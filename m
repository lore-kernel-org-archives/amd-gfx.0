Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9176CD597C8
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 03:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD6A10E333;
	Wed, 13 Nov 2024 03:10:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q6nOvMrt";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F0510E333
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 03:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F69Ja4bPTLCcbG8XoHtpMqsQ0siE70hfzxhU6UwyEdvvtgHBcrAqUf7WGYKGVTB4wRQDLKqx+lDpe4/hLRqb/k7aeCtm1ev/kemKSGi1jYdrjD95hyAWGOA1xYePFJ3QpDnrGI0U1bpx76bc2dnwCkyP2YerIQV9CANSBrU2MAt90T+0FVNi6AjcgHrL9Epfgb6dSh/xa7fHRNxIC7r6VeZ3/by7NTD5vLzNEG54NQZcWE8uvmOHwuXv8jNwACf8r46ezxk+kztw5ctlzMVW+EnnlxpcJE2ZTJZOO01pEBppCS+9ZCYyRyw45/vqbi8/nAcpE+KO1D0gqSEyZ1uLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5b+5eBQ5ywfedGDQwSEczOI1GKIlqA2+BVF9lE+jhgU=;
 b=hmESNZevkcfKbe20lA+pMicZaRKB1Sh1GQw5IOmDD86a7skNdV1/BB6Vte/P8iDMym8QdvodAb7EvdCEtL4UxQcNfnZkDEqFn+efDBTgRHo57YEEQDEwA2xPNaAGo+mXKFBeEGLQdZr0Ma2m5FAGSibinON5ue9IUmc0QRE94dk3pUlm+9QgKYMjxcUR1XOlx+FXGHZNb2eVy1GWJ6DtLB8R5jujPGgk3JMB6NtbZxZ0rk8lhRXiRGR+ursg/hbunF426clA866ON9s7tgFsf0698FtGPyweSXeOWvb6coXPXxa+tcGykcPHLHtOa6TFLCq+ybLQ/eUkaZwNm6hFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5b+5eBQ5ywfedGDQwSEczOI1GKIlqA2+BVF9lE+jhgU=;
 b=Q6nOvMrtvBLwor8UjNkAoOPQcLhXiYiVulzCYFDX+lc7VOB1HbnxfC3gczrRCop730jTR9ZgtPBcNn+faAC2hM8CH+q6GXCEWjUK7s/ZdhQO0S3oU4gxFHVbvm//wuQW4vz89tu2V+95INYn2caCXfvx80pY5niQhvjOUVhxc7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.29; Wed, 13 Nov 2024 03:10:25 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 03:10:25 +0000
