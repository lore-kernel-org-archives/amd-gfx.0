Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AFDC7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 19:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E59310E1D2;
	Mon, 24 Apr 2023 19:10:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2CFE10E1D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 19:10:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcQP/xu/x7ye+CrRn5wDSq/tqqOcQq5rS2T5EHHfsBrtbpwdgpNkmgUgGgjImXEPrha3zpSxax2f+32MfE29pLuuv0WoMdFmoT5kGXpRYI4wNvpN5txkwhXENUNgk4DBmUWdhC98/T0XA/u+TNKT9BI/0G3gRCIstI4VVECTwn24WjzXrx5b2N5U8gCrUlxJlrneFAV6uvA9WQ0/Rpe5NE2aNWFCYMDWcByT8ucXB6dqm4oIC1Wh/kZu9wZRX8NW2huXceVCx6njVZ/0TqExwy/Dazha3W5gLv3ibEMp4Mmtydr2CtrrIVZc2x4eLWDefTfohHOVifRcxUz4nNehEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5sEnu1MXoWMrCBGL32LZTIYPvHeUWIaE2gCs0614NE=;
 b=LGoJWIhcexb/Cus1ZYjKuSxaBZIu1GPODI2nvFcqzdT9XHqMxgUWT3j1vKnqgz9hp0KvMvioya+dLSxiutxmYRDH02zGZNRCJMIoZbi66s5RU7btooWt/m/mORMRH58BoUmlrs88rUYjVOJLnvgrYiJ8U1vgyUmgbE4qcr8gmltH+REb76LXIQhUN8YzYFVZNvhsxcOoho8Kln3zILlrk8Z8134GxD6L5eMbzPLKlwvaJBPvvgsccedR10IqCN+4ppNDYpeaMC/8nd3q1jPEItU37Cv3ikr3U93gCLEIX5Oo2JshabiQ3NjVK0Xx72dUaV7dvRnLttqWLkzE+pariw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5sEnu1MXoWMrCBGL32LZTIYPvHeUWIaE2gCs0614NE=;
 b=MnYcP2DQE07bugc1yjrY+kUgiMu7waD4Mx8ia8eqox+0qFLIYv9lYyRC2Bib3ybltuoLo/97vYT3qamxUlVrGLhjdFzNAs/5FnYxoIJhhsj4EsfeYaBn5THqG2yzwil+8yKtROAOfXMxGXxjJ84vlRY8E9SX5AbWhOXz1JWJRiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 19:10:02 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::296f:92cc:9525:27db]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::296f:92cc:9525:27db%6]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 19:10:02 +0000
