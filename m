Return-Path: <SRS0=y248=KD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F14C43460
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DF661354
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 11:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DF661354
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B02E6E87C;
	Sat,  8 May 2021 11:52:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C09DE6E883
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 May 2021 11:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxl2doWvdze9MK6bZAtw3kgf3s9u9jnNeAWBUokW98b5ODVkG4ds5G0IjkjTd029WmkI+lShpdcI02MVZBVw1Lmh7Ai4uObAffi+vKIjZusOjdmt362DArPl5mdGj0Z7C1bF01MGje7NtYTR6yw+aTn1DLaJB8a5STOICK74sfZGRYjhJxzoJpAP/WwbrcnaVyfK7HS2BrRsGI5Pvaih9Hiao6fRr8nBct0I4ivz1Xg3DjSuq2Q+HHo+6KMinyvsKRZA2I6+obgs3ZFd9FL/0LfdPdpcr2WJZrUzG2d+lnAZAE2BafcLx0KzjUMqb95pNcqtZSWW3IMFO2NnDz9l6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jvt8BTwHkqYsQ5JdYCWhdKmUG5wOXuqQCX1fnxjCz2o=;
 b=AuJHJOZs6OBjNKsKedSB7QldfON3fA/xn66+Z0v3XV+Jq2p/hTvhJKK/8/KjUzGXxwimlivjXtDUSHzHBV9LNMh2ixl9VIx/xUkNtCiX0xEXdQv6QhJpb5qIGygMy4gm/aWFNzxjHSufX4DptSSUT2hQxNjzdRm6BGb2fJ/J3jboNYizKzsGXiyFXg8ZkBlHadxs2xTI5S/sNzi0CdWP+FzZD/lLAOierIunngABqjyNAdbw2+zEZ4oohi+rcMXLjXkjPvjdQ17lk2TieU9B9ld5Q4iJyCfvaS5moyFVa5bOGqDGUyy21WFfNlacO1EW59rUUZExldqS80cgI5FklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jvt8BTwHkqYsQ5JdYCWhdKmUG5wOXuqQCX1fnxjCz2o=;
 b=4KaIFXm8b9uZ8tQtwkGLdsGbh6NVwgPucyxiK3QEIq4XIg4q4rhb27FANs2CQ0eHP1N+1WAuHlDPE1jiIYrZcXkWolnACqLVNP8ht1JJgI6Zgv2EB7ioq3zD9JD8gjFSzo+QCJ5UDXP2x7wWgrBb0nQkqSRMosfG7DmVY10pgvw=
Received: from MWHPR22CA0026.namprd22.prod.outlook.com (2603:10b6:300:69::12)
 by CY4PR12MB1624.namprd12.prod.outlook.com (2603:10b6:910:a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Sat, 8 May
 2021 11:52:06 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::98) by MWHPR22CA0026.outlook.office365.com
 (2603:10b6:300:69::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Sat, 8 May 2021 11:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Sat, 8 May 2021 11:52:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 06:52:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sat, 8 May 2021
 06:52:05 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Sat, 8 May 2021 06:52:04 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 11/13] drm/amdgpu: Skip the program of GRBM_CAM* in SRIOV
Date: Sat, 8 May 2021 19:51:43 +0800
Message-ID: <20210508115145.758-11-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210508115145.758-1-PengJu.Zhou@amd.com>
References: <20210508115145.758-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 979a85d7-0430-46aa-2ea1-08d91217b43c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1624:
X-Microsoft-Antispam-PRVS: <CY4PR12MB16242122D3847EFDB7E2CCA9F8569@CY4PR12MB1624.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OuX9OeX0BAF9ruUu3rNkCnR1qMDJWjpOmVurNcI39QF0P0v3X2LMpBKdqC17/1QNzgvzjQSuiPq2FPAqm86cuOp5eVnMSikETFNinS5gp0JjQetejpM/qyHrd4+v9vudmnj2V5H+27SH1RLpv7gHGoEvPmIL3DDi37nNOaYigwdtZ5MDsoQzUENHbgRCd+ZqSj4HxJUqiUzn4rFcBDOystmqqsy8Kt95AHelG7b3XnOSx80Khd3OoCtXNRYSVEamEoIWtf0rSxlt+8y3EVxBL78ugWtAJWNeQn/RoOf57A1PVP5tZdD+ui+xFbqkrIIEckzWsUQQov6YP0jtn06FFiLL4/3n5s0Tsz3oHDCdvhZJdZqwgtOfhP6+F+W5oc1VfGqdw3/SbRn4NdnMxVNdfBTQ5bMtq/Sagv+Smsc19iraTJzPgvf/YJBfg6tmQ2hzw3x9LTCtRsQ2WjXNgkuPblXPcLrp4Q3fRGCAvnHYl24imZWmFDgL8O+v/Gq+HxDRrK1uEJQTfcb12uwp28y3pLHQbUrJAt8BNeG/yniI3eMgdpe3Rig1jJ/oaDNKtZT2upjMuY17qJ/jsvnGmmcogW48JJsyzMqu4wGTyIV4oXWPXt2DbDezJ4xCP3L2xyDUE9Nrr8SOIJxP9BvJGVm58+YP64E1FsaJf1D9PVUIDAnbWSSbxBfR6ux3TVLk1EYS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39850400004)(346002)(46966006)(36840700001)(70586007)(70206006)(4326008)(47076005)(4744005)(82310400003)(7696005)(5660300002)(2616005)(1076003)(81166007)(478600001)(86362001)(316002)(8936002)(26005)(8676002)(336012)(426003)(2906002)(36860700001)(36756003)(82740400003)(6916009)(6666004)(186003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2021 11:52:06.5377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 979a85d7-0430-46aa-2ea1-08d91217b43c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1624
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

KMD should not the program these registers,
so skip them in the SRIOV environment.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1bab22272e97..2b065a9ba448 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7114,6 +7114,9 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 {
 	uint32_t data;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* initialize cam_index to 0
 	 * index will auto-inc after each data writting */
 	WREG32_SOC15(GC, 0, mmGRBM_CAM_INDEX, 0);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
