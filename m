Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84798C27C40
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D53B910E5D7;
	Thu, 24 Aug 2023 21:32:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2859210E142
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKMnsYLI+SVmuS3LqXldxEPWx8i6jZJm4/wD4a43BlXwxU3wycqydvaqVC6bGxzFzFXkn2qLLWqytNdzDxULGZ3Mlu6b6Gp6mRW9DGBbH2F6rnMeQkSEk+gTDdM+jbKQTW3lZDgY/8IYSh6lXFgCHP4i36T4WzbGWJdKHmExCHNMExVuSpB/4+wdKUia4PvcfkMZqeWQhoc+HYGmo+D52E1ywJxXThjJanwmlI//u4uTaKXML2yVqmuJ0j5OAG3LLMmIoBvPf7gzvFW4e3Ej5J8KGTS0zF/pjpmBGdtL7UvFvIqBaT8MdbqAZEKLc7eWy3OFelHNrzvYk02/bFqxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKNHHl1U8tUq7nyUEHEc3CnJSjff/vYdqovj84tJrIo=;
 b=UtcQ8NFp/Tyb0h3Bps9XyyngKq2uPqGpKhuuAsM99/EafoBD4e+btg3pdKKs+M5W6HpbB05Fz26RafFVOqMaqrohWzxZbcVTRO1QW5LBKPqrprhIaZlLwdUtp3ogq0+DkCHi4dlwOTZgFbbXTva0TcCXsIHPsoHZHsvoYknahzz3uGwGcje2qkfIdm/EYqJzavbT61C4Jv75EojXvM89x6jg6Ry4gJH5GTvfJJhgzd/dNHHUAPrYPY/zOa7oE1AS8He3fwDVJNRYch24QbJdA1Ajrq39kh9FSrpUIOzR32/Zw8PVseAdrNUJqU8Bp7Rs5QEkPBOEfoo9lIbmlx+WwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKNHHl1U8tUq7nyUEHEc3CnJSjff/vYdqovj84tJrIo=;
 b=HUVa8UUkFLWl7ZcWmid40zp+rNg6+voYEzuPfgm6Mmh7kHOu9xuWnwMJCa6QGIXs7H728tlKyt6rRdJhjvxaUYqUfvnW8wBLFiDyV7Le3BLhPVJrE06trdMDT/CEUnC1/LvWOnoxLBMasyfBEwkQ7xCFpnND3kL7Nzub99vgw5I=
Received: from SJ0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::11)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4c8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:47 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::b1) by SJ0P220CA0028.outlook.office365.com
 (2603:10b6:a03:41b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/21] drm/amdgpu: add VPE HW IP BLOCK definition
Date: Thu, 24 Aug 2023 17:31:11 -0400
Message-ID: <20230824213127.2725850-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SJ2PR12MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: f57e53df-b124-4c7f-6c6b-08dba4e98539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7cDaigkvEtPZ27n93L3Q1r6JcwW8odBYrTHAESmw5icGUgOTbRN6FazZcqXL9L5x0z37ZY5yzFxUS/sifpUYkzHlPtfilQyI/FiPL9xN7QbW8ERKn7ZDTvuaXpJFdOuZUIFG5gX1Qg2Fkb8l4I1gBxvTgUp8KvOcRT8+TUqnmbDJbUefG7t1XclMHtDa9yDMdDJu8CTF7Wnuc2PAR3KVy6pUMpx0WDH6PiO2c60YiMP42r7Osnrjk6Rqsqd8byGXsP4it7XT+DRI8wp6X+m93XFOVzoYEkathNNZjoBf9ZsjX5kKbdvxDEj0eCJBdM9bdLFDn9iTkjUiO3tnrOlnz8CmMHSySxwZDHnNADnuXWHL8sfOJbYi7CWoNbRV9v3Hzb4kTkUMykITkLxpPs8s3qhWH2k/saWIUxbX8EbMgIqpd9hAoZhqzbm+fEgLM+APNa29DDE0aXCHDhMmxqetZc3EQFbD+5DLM6oGHhBVFDJnnatBazw7MchNpV35njZDbDjrvorcsl2l+jpAUJJsL8N4VYzLlbMR3bBapAG77uMyRwYxhOl3Y4hkNuJDt4fqYmL/ueXvpiJzv+Ao27hh78ZnK+3e6xNDVv3ChoCYxkMbc5ItHoDEnSO3vGcl3cEmlKZTW3BXUv4JYWpj0u8B/A2ecnQ+z8Sz7JP5ohMh3lBDb6PT6ID5u67F6jtbDsLhJAYjEjpaj+pKpUmrt7LsuoIn6zAc14azW/sCqIkwBuuUsQwgBH8GpqAHFCd9pnVIZfw7mY27XpA6zSzkyu3MA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(54906003)(70206006)(70586007)(316002)(6916009)(478600001)(26005)(36860700001)(356005)(6666004)(16526019)(40480700001)(82740400003)(81166007)(41300700001)(7696005)(86362001)(2906002)(8936002)(8676002)(4326008)(1076003)(40460700003)(2616005)(5660300002)(83380400001)(4744005)(36756003)(336012)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:47.0962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f57e53df-b124-4c7f-6c6b-08dba4e98539
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Add HW IP BLOCK for Video Processing Engine.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 50cbdbf18573..6827ae37ad80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -655,6 +655,7 @@ enum amd_hw_ip_block_type {
 	JPEG_HWIP = VCN_HWIP,
 	VCN1_HWIP,
 	VCE_HWIP,
+	VPE_HWIP,
 	DF_HWIP,
 	DCE_HWIP,
 	OSSSYS_HWIP,
-- 
2.41.0

