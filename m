Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23125C531DF
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 16:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8EDB10EB62;
	Thu, 22 Aug 2024 16:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wqCvG58c";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B0310EB62
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 16:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzlL3Ypet9OW9O1IZgtTMBec+BYG13aoku+JbysW3fumxn1yYXxJXUAyR/gohSo0wmNlD1GSeJIiRAFMnrkFrlMM9M/cCnuqEK9eDWZNDDfF6XU/8XTC2Yr78BoIsmxqLGyGvmKjZY5x0Em0PBuNEFtnLIUUxQl39o0tVFMlDE1TeUEfpPj6nehgB26GwnQOJlj9ND97UBCAR5QWyIawihyXWrVajE+nIKoW+0pk22S6F0HMkzGkncC2gYxdeN4nkgfutvvICox4tEM2TN03FJCm4gcJjhSvvnRtpjsF4t46xJfYtFVl/KNWIfUyMz0Lt6Sx3WDMwgeFJsRXPgBrRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AD5F0g93GdIuIrD0FSCm/a2s56mS9DS01dxY1xq7sjc=;
 b=yWXWv+382y1/yg+eLkwzz3JNHmc1CY+JSvoIStHtzHghVPK3Q6Nxv9DdFzRf9rVr7Sdw+Ubx7XUcRnndQSfMNRqvOZ7bRPMqNkexmd6PdXSQ3aY3kTidtC+zsl0xmz8wCtiXVCRq8Y56CrmLlXrDuh/6JlPx4QMGqCdySmfbhsfzw9w8sX5AMrshGiSZhng6LYm6m6GSVoRYVE6u82DWTaHvqihJHf6lO9TQhS1pdxESz4VcOct4yTWT53/PNECzxIWLtc4seX94MzSB5A0GcryY2Ec/0Pzkx8Sk5Know7bIjEQ4QPYMub8AVbtjubcfW0kAp6EwPFti5drs8N1dzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AD5F0g93GdIuIrD0FSCm/a2s56mS9DS01dxY1xq7sjc=;
 b=wqCvG58cxjOLsyCMC50ihdZkairT7WXJwii3WXIUvtPihvbvFkSGg34eO+4xyQurDoE8Qv0+NekCRTUcWkZZqmUBDmrDDiog3QBgLxgPxRJUAEpjzLG4A1oLAaG4A6YioXdZ924ASHjzTVi/CwzRq+w5fadTPDwZl/epu32FWO0=
Received: from BY5PR04CA0023.namprd04.prod.outlook.com (2603:10b6:a03:1d0::33)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 16:19:19 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::a6) by BY5PR04CA0023.outlook.office365.com
 (2603:10b6:a03:1d0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22 via Frontend
 Transport; Thu, 22 Aug 2024 16:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 16:19:19 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 11:19:17 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH v4 2/3] drm/amd/display: use a more lax vblank enable policy
 for DCN35+
