Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE637C77B60
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B0D810EFF5;
	Thu, 30 Mar 2023 19:43:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A31C510EFF0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwmQrz4Mb5zoplYzIhRuXVeup7WFtwi6KLqr5MnfiM6THNRwle6C67X2z/TW1trQZAnbf8fIh5mI/psBW+4VfYJvfAzFBldOrQA0+vbJJYnf8qYCmMRaIrTsDWQ4rbTJ/fYIbfhsy4HIO6BGkGOtDjEb8N19lDf6MEwd4qcAlQk3JVlS+3N3EHJjfcqJwE17HYfGNgq8iwrvdZgY0oMUq6fu0y+YiiUBgUA1PyWFXqOKkCMratxiNmwy5QO8Fah1Fw++bY0v9SDo1nlXA+9VzJoHhs2tvpJQczkelURsrL7buLVDBSYhSvruGlIs1mXzHoRoTx4uEj2Qoi2caucv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENrIlScf+GFLt4MndbtVy1uQBbd/kcIAKpKJnZrUvow=;
 b=AI4hWXwb+DuHhYyC2O4qUs6+h6tH0ztYGnGClpn7hNzcnPomKrjUDIQjs95IhNUcjwisxn9jMt8bSPVWUm1m5Qdizk4B6EofP9gsPJeyCZrgb5zTEzpnl2Ho4mjJ8ca3jxkRxMTZgs6VFTwyy6p2YRJC23RG/1rng/oOCPB4bETKuIFPCMdJcGMT7JpeBtehVg51V08NLyxa3zMRH+IGZXfqAsRhpjlTmtUw26qbxUS1cmkGtp/Xw5LdpoCD/YmiBanNoyVUwS4JeMerzg/gOnBWlYiG4dvHkr06Sk/fzc+MgqVaKaTEDpD1ihFkiLezPS3QXirU8jtLsZs7i+yfAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENrIlScf+GFLt4MndbtVy1uQBbd/kcIAKpKJnZrUvow=;
 b=qT1tltK+9ZiB9n+ivz0gif1MR0kRI8JgdMtEDvW9Y1BZaw974s7P6JGSi+5KG6/c23WhyGpqIwAv+HrqtWwxXGJ70E7tFuNScMCC51/RtkptzPWmcZFp4UkOBtHzIgbdrzo9Eo3kmRVkCHtthrAzctuovaaLCZBJ+QPoF9i3qPo=
Received: from DM6PR03CA0084.namprd03.prod.outlook.com (2603:10b6:5:333::17)
 by SA3PR12MB8046.namprd12.prod.outlook.com (2603:10b6:806:304::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 19:42:59 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::89) by DM6PR03CA0084.outlook.office365.com
 (2603:10b6:5:333::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/23] drm/amdgpu: Make VRAM discovery read optional
Date: Thu, 30 Mar 2023 15:42:32 -0400
Message-ID: <20230330194234.1135527-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|SA3PR12MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad9d454-e9f4-40c1-b423-08db3156f759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDZV4nh1i4dHn0GaQuaUIERjGtmhHGDirG4urki00bju6FVSeqa2HPh/uKbTqlQEFLDXQ8U/GqmkNPrCgoDcq9PNlWEzvvtYQEC2Fa37Cekbga+rsNicQOB6KClUU6C84Dl3Rf1fCxmHXzqNIJuAENU/w3aMxBdhuf6d6uFyUlmcLCmMV+RcROZmbfWPCG2dhM87FcTrOxZhdLqHKNT+rzvpJZX6FjHkiauIkn6a0kk7fqp5aALLfHAmEE6755joeCHuZH8w11OfyiX6bVv6pzbgikrtWlvK/YVqK1ueRdjfaD4GWn496GrPa8/VOcuJBtPhiq6DI7wKo+rNQ3NwzK3RQh4nD0IYgoGv9sUg4IiRqMLWSvIxpx/Xy5CPJtpzKw9poOSkTS6HayD6G+aJZTn1I8jwm5mmlB46tkVOHiHzWZfpAM7G1Y3H26FQ2TjnjbeFrzMDqKrapWDIwsVNlRWGrop0o+orv141rRVYcc0r/g1LCj4A/9C2F2DYM8UD0KDbhT3lR6TbQvmHXj9zo/Bm+98KMvVWnIauDrzoYw6pccjiAw3pWdFk49Tqxw8xP+4EXQ/6vb4jAFzfnKfESA+q9/wL1FbLSZVyzoB+g5j+lBgrx2psC0VAb3tKd8ZRq59jlQHXTtJ/10+Q8sw/nNgkp9NJq/QF4LGnY5HZR4yJmSY9saU7NRQLZM5LLtXhoEC1mDzadkb9Tw0tOkQWag6nPRehQU/GC/3Eaz0vCiU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(86362001)(186003)(16526019)(336012)(426003)(8936002)(2616005)(5660300002)(26005)(6666004)(1076003)(7696005)(83380400001)(47076005)(478600001)(36860700001)(54906003)(316002)(36756003)(40460700003)(41300700001)(81166007)(356005)(82740400003)(2906002)(40480700001)(6916009)(70586007)(8676002)(4326008)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:58.9075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad9d454-e9f4-40c1-b423-08db3156f759
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8046
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

When overridden with module param, directly read discovery info
from discovery binary instead of reading from VRAM.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 31 +++++++++----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 7b176b178b06..cbdea32e40e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -301,28 +301,27 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	if (!adev->mman.discovery_bin)
 		return -ENOMEM;
 
-	amdgpu_discovery_read_binary_from_vram(adev, adev->mman.discovery_bin);
-
-	if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin) || amdgpu_discovery == 2) {
-		/* ignore the discovery binary from vram if discovery=2 in kernel module parameter */
-		if (amdgpu_discovery == 2)
-			dev_info(adev->dev,"force read ip discovery binary from file");
-		else
-			dev_warn(adev->dev, "get invalid ip discovery binary signature from vram\n");
-
-		/* retry read ip discovery binary from file */
+	/* Read from file if it is the preferred option */
+	if (amdgpu_discovery == 2) {
+		dev_info(adev->dev, "use ip discovery information from file");
 		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin);
+
 		if (r) {
 			dev_err(adev->dev, "failed to read ip discovery binary from file\n");
 			r = -EINVAL;
 			goto out;
 		}
-		/* check the ip discovery binary signature */
-		if(!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
-			dev_warn(adev->dev, "get invalid ip discovery binary signature from file\n");
-			r = -EINVAL;
-			goto out;
-		}
+
+	} else {
+		amdgpu_discovery_read_binary_from_vram(adev, adev->mman.discovery_bin);
+	}
+
+	/* check the ip discovery binary signature */
+	if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
+		dev_err(adev->dev,
+			"get invalid ip discovery binary signature\n");
+		r = -EINVAL;
+		goto out;
 	}
 
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
-- 
2.39.2

