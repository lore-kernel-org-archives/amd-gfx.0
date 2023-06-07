Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F4FC7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 06:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B515110E440;
	Wed,  7 Jun 2023 06:48:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B84910E440
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 06:48:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6ZJ+EYs2sIwCOqj5b26uf0/KNrjk525ptV1whKQuK4h1RCHKlYSc0y4PLJoK2QzltuT9GSdoX62YyK3GPLgpksTeg3FTSZe40WVt6j984vf5X9GGZy0i5wBlv/pawpo8zxZyqdlYPKotM3ZGz6NxvquBHv/UH+CUSQiMHHDL15ENNKdhElc8OsW7L5CII84UaQW+jIbdQS5f/y2AB2APcfE3EiPPmR0AlDCoYiXiyoXl1To0GOxDCxqvfoB2TM4dvM6Ql0zOZuRnAin5hNlw0I3eMq43kvfCORkkFyqNGsbDa8dMTeSjWjPvmLEG13RpHBJW6VPXdfx+EnNh26tJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCu3+1nEcYjqJFgoKBlDLUBgDGWcNgCacljH9Cd9Vuw=;
 b=AxDwByxDrgXcTD11yEpTKSw82DOqzobIdy5IhehsxnY/dhe6sWvyqAjTp6EJRvl7iZOR56GqusLbqFHjlfh4MMdlJPoiL6OS8NC1W9z3B4UQmYELz5ZH/1EYvAA3N5oXSXDtJV43Du7diDsEimUSj5c6HRSyC0vW9bWprTQKsoWgPJJD4BGXR+r1WW13HdZwIkph5OMKCStvOKYxa/LTXLEE1y+I+E3iqK+aK1QiD0ZlmjxXfoKr4qlVH/Xc/MNdPeZGunrCTEkMV+Jh46ypVXRf6IiqeuLwGin0mLhUi188AdKiwqv0ajABZPQndgzrRg6Qvfap6b2Jn+7XSC9E6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCu3+1nEcYjqJFgoKBlDLUBgDGWcNgCacljH9Cd9Vuw=;
 b=2WvYBscf/0YEowfQ/Pb/8mx9pdgo5BR583n2QJUHVY/Twnq4uaUBmSgsfLcvnZEYcHgMuJUJS/cu0kMhtWM3JDSd1e9o7FCBJzJrirXS/vQtVSapRtLMdmgrtaMGKzve7i5TEoj7ap3KEl3/nvZfDwsnIgj/6/juqSp+3/AqPGA=
Received: from BN9PR03CA0697.namprd03.prod.outlook.com (2603:10b6:408:ef::12)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 06:48:33 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::bc) by BN9PR03CA0697.outlook.office365.com
 (2603:10b6:408:ef::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 06:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.22 via Frontend Transport; Wed, 7 Jun 2023 06:48:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 01:48:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 01:48:31 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 7 Jun 2023 01:48:29 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH Review 5/6] drm/amdgpu: Calculate EEPROM table ras info bytes
 sum
Date: Wed, 7 Jun 2023 14:48:13 +0800
Message-ID: <20230607064814.27226-5-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230607064814.27226-1-Stanley.Yang@amd.com>
References: <20230607064814.27226-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: edeb4166-9500-4bff-2f1e-08db672335e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: izANtelQl/Jzd4dokiOPpGcuRfJKyOBx7C/Q5E5Wk/MawMwil9BVbPjBsUpOgbtOPL36Z1Prlmd0a89SfB5qrkE7Rk1Hxc9R7dXfkkh1dNZEmb3Fls5ipWFtL1OreJ0uF8dVoYS3KnoxuAbFIsXQcEidQ3T6E07hz+vLeHO84gpLVXsG9wKjjvbm21hPOxQMFw43zt26neUqKHy+8CeW5Qiw3u/rpI8TMAr6NjoicF6Rn/mkKmEpXG4mAjD2eMeIHamGi+SKqO6377tvF9L1aHIF7B2sIn+2iWU7w641UvrPoa4ysC5LpUmYabH09ltjfEGQ2d1/GDRzrX+r8kZJe1gmRKqY193g3/hxLgbzkiNI4xW5aSJoT6bU0Wd5TJrngMA3Rbe5Xuq96qfodXufmjdKxcXo8o9XMVPIuNfdBFaTaUzL0hyR8HS+jfrRShiH+lc5zDBHv8zIhRbrK6qnpmI3vcVlYHG9HWHhCehk0B4cCYqF3qIpk7WN7nNyR0suxU2MSuaq78BJwMrpfZ75CIpgI/xtjDZkPTzDhSljRGNJwCreBpVJKY9IvbTMCPfHo0CGzaA/I51AuSxtAs4R5s7feFEDYhnN4SltipBGYshduH7pkPV8DmBDZJKsSRHwkADI47cx7C7xuFHClCDryymmDteWZD68u8geGmUKnz4XijElbEhRf2nvdgv84g2wX+3uAtZvlRIXseW3nK1VAlLjc605DkX9wOE/5OGDXItN/6X6Jff1+K3iQEX7gquMQuK07nVKeFXWnkHnpa2Vog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(47076005)(83380400001)(86362001)(40480700001)(81166007)(82310400005)(82740400003)(40460700003)(356005)(478600001)(110136005)(41300700001)(7696005)(6666004)(8676002)(70206006)(4326008)(70586007)(5660300002)(8936002)(6636002)(316002)(2906002)(2616005)(26005)(336012)(1076003)(426003)(36756003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 06:48:32.8448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edeb4166-9500-4bff-2f1e-08db672335e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's more reasonable to check EEPROM table ras info bytes.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 7f134c3b0b14..9eceb3bc1058 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -355,6 +355,21 @@ static u8 __calc_hdr_byte_sum(const struct amdgpu_ras_eeprom_control *control)
 	return csum;
 }
 
+static u8 __calc_ras_info_byte_sum(const struct amdgpu_ras_eeprom_control *control)
+{
+	int ii;
+	u8  *pp, csum;
+	size_t sz;
+
+	sz = sizeof(control->tbl_rai);
+	pp = (u8 *) &control->tbl_rai;
+	csum = 0;
+	for (ii = 0; ii < sz; ii++, pp++)
+		csum += *pp;
+
+	return csum;
+}
+
 static int amdgpu_ras_eeprom_correct_header_tag(
 	struct amdgpu_ras_eeprom_control *control,
 	uint32_t header)
@@ -414,6 +429,8 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	}
 
 	csum = __calc_hdr_byte_sum(control);
+	if (hdr->version == RAS_TABLE_VER_V2_1)
+		csum += __calc_ras_info_byte_sum(control);
 	csum = -csum;
 	hdr->checksum = csum;
 	res = __write_table_header(control);
@@ -739,6 +756,8 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 		csum += *pp;
 
 	csum += __calc_hdr_byte_sum(control);
+	if (control->tbl_hdr.version == RAS_TABLE_VER_V2_1)
+		csum += __calc_ras_info_byte_sum(control);
 	/* avoid sign extension when assigning to "checksum" */
 	csum = -csum;
 	control->tbl_hdr.checksum = csum;
-- 
2.17.1

