Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227D5C761AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD41910E922;
	Tue, 28 Mar 2023 15:14:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F2C10E90A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJUiIjfVpQzeuORlPS7rKpzivnpJ6jdLOzdg2I8H7zNS/Odt7teEo+TuTcgDpYFTEnv/1rP/N71BXBJ5JyiNHYv3/yKAFjK/mwC2c1JgdRhN/B7auqM3gwrww8zlVdq+xuCnEewrSOHqA8FmQ+O2etmKjbA7kpicdo6gyk2tWIThT1HQzyGWT7UeLQSmqlgi9AazWgv/5ZoGA3NHYcT3r38XJgemdjy9kvWdzKl4JmoQuvtwklVJqvYhPlN5fngT4TiVzFWTsapsLNrwHNRjxTcC0WeyLGHpObGQhap4BeOVXKG7INDHZfl9/uH1JD1+vkvJZW5XTnRUvCgaLTZNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Vd/XM8i16gSPpX6rTwuoIsrbMt/WmizPsv3bWHU/fU=;
 b=JaqG7NryGQRT1AfRplhkDG47hZndveiby96xI9XmdhCkSaiyU8Tc7n80Gv83JiI3m5edO2vErUDgGGpXygyBnk+Dmbn1lIxke6pKnHl4Wua30lBh2s20jDmYP5T+5NiH6dxV8on4ARtD7HSYhT8KOUkkVJ3ZSRa/RdYxodhkIy+I3ofPlv5W+4BQLtKm+dezaZG44EPkAsu5kUUcnoG02xascAkCozZoGFLJICOS0/GMA+j0SeM5HxR85yH5pgx6gdr6zTxOuDZCsPI+R5kW7aYGuyz1hpTWLpwQvxPpbCAxCEdt5XhOk2boGbTwPwqOxbFeShNcvHK8PRYb8XdCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Vd/XM8i16gSPpX6rTwuoIsrbMt/WmizPsv3bWHU/fU=;
 b=wqAPeNGGf1sJfCyDns+ybdgzZDp9ymSc9kioBWgWaLo0au/TeQ2V+GYyLXV0GBii1bAGqZ8WWvvwCsiDbVIJlt2QRhyGCRPmEtG9a+bIpRwMVYze+kQjiszcP4b5NyAcMJgjIZkj2lszTBBXQpor/EcDvjO5HxDcxSCn1YKZ2aI=
Received: from BL1PR13CA0073.namprd13.prod.outlook.com (2603:10b6:208:2b8::18)
 by CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 28 Mar
 2023 15:14:39 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::f1) by BL1PR13CA0073.outlook.office365.com
 (2603:10b6:208:2b8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/32] drm/amdkfd: Update sysfs node properties for multi XCC
Date: Tue, 28 Mar 2023 11:13:27 -0400
Message-ID: <20230328151344.1934291-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f68143-18d3-4c3c-5575-08db2f9f263d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SSKCALTQRb0y1jDBPY2LvkzVn0GZXR8lggLKD1N13IvoQXdE9byg8Ig5izgz9NqnBpgodHemsN6PD/3YE1+Jgpn7HjLQrcWBfL5BcQyAFEKQqCW1gtzfoOZG99VbH4Xe4epKKxwLISgIz1DzxYqNJt9DPP22gMtOQDBHFJykZdJPm532pGTZOckcyvid9Oj215VK6mGTm9K4GoQw172mbjP6dsRe4OaERfgmSqtPKFwqLSXGhTUJ8o9j1nwqtA0qBhIRf5NfOPAywEgj8r9QZYza9NmbOX5T7RthiARhgPKetqcRQEqiSQhEVfX25fp5bl0AwzVfW29jXQ6JkhEpRM0eEPyspDcCLuT6OdOb3Gp5o4xMvHmuZdJ0ZyixfGlJim0mZQZCa+aYEqNzVJ9v2OkCYDVP0Zbs3C8QAjRAjv9avsXCAhCflanTG/enNJ/eHNbVwlpiwY+WZz8iBTCaztpSb8PBY2AOm8q22ZMR/Em1UvzxtyX31/gSDJNcegZagII3EtAEkGiLYj+EwyoZR30w5vnTyUNry4P/HiRnV2ZxFTpCDUc3leJUbcS4HAp7pph6kb+7kDWS6Ff+9YueRzFl9WGCXItd3n4sS7WSULYxbDOI3KYz5QazoAyrWgJf9kvV4UcHiNInESKX7oVSxHb6Bs02Fg69nVJku3lHPFUYjPGToWe3whki6u+rxGnVM9IIkNK63zdn4yHDd2MxYFwoANGS3ZwyVb5hdII8no=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(36756003)(1076003)(336012)(316002)(54906003)(81166007)(6666004)(40460700003)(2616005)(36860700001)(47076005)(186003)(426003)(26005)(82310400005)(70586007)(40480700001)(86362001)(41300700001)(7696005)(8676002)(6916009)(4326008)(82740400003)(356005)(70206006)(478600001)(15650500001)(5660300002)(8936002)(2906002)(83380400001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:39.0447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f68143-18d3-4c3c-5575-08db2f9f263d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457
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
Cc: Amber Lin <Amber.Lin@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Felix
 Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

Update simd_count and array_count node properties to report
values multiplied by number of XCCs in the partition.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Tested-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 94af37df3ed2..6d958bf0fe90 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -468,7 +468,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 	sysfs_show_32bit_prop(buffer, offs, "cpu_cores_count",
 			      dev->node_props.cpu_cores_count);
 	sysfs_show_32bit_prop(buffer, offs, "simd_count",
-			      dev->gpu ? dev->node_props.simd_count : 0);
+			      dev->gpu ? (dev->node_props.simd_count *
+					  dev->gpu->num_xcc_per_node) : 0);
 	sysfs_show_32bit_prop(buffer, offs, "mem_banks_count",
 			      dev->node_props.mem_banks_count);
 	sysfs_show_32bit_prop(buffer, offs, "caches_count",
@@ -492,7 +493,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 	sysfs_show_32bit_prop(buffer, offs, "wave_front_size",
 			      dev->node_props.wave_front_size);
 	sysfs_show_32bit_prop(buffer, offs, "array_count",
-			      dev->node_props.array_count);
+			      dev->gpu ? (dev->node_props.array_count *
+					  dev->gpu->num_xcc_per_node) : 0);
 	sysfs_show_32bit_prop(buffer, offs, "simd_arrays_per_engine",
 			      dev->node_props.simd_arrays_per_engine);
 	sysfs_show_32bit_prop(buffer, offs, "cu_per_simd_array",
-- 
2.39.2

