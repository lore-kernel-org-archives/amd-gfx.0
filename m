Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF839C282D2
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 15:16:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8017310E3F4;
	Tue,  4 Mar 2025 15:16:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E5rCGHw4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F2BA10E3F4
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 15:16:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdR9QTz9gYGRkV9uNG+X/pokvrPT8Dn3ppmDx3cNH6iqJ3ss3uhBGnhre8TM+akagyzeS6brfTJ2b9A5cGHYRZXOgMopUCl/+qpsHiDjnMCLz59c0w+Jn/0PRWeMH58wVCX3V5f7bGs64VP37Sg6mNmrh/r2m/JHZ++YHt73PiWlbE40v0L40DtW3qWwI+uGkvhxpKglmIUv3iTh2gQe9oUG52FyFlScGnyZGU+JO6DwIvEFTgksNmQxSD0dJAwFaNheCWGjs7P3Py9aTi6X5rmve3NzKSyHO/xCNQ+FZTm5Gm8sZd+2okbusVn5YcYxQjtoPaIo6CyrnmAHdCK8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N886fYkPfieCCbqc6JmPcgKt0O/S9wl/7WkYtDiKfJw=;
 b=wwzLCoNK+ZEaJ++fbOVa86Ppin8rbEPSdnYaPp/fVidbk5Px7dG2YksLjMxaQCa/FjosvTU5jCXCxIm55N2n50/f3XR0klWl2HdnHvnC81v5cZjvFWFuM4mxJhVZwHk2IEUXmorcMHreUgiaxrtmsog+2/knJCDtIkvumK+KVwV+KEHLahm4sDyYn1jBv5xluNRXTWWpu2MQ5f58QvJKy88oLMu/KQCM5SrvGFsUmIlBmZMgQMUarm7dSZuZ7yDepRYpX5oecKbzrbMXCJ/FW/LPoqJzfiyipeiGmDNrHDIme3X2FTAy4e2yZw6h97cD0hrjWjFMly4dY+MFYPOxfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N886fYkPfieCCbqc6JmPcgKt0O/S9wl/7WkYtDiKfJw=;
 b=E5rCGHw4H74UcMwaA1T1B4g4W+Mx5/8p9cz26G69UKyXAC3wR6kbFqhEG3qEf9xmxrxPZVxW/S5s3JKIYACcJuj8klKPmzpghuJlSHKLwy1ApnqOdBuKnNyu814CPqAmx4Mg/Jsr0sTtvFqFIvde+jkIF6INFMfXVUPzkOFOYoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ5PPFD525C5379.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 15:16:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8511.017; Tue, 4 Mar 2025
 15:16:41 +0000
Message-ID: <ea0821ce-11f0-4747-951e-2b9e8a35e549@amd.com>
Date: Tue, 4 Mar 2025 10:16:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: initialize svm lists at where they are defined
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250221092355.336312-1-lingshan.zhu@amd.com>
 <c0fd1f01-ed4f-494d-8e9e-ae092a6ef1e1@amd.com>
 <13836d37-3f09-4278-8599-ee8f3886e255@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <13836d37-3f09-4278-8599-ee8f3886e255@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0162.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ5PPFD525C5379:EE_
