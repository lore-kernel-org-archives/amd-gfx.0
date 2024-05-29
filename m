Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20A4C25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 06:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E773810FDBE;
	Wed, 29 May 2024 06:36:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xKdguAH9";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2365510FDBE
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 06:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoMMfAG5MDzdWUgF+xHLMhjshJBHRf//ktDGhi8GfBl6iaajJzJGhIm83v99YW73v4yoya+A1PzBCM/jqcrppCWhOcRebX0oG/j1ig9r+cdkl4ISwPic/4BAorVbkQEvJPsCEg/U6bPt9ZR3lUfKcbNsuBl5JMZA+XYzFScqCTZiY7yPE7TYVQpT1jSTeHOT4TPaWFgin8YtJuO5Sah0W9rzp79BdQiqwjbtf5A11Sz3W4mKHNQj0Yc3lrMxXRMONltpw8MwDfGCcnw1TOd6O0Z4LDEFcuF2WiymTvel1fnFHv5JvxIGfYDDw1plppEfc1SQ4xpk6/eCE2nad458jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvIzfB9RYHS6t5b164QkH28zE1+FSxVABGjd4PH4IvM=;
 b=nQz0qUZZ6410CFlErwjE+5+xUhQkvYyvcN0/XOM3on8YOHM9VcvXdeAY+OiuD3kxVk34ZU1IGxOq8DNlklSQdYb8VE/zS2f27Le/v9nV0xYVClKi/ptf9Uj6cfeC/ko/dIZylq35Qzp6eAsP6NWfkMq2nOHVULBuhPFajQH6LOnHMZxZkC0JRmbz/I3M5abDbT85Sr7lO2ekdidl4qqoelbzwge/AXxS9Vx90+3x/2MqJRoOvLhi6AgBhWYV4GCjrMcQLaVI85bikp+g32n1Id7aeoyyCvkNKh6gnTaMc3W24ba79fFpKqvvvHJtPq8EJqR5gQDBDMuTuPiizaIECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvIzfB9RYHS6t5b164QkH28zE1+FSxVABGjd4PH4IvM=;
 b=xKdguAH9m32LogbXHakxw6OfG75VLxUnZHhBfMoydeXquWbWPcMQLawl7Zi9uxcWOMGa7to813DSrhqNzhBm2ahD+9eWQABZcroyrxwfZG67nYD06mN6hxG8/KNUmZr+XL/xp2+1kEvE91YwglRsFRsP7ldRcXnlAYe8juhi6vs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7785.namprd12.prod.outlook.com (2603:10b6:806:346::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 06:36:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 06:36:06 +0000
Message-ID: <42e3e38d-fa69-46d9-a649-1564838745c4@amd.com>
Date: Wed, 29 May 2024 08:36:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] drm/amdgpu: add skip_hw_access checks for sriov
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Hawking.Zhang@amd.com
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-2-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240528172340.34517-2-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0e9aaf-ade4-487c-6f13-08dc7fa99e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MldEN2ZwQlErWFh6T2tGWTVBaXRONit4bHZYMUJJZDBxQmsveEVmdHViWlpx?=
 =?utf-8?B?L2w2Qys1b1dyOXdpekZ6endMM01mODF4cm5JUUVYeEdGYjNzVlpJeEJsanAz?=
 =?utf-8?B?SjRHK3dNUHQydnNLcDFXZTlvdlkrOE9QMmFROHdYZy9KelpLeFdmMXF5ZHlP?=
 =?utf-8?B?UWtLRnlZTndBem1vMFViVTdwdEE0cUtZcC95RVExSmp3TGV2RkFnQmxvQ1JZ?=
 =?utf-8?B?NDFUd2JTMExtbTlneFhnMk1FM0phRHVxMU1rY3MyVnRiVFpmS0J5bjVydUFV?=
 =?utf-8?B?TTdMUHVJR2Jia2NjWmQvNW9CcFFiZEFVY0FCb0dTd0Evd0RVRENTL1VqRFZs?=
 =?utf-8?B?STNLaTg1elNMYnp2RElkYjlSLzMwRWcveW03NU5RM290ODBqRnZBRmFxdTBH?=
 =?utf-8?B?eFphaDcwREZhTnFhclV6YW15UTVxcFR3eDZaakxtL2kwbk1wNTRQb3RFVXky?=
 =?utf-8?B?RWJ6eFV3MzNGc1FmU1gxZTRJTm94WStjbExSV25GeGFUZ0V2V1Z2aytuN2Js?=
 =?utf-8?B?LzRoV3FDSW9jbk8wQlJYNEZ0TjJWNjJ0N1pSa2JOWExJMUUrQlUvTm9XaHNn?=
 =?utf-8?B?NzB5NVNsb1I5UVpSWTNSZ3hGVzdBTTRHOVlNS2h4VU1ia011SHY5VXRSOWpM?=
 =?utf-8?B?aXVPcHVSYTUwNFVCalA1dUE1cmJLMzNXVEpzSjFtWXcrL2ltN2hBcjRNaXZP?=
 =?utf-8?B?ajhadG43ZnZXRjFGOXNyV2daV28xVStNQXlyRXV6bll4bG1VSjM2UEg5Q1R4?=
 =?utf-8?B?d0kvRjVXa0pLTWZpUmtkNXppbXBiVDUrTkFITjNxZFJha1liR3REN0tPeTlO?=
 =?utf-8?B?K1lvNGlPNStlQVM1d0ZqeXNVTS94OUovR01vZHpEdHA1aGQwbWpnZlU0YVdy?=
 =?utf-8?B?NWtzblVnZFIzbkpJc1paTGYxWHZtMUtOdGRrOHcyTmpxKy9rL0k3RWFuUVli?=
 =?utf-8?B?MG5EOVVqSVNaWXBPdDRuczJOR3hZVFMreHJMMHdQZHg5SmFtU2t4YWhIU2ov?=
 =?utf-8?B?L0hJWDVxekhDeUlVeW9NVC9Jazc5RGNOcE1scVZmbjlmN0tYOVQ0N0ZvN1FM?=
 =?utf-8?B?d0RxYlFjL2NnYVRaaXEvY0VTRTN4VE0reVVmSk01azlLZlg0VmcxbVY2MU01?=
 =?utf-8?B?QlYxajVPU1dvZzFyZlptU2FRSE1KazNKSDhFVmZ5YnhvTms3YUNNaWVXanN2?=
 =?utf-8?B?Qlh4QmI3THI1d2kyakVOdVhjbWpHbFozWDFvZVhGRGloTWRQdXRiRlI3V3FG?=
 =?utf-8?B?WEo1ZGZkYU9NWm5CM3BMcGtwTFR2RWcxOHNWSlpVYkxlWGtVMFo5MHpwcHZo?=
 =?utf-8?B?czMrZTYyeXJIVUZxaVNDc001VjcyN01leHEvT1pGRkkwb0lmUDhFemtZRVpo?=
 =?utf-8?B?SXNqdXZPMDdTeHM0d01xRHdpRm1yM3hDSHR2OUVBWldVRWwzeDU0SDhZT2ZD?=
 =?utf-8?B?aVA5M0c2ZGRPaWwrR1Z3RDJ0VDUydWVKcmoyek56WG1Rc1JyM3JPNjY2VkhK?=
 =?utf-8?B?MHN6aFdRWlMwVUFqVTZqV3RjL01RWVVrcklGTENGUVdqazhobS9uWEZ6RWQ2?=
 =?utf-8?B?TDhWa2wwZzNqTXZsTENKeGI1WVZGYU5DSnRkT2IzZ2tZTGxMR1gveU02TGFF?=
 =?utf-8?B?dFUyV1RLOG50QTRnZlhRZVViUGVRL0hHcGRaZTBLUmJuYWFWZGpFSlppbFU4?=
 =?utf-8?B?NmFveHRxL1lRS1B2V29wbnlQU1EzOWkxYVRzWG5aU3BaejN1RFAwNnJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STRIUkxCMnNQUldCWjUyN3VueXE4WmlGUDBvUzBFYXBKazhPd3c3NllNTmNB?=
 =?utf-8?B?N2psTmNNTWw2b1dqeHhPcTUxeE5oUUxhU0IxdjlOazhoU1RxRGFRQ1RIbHhi?=
 =?utf-8?B?bkk4ZXpnSW5TQno3bzJOMnhZb0VpckdGRFJyeHNhS29KOWdvdmtsbzF1d1FR?=
 =?utf-8?B?dG9XN0hqektYZ1BQWUVmQ1JDeHlNVEkzeUdpazJZSWdKcC9aQXplV2VYaXZv?=
 =?utf-8?B?NFkwN0F2YzFGQVFrdDZ6U0puUjFPNysyZXBoQm0rQ0tVTk1RWmZlOSs3ckdF?=
 =?utf-8?B?aklSOUQ5ZUswUnZ4T1greDJ2amxHS1BEeEtYRWxGQ2pmcW5EMmVEQTM2cHBV?=
 =?utf-8?B?aW9UR3NFMm1sQjNSOGU2WE5Wa2hid0dTdXR0eGNYcjY3aE9PRHZHd0JaWkVS?=
 =?utf-8?B?alNlZ3dOUzYrRE5BNHlMczNXUFEyZHdoTWtzc3BVV2Rub0JMODlFZ1JLUW5o?=
 =?utf-8?B?akxBcVA4T3pQTXUvank5bjZMdnZDY1c3QStwMjlZdVRFQmNXVGd0a0d2UnJX?=
 =?utf-8?B?SDd1TmZ5emlBRlJHZDV4Z3JkVHFEaFl2QXI4VlZyaFZTRVRIVjl4L2xPbDNX?=
 =?utf-8?B?STBzMDVHbmdiSnU0Vi82K0tHOU5oRUVMelJ0aG0wMDcvTWdhMGZrY3MyL3VO?=
 =?utf-8?B?SHFUVTJ4NGhOT1ZsNjlQeXRNR2s5VDZDa2s5VEszb1FNQjlvSlVTUXlPNTRC?=
 =?utf-8?B?eXlvdWhHd25XbmJmQWZYS08vcWNWcERBUmc1amNBb0ZwQ3E1N1l4ZlJsYTZ1?=
 =?utf-8?B?MkdUS1pBSjhIaTFwYWl1cGkxUGtyd2k0aWljUEtZMExPd0VRamw2Wnk1V09N?=
 =?utf-8?B?UFJXaGVXakpyczhxOFVKMmZOVVlJTUpUSThEbmszejJoT2wxY2wrSXg1eWVh?=
 =?utf-8?B?Wi9XdTF6WUdXRVVkcXl1K0dxTWF0QVB1M2tSTExuL0Q2ZHczR3RoVStZSFY4?=
 =?utf-8?B?a1N0TmRKVS9Kc2gweVdVZXRESmpFUGpyNG92WjB4YUE5TUhYRzVBMUVCcW80?=
 =?utf-8?B?MERybGtCTmUrZzJiTGd3QlI1VmRYbHQybnVmOXJqQTFodkNzOXcyQ245S0sz?=
 =?utf-8?B?QXlIY1F2Ykp5b3poU0ZUNEhUU2F2MmtGbHZCTEl5V3Zzai96dklGaUx2ZlZF?=
 =?utf-8?B?QjR4RTV3WVVabTVXUXhpbFREem0wMlhRdjkrRzVEdmJxUnpQVllVT0NXNWM1?=
 =?utf-8?B?ejRmY25XYVVEb2dQQkMveFVuaTd4V3pMaXYvODJSWjdpY25kSGJJRzdMVmxG?=
 =?utf-8?B?RVh3ZVgvZHpPaThjR2t5Q0Y0T3liVWtWUzllRm1acXpKcHUzWTFzaXlLZGgw?=
 =?utf-8?B?di9pU3NadTh6b3RIRTZrMzhWTldGMi9xdTFta3lxaWtrSzJiSWpkZjFWRzJ0?=
 =?utf-8?B?VUNDVlQ3U2VhUnptOHoxOGptaWs1QVJHazNkTDd5aWtISWxHU1k2SWJMRXlZ?=
 =?utf-8?B?NUh6UkFsNHVDUnZtbGNRUllRSTdVeWk4WmlWOUNCcmNDK0lDV0ZFaFBGY2ZY?=
 =?utf-8?B?WkhqbjBPb0FoUUdaMmJZb0E1STlDYityMXpHZ0l5T041TUZrZzhxME5LOCtC?=
 =?utf-8?B?UHp3NGs5dFZrMHpBbUxWam5ZZXFzWTBLWEhXalE1MHkzRU1FRzd0YUtPbGhD?=
 =?utf-8?B?M3czOEJ5SDVia3B4YkpaV21yckxZVG80cTVPVUtzS2o4K1F4bnJ0Ykk3eVRn?=
 =?utf-8?B?YVgyRnA3WnB2ZkpadTR4QmJPOUtKUjBBdHlCT3VYUXY3ZTYzbzE0Z09tUHp1?=
 =?utf-8?B?SHlNbkhQQXFLU0lmcmh0WGdNdEFxa3V5MmpYcEpRbEIwRmpYRUd3b1RiMFRt?=
 =?utf-8?B?a1BBQThaSkFob0NmaG80bzRhTS93MFVYZS92aWNrOG5za3BiTWdpRjFlOG1S?=
 =?utf-8?B?c3dNdDFtVnh5VGJ0VitXYlJ0RmpuY0NrVzY4blRTZERqMzZSV3o4djNwekpU?=
 =?utf-8?B?dDVlbXp3eFZYbkR5bzhKYzlKbEs3aVdQZW5PL1FZazFNWFlKMzhWSXd3YnRO?=
 =?utf-8?B?NWVUazFicTRxTit5RUVBaFZrN09pazRheVhLRC82dDcxUzdhS3F3UCtaekpI?=
 =?utf-8?B?cS9mR3VqN0lYaXNsb3A0MWtSc2w0dEh5QkR2d3V4bzZvQUh4b09iSi90eGc0?=
 =?utf-8?Q?/yw9i+zEkuvYWKP6BK+HOtPxh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0e9aaf-ade4-487c-6f13-08dc7fa99e53
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:36:06.5058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3CF1ejnKxjpir7+Qb51ByiHTRxkV/1XOoeM9plIawQV7pJC6Nwtuedt4SGBRGQ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7785
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

Am 28.05.24 um 19:23 schrieb Yunxiang Li:
> Accessing registers via host is missing the check for skip_hw_access and
> the lockdep check that comes with it.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 3d5f58e76f2d..3cf8416f8cb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -977,6 +977,9 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
>   		return 0;
>   	}
>   
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +

The only other caller of this function is amdgpu_device_xcc_rreg() and 
that one has the amdgpu_device_skip_hw_access() call already. So it 
could be that this one is duplicated.

On the other hand an extra check doesn't really hurt us.

So either way the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.


>   	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[xcc_id];
>   	scratch_reg0 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg0;
>   	scratch_reg1 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg1;
> @@ -1047,6 +1050,9 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
>   {
>   	u32 rlcg_flag;
>   
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return;
> +
>   	if (!amdgpu_sriov_runtime(adev) &&
>   		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rlcg_flag)) {
>   		amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag, xcc_id);
> @@ -1064,6 +1070,9 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
>   {
>   	u32 rlcg_flag;
>   
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +
>   	if (!amdgpu_sriov_runtime(adev) &&
>   		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &rlcg_flag))
>   		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag, xcc_id);

