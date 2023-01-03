Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC75C3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 09:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F8710E1B1;
	Tue,  3 Jan 2023 09:16:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB6F10E1B1
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 09:16:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4C5dZm3unpIySVi9aYETykNaZO6ezmXiOASOUmodR2Vpm4ozjvXZqTwzE2GyPVk6Dj2swRKuGtO3fyokO7PfcNH7wGC8b8Npa6EAYo0ffgJJSNQ3mg6P84G2zdGUKGLF9iUrSh0oOSap8fignPAHpsnVPY0pNHExc/B2Ss+td3342sjJC0OLhSpNqORAbRG6mfaO83Z6rYW1fPOiXepKh0IAfGdrUJOWyDwcGIKKmOiZ67hbmOa9Cx4G5OdobATjw62Vqz2+haybi1m6SUk7yEgbtlkZUQQCl+Ds0lWD5Mz3IIuo8c09+W1lFjcO71kNZ3CqBVEv/4FgYixmdwVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9c1xahV4ENemBWA2IV4np1L4lsLsD/SpvCRBqfl63bE=;
 b=ReBOajOVyEjrV5SQQlFbvejbVGR62f9znNCjpXm+HBryr6heohmsbJ/Ae4GtbYr1gOdcqW+Lc+WsXl1H+zqEOJci+E4xN+uaUrwFiPx+k8ri9UuI4L9ynhhsP5xesvEz+Y7AM1to6xivwOIn5bljL9kJFVbUZdRxMuBtKLKD+0mGgXmvYjQRd/a3OfdfHtYnsPKxqvDiEEqmfJoU5HtZgaEno3tQjglBue6C4Q+5x50Lh3zWPZ0oGuPgNe9MHrS1DkOH+Zi6IPIgKt845vGGnif4a7b1/aHlcCUbnsWDBm3rZQQ3VUFRY8TXyMoHO3oK+/u8SDMQCNGs9sxKS1DfoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9c1xahV4ENemBWA2IV4np1L4lsLsD/SpvCRBqfl63bE=;
 b=EjdF9oSR/8DNACEG8OIUxU8SmgIu3nUIxNPB2M38Vy0Xdnklwx343wY7dcy8/M+hNBKOmd6+oCiYlKcHd4WHkIbNWFJHPpBwuweeWm94xg8+Jf5NVodKzNSrSobrLiqfshTyUppWKI2C79YUZUpRBIucI5JxRQrzO8q0WXopWgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 09:16:53 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 09:16:53 +0000
