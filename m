Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14B5C27C5E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 418F110EB14;
	Thu,  6 Jun 2024 21:59:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XdtcYU1T";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B9910EB13
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rc5Pfs/ug04KtnGkydP9e0HZhgI4grRXEoLHACXEZCGlmo5Lc43k6Yo6J1kYtbSWXmy8AxU+f0dCAbQr8iiJOkeeqarv9lKc5mpjM+JIehVPqKliuWrJ05/EGrlHPzO/uXuAneMzKuMwiY+LY4QdYH+cDTni4NUVrcwXHU1+qCp6yxdART/HB361t+CcIASMR0ZHwwcG84bfTeQLr2v0ARn9PPHLAv95DH0WeiTlYI3YexXmJjaeXQuxu8Hit/f+dyakl4cnpVfcUesvDMz+fr8RgDLfUAYiEjyP0+9nC6nMlP2lF9xEg1yXWF3dW/F9xMiVYZisF3Qgr/VBLtmtvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTD6yO5MDVPl38UIbZdwIEl7Co+/kq6fSyCtMlubSPE=;
 b=PsAmCXr22gAUwUHeT2l+SA2cyap2hqvXXlW7ILuHMMgzX5/tiN2FFx+N6jFQHZvtf9hJ2A8jRAh6z331eqqOr7/ZJZQ5rY3NxJyqV09cgfGakqS7lAY56qDBk5P4HTX2je0YskC+pcPH9zi3j8C4lxElJn+UnEmSSq3gW0NGGXER6sOs8Pm8O0aMq3zDY1YdCchTr6pV+pamw3pc9zW3vu8LONQb1Ogfma0NnqJ/pQGwDT6qX840ETLCiz37VRZjNdVzxGzNEB+loFdE5V/R2TU6OgLweUJ8osemTDKzMScOq3cFEk/LX/VHtzAJk3FzvVx7nbjd+lwpQNBjXfisbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTD6yO5MDVPl38UIbZdwIEl7Co+/kq6fSyCtMlubSPE=;
 b=XdtcYU1TbqLSXLnQH+EQsAmmqTVXsYqrYLS9kDuc803oq11pmtWxdsEfh7RqD7XgAhSkLVVDon39Nube9LTdBYb2IARQGWsXgRrTOqiwKVQI80J3iDCEBqkRooINEr/x9IZvzL2M3/ilbotNmjk1QPf+44UYP5BymBaPdbOZ6ZI=
Received: from MN2PR15CA0066.namprd15.prod.outlook.com (2603:10b6:208:237::35)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:59:11 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::3) by MN2PR15CA0066.outlook.office365.com
 (2603:10b6:208:237::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:59:11 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:59:09 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 63/67] drm/amd/display: Avoid overflow from uint32_t to uint8_t
