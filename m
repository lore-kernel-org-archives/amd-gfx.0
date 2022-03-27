Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4B0C433FE
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Mar 2022 10:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D71A810E35C;
	Sun, 27 Mar 2022 10:42:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B1110E35C
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Mar 2022 10:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQ9hCwpyzYRtCJhdOY6P9Ey9Bb3Dk8stxBry3/fKPq0RL1vNREMLf/BXyugW1zaMUj6gb6MOrlOB5S26+pvK62JEYxxdh2m9NG2dAIVIRGQaztEvnyVl14RTA3uIXMI453bkQvWq1Iibfcr5Zf/s99mvIHAN3DE6f+OUK576GKYXDYkIsS4Iuhi+DYTNp7lV4KOrNzWT+gl4eYvxzyF0rp1qavXHBnQRKbVGlWHlwhbkrzOKbkyvhIYmo+vzz4QJYNkccvUqG4v9pmtEzAkul+CuBeAljId4dVDay8pViZDrk2ikLvTFBwvYjTkovAgt1273T8LaOePKnENhlvgQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0G9ecNPG7jEqo7P3ZNykEA92Q0SuCQV2HtLv9cyKAn0=;
 b=HwOJRidbzvCasDWNV9NELEpeuK0wFLQDNDpuWQKJtiL9vCBg2tUMP6OiAffVzzEULNlYAZVo9u95X757ZEfq/XZ2G2FhN9N6gPrRPh1WqhP4ux0r87IZvjt9jA30QBueFQ308Oii/0OaoDwjkEsm5HtOhvNEjSKhT0igdall1PZ3fDFlqlzy5i2ja+6R+NtXGJQbj0Y8jorAleu+HEzeX2GIlrVYhGRyp6E4679LO6SJsJUT0AUR4gzVMIgWOnEoyOho8Z31RG1DCdUUjFPapHxd5AYBhBM/XMEnBfWFKQgaOpGDG8WF/128w8npQBhEEyOEBOOb5fBgIhSEGfvVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0G9ecNPG7jEqo7P3ZNykEA92Q0SuCQV2HtLv9cyKAn0=;
 b=5BN3TZcuy1oBsgrMMl7LkP8n1Bz7Bf6/6fKLfFdCk1+r9jV0J+8cv5SuAxN0iyaAAO5Wcm9v8Mmxd0wtcQQfXTNV8emD5xT2ZrN0F6r+fW6Du5zgKJ7yHjZExIrRbbxbRQM8FGKx8LhONSlCwn53A64kEghWIndqjE5AxRLp8WM=
Received: from DM5PR15CA0039.namprd15.prod.outlook.com (2603:10b6:4:4b::25) by
 BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Sun, 27 Mar
 2022 10:42:34 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::7) by DM5PR15CA0039.outlook.office365.com
 (2603:10b6:4:4b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Sun, 27 Mar 2022 10:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Sun, 27 Mar 2022 10:42:34 +0000
Received: from pc-32.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 27 Mar
 2022 05:42:32 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] umr: Add command line support for "--gpu-metrics"
Date: Sun, 27 Mar 2022 06:42:12 -0400
Message-ID: <20220327104214.106340-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.607.gf01e51a7cf
In-Reply-To: <20220327104214.106340-1-luben.tuikov@amd.com>
References: <20220327104214.106340-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc23c301-c025-4c95-be25-08da0fde80c4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5706:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5706ADDB1E93D7EAC0B88905991C9@BL1PR12MB5706.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vz/KKPU1aIFUyUtAeY94uRdmfYMWmCVnVcCZqL6aLyhtBxrPV+0VIH8Qbums0oj2hdyXgvYAg3Ufpgv8wy08DxQfAK9FvWIATkXRNw/TbWIpxEzTLaHifBiGXw1hQFBvsFFiOS47PQhAC3R6gIKe3IqUJz4lt1wYZ9PEBejhodrfiY4EITHucKMdFu0yiMHKlWujNRHckkIDHkMXkeg048cq6hSuNDDRZkagre5aNlTmI19KImkMPKsnVVAEabnhSls22pB/jPUBghieV5sDUTUPP5ONhNzpq+hbJ0Cm8081SYvXuAkmhyluRWeLyoIz39dYt7XzGuJdB9vaj1R00LIL6HQ1Ok/kK92UYO4C5GtXfS4vwVmxNQUxMNIEUbQ9kR+BkORo6m04HlSyyaH0TrNJ45YabSjX1YI9bVjv8hV6Eb+ONr8c1Lk5iJEX5g/OpzuAD2H6v/ZB6FfT2oRWQDJxhsgdSOzM0i83aBlMF/lIILlZWANapkVoC8QRHPmtlwcZDrrjgy3FAx7R+o7/eTg3BfTiBpla2cxyH9njqHoRHku4RDgSmv+bfFUlrmnV/jzhWQKSS7ieXCyJdVoSgEtaTH3Iq7MlhLPJJn0hzFb0MJWFir1MgubAjK0gEvOGauzm7vNXOuaYpxhKLj+jseBjk2ShGEPhz7EThSy1jfrrAgrNvwpGLAhlL7B6KDPxzZ4drhnILtGpwCkUhJXWKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(4744005)(83380400001)(6666004)(86362001)(6916009)(54906003)(8936002)(40460700003)(36756003)(70206006)(70586007)(8676002)(4326008)(81166007)(316002)(2906002)(26005)(336012)(2616005)(82310400004)(508600001)(44832011)(47076005)(5660300002)(186003)(16526019)(426003)(1076003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 10:42:34.2942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc23c301-c025-4c95-be25-08da0fde80c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706
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
Cc: Tom StDenis <tom.stdenis@amd.com>, "Jinzhou . Su" <Jinzhou.Su@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add command line support for --gpu-metrics, to fall in line with the rest
of the command line arguments' format.

Cc: Tom StDenis <tom.stdenis@amd.com>
Cc: Jinzhou.Su <Jinzhou.Su@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 src/app/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/app/main.c b/src/app/main.c
index 62ea2f42145f60..6cfbe09bea7b4d 100644
--- a/src/app/main.c
+++ b/src/app/main.c
@@ -861,7 +861,9 @@ int main(int argc, char **argv)
 				if (umr_print_pp_table(asic, NULL) != 0)
 					fprintf(stderr, "[ERROR]: can not print pp table info.\n");
 			}
-		} else if (!strcmp(argv[i], "--gpu_metrics") || !strcmp(argv[i], "-gm")) {
+		} else if (!strcmp(argv[i], "--gpu-metrics") ||
+			   !strcmp(argv[i], "--gpu_metrics") ||
+			   !strcmp(argv[i], "-gm")) {
 			if (!asic)
 				asic = get_asic();
 			if (umr_print_gpu_metrics(asic) != 0)
-- 
2.35.1.607.gf01e51a7cf

