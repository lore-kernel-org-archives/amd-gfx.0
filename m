Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E606D66BA6
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 21:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE4110E916;
	Wed, 17 Dec 2025 21:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wPUgs8/w";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93AA110E900
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 21:01:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWNDDhgtpnrBEq4ok2LAMkW7VEeartTYAeWs7/+cYflbz5Hqnayze2jSKD9q8gEQYFrX/4CWi4dC8TCynR1+z8KI3fQdFlQT4f0AQthY7YTJPBu5Sw+FTzp4A4NL3f9BMznfOpOH2Yrw7xrmEjWTIkvRp4+RbjH8+YHU+UGAaKl+p+has5zsMdloTu5rmwA9Qik5B97HTTBv2+f0R5gA+PluTAdRIP+SIUaw2lkC6qJWkVEghOWCDmYZqoe6MioXQ10fc5za2ju5KExGuoi/IXeY0A5BJdNkIN8SyxzF1/8T9WRuARAKwK4JjJcpsmnl2Fxg5PS6IOGQZX7OI63Pwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hv9Uh82EGYmUeMMXnlkFc+f7eUxz9zj89mzMh1/TPO4=;
 b=CaMlO1Z6fGqFmdxL5NLdojlQ9w+AG5BOnx/tFPZqChCh9AW3mmwRA05JcR13STl5OSiVLT2WmqjYiDXUMU35pYEqh0V1FMAZ0uSFO+BnnrDzu/NL7yhRJ5zyefuEHF+u880goRTRuGW1V3Tx5atI3gnp3Y4r445NcScdG1fxX9ncp8yHjrkaPfU0JQd4CZL0KQDxS7nvQbjcWhckMeFxfiZSlOMT13XvjuoLBSU4yP2xJph32Qj0wyAU8h4ygM1bsbPrx2LXZKdI/Kt7m80wPrAH+B78YUhMAOKjfcGDxlXll/HVPsEr/NZj162pjzmGr+lR7pb9ss3g9Lneofun+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hv9Uh82EGYmUeMMXnlkFc+f7eUxz9zj89mzMh1/TPO4=;
 b=wPUgs8/wMMSIrXLHklnqkciGOuKGquSX5oU/wEoJ5Ogb3pFRLiJ0mtLyB0hN1oq4G3cNRbM9MFkj9h75Ld3y3bmtfQrXqjXwQNzux7fTY01c31JZyDGaRYGUxkSxrS2l/R/uk1jyPn85y4nldVquBo1f+YOeTR/WYutvmo1wtPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 21:01:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 21:01:21 +0000
