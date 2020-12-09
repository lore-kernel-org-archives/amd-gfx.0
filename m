Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39213C4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 15:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB591238E9
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 15:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB591238E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB576EA91;
	Wed,  9 Dec 2020 15:29:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBEBF6EA91
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 15:29:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkC6eksUIQyrZjDgD9Qq8tcGmIsjsE2K8nznnpb8jh9/24uw9EmfYVfCh9vRJd5qD24SgkKXGbU94DnZwzd3DQohm1KGNTL9B8OmIw0KBeNfkoTW0DBS46I+gfqFSWp5XFmazUvmytwNQXo6pIFyAdZZddFh+wuPQPNIE4h1t8ugFFy7Ga5NQE2g3hX2wDPcASegL3qiCtRyN0E0mBumLwitZBXFqWs4SmPAg6eZrSqe9yaGNYz9LBwu2r7/ZlNEbez9kZ3qBQBQIB1sFBvfnMwbHloJUb7TiVAy5QGWCyoVxF69uQ08Y/ix+wQT27yhzZjGzUsqlqt7GWmJS0VBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O8uBhweCKg94JtvvGW92EIGka4Ee2zjbsWN0tA5UwM=;
 b=VVSnYpjuE4clj2IHACu6ZnFVJs/flCHVjd1B8WSHM9OqNAGcLuY0QjGcD9hf05bpV9SdRdxbdD77H7Qm/BdNE4wzY4XnCOwRaeRUBt9jov9FqLt7+E6m6TuPOUrKJ2fvVlebTeD8bOTQt1C80iAbbpMhNayzjAL9zRDezv2WwU4bNbU+QkyYP6be/F7eLjDMqKBNyli81bOrCGIz1mN1YfBnlNAVZClykT07LAXh+0eFaAZuoimanAKJId3iWPzN+fpB1/dCUmc0dsnmVgQ27ZOveJNlaruIGbJhGSevzkL59n9pWxgCwMlAqYkWRaXKeGqwyQslL3V0YTG7SZ9DQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O8uBhweCKg94JtvvGW92EIGka4Ee2zjbsWN0tA5UwM=;
 b=mTaBoPXpBFL3LPbef5jsZ9p4wYtYDSR5S3QzuvvGgUu8RAGVhgiEnl4vE9TZaQwYvaD/m+6Seh389OhwI22LAPpaowfyPbbug7+e9ESepWLstKAFoM0gm2ovIrp/q2oonZUZsIza19x6pxrkNzjU0X7wz/cBBngjPtVIbs+PAi4=
