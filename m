Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D35ED597BC
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 23:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC40810E1A9;
	Tue, 12 Nov 2024 23:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xlxBjJSB";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80BBD10E1A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 23:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qv7ekjGGhKavBRv3PFrr9Ja1gGN5vLm4368/tDAxp5zWTZdu/Nq20YykvVQmI7V0YmEDNus9l2V3xu41BOra+xkCGE5WvB+5+QoPHq1wSie6wpPrjEXhXBQZ3VdulpaOYwBLkcJtvNjSc7OSouTqqrjzL/1cz08KP8c4gl1d3uIHJbFEsEC9adLubtrKVN0e9Ssuf5Kb11wvGKHrJ9JfHzKJweVGVS/dpw1Qpr7mv7gYVwy782/+w9GpeQXN2/gwJInD58mSoXacoD/xj6Yz7BOb+AD1Q+pPikjXVknE6kr9fJ8+gvb84EW/5QP5lWWhTPGqYPEOWB+Xyls7aA0uLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25TxwjT/8DFIKg2BrnolvM9Z4MWBwz3JNnaBofbRdfM=;
 b=EYGAeIiehCbRrTCQT/utQ6nvAR2N1zBz5UXWD6/z7+FsihA4OVDqVss0pONZYpjHJLlNoZZOhdN3e3V+eE73OVgpiBg47io6oi18jLZB0d34Sn80/846BIG9DVBi/2dpsBcgMYX3tPjGVL16UqCAjCZTegIeklGYdU24umXwfpbvG8QRSKmcITcjf9lQhhGOIC9xU0Xjyw8NGFfr8328k4X2XGuy9+dxKaFVa6ItZEPTrdN5HHTPQAdowanzEnfeJIQK0E6CPg9hcC9Psf+8C9Ch0ci2mRO+rCKV4kUha9C1v59wprws+bv7Q9rOyGqdTSb/Irs66epqUP6y4ThO4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25TxwjT/8DFIKg2BrnolvM9Z4MWBwz3JNnaBofbRdfM=;
 b=xlxBjJSBznEBghc28T6AOtQsguP9BvOUVMtAVlZeKjxPQbUMTr26y8x26N0Hh+R2h6EvayZ7wD5lYpBxsK10z/Ni60Uwto4VKVk3vMOFmI+U5UH9Kv1w45f4xIe7TpVQf5vwRTIWm835UfSZzPtrIUAqFI2s+Qsr8EjTYyR/M5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Tue, 12 Nov
 2024 23:46:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 23:46:28 +0000
