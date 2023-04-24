Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AE7C6FD18
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 01:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D17210E028;
	Mon, 24 Apr 2023 01:58:20 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4435310E028
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 01:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xqr+CgbHrYQhpJoDPXdl+m4D8GiltyJ/Tge2BDA+41Ba0ngVcXljjTB8Bo1PWyD+6xUKfM0Ys21o1FOOqNTy+fW7H6l/oqxi6jKN35JGmbLeLrTQ5m4uBybSqQ5fMGJ80BZG7V2FdykbraFlssFde1H2zI5fJS86BONkW3akPzZYVCX7mpFZ4Z2hH+ZNnmQ3NmF40PnDcAahnoi6E5jkwCVpo+sC2P9juO5xDqDxf553fRtNo9ql9ibtDa4bCxfPgNCj7SYFxnXT5zHuutfPQi2xB5qgDudQAWSpZ7O89hjxLNY3K0ZMdMIb++JK7OYKN3KEC6/efnGD05lvyJyZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLXidVrfFAogd5C2Ew/cvqFPmz5O5s4BCkTZGtPGixM=;
 b=CPpJJPys04ZHOT47qdedAfqwRDeadmXIA7X0/T8iX7Dh9zknmedPAgaMXt1xjohyRaRvlT6Y9A5cSAc+1+rsS8+E8cREW49RWIOhMCdAc0TBbABp2T2x1juD3xDo51LXMakUrPmtms0MJ34T/qA9krvWHi/Vq/g8NkICGegYHaFLqz4wZzlCYUWU7fHBmokfXmYv1cNe6Xzkr2DxhPB8S8BM0rQTpHuv/iGizHrvpDYoQL86tsuBaMVCEH1RcDSC3fFceNHlBUBKBNovfcTeKlZx5y231LdyX+P3CFK9CdrNIZbHevHRfbR0x+QHjQKFXxZyTNVzveRR7DvqzQdEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLXidVrfFAogd5C2Ew/cvqFPmz5O5s4BCkTZGtPGixM=;
 b=j0DYzNDc15ffRQn6pX5QmHpeq6wJBBX5HD1Jv+qJVp882i1Zu+11NYC/AREh6FCMUi5qxDeQeJNXrrE8lwckn9ls0+Hf2SyX86uKoswOQ9xWgw3IfNoMlvwdtmm7QwG4CSSd7/X2OLNj/Dm1kf2O7SdHU1GzEXDmTbYgKvLufJU=
Received: from MW3PR06CA0017.namprd06.prod.outlook.com (2603:10b6:303:2a::22)
 by DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 01:58:12 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::4a) by MW3PR06CA0017.outlook.office365.com
 (2603:10b6:303:2a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.47 via Frontend
 Transport; Mon, 24 Apr 2023 01:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 01:58:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 23 Apr
 2023 20:58:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 23 Apr
 2023 20:58:08 -0500
Received: from lyndon-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Sun, 23 Apr 2023 20:58:06 -0500
From: lyndonli <Lyndon.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Fix mode2 reset for sienna cichlid
Date: Mon, 24 Apr 2023 09:58:04 +0800
Message-ID: <20230424015805.78747-1-Lyndon.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|DM4PR12MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab1a859-1ef4-4aa1-6059-08db44675bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+GB5daUoW+lNVwRU5JPDjWWRdgfZt9RXPy/6xwsLPIsTxAoeqYczP34ngAwyW9NAYc0WppXzlMyr/+CFcJ0OPVByHqwguC6MjL45gT2Sz8EDThvZFLqR1Q/6c0dSCfGH+OSIlEaWWSz2EKnB4mxwyyeLsUCK+Rhm7YUKWtzubZveYffSoU1Y/3vdP3rA5B10Ep0X4LqbykxIqKuw4Jpc4I3SJhhWanE5uGN8HqYjVh/T77WVGHIjNQoZpJ8qA8U/noCiZDm4I645+5tSy87HbvOuYleUfc0D0pAxecpuZxtbajOuaK1tCTq62do/Lm7SkODszt490vW7DenUkFpTzqH00QBd2G7RA49AgGB4NHsozA6HyVtb4KuDNdONbDf3LbYo1GNmI/tPXcSOEO9o8hjbCSmJj3XGjtqwMmKBMJYKuHNSuNBQfGWgbImYW72JiIAwrFTQf5Ui2kAxxtNxVmLw1ZaMFMtbL2imDcphLnu4WG8jrQHU+AjEB7bY350DYAuItTRV+D5DlZ2T8dstakwDFE5ZD+5VtkjwWx7B7JbeBBL4JV+Z891ggT5A7qwb2maNCsGPnhYOXd5ow/VLjn34Tkwyt+UmXp3YRNM8MJslce/K8z7QWSXoFSrJG/5uEr78Mpp4yzpDWhwu7YgcdGJKBZfK0Pw/Cugk5Pjq9CK9LLD7H7CCZA/QfIdeGu7721vX0Ierve6aqFOQUZy3GJ1XUVoYkVVKEshxUv/GlZCnEkN+eDTNnf4oFogfLKU8vKQOLPvW7IHnXKWA+mSyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(54906003)(86362001)(478600001)(40460700003)(36756003)(186003)(7696005)(82310400005)(26005)(1076003)(40480700001)(82740400003)(356005)(316002)(336012)(426003)(81166007)(41300700001)(36860700001)(4326008)(6916009)(70586007)(70206006)(83380400001)(8936002)(8676002)(47076005)(5660300002)(2906002)(4744005)(2616005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 01:58:11.6400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab1a859-1ef4-4aa1-6059-08db44675bf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
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
Cc: feifei.xu@amd.com, Victor.Zhao@amd.com, Yunxiang.Li@amd.com,
 lyndonli <Lyndon.Li@amd.com>, kenneth.feng@amd.com, shaoyun.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Before this change, sienna_cichlid_get_reset_handler will always
return NULL, although the module parameter reset_method is 3
when loading amdgpu driver.

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 81a6d5b94987..8b8086d5c864 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -40,7 +40,7 @@ static bool sienna_cichlid_is_mode2_default(struct amdgpu_reset_control *reset_c
 	    adev->pm.fw_version >= 0x3a5500 && !amdgpu_sriov_vf(adev))
 		return true;
 #endif
-	return false;
+	return amdgpu_reset_method == AMD_RESET_METHOD_MODE2;
 }
 
 static struct amdgpu_reset_handler *
-- 
2.34.1

