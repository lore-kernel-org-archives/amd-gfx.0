Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE3FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 05:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 366A920709
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 05:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366A920709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B52D46E530;
	Wed, 27 Jan 2021 05:51:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2958A6E530
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 05:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wl5spd6wgXf+BkdzgEluvdJTg2YWOi46XuZ17TeXsnRTyFL0SKF+DTWKNM5rRvpWb6Z5cuCyAqsTnu5rvsMKdO93GZEWb+6erzkYEmRAOUqz6UjhA5+xtEHtaBlJDamenriY5mg3EQFl7MFD/1i/Z4tjMnTvZjm5zcSpHC7q5QLsyMKnpJiX3X1MCafHuunegtojDcqCCO3RWHmh9M/7GTU0AeN1btL3tzl/diE2ueMZMvUeNrWJ93aUL+3hFvA0QywYJPGwKn6cPUODEOmYjBz60FCAqtDkaelbz9GWyBImrhTyJ2ymk+3rNtd9TdF5FK0RmtER3UHge3jfjx1MNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIunCxmVZMQ/rZfao1Z+Rs7UQyZ37gpAplq84NPopXE=;
 b=LHFLlOJEBUG3QhFgCbdXc2YMJ6FNKkCqwVyEnCiZfiPlxHcX4a7rxwxIhLcq7T4JcXHhZT1PQru6jUlp+Rs0tsrK9CwziaHzn0vIvc1+LQZrXMgEflgsPCYscLZcAayK4ZqlMpxI4mgHwuihzoZiJASRPNVik6AV3fpeNAHMiMhVireUUgRC1jDMO7Nuq/ae4CnbRHHcfWtJ0UEEvXRoTPd6hxcGMZNQWHWLdLV/SyFbHwzGCL5z7rSGR0GHBwXHKZVtIBjg4X2zlj5ocECaLBmWY/rCo0ZzvgP3WPBqUAVpKVKb7QTwDX2CEG0qWW93cZXDA+cluN7TR1Gj4wSSQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIunCxmVZMQ/rZfao1Z+Rs7UQyZ37gpAplq84NPopXE=;
 b=iJ25ftXz8d7Ard6cdp6FISIhIhk54BJQsMAmBvUAh08X/yDMCvhS4VRIIPEfz+DqVrSrjpnWbGuGNNtiNrGk9OPquc9abR4/nYPcCZ4cGvz0gkgnxvghB+J2PGN0u9b7NNjXB+acUPqM+WmLiKfur1ZB8T+VmtKEbIOmfMSkaH0=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 27 Jan
 2021 05:51:05 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::e863:8081:a14d:b03f]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::e863:8081:a14d:b03f%6]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 05:51:05 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback
Thread-Topic: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback
Thread-Index: AQHW9A+A8B54h1FnhECsUfCRTVBIg6o61ZoAgAANYYCAAABmgIAAAHSAgAAB9QCAAApF4A==
Date: Wed, 27 Jan 2021 05:51:05 +0000
Message-ID: <MN2PR12MB454999711FCB8A2D63D5B70497BB9@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210126181702.48944-1-alexander.deucher@amd.com>
 <DM6PR12MB2619EE40237D99D8A666CEFAE4BB9@DM6PR12MB2619.namprd12.prod.outlook.com>,
 <CY4PR12MB1287945849A59414A6B38144F1BB9@CY4PR12MB1287.namprd12.prod.outlook.com>
 <MN2PR12MB44887DFA0177C949C1F99166F7BB0@MN2PR12MB4488.namprd12.prod.outlook.com>,
 <MN2PR12MB4549DE6D9D34295D8E63402B97BB9@MN2PR12MB4549.namprd12.prod.outlook.com>
 <MN2PR12MB44889D2E33706C0208837EDEF7BB0@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB44889D2E33706C0208837EDEF7BB0@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-27T05:51:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.208.238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6fedee0-2f52-4d59-79d8-08d8c2878975
