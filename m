Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB789C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 14:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B50AE61107
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 14:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B50AE61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 616FC6ED7E;
	Thu, 23 Sep 2021 14:52:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C41066ED7E
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 14:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSpUzcstPi05ljtS8gyZl2afWw/ga0N50gYynpjfA9UaFLJlNMRq+1DALkewP6sGyBubTCDPf6Gcsu6W6LPTnmDQpcOM1uUCBNWrzk0Qx7fNnyW2YwiZNCPmBvGofwZCU0FfmxHRFk16xwvh6uMG8Yv0idshFvqMSCZSEhkyxxxqVI8T6lKSx7R2AKcY5qi3FB+9cCeKbIi98x5eKtL7Zt7PgeYY5YMYsd7nbTxiCh01XHveyWvuo8QSFttknYrEaEIMatUMTxczJT2NhZg/kjfvNzq05HbvWARIzcR0Xr12cYfn+H2OlJmWbd+1H6IsuFJsC1I+2Lu0+Hr0r7hlbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=9EENtymzXgkHT5VxV2kB8SuFZrMJ7CyiUmWTy/3oodQ=;
 b=VGh3mNs9pb2LQz6pDqIedUTRsqfvvQYdQup32Q9MxpmHeskMQJ1N4ho+0lDJ+Xb0As74KSt2GHgLvqkWx7YQUiobIZGWnyscDrkUHAeGve3iRORdQJQXFQt2Vb27JYhwK1mLudTceVyJr1/7lFt5IXi4Hkac1zpFuu0MMg/GXjQ4My5cDSZAuzJvD6E1IheE9QC8v66f/VotHAytHvGvzNDduUtw/RK9/SX+8mLfRFJ20bSRrzm5rL4odZOGEP6FEPG3tD8yxLTTorjz3r5B5uCtzymt52q7S1U5M/WSMNTHYB/LMoaAoxMRtV9bnkcN2iEtjhKlz45mgOBUHpAQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EENtymzXgkHT5VxV2kB8SuFZrMJ7CyiUmWTy/3oodQ=;
 b=mBvYCyWil61rDctF964zShqJzg8rkpWAZxc9b8GTfUeE/KQ8MkvwPhI7w5Mr7xPADrAYBmdN7dRdeJs9WvrfT7SSmhCGW1AbjpCS6xsJNjj+Sp/UrvVVjKJNLpZGCmdTU2mfT4NyQarXarpFYge3/HjeDIxBAdlgKzaQzp882Uw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2449.namprd12.prod.outlook.com (2603:10b6:207:40::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 14:52:35 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 14:52:35 +0000
Subject: Re: [PATCH] drm/kfd: fix ttm_bo_release warning
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
References: <20210923094405.144613-1-lang.yu@amd.com>
 <063d904f-4083-f5db-b3d0-eb4e080b055f@amd.com>
 <DM6PR12MB4250123CDF0A1F69AD1C1131FBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
 <dc3b075f-70f9-6724-9b00-3e00afa922fa@amd.com>
 <DM6PR12MB42507FAA5B24CB49218517ECFBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <066e138e-3eab-8c4c-04b9-6c7b5d6a4acc@amd.com>
Date: Thu, 23 Sep 2021 16:52:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB42507FAA5B24CB49218517ECFBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0202CA0008.eurprd02.prod.outlook.com
 (2603:10a6:200:89::18) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:a75a:1e7e:91fd:64c3]
 (2a02:908:1252:fb60:a75a:1e7e:91fd:64c3) by
 AM4PR0202CA0008.eurprd02.prod.outlook.com (2603:10a6:200:89::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 14:52:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08f2f577-8f92-4fbd-939c-08d97ea1c79d
X-MS-TrafficTypeDiagnostic: BL0PR12MB2449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2449FD23CBAA5D0CA3AFC28583A39@BL0PR12MB2449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyZ8Gxes1o5+9NTx6H01qRJFG2vfHTKObigkTxjEFrIMBbLuCG9N3muTxD1Ny+9qtZhFAotSBPUu0WYUjZpUpmL0G1rwnpHYpjYvy8+y3KZzP13/UJTRnnL7NZcwzLEpLQAGd4lkrPF5iXfgAg3LVOYV2i+59s/pPnDaxyzY/dH0ieKOcr7LLViZet4QIicZgW7utZHQTITdwPWZnY4GWZiUKdnOaloky5rnVXkh3di5QuTDBsaracAi4aJu+Y9EN+muqOS8mOi4svQAWUaykdK5tLHDoCILpfz410yDtPYl/WjG7gQXfojImQJ9Lsxza6eYibkGV8zp4QzANEzKWZF9+GVOdqSA//78f/aDQnYZL6f7ipvOEBg0UaVO88idgKdNVn23grVpROZKQosiTexR4b/8phwYEwxScxOMw5deDMeudqbjnQnxE/uYOF2JOHo6krb94sU2+SbPYZp3Uw1TQNbUmo57DmdM+AO9k34k9/GugjgzaB7/UweTO1H1Jftt7xDSRXPHeDsMukS+S+cRdLeiXClNiFNCrDCw7JMhhFz+F5Ki2coemYeQZRW4xGYqQW7h71Qytq/US5/6oQDF0VEptOSlr5EeX0QqVmNgGDMKh6OM9RJBARogJM+v0L0gfPvcnL+p963XaAIpgRL/H4BIgzqgWKATwEFa9PpSfkKiAVA9u0GfXS3GsrIuGLD47FIZ1f8sxYMPGiolMTY1OikHmQEawMBZCXjfvmxG4d6fg3xU9K/QpTcF7WGF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(38100700002)(31686004)(54906003)(2616005)(316002)(2906002)(186003)(5660300002)(83380400001)(508600001)(8936002)(110136005)(4326008)(6486002)(86362001)(53546011)(66556008)(66476007)(36756003)(8676002)(6666004)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXVCZzlDT1NHemNVdExhUTMwK2FqVHNab085dy91MXRkNENheHZja2JVb3Fp?=
 =?utf-8?B?SEVFRmJ2RTdtUzVET2IydDZlNG5jT2VsUTdsMDUxdmwwWDFKNWRJQnZ0N1Bk?=
 =?utf-8?B?REhlSHNVRE4yNlkzNmV5akRhbkZjbGFHaklubGFJT1J6aXlkNDc2bDg0SzZI?=
 =?utf-8?B?dEJVUWh6M0tBNklMR01TVkFVTGFZNTlnMW5aVXpJZUVtRzNmSFYyNTZPeDdr?=
 =?utf-8?B?ajJxNTJocTlMVEFEK1hSVWZvWm9CZ3FNeUVhMm0reERJVW1WNUlsaExFeWJG?=
 =?utf-8?B?cWlzRXlHM2ErQS9IV0lzd2o5ajUrWUNOdDB5TDA3bHppQklNS0dkc0htQllw?=
 =?utf-8?B?VHJ0Z3QxSUpKWCtMQmdaTlMvNnArRFVaKzBNWkpKeWpoSzRQN3RYaFFMOTZu?=
 =?utf-8?B?eVNQVStXamhJRktRR044SlRSMVovNzErVm1BOVNsU04wSENpWElWdVdhWDJY?=
 =?utf-8?B?NlFPQWV2RXlOUUNlZlhYNGtQd0lwQUdzZ2F2MjFrSzBpUGdjTEVyMU9lVjdU?=
 =?utf-8?B?QXFEYk1OTXp3TkRQUkJDOHdzZE9RUy9lSnFvc1N0MlV5RFdEeDI5ditrd0sy?=
 =?utf-8?B?eVpsdUE2NkJocHVIR3FoT0RkcTNwa0FmODVMMlMxM2gyUUZBM3VSa0RndnYr?=
 =?utf-8?B?eUI0b2hKQXk3cGFpeUtlR0hTUGM4WUdDR2VUcDBHdlVhQXduK3I5K0xEdGJL?=
 =?utf-8?B?MEdRaUJXb1hsOUNHOEw4K3J2d0h5UlFvaFFFS0ZUOHBMcVVpSjVjRG94WGdv?=
 =?utf-8?B?eTlzV0xaeWpHTGZKOGlWeWNxZ250T3h4R3FKbXBJeXduN2FFbG13alNEWmNM?=
 =?utf-8?B?MjA4TWFLSlY5cWR6a3EwRFl2U0FBVzFPbHhIMitkZFVWVURGUERhOFhFWi9Q?=
 =?utf-8?B?bHgzMXFYR0ZXSnlLb09NczlrT3NJM1cyNTZpWTVPNlJzeER5b1NVSkNVOFk1?=
 =?utf-8?B?ZmQrQjQ5RzFqZjlGVTRRbzVLSTQrWUFQMy9JMGpGU01QS2dHKzJqK0FyYUFJ?=
 =?utf-8?B?alBKUEppK3JxWXlJZUxEZnhJTnR1eVFzcmV5TS9FSGkrTGUvcTIyQU4vZ1JU?=
 =?utf-8?B?dGpuL01zK0prTWNjOXd6MWdmZURBdW5Qa1h5akliRU1nYXRFM1NVMlZnVEsx?=
 =?utf-8?B?c09qVDZhRUQ3NThBOEdvd3UycmRzQ1NjdkpPdG5zakhNaklJTTQ1NmNhbk44?=
 =?utf-8?B?eEV5QVZBa204ZTc1Q3h4bUJ1U0RkQjRFNlNjUDQxbVRLTENOVmE4a0VsV3FE?=
 =?utf-8?B?VjJZTTgrRXV0d3Y0MzlXSndQZm1tZENQTi9YVGFaSXljNm9TTmdYVVBLWkxp?=
 =?utf-8?B?UG9uMFdidW1nNnpSRWd6bFNib09vU2ZVVTZBRTVNaEREYzJxT2QvQml6YUFi?=
 =?utf-8?B?L3k2bU9hblRCZHU2SXJtK3ViajlVWVJtQjBENnEydHFOdTAwZnQ1VGNWZU1O?=
 =?utf-8?B?dERTWDVkN0IzWkVRekRvUTlac1crMGVoUDAxVncxTnMvVWtJQU5aNmEvdDlO?=
 =?utf-8?B?NDQ1d2ZCOUl3YUFRdWRzaTR6TnRzang3akhvZ1hsN2NOdFZ5SDRsaEI4djZl?=
 =?utf-8?B?M3BHN0lwRGNSRWFKMm9vSWc0OGhJMTAwUWdPb3VadzZMOUxGaGV2RkpXL2o2?=
 =?utf-8?B?dWY1d0crWDVlWlhJRjNtdXJhbTZrbENmK2kwNEFpdkhxeWxsT204d2hRUWVB?=
 =?utf-8?B?ajBHeFpQQ2hwU1FORDRHTFdXZGhuZ0IxNGYrMzRiSnZ2RWt3akZ4NVRHbmFj?=
 =?utf-8?B?SU9nczBwZUlLcXkzZFUwYnJidjJPelY5a2ZBMHNkcEhUdmQ3VTV4L25HRG0z?=
 =?utf-8?B?N1BWSjIwQkU0UTVMcnR6OEFRVTcxNjk0aHhVbG9Sa1l4V3FSdlRLTDVIVElt?=
 =?utf-8?Q?gXSz0cDVtjdO2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f2f577-8f92-4fbd-939c-08d97ea1c79d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 14:52:35.5452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxFRi8bUelcOklElto7YSyT29RewpFpAtYM4cOo5oFYi93eniXEKCqScRwQx4N7S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2449
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

Am 23.09.21 um 16:24 schrieb Yu, Lang:
> [AMD Official Use Only]
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, September 23, 2021 8:24 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Christian K nig
>> <C3B6christian.koenig@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>> Subject: Re: [PATCH] drm/kfd: fix ttm_bo_release warning
>>
>> Am 23.09.21 um 14:09 schrieb Yu, Lang:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Thursday, September 23, 2021 7:40 PM
>>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Christian K nig
>>>> <C3B6christian.koenig@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>>>> Subject: Re: [PATCH] drm/kfd: fix ttm_bo_release warning
>>>>
>>>>
>>>>
>>>> Am 23.09.21 um 11:44 schrieb Lang Yu:
>>>>> If a BO is pinned, unpin it before freeing it.
>>>>>
>>>>> Call Trace:
>>>>> 	ttm_bo_put+0x30/0x50 [ttm]
>>>>> 	amdgpu_bo_unref+0x1e/0x30 [amdgpu]
>>>>> 	amdgpu_gem_object_free+0x34/0x50 [amdgpu]
>>>>> 	drm_gem_object_free+0x1d/0x30 [drm]
>>>>> 	amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x31f/0x3a0 [amdgpu]
>>>>> 	kfd_process_device_free_bos+0xa3/0xf0 [amdgpu]
>>>>> 	kfd_process_wq_release+0x224/0x2e0 [amdgpu]
>>>>> 	process_one_work+0x220/0x3c0
>>>>> 	worker_thread+0x4d/0x3f0
>>>>> 	kthread+0x114/0x150
>>>>> 	process_one_work+0x3c0/0x3c0
>>>>> 	kthread_park+0x90/0x90
>>>>> 	ret_from_fork+0x22/0x30
>>>>>
>>>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +++
>>>>>     1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> index 2d6b2d77b738..7e693b064072 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> @@ -1567,6 +1567,9 @@ int
>> amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>>>     	pr_debug("Release VA 0x%llx - 0x%llx\n", mem->va,
>>>>>     		mem->va + bo_size * (1 + mem->aql_queue));
>>>>>
>>>>> +	if (mem->bo->tbo.pin_count)
>>>>> +		amdgpu_bo_unpin(mem->bo);
>>>>> +
>>>> NAK, using mem->bo->tbo.pin_count like this is illegal.
>>> I didn't  get your point. I referred to function-"void
>>> amdgpu_bo_unpin(struct amdgpu_bo *bo)", which uses it like this.
>> What amdgpu_bo_unpin() does is the following:
>>
>>          ttm_bo_unpin(&bo->tbo);
>>          if (bo->tbo.pin_count)
>>                  return;
>> ....
>>
>> In other words we take further actions based on if the buffer us is still pinned or
>> not after an unpin operation.
>>
>> What you try to do here is unpinning the BO when it is pinned independent if
>> somebody else or our code has pinned it before.
> Hi Christian,
>
> Thanks for your explanation and advice. I got your point.
> Actually, these BOs are allocated and pinned during a kfd process lifecycle.
> I will try to add a flag into struct kgd_mem to indicate which BO is pined
> and should be unpinned. Which will make amdgpu_bo_pin/amdgpu_bo_unpin
> calls balanced. Thanks!

That isn't to much better. The real solution would be to unpin them when 
the kfd process is destroyed.

Regards,
Christian.

>
> Regards,
> Lang
>> That can lead to all kind of problems and is clearly illegal.
>>
>>>> Where was the BO pinned in the first place?
>>> I found two places:
>>>
>>> 	ret = kfd_process_alloc_gpuvm(pdd, qpd->ib_base, PAGE_SIZE, flags,
>>> 				      &kaddr);
>>>
>>> 	ret = kfd_process_alloc_gpuvm(pdd, qpd->cwsr_base,
>>> 				      KFD_CWSR_TBA_TMA_SIZE, flags, &kaddr);
>> Well then you need to figure out where that memory is freed again and place the
>> unpin appropriately.
>>
>> General rule of thumb is that calls to amdgpu_bo_pin/amdgpu_bo_unpin should
>> be balanced.
>>
>> Regards,
>> Christian.
>>
>>> Regards,
>>> Lang
>>>
>>>> Christian.
>>>>
>>>>>     	ret = unreserve_bo_and_vms(&ctx, false, false);
>>>>>
>>>>>     	/* Remove from VM internal data structures */

