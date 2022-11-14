Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C6EC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Nov 2022 01:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDDA10E25A;
	Mon, 14 Nov 2022 01:42:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4564E10E258
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 01:42:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIWo+Ow7untOGimnXpkNvALOQD4y8oc44zEz3SVlO4TiPf2GeARfqTrzyHgzUfA4orE60+mB4OaM1pYelPGmqup8P00aFWV4sOeex3h7VSmib4QFHJok6K/rU1qZCR01eYEP5RnSFPyQN00Y17Wa4KEPk6FHp36MuwrEnBryzKokmY0c7z5N4KoXD7sqKbvbocZ2BkBjwJuV4Y7/a2pNrzDdv82z+ZS7wEMxrnammNhFCkHBLDh3ckT6ngyQXIQCowtCVph0mHPG6jDS4ilrFSsRIeKDqbrc1v/9StPo7eQLryDbbIDJ/E7XxNlJyy5fNCYhdRHyD5+hT0soL+M/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvRfSG7tqzbDSGAVuBRUQiOgjuSEnORLkvW9eivXtzI=;
 b=YR/PmqKsCfznZkA9S8o8TfHdU7aVvoSIh4bhlfDBGpwFG3BAJtQHMOH3vveCsEBw4JDpqfCqKYNIoPbEMurxzmDvinhVufMo+121NyM/rSv+ma0xYbK90zvUyU1Q/wlzWwf8XYU4QIouFE99XaBKTz4AzGp5GANhhfZKdpb6Xs6eJFMQHE228pbf1d7t17NyqCpYxURhzuMY/u1GTs7NWvwyQ5UWhTjL3IQmHvjf/gkNmoz1khEzzX5RkmnVA6KGrEEvF5HfFTo+TU/1sg0K7x1qN+EytX7G3n/RDXy3dV31yIRydQXv9C7RQbMeriNNvVFBA+lAm2ZyYpB/rWi84Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvRfSG7tqzbDSGAVuBRUQiOgjuSEnORLkvW9eivXtzI=;
 b=hpU2rMEXVFP3KuUqPny5Jsyp2AwhbSsb50tauopJayGVp5Z2QkSMpRuO7k3DZ9aHZnSO0O0/aRqlEmVns4wCqVsygVUL72p4Kuu9dvB5K6Ti0gNsbGOv00RvX5O8QhQE1CAvZGN+8Cxn7VkSyzp5bcwp28v0Q04uPS9wCzs0hzs=
Received: from DM6PR13CA0059.namprd13.prod.outlook.com (2603:10b6:5:134::36)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Mon, 14 Nov
 2022 01:42:50 +0000
Received: from CY4PEPF0000B8E9.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::32) by DM6PR13CA0059.outlook.office365.com
 (2603:10b6:5:134::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 01:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E9.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Mon, 14 Nov 2022 01:42:50 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 13 Nov
 2022 19:42:47 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/pm: fix SMU13 runpm hang due to unintentional
 workaround
Date: Mon, 14 Nov 2022 09:42:13 +0800
Message-ID: <20221114014213.1118084-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114014213.1118084-1-evan.quan@amd.com>
References: <20221114014213.1118084-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E9:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 116e2fd1-87fa-42ea-40ad-08dac5e18a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xnc/cAJ0mPRdqKyh/BImFTc6CCrJN2J4wuiOC0LsfhrGHUvA6gJty5IrdsInAGRvrNw2enSc5gu68IJMxIYLAYGUnJEOH4lsujDRlBxcJK/DJLW0llsALJ6FYpDHI/Kzv68v495HK237OBTDpD//3jbDI2F2oR8sis7K7GhtbrVZ20v87qKuF86k8kBk7HtfI3Qaaf5Lp1cyf8M5Um7GpBg+iBA3NwQaqxEGrWqV1PtAxKlrXBlhs7Q/yAuV0tpRk6hlWAYmNuWVUp2NNuyOzjJVvhGDXoco0mOy3jFu7Nd2Q4JMzkhvd6XCUK4PeU00zVJGlcrkM8dg5IaGPY1qs+Tm6sle8nVfeKXE9AaZhf9ejbEB/EMgUd4lUlmCziK6LScy9zViW7p5o5you8X+c4HoJBmzzH9r7sjf/v9q3SzS2myDLEV0CDqnrs2g8aXBTYYYm4yH0zWI5xhlUMlSyitxKfMqy/QvDzWOiMUP0IPmGygKAkkpVlA6j77sSOQ7sAvdeN8mUFvOcRrrNg0h2wqXZcQwZgSgJ83065uE0vud+ZWT7p+D7WjJF4LD+eArN1LMb58J3C2FJEAMsOPTHXvGEm7hYBku0NEI5TtXHBi2xxErEAAWhNMpCgtxA8U1Yzz1E3v5jq/qO4RrzRLb9mpMAariQmAPCToixV9DM1ZfG1xplf9OyF5eUHnoXGBrV6Yo/StGJTeAfACgkRV5uwQY4j24Op36SADNzPTZlvNppI+rFENbQryUySKWlNYKKnHZNul8X1ehbEFQSXOr1KGPbiZ3FuqzpomjBp1PrJ/IGGSw9B7Cioo6w3/y0bCZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(2906002)(36860700001)(86362001)(6666004)(40480700001)(7696005)(26005)(54906003)(316002)(40460700003)(6916009)(16526019)(47076005)(82740400003)(82310400005)(81166007)(186003)(426003)(336012)(356005)(1076003)(36756003)(2616005)(41300700001)(83380400001)(5660300002)(70586007)(70206006)(478600001)(4326008)(8676002)(44832011)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 01:42:50.0543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 116e2fd1-87fa-42ea-40ad-08dac5e18a1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Feifei Xu <FeifeiXu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The workaround designed for some specific ASICs is wrongly applied
to SMU13 ASICs. That leads to some runpm hang.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Feifei Xu <Feifei Xu@amd.com>
Change-Id: I7cbdc45e9b21eede698afc4dbe26c6306644861f
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 9492dd638aea..20e5f66f853f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1156,22 +1156,21 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	uint64_t features_supported;
 	int ret = 0;
 
-	if (adev->in_suspend && smu_is_dpm_running(smu)) {
-		dev_info(adev->dev, "dpm has been enabled\n");
-		/* this is needed specifically */
-		switch (adev->ip_versions[MP1_HWIP][0]) {
-		case IP_VERSION(11, 0, 7):
-		case IP_VERSION(11, 0, 11):
-		case IP_VERSION(11, 5, 0):
-		case IP_VERSION(11, 0, 12):
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(11, 0, 7):
+	case IP_VERSION(11, 0, 11):
+	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 0, 12):
+		if (adev->in_suspend && smu_is_dpm_running(smu)) {
+			dev_info(adev->dev, "dpm has been enabled\n");
 			ret = smu_system_features_control(smu, true);
 			if (ret)
 				dev_err(adev->dev, "Failed system features control!\n");
-			break;
-		default:
-			break;
+			return ret;
 		}
-		return ret;
+		break;
+	default:
+		break;
 	}
 
 	ret = smu_init_display_count(smu, 0);
-- 
2.34.1

