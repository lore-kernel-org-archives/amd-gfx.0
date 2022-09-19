Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDDDC32771
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 02:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B114C10E454;
	Mon, 19 Sep 2022 02:03:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABB9010E454
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 02:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cB1p7SA2CykqWEbWB9gJpnJJd/KRxzU85GwItU+K4FlUytvY23RkFcwUUCVzJrs1hI+OIsB7uJyGi9Ysse1cM3wNt2pwqY8su41IyDXCdaBxusZzhbxI/vBk+cWAxZ8cajbTpfGBh9ClU6QA9gPZHfci5XaMpIrEmtPZEkEoYoSTaDTHbjen8LlwjZ4Y59jLXwHrqEyusHTb49maTN6U9T0NNYZ2AY/pICzk1N4XwG1pHjoAzYhHZLv0PTH0vJW9OLnw4pVuEDMJkJpdJLuWUZomovLEoqx5Xc7TgeUsH8+TIY6krmKEWjw0bL0ENKRUKYCrUuDmJdXlkv8mz4lEiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnAenuDiJc9gG5Mgqt+EHxj6pMa1w6L6+aU40ZAo3Dk=;
 b=Iyn0pAxH7Wrnef/BA7pECPHa19/FxAZoRFIDh2EmMLY2xIkAjr6J6eeoT6wGmDuVxD00e0cT7m+jy0A4dQQNt7PoqickS99uCFP/SYfjnXIYMH9pk2lGOTm31jEs5lPJBFNJQHRJRSy6p7OsZRjkYmIwsZVxje+8U8vyfsHgZBtRryrKldIY6uqt41239kZ8a+W5Rrm2w3XCOx5eqETz8T/L0wwTLMuwgR+yfQtzUKbGqWIXXuSGBTAIQu59JqR45iw+3j8zZPg91XZ9Q+b+JlwdbDfXIsoWlGqOTHG+XFLE3tYlVXv4smAiA+/rXVnBNfLeWndNSw2H5boKY470yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnAenuDiJc9gG5Mgqt+EHxj6pMa1w6L6+aU40ZAo3Dk=;
 b=2yiBFQxKosMsXh4teeQOy3CD8zG7ya5CO5/NHt0aEQI40sVgHvwhnvkpF/sIsvxPMS+oGt8Ch8Al4Avoxzib/6oabd7Adhk9xaOcRuqvW5BhKfy7/RwRbwffUwxQTWrW3r0w1fFDrfNmfhrtVUblrnazuNK4WbQKeMtzO7HxeX8=
Received: from MW4PR03CA0110.namprd03.prod.outlook.com (2603:10b6:303:b7::25)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 02:03:38 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::25) by MW4PR03CA0110.outlook.office365.com
 (2603:10b6:303:b7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 02:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 02:03:38 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 18 Sep
 2022 21:03:35 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 6/7] drm/amd/pm: move SMU13.0.10 related pptable settings
 to smu_v13_0_0_ppt.c
