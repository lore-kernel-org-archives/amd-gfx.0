Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F259C83F26
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 16:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBF1110E21B;
	Wed, 30 Jul 2025 16:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EKJeRfg5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A29D10E21B
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 16:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uK9dybqraba5H1IzLgi1KIXbXUIZKvQZzyQcAvXucV0bn7jjvBkJpqQSIWvPilNdTUpRTmRZj5MRThr3PyEwlZGkH3RTilYu9TIjaLtfq7N10uOonJQ2Ku26isti/lQh/HAGiWK3w5Qal+MeWCOr11zV25rRtt7F0mZnpqyBPNE5qdtUACS0PH6zuwJgYFCemg1fsonDzPt2/SFArtqTYfC896WvxBLzyb1EJZkd3x+1Ic6LyZxtEH1JNvd/etqmEQ54xkTlgtu29tfl2KlPs0vX0J1XDskCuQ0EWkQ2MzB2uG3hZvlSxOWBOyUrgPVbecZrXzx6pXvhuz+yuAHwqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sY6NE/1/h5Fpt5DSFErSr9nFATPLjI+EXu+T8GMgeY=;
 b=ZlCTBlfmvKTjVScx8x8mkBhk+WF6wy5WlxuOWTxlcm0NhUwgGetmaKQ+qg39/Z0A9K6N6TWux+isnHPh4Nm6pK00CEVXzGdsjoUNa+6FNNBivNyEzAdr+7Q3DA8xzAE9JqnaOTRfoSRf7SGrcuT+8lBEZoJbpnFqMTp+Y9onv0PMH1wARTUjH4tTSy1C6CW5bP4rjFERdXDO3OK93NioIpkhJoObW72jsL6HcWjMUWmCkTsaJePIDg1A73axXAJmCXN1+44gIipNHW/iQIRynnXe+NFpoGkHkL8+OINNBSJBXn/eszMVtUzvttbTatSVhOjYNHpf0SmOpP7e0oa6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sY6NE/1/h5Fpt5DSFErSr9nFATPLjI+EXu+T8GMgeY=;
 b=EKJeRfg5ZqdpFnocT9XxTpCkWo6K2Gx9K43LGKjRkqvHMRLPVKBmRtl8F6l4ru1Xsw0/cQDEHnmJkkvYZv+wdAbHpwm6pFSJKR5qAsN+HiBjV3b2z95cr127m9cCv2zrfOAjlkvTFQI86I8wJu9MOzbEDdhSbmaYuqhrmFRuBvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 16:29:28 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 16:29:28 +0000
