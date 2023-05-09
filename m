Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4431DC7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D4EC10E42B;
	Tue,  9 May 2023 22:20:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF0C710E405
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:20:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6qCRBPGlQVlwBaOz/i99GobsmELCN6zqUovuh+RrhQwPy5K85PAY6+6AYPig0ZXbGH/3FcShWe19FmCa/bELNGA3hU5Wk9Hy+RXO/b58GWUiiIebd2GRsmQU0Txh6Vw1VHCs6gx1eYJpwiBH5p29ch3CHjiQ4n4eTyngiYD8cRyZorWdMHotio2pCcyDfLRNACqWeWCEgGa/VQS5XWrCj3wf8jF49AJ0M+jj1qusuH2tT6yF9/g5gDrdmgzXmCqSHdxcyLw09n4EBuQ3Wvlf+k2FIDl5w3TotxXrvDNYQqEgzO+l0ZexIMEJAL8EZ+RWW9/Ubm9N26WnhNDeaOsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5a5ZljVJQ/BOlVJce6Bm7nVuPgYVfsJGtn8zPnbGck=;
 b=KTQNWzXH3AbZyvPUBpq2hfjHDg5PW5fjDq/XujE9onJZXr5Ip6/wgiG7JKlMqQgT3fFuWO4g/nHpP05nx7T1v2Wj4Q6EyBfbcipnQRsTiqwbhQd6DHtnmZwnDm7MpszDSVTGWd1bLurZiZO0vVvxMc5uKCjXfbm6TlOO6//HyhmP/kQPYOiX828oSsvKDyJbtO9wEb4IoYkT+oPN+QQbGLkeTgz1BC40ETHBoURVrMf/QOg3hrEbG0CvLEl3r70voiGQ6oRChJxywo35xJ1ebbNXgffGSQwsDrlkclaQjnx9ZqP0+0/wkjHBHXjUvRO3V6pwdIdEcOm3TXwTNDB9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5a5ZljVJQ/BOlVJce6Bm7nVuPgYVfsJGtn8zPnbGck=;
 b=MRUxx5NrWRp2tD6QPu+8bzXkRVDHtE3CkZTioP4sPZpG9861UP0KXOlTR6k6Q2XqvEVLoDklJfPRfj06vakFUDfWMh6yKzqMzmWS4YtSxSnGDSgLozUoFq0YIZOBUxNZ0ulDLirnZ2wOLz1cAEZaP61DIDgpEO35BU1xY6c2SCg=
Received: from MW2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:907::22) by
 BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:20:30 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::c8) by MW2PR16CA0009.outlook.office365.com
 (2603:10b6:907::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.34 via Frontend
 Transport; Tue, 9 May 2023 22:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.19 via Frontend Transport; Tue, 9 May 2023 22:20:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:20:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: Set memory partitions to 1 for SRIOV.
Date: Tue, 9 May 2023 18:20:10 -0400
Message-ID: <20230509222011.477547-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509222011.477547-1-alexander.deucher@amd.com>
References: <20230509222011.477547-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ce2eb7-f744-471f-ec2e-08db50db993a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IKpp97lu5kngMOoGly6vNMdWi+ZelJORQByVonb4PVmPLPEA+Eb5eKy9/z5vCnfjXu0LJbMvM5jWnG2eax648TceQwyPhGsIgvlMMOQRKtQBr9Ww99NXku03b1CYST9psYQn3gTf53hiKigFPtFF+kkpEN9LEuZdlGe8lNVVGMzXoufYSAW6JNH7RIL40BppXsPRgsMXmTg9jZduvw8wvU3SqQY7x7i5cBZg8PUkb/Pg5pP/xLVc/uSquqEezzEN0ad3pmfyquMWxb+5BUFBp+28XGcnqluoYmIdepykUOPKQ//nF36liNGWFJEfSUg2RJnXlJfUX2a3sg5F+O/bifbQOSJl19SvKaqyI1wt77PBJnQy5IG5zRt+JlnbQx2qGHKwf44rnByWknVjxiF1VfFOc4ifTN+4qrjNICDZMvQx1WISHdMbO1rFxhcLf3hVzFgGaQitbeqlANTTuREjkV6OXCi2ykp2/mGqiMb/x8vtTvkhPCHpQxzKlgqA1mFN62Ejh3GWe4qik6E5VtU7sKT88JWPodjJ6kR83ikbOIYG1FqNSFiaLykpSNsgH8G4k+PxTwQcLG/wijXsi/mBYJQ8jBFs5wltoALcNDLmD9r66XWn+6+0DOJc4rGSmAqyeqt0ELDCE4rcjFxJ/J/pBMWEGG8knBbx1PWwv+x+MbWxi9q6gJ8NmBDozyn5XAXFkioJjKHg3nmU9VyK4NTlII4cs18iFPqTwukbYpjmsq8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(41300700001)(70206006)(82310400005)(6916009)(86362001)(70586007)(4326008)(316002)(356005)(36860700001)(8936002)(83380400001)(8676002)(81166007)(54906003)(426003)(2616005)(336012)(47076005)(82740400003)(478600001)(26005)(186003)(40460700003)(1076003)(16526019)(2906002)(6666004)(40480700001)(7696005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:20:30.0486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ce2eb7-f744-471f-ec2e-08db50db993a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Gavin Wan <Gavin.Wan@amd.com>,
 Zhigang Luo <zhigang.luo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gavin Wan <Gavin.Wan@amd.com>

For SRIOV, the memory partitions are set on host drover. Each VF only
has one memory partition. We need set the memory partitions to 1 on
guest driver for SRIOV.

V2: sqaush in fix ("drm/amdgpu: Fix memory range info of GC 9.4.3 VFs")

Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Acked-by: Zhigang Luo <zhigang.luo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 394644d9d559..f000e0e89bd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1346,6 +1346,9 @@ gmc_v9_0_get_memory_partition(struct amdgpu_device *adev, u32 *supp_modes)
 static enum amdgpu_memory_partition
 gmc_v9_0_query_memory_partition(struct amdgpu_device *adev)
 {
+	if (amdgpu_sriov_vf(adev))
+		return AMDGPU_NPS1_PARTITION_MODE;
+
 	return gmc_v9_0_get_memory_partition(adev, NULL);
 }
 
@@ -1897,7 +1900,10 @@ static int gmc_v9_0_init_mem_ranges(struct amdgpu_device *adev)
 	else
 		gmc_v9_0_init_sw_mem_ranges(adev, adev->gmc.mem_partitions);
 
-	valid = gmc_v9_0_validate_partition_info(adev);
+	if (amdgpu_sriov_vf(adev))
+		valid = true;
+	else
+		valid = gmc_v9_0_validate_partition_info(adev);
 	if (!valid) {
 		/* TODO: handle invalid case */
 		dev_WARN(adev->dev,
-- 
2.40.1

