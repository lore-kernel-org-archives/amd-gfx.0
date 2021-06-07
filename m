Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F612C4743E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 03:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C40610FC
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 03:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C40610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC306E08E;
	Mon,  7 Jun 2021 03:12:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A0C96E08E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 03:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DILqpXAGR8E658NcB6Psc1wwgvee/WdaoU9xLfxA7nB2CzNLsOrfLzI7L7MVm5CYuGUFtii4WJJyqbhbz8ESKP3ZAf/66NNpiNxZMq00G/q7kO8Em7iMhx5NWahOcIxWS5AsjNXX9g9DltBgFmTavbfRrUJMiZt3N0C9MNsCbLgSimFb99RESe1WESBKRCiacekpCFUXnkEHdDvda2hBuLrd4FG8g1ocIYNwsXiOoU7ejTTWcy0X6Wmc1THwWJQ4K/KXlvy/TkY60pp1+yFjAz3ea7A6x+bmDt8OxsH2xpGNLKHOWSeJqoU0rCKctLF7uP/iIhIESfNHVaankkbFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zmd0UZjzPE+qiQvK/MFW8dD92yeFVSUTza06kuwsbI=;
 b=MyOJzBO26x6KYP6eMGJLxa0uDu0mRN7mzyt7mPNz2RPpHzL9BamworfevYlhlII2U7+OC4kcZsjIOvS6Bko/TB/xET+VWwMvcjr7jvcESnybhPMv8WE3jamEZZg3d5FBUYWhM9jWBi9fwMI5m4eCrF5btzxCIoeREZ8fHrJBuzexZdp8HBDanwiqAQSHs82XXFmSdVFuz4l8ueL+cUZMMeaQ1qjjTPgFwtV3umnSCHTrgjaErMgjPyWS0vVWIPUtfd5ybcXf3lOjx1N55pEFSCnQfq3afnsdfK1cxhpE5sjl7Aau7B5e0sEo8KUxwRn0hdIMgrK26IuJ5pAX3lQ9tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zmd0UZjzPE+qiQvK/MFW8dD92yeFVSUTza06kuwsbI=;
 b=c2vzylkmpwESU6byx7V+9dcpigR/5idpwqM++YxHnMixyokIgPa4urSwXwKpxDbH+FJzig1dGfusGnjkeiL00/XmGBJPHLpbFsKb5UEZyyR0Cm90JJ0iJ9KmMvm+BvN+pHpVbH0/JNLlQFud4TS9AtZxVIF2gNC5JCVBzW8tNGQ=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5382.namprd12.prod.outlook.com (2603:10b6:408:103::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 03:12:45 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::9cbb:588f:a9cd:e79]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::9cbb:588f:a9cd:e79%5]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 03:12:45 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Update psp fw attestation support list
