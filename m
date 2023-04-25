Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2F2C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 13:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11E710E2C0;
	Tue, 25 Apr 2023 13:35:06 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6899210E2C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 13:35:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPzU179cS1lDKtwF1e3cz/+7uS5oy2Yyjv1NHP4LrYiB4fk4MUOmtwiMXwt8cu2r6+nRAWZvYSu8p8WgRR26vYDshv5uuZ2VhMP0rMOWNlcLEP3Kf41q+d+Iqgw67lnFEHBGUowDUv0WNLbHet/clSpclpQFt53G5ZPb+aU3/sF21a0mC/6sKaDlPhbUUl+l8W/3GP0LTLIS3waZ8gMqvHW4QrHAdEXYFfVYBtvPv8EtiIVg8zba5g0/4UmlHYIk71zc6lycug00ID6E6IFl/cCanaY5ZBJxbpLUjJBGVNVOtKDCy/SiTiggfhV4p3OqEUqpYuIAXBBMvrz3XjYB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaK5SM1tQ/bHxdCKI1f/Tu/phT5QdMCqq7kEkYeLFnY=;
 b=H3BtOBwpXS8z8YBLKvHzn1lwcEFNmliIXkhgD/RgIi0SMhlE5UsRFNSbc9WS/jX8ONKC2vsfcA4408b3ipGylVSKazTdRB4uwO/7BdXycKZLxxRS9euy8zswXlAWTFo4QAwg0VuE+n61+bS0980E29zMrtSeLa5oGl60l/2nnDoRfy8GmKCRO9ZAO58PIJp70poysrDWE/sgUzAWidNz4VN1YKqq1mp6N78gsgPKkaVGSElXhb0hJGW9EE/pFYt2eK/Kgl2aj6u+bMcAj0MYjdvToMEPlzzNQJxzuRrIVyiQNcBl0t/Ol2k/WH6NhP2f+XyBmeNEpmbRg2zd1MdB6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaK5SM1tQ/bHxdCKI1f/Tu/phT5QdMCqq7kEkYeLFnY=;
 b=eHa7scY3QprnQGxOX99VVtFFBhx4s/o6LACkMRJDm5qsduIKfyCdvoHeJeDGINJhyAeoX7XR7iIY/lZeT/hwTRh+Cv2Wtl/Sv7TU/ntdr1VTLYYqQQJwHsbRMpRqwoMjQjJWxSVwlC0fJxF5eouyKZzOtMpiQCDnpBBV7Psk0H0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 13:35:01 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%6]) with mapi id 15.20.6340.020; Tue, 25 Apr 2023
 13:35:01 +0000
