Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712BFC61D85
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 21:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EA1110E193;
	Thu, 23 Nov 2023 21:33:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3B110E193
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 21:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJoSNW2UpV0W1rA1cjDDX7krAJewzBRTQzBXHfJOFX9KTyexx8naohvtVVfY+UUVB73DfE/9d9vWPByxa/tlrfSG5KcykBX8nr2BQlJiJoWrATZyEPca+DdJSqpVlWlTvFBphxsGSvvONr0Ho7cJdFCcE5yba5PtjRPZoAvPkSdG6Whu75B07L8H9Yv3ArnTlD4LoTdNH375JqmkqQ8oOP7JA3Laz8B6t+1J5IaQXL/RL3ea9JuzNalEp61nJ3hQ8VEQ9cMxbuL6nRzDCWJw+PqxyytWnEBRb9KC0EeLuDqZqSpsfboveJTKf9AueEdftnffFhAIrKE/TKTFF4KlIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObkkTAg+2TxCF72Y86WHuDwvWCIcpNevWhjR+Y+Anv4=;
 b=jmb14zBZCN/VkORTtM8s8RFcruJ7f237Af0Qws/s7AWgygcAUklwA/xeMSynsIqY7avv5o0LWKBpCnJOE09w1MCjJnG+lDKwTsDYUmquVmQDClWIlK/bXs+VsYJHjCo9WB4d4f+veIL9lqA/p2skMUQ8Wg3C/eMgUe6jxnhnD/rN//Fu21F5cR2otonz85wCy/Wqj4Ur9/VBE7WuvQJYctJX7en1DmQW2brLmaYXx1Oo1tsMXg529+daOqTJkz/jduTtEWA8QMnRaiLqIBfLU4XL2nxSKdW6DiM2qFtviPoAAMyADu51Xag5ZUp9cF9UgUFCQ9vTAq15ce2UPJ/+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObkkTAg+2TxCF72Y86WHuDwvWCIcpNevWhjR+Y+Anv4=;
 b=wvudbzBNSLmYfiDu4yhDkXUaThdHA6QEPyvGjfE6AXxGpAbWxmenfcrziVEoNmw4dJhH5ApnGTwiYqay9rE2p/fes4yG/1T++mlWS7uzcRNtAv4u6zJClbppbpujHC4td5dTs82pUmDZXRg3R0jk5zWH37b982dhS4Qeyg88VyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 21:33:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 21:33:26 +0000
