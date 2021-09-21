Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C02FC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC4A761168
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC4A761168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF3F6EA8C;
	Tue, 21 Sep 2021 18:07:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E002B6EA32
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2AUwXlYZtTg6Qv5X4Y6EDdo+qfy8kAoe5u2Lfj3Vcca74Eq45m1mZ28Ppeawgvuyv/0h/w6RAd5XiAZgexXQdzHeKOkuV0bBlzn5F/9mu7q2+oSj/vKMU3xj5fyc0kInZRA+se50gAd+/eRv7ztpHcPJM1/vmJXXP4hy65qf3A3tNzIjCFTulEHxTOxr3rliSe/mYAhzbLqeqOBqeOLC2EQ2KyBJNuc4uahgw9nemvSv5PrZJLamRJjr9c7TxaUKGGxqiyBavUe/u8HVSixa4DwCKlF64oG2A0krBsgtVpOJEw7MTImHlgmuK+5+sGkMWZtK6LzMozqbbPnuBIvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=jyWRnkeEIqqtYghQlkMtwtSnoXtkyp14iCNvr5INVR0=;
 b=dARKt/v8zZuMw9mlexwMYw/u2ARmoYKWpxVLsrqMFj6r/GiAQPnH6ZwZHAXog4q6hKi/VscIr+nx0rifqruH+Vct8JiCZzKyko+EOUkVQedzEck9Ix++Q+4UyjBdyqwDfYrmLQeRTnDdAwLRDCe8DsiXFOrYfJRpUT6+r/M+8dnzwGReHQOT4/HG2oYMqUxdy66sATUXu5CBxj7NSXipTrN73+h9jcBFe8HdLak3yw2faPZTUalr5GAQfCnqkBkKeoIz7qChaVrA+Sof3sa1H/991coItsBHSflRJQiZ4M4uN4QtRYdiSoH3ftRjPjF8+YEIa1giMnaibGqIXdy/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyWRnkeEIqqtYghQlkMtwtSnoXtkyp14iCNvr5INVR0=;
 b=g7kVkv5MK/gHjPtwdC8uOrAcVPw1HsotDlkoE6yBA/FUV0r6EfYW1I4mQ1yItDelnjGul8cu0PBytc9W/3T+x83IGMzRtpjaBAMzM+2oTS6YrRZaDsnlU9Re8u7MLdFLqjRHWz6jXprXT0/CSgIm1JLpw7AqlhdT+iJPOkGaDrM=
Received: from DM6PR21CA0015.namprd21.prod.outlook.com (2603:10b6:5:174::25)
 by BN6PR12MB1555.namprd12.prod.outlook.com (2603:10b6:405:5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 18:07:52 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::84) by DM6PR21CA0015.outlook.office365.com
 (2603:10b6:5:174::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.6 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:52 +0000
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
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/66] drm/amdgpu/navi10_ih: convert to IP version checking
Date: Tue, 21 Sep 2021 14:06:41 -0400
Message-ID: <20210921180725.1985552-23-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 42a3b8d0-3431-47df-438a-08d97d2abafb
X-MS-TrafficTypeDiagnostic: BN6PR12MB1555:
X-Microsoft-Antispam-PRVS: <BN6PR12MB155504AE4CA6E4591571E47FF7A19@BN6PR12MB1555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RSZ4r2eWDYKfIRiTlOWDnVjQnsR8JYs7//M4YtEUzmK/2edRlsGXsgW+Dei0fZV30p82TZojUnGDJ6J5Yl7pS7xTIjRZrytHwzqLDTdMkxeArU5OCwyBJBlX9seLv9YWP1eTgvMKXgly6LmGxwJlCnxpAVYm+X/0Arw/LmoqkhFk3m7UIDEZ8PTkkA8HRanY8nm+97mf2ObZmYkgugA1rLHCwXXWEFw3L+M91LKtjopDDaFutHl6b08pFjBX1lNgslFUqzjf73YyAeWE1e+5wwREhac+6/SrcOwxP0U63xl5urj/k6ocnfN7wWoJ9W5M1kcUtvRRJo0f5uESiukZ7liGY3OwLP4SikyiTMIE/hextjdh9lHPes0OSlU6VBR1FN4E8lb83hhl+5AdFATtMljpr437lGUsQ5O7NEyNlWjTVywMdIB9HJc/oPT1qqW7LWBAx5pWsJ3NdU1Gk+DqipABwqHr4XMxIjY1XS2aqCjb/5HlgWV3lIq1yfL0oDEcAHb5zlPJQkE0r5U4a94p6a8GY7KDGw2UNCvgY7JGSI7yoCy9T9I87JqqRD4voKbzFMI3qITHlWs1RMsYIPA0oaBoxNqeSC/97+LVWZVPvxxkRejtJM31yg15R2o7D28iO0AFzRCHxh4O9nbsbt6zmS7W6cJJbJjOye23bBn5UDifyRrv8avoDHcoIUg+ZLb72F2i+uMjiyvJv7gk21gqcVCKWt7sIQC7PcI6CT8ggbQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(70206006)(336012)(70586007)(8936002)(47076005)(36756003)(83380400001)(508600001)(7696005)(1076003)(356005)(4326008)(6666004)(316002)(8676002)(426003)(6916009)(5660300002)(2616005)(86362001)(16526019)(26005)(186003)(81166007)(36860700001)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:52.7949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a3b8d0-3431-47df-438a-08d97d2abafb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1555
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 530011622801..c3f968d9cfcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -107,7 +107,7 @@ force_update_wptr_for_self_int(struct amdgpu_device *adev,
 {
 	u32 ih_cntl, ih_rb_cntl;
 
-	if (adev->asic_type < CHIP_SIENNA_CICHLID)
+	if (adev->ip_versions[OSSSYS_HWIP] < IP_VERSION(5, 0, 3))
 		return;
 
 	ih_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_CNTL2);
@@ -332,13 +332,10 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 
 	if (unlikely(adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)) {
 		if (ih[0]->use_bus_addr) {
-			switch (adev->asic_type) {
-			case CHIP_SIENNA_CICHLID:
-			case CHIP_NAVY_FLOUNDER:
-			case CHIP_VANGOGH:
-			case CHIP_DIMGREY_CAVEFISH:
-			case CHIP_BEIGE_GOBY:
-			case CHIP_YELLOW_CARP:
+			switch (adev->ip_versions[OSSSYS_HWIP]) {
+			case IP_VERSION(5, 0, 3):
+			case IP_VERSION(5, 2, 0):
+			case IP_VERSION(5, 2, 1):
 				ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_Sienna_Cichlid);
 				ih_chicken = REG_SET_FIELD(ih_chicken,
 						IH_CHICKEN, MC_SPACE_GPA_ENABLE, 1);
-- 
2.31.1

