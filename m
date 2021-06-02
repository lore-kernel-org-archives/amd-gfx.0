Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62447C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F87361C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F87361C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 505036EDE6;
	Wed,  2 Jun 2021 16:51:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF00C6EDDB
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVT4ml+H5JwwcBrpJicYFdHslplpjzl0+6FQyueGYLrdONDxIdC3xxHSu+sef3Q2xeNxCzKuY9eva5mz5egNObbfx1bFC2Vfr8RC3q+2XzjzdafqlAstKz8gO0DVRrs8GrtEjfhAtTSqA0N6ETRgAU3xHhALTkIrqx2/mk/Y+NgNOWUzX0clpcuK2qOiaWaeqZG+2zbclBikBdvyyTnP9FOh5oddIlgaC/AvVSNXVU3fJdQe/FTk4c8em5oV5xg3KkREo9BkJSREpKRkeIc6h30Iwj/aUXQT1ymBPHpQce2frAhUSPQuIe08fcn5DZvWUZZZWjZcDNYc/Y330Sw1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KEg7FoIswJ0NYBZ/sJJNcX8XUjDOYp+RTEd9p/3KtA=;
 b=B8YLN5laEpALji2mhNmNWEolPIr2grwy59pm8XwC37ebRQjsu8jNIHClwKvTk/XxteIHHv2fudRK5lNF+N3PmCeNWJjGG4KD1ojuGYXim81Wyduvf6qpfXRkQcEfUJqtNnxyA5rs9lPbcgm25ZpZbzb+evWw30MpPQD8KefV1yiqR2xCDWG5zyf4Z94CDXtZfybwb0x3UIohGXwelS+tVOoN/RE2cf8csOn5hT2jCTuSR5zKGczlSjw9tSd04GxAggVKslOz3IYmGIBvhmBUBfZ8R7eeYffWMPJSD2BtwhBP3H1G1CFpodjbDeArysbqYl/n6EOrtVjXcUU89ZxB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KEg7FoIswJ0NYBZ/sJJNcX8XUjDOYp+RTEd9p/3KtA=;
 b=RA3X7Hxt9lkji73EBvGA0ddmerK2+xDJ2ybn4Y0QZwhuC9YZiiupDk1BYXOFd9PV7TwzvM13+ylo2baEhsLv2u4pds+0huiIcMH9l/QQadsG9h/MBdud2UQG/XfJkZ+1z/gUe+nOvPHlDDIjTHpVY89hzo7C/W1fGvne9SB3k3w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:21 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:21 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 79/89] drm/amd/display: Add DCN3.1 DMCUB
