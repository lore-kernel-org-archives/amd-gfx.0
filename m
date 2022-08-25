Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A21C04AA5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 07:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81CA0D8A34;
	Thu, 25 Aug 2022 06:59:27 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B85D8903
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 06:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDsQrkjqwmoDHgr3PjA9MqY+rwpQlKGW/aNxE1nyNcBrcAJoClIlnzdwI34IdLwYQu+nyRmhwqI3/z+i9HvtWLReXRXyOXy8lVJzUHrQbhxv4K7M1JJOTF2t7nQKnH+Z+o3CspRkA9uBIxA1tyZiW6VGdjEhEItw13PPdG1UJkuCCmplPIuaqL8pAG/0myfM8YrRmQWF5sE766BiLdYZ6jgeYn2F9IN8ggodObgcdkV/o1ijeQRp9PXulTesbT3MKcoleKxWNG5+l8zOrfPhbu4EmKw1/W7mPvJa6XEFY638LBtKzTvWZqfNZ+EUDNV6sucJIU0U81dTmbP4NAHaAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seFr3V9e7uZ6Q7EDqedSC+yUSufzRpfELSyh6CzX3E8=;
 b=hrvthBeih0k1P7dGHpYq0OQCsFZXsSjVhOYz8NRy1OJnUcG3TGQwD0Ps27HE0cPC+PeilFH5qEqG3tEMVg4Gezu+qQ9uY+a2fVkxjBo5VoVP1oP3Wz5zGm8e0hA/v21EGC4c7loLrQvzeX1ihzxSOKMJfRwViHvwj7Ry+lq28SjGJm8cPhj64/40ni/Q9zqej6wEOHF0T1SvG1dDHCw38VU4W7JXMQVZ5bUVs9qxuwbndiWhKpFZ4cVs52PYzkaN1T6r3AlUHVJ9pbq7GoopIAzUlAAOaBZXOyFz7CgtHeTzXS2P2nzZ955kza3/EiCYn6yLGCJQrz2MNoImupQetA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seFr3V9e7uZ6Q7EDqedSC+yUSufzRpfELSyh6CzX3E8=;
 b=Jlaa0ZOZHIxom2HQIT4j1j+q+TgOVoApBuWqKTyy9zS+LaX3jFZ5orkwb9G5Bh2HolORMwf7PMkpFA7xqKDOLJWa7RP8CMFmXJtWhA4dRJ70ZGSllcotmPhffd8lNLC38Ewgtsx7avLRXfBAPJJtAKD5AG+pdUjcC1sdoCqTHDs=
Received: from DM6PR01CA0030.prod.exchangelabs.com (2603:10b6:5:296::35) by
 DM6PR12MB3147.namprd12.prod.outlook.com (2603:10b6:5:11d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.14; Thu, 25 Aug 2022 06:26:09 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::b7) by DM6PR01CA0030.outlook.office365.com
 (2603:10b6:5:296::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 06:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 06:26:09 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 25 Aug 2022 01:26:05 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <evan.quan@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: use dev_info to benifit mGPU case
Date: Thu, 25 Aug 2022 14:25:50 +0800
Message-ID: <20220825062550.331393-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b6baa5b-a1e9-456d-5fbc-08da8662b2d0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3147:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ga7NNOrzKhFBlSBqlsevOeAUQkt7iJr9k5Az1U6kef5dM7HCYdfdtSCJ/hAVv1/hYCQqm9apBAel+X2+Sjda3d/sYXzLMWHSxJr+z7/dbcofIUN6yO0IYjDb7mzRQqljt/xO5zyDjkjOrgHpLAh87YX4d7S2n8iKuM686bfq1unSoGcEIP8e8EiNFRmVyTtLMeGnleQF85cKlZZUw/wD1dcf6FuWjono/CPnS9qaJjRIsQjtA92vKd7zmBTGvYWSdi1s51wTgyy49uuFbwqeb5j3fY/yA2O1/rP1/mjcv6NB/U3ywS/mnIenDsVNsETvlMkucDmggo3Xi6NcTzvHySAhOBnGXpQv6B/AWd6QR1xgW/0jasZ7ZTUVqdyfvpq19mA05crd21mjqBPTw1/sbIENZy38ObiGJC6REYmuFTwVEb3yOs/YgcBJAXg70cdSsKcBE7VyRlTpbGvkONGCdk56hAlLn1aFoY+7/PJYU4a8EovBOtQb3t8QbHj2YcNlVbow8iWUE2SUDTIbLnFKuJX4aMhrdQ2TBAHfueYOsuTEANdNW09icyHkqwESA2IjyhbMhV4O38qqQ9i+OXCmf7zZScYasziAlVOz0MStPq2Lk0oxFAFC1lXkfO5t/rrruLw4xWLqZKBmuDFxv1ThzdkQpTIqiI39LTcKqV80UmK3+YsDHBF325K71voOYSoUVcu6QdyPXENO05kfnKNsPrXhDsTbfT6R463pqIqLd2WYFRl20Covn9t4tSmWOQw9Uqc3HmY2nGk8g3J163l5Rw6oBkLettE3nmLAOywa/j0IglHAZxYle/LY5Mj2w7chnFoSIvatxL8XRNmGNbzD+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(346002)(396003)(136003)(40470700004)(36840700001)(46966006)(186003)(336012)(86362001)(2616005)(82310400005)(47076005)(83380400001)(16526019)(426003)(26005)(2906002)(1076003)(40460700003)(81166007)(82740400003)(6666004)(7696005)(356005)(5660300002)(44832011)(8936002)(36860700001)(41300700001)(40480700001)(316002)(478600001)(6636002)(110136005)(70206006)(36756003)(8676002)(70586007)(4326008)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 06:26:09.0326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6baa5b-a1e9-456d-5fbc-08da8662b2d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3147
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

'free PSP TMR buffer' happens in suspend, but sometimes
in mGPU config, it mixes with PSP resume log printing from
another GPU, which is confusing. So use dev_info instead of
DRM_INFO for printing.

[drm] PSP is resuming...
[drm] reserve 0xa00000 from 0x877e000000 for PSP TMR
amdgpu 0000:e3:00.0: amdgpu: GECC is enabled
amdgpu 0000:e3:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
amdgpu 0000:e3:00.0: amdgpu: SMU is resuming...
amdgpu 0000:e3:00.0: amdgpu: smu driver if version = 0x00000040, smu fw if version = 0x00000041, smu fw program = 0, version = 0x003a5400 (58.84.0)
amdgpu 0000:e3:00.0: amdgpu: SMU driver if version not matched
amdgpu 0000:e3:00.0: amdgpu: dpm has been enabled
amdgpu 0000:e3:00.0: amdgpu: SMU is resumed successfully!
[drm] DMUB hardware initialized: version=0x02020014
[drm] free PSP TMR buffer
[drm] kiq ring mec 2 pipe 1 q 0

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 1036446abc30..c932bc148554 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -812,7 +812,7 @@ static int psp_tmr_unload(struct psp_context *psp)
 	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
 
 	psp_prep_tmr_unload_cmd_buf(psp, cmd);
-	DRM_INFO("free PSP TMR buffer\n");
+	dev_info(psp->adev->dev, "free PSP TMR buffer\n");
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
-- 
2.25.1

