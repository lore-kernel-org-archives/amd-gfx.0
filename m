Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DC3C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5413A610A5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5413A610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB8A66E9FC;
	Mon,  4 Oct 2021 14:41:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B8166E9FC
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdxaYnlnOtvp8UL01Tl/A4ob5wbDHCg4jkOHQVWq/s75kb/3bbXehSbW2SCb2nc+13JwRn4WcncrJa8yrLffmsra4fmV3WwlpLFDIG5/frCaKRfzEIcOQvnyGkNxbXwhqEEpji2NwW58JGRfsng7xwL0MiBffNCKYLXKqA0XxYcBhMF5jRk052pHuRp0sCjYhO/TY1n9jIPGrMDheKtm7XSNKLCZGQLswBHutmK5S/DKK8OjP/lkOKwawjjZ3BGG4IaR3JTwtuZKR9JYOJZ7A8dPEj4PTs1sqytfYmQ4qfWC887hnZ2biJRMQR59YnX+PkQ/EQ/IJv2yy1jDIsOYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRTLcB1UEfULRsMT4huKC0nkKbDoLekwlc9wnNxc1jE=;
 b=ZDPjd4POkDF1sNoOm92A8iqDycN1L18yeKGzfMnqJGekZo+kqLREBcVV6iym2+m81j0S2esQ8JxI9J5iXSYREiwFpWC3qenX4QIIy+XfNUG/YwyvbIyQ7udWjQH3kZQRMw4yezQlUdmFKTT9ghAYC9m/xUPJ0m+gKQ3M/FoHnkEghvG5reZqNcopfZd64dDak2V0zQddElGcKpXql4T//GbZioohR5GM5/iZH6UsJVp14WOnVy2ybtrK30vpKYxBeD3VLFw9cMjkgJ1SR6x7y9GP8Sjbe/e4ewlOgmvWPGqH0geQpabv35HlTRASJWc2mt4B8O9Xh1AekbFpyw+rbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRTLcB1UEfULRsMT4huKC0nkKbDoLekwlc9wnNxc1jE=;
 b=XRyg1FD5SUHsT/vVGOLqt39zXKCu0TKz0Lt+uvzeJtD1luqiueR5K7XR7PT29BKU4fxM4uWYbn7WAv8SIDpXdUEkhaQuKPh3pLlAicq5oSNqd4Mc8idac/ZhZdHqWH9M6+nDQmFnL1tjVgBV8wjFsX7ICelRSEYpVuDzDg3ixxo=
Received: from BN9PR03CA0325.namprd03.prod.outlook.com (2603:10b6:408:112::30)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Mon, 4 Oct
 2021 14:41:44 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::37) by BN9PR03CA0325.outlook.office365.com
 (2603:10b6:408:112::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Mon, 4 Oct 2021 14:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:41:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:41:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:41:43 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:41:35 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jun Lei
 <Jun.Lei@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 03/23] drm/amd/display: Support for DMUB HPD and HPD RX
 interrupt handling
Date: Mon, 4 Oct 2021 22:40:30 +0800
Message-ID: <20211004144050.3425351-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ade4c33-4cba-40ca-c08f-08d9874515f5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4107:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4107C47D17FD79581AA5C7FFFCAE9@DM6PR12MB4107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NiWY3Fa+Vxbpv4Io4jlc17ULFJPxq9A2GDaNk+DsPkzL7+b8/vNl7WMS5x2lpBoI7o6Q3QNlpFY4xmkMYbRXZmLAcqNNcMMnbbGtYZmM3w2PPLrFnFHoOt1xcfh0ldJ04VdnuGxczF3sr9ksv7fHF8USRLZ0h3V41MQyQLRSEsRTc+0M/r1lnvKlRBbHkA7se+3F9sXPJBup1KHYu8XPaYjxMCtR3NJJ5gtnSooq0wrZWq/PmyNF+LrIUEc+JdWzIWVpg9pnzr9ALs0rjI4dxJo8oTGwM6ISOkMwMuq3B7mrJcY9V9NHnf1sVtVpTAYeriHyEpempHfn8LtiJ14ckzzwu9I/xTGgpsG6ge6cbQNmUZZ8AXDLw2apDhXVrqXzSsfSsGkfC+w27vej8NJe7nyWXsaqMXGtyHZCfxQfrU/UYVzmiA1xr2Al/+D2ypPyx34gYus0Uihgy1KGIaW132jxfitm9GhgbQ7ToJkueyezeI7UHro9F2Z6+N3Nd7kf0uNkRWh4ps62sQyKqx1m+F5bhHoWVuNbt6GO5RkGBkjSM9qQxNhoqJfuM4TYNVt2CPwK0WcRgfBy95R/D7GB/B5FZC0T0yYhX4aLvEGpvkGdfYxVfAUSbT9dQWqQLJLValUFuLQITWIAMIVZBWuqoZm4B/Fq7n+Y+VAYuxMIJZ6ljvqyjaTD9dpDSQtJN9amOSpFVyP/g/c89DAUxPBERCm8avT8zDb4Px9Yesgdz0o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(86362001)(356005)(81166007)(47076005)(26005)(83380400001)(54906003)(508600001)(316002)(2616005)(4326008)(186003)(2906002)(336012)(36756003)(82310400003)(7696005)(5660300002)(70586007)(36860700001)(8676002)(70206006)(1076003)(6666004)(6916009)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:41:44.0126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ade4c33-4cba-40ca-c08f-08d9874515f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[WHY]
To add support for HPD & HPD RX interrupt handling for USB4 DPIA in
YELLOW_CARP_B0. USB4 DPIA HPD & HPD RX interrupts are issued from DMUB to
driver as a outbox1 message.

