Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5139C3ABD8
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 18:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA0410E216;
	Tue, 13 May 2025 18:23:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zIiTNFCf";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D48E10E214
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 18:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyeY69Bzptz5Z08PuR/LgrYuzjR/8cL/97JZE9dMgeFuHivCKzx8Q1/YOzie6gMBX9Ke+yJivuJ+Fdb/1uj56tx/+BndZad6d4wQugRUFPoTQjTqL6099NCztIy5dHDFPpWiIi/oLvYLr9kUOQHhZXkodzn1v0ZXEwV6Ce5Kyb4r3UOUxDr51BCxla/0ghbFT6LdKU4zeUx8JrlIFFbdmizICb5LHz7+xD2kZz5FMLFv2eOlTnMamyVs15mkYAJcLBzWvOxkA1aGC/HYVXjsgN7uLrZqczh0oFY2w8hTsDlhiF0vFdij7yoFIaIUP6LZPMzrCC7jY+69fX1j1uugeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDYioXcsbONo3H1eq0xWvIpVOWSyDZIGHqiozV0vOuY=;
 b=hNBcUIF+6LvnQMkqVLF0/JqC2+Eu9zmHDW3fsoXZZh62GUTdQk5JqyWZcBMo7QqaGc14xvrAo6gqQSmydwooZa/pLXxJ11aFF3GRHcof9iuPSo574AOK7YKBKrNw5a7DJTOQ8X04j1eKchxmsepWFnT5JUflBiKkUy2AH7VZ/KDxpeaEX3n2k9YRVWhjvyXpEYe5TblCa7uVNR5P+D6GfYU2ny2QA5o0AQZ/QBokre5+i7vhUYtw//Urvs955IGMuMaW5arS6tr9dJ1MKctHlWh5X45TfOVEtSM3yTxAgXga7s2IdWVDLbA5YRjQrh0tnmThG3MlcXZPKN8REFHCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDYioXcsbONo3H1eq0xWvIpVOWSyDZIGHqiozV0vOuY=;
 b=zIiTNFCfWF2MYDzqWKlmxxqeNtX3dZwyShS8wGHMNYVc9pD1zLWXLYQsusclP6M0JW0/d24k4cxopaxg3BwaQeh+9yh35wH+U/P2VWX+ofVCQAi4N3sx7yuA6WogmPWpycAD9Bu7Ebb0oVu0y9VTPgAnEN1GcfGDOk89sV02RSk=
Received: from SJ0PR13CA0193.namprd13.prod.outlook.com (2603:10b6:a03:2c3::18)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 18:23:21 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::f3) by SJ0PR13CA0193.outlook.office365.com
 (2603:10b6:a03:2c3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.9 via Frontend Transport; Tue,
 13 May 2025 18:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 18:23:21 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 May 2025 13:23:20 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>, <stable@vger.kernel.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH V2 1/2] drm/amdgpu: read back register after written for VCN
 v4.0.5
