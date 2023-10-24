Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1EDC00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 02:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B1C810E052;
	Tue, 24 Oct 2023 02:55:56 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7FCE10E052
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 02:55:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRMtacohVGc3B6xuAVsjE1OADwqX6CmF0Pk1T6+vj9A7McQ4AY/FDo8k/Ii2yIFO/iGJ2ZCu9/+lQcIdr+ZiFbP+DUCdNBLldI/Roxn8CZjQkxvh9wQ7F5pbJ5JKUcmqvvFQqsJFw8uCB75AHdLLLo5Jmyq4XTuBduS+mxeN9Olp/do2eb4Lv+gaLFER+yZU4WOhOgTCZ46S+5AUI8iPqDy0WGtjpwjTgTU+TPV5Wm12g58Ao1b4FuIroG/U5KvRkcRhFBxWPRezuFcN56CVZau8kHjgfx2rHrYVNXKrGsP8NS0w43JyMzEE39vwnY77o6Dd4KGFNUe2tkP/MO0frw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXc5kh3SOlazUzldLLRw+Qn+69si0hn9XKmBD1+SijI=;
 b=CqGNHITnI4yyIe3ctmL/UWGTeIOd7B+8bLWg0S23KhHrUJIJsmv2k80m0QFqzBTqcHSm2kV4kUtSOWZjPT/FUCm3EWhRHllwqSTZZdt/QXjInI2FQuJ+/P6F1yml6PokSLvlpFKo48TzNNCI0sqslLLSgXjNCBP3+c1ViD9/lzyjYlPG5jf+tEoKSPimP49zoOmT+Esulr0ioCAcoBRtl/nSQrMPdlYmdyfaoNd9wFZPCU3rCXjdgY80yAZQXrQLu0PbocnPmXSmeZ3T3yHgNHLKOdJdO2AFc2NuvWV8U1y13QDaWIOn9oGBtHHVWC5NQruutzaqz9jWCihVkeYQbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXc5kh3SOlazUzldLLRw+Qn+69si0hn9XKmBD1+SijI=;
 b=piruBowRfF2nW44/f01DgvUwgefLaIh3GSqyo0KrP0UsFkIW/9/mXG37UMfCy3qpJIFTOc3G4TTekO1/NT1HB7p/xLG9MWG2bUiUt/Ty7k/7yn56/rhkoFRaYbIqmwT0r30WZW0ftgp4oxXxsn/yRrzhzxP/345lUbYU//eOEa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.31; Tue, 24 Oct 2023 02:55:51 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b80b:7138:6ceb:9aef]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b80b:7138:6ceb:9aef%6]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 02:55:51 +0000
Message-ID: <53e14f59-6743-4a11-bf27-151507071bb0@amd.com>
Date: Mon, 23 Oct 2023 22:55:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.3.3
Subject: Re: [PATCH] drm/amdgpu: Initialize schedulers before using them
Content-Language: en-CA, en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20231023032344.164925-1-luben.tuikov@amd.com>
 <402f475c-bb67-4061-9521-2f811eca7657@gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Autocrypt: addr=luben.tuikov@amd.com; keydata=
 xjMEY1i6jxYJKwYBBAHaRw8BAQdAhfD+Cc+P5t/fiF08Vw25EMLiwUuxULYRiDQAP6H50MTN
 I0x1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+wpkEExYKAEEWIQQyyR05VSHw
 x45E/SoppxulNG8HhgUCY1i6jwIbAwUJCWYBgAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIX
 gAAKCRAppxulNG8Hhk53AP4k4UY5xfcje0c5OF1k22pNv8tErxtVpgKKZgvfetA4xwD+OoAh
 vesLIYumBDxP0BoLiLN84udxdT15HwPFUGiDmwDOOARjWLqPEgorBgEEAZdVAQUBAQdAzSxY
 a2EtvvIwd09NckBLSTarSLNDkUthmqPnwolwiDYDAQgHwn4EGBYKACYWIQQyyR05VSHwx45E
 /SoppxulNG8HhgUCY1i6jwIbDAUJCWYBgAAKCRAppxulNG8HhnBLAP4yjSGpK6PE1mapKhrq
 8bSl9reo+F6EqdhE8X2TTHPycAEAt8EkTEstSiaOpM66gneU7r+xxzOYULo1b1XjXayGvwM=
