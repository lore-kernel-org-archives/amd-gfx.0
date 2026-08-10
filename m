Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8697FC5AC82
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 04:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A95BD10E147;
	Mon, 10 Aug 2026 04:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VVULcT0i";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 286F810E147
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 04:30:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRw5qdpbiLGCa4wtBSkMfKCec2aEq3sBZIxKjDAFVxPA49eAgwX4GfTg6N+qlAOtT+M3uPXevKQhKaxwzUg4JGEA0QbEmqnPq4IbeYUSPwDbFosJcQ0EPCAgcw3QmT+JrbvNEKTBbCcJ5OysCif2dbUf5OIHLArvftD4I5p0Yv6p4xGzBREgY9ItE6G54Aeh9XQizIaEL22MxndnnQW0it/JEpqNUamkb1aYsge0l6lXiAhilOdmld1CU0yjBSqg5WS8/CzKi4NHROJIQZwRaM3f1C+OwanzXVSXayVweAlMEWtpOp4xmD8VERWIDVLi3w6RZ/+1n+6Dr9JYBN2xyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z53jjiR6DFejHkb/f13souK+BrKG1fKI8ajO46LMzCQ=;
 b=oCEzhuDgs43uE3D6sF1GXvDY9Yxq5keQdGdNMieenInciIfmgY4DgpAJ+LK5y39yTpyxUORvKqUmz6/7OUtljsbwz1EMzg8iFTIMPqdwEkncHTcRcSP4tKLYw//r7upkGLiIc5fq4sbE3XRmXjIPiO+rC71qb53pPgguxWbNEruQJOk7XeiN/2g5D9F3gCYgmI4pu5IPZ5Z0RRtmn7Z/S2DpWlwvvZpt1s8tAliJBZTwzSo6WcePS8f4rNF1ATpfESoKtu5Kk6AVENfVxSuHKZAoN1oiQrO7PymKUMRrW2Lp8LxzzmrwdRb7Qyyymg7oo3QhPNeFtmy7XLHTbUqYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z53jjiR6DFejHkb/f13souK+BrKG1fKI8ajO46LMzCQ=;
 b=VVULcT0ik4JON1tX4sDJLMaRmIzvP3Ap96ZjPj2HGD/wlZIOk2hfKpGOTwE7e4rUhJZsJ7/eMJKfNUMrNLgcm8jhGuJZ/u7Oi0sQZmKYr38yd0MK3XnT46pvVKUbz1TzITId4/Qmf97NJtTCF7kL65EXMIcXmVAO4UQum91Kj+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH1PPF2D39B31FF.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Mon, 10 Aug
 2026 04:30:30 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 04:30:29 +0000
