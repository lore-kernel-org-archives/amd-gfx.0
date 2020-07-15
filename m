Return-Path: <SRS0=Zv7j=A2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37386C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 06:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9EC020663
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 06:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q1AjnvPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EC020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 940A46E3F2;
	Wed, 15 Jul 2020 06:44:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65CD36E3F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 06:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKZ32xqfoihILXxcSwd2vVokaDKlK8MoB1yRiXQEwIaClK1RHT+ApOmt9yLujttbk8Uf1OYaAMldmPOyaMd7FTkSK7lWio2MFmB6cFJ6v8nNbfei3WCyuk78ZOwNV5aXKHVM6B2uB3ntaN10g6p3YC62QExwuDF4zBC8KNpoter+pbXLoyejNtK+J/0qpGkonNQIXPeOs6rgg4ISHpimiRFSIj1zSB7jHwHfhswdfDF0UwuAFAiCXQLcIN8kdu/y09w2194Lpz5mDVkKvg5yyN4oxUtsIhgCarpB3VMIq4VOF9kmZapi+H4B2KQ1qZto9XC5LSBz3DgUYT55ZU1nyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHfsNHr3xR1CDuMEGuO54mf7Aw02MXLyXIhNNBmCemk=;
 b=AYkmjWAghs8eqeckeprIku35UJCRwntUXh5Gs4s9+Ta3/LAyYfw4cQv5mWEbtUnFw/yOoTauGe8ScqEmSw90rpZbBXVUEk8TefYnrwF4PszDSBdRhRgnZlXT1qLdZv/9+RbEYMPRHBiTRQaHRpuGf3k0Mgvff8ye8A2gIkArPQetoZINU1Gii63hAHl6nJr+EasM5Gx9vmNbwuv+JbfthsYbB6Z6YBjRQv5El9jje931tRpXXXa5w+eKiMzdOPcmyNtHKe03EIu+fohZaQwoFWnKL5y9tDfCk+A741XXSOyIP60BZsCn/iCgqak1h+G1fqoWEO8miu8eiOwG1sVn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHfsNHr3xR1CDuMEGuO54mf7Aw02MXLyXIhNNBmCemk=;
 b=Q1AjnvPzDunHGhbPYDrIkIXS7dPnLOVEW53EWUrk8vNfLUZ5iVzsxazn+Uh7VYQhU2hhb/V0saPJ0zoqdCCBracBD5P0qfs3WoGSr7jTkIAJnUJTUfQjGb5d6JSEbQcfRhHNye9vXfPL0AQkfmlWjefEQ/9/QTrSCkopNq1iFC0=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by BL0PR12MB2530.namprd12.prod.outlook.com (2603:10b6:207:43::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.24; Wed, 15 Jul
 2020 06:44:04 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235%7]) with mapi id 15.20.3174.025; Wed, 15 Jul 2020
 06:44:04 +0000
From: "Clements, John" <John.Clements@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chen, 
 Guchun" <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: resolve bug in ta microcode init
Thread-Topic: [PATCH] drm/amdgpu: resolve bug in ta microcode init
Thread-Index: AdZacxLt6n7WOYuDTHSPsvqdIgusVQ==
Date: Wed, 15 Jul 2020 06:44:04 +0000
Message-ID: <MN2PR12MB4032BE9B97E446082D680CB0FB7E0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-15T06:43:57Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=612aa6c4-0541-482a-be8b-000085f37a68;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-15T06:43:47Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: bab80f20-d18a-4e5b-b43d-000017537c83
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-15T06:44:01Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 31c4ded3-6caa-42c4-8126-00009b450901
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0a34d7f-c0f2-45fe-24db-08d8288a7775
x-ms-traffictypediagnostic: BL0PR12MB2530:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2530478F3B4E2C896DB8F92FFB7E0@BL0PR12MB2530.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bqK4/8VyEW0mWfWVP4brrL+pQMf1QOvkKRPzCl98WyyXWb8NXGPQFZVt3wGxcQHI1xeUszRi+ZcmTR3WUQ+Ldq+0cERfsWIDC05/zdRBStsChjWZvSBApRtDRiRWMXhfyjO9WxdDAFOcm3ybHNj2rAa2Ma//kQW8jYl8njlX4hMc2a/80FJ7ZXum77DSSebVPTwRcQvVpf+QmCSYAbOEDx3BrIssf3TfPQuKcLVeeqwojPiaWLPhNJkxo0oAsJvUrPjArC+gscE1Hxv9zRMjnrj0uE6QPTMhGda67w267U3466/a6cjIwyHJ/iBDvxVq/tDQOu6t6sqe1eEZEkIZsA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(33656002)(316002)(9686003)(66556008)(66476007)(66446008)(6506007)(2906002)(8676002)(5660300002)(66946007)(66616009)(55016002)(64756008)(52536014)(99936003)(478600001)(6636002)(8936002)(7696005)(186003)(110136005)(76116006)(26005)(86362001)(71200400001)(558084003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: K+8Wpg7CaevO7r+EgOSV4itu5Oty4t0MWaQN2IIq3YoefajUhaF/ZQFHZjCe0si16Hd2jiOVxREv1yKrNa0/QSxN3bQ7rGnmtK17PCHtD4/XssNrlEUly8ObaSl4GTvVrQz0nnR1zx0xcltDLOH0zLxCLgoXcDNRoFfEgZQRljss+xpsBMRRJ0ELu9ITB+G9te5nuEVGUy93C7GC4lMUNFYvqVr4sLZbg6Qfuqr7tXqlAakWSgRD8CdhkOLhJ/NsDkkVLVPsEbdONehV5EqqmNZ4wkxtF2LXJwoyIysWpDcArnAdjRD99EtBvxyKscBHX7a/lkhsCyIeu516C/2qc9BOZwkfgb7kc6FJsuWAf4cxkz3etTrl7qvAdrzY+ttc0ltc8Xsm5Diuiaes1xMQ0V+C05eGHbKbPig5PWKgL4msYJrjfxd7VmWJxSxCk2E0+5KixB56Qs0nneHqjojcgJDFnh73OtbwbqjRcdPEat9CYMe1FSy9iwpZooV+edKA
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB4032BE9B97E446082D680CB0FB7E0MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a34d7f-c0f2-45fe-24db-08d8288a7775
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 06:44:04.5899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /KpL+ixSLWw7PY06UZX4m49rqL984W3rNzr4DQ+PxtHnOWWkT9ic2lC1UG1fgD84q3j4vpIdqB24m/G5aHj2IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2530
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_004_MN2PR12MB4032BE9B97E446082D680CB0FB7E0MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4032BE9B97E446082D680CB0FB7E0MN2PR12MB4032namp_"