In-Reply-To: <402f475c-bb67-4061-9521-2f811eca7657@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::15) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: b2436ae3-27ed-4193-aa9a-08dbd43cbb29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k63QKWCvUM5HDqxMwLNs6KsE++NIm0eSFtz48QKqGs+4KxwTFeMNan6Z6N83q4PO6OgtSwTprGDAHteSzqOICfPZm2gQ1JSgwyBdYmkEtbHTK4f6RF0EBrwEG6E3nM+6R9y2bCGbHbxclqa0/mQF+JtFDMKJLXfG5j4By3x3wwLkI/Gi1EKaBnpmjncEbgMnjpm1xfxfynofrHLNW1sm9JFHtz6qoQIKF+pnyEXXpBkqkjGduFMBiOJTeheR3oOAzDSpUosAMhQmKtueR7J3Uo4NPtPi+wCCmwtoNPBA1ww+CAECVLBNra3hMn3eSZUZB5lvm088tYt0MdaQNuo+t//ZiHIFdu0w80ShqxyuXFWtoKeJO/f+u53XABp8cvLtjJermlzHhD3aEkCoUKX0IqSh4Jbjrxhw+xt+2724pQuHnzU4VL3abbYysWNq7NgQrHuGRnggRlqaUwWOX5KGMjEwEboRhbCwozCaFEb5N/BE09mdm3Vd/bAUhB/UIiuVL2WmFtTK5lUmI3bCxjk0aFVhEKrlDfV7hR88OgORq6EylU2tZkp7uRKbKHuJxhuTUh20Iei2shRUCh9kEbAy4fZqwpYl+oBN9BEEjLgUNibLWMCOzaTwbKxuDK6cTSTySra7ok+oR8tIz90MAKU0cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(83380400001)(31686004)(44832011)(4326008)(8676002)(4001150100001)(2906002)(36756003)(41300700001)(478600001)(2616005)(53546011)(8936002)(38100700002)(86362001)(31696002)(6486002)(26005)(110136005)(66476007)(5660300002)(54906003)(316002)(6512007)(6666004)(6506007)(66556008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXhyUEFqRFB1SGZ0ZDFtTG55aUcvdHk3NmVsdC93Slp4NXFrek5CUHlsRkdo?=
 =?utf-8?B?THR3SE04cjhYeTc1akRxT0dRTUVqenJETnRCYUQraG5WYjV5MUFBbm12Y1Np?=
 =?utf-8?B?K3h6OWVSV1pEZ0JyL3p6dmlsOWJDT1FYY3FPZVNQUW1uNk1ZdUZDNnVFQUMv?=
 =?utf-8?B?cXp6MDJVYTJna2xwb3cwaFRzenFnUGp5NERhYitrTUFlV2lVb2cwVms3cURP?=
 =?utf-8?B?T2ludzBzWkg4dm1nQm9OYXRzbGc2M2cyS0JiRmQ2MHp0K3ZsTlVjNHpsaERY?=
 =?utf-8?B?WlE2OUdzaGwxTVF1RTVXVUEydVFyMG1YRUlXN0ZXUVNFTFE1VkpqUTdvRkxZ?=
 =?utf-8?B?dWRReUlaT0VhYTUvMGNpMVlrTE1oUFNNMWZYTGRGOTVwTUZ0aHU2Y3FHdmFu?=
 =?utf-8?B?UVhXcjhsaGV2LzgzeGd0ZjhlbHkvTDdkWlhoVjZva2o1dTRXMU1UZnl3Zlk3?=
 =?utf-8?B?WXlhS0dpTmtjdlNaV2toK3VONzhRcVZBOUg3eTJ0azk4UHkwYXVCN1pBbnV4?=
 =?utf-8?B?bmlTZHNtRlp4NHlvbG5UWG1YYTdON2RMVGFQODF5TS9uTHlsUzJPVjlWVmE0?=
 =?utf-8?B?WEdUS1RTOU9GZGVabEZxMnhmOU8xNUo2UGJRcGZ6eGs1OTVwaklSWkxzTUcr?=
 =?utf-8?B?UnVUZVlQS2pUN1ptQ29sdkdldE11WnBjdGtkaTF2VERObEZ6Y0tyRkY5aGpn?=
 =?utf-8?B?OXk5aE5UMWlrVWNuaFJ3S0NyMC8yTms3dlJzVE15cGphUlhEd1dNMkk3OTl6?=
 =?utf-8?B?WmptOGtIbnFEVWhqdjlaOXFJRjVIeWIzSEk4OGdSdmdmMzJibDF6SmNKV0ZN?=
 =?utf-8?B?TC9laXg4UHF0dHA1dWs2K3dNM2RQR3hqWWovd3BHV1l1ODVBWXBRUW1DWU9u?=
 =?utf-8?B?bzlOTXYxRk5lSW1OS3UzNG5jSlliTnEwdk44STJZTlcxd2srU21KMzFNTUlk?=
 =?utf-8?B?THdha1ZSdGFPVzZKRnNYZ1lObFdnR0ZpaGNXaXNJa0F4M2o5VmpHWmdqQmFY?=
 =?utf-8?B?Kzc4M3dSc1gvUWVDLyt6UVlVVnkrN2MyWUJFbEEwY3pLQUVpUFZnUi94dk0v?=
 =?utf-8?B?N0RaMUl4aXBjdHhnMnlvcC9OREZPK2duRU9pV0Vtc1NURVRNOXRiVXFKNm16?=
 =?utf-8?B?U1phWHE2SFRaK3c3OThWQTllakJWVkV0S0F0NFJVRzN3U2NabmYzcUw1SEJm?=
 =?utf-8?B?VHhyRSt4MHE3ZndaQlpDbklnZWVrUzBQOHN0eDZWNy9kTmdVbW5wclRMK3J6?=
 =?utf-8?B?NGxQR1FLWlZDL00zOWdJQnJuN0tXRENvL0hOVUNsSzBpb2Zac0ZXUHRwTzdr?=
 =?utf-8?B?YktRUVdnZ01ZWHVBZ0NvS0tZQU90YWNFemJQQy9hY3IyZi91bWplTlhZNjN4?=
 =?utf-8?B?Q1NuRkpVdkhJS3ByZDUyNzR0SDB5eENraVVjVFJjOG9FQ1I5cEV4dXY4eHdh?=
 =?utf-8?B?aDM4VS9CcG9VMWFVdS9sR2VLYkVLVUoyeE9Jb3RrZy9IN0ZsZmNvcCs0ZkM2?=
 =?utf-8?B?NjdKTXBPL2NxYkdJRGhyWTVGMEdwcXlXYXZqeUlUY2ZwWEVkM3lIcWYrWlFs?=
 =?utf-8?B?Zk5DQUlwa3h2N0dKMnBmaVZyRDdpbzBMNTRYb0RvSXVXdFZlTGJTSjdCajYv?=
 =?utf-8?B?RTJCbE85WVJiSngwcjdGTHoxcHQvMllWOEZ4Yy9KL0hQc0JlK2RjZERndFVL?=
 =?utf-8?B?eEdPMkswdFNaK1hxK2RVbGVLb1lpVnV4QWFaaXJ0K1NXeHFXR0ZOY0RKUWJQ?=
 =?utf-8?B?aitLWmp2NzY4ZWNGMG1DTkpkV2tSZjlEUmlmVzZjOTBZSkVsYzlGaGl5eGM4?=
 =?utf-8?B?MGdMckZqY29Ja0F0ZVFONEQ0OCtwTUMrTCszeHZhWjJQRVlWWHFGYVFYV3RT?=
 =?utf-8?B?R0JMeTkwZE0wdEp3UlZJdjJwelJVZUNtaGVHd1daL1VoV1Rteld2MmR3THhH?=
 =?utf-8?B?ekxtVURLQWZ0d1Q1NWo2VC8rSWhQcWVraXlkN3BJZEFIa0grU05wSTRUd2tW?=
 =?utf-8?B?eDhydjFlUUluVVVpa1hDUGd5TWtlMlk3Y2FWN2pyMjNvR1RkZ0k3N1JLa25M?=
 =?utf-8?B?TkNGZ0NuTEJXVmZxZCtwdTd0MURqb0RLN1ZGd0xIR1BPcXYrWkhFZlVFVExC?=
 =?utf-8?Q?vF3K2srWZmmVT8WOHFR+Fz6K9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2436ae3-27ed-4193-aa9a-08dbd43cbb29
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 02:55:51.0078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UK6xRmSCuTSwhvpDrnTHc2LURya3KJWNs64HCT0xWeo42TxE2q4YNT3ejdEQVXM1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-23 01:49, Christian König wrote:
> 
> 
> Am 23.10.23 um 05:23 schrieb Luben Tuikov:
>> Initialize ring schedulers before using them, very early in the amdgpu boot,
>> at PCI probe time, specifically at frame-buffer dumb-create at fill-buffer.
>>
>> This was discovered by using dynamic scheduler run-queues, which showed that
>> amdgpu was using a scheduler before calling drm_sched_init(), and the only
>> reason it was working was because sched_rq[] was statically allocated in the
>> scheduler structure. However, the scheduler structure had _not_ been
>> initialized.
>>
>> When switching to dynamically allocated run-queues, this lack of
>> initialization was causing an oops and a blank screen at boot up. This patch
>> fixes this amdgpu bug.
>>
>> This patch depends on the "drm/sched: Convert the GPU scheduler to variable
>> number of run-queues" patch, as that patch prevents subsequent scheduler
>> initialization if a scheduler has already been initialized.
>>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Cc: AMD Graphics <amd-gfx@lists.freedesktop.org>
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 4e51dce3aab5d6..575ef7e1e30fd4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -60,6 +60,7 @@
>>   #include "amdgpu_atomfirmware.h"
>>   #include "amdgpu_res_cursor.h"
>>   #include "bif/bif_4_1_d.h"
>> +#include "amdgpu_reset.h"
>>   
>>   MODULE_IMPORT_NS(DMA_BUF);
>>   
>> @@ -2059,6 +2060,19 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>>   
>>   		ring = adev->mman.buffer_funcs_ring;
>>   		sched = &ring->sched;
>> +
>> +		r = drm_sched_init(sched, &amdgpu_sched_ops,
>> +				   DRM_SCHED_PRIORITY_COUNT,
>> +				   ring->num_hw_submission, 0,
>> +				   adev->sdma_timeout, adev->reset_domain->wq,
>> +				   ring->sched_score, ring->name,
>> +				   adev->dev);
>> +		if (r) {
>> +			drm_err(adev, "%s: couldn't initialize ring:%s error:%d\n",
>> +				__func__, ring->name, r);
>> +			return;
>> +		}
> 
> That doesn't look correct either.
> 
> amdgpu_ttm_set_buffer_funcs_status() should only be called with 
> enable=true as argument *after* the copy ring is initialized and valid 
> to use. One part of this ring initialization is to setup the scheduler.

