Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36116C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF41D64E38
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF41D64E38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D6146E44A;
	Fri, 26 Feb 2021 22:37:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2906E6E44A
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 22:37:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJWLSd4YH/odhUtpKD9DTX5obqzBSsDfjGygc4PokiVdpFLPc9BlyWqtgRLtP+EA/8FKb3/f78GPzAMhwxMd4VPUxH/IL3t54DZwTDxVE/Y1hLjUYNwpnATljqVWX1PT3W2VMG/mat0IjEmxOr7HV6nbdWQrZkmEWzxrsGl9QRZQu+vsCSy7+JWvhf4WBd7ryHzIzS2bbd+2SH2VltFkRhCm8FrAMsQDlDaU2vEEcxsOWT4aWYYNJo4CRq1g98NYdEfO8cseYEc06r3a18oXrtj0Qm5bKQ9IW4+3yCGoZvhbvAegdTiEl47iqx7ZWxsZtMQNxyCZUVz5TMmiVi9SJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0jR9A7Q//bhXZMhc/eIShfgOoFQa0B8DrJmVAxpuqo=;
 b=Fa4TKGyqr5bm6In1pOYwezDYzA4t0N+T16ttYW7LiMIqHLp0rRJXQ4WcEI3OxS26uR2UJFW8YNyyuxW0ImVoax/UDjFtSih4l51FNQ3bHhADFRbNgZrGgJf6wqwCEuag/seyMVA25O51Lqg93aGG/bd3FfYNXwrnOcIkZkx4/8zNvidOyuVsuyXVdcNtxAWC74vrK3Hu9ypTazpd47HeDcA6sYL4Op8uMX160JfyqomoQfh7zbXLQv4w3B6UTQWHhkYpZaZ+qYV5pse3iyRp2mv2J8LLIhQtZXMhpJUKSnfKG+R6qLWhAru2mZvppNRpizEeeEKKsS6gbPu34aqtfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0jR9A7Q//bhXZMhc/eIShfgOoFQa0B8DrJmVAxpuqo=;
 b=IGgAIFOkX0gLJi02aHyZjiH2BoIqNzwi7vHLSmmAam73xXEqcQ+0FQkobCHH/PzM/bxe6KUxG8Hv00Vj20Js1kghhM8nK659t6h7lM0MCfuUn3Fk6U69tDvkAKlADzIym/hOFBleBbASJAw9VmVgBBGPlynj1syJ+LWNVq8E9zw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Fri, 26 Feb 2021 22:37:42 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 22:37:42 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/11] drm/amd/display: Add flag for building infopacket
