Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F051C7EE29
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jun 2023 17:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2753310E5F3;
	Thu,  8 Jun 2023 17:07:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C63F310E5F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jun 2023 17:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpD5UImtDOR14NzF9Khnwtd1PeEz5EfLhsC/hehjCSuBrlFu+zy+0eClqQBRqOOSxtf18iMW9W6gZbHpA9lDQ1hwQ1VZnToG09qjrZWVU2Ak9F5JZuXK5716kj21Bol0UQHVOJr6tnKAoPTnAhd3PY9v6OiQqTqwbZ+au5Kn8svdz/rDVHnRUZ3nPORDcxRohTLxBG6OSfYfOp96fsj6B29kVwCl4Q1oJD+bKnWqPQd2qKdcsVF4Koc2FABXL9XDfoUIYlUlsacDECHq/ggxKUoj5WBOaWqK9NOzrsDMvuTDVhZUQzsx39nvJEAU/2G2Dy9ZBnZNHcgwC+o2hcHNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsMEvxf9XuF0yfuVh9XUCJM6s9qJlptVN7vV5JUsvlk=;
 b=D0XaiY3evn9k3QK293e25mQArceRclFETN6dalPrTQwKEBd8FbjV7EfEXHNWFK/Y9JMybLN376ljG27s9S5rz3ez8sIgG0aq1gvP/JoQkMBvKWFr71QWRK1IRuQApbVZg0uR2hdORy/hT9MPf6kQkuygHCON6rNe4WWKuNO30kb63Lar32mI4r9b7CjoXyhc1tdCVQhKds7qN8gkclZMzQZlTqA2pTxn7vxEXlF5ieaYQzHQFi0E65B0Mn4ad1+ktG3uphLWSXwMvnM2yaMk7MC5Mae5ffZY2lYPzPmEju7Yv9uHisIAMFKHq1U5/AnCik+sZ4gNPla02dQ/7xNFnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsMEvxf9XuF0yfuVh9XUCJM6s9qJlptVN7vV5JUsvlk=;
 b=AX90FTedZp9i/xHG/Le6ZIP5wQu9OnFCfTWhenuvE7VohG0E/6qfjtBMrvyoHOdEyd07euVFZwJYo0PtsFLfbSQt3SHCvCOSj/EcXqSjqtgROWQE3XyDpK7p5KDNSCC1K5qeZg4LwgyPJ6WtCNGCbBfhiTjHoDPLlmf0hWhrdm0=
Received: from MW2PR2101CA0009.namprd21.prod.outlook.com (2603:10b6:302:1::22)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 17:07:39 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::f6) by MW2PR2101CA0009.outlook.office365.com
 (2603:10b6:302:1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.8 via Frontend
 Transport; Thu, 8 Jun 2023 17:07:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.0 via Frontend Transport; Thu, 8 Jun 2023 17:07:39 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 12:07:34 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 5/5] drm/amdkfd: bump kfd ioctl minor version for event age
 availability
Date: Thu, 8 Jun 2023 13:07:05 -0400
Message-ID: <20230608170705.2271276-6-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608170705.2271276-1-James.Zhu@amd.com>
References: <20230608170705.2271276-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 90bbd2c0-2015-45db-3182-08db6842dd8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9OHXaVJ+nYEFMY9+flAyYkl3mTY0h15IqkzHtouO76cjzqP7l4AS5TLj0Jeg6jWUctHoG6J1ugEMIAvlTYTKdSFYDEisPaipsYthZ9txBhxG9otOwIqEYsdnhlII6dgcIhNn0LcsR/An60v8m+3b+zPdF90KxQMH5odGSwN0kgOGrTXoqU46Y6/MxbLwLkuHmanEE9C7jh8XYhxh6bh/pGh1QtNMTx9nkoOPj6ZZG0731Sf38gGie2QEdKXgmc4qMDRy9pPrEU6Zl84ZEV0lps3+pFIIIfyxrKNoxWYb6I5/EXiRKdnp2ZlUQ046b+LkMWEuXQP8UtAu2eVuUePTxWGko0uhKSRopW6jasZ1I16LpovfgUjDCqjyitDIRtJk/31g+q9ZbOP9MDQHZh8Po5AHdSPRv+cvxVmyhCjJosAGJpO6fY+2kaDOFpr93NEZ7SayKvJzJt5MfC40RB2VYnqdYKxm3f/4x9ISh5eyVlRWf7oIJLONHJ+goz0YvTAOB91PgOcT9DN9YShyuXjAVv2sB3y9h+XRwH/zRdyfYYvl9bjoeIrX1erT6oviSkBHhm5ScDj2QG3UaFnniqDP1fSdgO01eZo+q9oSjr/IcfDkchXSLnO8ankl7m9umXNA9NxQB3Son3MuIvi6RhGzh+UpuQ8PBGz+YAosvAcuPHAoz0LPEcAneUqAKKh9SS8753TtMdgp7rKaKiE3BKscx+RwxdWw7NdzuYJajut0kKLr6ZzcAR6IEVxcYEMQJWpQouDgemd4gVRpS9F5fn+L3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(81166007)(83380400001)(82740400003)(47076005)(54906003)(4326008)(6666004)(356005)(426003)(6916009)(336012)(70206006)(70586007)(7696005)(478600001)(82310400005)(2906002)(16526019)(186003)(86362001)(40460700003)(36756003)(40480700001)(36860700001)(4744005)(8936002)(41300700001)(2616005)(316002)(5660300002)(8676002)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 17:07:39.5668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90bbd2c0-2015-45db-3182-08db6842dd8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875
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
Cc: Felix.kuehling@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Bump the minor version to declare event age tracking feature is now
available.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 93f1c0bc5caf..eeb2fdcbdcb7 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -39,9 +39,10 @@
  * - 1.11 - Add unified memory for ctx save/restore area
  * - 1.12 - Add DMA buf export ioctl
  * - 1.13 - Add debugger API
+ * - 1.14 - Update kfd_event_data
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 13
+#define KFD_IOCTL_MINOR_VERSION 14
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.34.1

