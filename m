Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D4CC3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 03:52:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9C8D10E002;
	Thu, 10 Apr 2025 03:52:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vz+o/upN";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA1D610E002
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 03:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFD2lVLfKgZEPeDY9sW7fvTaO1LfPgctjFAJjaRly/waJNI+5v25xe/XLqVZLadu+b2z4XqDcKujUsawNeceIF03SwtK7Ef6OxydGJ305Wtnb1A75LB26wBJ0O16fPnaL6jWWCJAEuwrpo5OTpNBFT/C/qJPC3iqnppYzcuPYuQTSRBvuZVQrcJ1Quwo1hKNqUVU3EgKZseDJbWVJu1bxwqsgOPyH0+YbNmKeosOVH4vqZd2Xf0EcnQlYppf9bpbh40bM0WwCBOuoYAeo3QkJoPncTw/mR2LCQFzP716SYMjTh+s6PwJH/u/j8mnDMiJw52TQPF1F559eEzHCBpHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSKXUt2Mzl/kyOmv6MwXdUPF4jcxZpkp7H3kDmJkg4Q=;
 b=o9nlaA0UAc+yTh0ldqnohuSBf78IMP9tmVwqyAlN8JFZAIYB+pYMU0IB/tOEqHfUdV/WnpvD7OFXddcaWwX7Q2O9PVHk8FWfyqBo4RqJH+JjdcFOPS0RG6vUSA7oaLJ6OglsgUx8H3jH21VsroKvfXco0Hd+YyjKR/aQbfAAFBt4/LhOU0WcUQHEsHK39QRxvhfO41oOobL7+2FMh/3l800EhCnJ1fcFlesF7iiPap2SLj4EkPjj7hmQoRHrRby0k36k2JSo9S2YGgaRgf0ss7LU24ks6kDyG5xZ8e//45ZF42PDyLsurhvmFrtqTlTduUAdbHFe6CLaZBc4vw20YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSKXUt2Mzl/kyOmv6MwXdUPF4jcxZpkp7H3kDmJkg4Q=;
 b=vz+o/upNSFFRpRT0y3JgyAgjbylkdv5RtfX8Q0IPZedmtk3MHi5ugLCeswwsaN/QQubAAar1GDBdR5J7TfjXHn/tiFQr41N0u2fYxqms+MgRYJwiv67Qps/Uzozr9ODfpOTrjG5Lb+REzc4betGQCo+yizCU2QAziJE81xrQNtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS7PR12MB6216.namprd12.prod.outlook.com (2603:10b6:8:94::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.21; Thu, 10 Apr 2025 03:52:12 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 03:52:10 +0000
Message-ID: <16c1d7dd-848c-4c5f-8581-c5d784029ee0@amd.com>
Date: Thu, 10 Apr 2025 09:22:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: cleanup amdgpu_vm_flush v5
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250409104500.2169-1-christian.koenig@amd.com>
 <965773b6-40fd-481e-8699-ae7234cc1934@amd.com>
 <c2270a3b-943d-477d-9220-593e05631d82@amd.com>
 <65d607ab-3d65-4d08-9ac2-49f3228b195b@amd.com>
Content-Language: en-US
In-Reply-To: <65d607ab-3d65-4d08-9ac2-49f3228b195b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::13) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DS7PR12MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a3941e-42f6-4138-f381-08dd77e31243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dk1lL1Z4L0VvODhvcnA5WElxQ2xxMW1jNEZBNDBvVHpQeFRiNzF4ckVTT1BB?=
 =?utf-8?B?MTc0QjYvb2JCMlJzSzhURThnRVRUZ3g0MC9kUUpuZmpsUm1Ia3ZZUjBCNDJ4?=
 =?utf-8?B?TUI2ckM3ZDFmWHdjcmN6dnFpRnlLM1BXelJOd0R2REc0V2tEUU44Nzdwc0J1?=
 =?utf-8?B?QTl1ZkRwcmVJL0VRd1VxRGJWWk83c24wZUpsZ0dBNForUVZxR0M2RDl0bENV?=
 =?utf-8?B?b0hlcGY5Wko2bGVpNC94OVM1eVJ6Qk0wa3pPY3c3Tlhoc1NvRVFHSEc0VlVS?=
 =?utf-8?B?SVFkaVcrSWp3STR3Q0hHbWNnSDZESVVlYlVPdkdJemlxREEwQWRxaGwwQ1FP?=
 =?utf-8?B?SC9kNnZ4THg5dTF3d2Z5ejh2L0UyblZ1QVI3QVBQRTQwMjFnY05Na2ptcjdQ?=
 =?utf-8?B?bGl1UDRWUjZJdU91TXJuQitvaVZRRUpaeW5IemF2OGNQNmVTNlJDVGo5YStj?=
 =?utf-8?B?N2puRmJtQjFCNnljaEhnMW02bmNVQjJXRnBleWZMeFpSTVFBU05BMmdjNzFL?=
 =?utf-8?B?cVd2UlFwd25IMEZBQVNPVjlyVGxEMGxwSnhVRDlBYmxDckFzTFM5WkpMRkJO?=
 =?utf-8?B?b3J3K2w2RlhVRXFhN3V6OGdnV3V2L0FtaG92TEJQYVdGRUUzZ1hGZDcyUHha?=
 =?utf-8?B?TWRKeU5DV09XZVNNVDJYbUlaSlJ5NG5qRndKTDhFM1ZxUzRORElPQmF5MnV4?=
 =?utf-8?B?eVVTQ3dQOWE3alU3bEtsd051NDkzNkhHaWQ5cnIyYTZmNlIyQmIyV0VuZnpP?=
 =?utf-8?B?WFpreXdMbTVCWmRRZHpZNE1SKzdlNlR2YmNHNEt2dWJGdmx1Y1F3cWlCTlZI?=
 =?utf-8?B?a0x3MVRlbGFPVDg1TTBocGtiNEowKzVRczlBS0x3U0pLdGdzRThZZ3poV1hx?=
 =?utf-8?B?a0Y3SlV1ajJNVGd5YjM2S2hJYnAzdmVJTVl3eVowUUpNWmUzZ3JiOHRydFMw?=
 =?utf-8?B?QmF1SUt0YS9sM3p3SkcyUWxOT04xOVJkc2d5MUFubDh2TTYxOGRzMTRvTVpO?=
 =?utf-8?B?d3dpZmpQa09MUGpnNzlkWjcvU3A5SG5zMG10bmlIR1lPVzRiZDZvR1FrRWlh?=
 =?utf-8?B?cDhmR1IraG8yQTBSQUVlRjZwbnUyN0ExOCtYVlNtNDQ3RE8vUHZXQ0NkcXhs?=
 =?utf-8?B?dkZEOEt5MENMbFpZWm1EK0FvZkdSSkZEVkJRN2JsdXErMHVHUkNXOXFLRXVV?=
 =?utf-8?B?UWpYcXdJTVdtWTlaOTFNaERCQ0toOEpQY1FUQmlWR3F2MTRUcjhMTmxiaHlj?=
 =?utf-8?B?bnIwYmwwUzdLSlVhbFNENEUwVktnRjRUNmtsSC9rRkZrMEx0dFFxUHRmeTZo?=
 =?utf-8?B?ajZadTRIWkZ0a0NpUnpObC9YU3pMRVhaMFJXOTQ2Qis4alNhdFpjcW1RaENN?=
 =?utf-8?B?bnpuTVB6ZjdtbGZJdUhQRXZINHAyS3YySzVqTEpGMWVJY1cxd1JCa3pLK0VR?=
 =?utf-8?B?TzEvRWVPd01nRURPWXp6V05aYml4VWdPNTRpVHoyQ1NqZDR2bDBzL1FyR2Nk?=
 =?utf-8?B?RGZQQXpyYUhuaFpBcUw0S2ZWVlJqNGlpYyt3M1A1dnM4S2o1Y1UwdDFDaExL?=
 =?utf-8?B?eHVaM3RCSEovVW5Ub25hT0k2YkREQldRcCtiTlRSYzVrN09aUkpxOVYvUzFo?=
 =?utf-8?B?MWZlRkRIV0xwSVN0YTVNWHdKNk45Tks3NitYRCtwVjJ1bC9IQlp5eDJCN2hh?=
 =?utf-8?B?S05kRS85R3E0R1N4ZXVQcjM2djhDeWs5UlBnTFFrZ0NFNS8vYjNWT1F5eTMx?=
 =?utf-8?B?dE1GVW9RRHhDd25QZWVlQjBuS1hnNzM3L1lSTjdsTlY1Y0lRU1RWY0ZES2Qy?=
 =?utf-8?B?TUhrQUJsZTNkbGpXTFhUc3AyRzhQYkxTOFlKYXZrUG1wMFVFd2xjRERGS1RL?=
 =?utf-8?Q?Cm1mtp19VCkNh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm1vLzdOLzhTVkxoM2F5T3QyR0x4Y3dmdTVCNU1mNm5tM2xEb1A0YloxcVdC?=
 =?utf-8?B?eWFvVkRPU2Q1cGJmSVg0anlHNUxCZDZnZ0UrYURBUUUraTBGa1JqM1Nnd3la?=
 =?utf-8?B?Zkt3NTJNOG9WUjdIak5aaHByc1BVUjhyeTkzWmEvT0paU21Nb3lLcHdvelh4?=
 =?utf-8?B?cW04SGQraU91VW1DbTdRWExONmJDcm5vdytuR1l1OTJtcmhVZHdIeXRKWVV4?=
 =?utf-8?B?NHBBV2tsTVJkM1VxNEk4dDJFVmx0VGlLaTFtczhJcUJsU1RKNzczQUoxd0J2?=
 =?utf-8?B?MWlTb0pXMHBvYkhZd1RBeTNRdWdPY1ZNem82bktTNW1acU54QWxDWnpmR1BB?=
 =?utf-8?B?ZlB4V3BUNnlSa0VHRS9DNmJXUStnNk9FYW9pQ3UyRnNReFVXdjhqWERxQ2Js?=
 =?utf-8?B?WkFPRlI2ODRpWEdkRWl2cDRlMnJ4a09ZOTFDbEgvNWhla1ZPS3pDZWllcEJj?=
 =?utf-8?B?ZWJ0WGF5ZUJZNzYzRkh4UmVtTFJNTDh4OHNvZGpWdEk3eTczR2RFbkxvb01X?=
 =?utf-8?B?UktrYURmRG5Lb1czWFFQb0xwNVZMNmRTNTNiTXJhUTJpTm5xdStDZzZXWUVk?=
 =?utf-8?B?SnZNek5pVTY0QTVsZlE1VEkwcGdUcTlreklRY2xvSzJTWEg4TXpMZ3EzU0ZC?=
 =?utf-8?B?VFR6amlUQ0tCdFh0VVN5TEl1WnpPTStNeUJ5Z3dYajBUL2ptem52SHZFei9C?=
 =?utf-8?B?RXdyZS9WY3BuZ0k1Q1ZHWTh3UDZhZU9ya3VGaUhBb1hiOVBHcG1CNmFmV3Qv?=
 =?utf-8?B?SytzQlFXTnNwZEExOTlQeU82Vko0MWVweE9zR0trSStURit4dGx1MzJQbVRr?=
 =?utf-8?B?THpXNVMvSDlRYjgrSnpMbWo5UXlmUlRldVdmcERoVFhpQVpnNmFodjFpZlh3?=
 =?utf-8?B?WWs5Mzg1T2ZYZHkwdk5SUndWNXJ4cGQ4RWtldk1Fb01YZXlmaldZMHp6ZjFr?=
 =?utf-8?B?TDNUSml6eHNYUXNKUzVncHorNDYxQlg3SDRqbUZKbVFWMXlTYWNnbmdWMzl1?=
 =?utf-8?B?cEtheGxzMnFpUkNSV0p6LzBoWmVxa0d2dXovWURwdDVqcFMwU1hUNDR5M1hF?=
 =?utf-8?B?ek94N2VxWU1yUm9KTFhUcG4zUHUxVCt1UGNyYy90ZmtEUXlCZlRNKzFjYndr?=
 =?utf-8?B?c29DT1ZsZDhtQkVvRzBsZ2pzdjJMdFN1Y3QzbG91ekV3OW1RbnNPbnc1R1Bj?=
 =?utf-8?B?TFJheXFzNHdGcGMwbWluMmFkWldtaEpEN1VkUWFlMG1yTXRodGN1TmI5MG9p?=
 =?utf-8?B?SExLT3FUaklCQ3I5TXY4QkZuVDBySTlwU1NFWkZDTi9SVEdvLzhPRDNBMytQ?=
 =?utf-8?B?cThIL1VsOTNzRE4yMzRDbXhrUU5xdURLQk5obVJrWG9tOWZkbVBoOC9EVElE?=
 =?utf-8?B?WHQ4ZnFwVnQ3Q3U4RW9qUWZzcjZGSHA5a0Z0ZzNTVDVNOFRIYnZ3eFdEK0Iz?=
 =?utf-8?B?VEZyTEQ3OFZoaUV6ZTIwbXYvcVY1MEMzbjBueDNpYUpoNXJYNjdhV1Jrbmpp?=
 =?utf-8?B?Y1Zhems5aXVBaHQ0cnZSUVZZeXNNMklaYVRyaVFqdXloRFFEaURVZ0hOVnZy?=
 =?utf-8?B?TXlMR2JTVmhteld5b2hJYmVYajhNNGY2RnpCME5HTUxHUjFnVnpvM0E5VG5q?=
 =?utf-8?B?Vy9mMXFLS21BbnpQdTM1NENJMCt5R0xUTkZpRXp4a1J3eWdYVm9aeUh4SWZp?=
 =?utf-8?B?QmcvN1ZqUmU0Z253M2tlOEFhMGk5NmJXcld0R21KSVRBa0NxT01pekZSTU0y?=
 =?utf-8?B?V3VnVGJTcjUwbFJHQ0dkbnoxNEZDakg1NnNhQU0xdU9vVXM5TlBaK2pndk1l?=
 =?utf-8?B?UDF1bHY2ZnFIeEU0ZTRCMnA3aTdydjNtTlB0L2hjdENSdG9BY2F2L0tNZHlE?=
 =?utf-8?B?bmUzK2lGeTlkRFhXanJadGl1VzROR0IvY3huM0loUmR5QVVWNklKUS82K2RX?=
 =?utf-8?B?dDhheEkvTUM3djI5Q09NWEtWMW85c1RsRDErMEJxYW9QWXNML3VCdGdVOXpx?=
 =?utf-8?B?QUZQV3BJb2FnV3hia3BmbGZ6STQwM2NGdlM2dVpVOVlGOFQxSXJQTzlYRGJr?=
 =?utf-8?B?R1N6emhmbzMrMDZYWkZPOFdZR3hsWnVPOFlBeGxoK2RzNjUzVHA4Y0FJd0FO?=
 =?utf-8?Q?/OV3zLl55ZBTvcaWQG2phITOX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a3941e-42f6-4138-f381-08dd77e31243
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 03:52:10.7819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKUVDbuDFtIB4KlL4CHl00Pii9Lvkp44ZUhF2luzYf8ZOd6tNZwjJjRi3M7LXrqD+NmV+OvXeBs9jtZcwL4Aew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6216
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


