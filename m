Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A201E7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 20:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D578A10F0C8;
	Fri, 13 Dec 2024 20:26:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lh5PDQv3";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0478910E1C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 20:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjhygcvfRPNl7CqlYXMvv8jbasq3CS/L9Cvr0gbXeLNU4/uNikgBgyqvg94VHX+YnqnUWh6/JGJmFbCtmH2CouWlBAdY9dLpluhQMZYqRq4mD+KA9qOtZmLUxD5urxTLkFyV2Um3FUHyt22Bh7qAYq/rGQNLk468kPDeWUxWxIVAu0hklpTp2VXklZgFaAfl7QkFtOmDHlxEtM/tHbRUd20PLq8OCnhiCZ7vXDx7n/z6ETHaPhQLsEWwuyQ+YB8a2KOUxEYBc1OgVDX2dzKO+k7yup1yQWbgGVIRvO4XvwLK1B4Hri1Q7V0w8ngnrqG51C1QGIY+rKV3gQ+t2UCVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGkbHOr4CnbIb4/h5hr9TTAhIyGLv4sO2H85Cfcz4AM=;
 b=bmpKcwIbEy5nBxPDsIRLnWy9afNPMjGdYlR+kKB2HpkKGbSlUX+AxYD1FditiKeUcEyZKJIq29fj4FUk2Wu7loMziapMz+ECy8jSMGy9sO3axrKSJkM/IOFTR1tkeDxoWCIYsEtQXpzPvGhhmAv73sWK1pfqo7WpGRE5y1qtwGtMyMju4T1/+jS43GnlUyIc42QjJtwLNhuum2f7Y8LgG+CRlIhnAM4qH30Kk7slUA6fx0ZNi3LQX0NV5vIeqqWBd1c5jVA1vIWKUiXaDe3evJ1Ad5rT94Xc/DlECvOVjQeqylH92+mfPoXn4J5fWsu3H+yRU4G0dkytDL0wV5tFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGkbHOr4CnbIb4/h5hr9TTAhIyGLv4sO2H85Cfcz4AM=;
 b=Lh5PDQv3Y7cJ+ogLCgZlv2/2ieLunV3zJpntHb8fPm44G/1L/mIjf75PDq8vmuMI/FMcoxYTHoLPI2CH2Qs9dahGLlLZ5syCldOif3AhDA28hcSMs0U3kQv2jVxUHCRAz+axUeXjIzP03r6bmi4Kc6u4QWXvz1mxc8dtbPbGwlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 20:26:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 20:26:37 +0000