x-ms-traffictypediagnostic: MN2PR12MB4317:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB43173D6999D2C5FD14F392B497BB0@MN2PR12MB4317.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tQnvAmIlnvx/fMvIpehL1HcEPw2oawIxTVHhu3WNJRvDczRw4dr6W3LCy7YX/kkABE7Wx/4jwjjWyfYH4HYaGS5/DHbaZCkx9nXm3e8jLi4zVE5JNt+/fXVO8o3AfzQhYmiXqREC/7Isubs/MqlU+At7YRvDG6uuLK7oBeixxFNiMIoDFJ6lw0uTls76qSyUp091j6fs13xkPzoeK1RO7gSQYAfmRSMuZlHdN9Y53V3692eJ97YL4oZgChlMrz4aJH28OgkIcZBKK2UWGdkVxqS+pE0SVqQKlOPnYVOLIeN/oyKoB+XEx6Sloq6jK6cQE5ofJ4Nl6u/SXPUvn2JxJ7hpDy7/cskePmGck+g8tWbVqi6ZvD5ZF12M3OO3POjaXlIVWge3OLVk2nqPCF2vhRXxmSBKneuwgnS+DOW1mN9hUFo0UZVGv/M82dj/M3T88QoG9Y5BRnjyPUrRu7Vxw5OieUTiJRS4FMLutV2UQI2H+W1yb5IX9RzJRHIKZCLRZj17GbKi+sXvzVrYlk+HdxHIwwURCnnXze4wAG97g44//BuIOfwmeAsdeNxahk3j
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(66476007)(110136005)(8936002)(966005)(86362001)(6506007)(2906002)(64756008)(66556008)(26005)(5660300002)(76116006)(478600001)(55236004)(71200400001)(8676002)(33656002)(166002)(9686003)(53546011)(45080400002)(316002)(52536014)(55016002)(7696005)(83380400001)(66446008)(186003)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?x8MjIeKgJjZ6Q8OZlU00kBpKVh9fiqZyCAIMRDfMKC5b0gSNBlSTtO+firTz?=
 =?us-ascii?Q?vcHKw+G1ePVD3dqZNTLAoym93YzCCrboT1th9J9kImD67C1miJGFDa2e925L?=
 =?us-ascii?Q?u1PSWahxRYtsDtv4aDWWARpgDzjI1SYdl1G8KfPITV1ithZ4qJ2aQtDIu53i?=
 =?us-ascii?Q?kXOKM7IS2xkX5bXDOVHWrtbCuovsTe4/nLls2aYMuVdYP8zts9df9vBb957u?=
 =?us-ascii?Q?DDJFySMyyTwvkH3n1ywqFfwk6yLKnDFsiZgWVAI5yb5tZj+ew9Cl6+KYpCwa?=
 =?us-ascii?Q?Jj3oKVxam9Tr7/+8p2yfdii89ybwCMWxBRzHodpg9WZhS9CxaSDt4MidL2Tt?=
 =?us-ascii?Q?puQFcL0OLfbkclkO/jrsIdQ6BgfwbokRoNfSN2SIFjafZk8csg4X/foizKrQ?=
 =?us-ascii?Q?tdmIKUMHzIYzMk/9uBM0GbEUJCj2NMgPEcey3QnPutoRVSEyPTSFN0DbLLti?=
 =?us-ascii?Q?AS5s+uTe6Uh5XanMLGNhXzXU/IcxgOf8yD53fOAGPjdg7JJjTmhqIjsG+ATd?=
 =?us-ascii?Q?sbaNXD5BR5TmrOMcC/BGnueFyqEaeRqzT8SxduCMvaoH4SgSxDhEmwCbUYAX?=
 =?us-ascii?Q?LF9ait3If2OY45DNY2CZ3I55p7dViGWcrWQJiKo+b7BrspxNUw+763vaZU7Y?=
 =?us-ascii?Q?1bBGlcPFWmLzJjJ3lYHN5EP2DthkPn9AkVNXGNzCifNxM7DCtomCv+//oqYb?=
 =?us-ascii?Q?1qlVqogznoNegD1gzcoKdfcu2hpazQC9fypbYZVW6Da/5LZoF75EXaJKidDO?=
 =?us-ascii?Q?uDs8zHxm0w+gK042bLRqIE63eJvsZI/ILr6+xDM+I+PhGP01cWNYGZmS1YXd?=
 =?us-ascii?Q?gVe8EbysGrp5SV/dVHCmU8eIFy0E6Xx7ke3njF8NK8OdidAQZA7NlJ3fxCiM?=
 =?us-ascii?Q?7g00rNc9RLnbrhGq+NQLGq8lZUxD3leorh8qbF7NJac9QxJ55bhV0FE9D7fx?=
 =?us-ascii?Q?VKRCJSKaSDT3yRd+yIGK2RGC7GQbsxvR2osfjPVf8Le2HeUkRk/abu+DFhRa?=
 =?us-ascii?Q?Eoe9u8uj45bmNvvZ/eLyiAPMduIGiT7RQBlDCOewWMAQIWZIDJ4MvomrQMna?=
 =?us-ascii?Q?IZ2k6/c3?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fedee0-2f52-4d59-79d8-08d8c2878975
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 05:51:05.4928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJkrkEpIQ0gJwZr6aK99TJn+K2BSAP38hZdcB3gg1pi6mNfQCilElsbCz8PS0Q4a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
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
Content-Type: multipart/mixed; boundary="===============0744307175=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0744307175==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB454999711FCB8A2D63D5B70497BB9MN2PR12MB4549namp_"

