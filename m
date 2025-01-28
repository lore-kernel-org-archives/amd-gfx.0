Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A0AC0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 09:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43DF010E611;
	Tue, 28 Jan 2025 09:35:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Je1ANC/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58CE510E612
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 09:35:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkhfVsF191WWA645O20DTn0RbQnlJub/n97zYZ6xwrREbBho7z2Wxl1Sozn5a/W53Yh29Z284L4aubxQlFJ7LPC4EMj9g7bnhbSteTmK1vt4T2873C1eusPmee5itQxCGqYzxpm5Hr7mRBPTDTNBM9f+WberBhhCnibkWF5B67/O6ANgtvI1Bu0qcdoUNnAWewswYfK4nKFJdiBmmXwsUzCGcw7+dsie41L+1u+gtY30Vc4rQaTX+aoDbOTKUK2iuHfOImUM5t+M13Pgx6lmhQay58tW3TFfqVwhAc1xndR5BTEbTonASkJCoiP65+qiGi1Q6AKBTG1WUnIiVE9eSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqiyI/eZGk+R/KaE5FWjTOHzW6RMavk5bMgiUXAAE3Y=;
 b=HEsmMErm8ajGHvdC1OL/Dmw13FZ3ZDYtwtap+/GgRFUZZxAWqkW95PKvC8Yg2arPeZ8j8jIVEIzIO40meMEvAys12BQ+0bGo9Lb+Pp9qWw4GFxFy9oH9pBJ/Vrav3iRkQP3/PKfNXJJbsUkN34NZ5ReDhqeQ+V+h1usb3uu0pTcAQ15pRRC5CQsl516vseQ05+ozfIkOv198I2zGOlbrxT7PpSmTX3zBzPcmKrXT+Zz4adfF6/5wQEHLuJn3HSsHw3PTbADShdxW+KuncGZHxnJ18pEdJZrSfjE1bcnlfQYJ6t5bT+ZPbUNaizPBAbYoXghhYwqMIOxuEAxetF++ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqiyI/eZGk+R/KaE5FWjTOHzW6RMavk5bMgiUXAAE3Y=;
 b=5Je1ANC/OkGeuNrMYLG6TbGdWwf0QIvpY9FfQPLfdDDkjFXRSZHgTHukJNvnnrd6agSHfawcHhWOqmUvUiQCPljUG4Cxkl+lkKaDo+wOCTe6WgTfH3HkWsPwDidKoHudLRMf17HhlKrtVBbhugI20isSpoOLfFz1uVfO1FLkCMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB7105.namprd12.prod.outlook.com (2603:10b6:806:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Tue, 28 Jan
 2025 09:34:57 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 09:34:57 +0000
Message-ID: <16793f54-a7b8-4e45-b899-fb177b39f8f7@amd.com>
Date: Tue, 28 Jan 2025 15:04:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/amdgpu: Add helper funcs for jpeg devcoredump
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>
References: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
 <20250128090950.461291-3-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250128090950.461291-3-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0205.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ab53ab-cdeb-4bf9-5a6b-08dd3f7f0714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUtkMEFrazVzODVydmMvbkFRMFlvOTJQdC9MYVZCMkEySlJsUzIrWThTMzlk?=
 =?utf-8?B?QSs0ZWRIY2l3REsyYmEwMDd2alk1S2kwVXcxWnZXT1RGL3pEY0tjc3Zkalp4?=
 =?utf-8?B?ZmkrMjJxS0dXZXpmUVV3V1JaelJla1I5OHRXUGFHeGFqcThCaWx1ZkZabktB?=
 =?utf-8?B?c3dtN2pFUEYzY1I1ZEtZeSt2SFFEVlZRa3EzanQ3Vk5wUG9EWURQTk80WHRJ?=
 =?utf-8?B?YkR4aWtZQlNaS2lEVnN0RlQ1MDNjU01aQS9qUTdIZEVMMDNrM2x5cXVyenU2?=
 =?utf-8?B?UEpvQWJubW1FNzdDaFg2NWtvVkFmRTFaV0VaODZRSXJFMHlQTHMwWlJtbjBl?=
 =?utf-8?B?aW5YME95QjBNSDZrSEc4S0drdDcxaHhtVjByOWhjRFlGQVhhRVZxbk1RMHJv?=
 =?utf-8?B?VnJscjRSSldncXRYd2tzVFp1SmROUjJaOWt4Qi9oY3VLbG1FR1N5Q0tuem9B?=
 =?utf-8?B?MTNsajBZc3JVY1NUOTZEQUhIMmViSytMWjd0dTRwRDkwM0ZMbGU5YVN4Yzgr?=
 =?utf-8?B?YWdFL1dQZlFRSkxrL2VHTFRYTnl0cEo2T2h5c0FsbHU3cFVVWTBPdkNSRmxC?=
 =?utf-8?B?Z2dIUldFZ1lFV2RCcEVRWFZIZ016MDUya2FHZDMyUFhhc1ZpNjFWYkNWUmYv?=
 =?utf-8?B?akpFaDY5VEIyOFk2dFRKRXVwSktHeDN0NWZuQVVmK3grRzBQOEF6QjA1R0Vm?=
 =?utf-8?B?UlJtRUUxZmNjSndZeCtXcEZYRHdnZDhxQ3pKYjBVUHJhMFpYNHFyejMzZTd3?=
 =?utf-8?B?YjBWbE5Jcm9rSzkzWS94UUxBR3ppUk8zWGhZUldFSk53M3c4c1grQUgyTHNU?=
 =?utf-8?B?SzhCdDRvYjlBbVR3MzVFR1JFRXFIS0tWbi9jaUZMWUxid1lBMXlpaEZHdVJP?=
 =?utf-8?B?Uzd4WjN6UnpsZ0U4bHQ2cXB1YTR0SE8vQUxTbnplTmdlTlZLY3lON21IOTlj?=
 =?utf-8?B?Z1NhSG9BTExKMTVQTC9GeEpPUE1KVVJCRjR0WlRMSVdCbGpTUHJ4WEdYZ3lE?=
 =?utf-8?B?QTBsc3V0dGZUZm9DMWtOdm05b2twR2hGd0srSjU3ZDFXSysrSG80ZTE3b0d6?=
 =?utf-8?B?cjJmZXBuVHFEMitzd1F6OE1vdkIzV0JGQzhzSkFWaWs0VEt3dFczTWp0OHJo?=
 =?utf-8?B?YytPMTBMRjF1SGwzNFNtTzJOZXhJSzFoK3l6cG82TlZ2Sjl0aHVPbCtrMGlE?=
 =?utf-8?B?YnRLQTNUMW9IcHNvZFNJd0ZCOGUvWnp1aHl6Qm9yRjJyYy9yZUo2cGNsRzNa?=
 =?utf-8?B?eFlqWmxadVlwejNPQ3p4TUN5bkNNaXNOeFJ6ZmxTWk9TaEN1c3dNdFd5Ti9i?=
 =?utf-8?B?NDM3eURtOHZTS3NINkJBeGtmd1doaUlHZWx4ZWFzZ2dGUXpKSnIvbGIvRUJY?=
 =?utf-8?B?RGgzUFhrclljOEhVQVF5MnBVbzlwMHpMcDVFeXRLOGdrd1F3QVpTWU1lT3RI?=
 =?utf-8?B?R1NEbUFZS0dGRW04c2haOUtPTzU5L1FDeFB6RjhsbUg5QzZ3S0lrZVVxQmlj?=
 =?utf-8?B?OFp0Y3NiMnJNd3VFWU51VTlSL3F6TkRvZGs1MmFPZzFla0taWWtEMmt3T1FJ?=
 =?utf-8?B?djBtRkhoM3FqS05Cb3JVUzl2ck5uZkNXdHRFWnFiMDhkWTJjTWM0RFdicVNM?=
 =?utf-8?B?aG1GSklvbDdSUnlEek1KZmRPaS9oMGJzcHVBOGFObWpyZDlIejEvaTMwWFFM?=
 =?utf-8?B?SFhycThEMjBQQVhyQjdnVlhrNWV2ZHBDRC9XSS9nbWxzVGZ0KzI5RXNkbHV1?=
 =?utf-8?B?N2xZZEpEd0lnVnJEZXZtVFA3aUNVZjQ2TERGS1BVY0hIY3J5M2hLOWVVWndG?=
 =?utf-8?B?MlV1Y0FpcG9yeHVsc0syZ3NreHh1cWVXSUl3SjNBR08yMEZha0NJRGR2V0xO?=
 =?utf-8?Q?GrVnvQxuUKog/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWxESCtXcDM2bUdGMUVERytEaEdkNGRGTmxVYVdaaEo4ODRWaUJRQ295cXMr?=
 =?utf-8?B?Rkp1MmdYT3IyT1U0c2VOeHBBbEpMUXRUODRXTElGa2M0M3ZwNFIvRmE4eUQ0?=
 =?utf-8?B?UG1CYXJpaTExQW9CNGNQOHI1ZlB5bkh1L2dWNm54d2VzRnJCazdYc01FaHBV?=
 =?utf-8?B?RjVIalBjaGdLWFF5MWY0RERGWFo4WE9LOTlUc2lmMEp0dWxBOVAyQW52ajZL?=
 =?utf-8?B?Z3Uxb1VJc1NPd25SditEeDRFRmVUak5WYXB0Smdrcy9TU3Z6cXJGMDVqV0Fl?=
 =?utf-8?B?eE5zQytSNitQZy85TUMzU1IvQ29ncEJmYWY5bWg3ZDNmNDc0M3N4L2pycWc3?=
 =?utf-8?B?VWpkZDdIT29hTmNrZUZUeHFpdUVWeWlSdXhzaS9GRkdsRkdjQ1dUYkNscHJY?=
 =?utf-8?B?dUY0TmQzMlg4cW5tZ1A1amRvMlJUcmxtUElmdkozYTZGL3ovYUovYjBja0dF?=
 =?utf-8?B?d3BrQmk1RytuL3NSb05FR0VMWGJKVlhxUnhaUURqU2Z3YUxIOGJnbXBPZVFF?=
 =?utf-8?B?SlZkTllsR3RXNHNqVU55QnRFdmh1bzlUSlc5WnBtRlZPL2QxdFFyVDFjazBk?=
 =?utf-8?B?NzdUYS96V1UwMG1uYmlMWTRZbStGbmFNcXVZdEdnRXAvaFp2Nys3Zkc2ays3?=
 =?utf-8?B?bVJ2VzNYQitKMjBQd1dtOHZKWWtFZ2NmTGQwSTJ4NThkNG9sKzZEcUlvK3Iz?=
 =?utf-8?B?OFludlljMU1BZFhxdFBSSWxvQ0xFdWNqMCs3UkRLMkkxekV6eDNjT3NiQlRa?=
 =?utf-8?B?b1FoMTB1YU1nV1dpaWt5SFBLcGtMMk5ZMTB2NGRlWjNObksraHFqRGplQWlK?=
 =?utf-8?B?bU9BMmxkUnF0VTdXUEo0Nkp4ZlhJaU1ZdjJJSVdVZTgwK3hNbUNlZWJ5QWZT?=
 =?utf-8?B?V2FPd2ZZMWE4cVlPZDhBVUdscjdmeUsvU2pTM3JOYW5maWp0d1dBY0pWNHF6?=
 =?utf-8?B?K2IrUlhKRmx4MDMvc1Vmem9xcU8vZjNwdyt1Qkd1citMMXRwcmIzM0NwTTNB?=
 =?utf-8?B?L2dRa0hPT3dRZ0JzRHRrRmxqTThXTUZlQVNIQ09IN3UxazZPbVpCTjFhZzhS?=
 =?utf-8?B?TU92NDJzZmNNemM4c1l4Q0puOWNEMjJKajcvSGVDaXZuZlhLb2JJeWorQXEv?=
 =?utf-8?B?QUtIVDk0d0NSVHBBeVNSK3ZZYXpsNUVMR2xqS0dPL3lKU1NPWTZlOEpoS01T?=
 =?utf-8?B?eHFQRThHQUZjMzhiOG5QaFVZbjU3NHhMYWNTSUlVSXlvR1ZjQ1hnc1Q4VFQy?=
 =?utf-8?B?OTR1elAyeW95R3pHSDd2S1RsTnlERHZKQVRpVzBDV1dSbUJQRFYzeGYxYmFu?=
 =?utf-8?B?Q1JpWDRTWkRQRXpjamg2aFhXL081bmJMNkhDSEdIS1NSMkxHdVViWHk3WjFN?=
 =?utf-8?B?blVGbVkzSGtiN3dycHBaRVFQL1lMclhwQUhEa2ZLMTZtUHBOcm56WXdNYnI3?=
 =?utf-8?B?MjZ5cWdnMnhrelZRUzl3MkdmNy9ZM2RJaXFjRVp4OHJsY1RCV2VYMHRaelVS?=
 =?utf-8?B?ZGdiK0xkQ0RxbWxyeHZZUWdoQnZRZVZmb1FmWFloYjZhcE9ueFNNYldtMUl6?=
 =?utf-8?B?SHNNU083SjJDY0Y2aUl6T0FVUEFIbEdDdlBqckdUQUtPSXgraFRIK1p1L1pp?=
 =?utf-8?B?eUw0S2pwZVFwNjdBWEVSMEVPaUtBUEJ4SVFGU2g3bHFxeTNOVTlTRFNVZ3dG?=
 =?utf-8?B?WnUveU92akZXY1FVZkZSZ1FQOHFidXJ4OHBtWmoyN3Naak9NTWpMNFJBK1M4?=
 =?utf-8?B?U2JqbU1UV1IvRXJWQUVVcXJNRSsxdXpsdmV1ZDAvbFpsYWFKR2FoT3ZxOEdi?=
 =?utf-8?B?bWNNaldMTXI1WEZZZm9pRGl4b2UrVk9sWDMxTlNYMHVOVkY5SCt5cWw3Zzdn?=
 =?utf-8?B?dVJtSFJKN1lpTi9ST0ZPSyt4dXV2bEd6NkFLZDlPY2o5bWdvVzJORkQ4Z0Zm?=
 =?utf-8?B?WGliQjZOT09Gb1FsTU1IVk95NElhM0pZY2Q2RTNBQ0h5ZTljVFg3SkxvNDlL?=
 =?utf-8?B?TGszTjdrMDd1dFdZdDFyb0YyVXFOK0RBSHIrOWwwSWc3K0RmYjhqLzZSSkl4?=
 =?utf-8?B?VnNDYlo3RWRuT0RtQUJ6MmZjaXhDblF3YnZTUjhlUFpSbDF4dkovUnUrYVZu?=
 =?utf-8?Q?lkmcEJnhL32TlqtyCywavGVYi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ab53ab-cdeb-4bf9-5a6b-08dd3f7f0714
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 09:34:57.2026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVIXIERsOILJSUCwemrn7ZkB8DXrRzsPKeeC/oiK1ZJswzZfjENaTLhO5PVuhtkk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105
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



On 1/28/2025 2:39 PM, Sathishkumar S wrote:
> Add devcoredump helper functions that can be reused for all jpeg versions.
> 
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 59 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  7 +++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index b6d2eb049f54..70f1e0e88f4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -452,3 +452,62 @@ void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>  			device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
>  	}
>  }
> +
> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block,
> +			       const struct amdgpu_hwip_reg_entry *reg, u32 reg_count)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	u32 inst_off, inst_id, is_powered;
> +	int i, j;
> +
> +	if (!adev->jpeg.ip_dump)
> +		return;
> +
> +	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
> +		if (adev->jpeg.harvest_config & (1 << i))
> +			continue;
> +
> +		inst_id = GET_INST(JPEG, i);
> +		inst_off = i * reg_count;
> +		/* check power status from UVD_JPEG_POWER_STATUS */
> +		adev->jpeg.ip_dump[inst_off] = RREG32(SOC15_REG_ENTRY_OFFSET_INST(reg[0],
> +										  inst_id));
> +		is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
> +
> +		if (is_powered)
> +			for (j = 1; j < reg_count; j++)
> +				adev->jpeg.ip_dump[inst_off + j] =
> +					RREG32(SOC15_REG_ENTRY_OFFSET_INST(reg[j],
> +									   inst_id));
> +	}
> +}
> +
> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p,
> +				const struct amdgpu_hwip_reg_entry *reg, u32 reg_count)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	u32 inst_off, is_powered;
> +	int i, j;
> +
> +	if (!adev->jpeg.ip_dump)
> +		return;
> +
> +	drm_printf(p, "num_instances:%d\n", adev->jpeg.num_jpeg_inst);
> +	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
> +		if (adev->jpeg.harvest_config & (1 << i)) {
> +			drm_printf(p, "\nHarvested Instance:JPEG%d Skipping dump\n", i);
> +			continue;
> +		}
> +
> +		inst_off = i * reg_count;
> +		is_powered = ((adev->jpeg.ip_dump[inst_off] & 0x1) != 1);
> +
> +		if (is_powered) {
> +			drm_printf(p, "Active Instance:JPEG%d\n", i);
> +			for (j = 0; j < reg_count; j++)
> +				drm_printf(p, "%-50s \t 0x%08x\n", reg[j].reg_name,
> +					   adev->jpeg.ip_dump[inst_off + j]);
> +		} else
> +			drm_printf(p, "\nInactive Instance:JPEG%d\n", i);
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> index eb2096dcf1a6..1d334f35d8a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> @@ -92,6 +92,8 @@
>  		*adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;	\
>  	} while (0)
>  
> +struct amdgpu_hwip_reg_entry;
> +
>  enum amdgpu_jpeg_caps {
>  	AMDGPU_JPEG_RRMT_ENABLED,
>  };
> @@ -137,6 +139,7 @@ struct amdgpu_jpeg {
>  	bool	indirect_sram;
>  	uint32_t supported_reset;
>  	uint32_t caps;
> +	u32 *ip_dump;

It's better to keep this at per jpeg instance level (amdgpu_jpeg_inst).
If the hang happens for a single jpeg ring, that will help rather than
dumping out reg settings for all instances.

Thanks,
Lijo

>  };
>  
>  int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
> @@ -161,5 +164,9 @@ int amdgpu_jpeg_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
>  void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev);
>  int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev);
>  void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev);
> +void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block,
> +			       const struct amdgpu_hwip_reg_entry *reg, u32 reg_count);
> +void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p,
> +				const struct amdgpu_hwip_reg_entry *reg, u32 reg_count);
>  
>  #endif /*__AMDGPU_JPEG_H__*/

