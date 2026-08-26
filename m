Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820E5C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 09:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 039A910EC7C;
	Wed, 26 Aug 2026 09:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GMIoH3cs";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BD3A10EC99
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 09:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IucV0xzYHVyqY81hx/jcwxYRHo0tp2S0Zrsn0RndwRPRejKI8EdmxHLRv4nxDiFWA6KAxaFrC9XG/fbDzbnsnrhHxvDkZA/4Oxq/WmTr/+mszHD+tQntd2avJqWpfG3r2ilMGFOUC3idAND12YI1/eLWy3TPWl1xC4TrlBk5ZP2SBU/ji0tKSLrjoC/3m7+KClb2IZ+DsX0ELEn5cCLjKmsmkO1yYm698RIiRTrlhbJrpWJG+EFo0JuLVYiA5WB9BFcN9dpPFDvXXBobw8wxVA3WPkPyT/u+H860VJQWa78ivnN8j1e/am9hZFudfaYOjQeR804YepiiJ1t+M20J9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX59Icw62pG5VWNaiFY2gm3XmZLh7phDsXs7r8PJx78=;
 b=mmkl8GgBtOTdg5JalZD15WG3b8O/hewKmHGpd917wJwzN3KRxxVzFdx69ngltPgQ3erysZZ4BxHm1gW7Hkt2ioCfOH5gxokyzlz7y7c2AuOJGIKdvCstAkFpdt/r3rPEBGClcuNIEO9no88xw4hW0unCI67t9OIp8AU3y2qoWRuY+AhUmpvMeKyJZVewiCkyYA3z0X1zxgzVyhiMu0se7k+31/gSQGer/9SMqytK7bz9QhS++Ni83xTiB62Hq+J881qcUwEeDp323KTEtv5hkM/bsnRi+lnR0HP0MnzjMJs+zpWLlZJ0gwgN7jmdg03Kw9CeJNq4bMtpaJgOV2g3jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX59Icw62pG5VWNaiFY2gm3XmZLh7phDsXs7r8PJx78=;
 b=GMIoH3csFOE8TQq0AEFDBLMB2lvggFUMf933V7bTWLu+JvDwXeWChUfHOvvmmuK5RTeqLUpeYfSxogco6j97QTusd4Ip+ROAXbB8n1RusmU/OlAGI/eZwXTtH5r6ZIjklKFVXUqlMDLLqudAPXTxDOLHP2vDec6sJvMwy3lKMGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Wed, 26 Aug
 2026 09:49:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 26 Aug 2026
 09:49:42 +0000
Message-ID: <9f72d52a-a157-44fb-abdf-959533390cbe@amd.com>
Date: Wed, 26 Aug 2026 11:49:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] drm/amdgpu/uapi: Add second-level trap handler
 ops to VM ioctl
To: Natalie Vock <nat@pixelcluster.dev>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhu, James"
 <James.Zhu@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Six, Lancelot" <Lancelot.Six@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Samuel Pitoiset <hakzsam@gmail.com>
