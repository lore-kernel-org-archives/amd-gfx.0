Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CECC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50F8310E2A8;
	Fri, 17 Jun 2022 19:27:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF6C10E2A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:27:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkSrh+pzBgcVmAVqDTmSM0qC+xbJFaEwIZwHqunSoF2sHNi+PkTjdK2qhclHxJnsHPG6IBHVCpBsTgdCUUitJFv8AF/kh6IwOHsh9TmdgUFk/DHNaHWG7Mq6DYAxi07V5DZSFi+xQYyDuF0pmri9x1ghd27E1q8s/fF3KwnxwZk0fjq6Q0IWesGUFAVdKKyoDiwrEifIiPuEHfx0I7wtv0YowX9aLhAW3lRwszmpaA1ch92jq9FKGvtvBDXqoC8KNjvjmRyradB4/8fZK79l8NG6RqIuAgWUaKTDsQJWOAhG4hvozdGbP+GwshQlfOE0eRJfebq5XBpIH6Uu05Oojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Usr/r8mjeDmC6W1MhheLkhwVKnM917tqKw472Q7VX6M=;
 b=NmsPohLYlAz0p7tXEMaWJQPJ495AmrVzaqJys1Utz0iYzal9RbvpqyR8iG53d+irKMQYZg+pNqM58qYVvdafdUUdjObJbzMLzMZOtiD/X62+5o9YQlX7Il7yXbWjuGNmf2B6v8VlQkDxVFio18ze43GUKohdY1i8EQyYJ6UMD2/vlfnLP0jOIFhpZ1UNHgrb2vJRsLZAKkRM5dCIydd+aQrR0XTzcVldtPqMdJbkJQ36lLB3UyJSCZAbPJ0Kk9lGJuCoI8i0FpH4sgDorrCC246sJ90ZC24mVRwlIuy2lmxi1lzJYrvVthZ06DKLhUNZfQEOXqKXLXCRUG/13T84lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Usr/r8mjeDmC6W1MhheLkhwVKnM917tqKw472Q7VX6M=;
 b=oa3b49zUSlDvALW8IiEuwlxVc+Gl/LIsv5ixtlVrnw6+XH7dKm0yzC43e+OSPcvO3hsORqcMo8upPD8b5LdFx1icY8JFTlG0073QEKlcSXHI2UasuCutP5Mtf3+fdFXwaKGGwqwqauoaBVVLITuNxvlA+32EEAMmNPwIjOEQO70=
Received: from DS7PR03CA0278.namprd03.prod.outlook.com (2603:10b6:5:3ad::13)
 by CY4PR12MB1832.namprd12.prod.outlook.com (2603:10b6:903:11f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 19:27:19 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::cb) by DS7PR03CA0278.outlook.office365.com
 (2603:10b6:5:3ad::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Fri, 17 Jun 2022 19:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:27:18 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:27:17 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] Revert "drm/amdkfd: Add queue to MES if it becomes active"
Date: Fri, 17 Jun 2022 15:26:14 -0400
Message-ID: <20220617192614.6868-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81a493af-e23a-46ef-662f-08da509764d3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1832:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB18328C784C4C2DD3B380E6FEE6AF9@CY4PR12MB1832.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQiJgTayguSRrbHwr8cYa6+0Jtn+66X5vPdNtcXxrSzOLBe0foT5xJMCpuv9rNO6DA61bLQMwCrjKMpVDRTdNUcCNN5I3wx6Eyk8wcfPNWjck4Ylsiz9Ym2xf8A+bWMJNbeRI+iHNE7euL+W5ydkJVg2b1CS5j2iIUhb/0ZIMxRwlbfCGMxjdIB6Y1CuDj+4c0NoM8oyiy67sNJLBJNWg377W+ZzSK1ImLnIkQhNfuiiF9Cy6lDvgbe+OY+PZF7gppqoTtawDFtNX5mhxhszU165vat3BbRZ2rZ+7by7Tt8ZI+pFycpweqW6rIbg4aNLbpgzASF1QwuQ3yWPCdavrXJf4ojhLF2dFhRBVca7de4Z0tcC5d7UGBnO+pYeCf+yhDfr7gE4M9VaB/AS/GpIK8OzGGeKfuttukN9C1mixu5/3gxTVENBwSHsxy1nsHTm4X1Avi+RKDUCzOJscbYU0OyS5s7ljVEC1hGPhqSTtnwwb8uVVfgWzTBydeeojPEpeLqcDq/1tmWAuN0/k7jS92ykzYjOXWv3S+arBDZrVZf2AhOO/1r07ntCmU/psiNZIfAwo/vwpyj3F4MCiV8bdCFQkI1zY3NyUIesFiEPh2Xc+RQ1Ytg1iKThsb1YVMrEOvGEXai6i+bhygKrvPXk3Y8RmTE+NSMpwhDULTnOt6+AhlQUylOMJhwA0bGUv8TV2R6lDOpVUN+yS7e0YWKpEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(426003)(336012)(26005)(1076003)(2616005)(86362001)(186003)(16526019)(36860700001)(83380400001)(36756003)(82310400005)(2906002)(7696005)(6666004)(47076005)(5660300002)(498600001)(6916009)(70586007)(356005)(8936002)(81166007)(70206006)(8676002)(4326008)(40460700003)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:27:18.7268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a493af-e23a-46ef-662f-08da509764d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1832
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
Cc: Philip Yang <Philip.Yang@amd.com>, Graham.Sider@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 8b9aa1fa82baf4e8b6a2daa3aa4d69b728df727e.
As it breaks pqm_set_gws.
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 67ae5b6385a2..e1797657b04c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -866,10 +866,8 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 	 * dqm->active_queue_count to determine whether a new runlist must be
 	 * uploaded.
 	 */
-	if (q->properties.is_active) {
-		add_queue = true;
-		if (!prev_active)
-			increment_queue_count(dqm, &pdd->qpd, q);
+	if (q->properties.is_active && !prev_active) {
+		increment_queue_count(dqm, &pdd->qpd, q);
 	} else if (!q->properties.is_active && prev_active) {
 		decrement_queue_count(dqm, &pdd->qpd, q);
 	} else if (q->gws && !q->properties.is_gws) {
-- 
2.35.1

