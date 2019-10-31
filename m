Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375CFCA9EC3
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 07:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C6B02083E
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 07:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6B02083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A4D16ED87;
	Thu, 31 Oct 2019 07:22:37 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700083.outbound.protection.outlook.com [40.107.70.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE7176ED87
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 07:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwBy0a3pZsG87XJaf0yV3uzO5AG/UrBUpszRXeYB4Lg0/jaKcrLWkeUNPtbVHOtPQDqREgEqCaYCbgyjbB7qQ8YdZ4kDp0t1Rd09o7BcHZ2JUdK8VkFRZRMiiYB/Nbrj/OFFCwoOWs4vUmBGePSS3qGnqmgfSZVORTBXsmscNs0voyAsDfyBwHzNH/dKbwtk5T3U/Q6LAj83iN/T6wCN1WsE4h5usqijK0Ml/+Lf+/CFQjOHrVhm26PCOuNscbEC5gMYDfcecDwKq2dDD2MgLCvwsItCQUJsqbUcGpRDhTYRuLNQQ1Gr7WRdo93O/Z8c+E94PBBWqy8hcwTt5oHFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnSDcL1uXtXWejGmvu3saCmV8YmJwg4AAzAG2WQc9tY=;
 b=H+qL3WfWyYF49gIuz4/fYF5h/Sype3UiZ4bS5NDQo/8eEbusa0YmIREaicvvhHeKs0RSVx/cEjCUhw9KkzHwQz8CmS0vK4P3m6JcSLI6hB6PW2xabQSw84pqGZkVz1nswOolftOp7ddYTDVDXh/LoUznhMJrzi4PlgBww1qblv6DHsBhBHHf4a/OGI1p9EiY5DQVpDevrwdrirLGhivx803UUKB1EEaLSbflX3TyvdGza7LBQTWOoEZZafPCY5rH8UaBkTd6Djkvn7AoMV51s+UK0UNmg9O8t5VCWLCCBIfBIfTt5BNj/E/hPDnc8lXjujeLOP+nXPTkTdL+7jQTlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3853.namprd12.prod.outlook.com (10.255.236.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Thu, 31 Oct 2019 07:22:32 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 07:22:32 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: change pstate only after all XGMI device
 initialized
Thread-Topic: [PATCH 1/3] drm/amdgpu: change pstate only after all XGMI device
 initialized
Thread-Index: AQHVj7v1Xc1TNYQl10SzoTV3WPrepQ==
Date: Thu, 31 Oct 2019 07:22:32 +0000
Message-ID: <20191031072205.27537-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:203:2e::19) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4cf74396-941c-441e-373c-08d75dd31821
x-ms-traffictypediagnostic: MN2PR12MB3853:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB38531AC8F1CBEDE50D47E0F6E4630@MN2PR12MB3853.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(199004)(189003)(2351001)(50226002)(2616005)(66446008)(14444005)(2501003)(6916009)(52116002)(256004)(6512007)(8936002)(54906003)(7736002)(26005)(486006)(66946007)(476003)(64756008)(66556008)(66476007)(81166006)(1076003)(81156014)(478600001)(25786009)(99286004)(305945005)(5640700003)(36756003)(14454004)(102836004)(86362001)(386003)(6506007)(8676002)(3846002)(71200400001)(71190400001)(6436002)(316002)(6486002)(4326008)(2906002)(5660300002)(66066001)(186003)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3853;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cjRzc4shIa13eZgQZdggYq2VCva5xiHuNVBs1xhn4p+GI3ggIiB7AbSwptDI8jwQuOXm2ItFiKyZDLUIshV76GDFE8dLzVOTwzSxAWotgEVopE+Q9297gPpcZHQmu44Hk55EecMZmhlEJbygCmiiJKHlkLTjO3hXnkg+a+EjzrobR5S7ClKx9guSNTJ6/pnthAUBfxjSV7YhAvdHUBMMg9JttjlUFXg933PS80hDkzclUAjU9/MePxVybiCTiZW7FFbzU73/58HW/VwcUhI46/aFr6h8d2QWP+2gyRsaf3b8jfzTdnyJDP1uRw9oK1xbNFJ7uiTGKfF5ILGxcuKEb5vkBwEtgxTTFEoL608MgzAs+PfAqPlkfgtRb1QQ+zHx4JsjTgJIDemeGDtuA7GrtUlOZycIlOSoZxpIzGNiBHVysy3T48nx8ms7lzicOzQ6
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf74396-941c-441e-373c-08d75dd31821
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 07:22:32.5274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KMHbrgo8kTE6HwcVGoFuxwv88c6xGkgBn0cxPbag0BTQLAIRe3AdcyQWPhBiEbdm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3853
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnSDcL1uXtXWejGmvu3saCmV8YmJwg4AAzAG2WQc9tY=;
 b=TTnAPZ9Yqb9+yz8UOnOy4C0wvtxbMzB7+XngUJHlZLJv3+19JihtkWv9N98QXyhXFhhGWKVsqGYp0oCvb2UV7ieOq2F5uG88Fa5WVUYKJwQ9/oy8E0UG7+FSSery5GbqnfX6THycKGQlVODwkn4VK003HirvrzIYdDo0aOfJtsE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031072232.DFS2has-wVWVXLbpiv-WCWCR70tfZ7-dWW4kizh6LBA@z>

UHN0YXRlIHNldHRpbmdzIHNob3VsZCBiZSBwZXJmb3JtZWQgYWZ0ZXIgYWxsIGRldmljZSBvZiB0
aGUKWEdNSSBzZXR1cCBnZXQgaW5pdGlhbGl6ZWQuCgpDaGFuZ2UtSWQ6IEk1YzRiM2Y3OWZiZDYw
YTVjY2ZiNGRjNmY5NGQ5ZTFkYjZmYWVjNjk0ClNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZh
bi5xdWFuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jIHwgMTUgKysrKysrKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMKaW5kZXggMDhlOWQ4NWQyMmY0Li45MzcyMGM0NzkwZjggMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTIwODEsOSArMjA4MSw2IEBAIHN0
YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9pcF9sYXRlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCiAJaWYgKHIpCiAJCURSTV9FUlJPUigiZW5hYmxlIG1ncHUgZmFuIGJvb3N0IGZhaWxl
ZCAoJWQpLlxuIiwgcik7CiAKLQkvKiBzZXQgdG8gbG93IHBzdGF0ZSBieSBkZWZhdWx0ICovCi0J
YW1kZ3B1X3hnbWlfc2V0X3BzdGF0ZShhZGV2LCAwKTsKLQogCXJldHVybiAwOwogfQogCkBAIC0y
MTk1LDYgKzIxOTIsMTggQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2RldmljZV9kZWxheWVkX2luaXRf
d29ya19oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIAlyID0gYW1kZ3B1X2liX3Jp
bmdfdGVzdHMoYWRldik7CiAJaWYgKHIpCiAJCURSTV9FUlJPUigiaWIgcmluZyB0ZXN0IGZhaWxl
ZCAoJWQpLlxuIiwgcik7CisKKwkvKgorCSAqIHNldCB0byBsb3cgcHN0YXRlIGJ5IGRlZmF1bHQK
KwkgKiBUaGlzIHNob3VsZCBiZSBwZXJmb3JtZWQgYWZ0ZXIgYWxsIGRldmljZXMgZnJvbQorCSAq
IFhHTUkgZmluaXNoIHRoZWlyIGluaXRpYWxpemF0aW9ucy4gVGh1cyBpdCdzIG1vdmVkCisJICog
dG8gaGVyZS4KKwkgKiBUaGUgdGltZSBkZWxheSBpcyAyUy4gVE9ETzogY29uZmlybSB3aGV0aGVy
IHRoYXQKKwkgKiBpcyBlbm91Z2ggZm9yIGFsbCBwb3NzaWJsZSBYR01JIHNldHVwcy4KKwkgKi8K
KwlyID0gYW1kZ3B1X3hnbWlfc2V0X3BzdGF0ZShhZGV2LCAwKTsKKwlpZiAocikKKwkJRFJNX0VS
Uk9SKCJwc3RhdGUgc2V0dGluZyBmYWlsZWQgKCVkKS5cbiIsIHIpOwogfQogCiBzdGF0aWMgdm9p
ZCBhbWRncHVfZGV2aWNlX2RlbGF5X2VuYWJsZV9nZnhfb2ZmKHN0cnVjdCB3b3JrX3N0cnVjdCAq
d29yaykKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
