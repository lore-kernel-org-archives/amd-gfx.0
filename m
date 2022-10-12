Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E76C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Oct 2022 19:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9A1110E00E;
	Wed, 12 Oct 2022 19:08:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AAA010E00E
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Oct 2022 19:08:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVJ53bEK/jsVu2Vtf8Lq1XU9pZwemPN2jsdtbSOOUw9hCWEwyi+BtEjD1C7sFTPf1XWPro3gNXbxX2bypZ3VDrUVYSccPwFuiMZimFH9gqOcIhKqPiLGRy0ohFUa0cn33pol0x1u5T07T0IfrtSBvXDYP1hGKTGZsGc7ikhwCFFtwYbfCQDNsZaCUdk4fTsANMZagMlchuMXZzIZso0crjhL8kX8oNpiOZ68L/DIjs1K/QHxQhGqMOYSAjfurrf4OTRpSzJbQiqZj7ZW7washdEl3mh1xC3h6QGracaLTg8BSMD60ZbQ7sM9tWr0kaEmDv8ZmavDt2UcsDrAqwFmAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OetS2l/zNyZi66onHkT09bmRcHRc97GzcGcGpAJo//s=;
 b=G6+2IRlQZaa2g9PLwE0F/BhSo8rMlgsvZ04voHmnQxpVwR5981Iqq9uxFodZv5peL3dkK9mFrA2uuWnxQU6L4fn2reYEc8zoL32Z+P7N52DmC1/AA/fIAdboY2y/yDpc3ib5mLyaA0qfJAIxa5IsO38TnmACVnnUKnZKWhiKPmIPP0uPTGy8aL5ymd5CTnjbKlnVPlVtcOfblGkh3FPJmWbMaVDNCti3dchPyXf+cPRoh8d2LJWo7o+VHEf+DemPMBFBZ6iprRkzIcy5I+aewIHP+jNYMonwxWyjIWL116XppwD99oPcdh+CYmcrvxYwTZ4qZipJXIiIr6rO8q3+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OetS2l/zNyZi66onHkT09bmRcHRc97GzcGcGpAJo//s=;
 b=PDzwZCiHUaw934/ZNNPJ5dd3wdHGoyeI4D55MXPndRkLfeQO71Z9BUhwhyipVz3oq8DVLcvp/lJ2kfO8UNnYQaTqns98aCNcc3WKW51QtFvI+mGdWVZwoFf5PlBwXhBy1AkwDZTyAqgQJg+APInCvBkvxDZESpj9ATWqDMwJEXU=
Received: from DS7PR05CA0046.namprd05.prod.outlook.com (2603:10b6:8:2f::14) by
 LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Wed, 12 Oct
 2022 19:07:58 +0000
Received: from DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::4d) by DS7PR05CA0046.outlook.office365.com
 (2603:10b6:8:2f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.10 via Frontend
 Transport; Wed, 12 Oct 2022 19:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT080.mail.protection.outlook.com (10.13.173.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 19:07:58 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 12 Oct
 2022 14:07:57 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: enable cooperative launch for gfx10.3
Date: Wed, 12 Oct 2022 15:07:46 -0400
Message-ID: <20221012190746.3318031-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT080:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: bf416634-107f-4373-1969-08daac85136b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 49A3yHIiILJcXR87K9fa0U/3JVA6U9QkuJ+swJReCpdFJxIfAaNQ2TCMH4M8gEkPd/WPyUWGM0iWbe6uQZbGno2sZOH94z8+wN/Rg8Y55JFMgppdaqMCJxYLQUxhIp/KDdY91slpze+E579w/wHyyqJXN3pq+OkINVdECvKoqX1bHvGnooWIvQJIKzXJuAz74yX5y50OcXVC2MwiXYDgIJghOKMe64v23kLs3n7zex8iyAdzCNUJ9bt2D7rtppVOYiCA0TEsaLuplf/IQcm/NQ/3duK/qGkkCEYBW4cXcsFG7O74eIQ1nmnNeaiWHTo2tmfcbrkYwCeOQYwQNEPb3O+4Pl5tOj9fj+cXpeI2k6lLYJr7bx3YrexMItbuxRl9GG5pdxb5sR8ggGacgrtP8EZGJvWVFmHyawvGJI9CA6J6m3K6AP/hkrQpnmZEN3izlI2gIRoC14t/cjOJrwL5JIufQFVnNzV9MX2JWeQQbQAwJHrv/cP01UVqV59KanDynabBxfMD703eB8lp1UkCY8XbRr/SmJoftpvZlAvRCAVVqCpUfS42pDrvk8FwtEXIIFDea4d21AN3JIYaZGQlUa41htFOnZn3u2Ox2+rruTOGc7e6zm/GZyvpH+4pv9em4QSKKOoCv6hmYRQeSLrYD/y8HlefO4Qe+f2u4gAWbzjF4s1WIvwbkajQreOw8pGqqmRTIsS89Gxksv/cckTLN7yOEEIFYD7pwUbkSuDVaf0xWo/J7RQAvLcvKsF4UytwuYJt3QJmQPD7Z69bvI5C7hRg39GcNTxGiMy1lGQf28bnJTBuEz9qxHevTrn/sE2T
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(316002)(36860700001)(40480700001)(8676002)(70206006)(4326008)(70586007)(2616005)(1076003)(40460700003)(86362001)(186003)(16526019)(6666004)(336012)(83380400001)(54906003)(26005)(7696005)(6916009)(82310400005)(478600001)(47076005)(356005)(4744005)(426003)(81166007)(44832011)(8936002)(41300700001)(82740400003)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 19:07:58.1979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf416634-107f-4373-1969-08daac85136b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

FW fix available to enable cooperative launch for GFX10.3.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index be7a0b5a2dbc..66296cccbadd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -498,7 +498,10 @@ static int kfd_gws_init(struct kfd_dev *kfd)
 		(KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 1)
 			&& kfd->mec2_fw_version >= 0x30)   ||
 		(KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 2)
-			&& kfd->mec2_fw_version >= 0x28))))
+			&& kfd->mec2_fw_version >= 0x28) ||
+		(KFD_GC_VERSION(kfd) >= IP_VERSION(10, 3, 0)
+			&& KFD_GC_VERSION(kfd) < IP_VERSION(11, 0, 0)
+			&& kfd->mec2_fw_version >= 0x6b))))
 		ret = amdgpu_amdkfd_alloc_gws(kfd->adev,
 				kfd->adev->gds.gws_size, &kfd->gws);
 
-- 
2.25.1

