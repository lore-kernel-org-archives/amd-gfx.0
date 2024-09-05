Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD77CD4F50
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 04:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607D110E41E;
	Thu,  5 Sep 2024 04:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gPpGIeWS";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E19210E41E
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 04:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj0ZW0HCvBvq9lBtEa1K0srr3cr649Z+LdE6/CwAbWSILHs6FjBB6sGsCTUFkdsVNL90lAR2UdUtmbAdYhZyxfrEYbEkPEoqQ6kR0/dJwYFNFEDrGjxashsWChe4vgtsmNqrSChY43YVXYbecANvSwphOYSVJaLD+30uSgRks47IMHLXjih2tlg2VNNiClms7+67tbtT9m2WV4QLah/u//A9Ilpio0+UJBilF/3BzfZI4D8YRgsEWkJnPfwsQgNr90to+N88fGCowu28C722BpfjBs34yVZ35mN6W2hoprcyDUP+q4C7OvLV/rhq8O80rBdYbHadtU5DwlgNeAyKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Whgb5wnzcPTpNBS6JbEO2Uzm2G5alqJc9oM1GjeavnA=;
 b=T4l3SY4uSj2Epvn8ESoNQY9n3LXNC/QwHQf9b4fmGdw1xta9+OQM8+GqoCUEJ0AaNWki3hY1/dKzOq6eZJ2QoCgv8pBYO1REMPOVzaYBbtAXXGt6icw3A28q9TNaxnZC8MUkUJs1UVoESBtvl2HyjhAI2vb8Ap8b9aThUbZSlKUr04w72y2PW2ABnZpoWiXpgfQIjl8AJiiLghzvz1Z8FA4iHnBYUSkAVwu8RzIiqDy0rj2UcxBmIzNNh0P3GOdlNFpLe+P3o8B0WIqZ2U7Je3VylGbfoCKx4cIOSu76iahh7YSLt33B0zoV7g1ALYTYLN4JWCAhAp+HgmTO0Oxtaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Whgb5wnzcPTpNBS6JbEO2Uzm2G5alqJc9oM1GjeavnA=;
 b=gPpGIeWSvJGeeSXI6U98tr0U/IcZV/w4SfE4qwukJyi0T8oStHgl2WoQV8WNe35RMj3KXv+7sci+19BX2cFHQ+lcCLUsi1amtr62bpGPf4onS1/zkV+4s4y9a1CuhEkzCOvRi9At10WRnoL/FvaAv213LzrEfAttr+aHOBp+0OA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 04:46:12 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 04:46:12 +0000
