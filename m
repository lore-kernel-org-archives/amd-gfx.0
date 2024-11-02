Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20907E6F09C
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Nov 2024 00:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A24E410E0BF;
	Sat,  2 Nov 2024 00:43:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GW3AMmoL";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE37F10E0BF
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Nov 2024 00:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ome1aM0jEj/LOHw0Xy4zU2k88IeEf/BjyMabizEfRPPc/TmxjSEimyt8u55jaz015jGkFkUwK24pybg5NqseVgSFGbBNDtPv4g3MAdYpxJDh8+9WH65Ju1rMmCxrd8yLv74LJ7rAViBNjwdVje4FBtFAgl4q5Mi6UKhC+uSZ/0++UKLGP0AIKGHVocC5BqmJr+yCs15Pkl/k2b+avTuo6vLaltYcrnuW8yAFuzUq2wDIPT/gW3BMGlajZhrDVG37/+tRgvhLzX0c7vhH4RpM4JXEnPo2GlCO5WgKfMjfEUpI2vQGEuF2+lDC4oWm0jKdq6aURgZvhH/A0q+I0xuTUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FN/2/dtzqAtDoGfcXH4kERELoVFy89lUN3isr3NVNN0=;
 b=FK2LHhsys+bWQH2NvcXRMhPOT5JDaYdkSvRc0u+17NE7ig6rVRSYAWokVQqzr+QykolZbrO7+MDGeMbV7kVbbV5+A9XcStbQqfiFJKKnod7KzBVcJflIgamORQjjANkDyYJa9ndCh9JKFKGRCiIdxN6phmMRm+QltZ+Pvrs8uVyoUB3+1Spw1onQC6Xa4ydBC+zi5lx2rNdadi4bajYNvhJoHxogsccWvZRYjujB9+tA9eBHwgjANHlbb2LRfL+W06+fXv6VuxJiQ9BXLbYbsJo76nOz1DEvUFiM9aJbYhAwtFNgclSa4ZS+E0YZRI+KNqa7cFZicA0uuE/TMMorMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FN/2/dtzqAtDoGfcXH4kERELoVFy89lUN3isr3NVNN0=;
 b=GW3AMmoLDkbLkZ3uz6JbsZAJgOMTPDaR4tMJYkmOy7dLdrY0M/c5JB6A+JZR2K+Ee59lOe0rSY7Thw6gK3SzpqMIPopNEuViRThuTuMXC7XWbBVA9dGgkMEApM537SMQt2cZ2tS2ap31OVubI7CzsrgABYUwBinKQW0ZJ38OBYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Sat, 2 Nov
 2024 00:43:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.015; Sat, 2 Nov 2024
 00:43:42 +0000
Message-ID: <e99d304f-4c39-4fcd-99e3-2aba0c9d5e56@amd.com>
Date: Fri, 1 Nov 2024 19:43:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] drm/amd/display: Fix brightness level not retained
 over reboot
