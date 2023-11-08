Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279DAC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 04:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91EC210E703;
	Wed,  8 Nov 2023 04:22:39 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA4C310E703
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 04:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IH5r6EKkwiJJ1bDLtlavcnFOcOKytb3ah9ieEsHaKcTUX2mkTJllqL1HFl+gwshmHr0EDa8oOngHvDEKGPWCRvJu56OmM31r8OoKsuctNY6hl7MlTtQzbOdkSgnldjFgF1JJliIQH7bf+mzNyTADkA/boBcE0/j9L07XZUGe+6dKXY/gJ70TJPCYMtlN2FrKDqvA8YK2ELCBB3FQ6w5i3nr1hnXLio9ruqlDsZPaS3yj9V0KTUTDs2YNdOolRgII5nnXLWMrTHa4ffhidcyaBVHop43k4+wnTSrVV299sQ2c0ueQFVEG+nsAag6LRH168uV96exL8EMe20ugD2sySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQpn76PVeuGr2mAqPiECCqyMAfjmuBAcvlpkYfm7OJg=;
 b=nfhHPQQbEECy6zl3gcM1K2uqNzCdTHq6J4tYHXMMTL+UtiOHal59H2lveDVaNJpgS5LiT1Ew4YR61PZuDEKbxqfEYRXxnBLEd2bLvSLUbhP2w24l1PomKRH59tX0gdHmJL3bYlmp0dOej1oe0uvTfkmQiAGDVQ7EyqUfPCbDIN5Je4h1gELZ6Y53cGOxNOAQQhsFDHt2CHK2qqBxeEtRdBaUsNbWPdQdHx4+bV1PdGYZ6s+4VWlzw6XJFlGR1JVi6twcgy/B0hZjOYyEaxURZM4AfEbue7FdP4dj4eBohj2FctaEYSnFIXKE4WhE0KSAjPmicwnW2Y/ufXLCm1sF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQpn76PVeuGr2mAqPiECCqyMAfjmuBAcvlpkYfm7OJg=;
 b=S2WofgJbAwHkJkzmBpGRG33OjciBR2Dbi8A/atGGxFr7FZ3oDbPvD2VMqy3aJwI2KayKP7o9ME/+qIM5QgC3n+iK1Gh0SKqttMlcKfdzedfby7b/EMPL5Z/nOtqcDHq2zzhz0hTRKLPgtpxe4dYIu5HS6AkKLNRR4yZlHuqul5I=
Received: from CH2PR05CA0003.namprd05.prod.outlook.com (2603:10b6:610::16) by
 PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 04:22:32 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::9b) by CH2PR05CA0003.outlook.office365.com
 (2603:10b6:610::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 04:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 04:22:31 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 22:22:29 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/4] drm/amd/pm: Add sysfs attribute to get pm metrics
Date: Wed, 8 Nov 2023 09:52:07 +0530
Message-ID: <20231108042207.528357-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108042207.528357-1-lijo.lazar@amd.com>
References: <20231108042207.528357-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca48369-b909-424e-f2fa-08dbe0125355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5FqzUIj44iKxkJcV+TPtwiOBo+ouRbcQIoFJiIWhHtk/VCx5Yls+7U9b6RuS1GD4k69FKyYVeZ8GK587G0+cZCIHF9LN6JEp6GhPDOky/gspDxLh5VXC8V1o+ISnBUh/bqQCoJUIovW+pbCHEfzLLLHd83KHKD1Zu+69DRnVlZJGqJ7SzU4ubVj0M+99ErYIJ6NdKWcH6RhUNogHY3Dm46TNnfketCsuAczWdO7KnLX5tsFSdad9kOjDzg46Nw47odpk6bw5pos6Vt9ziwKVfPioNpKcrxZgwzALT6RKKtcZ+ZoWyfke/5pVovMn7v/C6w2MQ+nnaJJHJmMdX5fOqGSKG7fVFAsRxMVwPYrdrq8WlkiqfEH2pdFdcotl3fKLobvMZXUAPZUlHlDX0uKPIdHEI0NPMt1W6JgwrShjdXUJpuAjGGzA4UmlA088cosOdyh3DbH2fh2bQXHNd+/FztyDmXraqcamxgJa/G47bo37lcyk36Ody9dnE1hJ+hHcNkxn1QXvAYn2SFtCWt34X0b4QZKZJgGl4oM3m+CBueGUHRhMvKL5jrXZrlMQWAMuaUEzmp6Xf+ns4gRD48FNg/aVBer7GgleqbtTnnKW7RbyQq8PQgWtrCNmZsqD/ELp61SjMK2/dQbnsJPcOj8orTugKs5gIGeaLkoZaedaG5k5XMsWuCScN344A3X2BxprdsMXJ5ihH6L6gltIgP86fZxyaXqgszlUZDQ5453XhmszpUkPDB5oif4HnnNIzluTSNsQ4KMbsMQSVVOjs/3GA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(40470700004)(46966006)(36840700001)(316002)(6916009)(70586007)(70206006)(54906003)(40480700001)(40460700003)(36756003)(1076003)(2616005)(6666004)(81166007)(356005)(26005)(336012)(426003)(7696005)(83380400001)(82740400003)(47076005)(36860700001)(86362001)(478600001)(41300700001)(5660300002)(8936002)(8676002)(4326008)(2906002)(44832011)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 04:22:31.4450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca48369-b909-424e-f2fa-08dbe0125355
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916
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
Cc: Alexander.Deucher@amd.com, kevinyang.wang@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add sysfs attribute to read power management metrics. A snapshot is
captured to the buffer when the attribute is read.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 40 ++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 8257be1b9464..b73e9b89d8f7 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1798,6 +1798,44 @@ static ssize_t amdgpu_set_apu_thermal_cap(struct device *dev,
 	return count;
 }
 
+static int amdgpu_pm_metrics_attr_update(struct amdgpu_device *adev,
+					 struct amdgpu_device_attr *attr,
+					 uint32_t mask,
+					 enum amdgpu_device_attr_states *states)
+{
+	if (amdgpu_dpm_get_pm_metrics(adev, NULL, 0) == -EOPNOTSUPP)
+		*states = ATTR_STATE_UNSUPPORTED;
+
+	return 0;
+}
+
+static ssize_t amdgpu_get_pm_metrics(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	ssize_t size = 0;
+	int ret;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	ret = pm_runtime_get_sync(ddev->dev);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
+		return ret;
+	}
+
+	size = amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
+
+	pm_runtime_mark_last_busy(ddev->dev);
+	pm_runtime_put_autosuspend(ddev->dev);
+
+	return size;
+}
+
 /**
  * DOC: gpu_metrics
  *
@@ -2095,6 +2133,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(smartshift_bias,				ATTR_FLAG_BASIC,
 			      .attr_update = ss_bias_attr_update),
 	AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RO(pm_metrics,				ATTR_FLAG_BASIC,
+			      .attr_update = amdgpu_pm_metrics_attr_update),
 };
 
 static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
-- 
2.25.1

