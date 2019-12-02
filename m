Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5828C432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13D220848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13D220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32BE56E2BC;
	Mon,  2 Dec 2019 17:35:09 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720044.outbound.protection.outlook.com [40.107.72.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 625EB6E2B0
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaTzZ2lVYCQ5XW/e46nphoyqpCfeuTOU8KECRc82e9+l4CsSqfWbC4BKE6R27nmBNFUAH7hzrNnCK0dwlN9pRALPoS8hPVwW3pO8mmWBUUoqnmYuUYTk6HBZ4pOX/P4UlghMtsKLVpr+cAPX0Fceg7XsEv489+S9+qVW4Wu1+X7STnH31fD0/WoLLug/qqgRPr7VBsTCIkR1XN+7jomWcMuWhC6fOW+5cwaiza5HKkQecQ/IA3cgbSi+OJ/a9JM6eRDYbMapcsFZxgvAoWqS8YKGMdXYZyr15di4QKWlWouwFs9scIQR0rcE34xJ//ZzOiB4J+esgnqZmiuLADHndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cdnd2C3VbIHM3j3MTwFJJo8ykYzLBX1jbFgwGumdbKQ=;
 b=YYVtv4P3f8P6SWezq01pnF96DbMXfdUoF6ZrhkTSWdmDv8Ir4xCBFgVya3eXV1aRx8DN2egOGVWR8i3/DGJJO2AM1YhKmWNMfImGwVNNU7IDU09FkQYJO6GnKqzwHwidV3ywZkROvi5Toj/WWeEXAQQnynLTM6M1K9pvzzBhVOvNL7qhZPgMYNNA4ystGsvqvI1vjFtqih1d45IriMRPrhwEznfG4aeMwReHI6FkuC9sovmmapWMLVtggy6ujqhLGvhgnfmxOndNHgAecxB4caYHynFM3slcNj+Wj90WvBr+3eYJUTQLrY4KWBb4oKgNPg0i7m1ZWe+s5eEHG+qtew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:05 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:05 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/51] drm/amd/display: Change the delay time before enabling
 FEC
