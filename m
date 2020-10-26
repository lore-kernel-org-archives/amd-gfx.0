Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED16C4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 23:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A1F20708
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 23:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L9v7/26c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A1F20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D96F76EA87;
	Mon, 26 Oct 2020 23:06:41 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760051.outbound.protection.outlook.com [40.107.76.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 045226EA87
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 23:06:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9MJksGr8oZqHBQOXzjbxpz9+ojfiG2b5LZSuhtmS0dNZzfWzm6b+Ct3ALFz/7pOPlskjs3Tic64le2fim/qbgLDdJmIr6LWw9MJDJKFipWYvrRRrJ+SxEsWTJH7OyktctDGT1agsH0VLuI1Nr3AjrkiYu9V6NFLDmGPrH6IML5djfFy57QxgqOXjlnCrCp8/fhPpjicDouElhGhgMJ9ALPx5JTXjIXMQ66BhHZ8Bt9/Mr31BxLJzkoXfKde4O9fkowfL6BJ6pp2KiGVqYnsrPvfEXmNoaucZ9ckNcig6nRC+Tn2uI550DbGdda3eZMz4MuLa0z1rqxO+bdZyknV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RUt7O4tT5QUmzzJ+79W30JHJ4AFu2B1p6kexD689pE=;
 b=NTJxnHbWIOmVuPPKTO98S485df78sc1yeVJzw3jF4reH3W6q4IRVRk6nUBSaY6YzkYgQBpIkVvlhsXEVUpmAtTgMZyPjyFHsAxZhbIs3XY48p1wvi8t2hPRQd7x5QGxa2ZombQcVmF5nm4y0hU7fO+pF+mnsuBHDI0VwsolhDHispMitYkpcqodbcXaYj6/x1Kz92dehwR7MeRIWXmtoxbCsqy+ivm6z+d/26xdEOoPKOQEMwpuNqC7yW3Xlra//XpigfTzBIMkD3MKPd2AaUWIT9Tt26B/VbekY6VTB7EMSA/6akyJue+nMO0JiQNRN+y/GYs28tj+/I3gUs9+iRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RUt7O4tT5QUmzzJ+79W30JHJ4AFu2B1p6kexD689pE=;
 b=L9v7/26c/2iWk1ZrZ1zTSq4PAuWHkuXlyvsbwy+8qhmDhmUyGC+4A89PYnw6zoP9YaqvFruPEBAU43VEMGDFTX3XUr4/O5qfKS6DYVpeXX1ewrn7LDtjCtjhsbbmLowiCHB+jYBddGNkBOJj7Zr/ANv8b4hwOAPm2Vo0S/Me2JE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 26 Oct
 2020 23:06:37 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067%7]) with mapi id 15.20.3477.029; Mon, 26 Oct 2020
 23:06:37 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu/display: remove DRM_AMD_DC_GREEN_SARDINE
To: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20201016165004.1218352-1-alexander.deucher@amd.com>
 <CADnq5_M99PBm-GS55m3Q4aFY5U8xgb86zUTf4dX-1nhRoK7-fA@mail.gmail.com>
 <CADnq5_O+_fL7ssPgS94ib6=f=0+zbs48qvyO4MBtE9qce4=kbA@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <61f7a8cd-2548-8661-116c-fa6a7c4d882f@amd.com>
