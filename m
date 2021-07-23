Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B013C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 10:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA36960E73
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 10:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA36960E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE376FA92;
	Fri, 23 Jul 2021 10:09:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE1146FA92
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 10:09:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYfN9PRuCQ1cjmKxw0eF3wOttGtPcaZm6yaMmn8XlikpWMfjDUFOL4DYKAy0EImRHblJdgH6n5YT9+YY9g7AJhZ8P0g+4Rbgsh+dGJ/xpPc2yBDcdduiR+Nyw1I30E05SngACOB/e2RaTBuHxlXIR9TlRicVgmZNidVNjKZ56AtBs1cMvhc2xQoRzSoKiVZC1TARunQZLlPvl6GIvsYpmZmx7DSaP1mcULMDDz/Sf0y7bS5sPD5ecJsv7DgjBmfxSrcxD74j07z4BrTu4ZX653D2mPwcI+nQNeynuBZTxQOxb4ntlA/K3W1eACn/485RXjQB3oqzcLQ/ckSdijH2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI5DZ4ZaAiqnXlIKxjJBKboq5oNeS0R/XfkOcRlezD0=;
 b=O0EeGUJB705GLnPdb8rkiwQgCzM4l6J4a992DuJsHsvTfPQzfFP4m1pA13yOiDaifbMHYejP2nvZG23szS2ojURJZwMY/FnGVmh6CpLorU5AE/YQ91o3VrH7rwA0vsvILvxuTt8cIGx+/ns0Hx8wU1f54NlJ/3AUy8iNeL7v43jJrUVGH1sVlKo04v3R6KONohHQH1JEBNq3QwK6ezIJavGdDjIwsEQPxe7MltuEx3k/NGppMnreD0cwgHod5AHGgDxLb3RQ4nUhwUXPjIIAJbS3f/akQiynGF3c/irNQ+najSVwp1uAu6ghOzRseGteCxUI3Wb1qfHrDuDyfjv5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI5DZ4ZaAiqnXlIKxjJBKboq5oNeS0R/XfkOcRlezD0=;
 b=tyqneU0wDkiAPfHUWaQVMQqBlzC/fqbWSvVdfIMOf+26FlaFCfJpNybKhuyoS4A59R52Cvke6hpWCBao0d8ad+1RDJ9rRW/Q41cDN5h4FDFSrzkfOQcNz80km4dKvNlgxtYHlkdRzUazXfNESHUnEZkgYKOfkBxeN/Gjc72HC5o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Fri, 23 Jul
 2021 10:09:32 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c%4]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 10:09:32 +0000
