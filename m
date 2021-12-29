Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FF9C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 06:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7826210E3A2;
	Wed, 29 Dec 2021 06:32:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2911610E36F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 06:32:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0kuaJ0lmuCuSxqfDRCgJlGIMjdWqw0U+TWIqIRKWVlaTilh+/+6/D5LN6U3SXRlc7WSEOhggzNY+7F/Wz7gMqNwpkmTgdg7Tn4eHFT4tQiTFq8KYHkjJnZiGrwHIq6RG/TZZq3FTPCFRbJhTkQCRCLMBxc9aSqmw+/b639URKjUl1ZjqAgDi9MR5TvdKOf4C8f0upLDmZqRgx7AdP40soSvFStO2kVkTF+H/rbwk99la/mIuyJ0uD9YQbe9gcq4hmgvLmxlXLzLp/qAT7B1jmr0QIqvkvfpagBRqBh0o2nBJbw1rPbVu403/YDGTkE1k9MM1BM2BiiRCJlig5+JEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABE+150yEu5RQJqoHcOF7TeZjFUcH9DttURbGAdPHu4=;
 b=bR4MdbOpeTk/TkFeb147lsOtEkBNzfqt6Vwi5TFV8PuyUKjKlILjR8C8uprdcIgZHTFCTVbViqbnytoIssY+IjwDIHnIlsQqzsgs5n2teeLZc/AKMEyGzyB7Zv1IAJzTg4ijPzh27TCQ8TRoBFy8QuoNswR+/rVWjFcPT+a7tnaEeHYZfoS0y/1sHLhjrpkvKalgX3cXID548Cz1c/B9v/ouJIJGt8h1sLCtZlQcW0maszmxU+hrKw12902ppO7dL2d5VIflJOYiWekX8hbWPNr/sj+zIO9CR4yTwe+b2Uugy/hbWWICPETjX0c8df8rifb8XMttwl1AQ/6ilHGEuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABE+150yEu5RQJqoHcOF7TeZjFUcH9DttURbGAdPHu4=;
 b=zU4S5CoRrIBqZ14rufNEyeVYIBKFEJ3QCjNslkD+l7qWkyeJHpkAKjWmD3GelrPBEVZ1KjOQCFS1wct/hGbV/VWKJ0gwh86WYoYbRH5gFXl4eZwapiskT6CfkvL+lcoHppABq4v+DBtJ47TtUEGrWpBO/5JYrumzxUcGNbtexiU=
Received: from MW3PR05CA0002.namprd05.prod.outlook.com (2603:10b6:303:2b::7)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Wed, 29 Dec
 2021 06:32:54 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::67) by MW3PR05CA0002.outlook.office365.com
 (2603:10b6:303:2b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.7 via Frontend
 Transport; Wed, 29 Dec 2021 06:32:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Wed, 29 Dec 2021 06:32:54 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 29 Dec
 2021 00:32:52 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 02/12] drm/amdgpu: Modify the compilation failed problem
 when other ras blocks' .h include amdgpu_ras.h