Message-ID: <bfa7bfa7-c134-4268-97aa-7b9baf899be3@amd.com>
Date: Tue, 12 Nov 2024 18:46:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] amdkfd: check ret code for ioctls
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241031105059.251085-1-lingshan.zhu@amd.com>
 <616bc79f-ad92-4b22-8df0-0a0ebe27fcf6@amd.com>
 <2ca21e92-6324-413f-9df9-0bfcf638c669@amd.com>
 <76ef68f6-dd23-41b3-8dec-d35e6874de01@amd.com>
 <cc6f4141-a085-41e7-b772-8c400788c1b9@amd.com>
 <d96c1117-7eb9-4c65-ab0a-1f4507d32674@amd.com>
 <87029c10-4fce-4a42-a04b-ed2633c69148@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <87029c10-4fce-4a42-a04b-ed2633c69148@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::39) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: f7312069-0253-4eed-429d-08dd03743a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2NDSFVQSjYyOGhJQTNNeUFtb29IbHZ5bWVESEdaWHNtbW1OUlRlMlVVbFlV?=
 =?utf-8?B?R0QveFpXU01sQ3U0NTZiT2RSakZwKzNSTTF6SGR0c09MZVd1eTg3NFFuS3Bn?=
 =?utf-8?B?Tit5TnhkQVhkWVI4S2lCREFQeWxmcGkrcUpVRzMrY0pHNVlVRkdNUUhTamRa?=
 =?utf-8?B?bWEyTHdrdmE5TnBjTUFqQUR2Zmo0Ry9YK2YycHVlZWlPWUlyem40TEljaVB1?=
 =?utf-8?B?YVAxU0p0ZThseGpuQ1ppeGJ4RWNNa3h6U1d6d1dsQVJ2d0kxL2lmL2VYMXVH?=
 =?utf-8?B?OHgvTmF4RGZPMnVwVEN2bndaMDFObHJVK09FVnJ2U1ZjWGlmLzA2TDZac3lF?=
 =?utf-8?B?OEZ5WHA2SnBvRHYvQW4wZFliMUZXeFRiamcwajhaRVB5aUpXV2FHRGViaGx6?=
 =?utf-8?B?VXY3ZDY0aHIvTk85dXlLam03T3IvMkkrRnFNRHdGQkZQL0FMOTJ4Q2Q0c3dn?=
 =?utf-8?B?Q0grZlBsdTBhMXRydzcybGI3OWNnaS8xNXFuYUZIU1J5a2ZvcnZZdno0YkUx?=
 =?utf-8?B?U3ZHNEx6UjAyeGtoNFB5cGpOZWZzV3ROL2w5eHdZVVhpOEpEQ0Y5czBvcFlR?=
 =?utf-8?B?RU9aMHNXZnhUdXBobnU0bjQvV2Z2RXllOStMRkJUOW9pdlpOcUJHUVVWd1J5?=
 =?utf-8?B?RjU5aEkyaE5KZGhiSUsrQ3lGRHRaWGpuNFhoYm0wV0tZSno1QkxhdS9Mc1Vz?=
 =?utf-8?B?cmVETll5alA1eG05UGYyNzZYR0o5ZitSOU5lZ0RnRHlZWFl6Y2d3YjBibzcw?=
 =?utf-8?B?WCtrcjYvRUxSS3hiNmhFTEwyUDZYTllwOThIMU1CVXlzV1FySmVMZUYrMlVz?=
 =?utf-8?B?WENEdjFIN0lYNVZvTFg0N09hK3h6NWZCYXdHaExkVVh4NjJXU09lNXFBYUIr?=
 =?utf-8?B?Mkl0UDVqR2poS3Y5blRnZmxFTFNSQlJBYkFmRzVaSjRucElhSVUzZWY5NTB0?=
 =?utf-8?B?NkNmbEpaNWNCZU5lRTFwaDVycDhTaitHSnRCVWpIbjFNR0hweS9jbzZ3UkF3?=
 =?utf-8?B?YVZNT0tNMFY2eCtBQ0NXTjRCR3RuTWdGV1lwZzc2aFEwSFFpTC9RakZvUmN5?=
 =?utf-8?B?T1JwdEJNbGNlNUJWb1gzc1dPV1o5YlV1amhWNkZhaHY4bkxCajBCeEpOUnBt?=
 =?utf-8?B?ZkF5SUZWTnlzV2pzVVhqaHBjOTREa3ovc0V0MUFaSlYxVGdSZHVxRE5LWHpP?=
 =?utf-8?B?U093VlZGZGkwNVVlZXRKRTU1R2J6bHJOeTRjN2Jjby81ZnQ5dDBQZHhRNEpI?=
 =?utf-8?B?dFZsclpDdDgxNE5PN0Y5S0RobHRpUTMwNCtodG0wc2pJUVViSmpKdHNuTEVp?=
 =?utf-8?B?eHAzc0VrT3cvbUtRdmVNWlREb0c4TlEvTUtTQjFEK2NGWGNjQ05wT081MTYy?=
 =?utf-8?B?MDFWNmR1dE5PWjNZekJlSEkrSHdQbHpuU2FFZXVscVlYU1VJRUgreVFIZWJS?=
 =?utf-8?B?eS9CUlBnV2FxL2QrZy9RR0xzMnlMUHJWSzljaFFBNlFwaklybGZDb0t0eWpa?=
 =?utf-8?B?NUZuK1lYYytHb0xUY0N0SE9nL01ISEsrd2J5c29QYTR3RERScXduN3RCU2tk?=
 =?utf-8?B?ejE1MlpqeU9MOEJPd2hVaGNLd3hlM2dxWVR1L1lQWGpOTWRDVVlBb2dtcnpO?=
 =?utf-8?B?Rlg0Mm5oTEFnU2JSM1pSOXhTd2FsRDBjeUo0amhIS2FPUmF5bjRweVdmdXd0?=
 =?utf-8?B?bE5oOG9kcWhzMms2KzZMRlBOelhsdjV4ZkxON1NCQkV3TU5TRlB5RWFHS2Mz?=
 =?utf-8?Q?KLim/Z0zKIDhpZFbzKxpGEmFYv7Z1FFaSdmSM6a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXp4aTdDanphQzh6ZFFZYWZIUFErNVlpVDh6citOM0plS0V3YzBJRGNJc255?=
 =?utf-8?B?c0RiRHd0Z011N1FQWVhlMFpwK3ZTNjZBSklyVmRpYW9yeWNXMlhsekpnWUNX?=
 =?utf-8?B?dTJMZjRTQ2cwaTA3VDRIUFluMGhyWGdDZm9CN2lOK3NGdFBrZWZWYnIvcUto?=
 =?utf-8?B?TUZveDRUa0hhYm1lUnBwMDVPbXVFYi9iMElTMFd6R2pzcm9kbHFvUkZJczVB?=
 =?utf-8?B?MUZqRkVKdnZLbWw1amFTMlplcndrWFFsL1kvdFZxVGRCbXk3VldOUWFpNFZo?=
 =?utf-8?B?SFhRNUYveStjdUZVeW1hRWJkRjRQaHRUeE1neTJEQ05UUDJqOVVDR2xuVTFD?=
 =?utf-8?B?eGM5M1l5OE1yT2NudHFjd2M1NDJkZ1cwZi9RWEhKVklQakg3ajh3NzlPRExi?=
 =?utf-8?B?djB4MGRwUGxHNmlPdm41V0xhUTNwaFNBSkFNdDdvOHl1OHBkNFExckc0dG9y?=
 =?utf-8?B?RnQ4NFVkeUpnTE12dzBxbEcvTDNwdmkrS2NUQTMvSU5nOU53ZitGMFNtMUxW?=
 =?utf-8?B?bVJ0R2U0OXFSd0FFM3J4YWNsQ0NsYnFrMVc3emlQcVZMNGxqdXNNa2VQYzJy?=
 =?utf-8?B?RDlHVy9YWDkvdzNXV0VRc3lLZ0I4RUpUMFNPQ1lyN3FxSWozNjR3eXBUd2tm?=
 =?utf-8?B?SEFmS05nbnArN1JYMjBIalN0R0svTzJuUDBWYVpCdzkzQ1hFbksxOFRxK1lV?=
 =?utf-8?B?bEtJekFpRVFWRFFZMVNCRFYxNXNSbjEvZTBxeXZlaWROcUgrVXZzYUc0NEhE?=
 =?utf-8?B?TWMreXpLRFdjS3B1ZXJ0T0pKcUhuZkFxQUJvL2lwRWJPN2tFZnAzNmt5ZWRv?=
 =?utf-8?B?U0x2aFVlZlgzTUpoYmh6MitPZDg0djdodHFmUTkvdzRBbkpWOU1GSjQyMDJP?=
 =?utf-8?B?OTUzdzNScXBrR3B3aEJ4R3JEK1pjUUZ4M1l2azl4anFSaXNxWkRTSFg0ZGoz?=
 =?utf-8?B?bGJlNkpnS25tLzJOU2t3NVZ3cGoxMjJRYWUzT3QrREVjTmg0SStuelZ6UG4x?=
 =?utf-8?B?VDRkZ1lPY0xXaHEwSDFBejJTalc1NzZoa01WWjdITVdnN2hGWlZNZDJ3MXVH?=
 =?utf-8?B?eVJwcm14eGJ0WUVSSmtVemdoVHlEOGFBUm9vV1plN052WlR0NzhmemM0NW55?=
 =?utf-8?B?WHBJd2dTYU1zSGVpYnJ4OElELzZYVnkrNGM0RFNLTGZQeTJ5bm9XU1R1R0FM?=
 =?utf-8?B?cmwvUnFUNXZLQ1piRmNaZHNPcCtZVkx0SHZqd2laVENxM1FXZU1hd005ZEJt?=
 =?utf-8?B?NVR3WXRFdFZVUE9iZVF4WXE3R2hkZVpiYUxIZjZ6RHlLckhPUURaOVVuSDdw?=
 =?utf-8?B?ZC9DZVozYjRTcjFQWXRLM3RzVHVUNjBwaW1OVVJmUDhtVWJhYmVDWmZua0ZN?=
 =?utf-8?B?RjhDbk90OXlwV2MxZXpObFc3VEMyWkd0R2VGak5COFlmUUZXS2RxcytOTERq?=
 =?utf-8?B?dHFEcUpoSzdOblB0NFUyTkExYmxpN3ZXSmpnWXNXeW9TbGpTWFZ6R2FyQU5z?=
 =?utf-8?B?TnJLdk8zU1E3TDBuUFBBUDZaYlJlWHpEWitoaEtHWmh0cFRoUG54N1llVkhu?=
 =?utf-8?B?aVlTWVRvbU5kdG1DdjduaGl5aDdQOTRqSGNNZGdneXdKdkl2NjdncmpidVM2?=
 =?utf-8?B?bFMySjQ0UlZ4NzZkbk1NOFRuZWI0ZXd2eFBEVTlBaHdTbk9kOGZhc1NZblNM?=
 =?utf-8?B?TjBmbTdCVGxoQ0QxQ3ZtdDhaWFJ3SzFFWGcwTzlNK0hQOXhZVWNWZzlzMGQy?=
 =?utf-8?B?Q1lUa00zelNUTWV1eU91ZldhdG1UbGVJeFBTYURPZ2ZOZVVmRzJVaW9jMU9V?=
 =?utf-8?B?M1QxZEoxQ3BMbC9QblZWSjFGZy9lTTBkcVlHZjBaOFBvWVZrRnpDUkRlQVly?=
 =?utf-8?B?NDdWZkV1ajE1WXFBTkxPQUVhTzl6ZlJaOGgxN1VId0FJL0hZK29BMEpTYkh5?=
 =?utf-8?B?QkdhMk55VFRZRURlVlY4NU9lNVVLcTkzTnpaTWtVdFBBV2tkSUJoWlJtYm5i?=
 =?utf-8?B?ZUFzZ0UzS293SHJCYldKRDBLQk9qcGlvenlOVVI2aXFsQmZqQVMrS1Y2N2RU?=
 =?utf-8?B?cVhXUEcwQUc1MEN6V3ZSNlZUb2d3NUpTSzJHeHgrZ3c5SE4rMGF4UG1xNzVH?=
 =?utf-8?Q?/mylI+sQMM2ZIyxiBJLLQ/Pgx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7312069-0253-4eed-429d-08dd03743a21
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 23:46:28.4260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUbpdsK06KkECaxZXx5MUqH/OZ2PJskOOaWkgk2KJc2drH8oyMSAnsD4rG08c/OAWIQSTSB9jSphAoAf/QpS8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
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



