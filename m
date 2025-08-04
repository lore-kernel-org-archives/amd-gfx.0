Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B22C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 12:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89CFB10E44F;
	Mon,  4 Aug 2025 12:25:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rwTS8ZAT";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD6C810E44F
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 12:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfX8Y0C1OGiSDzF8h2SGxLmAou0drOsGCbSkUNjMvnHRVPDpRP02nTUsZ95ljG2JajfyUnLChRE3TcagCCkEIwzYCFoRxLoIH+xBN3wUmMExfQxIZNI6NXY24K4yqBvExJbcdZSdUPcL2P2WPTO0eXYUrGNmRx6mnhk8UGr4xRn1PjQffS40i0p1DFn6MzH+q2d/yKK3spTX2NmwOd3jVN+j1HlB89wzW4eyWXqxt2VT0VpspwmXraD3AOUWJmhL+7J3x1wtjTC/8Eeznur6mEDqpFbeEV+dlXo5bPn4z6nKdoRWlprum9MUQoeCLymYXwhLjIQ7XP4NlRP76UKQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4GkGD9SU/Xya+4USDXTOj3USWDhChmONc34bvC2oew=;
 b=sTrPHWXSrDoDuYix5Fqe7R6kQZsCmaytoaNDPcMg85gIvji9V7YYFY9Mc9JCI88Ml8meogs2HlKsdhY4BQSZs9AfVU8xX6TfFzSFlY5m9+jE2NqPQJN6ENfHjZz6LKo320Tws9I8yB6sahPvQT0+Q8rdy8PBnZBu9fRaNv8bDDe4uTQttcnpS/MyHwPh4JMdHPGpVk5NGl2pdALMmnX8uAP0rdNknweY17+k7XP9gBIwD2tYJFJA5QjhgLGu9YoFiG4L8jQpO84v+C2JDAxTypzY05MRPxSg27xTkkE9wgnFsBZ2eeGJ7bioWn0MG9MXc+l2BQxEg3CA0jFuRS9PEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4GkGD9SU/Xya+4USDXTOj3USWDhChmONc34bvC2oew=;
 b=rwTS8ZATayHTmBea1SR42X0mzSRRv6HiyqiKZsI1i10OYJ9ZXfQz11EpZSlqDGDpJGhTufaPCdaMDCa0JsjmFFksftCDJDSGViLSOROkBCV/GTcHMnRs3SYuxOwpfigZzUk3VgrronolvhmFOlUo+MEbrrDRONpDGJg+UhWYq5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Mon, 4 Aug
 2025 12:25:22 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 12:25:22 +0000
