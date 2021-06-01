Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F3AC47092
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 19:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950C761287
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 19:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950C761287
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B716EACB;
	Tue,  1 Jun 2021 19:07:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF036EACB
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 19:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReLwjOJf1QG40xEp2gbKlC3IRCbOdeHLXSpVeuut4mkaZgTEsPl0L3k6J1kkLdVC28c6r0N5v7uETkC/YlK6n1Nq76Z3j9/GFJ9Va0XMKHUL4plpCQfETlrTjAuF5Xi6eUIzlQ3VUKTxGJqrM1B3y8G2XFjNmDNZMybhPlUdRxT1xQpjwJFbm3z1PN1VqHtH/W3nedsl9ntv/ReArtrCFe/+7RsHfmvlBwoSD48b7T5gYDQvbPYGOSR8fxJZi78xFo21EnYDuqPx1bQ1gjADCfPXdur+BZcesyYGKBNFuqh/b2mdLfZ54vREDt7k0X7YaJbS+lHoUx6QN5Ieguoxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Faz8NijLygsOJJdvhpUtwevVPzzvJIa1GtggN61hLhQ=;
 b=TnP4xIefBL8/4dJ5QoKPI1c4bz+caToHOVl584UeW0X3x42FcJL4TDpvzj4DBT9mI/SFW/rh1r9reMzctTOMez70aUPIO3C9/GEcMd9/lu4mZlryj3ft1QDVIYvWASgesVOfiwTT616Et1IhyEkzZjMZx9Jic3ICliROWqie4vttk6C+t0pBbE+wEHhPSk5wUitxV4qOdg0XHPjyHUKShK24BNcbTf/L33HkJCvn3U5jLPfDzLBzzL7tB9qu5dYlYxMxBZZnSPFJfZR6fSA9i15IKSV36ZyXSwmf0BPLSZkfjAvEMowjyuOvduvX9yVY/ICRfaN2hiQB37S5CTA8IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Faz8NijLygsOJJdvhpUtwevVPzzvJIa1GtggN61hLhQ=;
 b=0/vg39ppkb15nI9EaBUu7edcctRWbRM3vKFYayzVo7EVniiB2wm2erJLYUbNgVLzlVlWkg0M0TLsmRZEkhXlwe0yo0NDW46Ywwkp4wkEhpYupzj4zVCXczEb/7B/cV5T2aLBJvve1pZ3q9buwhpoXB6DRfrYS0MuF3OzbvVLMwU=
Received: from DM5PR04CA0071.namprd04.prod.outlook.com (2603:10b6:3:ef::33) by
 CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 1 Jun
 2021 19:07:50 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::3d) by DM5PR04CA0071.outlook.office365.com
 (2603:10b6:3:ef::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 19:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 19:07:50 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 1 Jun 2021
 14:07:49 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdkfd: Don't create crat memory sub-table if node
 has no memory
Date: Tue, 1 Jun 2021 14:07:35 -0500
Message-ID: <1622574457-4447-2-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622574457-4447-1-git-send-email-Oak.Zeng@amd.com>
References: <1622574457-4447-1-git-send-email-Oak.Zeng@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c79f1015-25c7-4680-9c50-08d925308d4a
X-MS-TrafficTypeDiagnostic: CO6PR12MB5395:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5395B82120AC2530DF7A80D7803E9@CO6PR12MB5395.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yY7mVN158yRUW/uufU6ed3Z1fxCiQcMRImRsQAIlravUkRdLbK4BknfFox3sGMP8f9Klseyv+bCDj4VMPSXh8cAFvW5svV8/ysCEjNP/ZId3E9mGhpckxlW9QB2OmIw++021gXDvW6YQ3qvcRG4nGr413HzaJzba3DSzvZVbw30EqFQ79j3Ko2yGPD/VT4dfLhkb3ELqhvIL0RV1Fh1bw4592GjDZpjxkFaKsYfnsRbEMoDbYUPT8cKQWQkiPAhtjRdPMnPR/xsIhPt8T4Pp5IcOLT8JUWKEM4Jsd6aBAc/XHidQR4K59CqI+mRDGk1u54Bw2cvHAHBrh7KeS2pHuXrHvaJYGrzD5G6vDJoOVdtbMSrQz0xRsmMUkCVnBl9hV/binNUi2tVv+6wAltSmKKrsQ7gMh+O7C6Wna7eafuQAXxJiq3gJAq0ohigSWy8TMIS/T3K9XJP5v34PsdaBtztjRJE966Da/3ynJuQbm0rCdqAY2tF5DbqoO3ZtTpV4BI3ixM/TfrCRzoYOmpqPEXBKIykiymXLGr7EsOLFW5iu21KkCXWON56TgfXvyyLwC3JkGDeE4zCINM/vCqdrTmFBA3gEQb5YHgw5ir5dzwF0bZ3m0q9U1XpKvC+wxBfzns/Fmv7pZkHFyt7kP7I6tznq18A+ckCnyy/oZkj/xsPU0mSqln4tXeTw1602QN7P
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39850400004)(136003)(346002)(46966006)(36840700001)(86362001)(36860700001)(47076005)(16526019)(186003)(6916009)(36756003)(8676002)(356005)(54906003)(81166007)(426003)(70206006)(26005)(2616005)(316002)(82740400003)(478600001)(82310400003)(7696005)(70586007)(2906002)(336012)(5660300002)(6666004)(8936002)(83380400001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 19:07:50.7781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c79f1015-25c7-4680-9c50-08d925308d4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
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
Cc: jinhuieric.huang@amd.com, felix.kuehling@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In some configuration, there is CPU-only (no memory) numa node. Don't
create crat memory sub-table for such node.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 56e6dff..dd7772c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1583,7 +1583,8 @@ static int kfd_fill_cu_for_cpu(int numa_node_id, int *avail_size,
  *	@avail_size: Available size in the memory
  *	@sub_type_hdr: Memory into which compute info will be filled in
  *
- *	Return 0 if successful else return -ve value
+ *	Return memory size in bytes if successful else return -ve value
+ *	Returning 0 means this numa node has no memory
  */
 static int kfd_fill_mem_info_for_cpu(int numa_node_id, int *avail_size,
 			int proximity_domain,
@@ -1619,7 +1620,7 @@ static int kfd_fill_mem_info_for_cpu(int numa_node_id, int *avail_size,
 	sub_type_hdr->length_high = upper_32_bits(mem_in_bytes);
 	sub_type_hdr->proximity_domain = proximity_domain;
 
-	return 0;
+	return mem_in_bytes;
 }
 
 #ifdef CONFIG_X86_64
@@ -1746,11 +1747,15 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 			pr_err("fill mem for cpu failed\n");
 			return ret;
 		}
-		crat_table->length += sub_type_hdr->length;
-		crat_table->total_entries++;
 
-		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
-			sub_type_hdr->length);
+		/* ret == 0: this node has no memory */
+		if (ret > 0) {
+			crat_table->length += sub_type_hdr->length;
+			crat_table->total_entries++;
+
+			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
+					sub_type_hdr->length);
+		}
 
 		if (kfd_numa_node_to_apic_id(numa_node_id) != -1) {
 			/* Fill in Subtype: IO Link */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
