Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A9DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Dec 2021 19:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD5C010E372;
	Thu, 23 Dec 2021 19:19:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E97B910E372
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Dec 2021 19:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXIrMEtcXhkNpXTUUPSPAq/0rKeYEo71GEJjCSqSL1pAeoTdd9N2ExezHct3ceXCGkl+PwBxyYFtwDW/FpE86+qIbT/ZlkQ2EMhX13TegkoQhkyhpmyucQ/adVCJHl6185f0nJV16DpWoiVArMRWLkyFgZ5HOPB2ws+gzMtT+95a/igy5lcKStvRMoZcjyd1Ir0R5CwiH6LMeRAGYuexPnwoZj+l6PKnTJy5MsFuN5ELD8Ckwo93qJhWjgwKvxHu0+We8WLcFGOSZ3Ik8irB32VVDgDls3qTMgD5ot3cRchdoGS1ZmuJptS1OxENZRnlGVsQVMmNbQG1jUTaNsQcEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+t496gtV7uLHmKYh5SWBjSkquvQHU8iMdNWjh0QV/I=;
 b=mIX3/+/aIEdkzQ8tvb5HdBHeGNmsAsVDBZUQ71NRVlYkJeJwktW7K3dstw9giE+HS5jO9ey7ot9wz/hGobalROK3Vr3Z1ji+m55Ns4qdZxa9JvVUFbxLDrt+joY0pQbFsQpugUJWudf8LNCvB8CIcO7hcPhLQGruslNgtyvTuGxwwme2MtMLK0s+iHFOv+xrpPknReGhyMO3vJtg3D9lgBFUAxb29FmDF8k8Udvb2n+ZoY1PzyCHMBTwdqseqskhGzOSbVfVm0AHN+jRRKuZchdpF2jFQ44U2l4hlACnzzsbgqWqFPAZYK56yn5LinXa5c1QPFS30WDW8HhXo3N5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+t496gtV7uLHmKYh5SWBjSkquvQHU8iMdNWjh0QV/I=;
 b=fxWmFf5ZFmZ/ufNcC47Wa0NcQlSSowBCknhFANgZtyRu9dxGJQmdawlc1iZwK3z8Z517DPttMU4l9hglyFHnQhcJKk7gNYaVZHP8keqMFm8JJdP1UnWhhjnu5/xn4qV8dtE+B2UQt4ZeZtbD9NgiI2O3aGJWlg/HKQb6qzo6oWw=
Received: from BN0PR04CA0145.namprd04.prod.outlook.com (2603:10b6:408:ed::30)
 by DM5PR12MB1260.namprd12.prod.outlook.com (2603:10b6:3:78::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Thu, 23 Dec
 2021 19:19:48 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::91) by BN0PR04CA0145.outlook.office365.com
 (2603:10b6:408:ed::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18 via Frontend
 Transport; Thu, 23 Dec 2021 19:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Thu, 23 Dec 2021 19:19:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 23 Dec
 2021 13:19:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: no DC support for headless chips
Date: Thu, 23 Dec 2021 14:19:34 -0500
Message-ID: <20211223191934.1269698-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6894cce-12c8-4404-6cf8-08d9c6492f20
X-MS-TrafficTypeDiagnostic: DM5PR12MB1260:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1260E819044D7E4AEA45F0BBF77E9@DM5PR12MB1260.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRJBoJTCEWBH5yeWuYNdvQBaki0UAE2AoZiEVhCHBV3gdnD8zYikuF2HSIi5HlUFxswmx0y/oZq9yQb2AHFqBHxX5YuMEJ0O3eadCYgm9Ki4pI5UlhgfPaEoKbJ3eVux3WkIE/8bFh68Fep+OMLhTZ4Ypks29YPimZM4xalWbd/rrV/zI50aW/DSFo46oTwOFMWPA1MfVDAnlidh9YI2kl/NxI9JNicTVYRzNxbkVLGE04iCbP8EfOBoPYc75+BbLCWrT2mxfS3Q7z0Ne9o8HUtF3s5CyYr10mY6N4vaZjP8HKOiRGW+ERHnyW13Mgk4dq1Vf6Y71bXYqiJ65XP+xZ1cssG7hShAyNLg4xVhe27OK9HbtI1Nb5IWwbsWCfz3bM7fBjMOmfeCvvgDdqDDVVLXDcxESpPhToofZygA2TY4Ukf98fA2JmVw0H7/48t56n32xNxjLVkvGJbAxfNhMKOTpraZggkCjpFtfSkovfcUQ82q/27FXUeXg5MXgIcb+TdrNAmxVx0cADBIun6XVIeu7QEYZSQXJzEFOrGodKUuTNvfDQL7EVTl0ZN7cKV28kuAMX7qO9zV2DAFk4KDBKEaopOA6zL+C3PK+DJWohxUinkIEg0xiqesutDU/+GMDmm13N1UNXXwlCbuCm6lwgusstF+3NYjrZTihZD1b6JDm5PPTY0qdub90WA1/ttjTb2S8V7PO0dfTLItQIdMOEtmpe6JnRknk6zV7bXT/WX/106bbXzUiYs2gGlY4pJOToFasUkm8wdfwrgPLy2XGaCIuo6AHPXP+YmMQZ3LrTk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(4744005)(186003)(508600001)(6916009)(1076003)(83380400001)(8676002)(26005)(356005)(316002)(81166007)(54906003)(70206006)(7696005)(70586007)(86362001)(336012)(2616005)(16526019)(36860700001)(4326008)(8936002)(36756003)(82310400004)(47076005)(40460700001)(6666004)(426003)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 19:19:47.4889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6894cce-12c8-4404-6cf8-08d9c6492f20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1260
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
Cc: Alex Deucher <alexander.deucher@amd.com>, tarequemd.hanif@yahoo.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Chips with no display hardware should return false for
DC support.

Fixes: f7f12b25823c0d ("drm/amdgpu: default to true in amdgpu_device_asic_has_dc_support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9dc86c5a1cad..58e2034984de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3166,6 +3166,14 @@ static void amdgpu_device_detect_sriov_bios(struct amdgpu_device *adev)
 bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 {
 	switch (asic_type) {
+#ifdef CONFIG_DRM_AMDGPU_SI
+	case CHIP_HAINAN:
+#endif
+	case CHIP_TOPAZ:
+	case CHIP_ARCTURUS:
+	case CHIP_ALDEBARAN:
+		/* chips with no display hardware */
+		return false;
 #if defined(CONFIG_DRM_AMD_DC)
 	case CHIP_TAHITI:
 	case CHIP_PITCAIRN:
-- 
2.33.1

