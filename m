Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29BFC2D0E4
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 19:14:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2739020B80
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 19:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3EdnRXFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2739020B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 413866E408;
	Thu, 12 Nov 2020 19:14:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8422C6E3F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 19:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgOqIpJ1EKctZa/+7j4nOji4g60uKnQRDVzoRE/xug6LU11w2XtMnKRZ+yzP3D1sZdK4aPTQ/i4lbhmRecbhcj8C8MsubdxF7pOdGGESnuqWDqWCPeQ1lnOVHoLrSf28nkWQ3zlbFlTQFu8SUmWqjDgtwyMqsRaE+4qOew5fLO+Z/EdKwdHHrJMw/Xpkhli2eCvUk1fdLHpJXt2tSVjaciRCATzXuNrumB0G99WI6cljuQO6u2bh0TJGZapcR6WjfYOkRjBqNob4qZIBReGLSJO+Kdx8Vg7OcS51lBIuOajIJE834PSc/BW4S0RIMU0w/fYGJlWtTBApc64YXtPhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRiR/aGeVCsgtcU9ngNLG5vYbcX83Ebd369AxSiYbB8=;
 b=Xx7LxW3G/cPfKka2VkkY37b81M8/8FASmcZ29OvSUi1L71sw4fUGaZnKvjKffGE1SCIZNuRuXjlXZqvkUrOxHG5Oyvv837pPns6duFLh6ykEkmAF9xTseueHCfZvGIaWvdNQFDC4janJ02iKHLIjBIh7F+ZVbp8fgqrpM3hrAA80PRN0Q7px9bpY+0jVKluKcK0Lv7zijKYhePz2VfmNW6qjVjTiP9IzlH/dQQu/WPUjWjH+dKs8REwrkfcOLhfu2XAMulaHKXK0kGZXBzGBjZ8/uDvZr9mOtvDQZB9e8j9BAJCVn305N7q1Pbp3WY73pNcjYxH0N0VTBdWDMd/6wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRiR/aGeVCsgtcU9ngNLG5vYbcX83Ebd369AxSiYbB8=;
 b=3EdnRXFrLQtqBWQR6em3nlyqFcyz+fB+4rZznlangjpJ0q6OCvAATRHkRJWdfImsKYg0Xv4Re/MrExPyk+bxdSJZbrGKnO81HVIJ4kHgzjXFvcdU52BFw0g8rUNESI88EGHNSvdvXOfHhwNo96GdsZVtkkOnHNYp3Pu9r0dkpFk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB2472.namprd12.prod.outlook.com (2603:10b6:4:b9::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25; Thu, 12 Nov 2020 19:14:45 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a%7]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 19:14:44 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu: add vcn dec software ring enabled
 parameter
To: Alex Deucher <alexdeucher@gmail.com>
References: <1605133674-21093-1-git-send-email-James.Zhu@amd.com>
 <CADnq5_OuXH4iWR7baRsUDTO3BMe=TditrXgCqvzC1U_pb27saQ@mail.gmail.com>
 <9971c116-faf9-7ebe-0b59-4ff1b5cd25ae@amd.com>
 <CADnq5_O957h_HosBL=mMhwrY+0xkFvZypCVgnsJZ4e2gq1Xbpg@mail.gmail.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <eef89f33-6760-41e5-731c-d2a1b362d042@amd.com>
Date: Thu, 12 Nov 2020 14:14:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_O957h_HosBL=mMhwrY+0xkFvZypCVgnsJZ4e2gq1Xbpg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::21) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.230.192] (165.204.55.251) by
 YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Thu, 12 Nov 2020 19:14:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 58b30a9f-f7e3-4770-ab6c-08d8873f36d3
