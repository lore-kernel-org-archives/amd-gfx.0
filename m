Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C622AC04FF8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 20:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 523CD10E54F;
	Wed, 20 Sep 2023 20:02:25 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 635AC10E54F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 20:02:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKsC6AOV7H4WYOovZCdb/LCSmMkqUGa6cGrZqeDER5VNcukTMmPmVzhQRnzb6ZqhXUJwBmpcuFcB+9QWofZ8Cyx9qwGJSSRR1bDG/J6CXzw0V+j4ICyYQW5n+b4cCP9WPOoLloc85TGfRmK1HIMKZr61sJZ3NYqd6/wV9uDGliUUGn7bZqFiMsuyPsC6+qiQpxdUhdAAYMIOV42CaPH/AK+vARA7CU7ldnIgnKjotsCktMnV4jwdpwlroE4AI6KcefSjHxl5Se/dtKDwBhWTG92yeg/7yLYI+cRXdWOUV+4QXjPekc1U4717cuk5nKKC64Pe7+oOOOHG4f+1w9/7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biHY5VMpYICvDlquHHhex93g3dRBCAyt82cccN7aedA=;
 b=F1yu+I3MmMC9v83Neg0R/zB3Igmli5550K1j7V13xx1EasUKQPShUbYZyM5hAtxKq8K0//eaVmBgSG6cwYpObt32IFNhvZj816lDvC3LQMAKD1Usqkrm3JDek/ay3JxLDUQg0Zc1j2XGbI/jIihfd0pqHAWLYsrRCRgD/TezaInbhvssoML8FFMmzumihwarVZSrHG2DbxT4mwN/Hw4Wxnw3+3g//5ccd/MNo3tpNl6jUEvfOs3jjByuum6DWdA6LUZDFexdvwc66QZrMxezjlo3uVEHn8Tt86ugTQDZCBAUf4fVnaG9136evL3o7OH2OJhdGHM6kZwIrII5VWF/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biHY5VMpYICvDlquHHhex93g3dRBCAyt82cccN7aedA=;
 b=cuBNK5j2re+IXMB/nnxd76/sfuH6/FBkj/PXSFo0huui8qVGobACruTud2ZvsS24OfFq0aekr9EI3NqPO9Zzp3GkkchHUHCEoqBHPDZBva5PMWyMNGwJUlOIyXbZv+uTgzgkuYSb2XEJcQNJ8XWUwAT1x6RZTD94pVM2PE4Q++g=