References: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
 <20260820070143.3916329-2-srinivasan.shanmugam@amd.com>
 <6dcd3e9a-b308-44c6-a9cb-4bca149a2fde@pixelcluster.dev>
 <IA0PR12MB82080BCDF88122DD4E767E1390AF2@IA0PR12MB8208.namprd12.prod.outlook.com>
 <44857ea2-7f39-4088-9209-ce21ddaf8987@amd.com>
 <16d7dd0f-5622-4524-8522-62b7e6d40a0c@pixelcluster.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <16d7dd0f-5622-4524-8522-62b7e6d40a0c@pixelcluster.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0354.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: 5977389d-f6d1-49d0-6073-08df03575a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: d+XuiVvdNk7kX2/pETF9KGkiwBXTmMXgYiVXdn99YhefzK4v4niWhpRKZP9GINKBRpztpmo/2bBr6j3FmK3TZ7kWVIeoPZnexnMO+Shfl8ypiLE0N76BJVRe8l2BcNQkca7RNz5VYTLRNCKNyvSSAqtivMrTPgz6YgBC9Tn6bKhRLkfM/Zi41JKVBPh+jJpcf0uXzTMr7FsLqniRbUoSQY5TZECvY8Rlh6RY+ns7/Z6zj4gic0oD4VUvjnbmaWxh1ddVV8BLYD82ACWS4IqcnK750JsOISZDEAtETbTtgmkmlNs07sesF+Xx4OzedMRXtZ0QjN2SCNAIMNvbxQU7aU0HA+CmzLNuvlGmzJRd5O5D4OMscVbqsuu5MLIg2JpJVtENHQiVoL/+9SCmJi0CIr0VKdUs0fJjjmJUOaBnM96zfJk6rWkmBmpE0CJVtCZKfn3H7oihDEJnndp31cOLfmVWxowHzc+luxC7DLwNNjLvsuTcdRfm8wSRB96PD4o5sETAnDn51mySXfMXkP9K7CwMVu0sYC6AaGOyV5bkn+cRLw3tdPtCgp1ucR5wlJdKJln72j3QKfkKbkisavyM93hyQNLNHm9EBrDWZzhG1lSlz1XZ5fLSvTWXkgSZMJGl9wSK28JMBYA/rniQf5+BSufOUppyXZzEj6CimtxTe24=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vkd5SVEvSVIzR1R3MnRrNzlpbmJmb3pLVTc1SDFnVk9helJPZ21BM2IveTR4?=
 =?utf-8?B?bjhGNFl6Mjl3TDUxM0prV1pzYzBBOEs0ejFmTnpVTEpIcVY0NTJrRFN3SDNZ?=
 =?utf-8?B?eDRHdmgxVm82anIvd0dkbWdaTGgwOVBjZ2xUUlJNQklXcUdWejhBUDJKd1VE?=
 =?utf-8?B?WXhJZjFxQjVpc3ZRWVUxbVkrSnduVnBERnI5d1hpN0hjOXVONnAxVHRwZit3?=
 =?utf-8?B?aWpoRCtkK3BpYnBwQjVFcDVSN1hRcS9HS01mZGFXQU45U3NBdzh2TDBTczVF?=
 =?utf-8?B?WXNaWVJkU2VUbWJUVUxab2R3bVE5UjJaeERRYWUzNGgySDFIVmllejFUTUta?=
 =?utf-8?B?K1crSE9TMy9sd0I2ekp4emUyb0xGeHJIQjZ4Z2h1NlNuWmxzMWYwWW9nUmZz?=
 =?utf-8?B?MXpXRG1RM003d0taYTR0R2Z1aFM4UkswUEc3WDM3M2pQcFVwaCtVV28xeTg3?=
 =?utf-8?B?MTNpVzhDK3BwMmVDRCs0L1JHMmhIWGc5ZUdmU1ZPSTJNalVGMS81V3d1d2pw?=
 =?utf-8?B?MjBtR3RRMzRCNXVWT3FaN3NhdzRiWi91ZzM0em5ac0NrTHJSeVpJcEllamM2?=
 =?utf-8?B?Nm1BNENROWYrR3I4K2ViSWNYOEZSWEJNSjNTbTc5VENlTnZmQUlBU01SQ1Ft?=
 =?utf-8?B?SEFMSjFIK1ZVMm1OcmlpTHRtbXFkRjREQnVrcEViQ0JJWW9YMUVqdzFFZmhG?=
 =?utf-8?B?cXIvSmtkMXNqOVlCNlR6SkhwR1AzaHFVTnE3a3VuQWgyRGJFRzRFNWNSNFM0?=
 =?utf-8?B?bXoweXdKNXA2WHlBWGJ0dmhRQkxEdVpnMTgzOUdOdFpvUkhRdGFIcHRKR1hK?=
 =?utf-8?B?SS8vMHZWYTdGbWFRclUrZC8ySUQ4eFpxbkFaL0hvM3IzLzRvY1JOMWRSczM0?=
 =?utf-8?B?YUJnZk5ZS2JIVFRROXNNcXVzeTJNcnhORFRLcEc2NE9EUmNNVWJBUUdsUTFY?=
 =?utf-8?B?ZFZvZmNVVDQyNFhTWDVvUjNuQzdwWk5PSUxzTEtHZGl0UXBKaXluRHN5UjVt?=
 =?utf-8?B?TURpUXhVQjVHalZnSE82WUoyQ3U1V1BaeHQ1Ukhmb3E4Zng5U1FLeVhIVWtQ?=
 =?utf-8?B?OXBSdTNSZlBvUEVYdlVXVGU5TGkvWE9qNEhPcG5oNTNpWGFLbFRRMHdEQURU?=
 =?utf-8?B?d09ZVkMwVlhHL2pnRkpyNVZIVnZNU0FadGt2SG9IQ21lVU5QQk8xODFhcS93?=
 =?utf-8?B?OXlwSVk0L0Z4c0EwU0lRZFpEaDFMNzYvby96dTBwWm02NTM4aVJoYXhWWmty?=
 =?utf-8?B?WXc5TkZHNm0wODRNWTlPdHZEUTI3V1Y5UkJGay9hd2lBNDQ0WC93bml1Ymdw?=
 =?utf-8?B?bmh4MWVpUTAwSjFYYmxTUmV1cEIzdTgvQkM1QVphSXFzYTlMQWJ4L1ZuclV1?=
 =?utf-8?B?S09uZXdjYlBaSlhFK05paWFGV1gxSEowVnFuY2JwL1JjSkl4bTljN0l6Tm0r?=
 =?utf-8?B?RDBVcjM5Yk4rUjRrQUNGL1RNQTlsZzBrQW84K3VIYzEzRTNXZWltYVVCZ25Z?=
 =?utf-8?B?NEhNMVYxN25FNm9EQXdRYlZwTC9SNkZqQVRHVXdSR2ZxRmFtZGdya3FnM3hG?=
 =?utf-8?B?ZnowZkRkQmJvVTE3TFJhNTFtejgyQjl0bmUwZGtKR01TSWlMYjVFT3VMblRv?=
 =?utf-8?B?QmJCVEdtUzJnUGRHelExK2lKeUhvYUxkRUhLYjVNV0d2Ris5Tlg0RDNPa1or?=
 =?utf-8?B?NnpKcUhSZXFldDhMclB2aGM2cDMxUFM1L1VOQzZ4Vlo1bnY4b2t6ZnJKS29S?=
 =?utf-8?B?QmNVeEExcGpOdk9RZk44cXhEQ0FuSU9EMHFFblJVaHgyZEJ6ZmFyc2JqTUN5?=
 =?utf-8?B?YXdQdlJ2T1R2U1FRc29XVkgzUTVmVDdkcEVURTBSK1hqdjJ6VGltSE81bkZs?=
 =?utf-8?B?clI1dEwvbk1WY1JYVVN5Zm5rMHpVQTZkU1V3UXk5L1ZsZXIxN1QxUnR6SEVF?=
 =?utf-8?B?YzRaODRhMll1bnlwRzhDSUFHam5Hcnl4TkRuVTVtRXpuWm5VVVV5MFR0bDhi?=
 =?utf-8?B?OWNUNk1WMHlnc3R2NmJiL2pEMmEwMTFidXZrdnUzVHc0YW1hdVgvT1dqbzlF?=
 =?utf-8?B?Z1dDdURqUGZ5aXpoT3M4Q1QxVW9WVk5DYmFMdGJkYmZjZGxMM0tURnJrc1NE?=
 =?utf-8?B?RnBYOVFaV3Nxbk51U3VSd0RaeHJ4TlExTkZUNTJidS9rMWV5S0hjTlZiMHhF?=
 =?utf-8?B?Y3RRbFBxZU5mRG5GeC9ERUs4bXNKRFJJQkI2SFk4RE9VakZOa20zT0JpdUtK?=
 =?utf-8?B?L2xBbzd0a0oveVo4K0pNYkRTbzNudmpKWlBkOEJxSC96UjVvRmF2RkhydUw3?=
 =?utf-8?Q?nSAO4u0h9N0Q3rTDe0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5977389d-f6d1-49d0-6073-08df03575a3f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 09:49:42.2517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wjfthueyg2baeclcbwPR0Zk7Xp17TkHxEDFvSNYZeACTKn581+ElPFZkwTKEQqOe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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

