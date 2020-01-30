Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E63C2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 19:10:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F9320658
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 19:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s/VZcve1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F9320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 694A56E8C6;
	Thu, 30 Jan 2020 19:10:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 494F36E8C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 19:10:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQFtpnj5hPDc6pb8rNobEXcbSpxWlVgKv7r1WriaYGrfGkVrL7SyUcfrriYwg6QqsBki3cieVdhFKFU/HSpJod8pE8zK0niClgXqQ9AhxbG1wq6oPgTQZSEkiH7qm7vPfpWMiN3djbJR25sP67S7PtLuhKs4MPAQaKay/qSNg5EjhC6nqBx9gT72KgDAev3aIyd2/35p5RCONGS7bdYcnom+CLjuDreFGPdvgzxc9rkTXcQYbdL6/jD2vEkaXw2a/gJUdU07B/4ecfvF25ytz5DzyTDfDkO/qRuSv/ljjsEYhbT6XzoX/TMfJrnOeW7rKdEo/Wt8zYYhnVaRoqzurw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vz7MfE9E+na0+6l024pwOsqZLjAXnDrW2+z4sGo3iZo=;
 b=FuLqezHmRh1EYKfEvskj+2X68CYGgFE9yH46sc4DW+1IR7w5KwbuwSXSJZ1HhL2jsS400pTyEupT5hTkWXqSwq+oKi0MqOdXewL8/dAb/5OYhgbn+cbiPIq8hJP1sj1aPCTDi21VM4O0X8u6AARWlwN3Wk3lYxLzZ5EZmLSx5imOv3e/nLdYrWkvzgqsSxDcxElZwt99hgQpr3pkgu+a29MvPtjE9NpTYASdRkO5zfnMimFJCZ2r9HTZ694YUsZsCCaoLDO8yRVv/DQTsJgLJNPmvcCFunDHmBGBopxCFxnBg/k7iBF0XQgD/kITrRreJbVzj2OBV7cTikojyBWfpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vz7MfE9E+na0+6l024pwOsqZLjAXnDrW2+z4sGo3iZo=;
 b=s/VZcve1tRnuoaQdOAHQBbCkylinhcyN2vxwKLommKq5/pix+zLaB00baVCYUBC55NTYZGT9cHeumdtRvybC/U6vyHer1YHhDulmo2riKGhNtAOVgsrO9Tl35bqd1hszFm9O/hmp+At1yIsZmLF8aVOJete3nefsSLG0NddfcB4=
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com (10.172.92.14) by
 DM5PR1201MB2472.namprd12.prod.outlook.com (10.172.86.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Thu, 30 Jan 2020 19:10:15 +0000
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::f4c6:42e8:77bb:d721]) by DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::f4c6:42e8:77bb:d721%6]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 19:10:15 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: Jacob Hrbek <kreyren@rixotstudio.cz>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: Suspecting corrupted VBIOS after update of AMDGPU on AMD7870
Thread-Topic: Suspecting corrupted VBIOS after update of AMDGPU on AMD7870
Thread-Index: AQHV15Rg0BbLc2SY10KexnqB4ReJNagDkiVA
Date: Thu, 30 Jan 2020 19:10:14 +0000
Message-ID: <DM5PR1201MB25540C0A23067345E620DA6C9E040@DM5PR1201MB2554.namprd12.prod.outlook.com>
References: <CAPA_gs6evUkUbPipQ4=BTH9R9ZWDZimZpTYbOBus+i=AZZDnyw@mail.gmail.com>
In-Reply-To: <CAPA_gs6evUkUbPipQ4=BTH9R9ZWDZimZpTYbOBus+i=AZZDnyw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92cba3ba-c361-4058-2688-08d7a5b809a1
x-ms-traffictypediagnostic: DM5PR1201MB2472:
x-microsoft-antispam-prvs: <DM5PR1201MB24724B141F379972DB9CE2849E040@DM5PR1201MB2472.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(52536014)(110136005)(26005)(8676002)(81166006)(81156014)(64756008)(66446008)(86362001)(66556008)(55016002)(66476007)(9686003)(186003)(966005)(478600001)(33656002)(71200400001)(7696005)(9326002)(2906002)(76116006)(4744005)(5660300002)(15650500001)(66946007)(53546011)(8936002)(316002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2472;
 H:DM5PR1201MB2554.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vu9HLexTuOEZXSASZT16TiGJxtVp/d9hPmsXVqnhDQqNI9UKP7/D3FD7KpGS8pNV8x+UV0IQ8z893zKeJNG4r7r8EZ2WogAbJNI5JcSG25Yu8nrCIpa8xVMycMn4R5toBmcn89kCwHKlsaiaoyX7HWK8VyVeeERP5QdMleXVjv2zlto0iIL3pzVXa3Luc/WoZ+/IAUdb/ng7EU8le59Z/eieJR14CJHt4/YXq6ckqwdlNAFxbBzpcY7r2RZsHCUO1vBtNvxnN7JKxk+uAEwypu00hgMZqXRJqSYTSE5ylUYmYpTJYOnwa/2qWb/zpgUIPWBp1KmZZbcbOWX/t2KJNAMdUPRBbr/8E+AKmj9RhBsm0TnKMki8W/PMg69O3bfN/tQKOXWNIyCzX9rvp0gKBq9AEEJdBk18U7Z53Nv3HZHoNMMCiM3Vx15KXEtPV5uO2PlZLQCFzdTR7F/fxMaIMlDy801PaX637JXEWbn99MzXVfaxnknkmQKHXjk/LhVKwGF+bX0VZkpQ3WZce+tiaQ==
x-ms-exchange-antispam-messagedata: 7otKsDMKjb5HlEH7MKcHgRNJ72QwurtY1M6D4+WKO8yKtxGw5Jg8ZTx37LowbX19eD/K1M300VDkw2UJKtE0U8PLpgBTmG2Bh9V8bC18uza8A7NWEgZ5Tx0jAzJH+3+mhYjUwZiHyQQy5Auanr5Kpg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cba3ba-c361-4058-2688-08d7a5b809a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 19:10:14.8696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjvSc/FgG3T2v6QJMPC1wOGQouJN3/jSdrZvREfxeuZjfHarOt6WlRkko58yyPJv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2472
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
Content-Type: multipart/mixed; boundary="===============1856301281=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1856301281==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR1201MB25540C0A23067345E620DA6C9E040DM5PR1201MB2554_"

--_000_DM5PR1201MB25540C0A23067345E620DA6C9E040DM5PR1201MB2554_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSmFjb2IsDQoNClRoYW50IHlvdSBmb3IgeW91ciBidWcgcmVwb3J0aW5nLg0KDQpJIHNhdyB5
b3UgYXR0YWNoZWQgeG9yZy5sb2csIHdoaWNoIGlzIGdyZWF0LiBDb3VsZCB5b3UgYWxzbyBncmFi
IGRtZXNnLmxvZyB2aWEgU1NIPw0KDQpUaGFua3MsDQpaaGFuDQoNCg0KRnJvbTogYW1kLWdmeCA8
YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEphY29i
IEhyYmVrDQpTZW50OiAyMDIwL0phbnVhcnkvMzAsIFRodXJzZGF5IDEyOjE4IFBNDQpUbzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFN1c3BlY3RpbmcgY29ycnVwdGVk
IFZCSU9TIGFmdGVyIHVwZGF0ZSBvZiBBTURHUFUgb24gQU1ENzg3MA0KDQpIZWxsbywNCkkgYmVs
aWV2ZSB0aGF0IHN5c3RlbSB1cGRhdGUgdGhhdCBpbmNsdWRlZCBhbWRncHUgb24gZGViaWFuIHRl
c3RpbmcgKGJ1dCBpIGFtIG9uIExGUykgY29ycnVwdGVkIG15IFZCSU9TIG9uIEFNRDc4NzAgKCst
IDQgaG91cnMgYWZ0ZXIgdGhlIHVwZGF0ZSB0aGUgR1BVIHVzaW5nIEFNREdQVS9SYWRlb24gZHJp
dmVycyByZXN1bHRlZCBpbiBubyBvdXRwdXQpLg0KaSdtIHNlbmRpbmcgdGhpcyBlbWFpbCB0byBp
bmZvcm0gYWJvdXQgcG9zc2libGUgYnVnIHdpdGggbXkgZmluZGluZ3Mgb24gaHR0cHM6Ly9naXN0
LmdpdGh1Yi5jb20vS3JleXJlbi8zZTU1ZTlhNzU0ZTU4OTU2ZTE2OTBlMzhiMTg4OGRlNzxodHRw
czovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZnaXN0LmdpdGh1Yi5jb20lMkZLcmV5cmVuJTJGM2U1NWU5YTc1NGU1ODk1NmUxNjkwZTM4
YjE4ODhkZTcmZGF0YT0wMiU3QzAxJTdDemhhbi5saXUlNDBhbWQuY29tJTdDMDFlOWJjODI3OGE3
NGM0ZDIxNWQwOGQ3YTVhYjY3ZDAlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3
QzAlN0MwJTdDNjM3MTYwMDI4MzUwNTE5NDQ5JnNkYXRhPXBJcVI0YlIxbTUwSE5HOFFTVkJKeXA3
NVoyUHRvVWdOQmJMamtsaWx2UnMlM0QmcmVzZXJ2ZWQ9MD4gYW5kIGkgd291bGQgYXBwcmVjaWF0
ZSBhbnkgaGVscCBpbiBleGNsdWRpbmcgVkJJT1MgY29ycnVwdGlvbiBmcm9tIHRoZSBkaWFnbm9z
dGljcy4NClRoYW5rcywNCi0gSmFjb2IgSHJiZWsNCg==

--_000_DM5PR1201MB25540C0A23067345E620DA6C9E040DM5PR1201MB2554_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTUgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
IkNhbWJyaWEgTWF0aCI7DQoJcGFub3NlLTE6MiA0IDUgMyA1IDQgNiAzIDIgNDt9DQpAZm9udC1m
YWNlDQoJe2ZvbnQtZmFtaWx5OkRlbmdYaWFuOw0KCXBhbm9zZS0xOjIgMSA2IDAgMyAxIDEgMSAx
IDE7fQ0KQGZvbnQtZmFjZQ0KCXtmb250LWZhbWlseTpDYWxpYnJpOw0KCXBhbm9zZS0xOjIgMTUg
NSAyIDIgMiA0IDMgMiA0O30NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6IlxARGVuZ1hpYW4i
Ow0KCXBhbm9zZS0xOjIgMSA2IDAgMyAxIDEgMSAxIDE7fQ0KQGZvbnQtZmFjZQ0KCXtmb250LWZh
bWlseTpUYWhvbWE7DQoJcGFub3NlLTE6MiAxMSA2IDQgMyA1IDQgNCAyIDQ7fQ0KLyogU3R5bGUg
RGVmaW5pdGlvbnMgKi8NCnAuTXNvTm9ybWFsLCBsaS5Nc29Ob3JtYWwsIGRpdi5Nc29Ob3JtYWwN
Cgl7bWFyZ2luOjBpbjsNCgltYXJnaW4tYm90dG9tOi4wMDAxcHQ7DQoJZm9udC1zaXplOjExLjBw
dDsNCglmb250LWZhbWlseToiQ2FsaWJyaSIsc2Fucy1zZXJpZjt9DQphOmxpbmssIHNwYW4uTXNv
SHlwZXJsaW5rDQoJe21zby1zdHlsZS1wcmlvcml0eTo5OTsNCgljb2xvcjpibHVlOw0KCXRleHQt
ZGVjb3JhdGlvbjp1bmRlcmxpbmU7fQ0KYTp2aXNpdGVkLCBzcGFuLk1zb0h5cGVybGlua0ZvbGxv
d2VkDQoJe21zby1zdHlsZS1wcmlvcml0eTo5OTsNCgljb2xvcjpwdXJwbGU7DQoJdGV4dC1kZWNv
cmF0aW9uOnVuZGVybGluZTt9DQpwLm1zb25vcm1hbDAsIGxpLm1zb25vcm1hbDAsIGRpdi5tc29u
b3JtYWwwDQoJe21zby1zdHlsZS1uYW1lOm1zb25vcm1hbDsNCgltc28tbWFyZ2luLXRvcC1hbHQ6
YXV0bzsNCgltYXJnaW4tcmlnaHQ6MGluOw0KCW1zby1tYXJnaW4tYm90dG9tLWFsdDphdXRvOw0K
CW1hcmdpbi1sZWZ0OjBpbjsNCglmb250LXNpemU6MTEuMHB0Ow0KCWZvbnQtZmFtaWx5OiJDYWxp
YnJpIixzYW5zLXNlcmlmO30NCnNwYW4uRW1haWxTdHlsZTE4DQoJe21zby1zdHlsZS10eXBlOnBl
cnNvbmFsLXJlcGx5Ow0KCWZvbnQtZmFtaWx5OiJDYWxpYnJpIixzYW5zLXNlcmlmOw0KCWNvbG9y
OndpbmRvd3RleHQ7fQ0KLk1zb0NocERlZmF1bHQNCgl7bXNvLXN0eWxlLXR5cGU6ZXhwb3J0LW9u
bHk7DQoJZm9udC1mYW1pbHk6IkNhbGlicmkiLHNhbnMtc2VyaWY7fQ0KQHBhZ2UgV29yZFNlY3Rp
b24xDQoJe3NpemU6OC41aW4gMTEuMGluOw0KCW1hcmdpbjoxLjBpbiAxLjBpbiAxLjBpbiAxLjBp
bjt9DQpkaXYuV29yZFNlY3Rpb24xDQoJe3BhZ2U6V29yZFNlY3Rpb24xO30NCi0tPjwvc3R5bGU+
PCEtLVtpZiBndGUgbXNvIDldPjx4bWw+DQo8bzpzaGFwZWRlZmF1bHRzIHY6ZXh0PSJlZGl0IiBz
cGlkbWF4PSIxMDI2IiAvPg0KPC94bWw+PCFbZW5kaWZdLS0+PCEtLVtpZiBndGUgbXNvIDldPjx4
bWw+DQo8bzpzaGFwZWxheW91dCB2OmV4dD0iZWRpdCI+DQo8bzppZG1hcCB2OmV4dD0iZWRpdCIg
ZGF0YT0iMSIgLz4NCjwvbzpzaGFwZWxheW91dD48L3htbD48IVtlbmRpZl0tLT4NCjwvaGVhZD4N
Cjxib2R5IGxhbmc9IkVOLVVTIiBsaW5rPSJibHVlIiB2bGluaz0icHVycGxlIj4NCjxkaXYgY2xh
c3M9IldvcmRTZWN0aW9uMSI+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5IaSBKYWNvYiw8bzpwPjwv
bzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+VGhhbnQgeW91IGZvciB5b3VyIGJ1ZyByZXBvcnRpbmcuPG86cD48
L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPkkgc2F3IHlvdSBhdHRhY2hlZCB4b3JnLmxvZywgd2hpY2ggaXMg
Z3JlYXQuIENvdWxkIHlvdSBhbHNvIGdyYWIgZG1lc2cubG9nIHZpYSBTU0g/PG86cD48L286cD48
L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiPlRoYW5rcyw8bzpwPjwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PlpoYW48bzpwPjwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9v
OnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8ZGl2
IHN0eWxlPSJib3JkZXI6bm9uZTtib3JkZXItbGVmdDpzb2xpZCBibHVlIDEuNXB0O3BhZGRpbmc6
MGluIDBpbiAwaW4gNC4wcHQiPg0KPGRpdj4NCjxkaXYgc3R5bGU9ImJvcmRlcjpub25lO2JvcmRl
ci10b3A6c29saWQgI0UxRTFFMSAxLjBwdDtwYWRkaW5nOjMuMHB0IDBpbiAwaW4gMGluIj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPjxiPkZyb206PC9iPiBhbWQtZ2Z4ICZsdDthbWQtZ2Z4LWJvdW5j
ZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnJmd0Ow0KPGI+T24gQmVoYWxmIE9mIDwvYj5KYWNvYiBI
cmJlazxicj4NCjxiPlNlbnQ6PC9iPiAyMDIwL0phbnVhcnkvMzAsIFRodXJzZGF5IDEyOjE4IFBN
PGJyPg0KPGI+VG86PC9iPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxicj4NCjxiPlN1
YmplY3Q6PC9iPiBTdXNwZWN0aW5nIGNvcnJ1cHRlZCBWQklPUyBhZnRlciB1cGRhdGUgb2YgQU1E
R1BVIG9uIEFNRDc4NzA8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjxkaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCIgc3R5bGU9Im1hcmdpbi1ib3R0b206LjI1aW4iPjxiPjxzcGFuIHN0eWxlPSJm
b250LXNpemU6MTguMHB0O2ZvbnQtZmFtaWx5OiZxdW90O1RhaG9tYSZxdW90OyxzYW5zLXNlcmlm
O2NvbG9yOmJsYWNrIj5IZWxsbyw8L3NwYW4+PC9iPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTgu
MHB0O2ZvbnQtZmFtaWx5OiZxdW90O1RhaG9tYSZxdW90OyxzYW5zLXNlcmlmO2NvbG9yOmJsYWNr
Ij48bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9y
bWFsIiBzdHlsZT0ibWFyZ2luLWJvdHRvbTouMjVpbiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTox
OC4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7VGFob21hJnF1b3Q7LHNhbnMtc2VyaWY7Y29sb3I6Ymxh
Y2siPkkgYmVsaWV2ZSB0aGF0IHN5c3RlbSB1cGRhdGUgdGhhdCBpbmNsdWRlZCBhbWRncHUgb24g
ZGViaWFuIHRlc3RpbmcgKGJ1dCBpIGFtIG9uIExGUykgY29ycnVwdGVkIG15IFZCSU9TIG9uIEFN
RDc4NzAgKCYjNDM7LSA0IGhvdXJzIGFmdGVyDQogdGhlIHVwZGF0ZSB0aGUgR1BVIHVzaW5nIEFN
REdQVS9SYWRlb24gZHJpdmVycyByZXN1bHRlZCBpbiBubyBvdXRwdXQpLjxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtYXJn
aW4tYm90dG9tOi4yNWluIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE4LjBwdDtmb250LWZhbWls
eTomcXVvdDtUYWhvbWEmcXVvdDssc2Fucy1zZXJpZjtjb2xvcjpibGFjayI+aSdtIHNlbmRpbmcg
dGhpcyBlbWFpbCB0byBpbmZvcm0gYWJvdXQgcG9zc2libGUgYnVnIHdpdGggbXkgZmluZGluZ3Mg
b24NCjxhIGhyZWY9Imh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRmdpc3QuZ2l0aHViLmNvbSUyRktyZXlyZW4lMkYzZTU1ZTlh
NzU0ZTU4OTU2ZTE2OTBlMzhiMTg4OGRlNyZhbXA7ZGF0YT0wMiU3QzAxJTdDemhhbi5saXUlNDBh
bWQuY29tJTdDMDFlOWJjODI3OGE3NGM0ZDIxNWQwOGQ3YTVhYjY3ZDAlN0MzZGQ4OTYxZmU0ODg0
ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTYwMDI4MzUwNTE5NDQ5JmFtcDtzZGF0
YT1wSXFSNGJSMW01MEhORzhRU1ZCSnlwNzVaMlB0b1VnTkJiTGprbGlsdlJzJTNEJmFtcDtyZXNl
cnZlZD0wIj4NCmh0dHBzOi8vZ2lzdC5naXRodWIuY29tL0tyZXlyZW4vM2U1NWU5YTc1NGU1ODk1
NmUxNjkwZTM4YjE4ODhkZTc8L2E+IGFuZCBpIHdvdWxkIGFwcHJlY2lhdGUgYW55IGhlbHAgaW4g
ZXhjbHVkaW5nIFZCSU9TIGNvcnJ1cHRpb24gZnJvbSB0aGUgZGlhZ25vc3RpY3MuPG86cD48L286
cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PGI+PHNw
YW4gc3R5bGU9ImZvbnQtc2l6ZToxOC4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7VGFob21hJnF1b3Q7
LHNhbnMtc2VyaWY7Y29sb3I6YmxhY2siPlRoYW5rcyw8L3NwYW4+PC9iPjxzcGFuIHN0eWxlPSJm
b250LXNpemU6MTguMHB0O2ZvbnQtZmFtaWx5OiZxdW90O1RhaG9tYSZxdW90OyxzYW5zLXNlcmlm
O2NvbG9yOmJsYWNrIj48bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjE4LjBwdDtmb250LWZhbWls
eTomcXVvdDtUYWhvbWEmcXVvdDssc2Fucy1zZXJpZjtjb2xvcjpibGFjayI+LSBKYWNvYiBIcmJl
azxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0K
PC9ib2R5Pg0KPC9odG1sPg0K

--_000_DM5PR1201MB25540C0A23067345E620DA6C9E040DM5PR1201MB2554_--

--===============1856301281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1856301281==--
