Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FBCD167F4
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 09:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C33210E869;
	Fri,  9 Jan 2026 09:51:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZjqYyiIn";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C392010E869
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 09:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cahc6ik9orHMR9micDZosJBUb4POFsHMcGi91qbWZeNYQOaz3sxeoRBkZ9XBlPHAg3eTiOjjQ4C+yV39EaU+GliKyPk2V7CUwfuQJ64H3lUGmCjerHC15d9b8NhFZ+eMJS2aPvp2VZbPetszFIJ4bhZFl/pAwrcoGWhiH/wlbPw25iXf+ZIHMHidpGqvBWGG8IDehn7Wem77CNlfbCX2EiYAVy7vx4vFtGixqCWzKffE63OsbBlJQcTrkvLyASQkx+/K19LvwpWfJL6hfuNrtoHF1u9RXyllL18s/yiJC8Z7wPMpvgFzKdX6WV0ihSaTOftF3/fUXdjvZk+47nsrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZdNqOur0qjnX9zdYl7ZFRy3Gg60V5CEcXSI/Pk8QBs=;
 b=VG5bCLGhaNXwFfZl4NRzeo8KQlJOPapC2Ev78pX45kLj2ySTR1RZs5FhPTd+6g6KxL4NyWT2/c2iU93N5GqPXHQ5Uy5BgJXkqqizydCx3iQRszoQ+gjy+qzeqzfEzyk0dgqPDhIGq2BJmWvaENuEasRPHbU6GZ0ilfxqAXDaX4+xIexCcPNHsTrixiYgnRLo+FfntRNASp+khNOIlh4A7JVmAJ+ZKqjxoG5g/MKWQkG30pDN/PYek7RGosyuHzKNXlWSLApp1gkNAC8hYBM57X1/5xzmV7I8js2Zqauye0BMk0Vg+Ol+Yfn2AEmHXEd52Hm8f6v7ibd2vZQedQjuww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZdNqOur0qjnX9zdYl7ZFRy3Gg60V5CEcXSI/Pk8QBs=;
 b=ZjqYyiInuzQGZbkO4NG8G/rrNQTp70eZOFwR5brw3FE3F5DpyM5rEnm+pt5c8d83d/5iz3EIdzReoqx7JjoyX76Z4CBC1y8jokCVZgudqmexGYQBVdaDvrla125pG5oVduObZJpv/IhZm3Jjy7OKd6DAQ76nGqcl9lfRkitnAT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 09:50:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 09:50:58 +0000
