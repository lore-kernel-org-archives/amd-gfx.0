Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDF0C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8615A10FF21;
	Mon, 29 Apr 2024 14:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UhpNuNDP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A594810FF08
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gp7p58QlHyKXEzuuRqXpBaNFiDKNDT7fSQfZRv2qoUkLkdjmyloYywyQTZaDzVLztHPJ6QjQ41NwufoweeFzHyuzf2u7CmWVOrKyDtUANQyxf44Qh2DJ+l1u7heVpGuHWaNaodU0o5xUwfRZNCTkqV1aJjb50F+79kHbVEZbhrJic95SPoXcmkGxemKrxTzj0TcRX0vGJ3OYUNeFRpOoaNqDLHeZ8YR5OLF/D+DL9brB92bovlQTdSwGtHJPApDBxOjeeiN3AMD2kHQ2BKxi3BlQPrp5/SeOUPSPScvmlIQIU2LPgS1FVTzjzSteMICV+Z5412Ph6NAJcyWqPRzJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCvAt/2L+BOlCFMFL8S3yaF5ZCLQPp+vdyl5MZ81uPs=;
 b=UBiYK5oqOMTM1yz5HGsGn+yvMGWRj/fljgOPQNeJE9ELhLpqSqR4oam81rvdjlpnTiaxO7XM/n3zyuVFnIY3c04zUx2IUWoQkd5h1U3V0ZaMsrNpAWpi0OINFy/s1v95yKxXRuPEPBhoEs3FvqPCUs1roZoRQR9gFnVqj84xEeH0U0Qe3352ELtFLbmY4NEltDFyDV29bLr/fGJGBeJfXn6v+St1qh9PdxY4O1+cbTi8eKu9osXHjSUEO4fifSyjwRwqWef7Ut58wVestQMIhx1pgi4RsEnfn9cKgKpk/9ndhLuT9mlPHkc14vCGHXeE0HMHa2/yUSvkjaX9f3cprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCvAt/2L+BOlCFMFL8S3yaF5ZCLQPp+vdyl5MZ81uPs=;
 b=UhpNuNDPWGnMe40AvFmajcb5JFcWe9xjRWwbHkyk4758waY6TzKgMQfqNfYjutIC0mxhIKs83Ei6A2vcz2b4YfqNI9UK/0Jj6cK+Ah1VMHC5yJPZWDz4nNh9v6D/Dpvi0EkPDPPViJ3pIJD+Pjwxo7T+ZoSnQfJwdjKMSgH3FUs=
Received: from BY5PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:180::41)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:57:53 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::96) by BY5PR13CA0028.outlook.office365.com
 (2603:10b6:a03:180::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Mon, 29 Apr 2024 14:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:57:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:57:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/14] drm/amdkfd: Enable GFX12 trap handler
