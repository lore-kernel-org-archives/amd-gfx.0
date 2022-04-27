Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17378C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 15:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6E7910F5E2;
	Wed, 27 Apr 2022 15:28:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E150010F5E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 15:28:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbXaxmpoCynBlCaPuuoaYeCDsEff3vS73mfqrPsMw3+1m87/S62+3yU2Wg1JPbCjQZCaMxly69vhu1v2JdXjxe2i/dt2e3VCahPOLuukmoJ+WIid/lT5rRIE1mkMHa5hufp+RHjWl23R/Rjmc7dt5A7vgU22hRfvoc2AsW5Jb44dUwLEv1ZBH0kmE5VUG+6g0eufDF14chH8AQjwAD0JI8wBd5tncVjB2KOKD2mCZz3tJskf0VFih//47ON7I5HlA5wyobGBhDFS+GMRXeJ+BMyuAvVuAJaDMfUErd0A6V2uqrZX7zXdI7GfW08H1GoB+FR+HqP6dthCJf8SFTtu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGkBYkMzUOLckBOLLAAxvo9pMbATSfMJC6VS0Z1UGVg=;
 b=c77C+pU1O/9ktAvcPiiyJaHH1X17IAQfpifxaVvrDt5ldDGx3ATeDTx/7NVQnaA57fOetevHDdX1st7VIdEHReMECprOEwBcHK9EjHj2RBBu7ZQeQkPewnOqBobgy4VbQ705TRmCNMQ+2XUVjoEtJibSnuK4mY7U31G6vzpurvwZrTEltszyRcl9gSZi86WNDomrOO42S64Hn50exy7YVSVpQZoaMwx3kn9xtlhva2LhnTMnMXbPyrcrU7lXt6CPc/5hTcSooYDp+QHqsAjoy/SZ8Z88jqFVroorx6LHxBvI/tUNrxvbQH0Bd+j8G5xD+AkhYqUpjb3yGa/A6TvU+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGkBYkMzUOLckBOLLAAxvo9pMbATSfMJC6VS0Z1UGVg=;
 b=jrwBjIZ7cunCOYMrvOiwdoTIoXirTOuIFXkeiwYL4gFLQHQL8XTZyCh7U5F/2h8KF29UlSuN/nICM7CP30ZgGbpYSYQT6yNM0Db7ot47t53WrlqBzB9oF+KMs6HtcQ4W3OOCnVFr7hyn4HONHQ17KyvM82ERecpl3i+ZdEqCOjM=
Received: from MW4PR04CA0215.namprd04.prod.outlook.com (2603:10b6:303:87::10)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 15:28:08 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::f3) by MW4PR04CA0215.outlook.office365.com
 (2603:10b6:303:87::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 27 Apr 2022 15:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 15:28:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 10:28:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: init smuio v13_0_6 callbacks
Date: Wed, 27 Apr 2022 11:27:53 -0400
Message-ID: <20220427152753.3107794-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427152753.3107794-1-alexander.deucher@amd.com>
References: <20220427152753.3107794-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11bec456-a1c5-4f6c-c694-08da28628835
X-MS-TrafficTypeDiagnostic: MW3PR12MB4378:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB43781BA0DE295FC3C3DA421DF7FA9@MW3PR12MB4378.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8gMrdJvyKRemipNRmhZvzSOguAxOzXZryIcV6JH0tjRS9KhmTOX3pkf4ROaERTn2UP5A1phs3kE881lv1poPsdBHC2YxNeVbeNw+DEoq59JLYMVOzBHismBZD9WLcAHo2oLy4A0pKsi9ZOLamPDbvH78BG0NL8nremeeVWO5x5t/Su94w0KAFnKfMy3yTqn1ltn8f87xvADLiiCUFDlgBm/ehbpIMclwL/9EZWJ8DuT+hCfEqiVLDbqmrP1mrdFct08d9cKk8RaTp1oMgLQiG7uNN4MtMARrzlIPE6fJul1/MMRDdOJlRS5UCiZaY9hVimUN5Qvde8Fgd3mFTUDw9DxFbf5bCBGOxiOfRVe1lXKR8RMAk88V097gLdH+NX2INwOOiYZvofLMXDem5cxn0NtAgD6yzfghWSQDbV+sSPkXqE/qH7hb2jRhSBBDS18nV7p2lAi/vjdC2icWpaPv+YFeVWtiZHI2p+695MFTDUpBHnlRun+lAg6GwHVi6lEHToQZUmQX/cwKT0Cw9yj/fqKXx75c38kkzB3XUsqq3+9lVuc6Xc8yzogphLWMpDmJqVT5ldgyTAbo69HydoHkfuFs5P9zO+gga/9Xu5j3O7dIA2oTe1hqJkdQ/mC2ibhrXXbph3YmEA516zf/jLPSJ44Nqj00/XQjwRJKH8dJiRe94aLB8yX1UWe7NqdT/o11W3KnSwDi9ZeRpIevd+5Ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(336012)(86362001)(47076005)(83380400001)(1076003)(426003)(16526019)(186003)(508600001)(8936002)(356005)(5660300002)(2906002)(26005)(4326008)(2616005)(36756003)(54906003)(81166007)(6916009)(70586007)(70206006)(8676002)(36860700001)(40460700003)(316002)(6666004)(82310400005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 15:28:08.1603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bec456-a1c5-4f6c-c694-08da28628835
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

initialize smuio callback for soc21

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 834354597cb1..34c22fdcd7c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -70,6 +70,7 @@
 #include "smuio_v11_0.h"
 #include "smuio_v11_0_6.h"
 #include "smuio_v13_0.h"
+#include "smuio_v13_0_6.h"
 
 #define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
 MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);
@@ -2229,6 +2230,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 2):
 		adev->smuio.funcs = &smuio_v13_0_funcs;
 		break;
+	case IP_VERSION(13, 0, 6):
+		adev->smuio.funcs = &smuio_v13_0_6_funcs;
+		break;
 	default:
 		break;
 	}
-- 
2.35.1

