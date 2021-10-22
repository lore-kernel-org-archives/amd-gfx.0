Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450F7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 12:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFFF60EE2
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 12:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0DFFF60EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 758B76ED34;
	Fri, 22 Oct 2021 12:32:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F086ED34
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 12:32:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWqyMnd/KEH6EEupHkdlg7qLEKYs0bJZAApMdhV3syHid54BG/lwk9Sl2o7BI+q/pWQ6m5/ppwjBndVEq0IKLUjBW8q9DiU3dCAQP9FlNR7NfVE5GzAPrJt8DAEYLS9AY8yZ+H8o9zCQ0oXtK6PwoNpkzJcZoRC0o7VWMywbeswB6telajXRRgxEmTWgKVWeEoFW97vpbrxz9hqn0Ud1wpZmkU2X9R9YwHMuuqnpdimE4IN1J7bSCHvDIwyQ7xJ6piR5VN+Fv0FU9CQJZUMJOgJK4Wkg12AQlneko46pMrdkgvzvqwzwYkBD9clFO1Jfv9B8mwhfLD0n72zQKRvSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAFGsw3xDYy0R+FQIvQTwKisI8gdmzUai9t26/CsF/I=;
 b=W5Yju/yXPvYcurhsZAEOLmfaFgf2pEpT4ocbV827LzCUg6loFQXtz4h3eGUniv7i59sWUv6rhm10EE2UH6NdEBNc6KNbGuxjOhWMcBgPlElC/AJkrsoQ9G5PNDpzksDc8UmmZckEtS+n3NRl7B2C+s4Vdc+Cfcp+TV6LDkPQER2MYF3RsZsjN+Y70xtPogAXhD0ItygcvTle0e6Dp+LWrX8TKE1kGvjEgY0TYroKhaW/eSBETMJnBCc9Re4wi2T08pr2lNPn+rRJUgNilfBet+jbsj+7UUaUE0Ujvr7tGFxr2xgrCVeivQQL2RZPuiLMve5jTAGdUGYI085CmbMZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAFGsw3xDYy0R+FQIvQTwKisI8gdmzUai9t26/CsF/I=;
 b=jBoY9nDa5j+qcIcZevBnb8BqdOAdwRtUMyFKKU+Ix6MHeVW15pK95pXg5wiZGbEIH4JJpoUDX4j/ZIJycyJ0hCg++Pn3Qy8CJ+YGpL8+j+Krgu2Rg8JUz9Y2AoBW+wzJR38xiunCcubI2cR8iy02rKL3qAjio8XAHAaFzkWmatY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 12:32:01 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 12:32:01 +0000
