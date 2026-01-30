Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F888D49C9D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 10:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C917210E992;
	Fri, 30 Jan 2026 10:40:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RfiKkT9C";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F94F10E992
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 10:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWFdMuea+LQtN3eVoN2aWZBdffuxpDab2QaahAkbTusengmh/b0QJIyIFl9zonnGRE/qPe1jULezRJiDSeDU8IgPvyAoXR+rZDUtr0DFqyymrOyaBJ19hKJwV9C/yqSOQvikof4wfy1pIGYlPH19NciAuhQy52C3VIByBlf19qT3UG7SAKVEGVYlGvALq8dX2G1xAxDNi/6mh5oyBFKs+2I+LxXKGYU0YYRF218vQTtl0M+3b0Bf7GU51hlkRJabAVbuyS/OYW6gnkPYha+oh17cVJgyrOm23iwn3hsqaEN1BPlvCVkOwMeahQG3OtOPtk+X9B8CIWOOHa1vIOVfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heRvVeTPkzt9NyCuQr261w4hTB0SS2cDvGGi0UVfpKU=;
 b=qjAlh0w5l3zcApkf+CcImhWxGldJUiGMHowaIbwpgHGZuGGW2Kz9DPconougdwa+NRIN+40v1uJ3Xir0MV32H6OBx97ej1Jp4HyxQOqfJhPyG70OOPN/IPHhnxx8NJWorMRfKIfENvgZxf4YnfOBnILxed2YRl3+EXZj+tVV6JfJl5TXStLkeVnlL6lslOUbPN7jU97Jn7aFQgrTsOVYcx3BZ6FR/Ah0tQnNgui97l9B3z4Q7V583ELOFwRLsXfQ0R/wnYUFiqmE7iVEM14+0PdY5A7kV4SlBuqJibV7c0gO6xMJFBNGrFoqdukNZ63UwwCs/9JaTSx44JMrLECrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heRvVeTPkzt9NyCuQr261w4hTB0SS2cDvGGi0UVfpKU=;
 b=RfiKkT9CQANws8Hb8Vxp2fwEvuAPolsgiqpTW2Ylhw2Wb/Ui+MRaykuC+h6+UTqgeinXMoRtpnbaa9DYErMjIjk/xZeOEojLgJ+0aevPjGV88Laz0wLO/MjlW/os1pDYjkDeAIQbeO6a5qv2+yUQNMhPJRCMMt5DCQcYsDllM28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Fri, 30 Jan
 2026 10:40:11 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 10:40:11 +0000
Message-ID: <208c51d0-7ba3-4d1f-be3c-822ea1a49685@amd.com>
Date: Fri, 30 Jan 2026 16:10:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Skip vcn poison irq release on VF
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Mangesh.Gadre@amd.com,
 Stanley.Yang@amd.com
