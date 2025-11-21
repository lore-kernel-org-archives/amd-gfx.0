Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D07CFA478
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 07:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC6D810E12D;
	Fri, 21 Nov 2025 07:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SsVZ0PkP";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013067.outbound.protection.outlook.com
 [40.93.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2EDC10E12D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 07:33:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2vIJtTVnb1l5e99Q4K9jydiEJCXpkPNH+Iuu81FcwYizUHrQYKB0j0hXlOL1EsWs8Ua2wds27sKR9UjHKO64UdybO1HTwOQlI7Ar4EfeLm2YAcYd8ChbveHkGsmoTkdJgQ6Je2fpcYADGzJCFCyCEP8HsTzHQoLH+viKwvc9B8TElSsVazAv4x7qAZ3tmjH9r3732xVNx76bHFTzy98tPfe2FPX5cb72LerVSNXwyUUQXTgY434ZmJcO1+W51BUX2nTrlbZ1AEP6mY9OJVpq44H3o37tM5Dy79Sy6TDJJBbNRw7s5dSrFgtEoWoaNc7Vkd4lxAdGGv4w4Z0poyaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7+oF4WA7UWHn3oCrJc+c2/ZHlbmek1BuqBCBNXN440=;
 b=utVgSKdzEueaSgLSuMJ9hmLy390ESNU0QFdkikyznfrmMYqcO4IQ2i0k0Brk4afuUSvvFDKXbMTHHgRdX7Tuyy3SR15vHxGnKdaYumRVFYk0WsjbI44G9W202bSOpWTKyMijWOjcImkc1LNeHC8U1LjPc4eYNaXkHvFywyGWt6QARPXi2OvXCEdXgzKbCCXL4rjv9kmWELQHyPxFLW3+lg5MGOCr7aCxS7AGVaVhscqCD6zEyAnPFB8tcZ8xQ9GGVoVoo8o8E2kbaUZamQa+OMckG2Xcl6Rq4ukGnUM+jN80CJB41rsqtCyM59icTLEiVSGsOQqfb2LmgC3CzuEKkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7+oF4WA7UWHn3oCrJc+c2/ZHlbmek1BuqBCBNXN440=;
 b=SsVZ0PkP24FyQRzbqONXMrk3UCcc1kehtgMgk12pEMJpEGULpgBAHHD7Zd1Xkfw59X6/iXAW3vaEJ8h2g19UoldwphYT47NuYWKquisQdAOXYXgemnecaCfct2hLfW0KJv+HXM6teCSTGAaIzhShNQ/+AbGQvFP93ivQ51gVYbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS5PPF5A66AFD1C.namprd12.prod.outlook.com (2603:10b6:f:fc00::64d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 07:33:53 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 07:33:53 +0000
Message-ID: <24955785-767e-4600-8ce0-d4eaa91a7286@amd.com>
Date: Fri, 21 Nov 2025 13:03:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/ras: Move ras data alloc before bad page check
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, Tao.Zhou1@amd.com, Stanley.Yang@amd.com
References: <20251120171949.7529-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251120171949.7529-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS5PPF5A66AFD1C:EE_
X-MS-Office365-Filtering-Correlation-Id: 881d8799-debd-487d-0de7-08de28d05246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEdnZmFuME1aWTFPMll6WVFVczhNeDdkOWd0c3FRNlU4ZG12b0JTVWtEdEVB?=
 =?utf-8?B?Qi9mcVBKdWkrdExIQ3RobzJYVWcxNzN2T2NCQ2RYWjVwOFoyNC9kUHl5ZFFM?=
 =?utf-8?B?WEhnRmtmRmlQYzZQazBEWDQ1S0NwUER4NUN3WC9scVVaMkFRbGpXdDdGSjRH?=
 =?utf-8?B?cmI4YTRDWm9QaUVTSGIyenZQY2lHc0JWMGpIMHljQjFMU2pVNTgzVEtPK2U4?=
 =?utf-8?B?U0dZVDFiV1ZMSW5NY2NXYnVvQlhxN1l0YVhRby9uUkQ2WVY2T0pPZVFkSFQr?=
 =?utf-8?B?Y2RkOXhmTDB3cTNGWStoZlRkMnBZWEZLZTRsbFhEV0FKT2VlM1NDeStFUENL?=
 =?utf-8?B?OG0rQ2lZUEwwUWk1c09hck1Hdzd4eDRWZUtsOWhWUnlIWGpKaGl1WHIwYis2?=
 =?utf-8?B?MXIwSDd2UUlva1ZQRFV3UGhPc3N4ZFlaNmhKdFJVaDZ6YUc2UldHRXlPcGJx?=
 =?utf-8?B?U2wyVS9xZzRMVU9sb2NURVJZZkpneTNUcHR5VCs2d0R0SWdlV0U4Q0d1VjJS?=
 =?utf-8?B?UlNMVFUrNUYrUHd1VEhncWw1Rlp1SlZOWGlZWHR0dGg1dUVIM0JKUDIvOU1B?=
 =?utf-8?B?ZzJrd0cxTUdxZ21jN20ySzFjbDMveUlkZFdpTEpKQ2Q0MjBBZmxmWFJINXQ0?=
 =?utf-8?B?aE45VUwrb3h0aW41OGpQZWNkNE0wTjU2dzI4QjgxWE5HaE9iWlBNUldBTC83?=
 =?utf-8?B?WXR1UTArVHg1WFd5K2FJNVQzQWVsM0E3NjJLaERCK3RTRzh6cG9YRktFZlNI?=
 =?utf-8?B?cXpOWkY3UlRWUjZYMmtGVFlqZXFWaHYvQkh0bDR6VmZGR1NubGZrWDBINnNO?=
 =?utf-8?B?U2pLVG83MzcrUUliMlU3dXhMcnorSkJSZnBZYmdOSzNJQmdGNTA3Rll6OUhN?=
 =?utf-8?B?S2dud0drclVkeGFteGZFVHRxam8ycXdLRi9Jdk81aW9sZHRicGNtMFlrQmp2?=
 =?utf-8?B?bzVvdnp1ZTFLUHpmay9KaUo1Ni9XaFdaWFlPaEgwelFmOS9PNGQyTElnT3Np?=
 =?utf-8?B?Vk1aV2N5Wk9jcXRTL3ZFYnE2MFZKRnE4a1pKTTZEVzRYYThWeGlaSXBHTWda?=
 =?utf-8?B?Q3Z3dDk0aUNPeTJvcnJmZ3J3VnBuM2ZlWkJJbVFYajdiZHNONURTenB3dVA1?=
 =?utf-8?B?Y0E5UzZGcEFKNGxucW1PMlRtaGordGN6cmpqWjJXZ3dlbmNmaXZ6ZnNkSGdT?=
 =?utf-8?B?bEFXRSt5NWtZZURtUEV5K3BlWjJKWVhRejl0VjdIam00WFlxSVdQcjErM1Nz?=
 =?utf-8?B?MlFIV216Z1RzZk55NGFncE83VVJ5eHFuZVNMMmZMOU53VnBSVHZ6TGtjMHRz?=
 =?utf-8?B?TEFISE5ab2JzbnRWK2pyUnZIL3B0S0xYRnV6OWdadTY4RGV3VzlHRkhPNjdL?=
 =?utf-8?B?OHBGVlVacU5qcEVMaHorTmJUak5yU3B2MzdmOVdLbmN0Q1JUOVNIWEdwV0xG?=
 =?utf-8?B?KzdsMmQyZjlscENINEY1ZGlGamxEZTQ0blBpOWNvV2pZQjRWQ2c3VmNVVkJ0?=
 =?utf-8?B?ZXJwVlU0YUdRb0Y0TmpYOFVoWnc0L2tZWmsrRVFON1ZGTFVWeUE0UUZ1VkN3?=
 =?utf-8?B?bDZBMENGVUNDMm1SdGs5aVo0WHZLbEFzb2N2RGxTYkpxdE4zMkQyOVhEbzRG?=
 =?utf-8?B?elNPNkVORTg2YksxUXdxQTVUbnFKZFNMMnl2V0poNUpWRm4vNzFwdWVOOGp6?=
 =?utf-8?B?RkFjclc1U1p0b1VKMExxbmtWZ2VYc1M3ZGplWEdBY2F3cWszZmU0UHNDM0NM?=
 =?utf-8?B?WTBqeFpZbHFLdzh1eUp6Q0NmbmpOT3BhOUNTemhYWkpRd0hpeGlFQVFFZGpO?=
 =?utf-8?B?VCtJSWZJMDdPeDlnSllWSEg1dXllTXlVc2F6NVZ1Uk1FM1c0dy9qOGtRa2hw?=
 =?utf-8?B?UWZYUGcrZ1EraEJMMXBxMzk5SWtxY0lSL3FGMzZvWnRGaVBRVGE5anR0c3A1?=
 =?utf-8?Q?MPBKL/tgkjPUMaNQTPIyvdyCxLfJfxYS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEFPd1grRjFZL3pCbUcxcEQ3N0JST0dCcWUvUGR6WUJubEhpbEwremlSMHBC?=
 =?utf-8?B?eFdRUGxyMjBpQXplSEVMN1NaeU1RTHd5L1FMZE5SSWtTMmNoRHloLzAxRjRQ?=
 =?utf-8?B?eGZOYTJXWVlQbkZPb2Uzb2VjbG1WaWUvU3hDSTY1MEVsdG5oTWp3VW9LQlZi?=
 =?utf-8?B?Y08vaFh5cE9BczRDbURDTkloa3JLKysvdzk2OGZrM0RQNG44WlAzdE02RlpC?=
 =?utf-8?B?MGpqUHNQZnEzVmZ3d09scnpKMC90MEhnOTV2ZGZ5YUwrVVhIeGhVV0pjM1Fj?=
 =?utf-8?B?SENLMnJIZEZZcU92WDhiSlY5aVdSTUpicDI4ZGVsNitKU0w1a2dxTnZ4MXFK?=
 =?utf-8?B?L1NPTzdZa1ZOWkkrVTJYZkd1WGVUenVFMzVoR3NxYlkwSkhCYkJ0ZTBHb0E0?=
 =?utf-8?B?N1ZZTlFwRUo2Vk96WW5KRmduYlJiK2RrSE9qSGtHdVZRSmNLYzJWamJYdnBl?=
 =?utf-8?B?UFpacy9VeWJnOGo3TnJRU0FEclNUdHFEYkZ3cnNvbzFSdDF4ZldueEVGcWpo?=
 =?utf-8?B?TFZxUE5Uc0FNdlJHVmgyWHRoOFEwMzg5RmRQQjB2bEIzTVJ3VlpLTkt5NlY2?=
 =?utf-8?B?Sjl1bCtVVnNqMzB5Z1VxWE1pckh3dWtVcjVQcmtTZUE4aWcrSGpWYjZ3MzdS?=
 =?utf-8?B?M09KSlFKTlUySEhJeVBsNHN6L3d4UGJFdC9VWHJiekR5aVhOV0FQTFZnMFRj?=
 =?utf-8?B?QmM2UjExd0N5T25KWDA1bVNKOWZUVko4VkR0T281SDAwWVMzU1FnN1d4T25i?=
 =?utf-8?B?Y1BkeGZ2blZZOXdHZmo5WHVMVEhXSEJCVDM5WGkrVDUzeHI3ZC9MU1BCc1d0?=
 =?utf-8?B?bTJPdUl1WVdFMWRpV2lpaGNpTXlVd0xYZWl2eEFyRUJDSzJ4WHVMTWRJMDNz?=
 =?utf-8?B?TGMzZzNyRnlmdEt4Q1o0eURHZE5ZS3NpYnhxUlVXdTU2MFJ2aWQva3R6ZXU3?=
 =?utf-8?B?Q1VzaFdLSGVZeE5KdlhUOVFFb3l5SGY5cU15aUY0NkdrZi8wUU5ZNFM1VzdY?=
 =?utf-8?B?N2JIekh2QUFXMUM2emR5RitqWmwzMUYwNGRDNjBka0c4VnNRUXpSbUhOSXpx?=
 =?utf-8?B?dnAvWkcvUk9yb0UzNDlFd2lTS0tFUERTMldvUFJuMHBiM1o5cFZEQlBzR0Rk?=
 =?utf-8?B?Y2JQQ0hJZjFDZ092eE5QYjVkSkMySnoxYlhvOXlITCtmTzR4di9TQlpON2VQ?=
 =?utf-8?B?Si92M3ZtZmdyZWptVVcxa0psYzQvcTlwUGc1Rmo5VFptZ2tKYTFXZUpoSzNk?=
 =?utf-8?B?c3VSZlIxWk5MbHk5Yk1JTEJsQ0x6Ukl4T3RUaSttUzUwS2htY2tGc3lacnh0?=
 =?utf-8?B?ZEliQ3l6ZjlwZ1ZZdHNTVklpSnpMU0tQMmFDWnFtMURuSWZNWTlwSkpSYXNq?=
 =?utf-8?B?RnZKZnpCaGI0SU1tc0NhdkNiSGdEZjdEVGg1MjdaVVV5R2xoc1FJT3ZTdlRR?=
 =?utf-8?B?VEFOSlVuVEhaeVI4ZzQzclAzb0xvcHpVY0NHMlhiNU1RbEdJTUNWbTIyUnhv?=
 =?utf-8?B?YXBjU3hFRVk5TCt6M3pZSWpLanpUdHV0UjJXYU5zOUNORklnSEJhdFdGQlBN?=
 =?utf-8?B?U3hpbzVTQnp3TEZSRnlqeGIxSE10dkdMRjNCRTF3bnJBRXpuYlF2VWZkZko3?=
 =?utf-8?B?TnBoRVBZMXl6K2hWWG1mdVd2N1UxdnNBNDlnVk9WTWlnYXBoTllYRXpqUWNn?=
 =?utf-8?B?MmQrRHU5V3hKdlJnVGl0N2VLZUh5ODVEUzQ4S0hRbGhnNW0xQnNKVGRoWWVI?=
 =?utf-8?B?NGNtcDM3NTBwTlU1cTR4dURjSVp1OWxrMXZhR0NzQWlQdzNObWI0SWgzUWFr?=
 =?utf-8?B?cFFidDB5YlBaZHNmRFNUeGVqOWJ0cm9YLzJ0Smo1YVBKSmtCZWZmdnoremlv?=
 =?utf-8?B?MnR0ZkhobVFoZkpoeSt6akxxeU9iWngxSkNpSXpuTWlyK0YrWEdmdHlBdGRD?=
 =?utf-8?B?emxtYXBoZEgrTFZuNzlZd2lPK1dFWFhVK25OODFlY1FrZWZnRE1rRGdvejZi?=
 =?utf-8?B?UUNISUs2VEl0STZ0TWpUQkc3YVJFNHJNSUhPZUpuc0FGNDU1WVNnRGx5TjIw?=
 =?utf-8?B?KzkxUzluT2dOdldBNDRjM20welFBR0NpTlh3OFJoN1J4SkNFek9TVjlRRk15?=
 =?utf-8?Q?jxdHikgEqvwIioE+mmXpwC/AM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881d8799-debd-487d-0de7-08de28d05246
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 07:33:53.5911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6TbWOiDZd+BcPeRRor7r+SaiUr8Rr9vBzzPUBCa0xy1kcUpyuy5JiJVo0ewiYd9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5A66AFD1C
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



On 11/20/2025 10:49 PM, Asad Kamal wrote:
> In the rare event if eeprom has only invalid address entries,
> allocation is skipped, this causes following NULL pointer issue
> [  547.103445] BUG: kernel NULL pointer dereference, address: 0000000000000010
> [  547.118897] #PF: supervisor read access in kernel mode
> [  547.130292] #PF: error_code(0x0000) - not-present page
> [  547.141689] PGD 124757067 P4D 0
> [  547.148842] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  547.158504] CPU: 49 PID: 8167 Comm: cat Tainted: G           OE      6.8.0-38-generic #38-Ubuntu
> [  547.177998] Hardware name: Supermicro AS -8126GS-TNMR/H14DSG-OD, BIOS 1.7 09/12/2025
> [  547.195178] RIP: 0010:amdgpu_ras_sysfs_badpages_read+0x2f2/0x5d0 [amdgpu]
> [  547.210375] Code: e8 63 78 82 c0 45 31 d2 45 3b 75 08 48 8b 45 a0 73 44 44 89 f1 48 8b 7d 88 48 89 ca 48 c1 e2 05 48 29 ca 49 8b 4d 00 48 01 d1 <48> 83 79 10 00 74 17 49 63 f2 48 8b 49 08 41 83 c2 01 48 8d 34 76
> [  547.252045] RSP: 0018:ffa0000067287ac0 EFLAGS: 00010246
> [  547.263636] RAX: ff11000167c28130 RBX: ff11000127600000 RCX: 0000000000000000
> [  547.279467] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff11000125b1c800
> [  547.295298] RBP: ffa0000067287b50 R08: 0000000000000000 R09: 0000000000000000
> [  547.311129] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  547.326959] R13: ff11000217b1de00 R14: 0000000000000000 R15: 0000000000000092
> [  547.342790] FS:  0000746e59d14740(0000) GS:ff11017dfda80000(0000) knlGS:0000000000000000
> [  547.360744] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  547.373489] CR2: 0000000000000010 CR3: 000000019585e001 CR4: 0000000000f71ef0
> [  547.389321] PKRU: 55555554
> [  547.395316] Call Trace:
> [  547.400737]  <TASK>
> [  547.405386]  ? show_regs+0x6d/0x80
> [  547.412929]  ? __die+0x24/0x80
> [  547.419697]  ? page_fault_oops+0x99/0x1b0
> [  547.428588]  ? do_user_addr_fault+0x2ee/0x6b0
> [  547.438249]  ? exc_page_fault+0x83/0x1b0
> [  547.446949]  ? asm_exc_page_fault+0x27/0x30
> [  547.456225]  ? amdgpu_ras_sysfs_badpages_read+0x2f2/0x5d0 [amdgpu]
> [  547.470040]  ? mas_wr_modify+0xcd/0x140
> [  547.478548]  sysfs_kf_bin_read+0x63/0xb0
> [  547.487248]  kernfs_file_read_iter+0xa1/0x190
> [  547.496909]  kernfs_fop_read_iter+0x25/0x40
> [  547.506182]  vfs_read+0x255/0x390
> 
> This also result in space left assigned to negative values.
> Moving data alloc call before bad page check resolves both the issue.
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 3140c20a6c81..83194eb6344a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3076,6 +3076,11 @@ static int __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
>   	struct ras_err_handler_data *data = con->eh_data;
>   
>   	for (j = 0; j < count; j++) {
> +		if (!data->space_left &&
> +		    amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
> +			return -ENOMEM;
> +		}
> +
>   		if (amdgpu_ras_check_bad_page_unlock(con,
>   			bps[j].retired_page << AMDGPU_GPU_PAGE_SHIFT)) {
>   			data->count++;
> @@ -3083,11 +3088,6 @@ static int __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
>   			continue;
>   		}
>   
> -		if (!data->space_left &&
> -		    amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
> -			return -ENOMEM;
> -		}
> -
>   		amdgpu_ras_reserve_page(adev, bps[j].retired_page);
>   
>   		memcpy(&data->bps[data->count], &(bps[j]),

