Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C81CD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D4D310E86E;
	Wed, 10 Jun 2026 09:48:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L6eZ6nFj";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011006.outbound.protection.outlook.com
 [40.93.194.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C9D710E86E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:48:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJNZZ9Or+ugy9Wii44vJd9FAriwERRkKmAGtnU3UOPUIqo+9mDfZ6vMooQxImP65LI2pONU+WJ7mSDHOS9eSlsuNAriYqP499TSGKPW719GCbb0gLmhTd/vy10mvQTj4ZJZEb/MOI1AYEUXhcwJEcuO3oHZDojpcVHFO1pTlgevKvQf29x/CgjpJykN4RS1FymzDCE1/h77Tpp7wf/wCYvOrlIQd3Z28JC1FWF4h8fCEMBf5tCKGWyzKHhwb78B72ZyfmD6kPDfNYyWqyVpC8YYJv85+ylo8hR2LCur8hR6R3GNOo2qfVE7yI6LqsCGQHHJoyndKMoSX8+LDBJ3lRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRrgzP4znrMnEld7ZUpfdScbdNgks3D5Ko8Mo8zGf2I=;
 b=aOIvt+pbepijZahVImDhEwc8cJ3vqBV/Ca+fSSSJAN2UozhZ4BUkaCIbfpLSSJfYDdt2NnVJqTlsNg3AxARBZpdWBbc3QnDSbkmrDBabKs08p0WK92UG8ohJfTwRU1FRJv5CzInhiGtONBbdPEnin1Ux2YOV8dekHoEhSlsKMU0LjNPATn/krH2DwSutvZeZlNmnuxE+1QX99eHOEIBKqvY8AOp1AEDR9xqCnApMOqOcMtbBsuVS1L6omiGsGX+SERpN3i5n9/MxYeddEcA225VESSiWL5Ubnt0hAvxlf0Qwe7j354TyBDLH+L52MKfhO38w+KXD0nEVrU9FbnKyPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRrgzP4znrMnEld7ZUpfdScbdNgks3D5Ko8Mo8zGf2I=;
 b=L6eZ6nFjjw9hlij6ynBTLCmms4+4zEhgweYgCBYjpFyhMs57RRYk4puTEmwbX8vcp7zMIUZ7a8kkxHDz9TxhaawyBCI4Gnr+ZDPwsrbtpqwCg34b/uyano7BfCWyicJSVuwzsR6p49qme+RZ3SfuUdqbIMFqXBSLnhJnz238pII=
Received: from BY3PR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:217::8)
 by SA1PR12MB999227.namprd12.prod.outlook.com (2603:10b6:806:4de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:48:34 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::54) by BY3PR04CA0003.outlook.office365.com
 (2603:10b6:a03:217::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 09:48:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:48:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:48:33 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 02:48:32 -0700
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:48:24 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 04/32] drm/amd/display: Remove get_utm_qos_model from
 soc_and_ip_translator
Date: Wed, 10 Jun 2026 17:44:48 +0800
Message-ID: <20260610094639.1965367-5-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|SA1PR12MB999227:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f889dcc-547f-44d7-2195-08dec6d56fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|22082099003|3023799007|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: CTQU22anRw1AnyFCE6hESD6AoSxiZ80v/NFSzWP2N0APKQ9Tw1QZ5NhfbVA6EEyGe5ZyrBf3pFrOliudOgWpAgwLxPbDZe95iAxhj1+1r8SJMsXZuDxHHtZInNEtIjdTNMv4NjH4saDB6/My/VEEMlYgJgpNth+8QFhnY0jQ8oIsmHVq/N59TOraUYNk9EzasSLlYMrkqjSUvNTrPhSRVpdkcrYYirhHCM+AW5arjlGwpF4c/1XR7lUWqX/d3ReTxze9h15ZGMOWI8xh22s3i8AnHX7YtPbHSHc/2lH4IVRDiYLR7m0JEYOaW6PGDpL7JhfdRbVKH/fdkBWpmva5LQh7lyI1sBgGuL+OogcUHgko1aLYkXHNk0ctBA9qDMnpGSb71MotQ1C+jauqMbg5fDsTmFYdXMOnsKFrB9XzL1d4MONMFHSfco5OPfBuoL2hDR1kw4tqPP+Dn0EYEPPA7yeDgOY4Ay1DY2Qp4v3KWH/JNL5u4fYd+WF7g2wTPQIFl3mdvewefLteDoZ1jPPD9TRpmoppmanlhWx/fBm4irfT+3Pal/m1o0pzK4yg1WD8PtroYktq5gSCEZSEwOBcHe+ZzUYxTzQpXuI43QIycBi+cSqingTACf+2XrUUei2JMXAGtOydggdfmG2LlHRBOrqZoUEOpJa+aJgw4K7wo50VKMffhb2dXNEQ29znsaKM8wrylLsW4/oJAaXyqX43CZCQQQSyTsfaLU3AUv1MDi4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(3023799007)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6nbosseSi+2Nzlaw642WoEIS83t5pPQzCTe8y8MIMJ9qUy1cHf2ezOzq2w2KptzQCJ+Hp2TR8JCmdCwU168jgaD0h5rA3yMfmiUr68GN7a62N/swM3IHyl3iIbR8qts4W0ClJth1YvGg4rPV+Mjv3g47vUn0l83BGwW1MbEVULhCd4pyyURo2ObCqzEzhOB9TM6mo1qHtLR9H4iDH3y2QXaki3TVsz+kS/4AInKz4dSrMhTmD4aMUINcJ5uFTJOmwgYFZSB6Et0AAR7vX2P4wDKXg7Xh2pian9tetT6Da+XLxI+aEGIwK+bJlwpQV0xybaBH0SZhlM63tNxi7Q3FzkvMSgFYDg5Tajafb8BfJ/9jEAhXFRNrn/6X8hApUCXWA4V5/p6/O/nrwhURrB1DsxPDYv0mINQrsE3GbY7PCEwauC54LFD5cxy+v3SiaRpE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:48:33.5723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f889dcc-547f-44d7-2195-08dec6d56fa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999227
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

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
The QoS model is now populated directly in clock manager
from firmware data. The translator function pointer is no
longer needed.

[How]
- Remove get_utm_qos_model function pointer from
  soc_and_ip_translator_funcs
- Remove associated forward declarations from
  soc_and_ip_translator.h

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/dc/inc/soc_and_ip_translator.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h b/drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h
index 6a97a3e28bd2..5dcb9f8f4daf 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h
@@ -8,26 +8,12 @@
 #include "dc.h"
 #include "dml_top_soc_parameter_types.h"
 
-/* Forward declarations — callers that dereference these structs must include
- * the full UTM model headers themselves. */
-struct utm_qos_model;
-struct utm_qos_model_dchub_v2;
-
 struct soc_and_ip_translator_funcs {
 	void (*get_soc_bb)(
 			struct dml2_soc_bb *soc_bb,
 			const struct dc *dc,
 			const struct dml2_configuration_options *config);
 	void (*get_ip_caps)(struct dml2_ip_capabilities *dml_ip_caps);
-	/**
-	 * get_utm_qos_model - Return the static UTM QoS model for this DCN
-	 *     generation. Caller provides storage for @qos_model and @dchub.
-	 * @qos_model: output — populated with SoC bounding box and SOP table
-	 * @dchub: output — populated with DCHUB client extension data
-	 */
-	void (*get_utm_qos_model)(
-			struct utm_qos_model *qos_model,
-			struct utm_qos_model_dchub_v2 *dchub);
 };
 
 struct soc_and_ip_translator {
-- 
2.43.0

