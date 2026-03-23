Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9421D58CD7
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 05:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E22910E054;
	Mon, 23 Mar 2026 05:37:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vU0DjZBF";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6592F10E054
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 05:37:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQGGN1s6i+EiCGkFGLD+dWxPUEUF8lHzKJ4dv6+CSlEbGpOr6DvR9d15XPWeuMCqGb2L7maMyZPcjNbKjRyEh6vvRaOHM+QBUF4oVVWEp4ea+TDPWTnVl2sRTIBr5cF/hqabjQqUYNbYq6hXuUeKxA9Ep4FNyBQ+WxU16M2x1XexilRiQbyFh4RM9NEudKiEb2QhZgk1EdPt7XgeLnWO+AWg5b9MTzos2JvQbsmPkz/S6WYt/+madDlGnwoVuBZe13KvXB30g+37EPGCCKOxpfq9axFSG/CqVVBme0Bq1skuN91CdrKUxy0mnJK8D1Bn51wEqmllA/Y4+sEGpD9OcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F3suYpfgkwQZTj2VgnEWNHBx8w748CkH01F1sxSEL8=;
 b=eRTleghS/tag0a1ScR1c0JxX9+xckof5uvW0uUJAvVynpv+7I4L9qfk/uxRTRuA9Mfjef1WEycWUblF3GzDNgrbeTY0zv7Da3bF8S5o/kSfc2SY9QiJ4irqmWJWWxf2kwTd0aKkA8orYDZL1h/Wn5CuCX8MVflfOKskmmgiWdRLcvf6px5DkMoZJsjHNd/0rg61f84aHezJ39woQnbvYvoNARIYG/eezQoZZgzieBV8gIl0/XFEGUMvk+Gkmnuj2+K7B+oQRik36xGf7Um9iKuEJMSJRBw/W+1QRcqt7D4MVtXyOODJ0jl6qlnEWQzBjW6FvXZjzgeQqrf4zF20t5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F3suYpfgkwQZTj2VgnEWNHBx8w748CkH01F1sxSEL8=;
 b=vU0DjZBFIyKs7paWeor1aLwk5HxMECz72cKbx5+a1rs3jSm/VMcfwxQ6BRyVmhozNwcatPstdRdPmOeViEyRmBhP6fNZC761hmiTaZLolZXzpUGtZCR0z+MxtwHXWZK+9iC+FyMzyAoZvqKjBx/5dgI5InukOk+tnMv3XZYGZQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 05:37:41 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 05:37:41 +0000
Message-ID: <37cba211-07cf-439f-b9a5-27994a85f13c@amd.com>
Date: Mon, 23 Mar 2026 11:07:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amd/pm: Unify version check in SMUv11
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com,
 kevinyang.wang@amd.com
