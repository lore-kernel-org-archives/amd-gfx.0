Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BB2C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 04:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77CC20704
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 04:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77CC20704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62CA56E0D2;
	Fri, 22 Nov 2019 04:21:39 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690063.outbound.protection.outlook.com [40.107.69.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5D7E6E0D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 04:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVbUDlIEvdddT1iCNxE+6/visHcDmRNt2VYjLUo47O4H5Ns1DgopQrXrLTPt6Ud5Jq9YCtcghASzJDb5AWNGcdCDDfxdw6S+nR13VCazVH2AwZ1wNyxupnEIQnsPQCnOM02W8KBlHaoKRvRquiFVd+yw2koUQi92LsSOy8SfnWJyX6baQdXNVYm0x7C3VNsOobuMm4Kem55GHjmq03fAakN6NWwEWQssXY9tjgfhgTwWpzlxuxSxkI+hmKosf3lsKdYIF4XZleUBX/SY/0lZ3lMREKertkcJQnoO5zAvGxuC7McOYMbwNTr9oGWZC6H8weucSEVdPODSaPJXyOGNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwsiKsE2PeWBwestn72v7gHkidsaaNLcW3u4XZM+AiI=;
 b=Ij62PJIbp2PNkrGICMRH56Zn/6yf7Ga1mKBTasoIAO9M+a9qrlZvfucv9lPou873adcOZxIRtG+nCzNasnXFjdgSE+JakrEQ7nlgq/VdzjKcVkpyBjhRTxV8q9AmOAE+BQXGmvSeIFH/IdbhrNvp/zlD09AzF49iZ1GJdsxnH7ytRmsrtmVe6vntFbgm1aGZV85TbZ4K6D7wlq6bVw9q7yw41U1Z7SoJ1XBLu7fj4IZCaUU5BBfQnUJhdLg4YYDxw3G0TWTiOSceMTm5ziASDJjA80NwGWD0BMXLNiG+PZgHy2fD6vHo8w+8wcF+Wmu6rLJJNtaohKAYpUvl4fjmjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Fri, 22 Nov 2019 04:21:37 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616%7]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 04:21:37 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Remove duplicate functions update_mqd_hiq()
Thread-Topic: [PATCH] drm/amdkfd: Remove duplicate functions update_mqd_hiq()
Thread-Index: AQHVoLJAySHQcDbLgkWmgnN92I00a6eWlvLg
Date: Fri, 22 Nov 2019 04:21:36 +0000
Message-ID:
 <DM6PR12MB3466B2CDD1F0158C673AD87B9E490@DM6PR12MB3466.namprd12.prod.outlook.com>
