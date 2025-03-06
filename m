Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF73C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 11:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3EB910E828;
	Thu,  6 Mar 2025 11:19:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SIwBRD3Y";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC3A10E828
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 11:19:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CO74tIFdtolxiLKi4b1adn+kp615WYdx+ZL+fPAKv037OjO0p4L6INGH0HoTUyLdGkMRomx31HhoKn93/Igx3m9Zey8N+Jett65IQdakCF804/6yjDrhpwOSwE/t6AK4stQH/sHbMxcDh27GchSkmT1hKBBTbmpjiUYVl6HHtp7kjvgPvkYsryUkyfF6IOvRo+GRYNciU3xYnAyIFEVH5VN0w7B1xphZbCwDayxIMOGqVtQg7KOEXP9m9t40ba208gHKn311uq9aFRHmJ0B2Iy5bDcqlr56Er12icgbpBgiTXvmymf0Ygkk4Z3sCEf3Ei93c/iwD2qC2m4AAswtcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RakyK6wHLxJR7sMiGsCp27ipLKcw+J9y3KGQcjx/GM4=;
 b=Z7+9vXddOUPqenAgN/CSfOfT8jKZVQGlmaE554JemmPSfskTK7DcVuAA9W53yx5iyhujQbmQgXIceyILIX2i3OcxyAF3ZiBgjrQ+nJuem/iDUXfVKgpXR2Dltg2I3eQvnThmXm3XSwGXxLqbNfMjdTxlQ7Op0Do3bWhYnDcIZXrfyroYVOV3A/QVlrz65khbSzULJM63aI5gnzlMJhS3xQlZgXa3OvCI5UqCckw6xu806zuF5WwGBTjGfMcEDzNjoGtUwa9TIfNynDfT5QR8DLEwhhmqJzg9A2QUV/gokteFkPe0CLrQ55iwHQn2nRFUnca7kmGC3Y7X8EsyVcxFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RakyK6wHLxJR7sMiGsCp27ipLKcw+J9y3KGQcjx/GM4=;
 b=SIwBRD3YjbzrZixEIvqAgW9ATf6jq/p2+NbKd5LQtN1bdPi73qyOKXfDfylDRKLvf3jLViw6DKGGg4QmYuYN4ipLizHQSxH7tFU50Jd81KtJ1LDYOSkgn4idAjgzH2ZWfOeF7hNxaqsVFeYbsDxZ4UBaCxEEgndZi8CUnHPYzZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 11:19:31 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8489.028; Thu, 6 Mar 2025
 11:19:31 +0000
