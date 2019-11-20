Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A388C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 19:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D0320674
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 19:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D0320674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E246EA27;
	Wed, 20 Nov 2019 19:44:04 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740059.outbound.protection.outlook.com [40.107.74.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A1F46EA27
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 19:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R46m8LgLO6zM1k70tZ0sxUwhbdl3cb3G0YAFpap2HH4jN8JcJ49eh4zjndpWl44EWPm/u+F+ahD70FQ9MSuL0LOVqZJz9g4rXBF8IT3Q3YYDcYRb/r0R+hR+dlDJUMvXbSciHE5znPabS1OhGQk7dras39YEqGj2KL23VIgV3niXYqz+azJqWSLmg7NhLVFCoeksxp/guKdl8P7B2ln+ugsDncCa9THBh1jQIzO2g9cUGHnFsZW7eZe9oq+yPzrUueWpRaOgA8Z7NHua4CfzTepC4JAwHVLUowKJ4kOARz/dPgQx7yVRM3K8rYPQoSIWh9lvKvba5rxw5LdznIWYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqQQGysz4W3wB1dYanlA+SjXdpdzr1JQYvlFYJ8s1pk=;
 b=Rjb2rhnb90AZ5Ish+762kNLJObDSu2xEDqYR1yOjZgej621z8u5cRW3ofB2YhQOA/3+d5bfgDCwOXaN2FbyIaiboZFfji1v5FUIzaxklqDiBYECPr6QDAde3NL9lvsHuu3fBUPcqzWUBXqalqsWPlEmnA/sa32m9STJ2AXY+3eqbD8qNZQ0HBykE7uqU3XROyMvch+P9cV30EklhmX2QXpIDoxi1d5lihze/EYsq6UfRG+7Uoy3LchK4KbSdzvKsZ60I/90lKvoCf6eQUYO1+vSdITFkdQgYW0tWbjtd6Grlm6qNStTdlUMCjbYHn72kGApbXBxQLNea6p8vG4if4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM6PR12CA0021.namprd12.prod.outlook.com (2603:10b6:5:1c0::34)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.29; Wed, 20 Nov
 2019 19:44:01 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::200) by DM6PR12CA0021.outlook.office365.com
 (2603:10b6:5:1c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Wed, 20 Nov 2019 19:44:01 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 20 Nov 2019 19:44:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 20 Nov
 2019 13:44:00 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 20 Nov
 2019 13:44:00 -0600
Received: from a.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 20 Nov 2019 13:43:59 -0600
From: Zhan Liu <zhan.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <zhan.liu@amd.com>, <Dennis.Li@amd.com>, 
 <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH] drm/amd/display: Change mmhub_9_4_0_ headers to mmhub_1_0_
 ones.
