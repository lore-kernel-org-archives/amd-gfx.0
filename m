Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93874CDB483
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 04:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90E6F10E0A6;
	Thu, 19 Oct 2023 04:40:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E51E210E0A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 04:40:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KT3ZRS0oGm85Cg3B7jfgBwLDOGieVlkQZYXcCAA/72LK+EtZ9sLzz5CDpGi1pjmiaIvYuCkr2c0qzkdmUuwnXpw3RBnEjGSaH6geLEh/7PsN++ZwPJJhJdttKkXcZsyrlYh76EJE4+ktKXf6jH/OpvWJAwaIqslyWUnEtb7kEz1AxFYI/lCMcljqXfMTi/9N9/JKyjjTWWW8oPNOkIVb85myTNF+Oa5vE9FN2V/7oMl1p6RCmfP+vMaIFauan8d46yGeDw7GA+NAyGH3/slnFoclKm6yfhfm33mrBL5QjavuptdO3evY0QIRq3iYnWDE616AgnksIMFdjPxHhYdfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwP099Z7pLpTNN8YuXDoZQxxVI9Ug3+/fK8bdjjtKFI=;
 b=jpQvojojrwIAu8trfEB4XA/rn6MLlRqMx6j0AxrqQVB8RTZn7OZ7ULb/VLd/mU5vOX7Kgixgw8e0qIUFKgjoCJZdIzwbadlcv+HWL3TUrvn6aY0erEszisTvYbW3+i3zNB91K+h4xmnsCvT4PTLZ+Gr1oUp0xdbkzz3gM1mGQJ/O/LBAqWjIR9dRzS0gALI9HKWMKGq3hbK0gaK6K026zLXpMMl3D36s61v/aTAKekwIthr4WFQIhk09fwLL3tn8B1hjd+wxqbGc34sMox+W3z5S33ump58RmUUzuO8iDct0NHlSg2w4IjyUzLqNtkFdvaZfuGoeWcVpLiE5DQhlOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwP099Z7pLpTNN8YuXDoZQxxVI9Ug3+/fK8bdjjtKFI=;
 b=R7R/hyFl1oWSqdb5IUXokpfRIaAiO4DM7nOY5DQ75n4y6Z0YnsuzM9iBN64xdz19SrM1jfRcpkuFjnz2dcKY4JdKzpCEcQxnxg+/t5fTSx0ZWbZfMbLVmETTKBmBd7zBv2p05fiku5Ftlm9S6pMFrRcLIdSx98KxfdeNVhTLlFc=
Received: from MW4PR03CA0234.namprd03.prod.outlook.com (2603:10b6:303:b9::29)
 by DM4PR12MB5134.namprd12.prod.outlook.com (2603:10b6:5:391::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 04:40:03 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::a5) by MW4PR03CA0234.outlook.office365.com
 (2603:10b6:303:b9::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.37 via Frontend
 Transport; Thu, 19 Oct 2023 04:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Thu, 19 Oct 2023 04:40:03 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 23:40:00 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Use discovery table's subrevision
Date: Thu, 19 Oct 2023 10:09:42 +0530
Message-ID: <20231019043942.199561-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231019043942.199561-1-lijo.lazar@amd.com>
References: <20231019043942.199561-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DM4PR12MB5134:EE_
X-MS-Office365-Filtering-Correlation-Id: d31a8252-5167-440d-a22e-08dbd05d7603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iL2qPa4FTMwJ18JJ6BHGi/ihL+/ucXT29MsPetCwU9mFopvBMq4KNxQtYjsIammKy3semxuE9MTK2pRKwpzyaHqLb6QfV7cGOsB+HOqrv/AX8B3AloB5OJN84+q48t/s2+3aqinG3AhLR12teS4ze4Kg/iHobVPJE9wFqD9m9llGiVaN5NRLbWOjH7jdl8wLqo8V9I6sM6FffvDvQr6Qx+UuM+hjted2aWKcl0xaf2mbx2dy8cuj+oSpQWfus/+6kuLadbqsGTpi8BeFYvZXNy1S7PM0vaIxxmddeg4RVkeIavWNjeblaIVGKgQKuu74WpAWd1bK77KLkH7OR7h202XRWhDghA2pf6HPV5ml7WPZixUm2wbTDxTIpiYRseZeW2HOMvGm6k3a80xG+eMbaX8zvf88LTkOpsumogKjfC0dDnDofnRP019Pk84qisf5ai2duAOll9ERhOV8AvCez8Wm7+zLU06vCYIbih/ON4Ebwp79drV+jl+1Ns4Lop1kzj3D/71m85hJyTTIKq2F2GpxZBTwmwLNwlmd67lB5jv3XGrl0L/8ShVE15eU+tssDZKYULdF1LzpCEvrzz1GSvvvWWAx9nl/Tew8Gj0JZdSecCe01fMGVHHiFvXkxozT+Ml5ywr7OkFtt7OASd7jnPDjLgHcztbacUSAtaEwE/AflBRnl16P+0e4pSDO7UuWShxS3KYycvafovh5oCmebYwCNBpD7nJUm7VQx/6fANNeALfDjRnz+OEiprDfN9YA5FZfhxHSM3N8NRl8tv9xZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(4326008)(8936002)(40480700001)(8676002)(478600001)(336012)(16526019)(40460700003)(86362001)(426003)(1076003)(2906002)(6666004)(26005)(44832011)(41300700001)(36756003)(47076005)(7696005)(2616005)(356005)(36860700001)(83380400001)(82740400003)(81166007)(5660300002)(6916009)(70586007)(54906003)(316002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 04:40:03.1823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d31a8252-5167-440d-a22e-08dbd05d7603
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5134
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
Cc: Alexander.Deucher@amd.com, Le
 Ma <le.ma@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use subrevision of IP version in discovery table to identify SOC
revision id for NBIO v7.9 SOCs. Only newer bootloaders update
subrevision field.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index eccb006e78aa..23f26f8caad4 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -56,8 +56,15 @@ static u32 nbio_v7_9_get_rev_id(struct amdgpu_device *adev)
 {
 	u32 tmp;
 
+	tmp = IP_VERSION_SUBREV(amdgpu_ip_version_full(adev, NBIO_HWIP, 0));
+	/* If it is VF or subrevision holds a non-zero value, that should be used */
+	if (tmp || amdgpu_sriov_vf(adev))
+		return tmp;
+
+	/* If discovery subrev is not updated, use register version */
 	tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
-	tmp = REG_GET_FIELD(tmp, RCC_STRAP0_RCC_DEV0_EPF0_STRAP0, STRAP_ATI_REV_ID_DEV0_F0);
+	tmp = REG_GET_FIELD(tmp, RCC_STRAP0_RCC_DEV0_EPF0_STRAP0,
+			    STRAP_ATI_REV_ID_DEV0_F0);
 
 	return tmp;
 }
-- 
2.25.1

