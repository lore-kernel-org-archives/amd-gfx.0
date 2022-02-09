Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3FEC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 07:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E271510E257;
	Wed,  9 Feb 2022 07:47:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4071D10E257
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 07:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmJsUFSnhVQB5+VOXzLTHnfnT/2USk6YRBNULjF+y2WWPurzVrGktm7LSnVN4MseQ08R/3uOPZFSdo0vgrMEYcrSqn04d1hwT/fw4/+5x8qc+1UYVSleVqbJXJTEEAFUpXmCr6yvUogneME6AS3E9JotGXnoIvmZr2WxPtwJFTAzLRCeWTi5YPNQnuDT6i9pAS4GmGKAnO9uIbsRgu7IQoA+1caojdLMeTcN90YgLoYLKVrftEspekUfqvyQzW9h4o2p9b08KhD+v2bkT7DOKMsaddTIo/NLms3v/HZxh2zXhJe/VcCuPuwSk5mjZ7r5i2og1dloa2BGVNkEPKAZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxa9v7Gu81RlVdDeNoMOfzopOGnZlXC1/srPGiWSP40=;
 b=i0gadjqs+RJWYqOTMFr+4rLobuRfw7To1Mp+4L4YzKWRAZKl2SYQL3zMrm8O0CPdqr0fAmxBo2Yns6n1AnJweOvyTx1wAdT1wSymafP15PrAHNU/dg6gvin6hGahjUuYUwTDmkT1A9DbDvrS68DI12XovJlbUQMrkmlIegmHpdCYIQ/bdyOC37Nt6jES3vIlxFK3HGl8qbasP0Bssut6DSVKoIM7XhZC3Fq6CPU6C/N1fkEXsHlFG0eJna4CSD0smsmJN3LbvbkvuTP0+yCplB2BIv2ABTje/EX6fcgqqAzIrAdiJWoAPhy5J9mMatkA6paN8w+pt50fAEATdlxw6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxa9v7Gu81RlVdDeNoMOfzopOGnZlXC1/srPGiWSP40=;
 b=w+vqTRrOzJWVCibkwQ1A8xmKuL32TnmFghi/0cSMEROtRcgkzyZwBi3WHVDLOJJd5X7wN/Bc/w9H3fbxBjpSRhif3jS0YWnGADDkeH/jDCEkVih7ccjVaxXwJBayKN81vEw91ZsyxTmH0+5kWM9ZB1MmbEXViaKdMEG4crnxito=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN8PR12MB2916.namprd12.prod.outlook.com (2603:10b6:408:6a::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 07:47:49 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3%3]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 07:47:49 +0000
Message-ID: <6a7ca5ae-6d78-b8fd-cba8-cd2dca4418f4@amd.com>
Date: Wed, 9 Feb 2022 08:47:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add reset register trace function on GPU
 reset
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
 <20220208081647.3025-2-Amaranath.Somalapuram@amd.com>
 <CADnq5_Pun3UPKJsTKEf4pu3R=UbbHAZDW5-=+pekTDx4TWsAEw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_Pun3UPKJsTKEf4pu3R=UbbHAZDW5-=+pekTDx4TWsAEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P195CA0067.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::44) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a11c5af-b9b6-4f32-a68a-08d9eba0781a
