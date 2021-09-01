Return-Path: <SRS0=BBbY=NX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A21C432BE
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 16:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F7461053
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 16:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48F7461053
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C92186E217;
	Wed,  1 Sep 2021 16:47:37 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2040.outbound.protection.outlook.com [40.107.102.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95D6F6E216
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Sep 2021 16:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpHwGKZY079B2ovDQekdUduw4CDi0zDnx2ruHU/tEf1pZGFXMG9vHAHzjYNYf2qhNXxJKhP30xTVQarpsC8qzkKE8UHpCp/Q8dqHLYnFUAwCMn9cHJJSxkE+oBS7ItsvwRNiAsE4chM5Dk9nJe6nH32FGwnK8YrFw/n8Zj8Z/excZZjFIivZBHJbp4psfPv5YJW8IFXKC5ogtMXAwt8ry4U0gQfOjckHgz5wdlt57zymtgOiJ8Da7vi3dXcQNbEB4+3HPDOWc5J2KwLO7VTVbaXrdyl4QclVOOgdKy2fTMqPIGPs2ul+JT64k4vPFLrNseyXgCfPhMd1qCM0XoxNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L66pI+08hp+oj3kzWb8oB5xWKdNa0dnDuQgZ7UBV2wY=;
 b=OGJbJjfZOEPZ69FfAf0zsCMUhrHQmdtSJ2o42t7z6xwuhIjOhoEz4e2BHpoasRs9u3k7+zkznOQ+rd+adfORApiG90v4H8+L1Z2i83qn5GexPVI8dMC5XupFLL6wyA+jTqOF0ucevlzVFY1+lUV8QkBqbIN9ZezZSYbAu9qgKsTXInuuBYe7/kz4ZLZXdtY4ROXIq3EV6L7wbHqWlCM5wi8NDVR1dhyevMxAosxpklyzzI0WOUzF5mJK03ZRwaP6X8l2FuySKndCxRnLz+Plw+ZjCVUy7VFcnPJCWx8O9DEzEhM1lljNYIo1D/1oynWLjxhD6aA2V8Xn826LX6ZvPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L66pI+08hp+oj3kzWb8oB5xWKdNa0dnDuQgZ7UBV2wY=;
 b=OrR1fvezFsyyvBrtkO43ULJb9LNa3hhR5OZGK3xGfEx1MXeUzUt34c6www4LgEElB7A8bsxN6l0Bp+Vc0W7GKcSEhyLvt6SPetKWEv+ODYqWxigShfW09PYd/aC+1wmF38uxqkfh2fiyR+1lC/1H0iLb8MI1fy6QrApCp1F9Eug=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 16:47:34 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 16:47:34 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: make needs_pcie_atomics FW-version
 dependent
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210831215632.195506-1-Felix.Kuehling@amd.com>
 <239a99fd-835f-cbbc-152f-afae6861bf60@amd.com>
 <2c63bf17-2404-8c68-fa63-b14d94de3e90@amd.com>
 <BL1PR12MB5349845ADA6A373FBA45609197CD9@BL1PR12MB5349.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <9e6ea029-d928-0c60-edde-be1dd1fb09f6@amd.com>
Date: Wed, 1 Sep 2021 12:47:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <BL1PR12MB5349845ADA6A373FBA45609197CD9@BL1PR12MB5349.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::18) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YTOPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Wed, 1 Sep 2021 16:47:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43f0943b-122d-463e-05ca-08d96d683293
X-MS-TrafficTypeDiagnostic: BN9PR12MB5131:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5131951D09CD4D7D30C0F01592CD9@BN9PR12MB5131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPxSgAQBjzxjcO2ES5sPr2QveyG88EkgG/QwzcdMOh1ppXXhPuYo8mH3EB3Hvn5aT66o7VMimtJ8ImD4r8U1iKsXZKwMa5SHleJDa/NBhtk6UeCv6zFz29FJIk/dgsrzdNm+kNCjIfEC9mc6/j0p8aJ5CL50gWK5gV8jOW/r1K9yVICosftCNtSgdLlz5HbI8jMsG+MKvsKy09W05ISSIWlmNeLOsoQ4S1cHV0i/CbTvSpjyOd0ZRJOOY4MT9zF7ntHge7pMLdZLUfdbNFCZeb5byud/0gmcRZXr4Ykndn4UWoEaM4IEIxtrJsSOTxduVfBHoqsUNL68Ah3wa2YRlQBH810SjJ/PWQerb3EuVz9qotoOznmmw8uSv97V91/z7N8bJGzOpaId8otlrfkxmtRPWRbswIjjEGuo5wYCHHfofmXvC8+kj1wy009MQzGcWt81N7axuHgkORO6p8bH/d2XTBuqV1CVAZs7eH4K2SIggAC4Nth4xEAe+KGygvRMOFcSaZrD2ud/LshG+2JAXUxuqEwId1rTS+VPcqcJ8lZPSaEu1KGjFhJ8qss0CE+oEz1qA5NypKkx0VKA5eSrveaLk9eu8LCdaYX0o7ieMRzTuGCysUAel9ozb9+MVYO2Gjxba+JjAOO5czqRXaFa1ov7wi1TYk4ytiiEJXl00a6r6RCYoPOaK1Wg9CLEGIDiCqA0igg4KDVVycovCdDxXZtPe08of8EK6wuOOhAHYzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(86362001)(36756003)(2616005)(186003)(478600001)(26005)(66476007)(66946007)(956004)(44832011)(31696002)(38100700002)(83380400001)(66556008)(53546011)(31686004)(8676002)(16576012)(110136005)(316002)(2906002)(6486002)(5660300002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TS9Wd1RpQ3U4ZkZJcTRyU1cxL3h4dkxzc0U1RHlKZ2ZjaW0xZGpnRk51QlY5?=
 =?utf-8?B?NzdBQ2JJVkdBTWJPdlRBSzBaNTVQRDRzaERXMGRWRzU0UWJNSUo0U3U0WTlX?=
 =?utf-8?B?aGY1SGtaeHdjK1FFNnpHSDhVc1ZCWWpZditqdm5RaHhPRDNqbTJUeHNPaWE4?=
 =?utf-8?B?QWx3bENwenEvaVRXTXQwdnJNYWo4M1plRDV6U0R5cnQxcHpEcUNHTEZyY05m?=
 =?utf-8?B?bUhkckVnemtRTks2R2FGaFdmc3lZV2JsWWxGcFdaZENScm1Zak03NXpibEZl?=
 =?utf-8?B?U1Fqci9MdVRMTm96aGJVWEFvU1Q3UXpnNzR0QlM3REQxREovQUhYdWdDVExV?=
 =?utf-8?B?OGJxekNyY1BUNkJTQVdZckFkQXVuTlpDSXdKVW9BYkhtZmFkM2ZDY2xCOTI1?=
 =?utf-8?B?eGV1TktReW0vcC90eFlaaS9kaXJQcHNBS2w3MmF4YS85cnVwclpTa2E2RUhi?=
 =?utf-8?B?ZytRVG5nSHo2TWNwbW1aaDNNdlFEZ2RjY0VCQUY5UGM0UE1ZNTQrbDFDMDdJ?=
 =?utf-8?B?cUwxQUNYSXJMWTRtZERDTlBYTDN6dTNwaWNoVGg0ZEhvN2pGRVpjREM5Mkg3?=
 =?utf-8?B?dTJlSUpqY083UGhjS1RiUXl3RE1KaFZacEtFKzdnb0J2S0loQzNHU2dVeVVX?=
 =?utf-8?B?WFVwODR4VnZwS2VLZU13QXNId2F1ZkVQTkxlRGttUTRMZXFUNCtHcit4bHVj?=
 =?utf-8?B?SjBLcHhjd3VWSnBmM3VyOGdBdU0vRmNCQnh6Tkp1Z2NmYW1QOHo1Zm9HY0tm?=
 =?utf-8?B?c0kvYzdzUmtVR2crcTNURTZycTZ1c1AxMlhWUDBVODdmNDNjVUZMR1ErK09N?=
 =?utf-8?B?WTZTT05reHlzZGc1S3o4aVhMWXRqM3VSRzV4d21pL2oxOWtYUmlzdnRnSTIv?=
 =?utf-8?B?YUV0Z1VTWWYzZ0lzcitUQTd6cFFEcTR2MGtlcm1yRXluaGd4bGxOWFhxMy82?=
 =?utf-8?B?Q20vc0lWVFFPdHlEd25rZ1RJYzFvTnZ0YzEyMDJ0c0lFUDRuUkNjWkhOYi9N?=
 =?utf-8?B?OWpVZTk0Uk9FRnMyYmVUaTRTY0NPbHgwK0N3RkxrSjlzNXNvZFp5Qmptc2M3?=
 =?utf-8?B?bVRPY09sc01DVHVoSk5nVk5WbEJnQmpPUlNnWFZ1bzdyeHljanRsdmpxMlBS?=
 =?utf-8?B?QUJnWG1zeXYrcVJ5OXM2RFpRZm51Zkp2L1BSYzdLN2N5MmRVNW15dm1vV2ln?=
 =?utf-8?B?SDVVVVVjYmwwdFhwTUlnOTNPWGx2cjN4dko2MmQ4ak1hZEFsWjB4cmw1YXJL?=
 =?utf-8?B?MzhiWExuQ05yeC9sTjY5MGxNTjFMbThuczEvV3o0SlM4bEFTZlZ2RXFLTUda?=
 =?utf-8?B?Rm80NC84amZXNmNuaTUzMWQ1RkxtSzZLejRkVEljL2VoOGoxRHlFaGp6VkVi?=
 =?utf-8?B?cWlBZWxHMGRrM3pFOHZyWWI3eHlCWHRHOTZaQndQQ094SzFESERrSDRPZUl3?=
 =?utf-8?B?Q0cxMTBJbWpnaTZYbWF2dm51cFA0NVlOS011RXVHamJwYTZUd3JuQlVWRkxU?=
 =?utf-8?B?cnU5ZTZyZmI5WUdEWUtxS1JTdjhHUE1yM2RCZ1Z0eFl6M2pWZlQrV0dSSGtC?=
 =?utf-8?B?RzFManc1NmRmdWhObllTR0JvY2c4QmRFK1lJTGZCVTN1Slo3UUsxbkVPS2lD?=
 =?utf-8?B?YXhadTlFSXhBd1JCbmJQaVJwNmtPNWRoQXl5U1lYdk1mUk5VQzFqTXFaeW9n?=
 =?utf-8?B?SjNCeWNMdExFWnhOWlUxODBranN1WXpYZE5GWWUrN2o0eXVGaldUTnhOQUtT?=
 =?utf-8?Q?NVHz2p/g2PWB8PbaBcmk71hT/nsLABgUHCWcnvL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f0943b-122d-463e-05ca-08d96d683293
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 16:47:34.3283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJYN2Ksid+FcnS6Mj9qI0rlXJIfUI2i41SGSMwhqfefEgsfCBygF9yXXBmv8IoNMqOc+Lf+5afWk9qap1yso5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131
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

Am 2021-09-01 um 12:30 p.m. schrieb Lazar, Lijo:
>
> [Public]
>
>
> What I wanted to ask was -
>
> Whether user mode application relies only on link properties alone to
> assume atomic ops are supported? If they check only link properties
> and if the firmware doesn't work fine, should it be still marked as
> supported?

Let's be clear what "firmware doesn't work fine" means in this context.
It means "firmware requires PCIe atomics". If firmware requires PCIe
atomics and the system doesn't support PCIe atomics, KFD will not use
the GPU and will not report the GPU to user mode.

If firmware does not require PCIe atomics, or if PCIe atomics work on
the system, KFD will use the GPU and will report the atomic capability
to user mode in the IO link attribute.


>
> Basically, what is the purpose of exposing atomic capability in link
> properties and whether that can be utilised by upper mode applications
> just based on PCIe atomics support?

Applications can use PCIe atomics by using atomic shader instructions
when accessing system memory in GPU shader code. If the system doesn't
support PCIe atomics, these atomic operations are silently dropped.
Therefore the application must check the atomic capability in the IO
link properties before relying on these instructions for system memory.

Regards,
  Felix


>
> Thanks,
> Lijo
> ------------------------------------------------------------------------
> *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
> *Sent:* Wednesday, September 1, 2021 8:24:56 PM
> *To:* Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [PATCH 1/1] drm/amdkfd: make needs_pcie_atomics
> FW-version dependent
>  
> Am 2021-09-01 um 7:04 a.m. schrieb Lazar, Lijo:
> >
> >
> > On 9/1/2021 3:26 AM, Felix Kuehling wrote:
> >> On some GPUs the PCIe atomic requirement for KFD depends on the MEC
> >> firmware version. Add a firmware version check for this. The minimum
> >> firmware version that works without atomics can be updated in the
> >> device_info structure for each GPU type.
> >>
> >> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 9 +++++++--
> >>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 1 +
> >>   2 files changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >> index 16a57b70cc1a..655ee5733229 100644
> >> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >> @@ -688,6 +688,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
> >>       struct kfd_dev *kfd;
> >>       const struct kfd_device_info *device_info;
> >>       const struct kfd2kgd_calls *f2g;
> >> +    uint32_t fw_version;
> >>         if (asic_type >= sizeof(kfd_supported_devices) / (sizeof(void
> >> *) * 2)
> >>           || asic_type >= sizeof(kfd2kgd_funcs) / sizeof(void *)) {
> >> @@ -713,8 +714,12 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
> >>        * supported.
> >>        */
> >>       kfd->pci_atomic_requested =
> >> amdgpu_amdkfd_have_atomics_support(kgd);
> >
> > Should the check be grouped inside amdgpu_amdkfd_have_atomics_support?
> >
> > This flag is used for setting some link properties. If there is HW
> > support but comes with incompatible firmware, should the link be still
> > marked as atomic?
>
> Our GPU HW always supports PCIe atomics (it's part of the PCIe 3 spec).
> But some mainboards with older PCIe chipsets do not. Sometimes even
> different ports on the same mainboard differ in their PCIe version and
> atomic support.
>
> amdgpu_device_init always tries to enable atomics on the root port an
> all the bridges leading to the GPU by calling
> pci_enable_atomic_ops_to_root. The result is saved in
> adev->have_atomics_support, which is returned to KFD by
> amdgpu_amdkfd_have_atomics_support.
>
> The firmware change here does not affect whether atomics are
> _supported_. It changes whether atomics are _required_ for the basic
> operation of AQL user mode queues. The coming firmware update will
> remove that requirement, which allows us to enable KFD for these GPUs+FW
> on systems without PCIe atomics.
>
> Enabling PCIe atomics with the updated FW is still beneficial because
> shader programs can use a subset of atomic instructions for accessing
> system memory atomically on supported systems.
>
> Regards,
>   Felix
>
>
> >
> > Thanks,
> > Lijo
> >
> >> -    if (device_info->needs_pci_atomics &&
> >> -        !kfd->pci_atomic_requested) {
> >> +    fw_version = amdgpu_amdkfd_get_fw_version(kgd, KGD_ENGINE_MEC1);
> >> +    if (!kfd->pci_atomic_requested &&
> >> +        device_info->needs_pci_atomics &&
> >> +        (!device_info->no_atomic_fw_version ||
> >> +          amdgpu_amdkfd_get_fw_version(kgd, KGD_ENGINE_MEC1) <
> >> +            device_info->no_atomic_fw_version)) {
> >>           dev_info(kfd_device,
> >>                "skipped device %x:%x, PCI rejects atomics\n",
> >>                pdev->vendor, pdev->device);
> >> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> >> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> >> index ab83b0de6b22..6d8f9bb2d905 100644
> >> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> >> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> >> @@ -207,6 +207,7 @@ struct kfd_device_info {
> >>       bool supports_cwsr;
> >>       bool needs_iommu_device;
> >>       bool needs_pci_atomics;
> >> +    uint32_t no_atomic_fw_version;
> >>       unsigned int num_sdma_engines;
> >>       unsigned int num_xgmi_sdma_engines;
> >>       unsigned int num_sdma_queues_per_engine;
> >>
