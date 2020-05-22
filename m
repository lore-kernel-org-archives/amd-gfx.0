Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261A2C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 19:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E363C20723
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 19:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FsPYyRtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E363C20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A03266E0F0;
	Fri, 22 May 2020 19:40:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F14986E0F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 19:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLbCCsr1AwvFp2Nj+8wyA96Dc0p6rdRIOcf9yjyd15A9rMmmI4vr26+soXXQ45aflGGSyhn5xuAhCjmI4qZ2Eu6hS20tFvm7fmecsa38Z8+VyBfWnLVZBd7Rq/RyNnwz4CVVFii4qeGoxgJgzjB3pd+gn60qv9XNOKhm1JSx6Y6jnU7RJ5+UA9ZvZS2VNp7eG+Dv77LFdoGZk3ZDpFu9aFXlX3AQ/06UwmyMGGxR1sLAj/E1j0s0ROszZ8zIxav6bffrdE3j+IwpC6uvPS6xrIv8uLxLJKHdrXJX2+VCC9lN1o6qPCtxWuM5f689NdI2+BvCgpwdpkKWxHgXBFLfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mMlhtah6dB3R05ESNFIsSzJ50tSGVNl3qCmKHYU+jU=;
 b=JT9cTiypckzP/BhTTEa0asWADk2NKI+wpuuhzbaaMoIQ4sr8jvvnZTR4emTdoQYOaClRkcEBwVSTpqAGYC0BUxPbmu9oy7/5w5aCkBcoyJwqzBqMakhIvhTMykNS7f2VzPZG4Pzdvls9nSdUbPi2RrPNqS290T38RbCNrsRGZzncvntudlVBw7UKgIKBgh3b8m3e8Wdz6Wps8Ba1ZAOmDeMbMfoYf/204t0U2NJSVd2LF7kqejLNBvQ3NBWfGVsugX/9+R1T7YmQHhbWH45F6hYA34K+9x23Zyr0zh+q5wS8Y/R+vHaMn2p6bafZxL7/au9mKoHsyLD6HRgnwVOfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mMlhtah6dB3R05ESNFIsSzJ50tSGVNl3qCmKHYU+jU=;
 b=FsPYyRtOBs62E+LtkqwKelY5MjVRhVvU7Q0fytWRZWYhC4g27v3i+QhcMcqyiULG2kQhXBJT8xGxh7AhAyd/RLBdSKh4DUOEk6jc/CBamjWWKKvFZMfJ9IwweTice3Ki2BjJJLeHTKxa0+PI2MJk1lplmilsa3ZBYNje2OMqE00=
Received: from DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Fri, 22 May
 2020 19:40:55 +0000
