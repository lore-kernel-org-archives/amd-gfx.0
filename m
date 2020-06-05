Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F97CC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 05:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BB8207D5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 05:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MsUwgRwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BB8207D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D22C6E841;
	Fri,  5 Jun 2020 05:53:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C2706E841
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 05:53:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGmoTz0P0tgIdHs6J8CRtVael/cNzfULCyK260xu8x3vbjwYPjeezsD+xSzIWkV+4+YmwLYd1CaY+OuJ9HzmhmFjZ2a2VkNS/62uPxJTKGU6+TkKZmZr68xVgmL8LusYf+sNuIW9J6k7MJg4NtXKybw0J1YF5LMwnK9yBJT+andZulVozFRjcXS07bU2PuevoA1AXgRA1r4srycWRPmhfAwCgtGYoCcTjiKxGObpiSdvQeqWaLg3H+dLDuXzpxwhY123thkknWtgkh1KQyKxzhGuhfmQ+MY+Az8QTpjrV7dRwytFBrAgPB0nMafJmePnni90A/KbnRqGqn9C8BDGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cX0Y2FjI4GkON9bBxn2SYu7MS/6ihOVuEEHRUmZqq0=;
 b=MMWlfJYdkYQK4QX/N31PBO1eZuxVFHpEuQdawdp50B8TI3Ua2Rg+dBefR2Ak/CO+GDlA3s1VbKVR9ndPTy54hV1ktVyGuZu27hHRMPyDPWl0PQSy1iXfWfaCR2f4GvUo/LNP6ETWenBLCQW9fz/wWCNq2wh1FSyftN26qxWqzm+D/18miKoBtNQqMfg20qXH/t1++EUk4JUudpBpH2HERPb+ifWcawjfM5sxMOST/nKTTwa32rlPE6PE6Iwaa34vuzBgKTWyZ/LrzrO+6N3kL1nkr5f2Z51r0YQFgELS4fy3YXY3CtGz9u1FnNfCx+Pmv4/96yvXEpXT3fJ/kyHNJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cX0Y2FjI4GkON9bBxn2SYu7MS/6ihOVuEEHRUmZqq0=;
 b=MsUwgRwXT3lE+146vMU+WVPZKR105UJgES2cooH42rwK0Y5+wVF74R9TVjzVBz+n+3tM6UhLwjJWWkdtoUO2quYy3mjvROpcBysP0sEA/dEo/FzFxmZVLv4LV/9xPQHH5Y6RSecLOQl/hpvHykxYxuMcSRMC0TTm6HdVJtoQTfY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Fri, 5 Jun 2020 05:53:30 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Fri, 5 Jun 2020
 05:53:30 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 12/16] drm/amd/powerplay: better namings
Thread-Topic: [PATCH 12/16] drm/amd/powerplay: better namings
Thread-Index: AQHWOis2batK22VpHESCtB9cl+n656jI89eAgACSttA=
Date: Fri, 5 Jun 2020 05:53:30 +0000
Message-ID: <DM6PR12MB2619DC1674F3B6D9F5CBD9F6E4860@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200604044619.18658-1-evan.quan@amd.com>
 <20200604044619.18658-12-evan.quan@amd.com>
 <CADnq5_OpT1bxmF-F52fN0gTMffRL49m_-Ln28JuLkCmXsdxBsA@mail.gmail.com>
