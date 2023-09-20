Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28013CE79BE
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 10:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3AAD10E478;
	Wed, 20 Sep 2023 10:40:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96BFF10E16D
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 10:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NClF5IFrI+BOp0Dv7Iz/eWa6c3xfeVvx9aS7qcjL2MxAXgGTKKvqeC0VA+4C4vZSsVEUPVpW8if2o9mygQPDMGMxmh73chNgiUcAj7lMyUtd7Nb6VQAGf4wRKRv0REq22JEnkOb488/6OWYlSWgrY5nvH2/ySZix0mB79T3SfCgBdX0qa6Ppl56fEAg07DCZS1f1Xkp6zpsn9hDYxEzwk5tW4sqOCAXg1fB1q8i7HV1vZm/kJ525zi9qzVWnEkuwesaNeR2LPQDxyu870NHRhwAu6SKUKqs/9CfRtn0557LkZMunHzh0dwcnEnp7rHKw0jKABnlHrkIsgRhYbsls9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxzGqONBNpxwZx8SeJxnWr44uhMI2GAG1IRSabIRlI0=;
 b=iPEQIbkDDLNU8GNRGWdM5Rz8gl4X9yuOp1ZBbCa8NZyzB9gX9QIlFzPRyuA3ZMlxhlLSGpGhyD6W5K06EDo/gFO3LVsRXPh8wzJXHvVC55zdS1leuyHFD65D5tTBHe+UC2LMTpaK7Ga3t5UdiJfHSzlnpWh4+o6DVYuaD6i7KwqZnFhyw6vF1Bodkp1OiR730Hqq4C0fqdM3Oq/1Iat1BqGvAeL3WE0BPFjZnrxBnQsPHDewgEyoHe6Yi1O3/pRLlRUQxAfLXEMR5Ad35q1aIA6TjbAfSmR4IHogcnHt/2CEKEGGYH50kZXX5jMlz0rCyoIswah2+qDRubcAz6GyVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxzGqONBNpxwZx8SeJxnWr44uhMI2GAG1IRSabIRlI0=;
 b=ubaMNRERbpOgPTniFcQO9Sgqy1TQYif/bg8ALJPC37ntLTqOnKjJBIqSw0zn7MNsjYstlwHv7JOqMukOw/5X4Jwrw4qT2DzK7Nkv8eJB9yG48oewLFttL4w29R+QUO/0y0AMpS/pZ7b3BZHZk7zKhg2Nwg4OrgfnJYdhoFj0R7s=
Received: from MW4PR04CA0224.namprd04.prod.outlook.com (2603:10b6:303:87::19)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 10:40:47 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::13) by MW4PR04CA0224.outlook.office365.com
 (2603:10b6:303:87::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 10:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Wed, 20 Sep 2023 10:40:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 05:40:44 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: Add GC v9.4.3 thermal limits to hwmon
Date: Wed, 20 Sep 2023 16:10:27 +0530
Message-ID: <20230920104027.1295775-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230920104027.1295775-1-lijo.lazar@amd.com>
References: <20230920104027.1295775-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb5c63e-32de-4b9a-2f2f-08dbb9c60cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfgv4LtxHX6XOzCyYAXtsrIP+7gTT0dk75iM9wyg1l0TKan/TknlhbZ5jwc80nPH1PJninen5sRTFPhVjJoWx60QCWJAbIhB4DCL1xRlW4Gmp8tYuEGbd/1/GM9J2MFkL+jp7piGczZbWGZ/Ibb6w85BJ+Ke/KIWE8hvQWqPhNlzBmU4JQpACdwZ6JD03mkk9H635Iw77tk12zvjnw+E2NBw3eomeaedMxKVXFRn1+OyGkxbk8tN1Y5ZT6sp8NbYH7vXh4AAe//o1bxyykqfoiPm/x+GuGtP0D2MF0c9Kl6elIhZbQ0yR1yULgOgET131xag6t1x9oUf+WEkJol3zQbqo0Q2J0avUyKzQ/3Uiqv0gtfA4ge2WyQjK8XL29Nf+AU9Mr9W71MkJcku3qI/JWg5rl6udSNuSS3Mb5ZxxfclGPLtHdOuOiJuPknMV7HHGVX2ElLgN20KcOvHDeRwvDJmzOccWayhfVwbNqDNI1Scs/jRe1Ga6O5Ti+ebzJw6IqZBWDFgxOii93SdDpg+22AOKLcIs00SjS0tAz1DeiFvzMD1n7gem77sVYi9V4mq8YUg9M8KHvrvbWfF2hKDhLAVr9tmSe5yT3nr+Dpu9/IpS2ydiux6nRosm0pW/AZo6DWnchLU+XVhiL7To/jcJ+eDIuiH9ZUvP2VTRTcoEXVM9hfLXphqzgniEkkn+WO9fRfjX2iIopTSmO1DtgiO8SPeJdCCRo9x6zLCI7vLFwXzYeOBDPP0EbbQ/h2a13GE7DYWR9QjfoAB4ZmNYR+stg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(70586007)(54906003)(6916009)(478600001)(316002)(86362001)(6666004)(26005)(2616005)(1076003)(426003)(336012)(7696005)(16526019)(2906002)(8676002)(40480700001)(8936002)(44832011)(41300700001)(5660300002)(4326008)(81166007)(356005)(83380400001)(47076005)(82740400003)(36860700001)(36756003)(70206006)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 10:40:47.3094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb5c63e-32de-4b9a-2f2f-08dbb9c60cee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133
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

Publish max operating temperature of SOC and memory as temp*_emergency
nodes in hwmon. temp*_crit will show the throttle temperature limits.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 2807f3bd9ebe..5d84cdcd7c0e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3353,15 +3353,20 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		return 0;
 
 	/* hotspot temperature for gc 9,4,3*/
-	if ((gc_ver == IP_VERSION(9, 4, 3)) &&
-	    (attr == &sensor_dev_attr_temp1_input.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp1_label.dev_attr.attr))
-		return 0;
+	if (gc_ver == IP_VERSION(9, 4, 3)) {
+		if (attr == &sensor_dev_attr_temp1_input.dev_attr.attr ||
+		    attr == &sensor_dev_attr_temp1_emergency.dev_attr.attr ||
+		    attr == &sensor_dev_attr_temp1_label.dev_attr.attr)
+			return 0;
+
+		if (attr == &sensor_dev_attr_temp2_emergency.dev_attr.attr ||
+		    attr == &sensor_dev_attr_temp3_emergency.dev_attr.attr)
+			return attr->mode;
+	}
 
 	/* only SOC15 dGPUs support hotspot and mem temperatures */
-	if (((adev->flags & AMD_IS_APU) || gc_ver < IP_VERSION(9, 0, 0) ||
-	    (gc_ver == IP_VERSION(9, 4, 3))) &&
-	     (attr == &sensor_dev_attr_temp2_crit_hyst.dev_attr.attr ||
+	if (((adev->flags & AMD_IS_APU) || gc_ver < IP_VERSION(9, 0, 0)) &&
+	    (attr == &sensor_dev_attr_temp2_crit_hyst.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp3_crit_hyst.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp1_emergency.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp2_emergency.dev_attr.attr ||
-- 
2.25.1

