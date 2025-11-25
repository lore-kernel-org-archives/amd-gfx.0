Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F98D0E6EC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 15:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4088310E428;
	Tue, 25 Nov 2025 15:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WfcYWJYo";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D990B10E29F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 15:08:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaUcKzD3+WV7Hc402Ii3qorgMoklfBD6SttcesuZ+yd+AnlUH2kAMUr3lHa9sy9JIw6ZWWgemUeBz/TjYiKeSgGl6XzDO+qWmMj3ktT9elELUGTKNaE1xkf2OgAUVX2tQ5kxuV3szFqJB/wZqVY1bomSGDhKcDE3PnIY+jFVofUIJ3bQyAoQl/POYmMVYQ8AiIR7YDY1ZMa9pjHW/eefzpdkhLEAfaa3Y9cykN5mwmBCUl4w3rS0h2wud5GCXekZ14LuHbzwpY9QDNBNkfXQS8t2vXf1me4CfspaIu7gbcGBKml+Pl9GS8ZqY75cfJk5/RtHIu+3Ai0F+N041LmhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8s0rJFC1H6YctA+HnfnWhVGwkVWVVSq6+aQIp5Swgg=;
 b=sRxXp+35j0R09sHCWQy5bM6SeFx6j5xuwdu9GAXdH5yfJbKBV0P1Dlw3qG7cy8hQQHswZWUBKpY/zrVUKO/6/3f9Xi5HfBs1b8j/fxnE4FaPOR2iVvHr5VC52ei3C6qYwNfPdhkMyz409sW3hgW/qUOr4GQ9A6mrlkFUwX+qgOW0BCnXja7HjVQ4z+4gkXdWG3LpDnJVUczWvMF+ZFSSl+6HrARN9fd1aIXDNZt7yeH8riVXDvTCNoCxqnYEJuyxbim4IZNpnEhZZrRlF2A3pPlTmS2yn28/1H1WI6D0YiZx1ES5Ps3ZB4uld4OJUVNFT31khUqYN4NoP9hJKAHprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8s0rJFC1H6YctA+HnfnWhVGwkVWVVSq6+aQIp5Swgg=;
 b=WfcYWJYo+ILfFcGaOam4cz8ZLTL69A1tuyDRkvYg6AI+0/cb0yPepn/waQnDIi2b1nmi491akCVzXWiAUjQjQ+6NGKIsPffeYmmRHg0iMyCOIGdAFdLHWu0dQ0uPhuFiIqBk5fjol8i7evHkcoLk70BDmotWcYljtnHucCroot8=
