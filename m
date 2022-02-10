Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23BFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 05:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FE1110E67A;
	Thu, 10 Feb 2022 05:30:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF03410E67A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 05:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnbD0Ljo7KvYGLOveL+zKyCe60AmAxbZdDVsy+1WvSeo4CsXjOR1DBIB6jXm200j6QAq4o3Jch3uLW0stzMLQ6G2lRSuLOkTwzaTRfH/fi5QGGlMs4sYN75CBofeILLM/RvFTEB9jra0y9uZIyOalNeAiRmwPNCb3RN2MvzE8Vx+HJ4DRi+84Sw2Yxry9O6Zbt+/F7VS6x8oKrxMoM/ecGT3aBJYm7vtwB0Y44LBzULAsHJyUhZZHr8K03J18wn6YzqcnF48MUoTQFJRupdBeCjSfUC8kObxY0RpXz/0TE48nR0gSQWC3sVziujLi5p0FgRi86F3bIrlahoxW6dAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRn3Nk+MSm3tJ62WO7ZK57P4Qo5SKDkpq6gPZPzxBws=;
 b=S+yaGmrez+Iy1Jp/zp9BhxKDrQUdW1jobS8xfjjQcYVYgU1Up0DhUQ8beEOuCeAJrUWLAWR3SK1uSN4G97LiTnEJUkCUYgS/RXgwLbi9CdTtkGPmwqyHhMBFZpOsoul9gcxsf03M9k3jAVzEPdJgd3+UNqURbS6RnNfTf+yldWpCRnVIfwj13fEkWS52xq1K4Vbpl0oop/fVk+5TlgoNzByY9nW+OBsLIe2zZojT7P+Ml5sm2RdzY7VzbhmTWmzyguoNX1V5eYyq84MG8SSL3zLHURmVba006Nqp8VRgeHtGmbJrBMd+nh8v17wHGsvnNXKwqC021eyw7Q74rxi9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRn3Nk+MSm3tJ62WO7ZK57P4Qo5SKDkpq6gPZPzxBws=;
 b=33VH9cRanEGeaZw5P0drQ4Ux/Onz3ZXo+tEfzMCHI//OsX263tNYA+NuCoi5iN9vq/YFM09o2ZJ8gccOrusooqqnx649aR3PR1/9mpvm5KUcy7AGYbXw5bGv1u3cnYcH1AOJYI4jxm7vwXxnE+5H8BpX3Hp9rlrLfbDRnr58MFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3892.namprd12.prod.outlook.com (2603:10b6:a03:1a2::11)
 by MWHPR12MB1568.namprd12.prod.outlook.com (2603:10b6:301:e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 05:30:06 +0000
Received: from BY5PR12MB3892.namprd12.prod.outlook.com
 ([fe80::5c63:88eb:f0d7:c523]) by BY5PR12MB3892.namprd12.prod.outlook.com
 ([fe80::5c63:88eb:f0d7:c523%5]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 05:30:05 +0000
Message-ID: <49e24f9f-4657-d3ce-e84e-abbaa56d3181@amd.com>
Date: Thu, 10 Feb 2022 10:59:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add reset register trace function on GPU
 reset
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
 <20220208081647.3025-2-Amaranath.Somalapuram@amd.com>
 <CADnq5_Pun3UPKJsTKEf4pu3R=UbbHAZDW5-=+pekTDx4TWsAEw@mail.gmail.com>
 <6a7ca5ae-6d78-b8fd-cba8-cd2dca4418f4@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <6a7ca5ae-6d78-b8fd-cba8-cd2dca4418f4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK0PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:203:b0::15) To BY5PR12MB3892.namprd12.prod.outlook.com
 (2603:10b6:a03:1a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 327d055b-39a6-478f-b84b-08d9ec5664a8
X-MS-TrafficTypeDiagnostic: MWHPR12MB1568:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1568A27CC29B12DBF1B9C00CF82F9@MWHPR12MB1568.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:298;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgrTgSOa356Os87MMQ4lnrnRgmKndCumfTZwWCKxFZHZF6YS153rNMb68+yaHW1CBB89LadUr4+Mu9l7Mqm5hIyEki+PhumzygZ5j+ncduJW+S648A5nj/i7EgQCkLoxVEFgJ+E9EXlqjxj2tbS6lyV7ncqvE4O+4ig6f+A7JPJQya3GJiPdrXEKuoSCt+7iik8Fqj6KIhSwZGmMcqlhF+F2luKgpj23Sqbeu8uwy6vyMxUxl3JrNNRrmFVP1LGO7aEi+kFcX09J7aZTI8HJZXYY0QDGw8756SvjIawxHkbIofwyZ3Sm/h95X/fbpzHQ2fuFi5qo/XfFZBG+wn1Gj1VPuZJEZwGHQ1Rs6EFW893eYPm4xwrm9KxOLBTN+pJSacfaQZeZOxLysiII5m4HZdJ14UMLcewaQNmqBnwdREjev0CBRVg+71VbdhDaAEuXRkKzfaLobYrZn3tvkp83HuX3QI2EKPPZ5IE8Gju25wJsWQjE/L/Raop1biOJk+AOy/ZvJGr30YIp5vKgHzqr828airuOc05wODTuXff1jylQo1Ec+LOp8Eta+IlAIXoDRIiDGnIr9su5EyLPaWSwDcO7+DdzTzs+IG6ostfOYnbwEjD4sZxpmBmJN+kifj21/nejRRgKP8pAjfUsRwqLPmk8yffth5SS5B3TyhYR6Q1t9TeE7UcwAzq/3U2Fu6M2PkQxNzrxTOGPfDIEozmh8iPmy2h+EJJTmFkjmgYrgLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3892.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(31686004)(6636002)(4326008)(5660300002)(508600001)(2906002)(66556008)(110136005)(66476007)(66946007)(31696002)(54906003)(316002)(8676002)(8936002)(6506007)(6512007)(38100700002)(36756003)(6666004)(26005)(53546011)(2616005)(66574015)(186003)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3B0VDdFQ0srcGRMa2RTZmNkbjRuN3NsSnhCa3hmekFzVlZtMVhoQUFNdXpS?=
 =?utf-8?B?VWRXalRXUjJDcXd4bmtBV09FMisxUEdFK2h4eGVTbzU4VytuTGNSbG9oSEdV?=
 =?utf-8?B?VEpZM0k4NnE3RjE1S2hYTGlYME9FYXN3ajE4QnBhcFZNczZjNStLTG1nNERq?=
 =?utf-8?B?VXBveG55RXMrT09veGhjQzRRR2tkcHo5TjlRc2N6cnlaSHZqSlNvYWg4NFVi?=
 =?utf-8?B?a0dENFFjQk45QW5Gb0xFdlN6QkI0bThRZ3NUTzZYV0Nya0d5ei9yMllRRXFm?=
 =?utf-8?B?WUpXdFJ1K1JDMU1RRUxyNlp0VGVxM3BtQVFnS0dtR25PdEQ1ZXVRNG9wQVhQ?=
 =?utf-8?B?dE0vS3NxbmxxZEtZZnFGMFVmbWFKYUhpWXRCcnR6bU5RUnIvbzVzTnhKSzV0?=
 =?utf-8?B?UTVBeHVkc3haSSt0TklhVVpMZDhBSE16SDJEVy92ZEpieXFURTQyVmZLclVl?=
 =?utf-8?B?YjdTcVoyWUs0b1Y5enRLVERodGV4clZMVUwzbTRUajZGWGovd0sxdTZnb2ht?=
 =?utf-8?B?eWlIN2FZczV2bWdyMTZ6dWhsbmtNSXJSQ0xtMUhGdzU5U1F1VjNZUkcxbGE3?=
 =?utf-8?B?RTJ6TlByMksyb1Yza05uTlVsQ3BFSGlFa1ZKQ2ZwRVFhRGtBV1AxMDJlOG9J?=
 =?utf-8?B?T0xKeGUrUHNPZEdhTURVWUN5TkhvL3RsNDVZN2NpQXByM0tuSk92NFlhb3Vl?=
 =?utf-8?B?Ly9XSkpvaUJPRHcvcHVIeWZlbi9IYkFDRG5iTStnUG5kbnRMUEhvMkE0Mnox?=
 =?utf-8?B?MVJ6V1FhV0ZnZGpxTkxPNGhPRWtEazJkYnY3RlpqOTVIRXdvQkNhRTJmV3J3?=
 =?utf-8?B?a1VIcXVuSkVDakg3dUZJNU0vcmtMZlcyWmd3ZW9Oc2VFWm0wZ2xxTWVmdXZx?=
 =?utf-8?B?NWs2aDQxN08vczJiejJrWjJBUStySU95S3g1b0ZtdDNkeTNqSkdvTTBIbjRi?=
 =?utf-8?B?bWhWL08xQ1VyVEdCT0hONEJodURMYnZ6M2pqQnBPQ1BXM2xvOVpsV1g5ZWJO?=
 =?utf-8?B?Unp2bjMrU2dRWTQ4Y3VacGt0K3F3RkkzY3VUMFM3SVZtaTQvZUY2OGhnSmR4?=
 =?utf-8?B?ZkZHOW9CVHNxS3BpVnBITlJFbm9YUEdZTWxiQnlXQXVkNFJ5VnQ4cXJMZ1hh?=
 =?utf-8?B?MDZQT3Rwb0RUQWJGeXBuWWdzMldtVzB4ZVoxSHdVQmtMY3hiNkUxTmYzeHhw?=
 =?utf-8?B?b3NnNjA4YkV0QW0wdkZvMHRld1ovQWU4M3BvSXFlM2VJR0h2MDZ6dlp1dTBr?=
 =?utf-8?B?bXJ0cTUwbWJ1UE5Cb3pRU0xsdlFlOUx6OG9ZaUh0a1hBM0hUVUcxZnA4VlJa?=
 =?utf-8?B?VVlmUVNQSEYrNnlHMnpHUysyMTJ0cmRLUEl6VllqWTdwTDFhNHdoMWdnU2M5?=
 =?utf-8?B?OGRPUm9BYzlVMlJuS3Y4bGwwUDR3L001SU5sQTVSKzFuUWJIdGN6V3lTOXBB?=
 =?utf-8?B?VXc3a05GUFNKbHBCT2NSWUluUEd4NjJMWHIxVmpubmNLT3JtNzNEd1k1T1JT?=
 =?utf-8?B?bm5ZQlJKMXM3elJTM09JbHJYWXVQbGlnTjVpWWNTanhKR3N3dCtZbkFLbXdx?=
 =?utf-8?B?Um9paXdpbXFMWHNXem13Z0ptWkZZbm5ITFM5SW9OSis1NWQ1Mk83WGE0ZXdV?=
 =?utf-8?B?TDJUNGZDY1k2VUg1QmE1eDJuZlhLVE1SaTMrY3Bpc25iVUhRUk1YQitkaFZL?=
 =?utf-8?B?eTRPQ2VUZk5MSWRFVE43cm44dnJOVG1hVlJIOFhmVnJkY0JXZDFvQk1Saysy?=
 =?utf-8?B?RzJRZ2ZjOEhncFkyZmtBS0hLOFVPcXR0SWJkV3VPODdHSFhjSWdncnI4cXNs?=
 =?utf-8?B?N3FvWCtaaW5lVElIajhVRUUxeUdWdk9WWWVhNG55ejBweFVaU0c4a3lJc1ZM?=
 =?utf-8?B?dmpKenZTVlNybUx4TzJUYVJxVmFjVWVCZWI4cCtIT0kyQ2xMQ3d3cnhkQWUy?=
 =?utf-8?B?Z2JJdUpmZU9BWjdOQkhWemhhNlN5eHdRalk3YmFCZG5FMnVGWlhLM3p0bDRa?=
 =?utf-8?B?cDgwbEFOSVlUdVgybWU1RXl3WHZqSkdJREV2cG9McnFYK04rZ1UxSWcwMUFi?=
 =?utf-8?B?Qld2ZlhMTUJsNVN1dlZaM0MvcWZ2eUFJVGpFd3NlM2kxVnQ2UXBiZnlTcDVX?=
 =?utf-8?B?a090b1VrNDA0ei9kZE0wRlh1dFhpNlVycXk3WEl1RDhVeW5qTGtvSnIydTVm?=
 =?utf-8?Q?lHF/74F6GbCOIBgDJaPIK+E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327d055b-39a6-478f-b84b-08d9ec5664a8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3892.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 05:30:05.3038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcV7NPDRhdyowwTQJHLAkewSj5T7a4CFOyVsUAPkFNj/bmSw0AEHSM1zIoXqcTBZyMx5DClj5z9hXtdMdcDlvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1568
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/9/2022 1:17 PM, Christian König wrote:
> Am 08.02.22 um 16:28 schrieb Alex Deucher:
>> On Tue, Feb 8, 2022 at 3:17 AM Somalapuram Amaranath
>> <Amaranath.Somalapuram@amd.com> wrote:
>>> Dump the list of register values to trace event on GPU reset.
>>>
>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++++++++++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 19 +++++++++++++++++++
>>>   2 files changed, 39 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 1e651b959141..057922fb7e37 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4534,6 +4534,23 @@ int amdgpu_device_pre_asic_reset(struct 
>>> amdgpu_device *adev,
>>>          return r;
>>>   }
>>>
>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>> +{
>>> +       int i;
>>> +       uint32_t reg_value[128];
>>> +
>>> +       for (i = 0; adev->reset_dump_reg_list[i] != 0; i++) {
>>> +               if (adev->asic_type >= CHIP_NAVI10)
>> This check should be against CHIP_VEGA10.  Also, this only allows for
>> GC registers.  If we wanted to dump other registers, we'd need a
>> different macro.  Might be better to just use RREG32 here for
>> everything and then encode the full offset using
>> SOC15_REG_ENTRY_OFFSET() or a similar macro.  Also, we need to think
>> about how to handle gfxoff in this case.  gfxoff needs to be disabled
>> or we'll hang the chip if we try and read GC or SDMA registers via
>> MMIO which will adversely affect the hang signature.
>
> Well this should execute right before a GPU reset, so I think it 
> shouldn't matter if we hang the chip or not as long as the read comes 
> back correctly (I remember a very long UVD debug session because of 
> this).
>
> But in general I agree, we should just use RREG32() here and always 
> encode the full register offset.
>
> Regards,
> Christian.
>
Can I use something like this:

+                       reg_value[i] = 
RREG32((adev->reg_offset[adev->reset_dump_reg_list[i][0]]
+ [adev->reset_dump_reg_list[i][1]]
+ [adev->reset_dump_reg_list[i][2]])
+                                 + adev->reset_dump_reg_list[i][3]);

ip --> adev->reset_dump_reg_list[i][0]

inst --> adev->reset_dump_reg_list[i][1]

BASE_IDX--> adev->reset_dump_reg_list[i][2]

reg --> adev->reset_dump_reg_list[i][3]

which requires 4 values in user space for each register.

using any existing macro like RREG32_SOC15** will not be able to pass 
proper argument from user space (like ip##_HWIP or reg##_BASE_IDX)

>
>>
>> Alex
>>
>>> +                       reg_value[i] = RREG32_SOC15_IP(GC, 
>>> adev->reset_dump_reg_list[i]);
>>> +               else
>>> +                       reg_value[i] = 
>>> RREG32(adev->reset_dump_reg_list[i]);
>>> +       }
>>> +
>>> + trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list, reg_value, 
>>> i);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>                           struct amdgpu_reset_context *reset_context)
>>>   {
>>> @@ -4567,8 +4584,10 @@ int amdgpu_do_asic_reset(struct list_head 
>>> *device_list_handle,
>>> tmp_adev->gmc.xgmi.pending_reset = false;
>>>                                  if (!queue_work(system_unbound_wq, 
>>> &tmp_adev->xgmi_reset_work))
>>>                                          r = -EALREADY;
>>> -                       } else
>>> +                       } else {
>>> + amdgpu_reset_reg_dumps(tmp_adev);
>>>                                  r = amdgpu_asic_reset(tmp_adev);
>>> +                       }
>>>
>>>                          if (r) {
>>>                                  dev_err(tmp_adev->dev, "ASIC reset 
>>> failed with error, %d for drm dev, %s",
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> index d855cb53c7e0..3fe33de3564a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> @@ -537,6 +537,25 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>>>                        __entry->seqno)
>>>   );
>>>
>>> +TRACE_EVENT(amdgpu_reset_reg_dumps,
>>> +           TP_PROTO(long *address, uint32_t *value, int length),
>>> +           TP_ARGS(address, value, length),
>>> +           TP_STRUCT__entry(
>>> +                            __array(long, address, 128)
>>> +                            __array(uint32_t, value, 128)
>>> +                            __field(int, len)
>>> +                            ),
>>> +           TP_fast_assign(
>>> +                          memcpy(__entry->address, address, 128);
>>> +                          memcpy(__entry->value,  value, 128);
>>> +                          __entry->len = length;
>>> +                          ),
>>> +           TP_printk("amdgpu register dump offset: %s value: %s ",
>>> +                     __print_array(__entry->address, __entry->len, 8),
>>> +                     __print_array(__entry->value, __entry->len, 8)
>>> +                    )
>>> +);
>>> +
>>>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>   #endif
>>>
>>> -- 
>>> 2.25.1
>>>
>