On 4/9/2025 7:16 PM, SRINIVASAN SHANMUGAM wrote:
>
> On 4/9/2025 7:11 PM, SRINIVASAN SHANMUGAM wrote:
>>
>> On 4/9/2025 6:45 PM, SRINIVASAN SHANMUGAM wrote:
>>>
>>> On 4/9/2025 4:15 PM, Christian König wrote:
>>>> This reverts commit c2cc3648ba517a6c270500b5447d5a1efdad5936. 
>>>> Turned out
>>>> that this has some negative consequences for some workloads. 
>>>> Instead check
>>>> if the cleaner shader should run directly.
>>>>
>>>> While at it remove amdgpu_vm_need_pipeline_sync(), we also check again
>>>> if the VMID has seen a GPU reset since last use and the gds switch
>>>> setiing can be handled more simply as well.
>>>>
>>>> Also remove some duplicate checks and re-order and document the code.
>>>>
>>>> v2: restructure the while function
>>>> v3: fix logic error pointed out by Srini
>>>> v4: fix typo in comment, fix crash caused by incorrect check
>>>> v5: once more fix the logic
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  6 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 94 
>>>> ++++++++++----------------
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 +-
>>>>   3 files changed, 39 insertions(+), 66 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>> index 802743efa3b3..30b58772598c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>> @@ -189,10 +189,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring 
>>>> *ring, unsigned int num_ibs,
>>>>       }
>>>>         need_ctx_switch = ring->current_ctx != fence_ctx;
>>>> -    if (ring->funcs->emit_pipeline_sync && job &&
>>>> -        ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
>>>> -         need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, 
>>>> job))) {
>>>> -
>>>> +    if ((job && (tmp = 
>>>> amdgpu_sync_get_fence(&job->explicit_sync))) ||
>>>
>>>
>>> Direct assignment in if condition looks like may not be allowed, may 
>>> be can we split this logic , something like below:?
>>>
>>> /* Check if job is present and get the fence */
>>> if (job) {
>>>     tmp = amdgpu_sync_get_fence(&job->explicit_sync);
>>> }
>>>
>>> /* Check if pipe sync is needed */
>>> if ((tmp || (amdgpu_sriov_vf(adev) && need_ctx_switch))) {
>>>     need_pipe_sync = true;
>>>
>>>
>>>> +         (amdgpu_sriov_vf(adev) && need_ctx_switch)) {
>>>>           need_pipe_sync = true;
>>>>             if (tmp)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index b5ddfcbbc9fc..8e99dbd70968 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -596,37 +596,6 @@ void amdgpu_vm_check_compute_bug(struct 
>>>> amdgpu_device *adev)
>>>>       }
>>>>   }
>>>>   -/**
>>>> - * amdgpu_vm_need_pipeline_sync - Check if pipe sync is needed for 
>>>> job.
>>>> - *
>>>> - * @ring: ring on which the job will be submitted
>>>> - * @job: job to submit
>>>> - *
>>>> - * Returns:
>>>> - * True if sync is needed.
>>>> - */
>>>> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>>>> -                  struct amdgpu_job *job)
>>>> -{
>>>> -    struct amdgpu_device *adev = ring->adev;
>>>> -    unsigned vmhub = ring->vm_hub;
>>>> -    struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>>> -
>>>> -    if (job->vmid == 0)
>>>> -        return false;
>>>> -
>>>> -    if (job->vm_needs_flush || ring->has_compute_vm_bug)
>>>> -        return true;
>>>> -
>>>> -    if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
>>>> -        return true;
>>>> -
>>>> -    if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
>>>> -        return true;
>>>> -
>>>> -    return false;
>>>> -}
>>>> -
>>>>   /**
>>>>    * amdgpu_vm_flush - hardware flush the vm
>>>>    *
>>>> @@ -647,43 +616,49 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, 
>>>> struct amdgpu_job *job,
>>>>       unsigned vmhub = ring->vm_hub;
>>>>       struct amdgpu_vmid_mgr *id_mgr = 
>>>> &adev->vm_manager.id_mgr[vmhub];
>>>>       struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
>>>> -    bool spm_update_needed = job->spm_update_needed;
>>>> -    bool gds_switch_needed = ring->funcs->emit_gds_switch &&
>>>> -        job->gds_switch_needed;
>>>> -    bool vm_flush_needed = job->vm_needs_flush;
>>>> -    bool cleaner_shader_needed = false;
>>>> -    bool pasid_mapping_needed = false;
>>>> -    struct dma_fence *fence = NULL;
>>>> +    bool gds_switch_needed, vm_flush_needed, spm_update_needed,
>>>> +         cleaner_shader_needed
>>>
>>>
>>> I think, should we initialize the "cleaner_shader_needed" here, 
>>> cleaner_shader_needed = false?
>>>
>>
>> or somehow, try to move below to here?
>>
>> "     cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
>>          ring->funcs->emit_cleaner_shader && job->base.s_fence &&
>>          &job->base.s_fence->scheduled == isolation->spearhead;"?
>>
>>>
>>>> , pasid_mapping_needed;
>>>> +    struct dma_fence *fence;
>>>>       unsigned int patch;
>>>>       int r;
>>>>   +    /* First of all figure out what needs to be done */
>>>>       if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>>>> +        need_pipe_sync = true;
>>>>           gds_switch_needed = true;
>>>>           vm_flush_needed = true;
>>>>           pasid_mapping_needed = true;
>>>>           spm_update_needed = true;
>>>> +    } else {
>>>> +        gds_switch_needed = job->gds_switch_needed;
>>>> +        vm_flush_needed = job->vm_needs_flush;
>>>> +        mutex_lock(&id_mgr->lock);
>>>> +        pasid_mapping_needed = id->pasid != job->pasid ||
>>>> +            !id->pasid_mapping ||
>>>> +            !dma_fence_is_signaled(id->pasid_mapping);
>>>> +        mutex_unlock(&id_mgr->lock);
>>>> +        spm_update_needed = job->spm_update_needed;
>>>> +        need_pipe_sync |= ring->has_compute_vm_bug || 
>>>> vm_flush_needed ||
>>>> +            cleaner_shader_needed 
>
> Sorry here pls:
>
> "     cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
>          ring->funcs->emit_cleaner_shader && job->base.s_fence &&
>          &job->base.s_fence->scheduled == isolation->spearhead;"?
>
>
>>>> || gds_switch_needed;
>>>>       }
>>>>   -    mutex_lock(&id_mgr->lock);
>>>> -    if (id->pasid != job->pasid || !id->pasid_mapping ||
>>>> -        !dma_fence_is_signaled(id->pasid_mapping))
>>>> -        pasid_mapping_needed = true;
>>>> -    mutex_unlock(&id_mgr->lock);
>>>> -
>>>> +    need_pipe_sync &= !!ring->funcs->emit_pipeline_sync;
>>>>       gds_switch_needed &= !!ring->funcs->emit_gds_switch;
>>>>       vm_flush_needed &= !!ring->funcs->emit_vm_flush &&
>>>>               job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>>>>       pasid_mapping_needed &= 
>>>> adev->gmc.gmc_funcs->emit_pasid_mapping &&
>>>>           ring->funcs->emit_wreg;
>>>> +    spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
>>>>         cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
>>>>           ring->funcs->emit_cleaner_shader && job->base.s_fence &&
>>>>           &job->base.s_fence->scheduled == isolation->spearhead;
>>>>         if (!vm_flush_needed && !gds_switch_needed && 
>>>> !need_pipe_sync &&
>>>> -        !cleaner_shader_needed)
>>>> +        !cleaner_shader_needed && !spm_update_needed)


