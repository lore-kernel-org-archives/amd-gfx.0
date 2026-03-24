Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED568F54AD8
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 16:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E5C10E73A;
	Tue, 24 Mar 2026 16:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="auLyeXMt";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AACC110E73A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 16:03:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcaPWN0cIUzcQkMUWkVXWt3ZbOwkRn/UREQeTj3POGHkigKTR2QkstbA6IOmpkAyhQEr5wej1tI5Ma8kfgvt2FAlMlRmJIvqeFIseN6zvbGZKHd1MYe9zHen7uz0/aXKw0gHI+gDFlaNj3Md9DckCWgWOkVEoLh9ExNnanvlmzqkCREtf0CXYdOhEQdDhOAamPLq66z6W3yHhLU6qCcoS2LqmQ9HwDDuQ2MonY44SpjGE5sGRaOlzfWQdfd3jWdnBDDS9lYt1+BcLuQnhQPCcVQ4lSqhRnMWQ0eatwr7sEsQwQWhxfXffVs5Gv18IhQVdCY/tB/U8RDcfQX0TMv5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCT1+824OFHlDdavn4NZTtW0sm1Nnbt9+tZzpIUUhRc=;
 b=qeKKvnyLT/S85sdaW+ep0RT4fyxXJvAWkxdDtX1TLaZZTcvnOsS17M3WDO5dLzGGaxGdwuDHzXCeP9YvI9tI3naNWBWWWb0mL1Pu1+D3P0S7zp5uEsnSydEcvK6BE9/lu6z8hp5qIvsM/jlWF2HE8numm64yvw/NJugRztjrVJ9IHKBtWNydBzXfhu60V2Dm97IXVe9AcWHTo2eKjkaNHT8uH0Y2hiQpvqGBg0lYXnKJ1BoMrehVIptsdm1Yl5zINNBdOcytCwFNVMbMa5+YbGQm/KRr0r5fUupGguPuMXS5yAKIEQXOaOXlpt7nIjW7jH5C7gJX4Hk7scBmXL9Thg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCT1+824OFHlDdavn4NZTtW0sm1Nnbt9+tZzpIUUhRc=;
 b=auLyeXMtnebALm9brp+J1SF1dqowxZWxFbPh/2Y8WL3ulvTgukeDT+qkKtRvznaj/9lkIcJKkkbzDqY64HyKKLmHI7JPlrxL2y8V6kem/4zr2SN2JDCU41vI59z9q0SNgsD9XRyc+L5j6V7Q3seIh7TUWuLAjxfbG6/MNyIB4Uk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 16:03:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 16:03:40 +0000
