Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A63C25B75
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 10:22:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5F710E5F6;
	Mon, 13 May 2024 10:22:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Eyqg736G";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 082AC10E5F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 10:22:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggDV3Kbhip4mpFb+xZFTAayxrsdedQp8c/qdPnohaUIWTM0lYz79HzYeo6okpw3Mk43femxzfHx3rwYuNz0PB7jEJqgyQxP0Dq9/+YxJR/hPmZQ2heIYEAgRgVFJkrQ3rY2eE9Bh5/ExGlLA6JBQDh3yQLpJlcHp2ad2L+7foM3ATnhh2wEl7AycUyddm7Kz/6ciFy5Rsfv8pJf0ekGU4Har4F/rfAmpb3AUb5Du4VPF6q1VcRBTU1R9HWlHLbQ3W/lbJVQKSRV1rHR7EwKWqWQMiDiNpsjcc597Zf49qMSuqNaNH2tCr4zJkessxMDL8HWfkydvmrMiaSf3ANFacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/wgF0ePFvlmptn09TjpjdMq5RhHiQOUiiJTGle/U+w=;
 b=TsrO3Zd0sdGkmhQDfeiyfd3irsnjSjQOeF23IvMCsZV6QvB6Y585lGi/eMSTbfO9BBv5ZvwCVTk/Le0grTBxBYi52pvKIV34v6I87w0CVN504diHCz1NihxhedIuz8UFTArjMvBvKDelMO5xpF9PsB9yMXnHuUME2QR11kgmKABR/xsBVnIIl8CL33t53TqVHIDHMdd0+coUQDdVZREiaELHdH6jt4TAGh0riSw+ok43IEzhrTqOpXiLSQiI5Xsj+XLVXQn1VUltGnEmx+KSJD64z5/zPAN4PR/RR/Dgmo8KgIgBOnlj915pkKDbpP+rone1AROlpzNzcfmzlEJPHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/wgF0ePFvlmptn09TjpjdMq5RhHiQOUiiJTGle/U+w=;
 b=Eyqg736GubMfHr7undDdppkmqxfDVvUORmG/ZkMwhLAdfzooJxIemQuvOZ/jH7nFDDWN0Dn977PMx/PobXHtRHQ9RT7o3f0shH0/3FgdC9p8xaGP/rgII9NY3L0in6nc74Fh7GT6RSRLx938myvHYiVJ/W0qbWuPFn/VHeZ/oVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Mon, 13 May 2024 10:22:05 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 10:22:05 +0000
Message-ID: <a6066b03-a2d7-452f-8d72-1cb1b9387fac@amd.com>
Date: Mon, 13 May 2024 15:51:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/amdgpu: Fix the null pointer dereference to
 ras_manager
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com,
 christian.koenig@amd.com
