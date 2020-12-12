Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413DAC4361B
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1DC22AAD
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1DC22AAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AFC56E82E;
	Sat, 12 Dec 2020 15:46:10 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700045.outbound.protection.outlook.com [40.107.70.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B4C6E82E
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApJeQ2dgdJ+sYxTRN+STILgRxaCaWkni3lX7jJ967iDApigsX3nF9V5OCiGAcp4b0bGLfF2xcrvl+8vSeok0QIjx0NFuabdzyokGASIC2Vr/HyMdwpZviwP4CySCar/2/+8kZNbuUzVWyPpnHvEi1Ev7IVIYhJLvIBrG7ZNuG1SArk3gE2443EJEOdU/7XVbZ0wdDLXP5h4LNGmuPvbgFwGI2ui2MtZXnYmZq84IPKUhWsU8b7ZaDVlxj6/LkKwhkxhj3sAwTKkoHxdqNAo1eFcq2mQIwyer4E/jRMktAxTb6foH3t2xSy2/yZoqarPjBOei1AAxDSn34cRmGqPUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0m0buEeqnqShTvD+Gyw9Kru/0h6J0GuP8Jg3tYL1s8=;
 b=NblxSCEdmymUJm0lMpem3uOw1MS7d/DYbraSyyhVSykOjXMGgkD4PwT39nq80J4jHNwhJDHihUFx8S0jbr1Tq/qTDhOxKF8Q6WzWQr+femj8yrVUZwDm616LRd+uC37KkBfEoYWjadi6a0dWvNRpnx5LSm6hGs3Y2x/s5KSDos1yaOmIZWN0XoZRWsTwxdG1lsezdxQlBkYYKlmb0DiU/7cAYPC5SIp0M6nWUo9B1qpS6sykzd3iInJQkGIjiVFEW+Wh9pb6n81HVwhtTc6H9hOLFUgK/c6dztUdIoH+NRBWZK/f+v4G3i3xD8isEqjxwpKYaDQGwB5neu9DYyKNLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0m0buEeqnqShTvD+Gyw9Kru/0h6J0GuP8Jg3tYL1s8=;
 b=I2VmTWYuF4S7ehqhzIDT7TZalAH9c7kBoMnhHWCV5mk7Hzpg9KF5uvVe+N/b1LKd8IyV/3sIVwGAf4AE++UjHgvFkYicrpgoLQt1f525sGfIoLqW9NaAPujNxRSsadwdAWJXPXQSERiuKDwt89H+qASPm4YjAlVmb0Xgk9zG7Vo=
Received: from BN6PR1701CA0015.namprd17.prod.outlook.com
 (2603:10b6:405:15::25) by MN2PR12MB3229.namprd12.prod.outlook.com
 (2603:10b6:208:102::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Sat, 12 Dec
 2020 15:46:06 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::94) by BN6PR1701CA0015.outlook.office365.com
 (2603:10b6:405:15::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:46:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:46:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:05 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:05 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:46:03 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 01/27] drm/amdgpu: add amdgpu_ih_regs structure
Date: Sat, 12 Dec 2020 23:45:34 +0800
Message-ID: <20201212154600.21618-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d10a00f6-5692-4cb2-965a-08d89eb5098d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3229:
X-Microsoft-Antispam-PRVS: <MN2PR12MB32294631E71AFD28CE28D1CBFCC90@MN2PR12MB3229.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3GPY0AFjnEYR62WwZQZCfKvAlSg8FO1L0D73lGyxlWyPLwhQX3zuZDZQBBe2LlXiX6vr4nkl2G5bLBrTTuuVd1r0/452ErUXGbjY2pVD0SDcRS/Jt5AHAtTQh7G2/sIt0PCQ565ew7ITUrkFIyZESwMPELOLsyTj7sPMOPvR73pjGwCwP4Xpro4mrYfZdp/QJbxeM5T2OZnyr0X172v2rnVE8ZgmBVHPBAUUBGHbFrOmogKO2tpVJ850u/ML/jecfXy2EtPVCsGCNW0SYQ8u0oW5URM4MVebLOMyKi+v7gkKY6hzzW1LCAgIexdB/QIhZhLvqK63hcl9PmE7RsDhf7MtMgwSRuE+dOimWhY8rpFe3dJU/7pGRdh5bko5t9m6SJD2pX0iGDIzH2/qTVM9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(46966005)(86362001)(81166007)(6666004)(2906002)(47076004)(8676002)(82310400003)(356005)(6636002)(5660300002)(336012)(1076003)(83380400001)(8936002)(26005)(70586007)(110136005)(508600001)(7696005)(70206006)(2616005)(4326008)(186003)(66574015)(36756003)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:46:05.9028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d10a00f6-5692-4cb2-965a-08d89eb5098d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3229
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

YW1kZ3B1X2loX3JlZ3MgaG9sZHMgYWxsIHRoZSByZWdpc3RlcnMgZm9yCmFuIGloIHJpbmcKClNp
Z25lZC1vZmYtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KUmV2aWV3
ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQWNrZWQt
Ynk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTog
RGVubmlzIExpIDxEZW5uaXMuTGlAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEZlaWZlaSBYdSA8RmVp
ZmVpLlh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lo
LmggfCAxMyArKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmgKaW5kZXggM2M5Y2ZlN2VlY2ZmLi45
NGM1NjViOWVjYTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9paC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oCkBAIC0z
MCw2ICszMCwxOCBAQAogc3RydWN0IGFtZGdwdV9kZXZpY2U7CiBzdHJ1Y3QgYW1kZ3B1X2l2X2Vu
dHJ5OwogCitzdHJ1Y3QgYW1kZ3B1X2loX3JlZ3MgeworCXVpbnQzMl90IGloX3JiX2Jhc2U7CisJ
dWludDMyX3QgaWhfcmJfYmFzZV9oaTsKKwl1aW50MzJfdCBpaF9yYl9jbnRsOworCXVpbnQzMl90
IGloX3JiX3dwdHI7CisJdWludDMyX3QgaWhfcmJfcnB0cjsKKwl1aW50MzJfdCBpaF9kb29yYmVs
bF9ycHRyOworCXVpbnQzMl90IGloX3JiX3dwdHJfYWRkcl9sbzsKKwl1aW50MzJfdCBpaF9yYl93
cHRyX2FkZHJfaGk7CisJdWludDMyX3QgcHNwX3JlZ19pZDsKK307CisKIC8qCiAgKiBSNnh4KyBJ
SCByaW5nCiAgKi8KQEAgLTUzLDYgKzY1LDcgQEAgc3RydWN0IGFtZGdwdV9paF9yaW5nIHsKIAli
b29sICAgICAgICAgICAgICAgICAgICBlbmFibGVkOwogCXVuc2lnbmVkCQlycHRyOwogCWF0b21p
Y190CQlsb2NrOworCXN0cnVjdCBhbWRncHVfaWhfcmVncwlpaF9yZWdzOwogfTsKIAogLyogcHJv
dmlkZWQgYnkgdGhlIGloIGJsb2NrICovCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