References: <20191121212524.3946-1-Yong.Zhao@amd.com>
In-Reply-To: <20191121212524.3946-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7ce5355-0a9c-4938-bb01-08d76f037727
x-ms-traffictypediagnostic: DM6PR12MB2778:|DM6PR12MB2778:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2778FD048104EE6A24DD702D9E490@DM6PR12MB2778.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:534;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(13464003)(199004)(189003)(6506007)(66556008)(71200400001)(71190400001)(15650500001)(66066001)(99286004)(4326008)(8936002)(53546011)(102836004)(446003)(81166006)(14454004)(7696005)(86362001)(81156014)(6246003)(316002)(76176011)(55016002)(6306002)(9686003)(8676002)(6436002)(26005)(305945005)(7736002)(45080400002)(229853002)(5660300002)(14444005)(74316002)(508600001)(6116002)(33656002)(25786009)(11346002)(2501003)(3846002)(110136005)(66946007)(966005)(76116006)(256004)(64756008)(52536014)(66476007)(186003)(66446008)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2778;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L9auIDizG/m0O7jjW8bKRp/zGaoYACjrTYkaiQbyizZ4tiIggdLrUIwjZeftDR/Fnw420LO3b1PUhxMT6Ck/7va7369cFyuQGMvZAsPCDDenJW0owHOcYVXhBW2nTKEChCK3v1QAKImzaK2+S54i2JKgImbHLTleqXXd01av6CLjK42qT+WcscQqTL+UiQrEw8Dj6Q4GQIsG9dndXTcVzPc46+7cxFBbtyfytqwjatiBNQIRtUQ3uG1M4/wfe4rZtWR66DagLZPh4axcoAhbb2Sk/dVBtTS1sKYMKQpO15mTiCUMkb5gmaTMh385dpdWB7Y88nROh4hevsQqww2r8uqTGMILCe81Ic8FETS2FyHc2sg5YBTBuiTSVIjfThxFtAQUVF3IaJNT6gxwe2k40vOrHbkeDk069Ms3OiU9kYTohmaowS218iK1aELokHlL
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ce5355-0a9c-4938-bb01-08d76f037727
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 04:21:36.9692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e208Jb6Gd9jM4h7cdPVKMzl5GvFSgstrKKpaFB9m5oSpk2oWt4wHug1oagTefwoS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2778
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwsiKsE2PeWBwestn72v7gHkidsaaNLcW3u4XZM+AiI=;
 b=Bzku+DH2I6d2XjopYXKalVu9KoXPZekqZlc4bLJE1fF9tVX2Q2ni4eD0AlgYs9fI+cJEiw1YBpay/EO2DdeqDEN6MQtzMaRnJ3c3TWEsBInRxt9+r9Fx/ufiuufrTGppc6yNB9K6/p6Go7o1EF8+zSiAbFetghYEWZzKTI9iRwk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
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
Cc: "Zhao, Yong" <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191122042136.97ughv-vvKUCutXTmzgE6Vne_KG3vOgpzavGADHWUOk@z>

