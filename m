Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451CCC76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 08:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C8E10E4CE;
	Tue, 11 Apr 2023 08:02:33 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1774710E09C
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 08:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxsaH2Z4+AanxCVzT4OdSTzcVnE2GTH6zJYZZn8UnT+3B2oWGgk5OkBsbdtU8gNEnZICNwAD1m1jayjcYpucOHJ7FXLJfAhpybXDcEtPla9altGi+SFpXhWqlIrdwt29UoSSnX7R8dK59MPX5vxhb89pDHCo1BfRZ0fouqhh5sjBbxI7O8dru4ybq6zc4gL3wn/2bsa72Ic8CiztEubYzyX0xvjc5kXApisGjaI8dmAnJ2tMgbxTjB9SMoHehLY899uJpB/COeOvRNdkF9HKUFN28erMlc07W99+117zcjlrR+T76eWDYTBO/HLjJ2IzXYtczHqqgvq36Jf2Mrc2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfGfjR7tJaBOBKRtzGHW383nDJWefF4fYUtHFQ8jOlg=;
 b=EB1tM5mFxjij50lZmGbmIJ1LEP1CZUBqJ259ILkfi4KETxCBBNIg7nUmJkmqWYLwMKDKs+NxKNmWbPGINdJHJOR65KFcB6SXyNDweK0FpKDfxUANiHkBfxb7qAbdWnGCrSFx2MxJYMlsVDJiwShaHwJ3u+OxxZa7RWorySgKghLmmMWvM0w1F972dh0IwPO4UQwWuJoPQ1uK/KRum1KUlWKwRIV1c6zaCArRUKRhrNatBbdzqvy/gnYRxF3ANG/I+0mm3X5vvS+ntSosq+JJGCqFJ8jvFgfE0YXlRRzXgrXHrKmSIaOuOpwfbZlvGh7R9cvRFdGJcpItFas/IOmSlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfGfjR7tJaBOBKRtzGHW383nDJWefF4fYUtHFQ8jOlg=;
 b=M2JX7WmtLRrKE1F/Q0eS56tckxbUtww3a13ezqolOvDbujPp9uF3hjsWYxeI/KvR4mM7bMMyEbxalX0S2Bs6yMCE5rkV5ESVhia5Mo2e2B9fmjN4wmgoQmUDFUGybPIJurtxSeJ6lwQN20XdNx/i3GTYCUEcHXmaOPpB5luMm1k=
Received: from MW4PR03CA0133.namprd03.prod.outlook.com (2603:10b6:303:8c::18)
 by PH0PR12MB5419.namprd12.prod.outlook.com (2603:10b6:510:e9::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 08:02:28 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::60) by MW4PR03CA0133.outlook.office365.com
 (2603:10b6:303:8c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38 via Frontend
 Transport; Tue, 11 Apr 2023 08:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.28 via Frontend Transport; Tue, 11 Apr 2023 08:02:27 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 11 Apr
 2023 03:02:25 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add gfx v11_0_3 fed irq handling for sriov
Date: Tue, 11 Apr 2023 16:02:10 +0800
Message-ID: <20230411080210.703504-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|PH0PR12MB5419:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0223a5-a710-4e6f-a97b-08db3a6317e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wr4Q8gI0fG1rULlDlrGT18ZvVCbV5qsAp0EfftixWMn+mqYltfio4pvpDTu0ZTa7kEMGm8m05+z1802LIgBwce8E+AD94U5Uo6VkrPaDl1N8qDg5ViZMvIpq7C3kBKK0wYtHKpAA4B+OcqciiIILMfDb/BZaFUAJhO64B92FextTQiIO+a1NgAgFG76oyJ2ILEFlQEjcoMp1xxI4xAvaV+aX4EGoxoiXd+woEn/1uUl86asUL67AX1WUF5pj/+eysGvm59be1SCiKpGNZ8u+61lfekRfPyodn4+4GDEXPD4+o9z83LaTZZadjnskfCpB0pwdaRXdIcWKsdJwByL7L8RPFGO7ZeqGpS4TzROibposnQvuVgYrVqmr2RLjBcFHS4ObUX6hu3+TXtXTMmAnIcEzQyFbtRqYUO/hxDLU6Vk1oN7vqbBQs01ni5ufndoKpT58YJBgTI6CufAhOI5Xe8pS3hTBYBIhaqa8NJQtPTIm+nPHgJYOSoO3DdYdKlbh/1sOvjBc0fz5RFBNHONgZCqPRv0Rkfi4HqzuC9b0mMgBfMUXX0BfQ5D0nX+OAo64NlBhWTL3zE/s1RtYGchdgcPCUG7lR+Kj/Kd/bTxhQ4pZsk7VbnhXRuwm7cuWKH1gNBnLn5PqfL2AJOqKKFxpPncFsJjVEG9zdrca22FB0jsj7touQjJRY78rUNgMemCcdcCvjv51zgbNfSbaAWO3wDz5MRC8/KzLTdGO3eTEjds=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(70206006)(478600001)(7696005)(54906003)(4326008)(70586007)(6916009)(8676002)(41300700001)(316002)(86362001)(36756003)(83380400001)(426003)(336012)(2616005)(26005)(1076003)(6666004)(8936002)(2906002)(40480700001)(5660300002)(82310400005)(36860700001)(82740400003)(356005)(16526019)(186003)(81166007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 08:02:27.7461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0223a5-a710-4e6f-a97b-08db3a6317e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5419
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add gfx v11_0_3 fed irq handling for sriov.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
index b07a72ca25d9..068b9586a223 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -62,10 +62,18 @@ static int gfx_v11_0_3_rlc_gc_fed_irq(struct amdgpu_device *adev,
 		return -EINVAL;
 	}
 
-	ih_data.head = *ras_if;
-
 	dev_warn(adev->dev, "RLC %s FED IRQ\n", ras_if->name);
-	amdgpu_ras_interrupt_dispatch(adev, &ih_data);
+
+	if (!amdgpu_sriov_vf(adev)) {
+		ih_data.head = *ras_if;
+		amdgpu_ras_interrupt_dispatch(adev, &ih_data);
+	} else {
+		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
+			adev->virt.ops->ras_poison_handler(adev);
+		else
+			dev_warn(adev->dev,
+				"No ras_poison_handler interface in SRIOV for %s!\n", ras_if->name);
+	}
 
 	return 0;
 }
-- 
2.34.1