References: <20240513085616.584249-1-Jun.Ma2@amd.com>
 <20240513085616.584249-2-Jun.Ma2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240513085616.584249-2-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: c68f6d29-dac4-419b-40c4-08dc7336899e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2s5RVcxWlBCcmdseEc1T1g0Yy9vMU1oUlFrNThFZE96Qi9mY2hkQ21id0Jo?=
 =?utf-8?B?ei8xY0lydlc1SkNuZVhQS2hIbjV4WlZFazhMRzdyZUF6b0VxdzhzbnhkRHZa?=
 =?utf-8?B?eE1mVjZhTU1aaEZtTVZKWDJLS3lkTTNpeGM3OVBZbDEwQnZmMm01dkVaZlJB?=
 =?utf-8?B?cVcyV3BWVmprOXl0dHE5SmcwWk1QRXNLSUhYeDFKL21qUUoxN2NrSnI1QnZN?=
 =?utf-8?B?OGJ4dGIxZHpSbXpRaHMxdVRHUElNV1NiTDI1R3VXOXp5NVdHRlhEUXJyMGFh?=
 =?utf-8?B?WU4rdUtNSm1oZXJtbnNGYkI3SkVicy8xNFhvVHp6Y09HRTlVUXRSK3d0ZDB4?=
 =?utf-8?B?ZWdsdHJLYmRxVVQvWEJpbE1SbjdPbDcra1FPaEo5VENubEJGa3k0Q0FmS2Z6?=
 =?utf-8?B?T08xTHZtVm5QMnR1b0J4RnhoMG5GUDlNWFR0bnF6RnhxdW94QmhiSC9ickwx?=
 =?utf-8?B?ekxVNEFPcnlPVVdLbm5FZXk4cU16Z2ZvNGVPaFR6Z2F2M2l2cG15K3RwMFdh?=
 =?utf-8?B?SUN6QnpuTjErMlBScS84clpBU1BSK2w4V29LRnJsT2g1cVIvY0xCOEdvdERK?=
 =?utf-8?B?MWFxWWxPTmhMSmpVdUJSWFIyaEs3K09DRWEzUXZsbmN5VVdNSTdiYUJRd1RO?=
 =?utf-8?B?cmpNNEpyWFk1VnJHRjdBT3lrWWhlekdDMG1oVjlmUEQ5MW55QUJCRWFFSGVS?=
 =?utf-8?B?UDhtVFhqdVNGTUFnRVhqeERUZko4TENPWjF4STJUeTBZdGRRK3JlSWczbXZC?=
 =?utf-8?B?YlNsaXhqMExPN3NzcHN6MlhNS2M5dENzSzE1Wi9DaHJ3L2VJczRrdjYzTnRi?=
 =?utf-8?B?VkhFc0pCOUVHblFmSGFDLzlqUVNpKzNJRVE1ZFYwa1F0U2t1b1YrQ1kxbVRE?=
 =?utf-8?B?YkNZRy9HMmM1Y3FsU1h3b0t0cTFab2dWYzhMQUROcEQ3dHBRbkE2MDdtUmxo?=
 =?utf-8?B?NlVtNHBVMFd0RXI4WnpONTVVOXdxaXVWRGdCcVNUSjBTR0EwZVp4a1ptLzBh?=
 =?utf-8?B?SFVQNGZuN1d5K2xUT252Uk5yQ3l1aWdCblpVTS8zNURXZStESVpJQ0h0eWIx?=
 =?utf-8?B?YXo2clMzQWJtSnpCNXVDeHZhUko3cDhlNXYyUTRXL05SMHF3N2JoeVhNTWY0?=
 =?utf-8?B?QUl5S3ZwTUdaMUtOd2JLVWNGQXNRU2VnRmp6M0VzNjdNUjJyNElMNk9aU04w?=
 =?utf-8?B?NmJONEJVcHpVQnE1eVZOdnlpRVVBTGFCT2dVZHEwZkJzQk4waWdOSFh0dXZ0?=
 =?utf-8?B?ZTNhaFV1aVRCVG9CWlRpSkgvT2Fadjk4SlFiMTdnTjU4UmRtUllwU1YzWXJo?=
 =?utf-8?B?VjFOMTk4Zmd1ZEdnQnh2V1BYU2hIbjlHUEJnODhiWkM0cjRDZ2tweTdhWkIx?=
 =?utf-8?B?SjBYQllGWm5HVzRndENlaGNKTUE2TC9Nd25rT2VvVnpNN205VmJpMkd3UnZG?=
 =?utf-8?B?S2w2dzhtZXhVcjYrV05meTZIZlZUcFNvNjVDOTNoaThsUVh1VDlvais2TlZS?=
 =?utf-8?B?am1Xb1BKN3ptOVlsdU5TRDEyV1FOamxUZXpJc2tkYTIyOWZyUTVNcnFxdnZm?=
 =?utf-8?B?TXU4ZlhUd29IbXhaYjRVY0sxQmxvUXZpZFpyNFppR2xiZXJIdDNmNlU5cnhP?=
 =?utf-8?B?eFF2RjU2WUpGckluaDZleEFlRjhPUW5DdHVhVjBzMjBidWswWWRQTVIzQ2p3?=
 =?utf-8?B?ZGhIM00xVWJiNXdacDh5ZlNGOVJnQS9tWU4zTXVjOGs0Y2ltMVMxcGR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUJkR3RITG85ek1ab295UUxzMFJmQitaTVAxQ1FDaUlNV283ejBrZEUvcE5i?=
 =?utf-8?B?ZEJOR3l3Zm4wcklTd3pEa1FPWHA4SHJFYWthaExoRnZpSGRqemRuTk9lVVAx?=
 =?utf-8?B?ekJDbis0ajFNNFNwQTZjaEZHNnZtWW0zMGxOZUFteDhnWHA5TmgwcGJRM1Bl?=
 =?utf-8?B?RUdVbkJXYndxNHNtbnRXdTB1bklKM3dha2UwZ2RaeUNSK1FOSjI2Qm5UaEoz?=
 =?utf-8?B?SUFjRHd1VUV6OHgrQnZqYitKTlI4eUFvY2ZNOFJiMnB3L3Brdnc3UGhzTE1n?=
 =?utf-8?B?VW40ZFgwcHNZWThDT1l3L1lia0R2UFRGWUg0NlpnbWRtcjB4WU5GdU5qUE9H?=
 =?utf-8?B?Rk1kcTBURWdIOU81a1pWQklsNEJXYVNabXIwemtTZXhmZ3M4SUJOSHRWOHRs?=
 =?utf-8?B?UEZDSXdIQ0FLbzJsbFgzeUh5TnpwN0Y3UG1MWXJ1bEY5NUVUNU1KVzRvY2xK?=
 =?utf-8?B?Sy9BajNxRlNKYWtsRW8wZTRTdEN3dWx5ZGVVOHJ5elRlNGs0cEJ5M2pKVDcz?=
 =?utf-8?B?V0dtaVFmQXJhQ3E2aGkvTjBoSW1VYTlDSHZrQlJPYVp1eVZIWVdnNWtja1BQ?=
 =?utf-8?B?SnVIUE5KK0xnWFh5Sm1aN1QzNzJnUG1hanFnRXcrLzNMMGlCdjdlSWtYakNN?=
 =?utf-8?B?Y0tnSElsOUJEbEFNdnp6bHBPcCtkSk82TGgyMUFGa3Y0WE1QUjdQUUZOZlpV?=
 =?utf-8?B?THZvRHZKeG1ZTXhrRkZQa0lGNXQ1eDNqN3BpbnduNjFGaXNlY3BhMWIyQjNN?=
 =?utf-8?B?bUc2aU1KSUljTWxCNS9Vb1hpaGhwUng0VmlYK2dLSEltMHdsU2ZWcFJZT3Fy?=
 =?utf-8?B?c1RHZC9HME9EVnFhOFpQc1ZWWjdZb2lNZ0ZvT0YwaXhkSks5dDJCM3J3MWhU?=
 =?utf-8?B?NTBkMndiQ3BPZzZJYnFvVlFSU1lDUDZrQUF6MkNlQzQ2MFhSeVp3RllFS2tH?=
 =?utf-8?B?VTVyWGpIUjBISVJqWWNXenplcGRmTXdlRStZYmN2bVNCZG1JSS9pMWdlN2JC?=
 =?utf-8?B?NUxoUXIvSmQzUFNjL2VZaS9zMStua3FmZFpHWXhFeXRlc2lLa3pzRHp1bHla?=
 =?utf-8?B?ZnJHMmRHSmFmMnNKR1NoZ3c1VnFLcWh3UktnRk5nY0Y2UGZKZzZNWWYxOFVL?=
 =?utf-8?B?OUlKMUdPRW5RSk4zYmRpSzhDWFM0VXFzMFE3S280OHdMRWJaaDArT0hEVEtG?=
 =?utf-8?B?dTdzQzFLc3FaSzJ5cldUQ2Qxa3pJYkErZGpGMmhYZ25jRE83Um1PWXJQTXZr?=
 =?utf-8?B?MW9vbG9kRCs3MUJMU3ZhSDJLdWVabUp2NUMzYlNyVTZLa2VYL2pneHVXbTgw?=
 =?utf-8?B?UC9yK1dpNVNZTmg1cVgzZ29WZi9mOExlNnFKbFBySXhwc2FpYUlNK2RTRzVQ?=
 =?utf-8?B?VGtoS2hlSUNRU1pIY2czMjZFWE9PU3E5YzJZV2p0d3d6TmIwSHgwWmx0YVpV?=
 =?utf-8?B?MW1mbEVhckY0TCtuVmRwRk14UzNaei9XL1owRXBSZVdjZ3ZqSFAzR3R3VGgr?=
 =?utf-8?B?V0hCRFJFdEhOOE02dmw4aEl3dWdERkE3QnF0RExRR3N0aXhYSW00QnRnOTV2?=
 =?utf-8?B?d2ZNR25XK0tNNHZxUG5ndDVzU2ZyOTNhbXoycmlLdHRlY29WVE8yZThrRjdE?=
 =?utf-8?B?S2RvUW8zWEZYOHcvUHY5ZjUrNFRGUjduTUhTOHBtLzUzZlc4OE14L1JOM1dm?=
 =?utf-8?B?dTBJdGtpS25zQ0poODF2aExiUmVMQUVCUU50elRpRzZEZm5XRVJzUVJEM01N?=
 =?utf-8?B?RnNCTHlkLzhHejlRYmdNRitjRHd4KzNrM0x5NGh1VUJQRUVKaThjY0VOSWND?=
 =?utf-8?B?OVVFSUp1YytVUnFJS2xIWFd4a0llOGwyMGxTNk1PNGQ4Lzd1Vml6Q2R5cXhI?=
 =?utf-8?B?Sm0rRFhUclRIY0RRQ3lXYkllMzlRQllFRW5ZcWZ1M0IrbjhDQll0am9qTTJn?=
 =?utf-8?B?NmtBZUpUM0x2T1pIUXhhNVpQZHpqR1dVWGY4ZWtOZlgzNEY0azhYVnNURlpx?=
 =?utf-8?B?YmZ3MGdVRm5uMFN4V0FhWGlITVdzeGdRMDYyU3lRZkM5cVBDKzhXdnNpNzNS?=
 =?utf-8?B?ZFordHBTN3ZJUDZxUEN6Ynl0c3hQK1p5TThrUldmTkg0dU5EOG8rOGw5U0Fi?=
 =?utf-8?Q?ghBels+2gH2WKvZ7seqv8E4kr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68f6d29-dac4-419b-40c4-08dc7336899e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 10:22:05.7926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCvKzd7A5euIwb/biBzb/6M/d91xi1EOOYJkYuHthQG3kiom2wdTJYLTzXdEwMcV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622
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



On 5/13/2024 2:26 PM, Ma Jun wrote:
> Check ras_manager before using it
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1dd13ed3b7b5..6da02a209890 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2172,12 +2172,17 @@ static void amdgpu_ras_interrupt_process_handler(struct work_struct *work)
>  int amdgpu_ras_interrupt_dispatch(struct amdgpu_device *adev,
>  		struct ras_dispatch_if *info)
>  {
> -	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
> -	struct ras_ih_data *data = &obj->ih_data;
> +	struct ras_manager *obj;
> +	struct ras_ih_data *data;
>  
> +	obj = amdgpu_ras_find_obj(adev, &info->head);
>  	if (!obj)
>  		return -EINVAL;
>  
> +	data = &obj->ih_data;
> +	if (!data)
> +		return -EINVAL;

This check is not needed. ih_data is declared as below in ras_manager.

struct ras_ih_data ih_data;

Thanks,
Lijo

> +
>  	if (data->inuse == 0)
>  		return 0;
>  
