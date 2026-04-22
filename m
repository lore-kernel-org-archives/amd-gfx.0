Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED155F9B608
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 10:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9252210E9A1;
	Wed, 22 Apr 2026 10:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s5lsBuLz";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D9C110E9A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 10:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSfJ3ROlkf0yUMlAFyna16v27bO7lDKW91kpOtSnWtYhYxAYFWobx7y9fUP9cpnpukD5z3jP7Q4eaAbmMbOlh78EwPiIHXfR6kEzmROdXajLSYNFTprvnuT0zDpwfUsaMpqDi6RT4vRblNjqMzm0Bk5TnDRxnQ1arkVqZQiv995zdVJd0i27KCXNkjeDrqOtRHrEhH7pT9ZpgbvtfzsJWD2it4BhVw3bFT/48TJnhQ2lgjEDoCixmd3Dg04QSeMwbnIagihDNH7rm2eFmnUlKfUJDdwsJX0QRZrdLd7/HWk1z3SyIkXbIRmbqH7xbu2SMIB0hvsml7drAa+GQ8Nykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88GhMGESn4Zk0spRr7urqSMqcIZRoDRsbJXrIDCCBi8=;
 b=ckpz3pVI+lEWHxmN+adj6KC3B6GrC2BFyG9OdauBzvjX3TLwXE/o6paWFW1KMfzr2wx4YImmySf8QGss5pgm0v25bSZYDmBkrIXF88HJnDYsjc9TMJ2tCMPEQDUYFUl2WUO+LW9Plg++Oiu3mR+X0XuMeiMcHUsuSYo6pjpHOASLSOKpw2f82G5ZuVYZrGCr0tkRppiTIUiez2tqwc2zRG6Fosvb8sY8+mN1pUiyHDZ75ZjpH+thJ8oXWdEUeeUg6omXqTVUkInKKZF0SNeYhR4+9Kba5buX61YPdjRp8cBX7qfHwAgVPNZb+xyoDGaekX7nA60OjZxb+V1vjhzIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88GhMGESn4Zk0spRr7urqSMqcIZRoDRsbJXrIDCCBi8=;
 b=s5lsBuLzCfcFcrDf8m9tP0Tz2vycwx74rbqQWPAxAeYFWd7ect1wlA0UHogBTacYvvBI4jb/Rt4Qna1Lz20yOCreRql6Fa29/6sgMlgeTfuGPio37QMVGO09/QACfJRZKJzZKWYGMc5zCw6ojIB3aTJ/OQTjbnbwbceHZRf69po=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Wed, 22 Apr
 2026 10:14:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 10:14:52 +0000
