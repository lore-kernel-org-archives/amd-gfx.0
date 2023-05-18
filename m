Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45924C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 12:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D615D10E51A;
	Thu, 18 May 2023 12:21:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE0510E518
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 12:21:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9qJ8zgFyRp3MYRXagoVpEr5rV44oVjPcufjjyClf3RYSX19Fwth/dykcXS+JF/iRQsDVN23/4NMwJ8Nh8ZeeCics37u/Riwlkc9tuutvbTrLKLAfVUH4TNrrEqJAoKO1evXtH7oAn+46ij5E7Me2bIJ2vhf4F5vNMfvO4CXjb1e7LZrhwdOny1ltUxHcQmsaW8+y7qmnKaCtFKC8/N4Yql9wZrC2CEpmdMnOwer8y0mZ+e/pFDblAXZvaviyTLvqYL4vz1FuPe44ZG1vMiD5KK8g07NpaIODVixy9B7ckqNK9UmKkb+jCvbFHE6klf0+ux88nnzkFDmzzfIvFHXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eC+GW2ppmJX/ZLGSY0LaemSOzgg902r+5sJJswTf3qI=;
 b=P55OmhQgRfsFJuREmtuIgMeaVp8V13r7PohZroePRJGCe9SKUyKwzBLdIPLJnGsBQoxTrDwle9ZSyV+eiyPP3bEf/QPleKOOCf9Ymf9CPOOOKmS+dMcPClKp2LrQP9V00B6l4CVaSCrqDGK7LPjbY3KA4Ly3hxcLdeKTX87Dhg3Lk4O3wfAtVy3m6Omvb/q5AlRfxOjK0ekhR2IkH/jzTKS8RTWgjevTkGMUEICZzxuSQqZcWyszuDntOQI5Q0/vcsHfOTPb/oTKpvJ6yWcwrfXzZiu9DxMFBwOK2jGIIXMlgbHk4cLDlptlRJ2Zo+56GrML0D4rIOUjEUCVVP7JnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eC+GW2ppmJX/ZLGSY0LaemSOzgg902r+5sJJswTf3qI=;
 b=2yUTtXVlEKRv4N7vM9puJswFnMH1b6NtPRaSgOPZhev/0g60ugr+Txc/ObBp71heSM/WQZleEAGL0ZK0U2pA0IQrd/oovqr0UskxISdyD+TJihvWzfN8TrPYWVjVslRGL3go2qKNStj8cFf92ZQ3uJ0PaW7z2DFxmGAqMeCZ5ls=
Received: from MW4PR03CA0001.namprd03.prod.outlook.com (2603:10b6:303:8f::6)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 12:21:48 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::8e) by MW4PR03CA0001.outlook.office365.com
 (2603:10b6:303:8f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 12:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 12:21:47 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 07:21:46 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/6] drm/amdgpu: Use single copy per SDMA instance type (v2)
Date: Thu, 18 May 2023 20:20:57 +0800
Message-ID: <20230518122059.28815-5-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518122059.28815-1-shiwu.zhang@amd.com>
References: <20230518122059.28815-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d35cdb-a50d-4672-d5a3-08db579a73aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbCkYVDOF5BajMIZO3Hc87AS1j2dWu6UI8GM+U2C4x1NB1HL9RwGWsrAeq1xiLYmla1NetUEdoMVeNOcrRvh2kq17d/WbI3pLaKLslvzLoSXr3I5HZjj3PeXdmfxmgDW1G3v8B3IeMKjKR4ngIXvYYoiLUfP8F8BhWMD1bO0ggXL0RU0G+gJbSmlr/M8WeTFO9oTaGdR5RENk6wLZgY/Sc8FOvM+7jCayUZ9+kEl3IKHS0jfnG11X9vXHQPbUvRWiNRNQb4L89cYpPRJqGwFguLrciaKXTz2WVVoCn/RAFWqoji/5r29oaNozrQkP9W/zQ+peEGxJM2beE2pImzzLcN1E+l19Aa39k5MfJGpAn51Nf/RegTvy16Csp9SOF85wxdKZPwumKlJtcjHoe8p8eXLFCSGRhLwW/o93tla5q8wrar0vXEzVOP5mie3CAJdjjHiIo8YHyEbRoqxFQ37fEH9C1rG9dL/i8a2KKkgJ2QiJYrTyOEbKPEMXg1GLrzBGuQjbo7guQmHEHiyxwS67YRqUHutcpZBgvuuTLQCbUVSUIEKl/x1DGo832QE4CZqT4qCDB3q9716OfPuaofjI2t0XcbLEFHh5Uo99Xctj/B6R2exi9USREIGLLDJndO0EmquwFXQxA1F/8RQhYSLL7Tdnd0Mu+396FB6R8XLTWcGuHcM1GpXzo7RH8xhRzg+OwxKUkjkdjsdw93ODDIR1BXJEGminTSe+zTFr90pwdDiT3Lem5VmeJpiKZ+sBElBjUwdY3PCRfm6E7MCjUJzCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(7696005)(6666004)(40480700001)(40460700003)(16526019)(186003)(1076003)(26005)(5660300002)(44832011)(82310400005)(86362001)(41300700001)(8676002)(8936002)(82740400003)(356005)(6916009)(70586007)(70206006)(81166007)(316002)(336012)(2616005)(426003)(36860700001)(2906002)(36756003)(47076005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 12:21:47.8806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d35cdb-a50d-4672-d5a3-08db579a73aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

v1: Only single copy per instance type is required for PSP. All instance types
use the same firmware copy. (Lijo)

v2: Apply the change into amdgpu_sdma_init_microcode() due to rebase. (Morris)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 231ca06bc9c7..1797b45d0b55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -252,6 +252,13 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 				if (!duplicate && (instance != i))
 					continue;
 				else {
+					/* Use a single copy per SDMA firmware type. PSP uses the same instance for all
+					 * groups of SDMAs */
+					if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 4, 2) &&
+					    adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
+					    adev->sdma.num_inst_per_aid == i) {
+						break;
+					}
 					info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SDMA0 + i];
 					info->ucode_id = AMDGPU_UCODE_ID_SDMA0 + i;
 					info->fw = adev->sdma.instance[i].fw;
-- 
2.17.1

