Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E35C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 04:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94AC02053B
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 04:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U1RBzxYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AC02053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 478056E2D3;
	Fri, 14 Aug 2020 04:11:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739456E2D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 04:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLUlEqEnr78UgV0KvrRLT13yYf9IXkldNGcB6xCJHDYDr01+idQ00pftRubCrKVeFgOv6IpfbDLhk+GdECM1lR7vi1BS+FQJLxTn7dMyr8gucpKDpacMKD3a1/Cvx1pPiD1kitCTjk2JVIqA0l076hs6B3URVGncgQ3W/6BxV1tx3WGfXeRwUb4HqpLFkvr9dL6dWaDKg8H2ck8E6nvHSHfS/z+ujSy0NNV/5zYGkkk1kQv2DkgeKQKkJEO/bBcfaqEGsgoLs/H2szOgZ88jAPBus2pSwUd9hs9VbvF26uaYkMu7sBGcW47g5d+XiGyDYJTq3yi2DFdwWiezoU1zuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaC/vbIItt4jOqj5C0CMHGvL/hh5AE2lw4u5lZXDy/Y=;
 b=K+Z0EY5pSY1zXQFYpLYF7K2GoMZkggByVS9YAFoRNjjvQCy7HwA/fqCJ3dbmaQdyTjOMLrnchvGu2Vww2izFoBVDehkhP1scko/4v8NnDSTOjzieot0OeZsQ/1GXzPWmHpnbe25+cS9+r9nZEQEzTim2T12Qn/V+EzWXJrcyW4Z9egB7GPc3o8bVCyU0cRqYGVTGh/Wsh5Ww0ihS5Mj31opguPwJi7t1zrJmC7Tpwf+xHCsxyOpg0FK+T+hwOEyQSuNPeAZWxiz5v3WE74oyDZPxPN27B486v3d7/UEJJNMGRXqrblYq29BDBbpr0Tpeb/oC+Nh5EsKKWm3L4pB6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaC/vbIItt4jOqj5C0CMHGvL/hh5AE2lw4u5lZXDy/Y=;
 b=U1RBzxYqX3LOYpIOaCuw5tr2osaKzTV3e7H6JbEyN85fHp0tYr8C587VIPnh11xufKZFhK+e+DaxPxOanIlj4jWtZk+NWYPRp+leV9Uby82kFWGwquNSfliyIB8HC44Zz6MSzHsz3mWOn0lLSojxua/M7ri3Djhn8pzuBfIJWIM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2825.namprd12.prod.outlook.com (2603:10b6:5:75::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15; Fri, 14 Aug 2020 04:11:06 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 04:11:06 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/pm: optimize the power related source code layout
Thread-Topic: [PATCH] drm/amd/pm: optimize the power related source code layout
Thread-Index: AQHWcVVqnQWOQXCAxk6SK1whcKW0E6k2EP0AgADs9uA=
Date: Fri, 14 Aug 2020 04:11:05 +0000
Message-ID: <DM6PR12MB2619AE6A86EC55D2F5DA5D06E4400@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200813093732.32407-1-evan.quan@amd.com>
 <CADnq5_NcWPUs6jRgZnKQ_1pczJiqW5U4Gj32JPkM2gqZZqMDVQ@mail.gmail.com>
In-Reply-To: <CADnq5_NcWPUs6jRgZnKQ_1pczJiqW5U4Gj32JPkM2gqZZqMDVQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c400cf95-47c0-4002-80ca-31bacd1c00e3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-14T04:06:39Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 11e9829e-ce0d-4c23-7fdf-08d840081100
x-ms-traffictypediagnostic: DM6PR12MB2825:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28255EC49A1E170E975FF401E4400@DM6PR12MB2825.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s6O8tdFJ3aNDXvoK+3+Ea5+sVltKEB+Xnbo2Nm6E44aW4N/78YM4hn+imBx4WkUSSNS+OeIBXZg/OJg4mwtgV2juVBH1742gAk63WQ9h+s4oy+4rOcvzexbO+xDHdgDj8/8EydNYjiJNVDDPnKmupAsF6Lj6ORUVs5Srf+dUZfYVBU7YOGVknLcXbbRBoWgJoyCYpIgOwpY/jicR9SOPZp7FAGJPLl2a9e3mScpIY6fluIT38JCHByVMXPfaMldAWtf3soSZ3k8kgiAOF2yg+keY3TwBstuLCSQNdetl5mCiH8/ExKLiyerXyprrdb0yQ8CxNm+w5oEagPAFmM9l6QVjguCRF0NAhZDAaG2HzpY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(7696005)(6506007)(186003)(4326008)(30864003)(45080400002)(71200400001)(86362001)(53546011)(5660300002)(966005)(26005)(9686003)(8936002)(8676002)(316002)(83380400001)(66946007)(478600001)(55016002)(66476007)(6916009)(33656002)(2906002)(76116006)(52536014)(66556008)(54906003)(66446008)(64756008)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: W8TWO7mVpfJuT07gnkaGcCkxgP4PqnQoqqxGsV1Lcv4Te2lZX7oo1zBPk3Ppplm/OFiSbX8rmRnj1Yn9DeRjfSho2UVr4/f4FHjn7KQFdic00Pj5Dk0ZdW/6bgxVEwUnZkoam1X/2WVl01fcW2ZY93LsFm0KjVPxjH6tfy42qdgkPspzjm4RLAGrYmJp6N70f3fuea6ym+wXHYetmSARdKnNFIWYvRbFdp87EJp2ddalmE+0b2HGGiAlJpkzw/Yby8e+oHlSIzvsEqK45ZGFTr4M7RwGWCjyrvvNmwxn64Nma6avMXf3v0rrQ/hEmgUeDKS4nA/4QEbS9iPpODGCLT1IOnQ6y08OFpy5a591y/OSjrP7SXlqApbUOQAO0d3fzm1deHXlYpwcNdYq2EUnNV8s5k5orUvq3lg5nJ5aw4K7jGDOkHRUYZFR9EjYzxo8lRnVAMXGphOzw2Cc0mG8zbxhif991Zp8HWUexiDS5JKeRzUTRRFSvbumtxJo7ZU5jZvdlTM09coRR1K49QRLgmLkokGxlMvUGt5FGwzsp5AoZ5hqwMtqhHGU7aQhmr71rO7p9RUgsQ7jmdn3qxFcM6LCPQeClph+WXSkY4O9p+FHxjiegrv6CLoW2b6/cCSC5CApjjvywh6vHDF7o/6TkQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e9829e-ce0d-4c23-7fdf-08d840081100
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 04:11:05.8038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 69lGs/rCxLr09gM3e7GY0f4cltZIgn3vTQ+qYykbN8V7CSE4kVe93SvdRG4fy4i1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2825
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Yes, that's guarded in the new powerplay/Makefile and confirmed by my local compiling(with/without the configs).
POWER_MGR-y = amd_powerplay.o

POWER_MGR-$(CONFIG_DRM_AMDGPU_CIK)+= kv_dpm.o kv_smc.o

POWER_MGR-$(CONFIG_DRM_AMDGPU_SI)+= si_dpm.o si_smc.o

AMD_PP_POWER = $(addprefix $(AMD_PP_PATH)/,$(POWER_MGR-y))

BR
Evan
-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Thursday, August 13, 2020 9:59 PM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amd/pm: optimize the power related source code layout

On Thu, Aug 13, 2020 at 5:38 AM Evan Quan <evan.quan@amd.com> wrote:
>
> The target is to provide a clear entry point(for power routines).
> Also this can help to maintain a clear view about the frameworks
> used on different ASICs. Hopefully all these can make power part
> more friendly to play with.
>
> Change-Id: I2baaa98f3c1078816bd44e14153d8bfbbddd141b
> Signed-off-by: Evan Quan <evan.quan@amd.com>

This looks pretty good to me.  We need to retain the build
conditionals for the CONFIG_DRM_AMDGPU_CIK and CONFIG_DRM_AMDGPU_SI
dpm code after the restructuring.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           | 14 ++----
>  drivers/gpu/drm/amd/pm/Makefile               | 46 +++++++++++++++++++
>  .../gpu/drm/amd/{amdgpu => pm}/amdgpu_dpm.c   |  0
>  .../gpu/drm/amd/{amdgpu => pm}/amdgpu_pm.c    |  0
>  .../amd/{powerplay => pm}/inc/amd_powerplay.h |  0
>  .../drm/amd/{amdgpu => pm/inc}/amdgpu_dpm.h   |  0
>  .../drm/amd/{amdgpu => pm/inc}/amdgpu_pm.h    |  0
>  .../amd/{powerplay => pm}/inc/amdgpu_smu.h    |  0
>  .../{powerplay => pm}/inc/arcturus_ppsmc.h    |  0
>  .../drm/amd/{powerplay => pm}/inc/cz_ppsmc.h  |  0
>  .../amd/{powerplay => pm}/inc/fiji_ppsmc.h    |  0
>  .../{powerplay => pm}/inc/hardwaremanager.h   |  0
>  .../gpu/drm/amd/{powerplay => pm}/inc/hwmgr.h |  0
>  .../inc/polaris10_pwrvirus.h                  |  0
>  .../amd/{powerplay => pm}/inc/power_state.h   |  0
>  .../drm/amd/{powerplay => pm}/inc/pp_debug.h  |  0
>  .../drm/amd/{powerplay => pm}/inc/pp_endian.h |  0
>  .../amd/{powerplay => pm}/inc/pp_thermal.h    |  0
>  .../amd/{powerplay => pm}/inc/ppinterrupt.h   |  0
>  .../drm/amd/{powerplay => pm}/inc/rv_ppsmc.h  |  0
>  .../gpu/drm/amd/{powerplay => pm}/inc/smu10.h |  0
>  .../{powerplay => pm}/inc/smu10_driver_if.h   |  0
>  .../{powerplay => pm}/inc/smu11_driver_if.h   |  0
>  .../inc/smu11_driver_if_arcturus.h            |  0
>  .../inc/smu11_driver_if_navi10.h              |  0
>  .../inc/smu11_driver_if_sienna_cichlid.h      |  0
>  .../{powerplay => pm}/inc/smu12_driver_if.h   |  0
>  .../gpu/drm/amd/{powerplay => pm}/inc/smu7.h  |  0
>  .../gpu/drm/amd/{powerplay => pm}/inc/smu71.h |  0
>  .../{powerplay => pm}/inc/smu71_discrete.h    |  0
>  .../gpu/drm/amd/{powerplay => pm}/inc/smu72.h |  0
>  .../{powerplay => pm}/inc/smu72_discrete.h    |  0
>  .../gpu/drm/amd/{powerplay => pm}/inc/smu73.h |  0
>  .../{powerplay => pm}/inc/smu73_discrete.h    |  0
>  .../gpu/drm/amd/{powerplay => pm}/inc/smu74.h |  0
>  .../{powerplay => pm}/inc/smu74_discrete.h    |  0
>  .../gpu/drm/amd/{powerplay => pm}/inc/smu75.h |  0
>  .../{powerplay => pm}/inc/smu75_discrete.h    |  0
>  .../amd/{powerplay => pm}/inc/smu7_common.h   |  0
>  .../amd/{powerplay => pm}/inc/smu7_discrete.h |  0
>  .../amd/{powerplay => pm}/inc/smu7_fusion.h   |  0
>  .../amd/{powerplay => pm}/inc/smu7_ppsmc.h    |  0
>  .../gpu/drm/amd/{powerplay => pm}/inc/smu8.h  |  0
>  .../amd/{powerplay => pm}/inc/smu8_fusion.h   |  0
>  .../gpu/drm/amd/{powerplay => pm}/inc/smu9.h  |  0
>  .../{powerplay => pm}/inc/smu9_driver_if.h    |  0
>  .../drm/amd/{powerplay => pm}/inc/smu_types.h |  0
>  .../{powerplay => pm}/inc/smu_ucode_xfer_cz.h |  0
>  .../{powerplay => pm}/inc/smu_ucode_xfer_vi.h |  0
>  .../drm/amd/{powerplay => pm}/inc/smu_v11_0.h |  0
>  .../{powerplay => pm}/inc/smu_v11_0_7_ppsmc.h |  0
>  .../inc/smu_v11_0_7_pptable.h                 |  0
>  .../{powerplay => pm}/inc/smu_v11_0_ppsmc.h   |  0
>  .../{powerplay => pm}/inc/smu_v11_0_pptable.h |  0
>  .../drm/amd/{powerplay => pm}/inc/smu_v12_0.h |  0
>  .../{powerplay => pm}/inc/smu_v12_0_ppsmc.h   |  0
>  .../drm/amd/{powerplay => pm}/inc/smumgr.h    |  0
>  .../amd/{powerplay => pm}/inc/tonga_ppsmc.h   |  0
>  .../amd/{powerplay => pm}/inc/vega10_ppsmc.h  |  0
>  .../inc/vega12/smu9_driver_if.h               |  0
>  .../amd/{powerplay => pm}/inc/vega12_ppsmc.h  |  0
>  .../amd/{powerplay => pm}/inc/vega20_ppsmc.h  |  0
>  .../gpu/drm/amd/{ => pm}/powerplay/Makefile   | 23 ++++------
>  .../amd/{ => pm}/powerplay/amd_powerplay.c    |  0
>  .../amd/{amdgpu => pm/powerplay}/cik_dpm.h    |  0
>  .../drm/amd/{ => pm}/powerplay/hwmgr/Makefile |  0
>  .../amd/{ => pm}/powerplay/hwmgr/ci_baco.c    |  0
>  .../amd/{ => pm}/powerplay/hwmgr/ci_baco.h    |  0
>  .../{ => pm}/powerplay/hwmgr/common_baco.c    |  0
>  .../{ => pm}/powerplay/hwmgr/common_baco.h    |  0
>  .../amd/{ => pm}/powerplay/hwmgr/fiji_baco.c  |  0
>  .../amd/{ => pm}/powerplay/hwmgr/fiji_baco.h  |  0
>  .../powerplay/hwmgr/hardwaremanager.c         |  0
>  .../drm/amd/{ => pm}/powerplay/hwmgr/hwmgr.c  |  0
>  .../amd/{ => pm}/powerplay/hwmgr/hwmgr_ppt.h  |  0
>  .../{ => pm}/powerplay/hwmgr/polaris_baco.c   |  0
>  .../{ => pm}/powerplay/hwmgr/polaris_baco.h   |  0
>  .../{ => pm}/powerplay/hwmgr/pp_overdriver.c  |  0
>  .../{ => pm}/powerplay/hwmgr/pp_overdriver.h  |  0
>  .../drm/amd/{ => pm}/powerplay/hwmgr/pp_psm.c |  0
>  .../drm/amd/{ => pm}/powerplay/hwmgr/pp_psm.h |  0
>  .../amd/{ => pm}/powerplay/hwmgr/ppatomctrl.c |  0
>  .../amd/{ => pm}/powerplay/hwmgr/ppatomctrl.h |  0
>  .../{ => pm}/powerplay/hwmgr/ppatomfwctrl.c   |  0
>  .../{ => pm}/powerplay/hwmgr/ppatomfwctrl.h   |  0
>  .../amd/{ => pm}/powerplay/hwmgr/ppevvmath.h  |  0
>  .../{ => pm}/powerplay/hwmgr/pppcielanes.c    |  0
>  .../{ => pm}/powerplay/hwmgr/pppcielanes.h    |  0
>  .../{ => pm}/powerplay/hwmgr/pptable_v1_0.h   |  0
>  .../powerplay/hwmgr/process_pptables_v1_0.c   |  0
>  .../powerplay/hwmgr/process_pptables_v1_0.h   |  0
>  .../powerplay/hwmgr/processpptables.c         |  0
>  .../powerplay/hwmgr/processpptables.h         |  0
>  .../{ => pm}/powerplay/hwmgr/smu10_hwmgr.c    |  0
>  .../{ => pm}/powerplay/hwmgr/smu10_hwmgr.h    |  0
>  .../amd/{ => pm}/powerplay/hwmgr/smu10_inc.h  |  0
>  .../amd/{ => pm}/powerplay/hwmgr/smu7_baco.c  |  0
>  .../amd/{ => pm}/powerplay/hwmgr/smu7_baco.h  |  0
>  .../powerplay/hwmgr/smu7_clockpowergating.c   |  0
>  .../powerplay/hwmgr/smu7_clockpowergating.h   |  0
>  .../powerplay/hwmgr/smu7_dyn_defaults.h       |  0
>  .../amd/{ => pm}/powerplay/hwmgr/smu7_hwmgr.c |  0
>  .../amd/{ => pm}/powerplay/hwmgr/smu7_hwmgr.h |  0
>  .../{ => pm}/powerplay/hwmgr/smu7_powertune.c |  0
>  .../{ => pm}/powerplay/hwmgr/smu7_powertune.h |  0
>  .../{ => pm}/powerplay/hwmgr/smu7_thermal.c   |  0
>  .../{ => pm}/powerplay/hwmgr/smu7_thermal.h   |  0
>  .../amd/{ => pm}/powerplay/hwmgr/smu8_hwmgr.c |  0
>  .../amd/{ => pm}/powerplay/hwmgr/smu8_hwmgr.h |  0
>  .../amd/{ => pm}/powerplay/hwmgr/smu9_baco.c  |  0
>  .../amd/{ => pm}/powerplay/hwmgr/smu9_baco.h  |  0
>  .../amd/{ => pm}/powerplay/hwmgr/smu_helper.c |  0
>  .../amd/{ => pm}/powerplay/hwmgr/smu_helper.h |  0
>  .../amd/{ => pm}/powerplay/hwmgr/tonga_baco.c |  0
>  .../amd/{ => pm}/powerplay/hwmgr/tonga_baco.h |  0
>  .../{ => pm}/powerplay/hwmgr/vega10_baco.c    |  0
>  .../{ => pm}/powerplay/hwmgr/vega10_baco.h    |  0
>  .../{ => pm}/powerplay/hwmgr/vega10_hwmgr.c   |  0
>  .../{ => pm}/powerplay/hwmgr/vega10_hwmgr.h   |  0
>  .../amd/{ => pm}/powerplay/hwmgr/vega10_inc.h |  0
>  .../powerplay/hwmgr/vega10_powertune.c        |  0
>  .../powerplay/hwmgr/vega10_powertune.h        |  0
>  .../{ => pm}/powerplay/hwmgr/vega10_pptable.h |  0
>  .../powerplay/hwmgr/vega10_processpptables.c  |  0
>  .../powerplay/hwmgr/vega10_processpptables.h  |  0
>  .../{ => pm}/powerplay/hwmgr/vega10_thermal.c |  0
>  .../{ => pm}/powerplay/hwmgr/vega10_thermal.h |  0
>  .../{ => pm}/powerplay/hwmgr/vega12_baco.c    |  0
>  .../{ => pm}/powerplay/hwmgr/vega12_baco.h    |  0
>  .../{ => pm}/powerplay/hwmgr/vega12_hwmgr.c   |  0
>  .../{ => pm}/powerplay/hwmgr/vega12_hwmgr.h   |  0
>  .../amd/{ => pm}/powerplay/hwmgr/vega12_inc.h |  0
>  .../{ => pm}/powerplay/hwmgr/vega12_pptable.h |  0
>  .../powerplay/hwmgr/vega12_processpptables.c  |  0
>  .../powerplay/hwmgr/vega12_processpptables.h  |  0
>  .../{ => pm}/powerplay/hwmgr/vega12_thermal.c |  0
>  .../{ => pm}/powerplay/hwmgr/vega12_thermal.h |  0
>  .../{ => pm}/powerplay/hwmgr/vega20_baco.c    |  0
>  .../{ => pm}/powerplay/hwmgr/vega20_baco.h    |  0
>  .../{ => pm}/powerplay/hwmgr/vega20_hwmgr.c   |  0
>  .../{ => pm}/powerplay/hwmgr/vega20_hwmgr.h   |  0
>  .../amd/{ => pm}/powerplay/hwmgr/vega20_inc.h |  0
>  .../powerplay/hwmgr/vega20_powertune.c        |  0
>  .../powerplay/hwmgr/vega20_powertune.h        |  0
>  .../{ => pm}/powerplay/hwmgr/vega20_pptable.h |  0
>  .../powerplay/hwmgr/vega20_processpptables.c  |  0
>  .../powerplay/hwmgr/vega20_processpptables.h  |  0
>  .../{ => pm}/powerplay/hwmgr/vega20_thermal.c |  0
>  .../{ => pm}/powerplay/hwmgr/vega20_thermal.h |  0
>  .../drm/amd/{amdgpu => pm/powerplay}/kv_dpm.c |  0
>  .../drm/amd/{amdgpu => pm/powerplay}/kv_dpm.h |  0
>  .../drm/amd/{amdgpu => pm/powerplay}/kv_smc.c |  0
>  .../drm/amd/{amdgpu => pm/powerplay}/ppsmc.h  |  0
>  .../amd/{amdgpu => pm/powerplay}/r600_dpm.h   |  0
>  .../drm/amd/{amdgpu => pm/powerplay}/si_dpm.c |  0
>  .../drm/amd/{amdgpu => pm/powerplay}/si_dpm.h |  0
>  .../drm/amd/{amdgpu => pm/powerplay}/si_smc.c |  0
>  .../{amdgpu => pm/powerplay}/sislands_smc.h   |  0
>  .../amd/{ => pm}/powerplay/smumgr/Makefile    |  0
>  .../amd/{ => pm}/powerplay/smumgr/ci_smumgr.c |  0
>  .../amd/{ => pm}/powerplay/smumgr/ci_smumgr.h |  0
>  .../{ => pm}/powerplay/smumgr/fiji_smumgr.c   |  0
>  .../{ => pm}/powerplay/smumgr/fiji_smumgr.h   |  0
>  .../powerplay/smumgr/iceland_smumgr.c         |  0
>  .../powerplay/smumgr/iceland_smumgr.h         |  0
>  .../powerplay/smumgr/polaris10_smumgr.c       |  0
>  .../powerplay/smumgr/polaris10_smumgr.h       |  0
>  .../{ => pm}/powerplay/smumgr/smu10_smumgr.c  |  0
>  .../{ => pm}/powerplay/smumgr/smu10_smumgr.h  |  0
>  .../{ => pm}/powerplay/smumgr/smu7_smumgr.c   |  0
>  .../{ => pm}/powerplay/smumgr/smu7_smumgr.h   |  0
>  .../{ => pm}/powerplay/smumgr/smu8_smumgr.c   |  0
>  .../{ => pm}/powerplay/smumgr/smu8_smumgr.h   |  0
>  .../{ => pm}/powerplay/smumgr/smu9_smumgr.c   |  0
>  .../{ => pm}/powerplay/smumgr/smu9_smumgr.h   |  0
>  .../amd/{ => pm}/powerplay/smumgr/smumgr.c    |  0
>  .../{ => pm}/powerplay/smumgr/tonga_smumgr.c  |  0
>  .../{ => pm}/powerplay/smumgr/tonga_smumgr.h  |  0
>  .../{ => pm}/powerplay/smumgr/vega10_smumgr.c |  0
>  .../{ => pm}/powerplay/smumgr/vega10_smumgr.h |  0
>  .../{ => pm}/powerplay/smumgr/vega12_smumgr.c |  0
>  .../{ => pm}/powerplay/smumgr/vega12_smumgr.h |  0
>  .../{ => pm}/powerplay/smumgr/vega20_smumgr.c |  0
>  .../{ => pm}/powerplay/smumgr/vega20_smumgr.h |  0
>  .../{ => pm}/powerplay/smumgr/vegam_smumgr.c  |  0
>  .../{ => pm}/powerplay/smumgr/vegam_smumgr.h  |  0
>  drivers/gpu/drm/amd/pm/swsmu/Makefile         | 36 +++++++++++++++
>  .../amd/{powerplay => pm/swsmu}/amdgpu_smu.c  |  0
>  drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile   | 33 +++++++++++++
>  .../swsmu/smu11}/arcturus_ppt.c               |  0
>  .../swsmu/smu11}/arcturus_ppt.h               |  0
>  .../swsmu/smu11}/navi10_ppt.c                 |  0
>  .../swsmu/smu11}/navi10_ppt.h                 |  0
>  .../swsmu/smu11}/sienna_cichlid_ppt.c         |  0
>  .../swsmu/smu11}/sienna_cichlid_ppt.h         |  0
>  .../{powerplay => pm/swsmu/smu11}/smu_v11_0.c |  0
>  drivers/gpu/drm/amd/pm/swsmu/smu12/Makefile   | 31 +++++++++++++
>  .../swsmu/smu12}/renoir_ppt.c                 |  0
>  .../swsmu/smu12}/renoir_ppt.h                 |  0
>  .../{powerplay => pm/swsmu/smu12}/smu_v12_0.c |  0
>  .../drm/amd/{powerplay => pm/swsmu}/smu_cmn.c |  0
>  .../drm/amd/{powerplay => pm/swsmu}/smu_cmn.h |  0
>  .../{powerplay => pm/swsmu}/smu_internal.h    |  0
>  203 files changed, 160 insertions(+), 23 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/pm/Makefile
>  rename drivers/gpu/drm/amd/{amdgpu => pm}/amdgpu_dpm.c (100%)
>  rename drivers/gpu/drm/amd/{amdgpu => pm}/amdgpu_pm.c (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/amd_powerplay.h (100%)
>  rename drivers/gpu/drm/amd/{amdgpu => pm/inc}/amdgpu_dpm.h (100%)
>  rename drivers/gpu/drm/amd/{amdgpu => pm/inc}/amdgpu_pm.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/amdgpu_smu.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/arcturus_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/cz_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/fiji_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/hardwaremanager.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/hwmgr.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/polaris10_pwrvirus.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/power_state.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/pp_debug.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/pp_endian.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/pp_thermal.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/ppinterrupt.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/rv_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu10.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu10_driver_if.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu11_driver_if.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu11_driver_if_arcturus.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu11_driver_if_navi10.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu11_driver_if_sienna_cichlid.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu12_driver_if.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu7.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu71.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu71_discrete.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu72.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu72_discrete.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu73.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu73_discrete.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu74.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu74_discrete.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu75.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu75_discrete.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu7_common.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu7_discrete.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu7_fusion.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu7_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu8.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu8_fusion.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu9.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu9_driver_if.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu_types.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu_ucode_xfer_cz.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu_ucode_xfer_vi.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu_v11_0.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu_v11_0_7_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu_v11_0_7_pptable.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu_v11_0_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu_v11_0_pptable.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu_v12_0.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smu_v12_0_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/smumgr.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/tonga_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/vega10_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/vega12/smu9_driver_if.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/vega12_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm}/inc/vega20_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/Makefile (70%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/amd_powerplay.c (100%)
>  rename drivers/gpu/drm/amd/{amdgpu => pm/powerplay}/cik_dpm.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/Makefile (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/ci_baco.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/ci_baco.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/common_baco.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/common_baco.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/fiji_baco.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/fiji_baco.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/hardwaremanager.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/hwmgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/hwmgr_ppt.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/polaris_baco.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/polaris_baco.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/pp_overdriver.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/pp_overdriver.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/pp_psm.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/pp_psm.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/ppatomctrl.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/ppatomctrl.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/ppatomfwctrl.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/ppatomfwctrl.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/ppevvmath.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/pppcielanes.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/pppcielanes.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/pptable_v1_0.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/process_pptables_v1_0.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/process_pptables_v1_0.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/processpptables.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/processpptables.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu10_hwmgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu10_hwmgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu10_inc.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu7_baco.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu7_baco.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu7_clockpowergating.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu7_clockpowergating.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu7_dyn_defaults.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu7_hwmgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu7_hwmgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu7_powertune.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu7_powertune.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu7_thermal.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu7_thermal.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu8_hwmgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu8_hwmgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu9_baco.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu9_baco.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu_helper.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/smu_helper.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/tonga_baco.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/tonga_baco.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega10_baco.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega10_baco.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega10_hwmgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega10_hwmgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega10_inc.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega10_powertune.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega10_powertune.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega10_pptable.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega10_processpptables.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega10_processpptables.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega10_thermal.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega10_thermal.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega12_baco.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega12_baco.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega12_hwmgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega12_hwmgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega12_inc.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega12_pptable.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega12_processpptables.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega12_processpptables.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega12_thermal.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega12_thermal.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega20_baco.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega20_baco.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega20_hwmgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega20_hwmgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega20_inc.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega20_powertune.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega20_powertune.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega20_pptable.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega20_processpptables.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega20_processpptables.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega20_thermal.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/hwmgr/vega20_thermal.h (100%)
>  rename drivers/gpu/drm/amd/{amdgpu => pm/powerplay}/kv_dpm.c (100%)
>  rename drivers/gpu/drm/amd/{amdgpu => pm/powerplay}/kv_dpm.h (100%)
>  rename drivers/gpu/drm/amd/{amdgpu => pm/powerplay}/kv_smc.c (100%)
>  rename drivers/gpu/drm/amd/{amdgpu => pm/powerplay}/ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/{amdgpu => pm/powerplay}/r600_dpm.h (100%)
>  rename drivers/gpu/drm/amd/{amdgpu => pm/powerplay}/si_dpm.c (100%)
>  rename drivers/gpu/drm/amd/{amdgpu => pm/powerplay}/si_dpm.h (100%)
>  rename drivers/gpu/drm/amd/{amdgpu => pm/powerplay}/si_smc.c (100%)
>  rename drivers/gpu/drm/amd/{amdgpu => pm/powerplay}/sislands_smc.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/Makefile (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/ci_smumgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/ci_smumgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/fiji_smumgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/fiji_smumgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/iceland_smumgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/iceland_smumgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/polaris10_smumgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/polaris10_smumgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/smu10_smumgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/smu10_smumgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/smu7_smumgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/smu7_smumgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/smu8_smumgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/smu8_smumgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/smu9_smumgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/smu9_smumgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/smumgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/tonga_smumgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/tonga_smumgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/vega10_smumgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/vega10_smumgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/vega12_smumgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/vega12_smumgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/vega20_smumgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/vega20_smumgr.h (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/vegam_smumgr.c (100%)
>  rename drivers/gpu/drm/amd/{ => pm}/powerplay/smumgr/vegam_smumgr.h (100%)
>  create mode 100644 drivers/gpu/drm/amd/pm/swsmu/Makefile
>  rename drivers/gpu/drm/amd/{powerplay => pm/swsmu}/amdgpu_smu.c (100%)
>  create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile
>  rename drivers/gpu/drm/amd/{powerplay => pm/swsmu/smu11}/arcturus_ppt.c (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm/swsmu/smu11}/arcturus_ppt.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm/swsmu/smu11}/navi10_ppt.c (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm/swsmu/smu11}/navi10_ppt.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm/swsmu/smu11}/sienna_cichlid_ppt.c (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm/swsmu/smu11}/sienna_cichlid_ppt.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm/swsmu/smu11}/smu_v11_0.c (100%)
>  create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu12/Makefile
>  rename drivers/gpu/drm/amd/{powerplay => pm/swsmu/smu12}/renoir_ppt.c (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm/swsmu/smu12}/renoir_ppt.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm/swsmu/smu12}/smu_v12_0.c (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm/swsmu}/smu_cmn.c (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm/swsmu}/smu_cmn.h (100%)
>  rename drivers/gpu/drm/amd/{powerplay => pm/swsmu}/smu_internal.h (100%)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index dec1927ca75d..39976c7b100c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -30,7 +30,7 @@ FULL_AMD_DISPLAY_PATH = $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
>  ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
>         -I$(FULL_AMD_PATH)/include \
>         -I$(FULL_AMD_PATH)/amdgpu \
> -       -I$(FULL_AMD_PATH)/powerplay/inc \
> +       -I$(FULL_AMD_PATH)/pm/inc \
>         -I$(FULL_AMD_PATH)/acp/include \
>         -I$(FULL_AMD_DISPLAY_PATH) \
>         -I$(FULL_AMD_DISPLAY_PATH)/include \
> @@ -47,7 +47,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>         amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
>         amdgpu_fb.o amdgpu_gem.o amdgpu_ring.o \
>         amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o amdgpu_test.o \
> -       amdgpu_pm.o atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
> +       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>         atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>         amdgpu_dma_buf.o amdgpu_vm.o amdgpu_ib.o amdgpu_pll.o \
>         amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
> @@ -60,10 +60,10 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>  amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
>
>  # add asic specific block
> -amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+= cik.o cik_ih.o kv_smc.o kv_dpm.o \
> +amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+= cik.o cik_ih.o \
>         dce_v8_0.o gfx_v7_0.o cik_sdma.o uvd_v4_2.o vce_v2_0.o
>
> -amdgpu-$(CONFIG_DRM_AMDGPU_SI)+= si.o gmc_v6_0.o gfx_v6_0.o si_ih.o si_dma.o dce_v6_0.o si_dpm.o si_smc.o \
> +amdgpu-$(CONFIG_DRM_AMDGPU_SI)+= si.o gmc_v6_0.o gfx_v6_0.o si_ih.o si_dma.o dce_v6_0.o \
>         uvd_v3_1.o
>
>  amdgpu-y += \
> @@ -105,10 +105,6 @@ amdgpu-y += \
>         psp_v11_0.o \
>         psp_v12_0.o
>
> -# add SMC block
> -amdgpu-y += \
> -       amdgpu_dpm.o
> -
>  # add DCE block
>  amdgpu-y += \
>         dce_v10_0.o \
> @@ -212,7 +208,7 @@ amdgpu-$(CONFIG_VGA_SWITCHEROO) += amdgpu_atpx_handler.o
>  amdgpu-$(CONFIG_ACPI) += amdgpu_acpi.o
>  amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_mn.o
>
> -include $(FULL_AMD_PATH)/powerplay/Makefile
> +include $(FULL_AMD_PATH)/pm/Makefile
>
>  amdgpu-y += $(AMD_POWERPLAY_FILES)
>
> diff --git a/drivers/gpu/drm/amd/pm/Makefile b/drivers/gpu/drm/amd/pm/Makefile
> new file mode 100644
> index 000000000000..f01e86030cd1
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/pm/Makefile
> @@ -0,0 +1,46 @@
> +#
> +# Copyright 2017 Advanced Micro Devices, Inc.
> +#
> +# Permission is hereby granted, free of charge, to any person obtaining a
> +# copy of this software and associated documentation files (the "Software"),
> +# to deal in the Software without restriction, including without limitation
> +# the rights to use, copy, modify, merge, publish, distribute, sublicense,
> +# and/or sell copies of the Software, and to permit persons to whom the
> +# Software is furnished to do so, subject to the following conditions:
> +#
> +# The above copyright notice and this permission notice shall be included in
> +# all copies or substantial portions of the Software.
> +#
> +# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> +# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> +# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> +# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> +# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> +# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> +# OTHER DEALINGS IN THE SOFTWARE.
> +#
> +
> +subdir-ccflags-y += \
> +               -I$(FULL_AMD_PATH)/pm/inc/  \
> +               -I$(FULL_AMD_PATH)/include/asic_reg  \
> +               -I$(FULL_AMD_PATH)/include  \
> +               -I$(FULL_AMD_PATH)/pm/swsmu \
> +               -I$(FULL_AMD_PATH)/pm/swsmu/smu11 \
> +               -I$(FULL_AMD_PATH)/pm/swsmu/smu12 \
> +               -I$(FULL_AMD_PATH)/pm/powerplay \
> +               -I$(FULL_AMD_PATH)/pm/powerplay/smumgr\
> +               -I$(FULL_AMD_PATH)/pm/powerplay/hwmgr
> +
> +AMD_PM_PATH = ../pm
> +
> +PM_LIBS = swsmu powerplay
> +
> +AMD_PM = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/,$(PM_LIBS)))
> +
> +include $(AMD_PM)
> +
> +PM_MGR = amdgpu_dpm.o amdgpu_pm.o
> +
> +AMD_PM_POWER = $(addprefix $(AMD_PM_PATH)/,$(PM_MGR))
> +
> +AMD_POWERPLAY_FILES += $(AMD_PM_POWER)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> rename to drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> rename to drivers/gpu/drm/amd/pm/amdgpu_pm.c
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h b/drivers/gpu/drm/amd/pm/inc/amd_powerplay.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h
> rename to drivers/gpu/drm/amd/pm/inc/amd_powerplay.h
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> rename to drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
> rename to drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> rename to drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/cz_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/cz_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/cz_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/inc/cz_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/fiji_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/fiji_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/fiji_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/inc/fiji_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h b/drivers/gpu/drm/amd/pm/inc/hardwaremanager.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h
> rename to drivers/gpu/drm/amd/pm/inc/hardwaremanager.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> rename to drivers/gpu/drm/amd/pm/inc/hwmgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/polaris10_pwrvirus.h b/drivers/gpu/drm/amd/pm/inc/polaris10_pwrvirus.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/polaris10_pwrvirus.h
> rename to drivers/gpu/drm/amd/pm/inc/polaris10_pwrvirus.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/power_state.h b/drivers/gpu/drm/amd/pm/inc/power_state.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/power_state.h
> rename to drivers/gpu/drm/amd/pm/inc/power_state.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h b/drivers/gpu/drm/amd/pm/inc/pp_debug.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
> rename to drivers/gpu/drm/amd/pm/inc/pp_debug.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/pp_endian.h b/drivers/gpu/drm/amd/pm/inc/pp_endian.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/pp_endian.h
> rename to drivers/gpu/drm/amd/pm/inc/pp_endian.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/pp_thermal.h b/drivers/gpu/drm/amd/pm/inc/pp_thermal.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/pp_thermal.h
> rename to drivers/gpu/drm/amd/pm/inc/pp_thermal.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/ppinterrupt.h b/drivers/gpu/drm/amd/pm/inc/ppinterrupt.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/ppinterrupt.h
> rename to drivers/gpu/drm/amd/pm/inc/ppinterrupt.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu10.h b/drivers/gpu/drm/amd/pm/inc/smu10.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu10.h
> rename to drivers/gpu/drm/amd/pm/inc/smu10.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu10_driver_if.h b/drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu10_driver_if.h
> rename to drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h
> rename to drivers/gpu/drm/amd/pm/inc/smu11_driver_if.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
> rename to drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h
> rename to drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_sienna_cichlid.h
> rename to drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu12_driver_if.h b/drivers/gpu/drm/amd/pm/inc/smu12_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu12_driver_if.h
> rename to drivers/gpu/drm/amd/pm/inc/smu12_driver_if.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu7.h b/drivers/gpu/drm/amd/pm/inc/smu7.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu7.h
> rename to drivers/gpu/drm/amd/pm/inc/smu7.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu71.h b/drivers/gpu/drm/amd/pm/inc/smu71.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu71.h
> rename to drivers/gpu/drm/amd/pm/inc/smu71.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu71_discrete.h b/drivers/gpu/drm/amd/pm/inc/smu71_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu71_discrete.h
> rename to drivers/gpu/drm/amd/pm/inc/smu71_discrete.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu72.h b/drivers/gpu/drm/amd/pm/inc/smu72.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu72.h
> rename to drivers/gpu/drm/amd/pm/inc/smu72.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu72_discrete.h b/drivers/gpu/drm/amd/pm/inc/smu72_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu72_discrete.h
> rename to drivers/gpu/drm/amd/pm/inc/smu72_discrete.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu73.h b/drivers/gpu/drm/amd/pm/inc/smu73.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu73.h
> rename to drivers/gpu/drm/amd/pm/inc/smu73.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu73_discrete.h b/drivers/gpu/drm/amd/pm/inc/smu73_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu73_discrete.h
> rename to drivers/gpu/drm/amd/pm/inc/smu73_discrete.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu74.h b/drivers/gpu/drm/amd/pm/inc/smu74.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu74.h
> rename to drivers/gpu/drm/amd/pm/inc/smu74.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu74_discrete.h b/drivers/gpu/drm/amd/pm/inc/smu74_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu74_discrete.h
> rename to drivers/gpu/drm/amd/pm/inc/smu74_discrete.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu75.h b/drivers/gpu/drm/amd/pm/inc/smu75.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu75.h
> rename to drivers/gpu/drm/amd/pm/inc/smu75.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu75_discrete.h b/drivers/gpu/drm/amd/pm/inc/smu75_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu75_discrete.h
> rename to drivers/gpu/drm/amd/pm/inc/smu75_discrete.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu7_common.h b/drivers/gpu/drm/amd/pm/inc/smu7_common.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu7_common.h
> rename to drivers/gpu/drm/amd/pm/inc/smu7_common.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu7_discrete.h b/drivers/gpu/drm/amd/pm/inc/smu7_discrete.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu7_discrete.h
> rename to drivers/gpu/drm/amd/pm/inc/smu7_discrete.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu7_fusion.h b/drivers/gpu/drm/amd/pm/inc/smu7_fusion.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu7_fusion.h
> rename to drivers/gpu/drm/amd/pm/inc/smu7_fusion.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu7_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu7_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu8.h b/drivers/gpu/drm/amd/pm/inc/smu8.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu8.h
> rename to drivers/gpu/drm/amd/pm/inc/smu8.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu8_fusion.h b/drivers/gpu/drm/amd/pm/inc/smu8_fusion.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu8_fusion.h
> rename to drivers/gpu/drm/amd/pm/inc/smu8_fusion.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu9.h b/drivers/gpu/drm/amd/pm/inc/smu9.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu9.h
> rename to drivers/gpu/drm/amd/pm/inc/smu9.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu9_driver_if.h b/drivers/gpu/drm/amd/pm/inc/smu9_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu9_driver_if.h
> rename to drivers/gpu/drm/amd/pm/inc/smu9_driver_if.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu_types.h
> rename to drivers/gpu/drm/amd/pm/inc/smu_types.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_ucode_xfer_cz.h b/drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_cz.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu_ucode_xfer_cz.h
> rename to drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_cz.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_ucode_xfer_vi.h b/drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_vi.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu_ucode_xfer_vi.h
> rename to drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_vi.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> rename to drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_7_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_7_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_7_pptable.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_pptable.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_7_pptable.h
> rename to drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_pptable.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0_pptable.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h
> rename to drivers/gpu/drm/amd/pm/inc/smu_v11_0_pptable.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v12_0.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
> rename to drivers/gpu/drm/amd/pm/inc/smu_v12_0.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v12_0_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smu_v12_0_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/inc/smu_v12_0_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h b/drivers/gpu/drm/amd/pm/inc/smumgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/smumgr.h
> rename to drivers/gpu/drm/amd/pm/inc/smumgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/tonga_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/tonga_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/tonga_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/inc/tonga_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/vega10_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/vega10_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/vega10_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/inc/vega10_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/vega12/smu9_driver_if.h b/drivers/gpu/drm/amd/pm/inc/vega12/smu9_driver_if.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/vega12/smu9_driver_if.h
> rename to drivers/gpu/drm/amd/pm/inc/vega12/smu9_driver_if.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/vega12_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/vega12_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/vega12_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/inc/vega12_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/vega20_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/vega20_ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/inc/vega20_ppsmc.h
> rename to drivers/gpu/drm/amd/pm/inc/vega20_ppsmc.h
> diff --git a/drivers/gpu/drm/amd/powerplay/Makefile b/drivers/gpu/drm/amd/pm/powerplay/Makefile
> similarity index 70%
> rename from drivers/gpu/drm/amd/powerplay/Makefile
> rename to drivers/gpu/drm/amd/pm/powerplay/Makefile
> index e9c48f99f71b..0fb114adc79f 100644
> --- a/drivers/gpu/drm/amd/powerplay/Makefile
> +++ b/drivers/gpu/drm/amd/pm/powerplay/Makefile
> @@ -1,5 +1,5 @@
>  #
> -# Copyright 2017 Advanced Micro Devices, Inc.
> +# Copyright 2020 Advanced Micro Devices, Inc.
>  #
>  # Permission is hereby granted, free of charge, to any person obtaining a
>  # copy of this software and associated documentation files (the "Software"),
> @@ -20,25 +20,20 @@
>  # OTHER DEALINGS IN THE SOFTWARE.
>  #
>
> -subdir-ccflags-y += \
> -               -I$(FULL_AMD_PATH)/powerplay/inc/  \
> -               -I$(FULL_AMD_PATH)/include/asic_reg  \
> -               -I$(FULL_AMD_PATH)/include  \
> -               -I$(FULL_AMD_PATH)/powerplay/smumgr\
> -               -I$(FULL_AMD_PATH)/powerplay/hwmgr
> -
> -AMD_PP_PATH = ../powerplay
> +AMD_PP_PATH = ../pm/powerplay
>
>  PP_LIBS = smumgr hwmgr
>
> -AMD_POWERPLAY = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/powerplay/,$(PP_LIBS)))
> +AMD_POWERPLAY = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/powerplay/,$(PP_LIBS)))
>
>  include $(AMD_POWERPLAY)
>
> -POWER_MGR = amd_powerplay.o amdgpu_smu.o smu_v11_0.o \
> -           smu_v12_0.o arcturus_ppt.o navi10_ppt.o \
> -           renoir_ppt.o sienna_cichlid_ppt.o smu_cmn.o
> +POWER_MGR-y = amd_powerplay.o
> +
> +POWER_MGR-$(CONFIG_DRM_AMDGPU_CIK)+= kv_dpm.o kv_smc.o
> +
> +POWER_MGR-$(CONFIG_DRM_AMDGPU_SI)+= si_dpm.o si_smc.o
>
> -AMD_PP_POWER = $(addprefix $(AMD_PP_PATH)/,$(POWER_MGR))
> +AMD_PP_POWER = $(addprefix $(AMD_PP_PATH)/,$(POWER_MGR-y))
>
>  AMD_POWERPLAY_FILES += $(AMD_PP_POWER)
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> rename to drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_dpm.h b/drivers/gpu/drm/amd/pm/powerplay/cik_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/amdgpu/cik_dpm.h
> rename to drivers/gpu/drm/amd/pm/powerplay/cik_dpm.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/Makefile b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/Makefile
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/Makefile
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/Makefile
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ci_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/ci_baco.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ci_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/ci_baco.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/common_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/common_baco.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/common_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/common_baco.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/fiji_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/fiji_baco.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/fiji_baco.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/fiji_baco.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/fiji_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/fiji_baco.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/fiji_baco.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/fiji_baco.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr_ppt.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr_ppt.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr_ppt.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/polaris_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/polaris_baco.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/polaris_baco.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/polaris_baco.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/polaris_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/polaris_baco.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/polaris_baco.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/polaris_baco.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_overdriver.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_overdriver.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/pp_overdriver.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_overdriver.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_overdriver.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_overdriver.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/pp_overdriver.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_overdriver.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppevvmath.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/ppevvmath.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pppcielanes.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pppcielanes.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/pppcielanes.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/pppcielanes.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pppcielanes.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pppcielanes.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/pppcielanes.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/pppcielanes.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_inc.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_inc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu10_inc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_inc.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu7_baco.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu7_baco.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_baco.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_dyn_defaults.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_dyn_defaults.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu7_dyn_defaults.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_dyn_defaults.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu9_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu9_baco.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu9_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu9_baco.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu9_baco.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/tonga_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/tonga_baco.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/tonga_baco.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/tonga_baco.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/tonga_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/tonga_baco.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/tonga_baco.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/tonga_baco.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_baco.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega10_baco.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_baco.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_baco.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega10_baco.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_baco.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_inc.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_inc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega10_inc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_inc.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_pptable.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega10_pptable.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_pptable.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_baco.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega12_baco.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_baco.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_baco.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega12_baco.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_baco.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_inc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_inc.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_pptable.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_pptable.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega12_pptable.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_pptable.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega12_processpptables.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_processpptables.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega12_processpptables.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega20_baco.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_baco.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega20_baco.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_baco.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_inc.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_inc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega20_inc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_inc.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_powertune.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_powertune.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega20_powertune.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_powertune.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_powertune.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_powertune.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega20_powertune.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_powertune.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_pptable.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_pptable.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega20_pptable.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_pptable.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega20_processpptables.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.h
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h
> rename to drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.h
> diff --git a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/amdgpu/kv_dpm.c
> rename to drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> diff --git a/drivers/gpu/drm/amd/amdgpu/kv_dpm.h b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/amdgpu/kv_dpm.h
> rename to drivers/gpu/drm/amd/pm/powerplay/kv_dpm.h
> diff --git a/drivers/gpu/drm/amd/amdgpu/kv_smc.c b/drivers/gpu/drm/amd/pm/powerplay/kv_smc.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/amdgpu/kv_smc.c
> rename to drivers/gpu/drm/amd/pm/powerplay/kv_smc.c
> diff --git a/drivers/gpu/drm/amd/amdgpu/ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/ppsmc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/amdgpu/ppsmc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/ppsmc.h
> diff --git a/drivers/gpu/drm/amd/amdgpu/r600_dpm.h b/drivers/gpu/drm/amd/pm/powerplay/r600_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/amdgpu/r600_dpm.h
> rename to drivers/gpu/drm/amd/pm/powerplay/r600_dpm.h
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/amdgpu/si_dpm.c
> rename to drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.h b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/amdgpu/si_dpm.h
> rename to drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_smc.c b/drivers/gpu/drm/amd/pm/powerplay/si_smc.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/amdgpu/si_smc.c
> rename to drivers/gpu/drm/amd/pm/powerplay/si_smc.c
> diff --git a/drivers/gpu/drm/amd/amdgpu/sislands_smc.h b/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/amdgpu/sislands_smc.h
> rename to drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/Makefile b/drivers/gpu/drm/amd/pm/powerplay/smumgr/Makefile
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/Makefile
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/Makefile
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smumgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/smumgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.h
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.h
> rename to drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.h
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/Makefile b/drivers/gpu/drm/amd/pm/swsmu/Makefile
> new file mode 100644
> index 000000000000..6f281990b7b4
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/pm/swsmu/Makefile
> @@ -0,0 +1,36 @@
> +#
> +# Copyright 2020 Advanced Micro Devices, Inc.
> +#
> +# Permission is hereby granted, free of charge, to any person obtaining a
> +# copy of this software and associated documentation files (the "Software"),
> +# to deal in the Software without restriction, including without limitation
> +# the rights to use, copy, modify, merge, publish, distribute, sublicense,
> +# and/or sell copies of the Software, and to permit persons to whom the
> +# Software is furnished to do so, subject to the following conditions:
> +#
> +# The above copyright notice and this permission notice shall be included in
> +# all copies or substantial portions of the Software.
> +#
> +# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> +# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> +# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> +# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> +# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> +# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> +# OTHER DEALINGS IN THE SOFTWARE.
> +#
> +
> +AMD_SWSMU_PATH = ../pm/swsmu
> +
> +SWSMU_LIBS = smu11 smu12
> +
> +AMD_SWSMU = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/swsmu/,$(SWSMU_LIBS)))
> +
> +include $(AMD_SWSMU)
> +
> +SWSMU_MGR = amdgpu_smu.o \
> +           smu_cmn.o \
> +
> +AMD_SWSMU_POWER = $(addprefix $(AMD_SWSMU_PATH)/,$(SWSMU_MGR))
> +
> +AMD_POWERPLAY_FILES += $(AMD_SWSMU_POWER)
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> rename to drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile b/drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile
> new file mode 100644
> index 000000000000..f98d97192635
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile
> @@ -0,0 +1,33 @@
> +#
> +# Copyright 2020 Advanced Micro Devices, Inc.
> +#
> +# Permission is hereby granted, free of charge, to any person obtaining a
> +# copy of this software and associated documentation files (the "Software"),
> +# to deal in the Software without restriction, including without limitation
> +# the rights to use, copy, modify, merge, publish, distribute, sublicense,
> +# and/or sell copies of the Software, and to permit persons to whom the
> +# Software is furnished to do so, subject to the following conditions:
> +#
> +# The above copyright notice and this permission notice shall be included in
> +# all copies or substantial portions of the Software.
> +#
> +# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> +# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> +# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> +# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> +# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> +# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> +# OTHER DEALINGS IN THE SOFTWARE.
> +#
> +#
> +# Makefile for the 'smu manager' sub-component of powerplay.
> +# It provides the smu management services for the driver.
> +
> +SMU11_MGR = arcturus_ppt.o \
> +           navi10_ppt.o \
> +           sienna_cichlid_ppt.o \
> +           smu_v11_0.o
> +
> +AMD_SWSMU_SMU11MGR = $(addprefix $(AMD_SWSMU_PATH)/smu11/,$(SMU11_MGR))
> +
> +AMD_POWERPLAY_FILES += $(AMD_SWSMU_SMU11MGR)
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> rename to drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/arcturus_ppt.h
> rename to drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.h
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> rename to drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/navi10_ppt.h
> rename to drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.h
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> rename to drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.h
> rename to drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.h
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> rename to drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/Makefile b/drivers/gpu/drm/amd/pm/swsmu/smu12/Makefile
> new file mode 100644
> index 000000000000..67e53f7da3ce
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/Makefile
> @@ -0,0 +1,31 @@
> +#
> +# Copyright 2020 Advanced Micro Devices, Inc.
> +#
> +# Permission is hereby granted, free of charge, to any person obtaining a
> +# copy of this software and associated documentation files (the "Software"),
> +# to deal in the Software without restriction, including without limitation
> +# the rights to use, copy, modify, merge, publish, distribute, sublicense,
> +# and/or sell copies of the Software, and to permit persons to whom the
> +# Software is furnished to do so, subject to the following conditions:
> +#
> +# The above copyright notice and this permission notice shall be included in
> +# all copies or substantial portions of the Software.
> +#
> +# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> +# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> +# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> +# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> +# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> +# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> +# OTHER DEALINGS IN THE SOFTWARE.
> +#
> +#
> +# Makefile for the 'smu manager' sub-component of powerplay.
> +# It provides the smu management services for the driver.
> +
> +SMU12_MGR = renoir_ppt.o \
> +           smu_v12_0.o
> +
> +AMD_SWSMU_SMU12MGR = $(addprefix $(AMD_SWSMU_PATH)/smu12/,$(SMU12_MGR))
> +
> +AMD_POWERPLAY_FILES += $(AMD_SWSMU_SMU12MGR)
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> rename to drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/renoir_ppt.h
> rename to drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.h
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> rename to drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smu_cmn.c
> rename to drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smu_cmn.h
> rename to drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/powerplay/smu_internal.h
> rename to drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C8c202b843c8244f1f87e08d83f90ff4e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637329239293759020&amp;sdata=IuU68ahl2gI9H2yXZneVbScah8wA0Ym0XPyUbwvWMf8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