On 2024-11-12 2:35, Zhu Lingshan wrote:
> On 11/12/2024 6:21 AM, Felix Kuehling wrote:
>>
>> On 2024-11-11 03:08, Zhu Lingshan wrote:
>>> On 11/5/2024 4:50 AM, Felix Kuehling wrote:
>>>> On 2024-10-31 22:35, Zhu Lingshan wrote:
>>>>> On 10/31/2024 11:30 PM, Felix Kuehling wrote:
>>>>>> On 2024-10-31 6:50, Zhu Lingshan wrote:
>>>>>>> The ioctl functions may fail, causing the args unreliable.
>>>>>>> Therefore, the args should not be copied to user space.
>>>>>>>
>>>>>>> The return code provides enough information for
>>>>>>> error handling in user space.
>>>>>>>
>>>>>>> This commit checks the return code of the ioctl functions
>>>>>>> and handles errors appropriately when they fail.
>>>>>> I have reviewed and rejected this patch before. My opinion has not changed. The existing code copies the ioctl arg structure back to user mode even in error cases because user mode needs additional information from that structure for some ioctls.
>>>>> how can the user space program distinguish the "good informational parameters" from the  "bad default legacy parameters"? There can be other user space programs other than thunk.
>>>>>
>>>>> what if the user space program doing pulling mode, it can pull the args changes because ioctl is usually slower, our code should be robust.
>>>>>
>>>>> usually the return code provides enough information for the user space programs.
>>>> I don't understand your concern. Even without your patch, the failing ioctl still returns the error code to user mode. User mode can safely ignore additional information returned in the argument structure. You are raising concerns about performance or robustness. I don't see that either of those are negatively impacted by copying additional information in the argument struct to user mode.
>>> Still the questions:
>>> 1) how can the user space program distinguish the "good informational parameters" from the  "bad default legacy parameters"? 2) what if the user space program doing pulling mode, pull the args before error code returned. Memory changes are usually faster than error code.
>>
>> There are no "bad default legacy parameters". Ioctls that were defined to return additional information in the parameter structure on errors have always done so. This should be documented in the kfd_ioctl.h header, though some ioctls have better documentation than others. For a good example, see kfd_ioctl_dbg_trap_get_queue_snapshot_args and kfd_ioctl_dbg_trap_get_device_snapshot_args, which do return the number of queues or devices in the parameter structure if user mode didn't allocate enough space.
>>
>> Another example is kfd_ioctl_map_memory_to_gpu_args and kfd_ioctl_unmap_memory_from_gpu_args, which returns the number of successful mappings if the ioctl fails. This is necessary to restart the operation after -ERESTARTSYS and skip mappings that were already completed.
> I believe these are bugs that should be fixed. If request N but only allocate M where M < N, the kernel space should return a proper error code and then user space should reduce the requesting number, like N/2.

