Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA09AC3ABDD
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 07:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B15D10E172;
	Tue, 20 May 2025 07:35:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PGi2oPza";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5EB810E179
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 07:35:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAWlsTk3iquo6TbriOg+d64/dcwQjcjrd2tEPXFc53sj2LzcGjSeTsA+UVovBNnElN1w01EU8FB0A0rRzIT1z8va2e+eZ7kews/JmYA4qQF00I98LiqxWxOLpuk0YiCQEr2ttKBfTyA9OQbBEn11/pc9tOqOCm4dCwIqPlGL0HLc4Sl+L+0jpKPgQxS+onJSVjxuKyECyG2vNtPm+oN5mtOvvfZYgeD9Iz1AeM5n1wqAKE09Sz8lKqt3WOJDPQnv5dikqWRMlSO6Am5jN395Bowu8wuTO5x+EQ3B8+uYBRZrvUfl2wp2PjrrTrVAzKEKy6ymjT4QXsIvqk5h2XhdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=by//n0On7ot+LCYTbzyq/KanrZlfWK6oBShmhBLFglY=;
 b=qpSpi6gImRcFBwwihI+3zxMeJ+yYTWdFpHsm+qieowOdZp/RM6pAYx95pDNqx3QnRvVF4AjNGdCSTMZNP4mzuzxwvHv1Wo27gfjT7EA0g9ft2N0axIVtxCy0DmkpveSNAfjUF8hDnN2Q2t0UR3SIAgAM7mnXRnjz5AzslU+RkZwU0rloZFF7JzJTCrBsVyY+faqR1mLxzJ2rA61YOwLsBENmojrtdRIWiuwC5oPsXmjQNoKOfiJfe7rHf4F1i0QIjcXdL5KJpOR01ba7yURao0RBEwWYs3bDumIR9fTZkQAA4QIv2MVoLIdkJjVmNFQ0zt1B6fbJjOpHV13RazNq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=by//n0On7ot+LCYTbzyq/KanrZlfWK6oBShmhBLFglY=;
 b=PGi2oPzaK3nhx6RrqwFOccY7R1d/1ekSoLdbb33GEJgiQkC0WMACTE15mz1BXFKKBe8qeNe544gTtM6xMYZZfryp8d2d2e19SQa28ZuxSC1yaD060y2wjpYG+fzZx4nQWEf9plI1xjlbkvvDlVCpwr5qwk5qMzKCftyl1MxWC7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 07:34:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 20 May 2025
 07:34:54 +0000