Date: Tue, 13 May 2025 14:23:06 -0400
Message-ID: <20250513182307.642953-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: dfeb2d9a-31d6-4203-8f69-08dd924b3dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7SWIcxw3DAFKsK1Qs8jsEjudrHxXKokLYB4gQZZ/WgKSf9RxKL3DDuTorRKZ?=
 =?us-ascii?Q?pyKCXzTnmh884bjPoBthkZjI5Q/rUdS/0nZRsdIL/iWzCPL0XPA4XG6AGMEL?=
 =?us-ascii?Q?I04GmOkY6/yr0UiGngvgJMUFQ0V4Yer/SfZeISY1YiKutGxZPxvmBABvHqZl?=
 =?us-ascii?Q?hO1I3sDi4EMZfjd2k9CensoW+39CsqgLhfFFQ9/A653Zp4swgehsNBdxo3wa?=
 =?us-ascii?Q?wfrlRJacGCos1GF2aRSjiyWyIp4UjlFg/wBOIUW3hyIpU0HZ1Hlv3W7GhLHU?=
 =?us-ascii?Q?8938XPus/3Fl8IHBQyHywO7zZbQvv+F1Hn1OaMpjEbnP1gwbiHociNWuxOUA?=
 =?us-ascii?Q?QpMJDIUP/oDQKqVDFdRVkKounSVjBeMKaAdy1HVaJmOvZ7DX2ITQIU/GLjqP?=
 =?us-ascii?Q?CNGY+PmwF8DEyFgxzo4ev1Vkw1q3XszsuT92ghswqOn/9zszTsor1EYwhwAs?=
 =?us-ascii?Q?71Bhf8CJOA31U8YPyTxV3mGLFlvEO2cXPNNVijR3D58iSfCS3wdgKxXJyIoM?=
 =?us-ascii?Q?SdGKmo0w6ncsfaQPX+JaSwK+O1uF4A6tWf9EwIe8VH4aFQRDjBIvmMTn9Ly5?=
 =?us-ascii?Q?5uaMNTni2I8diwAhP9/J5y9Orj8hkGgVN3Sc4fMRsNkcmUGGLNTEMYPQyjsi?=
 =?us-ascii?Q?vjf0F+2XfwQPtSqY+AZ1oLuSEmjo8ra/ulgQgHgGo4wb28JBanz++MxE1jyB?=
 =?us-ascii?Q?ADP3McBYTF01NTG0vSsJtEXNbIK1CvCbrDsPazz31U5Nt8lNLet3715LFinr?=
 =?us-ascii?Q?3XKFzuELd9IcNPY+euqM0l5NAqnkPc5u0TrXmFH3eUAMIiDkfDt4+/KqzcNS?=
 =?us-ascii?Q?pnTVjt608NH5BxPul7D2BS6U4r5Fyz1by0m7h5T39t525EGmzjY8WxRvUnhh?=
 =?us-ascii?Q?gqntT38fro00aS5fBNYPXUCZLxw4BP2beGd58bEYJ92NM7QAEuwTvxOE+6lM?=
 =?us-ascii?Q?IIh6b51JVXYaY9qmuTNUAQwk/eEVIXfl0NcuaFetHVxTJoi800GUyMAdnVYP?=
 =?us-ascii?Q?6z5/t4m2H17c748QpctcMawRR+6CD1dkzwfJihDlAYMl89FvBewq/xwNlpDv?=
 =?us-ascii?Q?kJQGsoFYwZ7OFaGCxFlVJTNLmjtSEm6kcKtadQgx6lzvp80WT45KlMN+wOZU?=
 =?us-ascii?Q?2y7P2v4T8J5FJhJQfKkd5SQvyVPzKEa4nCCDwWYWt2Tod88J0C+rDMhA8T6Y?=
 =?us-ascii?Q?JcI2Dz+hSjhfHe2YLtMXcnD/Ab7WglUNIbNo68mzV5Qy5DBo/ncdH/RYZGiv?=
 =?us-ascii?Q?JGq9/MpaZNpCbajXkc4a5V8S2DpEkytlDjkryWIjnLRp7qG/xgTRzZZFSE3l?=
 =?us-ascii?Q?KMmW82ydzBwepgzxGmZwne9HXlW+Opwq56IeOQqaCn2uWxvarogPYX7gmiz6?=
 =?us-ascii?Q?zuyywolOve5OReCYDd6RqcLC36i6JnyC9uXMjkItVpyjHsdJapPjib1OeEmw?=
 =?us-ascii?Q?dfh5phLxH5K1O0Rlr2uC9k4urpLSND1/rVhHnQ0IKnA8e10zqXJzHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 18:23:21.3185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfeb2d9a-31d6-4203-8f69-08dd924b3dda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513
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

V2: not to add extra read-back in vcn_v4_0_5_start as there is a
    read-back already. New comment for better understanding.

On VCN v4.0.5 there is a race condition where the WPTR is not
updated after starting from idle when doorbell is used. The read-back
of regVCN_RB1_DB_CTRL register after written is to ensure the
doorbell_index is updated before it can work properly.

Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
Cc: stable@vger.kernel.org

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index ed00d35039c13..e55b76d71367d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1034,6 +1034,10 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 			VCN_RB1_DB_CTRL__EN_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions */
+	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+
 	return 0;
 }
 
-- 
2.34.1

