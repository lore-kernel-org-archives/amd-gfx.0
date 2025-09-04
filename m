Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5A8CA1012
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 11:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84C4910E9B4;
	Thu,  4 Sep 2025 11:23:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nTCgBbGa";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3482210E9B4
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 11:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiNSrPn5gG+bqmksc68isL7jLMcwcHpjLsRXe+xDdVMFu6D/Jj7gXFwX+K4jmjamAmjy19yx5ngZ7oG2so9DqD+O+9mbZfJmZykWwpdc15nzbpjiHC1AX7YrDGYoZL4x9LBirssPUjoKlmax+BR6ysG/uJt8aAYcgHylFovkuKhdENIyg7fO3fxVPuKFt44KRZoitAN0/T5p6b+SDzlJ1+mZ9OKB8yNdDGHZBqrMJWV/T/XpHYrmSs8v4gZC7SM3mKC84PSAa0EgnsQdHHe/4ddRhvubKz4wFT2l3lIPAuM/kuyw/wvL71dGYNwpqFv4hMQtMNtfLbeHu5VuTo+WMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnHm8rB4h3wCp7r1ObOAp5+Mbw5EVvIcdYIASL9oURg=;
 b=O62Jgz6JO/A6qZerXoE9g5T3MooCNWG2TcwjP5pjO+fH4xEZ/jQDRWNXhWq/35rEJyhWDhuFe3nn900t4PAv5z5y7cjnca3OOXGNqgM3iqbL2haI1s5Wc3WdeGivysV/Ft00c9BVDhzptlj4/mXhQq7x+W/Uxrw33/b03XBYO1plZAt/4h0BZr+85pTDj64zUkVRAuWhIztJnmaILuLQVTX/F/9Rzw+TFWRehGt8YIvExiJZkRX03ivshl3WP9pqWXwrIcCFdNNrHOvTTLj4u/3Xwy4+iC/98uc7VTzfu0FuEgX62azCvK7VPf5f7thmmYHtjcIvb6IMWAArcsASxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnHm8rB4h3wCp7r1ObOAp5+Mbw5EVvIcdYIASL9oURg=;
 b=nTCgBbGaXJm4xDjyCbCU7fT5uUKIpgFtnu87kM6Jtg/vQCNzFvnS0IxL1kaJD8Rv4HTs8wMFHsc/E8hHVkSfvxmZsnbeksaWr1JLgENXZorswKrk/600sR6iSyi+9pvh8HpY6hFaQL0LxWCot0ccosiTxZQFm7ELA26TWf4srKU=
