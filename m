Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EA6C52D7C
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 13:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B50C110E21B;
	Mon, 12 Aug 2024 13:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZGQB9UWd";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6CE810E21D
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 13:45:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxum4+rbrKSe2gp9LrGj7UweMzwaq2A0zsF07TQSz5MLOJirxfuFqeUbi1Hg2UAAwNLQDZ0f3YIUMwe2OjyADAPZ2sn0WB1Qn7tqqe2xy9o0YP6PB2Kav3ny1JNo14eEyxd0pQTWm+hor/k7/5trlgq2Xn1/bcppzBknLK4oaJ1WRSswxQvgv5i4aU0v15C17L1Yw54GSIwSjElCZ5VKaXmec5kVRwEpk+wlY+vXgtYqU+Jcak2N5bBu1o7qnlv43/WtXlNwEFdbzWOMbKyVU7S24cHo4x+7lhWfZv+44JQAjXtSo2owcsaAkQ4ZiHF7ur/+5tj3DhqMHQuGUFgV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5R8326GVe2IjAHYG/8Mfe6WfuocpzzqLWn+SDpFXMcI=;
 b=pn3jZbBPxF5ni9NDvQVMSK1BwhAhZw6wLiN4gIvsXh+JucSmZNwi2oAeHF5y5J9HTGi/Xwxe21GtnXD3gJ9fUSefbJPe28aqOWU5LbH52U8d02HYQJlSP8Crivskj0FDJaTSqqw1VMfmHMj3KUMuaqZmY8K39ez8OznZW56RkONyDxm0pNpT5ksthPYgbJz71v+Mq1uZwaqmHhNZP8iOnhw9MSU1bZWGCKqk3PgCWyQGs7t/5ro+/GO6/h7Ax/1MVD60ZpOUN7OX/nNeZ8pwP3gWJqWFM+sDRY27ZmKVhHwPj9Auhs18uIrwe+VbDLHpMogeYTK1wAVHVf7JgLxlRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5R8326GVe2IjAHYG/8Mfe6WfuocpzzqLWn+SDpFXMcI=;
 b=ZGQB9UWd5aPaAdiNodKPMhpYk61UGPH4YAdkwYS2k8Y+DNtnX+pOIFE6ncQZzFfBquLmt7C40FOuh5mybfYCWr9lAFeLLxZxhZs+NAsnbvBOi2i6ohIUxjqNNhNbVmaEEJhUG4D/AKmo+z58FGpqyWxjdbgb94ncaCgjxGzeucE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.20; Mon, 12 Aug 2024 13:45:40 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 13:45:40 +0000
Message-ID: <562e12ad-c10c-4b10-bf43-d0dcf82eb823@amd.com>
Date: Mon, 12 Aug 2024 19:15:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Disable dpm_enabled flag while VF is in
 reset
To: Victor Skvortsov <victor.skvortsov@amd.com>,
 amd-gfx@lists.freedesktop.org, zhigang.luo@amd.com
