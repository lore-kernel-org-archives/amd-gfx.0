Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BE0C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 02:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C666110EF7B;
	Mon,  7 Feb 2022 02:42:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC86510EF7B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 02:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUihr0EMxQM6q7wTGjwCgdAojlFIxWVUwGtd8H7DfYN+7+dQwXlivBNx4c9QPOKzm13Flu9GH8wNf8x5AjJQXGo4jzQ1ZwHcNhJ5R1fd6nljZL3yImw3VkIPINXCgq2hei7jA1p90zhRi4Ghw+m2bJkFdH13kGBpICW3Qs067Tn05P0StmQ+cr6RGV6wevQORb+DPW96EsWCXgX2iLs8eBAUsrQuD7fggWN2rNpWZxQTCU1ZrsjEnapPNKjVKggAHiugGc97WPONHil8HO/MkpcOX2IZCMup598G0ZOgCNe5eRSBfZO/k5+rSZnY6ZqfxchUZsRG8aDEkQt+vh2f4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ln/8tEVw+/d5NLlNaB1K9Tq1Mx8lGdscULIbETRyCeo=;
 b=J4JOttishNIaNKGmT0i7eQrmsiUe5BNuD+1ayQeUBA44phjKFARrt3GdXkoWrrSolL+udNrJO7GIFmSt+VSsrxCxRolCTO/sKmEvm+HF0VRI8Zer1ZAkkP+r1NKegoTggzAMNVCVj3A59j+LnZIVGz+vjB5ieJFrsgrDpo+h/NK44OzY/yMqaJ80TNaUaDhpoWJUTC9JNZ2hB/KgXvYHRAngYHoG2ltTYQYq0s5CEK2eJodZS7SRs26Q4ZPlOHTR0jzRA77ZaymyiBPEVuPqPII6SlAsbxyGnwH4A0foHpxHtFRpdXMIZZbUv3AIKi2pi6Aq6iZY6mjI1orxbACAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln/8tEVw+/d5NLlNaB1K9Tq1Mx8lGdscULIbETRyCeo=;
 b=nx03l7mreQl1lbcR4faaW0mIUCsJcT4wRzGXVNBmAVh8Q6XAsEzGFgWauG/0iOjA0f9gmkA3ELC+RtcO02Q3GtUq9L2AB7TXfG14znvcfMjIOnSRu+Vog/dETenM2cUIwneDmzdVuph8H6TiMQPualYeYr/961r1VBLdUz8M3sM=
Received: from MW4PR04CA0103.namprd04.prod.outlook.com (2603:10b6:303:83::18)
 by SJ0PR12MB5423.namprd12.prod.outlook.com (2603:10b6:a03:301::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 02:42:16 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::ae) by MW4PR04CA0103.outlook.office365.com
 (2603:10b6:303:83::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Mon, 7 Feb 2022 02:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 02:42:15 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Feb
 2022 20:42:12 -0600
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add utcl2_harvest to gc 10.3.1
Date: Mon, 7 Feb 2022 10:41:54 +0800
Message-ID: <20220207024155.414712-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b010d32-8d6a-4d51-cf7f-08d9e9e37396
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5423:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5423D898FE6FCD605946B6ECF02C9@SJ0PR12MB5423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PydEvj/Xro07HMe8hjWqqM9P4iDr0A/ary6B+0KSam9XfU1qNym+9TKPW804DzmVRtUF2rqd4SXw8BTfYxjdouV/zpi2wv3gjFrJsB3epPFcVcWtA6JNT6gYG4SCLjXJU0GaKC+uGKyWMI+h948oSR02aXqPYeF5uy4lPZNn6iRLSM8geLV+QTHQuWZXkokS7Hju+HiHkKh3rsamgJQTAIay/Gq182PAT/xcHumKdwLD2aYwk3L1ywWqSFK7GabJ9MCJonvJt5T9vCFXWU7eip2R7fsjqLMa+JXJDdRq2U5i9g5wEz9J56MlRT2VW5mwpzNZQFNCalbc9HbiGrMG/1P3l7xdu+G+X2dbjc2FX/TVDu1d8qnJRX/SrN/dI2gHP+Ju4Gum+hy7fEwZ1GhX1r+R24bMa8kYQ0AO7piDalUGpwogOi35gmV33db+qn3k9vVxqGdBQpS/0b3lyo3faXt9rDV9QNJbzX9mu+JZo7aANVKtKA2rcL3nVcSt6g9VM7HTD/5hqRnhki1Qo3ah4IFAkZ6SLkUMFPEHQS6crAyb7gVTwXnV//AGCE7Dv0/c692tQYZYSWMosGsCBYiFTIDSUDX5UfaDj/uZZTIlX5RnoHLxHJcHZFJFGr3dkCyoi2kPr3D9DHw2VV1anjMiyTUq1NH7WIr/E3dIQgGUxLp4zk5SD2PgQgGoL4OONxkkrEzkn//ax777sUFR9ft7tA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(356005)(81166007)(2616005)(44832011)(5660300002)(47076005)(83380400001)(82310400004)(26005)(186003)(2906002)(1076003)(36860700001)(16526019)(6666004)(40460700003)(508600001)(316002)(8936002)(8676002)(4326008)(70586007)(70206006)(54906003)(6916009)(336012)(86362001)(426003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 02:42:15.3872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b010d32-8d6a-4d51-cf7f-08d9e9e37396
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5423
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
Cc: Alexander.Deucher@amd.com, felix.kuehling@amd.com, Ray.Huang@amd.com,
 christian.koenig@amd.com, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Confirmed with hardware team, there is harvesting for gc 10.3.1.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index b4eddf6e98a6..ff738e9725ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -543,7 +543,9 @@ static void gfxhub_v2_1_utcl2_harvest(struct amdgpu_device *adev)
 		adev->gfx.config.max_sh_per_se *
 		adev->gfx.config.max_shader_engines);
 
-	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 3)) {
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(10, 3, 1):
+	case IP_VERSION(10, 3, 3):
 		/* Get SA disabled bitmap from eFuse setting */
 		efuse_setting = RREG32_SOC15(GC, 0, mmCC_GC_SA_UNIT_DISABLE);
 		efuse_setting &= CC_GC_SA_UNIT_DISABLE__SA_DISABLE_MASK;
@@ -566,6 +568,9 @@ static void gfxhub_v2_1_utcl2_harvest(struct amdgpu_device *adev)
 		disabled_sa = tmp;
 
 		WREG32_SOC15(GC, 0, mmGCUTCL2_HARVEST_BYPASS_GROUPS_YELLOW_CARP, disabled_sa);
+		break;
+	default:
+		break;
 	}
 }
 
-- 
2.25.1