Message-ID: <6e2666b1-9e63-4883-852b-ca0ac0cb34d0@amd.com>
Date: Wed, 17 Dec 2025 15:01:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu/jpeg: Add jpeg 5.3.0 support
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
References: <20251217153521.2018841-1-alexander.deucher@amd.com>
 <20251217153521.2018841-2-alexander.deucher@amd.com>
 <4c6a9a94-8bc5-49b2-ba03-0f81266b3797@amd.com>
 <CADnq5_O_3akUX_rRpas3yFMj-Nu_YGzuMtfGTcUJ1t6U-0mibg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_O_3akUX_rRpas3yFMj-Nu_YGzuMtfGTcUJ1t6U-0mibg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DSZP220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:5:280::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b24934-2b3b-4a83-3c19-08de3daf6e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTdZUzNzM1hINTZqV055Z2dsNFI5K1pxTk44Y2NScVFLZ2FpWExGM2RyUnZF?=
 =?utf-8?B?dHdUY0JLVWZUUUo1K1Zob1V3TUFTSHZ2NEFobU1QbXYwT0J0UGZWVGJ5bTlp?=
 =?utf-8?B?cHZSYWUzRmxmZWVMYWNETGVrVjYxVFBhdmlnRUFzYTZJd3BuaTNvWE5tYXla?=
 =?utf-8?B?RkNZRW80WlVOQU9pa2ZVejFwV2dGOTRuOGt3NnNNdGNFNWlYL2tjM29kZmZl?=
 =?utf-8?B?Vm10Z0Njdk5FV1NrSnI3QW5iNmp5NHZ3dTdZMXFDRThvS1JQRDcyRE5MaVho?=
 =?utf-8?B?bnhZL3YzRjNlbmV4SENmeUFodkVqaFZta0h5M2FKakUxKzlRNEZvZUwwdkJF?=
 =?utf-8?B?TGJ5QXFXRDBKWmhOYmRaanZVMGVnWHZSN1R0Qng5TjVKbVk4V21IU1BsM0NJ?=
 =?utf-8?B?UXdMU05FZjVNMWx1VzlyTXRDUUpLcndzYWhDOW4vT1RKTVZaWWh1bzlabURh?=
 =?utf-8?B?TUhXazh1T1NRN2Y2ZVRrNGprZ0N4dEJXcnQvQ0NMQ2MyeDVqYlp2SjN4MlRD?=
 =?utf-8?B?OHBYRjk2Zml1ODcvTDhBKzAxWGRScWdwOHZDZ25GNTNhU25ZVmNPY0ZVWFhq?=
 =?utf-8?B?c2RVTkpjNG9YOTJuZUE4ayt2K0tlcy95bVpSK1QybzUwVlNDM2ZTY3F4bXN4?=
 =?utf-8?B?emllVTNHMERaNHphem9iNjJ3SGtWL3A4ajlZNUY3bFJvRHlNbVFIa1cvZEFF?=
 =?utf-8?B?SWRPSjEvbXYzRitpVy9BQ2lDMzI0a3NGNE4yUjBlOUtmbURyYUxET0UrUlBE?=
 =?utf-8?B?c0dCOUZJWDdwNHdNZmVaVDFXVUxYaVNhNnJtVWxYV3g0Yy9LaWlmcGQ2ZzZi?=
 =?utf-8?B?VFcxcHJBbUUxV0RtdUZTWkl5Myt3SHlGSHJ6V0N0ZmZVMEdqRlRnVTZxUUR3?=
 =?utf-8?B?eDA5eGg2U3JndVFkN2J0M25MRll0Vy9MZkkvT0xlcm1rbHF1aGtDRjVuYnZl?=
 =?utf-8?B?QkdvaGhVeW84aXlTZHJnOVVrNTJCZlltdUI4ZXVKUmFnWHFYUU9CcTRvUFFj?=
 =?utf-8?B?K2NQcm5Jbm91ZlFpM3FvQUorMUxaV08vWlpIeCtwWEpYR2NUUDNRRmpEUHho?=
 =?utf-8?B?OE00UDFZcWNYSWttQWhmYjFSZ3M1SkloZmN0T1VhM2dYbmxvRnZHMnV0TGhH?=
 =?utf-8?B?WGR2N3JWM0Fmb3RjRlR2WDZjck12NHppOWI2YStleDZsRU5zbDdSN3ZWWWVV?=
 =?utf-8?B?VHNoTlpyQS9NekNRN2FqcGFSeU0wSGlBdDM0L2NHQXE0UGU3QWNtMWpPNjFk?=
 =?utf-8?B?OERPU0oyam5kN0FMcjFvS0ZkTWxoa0R6azBBZFBlNjFVcFQ4VEFhQ3d3cXRH?=
 =?utf-8?B?S1U4NTRock03YzQwdTBzTzhLUm5VRzZhRDNvc0hjOWdXVmZ5dUJXazhrMGZz?=
 =?utf-8?B?NnVOOG1CVCtmZnRNbkdYNVhjY09kVEpWdjgxNkRSSFAxQmNnYTFEWlplRitE?=
 =?utf-8?B?UmFBL2FpNmhDbFhqWDdZUUM0T1FmdXJnb2h1alQrYktwQTI4T3FPQksyZUNh?=
 =?utf-8?B?aGVXM3krdG0zczVadWRBVldRdTVSa3dnbGo4cWc4UjdmSmR0ZEdiZWh4Zmcw?=
 =?utf-8?B?U29wajMvMmg0K1RHUTR2YmF0NDE5NG05dzRQNGFCMjZ0a3RUQXFLSk1rcGhz?=
 =?utf-8?B?OHA4eEtZaTdGWUJJejBPaVRVdTQ4TUloekQwUXNmWFZ6Ty9LRHRORDlKMk0x?=
 =?utf-8?B?ekVkaFZnRHhUMU4rOGxhVkE3MUVOcG9oaU9YaERzWFhrZHFCNVpjemlWcm1m?=
 =?utf-8?B?S3RkeXRpNFAwczdBc0VYcWlIc21sUnVWb0toTXlWTnEzY0dyWFBDSjNwZVAz?=
 =?utf-8?B?U1VHeTZ4TG9sVkhQSzlITVFxRWs5ZFlaaGhrTmJRSlJMWHo1NmJ4VVRQQ2pu?=
 =?utf-8?B?Qm8rMmNBNk5INUVTNW9CUXgvKy8yMXZ0bkNhenVQSjFveWdVbzdwUnhsL1pR?=
 =?utf-8?Q?5mnYkK1RDPhxpwH7Q9xjKKd++8aeBXJN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWwwa0VRL0V4YVpEY1YzQUYxenZUNzJhVzEyN1kyT3RnRCs5UWpxRk9QeTA4?=
 =?utf-8?B?Ui93VjJNQUhEL0JNSWVZYXJTTUcwM1ZvOENyOEFBL0ZoZGplNVVhKytqNk5R?=
 =?utf-8?B?MkhZS2MzWlp3aktSL2tmUXVoUFUxTEdBYzQvTmV4N3hvWWowRlgwVTY4RWd6?=
 =?utf-8?B?cCtYdkF2dENwV1U2c3VYay80Z1dvcHgwdFFpQVc0T3VXd04veDVxbmJmOU9s?=
 =?utf-8?B?YnJMU21wSjdsUlZUVW9HOXI0aU5VOStNU3RJdVhHUmJJTzI4Si9XU3JCTEhT?=
 =?utf-8?B?WXYrTzZtTXRBeEpMTWFWMzhRSUs5NVg2ajRlTEtIYnVpNmE1OGViRWFMYXQr?=
 =?utf-8?B?cllLbmRtakFrSEtCL3BJcTV2eUI2OFlUTHZJVXBaNVUwRHZwUzRGazdaUlZW?=
 =?utf-8?B?MGpGTHBTc0RSTmtrKzlHaW9jSUVqWGR1R04vZkJiMS9lSTY0OXpaOUdsSVIr?=
 =?utf-8?B?c2p3VmNlQmhHczY4bE02Qm5vamdod25VTjVCOGZwUC9SZU5RUytNQ0NRQWVJ?=
 =?utf-8?B?REk3RUpHZityYjUwTmJqeFQydHJ0bVp5d3BiL0doWnprbVpLUStaU2tlQUtq?=
 =?utf-8?B?Y2l0bHo1Uko2VkRFUU43eHBCejhQQld4eXF0Zm5yZGVEUzhSc2VUR2JwMVZH?=
 =?utf-8?B?K3dIZ1ZKV2tNbWF2NFpQaExUYWpXMmY1RFJlcklTL0xBNlk5YXBncGxEd0hX?=
 =?utf-8?B?WEZWS1Q4d2RRYmZTR1B3ZmtCMyt2V1kvelFHSm40eGNISGFNQWVTNzdsNFJB?=
 =?utf-8?B?TmVXTS9mRXdxS2ZyWVpLdkhJL3FiZDVmVHMvb2FaVmJweHd2R1cxaVJGR2RC?=
 =?utf-8?B?bHNpMnQ3YXNkVmFHb0VTQUcxOCtxeEYvY2lRZ1RBZnJFOTNiTzNtNFI1VlZn?=
 =?utf-8?B?QjBSMC9pU3ZVTDQweUhDWHQrNjc1YUhndjljUnZSeXV6SWNzTDlYWE00V0lr?=
 =?utf-8?B?WG5BdFN3WHZhRXJjY1NWbi9UQmFmTlVVRHRXSzBoRXBJdlljTDY1MGJJQ2xs?=
 =?utf-8?B?RTFUUG9vWFBVci9MQjZlTVRYcnJabGFWRHkralJ0MDJ4RlpUVmJEWkpVbWVj?=
 =?utf-8?B?Qzl3ajJYQkZrcHBtSUhSUnBnY0FlSlo0Ty9jOEFXSHFKVmdLZkV5RVJkOG1t?=
 =?utf-8?B?TXNZV080WWNzQ0tjcmt1b29kSXNPYlVMS0pVOWd5dUlMNmZrbGpLZDFZYTFQ?=
 =?utf-8?B?a2VTNVRvVDRqdW9oZHNQdnN2Z29uSDZ3N09oZ3B2MVZxNXVxUUNEZzR4U2w1?=
 =?utf-8?B?VmFqZXk4cXIzY0YyNFhJUzVLN1YxSDhKRkk0ZjZ1cWVDem9UNVJjVmZZd2Rt?=
 =?utf-8?B?Lzlyb0hBL3dwWXJmSEc2MTB3NThTMEtNdjE4UkdTUGtzdkVUSE8xaGdOa3RD?=
 =?utf-8?B?ZnhmY3NiSUZraVRLeWN1RFFBWXB0QXhZQ01wOVJ0VXo0SHdxWG93ZTFRa1Z2?=
 =?utf-8?B?UEN6L0VTcHJRSDdjUUxCUWVQNjg0Y3pvOTBRR1M3YUYvdURvWmRYeVlXK3Jy?=
 =?utf-8?B?Wm8zZDdhTzAzUC9zSVRJSGZ6TG1sS3ZoZDN6TmN4cVhQUU54aHFLeU1ORytW?=
 =?utf-8?B?elF0dnVRT25yQ1JjcTd5ZjJuMEcyVlF5YjFqS0J4dnlrRnlXT0tQcXFERytX?=
 =?utf-8?B?VFc0S3JWK0h0RE5RTk1tNjJoSVNvMGJVaTEyaFlTVnpNZnd6YUdwQ3B2VUxX?=
 =?utf-8?B?cmRBYWNXYlg2VldFNVV3U2xMbEx6VllJU2FpTXQ2WnAyeEw2TXY2ejhha09N?=
 =?utf-8?B?SCtvVVBXQU1EeFFSWGRiSW1EMjNwNEhNc1Y0ZVoweWU0dTFCL0dlV0g3ajJF?=
 =?utf-8?B?MFZ0K1luMzNhbWliUXE4d3hHemo4WkhiV3k3QzlkTk1GeXpicXZlQnMwM3dM?=
 =?utf-8?B?QVhuK0loU2FSTVBtME1QSDU0RUI2cFJldGJyQ0VKMFhQWDZ1NkRSVWIwSXN2?=
 =?utf-8?B?TUw3Y1BObVJKWlBjV1FoQVNjd1EwR1Jwb01CbDRvdDN1WFpMZWU5UGdhbW1l?=
 =?utf-8?B?N3BsVmplbGpUZDFKZFhkL29ab0FuejMvQkpla2l2Z3FReGtaTkhONDVCbHds?=
 =?utf-8?B?R0ZEMGswbVphMHhuVUlYQkg3WnpFMHRHdmRLVTBHQTYzL0JMZFNWVlZxTE1w?=
 =?utf-8?Q?b1boAzr3QD1id8QtHce0DOMLZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b24934-2b3b-4a83-3c19-08de3daf6e18
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 21:01:21.0453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfk/dlW8O5xtW5CaA+ziya1PUM5NDwXtjgiyGM3XPTZqnwaVYXr35MAdknHsbL3hkrYp1pdTjyJZmJAFe3CFfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793
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

