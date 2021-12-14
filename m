Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C281C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 04:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5723510E8CB;
	Tue, 14 Dec 2021 04:12:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1073F10E8BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 04:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQFyHItQIz4x7K0Jf1GSqytmztOlQbTC3no6W8h5BwHIWkPuP/ssEFZhUyRzqLIdyjIzgoeVVrCmVA2KrkP2VIwPzi+8WlFRKNK4xf5AnecL5pKEUUgYfteXwecIwsTDW9GB9YR1ExiV6LWHBhUYQ73iofEaKOjuSc4jgHTMPCLhskbJgCqFI0x7dZNVxGFIpDY5teV+u+eDpzZtUuxDR8hhaDBKMcQ8QgLfRyOUyZEvYTMinAEhSllY5v8r9VOWlIIy7fo56lsrHsCB3fOVb3eshbatwWEr4VqAb/hF3oIv9cG0FxpQT10rGJAwOXvTyR6RS16NDbBB/4D4grmVpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYvJplPHrx+tiL6AEBUUNoUjNS/ccULsb28CqbS5ENY=;
 b=lj4CpQR5MyoIhP/9TzABVP8InQO8aFcUPDsT9ezQ2g6U+mOP3vK5LeQm2g/S0Kjm4kwEQa+BGjSUayp4hTcDrSLb8Hl1Gh2Dp7TgatDlJbTZ860PMMBZ52TDaswygMT/Nh3ljsz6tWVlMbykkpoHBloenUAoDLfakUF2LbQQdiRgery7CpC2S36h0B/o8LcKW9pdgOV62nkc/XLTAV7P7TrDkj5JtWtzaBbpA5NsBMzwFhtPebom7Z79kMWye4scFEI7bZMhL3PyLX4GgOCxIE5WhjbMXcqXo/+lCs7Joy7hIHu+0XQV7H1MRMWSL+bgq4PR3/oHHj2FcV4eRwLLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYvJplPHrx+tiL6AEBUUNoUjNS/ccULsb28CqbS5ENY=;
 b=mqqluWIP+rX9/e0LX3UezFEwUXOC+hrls/RUnlclBNRY15axiSSyo/VZFHPbNmek0au/yMq4m7yzE4UvqTIbFNSCkRHEs8s4zEJzi6b1I0zGL4HSIScoeXH8ZZL4ePluR+dynhd3po1SXAQbk2hRhcsGhq1AZz3lZtZnjRCHIPw=
Received: from BN0PR04CA0154.namprd04.prod.outlook.com (2603:10b6:408:eb::9)
 by BYAPR12MB4792.namprd12.prod.outlook.com (2603:10b6:a03:108::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 04:12:41 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::38) by BN0PR04CA0154.outlook.office365.com
 (2603:10b6:408:eb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Tue, 14 Dec 2021 04:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Tue, 14 Dec 2021 04:12:39 +0000
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 22:12:38 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/amdgpu: fix psp tmr bo pin count leak in SRIOV
Date: Tue, 14 Dec 2021 12:12:13 +0800
Message-ID: <20211214041213.20120-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2d0767a-cbb5-4cd7-d6bb-08d9beb7f7ec
X-MS-TrafficTypeDiagnostic: BYAPR12MB4792:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB47926335B79D32ADAE710D40B7759@BYAPR12MB4792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slA7rB2uuklfB1DIJ0Y61sLLy3Nno3rPtZtZltbQ+tf/m08wSx5eiDcdZ794Dt7jzStmUCOQ4c11N+X3D0qk2KRxUl+HUwFKwgb/WYq2fNitHcRGLe5zqKPj3hp9GDhjBJPpbUSfJ7wKfOxJaDg9Zr3FqVKFcNFSxt/O+Y6+7qjEhzQwluM/KI5xQZogoIFMwYA5gaYrgc+EgiReQavkQSs7eg/rKp4O+9Hgr+Set1fHpj9tnORZKQ80ESI05TnBQtfr0cVescs/NhWSej2+iQOuz/n+4FU3xkY124lvMXkEd/TgWddUf4KcTtDNMdab27+yWHfnp8YM0DZL9p9B2GXkH9LCIQqMMZYa9GdhxYmiyuCwOQwLgJTS+NbTReVDmHivvKWdxPCHiE9epEg/kQ94fVgfBDdKMQKzuKqXpnBK20Y/no50jVlO7e8xMUEkTHRMfX25HUn8uCT5VwmAl+iwe5JCqCY8ml/y3OHzGD7Ca3G6TMqVIKOZFhbfoFoftGDdei6HWFfFzUmiYLOZl5az0CljK2EYSm0kR2jYEQ71M/96nlXFinbB2x1SJYe9Me+IRhrJqRCH1nvwGCmx9iOpUq3q2hwxtS+kkrmgUT730V5hCAy5uqtSEs3XR4QBLlMIoC3aNfoMEbm+ElTqP9407kFCeY+FOyM8AzCWr7o8Kss6W1WdvazdYm98eVIfdNgi44gYQeBVruEEB5s17Gu6E3yIYeMHx6fmm5F+EgV3UgX96JUFnI8SJQwF23ks7RroLrN61xBAWw9zCkIATLTyilPO1jg9QqeEac9quLs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(5660300002)(63370400001)(63350400001)(4326008)(508600001)(426003)(82310400004)(336012)(4744005)(2906002)(26005)(70206006)(6666004)(36756003)(70586007)(7696005)(86362001)(1076003)(36860700001)(8936002)(47076005)(81166007)(316002)(8676002)(6916009)(356005)(40460700001)(16526019)(2616005)(186003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 04:12:39.7109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d0767a-cbb5-4cd7-d6bb-08d9beb7f7ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4792
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
Cc: horace.chen@amd.com, Jingwen Chen <Jingwen.Chen2@amd.com>, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
psp tmr bo will be pinned during loading amdgpu and reset in SRIOV while
only unpinned in unload amdgpu

[How]
add amdgpu_in_reset and sriov judgement to skip pin bo

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 103bcadbc8b8..cf5baa57ab95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2017,12 +2017,16 @@ static int psp_hw_start(struct psp_context *psp)
 		return ret;
 	}
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_in_reset(adev)) 
+		goto skip_pin_bo;
+
 	ret = psp_tmr_init(psp);
 	if (ret) {
 		DRM_ERROR("PSP tmr init failed!\n");
 		return ret;
 	}
 
+skip_pin_bo:
 	/*
 	 * For ASICs with DF Cstate management centralized
 	 * to PMFW, TMR setup should be performed after PMFW
-- 
2.30.2

