Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D91C3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 22:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C843810E29F;
	Wed, 14 Aug 2024 22:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PCNQVPuJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A2210E29F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 22:12:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuhD3g2b2Sqh6Iwasj8jZD1Z9F7sYQ9uzbOZo5P4+u5vgtBqsU3732aK3mUAkFlM2ItdVF7OQ4mFVdBwpOJWl8DyeFErdGCCChqPJyhK9jqCu7TTH4k3NNjleoG8aXDys1XUcbF0zwt5yB/9qhuN9XyFCWFLDToUqJcsG7WRp9cnnxcM7d1keenY9PMMFz4Fgs2UyAcWOsp/j0NVa6lRlaLvsZKoyGAPGrxth7fQcF8uhw50bxmnll+3bBhvdRStBiLlo1h5/ALTRJay/Slogz5ke9tCT+jMOw2UwR3f1RKYzQC4GnQfkwBFmdXOIU4mQlI1mRUHAmnU4j5xfxQKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTb/b2kMjq6JxRXJEn1dgZhHPXMMT/EhVEjSgl6pMp0=;
 b=YoYTS33xJGNbLo/YlzMi5Wqek8jMk6Rw7wfyZb/fT433pdsVbNw9Aflv53rzFptfXBQapL4nIfQ3C/oHJhZqtsBXudlQDL8hVvjHICZUvdn1JIlhShKQVpBL9ci5Jg3csVIInBrDb88grCmTHmbb37iTHon+GxAd4dOI8BFAg1Fwx6Zt41hwQ8hwJHsUlNCV68zoeNIX15aAapVlQz1XpkN6/bCYAjGHWCgTbpKuTHUEDOsgOOy5WKKx3FIlFv0rzPDGES9s1x11N4s87RWrx0LitSKybi/cYRg3DBdA4539PcoLxW2wooZZzP5/I5By9Wvc837H1qWv1Cu21KJgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTb/b2kMjq6JxRXJEn1dgZhHPXMMT/EhVEjSgl6pMp0=;
 b=PCNQVPuJx3pbgbPfhGEWOFG7lGHCGUMofUZlSDs7nRbg3+Ru0F5GWPlO2n+dqW8cSxLCCKzUCOF0aPag8oCuXituVQ4IHidu8/qIl7UsFUT8/RTj9nhjgsm+pdHFeIE+zXd2paSut785cexrXlzKbDlY0d9MSfRnCVJKfeQsjWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 22:12:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7849.023; Wed, 14 Aug 2024
 22:12:20 +0000
