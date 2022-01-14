Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66E6C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 05:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28CDC10E1FB;
	Fri, 14 Jan 2022 05:35:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C262310E1EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 05:35:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvJpJy0OLs3JeMqSIMCJ5V2jeg5bu6GurDX4zoCkpzGSqcieNuHP/CK+RZgBTS/Nnalprp0RS/3ybWuQudLYfbFDMSijrjI9eOeg9zVuMVtF2xC0MQc/fal7vzWK8UhR2I+VfQdABKsrI2qTvlz0VqQGF3QmZ8syQnvnWfWEkR8IBkdrQfyHR12aOz+UdlUiKVo7H+rPjZZCxJb6HFEpcBXiL6nkakVSIUe8jiybCq8N+dY89wGpIpShFrpHMKEFgNXTb1dn1/hbhXQiD/e/lqJqWm0sAFOTCoiAQsL4Vev2SOpNv6A6ie8/qgjD4WtjZKn4bisfT3dgRtYyn4s9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uK01fIEK+8fTVpRMBXDOMY3DLHeuxDtWqGVpvYCFbXk=;
 b=OPsXUq+pARKdfCvsB8sIiN0BDGkdj1+ibLI/N4BqmRP0lDO/dsPhMwd25HyVbjqN7mLEFUzPj76obii/3AZahvD3VxN61wzxDA0jZ4l2oHKse/AGm+7VGiJgpmtjMLXeLQZn2GVccSTeTlIfrwi0+78xbAbwN62PiTCiOMQIuZnr7bbjCeM3S3aqBlpIVpnIN2R36KJEJ7twVNrBJhrtWDD9YeZeEZJINtWdYHKvY4Vxaj2IztFwxS+hN/q2OgZiZ4VoRUR9oiDWOGwtCb5Jppm9nlNoB0Trs0hMgLLGKN+vEHbonQzST1LlmnhtXTJyaCTXto3wYXT5f+QMtbtHpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK01fIEK+8fTVpRMBXDOMY3DLHeuxDtWqGVpvYCFbXk=;
 b=XQjpg52p4JxgzP/opeVwDhIeHUyeixLQUJ+W1dGecvoB8SlUj2lobDWEL1OryEdFc1eP7SmkSu33aWzsj4mudl7kiDymnizoTAp1K3Dafx2QabJFLpsB+XONABcXeGWq/4BEDsVe32t/X2P5NFjXn8E+PCit8dTXIRnENiTPulw=
Received: from DM5PR15CA0028.namprd15.prod.outlook.com (2603:10b6:4:4b::14) by
 MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 14 Jan
 2022 05:35:00 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::6d) by DM5PR15CA0028.outlook.office365.com
 (2603:10b6:4:4b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 05:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 05:35:00 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 23:34:57 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 5/5] drm/amdgpu: Fix the code style warnings in hdp xgmi
 mca and umc