TG9va3MgZ29vZCB0byBtZS4NCg0KUmV2aWV3ZWQtYnk6IFpoYW4gTGl1IDx6aGFuLmxpdUBhbWQu
Y29tPg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFt
ZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBZb25n
IFpoYW8NCj4gU2VudDogMjAxOS9Ob3ZlbWJlci8yMSwgVGh1cnNkYXkgNDoyNSBQTQ0KPiBUbzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IFpoYW8sIFlvbmcgPFlvbmcuWmhh
b0BhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRrZmQ6IFJlbW92ZSBkdXBsaWNh
dGUgZnVuY3Rpb25zDQo+IHVwZGF0ZV9tcWRfaGlxKCkNCj4gDQo+IFRoZSBmdW5jdGlvbnMgYXJl
IHRoZSBzYW1lIGFzIHVwZGF0ZV9tcWQoKS4NCj4gDQo+IENoYW5nZS1JZDogSWM4ZDhmMjNjZGRl
NmI3ODA2YWI3NjZkZGYzZDcxZmE2NjhjY2E1ZmINCj4gU2lnbmVkLW9mZi1ieTogWW9uZyBaaGFv
IDxZb25nLlpoYW9AYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfbXFkX21hbmFnZXJfdjEwLmMgfCAxNiArKy0tLS0tLS0tLS0tLS0tDQo+IGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5jICB8IDE2ICsrLS0tLS0tLS0t
LS0tLS0NCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3ZpLmMg
IHwgIDQgLS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMyIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9tcWRfbWFuYWdlcl92MTAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9t
cWRfbWFuYWdlcl92MTAuYw0KPiBpbmRleCA4ZDIxMzI1YjVjYmIuLjc4MzJlYzZlNDgwYiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Yx
MC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92
MTAuYw0KPiBAQCAtMjgyLDE4ICsyODIsNiBAQCBzdGF0aWMgdm9pZCBpbml0X21xZF9oaXEoc3Ry
dWN0IG1xZF9tYW5hZ2VyICptbSwNCj4gdm9pZCAqKm1xZCwNCj4gIAkJCTEgPDwgQ1BfSFFEX1BR
X0NPTlRST0xfX0tNRF9RVUVVRV9fU0hJRlQ7DQo+ICB9DQo+IA0KPiAtc3RhdGljIHZvaWQgdXBk
YXRlX21xZF9oaXEoc3RydWN0IG1xZF9tYW5hZ2VyICptbSwgdm9pZCAqbXFkLA0KPiAtCQkJc3Ry
dWN0IHF1ZXVlX3Byb3BlcnRpZXMgKnEpDQo+IC17DQo+IC0Jc3RydWN0IHYxMF9jb21wdXRlX21x
ZCAqbTsNCj4gLQ0KPiAtCXVwZGF0ZV9tcWQobW0sIG1xZCwgcSk7DQo+IC0NCj4gLQkvKiBUT0RP
OiB3aGF0J3MgdGhlIHBvaW50PyB1cGRhdGVfbXFkIGFscmVhZHkgZG9lcyB0aGlzLiAqLw0KPiAt
CW0gPSBnZXRfbXFkKG1xZCk7DQo+IC0JbS0+Y3BfaHFkX3ZtaWQgPSBxLT52bWlkOw0KPiAtfQ0K
PiAtDQo+ICBzdGF0aWMgdm9pZCBpbml0X21xZF9zZG1hKHN0cnVjdCBtcWRfbWFuYWdlciAqbW0s
IHZvaWQgKiptcWQsDQo+ICAJCXN0cnVjdCBrZmRfbWVtX29iaiAqbXFkX21lbV9vYmosIHVpbnQ2
NF90ICpnYXJ0X2FkZHIsDQo+ICAJCXN0cnVjdCBxdWV1ZV9wcm9wZXJ0aWVzICpxKQ0KPiBAQCAt
NDIyLDcgKzQxMCw3IEBAIHN0cnVjdCBtcWRfbWFuYWdlciAqbXFkX21hbmFnZXJfaW5pdF92MTAo
ZW51bQ0KPiBLRkRfTVFEX1RZUEUgdHlwZSwNCj4gIAkJbXFkLT5pbml0X21xZCA9IGluaXRfbXFk
X2hpcTsNCj4gIAkJbXFkLT5mcmVlX21xZCA9IGZyZWVfbXFkX2hpcV9zZG1hOw0KPiAgCQltcWQt
PmxvYWRfbXFkID0gbG9hZF9tcWQ7DQo+IC0JCW1xZC0+dXBkYXRlX21xZCA9IHVwZGF0ZV9tcWRf
aGlxOw0KPiArCQltcWQtPnVwZGF0ZV9tcWQgPSB1cGRhdGVfbXFkOw0KPiAgCQltcWQtPmRlc3Ry
b3lfbXFkID0gZGVzdHJveV9tcWQ7DQo+ICAJCW1xZC0+aXNfb2NjdXBpZWQgPSBpc19vY2N1cGll
ZDsNCj4gIAkJbXFkLT5tcWRfc2l6ZSA9IHNpemVvZihzdHJ1Y3QgdjEwX2NvbXB1dGVfbXFkKTsg
QEAgLQ0KPiA0MzYsNyArNDI0LDcgQEAgc3RydWN0IG1xZF9tYW5hZ2VyICptcWRfbWFuYWdlcl9p
bml0X3YxMChlbnVtDQo+IEtGRF9NUURfVFlQRSB0eXBlLA0KPiAgCQltcWQtPmluaXRfbXFkID0g
aW5pdF9tcWRfaGlxOw0KPiAgCQltcWQtPmZyZWVfbXFkID0gZnJlZV9tcWQ7DQo+ICAJCW1xZC0+
bG9hZF9tcWQgPSBsb2FkX21xZDsNCj4gLQkJbXFkLT51cGRhdGVfbXFkID0gdXBkYXRlX21xZF9o
aXE7DQo+ICsJCW1xZC0+dXBkYXRlX21xZCA9IHVwZGF0ZV9tcWQ7DQo+ICAJCW1xZC0+ZGVzdHJv
eV9tcWQgPSBkZXN0cm95X21xZDsNCj4gIAkJbXFkLT5pc19vY2N1cGllZCA9IGlzX29jY3VwaWVk
Ow0KPiAgCQltcWQtPm1xZF9zaXplID0gc2l6ZW9mKHN0cnVjdCB2MTBfY29tcHV0ZV9tcWQpOyBk
aWZmIC0tZ2l0DQo+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2Vy
X3Y5LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjku
Yw0KPiBpbmRleCBkZjc3ZDY3ZWM5YWEuLmFhOTAxMDk5NWVhZiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMNCj4gQEAgLTMyNSwx
OCArMzI1LDYgQEAgc3RhdGljIHZvaWQgaW5pdF9tcWRfaGlxKHN0cnVjdCBtcWRfbWFuYWdlciAq
bW0sDQo+IHZvaWQgKiptcWQsDQo+ICAJCQkxIDw8IENQX0hRRF9QUV9DT05UUk9MX19LTURfUVVF
VUVfX1NISUZUOw0KPiAgfQ0KPiANCj4gLXN0YXRpYyB2b2lkIHVwZGF0ZV9tcWRfaGlxKHN0cnVj
dCBtcWRfbWFuYWdlciAqbW0sIHZvaWQgKm1xZCwNCj4gLQkJCXN0cnVjdCBxdWV1ZV9wcm9wZXJ0
aWVzICpxKQ0KPiAtew0KPiAtCXN0cnVjdCB2OV9tcWQgKm07DQo+IC0NCj4gLQl1cGRhdGVfbXFk
KG1tLCBtcWQsIHEpOw0KPiAtDQo+IC0JLyogVE9ETzogd2hhdCdzIHRoZSBwb2ludD8gdXBkYXRl
X21xZCBhbHJlYWR5IGRvZXMgdGhpcy4gKi8NCj4gLQltID0gZ2V0X21xZChtcWQpOw0KPiAtCW0t
PmNwX2hxZF92bWlkID0gcS0+dm1pZDsNCj4gLX0NCj4gLQ0KPiAgc3RhdGljIHZvaWQgaW5pdF9t
cWRfc2RtYShzdHJ1Y3QgbXFkX21hbmFnZXIgKm1tLCB2b2lkICoqbXFkLA0KPiAgCQlzdHJ1Y3Qg
a2ZkX21lbV9vYmogKm1xZF9tZW1fb2JqLCB1aW50NjRfdCAqZ2FydF9hZGRyLA0KPiAgCQlzdHJ1
Y3QgcXVldWVfcHJvcGVydGllcyAqcSkNCj4gQEAgLTQ2Miw3ICs0NTAsNyBAQCBzdHJ1Y3QgbXFk
X21hbmFnZXIgKm1xZF9tYW5hZ2VyX2luaXRfdjkoZW51bQ0KPiBLRkRfTVFEX1RZUEUgdHlwZSwN
Cj4gIAkJbXFkLT5pbml0X21xZCA9IGluaXRfbXFkX2hpcTsNCj4gIAkJbXFkLT5mcmVlX21xZCA9
IGZyZWVfbXFkX2hpcV9zZG1hOw0KPiAgCQltcWQtPmxvYWRfbXFkID0gbG9hZF9tcWQ7DQo+IC0J
CW1xZC0+dXBkYXRlX21xZCA9IHVwZGF0ZV9tcWRfaGlxOw0KPiArCQltcWQtPnVwZGF0ZV9tcWQg
PSB1cGRhdGVfbXFkOw0KPiAgCQltcWQtPmRlc3Ryb3lfbXFkID0gZGVzdHJveV9tcWQ7DQo+ICAJ
CW1xZC0+aXNfb2NjdXBpZWQgPSBpc19vY2N1cGllZDsNCj4gIAkJbXFkLT5tcWRfc2l6ZSA9IHNp
emVvZihzdHJ1Y3QgdjlfbXFkKTsgQEAgLTQ3NSw3ICs0NjMsNw0KPiBAQCBzdHJ1Y3QgbXFkX21h
bmFnZXIgKm1xZF9tYW5hZ2VyX2luaXRfdjkoZW51bSBLRkRfTVFEX1RZUEUNCj4gdHlwZSwNCj4g
IAkJbXFkLT5pbml0X21xZCA9IGluaXRfbXFkX2hpcTsNCj4gIAkJbXFkLT5mcmVlX21xZCA9IGZy
ZWVfbXFkOw0KPiAgCQltcWQtPmxvYWRfbXFkID0gbG9hZF9tcWQ7DQo+IC0JCW1xZC0+dXBkYXRl
X21xZCA9IHVwZGF0ZV9tcWRfaGlxOw0KPiArCQltcWQtPnVwZGF0ZV9tcWQgPSB1cGRhdGVfbXFk
Ow0KPiAgCQltcWQtPmRlc3Ryb3lfbXFkID0gZGVzdHJveV9tcWQ7DQo+ICAJCW1xZC0+aXNfb2Nj
dXBpZWQgPSBpc19vY2N1cGllZDsNCj4gIAkJbXFkLT5tcWRfc2l6ZSA9IHNpemVvZihzdHJ1Y3Qg
djlfbXFkKTsgZGlmZiAtLWdpdA0KPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9t
cWRfbWFuYWdlcl92aS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9t
YW5hZ2VyX3ZpLmMNCj4gaW5kZXggM2I2YjU2NzE5NjRjLi5hNWU4ZmYxZTU5NDUgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92aS5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92aS5jDQo+
IEBAIC0zMTIsMTEgKzMxMiw3IEBAIHN0YXRpYyB2b2lkIGluaXRfbXFkX2hpcShzdHJ1Y3QgbXFk
X21hbmFnZXIgKm1tLA0KPiB2b2lkICoqbXFkLCAgc3RhdGljIHZvaWQgdXBkYXRlX21xZF9oaXEo
c3RydWN0IG1xZF9tYW5hZ2VyICptbSwgdm9pZA0KPiAqbXFkLA0KPiAgCQkJc3RydWN0IHF1ZXVl
X3Byb3BlcnRpZXMgKnEpDQo+ICB7DQo+IC0Jc3RydWN0IHZpX21xZCAqbTsNCj4gIAlfX3VwZGF0
ZV9tcWQobW0sIG1xZCwgcSwgTVRZUEVfVUMsIDApOw0KPiAtDQo+IC0JbSA9IGdldF9tcWQobXFk
KTsNCj4gLQltLT5jcF9ocWRfdm1pZCA9IHEtPnZtaWQ7DQo+ICB9DQo+IA0KPiAgc3RhdGljIHZv
aWQgaW5pdF9tcWRfc2RtYShzdHJ1Y3QgbXFkX21hbmFnZXIgKm1tLCB2b2lkICoqbXFkLA0KPiAt
LQ0KPiAyLjE3LjENCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLg0KPiBmcmVlZGVza3RvcC5vcmclMkZtYWlsbWFu
JTJGbGlzdGluZm8lMkZhbWQtDQo+IGdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDemhhbi5saXUlNDBh
bWQuY29tJTdDMGUzYWIxYTFkMTFmNDg0NmQwMw0KPiBhMDhkNzZlYzk1ZGYzJTdDM2RkODk2MWZl
NDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzANCj4gOTk2ODM1MTczMDI3MDIm
YW1wO3NkYXRhPWptbXRkSHVnamw1QjZQJTJGUkFvanpQcUtQbEM4cyUyRjA3d21TDQo+IGtZODJp
T1V2USUzRCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
