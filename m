Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B96C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72EB810F4D8;
	Tue,  3 May 2022 20:37:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 337C610F45E
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqYRaz3mkW/ZmJY2C1+YmTzLS/mVKQLMYZjpJ5Hzb4S/CoqilGsudLf8pSE3stZvJbW7klLuIzu7CYe+v4Do23IFo6D64VqKJEFb+BfVzNPr9MzJ01+wIC+p6WmTbxd35oiq1ggZjaHxWm/TKpJnY3O+tWLkubhl2TskYQ+rg9be3shBtpmvsk5J4P2pzHElrTLZJb4JWF8LEQLic5veCEhLkHqRrPZuci84w3XuZayrFHGTm9JeLzGpsfY+VUka+a6UALbAB5CFSrr8tajsAJRzwmvaz68JaSHiCSS/rbHMLVE+r5bCs0AhSK3z1NYSivRKCAuFDOlHHtS5YKklBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j663inTMN3N5GydgeVNIKpt31zpUm52u4Vt60UuzXfw=;
 b=Df8I4r5+9Hf14UJ62Mhds7Mw0G3b5Tcg0L43PjjeWItaEhpjPCBJaLoSmLv9sZDKAWnB0qh31Hz64e+89FMUjIz3YH5JLGjFtGOko6teSKqiHBCxw3rlM2ajFXafJ6z68SILGZX1FMJBo9yedOWRMy9pnicniYinJ2sOA9juNrbxIZOywAMGYHbOvqJpwifyDCy3RxKFo/8X5QOpEzvJgc/v3bqJq62JdFDnDSXb/H1HPwY8G8Q6LI/WWHkUUS+eOiKEp+JPYSPOgAQ1QVj3+/8e44UZn8pDvh2lWr+YY9LTGQzKAjyTTFg8fpTYmRH1OgIaWhb+yYjG8gU5yS6VBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j663inTMN3N5GydgeVNIKpt31zpUm52u4Vt60UuzXfw=;
 b=RLRWFSVJvCemOoKk+0pYrssoKYWTkaUB8jVVRVtyJXBWab/je1I2MUmWjb6L6g+2AWfVLzpaz8TcYVqJYvws4rF3TJ9Y+VVbama9TXDX/3FJt/Y4V84msNdMnpCPPBvPhtgOO6Y3jywa7vmj69OQZ0tbsbBcTMgt6T2PSeDDm1k=
Received: from MW4PR04CA0137.namprd04.prod.outlook.com (2603:10b6:303:84::22)
 by BN6PR12MB1747.namprd12.prod.outlook.com (2603:10b6:404:106::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:37:41 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::bf) by MW4PR04CA0137.outlook.office365.com
 (2603:10b6:303:84::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 20:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:37:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/26] drm/amd/pm: enable pp_dpm_vclk/dclk interface for
 smu_v13_0_7
Date: Tue, 3 May 2022 16:37:06 -0400
Message-ID: <20220503203716.1230313-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53fb6085-3f3d-4c56-5bc3-08da2d44c4ca
X-MS-TrafficTypeDiagnostic: BN6PR12MB1747:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1747720073FBE8F0936DFD17F7C09@BN6PR12MB1747.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 10+MaY0HWsgTL4u4vcYVO9AU8Riyu02I9/TY9RyufLKDqSD0O0LRdroOETPihWgHb6+vcX+j+Mlb332X5zYP7rWqr6ZBwreydNn1NMUwfifxNOigTHHy/b7VGNmfeWRRDfEjwH1a35adNA7+zLAYiIyWU5IxJsfHiPEYiYplU8zjhXgl3OSm8pk/1Gwsvn+pOnRhN62VdWXfLK0gsbG2tCVFm9T/3RZXObR0jNa9bzwbCN3Gt3vBlByhKnjraVSioUmHox3wOvwEocsYfWmx72TAuE1NyijJt6W+OS5KiUKwBQoofP/LoT3enTe2LCUrJWWWG0jv+C76weB6NiQHQTeLSHvSHtuw41XJ7lo6w3h1HM0Lefhrx8K1fjRuZ4/uKAvsNrHkVxzx1X7xGEoNupV0yhY+fcz4nVZy7lx249VrdNnIXEtfweWjk9nUIuezi6BE4ZZ71RoLbb81GDPTLSOw99+ymMs9K3ZL9COuXb6GCSHZ7bDmCrdQZb8xRMS2r+WyyUSKmOYAibWCFV7/fv5yiyqz+UuKmMSuNEAKSJy1RXQmTV8o5LJcR79ucaFJpqUw3CDYygpMhFIWibWpDNCHcm48893h8MbfyVwsEmjus3HbmKL3SCZcWXg2rwUfN25hNcfhH/K2ntcE6psFlMubvnI70ZXnEUbIlxOR4jTEfcqRav2iljeMjQIR8hP2P2ohIKBvfVnshR4uedZjkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70206006)(81166007)(40460700003)(47076005)(336012)(426003)(82310400005)(8676002)(70586007)(4326008)(83380400001)(6916009)(2616005)(54906003)(36860700001)(16526019)(316002)(1076003)(186003)(26005)(2906002)(86362001)(6666004)(356005)(36756003)(5660300002)(7696005)(508600001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:40.7250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fb6085-3f3d-4c56-5bc3-08da2d44c4ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1747
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Jack Gui <Jack.Gui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

enable pp_dpm_vclk/dclk interface for smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Jack Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 6e40e9ba9ff0..d2978396d6b7 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2011,13 +2011,15 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
 		      gc_ver == IP_VERSION(10, 3, 0) ||
 		      gc_ver == IP_VERSION(10, 1, 2) ||
-		      gc_ver == IP_VERSION(11, 0, 0)))
+		      gc_ver == IP_VERSION(11, 0, 0) ||
+		      gc_ver == IP_VERSION(11, 0, 2)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
 		      gc_ver == IP_VERSION(10, 3, 0) ||
 		      gc_ver == IP_VERSION(10, 1, 2) ||
-		      gc_ver == IP_VERSION(11, 0, 0)))
+		      gc_ver == IP_VERSION(11, 0, 0) ||
+		      gc_ver == IP_VERSION(11, 0, 2)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
 		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
-- 
2.35.1

