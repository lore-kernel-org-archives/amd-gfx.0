Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB46C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2242070A
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2242070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D43A6E4EC;
	Wed, 27 Nov 2019 09:16:07 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730052.outbound.protection.outlook.com [40.107.73.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 454046E4EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 09:16:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5xTejbTYT7AAEMBs/VfZCEUFduD0nrVDamQJV/NM25AdgnG8PSEDLELZLlsRC49Tz3KTPzxELZvfUhKgMsetIUqWfEYffy/3dVCkakC2gcB4ph1UXqRmQn0BIpSBYmpAi6iLbRXML50nfHC+GvluPEgMeJtpDWUh/m7scG/2V6uHmt7c9vHXxOaDZ88u6Y6QR7n4EUW88GVDFt26lWOLwEqxZy98vxPvYkT9KoBbjNYMzT42HOtdqZKKyMQh07B2jYtYBjh3ls+p9A3y2dlNlUVjXH7u+814e22XoirQV8Yoc3Yd7Jl0w6NqTGajNeyPZgs2xBWrCJN/fXBrSQDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GxqUpFwTEa/hojcNfaZwioLU92/mbuiL2tyJt2OSBM=;
 b=fqPGtqhDRn3MQl9JzzYXqBHoL5ZLI6oyHmY9Sw/oPBt1de1XNVbTFFmdj1B6glKmcnDxI9BUIBX1LjKfj6ub5586kpcOQZOHh6bXvrHYik6Cwn8rJ3lYTMpbJ/UQxjgj2uEjYBjO+WCcBHr8Nybs4AymJt2WE+1BdfK3EJMoWT2ckRx8M4JIKkZKp0kkTx3lqAzpH4FgQMWzX/XwVxewREcv/u9MODIOapEzNkdSXHeQvN+G+BZjE6lhTw9UwT++SKaQ01dRvcPCyALc4IbRMdSZfdIrUBohrJJJcvXXhK3WzZQk60596zvMkwlqYRdw2v5AmfUF41Rigrqsd2XJuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from SN1PR12CA0086.namprd12.prod.outlook.com (2603:10b6:802:21::21)
 by BN6PR1201MB2498.namprd12.prod.outlook.com (2603:10b6:404:ae::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Wed, 27 Nov
 2019 09:16:02 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::208) by SN1PR12CA0086.outlook.office365.com
 (2603:10b6:802:21::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2495.17 via Frontend
 Transport; Wed, 27 Nov 2019 09:16:02 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 27 Nov 2019 09:16:01 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 03:15:59 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 27 Nov 2019 03:15:57 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/10] drm/amdgpu: reduce redundant uvd context lost warning
 message
Date: Wed, 27 Nov 2019 17:15:29 +0800
Message-ID: <1574846129-4826-9-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574846129-4826-1-git-send-email-le.ma@amd.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(428003)(189003)(199004)(36756003)(6666004)(356004)(54906003)(478600001)(5660300002)(8676002)(51416003)(76176011)(6916009)(4326008)(2351001)(14444005)(86362001)(4744005)(81156014)(81166006)(2906002)(305945005)(186003)(16586007)(336012)(446003)(50226002)(426003)(47776003)(2616005)(11346002)(316002)(70206006)(70586007)(8936002)(44832011)(26005)(48376002)(50466002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB2498; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fae621b1-6ef3-499c-4f8a-08d7731a6c58
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2498:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB249806822AD619373A3B2948F6440@BN6PR1201MB2498.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 023495660C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUaMnvBD668mQLRxvnnfmJsPd6AL9R+jTF70KQwDscRPjJpV9+abbNvX3s4e3IlAzIA1jO8Lo9DAitLgHGLvnfHkswNWKfiUOqmGYxVh4XJ3iVo++3pCceStkg+aqzuYrHyLHiP2wqCru7TGZif6IU3bClmk2ylemWAMlL6M3h3uhndI6jiGu4hgIj7GJoyB+XuKxfJmqt952qwPopc78DJ7U9MHNWKkqXNpo74sZw8kQa3HQZtO9NaxwXLWa3+Epfvy/MD10NtjCClbRsYpSH9xqG3nlxiXSyfd4KITrNNxKgAiVoXUV6hpnODpMdrkLTEWJg+0sN614ooSzYE9jLan9CSMyJnp++rVE6WCx2YsNF+uVW34DKg4aVnIozvStdavDoGso/JVFIz+cGAY7L2sJty7Q9qsSJK6AyJMoNwSeBkXZSoMla/4rBDEuZ4g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 09:16:01.9444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fae621b1-6ef3-499c-4f8a-08d7731a6c58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2498
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GxqUpFwTEa/hojcNfaZwioLU92/mbuiL2tyJt2OSBM=;
 b=uT+eUarcuagSvEUiSKjUnj9dL9RJgu5EXpqATObxePPJMXnbKETshWau5GN1A356xs3h5xAiynVqllpOLIgK+pxoX2nWNdPJOf5ehlTsbb5eOtGOLDPG4f3cXC0izV/egE0fw9il4OKgkc9MEmPLduvn1hYhuqbvM54FHqVrOF4=
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
Message-ID: <20191127091529.i1RUJ-ZykqDVFXoxUDKtSmS1Jsf8110F9CM_9WaFEtI@z>

TW92ZSB0aGUgcHJpbnQgb3V0IG9mIHV2ZCBpbnN0YW5jZSBsb29wIGluIGFtZGdwdV91dmRfc3Vz
cGVuZAoKQ2hhbmdlLUlkOiBJZmFkOTk3ZGViZDg0NzYzZTFiNTVkNjY4ZTE0NGI3Mjk1OThmMTE1
ZQpTaWduZWQtb2ZmLWJ5OiBMZSBNYSA8bGUubWFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMgfCA1ICsrKystCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3V2ZC5jCmluZGV4IGUzMjRiZmUuLmFjN2M3Nzk1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3V2ZC5jCkBAIC0zNzcsMTIgKzM3NywxNSBAQCBpbnQgYW1kZ3B1X3V2ZF9z
dXNwZW5kKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCiAJCS8qIHJlLXdyaXRlIDAgc2lu
Y2UgZXJyX2V2ZW50X2F0aHViIHdpbGwgY29ycnVwdCBWQ1BVIGJ1ZmZlciAqLwogCQlpZiAoYW1k
Z3B1X3Jhc19pbnRyX3RyaWdnZXJlZCgpKSB7Ci0JCQlEUk1fV0FSTigiVVZEIFZDUFUgc3RhdGUg
bWF5IGxvc3QgZHVlIHRvIFJBUyBFUlJFVkVOVF9BVEhVQl9JTlRFUlJVUFRcbiIpOwogCQkJbWVt
c2V0KGFkZXYtPnV2ZC5pbnN0W2pdLnNhdmVkX2JvLCAwLCBzaXplKTsKIAkJfSBlbHNlIHsKIAkJ
CW1lbWNweV9mcm9taW8oYWRldi0+dXZkLmluc3Rbal0uc2F2ZWRfYm8sIHB0ciwgc2l6ZSk7CiAJ
CX0KIAl9CisKKwlpZiAoYW1kZ3B1X3Jhc19pbnRyX3RyaWdnZXJlZCgpKSB7CisJCURSTV9XQVJO
KCJVVkQgVkNQVSBzdGF0ZSBtYXkgbG9zdCBkdWUgdG8gUkFTIEVSUkVWRU5UX0FUSFVCX0lOVEVS
UlVQVFxuIik7CisKIAlyZXR1cm4gMDsKIH0KIAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