On 8/25/26 12:13, Natalie Vock wrote:
> On 8/25/26 09:34, Christian König wrote:
>> On 8/25/26 07:05, SHANMUGAM, SRINIVASAN wrote:
>>> AMD General
>>>
>>>> -----Original Message-----
>>>> From: Natalie Vock <nat@pixelcluster.dev>
>>>> Sent: Thursday, August 20, 2026 3:29 PM
>>>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>>>> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>
>>>> Cc: amd-gfx@lists.freedesktop.org; Kuehling, Felix <Felix.Kuehling@amd.com>;
>>>> Zhu, James <James.Zhu@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Six,
>>>> Lancelot <Lancelot.Six@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-
>>>> eric.Pelloux-prayer@amd.com>; Timur Kristóf <timur.kristof@gmail.com>; Samuel
>>>> Pitoiset <hakzsam@gmail.com>
>>>> Subject: Re: [RFC PATCH 1/3] drm/amdgpu/uapi: Add second-level trap handler
>>>> ops to VM ioctl
>>>>
>>>> Hi,
>>>>
>>>> first of all: Thanks for working on this! It's great seeing trap handler support come
>>>> together.
>>>>
>>>> On 8/20/26 09:01, Srinivasan Shanmugam wrote:
>>>>> When a GPU shader hits an exception, memory fault, or debug
>>>>> breakpoint, the hardware jumps to the first-level trap handler. The
>>>>> first-level handler (managed by the kernel via CWSR) checks the TMA
>>>>> buffer for a second-level handler address. If one is installed, it
>>>>> forwards the trap to that userspace handler, allowing the runtime or
>>>>> debugger to handle shader exceptions without modifying the kernel trap handler.
>>>>>
>>>>> KFD already supports this for compute workloads. Render-node user
>>>>> queues had no equivalent mechanism. Add it.
>>>>>
>>>>> The second-level handler is a per-VM setting — it applies to all
>>>>> shader waves executing under that VMID regardless of queue type. GFX
>>>>> and compute queues from the same process share the same VMID, so one
>>>>> SET_L2_TRAP call covers all queue types for that process. This
>>>>> configuration is not CWSR-specific; CWSR is only the first-level
>>>>> handler mechanism. The correct home for this setting is the VM ioctl
>>>>> (DRM_AMDGPU_VM), following the same pattern as
>>>>> AMDGPU_VM_OP_RESERVE_VMID.
>>>>>
>>>>> Add two new VM ioctl operations:
>>>>>     AMDGPU_VM_OP_SET_L2_TRAP   (op = 3) — install second-level handler
>>>>>     AMDGPU_VM_OP_CLEAR_L2_TRAP (op = 4) — remove second-level
>>>> handler
>>>>>
>>>>> Extend drm_amdgpu_vm_in with a 32-byte union for op-specific data. The
>>>>> l2trap member carries the GPU virtual addresses and sizes of the TBA
>>>>> (handler code) and TMA (handler scratch memory).
>>>>
>>>> This should be a BO handle and offset+size, instead. The BOs associated with the
>>>> TBA/TMA must be tracked as used by every submission from the VM that has this
>>>> trap handler installed, otherwise you introduce a ton of race conditions. Off the top
>>>> of my head, here are a few:
>>>> 1. The GEM VA ioctl can spuriously fail to actually update page tables.
>>>>      This is okay and intentional, and BOs with outdated page tables will
>>>>      be updated on the next submit if they're used by the submission. If
>>>>      the TBA/TMA BOs aren't marked in the set of used buffers, the PTs may
>>>>      end up never being updated and subsequent accesses will fault.
>>>> 2. The TBA/TMA may be evicted/moved around concurrently with executing
>>>>      submissions if these submissions didn't add their fences to the
>>>>      TBA/TMA resv, which would likely randomly corrupt things or hang.
>>>>
>>>> A simpler solution could be requiring the TBA/TMA buffers to be
>>>> VM_ALWAYS_VALID, in which case synchronization to all submissions in the VM
>>>> is taken care of automagically. This prevents exporting the TBA/TMA to an fd, but I
>>>> don't expect anyone would want to do this.
>>>
>>> Hi Natalie,
>>>
>>> Thanks for the feedback.
>>>
>>> We will update the UAPI in v2 to pass BO handles alongside
>>> the GPU VA for TBA/TMA. This ensures the kernel can properly
>>> track and pin the buffers.
>>
>> Please don't. It is the responsibility of userspace to make sure that the BOs are either in the used list or valid per VM.
> 
> Oh, right, I guess we can do it this way too. That's fine by me, but I
> think my point about syncing TBA/TMA binds/unbinds in the same way as
> VM map/unmap ops still applies. I suppose for user queues the existing
> approach could be fine, but as Timur points out RADV won't be able to
> use this unless support for kernel queues is added.

There are also tons of HW restrictions this patch set needs to take care of.

E.g. you can hard crash the ASIC when you mess up the second level trap handler and we somehow need to prevent that. Srini is working on at least catching the worst userspace errors but I doubt that this is fully fixable.
> As far as I remember, it's convention that before merging new uAPI, you
> also have a userspace-side use of that uAPI lined up. I or someone else
> working on RADV can easily write that up, but for that we need an API
> that RADV can actually use :)

This is primary for ROCm now and if I'm not completely mistaken we develop everything on a separate branch (not amd-staging-drm-next) for now until the userspace parts are released as well.

I just said that Srini should CC you guys because you expressed interest in the trap handler as well.

Regards,
Christian.

> 
> Best,
> Natalie
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Thanks,
>>> Srini
>>>
>>>>
>>>> Regards,
>>>> Natalie
>>
> 

