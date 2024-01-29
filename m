Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B591C47422
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 09:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA07810FA5A;
	Mon, 29 Jan 2024 09:07:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45DE410F6A1
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 09:07:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/XRWQagIH2qGO0o9e/3Yz5dzoxZQvQ8VIY8sKs2VRvpizQ4ig22wyoPcF6F8tcdXIunXjkK3k60g4yS22OLQlRIYvouebA331M5QehIBitFFxXrFKnOm7wlRttvlRX+1rmPuDxiXso7e2mxGWVVpR2IUp4PqLcBxuFhcsknfiBL6fIPIMXVyyYEOhul1FJ5jlC8bWe9UVk+ty+6CGhNaO1quGyJwYbpLs4mh5PXEMHsss48VBjNlxUWj/SQYOHPPdq78aJgUWQw8Mfq2NcuQjT5YA6r+2pZEYidHMWXDvkyKt6KBa92VjGE86QLhHY3b9NkpHuNIZfl0wjlBH662Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqe1OwDpw170pjRjzUxYxg1P34PuuClNEw7DyDRnGQw=;
 b=Z+Zl8D7A8Zcp+11Aao2TXt3NhYL02Q9p8fOFEugEoGVf2te1VIydrP23E7651WbMcqJLYlbvPRSutdk9KOo8YosQ87A3cLpgfntt9sijliM6WpoMjNqwoV9HKmKiKs3DH2KSKqTQIr+46KsQX6kw1ocyizayEsKWSV6+4/8G7niBibvveC5O1M5T9tsxOE6CK0ocq1NH+OilsjW/O07weNPxjmqahDXBg8vUWJWFWq3FQXbKQfPmPqKLGS1dGB70i5VuTRFz4vt1AoLV1L5qEHpapfNRTvy3SZcLrdZ1Ch0hHi4v8memCCGS9HhpGXFt8uCIaPmxuw+bDp2pKtXf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqe1OwDpw170pjRjzUxYxg1P34PuuClNEw7DyDRnGQw=;
 b=kMs47YOS3H61iKL7YS+SrjeYBn9kQlYwmK7cBaG7IkKMY8MjwuMLrwmy+j22Q7OBbwF5+sev3jdHsaffIH6ixPPArNly/Qh28L6QgGDfsVoWgFe/+5QO1Jr31sVtLDwk8eZHqdlbGxFRdcvEt1iUGjw/0Sm0BwP9bZN1Xl0rbzE=
