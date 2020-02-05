Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC36C35254
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 14:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7C021741
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 14:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j4xEctXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7C021741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD6616F5F0;
	Wed,  5 Feb 2020 14:59:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 738776F5F0
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 14:59:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S48KZP4n8COBj81WPEKXxFTNgvIgqIPRtT43MpAnie+uChW1HJ8nIHPUKQOycv5Xaytk4/eHjTEDeY5Z7R4Nazreh3oHtmJq6cu9Ryvg5D3NaAx66/Gz5VQAsHzoL3VTwtoGWQNRTdvNdKJTLQtfBIsR80nhe6TkOfL3XjbhBNleLM38qSNddGlt5DDJoLAIgIfS0slxBOnbAp9AkiQvglo9tSoTyoF/U9CDgl2GRqDJ54KyA6DajmRW766lmPiNVgFNs7sTcKKCPBf/0tTgTy/WOdcsR944dT/QKbVLG4UX8ze/7WVBNq6rkCxT//uJ33wxotiiATye2VUy30KCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgkSfiSrXNM8X/cVPnYIrwkPvORsztgNO6uy+Ft9mEg=;
 b=KoNOqV3gC7A3IfCwV3LASMGqKldM6HmEhXVANK4mS6OHlLyCnz945Oh5c5/wbv6jKDWvq9i9KhunYM+sQwGguW4i+pmYsES8CSvpr/No5LrEqBqQFB8ZLMQXgWoDLiusveNpk++raFFrWMNwRXq/kXrrlvUSNWfDSrDAnUZFi646xc2pKx9ntJqForV+7GxCZgWD+/HxyFgtTPBmuBFTy8QsruteIPb3mrfs1ArK8+0lAMktfjARR3vQvrjX/Y7jSRQRI/KRITU9V12urgTJ3q+lhXDl80ZDIXQfyGzY5b9aUvPjDfS+Sj3csnmK2bcmZkY9TLMEe++APoJ1PMn6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgkSfiSrXNM8X/cVPnYIrwkPvORsztgNO6uy+Ft9mEg=;
 b=j4xEctXP/U0euCSvshqCTeN1l0IuVslwVthMV727CIucwvXkwk4HziYjoEW5D7YJUSM6kleohv83ZrRd/9d7N3VUJ0yeNqrpNMx4jWMq7FrFHkU06TXDs/8lkGdUBqnrVg9C5SgGhT+ydd46C1YCrWXBwKExQVu4kV8zbOcgrLw=