Here do we need to explicitly add this  "&& !spm_update_needed" check 
here along with the other checks pls? cz pipeline_sync is independent of 
"spm_update"?


>>>>           return 0;
>>>>   +    /* Then actually prepare the submission frame */
>>>>       amdgpu_ring_ib_begin(ring);
>>>>       if (ring->funcs->init_cond_exec)
>>>>           patch = amdgpu_ring_init_cond_exec(ring,
>>>> @@ -703,23 +678,34 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, 
>>>> struct amdgpu_job *job,
>>>>       if (pasid_mapping_needed)
>>>>           amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>>>>   -    if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
>>>> +    if (spm_update_needed)
>>>>           adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmid);
>>>>   -    if (ring->funcs->emit_gds_switch &&
>>>> -        gds_switch_needed) {
>>>> +    if (gds_switch_needed)
>>>>           amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>>>>                           job->gds_size, job->gws_base,
>>>>                           job->gws_size, job->oa_base,
>>>>                           job->oa_size);
>>>> -    }
>>>>         if (vm_flush_needed || pasid_mapping_needed || 
>>>> cleaner_shader_needed) {
>>>>           r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>>>>           if (r)
>>>>               return r;
>>>> +    } else {
>>>> +        fence = NULL;
>>>> +    }
>>>> +
>>>> +    amdgpu_ring_patch_cond_exec(ring, patch);
>>>> +
>>>> +    /* the double SWITCH_BUFFER here *cannot* be skipped by 
>>>> COND_EXEC */
>>>> +    if (ring->funcs->emit_switch_buffer) {
>>>> +        amdgpu_ring_emit_switch_buffer(ring);
>>>> +        amdgpu_ring_emit_switch_buffer(ring);
>>>>       }
>>>>   +    amdgpu_ring_ib_end(ring);
>>>> +
>>>> +    /* And finally remember what the ring has executed */
>>>>       if (vm_flush_needed) {
>>>>           mutex_lock(&id_mgr->lock);
>>>>           dma_fence_put(id->last_flush);
>>>> @@ -749,16 +735,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, 
>>>> struct amdgpu_job *job,
>>>> mutex_unlock(&adev->enforce_isolation_mutex);
>>>>       }
>>>>       dma_fence_put(fence);
>>>> -
>>>> -    amdgpu_ring_patch_cond_exec(ring, patch);
>>>> -
>>>> -    /* the double SWITCH_BUFFER here *cannot* be skipped by 
>>>> COND_EXEC */
>>>> -    if (ring->funcs->emit_switch_buffer) {
>>>> -        amdgpu_ring_emit_switch_buffer(ring);
>>>> -        amdgpu_ring_emit_switch_buffer(ring);
>>>> -    }
>>>> -
>>>> -    amdgpu_ring_ib_end(ring);
>>>>       return 0;
>>>>   }
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> index daa2f9b33620..e9ecdb96bafa 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> @@ -493,7 +493,8 @@ int amdgpu_vm_validate(struct amdgpu_device 
>>>> *adev, struct amdgpu_vm *vm,
>>>>                  struct ww_acquire_ctx *ticket,
>>>>                  int (*callback)(void *p, struct amdgpu_bo *bo),
>>>>                  void *param);
>>>> -int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job 
>>>> *job, bool need_pipe_sync);
>>>> +int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>> +            bool need_pipe_sync);
>>>>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>>>                 struct amdgpu_vm *vm, bool immediate);
>>>>   int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>>> @@ -550,8 +551,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device 
>>>> *adev, uint32_t min_vm_size,
>>>>                  uint32_t fragment_size_default, unsigned max_level,
>>>>                  unsigned max_bits);
>>>>   int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct 
>>>> drm_file *filp);
>>>> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>>>> -                  struct amdgpu_job *job);
>>>>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>>>>     struct amdgpu_task_info *
