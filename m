Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196A9C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 15:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B782010E34B;
	Fri, 28 Jan 2022 15:19:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3261310E34B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 15:19:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gzfh6CC8XL2Jd/SWsRBqNmD+e1MfIr4sca7jf0yZmSD4P98U/Ye79xXYwBWGSj15KtisrTlJFv57PCQQgwW0sOC2LzxKcPokMdNMmkGfoKC/3LsHc3CT07Vs/Hi+73iL/mfgncP2UlwnQFBlgo9t11T2c/vzM3+MiRoBjMzR5x6xF7ECHE6+KLcd5qnV3Cq7ZV30zr0HQ9Q1+PwY2emkvpBLcJ6BRfOCABBS4+XODbeae3RxqOAwQWHwyLNDMs2qHwNB9/qPCvFqXZ+xD7EBx0C16/RpaBMRYv8i3plf9ukY73Ul5i02e3G5b3Iew6/Km+T5iMSbJ0voIWec/E3ThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hsC9svUo4mqIlb4GI7WRHiysYz7/OoJPIS/+OaCOCA=;
 b=nw1U7QvnWSMUc+N8RguhzKmxT/UpVY/K+js+Jrdh2r0Hr8bcKA+3wdLWAuCNA7vRm+59KAiab+evnHWcshgNUgGA9EXOhCvi8GFldleqnGxEi9ZzDiiUP3Lo4te/eo6dKZTUXmt2Q1hqbDMtQUS9h6b2YfaGfvKKDIfCr6lkAgfZaliH0NniZH8pWXgBtP7zynrA9NnPWv6bYuytr6L2H9sCDIkzfYC2yiXimnU4xvn3xRko3KqGT2upn5bEeMW6S3dMO1dnPwRa8fMGipfiP6VJm+OcStjfY7BTUyRbQb3SQpFLSfAgMuXm4ReZ7VRekLVYpAsXr0m1nIuu1hSN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hsC9svUo4mqIlb4GI7WRHiysYz7/OoJPIS/+OaCOCA=;
 b=oVRGchnRdqzfFE/7rXoGO2vbfMO2ju6pt4hJnhD17s9hXEBZQyPGrC0/ZBJ3ytKdPT0MDc9Bwuaqp7IpeeqW/cy03xA0ZOSyZ+smNncz/JCSktXGftDp8YBEX9i7ciaLF7TYUw23tXGWRAoFKCU9K8NmBAvFk3GbjKpYdAVzaYw=
Received: from DM5PR10CA0007.namprd10.prod.outlook.com (2603:10b6:4:2::17) by
 DM6PR12MB2874.namprd12.prod.outlook.com (2603:10b6:5:15e::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.13; Fri, 28 Jan 2022 15:19:55 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::96) by DM5PR10CA0007.outlook.office365.com
 (2603:10b6:4:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 15:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 15:19:55 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 28 Jan 2022 09:19:52 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>, <hawking.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: drop flood print in rlcg reg access function
Date: Fri, 28 Jan 2022 23:19:37 +0800
Message-ID: <20220128151937.25577-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dd2f36f-71a5-4ea9-a2f9-08d9e271a391
X-MS-TrafficTypeDiagnostic: DM6PR12MB2874:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2874060549BFA6371A8FE9C9F1229@DM6PR12MB2874.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OiNMWljCrf6hnyZh8GURhsymr/L36bzBPncHUZdQPfZAqfW6pQwVQaWhKzoQn4CE8akM+/z4isWyXDGuV4Ntj6KxSSl2Pebvvhr6LFcD3gWMZObZYcSlc0FkFxrCIDOk4muDx+jzqemUB7XWTFJvsiCPe995YmDirYaXgpwrHZhEGGG0s9oHYm2cD6z3dJlHI5ko1aFKhQGowQmZI3OZLoC7cOPsHgA6D56GQmJEeDZIzUHRUxI3iGVbzly1zykojGMUxVT5/UFhnwq6o7xN7lu2cCv1czdHsmysjX90cGX1/S+hRXw4MiUEw/e0G9vktdju6tIVhglGqkTQTxFJHc/jPbLPwoUgBvZ9zNMzV4kBdKJELkQhyCofQLMuT/9vlDaDmMjH14A//15mJ79NzKT7uz3fM4w397jDxUxKcyz+kEJXNbV7u2W4kc/23QZZnYOGQaWUzj3HzK4+hLHgMnOBZt8yEqj/CgLae0OK9bbSKzEz9mvAQcDrn3IWfODW5/JymN6sAoWtKHQAOnV9a1nu+QAlGQNZb+9apIhJoEx8uwGcGtKBg8AQMzWwVZkayGBHGbvvkoHJ1PUcOmpdtts45wvDEyZ6W77PYHKqXv3WBfcPwZJDxiGrUHjkHRc4iFrUy3L6C+j277UwcCIrdUi+HTW9CplDhKpzevV3CqPktiiiymv7xEiTSEtD/2HYHrcpgwFAJb+319yOw39cSiq7JfFNnDCLGWOs0CFwP+8tfpPs+82vtrZM7lk0Y/wUmkm7wKT98obk60gUziZ6Wukm9l5O2HT+av+00OKtEgpohTK6lejvV3GUrrAPnpD+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700004)(36840700001)(8676002)(1076003)(508600001)(36756003)(36860700001)(7696005)(16526019)(426003)(40460700003)(86362001)(4744005)(186003)(70206006)(70586007)(2616005)(4326008)(6666004)(47076005)(5660300002)(356005)(2906002)(82310400004)(83380400001)(26005)(336012)(81166007)(44832011)(110136005)(8936002)(316002)(6636002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 15:19:55.1954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd2f36f-71a5-4ea9-a2f9-08d9e271a391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2874
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

A lot of below message are outputed in SRIOV case.
amdgpu: indirect registers access through rlcg is not supported

Also drop redundant ret set, as it's initialized to be false already.

Fixes: d4cd09ca9bce("drm/amdgpu: add helper to query rlcg reg access flag")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 80c25176c993..b56cafb26f4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -849,9 +849,6 @@ static bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
 		}
 		break;
 	default:
-		dev_err(adev->dev,
-			"indirect registers access through rlcg is not supported\n");
-		ret = false;
 		break;
 	}
 	return ret;
-- 
2.17.1

