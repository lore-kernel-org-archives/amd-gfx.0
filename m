Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E71C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B885A10E6CF;
	Wed, 28 Feb 2024 18:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nu9zsN8h";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8B9310E6CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:48:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcwcOW/UPdMGU0JHxcmqRD9siQQo+gx/gGHbyRFfAoLxZK9qATn7Xl8ffDZ/6lrUob2J0+NjBYoxPzjmm8mNeU91TwqDWpoOpu08e/AbFglm9n3pOL4/19Ssoru47sR5RoT9FLEvrHwbqBL7qlDl/OkXgfrxyq9ed+VsNYKm3WmVCWb9WpS0ZiOYcHWBk1mCkoq4Gz0pJOFQJR8kb8ioLO8RgnESQW/LWaBy6PKcd+7GhKGF85/wBjHGj9xMFUXv6ULR7OgcX/Y8TPtkTiZzdc1pOw/FTFc52rJO7cTczKAkNv2Zkb6M1qFlrsJ+JNKb5uG0rDpseIAJ0obSDfYggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17/6b1WcHbB5Vo/f7wQCvm7o9Cev8A8AgsK8MRX8ZgU=;
 b=GKm40QJvfm3CHgCtwKXFtDL6nF6i9xPpqLRZ27FlkAvF1EoxYB1hVW5VbETrC/QvQOBasUm2mTnsodgTMAXAncZiPR/eTluRvdXsCL1fpetCTt7lKK66+fNpaa4ULK/iStOnDUHG7uoZmKowpndfSrJMwdC5drRiqPtbFLHMXiVcelC5U3JlNdnRvS8HPN6hiCMERno/oKWUUr1cBafQM+fv2NUwrmiEQoE96kz9P9GOvwnKKm09eQ6pRRQxjMktaBRlKstsh8+2iFts9iQ/Nfle1+YRXM+ZIhowCwqYk0Ad/FGeB2npyPyr3G8jlyvL7A+5I8XQfW2ytfyXZS3AyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17/6b1WcHbB5Vo/f7wQCvm7o9Cev8A8AgsK8MRX8ZgU=;
 b=nu9zsN8hKyrZP3nvowNbGNw/FLKLBDU3SaJrIqZ8EFZOmfcv10GY4ssruvfdbn+fLQ4ClUTmhblCypFULngxJl5FtdAD9aeCPZT5GHrPuONA5JGtGruKzBcsYc1IwS3bqY2uZvp31BU9+8OBPRpzyPPc1mneB5ujqOeV8nuh84M=
Received: from SA9PR10CA0015.namprd10.prod.outlook.com (2603:10b6:806:a7::20)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 18:48:27 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:a7:cafe::ff) by SA9PR10CA0015.outlook.office365.com
 (2603:10b6:806:a7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Wed, 28 Feb 2024 18:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:48:27 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:48:24 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 "Alex Hung" <alex.hung@amd.com>
Subject: [PATCH 34/34] drm/amd/display: 3.2.275
Date: Wed, 28 Feb 2024 11:39:40 -0700
Message-ID: <20240228183940.1883742-35-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: d34527a5-3d1e-4f79-d993-08dc388dd98c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTWrxcXlw103UQPRndHQyoWeVFZCagzxNdjb7wkidkUsGNb8N0swpejcohNIC5iGbj20kzcWm39T46JEaOvloaztqJAaW3DgKAZlk9cd0GZkX3b5wketazgYZis2qktHWqh4m4YcqK3KrZ1IW+Ewoeg7h39Tq7Raa5BV/W573/yNvUsXOHHhMIGG0yakyijcDagyWUoYfs8yL6iibs6BCEoF9wzHZm8nZaUBiWe3Sqcw7HXnvdrAmFRaPb7L16KlRdSstMXEo02OVER9ggToB/cZ7JhiRtmMd4UEIv54L0JLJaQ8FJu4IFJ84JuYYtN2x3R3sKxthdimEgW2gixYxlHU6Zr2LdcGnNGaOBHiiRvgMz53pc3+J6FgZLifi4ZQr2IXfbQJpVcRULxf/ZZsqYQwFoeAw/vrZWVuz8dgmhxn3FxLfN6AVR0YVUjzVzKB5naypWdGwtgAlIbEC/DYS2ePRK1ZeJX1v843tvB/5WyYeSS7Z04NqseyIKP4A/DnCJwPHsB1PXhhRmhijWrSfFRSIhYw0Jb5Tub5f+9N854vUSSRm8438nWjUPkpNK7aiRe/pqGtnKIeCYm2vB4WWAOHAOub86wgbFkK6ImY4DBpw1qJutNlkMEPeja3w8wPv9m8AAr0uMgCtt7uJi+3fA8iY3WXTJuKSHLyOnAw1Qnm6b3+7qmKvFipP8XNzrbdPdfdLziF/oiAlmm9StK0e09lrlDUNSTXF6T0/KH55qEhVVVnsqU+15J+9M853Epf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:48:27.0573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d34527a5-3d1e-4f79-d993-08dc388dd98c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
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

From: Aric Cyr <aric.cyr@amd.com>

- Support long vblank feature
- Add monitor patch for specific eDP
- Init DPPCLK from SMU on dcn32
- Update odm when ODM combine is changed on an otg master pipe with
  no plane
- Fix idle check for shared firmware state
- Add guards for idle on reg read/write
- Guard cursor idle reallow by DC debug option
- Add debug counters to IPS exit prints
- Add left edge pixel for YCbCr422/420 + ODM pipe split
- Amend coasting vtotal for replay low hz
- Refactor DPP into a component directory
- Set the power_down_on_boot function pointer to null
- Implement update_planes_and_stream_v3 sequence
- Lock all enabled otg pipes even with no planes
- Implement wait_for_odm_update_pending_complete
- Add a dc_state NULL check in dc_state_release
- Backup and restore only on full updates
- Update DMUB flags and definitions
- Return the correct HDCP error code
- Add comments to v_total calculation and drop legacy TODO

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9629bd9252b4..e17ddda8ec38 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -51,7 +51,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.274"
+#define DC_VER "3.2.275"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

