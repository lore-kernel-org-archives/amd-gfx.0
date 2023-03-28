Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997B3C76195
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 10:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2325410E4E5;
	Tue, 28 Mar 2023 10:51:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EFAE10E4E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 10:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZXSk7SwaQvYa556O3KXutlHm3PSSXydz4eF9nXT0KUdEWrjAdYhqTVQQLGST1w/0TKrYA6M9QNRJ2dHmLJf8sNExFyLhRR1L2mcTK4rWwDQ/Y7f49Jy4FNxXVDAqpYqsXpfF77xcHyWbH3ZxioZtIwqZbAnnnRhHZsFBlBhCxmZP8bvN3rA9NpVWJ9S/JEvkfUGeoCmiTWj6mnkhqoDw4DNRXfheYGrMYPgrqWivwEmDANgFEesCHDKPIfemFtvl55NmSBzaZF/G7yIxi+ialK2dw6vTZVqnsC/H7BBUdNOG4lVO0xrpHiyWSeZc4CsNm6K+B/YtKVKXruoeAkJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3jeWbVxjcdaZKxbYiK6eYG0ywb0IY3JOU5gMb28yIM=;
 b=kGKKqLBXVAVTfvBtaMu8mZraIH7x5P1XNZQWVapCXrPwCvGXiipueqhf+7Hv7kZQbDt1lBWUm6WQwQVTsFN8ADiVfQpJjQ78Pb/taHyt4v+VHwB0lxSdIeX0FMzjMcRMzkgXVFviKfFyYO/T3C91VGP1ZgHq1lW7Fr4vYEqt45Cqzl68sJZ6ktpqrJrledSDIl3MIbqwIhvYpsqdJRigKOKk6AT8T1fVUZaxLk12ViJ9Cfw2hMQHCd07N9xLDNc3I6aslAbaW28qNGnrt5q4XUWzNZOkvO7LicwChEFyIqcZaHHBhjXGPCW7QNNdywGD7UXyimMTTYeJ+A3Ul6xX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3jeWbVxjcdaZKxbYiK6eYG0ywb0IY3JOU5gMb28yIM=;
 b=pUKPHrbZodl6ifikdX2QfHjkpgnjZBJKcBzUgY7BuX3c6Qy0M4q8MU9PWVnvW5wtI4ENje/gnJFkFJoWOkNEq5N+1HoZH7yvCcC4W4gqDfrdCGH2m6fSMsA+/EG5ci6xJOBlUBScr545bdHvuKcL4HI1L+CfzErn/ypjojgdtqQ=
Received: from MW4PR02CA0006.namprd02.prod.outlook.com (2603:10b6:303:16d::12)
 by DM6PR12MB5008.namprd12.prod.outlook.com (2603:10b6:5:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 10:51:10 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::8e) by MW4PR02CA0006.outlook.office365.com
 (2603:10b6:303:16d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 10:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.32 via Frontend Transport; Tue, 28 Mar 2023 10:51:10 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 28 Mar 2023 05:50:42 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: correct xgmi_wafl block name
Date: Tue, 28 Mar 2023 18:50:25 +0800
Message-ID: <20230328105025.17511-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|DM6PR12MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a1c388-d0d5-4e6f-1ece-08db2f7a57be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPbVpeUHWfq9igXUdQUx4odproGeLbcrQHlIUIp/BqL1FfZZtKr0uaMjI35pbqFDay1vgNZrQRmIOAMlOaenuzpKvVBG/rv6T+Yk/rzb9wnL7l40T9X+/tkHDqTNkz4iQqsMcLgqslRj7QpgbmNd9yxGuA6Qk+hqoHz+YacvWW/L6YEf304q/6oNxb9tobwxaBAgBZYv2OGmgK/KjhFXDWHS+y/gqRDtVqD+fYcTqfe6GJ8a4mUYWrYDywVqtOIavoMMNq2kBgjr1OpXig3vXTkty090EzbG9OIAn1KrjWQBXjb4kFBrHN6tmJ8/C/xrsUpKZwCqHfKwRTMx2lJADQn3Aki7O+fk9Yfm4UlFmAKmFW5iJ1st+KFHCv9tJYNQXy1KfGMuq+v/jyZmomWonQdgL+Bja6q6EDGMGC+aEV/5H850iqQWqLBYqqxXzygszxpHvz7QZ0Y7VqjvxTpa0K0GzHnadazvCFI0f3YsHr7v4rzCHrJ2dNCZhZpdKregOkqvOSzqzxJDMx9NXECUBnLO3YcD8ich8HQAszGF5pY2XoUGWyVTEAL9ZhEoRlCwgW1Yz+jrd5R7xilyL1v51BrqBdhpw2ce70wPTu+OFyns+u34g2IjmZz9VaVQo2LgOD0HYm4x+zdV3gqIYuOvbjDfvwvGM4q8sVsr1ipjNHx2AcBZz1bZ5y3uQ1S32bowVLIUh2w66SWy9pdEihTYtoc5SQFC5LKpzHA/D0iMVwk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(2616005)(6666004)(110136005)(316002)(6636002)(83380400001)(426003)(336012)(186003)(16526019)(1076003)(26005)(47076005)(7696005)(40460700003)(4744005)(40480700001)(478600001)(86362001)(82310400005)(81166007)(8936002)(5660300002)(36756003)(82740400003)(356005)(70206006)(70586007)(8676002)(4326008)(41300700001)(36860700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 10:51:10.6244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a1c388-d0d5-4e6f-1ece-08db2f7a57be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5008
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix backward compatibility issue to stay with
the old name of xgmi_wafl node.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 3fe24348d199..439925477fb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1068,7 +1068,7 @@ int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev)
 		return err;
 	}
 
-	strcpy(ras->ras_block.ras_comm.name, "xgmi_wafl_pcs");
+	strcpy(ras->ras_block.ras_comm.name, "xgmi_wafl");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__XGMI_WAFL;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->gmc.xgmi.ras_if = &ras->ras_block.ras_comm;
-- 
2.17.1