Message-ID: <5f02aa89-c25d-4b59-915e-cabbdf188309@amd.com>
Date: Mon, 4 Aug 2025 17:55:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] drm/amd/pm: Add temperature metrics sysfs entry
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com
References: <20250804110539.637463-1-asad.kamal@amd.com>
 <20250804110539.637463-5-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250804110539.637463-5-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::18) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: dca09b3b-6942-487f-e919-08ddd351fb17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHNsN0d3VGhTaUxFYlR2MmJrMEtJZ0RXeWVUOWxyNDZJZHZLMVZqU1V1QURh?=
 =?utf-8?B?eUhwYUpDcU5DSXd0bm1pY2NhSTkwTWYzQXdrcWY2QkdPakJFSXdMWVV2L251?=
 =?utf-8?B?a1dka28zT2Q0djZTc20rYnNFbHZpWXlHcm5mSHlDZFBHekdaMndiTExHc21R?=
 =?utf-8?B?eVBoVTlOZldIQUpPUnh1VEhkM2Zua1E2MzZ2WkNsMVg0aDFtZkpLb2FLcmJZ?=
 =?utf-8?B?QnQ2MFcvL3M0MGRWM0NLU0UwRXdaWUhsNmw1WFhRMUE4b2RuWTlPQWtaUDR3?=
 =?utf-8?B?SmdOcDRzd1B0c21CTldqS2hEUEJRZU9TZmxvbVF3aGFaMUdSSW1aM3RIcHlx?=
 =?utf-8?B?THUzRFBScnFUSmVzWkl5M0RnemJOWGJDWVZqNlJOR2REVDlvaFcwblZxNzh4?=
 =?utf-8?B?MDEyUklOUG9NR05Kb0dXOXhNVXdRSWJJWWlNNU9oZy9kem9iblZmczkvMXlX?=
 =?utf-8?B?K1dLdVJYaXUzblBLM2tQU3VGRVBPSm03TCtlR2pPTDJJNGJuZnlLK0lIMDJU?=
 =?utf-8?B?aGg1cnFvcmZGVER4aEdTbHNGc2VRaDVGRVYvQWpBYXlRSXlESms3R2Zua0FJ?=
 =?utf-8?B?MmRDK0dDQ1hxSVhDVVZ4eHJxNng3SkZCZmtxVHZBVE43Sy8vRUNTYk1uY3Y0?=
 =?utf-8?B?cm1ldmpFaElSdE5BRlVoUVFhVnVXV2JQcXN4cUt5NXRnQm04YmRKZkVNdUg0?=
 =?utf-8?B?akFMWjd5aXRRVnBiejhtV0NuQit2Sys3cDFMZVBXMzZqcUdqWXY1bFVDY2pn?=
 =?utf-8?B?Yjhwbm5JSGZKOUtDM0c4MkY3YWlRWWtqelU5Ymx4Zm1YNUJ4MEJqNk5tVkN5?=
 =?utf-8?B?bkJ3ZlpWSFFvRHNUNFNMTDdDR3JOa3diTzkyZWJRd1Jwd05yeW9raTFTYkla?=
 =?utf-8?B?Z3JkR2N2SGlMQUR3OHlsN21CeGNmR3Axd1EwdW9XMW9OelJjMnJrRXNFcVdm?=
 =?utf-8?B?T0ZmSlN3aWdROXlGNktGZTZnZW9UdnhzN2ZVdnN5c3RYb2tCUmJ6aWpzNTVl?=
 =?utf-8?B?ZzNWbVlRblN0ZGdsQ2RjUzVXaGs1ZzZmaVpQaEk3S2Myczg2b3Rlb1M3ZXNL?=
 =?utf-8?B?d2xMTWRsZUd5OVdQZzVvWFF3aFZBMTZoOFRXTlJicHZ6akV1NWtMWjVMNlVy?=
 =?utf-8?B?cDM3UWtubi9KSnRkaXBRK2cvcjlHNmlXQlN2eWpaMGdxd3FSZ0dHQkdrWkY1?=
 =?utf-8?B?S0puZXNpRTBKSEYyYjZOQXNmNmt0WTVFd3dPSnBsWnVhbGUvK2c5S3A2d3ZM?=
 =?utf-8?B?cTRjd1h1eFY2alMwRkdIRTNRVDdDVTQ4ekUzQmsxZG9UcldMb09GTXEreDZm?=
 =?utf-8?B?MW5lbkhQaVNtVXpFaFp0Zy81bVRCSmlGZjA5cHR3SDJZcGswTTRIZnQvWTBF?=
 =?utf-8?B?YStFVU5jRklSSGsrZk5WcXZjdnVkT3Q2SDl0d0tnZ3RLMFlCK2xPRVlkWlJq?=
 =?utf-8?B?VHV1RFNiTUVuMngwNnkxc2NzVHhhcFgzREJiZGVKY0JoVDhMejNQUU4rUkFZ?=
 =?utf-8?B?N1ZNR2dXbUxXTDFuUC91Z1hINjNmMDJUZm9yOTNjRHFLRmgxQU1aVUt3SW5m?=
 =?utf-8?B?UkJhdkx1OG43UXdzNzlKM0N4alYzNHJ1U3NpSmprWkgralNnaUNYUHFtTThF?=
 =?utf-8?B?Q2xKNzhscFNBTW13bC9MUVFwTkQrTWJHcjdsaXdDTms0Tk9uSFpVM1dFUmdl?=
 =?utf-8?B?OS9JNlYzRjN6Z2JSc1ExY0Z4SVJqTlBkTW9nMk0vMTV1RmIwSy90T2JmaDds?=
 =?utf-8?B?NTFuL2wwNkV1TytwUVVKYWp5WU4yNnhsVlJHTlpSZ2lYcm9oNElnWjVBbTFB?=
 =?utf-8?B?R0lIM3AyUEtrL3NJMW9NVFNPTmozdFYxOUVMM1BJd3lzSzU0NllEWjlGWEJj?=
 =?utf-8?B?ZUZZNnBjNytxSUpWRDU2eEE5dFFoM3VLZjJxeEwvdkVMMndUTFMzWEs3YTVF?=
 =?utf-8?Q?XkRH8msG16E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm42d3o1V0k2QjQvSU9yYkFWTmUwd1lFd2VIVm5mQnA0V3pjY3hXZjNoWTd6?=
 =?utf-8?B?a1k2czZKK0FiN01NVG0zN3JRYzg0SGVnMUpiMktNK1dERWNrUnRGNHpMUTVR?=
 =?utf-8?B?K3FFVXhrKzN0d2JhSW5Jem5hODdjbkUwZVhmMkpzSUdJYnFZMEdyRnBuMG1K?=
 =?utf-8?B?SlR2bXJ4ZXpxWXo2SjA4Y0VmbTd0Vy9OVkF6ODBaYWdBa1pCRzgzV1djNC9y?=
 =?utf-8?B?cHE2cmgrYkFmWVBwL0VVcFNPVHBmTFRVZnl1enRRVEtoZEhHNWZBeUdqNzlV?=
 =?utf-8?B?WkxySVZkSGhWMi8zSzA2WVROMXVjZ1ZDcjJGSklMTzhGenRUYWNRSzdHSXli?=
 =?utf-8?B?V3hPaTVBNGhTa2tSd04vRlNNejlvQW5OM2VXUzJidFNFdGVLM2llRDY0K3R6?=
 =?utf-8?B?eHhvQ0srWkpYemdTNkVndW9XQ0I1MHNxS05pRkh5WmdHRkNLVmdmcmwyZWFC?=
 =?utf-8?B?cmRyc3YyV2pFdE1aYStDTm9YUHRPb29tWEtZemx4dE5iNmpnT1JwczFCa2ty?=
 =?utf-8?B?K1ppdXpsY2VrOEhwZGJ0ZXUxSktZOHZhNXc3djYzck45VytTZEZybUs1TUZx?=
 =?utf-8?B?cVVIbkpuUkt5M3JPSlB5NkpYYndWTHJJdHAvZ2hJQkJpR1czYVZqWVB6Vi9o?=
 =?utf-8?B?ditqZ1dSUnhvMkt4ekh1V3BWeTZLSXo4TE9mem5NRGhBYnQ3OTdsTGlnSFJL?=
 =?utf-8?B?ZmQ0aU5qYUp2K2dkZEpqOGVZa1RtZkhPbXlBUDZkcTZUZVhHMnhwMHFCQUFa?=
 =?utf-8?B?eEVTY0tkSE9MUDR6QnZOa3p3eWxuNnYvUmt6bFlrQnlvSmw4ZjRNOFNTS2d0?=
 =?utf-8?B?VE9WekMyK0l4bTlwUXJ0dWlTNDdmOStLOVRJV01ldlNad1RHT0s5ZDhMK1pL?=
 =?utf-8?B?U1RhcnRVWVphSUZvWWx5bWo2bnRDZ3NNbVNUTk5PejJFR3VMS0Mrb0NVM3hh?=
 =?utf-8?B?K3lWNm9UMlpEejgwN3VnOWtBYlZGV2d2MzJUSUFPN3QvNk9IWTAzWFJMak9Y?=
 =?utf-8?B?eXlTVWdmNStZYnlvK09Za3Z5MFBuZXlpVFdyanE5eFRaVW5HTG1MWlFPelN4?=
 =?utf-8?B?bm9SZkRnczVDYUE3YXJuRDgva2padHdEa1JwQ3RTaWNiTDVwYkM3QnMrNzV5?=
 =?utf-8?B?dGlNV1ZORzUrbC8rQjBqR2k2OW5MN1dOYi8zVnRlWGRXT293TzJLa1dNbHo1?=
 =?utf-8?B?dlBVclZHbGpZRk83MlppQ3VqMHZkRVFsdFB5amphdWhEUFdOY2l6emFsalc2?=
 =?utf-8?B?WnByeVJVRVpJL1owSWh0eDhYSXJEK2N6NUxROUJoTmFmTnFUYnRDNWxtaTk2?=
 =?utf-8?B?Qm5rS2ZkM0p6cVYxVFI3Q085U2htNWJ4cUFNSS9xWkowYmw5T2Z2ekhvSXRS?=
 =?utf-8?B?M3dTU2xHaEJSMytVL0REeGZSUXU5VXlxYUZvdmM4eENQa1hJYm9wUTJTYkEr?=
 =?utf-8?B?cm9XSlhBRDhuUVlOMFVVUzZMTm91UzB2bGdNa2EzV3ZpbmlTQlR3MzlpY0cz?=
 =?utf-8?B?NWEzZCt6VmE2OHI5R1V0ajdZM3FNc09MMU9qNkdVYWFmbXo1ejdCS3JGbXVp?=
 =?utf-8?B?cUhVQi9HK3lJdlpXVDdvUHFpM1BjOXlkcU54R05pS1VkajI1VHF0OXF0UDJS?=
 =?utf-8?B?QkcyeWc4UGQwUW1zQVhJUkJERURiS2h3QldTZXB4dkJ4a1AzUDRnUGFaZFZD?=
 =?utf-8?B?RStkc1JJbXlLZjlVKzBkQkttSWxEeWtFWHRuU21QMTFJRXlkb1BMNEdxdnNt?=
 =?utf-8?B?WFFtUGM3OHZCVTk5SkNjMm1DallyUWVKUW1VUWxwTlBuSzBkTmtjckk0QkZz?=
 =?utf-8?B?MWNCWUFxN0REb29rNi9xTFFxWXFSK1RNL0dpaWJTd21QTTB1V3Vpd2tMelJn?=
 =?utf-8?B?OGNrQng2SHN0bWt6bXJ3aUlBcGVBMlA1VmNyMkFlK2EwNzNmRTZ3dHpTbEdF?=
 =?utf-8?B?ZTl1dmhQQlpJVVNDbFlTR2dPVUJkU3lSekxVcmVCSzRRdnVvd1NCQVdPQVNW?=
 =?utf-8?B?cnJLRzFzbnBpeFZsQmowVGtNOWkwYkcyUlJjWnNUQStEb0VzQ21ndlUzZ0hZ?=
 =?utf-8?B?ZHlMY2dXcTNOZjVNTFBSSkdKWTVpY0d0TkdvV21xNTFYc0RnQzA2SGpSc01i?=
 =?utf-8?Q?yF86hg6cM8EJzcQLRN1jLXjIR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca09b3b-6942-487f-e919-08ddd351fb17
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 12:25:21.8987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrkAne1LGVMp9CIwhWH/CSlkQ+BkNY/cdhVvCWxEzCuwk/SiEHsSp4vuDqqU3thN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451
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



