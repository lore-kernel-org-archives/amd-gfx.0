Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E68C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 09:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52406610D0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 09:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 52406610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED4726E948;
	Fri, 22 Oct 2021 09:47:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6577A6E948
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 09:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaCdXxPsehsT2/ITXNuNMuwlDlkuSjD33u4vLEWENjKTszaqUulQ61DqtuABEJ87xY8xNRqM/lbO10BioCFNdUFCATEWtTQRUqvXYGYaQQjHYvKCro722d3I2lVrMc0pcwyWVWlYjHpGdiemeRZ3W9laskw4p7dvKcRkL6ckRnU7FOScz6Ox3enkpOLAP4HBNCW7MObLWXfNlNLu7+nhPxduFirbTO+YNBLnbJ/jRk0DUQ25esqE9rnQua5CnRIDQE4IetQ72Mp4r+E/3QrgbTIG3Nqti/cxWkSbqERVHphzEvqc3QAljG6ilTey+aWfPpyLkI7nHOnbGCr4KQXvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLHR60pn781KhYIILIZLeFiBVuthEbuisJwmGwpJuo4=;
 b=LYfrdcwvbVKVsgwQVpyEvR4wBvtu5b6LxsAJqoJ/HsjFbQPAZfH2NqNT+yCN1FtRx1YGQxlVEzgIOtUbQib7MpbprWMnR7LMm5cPsbEper8YNiT78HM8vCIwaL0bkSv+VmAUUc7NtobamOjbElJazL68yIjMLWZt//7HeoHQ8BUYsFRnAjO0v17TCmyjUzwuD4kIOqtX/ameN7TwM+eYCGMmLY7FsNDujO+176BNBzSwfRWVyxr2FLZvDuOwNTKf14TBxfiAbG69DK8FYNx4rdkriL2D9GTUrO+rrvZGKku0dwdO+T5ipdluGiOkPxFvaTsOFAGTOFH/FOrCPY3+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLHR60pn781KhYIILIZLeFiBVuthEbuisJwmGwpJuo4=;
 b=kX/EWKsK1htkAoBo3k2L1gjsyFw6yN3LRD09bLShe2STw2Prf9UPCci0mLomMAZ45Jow+0ibTohN9t4FpyC5p/srE6MEF1vPJVeC3nOZ+wCOxXBLl9ou8uJWxz0li5HxfWpF2yu4id/DlWVvZC6752UsfBfQSuXIVB7alkYP6xQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 09:47:56 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 09:47:56 +0000
Subject: Re: [PATCH v3 1/3] drm/amdgpu: do not pass ttm_resource_manager to
 gtt_mgr
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: andrey.grodzovsky@amd.com, lijo.lazar@amd.com
References: <20211022093231.7787-1-nirmoy.das@amd.com>
 <3c9138cd-3635-29fb-f4c5-19eccb2b1410@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <2d0cdcd7-bb4d-049e-7e32-bb692121a708@amd.com>
