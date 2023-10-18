Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CB4CDB483
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 12:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B98E10E3E4;
	Wed, 18 Oct 2023 12:39:23 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB84610E3E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 12:39:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZqpOqVIq6ox1eJ+xAc4/MAMFuj5APll8oNIpw+TrVHfbNG9/lt+eNHpQbNnuThGk35rwMP7J8K6bLteIto0WIyt9DyzPBOJRfxEWiUQyYh107HI8wIMysP1WOPW/jJtvC/wcGUJLik2MpCU/HkaRZ90LrMlKSRphIcOoPFY2Zivu0GnflsddPph2l+oZ6QbYUxl5iIektlHC0Lhtzf35hIC+rklPlD6KyBdyxsRKGP8YubN2he/ef+hBOaSeZKSGhm4PInWE4B1ZgSDyhfWx+VicyXt6Tr/WovVRIg3TFFE9cDDFfDCPWSOKPECjaaFsHEo/C1DgzfukoAegkywFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIsySk/JuqttNa/yPRimTsgvhJHELcC1nXYIA6BoFjo=;
 b=H64bTipOU/M7TnMZu5NgZZpTJX9k10eahviCcT2bcDxYUJSTW/jQFgsX0KH9ZAG4aQFDIETaruPnxkWEj5f7N4kNOgc++KtYciHCRJ1gTZ0Ypd0xnwGNy0VzEB8JQmGgHGgmU5sF+j6bYRqchWKgO3JQa8s2PseojfZl3DK443pbocc6NBSLM4K/xlx8fOYJAEPy5rFncipEzcJMI8hgc3IrwBeR31AFdpQG5542lg4sEd9bWDGvCx5LIigvL2KZbMC6or8UiguEToObxUSCX/25EmCp0unmSWKDwDIkp2AJOXm9dyBPjTH8nrZsv5kLDiXd4Pb6OaJNOsIJ5DEeeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIsySk/JuqttNa/yPRimTsgvhJHELcC1nXYIA6BoFjo=;
 b=tHF1w0KA+gyEPgP7p5MbSoQ+tNKNyrKLRwKlyxUbmKx5UBq81AqxM3A9WqM7PVNZN92a+gRNXKF3VsOGmjEwypWZcdmRxEKQ2PBdBAjaxlSriRqribvS1naw1OKIVxDsOq95wCqoGCeYyFHw7XE5kK7FNXr0Rg8Qre2N9LBeCs8=
Received: from SN7PR04CA0157.namprd04.prod.outlook.com (2603:10b6:806:125::12)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 12:39:18 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::c3) by SN7PR04CA0157.outlook.office365.com
 (2603:10b6:806:125::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Wed, 18 Oct 2023 12:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 12:39:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 07:39:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 07:39:17 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.27 via Frontend Transport; Wed, 18 Oct 2023 07:39:16
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Stanley Yang <Stanley.Yang@amd.com>, "Tao
 Zhou" <tao.zhou1@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add UVD_VCPU_INT_EN2 to dpg sram
Date: Wed, 18 Oct 2023 20:39:07 +0800
Message-ID: <20231018123907.14772-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231018123907.14772-1-Hawking.Zhang@amd.com>
References: <20231018123907.14772-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: c775664b-3962-4439-c1d7-08dbcfd73edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25py1tE6JZsvirNtjzeiyacTymStYKOdcKVR0QLTCVjib13kGNXiOhATCt6SFqqzpVB1VnXewW0D+8aHSGLifZ2abBOw5/zqqzCmcdVMwdpUVw9Qmn27ar0CR4BjrX3xQcZCv9pM2QK7iFkLGvlzY6uvHRz9bMr/EQyHVTm6MPLm1Jjgc6dM1PadvWc972bAMwe05aRrhF+L/JBoEkZppBkzNdOwrMHDyVXsJLYo1K0KAcInZ2ookeq8knSIpPlKZKF/B9sWhq3LJ9zq/TnuF5ckJoywifWbn49UU+iF+t1mc0ZW4NroifCpTj+7wUPB/A30b5AWDR5EoBQwmQ1SMspdIjnBTccNDMzwQPhOxA+ScujdH3wB7wNhvj2SVw/PSKSpPGL679Q7BRvBTz9/Sk1Cm96IZ7mFDy656bqKUwEzd34P3AAAd98EYg/4Ps/KODBmJ0npFH30sNgLl8pEKNNKyZHhqZbx4/ZamCWb7M/hxgVMghIScAoapVmWinMsycH1EcbVtbz6urd9J7mXVfga9Rxy1C2lDxJd/ooHBwL6DMUXadmEkoKNbcm5OUwwBMfa5zuOxZf/BJJK/TZxo+57dtyJj18rC7gS+2mqx7TKIVoJFcTzWb8kWE46SGl9r5HpWR2fHOTujZgfN5qYzWQg7BbOUAUQ/oOsg0z8fEq/KprhZzZVfdBzNpOz1F1zA7GVy2CEj/RLbms7oajI2yrsQRSwWkLNTLRqPXyaHW+ltuaKCdiFVARryCMRsdDuH3UiHHiHSD0gE/Vxnh3niA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(46966006)(40470700004)(36840700001)(4744005)(2906002)(86362001)(40480700001)(4326008)(8676002)(110136005)(316002)(8936002)(70586007)(70206006)(41300700001)(40460700003)(5660300002)(36756003)(2616005)(81166007)(356005)(1076003)(26005)(82740400003)(336012)(426003)(6666004)(7696005)(36860700001)(6636002)(47076005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 12:39:18.2070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c775664b-3962-4439-c1d7-08dbcfd73edd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add RAS sepcifc programming to dpg sram.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index f85d18cd74ec..810bbfccd6f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1760,6 +1760,11 @@ static void vcn_v4_0_3_enable_ras(struct amdgpu_device *adev,
 			      SOC15_DPG_MODE_OFFSET(VCN, 0, regVCN_RAS_CNTL),
 			      tmp, 0, indirect);
 
+	tmp = UVD_VCPU_INT_EN2__RASCNTL_VCPU_VCODEC_EN_MASK;
+	WREG32_SOC15_DPG_MODE(inst_idx,
+			      SOC15_DPG_MODE_OFFSET(VCN, 0, regUVD_VCPU_INT_EN2),
+			      tmp, 0, indirect);
+
 	tmp = UVD_SYS_INT_EN__RASCNTL_VCPU_VCODEC_EN_MASK;
 	WREG32_SOC15_DPG_MODE(inst_idx,
 			      SOC15_DPG_MODE_OFFSET(VCN, 0, regUVD_SYS_INT_EN),
-- 
2.17.1

