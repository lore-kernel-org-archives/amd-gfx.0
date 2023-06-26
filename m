Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34BBEB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 15:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 749AB10E0B9;
	Mon, 26 Jun 2023 15:04:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D9D310E0B9
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 15:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7FrbXQmh7K/eekpNP+uSH1tD7i8CuZam9A2bDdEB/aOr7kVZPkIGU9ZdDCmcXTz8+BbDS53HGS7bfzx3ebqcvOhgjcQDahvjtn+py5ukYtuOnfz4c2p58a67vF9llQOCNjleb29j/Npff1JTVQRjFJK3pl8w8eKfq+DwQLengW4xDAcCaLeU/qjhYWlO+fwd44ANhahK0kkJmaGhtJNasV+yoeOCwU1fon3pZZc39wm8Uk+/Aib0DYWg5Vg/+DlTGfGMk3dazAXA0t6IkC5MA6r1j24f9YcH8VieRoL+vCpo0Hh/79Tj9b8HxanbL/RghwCEHdArMGo+RNU9V3Dcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuAZTc1aPRzTibPyHz7MkahjaZgp+1rVP2tVF5HNs2k=;
 b=iqogwb4IlXT8QNBrXb6+KxdtYRcTb8Sb1R4nNjby7XsBG/OWOeU6l7ZuoEmyqmhPxivEcZS9FMht0xY6SWytRTzmsJSgZ9bFEIbDDlmldpOoZchBpO/UAXxOTqZXMHDzcycwcTKl61aDXIbiUh2PKRPHatPjWQDh1kRAseVtBMHlgd6Y7FrMY0oQ8kh34bHyn1tYFg1BRHAPjklZrPKTRUgHq5l1r85sTpzspESW5zo7cL9sL3cnGesx1oV0dAT3ryxs2gD8Y70tfi78I9ZYzHydErCuibCTIpCUKsG2y6zRJRse4w1FmI8N6qbai8D3ZofMfB8rsec4WMLM2gaxTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuAZTc1aPRzTibPyHz7MkahjaZgp+1rVP2tVF5HNs2k=;
 b=paNPGDWEaBo3MxIXE7gyJzGQgApJkE5bdKuNBvM4FKhhQNvcgZ9PdsZr+DP5MkrY6/hNbJ6LTWK/zHwPxW9MKpP5jHEToLD3FpjHUpWBx+vqzhb7HBdOT9GeirohwDwquIBwibzYRL9tAqsI/Ra3l1LpoKzHt7gZNxOetKkrbRQ=
Received: from MW4PR04CA0347.namprd04.prod.outlook.com (2603:10b6:303:8a::22)
 by PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 15:04:25 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::b7) by MW4PR04CA0347.outlook.office365.com
 (2603:10b6:303:8a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 15:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 15:04:24 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 10:04:23 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amd: Don't initialize PSP twice for Navi3x
Date: Mon, 26 Jun 2023 10:04:03 -0500
Message-ID: <20230626150407.1447-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d56ac58-6e34-45f5-c3aa-08db7656a144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sg8Fd7HcTqtPQudhFOX1qWxcq5LiemaIISDxW5FLrOLtbgXsJIpTqDwwBGaiUkvVA7Gd516dmqGEL/wEsiKwC0wmkxczTlp4G48mR74WxZDKzjN7pRl9gi4M2gW30Dtgc3Bi6V9g7pXFN2rWmn22E17c+BlkwFYcJG/t7dVnUKmzD4ltkZhQiyToBvTMlCPajfpq5l/xr2g+DhxVFBHQiWZvcYEOn7hV3AFIactRikMZHbKpU/Ozc8q4LG1lLBM8c/rwgbLWtrCKK1zdSWqtrCSZhqT/0ltDVYcdXZS9E8VKpF3YouRxnQBO1b7gFif44j9oGpKSYg9OrkAkU/WZ+4lQpYlx+ueOrJ3QEVdrxa0LD0WVmcOgWCBUaydp1w+fsUAZZC6OC6As+ChvVKtrdOQRN43V/eeYv06wt4fDMjwvvM2oq627hj/VDjAvY4p+BGEqa2w4/bRn/fRBI3KRpgNyntMoJU5uP0tBuYHg7otrrHu7c1OcAS2HIGiSeGgQBGzYW5xuiwqHIfOdyU3ZZ8tuOW81UqW7HSZhXQqymCdRVpTWuIcJXC/y20tul7eGw0zVAiX+slAvH5gWWdI9WTqRn7lj/RfNwBccde3W+89Kj7wb1Nltv60KdjT2GTl6xaJQAqJeDLNGKRFjeAMoPFe/FSl4WfMKKCJeno3n7/cw2WFPY3EDtqTZUP8Js02fC2Md3/L/i7U77L/O7yf5qK+sXyuWBw7stsg93zpfNzkIPSLt6d2ZOPd+g2Wz/mMIMX1FoLwGbSXtv83k64sHb2k69I89/PIjqRTzuzqEoJ8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(2906002)(4744005)(7696005)(82310400005)(16526019)(6666004)(2616005)(356005)(81166007)(82740400003)(83380400001)(336012)(426003)(1076003)(26005)(47076005)(186003)(36860700001)(40480700001)(40460700003)(41300700001)(86362001)(478600001)(316002)(36756003)(70206006)(4326008)(6916009)(70586007)(44832011)(5660300002)(8676002)(8936002)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 15:04:24.6398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d56ac58-6e34-45f5-c3aa-08db7656a144
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PSP functions are already set by psp_early_init() so initializing
them a second time is unnecessary.
No intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a150b7a4b4aae..eb687a338a1bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3621,10 +3621,6 @@ int amdgpu_psp_sysfs_init(struct amdgpu_device *adev)
 	switch (adev->ip_versions[MP0_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
-		if (!psp->adev) {
-			psp->adev = adev;
-			psp_v13_0_set_psp_funcs(psp);
-		}
 		ret = sysfs_create_bin_file(&adev->dev->kobj, &psp_vbflash_bin_attr);
 		if (ret)
 			dev_err(adev->dev, "Failed to create device file psp_vbflash");
-- 
2.34.1