Message-ID: <4689fb9e-64bd-4931-ad4d-fae6e9a08fb4@amd.com>
Date: Wed, 22 Apr 2026 12:14:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/amdgpu: rework amdgpu_userq_signal_ioctl
To: "Khatri, Sunil" <sukhatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-4-christian.koenig@amd.com>
 <8fe38911-e8c0-40da-be4e-4d14983678a0@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <8fe38911-e8c0-40da-be4e-4d14983678a0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:208:239::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: b567a87e-4322-47c0-cbdd-08dea057fe09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: Ztv9nUH6oFg67SDb7GtwRqegZqZXPLakNPmcJbORk4ZvBb1umyy2joLvOg2i1WE8n3UX3D5MC3MzhVkyrNA4xMskrMfNzuDNeBi70OvKRpvBeKzUlDAiG6ev3ka2sh2X8pnff2Au640AbEcTDp6WmQhmD+zpQUcUZRrFH2cGyOWm/TUM4x9tyVW3LPOnXMNOnItDdY7cilFtVeonig2MsgXoPRBHCEEtDpX4X1djzBPBdYhc0wNQxIgFBW52pH7H0gzUZqeRB1c/1+7eSz5q6gi3bvCGbl1y9G2nkWCyfrXqQEtJqs7UgkxsBcRaKJiE8jG1mDPQSMmhcOJu4dxQyl8pFO6EZ4whUkSbKMcZ71zyvheRPOvf7FE+XY6NsVzIzNO+SSGvWEzj5eOeXQZYTtzptqNlAGl1JXd7LfRrsOW0Byk6/HYUwp6joALl10emTDoIXo+uT4p+Lw+uiBQ+NgSiQG0iNYDk0XYrOoTgV/fun9fZWAGSsuEY2FyNspTuvl0/fypSFFSDHFm1/YFsvChrXrTO4M/Y9gIcWFG2WqHZpIXSbNXdNv3vwcx8R1EN31sbiv3BbM02sNcAGgm+0zo5vSoV3WoWHhEaqKcqpJfk6hCjvw9osmlXGrwo9xE1mDzfFVhau2TsOmgOMyeypmqdp6+jYc082AQ5cWO2wkVXRxCve87uCXSHQuytbE6sr5SXlLwsMpa46LEyJiNLu46sXpWUXX0zdcAilHTSQ0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enI5amZDbVhTeUtibVRNZ1VTUEFQdG0rN1psSnJVMDdDSE5HeXB5VXZyM0VX?=
 =?utf-8?B?OVV1eUtZTkt2dVQvTjNmWVVOUGw0TzJKY1FmeEFHUmpHM3JZek8rSnFJMDFQ?=
 =?utf-8?B?Z2kwTitCOGxQWHZ5MjNOT3RaRUp5dFZ1RTNrM0dVbUVyb3NkdzR2Qys0UzRt?=
 =?utf-8?B?VTdpWmNaYW5TbGZVa3d0RFk1VXY4bWFKQnM2Qm0yVmRZYi9Bc3ZjS1BWWFk3?=
 =?utf-8?B?TUtZZi9DN0NyV1B0SUFYaE1IWDdSVDRQQTBiT1ZQRm1JV1VmL2pLaCtNd2x3?=
 =?utf-8?B?amJDc0pjVkhqQzdJWWQ1QlZrSkxQM214MjY3MHVVdmxwdlpCL2w4OHZVYzJX?=
 =?utf-8?B?M2c3QVpydzRZRFNFYVpkdzZ0NU82Y2tjNEVqMFJRWk9MN1I2OHpZeERZQXNY?=
 =?utf-8?B?cXQ0bDdYU2RjZUJMT1ZDNFJINDJsWGZsSEYxdDVZTHZXMUwvbUM0WjdmZnFJ?=
 =?utf-8?B?WExsMnNRSXQ3OVBzT1J5K1QwQ3JyZFJEeS9zRzQyd0lBRm9kUzFoRHdNeTRu?=
 =?utf-8?B?am4vL3dKRGFKemVmVE1sV0h5SjZSYzQ3cytuVm5ac2RQQzVtSXBFZnFtTEJ0?=
 =?utf-8?B?cE5BTWw2NllLeXpIc0NlOHZtY0p0OTVHNU8yYVRQVGZMRFVNck1NdjQ3aElo?=
 =?utf-8?B?cUs3L24rNHUwb2pxMW84cUh4UlZpRjVBQzVIb0pYNTE3WUJ2ODVBeHpkQUJV?=
 =?utf-8?B?RkE4bXhkMFFkQTdQN1RwUWk4cmZRNndBOThHUVdISWhUSUYra05JK3M4ZnNV?=
 =?utf-8?B?M2F5TXBPQWxzdFg5OXVWY1U0UXZ0dnFGUHo1YUJoWHd4Ulk5TVRwR3RvVjR5?=
 =?utf-8?B?c3pIRDJkcjJxZkVRNkN3VE8yZVQ1MitsSWMzd2RLS29VYWdWMnlGZzVFaGo3?=
 =?utf-8?B?Wk5DdnhUcm1BTzFBcDZ6Y1c0L1JySnVFS3BtMnJMRFRoM3Z1SnJ5SmNYNDFQ?=
 =?utf-8?B?ZEE5UGVEaFJWOEptTFQ1VU1saEZYSDZ2VzFhRFBueTR0b1lVdGRNZjNXaEhy?=
 =?utf-8?B?Nmt5MGxtcGtiR2pSVEFGSEw1UUZqVjQ1QUFQdCtRc1lISFBJTUpXQUd5S3lr?=
 =?utf-8?B?RmI5MFh1MWpkNFVwQVovaWFHeVNZbitkWHdkOGJXMU56M3VjUkJTZWNNc2F4?=
 =?utf-8?B?WFNVU2FtVGJSZUl4M2dSN2RuVUltRzdMc3RUdmNvVGdTTXFrcjF5bTF5bDdL?=
 =?utf-8?B?TzBpbXorR2FTTWNaRE0xT2phVHlwUFg0ZVVWa1YwK1NrSGZpWEZpWVJyaDVp?=
 =?utf-8?B?OXVqNnNoV0h4QTVsYVRqMDVWWXhNcnVVL3I1ZjBxaEt5alY1bWU2TmFWZjhT?=
 =?utf-8?B?NmU1QzVIbEpLL1h2QnhFMkY5cEJlTkVpUS9iZzg2NUVwbmd1S2lGMnhzc0tE?=
 =?utf-8?B?NldzbUxlWThmdzFmZXF3RDRib2t5S3Vtc2E0czJVakJHanhVMDhjOWJaK0V5?=
 =?utf-8?B?ZHhoQWtmZzJOUmJDb3J5azA3emdsUGdlYTlmRHlvVGkyclVGTFlkNE1ldk5W?=
 =?utf-8?B?UW1ad1R3RVlndmpVRTlwdGhpMlc0OVZZQzZGNThKMWtweTNqRmJQTkRLc0Jz?=
 =?utf-8?B?WEUzemV6YloyVE8reVQ2dzROWFlIZUQ3N2dJMStQZi9weElDWkNJczdHUTBB?=
 =?utf-8?B?Tk1JeGJUaG1TcTNIMW94c3dvV1ZQMXc1bXhmRXB5RVlrR1ZHeXNiU1h2V3Nh?=
 =?utf-8?B?ZjhXMzdxSXBLSThxWU9OZlNPYUpjSW1DRHd3N1lYU3NEM09hNUpHYzRVV2h6?=
 =?utf-8?B?RTdBcmIweGdGMEIrOXpNUjdlczZweVIyZE91MUs4akozSVppaWx6a2tWOVE1?=
 =?utf-8?B?a1BxZmlVOFBqb0NzYVNYMkhnLzJkaVlKWE5VN0NtazlzRk0vb2k2cU5BZmtM?=
 =?utf-8?B?dTRVODBZRXBUdFk1WGJDK3JZOVMvOGIyd1hFYmVaNWx3RzVidkZiMVg5cWMy?=
 =?utf-8?B?aU9TV2drS2FwV3dSOUJuN1E4VDlhOEdxelJoU3NsUUJBbXZwWkIrbFpBUDd4?=
 =?utf-8?B?ZWJkQTZGMG5hTzRoeVJqVjhNcVk3V3ZTQTZoRG05akVyaUd2OHdlcDZJU3lY?=
 =?utf-8?B?bmNxNnF4RkhLeXJoYW9Bc3laS3RmYVhVWkh4bnNaWUhsaTBWb2xLMEJxSEg3?=
 =?utf-8?B?Qy9zaTJKYVBveTZSY1JoMWMwZU5wbG1lcDRnSEdhWm5xUVFQZTNJbzBvN3pq?=
 =?utf-8?B?YXJlUDM0RFR2RGFsci9CdmNjRUFPdDFVUFRhUFp4YUR0eDdNSjg3dHVsOXNi?=
 =?utf-8?B?NGU4MENtWXZpNFo3b3FGRFZwRnVYY0hsZ2R1bjViT2xBL0hmVUtaZWlFc0E2?=
 =?utf-8?Q?al8KMEX+RMp3XgPM7J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b567a87e-4322-47c0-cbdd-08dea057fe09
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 10:14:51.9767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0n1gxe7Yi6bmlEjw2uGFmRNkpeYdQ5qTF1Tq9IgA2VzIyGQlNESh0VR6a26/Re/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814
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