X-MS-Office365-Filtering-Correlation-Id: a2eceafe-7390-440a-0d7a-08dd5b2f90e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVJkYnFGSjhBZzRVenB1M1ZCS3dwZVJXT1hvNTZVWml6OHpnRk0yM3g4VzFs?=
 =?utf-8?B?QkxzUlNoMmNzUEFyRlpIWnoxeE1ocFhMMzFqSVRlZWgveE53MWxyZXVEMnV1?=
 =?utf-8?B?eVpSeHQyaEdLTUhpS0lQUnUxQk1YelJzSm1XYllOQ3ZDaEdZd0tHQU5xUkps?=
 =?utf-8?B?L1EvMW1ycWtCa3N6R0s0L1FKd01oeFQwVFZHLzBvWjMwQlRkK0c2RjZCOVJC?=
 =?utf-8?B?SllSVlpENlBhTHcrRnUrK2lFMld4R2Mrb2ZFdkREZFozMGhVVGpLL0xVMWN2?=
 =?utf-8?B?cCtiSU4rNEgzcm5JZE0vT0phRXFQR0xyT0tra2RRUE5WOUQzOFFaM3hjV0hZ?=
 =?utf-8?B?OUdHR2hDVjd6KzdNRzNCRVgyanFTRWtCZkc0bHR5KzVYNEwzRGpFYXc3V3lZ?=
 =?utf-8?B?VnZ3Z3FFRFF1Y3dpUHJvKzZwNjBKemVacTdEUzBZOTVoeloxOEVhczhBOHZQ?=
 =?utf-8?B?Q1NwMmxEemF3eEtIVnphRWQ5ZG5tVzRtNGsyd1ZzWVloU3BYVFkwQVdydDlI?=
 =?utf-8?B?eWQ4UXc2TVFxVkhsNXpZRERXTmQ0bkRtK3BNY0oyRmF6WGpBRGZtVlVFd0hO?=
 =?utf-8?B?VXFGeUJ6RU5zV0RUcDRrOTRtOGFkVVRNemM3YW8wS25sNUhmMlpVb0RGeUw3?=
 =?utf-8?B?YTBkNmYzYmwyVGpycS9nWUtGUHEvOUx5U3BFMkMwdXFZNE5QTEJVSHd3S0xy?=
 =?utf-8?B?MGxCc3dteUt1c2hvOWlTMGZaRVpGL2RucDl5K2J0OWpOUGdKYzhQTzRQcEVP?=
 =?utf-8?B?U2VIYlcwZ25WSHpzNFZkUlhlUUJJV201SGV0Z056dkFGZGJ4S05vNjNTekRm?=
 =?utf-8?B?NXdDRTZ1bHVjQ25Nd2dtdy9kdmtDNlYvb3RxL2doNWg1eFczTDB6YXhtMkZs?=
 =?utf-8?B?RmZKVmhCdW0xNXhRK2ZDcFlyN0tUdEtWVFZyS1UvZnVmK2VYK25ZM2FUakxZ?=
 =?utf-8?B?VWJZMWdyNW5MdEFQUHlYVVh3MWpvZGMzQ3RmMTZuSFNKZkUwZFgxcHFBZkkz?=
 =?utf-8?B?T2RYLzZwUTY5TldxY0dFUElzMUI4NEFwOHdkbER5MmJPWDFkbmJCMFFMa0Q3?=
 =?utf-8?B?Tkx3Q0J2YVpoMDY4WmxodEZ2YjhpdUxZRW9OOHUzcEVnSVRoMzhwVHNuUGcy?=
 =?utf-8?B?eTRPb2F4czZBSEhsR01kRlpOc2N1R3BUNGFzNWxUSjZjdUo2eHkveW94NU5W?=
 =?utf-8?B?cUZOZWFCRlNyQnozem0yYXR1Z1RaWk9oVTdRMExkSnNINWtDZXhrcnBoOGFn?=
 =?utf-8?B?ZmovbFFIQ0hvR2o3dTYxVUtEb3FoSTNhU3d2NndGMXFtR2YzZEdjbjBldkhD?=
 =?utf-8?B?TDB1RXBESWJITVFYWENGaFN5SUtVMEIyVTNIaTJ2NCtzZ01PMXpOVVZGMTQ3?=
 =?utf-8?B?VytJakhxS0xKNzArNFVFeXJ3UkNxcW4zRytNZzlaUTc4dDVnZjMwdlVDTjVm?=
 =?utf-8?B?RWFzQUlYZFVTTWo3Y25lYkpvU1BOdlcrNTdyQkRlOUxpN3Y3djdHeUNWZnRz?=
 =?utf-8?B?Z2pjVW1hNTBuRGorSWVqZGtmUlN1c1RKOW1iS1h5MnhMMThUQ2JrdlhoUDZB?=
 =?utf-8?B?amNBWUUxTFpldE9QQ0hRaUhwd05NeVBwSHJEL0QwZndqSzBWQ3JZeDJZNjRy?=
 =?utf-8?B?R0UvVHVNdXBpcmE5U1JZSDhSVG9maVpsWUdoeVN3bWxQYUM2NWF4WnNJQUR6?=
 =?utf-8?B?L0s3cmFSL2dWNmlaekFGUzF5NVlSYkxlU0pINk04NTl0TkpicVFKQ0tRMDMr?=
 =?utf-8?B?VXZVR0JJbWF1dGsxMnBleXlKaGpQSXRGN3k0QzE1S0szckZ2akdNK0JCYXRp?=
 =?utf-8?B?VkVVWEcwTEl1MXpTRHNXYzFNVGc4QTNKZ0c0ZDNmU0RkNS9XTU42OXZVL0Fk?=
 =?utf-8?Q?UXnwuG5vHOcCR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RCtzRk9KeFhLQXQrVHBSYnNVMDZqQmNVdnJaQ09LZXlIUXdhSEpIUVFscDRG?=
 =?utf-8?B?ODNUcytjWHpzU2pKRTU3RW1lN0U2Nit4bjFzaUlLMStUNDdXSXM2RFlkenNp?=
 =?utf-8?B?Y093dGdQZUljZ3FCbmliYS9rbE1TWThCcVVreUVlVmpZNm9qVGRpbkNKSjEy?=
 =?utf-8?B?STc5SnhLcmpUVVcreW9ueU4wdzRBSDlSdmVFcjVmNlpvY01KNlU1R2lNNndr?=
 =?utf-8?B?R3phVCt2S1Nvd3k3Ynk1Q1YrSUpCb2o1dGpwcWRrQlpQWWZPakJaSWdRcElK?=
 =?utf-8?B?QTRzSXN4cFMrQTJZbG1NeG5zWm56VGJLaW5KWUxpYWd6WnVtU0lMQzFDWkZn?=
 =?utf-8?B?MU9WV1BpL3ZFWXRlSDVhM040TUFzQWdpbW9UU1YyUnVXdE9KWmpGcTBjbUhW?=
 =?utf-8?B?Qk40cjBtdDBuaG40eGRCTHg2SFpSakdFYXBjc3FSYlRWalh0aHRLUEczTUxY?=
 =?utf-8?B?d3hhVUkvMVllMnVhOFJkRG1obTFyUDQ3RjJtMzN5Q3ZJMHMyanFETkRsRGFj?=
 =?utf-8?B?QUIwT2tKcmV4Skd1YVFOaTM0dVQ0Z1lNYTNRWmxXcEdmK3NQaVdkMWJ3aDFK?=
 =?utf-8?B?cCs5Z2NqZnBubmxHcTBlWWQ2emd0cWhLbFdUZXNwVng1cjF5ZU0vRW5MS1V1?=
 =?utf-8?B?VmpNZlBIR05sY0IwRzJ6R1NSMDFCdkkxS2pJYTE3ZG5mL3BqUThvMDhQK3FM?=
 =?utf-8?B?cUM1MHBJODRiTjV6WGdCU095cy85YTMwVEZQYi8vY1dtekIrM0JKWEpVcXNv?=
 =?utf-8?B?RXB0VUk5ZUgyTFppdGllazNsN01zVFN4eHNscmVhR0VtcE9xUFhSR0ppWXlk?=
 =?utf-8?B?eGxpZkt6Y3N5a3dkOUxsYWtyZ0cwYS9oU2s0VGJRQi9ZU3NLL3pNZzJpT2Rk?=
 =?utf-8?B?dmV2ZVhGbWhucE14U1IyQ2M3NTRicW4zNlJCVHNvSW1HekxhMFhDTXVxYjhJ?=
 =?utf-8?B?Z05xK0dOK3Z3ZjIxKzlFNzVOMnFuNGQ4SjBPWXV1enlNdS9tN1Zpd3dBc3Fo?=
 =?utf-8?B?dVlEelFVN2p0RzRyNVhHZkJmb1NKYjZqTFRDdDJFVHZFOTladFdxNkorUCts?=
 =?utf-8?B?K0pCdVdWVFJlVlFuR2FrQzZja1hQU2wxOWlGTmQrbXZzeHB6cVUzTjZWb05K?=
 =?utf-8?B?WFJ2dCtIbE1TcGRSNzJkcytvSVdEbFdWWE9PMW1FWGZWV1NSYnNnalM4RXVJ?=
 =?utf-8?B?dVNhNmdTckZBNmNOZi9qVHFKa1dBeFJLTlN4TkpySGdURmVHb1lSZzh3Kzds?=
 =?utf-8?B?VG5DQzlIS1crdWJjWUp4WkVVQWgrTzhWZzNJVHo0cnNBQWhBS3dQcjBxclJr?=
 =?utf-8?B?NjRsRCtpbVVma2NmV2cvUjRPek84RzFMSjBMSko4L1orWExnMzV3QmtjZ1A4?=
 =?utf-8?B?WHU4N2F3ZE8xemFPUGlMbENVSkhWL3ZvWUhGeXJYYnBSOHJHNm5uZzYwbjU1?=
 =?utf-8?B?Y2tBVm9aYlJVaXI5eWNKMEk5VSs2YlhXUnR5QXh0SEF6MGpZZ1YyNmdrT0Fm?=
 =?utf-8?B?V0NQMjVETUdQMGpBcndjSmt2U1QzU3BIaGJuQjZMTmdoRitIZGJuek84UjhW?=
 =?utf-8?B?WmxpcGtkVnNtYklNbWczMEJlNm9ZU3pNeE5xZ3d0TmdJYnJpbTRUNm1tZ3lH?=
 =?utf-8?B?dDNKd3ZlNDEwU04yRDdiay9YamcvNE9ha0IvQ1FIVlJDZSsxUlVNNVNicW1v?=
 =?utf-8?B?emVaVzR5RXFiNUFZcE5uYW9mUGgvTGtqVDNuSEtJZHp5R2dVWUR1RC9HSEhG?=
 =?utf-8?B?VUFuQnF4TGgwZlZlMG1mQ1pveWVSQjdPTWoyR1dJb0JWbm5EL0d6RTF6MHMy?=
 =?utf-8?B?UFp3V3I3OXV2V2k5SXl6M2dUMUNud0R2Mm9TOGRFbmJjaDgySUlsMCtad1Rl?=
 =?utf-8?B?d1pRbmd4YWhiVkhod1RtQXlxTUtGZ1c0YjZ6eFM5a2dyVzMrME5XdkR4bGxu?=
 =?utf-8?B?NEZueG1oZlUrRGtvcHFPTURHdGtNTEVsQ2NTTkxYd2xTM1Z5M2hrTDRQbkZs?=
 =?utf-8?B?cHd1S1dFRVBLK0kwN3FpQWRJK3FrSFdBdjFsbDVIcjV5STY5c0xqaU1XNEVo?=
 =?utf-8?B?R1dFYkQwZXFvbVRDNWU0aWM2TnlaenY2dEZRT1gzVXVRYklvMVhIMVZjelk4?=
 =?utf-8?Q?5VxZFCA3oXFVyVgEukG+x7dZR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2eceafe-7390-440a-0d7a-08dd5b2f90e9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:16:41.0837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rChWBhd0BggGFb/GCiojUO16MutT3mo0JvyR5HCyaIN/Akh3iv3UbQMLesjf7rQfRHpB98uoxaH5GF3APsf64w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD525C5379
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


