Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E218C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 02:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD1D66E0D4;
	Wed,  8 Dec 2021 02:55:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290F26E0D4
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 02:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bc8bDxU6bEzcoRZAbQm1egrkygfGyUKoErLudtH1tiLFoFkeAKjyRK5Bd81WNB8ChmC4Ty0bVlGNoaJmxSkKHRzrXLGBQ/+AbB9+Fgk5XPeA3vsk0Ytv4fvsJdt3LWMtg3yA/UObmGYgkS1D47W7e1N1PluXtB9quZgGJ7nJAs2Uom0m4eqj2Mnt5/Xctaws0/U4SJ11irTZ7I2mfdqJg+t8sRYnI0A5u3C2QVvAj8/eukzAuLa5kGEpPNYJvRBDTEXX/M8PN7zU4ng4PgJmCSVwbVSD4WLSkpOiMQ/rwupjTyiSZ6p4ZOhjq0KL4UVoZupTZroxajQzxqadnjNPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKpKn8ei5ugPBSwlO5b3JsJPeO3r7B5fsmw2LEc5/KQ=;
 b=NAlArkh3MJMteVI1KYkENbzCwuDlvaCpEwJthBfGs48zmBHPTqB46u8SeLXQ8EiqYJa2FWs8efECDY1yP8kGD0jcq+HONUMMmeCMe7GcGiGshjXGvl+E+lbPL44Yg6YTDcBIuJ/ZaON1FoGtxqjYBhVGpSrp1+nFh/OE9wvcQQS5E51rdUiB6Sv9vvECzSoYbBb4q7uajTYBhMHtv1kv7kocUsFeFJvnmzpEfXmYsIxJls1YWYkmHZJNoLKpREwhf3TRErPMAZmKLRH2od/fIt0W1AaAzdYG+zt1B4Y4ThsfJIRj1+HPQzseQPHge5cZpr+jbTsV8Kmx8AuVwFedwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKpKn8ei5ugPBSwlO5b3JsJPeO3r7B5fsmw2LEc5/KQ=;
 b=e34QL2qYYXzKE4q6Q6GrgaNbjOHzXzxhixP28QEoxV6TsrnqchHu4JJjUZI3THv+5CiJyQ3mpmZEtmsk5pioOQTY3mKC9Hy6XAgRAm2RyGbWpUHLMNOnvk/AnboHgtzkOKLvXZ6m/KAvbb/+fmR0WhvQu6HQAtHtcu5WfV87N+0=
