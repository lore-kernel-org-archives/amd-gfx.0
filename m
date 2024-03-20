Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5873C54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 538A610E7DC;
	Wed, 20 Mar 2024 06:36:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rFk27fd4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97A3510E7DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kx+fOlD7NPMCIenAvUQRyfyHF/8q0/nK8g6hmzSCHILbiMBU8xcsQyAQWzOBe82Oo5/3Zz3yNqfGDN4cKIkaFSj70yfsvnW/ZOz6J3uQFKe7NFu5bsU6aLdtN9y+5hfNhs9/rnA6DRJgKKix4OU2SfngB98lyZniQOLlfdLN9huXJ1JTUEwMmWF0rwSv9dO1O28VQ7bdj3kbBpakMwrEjTDwtuObR0agylXwlJIIBN4DREF7eiLR/oKsfZ2gHx/Yjk9tiT5ZxfHMUflqkP0QX81oAV4cuxINvSrtw2uoGdyesfyuqUti2untdkH7DqIxo+H/2IkgtsePkZA3TKTdqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnfZY4p/+cQYmp+oLOP/mYB2i64Wf5brvj4piwu0YG8=;
 b=bFyysn0oaVKPCbT7hMxlsIbaMOPiAmFuOkd3xdVCfmEexE9DBHasc3Pw97FPoEzFn3Ez8CH9UdMBLK6NQvdbc4MhlvI7ls79CEmZD0C+GO9HvetCjzHf3tsi9xsd25Lpj+8rLqu3wF458GtPajUuK1djxB1iTJxCFtlR70mhBcokTFRaiV1IAqI1pmhv+eRFVvFoxxRUv+B4HFP4E+4He8mzKV3oI0QWne8/R4mvyhSDrHOzi2eUSn6d0HXwhDO4y4IRf31Piz0u5gduZjwYXvITmVKtv/IX55Q48XsSvFIe9LF0bj4rC4f+oVO8Chez7lW0Dr89SCWU8dbCYR1aHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnfZY4p/+cQYmp+oLOP/mYB2i64Wf5brvj4piwu0YG8=;
 b=rFk27fd4k60+cmtZWgpGopyoCDkTklbWM+r+LhDrB71uiososSnYsOagA3WhqIBBGM2bMdSKTLzhxKwec16lBFleGVoNnIXtOQaBByfd1oFzT6U+VJpq4kedjpceqN4yWQGm+D574UfmHi+QP1lwg+0TFAs3i2KZuy+srYAXKHI=
Received: from BLAPR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:36e::19)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 06:36:11 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::d3) by BLAPR05CA0010.outlook.office365.com
 (2603:10b6:208:36e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Wed, 20 Mar 2024 06:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:36:11 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:36:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 23:36:10 -0700
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:36:07 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Samson Tam <samson.tam@amd.com>
Subject: [PATCH 01/22] drm/amd/display: Allow idle opts for no flip case on
 PSR panel
Date: Wed, 20 Mar 2024 14:35:35 +0800
Message-ID: <20240320063556.1326615-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: bf242a05-1cc9-4cde-0313-08dc48a8088d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUtGx3uCjHzzKgl1pNiSbjOmu7P9HFwcH81F5HK1K84OQ+sovbYovwX8hXzNo6vDJjw0FE8EoRTz0GvKxD0/+mIaGpO8zmilA/YuOkxuR1fSLv6BGwoCsvKfQ3Ll5jr4mXOZaAZbUXKNmOYFzXBEBc0z1EhewiUbcfK2JXUW+ugl6LcVZ/SaSVB0vQWNhhYwbDaVhTNOw16HtmjO8cinrgiofaKsO/fTrn4xzko3jYCl9y8CT3H6MbQcxVx/2M/Fg6o8QCf3H4o6cMpv3+t5+yvplQohOyK/Xy973uYIcOgeqkTdwdvM6tHkXYGRqjP7HEGOLpVCmAss/swT8wD06BscBMLTZPsOr6evQIkFYCFLz8uK9X5dR08eomk6Wj8QQSaDigqFN9DcxIYgsZ7bUZI6kInPM8oK8WEeHcPAyvZ2IIp1l4Rhg+c40GzhA9KoF8GedC6C8LUfSy4W812W2mVCQOWUe0/8B/CklfwkQRdgxuBTSRnH8bri2/3r92IevzecTHzqSVeOoKj/jizvlcE9rVvBA4c5qC3EDwliuAiCvPaFAiZeYEHIAfCn14qnBI5BSfs4gByshHaDF1QhidMdErm1Dwcyt8ZxZW/EpN6ooWeMeNnxiiBgOxVEGOnIz0FHGHOT18OiZxpPCF0ONr7VwDW8ajmeYM7JSRWrGTxpzmxt7xwDMO5prJlq5u/3WtbzXmcq3BXXKqbKwS2PQbUy8shrt9zX6tXfuZl/ok4PHKAmeRJKE2mQznA4yH3r
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:36:11.4463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf242a05-1cc9-4cde-0313-08dc48a8088d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
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

From: Alvin Lee <alvin.lee2@amd.com>

[Why & How]
There is a corner case where a single PSR panel
fails to enter idle optimizations if the panel
is not flipping (no planes or DPMS_OFF == true).
This is because the panel will not enter PSR if it's
not flipping, but this will prevent the FW idle opt
path from being executed. To handle this case we will
allow entry to idle opt from driver side even when a
PSR panel is connected under the following scenarios:
	1. Only a single PSR panel is connected
	2. PSR panel is not flipping

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index c0b526cf1786..a5e92389615f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -261,7 +261,9 @@ bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable)
 	for (i = 0; i < dc->current_state->stream_count; i++) {
 		/* MALL SS messaging is not supported with PSR at this time */
 		if (dc->current_state->streams[i] != NULL &&
-				dc->current_state->streams[i]->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED)
+				dc->current_state->streams[i]->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED &&
+				(dc->current_state->stream_count > 1 || (!dc->current_state->streams[i]->dpms_off &&
+						dc->current_state->stream_status[i].plane_count > 0)))
 			return false;
 	}
 
-- 
2.34.1

