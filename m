Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139D3C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 18:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8186210E69D;
	Thu, 19 May 2022 18:04:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDE1910E69D
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 18:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyBNRxA/DVyU8949zGZh0rVj6SavPtkA1fTmDRSm8/C4rd3wGPL7ReGfyY0ciJqUhEpKZ52fRTOT0O+8zlZJIWwiY9NIhQwHrr6EUx0j1mE70q4kNepZ/lyIfurWcKdtzjhMzzBMivsU0tDrTO9OZcRy//yLmrFfbGagP7bKCthF1RDaXyN27W3QEbKhQlGzy+ExPel39cL9rpT3hh9By+FoxEPghKP2hroB5NuL/vfdQRUDMN/pU4MAnEFz7PeG/BojST8tdY/DzlpPGoPduU8yPKMzjaIdCQDQZr6LEVnx22F3EuOWeEpkNRonpjgpDMeQynlSIVbSO77lj+vV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldjiijv9eLsFkF2Yw1602d96x9Qi5zsunUkFL4ZDwKQ=;
 b=kSv2pKYNBWasV0oFro0lsUBbgnwrllg6Ks4VjiOCrlrKxApUMTtoMGszsf+fk0riP4uxD+qdn2UtZCE+iDpLLT+LhFBR1BbvteYbp0R123AcZG8dTRF7l7ZT/OFddl16ND94g1MpzaKDigAa/QMkYUK8/9x+XmrQZw8JM03mxGKAnHJdYHQ1aHp3JGxGEEtDHWtNLqIipZl6hbrQCdPamAFXXoOdi66kJezzu/Y3tDJaA09nuSic6j3pFzIMq2gsAytJq0aK41GgSBfSMdRXTx/kevdXQXujUfvJQHuFjB7swbiopcfhtn2CeY+yvEr19qLJ5iixsFWbMReHQTBn+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldjiijv9eLsFkF2Yw1602d96x9Qi5zsunUkFL4ZDwKQ=;
 b=VBSJIOk2qwvPIFngEPiAEP/u7ZADftPSkYkk6/QKPY3J67/Po+jIrSHtY2GtWHmbcZx66rHQy4udhMQeR+puaMefX4mNVpFgEkmjPf0gXPBSepJD55aK5E77V6Ieqba4ijnsyDhRaX0OE6lLql0Um5i536+kMJnYlGFiPQTJzEo=
Received: from CO2PR06CA0065.namprd06.prod.outlook.com (2603:10b6:104:3::23)
 by DM6PR12MB3164.namprd12.prod.outlook.com (2603:10b6:5:188::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 19 May
 2022 18:04:18 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::45) by CO2PR06CA0065.outlook.office365.com
 (2603:10b6:104:3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Thu, 19 May 2022 18:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 18:04:18 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 13:04:16 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC] drm/amd: Reset ASIC on GPU resume failure
Date: Thu, 19 May 2022 13:04:15 -0500
Message-ID: <20220519180415.32456-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d6f52ee-c082-4d36-5a14-08da39c1fe6d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3164:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB316405558305EF328843B5FAE2D09@DM6PR12MB3164.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQFRWNg5ILOpiLNZpPNx4ClWt/nUdzfPuGLAwe45hFKY067cw6RwIN9/3yJuXrImnleNrqSMLwPQytXwNAO3Z1oocvW9o8gtDGy63l8A4BC2H7nHbbeUZNMCdqIS6mmyxaIzpvtWaaxg1Mv0LjDVFINuNPTU66b23fuyFecCdMJZKxi1F4ddQSdFyk9C/eUdeh5UKyXadyGV4u6ilJlSB+TMmm1v0XdzqbjRn9NEv3UXRInbOpEPuP1ZgFHT6cIk0fkrwdV3N/BYCgNc4Z5+5GxNHITpgK+QwzGiO48HZLuqM6z2zHXLyIbgoEV8Yf20uEdMRF3ouIkbBcOCeK0I8TKMAM4KXaY0PMH1OP9cFyCxaCgOEbGJ7kfSafCkqh/ylvbA8oEx1G6LHUxvn17ejc6AoltDSFpexEdJMmpCL9U7THlVQMYnPp7V0qEqIQ1A1rgriFdRV2bZy/YijwA6DXZ7+oIbPkOKuSYEVrPDlBsI4zba8fT8WxWIfpFUE+3zRt4C3BARFzQ3ZoP/fFiB4BKBgpWE9mwTC5zSfpWysBq2L6L/aaIRmTeFNdaDCYgJLnukYl+L3vQLNztKirPme/Dvl4pEUqYq6Y/csunFm7tKNIosD++84RfWo4MBwaQFnMadI9Y3zQooERWfnxzk9BI22syXpaYInOOspv9ErKayH5TAOpgwJjXbnlHfgGubfM3hr1MGvVEgUPDo7WsqwiPtmaNmzGIcLwy7luA/V66UVZG+hP5Q6boMypCJPNiSkTqFUkBZ6NxDlX5vWpsjBBSYLRAG6OtQ9+DrTMrILh0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(26005)(36756003)(83380400001)(8676002)(70206006)(82310400005)(4326008)(70586007)(36860700001)(1076003)(40460700003)(47076005)(426003)(16526019)(336012)(186003)(7696005)(86362001)(508600001)(45080400002)(2906002)(5660300002)(8936002)(81166007)(44832011)(356005)(316002)(966005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 18:04:18.4366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6f52ee-c082-4d36-5a14-08da39c1fe6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3164
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Is the resume failed, it's unlikely that the GPU will be usable.
Reset the ASIC in hopes that it will be able to recover from the
problem.

Link: https://lore.kernel.org/stable/MN0PR12MB6101FA3FF375A961E67AE89CE2D09@MN0PR12MB6101.namprd12.prod.outlook.com/T/#mf90fc5d39b02d4cf7d430a49d3b58243083042a7
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
This is RFC as it's conceptual, and we should wait for testing
that it actually works.
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3b9dc1803be9..4c2a0aea5a6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2333,6 +2333,13 @@ static int amdgpu_pmops_resume(struct device *dev)
 		adev->no_hw_access = true;
 
 	r = amdgpu_device_resume(drm_dev, true);
+	if (r) {
+		dev_err(adev->dev, "resume failed with %d; attempting to reset ASIC\n", r);
+		r = amdgpu_asic_reset(adev);
+		if (!r)
+			r = amdgpu_device_resume(drm_dev, true);
+	}
+
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = false;
 	else
-- 
2.34.1

