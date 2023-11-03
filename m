Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC07CC001B5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F056910E9CF;
	Fri,  3 Nov 2023 13:12:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EB8010E9C8
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/T+KP2fu7k2kddYYqzokTlApV1aO/mGA49DYyMXo+2mfF3PWHQTwpsnGyuKiAzfzgc9BnrDMGbuWr86U3SvAnWiZYw3VygyQJtjqd27C9Yj86t9iLCzdlW/m1CuYryHYZU6yBZmZB/irOLgJsYBv4gxTTNMfNkC7v3ay3hmiFMf1kzT1HoN59Kt2T3svgkp42pcCHElNSzj0eIPZ2ZwqtHeO4mVGW6fXTf+BOOlkDv69LyFuj3BrwqPRIwEcAj6SRvx+WO4Dg0hkfYzhypG/siXEWPeXO1FqBdtPPPH1oOve5g34ZnJvwflRA19O1jTCKz6ulh4I+W6SCBZWfLpWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1ztcKmDsbbCEVGM2Md5EzCyTPmMH30qvnT2vcKPCFE=;
 b=G2deiDreKa9IDqzR3quh3z2zFKHqVrOUNXhh61nCi4jIa6fWJhdFfxYob9OxuWSLKC/KqcuSq7cZPTIisFzW8o6IfNi2miHkMGV96Gcx0rn8BH/U3uSyekwiyh4cou4zUgDICRA4cd7OsI0QIKVDwPfTjxwU34S6iFIFe/sCfDODUiwNVuFaYPVzTk7K6kGgz60RZD+rbRfXx1ZVzJ0TB8MwYFcoSFQ8m56TSO93nU6DXD007lPveftk5C9YtzULcldv3orHzQ36qA7GcFEh/KJt1cpVvGK01HHSDQ8b46k4OEMLzyYuCmoOdbYlLXs2V6fsYWmQAamdTGEpw3OUZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1ztcKmDsbbCEVGM2Md5EzCyTPmMH30qvnT2vcKPCFE=;
 b=McQ2rQGwA9M4ZJnfscHFkAGzVpETTeBIS+gBGZ6+0vMhKSjSt9l623HS6rLpcNwDH2Og0I/b6mEIuo30q0D5HxbUL9ufhwwZcrYNoqwxE2RSwPgRXbUOOYdcxlBiKpHmGbzqGQz+88KEVm888D/EvQGeODdf/2sLELvKQR6xaWA=
Received: from DS7PR03CA0091.namprd03.prod.outlook.com (2603:10b6:5:3b7::6) by
 CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19; Fri, 3 Nov 2023 13:12:10 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::fb) by DS7PR03CA0091.outlook.office365.com
 (2603:10b6:5:3b7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:10 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:07 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/24] drm/amdkfd: enable pc sampling stop
Date: Fri, 3 Nov 2023 09:11:34 -0400
Message-ID: <20231103131139.766920-20-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: b7743db1-9e3b-4f5b-ca0b-08dbdc6e7cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTOZEe6Dtsd/QXB8INM0KwPSmLrMOLs/CLgIfOtBDAzfqLdwqrztyYOh/Ra2g2yECPgU0H+SbxDiEsJDqUuVQ7QDSH1sZ1yD6YlQCGh/H90dHzn/a4uIlrljW57Kh/+Xk6eR0+iMb+AREOAPchUZSDMNZsBm1iAVHxy0NUNWZ0nl7QGAgGQNgrWTMY+5BKU6rAFDA8EhrLEm7pK63FNfrKFxFnwe8cpLqexVTBgJ/t4LYlBaAvEMg75dzbnNKqwj1j3xagdbKKpcOWkCUYKd2nI9u2OgQrQYGzeUOVqiAU1EkHeiMjuCkTHBFUXfq8f3M9azh3c0omvlzFFLuSWxcVnPCFyj8gsGJZchlbuW71IxI+8q3NeMXq7MGTuEBwD7ijoJNRZexoV/z6aXX/Rumn+vBENhnVdCL1IBjq8czIFbBrFaBqxwEyHAb1TuyjVnmKX8zoD+SiWpNIrfTfVN0phyZyGtE6aooFMOyL3mV19ordBfvd1XSLB0p83m/gE55Ms3wS1alcSwLef4IL11LTwKdhi8FqBl+rMcp+HR5jWzNSsDPCGgEuWwclH3jmI/peonZrZlw2OcA5xffy3JUlICz/YMADM/z5wRUSCU9DgveFoOrK/NDX2ILXCOXT08ZlXh9SK542lcuO9IZWRVZL8XuXzaDDCaRZVGuaDvjbxHtfJ57Zn5rytrAkQClZ3tTbfhvj3QX8KcuERnwF8VHpW0nysQM9TR+dpdErbEsbcY8unv0yshJ24uPVaCszX0lqCri15/AAx2usMdb05HxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(2906002)(41300700001)(40480700001)(4326008)(5660300002)(8936002)(40460700003)(16526019)(26005)(2616005)(83380400001)(47076005)(1076003)(81166007)(426003)(8676002)(356005)(336012)(7696005)(54906003)(316002)(6666004)(70206006)(36756003)(6916009)(70586007)(478600001)(82740400003)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:10.0141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7743db1-9e3b-4f5b-ca0b-08dbdc6e7cca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable pc sampling stop.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 28 +++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  2 ++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 33d003ca0093..2c4ac5b4cc4b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -108,10 +108,32 @@ static int kfd_pc_sample_start(struct kfd_process_device *pdd,
 	return 0;
 }
 
-static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
+static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
+					struct pc_sampling_entry *pcs_entry)
 {
-	return -EINVAL;
+	bool pc_sampling_stop = false;
+
+	pcs_entry->enabled = false;
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+	pdd->dev->pcs_data.hosttrap_entry.base.active_count--;
+	if (!pdd->dev->pcs_data.hosttrap_entry.base.active_count) {
+		WRITE_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable, true);
+		pc_sampling_stop = true;
+	}
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
 
+	if (pc_sampling_stop) {
+		kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
+			pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
+
+		mutex_lock(&pdd->dev->pcs_data.mutex);
+		pdd->dev->pcs_data.hosttrap_entry.base.target_simd = 0;
+		pdd->dev->pcs_data.hosttrap_entry.base.target_wave_slot = 0;
+		WRITE_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable, false);
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+	}
+
+	return 0;
 }
 
 static int kfd_pc_sample_create(struct kfd_process_device *pdd,
@@ -251,7 +273,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 		if (!pcs_entry->enabled)
 			return -EALREADY;
 		else
-			return kfd_pc_sample_stop(pdd);
+			return kfd_pc_sample_stop(pdd, pcs_entry);
 	}
 
 	return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 613910e0d440..badaa4d68cc4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -259,6 +259,8 @@ struct kfd_dev;
 struct kfd_dev_pc_sampling_data {
 	uint32_t use_count;         /* Num of PC sampling sessions */
 	uint32_t active_count;      /* Num of active sessions */
+	uint32_t target_simd;       /* target simd for trap */
+	uint32_t target_wave_slot;  /* target wave slot for trap */
 	bool stop_enable;           /* pc sampling stop in process */
 	struct idr pc_sampling_idr;
 	struct kfd_pc_sample_info pc_sample_info;
-- 
2.25.1

