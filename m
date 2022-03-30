Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE34C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Mar 2022 15:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48D1F10E561;
	Wed, 30 Mar 2022 15:23:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C7110E561
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Mar 2022 15:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EU/WkWu7bwuHJWoyunSK+G2cf6mcesd1tMi5P8ggq39GsOG9+JyVLGio0/BevxTW7Q/XfTPqBSPtJw/cw/QV+4QLm9fg2AiyDGReK8TYWVgyKRfVdmVOXS5lKP039Lh3L5ue2dtobuFXFdWJ7JIJ1KhK3/zKLW9uQjHCtv3NFXKsiltyCgP5o2K/9ZRBn90EKCBuFYYGb30GKLY7QEEeFEyX4zWLNO1wtQPuxnqDdEWC5+ZNE82r1K5bSRhD0RR3jfI0eiLiWTjDUYDi51Ty/nTOH/LaeYI8uIrBfQmiozqp8jFKRTCKnoWa22iICeWwuAL2nsudaG0lhoEfOLpQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VR/niOEMZGAQX1BZTfQATqa0SqFOxnyXRI8y79tz6J8=;
 b=GRWwOETOIYk0xicTXkwjhEydl88MKvQwRD7iC+TUiNA0EIrx2KAgg7P+BbgOEk8YTxDB30AG7UXsznLC6dz+YxM902xJvd0rDpV8E5GV61eJcN+7IA8OFsjgQMvOtQot5q59tCn68OxcqtSEiVJytfDZSv03aUbRWU0T57LPfVvJzUSOw2ZHxGJ+LLswzYBWqsxrL5Tvd05O3IYcUJMTzTWheV4U4l52xMsXTfbVPybQInRsRthmWnsXH+Gzs05KsxP5OYuQlx/5O9uIhNKS2fYgn5StqOEcMqtFvdE8INTWXYahS+2th4sXUQxLjz83oZ3mVJ5fH8ole4EeA4JiRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR/niOEMZGAQX1BZTfQATqa0SqFOxnyXRI8y79tz6J8=;
 b=lCpbDAPQXwFI/VAQeJkVT6QEtA4yi1d36TgQfgjvZr4UWMHpnkuxE0H/mR/qW9sUCSp4HDvU1b3O1HrizuhhqEuCeI6TPryhTJpp17kga384tINRSatri6OSY6UbXBUNhKBnM0GDtU6TUcigFVRVbZd6KrWN0ypGoKMoMc7LZsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MWHPR12MB1757.namprd12.prod.outlook.com (2603:10b6:300:111::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Wed, 30 Mar
 2022 15:23:01 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06%5]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 15:23:00 +0000
