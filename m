Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DA5D1BDF2
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 20:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17C5210E09B;
	Mon,  4 Nov 2024 20:51:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wCI0cYZ2";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D9010E09B
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 20:51:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCxdNawzl9ByDv8BO6Prpq0NuXhZ98fzQpz3h4cx0cWRkAu+MFLwJ8KCYjk+v73Ws8JTxV3KuGXemlOOBRNSZm7FuYGhah0sjZrNKKWNsZIZ6QI0l4M/8trAz7s8B/EWCiOHXW/PFA2cNkQAKu/Zx+t2ZYTYmX0HWgP9FU8pqdQ2NKuW3YwqHlfPwEbsI9PuHZDGYyxk5Z2y1jmeM97DKZS3E3RCtaa9YCnnRnV39oyEgzZxIqs3eDKo1JBWz3aIHF+SNH28D+YhXr94x1g/7oyHPWclbyHYAaV7ENqMsxvXEDtoiXLWGixldbz4/Rh/FzXJ2Tb6rutZwKuwJH8s4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ch7Cs4Sw0zmFG/KeBHhcErO34zF+U5M3n4IomtI+efQ=;
 b=ri4TI+H/rOeyVtDLYDmO9/Avn71fBqGRyx/jXDogEJ25lolURn0FTJXrid+mMz8RJNvdEHvfhfARd1W3TnI6/Q1UHdwxpnGi0AIHKXSVmhvrR6WJE2whnoqFQsDcWUx5dds+/mJyySH3aYiyiel2RSsMU77rKGL2E2O+pM+dEbphmqqzFT42dFujVfDXdbkKhpWvvwlqsez3gMRX+XkGUrSN2KtwkrENwHMHWmiYXXpbuMA5y8AFf3PxxOKX7AqrEVwSdZgUC/NaycIenoUcELLFoJ5z2v3rugojgWKPex9ncpZi8KI3Eq8+U9vekt108t6Bbc7rDzl1BZlthkm0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ch7Cs4Sw0zmFG/KeBHhcErO34zF+U5M3n4IomtI+efQ=;
 b=wCI0cYZ2KoE3lgD9tUv5c2pm7sw6Lpzp4ALYB1+5QXPdbioM7lFTSz461QT1hpSHF9vJnNdyLZzm4GKjk0QOJ/K2W9kVQpVnzIfzO9gWxCSpfBpnMouUZ2yl4MZiy6UJg23gEiG6+bP9Da2JV+90DSImyxxlxNFnOmRnDdERVhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Mon, 4 Nov 2024 20:51:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8114.031; Mon, 4 Nov 2024
 20:51:00 +0000