That's not how these ioctls work. The ioctl needs to return data for all queues or all devices. User mode may not know that number ahead of time and may not have allocated enough memory. So the ioctl needs to be able to return the required allocation size in the failure case. This is what it's designed to do.

> 
> We must keep do defensive programming to reduce potential risks & bugs, keep our system robust, we should not assume the other side work perfectly as expected.  

Exactly. More information makes this easier. Removing information that has always been available breaks the ABI and does not improve robustness.

>>
>>
>>>> You mention that there can be other user mode clients other than Thunk. That's true. E.g. rocm-gdb calls KFD ioctls directly. And it depends on some of the additional information about errors. If you know of other user mode clients that are broken by the current behaviour, please point them out.
>>>>
>>>> Before anything else, we do not break existing user mode. Your patch breaks that rule. There is really no room for discussion here. I'm not seeing any reasonable argument to even consider your proposal.
>>> If a user space program needs to read arguments to do error recovery, then it is a buggy user space program that should be fixed.
>>> Usually the error code provides enough information for error handling. Why our KFD user space are exceptive?
>>
>> See my examples above. User mode is not buggy if it uses documented API behaviour, like what I showed above. In the case of -ERESTARTSYS, saving information in the argument structure is also necessary for the kernel mode driver itself, not just user mode.
> so we need a list to document what parameters are guaranteed to be safe to read in user space?

