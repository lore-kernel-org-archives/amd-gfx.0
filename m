Return-Path: <SRS0=y248=KD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFBBC433ED
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6587161354
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6587161354
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A1D26E87E;
	Sat,  8 May 2021 11:52:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EB636E87B
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 May 2021 11:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6iM2Q85pTJUnLb8MMsjXRJHxNNdbvB1XkDV5CAIVNQNdPHM3QzSX+9TrqSdjWXf6QJfFKyyZYZ8zLd22PdIeLFupAg4JeJTi0EsJGAYG0xDB7Am7nf/YQVgabybWDcSUX4Hnz/W/Lo+otRsCoAFzUHSgm/o2Hz7mzyy3s5909jkqUvFIFdaKk99sE/qLBkV1NWqZD8ltzIVVAMRlvinZvCTyqZfm2++fKmVXCno2PGxYpWPoWhmn6GZ/PvnrvtRIAG6lJ6H14BMYLtIvfJ9VIQAAdsjoMqy0dKpjeSV94zN0/ekhrevpX2sshCBpr1gwKB6Rq2xgew1rbz82Xw8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0e5XoNaQYWs4uv4dMuzHgz0URl1+L/usdFdm6JEf40=;
 b=mGTVEOVxYvCvcS8hIhqxkLRTMCWgJDAbCnYPlPhvsMGlyys51YgIiliS60wAGZ2W/G8cnkP6W4URGpubfNThTc75A3dTQrv6XBg9MJcmnVBLotztu4Q4S+B8D1RzsjFqxD3V9qYcHsTE05cS3YiyuTut2yPNvkpENUfao7jSNeLJzHoPRuYNb6pibBTqrI9TRWk99mTAHaWucrB/dFWV7PCFgbe+8KR/5aFpX+21LoS8iOmD5C52zIOw3+1IxcQWH1zxVbUgx78SnC4S8Aq4RBF6C0o6qxdGSKn511YhUeiR7QNgKUBFJFlp3uJwiIg9+scV8XasRWyGw0QTMlDP1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0e5XoNaQYWs4uv4dMuzHgz0URl1+L/usdFdm6JEf40=;
 b=MLT/D4kw0YCIVFY7ZqYXbx/E5PqFhbKVeP2Y/gfU2iyy8sCoT6jfzE2giuCPspfoMODVVDtXaBE/N3cV0l45NoJQMKGVZNCp2bU8mBXU9Ma4AycHCTV/lFVcJSXNDqT5JVX4wcTr/Oqhu3iHqLuS8vpLt2CmbjgcQEi9RW6Vh2I=
Received: from MWHPR17CA0049.namprd17.prod.outlook.com (2603:10b6:300:93::11)
 by DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Sat, 8 May
 2021 11:52:00 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::f6) by MWHPR17CA0049.outlook.office365.com
 (2603:10b6:300:93::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Sat, 8 May 2021 11:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Sat, 8 May 2021 11:52:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 06:51:59 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Sat, 8 May 2021 06:51:58 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 06/13] drm/amdgpu: Modify GC register access from MMIO to
 RLCG in file nv.c
Date: Sat, 8 May 2021 19:51:38 +0800
Message-ID: <20210508115145.758-6-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210508115145.758-1-PengJu.Zhou@amd.com>
References: <20210508115145.758-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eada459-5b63-4569-316d-08d91217b063
X-MS-TrafficTypeDiagnostic: DM5PR12MB1883:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1883FE5DC595D08B77B39671F8569@DM5PR12MB1883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMmDQ5BUlKznOe33M5NDHRbIUxlLWt3LnDoWndjGFrpIdlGUcM9TVF3xwCm+S1PbgBWiZklTn4qSeVUdoKvNj8SfbRdh4wUETh//MjIecwX0Kby+UaykPFuwTDVQU0iRTbHWFY1o861xY8+FrYtv62qq64UJVAO5VsZ3TDY7bW9i46hS6ZiiP5tCBAGEiECb68CNm1gRei6cnFE+fVTvH3qdKG4HF4eOYG36Xq1AOonI0XdxK0/2/PRzZ5qX6MxezaR/pgi0FWw84LuBYKDQIJHf29V9F5jiN0QE5JRC4HGvePwZaCTBCvnST2e/F349qa6ydyriTuCLDLq4jd0aDKBVgfDP58aUBIo8YWgJdw/Xlid7hz2XrzukdVDWgt6CiCIguvV2eInnPY9RmZkjuMO1XkZ1YPOpRsE7D8yI8FDYtfp8/lbcOrnPcGzFKuFyqjJGatVAPYMuPnf9QJRKoI7/I+vi/uKkpAhM/jgW/bwvCOw8jTk3WfA7bYqLAgN6sb/gw5t1uiJb7j/9HgKeT2TEpE7mAOD/2CM2Bx60akoPmKrvzAUa0Olw2yRp+KeQGISJBfg/+wGok6AT7Scy54+tPNkvNxh5g1lOw0rnyIdsBdVuBDqeHdHD4Qk8aAJb0adrBE3GdmUE+HrOQ3lb+C9Hj1qgysqqfAsmrnSmACX35yByVCpGDdkcydRn07SV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(396003)(136003)(376002)(46966006)(36840700001)(70586007)(7696005)(478600001)(316002)(36860700001)(70206006)(2616005)(26005)(356005)(5660300002)(186003)(81166007)(82740400003)(8936002)(83380400001)(36756003)(86362001)(1076003)(8676002)(4326008)(426003)(82310400003)(336012)(47076005)(4744005)(6666004)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2021 11:52:00.0785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eada459-5b63-4569-316d-08d91217b063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 82a380be8368..f2f0caf560f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -363,7 +363,7 @@ void nv_grbm_select(struct amdgpu_device *adev,
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, VMID, vmid);
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, QUEUEID, queue);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL), grbm_gfx_cntl);
+	WREG32_SOC15(GC, 0, mmGRBM_GFX_CNTL, grbm_gfx_cntl);
 }
 
 static void nv_vga_set_state(struct amdgpu_device *adev, bool state)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
