Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF18C282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76F082082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="22jOrx4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F082082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D2A46EA3B;
	Fri, 10 Jan 2020 14:47:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1D96EA38
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y47oGaoyLwHLGJ91kf7PokroewfS0+oRQp8Fz7KKezDBbe1zLy5Zc2XSj5vsEFEm+EcrhSKT3iCA1C61awVv8Zf1uhvGDQd54AvAEkbpCRBrs1CyOc5Sbzh2ycv7QvG/qYSOOnIG9hQ2Hxcf/f8DOb1KClhzpbswT/jiuJqLwkYct1w59lphScRGP5HfNNe+bYBSa+F7lvpWAZxbU374dA+tm9UdJJ61S9EJWHe/rRJju/O9//muh16lHr24NbrBpcc8yOL1wg59DPu6ha2HGz68eW/WVV/YY+LyW8ZPl26CGE37m38vguirGVZeJQtZVuOUsVKOCxbjq4szRoOwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxJjcRC3rG5fwZWNJzXfFbh7Fgpe2+XZ0ZKAhCY//Cc=;
 b=WF+1NrX9Uy0y2F0CppRShkgL3GkkBDG7bBak8pY5/lDYxMeqVcwCwV1WwCFpoYEjmVfWwanWRhqaP78ZnyTRWtZkv4bdihtIgnz6sYEC1/X/hICpArND2Ox9Mp+2FxjCozzkP2B4aeey/Z7gFh7JjqE5+us7jaeDww+VVMbmAfD3bRiYYvXi51O2hsRH/UsvyQa2D4mw5/6qPRYEwd4hTSc5R3x+nKlKSmJvQ5nO0/1tbjyfo0dZsjpwdrPaQdtLTXfnYockm3DthHL9Qci2U6kpfjGkbH+y9E5wZyYI4k+ZNpsE1+rHL3ND5JO6Mcx80cvRiZMSeiU6s9UyMQd3qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxJjcRC3rG5fwZWNJzXfFbh7Fgpe2+XZ0ZKAhCY//Cc=;
 b=22jOrx4povd3NsFsiR3XgwWPeUPo+QctvCQUymjjLGv6H9MFFaPWCyI7X8COPNaD7bHzZ6+1EhnpXsk9EkvHn+J7z3xax9PdQrJWk9zlbQkXXJwTjlRIHHQYhiX+CRzDQRNJbXs4So1FT3TV2aUW9HtQLj5VWoVpWK9KAnE2Fbg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:28 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:28 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/43] drm/amd/display: Read inst_fb data back during DMUB
 loading
Date: Fri, 10 Jan 2020 09:46:21 -0500
Message-Id: <20200110144655.55845-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:27 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cfb27bdd-a789-402f-7e50-08d795dc03bb
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB252415979C2FF8686F433B4498380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LlqmhEE1+MkiD5wZm278/Pcpy1wn56i43po2qk0lRrcU3G1P/ooSYnTzZRP/rbLRZLRAWz9o5qBHc/vfzOL5QVWnKeQtKc9C00TOWP36UYIx0ISPiw1zp7xLSyXBYerNiboDEB7jGCk1EAVz2NIZBBbgp4oHdtLGnZlZPV0z1Wp0z2ZHG0YPEfx9qPiyvlIocxvfxSub2ZLnxYyToc5NpkPJ3+pgZRnHkoGcSvtctUgrkQoFnJrm8z799KLKrXGukkhEVherpfkd10KCIWv1UKf9MW3Vb+SgFFBCqH6s8Ida6kaaWGU+EhQHIPvkcGeFMzIS/llDmuXcQ37creYS+BgXYnyICYhWuJHVFSYHvJ2U0dAMk6H33YH1LnNMW8coECbqbHHVnlEmsJUerBbScrqZOXPDElAKYjgM+Oc61NuFzCs5eTjCc1ofISQrEPgg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb27bdd-a789-402f-7e50-08d795dc03bb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:28.6146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpIDgg9ygnF9kHnMeliDxEWc0NL54DPyVeX8IP1eN+X8x6yvT8KnNIPpFyJcbekLF1oZNWusxv1YDLFQDurbQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The inst firmware isn't necessarily fully flushed to framebuffer
memory and the DMCUB can hang due to invalid inst being parsed.

[How]
Like the fix to flush ringbuffer commands before updating the inbox
write pointer we need to read back inst memory before writing the
CW0 registers.

Add a helper to read 64-byte chunks to avoid a large temporary buffer.
Read the remaining leftover bytes if the inst_fb isn't fully aligned.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 23ca1fe97757..dee676335d73 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -67,6 +67,26 @@ static inline uint32_t dmub_align(uint32_t val, uint32_t factor)
 	return (val + factor - 1) / factor * factor;
 }
 
+static void dmub_flush_buffer_mem(const struct dmub_fb *fb)
+{
+	const uint8_t *base = (const uint8_t *)fb->cpu_addr;
+	uint8_t buf[64];
+	uint32_t pos, end;
+
+	/**
+	 * Read 64-byte chunks since we don't want to store a
+	 * large temporary buffer for this purpose.
+	 */
+	end = fb->size / sizeof(buf) * sizeof(buf);
+
+	for (pos = 0; pos < end; pos += sizeof(buf))
+		dmub_memcpy(buf, base + pos, sizeof(buf));
+
+	/* Read anything leftover into the buffer. */
+	if (end < fb->size)
+		dmub_memcpy(buf, base + pos, fb->size - end);
+}
+
 static const struct dmub_fw_meta_info *
 dmub_get_fw_meta_info(const uint8_t *fw_bss_data, uint32_t fw_bss_data_size)
 {
@@ -329,6 +349,13 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 		cw1.region.base = DMUB_CW1_BASE;
 		cw1.region.top = cw1.region.base + stack_fb->size - 1;
 
+		/**
+		 * Read back all the instruction memory so we don't hang the
+		 * DMCUB when backdoor loading if the write from x86 hasn't been
+		 * flushed yet. This only occurs in backdoor loading.
+		 */
+		dmub_flush_buffer_mem(inst_fb);
+
 		if (params->load_inst_const && dmub->hw_funcs.backdoor_load)
 			dmub->hw_funcs.backdoor_load(dmub, &cw0, &cw1);
 	}
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
