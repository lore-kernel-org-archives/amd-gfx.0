Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4917DC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4202910F8A0;
	Wed, 25 May 2022 16:20:47 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B76610E7E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KT+YI4qyX731cOnS0pcspyO7wXsByYgh9Rh7wSxjtL5ruqmdB8uvXI2we9S6kRxVLn8my/qTN084FAyqt2u7vdihRAmnvloSqdBJHSyYQhgbMVxfYyzEgjJs7vnkpRA3ajdCCBb7O+5PjdfrmC59otZF68IR5/S6ZwzAePJfrjNTOCjOUhf9R8/5TKSnjutfGogcXs4ZvaqZutIcr4nZQCmz7AB7992PjU+1DDRytao3SwyY+EvHynb3yyUCRSDm4347ofmJ5AAOgpT0S115favJWcccC1+1wOouZDFtKRHONXD/ohLxRLLGXkyoFz90wozNd6t8Ct9+PD+8saiEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VReUgcuPrDVzW0Sy0LgZtRrmCGOLdvMdDyI7Fo2ojHE=;
 b=QrIU3AxqUd8ek5EUdMl8EFyU9me9xAPnRU35FSH4i3CsIpQDsJwPs0TvXYt7/VlLPT5PvZteOnAdzJJ5L6CN560y/gtPDKm2va10znbOHg04cPHt+AB0TUO/uV6+Uk0jsOf1LpB7PM2t1hribYtwhuoYErorHEB8HGb8zBgcOkCukv/RXapnNAdHtmvWrryCnk18iFsIDZqBa2e6ZGJYktivH+w8WCSmYMydSRggas5b2/e/6CvipU9YkYECYXtro2neHF0L0+wkrPdLX1qBk1Jg29sgZF4NjiDtz3eZ5HV5feSj9siXYLS+a+vGC6jeG21fQ8C0KOXRxbwAiGbXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VReUgcuPrDVzW0Sy0LgZtRrmCGOLdvMdDyI7Fo2ojHE=;
 b=qQGztNc3NTNDWCXVX8Fdqi9vkTFWG6CYI2g2UtLX6DWpyGrRdeg4dd0porhba2sUIo2HEF0TR/vq2XnIgq0pt+GTtfou9hgOQ3/yJIqYufHjypLeSOjenJUbdo/Rg3WTetNwE4oYfsxJfP9yX1T67efDE+X8fdOsG+Pw8SqgvQQ=
Received: from DS7PR05CA0090.namprd05.prod.outlook.com (2603:10b6:8:56::13) by
 DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.17; Wed, 25 May 2022 16:20:17 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::83) by DS7PR05CA0090.outlook.office365.com
 (2603:10b6:8:56::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/43] drm/amd/display: Ensure that DMCUB fw in use is loaded
 by DC and not VBIOS
Date: Wed, 25 May 2022 12:19:23 -0400
Message-ID: <20220525161941.2544055-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3aa9370-4c0d-4f4f-2a41-08da3e6a749c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2988:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB29883DC0BAF677A145732167F7D69@DM6PR12MB2988.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbmOIsTM9KX5RJpjgsozX9L/cetYpiHcr25h3gmFzceF2wFkB+tzboNmsvua1tHU5EmDw1BvFkV8QwkD7sga+B3I1ZpxZ1y9He51vSDXLphNwTz7e579RiP97gkHpnta7C0TJj4506ALVTOZi+8BrSSWfwGv/Cgun8PVPnBiawKL7t2mYgWO1dgVsFO/iasRcJ4YtXiO24kI6dnYNyfY+otNN42Cl6RA7OcNzheNceHlzfleGiWtK84YZE9nsnLZjzB1bojEmeCShGu8JEc8wU+OYLA4AvNEIr8QgOHuT0DS+QlbfItKROe69cyVWGj7Ra5Eg+tmjzyh/7XnmDgxVg5ZagInvH2jvNY8qGZixTzoUWOtBxtPzFw2vWDefnm/w/wdB5/U9qX9DejAp5ZEMIj42iZYv4Jh1sa5MN3yv0XDBMfvtWYgB0nGRrDJWSpp20bvdjTk2FnhPwRKaNHyUnAv8KudOjhRFX6iG6iZ09nylc3Ove0iTzXylP3IFLpH2SXPXBSlIVdaio2962QbSqZmPvePpivy6fMbki92ORshzBuoqeSVd8JNYaA4pYgJCGC62hCYEa601h2e0+2svRGmLJpNnwZI/0ewwTFT76jL+I5ceYdbekCx5+GftxneJtTTr8I310wKenND73Hs08Prk5AFlc/px+bkV3rKqn4io7gGVE5AQDy47qv/0elkfOywG/QVT1wCs+RKfs/Uug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(54906003)(4326008)(83380400001)(356005)(70586007)(8676002)(86362001)(6916009)(508600001)(316002)(186003)(26005)(36860700001)(16526019)(6666004)(81166007)(7696005)(40460700003)(426003)(2616005)(1076003)(47076005)(336012)(2906002)(8936002)(5660300002)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:16.9099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3aa9370-4c0d-4f4f-2a41-08da3e6a749c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Dillon Varone <dillon.varone@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[Why?]
On wake from S3/S4, driver checks if DMUB is initialized. On S4 VBIOS loads
DMUB, and driver does not reload as it appears to be initialized already.

[How?]
Add a check for the DAL_FW bit to ensure that loaded FW is from driver and
not VBIOS.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index 0a498082ccc6..d298f6016e0b 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -299,11 +299,13 @@ void dmub_dcn32_set_outbox1_rptr(struct dmub_srv *dmub, uint32_t rptr_offset)
 
 bool dmub_dcn32_is_hw_init(struct dmub_srv *dmub)
 {
+	union dmub_fw_boot_status status;
 	uint32_t is_hw_init;
 
+	status.all = REG_READ(DMCUB_SCRATCH0);
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_hw_init);
 
-	return is_hw_init != 0;
+	return is_hw_init != 0 && status.bits.dal_fw;
 }
 
 bool dmub_dcn32_is_supported(struct dmub_srv *dmub)
-- 
2.35.3

