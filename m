Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063B2C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 18:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 926F410F0C3;
	Mon, 30 May 2022 18:03:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D7910F0D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 18:03:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEqAwuZjApt11JAeYR5M5n7XEP4TR3SZL+4T30LsSV0sPoEXcQ/pUU8Ud97UJIGxmZxwvwu2yVP/xWHdYG3IWWV+qBerkDoerIcpg0Slg9dB0HrIR8lIujGsWIaxZ2900eERpa64110z3HCXSzvocUMdrtZ8zgAtbqQn4RvPQMvgECP8Az4dUicr3lh2NIWXtEiCM2Cq8hI0swm/Rj7UbrV6KUn9qYo4Ix3LDX4RShy78nPUXBNoGmgVzD0x91YzR6F3Z7ICuT4ysJ0L2apyPj7EFgmOHvYpjj1MsEnoAQWvMhkWKGd5hZg5j77peRl17CFtsMT02BkC1R9CeLL1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeW1Oze8LMQd7amDxj+63Q5Gl1pw/rc8SbTSCWfs+4Y=;
 b=HMWHxTV5UosuNdbyHrwFgVkM2mc4HzdViFBGvzwoUb1jfLvg/s6kRisPBhOOWBBB5jF3zpsf7VbV7ip0IIBGli6DnAZmD9vJTn4uLW6zYU4kzKvfgW03gViHXqGoaWyx8zQ1spg2S2Y+ySZvCPWkYbTP3xQcWiux4s61NGCF32VzicSEYADfUQVGjwZZQOpGAvNwrz91DpyJxpIWH7UD0DugLmBdMUev73ED3i5ubBNrU9wXUNaGeyZ7oFSLa3Il5knSI/QF6Yneh1RyE5H2qkNOPSWVAYvE0wH8KGqyvBLx9vZJU8XVj43hUDYyRcUn73IDdl2igrkBFxmLMUlhgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeW1Oze8LMQd7amDxj+63Q5Gl1pw/rc8SbTSCWfs+4Y=;
 b=iCrtpPB2Xj53qbiS/fQn/+KMXbiwMs9ZoE41yuOWgWcdR/vjDfm1ssKVbxO33vksOtIDjCidmDCBeo3KxvPy7Tv3UI04i6u7YauOQMm27BtZDogovJUMUrTzlJu9Wkv/aEFLL+APFeds4q3RFR29qn+YdOVtijfnlwUgdtwmD8Q=
Received: from DM6PR08CA0029.namprd08.prod.outlook.com (2603:10b6:5:80::42) by
 DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.19; Mon, 30 May 2022 18:03:14 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::a5) by DM6PR08CA0029.outlook.office365.com
 (2603:10b6:5:80::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Mon, 30 May 2022 18:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Mon, 30 May 2022 18:03:14 +0000
Received: from ETHANOL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 30 May
 2022 13:03:12 -0500
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: enable tmz by default for skyrim
Date: Mon, 30 May 2022 23:32:33 +0530
Message-ID: <20220530180233.2447918-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d3aef1a-f5f5-43de-0538-08da4266aaaf
X-MS-TrafficTypeDiagnostic: DS7PR12MB6240:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB62408DAFF304F49B495E542893DD9@DS7PR12MB6240.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+NRez4yD3lbYKIK1oeSxROqV9hm7Ky/Ok2YYdVw5LidnkXlmpXRO3A/b7grp57JhSuQdh24PUYUmeYG+Wbk3jvEW0Lkl2dMIspNyCwC+sTplQDFiWoMkxmFlvsVYAV/Tl2DiD31AJGRRTiBtiuPxfU61WIiQlwNW1O9o0sE1DsjIPLvwAD5wCwyiWkWFB0Q6bBB0N2J7iqe30SZVd1xloAnHcdR0g1avXK2DANirlJ8ujhUa7wgCtLoIra5Zb7fgGSmv67C1ucxnkax2ykjA9J+AEIL1d4dJsh/DyB3YwXd5KzrE7akygzCMJ5Hn43taAi/xxWH0FKXnyNNv/kslhrw3345QMkzgAKRpBGPjPbmlrvy1ylbtiM4/7erY80LEn4zzg1DM3TDx2xMyqQ9yS/mlBnNSrE9+4Pd/qWJFkAsS7kvlnU/IhFETL/NhIJi167hdfp5SsGJIYGO6AKbwLYjY3ppA2IidHRw7AUmVWrdfQc8CJyXy6ceqZC6mXU2hw2P987S+M4/jIqRCSSM33MICx+Q/vsG4QR3xJCObY+soWsSmXf6uDVsD3p9pi/yC29sABrgfrxJRty7w5N2T0TfLj9+kXCRf26Amnur1S/ldn5qaipEcNstyQbXlHrtTUh6ElYIDOYlCpZDHy2Omoycg+hCU/9bNy638gz6qMlRqCo5+fQ9rQjGBLO09AEfHWJkwtg7jyWc6isZYvnp0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6862004)(83380400001)(82310400005)(4744005)(4326008)(81166007)(8676002)(426003)(36756003)(6636002)(36860700001)(16526019)(336012)(47076005)(2616005)(1076003)(26005)(186003)(70586007)(40460700003)(356005)(54906003)(37006003)(6666004)(7696005)(70206006)(2906002)(5660300002)(86362001)(508600001)(44832011)(8936002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 18:03:14.3103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3aef1a-f5f5-43de-0538-08da4266aaaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
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
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable tmz feature by default for skyrim
i.e IP GC 10.3.7

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 798c56214a23..aebc384531ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -518,6 +518,8 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(9, 1, 0):
 	/* RENOIR looks like RAVEN */
 	case IP_VERSION(9, 3, 0):
+	/* GC 10.3.7 */
+	case IP_VERSION(10, 3, 7):
 		if (amdgpu_tmz == 0) {
 			adev->gmc.tmz_enabled = false;
 			dev_info(adev->dev,
@@ -540,8 +542,6 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 1):
 	/* YELLOW_CARP*/
 	case IP_VERSION(10, 3, 3):
-	/* GC 10.3.7 */
-	case IP_VERSION(10, 3, 7):
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
-- 
2.25.1