Received: from CH0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:b0::27)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 11:23:05 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::c1) by CH0PR03CA0022.outlook.office365.com
 (2603:10b6:610:b0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Thu,
 4 Sep 2025 11:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 4 Sep 2025 11:23:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 06:23:04 -0500
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 4 Sep 2025 04:23:02 -0700
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>, 
 Wu David <davidwu2@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu/jpeg: Move parse_cs to amdgpu_jpeg.c
Date: Thu, 4 Sep 2025 16:52:04 +0530
Message-ID: <20250904112204.3817975-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e8e0bb-ed7e-499b-ace2-08ddeba56aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTZUNmsvZDdjL1BVNnVnV3hCc3NTZm5EcXplS0lGM1FKRVVLdjlBWUV3b3Y0?=
 =?utf-8?B?amY1U3NKQ2YvVWFiamdRMmNzaTNoSkJWM1FvVHVtcmZvZ1V3dUFxTVF2QVlm?=
 =?utf-8?B?R0NkQnBxbDZWODBUWE1LVEtCK2d1Qjl4R28zczRiL0FneUEyK0QxcjJISFRi?=
 =?utf-8?B?V3Qrc0hsMWFoMXJoVUtzUzZEamttK2ZDL1JEd2ZGdDYyMG9vdmgwKzdnTFBq?=
 =?utf-8?B?S1ZCeWpZcUFGbjlxNG1sWGx1YkthMlozV2o3ZCtlOURxSjlSMlZPSTdOL3Fj?=
 =?utf-8?B?NGQ0alBjL1EyY2loZFZmQVh0bmZVWmxHS3BPeW9TNkFiNGdFWVhyTmlYdXdI?=
 =?utf-8?B?c3Q1ZncwR3BXVWtOaUlFSHVEeDhQOW1IRnU4QTZydCtESHlPY3hjRXBObERk?=
 =?utf-8?B?Z1JsQW5uVW1ud2o4MUJUQ09HdGxpdlJCZnhlZytCaHdvUnBORWJFSldTaytB?=
 =?utf-8?B?YytiejkzSHplU0o5ZzZYd2xXNERwZUQxY3FaNDkyYWY2aUtKSC9XWFpSWFU0?=
 =?utf-8?B?bkplOFJlOHp3eVRLSXBqV2U1dHZtU1lMZ2ZPVGNQSW1rQUlqMENiUmxNVERt?=
 =?utf-8?B?UUo5clpjUmhZSmZQOEFRclBUTGdHcUpZeTNrY3ZCTVkxdktVZDFCSlVzTW5w?=
 =?utf-8?B?WXJmNmJXVUIzd213cDVVN0ErSnRxL3BTdlNCNHhTd3hZUmt1b3BhMVpmV1pt?=
 =?utf-8?B?SkF6VjE4MW9MYlB5RVFkdUtONStlNW0wRmcvM3BKS0c5TlU0ZzBWM2pwNXVl?=
 =?utf-8?B?aW5ZcDFQdnZBNE9ZRVJrVU5lOC9PQ0F5V0lqbExaR0ZDb2FhSW5aR1paZklS?=
 =?utf-8?B?TzdSaEN0d2oxZWM1QU53S2pmbEtoa1Ewak9CVXovNmIzZEN3Y0lBWXkvcllM?=
 =?utf-8?B?S1RybFQ0cDdOYWdvWXR0eTBlamhMSXQ3N2V2eG1aQncrY0NFZVZpMUFOd1lZ?=
 =?utf-8?B?dDUvTHROZDM1UXdEQXlwVU9UdlViUCtRc05pb09oZ0RoM3FwOFpYSTlROS9m?=
 =?utf-8?B?dENwUmFpdzFPQStCZzlKdjQ0bmpxMkIvVHVreVlYL1ZvRGFDeTdMZkQ1VkI2?=
 =?utf-8?B?eFJqOER6UEdVTHRxWDN1QXJ3Rnh5c2xockRZTDBZU2J6bWhwR0RHUlpwZFRv?=
 =?utf-8?B?elJyRE5reUpJcHptZzlvZFRoUHlQanNBUG9ZLzgwZ0JwRWo4eURTTGhqcnYw?=
 =?utf-8?B?cFI4Y1k4SXVob016aGtzWUk5bzkxU0NaY3Z1ZnI2NWY2NmV1QXFZMHFWQzB1?=
 =?utf-8?B?empFbmdoeU5JSXpDdmpIdlVSQzNmWExlUWpZZkxDSkhsaU9pRDhQc2FhZW1C?=
 =?utf-8?B?Q0tmT2lpc2paMzE3Nk5zYXpTSzdTS0tNb2tldlNwWDkxQ044d1YvdXRxV2lP?=
 =?utf-8?B?aURjbDNVaTVqQlUzaUs0REw5OTBISURDd3pqU25rc0NYWEFEcTNtbnNQR2pw?=
 =?utf-8?B?Wm1uVUpPcXlvUWJTL1FiamZmSFhnQjdvRlg2cG5UTmNITyt0QnF2clNuRDFU?=
 =?utf-8?B?UndjNXdUcUh4cmlOOXdtKzFCVGljL1FWMHV3aHZQaXNqT0F5dFhURkl0MnRY?=
 =?utf-8?B?L2trNnNVWVlSdXhFMWNFZUNZbEZjcE1wTVlPZHVIb0lOKyt5L0ZMOTZWVTh5?=
 =?utf-8?B?ditFNmhDbk5waHVBZnV5NURIMFUrdXF5MHlTdWlzRjl5NGxYblMxVE9id2JT?=
 =?utf-8?B?WDM4aXpqenM5ZlUxTXdvYk5yRFZ1R252TVFPWDh5V0V2SUR4OHlTYnZqRkw0?=
 =?utf-8?B?QXdUa2tqY2xkSEc2YndrMFI2WWx0TWYvenhERG1Gd0ttN2JGcWJWKzc5RVZB?=
 =?utf-8?B?N0tWZjZCTTZyYlJ1QlNDNGNZd0FoajRpa0NNWUN1Mkl4MUxvS3hudUdWYVNM?=
 =?utf-8?B?N0dMeUtsWVdOUGg0QjVLN1dDYmtWQkxYZE0xUVczdUVhSGlwaWFCaEJzSTl6?=
 =?utf-8?B?eTRIT2dBNzhlSWszUlBqN250OXB3RzZmckZjZlRzcFZhL2N6cTBSdXNsOCtl?=
 =?utf-8?B?NE8xL2dCcDlydld0dzZqNEw0MmpERW90Mkl2Y0FldktqYkdrL2lVOEJDcGVi?=
 =?utf-8?Q?wT+Dyq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 11:23:05.2088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e8e0bb-ed7e-499b-ace2-08ddeba56aee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
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

Rename jpeg_v2_dec_ring_parse_cs to amdgpu_jpeg_dec_parse_cs
and move it to amdgpu_jpeg.c as it is shared among jpeg versions.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 65 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h | 10 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 58 +--------------------
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h   |  6 ---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 10 files changed, 83 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index f0d7e2487237..e7b4b768f7d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -539,3 +539,68 @@ void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_pri
 			drm_printf(p, "\nInactive Instance:JPEG%d\n", i);
 	}
 }
