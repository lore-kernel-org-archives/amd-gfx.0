Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C48C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 10:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21D82245C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 10:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21D82245C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27236F9B4;
	Fri,  6 Dec 2019 10:18:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42FEE6F9B4
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 10:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TP7jVjEes9EXZm4dlXg81UaH08ngrmcvy49zy6gVhXmuNnpvuVOpC0zJIiGfpGAJS3WzBZf/lm0Ywx1pgMiOaMSBnACLIZS8oS7D8NsBKD1/rtqmyJGDEFThwYTimuoS43xp7Yd0r4nZb7AMq6f0dyq6p5Wx5fB3hyqHMv41t/ctzwWU+ZhWcTeDmOC+bLHg8uVKFoouxVivMLzr33n6RSsJS07shX+GAstFgzJipak8bUQXEarcEA/nUQamv1d3p/fZce700Wc/DeSTO2/L79C0hRy8I7+2PddJx0apRxfVvzF/3KF+n4FjZymQNBuC3bOsmNryoztxN/ZufKL0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4noFzy4QzmNji9QaxB6f00kcgZgv/EGXobNFl7XWJU0=;
 b=a3a3idRPKU8h78dX+UvcmU28gwDamD7XoQWQ0rWf+1UwJIhvspLQS0Hrkf5RR2UTjDu1XUg2/eOZZ+G1sceC3KyOoAyfw8VYsGyqOy4RToLpoHWWjjzpk4cAc4Oo4HrUOIZ+b/wOjpBzaAt9QXsZb+LFt1ysC2AuVefx6Zh15WePfTU6ENJMW0i26swsOCwcWVIhDNhOcKZy74+/FUghjGle06nklZ8n9aydP94pYBgTofQwIhi9CEr7wGjXHXFAI+R/cEdloVNwFISge+tu06QNWYOx8y6rSyLVUDOWkY0K2n01q8HI9NqeSei0QqFBeqmcOntTB0LbgX5hrYI8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB4285.namprd12.prod.outlook.com (52.135.49.140) by
 MN2PR12MB3694.namprd12.prod.outlook.com (10.255.237.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.16; Fri, 6 Dec 2019 10:18:52 +0000
Received: from MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::b4d9:8cb3:3876:ed5]) by MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::b4d9:8cb3:3876:ed5%6]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 10:18:52 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix resume failures due to psp fw loading
 sequence change (v3)
Thread-Topic: [PATCH] drm/amdgpu: fix resume failures due to psp fw loading
 sequence change (v3)