Message-ID: <63fcdfc5-af2a-4065-ab5a-81ca5dca6db9@amd.com>
Date: Wed, 13 Nov 2024 08:40:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
References: <20241112143050.1931822-1-jesse.zhang@amd.com>
 <20241112143050.1931822-2-jesse.zhang@amd.com>
 <910caa3a-802a-41d6-ae07-c39292081d4d@amd.com>
 <DM4PR12MB51524E90E5A98A03BF7FDD8CE35A2@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB51524E90E5A98A03BF7FDD8CE35A2@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: 603f503d-0ae7-4861-a5e3-08dd0390b786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEgrdkJiVmFIV3ZmdFFmMHlzMldlYnBOdURjYURuMUpaNTJtdk5CcUJOUEhS?=
 =?utf-8?B?Y2NOK3ZTdzkxS2JtUVZPckR2Qy9SbW5kdC94Q3MvanRtS0JyZFNVSWRLQk1L?=
 =?utf-8?B?UXg4TkdscUhhM01xYXlWb1o5WWo5U2dSdHFKUGdxcXg2enNockhwMmNrNE91?=
 =?utf-8?B?d21sdW0wWHZQSzFNWVhFaGNZck8xUUROTm85L2ZYb3VVWFVEUG1ydTNXZFlF?=
 =?utf-8?B?NlA0dmh6Z3pWMkhtL0V6K2dqaVF2bExiVEc1cVJ1V2ROdTFIblh4cFY2T1g2?=
 =?utf-8?B?NHJxNXh0UjJMbW1PY2hCcDdHQ2hBUHVTa29wcEVwalBFZmhNTldlWHArOUNU?=
 =?utf-8?B?a0NaRkptU2Y1TWZwTXJRam94dHgrYlo3V21ueHh3QzVleWM3UGZjb1I2OVE0?=
 =?utf-8?B?UE9kWVFxVmhYM0I3cm9oU0Z6c1VNcG9zZjMxc0ZxZlRLQnIxU0oyNlo5aHBn?=
 =?utf-8?B?dXc5VUx1T0RhMFBtdldyZlNqTXd5RVB4elRCS2pucXVWUmNMbC82RVBOL0Ex?=
 =?utf-8?B?WTdXSjc1RXpGdi9UTHEvWHdERkF5V3ZCNGUyeEQ4QTRkNFNTcnFWbmZVL3A1?=
 =?utf-8?B?TGdXTGtnSXBOaVoxNjdBRm1TNEcvdjlaZVl5eVFYYmVjM1FtNzZqaGlHMkZ5?=
 =?utf-8?B?NWpwTkVZT2hkQmdGNG9OUm9hbkVqQ3QvTmthSXdJWE9uQUJuWEZXbVNWUUZ4?=
 =?utf-8?B?WVB4OUtlb3ljeUNKMmxWWWJYTnVJWDZNYWxxWDcrMlRUV1RFMkZHMU9HL1NF?=
 =?utf-8?B?MEh2YndBbEhLVjFUNnMxRVh3WU5wQlFib0ordXp4RFNoeGpKODBQOXVuRGxl?=
 =?utf-8?B?Z3lGY1ZVSzVSaUdxVVI2Q21QNXhCQU1mQkJRK0xmUzFidVI4Y0MvaFBPUC82?=
 =?utf-8?B?TUU0RGY3Wml1OFpnWHNHTDJTSE9vVzhva3RoNUltZ1kxZkRYWEJiNDI0V1FP?=
 =?utf-8?B?V3lWTzFDb2hjRGtyWWdMMlMzY25KeTREbEh2VndkYkdQQmpwVzRkWjA3MXpz?=
 =?utf-8?B?TVQzOWtJelhZSk9XdDkvWUdKbkRVSytjYXhUS1YyRWc0V2M1dExFYlNXUlRT?=
 =?utf-8?B?Y1J3RHNWbTB2RVA1YVd2NkZPQWlUc1ErbUhsbEFWZEZyZlZKN2Q2NVZLZ0dS?=
 =?utf-8?B?OGlabjhvY0grV3pocGdMREI1aXIvT3k1RC9NdlJHaU90VHk3V056cnh6TzBr?=
 =?utf-8?B?M1NnaTBjcHRteWZWN3FyRDNCSFl3QlNiWFpncXJOYTJFQ25OQXV6eUQzaGRs?=
 =?utf-8?B?a1dqQURPcWZnYkdDV20zaENrOTBIQlBRaTV0bkdndmF2azJJUVd2V1ZSK0pr?=
 =?utf-8?B?WEpmQmxlT3BYVmowWmx6ODFEUVFTSzc3bW9WakhGZWFFK0RSNDJ5QkFNRDJI?=
 =?utf-8?B?a1AwTkdqMmJEWEV5bWJjKzY0dVlBSGx2OHR3NWNaTGgxZ3IzUmROeis0dnM5?=
 =?utf-8?B?MTZKRitFSTNiRjJNU28zOFZyVEdtS2dpS3NyRXNNU2FQb1dhM00vNUZBQ1A2?=
 =?utf-8?B?UytnNk9ndzNYSkpyd3JwUDFFZXMwbTBlcXU2WGN2dXRKTFQyeUwxcEVBYUp5?=
 =?utf-8?B?ZDI1c2VxU1B0WElONU1YVXltQ21raWZTRUNZdThFSUxuQmZnL2tENWxYdGtD?=
 =?utf-8?B?c3hMUFFGeStmM1BFNTI2QU12ZmhIOEJ0YisraHFFakRNSExlYzNWb2NaeDRq?=
 =?utf-8?B?RGQvRkJ4ZHVBNE9NUmdudUdSdFl5bDlxbjNlM2cvb2pDMGhKWDl4Z1dwRHFq?=
 =?utf-8?Q?4/oIh+MFRJTwgqltod4ZiY5oR/bRMeQpKtTb/0G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TklTak1CVFh4UEUzUU1tZ1B1ajVvZGRxSVNHYXh5MGYyU0ZRUUh4eTg3bzRk?=
 =?utf-8?B?cFU5UGRmWkxpMGdoSlpOUFNQckpld05qZGorelJVeitMWEpRWFpJNzVxOERj?=
 =?utf-8?B?S2hrTU4xcGpYc0VXcDVCeSs4cVVwV0pjbEJFRTl4dStGck9kV0Q1UjFkcnV5?=
 =?utf-8?B?cnd1REFDalJJYkQ4bjhDd0lDeEZQOU41OXRzRDVaK0IwU2dmdXl3bk40YVVs?=
 =?utf-8?B?aENoMTBXL2JTWGVyRUFHbUE2ZllPQ05iWVF0NEZVMk1xc1R6QmlsdnVZSlVE?=
 =?utf-8?B?VHc2Vk02R3dNN2lDTnZZMWRjaGRMUkNiZmV3ME1uY01CeEN6TzNLOVdCa1FZ?=
 =?utf-8?B?eEpFUURPaGRtR2FFVzVGaGRkazU3RUdLNzFnZmJBUHo4QlcxbndrLzlyRElB?=
 =?utf-8?B?akZnS2MvcTdmTTFxZ1NWYkI0bHFBSkpKQmpuOWRQTUxqdXdkeERaNjAxTnNU?=
 =?utf-8?B?MU1JbzFZQitIS2Yyek9SSlFRbUxNb1U1NEtMVG50RmRsa2hmZEppQlNXUnpH?=
 =?utf-8?B?Qm42aWRxc2svTlFXeTl5S1dEdHNoVFhIWk1KUVNvT1hhdm50bkJkcHd2Vk5V?=
 =?utf-8?B?OE03VzFtU2ZKUVVJdytFc2ZsemJVRFhtQi9mR2lzeitLeVFocVBUcCszSm1C?=
 =?utf-8?B?MFFub0d2VWRwakRZWW1FeTgveE5uNDBkM0NpSmtHODg3aFFySzVoZFVLZlJC?=
 =?utf-8?B?Z1VCT1ZmUGVNNU5FaG1EUjFEZHVQTG5aVlJlNzdJYzV2V2JFUm9Hblp3TU1M?=
 =?utf-8?B?bUtjK1FnSEFpU0J6K3ZKU0FoWURCVURCNFVhaVpqNEh1UEtZZEdGR0x6K0NL?=
 =?utf-8?B?WUFPakdYZUl5WjdzMk0xYTF0YXVVZ2VHcmlaaWQyNm80UHhidjB5aTE1ZGNL?=
 =?utf-8?B?b2dRdWFNV09wZjBFMEZJa0NsdHZncWE2Rjd5bE9rbjl3UHZNNlVMVWNZb2x3?=
 =?utf-8?B?bGNtdG8zZkc4a3ZyMEhmdDY5ZEM1amR5SEU3eGNNTCs5VVl0T1NZUEExN3M2?=
 =?utf-8?B?cEZzTnRrczNWUzFWc3R6OVRsV0dJSWczRTByelhYcVNRYTh5ZFY3aVNVbjlv?=
 =?utf-8?B?VXpGdWptbTNaeDJqRFpsY0NLNmdmazU3VkgrYnlJVE1hRCtieXoxRFFaT2pz?=
 =?utf-8?B?a1g2eWdGTVlQTmxqZ0xiUE1ydy8xSlo4QWFVMFhTSnVFMFZsejAwU1VIM1R1?=
 =?utf-8?B?K2xidUtCUng4OHpEU2FPZVBtcmtBbU80ZjIwa2JWTG5UaVBoTU1UQlE5RTRq?=
 =?utf-8?B?NHVTMDZnMmsyL2p6akJiYlUrSWZvMU5DOTdhbHZ2a1lyTWpBaDYzcHFLZmVM?=
 =?utf-8?B?b1JySjJ2OVp4NjdqUmw5VnJPR0ZuMVlzSzVIcjlaQXBIeWNRYkZEaytoZEpG?=
 =?utf-8?B?bmJZRitKTzNaUEJyblBoQklUL1ZmTVZNSzJPVnFuUlRHNDhoVHRIMnFRN241?=
 =?utf-8?B?b04rWlNMUENRck9mM1E4Ymp6ZnB0dS9sbzFUS1E1ZmZJM1JROVpEcmVHSmMy?=
 =?utf-8?B?bUYwaDhLREhBVWZ3aGpMbjFIMjBybU1jSHpBSCtKdCtIbHNvRy95R3YybnJL?=
 =?utf-8?B?akNXeDRRbkVuSGFLME04SGdNM1ZCeElOd29qa0hQNWhyMlI5bk91U0tTZElG?=
 =?utf-8?B?QjUvenJ3KzlrZVh2OGZQcjJzOHMvZWtkVENPOHNBTElMQzdTTTQwelhIcUkr?=
 =?utf-8?B?VHVyR1orMmk0clVCMHlRRzVERFdRK1BWTXRFeEYyZFFjVXpWYmpGZFF6Vk95?=
 =?utf-8?B?UTVGeUVINERtK2hMUkErY0JaQkhsVytuZTVuTXpFOTlzQUdXeVdOZzBzZ0Fp?=
 =?utf-8?B?bzZQN1dyQWRmdmFEOXhtckRMdjlKZG5EVVlKS1Yxd1JtT3NaYlFvNjVFd2tz?=
 =?utf-8?B?Uy9jTTB5TjZ1cEZlNWMxNjBFR2x1MGxYVGV3TkRZUXlmbWJLaEhiY1Z6M3RL?=
 =?utf-8?B?WElBVGFIYnNBbXp1emVZZytLTjlzNGt1dXJDOGdHUndLM0thbmJJNC9sZnJN?=
 =?utf-8?B?M3g4aHRoR1ZUWlMxN2JPWmhLSVkrazlrb3VqdzkvQTZTa3doVzFZQ25HcWd2?=
 =?utf-8?B?bW93T2xXelF4SHhCZ3lMK29qeWc4NlRDay9oRmd0eTVkb3dlQkw0UUJmUXRx?=
 =?utf-8?Q?i0F3qlMbZDFt1gc+hylNja+D7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603f503d-0ae7-4861-a5e3-08dd0390b786
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 03:10:24.9903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5iIOcQShYYEVpIcTmW6yXmK/p4qI1g4jN0CwuDSnIzLe9zqV3bzZhpJ56dWKU1r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916
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



