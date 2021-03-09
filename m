Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC76FC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 17:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674A665146
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 17:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674A665146
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19D1E6E90A;
	Tue,  9 Mar 2021 17:25:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8180A6E90A
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 17:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QU5dCyV6y8ZE3TAw1V4zZYJQ54ZKTJC+/zM1C3JtSQxSdwINhxOnt+nvSBXlu8er05YEpqQKZ9QemUwdcJ0qNRh355vRj52nn8hZTM7eKIQ1wGHStvG30ra3s1CU5A00SlHnVSdb/h2T18tf6cBEMmBr5cFGHO/FFo452Geoz75kaX85dF4rqSojGOsa0akcRyOGchmM0nkmKapKG3/MRsYFspFUBKv3w1ewrAXyrItGl0xwzWAnHn/D58PgiiMovot09OX7PI5efKE++bbwFGbmKhwsTqLceK7gCOvnmt2Pr+ybnoplnRPUz0pn679k7/DfBTjGKJIs8uh4uw8xZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yqyf/urWP95bYB7PHJ8ptnBfVHzznFzmYCGVHgiJVDI=;
 b=Cr3sqALGVLrQid1/EY2bd+xzQkh8KWvTDiELYm7GmL/cVfX1SQtyu3jxZU0Lx6GJmtu5cHnEHBvVOSUv95K4IAZB7UyHIk/vLNHzIYJOfoUacPegqbLufIsTRlChHQMulJKLXFROWsBD0r+asJlDLcR4arRFJpsR/bu43rqFqUWriGy8OkWzqFVRw851eUEfxI+5vt+RvVxwDHQorAE+WT6V80CTwGH8IGtJsBmSPcz0YVqbxMMv1DXggmhQoFu5t0hqe3K+bcLswnqcXLsh3JsRYwQFJyYmrHmhEgpANvOFEGjYY7+drk1xSiiPrymCFHZ1xlGA7oB4RwXWUbfr+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yqyf/urWP95bYB7PHJ8ptnBfVHzznFzmYCGVHgiJVDI=;
 b=vFV3U0QjHSUFFkHB0htFmppbkiuJ4Ov53d1GtwXhnlm8WVymmNpS2pKKafwFcJ390yUiCqyWJSPV/vFUsktxnnYu8Q8l1afgjFdi8OsHZVNjZEAX7Ox3+53KahSksWddVZlFyH1Zd+NLDKBTQbvI9KkaDPZqDon/fEpyPuJmgsA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20)
 by BYAPR12MB2902.namprd12.prod.outlook.com (2603:10b6:a03:12f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Tue, 9 Mar
 2021 17:25:13 +0000
Received: from BY5PR12MB4097.namprd12.prod.outlook.com
 ([fe80::a8bd:e678:1c74:94f1]) by BY5PR12MB4097.namprd12.prod.outlook.com
 ([fe80::a8bd:e678:1c74:94f1%8]) with mapi id 15.20.3890.038; Tue, 9 Mar 2021
 17:25:13 +0000
Subject: Re: [PATCH 4/7] drm/amdgpu: track what pmops flow we are in
To: Alex Deucher <alexdeucher@gmail.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
References: <20210309041012.23367-1-alexander.deucher@amd.com>
 <20210309041012.23367-4-alexander.deucher@amd.com>
 <MN2PR12MB4549198E8D86DC4176EC6C9E97929@MN2PR12MB4549.namprd12.prod.outlook.com>
 <CADnq5_OauPrtpYZQb+C3qRkU15u5Hp3tpXXM7ERC63Lh9sj6TA@mail.gmail.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
Message-ID: <f5b4bfba-6d01-bccd-cf8c-8036e2a4320a@amd.com>
Date: Tue, 9 Mar 2021 12:25:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <CADnq5_OauPrtpYZQb+C3qRkU15u5Hp3tpXXM7ERC63Lh9sj6TA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YTBPR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::30) To BY5PR12MB4097.namprd12.prod.outlook.com
 (2603:10b6:a03:213::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.18.117] (165.204.54.211) by
 YTBPR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Tue, 9 Mar 2021 17:25:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b03e48a-aae0-4e62-1faf-08d8e3204c1e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2902:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB29024195718832429C26CF96FE929@BYAPR12MB2902.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKLdRLwFsRG/gZ18SO0jD20uavlAp5QzyzxxRzlh+6zdYug8BSpwp87eNIb/g5KzwuifmGZKPeJUGb4dcoOSyYAP5lOs5zXWDJwoP4rKM/BpVkn+YIFubMSJ/QErRLZakQEoH6xWhnClfhFPyXk36B1idzz/yzcTm1iky/KLYRQuUjrm3DDTSzA9ASo3x49BRTDx7iolDWeUfCyEfB3RWgUX8KfLuO7TueaHNgBo7UyKBhbZpDsXkKNjv/Pjbve3yq+Ag+P2fu+zZPGB/i6/6w7PDhH0SniloJHY24G/+MmEmZh2Qo8QxVHSxVjVp6KVs3QIZajO7Ux02rqIkE9abueAAoSGWR5y/T/WvaCK6VUaRtHh+l5RdUnarcIj2RPJ5TIgTLt2dhwehlvPDELm8JjMqjVQqozsIluMSTEaEFBnDiSlnk4RNcRYPG21C4DM7KuqaVRxJMhG37hpfpoxsSsMDou/nfe//MXgmkce0KRv/AwWlNAJzqzMUSapzJ0PJqmYkCyAu4et4qewytbgyOhpI68mrDyT8YPRhbzPZUMmHsH+NygpiQpmwZWFY0947y86zKyHEad96j0qtty+cfxzxoaRpBuvN/d2Jaq45dfvoczLF+FOjwseR2pZhvdXGMBa2ZfGqvX/Gr0VfgJGfOgxmA2DflF3MgWT7ae7+jUwYjYpWa5YfhulNsNS1x6F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4097.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(52116002)(66476007)(478600001)(45080400002)(31696002)(66556008)(956004)(30864003)(186003)(86362001)(6486002)(6636002)(2906002)(4326008)(31686004)(83380400001)(8676002)(16526019)(53546011)(66946007)(5660300002)(16576012)(316002)(966005)(2616005)(36756003)(54906003)(110136005)(6666004)(26005)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YzEyZ1RCOTFub0l4MmJrNEdUQlVLd3lDWUdhVlRXYmRHMENrNWFaWjRQTU9K?=
 =?utf-8?B?cHZ0ajVEbGpkSVp2NElYL1BsaVRLTDA4Y0ZtMXJxS1MrTjlWaFBrQjhZNk5H?=
 =?utf-8?B?RVd0cTcvQmdPSjFCYmtKdnQzWFNEVmdia1RDT1g0eTF3TldKZFoyQ2cvblVI?=
 =?utf-8?B?cEJCbG9wMHZxRk5Zck9sZWdVbmFzSDQwWG9xTTU5ZjRJV1krYk0rYmpHUDJ4?=
 =?utf-8?B?SmdCcm94c1R4WFBIT1VmVXVrYmVDZS9hM2s1ejVmTTFxSjlhMUs2MFJ4T3Ju?=
 =?utf-8?B?Tk1XTzdnUjdCVCtGck5HZTB6MjVpOHJ2OUVGQWtWTmJqaDhicGZJUnFZZldH?=
 =?utf-8?B?ZDB6UzNsTFB4TFRjNlEwbVJaYnE4TFZZSzdhaVVwRG9JLytwZ2hWQnczSWgy?=
 =?utf-8?B?SGhYcld0S1ozMENZUjhzWmdGekMxM3cyTFRLTVdoNkt6NkxBT0hhRkMwTmJL?=
 =?utf-8?B?djBUbTlZOEZkNjVRTlRLSU8zYUhLUDZHQTRPaEZrMlIrZDJzbFcrVkZvOHhk?=
 =?utf-8?B?L2JiaVB5NWNLWUVVMmFnVzdyVXQ5RndGK3NtS1NwVkNyZnQySTc2c1BwTTdC?=
 =?utf-8?B?QzF2blpJK0l3UUwvZ3dJNzMwbDRGSDl3czlyM2t6SkRxU1Z3VExhVHpXVllD?=
 =?utf-8?B?RE5hSS9MOHBFYUw2dEV2K04xaDFSWlhhVTlXdHhUNXpnelFWbW55WU5SU0Y4?=
 =?utf-8?B?YStxNGVVUkJkMEdNcmw4ZGlHemFnSHFaTDU5RUh1cncyeWQ3OXVOekxkQk9r?=
 =?utf-8?B?SUdVam5kQUxmbE04ZzNBN0FhbitTeE1CNHJwRTRsTGxsY2l5OFVFU1RmMDFS?=
 =?utf-8?B?eDZJUndWOUlQS0VOVllzNDk1MzN6bEpuSjZNK2k0UUtzT3dabWY4VTF0RlhF?=
 =?utf-8?B?MHBUZHg1d0VIb1kwak5NZnQvcUd3dUtRKzZzL1FzR1QzdlVCUCtVTXJ1MitD?=
 =?utf-8?B?TUJZZERSOVdsRVpuSjkwNm5JMkZsNXNnTVVMNHJuL0lvcDM0VTFpRTRCM25D?=
 =?utf-8?B?cVQ0THVKSDN2WWhLcVhYOFNjZktETHU1SG91TmlOaDE4aHk1eWJJSlNrMXlG?=
 =?utf-8?B?SzlXQ2EyK1pCOVVQWFdLRDk3SHcvcUNhSzJDTnhLN2ozNkhlbDIxTm11aHBp?=
 =?utf-8?B?WHNUSWZCNDA1MEZzMGs2QlpHSis2a2JkdTU0MGR6UTFXeE5hTmQ5NE11ZWNK?=
 =?utf-8?B?eWNCTWQvNzJTZ3Vya2t5UUJDQjhRMHJCK3RZTnNjd1Boam52UE9OMGdBbGpu?=
 =?utf-8?B?ekxaWTc2empUbTVJWHhjbWRBMU1pUmZwU1RNYmJabVBVVGtEY2hpZk84V0tt?=
 =?utf-8?B?TUFFWlN6MHY5TDRmejdXVjZGMmlYVldkYWhtLzU1V3ZGeW1CYkVFUFlhY2VO?=
 =?utf-8?B?a1dNZnd6ellrVjhlV2VrRGVzMmlGQVJETTViS3ZkT2lna2wzRlMySFk3cWN0?=
 =?utf-8?B?OHlQTllraURobjVYMVBCVVJhUEpyVm9tN0JDdjFsWGQ1WEhweVJWNjhRSlFq?=
 =?utf-8?B?Tkp5Y0NJa21oc2pTdW8vek96TmNjSzVYamRvbmNoZEE2Q2pwVk1Hc1QxbVhp?=
 =?utf-8?B?eWJaK0wwSCtOcmVlVGFhVkd6STlLeUduUWdkc1VDS0wvMTNpWGRVYmIxT3Vi?=
 =?utf-8?B?MVNXbnRIT09MUm40RGRhbjhYWFJ4eTBmc0lHWisxUW1IRmRFR3h2YkZhZEF6?=
 =?utf-8?B?b2NicnN6SDQ1aXE1VGtidkVITm5pZHpKR21JKzZXZjNTT1hBUGs0MktQWmFl?=
 =?utf-8?Q?C3/uiXyU2vY/ynGNEhdHBj+Hg/r2OIDIFeSrMi+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b03e48a-aae0-4e62-1faf-08d8e3204c1e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4097.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 17:25:13.1283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIPRne6A+2AeQOZ6ojrPzvlvJNxO7KYQ8oOPjz7RraqQdW6B7CmEdFhPi0eyGfqrQUkApxQ/YvWsG86GUdRAbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2902
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

