Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB011C282DE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 07:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D97810E90D;
	Thu,  6 Mar 2025 07:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yQeDb9XW";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2081C10E90F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 07:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IF+ckiW8fcGEG24KFhhlupCOsKQvrP3WrQ4tfz9J4hlRbeLi8C0+/8K03c9mb2kz0QWNkqiVoBesWh86uZ5ONXVKwC52fG2QLLQ4Htjvp643D3ncyM1FMZe2DVAAc9yUGjrHoc1SiClAEh2JtuFUCd/t52+9iybCUiGsyjN0/UyRVqS3PXNmEtN6dy0A2VjHW6dBLpY3alOud/mAY/5yegh1mfZfFFasMkiL0vhqBSov5OmhEW3KGJwIihJGlwwhKc+KvlBWZr7JRSWXUEmTyMUpAWlLFEgPAk0drE5vbIAcmQOygxoU04/jYuI4Gq9sfWuuV3INGOl3Ijp1IMNeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4HrJp6e29dMbEELHrh8xy5nFEpiNMveUJw0++GEF9k=;
 b=segJUQbwNXCbAV5ArH0Z8rIoUM9S8vzBXuXgm6Vogv+Z2pbvuT1V5zuDDMJ5Eor7tbcD37wH1ztcNbRHvDO4+j/wEgo/novgchVBmFpmUmCOBJ0ks37Usjcm8Ie51CcYrPu5oe9LOn6IQWPCel+wUoUvit3t06pMKEtmFhZbXy71N+VktD0hEuZ7Kl0kAWCoTRwfXzjHYfcvzsUpr3PPP8ij4QF1IexXF4rWMvxL/YBNfKRlCgs2BDonBuRZxBD95CDDiNzOj0FX1Nh5bQlxbS1aUuP5lkGSflXQ5xRE8hqPnQn/WNfDmXtPl8A1juQIxV7VZH5nPq1eyy05zZXnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4HrJp6e29dMbEELHrh8xy5nFEpiNMveUJw0++GEF9k=;
 b=yQeDb9XW15Zd/9NtbB+IrdvKwTHpCe90v40299uekKWXHKR+CyExG/rlIZbZt6/oDQ6/5DhQbaGv/WKlRP2vDjd6hnDiT2Xl+gnTokN0GhZh9XCgkoCVSQizqcG9uJEXnQsu3xPiEN8k7ywHi/lOV4h2pYpiP8TYtWi8ffoQmhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CYYPR12MB8992.namprd12.prod.outlook.com (2603:10b6:930:bc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 07:48:15 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8489.028; Thu, 6 Mar 2025
 07:48:15 +0000
Message-ID: <ff8c8af5-aaa6-491f-8b9d-71f788ea48fb@amd.com>
Date: Thu, 6 Mar 2025 13:18:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
 <20250305204721.1213836-3-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250305204721.1213836-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::10) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CYYPR12MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f84ea32-6378-4bf0-6c25-08dd5c834083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ay9tSXFqY0pUUXNEWCsyVGpPTDFQSU5YUVV5TU5SbDhxNnFFK1haOHhQM04r?=
 =?utf-8?B?VVJOQXpzTnJEWlVlSmRGdnU2L3BIbkJyUDcrNkd3cTRLZDI0bjJIVjBzNWsy?=
 =?utf-8?B?eXA3TDNDVmszN2NiMEwxdElHNjlGREVIbW1CMEJtZjhOWmpNa1F5RFEzRUxL?=
 =?utf-8?B?aDVjMTQ1bDJXWlFkZkkxaDNlNHZaQ3NKRjBMUU1KbHd3ampzdlFRMTN4Um8y?=
 =?utf-8?B?YWdoM1pGSmsvc3k1QkFLQmcwVnE0WW1FcUtJR3VlWVhOZ0JIMG9FTEJhMSt3?=
 =?utf-8?B?ZkI4ejlONmE4QkVFVjVjVjl0dzk4elZSd2greFN3OEtUUzF1TWk4aEFENUx4?=
 =?utf-8?B?WklaNDVjUUxJZjhwL0RkMkhDZ3lWUk1xZmdVRTRlK0tiZW5wMlEyMXpXZlhQ?=
 =?utf-8?B?bjVMY2hBSy9RYlpYVW91b3ZVVmpDdlFkeEh4bHUxamhHZ01rK25qQ0VSMFlo?=
 =?utf-8?B?RHhnUEtmMHB4VUxQTTdQK2F4UDUyejhleVR0UU1hdEVjbTJ1MndyYlpvT1N3?=
 =?utf-8?B?SmxzK0pOdVR4WGw1a3BZWHZrZ2pYWFgvR2hQREw3bDltR0EyanNOOW9TVmtk?=
 =?utf-8?B?b0d4czB1bDJzNDV1TldRaUVFV2RNNFpLL3Iyb1o5bmVBczFtY2NGcWtKUmlw?=
 =?utf-8?B?aVlVR0VPT0l2eUFrazZaMEJwdnNtMWkyaFJrM1dnTkNSM0dqQlUwV0xwenpT?=
 =?utf-8?B?VUNJSXh6R3VDZWdKV0VvM0R4d3duY3RITncra1d5cW00cFRRYndqTlg1TmJa?=
 =?utf-8?B?MEdBWGg3YSt4WTdDeUhCZTMwNnJCcTAwRkQvYUk4Yjd3djFJY0l2Q1ZyL1do?=
 =?utf-8?B?UkdyVE5Hdm1kRU9LaE5RRmJNYWtveU8rVmc4M0FrQ283ODRhOENXYlF1QjVa?=
 =?utf-8?B?dHZGU2tDN3kwb3d1WlJMSjhNKzVncGJJQStkam02eENDNTZZWGdaVjJUZWZk?=
 =?utf-8?B?UUJpTnJFR1J2T2hWRGlCNkoyRlYzUTMvN2RyVHBtR0RidG54Q3dPNGcxd2dQ?=
 =?utf-8?B?amZoWElrQUZWREFoQ1N5SFdYQzdyY0czYTFFVEdFWHZucXJlcWZiellPc0hG?=
 =?utf-8?B?SnhSekpLTC82WDROSm5saW42S1FhS0dLWHcvMGp4MkhFV3FZSVA0ckxiNWhk?=
 =?utf-8?B?bVA0NGJGOTBmREVaMHZJYTBFMXpZQ0NCVXd6cldueUFQTzRYU0FVZ3RPMnhG?=
 =?utf-8?B?Um1Wb2MxNlljdExnZFFxUzZnTEFldVlaZjZ3cURlcHdLQ1BPcUlFa3ZERUhj?=
 =?utf-8?B?UFpBTE14Mi9aclkyMzE3SjZnTFRTTlg5WDBlTlF5SHB6WHdUcUZFZ3ZpREth?=
 =?utf-8?B?T0h0cGkza04zeDdIVG9KM0p2NEEwSkh1aWZudGxnVHNSYi9lbDhQN1pqNTc2?=
 =?utf-8?B?OVVXdWM4eVNIUU04ZjltS2VKS2VBNmVEVkEwVTlSVXViV1N1ZjVIbHNETTNv?=
 =?utf-8?B?ZFZNZVF3YVQ4RzFJOTRpajdVOUhRVjc1bnF3Nk8rK3dJTEl0eEZFVk9ZSStn?=
 =?utf-8?B?YlA4b0tQMGhFSExrS3ZwMDl5eWRXWUQ0TzZxN3pYdFVOcVlaYjFSUzlaTlpR?=
 =?utf-8?B?NXAzell5RzAwWklYWFJ4NEtYR2VOSlhWa0hZdDJWSFBCK05HYmZsdCtMWCtW?=
 =?utf-8?B?TWllOFBkYmFqNU5IcytJZTBnV2ozSjA4TUZybWluTFNCbEExbXhNNVgvc29E?=
 =?utf-8?B?RHYyRGpYQTRjdjZjM2p1ZEdDRE1sQmN6S1dGd2hzbk5sWE5iUFJZOHVVTmJx?=
 =?utf-8?B?Q2dGNGlIczJtZmhSMVpkNERWaHhjQnkycEtRZHRPa0R4WUhLSDhETnFtU0pq?=
 =?utf-8?B?Yk80a2I5RU9vRURpSmw2UnNzcXBYZzRMWkxrYVoyUStObndvbXlSYjlVRkZw?=
 =?utf-8?Q?9ohzU8fGHQC1+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z25GVHZTczM3cHl2eHg0aks3QmdUNTRpd1ZVeXRsM25hWmFvMUIxQzl2WVVQ?=
 =?utf-8?B?OSt6VXZMbC9xZEdDalQyWDhPRVhneEpzd3Aza1ZhTUlULytDRUFHUHl5dlB6?=
 =?utf-8?B?YWFwUHpLWGYvTFBCSllpRjZCUy9ZQm9JM1dsb3VRcEZlODVFeHMrd2dWNmY4?=
 =?utf-8?B?dVZkaUJnd3h3L2FRTzl6cDYzd0RxYXQ2M3JvM0E5dnE4MWNQTTJzRVpaQTZU?=
 =?utf-8?B?STk4SHNNNm9hQVM2d3BUK2dDTjdpaE5TOUZUai9ZRXVQZEt4Ti9XRDJhTG9R?=
 =?utf-8?B?bUtNQ05sKzczOVJ2MkJuS2VsQWpCdnNuVlR4Sy93dUxMVXZwaE1wWk9kelRy?=
 =?utf-8?B?clRGU1p0OWROa05YVVg2MGs0RDJJQkt0QWxraUNyQ3pXMzJCT0dQaFZlcHNy?=
 =?utf-8?B?OFdicytETjduVlZPMDFUT0Q4V0FZRG5GSWJzMXNmR1JDRDltanFsemUvS3B6?=
 =?utf-8?B?amhyUis4ZVZxZkpkSWF4eXdpWE02dm9yd2tGT3p6KzJBbUhWZU1qdUlLVFRN?=
 =?utf-8?B?SnA3bHU3TE55UXVWVGJ0YXVpNDhoQXNMakNMeGUwZC93NnF4cjFFQ2pucS9o?=
 =?utf-8?B?U3o1NjdISWZVZUFxenovY3Zmb0FibGxpU3dBVWI5M0ltNUpLNUdNRE1aLzBY?=
 =?utf-8?B?REJaWW1IVjg4Q2hxR3cwcUZudmZ5N1hvMHMyVlFOKy9obFpZZ3pEalRXVU9j?=
 =?utf-8?B?ZjR5UVI4Nnpta1BxOVo1T1ZCVWNjT054ZnQ4eVQ3UVpwMVlIbUNvbkcvczgr?=
 =?utf-8?B?ZGladFpIWlNFZU9wNDNjS1pESlkzQU9vUFNzYUJhZnNZU2F0VU9TaTFSZ1oz?=
 =?utf-8?B?cUN0QkdicHR1OUlKeXhBUlcrMDB2Wk9RVmE1Y0Zpay9Ba3ZHM2NWYUpPdXYy?=
 =?utf-8?B?RGw2YlR6SFJhV3ZET2hZQ1Z2MWs2ZWRxbVdpbERYYlg5NUhkZmxVeTN0dGVx?=
 =?utf-8?B?M25PTEUyY2RnU2hTMVRnMmRzMVI2VlJPcmh3V3BZOWhJUENDMjlnU05zQ2d3?=
 =?utf-8?B?Vkl1MTUrYXhZS2RmZThWdW1peHY1YTRZa3d1WDFEYU1xcnJJUlBmVnBrKzFw?=
 =?utf-8?B?L3oya2ozN1pYUHVYdXBJY0taR0ZkdXRKSGM5cDEwOFBlbmhwSGdhanhKakxi?=
 =?utf-8?B?L29MSHF4SDZjUVNUS25zU1JlV0dmYndOQm1UdDZVc00zU3krTmdWV21kR2pt?=
 =?utf-8?B?dEtlUlF4ZlplMTBSUmtTQzVmalAxOUhGVm9PL1pwOFJZNVh1cjRoTkJTV01K?=
 =?utf-8?B?VFlSWWRWZkpoL2V6MjJDajdzam13OElWN0VKY1YvalZBV1luWU1seHV5clRa?=
 =?utf-8?B?MU9lSTh5TTVkRnUycXhNcHJuOVZaNlgyN1V3US9rb2JXUHFLV0dDYmVDMWJ1?=
 =?utf-8?B?akszYkV1VFdyRkFLZVZxZjBqNVp4bUQvOXh4Tmg1ZzdhSmsrMHo2UjFEN1lp?=
 =?utf-8?B?azdHcWtpTWJ4d08vbDFBSjRLTmRFUHlyeUVOaUx6MXF6RGFxOGsvVUlzTHVX?=
 =?utf-8?B?S2NBbHlZR2l4WldtOElkUUpHc1pZT0Vqa1l3UWJRdGdWS3ZyYXRLeTFlWW5B?=
 =?utf-8?B?UG1SUXFhcUpqOVlxVCsrTm1XRFlxZHNuMlliQmRzQUh6ZnlIOW5WYlhlbDhO?=
 =?utf-8?B?Q3l1dXVGYXpEREIvUy95Y2JBcjVXTG5LMFhPakVpRXl5UllmY2lXaFFGQUpt?=
 =?utf-8?B?bVNxaFlaYWx2WDE4eGFVWGorRTlwNm1uWHJLZk8zcVFxaFJRRm40Y2JVOVdF?=
 =?utf-8?B?L0l5VTNMaUd2Tk9yQkJETHBBVXhFMlVHdEM5dWY0aFdUMVN5cmw3cWg3ODRh?=
 =?utf-8?B?eDlsWUxLK2JFdmxsNzJzamJBNXlIcXNBbTdESEtxR3RzYnBUN3Jia1RWcUR4?=
 =?utf-8?B?MDNLSmlZUlA0WlZUOWw5OVZrRWNHNEpUdG9QWFg4NjdKWFFwMmRvRXVuZktz?=
 =?utf-8?B?Qk42NkdlTm84RENlRkpKTHpDN1diZm5NdWtRUjltaURUVnRxSDFicS9lWTRM?=
 =?utf-8?B?V2srUWx3ZlVTL3FuWDkzcEhJdEhLQ281RDlQNkhNNWF1T2lDQ1BYK2pkc25j?=
 =?utf-8?B?cGZTUmk1TnAxSk5JaDRUVVBKRkZva0pnTllGa2dRRlVUaVhvSzM1ZG92Rmx1?=
 =?utf-8?Q?P3CLVhkZbbtQ4O5yI9M+PyIDY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f84ea32-6378-4bf0-6c25-08dd5c834083
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 07:48:15.2385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x84fz75zbqyXppU53C0+f0PXZ4r8oluOu8bXBCYD74RGfr77j8gi8QbJ+BPVE7doO7HJV6Uaglf4VQZPcy7O1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8992
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


