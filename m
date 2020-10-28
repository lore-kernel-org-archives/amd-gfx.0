Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB71C388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 14:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F7E247A3
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 14:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e9JDhYrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F7E247A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AA7B6E54C;
	Wed, 28 Oct 2020 14:45:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 812D96E544
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 14:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2VKgtHdUu+lLMAy970PmpmzrsHDGK83DT3U8oqm4W2NM3E/U05NC35aWjcWSpU254ISXNje6xi5bU2SkqTrns5AGf20Y/Y3jQjuvnbpvszlqziCdTxPqx2AfBIwNHSrHn7pU6PT2JYj6K8fEcEx5C+vh7xpRyozfgOFYxOJaOA+pRA01NpjONUqhtU/DqwXcgEXQJbEK/OcZQVt1J5W7xwW1FHPuheXO8TwuH5Rqt5qH972gdI/7RS8xB2iCagZWMRz3WbI9wmesaIqC5MzLkZmli14DFr2afxFOZg8VGI+5LTq9aDYIjv9LC6X3Mv81cZvDSzkpN5aAZFH2kvDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEz3AyPTvs6ge8xWVtI2Ejunph1fIW7RRSTuUoNohK4=;
 b=CaOT+lFAP2Yr6L0sy+tjzeL6JYUKZ8Syy0u7eHkWy8TdHzyoKgHnotmE6y/CLQi8w9FAKVL+SXkKw2NwXFjhl69hbUeBGl+PpFzVSd5hEL0Jt9cgDdzTr3wdIcG3izJSBgicdtAM+fKfhyVEEHHOnQprqE8Em+U+gt8/q2U7BF4rHpf6PiiJGkl8E2JrPjBt0UUAbvPI58B7oXDSDU5PCaE8IWeqtp3T4lWKdlVjrgfRb/2pnzqKTRdXpfrn/vhFv525bMJh76sMWYEmbH5437i0k2vMgvOEi7m1RIA29xTOqdzJO2SWOLHmM86Vr4NPgwq8KTijIZYGQ4AHvG1HDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEz3AyPTvs6ge8xWVtI2Ejunph1fIW7RRSTuUoNohK4=;
 b=e9JDhYrRduGYekMg+kOx2hB1ykN0qqHmmxkiZREeqSAQc+q0ezeKaHIqmT8PYPQUVwV/3YJFwVkRZKaV4MrnFhwZw4fl2ouSQCmdfue1zKPL4CzxBb/O91I2z2ZO2MY2ne3ZHu2t2hc2l6mVH8fruSac1IWZdykvN5Nm/MNYS0s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1836.namprd12.prod.outlook.com (2603:10b6:3:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 28 Oct
 2020 14:45:08 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067%7]) with mapi id 15.20.3477.029; Wed, 28 Oct 2020
 14:45:08 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu/display: remove DRM_AMD_DC_GREEN_SARDINE
From: Luben Tuikov <luben.tuikov@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
References: <20201016165004.1218352-1-alexander.deucher@amd.com>
 <CADnq5_M99PBm-GS55m3Q4aFY5U8xgb86zUTf4dX-1nhRoK7-fA@mail.gmail.com>
 <CADnq5_O+_fL7ssPgS94ib6=f=0+zbs48qvyO4MBtE9qce4=kbA@mail.gmail.com>
 <61f7a8cd-2548-8661-116c-fa6a7c4d882f@amd.com>
 <CADnq5_PON1F0bzbiGyw3Y1wRVpCpxYhOuO=YSyOaOfFecZeEbQ@mail.gmail.com>
 <f61735de-fbc7-3bc8-cf86-2b2d6285e321@amd.com>
