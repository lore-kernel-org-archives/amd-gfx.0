Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C2CC54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 08:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1348411201F;
	Fri, 15 Mar 2024 08:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LlZm94cp";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65D15112020
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 08:45:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWeSv7tgcBuwKCLDKOC5rvZrd+VD0qXi81te61/jCUvhjPdTK833dvjsTlhlJcN1vDGtjUifJ94vu3mx6v0CVQkfOSyaBE5Dt8AwkaJM8tz4zVj4cAf+o4xqMa4xM5JcwQgN8BkZzmd+37Ahh6xtaWtgVPJfeJxYmM2gUnOixyGbLHNFHnLW0gWRqbIVQBW7nWGDzlNJnXeJmgCcFQUqaYiN66qkXAbZuVQ9OPke17wLF4qVVgIpSlMpXT0EaFys/GyhS4sYSLah9eo+KLu+4GG6YiwPRUW9Pi/0NgCpHqdab6rnomQiLF/hwm4HaCEq6FZV4Xqc4rG9pv0ASKnIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tINGK0u/gHyBwIvc/ZEd7PKN3Cgc/e9xzscmlEw+ITU=;
 b=Aq0jQfvivu6we2TDEu8n+cYWu11zVcqNF/EvAY5nD1ixmhxVsbeWVSpcQDxrVz9GrO+2Xek5HNJwoAHFAyt5qKqmByjq84fKmeMSEoT8AE/rpHgTl7XF0//EWJgnogCsYUW9WrVqrLti9ROELBApuW1OmPVG4rWAayuymhaltuxobk/9BzanwX61RZoVYS+Mzrp+gvolD/YWgDnn0OhF9Tdc0lhVrhXPvx2j1NNqYPMHo736eHx//Zq0G0jsMhT7t5MvhUBAfSUuhqcUegjiJOcnICo4RryJT7OlfduBOiw8208D0fSZVJK1C3cbU/xkI6OQfIwmroLMoJMT76rlAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tINGK0u/gHyBwIvc/ZEd7PKN3Cgc/e9xzscmlEw+ITU=;
 b=LlZm94cppsmQZCPZe3ajsJM02ohPfsoou6GGBeDDyCO3YSDxN2UHUDz2DmNp31GCBv8uPpxPS66PFwz6bxoyytD9nSv3pHGYlDP1CCGM69lglbzpkzgDuAF4/i3BlsYwqMc/rINhXCtQUUPVmfMRDf0Gg9cvAhJKybPE71hmzuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 08:45:13 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 08:45:12 +0000
Message-ID: <deec30eb-4745-47a6-9085-70f2fdfa16f0@amd.com>
Date: Fri, 15 Mar 2024 14:15:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amd/pm: Update SMUv13.0.6 PMFW headers
Content-Language: en-US
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 donald.cheung@amd.com, sepehr.khatir@amd.com, daniel.oliveira@amd.com,
 charis.poag@amd.com
