Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18281CA0FF3
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Sep 2023 13:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AA8B10E34B;
	Mon,  4 Sep 2023 13:10:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C2810E34B
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Sep 2023 13:10:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0IOHP63siHIISi2XyjFpVyI3h9P5VslnZYUH1yazMYOkY4doZAYv6nCM45fHURrmnTr/LcNG4flJ1o83P7rOakO4DYMr+GDwc1a+AWvj7T5J85iyxrXTioKpW/K4rZj1S4nL7UnS1hgvqR4Xqy8LYT9fNJSAMYP+UWzPPZoBKv4WYOntN9oNyz01CKRKyQdSKgT6VwvHPQ3qOSCBu+i5xfpJFvyYutnWbuYdT48GTTfTMvtqlCWJNgSypQn0WVeaVF6emPIMQ6sZxBTyyKSNeEuk3WPV4yNcMz8+7BA4jWhWGyXJ/0i2MKjs9ROJ87KpXvRg3sRvScFFSoAO4+Bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3Au14PBQDPpPZbSmCbLyy1UKQHJnGPAtdWVrSZUZHs=;
 b=ieLAQR5fGeyYZdsa2nzBRPsa8Ek32WFAyy8r7dld+diZgYpV4U81ZldJdkUo3rYjlXkn0eM7Z9gf/HhrExffR3C8TxP1nL3KlvqQbCJ8uhaFd1G5R0wKjwYd3sVidK0c9glWEcb1NzGuJi8gdBTFi7zcW2Nzp/6RbZ0MnaMgPMMcYs9a83ac2lCN64Pi9KieNVYFsPDnNuHqKxXGs5Mm+8fWrMjhBx4nyxKz5Gb75J7xAquKUMRPkRIMt7C41FhtZkSXR2Rt+Xx2ek1BlcthoFiCOFKy+pDZC2xocrG6WyTLQ7uba+osOz5c9CJNHueEy9F4cYOyY3/ct+kFxsvBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3Au14PBQDPpPZbSmCbLyy1UKQHJnGPAtdWVrSZUZHs=;
 b=aWr1jfv5W8uFzNevHI7IIGDBJ8JvwHzEJ4AcZJ7Ek5X1Xph0zHYibYeJ1NT3CZaYpwLJhvFgwqZY0HvS2RmU3IWV78wvBIyaRYxRpUhuOdeIlnviA0rUVL0+PtAle3k1aW8CDEAEtAtLgvQ1RpfO6HmzZFfXjwK4Uw2hwPhY0EQ=
Received: from CH0P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::14)
 by DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 13:10:53 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::57) by CH0P221CA0004.outlook.office365.com
 (2603:10b6:610:11c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Mon, 4 Sep 2023 13:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Mon, 4 Sep 2023 13:10:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 08:10:50 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] Documentation/amdgpu: Modify pp_dpm_*clk details
Date: Mon, 4 Sep 2023 18:40:27 +0530
Message-ID: <20230904131027.912234-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230904131027.912234-1-lijo.lazar@amd.com>
References: <20230904131027.912234-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DM6PR12MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: 510fe2b3-c6b6-4e94-9b9f-08dbad485e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IK6fW2OR3A97u3Oa7EfzjGec6HvtWt3cftZ1lFCC9TyYTUSRwH+QNPsHX8r7pzbLaAgMUtr6fGeyUJMQJUjXr3krkr1ZKuBvl9q467nPM6+OIMxntc7StDv/4ZpgTlkr8wDD3GtDEEsX9U8tjNEf6BauWLMpac/oWaM2vE5YcIvpUZTlVLnRppxeaLiorTXXDUQgN1MBSuLFGuB5j/9rFe1r9dj6xIbo/KjIPE1pArA9XV6NL9GRExpu1wheyZ3Kpg84ozE712HzVrsys9pIVyRV29lewNiL0yL9+Fh27RK2vn++gtJ/VCHu44GhF+RmJ0NSeK9OURTCW3kRGUwfr9W0/AHUg/M3scfl8xIJNYUUIFc8n2gxHPXr8y4m83CjYFv/Fst18hwNfytXZ7QnygmXzB9FOJ7aXDBEVuFFOkuaVnFeFItzNP0FyUdBVaD4Ogz985aMWdIbSMqdpdjEAVVL0GHgLwLtqj9VKyW7lpGDxzOEUYr8O7v+G1kxkeTQ90jcFKoR4Nbtgs10F9a79upTPtKN9b+It9jsz6H8wdbVrj0C6IVrfhKMydnHyJ0rGmNgUd+wG2X+1HIT9ajWDzS+ynPTBgyevLwac/JXQzfNJB+swjp0ig6qn/08VIXPnQN+ZvHXyhtd7ao2Z1ChQSqTVGW9a3ZQgTemLX75lyEWE7dEbQP2oum7ON3zlkMlruLP9YcsynRm+zyMnFA20bTrf5KMU570Npi+odIpU4BxpCGPTCt39UcuiIPaIq+azc2mVRL9U4gVRrCQXihXHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(186009)(1800799009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(41300700001)(478600001)(356005)(82740400003)(81166007)(6666004)(86362001)(2616005)(83380400001)(336012)(16526019)(26005)(1076003)(7696005)(36860700001)(426003)(40480700001)(47076005)(70206006)(70586007)(54906003)(36756003)(2906002)(316002)(6916009)(8936002)(5660300002)(8676002)(44832011)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 13:10:52.9804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 510fe2b3-c6b6-4e94-9b9f-08dbad485e12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

pp_dpm_*clk nodes also could show the frequencies when a clock is in
'sleep' state. Add documentation related to that.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 84e1af6a6ce7..3dca1aa473c8 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -983,7 +983,15 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
  * pp_dpm_fclk interface is only available for Vega20 and later ASICs.
  *
  * Reading back the files will show you the available power levels within
- * the power state and the clock information for those levels.
+ * the power state and the clock information for those levels. If deep sleep is
+ * applied to a clock, the level will be denoted by a special level 'S:'
+ * E.g.,
+ *	S: 19Mhz *
+ *	0: 615Mhz
+ *	1: 800Mhz
+ *	2: 888Mhz
+ *	3: 1000Mhz
+ *
  *
  * To manually adjust these states, first select manual using
  * power_dpm_force_performance_level.
-- 
2.25.1

