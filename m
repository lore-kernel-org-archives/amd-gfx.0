Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8D9C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4C42070A
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4C42070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 457936E4E6;
	Wed, 27 Nov 2019 09:15:53 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680078.outbound.protection.outlook.com [40.107.68.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 244966E4E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 09:15:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0Q3mbaunEA1SwUEe0A1AEDtAUrNfm9/VBtOsA4xWH5bl3pRmkWMm+8n6U2/PvDBvf/bNl83vxxLZhORuQXVAA5TzT61CQWODFNHXbMLNUfYmYjVRfGjFSTteBoXzw/pMjWqioENnhQWJUU81B5i960lqMFX7P5AgV5+HcGohS6Yt/V7HsdfTz2zqsXAcOgFR/s5hZ3/VGjmJunQ/kYb9fVc7z0M0FMHQ8IPLgjMyzXxpNRNeqrBD87YgCGP0E3+8OYR2yRBuTALAxinLdxYmtQHgcGeab3bz1PSh43OfxutrqHdzaQHWxbAxtRX54al6FHpDBGzMFwTiO90na2HTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+d9L8uBzaxTXlmijRbLgG9Z2m+Ea2fbcrDZtotxFq00=;
 b=fWc8NOloqrBGNjnrZYjXa1TbYeNKFcG2gu0txsPYJbnHwTrMut4SzV+/5Pd/YvhRgAtY3qpoxLrENl1Ox9MU9J/NsiBnTyG4Htkum/n9PEcaIyowkbWLVJBCVzbnqCGvcS7R6qDRC8O1rYl37ZJOQXhUxTQI3b/U2onerpYyRUkFoCsK5ayNEQGhyNO86FRGzCV6KA6/tbKWI7p3CRLAnn0hV9fgKIjIzMn6LFsuomwtPIA3GcBb7qOCjIxBnT2NQea/Yn6JNkknyvWuEb0gEuqhw/qhV/A8Uaav7Vggp2pUco2oyrskSQtSLAfKju1ZpGd++DvvGGpcOhEnU+j+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0080.namprd12.prod.outlook.com (2603:10b6:0:57::24) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Wed, 27 Nov 2019 09:15:50 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by DM3PR12CA0080.outlook.office365.com
 (2603:10b6:0:57::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2474.19 via Frontend
 Transport; Wed, 27 Nov 2019 09:15:50 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 27 Nov 2019 09:15:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 03:15:48 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 03:15:48 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 27 Nov 2019 03:15:45 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/10] drm/amdgpu: add condition to enable baco for xgmi/ras
 case
Date: Wed, 27 Nov 2019 17:15:25 +0800
Message-ID: <1574846129-4826-5-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574846129-4826-1-git-send-email-le.ma@amd.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(428003)(199004)(189003)(4326008)(44832011)(86362001)(14444005)(11346002)(6666004)(36756003)(70206006)(8676002)(2616005)(70586007)(356004)(2906002)(6916009)(26005)(186003)(2351001)(336012)(48376002)(76176011)(50226002)(47776003)(446003)(8936002)(51416003)(478600001)(50466002)(4744005)(81156014)(81166006)(5660300002)(426003)(316002)(16586007)(305945005)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1354; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84e12d89-7596-4c57-9020-08d7731a655c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13549F04E5AD2FA919720BA7F6440@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 023495660C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PoGlbB77yWrpRxlF3Xa0iV3pcPlQcBnTpvZ9PQMlVDW85YJ5GpwEJAnBtccbb/c+AaUmNStFeaC6dMWksQ0L9NAUWVFLKYX9Wreh2zTc3X+OD8sb7sqVPqBYqLXNlkeV2svLgO580il2dcNpi325oBTzzmJ5g3wfSAtjkULuZbae8HY8dMTolWxZXPAzplprF59e37rWMkc5ey6U6irpZ17pB0m10dlneyaMr68QrFgD02cFQSjUwYgTg9KelmKWs1e2Cm6UV/zdr6FhusXvijIs+hESQldBUvh27BTr2OepuaY29OEMH3od5u7qXNH0OV8ltBlr73YlP3a1dJ2bUtaUXH+jQnYkfacR+BqaHtIZF0XnSbyEf3Ta/et3jqql1TsI2M7FyUSxoQhDxgsCfv5ff/tkBjJo1Gk6k5C6jwIkhRh85x09/HV9FDp2YB/i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 09:15:50.2282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e12d89-7596-4c57-9020-08d7731a655c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+d9L8uBzaxTXlmijRbLgG9Z2m+Ea2fbcrDZtotxFq00=;
 b=pBY9ZPa6yXFBdfSpdj5rQ53hTM8noWwsKAwfkYdwiKUT6/A6pyzC/8cpg/n88YYl13TVFSUbxHMqsIfK1AKCX8FKWgZLpiTxneu8ujEJxg3VElN+j+HMeecQWn6PBOogTUBSuRTEMIiAKNGPFiVU75sHVl8i0ejQ6D+Xmh5Nhxc=
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
Message-ID: <20191127091525.wgoBxKIkGBRF7v5VWv4Mv_t44jG5C9X2YVxYQrHi1RM@z>

QXZvaWQgdG8gY2hhbmdlIGRlZmF1bHQgcmVzZXQgYmVoYXZpb3IgZm9yIHByb2R1Y3Rpb24gY2Fy
ZCBieSBjaGVja2luZwphbWRncHVfcmFzX2VuYWJsZSBlcXVhbCB0byAyLiBBbmQgb25seSBuZXcg
ZW5vdWdoIHNtdSB1Y29kZSBjYW4gc3VwcG9ydApiYWNvIGZvciB4Z21pL3JhcyBjYXNlLgoKQ2hh
bmdlLUlkOiBJMDdjM2U2ODYyYmUwM2UwNjg3NDVjNzNkYjhlYTcxZjQyOGVjYmE2YgpTaWduZWQt
b2ZmLWJ5OiBMZSBNYSA8bGUubWFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zb2MxNS5jIHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29j
MTUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKaW5kZXggOTUxMzI3Zi4u
NjIwMjMzMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCkBAIC01NzcsNyArNTc3LDkg
QEAgc29jMTVfYXNpY19yZXNldF9tZXRob2Qoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJ
CQlzdHJ1Y3QgYW1kZ3B1X2hpdmVfaW5mbyAqaGl2ZSA9IGFtZGdwdV9nZXRfeGdtaV9oaXZlKGFk
ZXYsIDApOwogCQkJc3RydWN0IGFtZGdwdV9yYXMgKnJhcyA9IGFtZGdwdV9yYXNfZ2V0X2NvbnRl
eHQoYWRldik7CiAKLQkJCWlmIChoaXZlIHx8IChyYXMgJiYgcmFzLT5zdXBwb3J0ZWQpKQorCQkJ
aWYgKChoaXZlIHx8IChyYXMgJiYgcmFzLT5zdXBwb3J0ZWQpKSAmJgorCQkJICAgIChhbWRncHVf
cmFzX2VuYWJsZSAhPSAyIHx8CisJCQkgICAgYWRldi0+cG0uZndfdmVyc2lvbiA8PSAweDI4MzQw
MCkpCiAJCQkJYmFjb19yZXNldCA9IGZhbHNlOwogCQl9CiAJCWJyZWFrOwotLSAKMi43LjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
