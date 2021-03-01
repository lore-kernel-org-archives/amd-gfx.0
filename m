Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5341CC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 09:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3D764E04
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 09:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3D764E04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B3FE6E529;
	Mon,  1 Mar 2021 09:10:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770052.outbound.protection.outlook.com [40.107.77.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EF2F6E529
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 09:10:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0W4GEyAMNg/RvC7Kpqb9HBGGJOpPJRbhBmFY/Dkbtkk7uM278DObQEFPezkBX+JRkBbmJIcdbpmCXuNEv2b3pKSkTkagXR3XAveC5SVssk5quNY7YA9LW81T/T1A8j4mEtfSTO9lhFhk3H5JrVcG4nBDoBjXh83QLlZeZiXAbslewiwrkzHJh57GRrtTeinCUBb+Fd2PiuD+7QLIkVDCgpuJhdVuaL6zKLIUkCHjVJ8pGqKz22lfl1JP5Cp9tOJuMUOGzZcrqStpC0KK+UeLg778Zx9MGma7DrUVCWgAUGyNPbZNVfLJujEt2ZkHjQiaBAUHVLqIiC4SqvSrfnRHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KdZgVGuGbfHhm/Ie1x8H0PN+BMTaLqXhq6IcU4VSkQ=;
 b=WmrpQpGTYPZkGdIy/iv9Q3MXwEUccFCBz+ttM86twtP+V9RI1T50XA6BgrAUI7jXxvnwY4tU7v2/t4bjsR1z/v1BKA2l3Yp1bdy29uwozlKbtJnECvJ12ZgaCsR42Wue/taptXweZonVVmaRg70Nntu6pC5uEYuyFv/amO2Xp6NB/aNGH21RNC41MMWSs0Ip5lmo2dq/XohBgWbAH24gZw7wT8jY9+DUQkisEHpFFqiUNmPC9FWSdLWd96DSTrorulQuyIK1/QiAAjj3Z9ZKxl0KMG+ub8M8S9qHiVphjHZAUX2przOv2uJO6ZxA5UxFJhxBLnmrBUSv07w4fk3ubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KdZgVGuGbfHhm/Ie1x8H0PN+BMTaLqXhq6IcU4VSkQ=;
 b=4exqjxlauRDk/qGCeRW2UfcSPuVzcT9tUsazIMaX6Pfuk0OTs96H2oQShyQu9bLTfxIDxeZernAHoQBez/Z/sBALV7kyBjeIi6l62RSVhfQw+VntBDjv0Z8o/f5C500IdzZ5PseMvqvKd28rxy4ewEl1HH5+tLfYUIe4OjEo87o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3390.namprd12.prod.outlook.com (2603:10b6:208:c9::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Mon, 1 Mar
 2021 09:10:02 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 09:10:01 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: refine PSP TA firmware info print in debugfs
Date: Mon,  1 Mar 2021 17:09:50 +0800
Message-Id: <20210301090951.43956-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK0PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:203:b0::36) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-ws.amd.com (58.247.170.245) by
 HK0PR03CA0120.apcprd03.prod.outlook.com (2603:1096:203:b0::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20 via Frontend Transport; Mon, 1 Mar 2021 09:10:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 06c9ff66-ef16-4114-c013-08d8dc91cb6f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3390:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3390270826D678BE7D15130DA29A9@MN2PR12MB3390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uRkmwmVL6Lq4r/wLCMZU0RQ4yTcc2Ux9OkUFUS7thTPn0THF8PbYFVkrtGIvNLNabyY8tDfNhWuw9YYAEJp9rbDg1SnihFp/oarKSwDe+Riaa6CJmdefZY90OInXjSg+7MNgwgDrcIwEHLcKNhH+TlARITj32OPLW5eN7VuFlemrPRiVFQHVS0H2Wn5gDT9Dx9aaDpKIAMOXeB2r6LDMrjb0f8A7WNe/ZlXN+acKZN7zLLNEZ7gtnKxKar+nyLhkni646zqHQQkwmq8QcW4HVPGNukJYczilt6LdTUIFykkji9Dtb804JATpMMn8eedSe0ENWnbpDevx9T3Q2ZRIwAbqChg3nSLhJwxPifuVnmpea5ax2z6SuDq95Pcr7zfZC4UQDBIK/0leHmQne2XFQdJFvpLLRW4/pHCBSycHXNXxxlRedwfYy1yXEzWXZH8lafSAb/EElBAyIdLUlkD2GoOte2+NAZRoHS3TzK8QdA4wQO3FqpoW0YU7MtDyfQ1NwmCyt1ZwDJWQHmeVUceYmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(36756003)(26005)(66476007)(66946007)(16526019)(5660300002)(1076003)(83380400001)(186003)(8676002)(6666004)(66556008)(316002)(86362001)(6486002)(2906002)(8936002)(2616005)(956004)(6916009)(7696005)(52116002)(4326008)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bfJSTq8m9h6LwtuCH8d3R1s8kUxHo1AnkNGqRDN0GpJPM1YLp2rhw2fxucYV?=
 =?us-ascii?Q?/PJB66f93XwuPTCaaPhVPV0wTJ/yHmcjoX1RRdZXXrqB7YnQN2XTUm3MA7yV?=
 =?us-ascii?Q?JVA6EJ0uvueCbgkgGjLAPtNN7lgMirA2PVZltSCz/397uZB+1B6o4QpRfFH5?=
 =?us-ascii?Q?qdM/7LDOJLy0AWLvyXShjGoqM9CyPapXRYb5adpwtWJd4NkhqeZWsNELUNpp?=
 =?us-ascii?Q?D10OyXpNlBS49CiRYsHrKdpoNzDLDS5WF2Ox8wDLxlFu5pMQjA7x0c8J4hOC?=
 =?us-ascii?Q?GMCTI3Sq3oE+xZwiRazSiBPTBBZ8wwV9iXk8OIeAd0b4m4X42j8rMKFXqJg5?=
 =?us-ascii?Q?Xftw8hmqxTNdKcj5bL1+AuDVgU7v2jFa9woR98FlXkaybOh7qlQDroBqhDRD?=
 =?us-ascii?Q?z0xVG3jgIU4KwBMv/+F9dHRvIzb6350ryGcA6KrC283+rVBvfJ4WVSE870zx?=
 =?us-ascii?Q?MVZsCO8LwVLu7Yq2Fl0unLZwDigx3JfB0M4baxWLhDsg7bdaVX9mm8PtBi69?=
 =?us-ascii?Q?LYXY+k63IFtkSxGEekKyYaLDRhJ7yTMpo5ARIOjCNseGZnOUWCLXjK+oWbJE?=
 =?us-ascii?Q?LBspZCEaAC/uSXQyHlmTxXalEezrqFPtVBtCMTaLV9nK72OEHkPzEYWZwm/E?=
 =?us-ascii?Q?/LIsXQDOKl8zLrx/ea97zqK9g+AdROXKApnlp48a6b1ET2Ayr18iUNeH9moi?=
 =?us-ascii?Q?74ip//Y6TdlOqCLWveRMZecvjeC08m0WtxMO3WsAsyrIhuLE/Pe1KsIp6lL9?=
 =?us-ascii?Q?eLAz0ty5haEPo0TWpoJyQRIcyG9gFB+pYH+tg3qfQdYqgQfWRuG7Lsp/FQxZ?=
 =?us-ascii?Q?7cXeg5YqDpsi0gHYQO9uBD7zusUsMGsuwnC341I4PDW4PHh0Oxx2uDAdflJh?=
 =?us-ascii?Q?gko4HDw94tEkoMPCgYuaWU6FIM2nxDqmlJSEgXgtD6b235iPpkdEu1kqICa0?=
 =?us-ascii?Q?xxozqGvHmtwgm3PCPKzUH7N+XshM0Ah8TstS61L7da+DsBin2v/OLMIBqMAR?=
 =?us-ascii?Q?Qj2MWGfMZblCnvr63sYi/RYj1ap9gISGiH+s0le1L/LrLPTkYaTjbDPq9Vmi?=
 =?us-ascii?Q?CpdV3VKz+CH84iIf/OMyJY3uG+8+BAbP3yqNcCKhWtHSNpAv6Yq7XsZYFYg4?=
 =?us-ascii?Q?ffr23YWzmkanRPDIvQ28FtAvtON8+BrlQt6ED8X9PF3Uu4g1wFjLQgComF33?=
 =?us-ascii?Q?jDzC75/XV3DRssTcWYFWhpHsKW3SJ9CRRmQBmn8TkwlHdEABYMbyargKf2Cs?=
 =?us-ascii?Q?y1g3MY5XMJ9NS6Lr84LgjW2dw0NnHeINrqpMOJGwd0nw8BRCGwSRFFO2Lq9t?=
 =?us-ascii?Q?jUKzmpKddNfOicyMraoHlZ5Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c9ff66-ef16-4114-c013-08d8dc91cb6f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 09:10:01.6201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtfZb83snsCu0QYqhqqaQMm7xu8BsABxhLylRDBIHvGsfJ1AYETldp8O159CDHOm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3390
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
Cc: Kevin Wang <kevin1.wang@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

refine PSP TA firmware info print in amdgpu_firmware_info().

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   | 50 +++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  1 +
 2 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 6c8ea9d26320..1a27673271b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -289,23 +289,23 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 		break;
 	case AMDGPU_INFO_FW_TA:
 		switch (query_fw->index) {
-		case 0:
+		case TA_FW_TYPE_PSP_XGMI:
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_xgmi_ucode_version;
 			break;
-		case 1:
+		case TA_FW_TYPE_PSP_RAS:
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_ras_ucode_version;
 			break;
-		case 2:
+		case TA_FW_TYPE_PSP_HDCP:
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_hdcp_ucode_version;
 			break;
-		case 3:
+		case TA_FW_TYPE_PSP_DTM:
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_dtm_ucode_version;
 			break;
-		case 4:
+		case TA_FW_TYPE_PSP_RAP:
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_rap_ucode_version;
 			break;
@@ -1355,6 +1355,17 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 	struct atom_context *ctx = adev->mode_info.atom_context;
 	int ret, i;
 
+	static const char *ta_fw_name[TA_FW_TYPE_PSP_COUNT] = {
+#define TA_FW_NAME(type) [TA_FW_TYPE_PSP_##type] = #type
+		TA_FW_NAME(ASD),
+		TA_FW_NAME(XGMI),
+		TA_FW_NAME(RAS),
+		TA_FW_NAME(HDCP),
+		TA_FW_NAME(DTM),
+		TA_FW_NAME(RAP),
+#undef TA_FW_NAME
+	};
+
 	/* VCE */
 	query_fw.fw_type = AMDGPU_INFO_FW_VCE;
 	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
@@ -1472,35 +1483,14 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 		   fw_info.feature, fw_info.ver);
 
 	query_fw.fw_type = AMDGPU_INFO_FW_TA;
-	for (i = 0; i < 5; i++) {
+	for (i = TA_FW_TYPE_PSP_ASD; i < TA_FW_TYPE_PSP_COUNT; i++) {
 		query_fw.index = i;
 		ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
 		if (ret)
 			continue;
-		switch (query_fw.index) {
-		case 0:
-			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
-					"RAS", fw_info.feature, fw_info.ver);
-			break;
-		case 1:
-			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
-					"XGMI", fw_info.feature, fw_info.ver);
-			break;
-		case 2:
-			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
-					"HDCP", fw_info.feature, fw_info.ver);
-			break;
-		case 3:
-			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
-					"DTM", fw_info.feature, fw_info.ver);
-			break;
-		case 4:
-			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
-					"RAP", fw_info.feature, fw_info.ver);
-			break;
-		default:
-			return -EINVAL;
-		}
+
+		seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
+			   ta_fw_name[i], fw_info.feature, fw_info.ver);
 	}
 
 	/* SMC */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 46449e70348b..c03f32ec3ebc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -136,6 +136,7 @@ enum ta_fw_type {
 	TA_FW_TYPE_PSP_DTM,
 	TA_FW_TYPE_PSP_RAP,
 	TA_FW_TYPE_PSP_SECUREDISPLAY,
+	TA_FW_TYPE_PSP_COUNT,
 };
 
 struct ta_fw_bin_desc {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
