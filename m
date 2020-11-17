Return-Path: <SRS0=Y8VF=EX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0D5C2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 14:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22C0221FC
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 14:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u3tj9QvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22C0221FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE7B6E22F;
	Tue, 17 Nov 2020 14:22:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D0AC6E22F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 14:22:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ik9MpieKVnh0n/tOUI+P60vNJZSgSOLa3uXB1ZWxhF0KHOhiGHwXxMIuyt25oUnyIFSgoOGgDteYQiraPIHMRQB/ti2MP14IaqwYIvOgdo/YIRtPLBsm2/DPi9Iyhanyu1PsidMsIm01vUgpHXnjGb0YnptrJk9ouFcgYZK/g4VRYuF0vmlz2Ky/pJaH97YpfnJxk7EJKqrFnRiyA5jfF+ZbuyyMp0vY6iq43askXlsekHoWii2xFGjN8e+CXU+NCEKpT9AStofdfav2/Cq6nzGhW2mtb7V4OGK0Bp+CRZwXqpIFsxRCOIWxDOt3UG+zov9Uu8CfHF8sgK1mCntd8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plDV4J8Qf6EH1+GORT3n5mVjOBJf+trdZqTO1ykuPRU=;
 b=KCc5YnwCfio5rMuqcYnnFTscAaiNX+cRUMYbVTXY8F+EcNxu1u45kaSonLqE9NT4UvjdfPdFHnMHx5NVEncxmQcntheRuA/2zHtZePRPmEH5kMBSkylhSxGCP9D3KBu/l5iGQbQG+0QQE4RP029GjjP8TE27gHCqX5AyLb9bUz7jM3y9FIDONIyYKfPTO2LjRpYcog3iqs5CuRMAiTsynK8zAul40XEE+i8txn4G7sOcVnHg3qHemgx5mLDtKxo4jiSn52mL074PnV4AAuzNzfTzdIGwmSF+FTPH3bW+vU4Dck5BtnWrO3dTnl8hf38WUamP+tw0ZWWbpUAJaY7oAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plDV4J8Qf6EH1+GORT3n5mVjOBJf+trdZqTO1ykuPRU=;
 b=u3tj9QvXf32fu3/uVaw0qA7kne6is6XJidVNIotI2OFB3OetX9x5tRonUKbkTnWuy0mTh3OikAUMUiM7QdTUScL3VsFBn0FYbWgDdkRqcVppI4wVHRqr0PV9ZdfWq1zQwwVeanZbpoWDHUdqYTZGmVD9iMBAVGeLWMtK68bc7xE=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 14:22:09 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3564.030; Tue, 17 Nov 2020
 14:22:09 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/pm: fix the crash after runtime pm resume
Thread-Topic: [PATCH 2/2] drm/amd/pm: fix the crash after runtime pm resume
Thread-Index: AQHWvOXxvnJXwhL/Ck68e1DVCSo5+qnMX+2E
Date: Tue, 17 Nov 2020 14:22:09 +0000
Message-ID: <MN2PR12MB448831750FA3D120F734BA65F7E20@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201117133051.1016-1-kenneth.feng@amd.com>,
 <20201117133051.1016-3-kenneth.feng@amd.com>
