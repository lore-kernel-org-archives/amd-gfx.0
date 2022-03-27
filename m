Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB96C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Mar 2022 10:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8381B10E337;
	Sun, 27 Mar 2022 10:42:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE8B10E337
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Mar 2022 10:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j64yn/Tdc1G2mKLMaKODs4oITgQNs/frZLQVz75d6WCZQnJErcc7Vb2nc7BWZP9m5S4LLUje6OX8njvFFQZAcH75yHxk8p+1KY6rnV6plb3EC/St83+eE0Y/XNQjX/K+pH3WOXDEVHf655cYqmK7QEauSFWpDRenxX8aFc0HW8cvzS381Q03FNFcKYIXCEnvuTHwi+aNb4FzI7e7sCwlHl3BajIoHWoF6TK+MzHlpL8AgB9UUQDeJX9kV+Bqp6tpv9il78Bp50NhMaXfyZcwDAb+VWoEja98KyG/j+NbrDxeyOGVTh/gjIBkCwCOlX429LCf/jrytTaBV6OcAwlAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckvL0JWV9ybxl/Llm3AJFD23hLowg3MsTLrjx02rwK8=;
 b=MiCrCQJoiSPe9cGfb1QE9c+ZzxSB48g7XmJHgnkVQ0LBNSDQPuaxsv82bpul/He+lKibMRcxLNXtR6uRlCQsHKoYTrvI9NdHZGARqcdm//whkmgSa6EBvsmf/+JfbRuBo0ec/F23j2n5GR2ntqUAQV3m6fYGFrnKQ2NXC8ggj+DD30iWxjN2BMAFNhM+JJUuuK1i7iTip3D/O/aFtx6R9Zm/OVOsY3NmHy6LZO7+8qnaeH1rjfWUXC880sfWeUF7DGZz82hvI13pJt2LWp2up1ITG9sGaQCod9qp3YGtyF9bNFfXtJ3pbFKPBnIkP3vtMSNHU9CAh6LxhQCbq1cxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckvL0JWV9ybxl/Llm3AJFD23hLowg3MsTLrjx02rwK8=;
 b=3C8z5SW+R1cA7E+zCVYtAhBHrKB1GpohPjn2nOyKPpqVjCI9g4fyxUntQTmIC4rg6G1mYFcbMUYi74XPY/nC3CwogqoljRAfG2NZ1XfpeACMsEg+VqQPJcaQcJuwvNWOGopmhQsBH5XONd4GX3IfUN3y/Q6ksz9v0yhAjuSKWvQ=
Received: from DS7PR03CA0066.namprd03.prod.outlook.com (2603:10b6:5:3bb::11)
 by CH2PR12MB3909.namprd12.prod.outlook.com (2603:10b6:610:21::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Sun, 27 Mar
 2022 10:42:33 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::84) by DS7PR03CA0066.outlook.office365.com
 (2603:10b6:5:3bb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Sun, 27 Mar 2022 10:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Sun, 27 Mar 2022 10:42:32 +0000
Received: from pc-32.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 27 Mar
 2022 05:42:31 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] umr: Reorg and print the message on ppt-read
