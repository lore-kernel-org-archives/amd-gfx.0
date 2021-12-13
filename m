Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0D9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 04:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB40E10ED0F;
	Mon, 13 Dec 2021 04:09:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F00C810ED0F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 04:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqZZhLpkp1L4Y7iE9Dd4Xj9S5hm2I9VdchCXNVDitjWpgSM17V8SJtJ8zuELMrIc3R5pHfZFCHh2fqY1OdWtHT0dWoWLWAYjn5bZBY52anjj6RuFq1sUU3zGj67UoUuN4lTLQDh98kaND6WqRDdKy5lFAPLG9Xnrw0wu+Eg3vhTToj1sRzCunR7Mn0XYSJ2wEoFdiYlU+hP5udAR4QLJ9fnY/RbiAzcFCRGHgAo6aUfj9Q2h9fcdMM530fvxrXleKwZ7PO15/qgz+t7/ti2JOfU1XLVLtQcvUyXH91L/BCSX1UjBP9kxCgRejO100SPU1z+Sg8OT93h6cV7mNEUWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=979YzmEJQGE052tsBv4mM2cK3OCjGpgqJJFmMfSXU9c=;
 b=SocLPjm4XBQ9ZWoFQppG+tX2NWQBloygaSNnFIXnEEiaKb6S2rE/qmfQ3+yBMHtMkxInIPv3FG/BxrkA/5Y+OjCwYln7q4T0ssaOVISAcKlZYE6BE3zkkPj/JjxQ5rbUxA9rXE/efI4LiY9oSsZWJo6ihY6eyh0J8AgwLQfpzh5BMaQGNUncVBBgOUCv0Bp9cbQs2Tua6MaBtEioiBeRmFGizevojWsLqi4WjYuwUa7qmSelpfdiYiDrZb+2jacyZGq4+QB09e47DcU6Ss5JAFFSWY8u/EPrRpMIYefPy9EUSdwFo+iXD8kbkuEXKH6h31ivc9ZT3ZK8BmbJgegJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=979YzmEJQGE052tsBv4mM2cK3OCjGpgqJJFmMfSXU9c=;
 b=aNn9uSXk93oejLWdRhcqA2MMX05q0mrcT4xkabCX23wKt6ix38Tb/pBRjtQgp4K10SI9puBTx3gkqKX7bd4yD0KnchocKV/B8brHKs4fpHdriNqOMOJMV/GZr9qPk5GXoMs0o27iCZdXhlAlT8s6arNc64Py1cEtbZq1rlL5K9A=
Received: from DM6PR17CA0013.namprd17.prod.outlook.com (2603:10b6:5:1b3::26)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Mon, 13 Dec
 2021 04:09:14 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::19) by DM6PR17CA0013.outlook.office365.com
 (2603:10b6:5:1b3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Mon, 13 Dec 2021 04:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 04:09:14 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 12 Dec 2021 22:09:11 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>, <lang.yu@amd.com>
Subject: [PATCH] drm/amdgpu: use adev_to_drm to get drm_device pointer
Date: Mon, 13 Dec 2021 12:08:56 +0800
Message-ID: <20211213040856.2059-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b4da8a9-3b6a-4acc-d37e-08d9bdee5309
X-MS-TrafficTypeDiagnostic: MN2PR12MB4176:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB417631C30FA5B6506343CF14F1749@MN2PR12MB4176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8kLJMXnYvnmNgq2Pjknvo7PLBfclGrpt32wHH6eGin0tUPz6EMsnqCDnAZwt4KP9mlErcHG8c+2UGY0hhcFFcJknUJO6Le6R0x3kGsKvd964T+Rv2L2OdGN3+gtFDAxuNgP4FVVvw082XjU47IL4qbhMA2KIvSIV6eW1NNIZqjA7fawakIeFiOA78DYwg/U5f+G6ijUzghmSsCqmRrCxFAyOe7YgGwIc7zUW0ioGJTjqkc+ZD1wMIndr0xQ+gQBsoeAHG+0NjvTrXrp6xIPdbGKQdGq3vXtr2JXDKV25cni79a0sBP8GQNrrdr5Tx6Sc3rAXd6kh68g5XJEmJo1Vg1FKhUstaGVd/nYYBPv3uQADBr9g3QLuiyrqmbGkuDUl5dXDjCZpe1wTXD4buu145TqcrduNTDT0r2aNZ3UU53C+MP6dwbv75JMo62TrEw5VYeYNkOem/Tiiq138dbhxSh12wnlmwke4BiC1d/MKvjeAkgkiyAO8TTdupczAP7bYCcN/dV0xqcCzlUBcBjk76p+TEX2MXzoBaXJIdB3HiJKD8sYOG7Q82WOtQn1sAurXN5iu+wNKbx/YJAXwOXVJwB8bHZ3HWJnD05TkCtpPQnQtvjgiNCsgm1iTHtuXR9Dc5kxfuCxWCnK9GXlT8qbxZbgw8hop2w9H9zIEEpUUT0Uxp3JV3EUv5xEZLcKRlxbTjlCwHBX7hPntmdM4WLT10cyUYf7vQoYu69T4Ymuv/XESUaRp5mWOwnfU8YOs7Ede3iSgK1KSCrISLsPfkGGwG/sG+biWU2VCG5ag+QDQfXOIGK6CLZ2mdntd1a2NsVP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(8936002)(70206006)(36860700001)(6666004)(316002)(2906002)(8676002)(5660300002)(4326008)(70586007)(110136005)(508600001)(336012)(82310400004)(426003)(2616005)(47076005)(1076003)(44832011)(16526019)(186003)(86362001)(4744005)(6636002)(83380400001)(40460700001)(356005)(81166007)(26005)(36756003)(7696005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 04:09:14.1561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4da8a9-3b6a-4acc-d37e-08d9bdee5309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Updated for consistency when accessing drm_device from amdgpu driver.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 48aeca3b8f16..b2c3892e8e7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5705,7 +5705,7 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
 void amdgpu_device_halt(struct amdgpu_device *adev)
 {
 	struct pci_dev *pdev = adev->pdev;
-	struct drm_device *ddev = &adev->ddev;
+	struct drm_device *ddev = adev_to_drm(adev);
 
 	drm_dev_unplug(ddev);
 
-- 
2.17.1

