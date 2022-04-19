Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D28C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 15:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2129410EEC0;
	Tue, 19 Apr 2022 15:14:42 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2047.outbound.protection.outlook.com [40.107.96.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABDAC10EEC0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 15:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmqVe5WSlwThG6+N3s+pklk9WFyYPNZleHMaqKn/Yar8aWhzcnp4PgLLmz5Me1kH/jXuEK6QnOyRJJKn/cRH6F8vRjdyuNGjYB+Lh4WS+mD5z/4g7iNU9qe5r6AeWH5oEy0rFxRL+Utb84a7/MBNReyf504/iE8BJTUfBpfVZmpPA7abfkEAEbBlN/NdbMQToOuR8yN1QKJyKtuTtqVvqGTzK3VLJj5PRB0hMH6MVl3gwq/oK2dOfpljul53bgsaLaePzQGrGxDLDiyb1pANCK/vQfEK8YrAm9Q2VTcnwSxlN//CC08U5EyXhp+4dgcrri3JyWAJNaWjHU4m6L4k8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge0pZNKRcxZoxrrqhA8ITPMrIK1uIQTAOgFewPIZkxk=;
 b=h41PAU3LSMXN6IcR7k2pg0NfutUZOE1e/Fqa7+cv5b4EMxoyon6n38rRFbLJ/0IzYjIlPFjQX+mgtgOV8MqOJvVkFOWj+poDGdKoCJwS0pPPiRYADfnxbsNviRJVN/NT1syaE0//aBSs4dHVyTe18TLoX0oS9jjA9iDnY71jaMCXrUWPI6Bl309icTZuVBFC1Pn3jK62cKibpuHlUbwY0C3MyGBn0ycVIzd6qS6AOjiD3CSlv/MwmH6NM2OXmpdCYYwBHrv+xlWEvXMathIi8pQbETp8b6HuBqFF0OsueVDySsYx2uXKc8izC3UN40aDrjJ8TVEE+G45fbDrK0b0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ge0pZNKRcxZoxrrqhA8ITPMrIK1uIQTAOgFewPIZkxk=;
 b=avs2SY1hzDUHbbnsV7+TL4nwRqsqpM+1WtpYG8YsSeUtb8Ghy2zFy5WnkH1H5xntRhAiuU0LmeusdpfGEvRdb0MF/4x7Fg9xa2sPa84UGIL28RloJHSlTyNiDU7AvMpbbVmEPPNzm3ds7/IUSQXi0l+QaX7uLGwQup9QI7ek3OQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 15:14:35 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3c53:b805:4206:6620]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3c53:b805:4206:6620%9]) with mapi id 15.20.5186.013; Tue, 19 Apr 2022
 15:14:35 +0000
