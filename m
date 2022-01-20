Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8D0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 11:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FC6B10E5D9;
	Thu, 20 Jan 2022 11:19:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E595E10E5D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 11:19:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfKp5DKfIu1X4n+PhuionMdRQsnJevvOJMJGiJFNmehpXMQ4JsnuFFJSbUFku2UyZxbtkTvQbP4xsOuTe3mOn5xaKvW2I922YPDz9pO0oZ8WB6e4VxOQmiF1gv1VjzdlGZ2aux5FJMaC3p02wdJ5F2dM8RfgqILaEd/99+JNtyuK+GYBd3jJWonzzUnCw/9lI7oDQMTjV2r6MnnjWUxjcZwsILIF3LRVosKaRRfnswEUI7T/UB+RqNQOmhUH9+o87bGQ4CCMSWWNEVN4qK32OBo/B00R03f9BfrnEEfGOqOZqwg4TWHr8FfAVv9vC4gch7bszf5WdprkNzZ8TE/TjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTXCkPcmEYFHKQcWFv/F3MtRvRRfR1A52Ho3XRQ0Dc4=;
 b=EQ4ATIiiXqN54sQWxzR6LjIRO7P4WLkeETVKLVVG1tMiadSmvMX2WsLSttBITVG7XsvNEaIiZf5zbqVT9GmluyogSmeQ5PTDHMH3iteUypRRdLZBm2SchAEhHbEp94Q6we1hVWLtWrLbGWuAFj+spWAy3dS7cfTktov1ottNhApMosODMhrLEPmO5k6Qmj2q6mPEV8YoS5qjvldZQWEfhTOWaYV9NOEB4D6FL20XDBypj4vK2jeGw2ykvwmmtTaQd+kn9ZIbwNPbC02KsLfFpU7xEnkY9+tecKXhx+0H2qLUlMvM2axiX5YTVNgp62rPjP4F5GJebBXWHYnUt6W0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTXCkPcmEYFHKQcWFv/F3MtRvRRfR1A52Ho3XRQ0Dc4=;
 b=mATVwxGS64Xo69XXQ0aD7Swg5yd4qJnuyDzb4uh1X+v2zgbo0YGeukVMFXXVaQR+owg1P/fG1BPo0sd2pUN61hGrz5ZP/GvoxvTXCtpyXlB1BwO7aJ0cFxm9/TdcOxGCeyRhgDmTgMcH1CxtBhZ2jThWjAwFgI/vWh3uBEZLRMc=
Received: from MWHPR02CA0010.namprd02.prod.outlook.com (2603:10b6:300:4b::20)
 by MN2PR12MB3133.namprd12.prod.outlook.com (2603:10b6:208:c7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 11:19:07 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::83) by MWHPR02CA0010.outlook.office365.com
 (2603:10b6:300:4b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Thu, 20 Jan 2022 11:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 11:19:06 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 05:19:05 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 03:19:05 -0800
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.18 via Frontend Transport; Thu, 20 Jan 2022 05:19:04
 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/9] drm/amdgpu: add structures for rlcg indirect reg access
Date: Thu, 20 Jan 2022 19:18:48 +0800
Message-ID: <20220120111853.11674-4-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120111853.11674-1-Hawking.Zhang@amd.com>
References: <20220120111853.11674-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 567c5195-5eeb-478e-d777-08d9dc06ac55
X-MS-TrafficTypeDiagnostic: MN2PR12MB3133:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31335E75C3BA3AD76AB4A5CFFC5A9@MN2PR12MB3133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQgU8yDJzVbSzYYJxxpwhfv0xtv6iTsu/QN1gnmA5V5r/+/cEMPOCc99BesoA5wmrOp2hYKFk7/qnV+1lRupqaPVn3+F2fd5645jJ6XAVQw61pPgOGBWbp32WkQEoFEPSODD0UoVAuP/D2fYz8TOAy/Bf7YAffN3TfR9wuf27jaiyRm1BWv/oWRbDOSnuzyDc86FoWOsXbV8d6cDDA07yEUFb+VqMhMOfoJyu7/kxypq6ncmPJr6EoHb4dMV7GlaHBGr9HsqYXMFzuVdaavIfW6svIvn2rHpS6aVMTCVe2pt4p+0Exj7m2fx5rNd9FF6EbkekkIOrvUUna+LDCb4BdfeYU61WdQ5XtIOM5LBCf6X1CYS0FWy/FPYx0IyVkTieD+Ph4Ac0arPE0qu9ZDNh3yW7kfRlzNn29++CYRuBhGO/9Iu0hurWFZMnY6K7jOuZ/qAhba2vaAih0yjWqL2NsVym450jdhhHA6iqEoMHw7+okzCU6na2DJ3nHutWo7Uz7IyBKu5w44BaMu7zh4sVcKwHDBK5gbVBRG4qvnU0fAEsok9wF+QmvcHDx5rqb4LPxBvk41ShqsIpL0S419cCgr4Ic+xalLphKn9YtPTr4lO7KijZRF/oNf6oCP27gKk/co6/XxelL62jzKH1CeHlI3+ZCj2zWCIAuW6A60WgZP4DfovBaPnjoAPyHGJ7n9FkEbs+EkZjOWAG/gQP9sc7YzZMKpjDOeYTn4p8bRa7DWnTAWP90/UHT8GqcLMw0AQDoEHot2Ll7quEyInBL1eNKugoQ4Gtv7f1to9nJ+coS0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(1076003)(86362001)(70586007)(186003)(5660300002)(26005)(47076005)(66574015)(6636002)(81166007)(36860700001)(2906002)(4326008)(82310400004)(83380400001)(336012)(110136005)(508600001)(8676002)(36756003)(7696005)(356005)(8936002)(2616005)(70206006)(40460700001)(316002)(426003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 11:19:06.7294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 567c5195-5eeb-478e-d777-08d9dc06ac55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3133
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

Add structures that are used to cache registers offsets
for rlcg indirect reg access ctrl and flag availability
of such interface

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Zhou, Peng Ju <PengJu.Zhou@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 00afd0dcae86..286b2347d063 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -132,6 +132,16 @@ struct amdgpu_rlc_funcs {
 	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
 };
 
+struct amdgpu_rlcg_reg_access_ctrl {
+	uint32_t scratch_reg0;
+	uint32_t scratch_reg1;
+	uint32_t scratch_reg2;
+	uint32_t scratch_reg3;
+	uint32_t grbm_cntl;
+	uint32_t grbm_idx;
+	uint32_t spare_int;
+};
+
 struct amdgpu_rlc {
 	/* for power gating */
 	struct amdgpu_bo        *save_restore_obj;
@@ -191,6 +201,10 @@ struct amdgpu_rlc {
 	struct amdgpu_bo	*rlc_toc_bo;
 	uint64_t		rlc_toc_gpu_addr;
 	void			*rlc_toc_buf;
+
+	bool rlcg_reg_access_supported;
+	/* registers for rlcg indirect reg access */
+	struct amdgpu_rlcg_reg_access_ctrl reg_access_ctrl;
 };
 
 void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev);
-- 
2.17.1

