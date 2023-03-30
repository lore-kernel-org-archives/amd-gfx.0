Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEFCC761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 13:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D8DC10EE40;
	Thu, 30 Mar 2023 13:44:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D788D10EE3A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 13:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1fE+9z50iDQv5M2z7GiJwpB9NUTyGOLCRPs/CE6BfU4tLCDPMCdP1Kpig8ICTkOGyUMsihFBoEkDaGEfzPhiVdE0TOQ8QVz6iBL/oeWzdTdJLCAL0Sz85TdcJdLxffsGQynVjEUEdQom0WITAbSnNQIh2FW/nnZfpTgvmLKVxsznK0R+kTpLKi/AFNWLZPtlgSWWcui3X9alIqAWIAU8wQzjPHj0DOhJWUhm3NUNogLWrrbqhJTFWNn9Qogd1+q+P6Z8ba620bHlaZZXQagvc/L2byere68waws7JYFMANfJhuFG9tXVUBkWyi0dPh4S1mGPMTFOL4zq/FuhuYAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x01C3UZoQHhH7yASUNaMAHr2ssK3DBA3eel9vVBV6cM=;
 b=hy32weOh7Fds/eS6oxBB4S0TUjBQ0wyqmWHhozxz5ch1T6Scyj1juMYTurF6tuqkVwxKzFJfrvXtL3gbIDiVCHOeqyROGXZQ93CXhzkS7yatpxKdRFQJ83XNNgh+73yD2VjWbyUhyuQ+GX43wkbBvZL6FfinWTrqR8NpA2fS8XyoOOmpiA3kMSQmE17/B0IwtjxfMNP5oteIsnRPDSsYhViVW9B4HaUFoSyXoU9aOAZI8c0A9qZTB21VJlTj6vWJXOtC5fgMP1HedNQdxbokFf9PKtyBTyrd24jyjQ9PZCrlRQH/T+Cvw7nFL/vIdttjOOhnosyP7wrfOGXku5y0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x01C3UZoQHhH7yASUNaMAHr2ssK3DBA3eel9vVBV6cM=;
 b=IoOY3bq7VgdKbIU0uV9Kav1rN+vckEON5xsn5POmS3Se8wNv1lJQGSppN/BEOaEwJW6W/RMtfefSG1xLjJUg7z6IkE7tXzZqhBuuOnjUwaC58FKnwtV6fDcUWQzxAChhQglZpTftFkfb1Cfdb2npwqQ4dn4CkX8aQ4ZlFfgtvvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 13:44:34 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 13:44:33 +0000
Message-ID: <0fab426b-cbfb-6abf-7922-e052528054d3@amd.com>
Date: Thu, 30 Mar 2023 09:44:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
From: Luben Tuikov <luben.tuikov@amd.com>
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-8-shashank.sharma@amd.com>
 <d03dba54-9f68-60ef-67ab-0d58245632d6@amd.com>
