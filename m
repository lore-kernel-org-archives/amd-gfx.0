Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD99BFEA837
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 08:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A85C10E7C7;
	Wed, 25 Mar 2026 08:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M5dG4w9D";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B838710E824
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 08:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DllGe45x5mWjIuAC29Nw2WvTt1mib+j3wfMgft7+sfbScRh7EynGgGrNt7hPoPtY/YD4E7TvKlLxc/mRfgjJpotoKr+s+7R3+thOekeBi5tnsSNSGGFwNMrjHjGt5Y+bBN3h/MGxlq2Tp4kMmi3hJWhPy/TxD8BlMXA1Jv5uRgL2XsTwYOcHzth3WCB20RsR/FBejoAoREIgT9Arb83vIKJy/PO9Dl9fZYxplKDmMY1o2BNEEHBPcarBQ3J63ni709icatgbw+L6xVCQxXANRVlLYMKRcdp/uM1QgWOqRHNJVVDfgPtE/v+TDfOJkfubJ5BTlVHHFdXVToZ6JjBL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hBiVwky2TGhFvTaSiZIEC9of1Av2OdKKA8uJkGMNmo=;
 b=BAxddWZd427Qicmqq7HU1R928Up6qMJQ3HWzgbyjA8knBzBuWFefJPZz9Wgt+8YQG5kL8Mz6ZvUCdW77qCyJ7wSAQG7ybYpE/myVGYKBYKmq20UR4sFuVgjaexGN5/VFIXCPF0J7XtGe8cOyo7hCOLAYMT26vBcVBfvQmcf66+4ZuaXvQGP04dcyrkWYNOr7c7ptxuEf4TSH9UZUI2ZDijGT1N9TbuTGmzna5dSejDKgyETOesSYy83HzWhDMRWeY4ixiTgC26WbWG9gSO+2l8nlMun5HfWXf6xJG1tajstlfr+HV98EGuiGpz2U2GR/mGelgcFPvwyF7WEKJyksoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hBiVwky2TGhFvTaSiZIEC9of1Av2OdKKA8uJkGMNmo=;
 b=M5dG4w9D3e9c3ApRW2QFRLn+pnI0NxncUNOkQl79jGwP74oyEeCfe4XN+vHvK6vqeAsK1XMsmz69Tq27XKU736raht6yzqXuoAL6FYIQjIyaTvceK5inlokssSutJ9QjRJ0u4aeLChDIoBO6SNARYIbkA8bVK4Y/BeK21kPZF9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 08:55:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 08:55:18 +0000
Message-ID: <88c87d9b-90dd-4a3f-9951-5d181873bcfb@amd.com>
Date: Wed, 25 Mar 2026 09:55:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix NULL bo_va dereference in VA clear path
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260324135710.2079864-1-srinivasan.shanmugam@amd.com>
 <e9cc8d81-5838-48f9-ad01-b43d90620091@amd.com>
 <IA0PR12MB82084F7DEFCBE7FC1F468A3A9048A@IA0PR12MB8208.namprd12.prod.outlook.com>
 <2687f0c7-e458-4bd6-b438-4a4fc942f670@amd.com>
 <IA0PR12MB8208839D089361E8AE6FC4099048A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR12MB8208839D089361E8AE6FC4099048A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ea955a-a495-42c8-afd2-08de8a4c3d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|7053199007|18002099003;
