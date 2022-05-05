Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC79C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D70F10E3E7;
	Thu,  5 May 2022 20:04:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A6710E3E7
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQ7FHze/o8ppL+P3Of9vbqrrOOPawtIT46IPW1XJsVdNPx7xcVynGvLCKh7b0hJWdqQ1bWWad/YBAuKHRvJ7zNRrQgGKbf4Czz7CYoP1iK7YfqVpt19MoJKM6t7ArXs+U8WXJxe00JUgR+UC/q0Wi5SUiCWmk/rc/u0bndnvxUGwgg2lBHXJ2dmLf1rAYss6Hm0pwmyzqp8SVY7/ij14Yo640bYSuK+js20YZCCdN23Z6jV5H1ofwdnfvgERSWmsT5OeFd6FYiQWsLoz5gqKEPEol7MawKrJ3ByLFI6BlJKwoaQHlXZ1S3KAhyeNYygRY1Ou/sTs6Bfzii1PvrPgvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lg01XQa29sWPW89H1wFoF2/prNmD7lUgI8TsyqIfH6I=;
 b=kd6ZFVo6CRZU+A6ENehisSQoE7ILahdxrIGtEYzcyReK+JzpJi/wHFMHxUFwY2oPUDEfO1i7qfMzYKUqyYq6S1GFgWMMyd+PtKA7liVZI/lzgJWdQ7o5HCkOehUGAr3UTeiNWwscTObLbCVMFwmhClB+lkDEHJBI8xxmyiUPnZifQEFtl/CxTqWPZmB6ubQyaHsnQ21pUZORt/bk91Vz8H+HT2WHfFhwHExH2qZabkeYedAh0skQ9u1CizanAtWvkUKpXwm938PH676jkMx4sHSXKcUMpd0e3Z7wPI3qn8L9dFD09e05EsijCtE8/O+wQSLV/7UDKJ+Ft1GwnpwR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lg01XQa29sWPW89H1wFoF2/prNmD7lUgI8TsyqIfH6I=;
 b=3s+YqKgBUhTErspigIlGSzLdvHZc0AmNxN9ARkYFMo1/oQZVwBs+1uYJTk2GNNCLuIiHaPwUewVGRmCiwIdRB/Y6Gcdnbnhs5ZlZhw/PrbxhTdYGta2UJozjE4+9umaiu/DGPjOFXVFyTZYKRzGPNI0fCMBOZoZBHQL7q8daaK8=
Received: from DM5PR08CA0057.namprd08.prod.outlook.com (2603:10b6:4:60::46) by
 DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Thu, 5 May 2022 20:04:29 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::8a) by DM5PR08CA0057.outlook.office365.com
 (2603:10b6:4:60::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27 via Frontend
 Transport; Thu, 5 May 2022 20:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:04:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:04:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amdgpu: support memory power gating for lsdma 6.0.2
Date: Thu, 5 May 2022 16:04:06 -0400
Message-ID: <20220505200406.1293467-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200406.1293467-1-alexander.deucher@amd.com>
References: <20220505200406.1293467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d69ce6e5-bbba-4cba-d218-08da2ed27681
X-MS-TrafficTypeDiagnostic: DM4PR12MB5101:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5101453482E0A2DA4CDE2EC1F7C29@DM4PR12MB5101.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGpiXHqFYlMAIfVlR5KA+2sqBA/zG4UtRev0cfThUpeLdTzXqY6XbFUXLjd0KdEdeFQ4JSBejYxb8xxaon/5f3aosi7wcHcsqZt9XNbxyF6IS9FTDTrxH5FxULRDquLMmBbWw23jvKhJmWY3Wq2598h34r4JB0zdt3U7AjRmpuBKOSgQtm+Uf3A5Y+yFpVsirXtIEnGPIDF0EaRLBE0Mmolu5cc4SHBEwDRYAm3mjSBlQ0kxjHBhHH+Tr8f7GnR8CrFgoKyf6r+7/cA68Y845L0EN5gjacOAeHsrxRxIszU68qTKTxZvgydgDAetkhR21ObfUiPb7Psj2t7DYnRe+w+gGUomb3+2Smq8EylBRyTJf1yuu1KAVtcpjrk2eiqe6DSAvteJCDalrFHPyXRY3BCrvamqP2wL/1lbfLFe6jQ0h4sLprJNAR0UbTl/hg3ZwDSHdsKisKgljVFoy66t4cfqSghub+ix20Kn9rTpUsaGogNZo8cI+Em/HVesC2/fTx2o3750R6N7sGnJJy1Tj/9/KAyzeMbb4Z+KlqJ0uSJ9JrlcF3lYfsfx48uDG1X3Da/cGKMjwy1VLHiV/jfveL1W93IiXjj38uyFq+QJdtfQYQgz6s7VBupVNH6tx5S8X/4zyyiHEedH7gWiiK/kRNbTgHPKNH1ZnKG4W0Vue61CbwbOYjPvPO2dCalz/USDAA1GQmhmPHOtfbNjjCcDyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(8676002)(316002)(82310400005)(36756003)(1076003)(83380400001)(336012)(47076005)(426003)(2616005)(81166007)(36860700001)(16526019)(186003)(4326008)(8936002)(2906002)(4744005)(5660300002)(508600001)(70586007)(7696005)(70206006)(6666004)(40460700003)(26005)(86362001)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:04:29.1638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d69ce6e5-bbba-4cba-d218-08da2ed27681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Support memory power gating control for lsdma 6.0.2.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 3303e02f85d1..c6a8520053bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -680,6 +680,7 @@ static int soc21_common_set_powergating_state(void *handle,
 
 	switch (adev->ip_versions[LSDMA_HWIP][0]) {
 	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 2):
 		adev->lsdma.funcs->update_memory_power_gating(adev,
 				state == AMD_PG_STATE_GATE);
 		break;
-- 
2.35.1

