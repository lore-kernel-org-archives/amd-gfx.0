Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2241606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aYnBEb27
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2845410F2E6;
	Tue, 27 Oct 2026 09:07:10 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013036.outbound.protection.outlook.com
 [40.93.196.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D6110F2DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 09:07:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncfsGNVIIqMkMOg+f2na9LF7/8m1sEegL3+Q+jUC3EqHGcsHeqAQlwiz+cPqAYk2ySWq8bYbS8gBuj4hXbB9JvjNaP26/haLwJcbOmqF7qH+pDsj0T0VTDS2JqYsGj1rhQWq/IVHibci7HXZtUqExtw88jW6ezxWE6Ngoq2oix0lxW9B0ruydai9ZHNpfJSV0xRS3mKGYZyqcoVhIEJOFPu0FIGEYWxUMuAq3IqCcEB68UYYP5IprNmgK0Cx+Dc5yG+nQhqtNbzEir/bL61jHNfOu7Xj4dymUWEQvvMBnlftg4Y9fmh8FE8qnhwPO+B9PsLIX2oLRuJGnKBPIV6h/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycgCs5KOKmNsvJ5yvPawIYB59z6Bttj98q8JlD6JVXQ=;
 b=tynnDtiyx8lbH+8CaOypE4Ep/0Vwn+Yo5zgyubUlAFqQMcyZIXhqOd9EacP67bCgshPrHMMxq9Mde2zpyqD++Hvb8raZuZIH2KIgHXBFtgMB5X4hx/DC4fNpDDJivZnsyN/lzn/xzwqRy/0g/Ur3cMj9anDEnBKZdZAXPSLiPcleVbLkOK2S6ozao5cS9o/rxy+AxuzTsVYhToIuvtTkuAUp9/SWEpOaekSZZOqnUBOAZghplMou3LC3jHjIg4lH8pEbqTAFyBRWt1hMZnOe+5FqRSRA9SBwro24hmMGf2NWHzlvb6DOJBTp4tkBUcVEeIt1ONofNb5Ei0xbBOVIaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycgCs5KOKmNsvJ5yvPawIYB59z6Bttj98q8JlD6JVXQ=;
 b=aYnBEb27Av615B3/TenGTxdjc5l2GzNpdfOZ3dxiq9BBDJ29lLnyglm+87GvNXA30zn/RrpoT8A7YzNgDNox1Q4C1cVt+1GJuPrGpkVYctObn2KUxWdBaJwcShMZTiEEvp0gflxzLP/ZoU27cV8WDq/Jcwd4KSG3uqzwJRym50Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 09:06:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 09:06:54 +0000
Message-ID: <7ee3587a-259c-4742-bd50-01c45a2fb2e6@amd.com>
Date: Tue, 27 Oct 2026 10:06:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] drm/amdgpu/userq: remove extra blank lines
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261026065735.3299011-1-sunil.khatri@amd.com>
 <20261026065735.3299011-3-sunil.khatri@amd.com>
 <CADnq5_MzaEFA5eaBv9qFUrpnrPGKxwCsB4dqJcDePjKROn0N8Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_MzaEFA5eaBv9qFUrpnrPGKxwCsB4dqJcDePjKROn0N8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ac45ca-f02c-4fbb-e1f4-08df3409a52d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|261009223027099003|261021123027099003|261022105027099003|261021121427099003|10067099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|4143699003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: xB00B4RcDMPqJ0md9zrtxHR0Eahj4Qie8aLAXrLbOSy6gdDFL85h5yCIM5PjwWME+td8mDAoaBzJDDb1UQLVTAqDAy9cQq9UXfwACLYcc4TVdZWenVvLaNDLOi+uZjkAvlEAO5WI7mNtp6b1hPErqgdhZgtKH/DXYkfQ52j1OQSYlFRN+mViuEJ7Mc/SG66HZsVm1NNJ3LR4iZptq3PxwcZ912JxlOpRVEMxFExH3bfNrts+cY7AX+jXb+IveiyNeYmoivLrkZN0D+DYRp4SUunfDAU0Wivgc8GQXfWLO0G171E2h6PiXp9i47NguLQEvXEUIrESUSi05bRiCmaUTlEX2Fel16FM+823+yL42SfYJGeAHyy3hs7AlTmDwqpsFUhmDL9dOToz+5QDUQg5e8PRCFEsrPLpi4c4jQLLlO1CAzUcw5Icv3Gs0/zeO6imab11miewIp/5myLHB1Rz42xxsUDZJSTH8i5FTtNSdMGRO1VvGOguH2uaQfVBs4q0P4hMMhO8XQJD8OEAHVL1xjI9fvZUi/epqsgvJZc6KEkJl1CsS1jfYzKNmf9QBjioLItMkTQagyjvNyz76tKnRUmsiPwYAW17lRmchlj6/kewzLn1dFooDDCenDgEbN038o/wPG8bf2sw2ao2cbzfgpG0giT410Um4nqEo63oizE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnpoVmd5eHdzMVN3dnlmdjVXVG1BRmFrM1dMRjdrRklKT1hOamVtNHNVb0hJ?=
 =?utf-8?B?QmVabDJBQU12NGpJQjBKUVExQ2VDSE5sT1JybGpGUnk3YUEycENDRmtLczRu?=
 =?utf-8?B?T21NeVpwSnNXOGpiNmR1dFZTcXMvVktuU3J4OFV2cVlEVEhNdWVielRVazA4?=
 =?utf-8?B?U2xjSkRFTTJ5SitHN1RxQllqWVNPZnVKRWdsYSswbXVhMjR6cS9hbFZHdFdY?=
 =?utf-8?B?aEF3YXgrZDFxZ1llQnhndEs0azV6SmNERVN3R2Urb0VHa29jZW1ERXBMVDl0?=
 =?utf-8?B?Vy9FWW1VZXJhSGlxeDJRY1NJT0VNbFozMTVWaisrTC9lUUpFRXFYWTR1MlJs?=
 =?utf-8?B?NGhCUFhXTVFnbGtGVXNYS1pramtmNU9xaVQxanB2MmMxVjZXNGhPZU5ubGky?=
 =?utf-8?B?N2luZEdaUXNYZEE5d21tY01FVHVNVzVkS1E0QXB0MDFvNE9CMXJidEh0WG1M?=
 =?utf-8?B?U2R0Ukp2b09sTzhTdlF6eWNVL0VOUklVY0dUOFBJeVVpckpWdlN0OWJianZs?=
 =?utf-8?B?SnU4MTRISFVUb2tRNEt5VVRhbHJSWFFxRTh6cDk2WmZtQ0UyeFRDQ3g4MDk0?=
 =?utf-8?B?bzNqZUJNWVg2Zk5pSi9TYjE0VVNRQmlmVGJMbmtDYUFsTFVZakJWR2kvd013?=
 =?utf-8?B?dVE1MEdLeWlaZzY3Nk5LdFY2TGFOMk5RMnpCazlCSjlMcnVRNVBpT0tRL2cx?=
 =?utf-8?B?RGprR0htVEs4MDM5Sm5QUHZUOGo0SHp4TU1Wam0xMlQ2ZzNJZ3dsWjJ5ME1V?=
 =?utf-8?B?ZEdGSTJXcUN6VkhPcEJYb1FWcEFFVk9SZXdyamZtNVBVKzBvdG9aem1nMHRH?=
 =?utf-8?B?Wk9rOW5VMjEzbld3WHdyNGRJRVhyY21qM1RhVlpYTUloazBFL0xDWWpBenVM?=
 =?utf-8?B?UzBnK3RjeHpiMXRDdUs4aGppMlF3M09nRDlSNGxVSXhheFU2WlpIVG5NckR4?=
 =?utf-8?B?WVR3VWhBU0p5ZGRRbFlnaHZxWW42dW5jZENzcVVJRXkwczJ6WC9WeXdsZjRk?=
 =?utf-8?B?aEFtTnBrOTFUaUc3bjRGZzV1bnB5UUdIQmMrVUo3ZitoNkxUL1RIeWlMdUxn?=
 =?utf-8?B?KzMvb1psSHo3OGE5NDJkVHlydVhpMjNrUEs3TnFXZlNJQkVCTUlicGFlSTFr?=
 =?utf-8?B?WDFaTXNQZGtlVWdGZU1HdVI1M01PTUNtTXl3QnFkUXZhSzhYWmJpYStKMFpM?=
 =?utf-8?B?OVgxV2J6a0VqSElHR2ZobG1zdjlPOHpCQnY3bExkT2k4ck00Q1FCemxQZDYz?=
 =?utf-8?B?QUJBNUdtZ0xuRkVXRjZQT091YkJ3OXRUYUZEaEV0ekNUdzZvVjR2SG00bDR4?=
 =?utf-8?B?NitYeG5TMHFHZ0U3bUMwQ044NllFVFo1Lzl6Q2lIMVlRZFB2aG93WStIRVpO?=
 =?utf-8?B?cVRuTUJEYm1md1dOQnBxV1B6WUNyaTlTbERsNkV6dWFvQng2TUpKS2ZqdTda?=
 =?utf-8?B?Y3EzdXdNQXBsR2p1RVZuYy9jSmlKaldoWUwwSUI3K3dPZHhieGF5TS8yL0lC?=
 =?utf-8?B?MkxQeG9wNktEWXV6d2ovcENRVy8vU0N3TlRycHZoNjV6WDVEclM2UjZuQkRt?=
 =?utf-8?B?UWxxNjlFM0xzRktZaDhSdjc4dGt0akY0dXBrZUFqZGFaWWNaY21rc1Evbkt4?=
 =?utf-8?B?eGRvbXRDSW1JRmpqTFBOYzByaDJOWjhtUVNqT21KSVJVU0h4WUg0NE1jZXNR?=
 =?utf-8?B?aHk1c3A0SFNGSk1BQUZZMHVnZGhCK2ZjZzhkUjVHVFV0RkVod21mdFNJZzFK?=
 =?utf-8?B?SGJUUVVxZzZzNjNrYU0xU0dvZm11cVd3bGlGaUl2bTVxd3dCdUlvaFhLdThz?=
 =?utf-8?B?NXpoV2Y2VGxjVCtSRnZMOVM5Zlh3ZXB0Z2Y3L2hUNzdvek0vcjJlenlabnRB?=
 =?utf-8?B?N3BpelRZV2dEQ3RZdWRSOU91VVdBSjFLVnFmL21Pb2x3dnRsY0FUMUNzWGFR?=
 =?utf-8?B?VXl5ckQyRXRvTGJQVUV5aGVxL0NlNTVoWk5iS1I5M2l5N0VIRVRqblcrOVJo?=
 =?utf-8?B?QnhUeUFnVVRaNUcvWjR6OWtBeEx6SFFLNC94eGU1cU1ZRDNxZ00zOG9vNVRa?=
 =?utf-8?B?eDVBdFE1QncxWDMzaVU2NzhVQ0Z0ejFpNXBsVG5iTndlOTRKNDNFS1dsdks5?=
 =?utf-8?B?Tk1ZTm56dWp3aUJlRlBHVjQvOVFCbThSVDZPRWEweVdUZytPUS9OREVjbW9j?=
 =?utf-8?B?V0gwbGptMTlEZFNSRGxjeTdmSDBuRW5jWC9tcUI4c3QyYis0M1B3c2FSdENa?=
 =?utf-8?B?Ty9GMEVCanlnekIzUXFuL2hSMGJYYUd2MEZ2emladitQamZPYnMraDU2aEI5?=
 =?utf-8?Q?+G5eIgt9dvxzPIoP6O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ac45ca-f02c-4fbb-e1f4-08df3409a52d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 09:06:54.3291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/GaWBx6N9QC8xxkF8UORirSHc+YMgQLtoCJKiDZ3/YQsZrCq2K/vqtsoSujQB+r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 15:58, Alex Deucher wrote:
> On Mon, Oct 26, 2026 at 2:57 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>>
>> Remove extra blank lines from so many functions.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> 
> Series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       | 6 ------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 --
>>  2 files changed, 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 1a2aa85c504e..4b3926241f75 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -52,7 +52,6 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>>  static bool amdgpu_userq_is_reset_type_supported(struct amdgpu_device *adev,
>>                                 enum amdgpu_ring_type ring_type, int reset_type)
>>  {
>> -
>>         if (ring_type < 0 || ring_type >= AMDGPU_RING_TYPE_MAX)
>>                 return false;
>>
>> @@ -304,8 +303,6 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
>>         return true;
>>  }
>>
>> -
>> -
>>  static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
>>  {
>>         struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>> @@ -458,8 +455,6 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>>         dma_fence_put(ev_fence);
>>  }
>>
>> -
>> -
>>  static int
>>  amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>                                 struct amdgpu_db_info *db_info,
>> @@ -962,7 +957,6 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>         mutex_lock(&uq_mgr->userq_mutex);
>>         /* Resume all the queues for this process */
>>         xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>> -
>>                 if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>>                         drm_file_err(uq_mgr->file,
>>                                      "trying restore queue without va mapping\n");
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 8c696e37d971..dd976a50e053 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -457,7 +457,6 @@ amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
>>                 amdgpu_userq_fence_driver_set_error(fence, -ECANCELED);
>>                 amdgpu_userq_fence_write(fence_drv, wptr);
>>                 amdgpu_userq_fence_driver_process(fence_drv);
>> -
>>         }
>>  }
>>
>> @@ -821,7 +820,6 @@ amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct drm_file *fil
>>                 dma_fence_put(fence);
>>                 if (r)
>>                         goto free_fences;
>> -
>>         }
>>
>>         /* Lock all the GEM objects */
>> --
>> 2.34.1
>>

