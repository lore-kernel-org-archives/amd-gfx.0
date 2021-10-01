Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE7CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F5761507
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 14:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5F5761507
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E736ED9A;
	Fri,  1 Oct 2021 14:42:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2CE26ED9A
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 14:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWjgVYGWX4oVHnpaEuoID3qFn+SftPD1tyGZa78Q01hnp5HzKQU2OKcBTFoEtSxWor6UjIMTh9tjqD7prw+tsU/kzMyukP6tWQhhjDBotq6sRpAnvO8hWesn3co6CDzdMSKxvs5+6kvR8taXz2jjqtzTXlDTlKKZzbtt4J9VBQ0C3cZ74QT7bXGol6SSkwuO2XlBdmtuEEJ6Yd4+e2f/XpP7KrkLpekkL8wrJa7vqqhwTaKYlrwO3jIweilCUaKH+erYtIl2RtbC6Ty/KPnnc1EPiAAzg5GYPInCY5gDUhudBvK6L4P/X6oP4c3biwuQl0wwWrv/b6OhKIkMaMtVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDVcrcLAFRQpluvlIqVX6wvtJLycUDp6flXXRI2v7Ck=;
 b=Nfr59yUrQp673Ccc6DlkJSec0E9RFKEOFFrkie6KDSKX7I68ZCkIKqG8l+HWjzsd4zUHYyAziLEm7SjQUYCFcz/dj0VYbOhQLI289RfzyZk5B7/CvuuqpEz+6fbK3TwguCQpPTQ9auBqwWIH2eX2hUAN9u/H/I3RimSrnL/FBsMtQe0g/aycNiacwLSTlIFqCG2ubgvkc6Jbnn9abcrlIZYHIX0ErgmQPKxrMs4Vf/3eDhos7tg71aP9Lc2BOqwGzdRtYThJWg0r442B8Jy4O4AyhYbO6nwipIk/yLMLf6lR8BnvNDlBBt/t/WOuU5YmWkTbbh+0qDcIBlA+eMS8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDVcrcLAFRQpluvlIqVX6wvtJLycUDp6flXXRI2v7Ck=;
 b=oBNwcrNkRw+5v+7vUGHbG7s44vK1zWZg7x+JsOz+/UTYQda7bkgwYKqtxyhZ4SYgTkJSfY5G82GU5VDFLSe2f7JQuzDkqcqNUHdKHC6h6bs+ubjXR0puRR9WaDAYY6Yv+6dMNWYhr+S83LeV7VJqFwMZy7N2ohQ18yT26S5opyg=
Received: from MWHPR03CA0013.namprd03.prod.outlook.com (2603:10b6:300:117::23)
 by MN2PR12MB2976.namprd12.prod.outlook.com (2603:10b6:208:c2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Fri, 1 Oct
 2021 14:42:01 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::f5) by MWHPR03CA0013.outlook.office365.com
 (2603:10b6:300:117::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Fri, 1 Oct 2021 14:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 14:42:00 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 09:41:56 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>
Subject: [PATCH 13/14] drm/amd/display: Fix concurrent dynamic encoder
 assignment.
Date: Fri, 1 Oct 2021 22:36:19 +0800
Message-ID: <20211001143620.192679-14-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001143620.192679-1-solomon.chiu@amd.com>
References: <20211001143620.192679-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 956365f9-a3e2-475a-c00f-08d984e9a0cf
X-MS-TrafficTypeDiagnostic: MN2PR12MB2976:
X-Microsoft-Antispam-PRVS: <MN2PR12MB297648CDF36B337774EC2F3697AB9@MN2PR12MB2976.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Af9pBog5i73Nm6fwDqrb90hkXtRxT4haihMyR2WTB9g++Nb+u+eN+XrVasIwEFZIIcjXMAVKkYxT1hTOHSSyE5gW4tkhm6CoyCzjTRsZcHBIQpeDtzUTsEyULh3VKrFjO6uVRt1cOllIiE/Fi6JqLCwlW83UKReGMGUWe98rLfFsOkJMbBe08aZFPkRBTcSkqoVVBkcFkwZrK6y1F0J9RxIgEZ4PhnvBu9r5ntrpRXxWqF3hBA1M+em17hqR4EAsMGCHaOUawGPin/W6Pfi3i9Pr33Hk4+PdmkNHO+KBlHx9f81AoEf8hL9gZhSljDndbTp/686Si9xxNoqOPUY/sQbrgTVwz5yblKpy4nt3X6kbAWjxzgjMZHiEejrbT7mL6wI5ijt6N4xLePabfX3GHDySk+LeP+/HKbtglSWEgngumnIRZ6/hTksu3K4FAajkQLJyYULf8cOlwbvxiNZxOx9VM8uRytN1IQoBLjqcIDNPctzndNkugmIQ8A74DP84I/HC0LXjFyrMTX9uYE6GTOx3/fPUdwzUSWRw183TE2oYe/Zz7isCsgTNUqgeBXKkt7UtvLhdwlctyjIZs2nJ7DeXAcLAEHDtmnD0qppyYCzPh5nnqXhl9GXQ3bopwkTbAWXW6yxm21fs+wXR5fwU54gJYA4aRGty97nTsW0QDn3kPOIUxEfbN8+xIUtxWQDSP9D2Z05gnuw2CP2ivjgjAFsPi8ERPHpNmmn1eufUACs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6916009)(2906002)(83380400001)(8936002)(36756003)(82310400003)(316002)(1076003)(4326008)(54906003)(508600001)(36860700001)(44832011)(8676002)(7696005)(186003)(16526019)(47076005)(336012)(5660300002)(26005)(6666004)(86362001)(81166007)(356005)(426003)(70206006)(2616005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:42:00.7873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 956365f9-a3e2-475a-c00f-08d984e9a0cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2976
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Trying to enable multiple displays simultaneously exposed shortcomings
with the algorithm for dynamic link encoder assignment.

The main problems were:
- Assuming stream order remained constant across states would
sometimes lead to invalid DIG encoder assignment.
- Incorrect logic for deciding whether or not a DIG could support a
stream would also sometimes lead to invalid DIG encoder assignment.
- Changes in encoder assignment were wholesale while updating of the
pipe backend is incremental. This would lead to the hardware state
not matching the software state even with valid encoder assignments.

[How]

The following changes fix the identified problems.
- Use stream pointer rather than stream index to track streams across
states.
- Fix DIG compatibility check by examining the link signal type
rather than the stream signal type.
- Modify assignment algorithm to make incremental updates so software
and hardware states remain coherent.

Additionally:
- Add assertions and an encoder assignment validation
function link_enc_cfg_validate() to detect potential problems with
encoder assignment closer to their root cause.
- Reduce the frequency with which the assignment algorithm is
executed. It should not be necessary for fast state validation.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 74da226efffe..81bf1e5a64c8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1926,9 +1926,9 @@ void blank_all_dp_displays(struct dc *dc, bool hw_init)
 			}
 
 			if ((signal != SIGNAL_TYPE_EDP && status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) ||
-				(!hw_init && dc->links[i]->link_enc->funcs->is_dig_enabled(dc->links[i]->link_enc))) {
-				if (dc->links[i]->ep_type == DISPLAY_ENDPOINT_PHY &&
-						dc->links[i]->link_enc->funcs->get_dig_frontend) {
+					(!hw_init && dc->links[i]->link_enc &&
+					dc->links[i]->link_enc->funcs->is_dig_enabled(dc->links[i]->link_enc))) {
+				if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
 					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(dc->links[i]->link_enc);
 					if (fe == ENGINE_ID_UNKNOWN)
 						continue;
-- 
2.25.1