Message-ID: <31cca73e-5cba-4664-9ec6-fc81f8547c22@amd.com>
Date: Wed, 14 Aug 2024 18:12:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix incomplete access issue in
 amdgpu_ttm_access_memory_sdma()
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240812065929.1842802-1-guoqing.zhang@amd.com>
 <20240812065929.1842802-2-guoqing.zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240812065929.1842802-2-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0205.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c47e729-23e1-402e-747e-08dcbcae2a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0F2blNwVFFrdDNlcDlrVHlNMXF2cTZucFVyajhQTFRmakd5VE9URnJ2SGIy?=
 =?utf-8?B?SGJCRzhwbXA5ZEFpVTZrNWluY1VtSFBOWWlWNUhlOEQ1RUJPc3pyNnpiZVJP?=
 =?utf-8?B?QWsxZHFxY0JMVTBIMlNVaWFYYXYzQXNuMzJqNENydWt4WGVyU1pKSVlibkJS?=
 =?utf-8?B?M05janJJYWF5bUluNHg2TGdKNHp6enFOalBRYkpvU1AxZDNXR3pwMkdvdDN1?=
 =?utf-8?B?Q3ZiNmQyUXNWa21RdFA5VlVtUUE3M01kT3hmQ3h2WTV1TEJTa3RNVGU3YzVG?=
 =?utf-8?B?aVNOclFuY3ZsN3J2VzNjeDJRTWVTaHgrWHFCZEJMTms4bTdlY0lHMEVRanBn?=
 =?utf-8?B?dWZoeHhWMERLK0dBeU5YS1AwTGZoNmJjOFdsZ2s2anlicThrcHFvMjhYZ3p0?=
 =?utf-8?B?UzJQTGt3QzBJQXlNRlVCbTZ6M2RYM0s2OThvTGRXNkx0Zk9aTC8wU2RydGdj?=
 =?utf-8?B?M2lQSGVJdjBlT010ZmVlR1BMYlVmRWpocFA3ZUhENm9FUVdhTkhvUHd0RDhN?=
 =?utf-8?B?c3ArV3hITXJuLzVob0J3MWtaU0o2VGphODJQeVJ3UlVPT1pSOURieEcxQ1Nx?=
 =?utf-8?B?WGw1WDRqeGhkRUxiTWV2ZHJjSSthUDY5dHhKWUhGbmllK1lNOG04RGxWeXRr?=
 =?utf-8?B?YzY1emNQQ29sSVFSYy96TnFLQURWbzRMbloxamY5cVFJNWhSSDh4L1BFZjQz?=
 =?utf-8?B?SGVyTUkyUWZKYURyWkZGZ2ZDSHlpNTluYmVrV1BsakJxT3RWUW1iWG03YkYy?=
 =?utf-8?B?TStYZXpuTXpMMkxQSy95Q2VrU0dYanBBOTFHb21rcjNzWnJMWUJxVk4ySGZy?=
 =?utf-8?B?anpBVDdreE9IUmZKUFZBV1lHUjJTdytsdTFqQ3R6bDFROU5aTHdFK1JXaThm?=
 =?utf-8?B?czhJVnpmMHFhbmlpaWRIb1ZnNzM2azl2eFA1WFdvVzQ3SjB2UllEbkpVd0JW?=
 =?utf-8?B?QzczajF1a3pjRDk5YkRBckE4ellyNjlPaDhFajFrQ0sxYkVvTFFJdjJORzRK?=
 =?utf-8?B?TDdYTXhWS0VTaENxS1N4SW0zQ0hLR1QvdEFoUzhNY0VSVnlIdGhvVHlIR01u?=
 =?utf-8?B?cmFJekhsVzkzV1MxQnRwM1RDWVF2dUdPTVNxVFlCQXZGZGJGWkE4WDVKNFE4?=
 =?utf-8?B?cVNGSW1qcEtxL3hrUlUvdmhpRjgySEdtQitDbHY3RnM4M29hUzJoeEJOS3py?=
 =?utf-8?B?WXJRTGZxL3YxQ1U1L1NTYjJqRWorT1hQNUJPSlhSdmd5azAyTFMrdkJDcmNp?=
 =?utf-8?B?ZUluN3N6TUJrRmViamh1UUVYUmw3eEdkY0luMzlzTkJDYTdpd0xCcE1iMG9t?=
 =?utf-8?B?b3JaRWJvdmNUdVNUR3dXTm5QS2V5cHp0eXdueEJLbkUvTSswRHlUaXlqR1VI?=
 =?utf-8?B?VG9CcFpBRlhaV3ZhbEkxUUM1a0xlSitFa3VheGNPTkMrNjVvWEcxREhjajk4?=
 =?utf-8?B?QlM4WEdZdlVyTUdnaHBYekxWQmRESkE5UG5FNE5WV1lQUUhQWVFyWEZUMUZF?=
 =?utf-8?B?SzZ2NndTV01mRUZqcmowMTg1N3Fwc1hpRitGSHpMdi9NL0thWEVKanJDRHQ1?=
 =?utf-8?B?bFVGdVlpck9ZckcxRmUzSkZiNkdXNWVXemF0S3VLdUZ0M3Bad2N2TFNxMUhm?=
 =?utf-8?B?azR0S2FtVnZTa1lKSXlXNzRLekVvV2J3SHhpL2gybjR5dm5MUXFJVDJkaW96?=
 =?utf-8?B?KzBkZUJyRmVIN0szeEtBMnhQdnJmZmwzbDlnYTZwSjBiOW92VFJad2oyR2tu?=
 =?utf-8?B?Mk0yVzU2b2ZndEZQRHBIMFlHa0lFSzhPMC9IREJPSkxIQ0NmenVDN1dPcnF1?=
 =?utf-8?B?akw2a2dOWmhXbXVqMmJyQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzdzNEcyMFdKcCtvM1hWYkI1UnFTSmQ4MSswbkpzTW5qbVRoNVJRWnVBSy9w?=
 =?utf-8?B?dkIxSVBvMXA4eHp2NmVMTGtIY3U5b2xwUVlQMERhSExsWjE3c0J1OWFRZ01U?=
 =?utf-8?B?anF6b1BBTXRqazdlUm5ZN1ljalYzdkpQZWp4UHlIWlBJRlVCb3ZZaHUvZWkx?=
 =?utf-8?B?SHhsbWlpQmRMNmJDekF4eGtwbDZQdm5CMVcvV1hiZ3NFcUN0clhXOVBqd3dh?=
 =?utf-8?B?ZUxBdHo3bHlhNFZuSFZpQmlsUkFVZGt0RzJnNjRZbGhLdVBlaGV1OGhHbUFL?=
 =?utf-8?B?TzlqZ1kzR3E2cnZGVS9MUTVJa21UWWRCNzdYTXJDQnV3cEIrZDJCN0s5TUpS?=
 =?utf-8?B?b2JFSUdDSnhkMXVxSlJQN3hnUjhLOEJENTZQdFIyVmVKa0JPa1dDRHV1M3dk?=
 =?utf-8?B?UFJ3NDN0dTFETDJkSEM1b0EvZ3owdzFkeE1aaWhBaENYOWhJSWxRSUI5WEM0?=
 =?utf-8?B?Q0NJRHBkT0NVSVdDUW51Zk5sTXUrTXg2YjFaUTVXZjYvZFUwSzhDdVkyKzBp?=
 =?utf-8?B?NHRQcG9Eak1CTWxMODdqMEVhMzYxU3B5dGhVbFdvZzVvbldpTnVzMmJuM2tX?=
 =?utf-8?B?ZFJrSGN6V0JJb3BkeHcrU3Q2UzU3ZkE4Z2NTenV3cWtFN2Z3WFBpWHZGSFJC?=
 =?utf-8?B?UmZvTFBsN3RGRndyLzh1ZkRMK2pKMFh6NjJ5dFV5NXdQL3grZkI0WFNOYkcy?=
 =?utf-8?B?V0FxaXZwdVJnQ29HVXJxdUtWbFhXS0ZPYWdVMFZyVUd1a0lmcGFNTzVQWXlp?=
 =?utf-8?B?amxpZHhid0twUW1zUFJhOFV0SWNxZWxVVnJnVlZiNDFPWVpQcGZPSTMxSjlR?=
 =?utf-8?B?a0JDeDM2WWlhU1FDNng2VXA1ejVvL1lONWZ4cTlyRVFUWWVPTlBpczlQdmlz?=
 =?utf-8?B?VzI4TmJtQVVtVjUyRVphbFJmVkRueVJqMVZnR3YrNmRUOFVjL2N0YnFnMW0x?=
 =?utf-8?B?WmtpSXpab1ZBSER4TCsyd3EwKzNaU1M5eS90MCtESFZyQzlFOU9pTXlUcjRL?=
 =?utf-8?B?VkJVN2UraVZrMVdtZDBPQVpNWk5NU3ZVc0JySHNiWEtYWWxVbUdwUmUrT29k?=
 =?utf-8?B?cGxjNTNzZmliakhGVmFacThkZHlzbDd5UVJHZXRmQjZmbDBjR3FGaW1FMjZj?=
 =?utf-8?B?V0F4c0V4ZmtRK2N4ck1sbmRYSWg2SnlZR0h0MTROMnBRcWZmU1lIcVpOZkN0?=
 =?utf-8?B?TmlWZkNjMmNmR1I1Y2lCaGIwS3RUU1BUVVdoVGJaRURRa0MwR1FyblpLSmFt?=
 =?utf-8?B?NGM3bHAvVXd1ZFJnNlB6Ujdpd3dyRm51NC9XYjVPNkhJNDlIY2tiZVpncm9k?=
 =?utf-8?B?c0trMzNzR0xudWRtbGtHMk5hbVB0c04vaHZoVm5IeHFsRUkzM1dVRXEzd0h6?=
 =?utf-8?B?WlhxT1RuNXVydnhDZ21nOG5EMXNvQm9uRjhLUGxkR2w4eWlFeUtxL3dkVTFq?=
 =?utf-8?B?SFhua05wREQ2NHBldXhaQ3l1NEtrN3pNS0o1eEFhdXJOYnV5ZWVIRzNzM0xD?=
 =?utf-8?B?U2RBck5Hd1k5R2ZxMjBzNzNEQmM5cUZaMkFVallQRUlCeWdzTXBGb2x0MXNC?=
 =?utf-8?B?d2M0NjB5SWcvQVVuMVV0aFo5U2Y5ZXFwMjJ2NWNlcTVMQVAvMldRcTRvYXZa?=
 =?utf-8?B?YUI2VFk4OHJxbG82Q3FjbSs1ZHlmNXdCcEoyeGc1bks4RUJNMzVUeHpIaGg4?=
 =?utf-8?B?KytIMTM0UVRLUnVpbjJ4dXN0RUFsUFBJZlllR2JnbVJ2M0YxWVh0WjRwb2Qz?=
 =?utf-8?B?bnNsdVFBUFE0NWp0UGhkQUdsVG9uTVJRSUpwaEJwZDIxN05HTFQwRnBuU2hq?=
 =?utf-8?B?dnBkZGNBRnFXWVNiUVFrTVhKQm9od0ZxMXM5UjkzZWJoZ2JUQTRYOW55SDFo?=
 =?utf-8?B?ZGtwM2hiV2pSM2pxMEZEdXp6cVFpSkZwaTN2N0pHQ2xOV3FYcy9GZ3RHZzJM?=
 =?utf-8?B?QzlGUHdMWHZwZk1rQVB6VnM0L2UrNEp1elBPWWRjNVZ1VlpVYVJlZG1QczZ3?=
 =?utf-8?B?ZUc5M090L2NRY1J0K3JTRGdPMDVPTXFCc1JpL1B1MFFLT3FvUmtyZjVvVkdC?=
 =?utf-8?B?K2tkZndXdEhMTkR5OTZxU1FER0JtZjIyZE9XTFF6aEVWWE1Wd0FuSnR4QTdU?=
 =?utf-8?Q?ikfhD89L1OJjl1qwqq9EDUTBf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c47e729-23e1-402e-747e-08dcbcae2a4b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 22:12:20.0858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oDNAcfWwZT0X+sb48SxNRvYPsLpvyIAPjsUe04jHC8HWLRdcInjc7fr9HVAn9L4DNW64z+H5e1DTC1WzFtDCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508
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


