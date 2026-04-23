Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B85F9936B
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 10:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D093810F089;
	Thu, 23 Apr 2026 10:47:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zxpzRMp7";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2BDD10F089
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 10:47:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxahz3ZFHjhZXdp9J4OmBHEv2WfFrYVlFnQShBTawZLLfpku7nghFoNYBBeU4bd2uc9pAu1/H061bu9FuxvPzk7b+/38c3yEUDRxUA6FyKHB1giPtjyAPjT/RUdOU9n83ONS9uopnCl1qR1QpSieX7ebBaTpfYumBnGmsKsfXKocneXhUQ+OP6v/0LD3y1q1kV0I662DpE20E23/tmPgA4IC7GH+VOPITvdiWCDy5sdnQ1+L7KU9X9s6trE7xEm7Rv0CLlFeQFqdQuSzO7Z05nuPMf0wwY/RnVLXN5wj9bwgds5JhRS8Fcu8cL0ET/1mp47GKw3Iz2wHDGtzoZ5Ejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pKM+ADOxrkLmsxp+8WkuiBEcIxBn965glfG2wOlSE4=;
 b=aG7tuA/Texe/g5y47MDzXR6Cdrf/R5QAWpKKFVqZoKHTiMlJsTmni11PsO8ziHxdRzV+5ZexHTdV37q//V7bVnQ1ZloSVKCoWF+woCiTAdLBhqCwFnx6I+vd5vRxnqKbmGwG6CcQV890fEXJybTsae4yhFCHYOT+xI3qNIAQ7ePx6kdmhMiMz0T0iGgL+Am+yVaPjw3790zwvwPaUiWMe1xF2R3yN+7g/i2Q9IdIuarl6LVvKJo0bsDm7PIhXPVOvlgdR7car5ax6MhbHbcV05HoFrhX48oCbTb0IXwHffcoxsbCUM5Yml/OA2FWfLNUt5sPknGBL1p9Us6M51jc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pKM+ADOxrkLmsxp+8WkuiBEcIxBn965glfG2wOlSE4=;
 b=zxpzRMp7bRTNrb4aGgoh+IWz+rzh3eE7erN9z6zoVB4mTd2j2tnJgHiOrCCgZpJB7bl8Zg6+8EA9a0M7sfVRRMGSAi04Ywo3Uwx8roqms9fQshnDJucvbjvrWqFY/3YDm6xduTpNdrgg+jGtFRtkZyE5DDQE3PIlTEYOhtmgcDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY3PR12MB9702.namprd12.prod.outlook.com (2603:10b6:930:103::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 10:47:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 10:47:35 +0000
Message-ID: <03e6c28c-5c16-4e5d-8c26-a214f0aef012@amd.com>
Date: Thu, 23 Apr 2026 12:47:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/amdgpu: rework amdgpu_userq_signal_ioctl
To: "Liang, Prike" <Prike.Liang@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-4-christian.koenig@amd.com>
 <DS7PR12MB60051B45E53E61949D874CDDFB2A2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB60051B45E53E61949D874CDDFB2A2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY3PR12MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1803ef-e2f4-4831-f48d-08dea125ba8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: gobzIKFnJnQR/7+cKKeHgD4ooGO+7Dk1859/VNHBskiRqbhu2T+vvrDVjnAmTMT7FoZVFZdVnzEqnTeYE2ug6fQUsXOzBM0VRW8GPGgMWZYSTxGtjsPVH4huVQR19aQrXIv9cCKxzmPq8G+FSKpDfLrVbSKQeBX+4IUfM2DtXQyxyLnhezKE9Tsw+wXby5bCy1/hhLgAct69Q3ZbCx4/O4UBNzTwL4vu9K8+edfcH4IxcS1PLD/EerCnhG55z6m2FBs3FgAU13kfOybFVZMYuStJagSYcpiIyDlSu/eIMMU3B/PWTyRd/VWzaN+1PFinXsFmXpvrMtNzC0P/eBiKUJDZLiP1LKukA2x0K+f6I0yiwbH9kVIc8J1+OJvpuX8x+mypA0yrTSdI+DsVT52erkrL5sUIJaa6VFDOUt3iKYbWjy2DhiEveNiY8twAjUkzscoUoBvv/SPgUakLZk3MasTYVo/1+qNvsDu+nBqXKkzdOifrC6yNeAbrAkcF0GIWB9+hBPfkETcinHPSIbO56Y0KX6x2WLOU6gjoPXPD5bwPFItd75Zm9Q+uKaKrIiMAoOsw3qWUcFYhO81BHirKsjCEby+eyUpnSwA/NjO9NBpq1JT6Lo9KXXsBtdL19yDMuB3+5QQZ9dpSpxM3PkHi7Zvd8sF4cwzzkB+XajVhGV+miChLniYNdFo+eCp/2t6C/pA2ONacgyXgE7OaQIMsVksMw442C1Flspe49PjuoVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUN1cDVaQzd0UWVRd09lWVlmdmhrMDdrQzBSY3kySzZwQWJTalZGc1BFVyt2?=
 =?utf-8?B?Y25WdjEvaDNVZjZkK2szMThTZGIvejNSOTlEdXg3TSt0ODVzeTUxK2FBeTI3?=
 =?utf-8?B?Tm5qTGlZaFhjNzlYUThMZUtNdjZpOE04ajdYMU9ZMmZXcmZhdThyRitlSHM4?=
 =?utf-8?B?emdLcnowRXd5RS9ibnJzcVpKalZseXhQbnRqZ1pnQk1hM0FkYmR0R3NySjVC?=
 =?utf-8?B?b1d5eFFKUjQxMG14dG5xWlVSeGFPbXRaMEZPTitmbFNHNnRvN3B1TENmZ3JK?=
 =?utf-8?B?TmRmZXBBeU1TTzhjUFdtMCtONm1TNm5US1NoZm16NXA0ejVnSXRGYklPR0hi?=
 =?utf-8?B?UEhlaXhzT2JwOWJTUWNqc3pFTGFQb053ZkVCdzQ3NUtpV1BLamJoRWJkdXp0?=
 =?utf-8?B?YlVVM0I1ZDQ1cTJEWkJQd1BVTXB1VXdaSnhqQ2ptbFpRS0d1V2tZZGJwaHZT?=
 =?utf-8?B?SjlzcC84WXpkaHdobFlqZEFwMWN4cUFBN1BlYkFLVWE2WXlMdWE3SllpUDkr?=
 =?utf-8?B?UjhOUDJodC9Vdzkrd1FpOVRzemQxem5SWTNMU0RNSjFFOGJlKzF3VVBEYVo2?=
 =?utf-8?B?OTY5L2xBMkY0cWtVdUpYd2gxTUJ4ekxUOXgyOU1ydGxWWFpOcTlFTHdtR3dU?=
 =?utf-8?B?bENBZm54OUx1cmZYRlJPb0FCT3hOb1dkY0FUbGZ3Y282UkFMSnlNT2hvNDVN?=
 =?utf-8?B?YUNPQnFqUk0xSjJNRWpUbVZwdDBnSmhJSUpFTzVYOUlaNUlSK21PRmc0dW42?=
 =?utf-8?B?L0NoTkZzcHljRE9sS2lvNzFJODZiOVdZdkF0T3JoYkFUN05UYWthc2VuVzds?=
 =?utf-8?B?WFdHcnc0K2tydURvYXJtN29LYVQ0OGhhZ3FNdThlMFdLVkY5bmNzQStOWGs3?=
 =?utf-8?B?aHkwK1BtamVMdGRqS3JRNXd5SmMveEdFZm9PU3lIS01xT29scU8wTHRZUW9G?=
 =?utf-8?B?Z3YvRWN0Zk0vS2F6M3gvYlFXY2ZZKy9SaWpQbWp2MWdUYXdJWTRqcTRHRVdM?=
 =?utf-8?B?N0hHU3IrTDlpQmlVejBkbWtHTHR5d3lDaXphU2RNa2xnMHV6Y29JN0ltMCt5?=
 =?utf-8?B?YjNzcGM1cWJBMkVDUG9lSm1ZK09BcTF1eFZCVjNBOHQ1ZjBxZmNQMFlwNWUv?=
 =?utf-8?B?NmF1WXVLaEJtZGljWXJqaWN1dU95NER2S1ZYK0N5NldkMjc0YllmelVjZ3pL?=
 =?utf-8?B?VVBBUHRrUUFOeHJRSm1ZTll3bUxJd1hFV3NSZDdMQ2FMKzNiU1N6NGM1U0dU?=
 =?utf-8?B?bDZyTzc0MUtBcWtuVzJ1YUEydmJGSlNUbGVLdzVRRyt1TWh6RXZRSVNkSTR6?=
 =?utf-8?B?WGpTWHY2a3V3WWdTMUVxV2VNVXhSRWp3ZWJlT0owUXh3RDJLS0NtK2Q5dTRy?=
 =?utf-8?B?aG1BVjBwRnZLcDYzekpyMUNxVGlTQlEzb09PajF5T0h5Vi9pbFlzcWpoWEQz?=
 =?utf-8?B?bGZjNkxYZUtrWmNYMGdLTUN5dDhhQUd4ZkkvYjZXNnV5TjZCVU5lVkpuSmNx?=
 =?utf-8?B?Q0xYUmVyTUU5VzRWS24xTWJRb0o1bVFGWHp1NmNWVU5FVmRteW1iNjdiVEhv?=
 =?utf-8?B?cis3NFNaZVNOK1YwWU14MVpwMkwwYkZjSXFrbTVDYkk1V0F5RkZVK0YyWVBI?=
 =?utf-8?B?T3VlOTZ0aVBjdkRTRDZlZEdPNGFvYUE0am5NeGV4aFZuNFVSdXJ3V2VUaXVW?=
 =?utf-8?B?UzNJLzRKQjhiZFFlK2t1cVMzTzV2LzhGN3k5N1dLZ0daY3E3aTVkckNLZStz?=
 =?utf-8?B?UVNSMCttQTMzdUxHYVUrV3NLZ2paYXFEVG00K1o0WllMQnZDeStCTTVGZVN0?=
 =?utf-8?B?MXRSYzVKRUNUMVBqRnp3UU5oVWNCc25JYXlnemFORnhkRE1UMmdVWFZGc2k4?=
 =?utf-8?B?VFE5cTVaa3h5a1JjYmEvNnZjTHpRdTZWbGNUZ2tRVGJxeG1YTTFHbTlSekZB?=
 =?utf-8?B?K3FlWlVzdGJ5U21ITlRlMjArd3hGTzZXYkRic1c5N0xScjJ0dHU1N3A2VWU0?=
 =?utf-8?B?ZXNDN1l5TU4zMjU4bmxyUXB3RG9rWUtSSy90bjNZam0xRWVzSzZKVlZLb3dp?=
 =?utf-8?B?VDRaZEdvQ3pETHIwcUsrRDcxeEduTVVxYTVydUZmdFhNY2FGSmhaWXVCYzQ4?=
 =?utf-8?B?R3gzZTRXWng3eG9jbno5bysrd2tHamlqeTRNTThBVzNDZlMrNFk1WkdnK1hY?=
 =?utf-8?B?QjlUYzE3TkVRbGw2TFB2djVuRWsxQlZOeDVKcGc1Z2toZVNxcXpSS1M0MFFP?=
 =?utf-8?B?OExjWlY1SGRuQ1ZkWTJxUkxXNFJFWDFVNm5Yb1dyOGZFY1JHS2xuYnk2S2RO?=
 =?utf-8?Q?yif2tpxixmDfT4HvnE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1803ef-e2f4-4831-f48d-08dea125ba8f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 10:47:35.0317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghkSwhDWf0oO0dWC30tANZ3aq2svJvcxmxfWTdWXy27SAWf0vlGxuy4pjW+kacMX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9702
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

Hi guys,

On 4/23/26 11:58, Liang, Prike wrote:
...
>> -static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
>> +static int amdgpu_userq_fence_alloc(struct amdgpu_usermode_queue *userq,
>> +                                 struct amdgpu_userq_fence **pfence)
>>  {
>> -     *userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
>> -     return *userq_fence ? 0 : -ENOMEM;
>> +     struct amdgpu_userq_fence_driver *fence_drv = userq->fence_drv;
>> +     struct amdgpu_userq_fence *userq_fence;
>> +     unsigned long count;
> We must initialize count; otherwise, it may contain a garbage value, which can cause amdgpu_userq_fence_alloc() to fail and,
> in turn, make userq fence emission fail.

I've got the same comment from both Sunil and Prike but as far as I can see  and that is actually incorrect.

> 
>> +     userq_fence = kmalloc(sizeof(*userq_fence), GFP_KERNEL);
>> +     if (!userq_fence)
>> +             return -ENOMEM;
>> +
>> +     /*
>> +      * Get the next unused entry, since we fill from the start this can be
>> +      * used as size to allocate the array.
>> +      */
>> +     mutex_lock(&userq->fence_drv_lock);
>> +     xa_find(&userq->fence_drv_xa, &count, ULONG_MAX, XA_FREE_MARK);

The count should be initialized here. But could be that this doesn't work.

Did you guys got a KASAN warning or something like that?

>> +
>> +     userq_fence->fence_drv_array = kvmalloc_array(count, sizeof(fence_drv),
>> +                                                   GFP_KERNEL);
>> +     if (!userq_fence->fence_drv_array) {
>> +             mutex_unlock(&userq->fence_drv_lock);
>> +             kfree(userq_fence);
>> +             return -ENOMEM;
>> +     }
>> +
>> +     userq_fence->fence_drv_array_count = count;
>> +     xa_extract(&userq->fence_drv_xa, (void **)userq_fence->fence_drv_array,
>> +                0, ULONG_MAX, count, XA_PRESENT);
> We may need to assign the userq_fence->fence_drv_array_count the exact copied number from the xa_extract().

Interresting point. Why could that differ ?

Thanks for the comments,
Christian.
