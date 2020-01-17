Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8067CC33CB7
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 09:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1445D20730
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 09:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j/5fOpHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1445D20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDAF76F4B8;
	Fri, 17 Jan 2020 09:43:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA196F4B8
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 09:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOagmnZ0YmmyPnKR9DkL3s61/m8gq/CBzS80C+xp3kmOBUcB8x2vQc4jDcsc6CbfUzDcQGkQUxT/R/yJvs/Ppa/QNEoG79tDJLJK3M6uxNTXWqYAmMNPq8pbPIXFJ+EW3HlIqs3AYtCWIAbDp3nFzPLXKgsDm+4VEAZkuHwc0lwFyJUBg7Quxxbqzli+fv4Z2ZXxwa72cHf9EZoI5F3eRpuURpXnevns3Z6DCWkjmeUvQQ9iC4ngBSu/5MLbNrtCYX64wFJ1XeQgqhaQCOoEHrH5LiJZFeDzgPbp0HwOzb719TGHIyCz+ZrTJ2mK8daXxw3jM+zxGxKOoAZg2COdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3fqcGR5o5GWoyzSMjoAL7QACjWf8OclA1OjMRFi9ew=;
 b=lUZ1yuaF8ih27qi6Ve6MFwLge496YRYaqlB59q97Dh2oAYxQhzPa89X+6WXNO/Yzz0BDSty1KIigS3m28+ygNSg2Fe+QO+4HwR9x8mXqpgKC89ly3NTcsBWCk1H7tDb6Zig9BjdogHTAY/lkahopo19ZKcFrkZqhCDJRCMjGYaPYyycXE9R4fmObvjy2MSSX32oIf04X/hKOPSz1alwEDt8ae6Tx3jtoz6aO/5/8j3QWq7kUYdOKLKUjxT7VLt+4aew9gQn7gcj8LT+JrbRCYIef7d6hjk9xmODFs+m6sLu77adR95mkA3s4mxTR9CUjDOB/Kpir8MEvLUD/3hn62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3fqcGR5o5GWoyzSMjoAL7QACjWf8OclA1OjMRFi9ew=;
 b=j/5fOpHNnS2aCOfDIRtPF6hEkaxk/KvTI1EcxhE7MxOk5ynKVhnr8pq/6pi/S55ZOdCsLYqvod3OB2cmto/9b4uQg56pm7/yDTZrzThQh2APfVPs4GejBFUQc0EFFWWEixsRHlcTRvD77XbrszqyZctdFPQvWkOGE2CurdOeaPU=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB3023.namprd12.prod.outlook.com (20.178.242.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Fri, 17 Jan 2020 09:43:11 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::86f:2434:3029:f166%6]) with mapi id 15.20.2644.015; Fri, 17 Jan 2020
 09:43:10 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Added check for RAS EEPROM support
