Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB7FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 07:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E0A961164
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 07:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E0A961164
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D566189F99;
	Wed,  8 Sep 2021 07:36:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F1F389F99
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 07:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWqeb1WIHTeGKn4tvpC1GexqfSuDS0/pG8LIOqz0iSQbMqsHB2HZ4WS9xUc12HvY34CI5w3G2doLfcBmOFLSFD5Hi9ZY7EUuKjKngU+A7lgHoGQg16MdkogAIKQetXL68UbMKdOpnWwx4CZ/JeK0Y9eOIQAbIzqajYdIV2WUrY2g5B/frViKN04og/bwDUj3lhEtLGy4vNdk/lmPbzhb9AWfmTEyBNwJHZR+NdQIfkuDVqvHc7lcPmJof+sdPQ9om+yv44ThKYMN8d8lcchessy0pMlGtTvd+m7durSoT4tey78i4WKTFoTXu5cmDZ1wTgM16p9yWHvXEx7kd9XM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=2gcYVI4YXpf5IIS7CU5AvEP77/Qut+q+v0khma4DIOo=;
 b=h/7fh1qDKP8eu67ifUhQssZF8KIp+LJ3Ii44Pe6pIOuZrxNjk5Oy//B/tJcb8CfZdVzJ4BqYJyKqwFu6uXfBqnr+oWqYcUOyy7uQK3FT9/LMgA1CmsfPr8nZdFxk0ZRBB8eS/WVarADSVcvzFITsMG8E1ug5lJv/iVf5Ynb48a1KzcCrNXDj8AQEBpAndzWdyig+3XgUli9/xp7p6Iw+H2KqMT60kvb8IgZGEsGbpnTuJ9/r8oUpWPfnA6hHPuNNvjbY/DJ/E7IC4UEabTsVSBneGZphG6aQlc5SwfS/6Jc93Znvxr1d7pnD/EJbyNNrs7C4i4eu5ACY2LgzVcmT7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gcYVI4YXpf5IIS7CU5AvEP77/Qut+q+v0khma4DIOo=;
 b=4kW1YJ9NdjM/Y02Y8CSFhv9spXFbZS6s/hSPnDP9hnP5qNzs0qdY0E/S2KDMHBdWf11CKVmt6pvRF2B/JXf/eHNaPbLotfPcOtSFNt8qRSizMhbdU9xW46R2kIaUMu+RsuBdfkGgJ5omc2bZZ1xM80C6uwJm0BxBOc7Lsswysw4=
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5100.namprd12.prod.outlook.com (2603:10b6:408:119::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 07:36:39 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed%9]) with mapi id 15.20.4415.022; Wed, 8 Sep 2021
 07:36:39 +0000
Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Tian Tao <tiantao6@hisilicon.com>
References: <20210908055615.3781901-1-lang.yu@amd.com>
 <e8b39f62-ca0c-d4e0-92a9-52487fa0da81@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <47ed143e-b9ab-a80e-dac0-cfa1ec39d033@amd.com>
