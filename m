Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1412DC07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 07:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B7A610FB
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 07:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B7A610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D746E17F;
	Tue, 20 Jul 2021 07:57:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 539236E150
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 07:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsHZHXClDsyrtJBQ32MFoWKcLoY7XtFYtO2ULOVxPGIFI4B7WXIRYDgDZ0Z0BEwEifHrnXE/fiMlNkahLOYoiudGmFZIs566YfUrTBBSHt5L+MYmYBOtZ5juQZFfAVfBupuzfD5KlDTlGcX+drrH8m9Nm6wVyX+AcIOy/ZfgsEE4p5tNZ0y5dntppQn6rdt4D1NckngrRgyB/6WyY3FdrJPWoCb9kq8OS+93vsHRKpKji5SPXwsZiubWriWy7IXpmbSuO/nmjL5fY34n9TO9vhKZCsiUJM9lB4epEO6KeU0jJaQj/Hz+rN8ZZnNiP3R87U+tFsJjTE2EF2TkPQZQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/IIF+5NnFwoRvKBGKoFpZ1Sp305ZRCEgasTw4SySuM=;
 b=mS6J0X+6+CLFCO/I8NQRJhGiVKCNTDoZvfnDmKIZdLaJnwMUaJX6Z+vg5IUP3pkk23S3rpP6SAQE/NSXeiSDWN3D6F9kabyzhKgfjYBpI9oe3kxdz6sfkENuLkFXTMRYMr5JlRfEA4pRFbPdhpk9+fODK04H2I1NzUUBnmZX2H8AbkVFyVIMvy+Tekm1LCkb/MjzEBu/hhgjIwb4dqQq/avFmgxMJE05++u35qwx3OUwEf8UT6PHfnC/xwsJtmgMzJX6moCSop8jSfNnaz4tgik62qx59i14ovxL8FSZFe/Dypt7gKM8rNcEa+RTM6yy5HdON94PMZU/yBlaxrWkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/IIF+5NnFwoRvKBGKoFpZ1Sp305ZRCEgasTw4SySuM=;
 b=Hi49Aqq0vnyNSxnhCf+wzMiLZINtEGxiv8L+piWpfMPV8Mdj/Pw4kwbmJ2ZDn1Rf7zkTEhILbrLaXSOOPQEEyIydZqkB50S0SNa11VkgA9XRjVDG0YdF51hYeRaVDd95vnIFjl+qBPRGTc4VqRBnp+l0UefZRtxnCP6RhSbFIL8=