Received: from PH8PR07CA0042.namprd07.prod.outlook.com (2603:10b6:510:2cf::8)
 by CH0PR12MB5058.namprd12.prod.outlook.com (2603:10b6:610:e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 20:02:20 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::36) by PH8PR07CA0042.outlook.office365.com
 (2603:10b6:510:2cf::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 20:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 20:02:19 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 20 Sep 2023 15:02:16 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix ip count query for xcp partitions
Date: Thu, 21 Sep 2023 01:31:55 +0530
Message-ID: <20230920200155.1728471-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|CH0PR12MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: cb087145-dd17-4feb-ccd7-08dbba147ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZrOeunFjcTxX/0mlE7nX24HrAZANDkCGjRz3Bkb8gyeLEtt2f6u9RruVMBKr+MjCZsCnOj2CcHJaDdlnLlvYOvw8bOyX0w0+LQhWr5/NUD/NeX7CIwrMkG3sVvAFKw32ln08R99isMGZsODMLKKLPYLsuI/GGmyZ6n98kTi/Ie0crHprS+pLd7yEL7GcKOUYUIiwBVgbkyOachSIapz0G+z6sIUtAuSNURJjOTJVcPRGBwWN/F1YdbMbanaQW5Iu2dvVe67dBQGjL44i5RI9XIcbEPBTBMY+Ekhtk/pbWlub+yVRxxubI80astEZasRWYDh4Tr4wu03frWSmxYOD95niBPcRhl2XKIE64M2oAeRch5PH6rdNP1dAsXLIFW4Fk4nAjuy87d9K6sQpY/wATv7+48tH12HwtKqqWMwtLw+uuBXOCTrZMtqbaDXOI7+W14c3Wb/8hJ2VVNs1KCScXPyGkmQCpBnpoovTaPRbjtFJCij2iY6GSrK/q0D0MZoH+2y5HRrfAYfIfi68bFqh/mWL63rtKr49tV2Oi+ZzwxlSvEIi2WMHxQHk15MCFEx1wa5cQsLsVAQLAbzi6ctY1pmJvFccN0Qlx8az9r3CsgIeqykwAVtaKrEH3q0/cHL9h1o6vMzUA63JfLGSXWwF2Kw+nKlW8Ed2o0likb6qjfnypsTB3tM5x+zUQV69C6tjldu3NYEpoQmB3kJpqJA1Mofu8MMN88rGwMopVpwntxppF4o4Gu/zVfhYEMQDvVEwNqWw8YdRvfjXvU7Vec5iA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(82310400011)(186009)(451199024)(1800799009)(46966006)(36840700001)(40470700004)(478600001)(40460700003)(6666004)(7696005)(83380400001)(8676002)(47076005)(26005)(1076003)(16526019)(2906002)(426003)(2616005)(336012)(54906003)(70206006)(70586007)(316002)(4326008)(41300700001)(6916009)(5660300002)(8936002)(81166007)(82740400003)(36860700001)(86362001)(36756003)(40480700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 20:02:19.3337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb087145-dd17-4feb-ccd7-08dbba147ee2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5058
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>, Leo Liu <Leo.Liu@amd.com>,
 Koenig Christian <Christian.Koenig@amd.com>, Srinath Rao <Srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix wrong ip count INFO on spatial partitions. update the query
to return the instance count corresponding to the partition id.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 081bd28e2443..42348f61a5c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -639,13 +639,45 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	case AMDGPU_INFO_HW_IP_COUNT: {
 		enum amd_ip_block_type type;
 		struct amdgpu_ip_block *ip_block = NULL;
+		struct amdgpu_xcp *xcp = NULL;
+		struct amdgpu_fpriv *fpriv = (struct amdgpu_fpriv *) filp->driver_priv;
 		uint32_t count = 0;
+		uint32_t inst_mask = 0;
+		int ret = -EINVAL;
 
 		type = amdgpu_ip_get_block_type(adev, info->query_hw_ip.type);
 		ip_block = amdgpu_device_ip_get_ip_block(adev, type);
 		if (!ip_block || !ip_block->status.valid)
 			return -EINVAL;
 
+		if (adev->xcp_mgr && adev->xcp_mgr->num_xcps > 0 &&
+			fpriv->xcp_id >= 0 && fpriv->xcp_id < adev->xcp_mgr->num_xcps) {
+			xcp = &adev->xcp_mgr->xcp[fpriv->xcp_id];
+			switch (type) {
+			case AMD_IP_BLOCK_TYPE_GFX:
+				ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
+				count = hweight32(inst_mask);
+				break;
+			case AMD_IP_BLOCK_TYPE_SDMA:
+				ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_SDMA, &inst_mask);
+				count = hweight32(inst_mask);
+				break;
+			case AMD_IP_BLOCK_TYPE_JPEG:
+				ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
+				count = hweight32(inst_mask) * adev->jpeg.num_jpeg_rings;
+				break;
+			case AMD_IP_BLOCK_TYPE_VCN:
+				ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
+				count = hweight32(inst_mask);
+				break;
+			default:
+				return -EINVAL;
+			}
+			if (ret)
+				return ret;
+			return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
+		}
+
 		switch (type) {
 		case AMD_IP_BLOCK_TYPE_GFX:
 		case AMD_IP_BLOCK_TYPE_VCE:
-- 
2.25.1

