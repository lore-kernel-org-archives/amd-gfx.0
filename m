Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13521C54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 02:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F80E10E1D7;
	Tue, 20 Sep 2022 02:08:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F4010E1D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 02:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8pr62NyxQDec36+2hddFB/xuMHTKkL0XM5pkSF60RD2jQm/WYNYrvZ13PpxYZFG3TCb0UAMoWOxNmKtSrMQM6azDGeXxu9aUVNpv9xbeD4pkpG5nhmt0o5n7WWT6lPa4xi/FBz/om999JmeTqlyDFXskkNNf8qcSoiwWNjVPmwtXwHul9EfhuFF0H0o12cSpsjAoaeQTaW49/L5zSzc0Js9ub+9EBMLlI40rmoxxDQzFhhRBHeu4tly38FgHQIHEFk2xpME70GCjoM/bbQ+92ib9V64Nu3G3H3GePtY/RkiTLH3eMkEP/XJAhTzipc58BoTcm5g6lYk0N+/irqR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0htKVHa1xQ1OcC96QqN/3moS1iqo77uPhKTvkZlszTU=;
 b=ZN5wPVF9MDNoYR83Nm7UkQkP8ZijfITxRJ2QCMG6T/r6Z5xw981Nl8S9BHRvRirBAn61LcL+emrAm230xcOnspMsJiPAYKeETn8EJeMeHvKOIe/wtvLGjDIrUQOvRCv/k9IudtPVTJWQrqtB7wY2LRwFudG7AtQeFCq3Ou+cstqtbiG0zGjIK/PmiUlo2LvgD8OEMutWPSTkeZoK1O7pYt7JqfL0W/vLicTMH/m0smiriLyjbccom7S4DPE30zk1gkM+AHmZIv0VMkU4nJt+R7rfGvAhwtJmzFbEbOVEa4xpxJFEG2iFTi4fBS1bvXkve39dtQnoXG31Xf8qfMKnAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0htKVHa1xQ1OcC96QqN/3moS1iqo77uPhKTvkZlszTU=;
 b=pxD4RZrhR1L5bZoMi/FFAeHVSXNg4rBzzH5tH9pkv9247XUGreJBtZfM/I98RO8PbtYHBg66ksCrs2s0E5WftLSUj38sqweBM6DEwRV4FnNXVQLZAGFFf7K6rYaaK0MJrwRTSz0ii8RHRHbhSwnjBHwIVNnGhoRmsbrZAVBXntE=
Received: from BN7PR02CA0028.namprd02.prod.outlook.com (2603:10b6:408:20::41)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Tue, 20 Sep
 2022 02:07:55 +0000
Received: from BL02EPF0000C409.namprd05.prod.outlook.com
 (2603:10b6:408:20:cafe::7d) by BN7PR02CA0028.outlook.office365.com
 (2603:10b6:408:20::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 02:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C409.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.11 via Frontend Transport; Tue, 20 Sep 2022 02:07:54 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 21:07:52 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fixed ras warning when uninstalling amdgpu
Date: Tue, 20 Sep 2022 10:07:01 +0800
Message-ID: <20220920020701.692610-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C409:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 231afc63-2a9e-41da-9ba3-08da9aacee51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+eJp4Jrx23duqVSyi1p6L+aOYIP8QoHSNDrnFUxW7NCpzRxx2yFAaQ8FmA67TrZQYHpVZI2HOUeCaiPlYDaKsFkMDA8BbENfrKURS/Llxz9UdUFv6rKRyjhzrzFgn5VbAmKyrA8svj8e3x1mD+Ow40s0XxFFpVaanEXc7tgCmRywQ/h2So74PtvYbxPrf871o4ceQyXIN5nMD3lfci20+72DWPOnxSdvJSmvYBykPb+Z6wNfqzNNBcKl7ELQX/x1NhRhaaNDfD0YWUuGzqGoqYxqpfmdwvU/3LDofwL9ZBaowDl26/1VkShAdNQ7l6mC6ZC5j+NW7nswAEFPCX+ABqzIjPMovOq+EyOwwRFye36QtEYprSFPYrVxRrlB5drh5RdA6RkbvLpj3XU3jZ+vHuhG7nE566QgTGhpDWtfb+EMvuYgOZ+U3GQp7YIe9gjM3JOwG7PKoPcBpGhnlTl0N8ry1ckz+odB3ukuYM86xjElQ8qrT3N+g2Ygz4GZ0W7M7s9C1MIHhfu/i0DtGtJHG4+ng56q/+5waIV8Hri8Mw0bBc3AIRCKZYSNzLtzlF3dycuu9EoHilS9MiWgdYyiPjLXDiG36+7ENnQe9iT5X62CJnwzG8a3XG2iB+YOyWsWufsptC5TSAPTtxYq/AXdGhCkRKYRnhDE0uMNsOD4bnZpTAh3lse36JMPaTkLlb+FzTww8c6ikP8H2KUkkYZIT6U3yz/U2FGmab0spGGwdnErtPrPdT4SRPKW3lBQez1kYSSan0FeeRzwbwRiGDrVPdZITkK+4ERda/oNkvR/EtbOCMOvuRX9g4vtVA90bFPKNdNrz0g1IIOqfZ8Aca0Jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(26005)(7696005)(2616005)(81166007)(478600001)(2906002)(356005)(5660300002)(36860700001)(82740400003)(82310400005)(36756003)(40460700003)(1076003)(336012)(47076005)(186003)(16526019)(6666004)(426003)(40480700001)(41300700001)(83380400001)(4326008)(8676002)(86362001)(6916009)(316002)(54906003)(8936002)(70586007)(70206006)(36900700001)(473944003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 02:07:54.8943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 231afc63-2a9e-41da-9ba3-08da9aacee51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765
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
 yipechai@amd.com, John.Clements@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

  For the asic using smu v13_0_2, there is the following
warning when uninstalling amdgpu:
  amdgpu: ras disable gfx failed poison:1 ret:-22.

[Why]:
  For the asic using smu v13_0_2, the psp .suspend and
  mode1reset is called before amdgpu_ras_pre_fini during
  amdgpu uninstall, it has disabled all ras features and
  reset the psp. Since the psp is reset, calling
  amdgpu_ras_disable_all_features in amdgpu_ras_pre_fini
  to disable ras features will fail.

[How]:
  If all ras features are disabled, amdgpu_ras_disable_all_features
  will not be called to disable all ras features again.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e55f106621ef..3deb716710e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2720,7 +2720,8 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
 
 
 	/* Need disable ras on all IPs here before ip [hw/sw]fini */
-	amdgpu_ras_disable_all_features(adev, 0);
+	if (con->features)
+		amdgpu_ras_disable_all_features(adev, 0);
 	amdgpu_ras_recovery_fini(adev);
 	return 0;
 }
-- 
2.25.1

