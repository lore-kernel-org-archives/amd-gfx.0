Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447E1CD5BB1
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D11DA10F48B;
	Fri, 22 May 2026 00:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LsXwjYd2";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD0210F487
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDqPNq6B77ZjhULQVhejoKZKW5QiBoHa03O2qw89iF/8bANLuBpIcog4UraDqERkM9vMgA+9MTQx+p5kwcQftk3QYXp9Ek1eKYHVz2mRo2gToE3m42lJ1a8KLj7ucjVYmC45Uwp72kJ36ltUibZo9Rvo1gZOw0vLQHGrrPPA5LWJUCmcH1uFLFC7mTdbhbe7FCxUsyuUB7aR8kTUz/adixCVW9a8GAEYS/ulaz05ifD2hG33Jnh1n6koUzH+7jZ7LLUC3TfTnNbti6bOC0PPl9RuLDV1do/pil+G7C7RilptbVwMwV9DICyb69yQieg/YrrZN3eFDP6cyYAF/ZNHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvTkXtNNQObSWSx4AbfZlUDkdNznlI/filSfXpbiFJc=;
 b=QKpqjOiBVQNuMlD0r7qxYCvyYe/ZL9IVyjO7wiFZK2QxaSyq69Lt7Vv/GVSe2JaNIrA6/yKTUKGq9lDBjx5AeiijmVrFLPBo1rhRs3LXBRKLIndCyFOwMTxH3RG5O9v8nBE7gRxwH3D7CU16tvt0epVnALHW6zKzOE60/GsVKYY61j5CaPCiVFsve9Kv5KLynPsKtmuAVDjcAX/HiKKqM+3Mh9dmjEBNaBfKjeYs9fNjiOowBEHRnmMDSLWZ8YTGr6dMUTgZj4Zp+FgRrfXjj/ReN2E0bYK0hrRG0PGl045zNBgA3QudPLspxQYYm5xFP7FXCMy1T+Yn+rAIkxPqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvTkXtNNQObSWSx4AbfZlUDkdNznlI/filSfXpbiFJc=;
 b=LsXwjYd27f09jXhaLhFJ/y41ELnJ3JoFj2WkGc7gifOjdoeJa/okqDkTmZwiIqViPvdrG2/4+LW7z0JR3vY1FtrgW+FxWv7GaAzfzU85vVcgbolqPIdy50e7eW+t0f3z/fRWkZoA3kIaH03UYU+SAnAxGDxRESKFKWfeubbmduI=
Received: from DS7P220CA0055.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::7) by
 DS4PR12MB9820.namprd12.prod.outlook.com (2603:10b6:8:2a7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Fri, 22 May 2026 00:22:16 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::93) by DS7P220CA0055.outlook.office365.com
 (2603:10b6:8:224::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:22:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 21 May
 2026 19:22:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 May
 2026 19:22:07 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:22:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 30/42] drm/amdgpu/gfx11: unmap the queue via MES on reset for
 MMIO path
Date: Thu, 21 May 2026 20:20:36 -0400
Message-ID: <20260522002048.98506-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|DS4PR12MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: d646b792-1aee-4e2e-8304-08deb7982df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: bneutWYOeuV3lxnFEpEQ5wJA2lH4z0BWAnQVyv2XzcHBAQwwL7BF6ilxyD57amNSvzbP1IfmL556/dJBRTYWhIDpHJbHgteTuTvl49ej00aOVYoy9wzKU1voRupUZ1zIm2ru4qN5j1HFvmJMy26ctZ1hlS2lUn/XHyZSbwwxfy/0kvR2UpSsjJTCoJzu21CMLiBNxx1+/3mwWBNIiTwS6TsnNwNdgfYBdEJuCDhG5IsX7SUZIAArsyFBQHmhN2oW0zP1oBhVMUnEvgj7rWECu2ZkleJJr7f2PsS9BrN7Y5wTkAuLHZenj8IvqlJ/yZYBU4803rdeq9EsZYwhms0qQbxsSlcVmnlQD+6AEoB/GfFIW/61685/8J5BHm8/OtWHz8cp2uuTNDtBR1xbdybukFVttGYS2nhxvO7hfG9lr8QNOO6RtChtLBTDb9sG1FIGZn7zVHi0Ss6fbkg1fYIQaqaCIZIuImUOpcHsn99UeIT0eqyxCte9iv9k6dcg2wnN1UkfrOEJAiiqjGNdHNyubQDgf20wiT83HRYN7cqKNJlDC6x7b6ITUMj8/m6I+QoOUxIicYtt1m2SNiGNMq1nGgar7TIqME3LfS0FN3fSpp8D7N2AKDlbR/GFVTM6mSi7wxawxPknzKdxXH/NK+tFPtGqC67Xpx8R8fIMR5l8KriTPqxKiPSA5MVfSwdLUOiytUJLuEQ7be3usgmCW4rtv9VVN7VTVeGjhr9WsryeRjk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r8Ux7fM2IryGN8Ga19onnMVraf3Ck7eyydQjojXtboriokFIPTIQI43l/h6K+927OSBC56/ZNjJPUmzpe+5VWZ0gChFRhr+08SX1vk2PL4oKy7ZP6g0AT91Et+p/VupZfgCYkz/Uek6kQ8872gABzKWq8FfGmItIiUZcldhpNgPEqVOwU1zZoHfZTTR1mfNw9xi4LHIUy5sj4+JYOoc4pgEv+vqPCXoyqxN/FGpDYTJJmANzpYUJV/eXSNK+7VDBV/m6A8Vpvv53Wu7Y4/7L7QWHOx7+DMrl1mrGQW7vOlwMix9eCam2QQwKurdkBhDZKWGI76UqZeBsp4KAp4SdWwmPz2SuazpkOHS+ZIPzfGNR45DuVJXXUxrSLVZ3FPXNJvJtuSXWeCDhpmd6rRQ6asxZZ+44Vxdyv4fkS0DMFJJGjC844YlsWd6BXHU/S7IA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:16.6939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d646b792-1aee-4e2e-8304-08deb7982df7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9820
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

To keep MES in sync.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1dd35aa6199d3..455fe4b3c2055 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6790,6 +6790,10 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 
 	if (use_mmio) {
+		r = amdgpu_mes_unmap_legacy_queue(adev, ring,
+						  RESET_QUEUES, 0, 0, 0);
+		if (r)
+			return r;
 		amdgpu_gfx_mqd_reset_restore(ring);
 
 		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
@@ -6817,6 +6821,10 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 
 	if (use_mmio) {
+		r = amdgpu_mes_unmap_legacy_queue(adev, ring,
+						  RESET_QUEUES, 0, 0, 0);
+		if (r)
+			return r;
 		amdgpu_gfx_mqd_reset_restore(ring);
 
 		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-- 
2.54.0