Subject: Re: [PATCH 07/16] drm/amdgpu: add helper to create doorbell pages
In-Reply-To: <d03dba54-9f68-60ef-67ab-0d58245632d6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0223.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::15) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SN7PR12MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: d99e20d4-7655-41b0-3887-08db3124e52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icBeHtAbTRkUFEL0k+4yn9P0hOVZ6ld7X4edXZItb7UDXGPZHXGaKuKjnyd98y8PAfwRU3mLBpjLBeDyZekzgD/v/vxRPbqeuvxfxweukXv+fv4FfmK4x4ASRmTN9sJMrp7FS4u/8yKPmiqXGoElNLnehQJSPa8cGr+fpoxbjOeubIyV8rd3TpmP0nPpQQMBxJhMTRnqc7xSBAaM4NH6PQoa1aI6BrA1vG7U0Si6tPX06ndAsynyZnXlrDopw5Zip/UZj4UrMOqaK6XkRbr5H3Lp6AIwSleDNpxMtp0KuiwU592HrVmFTNSMLzICz50nEVMAbPbjwK1OaMh7dFoFq7yD/uMdsllweZ9x38CBb9Ajq2Gl6VH36l5Vm3/8zJelOMgrOMF7b/nkPnhf/NfB07cYOERNQLRFxw3VVQIQ+2XvmyMcvJH++h/99vJyuNlsW+ZYCRmrTKzVYgS7/gctfLudZoyAuq/wE6rJf2Lpg6J61aVExkVQKhWuN9V82ITSazXTqIqBkpc7fg2oiF9Iw55t4O/KXHT1LUDyZOSbPUQrVLGNnMPoeugOmXyp77p78KqwCHv2Upwud3qAGsIUPaNg7TGeb7Q/Jwqr3yafJafYQnG8CC/apcVnH5/5ZJTr4on/oF76OOzbEaET4McTnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(6486002)(53546011)(6512007)(6506007)(26005)(31686004)(316002)(478600001)(186003)(54906003)(8676002)(66946007)(2616005)(66556008)(41300700001)(4326008)(44832011)(5660300002)(38100700002)(2906002)(8936002)(86362001)(66476007)(31696002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnEzZkVzQjNYVFlhaDVZaWJnTDV6eHBRZjY4bVVyT3FxWEFnTlUxSGhwSExT?=
 =?utf-8?B?dGFPMXJNeWRYdVVZNTlaTUNiYmJoeXRxRG8vTCtGQmNsVnkzTGNGRHVtL3d0?=
 =?utf-8?B?STgzS2dZTmxYclJjVHZRU3BzWDJBN0pHb1cxSWlKTllqWGhtTEo4R1J6YTkz?=
 =?utf-8?B?VDZ5Q1g5Z1cvNkJ2YnFWWHRqdEtEOWE3ZDVoZFB1aTZJYmZGTEVnL1k4Tnlo?=
 =?utf-8?B?MlZVcW12UVJLZ3ZZZ045S2c4MitwU2JJWkF4NUV5UjRLQWhOZ2FFYXNXaldu?=
 =?utf-8?B?ZkpTZmk1Y28zYWVrMlhxQnJISzlnVUVwVCs3OU0yNWpSNXp2T3NyLzVnSTdp?=
 =?utf-8?B?TWhjYUlSaXF6ZS82aktsQWRLdTRJQUkzYjdWZS9FZGRvUmd4M0hCZGYrTUJF?=
 =?utf-8?B?TUZpdDgzQkhWWTdkaVdUWmZQUTdVZGZxY2k3UXdROXNRNkhRL0lPSS9CcEVT?=
 =?utf-8?B?RWw4TmpGdHBRRFZWZEJPQjZJUGJ6RDVmb0J2dkY5aEIvejJFTUVRWC9Fck9W?=
 =?utf-8?B?aGlZbzJqZXNJNlNMNUE0alpWNlE3aDRlRHVTTlNrSi9wTWRCaGt3c3B1ekFW?=
 =?utf-8?B?aG5DaGZzMVJPakNCSWhDWEVnYWRwWDVqdXlGOU9OV0hnV3NvNi93bWRaaG1V?=
 =?utf-8?B?V0xoay9tZ2JpM1lpSGxyRTFMQ2ZZMnkydWpnb0lDQlhxUzBmZTh1UFNocFFF?=
 =?utf-8?B?YlRGVkNteEJjZFY5bkNJRFY1ZVZ0ODdtR0gzVEhCR250K1E5enl1eFFZV0M5?=
 =?utf-8?B?Zk1GOGhSRk5KMFFiNndTMFlyeWJLYThjbVVoWm1nUDJUcWJxMVo3a1ovSEdu?=
 =?utf-8?B?Q2dQbXlQSzJqMVpOOGVjRVAyNTlPUkNGa1JyeVQ0M2NlTWNDZCtNcVlGKzdP?=
 =?utf-8?B?YTViUlRSZFpaaGM0YXg1OUJnUnlnSDVyeDlSQlNJcEd6V0p1SDFYem1iZTZM?=
 =?utf-8?B?Y3diYnBUOEZJWlZrZzdURS9nZkk2WmhmQlFOWjVIWFY5NlZISm5kK2FWUE4v?=
 =?utf-8?B?ckt6b3lyVzNjOFF1cWRPcjE1Z0FXRXpSYnE4czVzZk5nYW05UVJNRXkxOTRU?=
 =?utf-8?B?WE1nQ1ZQeDVWeGZwdUFCVzlWY2F3a1l3eTdJbUVScnNzeGE3MUtoZi9rNFhw?=
 =?utf-8?B?V1pydkdQcWQ4Z3F1U2syQzdQMzJOWUlzc1dhUk9WRzJ1allIaHd4NHhUTU9T?=
 =?utf-8?B?amVzTGVWZm9MYWlkNWU5RVI1SlBjNklyV3pqMExsVDdNL3UzM3hGSk5JMUlM?=
 =?utf-8?B?Ujh0QlFLZU55cUVmNXhmTUQ3YkQ4Tzc5Znh4c2IzK21pbmhHV0UyeUw2dG5F?=
 =?utf-8?B?RnNGK1VJTHAzQ2ZDNkswRWVvbmhzMWQzWDlGZDE2R2NBTUplODNIaHY1dXVE?=
 =?utf-8?B?MGgwUUFjZ3RHeHYwSmNCcE5NYVNiVTdwVStiOHI4UmFnMm55S2lpcllmaWVY?=
 =?utf-8?B?SFdDY2N6VG5XcG1YeDRwMHdYN0o4elJ0QU4vVGxyWGlrbHA3L0w1TVczbUJU?=
 =?utf-8?B?RUF5dmpsVGtEOTV4bVpIMTFIMjUzeTYzZUVjN1A3VkYyK3FKc2RRRFl3ZWk5?=
 =?utf-8?B?SXdKSkxwOFlYK1JKbGsyQXNOakdPT21xUDkyMHdXY2UxZy9HRUlIYnExMkJk?=
 =?utf-8?B?UjhXT3NFY2pnVG1GdnY4dlQ1WGlGV00xUDhwci9vL3dFeCt5V1VnbnVpdXdW?=
 =?utf-8?B?SWsvbkNmcVQ1aFpGRm05S05KMDRlQS96RnVGRnBJRjc3SjlPM0NvdkpER0ZI?=
 =?utf-8?B?bWowQ1hDczFsL1ZhcUw4QmhwOVdoY1hnS1F2REFEUGh4SWlNNWtZVHVHa0VH?=
 =?utf-8?B?Ym1qRDJ2Uy83WFpaWUtnenNWanRKQmV6OEUxclZuenFySDJWTzI5b0pkeDRs?=
 =?utf-8?B?R1RzYWxoRnNSN1YyRFRwRVNGUHV0cWNMbTc2T1dyR2xuWkJMdjdIamNwblZF?=
 =?utf-8?B?Z3hIbms2blZDUWlzYXFTSXpsTk9YTHNwOUhmdWFzS1NQV203Zy9rSXk0NGxn?=
 =?utf-8?B?ZXBrb0JlWks4azY5dTRYZ3MwUHNvaTI3TmdrK0lJbTBvMDRQWk1Pc01SanRq?=
 =?utf-8?B?QWpHblk1aUc4SmlqL0JmanB6UUJaYzRMSmszZnB1ZmE5VDVNRFlNZTVmQ1Vk?=
 =?utf-8?Q?Wo501mjHnwjVX5yzk3ZVE0MOQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99e20d4-7655-41b0-3887-08db3124e52b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:44:33.8193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdfgMuMOLSILCT9Xg7l5DCFSiRkvYfYF/8YcGv3uPeR9Ta03+7fkPGGVCaaGQzLd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-30 09:42, Luben Tuikov wrote:
> On 2023-03-29 11:47, Shashank Sharma wrote:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This patch adds helper functions to create and free doorbell
>> pages for kernel objects.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 41 ++++++++++++++++
>>  .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 49 +++++++++++++++++++
>>  2 files changed, 90 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> index f9c3b77bf65d..6581b78fe438 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> @@ -27,6 +27,24 @@
>>  /*
>>   * GPU doorbell structures, functions & helpers
>>   */
>> +
>> +/* Structure to hold doorbell pages from PCI doorbell BAR */
>> +struct amdgpu_doorbell_obj {
> 
> In the comment you say "Structure to hold ...";
> it is a C structure, but then in the name of a function we see "obj".

I mean here " in the name of the structure we see ..."

Regards,
Luben

> (Object is something which is defined like in memory, i.e. it exists, not
> something which is only declared.)
> This is just a declaration of a structure, not an object per se.
> I'd call it "struct amdgpu_doorbell_struct" or just "struct amdgpu_doorbell".
> 
> Then in the definition, you can call it an object/objects, if you'd like,
> like "struct amdgpu_doorbell *doorb_object[];" then you can say
> "db = doorb_object[i]";
> 
> Regards,
> Luben
> 
>> +	struct amdgpu_bo *bo;
>> +	uint64_t gpu_addr;
>> +	uint32_t *cpu_addr;
>> +	uint32_t size;
>> +
>> +	/* First index in this object */
>> +	uint32_t start;
>> +
>> +	/* Last index in this object */
>> +	uint32_t end;
>> +
>> +	/* bitmap for dynamic doorbell allocation from this object */
>> +	unsigned long *doorbell_bitmap;
>> +};
>> +
>>  struct amdgpu_doorbell {
>>  	/* doorbell mmio */
>>  	resource_size_t		base;
>> @@ -328,6 +346,29 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev);
>>   */
>>  void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
>>  
>> +/**
>> + * amdgpu_doorbell_free_page - Free a doorbell page
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_age: previously allocated doobell page details
>> + *
>> + */
>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>> +				struct amdgpu_doorbell_obj *db_obj);
>> +
>> +/**
>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_age: doobell page structure to fill details with
>> + *
>> + * returns 0 on success, else error number
>> + */
>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>> +				struct amdgpu_doorbell_obj *db_obj);
>> +
>>  #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>  #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>  #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> index 1aea92363fd3..8be15b82b545 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>> @@ -111,6 +111,55 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>  	}
>>  }
>>  
>> +/**
>> + * amdgpu_doorbell_free_page - Free a doorbell page
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_age: previously allocated doobell page details
>> + *
>> + */
>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>> +					struct amdgpu_doorbell_obj *db_obj)
>> +{
>> +	amdgpu_bo_free_kernel(&db_obj->bo,
>> +			      &db_obj->gpu_addr,
>> +			      (void **)&db_obj->cpu_addr);
>> +
>> +}
>> +
>> +/**
>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * @db_age: doobell page structure to fill details with
>> + *
>> + * returns 0 on success, else error number
>> + */
>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>> +				struct amdgpu_doorbell_obj *db_obj)
>> +{
>> +	int r;
>> +
>> +	db_obj->size = ALIGN(db_obj->size, PAGE_SIZE);
>> +
>> +	r = amdgpu_bo_create_kernel(adev,
>> +				    db_obj->size,
>> +				    PAGE_SIZE,
>> +				    AMDGPU_GEM_DOMAIN_DOORBELL,
>> +				    &db_obj->bo,
>> +				    &db_obj->gpu_addr,
>> +				    (void **)&db_obj->cpu_addr);
>> +
>> +	if (r) {
>> +		DRM_ERROR("Failed to create doorbell BO, err=%d\n", r);
>> +		return r;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * GPU doorbell aperture helpers function.
>>   */
> 

