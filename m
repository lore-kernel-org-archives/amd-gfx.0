Return-Path: <SRS0=0vKA=BN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBDBC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 06:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5CF820678
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 06:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yZI3QS3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CF820678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05BFA89D73;
	Mon,  3 Aug 2020 06:00:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98AC089D73
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2020 06:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWsACquZ9BhuIbpgYYYeU7RM955uZt6b7YFUnG5Ppb3sjqwPO5w/ONnEt/QmKkMm3XvRjZDZ4nYVkkp4/l6ixni6I8uTZ2pe2dHPiKmv40XsIid5Oy6TZNrjtutyVyrpuyo7RMKsJnTXP75AFnTe5GUvKKrJ+VJ4/tglBQYZlas4G+7YNk5M1BFgkNA2oFRPMNRZ6ymkCQbneo0Hg5MlCvIgPgeEbNq3ETnqwND9nGowyiJBiH165+9W18DAHsk8EpMpqvKKwpFfawlA/ALwgAdVW9/Hp0kdi+1jdJiscvtgM7T0DRLkGoVO2bukE2c1dNjOOFPgoBxMKSxcmv+H8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU/PHtnKMZS7z+Eh4FDllLeJi2IG5AE02uezGH6NzVk=;
 b=W9NZ9CCwvDeFoKnGydJQLVRtttWYurAGBCcsOtWqTKNM6Yq6r0lBHoYlg0PaL7dUTNCOncqAcNFVmbDv7bYEybpbPo8vNEY02tMHP/DoSjTsIsgsDMn4t6wElNnL+JrYguswK4AKMmuRsCuZ0E/x5Ik3svMOwaWHNJ+ldNwej25iNuf+OVDvVL4Gyg8NDmYzz87q2bfwZijOPRKhcThKmU0QA4FwrUb9RysPzEqHnGbVxfXagK4Sluei2NjJ32tQ8fm4/8mjbHc+C2wzOPAfoGxWT7BdKX/V3cXF+Ec8Avaf8iVjvFH8ylOJDD86tYKWk8eJzLg9ETjiCj4jjXNQdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU/PHtnKMZS7z+Eh4FDllLeJi2IG5AE02uezGH6NzVk=;
 b=yZI3QS3wcK6tOG4rwmFkyhlGe/El0DKAa5EvTPf9wxcVOVjjkQpYg5DU5iTQPBcOs89a8SmNGHZRyGeZ3O2LoM6hKaGE2FoijaNdRexbi6G7iXTmufAI2x1ofw01dWxzvwHTghAbYoE3ybcnAC2uUmWFBjEmIoWxQdOgTN+Psnc=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Mon, 3 Aug
 2020 06:00:42 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235%7]) with mapi id 15.20.3239.016; Mon, 3 Aug 2020
 06:00:42 +0000
