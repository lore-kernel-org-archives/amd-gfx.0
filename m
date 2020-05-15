Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8473C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC8420657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3FuhpWC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC8420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A8F56ED24;
	Fri, 15 May 2020 18:14:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 876EF6ED25
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImSIG09GFBDKnzsZruCSC9Lo95GlYHios1rceTkZi/KL21yaN0rnYCGgFPYFke5FIEF+Fc6qxutj0a3prrnRheK1fvGklXkQXuvcBdHTBRZLcGZeU7tyHPPbv4C+WpWp+FZGws6CfOOaQOFqSm01Ma5LVgU65UtSb5FhSjGRQg8T2tklt8G9q8zGOSm2IvSYdGzRru2dLOMEj+Fb8lX2FSn12zHjG1TesKHM+sMfhHUU57uon1EABFl5uEn2FrfgB/PNN81+Gweik2IC8gy/lZSqsinE99J9YLaspgmhRZvs7+p3iDPWu1AHoQ7iHFBOWw0h5uQ20T03wmhtTZ3w0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDieuEl8J4bW5i1NHwuqPXOqIq7Zl58Onhv5t8/7MhM=;
 b=gfZzsrY/XeR4JsPrJrWzIx30HeDajaq/i/BewGAf4jxEcxMwvtEy6CeDFquICerndHshgRyba2gfFqemXx5c8NFVsRqYnjL3aDoRUKuhEizQX1UyqO3XQQb1PksQ7P/QmfJjRQKPIQfXrSPA8ZpaNBRuQi5CUww05PfYQ20SxDNJ3HW6eBslQICUIbePJxIzL5YgZYACACSsKQ/5NRDDVMobob+2tdJDz4/Vd1/kbdzMVVI7BUC231PaOQlPQBGTqk+6cs4C8VAtYfHP0wrIVIeUyH3Hn4k6wEAiL02gpNZDEq6V2z5bT0n/MxHo6JW55W2+32Ekhpol6H5Nb63pNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDieuEl8J4bW5i1NHwuqPXOqIq7Zl58Onhv5t8/7MhM=;
 b=3FuhpWC4WZh72OTITSu8KTDMlQkoEfMIuyY7wEkbkYakZVgHmO3iQdpFQZ7InF82MACvL6s9OEi6mePGja14fQrPZXyHrfjPhkTkCcQuPkaj2h6Rlw1jvEUKiCQA98QywwrJcUv1ndNSwvcV9URz2Q6pyh/jnr/yaR6bhQe/IXM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 15 May
 2020 18:13:57 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:57 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/27] drm/amd/display: correct rn NUM_VMID
