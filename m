Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AFAC43460
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 10:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E44061453
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 10:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E44061453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA76C6EDE8;
	Thu, 29 Apr 2021 10:27:24 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770077.outbound.protection.outlook.com [40.107.77.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F26356EDE8
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 10:27:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcZiO9OXPOphEWJGz6Eux0GlJLR+oZRjH3e4+bFYJUC4QbwjQ/3HODog++awLhRiP1LC0P1JfWcdQ53DmuXxJjSszbi+ed5f0UxGxWXdeJxJFzXemfpyBNQwWrwTd/lFhzvgURRjrZB5vRF1oPBIxefK79CCLLNXbBrxBO9t0uwAS3rmA2RoM0s6G2A93OV/aMiYUytVbvmbBIjjx8/8XDTGKpgI0hVK/W2vFXucsRuoCCY3E+vuGU/Ah0fTjzn4U1zvUQ77wIL9yi4zAcNYyPIdASQwAUjkUyoC8CidurgR6Aq5U0U8rtu8T865vrj2/2H3xs1D+DpQvG4xbsWXTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWLs19IQ1z01mj8ttV67RW1S/hlkJtZc9upRx25oaAw=;
 b=Y7mDtkMyVmihFf3CZLsL5NMTVeHwp/Dfd4h0yV9FXEWCpNm3NG0ieLR3jWdf3YVoD6GMbZZH7+QfNBLc+UtEGiS8c03mi5gm7wTCosby5F/hHnZL8IU9bTJ26NooA3OviLNyCQSnbVaWgRqTCJrWC0F16SUu0EySVJDXsmO9eSgX0yXLqEyF5aXoXKY5DJLi99ITaOADfsDnrxUHT6EIVGTdLCQBD4XbDl4WU2Pq5QvvKfoQEjsnx9s1dk/CBHxxZ+851GrZXuj08hfaqyZIfC0hFcGbY22F2W2JT4/E9MtofR1R4ZkSxYOup7GubwWQUYF0gNR5LjpqkZ4zcIlRfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWLs19IQ1z01mj8ttV67RW1S/hlkJtZc9upRx25oaAw=;
 b=w0aDR+JuIzM+/ebbq4BSJBOwAFpgX2W4ipH3bPLsmfj3BdAoJXOwywmha91NXbouGOBfphtmgEqkSkY6C0rRRDEaUuxKiakqlG3kpqadkNgA4TvNZTW2ctxva5irjIMJNBK4VUH4qALNqXM3L8sq3xFSsn5gaJRl3eCadzRFmVg=
Received: from MW2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:907:1::18)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 10:27:21 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::47) by MW2PR16CA0041.outlook.office365.com
 (2603:10b6:907:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 10:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 10:27:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 05:27:19 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 05:27:18 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 12/12] drm/amdgpu: Refine the error report when flush tlb.
Date: Thu, 29 Apr 2021 18:26:44 +0800
Message-ID: <20210429102644.31172-12-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429102644.31172-1-PengJu.Zhou@amd.com>
References: <20210429102644.31172-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f62731e-a6d2-44ff-3509-08d90af95f18
X-MS-TrafficTypeDiagnostic: MN2PR12MB4406:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4406887693A9D0DCC6E5B7E9F85F9@MN2PR12MB4406.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AypgXFyNcUSX7OkVzDfevH3L6kFMew5jN+/b7PzM6HE/oiaP+S6hpBrMfbnOZfiI5G5IFGseE5YT3hvNQMI+NgKFqQ/INqsEJWZ/7i0TqkYLa6QgQfYoN8RqzhTP29Yoij5muqmUHINeJQUv86qCgZj8I2d1DngiiA3hAiImcuBD41yur56tgzwTbxkygnJ/oPhgL9iogU2uiJgWgmM3sDBkClVigNHY+sjZBKnEWM08hahtCD3p55NI9KVaHDY/Wfsj4ZA/SJqx1CcOtUL0aFK6uzTpju3fRf4NnURftro7W12ZgFSJ0PVDZL7fAaj6AsRwSZ6gqYc/AfvJkQrdkDcYPU4QpnXr9gD2k1MkV+mqYi373JkWtGm/ReuYxZwVDvf6I4KhwcAFPfxecac4uRKm7DrL9uOTC8sQVTdq2xUXzMu9foGOEQj4ecq5+EN5nTLC6l5/JdXBKBwnqKVWewys1tyW0/K7pzsb9RXdpL2InoQCjtuz/7YBQk55c2E8IBGmTi0mxJ9C91ep8ykiOodDW2Q2dtCuElsDBrM4FfNpj4Q1jpH0Scpig1fotXK3Y74ZzJWaIR3plPfWpiT7CZjHvS6zjnPLWSeCDwzQ4fo2jYreZjySwhDwpUzVKUr4VZlALWNfWSakXf7AUTVne1HYxxHe72X2s66CPSDCzsXmxxtTMcWIYNGBvRL3XbBY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(36840700001)(46966006)(336012)(4326008)(2616005)(83380400001)(26005)(426003)(86362001)(82740400003)(6916009)(5660300002)(70586007)(70206006)(6666004)(356005)(186003)(81166007)(478600001)(36756003)(7696005)(2906002)(316002)(36860700001)(1076003)(4744005)(47076005)(8936002)(82310400003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 10:27:20.6663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f62731e-a6d2-44ff-3509-08d90af95f18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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

there are 2 hubs to flush in the gmc, to make it easier
to debug when hub flush failed, refine the logs.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index c25541112663..33cd487741f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -297,7 +297,8 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	if (i < adev->usec_timeout)
 		return;
 
-	DRM_ERROR("Timeout waiting for VM flush ACK!\n");
+	DRM_ERROR("Timeout waiting for VM flush hub: %s!\n",
+		  vmhub == AMDGPU_GFXHUB_0 ? "gfxhub" : "mmhub");
 }
 
 /**
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