Thread-Topic: [PATCH] drm/amdgpu: Update psp fw attestation support list
Thread-Index: AddbStf9BnLmUUpcSRKXKLQG8fAUEg==
Date: Mon, 7 Jun 2021 03:12:45 +0000
Message-ID: <BN9PR12MB5226F943C24139A71502430FFB389@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-06-07T03:12:37Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=df1aa59b-160f-48b4-9bcf-cc154c83c10d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4951aed-2038-4a43-b34c-08d929621f4f
x-ms-traffictypediagnostic: BN9PR12MB5382:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5382187AE2A41D4FDC7EE42EFB389@BN9PR12MB5382.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vualKhiR9JzTzAfwMC55mhq/zwVna12NKmELFES8YbBGqkltwLj4b/BJH7P/IAPFpCrKnX3ic7p+n9cnqgeuZ1/PTw4tREo5GK7MA0W6+jhO0OCegWQKMwUPkiOZkbus0VsBNtEdMECVsNbR24K2Oku3bYBtiskJg+LO/uxxzdaVqSvz6X8mF5tY7Y/4KI9itQ3FGdDIwVpd4qIS+p3KNoJ+Mrb8qZJljw/bfN+oQb0z5YvXI0Xgcmw1EErSXLYbPbIJtXkyIycCk8BaWhzwQdpqiKCxbHXbm+7wdegnuHGzuz45ohzV0Gd6TF/Y72wQhaZwDsRn4l6RXN50igRiVFt3CusGkew6momfpvTz5x+1KK/tijIFFpooaRnotOTFElMn4RGg5xjVf6rJpJGjWqCcJAukQnQsYpR+tlk6MxBdyvc2+0lrCs3xo/U+CuVr0z2Dv4pJLjZt4Tf+KNSlJFosR1Rh+brxbOW4Q5J+79ySH0buvCGlqjgO1HD7Vzw00xk8CIkyXNrIzkXhqKy0UlidSlZG09hbo14BJD+66YPAk347UagHYcw9kLoV+uDt4m6STu5YtpE65AFa1+aGT0Vhj85CpDhFbeeWGFiKpM8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(76116006)(5660300002)(6506007)(66556008)(64756008)(478600001)(66476007)(8936002)(8676002)(66946007)(66446008)(99936003)(33656002)(55016002)(4326008)(9686003)(7696005)(26005)(6916009)(558084003)(86362001)(38100700002)(2906002)(52536014)(122000001)(316002)(186003)(66616009)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GcX+a3L9g7wUp1nBba1Dj/utlcMlA4BMTG8XLsj8yBcyUlYRr7mqVghnqPjU?=
 =?us-ascii?Q?i0W4ckBokNDdoAJGsz8Wxo0Pg9UZ9rqeHkz/kDaI3VSLCueiR2ylp5k++e1f?=
 =?us-ascii?Q?+CcdBKgV2+wALe3fnVHQ9wPgBov9JKjRqq8oUOtjqILkqdQaGzX6vsuNyMqL?=
 =?us-ascii?Q?ErKEe9TgNDc9c9R8AhLj6nop2mccSavkQAatZWLr+W1EjBo94bu1qE1491Mb?=
 =?us-ascii?Q?6nJS3nB18RecbYeLoAtOguW3Edi6EIKqyGTyr9DFDJ9D2WsH07nUnHr3fNhH?=
 =?us-ascii?Q?BgS83+lb8yVKbFL2LYahTvI510W8xC2CiGCXTY7FPgrMmvLLJ2GTz13SKyF/?=
 =?us-ascii?Q?Fxo5/7EamSoiiX51Oax/u+RX2M2OTXtGjsaft+AqYYETz7N+2lk8h9n0nlw9?=
 =?us-ascii?Q?oSSFu0cPAsQF/t/o0QjqTDY2yaxLzwKZykHnO0yUiziJ7BPJKXLuZIWVwHiE?=
 =?us-ascii?Q?0PIUM9KfS+jcwET1mn/RvA4tFqEnLoebib1XyBYSdHPWKtXYX506DZ4zP80A?=
 =?us-ascii?Q?s9i33dtK596OKWJhdKl7TGNhiPSFJbjijFEb3yxBAFKBsEIw94LRStxahaMB?=
 =?us-ascii?Q?q1SXkK/HE9e3QeQmucYjtDsRt9FLHpye8wZKisMa5o9Q5kCWe5yq1Bv/3L6G?=
 =?us-ascii?Q?bfY8t7aYxZzelAyFE0pH3LUcjgqs9ZEvdj2+RM5M09TeS4m2Z0eaQzzzEPPL?=
 =?us-ascii?Q?p7+ZE+0HZaGaeUfSQXuqxlohcpaDF9DNqPw3oufq1axDw3ApPEI87aZ/8q8P?=
 =?us-ascii?Q?vFkk/aKHvv1aKE8lT1tpeVCwrBoYgV9fMc7roRcU7IKAABlQgAblACyGjOSf?=
 =?us-ascii?Q?N/FQgv4Mc5tacc017NNSb1SokWojQwmBHXe3hJkJgL8ISLpaWkCJFtuJzwei?=
 =?us-ascii?Q?PjDGpOe+QT2u/Z00Kpa7SkSPCfXigy0oWMXaMGKXA4qUdvLQnTWcLsEuP/nd?=
 =?us-ascii?Q?fCiEiUWoJ4uTwnbyOTSF5+R/JC4qL3H9PmmEpkKFciKB0wx5ELJft+oGnaUZ?=
 =?us-ascii?Q?BCs41Hi7CZtHNAPkvO1skJb7Jhbay7y6bFUCYkh9wLhpvMhvjbOsOV/2LVNb?=
 =?us-ascii?Q?mVK6/BuekdsLct1JWM2QMPOTD28fNlihYolAEXQWtmCcRkTY3dBByFqA6KNc?=
 =?us-ascii?Q?FRfQFlwF2U8sDg0JWf2+RFAcYZWkMkVQsUuJjD+QtOXOIqu3Q91A+JPIVagf?=
 =?us-ascii?Q?BB+QXUiWoFFkq1EyECJKAXlBxCDIwff4Jf8MmeeqlwBK2VVPsKOeAn+3Sa4b?=
 =?us-ascii?Q?vHYCWSzxuYjaueqNiv1lgmBZza5r3//GGj/3QFELbhEfVrpkupMOMigPgYov?=
 =?us-ascii?Q?tt+5z+qqz2is2dFTZXVx6Kss?=