--_000_MN2PR12MB454999711FCB8A2D63D5B70497BB9MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Agree and the patch looks good so far.

Thanks,
Lijo

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Wednesday, January 27, 2021 10:13 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Q=
uan, Evan <Evan.Quan@amd.com>; Alex Deucher <alexdeucher@gmail.com>; amd-gf=
x@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback


[AMD Public Use]

As Evan said, this code is unused anyway and I have a patch in the works to=
 drop all of this anyway.  The manual manual rpm interface seems to not wor=
k on some boards at all.  I guess the pwm interface is a better bet for man=
ual fan control.  See:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/892cba31627b019c26a9c56=
016e6ebd442166678

Alex
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Tuesday, January 26, 2021 11:37 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; =
Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>; Alex Deucher <ale=
xdeucher@gmail.com<mailto:alexdeucher@gmail.com>>; amd-gfx@lists.freedeskto=
p.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org<=
mailto:amd-gfx@lists.freedesktop.org>>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback


[AMD Public Use]



As far as I know, refclk is fixed at 25M for TACH; no need to consider ASIC=
 refclk.



Thanks,

Lijo



From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Deucher, Alexander
Sent: Wednesday, January 27, 2021 10:05 AM
To: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Quan, E=
van <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>; Alex Deucher <alexdeuche=
r@gmail.com<mailto:alexdeucher@gmail.com>>; amd-gfx@lists.freedesktop.org<m=
ailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback



[AMD Public Use]



[AMD Public Use]



Is the xclk really 25 Mhz or is there some divider for the fan stuff?  Chan=
ging the xclk value will affect other places where this is used.



Alex



________________________________

From: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Sent: Tuesday, January 26, 2021 11:33 PM
To: Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>; Alex Deucher =
<alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>; amd-gfx@lists.freede=
sktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.=
org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback



[AMD Public Use]

In soc15_get_xclk, we have independent handling for CHIP_RAVEN case.

If (adev->asic_type =3D=3D CHIP_RAVEN)
        return reference_clock / 4;

I am not sure if it's better to squash the patch into the asic specific fun=
ction? Then we have one unified place to handle it.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Quan, Evan
Sent: Wednesday, January 27, 2021 11:46 AM
To: Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>; amd=
-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Actually after switching to retrieve fan speed from metrics table always, t=
his API is not used any more.
Maybe we can just drop it. Either way the patch is reviewed-by: Evan Quan <=
evan.quan@amd.com<mailto:evan.quan@amd.com>>

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Alex Deucher
Sent: Wednesday, January 27, 2021 2:17 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback

The xclk needs to be divided by 4.

