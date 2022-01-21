Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D13C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 09:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A09B10E9BE;
	Fri, 21 Jan 2022 09:49:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E194910E9BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 09:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqhPqYwxQmUph5RDRH52bff/vmRV18XhTKCdYLMwkMcjhV8c/cRdvK4DhgQ/R6eYmz5+E2yL664gR/ambeTRIHC8H+ob3KJRk5TTZA7RbzV/MBv41be0WCCvxTiHdrWZTvGyWklcEBFqp4APfv3SgJA7lIrMe4kZ+gbxHh02vyM/gblX4SWGjZE9MB3IYq8GrZ8KWOue8mcT6m9mjORs4AJI1DVyUtIwAQdPxGaQ0E49bBtgzFtYoIJx2rPIZu0/yNfJ7UPDMoHAFxpZitQsc7792cEFZrfllRpfgqo2TFAA3W7lBHm6nmxkXimF71AsiVLDQywV9I+9UULiIB7rJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su4ej2go6yqEfYEX+TUVCbthhLeNWN+Uw6gFxb0HXEg=;
 b=PYSfZvu/6FcfbuVgWO/+61/42dBnUwz847BDyLJZlrbpJkUp0tL1BKNo+w1ZBnho2VpHJ/FZXu77gcJvF1DNGEcNQusJByp2vWMTarU/9WsaOXZpcEg7dPdLtsmwP96U8SVLYeAMssWePTbNX8MuwRq+gYh6bJqJQEKboZ7xrGgIt+zIf7K+ULiYrG5ndayABsRCke4jBMAxycfJVp/QNkhfwXBIBSePXuSAYPlasy8UwweOl8NnaeiZrYnie0R4EEhw48rCD3ixkBoHCs4vQgHDfk0nWbIeBzAaRTqfm6/lbhriFCigGKGDNrszwavVl6lmLQJpRMi27NAobS56vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su4ej2go6yqEfYEX+TUVCbthhLeNWN+Uw6gFxb0HXEg=;
 b=B1wit+3J8mqkfXYOomKG5M63zBZmBX2yWVF9xQ9vX96apoLIoovoMfBHCo/TwlM3h1x/5Z6wdxdvFXqkqNxa7MORSYlVif0qCy/fLotMulrsFH7BYzgLhcaejVjzqlglNSsHHy2fzv8fX5+0yRO0zJ/pAfpEvCZEF3cCmVFEHdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN6PR12MB1923.namprd12.prod.outlook.com (2603:10b6:404:107::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 09:49:23 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21%5]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 09:49:23 +0000
