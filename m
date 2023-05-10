Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7AFC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 17:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EEA610E041;
	Wed, 10 May 2023 17:56:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CC7610E041
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 17:56:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEVnbnkVPS6UtITzgRK1d8Cjoawd50+R/wicVp2VKnna4jb7J51eIqYfEnDTnIbyTtOMV0pHj8aJOHSycvaapbXP9OSxSNIAb9PKfNhH0Eiywg3CEpgVV9LMW141cIXxLIB6Jeku3jZIkpG+fDiATkXA9iWC2TzZWDIDQEE0xRVtViyIXopfoqPjYIyNd3A5ImzMDAV4ePChGlpBfWrIp6Qir795TyPNEi1bTyrNf1BMbQtVmheamjqX00DKC6TwqgAXps/OLuZUm7rxKV1zhtvUCsi10Ok4CKw2bBpGvFBSKhdTMbiH1Cst02PO6+lP8LOCJk8bbSi16dlhwcTM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jewn03w0+qZ1pbuLG8PJaloPRpAnGnI7ZYkWHDt6SZk=;
 b=aZshfj8MdjZlc99Ku5WZ9L7PsAIIFFeenFJN99ELZbeEcBC/vR/ss6xbNmUNHKx5AyKyIfWDpyJMaLP+wbU7bVib/zxvk4Gxuy5MFAHFMm+Sn+5CroIFKQm3yRxP2qn4HMB/mnwrjpX4k832/U24YkhGIwQBS4H90+KN26NLksoIh1UaEemG9MP/Q7zDhioF2AJ53qi2D6xS/MpWe13SZICeXTyodunBSgLOJAYPhpA0fFEmEi58qoQK65YdY6eeZg4A878JAWtJyoxUjgf+NT/U7J4mkPB7FJacaMcA1eKwfN9835LJxJJNx+Ia7dWaRqgndzD/ZuD3dBsvKgwObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jewn03w0+qZ1pbuLG8PJaloPRpAnGnI7ZYkWHDt6SZk=;
 b=fBj6R/SYh5jDyVZ0DRlt8LjBtZaCBHBtcQScdYDbEO9ZlNHWkx5j4BLJqfU6HEdky4UGO8hDruQCKmEQkbI3jG30YBEcpPEdlrbizlfvzi2yJRJ4Glua8dxWJbEy/BpeeL8BcAQhgcOidb1Ts/EnqWU3qoudTEYwGxEjx3Osdh0=
Received: from BN0PR08CA0006.namprd08.prod.outlook.com (2603:10b6:408:142::26)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 17:56:44 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::29) by BN0PR08CA0006.outlook.office365.com
 (2603:10b6:408:142::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19 via Frontend
 Transport; Wed, 10 May 2023 17:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Wed, 10 May 2023 17:56:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 12:56:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amdgpu/bu: Use legacy TLB flush for gfx943
Date: Wed, 10 May 2023 13:56:25 -0400
Message-ID: <20230510175630.938276-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT091:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 495dc30f-c67f-4821-252e-08db517fea64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QNJrl9pB0aqoQd3q+x94t+RSE/LpS5DxWbsJZkxycdiilkCXg/mdZlqbeY7A+nrhRWl/XMYA6VjhFxGB9ie8qOJTpQt8tQ04mfdInJZMibvyykQhUqHkW4dpgN5qoZUdd9V6XqcRhIJ4EluiYe2yxlFrZ/9mU5fdJBotm0sNA2phFT96NSpPsou4z9cQtV2MSNZARV5vetBfL7pxuKLuIorp27WjbG46S+unSIaNn+NQU/WkX23YYKX7dmIYVOZpA/an18zPmHjQg/BUQDgZCEqecMw+5uApfPjyH/rZG76Tz8v5MkG/mTs7zkDBZN+igy+nK31Zu0MBh0eYUeSJqrCwXgwvDaGsvje1uGBzChsCdwAYE0adniVyBOZ+2jtSj3DxuCY2i8E3UOs28oMltYeCCH6jsdKTCMZ8MO3uXUazYVIVEfnHvIFBJVsXulgjupBUdSyRaWXPxIkBTBa8aYyOGLKvkfZdOvtO4mMoTVm4XlceaGfpHUJuwxKubVTAT8MQ86IpU+zHjRLvXEOkGu6cMqBt/n5L/wawjk2A+HiAa/ViNA64z5Gqlca5p+FsCqJTW48QTgzgeUfxmDOuMEqO/47M8weoVAsgHVev9Ts9v6kCjjIrmR47dnp2h/dclVFARazJuhJY7CrclEVYTRhMJuNbYh9rSz8HE4UBpRiM1zpo61ikXV2PH1omTDhW5YuxA6WyW++qX5qMfCnR/wcV/cHwPaisE9zOl3+zSBbRE75ZiVwt3P1Yd1hrmS+Kd6htb/V4idqknmjLuTYWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(1076003)(26005)(16526019)(40460700003)(2906002)(186003)(86362001)(82310400005)(40480700001)(2616005)(83380400001)(47076005)(336012)(426003)(356005)(81166007)(82740400003)(36756003)(36860700001)(8676002)(478600001)(8936002)(6916009)(41300700001)(70206006)(70586007)(4326008)(6666004)(54906003)(316002)(5660300002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 17:56:43.7716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 495dc30f-c67f-4821-252e-08db517fea64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Graham Sider <Graham.Sider@amd.com>

Invalidate TLBs via a legacy flush request (flush_type=0) prior to the
heavyweight flush requests (flush_type=2) in gmc_v9_0.c. This is
temporarily required to mitigate a bug causing CPC UTCL1 to return stale
translations after invalidation requests in address range mode.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index f000e0e89bd0..d28ffdb07ae6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -833,6 +833,14 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 */
 		inv_req = gmc_v9_0_get_invalidate_req(vmid, 2);
 		inv_req2 = gmc_v9_0_get_invalidate_req(vmid, flush_type);
+	} else if (flush_type == 2 &&
+		   adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) {
+		/* FIXME: Temporarily add a legacy flush (type 0) before heavyweight
+		 * flush for gfx943 to mitigate a bug which causes CPC UTCL1 to return
+		 * stale translations even after TLB heavyweight flush.
+		 */
+		inv_req = gmc_v9_0_get_invalidate_req(vmid, 0);
+		inv_req2 = gmc_v9_0_get_invalidate_req(vmid, flush_type);
 	} else {
 		inv_req = gmc_v9_0_get_invalidate_req(vmid, flush_type);
 		inv_req2 = 0;
@@ -976,6 +984,15 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		if (vega20_xgmi_wa)
 			kiq->pmf->kiq_invalidate_tlbs(ring,
 						      pasid, 2, all_hub);
+
+		/* FIXME: Temporarily add a legacy flush (type 0) before heavyweight
+		 * flush for gfx943 to mitigate a bug which causes CPC UTCL1 to return
+		 * stale translations even after TLB heavyweight flush.
+		 */
+		if (flush_type == 2 && adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
+			kiq->pmf->kiq_invalidate_tlbs(ring,
+						pasid, 0, all_hub);
+
 		kiq->pmf->kiq_invalidate_tlbs(ring,
 					pasid, flush_type, all_hub);
 		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
-- 
2.40.1