Date: Thu, 22 Aug 2024 11:58:21 -0400
Message-ID: <20240822161856.174600-3-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822161856.174600-1-hamza.mahfooz@amd.com>
References: <20240822161856.174600-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 7035f864-69ce-450e-4827-08dcc2c62d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sGaUlj0tATBX6LXwAYOFObqYM962Ytn4EqH7N+rE8cgCVoxj3tqiXsJGNaM/?=
 =?us-ascii?Q?o2JX9WIpvwuyHGjmYstOg8OG7KE9/A0C8B3QW1paHK4KVDhO8op3cSYyw/Es?=
 =?us-ascii?Q?iOwy0BrJcigXgrL7qzIB2jwIXcSzyJI9VmU2BJ1MOZQQchgOv/Bl5XZG/XXo?=
 =?us-ascii?Q?pmi9U6yBdFyM2+Uje1/QcBgsrDVLxjAdUFf8ro6KGyViYYqyLSzUbX04OFVY?=
 =?us-ascii?Q?bxI/UhQ3BMRrjDNm2/TaAPvT0D1QXzqLjN4ACzhUXEnQ0iUjMZPNSnV85ODm?=
 =?us-ascii?Q?0Ru1K8JhjGbeZe+yt8aNYY9xLQCxbdhWoVVQOPDjzFouVkrbz7Kw3IEpbXa/?=
 =?us-ascii?Q?rQ38/FNyjXPTbpy805duEj2OctFifPD5jx1TwVLl39SDK/xWmU82uimBiHiA?=
 =?us-ascii?Q?k7qH+eCP9RvTMQdaemcgvOuj8ExayGMSJMZzshRA7Psj2HhE98z5QXFdW3d1?=
 =?us-ascii?Q?ufvLpsUMlGNiQdnm8l1zUMPmxaRbdtZ/t7VMIJPC4aTr8U6h6zLpFckJqrY0?=
 =?us-ascii?Q?tr+qLR+Y/NdEKB6gRGiqiHVHeURYjPcbf4Z60hCb6WmgQ8DIRpNAoG6i5b2M?=
 =?us-ascii?Q?lYXtUTpgu8a7UjVmwS5A4M1tiqwrdlI2DQC+DtDeA+9782C/1hasTkC3sk9r?=
 =?us-ascii?Q?mtUJ54XcIoG9Tkp9SA++4J4Lm+S3KyEGSKKvx5JKPshTM5qfgFEQZHqkGNdD?=
 =?us-ascii?Q?rCNV7I0TcQMHN0dRGNdmmRVgcD2jmbKe6TczQbVyc/aVho6QxqV2nphz/l2B?=
 =?us-ascii?Q?Kwe3zDvR1xXyMjxIKVaGkECzv2d3T5lOsZlU5ub5H6TxHVu4i9zCPxtosP3/?=
 =?us-ascii?Q?2d6bYmdLpMtkf7VnaFd+7hJIYPPEY+Qgmar/+6b5rpNFGV0j2q69ektcJ+f6?=
 =?us-ascii?Q?PKccevDsTf4PQ8x9Dh4XTWyn/C1RZ6om2aOhl1wRm9auviaCSGulQyZipl4F?=
 =?us-ascii?Q?HjQ7O3r7bi2lzyurMdcOAzFW/7uBiKUK7z3kdE+D8jtHhSjA8Iq3yBFpWyqO?=
 =?us-ascii?Q?1k/8ZbHhfPAHvLf2+Bi9Rt+07Dn9iv7aE7W1aU+yzVEFZnidgQ+WgPx6K30d?=
 =?us-ascii?Q?VGi5HJnkL5THirBiOqSJ/VDb2EVOZlkgaoE7BkrzClO4hpC/ctkS+Q1LZe+y?=
 =?us-ascii?Q?HF9VVCLmBRHjWSon90AkcYJ+gO136MDgRSYoD0DStuoDcIOVOmUzLuRSylJQ?=
 =?us-ascii?Q?eViPeuH3MCeiqR8oKU51EfvaugxSdF+miFfZBQmAz3H2hYnsgtGg9sApDVil?=
 =?us-ascii?Q?7itmQGgdKt5F8XxtlVXNfUmqYfvZs6zcwdhMfOF9tmDcfJlFvp/7Ry47z+b1?=
 =?us-ascii?Q?VTmWG49jRxzCJFokCeGqVhqzKN1U8HHNpuRCfHu5V47hNia/NheeBEjHN0kq?=
 =?us-ascii?Q?UOBET0fZW09wdRR/14rqx+Hr7fxBHfN00hH6jbtFbJjYB7qKk32c6gfK1apu?=
 =?us-ascii?Q?6AYcx2KTv9ZaHND/EpVSM/8ykuNXjC0F?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 16:19:19.4034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7035f864-69ce-450e-4827-08dcc2c62d1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654
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

Ideally, we want to enable immediate vblank disable, when possible and
we should be able to do so on DCN35+, if PSR isn't supported by a given
CRTC.

Suggested-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 00d4c97e8d26..68442cb857fc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8246,7 +8246,8 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
 		    IP_VERSION(3, 5, 0)) {
 			drm_crtc_vblank_on(&acrtc->base);
-		} else {
+		} else if (acrtc_state->stream->link->psr_settings.psr_version <
+			   DC_PSR_VERSION_UNSUPPORTED) {
 			timing = &acrtc_state->stream->timing;
 
 			/* at least 2 frames */
@@ -8258,6 +8259,10 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 			config.offdelay_ms = offdelay ?: 30;
 			drm_crtc_vblank_on_config(&acrtc->base,
 						  &config);
+		} else {
+			config.disable_immediate = true;
+			drm_crtc_vblank_on_config(&acrtc->base,
+						  &config);
 		}
 
 		amdgpu_irq_get(
-- 
2.46.0