Date: Wed,  2 Jun 2021 12:48:58 -0400
Message-Id: <20210602164908.2848791-79-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93ed2670-4302-4e3e-cad2-08d925e68348
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4534556C8B10EEA3724C10EBF73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GSLyTkIkvgxvfrOvFSN17AjJ1dJOqBRfsmIAwB4wjvKjHjb32fIyVaXYDaRgNtOqj+WyOY8V2iiS89s4FQl6k0hd+OdpJI50bdS+kOHRugbk5MozFCZHd8OWnZPSRKakHy1tYTK/1ni3g2vH2I9aV768zfodfyUxHeKHw0Zel1aXGjqxki/EV9ItOQYKBhnjSRx9IefFsQNhpiVhhhMCTJleUwen+jjOxESGPjEsfJDeyEG+LyFxe5TxuGEEWbkFeiorcGfMXBIy88MFmAJ8wT1g2yF04SNqscSiDo30H5Ftcl1bv3Ia7p/54TlwHTNgbmPxX6ramUwhgJmzt8c0az4x21arvQo0Z8EJ2cfhyO4F3t4i/mEprIdfa7a3XdiXK2gNdLXohHAmE5UxiNh5cQ/72H8BB2SUUCU9sXCNion4jzuqsxiCaKKRk+SeHAHpJn9oIv3RvnfewntlL9CUoq0htkUWT6KSZB8E060jH+4kdE1txrsqkk6sLFiVQclhWCmHuDmZmg1zeQ1TxFDVM9Xl6U7Ep+Xy2gDGENVzBJAD2OGzXs2tmECPkiXR6qegaFuhEWBPQMQeL5hsCsV+OHWxYfSVkU1oW8F6ZDvU7gCLRQxb0fk7Z3ajgjSDrwoGH5Bul7UHmmC+tQ7QHIJzxjbvdG1AMM5xNG3YnCP6zZ2hnAau7GfUA8Sag85sUleo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(30864003)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Gt77VxVdZzBtPGHVfKlc5A0TTiWgDS3MDn6e2KD1VNZ0EbPAbAdoxELawJvh?=
 =?us-ascii?Q?m67Ap+3i7g6Pm5bsP8jj693hwNhjJraeJ8wrNqOJeBzM4JTca1p2X0UGjboi?=
 =?us-ascii?Q?5XQcbyTdwXkvgjdPvlQxGOKnhR4fy4GsJ0zBRSqVmnhpj5OiJ06I/0UP1lRq?=
 =?us-ascii?Q?MSCNv9VRxUIvGq751c78RhJsHg5JXWYbzXMrCab4YKo6J91xEMs+Pq0amq8I?=
 =?us-ascii?Q?PKUYHsNemVGfmCC+GXREaXBqUcmu2bQl7ZIFfPk9S4N5OwT5H+1T6F2fkjj+?=
 =?us-ascii?Q?/R18RJhzbzeULOe9V65c283R3KfSfm5uq6otDX9cJWkXQcKvnLLGqqJ+i0s2?=
 =?us-ascii?Q?ShWdbbdmtvyH1e6nu63z3vAuI7dvV7ZpY7MjelRno3Pq8uN7gnTjSEuj/4iJ?=
 =?us-ascii?Q?+SSalCn9pJ2zgez8d1LfbBs6YeiARj0VXQuHvyr7RPEl1QxUKYctde1GT3/l?=
 =?us-ascii?Q?2kw/txVdP+p5b8nKsJhfm4yfySMvjUuM047Pth3i1LzRJL4ClyR9RaOy2G7R?=
 =?us-ascii?Q?uRwj+QO54tGi9NOeOtLkc936WLRMzv3G79KGK1w70RbZcwkGz5T2vDHUzg8l?=
 =?us-ascii?Q?l5X0RZc2kMUktTg1SAM9oOBaOrI1lYxngJUkzeUKtraIO5BOJX1pnR3JpSkc?=
 =?us-ascii?Q?wk//BOSwNNAvqog2MN/OqefWRlFe8YSedOJ4nvejbZBDAFssesv2/OHFXdPl?=
 =?us-ascii?Q?d/HoeBxLuW7UwXuTbrU4F9KcXnnMILbClnv0/e0cFYazZPsUtEVI9BgifJ82?=
 =?us-ascii?Q?l3jBxbWktCyYVX/ODOMEkvksOOav8WDyGM2q64PzdloUimrYF0XDPyvdHwU+?=
 =?us-ascii?Q?RyewECtjKzl3g4qTXaZ789dltTZsFbDuxFLxjZEiS8zQu0IKz9MlZm7W2XTt?=
 =?us-ascii?Q?na98LBBA/xc4PAljxhOuXPucv5xMlSfrzokUaVRUmkwJWil/ajX73Oak95gY?=
 =?us-ascii?Q?7ebR6ryvaW9PReMq/FtJnfi538uCaW6krYESKQV77iYnlC9G4epiyfr6fPxw?=
 =?us-ascii?Q?3CraGRpNYT6guKuBPGO1PXKRvzPhTng9J6MUSVphDosgR+lwrJTAiqtYLq5G?=
 =?us-ascii?Q?KH/gc6wmlSi+Sa+DiNW2gTnjqBXGV+vjYCtBzne8Mv5kxafAMBi0PHjnvQ/8?=
 =?us-ascii?Q?Sk8W5DaGBWP5WNB0igjwR9c5QMyNzFbsl1Ff/7JrWL3CvOd5TPohRKqVFq9V?=
 =?us-ascii?Q?ffa5osxOlE9QYWTsKg0/VJR5ynFa65uDyeOlv/45sa91zr1yUJoq/uILlHVv?=
 =?us-ascii?Q?0BSxB16uI8P83s4aGSFcIgSdRi54MSnCpDTsAgl6NM5N9bLP+NG83BL1pggp?=
 =?us-ascii?Q?lVT2k8910CnVF+mjbe21JDbV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ed2670-4302-4e3e-cad2-08d925e68348
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:22.7058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2VxBm/S453ooLhJAw1JS9dagxs4Fgjpu8Jyx2uFmxs36fqEYyC94s0G+igi1NAQjbuptL76S70lbk85C/b5ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

DMCU-B (Display Micro-Controller Unit B) is a display microcontroller
used for shared display functionality with BIOS and for advanced
power saving display features.

Extends the command header to include new DCN3.1 functionality.

