Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CCBCD128A
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 07:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F270D10ED8C;
	Mon,  1 Apr 2024 07:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QO3QX/DL";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0644910ED8C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 07:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzgmkRRWbP7CSCGV4bk/GHYLU+omicX881NeszbXaBnPl9wJiJHhtRV9puMYvl/Wrayo1fKWPZDtPKhZaVKiIq0AcnYwH7kfdtpt/GYsqrnaOCU2nMqHzyH3jaloVpD1GVu1eqA2uXsq+jgacfjkHYTGWf7APlWBsTb5Y23UmcOAjoKFpO63upg2xydJx/IfF1FZ3VkWSiYl5jMm2u9TZQhJ0r2n1WeI3t8LPgBoN4lI2Vubu3s7qAaoaX/tW6THC7XTYez5mvDE8oWaWpRZPiqiFLbTUF+fBw36y8ZG/LcDx9fcBmo4VTPJBWNF79q0cow9253DVJzH+dI9BdT0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/IMMzISFydG4xQtIIPlv9eAZnoxaI2VnhiH0BBw8Ag=;
 b=hnINpyHO+hh9PjJII1nk8uMxCu2pIXY1rBq0I9bM6aBwqpwP6+b6BYPJFrj3iczpZk/bhLdts04zHUFsXZgGLynpBiMepAbi1g2li9XcbySbFKkC9+kFswQ60CbnwdygAqIkXVgUWzTP8Ji3Ty7XJPw6sPGZxdyPCw46nAdU454RFe+htp54di7NUeqrOF6j/8zASY3ETzCCsgL1uLQ4xwy5lv2I6E9MJs55mhTiNW7sqtC0p0dtYaS/mOtrb+sohu9F4VYbZlKvqpYEq0iDKes0waCwwa0cUF+MTVsmYaMTczku4UJfHgCiFUVG3SyrugWJIiRqEQC6q5b930XlEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/IMMzISFydG4xQtIIPlv9eAZnoxaI2VnhiH0BBw8Ag=;
 b=QO3QX/DLYPcMEwQSntRzHbeogxSHk7VnjbVAzlAXgJU88HcTg1JNeKBld8KtOvJLXh+6egtXkTFc7HDD3fYNYthZZqESFjCeFAr7LHLl0iyXdvRT/9e++HZvZ/Hu9UxayYUyZC8uKIGW55AkgbeXGtzbqcwvg45B801dR7IXQlk=
Received: from BL1P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::11)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 07:50:36 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::92) by BL1P221CA0013.outlook.office365.com
 (2603:10b6:208:2c5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 1 Apr 2024 07:50:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 07:50:36 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 1 Apr
 2024 02:50:34 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: update check condition for XGMI ACA UE
Date: Mon, 1 Apr 2024 15:50:23 +0800
Message-ID: <20240401075023.370054-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c187a7-53fa-4008-7af7-08dc52206aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHI4uckdni86T8vQmW4AIdJP3aInC99U6FGNlywDxoKpDxQUpKz9awwGl9dJckpjZGKFyPyR0+gH5DhbNQToSku3pmwvjDRzt2OCgxKttOjzqypOzpJd8LsbO0oTDj/YBSwXhEt6/j//OpDPnKQzwIfRtdY7WafVNZB8I3WRiFvF2wRzkNbx2VHmvlYCEEVXFurYin+o3DEkyTmTioHkOsABtwVSga8nJw+i8jQFz8IrHPpGD0XURGVx+qGcAbo79JksqVmEIoZPgGYF4G+ujlAHSYhkWgYHzg0F/SCZBZ66Pd/C/CuvnebHCLHvcfo7bhKnK+C9M6/hQ0eFWz1auzelQU+cOCMaEbNbixG1hYnhpanXQxaV8m23BVEJRE8npqHmDMg8qGQRFjbjVuSwwyDHLdR/yHH4f/9+XuqNUxQAiQ2G74k+lIGCNUVIBpOFN+eaxKMol1UHAZ4P7OQjRYfGc+y93wtIJzrdPr5M8xbWXnrI25MnRj6EkwfHM72zfJJy3cnKBmB28t6LoVkVRgzBoXOpw4NH0F/s7i+8UmUZ260ejwHDGA6fl3oDH+eJaLrSoMPWcebvKUI8v3P386dB6y0cbG0ZUVtPXO8C9cnMxV621c45hk0iLhplVoE71f6qZ8XR43J+cMWwQ/HTj778m7dRCITe9WV6Eb7x3GKb4jPJqWw+iSHmEIdVSsV6NZaYWyRaRQE72PxN5FllIZWQc5aM61ltUDiuv6slsdpYZ/TYzR1cZLW9I6jHHoSw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 07:50:36.1574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c187a7-53fa-4008-7af7-08dc52206aac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864
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

Check more possibile ext error codes.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index f4be524b0dc1..be1f4efa9ef6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1066,7 +1066,9 @@ static int xgmi_v6_4_0_aca_bank_parser(struct aca_handle *handle, struct aca_ban
 
 	switch (type) {
 	case ACA_SMU_TYPE_UE:
-		count = ext_error_code == 0 ? count : 0ULL;
+		if (ext_error_code != 0 && ext_error_code != 9)
+			count = 0ULL;
+
 		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE, count);
 		break;
 	case ACA_SMU_TYPE_CE:
-- 
2.34.1