Message-ID: <76071ed9-f552-3d1d-4708-b97936a3a6d7@amd.com>
Date: Tue, 25 Apr 2023 00:39:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/6] drm/amdgpu: Implement a new userqueue fence driver
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230420144714.124377-1-Arunpravin.PaneerSelvam@amd.com>
 <20230420144714.124377-3-Arunpravin.PaneerSelvam@amd.com>
 <40ef0a99-d159-d3ec-848f-efab6e702b56@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <40ef0a99-d159-d3ec-848f-efab6e702b56@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 973151b1-2e26-4918-9057-08db44f780f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZXMF1GuSKWHAJfJaxCxPeUYPkHUtjePL49j1cjDHSrA4ZCJuogQE1P8ibruAtyWc+a0E2eWO8NDrGahVAlMH+qasPgxYUQ77VArqA63k9D+J4ehF2PQe8Plywkuntilfo72fO674ZEt8I25qoTGODqVqD5Zx2WcWhpoWkVZig4wRLMDpwEWXFUkgCcXmAsiSTq/4XFDAHqPlqFKzHFQCyXZvV7Y9fRcOkNyhb5jBQ7FcTDwA8FbR5reZYeNilixaHFNvOH5LkYmhhyy7NUn0AKmkImuqoUudCEQwtntID+0BIRHVfCtxdnaG7abhk9ncuwUAPIw3JpuWdeb7vIO7Jl2kLmU+N9MeIVhKyx5B3CYp0E7NTi6n+Ef+zzZLuZECsNAcb950Gy7ZJVJkmmZbqAIpWA2PfTfMIcV9WUd4FDaHbaduYUUiVGf+1osfmblgPgw9J6qS3ArQwrmuheiAeNPopNp96v4xU9XKIdiNAFShKtbr/myX7upYspp7v118A7wQbrb8U4P92U2Ae78BDtEvIHxDw5+FT+h24rQHtoqJ5SvQrh9mrDFA2mqPsLHMFeDYqdMKIkcbn2gMlWeuEtZy/ZGPvVp0/krH5W+Cqgm7iRL0L7LBvZfWb3l8aWBB8ilwmHwS6mickce+niU+1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(36756003)(8676002)(8936002)(66899021)(478600001)(66476007)(66556008)(4326008)(66946007)(316002)(41300700001)(30864003)(2906002)(38100700002)(5660300002)(2616005)(86362001)(186003)(26005)(6506007)(6512007)(31686004)(53546011)(31696002)(6486002)(6666004)(83380400001)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGdtTm1qTlZ4UmlKSkRpbjZoazZGZ1JnbnNkTUNxVWJVTWNaRkxkY3I5YXU4?=
 =?utf-8?B?cWhNYk0rYm1qT0RuaHlFQzFuODB0THFQT2dzOFJRUmxTT21ma1Rkc3RYRGZ3?=
 =?utf-8?B?dFphZENXVUhJbWtHRlVhSWduQksvOUhwd3pia0Q1dnRBbjh0OS82emhrOWJ1?=
 =?utf-8?B?dng3N2VONnZCN0NFVDJ4bkh0Mm42RGc5djNZM0NVU1Bma2hDSFZOaUFXbzNm?=
 =?utf-8?B?Zk0vNlNVeHd3T00rVHVQZCtlR1hpQ2trSFBoRGU5cUdScENIallmc20vYWtS?=
 =?utf-8?B?VmVya1Q0VENsSmVXOW50Ky9nYSs5dGMzUnBwVHRoZHl6ZGpzMnowUzk4Wlgx?=
 =?utf-8?B?T0x1VWdkN2pEY09CczZJQ3d2ZlFRSWdLOE9CL3BMbUI1Q29tbVhpUi9LYVVu?=
 =?utf-8?B?NE9NVVNJblhIa3dwRWZDU3ZKaHJNRTdFQm5nMENaWnpjSThZcTNkSVQxMUky?=
 =?utf-8?B?b1poUmxlSHo0QUZFcG0vSTl3NzJmZHQ1MlYzcUR5QXc0eUt0cnFvZ1l0WnNm?=
 =?utf-8?B?RzJKTGdkUkNXbTBOZngzL0VUakh0SXNHRzJxSW9vM245VGZ0amVXL3JDdktY?=
 =?utf-8?B?Y1ptNVFPY3VmRVJSZFlzU2ZkTXR2L0locnpiVmZNNWt2bVhyTVowT0U0dlZH?=
 =?utf-8?B?SlhVdHVMVUFsaHYydGt2OURid2Q0eVFyUXgwSTBNanBCaDdZaDRpQVJDT090?=
 =?utf-8?B?N081M2M2VnI4UHdSeHErcDBDUjRCK1FyZnhIT3lIbk41YzduM1dIZ3FEVlkx?=
 =?utf-8?B?SmVmNWZuSE04R2ZqakJPQXJIWVkwSmhXcnBTLzJzT3FNSzFwRVJCYmdKeU1r?=
 =?utf-8?B?NjhHMjlhYTM4RG5hOSthbWY0M2hHaGhLU1paQ1N1TW5lMHFBU3RqWGpWVFhX?=
 =?utf-8?B?aVl4Q2RkUU9ZUElsMmI0U2FZTE5TMWYzUTBUc3Uwb042K2dUenBnYi9leUlW?=
 =?utf-8?B?RjZPaUE3alpMeGtiVTFvbHNhVzlMTjh5SS9tdkI1Z0w4T0lZM0tMbC8xNVJl?=
 =?utf-8?B?U1ZUNU5EL3k0Wmx5Y3paUVNwcVlNcjNsS1FTV05kdEVkY21SRGdHV2RSMlRJ?=
 =?utf-8?B?NEZpY1dmb0xXLzRsdGF1NHhjUEJZK2RETHNmN2xGQzV5T3loL0FOdWg3K0ZJ?=
 =?utf-8?B?ZE4rWUFrY3RJQXpya0hMeExncXhPdHdUNHJzV2FPb0tydmRnZGpHOU9LdEgr?=
 =?utf-8?B?RXcxcE1kM1l3QStTNi9rSTVZRnZLQm9KNEYvMFM3VmNmaVYvQ3VSKzdtdmlK?=
 =?utf-8?B?YzNtRFFVbWthWkdLQ3VORzZGeDBhSUpORFN3RzBWbWNxcGs3cGUrYXI1V1Iy?=
 =?utf-8?B?cDM1TUFqYTFLcEZBSFRqaDkxYWdpck45Z09oSkVtZC93ejFaUHdaaWd0NllY?=
 =?utf-8?B?ZE1kTUlqUGRhRmk3NEh4UlNhM1l1QkZVRlRRMVhXOFJmdFBiNW9HV3kvZkxX?=
 =?utf-8?B?aG9LcUgwYVJYUllxMFFsVTVSdklQRXhxZHRuRVhMZUJoWkJoUERiYlFpL2ZU?=
 =?utf-8?B?VGpRMWZOVXFIM3phbjdUMlByL3FkSlhTVDFDbm1ueHkycDUxV2JWbzZuK0cv?=
 =?utf-8?B?MUtGU1ZOY2I4RWhUV1I4UXMwTnRhR0hCUm1nYkRrWUJjWEJHZldCbGEwdUt3?=
 =?utf-8?B?Y3c4bTVucmdiUUJBSGZhbXBKWWxxekdUQlp3RVViNy81TjY3akZHTk54Z28x?=
 =?utf-8?B?V0RMVG1IbyszQy9HY2w1ZGJjRkFVSmtHVGFLTmNtNTVZb09SR0MzOW8vLzVM?=
 =?utf-8?B?QVV4TWxNUVdaUHJMRlg1Q3pJcU83QzErdFBLYWVpTEQwbG0yR0l4U21zaDh1?=
 =?utf-8?B?eEZkNEZVVzVkdmFoaXBlS2NpVHlXMG9mWVlQMVBOcmpYUE5XTzBVMGJRcXBk?=
 =?utf-8?B?WDRaVVZiTVBKRWtyTWdVeExhcTVIbUtRbTFRbHhjb05qb3NtN3dEZ0hsUHNC?=
 =?utf-8?B?VUt4YkMwc0pLSUl4NWFsTElqdm90Vk9QcjFBU0ExcmI5c1dpdUloVUF1dVZn?=
 =?utf-8?B?cTVFNCtGKy9vRVZ6ZHJUcklDanhGRWZUSWlRcVlaYXlwZndIcjcrdGJyaEhJ?=
 =?utf-8?B?ZEtCOEJXMGk5MVZqd2xEOWhVVXVXTWd3Tm5GM2VGYkRJY0xWaHVRZ2NqRVlw?=
 =?utf-8?Q?pdu3sh61TR63mRpuJfr6p+oAp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973151b1-2e26-4918-9057-08db44f780f0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 19:10:02.0317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSQSnJvJffh+Tcj9Nf3qyzwyGcesucOK9CIFMjD6e9lJJBwi+mcRmw8q3CMVZm8gdV3bxKvi3iX/vagbwgWyPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/21/2023 6:07 PM, Christian König wrote:
