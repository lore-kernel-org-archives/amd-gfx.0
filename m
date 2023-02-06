Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAA5C6379F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 17:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D42E10E428;
	Mon,  6 Feb 2023 17:26:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB9D810E428
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 17:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahjRvCR45G571eDiPjBLN2LNZac4cJwdYajVUSi5gm55sILcJ9tbomtRviSS9YRGsnxw1a064PHmmuLJ7kUs/51ltRMyGL2+xJKV7KhTD2lEqoOcjPQTI+/uSLkqFVJV2gYTYTg9OAKhfrNMkzi5ul5mVszyx4GjGQOu8lIunDZO6mOdTUeZMpc8pzpQFYklcLW2ltXEKlnPdkfjI4q5NDVhn/Vxpd+fMEMz6EvHVw7Zv7lBFCtYX3b5GAqUfF6MJQJ+TfciH0M08bS79yFu4mJnctMG8UGPDRVu9eQ8ZtuU51kowFDkrP/qJ51a+SdbleBPmkAwYCLmtmE4ydwozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0y1b8c6VPE1WQ1fRcwk8EwvHmuQQE4CkppkZOaL4N54=;
 b=CblXzcVpnz4Oo2CzQxUj0TWjwjAgbZo6u5Ai83kHVRNhX8E3MHudDNUVXNC6jQA4cWlrQXEs7j1t9bz7egmlWVY5sH7JcLhRZXQ8mIWwkw7yryzRAtji8YmU0QAAs6v0A5EDRLUE3ZyJ+ZPfWVZt8XiPHBH7KUiZg+kZr3pEhArfgE9mk20HT7qsvH0W1vG50nWBdh11QQT2c4Pt+Nf/Rvbm3Q6w6M4WrZNChs1K0TIKqWdYtV+wEZdvvs7z3RipnzYwnBmO4NZfumgqMrzo4BfKS03+yTdQbhygZ8ku7tiUGCqZ8Sd9ckkl+uhm3JRKWy7lA5LJQ2nd994XPza8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y1b8c6VPE1WQ1fRcwk8EwvHmuQQE4CkppkZOaL4N54=;
 b=xaE6h0Npd+05uoLxpg6SbMuwnXu9+LWSR0goq5wMJUusRTZ29t+JRzDHXJEk+zQpVx2iNrg4NxfvyhF9Vxy0bYthidpDUK/hXCObOFZIvH7D9BXmF4aFUCTUSysHOrGB1uSh9PoA/uKbmEJi9en+zsUErqVbrb8TJiS7XBAs5Ag=
Received: from DM6PR06CA0086.namprd06.prod.outlook.com (2603:10b6:5:336::19)
 by SN7PR12MB7155.namprd12.prod.outlook.com (2603:10b6:806:2a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 17:26:03 +0000
Received: from DS1PEPF0000B074.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::1) by DM6PR06CA0086.outlook.office365.com
 (2603:10b6:5:336::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Mon, 6 Feb 2023 17:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B074.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Mon, 6 Feb 2023 17:26:03 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 11:26:01 -0600
From: "kent.russell@amd.com" <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add unique_id support for GC 11.0.1/2
Date: Mon, 6 Feb 2023 12:25:37 -0500
Message-ID: <20230206172537.2320224-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206172537.2320224-1-kent.russell@amd.com>
References: <20230206172537.2320224-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B074:EE_|SN7PR12MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a6509f-752b-4e7c-9542-08db086738e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+UAu5ze4cODuwHTW0P5jf1XVr7njcRGQBqk7RSQR88zZghVlOztfy6R13VTW8aFnpK6qqnsYzvC2nJ1Annl8cQ/fnAqsGDFsqxqHSvKnt8NTKrD3SjWWpFiJ0cPPQEsB91LX20Ss71fmIA/knRvwWfh1hhKET9m5HUBoJM+QYtpLku3w+OnxkEaIb9TdcZ0q2ONLTqPnKhmhoKhJ9KNxQfkIaAPuaq/YyfiJ2KwuIJaJtfJulBAOUZM1+gf5DvC8uuD5WoccLkIXdhGXud5eDdOvMTnmKngAa8Zl4BoR69Zwns0TcVcPZr0FEylHGJ8QnZ/EWfFVZ6aJW+qlFC9AHfsA/1xbX1VJmnGt7sVJdud7450r2A47PlWeINfHM6K0WXXG8o+etRyhlV6GahUJK1izCc2lbyccUPFe5mkQ6Nfr7EIKvwkox3vhck6TS44ijzD/wqnJerL+toNdCESNVavoZGIr5K1X6NRE8/DyQ4mILG52Fg1v73UXY8NchuKQeU2mlroXHu9a/nytTfL8qNc2dXEVDvbPFtx+PU1LbCr1LjXXLgsJRrXJAc6c+slfhI5H8ShAy5nFz7nPvNKykBjuYCyp0231cwrORccuyUrwtyZJ2FwML2MV9ysycB8MmQf3edRhs/w85Gea+VtMHyxqEHEW+OPX4RHDdvGZLSSQkqZKDS6XLjw3r1BSxgXMMqisd1ryDUe9+/Cm60goFlaoA3GKpS/ihiilJOnK9c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(82310400005)(40480700001)(478600001)(316002)(2906002)(7696005)(82740400003)(36756003)(81166007)(86362001)(356005)(40460700003)(2616005)(47076005)(336012)(426003)(83380400001)(8676002)(6916009)(41300700001)(4326008)(6666004)(4744005)(8936002)(70586007)(70206006)(16526019)(1076003)(26005)(5660300002)(186003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 17:26:03.1434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a6509f-752b-4e7c-9542-08db086738e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B074.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7155
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
Cc: "kent.russell@amd.com" <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These can support unique_id, so create the sysfs file for them

Signed-off-by: kent.russell@amd.com <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index bd060697d982..bf6d63673b5a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1991,6 +1991,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		case IP_VERSION(9, 4, 2):
 		case IP_VERSION(10, 3, 0):
 		case IP_VERSION(11, 0, 0):
+		case IP_VERSION(11, 0, 1):
+		case IP_VERSION(11, 0, 2):
 			*states = ATTR_STATE_SUPPORTED;
 			break;
 		default:
-- 
2.34.1

