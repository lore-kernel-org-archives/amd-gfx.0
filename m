Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DADDC4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 16:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5329F611CD
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 16:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5329F611CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 081636F41F;
	Thu, 27 May 2021 16:09:21 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2086.outbound.protection.outlook.com [40.107.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A37A6F41D
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 16:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNKqXd/HlF7qi+mA9AMu86SDduMIzjgP5JvwZJb+2Bz5nzndKYqshvWErxZZjJx1k9vwl/wKsyP61cdDABsFvhLQm91CBxK5StDSxlwDYiTWc9vNoQ1dJ6S8hTuettVq7jiJI1vkvmaTQcea46PteckFM75/gD0hWAXgjPT4KlZeV59Ynvv3TdjRI95ev0eB6SF38dI/c7AJ9UcHwloOpg+9ePHtmiqBfec7CPPZ6683w/RvSw7mhXHdwXi1JHqnLn5i2U9RV6j2+bRx6nmgn1VtWUKSj9g9SPlG6vC+KDLXCjB0ltNxDfrLWbvMAcRcgy6tQQNaFIZdOfubQfg+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8bVyP8mZUEdBsWVjMvkTt9JLFXUODDD5skGKvWI8eA=;
 b=DLi2TaLBfymjqKPDPhrpG6EoBWWqXQlxyVrCTuS6LwNedvwXegRJLJxHEFzHIuubtT81pirBoQgLRU/E9K887i/qd9Ro9vAXax3ce7YvEC8vzZezBa+ePRZAgzGadlohYLjI0saiYvoy+Ylf2gNdISeHwQ+pBhQoybLiXKLwaeOA2JZ6MQa4jLzQA+5c3TUdy+zTUb0BehC1Df0ykrws0uMsVQkTQP0kEKtBb5JCe63jgpDyiCTxHnNhBmFumWxNfG0KTzSdj7Qz5vw5krFbRSb2o7wJJpH4MmNHY3Ykvjy8RI40ZLDj2saAs4DbC4zOeMC/xsohLSBeYi7miFT1nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8bVyP8mZUEdBsWVjMvkTt9JLFXUODDD5skGKvWI8eA=;
 b=gXl234XJh7O+3XrFk+QgV8YEjznlKKZIUF3dbjO4SN8410ZGeacvMq6R/SHWvhUXok1X5RFsPWeEZyUftEav91EyWGfzUraqnBnVsc532J0qwV7Qht5qJi9ikY9CJNpmYZ8NTYEIyMdfc/S/nyPkA57MmCIBuXsz/f7odhB7pQI=
Received: from DS7PR03CA0179.namprd03.prod.outlook.com (2603:10b6:5:3b2::34)
 by BN8PR12MB3633.namprd12.prod.outlook.com (2603:10b6:408:49::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 16:09:16 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::60) by DS7PR03CA0179.outlook.office365.com
 (2603:10b6:5:3b2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 16:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 16:09:16 +0000
Received: from veerat-X570-AORUS-PRO-WIFI.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 27 May 2021 11:09:13 -0500
From: <veerabadhran.gopalakrishnan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] tests/amdgpu: Add VCN test support for Biege Goby
Date: Thu, 27 May 2021 21:38:57 +0530
Message-ID: <20210527160857.63335-1-veerabadhran.gopalakrishnan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72cffd53-4e7a-417b-b184-08d92129c6f4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3633:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3633DD413D11F986C6CCB30CFA239@BN8PR12MB3633.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wj4GMVpEQCV82JU9sWXtcSUYolZAceTgj9wYG55AtbvGsdBjj0qHQG3T0xjDLhkYZRlcSqobtE9k0iS4swx4owuyBQy7Je1TDmbzubcXO7uhlXu0NhLCyXxnQkBY6VDWUKITNEdTZlO9+7YgkCbcUEicv8I4vejG4a9XnKaBraJHhWyGmrAao4VSkwOCv6ixbzeUQs7LNGAmviLtz04ASr6BGq9ToFjSTD53JHjc2VMVuWWPh/xd5g7m/LT28vfqQ/k3NYKjrmfwp3kAN2dHkmfzb5+617VnL2382TnIAWg84v+W4gktP7HEvmpK4IZy9pMmGM9a7ztKEUJ5zlRkX6p67QwNRMjVUQJBWFRn82nXH7iVNEF3jsSeG45UMvD+iGbVUnC3xcJmOWyKD5TnOZ9QwWQITrA1K5UNVmC4upNXhnxxnjSZHXVtw1EBVOR5o5vobvEZWxY+7lR7ySbw9gyx4vng9FgaGcCXe+uiwBqObncH6+LfhxxrDJE26vNlDgrrhctTa8s84t7OW3GzJ7HrPAG2WD1t+Bswl70E9A/8MvTeQJdIFf8WEPQ1kRnGT1dzf/uLMwnlrneZceKVKDf69rbw5A4ROq/Hyj1UU6WjuX5Bsfs1i7NQxbG4k0fcvaYHWXFEIinoMoI5nzP71vIEhAALAU1xQGD+dSTliJAyJYlXFAlshLInowO45X8M
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39850400004)(376002)(136003)(36840700001)(46966006)(316002)(54906003)(6666004)(2906002)(36860700001)(7696005)(8936002)(26005)(5660300002)(1076003)(4744005)(4326008)(478600001)(16526019)(36756003)(426003)(82740400003)(186003)(2616005)(86362001)(82310400003)(70586007)(70206006)(47076005)(8676002)(2876002)(356005)(336012)(83380400001)(6916009)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 16:09:16.3937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cffd53-4e7a-417b-b184-08d92129c6f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3633
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
Cc: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>,
 tao.zhou1@amd.com, leo.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Added Beige Goby chip id in vcn test.

Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
---
 tests/amdgpu/vcn_tests.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/amdgpu/vcn_tests.c b/tests/amdgpu/vcn_tests.c
index 628b4910..15d573d3 100644
--- a/tests/amdgpu/vcn_tests.c
+++ b/tests/amdgpu/vcn_tests.c
@@ -142,7 +142,8 @@ CU_BOOL suite_vcn_tests_enable(void)
 	} else if (family_id == AMDGPU_FAMILY_NV) {
 		if (chip_id == (chip_rev + 0x28) ||
 		    chip_id == (chip_rev + 0x32) ||
-		    chip_id == (chip_rev + 0x3c)) {
+		    chip_id == (chip_rev + 0x3c) ||
+		    chip_id == (chip_rev + 0x46)) {
 			reg.data0 = 0x10;
 			reg.data1 = 0x11;
 			reg.cmd = 0xf;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
