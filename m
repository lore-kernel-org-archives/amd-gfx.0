Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C90ED58CC9
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 12:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED7E810E696;
	Tue, 24 Mar 2026 12:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5nF7k44U";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013039.outbound.protection.outlook.com
 [40.93.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6706810E696
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 12:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNiD/WMMGL6OoZ0ihNoXCQ6htxRe2SQm4rYiT9MONmD4ElFCiOfOKXDgpENM00U6GhNChJgmt44AScgi4142FuHZIGPkimtz1S4yKx+twouiqZqUYEE4cAhs40O7/dUHPaA9zuT7F8Qk0dpYKNfiF2sk9GVFDhvxIo1rv/Vh/rCLzh6b0n9m17oBx7Z1iB3fAV/Wx2/Vph6L7CYgqi2Z8v2IruSkYpwpU20Mll1FEEtsM2pAY930M4xFETUc2vppQZvsQiFqxw3UQcyeRgW2MdM80pJT9ub5Y3dZ0lE+1//Yamgov409vNOuHQw+1Cp/sY3Mo+FVdLZNvv5Nqf1P3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yu0M/j1ftpxy2idE8sFV22sJS334RWN6d1aOqqepBzU=;
 b=tnJ24h19FunNsHzQMZVqJH8QvXrUTdR615fC3SGrzBmCoSPmvNr2lwoOq++BDg0DQF6Fv+0o+1ZS7UwGZlfGs6zVGXgJrS5fuixyECQTcjhzpy8PWgcKrJcA+93GPX0UyC8Wk8w70p+sVkpExXabccmdMGg5jGvncxwY4uneIMRuvUUfxAHUQTvNXsDnxHO+9n0Tru30pllyskO8ip4XlrYMuTR6W+rpkMWzsCRNxVwdnHEUANkPinAfAZ4rhTiVf09DTrl0POH/P7cVCB5W680uSCa5CT9W3T+poOIiSc3FvXFolL3dti5gT/1huDPxoV9TFuOb9J40tvOnPse81g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yu0M/j1ftpxy2idE8sFV22sJS334RWN6d1aOqqepBzU=;
 b=5nF7k44Ug0Pz6EIulq1hGZDEe6hZniGJrU4NBeJCiyIbAzTI/yxpCGKG4MJyf3HnKCnSR7NGOdyQ37hgyrG12zyFaYH3qtyk91cEsfizscYNDl0Yo7z5LaR+t1/hzPVhGwezoHwpuoUeVp1m1LSkAO2rcWvrk44dfWpBV2t+na8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:38:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 12:38:21 +0000
Message-ID: <09e8488c-920d-444a-83f4-f8e751625da5@amd.com>
Date: Tue, 24 Mar 2026 13:38:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: guard atom_context in devcoredump VBIOS
 dump
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: Alexander.Deucher@amd.com
References: <20260324012618.626710-1-Jesse.Zhang@amd.com>
 <ad42e9d3-826e-41fe-9810-49824cc9a741@amd.com>
 <06240d38-2cc0-4d2b-beb1-fc7f8e5caf1c@damsy.net>
 <705540c3-f1d1-4abe-ba87-571e72118ea2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <705540c3-f1d1-4abe-ba87-571e72118ea2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:208:d4::37) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b10d75b-0927-44fb-e7f9-08de89a23b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: ozM0KSVyNYb1NKy0zKA2tYt/BKNY9HhnvLI704tMgf7M2tCluLA2eC0YThNPhJBk9M6VRjxn75wKTD+Q0yxbhm4SU3k4q2CHInNS4j9bxFgqHvzHrHbS0vtxZcZnecGG8LPlaEZYEFgqg5w46dP0fpr/eIUfTkFE+k+7ddjIo7DkF/Wm3ss9ZEH6DCMbN5PDb4zjw2Y/Lfk7UruehWciujahGXh4GDXLozinByYP2dv10ap98aGoTTVq34mkEGpcH8FVdX54yIIglAK8ZiW/fRZeY/U4761YlNGIjiJkXr/Wvg1OjeIY35qHoTWi2YGmwF0ITW4UUNGBdHkrIud3a/6E10YU1ZT3iA+zYlJ4GGVri+QK/j9uLnj3T4nSjlGcFB5xPV0E/kYnozKf9nse7VUqonuYBVeefyc/qZr7M/RneFrHQ4iq2zd7ImGdnAkD00NfxYgoia8HVMPVZsOybw5C2GpwCSm/j0jbcGIkzIFJfivIcl1A+eSdodXOC4fP5D3UJMXANH+ErSQ2htsTX4oQnuQDyKvHVc9IQVi7R4L5ERPkOcODIT/XJU/uQro0LrxSwhuQL8i02b/G9QGiv65ek5riLHRQ6bfJLB/YJZh122U+wCaWyA9H0u+prTkLa6KmEwMLAP7rE6jvm8MFS5erbatUBupcd1qmKSwhghOkJjbP0o1HrHGgAUlUwNb/nk7nPye0TfCPRq8IyRo9mKwy2DCXUkqiZl4xO3ezVbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDRNeU8xVXpMcng2RVRpRmxjVDlIUFFaUzhTaHR0UUFtVUROQXVXUmRNMFcz?=
 =?utf-8?B?QzZvejBETk44ZTJKYzBYbWsyczkvSlFFSlJDekR2NmNrcyttNmUzcE1DMStI?=
 =?utf-8?B?WExkM3BrNGJKTTdueWNpNEpGNHNTUVFrOTZ0Z0MzZDNPUHlHU21zeGkrZUtX?=
 =?utf-8?B?U0dxZHVMYUFBZXYwQ21USkU3dzU1alVPbG54endwd0lRYUduS2dtbE8wRFBu?=
 =?utf-8?B?RGFnWnJDRng5K3h3emhjNDI2dHdmU1lQQXIvbTlmdHNzdEFxREFxWG80NWxT?=
 =?utf-8?B?eXc4N2tiUk02Y0JkMUk2RU10alp0cThRU3VxemkvenJMQkMzWDFleUwvaTdz?=
 =?utf-8?B?QVFXQUxQSUhIcDhhcEtLNE5qM1JLSXZxbEVQSU1WRU1UZC9iejJ0Q2NXSk9z?=
 =?utf-8?B?bEo4WTVpZFlJMCtocUV5allJWXJ5dWdockttb0F6RjNkdWlWMHpJalpUSTBm?=
 =?utf-8?B?dnNNcU9pV2dmb2tldFdvRThjemxjeUhoQkREUk5KR3kzYUNwQzQwakJ1am14?=
 =?utf-8?B?NmVCSmpPWHJUeXUyOFc2NjdmYlVROVFEV1h6dEIvSTAxMkFldUhhWFNEUXI1?=
 =?utf-8?B?TUlMYVZYNHZrc0RVaTNrcjRhL2R3bGFDQ1QwUUF1UldndjVEL1Ezc2wzTStN?=
 =?utf-8?B?K24vdy9BYXpBL3lTbVZKbmRtQ2p2diswQzVpbTc0bWR5bmo5OWdsanpHajg3?=
 =?utf-8?B?Z2JOTWFVMnlhTU90NUN2eUM5L3pIMWErZnVZSDdlZkV2cTRpc3BJeG90d3RH?=
 =?utf-8?B?WkFDOHozMHM1eVMwNjZsTHBBd0Nzdzg1OHJtS2kraG1JZkpzUFVEUE5sRUxO?=
 =?utf-8?B?dnRoZXM5WUExZ0dRK3dsWmwzQ2xIQTZwczVFcENodGZZZGhvUmNleThjWWM2?=
 =?utf-8?B?VFpid3dFVGdsWS9DUEVzNUczVU9uZFlLYXE5N3djM0ZwSE14bmwxTGVGNkIy?=
 =?utf-8?B?TTZ5NHFVZWFpL2MyWXFoZzc5ckM2WW9EVHN0OGRBazg2anNRcTdoWnVWbC83?=
 =?utf-8?B?U0Z5NWRQdFc3ZXhDa2lTazZLeFNKTEVIZUJLUzRINEZVaW9DMWxHRnZvOFd1?=
 =?utf-8?B?NHhBQ0pHMGpmVlgrUDlZN2ZxWlcreXlZOFMxR1lzbFFNVE1sRWZKcFNVMDVF?=
 =?utf-8?B?U0hZcVlnMkkwaGlQZDBBRHZlUUlFNmZuMkNBdHRsUWZNT25udEd4TzhDQjlw?=
 =?utf-8?B?MGdnM3VVSFo5YURSRTNlYXZkbEs2ZVBCWWduYUZ0VFUzRzVHVFBDRGt3QUpn?=
 =?utf-8?B?aW51LzVHeEFLNEdaV0RzaU5ZYTkreFBEZURaSHByZ1ROUlFoa2IweC9CTXcw?=
 =?utf-8?B?OWx2NDlCUXgyVTBwV25VQUlLSjIyOC9xL3RHZ3lESHI1UEtSMjAzTVNZU3hz?=
 =?utf-8?B?L05mc2FUWWhRSG9yV3VvSlF5aG5ReXZaSVFNRzNxd3ZmRzlyVXluN0JRUVVv?=
 =?utf-8?B?ME9kcDdyYm9BUGpxZE84RFF3M2FkV0lqOG04KytwNFBUQ3RPWWJrcy9hd2ky?=
 =?utf-8?B?bUtZTkRWMk54SW1nZlI3Y0tYV2lqNmNZNjFkdVdnWnJ2NXAxQnRvSUdBUThJ?=
 =?utf-8?B?bGlvUS9NQlE5MVprK0I0L3UwelpnNTU0eW01MFcwekMrNjhYVVNtOFhCVW5a?=
 =?utf-8?B?amdndHpraVRmWnpZR1FmaGlLQlVCM3lEWEpKMlF3SGZseDZXc0FwY0drNjlj?=
 =?utf-8?B?Zm9TZlhybHZ1SXd3dzJ6SSt0RTdraDRQVlByQmxwcGJxTUpraXpYdExTa0x0?=
 =?utf-8?B?eHRsV3lHUVdFbWJhWUpBdnVFQzgwelk2QjlkMm4wUU9SNnAwODQ3bnkweDd2?=
 =?utf-8?B?MGpYYWJONFlJVmdrMkxTMGFZTUU5RDZmc0RLSHQ3d1JucHlpMERJd3dqZm1B?=
 =?utf-8?B?S0JYeWFtYTR6RVRSeTRMcjNYd3E4ZlVDNDRJZDZVVTZRUGQ3cmVhUW1yeDN1?=
 =?utf-8?B?TSt5OFVGaGkyVUFRNTNhYTY2TkprdVdrR0pBQ0ZPamdvQVlEODJoY1N3WDJY?=
 =?utf-8?B?Ym1XNmhFb1M0dFQyc2RQT0Z3Q0RlTVdya21KSXF2YWZhd2JPV1Q4VjBrMkVY?=
 =?utf-8?B?SDdzNy9sM3lVQk8rMFdZcnhRckdFRVQyRTY5ZVB5bzVHSU40aVYwM0dmYmNJ?=
 =?utf-8?B?ZjNISUkvZmdqRkdBZG1HMjh0SlVNNlBDaTNjSVc2bnZJMVNFNS8rd2dYbStH?=
 =?utf-8?B?Q3ViN2JQTnRTeWhPN1RxcHdGZWhYelh0SUdsckpCaHlVTnRvUGhpemF0bkNq?=
 =?utf-8?B?NXBqOFllRTZmbVk3bFRmenNyblFzUU5WVVBvOWlxUUdMdHpBbHlOT3d1QTZC?=
 =?utf-8?Q?TSJa9zq0PXRCbKz/HU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b10d75b-0927-44fb-e7f9-08de89a23b80
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:38:21.1174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s83uCtIYoPKK6t3QU3EjBSWKsNPGAA8hT6VS9/jB9zfyMa1ecTctJIH1ZBGipPXm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622
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

