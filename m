Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4835FC0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 09:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE5B010E445;
	Wed, 19 Jul 2023 09:07:29 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDE8710E445
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 09:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmF76aChOR+FgCzfPWcRcywZtXy6ZLesh7w0Gf1Xaq6/eb2vFxkn6RafV8qzUkkz8IpDVnvn4ZjepmBePhd3hrf4SoRBULEPcIzYBvR4/3BQZc4xTT8QfHlLPqecTc2W6iY9uT84zfr5EpOG5FoFPwkQ3Txli7J9kKlcdsD78hfuQZ33c+vagDXM7vJvhx8rceSTGOWX8s2O4Dtqm13jVJIhWqlJXcvvW8/iqRzL9JfI/DwTL+3uzrLXMTHJlkpRXS0LDBkMezaCmuyRZRkEXfuWinDzEaMRrYK4+/CpsG1T7w9OQ1xe/lJmDF9E7MTrVV4ke+CV+7+HrGSiqkS0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cBzd6jNJuP07pOe9Yo/DJCOkLchVfsG/08DxtZDJc8=;
 b=g0Mp9Y3iv83f30/Mavd/d3QrRXIgObf3KuYfxmlFWo+0/4QL+aPEgSF+l4LngmxESrY7MSrJM//teRMGrkfhBNlA6iI4v/1mbApHWMheHGtYiaR/TpSYPwvv7gcxMlp3nbkeFGVMpZqoB38hgVZPGlXASW0jpUx4uyNndMb23x8JmXrFhnBop85Z/7RRsWirQGOh9m4Gn82cZsLjYQrIHHI27g3MUUyA8rd2YskuTBsfoNZuYCJMv+i9gaL2ta/I3ktzMyuYi0JVg8CJlrrC1jHnLQQn7pTCJ0hGjOo/ifh0AqcrTanFd2vr3MEdeK+pjXif7YeXCv99qSHhdyH6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cBzd6jNJuP07pOe9Yo/DJCOkLchVfsG/08DxtZDJc8=;
 b=Fq03PYr6+cbUdZ2KWQCGV7cVIkESmfKv4Fl8lpyDxfweHg6tl+yomZehVABnIqbmZoKBEKbFynTJyDAFJkO40AXFI83MUMF/VzGw6f30DpOCfd2br/niSJwDavRrYf+5B6WrGYjSrN1mhVMajq6Hws7HPx4EmQempnS/qAVAavw=
Received: from DM6PR02CA0131.namprd02.prod.outlook.com (2603:10b6:5:1b4::33)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 09:07:23 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::6f) by DM6PR02CA0131.outlook.office365.com
 (2603:10b6:5:1b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 09:07:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 09:07:23 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 04:07:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 19 Jul
 2023 02:07:22 -0700
Received: from horace-sm-debug2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jul 2023 04:07:19 -0500
From: Horace Chen <horace.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: set sw state to gfxoff after SR-IOV reset
Date: Wed, 19 Jul 2023 17:07:05 +0800
Message-ID: <20230719090705.3263-1-horace.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: eddf8687-ad38-44a7-69d9-08db8837909d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rj6dLM4TGCUc+G0Q/OhULIN/4mGfKyW/V+QFUWXJzQRlYZFSBSE9GJ7/3WGTqn0Vd83EkXvhAxI5ORHKMn55gXPDLplEi8p9zxlhF48MbWtyv+viRFfK8N46LZdnXJpvdOeoUWxYAe4fEvLateGkdD/E4K9BU32w2FyzIwK9WTC2/TAaNTyN5aGdzaGthezS+uAdhYJp/HdxKU1H/IVCu2A5o4V5aE99Cx8qYxbCp3RNAHCBw9c/tc7eHa5NDKEA93LFzvEFDok14uVTW8wbsVE0Mn89CGR6057+HKWgnDCLqyw5OkBMnnKBAn3sqqCyoLwGMJilvCxuFgJobv2qjO74BvUXo4L4SCeuNdW7OkcIhRWHZORa94sLPQA3j0Yy0prbL8Nyms8U7ytCTo/xy28YWc/EneIInqSXl2mbl2mDbgwa0p2SsW5ZU+8rU2AYsrjru+F9pqOtgs0RSXpgcOXmb7caFNnqivB/7pDKOSVXH0b3tIzhAChPiuSxxjpCkUpy4MgNCgwenF5EWYu4DgdCvX6RdI5GqaWN/RNmddVDXe4VF/MI3FISodrF9xOC4BPPSbxKJKG774JUbCyGO6OF2L6k82plkuq07/BGLA1exXGJHAFC56ntWW8HtFmrxN9SOBCR0mP6m1aAIeh5huQQd3qhXQ8zXiGmJ50wlE+qKjr+qk/8AiFKMWXz3B6x7Djb4tIwXZitq2Nj20h9zoVvqy6R6TTb0twNp9mHJkTaUlx+AXX9v5yurmGTuWVmyLsemN99Iiqv7vFJBQz9gA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(478600001)(7696005)(6666004)(54906003)(1076003)(186003)(26005)(316002)(2906002)(70586007)(356005)(44832011)(6916009)(41300700001)(8936002)(36756003)(8676002)(5660300002)(70206006)(81166007)(336012)(40460700003)(86362001)(2616005)(36860700001)(82740400003)(47076005)(426003)(40480700001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 09:07:23.3090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eddf8687-ad38-44a7-69d9-08db8837909d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Haijun Chang <HaiJun.Chang@amd.com>, Leo Liu <leo.liiu@amd.com>, Deucher
 Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Current SR-IOV will not set GC to off state, while it is a real
GC hard reset. Whthout GFX off flag, driver may do gfxhub invalidation
before firmware load and gfxhub gart enable. This operation may cause
CP to become busy because GC is not in the right state for invalidation.

[How]
Add a function for SR-IOV to clean up some sw state before recover. Set
adev->gfx.is_poweron to false to prevent gfxhub invalidation before gfx
firmware autoload complete.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 28e6419023b7..1c786190a84e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4575,6 +4575,9 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	/* some sw clean up VF needs to do before recover */
+	amdgpu_virt_post_reset(adev);
+
 	/* Resume IP prior to SMC */
 	r = amdgpu_device_ip_reinit_early_sriov(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 770eb9725ec1..c712d027d62d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -835,6 +835,16 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
 	return mode;
 }
 
+void amdgpu_virt_post_reset(struct amdgpu_device *adev)
+{
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 3)) {
+		/* force set to GFXOFF state after reset,
+		 * to avoid some invalid operation before GC enable
+		 */
+		adev->gfx.is_poweron = false;
+	}
+}
+
 bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t ucode_id)
 {
 	switch (adev->ip_versions[MP0_HWIP][0]) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index d1f7509a44cb..fabb83e9d9ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -360,4 +360,5 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 		      u32 offset, u32 acc_flags, u32 hwip, u32 xcc_id);
 bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev,
 			uint32_t ucode_id);
+void amdgpu_virt_post_reset(struct amdgpu_device *adev);
 #endif
-- 
2.34.1

