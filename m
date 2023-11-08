Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E71C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 12:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F5C810E732;
	Wed,  8 Nov 2023 12:58:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CECE010E0A1
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 12:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0o72JHGcDLH7j9Q4xFwbu7baZ8Olqf4bZ5Pep4HSkdt/3UKwozUU2J6eYjaGsa4rsQxoERZDlEDOS8xjWhpxDFWfAjKqBUCL8cxncOHMpyH4kYLm961V7CgHXPOiZV0cBHigb0Aeru2ZHCWX6/ZiMrGb4gyTqWm43N4MPsdDch4QI/r2T4vKhPU2RPaVCs+3YYXMpqmCYbmQHgDMzqMHXIo9tJkRE5ulHwZ11oJ3hoQhIqVWxjZe2VSWEN1qE7afxPwarbjfrIEqIJhu6Kc36RMk6RihghVYJUTHd8GN0Fvi9XowjqnZ/u46RMwDI0OWEGdeGt8WXX/fUIxcncVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3RGPhMzy5jnddoU9vyP4hi5he3115D4pg5bUCQ0HYM=;
 b=haNcekR46LkwZJSq4fSb2ORsgTGxTaCxiBjzHVwtpp92YRNm5+1YgoeFyw5PiVaX2qVoR7B+ovPhskezEcN6Gt7hfvzh/kSpluxB1rEMRGCJIlAHiIuhPW5+rcdB4FwQNLchrlr9g5v/uVlDfqdmRJd/pVE0r1zoQ1vPhHmps1r2Z80HCK+M9TeRX1ubny9k4BjxvdAj1WAkaLgHPcCNkHWU3+j9qGMeqSx7Z9kcKIis0LmB46tjNvx7mMebsft6HKMoaF/fA2CLh8Ha1LDf12JEWUqC+9zkAFEIDvdPZgeZYDT5+qFaxU0koOBTtLr+x8gQihgplGTyyPvhTDBnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3RGPhMzy5jnddoU9vyP4hi5he3115D4pg5bUCQ0HYM=;
 b=MZJdM3lpscuFAmqfTns0/L3a6KhyLc3E+Nw0sOF55coDjTN1Ddu8wx1MzLJS+X1ZE1rDXtPzUYhGzJv0GBaiWxdhfLxPFOPR/RXiUWpYfOgLABvj53jJHQQBWU8a07oB7q9xabJJOdIzJ4SjPW9kYgbUkEI3foESi8i40fnC8+M=