Thread-Index: AQHVrB2iu3g1yEVOskG1lL6f894LXqes5COA
Date: Fri, 6 Dec 2019 10:18:52 +0000
Message-ID: <MN2PR12MB4285CC4BE5E48E893353D912F65F0@MN2PR12MB4285.namprd12.prod.outlook.com>
References: <20191206101204.5374-1-Hawking.Zhang@amd.com>
In-Reply-To: <20191206101204.5374-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-06T10:18:47Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=558abb00-2e90-4625-a90f-0000cc12961d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-06T10:18:47Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 29ca8f3e-61c4-4055-a61c-0000f8e408c4
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a3458af-02c4-42f0-eba5-08d77a35b172
x-ms-traffictypediagnostic: MN2PR12MB3694:|MN2PR12MB3694:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB36948C29A05F87D383D75193F65F0@MN2PR12MB3694.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(13464003)(11346002)(66556008)(2906002)(66476007)(64756008)(66446008)(66946007)(9686003)(55016002)(71190400001)(6636002)(478600001)(86362001)(76176011)(110136005)(229853002)(71200400001)(316002)(305945005)(74316002)(33656002)(53546011)(7696005)(6506007)(26005)(25786009)(81166006)(76116006)(99286004)(5660300002)(102836004)(14454004)(14444005)(52536014)(8676002)(186003)(8936002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3694;
 H:MN2PR12MB4285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: clMevj9yIqabTTXDH66ZsKYyiY0J/eL3/C8PYKiR0j495xjm2PZQMGOHBeVtIiME20RlqpM7D2t9Chy5fXwL7sVF2QxPCoSkJqGPYe7bjSZE4Pm1iYK8oEYrUWe0vI6YV0xvojGg906ItMfd3ZYCGX3Q9AjBkrFE96+2Spz4fAPHMjfvl2/KOOWHZfKCYtFz28MH779td2Ysi/UKqmJ+JffbfdpRmPxOwZR5By6vzhWGTnU/ssSj5v2TBL7VrRu3WI2ossUppZ35/ybAKjA9pq8OX0IeCqK86sLHVMCMb8/N/3MP92Z8rbtp9IbT7PX0L54o0adIfCZHXKFQuIDElqQKC9S2JYidfjs/v2s+n523QwWOOpAPbFDKx0ckZYzRlYNtpqdUSiW2r2XwSk2rVl75IGOp/wIl3VE/cnFUEX5pPXtzWW47R3xIL/4xoDtsU9Wqm6x7U63OTHgRxwDQVWyW3rJCmsuwpVSmSWwtW+H1WHWlQ7jupSA1y8x3Fthh
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3458af-02c4-42f0-eba5-08d77a35b172
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 10:18:52.3615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EeeePex1hykIk9St7hJKL5U5K8KLT3OhUZllaf9eKFMhr3Zw03Xhr7bZz2KyEZ84
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3694
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4noFzy4QzmNji9QaxB6f00kcgZgv/EGXobNFl7XWJU0=;
 b=TxJCs5FgvmEncnjybeKcVJ0l9xHFmF5iXIAC170ZdxD2tt+R+JbWGiVxLFO4y/GvKdY/9HySYv1a88NuejyGKrHRiCNYDuEAQpoOQvPXvSakQRE+WTksE/oLPLND1Kb6nZs2AP7RolQTvkUT29r3lMunLg4WP7lYJF6PqsVJCZA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Le.Ma@amd.com; 
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQoKUmV2
aWV3ZWQtYnk6IExlIE1hIDxMZS5NYUBhbWQuY29tPgoKUmVnYXJkcywKTWEgTGUKLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0KRnJvbTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQu
Y29tPiAKU2VudDogRnJpZGF5LCBEZWNlbWJlciA2LCAyMDE5IDY6MTIgUE0KVG86IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBNYSwgTGUgPExlLk1hQGFtZC5jb20+OyBDbGVtZW50cywg
Sm9obiA8Sm9obi5DbGVtZW50c0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPjsgQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPgpD
YzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBmaXggcmVzdW1lIGZhaWx1cmVzIGR1ZSB0byBwc3AgZncgbG9hZGluZyBz
ZXF1ZW5jZSBjaGFuZ2UgKHYzKQoKdGhpcyBmaXggdGhlIHJlZ3Jlc3Npb24gY2F1c2VkIGJ5IGFz
ZC90YSBsb2FkaW5nIHNlcXVlbmNlIGFkanVzdG1lbnQgcmVjZW50bHkuIGFzZC90YSBsb2FkaW5n
IHdhcyBtb3ZlIG91dCBmcm9tIGh3X3N0YXJ0IGFuZCBzaG91bGQgYWxzbyBiZSBhcHBsaWVkIHRv
IHBzcF9yZXN1bWUuCm90aGVyd2lzZSB0aG9zZSBmdyBsb2FkaW5nIHdpbGwgYmUgaWdub3JlZCBp
biByZXN1bWUgcGhhc2UuCgp2MjogYWRkIHRoZSBtdXRleCB1bmxvY2sgZm9yIGFzZCBsb2FkaW5n
IGZhaWx1cmUgY2FzZQp2MzogbWVyZ2UgdGhlIGVycm9yIGhhbmRsaW5nIHRvIGZhaWxlZCB0YWcK
CkNoYW5nZS1JZDogSTIwZDM2NTFmMzI1ZTc5M2UxZWE3ZTczZGYxYzc2MjE5ZWFhMGI1YWIKU2ln
bmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDMzICsrKysrKysrKysrKysr
KysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCmluZGV4IGNlZWE4MzE0ZDg4ZC4uMmRmZGE1NTkw
ZTc3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBAIC0xNzAyLDYg
KzE3MDIsMzkgQEAgc3RhdGljIGludCBwc3BfcmVzdW1lKHZvaWQgKmhhbmRsZSkKIAlpZiAocmV0
KQogCQlnb3RvIGZhaWxlZDsKIAorCXJldCA9IHBzcF9hc2RfbG9hZChwc3ApOworCWlmIChyZXQp
IHsKKwkJRFJNX0VSUk9SKCJQU1AgbG9hZCBhc2QgZmFpbGVkIVxuIik7CisJCWdvdG8gZmFpbGVk
OworCX0KKworCWlmIChhZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMgPiAxKSB7CisJ
CXJldCA9IHBzcF94Z21pX2luaXRpYWxpemUocHNwKTsKKwkJLyogV2FybmluZyB0aGUgWEdNSSBz
ZWVzaW9uIGluaXRpYWxpemUgZmFpbHVyZQorCQkgKiBJbnN0ZWFkIG9mIHN0b3AgZHJpdmVyIGlu
aXRpYWxpemF0aW9uCisJCSAqLworCQlpZiAocmV0KQorCQkJZGV2X2Vycihwc3AtPmFkZXYtPmRl
diwKKwkJCQkiWEdNSTogRmFpbGVkIHRvIGluaXRpYWxpemUgWEdNSSBzZXNzaW9uXG4iKTsKKwl9
CisKKwlpZiAocHNwLT5hZGV2LT5wc3AudGFfZncpIHsKKwkJcmV0ID0gcHNwX3Jhc19pbml0aWFs
aXplKHBzcCk7CisJCWlmIChyZXQpCisJCQlkZXZfZXJyKHBzcC0+YWRldi0+ZGV2LAorCQkJCQki
UkFTOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBSQVNcbiIpOworCisJCXJldCA9IHBzcF9oZGNwX2lu
aXRpYWxpemUocHNwKTsKKwkJaWYgKHJldCkKKwkJCWRldl9lcnIocHNwLT5hZGV2LT5kZXYsCisJ
CQkJIkhEQ1A6IEZhaWxlZCB0byBpbml0aWFsaXplIEhEQ1BcbiIpOworCisJCXJldCA9IHBzcF9k
dG1faW5pdGlhbGl6ZShwc3ApOworCQlpZiAocmV0KQorCQkJZGV2X2Vycihwc3AtPmFkZXYtPmRl
diwKKwkJCQkiRFRNOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBEVE1cbiIpOworCX0KKwogCW11dGV4
X3VubG9jaygmYWRldi0+ZmlybXdhcmUubXV0ZXgpOwogCiAJcmV0dXJuIDA7Ci0tCjIuMTcuMQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
