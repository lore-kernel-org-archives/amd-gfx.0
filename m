Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A4CC25B47
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 08:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B46D10E0D3;
	Fri, 27 Oct 2023 08:23:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A50F210E0D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 08:23:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bjg16OG4uSEXSio8nxrQa/FuaRgF2Cgl+1hLMKLHkTtmgzRln6CtbLB3GPszYA7NTbe8A/ogPTgdemGaAUBzYzpSjNL4ViCTZ7FVmpfabNVVVl+DYHGs+zT3P5iClSLqiQgPSWX5f13IT8tzxi8R9JzUTru8c7QWdDtrE+ujO3qUJ4Rw9sbODbEprRjkKyNets5N71/mZNQOlHl3rmbMJE2oyqmUmsOcOn4uRzWFgsaOMg52sM0B+yWzFXKbV5I0AopIXemJYvAkLbxqrIHwGcDHcoz/IitHDNNx4g55ardYIcoqpSFwkgQ/tE0oJx5VgD9/tporjx1j42dx8rKaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uatS3XjCTuj7kuZD6BesVRUnWxyGCkOC82IC/74EFa4=;
 b=IPPrGu9VaVYzD/RQzLbc1T+lCHhL+uLB4CaUt9+7h60KUsouVGWoEaiSLUDzr6yAt4/JQ92CsgDf2aJajbuutxQaSIW+X1wzh63SQl2G8iT6CIxvEGOo0aTm1NnTEXPT3+14PCJiyiZWxToMQEaaY7MxCANsMlBSc+xGhQIARSFx1vJWBRp33oJ3M+Ydr2ZzHUGIBmmx9YxUpmqVBsDdk+qhQ7Tr+fhUHZ738Bq62ewTaQLuU24nBP/ZGkLVMq7sUxPfkucbA40VPL2uio/GsokvA/KYCvB3WS/nw+iMrkIw+TFCWeGVCbVuMChs9F2J1TTuKOEHuSRFZq2NryEwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uatS3XjCTuj7kuZD6BesVRUnWxyGCkOC82IC/74EFa4=;
 b=vqTMMCDrzE3WwdcF4A3nyyzyxqBeyNBOvImcdSEtwXCJHDWbBEWeXqjVzlkiVTZqVs/SpXsv71Q/PMK/jgN/h56USvI1gYmJTapKchh0DcFmlWOCD7L4s3hzqWfYo0F8HRk8lXRASGAJaGlMqLi03g0bqnQQJ5NLhtiIaAieMsA=
Received: from MN2PR17CA0018.namprd17.prod.outlook.com (2603:10b6:208:15e::31)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 08:23:03 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:15e:cafe::3e) by MN2PR17CA0018.outlook.office365.com
 (2603:10b6:208:15e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Fri, 27 Oct 2023 08:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 08:23:02 +0000
Received: from primary-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 03:23:00 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu set doorbell range when gpu recovery in sriov
 environment
Date: Fri, 27 Oct 2023 16:22:42 +0800
Message-ID: <20231027082242.204839-1-lincao12@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: c43552ba-31a7-4e37-d042-08dbd6c5f03a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmEzKrPwTOEfVOBp7QPv1QjosppJTBZAiHpwkNgxW+fhph7308dE/jEcOqW8q7qKxliwNVQbDjF+TVEpn+qRBdpwO86UlkSJpfs4BRLXNqqQJes0oQiry+RF+RsT7yAB4Q7ajwhUzBqugJ4vKNspazf6cQmjWbVha+qzoXgI5dGqOh9kOJuopZn3y2lydg2FLQs4k5VDyry/v3Ri0bDh9IproPlSEBHhwfSj9poHcDFcOzUeFVkwTor41/n6Gv2QMi6cldLjrRv+EDZB3Zia/qHaVedzVyguqqn1+UiVIw+ivvJQznA6E87GLM1NkzUaPYnLyaH7z4bIz2629tdc4H6eCZsxPGcsnCd2AjBDd7p+sZwKO2qE4j13kwDsD8Wd8/mjEC2m3g/lB10qzGqSNAYNUNbbwNEP6vog+nxsJitp50LXFVw1rS/2sp0lsrvL+XPI43tGQ9dPwkWN00XvhnME5Q1kt2CcQaaBB3FmHzrgZnrk0T0SgQGSCFD6efCoqBdLuqueYU5Tyvjx4wx3JjEBtbf+fjYlt3iLsCoGSg2cxcU0+e2hwWjahZIGjMsLptLQsWy36ysb14XNAdaUZ+t5LoitODZ8raDvkm27Qh7/V+/ELdfpQDoOmzckqOKS07GgNvW9TSjpZFsAo23tB2ruSDEbOBR9EVy/0sSbFBjBjhttVVttF6M2eCgUrO838QM7LWlehCxo2tCdjguX81uZD7SK5SCxTuw4fEj5AYIr7tq/32V+zkwg/8rnOFD1ZqA7ILIkVT/Nb7iHlWTxyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(41300700001)(36756003)(2906002)(36860700001)(316002)(478600001)(81166007)(16526019)(1076003)(40480700001)(70206006)(6916009)(82740400003)(426003)(6666004)(336012)(47076005)(356005)(83380400001)(7696005)(5660300002)(2616005)(4326008)(54906003)(40460700003)(8676002)(8936002)(70586007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 08:23:02.9876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c43552ba-31a7-4e37-d042-08dbd6c5f03a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
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
Cc: zhenguo.yin@amd.com, jingwen.chen2@amd.com, horace.chen@amd.com,
 lincao12@amd.com, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFX doorbell range should be set after flr otherwise the GFX doorbell
range will overlap with MEC.

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d9ccacd06fba..9074ced34277 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6467,6 +6467,12 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
 		if (adev->gfx.me.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
 	} else {
+		if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev)) {
+			mutex_lock(&adev->srbm_mutex);
+			if (ring->doorbell_index == adev->doorbell_index.gfx_ring0 << 1)
+				gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
+			mutex_unlock(&adev->srbm_mutex);
+		}
 		/* restore mqd with the backup copy */
 		if (adev->gfx.me.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
-- 
2.25.1

