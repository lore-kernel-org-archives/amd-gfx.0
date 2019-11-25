Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B602C432C3
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 15:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1980A2084D
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 15:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1980A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C40C36E14C;
	Mon, 25 Nov 2019 15:41:57 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760043.outbound.protection.outlook.com [40.107.76.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53EE16E14C
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 15:41:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhKjnl5swLJ/NgUA7pnmb73YiKUoQzEm+jZyrKngLoyVqVb5mrR3tba+GJ7SoMl0hKMTrCoWyQcBbW+QX2YCgHcPYDPNiwPpEmfaQVm3J7p+sDueFYVnecBdj5T2NOSapGBBRrJDMwVirUkmh1NlJmdjpy1Z08zwFztOdGwuWxFmJt1ldkivEZl60HxUPTIkxCZ9Oj8vfzhlAla0Xya2QtfR0V37i75MA4PPtBoNRSDDMLg0ug6oQRCjuWxoOOkE1GYZwLk40FpQxrxiTBlz6fwxHfAmPFEbd9R5KpyFsHw8txXQtqob+ma4WiUK4cOI7Hh7WCMAqFQZ2xGufIg4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ctq3DRbvkVhSXyTqXDqEYiwVywkTb5uKpFW9HOUE15E=;
 b=YaShUlqOxLO65SdqQWVvAorTipbrzxClPA3cL0lTGeOMHn8EMH3f57F9/jw8NJWT2uw/FoWcSXh6YBwyBkw6mxBAlf0/3ztCPObmVCG5rIran7EXgleE/UbAkTBdunHIyQTX3xkrwMCCGJbKJDp+YMAQV/AQinlS1bvEF9kBddF5nXHRXNx1EDy6qnFPwmgsBBoXhjQ2y+t2GXh0v7ekVSPoIwGYuiqyWNkJf4sWosiWEyauc9y2E0PvZrQxtaNvr4oY7B635oWuHQ5vENw9U1hEjoflwLAtKWeErYvZq1rh4eAPFF+3isoQj6H8qo/UoKcVEDzhG8jhrlsaXs54mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB3323.namprd12.prod.outlook.com (20.178.31.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Mon, 25 Nov 2019 15:41:54 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616%7]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 15:41:53 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Null check aconnector in
 event_property_validate
Thread-Topic: [PATCH] drm/amd/display: Null check aconnector in
 event_property_validate
Thread-Index: AQHVo6axrr7/34JRSUSG4iAOmU8w6KecBk3d
Date: Mon, 25 Nov 2019 15:41:53 +0000
Message-ID:
 <DM6PR12MB346695688D92D386098283019E4A0@DM6PR12MB3466.namprd12.prod.outlook.com>
References: <20191125154024.21218-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20191125154024.21218-1-Bhawanpreet.Lakha@amd.com>
Accept-Language: en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-11-25T15:41:28.6731105Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
x-originating-ip: [209.171.88.88]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 752b775d-9a42-44eb-5a5a-08d771bdff0d
x-ms-traffictypediagnostic: DM6PR12MB3323:|DM6PR12MB3323:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3323ED3434096E0A06CAEAD79E4A0@DM6PR12MB3323.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(81166006)(66476007)(64756008)(66556008)(5660300002)(66946007)(52536014)(76116006)(86362001)(26005)(6506007)(102836004)(53546011)(33656002)(2906002)(4326008)(66066001)(66446008)(229853002)(236005)(6436002)(9686003)(6306002)(6246003)(55016002)(54896002)(25786009)(7736002)(446003)(11346002)(606006)(478600001)(45080400002)(966005)(14454004)(8676002)(6116002)(81156014)(186003)(3846002)(76176011)(2501003)(7696005)(316002)(256004)(110136005)(14444005)(71190400001)(71200400001)(99286004)(8936002)(74316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3323;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?XIo1efcgdZt8DErQ0gUnVUYnIWI2j8wflNGw7Bu47fqGVVKB0+rS66A2CdDD?=
 =?us-ascii?Q?JUxxFPThs1Zb1eCbjxMzaT1Su6ZTeuI4LnLvVHx3j8cUhOqwFsBL3Ep51J3p?=
 =?us-ascii?Q?YCJSEl1sVLGwe0n39Xa3hc+BTfzHQJFMQI2pfn13IA6vxjgmgEx2BvmF35lr?=
 =?us-ascii?Q?GNSA08P0CV40nsNplAprzF5aqn1fUu4RuFRexR/xfWJREUGhl0yE8zssWwbh?=
 =?us-ascii?Q?wi4Wdk5Uoihd1cmGlWuKsMIrsBaoTSfUNsL3WBmdNQvOWq82mNrtuC2eHB9f?=
 =?us-ascii?Q?DWC7nDcuhVPAkRqdYOhKZ21/+SGymVd25EjDKKiEa0WK5Xmioc+nyeQb5kWL?=
 =?us-ascii?Q?EM9M9v6LiXoS/i6XEDnYcmDmn0EMjtCT6VvUQeZRliwPc+DMJvIB+Fv+bjvB?=
 =?us-ascii?Q?lUBQKjDTiP2fDPRGdKrjNikVId0GBxT5xTxIb7CQenFHM3c1DOL2TeYN3+Hh?=
 =?us-ascii?Q?WiSo+r27olEZiANOygdNTT8wgF6vLVaxygTJwJCA9RhKvownrCLFUhbEf7vf?=
 =?us-ascii?Q?6ua9CIyRk2yXGFB/524BkeRkJ4CHIi5WwTLSUervnjUouPgrDU/lV62qrA65?=
 =?us-ascii?Q?Tann8CHy93JufD0MpTeIDPLc+T3mAHjFzfPLFSp6rfX1EbDU5Bdq/83njno7?=
 =?us-ascii?Q?C4QBSEZzzsI3isBugPERP6N5eUW7itMBh1JdltztWp7TyICt0AyBqHIQr3Vi?=
 =?us-ascii?Q?rR0MoJlgHQzyzR2qis1+6S8ER3GZL+k5uUhgW7U9GF6g3h2sYOlfR7cSViDp?=
 =?us-ascii?Q?lZYSBWugTphe2fWAOEkrNYjVSN/5ayA7YVJ7xRgnt6IvwKCnCfEh3EylvKOH?=
 =?us-ascii?Q?ZgFX5XlK27OPGmaiGn24jENgwyEl7JFhXfkYJaBCHiHpmLx95nxCVA4OLyI/?=
 =?us-ascii?Q?jnZ5ZUOPYbJb1EKPzguup6zhfAMjRYCasiaKxM/XNqiX9kW9M8ENIyzM6R+f?=
 =?us-ascii?Q?yDPDAHPMR242uoS2LNflrolrAHHdSvoGazDqG6H869WWOmI8G7VggP0EWgOe?=
 =?us-ascii?Q?okMxNv8dSxxLlgJKRETtKlaLfwMR7PGDmM0oxvsYWqT/FEP5hACecz8eRACx?=
 =?us-ascii?Q?Alk/auv4lsBsRFa/DG3DurzFqJjCT38j7gXYUYCVuWuC58UNWVNojdTMr9uE?=
 =?us-ascii?Q?YZKIPn5Foq7K31N2CRdcm794Q36HlKrpgsvBJfwakHbHz20tJLwA3/QyL05k?=
 =?us-ascii?Q?XcASN7ynkTZqDQhkil0HMRgzyIyutiQ3pxQzDxJIqKdUNHP0KHbC4LKzCDVr?=
 =?us-ascii?Q?sb7kFuvkzHjIr4XuIc54sOWFP5UwVBjMO5d5bklxoJWqdJgCJW0dTVRn06qn?=
 =?us-ascii?Q?U17OBs0Xr7KqTGc/1apI6VZSQ0qiL74Ckd7w5NISZ+LbzBfD0x6LQ+P1mCau?=
 =?us-ascii?Q?z9m5PJpqrS0vkuIerqPGQIqVhCNTjoP2x8jo82HIi9ahupOPTke7sxE8NMoZ?=
 =?us-ascii?Q?zN1BogPvAR0daZQS4PJ7HTZHTa4zp5e0LlryuQhGn2SfLbURrmTWXEZ1mF0l?=
 =?us-ascii?Q?Uw6uIgWK4Q0ZqN4xXN5sHiBUIVGqf8+mUlF7mXZOSsX382Gh1T4zhGj/+uj7?=
 =?us-ascii?Q?VcgfJ+9OuAHLF7Y5Hm4+lGqTb0nzD/b/VFY8HkpMo9XjJpKBo19UJHPO+zmk?=
 =?us-ascii?Q?wQxR80KOaFh0diCFazOmX3EwI64rkh+Cl+asHGCx6Qul/d+rfjbST9dFHVwt?=
 =?us-ascii?Q?21wGcXPtBNkv6CmdUciExaaKoGX2u9ue9OVvj1BiC9se5+hUEmKEEVXYtcUX?=
 =?us-ascii?Q?bjKhKYpnOFbLFXNMpKoI1sIFx401v9fsq6fkrwjPpjl5ARZReeiVm91QEeD5?=
 =?us-ascii?Q?Mlyp/cDUxufqVU9TeQccn6m/pWRkFB1eQ+ydlN/njLBpxBguVLXBtWQGIEmj?=
 =?us-ascii?Q?SOTHs3KQFc3nIE1jrdUK84C297hjzJMsDQS9QrM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752b775d-9a42-44eb-5a5a-08d771bdff0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 15:41:53.6048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3N9dvpIrmTxsYlk2wQUVY574a0hC8IM1lmNTA9Tw0w9GGRcsY0uGT8rf6hCHF6k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3323
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ctq3DRbvkVhSXyTqXDqEYiwVywkTb5uKpFW9HOUE15E=;
 b=bn5659azsaHdtR10EkRaJoVCw3pVyTmrLoCnjXcQl4s6RSQP9Rb0Eo33sB5GSEWywf/Vtl15YL7Dz4tbK04cMGEFSyoaQg+PiBHa0L0AtnnNAv2sJQEydHCjI1mus+5sF7diwqxu+Vsqgp7NN6N/4ppBk5pTHpTS5yBEZK3gQpc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Content-Type: multipart/mixed; boundary="===============2127451733=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125154153.j-9aBzBf6dxWe6FAQjWRxKw_KcCAfwsgwzzidMWBQkA@z>

--===============2127451733==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB346695688D92D386098283019E4A0DM6PR12MB3466namp_"

--_000_DM6PR12MB346695688D92D386098283019E4A0DM6PR12MB3466namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Zhan Liu <zhan.liu@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Bhawanpr=
eet Lakha <Bhawanpreet.Lakha@amd.com>
Sent: Monday, November 25, 2019 10:40:24 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH] drm/amd/display: Null check aconnector in event_property_v=
alidate

[Why]
previously event_property_validate was only called after we enabled the dis=
play.
But after "Refactor HDCP to handle multiple displays per link" this functio=
n
can be called at any time. In certain cases we don't have a aconnector

[How]
Null check aconnector and exit early. This is ok because we only need to ch=
eck the
ENABLED->DESIRED transition if a connector exists.

Fixes :cc5dae9f6286 drm/amd/display: Refactor HDCP to handle multiple displ=
ays per link
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index f6864a51891a..ae329335dfcc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -225,6 +225,9 @@ static void event_property_validate(struct work_struct =
*work)
         struct mod_hdcp_display_query query;
         struct amdgpu_dm_connector *aconnector =3D hdcp_work->aconnector;

+       if (!aconnector)
+               return;
+
         mutex_lock(&hdcp_work->mutex);

         query.encryption_status =3D MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Czhan.liu=
%40amd.com%7C22996511e2124290c9fc08d771bdd059%7C3dd8961fe4884e608e11a82d994=
e183d%7C0%7C1%7C637102932411167739&amp;sdata=3DQ0Wlb9vuIRKJgLfiFmpLIJWWsQzm=
j9hFm3dOKBVxutw%3D&amp;reserved=3D0

--_000_DM6PR12MB346695688D92D386098283019E4A0DM6PR12MB3466namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div>
<div>
<div style=3D"direction: ltr;">Reviewed-by: Zhan Liu &lt;zhan.liu@amd.com&g=
t;</div>
</div>
<div><br>
</div>
<div class=3D"ms-outlook-ios-signature"></div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Bhawanpreet Lakha &lt;Bhawanp=
reet.Lakha@amd.com&gt;<br>
<b>Sent:</b> Monday, November 25, 2019 10:40:24 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Null check aconnector in event_pro=
perty_validate</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
previously event_property_validate was only called after we enabled the dis=
play.<br>
But after &quot;Refactor HDCP to handle multiple displays per link&quot; th=
is function<br>
can be called at any time. In certain cases we don't have a aconnector<br>
<br>
[How]<br>
Null check aconnector and exit early. This is ok because we only need to ch=
eck the<br>
ENABLED-&gt;DESIRED transition if a connector exists.<br>
<br>
Fixes :cc5dae9f6286 drm/amd/display: Refactor HDCP to handle multiple displ=
ays per link<br>
Signed-off-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 3 &#43;&#43;=
&#43;<br>
&nbsp;1 file changed, 3 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br>
index f6864a51891a..ae329335dfcc 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c<br=
>
@@ -225,6 &#43;225,9 @@ static void event_property_validate(struct work_str=
uct *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mod_hdcp_display_qu=
ery query;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_connector=
 *aconnector =3D hdcp_work-&gt;aconnector;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aconnector)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hdcp_work-=
&gt;mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; query.encryption_status =
=3D MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Czhan.liu%40amd.com%7C22996511e2124290c9fc08d771bdd059%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C1%7C637102932411167739&amp;amp;sdata=3DQ0Wlb9vuI=
RKJgLfiFmpLIJWWsQzmj9hFm3dOKBVxutw%3D&amp;amp;reserved=3D0">https://nam11.s=
afelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%=
2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Czhan.liu%40amd.com%=
7C22996511e2124290c9fc08d771bdd059%7C3dd8961fe4884e608e11a82d994e183d%7C0%7=
C1%7C637102932411167739&amp;amp;sdata=3DQ0Wlb9vuIRKJgLfiFmpLIJWWsQzmj9hFm3d=
OKBVxutw%3D&amp;amp;reserved=3D0</a></div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB346695688D92D386098283019E4A0DM6PR12MB3466namp_--

--===============2127451733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2127451733==--