Received: from BN1PR10CA0004.namprd10.prod.outlook.com (2603:10b6:408:e0::9)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 15:08:31 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::9c) by BN1PR10CA0004.outlook.office365.com
 (2603:10b6:408:e0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 15:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 15:08:29 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 09:07:21 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Michael Chen <michael.chen@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd: include rrmt mode for mes_v12_1
Date: Tue, 25 Nov 2025 10:07:01 -0500
Message-ID: <20251125150708.2046375-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cd0b1c-97be-4376-5db1-08de2c347dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+dGwA3kgEtSyFLyZW0AJCB7/SZd8B73NeDv6susrwaESQUEY6YTV7pg4XkoL?=
 =?us-ascii?Q?4EkavNu2UdDAooGbbRXMxQCg1Fq/t1SGNIfcH5PS3NQ0CO9XHpk9vbusMbFJ?=
 =?us-ascii?Q?okM1f2bXku43/LDjwSkhWh7kd4vSS8CYKvWWMQsLeq5aIHqqCu2tRQ8xeLW4?=
 =?us-ascii?Q?yBGQN0rjP/USs2M9eJoaWyCpxbZGwQKsJaGVH1x67h8upr3ocJEZaHALDU6U?=
 =?us-ascii?Q?qIT2D7vHnNrGWPVXqmHAvQ7eCCyTbFhYdqVxXl4ZMi63FgHOKxDXNjcoNU0k?=
 =?us-ascii?Q?s2qXwJpeZ9pHhHEtUkUMDk+jaoAXhkRinERwmYIbLsw77kB/srOYi6RndJEm?=
 =?us-ascii?Q?YlX7O05sw0mSA/gGpbgSNk8MY7SEdcYEwH977uJhgDo0MFH2M0d/1GsEz+4G?=
 =?us-ascii?Q?toBRXolaZa9s5roti9yOef9NgZ9OAQjSl3BO2B/iKFfapCdUbYmbXe8JIoJL?=
 =?us-ascii?Q?e3LK4/42pmkyI0PxiqZq6v05307LSCw65g5wgAd2WdB8Cufm1AaZuuV5h//x?=
 =?us-ascii?Q?azUemoceQUq87xTw90oP16T+roQuxqFx5MTKNAPR1AkOfpR0SPoEkNouR/Y8?=
 =?us-ascii?Q?2L4Av55LytRKhkmFmJKFt7tBYxdWeQTxxbOJEW/ZlIXvWaIUi7gT7htxA0E3?=
 =?us-ascii?Q?qSjFocHhxMwIntYlQqSAjbaWWYnMfSzecsmzsPxcg+uYF6GFCkXT6Tr0bkaV?=
 =?us-ascii?Q?tlzE+JkUDrBfA+TjQEN7Pldk4STf3DCMK3mPsOFMTF8bgxzPP/qsORykQNvN?=
 =?us-ascii?Q?yYlfMFzzsYY7iSVMJpiVixu2MerRkvt/waCTm60B5dHZeztU34M59Thh73uF?=
 =?us-ascii?Q?H1ZQK7afBJOfRFMZUG48bbgzzTGYb7CGZFK58q/peP1rPKJtDlusvc1KUF0y?=
 =?us-ascii?Q?XLlCdVJC7ZBNdbuAxD3Xsls4MAxyT+PijQIV6vALKdsjRJGNUcTsuQlXBAuJ?=
 =?us-ascii?Q?X8vIRmeFwXJVezHxvq1afPXDjlf/jioHPsbjUgaQ3/KputF8N3FMmpLcgORG?=
 =?us-ascii?Q?OkX4OgPxnwXFeZCpQVb1mXm2Jk31uUZhXi7qCywas0dNTxASk2ab9KFlf43c?=
 =?us-ascii?Q?jCBGL3OesuFWWADfN3XVIeI9hQ0M57MQ7M/Xa3eVdbXo/T3Qwwx4iZpd4jX9?=
 =?us-ascii?Q?JCdyqX4jrSANg1ssqoTCcZtwlvkiG0m3IZiy9FHgdaXtsmcAEF8olxL3lvir?=
 =?us-ascii?Q?TAO2Fu+vePjzpx+zxDdMnxUmeciO+ITrUjnIKpLx2TVYnUS3IlRE6PHjUzQj?=
 =?us-ascii?Q?9aVROlBd0CmhXbUbn87WLFrnzGhSAoj1bfq/++UM9EWBj+97wRU3IYfMFNLt?=
 =?us-ascii?Q?suJizKwDXNvdywYd0grcSp1+eCp1Oo1KbKHP/RQHcGUkk8cd0YC6xTVSeTQx?=
 =?us-ascii?Q?86T5i2WtHn3nVVI7+BFqMSLi3YoGMaC0kQ/fH5Q9u4e0Y3fBnonVDYQAkaBX?=
 =?us-ascii?Q?yXyG7uouNG1vfhHcMqbakejl8tjK2AiWHc/g8ya1U/uUQEIbL6P8VPRrPjMQ?=
 =?us-ascii?Q?a2RQark5Bh448h8DFuhBnJdUUfSVlBb+VKNUnxbF+VkbnbCdBRJRp8xsXuzP?=
 =?us-ascii?Q?NeZzou9LnKE+uPCaRno=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:08:29.2774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cd0b1c-97be-4376-5db1-08de2c347dc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894
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

From: Alex Sierra <alex.sierra@amd.com>

Implement rrmt for misc read/write regs ops in mes_v12.
This covers LOCAL/REMOTE XCD and LOCAL/REMOTE AID.

v2: fix comments (Alex)

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Michael Chen <michael.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        | 43 +++++++++++++++++++
 drivers/gpu/drm/amd/include/mes_v12_api_def.h |  7 +++
 2 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 13269d1113730..1ec3f876f7c53 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -44,6 +44,14 @@ static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id);
 #define MES_EOP_SIZE   2048
 
 #define regCP_HQD_IB_CONTROL_MES_12_1_DEFAULT 0x100000
+#define XCC_REG_RANGE_0_LOW  0x1260     /* XCC gfxdec0 lower Bound */
+#define XCC_REG_RANGE_0_HIGH 0x3C00     /* XCC gfxdec0 upper Bound */
+#define XCC_REG_RANGE_1_LOW  0xA000     /* XCC gfxdec1 lower Bound */
+#define XCC_REG_RANGE_1_HIGH 0x10000    /* XCC gfxdec1 upper Bound */
+#define XCC_MID_MASK 0x41000000
+
+#define NORMALIZE_XCC_REG_OFFSET(offset) \
+	(offset & 0x3FFFF)
 
 static void mes_v12_1_ring_set_wptr(struct amdgpu_ring *ring)
 {
@@ -477,6 +485,31 @@ static int mes_v12_1_query_sched_status(struct amdgpu_mes *mes,
 			&mes_status_pkt, sizeof(mes_status_pkt),
 			offsetof(union MESAPI__QUERY_MES_STATUS, api_status));
 }