Received: from DM6PR12MB3372.namprd12.prod.outlook.com (20.178.30.203) by
 DM6PR12MB4283.namprd12.prod.outlook.com (10.141.184.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 5 Feb 2020 14:58:59 +0000
Received: from DM6PR12MB3372.namprd12.prod.outlook.com
 ([fe80::dd81:9c2:53dd:9f3f]) by DM6PR12MB3372.namprd12.prod.outlook.com
 ([fe80::dd81:9c2:53dd:9f3f%6]) with mapi id 15.20.2686.034; Wed, 5 Feb 2020
 14:58:58 +0000
From: "Tawfik, Aly" <Aly.Tawfik@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu,
 Michael" <Michael.Chiu@amd.com>
Subject: [Dali] Raven 2 detection Patch 
Thread-Topic: [Dali] Raven 2 detection Patch 
Thread-Index: AdXcNMo4A9jV9vPHRUCOiC3R46hBTQ==
Date: Wed, 5 Feb 2020 14:58:58 +0000
Message-ID: <DM6PR12MB33724602207E1D3B7839A4EF81020@DM6PR12MB3372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1f6a68e7-77ee-4cbe-a8da-0000ccac7317;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-05T14:53:26Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Aly.Tawfik@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 97702908-462a-45eb-ddaa-08d7aa4bee05
x-ms-traffictypediagnostic: DM6PR12MB4283:|DM6PR12MB4283:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4283BF0C8491F0BE087CC1C981020@DM6PR12MB4283.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(189003)(199004)(4744005)(52536014)(6506007)(86362001)(478600001)(9686003)(186003)(7696005)(55016002)(2906002)(316002)(71200400001)(9326002)(66476007)(8676002)(66946007)(81156014)(5660300002)(64756008)(81166006)(66556008)(26005)(66616009)(76116006)(4743002)(66446008)(6636002)(8936002)(110136005)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4283;
 H:DM6PR12MB3372.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k7IBmnxXoeRwrE2LBhHUkiyBTJIFvcLz8YRgAc3i8s+ruNmtgk6U4oBg8JrzLtjHpp9GjJcC8AvwJ6a91kgTFO87YqlLZHETaWTqj10w1P9Rj1UADT914n/ya8rbL5qqTs9ElzdS6OWIP54J+Dlt2Pe8ryz/+5TnH1llOcJ6I4gkCliVdzDyTXL/XRh5VfKMkg/QBpEzXVd6f5jitGk2pRjoeG5knl4JkGU8YvIQyEO6OjR+sj8a9bVNuatAXHfJy0KHwFVekXEBHUaaMcjGDpM2CqopvhaV5xYTwMd14HX9/fAi7ESunu+ewNtruIPzQtxtMTPPcTm8put+PVOlWVwN5L78sIp0n+O2SILHGabjvx2dasp1XgAA1AkB4z96hLUuJDQYQSDFZCW1h/6PTa9cumIXHw71exUpB3HRPUtSWcskGvunKAB6MQM5YMWi
x-ms-exchange-antispam-messagedata: BLtMZYzu4PYcub30avhi8VTeGuO3hGAXUgAfykHC68SJq826TTsCUs1s2pPM22DTf2x3ZSfgGkQTGKgVl7SJ1x4gdd8ehq+I2qoL9225SsfNf3FXIHW+tlzWPuJaCUd/rXJnGlcjuaXjfl4CHUImZQ==
Content-Type: multipart/mixed;
 boundary="_004_DM6PR12MB33724602207E1D3B7839A4EF81020DM6PR12MB3372namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97702908-462a-45eb-ddaa-08d7aa4bee05
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 14:58:58.7176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pkTbLDAl2LDAUlJ4jtwrCOFsJKyEz3oiYsI1vFMbNDPnXGo/+gynjxvhihrUnVL2sZ9dI23gB03AolE5aFy4DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
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

--_004_DM6PR12MB33724602207E1D3B7839A4EF81020DM6PR12MB3372namp_
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB33724602207E1D3B7839A4EF81020DM6PR12MB3372namp_"

--_000_DM6PR12MB33724602207E1D3B7839A4EF81020DM6PR12MB3372namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,



Dali is a raven2 based asic that drives at a lower (6W) TDP than other rave=
n 2 chips. Currently the fused internal id is the same on all raven 2 board=
s, this means that the detection process must be done through PCIE REV ID.

Unfortunately PCIE REV ID is not defined inside the scope of display. I cre=
ated a patch to alter the fused value for internal rev_id if the chip is de=
tected as dali through PCIE REV ID. So that detection of the chip will be p=
ossible inside of Display core.



Can you kindly provide feedback on this workaround.



Best Regards,

Aly Tawfik


--_000_DM6PR12MB33724602207E1D3B7839A4EF81020DM6PR12MB3372namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
p.xxxxxxxmsonormal, li.xxxxxxxmsonormal, div.xxxxxxxmsonormal
	{mso-style-name:x_xxxxxxmsonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
<div class=3D"WordSection1">
<p class=3D"xxxxxxxmsonormal">Hi,<o:p></o:p></p>
<p class=3D"xxxxxxxmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xxxxxxxmsonormal">Dali is a raven2 based asic that drives at a =
lower (6W) TDP than other raven 2 chips. Currently the fused internal id is=
 the same on all raven 2 boards, this means that the detection process must=
 be done through PCIE REV ID.
<o:p></o:p></p>
<p class=3D"xxxxxxxmsonormal">Unfortunately PCIE REV ID is not defined insi=
de the scope of display. I created a patch to alter the fused value for int=
ernal rev_id if the chip is detected as dali through PCIE REV ID. So that d=
etection of the chip will be possible
 inside of Display core. <o:p></o:p></p>
<p class=3D"xxxxxxxmsonormal"><o:p>&nbsp;</o:p></p>
<p class=3D"xxxxxxxmsonormal">Can you kindly provide feedback on this worka=
round.<o:p></o:p></p>
<p class=3D"xxxxxxxmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xxxxxxxmsonormal">Best Regards,<o:p></o:p></p>
<p class=3D"xxxxxxxmsonormal">Aly Tawfik<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB33724602207E1D3B7839A4EF81020DM6PR12MB3372namp_--

--_004_DM6PR12MB33724602207E1D3B7839A4EF81020DM6PR12MB3372namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-DALI-Dali-Varient-Detection.patch"
Content-Description: 0001-drm-amdgpu-DALI-Dali-Varient-Detection.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-DALI-Dali-Varient-Detection.patch"; size=2748;
	creation-date="Wed, 05 Feb 2020 14:55:16 GMT";
	modification-date="Wed, 05 Feb 2020 14:55:16 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2ODQ5ZTdhMzQ1MzQ1YjkwZTNiZTU4NjI0OGM0YjgyNTgxMDEwNDk4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGktVGF3ZmlrIDxhbHRhd2Zpa0BhbWQuY29tPgpEYXRlOiBN
b24sIDMgRmViIDIwMjAgMTE6MTE6MDIgLTA1MDAKU3ViamVjdDogW1BBVENIXSBkcm1cYW1kZ3B1
OiBbREFMSV0gRGFsaSBWYXJpZW50IERldGVjdGlvbgoKUHJvYmxlbSBEZXNjcmlwdGlvbjoKCkN1
cnJlbnRseSB3ZSBhcmUgY2hlY2tpbmcgaW50ZXJuYWwgZnVzZWQgcmV2IGlkIHdpdGggcGNpIHJl
diBpZC4gSG93ZXZlciwgZnVzZWQgaW50ZXJuYWwgcmV2IGlkIGlzIHRoZSBzYW1lIG9uIGFsbCBy
YXZlbjIgcGFydHMgKGluIHdoaWNoIERhbGkgd2FzIGJhc2VkIG9uIHRvbyksIHRodXMgRGFsaSBk
ZXRlY3Rpb24gZmFpbHMKCkZpeDoKClRvIGRldGVjdCB0aGlzIGNoaXAgd2UgbmVlZCB0byB1c2Ug
cGNpIHJldiBpZCBidXQgaXQgaXMgbm90IGRlZmluZWQgaW4gdGhlCnNjb3BlIG9mIERDLiBUbyB3
b3JrYXJvdW5kIHRoaXMgaXNzdWUgYWx0ZXIgdGhlIGZ1c2VkCnJldiBpZCB1c2luZyBwY2llIGlk
IGZvciBhbGwgZGFsaSBjaGlwcyBiZWZvcmUgREMgaW5pdCwKdGhlbiB1c2UgdGhlIGludGVybmFs
IGZ1c2VkIGlkIGZvciBjaGlwIGRldGVjdGlvbiBpbiBEQy4KClNpZ25lZC1vZmYtYnk6IEFsaS1U
YXdmaWsgPGFsdGF3ZmlrQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
c29jMTUuYyAgICAgICAgICAgICAgICB8IDkgKysrKysrKystCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvaW5jbHVkZS9kYWxfYXNpY19pZC5oIHwgNCArKy0tCiAyIGZpbGVzIGNoYW5nZWQs
IDEwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nv
YzE1LmMKaW5kZXggMzE3ODAzZjZhNTYxLi5mODVjMjdmYmU2NGMgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc29jMTUuYwpAQCAtMTA5NCw4ICsxMDk0LDE1IEBAIHN0YXRpYyBpbnQgc29jMTVfY29t
bW9uX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQogCQlicmVhazsKIAljYXNlIENISVBfUkFWRU46
CiAJCWFkZXYtPmFzaWNfZnVuY3MgPSAmc29jMTVfYXNpY19mdW5jczsKLQkJaWYgKGFkZXYtPnJl
dl9pZCA+PSAweDgpCisJCWlmIChhZGV2LT5yZXZfaWQgPj0gMHg4KSB7CisJCQlpZiAoKGFkZXYt
PnBkZXYtPmRldmljZSA9PSAweDE1ZDgpICYmCisJCQkJICgoYWRldi0+cGRldi0+cmV2aXNpb24g
PT0gMHhDRikgfHwKKwkJCQkgKGFkZXYtPnBkZXYtPnJldmlzaW9uID09IDB4RTMpfHwKKwkJCQkg
KGFkZXYtPnBkZXYtPnJldmlzaW9uID09IDB4RTQpKSkgeworCQkJCWFkZXYtPnJldl9pZCA9IDB4
MTA7CisJCQl9CiAJCQlhZGV2LT5leHRlcm5hbF9yZXZfaWQgPSBhZGV2LT5yZXZfaWQgKyAweDc5
OworCQl9CiAJCWVsc2UgaWYgKGFkZXYtPnBkZXYtPmRldmljZSA9PSAweDE1ZDgpCiAJCQlhZGV2
LT5leHRlcm5hbF9yZXZfaWQgPSBhZGV2LT5yZXZfaWQgKyAweDQxOwogCQllbHNlIGlmIChhZGV2
LT5yZXZfaWQgPT0gMSkKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9p
bmNsdWRlL2RhbF9hc2ljX2lkLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVk
ZS9kYWxfYXNpY19pZC5oCmluZGV4IGEyOTAzOTg1YjllOC4uMDMyOWYyNmJmYWNkIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9kYWxfYXNpY19pZC5oCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNsdWRlL2RhbF9hc2ljX2lkLmgKQEAg
LTE0Myw2ICsxNDMsNyBAQAogI2RlZmluZSBSQVZFTjJfMTVEOF9SRVZfRUIgMHhFQgogI2RlZmlu
ZSBSQVZFTjFfRjAgMHhGMAogI2RlZmluZSBSQVZFTl9VTktOT1dOIDB4RkYKKyNkZWZpbmUgUkFW
RU4yXzE1RDhfQjBfTFcgMHg4OQogI2lmbmRlZiBBU0lDUkVWX0lTX1JBVkVOCiAjZGVmaW5lIEFT
SUNSRVZfSVNfUkFWRU4oZUNoaXBSZXYpICgoZUNoaXBSZXYgPj0gUkFWRU5fQTApICYmIGVDaGlw
UmV2IDwgUkFWRU5fVU5LTk9XTikKICNlbmRpZgpAQCAtMTUyLDggKzE1Myw3IEBACiAjZGVmaW5l
IEFTSUNSRVZfSVNfUkFWRU4yKGVDaGlwUmV2KSAoKGVDaGlwUmV2ID49IFJBVkVOMl9BMCkgJiYg
KGVDaGlwUmV2IDwgUkFWRU4xX0YwKSkKICNlbmRpZgogI2RlZmluZSBBU0lDUkVWX0lTX1JWMV9G
MChlQ2hpcFJldikgKChlQ2hpcFJldiA+PSBSQVZFTjFfRjApICYmIChlQ2hpcFJldiA8IFJBVkVO
X1VOS05PV04pKQotI2RlZmluZSBBU0lDUkVWX0lTX0RBTEkoZUNoaXBSZXYpICgoZUNoaXBSZXYg
PT0gUkFWRU4yXzE1RDhfUkVWX0UzKSBcCi0JCXx8IChlQ2hpcFJldiA9PSBSQVZFTjJfMTVEOF9S
RVZfRTQpKQorI2RlZmluZSBBU0lDUkVWX0lTX0RBTEkoZUNoaXBSZXYpICgoZUNoaXBSZXYgPT0g
UkFWRU4yXzE1RDhfQjBfTFcpKQogI2RlZmluZSBBU0lDUkVWX0lTX1BPTExPQ0soZUNoaXBSZXYp
IChlQ2hpcFJldiA9PSBSQVZFTjJfMTVEOF9SRVZfOTQgXAogCQl8fCBlQ2hpcFJldiA9PSBSQVZF
TjJfMTVEOF9SRVZfOTUgXAogCQkJfHwgZUNoaXBSZXYgPT0gUkFWRU4yXzE1RDhfUkVWX0U5IFwK
LS0gCjIuMTcuMQoK

--_004_DM6PR12MB33724602207E1D3B7839A4EF81020DM6PR12MB3372namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_DM6PR12MB33724602207E1D3B7839A4EF81020DM6PR12MB3372namp_--
