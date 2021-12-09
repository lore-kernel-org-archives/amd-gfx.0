Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359B1C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 22:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98E5B10E19D;
	Thu,  9 Dec 2021 22:29:30 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2068.outbound.protection.outlook.com [40.107.100.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0F6510E19D
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 22:29:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/BTopxTxLHy0bw5U2ofRyTzihgmHL5bzng0g/NBTAuUX6uPVeeECOprPGVxxaU+TqxzXvE/xfqRYdAH+Jgn2iYSC3psaKS8BqwV32MOAvQaqkZz0tTNGEoYeRTN8/9Ud+b8ycJfnez4M3I+SQOC86xWpTaC1vR6i5bthSSG9Jfn9uCLRYjwhjxapziVFjggU+/ZPTX7yU7snHp7HfX7V1fgaufPJSk315UIj7qm6Cc1UVkG58+pW0m7HBcwEU2Z0gxw24sRHTU8Q/Q5AMXCoCR2Rf1lrl24LdEt+HR7OOjGCT3buVs9JoIc/iMcmYWoyAHUu0kjBcy6OrPRjAEttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ymy3GSD+YtPq1lhBz0SOE7ZUTzbYbxotrh5XIh8s8QE=;
 b=ePCwawKxIt+UyGDrRKmBDaoOlefWqUup78GEazQdInYt6JVUt6O0fShEteNcGEUnQtAfAlx5U7pV6aVAgQI+4zmyKVVQvafnJiIbLjx862X77mZIFuJRRvqhhOIrDgmPrKVLpNnzJLQv9OrbYS6R5xInFsRU3TA6G3SDu+y1CxjUcLyMmH3wyyu41bCWC/fcoi/SYnhBkVstsZX1QV7Jfef6dy1V1br5rXpha3wBqTmq3nqOXnVtWgqItUiW4qLdC2caI82ZAz6eWpKTHhn5lIdrSjtzgH2aorCXmURpaduL/oabXDLIAdA5e7DGkaIcLQSLKIIGI1W4GfH9R8A4wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ymy3GSD+YtPq1lhBz0SOE7ZUTzbYbxotrh5XIh8s8QE=;
 b=B3WQC/kkqmqy7PoQR6lBmcaSIuZOCKH96zNuKObshHiir+sqtuWOOF44SFAA2XJ4U6eyyApx5gDainBsxspBJk4WcWpUBIJuV/BJUmL08DmXx6BaUEdjXqaQPr7pUaNjTY45hh48XUTpAM5G10PjJ9+Ni1Jdw9g9URCGtCLYJMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5081.namprd12.prod.outlook.com (2603:10b6:408:132::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 9 Dec
 2021 22:29:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%7]) with mapi id 15.20.4755.022; Thu, 9 Dec 2021
 22:29:27 +0000
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Reduce SG bo memory usage for mGPUs
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211209154715.20956-1-Philip.Yang@amd.com>
 <20211209154715.20956-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <d3e7f713-7f76-490f-acce-c6b6f05d23e4@amd.com>
