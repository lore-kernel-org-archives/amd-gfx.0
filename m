Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9E7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 17:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B60B61A55
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 17:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B60B61A55
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 301956ECE0;
	Thu, 21 Oct 2021 17:26:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 067036ECDF
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 17:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJuqh/N1c/sll8krQUpXmWyBbRk21GovmiD0M7Dd5CkclmtOjPDcYfF53RHghayNa6OFdQo63DEt9hja1y4UZNylzRucdyMQrydHWAufplx1WRXl9RdsDawGk7UNnoGlJGGpiYNs5ju3f8hNkDFEunnInEmpGdIyK3zvEhdV79gBtvbsfnSmoWhfwj2FnH+cEoCvjWIpZlFPdPfiS3211i2eggLQR93hYFpcXgtDjS0yCVybuu3Uvh9yDgSNHesvBNUsoZ0S85dZ7nxPTk8ZyVA+JtFA+9D6k/BPeuZdjb4ulDlHRfqijQiqgB/4nS8xvCsZXtuCmP9L6R9spbpcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGvFxfWJVfr1stm55PX99zIf/xu98P5y94lsSOap/4k=;
 b=HcSXFbxyAHsU0rI8JE3U27XI1regS1hDgSTuHq7A+jVXV6amhnYi/SKdgXOQIJTF0uR+WGebjas9xIGQHSrZH+P8P5Y4FbDVruWR0xuQ9VecOZmdGTkFuvv9bgDAT51CKZD94Jg2+qqLaKdIrg/7h8oEfAuMHL2rIz+srAB0lJOuHcBTuF4RAnOCly/w2iljLPvUEmIuBL82EUJENMLmU94AU80iItiUAx7oY449doFyi2uvxPOQXcXfz8gOL/5qaghL4oDEOxgSPLpi/iuOpKMyI134KeJ9Pw7OiK4ZbueVc5Jt1X2VCY0VkWJ2kbQ3B/B2ZE6VSDp6g8kDjZQUCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGvFxfWJVfr1stm55PX99zIf/xu98P5y94lsSOap/4k=;
 b=Gk8w4unK106lLpyuS9EL5kiUOs2IzA5VVgo7jzsza75FZ6gyatGXC2xLSQAd6Ro7QdTAxHaRi5o1mQq8TnAnfl6/OOEdt8FTjfCr8qTTRkeClup6Td3mGP0xAOrQYJaRkI7jB3JluuK2TQR3NjdcWOoAddYEAxrZH/7YM1gkomY=
Received: from DM5PR12CA0051.namprd12.prod.outlook.com (2603:10b6:3:103::13)
 by MN2PR12MB3373.namprd12.prod.outlook.com (2603:10b6:208:c8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 17:26:38 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::70) by DM5PR12CA0051.outlook.office365.com
 (2603:10b6:3:103::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 17:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 17:26:37 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 12:26:36 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
 Mukul Joshi <Mukul.Joshi@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Warn when bad pages approaches 90% threshold
Date: Thu, 21 Oct 2021 13:26:26 -0400
Message-ID: <20211021172628.1294703-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 573c4802-bce5-4c68-3cfb-08d994b7f03c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3373:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3373F650EA61F6CBE086DAA785BF9@MN2PR12MB3373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vW618JIoGAnTevb53oCG5fGdNb8vkAbljpy6Y652VWEehU4O4sRce6C8GWJYOJwcx4zPDPK+qAWXlzuvpFnOmV0c8GBiHFk0m/kzcezpANs5afM+/4QARs1UXK2RFP5ZNdEB9/bRU76KIr8J7wTU5XGQfGsQrkKl9B1fnyH/jQ4S/hiiZTWkw2UO/JamqjT4NHdIJ5yJknLpbyKvkUDQYFQ0w34dLr4pgGsb4Fdw44UxLNBcCW8/2dTg9YvVrKcWKi7/gZ48hEgahn7gSuZtrGl/qugFTMuTPE6D2Tm2KQO1J/j3RBO2oFYTf0HMp18/koty1L2KwEYJeQRkBsDL7NB3ws/+DQizSb1ywaywNxSyQo7B3jQCgFRVOpXonyehH9HmAQNBsxDuZ2uV+1hRp2L8ZY3IrnMaJevcmV6ns1nDOl7mvEHhr51QMVG/+ukigEEy8Er1axOGvCEV1FkyISfBeMqqVqLNdgj7OlnOjVXsM5wPTcUdweQsqIrR79uT1UYdkFpCepSuZlmniIHbwUy7iCf66Daz8K0yd5UBxzv7JfM5Vwk6CoXoGcy+PhOl+f+EVnS9+1ZhJsESh3ObsHkaJxHpBv3B3x2s3tfP/jal3oVfey6kZAodoJZuMXIZ7+lOmkbSxjj/do7UCxuF9ZaAg2yI+T2zwcmpIPRHoVdFoLLbKisOYkl/NRsyby64o+6h0U1km2CL4V9mBXtk/NDjkcrKnLCPtuG10IBKGEA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(508600001)(47076005)(83380400001)(7696005)(356005)(82310400003)(8936002)(336012)(86362001)(426003)(2906002)(186003)(6666004)(6916009)(16526019)(44832011)(26005)(54906003)(2616005)(70586007)(36860700001)(1076003)(70206006)(4326008)(5660300002)(36756003)(8676002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 17:26:37.9251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 573c4802-bce5-4c68-3cfb-08d994b7f03c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3373
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

dmesg doesn't warn when the number of bad pages approaches the
threshold for page retirement. WARN when the number of bad pages
is at 90% or greater for easier checks and planning, instead of waiting
until the GPU is full of bad pages.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index f4c05ff4b26c..8309eea09df3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1077,6 +1077,13 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 		if (res)
 			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
 				  res);
+
+		/* Warn if we are at 90% of the threshold or above
+		 */
+		if (10 * control->ras_num_recs >= ras->bad_page_cnt_threshold * 9)
+			dev_warn(adev->dev, "RAS records:%u exceeds 90%% of threshold:%d",
+					control->ras_num_recs,
+					ras->bad_page_cnt_threshold);
 	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
 		   amdgpu_bad_page_threshold != 0) {
 		res = __verify_ras_table_checksum(control);
-- 
2.25.1