Message-ID: <372c2caf-f60d-bb6e-1cb7-b7b85933944d@amd.com>
Date: Wed, 28 Oct 2020 10:45:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <f61735de-fbc7-3bc8-cf86-2b2d6285e321@amd.com>
Content-Language: en-CA
X-Originating-IP: [108.162.131.176]
X-ClientProxiedBy: YT1PR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::18) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.5] (108.162.131.176) by
 YT1PR01CA0109.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 14:45:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f5c36c7-6eb9-48fe-d0e7-08d87b5010b5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18360E00F684F3AC3A4AB50F99170@DM5PR12MB1836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:390;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibHyeV0Hf95KHgwB8HrqscaO8+hCTYDe8X06yIz1XtoM6GGQXZEfGftRCdEu5r8Az7zdzBc6fuJCmbkP7ASKJL7HqhVgvibR1TpYlCdFxZiv5v/0bh2FRsuEDkpzYAxZ3g/4ycNchaF35ok75D/PWJ7/DLExtP4/P//Zl4VPZ7DY3opAXKGk4wgamc1oUy+KfUe7x3l+Vd41LYhbgHGuZKZTin80Tbk77G7F86sy4Q+sa47YoxRyWTPnEgVXLPEYHG9m1B+NxkhRw5aCmT5RnTVKaqw1PyaAb/CsqaRBKtpbVEAUd/wOyAFnwqevMeMte7dgZdSfG66YMXHalBc+NKKCEkv/KPYCbInlooRU6wKntxanoYxT9/TmRsoWvEPZO4Tfpb4drnuEtUU7jJNQMwE8NSAbSA9hAxEonEL1ry0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(52116002)(36756003)(966005)(6916009)(16576012)(316002)(186003)(66946007)(8676002)(956004)(8936002)(55236004)(16526019)(2616005)(66476007)(26005)(6486002)(31696002)(31686004)(66556008)(4326008)(53546011)(45080400002)(83380400001)(5660300002)(44832011)(86362001)(6666004)(2906002)(4001150100001)(54906003)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: j9c5g73eSQSZEw3bFhlQy4VijHKDal3MirS3+jaVGXK2BXIlOX48PmGTvRpaUgTBhOhb/HH7hUlB4vnlQsXdT9/wtkhzxLUvTClbcaMwE/VqMmy4K6GBq4FuK0hTWmcJephj1/vXB9GuZ1lugWaagv7D9xbRKK7EWSGX2HQFRMfrAGMxm+TeocyqkhuDC4BG3O4Blne6RkHOhl2CZ632DLf2EzqjTz5y79KceJuGhFMiIvXrehQZ4SCMALI0Q0FfRQ6c+AVZeWv4/FS8A3nDhjYXiJ1o6uUncwgVCTRMvXkU+TQelBdjKIJWLgrKpHXHe2jtJfLa7pT52QIUeyQQYqDcOB2y3g3Xt+xw9uiNU30PEKpgGUvXONDAWAIeA0NGWuhPmldyhOf4vgOJvydKF4s3l4kdwXlZ+F/SzgFAmZeY1ghNoQJYZIqonslVlWDflXeQ3fsSzDkM0eDfQ2x4X3d54QGYZXFsFp4VT+B63rEq5y/q1bulsppDD5wQVhB9j/JeXAgx99FUCBid1uZVvmqrRXP5dZtpoinHBO5yDITTxKbsH1aLyDaz8G8McZahiVeuipRlarS+zf3wxCLumxBWyVtSR678t3mpi2kQ0UacYHGEsi9ND2vdlW0i4g3sbWaiT0yxK+Jf9mwibw4WZQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5c36c7-6eb9-48fe-d0e7-08d87b5010b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 14:45:08.2895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PV20dS948DVYE7NQM/Dm/VJVpip8ehRy+B1SldMZUTl/8oxFl/m1Oi9eX44kzrQD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1836
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-10-28 10:44, Luben Tuikov wrote:
> On 2020-10-27 11:19, Alex Deucher wrote:
>> On Mon, Oct 26, 2020 at 7:06 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>>
>>> Consolidating DCN seems like a good idea.
>>>
>>> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
>>
>> Is this for the whole series or just this patch?
> 
> Sorry, whose series!

"whole" :-)