Message-ID: <80048050-51df-45ee-a463-09b77a8111d6@amd.com>
Date: Thu, 5 Sep 2024 10:16:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/gfx9: Refactor cleaner shader
 initialization for GFX9.4.3
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240904132729.1948224-1-srinivasan.shanmugam@amd.com>
 <20240904132729.1948224-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240904132729.1948224-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV3PR12MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: df4ae33d-bd2b-4231-2938-08dccd65aaaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VE5WZnU2cXByd1lGSEhrb2ViRC9GN1pWa21zODZkTGNjckVqaGdwTk1ZSm41?=
 =?utf-8?B?UTI4RHpmNS9DdHg5aWJVdWJUZjJ3ZWFTd012aWNyTGNaV2VsRmRHSlJYQmsx?=
 =?utf-8?B?VXlITWxXSWpPbzF3dFkrbWVkeHBrN2ZVMHc2b1lqcVdrR2JKdWFabXVlRjVp?=
 =?utf-8?B?SEVaV0dqa0NWMENtclhWSDZ5TjBnZ3JYWnVxL01OQ2xqRXZnQ05TL1l3VzlD?=
 =?utf-8?B?SVZYeml6TW5xa2MwSXBkRHFDaTYrUVFBKzVUR2tuYVFiQ2JrK3BDTDdLem8w?=
 =?utf-8?B?NTBGd0F4SG85MWRwcUlGdXU3UFhQalB5MGRNMWRUdzd1cEJianZodG5tampQ?=
 =?utf-8?B?QUZPRG9UeGxvc2l5Q0xFTDJKVTRSaEsxNUxTVkdwM0hlcnNxS01LalNUdmo3?=
 =?utf-8?B?Mmc3VHhLTGIwdmZFUlJPL09iZ1BGRmx3TEllbnBRVDJaQjB2L3Q1Szd5MXpo?=
 =?utf-8?B?Q1lXYTVFaHZESjI1QVNZKzlFT2doUlNrb21wTGdwSFQvOTdIUm9DMVNUZDZ2?=
 =?utf-8?B?d0g2OGdhMkpVTDF0UmttYlhEeTJoMCtLcEZnZDZvYWhyQ3FJY0FvVVdQak9i?=
 =?utf-8?B?cVBsVTJFRFdvYzg4S3J5Y2ZWK3ExdCtXcmM2bTNoU2N3ZEloSzVOVUtOK0E0?=
 =?utf-8?B?cXNrQjByYm5PUm9jTkJBVGdiSW5Pa0ZFUmFmeUh3MUZnRTVGNnI1MjcvbHpW?=
 =?utf-8?B?aWN6YTMyUjhWQm9ENWR3L0tQQWJiemh4NDhKZU54KzZKVVVQVWtvY1lkcmhN?=
 =?utf-8?B?ZjlsSjJ0V2NyK0kvTzFubThiSER2QVdlbHU3SEJRYlFNM2NDUWcvMkV4LzFs?=
 =?utf-8?B?azNWRFB2eTl0bUd4emwyOWRxNlBCV0lPeFdTdHVNOEt3RDRiTlJlMVVMUUJL?=
 =?utf-8?B?c1J5VFFPMXg5RVZVS1JHVUZQSTMxc1ltdEVxalhsSHlXVTJRK0lNb28wU0hD?=
 =?utf-8?B?NkpQT0NJbTdtQU0yMGNlblAvVE9YM2hWUGV0akpzR25qREQ2cXF5STFhT0Zl?=
 =?utf-8?B?YUJISnhQdHJDTk5JRU12SVRyS1BUdVh4WHlCWHowbjlUdm5VRUJ2dkIxeEJy?=
 =?utf-8?B?QXFPVC9DRjRQaHA2Y1ZLZEdCc3c3M1pKT0RReE5sQ2s3THpGZUlXM0NMUUpB?=
 =?utf-8?B?REpHMS95RzdLOEFJVUxCcjNHYzJYZWNrSHJtSlVodVlTdytuajBwWFVGYWVm?=
 =?utf-8?B?eThLbGZSVWpqUXJpRHVjK0hhNzRYQnJaWUl5QXZIUXlMM2dPZC9CRDZkSkl4?=
 =?utf-8?B?M3kxYlhpRkZIN3R3eTVQbjRWMmliekZ6VnMzejAxQ1pLWnY1N3FNMVpHeEpq?=
 =?utf-8?B?cDloNU9wUVdTUGhFMzQvblk5TnFHS1lMdkxldWRucG1IM2NVM1dXNExYS0Nv?=
 =?utf-8?B?NzJtMGJmYWhGUmNZV2pOUlNaMWNJV0pJTlJ6YWI4SmNhQmFqdmR0QVV3d0p6?=
 =?utf-8?B?WDFCQm1Hd0JvNUNsb01mT2gwOTB3ck92cmRoZWlOeVZUOUlEbTYvc09ScjJD?=
 =?utf-8?B?aFZVZkxkbEdGb05DYkhQaUo4a1hCOVlqcmdHekVuSXRDbEloNWNjcGpjbGVj?=
 =?utf-8?B?YWZvZDBLYmV6QWlLYTc1K0lNNWVqZ25adDdJaXZFSmlJSnJManJzUmc1eUFI?=
 =?utf-8?B?S0RJcGtRbzhieE5BYnJZcGVnWTB3MFRNblJ0WDVvaktVQkJrOThKUFNEMERH?=
 =?utf-8?B?TTJOQkNuMVVPQk5KKy9qa1pyVWxla1Y0RFJlMEdvdjlNZndtSVJBNXc1dStI?=
 =?utf-8?B?d3phZ1JlNWk1U0ZaTU5UenFGMFp5MUxiblZQMGZ1WklkKytieVZFY2NWY21q?=
 =?utf-8?B?Vmtsa29WcHJWN0ErTzNPUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUZ2M1ZtdFEvS1h1aU80Wnl6WGwwdW1hazk5U0g5VENwbEpWTlN5aGc2MWhn?=
 =?utf-8?B?VWRqb2Noc0VwUmdYT1pZYjc4bmw4VzJVVGlHbUt1MEJSSVp0YmNKZk5qcjhF?=
 =?utf-8?B?MFZmVFN5UjRCclVFZUcyQXJYRnE2bnRqNjdUdTh5eUJqdkc4T3d6M3h1dnRr?=
 =?utf-8?B?OVNKYWNIZzlaQnZuQXY3L2MvZlRreW5yZ2k4V2VOeDlWTXNqSjlmSkY1OVhG?=
 =?utf-8?B?VHJuanh0NWthVFFta0xCNGZnQmEvWUk2Nk80aUVJS1JOQXJHRm5IdWxQNmVT?=
 =?utf-8?B?Q2VyVUw5TVRSNVdDYjc1bk5DR0JnK1o0dGowZnAxbzh4WU5yeGU2dmVDNmJh?=
 =?utf-8?B?ZmJEN2VFb2xwQTljdHFsMnJYOXFJRjlnTitFN2FlZ1dIMFY3T2sraGZTa2dQ?=
 =?utf-8?B?TVNMaDhBMFVXdW5IaEI3N0QyblQzVm5TdThMa3VzNEE3MjVUdW1rZU1zOG5u?=
 =?utf-8?B?LzcwVXl1dzJiTis2cDhEMTVRRWNlOVM4SlNRY0F4b1c1YlRyekxLTGh4eUov?=
 =?utf-8?B?TExMOXNOSXVkTlJtbDRUdXZzNjFuSTlVaUE4MTQwOEJ6MjY0bW9KWG91Ti9M?=
 =?utf-8?B?VjBDT0o3eW9XYVRQNS9ycHF4RTRseHErS1VxYm13S1NraHhzSHd2S25xbDZq?=
 =?utf-8?B?QU9hVE94cEtCaG5MVGV5dHhxdDBxRnJYYUw4eEthRFhuU0I1QVNuUkJOeHQv?=
 =?utf-8?B?Y0xJL2txV3VEMkQ3dnJTaDRsQk9YVkc3ZGtlNjVBcHRjeDlwU1VTVUI5SDNK?=
 =?utf-8?B?MzVRNGVEM3JtYlZibzd0dEpQMFBYUy8wWTBoK010bzNNdFZnWjhPQ0l2TUsx?=
 =?utf-8?B?N3dxSTFDdWUvdzlmNk41d2dqNDlNR3RLUzJreXV4aHMzZENtOWFwYUJIMWxy?=
 =?utf-8?B?dEc2ekc2SWNWYzNONTFHeVNzSFVBQ2Vkc0hTUFFPS2JyUkJRM1VhY2lTS0Q5?=
 =?utf-8?B?MkxkV0pSbFlPSFJycStYYkVtbDA5dmdqMjlOUHJXMDF3WitHbWhnN29pUjhF?=
 =?utf-8?B?ZE5IdHBiRWd5aWZEZzJuOWxFOG9MTmw1aVo2TVBSdHdKQmhjWVd0UFlyZGR3?=
 =?utf-8?B?WjJZWUJJWDh0QnVGTWRKUkMxMUN0R3gwVTU2eEhyRjhIYWxiMVhpbGpKS3Y4?=
 =?utf-8?B?eFd2VGlMRGVGanAwNGQzd3J3MkZlaGorMEhaSFpjb1FBZ0x2RHkxc082UU5E?=
 =?utf-8?B?WXhtUVdYelpLWHZJREQxcGFwTGZGRUZNSEo0enNsYnZaa3I4QzJLclhScGxM?=
 =?utf-8?B?aWJhY2xhbmtGTlBBN0hNWVIzZTB0dUlTRDMyU3VBeldndnBFNWNUTUwyOEJ4?=
 =?utf-8?B?U0RGMkErb1YxVXFRcm4vWThjUU45MTc3b1QxanA2RFVEOHNMaTRTZjRGVktK?=
 =?utf-8?B?R2VDck44MUNwVXY5eWdwRkEzOGtpa1AxRUxvQm02dEsrWFZpQ3k3M0VWWnRR?=
 =?utf-8?B?SUl2OWJaV09qZ3dJSWEzclBPcFk0b1VSNnhtMXl6dlZ0SGRQV2VWMm82aG16?=
 =?utf-8?B?d2RMQUxtL1NlM2FVNnlUT1ErdU9DeEVObVJYUThNQytvU1I0ZW4vRTlISjA1?=
 =?utf-8?B?UWl4U1Y2eEhHd3pYZDJQOGxuSllvN3paTUkrV0VjRGhhb0h0cHJLT3VBbjBT?=
 =?utf-8?B?OVNUdUdEM0g3U0N3eXQwK25HaVByZFdQK3hHUHFFK2lSdkFCbnNCSldxMUNT?=
 =?utf-8?B?N0pZa3ZrWmxxTWl3elJuZWlTRHE3NmoxeXJwUXIyK1FPb2dZQzZSeFkvVmk1?=
 =?utf-8?B?VkVWWVgxaDNaUEtXaUpQK3l3TTZobzErOXJHS0ozREg0c2pKSVdiS05uTlZI?=
 =?utf-8?B?REtZcFdrdDhxbGF2dDBhQTNzNmErenlWZTVRb1NEMFFJWk9zSys3cHYzVnB4?=
 =?utf-8?B?Nk1FMjhvcnFpNkNuSFYwWU1XL1ZFeGJqdVVJNjRFcS9BWHk3OUVScG14WGFw?=
 =?utf-8?B?VkpVaXUwd0FVbGRsajdUUDZlRGk3YXdpS0hzTHk5NC9JWWkyZ283Skt2WUhI?=
 =?utf-8?B?dSsveWlzNnRuK3J5VE5LU0E1WGc0dVRUdkR0WDVzV3EwbFFyRCtPY0gwZVNT?=
 =?utf-8?B?dHNwbnRFVk5yb2xQY1RuYnJTWkgxaHRoM1RTRUVCL3NRZCt5T1ZYc2RCc2Nn?=
 =?utf-8?Q?yfAdRRK99QQqYgFPVLAw2XTEd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4ae33d-bd2b-4231-2938-08dccd65aaaf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 04:46:12.2194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vLKNa/xk9EM3w1Fsx8vD/bXR74LROtWNhBkucUo4d+0+C/Yf8HTr2orYMY0O+vo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235
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



