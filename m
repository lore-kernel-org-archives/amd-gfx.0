Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A0EECAAD4
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 21:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0992910F3DA;
	Mon, 29 Aug 2022 21:18:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F107110EFD2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 21:18:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eitJdRmY5D7HWgN9h5b8xpmyS++wfAaBeJqz8J65CsjaT+YNURx82/zk9uGcf7QmOCPpwOGR0inZctuV74b+75xoAJmXDYf7m0PPaFLQCVD8qjgCBLcztiIOfdmhI1qXcLJnXxsuS0zSAumqqGnSOOJuMKNZq9Iw/dISVfnUjn73fVGij5NEcwKdCzcejorQRq3y1GtrUP074YmV0/uXvZt6AE2/C15ofYSOPIU7lC1cTfjyw51sfzhoWCJrNpshhj5UeV8/kwBef77piCDs3UAbz5IH6P2cV30uLzCUkHOy0xu+L+276BRs+BuBejuvXFTmiC1tPOQzspO/Oy7nxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8G2AhWTEj2QH6Pr7L9dhYe7E8L1AlracrLeqi3ZtKlo=;
 b=QA3pS9JXZ0OrT55yl1qMKondIqqmALUrFw4dntki1x5ij2VpcNbfbaOb56K1c5LMhwTTijkbfGeK7rqec0aJBgv85LST5DlaeOw5eLn9Jg2MbMOGSUX/GolKVa4BiFxlB7SfiZGcaICam8ltbPHlQBXtEW98l39RyeKIK5VacUCYf/UYxtcJ5ux6cclsbFl/mfnZTzOWk2Uxjv5CDNV3mVqP0CnWfm6mYNBZye1ktA7OYezhHKVh1zMh9GO1UATWMsCHlYvpauVBoMe1YSqk7FEiwQ0Q3yuFt97yUOpq4sX8pvWiAtggOQQR9wsWMjCMVCazWrRSZoK8I0mKK43XQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8G2AhWTEj2QH6Pr7L9dhYe7E8L1AlracrLeqi3ZtKlo=;
 b=kEBifUXkezyqaIB8SELX76H1qnYQJLbUegQTq3G7VE4gltpHbVPx+ss8mUYcAnjeoF3U9LfvADDSwYNRojNhJoYB9ZPLXSauv3TjuX6NulKqZ2QdG7m/oLhPRvqwsLM/4gE1v4udMIeZu+4nqtG7J9P3/BaMOJCRaz3vYYFdHDw=
Received: from DS7PR05CA0084.namprd05.prod.outlook.com (2603:10b6:8:57::25) by
 BYAPR12MB3526.namprd12.prod.outlook.com (2603:10b6:a03:13d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 21:18:29 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::c4) by DS7PR05CA0084.outlook.office365.com
 (2603:10b6:8:57::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Mon, 29 Aug 2022 21:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 21:18:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 16:18:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amdgpu: Set GC family for GC 11.0.3
Date: Mon, 29 Aug 2022 17:17:54 -0400
Message-ID: <20220829211756.1152505-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220829211756.1152505-1-alexander.deucher@amd.com>
References: <20220829211756.1152505-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4043c87-cd53-4e19-4830-08da8a0404ad
X-MS-TrafficTypeDiagnostic: BYAPR12MB3526:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43RAdxEwft56oxmK01JniZycwW8rJ5NcOoj9wFLtaosA5AxfAam3ECOF552Y830hXqQx6M0HZNA1clH0b2mRPso4mO6opAGwRJL0aAzPOOWDAPdIMsnWxjR64lM/qO6PqJtI7kuEkkC0MSDnBoxVfJg+S9DXn+LDrS3QJQDxkSf7vPuf8KG17z6PIzZhpG/4ueoMf8n0pB9R/alAW57nogpVMM9Z7iY5t8+EGCCZ5jlxyXpB/bVgM7CEiYZNrYVdEEu3tQ0VqnUDL3GxXuvPe7bn94m7h6yTZAmPJi8iSOAo5WoNgA4NrB0H5FLm7zgxlpwXq77dGlKufFGY5rmVNKVd9T66s74QxapQjMj8k0j9lrVFlVFjiZKp4qbga2EO+o+jo1XCRA20VQtUep1qud7H+DxmpW2jfV+8rSwxwL1OMK6siGUlxVA09qPf+xaZr8Pk+UTXLYjB0/1gMeA8O6zoI+V+COx/9lf7QOQVf4ub6HnlJRUh81+PwEbflP/wFPDgBD4nU2GWwC3INsd6IZqlOd/r9/6Tqj+2TTlvRbxFzf/sf9f49yDmV2F9X9NwZgbg+hr9R1jJTl/DaAOxGy+47gwGyayNgrZNqyW/510Ity0CkmIJm6bh5VO5hml2Sg+TTawRrRw7XozhXLoeZlsIt/flU0wQUpos5rPBI0ZMvzl2ngrif71kqORR12wBeXHRxJ+5Usfj1rwjnRBEPLUbHNKDcJhDt+ZHirCpqp+uEMv4Ft/0vQu+h1nMH4E+DCTmV8J02lwAvuhK+eJD/z3C53SYIUOAtwtb0s5aRuU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(36840700001)(46966006)(40470700004)(82310400005)(26005)(356005)(81166007)(1076003)(316002)(36756003)(6916009)(54906003)(82740400003)(2906002)(7696005)(8676002)(8936002)(40460700003)(70586007)(6666004)(70206006)(4744005)(41300700001)(83380400001)(186003)(478600001)(36860700001)(86362001)(4326008)(426003)(16526019)(5660300002)(47076005)(336012)(2616005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 21:18:28.8376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4043c87-cd53-4e19-4830-08da8a0404ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3526
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Frank Min <Frank.Min@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Set AMDGPU_FAMILY_GC_11_0_0.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a22b37495123..2d419bb18787 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2170,6 +2170,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
 		adev->family = AMDGPU_FAMILY_GC_11_0_0;
 		break;
 	case IP_VERSION(11, 0, 1):
-- 
2.37.1