It's the only way to keep the functionality of amdgpu_fill_buffer()
from amdgpu_mode_dumb_create(), from drm_client_framebuffer_create(),
from ... without an oops and a blank screen at boot up.

Here is a stack of the oops:

Oct 20 22:12:34 fedora kernel: RIP: 0010:drm_sched_job_arm+0x1f/0x60 [gpu_sched]
Oct 20 22:12:34 fedora kernel: Code: 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 53 48 8b 6f 58 48 85 ed 74 3f 48 89 fb 48 89 ef e8 95 34 00 00 48 8b 45 10 <48> 8b 50 08 48 89 53 18 8b 45 24 89 43 54 b8 01 00 00 00 f0 48 0f
Oct 20 22:12:34 fedora kernel: RSP: 0018:ffffc90001613838 EFLAGS: 00010246
Oct 20 22:12:34 fedora kernel: RAX: 0000000000000000 RBX: ffff88812f33b400 RCX: 0000000000000004
Oct 20 22:12:34 fedora kernel: RDX: 0000000000000000 RSI: ffffc9000395145c RDI: ffff88812eacf850
Oct 20 22:12:34 fedora kernel: RBP: ffff88812eacf850 R08: 0000000000000004 R09: 0000000000030000
Oct 20 22:12:34 fedora kernel: R10: ffffffffc066b850 R11: ffffffffbc848ef1 R12: 0000000000000000
Oct 20 22:12:34 fedora kernel: R13: 0000000000000004 R14: 0000008003000000 R15: 0000000001000000
Oct 20 22:12:34 fedora kernel: FS:  00007f7be4866940(0000) GS:ffff88880ed00000(0000) knlGS:0000000000000000
Oct 20 22:12:34 fedora kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Oct 20 22:12:34 fedora kernel: CR2: 0000000000000008 CR3: 000000012cf22000 CR4: 00000000003506e0
Oct 20 22:12:34 fedora kernel: Call Trace:
Oct 20 22:12:34 fedora kernel:  <TASK>
Oct 20 22:12:34 fedora kernel:  ? __die+0x1f/0x70
Oct 20 22:12:34 fedora kernel:  ? page_fault_oops+0x149/0x440
Oct 20 22:12:34 fedora kernel:  ? drm_sched_fence_alloc+0x1a/0x40 [gpu_sched]
Oct 20 22:12:34 fedora kernel:  ? amdgpu_job_alloc_with_ib+0x34/0xb0 [amdgpu]
Oct 20 22:12:34 fedora kernel:  ? srso_return_thunk+0x5/0x10
Oct 20 22:12:34 fedora kernel:  ? do_user_addr_fault+0x65/0x650
Oct 20 22:12:34 fedora kernel:  ? drm_client_framebuffer_create+0xa3/0x280 [drm]
Oct 20 22:12:34 fedora kernel:  ? exc_page_fault+0x7b/0x180
Oct 20 22:12:34 fedora kernel:  ? asm_exc_page_fault+0x22/0x30
Oct 20 22:12:34 fedora kernel:  ? local_pci_probe+0x41/0x90
Oct 20 22:12:34 fedora kernel:  ? __pfx_sdma_v5_0_emit_fill_buffer+0x10/0x10 [amdgpu]
Oct 20 22:12:34 fedora kernel:  ? drm_sched_job_arm+0x1f/0x60 [gpu_sched]
Oct 20 22:12:34 fedora kernel:  ? drm_sched_job_arm+0x1b/0x60 [gpu_sched]
Oct 20 22:12:34 fedora kernel:  amdgpu_job_submit+0xf/0x70 [amdgpu]
Oct 20 22:12:34 fedora kernel:  amdgpu_fill_buffer+0x2b4/0x650 [amdgpu]
Oct 20 22:12:34 fedora kernel:  amdgpu_bo_create+0x401/0x4a0 [amdgpu]
Oct 20 22:12:34 fedora kernel:  ? srso_return_thunk+0x5/0x10
Oct 20 22:12:34 fedora kernel:  amdgpu_bo_create_user+0x24/0x40 [amdgpu]
Oct 20 22:12:34 fedora kernel:  amdgpu_mode_dumb_create+0xf8/0x1a0 [amdgpu]
Oct 20 22:12:34 fedora kernel:  ? drm_client_framebuffer_create+0x69/0x280 [drm]
Oct 20 22:12:34 fedora kernel:  ? __pfx_amdgpu_bo_user_destroy+0x10/0x10 [amdgpu]
Oct 20 22:12:34 fedora kernel:  drm_client_framebuffer_create+0xa3/0x280 [drm]
Oct 20 22:12:34 fedora kernel:  ? amdgpu_vm_bo_add+0x2a/0xb0 [amdgpu]
Oct 20 22:12:34 fedora kernel:  drm_fbdev_generic_helper_fb_probe+0x61/0x190 [drm_kms_helper]
Oct 20 22:12:34 fedora kernel:  __drm_fb_helper_initial_config_and_unlock+0x297/0x500 [drm_kms_helper]
Oct 20 22:12:34 fedora kernel:  drm_fbdev_generic_client_hotplug+0x66/0xb0 [drm_kms_helper]
Oct 20 22:12:34 fedora kernel:  drm_client_register+0x75/0xb0 [drm]
Oct 20 22:12:34 fedora kernel:  amdgpu_pci_probe+0x3ac/0x440 [amdgpu]
Oct 20 22:12:34 fedora kernel:  local_pci_probe+0x41/0x90
Oct 20 22:12:34 fedora kernel:  pci_device_probe+0xb3/0x210
Oct 20 22:12:34 fedora kernel:  really_probe+0x19e/0x3e0
Oct 20 22:12:34 fedora kernel:  ? __pfx___driver_attach+0x10/0x10
Oct 20 22:12:34 fedora kernel:  __driver_probe_device+0x78/0x160
Oct 20 22:12:34 fedora kernel:  driver_probe_device+0x1f/0x90
Oct 20 22:12:34 fedora kernel:  __driver_attach+0xce/0x1c0
Oct 20 22:12:34 fedora kernel:  bus_for_each_dev+0x63/0xa0
Oct 20 22:12:34 fedora kernel:  bus_add_driver+0x112/0x210
Oct 20 22:12:34 fedora kernel:  driver_register+0x55/0x100
Oct 20 22:12:34 fedora kernel:  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
Oct 20 22:12:34 fedora kernel:  do_one_initcall+0x46/0x310
Oct 20 22:12:34 fedora kernel:  ? srso_return_thunk+0x5/0x10
Oct 20 22:12:34 fedora kernel:  ? kmalloc_trace+0x26/0x90
Oct 20 22:12:34 fedora kernel:  do_init_module+0x60/0x230
Oct 20 22:12:34 fedora kernel:  init_module_from_file+0x75/0xa0
Oct 20 22:12:34 fedora kernel:  idempotent_init_module+0xf9/0x270
Oct 20 22:12:34 fedora kernel:  __x64_sys_finit_module+0x5a/0xb0
Oct 20 22:12:34 fedora kernel:  do_syscall_64+0x3b/0x90
Oct 20 22:12:34 fedora kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