Received: from DM6PR12MB4121.namprd12.prod.outlook.com
 ([fe80::21db:6afc:4193:872c]) by DM6PR12MB4121.namprd12.prod.outlook.com
 ([fe80::21db:6afc:4193:872c%8]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 19:40:55 +0000
From: "Wan, Gavin" <Gavin.Wan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for
 SRIOV.
Thread-Index: AQHWMGWYIZUGxpxlykulf/mN5eEHfqi0eJIAgAAIPIA=
Date: Fri, 22 May 2020 19:40:55 +0000
Message-ID: <DM6PR12MB41219812A4B209595F9DA352FCB40@DM6PR12MB4121.namprd12.prod.outlook.com>
References: <20200522181931.277182-1-Gavin.Wan@amd.com>
 <CADnq5_P3a9-_zaoZBGi1nrnUJ2HVYb4_UWpjxLn7+S9qSe5zpQ@mail.gmail.com>
In-Reply-To: <CADnq5_P3a9-_zaoZBGi1nrnUJ2HVYb4_UWpjxLn7+S9qSe5zpQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [198.91.162.234]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 106cbcb2-366f-4fa9-9468-08d7fe880b65
x-ms-traffictypediagnostic: DM6PR12MB4579:
x-microsoft-antispam-prvs: <DM6PR12MB45792A6E3DE88B7EAAE5CED3FCB40@DM6PR12MB4579.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rp29Ee/dojAcERMc4XMKRM4wsJ0SspaBeWlfhuLOXGcnInXLqYGQgoIbx10KTD7Mpn6bJaQi7UP8xIABfH21n7SqHXo/mygXqd0ASc3tvDh0cLCADfLTw3n19RwJmuoMF3ujWRKb9yj32QGTwHLNVLqUPmgU4JhEoG24hap0bM4903QrT9ozS247Ix3XmlGsj/FoiZeGKs1c96VW7uo2lGd/nqoIt9OPSzdbfTUwBeonRR1XNgdelwhF2iSbUl05r1ZXfhfltETYOK9gTbpmP5RIDkqExG5ENZfeJ4LBrex9y+T/WTP69k8zhuuGpHUdSNVq/UWvfFhRnDfQinmG/vLnZq6pcNaxave/5rhyJO8x9zU+w5JB4/N+/2AfDEfwiXdByJU32rL/h40N+FJ8tA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4121.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(71200400001)(33656002)(316002)(4326008)(53546011)(6506007)(186003)(26005)(7696005)(2906002)(83080400001)(6916009)(966005)(45080400002)(9686003)(55016002)(5660300002)(86362001)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(478600001)(8676002)(8936002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 3uoBl8Sm5/uJIV9oA9sbokUgKju3Y9gLaU0TtmbzYPfHbz1crauwwicE70O2HI3dyEfsFtKRrerFy7QmRSZKQI9rUc51gGdEQtYbJ9fy1KqBSd0JJSN3/lna1GCuEWisxL/9xM5WsLVwOMo7UH9CDxaH+NIIQFgygjk6qmbcs4eT/ybvignMpHRnMdcIkrV+VjqzuD6noFEdPtixu+7P7lIBd0O5urfQUdgq2r0z8bkl1JW8aYeEM+qEOGl7PRzVDU0/c4Q/CEOlyY2G4D8UhXajPvz46PAwVugNkXY9AV9JMKQk9qTqTww6UxpsTPawZBEufM0LvnKFhMI5KyMF5JSiUqP2J9rKiWYhLK1RwAjNFbIVvgPUf694JtYsG5zJ9+te+VH4abTAoM7zh7HePZ05pIaiSSKGhBqgfbwK5Wa8RKesXJrn6s/LnIzxA4XIBHWz5wX0pqKORJ/8JgW/pEdhYNr+/N4a8XuC7bVAy4bVP+378y6kjIQ6kM0puOA/
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106cbcb2-366f-4fa9-9468-08d7fe880b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 19:40:55.5223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gghuPj/DSqEktpsB+qXmtmFNu8JvQImlsN3P2graquyrtO0IakgIlrVY19t4UbCi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

HI Alex,

I fixed it as your suggestion.

Thanks,
Gavin

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Friday, May 22, 2020 3:11 PM
To: Wan, Gavin <Gavin.Wan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.

On Fri, May 22, 2020 at 2:20 PM Gavin Wan <Gavin.Wan@amd.com> wrote:
>
> For SRIOV, since the CP_INT_CNTL_RING0 is programed on host side.
> The Guest should not program CP_INT_CNTL_RING0 again.
>
> Change-Id: Ic336fab3b23b8371c9e9e192182a3ba14a8db8e1
> Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index bd5dd4f64311..39275bf79448 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4558,6 +4558,9 @@ static void gfx_v10_0_constants_init(struct 
> amdgpu_device *adev)  static void gfx_v10_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
>                                                bool enable)  {
> +       if (amdgpu_sriov_vf(adev))
> +               return;
> +

This needs to be below the stack variable declarations or you'll get a warning.

Alex

>         u32 tmp = RREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0);
>
>         tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, 
> CNTX_BUSY_INT_ENABLE,
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CGa
> vin.Wan%40amd.com%7C23c1770b248841c7032a08d7fe83d940%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637257714548695750&amp;sdata=PaWH5hLNb3N1Z
> lalw4GsjeeB46xzCVxXDWBROndcKsk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