Adds new interfaces to DC dmub interface as well for z-state support.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  23 ++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   3 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  12 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 118 ++++++
 drivers/gpu/drm/amd/display/dmub/src/Makefile |   3 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 354 ++++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h | 230 ++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  37 ++
 8 files changed, 780 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 4b2854d1d981..48ca23e1e599 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -180,6 +180,29 @@ bool dc_dmub_srv_notify_stream_mask(struct dc_dmub_srv *dc_dmub_srv,
 		       dmub, DMUB_GPINT__IDLE_OPT_NOTIFY_STREAM_MASK,
 		       stream_mask, timeout) == DMUB_STATUS_OK;
 }
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+bool dc_dmub_srv_is_restore_required(struct dc_dmub_srv *dc_dmub_srv)
+{
+	struct dmub_srv *dmub;
+	struct dc_context *dc_ctx;
+	union dmub_fw_boot_status boot_status;
+	enum dmub_status status;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return false;
+
+	dmub = dc_dmub_srv->dmub;
+	dc_ctx = dc_dmub_srv->ctx;
+
+	status = dmub_srv_get_fw_boot_status(dmub, &boot_status);
+	if (status != DMUB_STATUS_OK) {
+		DC_ERROR("Error querying DMUB boot status: error=%d\n", status);
+		return false;
+	}
+
+	return boot_status.bits.restore_required;
+}
+#endif
 
 bool dc_dmub_srv_get_dmub_outbox0_msg(const struct dc *dc, struct dmcub_trace_buf_entry *entry)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index f615e3a76d01..f5489c7aa770 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -62,6 +62,9 @@ bool dc_dmub_srv_cmd_with_reply_data(struct dc_dmub_srv *dc_dmub_srv, union dmub
 bool dc_dmub_srv_notify_stream_mask(struct dc_dmub_srv *dc_dmub_srv,
 				    unsigned int stream_mask);
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+bool dc_dmub_srv_is_restore_required(struct dc_dmub_srv *dc_dmub_srv);
+#endif
 bool dc_dmub_srv_get_dmub_outbox0_msg(const struct dc *dc, struct dmcub_trace_buf_entry *entry);
 
 void dc_dmub_trace_event_control(struct dc *dc, bool enable);
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index ed58abc5b3f9..7634e8d94543 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -73,6 +73,9 @@ extern "C" {
 /* Forward declarations */
 struct dmub_srv;
 struct dmub_srv_common_regs;
+#ifdef CONFIG_DRM_AMD_DC_DCN3_1
+struct dmub_srv_dcn31_regs;
+#endif
 
 struct dmcub_trace_buf_entry;
 
@@ -94,6 +97,9 @@ enum dmub_asic {
 	DMUB_ASIC_DCN301,
 	DMUB_ASIC_DCN302,
 	DMUB_ASIC_DCN303,
+#ifdef CONFIG_DRM_AMD_DC_DCN3_1
+	DMUB_ASIC_DCN31,
+#endif
 	DMUB_ASIC_MAX,
 };
 
@@ -232,6 +238,9 @@ struct dmub_srv_hw_params {
 	uint32_t psp_version;
 	bool load_inst_const;
 	bool skip_panel_power_sequence;
+#ifdef CONFIG_DRM_AMD_DC_DCN3_1
+	bool disable_z10;
+#endif
 };
 
 /**
@@ -364,6 +373,9 @@ struct dmub_srv {
 
 	/* private: internal use only */
 	const struct dmub_srv_common_regs *regs;
+#ifdef CONFIG_DRM_AMD_DC_DCN3_1
+	const struct dmub_srv_dcn31_regs *regs_dcn31;
+#endif
 
 	struct dmub_srv_base_funcs funcs;
 	struct dmub_srv_hw_funcs hw_funcs;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 0b351da48563..026de4edb66a 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -337,7 +337,11 @@ union dmub_fw_boot_options {
 		uint32_t skip_phy_access : 1; /**< 1 if PHY access should be skipped */
 		uint32_t disable_clk_gate: 1; /**< 1 if clock gating should be disabled */
 		uint32_t skip_phy_init_panel_sequence: 1; /**< 1 to skip panel init seq */
+#ifdef CONFIG_DRM_AMD_DC_DCN3_1
+		uint32_t z10_disable: 1; /**< 1 to disable z10 */
+#else
 		uint32_t reserved_unreleased: 1; /**< reserved for an unreleased feature */
+#endif
 		uint32_t reserved : 25; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
@@ -602,6 +606,20 @@ enum dmub_cmd_type {
 	 * Command type used for OUTBOX1 notification enable
 	 */
 	DMUB_CMD__OUTBOX1_ENABLE = 71,
+#ifdef CONFIG_DRM_AMD_DC_DCN3_1
+	/**
+	 * Command type used for all idle optimization commands.
+	 */
+	DMUB_CMD__IDLE_OPT = 72,
+	/**
+	 * Command type used for all clock manager commands.
+	 */
+	DMUB_CMD__CLK_MGR = 73,
+	/**
+	 * Command type used for all panel control commands.
+	 */
+	DMUB_CMD__PANEL_CNTL = 74,
+#endif
 	/**
 	 * Command type used for all VBIOS interface commands.
 	 */
@@ -811,6 +829,53 @@ struct dmub_rb_cmd_mall {
 	uint8_t reserved2; /**< Reserved bits */
 };
 
+#ifdef CONFIG_DRM_AMD_DC_DCN3_1
+
+/**
+ * enum dmub_cmd_idle_opt_type - Idle optimization command type.
+ */
+enum dmub_cmd_idle_opt_type {
+	/**
+	 * DCN hardware restore.
+	 */
+	DMUB_CMD__IDLE_OPT_DCN_RESTORE = 0,
+};
+
+/**
+ * struct dmub_rb_cmd_idle_opt_dcn_restore - DCN restore command data.
+ */
+struct dmub_rb_cmd_idle_opt_dcn_restore {
+	struct dmub_cmd_header header; /**< header */
+};
+
+/**
+ * struct dmub_clocks - Clock update notification.
+ */
+struct dmub_clocks {
+	uint32_t dispclk_khz; /**< dispclk kHz */
+	uint32_t dppclk_khz; /**< dppclk kHz */
+	uint32_t dcfclk_khz; /**< dcfclk kHz */
+	uint32_t dcfclk_deep_sleep_khz; /**< dcfclk deep sleep kHz */
+};
+
+/**
+ * enum dmub_cmd_clk_mgr_type - Clock manager commands.
+ */
+enum dmub_cmd_clk_mgr_type {
+	/**
+	 * Notify DMCUB of clock update.
+	 */
+	DMUB_CMD__CLK_MGR_NOTIFY_CLOCKS = 0,
+};
+
+/**
+ * struct dmub_rb_cmd_clk_mgr_notify_clocks - Clock update notification.
+ */
+struct dmub_rb_cmd_clk_mgr_notify_clocks {
+	struct dmub_cmd_header header; /**< header */
+	struct dmub_clocks clocks; /**< clock data */
+};
+#endif
 /**
  * struct dmub_cmd_digx_encoder_control_data - Encoder control data.
  */
@@ -1956,6 +2021,43 @@ struct dmub_rb_cmd_drr_update {
 		struct dmub_optc_state dmub_optc_state_req;
 };
 
+#ifdef CONFIG_DRM_AMD_DC_DCN3_1
+/**
+ * enum dmub_cmd_panel_cntl_type - Panel control command.
+ */
+enum dmub_cmd_panel_cntl_type {
+	/**
+	 * Initializes embedded panel hardware blocks.
+	 */
+	DMUB_CMD__PANEL_CNTL_HW_INIT = 0,
+	/**
+	 * Queries backlight info for the embedded panel.
+	 */
+	DMUB_CMD__PANEL_CNTL_QUERY_BACKLIGHT_INFO = 1,
+};
+
+/**
+ * struct dmub_cmd_panel_cntl_data - Panel control data.
+ */
+struct dmub_cmd_panel_cntl_data {
+	uint32_t inst; /**< panel instance */
+	uint32_t current_backlight; /* in/out */
+	uint32_t bl_pwm_cntl; /* in/out */
+	uint32_t bl_pwm_period_cntl; /* in/out */
+	uint32_t bl_pwm_ref_div1; /* in/out */
+	uint8_t is_backlight_on : 1; /* in/out */
+	uint8_t is_powered_on : 1; /* in/out */
+};
+
+/**
+ * struct dmub_rb_cmd_panel_cntl - Panel control command.
+ */
+struct dmub_rb_cmd_panel_cntl {
+	struct dmub_cmd_header header; /**< header */
+	struct dmub_cmd_panel_cntl_data data; /**< payload */
+};
+#endif
+
 /**
  * Data passed from driver to FW in a DMUB_CMD__VBIOS_LVTMA_CONTROL command.
  */
@@ -2053,6 +2155,22 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__MALL command.
 	 */
 	struct dmub_rb_cmd_mall mall;
+#ifdef CONFIG_DRM_AMD_DC_DCN3_1
+	/**
+	 * Definition of a DMUB_CMD__IDLE_OPT_DCN_RESTORE command.
+	 */
+	struct dmub_rb_cmd_idle_opt_dcn_restore dcn_restore;
+
+	/**
+	 * Definition of a DMUB_CMD__CLK_MGR_NOTIFY_CLOCKS command.
+	 */
+	struct dmub_rb_cmd_clk_mgr_notify_clocks notify_clocks;
+
+	/**
+	 * Definition of DMUB_CMD__PANEL_CNTL commands.
+	 */
+	struct dmub_rb_cmd_panel_cntl panel_cntl;
+#endif
 	/**
 	 * Definition of a DMUB_CMD__ABM_SET_PIPE command.
 	 */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/Makefile b/drivers/gpu/drm/amd/display/dmub/src/Makefile
index 4d9387f53c77..80b9fe225208 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/Makefile
+++ b/drivers/gpu/drm/amd/display/dmub/src/Makefile
@@ -24,6 +24,9 @@ DMUB = dmub_srv.o dmub_srv_stat.o dmub_reg.o dmub_dcn20.o dmub_dcn21.o
 DMUB += dmub_dcn30.o dmub_dcn301.o
 DMUB += dmub_dcn302.o
 DMUB += dmub_dcn303.o
+ifdef CONFIG_DRM_AMD_DC_DCN3_1
+DMUB += dmub_dcn31.o
+endif
 
 AMD_DAL_DMUB = $(addprefix $(AMDDALPATH)/dmub/src/,$(DMUB))
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
new file mode 100644
index 000000000000..8c886ece71f6
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -0,0 +1,354 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "../dmub_srv.h"
+#include "dmub_reg.h"
+#include "dmub_dcn31.h"
+
+#include "yellow_carp_offset.h"
+#include "dcn/dcn_3_1_2_offset.h"
+#include "dcn/dcn_3_1_2_sh_mask.h"
+
+#define BASE_INNER(seg) DCN_BASE__INST0_SEG##seg
+#define CTX dmub
+#define REGS dmub->regs_dcn31
+#define REG_OFFSET_EXP(reg_name) (BASE(reg##reg_name##_BASE_IDX) + reg##reg_name)
+
+const struct dmub_srv_dcn31_regs dmub_srv_dcn31_regs = {
+#define DMUB_SR(reg) REG_OFFSET_EXP(reg),
+	{ DMUB_DCN31_REGS() },
+#undef DMUB_SR
+
+#define DMUB_SF(reg, field) FD_MASK(reg, field),
+	{ DMUB_DCN31_FIELDS() },
+#undef DMUB_SF
+
+#define DMUB_SF(reg, field) FD_SHIFT(reg, field),
+	{ DMUB_DCN31_FIELDS() },
+#undef DMUB_SF
+};
+
+static void dmub_dcn31_get_fb_base_offset(struct dmub_srv *dmub,
+					  uint64_t *fb_base,
+					  uint64_t *fb_offset)
+{
+	uint32_t tmp;
+
+	if (dmub->fb_base || dmub->fb_offset) {
+		*fb_base = dmub->fb_base;
+		*fb_offset = dmub->fb_offset;
+		return;
+	}
+
+	REG_GET(DCN_VM_FB_LOCATION_BASE, FB_BASE, &tmp);
+	*fb_base = (uint64_t)tmp << 24;
+
+	REG_GET(DCN_VM_FB_OFFSET, FB_OFFSET, &tmp);
+	*fb_offset = (uint64_t)tmp << 24;
+}
+
+static inline void dmub_dcn31_translate_addr(const union dmub_addr *addr_in,
+					     uint64_t fb_base,
+					     uint64_t fb_offset,
+					     union dmub_addr *addr_out)
+{
+	addr_out->quad_part = addr_in->quad_part - fb_base + fb_offset;
+}
+
+void dmub_dcn31_reset(struct dmub_srv *dmub)
+{
+	union dmub_gpint_data_register cmd;
+	const uint32_t timeout = 30;
+	uint32_t in_reset, scratch, i;
+
+	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
+
+	if (in_reset == 0) {
+		cmd.bits.status = 1;
+		cmd.bits.command_code = DMUB_GPINT__STOP_FW;
+		cmd.bits.param = 0;
+
+		dmub->hw_funcs.set_gpint(dmub, cmd);
+
+		/**
+		 * Timeout covers both the ACK and the wait
+		 * for remaining work to finish.
+		 *
+		 * This is mostly bound by the PHY disable sequence.
+		 * Each register check will be greater than 1us, so
+		 * don't bother using udelay.
+		 */
+
+		for (i = 0; i < timeout; ++i) {
+			if (dmub->hw_funcs.is_gpint_acked(dmub, cmd))
+				break;
+		}
+
+		for (i = 0; i < timeout; ++i) {
+			scratch = dmub->hw_funcs.get_gpint_response(dmub);
+			if (scratch == DMUB_GPINT__STOP_FW_RESPONSE)
+				break;
+		}
+
+		/* Clear the GPINT command manually so we don't reset again. */
+		cmd.all = 0;
+		dmub->hw_funcs.set_gpint(dmub, cmd);
+
+		/* Force reset in case we timed out, DMCUB is likely hung. */
+	}
+
+	REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
+	REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
+	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
+	REG_WRITE(DMCUB_INBOX1_RPTR, 0);
+	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX1_WPTR, 0);
+	REG_WRITE(DMCUB_SCRATCH0, 0);
+}
+
+void dmub_dcn31_reset_release(struct dmub_srv *dmub)
+{
+	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 0);
+	REG_WRITE(DMCUB_SCRATCH15, dmub->psp_version & 0x001100FF);
+	REG_UPDATE_2(DMCUB_CNTL, DMCUB_ENABLE, 1, DMCUB_TRACEPORT_EN, 1);
+	REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 0);
+}
+
+void dmub_dcn31_backdoor_load(struct dmub_srv *dmub,
+			      const struct dmub_window *cw0,
+			      const struct dmub_window *cw1)
+{
+	union dmub_addr offset;
+	uint64_t fb_base, fb_offset;
+
+	dmub_dcn31_get_fb_base_offset(dmub, &fb_base, &fb_offset);
+
+	REG_UPDATE(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 1);
+
+	dmub_dcn31_translate_addr(&cw0->offset, fb_base, fb_offset, &offset);
+
+	REG_WRITE(DMCUB_REGION3_CW0_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW0_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW0_BASE_ADDRESS, cw0->region.base);
+	REG_SET_2(DMCUB_REGION3_CW0_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW0_TOP_ADDRESS, cw0->region.top,
+		  DMCUB_REGION3_CW0_ENABLE, 1);
+
+	dmub_dcn31_translate_addr(&cw1->offset, fb_base, fb_offset, &offset);
+
+	REG_WRITE(DMCUB_REGION3_CW1_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW1_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW1_BASE_ADDRESS, cw1->region.base);
+	REG_SET_2(DMCUB_REGION3_CW1_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW1_TOP_ADDRESS, cw1->region.top,
+		  DMCUB_REGION3_CW1_ENABLE, 1);
+
+	REG_UPDATE_2(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 0, DMCUB_MEM_UNIT_ID,
+		     0x20);
+}
+
+void dmub_dcn31_setup_windows(struct dmub_srv *dmub,
+			      const struct dmub_window *cw2,
+			      const struct dmub_window *cw3,
+			      const struct dmub_window *cw4,
+			      const struct dmub_window *cw5,
+			      const struct dmub_window *cw6)
+{
+	union dmub_addr offset;
+
+	offset = cw3->offset;
+
+	REG_WRITE(DMCUB_REGION3_CW3_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW3_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW3_BASE_ADDRESS, cw3->region.base);
+	REG_SET_2(DMCUB_REGION3_CW3_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW3_TOP_ADDRESS, cw3->region.top,
+		  DMCUB_REGION3_CW3_ENABLE, 1);
+
+	offset = cw4->offset;
+
+	REG_WRITE(DMCUB_REGION3_CW4_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW4_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW4_BASE_ADDRESS, cw4->region.base);
+	REG_SET_2(DMCUB_REGION3_CW4_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW4_TOP_ADDRESS, cw4->region.top,
+		  DMCUB_REGION3_CW4_ENABLE, 1);
+
+	offset = cw5->offset;
+
+	REG_WRITE(DMCUB_REGION3_CW5_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW5_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW5_BASE_ADDRESS, cw5->region.base);
+	REG_SET_2(DMCUB_REGION3_CW5_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW5_TOP_ADDRESS, cw5->region.top,
+		  DMCUB_REGION3_CW5_ENABLE, 1);
+
+	REG_WRITE(DMCUB_REGION5_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION5_OFFSET_HIGH, offset.u.high_part);
+	REG_SET_2(DMCUB_REGION5_TOP_ADDRESS, 0,
+		  DMCUB_REGION5_TOP_ADDRESS,
+		  cw5->region.top - cw5->region.base - 1,
+		  DMCUB_REGION5_ENABLE, 1);
+
+	offset = cw6->offset;
+
+	REG_WRITE(DMCUB_REGION3_CW6_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW6_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW6_BASE_ADDRESS, cw6->region.base);
+	REG_SET_2(DMCUB_REGION3_CW6_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW6_TOP_ADDRESS, cw6->region.top,
+		  DMCUB_REGION3_CW6_ENABLE, 1);
+}
+
+void dmub_dcn31_setup_mailbox(struct dmub_srv *dmub,
+			      const struct dmub_region *inbox1)
+{
+	REG_WRITE(DMCUB_INBOX1_BASE_ADDRESS, inbox1->base);
+	REG_WRITE(DMCUB_INBOX1_SIZE, inbox1->top - inbox1->base);
+}
+
+uint32_t dmub_dcn31_get_inbox1_rptr(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_INBOX1_RPTR);
+}
+
+void dmub_dcn31_set_inbox1_wptr(struct dmub_srv *dmub, uint32_t wptr_offset)
+{
+	REG_WRITE(DMCUB_INBOX1_WPTR, wptr_offset);
+}
+
+void dmub_dcn31_setup_out_mailbox(struct dmub_srv *dmub,
+			      const struct dmub_region *outbox1)
+{
+	REG_WRITE(DMCUB_OUTBOX1_BASE_ADDRESS, outbox1->base);
+	REG_WRITE(DMCUB_OUTBOX1_SIZE, outbox1->top - outbox1->base);
+}
+
+uint32_t dmub_dcn31_get_outbox1_wptr(struct dmub_srv *dmub)
+{
+	/**
+	 * outbox1 wptr register is accessed without locks (dal & dc)
+	 * and to be called only by dmub_srv_stat_get_notification()
+	 */
+	return REG_READ(DMCUB_OUTBOX1_WPTR);
+}
+
+void dmub_dcn31_set_outbox1_rptr(struct dmub_srv *dmub, uint32_t rptr_offset)
+{
+	/**
+	 * outbox1 rptr register is accessed without locks (dal & dc)
+	 * and to be called only by dmub_srv_stat_get_notification()
+	 */
+	REG_WRITE(DMCUB_OUTBOX1_RPTR, rptr_offset);
+}
+
+bool dmub_dcn31_is_hw_init(struct dmub_srv *dmub)
+{
+	uint32_t is_hw_init;
+
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_hw_init);
+
+	return is_hw_init != 0;
+}
+
+bool dmub_dcn31_is_supported(struct dmub_srv *dmub)
+{
+	uint32_t supported = 0;
+
+	REG_GET(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE, &supported);
+
+	return supported;
+}
+
+void dmub_dcn31_set_gpint(struct dmub_srv *dmub,
+			  union dmub_gpint_data_register reg)
+{
+	REG_WRITE(DMCUB_GPINT_DATAIN1, reg.all);
+}
+
+bool dmub_dcn31_is_gpint_acked(struct dmub_srv *dmub,
+			       union dmub_gpint_data_register reg)
+{
+	union dmub_gpint_data_register test;
+
+	reg.bits.status = 0;
+	test.all = REG_READ(DMCUB_GPINT_DATAIN1);
+
+	return test.all == reg.all;
+}
+
+uint32_t dmub_dcn31_get_gpint_response(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_SCRATCH7);
+}
+
+union dmub_fw_boot_status dmub_dcn31_get_fw_boot_status(struct dmub_srv *dmub)
+{
+	union dmub_fw_boot_status status;
+
+	status.all = REG_READ(DMCUB_SCRATCH0);
+	return status;
+}
+
+void dmub_dcn31_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmub_srv_hw_params *params)
+{
+	union dmub_fw_boot_options boot_options = {0};
+
+	boot_options.bits.z10_disable = params->disable_z10;
+
+	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
+}
+
+void dmub_dcn31_skip_dmub_panel_power_sequence(struct dmub_srv *dmub, bool skip)
+{
+	union dmub_fw_boot_options boot_options;
+	boot_options.all = REG_READ(DMCUB_SCRATCH14);
+	boot_options.bits.skip_phy_init_panel_sequence = skip;
+	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
+}
+
+void dmub_dcn31_setup_outbox0(struct dmub_srv *dmub,
+			      const struct dmub_region *outbox0)
+{
+	REG_WRITE(DMCUB_OUTBOX0_BASE_ADDRESS, outbox0->base);
+
+	REG_WRITE(DMCUB_OUTBOX0_SIZE, outbox0->top - outbox0->base);
+}
+
+uint32_t dmub_dcn31_get_outbox0_wptr(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_OUTBOX0_WPTR);
+}
+
+void dmub_dcn31_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset)
+{
+	REG_WRITE(DMCUB_OUTBOX0_RPTR, rptr_offset);
+}
+
+uint32_t dmub_dcn31_get_current_time(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_TIMER_CURRENT);
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
new file mode 100644
index 000000000000..2829c3e9a310
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
@@ -0,0 +1,230 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef _DMUB_DCN31_H_
+#define _DMUB_DCN31_H_
+
+#include "dmub_dcn20.h"
+
+struct dmub_srv;
+
+/* DCN31 register definitions. */
+
+#define DMUB_DCN31_REGS() \
+	DMUB_SR(DMCUB_CNTL) \
+	DMUB_SR(DMCUB_CNTL2) \
+	DMUB_SR(DMCUB_SEC_CNTL) \
+	DMUB_SR(DMCUB_INBOX1_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_INBOX1_SIZE) \
+	DMUB_SR(DMCUB_INBOX1_RPTR) \
+	DMUB_SR(DMCUB_INBOX1_WPTR) \
+	DMUB_SR(DMCUB_OUTBOX0_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_OUTBOX0_SIZE) \
+	DMUB_SR(DMCUB_OUTBOX0_RPTR) \
+	DMUB_SR(DMCUB_OUTBOX0_WPTR) \
+	DMUB_SR(DMCUB_OUTBOX1_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_OUTBOX1_SIZE) \
+	DMUB_SR(DMCUB_OUTBOX1_RPTR) \
+	DMUB_SR(DMCUB_OUTBOX1_WPTR) \
+	DMUB_SR(DMCUB_REGION3_CW0_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW1_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW2_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW3_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW4_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW5_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW6_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW7_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW0_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW1_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW2_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW3_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW4_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW5_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW6_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW7_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW0_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW1_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW2_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW3_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW4_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW5_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW6_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW7_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW0_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW1_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW2_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW3_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW4_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW5_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW6_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW7_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION4_OFFSET) \
+	DMUB_SR(DMCUB_REGION4_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION4_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION5_OFFSET) \
+	DMUB_SR(DMCUB_REGION5_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION5_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_SCRATCH0) \
+	DMUB_SR(DMCUB_SCRATCH1) \
+	DMUB_SR(DMCUB_SCRATCH2) \
+	DMUB_SR(DMCUB_SCRATCH3) \
+	DMUB_SR(DMCUB_SCRATCH4) \
+	DMUB_SR(DMCUB_SCRATCH5) \
+	DMUB_SR(DMCUB_SCRATCH6) \
+	DMUB_SR(DMCUB_SCRATCH7) \
+	DMUB_SR(DMCUB_SCRATCH8) \
+	DMUB_SR(DMCUB_SCRATCH9) \
+	DMUB_SR(DMCUB_SCRATCH10) \
+	DMUB_SR(DMCUB_SCRATCH11) \
+	DMUB_SR(DMCUB_SCRATCH12) \
+	DMUB_SR(DMCUB_SCRATCH13) \
+	DMUB_SR(DMCUB_SCRATCH14) \
+	DMUB_SR(DMCUB_SCRATCH15) \
+	DMUB_SR(DMCUB_GPINT_DATAIN1) \
+	DMUB_SR(CC_DC_PIPE_DIS) \
+	DMUB_SR(MMHUBBUB_SOFT_RESET) \
+	DMUB_SR(DCN_VM_FB_LOCATION_BASE) \
+	DMUB_SR(DCN_VM_FB_OFFSET) \
+	DMUB_SR(DMCUB_TIMER_CURRENT)
+
+#define DMUB_DCN31_FIELDS() \
+	DMUB_SF(DMCUB_CNTL, DMCUB_ENABLE) \
+	DMUB_SF(DMCUB_CNTL, DMCUB_TRACEPORT_EN) \
+	DMUB_SF(DMCUB_CNTL2, DMCUB_SOFT_RESET) \
+	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_SEC_RESET) \
+	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_MEM_UNIT_ID) \
+	DMUB_SF(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW1_TOP_ADDRESS, DMCUB_REGION3_CW1_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW1_TOP_ADDRESS, DMCUB_REGION3_CW1_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW2_TOP_ADDRESS, DMCUB_REGION3_CW2_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW2_TOP_ADDRESS, DMCUB_REGION3_CW2_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW3_TOP_ADDRESS, DMCUB_REGION3_CW3_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW3_TOP_ADDRESS, DMCUB_REGION3_CW3_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW4_TOP_ADDRESS, DMCUB_REGION3_CW4_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW4_TOP_ADDRESS, DMCUB_REGION3_CW4_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW5_TOP_ADDRESS, DMCUB_REGION3_CW5_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW5_TOP_ADDRESS, DMCUB_REGION3_CW5_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW7_TOP_ADDRESS, DMCUB_REGION3_CW7_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW7_TOP_ADDRESS, DMCUB_REGION3_CW7_ENABLE) \
+	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_ENABLE) \
+	DMUB_SF(DMCUB_REGION5_TOP_ADDRESS, DMCUB_REGION5_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION5_TOP_ADDRESS, DMCUB_REGION5_ENABLE) \
+	DMUB_SF(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE) \
+	DMUB_SF(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET) \
+	DMUB_SF(DCN_VM_FB_LOCATION_BASE, FB_BASE) \
+	DMUB_SF(DCN_VM_FB_OFFSET, FB_OFFSET)
+
+struct dmub_srv_dcn31_reg_offset {
+#define DMUB_SR(reg) uint32_t reg;
+	DMUB_DCN31_REGS()
+#undef DMUB_SR
+};
+
+struct dmub_srv_dcn31_reg_shift {
+#define DMUB_SF(reg, field) uint8_t reg##__##field;
+	DMUB_DCN31_FIELDS()
+#undef DMUB_SF
+};
+
+struct dmub_srv_dcn31_reg_mask {
+#define DMUB_SF(reg, field) uint32_t reg##__##field;
+	DMUB_DCN31_FIELDS()
+#undef DMUB_SF
+};
+
+struct dmub_srv_dcn31_regs {
+	const struct dmub_srv_dcn31_reg_offset offset;
+	const struct dmub_srv_dcn31_reg_mask mask;
+	const struct dmub_srv_dcn31_reg_shift shift;
+};
+
+extern const struct dmub_srv_dcn31_regs dmub_srv_dcn31_regs;
+
+/* Hardware functions. */
+
+
+void dmub_dcn31_init(struct dmub_srv *dmub);
+
+void dmub_dcn31_reset(struct dmub_srv *dmub);
+
+void dmub_dcn31_reset_release(struct dmub_srv *dmub);
+
+void dmub_dcn31_backdoor_load(struct dmub_srv *dmub,
+			      const struct dmub_window *cw0,
+			      const struct dmub_window *cw1);
+
+void dmub_dcn31_setup_windows(struct dmub_srv *dmub,
+			      const struct dmub_window *cw2,
+			      const struct dmub_window *cw3,
+			      const struct dmub_window *cw4,
+			      const struct dmub_window *cw5,
+			      const struct dmub_window *cw6);
+
+void dmub_dcn31_setup_mailbox(struct dmub_srv *dmub,
+			      const struct dmub_region *inbox1);
+
+uint32_t dmub_dcn31_get_inbox1_rptr(struct dmub_srv *dmub);
+
+void dmub_dcn31_set_inbox1_wptr(struct dmub_srv *dmub, uint32_t wptr_offset);
+
+void dmub_dcn31_setup_out_mailbox(struct dmub_srv *dmub,
+			      const struct dmub_region *outbox1);
+
+uint32_t dmub_dcn31_get_outbox1_wptr(struct dmub_srv *dmub);
+
+void dmub_dcn31_set_outbox1_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
+
+bool dmub_dcn31_is_hw_init(struct dmub_srv *dmub);
+
+bool dmub_dcn31_is_supported(struct dmub_srv *dmub);
+
+void dmub_dcn31_set_gpint(struct dmub_srv *dmub,
+			  union dmub_gpint_data_register reg);
+
+bool dmub_dcn31_is_gpint_acked(struct dmub_srv *dmub,
+			       union dmub_gpint_data_register reg);
+
+uint32_t dmub_dcn31_get_gpint_response(struct dmub_srv *dmub);
+
+void dmub_dcn31_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmub_srv_hw_params *params);
+
+void dmub_dcn31_skip_dmub_panel_power_sequence(struct dmub_srv *dmub, bool skip);
+
+union dmub_fw_boot_status dmub_dcn31_get_fw_boot_status(struct dmub_srv *dmub);
+
+void dmub_dcn31_setup_outbox0(struct dmub_srv *dmub,
+			      const struct dmub_region *outbox0);
+
+uint32_t dmub_dcn31_get_outbox0_wptr(struct dmub_srv *dmub);
+
+void dmub_dcn31_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
+
+uint32_t dmub_dcn31_get_current_time(struct dmub_srv *dmub);
+
+#endif /* _DMUB_DCN31_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index f3f00d36e973..681500f42c91 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -31,6 +31,9 @@
 #include "dmub_dcn301.h"
 #include "dmub_dcn302.h"
 #include "dmub_dcn303.h"