It is at PCI probe time, when DRM probes for an fb dev.

> 
> 
>> +
>>   		r = drm_sched_entity_init(&adev->mman.high_pr,
>>   					  DRM_SCHED_PRIORITY_KERNEL, &sched,
>>   					  1, NULL);
> 
> That here looks totally incorrect and misplaced to me. 
> amdgpu_ttm_set_buffer_funcs_status() should only enabled/disable using 
> the copy functions and not really initialize the entity.
> 
> So the entity should only be created when enable=true and it should 
> especially *not* re-created all the time without properly destroying it.
> 
> Can you look at the history of the code? I'm pretty sure that this was 
> at some time correctly implemented.

Yeah, the drm_sched_entity_init() line above--which is not part of this
patch--comes from this commit:

commit c3aaca43fb07ce
Author: Mukul Joshi <mukul.joshi@amd.com>
Date:   Wed May 17 15:53:50 2023 -0400

    drm/amdgpu: Add a low priority scheduler for VRAM clearing
    
    Add a low priority DRM scheduler for VRAM clearing instead of using
    the exisiting high priority scheduler. Use the high priority scheduler
    for migrations and evictions.
    
    Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
    Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

The options are,

a) Revert c3aaca43fb07ce.

b) Let this patch in, so that it's not blocking the DRM dynamic sched_rq,
   and we can fix this properly in the future locally in amdgpu, as it is
   a driver issue, and it shouldn't be blocking the DRM dynamic sched_rq.
   If we had the dynamic sched_rq in before May 17 of this year, c3aaca43fb07ce
   wouldn't have been able to go in (due to oops). More details in the commit
   message of this patch above.

I'm writing this from a 6.6.0-rc6 + {DRM dynamic sched_rq patch, this patch}.

> 
> Thanks,
> Christian.
> 
>>
>> base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
>> prerequisite-patch-id: c52673df9b6fc9ee001d6261c7ac107b618912a0
> 

-- 
Regards,
Luben