X-MS-TrafficTypeDiagnostic: DM5PR12MB2472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24721551F798536CBE624A3CE4E70@DM5PR12MB2472.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hibXmmWlpT8TzeHOPW4b1UexdrjvuZ1UIFe829XLPyRCmZ67nePCKIpWLM6v3GE8n5qjKJGWnRvQBvxOIJhFxQeriLfNOz3xAVgWxtvJO1KcG/baF2xMiCesSRWd4BitWcR9Zog5ujr7ZJKrKR2oM2NRgwdBLtiED8wEN9L13d7TEc2kSiaLiJC/mkaHpyGMMpduxwsnqY4Id7SftbscGelXrpLv3zACWJESKW/rGpG0jXOFUqpdTIOzUCfqg39Ns8dSqUYslKqkMN0/XFSTdBYZlAi1hh6a21GxV1iEoITS0DAH3D8Gdlm+gQU3++2iH1QiahgUocgd9PU69FZnrTDHSGZwPaKVvSH2hH2SFHSsIbQKO2x/PV7n7BDaOeMBmeK/aHbVl6ju6CDNzBeP0xSOUhjma44jBVGew3JRn9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(4326008)(52116002)(5660300002)(36916002)(53546011)(45080400002)(2906002)(6916009)(4001150100001)(6486002)(36756003)(31686004)(31696002)(26005)(966005)(66476007)(16576012)(16526019)(54906003)(66556008)(316002)(478600001)(66946007)(8936002)(8676002)(186003)(2616005)(956004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: V1OM4OfV8sYmpS/IySOAnRccZVixRynauF4mdHsf5/411tnx4Pp1keczAM+nabFVSfIRgELCNoNToG4+4AKdFfnCsiAPyJmJ10VvquIu4fd1J97YWkm786kkfiYy0zK56FgKXuVJwgfaAP1MXNStOLttF8ZbEqNGoe7JBAZaIQXQduXhHgkyfef7juFS1so3LgVa3ChNwqjqOQ5adkNX4lUC8jfum7m7Zly2xYW2vnyBHmnDETj0Bhl/mjSslDPHSQMjfzaEtZIBMLPtAHEQ4dylGcFv6OEn2f0xvNPJ+JCjfHby9insWWVVIGPZwv/sEoYEeMCoyOtUmClzIG/dhSd7Zu4/dDcQRg2dihHGBp67pPtuSuVjxoz+SS64KAEHNwDjRjPJk0iFiQO7Tg/BcXsBgX+CiXcmRp1pV20G5+lFVixAg2AjDT5w1Ys7Tbuztr+i5lSUyjLL09OMyuAJkGt5wcGjgHtT+jh/b7OiPynrl2ooXOAOF2CcfEs1kLmky4mNrB+oUfNwwoAhg6PgYG/534b0oTXA3Y5ajIDRt+4VorViOh8zjxMsCoVlrismau8cykSDIgBICn6R068fx/bLiTX4g1Iz4gHTTqyx92BDle2XZ9TRON5xRroP7icFedHwm0uISv8uhp9UbwExejnkcuHvD48vZTQYVoERLb4nBUosdWKocwHgtiIVaGkIpHafqpFHFqeTmFUPgKoRTUhK1X2wGBHp2GOiQcb5hbLtYcv6+oK9oaW9d+KxQMTJ7nVPaQ9BWVt9pMQGuWckbDFROxGSIKwVEq1s5LtcBUpRll3Rcxhp5JObSutWCduDU47XvoQyxvLc5TDjif0xWmnMxLGOvVLQJcmuo7WG9mKrYWvAh32AC1ktwsNax2UPNXD8vVdisUsEvL8/YEZaqQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b30a9f-f7e3-4770-ab6c-08d8873f36d3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 19:14:44.8264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPWu71HcgiN4CMFmnHng8bO5fi9tc+jQ8pIG8c+qeNaGPDvK8NBY2KRjCPnxhfJZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2472
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
Cc: James Zhu <James.Zhu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2020-11-12 1:57 p.m., Alex Deucher wrote:
> On Thu, Nov 12, 2020 at 10:23 AM James Zhu <jamesz@amd.com> wrote:
>>
>> On 2020-11-12 9:23 a.m., Alex Deucher wrote:
>>> On Wed, Nov 11, 2020 at 5:28 PM James Zhu <James.Zhu@amd.com> wrote:
>>>> This allows us to enable dec software ring feature on VCN.
>>>> The default is 0 for all asics, and it is only valid for
>>>> asics with vcn3.0 and above.
>>>>
>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>> Reviewed-by: Leo Liu <leo.liu@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
>>>>    2 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index 20400ec..cc47da6 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -209,6 +209,7 @@ extern int amdgpu_si_support;
>>>>    extern int amdgpu_cik_support;
>>>>    #endif
>>>>    extern int amdgpu_num_kcq;
>>>> +extern int amdgpu_dec_sw_ring_enabled;
>>>>
>>>>    #define AMDGPU_VM_MAX_NUM_CTX                  4096
>>>>    #define AMDGPU_SG_THRESHOLD                    (256*1024*1024)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index 999f84d..570088f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -160,6 +160,7 @@ int amdgpu_force_asic_type = -1;
>>>>    int amdgpu_tmz;
>>>>    int amdgpu_reset_method = -1; /* auto */
>>>>    int amdgpu_num_kcq = -1;
>>>> +int amdgpu_dec_sw_ring_enabled;
>>>>
>>>>    struct amdgpu_mgpu_info mgpu_info = {
>>>>           .mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
>>>> @@ -806,6 +807,13 @@ module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
>>>>    MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
>>>>    module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
>>>>
>>>> +/**
>>>> + * DOC: dec_sw_ring_enabled (uint)
>>>> + * Override vcn decode software ring features enabled.
>>>> + */
>>>> +MODULE_PARM_DESC(dec_sw_ring_enabled, "vcn dec sw ring support (1 = enable, 0 = disable (default))");
>>>> +module_param_named(dec_sw_ring_enabled, amdgpu_dec_sw_ring_enabled, int, 0444);
>>> How about just vcn_sw_ring as the parameter name?
>> [JZ] It is for decode ring only. if just use vcn_sw_ring. I am not sure
>> if it will confuse people.
> Are we intending to have a separate enable option for enc?  If so, is
> there value in that vs just having one knob for both?

[JZ] VCN ENC is using software ring from the beginning. So only

vcn3 dec supports both hardware ring and software ring.

>
> Alex
>
>
>>>> +
>>>>    static const struct pci_device_id pciidlist[] = {
>>>>    #ifdef  CONFIG_DRM_AMDGPU_SI
>>>>           {0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
>>>> --
>>>> 2.7.4
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJames.Zhu%40amd.com%7Cd5c7a6f7a7c64c60436b08d8873cc5ad%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637408042373143039%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2F7n0SEiVnX2z6AfuwQaUEqlFmLLrQKs7wBHJgagW0OU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