Message-ID: <b76122ac-484d-c626-b00f-11d08ebf4448@amd.com>
Date: Wed, 30 Mar 2022 20:52:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: Fix unique_id references for Sienna Cichlid
Content-Language: en-US
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220330132948.1332199-1-kent.russell@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220330132948.1332199-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::17) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a85c6599-c77d-4ce4-f128-08da12612d09
X-MS-TrafficTypeDiagnostic: MWHPR12MB1757:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1757C2BB9E3422D62F222520971F9@MWHPR12MB1757.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mm+Eg4+wiCpeHPMVGhZ///RktJ6yK9dEDDHJW18cv55ULYEC4ehwepWsIb0uJKi2YHckw+8dGxcsJFG0mPalr7efBYHajxslfLLfPFCYCrhrPJZDZVLgVncY+T9hXUBAMP4QPlcKW2mWimdImHQo1foJLGMUxcYQAZ/lhQi1Pu2+F3UlY1F1KPMxLo7mPZbUVv5FfdnQUTlc2Lam87YkTohSSyCFbCKDeu3A3LVyn2c9cJQCz6Q8N53q/ejgw6IMbvcbOk3k0EwUj+zWoKkd5JJIyqYTAUP8wgWlO2YpZCJbpTPo0ff7OC4FArRDWhT/oB8jkafX/eGkkRlMY7XGmSUqZuDpvjQKmFHLNU9Z3oz/K+T91078OfTIp4DdlHnPmAba9OVzN5Br7B/NpBcnMwagc4F5vMP1zQ2+fB8hmBz49blncskKkFEf59n5u4tlYqaSsMycYMI8o0h5aqe/SqdxXoYUoiy5iJmH+dBFdiuDxMNNBpSCEHjrluBarYb7vYzRdubfvIKA/PFAjZ4aMXAWpCl0ya0LvZngNI4pNiBO1SHXFGBhzH1TdYOmOz/NQyCXDajfhFDI1Ew9ktYlQSXvVx5d4PDixS02cMBJtRWvXNdXTVjYlo3EORTFTDdK26Rz1xsUruX0x9vc+4gqFM3m0KhRCYwmzi6hr6AKOEM4gNXVP+Uli9NVGOFTNV9l6n1X/olqxnWdD6Fy6PPV2Va5rsmoDSjOpO1H8flkvJh3aLGRW62ps06m7sF4d66s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(31696002)(83380400001)(36756003)(66556008)(66476007)(6486002)(66946007)(316002)(8676002)(31686004)(186003)(8936002)(508600001)(6666004)(2616005)(5660300002)(6512007)(26005)(38100700002)(6506007)(2906002)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmQ4Wmw1YXZGZ3UzYXZQMDNrcGZhc1BFMGVxdGdPaGM2Y2EvWjFXV1I3VXFh?=
 =?utf-8?B?Zk90a21ueVdjZVJXdGZ4R21zV1dyY3M3M3FiOEFnSkptenFpVDVjSVgzL1F3?=
 =?utf-8?B?MHB2VFUxanQvNS9QbDIzbXF1eHIrVi9aaXZsM3ZJY2J6bUJwQ0cvQVBJUGN0?=
 =?utf-8?B?Q2xGWDdZNk5vbDY2YUxSVDV4VXRySGhFY21SY0hvYjV3TzNtQklGOFNVeExU?=
 =?utf-8?B?VUpJdldrVkRaWmdBL3VwY3pGZjEzWjhsR3Yxc251WHdGNk9Ob2VGSXlVUjdK?=
 =?utf-8?B?Yi9WT3ZaQ1Zyekw1cTFiN2ovNzlIdXY3N2s1YkJTcDZKaEwyT21oU3hKOG1n?=
 =?utf-8?B?d3Z3RUZCZkxWSy8rYndkU1ZzU0twZGVWZmVIckVGaWNBYU1WaE5wR1ZOYy9h?=
 =?utf-8?B?ODJMVndlSHlGRVdFMS9DU25BVEdxeTFYQ1QyTVo0aU9hZkpqeEJxNENoSDVF?=
 =?utf-8?B?b3BrMm1qTTRvMnhJQ1QycGZjWm4wSmcvUWhva2g4RDk3Nm9GRjVtRytIUlpY?=
 =?utf-8?B?ZGt1Mzl4d2JqZDFUeEJ3b3FYKy9ZSGlWbmdKSEUwS0tCK2ZiWmpBTi9IeXVD?=
 =?utf-8?B?UTQvMXA4N3FqRzY4Zkp6N1dRK0dKSWVGdkRwOWFYWWNpUDVJOUc4M1phcldJ?=
 =?utf-8?B?Mm9hbmIzZngybU9nV2E0cVI2Z3VVdHl2L0FIRU9ReHk4NGc2YTZVWFppM1hI?=
 =?utf-8?B?YzhDdHNnOG1RNzFmSjZKWWxna3FiSTcrUlp5SFpOSmE2TXdhQ1FEdkp5a0V3?=
 =?utf-8?B?WFBNcUFOSHJyZmZOWWZGL3AvVFAzRFpaQmZjNk5iQXFGSU1xVW9DdkJxM2tE?=
 =?utf-8?B?V3FQODYrMjUzSXpwZGxNQUxBdGY1dndkMVNxRm41cEV6Skw1K1pldHFZTUFR?=
 =?utf-8?B?K0hxaHczSkpZekFUNzZlakJacUNGNGhMM2hpTnBGOU9OM1lMV1pUdUVIVTdi?=
 =?utf-8?B?U0wxWXA1NllMb3lUZGQwMlRYVmV6bHdvZzd4YVExTUcxMUNOaFVMdDRtVGsr?=
 =?utf-8?B?bmpaamFrZ05lWElZUDFXWldoSk5sOUlBZ1pUQU56NExsYnlVTVJ4bWRXTDNw?=
 =?utf-8?B?cmUwQzA4UE5rMlFxNENMMGhsSUlEMlpkemNrQU14cG4xc1M1K0xvOUVuYmJZ?=
 =?utf-8?B?MVpYa1lDMHRXWGRQYUZ6TlFtd1pTYlVHcm5RN0MyeUlZUVVPR2hYeGZLZVJU?=
 =?utf-8?B?bGJhQ0xKcUdRSmVOckNCTnU3WThKQ0phMHVQM2orRXRWeHFzZmVkVVVnaWx4?=
 =?utf-8?B?NnlIZHhUazh1VzZHZ0dsRUs4QmpYcllUbWVJMVllb1ByODVFbzYvUXN3b0lQ?=
 =?utf-8?B?cGVRY2s5ZnpSVEpZd2lTV0FmbEJMaklkbUdpcXA4WWFtR3IxN2xzZVVuVU1L?=
 =?utf-8?B?eEdFN1doVFNnUnRyeHpBRGlqb1d3VkFYWXJzTHZmVWllb2tpOWhZT05PVFdS?=
 =?utf-8?B?QW00Z2tBMlNLRzlNTTN6STFOR2FkNXo5alpkeGdTdjhURTFnSUpIVFdMMkFH?=
 =?utf-8?B?SmVJeWUvVUUyNE5Bc0tobC9KRmRvZWdXK2ZVdHdUTGoxMTlOdUlTSmw3aXQ2?=
 =?utf-8?B?WDd0Nm1xVEd6NXF0Wm9PeTYzd3dHQmxEbWlmU2pXWE9xRFc2MExqWEttdHZr?=
 =?utf-8?B?WDNNcTJ3Y2NRYURJbHpMWHhobkRoWUJxWVBOWkdURU5qdGxuOTZsSUtHWjUw?=
 =?utf-8?B?ZXpwbFMvZ2lqUE1tZzZsY1kydVlwSmU5Nm1kbE9VdlFqZUxtd0dtSGNqWVhD?=
 =?utf-8?B?dnE3ZTFhZXp0L3pCVTJ4NGQ3ZFMrTDBIRVBlVG03YysrcS9JZ1RZZ1VRL1dn?=
 =?utf-8?B?ZWxSeUtkSmY1T2xaN0x6ZS82enlVdlp5aVl3S08vRzF3aTBmc1NFS25hYzIv?=
 =?utf-8?B?OU1vd0R3dkhBN1ZWMndrQ3J1QlVUYjI3RDU4dXJ6V2FLMllNMnBjVHlFMVVw?=
 =?utf-8?B?OUwvZVVFUVFnMGIweVB3ZEVkNkp1MkxGaTZSRmU0dUsyN2JHQTd5R1BmWVpY?=
 =?utf-8?B?aE5RdWdITk1ySG5HelZIWVNhNVJXVVpPa2FFend6NnhGNjRwczFzS0RmRkdG?=
 =?utf-8?B?NHJEMGZ5TVJ5QVVmVkdRb0xoUVFVQWRQenFsV2gwMS91RWFydmF0cFh1ZEJz?=
 =?utf-8?B?SjMzMjZCNnh0Ylc1T1h2UHkrcEZlcUpzQkRQYVZzQ3VyakZWMXhOR3R3bmpp?=
 =?utf-8?B?OTA5OC9tMjM3OGZqaElkaytZcjhLUXMrL0VhK1EzR0R5YTNoUjlTKzllNURs?=
 =?utf-8?B?VGxVaWFGaDloaCtKcnNXZ3ppL0JyOXFpWERvQUR5OUFnaHpMQnBmMElqMnkz?=
 =?utf-8?B?b2YyeEcrVnc2azFkMEdNeGpvaFVTUXgzVk9ieXdSZDJtT0hjVlovdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85c6599-c77d-4ce4-f128-08da12612d09
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 15:23:00.6537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QDqc+oJwP/WdjWlSvwKN9dv9bPgEkoIBZKG2BLd7KMx0rOTSBpC1m6YrHTcPBvP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1757
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



