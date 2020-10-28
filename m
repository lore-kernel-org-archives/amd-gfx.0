Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6F4C388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 14:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B84247A3
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 14:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mqtI6V6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B84247A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FF5B6E546;
	Wed, 28 Oct 2020 14:44:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 685856E546
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 14:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4m2VXya9OyDSneT0jdlaA7EuADMbe62VDb6G8Jl9jt2y1Dv49upnTP2KiQjT1IRCG2/so+EWVyu4ZtbC2AIv+eQt1ByKNPX3zPnkNHtwVqaLSc3gGa7UtAsMbRNDXNG3MdEkBoMdbVWPCLnebQR9DgO1AERIQ+HlpfcmqXSqQI4aDKZgAxcIRdWv3s7Z0sGNQBcOsc/+AgdiyE5e08IzUPEDzo6hZW1xx+inqFHLU6ycnHmfMbpxs4W6PeW7Bq6CmNDxasqo0vy1yPNk1DuCejf74mOisyYP7RNgaX1P+6eeFBAzcGmp8Y0LTBl0Yn46WaGDXLNKLc40rcU10CpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx5iZYtu0VJ0Bm0b/D8XiwYaWE4Zs1Jh6R/8ironVEc=;
 b=V3+8jlk8m4l2X9j3K0x+29GdD9YixFNIUwp1G9xsB0PHjR4MlWWxvOzVfikdGZjCrIcmeWTEx6oo31vTgIaTCbvFNnAAmxK4zcn5Zhnmt58TBh+oQWPubtdu5McSCIJn9RSxL8aZtkLCd1JutPwI5niL57rTew70L81K7WeTTsALMkB5QrO3SP5KX5zSE8XmFPXFZtiTtEYoPhz0ibKytXZbwsMecdDXqN7tj1+S1bUoEf4BQL/a4IGKeaL7RqqDnYjcUDMCoOXuvAhKyyHVhRLpWgR6c1NwNX8fCsxGvL3hwXNAOny6ce90f5qG1Chw/cnmygA/KUzRinR1dll7tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx5iZYtu0VJ0Bm0b/D8XiwYaWE4Zs1Jh6R/8ironVEc=;
 b=mqtI6V6IiOupZGFE+P/GansuORSxQ127Dms5GUTz1E1jUoL3+NA0xehTNJ8tSfhT9OCCr0YXIpoMsL0hgP59A/Bh31jCYegT4xJf/R+iAqt6s8ZskIMYDeFL/vm7kbwmq4E3xPqauH3DFgvtT7IBr6SNoeQxz1KQp+JMzjYjfvE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1836.namprd12.prod.outlook.com (2603:10b6:3:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 28 Oct
 2020 14:44:07 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067%7]) with mapi id 15.20.3477.029; Wed, 28 Oct 2020
 14:44:07 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu/display: remove DRM_AMD_DC_GREEN_SARDINE
To: Alex Deucher <alexdeucher@gmail.com>
References: <20201016165004.1218352-1-alexander.deucher@amd.com>
 <CADnq5_M99PBm-GS55m3Q4aFY5U8xgb86zUTf4dX-1nhRoK7-fA@mail.gmail.com>
 <CADnq5_O+_fL7ssPgS94ib6=f=0+zbs48qvyO4MBtE9qce4=kbA@mail.gmail.com>
 <61f7a8cd-2548-8661-116c-fa6a7c4d882f@amd.com>
 <CADnq5_PON1F0bzbiGyw3Y1wRVpCpxYhOuO=YSyOaOfFecZeEbQ@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <f61735de-fbc7-3bc8-cf86-2b2d6285e321@amd.com>
