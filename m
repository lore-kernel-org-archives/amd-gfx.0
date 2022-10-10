Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C116C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Oct 2022 03:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6588E10E452;
	Mon, 10 Oct 2022 03:12:53 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A80AE10E43F
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Oct 2022 03:12:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1/+bLCrZcOA+lp9QvScvp5t6M7O2htTolENynlzKesE69NkIzCLObvCcFxJC0HBBX7Hy+MS2Xy5f+kDdWK08s854UCsMAOmFqtjn+sjox02Z+Z2Z029gjBtr22DcJbaSA+KH3qnoJh+dWvpDi6KGWGzA9obgK5OHLBRpNlFcJFngr7XsZbumpz1BN5TxFlF2pnxN7ngmTqVMtp2vvW1+97xAbBtrbLVhdiUufqXk2XqVrOHlvkTtdD0GPErAEOSq15/ao/6Xbd9w8IlZJurRtT1+VW8DGzEDSlF+FnOXYwNpFwJ2JXeppbK33+or9wTNFaKPfaIKie3bxq3ct/8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCkcQuwvAASj7nU4pGDKZ73yPEVJH8VS+X3SL/J8hRQ=;
 b=kueI5rAJNR/pTJ0tZ4O8nCL7ZYfgxO18xMXA0ExU5X6I8LTzN020Nk+FyoynNULhd7kebU2NWr8KjSALRQzjxe0dHmmhlRKEvWsIzOPfmDqova2xPcgrzhiXnu59q/gJvfOZzNPIxUNrGQs9r3WAucOH7FAsfdlbmIo53QBT7qgvzKDlPVwVgDstYPvOsmNmb8FErvbrbeQR1h4aUkORTwtGWVqsgO01HxTDrFnb7eUvtQ8xbItYuhT1WoMT/TERYoiSu6DBxa9KGvpsK2/slNweNq7lOpxbxjuPNhxIgl9Lpev4dZUZrT9UXTtUwwkCBDD9oiEyJlvzql5C87Smfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCkcQuwvAASj7nU4pGDKZ73yPEVJH8VS+X3SL/J8hRQ=;
 b=0M+IN+dGpglrV3zB7Zrhl7DkJy2YuE8GbIXcpqa7wgyuQh53IEWb3p7iQUofIVVat18iaZZBeCtEgAYxon8jft9qQJVBiE7Oq1W8OLxSn1vgSDApCyGwy/DxcAhjumV6FAOMzgZjsnQD+E7tYcaTp2iyx4MMaA9CywNzt7uze4s=
Received: from MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::19)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Mon, 10 Oct
 2022 03:12:45 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::de) by MW4P221CA0014.outlook.office365.com
 (2603:10b6:303:8b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.40 via Frontend
 Transport; Mon, 10 Oct 2022 03:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 03:12:44 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 9 Oct
 2022 22:12:42 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: fix coding style issue for mca notifier
Date: Mon, 10 Oct 2022 11:12:13 +0800
Message-ID: <20221010031213.19258-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221010031213.19258-1-tao.zhou1@amd.com>
References: <20221010031213.19258-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT048:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 1887539d-acbb-4993-1406-08daaa6d4d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8yfP1Mz+D91gqoKdnYdek984dDNfLM84VTmvHHrGG6aLdnIZuw8qhr9nbiUra/dsu6laDkVObjjlag/i1Q54VsUjyKiaJv0MhiGE1Sm7DszTd1bgv4bajkfKV3chjYthj3/rsLjpSaoqOinSWmWnALfDRH452ccU6OhxhetknmZVxqOZmJ/9EGILuY2evSS+yYD3/6FL5XXdatR42kt+0m0iM2oRBgofY5tkfdJnYxVet0zvn8hMSB1besNaZQyoJJonIDqaLESU2xxiUc7c4XP5t/ZnuEvOxKP2yBsFjYqz857sVpetbj7VfhYGrQDx0A+wNjGmmJALljcCEIYI1f6uieHD1oEKteUzDS/HFMz5rZgspf56GCyJmKBTn9GGRbUgbDh5FsWJ3/Yl4rYPVhT41aodMJXgqqew6ixBshWEs02HVE8J9+zmkBURN5OdyKzxd01bKrVfXhvKYHVNjZQZ3M157wVdeaMrLHNbd62Zi0B0aD74svUZ1h6W1rePIdKyXKm6xl1dnmS61dirv8rZZ4Tzc7H3ItqJWrvOLbbi68893O2XhYf/6aB7i2ZTgTqg75ImwLBb3wLnm2miz6icHzyVIwI0WwKjiraGSDKiIt4mRE3luLX7CsgTioATcnI8/kW908/RP8OdR+RNNuI+ebKH7c2Bhp5eZ9vaZdNFaf4W54BjpI5JrgBLQ5V9eitdsCasGJmAuZDhW3LajHn8QQBBL7vFdWvNusrFe8AUgi5af2hug536DDhIdY3+xibVrBko8AlW187tutP+sSx3DU3a+lca2Ip/11XAv17Nn3ebzgxDKfG9CqfLY8x
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(70206006)(478600001)(6636002)(110136005)(82740400003)(82310400005)(86362001)(316002)(16526019)(426003)(336012)(186003)(6666004)(2616005)(40460700003)(1076003)(36756003)(26005)(36860700001)(40480700001)(8676002)(8936002)(356005)(47076005)(83380400001)(4326008)(81166007)(2906002)(5660300002)(7696005)(70586007)(4744005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 03:12:44.7453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1887539d-acbb-4993-1406-08daaa6d4d2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix some issues found by checkpatch script.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c2f9970e851c..2dad7aa9a03b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2877,9 +2877,9 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 	err_data.err_addr =
 		kcalloc(adev->umc.max_ras_err_cnt_per_query,
 			sizeof(struct eeprom_table_record), GFP_KERNEL);
-	if(!err_data.err_addr) {
-		dev_warn(adev->dev, "Failed to alloc memory for "
-				"umc error address record in mca notifier!\n");
+	if (!err_data.err_addr) {
+		dev_warn(adev->dev,
+			"Failed to alloc memory for umc error record in mca notifier!\n");
 		return NOTIFY_DONE;
 	}
 
-- 
2.35.1