Date: Fri, 26 Feb 2021 17:36:56 -0500
Message-Id: <20210226223704.400472-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
References: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf]
X-ClientProxiedBy: BN9PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:408:fc::12) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf)
 by BN9PR03CA0067.namprd03.prod.outlook.com (2603:10b6:408:fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Fri, 26 Feb 2021 22:37:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71f7fde7-0d44-4532-d696-08d8daa720f1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1883:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1883144EFCBB3743D3DB2AD0989D9@DM5PR12MB1883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C04Y4onbNgdHuLpLTpfjmFGR7q3J5KKI0RTXrPMtclbsvySo6Vg7m1kIWrxgVxr8J5dh8LlXlty4kIm0am7biggchGGomJqNElki1OZc8awpAoicG01ddSrdyacig7MLKHIEgPS8Mey9ofL+1An4uKy0COeQ8OZdZHdDmObe5lxb/x48wXfsEYNzdlqz+XUadoceZtgC06xL6vmhl8TIFdMrNchRhPhNUgnbiwNELcGDGBEx3RckZVeb9SRvKT/7gJeCXQlA0XMKdMFiYYrx/cWG9DZZvGUCxD9QfANdmhoIROI+YKNONBkmWOfqwsBkLZWVjNOUNiKL65JFAXZzQUIFf3RWuYJCmNh/UAW/BwRhfCVHvjifluT1PZmGqVRDCzZ0MjHCLYxBsQL5BNE5UO9m6a9TeVOMsJah6zrQ+8uo0psoxcGTosbIkSehmvtIsnZaigUQE6LhDqHRJsjBks5jsqozOHBQVJsM+cCYmHs1ubBB30QRDSqhYlGerkB/+4upLInd+xvH5Yp7Uc7R0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(2906002)(6916009)(2616005)(5660300002)(66946007)(316002)(16526019)(186003)(1076003)(54906003)(83380400001)(36756003)(6486002)(478600001)(66556008)(52116002)(4326008)(6506007)(66476007)(6512007)(8936002)(8676002)(6666004)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MmTaTGUvYxZlCPvHIh2sGHI2JdBoWumhjZ6h3dZZuq02i2mJt5rK5ueXi2z2?=
 =?us-ascii?Q?ziMpnzp2NtNUkDDRMsQL4VjoaIjUK0Gb5J/T3/9+wRXTMeCTA+YHDubHpJN4?=
 =?us-ascii?Q?UHwb7uY7hzvSpz2LQCix1bwah5IIFU0pZePCDnfxHgZgdZ+oD87lklsYwKdB?=
 =?us-ascii?Q?qdr9wMghGoC3yK/wO0vQsa6u7/0DdWpkSZVyFcNf7uGPum6095rQilTdev6k?=
 =?us-ascii?Q?bMFXgUzKKOTSsHF19E6TE1ZT+/1dE+3OPriXUd9k/rpsuCgfoFbe9mRYmymk?=
 =?us-ascii?Q?5vlmts7ZdN3J5WiO7/uZjLpGEkIwVznzkfOyrccTjhMeZiP9pN/UVcnHob98?=
 =?us-ascii?Q?2lt9NyfyeyHP9mfNlN5iuJzdUl0eiewhpCmmtkasIefFjm4UIdmHiWGyOrMA?=
 =?us-ascii?Q?lOkjIDRtLfmf3/MkTGULCcpHNoBzU/Mztk83kS0RsRBOv04bFuflmGeUT4H/?=
 =?us-ascii?Q?/qym6/FOLr9BMSY0xPyBO8RObT4Kc8AaxMNkpIviSoiBS3Ou6DhdjorM0b7/?=
 =?us-ascii?Q?HtbhetFw9tLGQQ3HB8aTaJu+IsYbWyy3Ra8nuMfIMMIXXAcv/qTO/leotcSY?=
 =?us-ascii?Q?wUsninLhffoolsbBCUMSKxWIySikuhyVmoGkVUv8pSCQ5/8kgWm1j7yHa012?=
 =?us-ascii?Q?1GHVFSfP9R8qplxyX5eW3iKysIWSeVdM/m9kZ9zOjCMErigvV06GAfY1sF22?=
 =?us-ascii?Q?hBykMSOkPEJaOQHe0/A2dvQrqrVPgutjd+SnG390syJPNjeQaV+6lZ5S5ThA?=
 =?us-ascii?Q?XDklTgPJUoWfHbHiqtx9JJADM+yzaQB/NI6VX5OpzOj/FGrHqDneg2Ll6Dpk?=
 =?us-ascii?Q?gz9eNSGUx647A33R10HlqOxOjGO0CslOi9vNFiCGZEhKpEa/19IVS1W8Gxv6?=
 =?us-ascii?Q?TdEoXjtGGnhcFzsek5fL36hQP5RlEZauIxiqZWVkIBNJ2mvwXUr+H8ZqtdnW?=
 =?us-ascii?Q?+KYT2E7Vi1TRaSnaHq4asFcfK9iglR3vmRvLeu52huBdE90z3FrOXV5a1SAc?=
 =?us-ascii?Q?EJ5Jyb9tvK0ZmH1gr+LAKwFq+EtqAFvaFc8O6uDb9rY4PteRyRRQaJmRw3OQ?=
 =?us-ascii?Q?2UZpIfk+XOEae50VQmgaZc1wL4n4nOE+8C1TyxDuI8u6eI/agRY4KPojzUIa?=
 =?us-ascii?Q?r0xUBlgPCtHXKLZrlDatdb6JkLjAgm07Y1ms5sxwmQ9AzdWu6L66MiaXjkOj?=
 =?us-ascii?Q?otyNs7b2+XJoGh5uVFf9xpmVYizD9lkwvKY4Hr3s28rd2vro3XMp582T+r+s?=
 =?us-ascii?Q?beEZj9dbnXXsdsWRIGI+oBvxU1lVRDzwrCj3S+pCh6Y86NWdRF2bYkZBzokz?=
 =?us-ascii?Q?058HMUT3bLBORxXTDRlNqB6t7sYpyD2J/GCifEU/fn8uUZ7Qb3d7TxXGX+G/?=
 =?us-ascii?Q?3VSztiaK0471AuzxFWGLYph+vjtL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f7fde7-0d44-4532-d696-08d8daa720f1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 22:37:42.4206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRiiLOm7Sl9FSxyAv4jkXVAf/EOowN+MHWa3Hmu75hDAH4UkSfrClPofjc/k+1UaZoiTV34I/iA9Nep7k7XZuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, "Max.Tseng" <Max.Tseng@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Max.Tseng" <Max.Tseng@amd.com>

[why]
Add flag to build infopacket in SDP v1.3 format

Signed-off-by: Max.Tseng <Max.Tseng@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 ++-
 .../amd/display/modules/freesync/freesync.c   | 28 +++++++++++++++++--
 .../amd/display/modules/inc/mod_freesync.h    |  3 +-
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d639c4b52400..bd77519440e3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7852,6 +7852,7 @@ static void update_freesync_state_on_stream(
 	struct amdgpu_device *adev = dm->adev;
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(new_crtc_state->base.crtc);
 	unsigned long flags;
+	bool pack_sdp_v1_3 = false;
 
 	if (!new_stream)
 		return;
@@ -7893,7 +7894,8 @@ static void update_freesync_state_on_stream(
 		&vrr_params,
 		PACKET_TYPE_VRR,
 		TRANSFER_FUNC_UNKNOWN,
-		&vrr_infopacket);
+		&vrr_infopacket,
+		pack_sdp_v1_3);
 
 	new_crtc_state->freesync_timing_changed |=
 		(memcmp(&acrtc->dm_irq_params.vrr_params.adjust,
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 4762273b5bb9..e5f9d7704a63 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -903,12 +903,31 @@ static void build_vrr_infopacket_v3(enum signal_type signal,
 	infopacket->valid = true;
 }
 
+static void build_vrr_infopacket_sdp_v1_3(enum vrr_packet_type packet_type,
+										struct dc_info_packet *infopacket)
+{
+	uint8_t idx = 0, size = 0;
+
+	size = ((packet_type == PACKET_TYPE_FS_V1) ? 0x08 :
+			(packet_type == PACKET_TYPE_FS_V3) ? 0x10 :
+												0x09);
+
+	for (idx = infopacket->hb2; idx > 1; idx--) // Data Byte Count: 0x1B
+		infopacket->sb[idx] = infopacket->sb[idx-1];
+
+	infopacket->sb[1] = size;                         // Length
+	infopacket->sb[0] = (infopacket->hb3 >> 2) & 0x3F;//Version
+	infopacket->hb3   = (0x13 << 2);                  // Header,SDP 1.3
+	infopacket->hb2   = 0x1D;
+}
+
 void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 		const struct dc_stream_state *stream,
 		const struct mod_vrr_params *vrr,
 		enum vrr_packet_type packet_type,
 		enum color_transfer_func app_tf,
-		struct dc_info_packet *infopacket)
+		struct dc_info_packet *infopacket,
+		bool pack_sdp_v1_3)
 {
 	/* SPD info packet for FreeSync
 	 * VTEM info packet for HdmiVRR
@@ -941,6 +960,12 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 	default:
 		build_vrr_infopacket_v1(stream->signal, vrr, infopacket);
 	}
+
+	if (true == pack_sdp_v1_3 &&
+		true == dc_is_dp_signal(stream->signal) &&
+		packet_type != PACKET_TYPE_VRR &&
+		packet_type != PACKET_TYPE_VTEM)
+		build_vrr_infopacket_sdp_v1_3(packet_type, infopacket);
 }
 
 void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
@@ -1304,4 +1329,3 @@ bool mod_freesync_is_valid_range(uint32_t min_refresh_cap_in_uhz,
 
 	return true;
 }
-
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
index c80fc10d732c..b64cd5bdc7b5 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
@@ -150,7 +150,8 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 		const struct mod_vrr_params *vrr,
 		enum vrr_packet_type packet_type,
 		enum color_transfer_func app_tf,
-		struct dc_info_packet *infopacket);
+		struct dc_info_packet *infopacket,
+		bool pack_sdp_v1_3);
 
 void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 		const struct dc_stream_state *stream,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