On 2024-08-12 02:59, Samuel Zhang wrote:
> The requested access range may be across 2 adjacent buddy blocks of a
> BO. In this case, it needs to issue 2 sdma copy commands to fully access
> the data range. But current implementation only issue 1 sdma copy
> command and result in incomplete access.
>
> The fix is to loop the res cursor when emitting copy commands so that
> multiple(2) copy commands got issued when necessary.
>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 26 ++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index a6e90eada367..c423574acd5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1484,7 +1484,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   	struct dma_fence *fence;
>   	uint64_t src_addr, dst_addr;
>   	unsigned int num_dw;
> -	int r, idx;
> +	int r, idx, count = 0;
>   
>   	if (len > PAGE_SIZE)
>   		return -EINVAL;
> @@ -1498,7 +1498,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   	if (write)
>   		memcpy(adev->mman.sdma_access_ptr, buf, len);
>   
> -	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
> +	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw * 2, 8);
>   	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
>   				     AMDGPU_FENCE_OWNER_UNDEFINED,
>   				     num_dw * 4, AMDGPU_IB_POOL_DELAYED,
> @@ -1507,15 +1507,19 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   		goto out;
>   
>   	amdgpu_res_first(abo->tbo.resource, offset, len, &src_mm);
> -	src_addr = amdgpu_ttm_domain_start(adev, bo->resource->mem_type) +
> -		src_mm.start;
> -	dst_addr = amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);
> -	if (write)
> -		swap(src_addr, dst_addr);
> -
> -	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr,
> -				len, 0);
> -
> +	while (src_mm.remaining) {
> +		src_addr = amdgpu_ttm_domain_start(adev, bo->resource->mem_type) +
> +			src_mm.start;
> +		dst_addr = amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo) + count;
> +		if (write)
> +			swap(src_addr, dst_addr);
> +
> +		amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr,
> +					src_mm.size, 0);
> +
> +		count += src_mm.size;

You could just increment dst_addr instead. And move the initialization 
of dst_addr outside the loop. Other than that, this patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> +		amdgpu_res_next(&src_mm, src_mm.size);
> +    }
>   	amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
>   	WARN_ON(job->ibs[0].length_dw > num_dw);
>   
