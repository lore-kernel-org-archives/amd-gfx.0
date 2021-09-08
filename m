Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C58C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBBE560E77
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CBBE560E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5FED6E1ED;
	Wed,  8 Sep 2021 14:55:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E87E06E1ED
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkiKO1tmBiLNQ/FRAr47kc4EE2LhzPAc+mposmRCvSOq+gdz44znMHOj37vfgp3gZufReI8iBkvWfZWuY6EdvDH/8Rb3L+dMcLLGzgIQaUGwR0E/vmVdeXpCR5igM/gqVA58E2lhzXYHyUb296n8IdWXl7zAgEch9mGZfjCfWFkb7LXrlSibYsYUW8SdlOvAwr7i3n6Eg+VLG7FdaJmq5zZbgI2DhK1Y6pZFLkX6sfdjCkO7iQr+z3FnZiUmPKs9JYNa3asae0jkV2GXnm2hcw7k8d67knheIoundWX2kSrDG8wtCqOZbRkEoDhqFCFl3aNgWbxWad6mFvU3mm3+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=L8TtfGPJc0pW9D0XIFaAlH7x6ZSnSVdl3E6vheAR4mw=;
 b=hv6P6Ibx4Sr6/NgNGeaItKMzdDnnN9H63hR0kQifjMe3PSi2E10tnz15cQu/k9rHZsClWgVVDDVl/bblMCglS3x6ia4kE2VVWRrbSHOY34339IA6VHV47tfyJRegClf6hCc0+XnPxmE8Rz2u/00FJBphb0t5Igf/YJ53/Pqu9jSoFk1aJdoCA3D3SMtPLTyGr+WeEmcEEQwS9UOFyEzbTJPJb8FdtMzHB/MspDrUeGfglRm7y9TvV+omoIndKfqQTNzyhMrlBxXQDUVcBqDAxJelKyjKPRfrKHc0R8deShogWm0haVEjl/dMUDdDxN0TDDTo1hJ8HBzortGatbV9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8TtfGPJc0pW9D0XIFaAlH7x6ZSnSVdl3E6vheAR4mw=;
 b=gusboioLJQXGnudafEolmmyrdE23DtGjspxIqtnt0K7Py9Rlf+8C+jpauAhoOEbRlBAIu0b+9xmV7ikWbYXTBS7CBqcZgeyNCye9NpEWM9tRnrYW5+l4CXZ2MJeSBCo7F3xhi970oxUXCTOWE35BNfPs4eGWmBJ92d7GJxNYJII=
Received: from BN9P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::21)
 by MW2PR12MB2364.namprd12.prod.outlook.com (2603:10b6:907:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 14:55:10 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::61) by BN9P220CA0016.outlook.office365.com
 (2603:10b6:408:13e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend
 Transport; Wed, 8 Sep 2021 14:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:55:10 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:55:08 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Bhawanpreet Lakha
 <bhawanpreet.lakha@amd.com>
Subject: [PATCH 28/33] drm/amd/display: Fix unstable HPCP compliance on Chrome
 Barcelo
Date: Wed, 8 Sep 2021 10:54:19 -0400
Message-ID: <20210908145424.3311-29-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33dcfb76-de5b-4512-a6ef-08d972d8a7c1
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:
X-Microsoft-Antispam-PRVS: <MW2PR12MB236459788888D6F23B2EDD15E4D49@MW2PR12MB2364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QHm9ovYl5ZKfMy3vZHfhHy9gAsx6DYpHxCEFH40tcgfBhRosXfxpLJq5VqcHmjOD+4eFH4/jSXGVMc0SfoeegxeHrhmFtwQ8f7Wxs2vgXBCrOd1QIHftEL+rgCxCcQtV+5Hrh4PmaWNgfX8Jl0ROg/2w3KlNPDnKTBlufy+hLOhVk5PdGBFXIC+Ltw4wwGiWw6unlyVjmPBsnB+qc8jCrfhrHzckQn261qgrBkVu2oWKSRvxLu+6bwEW6yzNzflPzAnecrI9HKtSirRYADXVM2skfPh2RwaybRBxRMe4qAHeB7/gwttUHIcTcOlXfhInTfjcy+QZc6v8QjpPV9QGVt5hBdo3a/vPCyEjXBhaJuVGfZr50ORD77w09J847cbhfWJFr1hO90zGoJdYIW/7EITCCeEL4/81qAb04ZtAMhGwwWgEnfcw+znfpgyaLfH4an4FFC5fkLbt5M5p4zK922xJrvRfwIsj//9LPueMiUqVjn9LXGB4Xhygd9hmQX256+LLjphq0y4UgE9ur1dl3Nb0LdneiSqSicVfExtR8C08Rp4XyYPW1i9I5Z9qvNMjIT77MxWCrmPuabjtyTOStFTRmTPreJWNXzijLbcjnIQfumjQf07KrCtyJJeM0c078nL0eDR3RtMWGIFff5nQR9lf+CyjDh25nZ6uhfWQSWdbSI5yrDuj6xaSzxxAfIYnCTkEzQiAsY2YPwDF1i8acNODWPhSFSH/Zarv2ILgvUM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(2906002)(16526019)(316002)(47076005)(6666004)(2616005)(426003)(5660300002)(8676002)(336012)(186003)(8936002)(82740400003)(478600001)(356005)(81166007)(36756003)(4326008)(70206006)(36860700001)(86362001)(6916009)(1076003)(26005)(83380400001)(70586007)(54906003)(44832011)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:55:10.2194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dcfb76-de5b-4512-a6ef-08d972d8a7c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
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

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
Intermittently, there presents two occurrences of 0 stream
commits in a single HPD event. Current HDCP sequence does
not consider such scenerio, and will thus disable HDCP.

[How]
Add condition check to include stream remove and re-enable
case for HDCP enable.

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 87499ef5282c..0753bbb3bfc3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8363,8 +8363,26 @@ static bool is_content_protection_different(struct drm_connector_state *state,
 	    state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED)
 		state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
 
-	/* Check if something is connected/enabled, otherwise we start hdcp but nothing is connected/enabled
-	 * hot-plug, headless s3, dpms
+	/* Stream removed and re-enabled
+	 *
+	 * Can sometimes overlap with the HPD case,
+	 * thus set update_hdcp to false to avoid
+	 * setting HDCP multiple times.
+	 *
+	 * Handles:	DESIRED -> DESIRED (Special case)
+	 */
+	if (!(old_state->crtc && old_state->crtc->enabled) &&
+		state->crtc && state->crtc->enabled &&
+		connector->state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
+		dm_con_state->update_hdcp = false;
+		return true;
+	}
+
+	/* Hot-plug, headless s3, dpms
+	 *
+	 * Only start HDCP if the display is connected/enabled.
+	 * update_hdcp flag will be set to false until the next
+	 * HPD comes in.
 	 *
 	 * Handles:	DESIRED -> DESIRED (Special case)
 	 */
-- 
2.25.1