Date: Wed, 28 Oct 2020 10:44:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <CADnq5_PON1F0bzbiGyw3Y1wRVpCpxYhOuO=YSyOaOfFecZeEbQ@mail.gmail.com>
Content-Language: en-CA
X-Originating-IP: [108.162.131.176]
X-ClientProxiedBy: YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::9) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.5] (108.162.131.176) by
 YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 14:44:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24112d3b-ee5e-44b5-1417-08d87b4fec7e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1836B68ACF6700DFBD6AEB7899170@DM5PR12MB1836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:390;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GhXWFzZWrw/WIlJxdHnag7jvxfstxPaPSQL6Lxpt3A62xUNyHlLk2VueA+azKRsorUUc9ovbDZN/YflY7ivw+n3yMWM0+bjqRQ1FS9UWrPbl5f3Fq+Cy0BEGg/gBZp8Qy44gzcs9pJRyTSpcoIvhoNHba7HRpMstNHbx1ey5czb08Z3UdQdlQH4XbIxtwdRtwZhEjGneAhXibTPukycbNMc+0QWKvcFmaQAn4HUvwF7O1U1Cz9URO7TlnrGacHNdi8uHKShyuBTW8ZkogHEoILmvPmEHcpPNj0JPQigDpdBjn1MZGhbCX/JSwAMbAVhu3YV8xlCr2zcZtbRSxXBAzMkVNDG/1yJQNNFkKEJvqlgfj58XVNqmIjV0dl6rN9aHfD0iJGqqMJpmVl2F5UipQl72fUWm4ZY0HVtup+PrBGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(52116002)(36756003)(966005)(6916009)(16576012)(316002)(186003)(66946007)(8676002)(956004)(8936002)(55236004)(16526019)(2616005)(66476007)(26005)(6486002)(31696002)(31686004)(66556008)(4326008)(53546011)(45080400002)(83380400001)(5660300002)(44832011)(86362001)(6666004)(2906002)(4001150100001)(54906003)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9A+pB1zV9vnlU6eBLWkp8RtgA3/AZUKpyoi7LS9PbhrBTFNic7cGzssOwZZbzwCCHDhTrgzkOyqdWjdTAnFQKdhsQihjkWQPG/NPNkROnwucdXiQmx8XDC2T3KBe9ZPBybkWbybvTNV9hbXFBb0N9bWIS/mSjAFR8H3CUnc/v0ND/1L03duXu0uf1rGOEjQK2mmIzsRXpTJ+59LbjQEL/Y8KvmMtkHC1okj20fGMOXuI1KK0K85JLhfD0gUN/kIxz/mY5+1vh7eQ3L+SkAId2iKzDXZo2ePOGP8+Y/ORFlXJm+zH1yr6f4RBlpnb4qbkNpTACmZ0Vr0i/d6mEPV2eTvf7/D3BS9FpsqLiWFGNR2JkMOkGyA59Vl4p49sTV4asdgds1l0m5pM3mRX+iHLJC0GB92GKleAzMnx1uXT8HcmZQ9ONikSMJyLxUnCb0wkwLmYjZ2riBrMeDhUWkQOdQU3nYEiXOGc7K3feEwTS7H+HOD8RNEOE/MxkxTbBR9LOF4yzOapww/+FSVgsCY8hrDPMg731uDwz9EMTKfzHIunWhpVPb2IJY82a8uOoRrpiNHDc3bXDB+nkPE8c3rDoIlpTV1O0V54yOcayFMo7qsRNEvEwLGhK1is6demFQtVtqUFtXqsMw4V10uZWMc9Xw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24112d3b-ee5e-44b5-1417-08d87b4fec7e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 14:44:07.5532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKop/+P6LlYl434OKhnnXeLxXCMhOF3jIriY+6Is05+NApmfrsKzwSS3xpCgJxYD
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

On 2020-10-27 11:19, Alex Deucher wrote:
> On Mon, Oct 26, 2020 at 7:06 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>
>> Consolidating DCN seems like a good idea.
>>
>> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
> 
> Is this for the whole series or just this patch?

Sorry, whose series!

Regards,
Luben

