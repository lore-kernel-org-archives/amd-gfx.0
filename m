Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850A7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E57CE10E6D5;
	Fri, 17 Dec 2021 21:24:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19A1A10E6A2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVJga9GlPC9SjDbG4JMjRBZ4jf500pztyf+y+bNNBElJe86+BAtp0OIUUCNSn7kkztdkPStLO9dAZagTjDE1qWuz7nUV3UutTdYRrwM/U9MX7sNTITdktBrvYmtAmEb5TZp3DNafR9+QMMql4GPlqiDSlHQmXj5Gvlh5HqtaxvKzQ8JPggha0B1sYn892AhL04RoKVXBQcVEMKJA1a2NCQGWhASwyEgnyJ72+UWOTc66mFbK9AE8/Mp8VQdOeqEOhMxcZvvkXWW/9KYf7JiBygm/BG2P7WWH8RY+33UpN2m/6/vtEUC07ze5hnlYX080M1NNiYFoYqNEaXmITofRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSesR51XM4a0Xg4ziJRV+lhkIGVeTrEE8t77OB/4qHI=;
 b=cMGjYCuViUOv+NyQf1F8+i/lWcxnXTxvYw3Fz9QIjqA7GyDzLW5vvbn+QukaAJRhcODUQGZ2smmKJlRsgn1JSg9H7bm72m1Js8zZa3MxgiO8OhcwoH1F1ij/jXm7mxO/8SVjl7stfUBzvnqNriE5h64ZihHcxUXJ8Up75sIuiCWyJT6jo5Aab6Xb3JOqYOj5m3PTsj/+apPDmLSsGVhl+pKTOpa8vPOZ61l4aVqu552r7E06hjyU6LHLB8TTbFe/fGeRHG7/9GyP2V2XOfeg65Ssmm6eGYQU6/H/kjmuih1216mqx5jzMQR6w5CJS7MjwDjH4kY9Sw178GEdfbcj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSesR51XM4a0Xg4ziJRV+lhkIGVeTrEE8t77OB/4qHI=;
 b=N6WkqXgfyp4uVKIdfsa5t/j9soNp+qZJLQ9zAKPWvVS02e4nCFSACjkFYzaOASX/V9vQJIegZ1VELsEukW4z/6JrzEbHcME+SNrCQhUJ1oCvRNkb1zqpP+6GtJ5p1hKMKPswfy/X7u0NrgW8Mjbg8ER0diFlpkUKV0tX+iURxac=
Received: from CO2PR06CA0053.namprd06.prod.outlook.com (2603:10b6:104:3::11)
 by MW2PR12MB2490.namprd12.prod.outlook.com (2603:10b6:907:9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Fri, 17 Dec
 2021 21:24:47 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::1a) by CO2PR06CA0053.outlook.office365.com
 (2603:10b6:104:3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:47 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:43 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/19] drm/amd/display: get and restore link res map
Date: Fri, 17 Dec 2021 16:24:07 -0500
Message-ID: <20211217212407.3583190-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24d3c3ee-9e9f-43d7-adf3-08d9c1a3a6f9
X-MS-TrafficTypeDiagnostic: MW2PR12MB2490:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2490DD84B055B4562A8B9F1998789@MW2PR12MB2490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: izZ600vTUvAQmzrPGv4lvSVr4JqY7D3DF1qYt4NpJa1XdVX4mjI0YR6swqRAoczx5q9HTUS+LrfB7KePRFquneyBhdrOYivbv6cYkWsQKNAGZzJLdvSFJgaT+raWWNJMdECOQdIiAopJ/msZeAUgPAe3h/HugtikscM4FIdBmJNnOxVR7IYVxQapjisqhTb6ESI+lQdo4hwZjFGG+VK98ogGc09lg9DXWu8jLId8/TGTLMUTqSzU4JyQRqlimO36SIflg8j5j1ik66g5xU8co3RvnE9djnqyFxUctCH0okFQpUT1vfmqIiP11GNCvadd5o0DwK8vVpzq/N5+l1QsAgyLGKbKSGWMBlpvB6skADPMQW1/v6GQbrYmzdNypwIspbmoESbOFfb/kVwBor8jgYirH9KuF+jhbUHqQbT8b1a8Hcpvu8Js7v6fEiibUmJy/n8yusUkVkCl7V43SJ3H+Zdx76Hroz0k0Vr/90IZtF9jJGI7MWod26LXcds25LO2nMDPO85jlaQ/q9vflmAPgz5z+3nyv/0NnR0dUUWR4MzpujX8NnpNox8+xzBQvrI+vRvENe6xXWR1Kx/mJh/yFD0zvK7kZZLfJ33c1jfGv22/xW4NscNLxLpa+CiDT/8V7UocMtD5R25VewfSE9gKURfyvfrcp9q0Lqq9XYeghzBLPoo1EkN74jU2eYrv2/p4oGVzu4Vk7y/2iXK0birfFEm2pA/RxGWOh0si0FxVok0jHeVa4tVah//poSOoXEkoQBFYz41Xkzm04r+eMBka3NBw88o9KreA2PZZs+bsYD4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(40460700001)(82310400004)(8676002)(86362001)(5660300002)(186003)(83380400001)(6916009)(336012)(2616005)(54906003)(2906002)(316002)(508600001)(36756003)(1076003)(426003)(36860700001)(47076005)(8936002)(6666004)(26005)(70586007)(4326008)(70206006)(356005)(81166007)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:47.3244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d3c3ee-9e9f-43d7-adf3-08d9c1a3a6f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2490
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
When reboot the link res map should be persisted.  So during boot up,
driver will look at the map to determine which link should take priority
to use certain link res.  This is to ensure that link res remains
unshuffled after a reboot.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 103 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   4 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   5 +
 3 files changed, 112 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c5d3e2417ef6..ee3c1c9eac4a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4890,3 +4890,106 @@ const struct link_resource *dc_link_get_cur_link_res(const struct dc_link *link)
 
 	return link_res;
 }
