Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85700C77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 10:37:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC54010E487;
	Mon, 24 Apr 2023 10:37:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 656C510E487
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 10:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lypLx9E8GMB69Ni8snwqJKnpXAWt+UHamqPFvSd0haUvVQVWC3bjV7o8loBFUuHWBWI6nh4OcZN86XBFI/n+BbFDn5cNPpmNsAwU642LdCApFqSYDq1fRy5gdxAkMYsPyUzdxpBkUyA3rqk2CVlJNqML8XHFjoEVzLyRvAdVephUi9evmebBytK1YteJQpw8xGW7y/qT24sv8sMlMfxYPnl0sTzO5uNNY72zdZmGK2YyCgTV3vcSZt5k7+aHnYM5vChd+Tj/UhPqB8DfViQaN8qlfS00zsHoUxXV5cUfBEf70FaL6qsbLzIYgcbZnI0DKGtwgg+sXqB4/xrn7gxRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFllpDCIgSyLuL59SxL+Og6jPyZEiUFqQAGgFsi3MTM=;
 b=GRWt2OOo4Qs6jUFFV2h00w2YoXfvP1OSVxmlMJjtFBV9xySfctPuIRuPai6yDf8+PakqI9wvUPK352GS6ni+KlVtDJEIdJbDZcAT4qGAHWN/MXFKIEqJeA9TlZPqKlGm0tjPCniusggBm0jBTtyInHpDTnNBKrdERynuML3+I+vpgrQuDmpeYF4LwzyElrGdRnoo0wNfkqGosUq6qnopzPIBs1FHSkgxvqvFEuJcY7QY4ij5KAkGG/AlgiQYY+NBL5JKZuW9l20G+Q00J924eSdbXH1whhxeOCJ0tDKYB25jeKMjoFmlsC0iPyNxKvddZqbSkJJt8YcFrJuDBKqwsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFllpDCIgSyLuL59SxL+Og6jPyZEiUFqQAGgFsi3MTM=;
 b=WMO/08geeuwT8kLJaDtbtWY0ZioLxY6H+5f8qJZ0bw+hqkljNUMQ/6hLNzY/9wgYMJG2JZv2kEFjBIF7acqR4pwBx8cTTvQ9PGA1vmt6pDI2VUrnVE2rPBKxgN64L4Ai/61fHpb+ubY2bMYdD5ufYJmy+TjxFkZLqpButuXpxYg=