Date: Thu, 6 Jun 2024 17:56:28 -0400
Message-ID: <20240606215632.4061204-64-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: f18babf2-e256-4138-76d0-08dc8673e593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?caDYPNotEWpmAjMyhClikW5w2RFwm91GpZd3+LWS/B3mG7XJbXltq5gKK/uw?=
 =?us-ascii?Q?V2jgSsNR+Y/72j5C5CEYLYzKyw2elN3tZgbgHeqpfP9xtYCrlBmXlN9oYxLO?=
 =?us-ascii?Q?KA9L2KJns3DTeu4ZdPw5APPz3DX4ZlmgFlAyNvI+Nv/h82XxPAV/3kO7YnMK?=
 =?us-ascii?Q?2BFdSPJ2WYmoznXku3LubsprcxitV2ctl5hfWmLYSiGeYgRiVZrBthQ+fBYV?=
 =?us-ascii?Q?3uARAZPqly1y4ZMnU89acvmRVY22QDv8eVdj7vWZHvMgIfieSLrt07rrEUA/?=
 =?us-ascii?Q?L0C0nZ7LgR6JCrmUk3ypxSDCjLELXPdYjvIOYlZC3zoKoVu025NuP4v7lh2G?=
 =?us-ascii?Q?Soa8aLNFlkCt14bgkvaMUNHTHXNBBfmYtyWppHQtgrWeX+Mslum0iBvgrQI7?=
 =?us-ascii?Q?s6VrGZuipr+QnFqm4dPQvza/uAVWN6eUCBcNHQScEmO40s79lJQeLl8s5LU2?=
 =?us-ascii?Q?8DOsqWYUMqBZLmv5ppeHgJu1wx6jg/C9Kxb+JEKHd+i+HgK/WDODxhN2rSKO?=
 =?us-ascii?Q?1gPG+h9VGWTA5xrzUvyui3pyaWL0du3Mr09/em0Ju3QqSFtbr68oY3dREK2L?=
 =?us-ascii?Q?NTVr6GSKg9n+0uMlcAovxYcTEQEHjSILWjwl2XlNFQlBQdlfRW6MChyGYGrT?=
 =?us-ascii?Q?f6KPJKT/c/aLVn9UZEnoi88H508bfxAyDR1Eum+rnfNYxNVfgdj9cVbbp5B0?=
 =?us-ascii?Q?PraDWJdiPmltHaV1CHSv4ZpPDkt/T8YNFdaGm5nu8B+0UjCWSK5s3E61ajGJ?=
 =?us-ascii?Q?FEcRRtDfrFyi+BzlJF7DR0V4h0fF7uj9Mjtfipaiob1NDnAUbv+JPcO8O37p?=
 =?us-ascii?Q?Oggy/vidEghAO5730GvRtQrm9GWUcr1tAqqV6PW6hLcQC+X4HVvYrOSaRn4Q?=
 =?us-ascii?Q?EAv8XiM6tbAMdV09eX3U6NofjGZNqHEONfjWjs6SlZ62a0S1wSdqsxwPBcOK?=
 =?us-ascii?Q?Jv5Uz8m3y/kBkoVPg/7fQp24zAkiH9cktov3AtA95rsxESLOe0Y0XhK197yG?=
 =?us-ascii?Q?dVPlvw8hmwUQGlkhkCYL5dpym/hpzVLeE+UJk8pHP7eqVPnPBtoBram0uab3?=
 =?us-ascii?Q?RjZhrdZri9cYguz6LTE4+dYmqQwF9qEYrIY97aCGp0W1UwFla8lmJjP0FqIU?=
 =?us-ascii?Q?FVyg7ctsAULqjmoKCguEamiKKqmHfcOvmm9v+rOnT3ZeNQ203rA6FESsO3kW?=
 =?us-ascii?Q?K9pNe7pn8D06d6LIMKDY7+nBxsys3qQoQBPJDAL8YhHNvlYF75xr7QWqmG6x?=
 =?us-ascii?Q?nHBhjS768MuywOXaAM2FxgLtbqybNQqs01aBIHBL6ieikx3aQAVL5RW6OZ7F?=
 =?us-ascii?Q?8yn+/afnWWyQCQshmS6CgsnEVNySGlR53MCYRl5hdpXAZu4rqNiY+jsP113h?=
 =?us-ascii?Q?rgGNY8kExtBXXWYMBpc8tiMjQF3r2miYVRCn7AvI8c63SBy+Pw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:59:11.0150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f18babf2-e256-4138-76d0-08dc8673e593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
dmub_rb_cmd's ramping_boundary has size of uint8_t and it is assigned
0xFFFF. Fix it by changing it to uint8_t with value of 0xFF.

This fixes 2 INTEGER_OVERFLOW issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c       | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
index f4987e96fbf9..0d7e7f3b81a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -258,7 +258,7 @@ bool dmub_abm_set_pipe(struct abm *abm,
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
-	uint32_t ramping_boundary = 0xFFFF;
+	uint8_t ramping_boundary = 0xFF;
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 804be977ea47..3de65a9f0e6f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -142,7 +142,7 @@ static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst,
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
-	uint32_t ramping_boundary = 0xFFFF;
+	uint8_t ramping_boundary = 0xFF;
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
-- 
2.34.1

