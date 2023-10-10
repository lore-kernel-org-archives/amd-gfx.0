Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7743BCD68ED
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 06:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5E6810E31D;
	Tue, 10 Oct 2023 06:27:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2898210E319
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 06:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWHHh3PaLdGs0yewXkEGsoSN2C0aXGufcTgFoFS1cfc4xJDtWHDFOKIRmxDgDG3Qlt60uSXVzYzo822niOYJhAAk4lrlWFcsmN1F+CEE9w4PLnAPPB28iR39PFlNG4KoAeGkkzz9dzOEeMZVntKwdfW2AinsYM4x6RT5BXWZg1NdcDksOif1gAzZoSAj8XFC1KXLiODX5yWWypzA6O8AfSfo7I2aI1BOnU7rPTFiRhoz5KEzuUML8JcsmMATEP3r7TzMRmv4oVWQB3xV0/+cHOvdiOq4+G2lD5J9BAjulbf++vy3jz9IskyHq6ck3ovPL84+vpajKdyqDRu6+ZT90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I75ENa64aXhjrllhpzG8Vrykg131JqC2j4QMeGU6iTU=;
 b=FP39U5X4yjLUywVlzS6jMZXmbUSCgznUQ6C2uyqg9hP/eGAU+h92dLBIx4WDp1Y43RX+milQBqmLZHzoWzyWyyvBxRZMQe2LLpPjcH9TxoJYA+0+f2rARGaLcZZXIN7Vi1uFPcLZ5Hed3+P+ULlaPH9Be6Ju1awVTKWTcZ25tXhesfDiCll3R3xfpOWy+FkQD17dT6ojRKf4CNMYc41bmJTuohcRujxQiHbLsE0KrWmzOC5IUFhQgw8wwxzHwq9N+nG1DLs47N4s5mzjur+o9P8eJyWXGGtcvab1/UGM6cp1I5yA8rbNZxUAORvWwa8iqlzfh+JdFhBBPpCaH8Clgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I75ENa64aXhjrllhpzG8Vrykg131JqC2j4QMeGU6iTU=;
 b=F58ZxqOobZhrf1lbQvU4qv0FMdR307PLtTIAKkKEFnVDEj0O56mrWMQM+BtKMMUGbqvVsBee/Nt8xF2jBktrb9awdWG4a4Zm8v1e1PBTyuzG8L+Xg6pp+dNkueLL/4gxZx85UrCmghENDqcfJMz+Zezxt+J4DlR2SjKxM0dyrS4=
Received: from PH8PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:2cd::18)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Tue, 10 Oct
 2023 06:27:51 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::b2) by PH8PR07CA0019.outlook.office365.com
 (2603:10b6:510:2cd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 06:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 06:27:51 +0000
Received: from primary-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 01:27:49 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: save VCN instances init info before jpeg init
Date: Tue, 10 Oct 2023 14:27:34 +0800
Message-ID: <20231010062734.40143-1-lincao12@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: f098371b-e3e0-4266-800a-08dbc95a0769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQ34MxlKWL/CDVsLuSDhvGIoc7mvS8SnrcRZLx7LUqz4A9wm2+gx39oVdOE22Q34JwPZgm6j25mnchHVdFDjD0WLToFv/Et1wf6Y1U6iW1vw4Ep6QqXLCdZYvrapRmzedHqNKh0/q6szv9MFpmSsbhKYj1U/PmXCgjV5xRWRzsQhmQE0pRECLZQ1SEUxw0dkNzLkcmLWg0WUN5qIcg3+tPfFYUGFvjVODsIwgblaZQgtp4CEVvSHESdgw09agpFAiLRpS1tfRstjDCoQszcdmIq2lqOpaOWuMJXJN0CdExvPn/ppox6hlp9nLqJtPuk4ChNffzqcbrA4yTkS4fgM3rlL0rmHKEPB1jUd07JbmlX0JAlCB0d1Sd2hmoNvaeRF9VaI7drEqok8qMYZYFmtyE/io0NkG3/jHof10X6u5xSMW+qzNJIUbHhgqgk5V/yd7DkAEywbbAbJTi2CkCvQXGbI9QIyd7Qwsx3RfJRkzJu8m1l6A7moET/CeWNinOtXXPErhCDW2IKiZH43OE0dERQfPzISOVdGz5jT5Bo5csEQfzHSN3tbxjsHHg48e8JH7xRO3z1WQ147Ch35rhFQ1fDvXPVDWms1XBjzHMtyyDWT4VgvldmgO4WwsTzOxn5iklZ1us/MLNKgctb4BNwunwiH6/Gb48YVsrYPK+j6EqF474Iv12welktRIvh+Fxq2jY8583PKxB7hrPLqD/+30k6/G3CKjToLsmmBUbrGj7In73adXHAS16sOfn4twoSeVvjfsaNcN4umY+nYokxGVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(4744005)(336012)(426003)(2616005)(16526019)(26005)(1076003)(36860700001)(36756003)(6666004)(7696005)(478600001)(356005)(40480700001)(47076005)(81166007)(82740400003)(316002)(6916009)(70206006)(54906003)(70586007)(8936002)(5660300002)(4326008)(8676002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 06:27:51.1182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f098371b-e3e0-4266-800a-08dbc95a0769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710
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
Cc: jingwen.chen2@amd.com, lincao12@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

JPEG init header will overwirte vcn init header info which will
loss some debug information

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index a3768aefb6b6..bc38b90f8cf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -431,6 +431,10 @@ static int jpeg_v4_0_start_sriov(struct amdgpu_device *adev)
 	end.cmd_header.command_type =
 		MMSCH_COMMAND__END;
 
+	size = sizeof(struct mmsch_v4_0_init_header);
+	table_loc = (uint32_t *)table->cpu_addr;
+	memcpy(&header, (void *)table_loc, size);
+
 	header.version = MMSCH_VERSION;
 	header.total_size = RREG32_SOC15(VCN, 0, regMMSCH_VF_CTX_SIZE);
 
-- 
2.25.1