To: "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>,
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
 "mark.herbert42@gmail.com" <mark.herbert42@gmail.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
 <20241101134940.1426653-8-zaeem.mohamed@amd.com>
 <4b624213-1187-4c1e-a37f-644cf3ca1703@amd.com>
 <CY8PR12MB728973E40876CF83D6164DA2E2562@CY8PR12MB7289.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CY8PR12MB728973E40876CF83D6164DA2E2562@CY8PR12MB7289.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e2ecdf-1345-4e2a-d0c0-08dcfad76678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dE5CendHYU5PckF5bnRSRXF5ZUZXL0dzSG42WlUxMW01ZituUVhCUTZZbXFy?=
 =?utf-8?B?VTBSQTRjZk9hTER4eGtQNTFPT1ZlT2ZTeFEwaytzNmlaMEs4d1dNRWNFN2VZ?=
 =?utf-8?B?eUxqeFhGVjZqOUcwcEFwYXJGb2VpeitVVmFWd28xdk1UdFhYbjMzbE1TMm9r?=
 =?utf-8?B?QUowQmZzdExHTTBmL280RGdWZjFuZmphVzRZNjRpR1dXVXVaM2hYVVpoLzJD?=
 =?utf-8?B?UXhsN1ZSY1VMVjdySlJtMjhVbzJieXJ4Q0lDMUdpNkNKREgwelJYQk9HRFBx?=
 =?utf-8?B?QmxnVzhlYTZseFEwV21WYk9XSmlkNFV2Q2tXS3YrajBocmJMbi8vdDV5NU9K?=
 =?utf-8?B?aDJBTmdKZUdkM1ZyQ1B4eG45bkRKQkxwTUZNU2lWVkxqdUdnYjVIb3UwVDlm?=
 =?utf-8?B?bG44R0kvYitDSG10TjdNenFrQ3FvQ0ZzMjdBQnIxZFg3aklEWVZBSFkvaUhB?=
 =?utf-8?B?SE0zUkVMejdTOGNkYU5abHVLVDgvSHc5emFuVG5ld3pxdjBxd3N0V0xRSmFZ?=
 =?utf-8?B?QmdxaG5NRC93Nm5oaVJUYlFqRCsrVE9UUm9JRmE0QzMrWnNNY2prczJINDND?=
 =?utf-8?B?eS8wczg1SW40TU5wOEF6MVoycFkyWnZKMlA2MHRRaFFocnN2Z2xlSGRVNUgv?=
 =?utf-8?B?TWlZT0k0WC9jMmJSL2pMYUJ5MVVNTmorUlI4WU4wUDVialFaZXFqU3YxWGRy?=
 =?utf-8?B?ZTBiRXdzeXRmTisreWFNN3dIYWphTlpaUHFPMzFYN3F2RWVpU0NhTjNHNnpx?=
 =?utf-8?B?K0VCV0U5OEk3QVNBdThyZ0s3YTB6b3ZlT05nS1R5NjU3M2RwektrTEVRSEgw?=
 =?utf-8?B?UXJOMllDRUg2RFpFYzI5MEVUZktKK2ZWazRiUDUwakZlTHRMUFhMSVhlNkZS?=
 =?utf-8?B?QVlBWEVnRmd3V1VlcE5xS2pCd1NOcmluajdiWUlCazFjb09qczdOeEpUNndR?=
 =?utf-8?B?SExXdjNRbE1USXpCQklKUDVIOTZUczJ5Qi9DSjNOMXk0RTlpUEJJL0hNU3Jz?=
 =?utf-8?B?QmdjYUlZck9qamcrR0hPeE9nMm5CMG4rNEN1b3J1YXFibEZMV0hWMFpNK3dl?=
 =?utf-8?B?QW52Vy9JUnVjRWxhdmxFaFdyOTdaK0FiZk9LMTcvOWtEc1prTEl4alhzM1Fx?=
 =?utf-8?B?NitOZDJlNFlVUnhhWllrYnpyUjdsRzVsTFk4b0hGVW9yeldZaUU5S3pIQ01p?=
 =?utf-8?B?eUZCT0Jya2FQckFvMjlGL2g3bmYzMVdQbTlncjV0bnhmcldoZTdIMVowZDY3?=
 =?utf-8?B?YXM4UHErRWpsUmxXRkFxSjVpRUh0OXlGZTdxQmx5cEI0STJtaC9lRm9wSXk2?=
 =?utf-8?B?VlF5TDBjT2RYbzZqVFhwSzMvbDZic2JjcHZRTmJZTjJCSllyaGluWDV5Zlli?=
 =?utf-8?B?R1JDcTdTMk14bHBpalBKS3BUR1RFU05GTDhwNkh2a3RkaUs2YzFVdVJtRFVB?=
 =?utf-8?B?NU9pRW9ySU01STJYQXpWZitCak4yQ0gzS0EvSTd5ZURrVzNmeXpKMTZncy9a?=
 =?utf-8?B?U1U0dzhmV0FkUnNpTFhIems2bzRLSEFSKzVYMzYvaURKOTN1VVFYeHFNcmdS?=
 =?utf-8?B?dXViRE5CbHhkT1pwS24vZGZnOGNvd25sVmdmOUVRdHJCT3ExNzhxcnRNS2Ns?=
 =?utf-8?B?WFZUNkdYUGRIMUdzRDRrblNRSDRBb3VibU9ockR5b2Q5bWI5dVU4KzZhRUJk?=
 =?utf-8?Q?lUCRMWejODXC+1tHEMvZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE5Tbkg1R0s2STN6b3F0aXlFcFB0d05GRm1teisway9aTDZRc1FLV2hSYWFK?=
 =?utf-8?B?bU5LNUZhK3czRzBtZVBscW5ndWJHT2hCZ0hrckNUekpXd1pzd0tCOFhJK0J5?=
 =?utf-8?B?SEdQcmNhbW5mRXVVS1RuYmdiZ0t4YStpREtvTWw4RC92MG5WNCtvN0I1NXBV?=
 =?utf-8?B?VHFEM1FHTGlBQW0xQ1R3NzBOaUJvek1HaUUyTnlpQmtvZXZEZzk4ZDlsMXhj?=
 =?utf-8?B?U0RrbDNSdkpPMm9SL0FNWlliN1kwYkIwOFd3bVNTYTlPNjVNc0I5UDRyVmhD?=
 =?utf-8?B?VjREelVLa1FNb2VVTkRPS1JUUlM1WnpUTVM4RlpiMzRYSjJtaFdSVmF6NFBt?=
 =?utf-8?B?VFBjSHd5ZWpxa0ZKZmRRMTVIVDdVdU9qOFVtUytXb0l2ck8vN25WSG95dkZv?=
 =?utf-8?B?NSt3VlY2TTN0TDlBazczSnZPcGJSNFN3MGl3aXZBb3RFa3NRSWVZd0p4b0h5?=
 =?utf-8?B?MituTVZMNkQ5RkJZcjJpS1hORlRWN21tSmhsSDBYMVFUL2tmVkRheXFCSS9j?=
 =?utf-8?B?SXQvbTFpTVdZWmFYTTA1VmR0UzdPTUtLZVl2ZnJPU0tlZmhwTlY3dFZyRERE?=
 =?utf-8?B?eVRSZ2ZnRldEM3JSVGRrN2dsVW1HT2ZGVVVQVXhPUUdRakxaVm0vc09zUE9M?=
 =?utf-8?B?RklLdHJhWVg1M2szdjRiTGxLcFJ0cy85ZGd3RGtOaWc3bUJjbytMR3FmKzZ5?=
 =?utf-8?B?VGJzUXFwVWwveUxFZzJVUGsyWnBWWmlFaWU3eGR6VmVEaFJzRmFqNDU2WTlN?=
 =?utf-8?B?UzJGRUxJMTFPdmNzTk5PWFBSbkZiVU5LRDlRS3c3Y0hERU5LNUtlV1VnMGlM?=
 =?utf-8?B?T2loSUh6NnJYR2duZzlqeUhMS29ndy82Z3pBcURSZkFhVU94YlJvVHJOK3p2?=
 =?utf-8?B?cllTanF5alZlNHBKM2pGcGI1VTFRejdtU2lJU2tpdmsvUU5oV3J4SW5Xd1c3?=
 =?utf-8?B?SVFndU50UTZrejZRZWowQmd0TTJNMDdHb2tFQlFkeEJobDJ6RFdrbEkySmxL?=
 =?utf-8?B?TTkvY2t3QXA2WGpiSWRDZzdZdnphV1BaUlRiTi81TDFlaHkwbUx2YWRSbEVG?=
 =?utf-8?B?YVZvcjNTeVBCT1pQVzMyVHM4c1V1VC8vMG1NWFdvL3l6V1FVZmNGZ2xsTmha?=
 =?utf-8?B?eWorZW9ib0FEZFF3YW53WHBaRU5jRHlGQ3c3VUNwQlVKd1lvMEFXbFVOTFB5?=
 =?utf-8?B?SyttS2ltVE5BaEszdHZvb0U0NDdQcENDVzJScUIvTGRhbnFLZ0RCWC9maTJI?=
 =?utf-8?B?elN0WXVuR3ZOaEoySmFna1Y1RU40UWkveks3OGxMQnF2ZGZLQzAwVE02b0pj?=
 =?utf-8?B?ZklicEhQenpkZEl4Rm5VcmhVK3dMSnVyMGdxa25KeER1cWdXajJxU01yV20w?=
 =?utf-8?B?Z2VNRUlqenU3Sk10QVV2T1F5eFozQ2lLMnZuWHBDSGlnZnF4NVpnN2N4Ujk0?=
 =?utf-8?B?YnY2Sk1HUXRGRHNodzhob2c0eW9YVjRPYU9ZWHJ6RVF5aEp5QjJKV1JuSFRT?=
 =?utf-8?B?M2hHbkIyai9keVJJYW40ZzhSaUFScjV3Ti9XTVB0Q2Y3cG1RdWhDbkdPamF1?=
 =?utf-8?B?dkMwZkJ5WjRRQ1c3S2p1V1ZsRXg3aDBrVFlsSE5LRDI5aExvNUlmSTRua2Rz?=
 =?utf-8?B?bEJQS1ZhSEVCYnp0R3F6Ri8zeStOUWoxdlJRUGRMSzk3YUw4UDdVbldBYXFL?=
 =?utf-8?B?b24xS3NpRm9yaDRoTE1hWkZOZ1l4SkE1ek1SSFBqMldBdnE2cWZpY1E1T1RV?=
 =?utf-8?B?Ymx1UDVxUjdiUjloOFJuR25KMWZWNHZQSUJCN2dFdExPQ2Y2K2hQNTdTejBh?=
 =?utf-8?B?OEZkd2x0Sm9oREhjcENXMDdtNm13UHkzZDc5SDkzcC8rY1FpTHUrclFMbnRy?=
 =?utf-8?B?NlhKUUQzWUNRRngxRzZvMUFhSUF4VnkyQytmVG1ialN6UUpCdkx6SU5TQjJL?=
 =?utf-8?B?OVZ1VmhZanl2MzI2c0ZINDB5eWtRbjRtNmVhZjFVcWt2YzhsWkx6Rm81NUF4?=
 =?utf-8?B?eDlCN0RPRWpicG1NNjVWNjJBZHZhYmFtLzhBTk9BWHcxV3hwVnpYbUpORVhY?=
 =?utf-8?B?Q0VheExPRmFocGg2djFCT0xSbkpLU2c0NzV6RU4vSlovUCthVEU2VFE1eXA3?=
 =?utf-8?Q?2Eft4RM2BliWYMNAZTT+Cb0IE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e2ecdf-1345-4e2a-d0c0-08dcfad76678
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2024 00:43:42.5643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhbYMYQa7dle0UMfqjw8HDdUhbfWqKwoniOZsGpZNI0TYBIayrwDao08qI8q2qrWLpw5F9Rep4WVciLSQ2JDUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
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