Message-ID: <b70697de-602f-4a9e-9190-a5036a7934bc@amd.com>
Date: Fri, 9 Jan 2026 10:50:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling
 Last Fence Update and Timeline Management v4
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250520045410.3404517-1-srinivasan.shanmugam@amd.com>
 <20251211174449.558477-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251211174449.558477-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f25be4-5e1a-4f63-10d0-08de4f6496d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnBvUlF5NkJhcUZhaHdaNjlybTAwWjdGcTZUMVdkTzdwa05peVlmSjlBejcr?=
 =?utf-8?B?UXdHeXk5c2tUYWltRk04bExleXpQTldXSnI3Z3VWa3NCWjlBWXI1RTI3ZWlJ?=
 =?utf-8?B?d3ovMDlJWFlobm13cFA2NGJ5Z01VVEF1UkovRUhVSE5qVDdzNkF1by84ZGZO?=
 =?utf-8?B?eEc2U3RWQjdtUEQvcGhidmRUREdWSWMzU1ZPd05Za2hLSEQ3YUlkTjE5dUpo?=
 =?utf-8?B?c1l4N0MxcGxXK1BaYnBMdFdxa3pLZzZMang5SUorcncyZWN4QkdTT256dDVR?=
 =?utf-8?B?MDZWbVNTWHRFalVnak1rQnBYdmNPeEVWNk0zREZDLzZnUkpDZGl5eUdLSXdz?=
 =?utf-8?B?dVpzM0VPcktHdnpDSysweGZUWkJ6bEMzanBFdFJnYkNYempoc0tESlhwZ0VV?=
 =?utf-8?B?b1NRNjFKaVhUaGNYd3JZeGVxdnZCODBNMDVBdFVhaFRuSmNNT25RU0lyN0VT?=
 =?utf-8?B?UmJVQUp3b0F2SGhIajVYRHp1S0tpVWI3MnlDZ2EzL3c4YkdhV2swT1RCS3Q3?=
 =?utf-8?B?ejJGdUlsVTRsM1l5aHVFVURPRWRNNGdTcE0wUVE0cnp3Vlc4NzlHNGFLYzdG?=
 =?utf-8?B?bTFZNWZFaVNkZmxFL044Q2JHSFVMdS9tOUJOMjBiTlJ3R3NwQWVuWkY2Z0Ri?=
 =?utf-8?B?eVFvVjNESXljRmoyS0R3MU1NUmJJQVdJL0YxOXNITFJ3cTBpemh2UW0rQi9h?=
 =?utf-8?B?bzhLYmM0Zm9SWGNua0YwVUtpb0c3S2pKOHRkMnRMTGFqaEgrNlphSlcrUW1t?=
 =?utf-8?B?UFJwbFB1Y3orK1dIZmErQmo5bSt1N0dTS21VVktVSys4SEJzdFRSR3FwZlFl?=
 =?utf-8?B?ZDNzeGxhd2V0eW55WDh4a1BJdnJTQTVTMlNGV1IrUFo0SFN2U2xzb0phRUJy?=
 =?utf-8?B?V3ltd2RyU3pVZnBTWEI2R0ZTVU1KOXM1MlJKVHJiWTcyMWpIOHVLWlUraGl6?=
 =?utf-8?B?WHVPWEl5M0pVb1hTSysyUlU4RkNXME54b2RQSU9sc05FaDhPSjBGYm5wT1dv?=
 =?utf-8?B?U2VTRnViMC8wa3BmYmtOZW90RDJHemZJbnhhdzJMYjJOWjJtVy9ZdGJncEhB?=
 =?utf-8?B?eFA3dDgyeGZURTQwaUNVN1pVNEhETWROWHcvRUpaejY3Yi9TN0NjWkFOeHNt?=
 =?utf-8?B?ZGxIT0loQm1aTFdEUmZRREpIbE54RDV2Vi94dGxqVGhzY3pIdDJpYVA4UFUr?=
 =?utf-8?B?NDhHdDNqRHlBKzI4QkozOG5FZjFRMnZWRXdkYTJ4ajhvZklPcnRFUGl4eTRO?=
 =?utf-8?B?L0xyU1NTMlRTOUlTd1FWQ09oOEUzeDZDUCtRQ21vMW9McVYyWGFDc3dpcW54?=
 =?utf-8?B?Mk0rR2lRbmtvNGFKTElobGtNaERvRXFtdndaZmRTVDF4akRpQytrMklDSnlU?=
 =?utf-8?B?eDZBYVk4ZGJELzRHRXZ6bVgxaUFPNTBKNkpzR0V2WGtGRjVHSi9Pb3N0eDZI?=
 =?utf-8?B?Tk9sY2JNejY3RDZtbCt1SG4yZ1Y3Vmw2OXZaVndIRm1MY0Fwa0QvSUJzSVRB?=
 =?utf-8?B?QkM5ZlF3eUdsZGlVSG4xNVYvaDkzZUVsTCs1d3FCRGhJZVo5Uy9zMjVPQ3VE?=
 =?utf-8?B?dVpITW83VDBoRXRWQnRHQXp6bm5Dd1ZOOExKUmNmZ3VEZUJHejJzOEYxRWg1?=
 =?utf-8?B?LzQ5bmNYaW5JOEJvZWoyL1VBelFtYjUrRHRMS2RwL0VsY1E4VGloUzlHNEIx?=
 =?utf-8?B?Rmg5cGFGZVI2ZFlzYThyK2hBRFdhZTE5dDRuVFllQVNwSmRMMHEybVNIUHhs?=
 =?utf-8?B?dFJTUmFHMng2L0NDWUlNaTNwT2pmMkR2cnVHK29LcndENnZWQ0VpMWJsZHZE?=
 =?utf-8?B?Ung0L2YyREJDdEhPUzJmdlFxRFJFSENobjFTSU9hSG5WdkgvcUVaTzVXeGli?=
 =?utf-8?B?T1hTdWdXOU1OTXR4T2pJRlJJUCtWd2QxSURwYnNaWHM5N0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnpwYUwrUG9vZVZEekRmZnpNOHNwanEwUll6UkZYN3FwL3NSNHBMMjZZa1h2?=
 =?utf-8?B?SnQ0Mkd0cDB2dktXZVQrU1RUK29mZ0V3T25xYmdGc1lqQUFWSHBFaVVhbzdD?=
 =?utf-8?B?TzBaWk44c2dqcEtwNCtPWENlNVJ2TmM2TXllY3c3ODJLTjd6N3pSc3ZoMW9V?=
 =?utf-8?B?WlVJcnFlK21KRElqVFlEWTZnbHppUHkwcGF2WjJaNStiRUg0U3cxdjZkbmQ3?=
 =?utf-8?B?RExkeUwvbkEwQ2dEUXNDbmNKZm9UdUljQzFUSkNaWHVoQW5VY09jdld4MFJT?=
 =?utf-8?B?ODBWMEo4ZXd6eFY3TFB1cXZqQlJmbUVBUjVnM3k3S0E0RVJXWWdYaEFMZDBl?=
 =?utf-8?B?bE8zTWlqWHdOMVE5ZUxKV0JON3hWenpSeWpyZjNPZ1F6VFhQK1AvL2hKVWVV?=
 =?utf-8?B?U0JlYTVhYW1TZ0dSN3pEZzVTMzV6NjY3akV1dC9UTVlaci9NY0hXcjczVTdE?=
 =?utf-8?B?NXUrWmpqdlNTWTBSa3o3ZHNBR3Z2anVvcEthL05YcW1lT1BUTWxlZXRGWmJp?=
 =?utf-8?B?bFlHYlVxN0Z0LzQ5WFhWV0laWUVCM0kwRm44amRYYXF4WUVOcjRSSzlYc3V6?=
 =?utf-8?B?ck11azlsZ21HWkZmdWJ6UGZ2aHJhbXcwWVc0ejBGc0ZKODFJWTQ4VkVkRTky?=
 =?utf-8?B?OEZtMTh0YkF6dE53R2hRb3Vwc0JUczlvQ2g0UVdXQy90bVMxMUdRMU10TGlq?=
 =?utf-8?B?ZDRYRTRpdDBvYkZIc1Z2czZkemNrb3RkQVQwQ0JtRlJLcTlwMHJXcnl2b0g0?=
 =?utf-8?B?Uk54N0JCWmJoUExsdlAwbHpwd0RJaVY1ajFuWjBnL2M5UjdWUFpGMjIxOUtq?=
 =?utf-8?B?T1lYNlpOOGdib0dJdktxS1lEWkgxMm0vMU5NSXVLVW55Y2luSTdnSXZ4eE5Z?=
 =?utf-8?B?VVgyRTdYMVRubjRHdVJFSnV3Q21aVDA3Z0tSa3AwVGZhN0ZkYmZQUEU5MXd5?=
 =?utf-8?B?cGRzUS9XU0xhMjBIVFNSR0pWOHlwRm1Ra1VtcHRPMWxWa0Y2R1BqdUE4TUNz?=
 =?utf-8?B?UFlhNDBTVEFkeEZJSlFJeU5RV25SN2tuRWNxaWQxS1FSY1h4TXRlTTlCTGJ4?=
 =?utf-8?B?VFZKU0krOGtEellUL0ozREozcGhPemlhRWM5ZnpURDc1TkV0SVZUR0YrVmNj?=
 =?utf-8?B?MS90cU5rcDNUU2JyRHhQTG1SZ3hVaERSTUtkOStSeEl4dEt2dWppZXM4d3I2?=
 =?utf-8?B?SUM1TlZ5QTZHYWFDNDk5d2JlcEkvRHFHdmxRUEhjaFBxNm8rdTcwVEJIendz?=
 =?utf-8?B?bW0zTWlicmIrM2JzQlMzRkFaVFpUa3pld2VFWmM3Zk9uTzg0TDB1NGVJSXJV?=
 =?utf-8?B?eDcwMWtYd0Vva2hUKzU0MHRVOXQzV2c5ZzFuQTdOS3ZsVGNNRXE3TVNJb0sv?=
 =?utf-8?B?UU1KRzVSc0hNVWJlR3pPQVJuUmEwOGRjY1NTMVFGNlZ6dFpyRmZhVUp0aWVh?=
 =?utf-8?B?VXovWEJobGpiZzgwdEx5VFVqZ1kzS3hXaWorZXZqcUJabTVoYTcrQktiYjZF?=
 =?utf-8?B?aG9RcGQxR2pWd0tVbFBCQk44bVFXSlFnOG1mK2hzNXh0SS9vdXdKL0Q5d2hY?=
 =?utf-8?B?VWJPMVowUHhUV3ljUnhKV3pGaUdhNXROL2NIUER3bHY4YUZNMVlOb2lEa0U3?=
 =?utf-8?B?RThtcVFTSU5xYUpkUU1hb3QxMm9ZRzhrR3Q3WnpINFc0NC9SZVRkRkNtam9N?=
 =?utf-8?B?OWZFUUQzZld4MC8wZzROSUlOdDc2Y0J2OHlWeVNiS0JqOE01RFlEUlBBcFlq?=
 =?utf-8?B?U0xuRWlXeHZWR2lTd2ZlYzVtZ3cwZlZUcDBRd2Y4TXRFUjI3S0dMOTAwTk5i?=
 =?utf-8?B?MXdSYko4QklVd1lkbi9ZWGoveXpoMFVSVzl1cjRIalU5ZEhrNWltOWd1Z1ZK?=
 =?utf-8?B?V2t0dGFrNVFkemsrVFpTY0VhMy9qVTQyc1FvOGNHME9tcklHc01KYTRoRjEw?=
 =?utf-8?B?NWR2UnRRcE1MSWtSckxUYjZOWElNUHVYbzFVOFFHRXpmbVRtS1NKa1dkaGhC?=
 =?utf-8?B?TERWNjF3RHJ6ZFhEL1l0bVZjeWZUemNSUzR2bnRySHZFdnFWOFNmZXYxcHNt?=
 =?utf-8?B?NGNTejFDUFNPbGhUdHBsUk1sK0FJQlJ0VW9IRktJdmkwRnF6Z2hKWEZxYXVW?=
 =?utf-8?B?QnAxVjBLMU1XaHlFRkR3NjM5Rmlvc1FUUTM5T2ExUGpYSlVNYldOYVRnbUxp?=
 =?utf-8?B?dmhISzk5WEMyTkRoaXUrVFZtbWJXMlNnSVU0NHNQa2c4QzU4TnJSeWpqRGJq?=
 =?utf-8?B?NEhGWFFxbEx4UlZOVnJmMzB2TTliS25xYWFzWmxGYk9XR2VnYXArbGZSa1Zi?=
 =?utf-8?Q?BFVGmWgygIZ3Jy2AdK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f25be4-5e1a-4f63-10d0-08de4f6496d0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 09:50:58.1159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsXrVMljW9eiCsAFjuAHlUZ/mRYbji5JDA6LqDdTHEnGP4Xhb/v9KjyhCH+42nnt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
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

