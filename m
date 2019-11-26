Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F37C432C3
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 11:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3885020722
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 11:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3885020722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C09EF6E30C;
	Tue, 26 Nov 2019 11:50:42 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700067.outbound.protection.outlook.com [40.107.70.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 593416E2FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 11:50:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONYB0hCBvpeT+ujeiDrAldyUMok9inhvVvPDmFWf9IEl6/OJKuh4Ygu4r3v/TVdJrVmWmaNJ68kJpN5uMeAmHI3tiJ1BSCNI8jfdHQSrhtaM3QgsfdXTG914a9QPMx8XvIw78hHbj+kNIrOh2ZjfXaiO9UHGwQGjCxfTennv2O2Kb4pycebOSJc4i4PXD82aKzVuLUFuWH1RmRYrsaUvxlC/hkHZbRpuUd5zhjmcI6GJPM9tIpMcRCpGKTHx+wswiTh9/A/kcXz+X3PMom6y1M+gXcX66UeB9muA7YarlbTh3/tufL1HhPfTlattX/KvpK1X5T1/zwOMEG+1ojqEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfBNrF0+Az51t37sP3OP+ctKvp4PFpG97kPuEvC1AaU=;
 b=WT2AjgX1kfzdZErO3m2OChstyO5SEoQ2el/QAH8OfdTG1BWtHc9Ml3qksmoH+sC8VKUgJf+YKOa97vjpJsjcqBnLKFoADkFbwbDbBAFFKhA6R7g6GsAWnl/s33PuGB7YNdmLUALWnd+lGCPOr/naKHHsVLm9uA1iZpJdY4RVjV49vofnJem3sIdxpBHEwihK34eO6dQPIrYZ5nFqp4/fgLgfHZ0CV3pGKD2B5upX+QnkhuKliMCaxljxe5H0txwl/8rTCZVT2V1sQP7ZlIZn5J7LUxHGE06Dy+Ts5/rGBb1rKKlTeQolA8xlSJg0v5az1xKm5ZARGlhYGvIEn/1+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from SN1PR12CA0055.namprd12.prod.outlook.com (2603:10b6:802:20::26)
 by MWHPR12MB1757.namprd12.prod.outlook.com (2603:10b6:300:111::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Tue, 26 Nov
 2019 11:50:38 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::207) by SN1PR12CA0055.outlook.office365.com
 (2603:10b6:802:20::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 11:50:38 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Tue, 26 Nov 2019 11:50:37 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 26 Nov
 2019 05:50:37 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 26 Nov 2019 05:50:36 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu: fix calltrace during kmd unload
Date: Tue, 26 Nov 2019 19:50:24 +0800
Message-ID: <1574769024-30611-5-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
References: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(428003)(199004)(189003)(6666004)(356004)(478600001)(51416003)(76176011)(7696005)(8676002)(6916009)(4326008)(2351001)(5660300002)(14444005)(86362001)(2906002)(81156014)(81166006)(305945005)(186003)(16586007)(336012)(50226002)(446003)(426003)(11346002)(2616005)(50466002)(48376002)(47776003)(316002)(36756003)(70206006)(53416004)(8936002)(70586007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1757; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84cad4a8-9f89-423a-b22b-08d77266dadb
X-MS-TrafficTypeDiagnostic: MWHPR12MB1757:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1757987E89DB4785E7AC316884450@MWHPR12MB1757.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 0233768B38
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRhTBm0t5F8/tzoAwvIHmWH0jz6r5YmgYcA18k6j32JhwRGsGws86VDf6GEddWS3NjFDEBGVg+7b0Wv+DUFq92cyL6qUZE/nLn4S/QomfyrWMm2ymM4HBZdAh3zvYvhB1GuhO6AcQ1SzqZiBZqv0zVGoc7quLDbIC2/UYA7r6jLE3eKCY7D66PRzgyCZc3J8P2AgLa78XLTycbpQs92Bdf8ofSCI0jliM4P9xcz538RvuxYeJTpeXuBIlBCjfc97KoqyBiV15y6+ZyaGQ6UybMdP4ITJ52N66LcNdpMXfhlPTpqBPypjwnjnfzNtzKmaNGhMUrEWPUVC37sD6O3jqRetB2j3DValVvAslIcgznj97DmSaGxHpE6R807cG0bEIza3VCjNi9id555SgVHy1cZRmX3QART0LO90ThQQaMKlSF1CmorDaAmbVwTyDf0A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 11:50:37.9445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cad4a8-9f89-423a-b22b-08d77266dadb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1757
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfBNrF0+Az51t37sP3OP+ctKvp4PFpG97kPuEvC1AaU=;
 b=WbnM9RmvEcJv5qHO5TZ1NM3/qk8GqWKfWl8MJOXFDTQIu6FGHhmly4to0vv5//YMMZ6iEyrvl7u8Iz2nItIk6Cib8570fGRrL75inOubMK+uSDukznhk1PhWfAN9P8LaLTb7wQlHJeoezk3hVJyK8z3jgNmiR8T8F0vGKLWwcsM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126115024.VbrgIExme67E2EmhoX2B2Wj_JVHtOJZF6bc12G1mR4o@z>

a2VybmVsIHdvdWxkIHJlcG9ydCBhIHdhcm5pbmcgb24gZG91YmxlIHVucGluCm9uIHRoZSBjc2Ig
Qk8gYmVjYXVzZSB3ZSB1bnBpbiBpdCBkdXJpbmcgaHdfZmluaQpidXQgYWN0dWFsbHkgd2UgZG9u
J3QgbmVlZCB0byBwaW4vdW5waW4gaXQgZHVyaW5nCmh3X2luaXQvZmluaSBzaW5jZSBpdCBpcyBj
cmVhdGVkIHdpdGgga2VybmVsIHBpbm5lZAoKcmVtb3ZlIGFsbCB0aG9zZSB1c2VsZXNzIGNvZGUg
Zm9yIGdmeDkvMTAKClNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ybGMuYyB8ICAxIC0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jICB8IDM4IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jICAg
fCAzOSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwg
NzggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3JsYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JsYy5jCmlu
ZGV4IGM4NzkzZTYuLjI4OWZhZGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9ybGMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmxjLmMKQEAgLTE0NSw3ICsxNDUsNiBAQCBpbnQgYW1kZ3B1X2dmeF9ybGNfaW5pdF9jc2Ioc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJZHN0X3B0ciA9IGFkZXYtPmdmeC5ybGMuY3NfcHRy
OwogCWFkZXYtPmdmeC5ybGMuZnVuY3MtPmdldF9jc2JfYnVmZmVyKGFkZXYsIGRzdF9wdHIpOwog
CWFtZGdwdV9ib19rdW5tYXAoYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9vYmopOwotCWFtZGdw
dV9ib191bnBpbihhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaik7CiAJYW1kZ3B1X2JvX3Vu
cmVzZXJ2ZShhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaik7CiAKIAlyZXR1cm4gMDsKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKaW5kZXggYTU2Y2JhOS4uNWVlNzQ2NyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKQEAgLTk5NiwzOSArOTk2LDYg
QEAgc3RhdGljIGludCBnZnhfdjEwXzBfcmxjX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBpbnQgZ2Z4X3YxMF8wX2NzYl92cmFtX3Bpbihz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKLXsKLQlpbnQgcjsKLQotCXIgPSBhbWRncHVfYm9f
cmVzZXJ2ZShhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaiwgZmFsc2UpOwotCWlmICh1bmxp
a2VseShyICE9IDApKQotCQlyZXR1cm4gcjsKLQotCXIgPSBhbWRncHVfYm9fcGluKGFkZXYtPmdm
eC5ybGMuY2xlYXJfc3RhdGVfb2JqLAotCQkJQU1ER1BVX0dFTV9ET01BSU5fVlJBTSk7Ci0JaWYg
KCFyKQotCQlhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX2dwdV9hZGRyID0KLQkJCWFtZGdwdV9i
b19ncHVfb2Zmc2V0KGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2JqKTsKLQotCWFtZGdwdV9i
b191bnJlc2VydmUoYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9vYmopOwotCi0JcmV0dXJuIHI7
Ci19Ci0KLXN0YXRpYyB2b2lkIGdmeF92MTBfMF9jc2JfdnJhbV91bnBpbihzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikKLXsKLQlpbnQgcjsKLQotCWlmICghYWRldi0+Z2Z4LnJsYy5jbGVhcl9z
dGF0ZV9vYmopCi0JCXJldHVybjsKLQotCXIgPSBhbWRncHVfYm9fcmVzZXJ2ZShhZGV2LT5nZngu
cmxjLmNsZWFyX3N0YXRlX29iaiwgdHJ1ZSk7Ci0JaWYgKGxpa2VseShyID09IDApKSB7Ci0JCWFt
ZGdwdV9ib191bnBpbihhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaik7Ci0JCWFtZGdwdV9i
b191bnJlc2VydmUoYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9vYmopOwotCX0KLX0KLQogc3Rh
dGljIHZvaWQgZ2Z4X3YxMF8wX21lY19maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQog
ewogCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRldi0+Z2Z4Lm1lYy5ocGRfZW9wX29iaiwgTlVM
TCwgTlVMTCk7CkBAIC0zNzgwLDEwICszNzQ3LDYgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfaHdf
aW5pdCh2b2lkICpoYW5kbGUpCiAJaW50IHI7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYg
PSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7CiAKLQlyID0gZ2Z4X3YxMF8wX2NzYl92
cmFtX3BpbihhZGV2KTsKLQlpZiAocikKLQkJcmV0dXJuIHI7Ci0KIAlpZiAoIWFtZGdwdV9lbXVf
bW9kZSkKIAkJZ2Z4X3YxMF8wX2luaXRfZ29sZGVuX3JlZ2lzdGVycyhhZGV2KTsKIApAQCAtMzg3
MSw3ICszODM0LDYgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfaHdfZmluaSh2b2lkICpoYW5kbGUp
CiAJfQogCWdmeF92MTBfMF9jcF9lbmFibGUoYWRldiwgZmFsc2UpOwogCWdmeF92MTBfMF9lbmFi
bGVfZ3VpX2lkbGVfaW50ZXJydXB0KGFkZXYsIGZhbHNlKTsKLQlnZnhfdjEwXzBfY3NiX3ZyYW1f
dW5waW4oYWRldik7CiAKIAlyZXR1cm4gMDsKIH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djlfMC5jCmluZGV4IDRjYzJlNTAuLjUyNGE3YmEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y5XzAuYwpAQCAtMTY4MywzOSArMTY4Myw2IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfcmxj
X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRp
YyBpbnQgZ2Z4X3Y5XzBfY3NiX3ZyYW1fcGluKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQot
ewotCWludCByOwotCi0JciA9IGFtZGdwdV9ib19yZXNlcnZlKGFkZXYtPmdmeC5ybGMuY2xlYXJf
c3RhdGVfb2JqLCBmYWxzZSk7Ci0JaWYgKHVubGlrZWx5KHIgIT0gMCkpCi0JCXJldHVybiByOwot
Ci0JciA9IGFtZGdwdV9ib19waW4oYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9vYmosCi0JCQlB
TURHUFVfR0VNX0RPTUFJTl9WUkFNKTsKLQlpZiAoIXIpCi0JCWFkZXYtPmdmeC5ybGMuY2xlYXJf
c3RhdGVfZ3B1X2FkZHIgPQotCQkJYW1kZ3B1X2JvX2dwdV9vZmZzZXQoYWRldi0+Z2Z4LnJsYy5j
bGVhcl9zdGF0ZV9vYmopOwotCi0JYW1kZ3B1X2JvX3VucmVzZXJ2ZShhZGV2LT5nZngucmxjLmNs
ZWFyX3N0YXRlX29iaik7Ci0KLQlyZXR1cm4gcjsKLX0KLQotc3RhdGljIHZvaWQgZ2Z4X3Y5XzBf
Y3NiX3ZyYW1fdW5waW4oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCi17Ci0JaW50IHI7Ci0K
LQlpZiAoIWFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2JqKQotCQlyZXR1cm47Ci0KLQlyID0g
YW1kZ3B1X2JvX3Jlc2VydmUoYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9vYmosIHRydWUpOwot
CWlmIChsaWtlbHkociA9PSAwKSkgewotCQlhbWRncHVfYm9fdW5waW4oYWRldi0+Z2Z4LnJsYy5j
bGVhcl9zdGF0ZV9vYmopOwotCQlhbWRncHVfYm9fdW5yZXNlcnZlKGFkZXYtPmdmeC5ybGMuY2xl
YXJfc3RhdGVfb2JqKTsKLQl9Ci19Ci0KIHN0YXRpYyB2b2lkIGdmeF92OV8wX21lY19maW5pKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewogCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRl
di0+Z2Z4Lm1lYy5ocGRfZW9wX29iaiwgTlVMTCwgTlVMTCk7CkBAIC0zNjk0LDEwICszNjYxLDYg
QEAgc3RhdGljIGludCBnZnhfdjlfMF9od19pbml0KHZvaWQgKmhhbmRsZSkKIAogCWdmeF92OV8w
X2NvbnN0YW50c19pbml0KGFkZXYpOwogCi0JciA9IGdmeF92OV8wX2NzYl92cmFtX3BpbihhZGV2
KTsKLQlpZiAocikKLQkJcmV0dXJuIHI7Ci0KIAlyID0gYWRldi0+Z2Z4LnJsYy5mdW5jcy0+cmVz
dW1lKGFkZXYpOwogCWlmIChyKQogCQlyZXR1cm4gcjsKQEAgLTM3NzksOCArMzc0Miw2IEBAIHN0
YXRpYyBpbnQgZ2Z4X3Y5XzBfaHdfZmluaSh2b2lkICpoYW5kbGUpCiAJZ2Z4X3Y5XzBfY3BfZW5h
YmxlKGFkZXYsIGZhbHNlKTsKIAlhZGV2LT5nZngucmxjLmZ1bmNzLT5zdG9wKGFkZXYpOwogCi0J
Z2Z4X3Y5XzBfY3NiX3ZyYW1fdW5waW4oYWRldik7Ci0KIAlyZXR1cm4gMDsKIH0KIAotLSAKMi43
LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
