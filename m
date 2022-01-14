Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3692C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 15:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE1B10EDB5;
	Fri, 14 Jan 2022 15:02:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 717C010EDB5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 15:02:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU8LNy4RnnWF+uB8uweFOvJ398uDnfjLj50zx0KWlxerdfb5MTzSzVVyYsdi7bFGfB90lCfw4NkURWA1tA33NqII72Y6jAueqlzc85cAOmMPvy9OligjGudc2NVul7TGLSOV/mIiPj9gTM8UWr+jOJ0gbbh/YL6qDCZkrTWKK+5jOJjOqdS7n50TTCIFqKdOfqDU3/pJ8pTFlvzHFNgVgvQMMP2xCpAA0T4eFwDSDHPHjCOKDWcccnR5T5PoIj1qs8y5kfgHTkf5mPm0SJK9Nln/1DTF+wS8+bRIaXBJVKfvm8Kh9Hz3hK+sncwh0wRSv9hayVX/kVi+AGjTodAqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhJGQrBz/Y6DyerqR92Do+MEg7Kg0hkvem0R+5Xjxts=;
 b=WWzbCXggrGg4ozTD9SiHgAve9CBnPtQXFUrey0OPKNKA7K0DtzMCw+reveRELD+tUii45uGigcm1PZISxIwaR94BuuQJTDfuY9NJjUG8TPuT132e4I5sIxsWtOMWRRFi00uxV4fMwR0rDJd4leXU6RccL4JoizNgbATDrDiaGNR8dZQDiq/4rcRBsT9pG4S7WzqGLEhdkeQc7nUJuCYXClksW8CQnTWmz0QtBqYSsAAOkJ921ZfOdVLJ673hmg2YOUMYDRuzs09KFgkKGbV/yA1H+G7YZfW2c35hxkHckyuWjH+QoUttCdiuOxkuD0ycP+P/v2iOBeqcipboV3NjLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhJGQrBz/Y6DyerqR92Do+MEg7Kg0hkvem0R+5Xjxts=;
 b=Lirh8/7VRXzS5oKl46qUFjz023+HpOAURXBqZGGrK4ZYDH+xPFdsXxCc7YIA/08ogXGavBqjm85hm2SKEMllb7mDI9E5vIeB723Fn9CJdeEHetYSIEynHOdozJHPTPRYLvKk8QLGpqOty2D8Ntn6AR4ef0yhrykcEGihHv8o4bQ=
Received: from BN9PR03CA0901.namprd03.prod.outlook.com (2603:10b6:408:107::6)
 by BN8PR12MB3538.namprd12.prod.outlook.com (2603:10b6:408:96::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 15:02:53 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::c0) by BN9PR03CA0901.outlook.office365.com
 (2603:10b6:408:107::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Fri, 14 Jan 2022 15:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 15:02:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 14 Jan
 2022 09:02:53 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: drop flags check for CHIP_IP_DISCOVERY
Date: Fri, 14 Jan 2022 10:02:40 -0500
Message-ID: <20220114150240.1008818-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7512371-01a0-4ce6-6f13-08d9d76ef0dc
X-MS-TrafficTypeDiagnostic: BN8PR12MB3538:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3538816938A071FE7EBEB8C8F7549@BN8PR12MB3538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVkHY/I4C9GakrQzwtF0eH/lYZt9gkQ7OtWAGRNTvEfd9Ox0X0Fm0T/w1r7Rja8sqAq03iDWfcFoBk2w/bvwFsdPeIBdwRyZ3w7U4X7xBhQjtp16/+lX5nfyXpBcdvVb293NmX3r1FapaYhD678BegMO2sH16QfzNLuCgjpZ25fN06xVlDlKfyXDAHKhwIpyW5XDbTR9h+dXsdAtIP/eKPsAYgUj9AOBljuSbeltCLBVJww4bliLxCCNXXFADuN4TAY6vM3g2WXGz2f00pUkqGy6R2si/g6hZFsdqFS+/nLL1t7rfXwzsvuuYGYe0O92RHH+rRJgetI0SlGPnpMS5uQ8EuLJ5RpF1b5H/RQ7B6EMOxrwJM23qSC5Ug6XWDh57O+VY/3yHNuGWjHtzXkSAOkqRHfWFi1YJPd2/ggeziYQJet2eJlO27RnWfh1Q+L8NMfm9NhhwBp0qvZWjSPmencDlgGAdcjZL42VixQuEtRR69i5/TI979oAFMkM+HgHnwHx+tS6XnBdibyA+37N+0+f9MDcxIvxAjMCfLD2Rt3RXc0356MoOTjvtVq/TjHo7k4ICQuU0oddhJ/w0dsM6Vmc667gfRWmVnKK8MoaHJicmW5CBbJzvgFUOcpkqhCVY028SD8MVnI1FvLf1mUuOa+liQgaXADoPN8KdebxFwh9+uhs0opxyrOH6rjlYnsXnzQtD3SFIeRntVo1sECMyCSCK+MbBSuMGfy+Qp8c/NqhWyKXCRopDBqD1+AEURuw7ryM0R6Kiu5Z+icD6ee7UOxR/U8HJjGkuavOyVhhj60=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(16526019)(2616005)(1076003)(336012)(8936002)(356005)(40460700001)(316002)(186003)(7696005)(36860700001)(81166007)(70586007)(6666004)(70206006)(4326008)(82310400004)(8676002)(83380400001)(86362001)(508600001)(36756003)(26005)(4744005)(426003)(5660300002)(47076005)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 15:02:53.6519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7512371-01a0-4ce6-6f13-08d9d76ef0dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3538
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

Support for IP based discovery is in place now so this
check is no longer required.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 224d073022ac..25e3ed351fd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1903,11 +1903,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			return -ENODEV;
 	}
 
-	if (flags == CHIP_IP_DISCOVERY) {
-		DRM_INFO("Unsupported asic.  Remove me when IP discovery init is in place.\n");
-		return -ENODEV;
-	}
-
 	if (amdgpu_virtual_display ||
 	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
 		supports_atomic = true;
-- 
2.34.1

