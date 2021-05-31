Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F0BC47080
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 15:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DEB61263
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 15:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DEB61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 010836E16D;
	Mon, 31 May 2021 15:51:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F0CD6E16D
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 15:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhey4M2qOi9TCBXld49Bm/Kh36MLAMZzs9Qag8WSaDbc0f1pk7n3nALdSGkXSSWw4lUGhXw/u54gxtDECOGj9Q2LYCWzd77Y/QtaLrHtu28ppOnPZGqDNXxIV/zgyANmZJMqWowXtsv4DzrHyvFlb8O91dwNYPhCfdn590qLkl6ie5IHcLgdeWv/whLHd8o6RP6F4VGzha8+ejjU6EPCCxcjDehuwgeeFKtwti3jvIaSi4wbkBkc0KdvZNDe+Wcm2FQLy7jXY65++lh12YszALUxUAf07T04z9FIkJm446SZo252cMRYc2xoDkBEWVvPlKh6kFWFoxWAKkRGYRDkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j16EU7b0dr6ryZD8J9L8PTB9NklIW1iDSZmz8pTmJ8k=;
 b=MejEquD9g/gJY9H2nHHBnEpXnepvFzkKqTJBei3FKzD33EaS7VZXh0HPWsSVh+v0rFKn09GmU9rOiHvrlfGEGVMcBkaG4NGflnRTxrS3SriZBLvm0tjG91P1dnbxJsPVOvzWwIkDty/gFZrsoHxnT2fmgLTVzORJtY8fqDNE6+sGTTZ6TczAqH6c8Inki7Plqg/pi5blqzVsXlPz2vvu4XvpBdD0BYpTyYvBWJmXP8je5UFABiDh/n3osn9FU9uWfc2ikZ56ZL7Agm/XZ1HofFHaUUncuSk3RJ09e0yuSF5vwcu684jT8uG4kDd4IURgOBho8Cv9/q40qgQ3/ELGEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j16EU7b0dr6ryZD8J9L8PTB9NklIW1iDSZmz8pTmJ8k=;
 b=F0aOAGTF90G70Bf7FLaVBwyWRR5LWueZJdDRKf/MTEdYCryQ5WPAzZch1PeVWnA61c1Sn1rWjkbWYoNXLFwdHXXD21vp9d7WjaIwdZwVtHLhbME39ts0/lYumoZQa+5LgcxyXDqR3QcUHlEK2Uy3CLNAdqasEB2lc7C4sPhDqAg=
Received: from DS7PR03CA0191.namprd03.prod.outlook.com (2603:10b6:5:3b6::16)
 by DM6PR12MB3369.namprd12.prod.outlook.com (2603:10b6:5:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Mon, 31 May
 2021 15:51:22 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::54) by DS7PR03CA0191.outlook.office365.com
 (2603:10b6:5:3b6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22 via Frontend
 Transport; Mon, 31 May 2021 15:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Mon, 31 May 2021 15:51:22 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 31 May 2021 10:51:21 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Don't flush HDP on A+A
Date: Mon, 31 May 2021 11:51:06 -0400
Message-ID: <20210531155106.496427-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59ecb08e-d046-4f8a-b6b1-08d9244bf0a5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3369:
X-Microsoft-Antispam-PRVS: <DM6PR12MB33692D57C20F0678DEAD6A0E823F9@DM6PR12MB3369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +VHQXtk61Pa1XqaKscLTVOxUFkmAY8oYdudI3AALmPfdIxT6L/YehG+NHcGhTunEwkRoE5MiMEc/MYIOseEBuXNFpY/xl/XsyoQlRMr1ORYvh7HdkrpJKgSH3Iofl6BtdwKKPhuMXglU16uawPeD4kHZ+Q478M0vhgFukrt8xilhJ8Q1DEksxfPX7V2wS+/3KdZOqXLI3+Xf3O8BNpXfDCvYSiWJ1Ico4J1HGIHpDu22yoxTtHvnJpEkkdTptottxwu5VTsZ2JSUbNJYxcVXEKrI36hlN0A8AQDkakoPYxAwSfAd/BiaJao1KmqXaWWq3C9m9hkaD4INsKEStT5dErPnCOdq3RkvtVKEg0wFCNqAqi3PVYDWU8fMqM+4136DE9TcNTGyzvogb8tm7Bg8szesUIqKQ+Gbiu/x1WY+jxlUdtfkxu2jMLPJgDDncaiOAD1IdHGADSjfbhP/GOdnQHoNedTOUY6QDwStOGi6+8lO9Uyep/+APfxLffMJXQg5oBeUm+uj3mw9F3IdP1HQJk9lsZ9ELEnIZQJxkhoCsQ3d4RVxFlPUkl5FkhDbC8VHRE7IPSQR7/Vb2IBUnaHwP+ewYKtcH/jwu6M1eGBT35Dik0EIZCiv4fDXx0mBinPAhCgLfi83KrTLytZyPko/A/Bo6iAmLSwlQRxoQWL0yrvYMKq7hhIOhC3kiEmgjIby
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(36840700001)(46966006)(5660300002)(82740400003)(186003)(16526019)(6916009)(47076005)(316002)(336012)(6666004)(36756003)(2906002)(4326008)(26005)(36860700001)(8676002)(86362001)(8936002)(2616005)(1076003)(426003)(82310400003)(70206006)(70586007)(478600001)(81166007)(356005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 15:51:22.7145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ecb08e-d046-4f8a-b6b1-08d9244bf0a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3369
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With XGMI connection flushing HDP on PCIe is unnecessary,
it is also to optimize memory allocation latency.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index 7ec99d591584..1ca23f2f51d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -44,6 +44,7 @@ struct amdgpu_hdp {
 	struct ras_common_if			*ras_if;
 	const struct amdgpu_hdp_funcs		*funcs;
 	const struct amdgpu_hdp_ras_funcs	*ras_funcs;
+	bool	no_flush;
 };
 
 int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2749621d5f63..6e1eab615914 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1223,6 +1223,7 @@ static int gmc_v9_0_early_init(void *handle)
 		adev->gmc.xgmi.supported = true;
 		adev->gmc.xgmi.connected_to_cpu =
 			adev->smuio.funcs->is_host_gpu_xgmi_supported(adev);
+		adev->hdp.no_flush = adev->gmc.xgmi.connected_to_cpu;
 	}
 
 	gmc_v9_0_set_gmc_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 74b90cc2bf48..e1b2face8656 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -40,6 +40,9 @@
 static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
+	if (adev->hdp.no_flush)
+		return;
+
 	if (!ring || !ring->funcs->emit_wreg)
 		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	else
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