Date: Mon, 19 Sep 2022 10:02:50 +0800
Message-ID: <20220919020251.7048-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919020251.7048-1-evan.quan@amd.com>
References: <20220919020251.7048-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT057:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 96338c52-c13b-4470-2f6e-08da99e32ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WkwiDQNWHzdNhGETW/mx25bUDZ6pBpBlzVUpyC4aJJoLok/+OiFi/mwwFf1vqD6exTbbg7zNB2EuBr4dur61xlKYM5RYxyfmgCcmA4xDK2WiIwPdPd5Cc5uik+AJzpOqKM61cSEmPKxzEugqnSDRDLrmtISNQzujhYXrNsd+huHek7cz2+yD3WScMMNnoYTLxxWNfrAkypwBbBuOHT8u12+A/2wdNHwL2NP5gW6H4RIvyDT2Z2hbCtDRo3M+hwUUIVtidN04ri4r6wKUAKR2EN0c6TUCQiio97XtG6ftu16aDHHbXNx7esDFTIyycOtvIpVdKZ0WUPKuucwQSnsiFm0n+ZeDLY/spCI7fwmiKp8niSTyjhi+N/Vp5FOx6xUZGOnQa1Um0wR8ljNpvA3d/Rzk33+pV4eCVezJtir29ukbo/cUSFgAf62Mnlh2LIZZ6lOyRl0ZPC+r2cN+bBIcLtHAPDLjmKGnkCCPjoCzI/ReXpvv2fOEex3dPnKd6ESjU29DiJAhK7/1Dp3Rq8MSmtnEDgHzQObyi1s/0knLWh2Yd6Hd8UPcw6Ve3oX1psnT+he+Ympsx/RNauwhPoq/GK1d6YgkOcfiRM0SNcQxNOl+HnivfSsFaKTLhoNHczLx4cxODC+Uke5k35+MrNvkImcw6nG7hLDzxw0QpPHeWGtZI8dQwWWgomGGAwYPcCSbU/u9l1EPXFwScdgfl7UFs7Ja+1p/urTsTLt+5/2xNHF0fw8+Mfmnl8QLWxtd/6uDcgJa80mODNhErR+m6yqmnqFlGmhyLaA3xsjt0nCZPXpfScej4t0EgU+1lfDKcrlG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(70586007)(81166007)(70206006)(8676002)(86362001)(4326008)(44832011)(2906002)(1076003)(41300700001)(8936002)(2616005)(83380400001)(426003)(186003)(16526019)(478600001)(356005)(6666004)(40460700003)(26005)(7696005)(316002)(6916009)(36860700001)(54906003)(82740400003)(336012)(47076005)(5660300002)(40480700001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 02:03:38.0407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96338c52-c13b-4470-2f6e-08da99e32ae2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879
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
 guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU13.0.10 shares the same implementation with SMU13.0.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ic3720ee8fd05f75f39e4e9242fc4c57d92efd6b2
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 12 ++----------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 24be318adf7a..1c354321630a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1026,16 +1026,8 @@ static void smu_interrupt_work_fn(struct work_struct *work)
 
 static void smu_pptable_source_init(struct smu_context *smu)
 {
-	switch (smu->adev->ip_versions[MP1_HWIP][0]) {
-	case IP_VERSION(13, 0, 10):
-		smu->pptable_source = PPTABLE_SOURCE_INTERNAL_HARDCOPY;
-		smu->pptable_id = 6666;
-		break;
-	default:
-		smu->pptable_source = PPTABLE_SOURCE_VBIOS;
-		smu->pptable_id = smu->smu_table.boot_values.pp_table_id;
-		break;
-	}
+	smu->pptable_source = PPTABLE_SOURCE_VBIOS;
+	smu->pptable_id = smu->smu_table.boot_values.pp_table_id;
 
 	if (smu->ppt_funcs && smu->ppt_funcs->pptable_source_init)
 		smu->ppt_funcs->pptable_source_init(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index fd405e2420cd..18b02b99ee95 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1758,8 +1758,18 @@ static int smu_v13_0_0_set_mp1_state(struct smu_context *smu,
 
 static void smu_v13_0_0_pptable_source_init(struct smu_context *smu)
 {
-	smu->pptable_source = PPTABLE_SOURCE_PMFW;
-	smu->pptable_id = smu->smu_table.boot_values.pp_table_id;
+	switch (smu->adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(13, 0, 0):
+		smu->pptable_source = PPTABLE_SOURCE_PMFW;
+		smu->pptable_id = smu->smu_table.boot_values.pp_table_id;
+		break;
+	case IP_VERSION(13, 0, 10):
+		smu->pptable_source = PPTABLE_SOURCE_INTERNAL_HARDCOPY;
+		smu->pptable_id = 6666;
+		break;
+	default:
+		break;
+	}
 }
 
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
-- 
2.34.1