References: <20240315074355.3297281-1-asad.kamal@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240315074355.3297281-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: d9188d82-011b-4e89-1aa5-08dc44cc3a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YluT/YdnlGDXc75iC3LU5lGzTgqiog7ijVdNvpNuJegd+YSlT+NHyNgOQA+m2nDi2JqS3xkdTOHEI8B7sTn/HV5rky1izcgWf0X87mBVpz+YA2ZxwEqdT3MZ60/sXQM6EhDNhxechdhLEcphIVUyzohBqvDUKyXupdLND7zYGoHwSdRIlLitQOUkDXHGII3QOlspU9TPyQVi3EccU5l1XWNAafoSE/lEonBhND/l+52oyH3rHU+iEbBNsP+HxNJckfrLa/A5YEUJBnMp2P7hHQYjHYi4iQBLbuInOecdmHEHSOO+NRApj62WyWPPj1lHnKITQxPxZJBxfcvJEal+Wr8XakEfLY9Lf0WeHtsyMGCZlFM3MT1NMMWLv1ZEnza/rZRVK0aWr5yv53lObhVpFtT4UGp+WAP9Idymgp1EQIxfXWiMrwdpTo8ZfRwm1dT+mfTVi9VJrhkJ4UwXPlE9i8IZebsQNhYTvicl45UpijAAg6XpUrb6vTk2yx+y8iaz0eAVtluQoPUv4gkgiz5uOJDV+3RDyatfOJhuV6avGkLhDK8KKYJUqT0j6O1MKe/zhswASjEm1kFYbkNyORzKRCEqo4czi3QXLOzkMW76IfHjJYH2AvsvDBi7vifmu0eelLzSOvoAmNU0oaH52hg+NvbpkuwTWW4CrOkKkYgTwGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmpHZHp5STg3T1RKSnIwOGpoeWluQWxPOTVRTHRaVkJnaGpFaVJ1d3BQVmpN?=
 =?utf-8?B?cWRHTXhZU2xtSVNSTlFCbW50K3pDYVRONzJ3cXRTNEtDcFEreHJZczJ5TlEr?=
 =?utf-8?B?bUhLVitDdTZaZDlpdUoxWmRySjJqWDBRaDVoTEh5bGE3d0YrR3h5czFKUTdr?=
 =?utf-8?B?bGFGSi9iZUpCd0VLbCtsV3VnVkN5WFJHUlVOZVNoRytKTFhPUVltSExhUDd5?=
 =?utf-8?B?NFIxK3VETkIxM2NDY2tBTGtvMWpTdFFRdlRBVVhlZUx5MzVOeStEOFpnTlFy?=
 =?utf-8?B?M0NLMTNSR3BlNEJ1RW5hSVhvYXJaYi9QMWNxMTJ5WnRybTRqMTg3MlpaMnp1?=
 =?utf-8?B?aW4xSUcwSU5zUEI5bm4rbWU3Ny9RT1I5Y1ZYYjJySzQvUEtiRmtidUJRbEIy?=
 =?utf-8?B?Mzlyb052amFOQ2FCT2djQXFLckRlNjI1L0VQNTZxZXZLQzQ5VzNnWG1zTitr?=
 =?utf-8?B?S3Q3NmFuOHZBUDdEb2Z6ZmQ0eTlaYUM0ZmdsMFFVRHpQRkxRNVhLQWRIUmQr?=
 =?utf-8?B?RFJ5eXJJLzNNU0FlZG1oR2FUUnlSU1VnTGZOTWFGdkFQVkxEVjJ0UWVuTWc0?=
 =?utf-8?B?WjRoQjhPc0pkbVR1dVRBb1RqSDliRWFJdnNGU09BS3JYMXZlS0pXb2FhNWNB?=
 =?utf-8?B?U2JrSU4zUDExNml4NStTMCtxL2puZmRrVVpxdHlTUEg3UitDRUFwYTJPYXFI?=
 =?utf-8?B?NlAzSkxleEloL08zYk5ybFovOUZuVWV3bDRNaGxtbDQxeHJiN3JUbVhvdVhQ?=
 =?utf-8?B?OW84cnRmV0NFcnc3UGhCejMrRDdEQTNPMEhONW13ak5URmEraDZZNHNKMklS?=
 =?utf-8?B?VWpJd0x1N2p1TmR5K2dta0w1aEhZSHRDaE5lbTVESndEa09YTThYcE1mQ1VP?=
 =?utf-8?B?YmxJcy9uOWR2MEszZmMwWVAvNTFVVGdRbVN2eDBFemtZb1oyZWhWMHpCYUVq?=
 =?utf-8?B?dC96TURsNkUzczE4WmtrbDZDb0JaMTRTcTBGZ1hRT29oQmF2czJnSXZTRDN5?=
 =?utf-8?B?RkNZMlEvM1h3WnVzYXhQakl5WXRRYXBtRC9EYlE0d29GYlh3eHlIejhrQkxZ?=
 =?utf-8?B?TXozWnlLeXFYSVNPbFczSWFUNFgrKzZwV29SZFZMRTBvVlJWYVhoZzdlMHo2?=
 =?utf-8?B?VkpQNS9oNkRoaVlwRXdjY0VnQm4xczR2cHJIdkUyV2U5MjFQdWpncDhTSkNQ?=
 =?utf-8?B?N0lXWm4wQXZRa1pHY2NVazU4RkhMeHhxbFFmQml5SWM4ZUM2L0RUblF5Wlgv?=
 =?utf-8?B?R05STHFIUXE3OHh1Y005Nm56VXJHTDdFZ1RPWXdxeU9Jck5WTC8vemN1b3Nk?=
 =?utf-8?B?WVNCa1NONytPU2xzNUdiWXBWdFZ3T3c2Y0ZRcjhrRHZLTkF3eiswRklrcjlK?=
 =?utf-8?B?WTFWejlBdGZyc1VHeXk2WTdVUjJvT3ZSK1o2S3MyRmxuTVZ3YTB5UEtTbW5Y?=
 =?utf-8?B?QU5JRld3MTNZaHZPNUVEMk1la2NBUW5JM01acnlPeWJNNkViTndqUHhuK2pz?=
 =?utf-8?B?Z295dFllL2tDZ3FJRC90WG96cEd6aEdwZnRqd2xSK0pHZWJzdUxoeTA4bXpy?=
 =?utf-8?B?dG5Bd0tUWGxTaWtCWUxDN0x6YU9JV01RS2tCVUJUUHhPY01EQUtVaTdZTkpS?=
 =?utf-8?B?L3dLbVF1UFJvazNDcXlGODJCRVdLYnVaTzhWV1FUTGtEa253ZjNlays5S1dJ?=
 =?utf-8?B?R0hLYS9KT1EyZ01sR1RmY2Y0aXJHQk9GWGZvcUdQS3hNRG02T2dxNXhJQ2hR?=
 =?utf-8?B?d0plMldKcnMrYitYb1dnTEpHQ1BsOUpCR0pTRFZ3UUlhT2pCQllnOGNGcUtF?=
 =?utf-8?B?YnpLVDZsM3ZMaTdpS3laVEViL2tseWtoVG93OERuSmpOWThFOE04eTJNMG45?=
 =?utf-8?B?OWtlMEkvUmF2ajZna3NGQlJmaERjWGpEdVNXdThnV04zVjI1ZjJ5OURVcDlq?=
 =?utf-8?B?dUltVzg5UWZVam1yeWhMTHFlQkdWamNaemZnM0dyNmEzYjh5dGk5RE9uZEIy?=
 =?utf-8?B?THNUenBMZWIwZ29KUmhYbkpRVENPZ3NIMUIvRldpUTF0U0JQaXNRcTF2cUpF?=
 =?utf-8?B?SGtlOUNIUkExRzhEMzJQcjBVbTJha21Wa0V2UGsxWEhnTG1MSlZxM29HNWJ0?=
 =?utf-8?Q?wIvv3tIkDoMOT33lu+BSWPxAm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9188d82-011b-4e89-1aa5-08dc44cc3a6b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 08:45:12.7601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/WsH9+usz9x6lokzt0g2LIMgEEW+05dcf+kM/VueHxRGDFeMHJ4ans3dJlikLcw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8600
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



On 3/15/2024 1:13 PM, Asad Kamal wrote:
> Update PMFW interface headers for updated metrics table
> with pcie link speed and pcie link width
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Series is -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
> index 7b812b9994d7..0b3c2f54a343 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
> @@ -123,7 +123,7 @@ typedef enum {
>    VOLTAGE_GUARDBAND_COUNT
>  } GFX_GUARDBAND_e;
>  
> -#define SMU_METRICS_TABLE_VERSION 0xB
> +#define SMU_METRICS_TABLE_VERSION 0xC
>  
>  typedef struct __attribute__((packed, aligned(4))) {
>    uint32_t AccumulationCounter;
> @@ -223,6 +223,10 @@ typedef struct __attribute__((packed, aligned(4))) {
>    // VCN/JPEG ACTIVITY
>    uint32_t VcnBusy[4];
>    uint32_t JpegBusy[32];
> +
> +  // PCIE LINK Speed and width
> +  uint32_t PCIeLinkSpeed;
> +  uint32_t PCIeLinkWidth;
>  } MetricsTableX_t;
>  
>  typedef struct __attribute__((packed, aligned(4))) {