On 9/4/2024 6:57 PM, Srinivasan Shanmugam wrote:
> This commit modifies the initialization only if the cleaner shader
> object has been allocated. This is done by adding checks for
> adev->gfx.cleaner_shader_obj before calling
> amdgpu_gfx_cleaner_shader_init
> 
> The changes are made in the gfx_v9_4_3_sw_init, gfx_v9_4_3_sw_fini, and
> gfx_v9_4_3_hw_init functions. These functions are responsible for
> initializing software components of the GFX v9.4.3 engines.
> 
> This change prevents unnecessary function calls and makes the control
> flow of the program clearer. It also ensures that the cleaner shader is
> only initialized when it has been properly allocated.
> 
> Fixes: 1b66421d29b7 ("drm/amdgpu/gfx9: Implement cleaner shader support for GFX9.4.3 hardware")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 408e5600bb61..abf934863421 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1061,10 +1061,12 @@ static int gfx_v9_4_3_sw_init(void *handle)
>  		adev->gfx.cleaner_shader_size = sizeof(gfx_9_4_3_cleaner_shader_hex);
>  		if (adev->gfx.mec_fw_version >= 153) {

It's better to bring inside this one assignment of shader binary/size

>  			adev->gfx.enable_cleaner_shader = true;
> -			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
> -			if (r) {
> -				adev->gfx.enable_cleaner_shader = false;
> -				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
> +			if (adev->gfx.cleaner_shader_obj) {

Keep this outside and check if a valid shader binary is available (size
! = 0). If so, do a sw_init

> +				r = amdgpu_gfx_cleaner_shader_sw_init(adev);> +				if (r) {
> +					adev->gfx.enable_cleaner_shader = false;

Move this state change inside amdgpu_gfx_cleaner_shader_sw_init such
that cleaner shader API keeps the state - cleaner shader is enabled if a
valid CPU and GPU pointer is available.

Any further calls to cleaner shader API - - ex:
amdgpu_gfx_cleaner_shader_init() - just need to check this state and
take action. Basically, all the checks may be moved inside the cleaner
shader API rather than implementing this at every client interface.

Thanks,
Lijo

> +					dev_err(adev->dev, "Failed to initialize cleaner shader\n");
> +				}
>  			}
>  		}
>  		break;
> @@ -1196,7 +1198,8 @@ static int gfx_v9_4_3_sw_fini(void *handle)
>  		amdgpu_gfx_kiq_fini(adev, i);
>  	}
>  
> -	amdgpu_gfx_cleaner_shader_sw_fini(adev);
> +	if (adev->gfx.cleaner_shader_obj)
> +		amdgpu_gfx_cleaner_shader_sw_fini(adev);
>  
>  	gfx_v9_4_3_mec_fini(adev);
>  	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
> @@ -2344,8 +2347,8 @@ static int gfx_v9_4_3_hw_init(void *handle)
>  	int r;
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
> -	amdgpu_gfx_cleaner_shader_init(adev, adev->gfx.cleaner_shader_size,
> -				       adev->gfx.cleaner_shader_ptr);
> +	if (adev->gfx.cleaner_shader_obj)
> +		amdgpu_gfx_cleaner_shader_init(adev);
>  
>  	if (!amdgpu_sriov_vf(adev))
>  		gfx_v9_4_3_init_golden_registers(adev);