I don't think it's a safety concern. If you make it one, you need to define what you consider unsafe. From the kernel's point of view, user mode can do whatever they want with the data returned to user mode. If user mode ends up crashing because of it, that's a user mode bug unless the kernel violated some API contract.

That said, I did point you to API documentation that explains exactly what ioctl args contain useful information after certain ioctls return an error.

 And Kernel must always make sure the parameters are reasonable even when ioctls fail in the first place?> I am not sure this is a good practice, we don't see many drivers rely on this kind of design.

I disagree. You can see the same behaviour in drm_ioctl.c:

        retcode = drm_ioctl_kernel(filp, func, kdata, ioctl->flags);
        if (copy_to_user((void __user *)arg, kdata, out_size) != 0)
                retcode = -EFAULT;

	...

This is the ioctl handler used by many GPU drivers in the kernel, including amdgpu.

> 
> Here is an example explains why this is messy:
> 
> kfd_ioctl returns -EINVAL if the requesting ioctl number > AMDKFD_CORE_IOCTL_COUNT. Here no kfd ioctl functions are invoked, therefore the arguments are not touched, they are legacy values or random values, even all 0.> 
> Other kfd ioctl functions, like kfd_ioctl_create_queue and kfd_ioctl_destroy_queue, they also may return -EINVAL, but the arguments may be modified. How can the user space tell whether the arguments are modified by kernel, containing useful information, or not touched at all?

They know by reading the API documentation.

Regards,
  Felix

> 
> And what if the user space pull memory changes of the arguments?> 
> Thanks
> Lingshan
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Thanks
>>> Lingshan
>>>> Regards,
>>>>    Felix
>>>>
>>>>> Thanks
>>>>> Lingshan
>>>>>> Regards,
>>>>>>    Felix
>>>>>>
>>>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
>>>>>>>   1 file changed, 3 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>>> index 3e6b4736a7fe..a184ca0023b5 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>>> @@ -3327,6 +3327,8 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>>>>>>>       }
>>>>>>>         retcode = func(filep, process, kdata);
>>>>>>> +    if (retcode)
>>>>>>> +        goto err_retcode;
>>>>>>>         if (cmd & IOC_OUT)
>>>>>>>           if (copy_to_user((void __user *)arg, kdata, usize) != 0)
>>>>>>> @@ -3340,6 +3342,7 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>>>>>>>       if (kdata != stack_kdata)
>>>>>>>           kfree(kdata);
>>>>>>>   +err_retcode:
>>>>>>>       if (retcode)
>>>>>>>           dev_dbg(kfd_device, "ioctl cmd (#0x%x), arg 0x%lx, ret = %d\n",
>>>>>>>                   nr, arg, retcode);
> 