Date: Fri, 22 Oct 2021 11:47:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <3c9138cd-3635-29fb-f4c5-19eccb2b1410@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AS8PR04CA0029.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::34) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.87] (217.86.122.144) by
 AS8PR04CA0029.eurprd04.prod.outlook.com (2603:10a6:20b:310::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Fri, 22 Oct 2021 09:47:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b1d38c1-1a8f-4e68-d93e-08d995410637
X-MS-TrafficTypeDiagnostic: DM4PR12MB5182:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5182F29BA63352AA8765304B8B809@DM4PR12MB5182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OU6D2KV4tWwMC2EsYb6/HLT1KEDWIErrv3xmZg5P9nOm9woplCH0IuYyDBSRW3ZFXDCgrwFy2DPWUnlcF70buun7cOIUN3X9dL9dzukPV15in3gSZtRJoifNBsNE7ECi5+k3svhc+EP5lI9kaMwcSQGqPxjN2/ccznBDMYaEgNmvrjSfAKROK2aEyACno72HiRiQ0oCkvsws8CaVvmwHm3Tzv6pzUljaHXaFdZLIuI4ZzUR0No7WpBH1+DLaHtO/NA6wCwwDjXvwIFwqjfSPNrlaQw6CZcvUzbK0lDCM7w/Dr9pmz2q4gOppLNCvkBbM3su59ezUeIsarG0Gx/f5IuJw+9+ydTABDOXWdcPaRLEJWegP51QTyganauc/B98sWbwvvhnuJ0zCdPpW/h7PC+eReGl4zaPosBVzIva6n5m98SkdslFnPFEuwkpFnONnQdZPRjwEF0moYWCc6kcOxJoH4en/prb4Ux7JHoTPTiGIN3lzEgCmzB6VkFtsobkz0/cGkw8gKL7S6SLlQk3GrPG3KFmYThpDOZhAepkGvEfT+9dEMTZEHi0PZMKP5qbezTLdkLrmGH2Hn4pIcEqipYogf9qHBYAuGM2Qpdy+8b1Wg3ArubHG5t75Fl+59Eeou/66yMwlVxzTdDsR6vq2VpyPVWzqkP6PWQ5l3SvqtWXrdcpsf7TSOCEW1CjYC499/l0De6fHWRAcs169BLFOsQK6+2gRhfS2u+OWvHZr37I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(31686004)(66574015)(508600001)(36756003)(83380400001)(38100700002)(2616005)(956004)(4326008)(8936002)(6666004)(66946007)(66476007)(66556008)(6486002)(2906002)(316002)(8676002)(53546011)(110136005)(26005)(186003)(16576012)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlBhRmM1M2xtaDZsTlNKd24xVnR4NGVKUEtPUVZnblRrTlNyY05zempIUmpz?=
 =?utf-8?B?MU1IM0xlcW5Oak9JTjRNRFpTUVlndVN2N3ZJTHdzMktxbGFOVHJQeVM1VDNG?=
 =?utf-8?B?bjIyNG56WmJ0bXhPeXRaZkZDejJTeVZFVXV1ZXNmK0xaNWFJQW1BcFNzZ3N3?=
 =?utf-8?B?Q29WMll6TlJwZVAzRzVUOG9vQmtGRFp0ajMwSkZBWG04VG5sSi9TaW42VWU4?=
 =?utf-8?B?Mm9IdWxTZjNFbXIzcFhXalViMFVDQnlZNnY3ZzZqY2UyWjc0U2hOeml2bEFF?=
 =?utf-8?B?UzZHNHFLZlRBQVUzRDRGR3dBeTlKUFFyaTIxSTRGVGhBL0VCcW1mTDF6UG9X?=
 =?utf-8?B?b1ZQZkZ6aXJqMTBJSk45VWx0WHdBSzN1NTJ5aytMUTBWUENBSDhLNEdoZDFw?=
 =?utf-8?B?UDg4L3h2anQ0ZVppNmk2UFNnenpvOHowYnViNUY1MW4yVDZ2S2VZRVE1Q3dT?=
 =?utf-8?B?MWhEMGNrY05sYW5aMDdUMHowYjByaGIxOGhWVHFORHU3YStqMlNocEN0cklX?=
 =?utf-8?B?MnpVTmhFcmZYRWRIZnFqQm1zS2l4V1lIbVNvZlU5c2VwRFhDVHE5S1RrZEll?=
 =?utf-8?B?dVlxNUFtMUxYNFJKZGtQRXRPZGh0VGYzMnZnR3YvbXJYenlyU3lZdElKb0xp?=
 =?utf-8?B?QUcxaGZaVFUycHN3WGpWOXc3WjlybENxQjB3Mld2STkxWWZaODFDMkN6Nkk2?=
 =?utf-8?B?VzFKejFyWU82aHNUVVZSSlN2cytLYXhLNHkxeVJ0Rkd5c1NSNnh3dHpaZWRr?=
 =?utf-8?B?VDZOc3lRTmMvVGd4SjBNalVBVng5VGVhc1ptOVFoRUkxV2pacmV5bGh0SUZa?=
 =?utf-8?B?MWZJU0gvUUx6dloxNG41dGJmWHh6cHArMXJSL3YrbWsvZjZUVGV3cEc2NkJH?=
 =?utf-8?B?YXVJZTdhN1AyNHlwbUkwejFCdkZ2bXFZZ3Y5QXExT1I4NUFpSWc0NUdQcldp?=
 =?utf-8?B?VjdYMWpUS09kaXZlNk5ReU9TUDB3aXRyZVM1TnFpOUFOOW1xWlM5TVdPcjBh?=
 =?utf-8?B?SVh1T2ZxWTdKRm1FbE9JS1lHTnp2SzlGWkNoSUJLUGJjOUNkbVkvVjRJd2lE?=
 =?utf-8?B?ZGdNR3Y3elpKTWdQb0dyRHNHUXNyMnJrZCswYmFjdnh5L0Y1VHdpWnhJZDl0?=
 =?utf-8?B?aVVjUkpzdzA2blBaYnpLREloMkU2bWlCYkxGTm01eVAyK2pWY1AzOGRBL2FY?=
 =?utf-8?B?eTNpb2JpaXVQUSs5ZWRvcEtpOExvWlFvSWJNeFJkeER5Q3ovWXJkYmhMSUJj?=
 =?utf-8?B?eWFVTXczNUFMSHhDOWNjN3hKY09BL0hnV252R3hxU1lMUklkTFRsRFdYL2dU?=
 =?utf-8?B?emZ6SVRybW5DRGZuSytvaU5LWk5zc0p0eXlrODZnUTc1bTVHbTN5OU9vTG9B?=
 =?utf-8?B?TkFycG5yWjZCZnVreTFSVVFib3Y5ZFp2QjhTdkdoNjl2UG0xVS9iQVNRTmpJ?=
 =?utf-8?B?UDBPV29nQWZQL2x2L0gzcmt2WGdUTkJBMHd2em5tc3BjN01LUzFlVVdIc3V3?=
 =?utf-8?B?L0FPWGlDNnhGWnVjRndvbEJsSkNBWHNxWS8zM0dhS3g5UlJmemVHbWc3TGRr?=
 =?utf-8?B?bi9sRThLckVMQUNKczdGNHpKOEMxR3N2K1ZFODZwOFIyOXBMNFpIdEo4OXFI?=
 =?utf-8?B?M092d0JRd1IrMUgyY3VONHloR0tFL2pzWTdtRTg3MnczZmt6Yk9uVHNTcnc0?=
 =?utf-8?B?RFh3dVkyWG0wYzlwdWcwWTRzN1RyYjF4OW9ocWdtZXBQMHM3ZTlRZEEwcUdh?=
 =?utf-8?B?RWhuREpNQS93V1NTdGxEQ0VuOTFVREhEWi9zMmlkZ2l3V0l4bTlITzRrU0Fa?=
 =?utf-8?B?NjUyTWszZ1ZFS0pNd1A4YTcyY3hhbXE2SkszcktiSDY0N3JRVzdSaVhiME5i?=
 =?utf-8?B?VHhnMDRMbUl3aHc5SjVmWTJYaGczcGQ5bW9FYnA3bGpnYmZzaHYwZFpFaGlo?=
 =?utf-8?Q?GKlpecZxMpE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1d38c1-1a8f-4e68-d93e-08d995410637
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 09:47:56.1970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nirmodas@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182
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


On 10/22/21 11:44 AM, Christian König wrote:
> Am 22.10.21 um 11:32 schrieb Nirmoy Das:
>> Do not allow exported amdgpu_gtt_mgr_*() to accept
>> any ttm_resource_manager pointer. Also there is no need
>> to force other module to call a ttm function just to
>> eventually call gtt_mgr functions.
>>
>> v3: upcast mgr from ttm resopurce manager instead of
>> getting it from adev.
>> v2: pass adev's gtt_mgr instead of adev
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 23 ++++++++++-----------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 ++--
>>   4 files changed, 17 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 41ce86244144..2b53d86aebac 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4287,7 +4287,7 @@ static int amdgpu_device_reset_sriov(struct 
>> amdgpu_device *adev,
>>
>>       amdgpu_virt_init_data_exchange(adev);
>>       /* we need recover gart prior to run SMC/CP/SDMA resume */
>> - amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
>> +    amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>
>>       r = amdgpu_device_fw_loading(adev);
>>       if (r)
>> @@ -4604,7 +4604,7 @@ int amdgpu_do_asic_reset(struct list_head 
>> *device_list_handle,
>>                       amdgpu_inc_vram_lost(tmp_adev);
>>                   }
>>
>> -                r = 
>> amdgpu_gtt_mgr_recover(ttm_manager_type(&tmp_adev->mman.bdev, 
>> TTM_PL_TT));
>> +                r = amdgpu_gtt_mgr_recover(&tmp_adev->mman.gtt_mgr);
>>                   if (r)
>>                       goto out;
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> index c18f16b3be9c..62e14efa61fe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> @@ -77,10 +77,8 @@ static ssize_t 
>> amdgpu_mem_info_gtt_used_show(struct device *dev,
>>   {
>>       struct drm_device *ddev = dev_get_drvdata(dev);
>>       struct amdgpu_device *adev = drm_to_adev(ddev);
>> -    struct ttm_resource_manager *man;
>>
>> -    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>> -    return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(man));
>> +    return sysfs_emit(buf, "%llu\n", 
>> amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr));
>>   }
>>
>>   static DEVICE_ATTR(mem_info_gtt_total, S_IRUGO,
>> @@ -206,14 +204,15 @@ static void amdgpu_gtt_mgr_del(struct 
>> ttm_resource_manager *man,
>>   /**
>>    * amdgpu_gtt_mgr_usage - return usage of GTT domain
>>    *
>> - * @man: TTM memory type manager
>> + * @mgr: amdgpu_gtt_mgr pointer
>>    *
>>    * Return how many bytes are used in the GTT domain
>>    */
>> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
>> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr)
>>   {
>> -    struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
>> -    s64 result = man->size - atomic64_read(&mgr->available);
>> +    s64 result;
>> +
>> +    result = mgr->manager.size - atomic64_read(&mgr->available);
>>
>>       return (result > 0 ? result : 0) * PAGE_SIZE;
>>   }
>> @@ -221,16 +220,15 @@ uint64_t amdgpu_gtt_mgr_usage(struct 
>> ttm_resource_manager *man)
>>   /**
>>    * amdgpu_gtt_mgr_recover - re-init gart
>>    *
>> - * @man: TTM memory type manager
>> + * @mgr: amdgpu_gtt_mgr pointer
>>    *
>>    * Re-init the gart for each known BO in the GTT.
>>    */
>> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
>> +int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>>   {
>> -    struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
>> -    struct amdgpu_device *adev;
>>       struct amdgpu_gtt_node *node;
>>       struct drm_mm_node *mm_node;
>> +    struct amdgpu_device *adev;
>>       int r = 0;
>>
>>       adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
>> @@ -260,6 +258,7 @@ static void amdgpu_gtt_mgr_debug(struct 
>> ttm_resource_manager *man,
>>                    struct drm_printer *printer)
>>   {
>>       struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
>> +    struct amdgpu_device *adev = container_of(mgr, typeof(*adev), 
>> mman.gtt_mgr);
>
> I think that variable is now unused, isn't it?
>
> Apart from that looks good to me now.


Yes it is. I will remove it. Strangely GCC didn't complain.


Nirmoy


>
> Christian.
>
>>
>>       spin_lock(&mgr->lock);
>>       drm_mm_print(&mgr->mm, printer);
>> @@ -267,7 +266,7 @@ static void amdgpu_gtt_mgr_debug(struct 
>> ttm_resource_manager *man,
>>
>>       drm_printf(printer, "man size:%llu pages, gtt available:%lld 
>> pages, usage:%lluMB\n",
>>              man->size, (u64)atomic64_read(&mgr->available),
>> -           amdgpu_gtt_mgr_usage(man) >> 20);
>> +           amdgpu_gtt_mgr_usage(mgr) >> 20);
>>   }
>>
>>   static const struct ttm_resource_manager_func amdgpu_gtt_mgr_func = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index d2955ea4a62b..603ce32db5c5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -678,7 +678,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, 
>> void *data, struct drm_file *filp)
>>           ui64 = 
>> amdgpu_vram_mgr_vis_usage(ttm_manager_type(&adev->mman.bdev, 
>> TTM_PL_VRAM));
>>           return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>>       case AMDGPU_INFO_GTT_USAGE:
>> -        ui64 = 
>> amdgpu_gtt_mgr_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
>> +        ui64 = amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr);
>>           return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>>       case AMDGPU_INFO_GDS_CONFIG: {
>>           struct drm_amdgpu_info_gds gds_info;
>> @@ -738,7 +738,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, 
>> void *data, struct drm_file *filp)
>>           mem.gtt.usable_heap_size = mem.gtt.total_heap_size -
>>               atomic64_read(&adev->gart_pin_size);
>>           mem.gtt.heap_usage =
>> -            amdgpu_gtt_mgr_usage(gtt_man);
>> +            amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr);
>>           mem.gtt.max_allocation = mem.gtt.usable_heap_size * 3 / 4;
>>
>>           return copy_to_user(out, &mem,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 91a087f9dc7c..af1c4e414979 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -114,8 +114,8 @@ int amdgpu_vram_mgr_init(struct amdgpu_device 
>> *adev);
>>   void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>>
>>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man);
>> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man);
>> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr);
>> +int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>>
>>   uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>>
>> -- 
>> 2.32.0
>>
>
