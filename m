Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3252BC432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 21:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E092068F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 21:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E092068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C84596E1A8;
	Thu, 21 Nov 2019 21:25:42 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720052.outbound.protection.outlook.com [40.107.72.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC5C36E1A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 21:25:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ix9ZBhNP9+zQ1KGbkeGesPYEz9ueO0s9rnIpfzJN9X/KK8W7qnE5mw7gZjRd/diy2gWzvzpbk4k2Z8pqTWABkxjN0tbg79F0r2EiGTtgTsXQ/Ufi/gcouLfJDFGaW8Xh0jE0GbRvfpGWe6WCgFu2TtNqrrB/zWitxnSr1LxqofioLl31x3SzW9UlBbj/iYtovDPFpbC2i5gopVSNrz5UDNycZXlKbxhocIdqJ7Do1bMpxYNaLbMmv5/5AcwxihOye9x6TUMdkqc/MCPcgI66Ef0FZlgh5aKRCin9QowLQHswo3sQPaQzcz3ZylD/d+yN26bmZrP3Om6OjF2g9UmS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giZ0IgI6huiSU4ufH+/KsGxSBKpwGQhbw6eg3vyJ6JI=;
 b=ekEMb9797H/z8jhpiyu6XC3JIQhBjxfjmHVWuMr82P4InpW8gh4LxqdV08SkuDaLRFRrcbntty6QUFqJceA1oJmWux00SMmbF9anmePftM7eFDb4Lo966PxmJY528onqnUMZCQgAeO7vFqe0gKFknlMNRcFiLvVJAlzILOHjKxjZTq9bTHx6MzDkBA4/PzLVYap4XQ942liCYcLDpjecjQeciPUNE5Vwzbl8+Fn6q3+cLGaFTC6LpYZWh5WZu9UNZkEJ/4Pk7hZpqp2TvCc6k9HExRSTSRy9bgl/fOLJpbXBBL/OyniJsi8YZUkAvaCtVgKZoZbL2HMuS1ASORdQ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Thu, 21 Nov 2019 21:25:36 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2451.031; Thu, 21 Nov 2019
 21:25:36 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Remove duplicate functions update_mqd_hiq()
Date: Thu, 21 Nov 2019 16:25:24 -0500
Message-Id: <20191121212524.3946-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::25)
 To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13235635-b40d-46ec-06d7-08d76ec95967