Message-ID: <b2930db3-299f-4c10-98ba-b5d919d953d3@amd.com>
Date: Thu, 23 Nov 2023 16:33:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: SW part of MES event log enablement
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, Shaoyun Liu <Shaoyun.Liu@amd.com>
References: <20231123194819.1041850-1-shaoyun.liu@amd.com>
 <8ab4ed57-ef19-4dbb-9acb-af655bdfa448@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <8ab4ed57-ef19-4dbb-9acb-af655bdfa448@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 25853588-074f-4a07-ba25-08dbec6bd410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dm6Qr5QVR3vGWAefQ8A5jiuiR19hXXDYN7ThpQOWmDts2VPoDucOMk4xgD/dmLLlyf6eQvcumm/fa59b5Dr7vA5D2qoY4GZV2pF6MjrMii5ThovZxVB4aP1g/3GOZ+zgLLexB+fMt4iHiI97Sq6WoCcw6r/PbDL6qry39WxFx3LjgVzwBXIaPdwtLAUk8L8QDEfvzxJKKPuGthXTEL64Gpy++LIoIfsEx+d3yXTdHLdImHCt3rZAk2HdmBk2DhdLtqihsBUsem772tWXHGxhzPjmMlbKba1FU351/FBgbOmGdrvSivBGQNVsD7Y1kuBj3nRGsoTaarrx3TQUKOhpd3gTrneYTc3W2ccNbn5SqxcrdJvzQSs/o6060pNgQRb5vS33vU7U/3S1RlKi5kVS6WwV5i8GVv8xumrDKEBmUqH62ILJfI9pIljuVYeGvcWA/jWzLiaOUjt2LiTCTNQQHyjGlZ+PIa/fOJMcv4xoUNW+jlx7wnSDLT61PtRv6D4dtMCn9dCte8GRVK4Av61ekm1HCL7GCYsgY7L8ZOLapyIn9a0pFNFKOcipQYJhDsfu+vKAZDz4VqLJkk0ER3AJRJO2NirkUntNlyO+xvP9FziFljuqC9N7d0603tVJuPNfMkgvpAUhPXyyzYuTJAJ9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(36916002)(53546011)(6512007)(83380400001)(2616005)(6506007)(44832011)(5660300002)(6862004)(8676002)(8936002)(41300700001)(478600001)(4001150100001)(2906002)(6486002)(316002)(6636002)(37006003)(66556008)(66946007)(66476007)(31696002)(86362001)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXp6d2szaTZGTVFIYUNvOXYyQURObUxITFRDMVRCUmdnaENuRHdIRU0weGRs?=
 =?utf-8?B?S0p4MWhqUnZmOXQrYS85ZDhUQWNhY1htZEk4Rkdab0d6c2VkMzRiY2VuSDlt?=
 =?utf-8?B?RjkrbGxGSlN0QkJXVUd3Ym9XeE92eWRFTFhUcVBhRlhDbzk1UFhkbFR3a1VV?=
 =?utf-8?B?dTRwSDg0T1pDL2lnTG9wSDJJNnM3R2NLRmtKaDBXcEVZSXpHL1VEanY5bkd5?=
 =?utf-8?B?dkl2UWt1dklTQ2c4cVE1SU95M095MTJSS3ptTzlOZDgxdExOdDNtSUlrZnBx?=
 =?utf-8?B?TERzQ0hza2g3YUgvNVBFUTlKWHBUT0FsV1NVakxTQlYxSjZ1SHUrRnZGNjVE?=
 =?utf-8?B?QmZ2SjBicnZhVnllZGIwckNHRmVOQ2hCbGhQdUM1OHJBbjd1dFVwaTVQUDI4?=
 =?utf-8?B?QkZ4bUZ1UWs2enJLbUNCS2lEOUExOXAxd0lOY1RQYXZaMFNQRkhRbHcxQ2cw?=
 =?utf-8?B?ZWlKV0hQeUVGYUhEQmcvblJCMHdIZUtpem5GNU9BVjNYSjFGUWp3WFEySXp3?=
 =?utf-8?B?cmRZS2E2QUt4VVpIU0dlRGV6OFBqblh6OUxSVTZFam9uNHkxWGc3dFFvNjRS?=
 =?utf-8?B?cGM2MkhMZlE5VXIrem1VaUVpMTdROUxqc24weEZVMGhwZVJ5QUZFVWk2TVBN?=
 =?utf-8?B?Yk9TcEd5Smc4ZVRwVnBwb3B0QjRQblBtTXZHRmpPbUZMcU1oeFhVYTV6QzFu?=
 =?utf-8?B?T1U4QlFCSnhFSjNqUnkvZlhIQkIyYWxGZ254eDh4TzB5YmVuTXBvTzZtaUVD?=
 =?utf-8?B?RGhGTW5WZ3VDVXpyanJmTkNwaFNLRUxDV1hWL3JwMTF5TENzRWhFMjhXVjRS?=
 =?utf-8?B?UFhpTmNHejBOU2NXVDdjd1hLS3ExaUg0ZFl0cXAyR1dCMWt1MWZsZWhKeWli?=
 =?utf-8?B?aVZ6VWtBUEFFMGptK1krLzgwY01sV014NlpUc2hFVE5ONTZoZUplQk5SK2Zk?=
 =?utf-8?B?bWp0U0l3Qno3MGRLdm9xWklvb2FNMkRxdXNlaHJaZmR2emVMU1pFejMzaTg3?=
 =?utf-8?B?YVFXeXdKTnF4U3Z1bnZpK3p6YzZiOFZjRGl0cFNzSHZKZUhkam9zU2Q4M1hn?=
 =?utf-8?B?SDJsL3RIaGYzbUZ3N2lwZDdHQisybmM3dUdGdDFhQ29xU3VFUmE1ZnMyTnhr?=
 =?utf-8?B?U0kvZ05NdUVqcEZWbzRLdHJIZ2EybVZjTEtBNTFWZkdOYUw2WDZhd1pibFNo?=
 =?utf-8?B?VlN5Qk1HTVgrNXpwU3VLbFdNb1ViWVlnKzhKRmpEMk01RkZIcTRrMktVSG00?=
 =?utf-8?B?Qy9zN2lWQXp0SWpydlN2dlhFWTNvOTU2R3VxRnZoT3FObVkzYlpJaHJ0SDRY?=
 =?utf-8?B?L1R4U1VzU2hSL1E3WHZMWDJKV3NHV3pxakVqR1k5T0g0S1FXL0t3bGpzTTVG?=
 =?utf-8?B?TTJPOWp6ZWducjRIYXVwSGRyVW5iUE1CMXpzckdEcGxpbGR0RnlCNmdRdkpQ?=
 =?utf-8?B?bVNIK09qQ1BVQkpzeWlnNGtCRExWZmdaSmlIYVlnKzc1a2xCS3dZWkFoNXFF?=
 =?utf-8?B?Uk11NGo4eElsbmp0N2V0eEc1SDJaYUIzK3NUTEduektzM2NCZ05iZnJ0M2lS?=
 =?utf-8?B?L1BRY1pOV3VGNll2STFOQVZzTDRpRVRHdHU4TnBoKzZvcGVPZDBGQ1dqbnBD?=
 =?utf-8?B?YWJSSU43bUlGR24zSkZ5Z1lBZ3FFNGQ4dFAxQXFwcXlXb2wxeHlrSm9QMTMv?=
 =?utf-8?B?ditWWFVwVkFPZEpGdzhjSEh1TVJ5Q2JWbVBwS2NXeWNRUkxNZnNYNG5zdWNP?=
 =?utf-8?B?Y1BjMTJ2T0EzdmM2UHZla1ZxdGlITFZWVUltM09LTnUvNjdjTjZSRjE3MFVz?=
 =?utf-8?B?cTVTMW5OQ25wV0Ftd2oraEpMOWdPZHhMQ0dFRk5acFU3VStXQTBsT3NqQkNF?=
 =?utf-8?B?UnZsUGNiL0RUWU43eU9UL0F3RmNWKzJENVIyOW04ODZpL3lVVVRhc09hQVlr?=
 =?utf-8?B?cFlnWjY5WjJkcUNjakhvTGNISmFleTlpMmxJL2FGMWhpZi9HM2NJN0J0WHhY?=
 =?utf-8?B?eWJ2MXdQUk53VElnNjJ6SEgweHYrTE9lc1c5RkY4QWpLVnNyQ0FDWGZGbUlk?=
 =?utf-8?B?YzhkWWk4T1hBNk90V05SZDNnSDY5OXY2TCtLVXZTam1qb0FVYW9CVDFRbFdn?=
 =?utf-8?Q?ZOLAsqMFyw31hKdyIVjrw2752?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25853588-074f-4a07-ba25-08dbec6bd410
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 21:33:26.7824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFbNHA2zUXnxAk96lzbYIt63AZ46fyzswgZhafpJun7/DOrcWgGwXPqWJ8MRudmCD/znL9etdWDuwirns+4CDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880
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