On 3/6/2025 2:17 AM, Alex Deucher wrote:
> This would be set by IPs which only accept submissions
> from the kernel, not userspace, such as when kernel
> queues are disabled. Don't expose the rings to userspace
> and reject any submissions in the CS IOCTL.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 30 ++++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +-
>   3 files changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 5df21529b3b13..5cc18034b75df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -349,6 +349,10 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
>   	ring = amdgpu_job_ring(job);
>   	ib = &job->ibs[job->num_ibs++];
>   
> +	/* submissions to kernel queus are disabled */
> +	if (ring->no_user_submission)
> +		return -EINVAL;
> +
Alex, dont we need to disable submission for other type of chunks, from 
function amdgpu_cs_pass2 ? chunk type of bo list and fences are 
submitted by users and we do want to handle that too.
If that's not needed then lgtm.
>   	/* MM engine doesn't support user fences */
>   	if (p->uf_bo && ring->funcs->no_user_fence)
>   		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index cd6eb7a3bc58a..3b7dfd56ccd0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -408,7 +408,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   	case AMDGPU_HW_IP_GFX:
>   		type = AMD_IP_BLOCK_TYPE_GFX;
>   		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> -			if (adev->gfx.gfx_ring[i].sched.ready)
> +			if (adev->gfx.gfx_ring[i].sched.ready &&
> +			    !adev->gfx.gfx_ring[i].no_user_submission)
>   				++num_rings;
>   		ib_start_alignment = 32;
>   		ib_size_alignment = 32;
> @@ -416,7 +417,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   	case AMDGPU_HW_IP_COMPUTE:
>   		type = AMD_IP_BLOCK_TYPE_GFX;
>   		for (i = 0; i < adev->gfx.num_compute_rings; i++)
> -			if (adev->gfx.compute_ring[i].sched.ready)
> +			if (adev->gfx.compute_ring[i].sched.ready &&
> +			    !adev->gfx.compute_ring[i].no_user_submission)
>   				++num_rings;
>   		ib_start_alignment = 32;
>   		ib_size_alignment = 32;
> @@ -424,7 +426,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   	case AMDGPU_HW_IP_DMA:
>   		type = AMD_IP_BLOCK_TYPE_SDMA;
>   		for (i = 0; i < adev->sdma.num_instances; i++)
> -			if (adev->sdma.instance[i].ring.sched.ready)
> +			if (adev->sdma.instance[i].ring.sched.ready &&
> +			    !adev->gfx.gfx_ring[i].no_user_submission)
>   				++num_rings;
>   		ib_start_alignment = 256;
>   		ib_size_alignment = 4;
> @@ -435,7 +438,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   			if (adev->uvd.harvest_config & (1 << i))
>   				continue;
>   
> -			if (adev->uvd.inst[i].ring.sched.ready)
> +			if (adev->uvd.inst[i].ring.sched.ready &&
> +			    !adev->uvd.inst[i].ring.no_user_submission)
>   				++num_rings;
>   		}
>   		ib_start_alignment = 256;
> @@ -444,7 +448,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   	case AMDGPU_HW_IP_VCE:
>   		type = AMD_IP_BLOCK_TYPE_VCE;
>   		for (i = 0; i < adev->vce.num_rings; i++)
> -			if (adev->vce.ring[i].sched.ready)
> +			if (adev->vce.ring[i].sched.ready &&
> +			    !adev->vce.ring[i].no_user_submission)
>   				++num_rings;
>   		ib_start_alignment = 256;
>   		ib_size_alignment = 4;
> @@ -456,7 +461,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   				continue;
>   
>   			for (j = 0; j < adev->uvd.num_enc_rings; j++)
> -				if (adev->uvd.inst[i].ring_enc[j].sched.ready)
> +				if (adev->uvd.inst[i].ring_enc[j].sched.ready &&
> +				    !adev->uvd.inst[i].ring_enc[j].no_user_submission)
>   					++num_rings;
>   		}
>   		ib_start_alignment = 256;
> @@ -468,7 +474,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   			if (adev->vcn.harvest_config & (1 << i))
>   				continue;
>   
> -			if (adev->vcn.inst[i].ring_dec.sched.ready)
> +			if (adev->vcn.inst[i].ring_dec.sched.ready &&
> +			    !adev->vcn.inst[i].ring_dec.no_user_submission)
>   				++num_rings;
>   		}
>   		ib_start_alignment = 256;
> @@ -481,7 +488,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   				continue;
>   
>   			for (j = 0; j < adev->vcn.inst[i].num_enc_rings; j++)
> -				if (adev->vcn.inst[i].ring_enc[j].sched.ready)
> +				if (adev->vcn.inst[i].ring_enc[j].sched.ready &&
> +				    !adev->vcn.inst[i].ring_enc[j].no_user_submission)
>   					++num_rings;
>   		}
>   		ib_start_alignment = 256;
> @@ -496,7 +504,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   				continue;
>   
>   			for (j = 0; j < adev->jpeg.num_jpeg_rings; j++)
> -				if (adev->jpeg.inst[i].ring_dec[j].sched.ready)
> +				if (adev->jpeg.inst[i].ring_dec[j].sched.ready &&
> +				    !adev->jpeg.inst[i].ring_dec[j].no_user_submission)
>   					++num_rings;
>   		}
>   		ib_start_alignment = 256;
> @@ -504,7 +513,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   		break;
>   	case AMDGPU_HW_IP_VPE:
>   		type = AMD_IP_BLOCK_TYPE_VPE;
> -		if (adev->vpe.ring.sched.ready)
> +		if (adev->vpe.ring.sched.ready &&
> +		    !adev->vpe.ring.no_user_submission)
>   			++num_rings;
>   		ib_start_alignment = 256;
>   		ib_size_alignment = 4;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index b4fd1e17205e9..4a97afcb38b78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -297,6 +297,7 @@ struct amdgpu_ring {
>   	struct dma_fence	*vmid_wait;
>   	bool			has_compute_vm_bug;
>   	bool			no_scheduler;
> +	bool			no_user_submission;
>   	int			hw_prio;
>   	unsigned 		num_hw_submission;
>   	atomic_t		*sched_score;
> @@ -310,7 +311,6 @@ struct amdgpu_ring {
>   	unsigned int    entry_index;
>   	/* store the cached rptr to restore after reset */
>   	uint64_t cached_rptr;
> -
>   };
>   
>   #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
