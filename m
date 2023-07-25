Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DCCC001DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 13:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED1410E3D0;
	Tue, 25 Jul 2023 13:49:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 475CA10E3D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 13:49:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTHiCrJkgeMOAyELUS8ea4qQ6TS9pNuWfh+gyQDhAXBdpWCvd99MZONwnN7HROJzZBCDM9x4dY30Uhu2AeYHN//4bSMuyMaTVwrAlhszNoJSBLM0SFti7sE8Qgv6ulKVBFJnWrGcVdHVnq1y/Z2kA57DG9y+CuQGeFz8RJrFwggHyB/g6Ji3ip65gV1IyPsLGPjISEMD7UF21gsAOvtctXOB5FYM84EiaTLYborOA0FJlpZN9Knorua8Ss4uRCpAqw8e6i3X9p+JZtqgufVMZ+BiyEKxibSsTb7JkcTrWkKyMLkiuq6Mi2yS4uQa6Bf2BJe6zFm2Q5m7h/G2Y/GMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqM2p5ejXXhTsnS8sKEYy07/uNtsnYM4KihdICVgFow=;
 b=JqLwLR5cBKu+dSHaDo+vCV9JYQjut4j188iLbcsQt1nhDWeS2o3hm9cQ0VtzOD4+iq374Z7Dxf1nKN/8HvoGnczYnbiNQG89bNBE91Elp0worOE88oi7CyYmKg+ZpaNjs4fjF7pI4ibugHsOc4Hx5pj+b0Ny1M45K745PKwX/ZYBnjJhdmLDS7jjbX0gbmI4oHdGbuoXwMSdNt8atE44fTmDUAG5P/kGYVXIx2Pzcm/aqAZuZaV4DPrlXaeSRURDrtbdJpvxUYByPzATUT3k2AaDLgQb5IC6ZBGGn1EN8h7gjeIOXXaquA4PsTTP14SNzMEyOBnE1pReRDMYNL3hKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqM2p5ejXXhTsnS8sKEYy07/uNtsnYM4KihdICVgFow=;
 b=b0nOpFofO3MGoYOpDstOOi+efNACIsG3cUTapm5K93tVIdT7stSt2sEPkjDl8NQOWqvMM8HJbVCQNHcjR6ly/79SYLwfww4mZK3U6ot5CBNpB2lTAeSxo4mMX+vB+hMSqYaKT7T9p8BWGo5ODb3pMOWjCjiwGt+w+wwElsBWvUQ=
Received: from MW2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:907::41) by
 DM4PR12MB7552.namprd12.prod.outlook.com (2603:10b6:8:10c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Tue, 25 Jul 2023 13:49:08 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::b0) by MW2PR16CA0028.outlook.office365.com
 (2603:10b6:907::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 13:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 13:49:06 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 08:49:04 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Match against exact bootloader status
Date: Tue, 25 Jul 2023 19:18:50 +0530
Message-ID: <20230725134850.3197790-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|DM4PR12MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d88c1b0-b56f-453f-3942-08db8d15ea42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KqtQU0s2UlrXNgtBF1dusZnoW/SIevzM5m5QeVleT45DceMUCqzYOdNNfPpLah9wMghXdZS6gVPP3NgzbIw80IoA2AZMLg2IaKhAQyVOjfNukglDl66O4z4/B3SU87yuifEgg3ohUNB1boPt88+ix/3AD1iHHZSTfaMa37msTlnbSjuDq2nUKwi7d8A5nXxzKL8ngCajTag+XTQTDVCqKF26CuLbbTml12Td4gSVmlbVXHVSbTRqkyQRoTheLmQQJxfzU5CrrzpNEsW3LsPhnQPa7JIl1CI2qPHLb64mkMsSpWScf7kb5ry/Yqhr58Lt0WFPLTYneLr2Y82XOa3ERoBvfXHSWn5kCC3xz8V638p7/ue86XQnW3cgBWNLBackO76yYCx7vYDFKuWHZNt0H8pWxXc2O2t68v+wY5ETcBHSe8BkX+f6zb+ZN7d/4NMFpq8rqWUvIkYv1MQbSyI5OD9B0lJlAcyCDCJKAC4kGrHwyWzDCQ2DXZgRA9MWjGTM/lY4dpBIjWhcnyy3AZ6O367tiqAk1JO/au/a7Yz/gAMM2BIEFZYzqZgHf/uYX3TkW29NAJs25AlpG8Vq1bQM+YQOQtp9JFaKdtLN5aU13S+TWnKbhnyT9kiqSm+Tli1+tc1cpJJ1pd9Jlpi5Vr5KQ/Cf+C7HWr3FkbFcpzXNF4mZrKnaZNQbW8/y6GNwHys+l8RUtPRD8mRXN8eBfsddk8VgXdp+PaXBaek51LTriV5ro+XGLBP/slRlqFrC264gE6I9o8bjRIn3LHTJG087w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(2906002)(2616005)(426003)(40480700001)(40460700003)(83380400001)(47076005)(36860700001)(6916009)(4326008)(7696005)(316002)(36756003)(70206006)(70586007)(41300700001)(478600001)(86362001)(6666004)(54906003)(82740400003)(44832011)(81166007)(16526019)(356005)(186003)(336012)(1076003)(26005)(8936002)(5660300002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 13:49:06.5689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d88c1b0-b56f-453f-3942-08db8d15ea42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7552
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On PSP v13.x ASICs, boot loader will set only the MSB to 1 and clear the
least significant bits for any command submission. Hence match against
the exact register value, otherwise a register value of all 0xFFs also
could falsely indicate that boot loader is ready. Also, from PSP v13.0.6
and newer, bits[7:0] will be used to indicate command error status.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index e1a392bcea70..af5685f4cb34 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -137,14 +137,15 @@ static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
 	int ret;
 	int retry_loop;
 
+	/* Wait for bootloader to signify that it is ready having bit 31 of
+	 * C2PMSG_35 set to 1. All other bits are expected to be cleared.
+	 * If there is an error in processing command, bits[7:0] will be set.
+	 * This is applicable for PSP v13.0.6 and newer.
+	 */
 	for (retry_loop = 0; retry_loop < 10; retry_loop++) {
-		/* Wait for bootloader to signify that is
-		    ready having bit 31 of C2PMSG_35 set to 1 */
-		ret = psp_wait_for(psp,
-				   SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
-				   0x80000000,
-				   0x80000000,
-				   false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
+			0x80000000, 0xffffffff, false);
 
 		if (ret == 0)
 			return 0;
-- 
2.25.1

