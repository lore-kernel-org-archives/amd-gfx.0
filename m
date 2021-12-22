Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A1FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 14:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE2410E251;
	Wed, 22 Dec 2021 14:20:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A980E10E251
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 14:20:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emMApQ1aiiCnJSfu1/8CcoCRhi4NijxQpMUwiaIktogwqa+e+dKfW5cgwcFn0T5cWiDpsSLj2x1bgUbPPjvl7Ai5/s3v2fadXrVyuaI4rUbXRqZ+oHAVehvNlJmlgoCN3jfimYgfv8Fo04h6SZCg7H6xwoG7dHF1a0GUqdHOyWcSadroRyJxx6JIniXPamPsnukXmbxL8g99tF1Z/G0/EpLWiuYvQ7qRXExRz/EcCA9aRiKNw4eIJAoKtnNlYefToL5rNuLwAlt3wEa2bFumaZNEiSpYctL0x8vf4nklLbSaklKwAxSedmRE9cLL+zKzLk8/ptpIPM1MkDJ43WFTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wLkKNuWknUapsQ3SbqR2iHTQb12ZkRNsb5LJLCh3/Y=;
 b=eqzDQ1cVNN6K4xXPdHIVMEcyPo0heS5Q6F4mdJ8w9P4YeQfRG7FFr05lbkVroUQuIv9perlRZYWcJKsiqt9n4WcKpuve4RVslHMbLwHaV91kZZ2AjFKBiyiDl6E5zvx7J+S7UdGPnzrmOe4KmV3ihMc57fZ75OcqSifIwV6xvfK/xYChCgU2YFSUK9ZFxmpj54imAwrGfHxiqcBU0iwiECkhaBQKsudOKWp6N48M+pIx2PsNWQegBw9IxWItw12R1cATomUqOzVQHQ13a9ZEf4iPgug9CoR/U720Gwm4e2x0nEIFffLLnJjY8v4GFXJ/Jmhz/mgZ5Igg5hXhY2QTkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wLkKNuWknUapsQ3SbqR2iHTQb12ZkRNsb5LJLCh3/Y=;
 b=QgrnK29Ze2p4aQ4SbXQlNHe6eone9JXcvYE8Mm+GPdf9hClJ5TrBP0qrv8X8SZ4gmblfpNPX+8MwBfwysqLVhnRL9leOT9h2fC4AJTuQVoZakMw6JLf+JyP45majC2UZES8oETNt1adlBy4DgG4H9628GXzsAFSaZsWwuIKm9Hk=
Received: from DM5PR06CA0076.namprd06.prod.outlook.com (2603:10b6:3:4::14) by
 CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.18; Wed, 22 Dec 2021 14:20:13 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::1d) by DM5PR06CA0076.outlook.office365.com
 (2603:10b6:3:4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15 via Frontend
 Transport; Wed, 22 Dec 2021 14:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Wed, 22 Dec 2021 14:20:13 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 22 Dec 2021 08:20:11 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <John.Clements@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: avoid NULL pointer dereference
Date: Wed, 22 Dec 2021 22:19:56 +0800
Message-ID: <20211222141956.13239-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0f5a838-b867-489f-7ec8-08d9c5562b46
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5427E8F56B5F6D566250EB36F17D9@CO6PR12MB5427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJti8IhWPTiVda+Xwmqg/2dgeQuN1tDjT5COSYCyt+qTvni1Eo7HL1ADL8eXqQz2uEJPO3zZoXywIiUQYDkTHmBDPBFFykaoKRot4A7wHQL31FsRR0hOMjFcawNAGt45g1HNXkFKeN2bXK0HOWwenVIujWD1rpw4UxY/j6u4eM5YnH1vVF/RimvyKaKckPXuASFhVm2KZuJK7HXCxxaOFmrufQms7txMLIMw9mk59kZqwvoGRdVjJLSok2oN1EeIhchym8eC1uxTnETUHpl1HneuGexL8/99xBzR/mKzWblJRG68dI4NgIj6JzMETmwNSHigBArdBgG0th1TsJ510FOHdqCnFlIrTPYSsjQOpAgkpsvsMLWeeofHk7rwFWv3OQ5YCWFVDwX4BLu3F6inQcouvxK+WfcEL9aX0I25BykRUB1jwc+HOU/iIuPccWksgjwTuTt7bBbcJBQmoZ9rq0x5WN/O1ozldjWtZDxuqjlsEHC3bpP4uEsvS2vWxr1SlrCeSLSavGQibUrL4vQg7SvzTpdEYwLoVxv40yKXrHhlWC0Ww50s1Y3K/YGdwH/TEOjlKKDMnJzA3ylEZeW74l6xNPn6KKvjD2koiCT08lLH9kc6G+31LatfnDppl3Jc66SwHYvgAVKtDI/FyWugjuA8gQ/hj0mvR8rQz9+Lulwn2fiBADARqfO0L8feDrnzbmJzBd+YG61mjvlrFvjemjiRN0osjv2TUpj+hEYVUJep8WzGaT5gAHwxnT4uB95gGTa7jgHmMCk6D1G4KJ3mfY6310D6VtiWa4eLKrz8YgE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(70206006)(2906002)(186003)(36860700001)(16526019)(1076003)(36756003)(6666004)(7696005)(81166007)(8676002)(110136005)(86362001)(336012)(508600001)(83380400001)(356005)(8936002)(426003)(44832011)(2616005)(316002)(4326008)(70586007)(82310400004)(26005)(47076005)(40460700001)(5660300002)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 14:20:13.2754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f5a838-b867-489f-7ec8-08d9c5562b46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_umc_poison_handler for UMC RAS consumption gets
called in KFD queue reset, but it needs to return early when
RAS context is NULL. This can guarantee lower access to
RAS context like in amdgpu_umc_do_page_retirement. Also
improve coding style in amdgpu_umc_poison_handler.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 46264a4002f7..b455fc7d1546 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -112,16 +112,20 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
 		void *ras_error_status,
 		bool reset)
 {
-	int ret;
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	struct ras_common_if head = {
 		.block = AMDGPU_RAS_BLOCK__UMC,
 	};
-	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_manager *obj;
+	int ret;
+
+	if (!con)
+		return 0;
 
-	ret =
-		amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL, reset);
+	ret = amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL, reset);
 
+	obj = amdgpu_ras_find_obj(adev, &head);
 	if (ret == AMDGPU_RAS_SUCCESS && obj) {
 		obj->err_data.ue_count += err_data->ue_count;
 		obj->err_data.ce_count += err_data->ce_count;
-- 
2.17.1