References: <20240812130909.1011463-1-victor.skvortsov@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240812130909.1011463-1-victor.skvortsov@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b936f6-2df3-4b50-ddd7-08dcbad50db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azFuYjFsaVBtZm9uQnJVQVM5WVA4enhmZVpEUm1FNFBSYi8rcDhIK0VCVlhY?=
 =?utf-8?B?SzFkY0FMMlZEVGtMdTNoeDY5MUo1UzdRS2FkYVVialRBZFpZeXVVV0syWDlE?=
 =?utf-8?B?M0l4TGR1dDY2Tm1uSEpKcXNKRkpLRkxiYU4vanRjNllUbm0yelUzYldQOWxT?=
 =?utf-8?B?Wnl6bmxxRDlSaHF5aWtrdVBIeG03NjVBK29oRXhsVnVOZjFLZzZvcHg3dDhM?=
 =?utf-8?B?ajk1VGRZaW1RZTUreHRnQTFEYVNpRjgvNE1SUmx3YzFxdzl3alp6eDNsbVdZ?=
 =?utf-8?B?QmkrR2dlcG5ZOW5uYmdreTRodlVYNWxFejY3NkJ0b0NBRU15MXVkMFNiY0M4?=
 =?utf-8?B?TTd3dXgrbGRYNkNvaGxZVENwVWNuNHM2dmxjaThlMjNBZFNjZkpweXNwdVlZ?=
 =?utf-8?B?QmZhTXRWRmhoMGlhN0lEUVBCUVZrQUtpZFVDZW4rY3h5blJxY3ljV2Z4L2dF?=
 =?utf-8?B?L1NuQk0vTnRjeHpKbCtPekdsam1rbkg0S3VPVlgrSFZNUVFuSGNrSmk4MUdB?=
 =?utf-8?B?RFQ1UE1OV1VvWExMY0MrdDB3WTJXVmhGRXZKUzBHQnJicVpUdTc0WEcvb2dx?=
 =?utf-8?B?NUl5TnhkQlRNVnZmMElZbW5wSkRXOEQ1U1FWZkRlbGlyNnhQc2ZxbGpadVYw?=
 =?utf-8?B?MnpyUUNSbVhmN1diWVI0bmxKU3RvWWlzTnExVGhseVhza1VEdU5ERVpmY28r?=
 =?utf-8?B?Uy9HUlVWbzQ0TDVtdE1DaVJ6d1hSYXBvZDZSV0U5MjJFcXJHaGtpbkU5YzB4?=
 =?utf-8?B?U2FIQ25lSXJmYlpSWlVmZGVDTEVXM3o5ak1kSndSL1RSYTlMK3RCSGlPN0hu?=
 =?utf-8?B?aGRwdE95MWxHSVozbHdLMExHd1NDZW5aS0JuZFB1blJuUmpZekZGb3hWVGVF?=
 =?utf-8?B?aEJBc2tyOWhHZWovQitpVElmZUw1TFFNajN1WFMvVlJRMHhYUDJzZ2lFRDJG?=
 =?utf-8?B?emxEY0RJdVVwRkxYUFMva1orWGlSU28wREtaVE9aYWdINDBQcmJhVVFKRVk0?=
 =?utf-8?B?cEovZDA4STlwdUJKaTV1RGpzU0ErK3VJZ081YVR1d1lWZkRJZmxHZDd4TmFO?=
 =?utf-8?B?K3A5WTRjTDJvelRacExIYWxiRDJXL1JCcWRudzlEQmVWREZjYm54RktzZ0ky?=
 =?utf-8?B?U1BNOEF3NVpBSldyaTNsTE5tWlV0czFranA2eFo5RXlOL0tCaHMzWHlXdkpO?=
 =?utf-8?B?eENjRGRzQXYyd0dSL1R2R2pmbnBOcXphb3B1ZDQvc3NFRmdJKzNPSDN6SkEv?=
 =?utf-8?B?WlFUVDkzMG1kR1BrUkgrTzJBL1RXV21udUxwa0NZeFAvOXd4SU5EaWtvWEJQ?=
 =?utf-8?B?YU83QUplWVpTclFadGRQdUk4djdxLyt1MGN5OGlIbHZlYkUyVERLQmFXWE00?=
 =?utf-8?B?V1pnNGlyZXhEcGt6Y0h0TFBSRUFld2l5SVg2bDlmMzZrWmtGR1ZWRU5GTW5O?=
 =?utf-8?B?OXNNUUtzUmRyMC9FT3daZlBwSm1DMWIwM0liUDNnd1h5OGhWczFVaHF4YUZq?=
 =?utf-8?B?NDZ1ejFPK2lqWWZURmxiVjRSMVFSbkJmbVJzaHFaV0RkSDU3YkFEbWVNdWl2?=
 =?utf-8?B?QU5yMDQ4UVo2TGVlOUF1R1pYZzFBOHNZbVJGaC9CUmNLbmxNMjVwdFI2QUI3?=
 =?utf-8?B?OHZEVDM2ZlRxa1lrV0s3MnFHZzcxOUpFSC9sUm1NbFpiNkh6aTdneEZqcXg0?=
 =?utf-8?B?MTRCcVN5a1M3TkJocU52bHIwc0pRTWRUZUxYbEptS1MrejFvMXprMWlueWxH?=
 =?utf-8?B?M1Y1N0lvS0p1THJiZmlLdFROZWgzcHA3QVRtWlp5eDhQWEUrUUtDL3hpbW9X?=
 =?utf-8?B?SERad2JYOXJNKzAxaUR6dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ynk3REFPTDlZZTI5ZmVqbXJJV0xWZ3hIa3V5YzVEbXVGNXVQbjIvMFlrZjJY?=
 =?utf-8?B?RjhBWHR3US9xcW5PTXh1RzVqQysrUW1nVDJ6bGE4MmMwaDdka080ZVFUbTYv?=
 =?utf-8?B?T0JJSFBoVjg2K0NjaHpJR2ZkNlZENEdyNnpQcVhFckdLcTcwT002Wkp5TVhz?=
 =?utf-8?B?VTVKRkw4bkJNaWlKQjNId2RERnErNzdXbmVlVmdCSmZiVU12cjFnMlNlendT?=
 =?utf-8?B?cVZtcFdYRTJRd3lxNGMrSzhzTGRLeEMyS2lQdnFja085eGRidG5xTEs1cUtH?=
 =?utf-8?B?V1R1TXJQVVl3NnZaVnVrY3lCdkVBd2cvT21RMkVCYWkvblU0eExWZkRkd2ZJ?=
 =?utf-8?B?M3F2NDVkZ3F3bnRtY1NJbTlobjh0USttZFlNd1VkUk1GT2MvOWM5U3ltYUdP?=
 =?utf-8?B?S05zd3JhM0JkRXk5Q1d3S2tibUVkdm5kaXhQTmpjL0ZvdHd3SkNjQzF6eW5h?=
 =?utf-8?B?cEZGalA2NHRuWWZnaG1JMVJiTnh1WTJuMml3cmpkNXA4NTVnY0tQKzNmeUtm?=
 =?utf-8?B?RFBES3lDWlFvUXluSDlBTnpNUXlud2J1a1VhWjNTOXZSTXhxV0dFR2F0N3lv?=
 =?utf-8?B?WW9zdzBIMWVybnlXQ2VoWFhVdnBzRDRLcmFsYWUrbmF4Y2hDb1F4QXRTTVNk?=
 =?utf-8?B?WG5QNHpXYmVRSE0xb0k2aWE4NXZEY1ZpTGZzdEFiSXBvSHhOYzZHZWZaRW1Y?=
 =?utf-8?B?MkdWNUhnbS9rSWlxN2d2TUZwZ1RMMnQ2SWt5KzBnOTlidldQOVFmb3NTNTA4?=
 =?utf-8?B?Y3lTemMwU1haQjVJUVBjSHJycHZSSnh0eU85aDdBa0VrUHYzbFI3QTVmd085?=
 =?utf-8?B?TEhsOFpXMWFhNkMydW9RYnduL3JCcFNITXNXVGdsRkNmWHVSNW9tSHdkS2dz?=
 =?utf-8?B?ZXFaY01oUk1iUDNmNDBNSE55WUpadnVzc1VXdU9qVUV6a1BZSFZ2eUVyRWpq?=
 =?utf-8?B?MjdycTVJM1l6d3I5V0RTMkxMcU1WTFVJVDhKNW5PTi9tdEFPdUNiUzBYN2gz?=
 =?utf-8?B?WlY2Q3ptOVhwUlV6ZWNCTVR4ZEd2MVV1c1RjZnZBRXRRbkcxN1FOeGtqVEx3?=
 =?utf-8?B?YldVVW1PR3JNdHduT2FQMEVmbVpnZDJwMjIvejBPVUhPRmZmTjd6V2VaSnBV?=
 =?utf-8?B?ci9ISUt3c1pWaGE4emhGQU9ySWNCd1VCZ0JVamxBMWVNZkZWYkV0T3NxUVlF?=
 =?utf-8?B?ZVQ5ZTNvOXZBWG5teGFVZmJSWGJDTTZCeS9KZW9oMXdEeExiL1YzeDgyK05m?=
 =?utf-8?B?ZTdtMHAwRlE0T2xrZTlndE92Ri9xMzduelJ4aERBcEZ1eGd0ZW5lNkkzUWlZ?=
 =?utf-8?B?Mk8rZFJSYWR0N01oMUlSa2pna1VvUitTMHJ6OUZjUnUvUXpFM2c0U1BXTThN?=
 =?utf-8?B?UlFlTm1lL3ZxdXpkTENNZ2hwOFl3YlJKVkozRVZ3WGsvd045d1ZDRzhoQ1lM?=
 =?utf-8?B?TEVKYTgyUGI1dHdXUTJ6OUdhWHhYQVRmcHdEbHprd3ViVkRtQi9lS1pxaWRr?=
 =?utf-8?B?T1R0NitIR3dYeWpxTFFIZTdPMDBOZzZEYkpjVWEzNUxZYTBBeEgzUXdqVUgy?=
 =?utf-8?B?YnB5Um9qZ1hGZzQ0K21IVmR6YWdEdzRyV00vd3orTWNoZk1yeHA0YUpUaVEy?=
 =?utf-8?B?RTREWXBacS85Y0lmZExjb09YRTlacUhrMTRndEdrcVJoYmtzT3hsTzQvWVJi?=
 =?utf-8?B?eWVrRm4vNXUrbTdpWGFtTExjT2VtZDlsd3dhQ3pKN3RkbjR6eTRXRUxFbjFQ?=
 =?utf-8?B?ZmVtb3FCNnRGczhuV1lRcW1UUE1MUi9VSGtKNU84enVvcm9kM3h0cmkzL0NN?=
 =?utf-8?B?TGZlcnMvUTJoS0I4clZqNWc2cXZTS3NjaVJndE9UM1RTRlhwdHFaUFZwWEpB?=
 =?utf-8?B?cVp4Ull4OFFPL0szVzVrUTdSanNlQkEzS2pkSWxscFpadmVtVnFheWV6aDl5?=
 =?utf-8?B?VjRUS2xnTVg1ckJOZXRHbFNMQVF3K2xGVThJeG1UNUZLV2FFN1NjcnFJNGIx?=
 =?utf-8?B?amt3czJGcE5oaHV5bFRzL2RlbnBVejA4K2Q4SmkvUWZBR0dhandJdTJLbDhJ?=
 =?utf-8?B?RVI0N1hIakN2YVVFeHhDUlpRV2JlL0pSY2NtTlVvb0ZDK1ZjeWN5QUp1cTlV?=
 =?utf-8?Q?bMwEhUbVwunCNn5qwVzhE6y7r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b936f6-2df3-4b50-ddd7-08dcbad50db2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 13:45:40.3880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrYuZdWNGRrmsGHxRTRMUiDfitwdtF+exCNp2U2HWEScLqTqPQ0vpYyyt0lI2/L0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844
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