On 8/4/2025 4:35 PM, Asad Kamal wrote:
> Add temperature metrics sysfs entry to expose gpuboard/baseboard
> temperature metrics
> 
> v2: Removed unused function, rename functions(Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 135 +++++++++++++++++++++++++++++
>  1 file changed, 135 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 8d934a365c3b..75b06ca7f20a 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2080,6 +2080,134 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
>  	return 0;
>  }
>  
> +/**
> + * DOC: board
> + *
> + * Certain SOCs can support various board attributes reporting. This is useful
> + * for user application to monitor various bard reated attributes.
> + *
> + * The amdgpu driver provides a sysfs API for reporting board attributes. Presently,
> + * only two types of attributes are reported, baseboard temperature and
> + * gpu board temperature. Both of them are reported as binary files.
> + *
> + * * .. code-block:: console
> + *
> + *      hexdump /sys/bus/pci/devices/.../board/baseboard_temp
> + *
> + *      hexdump /sys/bus/pci/devices/.../board/gpuboard_temp
> + *
> + */
> +
> +/**
> + * DOC: baseboard_temp
> + *
> + * The amdgpu driver provides a sysfs API for retrieving current baseboard
> + * temperature metrics data. The file baseboard_temp is used for this.
> + * Reading the file will dump all the current baseboard tempertature  metrics data.
> + */
> +static ssize_t amdgpu_get_baseboard_temp_metrics(struct device *dev,
> +						 struct device_attribute *attr, char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	ssize_t size = 0;

This init may be avoided. Same in the next function also.

Thanks,
Lijo

> +	int ret;
> +
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
> +
> +	size = amdgpu_dpm_get_temp_metrics(adev, SMU_TEMP_METRIC_BASEBOARD, NULL);
> +	if (size <= 0)
> +		goto out;
> +	if (size >= PAGE_SIZE) {
> +		ret = -ENOSPC;
> +		goto out;
> +	}
> +
> +	amdgpu_dpm_get_temp_metrics(adev, SMU_TEMP_METRIC_BASEBOARD, buf);
> +
> +out:
> +	amdgpu_pm_put_access(adev);
> +
> +	if (ret)
> +		return ret;
> +
> +	return size;
> +}
> +
> +/**
> + * DOC: gpuboard_temp
> + *
> + * The amdgpu driver provides a sysfs API for retrieving current gpuboard
> + * temperature metrics data. The file gpuboard_temp is used for this.
> + * Reading the file will dump all the current gpuboard tempertature  metrics data.
> + */
> +static ssize_t amdgpu_get_gpuboard_temp_metrics(struct device *dev,
> +						struct device_attribute *attr, char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	ssize_t size = 0;
> +	int ret;
> +
> +	ret = amdgpu_pm_get_access_if_active(adev);
> +	if (ret)
> +		return ret;
> +
> +	size = amdgpu_dpm_get_temp_metrics(adev, SMU_TEMP_METRIC_GPUBOARD, NULL);
> +	if (size <= 0)
> +		goto out;
> +	if (size >= PAGE_SIZE) {
> +		ret = -ENOSPC;
> +		goto out;
> +	}
> +
> +	amdgpu_dpm_get_temp_metrics(adev, SMU_TEMP_METRIC_GPUBOARD, buf);
> +
> +out:
> +	amdgpu_pm_put_access(adev);
> +
> +	if (ret)
> +		return ret;
> +
> +	return size;
> +}
> +
> +static DEVICE_ATTR(baseboard_temp, 0444, amdgpu_get_baseboard_temp_metrics, NULL);
> +static DEVICE_ATTR(gpuboard_temp, 0444, amdgpu_get_gpuboard_temp_metrics, NULL);
> +
> +static struct attribute *board_attrs[] = {
> +	&dev_attr_baseboard_temp.attr,
> +	&dev_attr_gpuboard_temp.attr,
> +	NULL
> +};
> +
> +static umode_t amdgpu_board_attr_visible(struct kobject *kobj, struct attribute *attr, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +
> +	if (attr == &dev_attr_baseboard_temp.attr) {
> +		if (!amdgpu_dpm_is_temp_metrics_supported(adev, SMU_TEMP_METRIC_BASEBOARD))
> +			return 0;
> +	}
> +
> +	if (attr == &dev_attr_gpuboard_temp.attr) {
> +		if (!amdgpu_dpm_is_temp_metrics_supported(adev, SMU_TEMP_METRIC_GPUBOARD))
> +			return 0;
> +	}
> +
> +	return attr->mode;
> +}
> +
> +const struct attribute_group amdgpu_board_attr_group = {
> +	.name = "board",
> +	.attrs = board_attrs,
> +	.is_visible = amdgpu_board_attr_visible,
> +};
> +
>  /* pm policy attributes */
>  struct amdgpu_pm_policy_attr {
>  	struct device_attribute dev_attr;
> @@ -4468,6 +4596,13 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>  			goto err_out0;
>  	}
>  
> +	if (amdgpu_dpm_is_temp_metrics_supported(adev, SMU_TEMP_METRIC_GPUBOARD)) {
> +		ret = devm_device_add_group(adev->dev,
> +					    &amdgpu_board_attr_group);
> +		if (ret)
> +			goto err_out0;
> +	}
> +
>  	adev->pm.sysfs_initialized = true;
>  
>  	return 0;