In-Reply-To: <CADnq5_OpT1bxmF-F52fN0gTMffRL49m_-Ln28JuLkCmXsdxBsA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9e020dfe-6e58-4cea-b220-00004a904a92;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-05T05:52:07Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4a0ea528-625e-4910-821f-08d80914c636
x-ms-traffictypediagnostic: DM6PR12MB2972:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2972FA0379FF759C47FC9996E4860@DM6PR12MB2972.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9M9zAqBOuVVoTwMdVnY/uJWg+AOYotnuSTMBUTzSLUDS3ZhFD92i1oxzbHQbByIEkwmrYZK9xNAlHaPn8N0Xw8LZP707vRRZ9ORRdckihpQU6nkTN6hGevge4GZqldc9oO6yv3v2ezynm0t7kmNOi4H9l8qXPUMoAYE9dTs5UbvUCgGOOEIEr/qvDMw1qYPnYmr3w2iPURtHRNDZ+32d75ywuYaHTy6AehhhHgESdf8BOSLONUeW/EWYm2dEBzpD2wLk/IeN8AwY0tmDLlotOUstEIbGUG0NLGkziSAMlGWWF/Xf6yCFnfMROl75GglJ2kkrPdXUKAF2Jw1p2Y0huO9YutQoBmrCG7QX0s6S+Ft4TQPAOfQA1KweDTA3l8JHs50EemRqX9/Y8JCP/zqPOA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(478600001)(7696005)(66476007)(76116006)(64756008)(8676002)(6916009)(66446008)(26005)(966005)(66946007)(83380400001)(186003)(66556008)(45080400002)(54906003)(2906002)(71200400001)(8936002)(4326008)(33656002)(83080400001)(5660300002)(53546011)(52536014)(6506007)(86362001)(55016002)(316002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: so7UKNvj2GBQWH3grF5cxp6bAzwx7grcHaEUdCB0Xfz5hwZfIHpvy1uLwWcF+wauGLrnlbAQ53gjwgItarXHpsvNeiPiq6MmVNR1mql2hBXEc5/vBhAIhdPgyH2H27TE0Lj9AJ/0WidSue+ITD526/JUCBF/xzYb1ZGKMuRb+J0hxfv6mP2VEAPNgsfYh4XnNNQMkmsvlEm2lSD76I9mXmNEPyq9+V3bYvhBOkl9utIbDmeepV3cVZG2oLtEhSJyc+BspBbelu+43UJ5k3bdv+cKUdEre5810EbCW78BuYSQvC+xi4SVTUdwA5oHGZy2B9qyuxvf8Q2ZE47ofaPzYHUla6d0DLb2GQAx4jczmIdBPWs9ROiCY1UT8agKuku4nzKSLmQgLni38cDTJcvjkpv+RftbglMYgu1CZoaq/x8F9I4LAkLzbzDw/smAx1xsgPrxyn7KujL9VwQJSxxxoB7YgpBRsXacA32rUEbVtW6ed9XNOOwCXrehGI/yvcSw
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0ea528-625e-4910-821f-08d80914c636
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 05:53:30.1212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/8LgB9FVRM0X3OlbYvggEK1+6G6+XzC2JVbP4L+1haN25O1h1AiOPviQ+DO5xpt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2972
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

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Friday, June 5, 2020 5:07 AM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 12/16] drm/amd/powerplay: better namings

On Thu, Jun 4, 2020 at 12:47 AM Evan Quan <evan.quan@amd.com> wrote:
>
> And some minor changes as dropping unused parameter and label internal
> used API as static.
>
> Change-Id: I0af0aea029dc4fc7d8e150ab6ec984e9a5f1a74a
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 12 +++++-------
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  2 --
>  2 files changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index b3410d111316..55ffbf1cf086 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -638,7 +638,7 @@ int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size)
>         return ret;
>  }
>
> -int smu_feature_init_dpm(struct smu_context *smu)
> +static int smu_get_driver_allowed_feature_mask(struct smu_context
> +*smu)
>  {
>         struct smu_feature *feature = &smu->smu_feature;
>         int ret = 0;
> @@ -662,7 +662,6 @@ int smu_feature_init_dpm(struct smu_context *smu)
>         return ret;
>  }
>
> -
>  int smu_feature_is_enabled(struct smu_context *smu, enum
> smu_feature_mask mask)  {
>         struct smu_feature *feature = &smu->smu_feature; @@ -1115,8
> +1114,7 @@ static int smu_sw_fini(void *handle)
>         return 0;
>  }
>
> -static int smu_smc_table_hw_init(struct smu_context *smu,
> -                                bool initialize)
> +static int smu_internal_hw_setup(struct smu_context *smu)

The "internal" in the name made me think this was related to someting in smu_internal.h.  Maybe call it smu_smc_hw_setup()?  I guess I could go either way.

[Quan, Evan] Thanks. This and other comments were addressed on code submitted.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>  {
>         struct amdgpu_device *adev = smu->adev;
>         int ret;
> @@ -1287,11 +1285,11 @@ static int smu_hw_init(void *handle)
>         if (ret)
>                 return ret;
>
> -       ret = smu_feature_init_dpm(smu);
> +       ret = smu_get_driver_allowed_feature_mask(smu);
>         if (ret)
>                 goto failed;
>
> -       ret = smu_smc_table_hw_init(smu, true);
> +       ret = smu_internal_hw_setup(smu);
>         if (ret)
>                 goto failed;
>
> @@ -1487,7 +1485,7 @@ static int smu_resume(void *handle)
>                 goto failed;
>         }
>
> -       ret = smu_smc_table_hw_init(smu, false);
> +       ret = smu_internal_hw_setup(smu);
>         if (ret)
>                 goto failed;
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index b2de042493ad..5f5a210668a1 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -656,8 +656,6 @@ extern const struct amd_ip_funcs smu_ip_funcs;
> extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
> extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
>
> -extern int smu_feature_init_dpm(struct smu_context *smu);
> -
>  extern int smu_feature_is_enabled(struct smu_context *smu,
>                                   enum smu_feature_mask mask);  extern
> int smu_feature_set_enabled(struct smu_context *smu,
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cev
> an.quan%40amd.com%7Cc40db198d5ce43d1c5f408d808cb414c%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637269016367160396&amp;sdata=XQbV2yqVdKZZY
> fM0j%2FZWQe2U53ik6untquO4FRp2OEU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