+
+static inline bool amdgpu_jpeg_reg_valid(u32 reg)
+{
+	if (reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END ||
+	    (reg >= JPEG_ATOMIC_RANGE_START && reg <= JPEG_ATOMIC_RANGE_END))
+		return false;
+	else
+		return true;
+}
+
+/**
+ * amdgpu_jpeg_dec_parse_cs - command submission parser
+ *
+ * @parser: Command submission parser context
+ * @job: the job to parse
+ * @ib: the IB to parse
+ *
+ * Parse the command stream, return -EINVAL for invalid packet,
+ * 0 otherwise
+ */
+
+int amdgpu_jpeg_dec_parse_cs(struct amdgpu_cs_parser *parser,
+			      struct amdgpu_job *job,
+			      struct amdgpu_ib *ib)
+{
+	u32 i, reg, res, cond, type;
+	struct amdgpu_device *adev = parser->adev;
+
+	for (i = 0; i < ib->length_dw ; i += 2) {
+		reg  = CP_PACKETJ_GET_REG(ib->ptr[i]);
+		res  = CP_PACKETJ_GET_RES(ib->ptr[i]);
+		cond = CP_PACKETJ_GET_COND(ib->ptr[i]);
+		type = CP_PACKETJ_GET_TYPE(ib->ptr[i]);
+
+		if (res) /* only support 0 at the moment */
+			return -EINVAL;
+
+		switch (type) {
+		case PACKETJ_TYPE0:
+			if (cond != PACKETJ_CONDITION_CHECK0 ||
+			    !amdgpu_jpeg_reg_valid(reg)) {
+				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+				return -EINVAL;
+			}
+			break;
+		case PACKETJ_TYPE3:
+			if (cond != PACKETJ_CONDITION_CHECK3 ||
+			    !amdgpu_jpeg_reg_valid(reg)) {
+				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+				return -EINVAL;
+			}
+			break;
+		case PACKETJ_TYPE6:
+			if (ib->ptr[i] == CP_PACKETJ_NOP)
+				continue;
+			dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+			return -EINVAL;
+		default:
+			dev_err(adev->dev, "Unknown packet type %d !\n", type);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 4f0775e39b54..346ae0ab09d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -25,11 +25,18 @@
 #define __AMDGPU_JPEG_H__
 
 #include "amdgpu_ras.h"
+#include "amdgpu_cs.h"
 
 #define AMDGPU_MAX_JPEG_INSTANCES	4
 #define AMDGPU_MAX_JPEG_RINGS           10
 #define AMDGPU_MAX_JPEG_RINGS_4_0_3     8
 
+#define JPEG_REG_RANGE_START            0x4000
+#define JPEG_REG_RANGE_END              0x41c2
+#define JPEG_ATOMIC_RANGE_START         0x4120
+#define JPEG_ATOMIC_RANGE_END           0x412A
+
+
 #define AMDGPU_JPEG_HARVEST_JPEG0 (1 << 0)
 #define AMDGPU_JPEG_HARVEST_JPEG1 (1 << 1)
 
@@ -170,5 +177,8 @@ int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
 			       const struct amdgpu_hwip_reg_entry *reg, u32 count);
 void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block);
 void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
+int amdgpu_jpeg_dec_parse_cs(struct amdgpu_cs_parser *parser,
+			     struct amdgpu_job *job,
+			     struct amdgpu_ib *ib);
 
 #endif /*__AMDGPU_JPEG_H__*/
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 58239c405fda..27c76bd424cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -23,7 +23,6 @@
 
 #include "amdgpu.h"
 #include "amdgpu_jpeg.h"
-#include "amdgpu_cs.h"
 #include "amdgpu_pm.h"
 #include "soc15.h"
 #include "soc15d.h"
@@ -806,7 +805,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v2_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_0_dec_ring_set_wptr,
-	.parse_cs = jpeg_v2_dec_ring_parse_cs,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
@@ -854,58 +853,3 @@ const struct amdgpu_ip_block_version jpeg_v2_0_ip_block = {
 		.rev = 0,
 		.funcs = &jpeg_v2_0_ip_funcs,
 };
-
-/**
- * jpeg_v2_dec_ring_parse_cs - command submission parser
- *
- * @parser: Command submission parser context
- * @job: the job to parse
- * @ib: the IB to parse
- *
- * Parse the command stream, return -EINVAL for invalid packet,
- * 0 otherwise
- */
-int jpeg_v2_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
-			      struct amdgpu_job *job,
-			      struct amdgpu_ib *ib)
-{
-	u32 i, reg, res, cond, type;
-	struct amdgpu_device *adev = parser->adev;
-
-	for (i = 0; i < ib->length_dw ; i += 2) {
-		reg  = CP_PACKETJ_GET_REG(ib->ptr[i]);
-		res  = CP_PACKETJ_GET_RES(ib->ptr[i]);
-		cond = CP_PACKETJ_GET_COND(ib->ptr[i]);
-		type = CP_PACKETJ_GET_TYPE(ib->ptr[i]);
-
-		if (res) /* only support 0 at the moment */
-			return -EINVAL;
-
-		switch (type) {
-		case PACKETJ_TYPE0:
-			if (cond != PACKETJ_CONDITION_CHECK0 || reg < JPEG_REG_RANGE_START ||
-			    reg > JPEG_REG_RANGE_END) {
-				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
-				return -EINVAL;
-			}
-			break;
-		case PACKETJ_TYPE3:
-			if (cond != PACKETJ_CONDITION_CHECK3 || reg < JPEG_REG_RANGE_START ||
-			    reg > JPEG_REG_RANGE_END) {
-				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
-				return -EINVAL;
-			}
-			break;
-		case PACKETJ_TYPE6:
-			if (ib->ptr[i] == CP_PACKETJ_NOP)
-				continue;
-			dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
-			return -EINVAL;
-		default:
-			dev_err(adev->dev, "Unknown packet type %d !\n", type);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
index 63fadda7a673..654e43e83e2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
@@ -45,9 +45,6 @@
 
 #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
 
-#define JPEG_REG_RANGE_START						0x4000
-#define JPEG_REG_RANGE_END						0x41c2
-
 void jpeg_v2_0_dec_ring_insert_start(struct amdgpu_ring *ring);
 void jpeg_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring);
 void jpeg_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
@@ -60,9 +57,6 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 				unsigned vmid, uint64_t pd_addr);
 void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
 void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count);
