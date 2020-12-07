Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43102C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 14:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E003E2337F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 14:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E003E2337F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F78189BFC;
	Mon,  7 Dec 2020 14:40:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C5C389BFC
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 14:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvAoEPg4G6KRGhbIfOjGzEyqFqenRE2AhtLsfkAjAFh2uMVldQVq33bNNVOqfMlO3i/q3/cngISXf4FXoUdenUHcRLm3TUvpcaymVnPOzwCHTFdtx40fJJMOSD9iZ1V0e676ZwgXUqI413Vyim9AiipKEXq0DnjuIB3qO/XdfwUgD5hW5PeAtgAbAu98buwsUc07nfJPnvav8etnVJh0MLtDP1rWgY8b1FKpudFboGQ/VMSY4AB84WAXRjtVHYs2Iyoa5EkIq1+TacVKXW44lSHwITpB9gAS8EpSAKa+zmSg+E6EX9wCstFhWBrBHySANP1FnsLT/wJfk3ouzvkzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3L69j8aH+o6V1kNypgMi9xQN7tMDritqQun79oJDV0=;
 b=W9DUtMMNpsTA4DnXcHqiml+PHhMF1MgrTjPV3lps3mcL8baWXFDlEVTG3TZaV03IgKLMYVxaMHr088crTd1g/8blzlop+AvpkCluts1y2wWX4NZ9tB4pvOPROVlLR6tNh1psGTzFDv9WHpz/QDKEvXZCVFUh8cIg1inre+UJTntKnGR8Z1I0iRLCZPsg8SASyeuwVlBYDtibSJd/dc+tHkcpTimORELUyM/xGcxJSrMauKevDs0A3m2eclZtUVGtxtxK/1FiGHDvq3RtRewHHTZyamv2Qjj8ia/NaAzsGrWbSEc00nUmrWrTJI+hTtMlFzk4jVJWMNBWAnS5nEXdNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3L69j8aH+o6V1kNypgMi9xQN7tMDritqQun79oJDV0=;
 b=wRezCb5PkjdSt6sVz+Kko4yJc92sXT32JM4/qXJ2TesCDG8Z15bZBWL/nvJmqofP0r1tErmV1oqrxwMEgBpH1cTTJS69eNHcjGJpDnjicTsuLsusyyrn/5w858OMDGa70bRDvHwsj1ZddrpLdk7JzOruMR2hWGasIylRopcd+7g=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2371.namprd12.prod.outlook.com (2603:10b6:207:3e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 14:40:06 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%5]) with mapi id 15.20.3632.019; Mon, 7 Dec 2020
 14:40:06 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Brol, Eryk" <Eryk.Brol@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 14/17] drm/amd/display: Enable gpu_vm_support for dcn3.01
Thread-Topic: [PATCH 14/17] drm/amd/display: Enable gpu_vm_support for dcn3.01
Thread-Index: AQHWyoTNdko/91uTl0yRRnmjYa49M6nruGnX
Date: Mon, 7 Dec 2020 14:40:06 +0000
Message-ID: <MN2PR12MB4488879965A579F764B05367F7CE0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>,
 <20201204212850.224596-15-eryk.brol@amd.com>
In-Reply-To: <20201204212850.224596-15-eryk.brol@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-07T14:40:05.541Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f29d1f1-21e5-43ae-a06a-08d89abdfd81
x-ms-traffictypediagnostic: BL0PR12MB2371:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2371CFBEED90C7CE5662A2F3F7CE0@BL0PR12MB2371.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d3BYFrUoY+bEuDJVKFoXSa8UibfEsdQqi5LutXwEnJp499736D+1d+cVTouej4UIq7vhnRmpIxqq+9SwHpDyhyGNxP29MVdQRqfpEeXOuvEzzT+9sZZErrruQtMf15u1DcaWyio97d8L0e0j1mn3GUXOxNN0GzboqiRRSAzlF+9RGF2NKNoVk4jpSXJGVm70wCVYlezUF4rn1IoT30a8AtuYHGau5WHsX38pp8svmim1pocPYbNhUv/w/Zrnsf+HREnb/y3tGaZUKHJZ6EMdUqMn85Lfs8Jfwcgi3Jf3Tk8w5dTP0w80aXSl5HyQoQKO17AKiJ1tqR6dzWuT6K9+SE5P+11UfQKPeAivUC267dw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(6506007)(8936002)(9686003)(86362001)(53546011)(83380400001)(8676002)(966005)(33656002)(66476007)(2906002)(4326008)(166002)(478600001)(26005)(186003)(7696005)(66556008)(45080400002)(71200400001)(316002)(76116006)(64756008)(66946007)(55016002)(66446008)(19627405001)(54906003)(5660300002)(52536014)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Dw5TC22zSI/ywVHqds55N0qiTkLk14RLrqmnRFPXkvwr7wQxtvRieNva5dWc7wTJ3hZZaHHHePQu6J7p4yiugIzk2UX9Z6DJOLmsiUcOhJjfFiSKfD0xV0YINBRlmpfgSJu+Bwm+L0jFmqlk/c1ULyKwnGLjkKzodwaqND5y/8weqZ9kGQjnKusEqTQ6v3W3dEQsKkwebg7x+6b9KmBrNfMM/3JIQ5jCVmzuAQXGO2+I4C4LXsrTNlPMrTfXYRw0sK9o2nSIOiWR7xHWtzNW1zPQ9Qf8S/qznpGum7fBVrjs3XREcDt2MQm3JhenWEO86c5ttkow+5L1XVu+8scXociMC7JfOlUU1SrQn0lZPJeiVSp1VFGreTLcdcELTK34cmD6+cimaHxL+BKiGYa8xPm+OztfDDZ7KuFs0uFhaUPvrkHalLOR04DavYdyQuelKxDZeGiRb5p18p5HY8byqWbsgTmXlzMy3SRPnTdiOsfrIhM+x62iDciRihM5TF7Yo4gzB5dLX1NCFZ9nCJEzKGxbcauaMkR46PSEKHrBI86wBj5wFScPKV3Z4bhjZhBMV4FDx3oIArq8hvCajhq3Ty2I8wqam6SvYvR9Sw1/nx+zABvLXV+2yT9h2PCiG8zji5SZm49DWzur7Ay+uyLQwAYPci86gcbPSA4r+XcEhQV/4YOQ1q3r4h+GZZbF7Kf2fgWzANBDtu0W8UBp7WsmbG9QO6b8AAvtgcXdm0/DiEg=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f29d1f1-21e5-43ae-a06a-08d89abdfd81
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 14:40:06.2884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W5Qc3O5cYy3e7tm4lVRtk7KkBn/9k/oOHO5yCJzh9vLSA6KV0Z7VDzEsminpTyAjbWLUT09+D80Q8bVSG6gRZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2371
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
Cc: "Liu, Charlene" <Charlene.Liu@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Sun,
 Yongqiang" <Yongqiang.Sun@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "R, Bindu" <Bindu.R@amd.com>
