Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0A1C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BDBA206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BO9VF2Q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDBA206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82606EA90;
	Fri, 16 Oct 2020 03:29:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 218606EA8B
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:29:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yxke+tHIPxX/bZB1WlMc1KaqBokGiopkrj3vNTCQj4TXQMYB3QJnmv8RKSfZLMo4AGAAKzHWIrf6nkR10nVHdWtwK0eFUFcR/AnJBJTviHp7mAIZL/C/Jcyjzhzz5/BblveTXdeEbwXdRAHbPPeBlcyHEkAzaVWLJKfhKcLJi/ve65XfEs4X+IF9AdIxt4Fa2zMF5AgnzJHLf8ddbQaUP2iJeZKPjEyZJSiup0V9HUYGOPfAuzPHmEVB9jEL5UBnm66lJ51og7duemymdDcS3xu1a15n/x4phTV/gN0T27BbPczzrlJkoo9LKdxK3nLGsIyPwGZdQB5PQ33QTLC2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYce3lgYsBsEXIr0Egd9Ls146NExZLt1ONgdplKbr8s=;
 b=jypIsVS7XVrFimvtFDki+ZiGopNTg/48OOZme90dmHPHLMc0NFK0XsoIAIWNiYjhCSC4Pz5VLJ9wWK2b8AZ5qTQvopwj1C4j5gUP87NPC7yOMY4OQ9us1qrq28CrFgEsJUmfaHXEwao9xFXwkCmDAho7aX4xmVNytiYu4NHeg85kIhAu9vZnVV4hsafMxkD7ZrOhtM1oy2C0401Cz6yvu5/idsFOj6lQ1xg7Hw/QeCjJBTYyIdznlizURzAFZKfttwFwpFdxX9DM1pg2nYp8d/0zBxI6Ws6b/ZLO8vMwEkwbUPRR3J7e5ndVsP7LeORxduyaNkQzENmt7IWYaFGjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYce3lgYsBsEXIr0Egd9Ls146NExZLt1ONgdplKbr8s=;
 b=BO9VF2Q+qdUXAgVRlFMHCzHB0EY8PXJDTwFuEIXA1YvjOvsotnBnxgo7DnqYptm5aMMtP8Rnn/HLTOyzLuYI/sM27R8KugwuEoMcgPl/T1oDzV0sPa7umCxBXH+A29NWjznkjz2SZWWnH+G2Qea5Ox3YNxOXxR8GCR/pqYJHYxg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:29:05 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:29:05 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 39/40] drm/amd/pm: reconfigure smc on display vbitimeout
 setting change
Date: Fri, 16 Oct 2020 11:26:51 +0800
Message-Id: <20201016032652.507-40-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a6ebddf-a75c-48b6-bd49-08d87183948f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB135402AB928043ED574B34A4E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGKs54bSSvJCXFm+TLsZJcd8Dq1ZwmWfX7BhW5w/IQ+ZdOFgNfg9nvuu/mZ3toeh3GPyYPQ6kXAoRUvspRRuPA9rjwmG01KCmyedVFg1ekmSBT1V4bsaW8a79hR0LdjPlh1t0WLChnGdXb0trTJfGexEGyWWtYDesbRCM3EtMOeZvgPVYW3zTm1sHtk7C8RclQD8klK3LhFH/bM+KBJlCY5qjCWZVOxUdv9M/z027KPskMunrHccE8Ztwmu08kpa5iPg6kDhfXzDdlWlAEiOkLxCWn9sYhzR1MWw8MebcSwtyIaeIWSrAnF29twuwHH1PtXkC0XQAlrVW7XBZTb/h3qMiprsLu3/U3s+/jpeSPU/rxZwltDrKUb3RMgwEw8P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ypqyxCnBPhfyTcFayUl03opFKS7mFfzmkYSjpfohcJU5jtmDb+Zl2wyLvLAMXCrqSR8dK3rUBdXPSY+3WXNI8hEWrr1CMBJ8OP3sjywSWkLNyxe1uvqK0ef887P7xi8ZShR0RP8uizQ9GKLgpNVOLHmRAO2QKP/GxP3yOw27cCYr0KoaBbRxlNuavr/6aQjKhe6N0gqIewhabuVU22jvpL/kO5Sjvg1WAYVV0HQlK3dlh3BZVQ0NVgUkBoCR9gMalkBbykJXffpJM/VcBpx8qFByhjopUxKUOTO6eML8F1ZrAYFXWLIL5tXMKZmcH2Xm5oEs7ihy2kG3M3w953h90vN4lYfmx7ecE1u39a110qpdWJ5baTOeuI7wvXwTRcULrIVLjPaMhDTdLzgyWuqtjwEQqCrvmfa7sdwhX0CQCQHxNnLBdOOoXxxGDdvUY5Onqhp+QJK7ZaioE/j/9I2rbEmH5x720Ew5WtQilOQIKn6uIXEa1eODKPE7ee6DFZxXwwNmF/LCR0GKBg+ZL3n8djznJotZvhlitSOiwyr1ZYTwHA1on7NFq6vitU2hxAkywGc6D3duJmji7atu2TdNCqSVbLOU9ASmLGnK2oh115ibJJkwYD/yvJgbrUonobPlAwMC1yOm9D0TeHu9nTm4/g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6ebddf-a75c-48b6-bd49-08d87183948f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:42.1506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2vQ0XRRmQqBo+csUPScFDJL5zxFJmf09/1zdC/TbVVb9xnwYFQjopK5PgrUPO5i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reconfigure smc display settings on vbitimeout change.

Change-Id: Ia026f6585954ce4e7f6bbd2e270a201f9c3fe25b
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 6 ++++++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 509136ea193c..d6c903e80692 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -4318,6 +4318,7 @@ static int smu7_notify_has_display(struct pp_hwmgr *hwmgr)
 			smum_send_msg_to_smc_with_parameter(hwmgr,
 					(PPSMC_Msg)PPSMC_MSG_SetVBITimeout, data->frame_time_x2,
 					NULL);
+		data->last_sent_vbi_timeout = data->frame_time_x2;
 	}
 
 	return (smum_send_msg_to_smc(hwmgr, (PPSMC_Msg)PPSMC_HasDisplay, NULL) == 0) ?  0 : -EINVAL;
@@ -4560,6 +4561,11 @@ smu7_check_smc_update_required_for_display_configuration(struct pp_hwmgr *hwmgr)
 	if (data->display_timing.vrefresh != hwmgr->display_config->vrefresh)
 		is_update_required = true;
 
+	if (hwmgr->chip_id >= CHIP_POLARIS10 &&
+	    hwmgr->chip_id <= CHIP_VEGAM &&
+	    data->last_sent_vbi_timeout != data->frame_time_x2)
+		is_update_required = true;
+
 	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_PlatformCaps_SclkDeepSleep)) {
 		if (data->display_timing.min_clock_in_sr != hwmgr->display_config->min_core_set_clock_in_sr &&
 			(data->display_timing.min_clock_in_sr >= SMU7_MINIMUM_ENGINE_CLOCK ||
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
index dbcba73fd750..d9e8b386bd4d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h
@@ -336,6 +336,7 @@ struct smu7_hwmgr {
 	uint32_t                              avfs_vdroop_override_setting;
 	bool                                  apply_avfs_cks_off_voltage;
 	uint32_t                              frame_time_x2;
+	uint32_t                              last_sent_vbi_timeout;
 	uint16_t                              mem_latency_high;
 	uint16_t                              mem_latency_low;
 	uint32_t                              vr_config;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
