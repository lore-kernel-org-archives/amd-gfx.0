Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B609C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 15:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C196C2310E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 15:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C196C2310E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 583CD6EA84;
	Thu, 10 Dec 2020 15:21:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F466EA84
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 15:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVSGKEQGnT/cvKdug/sqD1Xmc++pCLfgiCuAAOfE2LUZ4wtUGvSV/2/7BP03pXOK1vGZYqkQGGtVnXXh+hm+adCmPV90TuMfKKz1lVIM2QlPZ+nO5FT5LPA1S6UM0O8Rx81LLpWWDEUuHpuJMJxCkzeOVQ5nO3ro7hMdNwuTdVqrdpPeMipM99vDME54/rQKR7R4YrvUE6d0ptL8buToJKBF3SXdzsff1M07N6vpHiFy2PUwkaw83VyQ3bKG9cOqxsGM0rHwx29IYCNN/GyUghH6ZVu4pPdGshwA/f9YFVnBIv+NF7FnIZ0isJnI+mVY3vIH8Hu6aifCrJ10ZH5Q4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIJokABHWKSRpoBiyhMeCdcKfhhWPxnVNTSGwc4GGak=;
 b=g3atDWbrlWfWcza1bLus4QNG8Jm2c7hUJglkLmRZITOpqKqr7yGI5+Ne1UcPePvWahReJ6gpU4aWHnohFo4WkZFiH9tEMHi1fUJaeE869aBzdfBa57o/sfNaCVtvxc9JIuCCzd2PjYth9JRSOLrmRXlilLIdN5MY7DUeZBG8+HZo0d0ltaKmTUwh1q+a9CoNedlcrCQXbrYn0IaUIIc0EirBgii6LJ0fQA+GEtZVpdoiut+GqYAVoTLtXPinrEMdGRrhEJQXVr1VZ6wmnRt1m1yfIBfZDhn6t3kMaW3NDjxZeZsdG6Qw4HG/R2gfD7vOUEJ5Z9nASqRgOySa1FAmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIJokABHWKSRpoBiyhMeCdcKfhhWPxnVNTSGwc4GGak=;
 b=ZxzemQyWB+1vvoAw5/WfsO53beakmvDvjsYPhltBdTOm3nsplGMJa8ICAo7AMQ1LqgFwzARePBdY0Sstr0UeF+/Vxb6FtDxW+Y2I6yvboMBx9fv7QAb8w5UgIk8yMEg16WNqrgn52zkYzNrcb0+Nzq5+FlEhCimS7h4dwMokKCY=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2467.namprd12.prod.outlook.com (2603:10b6:207:4c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 15:21:11 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%5]) with mapi id 15.20.3632.019; Thu, 10 Dec 2020
 15:21:11 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: add deep sleep control for uclk and fclk
Thread-Topic: [PATCH] drm/amd/pm: add deep sleep control for uclk and fclk
Thread-Index: AQHWztC1JwhJ4BMF30yAxIjsnoeePqnwcncF
Date: Thu, 10 Dec 2020 15:21:11 +0000
Message-ID: <MN2PR12MB44880623621213C31F28CF66F7CB0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201210084415.206309-1-evan.quan@amd.com>
In-Reply-To: <20201210084415.206309-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-10T15:21:10.741Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c009ef21-7ea3-4abd-ce2b-08d89d1f3a02
x-ms-traffictypediagnostic: BL0PR12MB2467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB24675036DB6A51129E5CF21FF7CB0@BL0PR12MB2467.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:116;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fbrBI84oG8SI+Aif13h4bmjC3P3AYaBXzpfQQrvKtC9BN1IW0IAw3o+EqSBnAV5B4tB261p4tTvKqZc1IvRCp1QNzg6N+HYyN658miSVBCjlkMw/SJTf0C0K8nvOgmtM20QVXew0btmkvTOwi0cZL4B8pH66QhbV1Wecpyij7GVGGyEC73YdsXJxQa6QK/cjZvyiE6dicZnhpgGP94E0BBop8u1q0S/nLi8GappxU8zLW49cg2kWqykTn1KAc6jwAUrBVKgqr27A0PHNUIvj+MhQjFfv/fCNA1xpIDT51EexebdQrvmbb0LJOccoSo+GaK5WCh9bABGFIoS06VarKw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(19627405001)(6506007)(66556008)(76116006)(53546011)(2906002)(8676002)(9686003)(66446008)(508600001)(55016002)(33656002)(7696005)(52536014)(110136005)(71200400001)(66476007)(86362001)(186003)(66946007)(26005)(8936002)(5660300002)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?r+dFBGsJS5Ye718GFw9IP3svGf5kInZKgGF0vspJyFN4cpAiaVuMlzTpXe2S?=
 =?us-ascii?Q?2OIuRUDOPhUSJ/8T3i3+c6vqUfE7de7Yc6wiheqVEcNvBZ5yI1rae6CBOd+E?=
 =?us-ascii?Q?lCAbaGDFFQj6+p5dHV0FiUrZ8AQjxhfCiPiUO7Ay9DZf46sTwcbUpg6vMwo4?=
 =?us-ascii?Q?NnEWWokTHmJy5L2ZcMEQs8MyUtY2TcRbdw4d8yO/zOsV3kp1AmjVfQJ55SYM?=
 =?us-ascii?Q?hp0xZZWxmYIkx+jDG1lq+yd77pJX7ZksSiPc7UGxD5XqtV3tGCaSR7BY3vfS?=
 =?us-ascii?Q?XIKnpQFatXh1Y69+K31KUnWhekIbeDvs1L7MfxhYzemCgt3DmsyymQ98h9a/?=
 =?us-ascii?Q?SoxLAz2nZGvCsCgBDBkpYve+dxo/ana/RPAlY12vchTqCd/D5iXB9k1fWLaz?=
 =?us-ascii?Q?Te6r4b+/7T/R426FHgXqLLDbBGihq4braojCNrKE4thK+aXrkdXD2zgh239a?=
 =?us-ascii?Q?FuTkt/b6V+yb7yHRH977/5PeOMsnegM+QNUiUEeCrZb1OiAjF40ZWLU6SssR?=
 =?us-ascii?Q?JnjqWw+ZzZcu7NFJuk7sVfB+Srm6Ip6cLkjPVZaDb2/3VCqC11DRsmfAyKQt?=
 =?us-ascii?Q?Z868R+Wtcvi8ljwMxR6nalEdia2kvtFr5lKqUPKgxi7O2mOiqzVHHzvXXYuM?=
 =?us-ascii?Q?tyN/t3QNuD0NWkAaomZBrDjy+AbHfcv4U937NbQeIw4lW8myhx02kWQ/yeDB?=
 =?us-ascii?Q?8UNTaEM5s6BLxSV8u9J9i3YQtgogZmjEWH2cRs79Dicy4Dl9YiYZ2zY/dZaY?=
 =?us-ascii?Q?0mXKPNQamDPdApteQ6nVy09GTMfKJTVaWnurZv1qQ+tQ5z0aQyQnTO5RTPK/?=
 =?us-ascii?Q?m794srr+BNdBXtVdc5uQ9a6BS+Td3aaPkkYBOvAKiTvvfkzPol63DiDQxsdm?=
 =?us-ascii?Q?P3bPDhN/QdGDU0oH1XiSyjYvA6FVGkD54I9PqZoqtA/ZFwo7WN10JAk/FCIi?=
 =?us-ascii?Q?3XatHI6ijYT4KPTLwf04CtaWzmAaFBIVbXrgynui9s0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c009ef21-7ea3-4abd-ce2b-08d89d1f3a02
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 15:21:11.4788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opXuf0G8d74CpUt8BCTmI4LJlSsjubISDo0XhUxMHFl2GvlG2Lbpa96rrJ/VPBHK+VmvK3nDSnKGUMhDkj9ydQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2467
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
Content-Type: multipart/mixed; boundary="===============0035898916=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0035898916==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44880623621213C31F28CF66F7CB0MN2PR12MB4488namp_"