+static uint32_t mes_v12_1_get_xcc_from_reg(uint32_t reg_offset)
+{
+	/* Check xcc reg offset range */
+	uint32_t xcc = (reg_offset & XCC_MID_MASK) ? 4 : 0;
+	/* Each XCC has two register ranges.
+	 * These are represented in reg_offset[17:16]
+	 */
+	return ((reg_offset >> 16) & 0x3) + xcc;
+}
+
+static void mes_v12_1_get_rrmt(uint32_t reg, uint32_t xcc_id,
+				 struct RRMT_OPTION *rrmt_opt)
+{
+	uint32_t normalized_reg = NORMALIZE_XCC_REG_OFFSET(reg);
+
+	if (((normalized_reg >= XCC_REG_RANGE_0_LOW) && (normalized_reg < XCC_REG_RANGE_0_HIGH)) ||
+		((normalized_reg >= XCC_REG_RANGE_1_LOW) && (normalized_reg < XCC_REG_RANGE_1_HIGH))) {
+		rrmt_opt->xcd_die_id = mes_v12_1_get_xcc_from_reg(reg);
+		rrmt_opt->mode = (xcc_id == rrmt_opt->xcd_die_id) ?
+			 MES_RRMT_MODE_LOCAL_XCD : MES_RRMT_MODE_REMOTE_XCD;
+	}
+	else {
+		rrmt_opt->mode = MES_RRMT_MODE_LOCAL_REMOTE_AID;
+	}
+}
 
 static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 			     struct mes_misc_op_input *input)
@@ -500,11 +533,15 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.opcode = MESAPI_MISC__READ_REG;
 		misc_pkt.read_reg.reg_offset = input->read_reg.reg_offset;
 		misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
+		mes_v12_1_get_rrmt(input->read_reg.reg_offset, input->xcc_id,
+				     &misc_pkt.read_reg.rrmt_opt);
 		break;
 	case MES_MISC_OP_WRITE_REG:
 		misc_pkt.opcode = MESAPI_MISC__WRITE_REG;
 		misc_pkt.write_reg.reg_offset = input->write_reg.reg_offset;
 		misc_pkt.write_reg.reg_value = input->write_reg.reg_value;
+		mes_v12_1_get_rrmt(input->write_reg.reg_offset, input->xcc_id,
+				     &misc_pkt.write_reg.rrmt_opt);
 		break;
 	case MES_MISC_OP_WRM_REG_WAIT:
 		misc_pkt.opcode = MESAPI_MISC__WAIT_REG_MEM;
@@ -513,6 +550,8 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.wait_reg_mem.mask = input->wrm_reg.mask;
 		misc_pkt.wait_reg_mem.reg_offset1 = input->wrm_reg.reg0;
 		misc_pkt.wait_reg_mem.reg_offset2 = 0;
+		mes_v12_1_get_rrmt(input->wrm_reg.reg0, input->xcc_id,
+				     &misc_pkt.wait_reg_mem.rrmt_opt1);
 		break;
 	case MES_MISC_OP_WRM_REG_WR_WAIT:
 		misc_pkt.opcode = MESAPI_MISC__WAIT_REG_MEM;
@@ -521,6 +560,10 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.wait_reg_mem.mask = input->wrm_reg.mask;
 		misc_pkt.wait_reg_mem.reg_offset1 = input->wrm_reg.reg0;
 		misc_pkt.wait_reg_mem.reg_offset2 = input->wrm_reg.reg1;
+		mes_v12_1_get_rrmt(input->wrm_reg.reg0, input->xcc_id,
+				     &misc_pkt.wait_reg_mem.rrmt_opt1);
+		mes_v12_1_get_rrmt(input->wrm_reg.reg1, input->xcc_id,
+				     &misc_pkt.wait_reg_mem.rrmt_opt2);
 		break;
 	case MES_MISC_OP_SET_SHADER_DEBUGGER:
 		pipe = AMDGPU_MES_SCHED_PIPE;
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index 256eb7f702f66..a9bbe3070a488 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -71,6 +71,13 @@ enum MES_SCH_API_OPCODE {
 	MES_SCH_API_MAX = 0xFF
 };
 
+enum MES_RRMT_MODE {
+	MES_RRMT_MODE_LOCAL_XCD,
+	MES_RRMT_MODE_LOCAL_REMOTE_AID,
+	MES_RRMT_MODE_REMOTE_XCD,
+	MES_RRMT_MODE_REMOTE_MID
+};
+
 union MES_API_HEADER {
 	struct {
 		uint32_t type	  : 4; /* 0 - Invalid; 1 - Scheduling; 2 - TBD */
-- 
2.51.1

