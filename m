Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68036C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435FE2184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435FE2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE4A36EA31;
	Tue, 12 Nov 2019 00:33:58 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800058.outbound.protection.outlook.com [40.107.80.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE1776EA32
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:33:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuNUSoWo5EgM38KvcfS4ZC+0fqa/FssvU4wdMEV0uC6muq2TPqQq67M6u7M2GW/D1z056T5Py+p3UGN2lO3TMZshTF2/EWZ6bseQL5N1kMmTRfFF13auffBO/C7ILWqaV1n0MDpUNKmph7Bhalr8skx9NlY0LpjqWwD9XZBvMXZ1/SQowIDjGU+L3K97/Jh8fKjXxONKuPEeQIW9w7mxkm4xB1ffP+X327WKk9/gB4Erjc7OrZVpPAa0GwYZ40WqvhGYFpqCF9QhbndJ1Ki+9bck6TNCBLsXlzxbToH3tAUb6OsKYQT0XClX/rZ4I7ZFJLy5lfTUKlFE7oDXn7RQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqJdZEA+EMuVzSo9Q0tkF/RACItQPOGh0XBE0T1yJI0=;
 b=gvQmTrIqzBoY20EVhxDF3sOa+xs3gmpD5E70ZfauMfdhi+wzr9h4HDec/S8dvWy6fFh65wOpUk6wCECOt1/RiWn0C+CBksLCZQnR+/eGwbu+QDfy22PIvjX5DO5X5DfO0PjpWCUg0pRvdDM7enI/opDQCdNHu2JmJrecB/aC8WP0jnvBOVtlanClWE5SfCKBFsfZf188coXPF0+ju+gEOZlg1bIc49BKjVYgFeL0zfpYkit7+4fHpen23IirbdtdG0E/8SnayMi0XPFqmAZMOgpTfGh/VT29QkjFCPv0NimjRXZDTO37HbKxpXH5HpI3ZZPC0IBFecZeKm8ZStQffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:33:56 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:33:56 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/30] drm/amd/display: Fix debugfs on MST connectors
Date: Mon, 11 Nov 2019 19:33:10 -0500
Message-Id: <20191112003324.8419-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
References: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da6804b2-3f81-4efa-264a-08d767080088
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2554E6F0F16AD7A5906A973798770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(5024004)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXCJDRGbEV1t8RQnT92x7uKmr+1OewVgZLY9MYHoEpDdsKPfc+RH90c80y7fUMTtuOIPPfQlvA8TdpsO/+9UQ4SOXQvX+VKpDsrlBAMaRx+ag/hBu8C9sacl+viBuC0985H4n+RDlEWNfsKcRbx04ejgscL04qZVJUMVav+6h4AJi95Q3zieCOUOJqC9ySzaqvzT/IkE7kX7nNC6VmOch1eMw/EdL5BhMrOHuY9eIymNFRGt1A/goG52AQivfzxn1A88U7cDdAlHZ6axmF8FppW3kU7GywUVzgxI7izlHABxKs0pBNxX2MJH3S5N7pCbNfLHNrgH3JtphtX7r4Q9+pijSF5MbceLfTSz+uIG33H/uhvJ+qxrYbsrS8MzdaYKQK4yeaYnnEzvh5MH9tLow3i5I3jrpiuPOiK18BuR1S8MIlFJkdaniXyhaY026O0l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6804b2-3f81-4efa-264a-08d767080088
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:33:56.4815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGYP9SW5Lo9YWfnEkir6sNwui7fmbh7HwP+Va33vpb2VTLEnhnhjZzEvlWSmEB3rp8pIWcRcdO2Q/gWXDCzX5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqJdZEA+EMuVzSo9Q0tkF/RACItQPOGh0XBE0T1yJI0=;
 b=ppMEWdywiBp1AcjR7WK+jrQT0ssXpPXK5Lz+z0y4jMZ8ewuYnRHUdPn25D4bwVcDkC/nltQ/miK/BEU4Uqg+knMpGi8aiFa6Q/o9/RvBrNNwb4v0pGREufvXNTS/IV6ha+jBKJNfGc+bZPynZ/J9WvrqwVu7tLROB9sQoCkcxUA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
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
Cc: Mikita Lipski <mikita.lipski@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003310.R5axzf2sM6jPCpdfAC0VrUoeY84WWY2fwH0baASHlko@z>

RnJvbTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgoKW3doeV0KUHJldmlv
dXMgcGF0Y2ggYWxsb3dlZCB0byBpbml0aWFsaXplIGRlYnVnZnMgZW50cmllcyBvbiBib3RoIE1T
VAphbmQgU1NUIGNvbm5lY3RvcnMsIGJ1dCBNU1QgY29ubmVjdG9ycyBnZXQgcmVnaXN0ZXJlZCBt
dWNoIGxhdGVyCndoaWNoIGV4cG9zZWQgYW4gaXNzdWUgb2YgZGVidWdmcyBlbnRyaWVzIGJlaW5n
IGluaXRpYWxpemVkIGluIHRoZQpzYW1lIGZvbGRlci4KCltob3ddClJldHVybiBTU1QgZGVidWdm
cyBlbnRyaWVzJyBpbml0aWFsaXphdGlvbiBiYWNrIHRvIHdoZXJlIGl0IHdhcy4KRm9yIE1TVCBj
b25uZWN0b3JzIHdlIHNob3VsZCBpbml0aWFsaXplIGRlYnVnZnMgZW50cmllcyBpbiBjb25uZWN0
b3IKcmVnaXN0ZXIgZnVuY3Rpb24gYWZ0ZXIgdGhlIGNvbm5lY3RvciBpcyByZWdpc3RlcmVkLgoK
U2lnbmVkLW9mZi1ieTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgpSZXZp
ZXdlZC1ieTogTmljaG9sYXMgS2F6bGF1c2thcyA8TmljaG9sYXMuS2F6bGF1c2thc0BhbWQuY29t
PgpBY2tlZC1ieTogUm9kcmlnbyBTaXF1ZWlyYSA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAx
NSArKysrKysrLS0tLS0tLS0KIC4uLi9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21z
dF90eXBlcy5jICAgfCAxMCArKysrKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlv
bnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKaW5kZXggMDVlMDE5NWQwMDA1Li41NTczYzVkOWIzMjgg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYwpAQCAtNTY2MSwxMiArNTY2MSw2IEBAIHZvaWQgYW1kZ3B1X2RtX2Nvbm5lY3Rvcl9pbml0
X2hlbHBlcihzdHJ1Y3QgYW1kZ3B1X2Rpc3BsYXlfbWFuYWdlciAqZG0sCiAJCWRybV9vYmplY3Rf
YXR0YWNoX3Byb3BlcnR5KCZhY29ubmVjdG9yLT5iYXNlLmJhc2UsCiAJCQkJYWRldi0+bW9kZV9p
bmZvLmZyZWVzeW5jX2NhcGFibGVfcHJvcGVydHksIDApOwogCX0KLQotI2lmIGRlZmluZWQoQ09O
RklHX0RFQlVHX0ZTKQotCWNvbm5lY3Rvcl9kZWJ1Z2ZzX2luaXQoYWNvbm5lY3Rvcik7Ci0JYWNv
bm5lY3Rvci0+ZGVidWdmc19kcGNkX2FkZHJlc3MgPSAwOwotCWFjb25uZWN0b3ItPmRlYnVnZnNf
ZHBjZF9zaXplID0gMDsKLSNlbmRpZgogfQogCiBzdGF0aWMgaW50IGFtZGdwdV9kbV9pMmNfeGZl
cihzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmkyY19hZGFwLApAQCAtNTc4OSw4ICs1NzgzLDYgQEAgc3Rh
dGljIGludCBhbWRncHVfZG1fY29ubmVjdG9yX2luaXQoc3RydWN0IGFtZGdwdV9kaXNwbGF5X21h
bmFnZXIgKmRtLAogCQkJJmFjb25uZWN0b3ItPmJhc2UsCiAJCQkmYW1kZ3B1X2RtX2Nvbm5lY3Rv
cl9oZWxwZXJfZnVuY3MpOwogCi0JZHJtX2Nvbm5lY3Rvcl9yZWdpc3RlcigmYWNvbm5lY3Rvci0+
YmFzZSk7Ci0KIAlhbWRncHVfZG1fY29ubmVjdG9yX2luaXRfaGVscGVyKAogCQlkbSwKIAkJYWNv
bm5lY3RvciwKQEAgLTU4MDEsNiArNTc5MywxMyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kbV9jb25u
ZWN0b3JfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rpc3BsYXlfbWFuYWdlciAqZG0sCiAJZHJtX2Nvbm5l
Y3Rvcl9hdHRhY2hfZW5jb2RlcigKIAkJJmFjb25uZWN0b3ItPmJhc2UsICZhZW5jb2Rlci0+YmFz
ZSk7CiAKKwlkcm1fY29ubmVjdG9yX3JlZ2lzdGVyKCZhY29ubmVjdG9yLT5iYXNlKTsKKyNpZiBk
ZWZpbmVkKENPTkZJR19ERUJVR19GUykKKwljb25uZWN0b3JfZGVidWdmc19pbml0KGFjb25uZWN0
b3IpOworCWFjb25uZWN0b3ItPmRlYnVnZnNfZHBjZF9hZGRyZXNzID0gMDsKKwlhY29ubmVjdG9y
LT5kZWJ1Z2ZzX2RwY2Rfc2l6ZSA9IDA7CisjZW5kaWYKKwogCWlmIChjb25uZWN0b3JfdHlwZSA9
PSBEUk1fTU9ERV9DT05ORUNUT1JfRGlzcGxheVBvcnQKIAkJfHwgY29ubmVjdG9yX3R5cGUgPT0g
RFJNX01PREVfQ09OTkVDVE9SX2VEUCkKIAkJYW1kZ3B1X2RtX2luaXRpYWxpemVfZHBfY29ubmVj
dG9yKGRtLCBhY29ubmVjdG9yKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMKaW5kZXggMWExN2VhMWI0
MmUwLi4yYTA1MzgyZDU0OGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jCkBAIC0zNiw3ICszNiw5
IEBACiAjaW5jbHVkZSAiZGNfbGlua19kZGMuaCIKIAogI2luY2x1ZGUgImkyY2F1eF9pbnRlcmZh
Y2UuaCIKLQorI2lmIGRlZmluZWQoQ09ORklHX0RFQlVHX0ZTKQorI2luY2x1ZGUgImFtZGdwdV9k
bV9kZWJ1Z2ZzLmgiCisjZW5kaWYKIC8qICNkZWZpbmUgVFJBQ0VfRFBDRCAqLwogCiAjaWZkZWYg
VFJBQ0VfRFBDRApAQCAtMTYyLDYgKzE2NCwxMiBAQCBhbWRncHVfZG1fbXN0X2Nvbm5lY3Rvcl9s
YXRlX3JlZ2lzdGVyKHN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25uZWN0b3IpCiAJCXRvX2FtZGdw
dV9kbV9jb25uZWN0b3IoY29ubmVjdG9yKTsKIAlzdHJ1Y3QgZHJtX2RwX21zdF9wb3J0ICpwb3J0
ID0gYW1kZ3B1X2RtX2Nvbm5lY3Rvci0+cG9ydDsKIAorI2lmIGRlZmluZWQoQ09ORklHX0RFQlVH
X0ZTKQorCWNvbm5lY3Rvcl9kZWJ1Z2ZzX2luaXQoYW1kZ3B1X2RtX2Nvbm5lY3Rvcik7CisJYW1k
Z3B1X2RtX2Nvbm5lY3Rvci0+ZGVidWdmc19kcGNkX2FkZHJlc3MgPSAwOworCWFtZGdwdV9kbV9j
b25uZWN0b3ItPmRlYnVnZnNfZHBjZF9zaXplID0gMDsKKyNlbmRpZgorCiAJcmV0dXJuIGRybV9k
cF9tc3RfY29ubmVjdG9yX2xhdGVfcmVnaXN0ZXIoY29ubmVjdG9yLCBwb3J0KTsKIH0KIAotLSAK
Mi4yNC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
