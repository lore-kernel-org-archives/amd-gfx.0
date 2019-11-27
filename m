Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B492C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 11:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3830C20665
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 11:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3830C20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F506E516;
	Wed, 27 Nov 2019 11:28:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770073.outbound.protection.outlook.com [40.107.77.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B9576E516
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 11:28:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPi0jPqOlzxaXf9DNSqSYggjFXdVG0aDTpQF7WlbAfembilMHS23jx/lqSauSTSeTt1b/lcccGAL7s9uMyxCUOl/BTCRkV80XuC8eYGtcqZZps2YKjZhmmo2DhqYKUgy3dlwQlq3p/Ifg3ikC9Maf/g28dZol50WEpnIqhPVAT1n9druA1FGq22HJO14itVwGafAjWbNav9J8Ag0pgiZVv5VJq6jwhoM7LjmXGE/ugAdiqp3gGSo+lvMEoJQanNUQ9c05648bR24zXpu3rWUWgPPyBj/seECGSnZYMHu96ob2I/lNYCrN45D7xj8iYoaduRvO5SXj5lfeuXO67zg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FX1sxGNtr0ReNIOF/NYhfKgknfBX72Y6Ec6R1mBp34E=;
 b=IUk4ROhXQehsiTzxjINc1rQKAe3DvpWfxGh54yR5xeyJNO/h8Ph3dr0Oywfknfc/AoOnAi5EDVJcdb3uZsb5Qo537FRZHpK8s3kMrL85jqrWvcq6NQSCms6R29gLd1NM1462tnpXxDGOhZC/45i7XJwL88AKmy7mqkIa3jCaXDoOazDtOQogUT0aWNANZYjIP/K37yI6mv0s7N9DLPK8n9WzeRbL0SInb9R7T3H3gve7t6lK6zLZcxeSKqE/39ntsMp4f1HxmJPT8LLNFJxKgOsl4TOjW3JJ8c4GlspIiBgY9UTmQ4SBKV+OOF26jRY3Ktp7MSNj1UFjjDk/oWfuxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1499.namprd12.prod.outlook.com (10.172.36.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 27 Nov 2019 11:28:12 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 11:28:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 06/10] drm/amdgpu: add condition to enable baco for
 xgmi/ras case
Thread-Topic: [PATCH 06/10] drm/amdgpu: add condition to enable baco for
 xgmi/ras case
Thread-Index: AQHVpQNF7sQDwMPhqkCeX4PVICusHqee2nnw
Date: Wed, 27 Nov 2019 11:28:12 +0000
Message-ID:
 <DM5PR12MB141825CB772FEEF1FD013EDBFC440@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-5-git-send-email-le.ma@amd.com>
In-Reply-To: <1574846129-4826-5-git-send-email-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2019-11-27T11:03:26Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1deaade1-8d67-4c40-8ee3-0000834588a2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2019-11-27T11:28:07Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 06ad91ea-3a09-4e29-b7d5-00005b0ba2dd
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f8cbfefc-6173-43ee-84db-08d7732ce353
x-ms-traffictypediagnostic: DM5PR12MB1499:|DM5PR12MB1499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1499272633854BE74868FE39FC440@DM5PR12MB1499.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(13464003)(189003)(199004)(81156014)(4326008)(14454004)(2906002)(110136005)(76176011)(54906003)(71200400001)(229853002)(55016002)(478600001)(71190400001)(256004)(81166006)(8676002)(6246003)(14444005)(6436002)(8936002)(316002)(9686003)(3846002)(102836004)(53546011)(5660300002)(33656002)(99286004)(6506007)(305945005)(26005)(6116002)(25786009)(2501003)(74316002)(52536014)(186003)(446003)(64756008)(66946007)(76116006)(66446008)(86362001)(66556008)(66476007)(7696005)(66066001)(7736002)(11346002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1499;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TNfRUrNb+ycaphFAPEmwCQhBLN3jPEK1JPcPoHbFUAFVEvyRCQktVlVPmxkfv+FmAQWipZQDhFeQX6Y2U6GyeLQ674cvxQzLuhAqr7RGbCORyOPI1AqvorWXUSsgniYNljfprcMql6CR5vl2uJncORuSS0tLtlHrDiPUwPug9gvA9YUP1snI/sddkmrUZ22Mij2zuWMef/oRezpM61Nhkl1l01YMDFjXyoOOONNHj6S1VBX0t/XxrEh5X8FeoD+qbq93r9gBoKzA5hLqWARlE7ZBRQzODp0FTQpYIVUNL51g6ogUWiHDtUfcg0BjgfCvrL0ACaSs+pU/Lyh42Iety+nD3X4jx/s7OJllXXpuL0fbISfOrY0YYMB5IRZ7aIsjWjxbPN87knZeGqZDW2TDVgQmfBylxhd7acwdk7HahTymjFeNSB/Io0lKhh7hJWHv
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cbfefc-6173-43ee-84db-08d7732ce353
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 11:28:12.3072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJ010TjllS6gBzGNN4X64ZqPZXc9XWJpH7WRW/BSD40eZkIE1jy97gTZIz5wQCuK9Tvlnl2SKjfjESROoSrddw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1499
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FX1sxGNtr0ReNIOF/NYhfKgknfBX72Y6Ec6R1mBp34E=;
 b=ZE9LiRKQkdCfIlB6g5A89A38whh//D2f+1CHPf/XGyWu6WMjIsiZF4pDdFAHvS8txNTnaM9+FN7QGzEqX5zpJZSA3+z9O6/zRmUOQBuugEndL2M4BHwVLWJ3wvPJ5jZ+SvyYi9aQLsTIlKv2C26mWvJapP2LxD1tWZpkJWnRKs8=
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127112812.bLrINjUrpncxMy3oTAKT9bLK2v6TDS6WcdmYZh00imQ@z>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpBZnRlciB0aGlua2luZyBpdCBhIGJpdCwgSSB0aGluayB3ZSBj
YW4ganVzdCByZWx5IG9uIFBNRlcgdmVyc2lvbiB0byBkZWNpZGUgdG8gZ28gUkFTIHJlY292ZXJ5
IG9yIGxlZ2FjeSBmYXRhbF9lcnJvciBoYW5kbGluZyBmb3IgdGhlIHBsYXRmb3JtcyB0aGF0IHN1
cHBvcnQgUkFTLiBMZXZlcmFnaW5nIGFtZGdwdV9yYXNfZW5hYmxlIGFzIGEgdGVtcG9yYXJ5IHNv
bHV0aW9uIHNlZW1zIG5vdCBuZWNlc3Nhcnk/IEV2ZW4gYmFjbyByYXMgcmVjb3Zlcnkgbm90IHN0
YWJsZSwgaXQgaXMgdGhlIHNhbWUgcmVzdWx0IGFzIGxlZ2FjeSBmYXRhbF9lcnJvciBoYW5kbGlu
ZyB0aGF0IHVzZXIgaGFzIHRvIHJlYm9vdCB0aGUgbm9kZSBtYW51YWxseS4gDQoNClNvIHRoZSBu
ZXcgc29jIHJlc2V0IHVzZSBjYXNlcyBhcmU6DQpYR01JICh3aXRob3V0IFJBUyk6IHVzZSBQU1Ag
bW9kZTEgYmFzZWQgY2hhaW4gcmVzZXQsIA0KUkFTIGVuYWJsZWQgKHdpdGggUE1GVyA0MC41MiBh
bmQgb253YXJkcyk6IHVzZSBCQUNPIGJhc2VkIFJBUyByZWNvdmVyeSwNClJBUyBlbmFibGVkICh3
aXRoIFBNRlcgcHJpb3IgdG8gNDAuNTIpOiB1c2UgbGVnYWN5IGZhdGFsX2Vycm9yIGhhbmRsaW5n
Lg0KIA0KQW55dGhpbmcgZWxzZT8NCg0KUmVnYXJkcywNCkhhd2tpbmcNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBMZSBNYSA8bGUubWFAYW1kLmNvbT4gDQpTZW50OiAyMDE55bm0
MTHmnIgyN+aXpSAxNzoxNQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzog
WmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IENoZW4sIEd1Y2h1biA8R3Vj
aHVuLkNoZW5AYW1kLmNvbT47IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsgTGksIERl
bm5pcyA8RGVubmlzLkxpQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+OyBNYSwgTGUgPExlLk1hQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0gg
MDYvMTBdIGRybS9hbWRncHU6IGFkZCBjb25kaXRpb24gdG8gZW5hYmxlIGJhY28gZm9yIHhnbWkv
cmFzIGNhc2UNCg0KQXZvaWQgdG8gY2hhbmdlIGRlZmF1bHQgcmVzZXQgYmVoYXZpb3IgZm9yIHBy
b2R1Y3Rpb24gY2FyZCBieSBjaGVja2luZyBhbWRncHVfcmFzX2VuYWJsZSBlcXVhbCB0byAyLiBB
bmQgb25seSBuZXcgZW5vdWdoIHNtdSB1Y29kZSBjYW4gc3VwcG9ydCBiYWNvIGZvciB4Z21pL3Jh
cyBjYXNlLg0KDQpDaGFuZ2UtSWQ6IEkwN2MzZTY4NjJiZTAzZTA2ODc0NWM3M2RiOGVhNzFmNDI4
ZWNiYTZiDQpTaWduZWQtb2ZmLWJ5OiBMZSBNYSA8bGUubWFAYW1kLmNvbT4NCi0tLQ0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgfCA0ICsrKy0NCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29j
MTUuYw0KaW5kZXggOTUxMzI3Zi4uNjIwMjMzMyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NvYzE1LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nv
YzE1LmMNCkBAIC01NzcsNyArNTc3LDkgQEAgc29jMTVfYXNpY19yZXNldF9tZXRob2Qoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogCQkJc3RydWN0IGFtZGdwdV9oaXZlX2luZm8gKmhpdmUg
PSBhbWRncHVfZ2V0X3hnbWlfaGl2ZShhZGV2LCAwKTsNCiAJCQlzdHJ1Y3QgYW1kZ3B1X3JhcyAq
cmFzID0gYW1kZ3B1X3Jhc19nZXRfY29udGV4dChhZGV2KTsNCiANCi0JCQlpZiAoaGl2ZSB8fCAo
cmFzICYmIHJhcy0+c3VwcG9ydGVkKSkNCisJCQlpZiAoKGhpdmUgfHwgKHJhcyAmJiByYXMtPnN1
cHBvcnRlZCkpICYmDQorCQkJICAgIChhbWRncHVfcmFzX2VuYWJsZSAhPSAyIHx8DQorCQkJICAg
IGFkZXYtPnBtLmZ3X3ZlcnNpb24gPD0gMHgyODM0MDApKQ0KIAkJCQliYWNvX3Jlc2V0ID0gZmFs
c2U7DQogCQl9DQogCQlicmVhazsNCi0tDQoyLjcuNA0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