Fixes: acab02c1af43d3 ("drm/amdgpu/pm/smu11: Fix fan set speed bug")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deu=
cher@amd.com>>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..36dac106ed4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1245,7 +1245,11 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *=
smu,  if (!tach_period)  return -EINVAL;

-crystal_clock_freq =3D amdgpu_asic_get_xclk(adev);
+/*
+ * crystal_clock_freq div by 4 is required since the fan control
+ * module refers to 25MHz
+ */
+crystal_clock_freq =3D amdgpu_asic_get_xclk(adev) / 4;

 tmp64 =3D (uint64_t)crystal_clock_freq * 60 * 10000;  do_div(tmp64, (tach_=
period * 8));
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cguchun.c=
hen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637473159431451098%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3De%=
2BzrZgRQDkOb4ElNJNiLWP%2FHBM0cIQl4GwKFuYfvsP8%3D&amp;reserved=3D0<https://n=
am11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedeskto=
p.org%2Fmailman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7Clijo.lazar%40amd.com%=
7C8cdef44e170e4198c00e08d8c27ce642%7C3dd8961fe4884e608e11a82d994e183d%7C0%7=
C0%7C637473189035661354%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo=
iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DpfK0LTxZUBVlvvX3zs3D=
QjmtYyOJkNdFIBUGkTCyopg%3D&reserved=3D0>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cguchun.c=
hen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637473159431461091%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dlp=
9Gu3pJ7GdDbF1BJNlIQr4Z0TCY%2BTVDGtDWzZ2bR2Q%3D&amp;reserved=3D0<https://nam=
11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.=
org%2Fmailman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7Clijo.lazar%40amd.com%7C=
8cdef44e170e4198c00e08d8c27ce642%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0=
%7C637473189035671303%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV=
2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3Da%2BTTK%2BJ0YjbNe9irLE=
9GRgK0koyGYKfrtcMUR0wkvxs%3D&reserved=3D0>

--_000_MN2PR12MB454999711FCB8A2D63D5B70497BB9MN2PR12MB4549namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsipheader251902e5, li.xmsipheader251902e5, div.xmsipheader251902e5
	{mso-style-name:x_msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Agree and the patch looks good so far.<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Lijo<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Wednesday, January 27, 2021 10:13 AM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Chen, Guchun &lt;Guchun.=
Chen@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;; Alex Deucher &lt;al=
exdeucher@gmail.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readb=
ack<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">As Evan=
 said, this code is unused anyway and I have a patch in the works to drop a=
ll of this anyway.&nbsp; The manual manual rpm interface seems to not work =
on some boards at all.&nbsp; I guess the pwm interface
 is a better bet for manual fan control.&nbsp; See:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><a href=
=3D"https://gitlab.freedesktop.org/agd5f/linux/-/commit/892cba31627b019c26a=
9c56016e6ebd442166678">https://gitlab.freedesktop.org/agd5f/linux/-/commit/=
892cba31627b019c26a9c56016e6ebd442166678</a><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.co=
m">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, January 26, 2021 11:37 PM<br>
<b>To:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Chen, Guchun &lt;<a href=3D"mailto:G=
uchun.Chen@amd.com">Guchun.Chen@amd.com</a>&gt;; Quan, Evan &lt;<a href=3D"=
mailto:Evan.Quan@amd.com">Evan.Quan@amd.com</a>&gt;; Alex
 Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com=
</a>&gt;; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freed=
esktop.org">amd-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readb=
ack</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsipheader251902e5" style=3D"margin:0in"><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Pub=
lic Use]</span><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">As far as I know, refclk is fixed at 25M for TACH; =
no need to consider ASIC refclk.<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Thanks,<o:p></o:p></p>
<p class=3D"xmsonormal">Lijo<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-=
bounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt=
;
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Wednesday, January 27, 2021 10:05 AM<br>
<b>To:</b> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.C=
hen@amd.com</a>&gt;; Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Ev=
an.Quan@amd.com</a>&gt;; Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gma=
il.com">alexdeucher@gmail.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readb=
ack<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]</span><o:p></o:p><=
/p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]</span><o:p></o:p><=
/p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">Is the=
 xclk really 25 Mhz or is there some divider for the fan stuff?&nbsp; Chang=
