Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D4BCF3964
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8192A10E754;
	Thu, 19 Sep 2024 18:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="275K6Hk0";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192D010E754
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:35:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKQeV/X2o8s0ey5i8iTQ94Gdfga1YAi+RjHa0Z5F3Es2Z+gaM0kMRthTkzFnGVUpZ0owmrw6lpC59WYEx7Ow9Gby+P+fVBtUl0bIxCSDZadR8vn++0rUp0LGmKORcQF5R0rcNNHgsV/WRSb/paRwcmyr9+2M5H05zYXyfZAZrIhXot0p/EsjBts+YgujZGRaRDGcGXNNwBtI/ihLfpcBJrfnagU9iI5o3kBRYF3mVCCfoif4EuCwGdqiQVfv5mcT5X3CEHRG04cwEqzxiL5Sk12lr71A7SluaqxOJnefUL720906DHyHPoJ1bClB7uGGjJABrz0lBdEPnzrQphnrDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=To/Q5u8iFFaBGqa0PAy9HdqQ9wqTL/HnAspuZDX+3Ao=;
 b=yssfkBynjdw2HJJHggvOeawRMEX4MqOZdXdu7QPMprnNcXf1mJfFhz1jOW/WsLu42baZa6O5HEBwXj2nnd851nUGz/LrL7nhAUyUpd+19ZqT/lNZVKE/irIywSAP5SMMuN4OCkQgYb2gNMSmzgc1zoiTUTZFFw8nVuZIqpLndTBObL5DEmxng9J5q+LxhMdqYW8hnBwgLdTAB+IQC6PBYWu21IRchM6jOz4n6GCHNvuVw2g8pHLTe+rA6+vxq7s4O9SuaEEJuGTLlXInyFbfPIYbrr8lKlwVkZ3lltUWpkujwd78t1jjanocs5ngQlikstE4zPagB9lXuTaJiKqOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=To/Q5u8iFFaBGqa0PAy9HdqQ9wqTL/HnAspuZDX+3Ao=;
 b=275K6Hk0vrUpW9+/s41HbDen9F773LzZn1CopMlBhpJPFnh9EFrWIE1yJMXeMN5sBp4gvwoooVN+DFeEOm0kH/WGadJFYtQFK9qQ6kZVt3pUe4a0vRqg7BHxCAEJxQ231bjIW3FJVXU+Uzved1zvh7uohjY7s64OewJaG5aUrrY=
