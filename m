Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1195C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 08:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A45D60240
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 08:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9A45D60240
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D1CA89DEA;
	Thu, 23 Sep 2021 08:16:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D51FC89DE3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 08:16:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pn/8/aXzcpl2pNVo/g6XHm2zNHP1aV0548wtcWTyBpQ5oDJ5RzwS7hC+DnXMGbPK8TWb3LB5peVWSaklf+8OW7bvjlkDBv1ZKzI/fPZH7sQp1J1zI8GToo26lLa0SEYOItRaOyGBtPA+DDPNEfI3PPWMBZkR/IQROXOk9xP82jSeDLIa7X2uvPDSnX3ZZZmQIIyzvGXcbKDoRhHxUrqd7PVadImyZwBOQbR2uTY+YGJ8/60/UhOudw13fsyCdcStug2ALbaDwpFxeFysSoWz7zgoDRmEchWVoyBHEt28N8cgX6GY4iU/eT+4JhGFkTIEL9BOd/dAV0B8kdF2f+4OPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=PtOI0DY4jLiQWrU2V0oqGxz2uY22ZqXZNDsTtyviCvE=;
 b=Oc6W6wb4goof/Hti4BCZhl2trqvyM4npjpPgiD1dzUeKzZopEPVkaG9KJjD7a+prj16k9XDXf6xuCOSOdxgDZ+pYAvuD/CCQsCcxqjrrry/KgZRrkZa3dA1qIQNYF08jLfuPvZAFTH9+P3P/3x3w5Jgmpl9mUYnIHtnnJt9DQI1u6fJVWl+mYSi+VXItekmzvMRtQC9zeruPK9ji9+bjFisCPkkzIyf7TJg4VBOzhHdus6XYNolm9dqHlURbIQBBkZBJe5fzlm+SZJXe3Muu5HSBSVSiWibKRgy8LrZk4tA3s8j82vm3AMbyOez6geTHwcOw4sNDioV+AW7sABF43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtOI0DY4jLiQWrU2V0oqGxz2uY22ZqXZNDsTtyviCvE=;
 b=WQxZ5V04yopemnmIP1JSXbDGbiCi3yQEvfIBEN3D4f/ty1lggoamsSFN5CNF6Kfp6LCBFBLqDqLA1DbFcKBd/0j2IjSp+4eXCsV5ksWcWkbA7yYGv+Ga4CKWUXeojNsQuhGAEgnB3O3H2z5q1Lj6NI32Fq6+xOsaBU2PDRUpwoY=
Received: from DM6PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:333::16)
 by BN6PR12MB1219.namprd12.prod.outlook.com (2603:10b6:404:1c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 08:16:37 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::8f) by DM6PR03CA0083.outlook.office365.com
 (2603:10b6:5:333::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 08:16:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 08:16:37 +0000
Received: from syl-dev-machine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 23 Sep
 2021 03:16:34 -0500
From: Leslie Shi <Yuliang.Shi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>
CC: <guchun.chen@amd.com>, <yuliang.shi@amd.com>
Subject: [PATCH] drm/amdgpu: fix gart.bo pin_count leak
Date: Thu, 23 Sep 2021 16:16:18 +0800
Message-ID: <20210923081618.74243-1-Yuliang.Shi@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39bd08ec-77f4-4aae-03a1-08d97e6a76b0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1219:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1219DB35AABA27AF63BDCEB7E0A39@BN6PR12MB1219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zzHUwSLsurl69LX8yk3WEp2H9AJtlMf0kcssEh36a58rZxbUX1JH2pcwFlL/Od41VqQ6OVR+GwOZvMBvigDUyJKNQT4DUT+eHeSqY5bNOXfm4hON+v1sq5F2Z9jZSDGCQ48i8yq4Zln4876zbH2UL8LdRLqLP/X0z7CxZQfuVYF4A78i8VJtdyyI2vAXHnkeXABJ7iUwaeRiZAkf2iu/ZCLFzXVic9hU1hDtycuATwwiCmBVy9hG7ovUGWhHYww9U1ADwva0bARCAMys1BxshOMvIPVOAQ1GoFYO25nzbEb1BRQuL68ktWq5kKnQuUssXJ//Hn3Fc0wGesj6Gw72M5bOdJXd5WTiigKsT4h77WV3ipBryf3MUQU5YkVlUt84HwXmYURPv951E113HSnX/ugWcGVgGwUStFYHHoDlki9BmwBaJqxa9c/WD9LUzyv6aE2UY1hh3bhlIbaTb3MhGg6XNT+TSANxqr8dk+NFJ+FmmkpjoQqIHfAWBK2hf/VQ+PQ9/nzqm7az9hkbSyKBKZqojrBjUn2qAlIbKrTy4sNztg3sxSKPAMkv5pApKMZQeInAgNyOLZ1pVigfbX8IaN8ISuoSUlV6YccLF2a5hEyoMbCOX9E9pCPmYb+shy+EEzEid1PDyFbMUOWhdcaH8VEQgSWVOrWM/HCpAo4i+ZiQGAwqzbcK4P/rz3PTKT/PFQzRt+Pr1Qyj2cpO34uUuu+VA0DFdSKZgYnBsvy/9EM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(316002)(6636002)(70586007)(70206006)(4326008)(8676002)(7696005)(81166007)(110136005)(2906002)(54906003)(356005)(8936002)(426003)(186003)(508600001)(36756003)(2616005)(16526019)(6666004)(86362001)(36860700001)(336012)(47076005)(1076003)(82310400003)(26005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 08:16:37.1776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bd08ec-77f4-4aae-03a1-08d97e6a76b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1219
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

gmc_v{9,10}_0_gart_disable() isn't called matched with
correspoding gart_enbale function in SRIOV case. This will
lead to gart.bo pin_count leak on driver unload.

Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 41c3a0d70b7c..e47104a1f559 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1098,6 +1098,8 @@ static int gmc_v10_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	gmc_v10_0_gart_disable(adev);
+
 	if (amdgpu_sriov_vf(adev)) {
 		/* full access mode, so don't touch any GMC register */
 		DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
@@ -1106,7 +1108,6 @@ static int gmc_v10_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
-	gmc_v10_0_gart_disable(adev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index d90c16a6b2b8..5551359d5dfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1794,6 +1794,8 @@ static int gmc_v9_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	gmc_v9_0_gart_disable(adev);
+
 	if (amdgpu_sriov_vf(adev)) {
 		/* full access mode, so don't touch any GMC register */
 		DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
@@ -1802,7 +1804,6 @@ static int gmc_v9_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
-	gmc_v9_0_gart_disable(adev);
 
 	return 0;
 }
-- 
2.25.1