Content-Type: multipart/mixed; boundary="===============1331110831=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1331110831==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488879965A579F764B05367F7CE0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488879965A579F764B05367F7CE0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

We've dropped the CONFIG_DRM_AMD_DC_DCN3* kconfig options recently.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Eryk Bro=
l <eryk.brol@amd.com>
Sent: Friday, December 4, 2020 4:28 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liu, Charlene <Charlene.Liu@amd.com>; Brol, Eryk <Eryk.Brol@amd.com>; L=
i, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd=
.com>; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.S=
iqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Sun, Yongqi=
ang <Yongqiang.Sun@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>=
; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 14/17] drm/amd/display: Enable gpu_vm_support for dcn3.01

From: Charlene Liu <Charlene.Liu@amd.com>

[Why]
dcn3_01 supports gpu_vm, but this is not enabled in amdgpu_dm

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 59f738008734..53a7cb21f603 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1035,6 +1035,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev=
)
                 if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
                         init_data.flags.disable_dmcu =3D true;
                 break;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_01)
+       case CHIP_VANGOGH:
+               init_data.flags.gpu_vm_support =3D true;
+               break;
+#endif
         default:
                 break;
         }
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C93575bd3247e42f848bc08d8989bee3e%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637427142787650359%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3Dwf2Tl4Qz9IzTZVvfBRYcFHZ8Cr464ZEZ%2B1Pb1GP5W9E%3D&amp;reserved=3D0

--_000_MN2PR12MB4488879965A579F764B05367F7CE0MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
We've dropped the <font size=3D"2"><span style=3D"font-size:11pt">CONFIG_DR=
M_AMD_DC_DCN3</span></font>* kconfig options recently.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Eryk Brol &lt;eryk.brol@amd.c=
om&gt;<br>
<b>Sent:</b> Friday, December 4, 2020 4:28 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liu, Charlene &lt;Charlene.Liu@amd.com&gt;; Brol, Eryk &lt;Eryk.=
Brol@amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wentland, =
Harry &lt;Harry.Wentland@amd.com&gt;; Zhuo, Qingqing &lt;Qingqing.Zhuo@amd.=
com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Pillai,
 Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Sun, Yongqiang &lt;Yongqiang.S=
un@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; R, Bi=
ndu &lt;Bindu.R@amd.com&gt;<br>
<b>Subject:</b> [PATCH 14/17] drm/amd/display: Enable gpu_vm_support for dc=
n3.01</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Charlene Liu &lt;Charlene.Liu@amd.com&gt;<br=
>
<br>
[Why]<br>
dcn3_01 supports gpu_vm, but this is not enabled in amdgpu_dm<br>
<br>
Signed-off-by: Charlene Liu &lt;Charlene.Liu@amd.com&gt;<br>
Reviewed-by: Yongqiang Sun &lt;yongqiang.sun@amd.com&gt;<br>
Acked-by: Eryk Brol &lt;eryk.brol@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++<br>
&nbsp;1 file changed, 5 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 59f738008734..53a7cb21f603 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -1035,6 +1035,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ASICREV_IS_GREEN_SARDINE(adev-&gt;external_rev_id=
))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_=
data.flags.disable_dmcu =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+#if defined(CONFIG_DRM_AMD_DC_DCN3_01)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; init_data.flags.gpu_vm_support =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C93575bd3247e42f848bc08d8989bee3e%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637427142787650359%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3Dwf2Tl4Qz9IzTZVvfBRYcFHZ8Cr464ZEZ%2B1Pb1GP5W9E%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C93575bd3247e42f848bc08d8989bee=
3e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637427142787650359%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3Dwf2Tl4Qz9IzTZVvfBRYcFHZ8Cr464ZEZ%2B1Pb1GP5W9=
E%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488879965A579F764B05367F7CE0MN2PR12MB4488namp_--

--===============1331110831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1331110831==--
