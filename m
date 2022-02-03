Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C491C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Feb 2022 23:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0353C10E154;
	Thu,  3 Feb 2022 23:14:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2902410E154
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Feb 2022 23:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kajzaf5Xew4yGzG/4H3gkg7sv7p8XlMkkfhDBSqZOA48cNNe0edQBOB/QiZe93QvF3u5k3NCkbpqWkZKnlCpnTALrCI5oqcClMjkzqpf4yhtRWXTUk1FVRebPsCb4h2MxnPzPJcn/Jpuwc629pOhD9oLaPWduhPMyZf0gZsjyND0UBClkUigLgp2QdjpxDPIZV0BD4MVIbowVgr3FyWipOoS8RfBj88KcEe90ce6kePZCcAHVehmFLGK99WfP5Fv/ErOXLmQ6e8SyjtYSMieW0QnC0wS+vXfTsNzKrmA0Gr3sAVVk1lO00dT089A1hgXPZ2XGc/5XUfZ3sXpesZ2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2UsYQBDA5TtBVDVs9Uf4qWIv9jf8CTAwfr3607/G/I=;
 b=JRcZdVCnEm4gdKWu9AtAKrnslOkFl9etzlBrpPHCYE7p/jb9nmR8I0QeXLeGLswRQzNH41zMmHsj5GUfrV0ZpF6sWl/8jd69dkml7mukb8eW6EtDlIJfKcsHcUM+NP6lkn5kpxI0QrUf01j0toiZTyEjBZllCLJvMNLXHiJLUk4TeJVh/vkoSgGaEXllEd3Czd7Lo74lTjAdl4Hj7lB3pAWGwNZdafs2BfQTgAE/RpAutc/3DFBtk/92YWrY8PZkJ4Jgo9yGu1csurHMaMi+O5M9a4yvpdjCqFH8wkDQUoF0s+6mF987iVOS/ujSSCCGnL+H5Ova3rnittVnAc7rSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2UsYQBDA5TtBVDVs9Uf4qWIv9jf8CTAwfr3607/G/I=;
 b=RqgymLwr2QpsEd6c2sd5m0hmMamzA0DY7NBSrrJ3N+ilVdsdJzveZ4bvXGmhiYVovq0VWXD4nt9gAMRYPokUdvfWQv/ib6ybTbCvIDy3qJWKwwt7mhkFPvsWENEc0u8BHcGGvj6hdc9Wf+jC3OiJnuZOCtaDCjz6kYHukILfSDU=
Received: from BN6PR19CA0097.namprd19.prod.outlook.com (2603:10b6:404:a0::11)
 by CY4PR1201MB0134.namprd12.prod.outlook.com (2603:10b6:910:1b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Thu, 3 Feb
 2022 23:14:15 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::ae) by BN6PR19CA0097.outlook.office365.com
 (2603:10b6:404:a0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Thu, 3 Feb 2022 23:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 23:14:14 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 17:14:13 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1] drm/amdgpu: Print once if RAS unsupported
