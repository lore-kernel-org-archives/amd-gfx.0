Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27724C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 12:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A939110F338;
	Thu,  2 Jul 2026 12:27:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PEXWqRTx";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D1D010F338
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 12:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvL/fyKYwW3j18YXrkW/+eO9bvO2j+2yE27l5/0y4L69odk9pPgQZ67ueORPhNHkJEiWACBjDpf2dsEFIGsTxF++iiwIKPz3iTu7/ozxTIoQLTmgyjUNGGNwrGDiJaWZcPKiyP8zKYKH5fUFmmCneP4rm7/XxgLJlaiht2hmKvI171d8d4k8DPkSxpyye8vmRsDFo6QxYbv9C70pa73cchm6LB5PkDX0eN6UyB1clwRGPF4ue+9p8goCAxGRcUSKA9xWLFujnuafQ2/WVlYhQN6yV52qaVHwS8JQ3PjNoSl2B0FHn+yX+lHkuOmZn1kHy2/VTO1n3eeQCudoU7v6fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Np4rXGEpf1l1z0tsOj5QwoekqRVkonzC12xmfLXoYHw=;
 b=BTWtefRrc4hNJK9bTqp6h0s7jKs3aDv47w8tjQYfDWvPwhP+VVLoVALxDeQPin8aqabzMVI66g/9P7NH1ojsQ6D/A+nInIxFPOg5mR/4OJAfnuWzpo6uzxQZueJHKOWYi1iXuEKnUuc8ZAC3V99hzCmSoXZ/GuPEb0ZDyqTtpO9rG8fk0gOz/Wsc8twcEZsDyiocnkHY2MpYDCKWKpUvh4YizfQn7m6QGbZHq1iCLGeGkI7MziHohx1ZGIMdr4tcRbh4utLIrNK4YUDjV9f0Mgi5TUdHmUhNJeo4r9Qgi/jpO38/dv1nP5khPkflD7aESaCdoZ6D4XybHnlCY6SnPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Np4rXGEpf1l1z0tsOj5QwoekqRVkonzC12xmfLXoYHw=;
 b=PEXWqRTx6unfHTbdeu7HmngxwonMceW9jNfk+ECZIAzzpZITFwXV9kCmLMUyipmpzaFk8COzTlMcByqo4rpcHhld+xzuHkPeWs0vzS4MgKc0OP54q713O4c5eJ41ODzKikD6X7Gw6u2Z+UHafvWz1TnWYbXlTta3CvMELx4bwmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7132.namprd12.prod.outlook.com (2603:10b6:806:2a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 12:27:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 12:27:48 +0000
Message-ID: <17c52590-a549-4790-8b99-0b6575139da5@amd.com>
Date: Thu, 2 Jul 2026 14:27:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/amdgpu: Add PASID fpriv ownership helpers
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260702084021.3140071-1-srinivasan.shanmugam@amd.com>
 <20260702084021.3140071-2-srinivasan.shanmugam@amd.com>
 <5a6ad86d-64dc-480d-bb08-230e61534b79@amd.com>
 <IA0PR12MB8208395BD2307863D6BF516290F52@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR12MB8208395BD2307863D6BF516290F52@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0026.namprd18.prod.outlook.com
 (2603:10b6:208:23c::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a10120-6c79-4f9c-b200-08ded83553c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: jpcneCQoycNooZErLKKO4TQ4AR+3czR/7xh+dv41tE1dScoBbArNahbc8n6zKrIuBdiVJu2zfGUTDDhF8vSIvpz0QBsczyDNCn9a6+XvhrPVyaMKPPkhjp+VlqR+/ILVqj2NdtrNOwvg7mCxGC4nDS36CmAAE1lfF2hjtk95V10VniEBBmHfY5loP1ztgFTC2icSpFMe1hSKYn/7xmTUOcwLihWaEs5KPGsA697gj0JiLQ2uajveb9YaYsvKhG+UbniZgIs6At/Otq2MlIsPnk549c5dz8U1theKgWrSuFqXm5GVvH3zebgIBtk2Yf6nCGIMIRLXFMBWCR9bQTtHMCB29XlXhWc+E6uSU+Zn3ywZxgvf6K7HFUwIO2DuvF0BSUbn+R/G465o4bsLr/oAZb5KiITVtj/VUxzyChG9dcXBCQYW0FdvFEL+X61R65UeWrblv+WFuKzFM2E558ldzgA1uTBKIGZ7IdFPQ54/d7Wdr6uclwGiWkyyQc4Sc3Auwl48ajkFzg2kVGXkjnBQ6aofYSY33x+LYVt+8/gtSi76WxCVYPiwLIH5iNZZyGxUIrh+XdblEOrhqKAt3OXBBD66S1gUijg2bPG36h5YRozSBIpUHwlgzjyso3gCuiX0aKKFMkUzvcH/ogyWQ6BY3FnXXY7VVx//dGq6Z4K4JqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGIraENkNUo5MlFnWVloOUg2ZnczTGNScHhTeFE2V0tTMG9ja0JNZVh4NEZN?=
 =?utf-8?B?L0Q2bm9EZTVFUlV1RFNLTnYrS2VOTHdTb2ZuQlJSd1NnMnhzVFY1Y2FrWmRF?=
 =?utf-8?B?VkNVMVJyZlVJYjBtL2tCa3BnSE81U1BxZ1IzY09ZSnplQmpYVzdEenlYOVVi?=
 =?utf-8?B?ZjRlQXZWVEpmTHd2RmNFcHBud2t3dTFzU0VDOUdCb09ud0pjMCt1clNIZ2pN?=
 =?utf-8?B?NTd0dmFzMTF3QzY1WXNGWXF0V1ZWeG04Ym52VXg3b2JWTXdIMjM4aFE4S3F3?=
 =?utf-8?B?WDR6TEplMXp4bDRSTnljT0hENUNlbUg4dGp3SEFWdmlsUHV2YmVJUUNWUEx0?=
 =?utf-8?B?TkpMTnZ6MmZJekZ3WXJWRkR1VkVHZi85d0ZuQWpoTTFWYWRqNVFOUUpXcWNB?=
 =?utf-8?B?ZDVmV3ZIT09sSVphZHR6SnhUSkZwVGtVWlgrKzU5RG8rVTJWV05RazB5d3U1?=
 =?utf-8?B?SFdUSnMyZjJwTmJLRU9PTGduOVRwZmZuZ2lBcWsydGdwQUFVaFJmYldLbFpM?=
 =?utf-8?B?anVQUUpvYktsWjNEdW5GOGc0UTVSalhaYWtLSHR4U0ZHNXIyNkRQT25nNnNt?=
 =?utf-8?B?eVVzQk5uY0RjNTlTTXVnU2xhdzByUWxBWHdpWUVmanMzL1lNaFRXNzJ1WUQv?=
 =?utf-8?B?czBTQkZEbDJ1bHQzMWZkdVFvSGNuKzl5YnFIWFZVZ2JtNmNJd1dScERvcTg0?=
 =?utf-8?B?aDhpTlNTSUdXSnc3WDRvL1IzQ05VRHF4ZnIzeStzODM0SDVNcjNMVnZYSzdp?=
 =?utf-8?B?T2l2UENxbWZ4akVDQmNKUDFJczNieVZrSzRhNHpkVWlBWnJZaWloKzR6S0Jw?=
 =?utf-8?B?bzNETisvQURLdkovYWxLb3BYWU9ERHI2TDRFbTIxVklrOU1SUVFtQ0hZVWVx?=
 =?utf-8?B?RVVDc0tvei9vUWJxSFR0NlhhRDBTTEhtVm5SNWxlK2d3RElndklWY2NlVFJE?=
 =?utf-8?B?cHh3bzQwTm1HaWdMT0NOQmZxVjNtaGQ0RlNLU1NVR2VDRDlJaGlUS25neE5a?=
 =?utf-8?B?bkJLMXc3YjMwdWtqQ2NpejREc0NqMkRlSXllUzdZYkpEMGRGT2dnWnloZ043?=
 =?utf-8?B?SjhBaTllVStTTy81NjdEWE4zVWdoMGN3R3NLTTNvcVhGT2tpL1JCVW9JWk9w?=
 =?utf-8?B?Z2l6NVlmWG1lcm1OdkVFRlREQWlxRTBFK3hGdW9nZy9zeG1GQWRwTjZrZ2J1?=
 =?utf-8?B?MjJxM0JPVEh5WE5Fb1VtYlRsNmczakZnQUZuby9ab2FIWU90WERpOHFWTDJk?=
 =?utf-8?B?RmVVaWF0RHFSajJacFdQbE5zVTAxVm9mVHZIeDhKd05xVURBa1N3S1h4WmV3?=
 =?utf-8?B?M3RIak53eTVYZlJzWlF2QzV5a1VJYkU5WWVGKzBaQ3VXVUhibEFLTjVJVm8v?=
 =?utf-8?B?UWtyc2dhRjdtOFF6MjY0bzQ2K085YVNUakFlbTc0L25EY2VjVVRnY2NRaEVh?=
 =?utf-8?B?Tm5oSng0YWx4Z0EyYThlZjJYbTNRY3pRbXJVamlsMEZJZzVvZWNPVitDeGww?=
 =?utf-8?B?TDA0U2x6WGIxZ3V0UndUaHZkLzZlKzdTYTQvSTV0S21VRW5qY3hyS1dLck04?=
 =?utf-8?B?WUROMEc5aVloS1h1QXFuZEc5ZTYxZi9rZ3NPaHVKSHlOYWZEbGx1Q29uQW1u?=
 =?utf-8?B?MlhQWGJmVGNMRjNXRjYrb1RzZmpQZFE5NmJqMWVUMlV5NktORjJjbWcxTVUy?=
 =?utf-8?B?TzR1V3loV1d3VXkrZnpBVkc2aGpESTNRUmZPZmFaR05OMmV2UFA5bjZtemNM?=
 =?utf-8?B?QXJ4Sm5iM3RNblNZck5iVW5lUXhoQ2FRajJWKzVaeTQ2ZWxRRUI0eTlRczlU?=
 =?utf-8?B?NUcrd1h5ZG5sTkpMWktwZnJpbWxhS1dBSVVCbHRFaFIxcVU1anpDTUlJRWgw?=
 =?utf-8?B?WFNPYUNpcFN3N0I4RzhxZ3B0a2V4V2Nkc3hjbmU1UGxqbVQ5RU1QTks5ZktH?=
 =?utf-8?B?ZVN5MytCTmkxRWVEcXY4eDZqV09vVzczNEN6cHpWWEVHUHZZbkRxMnpVZTA5?=
 =?utf-8?B?SjhhdXkwc3hmUmd6VlRQQ2k2aVBFQnRaNXI1L3lhcm5QcEEvNkt4amcxcHVP?=
 =?utf-8?B?QUI5SXgyTGdPRVhrVWYxS1pLRVhBV2ZFY2JNQzN3b3ZNOC9INDZ1dnlHdTdB?=
 =?utf-8?B?UElQa2d1YTlqbHVUbHBwaHBOWkpjM0x5bjdKdlBNeGRPM09TQ3VFZm5CcVhD?=
 =?utf-8?B?ek9RSDU3aXZkaEF2SmRpdG9xRmlSdjVPTnhzREpmQzNHeHpPeE9YMWY0MTNX?=
 =?utf-8?B?bmNNcEEyRWlldWRkMHJWT0xkd2N5dDZ6ZlkwaUxCOFJSR1pzSkZ6RkFwWnRP?=
 =?utf-8?Q?tDkMsukvn3H0FBN8yy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a10120-6c79-4f9c-b200-08ded83553c0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 12:27:48.6504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfxKqcMnHXQ8wc0k8XVdPvUj7SMVtqf/8Slp2ESGDKOY6zHNGOXpI8QUIPVFaxzU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7132
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

On 7/2/26 14:13, SHANMUGAM, SRINIVASAN wrote:
> AMD General
> 
> Hi Christian,
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, July 2, 2026 4:23 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH v3 1/4] drm/amdgpu: Add PASID fpriv ownership helpers
>>
>> On 7/2/26 10:40, Srinivasan Shanmugam wrote:
>>> AMDGPU already has a global PASID xarray used by the PASID allocator.
>>>
>>> Currently allocated PASIDs store a dummy value in that xarray.
>>>
>>> Add helper functions so DRM-owned PASIDs can store and retrieve their
>>> owning DRM file-private object.
>>>
>>> This prepares for using:
>>>
>>>     PASID -> fpriv -> vm
>>>
>>> instead of the separate per-device:
>>>
>>>     PASID -> vm
>>>
>>> mapping.
>>>
>>> v3: (per Christian)
>>> - Document that PASID allocation is intentionally kept separate
>>>   from fpriv registration because fpriv is not fully initialized
>>>   when the PASID is allocated.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 126
>>> ++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |
>>> 13 +++
>>>  2 files changed, 139 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> index 684f40fce73f..5333937f0d04 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> @@ -78,6 +78,132 @@ int amdgpu_pasid_alloc(unsigned int bits)
>>>     return pasid;
>>>  }
>>>
>>> +/**
>>> + * amdgpu_pasid_set_fpriv - register the DRM owner of a PASID
>>> + * @pasid: PASID allocated for the DRM client
>>> + * @fpriv: owning DRM file-private object
>>> + *
>>> + * PASID allocation is intentionally kept separate from owner
>>> + * registration because the DRM file-private object is not fully
>>> + * initialized when the PASID is allocated.
>>> + *
>>> + * This helper replaces the temporary allocation marker with the
>>> + * initialized DRM owner.
>>
>> Taking a closer look at I think we should rather re-structure the fprif init code to
>> allocate the pasid later.
> 
> Thanks!
> 
> Just to make sure I understand the intended initialization order correctly: when you say "allocate the PASID later", do you mean moving the PASID allocation until after fpriv has been fully initialized in amdgpu_driver_open_kms(), so that amdgpu_pasid_alloc() can directly register the fpriv without a separate amdgpu_pasid_set_fpriv() step?

Yes, in this patch just give the fpriv as additional parameter to amdgpu_pasid_alloc() and make all callers give NULL.

Then squash patches 2 & 3 together and switch from PASID->VM to PASID->fpriv->VM mapping in just one patch.

Regards,
Christian.

> 
> Best regards,
> Srini