Received: from DM6PR03CA0078.namprd03.prod.outlook.com (2603:10b6:5:333::11)
 by DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 10:37:24 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::87) by DM6PR03CA0078.outlook.office365.com
 (2603:10b6:5:333::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 10:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 10:37:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 05:37:24 -0500
Received: from hongkzha-test-pc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Mon, 24 Apr 2023 05:37:22 -0500
From: Horatio Zhang <Hongkun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix amdgpu_irq_enabled warning in gfx and gmc
 hw_fini
Date: Mon, 24 Apr 2023 18:37:21 +0800
Message-ID: <20230424103721.9787-1-Hongkun.Zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: f617b885-5e6d-4cdf-0e3d-08db44afe488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8dYaJO8iI4XKvbwvsZquzA1wwyUWGnISI9K7SQzm6zfhCS75qcDRWJNJcra0kUJZ1c9bzdpK0cAvTxhSnpVIrff66xdzFqO0iiOvyJWhWCxD9wXeFtLP4kOk3cSVghuq6KM8MPLL6yj7uBxEZkq4cn+OkTFJszgJUPQKdFkNRHzdAVHWRv7U8RI1NbQgeFUglK4LlHGeQHmy1uWx6yEH6tz2pLr4TV9Pc4WF823LgBPX/Y2sPvheKlRS1LF8dGnfcZ5Au8Y4JroqqEc3uouMKCyYTXUspJ2RbjSQ024SQR+IPm4w9QZ8U5B655SF6UIOnNiixMnFr9/Syr0Y8Iua/nk7n9eWBYym7dLXKUMYWLJ2NAZMky+vQxFIxyNITL9msVZlVnbg/WspHKjPSB+OFh64hTqy6xIEjuJrSxTIngE7vYJ/jkJbkzaehtdcijXnv8XL+O+jM6DD/iJ8F5bCT4GRh/Q9hH+KeD5hxEDnoWxMyEV9ld7iMskOquG5WlEmtAQaYvaoymkr0xcOSXumvQ1RxVlywHOdqXKG4Z89oDYnQeCH65tdXYs8g2IzksJoHUKC4FL1TpchoG8rGAPyPsmNYDHa8CpoGcmjEHN9Q3sJWex3b75IP6tv/EXnYMGN+5+WcRCOJ3ythhjBAf1kHBWH0QicWeKFApHpFC786lsqAxaxA0+nFMR6djjv1nUqRvbrNFV5bYcrVDP1gQ/4Wj6VTHlhzyOzjOT/4mC6VA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(2906002)(7696005)(2616005)(1076003)(26005)(186003)(40480700001)(70586007)(70206006)(8676002)(8936002)(316002)(41300700001)(6916009)(4326008)(478600001)(5660300002)(54906003)(82740400003)(356005)(81166007)(82310400005)(36756003)(86362001)(40460700003)(36860700001)(47076005)(426003)(336012)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 10:37:24.6207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f617b885-5e6d-4cdf-0e3d-08db44afe488
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536
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
Cc: longlong.yao@amd.com, feifei.xu@amd.com,
 Horatio Zhang <Hongkun.Zhang@amd.com>, Guchun.Chen@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The call trace occurred when the amdgpu is suspended
before the mode1 reset. For the IP block that do not
support ras features, the relevant interrupt is not
opened during initialization, but hw_fini forced the
close of this interrupt, which resulted in amdgpu_irq_enabled
check warning.

[  102.873958] Call Trace:
[  102.873959]  <TASK>
[  102.873961]  gfx_v11_0_hw_fini+0x23/0x1e0 [amdgpu]
[  102.874019]  gfx_v11_0_suspend+0xe/0x20 [amdgpu]
[  102.874072]  amdgpu_device_ip_suspend_phase2+0x240/0x460 [amdgpu]
[  102.874122]  amdgpu_device_ip_suspend+0x3d/0x80 [amdgpu]
[  102.874172]  amdgpu_device_pre_asic_reset+0xd9/0x490 [amdgpu]
[  102.874223]  amdgpu_device_gpu_recover.cold+0x548/0xce6 [amdgpu]
[  102.874321]  amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu]
[  102.874375]  process_one_work+0x21f/0x3f0
[  102.874377]  worker_thread+0x200/0x3e0
[  102.874378]  ? process_one_work+0x3f0/0x3f0
[  102.874379]  kthread+0xfd/0x130
[  102.874380]  ? kthread_complete_and_exit+0x20/0x20
[  102.874381]  ret_from_fork+0x22/0x30

[  102.980303] Call Trace:
[  102.980303]  <TASK>
[  102.980304]  gmc_v11_0_hw_fini+0x54/0x90 [amdgpu]
[  102.980357]  gmc_v11_0_suspend+0xe/0x20 [amdgpu]
[  102.980409]  amdgpu_device_ip_suspend_phase2+0x240/0x460 [amdgpu]
[  102.980459]  amdgpu_device_ip_suspend+0x3d/0x80 [amdgpu]
[  102.980520]  amdgpu_device_pre_asic_reset+0xd9/0x490 [amdgpu]
[  102.980573]  amdgpu_device_gpu_recover.cold+0x548/0xce6 [amdgpu]
[  102.980687]  amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu]
[  102.980740]  process_one_work+0x21f/0x3f0
[  102.980741]  worker_thread+0x200/0x3e0
[  102.980742]  ? process_one_work+0x3f0/0x3f0
[  102.980743]  kthread+0xfd/0x130
[  102.980743]  ? kthread_complete_and_exit+0x20/0x20
[  102.980744]  ret_from_fork+0x22/0x30

Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 543af07ff102..0f6b037558bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4483,7 +4483,8 @@ static int gfx_v11_0_hw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
-	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 3828ca95899f..25f466c26d18 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -951,7 +951,8 @@ static int gmc_v11_0_hw_fini(void *handle)
 		return 0;
 	}
 
-	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 	gmc_v11_0_gart_disable(adev);
 
-- 
2.34.1

