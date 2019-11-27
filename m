Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79D1C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 03:26:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E6A206CC
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 03:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E6A206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FFAB6E25E;
	Wed, 27 Nov 2019 03:26:49 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800084.outbound.protection.outlook.com [40.107.80.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C596E25E
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 03:26:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPvZX1VSv5cTIR9lbtTno1cjsTW22f+YEIyJij1S8u55cmcjN4Qiq5LqJAAhbQZWpEcnOhEnZf6CUZgtG9iaYhjqBemVpXcNA1vJqsm6N77QIKihKe4KRaet/nQsBVh8ecdgtaemmySss3ARwRxRp9W+/PFTSITEeKI56cmWITls13/2giE0VISHgFerdvnHK2OODpIcxFHh+rz1ZYhrlv/7NnVqDLIzN9eCoilwUWS5oLpXsKRq+Y6w9Z12VNoAaMkDVFblkN//bsENHB7+MOfCJDedfKpQo0nqT4CeD/KCiQsPfXI7jBRG5yKG2xXPAkb4m30N44IJcYURNQzWfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3JuHBKdnOzsNv74FeKnttpR1aAdxmpGjwGZasHsF1I=;
 b=Seh+54htvqG+932pXpk0QTfFhraDFx/JC4bRnMaU5io4nqM8mEnfvBziCdjOVhIKW/yBJyMCiUTo1yjvutWt3IsPZ4S9XpgtReT/2yJG/01rb16dotkKt/DmZ7h1g3Fb0ehupUZOeiNHYr5NJ5fLmwWQj42RpEDIEKNNIYLbuL2j1wwr2Lz/wH9MIeTwv8CaDij8pvvwIBKBGLusAJ4YZXvYE4/HXZwsfBHFAw/XqLsv8GErOJ2DSErknh6F1EiFV+LaeP5bRTRdswIXizhLnvmXOMeD3J5tWwacJ3eDFxZcd/0wy2hfD11J1AD9w7IyBVEw8zZpNVGbntpmkAdnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1130.namprd12.prod.outlook.com (10.168.237.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Wed, 27 Nov 2019 03:26:46 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 03:26:46 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/gfx: Increase dispatch packet number
Thread-Topic: [PATCH 2/2] drm/amdgpu/gfx: Increase dispatch packet number
Thread-Index: AQHVpJBvtQv0TQGfSUCnVGkUbx/miqeeW70Q
Date: Wed, 27 Nov 2019 03:26:46 +0000
Message-ID:
 <DM5PR12MB1418C5D00FB01059A9C13D5CFC440@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1574796818-11648-1-git-send-email-James.Zhu@amd.com>
 <1574796818-11648-2-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1574796818-11648-2-git-send-email-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-11-27T03:26:43Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e32ada13-ca97-48c4-8de5-00006e7ebc12;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-11-27T03:26:43Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4f50b458-ee69-438a-b36f-0000b839955b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 465685f7-7d60-4bd6-d675-08d772e9a220
x-ms-traffictypediagnostic: DM5PR12MB1130:|DM5PR12MB1130:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1130F2A7AF15D5FCA9FA0B6BFC440@DM5PR12MB1130.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:457;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(13464003)(81166006)(3846002)(8936002)(5660300002)(74316002)(33656002)(71190400001)(71200400001)(66446008)(66946007)(64756008)(66556008)(66476007)(76116006)(6116002)(26005)(102836004)(66066001)(316002)(53546011)(446003)(229853002)(6506007)(966005)(45080400002)(6436002)(14454004)(110136005)(256004)(186003)(6306002)(11346002)(55016002)(2501003)(6246003)(99286004)(76176011)(52536014)(7696005)(478600001)(2906002)(25786009)(81156014)(8676002)(7736002)(305945005)(9686003)(86362001)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1130;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: inrfxl0TKUnPuPQVziwJl9eql4rz9vJmxqIfwuRZkOeKpEvZEpEwGlxEFQi+jOtJYe24yyextR5tUSRRdkZfZFCKNoYL0kchYM+xjdBgVjBftR9sFm5W35uDnCA3c9mBRpKlHTgjG+mmFpwz4LtgppbNFJo+CxWJVY9JwSIlnfU6iswMpJcyf0vQpTtkLB3aWMQQRhiDbHQGpzLfA/pQhHoJ45/S9d3u3Hqx0OCQA1nc4Fqyotwv/kkZ2FlI8k/td+JVaFPtcmQxjMJinWW2yoQPw3t7OPIqaistpyq4Vb/GB81oDh8kvOPCnMj26JzsKLywbg+lpJ4Am71W9zV6rCYfzg2XyZeVq44Zx0fPCImsoe6kLQq+RgBq5XSmbe47XODnb9g/hM4giJz7dTCWXI4xPn4+bd6Htf6ovwxZLTZWnrQ071RkvXeWlRswS6oHRgxD08iDkcmY1lJ17u9cSykd0g37obBJ9Oyp/Ayv7TU=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465685f7-7d60-4bd6-d675-08d772e9a220
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 03:26:46.7092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGFVY+Scl6L64iZF43i/OwnZAw+tG0zDqp3iO8uwzzG97N4Q4L/IIZP494btw0z4RFoAq7y4Rk9NADwfqn/U2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1130
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3JuHBKdnOzsNv74FeKnttpR1aAdxmpGjwGZasHsF1I=;
 b=nWCso8MJSjYGHW1B7FJ8mJaogU7SnXEZJaOSCaSxuCU/SvxoimFe3emvxgl2am5YcsQy98t14IjaaiJVWxeqlhsXWeatCHGXIhhKF+IJRtGYb/8eWRGl4cUdb+B1ibEZ37JlAdGLFy6eAVieru752PsdVt3qyyjz3reMIsADCw8=
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
Message-ID: <20191127032646.0MR_P0EsUvkqvup5JMZeWT81sXHTt2liqwjNHIVAetE@z>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpU
aGUgUGF0Y2ggaXMNCg0KUmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdA
YW1kLmNvbT4NCg0KUmVnYXJkcywNCkhhd2tpbmcNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBP
biBCZWhhbGYgT2YgSmFtZXMgWmh1DQpTZW50OiAyMDE55bm0MTHmnIgyN+aXpSAzOjM0DQpUbzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBaaHUsIEphbWVzIDxKYW1lcy5aaHVA
YW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSCAyLzJdIGRybS9hbWRncHUvZ2Z4OiBJbmNyZWFzZSBk
aXNwYXRjaCBwYWNrZXQgbnVtYmVyDQoNCkZvciBBcmN0dXJ1cywgaW5jcmVhc2UgZGlzcGF0Y2gg
cGFja2V0IG51bWJlciB0byBzdHJlc3Mgc2NoZWR1bGVyLg0KDQpTaWduZWQtb2ZmLWJ5OiBKYW1l
cyBaaHUgPEphbWVzLlpodUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y5XzAuYyB8IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KaW5k
ZXggZGMzOGRmOC4uZTkwNWFjNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OV8wLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8w
LmMNCkBAIC00MTQ2LDcgKzQxNDYsNyBAQCBzdGF0aWMgaW50IGdmeF92OV8wX2RvX2VkY19ncHJf
d29ya2Fyb3VuZHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogDQogCS8qIHdyaXRlIGRp
c3BhdGNoIHBhY2tldCAqLw0KIAlpYi5wdHJbaWIubGVuZ3RoX2R3KytdID0gUEFDS0VUMyhQQUNL
RVQzX0RJU1BBVENIX0RJUkVDVCwgMyk7DQotCWliLnB0cltpYi5sZW5ndGhfZHcrK10gPSAxMjg7
IC8qIHggKi8NCisJaWIucHRyW2liLmxlbmd0aF9kdysrXSA9IDI1NjsgLyogeCAqLw0KIAlpYi5w
dHJbaWIubGVuZ3RoX2R3KytdID0gMTsgLyogeSAqLw0KIAlpYi5wdHJbaWIubGVuZ3RoX2R3Kytd
ID0gMTsgLyogeiAqLw0KIAlpYi5wdHJbaWIubGVuZ3RoX2R3KytdID0NCkBAIC00MTc0LDcgKzQx
NzQsNyBAQCBzdGF0aWMgaW50IGdmeF92OV8wX2RvX2VkY19ncHJfd29ya2Fyb3VuZHMoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogDQogCS8qIHdyaXRlIGRpc3BhdGNoIHBhY2tldCAqLw0K
IAlpYi5wdHJbaWIubGVuZ3RoX2R3KytdID0gUEFDS0VUMyhQQUNLRVQzX0RJU1BBVENIX0RJUkVD
VCwgMyk7DQotCWliLnB0cltpYi5sZW5ndGhfZHcrK10gPSAxMjg7IC8qIHggKi8NCisJaWIucHRy
W2liLmxlbmd0aF9kdysrXSA9IDI1NjsgLyogeCAqLw0KIAlpYi5wdHJbaWIubGVuZ3RoX2R3Kytd
ID0gMTsgLyogeSAqLw0KIAlpYi5wdHJbaWIubGVuZ3RoX2R3KytdID0gMTsgLyogeiAqLw0KIAlp
Yi5wdHJbaWIubGVuZ3RoX2R3KytdID0NCi0tIA0KMi43LjQNCg0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
JTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDaGF3a2lu
Zy56aGFuZyU0MGFtZC5jb20lN0MzOWUzZjdhOTk4ZTQ0NGUzMTc1NjA4ZDc3MmE3OTAwYyU3QzNk
ZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxMDM5MzYzMjIzODk2
OTQmYW1wO3NkYXRhPXQ4M3VNTVNia1A3YjJUV3RjSWI1RDgxUSUyRnRiZDV3MVV2NDZpQzRjZnVX
OCUzRCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
