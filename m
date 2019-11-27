Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1DAC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 03:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707D1206CC
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 03:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707D1206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0283B6E23D;
	Wed, 27 Nov 2019 03:24:17 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800082.outbound.protection.outlook.com [40.107.80.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D9F96E23D
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 03:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7At6Ki1xqTAPy+8syOmACU3ibD5h9NodLDv1lzNlyVObWyYZKcUkmx2+5WqTdrzo9vnDk8TElzb+qq8Sb5FE4rJMF3RDzfynstt1I3MNOYTC5SvJECltdSH4sUGDPWqWLe6AAekh19jK7IHQQ/Ks8C2lshT2cbIHwgDrgcbkYHSJYk/leVlYUHUrDZ+VhRajVF/JVfuwyZNzPtUhkmljfAwugsJBQWw2nN8JT6uE61OoC8LsK5FU9txxwVooBqZmF4pbunp/Ehym+8DkEE7utLYQsqH9+B9Xpj5nfx6VEkgKY+ANvjWtwOUcNu3wEiEeWCVhwSTjl6heYjhVR7EIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wnFYoxl0jaUvEFkkV1Y4LjSHwMycawGe9yhQ5db8ik=;
 b=RmTEQnoFzQtrQsURtBfhcsyXxE3Fk5hf9zNMQr8zJt+rXvgqrDOXBX0xKH/1dTBB1Vp9jeMWY2wlucParZo3odALT/uA7tQbpkpT48ZrSp/Gv7OIqkbcBZiDbZCbyXrlasowq4jLJ6rPguSwjxWQg2aps5iRobT3Q0I2vM+58icYm5dAMD120hK/kBFLL+D8O2dadNfNdCmVtc6lv88A+4Nu63WK6GixzGtdsR5Z+eY5SEcqrmUqn66w6lCPwdXe5pAsZz+ZFI7NZKSdwej7f1oxlWXOLfhkj3jm8J5B3QYUlfTDMaHT/Yy6XJJ6FLLI1Qk+Axyes8QIKDH1tbyXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1130.namprd12.prod.outlook.com (10.168.237.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Wed, 27 Nov 2019 03:24:12 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 03:24:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/gfx: Clear more EDC cnt
Thread-Topic: [PATCH 1/2] drm/amdgpu/gfx: Clear more EDC cnt
Thread-Index: AQHVpJBvNaRlCubNhEKJjQN1kRS6DKeeVo4Q
Date: Wed, 27 Nov 2019 03:24:12 +0000
Message-ID:
 <DM5PR12MB1418C276613502A0CD12F1B6FC440@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1574796818-11648-1-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1574796818-11648-1-git-send-email-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-11-27T03:24:06Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e1d636bb-b5d8-4af9-8e4a-00002c01b6dc;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-11-27T03:24:06Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 431469a2-e1f5-44b9-a7b4-00001f8a82dd
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca6003d8-77eb-41ba-e2d6-08d772e9460c
x-ms-traffictypediagnostic: DM5PR12MB1130:|DM5PR12MB1130:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1130420179A988EF76103385FC440@DM5PR12MB1130.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(13464003)(81166006)(3846002)(8936002)(5660300002)(74316002)(33656002)(71190400001)(71200400001)(66446008)(66946007)(64756008)(66556008)(66476007)(76116006)(6116002)(26005)(102836004)(66066001)(316002)(53546011)(446003)(229853002)(6506007)(966005)(45080400002)(6436002)(14454004)(110136005)(256004)(186003)(6306002)(11346002)(55016002)(2501003)(6246003)(99286004)(76176011)(52536014)(7696005)(478600001)(14444005)(2906002)(25786009)(81156014)(8676002)(7736002)(305945005)(9686003)(86362001)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1130;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aXEVP6Pek2dQUmLOHz1PUv5urR+Nr6SpDZenG9zbgfe+5q/vKmbSQmxhhh2t1grsPSoHAuFOms/Qy9Zi+2OL4CKEp65sXIC248FIqDmovD0JID/1TB0BLcocEZDYgeK1QHtveBJeGcclYEPuroG+FIUen0iIwX2Ncvd2mZbRFz8FFEj5HNSHrqUKbuwBHJ9B+lfu7ty3bc3/7IvZaAA39WVn/H+GmzNpSQtSVzZrsPO5X/8714xDRAjWo1BNkuiDWMmj2NTe5kYs+UbX9W5os1W0V39sAuDd18XsoiZr4wVhZ2TJwg0T//MgnPHoIyMx76txF/dD9n9WQNpl+BRz1WhH/IVXJMLn0hzgRA8D2Cj5/HSv5E6zJy4VyaAaAzgvQz5sDgMtyXe4o6hTw1/GRz6cljxM91zqYcXbg3LdePgOmkgYob7s/Zl95NTfC+dUmx6RYhk+aPbIaqve4rvb05PuqCEpCYOQBz5LeMAeo8E=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6003d8-77eb-41ba-e2d6-08d772e9460c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 03:24:12.3151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0J8AfAoQGUtGxhAfFvbOsTVed94rb2XUL74x16KeS21TVoQCu3giY7FCiM5MP1Z6F+SFnqQ+PS9xiqnX2NVblQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1130
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wnFYoxl0jaUvEFkkV1Y4LjSHwMycawGe9yhQ5db8ik=;
 b=xia5fkjHSUHTK/7L8us+HSTIjhyJLqfs0dVSM7mr1dSTnhAgN7boFKdCDagUVOepCV0anOpWDbkOFdIW+685KParVGyMYjKRZgVLf0GfDnDYJ7IXVVQCQI6R+znULdo9RDBMWTprYLZU95q/JRlD8Uvl/8Oqn7CLsZnsCuENtfo=
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
Cc: "Zhu, James" <James.Zhu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127032412.NAGOZylKcrbXhDtahasGU-Q5wMYyknAVjdIruE3EhPI@z>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
aSBKYW1lcywNCg0KQXJjdHVydXMgYW5kIHZnMjAgaGF2ZSBkaWZmZXJlbnQgU0RNQSBpbnN0YW5j
ZXMgc28gdGhhdCB0aGUgY29tbW9uIGVkYyBjb3VudGVyIGFycmF5IGNhbid0IGNvdmVyIGJvdGgg
QVNJQ3MuIFRoZSBlZGMgY291bnRlciBpbml0aWFsaXphdGlvbiBoYXMgdG8gYmUgZWl0aGVyIGtl
ZXBpbmcgaW4gSVAgc3BlY2lmaWMgZWNjIGxhdGUgaW5pdCBvciB1c2luZyBkaWZmZXJlbnQgcmVn
cyBhcnJheS4NCg0KU2luY2UgZXJyb3IgaW5qZWN0aW9uIGlzIG5vdCBzdXBwb3J0ZWQgYnkgU0RN
QS9IRFAvU0VNIGluIFZHMjAgYW5kIEFyY3R1cnVzLCB0aGVyZSBpcyBhY3R1YWxseSBubyB3YXkg
dG8gdmFsaWRhdGUgRURDIGZvciBhbGwgdGhlIE9TUyBibG9ja3MuIEFzIHlvdSBtYXkgbm90aWNl
IHRoYXQsIGRyaXZlciBkb2Vzbid0IGxvZyBhbnkgZWRjIGNvdW50ZXIgZm9yIGFueSBvZiBPU1Mg
YmxvY2tzIGFuZCBleHBvc2UgdGhpcyB0byB0aGUgdXNlcnMuDQoNClJlZ2FyZHMsDQpIYXdraW5n
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3Vu
Y2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEphbWVzIFpodQ0KU2VudDog
MjAxOeW5tDEx5pyIMjfml6UgMzozNA0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQpDYzogWmh1LCBKYW1lcyA8SmFtZXMuWmh1QGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggMS8y
XSBkcm0vYW1kZ3B1L2dmeDogQ2xlYXIgbW9yZSBFREMgY250DQoNCkNsZWFyIFNETUEgYW5kIEhE
UCBFREMgY291bnRlciBpbiBHUFIgd29ya2Fyb3VuZHMuDQoNClNpZ25lZC1vZmYtYnk6IEphbWVz
IFpodSA8SmFtZXMuWmh1QGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjlfMC5jIHwgNSArKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQppbmRleCBjOGFjZTUxLi5kYzM4
ZGY4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0K
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KQEAgLTQ4LDYgKzQ4
LDggQEANCiANCiAjaW5jbHVkZSAiYW1kZ3B1X3Jhcy5oIg0KIA0KKyNpbmNsdWRlICJzZG1hMC9z
ZG1hMF80XzBfb2Zmc2V0LmgiDQorI2luY2x1ZGUgInNkbWExL3NkbWExXzRfMF9vZmZzZXQuaCIN
CiAjZGVmaW5lIEdGWDlfTlVNX0dGWF9SSU5HUyAgICAgMQ0KICNkZWZpbmUgR0ZYOV9NRUNfSFBE
X1NJWkUgNDA5Ng0KICNkZWZpbmUgUkxDR19VQ09ERV9MT0FESU5HX1NUQVJUX0FERFJFU1MgMHgw
MDAwMjAwMEwgQEAgLTQwMjksNiArNDAzMSw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc29jMTVf
cmVnX2VudHJ5IHNlY19kZWRfY291bnRlcl9yZWdpc3RlcnNbXSA9IHsNCiAgICB7IFNPQzE1X1JF
R19FTlRSWShHQywgMCwgbW1UQ0NfRURDX0NOVDIpLCAwLCAxLCAxNn0sDQogICAgeyBTT0MxNV9S
RUdfRU5UUlkoR0MsIDAsIG1tVENBX0VEQ19DTlQpLCAwLCAxLCAyfSwNCiAgICB7IFNPQzE1X1JF
R19FTlRSWShHQywgMCwgbW1TUUNfRURDX0NOVDMpLCAwLCA0LCA2fSwNCisgICB7IFNPQzE1X1JF
R19FTlRSWShTRE1BMCwgMCwgbW1TRE1BMF9FRENfQ09VTlRFUiksIDAsIDEsIDF9LA0KKyAgIHsg
U09DMTVfUkVHX0VOVFJZKFNETUExLCAwLCBtbVNETUExX0VEQ19DT1VOVEVSKSwgMCwgMSwgMX0s
DQorICAgeyBTT0MxNV9SRUdfRU5UUlkoSERQLCAwLCBtbUhEUF9FRENfQ05UKSwgMCwgMSwgMX0s
DQogfTsNCiANCiBzdGF0aWMgaW50IGdmeF92OV8wX2RvX2VkY19nZHNfd29ya2Fyb3VuZHMoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQotLQ0KMi43LjQNCg0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
JTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDaGF3a2lu
Zy56aGFuZyU0MGFtZC5jb20lN0MyMTkzYThhNDkzZmU0OGQzMTAwYTA4ZDc3MmE3OGZhMCU3QzNk
ZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxMDM5MzYzMjY3ODgx
NDgmYW1wO3NkYXRhPURlT0M1eThlUFp2MlR4aEc5bkQyZUtLa3V0TVNndENLQzB0SU5Vdlhydmcl
M0QmYW1wO3Jlc2VydmVkPTAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