From: "Clements, John" <John.Clements@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: enable RAS support for sienna
Thread-Topic: [PATCH] drm/amdgpu: enable RAS support for sienna
Thread-Index: AdZpW0yRASYpPXOeRrWELF9H7Dx0bQ==
Date: Mon, 3 Aug 2020 06:00:42 +0000
Message-ID: <MN2PR12MB403260349869815CF543201FFB4D0@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-03T06:00:38Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8643324a-d5bd-44bd-b7fc-000054a2e6d2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-03T06:00:33Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 41386be6-cc74-4c6b-a204-0000a744d7cd
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-03T06:00:39Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 8f3866d0-0945-49d2-ab65-000087e0a55e
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2236f6f-d4a6-402a-733e-08d837728e60
x-ms-traffictypediagnostic: MN2PR12MB4376:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4376348C2E9104718735DD96FB4D0@MN2PR12MB4376.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IYxWKEefZU396FrCS0JTLfG+HE23PoAFdXOfl60NtjnV9gWegMGLhAucVyjNzY3GhSHzZXxYvxs/pFEBvjXiJxyGhUgXHlv/V+YsOHB0Cfbefw0Gv+LVVXmKDZkmh8Fe9gY4pIRSFiIYBbPHnDcsM3t2QaDhK9covablnGGSxJDmKbdzDvQXpQRtNDs+VLsU+1HvlZ7oDQwS6C7QG4DFR95YGLRKRMDMkxJ8vJ3yHs0gagTHw39HPaKutu0zzMstTc4cfyaxZj9GQ+KhDKD3EdUiPwhhnnjkEaPyfRUnTcplP03mEOvZj7GErD0Yv7wPFWWUAZ50apLhfOALaJgkCQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(71200400001)(316002)(86362001)(7696005)(186003)(6506007)(110136005)(52536014)(33656002)(5660300002)(2906002)(6636002)(8936002)(66946007)(66446008)(64756008)(66556008)(66476007)(66616009)(26005)(76116006)(99936003)(478600001)(558084003)(9686003)(8676002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: FykmzoGbvHmedehGpSgYmMyE68CPA/degKrnfu6NIGhdWE3mgiTVKbAun/uvh1RrmD78/ooQ9D37K0/yTyk1RjO4HLbCgiDZRr/DXgNmcxmN0MYRySXGdqTEgcl09EO+gBvF+79jEAddoJNj0qjcWVPq+zrQ+4l/dC5v3ktuJK557aUKGPaoEHnW2xfS/LiRXrqp+cI5W/UFvU0c30b/NWn6kUTZ6VuN1S5HS25Y80R4O5khAlTVd33dv7ngeVOQHbBTSV0WiEvit/llTDpANGQc25xuyQhXSSxQ7+5AkFkxDZBNrsVT40rgkdTHwM9vlo2Sp6vVBgm0YRkdXO1si0FbRK3/mzazikk6sKES5lEzrb//t5v7eFKTteXN17vRRARPBzq08NS6dbuec2k7bp/Xg94GzA7bda/q1MRx0VJT2n1a3QVQF936IobHsgxY2Cflt/mjx5+27rDgwKhoEbOzU4HrI0SpjbIyRjXSy/QdEekNYsbkpCXoe878+MY8XUqfp6v1GUItD4Da1YKgFtodTN18oEK6RjQlrKhgSZ4fmzHN2e7RCtEERYkQgsbZXePS7ufEDTNRJAM9hPqCtsipFIblK+WRx533dPl8DP5uHR8xxGI6PVsBX13xlR7xc/eJDWQeLDgKDu51N+mYBA==
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB403260349869815CF543201FFB4D0MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2236f6f-d4a6-402a-733e-08d837728e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 06:00:42.5941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jW+EHmgKRhuV3hrIXBmH00tgfY69/uA9uzQq5g/d+bbpOsx8IxoJj6ik2GGUU/x0hRvHBD6orjJ7bqF+BPEXnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
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

--_004_MN2PR12MB403260349869815CF543201FFB4D0MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB403260349869815CF543201FFB4D0MN2PR12MB4032namp_"

--_000_MN2PR12MB403260349869815CF543201FFB4D0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Submitting patch to turn on GECC error injection /query support for sienna =
cichilid.

Thank you,
John Clements

--_000_MN2PR12MB403260349869815CF543201FFB4D0MN2PR12MB4032namp_
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
<p class=3D"MsoNormal">Submitting patch to turn on GECC error injection /qu=
ery support for sienna cichilid.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal">John Clements<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB403260349869815CF543201FFB4D0MN2PR12MB4032namp_--

--_004_MN2PR12MB403260349869815CF543201FFB4D0MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-enable-RAS-support-for-sienna.patch"
Content-Description: 0001-drm-amdgpu-enable-RAS-support-for-sienna.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-enable-RAS-support-for-sienna.patch"; size=1640;
	creation-date="Mon, 03 Aug 2020 05:59:00 GMT";
	modification-date="Mon, 03 Aug 2020 05:59:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzM2U1ZDFiNWU3ODUyZDZjZTJiODVlYmY0YTA4NTBmZjVlZDE5YmFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IE1vbiwgMyBBdWcgMjAyMCAxMzo1NzozOSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IGVuYWJsZSBSQVMgc3VwcG9ydCBmb3Igc2llbm5hCgplbmFibGVkIEdFQ0MgZXJy
b3IgaW5qZWN0aW9uIGFuZCBxdWVyeSBzdXBwb3J0CgpTaWduZWQtb2ZmLWJ5OiBKb2huIENsZW1l
bnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+CkNoYW5nZS1JZDogSTJmODYwNzEyNDNiZGMyOTdj
NGU4ZDIxNmZlYTY3MWFjMTkzMjZjMDQKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmFzLmMgfCA1ICsrKy0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEw
XzAuYyAgfCA0ICsrKysKIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwppbmRleCA4OWNi
MGFlOWRhOWQuLjFhNTVmNmY0OTJmZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Jhcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yYXMuYwpAQCAtMTk2NSw4ICsxOTY1LDkgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Jhc19jaGVj
a19zdXBwb3J0ZWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJKnN1cHBvcnRlZCA9IDA7
CiAKIAlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpIHx8ICFhZGV2LT5pc19hdG9tX2Z3IHx8Ci0J
ICAgIChhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9WRUdBMjAgJiYKLQkgICAgIGFkZXYtPmFzaWNf
dHlwZSAhPSBDSElQX0FSQ1RVUlVTKSkKKwkgICAgKGFkZXYtPmFzaWNfdHlwZSAhPSBDSElQX1ZF
R0EyMCAgICYmCisJICAgICBhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9BUkNUVVJVUyAmJgorCSAg
ICAgYWRldi0+YXNpY190eXBlICE9IENISVBfU0lFTk5BX0NJQ0hMSUQpKQogCQlyZXR1cm47CiAK
IAlpZiAoYW1kZ3B1X2F0b21maXJtd2FyZV9tZW1fZWNjX3N1cHBvcnRlZChhZGV2KSkgewpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwppbmRleCAzNWQyMWYzMzBiMGEuLmRkOTFh
OTNkZTYyYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8w
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKQEAgLTYzMyw2
ICs2MzMsMTAgQEAgc3RhdGljIGludCBnbWNfdjEwXzBfbGF0ZV9pbml0KHZvaWQgKmhhbmRsZSkK
IAlpZiAocikKIAkJcmV0dXJuIHI7CiAKKwlyID0gYW1kZ3B1X2dtY19yYXNfbGF0ZV9pbml0KGFk
ZXYpOworCWlmIChyKQorCQlyZXR1cm4gcjsKKwogCXJldHVybiBhbWRncHVfaXJxX2dldChhZGV2
LCAmYWRldi0+Z21jLnZtX2ZhdWx0LCAwKTsKIH0KIAotLSAKMi4xNy4xCgo=

--_004_MN2PR12MB403260349869815CF543201FFB4D0MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB403260349869815CF543201FFB4D0MN2PR12MB4032namp_--