Message-ID: <ad2a8e1c-50f3-5697-ce46-b5a33822be16@amd.com>
Date: Fri, 22 Oct 2021 14:31:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 1/3] drm/amdgpu: do not pass ttm_resource_manager to
 gtt_mgr
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, andrey.grodzovsky@amd.com, lijo.lazar@amd.com
References: <20211022105423.69769-1-nirmoy.das@amd.com>
 <3afc42fd-0062-9e8d-1690-07be82afb9ad@gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <3afc42fd-0062-9e8d-1690-07be82afb9ad@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0701CA0022.eurprd07.prod.outlook.com
 (2603:10a6:203:51::32) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (217.86.122.144) by
 AM5PR0701CA0022.eurprd07.prod.outlook.com (2603:10a6:203:51::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.8 via Frontend
 Transport; Fri, 22 Oct 2021 12:31:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4acf699-714a-4347-fdcd-08d99557f23d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5264:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5264D232E2A59C07293724568B809@DM4PR12MB5264.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7oIr6td9E6FPzQd6wWt5skZYjB/1hjj1ms0uNhECWuoNMr8n2iFZJRH/t0MyoeZn2A91YnP3A+8W9kYE3MBUDbpKDNICGYOqG6DqENQIr2FWcoQw2byF357SkuB+AIhdBUxz7crDodLvp2XwFKJJjZ6WGwEFqtJ4pdWpDRJ1XfMTYg1W6f+SiZ5C3Nb7X60XMy+/A67UvM5fLlxCxtKt6JB9nruw190FC/C0fPE5RMcuuXoc1OTeHpqfMWgoAtKl0GV/TlTfV0WxIi7WVZ8MvWK426v0auP1mlfwT9FWfQv9bdyDCOO/IzRS7RE27NJKPmcHI447Kva573Z1iSc+scaynAO96EtvtGmXkT2RK4WP78fPaspBALhGcP/7a9/+CxPPND03QhzVlWQPddA5DYLcb/0FrxSuTH9j3KbaNiBgQU+yHkYKbya0ne/xmbM/vMfjNd8VpwurI8JAts+b6qlq2lOWhexkKcwBd+9YWMzi+CSR5SogJVC3zcEL1NBYugvdYMQGcEDc4UCaABTcvnQrSmjmsvjajEBuD0R6a4Gq3H/Pipst5Brikb7+sMQ6J4Yy+59cnvdD4PXDH+Z/SkzyngODzzi4hB7oGHaeOwzRiaQ74bQBmdNv+e9uBE5EEEcn+BeJa0oH5BLBEgpnQFM6RNbKDL5DPp8wpvSRl1T4lev2bRmi/cu8duSkf4qkciLIszRlGqs6lnEeUc8OnsMzKif/dV9oOsC2BH7XR1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66476007)(66946007)(36756003)(16576012)(5660300002)(316002)(66574015)(31696002)(2616005)(26005)(31686004)(2906002)(86362001)(4326008)(956004)(38100700002)(8936002)(8676002)(6666004)(83380400001)(508600001)(53546011)(6486002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWhtMmYxa0wxT3FSZnhrS0NXUS8xTENINndWaFczc2o1bWFOZStwcGs4d3R2?=
 =?utf-8?B?dUhILzVXeFFISXpBd3pXOVgrdllheXlMdG5ZTUNySzhIQ0ZVYlN6ek1YV3Y2?=
 =?utf-8?B?VDhtWEdia0hrNGJ5bHdRKzF0L0VzcTVCTG1DVzlHTVhiUjZEZTRJRjYxVHVt?=
 =?utf-8?B?MWtYaFhmcXVDVHBncWJ6QldmZS9GZ2Q3blU1ckNqOGJuTis1dWgrOFJQZU1W?=
 =?utf-8?B?MDRqd1ovcThxZW5tV2kzdEVZckRpZUN5aVZTN3lyUnEzNlRpU1NlWEFrVTUv?=
 =?utf-8?B?Zks1UHpQblNmNXlZTENRbktnaHNlRGsyNXJiNi91LzZTWGRJZm45K21mUnM1?=
 =?utf-8?B?WGI2MHFSM0EyQkhCd0g3ZEFwcys0TXV1WVBwOTljWThWdDhiOVJmYTdrc2Mx?=
 =?utf-8?B?c0oxbUFmeUNrWmIyMFVvcWx3S1NPNmxSdjNid0RyNXpBS1orQlRGdUdaR2pR?=
 =?utf-8?B?NThCRlhJd2JiUmNCSExxS21SV24zT2hiWXpySHN1c08xdUFKYkVpT3l0a0Q4?=
 =?utf-8?B?MjhrVmZmRk9PWStBVmZ6SFg3Nko1VXNidmd5TzZsTDFzTEl4VE1HbFZBYnJj?=
 =?utf-8?B?L09SQkdIOGJHTDhHRk93aFdwd0FpcURIcEZwNDBqb3lvYTVTM3Q2WFBwZXI2?=
 =?utf-8?B?MUdpRjRweFlFZ1RRQzBPS1RoNndrcE5pVXNwNlBlK0tvc3BGOGc1Y3ZBTHBI?=
 =?utf-8?B?cmwyTU9tU3VtUEJ5ZTVTdWNIdmNyYnlXRVBtUUZ4d2pJVGQ3ckJZdllzTUZW?=
 =?utf-8?B?Nk1yaGtBSksxb1J3Y2wxUjRvUURDWkpJNkpaMDd5M1BpWkpRY1R4cHo2Wity?=
 =?utf-8?B?TTZLSmtVTnJxbFpoR2Q5Zy9QWVBGK0w1ZitPeUY3SmRMaldxNzZzc0pqUTJC?=
 =?utf-8?B?cFdrdXNtbzFtdHRJOGtzWUlXNENlUTUyR3pnNXd0WnR4RGM3WmIzRkFTblVT?=
 =?utf-8?B?cTA3cTVlTjFkYStCaFpaVk1tRER6TDJVRnVyeUxCcDBCdnBIT0liTUNqYWJj?=
 =?utf-8?B?WUZhU1VaTWNyWE5uZm5Ca0lDQ2pzMmQ3Q3d1T1ZSNmpaaGV0ckF6SUFqbW5t?=
 =?utf-8?B?MExJR09mKzdnaXVXeFNQUlg4ekxHNjhGNnpBemdrOUgxYVhPc2dTVGc2aUZ3?=
 =?utf-8?B?disrV2FkNVF1Yk9PMTZ3eWVtZzVEaVRON2xWc3dKR1pBaEt3dDdCNGtnQVgw?=
 =?utf-8?B?alNnTThnQngvOHMyYXFXd2p5M0ZRNzZuZitaSU9pbVU1Rnd5aUU5R21sZzhl?=
 =?utf-8?B?VFcxbm1zaFFUbDVJV3F4NmI5UGdqN3RwVHRHS0ZucHJFOEZKblIzOUtjZk9K?=
 =?utf-8?B?YnI0NWZWVnQzODR2Mm85eVJTYVRQNTlRNGlmWnlSVUFpWHRlTEEwWXJoQkJX?=
 =?utf-8?B?anRUZE1wOElCWnorMEpvZlh5d2pqcXhhTm1YYWl1V1FNa2d1N3VkY0VFTitN?=
 =?utf-8?B?ay9tSTJtbW01Ym1Sb2g4Tk9ZdWNXbi9GUzZyYXhYaUpOMk50Q3dCM2xrWUtZ?=
 =?utf-8?B?em8yZ2tnNXI5b2R2YWQvSGhlckdXczY3K3JrS3UxcVlQREpsQkg4T0pwK3A3?=
 =?utf-8?B?NXN0WlRYYStQbXlCcFVjN0gxQWJ5T0ZUdDBNTnlHdVNrcVpGUUtBSHhyNkRn?=
 =?utf-8?B?TnB6cThoamZQcS9MeUovVWd2S0l4enlnR0hMOVhaN0FxSzdhSDNOMG5aUWRh?=
 =?utf-8?B?UFMxeDgrNlBHMXdrMTBTMmp2cWwveEF5RHVtRTdweXd6ZzQ5MUhFUHc1eXZh?=
 =?utf-8?B?VUNKVnNWOXRwcW5HRTEvVVRtVUJsaHRvM1ZCdy9Id3lLSXNDN3RHYnU2aGt6?=
 =?utf-8?B?M0hKYmkwQzVJdkd4eXVNVkwrRnJmbFJwVGtRKzJNNG9Dcnd6ZHg3dVFRUlBT?=
 =?utf-8?B?TnVtUExncnZ5V1UvRm9mTXBJYUl2VndkMGoyQnBKenN4ZWx3VkFoRW01b0U2?=
 =?utf-8?Q?/VP2VGtFMRw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4acf699-714a-4347-fdcd-08d99557f23d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 12:32:01.3401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nirmodas@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
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


On 10/22/2021 1:46 PM, Christian König wrote:
> Reviewed-by: Christian König <christian.koenig@amd.com> for the entire 
> series.
>
> But please keep in mind that this here needs extensive testing.


I will do multiple round of test again on gfx7-10 cards and gfx9 APU 
that I have but I don't have gfx6 and sriov cards to test.


Regards,

Nirmoy

>
> Thanks,
> Christian.
>
> Am 22.10.21 um 12:54 schrieb Nirmoy Das:
>> Do not allow exported amdgpu_gtt_mgr_*() to accept
>> any ttm_resource_manager pointer. Also there is no need
>> to force other module to call a ttm function just to
>> eventually call gtt_mgr functions.
>>
>> v4: remove unused adev.
>> v3: upcast mgr from ttm resopurce manager instead of
>> getting it from adev.
>> v2: pass adev's gtt_mgr instead of adev.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 22 ++++++++++-----------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  4 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 ++--
>>   4 files changed, 16 insertions(+), 18 deletions(-)
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
>> index c18f16b3be9c..9151950e0cc3 100644
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
>> @@ -267,7 +265,7 @@ static void amdgpu_gtt_mgr_debug(struct 
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
