Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBF5C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 03:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6084C61939
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 03:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6084C61939
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C876E2E1;
	Mon, 22 Mar 2021 03:05:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48EB36E07F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 03:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6+Bxz0VioOjs99k+1HVPpCA6qlaTG4AX1pK6bFaty2Lvdn7jlAI2zVU8nz09Nd7KJV4cuvAGSd2MCuNC4TqvrJQ7sqZqwDHGuRuyiSUIfkSjTp6P2ToRzqaqM/Ccx84XHcZ0ukXcvYPer2E3fHGBG1YF+1uy9i16ydpKZvjCvKlEl6pQY4YZTAa9FDqMj9A8UyFqG3B6ZUXL5gV2ilp57f2ZxR6iMNtSyxG7s7+wIcDAUt06BrIIorXx2dDAFMYSNcSU3Sevxs4T66HiPMcm07MJdc1vw1hLFII+WW2ayWkUjrjEfF9RyhnIfkZzMEpFrmsuOv9F+3tUBE+D60O2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8834dAkwVo1uLglTypXYONK59gkqIYznAlglo9KamTs=;
 b=gZNuMU+gfJz95yHOmq7av6ttSZkDSbtJuSYkrJD5vM3YlF/81coo6S6MFfvKpAAppuBrHTl+taIaAoqQvARbOLePZqj9+FDITOlut6xpRIQTqWsAhZntqzPIL1FE5i/7kTAWqU603FClWey9nPZEBikR6S7JUtp/PCLXaBbhhtOahehKO+qba8ySWbwbGFHMJ8SYIcVWKX01bLRGbSAa+2wdC7GDPEgoRBq29nRg7MMe676o3M8ZS2rb2RwUHsAW9G/jUaNypTpZ59g0KzRGuMqGi8czF8DwcbuiVfzqiniWy1QJQVB0wybrxTJKZERU1xoIWLu5nya2JEa5mWHn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8834dAkwVo1uLglTypXYONK59gkqIYznAlglo9KamTs=;
 b=Zojlsm08/k9eCZQDs0Z99yOEt5kZXY0h8hHMq0jT+pLK+s9Ct6s22Joyjt3TnWADUPaWawlOigChwzjqDRqIU2KwRP8HYvqSbtCSEnNkCUEB45VBI14ug4YIgDfWafrOEk8nBnzuIzo4ceJF8n9xYc6c66WzLtf5GZXq+KWKTzk=
Received: from BN6PR1201CA0016.namprd12.prod.outlook.com
 (2603:10b6:405:4c::26) by MN2PR12MB4439.namprd12.prod.outlook.com
 (2603:10b6:208:262::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 03:05:18 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::60) by BN6PR1201CA0016.outlook.office365.com
 (2603:10b6:405:4c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 03:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 03:05:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 22:05:17 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Sun, 21 Mar 2021 22:05:15 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amdgpu: SMI debugfs tracking
Date: Mon, 22 Mar 2021 11:05:08 +0800
Message-ID: <20210322030510.31607-4-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210322030510.31607-1-Roy.Sun@amd.com>
References: <20210322030510.31607-1-Roy.Sun@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e93d467e-c7b1-492e-2d74-08d8ecdf5286
X-MS-TrafficTypeDiagnostic: MN2PR12MB4439:
X-Microsoft-Antispam-PRVS: <MN2PR12MB443991ECF4E10FBF573C1755FF659@MN2PR12MB4439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCHi0pF+vLwML3qwkF8ve0LTLrpCogjjlVnaqUDhVSlDvPxRSpHvM9c0ugCPPqEcrtLVzcbtP87RAoP7lM140ZtDUGEJ1wiLlnhNz+HIK/FBFsfxSiu4Gj2RaqGa2uOVAKzya1671byYbZ+3nKBO6fFZImlcoLVhkV4qfhp1Wtjra4Eoh0PfK8LxTjkDEHXSLixnUqjjPN+Tdcpxg1a1+cUv2uraXWW8oMGj25fpsFOtkvB/MK3Mw0O2qnyF6g+epZ+fev7l5fxftX4a+Clewv4pZbc25SPvcVZJLTxMHh1LBokndKJmW04ZFhHfw8slE49WrM6JZvZ6O9VeOD2k9qW6XH3V+J/oiqEatI/uFEYMcDZfkgAmtSpbUuqioIA2xWi0O9GV4cCPyypa2Wq33DL9etD4ScGJtdjRJVIHrNMrv2jMR3aWmBi09g+4LCkAC1f/qhs+HQs06qMl4Netp6Gjt7LAd5v05UUKocBFTtmNGPBbetATlPgGiSVMBbEAal1+cFv9iT3XU67ofb34B7n9fOoGPzvajy53mSuSHGhJVYO9AYmIrBbHp/t25O6lhDSYqbb9zzKufK28ZiSzB74P3jFQYhiJnFUB3n+1P5TCeYC7Jcq218p1i8oWwozVjin8jA+F+I8ECXWGWxqnFqe7/Zml6imloTDLSvGRMYNI1L+GYC45z339Si0Ke1zA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(36840700001)(46966006)(6916009)(47076005)(86362001)(8676002)(82310400003)(4326008)(7696005)(8936002)(336012)(70206006)(70586007)(6666004)(36756003)(426003)(26005)(186003)(4744005)(2616005)(2906002)(82740400003)(1076003)(54906003)(81166007)(356005)(5660300002)(478600001)(36860700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 03:05:17.8872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e93d467e-c7b1-492e-2d74-08d8ecdf5286
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
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
Cc: Roy Sun <Roy.Sun@amd.com>, yehonsun@amd.com,
 David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David M Nieto <david.nieto@amd.com>

Add folder in debugfs structure for tracking of per
pid fences

Signed-off-by: David M Nieto <david.nieto@amd.com>
Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index bcaf271b39bf..02534a059f42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1544,7 +1544,12 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	struct dentry *ent;
 	int r, i;
 
+	ent = debugfs_create_dir("proc", root);
 
+	if (!ent) {
+		DRM_ERROR("unable to create proc debugfs dir\n");
+		return -EIO;
+	}
 
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
