Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E97AC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 05:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E2D60E0B
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 05:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E7E2D60E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 873716E04A;
	Fri, 27 Aug 2021 05:42:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73BD26E04A
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 05:42:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3aV8b3V4B7N5Ug6+EHP3QCZPHJkJYF8wYRS2imA23pSbIsALPsJC+yBf67geBLOJuAjsFUeFf4YvXHb+TWRXem+yGmEV+P2tFKe6JJZd2e4ALHLPoQ0zVKUrJ/JgHRsf6ChGRwnyKTvpPRUOuoHLv1S2ijq0BMQjbPAfsQM62zQ6a6f6aueKmhkGDSycppWCa9JgAWs5xohZP22HXuyeyd93mxmbKeQrbv4XYv4PwmPNvEXLG0rn8LDIDEaco4KnmSNiQFZC5HOqzTG1nWI+74oVQ3hop63HMwBUvUs+5qgmLqPX1F73rAevqog2NNkT71HceeD1LvArWh+Nt3hTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXmSkNSNkeFa40Yu3SkLbLWaueXocXSemKDtJEELy5w=;
 b=bXmjQPc1Jtb+LhfHw2IgFkVP5JZxx1Bn+2Hg3qZawVumdgP3t/TyjqSbMhRZ29uU1yTpcmfvDhUfn81wovrzXICEpOwSorl4vulZuUoEVTva1zdLOnkUkvXgi80IZ7F9/FKF611U6dmOyXQC0OGc/ww5qQOEzTrDxR8bIikLGw+iatuAH6pBStAhIPFlbnu85G7LJl7k4nfwbjd7AjgE+nqHmuknKLmfT4Sf2MmldLZR0gOLqSA1dH0KItY3OHzmbrPbiV4Uj279Qb1wS5ClZgabIuNTPDGj8imQPMZDSQoeP0pDyEW92d+OKcdeFlwQzkN8pMvCjhTjQDD/wc0f6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXmSkNSNkeFa40Yu3SkLbLWaueXocXSemKDtJEELy5w=;
 b=JMg87je718zIodxKEiYlZ8SKUw7tiovoQcX7BlHzSMDzoqb9ANzrgbQeSf5hImiMZLrxxij7vX+pE+OFMhg3kPB+K/lUx06f8mqeXM1L6V3EfaiLKAGnknox03Qq3BAXWqvkn7T1d9hrGrGkxuQ4Jp6Lrg90q1vOegzAPWIW54Y=
Received: from DM6PR06CA0033.namprd06.prod.outlook.com (2603:10b6:5:120::46)
 by DM5PR12MB1324.namprd12.prod.outlook.com (2603:10b6:3:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 05:42:17 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::57) by DM6PR06CA0033.outlook.office365.com
 (2603:10b6:5:120::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend
 Transport; Fri, 27 Aug 2021 05:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 05:42:17 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 27 Aug
 2021 00:42:14 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <john.clements@amd.com>
CC: Huang Rui <ray.huang@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdgpu: show both cmd id and name when psp cmd failed
Date: Fri, 27 Aug 2021 13:41:28 +0800
Message-ID: <20210827054128.1136846-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c823dcd0-a1b6-4c8a-245e-08d9691d6e19
X-MS-TrafficTypeDiagnostic: DM5PR12MB1324:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1324CDAAF9A61720D0EFE7A3FBC89@DM5PR12MB1324.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:241;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kD8kWsPcWxXaFfbEk+2ocnbfkCov0hWSwpjXOevjiJ6w+Z4+CAbY7yW85pZEgqKSuSLNh3V4y3o3czhO3BRmr3JWIXta+bKo5Q9SBI+fjKGfmie1GllJrw01LuWokSK+5I/tF+xNWBL1MYi47METd50OxInTczNzbR2Mogei+n66KdtWznc7lmuzHCqSkYWkV0iAD1J58VqwKK8eVtm856Dj9+YGlHRf1tXfODNhe6wGFwKgS8M8qsJvGOHDJCs8YE8qvU5wSYPqSu3QnMUi6EHAlh4l6JA3yh+FmPWKAvxfYplVBGBRqRAigsy6X6PrT85kAYImxf4nNmcc++3DA4CAgvgJqFFpNOb5/jS4jE6Ev/3rf5kajtPXUH6jG2rCcOelKEah4OZF2/h7QuAwVgWfQMzjmC25jvvhC62/4+LPWvaCjtmo+TuWxYgHP7sKGTJdjbxkO8EbO5523S2ADkw42Mfvxah1amE+7LgoRVZR6gnrSpL1NR+ezRUa3+NhKn4iHcwHtPGRHCVexVHXkjbvUBE8V8F+XhQnR3gZ6Df6cuOkztmt3tYJWB66vCFvgha0OSxMf3mbeHmMMSY5nYFOClAKhyDzfT8dNkjQxPwMf4ZlktV9XPNkIWk6ZzJtac4Iop7axNS+9i9F/pAzrzu10FAz7Onvq/k681vX6ADBDzJ1sTY68FqKyhWSrRVnNbAy14KfnIbbjeCukxdVYNFLZpfIPgq7LMvrAlzE0iM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(36840700001)(46966006)(7696005)(6666004)(2906002)(2616005)(478600001)(70206006)(70586007)(6636002)(5660300002)(86362001)(82740400003)(36860700001)(44832011)(83380400001)(186003)(426003)(81166007)(356005)(8676002)(336012)(16526019)(47076005)(4326008)(26005)(8936002)(54906003)(316002)(1076003)(36756003)(110136005)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 05:42:17.0875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c823dcd0-a1b6-4c8a-245e-08d9691d6e19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1324
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

To cover the corner case that people want to know the ID
of an UNKNOWN CMD.

Suggested-by: John Clements <john.clements@amd.com>
Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 23efdc672502..9b41cb8c3de5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -469,10 +469,10 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	 */
 	if (!skip_unsupport && (psp->cmd_buf_mem->resp.status || !timeout) && !ras_intr) {
 		if (ucode)
-			DRM_WARN("failed to load ucode (%s) ",
-				  amdgpu_ucode_name(ucode->ucode_id));
-		DRM_WARN("psp gfx command (%s) failed and response status is (0x%X)\n",
-			 psp_gfx_cmd_name(psp->cmd_buf_mem->cmd_id),
+			DRM_WARN("failed to load ucode %s(0x%X) ",
+				  amdgpu_ucode_name(ucode->ucode_id), ucode->ucode_id);
+		DRM_WARN("psp gfx command %s(0x%X) failed and response status is (0x%X)\n",
+			 psp_gfx_cmd_name(psp->cmd_buf_mem->cmd_id), psp->cmd_buf_mem->cmd_id,
 			 psp->cmd_buf_mem->resp.status);
 		if (!timeout) {
 			ret = -EINVAL;
-- 
2.25.1

