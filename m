Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB8FE83EF5
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 09:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7169A10E59E;
	Wed,  4 Feb 2026 09:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U3FWyKRg";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010052.outbound.protection.outlook.com
 [40.93.198.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E7410E59E
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 09:31:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxe6EbXndWDTjT+Ts5tGJArvCQJkr7dJub1zTOVnGh7zyw2+ycb6vnpML0562qlkZVjrju9fO5SSwyQcUwQoA9J5xpmhan/lqur1fKCZTXBvvA4F9HCit+uVyiqSnKtmm+eTVLqE2NYQLN3w6wgKY3xkJzUGg3ZdY9FBoXFZXwUDwszHmpbVkEjz8F+HRltQfdFxclmkV+zgRrjC0LwsqSN/2s30lplmnPxOyMhgtLkG1qbsc1V31OIMCZ88gCRfFVc4N19nEfUxIFDIKhw+cS/wx9htpACJlakZx1ZXA0OuCbT0SYB2E0XH0IH6lVmrKt0R6hB2dcZglsCUMgzEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbNh7DIGXL4WW9zKn+7LZsaB2UbgwR7uSGvhWzOX1kM=;
 b=wVvgfztjQk+h834RdcQNMn6UJ4IaKiJfL+8yUUwKQ+1219qjYXEa8yzne0hKwIGFlVx6GbC9LoZblYEWaKYi5BphIrnQnvj8ANx4nJBeXlrfcgruK7+Sa6pVWjoqXLHZy7AzdUSRmtU3joyAWda8Qs7c+DqGojft4rwF61oVZna1tYJHMjbc6K/UuqrI6eoGBOHPhcPKVDtbX1yf9IuSqc1ea32w07PPQrG7SVtsxoYnAPPEqToPO44vkTVhyabdYbiXWcwp2tHUpM3Udm1q6lR6uIKSTu4wmkMOjv5pQ3dJB/DxQjMHCHsnvoPuGUUoCxl2UgQ59WtrsmgwSgNdAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbNh7DIGXL4WW9zKn+7LZsaB2UbgwR7uSGvhWzOX1kM=;
 b=U3FWyKRgWf+dyjCYdmEvbffy2OtgEb1guHxCPAIO1BTVKgiGGu5o3Y34FXjJeM+iTtjHeGsbij3XhPu/eF20UlXJycddjcmVeFuE4yIpmB9cYeFLn8xe1cK0GwrMc4pnI/Wf48YdaW8+sxUBdw7u22o2YoSAuff0gQ8NpByUIKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 09:31:28 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 09:31:27 +0000
Message-ID: <13ffc589-243b-41f6-b219-9136fbcaf09d@amd.com>
Date: Wed, 4 Feb 2026 15:01:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: Remove redundant and incorrect multi-vf
 check
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260204082547.3799740-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260204082547.3799740-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0131.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: b3219daa-a86d-4689-553c-08de63d02c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHhqbVFOVnM2K3lEZnY1TTg4TGV6L2NPdHVsWStXeUZUQm9ibnE5WGV2V1RY?=
 =?utf-8?B?MlpHaVRTcWJiL3BKeDhGREs4N25uLzdwMkVoWEZxSUpwNFZlaU4zQ2N2dHFy?=
 =?utf-8?B?MzhJNUtoNXM2MEZ6RzYzc3Y2YTFMT1BEVG9PWVVKUFl3cXU3K2JESHVYdFd4?=
 =?utf-8?B?R1dvYi9BcUxic1hFU1pPTHhhQWdVZWpuYzAyTjZiTDl0Z21tTkhWVjdQTWdK?=
 =?utf-8?B?REtpWVJ3SUNPN21wcjljNTRTVCtST1FYVUJ6ZWRrNTc2YnVVMjJua0NkV1Zn?=
 =?utf-8?B?MXZjTnJDS1FSMjRnWnVJTUQ4MFB6UGNycDlTVG5GRm50SWQzQUpyb3N6Znpq?=
 =?utf-8?B?aS9CZk9GRHZZeko3V1dNc0dXTk9QNk9yc1c3VWczUzJVQ2hzMlhydnJZemZM?=
 =?utf-8?B?QXlMaWhhWmZ4WDNrVXpZS2V4dnNZTEs0REZDUlFQemdwazJKTFVDT28xR1ZL?=
 =?utf-8?B?TUpqTG9QdXg3OER1N0FPWTM0d1FQZTlqcFVIcEtQczVwVVl0bXdPM2ZmVmhC?=
 =?utf-8?B?VEhyamlsT0R6V3MrRTRrOTVuTVVNSGhTL09tMW1jdEVEdmNuMXNuVmRHSFky?=
 =?utf-8?B?UGJNYzRkUXB4VmZCNlVGNStKQmhSdnJqZ0lHZndtZUY4RWx0VlJHVmNPNjR2?=
 =?utf-8?B?ZWx3ZEVWeERwRDBxd3V0QWFKa3JKWVBPeG5yYmh5SWpjbjlVM0VGN2l0YUZZ?=
 =?utf-8?B?QlF3SkhOTVRENjJDY25LblkvQTNtQ2JtY2g4MlJSYWFvNnRDckZOL1U2OHpz?=
 =?utf-8?B?WENIMUJaRCtMQS9ZcmxEdnBaQjFldnZ3ci9VRFZVWU5QMUl5NXFCenJCUXRm?=
 =?utf-8?B?UHVaUUFnTDdaaDJNVjY1MHU4KzhaWHBWYnlRTUs3TXhjY1Qrb0g0UE5JS2xv?=
 =?utf-8?B?L2Z4UXUyVGdQTnR0TVQ1bzRQM0p6SHpLMkd6d0MzM3RQT2ZDNTAxN0tRK3BJ?=
 =?utf-8?B?dDk3OXlmL0VvaUU2bEJuWTdMRjc2WmlDeUtjbDdua1RncXJ1OVVHaEZNZmtF?=
 =?utf-8?B?eGxCWTVPU0VmaUUvalI3S0lLeE85eFdrR3h5M0RGRU1ZS09RcXNPYXFpTHJv?=
 =?utf-8?B?OWdRaEZHR2RpN000K1hlVjRqTnNXd1hvZTJhWHJkU3FXQjV5Ukd1VHh1b01h?=
 =?utf-8?B?T3gweG9QcG96bGQxZ3Q0R0JxdCsrUmlsRGZzSGlzY29DN2ZCYjRjdlpYSVJ6?=
 =?utf-8?B?Unc5OGYyQ05WZElzeVhTTXUwNm55VE5QNGZrZm12N2ZoaU5zbzFsMUF4OVdD?=
 =?utf-8?B?bzhJendvdlBMQ1A4MjJPWDlOdDdNRlAvMW5BcXdyNTRjaTl4OVB3UTZiVTJG?=
 =?utf-8?B?TjA0MEQwOUcyalVYVWV1UEVmMkZOVzJ0NEJXSGthRXl4eWJnRElKUklLVWlJ?=
 =?utf-8?B?RlFwVHYyUGh6ejZYK29xeTFmMWJHcWJ4ZFhZaEExQllEOTBZK1BwTHVla0N5?=
 =?utf-8?B?M1hSZWx0cEVmUHBuc3dPMFBjTE51M1NlYTQrK1BDSkdJaGVFeVRrQ2lTaHBt?=
 =?utf-8?B?ZEVkMHRSeVBJeUFaWlRSYTRDYlhxOW1mbHBTVXNYekJWckpVaW9sTi93NXVG?=
 =?utf-8?B?MDFiNDNBNnluWlNLQ3lhelJKTWVIc1NnajRRSlZaOFJmeDNyWkdGajZ2dG45?=
 =?utf-8?B?dnI3dU96cnlXNlNDSFNMdjBtK2twRlhUSTRTRlNsTGlsdStjdHhkTllGWEVX?=
 =?utf-8?B?T0drRC8vZ0ZodUgxbFRzNDB4MWpVOXN1d09HcWdrRm9zbWJOd04wZkREV0Jx?=
 =?utf-8?B?YVErUGJEcXZHUjNBS2ZyLzhncll1OUp6eGVDdThmNG95Q2JTZ2ZtRVQ5Mllx?=
 =?utf-8?B?K3FwZW55Q2k5R3I3a0p6Z1F0Sm1jL0lOeC9IOGcxRWFheGsxOS90VU1uaGl0?=
 =?utf-8?B?WGlpTDMyRDFQaEp5dktLRVpUc01iWnF4VVkwQUpVc1laRWRIREliSnVWcjYv?=
 =?utf-8?B?eld6UHY3RG85LzdDZWFwZmZuQzlBV0MzL2h5QkZtc2VsZWhBb2FLUWdvemRH?=
 =?utf-8?B?SEZ3dCtUQmN5dzdBeHI4UW9VWkluVTJLcHFpNWlWakR3TUVPNmNjczRLa0J2?=
 =?utf-8?B?TDhzWmNPS2FpLzNwZzNOd1pJeWJXdkExRmpRMVdDVndLa0IzNm9KWENWODFQ?=
 =?utf-8?Q?FgKU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0phUEd2eFNQakYxY1grQzJhbEZKWlBWYU9GVjMwZUVkM1lpdVE2eUxvOU9i?=
 =?utf-8?B?d1VBUHcreU5HdllMQTUwNFdGVStoWTBlTWpUN0ZjVkhHamo1NGNRVjFtRzRR?=
 =?utf-8?B?K2VXNEU0QXJKb0NrYVRyZHV4MDNGZm55YTNsaXgwMEtKUk1OdTY5cysvM3RV?=
 =?utf-8?B?TUhtVitRZEtoUGF0YnJZSlJCV1BxQ1M2VER1c3BvZWRyZUxZdGZ4dlBzRkRN?=
 =?utf-8?B?citob2Y3djdicHIybnpIbGluSWVrSTlFUW4rNzZ4KytBU3FHbDFNZ2tzYnd1?=
 =?utf-8?B?ckdnemUvVHhNWjJZMFI5a2p6dFlTWDlhTEZGV3ZjcC9vMGF1TW9UWmFncHNC?=
 =?utf-8?B?Y3FrbVZnNHEvQTk4b01mL1JOSHZwYlNTT1Axb2N2SjA5Zm9rdFNlUHlNTXpL?=
 =?utf-8?B?Zkk1QnpxM2ozeHZZd29vK3cxSm8vUTRzNWVvdm1CVjJ2anpMVFVxZ1I0SC9t?=
 =?utf-8?B?ZW5tTnV6dHYzellVeGdtZDVyQVFRdkxNdDdaejIwQWlVZ1BMazFnTTM1M0JC?=
 =?utf-8?B?dHUzTjJadnA5K3dRUVdFVnhleTR5ZVFqTzVuVHRZVWRxaElDZkY4d3VUekhV?=
 =?utf-8?B?WGRMcFowM0czOXo1RFV3emJzRUVVUGQ3ZUtmNTU5Ykt1d0J5M2pPUHA0SUp1?=
 =?utf-8?B?Tk9Cemo0eHkrRWszSzVMM29wT3RYMloxbHhWR2xOeHIvYWU2V012NmE3NFFh?=
 =?utf-8?B?cVpvNXdzcENhQ1VTSEMwd3B1T2tiTmc5QzdHM3h2Wmw5TVFMRGkvbWFJVEtm?=
 =?utf-8?B?dG85UE54clpwSDFIVEVUSTdxb2FVZnovTXBmaG0rWmFMSlZ5bmVEY1hjcVJo?=
 =?utf-8?B?cUZXUCsxYWcxOXNmWEZlanYwQnNqdFEwMmZDK09sVGh0R3dIc0F2ODV3NFRJ?=
 =?utf-8?B?YUtsK1JyRUNXUjIwL2F5WnRGa3dDQ2xsalVDU1gzRWE1MmxoZlhFWEE4RUI4?=
 =?utf-8?B?b2pOWDFZVzBXNTRNaTc0WEZKU0RHU3didHhmV1FHR09ldm9NYzBuMkRJWXcz?=
 =?utf-8?B?T0F0ZnNDTlJJMVRYQnQrOEFNZG1rdXFSWnJ3Skd2bUgrd0N4WUdMcm9BN3da?=
 =?utf-8?B?eTZDQU1sWXNoM3VlbFdNdWwxRGxxYUNRak9tcnBZMlpZV1dGTzBzL2ZjRS9E?=
 =?utf-8?B?b2dUK3FnZ0N1OHkzUm8wNlUwbVo2b3ZXdWVZRTZVc2ZyejJmOVVYZkxnVVlK?=
 =?utf-8?B?U3g2bWZOYUV3ZHVyZnZlMFpGS3NxTDFFRklKcml2UEhneDE4djErVVNQRHdq?=
 =?utf-8?B?MGVjd3AyaTZVMEVjajhFVG5FN1FTem9vTThUdzJJL0FpaEU4c0wwWXdVRkcy?=
 =?utf-8?B?d1p6THNwZURHdytNL0tWYWU4Um9OY08zKzQxWlpwNWUxdjM3UVNUY216bnJP?=
 =?utf-8?B?WFVPL0txbDZOdFo3Ym9HSDZWcXBQaThmbHlweXpDQXR6dHcvZS8rVDZrSkU5?=
 =?utf-8?B?VVBobWRiRGtnQURSTVJsbHFjaFFhT2tqdWNQbEFDV3dXWFV4d1dhMEYyWEZ4?=
 =?utf-8?B?ZTl2VjlySjBnVW1RY2RiM0ZLNzVZRVFFTFE0TGV3dkg5Ky9WVnRadkZ4OHVk?=
 =?utf-8?B?VEhjVUVlbWQ1MkgrK3JVYTZmV2JmSHY0TG5rWmViNnZ3WnVybGxjbDRpelBK?=
 =?utf-8?B?eTNRa3l2dUozeXpPdzNSQmt1WkEzNjhYNTFadUQyNmhpNFdCb0Flb1pMR1pv?=
 =?utf-8?B?enhmVlhzTmtVN3l6N0t2QjBPM3M3bG5SZ3B6bVNOZVh5amdLS0J6NXJ3dEda?=
 =?utf-8?B?RlJoejM2YklqNGd3YjVRZDFOV053bEFTOWYzZWwvcitEZmNXSEFQM1ZWbTlZ?=
 =?utf-8?B?Y2hnNzJOOTVvcHVKWHc0WWlRNDc5V3JMWndGUkVEUmxKQnFnRE9vbGZZOTR0?=
 =?utf-8?B?UFlIdDBIWFI0cW5QVjVZM0Jyd2VkQkNaeElndFI3WTNyZ0hrL1VmWUNKc0U3?=
 =?utf-8?B?NjhYdjB6MlhVaVh0aGR1NHdZRlBkekpxM1E0ZjJtbks0Y09jSTE5em5ZWnZs?=
 =?utf-8?B?R2V5YkxHNEhwMU4yeFpWNUFILytheEFwWlhkbjYwQW4ycVNHektlZWh5U0Vv?=
 =?utf-8?B?cjZmVjZqWDVFL1JENVJGdEFKbUZ0NFFsU0Q0MGYybnYyYTRscTNQb2pHUFBO?=
 =?utf-8?B?RnpYYm9zbUtDWUZwM0VQY3YzR0cyRmJpMkR6b3dGb1ZOdXlhWVpkWmNMWk1y?=
 =?utf-8?B?V3c0WmM5dHRLUVdyUCtaS2VDUTFzZ2F3MktJT2hnbUhNQ1VGYXdqTkZodnR2?=
 =?utf-8?B?djd4NjFaSnBUSG5LcTJsRDlJbXQxM01jTmxtTDJmMmJaQldNTHd5bXN3Y204?=
 =?utf-8?B?Qy9YQVBGTUNIOG1GbFk3Zm84QzlhMkxMY1BtdkQvbk9WWGt1ZzMrdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3219daa-a86d-4689-553c-08de63d02c04
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 09:31:27.8744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j65Hilk1TsomhoLDfBKYyy7qecVjETHN86n6M6Z95fsqUygKunrQZ7JHifWuO6GZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058
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



On 04-Feb-26 1:55 PM, Asad Kamal wrote:
> Remove redundant and incorrect multi-vf check for pp clock setting,
> as the code path will never be taken. Mask check take care of same.
> 
> v2: Update patch title, Remove the check (Kevin)
> 
> Fixes: 166a3c735c95 ("drm/amd/pm: centralize all pp_dpm_xxx attribute nodes update cb")
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

You may drop any redundant multivf check in other attr_update calls also.

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 07641c9413d2..81bef5c5aae9 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2057,12 +2057,6 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
>   		break;
>   	}
>   
> -	/* setting should not be allowed from VF if not in one VF mode */
> -	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_is_pp_one_vf(adev)) {
> -		dev_attr->attr.mode &= ~S_IWUGO;
> -		dev_attr->store = NULL;
> -	}
> -
>   	return 0;
>   }
>   