Date: Thu, 9 Dec 2021 17:29:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211209154715.20956-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT3PR01CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Thu, 9 Dec 2021 22:29:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d2b04fb-1a08-4744-3fbb-08d9bb635bf4
X-MS-TrafficTypeDiagnostic: BN9PR12MB5081:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5081B8CF9EF2C7B509B037F992709@BN9PR12MB5081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8tRvgrwM4TNO7h3fdcEYA2OQa2YzCseuUj8cmPoYbmeSxbs9mnGQbtCi10Ygjv1pvZa616OBbQRQr05+7455WpBXQVVCQnLWZsZrY5nF+a+eiS//1IuNwbO6MkE3pKNPBTDjf8csStl+x+EQ19v0WYQ0W4CfvPlj6suHYSE5AYgybklXl0crGU8xCYOwmuHDwwHg1IEM15wwf6USmrOkatF4vBTLkiN8W/JripJNaQfr9TpPrEgAZ+NfxDx0dpAtVn72EHPeu7d6oz+VIPItkkRwcP/9Wtddyb01e0Y0gwfB22cX8hyMV6gW69L9bvJVgRsalC5yuH45a0lDJfWqme6A5t+gVmfGv5mOonnorg70TKbO3qFy8n3j8p4GI7SF7hoJKptbWvSuTszGqqsEROGfildE5tHWvbnsQq8/w7PyNKmf7fhkKFuH73D6qeaaUovHAlbodavwQZIFQ05A33pvcODHhZlUDEbMf1pmo3R4YVYGNdfj91G8aFB3UXeHf4QVJAZC1qlyrziq7QEJN17MrTHpl9vtGncXe9nbtxxsXnTXqB/tWuUA9acUDgsvqDAlpC9e8Lk/UYQIT31xSQCU5wka6lK3sJuW3RxBnCaG6AntEBDVHEhjewmfvBw6f/J4OsHorNjLjgENf0RO3RBJiS+tErUSGsnFezqpjkQ9lH3uAujVquDE2OiNqgSwGC5I0u7TFVJxZv+J0DRr0HJt0cvHudiHaM/BFVwdSiCO4A91IbNSwwEgyM7kYQb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(66946007)(508600001)(8936002)(2616005)(31696002)(5660300002)(44832011)(66556008)(66476007)(956004)(36756003)(16576012)(38100700002)(26005)(186003)(31686004)(8676002)(2906002)(6486002)(83380400001)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q05Zb1ViSk1ESTI5VDBWSVdLL1N6Ym5yS2pTMWpwVEw3YSs5cWdXbWx5YmhT?=
 =?utf-8?B?YkdWRlJIdzBjSU1vZ25OeXFQWFlWQVJqK1VjWDV3L29kNTVTVldKUU1HL2sr?=
 =?utf-8?B?SEg5RkJJb0xGRlVaWjUyTnZTMkp6d3FleldVU29HNmhqazYrcmo5NkhLYWJU?=
 =?utf-8?B?S003TFh5ajZUOXRuWEVqZ2JaQ2p6VXF0QnQxSXFHbGhIYkJoem1pdC9vd0VJ?=
 =?utf-8?B?TG5Ua2JwRTBNdm05Y1VMMkhOQkdYWmxBS3M0M0djeGdFY0hhTEI5aFg3aW5E?=
 =?utf-8?B?QkpnSk10cXpiRFF2RlFsdVJaeW1KVnJUbVBTa3p0Q0Y1NFQxcVdENEFiVklk?=
 =?utf-8?B?RWxKY3NiRVgyNkRqMnJ6SjJFRXBqUE55U3UrWGEybUF4cU5oRzZUeWwwT1Z6?=
 =?utf-8?B?QndUMmZtZlJLZS9TeVRSeTdObGtFcnNoSElaTy9DUVVibTk3ODV1bWxnc2JS?=
 =?utf-8?B?a2ZBbGN3YWRyeDJmUldsV0JBc2Z4UU1BWFpRVVlYUUhjMjFDalFxc2xJeUFl?=
 =?utf-8?B?dFdIcnc5bHZuSy9JcFQrQ2x5ZU4zdWlVR0VGVmdlaHdWQk94RGxhRElyTnlD?=
 =?utf-8?B?cTFBcVZOVk9mOHppc2NJeFpJQkhGVlpacnRLRzhvcnI2TUczdGEvSGFEL3lv?=
 =?utf-8?B?bmcrQTFSeWRIYWIwVitxVUdSSmV1TWRZQmdDMkltRCt3YVk1WTA5SW5QVHRs?=
 =?utf-8?B?ekt6ZFJFZFpWcTFtd1FzelBXekZuRXpqWStUWGRBemxOL0xabldrWWNEUllO?=
 =?utf-8?B?MWlwM05QVGd0U0hLT3cyZEVocmsveEFUQ3VORENqTE45ZzBDZDRqTmxqTkVH?=
 =?utf-8?B?ZWhGK20wWFFBSk5WbVBsUUYvOHJ5YWM3bzA4YnRyUm82SkxadEdUY1JlN013?=
 =?utf-8?B?UytKTmducTlTcVF3QzZ6d2hCb2lkak1nSFJSMG44SE1GM08zYU5mSHFJNlBS?=
 =?utf-8?B?QWhNWUN3bUVLd1lieWdlSUNQZGlFT2pBSzZWSitGK2tBOFVabERQR3kyMjZC?=
 =?utf-8?B?MW1aSFY0Y001MktTTjdXdThjNzU5VEplSXpSSmkrVTRId1hZeUprTTZKOE9X?=
 =?utf-8?B?YlUwb2RSQ2dzQXE0TWQrWDAzdnNoc3hPK3MwQnpiVDBJYzFZbEFobXlKblF3?=
 =?utf-8?B?SHF3cG0yaWJSZ0JYMFdwOHhLYjVZMkY3dUJwM1BrWGpDM2pCT1cvdEtoOXpn?=
 =?utf-8?B?RGl4TjYxcyt5eTJtbUhZYVBQcGNyM3FROUZPSzlUQkFMbmFOeW9tY1RzMXN1?=
 =?utf-8?B?ZGJaNm1xZEhUR1oxU01wdDdoVmdTUFR2WWlxb0o0OUNVK0p4UmhxaU15RkFx?=
 =?utf-8?B?M1ljZVNYUFRXTVBmUEh1YVFqZklqQ0xmL0ZYOVJpWmtpdjhLTkszZE93Uis5?=
 =?utf-8?B?SExOd05xaEtDcElxMEp1TDR4VlJ4dFFzUlBlVXJoQkpkOWIwVEJPeUtqVEx4?=
 =?utf-8?B?ZGRVeEd4QzB3QzNlMUJ2MXZPaFRUZWg2OEdpdFpibkhtV2RXbGJRU09jZ2tQ?=
 =?utf-8?B?Z2dnc0FmNVQ3OFdyTHlHdVpjRTgxZVF2OVp1Wm9WTGM3c0VsRkhCcU5yK1Qv?=
 =?utf-8?B?U2RrbDVndHJMNTJOQkcvV3lDTjlSbVhneGVKWldUM1BDeWlGZWFoRG1WRFJZ?=
 =?utf-8?B?VVZ3VG1LVmhtUGF5WjRGWWF5Yks2OVVqTzlXdnRNZ3dubFZyazBDZi92ODNq?=
 =?utf-8?B?cStsRzQ4QytDUytGVHFvcWExZHRVNDJwbGozSWZqem95WEJxSCtkZjc4TUti?=
 =?utf-8?B?NUxUbzJCTjF5aDU0N2tFdzFmRyt4T01xUzVzYjQxRmpBQXp2MlcxcHJBY1Vr?=
 =?utf-8?B?UHFtSnllUXpjc2Z1Q3ljTXd0YXUza21JdHhyYm0yS1czV2tjMGlTWWQzZEVs?=
 =?utf-8?B?SFNtRkkzOGVxUk53V2thUlhFL2xyMmVNTS9UNlA1bitQdmNNUDA5YVpsNnVT?=
 =?utf-8?B?d1Q2eTlSd3lQTTF6VVQySWI1NUZtMFNHc2pTTGJnTVBubW9Dbm9KRllIN052?=
 =?utf-8?B?bWNXZnJ2bnNZY3RUV2ZGTkNDTE8wQmxjdE9WMUV1NGxZY2NDK2FtcnVIKzZX?=
 =?utf-8?B?bk9uS1RGRFZDejM3ZE1peTEwTS9CNDIwZWxlSXlUTHJlOHhsS2VjZHJmVjl4?=
 =?utf-8?B?SEp5OWVjRmp1MVpzSWNaS0JXYnBLems5aTNvZnA2L213TWZxRzlJTXA0bU1M?=
 =?utf-8?Q?dqKPT2MB4f/QNSpMoadF8n0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2b04fb-1a08-4744-3fbb-08d9bb635bf4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 22:29:27.0696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0OsPTaPCmLw49vM0OVLIrt2OHU0BokbKiH0/xTvMsnlahg99Y/ipaXFd8+5WQ8IEOqqZy/3pZ5+0Mz1SwyJvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5081
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

