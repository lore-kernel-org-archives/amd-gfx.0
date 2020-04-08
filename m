Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903C1C2D0EA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 13:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 499112072A
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 13:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UegRaCqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499112072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F01386EA5C;
	Wed,  8 Apr 2020 13:25:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E8F6EA5C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 13:25:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OP+XYtGheWoECubtvanLGF49gsGdOYFxZ79MZwY+d0zDhrhfDEHyQxKlnbhZYeClqkn05YJwTqqqHZsJoMJIgBBMD8sZdMstlOyyjMLLnQ77/u3G1Hb5vYrVJvCz+/pSEHVgYli0yU4rlHKk2o5fohHGOAo2nfKR9QkjWwGLV6WOOc/PLJKdIUkhEoih4mfDnZZB3Gf1JYqvbzV0pVb19tIJAkSBNp8WznJznfEJxgy+PrX+TOSTyvjvzstLV8rJ4QEbnzsa1pnIuOmdR5+U81XR8DVoYcvV4gdxaEiS9pvEQHF6oU+Sk8SC2cp1PMwfrgbHYxP4Ylivuc0C8BmnHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn4rCJSQdEXBnfq5+QdKkjbV5wR1SYGEIJLZ0s+pt0k=;
 b=HKnibYPSXw0NuJt6vLoDV/qMTDzI0vQXwEjtlEyLeFPwW7v5ixD6O7fw/Khwm6zKm3kAYagJ5AjYafq5yIFRapx2kBHyMMa3ApiIoapPMgSNPSFjVmrEpDYvFse9b3f4Bi+Rt2tw97XaZ2+w32MtTtRVjxvgZMRZBLO6bvcyn+2V2ojoXc3ttklWGDZ7reRznZGl9lri9DZG2aQPjIlq5vh2eTtv/Fws3uxF720wmXLGEtfgded1qdRpuxWOeLRgrtQchNWTvmck5yXu1xq/XaYBMmOXhhFfjk9urv0dbhi0j34xj/pK/yESfo2jrEQ4mYrOsxZD9ekQ/hEATV6aXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn4rCJSQdEXBnfq5+QdKkjbV5wR1SYGEIJLZ0s+pt0k=;
 b=UegRaCqmeuRX46rcVXTvxgoNpD3mvbUuk0cZFCuCOmk2vRfNVGfD1X6O11DMguFu9x8xxxxfpZKeu8Uni+F/lPN4SmHM2xgjQC6HqY73gMDd4D6SlPZJsXPvEUjl1qOrlrZe2qL78lMJ+AGMbjexn7UrzT9R3uTeWRGqorrcigw=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4016.namprd12.prod.outlook.com (2603:10b6:208:16b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Wed, 8 Apr
 2020 13:25:13 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2878.021; Wed, 8 Apr 2020
 13:25:13 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: unify fw_write_wait for new gfx9 asics
Thread-Topic: [PATCH] drm/amdgpu: unify fw_write_wait for new gfx9 asics
Thread-Index: AQHWDXFiO8n3tZYb90i3ivcVINkXJ6hvN0zb
Date: Wed, 8 Apr 2020 13:25:13 +0000
Message-ID: <MN2PR12MB44887732BC07518A13FCFE0EF7C00@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200408064548.857-1-aaron.liu@amd.com>
In-Reply-To: <20200408064548.857-1-aaron.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-08T13:25:12.328Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7482e90a-ed9f-41c4-4ad7-08d7dbc044f5
x-ms-traffictypediagnostic: MN2PR12MB4016:|MN2PR12MB4016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4016327AD6DBC30E312B636FF7C00@MN2PR12MB4016.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(186003)(26005)(66946007)(478600001)(53546011)(4326008)(66446008)(86362001)(66476007)(66556008)(33656002)(64756008)(9686003)(6506007)(81166007)(2906002)(7696005)(71200400001)(55016002)(5660300002)(54906003)(316002)(19627405001)(8936002)(8676002)(81156014)(110136005)(52536014)(76116006);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UgEvwlGOmzN7aAeN9tKqj2+DFAL36h+3rYtlyRBrO3MFyRMickAC97d3is9fRn5HzMvEnE1RgWv/2W938cYpc39N9X15KOlFtJ6WFQIwm25zLGwcJCLg/UgiGvkkdJC7igqoO2BN9SeXiGYO1TePpyHwfthWfoLiO1tgazYin8KQWktcxFsHBmyVJ98dEvvYVLKMkx8xrpJ8ho4I4SFyHhRf0NlB8dPwjdK61PLy/GsdhrPLVdgN4WaIM2yOkzS0IZFDr+bzfeYc5/1ez2HO6GHA55NvjfPy3NLvRMUjxfy5oh5PLn8aU5on4ilXm69AmmCvb4nyT6EHDKy/nO2o3NXPHDkJD+V44xlj5FEQzAM0hVRyZLil2ZvdaXLfL/epfCR6b7l2+0cwO1cHbZ2fvBzTJ+SsjEYG2ax2YokUMutSHPjWn7WsSVtzCEfpDXmd
x-ms-exchange-antispam-messagedata: 8ci6gUwl69ixmch03+Opu/totBZlL2N0ONxfIrGu/wWMCGzNuvQ44/fzl9oeVc/dps/zRMxZMH6rtG5VatNW7g3d/1Bf9S0U4hoes/7kfWqSH5sr5AfoTiY96s2rttAYBugIiBW39uPtoH3B3NkGCQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7482e90a-ed9f-41c4-4ad7-08d7dbc044f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 13:25:13.2219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hy3Rd7gjRicytDXJIMG2zCM4h6kdBwv4WnlIjbnj0M7NLVgEBdBiwKaDzFVIjW/ar2iFH1GdlTmn0vMybUN3ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4016
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Dai,
 Yuxian \(David\)" <Yuxian.Dai@amd.com>
Content-Type: multipart/mixed; boundary="===============1560443137=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1560443137==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44887732BC07518A13FCFE0EF7C00MN2PR12MB4488namp_"

--_000_MN2PR12MB44887732BC07518A13FCFE0EF7C00MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Liu, Aaron <Aaron.Liu@amd.com>
Sent: Wednesday, April 8, 2020 2:45 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Dai, Yuxian (David) <Yuxian.Dai@amd.com>; Liu, Aaron <Aaron.Liu@am=
d.com>
Subject: [PATCH] drm/amdgpu: unify fw_write_wait for new gfx9 asics

Make the fw_write_wait default case true since presumably all new
gfx9 asics will have updated firmware. That is using unique WAIT_REG_MEM
packet with opration=3D1.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 2d56b06722bc..1d18447129b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1214,6 +1214,8 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgp=
u_device *adev)
                         adev->gfx.mec_fw_write_wait =3D true;
                 break;
         default:
