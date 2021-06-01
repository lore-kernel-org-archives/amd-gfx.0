Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2D9C47092
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 19:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E8D613BD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 19:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E8D613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5BF26EAD7;
	Tue,  1 Jun 2021 19:38:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCC5389E32
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 19:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9rvU8PqBDtbCluJNNQMIAONDoRDBJYeEsyhjWSIscZsd65K/sZLqL+XINEz4hymKehOkZIWQcUZ86ExFYsuPl4tRg8SH9G/bTCz7JZ2jvfagwRkrJCeyhNaJf2hvedV6uIS4nvKmwPlHj+2iCLAiQUydDESAbc8DAJ0/2f4zGqGrxI4KKyh3tq7Sz/oyUNhURmm4RG/zA/kI+oIhf/nB9vBTslsdy5WYwGehCG3sFkdKxUfYk2Ikv9MraVBtqHfYEDJCJt8xKFjhwMHtcGdJGQhLzNs+4UgwBdkc8kWkirq2CfXIDXsroKnyazHRmuGvEnH6Yp6rtlBBz/b1/+Eag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcPJy8PjNKFrQPJK7XgcGjDz4DaguBcHaeB5wg45LUg=;
 b=GrGBv68TzO0w7YLOU/Jn/jnMJEmz23DNCaOaoTj0Uhj+OhFV8NgeTfRZVOY/Pju3/Z0woVGlmogD3lMTaBIpDuWtSx7RNNvjgiVtQcgxjSMTMT/Jhpz7VyoSF4lx2mKKmkhuHwvgTZHZ881ldw6skF3ULKBVC4I2WKvcSPWJC5z3FJ2za5YRvyDl2ipZa8yUxxIfAbh9+++YjaPe7mE1BVII58YDapio5mgEIfE0xvZGuY5OcyUgJfDrcitJTYXFiUZZYupV6QgLlRExlTZrqDqMmVsy+GChKHgC7VZ0fjGDic/mFls4G2f7T/Znw+UWQSTb3DSRCxX/2olc1YUnAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcPJy8PjNKFrQPJK7XgcGjDz4DaguBcHaeB5wg45LUg=;
 b=ZBz38XrCFto2khKeCQrIVmN0+ihtoDLupVSr+dY16n+IGQRssCLJbGd5Svl9NacXRQaFQSEV8gC/R0FxO12r1onDVEWAN5V1cuT/AczY4Wh5zAvag/ttKfMhQ6tomhUeF/BLypTHlEz6QVfQbGQFywVs2slvtmh+Q7sX9+lTHTU=
Received: from BN6PR2001CA0030.namprd20.prod.outlook.com
 (2603:10b6:405:16::16) by BY5PR12MB3748.namprd12.prod.outlook.com
 (2603:10b6:a03:1ad::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 1 Jun
 2021 19:38:17 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::31) by BN6PR2001CA0030.outlook.office365.com
 (2603:10b6:405:16::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 19:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 19:38:17 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 1 Jun 2021
 14:38:16 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdkfd: Don't create crat memory sub-table if node
 has no memory
Date: Tue, 1 Jun 2021 14:38:03 -0500
Message-ID: <1622576284-20045-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 423a917b-22be-48a9-37cc-08d92534ce09
X-MS-TrafficTypeDiagnostic: BY5PR12MB3748:
X-Microsoft-Antispam-PRVS: <BY5PR12MB374874E0FBC0B0A04E4DBC38803E9@BY5PR12MB3748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XcvOr99kq9ulSFw/V2i+03arwzvQKV/yPczf7L5M04Db22b5GCJTZXvZckwksItO1wEsEMdzE54cuZbZ07LEftuBMZU6IepCzJPfeFjsTvDpGbAirpLty+4h/yXowc3vgyIZExiHHUPzoUnxEKSTXesuu8tAIioWIkC5s8HENG1uOnsMEJAq8cnleE4ITFNQ93jbtf/xTxVTV5QimKholCuZQhit3pBuUd8giQyimmJ2VVYHf+megNAf1VQhg8KTiXGMWkQGcsj/WYrjZ2GUhyj+FQDQSa9xmbvR14pKN0zZXjHxC7M9eCFOClK9T5kJl4utyxccivOWAVr2MXm7USMID+raGBrGs1X0wWyx6oiA3iDzFMN5EPUEkIBJHdWK06Dm7Db/27eQBvHgH6GqxHALfgBptYGqB9yLwz5wTXBwfDJ/EQilsBs8IS8xf7eYqYr2Dmockyb/tOFcLcUOaTuztYn5JenvPDp67Xj/mLJFv18buS8+uQUm630HlPmEgF903HaVr7WvStY4SqESvydfZC+eGBKmdaaEFel3DqjfxjR8+tBL5ewkM0uBnFejdqy47yrtqxgwcwX6zLqdUkXKxcIwaFPuzlRszQq+KEQ7PcRT9dV5KB7+fp23oZ9haUywklgVz9BNsrPcdl5kFNeTs4Q50I3Na3wECqLBsjhrgSAKI5ulRJRexo2caUlq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39850400004)(346002)(46966006)(36840700001)(2906002)(356005)(54906003)(8936002)(2616005)(478600001)(5660300002)(336012)(47076005)(82310400003)(7696005)(36860700001)(81166007)(316002)(70586007)(82740400003)(8676002)(26005)(86362001)(36756003)(83380400001)(16526019)(186003)(70206006)(4326008)(6666004)(6916009)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 19:38:17.4423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 423a917b-22be-48a9-37cc-08d92534ce09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3748
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
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 56e6dff..420a312 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1583,7 +1583,9 @@ static int kfd_fill_cu_for_cpu(int numa_node_id, int *avail_size,
  *	@avail_size: Available size in the memory
  *	@sub_type_hdr: Memory into which compute info will be filled in
  *
- *	Return 0 if successful else return -ve value
+ *	Return 0 if successful
+ *	Return -ENOMEM if not enough space in caller allocated crat table
+ *	Return -1 if this numa node has no memory
  */
 static int kfd_fill_mem_info_for_cpu(int numa_node_id, int *avail_size,
 			int proximity_domain,
@@ -1615,6 +1617,9 @@ static int kfd_fill_mem_info_for_cpu(int numa_node_id, int *avail_size,
 		mem_in_bytes += zone_managed_pages(&pgdat->node_zones[zone_type]);
 	mem_in_bytes <<= PAGE_SHIFT;
 
+	if (mem_in_bytes == 0)
+		return -1;
+
 	sub_type_hdr->length_low = lower_32_bits(mem_in_bytes);
 	sub_type_hdr->length_high = upper_32_bits(mem_in_bytes);
 	sub_type_hdr->proximity_domain = proximity_domain;
@@ -1742,15 +1747,19 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 		ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
 			crat_table->num_domains,
 			(struct crat_subtype_memory *)sub_type_hdr);
-		if (ret < 0) {
+		if (ret == -ENOMEM) {
 			pr_err("fill mem for cpu failed\n");
 			return ret;
 		}
-		crat_table->length += sub_type_hdr->length;
-		crat_table->total_entries++;
 
-		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
-			sub_type_hdr->length);
+		/* ret == -1: this node has no memory */
+		if (ret == 0) {
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