> Am 20.04.23 um 16:47 schrieb Arunpravin Paneer Selvam:
>> Developed a userqueue fence driver for the userqueue process shared
>> BO synchronization.
>>
>> Create a dma fence having write pointer as the seqno and allocate a
>> seq64 memory for each user queue process and feed this memory address
>> into the firmware/hardware, thus the firmware writes the read pointer
>> into the given address when the process completes it execution.
>> Compare wptr and rptr, if rptr >= wptr, signal the fences for the 
>> waiting
>> process to consume the buffers.
>>
>> v2: Worked on review comments from Christian for the following
>>      modifications
>>
>>      - Add wptr as sequence number into the fence
>>      - Add a reference count for the fence driver
>>      - Add dma_fence_put below the list_del as it might frees the 
>> userq fence.
>>      - Trim unnecessary code in interrupt handler.
>>      - Check dma fence signaled state in dma fence creation function 
>> for a
>>        potential problem of hardware completing the job processing 
>> beforehand.
>>      - Add necessary locks.
>>      - Create a list and process all the unsignaled fences.
>>      - clean up fences in destroy function.
>>      - implement .signaled callback function
>>
>> v3: Worked on review comments from Christian
>>      - Modify naming convention for reference counted objects
>>      - Fix fence driver reference drop issue
>>      - Drop amdgpu_userq_fence_driver_process() function return value
>
> That looks really good, just two more comments below.
>
>>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   build.sh                                      |  11 +
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   6 +
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 253 ++++++++++++++++++
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  64 +++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  19 ++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   1 +
>>   7 files changed, 355 insertions(+), 1 deletion(-)
>>   create mode 100755 build.sh
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>
>> diff --git a/build.sh b/build.sh
>> new file mode 100755
>> index 000000000000..fddaff75dd2a
>> --- /dev/null
>> +++ b/build.sh
>> @@ -0,0 +1,11 @@
>> +#make -j16 modules M=drivers/gpu/drm/
>> +#make -j16 modules M=drivers/gpu/drm/selftests/
>> +make -j16 modules M=drivers/gpu/drm/amd/amdgpu/
>> +#make -j16 modules M=drivers/gpu/drm/ttm/
>> +#cp drivers/gpu/drm/drm.ko /lib/modules/$(uname 
>> -r)/kernel/drivers/gpu/drm/
>> +#cp drivers/gpu/drm/selftests/test-drm_buddy.ko /lib/modules/$(uname 
>> -r)/kernel/drivers/gpu/drm/selftests/
>> +#cp drivers/gpu/drm/amd/amdgpu/amdgpu.ko /lib/modules/$(uname 
>> -r)/kernel/drivers/gpu/drm/amd/amdgpu/
>> +#cp drivers/gpu/drm/ttm/ttm.ko /lib/modules/$(uname 
>> -r)/kernel/drivers/gpu/drm/ttm/
>> +#update-initramfs -c -k $(uname -r)
>> +#reboot
>> +
>
> I strongly assume you didn't intentionally committed that, did you?
>
> Anyway, please remove :)