-int jpeg_v2_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
-			      struct amdgpu_job *job,
-			      struct amdgpu_ib *ib);
 
 extern const struct amdgpu_ip_block_version jpeg_v2_0_ip_block;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 3e2c389242db..20983f126b49 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -696,7 +696,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_5_dec_ring_set_wptr,
-	.parse_cs = jpeg_v2_dec_ring_parse_cs,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
@@ -727,7 +727,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_5_dec_ring_set_wptr,
-	.parse_cs = jpeg_v2_dec_ring_parse_cs,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index a44eb2667664..d1a011c40ba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -597,7 +597,7 @@ static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v3_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v3_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v3_0_dec_ring_set_wptr,
-	.parse_cs = jpeg_v2_dec_ring_parse_cs,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index da3ee69f1a3b..33db2c1ae6cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -762,7 +762,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_dec_ring_set_wptr,
-	.parse_cs = jpeg_v2_dec_ring_parse_cs,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index a78144773fab..aae7328973d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1177,7 +1177,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_3_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_3_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_3_dec_ring_set_wptr,
-	.parse_cs = jpeg_v2_dec_ring_parse_cs,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 481d1a2dbe5a..e0fdbacbde09 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -807,7 +807,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_5_dec_ring_set_wptr,
-	.parse_cs = jpeg_v2_dec_ring_parse_cs,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index e0a71909252b..1bb09d85eb5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -683,7 +683,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v5_0_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_0_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_0_0_dec_ring_set_wptr,
-	.parse_cs = jpeg_v2_dec_ring_parse_cs,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
-- 
2.48.1