Subject: Re: [PATCH V2 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210723090933.806633-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <1b728523-e245-13f1-b649-ca422d29594a@amd.com>
Date: Fri, 23 Jul 2021 15:39:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210723090933.806633-1-evan.quan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.25 via Frontend Transport; Fri, 23 Jul 2021 10:09:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a521f3a-caae-469f-b1c1-08d94dc1f74a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5110900E63BCF102F4AC8E2B97E59@BL1PR12MB5110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VKTEK+P/WKB2adwytyzTmiCwvVJYzz5/UdUrJ7baXXQsGejQXhuv2ETLcwuzIDBQVDY4qov/D/4BHZ3J+a7z9cWqUd5z7RdWwab4WZD94bo5aln50RfVNW1Glh83RCAFONc7AnOSjBfZpZwWJP9uCjXABFrVTV6Houl28fL+ncPLI3hzXm4A594gqapI1Q6W4d5OTUwwe3nTa6XvhiZytcyTS+I0njTbx0heRTCeZKYKxnUb1jPL2ewPgC0BDwGPncWVo40bWdgoOaYCgeFlGoIyuU5eojL09HW2BFtmotvX1lVotfEaXAlh2OqxlXW2RvL9ciIlIOo1kdNY4a4nFtGTeOM4cj6wnW/7Cf6SkTFzYeBpBsEBFlrOqHX78nsaYcfAoj76rhCAn6+NbFhAPLRdh8eXJK8emUs0CFDJkNzuX7pvIGaLCiUDIL35bBaT94ZbaB/FtrCNdZApLz4sNWeTiZM8clik85dae9xf/OXykRiRWjjJ/TswD9ciqVWcSJSlr6bV/idTIWWHA6piA1dPjIHegzYgMzZMyqN0PafhPuS6Q5nqMhmKnNA0z/AEKtZ6Mf727ajlNy2spwAUdnyIIAgnUwdr8+3flI88VBIqfSza5eiw/8it3n3MaxaIr9sA2dkozTzLjQaO6ax8fTIhlv0YJc09jfla9W1QSqyQboZ61fkxQHSmFwRGkGcsnZyIBumPkHvL51v96PLFTQJ2cmnb42798scHNyr2YKc4atItwvhdr5OvJc+qyPs6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(4326008)(2906002)(5660300002)(66574015)(86362001)(8936002)(478600001)(83380400001)(8676002)(26005)(31696002)(53546011)(186003)(316002)(16576012)(66476007)(66556008)(6486002)(38100700002)(956004)(2616005)(66946007)(36756003)(31686004)(6666004)(32563001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXlTZEdFZm51WXU1UCtkdmYyeEhvYXBBeU93dmFDNU5vTmRlWHZ6T29RUVFQ?=
 =?utf-8?B?YWJiVi9VRiswb0RqTUU5bEVzNi9tMGlCZElxd0E2bjFXVnFKd2Z3Tk1HT1Y5?=
 =?utf-8?B?L3puajJZSmdZZFY3THFzYVpBSkZQMXJWdXQxaWRBL3o4djJ6b3FQU1RjcTVi?=
 =?utf-8?B?TlFWak9yZlF6b1ZvU1pMblRwQitHZmRZNHArMDM3RmJzUDhRZ3E1ak00UmMw?=
 =?utf-8?B?dVVtNENjTWU3NS9CRDBFeXk4cFZ0dDFBVzJSclh4Nm5LeFAwYzViejdSK1JD?=
 =?utf-8?B?ZElsYmc4M0tXR1FnMUJIUDFtOXp4U0txbnUxSnBHaFVjSWhWVDBuY0VJNGFO?=
 =?utf-8?B?WHZxZFN0Z05XSG9jTWdFRlVPSGV4Z0VreEtYSVFCNnNXK1FOL1BWc1FVYmZE?=
 =?utf-8?B?MGZGUllIeGw5YnJsZGF4S3V2bmEwNWdZL0JMZXRqU2o5N2tITjRXalpKQXlG?=
 =?utf-8?B?VndvNVRZUU83NjB4ZGlWb203R2NXalV4S0t4L2g1dEVhbmUxd1E1bkh2UkNG?=
 =?utf-8?B?eTE1VEVrdm5ZMHYxMnRiOXRFOUM1WThRcnR1azBNR3NzTWVqZy8zeXFlSzNh?=
 =?utf-8?B?aGpzbmxCWWpkejRMVnkrbjAvVGMwM3B0d25Bd1BhenZTS1huaXh3VEtiNUcw?=
 =?utf-8?B?QUJYTy80bklsRWFOaFN0ZlRRNXpXQnAvK2FrSmZEOEFhWXVXVTE3Z0dMbkNx?=
 =?utf-8?B?OXc4TUFvZUpWdCtUSUppTnRMQVp2SzVSSDNZbE1UQnFWcXNPLzNzbGNLNXBa?=
 =?utf-8?B?RDRPRkdtMnhMREhIeHpkS2RrS1VBVGR5dGJ1TlNHWmprYTNhQVpYczlZSWpV?=
 =?utf-8?B?ZHFsaFdvR3B2NHZ2ZXE2R1Nqc1hlUjN6L01IazlsUTJEVDduZ2RpUndJYXZX?=
 =?utf-8?B?VWYwaG4wd3QzNjBheE15N3lqUWJvMTZRQXZ5bmlWVFdTMHFtTUFvRVNKQlhS?=
 =?utf-8?B?WUlwYi9yNzBoNXRocEZ3dDVWRnl2Q1dUZ0Y1dDNXZ1NTTzA0TFp4YXdYSjl2?=
 =?utf-8?B?TWJ4ZStGd0xqd0Z5cFduZ09sTHM4dFlzc3ZnQmcvdEFFT1F1U09HcUNXbVVL?=
 =?utf-8?B?ZVVXam9leVJsd3ZGV3l2cW1uVlBSbXRYTFpvUUd5cklJa0p1L3ZjT3FZUzZK?=
 =?utf-8?B?ckluYWdIUXBqblJDMWh2N2RybWdhTWZWYzFxekhxaENXMzZrbVJSSytOMFhC?=
 =?utf-8?B?cXlwYnhjeEh4bWhKbGFQeDJYcjRRZFE4dUdCNTMrT3pYNGFmcEhaN0treG00?=
 =?utf-8?B?M0tncHA2MDY1RG9ZVUdrZ3dGRGlHbk5vUlE0Y0dBSXI4VldVTkRQb21jYWhl?=
 =?utf-8?B?YlRIdHJCMUEwMjZlaXV2endpTmZydThZbFVzSzFWMEVCZVlyVS8rc3dTaHVa?=
 =?utf-8?B?Y2V2NHRxSFhPa05EN2oza1V3MWk4Q0szVTRVRkpNU2R0QjNRbEM4Ym96bDdN?=
 =?utf-8?B?ZG4zMVY4Z01qWDNZclZHSWRzalNacWdaOEdxMFlhYW1lWnhVNEtOQ0xPN0Zz?=
 =?utf-8?B?Z2hsUnlNVi9GdEJoWG1ST1NSbjJJY1NtK1Q4cmVPb1ZHK2NBb0x4YnVKbDZI?=
 =?utf-8?B?NDJNSVNFckorcW5xeW0vK1M2MURqSHJFOWczbVhxWFdWNFl1bFQ5d3VTcmtv?=
 =?utf-8?B?SDdJNkw1TVd4WjhOdDVoUWVsdnVFYXVtVDZ1THJVNmZCVFBEZjJmZWgwK2JJ?=
 =?utf-8?B?aXR6eXF3bzU5S2IvN2QxQit1QWFac3lxZUl5REZ5NVhBbDZES3hSK1Y5SVdr?=
 =?utf-8?Q?NnrR6AI2ClWX+tLK0Y8CRdG/iWulRJzUvLrsAs9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a521f3a-caae-469f-b1c1-08d94dc1f74a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 10:09:32.5009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4pnaU25VZOaXnRNWkM8eqa4QkRIp9srDtSq6219JliTTOsZZ+S7Y+j4LTHXdj3q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
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
Cc: Alexander.Deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The series looks good to me, though I prefer to use a common logic to 
restore od settings so that smuv12,smuv13 gets the restore feature by 
default once they add the user table logic. Don't have strong argument 
for it unless Alex, Kenneth or others have some comments.

Anyway, the series is
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

On 7/23/2021 2:39 PM, Evan Quan wrote:
> The customized OD settings can be divided into two parts: those
> committed ones and non-committed ones.
>    - For those changes which had been fed to SMU before S3/S4/Runpm
>      suspend kicked, they are committed changes. They should be properly
>      restored and fed to SMU on S3/S4/Runpm resume.
>    - For those non-committed changes, they are restored only without feeding
>      to SMU.
> 
> Change-Id: Iea7cf7908dfcd919a4d0205e10bff91b1149a440
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> --
> v1->v2
>    - better naming and logic revised for checking OD setting update(Lijo)
> ---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  8 +++
>   drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 +
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 +++
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 55 +++++++++++++------
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 25 +++++++++
>   5 files changed, 82 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 3e89852e4820..c2c201b8e3cf 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -231,6 +231,7 @@ struct smu_user_dpm_profile {
>   	uint32_t power_limit;
>   	uint32_t fan_speed_percent;
>   	uint32_t flags;
> +	uint32_t user_od;
>   
>   	/* user clock state information */
>   	uint32_t clk_mask[SMU_CLK_COUNT];
> @@ -352,6 +353,7 @@ struct smu_table_context
>   
>   	void				*overdrive_table;
>   	void                            *boot_overdrive_table;
> +	void				*user_overdrive_table;
>   
>   	uint32_t			gpu_metrics_table_size;
>   	void				*gpu_metrics_table;
> @@ -623,6 +625,12 @@ struct pptable_funcs {
>   				 enum PP_OD_DPM_TABLE_COMMAND type,
>   				 long *input, uint32_t size);
>   
> +	/**
> +	 * @restore_user_od_settings: Restore the user customized
> +	 *                            OD settings on S3/S4/Runpm resume.
> +	 */
> +	int (*restore_user_od_settings)(struct smu_context *smu);
> +
>   	/**
>   	 * @get_clock_by_type_with_latency: Get the speed and latency of a clock
>   	 *                                  domain.
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index 385b2ea5379c..1e42aafbb9fd 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -302,5 +302,7 @@ void smu_v11_0_interrupt_work(struct smu_context *smu);
>   
>   int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable);
>   
> +int smu_v11_0_restore_user_od_settings(struct smu_context *smu);
> +
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ebe672142808..8ca7337ea5fc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -416,6 +416,15 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
>   		}
>   	}
>   
> +	/* Restore user customized OD settings */
> +	if (smu->user_dpm_profile.user_od) {
> +		if (smu->ppt_funcs->restore_user_od_settings) {
> +			ret = smu->ppt_funcs->restore_user_od_settings(smu);
> +			if (ret)
> +				dev_err(smu->adev->dev, "Failed to upload customized OD settings\n");
> +		}
> +	}
> +
>   	/* Disable restore flag */
>   	smu->user_dpm_profile.flags &= ~SMU_DPM_USER_PROFILE_RESTORE;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 59ea59acfb00..d7722c229ddd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2294,41 +2294,52 @@ static int navi10_set_default_od_settings(struct smu_context *smu)
>   		(OverDriveTable_t *)smu->smu_table.overdrive_table;
>   	OverDriveTable_t *boot_od_table =
>   		(OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
> +	OverDriveTable_t *user_od_table =
> +		(OverDriveTable_t *)smu->smu_table.user_overdrive_table;
>   	int ret = 0;
>   
> -	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, false);
> +	/*
> +	 * For S3/S4/Runpm resume, no need to setup those overdrive tables again as
> +	 *   - either they already have the default OD settings got during cold bootup
> +	 *   - or they have some user customized OD settings which cannot be overwritten
> +	 */
> +	if (smu->adev->in_suspend)
> +		return 0;
> +
> +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)boot_od_table, false);
>   	if (ret) {
>   		dev_err(smu->adev->dev, "Failed to get overdrive table!\n");
>   		return ret;
>   	}
>   
> -	if (!od_table->GfxclkVolt1) {
> +	if (!boot_od_table->GfxclkVolt1) {
>   		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -								&od_table->GfxclkVolt1,
> -								od_table->GfxclkFreq1);
> +								&boot_od_table->GfxclkVolt1,
> +								boot_od_table->GfxclkFreq1);
>   		if (ret)
>   			return ret;
>   	}
>   
> -	if (!od_table->GfxclkVolt2) {
> +	if (!boot_od_table->GfxclkVolt2) {
>   		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -								&od_table->GfxclkVolt2,
> -								od_table->GfxclkFreq2);
> +								&boot_od_table->GfxclkVolt2,
> +								boot_od_table->GfxclkFreq2);
>   		if (ret)
>   			return ret;
>   	}
>   
> -	if (!od_table->GfxclkVolt3) {
> +	if (!boot_od_table->GfxclkVolt3) {
>   		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -								&od_table->GfxclkVolt3,
> -								od_table->GfxclkFreq3);
> +								&boot_od_table->GfxclkVolt3,
> +								boot_od_table->GfxclkFreq3);
>   		if (ret)
>   			return ret;
>   	}
>   
> -	memcpy(boot_od_table, od_table, sizeof(OverDriveTable_t));
> +	navi10_dump_od_table(smu, boot_od_table);
>   
> -	navi10_dump_od_table(smu, od_table);
> +	memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
> +	memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
>   
>   	return 0;
>   }
> @@ -2429,11 +2440,20 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
>   		memcpy(table_context->overdrive_table, table_context->boot_overdrive_table, sizeof(OverDriveTable_t));
>   		break;
>   	case PP_OD_COMMIT_DPM_TABLE:
> -		navi10_dump_od_table(smu, od_table);
> -		ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, true);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
> -			return ret;
> +		if (memcmp(od_table, table_context->user_overdrive_table, sizeof(OverDriveTable_t))) {
> +			navi10_dump_od_table(smu, od_table);
> +			ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, true);
> +			if (ret) {
> +				dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
> +				return ret;
> +			}
> +			memcpy(table_context->user_overdrive_table, od_table, sizeof(OverDriveTable_t));
> +			smu->user_dpm_profile.user_od = true;
> +
> +			if (!memcmp(table_context->user_overdrive_table,
> +				    table_context->boot_overdrive_table,
> +				    sizeof(OverDriveTable_t)))
> +				smu->user_dpm_profile.user_od = false;
>   		}
>   		break;
>   	case PP_OD_EDIT_VDDC_CURVE:
> @@ -3262,6 +3282,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>   	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
>   	.set_default_od_settings = navi10_set_default_od_settings,
>   	.od_edit_dpm_table = navi10_od_edit_dpm_table,
> +	.restore_user_od_settings = smu_v11_0_restore_user_od_settings,
>   	.run_btc = navi10_run_btc,
>   	.set_power_source = smu_v11_0_set_power_source,
>   	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 0a5d46ac9ccd..7aa47dbba8d8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -422,10 +422,20 @@ int smu_v11_0_init_smc_tables(struct smu_context *smu)
>   			ret = -ENOMEM;
>   			goto err3_out;
>   		}
> +
> +		smu_table->user_overdrive_table =
> +			kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNEL);
> +		if (!smu_table->user_overdrive_table) {
> +			ret = -ENOMEM;
> +			goto err4_out;
> +		}
> +
>   	}
>   
>   	return 0;
>   
> +err4_out:
> +	kfree(smu_table->boot_overdrive_table);
>   err3_out:
>   	kfree(smu_table->overdrive_table);
>   err2_out:
> @@ -442,12 +452,14 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)
>   	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
>   
>   	kfree(smu_table->gpu_metrics_table);
> +	kfree(smu_table->user_overdrive_table);
>   	kfree(smu_table->boot_overdrive_table);
>   	kfree(smu_table->overdrive_table);
>   	kfree(smu_table->max_sustainable_clocks);
>   	kfree(smu_table->driver_pptable);
>   	kfree(smu_table->clocks_table);
>   	smu_table->gpu_metrics_table = NULL;
> +	smu_table->user_overdrive_table = NULL;
>   	smu_table->boot_overdrive_table = NULL;
>   	smu_table->overdrive_table = NULL;
>   	smu_table->max_sustainable_clocks = NULL;
> @@ -2101,3 +2113,16 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
>   
>   	return ret;
>   }
> +
> +int smu_v11_0_restore_user_od_settings(struct smu_context *smu)
> +{
> +	struct smu_table_context *table_context = &smu->smu_table;
> +	void *user_od_table = table_context->user_overdrive_table;
> +	int ret = 0;
> +
> +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)user_od_table, true);
> +	if (ret)
> +		dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
> +
> +	return ret;
> +}
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