Date: Wed, 29 Dec 2021 14:32:01 +0800
Message-ID: <20211229063211.43840-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229063211.43840-1-YiPeng.Chai@amd.com>
References: <20211229063211.43840-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fb71318-908a-43d4-077b-08d9ca950ba7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4272:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB42722700C66407EC7DC735B5FC449@MN2PR12MB4272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8sttN8KXhc1KHU9/pckHirNOsmAklnd1OT2BcR2HV7F8mEpunPem0+0tnNLG7mED/VA5d1e02M5g0vlwL285Te7QHMPfV3NhwioyU74pBLyagpHUleq+FRHtiXOehdc9xFEuSs27S2KEA6Nui8tLLnYaVO4A3eHBi6T0n7wmTUODnYNIjk+OaWMxNgcxuz3Om2wurA+rGetKdeExeavQnjaoAArWDn223OgBMuOh10fgiTY5Dxx5cAJR01H/XGZdNkoL7COyGR/5xZo0LHRrAF7nbaxgy+TdZEDtnJSQYqlzwmd5ssEkOAb15upulDf/aH9CIWRG1BD8xKFwoHpjzOGsFxugDiLv2tZYkn+39VPKjzSSmViMOeE5UZ1VOgBLU+L6vcM5mC1SM6PXhI33qfcLIauf04uzR8emEjBnRKb/biwnHULCJChmHJ4DUU41Uk7FbcCoLBR3iCMc49XYR8oN0ErBG1rsQ+BLbLT0lYKs8h/0oAPiEFSMKMNKCgCpgU/MFBXjfue6U0HQDmqAF2xReQbdYBbS36XNfzk0Z1sOkI8i65dMuYafK5KITU0E6Sl9J5qL3ui5vnlVBjvwKdDIQzTXBg1ap3JFFACFsR+x+FoadPntlSbUIazaIzhHAUy5Bq22rjaa0s5UH7G4/rfpMmzfmdNVj51ADAHppV8wtirKWHrR/8rvjKENb6OAfY+4AbVbQDo8zZLS0nUv9RlmmLV9yvrVYHajnvlGHsCdB6CmYkhAk4wWBuTqZZw1kgMkgB8w4nvtvI4bmeHPCuboutzEhJoJpo91usP/UXCpn4TMVcQ6HyXQ/4XYWs5r4aV5SlDQ7gTXoR/l1g6qw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(82310400004)(5660300002)(186003)(70586007)(508600001)(316002)(70206006)(40460700001)(36756003)(36860700001)(16526019)(54906003)(26005)(81166007)(356005)(2616005)(86362001)(426003)(336012)(8936002)(6666004)(6916009)(8676002)(2906002)(4326008)(47076005)(1076003)(7696005)(83380400001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 06:32:54.2350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb71318-908a-43d4-077b-08d9ca950ba7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modify the compilation failed problem when other ras blocks' .h include amdgpu_ras.h.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 23 ++++-------------------
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9dd698354e04..67a08629711c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2773,6 +2773,28 @@ static void amdgpu_register_bad_pages_mca_notifier(void)
         }
 }
 #endif
+
+/* check if ras is supported on block, say, sdma, gfx */
+int amdgpu_ras_is_supported(struct amdgpu_device *adev,
+		unsigned int block)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	if (block >= AMDGPU_RAS_BLOCK_COUNT)
+		return 0;
+	return ras && (adev->ras_enabled & (1 << block));
+}
+
+int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
+		schedule_work(&ras->recovery_work);
+	return 0;
+}
+
+
 /* Register each ip ras block into amdgpu ras */
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 		struct amdgpu_ras_block_object* ras_block_obj)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 9dbe8d49b891..3d7a45ec4d9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -513,16 +513,6 @@ struct amdgpu_ras_block_hw_ops {
 #define amdgpu_ras_get_context(adev)		((adev)->psp.ras_context.ras)
 #define amdgpu_ras_set_context(adev, ras_con)	((adev)->psp.ras_context.ras = (ras_con))
 
-/* check if ras is supported on block, say, sdma, gfx */
-static inline int amdgpu_ras_is_supported(struct amdgpu_device *adev,
-		unsigned int block)
-{
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-
-	if (block >= AMDGPU_RAS_BLOCK_COUNT)
-		return 0;
-	return ras && (adev->ras_enabled & (1 << block));
-}
 
 int amdgpu_ras_recovery_init(struct amdgpu_device *adev);
 
@@ -539,15 +529,6 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 
 int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev);
 
-static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
-{
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-
-	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
-		schedule_work(&ras->recovery_work);
-	return 0;
-}
-
 static inline enum ta_ras_block
 amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
 	switch (block) {
@@ -679,5 +660,9 @@ const char *get_ras_block_str(struct ras_common_if *ras_block);
 
 bool amdgpu_ras_is_poison_mode_supported(struct amdgpu_device *adev);
 
+int amdgpu_ras_is_supported(struct amdgpu_device *adev,	unsigned int block);
+
+int amdgpu_ras_reset_gpu(struct amdgpu_device *adev);
+
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev, struct amdgpu_ras_block_object* ras_block_obj);
 #endif
-- 
2.25.1