Content-Type: multipart/mixed;
 boundary="_004_BN9PR12MB5226F943C24139A71502430FFB389BN9PR12MB5226namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4951aed-2038-4a43-b34c-08d929621f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 03:12:45.6565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NyWt423iHj61ar7cb1QIOe6qLgJUHcx0FFVOs9E6RbHoP0xo+U+abuaeaAuhdvAdzzn0H+gl0EF8OvOIXwFoiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5382
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
Cc: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_004_BN9PR12MB5226F943C24139A71502430FFB389BN9PR12MB5226namp_
Content-Type: multipart/alternative;
	boundary="_000_BN9PR12MB5226F943C24139A71502430FFB389BN9PR12MB5226namp_"

--_000_BN9PR12MB5226F943C24139A71502430FFB389BN9PR12MB5226namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to disable PSP FW attestation support on APU

Thank you,
John Clements

--_000_BN9PR12MB5226F943C24139A71502430FFB389BN9PR12MB5226namp_
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheadera92f4c5c" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:11.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to disable PSP FW attestation suppo=
rt on APU<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_BN9PR12MB5226F943C24139A71502430FFB389BN9PR12MB5226namp_--

--_004_BN9PR12MB5226F943C24139A71502430FFB389BN9PR12MB5226namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-Update-psp-fw-attestation-support-list.patch"
Content-Description:  0001-drm-amdgpu-Update-psp-fw-attestation-support-list.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Update-psp-fw-attestation-support-list.patch";
	size=965; creation-date="Mon, 07 Jun 2021 03:11:00 GMT";
	modification-date="Mon, 07 Jun 2021 03:11:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5ZmZkYjFlMjM4MzQ5YjQyMjE1MWIyNmU5Y2MwNmM4YjgyNGY4MDEwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IE1vbiwgNyBKdW4gMjAyMSAxMTowOToxOCArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMS8x
XSBkcm0vYW1kZ3B1OiBVcGRhdGUgcHNwIGZ3IGF0dGVzdGF0aW9uIHN1cHBvcnQgbGlzdAoKRGlz
YWJsZSBzdXBwb3J0IG9uIEFQVQoKQ2hhbmdlLUlkOiBJZGViNjE1N2M0MzU5NmVlYTY2MDczMDRm
ZGY3ZDM1NmYwNzY3YzI2NwotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9m
d19hdHRlc3RhdGlvbi5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZndfYXR0ZXN0
YXRpb24uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9md19hdHRlc3RhdGlv
bi5jCmluZGV4IDhkMWFkMjk0Y2IwMi4uMmNhM2MzMjlkZTZkIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZndfYXR0ZXN0YXRpb24uYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZndfYXR0ZXN0YXRpb24uYwpAQCAtMTIxLDYgKzEy
MSw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIGFtZGdwdV9md19hdHRl
c3RhdGlvbl9kZWJ1Z2ZzX29wcyA9IHsKIAogc3RhdGljIGludCBhbWRncHVfaXNfZndfYXR0ZXN0
YXRpb25fc3VwcG9ydGVkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogeworCWlmIChhZGV2
LT5mbGFncyAmIEFNRF9JU19BUFUpCisJCXJldHVybiAwOworCiAJaWYgKGFkZXYtPmFzaWNfdHlw
ZSA+PSBDSElQX1NJRU5OQV9DSUNITElEKQogCQlyZXR1cm4gMTsKIAotLSAKMi4xNy4xCgo=

--_004_BN9PR12MB5226F943C24139A71502430FFB389BN9PR12MB5226namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_BN9PR12MB5226F943C24139A71502430FFB389BN9PR12MB5226namp_--