Received: from DM6PR12CA0003.namprd12.prod.outlook.com (2603:10b6:5:1c0::16)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 09:07:27 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:1c0:cafe::f6) by DM6PR12CA0003.outlook.office365.com
 (2603:10b6:5:1c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 09:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 09:07:27 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 03:07:21 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove golden setting for gfx 11.5.0
Date: Mon, 29 Jan 2024 17:06:11 +0800
Message-ID: <20240129090611.2716545-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ca5c59-1bb5-4918-87ba-08dc20a9b72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sAao4/WP8gfI8mJmv7MykgHN1f0eicLD3ldlRawvNaLPKwdu4yR24y5JWoPUAtqgXssLdyxdt2q4HTiE7jxrt1OnQ0/Jt5Rm3IkkGcJbzXXPZWKcpSEi+CUKUgJlRmMQybKGEiUdbnzDnrYoiQcBlCsUEh/ej/lsyO0h6IzIC/Wbcg07gUg8NzBQW/urJ8t0ycGFtCcxhjXohxfHFZUEf9hNa6/VicuxgVtwmLyVTtgixifImQ623XRebRm62CponG/oNzcq2Wvu31eiXKI3zFxZKR+1evvJxBF9wHgS1gHCrQic6MgdRhmNPSA1TykfOpGtriHf7I/jzDAOKQquc3oYsgjC3d3YDf9yzIPEXEpdpCRWXiSds5qF3CoFcsEKfaPhyXjMx8Woww2oSVj7K+YAQizA4buZJJLP1UaW3xalPoYo2ftgTNb1CC2u7Adzo5dg1G8yOjP60HqQyz6Idjkk/KTg76wlMOUuqRhRq3guTcLAru0NWpjeADrtsjdLkPbYEgm06Ur6jBj+G8/h8eku0vzfem2Rcg48OSTq22fzYs4xos7U2tsDlbuoFAvsk0aKf8XzHcv0dbs8jjJylHXsGsUuNkFZi5INBVHSiH/JiDI02cjJh4i0al3m57nijvShvF1Ly0CESfm1jcV/YK7D5BG0EB/Xp/dE4K/C8awteMZWSKDTAjpmVZVp+OICqDm/58zQlxmYKtAOoDp86dFfPV5lEf9A20Klf3KvWhz2ah4gnYYpauR1geTrlT1VY4QIic+xe1ZyoFn+c+xIDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(36840700001)(40470700004)(46966006)(41300700001)(16526019)(2616005)(336012)(426003)(1076003)(26005)(40460700003)(40480700001)(36860700001)(316002)(54906003)(36756003)(6916009)(47076005)(478600001)(7696005)(83380400001)(6666004)(82740400003)(81166007)(356005)(5660300002)(2906002)(70206006)(70586007)(86362001)(8676002)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 09:07:27.3828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ca5c59-1bb5-4918-87ba-08dc20a9b72e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Lang.Yu@amd.com,
 christian.koenig@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to set golden settings in driver from gfx 11.5.0 onwards

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 32 ++------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index c1e000010760..4e99af904e04 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -90,10 +90,6 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_rlc.bin");
 
-static const struct soc15_reg_golden golden_settings_gc_11_0[] = {
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL, 0x20000000, 0x20000000)
-};
-
 static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =
 {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regCGTT_GS_NGG_CLK_CTRL, 0x9fff8fff, 0x00000010),
@@ -104,24 +100,8 @@ static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_SC_ENHANCE_3, 0xfffffffd, 0x00000008),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_SC_VRS_SURFACE_CNTL_1, 0xfff891ff, 0x55480100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL_AUX, 0xf7f7ffff, 0x01030000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xfcffffff, 0x0000000a)
-};
-
-static const struct soc15_reg_golden golden_settings_gc_11_5_0[] = {
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regDB_DEBUG5, 0xffffffff, 0x00000800),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regGB_ADDR_CONFIG, 0x0c1807ff, 0x00000242),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xfffffff3),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xfffffff3),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL, 0xffffffff, 0xf37fff3f),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL3, 0xfffffffb, 0x00f40188),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL4, 0xf0ffffff, 0x80009007),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_CL_ENHANCE, 0xf1ffffff, 0x00880007),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regPC_CONFIG_CNTL_1, 0xffffffff, 0x00010000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL_AUX, 0xf7f7ffff, 0x01030000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL2, 0x007f0000, 0x00000000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xffcfffff, 0x0000200a),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regUTCL1_CTRL_2, 0xffffffff, 0x0000048f)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xfcffffff, 0x0000000a),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL, 0x20000000, 0x20000000)
 };
 
 #define DEFAULT_SH_MEM_CONFIG \
@@ -304,17 +284,9 @@ static void gfx_v11_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_gc_11_0_1,
 						(const u32)ARRAY_SIZE(golden_settings_gc_11_0_1));
 		break;
-	case IP_VERSION(11, 5, 0):
-		soc15_program_register_sequence(adev,
-						golden_settings_gc_11_5_0,
-						(const u32)ARRAY_SIZE(golden_settings_gc_11_5_0));
-		break;
 	default:
 		break;
 	}
-	soc15_program_register_sequence(adev,
-					golden_settings_gc_11_0,
-					(const u32)ARRAY_SIZE(golden_settings_gc_11_0));
 
 }
 
-- 
2.37.3