References: <20260320060409.616702-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20260320060409.616702-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 3904578e-0f7e-4f1f-7a00-08de889e4cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: IoNe5rYFHBn50TGD5qqTe2jdQ0bJ++15oB23WecbPThvbU68qNMEqJMIxqYfmT3NOjk1UoWEYy2QYg018bDVTDu5mue0g6lbI1ngm4lWSJDDp0O5qOThQHcLYTG3cZMoqjktgNRSL8sTeeo+t2T9rngKXi52IHzDw+EUHrLWLpd0415Zkli2BSK7juAP2BFD5oqk5ny3Ul0XCJdboKMTYGLa2hTKOIwLpA+WcdZ+Wa+IxW84wdApDH/l47n/+y6lWEcz+bs5lwRWnL/NQg0/gAbdDwdIlMwdIDMrTq0UoqLGuPmU7u/xQ+86BbKVDLYXxsSqM/fWqD6WiFGkKIpYjam3bWdKRkKzbAyTkcq9rK0g7jFh2FqVWFRpZkLsy2uNI9nYzOh2PVnGwB37hcTxpxHhSYk8IGz66B/N5cgyrIbhpx0z8W2CGwSWGDi6uvt5A2glCKsUVqtYKU+CZpISx5lJZeYP7y5maNhoTp4noeeYjONdudZtrjVhaP6wfwx+9ZD1/qWJ2fc1I1gu8hP7PToSJ17ltngIqH3gLzKJhY9gyToy+tdkkxkHjV1SXJZcDee3JRpMMClunH18wbHEMmcAQDiWcZ70qerUNR7oFyN9ZtWpza//YYtRlCO4o0jKw1RhLFjxeXgFHaoC4YeQ6Nk8b9U3hLLuemqdzR+g5Au82CoSQCgBOtEqe1m8IdV5/Mnpg/uTTIzKFuK18YT4bCuxYLfVJB49T78Q3Id9Irk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjY3bzF1VmZFeTcrczJJNTVTTjZiN3ZUZTNtM0twSitFYWlzRE1TZTkyL3dY?=
 =?utf-8?B?M1BTdCtLV2luZWJwT2c1UFpJWmVDMlM1eWJxWmt5SDc3UG1EdmlvVjJ4Ry91?=
 =?utf-8?B?NWVYWUd5bmVkUVBiV3NVTXNmZmhGMTF4VDB2QWx3N1N2ZEJ0S3J6dnA4Rkp1?=
 =?utf-8?B?WjRCZXltckxTRlZ4aWxmNmV2Y0xCZnFEU1ZhVmdxQ1lBNG1lck9QNUVYZlVV?=
 =?utf-8?B?aWFFMXY4Wmw5eWlGVDNCeGd2R1N2Wm95OGtsRUFZYk1rQjdTUThwY2ptall0?=
 =?utf-8?B?TDMxajFwVXl4ZG4wSDdpeG01S2E2eDQyUkM5clR4Sm9wTDRaNGRFWmQzSnNw?=
 =?utf-8?B?SEtUbFdIeVhtb0ZVSUI1anl5d0tBbllVM2d1TmcrRForZVovekw3c0xtcGFl?=
 =?utf-8?B?Rmx1THhwYlVUL1JBakJyb2hLRFdhc1B5aEtUWXFzSnR1RkM0TFp3S3ZLQ1Bq?=
 =?utf-8?B?VkJLYWwramRkeXpyQWJaMlkzczN6MTkyck5tZFZxNFMxa2U4UXk3VzZpWkdy?=
 =?utf-8?B?cGR0WFRiaWZOV2NybjczTWR0NFVRSUhiWXJXbml3RHBJVUphcnB5YTdDQXhM?=
 =?utf-8?B?STlnMDArTVJYOUw0NHJSTlQyMjNNNXZtNVVYQmNKaFFPWkdab1N0NGE5YkJR?=
 =?utf-8?B?VVVTaWlPazdjVll4TGxCbDh4V2FYcENGdHZZTnFLRkhsUmFFSU9VRHU3VC9x?=
 =?utf-8?B?KysrMXZSZVNRemU4Mi9vMzhPTWdZSW91ME5GRndoaWluWXZhOWpyRFY1MWdh?=
 =?utf-8?B?cVF4Nm1zVzVmZTZHZFhiRHYvalRmWUxLdGZoRkE2WFgrWS8wSEtqMm9QeWts?=
 =?utf-8?B?SVBSbWdyaG9PODZwVURxaWhJMWkzeHl1Q292M25FUjRIREh4d2RaNTJKbUFE?=
 =?utf-8?B?VFFLNU9NZm9OT3VYR0Z5ajNUdTFNR0dpbVUxUlFyTCtuWWw1WGQ4TUlKV1BO?=
 =?utf-8?B?L2g4UDVqTnRzMWVRU0dEMzBuY2t4bkJCK21zTlJJR2pjenU3OUpQMm11SUdW?=
 =?utf-8?B?SzV0WFh0WlBLSG9MNElpSjVFUFRvd2hNeGZrR0FYZ05PbFZqMFhqdnM4V0VI?=
 =?utf-8?B?ekVWTTRDc24rZytKaU1mSTI2Y1JEZC9waElab2Z5YU9yb3BYSU5hVnVLVzZp?=
 =?utf-8?B?QWcrQUZpejVxY1h2MzJXa1F6bXZib083eU5hbU5vTXRSbXVLTEdlK3FkREZp?=
 =?utf-8?B?OWZ5OUo0cWFYVUFKeElGaXBrRm9UNDUzYTlTUy80c3I4M2lwb0pYMEE1Y2FU?=
 =?utf-8?B?VDRGcVpnZ0lhcWxiSFJpN2gvUXQzVy9DeDZpUFJ2S25RZi9GUlI4TjZzRFk4?=
 =?utf-8?B?UWxLUkp1N0pvcUFnZktlWkNMWjdGV1cxclJ1U0RsUkh4dGppRk5VdEo2Ym44?=
 =?utf-8?B?MUJxZnFTWFdiUS8za2FZUnZzcUlxTnF5V1dRalo0RjlKZWJtUlJtdGYzdHVP?=
 =?utf-8?B?OG56WTFkN3NMZXE1MjkrajY5RFhkV1FkbER1T2c1OWVYYWFDSW5TT1NFUVZn?=
 =?utf-8?B?UG9jNHh0ZmRTQUZheGt6ZWdFd1JLbDJYTkZLTStQbUtRdGhoaTBUU0pOQ1Nm?=
 =?utf-8?B?ZHFmR241K1VoeEVUOVZCNUxBUHJIQXJoREdlc3RQLzdBTHM0aXUxWC9RR2hz?=
 =?utf-8?B?VW5nYW13eGdBSTJJakhTZ2tlbnJyTnlSR2tuSnVQRGNXRCtWSnZUUVlmdTdz?=
 =?utf-8?B?dFo1c29WV3dVWHRDemV2d1VGMG1OeFVFblFub3Vwbks4WU9TTmxuTHV5VThj?=
 =?utf-8?B?YVI4RHRYUVZQZTVrcjVEUG40RXNJS0J6V29ZRmE0eGZFWkxNSlFUbEtLbm1i?=
 =?utf-8?B?aDE1Z2Y4VUJjOWtkcE1ONHNQUnM5VWduR09uempCM2RtK0ZOb1I2eGRTQ2J0?=
 =?utf-8?B?NHV3MjVGaE1ubEZxWTI3M2cvRHcwRnFTNklDd01yUHlQNWJobXVwSkZTb0ta?=
 =?utf-8?B?R0JSb1NUZ3h0NGxHc1lCT2RjbTFrTEx6eGZJSG41a09Eck1LT2xVY0M4cXZY?=
 =?utf-8?B?UDNVRTJvNFMrbytMa1lIMy9RdG1EUElBelQzU2JucmZWMERtdWZPUno4NzFR?=
 =?utf-8?B?cVFaa1VIa2taWjRqa25HQWdRZkxJSGF2VjBjZEwvZ2gvRWpwM1NsUHBpTmxm?=
 =?utf-8?B?ZFl5b1g4TUxrMEZLYlZ3SXE5b2V1Mk55Z0t4WEhEZUxyTTJoWTBXL1AwZ2dO?=
 =?utf-8?B?bFErVVZhb1lkL0R2aUY3SlEvR08zVmttMFpZZXQxbVNwMkM2ZG42N1UyQUc3?=
 =?utf-8?B?QXJkVjZiZGRhcTlvTWVRZ0JBOGNqSUczdGU1TFpsODA4ZHVDYWt4Q3FKTmxO?=
 =?utf-8?B?ZFNmOFRlbUR6dFBZUlJmSTdBZzdqWXlZNjVFSG5qOXhOMnpwdGc5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3904578e-0f7e-4f1f-7a00-08de889e4cff
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 05:37:41.6291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CdBGHzXuv0iQOdaLAbuINoh4o33AXKRcIjwARvM61pi563GoqSeDNAWJlLOjVhM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223
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