Message-ID: <ebdd79d7-f172-42a7-ac48-8a096b3ef07e@amd.com>
Date: Thu, 6 Mar 2025 16:49:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] drm/amdgpu/sdma: add flag for tracking disable_kq
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
 <20250305204721.1213836-10-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250305204721.1213836-10-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::20) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: c033912d-57cb-4ecd-d9c5-08dd5ca0c42a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUxpOUtBTkI5d2JiOUd2SEtWWWI1c3JtbmxLY1pTRzJpOG95aXJwN25NUkc1?=
 =?utf-8?B?Ry9TMDRWYUwzQmE0YmN6M1BEdzBSdDZMV2pnYTB3K3FlOXFZaDBJUC9rWkdm?=
 =?utf-8?B?UUFIbWNKTVBya0RmZVloVmxDZmRtSmlrOEZpd2RmTVBzOUQ2QmVJbnMvc05W?=
 =?utf-8?B?dlFnYWtNSkhQMHZPem1Ua3NDcGNCNjZPeWM5ZHBtZnlwNXltMHBOS2I4UDVD?=
 =?utf-8?B?QTZLMWZ4OFJoQVZkNHpKaWZmNTRLVXhxdXZpOEM2bFh1di9uQjVWMHJVRGVO?=
 =?utf-8?B?MG1HRGxMQ2xrUk1FMWRlWUJOdVhqQnVrWFdvWG15c3pvc1ovSUJodnRlellZ?=
 =?utf-8?B?aEY5TzAzVnhqNTcwcEFhMDI1UFcxR0Zuc1E2ZlhMazNBcXZkenZQNWVPVVYw?=
 =?utf-8?B?OEdpN0xid08xc0ttbjhXcWUrbGpWRG1oU0lRYVcxZWV0bmp2WktYS05zajM0?=
 =?utf-8?B?ZjlJR3FxanNXV0tvcFpaaE9nenJPQW9EcmNlM1prTk4yU2NOOUpid0NIYTRy?=
 =?utf-8?B?SE15UnovQ1JjQ2dpbTBhVXhoMFFNZHNRZDhheXh4NEhXVlRQUEY3eVFQaTVM?=
 =?utf-8?B?WThlZHhXMjkvL1pOYmp1ZzlldkQrb1E1bXNuYVpET1EyOTQzSzFhSXVhdjBi?=
 =?utf-8?B?bHcwbFppM2lLMEpCTm5NR2k5OGhRcW9wWEhIbnY1RE03dnpzazFuZjVJYXdR?=
 =?utf-8?B?UGRORFo2emkyRXNxVmJnUEhDSVFxRms3UFljZ3MxNERjQ0lvcE9HYnd6U1Na?=
 =?utf-8?B?K05ZeGczdFpWN1Nxbm1QN2pwd1I2Wm1DVnJmcmU0OEhFU1BMRFU4TjBxbnVz?=
 =?utf-8?B?Y0RETjZLd0ZDZmRENGRITGkvQnRiQm40RE9oV0ZBeFFIMHlPT0pYa3NrU0lS?=
 =?utf-8?B?aFFrOVFwemIzWEhsbkVnNUJUdkdhK2llMUo3VkpUNUU4dlQ1amNyeDZ5SlVX?=
 =?utf-8?B?NUZVL2JBa0g3L3p1R2xDU2NEWFpNOXFxK2V2WjRkNm9xUEQyRVRpN0ZCaHdO?=
 =?utf-8?B?a0h3bkhpa0xoTzROZ0Q2RVpKdWtFZ2YwWFRUWFFBaUJwU0RqNVEzVzk4dTA4?=
 =?utf-8?B?S0YvVElQVDRoYXlRM0o3Q256Y2twd3lMV3JwZGF4MGZPWjJFMDRuamVDQ3Rr?=
 =?utf-8?B?TkYyRWRkOUtTTWJFKzJzRHQybXVoZDNtV2hyeW5JUmVLK01lc2wwTHR1QmMw?=
 =?utf-8?B?MjZJSmlkOC9lNE05WThMLzFhc3o2ODhTazc0YUdjTDE0Z3E0MWxMdnJKTDdU?=
 =?utf-8?B?RmZsTXc4c3l4S0FNMzljQnhWYUYyQ0tjbVE2aDZQMG1jZU9aRkk5Tms4cmJC?=
 =?utf-8?B?bGZmWkg0TnVqdDlORjZWbmZTdnhmdEVidzNMRWg5a2M3ck95VEVTZDA0VElQ?=
 =?utf-8?B?MDVOS2NuUDNERklRT1c2Q1RWK2F1Y3Zuc2dZVmx0ZGxkK01ualQyNjl6WERM?=
 =?utf-8?B?R0JNa05zOUVRWVBDVGtYVWhYcnZzRGdibDRtd3RlODMwaTV4d1FUUUZ4T0dV?=
 =?utf-8?B?aEx0b2JOa2hlLzVlR051VXRQSHBWVXUvSGhJcDgvMVo2ZmV0QjlJK1I3cjU4?=
 =?utf-8?B?bVdlT1VMRkJBYmxqRzZsZnlCdUVUUlZLM1BYWmdOOTV1ZnhFaEgxL2xBU2J2?=
 =?utf-8?B?SHdyVXNJOTF0ako5bVNHeWgzVjBuTHg2T1JEejl3bE9qR1hRdVozbGhTc1RC?=
 =?utf-8?B?dDZWcStteUViU2NyaytqLytFb2Q0RTJWakw2ZExlOXhzR0hlWWh2NzNpZzJK?=
 =?utf-8?B?UUVrTnZ2bDJQUEx1ck4vbmpUTEtkL21ONkI1MVNXUEJRL1kyMDNuNEd2cEt4?=
 =?utf-8?B?b2FWUUo3Z1R6RVlvUENHaExkcGwrdVVYZE5zZzFyYXFTaHE3dEs5U1l1ZjRL?=
 =?utf-8?Q?yrSRkzlSXRNWF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUt3RkdDVEhQZ0dvUnhMN2w2VS85cW5ZQVlTM0MvZ1ZIUVF3eVFPb1krNGU4?=
 =?utf-8?B?dHRtVEEySG9VSVhCVi8wa2VRV2NoVW5OM3NQemM5RTNGaTdJSnU5SjBUeGtu?=
 =?utf-8?B?b2pwTE50T1ZIaVBOd09TTk0yZ0swV3NmYzBnWXFGWW9pYzd6NmRacmlxdzlK?=
 =?utf-8?B?OTYxNG1HWXRkTDA2VnpXTWhmSUR4SW5mdWJaOGdkRnhUYXo3TW56b2R6Uldm?=
 =?utf-8?B?dWFWcmRqY3lyeFF2cUFKSTFCNmgyNC93YnlqcnBJTkZla1llOWZjTXA2MDNE?=
 =?utf-8?B?Q0hWOXg0aTZLNnZDZENLaTZRdUhjOWpKSVRjL0x4S1RxSFB5WkVNaEpveERU?=
 =?utf-8?B?SU0ydzN2QStpMDZ5ejdFSEFIRFc3M2g5RUtZUy9TU3RCMnBaaGptVFVReEds?=
 =?utf-8?B?YndydHJQMnNDaUNJT0E2WDFxMzdNMFE0Yll3ZzBQVGNhVHVlaXNGTDlQOHVF?=
 =?utf-8?B?cGM3VDR2d1JLVkQrd2VUalVhRThmT3o0cGlhZEV6NHBEQ1NwRjU0OHJlbUZW?=
 =?utf-8?B?VnVtR1E5UlRWSUNSL1hVUkdiZnlDdXpMUzc0Z2RBaU9oZHREZUVtaG9IRHFR?=
 =?utf-8?B?UHRjM1JDME10S0lmOWJaR0RITHZDbG5qbHQxR2U0RlFqaWhSQ1N3OGQwS1V2?=
 =?utf-8?B?dEdOMEh1cUx5VUpEK21OdXBFQlpPNGFhZCt4U1c0MlErVnRPU09RQ3dOYzFa?=
 =?utf-8?B?azFzY2oyQXFtNzA5NkR1WkV3MG05QkJnaktCSTlnRW9GUjc2WWFhK2c0STg5?=
 =?utf-8?B?T1ZId1o2dTREeDIyaysxQUdRT2tQVDBFc2dnSVZ3S01XYm94VDlUTVBna3RD?=
 =?utf-8?B?M2w5U0ZQNnNuME55cm1GamdpeThPTk1VZlRpdzJoWGI2bzFUQkRhdGRjZW9t?=
 =?utf-8?B?WWtLUXorb3ZBWWhGNWgzVU9jNmRKZk1yeEdhUU8xWjFvYmhHc2tFZGkrUENu?=
 =?utf-8?B?ZHV6UnFLYVpDRlZScm4xM05LbVZCdEI3U3hScUdUekVwK2xlRGIzVm1GVWdN?=
 =?utf-8?B?YVEvY01UZG1tQ0RheGlDYitmcmFaOHdCRk5wMjhFK1VINVl3Sk1NZDg3dHAv?=
 =?utf-8?B?U2JvcnZrb2tEZjE3Z1FBeWNlRG9CRmh0UGxJNXRGL2gra1pySTcrUGhBNlVZ?=
 =?utf-8?B?VEpQNzFXY2tzWmNBdDk3ZXRRSjh3T1RqdnB6Tmg4ZTE0NFJxVzdMYSthZ1Va?=
 =?utf-8?B?NWh0NTFqSlhXVGVrWS9RNWozME9HcEt5UHBKcHJqTk45V3MrMEtvZ0hTa1B0?=
 =?utf-8?B?UHYrQ0Rtd3VSdTJlZHQyNU94M0RkeWZQZzFjbmhQdlFkZDAxcXZyU3l2ekFo?=
 =?utf-8?B?THpGTXVsS0h2WlYxWjdwSFA3Q0lyUFhQaSsvS3ZFOHB3TW5CeERnVHFoK3Ev?=
 =?utf-8?B?NnBWUGhzNFhmRHlkZFhJNkhLaHlxSFA1WERMSEtaTHFtQlo5M2NmbHVURU1Q?=
 =?utf-8?B?ZGFKd1B6dHhoNGlWR1Z3cy9tcW1NNTFVTGp3aFMwbys1OFJEbU1mV01ZTzFY?=
 =?utf-8?B?QzlSMGRWOThTaTFja21tQjgyL3RWZ0xNVnR1WUZhcmNraXlJL3hyRUF5a2pY?=
 =?utf-8?B?M1hSQmoyL0V0a0dPei9FY1hCaDNlTEttQ3lTVGNjcHBvTE03SlZhTXRRQURo?=
 =?utf-8?B?aXFzaGVqelY3QXp2RlhaNDBoZ3ZNMlArZEFNWUJMTXBLZkJ4NXN0dlFXZ0px?=
 =?utf-8?B?Q3RVbG1sN2lVZm96QmlWUndLVUU2VDZGNjhpM1o2anFVTkRtbkg3OE9pVHln?=
 =?utf-8?B?VWk3cjJsNWZiTCt5bGVpRjc1ZVNEWUJkMi9RMzhVTTF5K3Zja3NqMG5qbjg0?=
 =?utf-8?B?dGZXZHBzRnd1aWNMSk1ESVRVOGxKMWh0YmJxQU1VR21abzgrelZZSFFNcHJC?=
 =?utf-8?B?UzBwNlh5bnFnWFEralJiWWZzcnZCaUVnTkRnMzlLcTJxRHBQbEFkdGhkc1Q1?=
 =?utf-8?B?aTVmajRodWNJaXl3QlhnM0VNSFZKdTZoeTVyd1BrMTVLMTdMeEJPaXRqbGVs?=
 =?utf-8?B?TFhUNFFaTkI3czZSdGttSjBENlAzVVI2V0ExeFpYdVdUTGRaTWd1cEdVa0Fp?=
 =?utf-8?B?c1FnbVd2UVZjcWlycGlrRmhjUnUvNjZzZzNhcWsva3Rya1lGbEdCelA5U21B?=
 =?utf-8?Q?QRS6IyQOId6+W6H5clqHlNBNf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c033912d-57cb-4ecd-d9c5-08dd5ca0c42a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 11:19:31.4904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYIlS6yBsxHRcmdm9krtqfQdgOKaj0LM2VR31hiRddnEl4oe6dlKvvnhxw47L0YqwHdPlu9hmdMiv9ltXFwkWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 3/6/2025 2:17 AM, Alex Deucher wrote:
> For SDMA, we still need kernel queues for paging so
> they need to be initialized, but we no not want to
> accept submissions from userspace when disable_kq
> is set.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 9651693200655..edc856e10337a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -129,6 +129,7 @@ struct amdgpu_sdma {
>   	/* track guilty state of GFX and PAGE queues */
>   	bool gfx_guilty;
>   	bool page_guilty;
> +	bool			no_user_submission;
>   };
>   
>   /*