Date: Wed, 8 Sep 2021 13:06:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <e8b39f62-ca0c-d4e0-92a9-52487fa0da81@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::28) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 BM1PR0101CA0042.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 07:36:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1ee0204-c666-491e-a231-08d9729b651a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5100:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5100522059A6EBE57161654B97D49@BN9PR12MB5100.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3g6DD9rUSMekrEjQJOyYBtQtYWxW3ltYzq3cN7c1FCjccyJO2LyyQxC1DizuHuiT+7QqH5EIay6SdwGr0yrDpAB3qGcqKW+ZdWPPA/zGzTaiugo6N/jOqq3wSjrJ5p8YCQjWP5T/8mE3KssQgFr6pGJjxnMlj34P3LOA9FJ4He2GJkAnrdEYPZLvMGcr0d9+IER448/LDOYba4okPc9bXvwOAgkLVnd4cJA+ROD2iGflhXwjNtwPU5uIRD4PvxHaWvtmZAk6f6WkZNHHUauBzmaAsH6f/7J1aDHpeWY0fMtWVJ3dpN0mXv6ufSS9GtJhrV70yD6FEvG9vh7+7hwDcXFDP5URpfmu33VkTXfeGkydTpZ8hUcwB3dKHw/3+mRPaAS1QfgwmUqqcnBdwAyRJUiogvMWcfA3rolG/LEMtM0D47K/cBat8ZJ7IiepJcB+AeGmryidHiUwZVltcWtFM9P+iKKf7bXY2OoBMhJc0XLEVqw7tBValVFUD/Q2EOD8GRQsmDSSu0y6fOCXzpMTm+xO91J3GVI5YSC5HXjzHHBXlyFmgj6yu/3EUEG8xnSPgF2lQsoWXSUugLG8ykM0GQCpj0czUibv/pQmo8RqxqifHICBo8sZIoZgZmSJD/1H6QIRyZuNPIRdcMEJKxaX+UV9gP0E7A0sQZYSYObh4Vq36ZnPH5fiJAMmHN9MlUkGljENQtHOUPfJ0+u+xQ54GKY3uvlZ8XL0NmHKrAU5pq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(31696002)(36756003)(53546011)(316002)(31686004)(38100700002)(83380400001)(66574015)(4326008)(2616005)(956004)(66476007)(66946007)(26005)(66556008)(30864003)(5660300002)(6666004)(2906002)(86362001)(478600001)(6486002)(8936002)(54906003)(16576012)(110136005)(186003)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anIvbGtvdjR2SjJYaG9IdmUrZXBtQ3hmNVBuM2J5Vno4ankrRUdIMWVTeG9a?=
 =?utf-8?B?ZGVWNXRhWEFZS2tFMkJsUVRsbU5tV3UvL0gzL3FSSjBnNE9KaWVZWk4yVUFY?=
 =?utf-8?B?T2JuMXVMSTNnR2FQU1h5Y2RUalhWTXNxTFZxRG5QM1VycnJ1d1ljZkJZdThR?=
 =?utf-8?B?OUM5VnUzU29lMHUvOHNFeDM0aVpWTlZZMjh0aXJSTm45YkZTaWxaYTNWbldJ?=
 =?utf-8?B?ME00bjVCTzljV2xPUVl2cGdDU1BQNENrTnlyd3RJbEtTT0taekszV2hXNFdL?=
 =?utf-8?B?REF3SlZ6UmFvWExveVphUlJMUXU3Ky82NitBeUpoem1CL0dKcHQxME1tUnRr?=
 =?utf-8?B?UUhTSnl6K0p3azJJcjhwY0JFUis0YXVlSjhTd21rVUpnVStlaW1CYWgwdEtZ?=
 =?utf-8?B?elY3T0VpMFQrMXBZckRKLzNpYzFHWTNCc1VicHcySm9adnAyMzZvU01zWDJF?=
 =?utf-8?B?S2I1cHpBRW1wVWdxd2ZWZlRPckhOalhPd2ZjQVZpWDQ2QVBWaVRPYjVCTzdX?=
 =?utf-8?B?TVhadUF0YitldWRnNTJOK3pqakEwTHNINmlSWEJIY0NrNGpIYkNzL291SVhy?=
 =?utf-8?B?WU05N284TGl2N0wwOU0yQ2FXc056QmM4RHYvdGpIUTBqcS9tV0wzNDdyQmlI?=
 =?utf-8?B?NlBpMWhyNGUrM0Y3NzVrbGR4RFgvZDhDYzdGMkd0V1hkN1drSVJidVJWVWFU?=
 =?utf-8?B?Q3RXOE1xZXV1VWhDM2g4TFE4blRub0xRczlGb0JCV0ZUcjJPd2RNVThid0dU?=
 =?utf-8?B?Vnh3cnp1My9mS29ZeVRNOVYrMmYrbXJHNEtzZ1RDWUZnZ2xqakRiU0RmdERx?=
 =?utf-8?B?a0dNc3R3U3FnYjgwQlIvSnpDNGNtOUVCenNwdEJNSXMrYWpJcHNtNXdVckRE?=
 =?utf-8?B?cnpTcEVqRTlVVjdtWnJLVGJPRnErRTZnOVliRklYMnVYQ3FIYk1YeW1zbnFM?=
 =?utf-8?B?U2lxVWQyY1AyQWJYMDNkOGkycEpOK3A0Ri9OdFdMeU5UdGhzNldEVWNiTERu?=
 =?utf-8?B?Yk9yZlhJN1p2M2IzcjZnQnlGNHJPM0ZoVmJ1bktVdFg2bmt6WEw3bkFGRnp4?=
 =?utf-8?B?VGRKSTFHZVRRU3pGMHJ0VDR2a21ZU0hMWXF3MDVjSVlrOUo1b0w2S3AzbHZI?=
 =?utf-8?B?eWlsMkw2R0MzS3RsUGoxQkJpdGl4T2R0TTBFTVNiV0FxZHJQL2RCZEVpcHhF?=
 =?utf-8?B?U3FJRm1ueTFib2Z6dmVMdEVIdjNQTktqR3h3RGo1bDdXY1lVcmhUU2ZpaHZE?=
 =?utf-8?B?cmlqNFo2RWlGYUdvbGZJWkMwQ0t4U292djZWUEZ5TlR0djVMTlRlSVFpUWND?=
 =?utf-8?B?WndJazNzUUVQb2RBWjI3MnZtYjJKU0FFTG9UMFpDYXVOTHpFc29JSzhpcElZ?=
 =?utf-8?B?TmVWSEE1U09iT2RXcFB1R0RvU3V6QXFSNUlPcHExUzR2USt4NFJZM0I5aU9q?=
 =?utf-8?B?VWFIcmtJSkl1Z2ZNZ2xHYWZ4K3FraSsvMzdXcEU1V25ySTB1VmUzRk92US9t?=
 =?utf-8?B?ZkJqdDdQVDNFQ004TVhFeG42bEluQzc5K0tWWU1Ia0FaUmRPV1pSdXVsQ0Y3?=
 =?utf-8?B?MGtlcWkxMEhkOXBIM3NjK0NBVmh3TUQwaG1LMUZXQmZpZ0p4ZVZnOWsrNTFx?=
 =?utf-8?B?SmZJTGdBaFlCWVZVYU5NRkRWWjdDcXVMYkpEUjB6c1p5ekQ1bTh5YTJzNGVZ?=
 =?utf-8?B?aWJZSlhOSVdkQ1p2ZVhsaE9nUlVIcEh3ZlVxZlcrNWZodnRkM0NsNitSbXZO?=
 =?utf-8?Q?Qnotz8wKM+8bt4jqO5yMqfAd8QA+TeiDTcjm50F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ee0204-c666-491e-a231-08d9729b651a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 07:36:39.3114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPtEKNJai933dgsoKsWeUvy9vn0yRuvqz4yVKsMZ3wuJuA7vbaK2Dyly7xMpBB1+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5100
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



