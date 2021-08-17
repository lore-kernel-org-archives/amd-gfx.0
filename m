Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C65C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 04:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB3B60F5E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 04:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0EB3B60F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 780226E0F3;
	Tue, 17 Aug 2021 04:30:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 365786E0F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 04:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ykid5fkUNFYdrTOl8+oO2RHpYvMKbBBiy6fAGuAmgWtySue6tCftQ1wl/wzoZ91uh6eSrYjeXbwTAOVYJK6/T1KGbFATicdO8wUZHQWHDeNkNF5TShPe6X2kxSulB35aHGhmcoh0fo1CIoMCofVhCwEBWHBpmJufRGj/+ZIjXW5ddk5r7mfF3p5uMGCCz1Rn7xjlHaJLDv+d+yo0QpzNpgfCPYWCPyGXAzLf5h6MTodwWyEy9dQL5nLtL2+zihVlfQ5XJeRDML/3jcnMxSBD2+Xjq8MNMJajpqLwlLyq8gQjvq7wpaeYfFGJZU8d1ujMrcBxbsM3A2G40fpt47E7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbsbMMYJnjcgSJxXkAl3vbt4lL8XBP8pguLULb9N71A=;
 b=TeV5Jf+IWRvKwTp+u8rAAwmry8q3QTc7+4Xxkxt9nI+3uX0oj2sIMUxOYeCQVqwIRjhEgkCRKONACAuGkJ1ivjPtyUp+D1E16FYqX6xNxPFTakmcxJPLbZdzBJQPTtQDdBXcYTqqgqXvnBA5uGC9r8rY9dd1ycAFkU3s2PnwLDgjMT23Bkwhbuk1xmiMAdGWhSj+lar62C+7XgapIdMf1+dvCMr9TYbm8GMhpnGYHq2CqGLTaEZxGTTg+aLpq+KwxIl9YN/tNDV8ZWvY9vl4RONL6HqSyQAKt3Z2fpscjVl+1cYv9EjJ6xOqJ+faANJB6yPbcCntOh3ESNBXiuba9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbsbMMYJnjcgSJxXkAl3vbt4lL8XBP8pguLULb9N71A=;
 b=zNgH+yS/8hIbcxbgQGYiocnPtl/FOV9u5YC3d6JD6uiqeEoh94sWotMjQILTNDwMG4YXcuKmninCngbUUHAqJGBYhgZZUVnw/cw0xqMrkCQlK8zayW0EnUFidZQz4n9ZJPpsMxKZIBb4AhI4FYOgB/tudvN37xnpUc16Jpi/fwY=
Received: from DM5PR19CA0038.namprd19.prod.outlook.com (2603:10b6:3:9a::24) by
 MWHPR1201MB2541.namprd12.prod.outlook.com (2603:10b6:300:e5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 04:30:22 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::df) by DM5PR19CA0038.outlook.office365.com
 (2603:10b6:3:9a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Tue, 17 Aug 2021 04:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Tue, 17 Aug 2021 04:30:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 16 Aug
 2021 23:30:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 16 Aug
 2021 23:30:21 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Mon, 16 Aug 2021 23:30:20 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: increase max xgmi physical node for aldebaran
Date: Tue, 17 Aug 2021 12:30:14 +0800
Message-ID: <1629174614-2218-1-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 574ab17a-9748-4a5b-7182-08d96137ba02
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2541:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB254125BEB8E996F7C5E1D874FCFE9@MWHPR1201MB2541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BBp6yliHpH1iEaUWIfClV4ur6725MT75yTv3rukrNKIe1Wl3RVhvr9rH85QNw5efc4qzkEtkPtUkcLAMXkT8Dtllf/d2hOBWZmIIdbcISv9cPvjsmZ6IREE8zsIPgzNl0lf3tEdMuGVkfVlDy18dXaICeLSyGlGjnmwTs3bIdXY5+oCk9ZzKoGd1t62DUo3fu8IiVdL14HmkXhyR7zOP246rWSlhltMWHO69EivanRMeRg3uraQOSiZ6fOEPQDTkwq2PlRnjcjX1aJ+oJ7jtawxlYTeQ/TXhy7aZBzQAHSBywl0gJ8PdmVPGsXmMvCnGPSERo9+osHd/aTUMjVLDruFMLBwO8aKIa1aMj+T4eu2mg1SQ96wpi8u4baszEIwGfducTL4AOcS8t9YrEoqFsMFV6ja10dNyU+b4uYzvZFqLVA1VppXJRwJops4b0vchcjg9GPj9xkFNEATclUNdMR5CWYV2PGjPb+rRudCULT6FOgFKfXOlDvP2OdLWAJ0cjFU8hICspDfh59fVWVYsa9oTvOWgTTpGFU6FumgPRinv2GbDe95i0U3O3LQBRBcKb7B7pzssV/j0NYXe1GvvgoI16Fd/ZpwVopfrh5z5K6e1qzBpkJ4EAnndpnk2FgkKB/Z9t7gJBUoajKtJi4D/3Ig+pjT1yJmgLFZVRS44OflfUPP4YL70dHGGmrBzwTGeR2DmzfwIOD/3e+ND4ae8Vz5Lyaa3QJHkKu73hnjwSSYuikY4oRie1H4aUB5xykGLbjtvtehw/oub20nwf54CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(36840700001)(186003)(70206006)(26005)(6666004)(34020700004)(82310400003)(478600001)(336012)(86362001)(5660300002)(6916009)(2616005)(36756003)(8676002)(8936002)(81166007)(2906002)(36860700001)(70586007)(82740400003)(47076005)(4326008)(426003)(356005)(83380400001)(316002)(4744005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 04:30:22.0514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 574ab17a-9748-4a5b-7182-08d96137ba02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2541
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

aldebaran supports up to 16 xgmi physical nodes.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: John Clements <john.clements@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
index 8fca72e..497b86c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
@@ -75,9 +75,8 @@ int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev)
 		max_physical_node_id     = 7;
 		break;
 	case CHIP_ALDEBARAN:
-		/* just using duplicates for Aldebaran support, revisit later */
-		max_num_physical_nodes   = 8;
-		max_physical_node_id     = 7;
+		max_num_physical_nodes   = 16;
+		max_physical_node_id     = 15;
 		break;
 	default:
 		return -EINVAL;
-- 
2.7.4

