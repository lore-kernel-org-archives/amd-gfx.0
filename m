Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7F6C47073
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 03:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A89D10E37A;
	Thu,  4 Jan 2024 03:24:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E5C10E37A
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 03:24:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1rPbsbotH05DJvipFEjTNz7YbINqJ9h+RJjBkOi7Xk/rtQBsWiwnBoOiU8SB4gW+ycAgLnvpirxT43FCYFgCBHNM0qU5KVSVTuVtESjZY/Hlcn7hIClR2Ah20SIEhmdTA5N9MO6guVdLqIO/IVuyv3PNCe3j/spWyAvCrKx5AaRD2FfHsuKkBc4PDGNXLsXNdSZgaUyU4Pwyt2Z0iJm5B6AI5ggm3FcXxUkJK3h/S6QNpZEN9zo8rI/2y5BmrdrU/EotzI3vLuY67OztQzTR4FQeOIWVByx7CAkHBo92kHn6QHEmi1h9o8bSyCz2nsDiRBUkk/C4GkESD0i5vHa/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFlAeTuY8pX22bqBVUynXHtLsWx04DXeSTNkkLLooZU=;
 b=OvdO8m/S5GrTYbuqOuDYgTG/T802qfm+1se5FaPXqun4ZxyEUUIZwRdNOsj5HYnwW97IsUBB9QN04ifhAYztziyhhtz50RIHloXLf5JK8NMPL/9vmlK74pkyfs3NSw4fE06voIZ6X6RZ91uqTyJMnDYvNxEfETPL4RUtDYhlGWjVJWzFieVJfP8Bc4a9KBolyBMznhWuWuug6FY6YhzTpZfSJfv+GQf9WMSCUUMJJWz/i/Uk7ZpaGU/V4bOVtMMuv5X040ejHh+lXmnoo8VAAEWsXAEh4hfAjF9Iafub5D/oKJCNRbyLbsuD/NcUihXI1/Mqyv2unkw2uYyl28zZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFlAeTuY8pX22bqBVUynXHtLsWx04DXeSTNkkLLooZU=;
 b=5ndgaRw88cC/gR0tkGxBr8ViM53dro5rSbOEkBqznoxhZKUo6LPyKWoMJvQa8/HL5PoPoJDmmcdcxtGtT34nTmzxkvrjW7QIocGv/hHYoRzs9xcnlDwTEAmRd6Bfr3Dz8mtzelpv7StMTKJx8TQdIlcUek0/alO30iJunuz9LdY=
Received: from DM6PR14CA0050.namprd14.prod.outlook.com (2603:10b6:5:18f::27)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.25; Thu, 4 Jan 2024 03:24:17 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::dd) by DM6PR14CA0050.outlook.office365.com
 (2603:10b6:5:18f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Thu, 4 Jan 2024 03:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 03:24:16 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 21:24:14 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Fix '*fw' from request_firmware() not released in
 'amdgpu_ucode_request()'
Date: Thu, 4 Jan 2024 08:53:58 +0530
Message-ID: <20240104032358.2240226-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4a3def-c33c-4f03-f9b6-08dc0cd4a1d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFxfzIHyYdS9tPSPFOBCms3qoLAdGWczhSKbwDHjshuRRMunuKWewK461B8csl8pB0s0sYwzNUolGRBASC65AHl4rwqfDha/k/zKPe+fxfEjSsBHE+QKEwshYPZltOAtAYW/zmYpy0GHeCiIaOW0BnAYy3Qn0ss5tIzvDViJmB+K0PIwyuRdQZ2QpwC1PfVvPOK03PZfWKX9+unJ1Dko+yAypJ2JLk7OyKKqKv4qDJWPdiiYdkdrqVxyF5OVU3XAilCeL63Zjho4Ts3o/+qxULHmHRf4laMNgnWb8KY/i1umLso/vkUPfIkZJRapXjl1oHBrkyz08A+mFH6UbGiq55jLtRRuudTr5UeD00LjSnHfaIfmRpXAw6osDQu3cEWZQGEY1Q/g0lifY441ccPb6+JG5TXmWjBR9Yxzm5Ic6xb/BXq++rzyz4yKrrph0h1PhK01IflhiCvWcQZ5n9hVvnOy7kg4PER5KuzuEqc7b2nOzfFZc0+A3Yh8kCVdTt1S6m/e6Lf7fH9xHCufOtYrT8/SE6PLRI5xxtCxHlks25kPPHm5kGZzOPrVi+zSF3/aF8bX5hvMXi157pXKVDnCHfp1iIec3xDHP+4H1ZMm1vi/0k1cyQoqKDGSyydN0BgT+pER689yqEcleZ0F1gcqnglU/Mp7LjtogpqwvzZiKQOvEcun/d/vMSy7zTphp3JghrQydT/NxTec/PnB9adBnx6eMCDn/7aWTZrwLLuk01vkhOuIN/UukB5q3JuMnHpuhoIlU45TPxgTOnS+d8vSBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(2906002)(4744005)(8676002)(8936002)(44832011)(54906003)(478600001)(6636002)(36756003)(316002)(5660300002)(86362001)(4326008)(40480700001)(40460700003)(41300700001)(7696005)(6666004)(81166007)(16526019)(66574015)(26005)(1076003)(426003)(336012)(2616005)(356005)(83380400001)(82740400003)(110136005)(70206006)(70586007)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 03:24:16.6182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4a3def-c33c-4f03-f9b6-08dc0cd4a1d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344
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
Cc: Lijo Lazar <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:1404 amdgpu_ucode_request() warn: '*fw' from request_firmware() not released on lines: 1404.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index b14127429f30..b8d000105816 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1401,6 +1401,9 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
 	if (err)
 		dev_dbg(adev->dev, "\"%s\" failed to validate\n", fw_name);
 
+	release_firmware(*fw);
+	*fw = NULL;
+
 	return err;
 }
 
-- 
2.34.1