On 2023-11-23 16:29, Felix Kuehling wrote:
> On 2023-11-23 14:48, shaoyunl wrote:
>> This is the generic SW part, prepare the event log buffer and dump it 
>> through debugfs
>>
>> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Sorry, I just realized a potential problem, see inline.


>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c     | 61 +++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h     |  5 ++
>>   4 files changed, 70 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index a53f436fa9f1..8b2cbeae99ca 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -2140,6 +2140,8 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>> *adev)
>>       amdgpu_debugfs_firmware_init(adev);
>>       amdgpu_ta_if_debugfs_init(adev);
>>   +    amdgpu_debugfs_mes_event_log_init(adev);

This always gets initialized, even if the GPU isn't using MES. But the 
log buffer only gets allocated on GPUs that have MES. I think reading 
the log in debugfs on a GPU without MES would cause a kernel oops. You 
either need to add a check for that in ..._event_log_show, or skip the 
debugfs file creation in ..._event_log_init if the GPU doesn't use MES.

Regards,
   Felix


>> +
>>   #if defined(CONFIG_DRM_AMD_DC)
>>       if (adev->dc_enabled)
>>           dtn_debugfs_init(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> index 371a6f0deb29..0425432d8659 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> @@ -32,3 +32,5 @@ void amdgpu_debugfs_fini(struct amdgpu_device *adev);
>>   void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>>   void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>>   void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>> +void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev);
>> +
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index 45280fb0e00c..b4ba556dc733 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -97,6 +97,26 @@ static int amdgpu_mes_doorbell_init(struct 
>> amdgpu_device *adev)
>>       return 0;
>>   }
>>   +static int amdgpu_mes_event_log_init(struct amdgpu_device *adev)
>> +{
>> +    int r;
>> +
>> +    r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
>> +                    AMDGPU_GEM_DOMAIN_GTT,
>> +                    &adev->mes.event_log_gpu_obj,
>> +                    &adev->mes.event_log_gpu_addr,
>> +                    &adev->mes.event_log_cpu_addr);
>> +    if (r) {
>> +        dev_warn(adev->dev, "failed to create MES event log buffer 
>> (%d)", r);
>> +        return r;
>> +    }
>> +
>> +    memset(adev->mes.event_log_cpu_addr, 0, PAGE_SIZE);
>> +
>> +    return  0;
>> +
>> +}
>> +
>>   static void amdgpu_mes_doorbell_free(struct amdgpu_device *adev)
>>   {
>>       bitmap_free(adev->mes.doorbell_bitmap);
>> @@ -181,8 +201,14 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>       if (r)
>>           goto error;
>>   +    r = amdgpu_mes_event_log_init(adev);
>> +    if (r)
>> +        goto error_doorbell;
>> +
>>       return 0;
>>   +error_doorbell:
>> +    amdgpu_mes_doorbell_free(adev);
>>   error:
>>       amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
>>       amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
>> @@ -198,6 +224,10 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>     void amdgpu_mes_fini(struct amdgpu_device *adev)
>>   {
>> +    amdgpu_bo_free_kernel(&adev->mes.event_log_gpu_obj,
>> +                  &adev->mes.event_log_gpu_addr,
>> +                  &adev->mes.event_log_cpu_addr);
>> +
>>       amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
>>       amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
>>       amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
>> @@ -1483,3 +1513,34 @@ int amdgpu_mes_init_microcode(struct 
>> amdgpu_device *adev, int pipe)
>>       amdgpu_ucode_release(&adev->mes.fw[pipe]);
>>       return r;
>>   }
>> +
>> +#if defined(CONFIG_DEBUG_FS)
>> +
>> +static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, 
>> void *unused)
>> +{
>> +    struct amdgpu_device *adev = m->private;
>> +    uint32_t *mem = (uint32_t *)(adev->mes.event_log_cpu_addr);
>> +
>> +    seq_hex_dump(m, "", DUMP_PREFIX_OFFSET, 32, 4,
>> +             mem, PAGE_SIZE, false);
>> +
>> +    return 0;
>> +}
>> +
>> +
>> +DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_mes_event_log);
>> +
>> +#endif
>> +
>> +void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev)
>> +{
>> +
>> +#if defined(CONFIG_DEBUG_FS)
>> +    struct drm_minor *minor = adev_to_drm(adev)->primary;
>> +    struct dentry *root = minor->debugfs_root;
>> +
>> +    debugfs_create_file("amdgpu_mes_event_log", 0444, root,
>> +                adev, &amdgpu_debugfs_mes_event_log_fops);
>> +
>> +#endif
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index a27b424ffe00..894b9b133000 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -133,6 +133,11 @@ struct amdgpu_mes {
>>       uint32_t            num_mes_dbs;
>>       unsigned long            *doorbell_bitmap;
>>   +    /* MES event log buffer */
>> +    struct amdgpu_bo        *event_log_gpu_obj;
>> +    uint64_t                        event_log_gpu_addr;
>> +    void                *event_log_cpu_addr;
>> +
>>       /* ip specific functions */
>>       const struct amdgpu_mes_funcs   *funcs;
>>   };