+#ifdef CONFIG_DRM_AMD_DC_DCN3_1
+#include "dmub_dcn31.h"
+#endif
 #include "os_types.h"
 /*
  * Note: the DMUB service is standalone. No additional headers should be
@@ -203,6 +206,40 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 			funcs->setup_windows = dmub_dcn30_setup_windows;
 		}
 		break;
+#ifdef CONFIG_DRM_AMD_DC_DCN3_1
+
+	case DMUB_ASIC_DCN31:
+		funcs->reset = dmub_dcn31_reset;
+		funcs->reset_release = dmub_dcn31_reset_release;
+		funcs->backdoor_load = dmub_dcn31_backdoor_load;
+		funcs->setup_windows = dmub_dcn31_setup_windows;
+		funcs->setup_mailbox = dmub_dcn31_setup_mailbox;
+		funcs->get_inbox1_rptr = dmub_dcn31_get_inbox1_rptr;
+		funcs->set_inbox1_wptr = dmub_dcn31_set_inbox1_wptr;
+		funcs->setup_out_mailbox = dmub_dcn31_setup_out_mailbox;
+		funcs->get_outbox1_wptr = dmub_dcn31_get_outbox1_wptr;
+		funcs->set_outbox1_rptr = dmub_dcn31_set_outbox1_rptr;
+		funcs->is_supported = dmub_dcn31_is_supported;
+		funcs->is_hw_init = dmub_dcn31_is_hw_init;
+		funcs->set_gpint = dmub_dcn31_set_gpint;
+		funcs->is_gpint_acked = dmub_dcn31_is_gpint_acked;
+		funcs->get_gpint_response = dmub_dcn31_get_gpint_response;
+		funcs->get_fw_status = dmub_dcn31_get_fw_boot_status;
+		funcs->enable_dmub_boot_options = dmub_dcn31_enable_dmub_boot_options;
+		funcs->skip_dmub_panel_power_sequence = dmub_dcn31_skip_dmub_panel_power_sequence;
+		//outbox0 call stacks
+		funcs->setup_outbox0 = dmub_dcn31_setup_outbox0;
+		funcs->get_outbox0_wptr = dmub_dcn31_get_outbox0_wptr;
+		funcs->set_outbox0_rptr = dmub_dcn31_set_outbox0_rptr;
+
+		if (asic == DMUB_ASIC_DCN31) {
+			dmub->regs_dcn31 = &dmub_srv_dcn31_regs;
+		}
+
+		funcs->get_current_time = dmub_dcn31_get_current_time;
+
+		break;
+#endif
 
 	default:
 		return false;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