Message-ID: <2687f0c7-e458-4bd6-b438-4a4fc942f670@amd.com>
Date: Tue, 24 Mar 2026 17:03:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix NULL bo_va dereference in VA clear path
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260324135710.2079864-1-srinivasan.shanmugam@amd.com>
 <e9cc8d81-5838-48f9-ad01-b43d90620091@amd.com>
 <IA0PR12MB82084F7DEFCBE7FC1F468A3A9048A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR12MB82084F7DEFCBE7FC1F468A3A9048A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f75612a-a604-4c8e-0fdb-08de89beeaa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: PnRsCGvxZ6SfJ2oMX9Ts4k6zIHuqUUe77MwMxvrsr/uLwRdf0GcESI2FZl0aiRn7NlcTkoCSxHrLPR85xtqiU8Xdex5YjE/B/rCtQhh8bG5qqU22PECMP43XRFWDSuhnJkD3NnV9K0GOiGw4wd41h4iu8zg/rumfVRq7R9+Q+ikGdfxUOdGTNyu4VoPYRe6C1oMdLhzX6a7y+Szo5C7B0SrZ4yeD4YXQ+9KU27wD23taiMJLZPh0Is+mkJgM/BBqd1BOUFg7yDee7EtFK486dleszg/1dW1D0HQoykRCbrUZ1zRfCZWeu5dgC+vCrWBbBHz2F3aZsocrNYsEI8GwgvReRBnJ3RowiSR5uMGiuQgcZFxJhVgGJgB43g5Hp30kYCMR+RR6ptalGPJUIHP6OO/pwrMMOOPGf1gqD0z0vQWr/lTMRqFJKlHCaLfIjHq5uIFcPt+6JrImScEmCMOg6x4hTTbOLuEyzWcEQk/We7lLGWg51vFFeqVpiOEIsL8JSWAhP7G9KuHpDY3tn/Xx+875NIqSbkpVHhmIGQP9OOEV1C5ia+7pMRjEPGN5+uoLdVIyjTqajEJDcJTgFehcwmglF2BVfUyQ2PK30qqaVnXFbjuqx96/1OmY3GPJGtQgEk0FZGqcfra8JRd9dvb2TTrexptc8IBQ4W9NlRZcmK5qui1HhpGFPyCh9GgXuku4zkY8LqZbPF+jpzrikQyx9V/PRWEbqtTo7jdK/8x+3wc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXhTUnYwVWlmSnRWdXdiTXdRZFZZUWZCRTRCUU1uSmdPL3ZaN0VYaHNTeHBY?=
 =?utf-8?B?L2lvL3hhRnd0M2hNbkFPQVpkUE96andyR0FxcStwclg3K0VuREtTcGtHZk53?=
 =?utf-8?B?dzlvR2VFTmtHT242NnJ6b2RPS2s3VjlibXdTQmZkZkR5V0R4aSszUHVmTUcz?=
 =?utf-8?B?SmFzZzd4T2pCNWl4ZENsYW9ad2dnNldjSjUyTHhwWWRWQXRmT0JTVVBwZlgv?=
 =?utf-8?B?Uk15Z0o0eE5FOVFLNzJ3b2NOMWVncHBjUVZJWVpZVW90citab2Juc2MxeDJD?=
 =?utf-8?B?RTJuZ2VJcThoSnlsYWcrR1U2VW9CQzF4NWRIQTcrc2R1V3pCYk55eVZyMGlu?=
 =?utf-8?B?Y3pOWUE1d0xBRWFqMENyNUZSYnJMczQvSjcyY1B0cWNQRkM1cUpYc0ZJbm1K?=
 =?utf-8?B?SndJOE5LVmgzcjdoZ3NFekIva3hQbHNVYlZHTmhta1lLUWJNRE9uckRSZnJu?=
 =?utf-8?B?MGlYQXpadmNYWVVsVGlkWUphUVNUeUt6S2pOYVBGY3ZRSW1RTWpiUkdhSFZH?=
 =?utf-8?B?SzA4MjdQK1VMOXJvY1hJWFBGaGtlOVVIZEl1VlZPMFhWcDZiWUpDOHp3MWc0?=
 =?utf-8?B?Z0ZjVjVrdnBPRlJEVDRWWFRlb3JSQ3F6TDNGSnZwaU1nZ2dsWkJXTmZWbVVJ?=
 =?utf-8?B?NUtrMU0rL3Z5NE5tSVNWOThiTlM0T1BCYmdMeUFLM01aTUgva1ZKN2NWY0Fy?=
 =?utf-8?B?RkVlZDEySEZzMmQwdEdmWEdSbXF5WG5TWlE3NWhhbDJsQ3lEeGpNZHNNMVBD?=
 =?utf-8?B?bjJyV0pNMkVlZXg5SXpjU1ZlSlhsSElVVjExMmU4QnpjNTc4UEVBQ0VEaVBT?=
 =?utf-8?B?OG5GeHFQTEo4REc1V2YvTTlzOWFJNUoxWG4wVW90cngxWjhIYkQxbFh0cTlE?=
 =?utf-8?B?UXNpeFVGYWwrZWd0SndkUWtiakVLOFQ4RldxK3cvVDRBZ1lCQXo5MkFhaG1l?=
 =?utf-8?B?REIwc2Q3ejZUdklIQThlbElRWEpJQ2NFVmpldHAyc3JKaGxiOHRjUFNNN2xS?=
 =?utf-8?B?cmtjWVdnNm1SYkZmNkZVYWFKcmF0R3h3K2N1a1pZWmNiZStTZlJYZlFpN3Ns?=
 =?utf-8?B?a01UODB4RlVDenIyRUk3MWpVZXBXd2RkdENRUWZYZFc1SG1vSjRqL25QS1Vz?=
 =?utf-8?B?ZGNXaGp5VXc0ZUZKKzBONlB3RnhSMkxRVy9aYys3MUs4dEdyWG8zaWgzajlv?=
 =?utf-8?B?TVpBS0c4SzQybC9CSjcvb1drL0IzY1JsR2pjcGQzVHB2cHFBNU95ejkwYjhL?=
 =?utf-8?B?S1IvaXhkeEJIYnJWeUhNSENNclE0TUdkR05pVHZiWVd3aGp5eXFRcG0xQnAv?=
 =?utf-8?B?OGZEM2NxbVI5UFFmZjAva2NUNWxaVTVtN05uZHFRUVlSSytwL1ZHT0ZWK0lr?=
 =?utf-8?B?MTVVVTdHQ2Nic0lpVGtoK1RnUEUzd0lqbS9xZUNQdWRZcXlJNGVCUXFKcFlY?=
 =?utf-8?B?bTVzZWx6dXVFNk9uZGtnaFJUWmVGclcrS05YK21NKzQ2Z1dsbng2d1ROZVZI?=
 =?utf-8?B?NXQzUE1ZSGNVZ1BtbUNDbDE5TE5XOEg0ekxtakt2bFBQbVpkbVNGVUo1bVph?=
 =?utf-8?B?SHFBSFR4TG9Ncm5OQ0xzaW04TkNxQmZLNWxCQ1hhTFlQUmpDaHc5R3owUU44?=
 =?utf-8?B?T0NqM0thQ1hHMnY0cjVxVW5BbGx0bUluVzlEcUkybnkwSFFZOHlRaW9LZmRo?=
 =?utf-8?B?MzRFaGlIVzFGY3BETlZpVEFDeElzNHlvcHFEMmVodkFaS0R1TCtDTk1IZ3px?=
 =?utf-8?B?SCsrYWFYYXdsTlBieFU5NkhwL3plNUp5TVR6ajVkY1pMQjhnNGpzbWFRcENC?=
 =?utf-8?B?Y1lsVloxNkRnOFZyUmdLUUUrQ2ZHRFlxT05GK0E5dUVoa003UFBZUXMxRXVk?=
 =?utf-8?B?OFd4QlB6d1liblQvVE1QYVBtS2w0WXlzZlRkN3NmeGM5MjhacS9ySTV6NE1P?=
 =?utf-8?B?Y2Z2ejJjT2d0TzdVVUVpVUxlMExUTnV3RTZ2SEJTSVBLT2kwVlZSMnhyRjY2?=
 =?utf-8?B?RGFwbzBHdGttQmFKdDMyNlFTVDU4Vmp2V1VoVFl4WDdnL2hoRVpzcS9FVXkw?=
 =?utf-8?B?OHFLbDF0cXZ1RnJqS3dFNEFYajFNaUxPc1RXWWlKd09OSExRNUx1QmE2TkxC?=
 =?utf-8?B?cHV1QlpNZ0toaTBEb1BpSTVrUEN0MklJc0poSGIweXo1bFVIUTZpdjk2K0NC?=
 =?utf-8?B?dmRiejVwNGZZQWJpdUNmWWx5N2lLWWhuOHhrMllvb0NjNzg1amtwaFNEWlla?=
 =?utf-8?B?QWg0KzNnMDFpMjJyME4xYkZ3bDNVOGROck9DNUpoNGZzazUwbys0UkhHNDd3?=
 =?utf-8?Q?2L+WrlDAM/dlgIwjnf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f75612a-a604-4c8e-0fdb-08de89beeaa6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 16:03:40.8252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAYICMWQ47hDGTLkTLqlRybNsW4p/6M4de9OPkqKoCHhVar45kkKNTDc0TjEjagJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587
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

