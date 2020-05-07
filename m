Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33885C38A2A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 09:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D9C2075E
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 09:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DyuDiwKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D9C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 752BF6E962;
	Thu,  7 May 2020 09:11:45 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690059.outbound.protection.outlook.com [40.107.69.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA716E0B6
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 09:11:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWWndg2MzjKAms+ut3RGqEvETfQ0m3vMe8b0yVUSWyRmR/s4xZjsbCm+C3iKDoRy57dkWD0/Zykg2xfv2JgGPnxFAZXPRXp0F/OGyj0M1kL9XMVrCEADlSPbmlDkyXFForSI0jlyVwF2X0Xej8FabryWfBFm2da+ArBaLP8UO9zffFxcexncI423q/Cb/9TWK6qRG88XDSDLLyRWIjO1mOghU88MWx3OQS7/yHvPswGqlL/ITz1NxSjeJJ9lrXiELq3enITGPY2E9S4WYDS9WTFGB/NQXb9tzFPZi0zC62LE9XKXU2Z+BvCDBBXWTMIE5E2E+KbRVNj2s+0ZzI+1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjb0PEE+vM5l5T1+7XQtIPCjqAUAaHaabHIXsrYgGYM=;
 b=WJpHWtTx6ipAif968hchH3+S3eFVANVuPvF6bgI2ej1OCU5CozwsXKCzggwEWaYroPJiiTWYWWE85DxNlD5RHweTAh8UFAc06qdh4NtNLV/xBG+/0Xddkg/5KNAVqqaDiIQsgwxZ4QWywXtWjHel5pAyyDX0in8t4LMXBOC3KEbPp8zRDjeMyY3QVu4EW4b2+cArzjwY8Uda9CuJQsqcGIP0zcVZkeAAhrYJMvQ8EdMGW9ueaJ4RHqpr5mi0CCpdG/9HyrTqVBxdv/9iUFJrO1/7dEFYMtEMlTfoH0dqoVdH3dyHZal/nXgKv7AxxVqKFzZM0/AlrVQ6g4aSKLKYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjb0PEE+vM5l5T1+7XQtIPCjqAUAaHaabHIXsrYgGYM=;
 b=DyuDiwKP0KJU0dWJ5B/PuXQWX4QoprlTtvTMNW5slr6FqzncEp9k5Gb6PNvnjBWxUXjkkyduySgrfHEVCHK38IkmQZ6gQ1AdycdtyNsJUR99d6WMnocvur4nyf9LdGgWbS1mnFthfDBYYnX/ryDAqO0LNFQlevMWQyRm2+W6Ej8=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29; Thu, 7 May
 2020 09:11:41 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::d55a:3df5:8ff7:afd8]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::d55a:3df5:8ff7:afd8%7]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 09:11:41 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix bug in RAS invoke