Message-ID: <119c205f-a896-4f11-898c-cb2e6361fd33@amd.com>
Date: Fri, 13 Dec 2024 15:26:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: enlarge the hashtable of kfd_process
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241213065234.20998-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241213065234.20998-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: QB1P288CA0013.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: b938b9a9-7554-46b5-7e8b-08dd1bb471aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NStPQ1docnh5ZnFtMEloUzlJSGZxMkxaMmlFYUJzRzhydEdpOWE4SXErN0t3?=
 =?utf-8?B?ZTdrVFdtbDJhUUVvbmN2bW1KaCtxME1LdE1Cd1BkVTQrZ05jcWNXZFFCRlhL?=
 =?utf-8?B?d3ltY0YxRzZadEtRQ1h3ZnNoQjFWN1hLY3kzMnNxVzhubjNhWFRoTTZKVTBv?=
 =?utf-8?B?WnZ0L3BlZE5MNTdaL1M2ZVd5cDEvMnQ2RmI4Tm1yM0Jqdjk2KzhDdFYwSi9Q?=
 =?utf-8?B?bHdOOEN5bXFiSk5GOThTZUZJN0ZNcnFKSVVBYWhSMWhnME9tVC9nK3MyZkgz?=
 =?utf-8?B?YTBGMWg2eVM5TitJckoyWUFrOCt2WGVGS0RWMno4V2d4bmdiWFQ1MU5FTG1G?=
 =?utf-8?B?eThPRnc3UlJCa3I0V2lGNnRkZ1BvVXZCRUVoVmozK3ZJK2x1Yzk2WFYwQ09u?=
 =?utf-8?B?UjNkUWZrSEl3OStxMXZaZWN4eFNPQmwzVXI3UHpHN3BFK2JjQ0hzRGp6ZXh3?=
 =?utf-8?B?K0huck1GNFVCbVlVT0x2MVFnWmJmLzJwd1l2NW1KekVyQ1BZUWh5b3RCalo1?=
 =?utf-8?B?dUg1Y293dytNOHd4NVQvNjErajIrUjJyYzRXckxOVFN6K0dGOFNwU3F3ajJx?=
 =?utf-8?B?NlAvdTRCSEF6aTNYWitxRmtQejFGOUZ5VFRIWnh5NUNyY2o4R2tqb0RjNHoy?=
 =?utf-8?B?RTMzWjZLZkIvOVVYQlpBV2Z4dEtTY3dWU0ZwUHd2Z0NnZVVOK05rOTBieHE3?=
 =?utf-8?B?bUhuNncyb1B6dDVXN2pkWTZ1RTZBUG5qSXFqSWVTOFVJYWlZdHhXdEdDbzIw?=
 =?utf-8?B?VUtDU2libkJ0OURqdmZURW5KWXVzT053dEVNUHlSVGpqc0hGMXpEN2dEbFYv?=
 =?utf-8?B?QVNXMEh6blpENGsxOTlZdlhOZXdWZnBEZWQrbzE5WU5wd1o2QWcxUTZncHla?=
 =?utf-8?B?b3c2bGYyWUFybHNrLzdZY3czVldMdVBXeStTNjBLTFZBQ2h1MlpNelM4dWll?=
 =?utf-8?B?bUdQRTl3bDh0QnVOcURaY3lVVHkxZHFWcmRmNTFnZ2NjaVQwME1hYXZ0cFJX?=
 =?utf-8?B?bkc3LzdpakpPM2poWCsvN0FXT3pXUTM5bi9ET29jQUk2cDlVSWduUm5ia1E1?=
 =?utf-8?B?c2pJNkk2VENxSTVZcDZ2ZnB6eFJRUVUwd2FKcDR1UlUzbDFlY29oQnRJc0g0?=
 =?utf-8?B?SHdwWW44TDY2Zm9LYUErSHowZGl4VlFPSDM2Vlp1U2FadEVrTHppZ2Z6cloy?=
 =?utf-8?B?R0oxUXdYUXRNWTZjRS9qREc5RzJqS3dJWWdxbThremp2dmJGbVFmMHZIcDFT?=
 =?utf-8?B?NVRpRHFaYkdqbTZjeGVRcnE0V3NnTU9xaExlQ1ZILzJyejRYcG81amVUVE9O?=
 =?utf-8?B?ZDZBN0ljZnVpUzVDa0VaNk5ZMVlqMFBZU0Z6SDJYdU5jR2t6eG0zaElkNnlD?=
 =?utf-8?B?VlkrditxQWRmOGh5SjJkRE85WDFOVGl2MFBqSVFBTTlRODlWU1NFVHdXR1FY?=
 =?utf-8?B?SUI1dkQ0dGRvWlpjdjlBbCt3WmpJeDFTU3BYSGwxRnhJNG1vKytiVXY1a0pX?=
 =?utf-8?B?M3RqVFNteUtGOFpuMUtHWk9DM0g2czZFU0hRL3hQbDJnZzlnY3IwTGNYRmUr?=
 =?utf-8?B?bTViWUp6NG81V1FsbGlBNVFPa1NuT0R3UC9RMGRkNWdweThuenB4RnN6cE9v?=
 =?utf-8?B?Y2NzZmgvYzVJZVA4M01UM0FaWThZTW1INFdhOVlWcEV4UDFyYi9ubmk0L3B1?=
 =?utf-8?B?aTlpWGlzWVZnRmtCVnN5TnVrVEtCWmdzaXVrNDJpeUtHL3IwTTcvOFRHTUdR?=
 =?utf-8?B?RUpoWDhJMlU2REdDMzMzclJvb3BFZFNUL1BJMFlnSFE0dUpYN2xmVjA0TGx5?=
 =?utf-8?B?WnRhY2NpQXBjSFpCVmt5Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTRwazJDS1FDYjZ6WEl3NEZrd0x6Z3E0byt6Z2ticVRGaktuekJKdVlLSEVt?=
 =?utf-8?B?alFTZ0Jhc1VIeGNZbTFiQzBGMmJSWGtMYWdsV2NtTURGMzRXcHpHTjA2dlN4?=
 =?utf-8?B?SGJrOHE0cnFMSWMvS3dhazFNb3UxSG1MTTB2UFJmYXBCNTZOOHFmSDFhTzZZ?=
 =?utf-8?B?VEgyMURHOWc0U1QxWVF2alRSZmFOSFR0a0xZUmhwZnVZazRXSTY1a3FScWdJ?=
 =?utf-8?B?WHVmNTBDUkw1M1BwNGd5enVkU0gyV3dtTW1pVlZBdzI4MmNqTjQwQ2dXbyti?=
 =?utf-8?B?MEE0VFZaSzZ0TjI1QTMyWUxmd0hRVXJRM0U0QTJQRkJoZWxodG1QYzNVNjBY?=
 =?utf-8?B?WE9VOUM1dnFxSnBHeWlvQWNpNDRGaTNBVUJialBKNFovdS9NeDVGY0JhZTVa?=
 =?utf-8?B?UGVackVQeDJNRVV2RXNWMzNuclVGWW9GejMrck5KOW93VUI4TFJGRnd1RnZJ?=
 =?utf-8?B?R3hua05NdVlzRU9rUDFCbDVsRVN1NksyYWIvRHhTRDNnaXJPZHV0cmJPRGNK?=
 =?utf-8?B?bXQvc3dZVk42NHY5SExVM09EYVNqSzdwdEJTNzJXMUtxOWdNMVNoNlROR0N4?=
 =?utf-8?B?dnhrektPT0tTTDJLYkRXbFJZMkRJZHVQNjI1c0VmQWFlWmVOZnhnc1pmdUxR?=
 =?utf-8?B?Ti8wdzhHMXoyU28wd0Q4ZmhpS0RjMWNxQVFaVDAyM0xBemlla0tLSk1jZ3pz?=
 =?utf-8?B?emI4Q1E1YnAzYmpwdnR1ZUM1cGl4SEhTNDFNS1VmREdSV3JYN2pTbXJzcTRy?=
 =?utf-8?B?YWUwSHJVVm4wVWwwbGFpdnZRTlFQemF1OXBOZzhOQkUyQXI5YlR1ck9CQnJP?=
 =?utf-8?B?Q3dOVTZOcmIxUjRKZ2piMFFWc3BVeTl2bmFuRWh1Nm5PSEcxejhqUUl1RUVG?=
 =?utf-8?B?eFpna3JSVjRWV2hldlEwZ2ZLc2lVME81eUlqc3NuRkdDM3FyYUxUNENnWFdI?=
 =?utf-8?B?KzByUjFNc1ZkSWJlWSsvQ3Z4V2s0RkcrOWYvTHhTL2J1Y0ZkZ0VqeHBJblpX?=
 =?utf-8?B?NTNkekwrMXM0OVZpbTZjNjdzczUzbE9tak9oTTdiWkhIZGc4MlZIN1dDc1Ba?=
 =?utf-8?B?SFYxWm4rd1BiUnNMOGo3ZGFQUWlsRHBsQlk0eHR3emlLbTJ5aXNtK0duNnBC?=
 =?utf-8?B?UXFDdlM3bHhuQlorL0lJcjhjN2k0Z0NpSFhRcUxVY1JuK3VCZjZoeXY3RTVX?=
 =?utf-8?B?a2tzbEtHNGdHMHJtemNwU1ZpckF4R3V4WmduWXpkV1FGTERSaUN4SnBNUEFi?=
 =?utf-8?B?WUFZTE1qTTUxY2ozKzR4WGw0VTZvSXFrVTczZm5EdmhLNWh3d2J0MjR6dG5P?=
 =?utf-8?B?RlhZbE4vV2EwMFZMK1Y2QW1vbHJ3OEFReCtRMG9sMHd4TkNGTTQyWVlocTQ4?=
 =?utf-8?B?eGRsa3prb3ExQTFMcnhnaFFIUWJodTRSenNtMmF5c2FramVOS0JQV1JXcVpD?=
 =?utf-8?B?TTBRNjhGSDUyVjVCZDFOcFNaWWQyTTRFaHMzR040SG13QmpZcUx6R3BIYXht?=
 =?utf-8?B?Y1JKYVNJU2x6OFRIZzFZWkg2SE9ua1pib3J5QkhEY05Bb09FTWt0OTNBYU1P?=
 =?utf-8?B?QTluOW5BYVFVUzNwZDJPVjNRMlBVbno0d05KUGRXekRITjNsUnorQmZRUGVU?=
 =?utf-8?B?bnM3VzBubGZ0NmY4RnpPQ1JxUkVzQnp4aDdiWlR4bFB6bHRpMHBOdEJZRUls?=
 =?utf-8?B?NU12LzB0RldTTGdMc25VallLNlF0eFVjc21HTEJPcDdmSnpwQWxjVk91L2M1?=
 =?utf-8?B?dWhnK01xRWxZSW1HR1BHZWVtdm9RdGd1UG9XYWwzYnVpUDJtOVY0S0VTK1dU?=
 =?utf-8?B?WHZHdFJsTjZzK1J6Q3ZoNzVjZVVmcXZlakJ6UXdVU21rSmdJcHdkalJxckN2?=
 =?utf-8?B?NUY0QVhnQkdOcm5LZVZrQUdnUklPTmxvN0pLR0dtcm5MRVlQb09KLzNtTXlQ?=
 =?utf-8?B?aHcvaGRnaHBCUVV3WjhKYzlnTzFhNHgxOC9RbDJOOG5HckFkcEhSMjhpNVlr?=
 =?utf-8?B?cW5PcGRlMUVQNzhvOTVLSHVwdGhLZTBKMG5PVCttcFQrRVBSdVJJODQwdkZT?=
 =?utf-8?B?S29RdnFNeG0vV0o5MkhmVDFsWTRPMHVJNmh5L3NVaDNwV3JQdzgzeXNmbWd4?=
 =?utf-8?Q?2R+M6nm9cMKy04AIGskJzExwq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b938b9a9-7554-46b5-7e8b-08dd1bb471aa
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 20:26:37.2965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQUUMf4Y8zq4SZPV8gEsF82IhgI3AUCcWHLsZI/6VZ/JgWOeJZVGLW9VFETuz1nhgkJtiMq/NNoodLQxVaRghw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695
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

On 2024-12-13 01:52, Zhu Lingshan wrote:
> This commit enlarges the hashtable size of
> kfd_process to 256

That's obvious. Can you state the reason why you're making that change?

Does this change make sense stand-alone, or should it be part of your 
multi-context patch series?

Regards,
   Felix


>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 9e5ca0b93b2a..7b2049720c6a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1004,7 +1004,7 @@ struct kfd_process {
>   	struct kfd_runtime_info runtime_info;
>   };
>   
> -#define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
> +#define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
>   extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
>   extern struct srcu_struct kfd_processes_srcu;
>   
