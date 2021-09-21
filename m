Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893E2C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDA160527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5CDA160527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8214A6EAB1;
	Tue, 21 Sep 2021 18:08:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA1166EA91
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/YCEdIzVyi62ZuHxClShs+dd9NE/TbJPFRi6G4gqXAfH8ojuCMUYwuthLRpD3EHx8XNPYJlDbHlJHDKJNiaiSl+OYMkIwLWt2pryjAMKCAzE5ygLcHW/DUkpQCN26gf12iT3OgnDU2BrEVcrSnculG/pXXv2KdRhfKUdxy1BkBZ77w9Nuu8Gn5ALHex8RP5gcjyhL+nAfjaLb7txVDM3j7NqRA+qD6zO8i+CMDICZDfh4qk+mGptD+onILaZOIVCDTz/4UWYXaaHdpz7xsTXY7beqKcS7CK7JbmBeIX0UZt5kCexohc6Vj7rmvpE/yNRJKlTViieYg8mo2kwOAuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=JmJHCZDlVY5vZJRR6dclCGP3w0WbLLv+TON1C0tdutM=;
 b=D4vPnpjYahrdzmuAHc+k1UKh4+DboOjUqBYS7i9Mb0yKEveQEVJUAunj8WhsTYEDqfj4CrhZRyEs3DDgXgvZh3+TqvSRDoZvGikpTUPaZaAGBUx0tsKsTyOK6sjZl3BS8CnWqdY5Pj6z3cygP/8sqnv5wErnWcFgQfZKahFdPYvhG+y7bamPw7a/cMfQCroioHhcXXGkWa85RtF6XewLJWUiIdycgmW0AKNjvsKgy1C4gCAS6h5RriI4z5zw1nA3pB+qiPVNyF99dlxPhYwH7VcGMveAk0hSArCELj9Sh9qaiazaXt2q4NMNP1kiRJo7H86PcxO5D4stg5vhzyIEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmJHCZDlVY5vZJRR6dclCGP3w0WbLLv+TON1C0tdutM=;
 b=1zBtr2P5OIhamvIrPeAYCQZCEvtrqJIwaHqXJ3ZOeZgHjTPV3rlFYglapoA2Q7LUw+XhJV7TaS+NGfH3/z19TmSnEdTlcCbMdGuEhTl1s6LKh/Ua7+b5FkGfSirLG8GUIPH/LUSw/rh4gqJKN09l/5VMP9jII/v/Ib85T+bOHN0=
Received: from DM3PR14CA0129.namprd14.prod.outlook.com (2603:10b6:0:53::13) by
 DM5PR12MB1321.namprd12.prod.outlook.com (2603:10b6:3:78::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 18:08:08 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::a) by DM3PR14CA0129.outlook.office365.com
 (2603:10b6:0:53::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:08:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 60/66] drm/amdgpu: set CHIP_IP_DISCOVERY as the asic type by
 default
Date: Tue, 21 Sep 2021 14:07:19 -0400
Message-ID: <20210921180725.1985552-61-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b9f123d-450d-466f-e959-08d97d2ac470
X-MS-TrafficTypeDiagnostic: DM5PR12MB1321:
X-Microsoft-Antispam-PRVS: <DM5PR12MB132126BD7DA2931B32D6E68CF7A19@DM5PR12MB1321.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vBMMSGTQJGqqBkpkpUoouylM7Wx5OHMInUljzq1kuPuhv2vX4sMvxFd+RCBoIfFPUOzW94XWT0PsfgFzl2wUf0Rl8YmGXlmCGMSBWOPNUNG2//L9KXt2lSwbL27kiK5KyR/vccO2oVfU2lfrD08NrAON0M4OL55iSbkJA2smFZ9PPVHIhKjwtoGAlazfpT5+GHTHd43NDkfSArphlcN+rrqb74K1jkTKjefKHmO9X9D8/o+QKZY3Kpj7vLym2FZo7hh+WHrHavhBo2VdwuJwjBbtqcUGi9QxDzcP+9FXH02nU+nSzhs9yUP7KbEGPCQldypyLR8cdlKuBp7ZYn6ldqJg8ci2VlW2j6Y6fspJxJWove8jN+Yg8ARJ93+ke0l63T7Lh8vRlybUKkrJK8nFITYQT6hsgLvZVYbCqb1RM0fIoaganEpzN23Xm8xLFxuCIv6mTBhNbLrbR9XhxmOuPcJWESxVLJFXLEZi5p3XZJ0P8iDig7unib6znak1BPx9XEHdKggp1KMLNv8xEFh8uXg3tmlfS931DetuTvHecI0+lyAKId/MMP7dcDcipiukN09I4D4R7C2Eg+WQ7rKeLRmlLiTS7sU22CvQOo3dXUeMkdl9GzKltW/z+pC57XrgFhAieQfbbukyfMhFV3vJ8KKfTaOenDZcGnScb5DgZSczEOpyO0V1TzzOkvI6jxzE+jFjoiD773rjbqBkZGUqIeFASsS3DywUBQdSuozvBTI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(26005)(36756003)(6916009)(36860700001)(8676002)(356005)(4326008)(82310400003)(6666004)(4744005)(81166007)(1076003)(316002)(426003)(70586007)(5660300002)(2616005)(70206006)(83380400001)(508600001)(186003)(86362001)(8936002)(2906002)(336012)(47076005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:08.6668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9f123d-450d-466f-e959-08d97d2ac470
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1321
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

For new chips with no explicit entry in the PCI ID list.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c21eac6216a8..c7da1f7cc880 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1796,12 +1796,12 @@ static const struct pci_device_id pciidlist[] = {
 	{ PCI_DEVICE(0x1002, PCI_ANY_ID),
 	  .class = PCI_CLASS_DISPLAY_VGA << 8,
 	  .class_mask = 0xffffff,
-	  .driver_data = 0 },
+	  .driver_data = CHIP_IP_DISCOVERY },
 
 	{ PCI_DEVICE(0x1002, PCI_ANY_ID),
 	  .class = PCI_CLASS_DISPLAY_OTHER << 8,
 	  .class_mask = 0xffffff,
-	  .driver_data = 0 },
+	  .driver_data = CHIP_IP_DISCOVERY },
 
 	{0, 0, 0}
 };
-- 
2.31.1