Thread-Topic: [PATCH] drm/amdgpu: Fix bug in RAS invoke
Thread-Index: AdYkT3c9ULTdSUr+R9ugbEN9uWnO4w==
Date: Thu, 7 May 2020 09:11:41 +0000
Message-ID: <MN2PR12MB4032323C959F35257B0BCF03FBA50@MN2PR12MB4032.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-07T09:11:37Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1260091a-cd2a-46d7-bedd-0000fcc3ba48;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-07T09:11:37Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9320dc49-db9b-4f5f-aba5-0000a43e1519
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25bff8d9-0a42-4bc8-6293-08d7f266a7e6
x-ms-traffictypediagnostic: MN2PR12MB4407:|MN2PR12MB4407:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB44072C890E4773F694733BA9FBA50@MN2PR12MB4407.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VbrY6uyhKqXvaIKhhX1mJN9iRsHj33rEbvA87i1DrhTuL2RF1doGDxhvErC2WoFag4GmdgMrcXP0t3XJ6Ahx1HYl5aFSZl4lJITOY4izTGgVIXcyWO3Rmsg9QIlN4u9305/7ft624Ya1aFXbTmUaSLlg9u2HMPIe/mAEtw7HRM3KSEtKZ28CEy7AvzuXeER3kV1GE09gfeogXXcXiWyt6ycySVa4sTJWr0Av2H0BshnZWcy965rWuAzh+xuoHqxMb39wb/mRye0/IQkLZyeLFar9RwNX4DZUqeteqTFUn7nItx4eiYYbv/SCCSHC89PHoI14s2bEEpzuKZgbGj33X9q/04etAxJknQMz9U0qYiG09t5pEVtNPgC7KFhSUZWApS8qqORknIT6M2l9ce84qOeLnNaej02CPoC65DN/GJEVno9KGfz/yMmO3Me1rAObWGE+mplz6FB76lyLl9zkrgnz0os2+qG8KocLs23TqrBbFcihB8XjdxUxEcokLY3gyjDWKAhXtkZnOZe3C6ZmRQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(33430700001)(66616009)(66476007)(186003)(5660300002)(7696005)(110136005)(316002)(99936003)(52536014)(558084003)(2906002)(66946007)(9686003)(8676002)(66556008)(71200400001)(66446008)(86362001)(76116006)(64756008)(8936002)(33656002)(6636002)(478600001)(55016002)(26005)(83280400001)(83320400001)(33440700001)(6506007)(83300400001)(83290400001)(83310400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: DsnU0A5/RqhxqfkrGVBb20DAEeLQuy7pB4bx6rqCR0OHYrUwnmtCQ5p90LCzoSjUuSdztwt/pH2+xfLZUbqK3A2CbGVUuq1W5qaDGfEPk2CGe/jjBygknOUvbmnZKem9DPeTkOxUkNp1RVu/UaMC+l5JiIGq9PwVqqdjFw6aaRHoVmtxgSbTVb6DCzMXu0NX1Msr453emKJpyCewBE/PwiWO77dQT/5ibMHbTlCWgyCpgahoBPiAJkrRpPwItzteXNLnA7CJILBtyVN2WPswOsJ1kN2mw67F0YZefx55yyijgHlFxuFHkFZlQHVaMteMgh/EpAz/zzqfeAbeCe8/4fkOoG3nvRRmbAYKQVujKjPkZJycmhc2TV8zxG5zZkaFMsp59B7uSBov+lF/RQX/nU5FcM42DoFzvCTD4JIw4q2xDPBWKmzZvMseLCT82rIhESciORkR8X2Wgjx9cMoh6JJjCzXfhehnNMMcyhljZUzgI62WeDy492f+AzJZ2gcGeDc6fBddVBpKBvaxrNCG0efTWxjJpJPme1nzmRQ8hRrWc2Q5+Xd9uetdPbN0OyTsZhQfwDnOX5D42qKmn1FmkboHYDfh9jMonSYa/oJr0SCXcMP/P9ALSUIye2DEdP0Ma7BP8dCFI2/zc3S0sAlo+tJjFINv26GDmnFLOgWjSop46Gc+PSLctYqciYsLQ3bOm8Grw6gdX87x5rW0FOtb4gu/PIWgNCzRz3fQZ0aWto4kQw/rO7EwlYywMt1juurZwXS2P3n2DYvxmC9BTypfzOkcOWb8D31s8EsN09SDbFM=
Content-Type: multipart/mixed;
 boundary="_004_MN2PR12MB4032323C959F35257B0BCF03FBA50MN2PR12MB4032namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bff8d9-0a42-4bc8-6293-08d7f266a7e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 09:11:41.1935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +eikJqx54lC9rv5lfJXuFs9mNlKfmZPtuUShNMTtZRu5fqki0qjSQT5T+bJgXeB3ageznbNUD4os68bMkEpYow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
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

--_004_MN2PR12MB4032323C959F35257B0BCF03FBA50MN2PR12MB4032namp_
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4032323C959F35257B0BCF03FBA50MN2PR12MB4032namp_"

--_000_MN2PR12MB4032323C959F35257B0BCF03FBA50MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Invoke sequence should abort when RAS interrupt is detected before reading =
TA host shared memory

--_000_MN2PR12MB4032323C959F35257B0BCF03FBA50MN2PR12MB4032namp_
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
<p class=3D"msipheadera92e061b" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0078D7">[AMD Official Use O=
nly - Internal Distribution Only]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Invoke sequence should abort when RAS interrupt is d=
etected before reading TA host shared memory<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4032323C959F35257B0BCF03FBA50MN2PR12MB4032namp_--

