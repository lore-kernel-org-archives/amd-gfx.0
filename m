Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C3FC7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B865B10E3FB;
	Tue,  9 May 2023 22:07:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F1E410E3F8
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWGpIHrUJiN5V2ErFq5IVaaPhcqn9MJbeerOjHvkPE7/nWnGye+uxkJnd4Qdmhti02me9kNjEwpc5b9ZkYDtXV/XRExYzOb8Ei65snRr+bmTiJT1KCXbp7hc+Bn3IpCqpudzcQPoQF3Sxaylm20cynDuywm33RRJwqiRwbfxtDwmLGZCC3D8BjOdfCkdDAe/GVDDZoH82F84JTyah4K/lxjIQF3iZTN0pse/PXuM8FLdukEXtviOz1IfY3ejuJyNfFN6coDnppAGL698r4VIxNp+z8LfLyhBmYJFdCc7/Evw/RHy6sj6NA6HP7noh3VLz/ysUgo2/26dhsiSH6hDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YKo/ZTs4V/+yVXVS4AFFkLPdhjHpmz9z61fSTGhl6w=;
 b=ma7yN++uEWQ1zkP+GTD5+lFGOWC4VxwN9S4Q3+MPiuVe/hQ0B2fwcntB8i8UpuVjNotMCosCJ4qXCtVtIKQrXKxAbji8j6ej+dd+0j9fX8EEcn+TCnuFI9jzGt7kSDgkyL1vtnk1JLl0SH4fDqr9s7qUm8dRLD6WSFjWkMs2RZYgO+9vNwbL/PrwWE7eMRxGApAW48ptILbqyNp9c3ejpsuxI3EbARM947aCcSdzBEVittzC/m8pXfNHLmPzN6VUINMJrw7bPSzyO7IfqJ6uUhoP1rItpZti8DFJ746855KBr8R3GxzK6NDWX2QTk5xcuMW4zAE0dGPU2LO/Moku4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YKo/ZTs4V/+yVXVS4AFFkLPdhjHpmz9z61fSTGhl6w=;
 b=c6XGQVTQU2SjX+8ZSXDw5cm/yyoYxsqtlNWjqUQpQktLfXqsPF3HpCrP9QH5lpw5GJ2Dt+8Y7HphJO+9b9qMCON2MOXDXYHgH/jjDlzSguqHizqi9mXjG9UjPcOZMX3w05UEjTBmfUxQzJKfbY5Yeg4FNTLg8QAZx0aJKR+J1cA=
Received: from BN9PR03CA0425.namprd03.prod.outlook.com (2603:10b6:408:113::10)
 by BL1PR12MB5189.namprd12.prod.outlook.com (2603:10b6:208:308::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:07:31 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::d3) by BN9PR03CA0425.outlook.office365.com
 (2603:10b6:408:113::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:07:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:07:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amd/pm: Expose mem temperature for GC version 9.4.3
Date: Tue, 9 May 2023 18:07:10 -0400
Message-ID: <20230509220714.475369-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220714.475369-1-alexander.deucher@amd.com>
References: <20230509220714.475369-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|BL1PR12MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f0b098-b8a3-4a44-ec1a-08db50d9c91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kh9F4kjAQTB4Ja/nzxHME8Bm+L9IhbkEQAFIE/nKgkkFhCkxF45KHu6Q5OJoCcMEPYsWXdLuJ+aj5Awr9FP45Sc25lkSK2YWnHcH1m84YH/5MdAQLl9dxphgzAtfgv/tDuDEFeUTuzkdgVuaAa9/SpxJl09m+3txTX7QQEEgDChJioWOvsC1ahW0Zzp+BIMirOvVJZwIr3kn0e4VGIHqzbBMhQxz8ORyybTcbQIFji6Mk56qUOV2PcJkKsQMHB9CtmSJRGDlddHnOY4h6lkpU4k/LsNqUbcQCgOAk2dMYMwvcCscfOeG1qh3f37AbEB6BjRv6kFNcGsEX9jqAm5Sd8xuqiaO7T87TjQXKyfX5c+So3qEPTTZqjqCRlZiCMP5e/Mzwx9cBgdpl/UwNmBf0OnbzMQ9BgO26IxugfgrKdrOt5iLk19g4siFwvfOKa66tkS7MtqJpL3qYidIB0kD2j7bEPEK6Hb9LmoAkWp01JusQ+2JSYO6p+yuQie47qK0DtxP7V0B/AXE4kgban0/lr2IE7Jm4Fhyd2rVjidQ4zFsa2FMZAhd1Oj3QDQGO5uYO0XNyeCawVJB/O8f9Exz8bHZQowvV5KHfXAa6Kkk6fbK1+oIvrfl2sJH/4i1sXAd7OhwgPOYhNx9NRWCF0/aFCNMwty7iOnx4Ewt4EZ9nBd1shw0AYWlillWOiQRAH8neo8giYX3Otsenpnrjb4fwyXkMC17ySxynXZLTxcPIqs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(70206006)(70586007)(478600001)(54906003)(356005)(82740400003)(81166007)(6916009)(36860700001)(4326008)(316002)(47076005)(41300700001)(83380400001)(7696005)(426003)(336012)(6666004)(82310400005)(2616005)(40460700003)(86362001)(8936002)(5660300002)(8676002)(40480700001)(26005)(1076003)(2906002)(186003)(16526019)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:07:31.4854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f0b098-b8a3-4a44-ec1a-08db50d9c91a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5189
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Asad Kamal <asad.kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Asad Kamal <asad.kamal@amd.com>

Add mem temperature as part of hw mon attributes for GC version 9.4.3

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 385d83eb8706..40100b77b2d9 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3449,10 +3449,12 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	if (((adev->flags & AMD_IS_APU) || gc_ver < IP_VERSION(9, 0, 0)) &&
 	    (gc_ver != IP_VERSION(9, 4, 3)) &&
 	    (attr == &sensor_dev_attr_temp2_input.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp2_label.dev_attr.attr))
+	     attr == &sensor_dev_attr_temp2_label.dev_attr.attr ||
+	     attr == &sensor_dev_attr_temp3_input.dev_attr.attr ||
+	     attr == &sensor_dev_attr_temp3_label.dev_attr.attr))
 		return 0;
 
-	/* Only hotspot temperature for gc 9,4,3*/
+	/* hotspot temperature for gc 9,4,3*/
 	if ((gc_ver == IP_VERSION(9, 4, 3)) &&
 	    (attr == &sensor_dev_attr_temp1_input.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp1_label.dev_attr.attr))
@@ -3467,9 +3469,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	     attr == &sensor_dev_attr_temp3_crit_hyst.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp1_emergency.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp2_emergency.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp3_emergency.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp3_input.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp3_label.dev_attr.attr))
+	     attr == &sensor_dev_attr_temp3_emergency.dev_attr.attr))
 		return 0;
 
 	/* only Vangogh has fast PPT limit and power labels */
-- 
2.40.1

