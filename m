Return-Path: <SRS0=AM0C=PC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7484C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 17:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C88661167
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 17:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C88661167
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D496E11E;
	Thu, 14 Oct 2021 17:34:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97ECF6E11E
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Oct 2021 17:34:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llRl/83JyJ2HuC634iFX/rYy32x7CgrLlwokhlnYoKDZWPoLLjjbElvaAwzAlQgSf5urrhtLU9A0hXnyfzQC/P/OmNXF9268798GncDh5YPo/fUVXcZh3sZWIys4Ne3epS+6Hf04l5mUfaSNvh6LS8APtrFC8w7ERUsB+T6p1bnLYiyhEg6yQplGAXw7bSRctMPUhjdZiXI5SYakm4KUa/PaQE0oP+eE3JO7kKrgz1z0cuzvRKBrI1QZbxrqJBh+YH6MPH62zUPPRhHaBbGxfTpdoqKTdgv58LUSnzYX0jG0uoE4iQlwUNN4WgyEgPNZOAAARvlVZtZl2FL10PGnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTy9QX7RR570XNpZ1OOGshF+TqkBJ7Qt713/3HknvEQ=;
 b=A+JZ3Yh6qdGyPgZ4whLUSq3g7nwZY67qyJBNxC00MdPKIr7+LTEwqANqKVwbmLWFYmTaeFm3+JgGCwmExCbPd2hE67eBmeFyIlvPfE3446qovVdQPQNaJOWbcYu7jxRWdJ8BuuBOo+IlGVoW0sBWhU+rn2mc5/SSGN4QfgcYIFr0K84O72YDwTa0D36yYi5U9qC/9QLcVVU7UAqWLNJQCu8bvi/Zb483/FB5nrwXK+zXUahw9GEjxAB1dL5PAGV9EARWFw62krb6hXPqBTvz1fNmrBbd55KzO6TMFIYURzY4ihzWTk7fAohfThsK1VPfDCy55KYIXdtiQT3ExW/+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTy9QX7RR570XNpZ1OOGshF+TqkBJ7Qt713/3HknvEQ=;
 b=bDC33RqpQ9VtYTjkbkb+r5w1uUDSQpOvvAWBeKJvIJ3CLhRN9T/0Fh71LNs0OOr7fpgPkCLHnU0RhHbnPJUNgLNhXXSpBv6Ybti8GE4V3oHIk4usfPa2lm52iH+twjRlIwXhGWiSdK0Bz+uLksoBSiGC+W2R/S0Q25NGiU4kUz4=
Received: from DM5PR15CA0049.namprd15.prod.outlook.com (2603:10b6:3:ae::11) by
 BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 14 Oct
 2021 17:34:18 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::5e) by DM5PR15CA0049.outlook.office365.com
 (2603:10b6:3:ae::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Thu, 14 Oct 2021 17:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 17:34:18 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 12:34:17 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Warn when bad pages approaches threshold
Date: Thu, 14 Oct 2021 13:34:04 -0400
Message-ID: <20211014173404.713784-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22516445-168b-43ce-de15-08d98f38d99d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:
X-Microsoft-Antispam-PRVS: <BN9PR12MB517925481BCF9D85658C5E3685B89@BN9PR12MB5179.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9dOXyL5KECPUPf/OuHaLxzSZKEs4U74kdgvnAegjfsesN6FjT8D35niMUtcnvieKMzToMz6YqXn9/lLAzNZ4xDi7KtUJlm4GkxDUnEdp3BnP65f/qZkLavG4/hVvIxtjop2242CIo419uGl4Cv6E/uGsyDo5iBkcz86AZT1WDHai5NElHAf3gkSzZCUdSf47iqwnSjWxwmYTohmrZ7QQj9qlreb7IA5TwUr8BPSKm8K/eFqcA8Id6tgCkg3DuwzlqgCTc8AULq/4Upo8y66lfWKdlvMPHkj5pJ/qHP3trhaJ2jhb6GKoHkaasNdpKaOHwTho/RN05HShP0T6YIh8zkIstc/v+tCNiFP5SvN2nWGPhFAvC4xopHZB2U1Dcrpr8GaudebwRCZBs/X6DgCigW6oNMYHlDplucgzExK+Z8rEzPDK61JBMws/wjWp7ou/RIPFQ/VFill2W3KzlPCuw30DPLYBUUj8hNItRD4R5K969lctdHXkfMdMZCDf6+Bl1GFT/J0jVRdOw9j/0Bsf4EQnsr+RmfP6muHQ12Fkp3R+GxjtnZp4gWBIS4sQXu3YYLU2Yu71/j15eNo9+yHekmtIJmHsPgTfJzV/XWZULJ6Zh30zC6m1jKvQ5EnpGZRYpFvdxqvwEs+LZGG7BG/KbPYNeudKboFP2N2HteGKK7PTvb9rqyzIvluJyqEJVgM4WxlAuUj9+CsbH3/DvWu2vWWw1L/ANdfBlIFy+RKGfc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(83380400001)(8936002)(1076003)(70586007)(426003)(6666004)(2906002)(508600001)(44832011)(316002)(82310400003)(2616005)(36860700001)(26005)(6916009)(81166007)(356005)(16526019)(36756003)(336012)(5660300002)(186003)(47076005)(7696005)(8676002)(86362001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 17:34:18.0858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22516445-168b-43ce-de15-08d98f38d99d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
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

Currently dmesg doesn't warn when the number of bad pages approaches the
threshold for page retirement. WARN when the number of bad pages
is at 90% or greater for easier checks and planning, instead of waiting
until the GPU is full of bad pages

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 98732518543e..8270aad23a06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1077,6 +1077,16 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 		if (res)
 			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
 				  res);
+
+		/* threshold = -1 is automatic, threshold = 0 means that page
+		 * retirement is disabled.
+		 */
+		if (amdgpu_bad_page_threshold > 0 &&
+		    control->ras_num_recs >= 0 &&
+		    control->ras_num_recs >= (amdgpu_bad_page_threshold * 9 / 10))
+			DRM_WARN("RAS records:%u approaching threshold:%d",
+					control->ras_num_recs,
+					amdgpu_bad_page_threshold);
 	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
 		   amdgpu_bad_page_threshold != 0) {
 		res = __verify_ras_table_checksum(control);
-- 
2.25.1

