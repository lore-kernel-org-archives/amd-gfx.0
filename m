Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307E4C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 16:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB59E6137C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 16:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB59E6137C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB766E4B7;
	Wed, 20 Oct 2021 16:35:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 727546E4B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 16:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEzS2sxWqFn3uTKP7LEXilK+uJBc3X4NWSQOxxjF48lBPLGuxZizATLy8hr/bOeTjMzpFYRNrZAvLFH/Bk4rcabQGgtAal9APEewrOBwL5r6ndrpibtqcH2ye9ju5/NfYSgySBlaLsMb53XEOSJh0nTPNuU9Bui/lCG9q+4gmymrLpYdBH2Q2lcSZpHsrQq5P64jQSOFTj2R2QPcta8m7eOshw6uHVdYqkCAXz9UHV4mNS0MzFzC7TZBAJ351m9+OoLUVuvwJ5y35kX6LrhtZI668iESx9156RNQ4jFLmhPGGWOZ30Iw2e+wqO4SjVyp6KRFkc6Ae60i6/5YvEOlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fHZBOTzKqyueH/5l9JuStUO3bBU7mNE5xu4+MiwiRs=;
 b=VrurjTnJfR0i5i+WD1vlFyjk/v75y9XtVvt86G5mePHNyYHwhb24aCEagFN5vJNIqs0YCJC+W+Ig3mfvt17Uhyg3+WkHbD9HPLxCIUlTUN5Pl/nvAe33PyHVIVHHO/EZlTDqsgdGuk56GMdi7debOjRtdp50lMGYn6LlcOGiakUcrN55XIJn5zDMVi8XfprjuwiIBFnhXugooQZ5Sd1t67nmm0XnEBhjhN3IDGl5asb5LkrQBATg+5MEUV+KSoh0wZgQth8waF0oKf6kOy+zyznk1o41giZScdPEqHW8TGok7yvRXgvfWOL2teDof1yWbsq3JUHsHBG5HoTb4yPSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fHZBOTzKqyueH/5l9JuStUO3bBU7mNE5xu4+MiwiRs=;
 b=TTRR/Su29jaRNfmhkL60KwUPMO9QxQe54lDkfidUen7bWde49GbXkJO2UOHzH0NVTfH9CR1w64ti8zCwlL3ckp+J3Mq8dmYxSA8hsCYrCClnshtz1dV06teMTfH8MbhxrBzwjNa3zFBJDMoBtYrZb75atdBgU1TGmwiMN6X+dio=
Received: from BN9PR03CA0408.namprd03.prod.outlook.com (2603:10b6:408:111::23)
 by BY5PR12MB3681.namprd12.prod.outlook.com (2603:10b6:a03:194::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 16:35:34 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::6) by BN9PR03CA0408.outlook.office365.com
 (2603:10b6:408:111::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Wed, 20 Oct 2021 16:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 16:35:34 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 20 Oct
 2021 11:35:33 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
 Mukul Joshi <Mukul.Joshi@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Warn when bad pages approaches 90% threshold
Date: Wed, 20 Oct 2021 12:35:18 -0400
Message-ID: <20211020163520.1167214-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a050ac47-86fc-4e9f-0ab6-08d993e7a3c0
X-MS-TrafficTypeDiagnostic: BY5PR12MB3681:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3681ABCF9F58B96002698B0D85BE9@BY5PR12MB3681.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWekovcotMg2uFXzlKMaTgxAKgCJZVJrX1HFQ3na11p+Q9pgIYv8mxVGntjj7tXgSjcbYUEceHaUSENmxkWF8h79jkHGCNqpfZrJ+zF3tRJ6nAThi5xRccmuQt52f7q1Nt/C1u1BsgSV9uxUQqu5tBgSZMqGemq7HYBF9N8XZIbQpg+dcptIzdwwjWNLG0bJXFZdDzoe0C3WsLL1A6k0Zo4fru9jZQq229a9S5nAeWBq2GVzDcZKOGIJDLZ0I7fLmgOzC1h+fov1yvJQi6R+z93OQWKEkYKWMcPAsiol04VakPUAXztIAO0gSbW7h2kRumV16wODKuw4SIDBAWdjCYko3wZjp79QoKYYGEp9As7HwKf5vcNV4XgOi/S+8vo6gmiZwOuMsGOd0D+W2tAXFFQX7WLpCLCdCl/mFBNy7XBsa+zviujriUOJhDPToUrQs3ETjHkFOSuoFJ6fk0xhMX16wU7VrqeExnopNW6T/tnKe+y8IEHGrlX7aotT9sdOpAtwInFADD+qY4Zbq0Wd7QMbti5SHZvtp3nOLYpPKWxBZLka3pspW0CKy5oc9RwkCLPUFDfNNbZpoRV5nhCEZoQpxQpaPfuHyfdXizKmASK34qF/gQZXWT6PprjYJ4sTT4IgzlCUYjhum+Mg5ii9VS5gB1mUmPdK2HbiMVTD03c7pDfqftw6XzRdODoEn++n8L6dRLPRmFuuccefIEyndpcz9Eh7yz3no0cfdgct01Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4326008)(186003)(316002)(6916009)(8676002)(8936002)(426003)(16526019)(81166007)(86362001)(7696005)(26005)(83380400001)(356005)(82310400003)(5660300002)(36756003)(70586007)(44832011)(1076003)(336012)(36860700001)(508600001)(2616005)(6666004)(70206006)(54906003)(47076005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 16:35:34.3196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a050ac47-86fc-4e9f-0ab6-08d993e7a3c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3681
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

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index f4c05ff4b26c..1ede0f0d6f55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1071,12 +1071,29 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
 
 	if (hdr->header == RAS_TABLE_HDR_VAL) {
+		int threshold = 0;
 		DRM_DEBUG_DRIVER("Found existing EEPROM table with %d records",
 				 control->ras_num_recs);
 		res = __verify_ras_table_checksum(control);
 		if (res)
 			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
 				  res);
+
+		/* threshold = 0 means that page retirement is disabled, while
+		 * threshold = -1 means default behaviour
+		 */
+		if (amdgpu_bad_page_threshold == -1)
+			threshold = ras->bad_page_cnt_threshold;
+		else if (amdgpu_bad_page_threshold > 0)
+			threshold = amdgpu_bad_page_threshold;
+
+		/* Since multiplcation is transitive, a = 9b/10 is the same
+		 * as 10a = 9b. Use this for our 90% limit to avoid rounding
+		 */
+		if (threshold > 0 && ((control->ras_num_recs * 10) >= (threshold * 9)))
+			DRM_WARN("RAS records:%u exceeds 90%% of threshold:%d",
+					control->ras_num_recs,
+					threshold);
 	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
 		   amdgpu_bad_page_threshold != 0) {
 		res = __verify_ras_table_checksum(control);
-- 
2.25.1