pm_message_t events seem to be the right thing to use here instead of 
driver's privately managed power states. Please have a look

https://elixir.bootlin.com/linux/v4.7/source/drivers/gpu/drm/i915/i915_drv.c#L714

https://elixir.bootlin.com/linux/v4.7/source/drivers/gpu/drm/drm_sysfs.c#L43

Thanks,

Rajneesh


On 3/9/2021 10:47 AM, Alex Deucher wrote:
> [CAUTION: External Email]
>
> On Tue, Mar 9, 2021 at 1:19 AM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>> [AMD Public Use]
>>
>> This seems a duplicate of dev_pm_info states. Can't we reuse that?
> Are you referring to the PM_EVENT_ messages in
> dev_pm_info.power_state?  Maybe.  I was not able to find much
> documentation on how those should be used.  Do you know?
>
> Alex
>
>
>> Thanks,
>> Lijo
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
>> Sent: Tuesday, March 9, 2021 9:40 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: [PATCH 4/7] drm/amdgpu: track what pmops flow we are in
>>
>> We reuse the same suspend and resume functions for all of the pmops states, so flag what state we are in so that we can alter behavior deeper in the driver depending on the current flow.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 20 +++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 58 +++++++++++++++++++----
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  3 +-
>>   3 files changed, 70 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index d47626ce9bc5..4ddc5cc983c7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -347,6 +347,24 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,  bool amdgpu_get_bios(struct amdgpu_device *adev);  bool amdgpu_read_bios(struct amdgpu_device *adev);
>>
>> +/*
>> + * PM Ops
>> + */
>> +enum amdgpu_pmops_state {
>> +       AMDGPU_PMOPS_NONE = 0,
>> +       AMDGPU_PMOPS_PREPARE,
>> +       AMDGPU_PMOPS_COMPLETE,
>> +       AMDGPU_PMOPS_SUSPEND,
>> +       AMDGPU_PMOPS_RESUME,
>> +       AMDGPU_PMOPS_FREEZE,
>> +       AMDGPU_PMOPS_THAW,
>> +       AMDGPU_PMOPS_POWEROFF,
>> +       AMDGPU_PMOPS_RESTORE,
>> +       AMDGPU_PMOPS_RUNTIME_SUSPEND,
>> +       AMDGPU_PMOPS_RUNTIME_RESUME,
>> +       AMDGPU_PMOPS_RUNTIME_IDLE,
>> +};
>> +
>>   /*
>>    * Clocks
>>    */
>> @@ -1019,8 +1037,8 @@ struct amdgpu_device {
>>          u8                              reset_magic[AMDGPU_RESET_MAGIC_NUM];
>>
>>          /* s3/s4 mask */
>> +       enum amdgpu_pmops_state         pmops_state;
>>          bool                            in_suspend;
>> -       bool                            in_hibernate;
>>
>>          /*
>>           * The combination flag in_poweroff_reboot_com used to identify the poweroff diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 3e6bb7d79652..0312c52bd39d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -1297,34 +1297,54 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)  static int amdgpu_pmops_prepare(struct device *dev)  {
>>          struct drm_device *drm_dev = dev_get_drvdata(dev);
>> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>> +       int r;
>>
>> +       adev->pmops_state = AMDGPU_PMOPS_PREPARE;
>>          /* Return a positive number here so
>>           * DPM_FLAG_SMART_SUSPEND works properly
>>           */
>>          if (amdgpu_device_supports_boco(drm_dev))
>> -               return pm_runtime_suspended(dev) &&
>> +               r= pm_runtime_suspended(dev) &&
>>                          pm_suspend_via_firmware();
>> -
>> -       return 0;
>> +       else
>> +               r = 0;
>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>> +       return r;
>>   }
>>
>>   static void amdgpu_pmops_complete(struct device *dev)  {
>> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
>> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>> +
>> +       adev->pmops_state = AMDGPU_PMOPS_COMPLETE;
>>          /* nothing to do */
>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>>   }
>>
>>   static int amdgpu_pmops_suspend(struct device *dev)  {
>>          struct drm_device *drm_dev = dev_get_drvdata(dev);
>> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>> +       int r;
>>
>> -       return amdgpu_device_suspend(drm_dev, true);
>> +       adev->pmops_state = AMDGPU_PMOPS_SUSPEND;
>> +       r = amdgpu_device_suspend(drm_dev, true);
>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>> +       return r;
>>   }
>>
>>   static int amdgpu_pmops_resume(struct device *dev)  {
>>          struct drm_device *drm_dev = dev_get_drvdata(dev);
>> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>> +       int r;
>>
>> -       return amdgpu_device_resume(drm_dev, true);
>> +       adev->pmops_state = AMDGPU_PMOPS_RESUME;
>> +       r = amdgpu_device_resume(drm_dev, true);
>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>> +       return r;
>>   }
>>
>>   static int amdgpu_pmops_freeze(struct device *dev) @@ -1333,9 +1353,9 @@ static int amdgpu_pmops_freeze(struct device *dev)
>>          struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>          int r;
>>
>> -       adev->in_hibernate = true;
>> +       adev->pmops_state = AMDGPU_PMOPS_FREEZE;
>>          r = amdgpu_device_suspend(drm_dev, true);
>> -       adev->in_hibernate = false;
>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>>          if (r)
>>                  return r;
>>          return amdgpu_asic_reset(adev);
>> @@ -1344,8 +1364,13 @@ static int amdgpu_pmops_freeze(struct device *dev)  static int amdgpu_pmops_thaw(struct device *dev)  {
>>          struct drm_device *drm_dev = dev_get_drvdata(dev);
>> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>> +       int r;
>>
>> -       return amdgpu_device_resume(drm_dev, true);
>> +       adev->pmops_state = AMDGPU_PMOPS_THAW;
>> +       r = amdgpu_device_resume(drm_dev, true);
>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>> +       return r;
>>   }
>>
>>   static int amdgpu_pmops_poweroff(struct device *dev) @@ -1354,17 +1379,24 @@ static int amdgpu_pmops_poweroff(struct device *dev)
>>          struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>          int r;
>>
>> +       adev->pmops_state = AMDGPU_PMOPS_POWEROFF;
>>          adev->in_poweroff_reboot_com = true;
>>          r =  amdgpu_device_suspend(drm_dev, true);
>>          adev->in_poweroff_reboot_com = false;
>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>>          return r;
>>   }
>>
>>   static int amdgpu_pmops_restore(struct device *dev)  {
>>          struct drm_device *drm_dev = dev_get_drvdata(dev);
>> +       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>> +       int r;
>>
>> -       return amdgpu_device_resume(drm_dev, true);
>> +       adev->pmops_state = AMDGPU_PMOPS_RESTORE;
>> +       r = amdgpu_device_resume(drm_dev, true);
>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>> +       return r;
>>   }
>>
>>   static int amdgpu_pmops_runtime_suspend(struct device *dev) @@ -1389,6 +1421,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>>                  }
>>          }
>>
>> +       adev->pmops_state = AMDGPU_PMOPS_RUNTIME_SUSPEND;
>>          adev->in_runpm = true;
>>          if (amdgpu_device_supports_px(drm_dev))
>>                  drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING; @@ -1396,6 +1429,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>>          ret = amdgpu_device_suspend(drm_dev, false);
>>          if (ret) {
>>                  adev->in_runpm = false;
>> +               adev->pmops_state = AMDGPU_PMOPS_NONE;
>>                  return ret;
>>          }
>>
>> @@ -1412,6 +1446,8 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>>                  amdgpu_device_baco_enter(drm_dev);
>>          }
>>
>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>> +
>>          return 0;
>>   }
>>
>> @@ -1425,6 +1461,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>>          if (!adev->runpm)
>>                  return -EINVAL;
>>
>> +       adev->pmops_state = AMDGPU_PMOPS_RUNTIME_RESUME;
>>          if (amdgpu_device_supports_px(drm_dev)) {
>>                  drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>>
>> @@ -1449,6 +1486,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>>          if (amdgpu_device_supports_px(drm_dev))
>>                  drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
>>          adev->in_runpm = false;
>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>>          return 0;
>>   }
>>
>> @@ -1464,6 +1502,7 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>>                  return -EBUSY;
>>          }
>>
>> +       adev->pmops_state = AMDGPU_PMOPS_RUNTIME_IDLE;
>>          if (amdgpu_device_has_dc_support(adev)) {
>>                  struct drm_crtc *crtc;
>>
>> @@ -1504,6 +1543,7 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>>
>>          pm_runtime_mark_last_busy(dev);
>>          pm_runtime_autosuspend(dev);
>> +       adev->pmops_state = AMDGPU_PMOPS_NONE;
>>          return ret;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 502e1b926a06..05a15f858a06 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -1327,7 +1327,8 @@ static int smu_disable_dpms(struct smu_context *smu)
>>          bool use_baco = !smu->is_apu &&
>>                  ((amdgpu_in_reset(adev) &&
>>                    (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
>> -                ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
>> +                ((adev->in_runpm || (adev->pmops_state == AMDGPU_PMOPS_FREEZE))
>> +                 && amdgpu_asic_supports_baco(adev)));
>>
>>          /*
>>           * For custom pptable uploading, skip the DPM features
>> --
>> 2.29.2
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Crajneesh.bhardwaj%40amd.com%7Cd0524482d33848d5909f08d8e312b2e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509016743361628%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ZGYK5C%2Flo5BCIqxeEikspQi3Ib1M501mw04evWswAss%3D&amp;reserved=0
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Crajneesh.bhardwaj%40amd.com%7Cd0524482d33848d5909f08d8e312b2e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509016743361628%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ZGYK5C%2Flo5BCIqxeEikspQi3Ib1M501mw04evWswAss%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Crajneesh.bhardwaj%40amd.com%7Cd0524482d33848d5909f08d8e312b2e3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509016743361628%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ZGYK5C%2Flo5BCIqxeEikspQi3Ib1M501mw04evWswAss%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