On 3/24/26 16:35, SHANMUGAM, SRINIVASAN wrote:
> [Public]
> 
> Hi Christian,
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, March 24, 2026 7:43 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH v2] drm/amdgpu: Fix NULL bo_va dereference in VA clear
>> path
>>
>> On 3/24/26 14:57, Srinivasan Shanmugam wrote:
>>> amdgpu_gem_va_ioctl() can call amdgpu_gem_va_update_vm() with bo_va ==
>>> NULL for AMDGPU_VA_OP_CLEAR.
>>>
>>> CLEAR operates on a VM address range and is not associated with a
>>> specific BO. In this case, the update helper should perform only
>>> VM-level updates and must not access BO-specific fields.
>>>
>>> Currently, bo_va may be dereferenced in the MAP/REPLACE handling paths
>>> without explicitly guarding against NULL, which can lead to a NULL
>>> pointer dereference when CLEAR is processed.
>>>
>>> Fix this by making amdgpu_gem_va_update_vm() explicitly handle bo_va
>>> == NULL:
>>> - Guard BO-specific accesses with bo_va checks
>>> - Warn if MAP/REPLACE ever reaches the helper with NULL bo_va
>>> - Keep VM update path unchanged for CLEAR
>>>
>>> This keeps CLEAR on the common update path while ensuring safe
>>> handling of NULL bo_va.
>>>
>>> Crash signature:
>>> [  325.716062] [IGT] amd_bo: executing [  325.779102]
>>>
>> ============================================================
>> ======
>>> [  325.786483] BUG: KASAN: null-ptr-deref in
>>> amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu] [  325.795105] Write of size
>>> 4 at addr 0000000000000000 by task amd_bo/7893 [  325.801997] [
>>> 325.803595] CPU: 12 UID: 0 PID: 7893 Comm: amd_bo Not tainted
>>> 6.19.0-1314135.2.zuul.928a0cbbebc74c4f8d5a99a4d0a7ca55 #1
>>> PREEMPT(voluntary) [  325.803602] Hardware name: TYAN B8021G88V2HR-
>> 2T/S8021GM2NR-2T, BIOS V1.03.B10 04/01/2019 [  325.803606] Call Trace:
>>> [  325.803609]  <TASK>
>>> [  325.803612]  dump_stack_lvl+0x64/0x80 [  325.803623]
>>> kasan_report+0xb8/0xf0 [  325.803631]  ?
>>> amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu] [  325.804427]
>>> kasan_check_range+0x105/0x1b0 [  325.804432]
>>> amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu] [  325.805229]  ?
>>> __pfx_amdgpu_gem_create_ioctl+0x10/0x10 [amdgpu] [  325.806022]  ?
>>> __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu] [  325.806815]  ?
>>> __pfx___drm_dev_dbg+0x10/0x10 [drm] [  325.806894]  ?
>>> __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu] [  325.807686]
>>> drm_ioctl_kernel+0x13d/0x2b0 [drm] [  325.807767]  ?
>>> __pfx_file_has_perm+0x10/0x10 [  325.807777]  ?
>>> __pfx_drm_ioctl_kernel+0x10/0x10 [drm] [  325.807857]
>>> drm_ioctl+0x4be/0xae0 [drm] [  325.807936]  ?
>>> __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu] [  325.808728]  ?
>>> __pfx_sock_write_iter+0x10/0x10 [  325.808737]  ?
>>> __pfx_drm_ioctl+0x10/0x10 [drm] [  325.808816]  ?
>>> ioctl_has_perm.constprop.0.isra.0+0x2ad/0x490
>>> [  325.808823]  ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
>>> [  325.808827]  ? _raw_spin_lock_irqsave+0x86/0xd0 [  325.808835]  ?
>>> __pfx__raw_spin_lock_irqsave+0x10/0x10
>>> [  325.808841]  amdgpu_drm_ioctl+0xce/0x180 [amdgpu] [  325.809622]
>>> __x64_sys_ioctl+0x139/0x1c0 [  325.809630]  do_syscall_64+0x64/0x880 [
>>> 325.809638]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> [  325.809645] RIP: 0033:0x7f205fd12e1d [  325.809650] Code: 04 25 28
>>> 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45
>>> b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff
>>> 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00 [  325.809654] RSP:
>>> 002b:00007ffe9032b510 EFLAGS: 00000246 ORIG_RAX: 0000000000000010 [
>>> 325.809660] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
>>> 00007f205fd12e1d [  325.809663] RDX: 00007ffe9032b5b0 RSI:
>>> 00000000c0406448 RDI: 0000000000000006 [  325.809665] RBP:
>>> 00007ffe9032b560 R08: 0000000100000000 R09: 000000000000000e [
>>> 325.809668] R10: 0000000000000000 R11: 0000000000000246 R12:
>>> 00000000c0406448 [  325.809670] R13: 0000000000000006 R14:
>>> 0000000000001000 R15: 0000000000000001 [  325.809675]  </TASK> [
>>> 325.809678]
>>>
>> ============================================================
>> ======
>>>
>>> Fixes: dc54d3d1744d ("drm/amdgpu: implement AMDGPU_VA_OP_CLEAR v2")
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 +++++++++--
>>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index b0ba2bdaf43a..145cb222d5cf 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -759,9 +759,15 @@ amdgpu_gem_va_update_vm(struct amdgpu_device
>> *adev,
>>>     if (r)
>>>             goto error;
>>>
>>> -   /* For MAP/REPLACE we also need to update the BO mappings. */
>>> +    /* For MAP/REPLACE we also need to update the BO mappings.
>>> +     * CLEAR operates on the VM address range only and can come in with
>>> +     * bo_va == NULL.
>>> +     */
>>>     if (operation == AMDGPU_VA_OP_MAP ||
>>>         operation == AMDGPU_VA_OP_REPLACE) {
>>> +           if (WARN_ON_ONCE(!bo_va))
>>> +                   goto error;
>>> +
>>>             r = amdgpu_vm_bo_update(adev, bo_va, false);
>>>             if (r)
>>>                     goto error;
>>> @@ -772,7 +778,8 @@ amdgpu_gem_va_update_vm(struct amdgpu_device
>> *adev,
>>>     if (r)
>>>             goto error;
>>>
>>> -   if ((operation == AMDGPU_VA_OP_MAP ||
>>> +   if (bo_va &&
>>> +       (operation == AMDGPU_VA_OP_MAP ||
>>>          operation == AMDGPU_VA_OP_REPLACE) &&
>>
>> Something else must be broken here. We already check operation ==
>> AMDGPU_VA_OP_MAP or AMDGPU_VA_OP_REPLACE.
>>
>> That should be enough to Ensure that bo_va isn't NULL.
> 
> Thanks for the review and the clarification. please correct me if I am mistaken.
> 
> - For MAP/REPLACE, we are working with a real buffer (BO)

Not quite for PRT the BO is NULL.

> - So bo_va should always be valid in those cases
> - bo_va should be NULL only for CLEAR or PRT, where no real buffer is used

No, bo_va is a valid pointer for MAP/REPLACE, but for clear it is NULL.

For PRT bo_va->bo is NULL.

> 
> Based on this, it seems the issue may not be in amdgpu_gem_va_update_vm(),
> but earlier in amdgpu_gem_va_ioctl(), in the part where we decide:
> 
> - which buffer to use (abo)
> - and where it is mapped (bo_va)
> 
> This is how I currently understand the flow:
> 
> 1. First, we check the operation and flags
> 
>    - If it is NOT CLEAR and NOT PRT,
>      we take the normal path and get the real buffer (abo) from the handle

Ah, I see. Yeah, that is most likely wrong.

We should use the special PRT bo_va in fpriv for that case, otherwise userqueues would have quite a problem.

Thanks,
Christian.

> 
>    - Otherwise (CLEAR or PRT),
>      we do not use a real buffer and set abo = NULL
> 
> 2. Then we decide bo_va based on that
> 
>    - If abo exists → we find bo_va using amdgpu_vm_bo_find()
>    - If not CLEAR → we use fpriv->prt_va (placeholder mapping)
>    - If CLEAR → bo_va = NULL
> 
> 3. After that, for MAP/UNMAP/REPLACE,
>    bo_va is used directly in the corresponding helpers
> 
> From this, my understanding is:
> 
> - For MAP/REPLACE, bo_va should already be valid before calling amdgpu_gem_va_update_vm()
> - If bo_va is NULL in MAP/REPLACE, it might indicate an issue earlier
>   in how abo/bo_va are assigned, or in how the operation/flags select the path
> 
> So instead of adding additional NULL checks later,
> I was thinking to look into this earlier part to understand why bo_va becomes NULL.
> 
> Would this be the right direction to focus on for v3?
> 
> Thanks in advance!
> 
> Best regards,
> Srini
> 
>>
>> Regards,
>> Christian.
>>
>>>         !amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
>>>
> 

