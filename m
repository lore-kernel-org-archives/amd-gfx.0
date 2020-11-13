Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B42C55ABD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9672224D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l0JevXJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9672224D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 336936E842;
	Fri, 13 Nov 2020 20:58:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE7BC6E843
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmnY+upBN8APua2g0lJ2l8CAHpSTnGzttXynjx9MVc7SoQNFtMzqctcPGQTEqGTHn6dL1TCT4Fy4PYsTMafmLzknLJgCg8e5AwjleCFS+qPAgM6Wc6SgjsLXuIEhhUtpbd0tR6A0ODFkZNZEwGYE3a9g7NL66WFUW+AZ1gvyybWB2yr0ToIrHDlW0ES6guNvK9c9vWObzqhaJIgTYiFEKWbQeFhui2t2IFNKaMsBbfM4lkQnIOVlSFKje6Op5QdTQNI2PKNQWf2MED4rys4/tgdEVTzy1EiwyqT03jZFqOAPVTZhwi/w5X+5W07jm5j4sD8pSkmmhoy7Tsd1/Rgg/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7sURCLQelx/Jb8GD8b3HwDeKLEuV2OOawp2TKfepwk=;
 b=OdfmPpGkoP7OB0A491k/Bvvdg8uVFxI7j/znjJhe4MVd5HQcuYw2+qYA6Q3VAmS+wY90JyRbue9yBJ1naX6qYkXDzKRi0KCuLKyg/x2xWqMLb/duyJsIEVXykCGkc04V0haxOyyXIjNxnipuYm+1n1nO2OBfNtm2Gnu7czouJTKenMyvPmo9/DtKd2NOFsTYJDNFlsVCW2kRQ18R0rMBXFmV3Ndb6yYeHtKqHAdFYYT0aLKURjx0O5YPcn96SE8UWilTa8bMPNsFdZ9G+xMLcumtLa5PCf0ilMrt5cQJR1LYzFzMFeY7lzbs4A+2Mfte9pV7VVVZZTr52AFgzeg5XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7sURCLQelx/Jb8GD8b3HwDeKLEuV2OOawp2TKfepwk=;
 b=l0JevXJwLmObLv/2nRT2jGXYzu5sg/HDQg/324G9ol3hR93dBbnlpJqAJbUhM0j24cRrh87JVorqBShIpdJrfc5uQzyScU1wamjlX735fNDfuA3gyy156bUl7R1rND/E4Fqzb8MMoE7752u7d5QBzDXxUMXpEcYPhM5lxlqzCB8=
Received: from MWHPR10CA0062.namprd10.prod.outlook.com (2603:10b6:300:2c::24)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 20:58:07 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:2c:cafe::94) by MWHPR10CA0062.outlook.office365.com
 (2603:10b6:300:2c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 20:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:58:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:05 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:05 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 13 Nov 2020 14:58:04 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/17] drm/amd/display: Add dual edp optimization flag.
Date: Fri, 13 Nov 2020 15:56:39 -0500
Message-ID: <20201113205645.640981-12-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113205645.640981-1-bindu.r@amd.com>
References: <20201113205645.640981-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 359ab95a-75f5-477c-7ece-08d88816d22d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3211:
X-Microsoft-Antispam-PRVS: <DM6PR12MB32113243AE16AF80D1767070F5E60@DM6PR12MB3211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bl+B+SRHcBDgo9NO4wGp3ZOYWw5F1MHLer4UR63r6GSkoP9agRTF9svd52IqTk+LjNeK6Kb5Ao0Ff3ZH3Notgq7YyS2bV1CLlT+F1/6nl/T0NIi8PU20hzvnlJgtRhzvaFYssWXVuVh1UHnJpcBwSrSI9ms45TeyF6sUpJme5Uwd6LOcRuEYIh3WkTnen6vF3SR+0qBQXbAmdOy0oj6ooiPo2ruc8rBcL7KMxQ80q7YZ7pv2gC7giqzHY4VaV8xkAMtwDuTvCMJkWitzR6IlBnzftywN/N65YLBx3bT4mEsinKBTVzK0GqjZA/Jk7/m18G79fdVtrMA7cNNXzWv0hYLijhqxG1lxSI/Iz/SYJbGj9S3I+rJkljxv/wc39oRWZ4Zha83+dnJkBb64WUlpsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966005)(70206006)(86362001)(70586007)(47076004)(316002)(2616005)(6666004)(336012)(83380400001)(1076003)(4326008)(82740400003)(478600001)(8676002)(8936002)(426003)(54906003)(186003)(7696005)(356005)(81166007)(5660300002)(36756003)(26005)(82310400003)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:58:06.8111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 359ab95a-75f5-477c-7ece-08d88816d22d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3211
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
Add a dual edp power optimization flag, so driver will
notify this flag to dmub FW to determine if apply the
power optimization.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h       | 2 ++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c   | 1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 3 ++-
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 165fd2f3c80b..f522b664d3c6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2757,6 +2757,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 	 *  (Always set for DAL2, did not check ASIC)
 	 */
 	psr_context->allow_smu_optimizations = psr_config->allow_smu_optimizations;
+	psr_context->allow_multi_disp_optimizations = psr_config->allow_multi_disp_optimizations;
 
 	/* Complete PSR entry before aborting to prevent intermittent
 	 * freezes on certain eDPs
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 86406b42572c..80757a0ea7c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -697,6 +697,7 @@ struct psr_config {
 	bool psr_frame_capture_indication_req;
 	unsigned int psr_sdp_transmit_line_num_deadline;
 	bool allow_smu_optimizations;
+	bool allow_multi_disp_optimizations;
 };
 
 union dmcu_psr_level {
@@ -799,6 +800,7 @@ struct psr_context {
 	 */
 	unsigned int frame_delay;
 	bool allow_smu_optimizations;
+	bool allow_multi_disp_optimizations;
 };
 
 struct colorspace_transform {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 0d6fe7c29c20..17e84f34ceba 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -261,6 +261,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	// Misc
 	copy_settings_data->psr_level				= psr_context->psr_level.u32all;
 	copy_settings_data->smu_optimizations_en		= psr_context->allow_smu_optimizations;
+	copy_settings_data->multi_disp_optimizations_en	= psr_context->allow_multi_disp_optimizations;
 	copy_settings_data->frame_delay				= psr_context->frame_delay;
 	copy_settings_data->frame_cap_ind			= psr_context->psrFrameCaptureIndicationReq;
 	copy_settings_data->init_sdp_deadline			= psr_context->sdpTransmitLineNumDeadline;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b0d1347d13f0..9e6a4b4f2f1f 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -612,7 +612,8 @@ struct dmub_cmd_psr_copy_settings_data {
 	uint8_t smu_optimizations_en;
 	uint8_t frame_delay;
 	uint8_t frame_cap_ind;
-	uint8_t pad[3];
+	uint8_t pad[2];
+	uint8_t multi_disp_optimizations_en;
 	uint16_t init_sdp_deadline;
 	uint16_t pad2;
 };
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