In-Reply-To: <20201117133051.1016-3-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-17T14:22:08.637Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2cc69448-4f36-42ea-01d2-08d88b042b3d
x-ms-traffictypediagnostic: MN2PR12MB4141:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB41418EA48B328EFBB1495459F7E20@MN2PR12MB4141.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: McmjJ/iq2Fz1N+HC+7ayCz1X4dEguXdYSJHL+HSkPU9NEb5yV02dB1BnN/1zR8lg61mUXz+oTP/XPRZm5yF1TmZJIOrCF2psHsRjHzk4gZzn8ZHZZ88GxtJB43X/ZHZC2KU+pddCxdZQGxrmFk0KT+3T8ypiCgYlMIaeJmK8fWcRObHMIfoBlBKsc6zq9HZMJrVSBjQU0Ulgwx7eX3goWpmyHEOmYjMQYs5Ye2NMA+gLMjrM7qL1whiapjSdOMJh6P7MJBnsU8bgn43crRCj5iFxiA53zYRrRY11cyN3LuGOO5TNBVD1SwwomSiPQELMmXDOL9c1ZMwkv5z2ZcfXXT8OBCYV7db1d0Sk24KUMrA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(966005)(166002)(8676002)(9686003)(316002)(110136005)(55016002)(83380400001)(8936002)(478600001)(45080400002)(186003)(52536014)(76116006)(5660300002)(71200400001)(66946007)(86362001)(19627405001)(33656002)(7696005)(66476007)(53546011)(64756008)(26005)(2906002)(66556008)(6506007)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: WsYsgCGJpVh/egXUuySyBO0KizKAm/Q72+sqD3tYycIkTXsMnhPtfE0VGJzH+DTChNm289bCUUClsUg3dJXOM52+MFmp6QduFWu/+jdlwTkH1STnpwbDmjkL2FnWqYwiGuyk1raTD2+eplPyBX7qC06x8lyZX2pWJ7l424KuxuNLnNoqxeVPJYJ8Pax3hLtrF3720TRuAl4R0/xuXX84GnaBUCsPwO5BTCaE0kY5yweTwOJjLgDv6E8vxxes/zTwNeLphstSCnk2c4QcpOPswq2MXMYJLRnzph5WThNs94+cK3v/VjPvlCqm+t56LSDopUmfwOGzjLI84ejjK2hSykduJV4hP/eA4jcCwePWBMux210uyDTyb+n9jdQY3nXaZnWPsPGOoCr8ze3W5ZbU9O8TkRu7ffgMRxWaD/+kYIMVKl3sLMJPq5tZcB7t1hFBkPHbPBNmuDN6HNJaEnm0aJEP3FMxn+/cwlNb7nuPjl4pg3MpEoY+Zh4K5Ff3t0NlcJ1at06ulgzP8l4mvUOPrW1dyR0SAjeOTJZx9a9v37JMp9zDm2RWabpnM+Wbt25awxyPZw+jK16SN8ggo0kfivQcKMWgDIhrc146UhebfRZYC+4huOqGzNVnhtpTPlDKwIE8Y0PYjl9rDiF3nUHBtNhZRAgCePrUjzNHh73cyyfuqjdyuqbAuBdDRV87SKh3Aj2F1xz4Y1sIghn/74NbV7flIlx59A6dSWW68jEMDb6QXfopwbFI/09FL3exlb8TDDTRBFiIJB/WVuG3zQj+C2KCnu0YmdR7DSacKNQMbP3bQU5SvgKSckYPV7iZplToqAfNa2uTIw5w1JwBAp5OandO5xYvk4PfzD1S/1JoGX0M8a2kHIzo4lq+RaIq5v2vDfxQtoN+dzNxNuK/KqSB6Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc69448-4f36-42ea-01d2-08d88b042b3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 14:22:09.3308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XckYTgT8SSR9uSfqV3Sg0OL2aPA3p64vLdHt2w6fpVSL9GKAKaZnBz15/uPhEyjTmN279UoEIwTZTRQ6YHH3Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141
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
Content-Type: multipart/mixed; boundary="===============0342828859=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0342828859==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448831750FA3D120F734BA65F7E20MN2PR12MB4488namp_"

--_000_MN2PR12MB448831750FA3D120F734BA65F7E20MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Does the same thing need to be applied to navy flounder and dimgrey cavefis=
h?

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kenneth =
Feng <kenneth.feng@amd.com>
Sent: Tuesday, November 17, 2020 8:30 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: fix the crash after runtime pm resume

Some features are still disabled after runtime pm resume. This can take the=
 hardware back.
Unlike other projects, this doesn't need pptable retransfer.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 39990790ed67..ebd50f144c5d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -914,11 +914,14 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 {
         struct amdgpu_device *adev =3D smu->adev;
         uint32_t pcie_gen =3D 0, pcie_width =3D 0;
-       int ret;
+       int ret =3D 0;

         if (adev->in_suspend && smu_is_dpm_running(smu)) {
                 dev_info(adev->dev, "dpm has been enabled\n");
-               return 0;
+               /* this is needed specifically */
+               if (adev->asic_type =3D=3D CHIP_SIENNA_CICHLID)
+                       ret =3D smu_system_features_control(smu, true);
+               return ret;
         }

         ret =3D smu_init_display_count(smu, 0);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Cdd553fd04f0f44ebf3ca08d88afd11ad%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637412166838877500%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DswZeNMubEey64ZdWb7W5sTg88as3VNS9ILwmLb08GHY%3D&amp;reserved=3D0

--_000_MN2PR12MB448831750FA3D120F734BA65F7E20MN2PR12MB4488namp_
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
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Does the same thing need to be applied to navy flounder and dimgrey cavefis=
h?</div>
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
ounces@lists.freedesktop.org&gt; on behalf of Kenneth Feng &lt;kenneth.feng=
@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 17, 2020 8:30 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/pm: fix the crash after runtime pm resu=
me</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Some features are still disabled after runtime pm =
resume. This can take the hardware back.<br>
Unlike other projects, this doesn't need pptable retransfer.<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 +++++--<br>
&nbsp;1 file changed, 5 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index 39990790ed67..ebd50f144c5d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -914,11 +914,14 @@ static int smu_smc_hw_setup(struct smu_context *smu)<=
br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pcie_gen =3D 0, p=
cie_width =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_suspend &a=
mp;&amp; smu_is_dpm_running(smu)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;dpm has been enabled\n&q=
uot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* this is needed specifically */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHLID)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_syst=
em_features_control(smu, true);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_init_display_c=
ount(smu, 0);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Cdd553fd04f0f44ebf3ca08d88afd11ad%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637412166838877500%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DswZeNMubEey64ZdWb7W5sTg88as3VNS9ILwmLb08GHY%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Calexander.deucher%40amd.com%7Cdd553fd04f0f44ebf3ca08d88afd11ad=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637412166838877500%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;amp;sdata=3DswZeNMubEey64ZdWb7W5sTg88as3VNS9ILwmLb08GHY%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448831750FA3D120F734BA65F7E20MN2PR12MB4488namp_--

--===============0342828859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0342828859==--
