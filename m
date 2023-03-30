Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84454C7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0652D10E3BD;
	Thu, 30 Mar 2023 19:27:20 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A65010E057
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8voD3ZtAB+5X0lHBiJDltWDS9RF57Xjt08CK+C5h/irOLwFrVmwVYJnguuqe9l0qK4+OI1T7NU0/YHiUMPN9j+jMtHlzZM6BFmWKO9Q9vAr7J8cJgFJolJ7FWVLA0gAkLMMwBWhKRKDsWjGtAsmfrfQnduPYzg/f04YJzRe2fQkezxKwDPlJg5rtwPihXU0TX5dHZfDzETtSYKZSfRlMvk3RpVFHTZ6uInz6jPobMar8O92N7wQsMnufAakgjhLzccHEoqtvWWpwd1V9ZhOeEewnbHInbOfXDlOp4W03MfTYeIzDanDE19tI1+TaaThkqWg0O6+eTJVymc5pBx8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMxGzNOKH0Xnnx3aApJGvgsfuesjG8eeDQNqv4EeOoQ=;
 b=RKKl7YvtuHUyijpj8/uCnP0qutZFf8Bf6JLzRoz2Sc+rtPiapFWFno6scvpPQaieVxfvZq9nzxxOSUXrub7A2g6UcjIKbG56m3Pppf6CZGD0SoQoYOhwEgQS7xged0hDO3Q/9IuhpgCZdxlyhXFKSBcAE+y5RqTB3AYbM/gQ4MBNdwVUUYi8fpR/6MB9XOKJhGlj/f9kQyiIr2jaLnp39ljpwN6Ms3tOCK8mFDPCBSwVx4UFG0RfxdT2wo7ByFH45Adn6DWzjrWrMyqFaTO3gMemsLSsmaao6GLfjNzvfbqaXQwGhGZtcpcdT0OkH3S8NbobuDXe3v+8h6ikpkS8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMxGzNOKH0Xnnx3aApJGvgsfuesjG8eeDQNqv4EeOoQ=;
 b=0OQZBq2adPWKTKLAJmt2XtpdSfWz/WASxtdYAUMi9pjKc6RWhvNtm5MQMysRux39qwLjrZ4tyautYqZcgRgtw2QF8JeZzVdoMpRlE+/rlsGQ3nAmkeoRN+8aTY3AnDW/Ikd9RI+/3nH1yDIiiHaTqITk9uOoQ+VhN/yALIO2PXI=
Received: from BN8PR12CA0006.namprd12.prod.outlook.com (2603:10b6:408:60::19)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:27:12 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::e9) by BN8PR12CA0006.outlook.office365.com
 (2603:10b6:408:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.21 via Frontend Transport; Thu, 30 Mar 2023 19:27:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:27:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/9] drm/amdgpu: fix vm context register assignment in mmhub
 v1.8
Date: Thu, 30 Mar 2023 15:26:51 -0400
Message-ID: <20230330192657.1134433-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330192657.1134433-1-alexander.deucher@amd.com>
References: <20230330192657.1134433-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a4ae6a-e857-41da-0fba-08db3154c2b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUhLgzv8w66dk+GFnsSHKjhBrAee7rVLfDAQOZEPTWufSfova36DrIRbNGMyv1YUPiQx9VPm+AxmXNBIWvxFjM6g6gFJ6j4xXxUF7v5uMoaWVHnqpj/U/22lIH+TRMICv1gB6xUZr/N7TNT1W/WQJ9sw4U4w3M9mgI53Mj7bYnD9muWn/cwoZhV0fBSDOTxjraIskU/W6P3k6AGst7TeNp8HuyrbpM4DNT9lBEYk45cebUAyd2iYvq2Htl7uUB9mkqGjFCGIubYwmMzGH/Ao4xWYY/9qXABetIh2DAGt3x1IxSchiDZTDP9bLkzgRlGPmzMDsJxnWSR4Hb9xDSj6JZcUHjEIoaJ18jVslIVAwrw+mn6OOoqLlDVZFCsYIqIORciQ3x+2BKg/lPAdd8EPM+BjcpuC14CNZdLP9FjDpr4VHEKhEG8V23Y8Q6bVb4PiS9bXMYQYmmcagn0EA4toH69LrmZgphvEJhKYoqNVbfk5EyfwZDtefMS4ZFo4NFqFQul4FFyTJThs+/0urJkBzIjHPDZC2VQoxrYJ6zQ0fUbozwbAtnuaFFA0SayPcfeK0EApapNEeMHRAbYFoGkjf6MoXnsNSTHXTlA024lp/5C2Ja3onA/oBvBDOJ+TlyyxDpefbPzTMcs393jFtccQnkKzWF+K313m8OqV4YpAYLISOGZXmMHDSKTbfTyvzE1HHHNKubcnfqdWHOrj/38hushBYCweZUOTpMMFpJsi224=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(4326008)(186003)(16526019)(54906003)(26005)(6916009)(8676002)(41300700001)(1076003)(426003)(336012)(478600001)(5660300002)(2616005)(83380400001)(316002)(47076005)(7696005)(2906002)(82740400003)(36860700001)(70206006)(70586007)(356005)(81166007)(82310400005)(8936002)(6666004)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:27:11.6379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a4ae6a-e857-41da-0fba-08db3154c2b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Assign the vm context register addr per aid instance.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 67338cb3d7bc..6f469b9aa9a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -515,19 +515,19 @@ static void mmhub_v1_8_init(struct amdgpu_device *adev)
 	for (i = 0; i < adev->num_aid; i++) {
 		hub = &adev->vmhub[AMDGPU_MMHUB0(i)];
 
-		hub->ctx0_ptb_addr_lo32 = SOC15_REG_OFFSET(MMHUB, 0,
+		hub->ctx0_ptb_addr_lo32 = SOC15_REG_OFFSET(MMHUB, i,
 			regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32);
-		hub->ctx0_ptb_addr_hi32 = SOC15_REG_OFFSET(MMHUB, 0,
+		hub->ctx0_ptb_addr_hi32 = SOC15_REG_OFFSET(MMHUB, i,
 			regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
 		hub->vm_inv_eng0_req =
-			SOC15_REG_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_REQ);
+			SOC15_REG_OFFSET(MMHUB, i, regVM_INVALIDATE_ENG0_REQ);
 		hub->vm_inv_eng0_ack =
-			SOC15_REG_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_ACK);
+			SOC15_REG_OFFSET(MMHUB, i, regVM_INVALIDATE_ENG0_ACK);
 		hub->vm_context0_cntl =
-			SOC15_REG_OFFSET(MMHUB, 0, regVM_CONTEXT0_CNTL);
-		hub->vm_l2_pro_fault_status = SOC15_REG_OFFSET(MMHUB, 0,
+			SOC15_REG_OFFSET(MMHUB, i, regVM_CONTEXT0_CNTL);
+		hub->vm_l2_pro_fault_status = SOC15_REG_OFFSET(MMHUB, i,
 			regVM_L2_PROTECTION_FAULT_STATUS);
-		hub->vm_l2_pro_fault_cntl = SOC15_REG_OFFSET(MMHUB, 0,
+		hub->vm_l2_pro_fault_cntl = SOC15_REG_OFFSET(MMHUB, i,
 			regVM_L2_PROTECTION_FAULT_CNTL);
 
 		hub->ctx_distance = regVM_CONTEXT1_CNTL - regVM_CONTEXT0_CNTL;
-- 
2.39.2