Date: Sun, 27 Mar 2022 06:42:11 -0400
Message-ID: <20220327104214.106340-2-luben.tuikov@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f79c27d4-dab5-4b57-c1dd-08da0fde7fff
X-MS-TrafficTypeDiagnostic: CH2PR12MB3909:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB39092173148AA2484C95D744991C9@CH2PR12MB3909.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3OIzZYvkAA2i5vNa3fvHDXO6qdi5N+u20wXd9ENPCsHOm1aAMQI/Q0iiX6Cy6A8JEVKrb73RQqYegnYdb1335SMUQxiIvX3hg0gQJDKvSctakOISeMeSaGxB/4IGzZvzpVWkE01hD1ZdTQq9uCpUBZ5UezXA9jfIYKco41Quxli5CNo5dXdH6SZKQzVy8Miw9V4caw+Z0jHczelWNAOxWcb/0z/yQ5fuC+O5NDqV3O7uVP+u9TK0OHgsyLzq6KewJrGNWcUWUB7l8hetDlevd4VRO1LzL6JIBGMxD7FDZ0ATT0pYIOeZKPMWdD5rgp7x/V+I2I5SF9BJk9rSujsbIwc2VeJ0Hs3NNgwxgceu0V68rcYrq3FoTemdBxFvwrxzvzmyrRcK2yl9tFvGlbBc9Csd0cYGsZ/B1tCbQNFYzXPgCK4wZOYYmF1eGS/juoKLuzrelo80/G72vz5PNdWlnhL0I6whKs+d/ZtjWsrsfJUGuypIWldIwrSJqmBEviI+vTYN/0wTy7o4O5z6P0BhRuT15Qy9oOFNRDwX5qUVru4EfB0AimBILNQXYX/B1yd9ZH8ZDYQo+OB7dn52NatvbfnM/n5+/V0URCZQfu1O0wdMi6MYbwHZjVGOnxuAtfRr1321OC8NaPkw36QK3DPl9TriFWOSmqPU0mbLju+YGh/8+tAkGzJs0wb2QEbzWdoOmLrc5752jE8e28glTP0Cg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(81166007)(15650500001)(36756003)(70586007)(4326008)(47076005)(8676002)(316002)(83380400001)(6666004)(54906003)(44832011)(70206006)(426003)(6916009)(2906002)(36860700001)(86362001)(5660300002)(26005)(508600001)(1076003)(336012)(8936002)(186003)(2616005)(40460700003)(82310400004)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 10:42:32.9876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f79c27d4-dab5-4b57-c1dd-08da0fde7fff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3909
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

Reorganize the logic and actually print the error message when the ASIC
doesn't support the power-play table feature.

Cc: Tom StDenis <tom.stdenis@amd.com>
Cc: Jinzhou.Su <Jinzhou.Su@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 src/app/pp_table.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/src/app/pp_table.c b/src/app/pp_table.c
index 9ab42a9ae2296c..33c2d01e897ef3 100644
--- a/src/app/pp_table.c
+++ b/src/app/pp_table.c
@@ -20,27 +20,32 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+
+#include <errno.h>
 #include "umrapp.h"
 #include "smu_pptable_navi10.h"
 
-int umr_print_pp_table(struct umr_asic *asic, const char* param)
+int umr_print_pp_table(struct umr_asic *asic, const char *param)
 {
-	FILE* fp;
-	int ret = -1;
+	FILE *fp;
+	int res;
 	char name[256];
 
 	snprintf(name, sizeof(name)-1, \
-		"/sys/class/drm/card%d/device/pp_table", asic->instance);
+		 "/sys/class/drm/card%d/device/pp_table", asic->instance);
 	fp = fopen(name, "r");
-	if (fp) {
-		if (strcmp(asic->asicname, "navi10") == 0 || strcmp(asic->asicname, "navi14") == 0) {
-			ret = umr_navi10_pptable_print(param, fp);
-		}
-		fclose(fp);
+	if (!fp) {
+		asic->err_msg("fopen: %s: %d\n", strerror(errno), errno);
+		return -errno;
+	}
+	if (strcmp(asic->asicname, "navi10") == 0 ||
+	    strcmp(asic->asicname, "navi14") == 0) {
+		res = umr_navi10_pptable_print(param, fp);
 	} else {
-		printf("Powerplay table feature only support on Navi10/Navi14 now.");
-		return -1;
+		asic->err_msg("The powerplay table feature is currently supported only on Navi10/Navi14.\n");
+		res = -1;
 	}
+	fclose(fp);
 
-	return ret;
+	return res;
 }
-- 
2.35.1.607.gf01e51a7cf

