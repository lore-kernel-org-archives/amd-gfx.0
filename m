Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B9FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 04:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E42064FE8
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 04:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E42064FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 401136E9B7;
	Wed, 10 Mar 2021 04:38:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8E86E9B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 04:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chq6FM302aQk6ZAZitUgm2fXONZEwc7C6TxvWzZhV1A+sQStXsjC/b90axFYI5chLKxxErSXe9q7mo2ZGUx61yb4w4jj1dLT1Yk9ZxTnvKPxvlmKK4o7xvOQZcC2gULr+F7ymOrkrU9uXWysqhdvnXgeByP4wUHD8lfWoKDgzRCaPeNF0Dtqo8BtW4pGLDe9V/FaTzMgjelujejZH5vgXv3wWBAHVau19cbdDAKH0RAWdyH++vdUjbZqBOHyUij9DJSZI70IR87zDsSKaJw/frjhhZR9lLlCwAZsGVAVboQ3so2A96RVV22URrjYLtIRRV4Rwtp9yIjGCSitljeyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3L1zB8btnVWhlf/oIvpiO+6U2G9CeJ3LvuNoKrcS9kk=;
 b=MNoa+ZaRsKt3AU/hAuEby/TLaa26Yxfb7t8ywtHM3AAP63yDtUT+5T2BhXFGoGBJb9D0xflpM+WcLzOKebLXokPeMBTb9TczegYlcKCEW5M9gEZ/divVlZlkvHGK40raIm8JGyfg55pEMAznJNPPlZMPg/DodMQMoQWw88iMlxYmmpZfifuv/U0J+XibYoYn92t+/v2uIKXmxduGRJP2OHKq3HYaN0G7JHmtGXvAfuhW9um8L9wsthGZ6SdsZc4hFsC14N2Ds+rE4wsItszOWdKxQozpjdo7gilUv2pRJNxjIuNxjl0xnNAgL6Q0Pjoey15wQUav0L2dOWCSLmbDiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3L1zB8btnVWhlf/oIvpiO+6U2G9CeJ3LvuNoKrcS9kk=;
 b=Sql4uhad7UrG4HZNtZWakQ0GePLALX1A/MPi3cTfHESciY03jabgxGVdHNmnRufo4TvRMRx1uSf4enOM27Z6fMVovMXviJ1y4xxysfAIPupSZTb8IEn7i84bfCBT2K30XVJ0wf9xEGoaMvd32s4KpJSEwDOKFS8sg9blFYURmaE=
Received: from BN8PR16CA0002.namprd16.prod.outlook.com (2603:10b6:408:4c::15)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 04:38:33 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::26) by BN8PR16CA0002.outlook.office365.com
 (2603:10b6:408:4c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 10 Mar 2021 04:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 04:38:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 9 Mar 2021
 22:38:28 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 9 Mar 2021
 22:38:27 -0600
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Tue, 9 Mar 2021 22:38:26 -0600
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add amdgpu_device_is_headless() func
Date: Wed, 10 Mar 2021 12:38:06 +0800
Message-ID: <20210310043807.2248045-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5e0ca41-02a4-4fae-2934-08d8e37e5b61
X-MS-TrafficTypeDiagnostic: CH2PR12MB4134:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41347A18FF247266540887D9FE919@CH2PR12MB4134.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9oZ2YrCdPFSBoFIP1UPP9YjyYtDo4HBtgjjxWLpgd6YmVKuyfMcdcxNr/Fpx0xwXSuR8EmtM8ALSG41pslXkLucimABAWKZZtRVOuDKr8tgsl9kNqHNjayOyMfDLpMebIvipZrRzQ8oRsTwvHNGMfQDNvyjKToxW4a2oHAQ2cxlMGuRF6OnkB7nk9vBf8yBM7X9PSZFUPOSflE/0E9F3n5uHRBoavWZHzhY8FyfY4juiY1MtceQZYxYCFm0CdrtxH4yFljjvbW8jDoCfH3Q0xthvn35GhjdwLpYZi7PXgaEJKXFLhLORIbVlkjB4ZnMP/S2reXopB0/D/z3zXERfBBTWwva8WbYCfhKMPWdUvwIsMlPzf3qZU+0Tm0qwrvx97SolCwBw66fIXcun3Vq3I6JEmFjcNDix6CKbxneebwo4D2wN16YGcHih5DBjcT8bMzW7yr0e/z+/Q4d+RIngm19LjqUNghsNGPW7pbFsyqgpD9ccrIzBbJnmGnJU07MpyrqWXWWj+3g+3qu1uzV763ih8OdJJ73wToivBOVx7D98C4lhzIGeq4fd+D3grPy41MmSeWAij2ytMYJVyvHzytBqKD2DiDUcv+kQzQ+CBzj1K363qoaZMr3WOfX0yHU+SSUTEIq3WEut1mhru1zoNkMrgykcoImW+hg/XWwVQofW9e+YGDHY+UuFK9ORQsv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(46966006)(6666004)(5660300002)(36756003)(356005)(1076003)(82740400003)(83380400001)(2616005)(186003)(81166007)(8676002)(478600001)(7696005)(336012)(426003)(8936002)(82310400003)(54906003)(26005)(316002)(6916009)(70586007)(70206006)(4326008)(86362001)(47076005)(36860700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 04:38:31.0964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e0ca41-02a4-4fae-2934-08d8e37e5b61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add headless check function for NV and afterwards.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/nv.h            | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7e1f66120c50..5a4c6405e0d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1292,6 +1292,7 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 				      struct amdgpu_device *peer_adev);
 int amdgpu_device_baco_enter(struct drm_device *dev);
 int amdgpu_device_baco_exit(struct drm_device *dev);
+bool amdgpu_device_is_headless(struct amdgpu_device *adev);
 
 /* atpx handler */
 #if defined(CONFIG_VGA_SWITCHEROO)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 49ca317718dd..4074de941d2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5328,4 +5328,12 @@ bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
 	return true;
 }
 
+bool amdgpu_device_is_headless(struct amdgpu_device *adev)
+{
+	/* If the pcie subclass is not VGA, it is headless */
+	if ((adev->pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
+		return true;
 
+	/* If NV's subclass is VGA while VCN is harvest,it is headless*/
+	return nv_is_headless_sku(adev->pdev);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 5846eac292c3..1e40e36ab038 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -696,7 +696,7 @@ void nv_set_virt_ops(struct amdgpu_device *adev)
 	adev->virt.ops = &xgpu_nv_virt_ops;
 }
 
-static bool nv_is_headless_sku(struct pci_dev *pdev)
+bool nv_is_headless_sku(struct pci_dev *pdev)
 {
 	if ((pdev->device == 0x731E &&
 	    (pdev->revision == 0xC6 || pdev->revision == 0xC7)) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h
index 515d67bf249f..450619fe677e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h
@@ -36,4 +36,5 @@ int navi12_reg_base_init(struct amdgpu_device *adev);
 int sienna_cichlid_reg_base_init(struct amdgpu_device *adev);
 void vangogh_reg_base_init(struct amdgpu_device *adev);
 int dimgrey_cavefish_reg_base_init(struct amdgpu_device *adev);
+bool nv_is_headless_sku(struct pci_dev *pdev);
 #endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