X-MS-TrafficTypeDiagnostic: BN8PR12MB2916:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB291622F6ECD2E1E7D8335340832E9@BN8PR12MB2916.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:234;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vx94hg/rhTNRKucd9k7X9d2jPw9zUjlpL8tIsyViYwmkuJpmAj0J6RNcEqpel1CELKe2NnRxhb1pWPLjNUSiAWyDOjD14s5OD+9AUqOnbQUnQB9UrX4t+y1pLKpmDFacuTI62t7vjdudUbVuYqXKl96clAGD5poDEF2chgdkLVHshHDDcQvfFiNo89DIYz6tMea5e+Mq8XDUuczBzobjcw+uwrs7YXH13nYiYqSiZlE8zZiRHdi4DYQUY8juE5zqYiGcuB+FR+gPPgmygF7ciHZVmn3H5eFwEdC6rWWxLOxzJjvWVG1PckN32KNBtQMNZN7J69vQJXKGMvBZWM1bMK8ywchCWCTHt/+xJ4BFrHQVsXrxBRcxMe4Hk1Pn5r+BJUNkGiChfChA/h9WbFFq+C9GYf3QgxeqAruue2RJyjyyE4unP6EeG0jaquMzPySsI5cykGaN6gE/hWAX/kKDAppNZYnx++cOj7uQ2TWdBtP2fe2o3gSfsGc9k8YunOP6/kIBsonOuLRg3F3kYkf/vxhtSsIkLzRPBK1lKS9jqhTByed8HhWmnMFXtQg0t8JjQvy+j5LSrO77rmEHWu3WEC5NJhv4GejyzqCYhn2t+EDUR/Mro3hmwk84JCPt9zpcVd2RprTM6AoZPcn9AqNI1ajdzphpEiappEF1qGFr503/ws98EvLqPcpFKbkBEKk/5kYawB6dF5TG8DpHLsKDbWPu4+sbU+tk9GE/sfG61nWQAHzdPlrhZ7H/ZizDTcZc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(53546011)(6486002)(508600001)(4326008)(36756003)(6666004)(6512007)(83380400001)(86362001)(2906002)(6506007)(38100700002)(2616005)(8936002)(6636002)(66476007)(31686004)(316002)(8676002)(66556008)(66946007)(31696002)(54906003)(110136005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkVuNFdEZEpOcHFFbUYwTE51TGJPSEZUa295dzQ2enlFTEtwQXU0VldXa1pp?=
 =?utf-8?B?WFlvVUpvbWU2MG41WEk0QWFjUUhmeVp3N1V3bFBIWElUM2g4aTlxdG5lbGsz?=
 =?utf-8?B?Z1lPdmMycXRSNHZzVUdlSkJiRjQrRGo5aVAwamFRNlMvTGoweEdTMjIza1NW?=
 =?utf-8?B?c0lybjBhaUxLYmMxNW44RTFtWHNURHlic2Job2liT3VXVFh4TU1DK3lncSto?=
 =?utf-8?B?UVNpVjBNNFdrUUtkTE1XSFU5bjVOWmR5V2t2bmFXQ0dNL3lESkVjazhtWEdn?=
 =?utf-8?B?dURQNmdtMmpSaStQRGhvL215ajZzNVdtN2ROdW0rdWRmbFdVa0JiK1haOVNJ?=
 =?utf-8?B?UUE5TmVuOEZVVkJtU0NIcjVQazBMckZMUEJoWUJSb1ZiVzF2WkczK0dBT2Js?=
 =?utf-8?B?cktTVTdiUG5xMjErWjRHTVpCOTBUWGpCMGhuOEZpL29ZT0RQdFlrRktBOVpD?=
 =?utf-8?B?WklpWGNaWHdFdGlrNzlIRWRZZnRrcFYwcFZTa2VMRzlnWkRaMFg1QllkWVQv?=
 =?utf-8?B?MW91WEI0RFB2Vmg5c3dkYXE4TWxFdDFTTDRGeU1ldnRpZnM0WUZlRHVMSkRh?=
 =?utf-8?B?cjZTNmpzaGN4TStNL1BvZGlKSnR0UE4weFN2b1QyNm56OEs3V1BQNDNibi9O?=
 =?utf-8?B?RXYwZkEwTWsvQzI1akl2aTdXUXdtRDF5QUNIOFZLR1kvUVVSTTZ1QU5vZ3RW?=
 =?utf-8?B?Sm1kbytBK29iTnYyd2I4RTkrUEZzT0g5MWlmbzl4NXFWUVBmaXNJSWR2Vmhk?=
 =?utf-8?B?cVMya0VHVEhKNWlOSUZuZEhBNENPdkdMbS9PRXV6M2ZDQXJYbytQN0ZMRFB0?=
 =?utf-8?B?M2pySFlJRlJSdEpNcml6NEFIdVJpMkd3bUwvcm5STGpHZzlYb0Zra2pGK25L?=
 =?utf-8?B?TGNKWUVrSFhqMzBpVnRvVmovY1NsQ3B3SHA0SVo0eVBPUFN6cVlBOGRRbTVY?=
 =?utf-8?B?bUJ1Q1NiL3RMamZOMzZRQ0t0YU5tVGsvL1V2NUFxODBrK0xsOTJRRDhBM2Nt?=
 =?utf-8?B?cjRFdEtxaGRpQnFjdHl0MUdGRzR2S3E1WmZQRGRZUE9zZzBkVzNUZVkzZ0Zo?=
 =?utf-8?B?YjlDK1FuRjJHWk5TUkMrMEpvSzdyTzFXamlCSDY5N24xTi9pcFlYN0dyWklr?=
 =?utf-8?B?THR2T1NTK3pVdUpBakpLdHYrekJ4NWczZzRjeGdKUU9wV3MvbUNSb3lPdWlN?=
 =?utf-8?B?aHRiQXJ4VHhYRkF2V3duOGdzWGpjOXZuQ25OTHQyaExnWTdPcldyWTdjN2cv?=
 =?utf-8?B?OFZSU0R2RkREU3Nnd2pZdStpcS85QjA1c2lwaTNoY3U0NCtXK0MxQ2tEUDJC?=
 =?utf-8?B?bUFsVUc5MlFCUklUS2VrSWZDejJON05SbUllRWs2WDIraDd3MFBYbTlTRlJu?=
 =?utf-8?B?eUY4VTFSWVdGQVJVOXAzcDB2TVZkSFhNVkhZUU8ydFpWMVlJWlJ2RkZkeUcw?=
 =?utf-8?B?ZGhhdjlrcHliQk1tVU9KZlpGUWRVU3kyZzRvQ1RiQklxd0JNUTlHbU5hZTQ2?=
 =?utf-8?B?Qng0SVNleHZaWmVxdFJlMUwzWWVCbWwzVmdkUnpRN1dzaWN1eTF1YnFaZGlI?=
 =?utf-8?B?M0RFc1BzbEFWN3l2STRyRmNGM0Z0M1Q0Z0owUmtJTFYxQ1YvM01tWHBmUGZL?=
 =?utf-8?B?ZDI1MkJKdWNQcmQzVXhDYWNDcWoxUWMxZUlmT3ZBamRQN2dtbW9VUFdyRktX?=
 =?utf-8?B?OXE3anpEY2JzN3FBa3dnUXVoYmplUWhWSjBRQmhNNGFLVlJMTUJobUZIVDFF?=
 =?utf-8?B?Q1E2bUNETi9leUxMSExWa3ZmMTZpTkQ4OTdXNk5EbEt1SDlSVVdzTHQ4Q2Nl?=
 =?utf-8?B?ejdWa3I4OUk4blNSdUlLc01sQTRzWjlyQnBldllGT3owNmhJTk51ZFZFbXIw?=
 =?utf-8?B?RWdjeHdXY1NSSlJxWlkxWEhDZnRrdXVOazhrckFXeHlaVXVTSUpYZ1VlOC9t?=
 =?utf-8?B?aXR5NExCLytsZUtTM09vSC9tNFR2V3U5NGtycHNDMU1memlrK0V0NW5aRTBl?=
 =?utf-8?B?ZXlVdHFSNVBJQ2s0K3ZhcldoVlRNQVBRRG1uZ0UwditnTG1EbnR2RHlWZk1T?=
 =?utf-8?B?YmpiMS9UaVhFWEQ5YnFVbnNBTUVmRFF4ZG9kQktEUmlXa0lhU2hGSzh5V3Bu?=
 =?utf-8?B?QTlDaGlQeHhqMTN4d05OMG9ldmRhNkVTSzdzajU4dmpsZnVINHdkZ0F3VnpO?=
 =?utf-8?Q?bYxVqWLtkCp5335VQIQfynk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a11c5af-b9b6-4f32-a68a-08d9eba0781a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 07:47:49.4442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbb6VmW/W1+lGHPqR7zn1yu445LCDbsD3YbV0Rmjn/lGKuwkeBsso8P4ggP9X5By
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2916
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

Am 08.02.22 um 16:28 schrieb Alex Deucher:
> On Tue, Feb 8, 2022 at 3:17 AM Somalapuram Amaranath
> <Amaranath.Somalapuram@amd.com> wrote:
>> Dump the list of register values to trace event on GPU reset.
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 19 +++++++++++++++++++
>>   2 files changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 1e651b959141..057922fb7e37 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4534,6 +4534,23 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>          return r;
>>   }
>>
>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>> +{
>> +       int i;
>> +       uint32_t reg_value[128];
>> +
>> +       for (i = 0; adev->reset_dump_reg_list[i] != 0; i++) {
>> +               if (adev->asic_type >= CHIP_NAVI10)
> This check should be against CHIP_VEGA10.  Also, this only allows for
> GC registers.  If we wanted to dump other registers, we'd need a
> different macro.  Might be better to just use RREG32 here for
> everything and then encode the full offset using
> SOC15_REG_ENTRY_OFFSET() or a similar macro.  Also, we need to think
> about how to handle gfxoff in this case.  gfxoff needs to be disabled
> or we'll hang the chip if we try and read GC or SDMA registers via
> MMIO which will adversely affect the hang signature.

Well this should execute right before a GPU reset, so I think it 
shouldn't matter if we hang the chip or not as long as the read comes 
back correctly (I remember a very long UVD debug session because of this).

But in general I agree, we should just use RREG32() here and always 
encode the full register offset.

Regards,
Christian.


>
> Alex
>
>> +                       reg_value[i] = RREG32_SOC15_IP(GC, adev->reset_dump_reg_list[i]);
>> +               else
>> +                       reg_value[i] = RREG32(adev->reset_dump_reg_list[i]);
>> +       }
>> +
>> +       trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list, reg_value, i);
>> +
>> +       return 0;
>> +}
>> +
>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>                           struct amdgpu_reset_context *reset_context)
>>   {
>> @@ -4567,8 +4584,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>                                  tmp_adev->gmc.xgmi.pending_reset = false;
>>                                  if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>>                                          r = -EALREADY;
>> -                       } else
>> +                       } else {
>> +                               amdgpu_reset_reg_dumps(tmp_adev);
>>                                  r = amdgpu_asic_reset(tmp_adev);
>> +                       }
>>
>>                          if (r) {
>>                                  dev_err(tmp_adev->dev, "ASIC reset failed with error, %d for drm dev, %s",
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> index d855cb53c7e0..3fe33de3564a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> @@ -537,6 +537,25 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>>                        __entry->seqno)
>>   );
>>
>> +TRACE_EVENT(amdgpu_reset_reg_dumps,
>> +           TP_PROTO(long *address, uint32_t *value, int length),
>> +           TP_ARGS(address, value, length),
>> +           TP_STRUCT__entry(
>> +                            __array(long, address, 128)
>> +                            __array(uint32_t, value, 128)
>> +                            __field(int, len)
>> +                            ),
>> +           TP_fast_assign(
>> +                          memcpy(__entry->address, address, 128);
>> +                          memcpy(__entry->value,  value, 128);
>> +                          __entry->len = length;
>> +                          ),
>> +           TP_printk("amdgpu register dump offset: %s value: %s ",
>> +                     __print_array(__entry->address, __entry->len, 8),
>> +                     __print_array(__entry->value, __entry->len, 8)
>> +                    )
>> +);
>> +
>>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>   #endif
>>
>> --
>> 2.25.1
>>

