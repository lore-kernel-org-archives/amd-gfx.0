Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4845CD6E7D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 15:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4297710E518;
	Wed, 11 Oct 2023 15:33:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 664DB10E513
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 15:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVrYVi/nc+D4Y61VfGm4ogVO+F47tBrlR4cGpLeHGG9XL4m85BX5dhicFPM9+NzzNVj4NSQgEPQx44J9IDEqqg0ls8nYb7pF929yd0ve6JEhlhatxhw4gbimedZeppRpR5w4nHznuBoVziMvAEvxue5S30Rkndva4LXrGU9llWe9pRJcXlDgPKb0/8kJg/wjBnt+9mCUBZvDBDADyCIk1MpstLt0n83crSVt3aSBjVx/fQQxMt7oAsBQU5q043jAOdb6a3LD5JBj1a5C4B5hTW897sX55zbjv89AXCoiGyBxdaYg/yjLQxm0MbL9CmiyhNxcZFmSn0mBmd8DIhpZ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gq8x9hmXNtgFolXXbkhm4gzlB5b9XW/Ls3ARzQZNsYs=;
 b=Pt5Y33KJR1w3PqwvzaV4EP7HNJKvEKiKlSKThThw1S1VWoKYIZ1GP1Dm8dXJGQ3wr37f7vf1sYdMlfkW6upDVhE9QzQsFLjdi0HkRjiSf/09m15mOn9JeI1UeBPQSMFqgtkvncIX6M1V5g737+4t6XUs8xHX65x6qwGdqCDCs8pBOHVwmPXeS5cAZldNNwXZq5B/CSAhnGq4V9xXgx5TOi4Lpih9sTOuinBDD3SDDYAeeR7OuUZmghPAjg2jySqFuaHKyBvunX+u5AWVkFSRkwxf/J8E0JQc1lVHiytby95vbYlaCjXH2amnkDrIy19kQtzwcESqxhfR2fn6CxvnGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq8x9hmXNtgFolXXbkhm4gzlB5b9XW/Ls3ARzQZNsYs=;
 b=XrTQSaHpyBf1QjH+zIUg+ElZsAwSjqpWSK5CD/fo9j59mKpipiwD9U46unH3Z/ZJRS6YFB2Mw4a9csT3r+mNYqPsmi7gceXaNhIb+zwu5uPK0UofL7FLm0ae6mDDyiAXjEWlL7QSPrDBvpL7RKoQ20socawz9LjD+xi6Ry5cnxA=
Received: from MW4PR04CA0164.namprd04.prod.outlook.com (2603:10b6:303:85::19)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 15:33:49 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::c4) by MW4PR04CA0164.outlook.office365.com
 (2603:10b6:303:85::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Wed, 11 Oct 2023 15:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 15:33:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 10:32:43 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Update PSP interface header
Date: Wed, 11 Oct 2023 21:02:25 +0530
Message-ID: <20231011153227.97424-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: e5221ed9-32f3-4c02-1e23-08dbca6f760c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iL/NTyPAwgBaVNjp6yIDh+0OLg5eIIZgsEBmTFwF5f644IGcKHCgcP00XEK0pCkU5oPV5wqUD52+P3dvrY1hQ0TplQFYZMZ6HLQpyaNJcMq8EAQvpQ0zVVwB/oUjOfug6Crl6JYn/GCfo5KAK34indS4mQuYcQILOnjJhZSfJhdyiYouPwgPH+SwVPjcJD9iMudrwj7Zq73A90w41CKO3pdPzZDSGMa3jhRmJE1J2XfgXqbQ5B8fyz2EPY345XtgplrEtsq7ggklqsQNeR+zPwM1oCBnXJriYpgp0PA4SiqYvsBnRWLDboLxJ83fbIyhL7YnWmCRBCJ78PfOkuLRkpnnAvScOBKwzFwyNtpQlaw9qYsT8LiQHuQLfexzu+EhOQ6zJfJVHzDHs8/CEf5G5R8F2sS1PxpTu1pNXQupOg3TbvromIRj2b2cvKqKxS9scrGNYQekRsgiGNn6Oh8j6Y4yZgGZpbfv5dYQ8DF3o9PpuW52+99lq9pKRUZZ4P3zn2OQ5gYJWKIj4RKAvY6Kc7e1ayUXE79+tcq/4A7nV4UOdSyjmprGBwsmmYrvLl5j0+W4QvdKaEPnjh/QmqvHgXY12fx87xSve7u8O95GQSfzEQyfozl1tadMXKrYNgh0kLltWlDJBHgDJeYrBWu2uy55sx/jeG2mafWWAEeNI/8sZ1T6IwlszWWu3lQhONuUb8qayYKCfVB2j8/ClKMszF7GfG2XBI2CJ0oProfJViIB4qN8sZ0h5mCP5+L718mA1q7+0+XGzZWzperFHNe0eQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(356005)(86362001)(36756003)(81166007)(478600001)(41300700001)(40480700001)(6916009)(4744005)(8936002)(2906002)(44832011)(4326008)(5660300002)(82740400003)(7696005)(6666004)(8676002)(1076003)(63370400001)(336012)(426003)(47076005)(40460700003)(63350400001)(70206006)(54906003)(70586007)(316002)(16526019)(36860700001)(2616005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 15:33:47.2180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5221ed9-32f3-4c02-1e23-08dbca6f760c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adds FW id for P2S table.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index dfd60db97012..4bb5e10217bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -296,6 +296,7 @@ enum psp_gfx_fw_type {
 	GFX_FW_TYPE_VPEC_FW1                        = 100,  /* VPEC FW1 To Save         VPE     */
 	GFX_FW_TYPE_VPEC_FW2                        = 101,  /* VPEC FW2 To Save         VPE     */
 	GFX_FW_TYPE_VPE                             = 102,
+	GFX_FW_TYPE_P2S_TABLE                       = 129,
 	GFX_FW_TYPE_MAX
 };
 
-- 
2.25.1

