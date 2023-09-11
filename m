Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F8DCA0EC6
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Sep 2023 21:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E7CD10E1EE;
	Mon, 11 Sep 2023 21:47:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6542A10E1E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Sep 2023 21:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anaVT/5PJ7IxlnAX0oqyeoeIXwg4Adm6p2RLxeL0ezYnVivkG2ScHdsln24+yBWbI1fiyZHtoK9sJ1LsdY2yPZGPlyJFk8/pkN8AXwMHTxs6XFfEJ/aIOo5JMLQdamHVFNAhoFsILlGBtym9Jfp2FCDjDbf4B+NhQqtijTLZolEJj6MbXdVsXjz+Z7HTETVJKPPiCHfq84XkCWe3GmkIxfdv2TVddKGQU0iDxGrDowdO4pTbK4+QewLtT2fkXBAif3e+L4j3thC8+VOnL7gBfv68g+h6SZv2LCSeIm+CLy1Z4pj5j+icGasG1zwW0J4BEMWI7p38AfZBkNmVvQMbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu3YQKpkVZWa+IHtXODdLWvD9zWiO5CrKSDTnK6sWlE=;
 b=ON8+Jd7XvysNo25BzhxDsRL5CAl3q0Lk+FR7ucZvpS7LviojfZeURALwPyW0pJw1w83XlO+m4ZfEmZJEj/mmEEeNc6NAyg0X5lHa09NJ8fVrW3VE2ZIdR/Cct83Quf71CRNcD2Hb2aGBsh3Cnq6KDyfpV4vyBVREPf3PZEtmYylmtixJ4gdQNJUvwXntasZq0ZSogkC265vDHbyXjqWIqY5m5RmXJGbSYOnQHk/d1adq8hVDUgHSn+CT9xj5yTNZXEXanoGdj3cmBRDox8UPedYF177ambp9Z4GguUjDLThfweGGlWo5LuDRoYJbvAZESN0Ro9msyr1DiQGrgEtKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu3YQKpkVZWa+IHtXODdLWvD9zWiO5CrKSDTnK6sWlE=;
 b=jQv1BRV8ITe2DhLFD2wJLb4JYW3cwQ7zSUh1oFVlde0w0SgZ/1RLVt1EIdWbYvojHmpHQDMMYlUvCHXdo6ORvvGyy9aTf32vJIm/SsQvMyYXv2yjtI0xcuz+JZ7ToW+Oil1oC8ulbPjdv1gd3Fd2XBDx+5tuQKT2fqOmiCFwZLk=
Received: from SA9PR03CA0001.namprd03.prod.outlook.com (2603:10b6:806:20::6)
 by BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Mon, 11 Sep
 2023 21:47:14 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::8e) by SA9PR03CA0001.outlook.office365.com
 (2603:10b6:806:20::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 21:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 21:47:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 16:47:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add remap_hdp_registers callback for nbio 7.11
Date: Mon, 11 Sep 2023 17:46:59 -0400
Message-ID: <20230911214659.1074052-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911214659.1074052-1-alexander.deucher@amd.com>
References: <20230911214659.1074052-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|BL3PR12MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ccefe39-6999-45a8-6e80-08dbb310a90a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mi7wpwbqhtEE+HCg4Rb7dWX9MnUVvoyn25krFjoIBerYMP1q3nx8/8LCKU6+IyyuOMuDGsToTWkXf+l1Ls3NwaA3NtaiM5OFmviTMtrSTlF38LDzqNdOEtY4lmJDjUmzbmdCXSdoEizXXwFPrrwUifclAyWiiIiC+ndNUk2D6pjmGySb9z9FzlrTp996iQBMAUQDodLYSGeMUJOwlAoqBMeQ/v/QdpojFQxXPnT06VC+pjYB/no2J2xTc6ySLi17Eqdei0Ohn0dzVnCWPVF+nf2sK5slgKmQOJ8UdgRtKVwkNYT24oxbBHYymjGAW9yH3prkQl9zCwoB4AkTPag6y9pqyijL3sK6mIHNFEPlA0pCsP5bFcOqrecXOj4tgj9HFZ1PRJJLo+tTkQWBUWsOu74bQPjtN8XudXVJiZYS6v6XID1B6R0nQpaGUaP5gqWDT4CSTkn1mBYcF8kGo+sESLQJRCZTb7fPtnXxFEQk9lhdNs1Ze+A8jqDluAzIOBBlekHh7GKpAIzEIWtTV/Y4UYadVBtUp8RcD2sD9GlgQ9HDXRyfQHKLTzarB5JfAP21z9fpEPTZ6YyTKfKFvZGhxevbHlg6gogIDlkQOx0tZr73d9dhxSVRu4fv2YrAF7MXzC0dT0Mqkx68r7mwtQ6JGbeUTRFihUlVmKqeFJggQQW8JTNCEc1FauMpUMYFO9MdIuAJ+yRYCjYGgfV/IS09AxljYZfxDFDeXe8fJfuZdFFXP9oYWtA0Li7WXQ7qIdVMKHRXsawFvubfxTIujMQOoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(1800799009)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(81166007)(86362001)(7696005)(6666004)(356005)(26005)(36756003)(40460700003)(36860700001)(47076005)(2616005)(40480700001)(82740400003)(2906002)(336012)(16526019)(478600001)(1076003)(70586007)(5660300002)(70206006)(8936002)(4326008)(426003)(6916009)(316002)(41300700001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 21:47:13.9313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccefe39-6999-45a8-6e80-08dbb310a90a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement support for remapping the HDP aperture registers for
NBIO 7.11.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
index bcf5fb420fda..6873eead1e19 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -28,6 +28,14 @@
 #include "nbio/nbio_7_11_0_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
 
+static void nbio_v7_11_remap_hdp_registers(struct amdgpu_device *adev)
+{
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+		     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+		     adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+}
+
 static u32 nbio_v7_11_get_rev_id(struct amdgpu_device *adev)
 {
 	u32 tmp;
@@ -284,4 +292,5 @@ const struct amdgpu_nbio_funcs nbio_v7_11_funcs = {
 	.ih_doorbell_range = nbio_v7_11_ih_doorbell_range,
 	.ih_control = nbio_v7_11_ih_control,
 	.init_registers = nbio_v7_11_init_registers,
+	.remap_hdp_registers = nbio_v7_11_remap_hdp_registers,
 };
-- 
2.41.0

