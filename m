Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA79CC7618E
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 22:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FE6F10ED19;
	Thu, 20 Apr 2023 22:26:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F8E510ED19
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 22:26:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3ODOE0NhDZ8ZoB+SyDsd4eBYfPuFeyRq6+EZMGHpNdl3+gJ8pVYQLahYTK4C5VQvCvfmBfSHmC7vzBXmKnrTINBBeQ8R+CQpw0EZISGuqYBTlkjCfZXMk6u8XhPQKdpvkgqNhnBEUODgGSFNHFNCkYCqFURAHM5zj3OUbxe+x/31WAPA/re0cZlxvrRrozJYWq2bvPSS/varoLtq0isZBg8BO2WFI77qmsYCyVYpPwHZM+4RUvD0BReWK9AL6WB+xrK0N31AXsFTm+bbRR8sOKTTWGL63PMK9yMkdB0UA165C1V41WOLELPU2ytwfSvnFj5gTN5x/o+euu/cCBPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X8MZ/6fjUO89d3Kh7aj8wIgei7JVijRkL9ROntdUmg=;
 b=nc6nobMVnovLYn85OnvxF3AaYfj0IyAG2Z6eCi/CMNAcTIxSGmzPvW9EFGEW8pbtPObWSbVcC+el3Av+tB7MA4PQQfblTh4EYWJraX8y8FSZc+liXXjF83/3mJWn/oxrOU/s+PSJxmEqUKaWWdNm2W32Z6WL3jBYbR6XysWfxleonrXaDKnZAqTs2Gw1DsRq1lc/mylGrNsYoDMtATep7MGJ6uOSjx18vebCindjOxOzDDFh0j4Dpk6OcJxvBB4a7rHsun3DkEmfX5uZCov7cCuB+3U+B4UarSst6nW39+9ASaVWg5n4xEgTSEga9ws5ClEt+KZGlmmghBz+m3py1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/X8MZ/6fjUO89d3Kh7aj8wIgei7JVijRkL9ROntdUmg=;
 b=MhmHusyrZ3NtkXfqSwHBNJvZC+hXguXKJ+KzdF4DbVSS4lKlv6K7rIjbB4RNjDWyV1aP/20TeRzAeXdrVlksMMuiDNBheIjbLYIQCtg8XlU+yToeEdBjFAJlhAhtbaav6GxV2A1oSqjvsAYxiChO0CB8hJynaOlrS+s1nJ26Cas=
Received: from DM6PR11CA0070.namprd11.prod.outlook.com (2603:10b6:5:14c::47)
 by DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 22:26:11 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::42) by DM6PR11CA0070.outlook.office365.com
 (2603:10b6:5:14c::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 22:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.26 via Frontend Transport; Thu, 20 Apr 2023 22:26:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 17:26:10 -0500
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 20 Apr 2023 17:26:05 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix an issue at userptr buffer validation process.
Date: Thu, 20 Apr 2023 17:25:31 -0500
Message-ID: <20230420222531.470189-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec191f5-33c0-4e7f-7e39-08db41ee3eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +6FkHiRnicTpalhG5j2wnDVyLrGfFIX462VSuCjPvjCnm2XgPd3eFTSBdtaHStLqSRd1uctQMHGu4znlp0WKrDBW03Y+MXQOdoJ1aq4WxQyJ93RwFFV7TTm3sqbh9Uwj86/048/yd+1n7ra9t9vx38yTDoTIDcXCcBel0afHh1WpVH3/uMjG3wQnr1ibNKms0Z3BKqZreNE1o5DJoCfeYub6+LZywUjiN20pPOxEhe7QkwD89QeuoPfZrqxYUaZ5HLV81U5bvd1rOK/mT3hYvPpw3834doTDft1t+5W4P919Y6oASXhYPXqdbNgBEMW7ZCQT468vPPYS75ynTsSuzuMXibL4KIDF2QuQc1MaNu09jSZZzE0eDw6T74lYJOnOs8vbR8eZW8CqCInseVieUqnKEF4lOq4iGdWaYqDg1z2w2RMNnk0lakuzh8uwBYofG0ejggN0cTAtnULBLloHEXZNwwVER9aCZpwbkInUjTbRuhvtGYDt2IuGuWp3TCH+91up+M7cytS+w/1J4oYnla01Au2X8hctz23QAGgkwLDAGtTsqttiELxS8kMqnpUWrieabZgEzvfIIuMvxJ+xZ69/GDaKmDvEyftf/lrXZAOUjkSX7at8xlfr8j3ExSztyVPMwhhNrDygbp31sKppzufMr96iMO1B9FyF1VMwQkDYZH3ZVOmWPSozwGSMFE8gVUlijyUEsZm82l+DMofkhdqAS5leTu2o3lUvlKuxupw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(82740400003)(2906002)(356005)(81166007)(40460700003)(86362001)(82310400005)(40480700001)(478600001)(54906003)(316002)(41300700001)(70586007)(70206006)(6916009)(4326008)(26005)(1076003)(36860700001)(6666004)(186003)(36756003)(47076005)(8936002)(8676002)(426003)(336012)(83380400001)(5660300002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 22:26:11.2379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec191f5-33c0-4e7f-7e39-08db41ee3eb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292
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
Cc: Xiaogang
 Chen <Xiaogang.Chen@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

amdgpu_ttm_tt_get_user_pages can fail(-EFAULT). If it failed mem has no associated
hmm range or user_pages associated. Keep it at process_info->userptr_inval_list and
mark mem->invalid until following scheduled attempts can valid it.

Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 28 ++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7b1f5933ebaa..fad5183baf80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2444,7 +2444,9 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 			ret = -EAGAIN;
 			goto unlock_out;
 		}
-		mem->invalid = 0;
+		 /* set mem valid if mem has hmm range associated */
+		if (mem->range)
+			mem->invalid = 0;
 	}
 
 unlock_out:
@@ -2576,16 +2578,28 @@ static int confirm_valid_user_pages_locked(struct amdkfd_process_info *process_i
 	list_for_each_entry_safe(mem, tmp_mem,
 				 &process_info->userptr_inval_list,
 				 validate_list.head) {
-		bool valid = amdgpu_ttm_tt_get_user_pages_done(
-				mem->bo->tbo.ttm, mem->range);
+		/* Only check mem with hmm range associated */
+		bool valid;
 
-		mem->range = NULL;
-		if (!valid) {
-			WARN(!mem->invalid, "Invalid BO not marked invalid");
+		if (mem->range) {
+			valid = amdgpu_ttm_tt_get_user_pages_done(
+					mem->bo->tbo.ttm, mem->range);
+
+			mem->range = NULL;
+			if (!valid) {
+				WARN(!mem->invalid, "Invalid BO not marked invalid");
+				ret = -EAGAIN;
+				continue;
+			}
+		} else
+			/* keep mem without hmm range at userptr_inval_list */
+			continue;
+
+		if (mem->invalid) {
+			WARN(1, "Valid BO is marked invalid");
 			ret = -EAGAIN;
 			continue;
 		}
-		WARN(mem->invalid, "Valid BO is marked invalid");
 
 		list_move_tail(&mem->validate_list.head,
 			       &process_info->userptr_valid_list);
-- 
2.25.1