Date: Fri, 14 Jan 2022 13:34:07 +0800
Message-ID: <20220114053407.4035049-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114053407.4035049-1-YiPeng.Chai@amd.com>
References: <20220114053407.4035049-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f74d59d7-baa1-468a-8695-08d9d71f9b79
X-MS-TrafficTypeDiagnostic: MN2PR12MB4143:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41430D400C4E634086A51F45FC549@MN2PR12MB4143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBldkrcDHhByMHPv5So0jyTqHzyKYU1D0hxOwDYRkXgoXo+K35blOGXQLzmvp1t9AlooXUteraN5ZshZVI2ej32CFb61N7HMYHx7fDBzlJNRj/3UNGga1TftgG4uGxM6JTeD6th66kgsFdE7Bl0LM1DeYqFm4b7GT9Pd6hpsm7Fkre1pdNOG7dJuOxUM0qbt0I5UTj9DxkTXVEPYxie/KYMFCExqg7brQKN5UiyUFBT9cnl7A+zLSNClKzh9LXbVFoRWHmB3Mn10KLDxdp9RJD9aBsBp0gqOMdQMysxJ9ZHvviqnticCEUS2t3nuS23xz1oGtgF4T80z8/HOYjejJrZ4Y1JDjiYNd6+tM8QAyMG5D2uwyD+YPjmSuSTsgP6iXGJ24TO1PYUBTrPi2KOUV+2yPfDOfB7fiPZp1l9rTtD58CYMTnmnIF4J6SHuY4e059H87A6bKqwyps7Q0wI81lwhJw9kmPzgC0m3mDXe6fIum9OW2Jr66ZRfeTOeIS7IHbO7dmLaJ8yOF6fkB9Z6gQh1akTL5K1Jr7Igjyv0YfyfRdaSzRRgQtdBy86FcGEXRowdi04IoK54OnuE9Vb4nzc6UYkVl2vcEi1yiM0U4lGbGWMUQDdJsSnG/939eWx4xjsvd4T1qSlgHeYBW5452fqt/sUbdBsT7DISgcMdSo8ZesHuaabl1oZyAPMH7pMOeIxh5DXk9sY08L8/FO7SSrMKRHEUdErYA/uYDjk1DaLMdDzi+N4ZrdpM2dnln11FrwhWLd9P36ohr61elB8sijJNqeCTNZH/cnX6uJ33UlvHlnKbVT3bfNKP1AvT6L+GBWLuyeJzwqfmU/6lYZBMv3FvMCdWwsGqWSee1+x27CQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(356005)(6916009)(1076003)(2906002)(40460700001)(54906003)(8936002)(8676002)(4326008)(508600001)(5660300002)(83380400001)(7696005)(81166007)(47076005)(316002)(82310400004)(426003)(336012)(70586007)(70206006)(16526019)(36756003)(86362001)(26005)(36860700001)(2616005)(6666004)(186003)(43062005)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 05:35:00.1245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f74d59d7-baa1-468a-8695-08d9d71f9b79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
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

drm/amdgpu: Fix the code style warnings in hdp xgmi mca and umc:
1. WARNING: missing space after struct definition.
2. WARNING: please, no space before tabs.
3. WARNING: line length of xxx exceeds 100 columns.
4. ERROR: "foo* bar" should be "foo *bar".
5. ERROR: space required before the open parenthesis '('.
6. ERROR: space prohibited after that open parenthesis '('.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c    | 7 ++++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index c94a4b3c8d6d..4af2c2a322e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -24,7 +24,7 @@
 #define __AMDGPU_HDP_H__
 #include "amdgpu_ras.h"
 
-struct amdgpu_hdp_ras{
+struct amdgpu_hdp_ras {
 	struct amdgpu_ras_block_object ras_block;
 };
 
@@ -40,7 +40,7 @@ struct amdgpu_hdp_funcs {
 struct amdgpu_hdp {
 	struct ras_common_if			*ras_if;
 	const struct amdgpu_hdp_funcs		*funcs;
-	struct amdgpu_hdp_ras 	*ras;
+	struct amdgpu_hdp_ras	*ras;
 };
 
 int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, void *ras_info);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 478457637d29..5929d6f528c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -950,7 +950,8 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,  void *inject_if)
 {
 	int ret = 0;
-	struct ta_ras_trigger_error_input *block_info =  (struct ta_ras_trigger_error_input *)inject_if;
+	struct ta_ras_trigger_error_input *block_info =
+				(struct ta_ras_trigger_error_input *)inject_if;
 
 	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
 		dev_warn(adev->dev, "Failed to disallow df cstate");
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
index f51092041edc..68565262af9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -47,12 +47,13 @@ static void mca_v3_0_mp0_ras_fini(struct amdgpu_device *adev)
 	amdgpu_mca_ras_fini(adev, &adev->mca.mp0);
 }
 
-static int mca_v3_0_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
+static int mca_v3_0_ras_block_match(struct amdgpu_ras_block_object *block_obj,
+				enum amdgpu_ras_block block, uint32_t sub_block_index)
 {
-	if(!block_obj)
+	if (!block_obj)
 		return -EINVAL;
 
-	if( (block_obj->block == block) &&
+	if ((block_obj->block == block) &&
 		(block_obj->sub_block_index == sub_block_index)) {
 		return 0;
 	}
-- 
2.25.1

