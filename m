Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB57EC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 12:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3672074D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 12:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Cw4dEZsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3672074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B69C6E0F6;
	Mon, 24 Aug 2020 12:27:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AAA86E0F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 12:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oETFfqioKu2KWZ2qVxlvRTeKLxyjQzcXjSZxZw+lDGJ9Y/zg5kV1EA0S0IO5tHCDFMDntjBooM9zxWsjLdcHKH8BIjYClMGDyrqaBLSVIaYBuxYVpMfL5Fl/SK7ib4gdf8oSVvFJbMW2g+qDbpvL6dFpj/mKC0bkdLfBzarP3LPtaN+qr4eU/9nZxuaETrNrI0RHGcIeCM2ijCtjUF2iM/F0z8ZjQ7lrhUj5JvQYs6QtxgTesV9y/8HObGcDkf7VwrnCULs15f4J6x/M5unOROd9FSmTO3CtbPmvWU+AfWqRJ5C/Nkr6hpVx+YX3mooiw5zls4aC9sULTLR6otDILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u411HdA/ZRQ2J/4zQsrRsVTGuASa93fKIfOzTSr30PY=;
 b=juc8WWy65jfYgKOVNmRVN20XKxkDanIh5t2whoZzAA+m75Qf+dOyhgTlvLcH+fOBI/ngw+/fJ6WVNWAcMIW5/RgxGWgqd7uKgRBTiClNoNeg8Yq1cZMd6IIrX/86/LkUUdA5amx9hLQvjhVssm2Z9x38GUbLT1OCTOVdsGfejetFzhFWu2T1o4c4NKhGL8NmylvKSI9q7XXOp5EOs/eJ0+MMBBDTLlyQoHH/0OPw0NnT65IpCp1ALVP+E+TCmA/ci6t7tgfFRUAq0ON05ZC0fo001399YLP1izIrso7x3uopTxdSzqLLLRfZTYG4lQylxhSRx63u4PfVfS1s++IFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u411HdA/ZRQ2J/4zQsrRsVTGuASa93fKIfOzTSr30PY=;
 b=Cw4dEZskeDNk85uzE/7/+nqaKSydAJsokWeLB3FHYshXkPXkWDyuEqRpwcoGfwBFHETyg+WXNo0spRyzW4zIZrIZXsKG5mQ5uoAZWUGOHEDHY3sthSnNqY7cVU+6Q9kZI1967nrOpsiBI1/k49sdriCTpsi67X8NkW1tgm27hFQ=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2960.namprd12.prod.outlook.com (2603:10b6:208:101::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 12:27:32 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93%4]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 12:27:32 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: fix is_dpm_running() run error on 32bit system
Thread-Topic: [PATCH] drm/amd/pm: fix is_dpm_running() run error on 32bit
 system
Thread-Index: AQHWefSiAEKP3DP8ckqr3LrQKgsMAqlHKAKAgAAHJr4=
Date: Mon, 24 Aug 2020 12:27:32 +0000
Message-ID: <MN2PR12MB3022FF5C3770CA4C5A941951A2560@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20200824085922.2134157-1-kevin1.wang@amd.com>,
 <CH2PR12MB4326C5DAD1707EB4F9E7D338EA560@CH2PR12MB4326.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4326C5DAD1707EB4F9E7D338EA560@CH2PR12MB4326.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-24T12:27:31.604Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.246.143.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 71bd7cd1-3993-41d6-19d7-08d848291317