On 12/17/25 2:47 PM, Alex Deucher wrote:
> On Wed, Dec 17, 2025 at 2:22 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 12/17/25 9:35 AM, Alex Deucher wrote:
>>> From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
>>>
>>> Add the Jpeg IP v5_3_0 code base.
>>>
>>> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/Makefile      |   3 +-
>>>    drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 695 +++++++++++++++++++++++
>>>    drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h |  35 ++
>>>    3 files changed, 732 insertions(+), 1 deletion(-)
>>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
>>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> index d0c506a445695..4b9cb9b681b65 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> @@ -221,7 +221,8 @@ amdgpu-y += \
>>>        jpeg_v4_0_3.o \
>>>        jpeg_v4_0_5.o \
>>>        jpeg_v5_0_0.o \
>>> -     jpeg_v5_0_1.o
>>> +     jpeg_v5_0_1.o \
>>> +     jpeg_v5_3_0.o
>>>
>>>    # add VPE block
>>>    amdgpu-y += \
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
>>> new file mode 100644
>>> index 0000000000000..084e592fb838f
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
>>> @@ -0,0 +1,695 @@
>>> +/*
>>> + * Copyright 2025 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person obtaining a
>>> + * copy of this software and associated documentation files (the "Software"),
>>> + * to deal in the Software without restriction, including without limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to whom the
>>> + * Software is furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +
>>> +#include "amdgpu.h"
>>> +#include "amdgpu_jpeg.h"
>>> +#include "amdgpu_pm.h"
>>> +#include "soc15.h"
>>> +#include "soc15d.h"
>>> +#include "jpeg_v2_0.h"
>>> +#include "jpeg_v4_0_3.h"
>>> +
>>> +#include "vcn/vcn_5_3_0_offset.h"
>>> +#include "vcn/vcn_5_3_0_sh_mask.h"
>>> +#include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
>>> +#include "jpeg_v5_3_0.h"
>>> +
>>> +static void jpeg_v5_3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>>> +static void jpeg_v5_3_0_set_irq_funcs(struct amdgpu_device *adev);
>>> +static int jpeg_v5_3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>> +                             enum amd_powergating_state state);
>>
>> As it's "new code", could the functions be ordered in a way that
>> prototypes aren't needed?
>>
>> IE:
>> * put jpeg_v5_3_0_set_irq_funcs() and jpeg_v5_3_0_set_dec_ring_funcs()
>> before jpeg_v5_3_0_early_init()?
>> * put jpeg_v5_3_0_set_powergating_state() before jpeg_v5_3_0_hw_fini()
> 
> Not particularly easily unfortunately.

OK, it's not a big deal.  I was just looking for a tech debt reduction 
opportunity.

The series is fine otherwise.

> 
> Alex
> 
>>
>>> +
>>> +
>>> +/**
>>> + * jpeg_v5_3_0_early_init - set function pointers
>>> + *
>>> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>>> + *
>>> + * Set ring and irq function pointers
>>> + */
>>> +static int jpeg_v5_3_0_early_init(struct amdgpu_ip_block *ip_block)
>>> +{
>>> +     struct amdgpu_device *adev = ip_block->adev;
>>> +
>>> +     adev->jpeg.num_jpeg_inst = 1;
>>> +     adev->jpeg.num_jpeg_rings = 1;
>>> +
>>> +     jpeg_v5_3_0_set_dec_ring_funcs(adev);
>>> +     jpeg_v5_3_0_set_irq_funcs(adev);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +/**
>>> + * jpeg_v5_3_0_sw_init - sw init for JPEG block
>>> + *
>>> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>>> + *
>>> + * Load firmware and sw initialization
>>> + */
>>> +static int jpeg_v5_3_0_sw_init(struct amdgpu_ip_block *ip_block)
>>> +{
>>> +     struct amdgpu_device *adev = ip_block->adev;
>>> +     struct amdgpu_ring *ring;
>>> +     int r;
>>> +
>>> +     /* JPEG TRAP */
>>> +     r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
>>> +             VCN_5_0__SRCID__JPEG_DECODE, &adev->jpeg.inst->irq);
>>> +     if (r)
>>> +             return r;
>>> +
>>> +     r = amdgpu_jpeg_sw_init(adev);
>>> +     if (r)
>>> +             return r;
>>> +
>>> +     r = amdgpu_jpeg_resume(adev);
>>> +     if (r)
>>> +             return r;
>>> +
>>> +     ring = adev->jpeg.inst->ring_dec;
>>> +     ring->use_doorbell = true;
>>> +     ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1;
>>> +     ring->vm_hub = AMDGPU_MMHUB0(0);
>>> +
>>> +     sprintf(ring->name, "jpeg_dec");
>>> +     r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
>>> +                          AMDGPU_RING_PRIO_DEFAULT, NULL);
>>> +     if (r)
>>> +             return r;
>>> +
>>> +     adev->jpeg.internal.jpeg_pitch[0] = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
>>> +     adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
>>> +
>>> +     /* TODO: Add queue reset mask when FW fully supports it */
>>> +     adev->jpeg.supported_reset =
>>> +             amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
>>> +     r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>>> +     if (r)
>>> +             return r;
>>> +     return 0;
>>> +}
>>> +
>>> +/**
>>> + * jpeg_v5_3_0_sw_fini - sw fini for JPEG block
>>> + *
>>> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>>> + *
>>> + * JPEG suspend and free up sw allocation
>>> + */
>>> +static int jpeg_v5_3_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>> +{
>>> +     struct amdgpu_device *adev = ip_block->adev;
>>> +     int r;
>>> +
>>> +     r = amdgpu_jpeg_suspend(adev);
>>> +     if (r)
>>> +             return r;
>>> +
>>> +     amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>>> +     r = amdgpu_jpeg_sw_fini(adev);
>>> +
>>> +     return r;
>>> +}
>>> +
>>> +/**
>>> + * jpeg_v5_3_0_hw_init - start and test JPEG block
>>> + *
>>> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>>> + *
>>> + */
>>> +static int jpeg_v5_3_0_hw_init(struct amdgpu_ip_block *ip_block)
>>> +{
>>> +     struct amdgpu_device *adev = ip_block->adev;
>>> +     struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
>>> +     int r;
>>> +
>>> +     adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>>> +                     (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>>> +
>>> +     /* Skip ring test because pause DPG is not implemented. */
>>> +     if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG)
>>> +             return 0;
>>> +
>>> +     r = amdgpu_ring_test_helper(ring);
>>> +     if (r)
>>> +             return r;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +/**
>>> + * jpeg_v5_3_0_hw_fini - stop the hardware block
>>> + *
>>> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>>> + *
>>> + * Stop the JPEG block, mark ring as not ready any more
>>> + */
>>> +static int jpeg_v5_3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>>> +{
>>> +     struct amdgpu_device *adev = ip_block->adev;
>>> +
>>> +     cancel_delayed_work_sync(&adev->jpeg.idle_work);
>>> +
>>> +     if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>>> +           RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS))
>>> +             jpeg_v5_3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +/**
>>> + * jpeg_v5_3_0_suspend - suspend JPEG block
>>> + *
>>> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>>> + *
>>> + * HW fini and suspend JPEG block
>>> + */
>>> +static int jpeg_v5_3_0_suspend(struct amdgpu_ip_block *ip_block)
>>> +{
>>> +     int r;
>>> +
>>> +     r = jpeg_v5_3_0_hw_fini(ip_block);
>>> +     if (r)
>>> +             return r;
>>> +
>>> +     r = amdgpu_jpeg_suspend(ip_block->adev);
>>> +
>>> +     return r;
>>> +}
>>> +
>>> +/**
>>> + * jpeg_v5_3_0_resume - resume JPEG block
>>> + *
>>> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>>> + *
>>> + * Resume firmware and hw init JPEG block
>>> + */
>>> +static int jpeg_v5_3_0_resume(struct amdgpu_ip_block *ip_block)
>>> +{
>>> +     int r;
>>> +
>>> +     r = amdgpu_jpeg_resume(ip_block->adev);
>>> +     if (r)
>>> +             return r;
>>> +
>>> +     r = jpeg_v5_3_0_hw_init(ip_block);
>>> +
>>> +     return r;
>>> +}
>>> +
>>> +static void jpeg_v5_3_0_disable_clock_gating(struct amdgpu_device *adev)
>>> +{
>>> +     uint32_t data = 0;
>>> +
>>> +     WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
>>> +
>>> +     data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL);
>>> +     data &= ~(JPEG_CGC_CTRL__JPEG0_DEC_MODE_MASK
>>> +             | JPEG_CGC_CTRL__JPEG_ENC_MODE_MASK);
>>> +     WREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL, data);
>>> +}
>>> +
>>> +static void jpeg_v5_3_0_enable_clock_gating(struct amdgpu_device *adev)
>>> +{
>>> +     uint32_t data = 0;
>>> +
>>> +     data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL);
>>> +
>>> +     data |= 1 << JPEG_CGC_CTRL__JPEG0_DEC_MODE__SHIFT;
>>> +     WREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL, data);
>>> +
>>> +     data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE);
>>> +     data |= (JPEG_CGC_GATE__JPEG0_DEC_MASK
>>> +             |JPEG_CGC_GATE__JPEG_ENC_MASK
>>> +             |JPEG_CGC_GATE__JMCIF_MASK
>>> +             |JPEG_CGC_GATE__JRBBM_MASK);
>>> +     WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
>>> +}
>>> +
>>> +static int jpeg_v5_3_0_disable_power_gating(struct amdgpu_device *adev)
>>> +{
>>> +     uint32_t data = 0;
>>> +
>>> +     data = 1 << UVD_IPX_DLDO_CONFIG_ONO1__ONO1_PWR_CONFIG__SHIFT;
>>> +     WREG32_SOC15(JPEG, 0, regUVD_IPX_DLDO_CONFIG_ONO1, data);
>>> +     SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_IPX_DLDO_STATUS, 0,
>>> +                     UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS_MASK);
>>> +
>>> +     /* disable anti hang mechanism */
>>> +     WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
>>> +             ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int jpeg_v5_3_0_enable_power_gating(struct amdgpu_device *adev)
>>> +{
>>> +     /* enable anti hang mechanism */
>>> +     WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS),
>>> +             UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
>>> +             ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>> +
>>> +     if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
>>> +             WREG32(SOC15_REG_OFFSET(JPEG, 0, regUVD_IPX_DLDO_CONFIG_ONO1),
>>> +                     2 << UVD_IPX_DLDO_CONFIG_ONO1__ONO1_PWR_CONFIG__SHIFT);
>>> +             SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_IPX_DLDO_STATUS,
>>> +                     1 << UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS__SHIFT,
>>> +                     UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS_MASK);
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static void jpeg_engine_5_0_0_dpg_clock_gating_mode(struct amdgpu_device *adev,
>>> +            int inst_idx, uint8_t indirect)
>>> +{
>>> +     uint32_t data = 0;
>>> +
>>> +     // JPEG disable CGC
>>> +     if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG)
>>> +             data = 1 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
>>> +     else
>>> +             data = 0 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
>>> +
>>> +     data |= 1 << JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
>>> +     data |= 4 << JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
>>> +
>>> +     if (indirect) {
>>> +             ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_CGC_CTRL, data, indirect);
>>> +
>>> +             // Turn on All JPEG clocks
>>> +             data = 0;
>>> +             ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_CGC_GATE, data, indirect);
>>> +     } else {
>>> +             WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_CGC_CTRL, data, indirect);
>>> +
>>> +             // Turn on All JPEG clocks
>>> +             data = 0;
>>> +             WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_CGC_GATE, data, indirect);
>>> +     }
>>> +}
>>> +
>>> +/**
>>> + * jpeg_v5_3_0_start_dpg_mode - Jpeg start with dpg mode
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + * @inst_idx: instance number index
>>> + * @indirect: indirectly write sram
>>> + *
>>> + * Start JPEG block with dpg mode
>>> + */
>>> +static int jpeg_v5_3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
>>> +{
>>> +     struct amdgpu_ring *ring = adev->jpeg.inst[inst_idx].ring_dec;
>>> +     uint32_t reg_data = 0;
>>> +
>>> +     jpeg_v5_3_0_enable_power_gating(adev);
>>> +
>>> +     // enable dynamic power gating mode
>>> +     reg_data = RREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS);
>>> +     reg_data |= UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK;
>>> +     WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data);
>>> +
>>> +     if (indirect)
>>> +             adev->jpeg.inst[inst_idx].dpg_sram_curr_addr =
>>> +                     (uint32_t *)adev->jpeg.inst[inst_idx].dpg_sram_cpu_addr;
>>> +
>>> +     jpeg_engine_5_0_0_dpg_clock_gating_mode(adev, inst_idx, indirect);
>>> +
>>> +     /* MJPEG global tiling registers */
>>> +     if (indirect)
>>> +             ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_DEC_GFX10_ADDR_CONFIG,
>>> +                     adev->gfx.config.gb_addr_config, indirect);
>>> +     else
>>> +             WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_DEC_GFX10_ADDR_CONFIG,
>>> +                     adev->gfx.config.gb_addr_config, 1);
>>> +
>>> +     /* enable System Interrupt for JRBC */
>>> +     if (indirect)
>>> +             ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_SYS_INT_EN,
>>> +                     JPEG_SYS_INT_EN__DJRBC0_MASK, indirect);
>>> +     else
>>> +             WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_SYS_INT_EN,
>>> +                     JPEG_SYS_INT_EN__DJRBC0_MASK, 1);
>>> +
>>> +     if (indirect) {
>>> +             /* add nop to workaround PSP size check */
>>> +             ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipUVD_NO_OP, 0, indirect);
>>> +
>>> +             amdgpu_jpeg_psp_update_sram(adev, inst_idx, 0);
>>> +     }
>>> +
>>> +     WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
>>> +             ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
>>> +             VCN_JPEG_DB_CTRL__EN_MASK);
>>> +
>>> +     WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_VMID, 0);
>>> +     WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
>>> +     WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
>>> +             lower_32_bits(ring->gpu_addr));
>>> +     WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
>>> +             upper_32_bits(ring->gpu_addr));
>>> +     WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC_RB_RPTR, 0);
>>> +     WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC_RB_WPTR, 0);
>>> +     WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC_RB_CNTL, 0x00000002L);
>>> +     WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC_RB_SIZE, ring->ring_size / 4);
>>> +     ring->wptr = RREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC_RB_WPTR);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +/**
>>> + * jpeg_v5_3_0_stop_dpg_mode - Jpeg stop with dpg mode
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + * @inst_idx: instance number index
>>> + *
>>> + * Stop JPEG block with dpg mode
>>> + */
>>> +static void jpeg_v5_3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>>> +{
>>> +     uint32_t reg_data = 0;
>>> +
>>> +     reg_data = RREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS);
>>> +     reg_data &= ~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK;
>>> +     WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data);
>>> +}
>>> +
>>> +/**
>>> + * jpeg_v5_3_0_start - start JPEG block
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * Setup and start the JPEG block
>>> + */
>>> +static int jpeg_v5_3_0_start(struct amdgpu_device *adev)
>>> +{
>>> +     struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
>>> +     int r;
>>> +
>>> +     if (adev->pm.dpm_enabled)
>>> +             amdgpu_dpm_enable_jpeg(adev, true);
>>> +
>>> +     if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
>>> +             r = jpeg_v5_3_0_start_dpg_mode(adev, 0, adev->jpeg.indirect_sram);
>>> +             return r;
>>> +     }
>>> +
>>> +     /* disable power gating */
>>> +     r = jpeg_v5_3_0_disable_power_gating(adev);
>>> +     if (r)
>>> +             return r;
>>> +
>>> +     /* JPEG disable CGC */
>>> +     jpeg_v5_3_0_disable_clock_gating(adev);
>>> +
>>> +     /* MJPEG global tiling registers */
>>> +     WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG,
>>> +             adev->gfx.config.gb_addr_config);
>>> +
>>> +     /* enable JMI channel */
>>> +     WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL), 0,
>>> +             ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>> +
>>> +     /* enable System Interrupt for JRBC */
>>> +     WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regJPEG_SYS_INT_EN),
>>> +             JPEG_SYS_INT_EN__DJRBC0_MASK,
>>> +             ~JPEG_SYS_INT_EN__DJRBC0_MASK);
>>> +
>>> +     WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
>>> +             ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
>>> +             VCN_JPEG_DB_CTRL__EN_MASK);
>>> +
>>> +     WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_VMID, 0);
>>> +     WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
>>> +     WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
>>> +             lower_32_bits(ring->gpu_addr));
>>> +     WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
>>> +             upper_32_bits(ring->gpu_addr));
>>> +     WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR, 0);
>>> +     WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR, 0);
>>> +     WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_CNTL, 0x00000002L);
>>> +     WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_SIZE, ring->ring_size / 4);
>>> +     ring->wptr = RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +/**
>>> + * jpeg_v5_3_0_stop - stop JPEG block
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * stop the JPEG block
>>> + */
>>> +static int jpeg_v5_3_0_stop(struct amdgpu_device *adev)
>>> +{
>>> +     int r;
>>> +
>>> +     if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
>>> +             jpeg_v5_3_0_stop_dpg_mode(adev, 0);
>>> +     } else {
>>> +
>>> +             /* reset JMI */
>>> +             WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL),
>>> +                     UVD_JMI_CNTL__SOFT_RESET_MASK,
>>> +                     ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>> +
>>> +             jpeg_v5_3_0_enable_clock_gating(adev);
>>> +
>>> +             /* enable power gating */
>>> +             r = jpeg_v5_3_0_enable_power_gating(adev);
>>> +             if (r)
>>> +                     return r;
>>> +     }
>>> +
>>> +     if (adev->pm.dpm_enabled)
>>> +             amdgpu_dpm_enable_jpeg(adev, false);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +/**
>>> + * jpeg_v5_3_0_dec_ring_get_rptr - get read pointer
>>> + *
>>> + * @ring: amdgpu_ring pointer
>>> + *
>>> + * Returns the current hardware read pointer
>>> + */
>>> +static uint64_t jpeg_v5_3_0_dec_ring_get_rptr(struct amdgpu_ring *ring)
>>> +{
>>> +     struct amdgpu_device *adev = ring->adev;
>>> +
>>> +     return RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR);
>>> +}
>>> +
>>> +/**
>>> + * jpeg_v5_3_0_dec_ring_get_wptr - get write pointer
>>> + *
>>> + * @ring: amdgpu_ring pointer
>>> + *
>>> + * Returns the current hardware write pointer
>>> + */
>>> +static uint64_t jpeg_v5_3_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
>>> +{
>>> +     struct amdgpu_device *adev = ring->adev;
>>> +
>>> +     if (ring->use_doorbell)
>>> +             return *ring->wptr_cpu_addr;
>>> +     else
>>> +             return RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR);
>>> +}
>>> +
>>> +/**
>>> + * jpeg_v5_3_0_dec_ring_set_wptr - set write pointer
>>> + *
>>> + * @ring: amdgpu_ring pointer
>>> + *
>>> + * Commits the write pointer to the hardware
>>> + */
>>> +static void jpeg_v5_3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
>>> +{
>>> +     struct amdgpu_device *adev = ring->adev;
>>> +
>>> +     if (ring->use_doorbell) {
>>> +             *ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
>>> +             WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
>>> +     } else {
>>> +             WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
>>> +     }
>>> +}
>>> +
>>> +static bool jpeg_v5_3_0_is_idle(struct amdgpu_ip_block *ip_block)
>>> +{
>>> +     struct amdgpu_device *adev = ip_block->adev;
>>> +     int ret = 1;
>>> +
>>> +     ret &= (((RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS) &
>>> +             UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
>>> +             UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK));
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static int jpeg_v5_3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>>> +{
>>> +     struct amdgpu_device *adev = ip_block->adev;
>>> +
>>> +     return SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS,
>>> +             UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
>>> +             UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
>>> +}
>>> +
>>> +static int jpeg_v5_3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>>> +                                       enum amd_clockgating_state state)
>>> +{
>>> +     struct amdgpu_device *adev = ip_block->adev;
>>> +     bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
>>> +
>>> +     if (enable) {
>>> +             if (!jpeg_v5_3_0_is_idle(ip_block))
>>> +                     return -EBUSY;
>>> +             jpeg_v5_3_0_enable_clock_gating(adev);
>>> +     } else {
>>> +             jpeg_v5_3_0_disable_clock_gating(adev);
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int jpeg_v5_3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>> +                                       enum amd_powergating_state state)
>>> +{
>>> +     struct amdgpu_device *adev = ip_block->adev;
>>> +     int ret;
>>> +
>>> +     if (state == adev->jpeg.cur_state)
>>> +             return 0;
>>> +
>>> +     if (state == AMD_PG_STATE_GATE)
>>> +             ret = jpeg_v5_3_0_stop(adev);
>>> +     else
>>> +             ret = jpeg_v5_3_0_start(adev);
>>> +
>>> +     if (!ret)
>>> +             adev->jpeg.cur_state = state;
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static int jpeg_v5_3_0_set_interrupt_state(struct amdgpu_device *adev,
>>> +                                     struct amdgpu_irq_src *source,
>>> +                                     unsigned int type,
>>> +                                     enum amdgpu_interrupt_state state)
>>> +{
>>> +     return 0;
>>> +}
>>> +
>>> +static int jpeg_v5_3_0_process_interrupt(struct amdgpu_device *adev,
>>> +                                   struct amdgpu_irq_src *source,
>>> +                                   struct amdgpu_iv_entry *entry)
>>> +{
>>> +     DRM_DEBUG("IH: JPEG TRAP\n");
>>> +
>>> +     switch (entry->src_id) {
>>> +     case VCN_5_0__SRCID__JPEG_DECODE:
>>> +             amdgpu_fence_process(adev->jpeg.inst->ring_dec);
>>> +             break;
>>> +     default:
>>> +             DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
>>> +                       entry->src_id, entry->src_data[0]);
>>> +             break;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct amd_ip_funcs jpeg_v5_3_0_ip_funcs = {
>>> +     .name = "jpeg_v5_3_0",
>>> +     .early_init = jpeg_v5_3_0_early_init,
>>> +     .sw_init = jpeg_v5_3_0_sw_init,
>>> +     .sw_fini = jpeg_v5_3_0_sw_fini,
>>> +     .hw_init = jpeg_v5_3_0_hw_init,
>>> +     .hw_fini = jpeg_v5_3_0_hw_fini,
>>> +     .suspend = jpeg_v5_3_0_suspend,
>>> +     .resume = jpeg_v5_3_0_resume,
>>> +     .is_idle = jpeg_v5_3_0_is_idle,
>>> +     .wait_for_idle = jpeg_v5_3_0_wait_for_idle,
>>> +     .set_clockgating_state = jpeg_v5_3_0_set_clockgating_state,
>>> +     .set_powergating_state = jpeg_v5_3_0_set_powergating_state,
>>> +};
>>> +
>>> +static const struct amdgpu_ring_funcs jpeg_v5_3_0_dec_ring_vm_funcs = {
>>> +     .type = AMDGPU_RING_TYPE_VCN_JPEG,
>>> +     .align_mask = 0xf,
>>> +     .get_rptr = jpeg_v5_3_0_dec_ring_get_rptr,
>>> +     .get_wptr = jpeg_v5_3_0_dec_ring_get_wptr,
>>> +     .set_wptr = jpeg_v5_3_0_dec_ring_set_wptr,
>>> +     .parse_cs = amdgpu_jpeg_dec_parse_cs,
>>> +     .emit_frame_size =
>>> +             SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
>>> +             SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
>>> +             8 + /* jpeg_v5_3_0_dec_ring_emit_vm_flush */
>>> +             22 + 22 + /* jpeg_v5_3_0_dec_ring_emit_fence x2 vm fence */
>>> +             8 + 16,
>>> +     .emit_ib_size = 22, /* jpeg_v5_3_0_dec_ring_emit_ib */
>>> +     .emit_ib = jpeg_v4_0_3_dec_ring_emit_ib,
>>> +     .emit_fence = jpeg_v4_0_3_dec_ring_emit_fence,
>>> +     .emit_vm_flush = jpeg_v4_0_3_dec_ring_emit_vm_flush,
>>> +     .test_ring = amdgpu_jpeg_dec_ring_test_ring,
>>> +     .test_ib = amdgpu_jpeg_dec_ring_test_ib,
>>> +     .insert_nop = jpeg_v4_0_3_dec_ring_nop,
>>> +     .insert_start = jpeg_v4_0_3_dec_ring_insert_start,
>>> +     .insert_end = jpeg_v4_0_3_dec_ring_insert_end,
>>> +     .pad_ib = amdgpu_ring_generic_pad_ib,
>>> +     .begin_use = amdgpu_jpeg_ring_begin_use,
>>> +     .end_use = amdgpu_jpeg_ring_end_use,
>>> +     .emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
>>> +     .emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
>>> +     .emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>>> +};
>>> +
>>> +static void jpeg_v5_3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
>>> +{
>>> +     adev->jpeg.inst->ring_dec->funcs = &jpeg_v5_3_0_dec_ring_vm_funcs;
>>> +}
>>> +
>>> +static const struct amdgpu_irq_src_funcs jpeg_v5_3_0_irq_funcs = {
>>> +     .set = jpeg_v5_3_0_set_interrupt_state,
>>> +     .process = jpeg_v5_3_0_process_interrupt,
>>> +};
>>> +
>>> +static void jpeg_v5_3_0_set_irq_funcs(struct amdgpu_device *adev)
>>> +{
>>> +     adev->jpeg.inst->irq.num_types = 1;
>>> +     adev->jpeg.inst->irq.funcs = &jpeg_v5_3_0_irq_funcs;
>>> +}
>>> +
>>> +const struct amdgpu_ip_block_version jpeg_v5_3_0_ip_block = {
>>> +     .type = AMD_IP_BLOCK_TYPE_JPEG,
>>> +     .major = 5,
>>> +     .minor = 3,
>>> +     .rev = 0,
>>> +     .funcs = &jpeg_v5_3_0_ip_funcs,
>>> +};
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h
>>> new file mode 100644
>>> index 0000000000000..c1e7537d0f183
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h
>>> @@ -0,0 +1,35 @@
>>> +/*
>>> + * Copyright 2025 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person obtaining a
>>> + * copy of this software and associated documentation files (the "Software"),
>>> + * to deal in the Software without restriction, including without limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to whom the
>>> + * Software is furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +
>>> +#ifndef __JPEG_V5_3_0_H__
>>> +#define __JPEG_V5_3_0_H__
>>> +
>>> +#define vcnipJPEG_CGC_GATE                                 0x4160
>>> +#define vcnipJPEG_CGC_CTRL                                 0x4161
>>> +#define vcnipJPEG_SYS_INT_EN                               0x4141
>>> +#define vcnipUVD_NO_OP                                     0x0029
>>> +#define vcnipJPEG_DEC_GFX10_ADDR_CONFIG                    0x404A
>>> +
>>> +extern const struct amdgpu_ip_block_version jpeg_v5_3_0_ip_block;
>>> +
>>> +#endif /* __JPEG_V5_0_0_H__ */
>>

