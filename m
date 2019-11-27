Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48384C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19CBC2070A
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CBC2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7FF26E4DD;
	Wed, 27 Nov 2019 09:15:48 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700046.outbound.protection.outlook.com [40.107.70.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D016E4DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 09:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nq7jO+pRcNPgbZIHcDLzBFJI/MKzGvNjusj4Ip1iKrc6ukBjN+ZVU8OH3Kg1b/Hu+i0gmfw664e7u0wiU3Aa8COGtdbTD/KI5p0ELVLgacp7jY2POMilF8JwT9+Zj7WlD+zINvcPAKVUrVrqHr6NIoCI2pMKGBO75svZOwY+fHNg0lW1ScYLfkLbU2Xmc+F8Ly613QWAnkWwxdif+EWMG8+f4ZBk2nsqdCZoqsx8eF3fms43gGGAaWLeRb9Ct0u8RxI1H8LZ+2gHq4H7XWgF6Zs3hiG1yM9S2QMeeXO/H/f5vrAYaRTPQNNXb+X7Uu+agC2I7YQfI+VvujXlJIoBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLpderxz8eNPQFdeR+l8BVcIiMM4qUEMXrQaywvCr1s=;
 b=oXuwLmW2+2cyWZvZFgW4L5ZV8W8eIGdBcXV+rDkcV28H14cWULDVzdEdDd+FnJcaNbCTEKaTYPKx4N9sFJN+B0srSvqdRFXd38C8vL+EPvUPSHV5bhbow7IX5+f0vM56x1y6PBnQ1tni/RAdsDdS4y/+YERDNzKO3vF4NbKufeMmZPtVEF3oQ8M2GaiAiK8GsBL4znDilo0294ykOM38DQnpxndh3g4UkH7Dmh6BNFG7OSmDQzTnU6mlLwmJ5iAOBoDYu9lJMi8P7CXjdtvzK0NTxjDjPQWdkunCqyOe4QW4fXUDastthhrQw1qLXVk0S05ksRKVIuedy4UAdojZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN6PR1201CA0024.namprd12.prod.outlook.com
 (2603:10b6:405:4c::34) by BYAPR12MB3127.namprd12.prod.outlook.com
 (2603:10b6:a03:d8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17; Wed, 27 Nov
 2019 09:15:41 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::209) by BN6PR1201CA0024.outlook.office365.com
 (2603:10b6:405:4c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17 via Frontend
 Transport; Wed, 27 Nov 2019 09:15:41 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 27 Nov 2019 09:15:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 03:15:40 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 03:15:39 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 27 Nov 2019 03:15:37 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/10] drm/amdgpu: export amdgpu_ras_find_obj to use externally
Date: Wed, 27 Nov 2019 17:15:22 +0800
Message-ID: <1574846129-4826-2-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574846129-4826-1-git-send-email-le.ma@amd.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(428003)(199004)(189003)(81156014)(6916009)(81166006)(76176011)(36756003)(305945005)(51416003)(336012)(8936002)(11346002)(4326008)(186003)(2616005)(426003)(446003)(8676002)(50226002)(47776003)(26005)(44832011)(70586007)(2906002)(54906003)(5660300002)(16586007)(316002)(86362001)(50466002)(48376002)(2351001)(6666004)(356004)(70206006)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3127; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfa9ab2f-bfd0-445d-4ac5-08d7731a5fb1
X-MS-TrafficTypeDiagnostic: BYAPR12MB3127:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3127F470250A2D58D8CB98BCF6440@BYAPR12MB3127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 023495660C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqlLP3IaQFUcN052esRSsiGsrDtID7VETuwYrrF4nCYPAnA2accIdrVf3H1e6lyWpL7NDeIuuKimCzyLwZ+o5l2V4g+gnkZi2G25+AsepuzuFqeid2W/yxMu/GaIxwO7SkYC5Wz8b1CaF2DKOVFkBRiDnNyPQRj72TKaZCuXUPAaxKzQNzwXmqxkAW+kCSzitUXckCEWbuDvBp2kVZH3HFBDZ1rMYnjLCNmndHmhFgX1hRLgEZ+eLzwAmXp6x8K8f860snM2J/q/XMomBWRqKA2NbGBEng+pp41ztm11n9Z0brA9XZW2/H7ZRDdrwnXazRYmWXrQoH1lSJ1CmNqPkTSkzEgHJkH29/hkhbwoiMGKOZJwsinj6SaYQfGG5VadApz6P2VcOajKknytRyD3mSzuGFGN/NC52vC/3LSwsoDz5FTw7ryM2IrCdyX7QoNU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 09:15:40.7192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa9ab2f-bfd0-445d-4ac5-08d7731a5fb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3127
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLpderxz8eNPQFdeR+l8BVcIiMM4qUEMXrQaywvCr1s=;
 b=couXzzeIMbOkC5qP+EFG+zqkXRITxJdArO0eO+B704YKEFxS86Pu3PbohTZ+FFYYK6LVJn/pRmJpss7j/sueb8w4G187wN01DWooD/bYrUZeVmHL1qV6a/g525Sfq6a2ovVqQRnIc86bfpJyQezp3ni/srRALGubq381QjPJh9k=
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
Cc: guchun.chen@amd.com, tao.zhou1@amd.com, Le Ma <le.ma@amd.com>,
 alexander.deucher@amd.com, dennis.li@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127091522.BI9ynXwNS2iSyMAwQfH-mWSFjRXNtzJqdvov9rnQGyg@z>

Q2hhbmdlIGl0IHRvIGV4dGVybmFsIGludGVyZmFjZS4KCkNoYW5nZS1JZDogSTJhYjYxZjE0OWM4
NGEwNWE2Zjg4M2E0Yzc0MTVlYTgwMTJlYzAzYTYKU2lnbmVkLW9mZi1ieTogTGUgTWEgPGxlLm1h
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwg
NSArLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oIHwgMyArKysK
IDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwppbmRleCAxNTkzNTY0Li4wNDM5NGM0IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCkBAIC0xOTgsOSArMTk4LDYg
QEAgc3RhdGljIGludCBhbWRncHVfcmFzX2RlYnVnZnNfY3RybF9wYXJzZV9kYXRhKHN0cnVjdCBm
aWxlICpmLAogCXJldHVybiAwOwogfQogCi1zdGF0aWMgc3RydWN0IHJhc19tYW5hZ2VyICphbWRn
cHVfcmFzX2ZpbmRfb2JqKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAotCQlzdHJ1Y3QgcmFz
X2NvbW1vbl9pZiAqaGVhZCk7Ci0KIC8qKgogICogRE9DOiBBTURHUFUgUkFTIGRlYnVnZnMgY29u
dHJvbCBpbnRlcmZhY2UKICAqCkBAIC00NDUsNyArNDQyLDcgQEAgc3RhdGljIHN0cnVjdCByYXNf
bWFuYWdlciAqYW1kZ3B1X3Jhc19jcmVhdGVfb2JqKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAogfQogCiAvKiByZXR1cm4gYW4gb2JqIGVxdWFsIHRvIGhlYWQsIG9yIHRoZSBmaXJzdCB3aGVu
IGhlYWQgaXMgTlVMTCAqLwotc3RhdGljIHN0cnVjdCByYXNfbWFuYWdlciAqYW1kZ3B1X3Jhc19m
aW5kX29iaihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKK3N0cnVjdCByYXNfbWFuYWdlciAq
YW1kZ3B1X3Jhc19maW5kX29iaihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJc3RydWN0
IHJhc19jb21tb25faWYgKmhlYWQpCiB7CiAJc3RydWN0IGFtZGdwdV9yYXMgKmNvbiA9IGFtZGdw
dV9yYXNfZ2V0X2NvbnRleHQoYWRldik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmFzLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmFzLmgKaW5kZXggZjgwZmQzNC4uYTJjMWFjMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yYXMuaApAQCAtNjExLDYgKzYxMSw5IEBAIGludCBhbWRncHVfcmFzX2ludGVycnVw
dF9yZW1vdmVfaGFuZGxlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIGludCBhbWRncHVf
cmFzX2ludGVycnVwdF9kaXNwYXRjaChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJc3Ry
dWN0IHJhc19kaXNwYXRjaF9pZiAqaW5mbyk7CiAKK3N0cnVjdCByYXNfbWFuYWdlciAqYW1kZ3B1
X3Jhc19maW5kX29iaihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKKwkJc3RydWN0IHJhc19j
b21tb25faWYgKmhlYWQpOworCiBleHRlcm4gYXRvbWljX3QgYW1kZ3B1X3Jhc19pbl9pbnRyOwog
CiBzdGF0aWMgaW5saW5lIGJvb2wgYW1kZ3B1X3Jhc19pbnRyX3RyaWdnZXJlZCh2b2lkKQotLSAK
Mi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