> 
> Thanks!
> 
> Alex
> 
>>
>> Regards,
>> Luben
>>
>> On 2020-10-26 12:35 p.m., Alex Deucher wrote:
>>> Ping again?
>>>
>>> On Thu, Oct 22, 2020 at 1:31 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>>
>>>> Ping on this series?
>>>>
>>>> Alex
>>>>
>>>> On Fri, Oct 16, 2020 at 12:50 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>>>
>>>>> No need for a separate config option at this point.
>>>>>
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/display/Kconfig               | 8 --------
>>>>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ------
>>>>>  drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 2 --
>>>>>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 --
>>>>>  drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 --
>>>>>  5 files changed, 20 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
>>>>> index 93cdcd1ee9ff..cf87133f88e6 100644
>>>>> --- a/drivers/gpu/drm/amd/display/Kconfig
>>>>> +++ b/drivers/gpu/drm/amd/display/Kconfig
>>>>> @@ -17,14 +17,6 @@ config DRM_AMD_DC_DCN
>>>>>         help
>>>>>           Raven, Navi and Renoir family support for display engine
>>>>>
>>>>> -config DRM_AMD_DC_GREEN_SARDINE
>>>>> -       bool "Green Sardine support"
>>>>> -       default y
>>>>> -       depends on DRM_AMD_DC_DCN
>>>>> -        help
>>>>> -            Choose this option if you want to have
>>>>> -            Green Sardine support for display engine
>>>>> -
>>>>>  config DRM_AMD_DC_DCN3_0
>>>>>          bool "DCN 3.0 family"
>>>>>          depends on DRM_AMD_DC && X86
>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> index 8a90063ac08a..2aa810d3554b 100644
>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> @@ -100,10 +100,8 @@ MODULE_FIRMWARE(FIRMWARE_SIENNA_CICHLID_DMUB);
>>>>>  #define FIRMWARE_NAVY_FLOUNDER_DMUB "amdgpu/navy_flounder_dmcub.bin"
>>>>>  MODULE_FIRMWARE(FIRMWARE_NAVY_FLOUNDER_DMUB);
>>>>>  #endif
>>>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>>>  #define FIRMWARE_GREEN_SARDINE_DMUB "amdgpu/green_sardine_dmcub.bin"
>>>>>  MODULE_FIRMWARE(FIRMWARE_GREEN_SARDINE_DMUB);
>>>>> -#endif
>>>>>  #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
>>>>>  #define FIRMWARE_VANGOGH_DMUB "amdgpu/vangogh_dmcub.bin"
>>>>>  MODULE_FIRMWARE(FIRMWARE_VANGOGH_DMUB);
>>>>> @@ -985,10 +983,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>>>>         case CHIP_RAVEN:
>>>>>         case CHIP_RENOIR:
>>>>>                 init_data.flags.gpu_vm_support = true;
>>>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>>>                 if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
>>>>>                         init_data.flags.disable_dmcu = true;
>>>>> -#endif
>>>>>                 break;
>>>>>         default:
>>>>>                 break;
>>>>> @@ -1289,10 +1285,8 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
>>>>>         case CHIP_RENOIR:
>>>>>                 dmub_asic = DMUB_ASIC_DCN21;
>>>>>                 fw_name_dmub = FIRMWARE_RENOIR_DMUB;
>>>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>>>                 if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
>>>>>                         fw_name_dmub = FIRMWARE_GREEN_SARDINE_DMUB;
>>>>> -#endif
>>>>>                 break;
>>>>>  #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
>>>>>         case CHIP_SIENNA_CICHLID:
>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
>>>>> index b361dc6c3489..19d97ed6beb8 100644
>>>>> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
>>>>> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
>>>>> @@ -170,12 +170,10 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
>>>>>                         break;
>>>>>                 }
>>>>>
>>>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>>>                 if (ASICREV_IS_GREEN_SARDINE(asic_id.hw_internal_rev)) {
>>>>>                         rn_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
>>>>>                         break;
>>>>>                 }
>>>>> -#endif
>>>>>                 if (ASICREV_IS_RAVEN2(asic_id.hw_internal_rev)) {
>>>>>                         rv2_clk_mgr_construct(ctx, clk_mgr, pp_smu);
>>>>>                         break;
>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>>>> index ab105f26b511..419c0df08602 100644
>>>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>>>> @@ -126,10 +126,8 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
>>>>>                         dc_version = DCN_VERSION_1_01;
>>>>>                 if (ASICREV_IS_RENOIR(asic_id.hw_internal_rev))
>>>>>                         dc_version = DCN_VERSION_2_1;
>>>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>>>                 if (ASICREV_IS_GREEN_SARDINE(asic_id.hw_internal_rev))
>>>>>                         dc_version = DCN_VERSION_2_1;
>>>>> -#endif
>>>>>                 break;
>>>>>  #endif
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
>>>>> index b4c3838322af..2bf60ac2974f 100644
>>>>> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
>>>>> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
>>>>> @@ -209,12 +209,10 @@ enum {
>>>>>  #if defined(CONFIG_DRM_AMD_DC_DCN3_02)
>>>>>  #define ASICREV_IS_DIMGREY_CAVEFISH_P(eChipRev)        ((eChipRev >= NV_DIMGREY_CAVEFISH_P_A0) && (eChipRev < NV_UNKNOWN))
>>>>>  #endif
>>>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>>>  #define GREEN_SARDINE_A0 0xA1
>>>>>  #ifndef ASICREV_IS_GREEN_SARDINE
>>>>>  #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
>>>>>  #endif
>>>>> -#endif
>>>>>  #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
>>>>>  #define FAMILY_VGH 144
>>>>>  #define DEVICE_ID_VGH_163F 0x163F
>>>>> --
>>>>> 2.25.4
>>>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cluben.tuikov%40amd.com%7Cebbddd534b63463bae5608d87a8bb4b8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637394087755082027%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=sKPbRrnSf2jFwAHazGUPCjyF%2BgSjgjGSPce26MxnmAQ%3D&amp;reserved=0
>>>
>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cluben.tuikov%40amd.com%7Cebbddd534b63463bae5608d87a8bb4b8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637394087755092027%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=7OOuQ%2FzAhkmlqS%2FPdTA2wg9TIFQsBIeJ95TBro4kPH4%3D&amp;reserved=0
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
