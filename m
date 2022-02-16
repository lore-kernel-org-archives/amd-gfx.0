Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70308C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 10:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00D5910E73C;
	Wed, 16 Feb 2022 10:46:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C467B10E751
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 10:46:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzOjtx1o3kwineM4o2n4kt4pIywZcxAyemsTjKOwKvSDO8VX4moHRfxc5vaaRRo5hjswzNnXot34YA5r/eNugUeFadsefpOo44xO1qJiuCVZWJddEkDerG6g1o+DC5QKkKHrGWwdrB1c65g/0I4L8gzfVIWrGyivER9PWFPkJUEvwdDTosecbzmAOjv5HDa/Y0x64gb1SeRB+ptFZ1I5GoPDQRqfXdWbh2bgJTXTCEqW4du41KMobl2B8oULrf+UEeqSGGWa4y2liwccz+RhQtw5wkG4NOncJm/IA0kKGL6Th7uAtG3ZDIYB92Bw2iR6cvo0mQffbKiNrrYFzVclIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4WNbqPZmDW9TXXUWMaDC+WjeFGFvcCNnzr/Qz8CWkU=;
 b=JcX0eGFYeNKxczmFpC2ZZNOeuNBd1/8cDmfJXxCZufI1EREXUJpYwsMBA024FMG0oyQMk2v9Luj4aJUTmZ8X70bGNE9d1ziuEF2Qk93aBUO8HYdTliWhpkt/ULwFWLNx+vfiQUd5OPMr7tRZMn9fIMUBDHHWyh//t4UCaYyyXAPol3zdwwLRk0sQHyQkPBGMvFIfDnOqzNPApwHBInUddX8g6SBnv9Y74X52nks+lo4sIe86lkeW4UnSbCUaF/PYU7ALtEVVAlKpXKvfElxo6W/6+UOoyfqtOu31X9BB8HmWqtFJqLa4gSrGWRZiHziLqGXlZ8C4jwx8WQIvfQYD5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4WNbqPZmDW9TXXUWMaDC+WjeFGFvcCNnzr/Qz8CWkU=;
 b=qVynm2YeN+bIA41RABx4133byiOqyrXNkhoBtMFYsPbRjlBRD7BWxHSb7wW3hUdmKrWqU2xcGHnMdqFt5a3tYDnT2tfx01aSevVfc4uQjTwMq4MB4dBlcq3xA6MJ/BnXamDozLArjivTXEuW6P7+tLTpGOoLCr4uGhjyBEPGwJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by DM6PR12MB4863.namprd12.prod.outlook.com (2603:10b6:5:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Wed, 16 Feb
 2022 10:46:17 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::922:40dc:9c59:b18d%2]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 10:46:17 +0000
Message-ID: <bd8ad3f6-ce54-6498-5b79-74e4a5457492@amd.com>
Date: Wed, 16 Feb 2022 16:16:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] drm/amdgpu: add reset register dump trace on GPU
 reset
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220215101228.9433-1-Amaranath.Somalapuram@amd.com>
 <20220215101228.9433-2-Amaranath.Somalapuram@amd.com>
 <912e3da0-d244-fba9-2991-acc4ea8e9943@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <912e3da0-d244-fba9-2991-acc4ea8e9943@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::9) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdb8e6b9-29a1-4592-cccf-08d9f1398f59