--_000_MN2PR12MB44880623621213C31F28CF66F7CB0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Thursday, December 10, 2020 3:44 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amd/pm: add deep sleep control for uclk and fclk

These are supported by Sienna Cichlid and should be
taken into consideration during DS control.

Change-Id: I93ed67ae863a91b75d6dfecd87e74029ffafd302
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index 45ecd0386e9f..0372cb83cdd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2087,6 +2087,22 @@ int smu_v11_0_deep_sleep_control(struct smu_context =
*smu,
                 }
         }

+       if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_UCLK_BIT)) {
+               ret =3D smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_UCL=
K_BIT, enablement);
+               if (ret) {
+                       dev_err(adev->dev, "Failed to %s UCLK DS!\n", enabl=
ement ? "enable" : "disable");
+                       return ret;
+               }
+       }
+
+       if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_FCLK_BIT)) {
+               ret =3D smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_FCL=
K_BIT, enablement);
+               if (ret) {
+                       dev_err(adev->dev, "Failed to %s FCLK DS!\n", enabl=
ement ? "enable" : "disable");
+                       return ret;
+               }
+       }
+
         if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_SOCCLK_BIT)) =
{
                 ret =3D smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_SO=
CCLK_BIT, enablement);
                 if (ret) {
--
2.29.0


--_000_MN2PR12MB44880623621213C31F28CF66F7CB0MN2PR12MB4488namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 10, 2020 3:44 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: add deep sleep control for uclk and fcl=
k</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">These are supported by Sienna Cichlid and should b=
e<br>
taken into consideration during DS control.<br>
<br>
Change-Id: I93ed67ae863a91b75d6dfecd87e74029ffafd302<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 16 ++++++++++++++++<=
br>
&nbsp;1 file changed, 16 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
index 45ecd0386e9f..0372cb83cdd9 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
@@ -2087,6 +2087,22 @@ int smu_v11_0_deep_sleep_control(struct smu_context =
*smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_cmn_feature_is_supported(smu,=
 SMU_FEATURE_DS_UCLK_BIT)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_UCLK_BIT=
, enablement);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;Failed to %s UCLK DS!\n&quot;, enablement ? &quot;enable&quot; =
: &quot;disable&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_cmn_feature_is_supported(smu,=
 SMU_FEATURE_DS_FCLK_BIT)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_FCLK_BIT=
, enablement);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;Failed to %s FCLK DS!\n&quot;, enablement ? &quot;enable&quot; =
: &quot;disable&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_cmn_feature_is_sup=
ported(smu, SMU_FEATURE_DS_SOCCLK_BIT)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_feature_set_enabled(smu, SMU_FEATURE_=
DS_SOCCLK_BIT, enablement);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-- <br>
2.29.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44880623621213C31F28CF66F7CB0MN2PR12MB4488namp_--

--===============0035898916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0035898916==--