Subject: Re: [PATCH] drm/amdgpu: drop WARN_ON in amdgpu_gart_bind/unbind
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, xinhui.pan@amd.com
References: <20220121084738.29487-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6d75f6fe-372a-3a1a-e0c9-1e69a0961f93@amd.com>
Date: Fri, 21 Jan 2022 10:49:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220121084738.29487-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM7PR04CA0006.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dc36671-7fed-4929-273e-08d9dcc34dfa
X-MS-TrafficTypeDiagnostic: BN6PR12MB1923:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1923E089CA92BDC7C4E02125835B9@BN6PR12MB1923.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XWAohRPZpSyxjZyGqOj/UDz+ZK09H+ne463xH/rMUs13PP6D36M2ow04ShyWt23rRTd/gciQ3OOYR9DCUi0RuJDsg+y4Z3WbQQJkyLJ+0FrwykJ+6nK7GykGkjY2+SuYJrYrCIfG5tBeve4vQruhnj/EvwtUYmVAAJfX5Rq+fZrK60DYGmI+XEZtq01iWSJKq06pZeAME4eFVqjusDqoLQ1G4MP2FgZ9tJ5fwqz/F7yS71ckHSqP8Oc7xw6IIiWOI4Hr7eEE5GJWmN5zE+Ev4WzoNzQLZKZe/ek2aSVRZYM+hd/lLqsI2gWuZ2kxatjTFbnqmYuG9Jr3zvT08fe+XXzMC9DA0+Dj48tGczP6EztpIrqzCmOMOAk/2QewXQBqIoINtNDINQBXI+dsmE6L2DLyg9HROFfCJoG74dCmTSZW1XnOUfGlfUkh1N8UtCvifRMTujOCuKcheCD4gkqw06bpaeMcnAXwl3eYoZb0W2jYMFRDQhJR6rtUFPf/DpiCNOsiyo+7bz9+ymLhrwQuAGqmclYkG3K1ofkm58aoIDVd0LfnQump+2XK5HQU0drEqLoV6qVxgu/q5afdFG0mlxDuBE6drj47WjQWJv10lFkt0N6u9bRgSVPwB0jV/7bMw1QZz/YmOF6TzjPUjackX72lhjz1e2oOVFqI4McwP6WHKBgCIclnzXIxHFx9zKKeHwJRgcB8KdUp/jBuX/J60o6ZmbeHlZZ/rOyROB956TZSd468oklUGIbs0h8i2vL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(8676002)(36756003)(6506007)(316002)(2616005)(6512007)(66476007)(66946007)(508600001)(66556008)(186003)(6666004)(8936002)(6486002)(83380400001)(86362001)(38100700002)(31696002)(6636002)(31686004)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2ZrQWtiVEVYb05UR01JSmQrUVRUZktWUUpvT2IvQjRmbjBHTnFkd3dRV0RE?=
 =?utf-8?B?UXRwVGlyWGFnM0E0Z1pnQS9yOXhvMW4zS3haWm9SWnkya2Z1dW9wbUhIbE03?=
 =?utf-8?B?bm1xd09acGZxTFBuTTRWcmZvT25NZlZVQkxKWE5wRWZDVGh6WWdLT2d4Y2JP?=
 =?utf-8?B?ckVtSkV2dlk3Vm03dGg0L0xmQlNST1E3K0RKeGZVcnNaaW5TS3oxdEZmS0s0?=
 =?utf-8?B?ZlRjdXNqVldLeVJTQW90MlpPb0JLRlJCei84SlRVWHYvdHdhV29QVzF2TDhw?=
 =?utf-8?B?YTBXT09pNFRkV3dtTGhlSHNIMytxYUIwN3N2MDlkTEFOeEhkTjd6TkI3Ritp?=
 =?utf-8?B?Y3psOHpmVEtBV2NaUmhmSzliam01WU51UjR1OVBXUndkSm1Ya3lZeGtHUXRW?=
 =?utf-8?B?WnpwVStiTEhkZlNHRFpGWEd1WXk2WEJwTlNXOUx5Q1dHM0twS2gxeDRTalFC?=
 =?utf-8?B?RTRGL0pKVGJMZTErYVNHNG1pdGQ3QkJpSyt2TzRRZWllTVlib2Q4dmwwS3VK?=
 =?utf-8?B?bUhNN25uL05FMXVDdTErZjljR2tlenc2cUQ2OXhZUDZ2K0dZcjdzM3grL3d0?=
 =?utf-8?B?d3BtcXVyK3g3U2ZYM29oR25UL0RQK0xqME01OFVrRWc1OHI1anFscDNtWXQ1?=
 =?utf-8?B?WTgvTWlTZ2RjejdEeFVBeHFQN1lrTkVhMVVmdHptMXRzblZiY0t3Tmh2a0ZP?=
 =?utf-8?B?YmJmS1FlUnpvSCtiVDNqdHB5VXlFa042NDJjK1dubVZ2bUx6cThWYWZ1K1gy?=
 =?utf-8?B?K3NjVFJJUzl2aVZKZzdxSFl4ZTF5VnFuMUhUelJQN1JOOEdmVjNVNndyTUxR?=
 =?utf-8?B?cWNyNmNPUUQyOHVIUWhMYmVCeTlBcU1wdHpTSDhwdlZ2VmF1R2pVM1d0LzhN?=
 =?utf-8?B?WUd1OXY0QSsxMHZTMFFsSXFXRWVtNjJUbXRGb3puU3dHMldRVXlUdUM0YkxU?=
 =?utf-8?B?Sm1OMmU3bEpyUUZXdkF1Wll5VDlrWWEwOEl5ZnlTdWEvd3lyM2I4c1pHM0E2?=
 =?utf-8?B?NG5KdWl1Umx5ck51dWV3eU5FZUFKWHgwS1dHTk02MWZmMHpzQVdhcHM1SzU2?=
 =?utf-8?B?QXl5TnNPY1Fpa29OY0NDeDZlbm1KTklmVWlsYXY4UHFKWmpjOXlIUllmTjBm?=
 =?utf-8?B?bkpCb3Bxd0hkTjZFMWQ5NG1KdlM4VEFhM1VtV3krQlp6UXpnaElEcVpiOTVu?=
 =?utf-8?B?VUVEMXZHZlErVGxEeklpY05hRG9tSWo5RXpTOW1aZE9Vek1RdjUyaGlLN2tj?=
 =?utf-8?B?K1R6YmJ1R1E1Y3JPanlWRkEwUWNaMkdvOUZIR3UzRkxodWl6YnRYbTRFRk1m?=
 =?utf-8?B?ZDcxR2hGSExTOVhDeHJoa09SL1kvRSs2VEVPemtMVEpNWStpWitlS1NXeEhw?=
 =?utf-8?B?YlVWM08rY0ZWeVgvUlY2d1llNUJjTG1kV0o4N2s2YmFpaE9FMmdJVXZDWWxy?=
 =?utf-8?B?TWhVcndzdnFRRitoTms0TkN2cWFyNlJRbnFZdWhsY0RDaVBrT3dNMy9aU1pr?=
 =?utf-8?B?QVM1WEtxT1RYRjFHTW9SZmFaek5XaVp6d01ydzBIa1Fhck5FaVBUWW5qeUtZ?=
 =?utf-8?B?OFF3M1VNbU5oczFibkJSMkk1TWFWbEtxRUZScW1yV2Z4OFc3cURhVk5NL1dW?=
 =?utf-8?B?ZjMxMTRZOVQrSDdPeFgvdEhZVnhFeGRlbTJYR1B1MDljTWVnNk40cDRVTnkv?=
 =?utf-8?B?S3FJN0hiSFB1UTZndFI1ZjVYMGxHM0tONzlmemdTVnd3YmpucGtqL2pIS3I2?=
 =?utf-8?B?QTdSWmRQTzRlNXFOT0ZtWmx4Nkd1L0xkQ1RTVHRrOWdBaHp5UHFMUTVHbFFT?=
 =?utf-8?B?anNYTDJ0RldMeklMQkRPbTNtZ05iNi9uNHN5VklNS2h0a0pPVTRMaEFoKzlI?=
 =?utf-8?B?bUwvcXU4VzByWVVadnVjK3BsTE5FcWhFNGJPY2thb0Z5a1l4WjJUc2Y2MWd3?=
 =?utf-8?B?Q3BzWGkwcVp6cmIxYVl1akcrN0ZoaDhCMnN1cUJIS2oyNHBjU3pJZ3JzUGZN?=
 =?utf-8?B?MTc1bDNWMHRoNklzM1c5V2tjRGNMN1orUUJzR2JJdGE1Z3dydzlPb2lQRC9H?=
 =?utf-8?B?NW5LSkpvUXExTzkxb3Zaalg4REMzbnpiSGNNL0h6K1kwbjZLcWhrdjIzSXJm?=
 =?utf-8?B?NUlCRFNwS2RsYjhCWlNUZW1ZV0s4ck1SaFFvL21IUU53cGdnRk9Vd3FTZU5q?=
 =?utf-8?Q?VhDGk2vkAuWdTKxYub72ydM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc36671-7fed-4929-273e-08d9dcc34dfa
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 09:49:23.6796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcuypkZfIXixMt9j+m+R9XdMgCrsAYQBiKDGlB6nLWkrc/t5AtOu32f1hinTt7h8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1923
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.01.22 um 09:47 schrieb Guchun Chen:
> NULL pointer check has guarded it already.
>
> calltrace:
> amdgpu_ttm_gart_bind+0x49/0xa0 [amdgpu]
> amdgpu_ttm_alloc_gart+0x13f/0x180 [amdgpu]
> amdgpu_bo_create_reserved+0x139/0x2c0 [amdgpu]
> ? amdgpu_ttm_debugfs_init+0x120/0x120 [amdgpu]
> amdgpu_bo_create_kernel+0x17/0x80 [amdgpu]
> amdgpu_ttm_init+0x542/0x5e0 [amdgpu]
>
> Fixes: f0239505d6c4("drm/amdgpu: remove gart.ready flag")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index 53cc844346f0..91d8207336c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -161,7 +161,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>   	uint64_t flags = 0;
>   	int idx;
>   
> -	if (WARN_ON(!adev->gart.ptr))
> +	if (!adev->gart.ptr)
>   		return;
>   
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -241,7 +241,7 @@ void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>   		     int pages, dma_addr_t *dma_addr,
>   		     uint64_t flags)
>   {
> -	if (WARN_ON(!adev->gart.ptr))
> +	if (!adev->gart.ptr)
>   		return;
>   
>   	amdgpu_gart_map(adev, offset, pages, dma_addr, flags, adev->gart.ptr);