On 11/1/2024 14:48, Mohamed, Zaeem wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Mario,
> 
> Do I need to re-send the patch to amd-gfx after the tags have been added or is sending upstream enough?
> 
> Zaeem

Zaeem,

No need to resend to amd-gfx, they can be added when they're committed.

If you use "b4" [1] to apply them it will automatically pick them up. 
If they're applied manually then the person applying them can manually 
apply the tags too.

[1] https://b4.docs.kernel.org/en/latest/
> 
> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Friday, November 1, 2024 11:43 AM
> To: Mohamed, Zaeem <Zaeem.Mohamed@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; mark.herbert42@gmail.com
> Subject: Re: [PATCH 07/17] drm/amd/display: Fix brightness level not retained over reboot
> 
> On 11/1/2024 08:49, Zaeem Mohamed wrote:
>> From: Tom Chung <chiahsuan.chung@amd.com>
>>
>> [Why]
>> During boot up and resume the DC layer will reset the panel brightness
>> to fix a flicker issue.
>>
>> It will cause the dm->actual_brightness is not the current panel
>> brightness level. (the dm->brightness is the correct panel level)
>>
>> [How]
>> Set the backlight level after do the set mode.
>>
>> Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
>> Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
>> Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
> 
> Some more tags, please explicitly add these while merging.
> 
> Cc: stable@vger.kernel.org
> Fixes: d9e865826c20 ("drm/amd/display: Simplify brightness initialization")
> Reported-by: Mark Herbert <mark.herbert42@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3655
> 
>> ---
>>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++++++++++++++
>>    1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index bbfc47f6595f..2599a99509de 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -9411,6 +9411,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>>        bool mode_set_reset_required = false;
>>        u32 i;
>>        struct dc_commit_streams_params params = {dc_state->streams,
>> dc_state->stream_count};
>> +     bool set_backlight_level = false;
>>
>>        /* Disable writeback */
>>        for_each_old_connector_in_state(state, connector, old_con_state, i)
>> { @@ -9530,6 +9531,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>>                        acrtc->hw_mode = new_crtc_state->mode;
>>                        crtc->hwmode = new_crtc_state->mode;
>>                        mode_set_reset_required = true;
>> +                     set_backlight_level = true;
>>                } else if (modereset_required(new_crtc_state)) {
>>                        drm_dbg_atomic(dev,
>>                                       "Atomic commit: RESET. crtc id %d:[%p]\n", @@ -9581,6
>> +9583,19 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>>                                acrtc->otg_inst = status->primary_otg_inst;
>>                }
>>        }
>> +
>> +     /* During boot up and resume the DC layer will reset the panel brightness
>> +      * to fix a flicker issue.
>> +      * It will cause the dm->actual_brightness is not the current panel brightness
>> +      * level. (the dm->brightness is the correct panel level)
>> +      * So we set the backlight level with dm->brightness value after set mode
>> +      */
>> +     if (set_backlight_level) {
>> +             for (i = 0; i < dm->num_of_edps; i++) {
>> +                     if (dm->backlight_dev[i])
>> +                             amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
>> +             }
>> +     }
>>    }
>>
>>    static void dm_set_writeback(struct amdgpu_display_manager *dm,
> 

