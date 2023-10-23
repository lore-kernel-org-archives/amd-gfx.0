Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BE7C25B41
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 16:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1125410E05C;
	Mon, 23 Oct 2023 16:12:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3291B10E05C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 16:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Om4PApfwewmIUYHVwZHOu2ifLpU577cx7mYpPkExeedH8Gv9/YJegYOsETTnmQ4RU7mvxnXOFyB0arU5Jtg4hFnHnUFplK643uy6SxAa8fqj2uM6/EepX1xbG20DBK98QV79fhGx5LIUY68HJv/KYFEz/KzaedF2NQqkZjNSh3rJz/SmRaCiT3Z62qIkyHIaiSFzbTTIdOfFfSL+I+8u1c6FopmQDlLV3HTRfKFyCjMnbnRNOMChTlcFtKOaxXDiUtbkTJE3oqh05K+F7SNzMS+RmAER/jczEWyXYThl6MK93QWBE1NNNics1BqboH+68eYq2AALXMG2X+PzGQsrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdFhbwq0nYM8aMhPLzymYqXhoutv+EH5VpIWQvIRBws=;
 b=ZeY+xuy3HoqbM66XNNMrGpwcElQnP6JBTvtK5PEKf14Cnz2J1gFrTDGOXMg4ZkFcmQuu5pdoT6+dtYzZSsGGt/m2MttRQ/7YVC4+G/Ab/u9anpMhruBPvrN6yFByVhTs5AfPvqOg/JPWmJ2W8s5BDzWJf8iReN/FDJAoXF6BrkOfxt+BGE30rMsZIOz5yrFM281MXlByrLS5k+RbEhvde9sASmd4AqJeY9GK4vkgc5RCzABOexjwVXfnYG8PLFpr6MlktKWfipiatfkNmWA5zYMIdK5UG3Mnm4dcUwJj2t5xDHp2MRCZhicV4+H+4yousvrbUV5dyu4XdXevufQxqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdFhbwq0nYM8aMhPLzymYqXhoutv+EH5VpIWQvIRBws=;
 b=mHP0KHgXwLAh8XpQnhWDgKfDLg9hWcxF34/eNiWM9g8ZlaS7gAkgpp2SxnARb8FCdTXUcHGaYxPKHMViv9CaPT95hCUO+IzsEXrGPXnz+c7aQQFsBKTscu7m9CpJv4YSGV+JW+3MpA///+p05Q7Bte4iXvIXVlAv3XC9fNKuyI8=
Received: from PR3P193CA0034.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:51::9) by
 DM6PR12MB5008.namprd12.prod.outlook.com (2603:10b6:5:1b7::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Mon, 23 Oct 2023 16:12:52 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10a6:102:51:cafe::bf) by PR3P193CA0034.outlook.office365.com
 (2603:10a6:102:51::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31 via Frontend
 Transport; Mon, 23 Oct 2023 16:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 16:12:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 23 Oct 2023 11:12:48 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Address 'remap_list' not described in
 'svm_range_add'
Date: Mon, 23 Oct 2023 21:42:31 +0530
Message-ID: <20231023161231.2874227-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|DM6PR12MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: c4753531-89ca-45af-a27e-08dbd3e2e7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9RnipRzC5Ru5FlWYQbfCEZ0+ZuSUzSz4gt+rIMvm1bt78ZdmHIe3w9FMygQRk/lfy50ZQsEY7VQxIVk6lea2qpBQ/6OO56RamWfl9EXMvp4KR+dGkpX9L1Q0jpWvTCsBasdZigDvglvjzt7sn0GWX3nnfhDEc0GwPKjZB1/x3Dp+fPvfRJ4WHaZ2zqpZoE4CL0tY3L5BAbN76afh9I56+g144khKmDPPw62/osXXrtQA4xAkqdLkh8EetkiZWvn/IERfnmY2d1ukudIg6nDTF/9u1TD6NkNFetJ/369MbQ5CNwGz8mDm4tdXU0bcoXXIfYGVzUKHNNEP9mLF7fwqlxrKtZnzf6edvg2UWq0KjnHVva5TibycJlvkAUdEyyCjKwBCzBRznz6v2v8+CBSWI2Yy5E0q/8GiBIyD4y5wZASk6lfSdF/Yxo3rhPWsGvdU/03khCrEZrMF9c85+7zQQdIxB+mM4u6te0u3TLxkfaB2kwSpJdKV7ZA4tCK2SzyBGd1xeq1zN6K2c0W+ZknTktaqZh0ri5bV6dSsZPyXSy6IwFJXybXmA0Kt+xNNs+xVdTHml4VNwegyqxUKtfwPu2/ELT7B1RPJLTgzPbIm+Uyf1mHl2JxDzOrL4lzA6SCRfU14gpXPbtpK/BUu8C48oBP+EAf9PzkkfEYZ/dUUktN0OSMDIkq4Rpu56j/qd6vgoIdW6u8lSeCOqw7GSvYOxHspRGChX6tsb9dluPLuODjbrk9pCBQZN2CoI0sQQ3WUCz+zlhEOnMhU4MHWfd6p0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(1800799009)(64100799003)(451199024)(186009)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(86362001)(54906003)(70206006)(70586007)(110136005)(41300700001)(6636002)(316002)(7696005)(6666004)(5660300002)(478600001)(4326008)(36756003)(8936002)(44832011)(2906002)(36860700001)(26005)(356005)(81166007)(336012)(16526019)(2616005)(1076003)(426003)(66574015)(47076005)(82740400003)(8676002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 16:12:50.8039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4753531-89ca-45af-a27e-08dbd3e2e7d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5008
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:2073: warning: Function parameter or member 'remap_list' not described in 'svm_range_add'

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f2b33fb2afcf..f43dedf3e240 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2046,6 +2046,7 @@ svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
  * @update_list: output, the ranges need validate and update GPU mapping
  * @insert_list: output, the ranges need insert to svms
  * @remove_list: output, the ranges are replaced and need remove from svms
+ * @remap_list: output, remap unaligned svm ranges
  *
  * Check if the virtual address range has overlap with any existing ranges,
  * split partly overlapping ranges and add new ranges in the gaps. All changes
-- 
2.34.1