--_004_MN2PR12MB4032323C959F35257B0BCF03FBA50MN2PR12MB4032namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-Fix-bug-in-RAS-invoke.patch"
Content-Description: 0001-drm-amdgpu-Fix-bug-in-RAS-invoke.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Fix-bug-in-RAS-invoke.patch"; size=1268;
	creation-date="Thu, 07 May 2020 09:11:00 GMT";
	modification-date="Thu, 07 May 2020 09:11:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmNDg5NGE4M2QyODhjZGMzYjExYTIyNDUzOWFmYWFhMmQ1ZGE2MjllIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
CkRhdGU6IFRodSwgNyBNYXkgMjAyMCAxNzowOToxNiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHU6IEZpeCBidWcgaW4gUkFTIGludm9rZQoKSW52b2tlIHNlcXVlbmNlIHNob3VsZCBh
Ym9ydCB3aGVuIHJhcyBpbnRlcnJ1cHQgaXMgZGV0ZWN0ZWQgYmVmb3JlIHJlYWRpbmcgVEEgaG9z
dCBzaGFyZWQgbWVtb3J5CgpTaWduZWQtb2ZmLWJ5OiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1l
bnRzQGFtZC5jb20+CkNoYW5nZS1JZDogSWNhZDU1NWQzZGUxMDhiNzViOTgxZGEzNTk0ZDljN2Mz
YTNmOThjZjEKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCA2
ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKaW5kZXggZjA2MWFkNjc1MGVk
Li5jYWRlODdjYWVkMGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9wc3AuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMK
QEAgLTc1OSwxNSArNzU5LDE1IEBAIGludCBwc3BfcmFzX2ludm9rZShzdHJ1Y3QgcHNwX2NvbnRl
eHQgKnBzcCwgdWludDMyX3QgdGFfY21kX2lkKQogCiAJcmV0ID0gcHNwX3RhX2ludm9rZShwc3As
IHRhX2NtZF9pZCwgcHNwLT5yYXMuc2Vzc2lvbl9pZCk7CiAKKwlpZiAoYW1kZ3B1X3Jhc19pbnRy
X3RyaWdnZXJlZCgpKQorCQlyZXR1cm4gcmV0OworCiAJaWYgKHJhc19jbWQtPmlmX3ZlcnNpb24g
PiBSQVNfVEFfSE9TVF9JRl9WRVIpCiAJewogCQlEUk1fV0FSTigiUkFTOiBVbnN1cHBvcnRlZCBJ
bnRlcmZhY2UiKTsKIAkJcmV0dXJuIC1FSU5WQUw7CiAJfQogCi0JaWYgKGFtZGdwdV9yYXNfaW50
cl90cmlnZ2VyZWQoKSkKLQkJcmV0dXJuIHJldDsKLQogCWlmICghcmV0KSB7CiAJCWlmIChyYXNf
Y21kLT5yYXNfb3V0X21lc3NhZ2UuZmxhZ3MuZXJyX2luamVjdF9zd2l0Y2hfZGlzYWJsZV9mbGFn
KSB7CiAJCQlkZXZfd2Fybihwc3AtPmFkZXYtPmRldiwgIkVDQyBzd2l0Y2ggZGlzYWJsZWRcbiIp
OwotLSAKMi4xNy4xCgo=

--_004_MN2PR12MB4032323C959F35257B0BCF03FBA50MN2PR12MB4032namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_004_MN2PR12MB4032323C959F35257B0BCF03FBA50MN2PR12MB4032namp_--