[HOW]
1) Created get_link_index_from_dpia_port_index() to retrieve link index
   from dpia port index for HPD & HPD RX dmub notifications.
2) Added DMUB HPD & HPD RX handling in dmub_srv_stat_get_notification().

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 20 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c |  7 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 ++++
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  | 11 ++++++++++
 5 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f4bb8ea4e83a..6cdf68ca9048 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3658,6 +3658,26 @@ bool dc_process_dmub_aux_transfer_async(struct dc *dc,
 	return true;
 }
 
+uint8_t get_link_index_from_dpia_port_index(const struct dc *dc,
+					    uint8_t dpia_port_index)
+{
+	uint8_t index, link_index = 0xFF;
+
+	for (index = 0; index < dc->link_count; index++) {
+		/* ddc_hw_inst has dpia port index for dpia links
+		 * and ddc instance for legacy links
+		 */
+		if (!dc->links[index]->ddc->ddc_pin) {
+			if (dc->links[index]->ddc_hw_inst == dpia_port_index) {
+				link_index = index;
+				break;
+			}
+		}
+	}
+	ASSERT(link_index != 0xFF);
+	return link_index;
+}
+
 /**
  * dc_disable_accelerated_mode - disable accelerated mode
  * @dc: dc structure
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
index 28ef9760fa34..7d4a5dc8fc91 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
@@ -61,6 +61,13 @@ void dc_stat_get_dmub_notification(const struct dc *dc, struct dmub_notification
 
 	status = dmub_srv_stat_get_notification(dmub, notify);
 	ASSERT(status == DMUB_STATUS_OK);
+
+	/* For HPD/HPD RX, convert dpia port index into link index */
+	if (notify->type == DMUB_NOTIFICATION_HPD ||
+	    notify->type == DMUB_NOTIFICATION_HPD_IRQ) {
+		notify->link_index =
+			get_link_index_from_dpia_port_index(dc, notify->link_index);
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 204bab6f82ef..d51c7b000eb9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1395,6 +1395,9 @@ bool dc_process_dmub_aux_transfer_async(struct dc *dc,
 				uint32_t link_index,
 				struct aux_payload *payload);
 
+/* Get dc link index from dpia port index */
+uint8_t get_link_index_from_dpia_port_index(const struct dc *dc,
+				uint8_t dpia_port_index);
 /*******************************************************************************
  * DSC Interfaces
  ******************************************************************************/
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 42956dd398f3..a693b743f0d4 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -676,6 +676,10 @@ enum dmub_out_cmd_type {
 	 * Command type used for DP AUX Reply data notification
 	 */
 	DMUB_OUT_CMD__DP_AUX_REPLY = 1,
+	/**
+	 * Command type used for DP HPD event notification
+	 */
+	DMUB_OUT_CMD__DP_HPD_NOTIFY = 2,
 };
 
 #pragma pack(push, 1)
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
index 70766d534c9c..d7f66e5285c0 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
@@ -76,6 +76,17 @@ enum dmub_status dmub_srv_stat_get_notification(struct dmub_srv *dmub,
 		dmub_memcpy((void *)&notify->aux_reply,
 			(void *)&cmd.dp_aux_reply.reply_data, sizeof(struct aux_reply_data));
 		break;
+	case DMUB_OUT_CMD__DP_HPD_NOTIFY:
+		if (cmd.dp_hpd_notify.hpd_data.hpd_type == DP_HPD) {
+			notify->type = DMUB_NOTIFICATION_HPD;
+			notify->hpd_status = cmd.dp_hpd_notify.hpd_data.hpd_status;
+		} else {
+			notify->type = DMUB_NOTIFICATION_HPD_IRQ;
+		}
+
+		notify->link_index = cmd.dp_hpd_notify.hpd_data.instance;
+		notify->result = AUX_RET_SUCCESS;
+		break;
 	default:
 		notify->type = DMUB_NOTIFICATION_NO_DATA;
 		break;
-- 
2.25.1

