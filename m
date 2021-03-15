Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F4EC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060E664E61
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060E664E61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C9389E0D;
	Mon, 15 Mar 2021 11:23:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C7A89E0D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2jDZgR+i1DPAZLtBBWL5Q1mHWk+ajR3fH8DheCzeYo8nZmQGNfsGhl5AO/C+O30PBO4L+eh760Do9k3y7V2i6MS8wAN4nnpDDTTpVw8lYysuZXhQvSa2A1Scw7CJtSC69GcANWbQmwoD6jh7TWL0pAtUlVxtOreDk6F2S0T4Vyddy0ETRVWdrlenzgFrpVTROEUhKZajgkgA9T1avbduaW3gTdFFqF/sFCzgneV3yHH5j3k8fUhKdUxx/k51nMKDNHWPcOwzFboGWhtG1Qycowkh1SR4sl1bo+aIoMe5CFzeJMnTfgkwGh1NVPxP5ZVsVED70Vp9DHYOjn9BRDCDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drv2q84E814qLZcKO6Aadv8SYeG7fwrv2/tg4HFR9Us=;
 b=nvvK2tcnnjWNVv3bJRspSzBykvWlNXEEC9X62tbzoNL69VRnTNdQf0g1OVU9zTbYKKY0NBItEieFbZyWbsoYgXe5B9Z9AlgC9/19Pe9Wgv6OQ3Z6WaYUGGZSy5VAOET7ZrvetOZtjxXBbrGm1tB6Pgro353M7jJz1NowYqOJNqdPQFDghvwQ2CuZNziQ6B8usHZ5amYzDTcmgIjYta5opz/lKLsKybxNOFhqnGXst4azqdlH8Gq5C2HrYvAV7ax+SzFG8G8yzFPf+47yq0cISq+t+iW61anmAV5L6HzQqIPrOuFW4gDUpTjiPAL/FkHm+NQb417y1F9d6e2QpOWjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drv2q84E814qLZcKO6Aadv8SYeG7fwrv2/tg4HFR9Us=;
 b=jA0evo18N0vTe56JeX1b9cHsKi0X+yYLrdP3wLCtx+s5XS6j6rpYoOtx+3X5n1yZrLr60RpytT3wl8qoa/XkQjMDNGITDq2hFJ4tE0ohP8Bkj4J3pVWPCjPIRbDLYsB1MrYmQzJKFxEcXnpYKQXTDgMTWfFr1Zp4QqlfTZqJNe0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:23:29 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:23:29 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/23] drm/amd/display: [FW Promotion] Release 0.0.56
Date: Mon, 15 Mar 2021 09:40:04 +0800
Message-Id: <20210315014010.16238-18-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:23:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3e31bee-9a70-410a-e1be-08d8e7a4c224
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4617962F8656B38866309C4C976C9@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GHa2SKNfjZtr+pl+1I1q5pGrR0Zq2APmOT8YmMic8fvUIVjFU7iRUrQJWCMcPcC9OeuEkX2Y+JQSfX/cSQN2lyWoa8ZWws1ySX+nfvoMt2LuJ+syu6lws1C5It5rEcl3oPexxA6QnJswaY1qphpQbCURKlHQvRbFG8T7Ias/7J+YrcW2GFS4ach8QgfyifnUDRLVTnivuqn1rILDU+N6ndE80lW+iedDl4C3DJDKcDppwF+ViTUfJTGoMX546SWaXVq0O9cypC9CF2zKOLWFZ+4nMQaIcfznas8yiklnIYZ+Bp5Twtsq1Nbs5jB3SS+AXMhH7G/NRpiJzQYOrYv8FoDY8GamIO/ftxqSYludiSO1yZRXpatBipNLGIpCl3+2bK5OBYMlsuyGaSO8dZ/87r6JzGfMBY4oI+hPZcEpmBTBCvP04h2AANsOf1sQC5S0zcl78/O+6a8rKK3aW1e2iYD30VYhLzMI7CVF/x3Z7fINm9lID9LoQc70vqjqGy24fb8+zmVMb5asd16efmB2k/hy13K3R/WfLDR31HSqYa5tTsNu2Tz6cXJLRHbhGrTZdHdXrUYl61jM0haCX+Pb9aSTwA6joDVs1EDMmC2jykQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(8676002)(6666004)(54906003)(8936002)(52116002)(4326008)(86362001)(5660300002)(316002)(186003)(16526019)(26005)(83380400001)(2616005)(2906002)(30864003)(6486002)(6512007)(66946007)(66556008)(36756003)(6916009)(956004)(44832011)(66476007)(6506007)(478600001)(1076003)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Mf3ENSdvMJh0lqT7vFuNwFLeLoMmBC7IoZBVmVlTyAdmYPG0rGrIHCr2pmjc?=
 =?us-ascii?Q?tIvhRPVbeToLYgZJ28Y8LqPHdrMwgo/xH/S6VxqpBHwZXMrY7dnyc028oR+Z?=
 =?us-ascii?Q?dA1vNlHh2Le0hg7GTHfhfDgmzN5ALAhiB1V70Uinn/KauLSWCCq5tBpbQ23g?=
 =?us-ascii?Q?NbBgSQmnz1+f1hOKptwOldlqbJIaiqLxOyvckAhvl1ShzLJtddsvu3Fhn8SH?=
 =?us-ascii?Q?wdClZsmyzxGKEiR4oTV7jLZh7qw5YU6JZH2lXyXIoU7PvQeW+nYXdDjMgR91?=
 =?us-ascii?Q?jLZ+DQzWWk5n5JvQcqPiGLNx4INd5oZFoy1pNMqVZSGQprdXTM7N1O748npb?=
 =?us-ascii?Q?DYQhF8cfZy11zb8sazuyA5RmXMqVl9Q0NLmGf7h0HonVIzXrgAdv6EYDFvKP?=
 =?us-ascii?Q?/SveoQaSQ1BpCoSsCDoGdBf1H901Q8dNEXoFDAgCZNxjT+nCz34S8gJb88W+?=
 =?us-ascii?Q?fhXcHlfrdyJDjltxIcj4ZpxrIpv5lZMBi7z+xGsTvJiU8dZjk4rGV8Jlii5r?=
 =?us-ascii?Q?Se1g0xU8KVpOkJzBZt5s8B3PESsuLHphr3UO+ieMA3uFYk+E+BPnYdBYbBz/?=
 =?us-ascii?Q?w10hBLollrqHbLHQm7mQlkLPx8rFbVSBHzKoUsAwx8H71GFHokpb1mUwyqqJ?=
 =?us-ascii?Q?ln9Mn9KrsHn0rjAuRSXSRvFeo1piOceXUaNymPhoIc5eny/McYmtcOyQuL5j?=
 =?us-ascii?Q?HxtZutdMXPcc/DvtUJkQ1x+zLR2gR7ugYX2xCB8FP47zkdc5bqCBLqNbuEyO?=
 =?us-ascii?Q?MLOB40KWLkgQ2PqG4rR+HiUkcrtAahebukZ+khVlzED+2m9aIrrrNlqeK5O2?=
 =?us-ascii?Q?t81QXLFlpWwYWjUlkTHZe9htgz9BQRYNBvrzdMTjubdnZPSpuhUsuTs7bkgW?=
 =?us-ascii?Q?MxHjpxJ2mZXwoRPRnr+njbYivunVWHI6ru5Kd5dJDrwvFLViMGIcjvM6eArJ?=
 =?us-ascii?Q?yQr7fam2K0C1n3XehkBvOv0nKUTuQxTxkiNpO76H9PEp1DVFVSR5Rradz3Uw?=
 =?us-ascii?Q?U+pfadIPVRf/lgPHXxO3dLGgaEs6sKANkvY8rf3zXCZqcHK1ou8Y14zI5Ehi?=
 =?us-ascii?Q?OmGCtlkYNszdn57q0+8GIOXrarR0F360YhfIblWjTxqMgrAOY5I9SPDOxlma?=
 =?us-ascii?Q?vct3x9+JdaXT5ciPKwaKcC2ZDRpDt5p88X/wTktVgGMGJhxsgHUCKq8yOSfa?=
 =?us-ascii?Q?C0rs0sMlfk0VyXsr/Wkv1E3SrHzcTLcAQNGwYpgOWFs4TfGT5zrXJIFg3fYM?=
 =?us-ascii?Q?m2rqtZaG4x/oK04XsLIwxv059mvHPdtHBwiysAcAM+3pS0etUq1dUcbKLoTo?=
 =?us-ascii?Q?PTfW6IO/9KJFLwNf6rgJWPIOSMg7GQ6A0qtzngfhy7rHlw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e31bee-9a70-410a-e1be-08d8e7a4c224
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:23:29.5372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCNYYl0u9b3fn5kW5W0WhZEN4icU+vLX+3cUOIKnf4pKTQsRgcay46Vez+oCOz37Al4f+1NEBSJm1Ff7bTEYpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Eryk.Brol@amd.com, Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

