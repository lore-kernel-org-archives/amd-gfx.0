Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C609DC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD1E10F640;
	Wed, 24 Jan 2024 07:02:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C34C10F639
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:02:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzM7lWJ9XjAit5R1WRJyKO0cCrxiMGpaNi/sE4qSaeltqZ1j2JoQGzDCcDFEcWdBuFvqbvwxibybZGVhyFY84KGXWNYfOzFeb7V5dUZAqwWFIQuVuFm2MOu4uXZh2WJcqOOCT1AltAw1FZGEdZdNWe5pwbNhX3DCEqQvzPXvWZWj4Msf4XjYjXsP6Oh4LtMkIWX5d86C9ZVYueJeSQzKk62GFwQaP8zY+t/Gwh9fAylTb+g9Gj6dT2xsDNHQdigB+iEjoR2Uu6ZWC1ZvLdurzRK5WwgW+yJuw2UmOCcnFzICZY2SY2sL78QGhgvHXoVE8n2wD2I7b4qT8ahgtTmp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6MFnNlZE9PlKERTrqrzqYxHy2lK67r0GDfNNmOyXOc=;
 b=c9K6oM3/Zc98C2iGOY/dEu38zG8IecXnpFaxSLdwSqoNrylfW+tvhcrkDJRubRQ26FDCknQtHQofAPhmEg23uXcUihYJrRgF/6yyRg7+ppEl9urmLQtIqK0VbGSWM4lz1bQuPmRQQF1IR7EJ7ZccVnY68O5MUNYAIj/n5vm8NwswS44yNxcxLm0zyLC9FBLRaljI86bw45PM2ZU/lO7sbZROMhSMrS0NdOK6Z8BeQhnTuRddVs8hqh16eHhGhLvRO8AvcQyOfF3ZpfSGWvAVqr0H5rw4krPgSPMMLkedn4YpwWggvWaQSNgWRkPPHOwybqxiTt5lRM816JNBYuf1ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6MFnNlZE9PlKERTrqrzqYxHy2lK67r0GDfNNmOyXOc=;
 b=CIXt0l169JcFo/JmhFVUqUj+Sb7JcxdoR9lBXnn7ZbkYhjCZPmPGZAy/9cEYaJrbJQt0kYgLfJc2a3WZR/bFoC8YLCrDt2x4oovEuBIFUY92niEsT79M3Z3b5OllZaznk4trd9fG9b202sqiKGnzxIoSws5Py/3K7PIXZoXxldc=
Received: from MW4PR03CA0160.namprd03.prod.outlook.com (2603:10b6:303:8d::15)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 07:02:24 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8d:cafe::c6) by MW4PR03CA0160.outlook.office365.com
 (2603:10b6:303:8d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Wed, 24 Jan 2024 07:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:02:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:19 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:19 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:02:16 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/22] drm/amd/display: Wait before sending idle allow and
 after idle disallow
Date: Wed, 24 Jan 2024 15:01:40 +0800
Message-ID: <20240124070159.1900622-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DM6PR12MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: abd51b8b-798a-440c-1f61-08dc1caa6a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ElqR/PzQbfiTyOK0G+InCVSbXa2nPIuGEImMyspYsFAtXdqCuPj8ERwhXWHWN/21MSbTiRksJCz5SX2oPUqvtI8vF6QH1Os/coekLvrXHnZPfb+86hbZ6Cghxh/m6Z8FHnMFkT4Kq6nJ0x8v8M2stYrtC3glhBEGm9jOKhBH2sjwx9JJ1WusqJEXQI1Bjjgft0iOW6owg3gc233BX7z1QhofTe5hzTWRMMsCC135b9pVtWAT9deR8vq2o/9tvf29R0IKCO88vMljZbWo0rEVS58EvnOEAJEABjEVnhqQtiRQYDU5GJ3lw+ysYr6DZTKd70vxfeJjna9X7jBga1MvTpVjDpA6QeXnpEps5VhsulOhqvP4uvwr4388GGPo7l+2FAHoIY5PwNsXwUIglRW9fHeXjNgS1ux8zAxYucguKpBrm2BLKA+JwF1jXOqMfBlLJZw0HHY6cY1R+XxB07LWed48IjUb/scIMRt4n/NL5k/35IqwFxfCZZh3dCnoqEgyO9psh5vaM2TMAb1i5Trs+cLEXj2yC/SZjlztEmBrAR8lR9ciKrRTGOWcTJ3XXZdnv7aGAI9KPTuOAfY0V4NC/BtEIMtuotEVl2e7aJScHjhJOe2fQ0leNilInbvOcBWSdG0AiCc7c+Fup40cPQwHg+RUwBclS19/Z5PVG6s16yneQEZPpUcvJZ8aQ6OCMxehsa1eWaLbHr5xjZBvT/dFz3zAov2AojFK1zYDKvU/1I1ZpFLGckpayVhVtqFrV8d1s0SXpRwm60CmgH/x3ZFHYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(82310400011)(186009)(1800799012)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(2616005)(8676002)(4326008)(8936002)(5660300002)(336012)(426003)(83380400001)(54906003)(47076005)(1076003)(7696005)(316002)(6916009)(70206006)(6666004)(478600001)(26005)(70586007)(36860700001)(81166007)(356005)(82740400003)(2906002)(36756003)(41300700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:02:23.7127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abd51b8b-798a-440c-1f61-08dc1caa6a9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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
Cc: Charlene Liu <charlene.liu@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We want acknowledgment of the driver idle disallow from DMCUB before
continuing with any further programming.

For idle allow we want to minimize the chance of DMCUB actively
interacing with other firmware components on the system (eg. PMFW)
at the same time.

[How]
Ensure that DMCUB isn't in the middle of processing other command
submissions prior to allowing idle and after disallowing idle by
inserting a wait before the allow and by changing the wait type for
the idle disallow.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 2b79a0e5638e..c365cca05718 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1195,6 +1195,9 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 	if (dc->debug.dmcub_emulation)
 		return;
 
+	if (!dc->ctx->dmub_srv || !dc->ctx->dmub_srv->dmub)
+		return;
+
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.idle_opt_notify_idle.header.type = DMUB_CMD__IDLE_OPT;
 	cmd.idle_opt_notify_idle.header.sub_type = DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE;
@@ -1205,13 +1208,15 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 	cmd.idle_opt_notify_idle.cntl_data.driver_idle = allow_idle;
 
 	if (allow_idle) {
+		dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
+
 		if (dc->hwss.set_idle_state)
 			dc->hwss.set_idle_state(dc, true);
 	}
 
 	/* NOTE: This does not use the "wake" interface since this is part of the wake path. */
 	/* We also do not perform a wait since DMCUB could enter idle after the notification. */
-	dm_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
+	dm_execute_dmub_cmd(dc->ctx, &cmd, allow_idle ? DM_DMUB_WAIT_TYPE_NO_WAIT : DM_DMUB_WAIT_TYPE_WAIT);
 }
 
 static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
-- 
2.34.1