On 2025-03-04 2:40, Zhu Lingshan wrote:
> On 3/4/2025 1:49 PM, Felix Kuehling wrote:
>> On 2025-02-21 4:23, Zhu Lingshan wrote:
>>> This commit initialized svm lists at where they are
>>> defined. This is defensive programing for security
>>> and consistency.
>>>
>>> Initalizing variables ensures that their states are
>>> always valid, avoiding issues caused by
>>> uninitialized variables that could lead to
>>> unpredictable behaviros.
>> The lists are clearly documented as output parameters in the svm_range_add function definition. I think it's more readable to do the list initialization in svm_range_add to keep the logic of the caller more readable. One suggestion inline that would move the initialization to the caller without cluttering the calling function's code.
>>
>>
>>> And we should not assume the callee would always
>>> initialize them
>>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++----
>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index bd3e20d981e0..cbc997449379 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -2130,11 +2130,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>>  
>>>  	pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);
>>>  
>>> -	INIT_LIST_HEAD(update_list);
>>> -	INIT_LIST_HEAD(insert_list);
>>> -	INIT_LIST_HEAD(remove_list);
>>>  	INIT_LIST_HEAD(&new_list);
>>> -	INIT_LIST_HEAD(remap_list);
>>>  
>>>  	node = interval_tree_iter_first(&svms->objects, start, last);
>>>  	while (node) {
>>> @@ -3635,6 +3631,11 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>>  	if (r)
>>>  		return r;
>>>  
>>> +	INIT_LIST_HEAD(&update_list);
>>> +	INIT_LIST_HEAD(&insert_list);
>>> +	INIT_LIST_HEAD(&remove_list);
>>> +	INIT_LIST_HEAD(&remap_list);
>>> +
>> You could initialize these where they are defined by replacing the struct list_head ... definitions with
>>
>> 	LIST_HEAD(update_list);
>> 	LIST_HEAD(insert_list);
> Yes, this is better, I will use LIST_HEAD and remove the initialization in  svm_range_add because we don't need to init them twice
>
> By the way, I am not sure the lists are "output parameters", usually an output parameter should carry some information for other functions,
> but here the lists are just defined, even not initialized, and are on the stack. Actually the callee only fills the lists and the caller itself use
> the lists. I suggest to remove the "output parameters" in the code comments.

Input parameters send information from the caller to the called function. Output parameters return information to the caller. In this case the lists are that returned information. Therefore I think calling the list heads output parameters is perfectly valid.

In fact, I could turn your argument on its head: If you move the initialization to the caller, you now rely on that initialization in the callee, which may be a problem if the caller forgets to initialize the list. In then end, it's just a matter of calling conventions. It doesn't really matter where the list heads are initialized as long as they are initialized in one place. In this case the function in question is a static function that's used exactly once. So there is really no point overthinking it.

I'll give you two options: Leave the code as is, or move the list initialization to the definition as I suggested. I will not accept a change that "fixes" this non-issue at the expense of code readability. I disagree with branding this as a security issue in the commit message.

Regards,
  Felix


>
> Thanks
> Lingshan
>> 	...
>>
>> Regards,
>>   Felix
>>
>>
>>>  	svms = &p->svms;
>>>  
>>>  	mutex_lock(&process_info->lock);