Received: from MWHPR14CA0035.namprd14.prod.outlook.com (2603:10b6:300:12b::21)
 by DM5PR1201MB2488.namprd12.prod.outlook.com (2603:10b6:3:e1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Wed, 9 Dec
 2020 15:29:14 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::8b) by MWHPR14CA0035.outlook.office365.com
 (2603:10b6:300:12b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Wed, 9 Dec 2020 15:29:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Wed, 9 Dec 2020 15:29:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Dec 2020
 09:29:12 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Dec 2020
 09:29:12 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 9 Dec 2020 09:29:11 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: check number of gfx ring before init cp gfx
Date: Wed, 9 Dec 2020 23:28:10 +0800
Message-ID: <20201209152812.3215-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ec92b4b-7bce-4d2f-6157-08d89c572f20
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2488:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB24889E59C3665E971667E175FCCC0@DM5PR1201MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39uGxYwVBALWKhoQPDNQD101vD8WhCqZId459CjZi6cCX/uMfdQd2xJkzVSHmgYLBje3XaiwbXDBCcVDZ6MncS6Fi8KzWSph2xRHDk1nwsL3NnIO2VG3Xrk4npqc812ih0HL3mR1wuqLd0v+wfBaqUQjV1eL4BeEdoZ2bDarDBm5DIi+R8reJDFbTHjuq580YbW9aWwANaPfInlL1/tr3NxJcLENXdjvA6YoUHuIGrTUlerAuxeQmWBjXoFcN2nb+BqiiD8pnSoCRFMzmruPZx5Zh8u8IIvraEraMW4WLIiJJPjE4Yo4t20rb/z5gxNYsON3NPyNvxKbS6l/c1I7lm1pozz+qjDInZrrvyJUQ8vGUGPCHlzu7mKfH2tGRzKOOGVgM/oPJEjCsI9/igeMig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(46966005)(6636002)(83380400001)(86362001)(36756003)(82310400003)(8936002)(70586007)(508600001)(70206006)(5660300002)(26005)(426003)(356005)(8676002)(186003)(47076004)(2906002)(81166007)(336012)(2616005)(1076003)(7696005)(110136005)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 15:29:13.7995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec92b4b-7bce-4d2f-6157-08d89c572f20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2488
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Q2hlY2sgbnVtYmVyIG9mIGdmeCByaW5nLCByYXRoZXIgdGhhbiBhc2ljIHR5cGUsCmJlZm9yZSBj
cCBnZnggZW5naW5lIGluaXRpYWxpemF0aW9uIHNvIGRyaXZlciBqdXN0Cm5lZWQgdG8gbWFrZSBz
dXJlIG51bWJlciBvZiBnZnggcmluZyBpcyBpbml0aWFsaXplZApjb3JyZWN0bHkgaW4gZ2Z4IGVh
cmx5X2luaXQgcGhhc2UuIE5vIG5lZWQgdG8gYWRkCmFkZGl0aW9uYWwgYXNpYyB0eXBlIGNoZWNr
IGV2ZXJ5d2hlcmUgd2hlbiB0aGVyZSBpcwpuZXcgYXNpYyB3aXRoIGdmeCBwaXBlIHJlbW92ZWQu
CgpTaWduZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+ClJl
dmlld2VkLWJ5OiBGZWlmZWkgWHUgPEZlaWZlaS5YdUBhbWQuY29tPgpBY2tlZC1ieTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCAxMiArKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OV8wLmMKaW5kZXggZmM5YmI5NGVhYWY0Li5lZjQzMGYyODU0NzIgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwpAQCAtMTY0Nyw3ICsxNjQ3LDcgQEAgc3RhdGljIGlu
dCBnZnhfdjlfMF9pbml0X21pY3JvY29kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAl9
CiAKIAkvKiBObyBDUEcgaW4gQXJjdHVydXMgKi8KLQlpZiAoYWRldi0+YXNpY190eXBlICE9IENI
SVBfQVJDVFVSVVMpIHsKKwlpZiAoYWRldi0+Z2Z4Lm51bV9nZnhfcmluZ3MpIHsKIAkJciA9IGdm
eF92OV8wX2luaXRfY3BfZ2Z4X21pY3JvY29kZShhZGV2LCBjaGlwX25hbWUpOwogCQlpZiAocikK
IAkJCXJldHVybiByOwpAQCAtMzgyMiw3ICszODIyLDcgQEAgc3RhdGljIGludCBnZnhfdjlfMF9j
cF9yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCWdmeF92OV8wX2VuYWJsZV9n
dWlfaWRsZV9pbnRlcnJ1cHQoYWRldiwgZmFsc2UpOwogCiAJaWYgKGFkZXYtPmZpcm13YXJlLmxv
YWRfdHlwZSAhPSBBTURHUFVfRldfTE9BRF9QU1ApIHsKLQkJaWYgKGFkZXYtPmFzaWNfdHlwZSAh
PSBDSElQX0FSQ1RVUlVTKSB7CisJCWlmIChhZGV2LT5nZngubnVtX2dmeF9yaW5ncykgewogCQkJ
LyogbGVnYWN5IGZpcm13YXJlIGxvYWRpbmcgKi8KIAkJCXIgPSBnZnhfdjlfMF9jcF9nZnhfbG9h
ZF9taWNyb2NvZGUoYWRldik7CiAJCQlpZiAocikKQEAgLTM4MzgsNyArMzgzOCw3IEBAIHN0YXRp
YyBpbnQgZ2Z4X3Y5XzBfY3BfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCWlm
IChyKQogCQlyZXR1cm4gcjsKIAotCWlmIChhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9BUkNUVVJV
UykgeworCWlmIChhZGV2LT5nZngubnVtX2dmeF9yaW5ncykgewogCQlyID0gZ2Z4X3Y5XzBfY3Bf
Z2Z4X3Jlc3VtZShhZGV2KTsKIAkJaWYgKHIpCiAJCQlyZXR1cm4gcjsKQEAgLTM4NDgsNyArMzg0
OCw3IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfY3BfcmVzdW1lKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQogCWlmIChyKQogCQlyZXR1cm4gcjsKIAotCWlmIChhZGV2LT5hc2ljX3R5cGUgIT0g
Q0hJUF9BUkNUVVJVUykgeworCWlmIChhZGV2LT5nZngubnVtX2dmeF9yaW5ncykgewogCQlyaW5n
ID0gJmFkZXYtPmdmeC5nZnhfcmluZ1swXTsKIAkJciA9IGFtZGdwdV9yaW5nX3Rlc3RfaGVscGVy
KHJpbmcpOwogCQlpZiAocikKQEAgLTM4ODQsNyArMzg4NCw3IEBAIHN0YXRpYyB2b2lkIGdmeF92
OV8wX2luaXRfdGNwX2NvbmZpZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAogc3RhdGlj
IHZvaWQgZ2Z4X3Y5XzBfY3BfZW5hYmxlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBib29s
IGVuYWJsZSkKIHsKLQlpZiAoYWRldi0+YXNpY190eXBlICE9IENISVBfQVJDVFVSVVMpCisJaWYg
KGFkZXYtPmdmeC5udW1fZ2Z4X3JpbmdzKQogCQlnZnhfdjlfMF9jcF9nZnhfZW5hYmxlKGFkZXYs
IGVuYWJsZSk7CiAJZ2Z4X3Y5XzBfY3BfY29tcHV0ZV9lbmFibGUoYWRldiwgZW5hYmxlKTsKIH0K
QEAgLTQwMjUsNyArNDAyNSw3IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfc29mdF9yZXNldCh2b2lk
ICpoYW5kbGUpCiAJCS8qIHN0b3AgdGhlIHJsYyAqLwogCQlhZGV2LT5nZngucmxjLmZ1bmNzLT5z
dG9wKGFkZXYpOwogCi0JCWlmIChhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9BUkNUVVJVUykKKwkJ
aWYgKGFkZXYtPmdmeC5udW1fZ2Z4X3JpbmdzKQogCQkJLyogRGlzYWJsZSBHRlggcGFyc2luZy9w
cmVmZXRjaGluZyAqLwogCQkJZ2Z4X3Y5XzBfY3BfZ2Z4X2VuYWJsZShhZGV2LCBmYWxzZSk7CiAK
LS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