Message-ID: <6ba037a9-2feb-41fc-b16d-a8019096c927@amd.com>
Date: Mon, 10 Aug 2026 10:00:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Fix uninitialized mp1_fw_flags in
 smu_v15_0_load_microcode
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <error27@gmail.com>
References: <20260810035617.3818797-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260810035617.3818797-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH1PPF2D39B31FF:EE_
X-MS-Office365-Filtering-Correlation-Id: e161795d-5eb8-4e4a-3231-08def6981bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /xF7KSHxVVwpUuco9ee1f7texnoS8p5R+INPPWdZQIpQ+Jm3uCiTt3/sBzXL1TN8eGlTgktJAZHs1+48FMeCE62ikEVY9v7n9ziInp9xufkOYiOZFxIOWJDLGgjQVx8JeRf21pJr2JlDLhM8mSLS6DKpdCcggb/32beFtPu++Y9t2dBUY/XirDwrvabLD+uUoFaScMYQywBx/jcgk2HjknQqES28BB769PmxrthUapGQvuOJjp9/q66G0Mwlz1yxTeFWwMpSGY8pwjZ3q1+orBNOiz1ZD2MW+kEYyV7La2FV5dYafQUqgM9DLY1D7xegrnQk+x7VU99clsS2Rqisa3d3OiWySz7rHzY8uPFE7maszC+BDUdUM3O9KNVKtcTNmI5RWeSQve9IHoETyZ9pQSVnwswPO1xsl+f9bAg7b0U+t50XFzY3VPir2OFPJWtsWfkXVnj8CWH7WddFgaLMQmWbnZOlUlVFZK8Wg66vNDEE7qW3myr8Fob2UqHWro4lmyaHmycoR0d7FecyT2oGSDxI8Ry3LDAegbOmWg8/+O0teYb0td+IvNHKFEYrae8b/CUFmPXwzIun9RFN6HoERKTt0WJznU9iLmTftg+o3uzKodkh5mg3WzAyQn27jE+WPbkEcLc2a9iczT6B2F8ciWzuU2KjS1bnZOcDzi66+Qs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGtUS3NRcmlWelR3L3h6cit3YzRmeGtVQ0dtelpJWVB1eUx5S29NaysyekhC?=
 =?utf-8?B?cWZybTFMU2d4ZWkwMnNxbDlhdzZTQXQwek5KcUFWVGt3SllVTEZ1ZE4wNWl6?=
 =?utf-8?B?VjdGaTNlZzNkb3hsOGpZSnJwSmNJR2VsT1c5NFNNbEtCTkQ1V1o5SzBXVDJL?=
 =?utf-8?B?bUlOdndpd2ZyZk9YSW5Bd1h5bzVveENveWxuTGQ1dkN2U1ViYVFUTlFkL2pJ?=
 =?utf-8?B?WFVzbnlIV2F0b3ovY204L0dpYTExSlBkYTJJc3BYMzY1Z0kvS2hDcVIveWhP?=
 =?utf-8?B?KzNxaFhOU3dSUU83blpRaldwUDhtMkxTcjQ0SXg4bFFNSDlPVkNEQzhQTXIy?=
 =?utf-8?B?bzBHRE5lMnN6VFhRdE9JbVNqcG9naDhrWXZjMHNvbDJYekNjU3VqVXFJVnNX?=
 =?utf-8?B?UXU3eEdPVVFJTFJSMkF5ZzVrWnMrK3ltQkRHSXRaUzV3QWx1TWJ6ak5BaUE1?=
 =?utf-8?B?UzU0ajhOQkpQRU14RFhVZjMyNlJ2a2QrM3hiZjVHWlZXaE9zVlNrc2V4cVBo?=
 =?utf-8?B?WVUrNldEZTJRb1RwOG5yc3c2Um1Wa2VsMFpBN2x0VjJWNnUzamNvbVhaRXNV?=
 =?utf-8?B?OWFFeXBBdUVqb3Y2WGNUZHp4Z1VpdzV2TUFndUxtSnJENU5XMVhpaXpjcXFJ?=
 =?utf-8?B?SFNjOXg3L0l4OTdSc2hGNVhpVTJwb1QxVlJSWTE2ZWRoWTdYd1FjU1N5eC96?=
 =?utf-8?B?NlhPZTExZG0vNjhxOFd2eWFCMm0wSzNuQWFSdGhTMTJuc3JqSWxEcjNGNC9i?=
 =?utf-8?B?VjU5bGNlTGJZN3QyaXVpbDM4SUYrWWxkQ1V5WU93cU95WFRRblArS0h2cW1i?=
 =?utf-8?B?WFc4ZVBXWVVSMERmT1AxeDlqZWpBb0F3MFdzbFRyODdKUlJoZVMzdjFPc2Jv?=
 =?utf-8?B?SENzOUJySHkvMVlXbzc3QUl2Z2tvKzlyRzN3ejJlWFR1TExyclR3V2NZaU50?=
 =?utf-8?B?OHBURm51cThxU3kwTUVFT3drcjRDQkxXUThieVZBK21xNTNmdVRVSkRGdlYz?=
 =?utf-8?B?SFRxQXQ2OFpmenFId3VkR3NuNDkxb1VSUi9PekU0RVNMWmNMNXEzdmw2WmVx?=
 =?utf-8?B?eWE3RHRIbUxmY1VTM2MyOC9vanppOUFVMFhVMStCMnNOdXBYeldheFVLSlRT?=
 =?utf-8?B?dlRMYzhYR29OMVkvSUtBUXhIRlBXNWtmL3RJZTBDWDcwOWF2aUxWNE0veGI1?=
 =?utf-8?B?MEdtOXFxMTVQalEybkVWQ3FaTnluMTN4SElvb204eDRWL2QvZFVnd1BzQ1JJ?=
 =?utf-8?B?ZHM2aUsyVjlWcmFHN2V4clBvODlLVzBSYjRubnRDbTJlZXQwbWpNRlJxOE45?=
 =?utf-8?B?VnA1bU4zOFFjZlRIRFI4Zlc0R0lYQVpjaDFzSTE5d0N6ME50S0NhU3NKQ2NK?=
 =?utf-8?B?ZkVkeFppYjJFM0ZQcEZESjBzTU81S0NzZFhDWkpqWEU3bHJzbkRYcFBpWFF4?=
 =?utf-8?B?dWxPZUF0ZzdNUXhPRkFBdGZ5Zk1XdHRrbWlYWmpwK0pNTERDT2lWbTVrS0JF?=
 =?utf-8?B?N1ZoeVVqZ3hMWm1ZMGpSZk11VGFFV1NoN1J4WkFOTldiWGlUUjFNenNSVzBz?=
 =?utf-8?B?dVd0WVJHeEgxYkZ4djcyWEhYMlNrMVhxb2ZCc0h0Ky9jU0hMcS9wZk1PRFJE?=
 =?utf-8?B?L3ZmVjdOZnc2WXE3aUlvaFhtSCtrUmFzdURscFBvZTVlU2hWQThKRVl5QmIx?=
 =?utf-8?B?dm4wVThQdTNwTzI0WVN6RUdJRGx6bTNDTkJGUGN4Qy94aVdpVkVuM1Y0a0Fw?=
 =?utf-8?B?aTVYWU1DVUtQUHJhSjZVSU8zTE9zbUw3TURJaERSNFR2VEFpcWtReVp6MXgr?=
 =?utf-8?B?NXlPaWtndHBlSEMzTVlub0NFNTZxK3hCVkNvTDcrc1Q3aCtJMHo2aUZwelIx?=
 =?utf-8?B?WlVLNW1sVWdPczZCaVZYOTFMa2R0dFprKzFpbUg0TThQT2NsT21QaC85WkJw?=
 =?utf-8?B?YVFtcWlRbVhrcHMzbGprUzVBOGFJUWRFdXZIVlUwWnA1ZnJKY1ZGZFlaR051?=
 =?utf-8?B?b1lreSt4L21teXQ3TW9FUWx0RFhDcElBaEMrUjIxVERZUkZJVzJGclErZnBy?=
 =?utf-8?B?Q1g2ZThKb2pUd0ZIUnJjVE9YK3BZdHpMT2cvQ09KcG9UYmg0eHVSMEdabzVY?=
 =?utf-8?B?c3pGK1BzMTd4WTk5QWZwRHVLVytSbG1xTjRlM0l3MWRYRzRXQ1NxNmFaalpQ?=
 =?utf-8?B?VkhWL1VRcmwzb002YWgrcDFXZlVSMThZOGEzR3RCVUhweGczeTUrTm1vNlhq?=
 =?utf-8?B?TFgvTXBNL2JCcWFzYUJUZFNPdldTZFVjRkJoMU9HclJkQ2pLMW1SSTh4WU90?=
 =?utf-8?Q?EOec2cIUn3LRo4hZ7+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e161795d-5eb8-4e4a-3231-08def6981bee
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 04:30:29.8449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 279jayZrTE5re+g7oEkjqAXadASda3nJwLU1MTE3lSMWxvyK5sIQqq9HfbFUJtTt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2D39B31FF
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



On 10-Aug-26 9:26 AM, Srinivasan Shanmugam wrote:
> smu_v15_0_load_microcode() polls the MP1 firmware flags register to wait
> for firmware readiness, but only reads the register on APU devices; on
> non-APU paths mp1_fw_flags was left uninitialized before the flag check.
> Initialize it to zero to match the pattern already used in
> smu_v15_0_check_fw_status().
> 
> Fixes: c7fc0f372374 ("drm/amd: Enable SMU 15_0_0 support")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> index 4c0236196de4..f1182305d707 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> @@ -114,7 +114,7 @@ int smu_v15_0_load_microcode(struct smu_context *smu)

This one is also non-functional. Please remove this also.

Thanks,
Lijo

>   	uint32_t addr_start = MP1_SRAM;
>   	uint32_t i;
>   	uint32_t smc_fw_size;
> -	uint32_t mp1_fw_flags;
> +	u32 mp1_fw_flags = 0;
>   
>   	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
>   	src = (const uint32_t *)(adev->pm.fw->data +

