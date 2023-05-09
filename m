Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092EBC77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D6C210E40F;
	Tue,  9 May 2023 22:11:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 426FF10E40A
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:11:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlTKI7GRvMkXAsaXpCkD92Q1jvKUkh3dXQ1Z2gsZ1AuZFA0EriZC+Aflgpec8ZjxsNKDeAjPz100LrkhJm4yLYGdKwm1Fm9H0jOtF/JPOx76SpEW0p9z9PNB46DL/68tMMmliHqrXjqii2EBFwSSH8jaAd2FMqWhkh8og69XDxWy5UVNAWFWu88tiV5NdwZBqHtLgycxWaK5IGgg8oXnEZomO0Qk1NXj5kDEs1apvbyw2Kog5gk6pQrox4uhk2Qt7OfdTTpL+E3msPpM4tFguz15f86gSBpsvw3SwknlglZ8Vicug51pVLtQAwd27AkKAKHGLhsH2LwQpZ84ccm+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wo7uAURJKPcmXfleV5qjnR5JKG6gcrBbmEJXFc4o2ls=;
 b=I5x+GiSUPr4Ry317GpW2SlBd4POiclSuJkQLpUpeikOQrvwsCekItyTI6njsL5ZqFYhY408boORR0FcBI+PIGBvFaMV8Ji0rWPY6cN/TN+0QnFvFRzRgVwno7P8G9nesNWtvyEpJma0ADqf3IXwBXo9MH33dooHAd4rJoIJnzUpvMUiyTVp/M3njiwwY+ASJ/CpvaTezwda4wroUHSI7zCzb5W3wC6Fi5mvQTRMSy3DOQzjb2K1w8LpDvjEWX1Sb+8je4ymjrfs9hGcGgNrVyw0KBhrqH3/I0hXWs2PgmEm5cz9YKF83xe5+q2TS2RTkXwYJZbUcWPjk/wgtMFFXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wo7uAURJKPcmXfleV5qjnR5JKG6gcrBbmEJXFc4o2ls=;
 b=HAw8b7zU+c16adrJwHtvWQu2N76DBj9xIscKFa46+WNue+T+yMIuSi33UkzwTkJzsk3dfa3A07a5vCpPs5VBI51ICKOQHHaIxwQkYcyueX5NahBI2txM7uE0eragCXZnvFExjG1929frPDLbTathLeSPiQSXNt9YGEu/Wy6gyQA=
Received: from BN1PR13CA0012.namprd13.prod.outlook.com (2603:10b6:408:e2::17)
 by SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:11:47 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::99) by BN1PR13CA0012.outlook.office365.com
 (2603:10b6:408:e2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:11:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:11:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amdgpu/vcn: use dummy register selects AID for
 VCN_RAM ucode
Date: Tue, 9 May 2023 18:11:22 -0400
Message-ID: <20230509221128.476220-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221128.476220-1-alexander.deucher@amd.com>
References: <20230509221128.476220-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|SJ0PR12MB5469:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fd83c8-66ae-477c-6e41-08db50da618f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPw9BuEtiWJNCc6jj9QHPMh3zA+YA6u7IZ3wN/Xx3EYu4K96pf2FWcbp40BRJYrkTkKGzprodEiSj0FXqBVHJuIYYkH+K+igBOnWfqZwPY70/81NPsKjXwRNtELmNLKHmy1tysC7zoHGc9qotaPqEJPIEg/lT7xLVLU4DCvoVA6h8i+6WLFSqPzCUzi/TvHqaeB1iccFPUYLe4MmdnSnzUWG4uX/8MebwKYlCmMduGkWm51Sp+JHOzFw/OEDMwnOpJKoyNVndZ+G5nv5wLQnX/8XHbS6Y3caHPaPCo9R1Te5Cobt6X4MEbvnrzO2IXWtub7xKBdZeKF8+V6nstSfxShi2boaEQu8SNNVaBNxnpLVYm6mdOOBmGf45vi5Z2Hjbc9dqF+ayaM+qj//pMgjZJop6D3y1lRKb8nvN0Z2mNki/4thdYzl34TEB4dI+dPwBB3gqHe95EBxWhdVybzJQ80RUhebxaGnr0Ie5xOZNoLnKjSsidjos3GPBEIkJ2nrlqiBU75aw5RP6z49xGC+5VWZFEIZvdvyMuQvvrf77w+muelk2hDhN7GJMPsYcNb12b0ELAc87wrTCUo0tDJt7Rya6cRpT9vwqGVFwvYp7f1srr258Q/0JTHtbrNjWF+LsYZXxoAZXdvm1geZRVjq3evnX7bh6RhIqwQXdEmRIpS0NrRu+RpflcSoKlN10fUtD3XbF3ngE8QYZ6XKKJHrs3j6zDQmLrZ043dDh8nrHpA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(316002)(54906003)(478600001)(41300700001)(8676002)(8936002)(16526019)(6666004)(2906002)(70206006)(5660300002)(6916009)(70586007)(4326008)(47076005)(1076003)(26005)(40480700001)(356005)(186003)(7696005)(40460700003)(82740400003)(83380400001)(36756003)(2616005)(426003)(336012)(36860700001)(82310400005)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:11:47.2627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fd83c8-66ae-477c-6e41-08db50da618f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5469
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Use dummy register 0xDEADBEEF selects AID for PSP VCN_RAM ucode.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 49b07843efd1..759f64a4acf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -681,9 +681,15 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 	tmp |= UVD_POWER_STATUS__UVD_PG_EN_MASK;
 	WREG32_SOC15(VCN, vcn_inst, regUVD_POWER_STATUS, tmp);
 
-	if (indirect)
+	if (indirect) {
+		DRM_DEV_DEBUG(adev->dev, "VCN %d start: on AID %d",
+			inst_idx, adev->vcn.inst[inst_idx].aid_id);
 		adev->vcn.inst[inst_idx].dpg_sram_curr_addr =
 				(uint32_t *)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
+		/* Use dummy register 0xDEADBEEF passing AID selection to PSP FW */
+		WREG32_SOC15_DPG_MODE(inst_idx, 0xDEADBEEF,
+			adev->vcn.inst[inst_idx].aid_id, 0, true);
+	}
 
 	/* enable clock gating */
 	vcn_v4_0_3_disable_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
-- 
2.40.1