Message-ID: <96c3a9c5-f9e7-4b32-8a42-b931b9b96e85@amd.com>
Date: Wed, 30 Jul 2025 12:29:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] Analog connector support in DC
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250723155813.9101-1-timur.kristof@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250723155813.9101-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::8) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CH3PR12MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: e63fe699-a420-4afa-94c4-08ddcf8640d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3hDdDJhMGk1NVFvdXVVTUJmVllWaWJMUVVKVlk5R01pNjRDY0NrOVYzZER4?=
 =?utf-8?B?cWZ2QStVeG5TRGxSaS9aOTJwTTNNS0cwQUtRcVZUSytkVWpQYjdTc3paZVlD?=
 =?utf-8?B?R3Q0YnQ1dGQ3SUZRVE1xUm1XUlJuOWN6NVlyZUhNNkNDQ3A5Z2FVcDVFaU9n?=
 =?utf-8?B?Z1h2WGtJdDBOejFYM3NoUDZhaEV0U2NYd3F6WmRUUnlCM3lDMlRxdEQrUXc5?=
 =?utf-8?B?ak1NWGRBYklQVHhKZjFqUlMxbGlieVRwdTBiRG9LTEY2VVZzREZTcHpuaDdN?=
 =?utf-8?B?eThFTTNyMWN2bW1EbUJMMG9lQVlrVnpZeWhvY0xFYVltYjc1ZVArZ2tuUXJM?=
 =?utf-8?B?MUEwTnhRV3p5WGlFZXpXbDNLWm9Kc2JqUmtXQjJVTGl4b0swaUttU0h5dS9U?=
 =?utf-8?B?MnhWOHpIbDVVTldMdkk4Tm9UQ0U1YnJpakF3T1lpbzl1Q2RHYVhUb1FhSmhV?=
 =?utf-8?B?bU4zYXhybVBiVmZ3TEgrMTBRT0hyaFhXZitzQjFBYmpzNXNjZGlvcGdjWFpp?=
 =?utf-8?B?SnBpSDVJN29udkFjYUVWckl1eTZlMjFvd3BQWTROZzlNR2c3OG1GZWMvaFZW?=
 =?utf-8?B?T084cTdqQm0vRnY0Ry9qeEZmOWJMc0xYazFTeEN1dkNZaFZUVUZET3RxMGN5?=
 =?utf-8?B?dHQyNFd2ckJmam1QYWVmV0hjUmNSdjFtOTIyVzE1bDdPb0NITld6TGR1TCtv?=
 =?utf-8?B?VmYzSlNRYnBxVXJwSEo4VEJLZU13VUJKZTlqajVaQzNxdHJzWmF3aHF5cGZt?=
 =?utf-8?B?NE8zenZXdm4wZnFMSVNHNDFXakc5V2FHY1cvMFIyYkpuUFpNQTFNMzM3Yi95?=
 =?utf-8?B?K3YwM3JBVUhlQmdVQ3VoOE1GKzV4YTNoQittSkJncHRpWjdWaVBidlYwTi8v?=
 =?utf-8?B?eWNKMER1d2RadFhrbDRqb0wxeFBMUUtNUEtGN2VlcUhGZ2VkZ1oyZGVkU1RD?=
 =?utf-8?B?c2RnNktKZ3FKaVlEZlR2aGFWcndMenkwdUpZMlkzVE5ITk5vMy9ZbnNiNys1?=
 =?utf-8?B?OTJtTTBub1g3SWVwME9XU3J1MVVOeS9zTVcyUmdmZ2VCYXFXb3lQZkcrRHo5?=
 =?utf-8?B?WnhuejhvSXFtTmxnd3hxajJBTW1BZ2dXZm1yKzRKY0xhbmxMOW44Q1VmSHgx?=
 =?utf-8?B?MVNySk96c0hTWi81VCtweU51dXRRTkhtRUNJU2VkcFhRWGlGOXV3Yk51NHFT?=
 =?utf-8?B?TVFkTlJBeUlTUVBFbUt4dmhqaHFDejdSekRHS1lnaHlVUmxnNytIbzdtQUlD?=
 =?utf-8?B?ZEQ5TEdWV2l3bEFYZ1ZNSXplZGYyTTZvZHpJQWI4ajRlZWR0NGZ1cGZ6QWxM?=
 =?utf-8?B?blEyQkdqWTFEK0xpSGZZdlluVTJMU2Fzc3pqdWRjUGVYQ1gzMUJLL3RUdEdJ?=
 =?utf-8?B?SDVXT1VXa05Xa3BRcFpZNjVPNmZnUEZ0OWFZcDY4d3dwTUU5TG9CQjduK2FL?=
 =?utf-8?B?UEEzbk5tNjdQN2RoM3BVZnl1RkZRZHJDOW5ydE5ZUDJiMEJhbjY2Q2VjVWZT?=
 =?utf-8?B?TUtuN2xtTzR3bG1keWpqTy9nT3J4Tmt2OFQ0ZFpndlVXT1E1OFl5SkxlSVJH?=
 =?utf-8?B?R3lLVUJkT2sxN3RsL3FxV0lydGp0OGVoTTZVMGFORHJOSFAwRmQvaUFvTFpW?=
 =?utf-8?B?ejNHWGdaa3pRUkxtUjJlb3Q4eHpRaG5rSnR3OUEwbnVxc0doaE5HUHRoTEpj?=
 =?utf-8?B?N2ZjRzFReW0ya1JoKzUrd25HTVV0cTZqVU1sTGgzTFNGRURSVWZKRVNVSDhN?=
 =?utf-8?B?d1hxeC9VM3lJaFFFVC9pK241amtnY3VwUnZlYjRyTWR1QXNrd1hUc3liTDQ4?=
 =?utf-8?B?ZCt5K0x3K0k1akdkczRyMWRGUUtOdTZmU3JKZlNBNnFtTG1iZEFkNHJ4Vlgr?=
 =?utf-8?B?eTR3WUdSQUNJaFRNdjZkMGExL2JIT1pUVmVDRURnVm5MMW0yUzBkVVNYSFBq?=
 =?utf-8?Q?yGC/sYJ9MxE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUtEMVZ1WHpXTGtaTjJyTk91U2JtQjg2SHBqaDRXSnVRQ20yMHBMSnlNNG1G?=
 =?utf-8?B?d1RreWgzTGZxQWNwYVFDQnM4YUIwdi8xQWpYRDlmbXVmbDVrMWNydEt6cUpD?=
 =?utf-8?B?QzZkMkplLzJ0bXU1RjRSNSszb2pjb25jZ0RNTnlCYkl0NUlCTmxDc0hnVXBy?=
 =?utf-8?B?NTRNYXQzOW5EODVnbWVwenNIUUZiRkhIb1preXhRR25nVnRoaHpLdHZLdG5M?=
 =?utf-8?B?aTI4T2pQRXM4YUpBbXkyYldLRXp1enAxVThsT2xyU1FLMWdoMUdDNGQxZFhQ?=
 =?utf-8?B?elZWMjVVSVJkZkF0UDFLMUNrUGJEMHdadDRjU1A2RXpaVnBtejk4azhMQ0lD?=
 =?utf-8?B?amlLdSsycjdESHBLamtscGtaeG8rQ1ZtMkQrQk5vanhydXNOdkErTmNTa2tB?=
 =?utf-8?B?dHlOcGUwNXlUckFxV0pKUUhaY3IwVDdhZWQrRUdpTVUyVjJYc2k3Vk9sOFFD?=
 =?utf-8?B?S3VuQVZWTkNtdWNEOGp4NlBOVko3OGsvcFh5STBIdzFScUorLzVTZzF6dXp4?=
 =?utf-8?B?eDZUVHVhRFJycGtMQ2pscGVJdExWQWFkS3phYTIrS0hEckI0aHJQQmRlQjR2?=
 =?utf-8?B?dzQ1ME0rMGlWejdIOVhidDYrcVl1MTlnakwvYVA3bkdEbWVsZjZucVo4RE5W?=
 =?utf-8?B?a2lPVHlaYndqd2JrT1N0WVpPekRqVktZQ1JCV2ZMYkE0ZUcvYzFTL2d3dFpa?=
 =?utf-8?B?RWZxMno5N3NtcEZySmxndnQ2dHNFaTJLZ01Sa2Jaby82aXh3bFAwT0dPUlph?=
 =?utf-8?B?eDlSUFVUc29qNjlkVDJGMzJ0Ni9kRUc5Rld1djBJN3U0a2ZPdU9ud25yc0RR?=
 =?utf-8?B?UlpBeWZXQTRJOU5nZVF5UmtqeVBjTG9CZExoL01EWDd0VmgvaFZwOVpHdGZh?=
 =?utf-8?B?Zy96V3ZpRm1sK2pNS1hLQkNQd0VNUUZrK0k3VERyMWQrTzBpL3NrNklBdnhF?=
 =?utf-8?B?bGxBSFNaMy9FMzM1Tm9RTUlWeTFpM0JROWZJMkw3YnZiT3JBNzNGY2NzTWJF?=
 =?utf-8?B?VlhWMFg3djNlZW42MnBQOWQ1S2RSNjdEYVBnalFvN0p0YTBqbEVPa0p4UFk3?=
 =?utf-8?B?cmtyTE1SZmhUdzJYWitYMVI1bUdTWW9WM0N5aldyTVowbk04dHNmY2lLaWFu?=
 =?utf-8?B?MERWTmM4bGx5VWZIa0pMWDZSOG1jdzBmSjVVRE85RHg4WkJZM0VxUEVieDZ4?=
 =?utf-8?B?K0JXOXRwTHZzaXlQUnoya0NjZjUyaFJnMjdZYlBKK0tzYW5NTVk4OHoxS3lM?=
 =?utf-8?B?SkpQdDFvb2ZoVURUWktQNno0bEhUUFQwWUVhaVN0aUhONGtnK05JdExWQWts?=
 =?utf-8?B?eEF2VG9Gam55M0VMSm1tMzNMdG9lZGd3RE01Vnk3REM1c1BiczJlNjNPTS9V?=
 =?utf-8?B?ejFSWHArbHhKbW9GOGNEM25OdGovUkhhbDhZR0F2VnJJVHJ3WUZFdjVJaVBH?=
 =?utf-8?B?N2thMlNNUUlGYTRHMDltOGZ3dVNTUGNCZno0SVltSWZmYVJHOWd0SjN0Sit1?=
 =?utf-8?B?a2xNTGhkZkdwZ3c0VHJGQmxZbGJtVWYyMUJHc1hwY2tOc2NZRzYxQkNSZlcz?=
 =?utf-8?B?SVd0dmpiL21oZVhhUXFVMmo0YUdRTG9TMWN2Z3l2djZjbElsY3U5RlF6TlJB?=
 =?utf-8?B?OHFKbVJIdS9aa1duYnRCNmIySzYyWWwrRGN4NmVyQ0RNbDdQcEE4bmllVmor?=
 =?utf-8?B?cDQ5QWJkc0FpdnFxTkFUd1crUXBxLzdwNE9zMWVXcWdiUVVQS2V5bWdQeXpJ?=
 =?utf-8?B?d2MwbkdSQ1lUU0l2T1JzVmgxajMrazNnd2JXcTFsQUlnUE5yZHVoT3ZaMUVo?=
 =?utf-8?B?TjAxUlIrV1RlR0QzRnJlSzZXTExlV3F3eURhM1I1M2gzcTRkRU1XWHB2YWZy?=
 =?utf-8?B?VHlVdWtZOGJYaHdYdlVqUkk2d2lpaGc3WmdISlBZb292RXZsaEt1VHlyUXpz?=
 =?utf-8?B?ZVlGMEtaTHRSbFVCTjludzRBaWY2U09pZm5ldEt6aEdMSGN6VmlIUnFsT1pq?=
 =?utf-8?B?WE1HbVpnSWZXSmQvUFFZYjhmOS9MQllWa3phMDlwWE5pbmM0OFRyOXl0NWhk?=
 =?utf-8?B?YmdKNjdIaG94NUt2RUpJZmVTNFZFa1FRR1FjNWRycEl0dmlGaGJaNDdhWGFB?=
 =?utf-8?Q?hhyIQQKMo+0UM1iiLrQJrtigi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63fe699-a420-4afa-94c4-08ddcf8640d5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 16:29:27.8994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+sNDaVc7bA+p7EAvwSXzjiggn84YIjz8NBLcynut7eYBqlraeMx1xEQAEPnttQp0TLsXJ3+BfYMepYlkyCCZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879
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