On 4/22/26 12:08, Khatri, Sunil wrote:
> 
> On 21-04-2026 06:25 pm, Christian König wrote:
>> This one was fortunately not looking so bad as the wait ioctl path, but
>> there were still a few things which could be fixed/improved:
>>
>> 1. Allocating with GFP_ATOMIC was quite unecessary, we can do that
>>     before taking the userq_lock.
>> 2. Use a new mutex as protection for the fence_drv_xa so that we can do
>>     memory allocations while holding it.
>> 3. Starting the reset timer is unecessary when the fence is already
>>     signaled when we create it.
>> 4. Cleanup error handling, avoid trying to free the queue when we don't
>>     even got one.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  12 +
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 220 ++++++++----------
>>   3 files changed, 111 insertions(+), 122 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index b632bc3c952b..174190a77005 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -793,6 +793,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>       }
>>         queue->doorbell_index = index;
>> +    mutex_init(&queue->fence_drv_lock);
> we do want to destroy the mutex in case queue creation fails ? RIght now amdgpu_userq_fence_driver_alloc fails we goto clean_mapping and not destroying the mutex which is done in amdgpu_userq_fence_driver_free.
> goto needs to be modified i guess to handle it.

Good point, going to clean that up.

> Apart from that LGTM. Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

Thanks,
Christian