Message-ID: <a202c658-0b15-7a5b-df5f-7de8759afc71@amd.com>
Date: Tue, 25 Apr 2023 15:34:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 10/10] drm/amdgpu: cleanup leftover queues
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-11-shashank.sharma@amd.com>
 <66198170-f97e-7fd9-fd84-5046277b98d1@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <66198170-f97e-7fd9-fd84-5046277b98d1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::14) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: b3493510-8473-4fbe-4aa0-08db4591dec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AhCL+50l0wZLLA7gQL2TYkbUcgu5I49xTAgrQpRUlWn6ueCQZvbfm7KWCqJAVOnaptvXxM5j+f4176svJi6d+J3kDrvFDB3Mh894vjUSiKVmhCYpUZmRi8tKqzmZfVhmAdo+9vDPGuyUrOyQmVCUQ5NokdVxPbT83SrL5fMdaeRLerUWrqzUEHMn/Xue6zziw8GpAhXorog7zucdpBCU6aszTLXQI8CLekjWWTKf/G4gfmZLZkBX/FuqMBMEMPpnpi56LkJ7TV24/Tar4vOXSmnq5efBDgVqCV5ubUc9M6NiR5Owd1p/8ZARkYScFYKhDXyjuAfbD4Bf0nfqMG8zaPiTybWFn+k5/7S3QMUGPWtx//awOI3iTEUxAvrMMkbiMTk3A8e/D26QuqC2TSCTr1t2J3njH2BLqCioSooCUUOHng+mO53lXgY8UskzXNl/CvQUcxcoT+53NtcP3FzuMHp4iIwWzyDsUb23n2/lu3jj1JCYXMeOX+/N7CcoeQY4G8IUKpeRqoom93w6B/x6oKSY5LIKIBSeYWEMEfpk12ZvwjYRJ6ruakLOhtPRNTqRRlikKWKejkjoG8jxVHX8xQkvqCRkTBSJvvfsgQdrPvzcD+NZTJ1+h6xVqx6jy9qfgf1MEhSJMnFw2Lip6eGUXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(36756003)(8676002)(8936002)(54906003)(478600001)(66476007)(66556008)(66946007)(4326008)(44832011)(316002)(41300700001)(2906002)(38100700002)(5660300002)(2616005)(86362001)(186003)(31686004)(26005)(6506007)(6512007)(53546011)(31696002)(6486002)(6666004)(83380400001)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjRLcVd4SStqb3pTMUhHeGMwZWVoOGcrZ2JFOXVQeFJIN3VGRyt3RjZHWWJE?=
 =?utf-8?B?bzh0ck9rSW9Qd1NuWmRpQkFsWnlrWW13VGlJeDB6Z2pIRmJSTEN4dnA2TVFQ?=
 =?utf-8?B?Um1VYjBra0liODlkWHlHRlRXVE50ZXFYdnV0cFRuTUthU1NoeUZWUWl2eFZ5?=
 =?utf-8?B?VXhmSkE3aVc5cC9OS2NKcndMWmtISG5Ta1ZOT3hlR2l6Z00rSERJR1lWa2ph?=
 =?utf-8?B?U0ZjcnFVSFc4Y1lXNHFTNlVsQ0FmNXNLbkJFeDU3UWtacUFIZHJieHpVMm51?=
 =?utf-8?B?TEx5cEtzWCtpcVJ0MU9nR0NSb3NZSzM1RGh6amVUcjFReVlpS0s1WEptdzk5?=
 =?utf-8?B?S0xROU1CU1dCczcxb1lzUFB1MThSeVNremxsU2lmU2ZTTjNoakd5OWxZTE9I?=
 =?utf-8?B?YXlUODNHVFpaT203dmhRSUFWNVhVem1Scy81cjRxUWV0V2EzVlNxbUxEamxq?=
 =?utf-8?B?ZGlPcDM1bFFKeSs4NXg2T0IvUVl3UFkrNzYyOTd1UmZybWFiRnhGWExNNzdT?=
 =?utf-8?B?M2FjV1pPVnBGTGlYcHN1cVRCM2Q4M21NU1ZoTFV4VUp0Ukd4SXRnMFBhU20y?=
 =?utf-8?B?VXRaNFhkekF6dEh2cEt5UmFhUWw1aHdlNU1BeXBqU2JtTDQ1ZUVNVUVHVVph?=
 =?utf-8?B?TnZaZ2FiZ1BhSzNwM05OQTJTQ21QWXJ4TFRNdmdyYXhETlFuSmt5REdWYlVr?=
 =?utf-8?B?a3lFN2JXVkRCeGdvM3krazE5RVBZWCt2QTU3Qnhvc0pabTYrVW5TL0hMUFZp?=
 =?utf-8?B?RVFFTStlTWtDSjh0a3V5SURZNXM5UzZDdHFpakRHTm4zbGRaaW5FMndaY0lB?=
 =?utf-8?B?S0dIeDJPOXYvSXYyOEY1RGxIc2taVStHOS9zcXE0OTJoUnNYTXJMbm5NVXFU?=
 =?utf-8?B?WlZIYWF5ckxlTFhqUkNmQWhCWVA1ZlUzNlJTNk1FRVArOEhjWUhFa1BZakk4?=
 =?utf-8?B?c0ZvTlpHYTUvRXZIaDFiTmJMNlBrVno1TjJQaCs0cHVPSVIzS1ZCL2E1UDlB?=
 =?utf-8?B?YUN5WmRaSEJrSHdHMEszd0QwMXEyR3VQT2lUdW9HK3BhSW15UzZIOEoySTRz?=
 =?utf-8?B?MWYzcjQrRFZrS01meWJ1QjU3dHZySW15a1p4NzVsc0J0em1uNFE1K0x6TU9M?=
 =?utf-8?B?MzZxRmlZeFU2VHIvTWVtV2tFT1plVk5xWnlqWXptcEI1eWNXUG83elBqREtw?=
 =?utf-8?B?OTJnRTh2TmhKdWRKVldVOFRXcnFWZWxNcDBkZlQvR0t1amd5Nm52cXJNVDFv?=
 =?utf-8?B?ZFN5Z0tMcmNobHcwU05iUy8vczhTNHVPdnhhemhKb2VUd1RoSGtaV2pqLzVD?=
 =?utf-8?B?bjZrSnhuZzJKcWttemt2dVk3LzhaTE9mamhnTDFTWHMxUWpVenlFRU9iM1A5?=
 =?utf-8?B?ZG5jem1BUE0zT3Y0a3lVaDFDUjdzandQTkRFaDBVT09reE04ZjFrQTBTY0Zo?=
 =?utf-8?B?WTNiYytxYU42LzBoKzdBSXB6bUVkN2wzMkNzemVXQlhIbjBkaXpld3lIYXky?=
 =?utf-8?B?c3ZuZDhvZVVpNkM4Wi85SFhrcmM0Z3ZETDQ1WUpKQWNPT2puTXo0N2txVFJL?=
 =?utf-8?B?SmVTd05zaTlVeHNBWlJHRytESmVyemZVK3RHblV4RFlHaGl4ampTMkRib0Rk?=
 =?utf-8?B?R01wb0FwcUxTSkJYMEgyQ29MQ2UrYTF6L0FHVVh4M1BjaXdITXRsUExHWTlQ?=
 =?utf-8?B?SmIxeGNLSUNkaUQwSG1MTlQveTNzOW94QXU0d0lhdzFEeHB3S3VJVTY4RktU?=
 =?utf-8?B?N0FDMTlaa3Myd01JZERORmx2STNTcHZGY1doVjQrNkxDQzFab3VpWlo1a0hJ?=
 =?utf-8?B?U0w5R0VTNkV3SG80bE9DVmJITmFYc084bVRLODR2dHFmTjFxRmVaTEVIRDRP?=
 =?utf-8?B?ZCtoYmpsT2VvRkQzS1Y0ME9iMGtxZ2U0K2V3aHNmUDU2Z0FjMFNIamplSGZD?=
 =?utf-8?B?d1F1eFd0cEFvQVRwWmI0VUtxN2JaNGx0dXZiWENmUWNyNHJ6OXVLN1BpbkJ2?=
 =?utf-8?B?RHpmcDErSjMrMDRUdlBKRmFuLzBuczA4M0tUdGJOcWpaY0JVT2ErT25uVjBs?=
 =?utf-8?B?NVpoOTdXb01iYURKZXB2Y0w4UDl2dnVLekdxVkk4L0czUXhhRXFlYlJFalJ2?=
 =?utf-8?Q?hlgI4KG2LD584ipLnJAXPap6B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3493510-8473-4fbe-4aa0-08db4591dec7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 13:35:01.6131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDMHbSCQYo4Y4kN0HmV8/fNh4GSLagsPF5y4WmL/22ldsa2Mim1l3pQXYbu9tbqSFO5grSGlbVcp1a3/wLxQOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 25/04/2023 14:40, Christian König wrote:
>
>
> Am 24.04.23 um 19:38 schrieb Shashank Sharma:
>> This patch adds code to cleanup any leftover userqueues which
>> a user might have missed to destroy due to a crash or any other
>> programming error.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Suggested-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 31 +++++++++++++++----
>>   1 file changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index fbc9cb5c24ad..27201a0b1441 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -237,6 +237,18 @@ static int amdgpu_userqueue_create(struct 
>> drm_file *filp, union drm_amdgpu_userq
>>       return -EINVAL;
>>   }
>>   +static void
>> +amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr, struct 
>> amdgpu_usermode_queue *queue)
>> +{
>> +    mutex_lock(&uq_mgr->userq_mutex);
>> +    if (uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy)
>> + uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
>> +
>> +    amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>> +    mutex_unlock(&uq_mgr->userq_mutex);
>> +    kfree(queue);
>> +}
>> +
>>   static void amdgpu_userqueue_destroy(struct drm_file *filp, int 
>> queue_id)
>>   {
>>       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> @@ -249,12 +261,7 @@ static void amdgpu_userqueue_destroy(struct 
>> drm_file *filp, int queue_id)
>>           return;
>>       }
>>   -    mutex_lock(&uq_mgr->userq_mutex);
>> -    if (uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy)
>> - uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
>> -    amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>> -    mutex_unlock(&uq_mgr->userq_mutex);
>> -    kfree(queue);
>> +    amdgpu_userqueue_cleanup(uq_mgr, queue);
>>   }
>>     int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>> @@ -307,8 +314,20 @@ int amdgpu_userq_mgr_init(struct 
>> amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>>       return 0;
>>   }
>>   +static void amdgpu_userqueue_cleanup_residue(int queue_id, void 
>> *ptr, void *data)
>> +{
>> +    struct amdgpu_userq_mgr *uq_mgr = data;
>> +    struct amdgpu_usermode_queue *queue = ptr;
>> +
>> +    amdgpu_userqueue_cleanup(uq_mgr, queue);
>> +}
>> +
>>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>   {
>> +    idr_for_each(&userq_mgr->userq_idr,
>> +             amdgpu_userqueue_cleanup_residue,
>> +             userq_mgr);
>> +
>
> Better use idr_for_each_entry() here.

Noted, will update it.

- Shashank

>
> Christian.
>> idr_destroy(&userq_mgr->userq_idr);
>>       mutex_destroy(&userq_mgr->userq_mutex);
>>   }
>
