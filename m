Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DABFD8740
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 11:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C5910E209;
	Tue, 17 Mar 2026 11:23:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mhx/16kw";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012035.outbound.protection.outlook.com
 [40.93.195.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B78610E209
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 11:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRwggruqP6aHjEpXzRdSNaKOPCu0PzJq7njLFaQ5jHF5ekHq+WjZKRbfhcbei0YhpTANJg08wfi+KarXizQQtA1JuM86yq1nZvWwt0Hw2yLQ3OoYr/kLvrHjKc3h8VNPVp/i1XueT8Zp9IYtNgqvIzCYQGLotEsLqaKNXU1RZzMkWMKsVlYYsriryeU+yRK7N1o6QuS7TqNqPBBFuPI5LHXmD4Lrn0Y0/QTDuv5Lv+jlZJfkbWQZQHOZqUy17AMwPnhIB3N6pWNdi1k0VHj4yxh2KGnT9FgZytk6cG1sF0FF5sNcDsA1EdYS92wrPGtUsZQWdSmNHQZ6FVvnWGgwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqvFWP6gZgBI+odd4h0QvNT4XvFIEijohAiDk4nHd/Y=;
 b=wiywzbguKeg+27bLP8zSBgI7SwYgX/yYzC6zussstVkFD4zqyrxwVoNc94lIkZSjLigUOZFrsSDeqa/k5osUY5GyVSyagX1yrbm0kIRi9DxEA5WbK6eYdsQ03rrWsQ+HgNIAvnsiM9NUKkhrTLA0JeSc+39AIcO48CbNB+VvJadW9Z0fKeqnMh3wZkZ/H4CNtj+Mc4KIzczNOYPAv5ILWcHXiYqVx6do+ciMSNqocgj/H19tMcw0QbS3bgyBRfB3DriZ1DJfO/0zDgDRLiSE2gSwxF8BpVXWcvW7YQxeLwWQm0QQR75pQNIZTNvPZ+RtWlO9YgG0nxwx5sYQmNNKlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqvFWP6gZgBI+odd4h0QvNT4XvFIEijohAiDk4nHd/Y=;
 b=mhx/16kw3pRqql060bGyYskwSVZn9gCD/CMHmRv/OdQ5FThYqXvP6xWHSq7mnT++YlzwCvYOoghZpy7ZmP74qBflpcW8LTyiGqmseTd3pkNTp/Yrt4qJ4aNI/OOi8oLubLkuctIDKsngNkj6TtRypuY8fXLtUa4B6xZ2ev18DUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 11:23:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 11:23:28 +0000
Message-ID: <9bc4dbbc-1900-4620-9525-fd34a50fc565@amd.com>
Date: Tue, 17 Mar 2026 12:23:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/amdgpu: completely rework eviction fence
 handling
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "tursulin@ursulin.net" <tursulin@ursulin.net>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-4-christian.koenig@amd.com>
 <PH7PR12MB6000407BC326A3D9ADB2AC48FB45A@PH7PR12MB6000.namprd12.prod.outlook.com>
 <074594f1-59d1-4cd7-9b2a-997106b76167@amd.com>
 <PH7PR12MB60009290374F2995C51FD4A1FB41A@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <PH7PR12MB60009290374F2995C51FD4A1FB41A@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:408:ff::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a15f6c7-aa6c-4369-6073-08de84179c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|921020|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: mvMK0VgKnGvzKlTBd+t4ZzdX2fAVjYxvfvs8EJmwxyKv8bxtfd2FbyZduml7rVw+V7JtfOTc8kjWtivOrjv4OAuqogF3Op8cxxkzHcdyk1aVBEf2C0gmlXQOtbBj2qzQlfp5ZBonwTWunzDhLHhL3uL6czP+IBAtKMRz9+wrejXS51uSiP9vYDcCaa+oe9HgwLG7H4kblKCEGw1MZAQjHtaBTmBZMCKhuJx0acEdB9MHoSGbvizZZPe30cR+6cyU3WgHPV9WYlcyaNoqB79hkpvSFZ54/hQDoIH0Pa1pbIfWQPLqBBci6jrXnzaPCDX1xD3YldHEefMPVV6Ga3xymAjjscpcxDx2zMNOa0Fa0QnJTnnXrGF5+GSW+IpcoVqPOwDicjrox+py2q1hd1XYn4FsRJzh+QY2TvolCA4Z8kz3BKYlgq6sjmIX3RmDtZSry9yTLT1hKMlRlHXyvu/QPXoD9qSiW5e5nKPK+E1H99oC/eo30bXEDtL7QnCaHvJwoaFnJ6CRd14WaUap8VzRs+4tBHopmXXbO+zWGuFXjJ5UShlKqcxCDpipn+GOz5xZkjTUoyUzP6IRXtjUkDtJuGd2UnUTAoPYm5UJETL3tKAtsyefBDchgdf2UZ8QXlPt+CjT+gBlVCszOIEp2BiQNMsAT0+rc++ch3/ZHJmqNRTPGmdweIGdQdajQk3/JQg71x2bN+FR3MeCKMSVLJNDYipx9IMQT9Xb1ewK/g/NZAM14QOmsCKWYKU/cXAVXEeqWvjF/hyOEZvNZj9ueba13Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(921020)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUFIRThOcUtIVUdodGhjUTB6eUFaWk8zKzd0YVIxa3ZUME81WHZMMURPQkx5?=
 =?utf-8?B?aTBBamV2a0dpYnhWWldIQWgzWVNNb3RCUUJoVWc0bTVITHgwcFg4WHNtR3E5?=
 =?utf-8?B?RUhJc0FKNzlONXpwd2pWOTRxNUMvbG9pWjQ0VEJLWEFRbVQ2MjZlRUpNY1Bl?=
 =?utf-8?B?T3NvT1hDY0E3MFI3alo1aEd2R21LRmlva3lhdFF5VlVyc090TDFQWmFQaTc4?=
 =?utf-8?B?dVNMMGZrZTlqL3FkempzcS80UEthZFhzampDUEc5Ni9FeUlSaUFyR1hrajJO?=
 =?utf-8?B?VzN1UXlKcWkvQTdscWgyWEhGUEFzTEZNVkgwbWFGQytONCtQbDhaeGFNL0hH?=
 =?utf-8?B?MEpNSHhTUERiamVTMm0xV2c0a2FoTlhDbjhDNlhEZjZQU0hsQUtjdkFleUhK?=
 =?utf-8?B?VHMyZWh6QWZOc2h2UzlOYXZTRjkvYzhrVm5CRytITmk3dG9YS25GMFBuSGRo?=
 =?utf-8?B?OW02bEtBTkI5ZERHTEIrRGtvOTBuME51UWxCVVp5dWZEdlY3WUpIQlF0VDZL?=
 =?utf-8?B?eVZUdDIxcHdmckNPVlNjRzZDUTBoT0NGdmJrZ1Z2M0RiMHRRL0xuVmRrSGRI?=
 =?utf-8?B?RzdhY05xdjRqNzE4eGVVdFV5cU4vdFJuSWJTNmxBSzFBdlhiVUhUQzBEUEY5?=
 =?utf-8?B?N1piTnozeDg3WXR2VnZLUktjQjlXejhhS29FcG00KzZudkFvc3RnN2R3TGtu?=
 =?utf-8?B?WXhMZzBKUEIvUENXZ2lHdEsweWsweFB1ZUNrS1Z2UHFsc0pDSUEyTGFBSjRB?=
 =?utf-8?B?K3RsV1hjVHZveXRjTHJmcy9RWWRWekxjdEI0NFJjb1NCbERGeHRXMlJXbmxU?=
 =?utf-8?B?K0pibjNlV21QM0xkcFBnYWdZYXg2KzFvMzZDeFB0SjNabks0NjdyaEY5K1Zv?=
 =?utf-8?B?YXRzMVJOZEZMa3FLdzdQVG5OeVZ6NWxvNDJFR0xBTDVsWmNMdldnM2wzSVUv?=
 =?utf-8?B?bEJ6ajZXcDR0OGZUT3kzV1RteUZidkFkb1JlTFZXRmFBdExGV2wrMlN2RUFN?=
 =?utf-8?B?MEQwaEtmOHA5L1FWTVFqenU2VlhCdkpORVRBQkNlNWxrbWdMN3JNV3hqNkRN?=
 =?utf-8?B?cVljbkxnQ2FYYTdOUmtZczR5Vkl0WXdlQmFaYVVoaTVIbUZDc2xSV3NnRjc2?=
 =?utf-8?B?RFBQRW5XNHcvUHA3Ly9JWU1HNTBtMTZEbTV3a0RZenVBeXNkUHp0Vk5LWUIx?=
 =?utf-8?B?SjJaUFNUc3RUb1hEL2xHWUM4SC8rNHNYSzZrTXZxRXRFa3VkOU9uOTJGaS9M?=
 =?utf-8?B?N0U4NVA2Mk1uL3ZUNnZBdCtpd2oxdTZRTklUVkcvQVVoa054Y1lSZnhkN212?=
 =?utf-8?B?M3Z3WVV3UUxHN1VsaW9DZTZzdWVBWmJqb3RqSndGME9xVVlJZEJHdmU4ZWlL?=
 =?utf-8?B?UGFycTdXalpQU2tkZS8xRFdPaWxlRTVJU0NxQklWbTlJZTkyL3YvSEU2RGlh?=
 =?utf-8?B?SFdvd3RYdjR3L0V6Yi8zZ2xXVGVsT2FtVjNoU3VmaGxMcmVOMkV6SVVmbGFW?=
 =?utf-8?B?QUZvNXAwUVJRT3ZzNGVVbnpvQStmRTlwOUtXY3VOVElQMitIdnNYcSsrOTFK?=
 =?utf-8?B?M0hSbDM1QkxxUHk0a0cwdzdmZlQxeUViczZlVFVnM3pJZGhNNUd0V3Z6ZlNy?=
 =?utf-8?B?SEJBdFdxdDZ0OCs1S2FPRGFLRVh6ZkZ2YmxGbmdXMk9IK1lobzZmSlVqWlN1?=
 =?utf-8?B?ZmZxckpZMHZHdGFBK1dCM0xtTkFkMU44UVU3V2M4QU5HYmp3QTV2MGhnVEJ5?=
 =?utf-8?B?anJ2MWVxWUc2YTg1cS9qTDExbHZ1QU9SaUVFbU5IWmk0N1p3dVErL1IyNmdj?=
 =?utf-8?B?eVRkOTd5VC9VQWtjQXV0cS9tekorRXAzMlRFa0t6YUpJN0czSlVwZkU1ZkVY?=
 =?utf-8?B?VTRMOTU2MXdQOC9BZUZ4TmQ4UllwK05YYWdNUDBiZUF1RUdTaDRoMzJkVU4v?=
 =?utf-8?B?Q3dYbUlpelFmcWdzbWxlT24waUk2TlQ0VFBvL2hTaXAxQjhTQUpTZ1orUWJD?=
 =?utf-8?B?VFR0L2FnOG9IajRtUUEramV1azRFVjZ4N1BsbWZBdFYxTksxNkJpclNyVW9B?=
 =?utf-8?B?enFnc0JSQkZPR1BLSlVTUlNvR1p0ckRXdTZLc21YQWsvejZqblN0cERId1gv?=
 =?utf-8?B?K1JrQXRCSklicmIrZXJkTDJSNFFhUGhNV0FVNlplTWdrV3k5cjFMUnlHaTJJ?=
 =?utf-8?B?UlpBK3lzbWYzMHBpcTE2cTFXRzRhWEJUQVRyVjBwbGdmMTlSeUlFby82ZGN6?=
 =?utf-8?B?S2x3STBsVzlWWEo1b2dITm9SVld3Y1BtbUtxMXBQTTBTUGpWbjRYMHR4czBX?=
 =?utf-8?Q?iqEtsuqkd8sVlpKNVS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a15f6c7-aa6c-4369-6073-08de84179c94
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:23:28.4538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sI+rrTnfmKXHeDkXlUeEl5IOtZHOd+5fHdg2rOni8ApgyxawQbdcn6x/CluX19u5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
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

On 3/17/26 12:21, Liang, Prike wrote:
> [Public]
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, March 17, 2026 5:57 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; tursulin@ursulin.net; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Mohan Marimuthu, Yogesh
>> <Yogesh.Mohanmarimuthu@amd.com>; SHANMUGAM, SRINIVASAN
>> <SRINIVASAN.SHANMUGAM@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>;
>> amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 04/11] drm/amdgpu: completely rework eviction fence handling
>>
>> On 3/13/26 09:28, Liang, Prike wrote:
>>>> +void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr
>> *evf_mgr,
>>>> +                              struct amdgpu_bo *bo) {
>>>> +     struct dma_fence *ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
>>>> +     struct dma_resv *resv = bo->tbo.base.resv;
>>>
>>> Before adding the attached fence, there requires allocating the reservation fence
>> slot first.
>>
>> No, the caller does that using the drm_exec.
>>
>> Additional to that it is way to late to do any memory allocation here since that could
>> cycle back and wait for us to attach the eviction fence.
>>
>> So by reserving a slot here you would just create a potential deadlock.
> 
> Is possible pass the wrong fence number through the amdgpu_vm_lock_pd()/drm_exec_prepare_obj()? I saw the fence number assert error during attaching the reservation fence.

Yeah that is perfectly possible.

For kernel queues you need to have something like number_of_gang_members + 1 (for TTM) + 1 (for page table updates).

For user queues we probably need 1 (for TTM) + 1 (for page tables updates) + 1 (for the eviction fence).

Not sure if the calculation was really correct.

Regards,
Christian.

> 
>> Regards,
>> Christian.