Am 2021-12-09 um 10:47 a.m. schrieb Philip Yang:
> For userptr bo, if adev is not in IOMMU isolation mode, RAM direct map
> to GPU, multiple GPUs use same system memory dma mapping address, they
> can share the original mem->bo in attachment to reduce dma address array
> memory usage.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index b8490789eef4..f9bab963a948 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -708,10 +708,12 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>  		pr_debug("\t add VA 0x%llx - 0x%llx to vm %p\n", va,
>  			 va + bo_size, vm);
>  
> -		if (adev == bo_adev || (mem->domain == AMDGPU_GEM_DOMAIN_VRAM &&
> -					amdgpu_xgmi_same_hive(adev, bo_adev))) {
> -			/* Mappings on the local GPU and VRAM mappings in the
> -			 * local hive share the original BO
> +		if (adev == bo_adev ||
> +		   (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && adev->ram_is_direct_mapped) ||
> +		   (mem->domain == AMDGPU_GEM_DOMAIN_VRAM && amdgpu_xgmi_same_hive(adev, bo_adev))) {
> +			/* Mappings on the local GPU, or VRAM mappings in the
> +			 * local hive, or userptr mapping IOMMU direct map mode
> +			 * share the original BO
>  			 */
>  			attachment[i]->type = KFD_MEM_ATT_SHARED;
>  			bo[i] = mem->bo;