+               adev->gfx.me_fw_write_wait =3D true;
+               adev->gfx.mec_fw_write_wait =3D true;
                 break;
         }
 }
--
2.17.1


--_000_MN2PR12MB44887732BC07518A13FCFE0EF7C00MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Aaron &lt;Aaron.=
Liu@amd.com&gt;<br>
<b>Sent:</b> Wednesday, April 8, 2020 2:45 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray=
 &lt;Ray.Huang@amd.com&gt;; Dai, Yuxian (David) &lt;Yuxian.Dai@amd.com&gt;;=
 Liu, Aaron &lt;Aaron.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: unify fw_write_wait for new gfx9 asics<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Make the fw_write_wait default case true since pre=
sumably all new<br>
gfx9 asics will have updated firmware. That is using unique WAIT_REG_MEM<br=
>
packet with opration=3D1.<br>
<br>
Signed-off-by: Aaron Liu &lt;aaron.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 &#43;&#43;<br>
&nbsp;1 file changed, 2 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 2d56b06722bc..1d18447129b1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -1214,6 &#43;1214,8 @@ static void gfx_v9_0_check_fw_write_wait(struct a=
mdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;gfx.mec_fw_write_wait =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;gfx.me_fw_write_wait =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;gfx.mec_fw_write_wait =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44887732BC07518A13FCFE0EF7C00MN2PR12MB4488namp_--

--===============1560443137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1560443137==--
