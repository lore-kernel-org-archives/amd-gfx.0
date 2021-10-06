Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FC2C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 15:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6342A60FDC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 15:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6342A60FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A206ECD8;
	Wed,  6 Oct 2021 15:02:42 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 821F66ECD8
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 15:02:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a84Xv9g9xUlOr+nVtibmMW3Cx2O3Q7FxS0dXpJU23tzfBjhk5jHhnYLQkDJcGm9u+jq1J8aDKYjCItNF5yTkNSdy260ttrS1jAZbiCuvoHPkxNWWBs40BUU+1JpDDeZQQOxuJq2tl1j28Gq+Il/ckF8mMn3yTDQICJbYammnqSK1Pkbgd48gbvRfV+oguiW0wQJCvcjNva3psi3OIK3jl7uMZjcvHu13rrPGLn2WOcqoTOQ5HnVz/caVWTd0sjEGfsSnptSGlDf5YkXZc0FaqrNv7r4m38iAFes3JptDH3OPz+GdItO0dp+WmbkAmGIBLP2rWZX4XEiu6GYSIygaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1ykbt7hIbs0QdU5E2EZKG09riPnLcoP74IcrmzD0n8=;
 b=L9GwcBocQRPP17WGESB0LDN8s7Oh2BadA/w8WKQtMiutj6CacVSWP/tIDxrufGi2it3+ShHRPscPkX4iTfBtPpoBgHM5UR7grhX83HC0dVEythKcMqSNxoIgXiK0Jh4ibsejfKng35cJydj03d9BTE3xVITeyj9R83wvo58y187jWSX9sM6DYf4EAa2rWwgVOc0LfgglrUk/cd8e2gMN6nBFlYLQaSmhXRBAVoTiuTicXFw+/7kyeN++P8XfbK2TL8cv2icHG0SonRe5LsLTbJB/aDiT/Yn1gDYChGkRG01r/SYhteKlFK3typBeC9+bzN3LTaaDwYtT/nZhp4kZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1ykbt7hIbs0QdU5E2EZKG09riPnLcoP74IcrmzD0n8=;
 b=oBs/fsduaWBpfBkI1xOeVYkxZ8syR0WJ3NWSdUYOJ2nCoDA6pAwy5JgwI5fofiLIqdQJpNJpkWPIUEjo/vf/7xm9Z2YXoM3eBR/LJtAeNH74c8aTCbOzbmJIRKcj0Sb9pPeZWiL+El4bTm251sXs0NvXzPIRpn5Ml4p5/BwgdYc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Wed, 6 Oct
 2021 15:02:39 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%7]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 15:02:39 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: add and use amdgpu_bo_evict_gtt
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211006144529.61208-1-nirmoy.das@amd.com>
 <631488c1-9ae4-ba4d-b825-999bef07e5e8@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <bd11066c-999a-3ec7-4d30-eb9305ae1fd3@amd.com>