On 8/12/2024 6:39 PM, Victor Skvortsov wrote:
> VFs do not perform HW fini/suspend in FLR, so the dpm_enabled
> is incorrectly kept enabled. Add interface to disable it in
> virt_pre_reset call.
> 
> v2: Made implementation generic for all asics
> 
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 6 ++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c       | 8 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h       | 1 +
>  drivers/gpu/drm/amd/include/kgd_pp_interface.h | 1 +
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c            | 5 ++++-
>  5 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 29a4adee9286..a6b8d0ba4758 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5289,10 +5289,8 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>  	if (reset_context->reset_req_dev == adev)
>  		job = reset_context->job;
>  
> -	if (amdgpu_sriov_vf(adev)) {
> -		/* stop the data exchange thread */
> -		amdgpu_virt_fini_data_exchange(adev);
> -	}
> +	if (amdgpu_sriov_vf(adev))
> +		amdgpu_virt_pre_reset(adev);
>  
>  	amdgpu_fence_driver_isr_toggle(adev, true);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index b287a82e6177..b6397d3229e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -33,6 +33,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_ras.h"
>  #include "amdgpu_reset.h"
> +#include "amdgpu_dpm.h"
>  #include "vi.h"
>  #include "soc15.h"
>  #include "nv.h"
> @@ -849,6 +850,13 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
>  	return mode;
>  }
>  
> +void amdgpu_virt_pre_reset(struct amdgpu_device *adev)
> +{
> +	/* stop the data exchange thread */
> +	amdgpu_virt_fini_data_exchange(adev);
> +	amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_FLR);
> +}
> +
>  void amdgpu_virt_post_reset(struct amdgpu_device *adev)
>  {
>  	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 3)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index b42a8854dca0..b650a2032c42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -376,6 +376,7 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
>  		      u32 offset, u32 acc_flags, u32 hwip, u32 xcc_id);
>  bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev,
>  			uint32_t ucode_id);
> +void amdgpu_virt_pre_reset(struct amdgpu_device *adev);
>  void amdgpu_virt_post_reset(struct amdgpu_device *adev);
>  bool amdgpu_sriov_xnack_support(struct amdgpu_device *adev);
>  bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 4b20e2274313..19a48d98830a 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -218,6 +218,7 @@ enum pp_mp1_state {
>  	PP_MP1_STATE_SHUTDOWN,
>  	PP_MP1_STATE_UNLOAD,
>  	PP_MP1_STATE_RESET,
> +	PP_MP1_STATE_FLR,
>  };
>  
>  enum pp_df_cstate {
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 8b7d6ed7e2ed..af39206a2c5f 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -168,7 +168,10 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
>  	int ret = 0;
>  	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>  
> -	if (pp_funcs && pp_funcs->set_mp1_state) {
> +	if (amdgpu_sriov_vf(adev) && mp1_state == PP_MP1_STATE_FLR) {
> +		/* VF lost access to SMU */
> +		adev->pm.dpm_enabled = false;

For non-VF devices, PP_MP1_STATE_FLR needs to be a don't care.
Preferrably, something like

if (mp1_state == PP_MP1_STATE_FLR) {
	if (amdgpu_sriov_vf(adev))
		adev->pm.dpm_enabled = false;
}else { ..
}

Thanks,
Lijo

> +	} else if (pp_funcs && pp_funcs->set_mp1_state) {
>  		mutex_lock(&adev->pm.mutex);
>  
>  		ret = pp_funcs->set_mp1_state(