References: <20260122065538.1595301-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20260122065538.1595301-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::21) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d902a0a-fa32-4ffe-ea1a-08de5febf182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHBiM1RDOTV6c3BIc1dlOXJ6bXFmbWdBanJoNmhJTWdPQzFZTGcvcGY2cGNG?=
 =?utf-8?B?aVlYNGVVQzltVlJOSUp3eTdVRUxLaTh4RDJXRXBRMzlSVFQ4aVVLaC9nWmdm?=
 =?utf-8?B?dnVHcFljU1lRSzFCS0tCYUVuSTRhWjBRVnpOa0Q4V3JnWG14dnM2Q09sTkls?=
 =?utf-8?B?ZjluT2U0dFdxQjZtc1JGaUZuUVlSQWRoSnlxUnRDMVNiWk01UjJVYWFuREhh?=
 =?utf-8?B?cm9LWDFqSjZsZVFsbXg3QS9ZR1daMWxUVWR4STRsYTd1eU1EdmNkQ1czQVhR?=
 =?utf-8?B?aGhwWFJPZlUzTUNMcDNEM0dCNTQrZFJuNnpVSzlvQ2FCRG01UVpGK05pc1hu?=
 =?utf-8?B?RkUyeVNNQzZjaEs0SHJYQzAxOWNzdDd4RzROb1ZOUVprQ3Fna3AvWVFualh0?=
 =?utf-8?B?VHdKUzJ4K2tpZXZqQ3B4bDFSbTJ0R3UvVHVuVERuRmdpMHM1aFEyU2pXQkpR?=
 =?utf-8?B?cGdiVUlhcWlVYVVYSHdqWWpjMEdPUTZ5czZpWXVkNEJPWGhneGExWlFQKzlG?=
 =?utf-8?B?YUdtOHN1OGZad044QzN1MTNzQVFkdm1ueXZjbHpIamE0bEhrVW9xOUo3MEdz?=
 =?utf-8?B?MktURW9RSURLZXZidmwrdkVaL0MrQ240MmFKdS9BcGFGd1ltanZ6T0QzY1ZK?=
 =?utf-8?B?aGJFOFFjMEhBejZIWFh0aktEaW5oQkFpWVNNaFdvbE9HODBSUFF2aTBQWUU4?=
 =?utf-8?B?a3YySzdyYVVXcGFUeFpGNm1oYzBqYWJienBJbndXRWt3bmpEcElSVXpvenN6?=
 =?utf-8?B?TGZPRTNmYVBJa0J0YWRaUlZPT3o1cGFxUHF6dUFkUTV2c0F0WmdVVHZuUnpM?=
 =?utf-8?B?MW1SdjhucVc2aDA1a2E3UnhHUXZ6azRDZHVNK2xtbE5wU1RNTjQ0b1JZMjNt?=
 =?utf-8?B?YVBVUXFvcXJISTVZWEZlbmFvMTd4QU1qTlZaM1VRUjRHNVVWSFFuVDVXU2NB?=
 =?utf-8?B?ZWRJdlUvb1h0dkRIdGpBcW9tSG1ZZVBiRlVSdEluNmFrdWRnWG1jRkFnbnVT?=
 =?utf-8?B?Zk5GWjRSQnY5SHA3ZWFCbVRPQm5pb2l0WVZ6ajRXaEZJVHJzQnVRcTAxRnNi?=
 =?utf-8?B?K0xST2VzVktVRTRUYlhudXlNd2llK2g2WjJ5OU9CY1lmRHpuTE4wTHNLdThD?=
 =?utf-8?B?MlI2d0x1MUQvWEJ3ZWZOT1JuakZ6VnNWTnE5Ym9ISTlienZOWWR5SHQ5ZlN3?=
 =?utf-8?B?RjdINHVGeFFvaktCWG5KbHlhdzNhUU1FZVlqVDRobTAvZnNqMXNQdHdUWUR5?=
 =?utf-8?B?Wmg1TjNhZDRsWUVJNVhBOHZqVTlEckZoVXBwMHBTR1RvNjE2SDIzenVGdm5t?=
 =?utf-8?B?TE50KzB0RWE0NXR5ZHI2d3loWVZaTkx5YzdFMG1rRHMyZWFYUzRBOVZTdER0?=
 =?utf-8?B?WTYzWHVndHJteU9tSjI1a1E0WkpXS2loUU5DVk40VlU3dDk0Yis3bjNrYzVr?=
 =?utf-8?B?MXZxZXFGRFNJemVZYmZLNUNIeWRBcWI3QXRwSk1KL21rTHNLOXl4UHZlVFRS?=
 =?utf-8?B?WllZVjN4NzNsK1lzVkg5S2d3amxDdWI5UjRPbDgxSXUxUnd3c25HTEZGTVJF?=
 =?utf-8?B?bzhuUnFsRjJpcGVJM1RkWUhlNi9RaWpySGcyMDNFMGJURldpTnB4SjdrMVRs?=
 =?utf-8?B?aTJKU2pIWEoyQk02Vk1weFZURUlhZGRBdlQ1dWVabGcyWEdtS2VsRFFDOUxM?=
 =?utf-8?B?RDRZR0NTcDFOVURrVWZzT3cyRW0vRWJkd0t3aisyR1hmT1lXL09COEUycVRy?=
 =?utf-8?B?KytUaDYvLzA4SzY4cWsvOXAxbzdSQ1hmR0x3SDNPdTU1eXRXVG1GWHlNVEJP?=
 =?utf-8?B?RC9TeTBsbkRrdk1URnQ0VzJOb3RUc2FYZ2Y0QkJISGJlQXFPSHBHczdIOXVi?=
 =?utf-8?B?bnY0eitFV3EzUTB0UVRadUYxK2JEMTF3QjJEVFBqMjUxRVVuODFON1lMalRI?=
 =?utf-8?B?Lzc2YkR0RFZqV08zOTdtdzVVejVvU2FLTnh2K1NqNkQweWpFaXBud3dTK1U0?=
 =?utf-8?B?dFNqL1FRVUNZS21COWUxMGNKTkh0dTJ1dlFBeVo2OFZ0alFhRThmd2hvWUsz?=
 =?utf-8?B?a2VTMGJLTUhiRzdLOGVNWTdZdG9BTVNiTzN5SXkydzlUZkJYVEtvblFEOVk4?=
 =?utf-8?Q?4QTo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVJzQkg1MTk1d1hqcjZNN0tkaVZlQ3ZrNVVTdVdFbjFiNlhIbm5tZis2WlZS?=
 =?utf-8?B?eUxHalNwN3Jibzg5Y25sMG4ySElPTGdBVnBuK0NzTVNZcnlsbGRIOGMwR3ZX?=
 =?utf-8?B?SlNDTTYrdi9NamFPRnQrTVluZzhqSE5sWCtqcm1hVTRPUTBFUjhoK3JDYVpL?=
 =?utf-8?B?OEx3R1J4eXl2TTdwbG02aFRsbTAzTDFyTWRrMmM5L2NlVTE2dEFieHhiNEI2?=
 =?utf-8?B?a3BlWjBzRnZBeUhaaWswdHhZUTYvc2RtbC81cmtBR1N2THRLV1AxeFFOMVB3?=
 =?utf-8?B?NjN6WHN6b3VWTG1pK2g0OUJwM0c3N3cwRGg4TURtTGdORVk1NlVGSnd3SStS?=
 =?utf-8?B?TFFLUmJVdDc5SGdyZ3VjRGxkU3ZySE0rcGlGNVh6SytQYkp2SllVaGpOSWNM?=
 =?utf-8?B?eXE2WGRuQ0JUdDBiWkNEb3B2dDJYVmppZmgyMmFPSGhYUU5HV1NmUFZRNkR2?=
 =?utf-8?B?czBuNXNwQUxTSm5FWUVvNVlzdjUxaGFOYkdlT0hNMnpQMDFKZjl3Uk5VT05P?=
 =?utf-8?B?YUtuSmgycjhQN01HQ0hHMk1UUHd0Zk5KUlllT0dSTnAySmtJQ2Jsc3crZHNI?=
 =?utf-8?B?QVdsOSs5bjdPam9ZdW0wQ3pDSnQxVHRzQWZxWFpxRC9ONEdBSHVJbU56bjNZ?=
 =?utf-8?B?VUxEMTRGanI5cjhHeHdSQVBsZlRFN3V2MlJDT1NOSTAxMjFiTlNmaUxSUmJQ?=
 =?utf-8?B?R0ZyY2xMY3FUSU55aWxQc3ZWWWN2QUZCTTVrUzhVcGEwZnJtWHBub0JWbE5y?=
 =?utf-8?B?ZndNOVpjT05IaDVCdkJYY3N0SjJrV1lkZTE2K0FUdUdsakxlaWt3dUJMUUZF?=
 =?utf-8?B?VWtpUWFzU04zYTc0bnN2NVlCT0tXeU5tVVNtQlZxWlAyR2h6aTVCaEsvTEht?=
 =?utf-8?B?ZytkMFVVK0dYa000YVpJWVlXWmhiZHFCQ0ZEZTRSejhxMi95bEhjR1NmNkVX?=
 =?utf-8?B?c0xabEY4a21hTGIxY09zNEEvUVIxbmtUeDRWdk9vZC9TdmlKdmJHdnJMb1B4?=
 =?utf-8?B?Y0pPcFlDSTJOQ2FNT09qaC9Idk85a2ltY2JmY2NSRWtSQmo1bGtyY0ZETzlu?=
 =?utf-8?B?d2EyU2pCWDUySFh0Zk9MSlA2RFZkNXNyblFZSTY1cmZ1dStOWHBQV25ZM2JT?=
 =?utf-8?B?dUhqc05tdUFCa0VsbDlyOHFOb1d2dGlXaGJGV2Z2YWRJYmtNejI2U1BkK2Fr?=
 =?utf-8?B?Zzg3QmFRUWN5OU1CeTJkVGF6c09uQytRTWRJVnpqdVNTTFE2b1pzOVRTRmdh?=
 =?utf-8?B?SmloWTNTUVNudzFNdnFwS3JpWXlpV2dRaEV2cnI4dGVnV1dRelRsZHA3bFky?=
 =?utf-8?B?MmJlSjRYb25RQ0F0Q3pPUVhnWklSN2V6L3lkSVovdzRUdFpUKzJ0VWVaVHBM?=
 =?utf-8?B?VTFpY29ZOUxqdlZ6bWxxSkxuRHZOcHBvMDNzYjRvUEZacEsvbldDR2FML0I3?=
 =?utf-8?B?UzR6QUF1ZjNZd1pxYjBwSGJHVDVpVjU0RHpwcjZJV2tmS3BoL1h4d2NVYkc4?=
 =?utf-8?B?U25zc3lGTlJaN2RDck45YVdPV0hXaXdoclp6NzRsMFA4eHlGQ3pNdTh0M0N2?=
 =?utf-8?B?NmpKQmZqNTJvYTNUQlN0Y3p0aEF5OFIwYWRpR2Y3bWl4cWRXRzF0ZXdsZFhB?=
 =?utf-8?B?bmFCUzBNRlpmY3YwTm1pbHlXb1ZRekxpblRKZFVSSjduZFlzQzVOVTd6QThl?=
 =?utf-8?B?Z2NOdlZyQUdOZHlySGpteS8vOGI1MTczamJ3VE1JSnc1emRDVXJJVTBBbDVr?=
 =?utf-8?B?aFBSSnJUdW0rZDliTTA3MG4yWXJHU0U2OEk3dkdUaEkxM0ZYV1pLbWNxcTc0?=
 =?utf-8?B?V1hsSEF3MU5qbGptbVI2L2lJQjIrNXVDaXhqbnhBU2tyU0NhbG5YUko5bzJl?=
 =?utf-8?B?bHRBYmh3Vzh1U01ReTRDVXEzN3ZwZjVaeDJhNUZxcDRscmxsMlpvL0o5NUFT?=
 =?utf-8?B?YjUydGdDL0w2Z0NyRytmTzM3bDQwcGp0azJDZjU3WGhxT1NzdkhaUkZaRmg3?=
 =?utf-8?B?SE14MTN5Wmh1WkR5QlRUaVF6VFA4aDdQR3p1Y2haRmhjYXAycHY2WndySjFr?=
 =?utf-8?B?MitBd1BpZ1ZXL3Q0Y2IxNlZMMnJEZW5YbGV0dEs4ZFRacmxUOU9ZaW81TE9n?=
 =?utf-8?B?Njdyb25VbkxQNzVoNXJRaVpBL0xRdmVleE5BSnFreDdneHRydGx5VFNXYXMv?=
 =?utf-8?B?VHo1M1ZHQ0dLQVI5dFhlVWVVR054QkhMOXU3ckt4aFlUaGZVOGN4K0dGcFNE?=
 =?utf-8?B?cXpOQ3prQXlpREg1dVFueHR6YktMRkpuVDdWWmtQdWx2VUo5Z202dnBzUUJC?=
 =?utf-8?B?UWIwZGh6OGFKVHg0N1RqUUc2MjAzMStTVExzWENoSjV2c0Y3THpWQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d902a0a-fa32-4ffe-ea1a-08de5febf182
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 10:40:11.0940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLzdXyYA5Ao0pSAXtDzIT1NFsTjokBINF2G1W/dVuQ8U+Vc+SqVowrKiU3hWt0QA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945
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