Message-ID: <7263bff2-737d-47c2-8426-02a07177ef8f@amd.com>
Date: Tue, 20 May 2025 09:34:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/3] drm/amdgpu: Remove duplicated "context still alive"
 check
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20250519163713.11367-1-tvrtko.ursulin@igalia.com>
 <20250519163713.11367-3-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250519163713.11367-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: b118b7ac-6ae2-4d43-d48b-08dd9770d02c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anB6WnQxb1FzZER4YkM0NGs0MENJZUVjbjZFMUNlRkEzSTBzVFkwQWtwbisr?=
 =?utf-8?B?eE1ETEQ0ejVwM1k4U0VqaldsUWJ2WnNkRVlSRE05K0tka0JKRk5uZDhsQk1r?=
 =?utf-8?B?b3RUQm5vemdzR3FGK2duRkp1MTU5RWY2dDhWelk3UVQvRStscktPK2NkUzJ1?=
 =?utf-8?B?WFpibTY1eGRCb2tMWnFqMFVXV0VKRW5wS3J2U2lIQ2ZkZ2tkNFl0STFBb0t5?=
 =?utf-8?B?MWc4eVprTTZCNCtLejltN1pUbEdKbHpRZ1dBc2YwWXg2c2JSYWQrZWFFRzdL?=
 =?utf-8?B?aXd5N2dxZzk0MEdEeGhMYlhwYldHRmZTWnBVQ2hVY3R5VXhRSHVUV1FnMkxt?=
 =?utf-8?B?SjRMRXBTWG9vUkxtd1AzWVNUelV0U0ZlWldFWDh4dVNnVGM3cll5THFxaGJV?=
 =?utf-8?B?MGk1QUwxWXUrSTU5L3cyckVoWXRZS25JYitPZkRNbVYwZHZLc0NtclZMU3hp?=
 =?utf-8?B?KzRVWVk4MFlta3RRR0tNSXp2ekRkUDZTMUhWVXJKQ0tROS93NytiYmdVWUV2?=
 =?utf-8?B?d2pLVFNlYTVVYnQrTWcwR3VqU3h4TmllZzVjenB6QjFWUTVCbVJRb08ySGhX?=
 =?utf-8?B?N0NmZ2toUVAwSGEzemM3WStuNGVlRzRSRGdaUVFwS0J1MExlK3hoTGJzSTRo?=
 =?utf-8?B?ZDloZHM3enpmNFhhNzB1WDlWZWh6MjhVbyszSjhPazRGYzhISkZvbTV1Wmh0?=
 =?utf-8?B?MGZ3bzMxalNlU0d3NWR0a2NGWWlVbXRRV1B4TmFVelhxa2ZmcEVlZTBqa2hn?=
 =?utf-8?B?YzRHYUxoRlNkeXo1TEtVYzZ4YXR4bmVXQXlLbC9zeVZkMEVlbkQvbDBFdE9C?=
 =?utf-8?B?VjdUdWFhbEppZW53Z09pV25nRXIwbjRCSS9aL0w0OXlYT1FqMlduaitERStu?=
 =?utf-8?B?K1hwOVJVZ1hVeWZRSk51TmMrM2Y1T3RodEpBUVFrbnZzNyswSTFaTTI5OHk1?=
 =?utf-8?B?YmxlWWo4U1ZVYlFqOG1ZOC9nOGpDZENreXdUTVBCclZxTG0wek9vUzEyVkt1?=
 =?utf-8?B?WlBMbVEwTTgwU2ZheWhPUlBLVHZLMHAxcWRFb0NKaXFBTDkxSXBYS3V3Umcw?=
 =?utf-8?B?ZFNmUW81aXFqSkh5bXRFSjdibUNIRTJFSzJqUWJSYlZIcUFhMmxvU0hXazMr?=
 =?utf-8?B?aWUvRXlGZW91dFJiWkZJaFlPT0dnSVlPQjJOejVGOGFNRUs1Smtvc21kQzQx?=
 =?utf-8?B?M21jUTFtSDk0SnBXQXJvR09ZWnBKMFV4YnN5Und4dGV4MGJudDliV3BLNWNX?=
 =?utf-8?B?Lys1ZmpwbEc4MXRZR3NOejhyRk5OTlpqM0loMjVvNmFyN2xZSS91dUswSngv?=
 =?utf-8?B?Tk9UYXczTU10aTd3VDdYZW5pQ21Nei9qT3hCK25nUEl0ZXpXVU5zdnpSSzBG?=
 =?utf-8?B?d1h2N3hCWk5iSG9UeU1NT3BUSmRoZTNxYU5pYTFLOFVtc3ZYKzRMTU5xNXZT?=
 =?utf-8?B?U1VvNU1vOU8yN0ZJMUozK040clhKdHBPUkpKY0JrK2c1WVp6R09KZmVnWTJ3?=
 =?utf-8?B?QmJ4QUxrOEZvRUxRbGtQQkM4dzAzLzVLbjJWeFN0by94amNjbDhUQlJTVU5a?=
 =?utf-8?B?UndUT29lOW5td3BTdEtaOEJ0VGdxbXlwYUIwOWRtb2pOdUVodk4ydzFvMEV4?=
 =?utf-8?B?TzlhMkpaOW1nZGN1TytUK3NXWUVWYU9VTlRjTE5WNkZZa2JKOTI3QXQ3K3Rh?=
 =?utf-8?B?ZjVoczJmc0JOTlh2a1liWjdsU2ova0h4L0JydCtZYVB4aWJYVURNS3NGVVcv?=
 =?utf-8?B?c2NMUElxNmhxdWY4RFZ2bWdXSG43RlF3dXdyRVkvV1lLVUdmS2ViR1REWHZD?=
 =?utf-8?B?MzF4Y2hCWHVTV2s1RnF2TlpWSWxXMkMvUWF4eDRmeEtOZGZXWWtCaCtOeUox?=
 =?utf-8?B?UTFBQnhlbDFPU29QWitDM253eUpwZjRDY1dUdmwyV0VGM29La0hweFl4UnM5?=
 =?utf-8?Q?y4yd29NyuQ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGdEdW5MTFBNd3lYVDhLMVpoMEVzdGF3ejArRGUrYzYvSzF5MkYrUUg0M1Rx?=
 =?utf-8?B?NExiY0VtYTViZmFWQVZpM1EyYWlUU1hIMUlUdUxtQ2VEL0JPN0JIN1pSNStv?=
 =?utf-8?B?bmJzT0ZQbGRISWFxMTVZbHZlZ3BvRFZVa0JhYjV1cTZtbWFQNXJxK2JZVmYz?=
 =?utf-8?B?Nk9SZWRCM2dmbkpuMkRLdFhiaFo4dG13M0kybTBRWEVzb2x5VW0vbnhpb3Ji?=
 =?utf-8?B?TnpTbWhJTi85M1pCbmFGYVBTVnBkWGg2RmdLQzhNV1ZUaHJJeWFOYU90M05r?=
 =?utf-8?B?M29CaW5wdlZpZW1Td1VSSWpMTC8yakpOcFE3YlFTRXZvSjhHZGV0WjFMa0F2?=
 =?utf-8?B?T0NIMTFRS2FxZ25ycW5Ec0VXZ25HWFJJdUpmRE54MXlLSmhEb2ZMTGJyMU50?=
 =?utf-8?B?ZGpJckgzdkFqNFZqY1A4UEtHR2VvVjZhTE96Szl1RC96NDk4MmcyWVR1ajZF?=
 =?utf-8?B?TkdYUHo5eHpLOWhkQlQ0VnlwVEtLYlplUytrVEpnM0tsaS80UDl1T0dONGR2?=
 =?utf-8?B?dFBFandMbkZqakRTUVBGRDM3OWc2MHVnL2hWRUNOR0hxZDRXZVZEajVyVlBa?=
 =?utf-8?B?QWRuTEoxUFhndUxDWVlLaDlERG9iWjNmQzNYYS8vSUNPNHdRYzV1RVB3MUFk?=
 =?utf-8?B?ckd6bGwxVW42eFN4Y1psKzd1K3g2a0lzSG9mUWh6RDFPYk5tc2VnZFMxcXhX?=
 =?utf-8?B?TVh5RTA5YTBTdTcrcE41OXFUbGY4ODNHazBJOEtKUCthU3V0dC9LSk9ITjUv?=
 =?utf-8?B?YzZMSVFuYitocDZFSjRHRGIxTVNPdSs3N3l3UFBGbEhIL2FUZkNiSk1jeDg2?=
 =?utf-8?B?dGp2OG5ISWJ0T0h4SGc5VnlWeVVrQXZ1azZlcjZicHVKbHpRVDZ2YzhkUHd3?=
 =?utf-8?B?SEJJenBYb3YrakZQREZiczdPOFcwU2QwNnFUQktoZWU5Y1Izc1FNS2FUUVc5?=
 =?utf-8?B?bGRGdjRnMGVUcitTMGl0dU9EWjlZUXdYVzluYm9WUzlFbDFPdk9SY3JPQ2Ft?=
 =?utf-8?B?Q2hWNUpQWnZoY2hZQUF3QndQS1RTWk1hNDMxdlZZSTBiZTVzWkpHb3lRVFl6?=
 =?utf-8?B?R2tqU282QjR5SHNYZjRpS0M5MGptcUplR1NyQnpORVZVSlhGVlloczd6dFF4?=
 =?utf-8?B?aUFvWjNvRTEwQmV2Q3FrYjVTSmpMWmtScjQzYU4wUHBsVXF1NzIyaEhXOVVm?=
 =?utf-8?B?NldJNGJVWUc4VmttNFVUZU1ZbEpUQnRWVDh6SGJ0QU1QeXBieEd6aFpsRFFi?=
 =?utf-8?B?WDJ2dUFidCs0RVFwUzc2WUZPZXpFN05zRm9PZSt1NnAyT2R2OFYwVitUUS9L?=
 =?utf-8?B?aEM5bm1SK0ovQ2ljUWRJV0tFZFROeG5xU1ZFTUZpeG9LR3h3ellvQmRQWUFs?=
 =?utf-8?B?TjBhcGdTMUlmRVlMd0RqTEVMNys4dTNRMHdHNzN3SjRJWUZyL0pYaXBRU0hC?=
 =?utf-8?B?T3hUYndialRENjZ3L3BsbFpXNC9EVFZZNVM2SThIOTNOa3lZcFZBV3J1eHZq?=
 =?utf-8?B?bVlWWndOUWp2cDVUaGJqUnZnNlJEdWVVNmNVSTUxUndBTFg1eDI4V1ZuYmIz?=
 =?utf-8?B?WnhOVXZuMzZpZHZrYWEvdkhkalE3VE1kSTRNcnlnTlh4bXdWcmt0VklWbUlj?=
 =?utf-8?B?ZDFFTVQ0OWUxWTU5dGVFYmtZejdqQVErdVV4N0d3OHZyQkJWRmRteURuU0RD?=
 =?utf-8?B?WnhXV0FneTkwTmlRaklMd2d3djk3Vm55RWdRcFRxZTUyKzUxenJqektqdXM1?=
 =?utf-8?B?UHgxelEvZCthYTBOMTgwQUhlQ2U1ZjUrdlNFQlJGM2g3enpHTHYvd0FVdGRC?=
 =?utf-8?B?VFd5djFPbFkyRE5WQW8vMDVtaTE5ZDB1eUNSYmJtUTJkSmh6aGhCVWRmSlUv?=
 =?utf-8?B?OWxtSEdIT1U0M1doNVBzcmVvc0tEL0tIWHp4WjZLR0lOSU1WbTk2cFJzdkVj?=
 =?utf-8?B?K292elhreEQ4RUVxVnpVSWprNSs1dVY1Yk41azRuZVdnclo3Z1AwbHRjT1hl?=
 =?utf-8?B?QkltTVV5OUY0MllIU29ZSnRkZFRJQjUrRi81U2l4UEk2Z0k2di9ZdXRkMmdl?=
 =?utf-8?B?OVBEQlE1bVY1aGtBT05QODltdDBEbFZ3SjJKc2RLSERiMHl6bGNrV0NhLzFh?=
 =?utf-8?Q?LjPg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b118b7ac-6ae2-4d43-d48b-08dd9770d02c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 07:34:54.3752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ir+vhSghUJOpU4vsLMIhni8QoH13hhPiCkwsD/YbGC51xnNiWxD1Mqj3wWf0zwGR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
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

On 5/19/25 18:37, Tvrtko Ursulin wrote:
> When amdgpu_ctx_mgr_fini() calls amdgpu_ctx_mgr_entity_fini() it contains
> the exact same "context still alive" check as it will do next. Remove the
> duplicated copy.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>

I think we could also completely remove this check from both places.

IIRC it was only added because somebody suggested that CTX could potentially outlive the file descriptor.

We fortunately abandoned that idea even before amdgpu went upstream.

Either way this here is clearly superfluous, so feel free to add Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 4ff8552e872d..85567d0d9545 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -949,19 +949,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>  
>  void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>  {
> -	struct amdgpu_ctx *ctx;
> -	struct idr *idp;
> -	uint32_t id;
> -
>  	amdgpu_ctx_mgr_entity_fini(mgr);
> -
> -	idp = &mgr->ctx_handles;
> -
> -	idr_for_each_entry(idp, ctx, id) {
> -		if (kref_put(&ctx->refcount, amdgpu_ctx_fini) != 1)
> -			DRM_ERROR("ctx %p is still alive\n", ctx);
> -	}
> -
>  	idr_destroy(&mgr->ctx_handles);
>  	mutex_destroy(&mgr->lock);
>  }

