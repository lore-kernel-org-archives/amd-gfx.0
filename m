Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31C3ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 12:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E3F10E07E;
	Tue, 30 Aug 2022 12:06:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B704810E07E
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 12:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPtZP4Vg0ZDI2xogVKriOxlHo5pCot5p2uigtToZGCRdI/lLVASviSSP9gh8ybp/vNmmjD9tHTe5u0OazJqRfJhdzOaH1kaEDSQFlg1RZCaTmT6lvfsbnpQNUgaajf6TM1GBVj781yjX4Nt2xy7LZGaqEmkEsxRWL6k3jh1+roziCdIZk0Tcx/VIHrjUOqwVmT4cgTVNpwhluyxGVmpDNr1nnPw70cNudd1XvT/JOhOd/sRQ2QCyQMW9z79z8aDzbKDgb3aO7f/DW41+UgyDkwf+p2qbVbhsq/Ywdq1bdyFegLd7/WMdqAxjY4ZU3H+/xNuIAZKUbe7VXNTRrnMxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raDul8X78qbIjA0G2kHfFdf+Mg/aQspWnFO/mXtcMf8=;
 b=Nd5hPxtVT5DbiL+12FSvPbpgiC5dp6cR4oEIwvJscrJyShE5JuPJX/tXFwOnuzA5NHIar2ok0KFnVIjOyX0Nfzj90ZwJUim1y2eU6OGuvAJfKva3X3eeY4htdaAYa7lS2XbPtPPuX6KTl7I9m+DASsVigfeS7xqbituai9KxqzZ6jO8ECWImrSThEmde9pe2Wy58QpyEOQ4SOf95/gWsm+wh9TpIqi49YipHW7aw1OjW/nW5Ce1ur+nD1KqHBpuLtGNNl+il99A8vmHwXbGg60QvGAwo8DfEHd6XtcdoK1ObW1pGjwh6Pc3zufilt92kixsvYkgbeHqPFIpiK7o3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raDul8X78qbIjA0G2kHfFdf+Mg/aQspWnFO/mXtcMf8=;
 b=xyNy95mdESrB5Na2J3GwjEPtWy91SiO/a3CRUSgo8V6G5/jb9+MsPHsmLxk07UVTFa1zvmPnx343RCEqWJ/G1AWW9GbwtsFAprIYQjkDkTgTzKD7NlkM559bECziNFAhHj04N3hY+rimLFZnpK6wJigH0gdG/i6kkLcFkVNTRQA=
Received: from BN9PR03CA0660.namprd03.prod.outlook.com (2603:10b6:408:13b::35)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Tue, 30 Aug
 2022 12:06:10 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::86) by BN9PR03CA0660.outlook.office365.com
 (2603:10b6:408:13b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Tue, 30 Aug 2022 12:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Tue, 30 Aug 2022 12:06:09 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 07:06:07 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Remove redundant reference of the header file
Date: Tue, 30 Aug 2022 20:05:53 +0800
Message-ID: <20220830120553.1482014-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24cefd3a-d550-4206-796f-08da8a800670
X-MS-TrafficTypeDiagnostic: SN7PR12MB6888:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xImAUAikI8fVNf0XNdMp4XeoYDPDho5CiP+3rJHftGQ27JPtVqjnAMtpsuRUZzeVHT3GE3r7DU9cyZtDk0MzADSHDIDy67GcK7/wLBgkD8eSS+7rpXOH9pPGb7J17KIJ604bQYCwS5YJphgYcmSxB7nsiuJIEmalxymkB9ory1QeYwTi33L2na6L7mnDtI8hJbT7462F2Uj02ImasAtMYnXxdJN+L+Rx10G37j3G0+s+33n1Qd0K2n2hzaGG2EVihtd3wFs7O+gRGiw7nLD2ba6PlPGVsAdzX60keUyyaP09Gy+gSsMMEmVXYxA/M8i3Zt1TB4vjBBz1UTGG4aGXaHZw5HTyZFp0N92Ery4iJSBJs1TBpGMVm9aulG/kx9sdS1h4L1Jb+c4aYsJEQY1xcQbAoJ8ju6FhSFjlJgMRQuvx+AnL8eGNhLBpm3gN9eq3vPZpgevsgyjya9+qbwi8tyqEbJPQLDd6nE8D0ttKo3CYFfkV+yT47uc+Tv9T3XIeruxHLTAa6lXc/V/2sMZGEV87yzz9t0eGLWECcUwSCf8EuYl+NVz+jMDWlDsE9vIviT3iVNByVb3iMaXpYqlO/dpOY/xCrOxJcyJW3WdjjKUwGD4ELdQpvixFQLl75jHvd41xAu7Gmn7dXUUQQE66MjAFcgHZlCNCbyS5rwyXzzQ/liQ1TPsC9E5+efwBjSfaqGJ5U8sBMvmgauz0AdJyt7+zn+F9+bEl1pIexDCX7qR8ZHmYoaIlh4D2nrE10dF91TEjDldEx9G6pKJxLVXGZnF9X7L8acaI4aS5YSBe4KjOCIFr76IT3s1YjVSXnS1BCSRdzXLXZbx387z6bGwaPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(40470700004)(36840700001)(4326008)(70206006)(8676002)(478600001)(110136005)(316002)(6636002)(54906003)(70586007)(40480700001)(82310400005)(40460700003)(8936002)(81166007)(2906002)(4744005)(356005)(5660300002)(36756003)(82740400003)(86362001)(7696005)(336012)(47076005)(16526019)(186003)(426003)(26005)(2616005)(6666004)(1076003)(83380400001)(36860700001)(41300700001)(63350400001)(63370400001)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 12:06:09.4202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cefd3a-d550-4206-796f-08da8a800670
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ma Jun <majun@amd.com>

Remove redundant reference of the header file drm_gem_atomic_helper.h

Signed-off-by: Ma Jun <majun@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5140d9c2bf3b..b4019c4661c4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -87,7 +87,6 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_audio_component.h>
-#include <drm/drm_gem_atomic_helper.h>
 
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
 
-- 
2.25.1