--_000_MN2PR12MB4032BE9B97E446082D680CB0FB7E0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Submitting patch for review to resolve bug when calculating FW offset withi=
n binaries with PSP TA v2 header.

Thank you,
John Clements

--_000_MN2PR12MB4032BE9B97E446082D680CB0FB7E0MN2PR12MB4032namp_
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
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch for review to resolve bug when calc=
ulating FW offset within binaries with PSP TA v2 header.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4032BE9B97E446082D680CB0FB7E0MN2PR12MB4032namp_--

--_004_MN2PR12MB4032BE9B97E446082D680CB0FB7E0MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-resolve-bug-in-ta-microcode-init.patch"
Content-Description: 0001-drm-amdgpu-resolve-bug-in-ta-microcode-init.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-resolve-bug-in-ta-microcode-init.patch"; size=1119;
	creation-date="Wed, 15 Jul 2020 06:42:00 GMT";
	modification-date="Wed, 15 Jul 2020 06:42:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhNzZhMzFiMmI3YjNkNmUxZjEyZDIxN2Y1NzRmOWM2YWFjMTA3MjRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFdlZCwgMTUgSnVsIDIwMjAgMTQ6Mzk6MTYgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiByZXNvbHZlIGJ1ZyBpbiB0YSBtaWNyb2NvZGUgaW5pdAoKY2FsY3VsYXRlIGNv
cnJlY3QgZncgc3RhcnQgYWRkcmVzcyB3aXRoaW4gYmluYXJ5CgpTaWduZWQtb2ZmLWJ5OiBKb2hu
IENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+CkNoYW5nZS1JZDogSTdmMTBiOTc4OWZh
MTcyNDM1YzJjOGY4MDZkMTI5NDQyMTdhOGUyYTQKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcHNwLmMgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMK
aW5kZXggNDA3MDYzMzRmN2E4Li42ZTQxZDg5NmU2MmUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcHNwLmMKQEAgLTIyODYsNyArMjI4Niw5IEBAIGludCBwYXJzZV90YV9iaW5f
ZGVzY3JpcHRvcihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKIAlpZiAoIXBzcCB8fCAhZGVzYyB8
fCAhdGFfaGRyKQogCQlyZXR1cm4gLUVJTlZBTDsKIAotCXVjb2RlX3N0YXJ0X2FkZHIgID0gKHVp
bnQ4X3QgKil0YV9oZHIgKyBsZTMyX3RvX2NwdShkZXNjLT5vZmZzZXRfYnl0ZXMpOworCXVjb2Rl
X3N0YXJ0X2FkZHIgID0gKHVpbnQ4X3QgKil0YV9oZHIgKworCQkJICAgIGxlMzJfdG9fY3B1KGRl
c2MtPm9mZnNldF9ieXRlcykgKworCQkJICAgIGxlMzJfdG9fY3B1KHRhX2hkci0+aGVhZGVyLnVj
b2RlX2FycmF5X29mZnNldF9ieXRlcyk7CiAKIAlzd2l0Y2ggKGRlc2MtPmZ3X3R5cGUpIHsKIAlj
YXNlIFRBX0ZXX1RZUEVfUFNQX0FTRDoKLS0gCjIuMTcuMQoK

--_004_MN2PR12MB4032BE9B97E446082D680CB0FB7E0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB4032BE9B97E446082D680CB0FB7E0MN2PR12MB4032namp_--