Received: from SA9PR13CA0122.namprd13.prod.outlook.com (2603:10b6:806:27::7)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 18:34:59 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::26) by SA9PR13CA0122.outlook.office365.com
 (2603:10b6:806:27::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16 via Frontend
 Transport; Thu, 19 Sep 2024 18:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:34:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:57 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:34:56 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Michael Strauss <michael.strauss@amd.com>, "Wenjing
 Liu" <wenjing.liu@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>
Subject: [PATCH 11/21] drm/amd/display: Block UHBR Based On USB-C PD Cable ID
Date: Thu, 19 Sep 2024 14:33:29 -0400
Message-ID: <20240919183435.1896209-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b267e7-bb7b-4686-81b5-08dcd8d9c410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EqUGszxgFJYdf/X0JCCHXDHmo/orpACWGdL/54OryyZz+Mx0JBM+Fsofy6Xw?=
 =?us-ascii?Q?GC7hjPSh960kuW2nExhA3KSsbxmDuYr+Q2wBaNXZyucF8VRKyO8J4ey+Fxm6?=
 =?us-ascii?Q?oUtjUjbJJ/jKF8U4Tp2nXCicMR4pDT3yHl0Iw571cYAjKorOz0xShK8vdWZ5?=
 =?us-ascii?Q?uGi/nWtH/z82/90NOiAfnSVvW6T4a18dzhg9REf2rtZXEiMhro/IaRf8rEGA?=
 =?us-ascii?Q?teCbuQORQ9qvrZRFuMt8/efVGiETJYnEAVihmkwGJFsjn/xUu9uGtbkMBP9D?=
 =?us-ascii?Q?CMJYNVbCli5kypEQDrf79HMUBesA2BGis0pwEMG1ZKWctRR+GnouW3Q33PLp?=
 =?us-ascii?Q?A3yCMlizJ38o3qzt65EO469u//nO+luvZ8XikKjZtpW8viyWwNnjXj9jGuMq?=
 =?us-ascii?Q?1xSuxezHJC8vf4UM37wzKXh76B+tXSwfIv7o+AYwHh/BXCZsk/Q/scpHXFsd?=
 =?us-ascii?Q?lpYHRmh44ktupLVFz1PZu5xbEmbRwTqzFvKGmXkHbRvgU9lBGFldqfFGQv8t?=
 =?us-ascii?Q?yWA7SaHcDeWv0u+3HGIAci70zvysN5jSayl/qz3Pc7Pu3XsPvbKB0UH8W5Ab?=
 =?us-ascii?Q?Idt2iu6TzKHMNXrcDDSzployNPZEQf3DiJ6dxEQ+VZhGOwYBnbY+jIQroDjU?=
 =?us-ascii?Q?RXLBtwBDIgJfRSHPg3jV/IMEo6pqruFyG2hjVhYfH3/YSfxX5mnDs6pmlTXF?=
 =?us-ascii?Q?hIpO1WeuJEjecBDW35DZ/Se936XgqKGDv1hjY0x+ahdua+s6NlxQW/+j8k39?=
 =?us-ascii?Q?T63Ab0dX+F/bsyYlTeRRJ/C3VNsOUfaNPICFzwS4Q+jUD32CXLlvNNnV6P3o?=
 =?us-ascii?Q?Fr86oW6xha1lZE1po9hqg8pO1bQ5/bUVMvV0wzmtJhsgFqwuHVOfsZrBkNjv?=
 =?us-ascii?Q?D6+TUQAgNlihR4V+zJX+kQ1H9E7iF474y8SfLidW4LnzfKhcu1+cMdFQmvZb?=
 =?us-ascii?Q?Ws7Z2782jtwSZ823ujRGOMxpG25/CmwB295BDPeTnnYgtaxFABqBZ18m/k3Z?=
 =?us-ascii?Q?/67P3HI0CRn0toTy3xb/XpEx1U9OCMwP0sFX4KY7tm4MLdvIhUDBBcESOdpr?=
 =?us-ascii?Q?5V0U2aNqc/AmAvAmkC50j/Ln8vLp5geq6YkV80+lqcWnJ0msMnPA5v06l+4b?=
 =?us-ascii?Q?cnvtGDQLOi79bwLhrk+4r3TGL0XZld+7VkTirQXjmibGxaDGyFE1MGDF2ica?=
 =?us-ascii?Q?6wdD0Y7l8Fq77t3LCieZUhuMGDNMpsj+rEelkWRagYDxorDIgxpKlne9oDNz?=
 =?us-ascii?Q?8KB3XIULX9bbOZ3wJepylOs7rxG4eaUyIvAUSBOhDu2iJxOg7fqrF0m7C8KX?=
 =?us-ascii?Q?m5SxPWV7yi1zYUVweJiMehpGHNJUhcI05Sa8P/ocDS4sT/6saTqS4D+2SPeP?=
 =?us-ascii?Q?CD7dUhrhHCHYDpiemdky0ZLLPUr/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:34:58.7749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b267e7-bb7b-4686-81b5-08dcd8d9c410
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Currently the absence of UHBR cable ID caps from USB-C PD does not block UHBR
rates. In situations where DPCD reports valid UHBR capability but USB-C PD
does not, such as using a USB-C to DP1.4 dongle connected to a native DP2.1
cable, link loss and lightup failures can be seen as a result.

Additionally, in edge cases where a platform supports cable ID but DMUB
doesn't correctly return cable ID caps, driver currently also allows UHBR.

[HOW]
Block UHBR rates over DP alt mode if cable id indicates no UHBR support.
Additionally, block UHBR rates if a cable ID supported platform receives no
reply from a DMUB cable id query.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../dc/link/protocols/link_dp_capability.c    | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index d78c8ec4de79..fe4aa2c158ea 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1409,7 +1409,8 @@ static bool get_usbc_cable_id(struct dc_link *link, union dp_cable_id *cable_id)
 
 	if (!link->ctx->dmub_srv ||
 			link->ep_type != DISPLAY_ENDPOINT_PHY ||
-			link->link_enc->features.flags.bits.DP_IS_USB_C == 0)
+			link->link_enc->features.flags.bits.DP_IS_USB_C == 0 ||
+			link->link_enc->features.flags.bits.IS_DP2_CAPABLE == 0)
 		return false;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -1422,7 +1423,9 @@ static bool get_usbc_cable_id(struct dc_link *link, union dp_cable_id *cable_id)
 		cable_id->raw = cmd.cable_id.data.output_raw;
 		DC_LOG_DC("usbc_cable_id = %d.\n", cable_id->raw);
 	}
-	return cmd.cable_id.header.ret_status == 1;
+
+	ASSERT(cmd.cable_id.header.ret_status);
+	return true;
 }
 
 static void retrieve_cable_id(struct dc_link *link)
@@ -2103,6 +2106,8 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 	/* get max link encoder capability */
 	if (link_enc)
 		link_enc->funcs->get_max_link_cap(link_enc, &max_link_cap);
+	else
+		return max_link_cap;
 
 	/* Lower link settings based on sink's link cap */
 	if (link->reported_link_cap.lane_count < max_link_cap.lane_count)
@@ -2136,10 +2141,15 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 	 */
 	cable_max_link_rate = get_cable_max_link_rate(link);
 
-	if (!link->dc->debug.ignore_cable_id &&
-			cable_max_link_rate != LINK_RATE_UNKNOWN) {
-		if (cable_max_link_rate < max_link_cap.link_rate)
-			max_link_cap.link_rate = cable_max_link_rate;
+	if (!link->dc->debug.ignore_cable_id) {
+		if (cable_max_link_rate != LINK_RATE_UNKNOWN)
+			// cable max link rate known
+			max_link_cap.link_rate = MIN(max_link_cap.link_rate, cable_max_link_rate);
+		else if (link_enc->funcs->is_in_alt_mode && link_enc->funcs->is_in_alt_mode(link_enc))
+			// cable max link rate ambiguous, DP alt mode, limit to HBR3
+			max_link_cap.link_rate = MIN(max_link_cap.link_rate, LINK_RATE_HIGH3);
+		//else {}
+			// cable max link rate ambiguous, DP, do nothing
 
 		if (!link->dpcd_caps.cable_id.bits.UHBR13_5_CAPABILITY &&
 				link->dpcd_caps.cable_id.bits.CABLE_TYPE >= 2)
-- 
2.46.0