More updates to the comments to better describe the function of
different cmds and parameters in the dmub interface.

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 668 ++++++++++++++----
 1 file changed, 526 insertions(+), 142 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b6f4db3af5e8..f07b348f7c29 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x920aff8b2
+#define DMUB_FW_VERSION_GIT_HASH 0xc29b1734b
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 55
+#define DMUB_FW_VERSION_REVISION 56
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -120,14 +120,23 @@
 /* Trace buffer offset for entry */
 #define TRACE_BUFFER_ENTRY_OFFSET  16
 
+/**
+ * Physical framebuffer address location, 64-bit.
+ */
 #ifndef PHYSICAL_ADDRESS_LOC
 #define PHYSICAL_ADDRESS_LOC union large_integer
 #endif
 
+/**
+ * OS/FW agnostic memcpy
+ */
 #ifndef dmub_memcpy
 #define dmub_memcpy(dest, source, bytes) memcpy((dest), (source), (bytes))
 #endif
 
+/**
+ * OS/FW agnostic memset
+ */
 #ifndef dmub_memset
 #define dmub_memset(dest, val, bytes) memset((dest), (val), (bytes))
 #endif
@@ -136,16 +145,22 @@
 extern "C" {
 #endif
 
+/**
+ * OS/FW agnostic udelay
+ */
 #ifndef dmub_udelay
 #define dmub_udelay(microseconds) udelay(microseconds)
 #endif
 
+/**
+ * union dmub_addr - DMUB physical/virtual 64-bit address.
+ */
 union dmub_addr {
 	struct {
-		uint32_t low_part;
-		uint32_t high_part;
-	} u;
-	uint64_t quad_part;
+		uint32_t low_part; /**< Lower 32 bits */
+		uint32_t high_part; /**< Upper 32 bits */
+	} u; /*<< Low/high bit access */
+	uint64_t quad_part; /*<< 64 bit address */
 };
 
 /**
@@ -187,11 +202,12 @@ struct dmub_feature_caps {
 	 * Max PSR version supported by FW.
 	 */
 	uint8_t psr;
-
-	/**
-	 * Reserved.
-	 */
+#ifndef TRIM_FAMS
+	uint8_t fw_assisted_mclk_switch;
+	uint8_t reserved[6];
+#else
 	uint8_t reserved[7];
+#endif
 };
 
 #if defined(__cplusplus)
