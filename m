Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DC7CA9EBB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 21:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840EB21928
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 21:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840EB21928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3735D6E7E2;
	Thu, 24 Oct 2019 21:14:22 +0000 (UTC)
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr810085.outbound.protection.outlook.com [40.107.81.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B40926E7E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 21:14:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dz7r2MveeoS9SLDreO/ZPc/HvYjTD+CaAKGHAIrjq3ic4R+T0PfCzTO+xjo9rKkF6bnwDB0/m2aXIMd4eg2Rp/MDy5gmxY+lEmAjaTXsoBofGjyjUs3IQ6HUWgwMNDJMzVoe/fJDlBRQJLf6v5axIS7UX7nzJWLvMIDqM34QNmqd00/G6qlxn2nPcptQXpOLQF9Sf0OystyrNPIuz8y0BqEwFJHCxoBOPXEVUdlTsc0sHtuShJyNRWKmAUQsE/aKl0Ye8eN5Gy+r9n5LRK78GWjNKyJelqMphGtvClTmWuUwDNyF9iRnO3PrZ4Pd/OglWUt2sY0mawg2pgjHDGmswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpUZdneTOUoZFlYXjExOw1cUjpOFFGjfa8L3G/vPYNU=;
 b=MgzwRb5CyFNNTzshehMBgV6J2kNrzqOn3J+RHMw4Pz0FFb83YRSkg+/mclG6B6HSw2jyFUweLP3WYPM7wf66YJ/OjNoQA/wTWiSvkrTGBcIZm/OZytzL6GgBX3P1Z9h1xELvbAE19aHFI/vJ+XX6bEsTCdVFxU9eGYKx0lV9mARsU8+xMm3C4XY8zF3cAb6gWzgdzML4RJ89Rq2cDLdBaseQQjfr++bUkthTT9nDdeyOr59HC1uRP2xyqO2me1h2fjRoWtBiJpx5OuxLN3YHfGZYpYRfQMj43EiJrtKZr8BL1lrtSdUdxVe898e2uTo1/eF+GdDpSrkSOMoi2afy/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB2634.namprd12.prod.outlook.com (20.176.116.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 24 Oct 2019 21:14:17 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e%7]) with mapi id 15.20.2367.022; Thu, 24 Oct 2019
 21:14:17 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Delete duplicated queue bit map reservation
Thread-Topic: [PATCH] drm/amdkfd: Delete duplicated queue bit map reservation
Thread-Index: AQHViq/+pfN5s8nB6Uef1g1LFxHsWg==
Date: Thu, 24 Oct 2019 21:14:17 +0000
Message-ID: <20191024211402.29915-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::31) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ee8d073-f4b3-49ad-709a-08d758c72106
x-ms-traffictypediagnostic: DM6PR12MB2634:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB263465CCF6DBF9D548ACBF40F06A0@DM6PR12MB2634.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(5660300002)(66066001)(5640700003)(256004)(186003)(2351001)(3846002)(486006)(6916009)(2616005)(476003)(6436002)(14454004)(99286004)(36756003)(6512007)(6486002)(52116002)(86362001)(386003)(25786009)(4326008)(8676002)(6506007)(2501003)(8936002)(50226002)(66556008)(316002)(102836004)(66476007)(66946007)(26005)(64756008)(66446008)(305945005)(1076003)(478600001)(6116002)(4744005)(81156014)(2906002)(81166006)(71190400001)(71200400001)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2634;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hnuVlXQJJ+hbUa9bFZJMQjybbLklstRWMpIeEXxfrRUX46DMVz0NJP5Yum4SPxfgcDbmQ6La94AC52Yiwc6euA2ON6Jcfe6fj3gQ1Gq9MrAjxhKjUvjLiYRPlbh0NGRmqj1WbnJvGEEBF/RVT+RRG0HeWZ91u2IlpuZeDElga4W/rmFF2ZnnUHlbHLVChCZYSTZgum0mwSJzgR3GENT+5uqJOpEJ+zKXg5S26pcpgx7LlqGs39jhwoDZW8qnSq5xfpWpwBAlTrnXpXH3mHeyQdF0b651emd1W2g5FmhVEEeaJcPqLjMEFp9kSoEQmrPGSp/CerMV/dKDxfjMsWyZUsVAcTcuovd9RK2Ijll5Tok+Kk+1yZoZKTFs9QOuGSLyfXqtCNAuX2hsqoIoLrRQWNm65Q7UHHMixTtg6QZdiok37LDlR2NU49wIem//Cr3n
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee8d073-f4b3-49ad-709a-08d758c72106
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 21:14:17.3969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uuY0OMW4BYPaD1gMAswB96B967GWYyWBX6eWoMGuqAXFLQidwxaG2Hoy/N3uaIgw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2634
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpUZdneTOUoZFlYXjExOw1cUjpOFFGjfa8L3G/vPYNU=;
 b=YjRwVqwkR6u9CZuUwi7e0UTkmQn16/KihGXQ67X6q541xiKr5UoPh0SHcjnVytYNR+T5ayuTk28xprX4CNXZGcp77MkHWFx1QJeAJL/ivtmmt0GIWtqvrTCClSudM81sdq1TSyZk9a8OW1NPZp2/62rIjDFMpnVK3kDxwpm6oLM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Message-ID: <20191024211417.PFFAqKGscSBcGjaHPRZlR6wP9gpgZIMT6yxig_yjqk8@z>