On 2025-07-23 11:57, Timur Kristóf wrote:
> This series adds support for analog connectors to DC for DCE6-10.
> There are two reasons to add this support:
> 
> 1. GPUs that already use DC by default and have analog connectors.
> Some Tonga and Hawaii graphics cards in fact have DVI-I connectors,
> and the analog part doesn't work by default. This functionality
> regressed when switching from the amdgpu legacy display code to DC.
> 
> 2. GPUs that don't use amdgpu by default yet.
> Currently, SI (GFX6) and CIK (GFX7) don't use amdgpu by default
> yet, and missing analog connector support is cited as one of the
> main reasons why not.
> 
> With this analog support added to DC, we could already fully switch
> CIK discrete GPUs to use DC and switch them to the amdgpu driver.
> For GFX7 APUs and SI, further fixes are needed before enabling DC.
> 
> Before starting this work, I asked Harry and Alex about how best
> to do it and we agreed that we'd like to use the VBIOS to set up
> the DAC. So I used the amdgpu legacy display code as a reference.
> The first few commits add some minor changes to DC to prepare for
> supporting analog stream and link encoders, then analog link
> detection is added along with polling, and finally DAC load
> detection support, which is useful for old displays and adapters.
> 

The series looks good to me.

Patches 2-20 are
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Patch 1 is probably good, just waiting for feedback on my comments.