x-ms-traffictypediagnostic: MN2PR12MB2960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB29607392BBC7BB0027D0A030A2560@MN2PR12MB2960.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EO8f7eMzqh1A6q0pA9M7fTULyZBGKvUr5rQUSLBdx2PgA+g3Dp5HkUo3F371X+/ZjAqizA+kvCTzPRFvufZomTK8d5CxZZvdVU0JdANmZcXSTQ9Mvj9lGbLE3iLg7Qdh/Ph/ow6ViRQO32UhId+xEj7KTHhKySoFzVLxM7tRciFWhekHY7hp44DVls14tNsj5EH0Ne/LS534y6JrtWpOxinTQC/tFvQH+fNS+M3dIOuqvNruvhdFyPiK5NGhXaXrk37G7sZPJGUHegJFtmJrdAj/zDOfqnuZSfPd7IwnJMjiMv85MlnPjGlEETusX/PR8clTAIz6ZBWWskOWdMrPwObvvzcpCbNtBcBE6TXi5gM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(52536014)(6506007)(53546011)(186003)(26005)(45080400002)(55016002)(166002)(19627405001)(7696005)(33656002)(5660300002)(54906003)(110136005)(4326008)(83380400001)(76116006)(91956017)(316002)(86362001)(66946007)(66476007)(64756008)(8676002)(2906002)(478600001)(71200400001)(8936002)(966005)(9686003)(66446008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ydEcindsU1N2i+J2cJshAQcaQz5uOC+lVTgIZhSYzal5bN8iXtDsCO9NDDqAg7sdnyKYeRKIO23PdK0eJVepeDOustxUuDj/UlCsQXmNamQEB1oyjHYvrNCYMMV0y+prnBsuwb6283J660QAaxOMKeKooJJ++GI/VfiZpGyKlHTskZghEeV3O3HXnLOlj5zL6Cg76feP+KFkOuVAGsxGOQHEgdiP4jXSN+R63q+1+D9tM+kK5xAGvTTDllLhqIQMLZ1okcnZlB3QVss7FFoBJNMAG5zgtjexRJ1Uyzxq804qEKmI/RTiYGLKPgKy/IFMarsRVBkydVrxK1ijiP18nXiZnV+Ccqfv9BgFx7ywACXRYrGumOWFIXTzesCUQcRMIJkzsB4QQArjXdsJ1hHbTtquvElTYbBZYDnvsxE0NyNjOXu0Qo20t8hUF0sUiGizLtQixM/4dfGfuYe9EbY1IbepR3pGDti6NMHeRB1OAGijIIgYOSZWX7dFrrn6KCHMH9W3XZ78XlbsVCrZZOYeNco+oagRpTkkejhGjWZuPueyA4sPpi6NYZMrVgMyCoW+/GvHBNEQIREtWybZ0xyrrW8bpx7rSJ12KFM2pvGwe1GYmiZzisPUdLN0JLykf6IOCr/dG5f0kciAJzyLiahrOQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bd7cd1-3993-41d6-19d7-08d848291317
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 12:27:32.2066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIX0MqexAhf7Pe7bVBA7h9ELrFs+Q/FGgP603KqQ9F4sfLIO9G1Zb0hoOU+wsfqN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2960
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Content-Type: multipart/mixed; boundary="===============1849967764=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1849967764==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3022FF5C3770CA4C5A941951A2560MN2PR12MB3022namp_"

--_000_MN2PR12MB3022FF5C3770CA4C5A941951A2560MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Indeed, that's not necessary.
thanks.

Best Regards,
Kevin

________________________________
From: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Sent: Monday, August 24, 2020 7:59 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix is_dpm_running() run error on 32bit sy=
stem

[AMD Official Use Only - Internal Distribution Only]

Good point, but  I wonder whether the outmost uint64_t cast is necessary?

Regards,
Jiansong
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin
Sent: Monday, August 24, 2020 4:59 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: fix is_dpm_running() run error on 32bit system

From: Kevin Wang <kevin1.wang@amd.com>

the C type "unsigned long" size is 32bit on 32bit system, it will cause cod=
e logic error, so replace it with "uint64_t".

Signed-off-by: Kevin <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 9 +++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 9 +++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 9 +++++++--
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 8347b1f2509f..e619315b0f5c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1844,10 +1844,15 @@ static bool arcturus_is_dpm_running(struct smu_cont=
ext *smu)  {
 int ret =3D 0;
 uint32_t feature_mask[2];
-unsigned long feature_enabled;
+uint64_t feature_enabled;
+
 ret =3D smu_cmn_get_enabled_mask(smu, feature_mask, 2);
-feature_enabled =3D (unsigned long)((uint64_t)feature_mask[0] |
+if (ret)
+return false;
+
+feature_enabled =3D (uint64_t)((uint64_t)feature_mask[0] |
    ((uint64_t)feature_mask[1] << 32));
+
 return !!(feature_enabled & SMC_DPM_FEATURE);  }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 72f3d68691d8..d95b370adaf4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1345,10 +1345,15 @@ static bool navi10_is_dpm_running(struct smu_contex=
t *smu)  {
 int ret =3D 0;
 uint32_t feature_mask[2];
-unsigned long feature_enabled;
+uint64_t feature_enabled;
+
 ret =3D smu_cmn_get_enabled_mask(smu, feature_mask, 2);
-feature_enabled =3D (unsigned long)((uint64_t)feature_mask[0] |
+if (ret)
+return false;
+
+feature_enabled =3D (uint64_t)((uint64_t)feature_mask[0] |
    ((uint64_t)feature_mask[1] << 32));
+
 return !!(feature_enabled & SMC_DPM_FEATURE);  }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 66d655958a78..f8df6448ab4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1150,10 +1150,15 @@ static bool sienna_cichlid_is_dpm_running(struct sm=
u_context *smu)  {
 int ret =3D 0;
 uint32_t feature_mask[2];
-unsigned long feature_enabled;
+uint64_t feature_enabled;
+
 ret =3D smu_cmn_get_enabled_mask(smu, feature_mask, 2);
-feature_enabled =3D (unsigned long)((uint64_t)feature_mask[0] |
+if (ret)
+return false;
+
+feature_enabled =3D (uint64_t)((uint64_t)feature_mask[0] |
    ((uint64_t)feature_mask[1] << 32));
+
 return !!(feature_enabled & SMC_DPM_FEATURE);  }

--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CJiansong=
.Chen%40amd.com%7Cffe808387ca14e51bab408d8480bc717%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637338562729795065&amp;sdata=3DU2xw6nM06S0Am3TFYfyLhCH=
ob2k3UH%2BYgMX1hYFKKHE%3D&amp;reserved=3D0

--_000_MN2PR12MB3022FF5C3770CA4C5A941951A2560MN2PR12MB3022namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
<span style=3D"font-family: calibri, arial, helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">Indeed=
, that's not necessary.</span>
<div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
thanks.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,<br>
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Chen, Jiansong (Simon=
) &lt;Jiansong.Chen@amd.com&gt;<br>
<b>Sent:</b> Monday, August 24, 2020 7:59 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;<b=
r>
<b>Subject:</b> RE: [PATCH] drm/amd/pm: fix is_dpm_running() run error on 3=
2bit system</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt">[AMD Official Use Only=
 - Internal Distribution Only]<br>
<br>
Good point, but&nbsp; I wonder whether the outmost uint64_t cast is necessa=
ry?<br>
<br>
Regards,<br>
Jiansong<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ke=
vin<br>
Sent: Monday, August 24, 2020 4:59 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray &lt;Ra=
y.Huang@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;<br>
Subject: [PATCH] drm/amd/pm: fix is_dpm_running() run error on 32bit system=
<br>
<br>
From: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
<br>
the C type &quot;unsigned long&quot; size is 32bit on 32bit system, it will=
 cause code logic error, so replace it with &quot;uint64_t&quot;.<br>
<br>
Signed-off-by: Kevin &lt;kevin1.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 9 +++++++--<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; | 9 +++++++--<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 9 +++++++--=
<br>
&nbsp;3 files changed, 21 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
index 8347b1f2509f..e619315b0f5c 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
@@ -1844,10 +1844,15 @@ static bool arcturus_is_dpm_running(struct smu_cont=
ext *smu)&nbsp; {<br>
&nbsp;int ret =3D 0;<br>
&nbsp;uint32_t feature_mask[2];<br>
-unsigned long feature_enabled;<br>
+uint64_t feature_enabled;<br>
+<br>
&nbsp;ret =3D smu_cmn_get_enabled_mask(smu, feature_mask, 2);<br>
-feature_enabled =3D (unsigned long)((uint64_t)feature_mask[0] |<br>
+if (ret)<br>
+return false;<br>
+<br>
+feature_enabled =3D (uint64_t)((uint64_t)feature_mask[0] |<br>
&nbsp;&nbsp;&nbsp; ((uint64_t)feature_mask[1] &lt;&lt; 32));<br>
+<br>
&nbsp;return !!(feature_enabled &amp; SMC_DPM_FEATURE);&nbsp; }<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
index 72f3d68691d8..d95b370adaf4 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
@@ -1345,10 +1345,15 @@ static bool navi10_is_dpm_running(struct smu_contex=
t *smu)&nbsp; {<br>
&nbsp;int ret =3D 0;<br>
&nbsp;uint32_t feature_mask[2];<br>
-unsigned long feature_enabled;<br>
+uint64_t feature_enabled;<br>
+<br>
&nbsp;ret =3D smu_cmn_get_enabled_mask(smu, feature_mask, 2);<br>
-feature_enabled =3D (unsigned long)((uint64_t)feature_mask[0] |<br>
+if (ret)<br>
+return false;<br>
+<br>
+feature_enabled =3D (uint64_t)((uint64_t)feature_mask[0] |<br>
&nbsp;&nbsp;&nbsp; ((uint64_t)feature_mask[1] &lt;&lt; 32));<br>
+<br>
&nbsp;return !!(feature_enabled &amp; SMC_DPM_FEATURE);&nbsp; }<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
index 66d655958a78..f8df6448ab4d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
@@ -1150,10 +1150,15 @@ static bool sienna_cichlid_is_dpm_running(struct sm=
u_context *smu)&nbsp; {<br>
&nbsp;int ret =3D 0;<br>
&nbsp;uint32_t feature_mask[2];<br>
-unsigned long feature_enabled;<br>
+uint64_t feature_enabled;<br>
+<br>
&nbsp;ret =3D smu_cmn_get_enabled_mask(smu, feature_mask, 2);<br>
-feature_enabled =3D (unsigned long)((uint64_t)feature_mask[0] |<br>
+if (ret)<br>
+return false;<br>
+<br>
+feature_enabled =3D (uint64_t)((uint64_t)feature_mask[0] |<br>
&nbsp;&nbsp;&nbsp; ((uint64_t)feature_mask[1] &lt;&lt; 32));<br>
+<br>
&nbsp;return !!(feature_enabled &amp; SMC_DPM_FEATURE);&nbsp; }<br>
<br>
--<br>
2.27.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7CJiansong.Chen%40amd.com%7Cffe808387ca14e51bab408d8480bc717%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637338562729795065&amp;amp;sdata=3DU2xw=
6nM06S0Am3TFYfyLhCHob2k3UH%2BYgMX1hYFKKHE%3D&amp;amp;reserved=3D0">https://=
nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedeskt=
op.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CJiansong.Che=
n%40amd.com%7Cffe808387ca14e51bab408d8480bc717%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637338562729795065&amp;amp;sdata=3DU2xw6nM06S0Am3TFYfyLhCH=
ob2k3UH%2BYgMX1hYFKKHE%3D&amp;amp;reserved=3D0</a><br>
</span></font></div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3022FF5C3770CA4C5A941951A2560MN2PR12MB3022namp_--

--===============1849967764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1849967764==--
