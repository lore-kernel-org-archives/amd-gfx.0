Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47328FF886F
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2026 12:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF78410E37D;
	Mon,  4 May 2026 12:33:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TXqwJhUo";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07AA710E37D
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 May 2026 12:33:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4i6u6gyUBcPDAOatNpXqtUi9wwcCvzx2WxqnhYHNyPYivfhbgNF9YrSPR66z7pTE/ztmX2qD6iIfX5b64CLECGWkxAEq1hM+aBIFUpAObH7BCwxwMQlBkv0iNIYo3ISVTxXeQCT5hBIwgscERhUuVhKlF0dbVv+ShEquu3P+ONfSEZexBOHfpRgb1YVuwNpLysCHGWgIY4O3HULaBtOl5k8EV/xz6WvsWkceesdlHpYrXqssS3TsU9B27eB7Cu40YoKhyyU+QFcofzjE0h16D6l5Ft+DaWRoto/1wCcW6TE4GJzpTASVk988yDBSKY3VfvT6q2IHXE6p46cXXdzxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCOhfkNQEcSjXEXTLwzkkOobZW8/xs8o4Rg9Srm2ero=;
 b=MmwvCTJT4hA9fJtFPZd7XrFN/mIb5hVbZHao6VrYnbgWGJKHP3ZhHuEGC/fgkEOazXkgmjnRgpA9oJmBc5rYa90HUmVvxCPGpmEC6PujHWa+vr9NKwW36Ulkjn+RpAbdMEKyPUdOtJ10oFu8fyzOfNk9AL5Gb2ph48fGv1Zf5FiHjzZSbV7lujM6BVtChZvqT2rk9RqHNM+Hh9MnWYyEO1BBuPykdgVpTnzUT6TC6CKjzu3EWetdejUjQx1i8W0tJJ69i52+aOlaIsKY/VPL418vWaSlqtIRpduAwLDcpBQ4p1lI5Y1Cm6oma0IGBKnNGoaHMXAkKG/hZKoNo3BawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCOhfkNQEcSjXEXTLwzkkOobZW8/xs8o4Rg9Srm2ero=;
 b=TXqwJhUoBsaK6IvR8eN39e+3xexieVyGigiGcdKTxaKkdQ+vJTbLfcLdUFIV7PdX8CH9fMgt1mgmCZLubGfNl56ILvLNULXwsSc/381EPflltdTRyLFjSIDYO06UiEoSBXzgWKd1MrYJiuAszQjQQ8UpZ2AnZPSg/5JEEwD0e0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL4PR12MB9477.namprd12.prod.outlook.com (2603:10b6:208:58d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 12:33:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 12:33:47 +0000
Message-ID: <cb5bfdfe-ef9f-4833-a78f-273af67ee192@amd.com>
Date: Mon, 4 May 2026 14:33:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/amdgpu: rework amdgpu_userq_signal_ioctl v2
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260427182723.1715-1-christian.koenig@amd.com>
 <20260427182723.1715-3-christian.koenig@amd.com>
 <DS7PR12MB60057323BF3469806672FE3FFB372@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB60057323BF3469806672FE3FFB372@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:208:32f::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL4PR12MB9477:EE_
X-MS-Office365-Filtering-Correlation-Id: f0eb2bbf-99a5-45ed-fb70-08dea9d96356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: nKSBjzVoFH3Soh/34G7mGYvJ8pDCZDeSHup0OdLcR2TGhguAl8ViOWUt09gBOHgCXK/XMp4xAg4LMvnqeVpLMiMIosHd5yOG3CZJwn3Fk96+mUX1TgmyE7CdUCLA87Vym2KVu0iWzg2dmr1tg2SWZVEAaSz2gSjOfh84FWfpoZKDCp3yyhL+pFg+HhVnrX7FBdXK4wP/vXlR8kxO1rRuVZ8gIRHV9ZZzLxKU5McKzBPKc5ubfYzwm5hnZQ+6MkZzTzjmitF97jhQWdz27nuYB8LtlNPXT0sKsQuQbeDQ9lzZ62YCZNvkWejNsQKDoUnXruzfEqYDNor3jGF97jKe01K1e0AOT7ZcvA+9wBxIYTL6YwW/Hnbk00dVejlO1DoH/LlRR0e+WDwJjgWNU7RWJ2bTZx/irrewN53rC8wnTUT/PpZ+q5lSNPHYHJzc3gc83lGkcv70dX/0iIqR9AB+/wqbyfdmsHgXfQEhBaKHWYrT5/GRI2JAT8YRLVCzygbszMgnUGN0oZz3M/tpE4sjX49LZ0+pwQadON4QyeoJZSBakVan9RR/qiHN5LfhtYzz4YB/fgl4hNQf2YGp5xPu28rIQib5k+L3k/mppj7cmAUJoZoRCk5PdlbP2n8wLkY+2+HtObmM9kMSV7L6F2CgsUV/rXvWlLdWiqut+v1Wz0kLLjwbHDhRnAZ7OPm4wFTG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elVDSjlyUkd3VXJwSnJCWlZiU2RYN2pjQU1aQnhIemRLZUJQdHJtWE5MVmU4?=
 =?utf-8?B?VWU3WFFmSW1Jb1d5VU1yMmcxVzRwaitLRFZJT0dhL2ZKek95eTNwblFOWU5D?=
 =?utf-8?B?dWJ0T2dkSWt6VzByNjhKbERZckpQYmViK3RFMEJ5eVU0Q0FTcVJBQTNNejAv?=
 =?utf-8?B?Z1Z3OWRKSG1WazBPSVpxNmJhWmVhbFBIVzR5OTBXRjhUTTFIYU5EOTZ3WGVi?=
 =?utf-8?B?bXNvSnA0Vnh4ZjN5REpIWFRLS2NpMyt3QWdKQ3BMaG5lUTZQY1lZSnMyeTI5?=
 =?utf-8?B?cCtMWk4yaVFVeWxES2JqeElZSG9VczFYb0RsVHprSkRXbjM5VXRITGVmY2FT?=
 =?utf-8?B?c0N4cS96OEthOUlMS0RPNVFnd1N3S3RoS2E3Q2p4cEVsOFJQckE1NkZjdVoy?=
 =?utf-8?B?UkFaQVZZbkM3UkZDQjhlcjZlK1V6aDhTZUFhN1IvWG1XK1lNem1oenhGQ3BH?=
 =?utf-8?B?Zm91UWwxemtPVDZRK3BBQXNmL2laMk4xcXNSWlM2Zkd6Yk5sQmdZb2tNNnJQ?=
 =?utf-8?B?NWxlNXV1MGpDNW1NVkJhZk1manFBZTRvRkZzc1JCOGxkSlQ0cTFXS21vWnRE?=
 =?utf-8?B?SmMyVWVONGhlakk3MGJhd0xvUzdmNFJxcTJoemZ1dlhEZVhKWXowU0MzU0lW?=
 =?utf-8?B?L3ZiTm1aWE83cmMvYlZ0bExpbEs1YjlSMDArWFJETSszc3N1TXlYK0Rja3Za?=
 =?utf-8?B?WGVmN3VBMGJIV0FzM1g0RTBWbUNhVkcyZVRpcEtGaFcyKzlRZVNMeUg5OFlT?=
 =?utf-8?B?ekNvbW12VE5PZ21hMVM3cVNRV1ZEYXRiQkUzNVY2ajdlYnBVc2tSNjlMSzdX?=
 =?utf-8?B?a0NaZmpwajd5cmFWTWxvUVY3ZFBuWWhoekNHQm1Ncm0vUHBoMjBxWCtpdnM3?=
 =?utf-8?B?Q1ROaUUrVE1USzhONUdPUVRKNGw0dHdKdmpJVG55OSs1L0IvWGhWTmlxVEln?=
 =?utf-8?B?Zzd2MGlvbE5abmY2d0Y1VVJDMCtUMGVtT2VuM3dSVWROREFwRzBmbFJCenN0?=
 =?utf-8?B?b2RxNDhPb1p0SVJhTTVCTnVnUndxZUY3RlJMTVZxNmEwdjhLZUVYN3Vzb0dw?=
 =?utf-8?B?M3VhVUxnUEU0bXQ5a2M1MUI5Z1lMZTJFTlN4Z29BQUFXemZybHJlN09EVFhK?=
 =?utf-8?B?ays3MkZHa1NncHdZam03VlJMNmtEZ3JiK0ZWdWFHTytvTCtMckhiQ0MvL09M?=
 =?utf-8?B?NjU1dnFnMkNvYU1FR3JMWVl6Sm55NGZYdzRyYzBTeHVRMzNPWFRVOXJYNDVl?=
 =?utf-8?B?ejFjeml0MFhscnV3NHp3VnIzcEFjaDM1L3ppbjgvOEkwbFl0WjJYSGdnYW9U?=
 =?utf-8?B?bWVKVUppVlZqRDZQM25RVlZlaGl2cjdvK2lTWmVlVjdKdEZ1NU51QzJuTXQ5?=
 =?utf-8?B?MUNsU0hvVnU0RGxHVnh6My9KVzFFc0ZEWmhOSUVablRpS0E1clRSWVdGdVRQ?=
 =?utf-8?B?em5tN1hjZmkzeTQ3SGZnR3ovckFja1RSL3JybmdQSHNoUjFwMFFqODM3ZDBV?=
 =?utf-8?B?UDJjamlrdXJpR2lTUDRmS0FFTmNVSUF3VzhsZVNvNlcwY1hVVHhxbXo4MzBT?=
 =?utf-8?B?d2lIOVdVTkJyUlV4cW5hblIzYlZ5Q3E5OE5pYTE3OHNDWVlYcGtHMGJBdis2?=
 =?utf-8?B?TkdndXd2SjhBcUpaVE90S0l2RHlVNVlVNzhMN0dDY216d0lkZWlpb1k5QTV6?=
 =?utf-8?B?dFZRMjdoRW1oYmxxRythbDY4L1ppQ3hJNDNPYTFPTVlVWVI3KzM3Wk10Wlps?=
 =?utf-8?B?cmdhYTNJandjWW9QcGhJaEgyU0g0Ym1Zb1lOM3NLenQ0RUpkK0N0YVlQaWNW?=
 =?utf-8?B?Z3B6WEo2VVZwdUVDSHNvaXkvTFZuRmJVTEFBbW9UM3A0NE5EakVJeHkrMlEz?=
 =?utf-8?B?dUx4NEJUUU9GRC91a1ZjREUxc1VBRlFjOWQ5Q1NyeVZvLzNnNTY2LzFuUmVW?=
 =?utf-8?B?WW40SFh4OG1NUjkzK3orTE13ckZ4V25rR3pNS1BlWVRCNm5hQ0NxeDBrN2JN?=
 =?utf-8?B?K1NGd0FQVTRqVGhGaWFTMm1UejhIUExsaWlWUjEzM2Y5T0sxMFlQQ3ZCR1U5?=
 =?utf-8?B?VzdUYjNkMnFlakNpa1RpUUNkUGp1T3pLeGdEOTZTRVdhcGQwcWdaTTQ1OXdH?=
 =?utf-8?B?bHBVQ0pUTDVMWXNWd2dISTJtOVU4R0N5cDdDbDhBSGdwdFhxenh6d1haaGgx?=
 =?utf-8?B?RHVsdW5MVFNjQTcrSjV0a2htSnY2NDQ5Tmo3NjZ3cWp0N3RjM0x3bzZKc2NB?=
 =?utf-8?B?L2ptUTlOeVJ5ZjQzMzA0eGFLQnlpaVY3ekRYRXlOeEdYQjJtWXdVWFg0MEF6?=
 =?utf-8?Q?BvUaFS5DIFwMOQO4qr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eb2bbf-99a5-45ed-fb70-08dea9d96356
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 12:33:47.5813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhvLGb1u59DZO57+z8PUEPcIOVqvdvYpGAkzgd9c2HREEhjHELqMwG82mwu4iAdu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9477
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



On 4/28/26 10:49, Liang, Prike wrote:
...
>> +     /*
>> +      * Get the next unused entry, since we fill from the start this can be
>> +      * used as size to allocate the array.
>> +      */
>> +     mutex_lock(&userq->fence_drv_lock);
>> +     XA_STATE(xas, &userq->fence_drv_xa, 0);
>> +
>> +     rcu_read_lock();
>> +     do {
>> +             entry = xas_find_marked(&xas, ULONG_MAX, XA_FREE_MARK);
>> +     } while (xas_retry(&xas, entry));
> 
> Do we need to handle the xas.xa_index = 0 case separately rather than use the invalid wait fence?

No, zero sized array allocations are perfectly valid.

> 
>> +     rcu_read_unlock();
>> +
>> +     userq_fence->fence_drv_array = kvmalloc_array(xas.xa_index,
>> +                                                   sizeof(fence_drv),
>> +                                                   GFP_KERNEL);
> 
> 
> The kvmalloc_array() should use the obj size of sizeof(*userq_fence->fence_drv_array).

As far as I can see that should be the same?

> 
>> +     if (!userq_fence->fence_drv_array) {
>> +             mutex_unlock(&userq->fence_drv_lock);
>> +             kfree(userq_fence);
>> +             return -ENOMEM;
>> +     }
>> +
>> +     userq_fence->fence_drv_array_count = xas.xa_index;
>> +     xa_extract(&userq->fence_drv_xa, (void **)userq_fence->fence_drv_array,
>> +                0, ULONG_MAX, xas.xa_index, XA_PRESENT);
>> +     xa_destroy(&userq->fence_drv_xa);
>> +
>> +     mutex_unlock(&userq->fence_drv_lock);
>> +
>> +     userq_fence->fence_drv = fence_drv;
>> +     amdgpu_userq_fence_driver_get(fence_drv);
> 
> It will be better to acquire the fence_drv reference first before publishing it.

Good point, going to clean that up.

Regards,
Christian.

> 
>> +     *pfence = userq_fence;
>> +     return 0;
>>  }
>>
>> -static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>> -                                  struct amdgpu_userq_fence *userq_fence,
>> -                                  u64 seq, struct dma_fence **f)
>> +static void amdgpu_userq_fence_init(struct amdgpu_usermode_queue *userq,
>> +                                 struct amdgpu_userq_fence *fence,
>> +                                 u64 seq)
>>  {
>> -     struct amdgpu_userq_fence_driver *fence_drv;
>> -     struct dma_fence *fence;
>> +     struct amdgpu_userq_fence_driver *fence_drv = userq->fence_drv;
>>       unsigned long flags;
>>       bool signaled = false;
>>
>> -     fence_drv = userq->fence_drv;
>> -     if (!fence_drv)
>> -             return -EINVAL;
>> -
>> -     spin_lock_init(&userq_fence->lock);
>> -     INIT_LIST_HEAD(&userq_fence->link);
>> -     fence = &userq_fence->base;
>> -     userq_fence->fence_drv = fence_drv;
>> -
>> -     dma_fence_init64(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
>> +     spin_lock_init(&fence->lock);
>> +     dma_fence_init64(&fence->base, &amdgpu_userq_fence_ops, &fence->lock,
>>                        fence_drv->context, seq);
>>
>> -     amdgpu_userq_fence_driver_get(fence_drv);
>> -     dma_fence_get(fence);
>> -
>> -     if (!xa_empty(&userq->fence_drv_xa)) {
>> -             struct amdgpu_userq_fence_driver *stored_fence_drv;
>> -             unsigned long index, count = 0;
>> -             int i = 0;
>> -
>> -             xa_lock(&userq->fence_drv_xa);
>> -             xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
>> -                     count++;
>> -
>> -             userq_fence->fence_drv_array =
>> -                     kvmalloc_array(count,
>> -                                    sizeof(struct amdgpu_userq_fence_driver *),
>> -                                    GFP_ATOMIC);
>> -
>> -             if (userq_fence->fence_drv_array) {
>> -                     xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
>> {
>> -                             userq_fence->fence_drv_array[i] = stored_fence_drv;
>> -                             __xa_erase(&userq->fence_drv_xa, index);
>> -                             i++;
>> -                     }
>> -             }
>> -
>> -             userq_fence->fence_drv_array_count = i;
>> -             xa_unlock(&userq->fence_drv_xa);
>> -     } else {
>> -             userq_fence->fence_drv_array = NULL;
>> -             userq_fence->fence_drv_array_count = 0;
>> -     }
>> +     /* Make sure the fence is visible to the hang detect worker */
>> +     dma_fence_put(userq->last_fence);
>> +     userq->last_fence = dma_fence_get(&fence->base);
>>
>> -     /* Check if hardware has already processed the job */
>> +     /* Check if hardware has already processed the fence */
>>       spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>> -     if (!dma_fence_is_signaled(fence)) {
>> -             list_add_tail(&userq_fence->link, &fence_drv->fences);
>> +     if (!dma_fence_is_signaled(&fence->base)) {
>> +             dma_fence_get(&fence->base);
>> +             list_add_tail(&fence->link, &fence_drv->fences);
>>       } else {
>> +             INIT_LIST_HEAD(&fence->link);
>>               signaled = true;
>> -             dma_fence_put(fence);
>>       }
>>       spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>>
>>       if (signaled)
>> -             amdgpu_userq_fence_put_fence_drv_array(userq_fence);
>> -
>> -     *f = fence;
>> -
>> -     return 0;
>> +             amdgpu_userq_fence_put_fence_drv_array(fence);
>> +     else
>> +             amdgpu_userq_start_hang_detect_work(userq);
>>  }
>>
>>  static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *f) @@
>> -404,11 +408,6 @@ static int amdgpu_userq_fence_read_wptr(struct
>> amdgpu_device *adev,
>>       return r;
>>  }
>>
>> -static void amdgpu_userq_fence_cleanup(struct dma_fence *fence) -{
>> -     dma_fence_put(fence);
>> -}
>> -
>>  static void
>>  amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
>>                                   int error)
>> @@ -452,13 +451,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,
>> void *data,
>>       const unsigned int num_read_bo_handles = args->num_bo_read_handles;
>>       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>       struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>> +
>>       struct drm_gem_object **gobj_write, **gobj_read;
>>       u32 *syncobj_handles, num_syncobj_handles;
>> -     struct amdgpu_userq_fence *userq_fence;
>> -     struct amdgpu_usermode_queue *queue = NULL;
>> -     struct drm_syncobj **syncobj = NULL;
>> -     struct dma_fence *fence;
>> +     struct amdgpu_usermode_queue *queue;
>> +     struct amdgpu_userq_fence *fence;
>> +     struct drm_syncobj **syncobj;
>>       struct drm_exec exec;
>> +     void __user *ptr;
>>       int r, i, entry;
>>       u64 wptr;
>>
>> @@ -470,13 +470,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,
>> void *data,
>>               return -EINVAL;
>>
>>       num_syncobj_handles = args->num_syncobj_handles;
>> -     syncobj_handles = memdup_array_user(u64_to_user_ptr(args-
>>> syncobj_handles),
>> -                                         num_syncobj_handles, sizeof(u32));
>> +     ptr = u64_to_user_ptr(args->syncobj_handles);
>> +     syncobj_handles = memdup_array_user(ptr, num_syncobj_handles,
>> +                                         sizeof(u32));
>>       if (IS_ERR(syncobj_handles))
>>               return PTR_ERR(syncobj_handles);
>>
>> -     /* Array of pointers to the looked up syncobjs */
>> -     syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj),
>> GFP_KERNEL);
>> +     syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj),
>> +                             GFP_KERNEL);
>>       if (!syncobj) {
>>               r = -ENOMEM;
>>               goto free_syncobj_handles;
>> @@ -490,21 +491,17 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,
>> void *data,
>>               }
>>       }
>>
>> -     r = drm_gem_objects_lookup(filp,
>> -                                u64_to_user_ptr(args->bo_read_handles),
>> -                                num_read_bo_handles,
>> -                                &gobj_read);
>> +     ptr = u64_to_user_ptr(args->bo_read_handles);
>> +     r = drm_gem_objects_lookup(filp, ptr, num_read_bo_handles,
>> +&gobj_read);
>>       if (r)
>>               goto free_syncobj;
>>
>> -     r = drm_gem_objects_lookup(filp,
>> -                                u64_to_user_ptr(args->bo_write_handles),
>> -                                num_write_bo_handles,
>> +     ptr = u64_to_user_ptr(args->bo_write_handles);
>> +     r = drm_gem_objects_lookup(filp, ptr, num_write_bo_handles,
>>                                  &gobj_write);
>>       if (r)
>>               goto put_gobj_read;
>>
>> -     /* Retrieve the user queue */
>>       queue = amdgpu_userq_get(userq_mgr, args->queue_id);
>>       if (!queue) {
>>               r = -ENOENT;
>> @@ -513,73 +510,61 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,
>> void *data,
>>
>>       r = amdgpu_userq_fence_read_wptr(adev, queue, &wptr);
>>       if (r)
>> -             goto put_gobj_write;
>> +             goto put_queue;
>>
>> -     r = amdgpu_userq_fence_alloc(&userq_fence);
>> +     r = amdgpu_userq_fence_alloc(queue, &fence);
>>       if (r)
>> -             goto put_gobj_write;
>> +             goto put_queue;
>>
>>       /* We are here means UQ is active, make sure the eviction fence is valid */
>>       amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>>
>> -     /* Create a new fence */
>> -     r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
>> -     if (r) {
>> -             mutex_unlock(&userq_mgr->userq_mutex);
>> -             kfree(userq_fence);
>> -             goto put_gobj_write;
>> -     }
>> +     /* Create the new fence */
>> +     amdgpu_userq_fence_init(queue, fence, wptr);
>>
>> -     dma_fence_put(queue->last_fence);
>> -     queue->last_fence = dma_fence_get(fence);
>> -     amdgpu_userq_start_hang_detect_work(queue);
>>       mutex_unlock(&userq_mgr->userq_mutex);
>>
>> +     /*
>> +      * This needs to come after the fence is created since
>> +      * amdgpu_userq_ensure_ev_fence() can't be called while holding the resv
>> +      * locks.
>> +      */
>>       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>>                     (num_read_bo_handles + num_write_bo_handles));
>>
>> -     /* Lock all BOs with retry handling */
>>       drm_exec_until_all_locked(&exec) {
>> -             r = drm_exec_prepare_array(&exec, gobj_read,
>> num_read_bo_handles, 1);
>> +             r = drm_exec_prepare_array(&exec, gobj_read,
>> +                                        num_read_bo_handles, 1);
>>               drm_exec_retry_on_contention(&exec);
>> -             if (r) {
>> -                     amdgpu_userq_fence_cleanup(fence);
>> +             if (r)
>>                       goto exec_fini;
>> -             }
>>
>> -             r = drm_exec_prepare_array(&exec, gobj_write,
>> num_write_bo_handles, 1);
>> +             r = drm_exec_prepare_array(&exec, gobj_write,
>> +                                        num_write_bo_handles, 1);
>>               drm_exec_retry_on_contention(&exec);
>> -             if (r) {
>> -                     amdgpu_userq_fence_cleanup(fence);
>> +             if (r)
>>                       goto exec_fini;
>> -             }
>>       }
>>
>> -     for (i = 0; i < num_read_bo_handles; i++) {
>> -             if (!gobj_read || !gobj_read[i]->resv)
>> -                     continue;
>> -
>> -             dma_resv_add_fence(gobj_read[i]->resv, fence,
>> +     /* And publish the new fence in the BOs and syncobj */
>> +     for (i = 0; i < num_read_bo_handles; i++)
>> +             dma_resv_add_fence(gobj_read[i]->resv, &fence->base,
>>                                  DMA_RESV_USAGE_READ);
>> -     }
>>
>> -     for (i = 0; i < num_write_bo_handles; i++) {
>> -             if (!gobj_write || !gobj_write[i]->resv)
>> -                     continue;
>> -
>> -             dma_resv_add_fence(gobj_write[i]->resv, fence,
>> +     for (i = 0; i < num_write_bo_handles; i++)
>> +             dma_resv_add_fence(gobj_write[i]->resv, &fence->base,
>>                                  DMA_RESV_USAGE_WRITE);
>> -     }
>>
>> -     /* Add the created fence to syncobj/BO's */
>>       for (i = 0; i < num_syncobj_handles; i++)
>> -             drm_syncobj_replace_fence(syncobj[i], fence);
>> +             drm_syncobj_replace_fence(syncobj[i], &fence->base);
>>
>> +exec_fini:
>>       /* drop the reference acquired in fence creation function */
>> -     dma_fence_put(fence);
>> +     dma_fence_put(&fence->base);
>>
>> -exec_fini:
>>       drm_exec_fini(&exec);
>> +put_queue:
>> +     amdgpu_userq_put(queue);
>>  put_gobj_write:
>>       for (i = 0; i < num_write_bo_handles; i++)
>>               drm_gem_object_put(gobj_write[i]);
>> @@ -590,15 +575,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,
>> void *data,
>>       kvfree(gobj_read);
>>  free_syncobj:
>>       while (entry-- > 0)
>> -             if (syncobj[entry])
>> -                     drm_syncobj_put(syncobj[entry]);
>> +             drm_syncobj_put(syncobj[entry]);
>>       kfree(syncobj);
>>  free_syncobj_handles:
>>       kfree(syncobj_handles);
>>
>> -     if (queue)
>> -             amdgpu_userq_put(queue);
>> -
>>       return r;
>>  }
>>
>> @@ -873,8 +854,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file
>> *filp,
>>                * Otherwise, we would gather those references until we don't
>>                * have any more space left and crash.
>>                */
>> +             mutex_lock(&waitq->fence_drv_lock);
>>               r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
>>                            xa_limit_32b, GFP_KERNEL);
>> +             mutex_unlock(&waitq->fence_drv_lock);
>>               if (r)
>>                       goto put_waitq;
>>
>> --
>> 2.43.0
> 

