Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037E2C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 10:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A541161453
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 10:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A541161453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 467406EDE3;
	Thu, 29 Apr 2021 10:27:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E0366EDE3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 10:27:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ds5Yzu8HQz4AnmOAt25TUehQ5cfERPmo//XAuKJGsIelTasnEWJxvn0i6ibuIQQxVFFMOTsEpRuADfBjVw4QTJULBJJ/c19/UyRCulD2lRuiZQBli1QfPiKo/M8wYTtXP3BzsjupOw5bB6brERGqoKvs9FCRj/BkqZhr8rXKLlQQ2xUZKY41PX+m5+DdnKiCg0uNZjf3xuQbOj31hGCugl1R0SmD3WiY9d5wT460LRGuO8cEbe0OKj0wBkWM3DJckgT1KfT/8M73ip2dEVaPcE57JHEc/LEk2POI7TFfndO4ts51YfjoBcJxbv/6ydih6Ig8Eg1DOGavj5nKykNP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0e5XoNaQYWs4uv4dMuzHgz0URl1+L/usdFdm6JEf40=;
 b=JtKahvePZZBIy/Fu+CGCshnAogKuyE5+7o1gPbUNrKT9PBPbVLYzCCrM3g2lCIwcyS2gtMpwgon5JCJzHcVd2hoabmX+1RmebZQSg5pHzSUXQlKtJq2apxQcin/FQf6Pc6HOGpB3psvG1SSJjZUs7SfuKgMyTucAZbJxVIcBKezcILXU4ZomSOVKu3Pcwdvu2ueDAQl9DgPhOLbmbkbLoquo6kMqep/TAE1FyYFxdM5VMMOr4bU/TLve4nzk594vy+T7J/8l6WKVuY41X8mbPZaIE5JboWAbLMtAciYRE+hbHccJad1cIjc+MR/JIKrRCgw5hOl7slozy4cie2s23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0e5XoNaQYWs4uv4dMuzHgz0URl1+L/usdFdm6JEf40=;
 b=eCHg1TSTZOpAV8OPGvdUVUeD9MV0Lt9iiLWDeDDP2lZYLEdF3AdK/4vM6ui3oi6oIZsUKPWUbuLr84f3DlCjkVz9/ZM9Duezp1qZPCTVGzjUqi+gukcvyjluVduyR/QsPah/C8re4Hh/iRpBH9aUHC5gRKpeh4mRG32NFdZQy1w=
Received: from DM6PR02CA0157.namprd02.prod.outlook.com (2603:10b6:5:332::24)
 by MN2PR12MB3965.namprd12.prod.outlook.com (2603:10b6:208:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 10:27:08 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::17) by DM6PR02CA0157.outlook.office365.com
 (2603:10b6:5:332::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Thu, 29 Apr 2021 10:27:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 10:27:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 05:27:07 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 05:27:06 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 06/12] drm/amdgpu: Modify GC register access from MMIO to
 RLCG in file nv.c
Date: Thu, 29 Apr 2021 18:26:38 +0800
Message-ID: <20210429102644.31172-6-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429102644.31172-1-PengJu.Zhou@amd.com>
References: <20210429102644.31172-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15ca4a81-6dee-4946-a4ea-08d90af95786
X-MS-TrafficTypeDiagnostic: MN2PR12MB3965:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3965918796A2F18264CE367FF85F9@MN2PR12MB3965.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mv/mb1/WgCEQe5uKMk7+1EvS0AGPn3gPLDBJk/ec9YRUI/ZrivQszQRBe6W6Zvwg8kF0HZGJ7JmLXtr2SO/eAOsrIytWXEAtHh2eYyU1n7rbMZOvRdM5AVXIP3IF8hu7LUodRQDGTrW9I2NzNtsGFu6ADhNJMmXivhac94Kiz7vcrG+A97TN0gYl5j0XyodEYbPpVdR/yOJrFj76zuKPNetbQ27/7uys1hSAXlZ5vuvrPANu8GpUPs9PNJA27oS2bK2TCpEpnTFgMvyeGcPvzmqahLNJrnLj9rbeJNRq6u4qtrSzJjYwIQz6u5mvff7h88HXZ1gQC7Hr0rJIXmqPH4wj18DxICoNDSAqTwIoDiBBERRgjhRMPqTJ5Hlk43A7MJuUQeu8wcxW6bjTACtDrUDsRRZJLZ1+3JTSOTTEGjYjDcrOZ/xnUVv0oNaVaimF0OWv+BztGlIY/DB7Y4ddQtqLo3TOHn3SC+ubXXlyDZ2+7XAvO2/ot+c+rYARxQ3Wtx6qoYzk1XMRgRAoMkMn0cCNlA3Arz6DoW1nyaEMBMglAOvAT2Aer3OhOuub0c0/8BPR29TsLeKb+ORBnfqpcSEYVwz4hARszf6mGREqxLiFxmMyr/eMjrS/BqX2lRjIypC7RvXopelNxGZwRiCptwIutAfFP2ZXn0X/VmskpvRP/wWgYbKjqUjaew9gAO4L
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39850400004)(136003)(376002)(46966006)(36840700001)(2616005)(36756003)(6666004)(8676002)(83380400001)(7696005)(186003)(86362001)(4326008)(26005)(70206006)(6916009)(478600001)(82310400003)(8936002)(1076003)(81166007)(336012)(2906002)(5660300002)(4744005)(82740400003)(47076005)(426003)(70586007)(36860700001)(356005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 10:27:08.0292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ca4a81-6dee-4946-a4ea-08d90af95786
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3965
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV environment, KMD should access GC registers
with RLCG if GC indirect access flag enabled.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 82a380be8368..f2f0caf560f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -363,7 +363,7 @@ void nv_grbm_select(struct amdgpu_device *adev,
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, VMID, vmid);
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, QUEUEID, queue);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL), grbm_gfx_cntl);
+	WREG32_SOC15(GC, 0, mmGRBM_GFX_CNTL, grbm_gfx_cntl);
 }
 
 static void nv_vga_set_state(struct amdgpu_device *adev, bool state)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
