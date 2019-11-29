Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D37CC432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B3721774
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B3721774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB17D6E894;
	Fri, 29 Nov 2019 08:13:24 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800070.outbound.protection.outlook.com [40.107.80.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C07176E894
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 08:13:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR1FMTNumFb+beeebwrHnGAUAheqrx94S6sp74Ls+Zjtn/qO8umcw3ChgGBJXRkYK5VMzJG4VoffZJS+H3QjQiCqpzndPliCl2tbGjjRuCpC/Xh+jiQlvwhfBuyrRoC7byFGJJ0WUyuc3rzaZpPKLY/tqKfZQt04iMMET0XaCp0Ul9qcCXhYtIb/QgJbl7qsgoQTQsPm5GcD/Gyxd8LfrOTgYDP0rbJr6SygM2daKbAWkF2Je9Z7yvI5BeFO/H9N7iRqfBbqr8X2GHyVRsO0jl2rIz/kF2VmD8gU9LJJDD/tp1E48lJcWb6EMRGiQZzJayB9KoSU4QBNGJVMd3mo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcAdqjhnbRZ9D7BvjNk/y9MS3CqLzneguQOwa5Bdabw=;
 b=nlngtS5md++0KeVQeAves48qfjQvFeSIiCDRQF1Ocqc3sZuasDedNikEZzum5WmRe8PMyUlFngMJGKBWrxDpjQeKfa3OoOw0KotcfXkXcGHn0vHPY2G8MKOHicIkd266TZE3q2QtviDqsP6e5RwbjBdAiw8XJn4RWr2w0s8LHClpm56IaVj5LjmbWIxR1bQjOpcI7BeoZ65qlbJlQ8hav87rfvq3NrEKTnE2PYdIIGe+jNBwJJjOyo/XygWBsE7g1uwLClFUgNBKhlVgI2tvkLrcXVeOj8GzXgfvkak7BLLFCQF8T5gT9qw+Yq96QwWdYdoh9aMbBQbBDhKuKVElhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB3213.namprd12.prod.outlook.com (20.179.81.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 29 Nov 2019 08:13:20 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5%3]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 08:13:20 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/5] drm/amdgpu: do autoload right after MEC loaded for
 SRIOV VF
Thread-Topic: [PATCH 3/5] drm/amdgpu: do autoload right after MEC loaded for
 SRIOV VF
Thread-Index: AQHVpE+6OFp3RqEVEU2buxGtwbSBnaef3G9wgAHtX0CAAAUAAIAAAkLQ
Date: Fri, 29 Nov 2019 08:13:20 +0000
Message-ID: <MN2PR12MB3933E4996B045F4344B0124484460@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
 <1574769024-30611-3-git-send-email-Monk.Liu@amd.com>
 <MN2PR12MB393364068B1A041D93BC826D84470@MN2PR12MB3933.namprd12.prod.outlook.com>
 <MN2PR12MB39331072231F411D4150DD1984460@MN2PR12MB3933.namprd12.prod.outlook.com>
 <DM5PR12MB141846521D3423CFB02A04A0FC460@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB141846521D3423CFB02A04A0FC460@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-11-29T08:05:01Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7ffbf357-3251-4b5c-83c6-00005802e6f7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 335e1b90-4b6d-4001-fc49-08d774a3ff55