Date: Mon, 29 Apr 2024 10:57:19 -0400
Message-ID: <20240429145726.3459450-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429145726.3459450-1-alexander.deucher@amd.com>
References: <20240429145726.3459450-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: fae123e7-92b5-46dd-4864-08dc685cbf01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JRBeprfzoeMGKA3RwIf2u/bcHtIdBy1BPTFJTBWB+oRUQCM59u0rMFRsIlaN?=
 =?us-ascii?Q?VrZYHz6gLWsqGXhbX3YPV9wZYtuydiKrFOpxnPeE5C7K6yDEWGfxRBmM01ST?=
 =?us-ascii?Q?KR5HFWFCgrO+4fOQlNfC834pYLoIi+qlMAexsuyqlfJk8uQmjdRx5F0wpmiv?=
 =?us-ascii?Q?GkkzJX4PDToSfnCTCRsQrbVofnQUnulD7BkW6KDdkkwWid0nClYg6z1l1kJ7?=
 =?us-ascii?Q?HS4sOSISoN4tZGYwgw0a/YNwu+MKt5s2Iv3JcWkjZO7EUD46hHxUbGz11OLk?=
 =?us-ascii?Q?xB47RUTdg2yBZ1SqK8N6p1owA5uR51ujwF/Jy2F5YtWa/gBs+QnqLfu6zlK2?=
 =?us-ascii?Q?DiokXj5r/nzgOeEHbzg5lIyK+vcCiM5jBWOVjOV+d4+LbchdOBj91SSKbuCM?=
 =?us-ascii?Q?BmgpVrNZzQOiBKrj8YNplvcQbf3/F2kJInkXqP/Tt19kyJNqIAbJqrg4jiV/?=
 =?us-ascii?Q?pizaT8TE99hG9J7XEUb8cf6WApXZNUWVi/OAPHEAglqv1ft9vU6pmUbi513u?=
 =?us-ascii?Q?t0r9X3KUkp6HfxMjam7Lj5JHGxIz6qI8M0WPXPp1/HqMrmk///G7SMYoeD2G?=
 =?us-ascii?Q?kmsG5ROYpbvtXxMop47fro0ktlnNuUBDJs89QJeaVFlNfmVv959XkC0cb4iz?=
 =?us-ascii?Q?/RMmmGp1mHzav5mVvosp3EgnkKPyHxSe2ZJJBEHQR5bfd1eKu9tgaTWDKyfo?=
 =?us-ascii?Q?jbbbM2kj7eZYX7wm3tHmKAotSFOK7PFf6+YtsCnVdbdGPP0cKlGSqiNDRvuI?=
 =?us-ascii?Q?QXhcQL649OJbOqsLJhGMJcVwwfVHX6WWZzN9+m8IipWJD0kJgyfYxqVWWDic?=
 =?us-ascii?Q?TeA9PUKvAf7NOniFox2swMCo7ogMePu22UbFkTRNecBtZTXlnLN6A1yyFOWC?=
 =?us-ascii?Q?xhFaEC1qAhZL4B8U7upRCPXGezbj8hlVbiQ4G2DUYKz6vVadHVOli2RXcBf7?=
 =?us-ascii?Q?szVXOg68oORhB8iHDyY1b8NBzqjxph8c/K2/VJy0lafeWcgI3iKsPKNogwx5?=
 =?us-ascii?Q?y8GuR8i30GlK5s0C0dlrNISz85aDBpi+4Verzf6Fsm1ydjrf71v2LlpUIeQp?=
 =?us-ascii?Q?QjKIYCWGXKPKDClC4uajQcNKE9P9gOt/PNA5ItVVkD1hoDT3WeXhFRviUmXu?=
 =?us-ascii?Q?skDOVhzyBjdasI6CwGK68E2AxALsKyJUbdeEHJHcwhkb8QBd5c6Vz2lEEhEi?=
 =?us-ascii?Q?ZJtOlPZTdwx8rtCDU4TdFbqyMa7frRjjTLf5crNe9bnBdT+z1LhMl97c6dDF?=
 =?us-ascii?Q?uxnz3q6jdCso5sFgzcwtkuHXVKwwmOMovpBSVM3Bkxcj3OUFYHa78FxHuyrz?=
 =?us-ascii?Q?OOiVttYffADYe9trsxuLQr/Z0dbKOhnwFbiWm88RiLfpxsgxpPHbhpU9A9xK?=
 =?us-ascii?Q?DvF2Tyx4dVZamHxBZKtPyGYya+ee?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:57:52.8705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fae123e7-92b5-46dd-4864-08dc685cbf01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Belanger <david.belanger@amd.com>

Updated switch statement to use GFX12 trap handler.

Signed-off-by: David Belanger <david.belanger@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 1e21908e972fa..093987b1e373e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -525,10 +525,9 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
 			kfd->cwsr_isa = cwsr_trap_gfx11_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx11_hex);
 		} else {
-			/* GFX12_TODO: Change to gfx12 struct when available. */
-			BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
-			kfd->cwsr_isa = cwsr_trap_gfx11_hex;
-			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx11_hex);
+			BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) > PAGE_SIZE);
+			kfd->cwsr_isa = cwsr_trap_gfx12_hex;
+			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx12_hex);
 		}
 
 		kfd->cwsr_enabled = true;
-- 
2.44.0

