Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47F5C4320A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A111D60D07
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A111D60D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 430F56EC26;
	Fri,  6 Aug 2021 16:36:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 184D76EB93
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 16:35:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmxRwxwhoAUZe8p5iMXS8ziTZ567yprTA57IIHVFjuEJs45UL/rNJCkO6QQRbXDi9XYyO9w96yHPPq5SqmPAd8C74i15uKdaK+TIGozYaDnCeqJLnAKJ1aG6b4+KBEw8U8MMDzjNkfSMTrKIFeF8/8ZVHzMZgQqxl5sYJbNZQ+IWBD+pDmD+/GyD0lWJ0zRevd7Xwqa/3m9HChrIBp2iM31tgE1uI6w0e6tLoFYX9cfP3KykP577L6kBGAKjR00LV+nsjDDFj8wu5G8SZwqhI4JUtlGN4h0O2OuL1RA19v9NXF+cWAsxh41gMFVnTGSMFBWFhaIQWVbnNSVS89KElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xEBKwgRHQqJvnFXlsV/7ZKgfDi76bmcHg/OvGf2Lww=;
 b=QnjlQ94u4QXPYS1Qm5V0rwu66pR6rEO3HJrPydLa9SxvpozBwiv3IEqPE5zxiAxD8xf0m/INfeN16AwHqpzcETC9POBzMWS8593MIPVNyWLl8Ed4IEm3PE+c3aMuiD5TWCgaJ/cZySlMQ73qq+04W9fgbNfHYlPvt/U3oG0HGVluQ7L7zyW8K1zMvn09fIW9mBW+yNwYJfiYNfIc6lr7vGQrdLfnCZuWq+SMRONJ9G3SemnN6WHogQQFOOO1ZZMDoO9Q9ofn477gGjbvgA6xD360aycvYg+hKe1t+m6kbwq2E8KlbR16bj0C2rE1j28i9+a8kfWK5rDLa0p0tMbSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xEBKwgRHQqJvnFXlsV/7ZKgfDi76bmcHg/OvGf2Lww=;
 b=KArXlv0+VScNUoWtiTCHgLNWOgGeekD+/I/8JgOSlj1EKQJNOEsJHFH4EO/QVGIrcpeYvset2I7Z/tboJyeOEFjFelCDtVwkpq7/lBqaCKK8Q3oS06ndxPmVXJAoZVH0cNYa9mTxCySgYVA4PvmY9XkFvhs+daCgbJmJJzEGCac=
Received: from BN0PR02CA0045.namprd02.prod.outlook.com (2603:10b6:408:e5::20)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Fri, 6 Aug
 2021 16:35:44 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::2a) by BN0PR02CA0045.outlook.office365.com
 (2603:10b6:408:e5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Fri, 6 Aug 2021 16:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 16:35:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 11:35:43 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 6 Aug 2021 11:35:41 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <Eryk.Brol@amd.com>,
 <bindu.r@amd.com>, <Anson.Jacob@amd.com>, Roy Chan <roy.chan@amd.com>
Subject: [PATCH 06/13] drm/amd/display: Correct comment style
Date: Fri, 6 Aug 2021 12:34:42 -0400
Message-ID: <20210806163449.349757-7-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806163449.349757-1-Anson.Jacob@amd.com>
References: <20210806163449.349757-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d5b40df-17ab-4356-4c1a-08d958f83cd6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4314:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4314DCF4C4D34E9766E5261CEBF39@DM6PR12MB4314.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:326;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAMltfRRMNJMcXn7udO3+k+FusTAHvX650V6pwdp6pIppjUQUz8vuhMMkcHyJ9NySKdNIYBnpxDKjW/6WJ/ogoYQNuz0wZQyqqlOcXqb3xBXKpLGlvsA9iK4SPmh8OaTQJFu+hyEaz21S34eyPBnDNb7DJ56Rfi8ZLoUF7YFtcK/5/pglKjUeXKa+ScvZu/wY/0lyRSIwctV53mqZ6O1ID/OxBVGBYCU3xh2YQ2yf+Ao8YuMH09N8abFW2NaH8PEjN92aIYf/qRhUINZNYpytPdw1msPyYgJlDpfUABMuNyrFlrzETpvpg8vvNm5aRu3d77NE/dimPwmHtZgtaciANqO80jAxblCEEYpQ8NpbbcQX+PA6DvO/kJ0aQYnDEeSMdB+72UODP1DuK1cFcRo6I5fCSmN17+8oXo5JIW0A3n77LgPzeVapDiMoWHsK/rhaJbDlACW2xY2Z2Vu8XpK74oAXFAozw88v++gwbJ+llVZLg8wZRhuAAXajSNT7OjBhsyxfkKv9HAj7FFt0fFUKMeF8w72ALylPreBQ65RzfWt/3VPC5yg2GwhLD8rxDiyrKV30/ph2Z9Qy6u1MD6Gwb1EbXxhJuK/KTzxFIQyNGO7RR77xAxJnTIlgIMay8ZCkMOrdYe/6VfxyTpc960f6MTuRM+lj4L5RVNyeDap9x/srCWwNIoodeIqyRY2y0chqud6YE6/1RKvbCJC21Xvk0sgER158qrvC0cIAMOSbgU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2906002)(2616005)(83380400001)(316002)(336012)(26005)(8936002)(82310400003)(54906003)(36860700001)(47076005)(186003)(8676002)(7696005)(4744005)(6916009)(81166007)(1076003)(36756003)(508600001)(70206006)(86362001)(356005)(4326008)(5660300002)(426003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 16:35:44.5016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5b40df-17ab-4356-4c1a-08d958f83cd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
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

From: Roy Chan <roy.chan@amd.com>

Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Roy Chan <roy.chan@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index aa2707e469c1..661b32a5ff9b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1438,7 +1438,7 @@ struct dmub_cmd_psr_set_level_data {
 	 * 16-bit value dicated by driver that will enable/disable different functionality.
 	 */
 	uint16_t psr_level;
-		/**
+	/**
 	 * PSR control version.
 	 */
 	uint8_t cmd_version;
-- 
2.25.1