Received: from DM6PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:100::22)
 by BN8PR12MB2914.namprd12.prod.outlook.com (2603:10b6:408:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 02:55:08 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::1c) by DM6PR03CA0045.outlook.office365.com
 (2603:10b6:5:100::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Wed, 8 Dec 2021 02:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 02:55:08 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 20:55:06 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: wrap those atombios APIs used by SI under
 CONFIG_DRM_AMDGPU_SI
Date: Wed, 8 Dec 2021 10:54:49 +0800
Message-ID: <20211208025450.1814289-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fda0355-4b0e-4064-a7ea-08d9b9f62544
X-MS-TrafficTypeDiagnostic: BN8PR12MB2914:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2914C3F178BA54AC1AB5B22CE46F9@BN8PR12MB2914.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Om+d3PLaANfsIkabc6M9G1/zJkiCFhHFhxfDIU/Y2g3H3Bzdut+iyvwZp3LNLwXt6G3YLmcYsFBAwgCxo7hot66ZmHc5pNPu0bHzPjksN9+sKZ95vEx4lBtLsZ822SsmNPQDV+/SfFFzPJ05inXyUxTVURj1NWf9/kU2Cm27FQsAS2yO/hzrjYY9QjcxTmxBEUK6ILKSa3aojaOWcIJuYFltHhPUO5t2lBNBqOpec8Wn4sK+x2BwYawglLIuLuC5eUnd1lHZqaEyXpKLLi1iaxncZdUQIjmNvB4V6LawCRj1uUXSY4LYF7P1pmH3Dp4HGcw63WEAW/CvOIWRGL5eVgFIA4N68i/BKwRcMkwVEX91D9v3RyStmVZZKplcPqOzr2IHQf7W+whfHXnas4lhD5PMb5zfFxXPK+D8d4lylkYEL+wcDOjEcwymyKDpDR6xwXQcraE2CQ9g6S/YdvZhb+Ca/AHgPMrpAg3/ZlbXcN7HUFYqxJ1qCRHBI7nQHNXVg5npodFcgVjtQaCOxUJxuNfUDHEh2fCIAIdw7HZmGCVL5ikXuomTYDk0Qji+lTEzQS6K5SeM2HB+AcSqunJcR5Zzl45DlOil0KlDLERJdG+sOwgToyzRfK4mBBy0BNdh9LVn7C+nP0fNoACO7Li4rbkpH7DNLstyBOFLQnDE7VxiHKltreQCN2whVzIhiF3wtY7Txq63g8EdaianVZ1gxgY9S/yEnDEJ50IdhGod+BzQInMUSfWKf4r2qNL/jxqXMaWmPHYAX2ij+/yimZt9Yhajtztb6ek7/nmTxmavzak=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(86362001)(508600001)(5660300002)(44832011)(47076005)(26005)(8676002)(70586007)(6916009)(186003)(70206006)(16526019)(36756003)(336012)(2616005)(6666004)(426003)(82310400004)(8936002)(1076003)(2906002)(7696005)(54906003)(36860700001)(4326008)(40460700001)(356005)(81166007)(83380400001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 02:55:08.7204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fda0355-4b0e-4064-a7ea-08d9b9f62544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2914
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to compile them on CONFIG_DRM_AMDGPU_SI disabled.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I8e4baeb2abb0925fa1e37ff9e8e745cdfe9eaf75
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h | 22 +++++++++++---------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 12a6b1c99c93..9ba4817a9148 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1083,6 +1083,7 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 	return 0;
 }
 
+#ifdef CONFIG_DRM_AMDGPU_SI
 int amdgpu_atombios_get_memory_pll_dividers(struct amdgpu_device *adev,
 					    u32 clock,
 					    bool strobe_mode,
@@ -1503,6 +1504,7 @@ int amdgpu_atombios_init_mc_reg_table(struct amdgpu_device *adev,
 	}
 	return -EINVAL;
 }
+#endif
 
 bool amdgpu_atombios_has_gpu_virtualization_table(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
index 27e74b1fc260..4153d520e2a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
@@ -160,6 +160,7 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 				       bool strobe_mode,
 				       struct atom_clock_dividers *dividers);
 
+#ifdef CONFIG_DRM_AMDGPU_SI
 int amdgpu_atombios_get_memory_pll_dividers(struct amdgpu_device *adev,
 					    u32 clock,
 					    bool strobe_mode,
@@ -179,6 +180,17 @@ int amdgpu_atombios_get_voltage_table(struct amdgpu_device *adev,
 int amdgpu_atombios_init_mc_reg_table(struct amdgpu_device *adev,
 				      u8 module_index,
 				      struct atom_mc_reg_table *reg_table);
+int amdgpu_atombios_get_max_vddc(struct amdgpu_device *adev, u8 voltage_type,
+			     u16 voltage_id, u16 *voltage);
+int amdgpu_atombios_get_leakage_vddc_based_on_leakage_idx(struct amdgpu_device *adev,
+						      u16 *voltage,
+						      u16 leakage_idx);
+void amdgpu_atombios_get_default_voltages(struct amdgpu_device *adev,
+					  u16 *vddc, u16 *vddci, u16 *mvdd);
+int amdgpu_atombios_get_svi2_info(struct amdgpu_device *adev,
+			      u8 voltage_type,
+			      u8 *svd_gpio_id, u8 *svc_gpio_id);
+#endif
 
 bool amdgpu_atombios_has_gpu_virtualization_table(struct amdgpu_device *adev);
 
@@ -190,21 +202,11 @@ void amdgpu_atombios_scratch_regs_set_backlight_level(struct amdgpu_device *adev
 bool amdgpu_atombios_scratch_need_asic_init(struct amdgpu_device *adev);
 
 void amdgpu_atombios_copy_swap(u8 *dst, u8 *src, u8 num_bytes, bool to_le);
-int amdgpu_atombios_get_max_vddc(struct amdgpu_device *adev, u8 voltage_type,
-			     u16 voltage_id, u16 *voltage);
-int amdgpu_atombios_get_leakage_vddc_based_on_leakage_idx(struct amdgpu_device *adev,
-						      u16 *voltage,
-						      u16 leakage_idx);
-void amdgpu_atombios_get_default_voltages(struct amdgpu_device *adev,
-					  u16 *vddc, u16 *vddci, u16 *mvdd);
 int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 				       u8 clock_type,
 				       u32 clock,
 				       bool strobe_mode,
 				       struct atom_clock_dividers *dividers);
-int amdgpu_atombios_get_svi2_info(struct amdgpu_device *adev,
-			      u8 voltage_type,
-			      u8 *svd_gpio_id, u8 *svc_gpio_id);
 
 int amdgpu_atombios_get_data_table(struct amdgpu_device *adev,
 				   uint32_t table,
-- 
2.29.0