X-Microsoft-Antispam-Message-Info: cX3nFspRl6od5qEYig0YCADTQgSu01kMPnq1i2HMQi56BaSqjFfZ/sIQeGWJcfL7h59l3XaYA/doWsIUG5pH4CsA66VbEzMm0g7t0bs3LBy7JzccATB/YqulJvA7c0qgUq4csT5wiERX+x6G63W3SZig9r/vIiSjb4qjyT8ypB0Dg6kp0qsgTcykQGWkc902/r55aQn0eD1mlyUozraxDUIVXvO/roLu02sogJSV4VSrK2ynSCNCRF0CBWo6NMX10GPU2l27slID6cwOOP76wWNUGWRfk7XO8hfEflw3qcECopy4ilDhWHADylsrg629rQzn4gPNmQnRtAVsa+jg5B+SQ9Kk9F9yNJepnUsEuLbMrP/9EKoPk9FlhOjHLBrI9G32nKWa5GM8kaxrCKWpZwwqmaIA/aT9Rb6HGbtdKh2+WBZfG4/6t8cGEUI6/EGzqgpAIgJRcY6Z2wqC2Sr2PPOaPBPmBHfRAi+OqksxqPf5cqEum7HnIvF7DSLueiaZMTYK+jc0iFkk7QTq66mP5kShjXN+fzntYzY6PA4yLYZ5NhM+B3trSxPYP8KP4SmK1Kg+J1QHNJQ3Iu3yH3IEcaTGj7Gk84QGm/Sw4rmlc0fwqYD78mAKZ/c8OHaqFbYsWqtZ5uFEWq6k7dz7oBS7XWtX4YWoLh3/KzionGWokMjFg07QkxhuJY7Mb5fRtUY/T3rV+f8wpToLGhAQiLIn/mGG7M79wWPv9tZDjHBxT+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(7053199007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R05HVUQ5TnV2ZmJIelluYWRtY1BPTnV0TEpSckhXajIzQkxMZ0FLN0FjZ2FQ?=
 =?utf-8?B?WEc1YzhVWFhCNGd5ZjM4clIvQlRTMHVpYnU2dDF1ZWI5UzBXSGhjZEM2Undn?=
 =?utf-8?B?SW9jZWlVNTkyNERkcTM1T3o3clFiaXVzS3RoY0duWUpTb29HU1ZEMjR1OGJJ?=
 =?utf-8?B?QzZpSjJNWm8wTHhjODY5dUNRNCtJZzBsR0xPMTVlZVB0ejJhV1k4K2x5djlW?=
 =?utf-8?B?b1Z2QmFIc2xCdUNOTGJCVS9KTklSdklONzI0STRaN0VpMEZMVUtrcVViTjdh?=
 =?utf-8?B?OE81c1NkZFpBdFprRGtyVW5QcUE4K25DN1FubkVXRElRS1ZJRnQ1MExTYUZW?=
 =?utf-8?B?MW9hMWlZdlE0M2dCeFpZcTVSUUpzZm1MQjdCYldMei9vQkRUcUxBL09ldzlY?=
 =?utf-8?B?VWhBa3N2c1FZWnZRa1hTcDdib09KaHlMY3UwR3RKbnNHRmdoMlVSUXRGVmVK?=
 =?utf-8?B?TkVINmI0NTBFZlFNL1plUENxQVhGSFRlY0lCRXpZRGIvU21vZ1lReTY5VkRk?=
 =?utf-8?B?UzRQTFcxd3hnSERRaWxzZXhrNmM0cmdjOHBtNVh0M3pMc3ZUSXRjQ3ZGUGFo?=
 =?utf-8?B?MEJkWFYxaUlVTmhtbml1TytXUGVpaDRDS3J4NkFGaEJBSnN0dFhsbUdNM1RV?=
 =?utf-8?B?ZHlpdjZIVDhmbnFkeWp2RS9ZekJEMXNPTE1TOEhrdkQ3M2hLZERWM3ZjZ1hs?=
 =?utf-8?B?N0haeFZHSUJBaDB6U1NMOUtVN2dGMUpqdkQ3MU1aT1VTa043eUNFNGNUVlFm?=
 =?utf-8?B?d2ZrU1I5UDZLdnBUN2VsT1JpMU9NU1p6bGFHclQ4N2ZuSHNMbkRWRjJFLzZl?=
 =?utf-8?B?RHlNcGhGeURXaGJSVkhuNzBLS2owRWZ4UzdxMG54eENNQi9rTDh5RDhlczdt?=
 =?utf-8?B?NXNIL1FxWlJLRHBWYWxrcVRhK0NlTEtrRURqUVA5WithR2dZbmpGNy9NVzBU?=
 =?utf-8?B?K1VnelNVYUVYem9SRXRmUG9GcDVDOGNuM25YaHBxMlhHRUZoeXVJNVlEM2N1?=
 =?utf-8?B?U0l2MHpOckY2TE9sbllxd3hiZjVBU3dkSFFiaEIyWUl4Q2lwWHN4aUtzZVR0?=
 =?utf-8?B?bWFEZkl4NWg5d0Y0M0NkQW0yOW9yaU1VcUtTbE8vL25mNVkyaE1WTnlBVGFC?=
 =?utf-8?B?U2FrVnFxNnRJSExwcmg4TGp2ZzN3dkhwRlp2R2krRHZUUlIzdE9PMGlNdjBs?=
 =?utf-8?B?V0djczZNZ2JDaGVLZUwyQzBvcGhJSFBTeSt2SEpUSUNMZm55bE1tZGluT1d0?=
 =?utf-8?B?elFwVEk5YlhjU1d2cWNsQWdxVjI3QUZLbG5BZkVkbmViYUt3SmZELzAzdXpu?=
 =?utf-8?B?MXEyL21zcWk3enIrSFROdUFNckpkWnlFNlBDR295WmdlOUpQVDhVaWhJVk9P?=
 =?utf-8?B?QmU1cS9HbElyY0h0ZFQ0U1luUEU0NnFqR2wzN0JqOGNPR3dOSkhVSWVrKzJG?=
 =?utf-8?B?UFA3QkFqSzljaXpBRll2WHRzMG1HbHpGemtiOUdEN3pHUlp6NGxSOExkSisy?=
 =?utf-8?B?eGxBVWRGUlVjRkUzbWZiemRYWCtIOWRWN0c3Ny9GMTRaZjVtZEVOY2Q3aWFo?=
 =?utf-8?B?TCt3TXZ2R1JVVytuaHoza1RDUGg1MGlmY1JseXZBblRCdWovRjNGdGt1S2kz?=
 =?utf-8?B?c0VDMmpYbXYwNi8wa3kzWm9Zb0lCeENtRWZmUmxxZnI4clFhM09MYjh5ZHBW?=
 =?utf-8?B?Z21xYnJEWENHMkZockM1cEw1MTVRSjdNRTBwTVVTN3VMRkhXK01jcGsyd1Qz?=
 =?utf-8?B?Wm42MmlpQTMyRkpPeFNlQkhwdllNSmozQ0QrMWNsOXhoUEJPNFpqZHpmZmpu?=
 =?utf-8?B?aGF5MXJhcWxwZGFocXNGelJOTHllTzl6TFJ1N0RpekFrWmNCdjAwWVVCL1RC?=
 =?utf-8?B?REFadHZNTjlXSk9JZ0xUL29neUdTRkRuRHArNzdEV2JpRzdRYVhrMkc1RFBK?=
 =?utf-8?B?NkFyN3p2S3Y4di9UbndzM0p4ckRVUmlyOGtJdHpOMGJRVTJseWZ2MGpFTlRI?=
 =?utf-8?B?eGdQVFpnc2lFQUVYQ0F0SldiY1hkbG5jcWJieWsvZ0swem9QcWxZWW50N3h0?=
 =?utf-8?B?cDVhZU8wNytSS1ExaDVybWs3MGNockJFK2J6amYzbjk2ZWpocVFrUm9wT1Zm?=
 =?utf-8?B?eGJ5a1VNNGVLdVI0blA3MkVrczZrYitaRnNaNkFvZEpDS2VRclZIOXErMGoz?=
 =?utf-8?B?UWdsZHNMZ0Mwcm9Ic240c2dOT1h3a3dKRFR2Zit0aGFMdHZsM2VjanRZZzBl?=
 =?utf-8?B?NlE0dmJWYWcyaldNYkRCUkw1OEtIS24wVEEwRXpOSGc1RnVRVUU3QStIS3Jn?=
 =?utf-8?Q?T6RtneGQpXpVDDDbXp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ea955a-a495-42c8-afd2-08de8a4c3d46
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 08:55:18.6114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XglFSmIO2D2tAa/RJGhi2PYK/ayQ3F7vplU7YVVZlkcT3EBNP83N4rtilndIdDf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219
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

On 3/24/26 17:43, SHANMUGAM, SRINIVASAN wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, March 24, 2026 9:34 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH v2] drm/amdgpu: Fix NULL bo_va dereference in VA clear
>> path
>>
>> On 3/24/26 16:35, SHANMUGAM, SRINIVASAN wrote:
>>> [Public]
>>>
>>> Hi Christian,
>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Tuesday, March 24, 2026 7:43 PM
>>>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Deucher,
>>>> Alexander <Alexander.Deucher@amd.com>
>>>> Cc: amd-gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH v2] drm/amdgpu: Fix NULL bo_va dereference in VA
>>>> clear path
>>>>
>>>> On 3/24/26 14:57, Srinivasan Shanmugam wrote:
>>>>> amdgpu_gem_va_ioctl() can call amdgpu_gem_va_update_vm() with bo_va
>>>>> == NULL for AMDGPU_VA_OP_CLEAR.
>>>>>
>>>>> CLEAR operates on a VM address range and is not associated with a
>>>>> specific BO. In this case, the update helper should perform only
>>>>> VM-level updates and must not access BO-specific fields.
>>>>>
>>>>> Currently, bo_va may be dereferenced in the MAP/REPLACE handling
>>>>> paths without explicitly guarding against NULL, which can lead to a
>>>>> NULL pointer dereference when CLEAR is processed.
>>>>>
>>>>> Fix this by making amdgpu_gem_va_update_vm() explicitly handle bo_va
>>>>> == NULL:
>>>>> - Guard BO-specific accesses with bo_va checks
>>>>> - Warn if MAP/REPLACE ever reaches the helper with NULL bo_va
>>>>> - Keep VM update path unchanged for CLEAR
>>>>>
>>>>> This keeps CLEAR on the common update path while ensuring safe
>>>>> handling of NULL bo_va.
>>>>>
>>>>> Crash signature:
>>>>> [  325.716062] [IGT] amd_bo: executing [  325.779102]
>>>>>
>>>>
>> ============================================================
>>>> ======
>>>>> [  325.786483] BUG: KASAN: null-ptr-deref in
>>>>> amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu] [  325.795105] Write of
>>>>> size
>>>>> 4 at addr 0000000000000000 by task amd_bo/7893 [  325.801997] [
>>>>> 325.803595] CPU: 12 UID: 0 PID: 7893 Comm: amd_bo Not tainted
>>>>> 6.19.0-1314135.2.zuul.928a0cbbebc74c4f8d5a99a4d0a7ca55 #1
>>>>> PREEMPT(voluntary) [  325.803602] Hardware name: TYAN B8021G88V2HR-
>>>> 2T/S8021GM2NR-2T, BIOS V1.03.B10 04/01/2019 [  325.803606] Call Trace:
>>>>> [  325.803609]  <TASK>
>>>>> [  325.803612]  dump_stack_lvl+0x64/0x80 [  325.803623]
>>>>> kasan_report+0xb8/0xf0 [  325.803631]  ?
>>>>> amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu] [  325.804427]
>>>>> kasan_check_range+0x105/0x1b0 [  325.804432]
>>>>> amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu] [  325.805229]  ?
>>>>> __pfx_amdgpu_gem_create_ioctl+0x10/0x10 [amdgpu] [  325.806022]  ?
>>>>> __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu] [  325.806815]  ?
>>>>> __pfx___drm_dev_dbg+0x10/0x10 [drm] [  325.806894]  ?
>>>>> __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu] [  325.807686]
>>>>> drm_ioctl_kernel+0x13d/0x2b0 [drm] [  325.807767]  ?
>>>>> __pfx_file_has_perm+0x10/0x10 [  325.807777]  ?
>>>>> __pfx_drm_ioctl_kernel+0x10/0x10 [drm] [  325.807857]
>>>>> drm_ioctl+0x4be/0xae0 [drm] [  325.807936]  ?
>>>>> __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu] [  325.808728]  ?
>>>>> __pfx_sock_write_iter+0x10/0x10 [  325.808737]  ?
>>>>> __pfx_drm_ioctl+0x10/0x10 [drm] [  325.808816]  ?
>>>>> ioctl_has_perm.constprop.0.isra.0+0x2ad/0x490
>>>>> [  325.808823]  ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
>>>>> [  325.808827]  ? _raw_spin_lock_irqsave+0x86/0xd0 [  325.808835]  ?
>>>>> __pfx__raw_spin_lock_irqsave+0x10/0x10
>>>>> [  325.808841]  amdgpu_drm_ioctl+0xce/0x180 [amdgpu] [  325.809622]
>>>>> __x64_sys_ioctl+0x139/0x1c0 [  325.809630]  do_syscall_64+0x64/0x880
>>>>> [ 325.809638]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>> [  325.809645] RIP: 0033:0x7f205fd12e1d [  325.809650] Code: 04 25
>>>>> 28
>>>>> 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45
>>>>> b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff
>>>>> ff
>>>>> 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00 [  325.809654] RSP:
>>>>> 002b:00007ffe9032b510 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> [
>>>>> 325.809660] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
>>>>> 00007f205fd12e1d [  325.809663] RDX: 00007ffe9032b5b0 RSI:
>>>>> 00000000c0406448 RDI: 0000000000000006 [  325.809665] RBP:
>>>>> 00007ffe9032b560 R08: 0000000100000000 R09: 000000000000000e [
>>>>> 325.809668] R10: 0000000000000000 R11: 0000000000000246 R12:
>>>>> 00000000c0406448 [  325.809670] R13: 0000000000000006 R14:
>>>>> 0000000000001000 R15: 0000000000000001 [  325.809675]  </TASK> [
>>>>> 325.809678]
>>>>>
>>>>
>> ============================================================
>>>> ======
>>>>>
>>>>> Fixes: dc54d3d1744d ("drm/amdgpu: implement AMDGPU_VA_OP_CLEAR
>> v2")
>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 +++++++++--
>>>>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> index b0ba2bdaf43a..145cb222d5cf 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> @@ -759,9 +759,15 @@ amdgpu_gem_va_update_vm(struct amdgpu_device
>>>> *adev,
>>>>>     if (r)
>>>>>             goto error;
>>>>>
>>>>> -   /* For MAP/REPLACE we also need to update the BO mappings. */
>>>>> +    /* For MAP/REPLACE we also need to update the BO mappings.
>>>>> +     * CLEAR operates on the VM address range only and can come in with
>>>>> +     * bo_va == NULL.
>>>>> +     */
>>>>>     if (operation == AMDGPU_VA_OP_MAP ||
>>>>>         operation == AMDGPU_VA_OP_REPLACE) {
>>>>> +           if (WARN_ON_ONCE(!bo_va))
>>>>> +                   goto error;
>>>>> +
>>>>>             r = amdgpu_vm_bo_update(adev, bo_va, false);
>>>>>             if (r)
>>>>>                     goto error;
>>>>> @@ -772,7 +778,8 @@ amdgpu_gem_va_update_vm(struct amdgpu_device
>>>> *adev,
>>>>>     if (r)
>>>>>             goto error;
>>>>>
>>>>> -   if ((operation == AMDGPU_VA_OP_MAP ||
>>>>> +   if (bo_va &&
>>>>> +       (operation == AMDGPU_VA_OP_MAP ||
>>>>>          operation == AMDGPU_VA_OP_REPLACE) &&
>>>>
>>>> Something else must be broken here. We already check operation ==
>>>> AMDGPU_VA_OP_MAP or AMDGPU_VA_OP_REPLACE.
>>>>
>>>> That should be enough to Ensure that bo_va isn't NULL.
>>>
>>> Thanks for the review and the clarification. please correct me if I am mistaken.
>>>
>>> - For MAP/REPLACE, we are working with a real buffer (BO)
>>
>> Not quite for PRT the BO is NULL.
> 
> Thanks for the clarification.
> 
> Ah, got it.
> 
> So for PRT, bo_va is valid but bo_va->bo is NULL.
> 
>>
>>> - So bo_va should always be valid in those cases
>>> - bo_va should be NULL only for CLEAR or PRT, where no real buffer is
>>> used
>>
>> No, bo_va is a valid pointer for MAP/REPLACE, but for clear it is NULL.
>>
>> For PRT bo_va->bo is NULL.
> 
> Thanks, that helps clarify.
> 
> So:
> - CLEAR → bo_va = NULL
> - PRT → bo_va is valid, but bo_va->bo = NULL
> - MAP/REPLACE → bo_va should always be valid
> 
> I was incorrectly treating PRT similar to CLEAR earlier.
> 
>>
>>>
>>> Based on this, it seems the issue may not be in
>>> amdgpu_gem_va_update_vm(), but earlier in amdgpu_gem_va_ioctl(), in the part
>> where we decide:
>>>
>>> - which buffer to use (abo)
>>> - and where it is mapped (bo_va)
>>>
>>> This is how I currently understand the flow:
>>>
>>> 1. First, we check the operation and flags
>>>
>>>    - If it is NOT CLEAR and NOT PRT,
>>>      we take the normal path and get the real buffer (abo) from the
>>> handle
>>
>> Ah, I see. Yeah, that is most likely wrong.
>>
>> We should use the special PRT bo_va in fpriv for that case, otherwise userqueues
>> would have quite a problem.
> 
> Got it, thanks.
> 
> So for the PRT case, we should use fpriv->prt_va instead of treating it like a NULL case.
> 
> I will fix the ioctl() path to ensure PRT uses prt_va correctly.
> 
> Based on this, I will focus on fixing the bo_va selection in amdgpu_gem_va_ioctl(),
> so that PRT uses prt_va and bo_va is not incorrectly NULL.
> 
> Please let me know if this direction looks correct.

That sounds reasonable to me, yes.

Thanks,
Christian.

> 
> Best regards,
> Srini
> 
>>
>> Thanks,
>> Christian.

