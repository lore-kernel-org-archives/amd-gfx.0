Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDF0C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 11:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CB920658
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 11:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fCoW9Goh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CB920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B723F6E5BB;
	Wed, 19 Feb 2020 11:56:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E87B6E5BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 11:56:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zaeoj5U75djdcAKmmUa2M+NeoWlq7WzdQJxSmiqgqMH26Mu6PbK+qvTXdZujjLUWvwPeRP2PhGVc5hYT/PPmPZ4UKxr54rRIhN1YSuSO8+y6lecq2k6RS4/+a2klcwAMYwWArXYdbRCExCCf8dXvwdOYNJFEQ+cp5cFcdrGij4ReVIi97pVFQlCxXa6Yk7Qzm4UBS/2dcHGDN2nb4snyCwrBXXN3PAKPdW1/SBe1jw7planyxaSSEbF20IdAUmXZdBUtoji0ugIkhgOsESGD2QJjlotY6duPxqGwD2YUNG82LpN7Sk7aKw7TI3ngGDIMPU4pYKvZJn8F4yohS+obWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MZxHhm2EgZiuQm7VLv6facHJP4TdX9FZclS+jm66L4=;
 b=RECnrAgR/AhjWknubh6gNZ4M7UrlK3EIc7FeU0c4dtRbgVfm62sUTkpYZYVz1v3awimi56+8rDaFvQy0aZqeK96l9A1YKW5xk9JxXttR6n3wOWlV6XjgYPA0Brg+47d11xt9kfZKwsHE3UABL6PMTbwz0PqIb77e8YfQTDzeBZ6gCdFr6rJ4xqdAlmhUsZDc8nheUDROvWF9D36O8UKGwaXdJQCSe9JEUQ9xDTfgurtY+AHlb1d7ZYt6A7Z4u5kA3l6rkGgTi/gXGCn4hKYzZIDbaxjs/KdxN6PHZ1P+OV/NhCwvBCWhj3Tt2JvsHfj8aPOg4AO9ZoqMKd5V16jY2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MZxHhm2EgZiuQm7VLv6facHJP4TdX9FZclS+jm66L4=;
 b=fCoW9Goh65SMOZ/G9HvmQuPxxN+OP13e4ufAzBlFkaqZpypeAIXynuHa2zU+JH2J0aDPqk7R47rxRQN8BazBkzbKrNEhsPC/ZWpuIKuEhHs+Wbf77ypOBWYdzppEOXI9i4+bI9aA8uieJiudexvXt7TGMlaqsEeelsdzq7J4abQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB3071.namprd12.prod.outlook.com (20.178.243.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 11:56:38 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 11:56:38 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org,
	tom.stdenis@amd.com
Subject: [PATCH umr v2] fix field names for INDIRECT_BUFFER_CONST/CIK for
 gfx9/gfx10
Date: Wed, 19 Feb 2020 19:56:06 +0800
Message-Id: <20200219115606.6612-1-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2PR02CA0159.apcprd02.prod.outlook.com
 (2603:1096:201:1f::19) To MN2PR12MB3087.namprd12.prod.outlook.com
 (2603:10b6:208:d2::32)
MIME-Version: 1.0
Received: from c0.amd.com (180.167.199.189) by
 HK2PR02CA0159.apcprd02.prod.outlook.com (2603:1096:201:1f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Wed, 19 Feb 2020 11:56:37 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 83b68e58-934d-45bc-3419-08d7b532c6c8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3071:|MN2PR12MB3071:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB307177E2276966DEB4ACC0B589100@MN2PR12MB3071.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(199004)(189003)(478600001)(4326008)(1076003)(186003)(26005)(16526019)(44832011)(6636002)(86362001)(956004)(66556008)(66476007)(66946007)(2616005)(36756003)(8676002)(81156014)(2906002)(8936002)(316002)(7696005)(6666004)(5660300002)(52116002)(6486002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3071;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZ6iiOzmJ4AQ4/Nw0LCVKrNSnQ4hB/xj1gjpUwnGbpYZyJLFcpN8Ezx73Tgy3NXFg2Ux8JtULbK810+MHGQN03n4V+GW29Pp52hLblXvlnYIhgXC74LEB7HOjNMNhUBsYvc/+rj/J5ov9Q3eVWTA01wIaBG8Y2yk9hNFSBHB1dsw2kF3/+EtXkDYVdRfAHEfuTxRtzNuEqF9nkf2tA1JlYm/+lobk2pZPCysdo7d8hUnp9nih3C8uGIbF3dYN+FT7Mbe4WOE4cQi3u8xpHl2AuQQ7nzpnb7IfKe5Iw/L2rFrNXGzcngjhnArYL56KAgNX2T+2or/yIWnqVVzDzDkYNPrCAx4HfjbTqSnO86C8O08YsUNxODe1ouA+V9Cqr0JaBtmZ2mCUc3r1KeQ2TCUXTBgwItWvwXm8Ogom6O3lIeDz511ue04nrtoJJ7B73x+
X-MS-Exchange-AntiSpam-MessageData: RENYBYz7ATCeXs5CGG6+haV1TLgHT4HF/NsZSYNGE15D3zWNysHO10CphDdJbF+pKseC379eJ72zQj/ZL4QtcZrdeBTwtWmhjjDwIqac7itv1uhbwzIk93I1yrobx+tvlA3tc2558ubkc9Z0Jmoxcw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b68e58-934d-45bc-3419-08d7b532c6c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 11:56:38.6654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWm20xE0nYRH0ionK80zHQKJp61QeWbfyPfx9G8Bvo/bp8PibIxFZLr2PyxBg0ti
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3071
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
Cc: Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

field names for INDIRECT_BUFFER_CONST/CIK of gfx9/gfx10 are the same.
fields like OFFLOAD_POLLING and VALID are defined in mec's
INDIRECT_BUFFER packet, so not applicable here.

v2: fix umr_pm4_decode_opcodes.c as well

Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
---
 src/lib/ring_decode.c            | 23 +++++++----------------
 src/lib/umr_pm4_decode_opcodes.c | 20 ++++++--------------
 2 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/src/lib/ring_decode.c b/src/lib/ring_decode.c
index 250dfd7..fa44f27 100644
--- a/src/lib/ring_decode.c
+++ b/src/lib/ring_decode.c
@@ -617,22 +617,13 @@ static void print_decode_pm4_pkt3(struct umr_asic *asic, struct umr_ring_decoder
 				case 2: printf("IB_SIZE:%s%lu%s, VMID: %s%lu%s", BLUE, BITS(ib, 0, 20), RST, BLUE, BITS(ib, 24, 28), RST);
 					decoder->pm4.next_ib_state.ib_size = BITS(ib, 0, 20) * 4;
 					decoder->pm4.next_ib_state.ib_vmid = decoder->next_ib_info.vmid ? decoder->next_ib_info.vmid : BITS(ib, 24, 28);
-					if (decoder->pm4.cur_opcode == 0x33) {
-						if (asic->family >= FAMILY_NV) {
-							printf(", CHAIN: %s%u%s, PRE_ENA: %s%u%s, CACHE_POLICY: %s%u%s, PRE_RESUME: %s%u%s PRIV: %s%u%s",
-								   BLUE, (unsigned)BITS(ib, 20, 21), RST,
-								   BLUE, (unsigned)BITS(ib, 21, 22), RST,
-								   BLUE, (unsigned)BITS(ib, 28, 30), RST,
-								   BLUE, (unsigned)BITS(ib, 30, 31), RST,
-								   BLUE, (unsigned)BITS(ib, 31, 32), RST);
-						} else if (asic->family >= FAMILY_AI) {
-							printf(", CHAIN: %s%u%s, OFFLOAD_POLLING: %s%u%s, VALID: %s%u%s, CACHE_POLICY: %s%u%s PRIV: %s%u%s",
-								   BLUE, (unsigned)BITS(ib, 20, 21), RST,
-								   BLUE, (unsigned)BITS(ib, 21, 22), RST,
-								   BLUE, (unsigned)BITS(ib, 23, 24), RST,
-								   BLUE, (unsigned)BITS(ib, 28, 30), RST,
-								   BLUE, (unsigned)BITS(ib, 31, 32), RST);
-						}
+					if (asic->family >= FAMILY_AI) {
+						printf(", CHAIN: %s%u%s, PRE_ENA: %s%u%s, CACHE_POLICY: %s%u%s, PRE_RESUME: %s%u%s PRIV: %s%u%s",
+							   BLUE, (unsigned)BITS(ib, 20, 21), RST,
+							   BLUE, (unsigned)BITS(ib, 21, 22), RST,
+							   BLUE, (unsigned)BITS(ib, 28, 30), RST,
+							   BLUE, (unsigned)BITS(ib, 30, 31), RST,
+							   BLUE, (unsigned)BITS(ib, 31, 32), RST);
 					}
 					if (!asic->options.no_follow_ib) {
 						if (umr_read_vram(asic, decoder->pm4.next_ib_state.ib_vmid,
diff --git a/src/lib/umr_pm4_decode_opcodes.c b/src/lib/umr_pm4_decode_opcodes.c
index d7c1495..a823ecf 100644
--- a/src/lib/umr_pm4_decode_opcodes.c
+++ b/src/lib/umr_pm4_decode_opcodes.c
@@ -429,20 +429,12 @@ static void decode_pkt3(struct umr_asic *asic, struct umr_pm4_stream_decode_ui *
 			ui->add_field(ui, ib_addr + 8, ib_vmid, "IB_BASE_HI", BITS(stream->words[1], 0, 16), NULL, 16);
 			ui->add_field(ui, ib_addr + 12, ib_vmid, "IB_SIZE", BITS(stream->words[2], 0, 20), NULL, 10);
 			ui->add_field(ui, ib_addr + 12, ib_vmid, "IB_VMID", BITS(stream->words[2], 24, 28), NULL, 10);
-			if (stream->opcode == 0x33) {
-				if (asic->family >= FAMILY_NV) {
-					ui->add_field(ui, ib_addr + 12, ib_vmid, "CHAIN", BITS(stream->words[2], 20, 21), NULL, 10);
-					ui->add_field(ui, ib_addr + 12, ib_vmid, "PRE_ENA", BITS(stream->words[2], 21, 22), NULL, 10);
-					ui->add_field(ui, ib_addr + 12, ib_vmid, "CACHE_POLICY", BITS(stream->words[2], 28, 30), NULL, 10);
-					ui->add_field(ui, ib_addr + 12, ib_vmid, "PRE_RESUME", BITS(stream->words[2], 30, 31), NULL, 10);
-					ui->add_field(ui, ib_addr + 12, ib_vmid, "PRIV", BITS(stream->words[2], 31, 32), NULL, 10);
-				} else if (asic->family >= FAMILY_AI) {
-					ui->add_field(ui, ib_addr + 12, ib_vmid, "CHAIN", BITS(stream->words[2], 20, 21), NULL, 10);
-					ui->add_field(ui, ib_addr + 12, ib_vmid, "OFFLOAD_POLLING", BITS(stream->words[2], 21, 22), NULL, 10);
-					ui->add_field(ui, ib_addr + 12, ib_vmid, "VALID", BITS(stream->words[2], 23, 24), NULL, 10);
-					ui->add_field(ui, ib_addr + 12, ib_vmid, "CACHE_POLICY", BITS(stream->words[2], 28, 30), NULL, 10);
-					ui->add_field(ui, ib_addr + 12, ib_vmid, "PRIV", BITS(stream->words[2], 31, 32), NULL, 10);
-				}
+			if (asic->family >= FAMILY_AI) {
+				ui->add_field(ui, ib_addr + 12, ib_vmid, "CHAIN", BITS(stream->words[2], 20, 21), NULL, 10);
+				ui->add_field(ui, ib_addr + 12, ib_vmid, "PRE_ENA", BITS(stream->words[2], 21, 22), NULL, 10);
+				ui->add_field(ui, ib_addr + 12, ib_vmid, "CACHE_POLICY", BITS(stream->words[2], 28, 30), NULL, 10);
+				ui->add_field(ui, ib_addr + 12, ib_vmid, "PRE_RESUME", BITS(stream->words[2], 30, 31), NULL, 10);
+				ui->add_field(ui, ib_addr + 12, ib_vmid, "PRIV", BITS(stream->words[2], 31, 32), NULL, 10);
 			}
 			break;
 		case 0x37: // WRITE_DATA
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
