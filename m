Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A07FC33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94452073A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="InBBjlK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94452073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CCB36E4B0;
	Thu, 16 Jan 2020 20:22:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D6406E4B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:22:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqG7a7aCx9erX2l1APekD/AxBPUWxayQ43G7Ddp4m8ii2YydHHxC5UBdS3/aF4CIyJ3jcWsI/BebEla3Qxb5Ir7jDbGmfMFK8G/FMVeGV3tP7Ca+WCjSExRYMFw6iPsIiXgEO5Vs2P2+rarQtfmE3jL9nZFkyo7eZIX/lGFBDQ5J/T8QHHsiWZ76SJz87eK8nh8aoRNSM1OWJBoHD42BNwkXR5lPGplHnsETqimqxP9vJVDy4hsChtDu7hJ77wsNQSOoGSqSTzmWxkfh3GhKrrRtrh+qrkiJpontvye8IgLkoN8062QB339zLVEvdxLsJJiiCvOgq1YdxJ92eMbhEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSNAEQNMGVKBsalgPS/LHWK3HFA9tlLEsZczXy4BmZo=;
 b=DAAGFI/yNPJ268sqOOcffyZoIDAZuQLkDaqnN2GOb/fY7kYsRp1FNCc9496AQPeyhxarHaalm/qgAOT+f1yd6Rh8/dbFhisXCt2S0/V5MccyU7vXW/PcJRCb6lO1BOpodnHXUrMXbU5K18m5JAGz4h5xKoupZznmlRpBKQVIti1Fw3MwJ58/J5Ib9OzGRZztS9ff/2+AbnUYynVKWvqhec5eMqSgzW8FQ7rjzeo1NtM16D2HaNqjAFb3f+hTGuoI+/4+Fp4eRVnwxOvmmwXCPM0FuFwkrHNHLI8EAT8ikYcOjj5ktMtMukuigQli7Our4GwvF+Kn5IN3vauzFdin9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSNAEQNMGVKBsalgPS/LHWK3HFA9tlLEsZczXy4BmZo=;
 b=InBBjlK//jskYS/vBFnbsQcCgjnUOSABUGQtxhgieBGAi1gIvrqJl7xhR773hNON/5LaX7lqppUADLOZyHTtIjYXrtHWj+PXHj2i7yLhmaKoqtwyKYbPWHwVue2dp+FBlmspxLdIsOnmzPodB6EPi2e+dRko8d7xyFxV2oJn4TY=
Received: from DM3PR12CA0096.namprd12.prod.outlook.com (2603:10b6:0:55::16) by
 BY5PR12MB3938.namprd12.prod.outlook.com (2603:10b6:a03:1af::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Thu, 16 Jan
 2020 20:21:58 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::202) by DM3PR12CA0096.outlook.office365.com
 (2603:10b6:0:55::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Thu, 16 Jan 2020 20:21:58 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:21:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:21:40 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:21:40 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:21:40 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix HW/SW state mismatch
Date: Thu, 16 Jan 2020 15:20:46 -0500
Message-ID: <20200116202046.10991-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(39860400002)(428003)(189003)(199004)(478600001)(4326008)(8936002)(356004)(70206006)(336012)(1076003)(5660300002)(70586007)(426003)(81156014)(81166006)(2616005)(6916009)(54906003)(36756003)(2906002)(86362001)(316002)(186003)(26005)(8676002)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3938; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89418fe1-e521-4925-dca3-08d79ac1bcb9
X-MS-TrafficTypeDiagnostic: BY5PR12MB3938:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3938934586E21456160B4E6FF9360@BY5PR12MB3938.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZvUMiruW5QaOos2bfm/QeIUgXlRNcwjPyVVkcYVUckL6pUTvlAPZJH6abgXOOvBksc8eI2gyFrU6ZXvWJDPBzkc+4yybYSqGxLv6hkM/kg2Gd8eNVY43kfK3BXPh+pbNPkMQNdOhZBUyAdl7edUN3E91fri62af8JO1rmYqWiD0RYSKRBmKcdIlyCXkAqvZTVrdx+mavWUIGXM1E75EnhXksWtSWxh2V3kFjbnW9jKNf1kvPLusQmw0d7AsGNZvigrhp/8KFri8w1THnnlm57PXc+tSzSYhCmUvBuKjEYSBE+pytSmiEbd5qyuJjxWKeUmUmlXxLUSVcI0pooMWDyNLjyZ7MLiM8PBYWbmoIP5AhhtgBDIpEp9qDTV+Tu0fCt1apaTWiEkQLCVN6Kr6QsQz1R3jMz8qG7kuJOpyX2pjb71F328pqN0xEpWF4WqoE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:21:58.0916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89418fe1-e521-4925-dca3-08d79ac1bcb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3938
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, rodrigo.siqueira@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
When we disable a connector we don't explicitly remove it from the module so the
display is still cached(SW) in the hdcp_module.

SST: no issues because we can only have 1 display per link

MST: We have x displays per link, now if we disable 1 we don't remove it from the
module so the module has x display cached(SW).

If we try to enable HDCP, psp verification will fail because we are reporting x
displays while the HW only has x-1 display enabled

[How]
Check the callback for when we disable stream and call remove display.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index ae329335dfcc..0acd3409dd6c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -135,6 +135,20 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 	mutex_unlock(&hdcp_w->mutex);
 }
 
+static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
+			 unsigned int link_index,
+			 struct amdgpu_dm_connector *aconnector)
+{
+	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
+
+	mutex_lock(&hdcp_w->mutex);
+	hdcp_w->aconnector = aconnector;
+
+	mod_hdcp_remove_display(&hdcp_w->hdcp, aconnector->base.index, &hdcp_w->output);
+
+	process_output(hdcp_w);
+	mutex_unlock(&hdcp_w->mutex);
+}
 void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_index)
 {
 	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
@@ -303,6 +317,11 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	memset(link, 0, sizeof(*link));
 
 	display->index = aconnector->base.index;
+
+	if (config->dpms_off) {
+		hdcp_remove_display(hdcp_work, link_index, aconnector);
+		return;
+	}
 	display->state = MOD_HDCP_DISPLAY_ACTIVE;
 
 	if (aconnector->dc_sink != NULL)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
