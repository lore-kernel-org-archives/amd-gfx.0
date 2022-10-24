Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF627C67871
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 20:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD70910E7A9;
	Mon, 24 Oct 2022 20:21:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B1AF10E7AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 20:21:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzcVPnRKi7iC7cJsFBNBFxZqYeTdt8cTP7+jPSEVw8XGgplciQHLaaNNF8H745sGN8zivb1KZzvmwrBpvopzzDtslPNV5bLqy6BaeqFgGn2xcZYbiiiw+T9ZTjNNgnp+myyNHHtRbbwXJsWRGHTn9NhNYA9ZjNCVEfF6onBUkIU+W+N0OL2Wf34VYLKP72/FKrx67b4hxXS2in5sTcBFDEZkU8gGdme+MieQE1HVg1oavFE+ax0lz8DdMalzjPiD1rzp5YYlHMZiM40wM5qYov2r+EP1bgxw99gsNAJPUy5E1B/YoisSLPO0hQLmgBeXNqpQ4NJYSkFQWx/X+wu6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KB29d8nTxdb16utxN+Rx8j+Ia2yUeXOdzkQbSomK8SQ=;
 b=nXvcTsY+pK8xu+htU86qIJJQG35SfJ23tGgKfr5mHCIICROfGeg6K5ukjaFp/qyismYVJzZnatmpTm9ueqoPK8krSoJs8fhrPL2fkbpsnbxPgi24LJK8MR6HwL3WMgvdYMVq+dg8Mn3JNAQXAs4dCCp9QdDoenBWu/bP9b2DU6rWsCZikc/bVfVs/nv9t0rjedFOUwW12MosTgQim0stCkULw53Moj3tqG3kji5alXSpLKbwfnNHHYPr+Dd3l2ibCNsBPX6dB95AfGNash2evmddFNrm3eQXmvopAHcus1Tk4a8Oj/ZCouI4noND9vvX8K19fUIboLTWQe38sxB9qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KB29d8nTxdb16utxN+Rx8j+Ia2yUeXOdzkQbSomK8SQ=;
 b=I8bkvX0GOOfFJmPCd7C0LH+U6WSvywbsoTaEw/rYSwe45JkmUTAktJI1cuRGsXU+HCgmtAo3wjqbBX0pgoYxQUwmsaXfnpmaovsyKlKfULJqNaehchzyD3Kup0P0vjM3JOgvuN/mEKHla6FMbPJ47lC8ak+paWdk1erPpn/BYx4=
Received: from MW4PR03CA0271.namprd03.prod.outlook.com (2603:10b6:303:b5::6)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Mon, 24 Oct
 2022 20:21:42 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::28) by MW4PR03CA0271.outlook.office365.com
 (2603:10b6:303:b5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23 via Frontend
 Transport; Mon, 24 Oct 2022 20:21:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Mon, 24 Oct 2022 20:21:41 +0000
Received: from vm-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 15:21:40 -0500
From: Gavin Wan <Gavin.Wan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Disable GPU reset on SRIOV before remove pci.
Date: Mon, 24 Oct 2022 16:21:24 -0400
Message-ID: <20221024202124.8592-1-Gavin.Wan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT051:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ab0864-b42a-400c-9be3-08dab5fd5d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /fBrpyjoVSGbpxBl/YAY5te/ZjeS8np5uenMnCC//x89GrchGTC3h13zakIzXRT3Ws9U/TqjaoT/EWIrEWyfm/TqEI4IQpo1EcOy3R5ep1N6ylIuYA3ZmlbW5qX3CenS1B04A3ZInBI/lhtdLuRIV6MD3x6VrbKcEFlu7dEH1SWBw2RqU2cZ95SQ4B0s8oRO1SfjfRSZPlkqDmT5t9STm6fa90IomSupCQtIOp5PG+paFCcXzLMWXvc/27m2YvSb+Tk64HtP2OW3qZrofzNhGuAp2f8CH+YOTdnHD9knf0Ikl/xwopNervDYP8QpZr8F4PgspRFwthj2vdMuhx4fdNdcwmlSIvb40U3fL8uk4fvu2cEK/u4/Efqs6YPFhDXYwVmPQYzbL/lkUVsqdoxzfxXMm9N5McT2FPA26XBpJkKL4t9fqFh/QeMkLH1e8ALSEwmFoQce47CrtCtl8CNMSSQ5tjYzqzBB7UQjdYbQMp29l32AGrSv8Mz7+WggmvMhmiJxwVvi5G8BXLEH49s4Q9eciDWw8LzZYz6mmFTwsbV8sMWzmTaL+ZuQUUO91VzVG0XaJTOqNfNiXpADUWSgLDo+dXikfE/FPlQ6TBvu1i6Q2nARS9yvfIdG8gDM5DYW4Q7gJzhgy3aD+yT5ou/eaTgo62X+O//S4ql6lliRuWnbLVxWTVGo8otiaeemWSkuu9SAHKJop1NTdgTt5H2ssDKxAMzIFk+MjtkqY0qlWzj5Mo1J1qD+sXi0/0A7UldibOhKYw/bEp1Lbtfptfh6oxLIafrlCojggWOPmD9YNEQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(4326008)(2906002)(70586007)(316002)(8676002)(70206006)(36860700001)(5660300002)(41300700001)(36756003)(86362001)(8936002)(40480700001)(54906003)(6916009)(82740400003)(7696005)(336012)(186003)(16526019)(26005)(6666004)(47076005)(426003)(81166007)(40460700003)(356005)(2616005)(1076003)(478600001)(83380400001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 20:21:41.9841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ab0864-b42a-400c-9be3-08dab5fd5d36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Gavin Wan <Gavin.Wan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

  The change of the commit f5c7e7797060 ("Adjust removal control
  flow for smu v13_0_2") brought a bug on SRIOV envrionment. It
  caused unloading amdgpu failed on Guest VM. The reason is that
  the VF FLR was requested while unloading amdgpu driver, but the
  VF FLR of SRIOV sequence is wrong while removing PCI device.

  Fixes: f5c7e7797060 ("drm/amdgpu: Adjust removal control flow
         for smu v13_0_2")

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Change-Id: I1ff8dcbffd85d7f3d8267d660fd8292423d2f70f
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 16f6a313335e..ab0c856c13b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2187,7 +2187,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 		pm_runtime_forbid(dev->dev);
 	}
 
-	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) {
+	if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) &&
+			!amdgpu_sriov_vf(adev)) {
 		bool need_to_reset_gpu = false;
 
 		if (adev->gmc.xgmi.num_physical_nodes > 1) {
-- 
2.34.1