VGhlIEtJUSBpcyBvbiB0aGUgc2Vjb25kIE1FQyBhbmQgaXRzIHJlc2VydmF0aW9uIGlzIGNvdmVy
ZWQgaW4gdGhlCmxhdHRlciBsb2dpYywgc28gbm8gbmVlZCB0byByZXNlcnZlIGl0cyBiaXQgdHdp
Y2UuCgpDaGFuZ2UtSWQ6IEllZWUzOTA5NTNhNjBjN2Q0M2RlNWE5YWVjMzg4MDNmMWY1ODNhNGE5
ClNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jIHwgOCAtLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZC5jCmluZGV4IDhjNTMxNzkzZmUxNy4uZDNkYTlkZGU0ZWUxIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCkBAIC0xMzAsMTQgKzEzMCw2IEBA
IHZvaWQgYW1kZ3B1X2FtZGtmZF9kZXZpY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKIAkJCQkgIGFkZXYtPmdmeC5tZWMucXVldWVfYml0bWFwLAogCQkJCSAgS0dEX01BWF9RVUVV
RVMpOwogCi0JCS8qIHJlbW92ZSB0aGUgS0lRIGJpdCBhcyB3ZWxsICovCi0JCWlmIChhZGV2LT5n
Zngua2lxLnJpbmcuc2NoZWQucmVhZHkpCi0JCQljbGVhcl9iaXQoYW1kZ3B1X2dmeF9tZWNfcXVl
dWVfdG9fYml0KGFkZXYsCi0JCQkJCQkJICBhZGV2LT5nZngua2lxLnJpbmcubWUgLSAxLAotCQkJ
CQkJCSAgYWRldi0+Z2Z4LmtpcS5yaW5nLnBpcGUsCi0JCQkJCQkJICBhZGV2LT5nZngua2lxLnJp
bmcucXVldWUpLAotCQkJCSAgZ3B1X3Jlc291cmNlcy5xdWV1ZV9iaXRtYXApOwotCiAJCS8qIEFj
Y29yZGluZyB0byBsaW51eC9iaXRtYXAuaCB3ZSBzaG91bGRuJ3QgdXNlIGJpdG1hcF9jbGVhciBp
ZgogCQkgKiBuYml0cyBpcyBub3QgY29tcGlsZSB0aW1lIGNvbnN0YW50CiAJCSAqLwotLSAKMi4x
Ny4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