Message-ID: <4f784874-8fe7-8bb6-1a4a-1bcc0c3334e6@amd.com>
Date: Tue, 19 Apr 2022 11:14:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] drm/amdgpu: remove pointless ttm_eu usage from DM
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Ryan.Taylor@amd.com, amd-gfx@lists.freedesktop.org
References: <20220419141915.122157-1-christian.koenig@amd.com>
 <20220419141915.122157-2-christian.koenig@amd.com>
 <a9ec25f0-0404-3b4b-64fd-8acf697ca3b9@amd.com>
 <29e81464-ad03-a159-ef4c-3dd39563299b@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <29e81464-ad03-a159-ef4c-3dd39563299b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::15) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8a0b8b1-46c1-4400-c30c-08da2217504e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB27198204C6B231E1941021F58CF29@SN6PR12MB2719.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVxjDuDa10U+/bjoZVSC7VlCZ5kS5f7hFtG8kkTZILorpkwKRa2vKXbqU0RtflBfTIV3vOEjufNNXJ8L/HLiOJCy75HVJnpPlnx6ysEsQ2FF+wo4D9frn3F7bDZslzHCUAbZdeZXY0VYqL/SWihJ6HMtwY40wd//dC+7uu000zMaTy7gTpCYhOhp3mdRYYr1aiTS/c242P6X8w4aXc/OtNeMFuM51VkyClTxkMi0mEh/KYTRghdwqjtqhw7nXX0stZYcbuRbfilxa1fsV9tsA8SaEZvHEP8EkMsfku1YGAfMLeAhoZK90VG9WrZ/2A7CnzUmhszeMpLQYjX7qsuLrpr3blKdIRCblEsF1BCp4e8DV09EvZoTCIjp6ozC8pfgl++tP0zC/fABbWvYb0+X6MWtrKDkgwjwF7Zt7vmKefSYqPKL6K1QoAs8Uv4fxOHG6WQWZo0s63r0UzKAQjxZIJk7kDmAUjluu/4K7A78hhYB5Dx30PaWqZV/6blHUqO5SrZtSKYlDlxx8xBazkBpVVAaQ47d37jvk1t5JwqLYIYTlilHO2oyVIhq8s5zHdaO6w8iECR0RX5id8NVuhE+M6qNcUZSbReNA6wMD33StGoUbitjJMhvBm4G04U2mYM99fwtuMiRTulMGrbzv6ajsmgoWHkzGg9tMooAXp5rZg/y9pzMcjXRtcoutXnqvEW4Ow7Ednz/VwxUA+oabwfcm4zOouiOmPeHkLaUbIPH4na+nl6Kf+WpHY+FxJXSaZ58
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(2616005)(86362001)(6666004)(26005)(53546011)(83380400001)(31696002)(8676002)(38100700002)(6506007)(44832011)(66556008)(66574015)(6486002)(8936002)(186003)(66476007)(66946007)(31686004)(2906002)(36756003)(508600001)(110136005)(5660300002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzBFTEVLeSt6YUM0Uzl3aGlNTVk5T2FqRjdGbXMzRi94T0hhKzZSbEJvT2tK?=
 =?utf-8?B?anVydFEzdFVEZWV5WXdicCtaOTZzZGtKZ1BGSjA4bUFMdCs1Ty8yU05wemRU?=
 =?utf-8?B?WDVoMWk3NURnQ1g4VGg4Zk1wN28xclhDTUVyclEwN0RTVjBVbDM2VGJWVmZW?=
 =?utf-8?B?L0duWHd1czdYb3Q4MFNobEZ6Qkx5aTRmWlZkL2x1ZDNnQlJTTjYyN3RXaWhP?=
 =?utf-8?B?WnU4Q2Uzc05RMUU1eU5OYUd6VjBTODBOY1dxa2V5cTNhRDZNSVZPY0ZNTHBk?=
 =?utf-8?B?Yzh3VGpXbmtoWGo1elF0ditvRlNVWWhialpObW83QUhvZTE3a2lIWmEvNG0x?=
 =?utf-8?B?YXB4ZVNDa0hRTGtySVpudGJ0ZTlvS3lpOXFhSklDSzJreElkNzk4YlNETmtl?=
 =?utf-8?B?UXFsUjlEU3dDYlZ0dE9lNHNjejA3M2JxcnBEMXNRWU1NaFBRekdvOWlEZFk1?=
 =?utf-8?B?OVBlZG1hdVlLSEhTaWZTb0hnUFZ1aWRncjBGbGlyUHlsWmc1V2xNSXZieWUx?=
 =?utf-8?B?NTdnOXBNUzFEL0FFV1VRdUs1YnVNSFJiVHAyOGVLVjR3ZjRSNmp4YW9yM3Bp?=
 =?utf-8?B?aFp4N0E5M0NpZkJlQjBvanBSV0Z1enBzTmh2VGJ1aXpKWUJHQTdpaldlRXE5?=
 =?utf-8?B?NUdZNTJQemlRcmg4NVF5eGh4b2pLU0lyVDlPNU03T3pEeGdzbWlMOXVUSmpX?=
 =?utf-8?B?aU85V0JaWUhRajBEK1BaZVZibi9US3EzWFduU013V3RlZE85OEpET3Iza3l6?=
 =?utf-8?B?Ny9IdEhGYUp6UUs1bG5rNlZaa0JyM29MMmNOWEFtdXhZUXplTVlMcmxvSENh?=
 =?utf-8?B?bG9ETGpjSWU2OGNlSXA2NGFGNE80Ym10Qm1sWlB5TGV3MkJsdHJFUHUvM2ZK?=
 =?utf-8?B?a25VbTZ3R1lRL24zMEN1dktLZGNSdUY5alNvZEZuMnVmL3NTQyt5azk2eDli?=
 =?utf-8?B?dFFVTDMvbDVRek9wWTkvYjdLUXFHZmdIb1ZwRmhOU2p1WXJrTUpiVEF4UElj?=
 =?utf-8?B?UG9PelI0b3ptbWpuWEhGQUVhbDQ4MEhFL0ZvVFF1KzVha0w0bEI1SXd4d1A2?=
 =?utf-8?B?MEhTY1QyUHA3QW8vL0dsaUE4QmwvVjV1bjRaNVVrU09mdGZIdjM3R0JaYXov?=
 =?utf-8?B?cmVxWVllbXhrb2pvWEdsc1BxcmlYbXpyL0JqZjlLNnJCek5XNG9LRWtNOVpw?=
 =?utf-8?B?SVJRYUVPdnF3dnFDWHNFSG1JVnhFUWlDWjZlMERCTXN6TXpxbWN1N0FDdjhC?=
 =?utf-8?B?NGVXTWliMjlrWEF4V3JYRTZsRE12R0RsdjJIZHpGa3BoV1lEc3JBb1VyUXcz?=
 =?utf-8?B?ek9PVkp3aHhpdlRwZHZjT3cvNXI1b1dnaDFoNHpsY3ZLR2VKa3E3andwQlJ2?=
 =?utf-8?B?dU9IOWNGdVBsaHJsdWRVZVorQkRsbnhleHRaN1Z6d1czMGEwNS85Z1hyS3RJ?=
 =?utf-8?B?MHdYZzF4WEVlaUxOb1NBL1JHM200ZnVpYjA5UGJORjhwVk1FOHI4eDQyWGh4?=
 =?utf-8?B?WnNuQ1ZTS1lSTEtJZlFSUEE3UjJDZWpOT3BsNlpxUWwwdmtGQjJXZGlwc2lI?=
 =?utf-8?B?L0toMndlUEdlV1FNSkx5SExraVkyM1M5UCs5ekRqdnljeWhPVy81UDZIb3U5?=
 =?utf-8?B?VFpIMlVqWStyelFYZThYUmROb2ljYU0ySWNZNnhPcjgvQnpmeWF4V00rbDk2?=
 =?utf-8?B?bzhsK2VRUUJyeU4wYXVxaHVOZ2dYM2lFYUNQTytNcDkwbElHN2pZMEFYODNK?=
 =?utf-8?B?MHlqREUxWk94dTR4d2E4RXNBWWxkWlgvcVBiQlZpOHMrb1MvWXViTkNobWNP?=
 =?utf-8?B?WXQ3VnFFSDBIQWxRc2U2RFJ6cnk0aC8vci8rM0NZdG5QZzcyQ0NjL2t0OG13?=
 =?utf-8?B?SkdEOU1mT01PMUE4aXZjVVNiSVBKOGJLRzBQL0RDWG9yNjB2UnBqeGhiT0hV?=
 =?utf-8?B?N0tNYkV1TnJwcll3WTJ6SW5UNE8zV3gvSjFGWlgxV1Q4dHZqc2VQMlhOQzMx?=
 =?utf-8?B?RlpDNGZoZ0MyNTdSOStsNktOU2thTDFQWHQ5eERnc1BwMkV0VWNjV1Z0NFNE?=
 =?utf-8?B?MG1CVVpCa0NLZjVvd3FRelZtdFgwd2lWL0JqSThocWtvUWYzVEJuZUVQOWlW?=
 =?utf-8?B?blI3dTVRaG1DOXZ5ZGxUVTlnM3BBTTNaYW55dW94ZzdaTEpicGpxV05tSEJn?=
 =?utf-8?B?dkJCMlUvbUN5b21oZ0pFd3dwcWloVjM2d1JqcnZ0eG5BNHNoMWgrQTdjSzdi?=
 =?utf-8?B?azJKNks4a3RVd0FiemtjTi8xc094czBhV1JhN1Bkcnd0NUwvYnZzUURac2lp?=
 =?utf-8?B?eURqeUk2RnJFZThUUkE2MzdROHkveUJISGUrbVhUK1VJaFVSbkJoQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a0b8b1-46c1-4400-c30c-08da2217504e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 15:14:35.7495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRp8EkqWFw2joKhB1zgOdmMdKddpoWp00ZpOMPFCnU/rcHVje8HoMoIApYWdF0Dm+le0OK6FTSanyJdqgM14qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2719
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



On 2022-04-19 10:42, Christian König wrote:
> Am 19.04.22 um 16:37 schrieb Harry Wentland:
>>
>>
>> On 2022-04-19 10:19, Christian König wrote:
>>> We just need to reserve the BO here, no need for using ttm_eu.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>
>> Acked-by: Harry Wentland <harry.wentland@amd.com>
> 
> What about the second patch? Who takes care of amdgpu_vkms.c? You guys 
> or should I ping Alex?
> 

We're not working with amdgpu_vkms. Looks like Alex already responded
to the other patch.

Harry

> Thanks,
> Christian.
> 
>>
>> Harry
>>
>>> ---
>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 ++++++++++---------
>>>   1 file changed, 17 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 73423b805b54..91e9922b95b3 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -7583,9 +7583,6 @@ static int dm_plane_helper_prepare_fb(struct 
>>> drm_plane *plane,
>>>       struct amdgpu_device *adev;
>>>       struct amdgpu_bo *rbo;
>>>       struct dm_plane_state *dm_plane_state_new, *dm_plane_state_old;
>>> -    struct list_head list;
>>> -    struct ttm_validate_buffer tv;
>>> -    struct ww_acquire_ctx ticket;
>>>       uint32_t domain;
>>>       int r;
>>>   @@ -7598,18 +7595,19 @@ static int 
>>> dm_plane_helper_prepare_fb(struct drm_plane *plane,
>>>       obj = new_state->fb->obj[0];
>>>       rbo = gem_to_amdgpu_bo(obj);
>>>       adev = amdgpu_ttm_adev(rbo->tbo.bdev);
>>> -    INIT_LIST_HEAD(&list);
>>>   -    tv.bo = &rbo->tbo;
>>> -    tv.num_shared = 1;
>>> -    list_add(&tv.head, &list);
>>> -
>>> -    r = ttm_eu_reserve_buffers(&ticket, &list, false, NULL);
>>> +    r = amdgpu_bo_reserve(rbo, true);
>>>       if (r) {
>>>           dev_err(adev->dev, "fail to reserve bo (%d)\n", r);
>>>           return r;
>>>       }
>>>   +    r = dma_resv_reserve_fences(rbo->tbo.base.resv, 1);
>>> +    if (r) {
>>> +        dev_err(adev->dev, "reserving fence slot failed (%d)\n", r);
>>> +        goto error_unlock;
>>> +    }
>>> +
>>>       if (plane->type != DRM_PLANE_TYPE_CURSOR)
>>>           domain = amdgpu_display_supported_domains(adev, rbo->flags);
>>>       else
>>> @@ -7619,19 +7617,16 @@ static int dm_plane_helper_prepare_fb(struct 
>>> drm_plane *plane,
>>>       if (unlikely(r != 0)) {
>>>           if (r != -ERESTARTSYS)
>>>               DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
>>> -        ttm_eu_backoff_reservation(&ticket, &list);
>>> -        return r;
>>> +        goto error_unlock;
>>>       }
>>>         r = amdgpu_ttm_alloc_gart(&rbo->tbo);
>>>       if (unlikely(r != 0)) {
>>> -        amdgpu_bo_unpin(rbo);
>>> -        ttm_eu_backoff_reservation(&ticket, &list);
>>>           DRM_ERROR("%p bind failed\n", rbo);
>>> -        return r;
>>> +        goto error_unpin;
>>>       }
>>>   -    ttm_eu_backoff_reservation(&ticket, &list);
>>> +    amdgpu_bo_unreserve(rbo);
>>>         afb->address = amdgpu_bo_gpu_offset(rbo);
>>>   @@ -7663,6 +7658,13 @@ static int dm_plane_helper_prepare_fb(struct 
>>> drm_plane *plane,
>>>       }
>>>         return 0;
>>> +
>>> +error_unpin:
>>> +    amdgpu_bo_unpin(rbo);
>>> +
>>> +error_unlock:
>>> +    amdgpu_bo_unreserve(rbo);
>>> +    return r;
>>>   }
>>>     static void dm_plane_helper_cleanup_fb(struct drm_plane *plane,
> 