> 
> Regards
> Sunil
>>       xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
>>       r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
>>       if (r) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index 675fe6395ac8..cb92789c1ed1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -66,6 +66,18 @@ struct amdgpu_usermode_queue {
>>       struct amdgpu_userq_obj    db_obj;
>>       struct amdgpu_userq_obj fw_obj;
>>       struct amdgpu_userq_obj wptr_obj;
>> +
>> +    /**
>> +     * @fence_drv_lock: Protecting @fence_drv_xa.
>> +     */
>> +    struct mutex        fence_drv_lock;
>> +
>> +    /**
>> +     * @fence_drv_xa:
>> +     *
>> +     * References to the external fence drivers returned by wait_ioctl.
>> +     * Dropped on the next signaled dma_fence or queue destruction.
>> +     */
>>       struct xarray        fence_drv_xa;
>>       struct amdgpu_userq_fence_driver *fence_drv;
>>       struct dma_fence    *last_fence;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 909bdccc2a92..b0543fa257ed 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -121,6 +121,7 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
>>       userq->last_fence = NULL;
>>       amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
>>       xa_destroy(&userq->fence_drv_xa);
>> +    mutex_destroy(&userq->fence_drv_lock);
>>       /* Drop the queue's ownership reference to fence_drv explicitly */
>>       amdgpu_userq_fence_driver_put(userq->fence_drv);
>>   }
>> @@ -216,81 +217,77 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
>>       kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy);
>>   }
>>   -static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
>> +static int amdgpu_userq_fence_alloc(struct amdgpu_usermode_queue *userq,
>> +                    struct amdgpu_userq_fence **pfence)
>>   {
>> -    *userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
>> -    return *userq_fence ? 0 : -ENOMEM;
>> +    struct amdgpu_userq_fence_driver *fence_drv = userq->fence_drv;
>> +    struct amdgpu_userq_fence *userq_fence;
>> +    unsigned long count;
>> +
>> +    userq_fence = kmalloc(sizeof(*userq_fence), GFP_KERNEL);
>> +    if (!userq_fence)
>> +        return -ENOMEM;
>> +
>> +    /*
>> +     * Get the next unused entry, since we fill from the start this can be
>> +     * used as size to allocate the array.
>> +     */
>> +    mutex_lock(&userq->fence_drv_lock);
>> +    xa_find(&userq->fence_drv_xa, &count, ULONG_MAX, XA_FREE_MARK);
>> +
>> +    userq_fence->fence_drv_array = kvmalloc_array(count, sizeof(fence_drv),
>> +                              GFP_KERNEL);
>> +    if (!userq_fence->fence_drv_array) {
>> +        mutex_unlock(&userq->fence_drv_lock);
>> +        kfree(userq_fence);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    userq_fence->fence_drv_array_count = count;
>> +    xa_extract(&userq->fence_drv_xa, (void **)userq_fence->fence_drv_array,
>> +           0, ULONG_MAX, count, XA_PRESENT);
>> +    xa_destroy(&userq->fence_drv_xa);
>> +
>> +    mutex_unlock(&userq->fence_drv_lock);
>> +
>> +    userq_fence->fence_drv = fence_drv;
>> +    amdgpu_userq_fence_driver_get(fence_drv);
>> +
>> +    *pfence = userq_fence;
>> +    return 0;
>>   }
>>   -static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>> -                     struct amdgpu_userq_fence *userq_fence,
>> -                     u64 seq, struct dma_fence **f)
>> +static void amdgpu_userq_fence_init(struct amdgpu_usermode_queue *userq,
>> +                    struct amdgpu_userq_fence *fence,
>> +                    u64 seq)
>>   {
>> -    struct amdgpu_userq_fence_driver *fence_drv;
>> -    struct dma_fence *fence;
>> +    struct amdgpu_userq_fence_driver *fence_drv = userq->fence_drv;
>>       unsigned long flags;
>>       bool signaled = false;
>>   -    fence_drv = userq->fence_drv;
>> -    if (!fence_drv)
>> -        return -EINVAL;
>> -
>> -    spin_lock_init(&userq_fence->lock);
>> -    INIT_LIST_HEAD(&userq_fence->link);
>> -    fence = &userq_fence->base;
>> -    userq_fence->fence_drv = fence_drv;
>> -
>> -    dma_fence_init64(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
>> +    spin_lock_init(&fence->lock);
>> +    dma_fence_init64(&fence->base, &amdgpu_userq_fence_ops, &fence->lock,
>>                fence_drv->context, seq);
>>   -    amdgpu_userq_fence_driver_get(fence_drv);
>> -    dma_fence_get(fence);
>> -
>> -    if (!xa_empty(&userq->fence_drv_xa)) {
>> -        struct amdgpu_userq_fence_driver *stored_fence_drv;
>> -        unsigned long index, count = 0;
>> -        int i = 0;
>> -
>> -        xa_lock(&userq->fence_drv_xa);
>> -        xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
>> -            count++;
>> -
>> -        userq_fence->fence_drv_array =
>> -            kvmalloc_array(count,
>> -                       sizeof(struct amdgpu_userq_fence_driver *),
>> -                       GFP_ATOMIC);
>> -
>> -        if (userq_fence->fence_drv_array) {
>> -            xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv) {
>> -                userq_fence->fence_drv_array[i] = stored_fence_drv;
>> -                __xa_erase(&userq->fence_drv_xa, index);
>> -                i++;
>> -            }
>> -        }
>> -
>> -        userq_fence->fence_drv_array_count = i;
>> -        xa_unlock(&userq->fence_drv_xa);
>> -    } else {
>> -        userq_fence->fence_drv_array = NULL;
>> -        userq_fence->fence_drv_array_count = 0;
>> -    }
>> +    /* Make sure the fence is visible to the hang detect worker */
>> +    dma_fence_put(userq->last_fence);
>> +    userq->last_fence = dma_fence_get(&fence->base);
>>   -    /* Check if hardware has already processed the job */
>> +    /* Check if hardware has already processed the fence */
>>       spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>> -    if (!dma_fence_is_signaled(fence)) {
>> -        list_add_tail(&userq_fence->link, &fence_drv->fences);
>> +    if (!dma_fence_is_signaled(&fence->base)) {
>> +        dma_fence_get(&fence->base);
>> +        list_add_tail(&fence->link, &fence_drv->fences);
>>       } else {
>> +        INIT_LIST_HEAD(&fence->link);
>>           signaled = true;
>> -        dma_fence_put(fence);
>>       }
>>       spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>>         if (signaled)
>> -        amdgpu_userq_fence_put_fence_drv_refs(userq_fence);
>> -
>> -    *f = fence;
>> -
>> -    return 0;
>> +        amdgpu_userq_fence_put_fence_drv_refs(fence);
>> +    else
>> +        amdgpu_userq_start_hang_detect_work(userq);
>>   }
>>     static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *f)
>> @@ -392,11 +389,6 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
>>       return r;
>>   }
>>   -static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
>> -{
>> -    dma_fence_put(fence);
>> -}
>> -
>>   static void
>>   amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
>>                       int error)
>> @@ -440,13 +432,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>       const unsigned int num_read_bo_handles = args->num_bo_read_handles;
>>       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>       struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>> +
>>       struct drm_gem_object **gobj_write, **gobj_read;
>>       u32 *syncobj_handles, num_syncobj_handles;
>> -    struct amdgpu_userq_fence *userq_fence;
>> -    struct amdgpu_usermode_queue *queue = NULL;
>> -    struct drm_syncobj **syncobj = NULL;
>> -    struct dma_fence *fence;
>> +    struct amdgpu_usermode_queue *queue;
>> +    struct amdgpu_userq_fence *fence;
>> +    struct drm_syncobj **syncobj;
>>       struct drm_exec exec;
>> +    void __user *ptr;
>>       int r, i, entry;
>>       u64 wptr;
>>   @@ -458,13 +451,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>           return -EINVAL;
>>         num_syncobj_handles = args->num_syncobj_handles;
>> -    syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
>> -                        num_syncobj_handles, sizeof(u32));
>> +    ptr = u64_to_user_ptr(args->syncobj_handles);
>> +    syncobj_handles = memdup_array_user(ptr, num_syncobj_handles,
>> +                        sizeof(u32));
>>       if (IS_ERR(syncobj_handles))
>>           return PTR_ERR(syncobj_handles);
>>   -    /* Array of pointers to the looked up syncobjs */
>> -    syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj), GFP_KERNEL);
>> +    syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj),
>> +                GFP_KERNEL);
>>       if (!syncobj) {
>>           r = -ENOMEM;
>>           goto free_syncobj_handles;
>> @@ -478,21 +472,17 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>           }
>>       }
>>   -    r = drm_gem_objects_lookup(filp,
>> -                   u64_to_user_ptr(args->bo_read_handles),
>> -                   num_read_bo_handles,
>> -                   &gobj_read);
>> +    ptr = u64_to_user_ptr(args->bo_read_handles);
>> +    r = drm_gem_objects_lookup(filp, ptr, num_read_bo_handles, &gobj_read);
>>       if (r)
>>           goto free_syncobj;
>>   -    r = drm_gem_objects_lookup(filp,
>> -                   u64_to_user_ptr(args->bo_write_handles),
>> -                   num_write_bo_handles,
>> +    ptr = u64_to_user_ptr(args->bo_write_handles);
>> +    r = drm_gem_objects_lookup(filp, ptr, num_write_bo_handles,
>>                      &gobj_write);
>>       if (r)
>>           goto put_gobj_read;
>>   -    /* Retrieve the user queue */
>>       queue = amdgpu_userq_get(userq_mgr, args->queue_id);
>>       if (!queue) {
>>           r = -ENOENT;
>> @@ -501,73 +491,61 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>         r = amdgpu_userq_fence_read_wptr(adev, queue, &wptr);
>>       if (r)
>> -        goto put_gobj_write;
>> +        goto put_queue;
>>   -    r = amdgpu_userq_fence_alloc(&userq_fence);
>> +    r = amdgpu_userq_fence_alloc(queue, &fence);
>>       if (r)
>> -        goto put_gobj_write;
>> +        goto put_queue;
>>         /* We are here means UQ is active, make sure the eviction fence is valid */
>>       amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>>   -    /* Create a new fence */
>> -    r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
>> -    if (r) {
>> -        mutex_unlock(&userq_mgr->userq_mutex);
>> -        kfree(userq_fence);
>> -        goto put_gobj_write;
>> -    }
>> +    /* Create the new fence */
>> +    amdgpu_userq_fence_init(queue, fence, wptr);
>>   -    dma_fence_put(queue->last_fence);
>> -    queue->last_fence = dma_fence_get(fence);
>> -    amdgpu_userq_start_hang_detect_work(queue);
>>       mutex_unlock(&userq_mgr->userq_mutex);
>>   +    /*
>> +     * This needs to come after the fence is created since
>> +     * amdgpu_userq_ensure_ev_fence() can't be called while holding the resv
>> +     * locks.
>> +     */
>>       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>>                 (num_read_bo_handles + num_write_bo_handles));
>>   -    /* Lock all BOs with retry handling */
>>       drm_exec_until_all_locked(&exec) {
>> -        r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
>> +        r = drm_exec_prepare_array(&exec, gobj_read,
>> +                       num_read_bo_handles, 1);
>>           drm_exec_retry_on_contention(&exec);
>> -        if (r) {
>> -            amdgpu_userq_fence_cleanup(fence);
>> +        if (r)
>>               goto exec_fini;
>> -        }
>>   -        r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
>> +        r = drm_exec_prepare_array(&exec, gobj_write,
>> +                       num_write_bo_handles, 1);
>>           drm_exec_retry_on_contention(&exec);
>> -        if (r) {
>> -            amdgpu_userq_fence_cleanup(fence);
>> +        if (r)
>>               goto exec_fini;
>> -        }
>>       }
>>   -    for (i = 0; i < num_read_bo_handles; i++) {
>> -        if (!gobj_read || !gobj_read[i]->resv)
>> -            continue;
>> -
>> -        dma_resv_add_fence(gobj_read[i]->resv, fence,
>> +    /* And publish the new fence in the BOs and syncobj */
>> +    for (i = 0; i < num_read_bo_handles; i++)
>> +        dma_resv_add_fence(gobj_read[i]->resv, &fence->base,
>>                      DMA_RESV_USAGE_READ);
>> -    }
>>   -    for (i = 0; i < num_write_bo_handles; i++) {
>> -        if (!gobj_write || !gobj_write[i]->resv)
>> -            continue;
>> -
>> -        dma_resv_add_fence(gobj_write[i]->resv, fence,
>> +    for (i = 0; i < num_write_bo_handles; i++)
>> +        dma_resv_add_fence(gobj_write[i]->resv, &fence->base,
>>                      DMA_RESV_USAGE_WRITE);
>> -    }
>>   -    /* Add the created fence to syncobj/BO's */
>>       for (i = 0; i < num_syncobj_handles; i++)
>> -        drm_syncobj_replace_fence(syncobj[i], fence);
>> +        drm_syncobj_replace_fence(syncobj[i], &fence->base);
>>   +exec_fini:
>>       /* drop the reference acquired in fence creation function */
>> -    dma_fence_put(fence);
>> +    dma_fence_put(&fence->base);
>>   -exec_fini:
>>       drm_exec_fini(&exec);
>> +put_queue:
>> +    amdgpu_userq_put(queue);
>>   put_gobj_write:
>>       for (i = 0; i < num_write_bo_handles; i++)
>>           drm_gem_object_put(gobj_write[i]);
>> @@ -578,15 +556,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>       kvfree(gobj_read);
>>   free_syncobj:
>>       while (entry-- > 0)
>> -        if (syncobj[entry])
>> -            drm_syncobj_put(syncobj[entry]);
>> +        drm_syncobj_put(syncobj[entry]);
>>       kfree(syncobj);
>>   free_syncobj_handles:
>>       kfree(syncobj_handles);
>>   -    if (queue)
>> -        amdgpu_userq_put(queue);
>> -
>>       return r;
>>   }
>>   @@ -874,8 +848,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>            * Otherwise, we would gather those references until we don't
>>            * have any more space left and crash.
>>            */
>> +        mutex_lock(&waitq->fence_drv_lock);
>>           r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
>>                    xa_limit_32b, GFP_KERNEL);
>> +        mutex_unlock(&waitq->fence_drv_lock);
>>           if (r) {
>>               amdgpu_userq_fence_driver_put(fence_drv);
>>               goto put_waitq;