Date: Wed, 6 Oct 2021 17:02:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <631488c1-9ae4-ba4d-b825-999bef07e5e8@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM7PR04CA0015.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::25) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f21:1d00:e941:1883:217e:383f]
 (2003:c5:8f21:1d00:e941:1883:217e:383f) by
 AM7PR04CA0015.eurprd04.prod.outlook.com (2603:10a6:20b:110::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Wed, 6 Oct 2021 15:02:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31f0eadd-bf08-459c-f895-08d988da570c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5294:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5294DF0BB19B89B0DB566AC58BB09@DM4PR12MB5294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H9Gna+UxTfVoFohqtPBwFwOn8hVuNvOlxo6LxeGHf/C/Wf1jnb/hmbvtaNCnUVyKO3gfMh90M1SzN901fhPZ692NV63mQ/hPAiyWz1x5FqTfEU5j5XC3k9RHFrwwS+elM9P8Ajyaj7enmyoBdj6U5tDhTOgYYnQ1UI1G7DHFzND59ayf9gQQ+ASct7c3rkt7d/vdFUl8QpxTGnrox+/4aWK2D39GqRM637SujqJQNlDtjcAZ7cwo68KyvkVbCZt9mfFVj+gfNA5i4Tj3U+UdtLBy3+AiUo+VvbNVAl+DNO87t4z3b6mBEEDh987zIkjiYXOUhNamMy98b3VTa/nQmQ+Fne65MsUNdtbObtuTrX+99AVZF2FEKxers8trNL7AVHJYVKaHhph17OmMAsr8IVau0ywkXr9lrLcPoWbdiKmEYVAOBg3xsAj1vbEp56TbYcA5RPC1kKKfSt3DCDj1Y59tXNdJH5GLfxYEuf/nbI/U77BLRKFF/TlVrEpOgf0vprrtftVFwO0FfnoSOD+RFZXoqn/dmOFyeHKiW10VwkTUqJfs6aDBO/+WYh/yfG2jX+SR9It7Irb7Wop6AdYIWtPqdPf5nsj0M1LERI1HCdubHMU6PbrTy+5uk4j4nV39msOz/xhA6YyKc2l4PUDnixg+E1jiDBz1M4X01WMNPcc/kR9a/NzvEajNCZUH9TQjOZf2bmsp7P89pRigrC+4H5ibuowXngyVdgwclcaE2RQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(66946007)(6486002)(83380400001)(66476007)(86362001)(52116002)(5660300002)(186003)(8936002)(38100700002)(316002)(2616005)(66556008)(2906002)(31686004)(6666004)(36756003)(53546011)(66574015)(508600001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkltV2QxdzhLdk1pWDlTOWhBd0pMb3VDeFpBVmd1eklaQ0dxUzhNZzFreStY?=
 =?utf-8?B?TjI2dXR3WXh0amViVkh4VWFnbkFyMzFWUk82VWptT0k1ZGJONFR5eC9YenY4?=
 =?utf-8?B?d1JQL1BOYUh0TmVTV0ZXOVlLRUw0S0tFdGJ6cUwwZjlzQkkzNXNZM2JKVTNi?=
 =?utf-8?B?M1pGdDhzUW1DUm9WbkZudmkrRnlFMHp1Qzd1M0d0WS9oVk5ncGF1ZkpIYWlE?=
 =?utf-8?B?ZFlvaldITWw5eTBrY29GdzZPZUNpTzNvNS9sUWg5em95N2RmWGtNNGx1L2NH?=
 =?utf-8?B?WEVYWmlFaWhYbjl1anVLUE5RT3JsOWhnWVc2aXQ0bFZlL3Z0MGR6MFN4TXN5?=
 =?utf-8?B?Nk9UZ0EvYU8yQzlVazVOT2pucFRQN3ZZWkdzdmpYR1lmQkY3ZVVCcXpjaDUz?=
 =?utf-8?B?ZGdUdWcxSk0ybUNTZzJwRG5NTThJNDc5Nmxxck1UUER5RHd2Q1I1VkFoci9S?=
 =?utf-8?B?cyszWXdpMHUyeW1qL2ZtT3ZvSjBlZlgrZkwwQ2lhZDQ1WnZreUEyM0RrWlhr?=
 =?utf-8?B?S1g2M3g2THMrclRMRjBqSWNqZkNNY3NMOGJZRGZZek1PQlhnb1paVWx0dnFI?=
 =?utf-8?B?YWFRSCtHRmI3QXIwdmpwYVVxbGdYd005WTkyT0w5L1ZUZVpyUWxIMWdzVWtF?=
 =?utf-8?B?Qm5xN0pnbit1cytWV0NRSXlLeDR4VmdRenQwN1ZIbE56NXBFOHEydFNsU2Qw?=
 =?utf-8?B?a3ZGc1ZnZ3JrYTRqRjgwQTJHQnJnVG5GaXVtbTBBUmtlUnJyeDFIeUMvSVV3?=
 =?utf-8?B?K0NDWmVrNklZMHN0T1ZtOFB6T3AyRzVCUDBOQ0lvWXAwMXJ0blZhVGlRc2tC?=
 =?utf-8?B?eDBGK1FHRmZRWXRiSmxTOWhjNGl1SEZVTWNySC91Sy9GUXZIOG5EK2dBK0JQ?=
 =?utf-8?B?djlkczZWUUgrVWx5cktYMlB0SG5LTVhza29iVitRNDEyUUlHbFNrNVMralYx?=
 =?utf-8?B?Vkh1azhYSHJaT3lJNVBkelV3ZHJmdStjUWJ0eGFaajRUbzVhYm5YUldySGF4?=
 =?utf-8?B?eUs4MVZmRElqV002U09JR0lEdnpmWHJmelVMS2hia2NDQ0k4UThaZ1ZVMXlL?=
 =?utf-8?B?cUNpa2xmQmlESGlsdGlsSlBZL2s3UXJFT1Q4SnFwMVZkUi9PSjVrdEFZZnVv?=
 =?utf-8?B?K0VQUDJaQ0U2ZWV4NTZ3VTBWYnJjVG96WG5vNzRkVnJmQ2hmZUtyclFEQkFm?=
 =?utf-8?B?cC9hOHcrMDdaZTdkb1lxbGhVem53dEphU1Q4OC9iUDdVNTZnS0s5RlFEOUdE?=
 =?utf-8?B?dWVxOE1iZ3JSVmgyd2JTU2NJTmxrOTNXWnZVMWJ0RS95Nzc5TGx5MW9PQXZ1?=
 =?utf-8?B?ckFTVXBxMEdNRGVJN0Z6TEw3aFFTNzFFVEZVQjQ0bjVNSGY3MUo4S2RsVGtL?=
 =?utf-8?B?c2VBUkdnaDBRcWw3eEIxTU93dXVMdnlDWHVnUTQrVVNQbXdoV2NGTG93WFJJ?=
 =?utf-8?B?MzFiZWRwbWxTc2NYWDVrcVRRdnQzcDlEWjN1b1h5dGExRTdsVk1xVVBoWHZw?=
 =?utf-8?B?T25KRGNwTnVLQWtwR3drN25nNTFZSmcrNHFMaCtDWUs3YlR6WVhaZzJJSUc5?=
 =?utf-8?B?NzhGU2k2KytHbi9wU1pPTE9nRWxwdnQrZVI2RHJVNzBvR3N6S1ZYMm1QdkxH?=
 =?utf-8?B?b1RieFhuZ05ySDRmWlY3dk9nU0NtT05TbjFZRGF3Qi92R3BGclhXV3l6dkRN?=
 =?utf-8?B?d05yL3o0WUpsNnJhSWdkWnFrVEI2SVJjLzdkTHdwbWlUTGJnVE1VUWVMdlNU?=
 =?utf-8?B?dFJMT05wMmZPMm5GR3dQMFBHYXVxVHF3aFZjL3NKSzc4MmRqdjJGbWpZVnpD?=
 =?utf-8?B?bVNyanZoYUl3UW1sa3Y0dzFsU3J4c0s5TzZYcUR2VXRZempWK3hFRjcrMHNP?=
 =?utf-8?Q?QT/EQuZdI9ZVd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f0eadd-bf08-459c-f895-08d988da570c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 15:02:39.5198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTTIXBpCv70DxwVHHhBADQXGKtth0rXqeOvnwAkaXGV0RuJ02u1lOLSXRR29b1Syc+L8NWlOul4Cw4JvcHmc5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
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


On 10/6/2021 4:58 PM, Christian König wrote:
> Am 06.10.21 um 16:45 schrieb Nirmoy Das:
>> Unify BO evicting functionality for VRAM and TT memory
>> types in amdgpu_object.c. Use amdgpu_bo_evict_gtt()
>> for evicting gtt memory similar to how we do that
>> for amdgpu_debugfs_evict_vram().
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  6 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 52 +++++++++++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 +
>>   3 files changed, 50 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 5497e2d31d1a..67045983d63d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1341,17 +1341,15 @@ static int amdgpu_debugfs_evict_gtt(void 
>> *data, u64 *val)
>>   {
>>       struct amdgpu_device *adev = (struct amdgpu_device *)data;
>>       struct drm_device *dev = adev_to_drm(adev);
>> -    struct ttm_resource_manager *man;
>>       int r;
>>         r = pm_runtime_get_sync(dev->dev);
>>       if (r < 0) {
>> -        pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> +        pm_runtime_put_autosuspend(dev->dev);
>>           return r;
>>       }
>>   -    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>> -    *val = ttm_resource_manager_evict_all(&adev->mman.bdev, man);
>> +    *val = amdgpu_bo_evict_gtt(adev);
>>         pm_runtime_mark_last_busy(dev->dev);
>>       pm_runtime_put_autosuspend(dev->dev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 4ec904f36ceb..3b8c9cf44d74 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -1005,10 +1005,37 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>   }
>>     /**
>> - * amdgpu_bo_evict_vram - evict VRAM buffers
>> + * amdgpu_bo_evict_memory - evict memory buffers
>>    * @adev: amdgpu device object
>> + * @mem_type: evicted BO's memory type
>>    *
>> - * Evicts all VRAM buffers on the lru list of the memory type.
>> + * Evicts all @mem_type buffers on the lru list of the memory type.
>> + *
>> + * Returns:
>> + * 0 for success or a negative error code on failure.
>> + */
>> +static int amdgpu_bo_evict_memory(struct amdgpu_device *adev, int 
>> mem_type)
>
> That function should probably be inside amdgpu_ttm.c instead.
>
>> +{
>> +    struct ttm_resource_manager *man;
>> +
>> +    switch (mem_type) {
>> +    case TTM_PL_VRAM:
>> +    case TTM_PL_TT:
>> +        man = ttm_manager_type(&adev->mman.bdev, mem_type);
>> +        break;
>> +    default:
>> +        DRM_ERROR("Trying to evict invalid memory type\n");
>> +        return -EINVAL;
>
> At least in theory we could do that for OA, GWS and GDS as well.


I will add those and take care of other comments and resend v2.


Thanks,

Nirmoy


>
>> +    }
>> +
>> +    return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
>> +}
>> +
>> +/**
>> + * amdgpu_bo_evict_vram - evict vram buffers
>> + * @adev: amdgpu device object
>> + *
>> + * Evicts all vram buffers on the lru list of the memory type.
>>    * Mainly used for evicting vram at suspend time.
>>    *
>>    * Returns:
>> @@ -1016,17 +1043,32 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>    */
>>   int amdgpu_bo_evict_vram(struct amdgpu_device *adev)
>>   {
>> -    struct ttm_resource_manager *man;
>>         if (adev->in_s3 && (adev->flags & AMD_IS_APU)) {
>>           /* No need to evict vram on APUs for suspend to ram */
>>           return 0;
>>       }
>>   -    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>> -    return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
>> +    return amdgpu_bo_evict_memory(adev, TTM_PL_VRAM);
>> +}
>> +
>> +/**
>> + * amdgpu_bo_evict_gtt - evict gtt buffers
>> + * @adev: amdgpu device object
>> + *
>> + * Evicts all gtt buffers on the lru list of the memory type.
>> + * Mainly used for evicting gtt buffers through debugfs.
>> + *
>> + * Returns:
>> + * 0 for success or a negative error code on failure.
>> + */
>> +
>> +int amdgpu_bo_evict_gtt(struct amdgpu_device *adev)
>> +{
>
> I won't add a wrapper for that. This looks like misplaced and overkill.
>
> Christian.
>
>> +    return amdgpu_bo_evict_memory(adev, TTM_PL_TT);
>>   }
>>   +
>>   static const char *amdgpu_vram_names[] = {
>>       "UNKNOWN",
>>       "GDDR1",
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index 8ff61bad4138..5e9b7710b8e3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -306,6 +306,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo 
>> *bo, u32 domain,
>>                    u64 min_offset, u64 max_offset);
>>   void amdgpu_bo_unpin(struct amdgpu_bo *bo);
>>   int amdgpu_bo_evict_vram(struct amdgpu_device *adev);
>> +int amdgpu_bo_evict_gtt(struct amdgpu_device *adev);
>>   int amdgpu_bo_init(struct amdgpu_device *adev);
>>   void amdgpu_bo_fini(struct amdgpu_device *adev);
>>   int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 
>> tiling_flags);
>