On 11/13/2024 7:58 AM, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi, Lijo,
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, November 12, 2024 10:54 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: Re: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
> 
> 
> 
> On 11/12/2024 8:00 PM, Jesse.zhang@amd.com wrote:
>> [ 2875.870277] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_init of IP
>> block <vcn_v4_0_3> failed -22 [ 2875.880494] amdgpu 0000:01:00.0:
>> amdgpu: amdgpu_device_ip_init failed [ 2875.887689] amdgpu
>> 0000:01:00.0: amdgpu: Fatal error during GPU init [ 2875.894791] amdgpu 0000:01:00.0: amdgpu: amdgpu: finishing device.
>>
>> Add irqs with different IRQ source pointer for vcn0 and vcn1.
>>
>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 19 +++++++++++++------
>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> index ef3dfd44a022..82b90f1e6f33 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> @@ -83,6 +83,10 @@ static const struct amdgpu_hwip_reg_entry
>> vcn_reg_list_4_0_3[] = {
>>
>>  #define NORMALIZE_VCN_REG_OFFSET(offset) \
>>               (offset & 0x1FFFF)
>> +static int amdgpu_ih_clientid_vcns[] = {
>> +     SOC15_IH_CLIENTID_VCN,
>> +     SOC15_IH_CLIENTID_VCN1
> 
> This is not valid for 4.0.3. It uses only the same client id, different node_id to distinguish. Also, there are max of 4 instances.
> 
> I would say that entire IP instance series was done in a haste without applying thought and breaks other things including ip block mask.
> 
> If the same client id is used, it returns -EINVAL (because of the following check) and sw init fails at step vcn_v4_0_3_sw_init / amdgpu_irq_add_id.
> 
> amdgpu_irq_add_id:
> if (adev->irq.client[client_id].sources[src_id] != NULL)
>         return -EINVAL;
> 

We had some side discussions on IP block-per-instance approach.
Personally, I was not in favour of it as I thought allowing IP block to
handle its own instances is the better approach and that could handle
dependencies between instances. Turns out that there are more like
handling common things for all instances as in this example.

I would prefer to revert the patch series and consider all angles before
moving forward on the approach. Will leave this to Alex/Christian/Leo on
the final decsion.

Thanks,
Lijo

> Regards
> Jesse
> 
> 
> Thanks,
> Lijo
> 
>> +};
>>
>>  static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
>> static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device
>> *adev, int inst); @@ -150,9 +154,9 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>>       if (r)
>>               return r;
>>
>> -     /* VCN DEC TRAP */
>> -     r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
>> -             VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst->irq);
>> +     /* VCN UNIFIED TRAP */
>> +     r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>> +                     VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
>> +&adev->vcn.inst[inst].irq);
>>       if (r)
>>               return r;
>>
>> @@ -174,7 +178,7 @@ static int vcn_v4_0_3_sw_init(struct
>> amdgpu_ip_block *ip_block)
>>
>>       ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[inst].aid_id);
>>       sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[inst].aid_id);
>> -     r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
>> +     r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq, 0,
>>                                AMDGPU_RING_PRIO_DEFAULT,
>>                                &adev->vcn.inst[inst].sched_score);
>>       if (r)
>> @@ -1734,9 +1738,12 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_3_irq_funcs = {
>>   */
>>  static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int
>> inst)  {
>> -     adev->vcn.inst->irq.num_types++;
>> +     if (adev->vcn.harvest_config & (1 << inst))
>> +             return;
>> +
>> +     adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
>>
>> -     adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
>> +     adev->vcn.inst[inst].irq.funcs = &vcn_v4_0_3_irq_funcs;
>>  }
>>
>>  static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block
>> *ip_block, struct drm_printer *p)