@@ -225,18 +241,20 @@ struct dmub_feature_caps {
  * @dal_fw: 1 if the firmware is DAL
  */
 struct dmub_fw_meta_info {
-	uint32_t magic_value;
-	uint32_t fw_region_size;
-	uint32_t trace_buffer_size;
-	uint32_t fw_version;
-	uint8_t dal_fw;
-	uint8_t reserved[3];
+	uint32_t magic_value; /**< magic value identifying DMUB firmware meta info */
+	uint32_t fw_region_size; /**< size of the firmware state region */
+	uint32_t trace_buffer_size; /**< size of the tracebuffer region */
+	uint32_t fw_version; /**< the firmware version information */
+	uint8_t dal_fw; /**< 1 if the firmware is DAL */
+	uint8_t reserved[3]; /**< padding bits */
 };
 
-/* Ensure that the structure remains 64 bytes. */
+/**
+ * union dmub_fw_meta - ensures that dmub_fw_meta_info remains 64 bytes
+ */
 union dmub_fw_meta {
-	struct dmub_fw_meta_info info;
-	uint8_t reserved[64];
+	struct dmub_fw_meta_info info; /**< metadata info */
+	uint8_t reserved[64]; /**< padding bits */
 };
 
 #pragma pack(pop)
@@ -244,13 +262,19 @@ union dmub_fw_meta {
 //==============================================================================
 //< DMUB Trace Buffer>================================================================
 //==============================================================================
+/**
+ * dmub_trace_code_t - firmware trace code, 32-bits
+ */
 typedef uint32_t dmub_trace_code_t;
 
+/**
+ * struct dmcub_trace_buf_entry - Firmware trace entry
+ */
 struct dmcub_trace_buf_entry {
-	dmub_trace_code_t trace_code;
-	uint32_t tick_count;
-	uint32_t param0;
-	uint32_t param1;
+	dmub_trace_code_t trace_code; /**< trace code for the event */
+	uint32_t tick_count; /**< the tick count at time of trace */
+	uint32_t param0; /**< trace defined parameter 0 */
+	uint32_t param1; /**< trace defined parameter 1 */
 };
 
 //==============================================================================
@@ -265,42 +289,49 @@ struct dmcub_trace_buf_entry {
  * SCRATCH15: FW Boot Options register
  */
 
-/* Register bit definition for SCRATCH0 */
+/**
+ * union dmub_fw_boot_status - Status bit definitions for SCRATCH0.
+ */
 union dmub_fw_boot_status {
 	struct {
-		uint32_t dal_fw : 1;
-		uint32_t mailbox_rdy : 1;
-		uint32_t optimized_init_done : 1;
-		uint32_t restore_required : 1;
-	} bits;
-	uint32_t all;
+		uint32_t dal_fw : 1; /**< 1 if DAL FW */
+		uint32_t mailbox_rdy : 1; /**< 1 if mailbox ready */
+		uint32_t optimized_init_done : 1; /**< 1 if optimized init done */
+		uint32_t restore_required : 1; /**< 1 if driver should call restore */
+	} bits; /**< status bits */
+	uint32_t all; /**< 32-bit access to status bits */
 };
 
+/**
+ * enum dmub_fw_boot_status_bit - Enum bit definitions for SCRATCH0.
+ */
 enum dmub_fw_boot_status_bit {
-	DMUB_FW_BOOT_STATUS_BIT_DAL_FIRMWARE = (1 << 0),
-	DMUB_FW_BOOT_STATUS_BIT_MAILBOX_READY = (1 << 1),
-	DMUB_FW_BOOT_STATUS_BIT_OPTIMIZED_INIT_DONE = (1 << 2),
-	DMUB_FW_BOOT_STATUS_BIT_RESTORE_REQUIRED = (1 << 3),
+	DMUB_FW_BOOT_STATUS_BIT_DAL_FIRMWARE = (1 << 0), /**< 1 if DAL FW */
+	DMUB_FW_BOOT_STATUS_BIT_MAILBOX_READY = (1 << 1), /**< 1 if mailbox ready */
+	DMUB_FW_BOOT_STATUS_BIT_OPTIMIZED_INIT_DONE = (1 << 2), /**< 1 if init done */
+	DMUB_FW_BOOT_STATUS_BIT_RESTORE_REQUIRED = (1 << 3), /**< 1 if driver should call restore */
 };
 
-/* Register bit definition for SCRATCH15 */
+/**
+ * union dmub_fw_boot_options - Boot option definitions for SCRATCH15
+ */
 union dmub_fw_boot_options {
 	struct {
-		uint32_t pemu_env : 1;
-		uint32_t fpga_env : 1;
-		uint32_t optimized_init : 1;
-		uint32_t skip_phy_access : 1;
-		uint32_t disable_clk_gate: 1;
-		uint32_t skip_phy_init_panel_sequence: 1;
-		uint32_t reserved : 26;
-	} bits;
-	uint32_t all;
+		uint32_t pemu_env : 1; /**< 1 if PEMU */
+		uint32_t fpga_env : 1; /**< 1 if FPGA */
+		uint32_t optimized_init : 1; /**< 1 if optimized init */
+		uint32_t skip_phy_access : 1; /**< 1 if PHY access should be skipped */
+		uint32_t disable_clk_gate: 1; /**< 1 if clock gating should be disabled */
+		uint32_t skip_phy_init_panel_sequence: 1; /**< 1 to skip panel init seq */
+		uint32_t reserved : 26; /**< reserved */
+	} bits; /**< boot bits */
+	uint32_t all; /**< 32-bit access to bits */
 };
 
 enum dmub_fw_boot_options_bit {
-	DMUB_FW_BOOT_OPTION_BIT_PEMU_ENV = (1 << 0),
-	DMUB_FW_BOOT_OPTION_BIT_FPGA_ENV = (1 << 1),
-	DMUB_FW_BOOT_OPTION_BIT_OPTIMIZED_INIT_DONE = (1 << 2),
+	DMUB_FW_BOOT_OPTION_BIT_PEMU_ENV = (1 << 0), /**< 1 if PEMU */
+	DMUB_FW_BOOT_OPTION_BIT_FPGA_ENV = (1 << 1), /**< 1 if FPGA */
+	DMUB_FW_BOOT_OPTION_BIT_OPTIMIZED_INIT_DONE = (1 << 2), /**< 1 if optimized init done */
 };
 
 //==============================================================================
@@ -310,14 +341,27 @@ enum dmub_fw_boot_options_bit {
 //==============================================================================
 
 /*
+ * enum dmub_cmd_vbios_type - VBIOS commands.
+ *
  * Command IDs should be treated as stable ABI.
  * Do not reuse or modify IDs.
  */
-
 enum dmub_cmd_vbios_type {
+	/**
+	 * Configures the DIG encoder.
+	 */
 	DMUB_CMD__VBIOS_DIGX_ENCODER_CONTROL = 0,
+	/**
+	 * Controls the PHY.
+	 */
 	DMUB_CMD__VBIOS_DIG1_TRANSMITTER_CONTROL = 1,
+	/**
+	 * Sets the pixel clock/symbol clock.
+	 */
 	DMUB_CMD__VBIOS_SET_PIXEL_CLOCK = 2,
+	/**
+	 * Enables or disables power gating.
+	 */
 	DMUB_CMD__VBIOS_ENABLE_DISP_POWER_GATING = 3,
 	DMUB_CMD__VBIOS_LVTMA_CONTROL = 15,
 };
@@ -346,28 +390,43 @@ enum dmub_cmd_vbios_type {
  * Command responses.
  */
 
+/**
+ * Return response for DMUB_GPINT__STOP_FW command.
+ */
 #define DMUB_GPINT__STOP_FW_RESPONSE 0xDEADDEAD
 
 /**
- * The register format for sending a command via the GPINT.
+ * union dmub_gpint_data_register - Format for sending a command via the GPINT.
  */
 union dmub_gpint_data_register {
 	struct {
-		uint32_t param : 16;
-		uint32_t command_code : 12;
-		uint32_t status : 4;
-	} bits;
-	uint32_t all;
+		uint32_t param : 16; /**< 16-bit parameter */
+		uint32_t command_code : 12; /**< GPINT command */
+		uint32_t status : 4; /**< Command status bit */
+	} bits; /**< GPINT bit access */
+	uint32_t all; /**< GPINT  32-bit access */
 };
 
 /*
+ * enum dmub_gpint_command - GPINT command to DMCUB FW
+ *
  * Command IDs should be treated as stable ABI.
  * Do not reuse or modify IDs.
  */
-
 enum dmub_gpint_command {
+	/**
+	 * Invalid command, ignored.
+	 */
 	DMUB_GPINT__INVALID_COMMAND = 0,
+	/**
+	 * DESC: Queries the firmware version.
+	 * RETURN: Firmware version.
+	 */
 	DMUB_GPINT__GET_FW_VERSION = 1,
+	/**
+	 * DESC: Halts the firmware.
+	 * RETURN: DMUB_GPINT__STOP_FW_RESPONSE (0xDEADDEAD) when halted
+	 */
 	DMUB_GPINT__STOP_FW = 2,
 	/**
 	 * DESC: Get PSR state from FW.
@@ -394,22 +453,56 @@ enum dmub_gpint_command {
 //< DMUB_CMD>===================================================================
 //==============================================================================
 
+/**
+ * Size in bytes of each DMUB command.
+ */
 #define DMUB_RB_CMD_SIZE 64
+
+/**
+ * Maximum number of items in the DMUB ringbuffer.
+ */
 #define DMUB_RB_MAX_ENTRY 128
+
+/**
+ * Ringbuffer size in bytes.
+ */
 #define DMUB_RB_SIZE (DMUB_RB_CMD_SIZE * DMUB_RB_MAX_ENTRY)
+
+/**
+ * REG_SET mask for reg offload.
+ */
 #define REG_SET_MASK 0xFFFF
 
 /*
+ * enum dmub_cmd_type - DMUB inbox command.
+ *
  * Command IDs should be treated as stable ABI.
  * Do not reuse or modify IDs.
  */
-
 enum dmub_cmd_type {
+	/**
+	 * Invalid command.
+	 */
 	DMUB_CMD__NULL = 0,
+	/**
+	 * Read modify write register sequence offload.
+	 */
 	DMUB_CMD__REG_SEQ_READ_MODIFY_WRITE = 1,
+	/**
+	 * Field update register sequence offload.
+	 */
 	DMUB_CMD__REG_SEQ_FIELD_UPDATE_SEQ = 2,
+	/**
+	 * Burst write sequence offload.
+	 */
 	DMUB_CMD__REG_SEQ_BURST_WRITE = 3,
+	/**
+	 * Reg wait sequence offload.
+	 */
 	DMUB_CMD__REG_REG_WAIT = 4,
+	/**
+	 * Workaround to avoid HUBP underflow during NV12 playback.
+	 */
 	DMUB_CMD__PLAT_54186_WA = 5,
 	/**
 	 * Command type used to query FW feature caps.
@@ -419,6 +512,9 @@ enum dmub_cmd_type {
 	 * Command type used for all PSR commands.
 	 */
 	DMUB_CMD__PSR = 64,
+	/**
+	 * Command type used for all MALL commands.
+	 */
 	DMUB_CMD__MALL = 65,
 	/**
 	 * Command type used for all ABM commands.
@@ -436,10 +532,23 @@ enum dmub_cmd_type {
 	 * Command type used for OUTBOX1 notification enable
 	 */
 	DMUB_CMD__OUTBOX1_ENABLE = 71,
+#ifndef TRIM_FAMS
+	DMUB_CMD__FW_ASSISTED_MCLK_SWITCH = 76,
+#endif
+
+	/**
+	 * Command type used for all VBIOS interface commands.
+	 */
 	DMUB_CMD__VBIOS = 128,
 };
 
+/**
+ * enum dmub_out_cmd_type - DMUB outbox commands.
+ */
 enum dmub_out_cmd_type {
+	/**
+	 * Invalid outbox command, ignored.
+	 */
 	DMUB_OUT_CMD__NULL = 0,
 	/**
 	 * Command type used for DP AUX Reply data notification
@@ -453,17 +562,20 @@ enum dmub_out_cmd_type {
 
 #pragma pack(push, 1)
 
+/**
+ * struct dmub_cmd_header - Common command header fields.
+ */
 struct dmub_cmd_header {
-	unsigned int type : 8;
-	unsigned int sub_type : 8;
-	unsigned int ret_status : 1;
-	unsigned int reserved0 : 7;
-	unsigned int payload_bytes : 6;  /* up to 60 bytes */
-	unsigned int reserved1 : 2;
+	unsigned int type : 8; /**< command type */
+	unsigned int sub_type : 8; /**< command sub type */
+	unsigned int ret_status : 1; /**< 1 if returned data, 0 otherwise */
+	unsigned int reserved0 : 7; /**< reserved bits */
+	unsigned int payload_bytes : 6;  /* payload excluding header - up to 60 bytes */
+	unsigned int reserved1 : 2; /**< reserved bits */
 };
 
 /*
- * Read modify write
+ * struct dmub_cmd_read_modify_write_sequence - Read modify write
  *
  * 60 payload bytes can hold up to 5 sets of read modify writes,
  * each take 3 dwords.
@@ -474,14 +586,24 @@ struct dmub_cmd_header {
  * command parser will skip the read and we can use modify_mask = 0xffff'ffff as reg write
  */
 struct dmub_cmd_read_modify_write_sequence {
-	uint32_t addr;
-	uint32_t modify_mask;
-	uint32_t modify_value;
+	uint32_t addr; /**< register address */
+	uint32_t modify_mask; /**< modify mask */
+	uint32_t modify_value; /**< modify value */
 };
 
-#define DMUB_READ_MODIFY_WRITE_SEQ__MAX		5
+/**
+ * Maximum number of ops in read modify write sequence.
+ */
+#define DMUB_READ_MODIFY_WRITE_SEQ__MAX 5
+
+/**
+ * struct dmub_cmd_read_modify_write_sequence - Read modify write command.
+ */
 struct dmub_rb_cmd_read_modify_write {
-	struct dmub_cmd_header header;  // type = DMUB_CMD__REG_SEQ_READ_MODIFY_WRITE
+	struct dmub_cmd_header header;  /**< command header */
+	/**
+	 * Read modify write sequence.
+	 */
 	struct dmub_cmd_read_modify_write_sequence seq[DMUB_READ_MODIFY_WRITE_SEQ__MAX];
 };
 
@@ -499,19 +621,35 @@ struct dmub_rb_cmd_read_modify_write {
  */
 
 struct dmub_cmd_reg_field_update_sequence {
-	uint32_t modify_mask;  // 0xffff'ffff to skip initial read
-	uint32_t modify_value;
+	uint32_t modify_mask; /**< 0xffff'ffff to skip initial read */
+	uint32_t modify_value; /**< value to update with */
 };
 
-#define DMUB_REG_FIELD_UPDATE_SEQ__MAX		7
+/**
+ * Maximum number of ops in field update sequence.
+ */
+#define DMUB_REG_FIELD_UPDATE_SEQ__MAX 7
+
+/**
+ * struct dmub_rb_cmd_reg_field_update_sequence - Field update command.
+ */
 struct dmub_rb_cmd_reg_field_update_sequence {
-	struct dmub_cmd_header header;
-	uint32_t addr;
+	struct dmub_cmd_header header; /**< command header */
+	uint32_t addr; /**< register address */
+	/**
+	 * Field update sequence.
+	 */
 	struct dmub_cmd_reg_field_update_sequence seq[DMUB_REG_FIELD_UPDATE_SEQ__MAX];
 };
 
+
+/**
+ * Maximum number of burst write values.
+ */
+#define DMUB_BURST_WRITE_VALUES__MAX  14
+
 /*
- * Burst write
+ * struct dmub_rb_cmd_burst_write - Burst write
  *
  * support use case such as writing out LUTs.
  *
@@ -519,96 +657,141 @@ struct dmub_rb_cmd_reg_field_update_sequence {
  *
  * number of payload = header.payload_bytes / sizeof(struct read_modify_write_sequence)
  */
-#define DMUB_BURST_WRITE_VALUES__MAX  14
 struct dmub_rb_cmd_burst_write {
-	struct dmub_cmd_header header;  // type = DMUB_CMD__REG_SEQ_BURST_WRITE
-	uint32_t addr;
+	struct dmub_cmd_header header; /**< command header */
+	uint32_t addr; /**< register start address */
+	/**
+	 * Burst write register values.
+	 */
 	uint32_t write_values[DMUB_BURST_WRITE_VALUES__MAX];
 };
 
-
+/**
+ * struct dmub_rb_cmd_common - Common command header
+ */
 struct dmub_rb_cmd_common {
-	struct dmub_cmd_header header;
+	struct dmub_cmd_header header; /**< command header */
+	/**
+	 * Padding to RB_CMD_SIZE
+	 */
 	uint8_t cmd_buffer[DMUB_RB_CMD_SIZE - sizeof(struct dmub_cmd_header)];
 };
 
+/**
+ * struct dmub_cmd_reg_wait_data - Register wait data
+ */
 struct dmub_cmd_reg_wait_data {
-	uint32_t addr;
-	uint32_t mask;
-	uint32_t condition_field_value;
-	uint32_t time_out_us;
+	uint32_t addr; /**< Register address */
+	uint32_t mask; /**< Mask for register bits */
+	uint32_t condition_field_value; /**< Value to wait for */
+	uint32_t time_out_us; /**< Time out for reg wait in microseconds */
 };
 
+/**
+ * struct dmub_rb_cmd_reg_wait - Register wait command
+ */
 struct dmub_rb_cmd_reg_wait {
-	struct dmub_cmd_header header;
-	struct dmub_cmd_reg_wait_data reg_wait;
+	struct dmub_cmd_header header; /**< Command header */
+	struct dmub_cmd_reg_wait_data reg_wait; /**< Register wait data */
 };
 
+/**
+ * struct dmub_cmd_PLAT_54186_wa - Underflow workaround
+ *
+ * Reprograms surface parameters to avoid underflow.
+ */
 struct dmub_cmd_PLAT_54186_wa {
-	uint32_t DCSURF_SURFACE_CONTROL;
-	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH;
-	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS;
-	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C;
-	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS_C;
+	uint32_t DCSURF_SURFACE_CONTROL; /**< reg value */
+	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH; /**< reg value */
+	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS; /**< reg value */
+	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C; /**< reg value */
+	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS_C; /**< reg value */
 	struct {
-		uint8_t hubp_inst : 4;
-		uint8_t tmz_surface : 1;
-		uint8_t immediate :1;
-		uint8_t vmid : 4;
-		uint8_t grph_stereo : 1;
-		uint32_t reserved : 21;
-	} flip_params;
-	uint32_t reserved[9];
+		uint8_t hubp_inst : 4; /**< HUBP instance */
+		uint8_t tmz_surface : 1; /**< TMZ enable or disable */
+		uint8_t immediate :1; /**< Immediate flip */
+		uint8_t vmid : 4; /**< VMID */
+		uint8_t grph_stereo : 1; /**< 1 if stereo */
+		uint32_t reserved : 21; /**< Reserved */
+	} flip_params; /**< Pageflip parameters */
+	uint32_t reserved[9]; /**< Reserved bits */
 };
 
+/**
+ * struct dmub_rb_cmd_PLAT_54186_wa - Underflow workaround command
+ */
 struct dmub_rb_cmd_PLAT_54186_wa {
-	struct dmub_cmd_header header;
-	struct dmub_cmd_PLAT_54186_wa flip;
+	struct dmub_cmd_header header; /**< Command header */
+	struct dmub_cmd_PLAT_54186_wa flip; /**< Flip data */
 };
 
+/**
+ * struct dmub_rb_cmd_mall - MALL command data.
+ */
 struct dmub_rb_cmd_mall {
-	struct dmub_cmd_header header;
-	union dmub_addr cursor_copy_src;
-	union dmub_addr cursor_copy_dst;
-	uint32_t tmr_delay;
-	uint32_t tmr_scale;
-	uint16_t cursor_width;
-	uint16_t cursor_pitch;
-	uint16_t cursor_height;
-	uint8_t cursor_bpp;
-	uint8_t debug_bits;
+	struct dmub_cmd_header header; /**< Common command header */
+	union dmub_addr cursor_copy_src; /**< Cursor copy address */
+	union dmub_addr cursor_copy_dst; /**< Cursor copy destination */
+	uint32_t tmr_delay; /**< Timer delay */
+	uint32_t tmr_scale; /**< Timer scale */
+	uint16_t cursor_width; /**< Cursor width in pixels */
+	uint16_t cursor_pitch; /**< Cursor pitch in pixels */
+	uint16_t cursor_height; /**< Cursor height in pixels */
+	uint8_t cursor_bpp; /**< Cursor bits per pixel */
+	uint8_t debug_bits; /**< Debug bits */
 
-	uint8_t reserved1;
-	uint8_t reserved2;
+	uint8_t reserved1; /**< Reserved bits */
+	uint8_t reserved2; /**< Reserved bits */
 };
 
+/**
+ * struct dmub_cmd_digx_encoder_control_data - Encoder control data.
+ */
 struct dmub_cmd_digx_encoder_control_data {
-	union dig_encoder_control_parameters_v1_5 dig;
+	union dig_encoder_control_parameters_v1_5 dig; /**< payload */
 };
 
+/**
+ * struct dmub_rb_cmd_digx_encoder_control - Encoder control command.
+ */
 struct dmub_rb_cmd_digx_encoder_control {
-	struct dmub_cmd_header header;
-	struct dmub_cmd_digx_encoder_control_data encoder_control;
+	struct dmub_cmd_header header;  /**< header */
+	struct dmub_cmd_digx_encoder_control_data encoder_control; /**< payload */
 };
 
+/**
+ * struct dmub_cmd_set_pixel_clock_data - Set pixel clock data.
+ */
 struct dmub_cmd_set_pixel_clock_data {
-	struct set_pixel_clock_parameter_v1_7 clk;
+	struct set_pixel_clock_parameter_v1_7 clk; /**< payload */
 };
 
+/**
+ * struct dmub_cmd_set_pixel_clock_data - Set pixel clock command.
+ */
 struct dmub_rb_cmd_set_pixel_clock {
-	struct dmub_cmd_header header;
-	struct dmub_cmd_set_pixel_clock_data pixel_clock;
+	struct dmub_cmd_header header; /**< header */
+	struct dmub_cmd_set_pixel_clock_data pixel_clock; /**< payload */
 };
 
+/**
+ * struct dmub_cmd_enable_disp_power_gating_data - Display power gating.
+ */
 struct dmub_cmd_enable_disp_power_gating_data {
-	struct enable_disp_power_gating_parameters_v2_1 pwr;
+	struct enable_disp_power_gating_parameters_v2_1 pwr; /**< payload */
 };
 
+/**
+ * struct dmub_rb_cmd_enable_disp_power_gating - Display power command.
+ */
 struct dmub_rb_cmd_enable_disp_power_gating {
-	struct dmub_cmd_header header;
-	struct dmub_cmd_enable_disp_power_gating_data power_gating;
+	struct dmub_cmd_header header; /**< header */
+	struct dmub_cmd_enable_disp_power_gating_data power_gating;  /**< payload */
 };
 
+/**
+ * struct dmub_dig_transmitter_control_data_v1_7 - Transmitter control.
+ */
 struct dmub_dig_transmitter_control_data_v1_7 {
 	uint8_t phyid; /**< 0=UNIPHYA, 1=UNIPHYB, 2=UNIPHYC, 3=UNIPHYD, 4=UNIPHYE, 5=UNIPHYF */
 	uint8_t action; /**< Defined as ATOM_TRANSMITER_ACTION_xxx */
@@ -629,19 +812,28 @@ struct dmub_dig_transmitter_control_data_v1_7 {
 	uint32_t reserved3[11]; /**< For future use */
 };
 
+/**
+ * union dmub_cmd_dig1_transmitter_control_data - Transmitter control data.
+ */
 union dmub_cmd_dig1_transmitter_control_data {
-	struct dig_transmitter_control_parameters_v1_6 dig;
-	struct dmub_dig_transmitter_control_data_v1_7 dig_v1_7;
+	struct dig_transmitter_control_parameters_v1_6 dig; /**< payload */
+	struct dmub_dig_transmitter_control_data_v1_7 dig_v1_7;  /**< payload 1.7 */
 };
 
+/**
+ * struct dmub_rb_cmd_dig1_transmitter_control - Transmitter control command.
+ */
 struct dmub_rb_cmd_dig1_transmitter_control {
-	struct dmub_cmd_header header;
-	union dmub_cmd_dig1_transmitter_control_data transmitter_control;
+	struct dmub_cmd_header header; /**< header */
+	union dmub_cmd_dig1_transmitter_control_data transmitter_control; /**< payload */
 };
 
+/**
+ * struct dmub_rb_cmd_dpphy_init - DPPHY init.
+ */
 struct dmub_rb_cmd_dpphy_init {
-	struct dmub_cmd_header header;
-	uint8_t reserved[60];
+	struct dmub_cmd_header header; /**< header */
+	uint8_t reserved[60]; /**< reserved bits */
 };
 
 /**
@@ -923,6 +1115,13 @@ enum dmub_cmd_psr_type {
 	DMUB_CMD__PSR_FORCE_STATIC		= 5,
 };
 
+#ifndef TRIM_FAMS
+enum dmub_cmd_fams_type {
+	DMUB_CMD__FAMS_SETUP_FW_CTRL	= 0,
+	DMUB_CMD__FAMS_DRR_UPDATE		= 1,
+};
+#endif
+
 /**
  * PSR versions.
  */
@@ -937,13 +1136,29 @@ enum psr_version {
 	PSR_VERSION_UNSUPPORTED			= 0xFFFFFFFF,
 };
 
+/**
+ * enum dmub_cmd_mall_type - MALL commands
+ */
 enum dmub_cmd_mall_type {
+	/**
+	 * Allows display refresh from MALL.
+	 */
 	DMUB_CMD__MALL_ACTION_ALLOW = 0,
+	/**
+	 * Disallows display refresh from MALL.
+	 */
 	DMUB_CMD__MALL_ACTION_DISALLOW = 1,
+	/**
+	 * Cursor copy for MALL.
+	 */
 	DMUB_CMD__MALL_ACTION_COPY_CURSOR = 2,
+	/**
+	 * Controls DF requests.
+	 */
 	DMUB_CMD__MALL_ACTION_NO_DF_REQ = 3,
 };
 
+
 /**
  * Data passed from driver to FW in a DMUB_CMD__PSR_COPY_SETTINGS command.
  */
@@ -1561,6 +1776,39 @@ struct dmub_rb_cmd_query_feature_caps {
 	struct dmub_cmd_query_feature_caps_data query_feature_caps_data;
 };
 
+struct dmub_optc_state {
+	uint32_t v_total_max;
+	uint32_t v_total_min;
+	uint32_t v_total_mid;
+	uint32_t v_total_mid_frame_num;
+	uint32_t tg_inst;
+	uint32_t enable_manual_trigger;
+	uint32_t clear_force_vsync;
+};
+
+struct dmub_rb_cmd_drr_update {
+		struct dmub_cmd_header header;
+		struct dmub_optc_state dmub_optc_state_req;
+};
+
+#ifndef TRIM_FAMS
+struct dmub_cmd_fw_assisted_mclk_switch_pipe_data {
+	uint32_t pix_clk_100hz;
+	uint32_t min_refresh_in_uhz;
+	uint32_t max_ramp_step;
+};
+
+struct dmub_cmd_fw_assisted_mclk_switch_config {
+	uint32_t fams_enabled;
+	struct dmub_cmd_fw_assisted_mclk_switch_pipe_data pipe_data[DMUB_MAX_STREAMS];
+};
+
+struct dmub_rb_cmd_fw_assisted_mclk_switch {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_fw_assisted_mclk_switch_config config_data;
+};
+#endif
+
 /**
  * Data passed from driver to FW in a DMUB_CMD__VBIOS_LVTMA_CONTROL command.
  */
@@ -1585,17 +1833,50 @@ struct dmub_rb_cmd_lvtma_control {
 	struct dmub_cmd_lvtma_control_data data;
 };
 
+/**
+ * union dmub_rb_cmd - DMUB inbox command.
+ */
 union dmub_rb_cmd {
 	struct dmub_rb_cmd_lock_hw lock_hw;
+	/**
+	 * Elements shared with all commands.
+	 */
+	struct dmub_rb_cmd_common cmd_common;
+	/**
+	 * Definition of a DMUB_CMD__REG_SEQ_READ_MODIFY_WRITE command.
+	 */
 	struct dmub_rb_cmd_read_modify_write read_modify_write;
+	/**
+	 * Definition of a DMUB_CMD__REG_SEQ_FIELD_UPDATE_SEQ command.
+	 */
 	struct dmub_rb_cmd_reg_field_update_sequence reg_field_update_seq;
+	/**
+	 * Definition of a DMUB_CMD__REG_SEQ_BURST_WRITE command.
+	 */
 	struct dmub_rb_cmd_burst_write burst_write;
+	/**
+	 * Definition of a DMUB_CMD__REG_REG_WAIT command.
+	 */
 	struct dmub_rb_cmd_reg_wait reg_wait;
-	struct dmub_rb_cmd_common cmd_common;
+	/**
+	 * Definition of a DMUB_CMD__VBIOS_DIGX_ENCODER_CONTROL command.
+	 */
 	struct dmub_rb_cmd_digx_encoder_control digx_encoder_control;
+	/**
+	 * Definition of a DMUB_CMD__VBIOS_SET_PIXEL_CLOCK command.
+	 */
 	struct dmub_rb_cmd_set_pixel_clock set_pixel_clock;
+	/**
+	 * Definition of a DMUB_CMD__VBIOS_ENABLE_DISP_POWER_GATING command.
+	 */
 	struct dmub_rb_cmd_enable_disp_power_gating enable_disp_power_gating;
+	/**
+	 * Definition of a DMUB_CMD__VBIOS_DPPHY_INIT command.
+	 */
 	struct dmub_rb_cmd_dpphy_init dpphy_init;
+	/**
+	 * Definition of a DMUB_CMD__VBIOS_DIG1_TRANSMITTER_CONTROL command.
+	 */
 	struct dmub_rb_cmd_dig1_transmitter_control dig1_transmitter_control;
 	/**
 	 * Definition of a DMUB_CMD__PSR_SET_VERSION command.
@@ -1617,7 +1898,13 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__PSR_FORCE_STATIC command.
 	 */
 	struct dmub_rb_cmd_psr_force_static psr_force_static;
+	/**
+	 * Definition of a DMUB_CMD__PLAT_54186_WA command.
+	 */
 	struct dmub_rb_cmd_PLAT_54186_wa PLAT_54186_wa;
+	/**
+	 * Definition of a DMUB_CMD__MALL command.
+	 */
 	struct dmub_rb_cmd_mall mall;
 	/**
 	 * Definition of a DMUB_CMD__ABM_SET_PIPE command.
@@ -1654,20 +1941,40 @@ union dmub_rb_cmd {
 	 */
 	struct dmub_rb_cmd_dp_aux_access dp_aux_access;
 
+	/**
+	 * Definition of a DMUB_CMD__OUTBOX1_ENABLE command.
+	 */
 	struct dmub_rb_cmd_outbox1_enable outbox1_enable;
+
 	/**
-	 * Definition of a DMUB_CMD__qyert command.
+	 * Definition of a DMUB_CMD__QUERY_FEATURE_CAPS command.
 	 */
 	struct dmub_rb_cmd_query_feature_caps query_feature_caps;
+	struct dmub_rb_cmd_drr_update drr_update;
+#ifndef TRIM_FAMS
+	struct dmub_rb_cmd_fw_assisted_mclk_switch fw_assisted_mclk_switch;
+#endif
 	/**
 	 * Definition of a DMUB_CMD__VBIOS_LVTMA_CONTROL command.
 	 */
 	struct dmub_rb_cmd_lvtma_control lvtma_control;
 };
 
+/**
+ * union dmub_rb_out_cmd - Outbox command
+ */
 union dmub_rb_out_cmd {
+	/**
+	 * Parameters common to every command.
+	 */
 	struct dmub_rb_cmd_common cmd_common;
+	/**
+	 * AUX reply command.
+	 */
 	struct dmub_rb_cmd_dp_aux_reply dp_aux_reply;
+	/**
+	 * HPD notify command.
+	 */
 	struct dmub_rb_cmd_dp_hpd_notify dp_hpd_notify;
 };
 #pragma pack(pop)
@@ -1683,31 +1990,49 @@ union dmub_rb_out_cmd {
 extern "C" {
 #endif
 
+/**
+ * struct dmub_rb_init_params - Initialization params for DMUB ringbuffer
+ */
 struct dmub_rb_init_params {
-	void *ctx;
-	void *base_address;
-	uint32_t capacity;
-	uint32_t read_ptr;
-	uint32_t write_ptr;
+	void *ctx; /**< Caller provided context pointer */
+	void *base_address; /**< CPU base address for ring's data */
+	uint32_t capacity; /**< Ringbuffer capacity in bytes */
+	uint32_t read_ptr; /**< Initial read pointer for consumer in bytes */
+	uint32_t write_ptr; /**< Initial write pointer for producer in bytes */
 };
 
+/**
+ * struct dmub_rb - Inbox or outbox DMUB ringbuffer
+ */
 struct dmub_rb {
-	void *base_address;
-	uint32_t data_count;
-	uint32_t rptr;
-	uint32_t wrpt;
-	uint32_t capacity;
+	void *base_address; /**< CPU address for the ring's data */
+	uint32_t rptr; /**< Read pointer for consumer in bytes */
+	uint32_t wrpt; /**< Write pointer for producer in bytes */
+	uint32_t capacity; /**< Ringbuffer capacity in bytes */
 
-	void *ctx;
-	void *dmub;
+	void *ctx; /**< Caller provided context pointer */
+	void *dmub; /**< Pointer to the DMUB interface */
 };
 
-
+/**
+ * @brief Checks if the ringbuffer is empty.
+ *
+ * @param rb DMUB Ringbuffer
+ * @return true if empty
+ * @return false otherwise
+ */
 static inline bool dmub_rb_empty(struct dmub_rb *rb)
 {
 	return (rb->wrpt == rb->rptr);
 }
 
+/**
+ * @brief Checks if the ringbuffer is full
+ *
+ * @param rb DMUB Ringbuffer
+ * @return true if full
+ * @return false otherwise
+ */
 static inline bool dmub_rb_full(struct dmub_rb *rb)
 {
 	uint32_t data_count;
@@ -1720,6 +2045,14 @@ static inline bool dmub_rb_full(struct dmub_rb *rb)
 	return (data_count == (rb->capacity - DMUB_RB_CMD_SIZE));
 }
 
+/**
+ * @brief Pushes a command into the ringbuffer
+ *
+ * @param rb DMUB ringbuffer
+ * @param cmd The command to push
+ * @return true if the ringbuffer was not full
+ * @return false otherwise
+ */
 static inline bool dmub_rb_push_front(struct dmub_rb *rb,
 				      const union dmub_rb_cmd *cmd)
 {
@@ -1742,6 +2075,14 @@ static inline bool dmub_rb_push_front(struct dmub_rb *rb,
 	return true;
 }
 
+/**
+ * @brief Pushes a command into the DMUB outbox ringbuffer
+ *
+ * @param rb DMUB outbox ringbuffer
+ * @param cmd Outbox command
+ * @return true if not full
+ * @return false otherwise
+ */
 static inline bool dmub_rb_out_push_front(struct dmub_rb *rb,
 				      const union dmub_rb_out_cmd *cmd)
 {
@@ -1761,6 +2102,14 @@ static inline bool dmub_rb_out_push_front(struct dmub_rb *rb,
 	return true;
 }
 
+/**
+ * @brief Returns the next unprocessed command in the ringbuffer.
+ *
+ * @param rb DMUB ringbuffer
+ * @param cmd The command to return
+ * @return true if not empty
+ * @return false otherwise
+ */
 static inline bool dmub_rb_front(struct dmub_rb *rb,
 				 union dmub_rb_cmd  **cmd)
 {
@@ -1774,6 +2123,14 @@ static inline bool dmub_rb_front(struct dmub_rb *rb,
 	return true;
 }
 
+/**
+ * @brief Returns the next unprocessed command in the outbox.
+ *
+ * @param rb DMUB outbox ringbuffer
+ * @param cmd The outbox command to return
+ * @return true if not empty
+ * @return false otherwise
+ */
 static inline bool dmub_rb_out_front(struct dmub_rb *rb,
 				 union dmub_rb_out_cmd  *cmd)
 {
@@ -1791,6 +2148,13 @@ static inline bool dmub_rb_out_front(struct dmub_rb *rb,
 	return true;
 }
 
+/**
+ * @brief Removes the front entry in the ringbuffer.
+ *
+ * @param rb DMUB ringbuffer
+ * @return true if the command was removed
+ * @return false if there were no commands
+ */
 static inline bool dmub_rb_pop_front(struct dmub_rb *rb)
 {
 	if (dmub_rb_empty(rb))
@@ -1804,6 +2168,14 @@ static inline bool dmub_rb_pop_front(struct dmub_rb *rb)
 	return true;
 }
 
+/**
+ * @brief Flushes commands in the ringbuffer to framebuffer memory.
+ *
+ * Avoids a race condition where DMCUB accesses memory while
+ * there are still writes in flight to framebuffer.
+ *
+ * @param rb DMUB ringbuffer
+ */
 static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
 {
 	uint32_t rptr = rb->rptr;
@@ -1822,6 +2194,12 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
 	}
 }
 
+/**
+ * @brief Initializes a DMCUB ringbuffer
+ *
+ * @param rb DMUB ringbuffer
+ * @param init_params initial configuration for the ringbuffer
+ */
 static inline void dmub_rb_init(struct dmub_rb *rb,
 				struct dmub_rb_init_params *init_params)
 {
@@ -1831,6 +2209,12 @@ static inline void dmub_rb_init(struct dmub_rb *rb,
 	rb->wrpt = init_params->write_ptr;
 }
 
+/**
+ * @brief Copies output data from in/out commands into the given command.
+ *
+ * @param rb DMUB ringbuffer
+ * @param cmd Command to copy data into
+ */
 static inline void dmub_rb_get_return_data(struct dmub_rb *rb,
 					   union dmub_rb_cmd *cmd)
 {
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