X-MS-TrafficTypeDiagnostic: DM6PR12MB2682:|DM6PR12MB2682:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2682E36F0385F5FC85F61DABF04E0@DM6PR12MB2682.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-Forefront-PRVS: 0228DDDDD7
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(6506007)(478600001)(14444005)(47776003)(6666004)(7736002)(305945005)(66066001)(16586007)(5660300002)(186003)(86362001)(4326008)(2906002)(52116002)(51416003)(99286004)(36756003)(26005)(386003)(316002)(2361001)(3846002)(48376002)(2616005)(66946007)(66556008)(66476007)(8936002)(6486002)(81166006)(81156014)(8676002)(6436002)(6916009)(6512007)(2351001)(15650500001)(25786009)(6116002)(14454004)(50466002)(1076003)(50226002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2682;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9v09ehaedd+iXkY6ry2lxuDlFqNLIwnXhhJVWYJxL2IOebzcK/jWaKmCb+tu9Ra61bU/K/Z2+xtWUnjXs3lJUQRZqvP5iTPAXZ6Rq4EuduPkCZH+Bh+kAEsu5qRsA/0KMQ/fEfUtLeiUm61A6tTjzt1M6iv5g5kAtCOEf7EP1nM76UGdH1ep0OcX3zb7M+PL1DForOvOBk0yiTpXtDsnZ3QHzXBaVG9tos9vX/bNwXdd+dJUokVnSfY/tRZqsS4lOknY+Tv3dT0f//vjK1xhevKkU2C9KwnKW+NCxgEzAWDK17v5lCC8kHXcjqscuUMLRa8UEx1V1AyXamMVoZS/Xg+719DaPdUuglXSrAJ/GLIpvI3+YvlRJTwwPgQrBfNv8pcoKjpc9dt/P2X3UBqYapuwWJM2zqmjTrhUcLMF4koDEXIvJTozMl1ykchVY0NB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13235635-b40d-46ec-06d7-08d76ec95967
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 21:25:36.5939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xmb+0scWp51ltv4HWpQVZPdD6FP0pcHRAubIQcdP3CK6DJdt/OXnpSXhUkmyHhQo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giZ0IgI6huiSU4ufH+/KsGxSBKpwGQhbw6eg3vyJ6JI=;
 b=RmmqLUOW/5Hjp7ESHvNZUYdSw6mDrFMdQ/jmM1J3Fdk9iCZfSBTmu+kdbINJb2xW4ytcvQ2x3ganUo76Wt11iOLNaD0ae+iI+w8PVdDVAb1bAac4RSQRQfYNY7bxIDEWEjJTaWpfOXfFvFpn8wn4SB+Vh7FLXuW073Baxtxpujk=
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191121212524.6ecd1cFm4-UqBFDtH-Ujcx_gNq7REB4eYLVARKO6usQ@z>

VGhlIGZ1bmN0aW9ucyBhcmUgdGhlIHNhbWUgYXMgdXBkYXRlX21xZCgpLgoKQ2hhbmdlLUlkOiBJ
YzhkOGYyM2NkZGU2Yjc4MDZhYjc2NmRkZjNkNzFmYTY2OGNjYTVmYgpTaWduZWQtb2ZmLWJ5OiBZ
b25nIFpoYW8gPFlvbmcuWmhhb0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYyB8IDE2ICsrLS0tLS0tLS0tLS0tLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5jICB8IDE2ICsrLS0tLS0tLS0t
LS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92aS5jICB8
ICA0IC0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzMiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFn
ZXJfdjEwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEw
LmMKaW5kZXggOGQyMTMyNWI1Y2JiLi43ODMyZWM2ZTQ4MGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEwLmMKQEAgLTI4MiwxOCArMjgyLDYg
QEAgc3RhdGljIHZvaWQgaW5pdF9tcWRfaGlxKHN0cnVjdCBtcWRfbWFuYWdlciAqbW0sIHZvaWQg
KiptcWQsCiAJCQkxIDw8IENQX0hRRF9QUV9DT05UUk9MX19LTURfUVVFVUVfX1NISUZUOwogfQog
Ci1zdGF0aWMgdm9pZCB1cGRhdGVfbXFkX2hpcShzdHJ1Y3QgbXFkX21hbmFnZXIgKm1tLCB2b2lk
ICptcWQsCi0JCQlzdHJ1Y3QgcXVldWVfcHJvcGVydGllcyAqcSkKLXsKLQlzdHJ1Y3QgdjEwX2Nv
bXB1dGVfbXFkICptOwotCi0JdXBkYXRlX21xZChtbSwgbXFkLCBxKTsKLQotCS8qIFRPRE86IHdo
YXQncyB0aGUgcG9pbnQ/IHVwZGF0ZV9tcWQgYWxyZWFkeSBkb2VzIHRoaXMuICovCi0JbSA9IGdl
dF9tcWQobXFkKTsKLQltLT5jcF9ocWRfdm1pZCA9IHEtPnZtaWQ7Ci19Ci0KIHN0YXRpYyB2b2lk
IGluaXRfbXFkX3NkbWEoc3RydWN0IG1xZF9tYW5hZ2VyICptbSwgdm9pZCAqKm1xZCwKIAkJc3Ry
dWN0IGtmZF9tZW1fb2JqICptcWRfbWVtX29iaiwgdWludDY0X3QgKmdhcnRfYWRkciwKIAkJc3Ry
dWN0IHF1ZXVlX3Byb3BlcnRpZXMgKnEpCkBAIC00MjIsNyArNDEwLDcgQEAgc3RydWN0IG1xZF9t
YW5hZ2VyICptcWRfbWFuYWdlcl9pbml0X3YxMChlbnVtIEtGRF9NUURfVFlQRSB0eXBlLAogCQlt
cWQtPmluaXRfbXFkID0gaW5pdF9tcWRfaGlxOwogCQltcWQtPmZyZWVfbXFkID0gZnJlZV9tcWRf
aGlxX3NkbWE7CiAJCW1xZC0+bG9hZF9tcWQgPSBsb2FkX21xZDsKLQkJbXFkLT51cGRhdGVfbXFk
ID0gdXBkYXRlX21xZF9oaXE7CisJCW1xZC0+dXBkYXRlX21xZCA9IHVwZGF0ZV9tcWQ7CiAJCW1x
ZC0+ZGVzdHJveV9tcWQgPSBkZXN0cm95X21xZDsKIAkJbXFkLT5pc19vY2N1cGllZCA9IGlzX29j
Y3VwaWVkOwogCQltcWQtPm1xZF9zaXplID0gc2l6ZW9mKHN0cnVjdCB2MTBfY29tcHV0ZV9tcWQp
OwpAQCAtNDM2LDcgKzQyNCw3IEBAIHN0cnVjdCBtcWRfbWFuYWdlciAqbXFkX21hbmFnZXJfaW5p
dF92MTAoZW51bSBLRkRfTVFEX1RZUEUgdHlwZSwKIAkJbXFkLT5pbml0X21xZCA9IGluaXRfbXFk
X2hpcTsKIAkJbXFkLT5mcmVlX21xZCA9IGZyZWVfbXFkOwogCQltcWQtPmxvYWRfbXFkID0gbG9h
ZF9tcWQ7Ci0JCW1xZC0+dXBkYXRlX21xZCA9IHVwZGF0ZV9tcWRfaGlxOworCQltcWQtPnVwZGF0
ZV9tcWQgPSB1cGRhdGVfbXFkOwogCQltcWQtPmRlc3Ryb3lfbXFkID0gZGVzdHJveV9tcWQ7CiAJ
CW1xZC0+aXNfb2NjdXBpZWQgPSBpc19vY2N1cGllZDsKIAkJbXFkLT5tcWRfc2l6ZSA9IHNpemVv
ZihzdHJ1Y3QgdjEwX2NvbXB1dGVfbXFkKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMKaW5kZXggZGY3N2Q2N2VjOWFhLi5hYTkwMTA5OTVlYWYg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92
OS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5j
CkBAIC0zMjUsMTggKzMyNSw2IEBAIHN0YXRpYyB2b2lkIGluaXRfbXFkX2hpcShzdHJ1Y3QgbXFk
X21hbmFnZXIgKm1tLCB2b2lkICoqbXFkLAogCQkJMSA8PCBDUF9IUURfUFFfQ09OVFJPTF9fS01E
X1FVRVVFX19TSElGVDsKIH0KIAotc3RhdGljIHZvaWQgdXBkYXRlX21xZF9oaXEoc3RydWN0IG1x
ZF9tYW5hZ2VyICptbSwgdm9pZCAqbXFkLAotCQkJc3RydWN0IHF1ZXVlX3Byb3BlcnRpZXMgKnEp
Ci17Ci0Jc3RydWN0IHY5X21xZCAqbTsKLQotCXVwZGF0ZV9tcWQobW0sIG1xZCwgcSk7Ci0KLQkv
KiBUT0RPOiB3aGF0J3MgdGhlIHBvaW50PyB1cGRhdGVfbXFkIGFscmVhZHkgZG9lcyB0aGlzLiAq
LwotCW0gPSBnZXRfbXFkKG1xZCk7Ci0JbS0+Y3BfaHFkX3ZtaWQgPSBxLT52bWlkOwotfQotCiBz
dGF0aWMgdm9pZCBpbml0X21xZF9zZG1hKHN0cnVjdCBtcWRfbWFuYWdlciAqbW0sIHZvaWQgKipt
cWQsCiAJCXN0cnVjdCBrZmRfbWVtX29iaiAqbXFkX21lbV9vYmosIHVpbnQ2NF90ICpnYXJ0X2Fk
ZHIsCiAJCXN0cnVjdCBxdWV1ZV9wcm9wZXJ0aWVzICpxKQpAQCAtNDYyLDcgKzQ1MCw3IEBAIHN0
cnVjdCBtcWRfbWFuYWdlciAqbXFkX21hbmFnZXJfaW5pdF92OShlbnVtIEtGRF9NUURfVFlQRSB0
eXBlLAogCQltcWQtPmluaXRfbXFkID0gaW5pdF9tcWRfaGlxOwogCQltcWQtPmZyZWVfbXFkID0g
ZnJlZV9tcWRfaGlxX3NkbWE7CiAJCW1xZC0+bG9hZF9tcWQgPSBsb2FkX21xZDsKLQkJbXFkLT51
cGRhdGVfbXFkID0gdXBkYXRlX21xZF9oaXE7CisJCW1xZC0+dXBkYXRlX21xZCA9IHVwZGF0ZV9t
cWQ7CiAJCW1xZC0+ZGVzdHJveV9tcWQgPSBkZXN0cm95X21xZDsKIAkJbXFkLT5pc19vY2N1cGll
ZCA9IGlzX29jY3VwaWVkOwogCQltcWQtPm1xZF9zaXplID0gc2l6ZW9mKHN0cnVjdCB2OV9tcWQp
OwpAQCAtNDc1LDcgKzQ2Myw3IEBAIHN0cnVjdCBtcWRfbWFuYWdlciAqbXFkX21hbmFnZXJfaW5p
dF92OShlbnVtIEtGRF9NUURfVFlQRSB0eXBlLAogCQltcWQtPmluaXRfbXFkID0gaW5pdF9tcWRf
aGlxOwogCQltcWQtPmZyZWVfbXFkID0gZnJlZV9tcWQ7CiAJCW1xZC0+bG9hZF9tcWQgPSBsb2Fk
X21xZDsKLQkJbXFkLT51cGRhdGVfbXFkID0gdXBkYXRlX21xZF9oaXE7CisJCW1xZC0+dXBkYXRl
X21xZCA9IHVwZGF0ZV9tcWQ7CiAJCW1xZC0+ZGVzdHJveV9tcWQgPSBkZXN0cm95X21xZDsKIAkJ
bXFkLT5pc19vY2N1cGllZCA9IGlzX29jY3VwaWVkOwogCQltcWQtPm1xZF9zaXplID0gc2l6ZW9m
KHN0cnVjdCB2OV9tcWQpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX21xZF9tYW5hZ2VyX3ZpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFk
X21hbmFnZXJfdmkuYwppbmRleCAzYjZiNTY3MTk2NGMuLmE1ZThmZjFlNTk0NSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3ZpLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3ZpLmMKQEAgLTMxMiwx
MSArMzEyLDcgQEAgc3RhdGljIHZvaWQgaW5pdF9tcWRfaGlxKHN0cnVjdCBtcWRfbWFuYWdlciAq
bW0sIHZvaWQgKiptcWQsCiBzdGF0aWMgdm9pZCB1cGRhdGVfbXFkX2hpcShzdHJ1Y3QgbXFkX21h
bmFnZXIgKm1tLCB2b2lkICptcWQsCiAJCQlzdHJ1Y3QgcXVldWVfcHJvcGVydGllcyAqcSkKIHsK
LQlzdHJ1Y3QgdmlfbXFkICptOwogCV9fdXBkYXRlX21xZChtbSwgbXFkLCBxLCBNVFlQRV9VQywg
MCk7Ci0KLQltID0gZ2V0X21xZChtcWQpOwotCW0tPmNwX2hxZF92bWlkID0gcS0+dm1pZDsKIH0K
IAogc3RhdGljIHZvaWQgaW5pdF9tcWRfc2RtYShzdHJ1Y3QgbXFkX21hbmFnZXIgKm1tLCB2b2lk
ICoqbXFkLAotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