<ping>

On 20-Mar-26 11:34 AM, Lijo Lazar wrote:
> Use common helper function for firmware version check and logging in
> SMUv11
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  | 14 ----
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  5 +-
>   .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  3 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 21 +++++-
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 25 ++++++-
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 75 -------------------
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  3 +-
>   7 files changed, 52 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> index 7c1701ed3e11..dd94e8a9e218 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> @@ -25,18 +25,6 @@
>   
>   #include "amdgpu_smu.h"
>   
> -#define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
> -#define SMU11_DRIVER_IF_VERSION_ARCT 0x17
> -#define SMU11_DRIVER_IF_VERSION_NV10 0x37
> -#define SMU11_DRIVER_IF_VERSION_NV12 0x38
> -#define SMU11_DRIVER_IF_VERSION_NV14 0x38
> -#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x40
> -#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xE
> -#define SMU11_DRIVER_IF_VERSION_VANGOGH 0x03
> -#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
> -#define SMU11_DRIVER_IF_VERSION_Beige_Goby 0xD
> -#define SMU11_DRIVER_IF_VERSION_Cyan_Skillfish 0x8
> -
>   /* MP Apertures */
>   #define MP0_Public			0x03800000
>   #define MP0_SRAM			0x03900000
> @@ -148,8 +136,6 @@ int smu_v11_0_setup_pptable(struct smu_context *smu);
>   
>   int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu);
>   
> -int smu_v11_0_check_fw_version(struct smu_context *smu);
> -
>   int smu_v11_0_set_driver_table_location(struct smu_context *smu);
>   
>   int smu_v11_0_set_tool_table_location(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 0c4afd1e1aab..d73c3c191e9c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -65,6 +65,8 @@
>   #define SMU_FEATURES_HIGH_MASK       0xFFFFFFFF00000000
>   #define SMU_FEATURES_HIGH_SHIFT      32
>   
> +#define SMU11_DRIVER_IF_VERSION_ARCT 0x17
> +
>   static const struct smu_feature_bits arcturus_dpm_features = {
>   	.bits = { SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
>   		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
> @@ -1906,7 +1908,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>   	/* pptable related */
>   	.setup_pptable = arcturus_setup_pptable,
>   	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
> -	.check_fw_version = smu_v11_0_check_fw_version,
> +	.check_fw_version = smu_cmn_check_fw_version,
>   	.write_pptable = smu_cmn_write_pptable,
>   	.set_driver_table_location = smu_v11_0_set_driver_table_location,
>   	.set_tool_table_location = smu_v11_0_set_tool_table_location,
> @@ -1959,5 +1961,6 @@ void arcturus_set_ppt_funcs(struct smu_context *smu)
>   	smu->table_map = arcturus_table_map;
>   	smu->pwr_src_map = arcturus_pwr_src_map;
>   	smu->workload_map = arcturus_workload_map;
> +	smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_ARCT;
>   	smu_v11_0_init_msg_ctl(smu, arcturus_message_map);
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> index 87953a4d0a43..1cc26cc79454 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> @@ -582,7 +582,7 @@ cyan_skillfish_get_enabled_mask(struct smu_context *smu,
>   static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
>   
>   	.check_fw_status = smu_v11_0_check_fw_status,
> -	.check_fw_version = smu_v11_0_check_fw_version,
> +	.check_fw_version = smu_cmn_check_fw_version,
>   	.init_power = smu_v11_0_init_power,
>   	.fini_power = smu_v11_0_fini_power,
>   	.init_smc_tables = cyan_skillfish_init_smc_tables,
> @@ -605,5 +605,6 @@ void cyan_skillfish_set_ppt_funcs(struct smu_context *smu)
>   	smu->ppt_funcs = &cyan_skillfish_ppt_funcs;
>   	smu->table_map = cyan_skillfish_table_map;
>   	smu->is_apu = true;
> +	smu->smc_driver_if_version = MP1_DRIVER_IF_VERSION;
>   	smu_v11_0_init_msg_ctl(smu, cyan_skillfish_message_map);
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 737bfdfb814c..f2ce8de58cb9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -73,6 +73,10 @@ static const struct smu_feature_bits navi10_dpm_features = {
>   
>   #define SMU_11_0_GFX_BUSY_THRESHOLD 15
>   
> +#define SMU11_DRIVER_IF_VERSION_NV10  0x37
> +#define SMU11_DRIVER_IF_VERSION_NV12  0x38
> +#define SMU11_DRIVER_IF_VERSION_NV14  0x38
> +
>   static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
>   	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,			1),
>   	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,		1),
> @@ -3310,7 +3314,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>   	.check_fw_status = smu_v11_0_check_fw_status,
>   	.setup_pptable = navi10_setup_pptable,
>   	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
> -	.check_fw_version = smu_v11_0_check_fw_version,
> +	.check_fw_version = smu_cmn_check_fw_version,
>   	.write_pptable = smu_cmn_write_pptable,
>   	.set_driver_table_location = smu_v11_0_set_driver_table_location,
>   	.set_tool_table_location = smu_v11_0_set_tool_table_location,
> @@ -3363,11 +3367,26 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>   
>   void navi10_set_ppt_funcs(struct smu_context *smu)
>   {
> +	struct amdgpu_device *adev = smu->adev;
> +
>   	smu->ppt_funcs = &navi10_ppt_funcs;
>   	smu->clock_map = navi10_clk_map;
>   	smu->feature_map = navi10_feature_mask_map;
>   	smu->table_map = navi10_table_map;
>   	smu->pwr_src_map = navi10_pwr_src_map;
>   	smu->workload_map = navi10_workload_map;
> +
> +	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> +	case IP_VERSION(11, 0, 0):
> +		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV10;
> +		break;
> +	case IP_VERSION(11, 0, 9):
> +		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV12;
> +		break;
> +	case IP_VERSION(11, 0, 5):
> +		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV14;
> +		break;
> +	}
> +
>   	smu_v11_0_init_msg_ctl(smu, navi10_message_map);
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 6268bc5ed3e6..68255cfcb04d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3120,7 +3120,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>   	.check_fw_status = smu_v11_0_check_fw_status,
>   	.setup_pptable = sienna_cichlid_setup_pptable,
>   	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
> -	.check_fw_version = smu_v11_0_check_fw_version,
> +	.check_fw_version = smu_cmn_check_fw_version,
>   	.write_pptable = smu_cmn_write_pptable,
>   	.set_driver_table_location = smu_v11_0_set_driver_table_location,
>   	.set_tool_table_location = smu_v11_0_set_tool_table_location,
> @@ -3177,13 +3177,36 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>   	.mode2_reset = sienna_cichlid_mode2_reset,
>   };
>   
> +#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid  0x40
> +#define SMU11_DRIVER_IF_VERSION_Navy_Flounder   0xE
> +#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
> +#define SMU11_DRIVER_IF_VERSION_Beige_Goby      0xD
> +
>   void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
>   {
> +	struct amdgpu_device *adev = smu->adev;
> +
>   	smu->ppt_funcs = &sienna_cichlid_ppt_funcs;
>   	smu->clock_map = sienna_cichlid_clk_map;
>   	smu->feature_map = sienna_cichlid_feature_mask_map;
>   	smu->table_map = sienna_cichlid_table_map;
>   	smu->pwr_src_map = sienna_cichlid_pwr_src_map;
>   	smu->workload_map = sienna_cichlid_workload_map;
> +
> +	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> +	case IP_VERSION(11, 0, 7):
> +		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Sienna_Cichlid;
> +		break;
> +	case IP_VERSION(11, 0, 11):
> +		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Navy_Flounder;
> +		break;
> +	case IP_VERSION(11, 0, 12):
> +		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish;
> +		break;
> +	case IP_VERSION(11, 0, 13):
> +		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Beige_Goby;
> +		break;
> +	}
> +
>   	smu_v11_0_init_msg_ctl(smu, sienna_cichlid_message_map);
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 1eec1a88e05f..98e7109bbc95 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -192,81 +192,6 @@ int smu_v11_0_check_fw_status(struct smu_context *smu)
>   	return -EIO;
>   }
>   
> -int smu_v11_0_check_fw_version(struct smu_context *smu)
> -{
> -	struct amdgpu_device *adev = smu->adev;
> -	uint32_t if_version = 0xff, smu_version = 0xff;
> -	uint8_t smu_program, smu_major, smu_minor, smu_debug;
> -	int ret = 0;
> -
> -	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
> -	if (ret)
> -		return ret;
> -
> -	smu_program = (smu_version >> 24) & 0xff;
> -	smu_major = (smu_version >> 16) & 0xff;
> -	smu_minor = (smu_version >> 8) & 0xff;
> -	smu_debug = (smu_version >> 0) & 0xff;
> -	if (smu->is_apu)
> -		adev->pm.fw_version = smu_version;
> -
> -	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> -	case IP_VERSION(11, 0, 0):
> -		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV10;
> -		break;
> -	case IP_VERSION(11, 0, 9):
> -		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV12;
> -		break;
> -	case IP_VERSION(11, 0, 5):
> -		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV14;
> -		break;
> -	case IP_VERSION(11, 0, 7):
> -		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Sienna_Cichlid;
> -		break;
> -	case IP_VERSION(11, 0, 11):
> -		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Navy_Flounder;
> -		break;
> -	case IP_VERSION(11, 5, 0):
> -	case IP_VERSION(11, 5, 2):
> -		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_VANGOGH;
> -		break;
> -	case IP_VERSION(11, 0, 12):
> -		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish;
> -		break;
> -	case IP_VERSION(11, 0, 13):
> -		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Beige_Goby;
> -		break;
> -	case IP_VERSION(11, 0, 8):
> -		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Cyan_Skillfish;
> -		break;
> -	case IP_VERSION(11, 0, 2):
> -		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_ARCT;
> -		break;
> -	default:
> -		dev_err(smu->adev->dev, "smu unsupported IP version: 0x%x.\n",
> -			amdgpu_ip_version(adev, MP1_HWIP, 0));
> -		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_INV;
> -		break;
> -	}
> -
> -	/*
> -	 * 1. if_version mismatch is not critical as our fw is designed
> -	 * to be backward compatible.
> -	 * 2. New fw usually brings some optimizations. But that's visible
> -	 * only on the paired driver.
> -	 * Considering above, we just leave user a verbal message instead
> -	 * of halt driver loading.
> -	 */
> -	if (if_version != smu->smc_driver_if_version) {
> -		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
> -			"smu fw program = %d, version = 0x%08x (%d.%d.%d)\n",
> -			smu->smc_driver_if_version, if_version,
> -			smu_program, smu_version, smu_major, smu_minor, smu_debug);
> -	}
> -
> -	return ret;
> -}
> -
>   static int smu_v11_0_set_pptable_v2_0(struct smu_context *smu, void **table, uint32_t *size)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 08179840697e..0349c73eb000 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -2512,7 +2512,7 @@ static u32 vangogh_get_gfxoff_entrycount(struct smu_context *smu, uint64_t *entr
>   static const struct pptable_funcs vangogh_ppt_funcs = {
>   
>   	.check_fw_status = smu_v11_0_check_fw_status,
> -	.check_fw_version = smu_v11_0_check_fw_version,
> +	.check_fw_version = smu_cmn_check_fw_version,
>   	.init_smc_tables = vangogh_init_smc_tables,
>   	.fini_smc_tables = smu_v11_0_fini_smc_tables,
>   	.init_power = smu_v11_0_init_power,
> @@ -2562,5 +2562,6 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
>   	smu->table_map = vangogh_table_map;
>   	smu->workload_map = vangogh_workload_map;
>   	smu->is_apu = true;
> +	smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION;
>   	smu_v11_0_init_msg_ctl(smu, vangogh_message_map);
>   }