Date: Mon, 26 Oct 2020 19:06:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <CADnq5_O+_fL7ssPgS94ib6=f=0+zbs48qvyO4MBtE9qce4=kbA@mail.gmail.com>
Content-Language: en-GB
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::17) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 23:06:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3bf377d4-9722-4789-4ec7-08d87a03ca9c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2502A6E04D5C3E16BFAD21EA99190@DM5PR12MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:275;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPViDz6A/KX2cQcOX/TI3eZ9OG/XeElZqRuwQ67awnuly8pcTP24IEZmdwoqxm9SA08EuGyIF823yhG90HqMT8MDThkmYXECCQrFbCi+0isotybb7TyFLNfOHxIkS9zeL2nc4pN0mqzks8JAtOMs4CEtWG8YOhA+F+4/CkGfZISpvNdNOlULr5Q3S/ysG47bdRWIv0oNiKh8C4au8I5dsYRX/RwSORB9ZfzrGApxBNb3Q5lApAnNosqnnYne7n8z3jZPvhhAvf0Y74o1mZDWuyIuQOknAh+QDkBa1gOf6r63zczd6KjkkMdFHMiKf48nMZ4YZEX8xgaCFdEBTujcVuDyzkxquPxXJnFycVCQjTB93Dv2DmU4gVJthhupJwqVP+fmELL501art35ygyFY4YQ6hK1cJPH6JFPGxn0qFZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(478600001)(5660300002)(966005)(186003)(66946007)(2616005)(26005)(4001150100001)(2906002)(8676002)(45080400002)(31686004)(66556008)(66476007)(6512007)(110136005)(16526019)(36756003)(8936002)(44832011)(956004)(316002)(4326008)(6506007)(31696002)(53546011)(83380400001)(6486002)(86362001)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LrPuu/Oa1J89wwBPWHXiBGX1i58BxtUDKxcCp6zufmLd71ix2nu9GX1asCtsLfqB7PsrAkFapK1aTHE/7OATPMTqsMb0uEBZX9Yzi3U6Lvpe44PjVAsr9IlVR7JFpc24FhJUlIdHJrc+Zr+2Hye93k2ug14yn8QMz18jIhrzCyIYyKOYW3JcvnlMiAhRTl/rmRjO27aBdNs0NK/zF7cyVDBVtOdGfLuTrnG/F/GOC3gMaox2fOWZngx6NHfsiNyciF2sguNeUPmVWJuJpSsWLxiEhXBxsAWYfBSK9Dy//j9PXZqW4Is17+TzflEy1wuEj4VrMxsBUahwc5yNUnyUJr1nKf9mzJOwTxK6OqqHeMC4WDcc4eEJXL/+t/QKQaxGkcJe7mbp/i4Z/RNTCxWBDadtx3nZ85bpNkMsLZYwXR7QogI1/+NA5dI/a8Js+e38Rh0eBMGH3Esoq+YKDXiakw/ixlk6SgJBjMmghSEILiHdeHvThkORirglmCoHenXi3WjFGU2EdZT5fDvjtdcs+OETBaQTrtc9NIcH8Vj1/PP4mMOk2f+zytfGviMu+FSI17AcPhQZ+RnW1KGjIxGW/1SgyMbpKb0LefMRWvo+NuOWL3nDNGlvxSA7icUTEMWU8Uhv3J0Cw+er/GYrPvdErw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf377d4-9722-4789-4ec7-08d87a03ca9c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 23:06:37.7626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tngdTbJvsFB5ASOcjcRZVpMlezAUs0cQQde62LrVFGvBsDOJbWNPpRS73kOIzJVN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Consolidating DCN seems like a good idea.

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2020-10-26 12:35 p.m., Alex Deucher wrote:
> Ping again?
> 
> On Thu, Oct 22, 2020 at 1:31 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> Ping on this series?
>>
>> Alex
>>
>> On Fri, Oct 16, 2020 at 12:50 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>
>>> No need for a separate config option at this point.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/display/Kconfig               | 8 --------
>>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ------
>>>  drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 2 --
>>>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 --
>>>  drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 --
>>>  5 files changed, 20 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
>>> index 93cdcd1ee9ff..cf87133f88e6 100644
>>> --- a/drivers/gpu/drm/amd/display/Kconfig
>>> +++ b/drivers/gpu/drm/amd/display/Kconfig
>>> @@ -17,14 +17,6 @@ config DRM_AMD_DC_DCN
>>>         help
>>>           Raven, Navi and Renoir family support for display engine
>>>
>>> -config DRM_AMD_DC_GREEN_SARDINE
>>> -       bool "Green Sardine support"
>>> -       default y
>>> -       depends on DRM_AMD_DC_DCN
>>> -        help
>>> -            Choose this option if you want to have
>>> -            Green Sardine support for display engine
>>> -
>>>  config DRM_AMD_DC_DCN3_0
>>>          bool "DCN 3.0 family"
>>>          depends on DRM_AMD_DC && X86
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 8a90063ac08a..2aa810d3554b 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -100,10 +100,8 @@ MODULE_FIRMWARE(FIRMWARE_SIENNA_CICHLID_DMUB);
>>>  #define FIRMWARE_NAVY_FLOUNDER_DMUB "amdgpu/navy_flounder_dmcub.bin"
>>>  MODULE_FIRMWARE(FIRMWARE_NAVY_FLOUNDER_DMUB);
>>>  #endif
>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>  #define FIRMWARE_GREEN_SARDINE_DMUB "amdgpu/green_sardine_dmcub.bin"
>>>  MODULE_FIRMWARE(FIRMWARE_GREEN_SARDINE_DMUB);
>>> -#endif
>>>  #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
>>>  #define FIRMWARE_VANGOGH_DMUB "amdgpu/vangogh_dmcub.bin"
>>>  MODULE_FIRMWARE(FIRMWARE_VANGOGH_DMUB);
>>> @@ -985,10 +983,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>>         case CHIP_RAVEN:
>>>         case CHIP_RENOIR:
>>>                 init_data.flags.gpu_vm_support = true;
>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>                 if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
>>>                         init_data.flags.disable_dmcu = true;
>>> -#endif
>>>                 break;
>>>         default:
>>>                 break;
>>> @@ -1289,10 +1285,8 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
>>>         case CHIP_RENOIR:
>>>                 dmub_asic = DMUB_ASIC_DCN21;
>>>                 fw_name_dmub = FIRMWARE_RENOIR_DMUB;
>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>                 if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
>>>                         fw_name_dmub = FIRMWARE_GREEN_SARDINE_DMUB;
>>> -#endif
>>>                 break;
>>>  #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
>>>         case CHIP_SIENNA_CICHLID:
>>> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
>>> index b361dc6c3489..19d97ed6beb8 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
>>> @@ -170,12 +170,10 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
>>>                         break;
>>>                 }
>>>
>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>                 if (ASICREV_IS_GREEN_SARDINE(asic_id.hw_internal_rev)) {
>>>                         rn_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
>>>                         break;
>>>                 }
>>> -#endif
>>>                 if (ASICREV_IS_RAVEN2(asic_id.hw_internal_rev)) {
>>>                         rv2_clk_mgr_construct(ctx, clk_mgr, pp_smu);
>>>                         break;
>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>> index ab105f26b511..419c0df08602 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>>> @@ -126,10 +126,8 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
>>>                         dc_version = DCN_VERSION_1_01;
>>>                 if (ASICREV_IS_RENOIR(asic_id.hw_internal_rev))
>>>                         dc_version = DCN_VERSION_2_1;
>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>                 if (ASICREV_IS_GREEN_SARDINE(asic_id.hw_internal_rev))
>>>                         dc_version = DCN_VERSION_2_1;
>>> -#endif
>>>                 break;
>>>  #endif
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
>>> index b4c3838322af..2bf60ac2974f 100644
>>> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
>>> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
>>> @@ -209,12 +209,10 @@ enum {
>>>  #if defined(CONFIG_DRM_AMD_DC_DCN3_02)
>>>  #define ASICREV_IS_DIMGREY_CAVEFISH_P(eChipRev)        ((eChipRev >= NV_DIMGREY_CAVEFISH_P_A0) && (eChipRev < NV_UNKNOWN))
>>>  #endif
>>> -#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
>>>  #define GREEN_SARDINE_A0 0xA1
>>>  #ifndef ASICREV_IS_GREEN_SARDINE
>>>  #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
>>>  #endif
>>> -#endif
>>>  #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
>>>  #define FAMILY_VGH 144
>>>  #define DEVICE_ID_VGH_163F 0x163F
>>> --
>>> 2.25.4
>>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cluben.tuikov%40amd.com%7Ce6faf7405e70424a369708d879cd2eb4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637393269481241813%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=qMugHyx6d2fLC3oZxvDpoCDt7rN%2BvHTJj9dU81QAYpQ%3D&amp;reserved=0
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