I committed this script by mistake :D I will remove it
>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index d39504e65db1..8ed9be0d4818 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -59,7 +59,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o 
>> amdgpu_kms.o \
>>       amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>>       amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>>       amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>> -    amdgpu_ring_mux.o amdgpu_seq64.o
>> +    amdgpu_ring_mux.o amdgpu_seq64.o amdgpu_userq_fence.o
>>     amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 229976a2d0e7..e9c5047087d0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -53,6 +53,7 @@
>>   #include "amdgpu_xgmi.h"
>>   #include "amdgpu_reset.h"
>>   #include "amdgpu_userqueue.h"
>> +#include "amdgpu_userq_fence.h"
>>     /*
>>    * KMS wrapper.
>> @@ -2826,6 +2827,10 @@ static int __init amdgpu_init(void)
>>       if (r)
>>           goto error_fence;
>>   +    r = amdgpu_userq_fence_slab_init();
>> +    if (r)
>> +        goto error_fence;
>> +
>>       DRM_INFO("amdgpu kernel modesetting enabled.\n");
>>       amdgpu_register_atpx_handler();
>>       amdgpu_acpi_detect();
>> @@ -2850,6 +2855,7 @@ static void __exit amdgpu_exit(void)
>>       amdgpu_unregister_atpx_handler();
>>       amdgpu_sync_fini();
>>       amdgpu_fence_slab_fini();
>> +    amdgpu_userq_fence_slab_fini();
>>       mmu_notifier_synchronize();
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> new file mode 100644
>> index 000000000000..a03d12f83147
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -0,0 +1,253 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include <linux/kref.h>
>> +#include <linux/slab.h>
>> +
>> +#include <drm/drm_syncobj.h>
>> +
>> +#include "amdgpu.h"
>> +#include "amdgpu_userq_fence.h"
>> +
>> +static struct kmem_cache *amdgpu_userq_fence_slab;
>> +
>> +int amdgpu_userq_fence_slab_init(void)
>> +{
>> +    amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
>> +                            sizeof(struct amdgpu_userq_fence),
>> +                            0,
>> +                            SLAB_HWCACHE_ALIGN,
>> +                            NULL);
>> +    if (!amdgpu_userq_fence_slab)
>> +        return -ENOMEM;
>> +
>> +    return 0;
>> +}
>> +
>> +void amdgpu_userq_fence_slab_fini(void)
>> +{
>> +    rcu_barrier();
>> +    kmem_cache_destroy(amdgpu_userq_fence_slab);
>> +}
>> +
>> +static inline struct amdgpu_userq_fence 
>> *to_amdgpu_userq_fence(struct dma_fence *f)
>> +{
>> +    struct amdgpu_userq_fence *__f = container_of(f, struct 
>> amdgpu_userq_fence, base);
>> +
>> +    if (!__f)
>> +        return NULL;
>> +
>> +    if (__f->base.ops == &amdgpu_userq_fence_ops)
>> +        return __f;
>> +
>> +    return NULL;
>> +}
>> +
>> +static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver 
>> *fence_drv)
>> +{
>> +    return le64_to_cpu(*fence_drv->cpu_addr);
>> +}
>> +
>> +int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>> +                    struct amdgpu_usermode_queue *userq)
>> +{
>> +    struct amdgpu_userq_fence_driver *fence_drv;
>> +    int r;
>> +
>> +    fence_drv = userq->fence_drv;
>> +    if (!fence_drv)
>> +        return -EINVAL;
>> +
>> +    /* Acquire seq64 memory */
>> +    r = amdgpu_seq64_get(adev, &fence_drv->gpu_addr,
>> +                 &fence_drv->cpu_addr);
>> +    if (r)
>> +        return -ENOMEM;
>> +
>> +    kref_init(&fence_drv->refcount);
>> +    INIT_LIST_HEAD(&fence_drv->fences);
>> +    spin_lock_init(&fence_drv->fence_list_lock);
>> +
>> +    fence_drv->adev = adev;
>> +    fence_drv->context = dma_fence_context_alloc(1);
>> +
>> +    get_task_comm(fence_drv->timeline_name, current);
>> +
>> +    return 0;
>> +}
>> +
>> +void amdgpu_userq_fence_driver_process(struct 
>> amdgpu_userq_fence_driver *fence_drv)
>> +{
>> +    struct amdgpu_userq_fence *userq_fence, *tmp;
>> +    struct dma_fence *fence;
>> +
>> +    if (!fence_drv)
>> +        return;
>> +
>> +    spin_lock(&fence_drv->fence_list_lock);
>> +    list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, 
>> link) {
>> +        fence = &userq_fence->base;
>> +
>> +        if (amdgpu_userq_fence_read(fence_drv) >= fence->seqno) {
>> +            dma_fence_signal(fence);
>> +            list_del(&userq_fence->link);
>> +
>> +            dma_fence_put(fence);
>> +        } else {
>> +            break;
>> +        }
>> +    }
>> +    spin_unlock(&fence_drv->fence_list_lock);
>> +}
>> +
>> +void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>> +{
>> +    struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
>> +                     struct amdgpu_userq_fence_driver,
>> +                     refcount);
>> +    struct amdgpu_device *adev = fence_drv->adev;
>> +    struct amdgpu_userq_fence *fence, *tmp;
>> +    struct dma_fence *f;
>> +
>> +    spin_lock(&fence_drv->fence_list_lock);
>> +    list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
>> +        f = &fence->base;
>> +
>> +        if (!dma_fence_is_signaled(f)) {
>> +            dma_fence_set_error(f, -ECANCELED);
>> +            dma_fence_signal(f);
>> +        }
>> +
>> +        list_del(&fence->link);
>> +        dma_fence_put(f);
>> +    }
>> +
>> +    WARN_ON_ONCE(!list_empty(&fence_drv->fences));
>> +    spin_unlock(&fence_drv->fence_list_lock);
>> +
>> +    /* Free seq64 memory */
>> +    amdgpu_seq64_free(adev, fence_drv->gpu_addr);
>> +    kfree(fence_drv);
>> +}
>> +
>> +void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver 
>> *fence_drv)
>> +{
>> +    kref_get(&fence_drv->refcount);
>> +}
>> +
>> +void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver 
>> *fence_drv)
>> +{
>> +    kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy);
>> +}
>> +
>> +int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>> +                  u64 seq, struct dma_fence **f)
>> +{
>> +    struct amdgpu_userq_fence_driver *fence_drv;
>> +    struct amdgpu_userq_fence *userq_fence;
>> +    struct dma_fence *fence;
>> +
>> +    fence_drv = userq->fence_drv;
>> +    if (!fence_drv)
>> +        return -EINVAL;
>> +
>> +    userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, 
>> GFP_ATOMIC);
>> +    if (!userq_fence)
>> +        return -ENOMEM;
>> +
>> +    spin_lock_init(&userq_fence->lock);
>> +    INIT_LIST_HEAD(&userq_fence->link);
>> +    fence = &userq_fence->base;
>> +    userq_fence->fence_drv = fence_drv;
>> +
>> +    dma_fence_init(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
>> +               fence_drv->context, seq);
>> +
>> +    amdgpu_userq_fence_driver_get(fence_drv);
>> +    dma_fence_get(fence);
>> +
>> +    spin_lock(&fence_drv->fence_list_lock);
>> +    /* Check if hardware has already processed the job */
>> +    if (!dma_fence_is_signaled(fence)) {
>> +        list_add_tail(&userq_fence->link, &fence_drv->fences);
>> +    } else {
>> +        dma_fence_put(fence);
>> +    }
>> +    spin_unlock(&fence_drv->fence_list_lock);
>> +
>> +    *f = fence;
>> +
>> +    return 0;
>> +}
>> +
>> +static const char *amdgpu_userq_fence_get_driver_name(struct 
>> dma_fence *f)
>> +{
>> +    return "amdgpu_userqueue_fence";
>> +}
>> +
>> +static const char *amdgpu_userq_fence_get_timeline_name(struct 
>> dma_fence *f)
>> +{
>> +    struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
>> +
>> +    return fence->fence_drv->timeline_name;
>> +}
>> +
>> +static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
>> +{
>> +    struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
>> +    struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
>> +    u64 rptr, wptr;
>> +
>> +    rptr = amdgpu_userq_fence_read(fence_drv);
>> +    wptr = fence->base.seqno;
>> +
>> +    if (rptr >= wptr)
>> +        return true;
>> +
>> +    return false;
>> +}
>> +
>> +static void amdgpu_userq_fence_free(struct rcu_head *rcu)
>> +{
>> +    struct dma_fence *fence = container_of(rcu, struct dma_fence, rcu);
>> +    struct amdgpu_userq_fence *userq_fence = 
>> to_amdgpu_userq_fence(fence);
>> +    struct amdgpu_userq_fence_driver *fence_drv = 
>> userq_fence->fence_drv;
>> +
>> +    /* Release the fence driver reference */
>> +    amdgpu_userq_fence_driver_put(fence_drv);
>> +    kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>> +}
>> +
>> +static void amdgpu_userq_fence_release(struct dma_fence *f)
>> +{
>> +    call_rcu(&f->rcu, amdgpu_userq_fence_free);
>> +}
>> +
>> +static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>> +    .use_64bit_seqno = true,
>> +    .get_driver_name = amdgpu_userq_fence_get_driver_name,
>> +    .get_timeline_name = amdgpu_userq_fence_get_timeline_name,
>> +    .signaled = amdgpu_userq_fence_signaled,
>> +    .release = amdgpu_userq_fence_release,
>> +};
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>> new file mode 100644
>> index 000000000000..7329b4e5dd30
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>> @@ -0,0 +1,64 @@
>> +/* SPDX-License-Identifier: MIT */
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef __AMDGPU_USERQ_FENCE_H__
>> +#define __AMDGPU_USERQ_FENCE_H__
>> +
>> +#include <linux/types.h>
>> +
>> +#include "amdgpu_userqueue.h"
>> +
>> +struct amdgpu_userq_fence {
>> +    struct dma_fence base;
>> +    /* userq fence lock */
>> +    spinlock_t lock;
>
> This one.
>
>> +    struct list_head link;
>> +    struct amdgpu_userq_fence_driver *fence_drv;
>> +};
>> +
>> +struct amdgpu_userq_fence_driver {
>> +    struct kref refcount;
>> +    u64 gpu_addr;
>> +    u64 *cpu_addr;
>> +    u64 context;
>> +    /* fence list lock */
>> +    spinlock_t fence_list_lock;
>
> And that one here should have better documentation.
>
> It's obvious what they are, so the existing doc doesn't help at all.
>
> What you need to document is why they are separate.
I will add the required documentation.
>
>> +    struct list_head fences;
>> +    struct amdgpu_device *adev;
>> +    char timeline_name[TASK_COMM_LEN];
>> +};
>> +
>> +static const struct dma_fence_ops amdgpu_userq_fence_ops;
>> +
>> +int amdgpu_userq_fence_slab_init(void);
>> +void amdgpu_userq_fence_slab_fini(void);
>> +int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>> +                  u64 seq, struct dma_fence **f);
>> +void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver 
>> *fence_drv);
>> +void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver 
>> *fence_drv);
>> +int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev, 
>> struct amdgpu_usermode_queue *userq);
>> +void amdgpu_userq_fence_driver_process(struct 
>> amdgpu_userq_fence_driver *fence_drv);
>> +void amdgpu_userq_fence_driver_destroy(struct kref *ref);
>> +
>> +#endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index fd4a2ca3302d..8918b176fdcb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -24,6 +24,7 @@
>>   #include "amdgpu.h"
>>   #include "amdgpu_vm.h"
>>   #include "amdgpu_userqueue.h"
>> +#include "amdgpu_userq_fence.h"
>>     static inline int
>>   amdgpu_userqueue_index(struct amdgpu_userq_mgr *uq_mgr, struct 
>> amdgpu_usermode_queue *queue)
>> @@ -158,6 +159,8 @@ static int amdgpu_userqueue_create(struct 
>> drm_file *filp, union drm_amdgpu_userq
>>       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>       struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>>       struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
>> +    struct amdgpu_userq_fence_driver *fence_drv;
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>       uint64_t index;
>>       int r;
>>   @@ -173,6 +176,12 @@ static int amdgpu_userqueue_create(struct 
>> drm_file *filp, union drm_amdgpu_userq
>>           return -ENOMEM;
>>       }
>>   +    fence_drv = kzalloc(sizeof(struct amdgpu_userq_fence_driver), 
>> GFP_KERNEL);
>> +    if (!fence_drv) {
>> +        DRM_ERROR("Failed to allocate memory for fence driver\n");
>> +        return -ENOMEM;
>> +    }
>> +
>
> Why don't we have this kzalloc() inside 
> amdgpu_userq_fence_driver_alloc() ?
Christian.

That's better. I moved kzalloc() inside amdgpu_userq_fence_driver_alloc().

Thanks,
Arun
>
>
>
>> mutex_lock(&uq_mgr->userq_mutex);
>>       queue->userq_prop.wptr_gpu_addr = mqd_in->wptr_va;
>>       queue->userq_prop.rptr_gpu_addr = mqd_in->rptr_va;
>> @@ -188,6 +197,13 @@ static int amdgpu_userqueue_create(struct 
>> drm_file *filp, union drm_amdgpu_userq
>>           goto free_queue;
>>       }
>>   +    queue->fence_drv = fence_drv;
>> +    r = amdgpu_userq_fence_driver_alloc(adev, queue);
>> +    if (r) {
>> +        DRM_ERROR("Failed to alloc fence driver\n");
>> +        goto free_fence_drv;
>> +    }
>> +
>>       queue->userq_prop.doorbell_index = index;
>>       queue->shadow_ctx_gpu_addr = mqd_in->shadow_va;
>>       queue->queue_type = mqd_in->ip_type;
>> @@ -217,6 +233,8 @@ static int amdgpu_userqueue_create(struct 
>> drm_file *filp, union drm_amdgpu_userq
>>       mutex_unlock(&uq_mgr->userq_mutex);
>>       return 0;
>>   +free_fence_drv:
>> +    amdgpu_userq_fence_driver_put(queue->fence_drv);
>>   free_queue:
>>       mutex_unlock(&uq_mgr->userq_mutex);
>>       kfree(queue);
>> @@ -238,6 +256,7 @@ static void amdgpu_userqueue_destroy(struct 
>> drm_file *filp, int queue_id)
>>       mutex_lock(&uq_mgr->userq_mutex);
>> uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
>>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>> +    amdgpu_userq_fence_driver_put(queue->fence_drv);
>>       mutex_unlock(&uq_mgr->userq_mutex);
>>       kfree(queue);
>>   }
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index eaab7cf5fff6..eaea88539007 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -50,6 +50,7 @@ struct amdgpu_usermode_queue {
>>       struct amdgpu_mqd_prop userq_prop;
>>       struct amdgpu_userq_ctx_space mqd;
>>       struct amdgpu_userq_ctx_space fw_space;
>> +    struct amdgpu_userq_fence_driver *fence_drv;
>>   };
>>     struct amdgpu_userq_funcs {
>