On 9/8/2021 12:07 PM, Christian König wrote:
> Am 08.09.21 um 07:56 schrieb Lang Yu:
>> sysfs_emit and sysfs_emit_at requrie a page boundary
>> aligned buf address. Make them happy!
>>
>> Warning Log:
>> [  492.545174] invalid sysfs_emit_at: buf:00000000f19bdfde at:0
>> [  492.546416] WARNING: CPU: 7 PID: 1304 at fs/sysfs/file.c:765 
>> sysfs_emit_at+0x4a/0xa0
>> [  492.654805] Call Trace:
>> [  492.655353]  ? smu_cmn_get_metrics_table+0x40/0x50 [amdgpu]
>> [  492.656780]  vangogh_print_clk_levels+0x369/0x410 [amdgpu]
>> [  492.658245]  vangogh_common_print_clk_levels+0x77/0x80 [amdgpu]
>> [  492.659733]  ? preempt_schedule_common+0x18/0x30
>> [  492.660713]  smu_print_ppclk_levels+0x65/0x90 [amdgpu]
>> [  492.662107]  amdgpu_get_pp_od_clk_voltage+0x13d/0x190 [amdgpu]
>> [  492.663620]  dev_attr_show+0x1d/0x40
> 
> Mhm, that at least partially doesn't looks like the right approach to me.
> 
> Why do we have string printing and sysfs code in the hardware version 
> specific backend in the first place?
> 

This is a callback meant for printing ASIC specific information to sysfs 
node. The buffer passed in sysfs read is passed as it is to the callback 
API.

> That stuff needs to be implemented for each hardware generation and is 
> now cluttered with sysfs buffer offset calculations.
> 

Looks like the warning happened because of this usage.

                 size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
                 size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, 
buf+size);
                 size += amdgpu_dpm_print_clock_levels(adev, 
OD_VDDC_CURVE, buf+size);
                 size += amdgpu_dpm_print_clock_levels(adev, 
OD_VDDGFX_OFFSET, buf+size);
                 size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE, 
buf+size);
                 size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK, 
buf+size);