Date: Thu, 3 Feb 2022 18:13:20 -0500
Message-ID: <20220203231320.114539-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.0.3.gb23dac905b
In-Reply-To: <BL1PR12MB5144C64B0B4E525FC97EB522F7289@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <BL1PR12MB5144C64B0B4E525FC97EB522F7289@BL1PR12MB5144.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdf4ebe0-19a9-431d-4cae-08d9e76ae509
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0134:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB013467A39B0034EF2839F9AC99289@CY4PR1201MB0134.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:52;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nn46xzpj4l2doCMQzl72QB4sJZphQ3XZ08ld81mJbxDqHhVtucLHDukh2jCvuZ/FlHH0Zcil5skRTxyBvSGoQiFjX6n5A8R1lLvdIZt9Zkv6sCn3a129pNWX44w7uWVBk9EBuBbIQ8EhT3nIMB1AdPMR2gC9+AVvGWPr/qu3zZ3OcziemZ6OiTe4IW5IYF4/856Wys3H8u7+ItVBitC5GobylaZEcsPGPdqwSGOBlaydJanfGBSB9t8hduvnG7WuTiDdNax7590CXTJXAbGlwJ3XJL4CK2+3Z0KMvRsuXdkPyBgN5PqTr4bhTIXicQ7365LQZQL8/hcYdGk0/Jw5vcNcsqrqsKscbID8srQSFGO66ehmh3cn3Xm3JrZfjOGoB70fmdxULHOEoXF1KIompGcl/3aDfwuYiCQRrfPFPMnfdSfX2JRsvZTUlNf8imXYV3T1dTML3xL4MK1u6/J/VaAqcB0lsB9olntcSsblc3/rEWPUdZ1/2l4qJTMysLPpKtnZmoHUcozWtC/trqen+R1W4KK9f9Juu+y5sODdjhfl2AIo/vSCRxM3F/lTo6dsCkAIRxyYDtJ4aYvsLyedxixH/RH6bwdh69G44mnoAwLTb8nrGyM0ZNWyKSHHo05v/2UUkkUlGs/4EFH7JeTpEHGG5JwjKek6I7HP2EFxGzA5DdyUNczxp8aqUcziI2yF3q3/9uTYul4xaj+3i0JKJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(83380400001)(4326008)(316002)(6916009)(36860700001)(5660300002)(86362001)(44832011)(356005)(508600001)(47076005)(336012)(70206006)(8676002)(26005)(81166007)(7696005)(2906002)(426003)(70586007)(8936002)(82310400004)(16526019)(6666004)(54906003)(1076003)(186003)(36756003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 23:14:14.4152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf4ebe0-19a9-431d-4cae-08d9e76ae509
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0134
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
Cc: Tao Zhou <tao.zhou1@amd.com>, yipechai <YiPeng.Chai@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher <Alexander.Deucher@amd.com>,
 John
 Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MESA polls for errors every 2-3 seconds. Printing with dev_info() causes
the dmesg log to fill up with the same message, e.g,

[18028.206676] amdgpu 0000:0b:00.0: amdgpu: df doesn't config ras function.

Make it dev_dbg_once(), as it isn't something correctible during boot or
thereafter, so printing just once is sufficient. Also sanitize the message.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: yipechai <YiPeng.Chai@amd.com>
Fixes: e93ea3d0cf434b ("drm/amdgpu: Modify gfx block to fit for the unified ras block data and ops")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9d7c778c1a2d8e..e440a5268acecf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -952,8 +952,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	} else {
 		block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, 0);
 		if (!block_obj || !block_obj->hw_ops)   {
-			dev_info(adev->dev, "%s doesn't config ras function.\n",
-					get_ras_block_str(&info->head));
+			dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
+				     get_ras_block_str(&info->head));
 			return -EINVAL;
 		}
 
@@ -1028,8 +1028,8 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	if (!block_obj || !block_obj->hw_ops)   {
-		dev_info(adev->dev, "%s doesn't config ras function.\n",
-				ras_block_str(block));
+		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
+			     ras_block_str(block));
 		return -EINVAL;
 	}
 
@@ -1066,8 +1066,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	if (!block_obj || !block_obj->hw_ops)	{
-		dev_info(adev->dev, "%s doesn't config ras function.\n",
-					get_ras_block_str(&info->head));
+		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
+			     get_ras_block_str(&info->head));
 		return -EINVAL;
 	}
 
@@ -1717,8 +1717,8 @@ static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 					info->head.sub_block_index);
 
 	if (!block_obj || !block_obj->hw_ops) {
-		dev_info(adev->dev, "%s doesn't config ras function.\n",
-			get_ras_block_str(&info->head));
+		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
+			     get_ras_block_str(&info->head));
 		return;
 	}
 

base-commit: cf33ae90884f254d683436fc2538b99dc4932447
-- 
2.35.0.3.gb23dac905b

