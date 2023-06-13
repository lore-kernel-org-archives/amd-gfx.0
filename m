Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20C9C7EE2E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 10:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE4E10E376;
	Tue, 13 Jun 2023 10:54:19 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F5810E36E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 10:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyqPbVoC2Ns5BiLbBXHU5bz+B2qfSGTkqj0pD7XDkZT+GkSoGVzcozBtNdp8kJnfPg6VQbLM6a6lEn0mXRAF+UZ3FD/ZDgLjMgdDXntpm7A/KOFXvUO0OA+eOEE6vhVGSidYIMsmjodQ5W/nI2wh0qUOy01RUs+OYWkw7llGJxEG5QmeO/1S83+Nx9uPUVQx+b5JHS+OADWx6bPl6vtzL64JU2JkxLhp7sNvuh2Zs8/Bap7d6qC4M5A3Kw0MgfgYUr9cE/ompaxb1Avuk0mEwZcVlkLl3W11gwyZJ6SChTwL47HQjrMJs9OHGzwy4J52W9LY8iG7jHE14zn8YadcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFv34uoZl0Vy31+czX2GV4bP8Z2Y6OgQoiiYnITGvqg=;
 b=n/Oc+dVwCzjR1PzNbTlkATMdc0/whxJ752pBFtUX93WlqmuAzKs28TkjGdLg4VIEf80OOy+/O3xC7MLXjzASU6KKg2mFWy7jA3RplDkkRmRbKdFMlNLherSeGM+szoOnmb/aXC/t6xJKb005Yhog32gy61uC/a1unQWHNH7sqGbMK9e39pKi4YbFwg2EsiQREFRsdvY5bpuUs0bwb7YmtaDbhPrYw9ZplDvUYuRREXtW2Hh79k/QPC9euHNl3HNlLHPZqh73IfyTRRsD3dpD5smFg6LlxMowXRt3I/KIh48nkOczZk2BK+O7iK+tY/Yvp6Cy1+wuRqSGAyF7N/oW6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFv34uoZl0Vy31+czX2GV4bP8Z2Y6OgQoiiYnITGvqg=;
 b=kiBDEP2CHt93lWaNz0jFVGf47DnQrjUGjHwJa5jcSXOP42MVXcKBHAxWMIoKFWvvk6SvTN2UkoAelDypbQRfjaHbl1R9BA9Ux5KKWGqE+1ll3I98sHJX/kTvT1fK4Vx44V8X37psW36qRGuic/a3sW3ARquxYjNtoq29WSqIiKs=
Received: from DM6PR08CA0023.namprd08.prod.outlook.com (2603:10b6:5:80::36) by
 SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 10:54:14 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::9d) by DM6PR08CA0023.outlook.office365.com
 (2603:10b6:5:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 10:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Tue, 13 Jun 2023 10:54:14 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 05:54:12 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: Remove unused NBIO interface
Date: Tue, 13 Jun 2023 16:23:54 +0530
Message-ID: <20230613105354.1561876-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613105354.1561876-1-lijo.lazar@amd.com>
References: <20230613105354.1561876-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: a23215bb-f141-4de1-9661-08db6bfc8748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5oCPGw+RzXkYZyiolx1rGGEIOWucweSjsfwof2xECoEUA0IuIHGs7MXsJGvTaGPbdndDvqoIil/CVH6HMrGf70yunk9/zSAdUOAalAC3hfSkQPjDb7lzE+K1tP80lhWeLDsLMNoIVjlBzZBHAquZNAHWaVVaJyWma9BNFdMns/r1hRge/EY57ihMPw85pxKUjv2M4XjdZsaEQqzdtsutpN24MXzDE5gzCwWhYw+GMpZRhSDOQryl8EBL1SOFch0CnahZz000JwTh+b6vViuvssl2E0BsBB4jzHTav1fLsjLayaZhMWqKa/+z4qMRnVZMP3BIuOPUreX4VwVRhC03NjIa6QBM6yVEDwSRQal23vdhb9SG4AYchZ77iuPe7d2IYIYrz0xcaa6ux9LkVH17/cfKwKygrA9jfMCyF/DSEKU85Y2Biv8OtP2IlGtNY7/On2YLyOnBqNLxJE/CUP5/Uj/Xlw6NGPM7qJXTjhP9NRkU3MbqyzU4v3ouX763JyfFVD/kZtvP07m4y3aIKyWWVfRTIGy6xSU9dTPmXeaFANifBVt4sFHBqiMDQiSL+rN6AbqyAQb6oy9CrSFBxrXTsaVctTqLlfVR8jR4IyBoEiKqjFGwu02gloVFU5k6ICSUZhuzfcpZ5PFOg0QMVEwa6/vFkdUyLiKsXZ6VKapgalJiExYsLiwsEvupvC4fOozttEVBnD/w4QIAMKbUREU57cwWx9QggMiKokrpfFc3NdJKQEG6gMJJWDwESaK/cJrRJOg2NrFkouZDzOEPTV2+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(86362001)(82310400005)(40460700003)(7696005)(8676002)(316002)(41300700001)(82740400003)(83380400001)(5660300002)(26005)(40480700001)(81166007)(1076003)(356005)(6666004)(36860700001)(8936002)(44832011)(36756003)(336012)(4326008)(70586007)(47076005)(70206006)(478600001)(186003)(16526019)(6916009)(54906003)(426003)(2906002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:54:14.7887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a23215bb-f141-4de1-9661-08db6bfc8748
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set compute partition mode interface in NBIO is no longer used. Remove
the only implementation from NBIO v7.9

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  2 --
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c   | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 095aecfb201e..8ab8ae01f87c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -99,8 +99,6 @@ struct amdgpu_nbio_funcs {
 	int (*get_compute_partition_mode)(struct amdgpu_device *adev);
 	u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
 					 u32 *supp_modes);
-	void (*set_compute_partition_mode)(struct amdgpu_device *adev,
-					   enum amdgpu_gfx_partition mode);
 };
 
 struct amdgpu_nbio {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index b033935d6749..cd1a02d30420 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -393,19 +393,6 @@ static int nbio_v7_9_get_compute_partition_mode(struct amdgpu_device *adev)
 	return px;
 }
 
-static void nbio_v7_9_set_compute_partition_mode(struct amdgpu_device *adev,
-					enum amdgpu_gfx_partition mode)
-{
-	u32 tmp;
-
-	/* SPX=0, DPX=1, TPX=2, QPX=3, CPX=4 */
-	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATUS);
-	tmp = REG_SET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_STATUS,
-			    PARTITION_MODE, mode);
-
-	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATUS, tmp);
-}
-
 static u32 nbio_v7_9_get_memory_partition_mode(struct amdgpu_device *adev,
 					       u32 *supp_modes)
 {
@@ -461,7 +448,6 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.ih_control = nbio_v7_9_ih_control,
 	.remap_hdp_registers = nbio_v7_9_remap_hdp_registers,
 	.get_compute_partition_mode = nbio_v7_9_get_compute_partition_mode,
-	.set_compute_partition_mode = nbio_v7_9_set_compute_partition_mode,
 	.get_memory_partition_mode = nbio_v7_9_get_memory_partition_mode,
 	.init_registers = nbio_v7_9_init_registers,
 };
-- 
2.25.1