<ping>

On 22-Jan-26 12:25 PM, Lijo Lazar wrote:
> VF doesn't enable VCN poison irq in VCNv2.5. Skip releasing it and avoid
> call trace during deinitialization.
> 
> [   71.913601] [drm] clean up the vf2pf work item
> [   71.915088] ------------[ cut here ]------------
> [   71.915092] WARNING: CPU: 3 PID: 1079 at /tmp/amd.aFkFvSQl/amd/amdgpu/amdgpu_irq.c:641 amdgpu_irq_put+0xc6/0xe0 [amdgpu]
> [   71.915355] Modules linked in: amdgpu(OE-) amddrm_ttm_helper(OE) amdttm(OE) amddrm_buddy(OE) amdxcp(OE) amddrm_exec(OE) amd_sched(OE) amdkcl(OE) drm_suballoc_helper drm_display_helper cec rc_core i2c_algo_bit video wmi binfmt_misc nls_iso8859_1 intel_rapl_msr intel_rapl_common input_leds joydev serio_raw mac_hid qemu_fw_cfg sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 hid_generic crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic ghash_clmulni_intel usbhid 8139too sha256_ssse3 sha1_ssse3 hid psmouse bochs i2c_i801 ahci drm_vram_helper libahci i2c_smbus lpc_ich drm_ttm_helper 8139cp mii ttm aesni_intel crypto_simd cryptd
> [   71.915484] CPU: 3 PID: 1079 Comm: rmmod Tainted: G           OE      6.8.0-87-generic #88~22.04.1-Ubuntu
> [   71.915489] Hardware name: Red Hat KVM/RHEL, BIOS 1.16.3-2.el9_5.1 04/01/2014
> [   71.915492] RIP: 0010:amdgpu_irq_put+0xc6/0xe0 [amdgpu]
> [   71.915768] Code: 75 84 b8 ea ff ff ff eb d4 44 89 ea 48 89 de 4c 89 e7 e8 fd fc ff ff 5b 41 5c 41 5d 41 5e 5d 31 d2 31 f6 31 ff e9 55 30 3b c7 <0f> 0b eb d4 b8 fe ff ff ff eb a8 e9 b7 3b 8a 00 66 2e 0f 1f 84 00
> [   71.915771] RSP: 0018:ffffcf0800eafa30 EFLAGS: 00010246
> [   71.915775] RAX: 0000000000000000 RBX: ffff891bda4b0668 RCX: 0000000000000000
> [   71.915777] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [   71.915779] RBP: ffffcf0800eafa50 R08: 0000000000000000 R09: 0000000000000000
> [   71.915781] R10: 0000000000000000 R11: 0000000000000000 R12: ffff891bda480000
> [   71.915782] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
> [   71.915792] FS:  000070cff87c4c40(0000) GS:ffff893abfb80000(0000) knlGS:0000000000000000
> [   71.915795] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   71.915797] CR2: 00005fa13073e478 CR3: 000000010d634006 CR4: 0000000000770ef0
> [   71.915800] PKRU: 55555554
> [   71.915802] Call Trace:
> [   71.915805]  <TASK>
> [   71.915809]  vcn_v2_5_hw_fini+0x19e/0x1e0 [amdgpu]
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index cebee453871c..006a15451197 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -521,7 +521,9 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
>   			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
>   
> -		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
> +		/* VF doesn't enable interrupt operations for RAS */
> +		if (!amdgpu_sriov_vf(adev) &&
> +		    amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
>   			amdgpu_irq_put(adev, &vinst->ras_poison_irq, 0);
>   	}
>   