ing the xclk value will affect other places where this is used.</span><o:p>=
</o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">Alex</=
span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
</span><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"xmsonormal"><b><span style=3D"color:black">From:</span></b><spa=
n style=3D"color:black"> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd=
.com">Guchun.Chen@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, January 26, 2021 11:33 PM<br>
<b>To:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@am=
d.com</a>&gt;; Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">al=
exdeucher@gmail.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readb=
ack</span>
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal">[AMD Public Use]<br>
<br>
In soc15_get_xclk, we have independent handling for CHIP_RAVEN case.<br>
<br>
If (adev-&gt;asic_type =3D=3D CHIP_RAVEN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return reference_clock / 4;<br>
<br>
I am not sure if it's better to squash the patch into the asic specific fun=
ction? Then we have one unified place to handle it.<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Quan, Evan<br>
Sent: Wednesday, January 27, 2021 11:46 AM<br>
To: Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@g=
mail.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Ale=
xander.Deucher@amd.com</a>&gt;<br>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
Actually after switching to retrieve fan speed from metrics table always, t=
his API is not used any more.<br>
Maybe we can just drop it. Either way the patch is reviewed-by: Evan Quan &=
lt;<a href=3D"mailto:evan.quan@amd.com">evan.quan@amd.com</a>&gt;<br>
<br>
BR<br>
Evan<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Alex Deucher<br>
Sent: Wednesday, January 27, 2021 2:17 AM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Ale=
xander.Deucher@amd.com</a>&gt;<br>
Subject: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback<br>
<br>
The xclk needs to be divided by 4.<br>
<br>
Fixes: acab02c1af43d3 (&quot;drm/amdgpu/pm/smu11: Fix fan set speed bug&quo=
t;)<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
">alexander.deucher@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 6 +++++-<br>
&nbsp;1 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
index 147efe12973c..36dac106ed4b 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
@@ -1245,7 +1245,11 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *=
smu,&nbsp; if (!tach_period)&nbsp; return -EINVAL;<br>
<br>
-crystal_clock_freq =3D amdgpu_asic_get_xclk(adev);<br>
+/*<br>
+ * crystal_clock_freq div by 4 is required since the fan control<br>
+ * module refers to 25MHz<br>
+ */<br>
+crystal_clock_freq =3D amdgpu_asic_get_xclk(adev) / 4;<br>
<br>
&nbsp;tmp64 =3D (uint64_t)crystal_clock_freq * 60 * 10000;&nbsp; do_div(tmp=
64, (tach_period * 8));<br>
--<br>
2.29.2<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01=
%7Clijo.lazar%40amd.com%7C8cdef44e170e4198c00e08d8c27ce642%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637473189035661354%7CUnknown%7CTWFpbGZsb3d8eyJ=
WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;=
sdata=3DpfK0LTxZUBVlvvX3zs3DQjmtYyOJkNdFIBUGkTCyopg%3D&amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Cguchun=
.chen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637473159431451098%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdat=
a=3De%2BzrZgRQDkOb4ElNJNiLWP%2FHBM0cIQl4GwKFuYfvsP8%3D&amp;amp;reserved=3D0=
</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01=
%7Clijo.lazar%40amd.com%7C8cdef44e170e4198c00e08d8c27ce642%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637473189035671303%7CUnknown%7CTWFpbGZsb3d8eyJ=
WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;=
sdata=3Da%2BTTK%2BJ0YjbNe9irLE9GRgK0koyGYKfrtcMUR0wkvxs%3D&amp;reserved=3D0=
">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Cgu=
chun.chen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637473159431461091%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;=
sdata=3Dlp9Gu3pJ7GdDbF1BJNlIQr4Z0TCY%2BTVDGtDWzZ2bR2Q%3D&amp;amp;reserved=
=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB454999711FCB8A2D63D5B70497BB9MN2PR12MB4549namp_--

--===============0744307175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0744307175==--