Received: from BN9PR03CA0463.namprd03.prod.outlook.com (2603:10b6:408:139::18)
 by BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 07:57:45 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::69) by BN9PR03CA0463.outlook.office365.com
 (2603:10b6:408:139::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Tue, 20 Jul 2021 07:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 07:57:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 02:57:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 02:57:43 -0500
Received: from chengzhe-build.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 20 Jul 2021 02:57:41 -0500
From: Chengzhe Liu <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Clear doorbell interrupt status after BACO exit
 for SIENNA_CICHLID
Date: Tue, 20 Jul 2021 15:57:37 +0800
Message-ID: <20210720075737.1583824-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3946a33-88c2-4eda-e4f6-08d94b540ef2
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:
X-Microsoft-Antispam-PRVS: <BY5PR12MB5544C771223FF0EF1634D97593E29@BY5PR12MB5544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W10MIVRvrTkiF/Dg0uofMoDOtS7lZy2XIweytkeAUHmOyB4fIuRszzv4FmVGMyJBWb7XQhs/8gvtT1YuRilVo6PBRjiQx6pfSgohYAM26tBer1Ji5V1bgbVATn4syyUkoZqhMB/iGvujMhEjwPQGGXwKqLV8MwCD/S6ThRwhZqqZUwlItg9xpSCxrlfIbDB2stETNErXiVIjupYEC5IY0DeckMcy3HqvdIZT/Vi/SboVFfVLUrHEk2UfSRbnTsvtR8PVmc8L5NqJ92AuQCC8uNTOO4nzkc48tqJ2zckEpPJAth086FbinOq4E8nGFR+Q6xP3GkscT/NOLkJzYnh5C3ayFtvzRt3xoJQ9sHXqyRXpQjzLr6266HXThyMNjaJ70FQr6TXhCoDFoPAEASfDzMKsYjRyoHZTEciNVQlxgzOvGnV932vJDVmqmv3DlS0tTr0m7RiWWlHTfs5OQ6Pwbmo2++uAPFKuGorOl7N+icLnDqJgzlnNqsNrE6f0dXjqONwB4mjb2cJ5OS24ZkP4qpDnVFzS2tLQw4rXsFVWHZweQv49Gzk/8mi7OGVl8QUcnjneHGEhoYG12STLnbuYuHiWx62jh8wn/yz7HJQHMGlOA2xZ0C7s9ynP80cBHwmy9/r668bNSd5+a1YJbCJ0yCHudD+vIl8WxmkQT7jZ2MAbkJc2LkjzU+O0679/p3zmJOvy/cZCPO6KlXiKWNYISuqwsOtyDlEk8wiAFl1g41k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(36840700001)(46966006)(2616005)(2906002)(82310400003)(86362001)(70206006)(82740400003)(5660300002)(1076003)(336012)(70586007)(6916009)(47076005)(8936002)(426003)(36860700001)(4326008)(8676002)(478600001)(186003)(316002)(36756003)(81166007)(54906003)(356005)(26005)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 07:57:44.9241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3946a33-88c2-4eda-e4f6-08d94b540ef2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5544
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Chengzhe Liu <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In passthrough mode, if we unloaded driver in BACO mode(RTPM). Kernel would
receive thousands of unhandled interrupts. That's because there was
doorbell moniter interrupt on BIF, so KVM would keep injecting
interrupt to guest VM. So we should clear door bell interrupt status
after BACO exit.

Signed-off-by: Chengzhe Liu <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c     | 20 ++++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 37fa199be8b3..109a76ca4535 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5265,6 +5265,9 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 	    adev->nbio.funcs->enable_doorbell_interrupt)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, true);
 
+	if (amdgpu_passthrough(adev) && adev->nbio.funcs->clear_doorbell_interrupt)
+		adev->nbio.funcs->clear_doorbell_interrupt(adev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 45295dce5c3e..843052205bd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -95,6 +95,7 @@ struct amdgpu_nbio_funcs {
 	void (*program_aspm)(struct amdgpu_device *adev);
 	void (*apply_lc_spc_mode_wa)(struct amdgpu_device *adev);
 	void (*apply_l1_link_width_reconfig_wa)(struct amdgpu_device *adev);
+	void (*clear_doorbell_interrupt)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_nbio {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 7b79eeaa88aa..044dc63d2e86 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -508,6 +508,25 @@ static void nbio_v2_3_apply_l1_link_width_reconfig_wa(struct amdgpu_device *adev
 	WREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL, reg_data);
 }
 
+static void nbio_v2_3_clear_doorbell_interrupt(struct amdgpu_device *adev)
+{
+	uint32_t reg, reg_data;
+
+	if (adev->asic_type != CHIP_SIENNA_CICHLID)
+		return;
+
+	reg = RREG32_SOC15(NBIO, 0, mmBIF_RB_CNTL);
+
+	/*Clear Interrupt Status*/
+	if ((reg & BIF_RB_CNTL__RB_ENABLE_MASK) == 0) {
+		reg = RREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL);
+		if (reg & BIF_DOORBELL_INT_CNTL__DOORBELL_INTERRUPT_STATUS_MASK) {
+				reg_data = 1 << BIF_DOORBELL_INT_CNTL__DOORBELL_INTERRUPT_CLEAR__SHIFT;
+				WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL, reg_data);
+		}
+	}
+}
+
 const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
 	.get_hdp_flush_req_offset = nbio_v2_3_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v2_3_get_hdp_flush_done_offset,
@@ -531,4 +550,5 @@ const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
 	.program_aspm =  nbio_v2_3_program_aspm,
 	.apply_lc_spc_mode_wa = nbio_v2_3_apply_lc_spc_mode_wa,
 	.apply_l1_link_width_reconfig_wa = nbio_v2_3_apply_l1_link_width_reconfig_wa,
+	.clear_doorbell_interrupt = nbio_v2_3_clear_doorbell_interrupt,
 };
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
