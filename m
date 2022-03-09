Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53C8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 20:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA8510E40E;
	Wed,  9 Mar 2022 20:13:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B13BC10E40E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 20:13:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duIFcmfU78z/o0dgIyfcBRY56+9keswOGET9MSS/+qa0vmwd93txHGZVFa4ZNs0wAGF4ngAQBXYxK8DVJu044JiOfSsiUT68WxTlNEChGzihMGQR+lreYJyISBMc4vI6nWJkIP7zX9h6ikalF+vgvoILz00M+WN3KuO5WlMovZw2dtduZXOk4IiMqKB9D85WzfrNpLeohfNYExV0MVEj6//c4F+1wYU1DBqanfNEnKoM+2Fwy24zigK8p+BlgKBo6epH7vYIoelg17axxrQ1Dw+zi+34ewUa7tJrWSscWeQyKmr0wariNZ2hdUvS2HMRTQhEN5+PULS3zstiYCfthA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSsJ6CjvLGKd+ENSDMkaqDu655p4aXSTYNzdP4baXTA=;
 b=A+ji/vqwzSlUe2EO0zTPrtVfaWh+2C/j9tE2VF+Kk0JMEnqBgXAsX9SfpVmiqM0tWfFEd+IyNNcmN291tiyBew/5UcaoGidtfrTv3P2oL0BgGoL2abbPKNsPr6ounyCN2iFHsY+1lymMI4izyrJL5MqIDlEX9qyLVcnUfEhh+FV9kPzcjkrl0sFHKUCyB5I9lO/h+vygEPwZ/tNhv5qti97Cdhz/Tq9rLgpsKG6F08RZUJKrU2Rnnwdwk4nPeioWQ+fb1ijBIj+28fmIckzW8PF7GlHa0Q/5EZZCteYHxjmmQZLINKroUmmeuifWBLXToaAgW3oizkKsPZcweWOYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSsJ6CjvLGKd+ENSDMkaqDu655p4aXSTYNzdP4baXTA=;
 b=EnsaXML8XlyiV6oJ/JDPoqi/T7ywXEu9cEhnQLBdBDW+2dwoDfIodY5VD2w4VNiVk7BsUA1El594hfGatCw70i41fNZ5HQF16rtzpcyojXGBmi4Oh/zByuvYJBogUNStn0f/fv7Stse1lGRG6qHBQkFurBj3xd68JCu0eX5E20I=
Received: from MW4PR04CA0202.namprd04.prod.outlook.com (2603:10b6:303:86::27)
 by BN6PR12MB1794.namprd12.prod.outlook.com (2603:10b6:404:100::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Wed, 9 Mar
 2022 20:13:09 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::2e) by MW4PR04CA0202.outlook.office365.com
 (2603:10b6:303:86::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 20:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 20:13:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 9 Mar
 2022 14:13:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: only check for _PR3 on dGPUs
Date: Wed, 9 Mar 2022 15:12:45 -0500
Message-ID: <20220309201245.1328201-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2b0abaa-722e-44a8-fae8-08da02093a94
X-MS-TrafficTypeDiagnostic: BN6PR12MB1794:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB17946A2B1CF0488C01739C99F70A9@BN6PR12MB1794.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+S21seTki9C3So/OHdRWyxhOkgVnGgGiQgwIL7d13IOC0YMY5h8pGjWDRQhSM7TAiC57euYCJ0QtcL/OYSj7v13psNBsyQipgYxgNRUPH+QiKsU9b5sgcPws1/n7TxdXOu+4Fy4jot1dArEgzrRn3sbKMs4ImTVgMoXW49YHEXNkNLXjki9eWFtdO1WZ0U44irVe6dl5fjmIrusQCvJ3xh1/kDMgK+kGr3sunnv1lTBSEk54HrBEccctHU6ZBFgmFC/m4CcxQeu90Awjfrc+R5PCi3cANCH2ek75rwiCwHk6Q+mB6/NZAaiU1hEDOIIJ/cP4YRsB+u0gzqesW+hi78h5nwDfaaXmYLyY0VHQ+ljrQ3oMaL8yShbl8IDJ33T/G/6c6ruCwwyg0hjl1YyZCaJMwNWbJ1ioBlJfJdBo5TImXxlKOP4bAefOyiFINpROqHxxUUFzWy81CDt4LXkoJkVzCCiU6tm1u/6VPTcjUdd5sOG1/3jtuqB1YmQrv2bXun367wZh7upKcRVmZ5AkL8nVW2o8r6x72io666wsI4cLDpmHSyUUC1iUV7r3EdSOOx87ATZadrwl8erOU30ysIUhwcXcFJLlWRAqwM6O96285CUr9veFnITtlQYMAJ7viGlM4FW4IQnA8Y9h+PVMbKGyJLorOB4F2/iEIg08cGJwQvGES37rjf1I1+bIWn1PacuV5zXygfMeJ/CemT+3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(356005)(6916009)(316002)(8936002)(81166007)(47076005)(70586007)(8676002)(4326008)(36860700001)(4744005)(40460700003)(5660300002)(70206006)(16526019)(26005)(2616005)(1076003)(336012)(186003)(83380400001)(7696005)(6666004)(36756003)(82310400004)(86362001)(2906002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 20:13:08.5274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b0abaa-722e-44a8-fae8-08da02093a94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1794
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

We don't support runtime pm on APUs.  They support more
dynamic power savings using clock and powergating.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ddc5cd61af58..1b313a95c7e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2159,8 +2159,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	    !pci_is_thunderbolt_attached(to_pci_dev(dev->dev)))
 		adev->flags |= AMD_IS_PX;
 
-	parent = pci_upstream_bridge(adev->pdev);
-	adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
+	if (!(adev->flags & AMD_IS_APU)) {
+		parent = pci_upstream_bridge(adev->pdev);
+		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
+	}
 
 	amdgpu_amdkfd_device_probe(adev);
 
-- 
2.35.1

