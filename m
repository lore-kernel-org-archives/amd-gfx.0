Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C78C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 09:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6689710E66D;
	Tue, 25 Jan 2022 09:00:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80FBE10E66D
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 09:00:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWH5NS1WLA4FfpDwa40iBaBjwg7u1mq2aYE32CeGzCFa9qntGafRWtij49uCxWOTj9deNpqghu4vw76RoAond9dPt/JnTy7sXo5EUfXLNqulV5nWFAPe9GkYwhD7HoFrLOQ/HO2L/+88bGDe7l/1J7zBJJROqyj/3JmeOln7GkgUgbzBTjEoYdF9AW8xjZqlO8nbajVsBJVp5pVq7GV2HMHX529t1YKUS9W06sBfVZt5MPE0kBB0PY8RNmJDjvCTyBfKpqfHQCZu7oQwO7Ws6zIqdDEX/wIOGsH8b2UTA5A3GNtn0PaZ+LYXPJUSfjCw63znilSQTnCpbN3x9mZHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGVKwT9Nv6oWiVr0nPDkGF7ITttbVboGxuzH/cXMAiY=;
 b=Sd/Zm5ZNFbg4Fp94jHdlUKE4EtnOH0zyml1go51wvHqPLWj0DcMI9oO5BUDbajE+7ngH2d5CnjetG/aXGpusbSTdoGcIUfZdxsNXVnGwIy5Hg4YsIiTk0OdxYFv+VEvU5WsQebuV8w89IkYol07CXVlhkMlKa4VMuJ2XSiT1A/6W9LpypCDEKRWtf2r30AkXNvBFvDSmU0I84/RekgpTpcGlcT050HO2C0M0aqGCIT8cesgxe+hW9mntzHg8X+ygMki8zIw61Txwc0XcOXWznfqIRnZd+71lsT42rZTQJa0E39G9Wq8IJWS3SqTSuGbAHPQjqDk0owXZnJo5emJtAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGVKwT9Nv6oWiVr0nPDkGF7ITttbVboGxuzH/cXMAiY=;
 b=yluUlNjbxQ9NMxIaY0XWaNQYQUrGzfIXNxOv3JPYxTD1Zh7gRfp77yi1r2xQDORLiTqRWEa9DdIt9JZacI3vSHO0lcvG4+udF6WqJpmuqZM0LuUUyJACrNhvvHdXBqb1yzQu9yERqztkWrqTt+Re/hUlwSppjVB1XF+YiHqPRDw=
Received: from MW4PR03CA0297.namprd03.prod.outlook.com (2603:10b6:303:b5::32)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 25 Jan
 2022 09:00:33 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::57) by MW4PR03CA0297.outlook.office365.com
 (2603:10b6:303:b5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Tue, 25 Jan 2022 09:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 09:00:32 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 03:00:30 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/7] drm/amd/pm: correct the way for retrieving enabled
 ppfeatures on Renoir
Date: Tue, 25 Jan 2022 17:00:07 +0800
Message-ID: <20220125090013.102080-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55fea33f-4ecf-419b-6dca-08d9dfe124e4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4078:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB40789CAE3D2EE1A5AA8F82BAE45F9@MN2PR12MB4078.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hI5npJbkqku17bkPVCMabgnOlh1HUEY5jf0S1RtJBoCuHd98AtbJ85XMFEddO7M5vuJuKlZzcfToGwnBPDh3LIq63iFILVSNHPKrJfHZi9kzSgW3gTBAfsCOoaPdNXBXIq/MEVDzEAhbDiqPjoSeVfLuL3mTGYfcaDcGiM5ij5tGQUg4628AqJ7SsilxgcZ3H/ir17xCvUYaPW+3zmfi9LTiiTpG3s1kxu4A3zy4nKX51BCOn35T/GtG76ywfbDT6k8mkclHofXOQaLl7nnZz410lzMd8gcJCjHLoL9TDBN72rD3/F6o0gL4NPa7R7+2japjGF1ky7hCPpKheea3brTMW+bvbAFrZfZ0pWjBtK+yQ99Y9fz61tyNqc2e23DDn5OqeyRrUNQrLJHNoxmp8AaGc0Q8G8GVTB0SfxzcdgbR2Z5kgCPjaQ6nDI0Try3FoA6IhW46ipJYQl75vqjAumdbMDTzT6rjF2yOlfqsct4rH7t0pr25xCgPderFVLDbDb1t/TKDfKqEcYrJduxv1CVknifcI1TnOGOwijgz6ALlu89I33N0b6XXIDO28djTkFRUDuy85HbsmLW32f+YP5jRRezS4wJI/CMR8bmuyyN3L7EgWr/BTRFP66T2dptxfWlhT3ux9aFThGxdVBQSgnuDC7O7U0I6zARBIbzlFLe+3zVlmY3HvC2BdCJD25548e22UjkOTwpq3aCfrQxjQbwU4dVKqVvZD4Ze+MB6oj5DunbmWlOBa5iZl/OuuqienIAi4VlR9nSlUThRpfgLlcTxskwYB5X12sWBsQlP9qk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700004)(46966006)(70206006)(70586007)(86362001)(316002)(54906003)(186003)(16526019)(2616005)(336012)(6666004)(8676002)(2906002)(6916009)(7696005)(8936002)(26005)(5660300002)(426003)(4744005)(44832011)(508600001)(4326008)(356005)(81166007)(47076005)(82310400004)(1076003)(36756003)(83380400001)(36860700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 09:00:32.7659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fea33f-4ecf-419b-6dca-08d9dfe124e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As other dGPU asics, Renoir should use smu_cmn_get_enabled_mask() for
that job.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I9e845ba84dd45d0826506de44ef4760fa851a516
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index fcead7c6ca7e..c3c679bf9d9f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -710,7 +710,8 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 	size_t size = 0;
 	int ret = 0, i;
 
-	if (!smu->is_apu) {
+	if (!smu->is_apu ||
+	    (smu->adev->asic_type == CHIP_RENOIR)) {
 		ret = smu_cmn_get_enabled_mask(smu,
 						feature_mask,
 						2);
-- 
2.29.0