X-MS-TrafficTypeDiagnostic: DM6PR12MB4863:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4863E76AC1E8B82E94E86AFDF8359@DM6PR12MB4863.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAtYwtCyz9yPaVXS7+Cx40GAWsgdUDKmHVxhYtDrvMOSYlUEMc9WhFgcpGdznLYqQ1nF1hMsaN1wvT+8BH1Jtkao9oA3oarRFtPsnkvBDLo2P5hcFmjSi5CSAjxFurTbtpJXj32YQbWGruRAzLd6fCHCsaPnrWlhJ3VRlQLbV9G15pk9xjuTgkF9U9PdxIVwgbbm/bvepnxT3JNRJ9mMCUqqnuMTiyddqeF35j1s8NH+v1pias4gPzTrciHTLTTTZ/R5jyX8uVecTXtC35x//RzanybIWX5ap2Eg42Zj56D0VLgExSF/rD36FkmbtdmNvnDVMPztnAlkxMHz9M/gHXSbkm/FCPcrU6dnMB2aBkOFjycZ2of0BHIPeA4j+g62x6yPQoGk2zoTsI9B1ASMDSaHeZH71aygNUrGMvpBaKpgUcFM2it8s+W8yOLjiptRCuKsa3SnW6gP5l5fPThtWtkAzvhsxudJ3W3OPtXlQtDh7m7HZZHU758BvI912ZRaCY/OxJ7Z8Uati5fl2fhVC10UCL1Heah8cF96OfFc6IuNcnVNMvrUpDbhrFZwQSWQhOgRHPToyMVrwHF7GGjp1P1tvGzRRdgTbpEBJWdl3AkMl1p3xE3jVxVs+bJmBpuPKvWNvqftrH1N03j9tmc7AIgz+j/5f/0fNjhx7FRCGQH7Q9297CMaXOiJ7QSAVyoJ7ScmoUXyBP3M+ud3F1NqLkya4te6WSH0ckxNVkSuDlw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(2906002)(8676002)(66946007)(8936002)(31696002)(4326008)(36756003)(66556008)(508600001)(6486002)(83380400001)(66476007)(53546011)(6666004)(6506007)(5660300002)(38100700002)(110136005)(26005)(31686004)(186003)(316002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDZpOW1wcU5MeXRuNWRSZDJXVHVmWnBDcDdKbXJYVDlkUE9DQUJGVTZGS0d3?=
 =?utf-8?B?K1oyb3hzclcvOFd3TDlaVFZORkNuNVUrL1RCZ1QzdVlxRjZoV3MvMmg5M29Q?=
 =?utf-8?B?M0pJUEViZHhUY2YzTXBTNjFpMHNON3o5YUxMcUJUMlNmM2RoN2htNTR5VXVV?=
 =?utf-8?B?ejA2aEgwSGdGTFBSUnhpSnRyZGVyY0s4YThiRnVxR0JseDYzV1lGanVrbkt0?=
 =?utf-8?B?bnZXTlBXVjBhWS9uZ0hhS2NFSnl2RXVlTHJpL2xyMFA1bFF5U0lraGlMSk05?=
 =?utf-8?B?OXdRcE1WWVpoMFo2N2NiUTVFL1RPSU1RNi9kb1E4YThNYlVyYTFpSjNaajgz?=
 =?utf-8?B?MHQyU3VsMCtxU3dYUnNJTUZEQ1d5OWJwV0tLTiszZi8wWXpUSjlEOUd1VTZ5?=
 =?utf-8?B?VWxKT05OdFdtV1EvcmplRzF2VVpyTTFGTWpnVW1xTkdTMGtqb0xSSCtkL3hY?=
 =?utf-8?B?RjBtUzMzc2JPbUxJdzNJbWlBdzFIN0lJZ0hERTVtVHJUWVBsOFpwNU41ZDBH?=
 =?utf-8?B?OVRzZWJPZVJrdy9GWW9HYkgzVXNLaTRYZ29JLzAvQWZ1UTdLTjYyRGFrOURK?=
 =?utf-8?B?djQyK2ZiS000YXFhQ0U4Wi9sV2tscU5KNGRMckliWlhMb2F2aXA0OTFRTk5F?=
 =?utf-8?B?YVdvOE9WWDJjRWdhc0doWkxHL2VDWnJSRGZiakhBVEtqaG5VcDVMV0tZT0Zz?=
 =?utf-8?B?QnlnRkxVb3NUMDEvRTV4T3ZKZkRuUW5YYkxNdHA5Vnl3NE5qcWR4VE84cCtu?=
 =?utf-8?B?dXhBb0M2cXZzRmZBWmdIU2NRdHUzSXVzT3NXdVNjOS9Ud240TTJYYktoUXRk?=
 =?utf-8?B?UEZIQW50dXBuSWZ5TlN1NjlwTUlmY2V6QlZqRUk5Q1p4bFQ4bVdFRFlFV0Fr?=
 =?utf-8?B?MjJlcmczQnE3M01Uc05KN1pQNzVjZGRRa3RLNmdtS2NKc3VRWXNuOWRVWjVD?=
 =?utf-8?B?V0ZtNlpUUkQ2OXVhUUlvdFFaaG9sM1laQXgvQXFzZzNLcFRqaUtEOElSQTRZ?=
 =?utf-8?B?QUhLTUtyQVJjK1RXQnBKSmhKMG16MFZ0dlViaExGeGwvZXBCd1hGeDJqbHl6?=
 =?utf-8?B?YlQvdzVnTWVmcXJlaGx6MWpSN2tmcVRQQyt4VDVEUktNMDRCa3NOSXY3aFV1?=
 =?utf-8?B?ai8zMmRSbkx4dm1qaSt0cnJGcSs5SC9GTHhySXkyc3RERUUwRThvSEpFM1BI?=
 =?utf-8?B?Z0l2NHRhR29mdjFJdHZEbW9kVDlpR0d6NHhQOHZyUjB4VU9WUmphWUp6RW1E?=
 =?utf-8?B?VU8rT3dKWlUwT2FpQU93VjZBaDZCU043Mm8wbkhxR0FhZnR1VWRyd2IzcGt6?=
 =?utf-8?B?dWY2eFlKd1kvd3Bha2pzZTZ4cklnTVJleCs3VnhwM1pRcmxpSHNrdE5nemRS?=
 =?utf-8?B?SGNLdm1sYTc3b1pQYXhiU3ZyTStrMWpxYk54bFVCZjY4bmI3OEVsUE91UjR6?=
 =?utf-8?B?aXlXQ1NGQWhmaXh2RkpYc1RQMXJKS3BIWGVENEtKRW1HR0NIaUNNZmx1YUxu?=
 =?utf-8?B?T3FNbjEzRkZNM2pTZzlPdWY2Ulg1eHhUa3dLcUZRMHk3WUVZM2JFTjBEMEpq?=
 =?utf-8?B?ZHk3K01WVk1SVjB6Y0pGNXlHOWc5REt6a3RxMkg0bmxjTjdDSDlmcW9UMy9I?=
 =?utf-8?B?c08rck1sRXJlWGloNjZPb3RpUjYwUWplajVyUkprUHllajdkVlBCNTJYYUlz?=
 =?utf-8?B?Y2NaWE9RMVE2TkJ0RHdPNHczZkp5bzdNQWh0NDRIZGZDWXRuN1MxWGpmOUhT?=
 =?utf-8?B?MWtjYlJkcmFSZ2RhUHNudGRrdWhHdkF3WFBqK09ya3NTUS9oUXcwS0xTYmFn?=
 =?utf-8?B?NCtPY01LeFlWWk5CaWVNTzVXaVU1V2x0dnlTZ0dUTGRtbTkwUlI1b1VZNGV5?=
 =?utf-8?B?Y3FnRTJ4Rk5aeGpHRHNDbXF4WGoyNzlhRTVTbHdzN0tXU0JoUjlCZ2ZzRFVD?=
 =?utf-8?B?OS9hUjhBZzhmWWE3YWcrcEJzb0NwM3lvcFNJVlI3eHlLT1VkUlhEbkRVNDJK?=
 =?utf-8?B?VTVFZU01djFrdjNBTE0ra0luS254ZDdkaFR4Rm5ZRkNwZWJNb1g3T29PendW?=
 =?utf-8?B?UE5rUkR4VUFSLzVrTzlPV1ZkdmdzU1ZrNkZsYnpkWVB4Y0cvVk84Q296bHc4?=
 =?utf-8?B?M0FrejE2TkhJdDgvUWdsRkUzRDdvZ2c1SWNNamhBR1FHcDZPZ1lMMTJkdXM0?=
 =?utf-8?Q?H/KuC7AYJjkFPEkZ2SdpDaE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb8e6b9-29a1-4592-cccf-08d9f1398f59
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 10:46:17.3842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBtIadSrOSD3CSM2+SfNRigkt0ug6IgNlXdXJUHQWQl5nhVhCLDFokP7BWYtQtgQap6NrV37vDh6QH6kFeJJig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4863
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/15/2022 10:09 PM, Andrey Grodzovsky wrote:
>
> On 2022-02-15 05:12, Somalapuram Amaranath wrote:
>> Dump the list of register values to trace event on GPU reset.
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 16 ++++++++++++++++
>>   2 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 1e651b959141..ff21262c6fea 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4534,6 +4534,19 @@ int amdgpu_device_pre_asic_reset(struct 
>> amdgpu_device *adev,
>>       return r;
>>   }
>>   +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>> +{
>> +    uint32_t reg_value;
>> +    int i;
>> +
>> +    for (i = 0; i < adev->n_regs; i++) {
>> +        reg_value = RREG32(adev->reset_dump_reg_list[i]);
>> + trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>                struct amdgpu_reset_context *reset_context)
>>   {
>> @@ -4567,8 +4580,10 @@ int amdgpu_do_asic_reset(struct list_head 
>> *device_list_handle,
>>                   tmp_adev->gmc.xgmi.pending_reset = false;
>>                   if (!queue_work(system_unbound_wq, 
>> &tmp_adev->xgmi_reset_work))
>>                       r = -EALREADY;
>> -            } else
>> +            } else {
>> +                amdgpu_reset_reg_dumps(tmp_adev);
>>                   r = amdgpu_asic_reset(tmp_adev);
>> +            }
>
>
> Is there any particular reason you only dump registers in single ASIC 
> case and not for XGMI ?
>
> Andrey
>
Not really, should I move it to the top of function?

Regards,

S.Amarnath

>
>>                 if (r) {
>>                   dev_err(tmp_adev->dev, "ASIC reset failed with 
>> error, %d for drm dev, %s",
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> index d855cb53c7e0..b9637925e85c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> @@ -537,6 +537,22 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>>                 __entry->seqno)
>>   );
>>   +TRACE_EVENT(amdgpu_reset_reg_dumps,
>> +        TP_PROTO(uint32_t address, uint32_t value),
>> +        TP_ARGS(address, value),
>> +        TP_STRUCT__entry(
>> +                 __field(uint32_t, address)
>> +                 __field(uint32_t, value)
>> +                 ),
>> +        TP_fast_assign(
>> +               __entry->address = address;
>> +               __entry->value = value;
>> +               ),
>> +        TP_printk("amdgpu register dump 0x%x: 0x%x",
>> +              __entry->address,
>> +              __entry->value)
>> +);
>> +
>>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>   #endif