+
+/**
+ * dc_get_cur_link_res_map() - take a snapshot of current link resource allocation state
+ * @dc: pointer to dc of the dm calling this
+ * @map: a dc link resource snapshot defined internally to dc.
+ *
+ * DM needs to capture a snapshot of current link resource allocation mapping
+ * and store it in its persistent storage.
+ *
+ * Some of the link resource is using first come first serve policy.
+ * The allocation mapping depends on original hotplug order. This information
+ * is lost after driver is loaded next time. The snapshot is used in order to
+ * restore link resource to its previous state so user will get consistent
+ * link capability allocation across reboot.
+ *
+ * Return: none (void function)
+ *
+ */
+void dc_get_cur_link_res_map(const struct dc *dc, uint32_t *map)
+{
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	struct dc_link *link;
+	uint8_t i;
+	uint32_t hpo_dp_recycle_map = 0;
+
+	*map = 0;
+
+	if (dc->caps.dp_hpo) {
+		for (i = 0; i < dc->caps.max_links; i++) {
+			link = dc->links[i];
+			if (link->link_status.link_active &&
+					dp_get_link_encoding_format(&link->reported_link_cap) == DP_128b_132b_ENCODING &&
+					dp_get_link_encoding_format(&link->cur_link_settings) != DP_128b_132b_ENCODING)
+				/* hpo dp link encoder is considered as recycled, when RX reports 128b/132b encoding capability
+				 * but current link doesn't use it.
+				 */
+				hpo_dp_recycle_map |= (1 << i);
+		}
+		*map |= (hpo_dp_recycle_map << LINK_RES_HPO_DP_REC_MAP__SHIFT);
+	}
+#endif
+}
+
+/**
+ * dc_restore_link_res_map() - restore link resource allocation state from a snapshot
+ * @dc: pointer to dc of the dm calling this
+ * @map: a dc link resource snapshot defined internally to dc.
+ *
+ * DM needs to call this function after initial link detection on boot and
+ * before first commit streams to restore link resource allocation state
+ * from previous boot session.
+ *
+ * Some of the link resource is using first come first serve policy.
+ * The allocation mapping depends on original hotplug order. This information
+ * is lost after driver is loaded next time. The snapshot is used in order to
+ * restore link resource to its previous state so user will get consistent
+ * link capability allocation across reboot.
+ *
+ * Return: none (void function)
+ *
+ */
+void dc_restore_link_res_map(const struct dc *dc, uint32_t *map)
+{
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	struct dc_link *link;
+	uint8_t i;
+	unsigned int available_hpo_dp_count;
+	uint32_t hpo_dp_recycle_map = (*map & LINK_RES_HPO_DP_REC_MAP__MASK)
+			>> LINK_RES_HPO_DP_REC_MAP__SHIFT;
+
+	if (dc->caps.dp_hpo) {
+		available_hpo_dp_count = dc->res_pool->hpo_dp_link_enc_count;
+		/* remove excess 128b/132b encoding support for not recycled links */
+		for (i = 0; i < dc->caps.max_links; i++) {
+			if ((hpo_dp_recycle_map & (1 << i)) == 0) {
+				link = dc->links[i];
+				if (link->type != dc_connection_none &&
+						dp_get_link_encoding_format(&link->verified_link_cap) == DP_128b_132b_ENCODING) {
+					if (available_hpo_dp_count > 0)
+						available_hpo_dp_count--;
+					else
+						/* remove 128b/132b encoding capability by limiting verified link rate to HBR3 */
+						link->verified_link_cap.link_rate = LINK_RATE_HIGH3;
+				}
+			}
+		}
+		/* remove excess 128b/132b encoding support for recycled links */
+		for (i = 0; i < dc->caps.max_links; i++) {
+			if ((hpo_dp_recycle_map & (1 << i)) != 0) {
+				link = dc->links[i];
+				if (link->type != dc_connection_none &&
+						dp_get_link_encoding_format(&link->verified_link_cap) == DP_128b_132b_ENCODING) {
+					if (available_hpo_dp_count > 0)
+						available_hpo_dp_count--;
+					else
+						/* remove 128b/132b encoding capability by limiting verified link rate to HBR3 */
+						link->verified_link_cap.link_rate = LINK_RATE_HIGH3;
+				}
+			}
+		}
+	}
+#endif
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index a6b8327936da..c0e37ad0e26c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -459,4 +459,8 @@ enum dp_link_encoding dc_link_dp_mst_decide_link_encoding_format(const struct dc
 #endif
 
 const struct link_resource *dc_link_get_cur_link_res(const struct dc_link *link);
+/* take a snapshot of current link resource allocation state */
+void dc_get_cur_link_res_map(const struct dc *dc, uint32_t *map);
+/* restore link resource allocation state from a snapshot */
+void dc_restore_link_res_map(const struct dc *dc, uint32_t *map);
 #endif /* DC_LINK_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 08f1222fdd26..943240e2809e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -334,6 +334,11 @@ struct plane_resource {
 	struct dcn_fe_bandwidth bw;
 };
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+#define LINK_RES_HPO_DP_REC_MAP__MASK 0xFFFF
+#define LINK_RES_HPO_DP_REC_MAP__SHIFT 0
+#endif
+
 /* all mappable hardware resources used to enable a link */
 struct link_resource {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-- 
2.25.1

