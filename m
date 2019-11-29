Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8180C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B280D21721
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B280D21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 665A56E897;
	Fri, 29 Nov 2019 08:05:14 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680049.outbound.protection.outlook.com [40.107.68.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 282F56E894
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 08:05:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+ktUM47iR7fwSm5U4N4gMwaYlZZQfckiLSgwCIV/73yFdKEwSTzx2D7wQfmkoc41+VdfwjdzQKKJcwBVndWk1YqefFvEzmCxO1DobefcaI0CqJqoxW8G8PgncyLJbJUanXLwwz7GyCbsy8kUM9wBe+zcRFPLCPjWCBjeQUJExrXweUnpr58BWytDzis7y1BrA7W4/pLF2CBUZ966TGwMvJ+KJsM3mn8IkB9OeabsKZEIljGTJresrngKbo88ZkXYLasm2KoYLXO8OgemAm92gvEWXH6NIC7zW3n7qsAv09aw9ZdyKpTICDhNGsi89ER6+RSJ79KnT5t4FaZcz/g+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niKTUzEpsBJ+gTOzo/n/aXmcygFZqrm8Zt2ETnQnnP8=;
 b=f2DmPI8dNzhsVCpJSWrFIwN6AaA0voj4+on8rhoLq7CWQWZWy33AM+re6g3Hd96/eAmZdhNJunzKktI61Ja4uo9z/v1xZxwPIKem13b+iZiJCZqpHS8BDke/0cbqlrzB3wpoB4xdLL+bd5mb2IpYjTICtsbbjmNbdL40nffCkYDJUEbzzjLUM+bBACDyPnqWWaPNzne9kvo1mvBr8uf8WwLcBdjP2TZZtJwX/JOl3lY/Zz5zh05gjqCXKqljrSjlQVPW2iHJ9aQ1tanFe9Pps0JmKKpAJ2ptzjSKadXC60r2Z1WDrOuq/e8+wwoULQJ/v0lflDnVi1Ks48TYb2XImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1529.namprd12.prod.outlook.com (10.172.33.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 08:05:08 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 08:05:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/5] drm/amdgpu: do autoload right after MEC loaded for
 SRIOV VF
Thread-Topic: [PATCH 3/5] drm/amdgpu: do autoload right after MEC loaded for
 SRIOV VF
Thread-Index: AQHVpE+7aeAS9aiWbkuWcCbXK5lVLKef3HiAgAHtawCAAALy4A==
Date: Fri, 29 Nov 2019 08:05:08 +0000
Message-ID: <DM5PR12MB141846521D3423CFB02A04A0FC460@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
 <1574769024-30611-3-git-send-email-Monk.Liu@amd.com>
 <MN2PR12MB393364068B1A041D93BC826D84470@MN2PR12MB3933.namprd12.prod.outlook.com>
 <MN2PR12MB39331072231F411D4150DD1984460@MN2PR12MB3933.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB39331072231F411D4150DD1984460@MN2PR12MB3933.namprd12.prod.outlook.com>
Accept-Language: en-US
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-11-29T08:05:01Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a5387852-90cb-4f8c-9985-00007df46f67
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 03e4e9ef-4d23-4700-60c7-08d774a2d9dc
x-ms-traffictypediagnostic: DM5PR12MB1529:|DM5PR12MB1529:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1529D6541211D19F15B669E0FC460@DM5PR12MB1529.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(13464003)(189003)(199004)(186003)(6506007)(6116002)(71200400001)(102836004)(5660300002)(26005)(71190400001)(2501003)(53546011)(6636002)(229853002)(55016002)(6306002)(6246003)(52536014)(9686003)(7736002)(66946007)(76176011)(305945005)(7696005)(6436002)(86362001)(64756008)(66446008)(66476007)(66556008)(25786009)(446003)(11346002)(33656002)(74316002)(45080400002)(316002)(14444005)(81166006)(110136005)(3846002)(76116006)(81156014)(8676002)(256004)(966005)(478600001)(66066001)(14454004)(99286004)(2906002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1529;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SHSOGBNIcOh1XDpQSn6DGiHao9GLxAJzvAlfD5lqMUPKAzN0YS1wjsCSLXfgV56j4kDRc4pWXjZO4PuKpU8eVVz+9PGWep1dCFjQZxeOGbwjlpjBoKZGgsa79kAVNNtPgU0Q/vWOJFyMLOnk+kCsiIGwmcBb7+O9sX/bruXznTfq5FIRQ2AGCc5xe8/JmjMZ+3UN7sLfug9nxOxyC15Nyumj12BMdYa4H1aRZ0TH9CwGxb/9sDyTyBGI9EX7WZBvP+VQKVqoC2Mj73iGWXBe/VH76Nrwl+baYjvquWUxNO/CP8HULlOo23hDNF+jlT07t0NeHUHGV5en3rbXGkJghPccFSIsCCv5VPOuyRlIns3maQ3VpKGg4BNr4PNqO42uzUgvehoo1dfzazLGzN1ON6oyHAN6z6OLjN0QR5d5i/NA0AtBNnAvNXlC5AhdVm2MsnibXY0eIZvckXlf1r07wuIdzUuoIUtKYdE2XvUwkmY=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e4e9ef-4d23-4700-60c7-08d774a2d9dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 08:05:08.3537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RrMoT52fURE3tTw7WWvsFeLvun3OMLIlFKURaiTCrvZoUCso8PjIRGLqZbVsV0TSkmysbpGZBUDxapi9IbJuZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1529
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niKTUzEpsBJ+gTOzo/n/aXmcygFZqrm8Zt2ETnQnnP8=;
 b=yXwrdF0bY7GnGWE0/nKvw30p/l/YFf1yJEk/Ed+6iBdeA5bbjgn5YcgnZxonzac5rQLXrQ9r7HnWjYcP9BFxmpszMU8uHbD6Njz9Km6tiffD5LB2FU/2bKpqIkJ3jkmCUTl9/t8RBKVCFacUfNj72+evBazANNx1B6Kf1VMA6sg=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpJ
dCBzZWVtcyB0byBtZSB0aGlzIGlzIG9uZSBsaW5lIGNvZGUgdGhhdCBtb3JlIHRoYW4gODAgY2hh
cmFjdGVycy4gUGxlYXNlIGtpbmRseSBzcGxpdCBpdCB0byBzZXZlcmFsIG9uZXMuDQpPdGhlciB0
aGFuIHRoYXQsIHRoZSBQYXRjaCBpcw0KDQpSZXZpZXdlZC1ieTogSGF3a2luZyBaaGFuZyA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPg0KDQpSZWdhcmRzLA0KSGF3a2luZw0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPiANClNlbnQ6
IDIwMTnlubQxMeaciDI55pelIDE1OjQ4DQpUbzogTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29t
PjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5nLCBIYXdraW5nIDxIYXdraW5n
LlpoYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQpTdWJqZWN0OiBSRTogW1BBVENIIDMvNV0gZHJtL2FtZGdwdTogZG8gYXV0b2xvYWQg
cmlnaHQgYWZ0ZXIgTUVDIGxvYWRlZCBmb3IgU1JJT1YgVkYNCg0KQFpoYW5nLCBIYXdraW5nQERl
dWNoZXIsIEFsZXhhbmRlcg0KDQpDYW4geW91IGhlbHAgdG8gcmV2aWV3IGl0IGZvciBtZSA/IA0K
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpNb25rIExpdXxHUFUgVmly
dHVhbGl6YXRpb24gVGVhbSB8QU1EDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJl
aGFsZiBPZiBMaXUsIE1vbmsNClNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAyOCwgMjAxOSAxMDoy
MiBBTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSRTogW1BB
VENIIDMvNV0gZHJtL2FtZGdwdTogZG8gYXV0b2xvYWQgcmlnaHQgYWZ0ZXIgTUVDIGxvYWRlZCBm
b3IgU1JJT1YgVkYNCg0KcGluZw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KTW9uayBMaXV8R1BVIFZpcnR1YWxpemF0aW9uIFRlYW0gfEFNRA0KDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4gDQpTZW50
OiBUdWVzZGF5LCBOb3ZlbWJlciAyNiwgMjAxOSA3OjUwIFBNDQpUbzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCkNjOiBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+DQpTdWJqZWN0
OiBbUEFUQ0ggMy81XSBkcm0vYW1kZ3B1OiBkbyBhdXRvbG9hZCByaWdodCBhZnRlciBNRUMgbG9h
ZGVkIGZvciBTUklPViBWRg0KDQpzaW5jZSB3ZSBkb24ndCBoYXZlIFJMQ0cgdWNvZGUgbG9hZGlu
ZyBhbmQgbm8gU1JsaXN0IGFzIHdlbGwNCg0KU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsu
TGl1QGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNw
LmMgfCAzICstLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3Au
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KaW5kZXggOTZhNmIw
MC4uYjY1ZmRhOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9wc3AuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQpA
QCAtMTQ5MCw4ICsxNDkwLDcgQEAgc3RhdGljIGludCBwc3BfbnBfZndfbG9hZChzdHJ1Y3QgcHNw
X2NvbnRleHQgKnBzcCkNCiAJCQlyZXR1cm4gcmV0Ow0KIA0KIAkJLyogU3RhcnQgcmxjIGF1dG9s
b2FkIGFmdGVyIHBzcCByZWNpZXZlZCBhbGwgdGhlIGdmeCBmaXJtd2FyZSAqLw0KLQkJaWYgKHBz
cC0+YXV0b2xvYWRfc3VwcG9ydGVkICYmIHVjb2RlLT51Y29kZV9pZCA9PQ0KLQkJCUFNREdQVV9V
Q09ERV9JRF9STENfUkVTVE9SRV9MSVNUX1NSTV9NRU0pIHsNCisJCWlmIChwc3AtPmF1dG9sb2Fk
X3N1cHBvcnRlZCAmJiB1Y29kZS0+dWNvZGVfaWQgPT0gKGFtZGdwdV9zcmlvdl92ZihhZGV2KSA/
IEFNREdQVV9VQ09ERV9JRF9DUF9NRUMyIDogQU1ER1BVX1VDT0RFX0lEX1JMQ19SRVNUT1JFX0xJ
U1RfU1JNX01FTSkpIHsNCiAJCQlyZXQgPSBwc3BfcmxjX2F1dG9sb2FkKHBzcCk7DQogCQkJaWYg
KHJldCkgew0KIAkJCQlEUk1fRVJST1IoIkZhaWxlZCB0byBzdGFydCBybGMgYXV0b2xvYWRcbiIp
Ow0KLS0gDQoyLjcuNA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQpodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8l
MkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0Ntb25rLmxpdSU0MGFtZC5jb20lN0MwYmM2NzRk
ZGYxYzk0YmE4MzFmYTA4ZDc3M2E5YjBlZCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUx
ODNkJTdDMCU3QzAlN0M2MzcxMDUwNDQ5OTAyNTUwMDAmYW1wO3NkYXRhPWt2c1pka28lMkZRQVhJ
aVpDUDE5d28lMkJ4RUlTTHFFdzd0TWFGTzBkdnhVNUV3JTNEJmFtcDtyZXNlcnZlZD0wDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