> Regards,
> Christian.
> 
>>
>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  9 +++++++--
>>   drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  5 ++++-
>>   .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 ++++-
>>   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 15 +++++++++------
>>   drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  3 +++
>>   .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 13 +++++++++----
>>   .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  7 +++++--
>>   7 files changed, 41 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>> index e343cc218990..53185fe96d83 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>> @@ -771,8 +771,13 @@ static int arcturus_print_clk_levels(struct 
>> smu_context *smu,
>>       struct smu_11_0_dpm_context *dpm_context = NULL;
>>       uint32_t gen_speed, lane_width;
>> -    if (amdgpu_ras_intr_triggered())
>> -        return sysfs_emit(buf, "unavailable\n");
>> +    size = offset_in_page(buf);
>> +    buf = buf - size;
>> +
>> +    if (amdgpu_ras_intr_triggered()) {
>> +        size += sysfs_emit_at(buf, size, "unavailable\n");
>> +        return size;
>> +    }
>>       dpm_context = smu_dpm->dpm_context;
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> index 4c81989b8162..5490e8e66e14 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> @@ -1279,6 +1279,9 @@ static int navi10_print_clk_levels(struct 
>> smu_context *smu,
>>       struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
>>       uint32_t min_value, max_value;
>> +    size = offset_in_page(buf);
>> +    buf = buf - size;
>> +
>>       switch (clk_type) {
>>       case SMU_GFXCLK:
>>       case SMU_SCLK:
>> @@ -1392,7 +1395,7 @@ static int navi10_print_clk_levels(struct 
>> smu_context *smu,
>>       case SMU_OD_RANGE:
>>           if (!smu->od_enabled || !od_table || !od_settings)
>>               break;
>> -        size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
>> +        size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>>           if (navi10_od_feature_is_supported(od_settings, 
>> SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
>>               navi10_od_setting_get_range(od_settings, 
>> SMU_11_0_ODSETTING_GFXCLKFMIN,
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> index 5e292c3f5050..817ad6de3854 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> @@ -1058,6 +1058,9 @@ static int 
>> sienna_cichlid_print_clk_levels(struct smu_context *smu,
>>       uint32_t min_value, max_value;
>>       uint32_t smu_version;
>> +    size = offset_in_page(buf);
>> +    buf = buf - size;
>> +
>>       switch (clk_type) {
>>       case SMU_GFXCLK:
>>       case SMU_SCLK:
>> @@ -1180,7 +1183,7 @@ static int 
>> sienna_cichlid_print_clk_levels(struct smu_context *smu,
>>           if (!smu->od_enabled || !od_table || !od_settings)
>>               break;
>> -        size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
>> +        size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>>           if (sienna_cichlid_is_od_feature_supported(od_settings, 
>> SMU_11_0_7_ODCAP_GFXCLK_LIMITS)) {
>>               sienna_cichlid_get_od_setting_range(od_settings, 
>> SMU_11_0_7_ODSETTING_GFXCLKFMIN,
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>> index 3a3421452e57..c7842c69b570 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>> @@ -592,7 +592,7 @@ static int vangogh_print_legacy_clk_levels(struct 
>> smu_context *smu,
>>       switch (clk_type) {
>>       case SMU_OD_SCLK:
>>           if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
>> -            size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
>> +            size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
>>               size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
>>               (smu->gfx_actual_hard_min_freq > 0) ? 
>> smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
>>               size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
>> @@ -601,7 +601,7 @@ static int vangogh_print_legacy_clk_levels(struct 
>> smu_context *smu,
>>           break;
>>       case SMU_OD_CCLK:
>>           if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
>> -            size = sysfs_emit(buf, "CCLK_RANGE in Core%d:\n",  
>> smu->cpu_core_id_select);
>> +            size += sysfs_emit_at(buf, size, "CCLK_RANGE in 
>> Core%d:\n",  smu->cpu_core_id_select);
>>               size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
>>               (smu->cpu_actual_soft_min_freq > 0) ? 
>> smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
>>               size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
>> @@ -610,7 +610,7 @@ static int vangogh_print_legacy_clk_levels(struct 
>> smu_context *smu,
>>           break;
>>       case SMU_OD_RANGE:
>>           if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
>> -            size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
>> +            size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>>               size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
>>                   smu->gfx_default_hard_min_freq, 
>> smu->gfx_default_soft_max_freq);
>>               size += sysfs_emit_at(buf, size, "CCLK: %7uMhz %10uMhz\n",
>> @@ -682,6 +682,9 @@ static int vangogh_print_clk_levels(struct 
>> smu_context *smu,
>>       uint32_t cur_value = 0, value = 0, count = 0;
>>       bool cur_value_match_level = false;
>> +    size = offset_in_page(buf);
>> +    buf = buf - size;
>> +
>>       memset(&metrics, 0, sizeof(metrics));
>>       ret = smu_cmn_get_metrics_table(smu, &metrics, false);
>> @@ -691,7 +694,7 @@ static int vangogh_print_clk_levels(struct 
>> smu_context *smu,
>>       switch (clk_type) {
>>       case SMU_OD_SCLK:
>>           if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
>> -            size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
>> +            size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
>>               size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
>>               (smu->gfx_actual_hard_min_freq > 0) ? 
>> smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
>>               size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
>> @@ -700,7 +703,7 @@ static int vangogh_print_clk_levels(struct 
>> smu_context *smu,
>>           break;
>>       case SMU_OD_CCLK:
>>           if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
>> -            size = sysfs_emit(buf, "CCLK_RANGE in Core%d:\n",  
>> smu->cpu_core_id_select);
>> +            size += sysfs_emit_at(buf, size, "CCLK_RANGE in 
>> Core%d:\n",  smu->cpu_core_id_select);
>>               size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
>>               (smu->cpu_actual_soft_min_freq > 0) ? 
>> smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
>>               size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
>> @@ -709,7 +712,7 @@ static int vangogh_print_clk_levels(struct 
>> smu_context *smu,
>>           break;
>>       case SMU_OD_RANGE:
>>           if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
>> -            size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
>> +            size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>>               size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
>>                   smu->gfx_default_hard_min_freq, 
>> smu->gfx_default_soft_max_freq);
>>               size += sysfs_emit_at(buf, size, "CCLK: %7uMhz %10uMhz\n",
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>> index 5aa175e12a78..86e7978b6d63 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>> @@ -491,6 +491,9 @@ static int renoir_print_clk_levels(struct 
>> smu_context *smu,
>>       struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>>       bool cur_value_match_level = false;
>> +    size = offset_in_page(buf);
>> +    buf = buf - size;
>> +
>>       memset(&metrics, 0, sizeof(metrics));
>>       ret = smu_cmn_get_metrics_table(smu, &metrics, false);
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>> index ab652028e003..6349f27e9efc 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>> @@ -733,15 +733,20 @@ static int aldebaran_print_clk_levels(struct 
>> smu_context *smu,
>>       uint32_t freq_values[3] = {0};
>>       uint32_t min_clk, max_clk;
>> -    if (amdgpu_ras_intr_triggered())
>> -        return sysfs_emit(buf, "unavailable\n");
>> +    size = offset_in_page(buf);
>> +    buf = buf - size;
>> +
>> +    if (amdgpu_ras_intr_triggered()) {
>> +        size += sysfs_emit_at(buf, size, "unavailable\n");
>> +        return size;
>> +    }
>>       dpm_context = smu_dpm->dpm_context;
>>       switch (type) {
>>       case SMU_OD_SCLK:
>> -        size = sysfs_emit(buf, "%s:\n", "GFXCLK");
>> +        size += sysfs_emit_at(buf, size, "%s:\n", "GFXCLK");
>>           fallthrough;
>>       case SMU_SCLK:
>>           ret = aldebaran_get_current_clk_freq_by_table(smu, 
>> SMU_GFXCLK, &now);
>> @@ -795,7 +800,7 @@ static int aldebaran_print_clk_levels(struct 
>> smu_context *smu,
>>           break;
>>       case SMU_OD_MCLK:
>> -        size = sysfs_emit(buf, "%s:\n", "MCLK");
>> +        size += sysfs_emit_at(buf, size, "%s:\n", "MCLK");
>>           fallthrough;
>>       case SMU_MCLK:
>>           ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_UCLK, 
>> &now);
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>> index 627ba2eec7fd..3b21d9143b96 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>> @@ -1052,16 +1052,19 @@ static int yellow_carp_print_clk_levels(struct 
>> smu_context *smu,
>>       int i, size = 0, ret = 0;
>>       uint32_t cur_value = 0, value = 0, count = 0;
>> +    size = offset_in_page(buf);
>> +    buf = buf - size;
>> +
>>       switch (clk_type) {
>>       case SMU_OD_SCLK:
>> -        size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
>> +        size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
>>           size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
>>           (smu->gfx_actual_hard_min_freq > 0) ? 
>> smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
>>           size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
>>           (smu->gfx_actual_soft_max_freq > 0) ? 
>> smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
>>           break;
>>       case SMU_OD_RANGE:
>> -        size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
>> +        size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
>>           size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
>>                           smu->gfx_default_hard_min_freq, 
>> smu->gfx_default_soft_max_freq);
>>           break;
> 