Though I would like to send this through our weekly testing cycle
before we merge to ensure it doesn't regress DCN in some non-obvious
ways.

Harry

> Please let me know what you think.
> 
> Timur Kristóf (20):
>   drm/amd/display: Determine DRM connector type more accurately
>   drm/amd/display: Add analog bit to edid_caps
>   drm/amd/display: Introduce MAX_LINK_ENCODERS
>   drm/amd/display: Hook up DAC to bios_parser_encoder_control
>   drm/amd/display: Add SelectCRTC_Source to BIOS parser
>   drm/amd/display: Get maximum pixel clock from VBIOS
>   drm/amd/display: Don't use stereo sync and audio on RGB signals
>   drm/amd/display: Don't try to enable/disable HPD when unavailable
>   drm/amd/display: Add concept of analog encoders
>   drm/amd/display: Implement DCE analog stream encoders
>   drm/amd/display: Implement DCE analog link encoders
>   drm/amd/display: Support DAC in dce110_hwseq
>   drm/amd/display: Add analog link detection
>   drm/amd/display: Poll analog connectors
>   drm/amd/display: Add DCE BIOS_SCRATCH_0 register
>   drm/amd/display: Make get_support_mask_for_device_id reusable
>   drm/amd/display: Add DAC_LoadDetection to BIOS parser
>   drm/amd/display: Use DAC load detection on analog connectors
>   drm/amd/display: Add common modes to analog displays without EDID
>   drm/amdgpu: Use DC by default for Bonaire
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   1 -
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 144 +++++++--
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   5 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   1 +
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   8 +
>  .../gpu/drm/amd/display/dc/bios/bios_parser.c |  95 +++++-
>  .../drm/amd/display/dc/bios/command_table.c   | 286 ++++++++++++++++++
>  .../drm/amd/display/dc/bios/command_table.h   |   6 +
>  .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   4 +-
>  .../gpu/drm/amd/display/dc/core/dc_resource.c |   8 +
>  .../gpu/drm/amd/display/dc/dc_bios_types.h    |   9 +
>  drivers/gpu/drm/amd/display/dc/dc_types.h     |   5 +
>  .../drm/amd/display/dc/dce/dce_link_encoder.c | 100 ++++++
>  .../drm/amd/display/dc/dce/dce_link_encoder.h |  21 +-
>  .../amd/display/dc/dce/dce_stream_encoder.c   |  14 +
>  .../amd/display/dc/dce/dce_stream_encoder.h   |   5 +
>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  75 ++++-
>  .../gpu/drm/amd/display/dc/inc/core_types.h   |   8 +-
>  .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  24 ++
>  .../drm/amd/display/dc/inc/hw/link_encoder.h  |   2 +
>  drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
>  .../amd/display/dc/link/hwss/link_hwss_dio.c  |  19 +-
>  .../drm/amd/display/dc/link/link_detection.c  | 123 +++++++-
>  .../gpu/drm/amd/display/dc/link/link_dpms.c   |   9 +-
>  .../drm/amd/display/dc/link/link_factory.c    |  31 ++
>  .../dc/resource/dce100/dce100_resource.c      |  28 +-
>  .../dc/resource/dce110/dce110_resource.c      |   2 +
>  .../dc/resource/dce112/dce112_resource.c      |   2 +
>  .../dc/resource/dce120/dce120_resource.c      |   1 +
>  .../dc/resource/dce60/dce60_resource.c        |  26 +-
>  .../dc/resource/dce80/dce80_resource.c        |  23 +-
>  .../amd/display/include/bios_parser_types.h   |  11 +-
>  .../display/include/grph_object_ctrl_defs.h   |   1 +
>  .../drm/amd/display/include/signal_types.h    |   5 +
>  34 files changed, 1027 insertions(+), 76 deletions(-)
> 

