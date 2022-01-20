Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9773CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 15:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0938010E4F7;
	Thu, 20 Jan 2022 15:49:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 166D010E4EB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 15:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhNttNhXKnbQov3C7cOkxQfSlZCTmgprbP8rLv1LRZkp3O3gMLHftkhbTMZSxzhD2j3TDvUuDCXr7tol+Y7tSinrgJBWX0YbM5bFbcmSVwRJEyHi/7lK7z9JMdXCYdXVg7uA+7qJQZ8a2B8s/6CXM6eyAe1DvHVa3Dgg0naWc1VTBugvgDJ82k+jIzYeLUD780zxfu3PeNNiSJwExg82fqgfNhXfO9/YukIAZlcHcgPv1HqkVVC7It2165jwjaCwEYKprZoHJGhym/JwVBSfBiuMkx7Pf1SKAZ5YRDUx/jvweh43WJM6BETyNGBx+1vpXhTVoqe6mpYlI+i+QZRtVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwDkT7AEwneFnT5xZnGrCUgdqTdEjUyy6GWpTRfLGpE=;
 b=OUlQ8TP36fGYLXtMR8L4yr9NWO/VjOW9kwBI/LRfNAQGttq855AZ7v8LID4CPDdCgNeAQtXbqNfq4uN1LBiNUPqFEW4QYA6WdSo906Q4M0iEvJGxEsqwmk/9AswZib6os+IDmmPvDL9dVZudvWlE0bMZ9GO2OkrmQi/s7nuJ2t4ykBGZtUbcOLNFiACXVKG8IsZXbiDoeBSLa8/58dus0DxFduqMuM3frGvgvoQfWHuaSzPrqaOXYbCzsE05ThgI653N1Vzcc8HefmkpqRmHJMkWBG3PzMmKxdJu7JmCcywvG16cn2XprM78yBa/vEsLTC7E5oqQyHWx43toBxlvug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwDkT7AEwneFnT5xZnGrCUgdqTdEjUyy6GWpTRfLGpE=;
 b=zaxH4Vv8fKEqOMwCmBGp/94QuPsjCtOd4aXeWGqvmJD0Z/dpklmulAqfCmWyb76h6HuCWMPYxxkEnpCSpyuRgUHYgoEfavK/zJE4wH6oDjGrFVr0rqmMlZQMlYHYG2IS2v1S5b559uY6IScZLjYO86BAHI3dCWf+Y0KW3jrod4M=
Received: from MW2PR2101CA0008.namprd21.prod.outlook.com (2603:10b6:302:1::21)
 by BY5PR12MB4819.namprd12.prod.outlook.com (2603:10b6:a03:1fd::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 15:49:05 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::fb) by MW2PR2101CA0008.outlook.office365.com
 (2603:10b6:302:1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.7 via Frontend
 Transport; Thu, 20 Jan 2022 15:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 15:49:04 +0000
Received: from shaoyunl-dev1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 09:49:03 -0600
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Disable FRU EEPROM access for SRIOV
Date: Thu, 20 Jan 2022 10:48:51 -0500
Message-ID: <20220120154851.22223-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c731fe0f-5201-43ff-6540-08d9dc2c62f0
X-MS-TrafficTypeDiagnostic: BY5PR12MB4819:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4819DF20B1D421F085B38B61F45A9@BY5PR12MB4819.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2SgzDcWpfME1cshYzvjGR6HmG1nIld5ISIFkP3KQchFjdiXv/UAOzGfsO3pvwiLiZdSf4MKi1ZVxQSDwTcgyi+ASQ+rs52LhRrsT4eGdagBQVLNXqH8dZTzIVoEUuGJ8l6k39blXX/78c33Lo4MpQBrqwcoipJCXq+GQO+SqZOzFDYu86BNwEMlHU95r5JApmX131mHHIndVW4jryJQutnrTlIEoQL5L3Ylusj046MHOfjzLyfun35hWEv6vMhb4c353wMlszrD3+WiSpq4gTs6C2+tLOA4uCTgCz0Szjh8ZKIP3jr8pnMlTL/2tQNQps2f1E4WfFg0XgPfsIvIiPvRVpUQLqt68JEqKWxHXTGYUYckCno2K+mS0TGjpg6Cxqf+7ZSJap2cAU1btgMWLYFUEd+npnODrUk5ttHkW+I11UD1uvdN+CcbzDDCnErta1JYqn/j7Zh/Ddt4MTq6t7LMmdYSq+Ud7NA2QQjqZ798jjil+kMBp/K0wHXffBgBZqUPBCzrb8EmYL6FH3k5nyYVpyV6dc9sy+g0tmd9+AC2hNgbPiRcG1Cl2bNCF3tO3nzsrep6NamnR3EQ6b3va4O+JQT+L1S1OOBYiWvnGb9OKQLIAiw0JgTKRCHFa1wOItn1AcTnNf8aOA0tJA2g1/mYHtHbZ2mx9EURiLWCIuMIT3VzvJrkhhOGPsQq6CiIR3SDElNJuDc1qZCz6uijGwKjiwqfctgvimzIL/NfnGH5EPQXMVOefdXb0y7yuD4YyTt+PnuqDtV4E+Vo6F2Y9FuC5Glmprp8yxboSx6ApjnCaEMk9O8tGFcb3fOK931/SOrpgI+020bMQZKkJ+WDP0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(7696005)(36860700001)(8676002)(83380400001)(86362001)(82310400004)(186003)(40460700001)(26005)(36756003)(6666004)(336012)(426003)(8936002)(2906002)(2616005)(47076005)(1076003)(316002)(70586007)(70206006)(4326008)(356005)(16526019)(5660300002)(81166007)(508600001)(4744005)(6916009)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 15:49:04.1542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c731fe0f-5201-43ff-6540-08d9dc2c62f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4819
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VF acces the EEPROM is blocked by security policy, we might need other way
to get SKUs info for VF

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 2a786e788627..0548e279cc9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -40,6 +40,12 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 	 */
 	struct atom_context *atom_ctx = adev->mode_info.atom_context;
 
+	/* The i2c access is blocked on VF
+	 * TODO: Need other way to get the info
+	 */  
+	if (amdgpu_sriov_vf(adev)
+		return false;
+
 	/* VBIOS is of the format ###-DXXXYY-##. For SKU identification,
 	 * we can use just the "DXXX" portion. If there were more models, we
 	 * could convert the 3 characters to a hex integer and use a switch
-- 
2.17.1