On 3/24/26 11:28, Lazar, Lijo wrote:
> 
> 
> On 24-Mar-26 3:43 PM, Pierre-Eric Pelloux-Prayer wrote:
>>
>>
>> Le 24/03/2026 à 10:42, Christian König a écrit :
>>> On 3/24/26 02:26, Jesse.Zhang wrote:
>>>> During GPU reset coredump generation, amdgpu_devcoredump_fw_info() unconditionally
>>>> dereferences adev->mode_info.atom_context to print VBIOS fields. On reset/teardown
>>>> paths this pointer can be NULL, causing a kernel page fault from the deferred
>>>> coredump workqueue.
>>>>
>>>> Fix by checking ctx before printing VBIOS fields:
>>>>
>>>> if ctx is valid, print full VBIOS information as before;
>>>> This prevents NULL-dereference crashes while preserving coredump output.
>>>>
>>>> Observed page fault log:
>>>> [  667.933329] RIP: 0010:amdgpu_devcoredump_format+0x780/0xc00 [amdgpu]
>>>> [  667.941517] amdgpu 0002:01:00.0: Dumping IP State
>>>> [  667.949660] Code: 8d 57 74 48 c7 c6 01 65 9f c2 48 8d 7d 98 e8 97 96 7a ff 49 8d 97 b4 00 00 00 48 c7 c6 18 65 9f c2 48 8d 7d 98 e8 80 96 7a ff <41> 8b 97 f4 00 00 00 48 c7 c6 2f 65 9f c2 48 8d 7d 98 e8 69 96 7a
>>>> [  667.949666] RSP: 0018:ffffc9002302bd50 EFLAGS: 00010246
>>>> [  667.949673] RAX: 0000000000000000 RBX: ffff888110600000 RCX: 0000000000000000
>>>> [  667.949676] RDX: 000000000000a9b5 RSI: 0000000000000405 RDI: 000000000000a999
>>>> [  667.949680] RBP: ffffc9002302be00 R08: ffffffffc09c3084 R09: ffffffffc09c3085
>>>> [  667.949684] R10: 0000000000000000 R11: 0000000000000004 R12: 00000000000048e0
>>>> [  667.993908] amdgpu 0002:01:00.0: Dumping IP State Completed
>>>> [  667.994229] R13: 0000000000000025 R14: 000000000000000c R15: 0000000000000000
>>>> [  667.994233] FS:  0000000000000000(0000) GS:ffff88c44c2c9000(0000) knlGS:0000000000000000
>>>> [  668.000076] amdgpu 0002:01:00.0: [drm] AMDGPU device coredump file has been created
>>>> [  668.008025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [  668.008030] CR2: 00000000000000f4 CR3: 000000011195f001 CR4: 0000000000770ef0
>>>> [  668.008035] PKRU: 55555554
>>>> [  668.008040] Call Trace:
>>>> [  668.008045]  <TASK>
>>>> [  668.016010] amdgpu 0002:01:00.0: [drm] Check your /sys/class/drm/ card16/device/devcoredump/data
>>>> [  668.023967]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>> [  668.023988]  ? __pfx___drm_printfn_coredump+0x10/0x10 [drm]
>>>> [  668.031950] amdgpu 0003:01:00.0: Dumping IP State
>>>> [  668.038159]  ? __pfx___drm_puts_coredump+0x10/0x10 [drm]
>>>> [  668.083017] amdgpu 0003:01:00.0: Dumping IP State Completed
>>>> [  668.083824]  amdgpu_devcoredump_deferred_work+0x26/0xc0 [amdgpu]
>>>> [  668.086163] amdgpu 0003:01:00.0: [drm] AMDGPU device coredump file has been created
>>>> [  668.095863]  process_scheduled_works+0xa6/0x420
>>>> [  668.095880]  worker_thread+0x12a/0x270
>>>> [  668.101223] amdgpu 0003:01:00.0: [drm] Check your /sys/class/drm/ card24/device/devcoredump/data
>>>> [  668.107441]  kthread+0x10d/0x230
>>>> [  668.107451]  ? __pfx_worker_thread+0x10/0x10
>>>> [  668.107458]  ? __pfx_kthread+0x10/0x10
>>>> [  668.112709] amdgpu 0000:01:00.0: ring vcn_unified_1 timeout, signaled seq=9, emitted seq=10
>>>> [  668.118630]  ret_from_fork+0x17c/0x1f0
>>>> [  668.118640]  ? __pfx_kthread+0x10/0x10
>>>> [  668.118647]  ret_from_fork_asm+0x1a/0x30
>>>>
>>>> v4: fix the race concern without introducing VBIOS snapshot state.
>>>>
>>>> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
>>>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 16 ++++++++++------
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  4 ++++
>>>>   2 files changed, 14 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/ drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>>> index bbb5afd67b49..5aa46480f05f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>>> @@ -192,12 +192,16 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
>>>>       drm_printf(p, "VPE feature version: %u, fw version: 0x%08x\n",
>>>>              adev->vpe.feature_version, adev->vpe.fw_version);
>>>> -    drm_printf(p, "\nVBIOS Information\n");
>>>> -    drm_printf(p, "vbios name       : %s\n", ctx->name);
>>>> -    drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
>>>> -    drm_printf(p, "vbios version    : %d\n", ctx->version);
>>>> -    drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
>>>> -    drm_printf(p, "vbios date       : %s\n", ctx->date);
>>>> +    if (adev->bios) {
>>>> +        drm_printf(p, "\nVBIOS Information\n");
>>>> +        drm_printf(p, "vbios name       : %s\n", ctx->name);
>>>> +        drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
>>>> +        drm_printf(p, "vbios version    : %d\n", ctx->version);
>>>> +        drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
>>>> +        drm_printf(p, "vbios date       : %s\n", ctx->date);
>>>> +    }else {
>>>> +        drm_printf(p, "\nVBIOS Information: NA\n");
>>>> +    }
>>>>   }
>>>>   static ssize_t
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/ gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index fbe553c38583..69f4549e6271 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -4260,6 +4260,10 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>>>       /* free i2c buses */
>>>>       amdgpu_i2c_fini(adev);
>>>> +#ifdef CONFIG_DEV_COREDUMP
>>>> +    /* Make sure deferred coredump formatting is done before tearing down VBIOS/ATOM. */
>>>> +    flush_work(&adev->coredump_work);
>>>> +#endif
>>>
>>> Looks correct to me of hand, but I'm not very familiar with this part of the code.
>>>
>>> @Pierre-Eric and @Sunil can you take a look as well? You two have done more with devcoredump then me.
>>
>> The worker thread doesn't access the HW but it still reads some things from the adev pointer.
>> Ideally, anything the worker needs should be copied to amdgpu_coredump_info from amdgpu_coredump.
>> Then the worker would only ever access its own state.
>>
> 
> Hi Pierre,
> 
> amdgpu_devcoredump_deferred_work -> amdgpu_devcoredump_format() -> ip_block->version->funcs->print_ip_state(ip_block, &p);
> 
> This accesses hw state.
> 
> A newer version of the patch is posted which moves flush work inside fini hw befor IP tear down.

That sounds reasonable to me.

I mean we don't need to copy static information into amdgpu_coredump_info (e.g. like BIOS info), but things like print_ip_state() clearly needs to execute outside of the worker since the dumped HW state is destroyed by the GPU reset.

Regards,
Christian. 

> 
> Thanks,
> Lijo
> 
>> That being said, flushing the worker is fine for now.
>>
>> Pierre-Eric
>>
>>>
>>> Thanks,
>>> Christian.
>>>
>>>
>>>>       if (adev->bios) {
>>>>           if (amdgpu_emu_mode != 1)
>>>>               amdgpu_atombios_fini(adev);
> 

