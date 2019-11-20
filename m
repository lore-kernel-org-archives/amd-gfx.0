Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8117CC432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 10:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB4B22429
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 10:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB4B22429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A1566E157;
	Wed, 20 Nov 2019 10:49:53 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790080.outbound.protection.outlook.com [40.107.79.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C536E157
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 10:49:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hon6iym05CBUAZPW55bCuwsOsKNHwQBJ93XRqED0yMC+2wFcujsDKfacEO6ptwbB4ZhfQ3MIej8FQqFE4EqDsupkefEOlZgudYdn4SZE5vYrDOTLE4+IMkFQClIZ1OAPRRUwaw5esWd+b3QZkD8L3q9/hrZlYGnpMd0/mEo8C9DHF3u6Z80GB5N4OwycntGM9Uja91wOhrXR5P2K//P4AWwuJHUbKifvWG5wMt9OF8Dlsikly9Mx9JPiaSXOv7FiXJi1ng8VoyBwfqEI7s39nXTEiJALsjfXenQCYZjtTAtjxTCiBcLYb+3I7I1d9HKGXCEUiC3XmYMaXFOIDkK8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iwk6Wv3xkeWxksqcXVYtU+Yn7WA7SAQTGLmQiO32g20=;
 b=ZyULgVomlx7ZzxWZjhuCYAO9OsANdYnjdXDfO/RKTWt+WHZfXLx6RyCUEil2o6pAXYB6XlAuLzeG+Djxi1pCwoo2O4xv6BrvQ21kjiVAy2aJ0DEf+8JScN2Gb5Z9O6CxfptyFTMO1l6dg0uMDm5npuywrallWYx9yTcBti2m9E3oNQSZWYgBznG9yFIEQZcReTk6uDX1isnnW6Dh+NqH7y3QV+jhLAuknx0eJv4xazQDFZyVnWsKGB2F/cduxfDlI7XZe2OH4JbKZ9/CHZ2rEmas+VJhn0vnUC4CuULkEPr0TlftTWAERkKjEjY8NZwI6KT3pAzktAsN5tNDkOPd+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0079.namprd12.prod.outlook.com (2603:10b6:0:57::23) by
 BL0PR12MB2339.namprd12.prod.outlook.com (2603:10b6:207:4e::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Wed, 20 Nov 2019 10:49:51 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::201) by DM3PR12CA0079.outlook.office365.com
 (2603:10b6:0:57::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2474.17 via Frontend
 Transport; Wed, 20 Nov 2019 10:49:51 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 20 Nov 2019 10:49:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 20 Nov
 2019 04:49:50 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 20 Nov
 2019 04:49:49 -0600
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 20 Nov 2019 04:49:42 -0600
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu: define soc15_ras_field_entry for reuse
Date: Wed, 20 Nov 2019 18:49:30 +0800
Message-ID: <20191120104932.16257-2-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120104932.16257-1-Dennis.Li@amd.com>
References: <20191120104932.16257-1-Dennis.Li@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(428003)(189003)(199004)(70586007)(36756003)(446003)(50226002)(7696005)(51416003)(26005)(186003)(11346002)(305945005)(86362001)(2906002)(47776003)(16586007)(316002)(486006)(476003)(54906003)(8936002)(8676002)(81166006)(81156014)(2616005)(110136005)(6636002)(426003)(2201001)(336012)(70206006)(76176011)(126002)(1076003)(48376002)(53416004)(5660300002)(478600001)(6666004)(356004)(50466002)(4326008)(2101003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2339; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b8f676f-0325-4997-be22-08d76da75e70
X-MS-TrafficTypeDiagnostic: BL0PR12MB2339:
X-Microsoft-Antispam-PRVS: <BL0PR12MB233973BEFF49547028113930ED4F0@BL0PR12MB2339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 02272225C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45dGBYJ3IC13qUcr5N5eEMzDQH4dUP4X6AKBf1ZkDagR/SN56u9TC3r/ximiatCAdRbFpWKQB+TGT6LqYV9vUA1uRlZ7EhhhCHUFbadto1SaLFAnNasM8ygZ304OM2ol5l82YtUQ2Wmo/WEdWGnCkKjD4+pCZW6LLePnC+mMGW0P7tdQzIpCXb7Y3G1PO9Xc9d86BX8QH8TKFQQmIJjT8h7p7r/oesaIANHBHlWV3V63gFLbTsbP1q7JOACeUlA5irAmCV1+RhIuQTHP0oLyCtz9m7C15WViV21bsOmqN9My75jiVwGRP0fpCOU9NzjEaD9wclKfb9LcsQwYVkiF5kD+mPJDLq4PV+smMc7wwWSZgahOhwhrTXIdCzygV4r9b1+IzWe3e1h5sJBLVmL/Zl2PhbpAQ62cCzLRbFsA54l/2ktRu5cXA9U1YAM/B66t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 10:49:50.6791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8f676f-0325-4997-be22-08d76da75e70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2339
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iwk6Wv3xkeWxksqcXVYtU+Yn7WA7SAQTGLmQiO32g20=;
 b=y99J76V/3GNbglnwh4P+P5OsnHE0dcCrkulzWqo0CT4ss18XYOTVqhdkwDhg2nA8yRtIu5Z2GClMD/EuhDWj73GiQ/k8Q+LecQPWd5ALtVNN3kTs2nQVkU7MINL4eOdGrzh8CF5yGMl4NYSnl1LRVAaFBbRgy8YXEBfXK7R5RyA=
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
Cc: Dennis Li <dennis.li@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120104930.QtnxKpASEb0iXD1_CS68mHfm0X1LMgoDxmdUD-AAwEE@z>

VGhlIHN0cnVjdCBzb2MxNV9yYXNfZmllbGRfZW50cnkgd2lsbCBiZSByZXVzZWQgYnkKb3RoZXIg
SVBzLCBzdWNoIGFzIG1taHViIGFuZCBnYwoKdjI6IHJlbmFtZSByYXNfc3ViYmxvY2tfcmVncyB0
byBnY19yYXNfZmllbGRzX3ZnMjAsCmJlY2F1c2UgdGhlIGZ1dHVyZSBhc2ljIG1heWJlIGhhdmUg
YSBkaWZmZXJlbnQgdGFibGUuCgpDaGFuZ2UtSWQ6IEk2YzMzODhhMDliNWZiZjkyN2FkOTBmY2Q2
MjZiYWE0NDhkMTY4MWE2ClNpZ25lZC1vZmYtYnk6IERlbm5pcyBMaSA8ZGVubmlzLmxpQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyB8IDM0ICsrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUu
aCAgICB8IDEyICsrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwg
MjMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKaW5kZXgg
YzdhZTY4NWQ2Zjc0Li44MDczZmNkNDcyMGUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y5XzAuYwpAQCAtMTMxLDE4ICsxMzEsNiBAQCBNT0RVTEVfRklSTVdBUkUoImFtZGdwdS9yZW5v
aXJfcmxjLmJpbiIpOwogI2RlZmluZSBtbVRDUF9DSEFOX1NURUVSXzVfQVJDVAkJCQkJCQkJMHgw
YjBjCiAjZGVmaW5lIG1tVENQX0NIQU5fU1RFRVJfNV9BUkNUX0JBU0VfSURYCQkJCQkJCTAKIAot
c3RydWN0IHJhc19nZnhfc3ViYmxvY2tfcmVnIHsKLQljb25zdCBjaGFyICpuYW1lOwotCXVpbnQz
Ml90IGh3aXA7Ci0JdWludDMyX3QgaW5zdDsKLQl1aW50MzJfdCBzZWc7Ci0JdWludDMyX3QgcmVn
X29mZnNldDsKLQl1aW50MzJfdCBzZWNfY291bnRfbWFzazsKLQl1aW50MzJfdCBzZWNfY291bnRf
c2hpZnQ7Ci0JdWludDMyX3QgZGVkX2NvdW50X21hc2s7Ci0JdWludDMyX3QgZGVkX2NvdW50X3No
aWZ0OwotfTsKLQogZW51bSB0YV9yYXNfZ2Z4X3N1YmJsb2NrIHsKIAkvKkNQQyovCiAJVEFfUkFT
X0JMT0NLX19HRlhfQ1BDX0lOREVYX1NUQVJUID0gMCwKQEAgLTU0ODcsNyArNTQ3NSw3IEBAIHN0
YXRpYyBpbnQgZ2Z4X3Y5XzBfcHJpdl9pbnN0X2lycShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwKIH0KIAogCi1zdGF0aWMgY29uc3Qgc3RydWN0IHJhc19nZnhfc3ViYmxvY2tfcmVnIHJhc19z
dWJibG9ja19yZWdzW10gPSB7CitzdGF0aWMgY29uc3Qgc3RydWN0IHNvYzE1X3Jhc19maWVsZF9l
bnRyeSBnY19yYXNfZmllbGRzX3ZnMjBbXSA9IHsKIAl7ICJDUENfU0NSQVRDSCIsIFNPQzE1X1JF
R19FTlRSWShHQywgMCwgbW1DUENfRURDX1NDUkFUQ0hfQ05UKSwKIAkgIFNPQzE1X1JFR19GSUVM
RChDUENfRURDX1NDUkFUQ0hfQ05ULCBTRUNfQ09VTlQpLAogCSAgU09DMTVfUkVHX0ZJRUxEKENQ
Q19FRENfU0NSQVRDSF9DTlQsIERFRF9DT1VOVCkKQEAgLTYxNDYsMjkgKzYxMzQsMjkgQEAgc3Rh
dGljIGludCBfX2dldF9yYXNfZXJyb3JfY291bnQoY29uc3Qgc3RydWN0IHNvYzE1X3JlZ19lbnRy
eSAqcmVnLAogCXVpbnQzMl90IGk7CiAJdWludDMyX3Qgc2VjX2NudCwgZGVkX2NudDsKIAotCWZv
ciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHJhc19zdWJibG9ja19yZWdzKTsgaSsrKSB7Ci0JCWlm
KHJhc19zdWJibG9ja19yZWdzW2ldLnJlZ19vZmZzZXQgIT0gcmVnLT5yZWdfb2Zmc2V0IHx8Ci0J
CQlyYXNfc3ViYmxvY2tfcmVnc1tpXS5zZWcgIT0gcmVnLT5zZWcgfHwKLQkJCXJhc19zdWJibG9j
a19yZWdzW2ldLmluc3QgIT0gcmVnLT5pbnN0KQorCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpF
KGdjX3Jhc19maWVsZHNfdmcyMCk7IGkrKykgeworCQlpZihnY19yYXNfZmllbGRzX3ZnMjBbaV0u
cmVnX29mZnNldCAhPSByZWctPnJlZ19vZmZzZXQgfHwKKwkJCWdjX3Jhc19maWVsZHNfdmcyMFtp
XS5zZWcgIT0gcmVnLT5zZWcgfHwKKwkJCWdjX3Jhc19maWVsZHNfdmcyMFtpXS5pbnN0ICE9IHJl
Zy0+aW5zdCkKIAkJCWNvbnRpbnVlOwogCiAJCXNlY19jbnQgPSAodmFsdWUgJgotCQkJCXJhc19z
dWJibG9ja19yZWdzW2ldLnNlY19jb3VudF9tYXNrKSA+PgotCQkJCXJhc19zdWJibG9ja19yZWdz
W2ldLnNlY19jb3VudF9zaGlmdDsKKwkJCQlnY19yYXNfZmllbGRzX3ZnMjBbaV0uc2VjX2NvdW50
X21hc2spID4+CisJCQkJZ2NfcmFzX2ZpZWxkc192ZzIwW2ldLnNlY19jb3VudF9zaGlmdDsKIAkJ
aWYgKHNlY19jbnQpIHsKIAkJCURSTV9JTkZPKCJHRlggU3ViQmxvY2sgJXMsIEluc3RhbmNlWyVk
XVslZF0sIFNFQyAlZFxuIiwKLQkJCQlyYXNfc3ViYmxvY2tfcmVnc1tpXS5uYW1lLAorCQkJCWdj
X3Jhc19maWVsZHNfdmcyMFtpXS5uYW1lLAogCQkJCXNlX2lkLCBpbnN0X2lkLAogCQkJCXNlY19j
bnQpOwogCQkJKnNlY19jb3VudCArPSBzZWNfY250OwogCQl9CiAKIAkJZGVkX2NudCA9ICh2YWx1
ZSAmCi0JCQkJcmFzX3N1YmJsb2NrX3JlZ3NbaV0uZGVkX2NvdW50X21hc2spID4+Ci0JCQkJcmFz
X3N1YmJsb2NrX3JlZ3NbaV0uZGVkX2NvdW50X3NoaWZ0OworCQkJCWdjX3Jhc19maWVsZHNfdmcy
MFtpXS5kZWRfY291bnRfbWFzaykgPj4KKwkJCQlnY19yYXNfZmllbGRzX3ZnMjBbaV0uZGVkX2Nv
dW50X3NoaWZ0OwogCQlpZiAoZGVkX2NudCkgewogCQkJRFJNX0lORk8oIkdGWCBTdWJCbG9jayAl
cywgSW5zdGFuY2VbJWRdWyVkXSwgREVEICVkXG4iLAotCQkJCXJhc19zdWJibG9ja19yZWdzW2ld
Lm5hbWUsCisJCQkJZ2NfcmFzX2ZpZWxkc192ZzIwW2ldLm5hbWUsCiAJCQkJc2VfaWQsIGluc3Rf
aWQsCiAJCQkJZGVkX2NudCk7CiAJCQkqZGVkX2NvdW50ICs9IGRlZF9jbnQ7CmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5oIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc29jMTUuaAppbmRleCA5YWY2YzZmZmJmYTIuLjM0NDI4MGI4NjljNCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuaAorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5oCkBAIC02MCw2ICs2MCwxOCBAQCBzdHJ1Y3Qgc29jMTVf
YWxsb3dlZF9yZWdpc3Rlcl9lbnRyeSB7CiAJYm9vbCBncmJtX2luZGV4ZWQ7CiB9OwogCitzdHJ1
Y3Qgc29jMTVfcmFzX2ZpZWxkX2VudHJ5IHsKKwljb25zdCBjaGFyICpuYW1lOworCXVpbnQzMl90
IGh3aXA7CisJdWludDMyX3QgaW5zdDsKKwl1aW50MzJfdCBzZWc7CisJdWludDMyX3QgcmVnX29m
ZnNldDsKKwl1aW50MzJfdCBzZWNfY291bnRfbWFzazsKKwl1aW50MzJfdCBzZWNfY291bnRfc2hp
ZnQ7CisJdWludDMyX3QgZGVkX2NvdW50X21hc2s7CisJdWludDMyX3QgZGVkX2NvdW50X3NoaWZ0
OworfTsKKwogI2RlZmluZSBTT0MxNV9SRUdfRU5UUlkoaXAsIGluc3QsIHJlZykJaXAjI19IV0lQ
LCBpbnN0LCByZWcjI19CQVNFX0lEWCwgcmVnCiAKICNkZWZpbmUgU09DMTVfUkVHX0VOVFJZX09G
RlNFVChlbnRyeSkJKGFkZXYtPnJlZ19vZmZzZXRbZW50cnkuaHdpcF1bZW50cnkuaW5zdF1bZW50
cnkuc2VnXSArIGVudHJ5LnJlZ19vZmZzZXQpCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