On 12/11/25 18:44, Srinivasan Shanmugam wrote:
> This commit simplifies the amdgpu_gem_va_ioctl function, key updates
> include:
>  - Moved the logic for managing the last update fence directly into
>    amdgpu_gem_va_update_vm.
>  - Introduced checks for the timeline point to enable conditional
>    replacement or addition of fences.
> 
> v2: Addressed review comments from Christian.
> v3: Updated comments (Christian).
> v4: The previous version selected the fence too early and did not manage
>     its reference correctly, which could lead to stale or freed fences
>     being used. This resulted in refcount underflows and could crash when
>     updating GPU timelines.
>     The fence is now chosen only after the VA mapping work is completed,
>     and its reference is taken safely. After exporting it to the
>     VM timeline syncobj, the driver always drops its local fence reference,
>     ensuring balanced refcounting and avoiding use-after-free on dma_fence.
> 
> 	Crash signature:
> 	[  205.828135] refcount_t: underflow; use-after-free.
> 	[  205.832963] WARNING: CPU: 30 PID: 7274 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110
> 		...
> 	[  206.074014] Call Trace:
> 	[  206.076488]  <TASK>
> 	[  206.078608]  amdgpu_gem_va_ioctl+0x6ea/0x740 [amdgpu]
> 	[  206.084040]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
> 	[  206.089994]  drm_ioctl_kernel+0x86/0xe0 [drm]
> 	[  206.094415]  drm_ioctl+0x26e/0x520 [drm]
> 	[  206.098424]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
> 	[  206.104402]  amdgpu_drm_ioctl+0x4b/0x80 [amdgpu]
> 	[  206.109387]  __x64_sys_ioctl+0x96/0xe0
> 	[  206.113156]  do_syscall_64+0x66/0x2d0
> 		...
> 	[  206.553351] BUG: unable to handle page fault for address: ffffffffc0dfde90
> 		...
> 	[  206.553378] RIP: 0010:dma_fence_signal_timestamp_locked+0x39/0xe0
> 		...
> 	[  206.553405] Call Trace:
> 	[  206.553409]  <IRQ>
> 	[  206.553415]  ? __pfx_drm_sched_fence_free_rcu+0x10/0x10 [gpu_sched]
> 	[  206.553424]  dma_fence_signal+0x30/0x60
> 	[  206.553427]  drm_sched_job_done.isra.0+0x123/0x150 [gpu_sched]
> 	[  206.553434]  dma_fence_signal_timestamp_locked+0x6e/0xe0
> 	[  206.553437]  dma_fence_signal+0x30/0x60
> 	[  206.553441]  amdgpu_fence_process+0xd8/0x150 [amdgpu]
> 	[  206.553854]  sdma_v4_0_process_trap_irq+0x97/0xb0 [amdgpu]
> 	[  206.554353]  edac_mce_amd(E) ee1004(E)
> 	[  206.554270]  amdgpu_irq_dispatch+0x150/0x230 [amdgpu]
> 	[  206.554702]  amdgpu_ih_process+0x6a/0x180 [amdgpu]
> 	[  206.555101]  amdgpu_irq_handler+0x23/0x60 [amdgpu]
> 	[  206.555500]  __handle_irq_event_percpu+0x4a/0x1c0
> 	[  206.555506]  handle_irq_event+0x38/0x80
> 	[  206.555509]  handle_edge_irq+0x92/0x1e0
> 	[  206.555513]  __common_interrupt+0x3e/0xb0
> 	[  206.555519]  common_interrupt+0x80/0xa0
> 	[  206.555525]  </IRQ>
> 	[  206.555527]  <TASK>
> 		...
> 	[  206.555650] RIP: 0010:dma_fence_signal_timestamp_locked+0x39/0xe0
> 		...
> 	[  206.555667] Kernel panic - not syncing: Fatal exception in interrupt
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Link: https://patchwork.freedesktop.org/patch/654669/
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 135 ++++++++++++++----------
>  1 file changed, 82 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 9b81a6677f90..e5fb8f5346b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -112,47 +112,6 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
>  	return 0;
>  }
>  
> -static void
> -amdgpu_gem_update_bo_mapping(struct drm_file *filp,
> -			     struct amdgpu_bo_va *bo_va,
> -			     uint32_t operation,
> -			     uint64_t point,
> -			     struct dma_fence *fence,
> -			     struct drm_syncobj *syncobj,
> -			     struct dma_fence_chain *chain)
> -{
> -	struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
> -	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> -	struct amdgpu_vm *vm = &fpriv->vm;
> -	struct dma_fence *last_update;
> -
> -	if (!syncobj)
> -		return;
> -
> -	/* Find the last update fence */
> -	switch (operation) {
> -	case AMDGPU_VA_OP_MAP:
> -	case AMDGPU_VA_OP_REPLACE:
> -		if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
> -			last_update = vm->last_update;
> -		else
> -			last_update = bo_va->last_pt_update;
> -		break;
> -	case AMDGPU_VA_OP_UNMAP:
> -	case AMDGPU_VA_OP_CLEAR:
> -		last_update = fence;
> -		break;
> -	default:
> -		return;
> -	}
> -
> -	/* Add fence to timeline */
> -	if (!point)
> -		drm_syncobj_replace_fence(syncobj, last_update);
> -	else
> -		drm_syncobj_add_point(syncobj, chain, last_update, point);
> -}
> -
>  static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
>  {
>  	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
> @@ -773,16 +732,19 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  			struct amdgpu_bo_va *bo_va,
>  			uint32_t operation)
>  {
> -	struct dma_fence *fence = dma_fence_get_stub();
> +	struct dma_fence *clear_fence = dma_fence_get_stub();
> +	struct dma_fence *last_update = NULL;
>  	int r;
>  
>  	if (!amdgpu_vm_ready(vm))
> -		return fence;
> +		return clear_fence;
>  
> -	r = amdgpu_vm_clear_freed(adev, vm, &fence);
> +	/* First clear freed BOs and get a fence for that work, if any. */
> +	r = amdgpu_vm_clear_freed(adev, vm, &clear_fence);
>  	if (r)
>  		goto error;
>  
> +	/* For MAP/REPLACE we also need to update the BO mappings. */
>  	if (operation == AMDGPU_VA_OP_MAP ||
>  	    operation == AMDGPU_VA_OP_REPLACE) {
>  		r = amdgpu_vm_bo_update(adev, bo_va, false);
> @@ -790,13 +752,59 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  			goto error;
>  	}
>  
> +	/* Always update PDEs after we touched the mappings. */
>  	r = amdgpu_vm_update_pdes(adev, vm, false);
> +	if (r)
> +		goto error;
> +
> +	/*
> +	 * Decide which fence represents the "last update" for this VM/BO:
> +	 *
> +	 * - For MAP/REPLACE we want the PT update fence, which is tracked as
> +	 *   either vm->last_update (for always-valid BOs) or bo_va->last_pt_update
> +	 *   (for per-BO updates).
> +	 *
> +	 * - For UNMAP/CLEAR we rely on the fence returned by
> +	 *   amdgpu_vm_clear_freed(), which already covers the page table work
> +	 *   for the removed mappings.
> +	 */
> +	switch (operation) {
> +	case AMDGPU_VA_OP_MAP:
> +	case AMDGPU_VA_OP_REPLACE:
> +		if (bo_va && bo_va->base.bo) {
> +			if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {

This isn't 100% correct.

You need something like this:

if (bo_va && bo_va->base.bo &&
    amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo) {....

Otherwise PRT mappings won't work correctly.

> +				if (vm->last_update)

That check is superflous, vm->last_update is initialized with the stub fence and never NULL.

> +					last_update = dma_fence_get(vm->last_update);
> +			} else {
> +				if (bo_va->last_pt_update)

same here.

> +					last_update = dma_fence_get(bo_va->last_pt_update);
> +			}
> +		}
> +		break;
> +	case AMDGPU_VA_OP_UNMAP:
> +	case AMDGPU_VA_OP_CLEAR:
> +		if (clear_fence)

and here.

> +			last_update = dma_fence_get(clear_fence);
> +		break;
> +	default:
> +		break;
> +	}
>  
>  error:
>  	if (r && r != -ERESTARTSYS)
>  		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
>  
> -	return fence;

> +	/*
> +	 * If we managed to pick a more specific last-update fence, prefer it
> +	 * over the generic clear_fence and drop the extra reference to the
> +	 * latter.
> +	 */
> +	if (last_update) {
> +		dma_fence_put(clear_fence);
> +		return last_update;
> +	}

As far as I can see that won't work as intended. last_update should never be NULL here.

Regards,
Christian.


> +
> +	return clear_fence;
>  }
>  
>  int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
> @@ -822,6 +830,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	uint64_t vm_size;
>  	int r = 0;
>  
> +	/* Validate virtual address range against reserved regions. */
>  	if (args->va_address < AMDGPU_VA_RESERVED_BOTTOM) {
>  		dev_dbg(dev->dev,
>  			"va_address 0x%llx is in reserved area 0x%llx\n",
> @@ -855,6 +864,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  		return -EINVAL;
>  	}
>  
> +	/* Validate operation type. */
>  	switch (args->operation) {
>  	case AMDGPU_VA_OP_MAP:
>  	case AMDGPU_VA_OP_UNMAP:
> @@ -878,6 +888,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  		abo = NULL;
>  	}
>  
> +	/* Add input syncobj fences (if any) for synchronization. */
>  	r = amdgpu_gem_add_input_fence(filp,
>  				       args->input_fence_syncobj_handles,
>  				       args->num_syncobj_handles);
> @@ -900,6 +911,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  			goto error;
>  	}
>  
> +	/* Resolve the BO-VA mapping for this VM/BO combination. */
>  	if (abo) {
>  		bo_va = amdgpu_vm_bo_find(&fpriv->vm, abo);
>  		if (!bo_va) {
> @@ -912,6 +924,11 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  		bo_va = NULL;
>  	}
>  
> +	/*
> +	 * Prepare the timeline syncobj node if the user requested a VM
> +	 * timeline update. This only allocates/looks up the syncobj and
> +	 * chain node; the actual fence is attached later.
> +	 */
>  	r = amdgpu_gem_update_timeline_node(filp,
>  					    args->vm_timeline_syncobj_out,
>  					    args->vm_timeline_point,
> @@ -943,18 +960,30 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	default:
>  		break;
>  	}
> +
> +	/*
> +	 * Once the VA operation is done, update the VM and obtain the fence
> +	 * that represents the last relevant update for this mapping. This
> +	 * fence can then be exported to the user-visible VM timeline.
> +	 */
>  	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
>  		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
>  						args->operation);
>  
> -		if (timeline_syncobj)
> -			amdgpu_gem_update_bo_mapping(filp, bo_va,
> -					     args->operation,
> -					     args->vm_timeline_point,
> -					     fence, timeline_syncobj,
> -					     timeline_chain);
> -		else
> -			dma_fence_put(fence);
> +		if (timeline_syncobj && fence) {
> +			if (!args->vm_timeline_point) {
> +				/* Replace the existing fence when no point is given. */
> +				drm_syncobj_replace_fence(timeline_syncobj,
> +							  fence);
> +			} else {
> +				/* Attach the last-update fence at a specific point. */
> +				drm_syncobj_add_point(timeline_syncobj,
> +						      timeline_chain,
> +						      fence,
> +						      args->vm_timeline_point);
> +			}
> +		}
> +		dma_fence_put(fence);
>  
>  	}
>  