Thread-Topic: [PATCH] drm/amdgpu: Added check for RAS EEPROM support
Thread-Index: AdXNGmYX/stLAjpBRjij9x4yAb51oA==
Date: Fri, 17 Jan 2020 09:43:10 +0000
Message-ID: <MN2PR12MB366303B43AA493B2893B8922FB310@MN2PR12MB3663.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-17T09:43:07Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9a309eb5-4d24-4287-9df8-0000fce02d88;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-17T09:43:07Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 3fc8ec80-1609-4ca2-a067-0000c52a1cbd
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [120.235.45.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9dff46b2-fd98-47f6-4132-08d79b31aa46
x-ms-traffictypediagnostic: MN2PR12MB3023:|MN2PR12MB3023:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB30237C9EC160778B3EE2E98BFB310@MN2PR12MB3023.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(81156014)(110136005)(6636002)(8676002)(8936002)(81166006)(316002)(33656002)(55016002)(478600001)(86362001)(66446008)(5660300002)(66556008)(66616009)(76116006)(64756008)(66476007)(66946007)(52536014)(186003)(9686003)(26005)(71200400001)(6506007)(558084003)(7696005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3023;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BBQ91OM2qFg8bnO65Gk5GYYALmJTvJtObqqH9c6Sx2FWUc572M2eCz+K4RZeHFAqROb1UTqP/u7NRcq01ZlgDrFFqV4YTiqVHhVvcmjsCEE1o5kBnoxiKBdGKnYSqxslA8BpGBQxSF4p25f6ceVZwWn6k9xWcpj7VShRTyPnGMZfxwvTFMLV+nPJmbONDyncfw2VzWNZn7I0JGThSmghI6+4g9B+0YQkst9t+8fOUpswpEA1SuR75OhIl2u9XzvoWZct0ScHycTuGGD0YuyIzv9nfTRTWCA4cWRT2z6tAuZIL53GKsLrF//8181zTmme8q6froynl3HOuYvfm2U/m5i0/Dxoj3+9RjbLLwRLCfthweJTbnk0J/8T6C17q4B6v2w53RvCX+2h5dhup97Dffm5opvciFKlQfx84jmjrnurNDEmyqGrf36E1mU7AYn5
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB366303B43AA493B2893B8922FB310MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dff46b2-fd98-47f6-4132-08d79b31aa46
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 09:43:10.7518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQ3pt4HLQDgXe4rOfbC9h1zSuEkwA6ONx9sugcPglyt2e0gw/NHZllZUxAcVHYCcn/FWa3RXWL4FXKnwBdWzZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3023
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

--_004_MN2PR12MB366303B43AA493B2893B8922FB310MN2PR12MB3663namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB366303B43AA493B2893B8922FB310MN2PR12MB3663namp_"

--_000_MN2PR12MB366303B43AA493B2893B8922FB310MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Submitting patch to disable access of RAS EEPROM in event SMU is disabled d=
uring modprobe phase.

Thank you,
John Clements

--_000_MN2PR12MB366303B43AA493B2893B8922FB310MN2PR12MB3663namp_
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
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
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
<p class=3D"msipheader4d0fcdd7" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Submitting patch to disable access of RAS EEPROM in =
event SMU is disabled during modprobe phase.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB366303B43AA493B2893B8922FB310MN2PR12MB3663namp_--

--_004_MN2PR12MB366303B43AA493B2893B8922FB310MN2PR12MB3663namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-Added-check-for-RAS-EEPROM-support.patch"
Content-Description: 0001-drm-amdgpu-Added-check-for-RAS-EEPROM-support.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Added-check-for-RAS-EEPROM-support.patch";
	size=2186; creation-date="Fri, 17 Jan 2020 09:41:00 GMT";
	modification-date="Fri, 17 Jan 2020 09:41:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwOGI3NDhmYjczOTU3NGE2ZmE4MjEyMTA4NmMyYjg3OGNkNDQzYmQ2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IEZyaSwgMTcgSmFuIDIwMjAgMTc6Mzk6MzEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBBZGRlZCBjaGVjayBmb3IgUkFTIEVFUFJPTSBzdXBwb3J0CgpJZiBTTVUgaXMg
ZGlzYWJsZWQgcHJldmVudCBhY2Nlc3MgdG8gUkFTIEVFUFJPTQoKQ2hhbmdlLUlkOiBJMjZiNGEy
NjUyMzViMjQ2ZWI4NjBkZDljNDAwMDg2MGQ2MWEzYjIxZgpTaWduZWQtb2ZmLWJ5OiBKb2huIENs
ZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+Ci0tLQogLi4uL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmFzX2VlcHJvbS5jICAgIHwgMjMgKysrKysrKysrKysrKysrKysrKwogMSBmaWxl
IGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhc19lZXByb20uYwppbmRleCAyYThlMDQ4OTU1OTUuLjRlNGMwM2Y2MjY5NyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20u
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jCkBA
IC0xNzQsMTIgKzE3NCwyOSBAQCBzdGF0aWMgYm9vbCBfX3ZhbGlkYXRlX3RibF9jaGVja3N1bShz
dHJ1Y3QgYW1kZ3B1X3Jhc19lZXByb21fY29udHJvbCAqY29udHJvbCwKIAlyZXR1cm4gdHJ1ZTsK
IH0KIAorc3RhdGljIGJvb2wgX19pc19lZXByb21fc3VwcG9ydGVkKHN0cnVjdCBhbWRncHVfcmFz
X2VlcHJvbV9jb250cm9sICpjb250cm9sKQoreworCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gdG9fYW1kZ3B1X2RldmljZShjb250cm9sKTsKKwlzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICpz
bXVfYmxvY2sgPSBhbWRncHVfZGV2aWNlX2lwX2dldF9pcF9ibG9jayhhZGV2LCBBTURfSVBfQkxP
Q0tfVFlQRV9TTUMpOworCisJaWYgKCFzbXVfYmxvY2sgfHwgIXNtdV9ibG9jay0+c3RhdHVzLnZh
bGlkKQorCXsKKwkJRFJNX1dBUk4oIlNNVSBkaXNhYmxlZCwgUkFTIEVFUFJPTSBub3Qgc3VwcG9y
dGVkXG4iKTsKKwkJcmV0dXJuIGZhbHNlOworCX0KKworCXJldHVybiB0cnVlOworfQorCiBpbnQg
YW1kZ3B1X3Jhc19lZXByb21fcmVzZXRfdGFibGUoc3RydWN0IGFtZGdwdV9yYXNfZWVwcm9tX2Nv
bnRyb2wgKmNvbnRyb2wpCiB7CiAJdW5zaWduZWQgY2hhciBidWZmW0VFUFJPTV9BRERSRVNTX1NJ
WkUgKyBFRVBST01fVEFCTEVfSEVBREVSX1NJWkVdID0geyAwIH07CiAJc3RydWN0IGFtZGdwdV9y
YXNfZWVwcm9tX3RhYmxlX2hlYWRlciAqaGRyID0gJmNvbnRyb2wtPnRibF9oZHI7CiAJaW50IHJl
dCA9IDA7CiAKKwlpZiAoIV9faXNfZWVwcm9tX3N1cHBvcnRlZChjb250cm9sKSkKKwkJcmV0dXJu
IDA7CisKIAltdXRleF9sb2NrKCZjb250cm9sLT50YmxfbXV0ZXgpOwogCiAJaGRyLT5oZWFkZXIg
PSBFRVBST01fVEFCTEVfSERSX1ZBTDsKQEAgLTIxMiw2ICsyMjksOSBAQCBpbnQgYW1kZ3B1X3Jh
c19lZXByb21faW5pdChzdHJ1Y3QgYW1kZ3B1X3Jhc19lZXByb21fY29udHJvbCAqY29udHJvbCkK
IAkJCS5idWYJPSBidWZmLAogCX07CiAKKwlpZiAoIV9faXNfZWVwcm9tX3N1cHBvcnRlZChjb250
cm9sKSkKKwkJcmV0dXJuIDA7CisKIAltdXRleF9pbml0KCZjb250cm9sLT50YmxfbXV0ZXgpOwog
CiAJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKQEAgLTI2Nyw2ICsyODcsOSBAQCB2b2lkIGFt
ZGdwdV9yYXNfZWVwcm9tX2Zpbmkoc3RydWN0IGFtZGdwdV9yYXNfZWVwcm9tX2NvbnRyb2wgKmNv
bnRyb2wpCiB7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSB0b19hbWRncHVfZGV2aWNl
KGNvbnRyb2wpOwogCisJaWYgKCFfX2lzX2VlcHJvbV9zdXBwb3J0ZWQoY29udHJvbCkpCisJCXJl
dHVybjsKKwogCXN3aXRjaCAoYWRldi0+YXNpY190eXBlKSB7CiAJY2FzZSBDSElQX1ZFR0EyMDoK
IAkJc211X3YxMV8wX2kyY19lZXByb21fY29udHJvbF9maW5pKCZjb250cm9sLT5lZXByb21fYWNj
ZXNzb3IpOwotLSAKMi4xNy4xCgo=

--_004_MN2PR12MB366303B43AA493B2893B8922FB310MN2PR12MB3663namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB366303B43AA493B2893B8922FB310MN2PR12MB3663namp_--
