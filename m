Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E5BC7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9E6410F00C;
	Thu, 30 Mar 2023 19:49:06 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DC4910F006
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:49:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTtfZIOUIDVM+9RoFnLr9lsf/OAgDHsN/Q/ZawKR2s1lqnqdaS+WiqZqvOsBAFs2eYegZ5AbDlpZFEsiJh0vBDQMVs4iVFRTeI/xmYSZJRdF9IeofxlUtkxrz/e0CieqDaHHnW0AsgtPmnTlLwKBqK6I4p97y0h3I91D15JD6eyE3PUJHDOeB7LscXJHq+KQbF3pNJT1f9/J/fx9c3SzySVWz34Z0RLPdJzxQmMWRgrIBGAeC7PxEXGIJDFgjtSVcogVoACa47z2oVFevtY3tXor54YoGkbWJGI6YtOfU5bdeq2LTuBl0IeFiQbBj3HCFcszltNsUnBxeE7aMuxUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8gIW+CEPs5haxMHL80XmTJpSPTvCPk01tUnsYnkW7Y=;
 b=PYKl4T6nczStLS0fXeyNo0FPiDd93liIOw083aifRczF4/1IBzCqEednorOlBcq7KWwBcv2hFYZeRxZc6z3LL6d+BAPJ+EcBKXAhxqQ+ljhN92csXe3FpcuiSTMTwrdmF7O6UPBDPmbrtctY1VklXUda9hjrU91mspcRHsHTwxKaLavvUvwbakZmnysMbKwkHnP3wRgcQhkGyiwhTNN5aqKGVIhuyLmgvneLB9+h0+jrdqswfokrZ2bddeOVm6vCNe40au73gyF+7P9xNNXB+QdfUNmobZNE5iDzIQrZy6Su4FBHqZi95UZbawMTtanc86wx3Fs4eraE3T4uSonabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8gIW+CEPs5haxMHL80XmTJpSPTvCPk01tUnsYnkW7Y=;
 b=pt/u9Al/tsdiSP5QxJ6r9O5EEsLkyxsXttxU5jZh56F6pcXzmMPsytERSgUwo17Y4wiH0DEFk+fyteD/J3zG7roFGXzQJ6jXLP5S/IEnrt2DjyAe+Xl3hbqBu+MeH0+ovJ3wc5OC+24u4uVIlsbLbZgg+nrlSr6T/+vTLACudCY=
Received: from CY5PR15CA0144.namprd15.prod.outlook.com (2603:10b6:930:67::11)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 19:49:00 +0000
Received: from CY4PEPF0000C971.namprd02.prod.outlook.com
 (2603:10b6:930:67:cafe::df) by CY5PR15CA0144.outlook.office365.com
 (2603:10b6:930:67::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Thu, 30 Mar 2023 19:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C971.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:48:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:48:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amd: fix compiler error to support older compilers
Date: Thu, 30 Mar 2023 15:48:42 -0400
Message-ID: <20230330194843.1136162-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194843.1136162-1-alexander.deucher@amd.com>
References: <20230330194843.1136162-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C971:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd02c77-8a0f-4c70-b37b-08db3157ce92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmpCNCJzCDcQIL8talO37eD2D3mEPex81jvLHrdKRjguG4XMkKbmhmjGI24LC9hVjQ9DMUkd2WyyqWKWGTXf0viVyxujQTsl8xjeUyTSX7daVCOvEGiU2OA57WaT850VHx/+mbsTzsb+C0CU2hEloV3984OAnG3DZhfVTVrntImDzywt0G6m2FhNMXlJPPzE4rVxv2EJJZe0aB5PHgrWzMbOcrD9v7iHA1x3ppvx4ALyjrSTuIq+l2MApNAymCn/LaBE8/JT7h2iORMVWMuMaCkMp5m3fLgQAmWbhrVjeHYw6CQdP/FkU4iTmOwE37WUhoZKBJn+pcKS5nqm/OhyglzleHFUPdK8EQ6IZbf32UC7ysLw7s0Un5cDTtdLz3/Ajoy8TdODjIw83K1VqQM8g5iD1CTvPbhkisOLVQUrD5nUzPUsigs3Sc6Z1NPxEvYPdx7YLXVLVhf3LjO4AptvpldwTNIzILWlR/rtj0ydnuNpL86dLgwRmHaJsE4b2a428Iskh97FyuZhNcupp+3kyfV9gISzlx3aZUb/rFZn1JOEFAPs+IVh8e2bZ8fiHWA+8koQSZBwRQXcmD4NKx3QSEnmQ+3ZGt8s8ZZaxBGcFxDnRlnIhabOyFUD7przBkeLhJ5ns5yEV15+PnGL/Tt3qwWPpqYx1MrKlxeR8REe6jzE478t0uDKdMNE+TyJ5QjvWSQSDWSMp9KOsS/VNFEIR9Blgglhfqban5bb9y+o8D4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(16526019)(86362001)(186003)(82310400005)(7696005)(36756003)(70586007)(6666004)(54906003)(316002)(5660300002)(4326008)(70206006)(41300700001)(8676002)(40460700003)(6916009)(1076003)(40480700001)(478600001)(26005)(36860700001)(8936002)(426003)(81166007)(356005)(82740400003)(83380400001)(47076005)(336012)(2616005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:48:59.9599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd02c77-8a0f-4c70-b37b-08db3157ce92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C971.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

‘for’ loop initial declarations are only allowed in C99 or C11 mode

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 55a6ebb940ba..fdc728f678d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -360,7 +360,7 @@ static int aqua_vanjaram_xcp_mgr_init(struct amdgpu_device *adev)
 
 int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev)
 {
-	u32 inst_mask = adev->sdma.sdma_mask;
+	u32 mask, inst_mask = adev->sdma.sdma_mask;
 	int ret, i, num_inst;
 
 	/* generally 1 AID supports 4 instances */
@@ -370,7 +370,7 @@ int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev)
 	adev->aid_mask = i = 1;
 	inst_mask >>= adev->sdma.num_inst_per_aid;
 
-	for (const u32 mask = (1 << adev->sdma.num_inst_per_aid) - 1; inst_mask;
+	for (mask = (1 << adev->sdma.num_inst_per_aid) - 1; inst_mask;
 	     inst_mask >>= adev->sdma.num_inst_per_aid, ++i) {
 		if ((inst_mask & mask) == mask)
 			adev->aid_mask |= (1 << i);
-- 
2.39.2

