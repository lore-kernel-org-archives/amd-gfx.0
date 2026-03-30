Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3035FFF494F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 12:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C83110E218;
	Mon, 30 Mar 2026 12:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iYLmhOhD";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013020.outbound.protection.outlook.com
 [40.93.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C117D10E218
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 12:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlG6qlxBEJtLuuO7svGSFxQKzZAg6/Fm/oGgroeNSxV6ne9M0RhoOy6KkSscNCJ3bYXBn4TM5XxNGC5Xa+Oh5AP+mVsxido9VdLuRWRb70GOGvyOGzoZqBzuz1wsC35ABcRZOiuhW2Sk5bZQB7FWGp72ZGL3AFTjoqHwJGd3bEck7AtemBQNLj9tH92TgXiQTNTuhBULKDvPNoot0zax+z7208ih1rkO9mxA4AnzeO4N2BiNmetjOcGjl0Knhv33tOwc+I3Brx9ai+q8Hm5HXdW8p2fi8OXnYDdNnt2o+zt2iyHrJCvKvl9d4UVyg/gBD0EM6ZdnJ9DvLY4RDmLjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3Tacjd3Apa5yvIpFe6QOfjscc1oiOiQ5n97vIaSVrU=;
 b=t1eDSfmuRzpYRkzDHdN9s79gOmyU96cW58rUFG4nf+8Fjz0/E5X7nlI6xaSTkUDj5apot0I0x05bd3BDUML3gzyS4rfAqb+ZqGPCm4VR7tgompedusqF0SWhGOknmDn1FkwJrnfTvKM68usI8ZLDAOCi+yhJpXnXVcug08T9kL45Df3gbe9qW8V06EPnKz22Dw0I9dXI/EnGWFoCf+IhG988sWQGQIcgnzWZxjvgQ8Egg5t+i0bOvow+Tqz3V4Y/+gCQGW9pZIHpOgQzDqwstc9PbSrum8Du/+ODnk2NLzCaMwuSIizNperVv7NSImOwsCfFcm621FH2wP33QYlHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3Tacjd3Apa5yvIpFe6QOfjscc1oiOiQ5n97vIaSVrU=;
 b=iYLmhOhDABhPahDEu3Ce3NQkZ80EVo6b9KhmUibDX525uRjm0Ot1TmsSyOTj3N6ExyV2EPRz3twtiO7HW4OiJ6T972VmnbppcOKv9Xk2L9mm+RQy5zWGTXZAt0jYH6HJFM+4CoU0/824zdto8Fo57LcjRS/hLlQbXnfJ45tJjYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 12:43:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 12:43:50 +0000
Message-ID: <0e014851-1593-4df0-b139-90e735448d91@amd.com>
Date: Mon, 30 Mar 2026 14:43:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 2/3] drm/amdgpu/userq: add the return code too in error
 condition
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260326132353.2753833-1-sunil.khatri@amd.com>
 <20260326132353.2753833-3-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260326132353.2753833-3-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: fae19662-eaaa-447f-7048-08de8e59fe58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 3P5f0+Pa7CQ1VCVxG90K/j0lU+zHXTDg7+N5hSbieWSI34bsOjBSGyMAzJvcWVpS/FnTaX2a9t/djpbxi7qj1GfPlUYugBJxL9T0re0O+NtY1Jv/0CZF03qoKPV3i31m5Ts/tHZU9Ti0rsKhWdN1yPgeI0tIZq2Rc3oc69fsrXaxbQmxTY8ELBZDRV3CRklzP499vBCcYiiR793DcA+BKCAaPbB9qsHxszUzmTPJlRSys/fmOxG0uUuk4ScoF8xCwy5fbcMApFm1+0HrWqD1Teyr9L2j85NHyPk7qeWtlfx//LHBnxUJVAAcdQCkdyuZMn0g/09oMzzSxiD9IyrUqaVcGC0gWS07PBtMNHPGZ0PcISPGtVC+1QqJ/FEC9oJ//GRJH1W/2LgcJvh9jvyVnLO2b+Jvf+1IVXJzGYUuvGsXUqRxM+douWeJM5iI6NNWl/gkRUawhACm9qWjeWzI/pV+xT8KWxtO3uuHtvqDV7M7/0HqqZWfmQsGsuHtE/+KkADHrbhrd2MAmAmAoXyBir89dK1oYGEncdhI88BzK5Bxot31cGVgODZf1eldFCEE2t0bbXb4NnDacxT/2kmKoeTy6c1nNw3SdQyWLDUT95RN7/JU4FGFuaxttxI9B5WIoVog7qtah+M/U4VEfRjQvEP5z6jpQxfAfhMNS7dG0t9pyXmv6PcSD6LMN9nUHvh6X9Z3mSgYO/d0YrDg0Oa0fk9VZvQQIt8JhHuTVRZVpRA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlFmWkhNK2RrbCtPVzF6VWIrSFdsc2JiTW90bmxzckgrYk9QaVFrWjlteVNG?=
 =?utf-8?B?aCtVaDJhKzUwSnlCSUtyeWVyc1hIKzIxQURRamh3MFVYcDIvMkdxb1ZibmJK?=
 =?utf-8?B?UmVDWFArMWN4eXhuNzYwZVNJbnhPc1hYQUl4RGJ3Q3lwWFBRam9VUklENm1Y?=
 =?utf-8?B?QzVhVGJJRFNkWjRrZDNYTTJzdlJOOVdpenpmSTdpTDhLZzM1dzMvaytSYzI5?=
 =?utf-8?B?bkpBam5nRlhueitxNGtmT1ovM2VNQ3Npa1JlN3pyWEM0alJJZ0V0NzJ3bnky?=
 =?utf-8?B?WDh5NW5tTWFDQzRTYnF0Y3NGNDRmSm5kRmtacFNJaWplR0xUclZRRTR5bEhm?=
 =?utf-8?B?S3llbUE1M0YyVW9iZUY3UG1lK1Q0TmpWL1ZVSytJSHVBMjNNVy9DWDNZQmFO?=
 =?utf-8?B?TTRvdWhKWnlmSUtwU0FWMGhyMDROVzRHNWJDeVkxK2NJaTlmVnk5dUVQYnhG?=
 =?utf-8?B?WUFnUHlYWHdpTnpZL05XQlZ2Q0lVWmxwMFdQSi9JdHFxaHA4ZS9VM3RLcW5M?=
 =?utf-8?B?OU16S1NNQjBWNHREY3RHZFVRZ2dLeWpXVW5haFBKMUtVdDRvMjc1VnhFYjZx?=
 =?utf-8?B?Yy9yTDVrcGkzejRGcDl1Sm5CcENOMzhPdHJ4V25sbzZRYmMvZ0Q0am5RWDBP?=
 =?utf-8?B?ZW8wTk4vZkNZcFN0SDhRUWxLN1FWQm9IZmlDT2x1UlBLOWthU2hMZWd6S0Mv?=
 =?utf-8?B?UmkyR0FpY3A5TWRxWmVCeFM3RkhaNFAxbUVUc0xQVFcxelB2OVZhbUdRVDg1?=
 =?utf-8?B?cERQUzZxUGNTVTkrZjhNdkZZdWJiemFKUjVLcm1WcWM3bnpTRngrNzkzQkt2?=
 =?utf-8?B?aWpnN0x1bHh4ZENGWjNkckVVR0NjUXZYa0hPOWM1SEQrdk9ObEtSdjUrQTNI?=
 =?utf-8?B?K1RBK0xDZnZIY1hnbTBpdDdhUHlySmF5ZlNaWW5SVFlndXJZV3VMSVIyUEVX?=
 =?utf-8?B?T25ucGtnSjhlb0I5UDZidnFEd25JbTlDSHlPTE9kc2s4UFJtMjdYSjVua2k1?=
 =?utf-8?B?SzU0ZllYNkZORzNnRGU0dUs1SzFyVm0rSTVsY3p1UXZvTVVkU1VMU0lGMW9E?=
 =?utf-8?B?eDRzV0R0U1dDSktTbHJYUDlxakNrSDRmRmJBMzU1WFp1NWNCL216NDY0YTIw?=
 =?utf-8?B?MTkwaDVzK1NlOUw4ZkJwc1ZWakprVUY2dXpOZXVrbHB5YTJxdmM4R25GZEYy?=
 =?utf-8?B?a25BUUxQL2lPdXRtQ2pmQ2piNEREaHhVeWYvTW1xR2Vqd1pyRGE3ZlJab3Mz?=
 =?utf-8?B?UjBmNEdyK3k0UkJoMEw3NHo5aForSmo1VThSVXJpa0ZrZitCb3BsWGwyaGMv?=
 =?utf-8?B?NjNpUUJLTnExRlBBL0dvTHBIbFNoQ3J2VVpvcUx6UEY3dEVxcWF1QXhMa2Fh?=
 =?utf-8?B?ZnhRNmdNUWVvZFJuMVArUzdubnlIaVJWaUowVERNS2xTRmY4ZkJ0cVJNOS8v?=
 =?utf-8?B?dXNGYTlqOWNoelRYN0JpWjdIalM0RDRmMG15L2NaMTEwcy9FMEFtSlVCbmpJ?=
 =?utf-8?B?dDdmdU1RSzYvblZNZ0xPOE52cTFsL01DVWx5VEhKQ2VGdStzMW5kVWFDcGp5?=
 =?utf-8?B?aExESFZ0MWJKdlpmaEh6VVZ3RlJlT01JMVNrRHpsSXVncWpUckJnUGVlR0c3?=
 =?utf-8?B?aG1uQStOK0FPNEZOUmFWdEhMeUlZZ1ZVdHplUlFvTUNJY3AzZ1ZaL0tUYklU?=
 =?utf-8?B?cUg5QkxTZzFzU2lMOFFTa3Q5NlJBVGl0ZUYzT09UN0Y4SGFiQXdHNWNIaVRJ?=
 =?utf-8?B?Lzgrb0xJOWg4ZW1GbXdrRnVHOTdEby9sSGxHeDNyQ1FGeXZRSmw4Z0czZDlm?=
 =?utf-8?B?b0pqcjNkQ2MyZDNHZUJDU2h2Y2wrRWFhQ3R5c01DQS8yQWd1NzY1YXRSWG1q?=
 =?utf-8?B?WTExcUg3bUxkYngvOTJTZUgwYnE2VmsvdFFTSis3dk5rdlFIYmVvVnh3aHpz?=
 =?utf-8?B?UFZiUm5HVnVscGRDWVc0bGE5d0o1WmNybDVJVXcxUGdGcFk2TFFIVkMyVTlN?=
 =?utf-8?B?NTkyYVgxMEU2RkZwbnBqY2cyOWdKNExKRmpLRStSa2VwRnZ5bEF0VnFSR2lp?=
 =?utf-8?B?cWlnQ3c1dlZxQ3ZwaWdnRGl3bVRqcmZuQWxRZ3oxdHAzSUd6c243a1BPQkVX?=
 =?utf-8?B?S0FicTNjUEx5OTljRi9WYWdkVFVJb3NzQmtMWlUrNzVqeTFEQlY1ZVVNNk9i?=
 =?utf-8?B?b3JocmJ6RHk2RXhVSGlhRDQrbTF3L0s0RHMrdlZWRmVxSXo0Y0wzd3kyTjVV?=
 =?utf-8?B?R0ZBRjQ4QngxaGNGQkZIbi9PTVhxLzBNTVlUeE5YUWhLWFdtRTZycThQM0Zp?=
 =?utf-8?Q?lrqEkf8GlzIrtvMJnx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae19662-eaaa-447f-7048-08de8e59fe58
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:43:50.5279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGhRmMuIOQIuVbkRdTEkO+4pk46vZD0uMkx/rb+83N6FMuW6ckEYzoFx5iaBzk/H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307
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

On 3/26/26 14:23, Sunil Khatri wrote:
> In function amdgpu_userq_restore
> a. amdgpu_userq_vm_validate: add return code in error condition
> b. amdgpu_userq_restore_all: It already prints the error log, just
>    update the erorr log in the function and remove it from caller.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 6e6b1cae15ce..d29620d3d0d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1023,7 +1023,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  
>  	if (ret)
> -		drm_file_err(uq_mgr->file, "Failed to map all the queues\n");
> +		drm_file_err(uq_mgr->file, "Failed to map all the queues, restore failed ret=%d\n", ret);
>  	return ret;
>  }
>  
> @@ -1230,13 +1230,11 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>  
>  	ret = amdgpu_userq_vm_validate(uq_mgr);
>  	if (ret) {
> -		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore\n");
> +		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore ret=%d\n", ret);
>  		goto put_fence;
>  	}
>  
> -	ret = amdgpu_userq_restore_all(uq_mgr);
> -	if (ret)
> -		drm_file_err(uq_mgr->file, "Failed to restore all queues\n");
> +	amdgpu_userq_restore_all(uq_mgr);
>  
>  put_fence:
>  	dma_fence_put(ev_fence);

