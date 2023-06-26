Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED89EB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 12:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2EC510E0D3;
	Mon, 26 Jun 2023 12:35:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 279A010E0D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 12:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXFMoWycwMoTKuqxnIAtCJyUUhtch+JWd6AcKgOnmk2UJMNiqaZ+eR5yBgGITgvNmrKOBt9zHYoD2piXoVHxczBJ0vE85RilEt9vwSZsXZ+NcERceley7iumwH3+reeEEfNkWT/wJTMVOImiDtCKHPS8+3k0fNa5LKq44OHm5JXUD1QxHAgr2WGazIgjlzbNKHjXzT7sowqdH0JAYN2sBOCVvUCbEf+2F9fabuiVlDalbFEaEId2Orem2ifnKn702kwgso9gth039POwm+Skml6oonvjZhuhJSVNkh2sI7OE0GRAg9GFSCoxn0TguAFkTsZNvQRKlJNm5JcZmuG6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXr5M0eVQe29wfF1TIsuzOhNYCOInt56PGgddc2YW9M=;
 b=O9SEvG8BtzQCo4vlmRqvrQ3yUNPyraAYJlwH3QdOkT/8r9VZB6Nlwu71mo6LNPe8eHSCi4SS9HTzDXqVunQSqUpJ0DOmlXOGlL47wnpAuSh8dszgIiy+0do65g5SYucK8ZeaN4VExv+vwFbLX3at8yu7G0aF0QmsPtuNF4PY0+OP2ZWEtk/lkahxS6yVK+Y1VaVCaDNLHDaM4D5MpSARvKFsACeapCEZVcahomYXlX9pEfeInrGg+XpYYePe5CwBy8fxxqa7AdsSYwP3ulwfGIB9cuXJbUaXUrzMJb9h7uDuKLo5v60mwmwXvvjVZScIzAvv4aqCtw3xi7EHyZwaEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXr5M0eVQe29wfF1TIsuzOhNYCOInt56PGgddc2YW9M=;
 b=vRNnsqhPsITYWs6W8QQPuLg+k09kE4VR28vgfCotyFg4nZu9bQdRTmVce2ORit3UlJvsXIjfm8XPJDtfD9smyhDl7Lhxr+vjKs1KHWkMv+I9faHAULQ42t25ItbVJDxmBcEyEPlRpG+q32lqCGe+5xlPjdm2kwyowosziXM64P4=
Received: from MW4PR04CA0313.namprd04.prod.outlook.com (2603:10b6:303:82::18)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 12:35:22 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::58) by MW4PR04CA0313.outlook.office365.com
 (2603:10b6:303:82::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Mon, 26 Jun 2023 12:35:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 12:35:22 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 07:35:19 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Enable pp_feature attribute
Date: Mon, 26 Jun 2023 18:05:00 +0530
Message-ID: <20230626123500.2641677-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc4273e-7b6c-4fbb-24c3-08db7641cf3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3KprLcTonBV4kEiLd8OamZNOD4YyHqnjmNMFqH8RyE65SFdNv4OMDrNQuvnzpRXlnscF+lSTJWYJHXSwIUT9XfwIo/EwsIAPZuYtKqTLgpIu8WVzYE7jCuF1Qtjyz6p+dVrtkv9YIrkoS2CIEJocJYfpDt31acQAp1bNtQ2XcUnjNDuXVPogWsM/4OZh4PWFMnORZ4iwfSw0ezzYZtrsh7vwn/43AuFaINlF8zd+ox5KaDcIwWE91WTJEugiMxiuCbXG5A3QWU2sBZklkKqhENuDiyk2dhaXccAGjWTpCifHVO50Z0HjiLwxa+FHyhXcnw+FqCeKQzPdQzPzre6CGEEUxL8wr1gx/pU+8sbtmRiqIpbhmPKEYq107ZwE7fueTKe7wYS02/K6efaotPKLDmkmn3oyW34wALsmyj3PahD1BhQToUmV3iiMGlTESE0ZiUUBVlWKrt15I06gVuZYyvvE12BVu2M7xc/3pmwetrqiIgQ3E5FfZLXlZqmIr/Q5lEv+wIdXAz4NkgJ8lMIB3RmPO/aAC2dPBRIsR8O1bDPOF5faoCDnZqRpyANUM+qxJehx/0hvZjTRigIpoTTtf0FiSLdoBobsUPicwLS4KWV48xaH+mdjhAcBFDJKHpV3SSV6Ag3r1ricS7UcJxJ7xmcqyRfOTgDkbnfjY7ccWfRj3ts8PCt9e+qveO7GpUUVsde0NS13WB5ENG792SK2Ak/Y7t6BpP9Kch4N1Zi0liNLW4TYoybZQ9tX6aOqMT+eBqxI9TP8vjPI7CXhlqdpqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(82310400005)(47076005)(478600001)(6666004)(7696005)(426003)(336012)(54906003)(83380400001)(2616005)(26005)(1076003)(186003)(16526019)(2906002)(4744005)(5660300002)(70206006)(44832011)(40460700003)(36756003)(356005)(4326008)(40480700001)(82740400003)(70586007)(81166007)(316002)(86362001)(8936002)(8676002)(41300700001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:35:22.3181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc4273e-7b6c-4fbb-24c3-08db7641cf3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

on APUs with GFX v9.4.3

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 9ec51f50fc52..9ef88a0b1b57 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2083,7 +2083,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			*states = ATTR_STATE_UNSUPPORTED;
 		}
 	} else if (DEVICE_ATTR_IS(pp_features)) {
-		if (adev->flags & AMD_IS_APU || gc_ver < IP_VERSION(9, 0, 0))
+		if ((adev->flags & AMD_IS_APU &&
+		     gc_ver != IP_VERSION(9, 4, 3)) ||
+		    gc_ver < IP_VERSION(9, 0, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(gpu_metrics)) {
 		if (gc_ver < IP_VERSION(9, 1, 0))
-- 
2.25.1