Message-ID: <76ef68f6-dd23-41b3-8dec-d35e6874de01@amd.com>
Date: Mon, 4 Nov 2024 15:50:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] amdkfd: check ret code for ioctls
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241031105059.251085-1-lingshan.zhu@amd.com>
 <616bc79f-ad92-4b22-8df0-0a0ebe27fcf6@amd.com>
 <2ca21e92-6324-413f-9df9-0bfcf638c669@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <2ca21e92-6324-413f-9df9-0bfcf638c669@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 36536ddd-5888-432e-ad20-08dcfd12636e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnlBVDcwM09qd0pkTW5YM1dBWGlvaFl2V0RLOC9iZEhYR212eVRwS0RSWDRm?=
 =?utf-8?B?WUF0UWJuRzAxSyt2dkNnLzRwUm1xUk5TN2lhTG4vVHpWMGlTNmxXWm9maWRP?=
 =?utf-8?B?WjJZN1VOOGlNVFZCOGhIYlBVSXhUbGhSU3ExdzNLbk9tUFVDL3UzKzhRODY0?=
 =?utf-8?B?K1BKMnhCTVpyR21ENHRKR1djU2VCQkJueUdhKzdUaGJrY0JTRkdtQ1dVZ2N2?=
 =?utf-8?B?bzA4eFNCVStFa0N3aXpidGNIMTAvRzBscmZHSUNoeHBtVzhXeUs3ODVabFJY?=
 =?utf-8?B?S1ZSR2xNdVBGRWhKOW1FTnA1QW1pemd6VEdzNDdibDZHSWpyaUc0MHBFWmxM?=
 =?utf-8?B?UnBDWSsweWhvaC9Vd3B1NWgrSFIwWmhmRExWYnJMNHZPaG82RStXYjB2WEti?=
 =?utf-8?B?Y3VTSm15ZlRjUTlkZnh1TmYxTzIyVXhkeFN2Z2wwYnBNVGNoUEVJa0F2V01Y?=
 =?utf-8?B?WkdJWXRSYm1DUE1hR0x3MWZ1U0kwUWw4UWxYNXF3R1pncmN3cUE2azBYU0FJ?=
 =?utf-8?B?MGFvWUJ2bW1nNjhqVVlGTnNpbFUwVHlvNkJlcW1rdmZNbDY1NGZHbnVtcWFV?=
 =?utf-8?B?dlNDWXdNTGlvTHN4NU1tU003eGFoZVlMQ1d4bUJSd043Y3FYM1VQVGVIQzRy?=
 =?utf-8?B?REh6UHZjNEFXalNvOXVGUHdySnZIMnVHSlpublVwRWo3RHF5WExZbCtaMm1M?=
 =?utf-8?B?YnBpd0ZsTktiby9hTmFzdHZ2Qi9idytwRU5YL2ZsMXBOTUtZcmIrVFIxNHc5?=
 =?utf-8?B?clUxcklIWm1YZ05FTnAvdkdGcEZJTnRLMnBoQmZKY0hjQ1AwaXRSdFZiTHNZ?=
 =?utf-8?B?ek40alFPd3pxck56OE9YanZwRnh4a2tPZ0VnMVlJUzhVNmZ5MW9UMmdpYldn?=
 =?utf-8?B?Ym43RWdGOFdCanFwc0k1czhxSER4OHNMWUNWdlo5VWRPMk9iR0NxYnNFUElo?=
 =?utf-8?B?NUErTGllSDNmNFh4VitpazRSNVIwcFRydFhKUktaaHZ3NGlrZU5jVTA3ZDhu?=
 =?utf-8?B?SEVEU3JiL1ZmT0tvNWpBNVRTYWlxZ1VoU1VZd1VIMFZEenNpbC9kV0EvVXhp?=
 =?utf-8?B?MVJZVFBNNHBvWXlaOXpVcWx0SUV3eTd1OUZSb0YwQk4veXkvbERTNlI3b3cv?=
 =?utf-8?B?QWgyV2lENFYxNkRxS2NSM0xnSVNsWVFUWm1OZC9nb0FEWkZ0YUkvb1Y4QUVP?=
 =?utf-8?B?bktVVzNCdkRFUFJ2K2w5YWJjdi9IczNnRGRmTkU1VU1GQVlJRzUzeWY0Z2Mr?=
 =?utf-8?B?cHhpMlRwNGdudkNMRHNGVk9hU1c4am8yYU1nWFdZSzhBOGhDc0hORXRRUlg0?=
 =?utf-8?B?SzhKaWNZZWU5bmQvZExhZkdqUjdNRG9XTHJnLzgxeXUreGs1Tjl2QlIyMWtL?=
 =?utf-8?B?b3BkZ0NVWVZVTm1JNk1NUWVSQ3hoVVJIazdKVGR5SXlka3lKa0hLb2xnVGYy?=
 =?utf-8?B?V3N1bUtrUWVQejIyenZ1UElqbkp5cFVXL0gvZWh5UkhKbXhHZnE2RDFsVUIv?=
 =?utf-8?B?OXhMUzhpY2kwZ0IrTVdvMzd2VFdNMTE2NXpwUVBFUnVNOFVIUWEzekpkVEkw?=
 =?utf-8?B?dWUwUnpqRXVVK2RZcFdzWXQ4ZzZ1S0x1LzJjemlmQ0hvNStSTEczUTJ4STZL?=
 =?utf-8?B?ZVdSRHhrenN2L1VmQ2ZvQkkybmZFTFM2cWtWUHQxalY1cUlLVGtHbHo1Z1BJ?=
 =?utf-8?B?VmZDUXNpU1IxUDQycnQvWksrZ1h2QjRvQmV0aGliOEFBV0JXZGowdkVKekRW?=
 =?utf-8?Q?4tdXJDxreOLt0Mi1Npp1eKRqVi7N1tUGXyCw/B8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zmk5R2dLQVZhTXVaMmRCbnhNbXdsSC8zTENXQTErRjhpaUR4YjBxeGhvSS93?=
 =?utf-8?B?UXNjNU54UlNuUUpRWXZpYXJPeW9nNHAzSDkyM2dWTVBhZzYyT0xKckJXZ1Jt?=
 =?utf-8?B?QlRWY0tjUXZyUW5pYW1lbWk2UmNGZE9LZG9TVUk1QkQ0RkZKdTFsN1lhQVFZ?=
 =?utf-8?B?N2dKTERra280cHlqQ2RSdStMLzBlRnJBQXQwcXVLMHNsWXRraWkyQ3VxTnl6?=
 =?utf-8?B?N2tqNUN2QmRKYlBNYWdYNzBpV292ZTUrUHNKaFQxMGNxYW5Cbk5SZXg3dERB?=
 =?utf-8?B?ZW1YM1g4YnQ2SVVmaHNFbC9RYzVEemtwNVl3YnYyVDJGMXU0RVBUbEltZzVt?=
 =?utf-8?B?Qkl0TDQ1RDM5MUdMd3dETUVOMGV2cnRGOUNNQWJZa01tL2djMWhMZFpqUDFE?=
 =?utf-8?B?MnZ5d2NVcThZYzFycklpOEpGU3lnYUNxL0JTM2dGNCtUL3VISGw3TmdEZEdh?=
 =?utf-8?B?YXZiRzF6MWJTR2s4dUwzQ3BmZkJQam5kQW1FSExZeGNEU000MWN4WStrQTJk?=
 =?utf-8?B?TTVxRVZsY1lxWXhEaUNpMFlqdi9PSVVhbnl2S1pNcHJic1VPejNlZ0dMaTgy?=
 =?utf-8?B?V0dCRndaTWwwdkd5d3N5aUVRWWJMRW8rbFVuNG04WXRMQmxpY0xBQm42UTVk?=
 =?utf-8?B?R3BJNjVBSktmTlpvWURNeFNuOGxJeHdBMUxUWXdDMENKSXVnWk9wRlBiOG9k?=
 =?utf-8?B?R24wNHkrRm90c2taM2Y1RkhlMkpUcklLK1IrbEJtUkhIeC9Eb3hFbEpQZGJ0?=
 =?utf-8?B?b3NmSTh6ZUI5SnpGSjhYMk9QOVk5bEwyMmhZTFduWDlFSTgzUHJwOFJoWStB?=
 =?utf-8?B?QmJrUGJnSEdMdjJrL2xyNFFZV3I2dmVCVCsybzYvOVpiaytZQndWWkpDdnBM?=
 =?utf-8?B?VUFmQ1J3cHIwV3lEZ2c0cjIwK1ZrN0lsSXpFSHJuVUJTMFhpWnd3REFjeTdB?=
 =?utf-8?B?TVozQk5qV04vNElVTWVaRGFDR2FMTzdOYzZKc2VmUkJSaTB3RVgzVDJsM05j?=
 =?utf-8?B?emhZRjBlVkJmMW5MZGdIS2IxTXNMcUFrT2VJNGkyWHNqYzJIblNsOVJtczNR?=
 =?utf-8?B?REJRTjd0REF5akFmZFpHWUJJK1lXbVR5V2dBMkFHbkIwd2MraWZJRXppZFpS?=
 =?utf-8?B?T0RjSWZkUWk0dzcvazBtMTJUWDBGUEVHMDRzcWRXaHFQNXRlUDhMOEdDWW1s?=
 =?utf-8?B?RU1XUWxld3RWMTdyVlpOTjROT0pZRmNXZXFJZ1AwWUkzTTRVckh2U2phQTNU?=
 =?utf-8?B?K29UM2EzSE1HVXFhZ2wwTWZXZzZGd0VsNzRFeEkyYlV1USsxRjdmNThyRVQr?=
 =?utf-8?B?cFBiM3ZENitZOHc3T2svQnBjazh2S05zcXE1Vmo5SFc1Z3QxUTVSS1BFNCta?=
 =?utf-8?B?V052R2l3eDRvRVB6TEtCNG9LeHFMd21RMXFNUnE5dGpYRThqYldHYURVMzcz?=
 =?utf-8?B?K2tZR2hiT2dmMzdhbGp0WERRREZJY1c1TlErNHFNbld2V1k2d2tRbmlqa2lK?=
 =?utf-8?B?bXEyZSt0V1Q0dXl4WUdVbWl1a2o3ZXM4bnM3cUZUclBGbDhKTE5nYnliY2Qv?=
 =?utf-8?B?Y1NtbWVIS0hDQjJRZEJ4T0t4bUxINUdWaFBsUnVoTStWbExBYVhOK3pHYTRC?=
 =?utf-8?B?L1p5SzA4em9QSWtHZzdBYzk0RWRLMlF1MFdZR3F6TlBsN0l3dHZ6ODVGVVJt?=
 =?utf-8?B?dlJjOFZmbWlZOUlxZC9odkNhZ3NDSlpwd09kNGVVdE1ybmoxR25tcGNMMysz?=
 =?utf-8?B?VFBYUnVyRHYyeTY4aUw4d05KUFZoSzlIQ01jcjRDTUkyNTlMS00yWmYvOXJZ?=
 =?utf-8?B?YlZZd3dRbTF5RTB4cXJCaGhUMGhOdmJ0ekJYcE5JbFo3SEp0K2xvSWhrMmxZ?=
 =?utf-8?B?Y2s0N3lPYWducFcxTzlwbUFYUldpcml6RTV3Q1cvVjZjUjd5dkcxMUk1a05i?=
 =?utf-8?B?bk9MQ1ZkMGh3U2RFZGxqdkhjbENZbFNHRFdHeW9JYTRIRFNHYmtLWW9jMXR1?=
 =?utf-8?B?aUpjVVpWNWJvbHN6NmJIaWRBMFJrYjRHTmxvSW5FejVDaW9yZTdueGNURmt1?=
 =?utf-8?B?RFl1b0NoQW1hQ2FsdEZyandDRUhQYXRUMnoxWUR0YlFJRm1RTTY5QzFTZU92?=
 =?utf-8?Q?uh0MBIlxdD/bb5CplCq+wy6tC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36536ddd-5888-432e-ad20-08dcfd12636e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 20:51:00.0512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rz9dfMQU1fCOOOaepcDAekKJ586sR+bbDyer9LOz0FQX848moi5kW34DA/b9MY71WVNXVBD+Yr41Q8+npW4Hng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464
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