Date: Mon,  2 Dec 2019 12:33:33 -0500
Message-Id: <20191202173405.31582-20-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202173405.31582-1-sunpeng.li@amd.com>
References: <20191202173405.31582-1-sunpeng.li@amd.com>
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 397a40a2-872b-4c0e-40ce-08d7774df7d6
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2802B35CCDA2F4ACBD41BE7C82430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(86362001)(6486002)(9686003)(6506007)(2870700001)(478600001)(386003)(76176011)(5660300002)(51416003)(186003)(1076003)(52116002)(3846002)(6116002)(47776003)(2616005)(26005)(66946007)(66066001)(25786009)(316002)(446003)(11346002)(14454004)(66476007)(66556008)(48376002)(8676002)(50226002)(305945005)(6512007)(36756003)(2906002)(14444005)(99286004)(6666004)(7736002)(2351001)(54906003)(4326008)(2361001)(6916009)(6436002)(50466002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2802;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NrfVnGtyCBoZQ6XSB4amqd0wq1dwVSRgc8cj2zwlOnnfR/PJgsvNfqDrzpdoqaJN9O+fZ+oJX0Ttc18R8ZgO03QaB5tylMhVzsozfqGaF4tNj0QGSD5p+bYRNXCy1bNLKVqxUnnLcniwmk7ZH9Jq+Wf9W64aPv+7WK/D72nWnTourAyTLYUefhPrZWHbbMhM8TZle2z5NXeHMmqLbJmhInMQFxLmCAakzjpjpQAR17pi539srXmtXIzgPRKXYzP09W1bRcuYEi+AoVykZc2bpsQeuWvtgIiqfgT94htqm3xm86MWv3XEMLcjweigDmpizVj8QpObHt1wY87APCguNzmNGjabKhy650GHcqZntQutvDBjA+bUKWMGFYs/HOAX7a0AUi1sjonHK9m8VNspECKEFGVqs/duoD+pZObXz2hVBo2bEV13LlqYQXBinQi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397a40a2-872b-4c0e-40ce-08d7774df7d6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:05.3423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PY1R5ulHZ+P031BQYIl7to9xTaY7EomHHZok/vEIpl6EVNDaxhe5vq688ewUoUpb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cdnd2C3VbIHM3j3MTwFJJo8ykYzLBX1jbFgwGumdbKQ=;
 b=xhL1aZM9sUJB+gElGoKxL0Amuprjy+DditQZSDAb+PQvM0G4LUcUTKbrnglpwc0oA7e3YewEYPfHdvASQHuFKnjvgaCErv+0f1OYYGNK5oDw33gUTIFDSZ/6DhY3W9aoW/4lsplHoY4bOtsunaOrI24u1FQrG3fNYJv+zjC4HxU=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
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
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 rodrigo.siqueira@amd.com, Nikola Cornij <Nikola.Cornij@amd.com>,
 "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogIkxlbyAoSGFuZ2hvbmcpIE1hIiA8aGFuZ2hvbmcubWFAYW1kLmNvbT4KClt3aHldCkRQ
IHNwZWMgcmVxdWlyZXMgMTAwMCBzeW1ib2xzIGRlbGF5IGJldHdlZW4gdGhlIGVuZCBvZiBsaW5r
IHRyYWluaW5nCmFuZCBlbmFibGluZyBGRUMgaW4gdGhlIHN0cmVhbS4gQ3VycmVudGx5IHdlIGFy
ZSB1c2luZyAxIG1pbGlzZWNvbmRzCmRlbGF5IHdoaWNoIGlzIG5vdCBhY2N1cmF0ZS4KCltob3dd
Ck9uZSBsYW5lIFJCUiBzaG91bGQgaGF2ZSB0aGUgbWF4aW11bSB0aW1lIGZvciB0cmFuc21pdHRp
bmcgMTAwMCBMTApjb2RlcyB3aGljaCBpcyA2LjE3MyB1cy4gU28gdXNpbmcgNyBtaWNyb3NlY29u
ZHMgZGVsYXkgaW5zdGVhZCBvZgoxIG1pbGlzZWNvbmRzLgoKU2lnbmVkLW9mZi1ieTogTGVvIChI
YW5naG9uZykgTWEgPGhhbmdob25nLm1hQGFtZC5jb20+ClJldmlld2VkLWJ5OiBIYXJyeSBXZW50
bGFuZCA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IE5pa29sYSBDb3JuaWog
PE5pa29sYS5Db3JuaWpAYW1kLmNvbT4KQWNrZWQtYnk6IExlbyBMaSA8c3VucGVuZy5saUBhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAu
YyB8IDkgKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUv
ZGNfbGlua19kcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlu
a19kcC5jCmluZGV4IDUzN2I0ZGVlOGYyMi4uYjEwMDE5MTA2MDMwIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jCkBAIC0zOTUxLDcgKzM5
NTEsMTQgQEAgdm9pZCBkcF9zZXRfZmVjX2VuYWJsZShzdHJ1Y3QgZGNfbGluayAqbGluaywgYm9v
bCBlbmFibGUpCiAJaWYgKGxpbmtfZW5jLT5mdW5jcy0+ZmVjX3NldF9lbmFibGUgJiYKIAkJCWxp
bmstPmRwY2RfY2Fwcy5mZWNfY2FwLmJpdHMuRkVDX0NBUEFCTEUpIHsKIAkJaWYgKGxpbmstPmZl
Y19zdGF0ZSA9PSBkY19saW5rX2ZlY19yZWFkeSAmJiBlbmFibGUpIHsKLQkJCW1zbGVlcCgxKTsK
KwkJCS8qIEFjY29yZCB0byBEUCBzcGVjLCBGRUMgZW5hYmxlIHNlcXVlbmNlIGNhbiBmaXJzdAor
CQkJICogYmUgdHJhbnNtaXR0ZWQgYW55dGltZSBhZnRlciAxMDAwIExMIGNvZGVzIGhhdmUKKwkJ
CSAqIGJlZW4gdHJhbnNtaXR0ZWQgb24gdGhlIGxpbmsgYWZ0ZXIgbGluayB0cmFpbmluZworCQkJ
ICogY29tcGxldGlvbi4gVXNpbmcgMSBsYW5lIFJCUiBzaG91bGQgaGF2ZSB0aGUgbWF4aW11bQor
CQkJICogdGltZSBmb3IgdHJhbnNtaXR0aW5nIDEwMDAgTEwgY29kZXMgd2hpY2ggaXMgNi4xNzMg
dXMuCisJCQkgKiBTbyB1c2UgNyBtaWNyb3NlY29uZHMgZGVsYXkgaW5zdGVhZC4KKwkJCSAqLwor
CQkJdWRlbGF5KDcpOwogCQkJbGlua19lbmMtPmZ1bmNzLT5mZWNfc2V0X2VuYWJsZShsaW5rX2Vu
YywgdHJ1ZSk7CiAJCQlsaW5rLT5mZWNfc3RhdGUgPSBkY19saW5rX2ZlY19lbmFibGVkOwogCQl9
IGVsc2UgaWYgKGxpbmstPmZlY19zdGF0ZSA9PSBkY19saW5rX2ZlY19lbmFibGVkICYmICFlbmFi
bGUpIHsKLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