x-ms-traffictypediagnostic: MN2PR12MB3213:|MN2PR12MB3213:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3213D21912584EE86849E59784460@MN2PR12MB3213.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(13464003)(189003)(199004)(76176011)(102836004)(53546011)(6506007)(52536014)(7696005)(110136005)(446003)(186003)(11346002)(33656002)(316002)(99286004)(26005)(71190400001)(71200400001)(6246003)(86362001)(256004)(14444005)(55016002)(6306002)(9686003)(6436002)(3846002)(14454004)(6116002)(966005)(229853002)(2906002)(8936002)(76116006)(8676002)(81156014)(81166006)(478600001)(74316002)(305945005)(7736002)(66476007)(66446008)(6636002)(45080400002)(25786009)(5660300002)(66066001)(64756008)(66946007)(2501003)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3213;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HJR8bBU9kk/CLSrbZx2Zlk8q1FB5Dbzk2e8MfH60PfIfMqvvDdit0gsGIrEp58/RtB3CWSTwPGFXf4AnrDbgLYcTwHGkRUnI/4y64upGWqWACvTb3AXOmc4J8Kp/SiLBG/KdJeJNXUfEFSJaRtcCHYjIippUfNROTq06HtKsWrVQPd3D3/DVmY1CYTPO41JSP82k8ev/iT1W+QJ/LuWzsHluYtpX1NSCeVOu6lN2c6gUeDzAV7nOnLLMmDWTI5x7+I08Qx1780Qd9AveKGuK2y3CVZ/7AG2kPdDoIS+ViCIaqodfcmb5T8wnc5fSthYfCtaP4tZA/APw4cPXkPYGiK3qh0BlCBnixFpGaNPEC+pUb0LUHin31Ul2wvgJU1F0hwoWtzWh8XsRn8tuEtg21/4yspWUStsEVqVATbJMCSC4b0r5WcYqih30Nai8QBGErwu7RR1S1JgwLKR8RUkLM8UvjORJiWGZTqul8YhQNbw=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335e1b90-4b6d-4001-fc49-08d774a3ff55
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 08:13:20.6712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t8ZUOgTmTMFblu+A6yBzdUmGabeie4ufF+poy3D0LIGrenk8Y7ZxQM5HIMpPFe+L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3213
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcAdqjhnbRZ9D7BvjNk/y9MS3CqLzneguQOwa5Bdabw=;
 b=EtWlrY2p4wqVPLJOUs7NRam/J0EFimv7odyG0BiHUf7jvSS73oVcZgG3oTkRTJVYtMY52rHtRDQrejK6pgbdrwYzF2X752CUwlhLACQqAjpgsTDkjnCxN8DJyekyO5AQUDsq1nyPwhKeYsWtzOcSqLTbyCoCf6/L8RIgEDrlh2A=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T2theSwgd2lsbCBkbw0KDQpUaGFua3MgDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCk1vbmsgTGl1fEdQVSBWaXJ0dWFsaXphdGlvbiBUZWFtIHxBTUQNCg0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhh
bmdAYW1kLmNvbT4gDQpTZW50OiBGcmlkYXksIE5vdmVtYmVyIDI5LCAyMDE5IDQ6MDUgUE0NClRv
OiBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KU3Vi
amVjdDogUkU6IFtQQVRDSCAzLzVdIGRybS9hbWRncHU6IGRvIGF1dG9sb2FkIHJpZ2h0IGFmdGVy
IE1FQyBsb2FkZWQgZm9yIFNSSU9WIFZGDQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRl
cm5hbCBEaXN0cmlidXRpb24gT25seV0NCg0KSXQgc2VlbXMgdG8gbWUgdGhpcyBpcyBvbmUgbGlu
ZSBjb2RlIHRoYXQgbW9yZSB0aGFuIDgwIGNoYXJhY3RlcnMuIFBsZWFzZSBraW5kbHkgc3BsaXQg
aXQgdG8gc2V2ZXJhbCBvbmVzLg0KT3RoZXIgdGhhbiB0aGF0LCB0aGUgUGF0Y2ggaXMNCg0KUmV2
aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KUmVnYXJk
cywNCkhhd2tpbmcNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExpdSwgTW9u
ayA8TW9uay5MaXVAYW1kLmNvbT4gDQpTZW50OiAyMDE55bm0MTHmnIgyOeaXpSAxNTo0OA0KVG86
IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnOyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSCAz
LzVdIGRybS9hbWRncHU6IGRvIGF1dG9sb2FkIHJpZ2h0IGFmdGVyIE1FQyBsb2FkZWQgZm9yIFNS
SU9WIFZGDQoNCkBaaGFuZywgSGF3a2luZ0BEZXVjaGVyLCBBbGV4YW5kZXINCg0KQ2FuIHlvdSBo
ZWxwIHRvIHJldmlldyBpdCBmb3IgbWUgPyANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KTW9uayBMaXV8R1BVIFZpcnR1YWxpemF0aW9uIFRlYW0gfEFNRA0KDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgTGl1LCBNb25rDQpTZW50OiBUaHVy
c2RheSwgTm92ZW1iZXIgMjgsIDIwMTkgMTA6MjIgQU0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KU3ViamVjdDogUkU6IFtQQVRDSCAzLzVdIGRybS9hbWRncHU6IGRvIGF1dG9s
b2FkIHJpZ2h0IGFmdGVyIE1FQyBsb2FkZWQgZm9yIFNSSU9WIFZGDQoNCnBpbmcNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCk1vbmsgTGl1fEdQVSBWaXJ0dWFsaXphdGlv
biBUZWFtIHxBTUQNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTW9uayBM
aXUgPE1vbmsuTGl1QGFtZC5jb20+IA0KU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMjYsIDIwMTkg
Nzo1MCBQTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogTGl1LCBNb25r
IDxNb25rLkxpdUBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIIDMvNV0gZHJtL2FtZGdwdTogZG8g
YXV0b2xvYWQgcmlnaHQgYWZ0ZXIgTUVDIGxvYWRlZCBmb3IgU1JJT1YgVkYNCg0Kc2luY2Ugd2Ug
ZG9uJ3QgaGF2ZSBSTENHIHVjb2RlIGxvYWRpbmcgYW5kIG5vIFNSbGlzdCBhcyB3ZWxsDQoNClNp
Z25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgMyArLS0NCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcHNwLmMNCmluZGV4IDk2YTZiMDAuLmI2NWZkYTkgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KQEAgLTE0OTAsOCArMTQ5MCw3IEBAIHN0YXRpYyBp
bnQgcHNwX25wX2Z3X2xvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApDQogCQkJcmV0dXJuIHJl
dDsNCiANCiAJCS8qIFN0YXJ0IHJsYyBhdXRvbG9hZCBhZnRlciBwc3AgcmVjaWV2ZWQgYWxsIHRo
ZSBnZnggZmlybXdhcmUgKi8NCi0JCWlmIChwc3AtPmF1dG9sb2FkX3N1cHBvcnRlZCAmJiB1Y29k
ZS0+dWNvZGVfaWQgPT0NCi0JCQlBTURHUFVfVUNPREVfSURfUkxDX1JFU1RPUkVfTElTVF9TUk1f
TUVNKSB7DQorCQlpZiAocHNwLT5hdXRvbG9hZF9zdXBwb3J0ZWQgJiYgdWNvZGUtPnVjb2RlX2lk
ID09IChhbWRncHVfc3Jpb3ZfdmYoYWRldikgPyBBTURHUFVfVUNPREVfSURfQ1BfTUVDMiA6IEFN
REdQVV9VQ09ERV9JRF9STENfUkVTVE9SRV9MSVNUX1NSTV9NRU0pKSB7DQogCQkJcmV0ID0gcHNw
X3JsY19hdXRvbG9hZChwc3ApOw0KIAkJCWlmIChyZXQpIHsNCiAJCQkJRFJNX0VSUk9SKCJGYWls
ZWQgdG8gc3RhcnQgcmxjIGF1dG9sb2FkXG4iKTsNCi0tIA0KMi43LjQNCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0
DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0
b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdD
bW9uay5saXUlNDBhbWQuY29tJTdDMGJjNjc0ZGRmMWM5NGJhODMxZmEwOGQ3NzNhOWIwZWQlN0Mz
ZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTA1MDQ0OTkwMjU1
MDAwJmFtcDtzZGF0YT1rdnNaZGtvJTJGUUFYSWlaQ1AxOXdvJTJCeEVJU0xxRXc3dE1hRk8wZHZ4
VTVFdyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