> 
> Regards,
> Luben
> 
>>
>> Thanks!
>>
>> Alex
>>
>>>
>>> Regards,
>>> Luben
>>>
>>> On 2020-10-26 12:35 p.m., Alex Deucher wrote:
>>>> Ping again?
>>>>
>>>> On Thu, Oct 22, 2020 at 1:31 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>>>
>>>>> Ping on this series?
>>>>>
>>>>> Alex
>>>>>
>>>>> On Fri, Oct 16, 2020 at 12:50 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>>>>
>>>>>> No need for a separate config option at this point.
>>>>>>
>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/amd/display/Kconfig               | 8 --------
>>>>>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ------
>>>>>>  drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 2 --
>>>>>>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 --
>>>>>>  drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 --
>>>>>>  5 files changed, 20 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
>>>>>> index 93cdcd1ee9ff..cf87133f88e6 100644
>>>>>> --- a/drivers/gpu/drm/amd/display/Kconfig
>>>>>> +++ b/drivers/gpu/drm/amd/display/Kconfig
>>>>>> @@ -17,14 +17,6 @@ config DRM_AMD_DC_DCN
>>>>>>         help
>>>>>>           Raven, Navi and Renoir family support for display engine
>>>>>>
>>>>>> -config DRM_AMD_DC_GREEN_SARDINE
>>>>>> -       bool "Green Sardine support"
>>>>>> -       default y
>>>>>> -       depends on DRM_AMD_DC_DCN
>>>>>> -        help
>>>>>> -            Choose this option if you want to have
>>>>>> -            Green Sardine support for display engine
>>>>>> -
>>>>>>  config DRM_AMD_DC_DCN3_0
>>>>>>          bool "DCN 3.0 family"
>>>>>>          depends on DRM_AMD_DC && X86
>>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>> index 8a90063ac08a..2aa810d3554b 100644
>>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>> @@ -100,10 +100,8 @@ MODULE_FIRMWARE(FIRMWARE_SIENNA_CICHLID_DMUB);
>>>>>>  #define FIRMWARE_NAVY_FLOUNDER_DMUB "amdgpu/navy_flounder_dmcub.bin"
>>>>>>  MODULE_FIRMWARE(FIRMWARE_NAVY_FLOUNDER_DMUB);
>>>>>>  #endif
>>>>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>>>>  #define FIRMWARE_GREEN_SARDINE_DMUB "amdgpu/green_sardine_dmcub.bin"
>>>>>>  MODULE_FIRMWARE(FIRMWARE_GREEN_SARDINE_DMUB);
>>>>>> -#endif
>>>>>>  #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
>>>>>>  #define FIRMWARE_VANGOGH_DMUB "amdgpu/vangogh_dmcub.bin"
>>>>>>  MODULE_FIRMWARE(FIRMWARE_VANGOGH_DMUB);
>>>>>> @@ -985,10 +983,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>>>>>         case CHIP_RAVEN:
>>>>>>         case CHIP_RENOIR:
>>>>>>                 init_data.flags.gpu_vm_support = true;
>>>>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>>>>                 if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
>>>>>>                         init_data.flags.disable_dmcu = true;
>>>>>> -#endif
>>>>>>                 break;
>>>>>>         default:
>>>>>>                 break;
>>>>>> @@ -1289,10 +1285,8 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
>>>>>>         case CHIP_RENOIR:
>>>>>>                 dmub_asic = DMUB_ASIC_DCN21;
>>>>>>                 fw_name_dmub = FIRMWARE_RENOIR_DMUB;
>>>>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>>>>                 if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
>>>>>>                         fw_name_dmub = FIRMWARE_GREEN_SARDINE_DMUB;
>>>>>> -#endif
>>>>>>                 break;
>>>>>>  #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
>>>>>>         case CHIP_SIENNA_CICHLID:
>>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
>>>>>> index b361dc6c3489..19d97ed6beb8 100644
>>>>>> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
>>>>>> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
>>>>>> @@ -170,12 +170,10 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
>>>>>>                         break;
>>>>>>                 }
>>>>>>
>>>>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>>>>                 if (ASICREV_IS_GREEN_SARDINE(asic_id.hw_internal_rev)) {
>>>>>>                         rn_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
>>>>>>                         break;
>>>>>>                 }
>>>>>> -#endif
>>>>>>                 if (ASICREV_IS_RAVEN2(asic_id.hw_internal_rev)) {
>>>>>>                         rv2_clk_mgr_construct(ctx, clk_mgr, pp_smu);
>>>>>>                         break;
>>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>>>>> index ab105f26b511..419c0df08602 100644
>>>>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>>>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>>>>> @@ -126,10 +126,8 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
>>>>>>                         dc_version = DCN_VERSION_1_01;
>>>>>>                 if (ASICREV_IS_RENOIR(asic_id.hw_internal_rev))
>>>>>>                         dc_version = DCN_VERSION_2_1;
>>>>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>>>>                 if (ASICREV_IS_GREEN_SARDINE(asic_id.hw_internal_rev))
>>>>>>                         dc_version = DCN_VERSION_2_1;
>>>>>> -#endif
>>>>>>                 break;
>>>>>>  #endif
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
>>>>>> index b4c3838322af..2bf60ac2974f 100644
>>>>>> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
>>>>>> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
>>>>>> @@ -209,12 +209,10 @@ enum {
>>>>>>  #if defined(CONFIG_DRM_AMD_DC_DCN3_02)
>>>>>>  #define ASICREV_IS_DIMGREY_CAVEFISH_P(eChipRev)        ((eChipRev >= NV_DIMGREY_CAVEFISH_P_A0) && (eChipRev < NV_UNKNOWN))
>>>>>>  #endif
>>>>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>>>>  #define GREEN_SARDINE_A0 0xA1
>>>>>>  #ifndef ASICREV_IS_GREEN_SARDINE
>>>>>>  #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
>>>>>>  #endif
>>>>>> -#endif
>>>>>>  #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
>>>>>>  #define FAMILY_VGH 144
>>>>>>  #define DEVICE_ID_VGH_163F 0x163F
>>>>>> --
>>>>>> 2.25.4
>>>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cluben.tuikov%40amd.com%7Cebbddd534b63463bae5608d87a8bb4b8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637394087755082027%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=sKPbRrnSf2jFwAHazGUPCjyF%2BgSjgjGSPce26MxnmAQ%3D&amp;reserved=0
>>>>
>>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cluben.tuikov%40amd.com%7Cebbddd534b63463bae5608d87a8bb4b8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637394087755092027%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=7OOuQ%2FzAhkmlqS%2FPdTA2wg9TIFQsBIeJ95TBro4kPH4%3D&amp;reserved=0
>>
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
