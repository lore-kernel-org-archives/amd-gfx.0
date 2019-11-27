Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABD1C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 10:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E1D206BF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 10:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E1D206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 242446E505;
	Wed, 27 Nov 2019 10:53:18 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730045.outbound.protection.outlook.com [40.107.73.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBBA6E505
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 10:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ev2ipzfkmcvvYI3YGqTasiIM2ltRdPpYEwFOQ+9lzwtZt1p/kmqLl/TMYH9+v+jHS+A5y/HpGfSVvw5f3WJzi0GAysZnhB1mWniVg5zw1PuKieDdzEtnMM1JtIPr0/CR2izELvjBLZG9YvfBfZfw6mj9f+jmZIy18XXCRYetSiVL6c5CfKAIE4cXAsw1+L6hvmbUXxTeKlMvQHMp6mwIlIJoxxVxGc8ZQZOda5wDJFrjEt+LBWV+34bD3gFFLch2kWq8VY7bKZ8VRBdClcRnaKnUH8VQI/domfpKXJAPt8zXLmPSDW+Qps+9gBujd5ogCvfMuTaAeUd6XXzVrXFWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdpe5nJlRK3Q1vuZF2aDex+V5nSDfchXbDXu3xzPS8I=;
 b=H0V0nu+YTTcWLxl47k0lFI96ISCHdKkZroV0WQg2DVvvHYGeCfN71NXtTSXGBHBT9LW5krmkwDmavyZW7c/DLmoKUJxgmSZglcGWQ20VXJbFboRW3Be9jeAT8XxP9kL8o5BAmq811/tEMxR3eYm7XlP/AwNpMhQ3dVuqPVdsDAlayUUi7yFhWdVlaFMQs2J+hPsebs5snxv72p4MgD67trmiyeNXQtAyWqYzxKIzZprzQyKWLxK0VEdKUgGnHAMayrSj6XP5aRD1z1cOSgABLZQP3SNaML1qTu/GEAEApHZW8e7asrbatf46saHL3rr4p10Tzg4ZEGMzzJynImuHPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN6PR12CA0032.namprd12.prod.outlook.com (2603:10b6:405:70::18)
 by BN6PR1201MB2467.namprd12.prod.outlook.com (2603:10b6:404:a7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Wed, 27 Nov
 2019 10:53:14 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::202) by BN6PR12CA0032.outlook.office365.com
 (2603:10b6:405:70::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2495.18 via Frontend
 Transport; Wed, 27 Nov 2019 10:53:14 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 27 Nov 2019 10:53:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 04:53:13 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 04:53:13 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 27 Nov 2019 04:53:11 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/10 v3] drm/amdgpu: reduce redundant uvd context lost
 warning message
Date: Wed, 27 Nov 2019 18:53:07 +0800
Message-ID: <1574851987-18828-1-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(428003)(199004)(189003)(81156014)(70586007)(70206006)(8676002)(5660300002)(426003)(54906003)(51416003)(2351001)(336012)(2616005)(8936002)(478600001)(81166006)(316002)(16586007)(305945005)(14444005)(47776003)(26005)(44832011)(36756003)(186003)(4326008)(86362001)(50466002)(356004)(48376002)(50226002)(2906002)(6916009)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB2467; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f731c36c-7c68-4121-30eb-08d77328009d
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2467:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2467306E3475D0D55A0364D2F6440@BN6PR1201MB2467.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 023495660C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U66jd7xU9kYiVDsReDf5Gx0t8QcBXGz662yUHhHMqZlsKqzrvsNGjpNIT3TrUeA8ScHqzo4rSKzlXYiDXho/FqpzwWbSXLQ6WdkayDbfwfrWgrF5il5I54d/u+C2HsfpZNrx/X2FMvUQzvJm1E0dQC/+s2WvduAVqazT78V0DCc2/x3hHLAAH93/JcM4ZNEVsTJP5r/O7lEXEOBQCtxT49gfTy0CqpVTp/QuXjGcL5DAW9llFwz1PCauPFoIlygXYvjzQSxPyyHJ+FqSBOorRcZwIFQfDVyxsvfdCxHnDE92EAFroAVln1TcmkpTgfoXB/bAiQUsPF/AseCYaasbGcmGLN3D+5vAFDw6G95IWQa/Om5YLXQ4uQkkW7cUBWMs6nyKFfp9P/Q4mTnud/9ghqegBADEkUOevDkn0IT/YwAzKYGUWQXacm//amJenpxG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 10:53:14.1243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f731c36c-7c68-4121-30eb-08d77328009d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2467
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdpe5nJlRK3Q1vuZF2aDex+V5nSDfchXbDXu3xzPS8I=;
 b=G0Ij67XrdVgPCwhr4oGD1o6xaiqVniNFdWAfGmGCTWBYKlpIkk3nSu7pvCFl28JckN51GZ8U2clu12wc0s8FNTgDtcBJamjjbk0t9pFIYZNp5N8p/ZWdrxGc3U/jupOvMg4Mv1bVtt/kZgjKXE7cPYBfDQSWekOjhdh2v5k0qlk=
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
 alexander.deucher@amd.com, christian.koenig@amd.com, dennis.li@amd.com,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127105307.k7eh1cF3rX8lKSO4RdlX_FAotQhOTqVAk5Cy2U68kqg@z>

TW92ZSB0aGUgcHJpbnQgb3V0IG9mIHV2ZCBpbnN0YW5jZSBsb29wIGluIGFtZGdwdV91dmRfc3Vz
cGVuZAoKdjI6IGRyb3AgdW5uZWNlc3NhcnkgYnJhY2tldHMKdjM6IGdyYWIgcmFzX2ludHIgc3Rh
dGUgb25jZSBmb3IgbXVsdGlwbGUgdGltZXMgdXNlCgpDaGFuZ2UtSWQ6IElmYWQ5OTdkZWJkODQ3
NjNlMWI1NWQ2NjhlMTQ0YjcyOTU5OGYxMTVlClNpZ25lZC1vZmYtYnk6IExlIE1hIDxsZS5tYUBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYyB8IDEx
ICsrKysrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYwppbmRleCBlMzI0YmZl
Li5kNTg3ZmZlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dXZkLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jCkBAIC0z
NDksNiArMzQ5LDcgQEAgaW50IGFtZGdwdV91dmRfc3VzcGVuZChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKIAl1bnNpZ25lZCBzaXplOwogCXZvaWQgKnB0cjsKIAlpbnQgaSwgajsKKwlib29s
IGluX3Jhc19pbnRyID0gYW1kZ3B1X3Jhc19pbnRyX3RyaWdnZXJlZCgpOwogCiAJY2FuY2VsX2Rl
bGF5ZWRfd29ya19zeW5jKCZhZGV2LT51dmQuaWRsZV93b3JrKTsKIApAQCAtMzc2LDEzICszNzcs
MTUgQEAgaW50IGFtZGdwdV91dmRfc3VzcGVuZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikK
IAkJCXJldHVybiAtRU5PTUVNOwogCiAJCS8qIHJlLXdyaXRlIDAgc2luY2UgZXJyX2V2ZW50X2F0
aHViIHdpbGwgY29ycnVwdCBWQ1BVIGJ1ZmZlciAqLwotCQlpZiAoYW1kZ3B1X3Jhc19pbnRyX3Ry
aWdnZXJlZCgpKSB7Ci0JCQlEUk1fV0FSTigiVVZEIFZDUFUgc3RhdGUgbWF5IGxvc3QgZHVlIHRv
IFJBUyBFUlJFVkVOVF9BVEhVQl9JTlRFUlJVUFRcbiIpOworCQlpZiAoaW5fcmFzX2ludHIpCiAJ
CQltZW1zZXQoYWRldi0+dXZkLmluc3Rbal0uc2F2ZWRfYm8sIDAsIHNpemUpOwotCQl9IGVsc2Ug
eworCQllbHNlCiAJCQltZW1jcHlfZnJvbWlvKGFkZXYtPnV2ZC5pbnN0W2pdLnNhdmVkX2JvLCBw
dHIsIHNpemUpOwotCQl9CiAJfQorCisJaWYgKGluX3Jhc19pbnRyKQorCQlEUk1fV0FSTigiVVZE
IFZDUFUgc3RhdGUgbWF5IGxvc3QgZHVlIHRvIFJBUyBFUlJFVkVOVF9BVEhVQl9JTlRFUlJVUFRc
biIpOworCiAJcmV0dXJuIDA7CiB9CiAKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