Message-ID: <ead1599d-7a54-6efc-476a-85ca84608c92@amd.com>
Date: Tue, 3 Jan 2023 10:16:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 2/7] drm/amdgpu: Add usermode queue for gfx work
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-3-shashank.sharma@amd.com>
 <CADnq5_Pyk5AnsW7C2YX2uR1Y0hWRFW6774iAvmihFznpAvt1fg@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_Pyk5AnsW7C2YX2uR1Y0hWRFW6774iAvmihFznpAvt1fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::11) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 87332fb7-b921-4f21-0e4b-08daed6b40a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cfuuYuETJuQLmzdNqcWGUOXDu8A4vBnpr54djS9BnIbSGxBh+9z8tBPy4WwTpRMZsppyM7bPGAnDaz8iHOBNRSTtGV4/iGGvhc7p8hCzmMWZYtR9OzDPXKxGFt6RwjWj8MCNT2DaT9So3PDdiKFM0lJeFLIcCsSC5dZd8crG6ldStRFxNh1ViUnc6OSHAGJz5/mLm7/q0Emx4y3YdX11ZS31+ilk2bUDOz+Ms8jOoPhgZHOzA7ON1K2x5GuWinfYI87EQSyXtZ9nhjomHyYehC/Ow3nBXamuy8tD1d7jFajJhAIwk4L5wl4HfJ/U4Ev4ZcpFSXuUGdj8TDjsB+2EEH2t3e9z+JvWouUIUPEPmmheVDylKkkYFXTI6BsLobpK9Pze5KR411T0HabtH1gifyapyY6qJkbfzTfbBpv2TGyrHAQn2YVefzRl9jtJE+InnppSDg2gS4BIAaoMLKQ1VRMAkTYlP5dB2EXmlXUrlndvr81vlqIZqXaVwAONjq0nmJ+Alwzl0oJrR3dIBOx9/d9DnL4PkrHo4xMzMmzlVDU0Re8Qy2U4npIdb3FM/OpEpZA/aeWD7Jc/vS5yzeh6Fx30gkWieLj8tdhZsI40G0fOlGpOW8sSaP/sxlh4P/51DMGF0yeIIxqMC3TovdhWlRLwS9iA0udZayvXRLGgdaLdCvnWdtK2FxGrcBe1EPU6TFXH8em6R5mw8eva9zM+53yiUE5LOayfAD1Fl4EirTio69ed3++L0NF/noAQLiSW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(6666004)(6512007)(26005)(186003)(66899015)(31686004)(2616005)(53546011)(6506007)(478600001)(6486002)(66946007)(8676002)(4326008)(66556008)(8936002)(41300700001)(66476007)(30864003)(83380400001)(5660300002)(2906002)(44832011)(38100700002)(86362001)(31696002)(316002)(6916009)(54906003)(36756003)(22166006)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2JUSnFXVjFDbjN2YnRzcmhZdVpsWllkazBkaExVMWNrNWVsSFBPUTZlZFFJ?=
 =?utf-8?B?a2QyUTFmais1WS9oOHNycmxheWVpdCtQSUNuOC9zZ2RZejhJODMzYUc0ZW9s?=
 =?utf-8?B?Q0pZVG0zdzJuUzZjVk5rRVovOXl2QVhQdUJaNS9sdlBGVlVRNEM5d3N4ZDhD?=
 =?utf-8?B?TVZEa1B6cjE0dkF3QURORUtXeEIrU2tXL1cwTjlpWXM4bHJyUmRIWU1kM2dS?=
 =?utf-8?B?ajllYzNoMHhrN3NLL20xdnZZd2h3NnVhY3R3c1NQbGJUZE1PTG5vYTZsTjJi?=
 =?utf-8?B?RWQxVDRGMmx1OUlxc1B6MUVzM0lldmZkYmw0TnJscHZDYWVoUGtVVjFlUmhH?=
 =?utf-8?B?MHZEVFVjUktxM2lXM1hEa2dJY2NWWXB6a3lXTDdRaHNzRFNRaGRnQ2RXRHBY?=
 =?utf-8?B?OS9jYXp2NXovUTFjdGdLM1VXN0dCMWZpazRLR0MzdDhrbnQzZHdGTHRVMWJn?=
 =?utf-8?B?eG1vdDJZcDRGaDRnQUVVTjlJNG9NWEFQNElwZ3JSV2xmTTBoeWU0VUcxVUx1?=
 =?utf-8?B?VkNCU3g1b3krYjYvMjhMSU9GdytoS05HbTFFVjlkQWJ0ZUtNWVBncGpWajh0?=
 =?utf-8?B?cmRyY3pWVzY3ZTJGUm84R0ZNbXVYbzJRbzduMEN3NEJ4eitUVHljTEttajF6?=
 =?utf-8?B?UnZhemU0STlsRVNxUUdIa0YvY1FTRFJEUUg2dVA3dExCMi9RQlYwa2hQeG5L?=
 =?utf-8?B?dldHdnJzaW1LZ05sc3VSUkRUUVY5aDRWQlhJMmJsdDd1RU5mUUNHY3I5dTU0?=
 =?utf-8?B?ZS9vUTA5V1ZPcE9xZUllelpsL2hxTmwrTFZiVGN4NTlzZm9PNzlKV2dIaVBC?=
 =?utf-8?B?UGhKYzVWS2pYczFOMzllZjVxYzNxTU5INTg3TFdocDU3THpmcDlXdDg3dEoz?=
 =?utf-8?B?SWtwYTZQOVY3bWJwb1FTME1naUNjVWsvZDJnczdDM0hvVFQ1UE91elZwWEM3?=
 =?utf-8?B?bDAxaU5PVFBKZ3Z5Q0NISkpjTHcwdDdmdlg5K3A4aHJIMXlGTCtIKzRIT2lu?=
 =?utf-8?B?OVE0TDE4dm5XMnRDUWViZ0FWWng4ODRLMmhla1dBcWJCZ1d6SGdlVEU4bkRh?=
 =?utf-8?B?OTYwMmhFU3Q0UXJ3akZrTlJSNk42OHQrUVl2TytyR2pxUkk1emtHZEg5QkE1?=
 =?utf-8?B?Z28xTDA5Z2VzQW5mV3lBdmtjRVAyVERZc1FrOFJ6eXIwMXNKMVhaNWxxSnpE?=
 =?utf-8?B?aGJxU2hsRmVuS2UrdTBkbVAwcUdoZGg3RE9xVlRqcGlPc3dtdDFybXByRzRy?=
 =?utf-8?B?SVd4NW1KV0lPZVhsN1pqMUZsS0tsM3kvVmZMK2JHK2JPaFVmaEdoamdRZEdE?=
 =?utf-8?B?NG5mU3FvaDV5MjFuSmQxNVc3UXhzdDB3SDFwODErdkMySzZ3am02S2ZQTFAv?=
 =?utf-8?B?a2E2NHRZL1ZmOFhyWmVTRER1Z0lQRjMyMjZQejdQWVR6RFBjUFl4bnoxaVg0?=
 =?utf-8?B?d1BCYWp5WHRjcmNxS1dBSHpJaVo2M3lYcG4rNXRiZDVQQ25hT0ZHQ2NxMW4x?=
 =?utf-8?B?czNUbS9XTlN5VWllb0xML1NMeFMvT2h4b1NOblo5a0kvRDB0K24wbzVUc0tt?=
 =?utf-8?B?TnRaZHl1OTZUZDI3eDd1dng1MXMyUTE0T05qNUFaYi9HSmlNRXJjL05GaVVz?=
 =?utf-8?B?WHVkdDBnMmE5Z0xPc2FXYytSQVEwYjNObDdqVDlHelFSazZ5WVRGdXVnakpB?=
 =?utf-8?B?TjY2MmlhaFlnTEo1TUFQQ0MxV3hsNDFMUjBCeDMrM2NLWlZaeGlndlhYd1pr?=
 =?utf-8?B?ZS8yQUx6WVloTHRSSDFzL3JiYWJZRGg1VENIOGx3NmE2TXBPMzRpWGNiK01I?=
 =?utf-8?B?cXd3NXFFbVB1UEZHNTg0SUFrUnB5MlV4eFJEOEkzeVkxNWZ6Ym0yTzYwM0d1?=
 =?utf-8?B?UUdXOG55dnYyNmVTYUVDemxlVHN6czdpSHJ1amFSNklxSWRnUlpXZnRVUFJC?=
 =?utf-8?B?WlpiL0ZHbmd1K0VWN1F4akhabWw2dkhiMHlVVTk0cmUzVXhyZ1h0Uk5kNnNy?=
 =?utf-8?B?c1Nmc0hwSzErb2xkS05ITEZrR0FDK0ZWNU9NY2xDTXgzcjk2NHh4VEpJV3ZH?=
 =?utf-8?B?ZVhkUDczZWYwdVdZdnhuRVNhRENhdWdKVVBPOHdqUW02allFdGNOUXZ4YzV5?=
 =?utf-8?Q?ItWFBLmJAbnKzXIymnmBxFHt4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87332fb7-b921-4f21-0e4b-08daed6b40a0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 09:16:53.0829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ssg4AGt4pHAmZu0A0bQcP/27iRqhuhz7q7Q3/ObMc2aq7XI6QHnQxwGAUDKp2Y6tf6OJGrWFjO3QTvIAB90Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 29/12/2022 18:41, Alex Deucher wrote:
> On Fri, Dec 23, 2022 at 2:37 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> This patch adds skeleton code for usermode queue creation. It
>> typically contains:
>> - A new structure to keep all the user queue data in one place.
>> - An IOCTL function to create/free a usermode queue.
>> - A function to generate unique index for the queue.
>> - A global ptr in amdgpu_dev
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 187 ++++++++++++++++++
>>   .../drm/amd/include/amdgpu_usermode_queue.h   |  50 +++++
>>   5 files changed, 246 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 6ad39cf71bdd..e2a34ee57bfb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -209,6 +209,8 @@ amdgpu-y += \
>>   # add amdkfd interfaces
>>   amdgpu-y += amdgpu_amdkfd.o
>>
>> +# add usermode queue
>> +amdgpu-y += amdgpu_userqueue.o
>>
>>   ifneq ($(CONFIG_HSA_AMD),)
>>   AMDKFD_PATH := ../amdkfd
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 8639a4f9c6e8..4b566fcfca18 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -749,6 +749,11 @@ struct amdgpu_mqd {
>>                          struct amdgpu_mqd_prop *p);
>>   };
>>
>> +struct amdgpu_userq_globals {
>> +       struct ida ida;
>> +       struct mutex userq_mutex;
>> +};
>> +
>>   #define AMDGPU_RESET_MAGIC_NUM 64
>>   #define AMDGPU_MAX_DF_PERFMONS 4
>>   #define AMDGPU_PRODUCT_NAME_LEN 64
>> @@ -955,6 +960,7 @@ struct amdgpu_device {
>>          bool                            enable_mes_kiq;
>>          struct amdgpu_mes               mes;
>>          struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
>> +       struct amdgpu_userq_globals     userq;
>>
>>          /* df */
>>          struct amdgpu_df                df;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> index 0fa0e56daf67..f7413859b14f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> @@ -57,6 +57,7 @@ struct amdgpu_ctx {
>>          unsigned long                   ras_counter_ce;
>>          unsigned long                   ras_counter_ue;
>>          uint32_t                        stable_pstate;
>> +       struct amdgpu_usermode_queue    *userq;
> There can be multiple queues per context.  We should make this a list.

Noted, will change it into a queue. We are still in discussion (in 
another thread) if we have to move this from context to some place else.

>>   };
>>
>>   struct amdgpu_ctx_mgr {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> new file mode 100644
>> index 000000000000..3b6e8f75495c
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -0,0 +1,187 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +#include "amdgpu_mes.h"
>> +#include "amdgpu_usermode_queue.h"
>> +#include "soc15_common.h"
>> +
>> +#define CHECK_ACCESS(a) (access_ok((const void __user *)a, sizeof(__u64)))
>> +
>> +static int
>> +amdgpu_userqueue_index(struct amdgpu_device *adev)
>> +{
>> +    int index;
>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>> +
>> +    index = ida_simple_get(&uqg->ida, 2, AMDGPU_MAX_USERQ, GFP_KERNEL);
>> +    return index;
>> +}
>> +
>> +static void
>> +amdgpu_userqueue_remove_index(struct amdgpu_device *adev, struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>> +
>> +    ida_simple_remove(&uqg->ida, queue->queue_id);
>> +}
>> +
>> +static int
>> +amdgpu_userqueue_validate_input(struct amdgpu_device *adev, struct drm_amdgpu_userq_mqd *mqd_in)
>> +{
>> +    if (mqd_in->queue_va == 0 || mqd_in->doorbell_handle == 0 || mqd_in->doorbell_offset == 0) {
>> +        DRM_ERROR("Invalid queue object address\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (mqd_in->queue_size == 0 || mqd_in->rptr_va == 0 || mqd_in->wptr_va == 0) {
>> +        DRM_ERROR("Invalid queue object value\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (mqd_in->ip_type < AMDGPU_HW_IP_GFX || mqd_in->ip_type >= AMDGPU_HW_IP_NUM) {
>> +        DRM_ERROR("Invalid HW IP type 0x%x\n", mqd_in->ip_type);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!CHECK_ACCESS(mqd_in->queue_va) || !CHECK_ACCESS(mqd_in->rptr_va) ||
>> +        !CHECK_ACCESS(mqd_in->wptr_va)) {
>> +            DRM_ERROR("Invalid mapping of queue ptrs, access error\n");
>> +            return -EINVAL;
>> +    }
> Need to check the flags as well.

Noted

- Shashank

>
>> +
>> +    DRM_DEBUG_DRIVER("Input parameters to create queue are valid\n");
>> +    return 0;
>> +}
>> +
>> +int amdgpu_userqueue_create(struct amdgpu_device *adev, struct drm_file *filp,
>> +                            union drm_amdgpu_userq *args)
>> +{
>> +    int r, pasid;
>> +    struct amdgpu_usermode_queue *queue;
>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +    struct amdgpu_vm *vm = &fpriv->vm;
>> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
>> +    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
>> +
>> +    if (!ctx) {
>> +        DRM_ERROR("Invalid GPU context\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (vm->pasid < 0) {
>> +        DRM_WARN("No PASID info found\n");
>> +        pasid = 0;
>> +    }
>> +
>> +    mutex_lock(&adev->userq.userq_mutex);
>> +
>> +    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>> +    if (!queue) {
>> +        DRM_ERROR("Failed to allocate memory for queue\n");
>> +        mutex_unlock(&adev->userq.userq_mutex);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    r = amdgpu_userqueue_validate_input(adev, mqd_in);
>> +    if (r < 0) {
>> +        DRM_ERROR("Invalid input to create queue\n");
>> +        goto free_queue;
>> +    }
>> +
>> +    queue->vm = vm;
>> +    queue->pasid = pasid;
>> +    queue->wptr_gpu_addr = mqd_in->wptr_va;
>> +    queue->rptr_gpu_addr = mqd_in->rptr_va;
>> +    queue->queue_size = mqd_in->queue_size;
>> +    queue->queue_type = mqd_in->ip_type;
>> +    queue->paging = false;
>> +    queue->flags = mqd_in->flags;
>> +    queue->queue_id = amdgpu_userqueue_index(adev);
>> +
>> +    ctx->userq = queue;
>> +    args->out.q_id = queue->queue_id;
>> +    args->out.flags = 0;
>> +    mutex_unlock(&adev->userq.userq_mutex);
>> +    return 0;
>> +
>> +free_queue:
>> +    amdgpu_userqueue_remove_index(adev, queue);
>> +    mutex_unlock(&adev->userq.userq_mutex);
>> +    kfree(queue);
>> +    return r;
>> +}
>> +
>> +void amdgpu_userqueue_destroy(struct amdgpu_device *adev, struct drm_file *filp,
>> +                              union drm_amdgpu_userq *args)
>> +{
>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
>> +    struct amdgpu_usermode_queue *queue = ctx->userq;
>> +
>> +    mutex_lock(&adev->userq.userq_mutex);
>> +    amdgpu_userqueue_remove_index(adev, queue);
>> +    ctx->userq = NULL;
>> +    mutex_unlock(&adev->userq.userq_mutex);
>> +    kfree(queue);
>> +}
>> +
>> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>> +                      struct drm_file *filp)
>> +{
>> +    union drm_amdgpu_userq *args = data;
>> +    struct amdgpu_device *adev = drm_to_adev(dev);
>> +    int r = 0;
>> +
>> +    switch (args->in.op) {
>> +    case AMDGPU_USERQ_OP_CREATE:
>> +        r = amdgpu_userqueue_create(adev, filp, args);
>> +        if (r)
>> +            DRM_ERROR("Failed to create usermode queue\n");
>> +        break;
>> +
>> +    case AMDGPU_USERQ_OP_FREE:
>> +        amdgpu_userqueue_destroy(adev, filp, args);
>> +        break;
>> +
>> +    default:
>> +        DRM_ERROR("Invalid user queue op specified: %d\n", args->in.op);
>> +        return -EINVAL;
>> +    }
>> +
>> +    return r;
>> +}
>> +
>> +int amdgpu_userqueue_init(struct amdgpu_device *adev)
>> +{
>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>> +
>> +    mutex_init(&uqg->userq_mutex);
>> +    return 0;
>> +}
>> +
>> +void amdgpu_userqueue_fini(struct amdgpu_device *adev)
>> +{
>> +
>> +}
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>> new file mode 100644
>> index 000000000000..c1fe39ffaf72
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>> @@ -0,0 +1,50 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef AMDGPU_USERMODE_QUEUE_H_
>> +#define AMDGPU_USERMODE_QUEUE_H_
>> +
>> +#define AMDGPU_MAX_USERQ 512
>> +
>> +struct amdgpu_usermode_queue {
>> +       int             queue_id;
>> +       int             queue_type;
>> +       int             queue_size;
>> +       int             paging;
>> +       int             pasid;
>> +       int             use_doorbell;
>> +       int             doorbell_index;
>> +
>> +       uint64_t        mqd_gpu_addr;
>> +       uint64_t        wptr_gpu_addr;
>> +       uint64_t        rptr_gpu_addr;
>> +       uint64_t        queue_gpu_addr;
>> +       uint64_t        flags;
>> +       void            *mqd_cpu_ptr;
>> +
>> +       struct amdgpu_bo        *mqd_obj;
>> +       struct amdgpu_vm        *vm;
>> +       struct list_head        list;
>> +};
>> +
>> +#endif
>> --
>> 2.34.1
>>