On 3/30/2022 6:59 PM, Kent Russell wrote:
> Since unique_id is only supported in PMFW 0x3A5300 and higher, we will
> only be able to use it inside Smu_Metrics_V3_t, which requires PMFW
> 0x3A4900 and higher. Remove the unique_id/serial_number references from
> the v1 and v2 tables to avoid any confusion, and return 0 if metrics_v1
> or metrics_v2 are used to try to get the unique_id/serial_number.
> 
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h |  6 ------
>   .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 ++++------
>   2 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> index 5831145646e6..08f0bb2af5d2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
> @@ -1420,9 +1420,6 @@ typedef struct {
>     uint8_t  PcieWidth              ;
>     uint16_t AverageGfxclkFrequencyTarget;
>   
> -  uint32_t PublicSerialNumLower32;
> -  uint32_t PublicSerialNumUpper32;
> -
>     uint16_t Padding16_2;
>   } SmuMetrics_t;
>   
> @@ -1480,9 +1477,6 @@ typedef struct {
>     uint8_t  PcieWidth              ;
>     uint16_t AverageGfxclkFrequencyTarget;
>   
> -  uint32_t PublicSerialNumLower32;
> -  uint32_t PublicSerialNumUpper32;
> -
>     uint16_t Padding16_2;
>   } SmuMetrics_V2_t;
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index b2f3d80e5945..ab3e9d8b831e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -716,14 +716,12 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>   			use_metrics_v2 ? metrics_v2->CurrFanSpeed : metrics->CurrFanSpeed;
>   		break;
>   	case METRICS_UNIQUE_ID_UPPER32:
> -		*value = use_metrics_v3 ? metrics_v3->PublicSerialNumUpper32 :
> -			use_metrics_v2 ? metrics_v2->PublicSerialNumUpper32 :
> -			metrics->PublicSerialNumUpper32;
> +		/* Only supported in 0x3A5300+, metrics_v3 requires 0x3A4900+ */
> +		*value = use_metrics_v3 ? metrics_v3->PublicSerialNumUpper32 : 0;
>   		break;
>   	case METRICS_UNIQUE_ID_LOWER32:
> -		*value = use_metrics_v3 ? metrics_v3->PublicSerialNumLower32 :
> -			use_metrics_v2 ? metrics_v2->PublicSerialNumLower32 :
> -			metrics->PublicSerialNumLower32;
> +		/* Only supported in 0x3A5300+, metrics_v3 requires 0x3A4900+ */
> +		*value = use_metrics_v3 ? metrics_v3->PublicSerialNumLower32 : 0;
>   		break;
>   	default:
>   		*value = UINT_MAX;
> 