Date: Wed, 20 Nov 2019 14:43:45 -0500
Message-ID: <20191120194345.10267-1-zhan.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(428003)(199004)(189003)(47776003)(356004)(6666004)(86362001)(2201001)(81166006)(486006)(50466002)(5660300002)(316002)(478600001)(186003)(1076003)(16586007)(110136005)(26005)(7696005)(53416004)(8936002)(336012)(81156014)(2616005)(476003)(2906002)(51416003)(48376002)(70206006)(70586007)(6636002)(8676002)(36756003)(50226002)(426003)(44832011)(126002)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3848; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f756d5b7-892f-4d25-3b8c-08d76df1fdda
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:
X-Microsoft-Antispam-PRVS: <CH2PR12MB384848ABA8927194A5F67EF29E4F0@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:303;
X-Forefront-PRVS: 02272225C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3K6TrT7FJpJW/jZ7fN+7rXiawDW3XGdyoSI69+I5ZMiJmlp7bfElfDoHXsAJppzTcPoGsLTMiAqu66jHp47hh50fPQoi1KGjzlaIP5kvcO7QHKfFmXbh4Y75nX3J7irf2Uf5W39UVzk2u3c9s3oNmzNddSapHZt3S+P5v++lVZ3WYsNmnLMd4B4jWTMb6llhKQPB/o5yIt0iyaDN7etrtjTP2Vd0jYk8I1A/OESaY8x6KlwAQrMQTZOYA2625R/z9UkNl2OAY6RL0obZR24h5+/cbgRsoVE+lX4pneHDAJvuv3yN+6kudsoGHQ5b6FZpSKj1JKyMIKNRbxioCltxifs4AnQTF/PifDGcf9B04aFm6obTHbHP5H7rJ0LMXJ/ZJjIDRUGb/ll7xjUkd2xnr2M8LWZduIhdEY+lKV+xT5t5qbKTu8oVe2BGBqzniH66
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 19:44:00.9277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f756d5b7-892f-4d25-3b8c-08d76df1fdda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqQQGysz4W3wB1dYanlA+SjXdpdzr1JQYvlFYJ8s1pk=;
 b=jJId1quyZ2ZgCrMXXEKzIPs5zxLofXrntqp0JxT1T6zPI2gJtf7XQcjJUkRB6pMk6LU/PmmwsLFeIydGT3YjPF9oH3Pmd1C1s2hvrUJBaO9cbqUZ5dw2MWTpOhI12zf9GuCURP2wR5WxRSTh5U36zOYhYQf45d6ejxl8ai2i2Hk=
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120194345.B33MJ_gxZ463-hAuUtnSkMaNr2wXJdZ-zO7i791ByHw@z>

W1doeV0KS2VybmFsIHdvbid0IGNvbXBpbGUgd2l0aG91dCB0aGlzIHBhdGNoLiBUaGF0IGlzIGJl
Y2F1c2UKbW1odWJfOV80XzBfIGhlYWRlcnMgYXJlIG9ic29sZXRlLiBBbGwgY29udGVudHMgd2l0
aGluCm1taHViXzlfNF8wXyBoZWFkZXJzIGFyZSBpbmhlcml0ZWQgYnkgdGhlaXIgY29ycmVzcG9u
ZGluZwptbWh1Yl8xXzBfIG9uZXMuCgpbSG93XQpDaGFuZ2UgbW1odWJfOV80XzBfIGhlYWRlcnMg
dG8gdGhlaXIgY29ycmVzcG9uZGluZyBtbWh1Yl8xXzBfIG9uZXMuCgpTaWduZWQtb2ZmLWJ5OiBa
aGFuIExpdSA8emhhbi5saXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNlMTIwL2RjZTEyMF9yZXNvdXJjZS5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMjAvZGNlMTIwX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTIwL2RjZTEyMF9yZXNvdXJjZS5jCmluZGV4IDMwNWJi
MDg0MTU2My4uNTNhYjg4ZWY3MWY1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGNlMTIwL2RjZTEyMF9yZXNvdXJjZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY2UxMjAvZGNlMTIwX3Jlc291cmNlLmMKQEAgLTYzLDggKzYzLDggQEAK
ICNpbmNsdWRlICJzb2MxNV9od19pcC5oIgogI2luY2x1ZGUgInZlZ2ExMF9pcF9vZmZzZXQuaCIK
ICNpbmNsdWRlICJuYmlvL25iaW9fNl8xX29mZnNldC5oIgotI2luY2x1ZGUgIm1taHViL21taHVi
XzlfNF8wX29mZnNldC5oIgotI2luY2x1ZGUgIm1taHViL21taHViXzlfNF8wX3NoX21hc2suaCIK
KyNpbmNsdWRlICJtbWh1Yi9tbWh1Yl8xXzBfb2Zmc2V0LmgiCisjaW5jbHVkZSAibW1odWIvbW1o
dWJfMV8wX3NoX21hc2suaCIKICNpbmNsdWRlICJyZWdfaGVscGVyLmgiCiAKICNpbmNsdWRlICJk
Y2UxMDAvZGNlMTAwX3Jlc291cmNlLmgiCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