On 2024-10-31 22:35, Zhu Lingshan wrote:
> On 10/31/2024 11:30 PM, Felix Kuehling wrote:
>>
>> On 2024-10-31 6:50, Zhu Lingshan wrote:
>>> The ioctl functions may fail, causing the args unreliable.
>>> Therefore, the args should not be copied to user space.
>>>
>>> The return code provides enough information for
>>> error handling in user space.
>>>
>>> This commit checks the return code of the ioctl functions
>>> and handles errors appropriately when they fail.
>> I have reviewed and rejected this patch before. My opinion has not changed. The existing code copies the ioctl arg structure back to user mode even in error cases because user mode needs additional information from that structure for some ioctls.
> how can the user space program distinguish the "good informational parameters" from the  "bad default legacy parameters"? There can be other user space programs other than thunk.
> 
> what if the user space program doing pulling mode, it can pull the args changes because ioctl is usually slower, our code should be robust.
> 
> usually the return code provides enough information for the user space programs.

I don't understand your concern. Even without your patch, the failing ioctl still returns the error code to user mode. User mode can safely ignore additional information returned in the argument structure. You are raising concerns about performance or robustness. I don't see that either of those are negatively impacted by copying additional information in the argument struct to user mode.

You mention that there can be other user mode clients other than Thunk. That's true. E.g. rocm-gdb calls KFD ioctls directly. And it depends on some of the additional information about errors. If you know of other user mode clients that are broken by the current behaviour, please point them out.

Before anything else, we do not break existing user mode. Your patch breaks that rule. There is really no room for discussion here. I'm not seeing any reasonable argument to even consider your proposal.

Regards,
  Felix

> 
> Thanks
> Lingshan
>>
>> Regards,
>>   Felix
>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index 3e6b4736a7fe..a184ca0023b5 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -3327,6 +3327,8 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>>>  	}
>>>  
>>>  	retcode = func(filep, process, kdata);
>>> +	if (retcode)
>>> +		goto err_retcode;
>>>  
>>>  	if (cmd & IOC_OUT)
>>>  		if (copy_to_user((void __user *)arg, kdata, usize) != 0)
>>> @@ -3340,6 +3342,7 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>>>  	if (kdata != stack_kdata)
>>>  		kfree(kdata);
>>>  
>>> +err_retcode:
>>>  	if (retcode)
>>>  		dev_dbg(kfd_device, "ioctl cmd (#0x%x), arg 0x%lx, ret = %d\n",
>>>  				nr, arg, retcode);
> 