Date: Fri, 15 May 2020 14:13:06 -0400
Message-Id: <20200515181315.1237251-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:56 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 927e9a5f-cc5d-4d12-fea1-08d7f8fbbbca
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3848C0F68ADD74A8757C645E98BD0@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zeeej5VtbVADCxt6LR4q9NRYYi0JawA0inxcelkEBhNO/Bt5kmBZ3NKL019ywKlfYOvL6lQmE9AGaxuUOP5DNF55dL3+dbjBxpTIneG4Ye0pDk7RQNqpJqc5Y9/MADTveOC9yhVSP/hc54agW77IQvbSBaILY8APNbWQcIUMQNWu8mdLLa/AY11aNIMSVo+QYNjTSgDNSEWttnBdNvCAH8UtI3IHCIg7Su5V+0qf6WdacHxIl3NLFzMIO30aDrrQOLGsnjqv+2pCwwsVuJKvihZKD8ueGayLlfOP6eU9QFt1tMDWBlyLe7AiLX9rRxlS50K9Go+guGSkZDDv3GqIGVX9vQc20JOBI+FCdhaUHFVJTX3hdtm8ZA2waFNdrfCHlr5qaDWdUydbfc1pefc5jnsAUAk2Jh4kE+R94lcFpKPX4tlebG0LTZbpXX+DBSRX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(54906003)(86362001)(2906002)(186003)(8936002)(52116002)(6506007)(6512007)(8676002)(36756003)(316002)(5660300002)(16526019)(4326008)(6916009)(66556008)(478600001)(1076003)(66946007)(6486002)(66476007)(6666004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MPW+HbBHxSgEXet92MB9ScoD3+eXImKgSHFh9AweDOVX6Wb8Wi1q7cGhb9kiIaN7jwcTcJBRw6B+xzBv0lQ27VJNUGdDZE95l1hW2inZ+paap5/1gI880kd30X15bWGQjRw4CMAPpOHtjVWssqowsDT17bzurmlZNiz8aajYT/nH+itV36lAUF3TACX1A9uhiHAFa8DSspjuFFMcsBw3YsbImxOTFK2efsCg4C7cmsLAl6NbtzG8R7z12C3bXxBzohkematHpmN+D4dMc85igZkvxZ7yDyhkzl4k/OYk/vIjkgo3suEeNpb2n1nDMxFeuvPikyM3mq2SoexuMWk4Sz1LQ6Qc0hZWjhP6wi8r3JY+btQtfPERmGLD/dCykEaG0G4da0wS6ybAMwvkKy6IYMDjPbYz6Agu4nXNXlQcaBLf3RNUL1UOxj2/SpIuaqwauxA1jDcepwVxGRNI/8YgUn1eIl2llJhK0Z72FhnL4bayjAzD92Pafh8tDCM8eHmy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927e9a5f-cc5d-4d12-fea1-08d7f8fbbbca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:56.9323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MD+P+1i28pYQ8MAQ1DNsZAuMOc06ahBeeUsrg4JZ2jipr8VWZcqIiKZQ/OTae1c1U4hD5VMvs++b+oNU8Z83Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eric Bernstein <Eric.Bernstein@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Save the correct num vmid during resource creation and fix RN gpuvm
level from 1 to 16 vmid entries.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c   | 7 +------
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/modules/vmid/vmid.c       | 7 +++++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h
index 501532dd523a..c478213ba7ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h
@@ -80,6 +80,7 @@ struct dcn20_hubbub {
 	const struct dcn_hubbub_mask *masks;
 	unsigned int debug_test_index_pstate;
 	struct dcn_watermark_set watermarks;
+	int num_vmid;
 	struct dcn20_vmid vmid[16];
 	unsigned int detile_buf_size;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
index 5e2d14b897af..129f0b62f751 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
@@ -49,11 +49,6 @@
 #define FN(reg_name, field_name) \
 	hubbub1->shifts->field_name, hubbub1->masks->field_name
 
-#ifdef NUM_VMID
-#undef NUM_VMID
-#endif
-#define NUM_VMID 16
-
 static uint32_t convert_and_clamp(
 	uint32_t wm_ns,
 	uint32_t refclk_mhz,
@@ -138,7 +133,7 @@ int hubbub21_init_dchub(struct hubbub *hubbub,
 
 	dcn21_dchvm_init(hubbub);
 
-	return NUM_VMID;
+	return hubbub1->num_vmid;
 }
 
 bool hubbub21_program_urgent_watermarks(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 419cdde624f5..f00a56835084 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -805,7 +805,7 @@ static const struct resource_caps res_cap_rn = {
 		.num_pll = 5,  // maybe 3 because the last two used for USB-c
 		.num_dwb = 1,
 		.num_ddc = 5,
-		.num_vmid = 1,
+		.num_vmid = 16,
 		.num_dsc = 3,
 };
 
@@ -1295,6 +1295,7 @@ static struct hubbub *dcn21_hubbub_create(struct dc_context *ctx)
 		vmid->shifts = &vmid_shifts;
 		vmid->masks = &vmid_masks;
 	}
+	hubbub->num_vmid = res_cap_rn.num_vmid;
 
 	return &hubbub->base;
 }
diff --git a/drivers/gpu/drm/amd/display/modules/vmid/vmid.c b/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
index 00f132f8ad55..61ee4be35d27 100644
--- a/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
+++ b/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
@@ -112,9 +112,12 @@ uint8_t mod_vmid_get_for_ptb(struct mod_vmid *mod_vmid, uint64_t ptb)
 			evict_vmids(core_vmid);
 
 		vmid = get_next_available_vmid(core_vmid);
-		add_ptb_to_table(core_vmid, vmid, ptb);
+		if (vmid != -1) {
+			add_ptb_to_table(core_vmid, vmid, ptb);
 
-		dc_setup_vm_context(core_vmid->dc, &va_config, vmid);
+			dc_setup_vm_context(core_vmid->dc, &va_config, vmid);
+		} else
+			ASSERT(0);
 	}
 
 	return vmid;
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