Received: from SN4PR0501CA0121.namprd05.prod.outlook.com
 (2603:10b6:803:42::38) by PH7PR12MB6718.namprd12.prod.outlook.com
 (2603:10b6:510:1b1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Wed, 8 Nov
 2023 12:58:06 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::46) by SN4PR0501CA0121.outlook.office365.com
 (2603:10b6:803:42::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 12:58:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 12:58:06 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 06:58:05 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amdgpu: correct acclerator check architecutre dump
Date: Wed, 8 Nov 2023 20:57:34 +0800
Message-ID: <20231108125735.2497856-6-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108125735.2497856-1-kevinyang.wang@amd.com>
References: <20231108125735.2497856-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a36a2be-6b58-4f6a-9853-08dbe05a5a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gfV3TDsjOnMhykHoqG0uCD1/1X1FjDzt6z25DI1eya76BgarnEPeH/f8+g+s4Y7r+AXJP0/R9EqI+BY2hkYe7e7OsyZ34TTiXTgGD2RXx12BZLgjp0wciUL2gSltX1HuGX1ft4lJYHrDVaTg0GWrEB+qc0h0oMLX0C2rHDux7PyZ1Ts0IOkwhJOdRiRfC8Lk8t5UBsWFEZTXJZ3c7hWNjYsQwRSBjWONSQLQBqtbmo8LsUFC1vQOwBobWeNyFW6MxYpKeHJvoh/Rw/yQ0U+S6mHg7qPmuTch4uB5cysdk7YHIKMPO3ROhmFPsHvcZJ7kGVXjcFKQgT/2kELfAs3ea7ioo7WP6MKrEPsYSgAyMyb3dl4DZh9wPbePJzplrMCcPY/mezbpGrN5az4z6qsd5WAhCHlOZ3P9tkCjxvVPckVPu31Rp6u2Yj+0V4+/58RoPovmAZSWdKTMWK+jyAlPh6fgOoofCA0yKZsGt6DrE7gDkjPwzA3EPZDlgQJfHLz5FfAnX9j5ti4tHvD4N6/rXUwbdMLLZ/KB/yrpqllD8qRVifZBG4N2PusgOMJDWNPyaa3MNkg5rzrRxjMBeZ/dxcrqpyUiynr+JZS2HL+MXeUdb/BCjnCFFMiHh0hZNz3wN+DUUj0mSeDl5Maw9O2WOnsx3CsOUFB7b3S9nyQzMeNq73P60f5ix3mluHsIqX69N7I6+4iFrItwujBGERWp33U2vHNDTR+DDkBsRimnWz1j5mfBXQGWDPfyyW6msgduVBVeyYej8Ydd0+NnWLzOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(2906002)(41300700001)(6666004)(7696005)(2616005)(478600001)(83380400001)(26005)(8676002)(1076003)(426003)(54906003)(5660300002)(70206006)(6916009)(336012)(8936002)(316002)(70586007)(4326008)(47076005)(36860700001)(82740400003)(36756003)(356005)(86362001)(16526019)(81166007)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 12:58:06.8031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a36a2be-6b58-4f6a-9853-08dbe05a5a3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

So driver doesn't touch invalid aca entries.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 15 +++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h |  2 --
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 3302f4a29387..65926f3c708a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -202,10 +202,17 @@ int amdgpu_mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
 
 static void amdgpu_mca_smu_mca_bank_dump(struct amdgpu_device *adev, int idx, struct mca_bank_entry *entry)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(entry->regs); i++)
-		dev_dbg(adev->dev, "mca entry[%02d].regs[%02d]=0x%016llx\n", idx, i, entry->regs[i]);
+	dev_info(adev->dev, "[Hardware error] Accelerator Check Architecture events logged\n");
+	dev_info(adev->dev, "[Hardware error] aca entry[%02d].STATUS=0x%016llx\n",
+		 idx, entry->regs[MCA_REG_IDX_STATUS]);
+	dev_info(adev->dev, "[Hardware error] aca entry[%02d].ADDR=0x%016llx\n",
+		 idx, entry->regs[MCA_REG_IDX_ADDR]);
+	dev_info(adev->dev, "[Hardware error] aca entry[%02d].MISC0=0x%016llx\n",
+		 idx, entry->regs[MCA_REG_IDX_MISC0]);
+	dev_info(adev->dev, "[Hardware error] aca entry[%02d].IPID=0x%016llx\n",
+		 idx, entry->regs[MCA_REG_IDX_IPID]);
+	dev_info(adev->dev, "[Hardware error] aca entry[%02d].SYND=0x%016llx\n",
+		 idx, entry->regs[MCA_REG_IDX_SYND]);
 }
 
 int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_block blk, enum amdgpu_mca_error_type type, struct ras_err_data *err_data)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index 45f90edf2283..e4f30d20170f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -79,11 +79,9 @@ struct amdgpu_mca {
 };
 
 enum mca_reg_idx {
-	MCA_REG_IDX_CONTROL		= 0,
 	MCA_REG_IDX_STATUS		= 1,
 	MCA_REG_IDX_ADDR		= 2,
 	MCA_REG_IDX_MISC0		= 3,
-	MCA_REG_IDX_CONFIG		= 4,
 	MCA_REG_IDX_IPID		= 5,
 	MCA_REG_IDX_SYND		= 6,
 	MCA_REG_IDX_COUNT		= 16,
-- 
2.34.1

