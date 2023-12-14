Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43A8C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 18:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A1410E1C3;
	Thu, 14 Dec 2023 18:16:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F4710E1CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 18:16:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzUSvoq61zpA3TrLPxTyPMguhN0RjGc75HhQcKm8QpFEDBKW+xP/bRfDkZ3GAz1PsF+P31Idjzp7Aic18bdMY9dZwkReURKqVMSMzvtrPa3wQ+sMqy7GXMLaMAFMqbPKN1mzD9TsOYWaYdvJhwiZ601G1F3nWP29dfWIZRhhbkXC4QGVbcj6Tmj0/tHMffvwRDwjdhf41yB0dogpxNWsYLWp0Xd8T6D6gOwUEX5NqFJzYRO8/8pSnwnTeK5unYfP1EhHWqZyn+BUFfnUiuGC6h5SVflDB49Zm52BT3sa4VPyBaR/X7gOKCxnOFYjo767Nv3Q0LUsee6Di17iIle3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VgQcdRO5ABGuAWklLUU7gJFv0MC7Xn/kPPWb8Sn9Ro=;
 b=fuUP51dSv9AOZXqOVS2XNuaJSqcINeHXwGk6ajN1SrS+zzFBcUp6QUHEY5+4KKXbpcTSnuKZ2OozU34P1vgIzofVrqzuJHwdmn+bkfoSfaSTjkOlTaPbITalz0Y8TyieDxYYHm2C/flZWcEUvx6Z4z1YHLHDFNN4aokwGBOmEqbZRYPOYfdevn3h0Y390oSyio0CvzcIr8TZWJcN/RQEacxXjPDQ1bh17Fhd8qyVEZqGyejj/k2I38sV+K5LcbIvhvqWePNPwxvZF7yWxrQ50fVbS8xAHTckuEA4+x5ej4jz0rQi73SlBk0Kz8yUQh9zbWcagYJBHTuWi19aUUOK8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VgQcdRO5ABGuAWklLUU7gJFv0MC7Xn/kPPWb8Sn9Ro=;
 b=S8fhC/AuzxWzF/qUS//9nS5nSHwFlOf6ZVsPRjT+cFH042/JuxOk8tFUXPlNcC2TfapE+urmroIrMvZDUzpItSVcaI3Mt4CpTUcy42HzTXmKpNnFO9QFoqgg9cmd18520SnHKUv4NwMCYN7HgoDRwro+YPHd+Ey3mBGnY2acA+k=
Received: from DS7PR03CA0094.namprd03.prod.outlook.com (2603:10b6:5:3b7::9) by
 DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.28; Thu, 14 Dec 2023 18:16:13 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::a4) by DS7PR03CA0094.outlook.office365.com
 (2603:10b6:5:3b7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Thu, 14 Dec 2023 18:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 18:16:13 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 12:16:13 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Make SW CTF handler cope with different
 read_sensor() results
Date: Thu, 14 Dec 2023 10:45:47 -0600
Message-ID: <20231214164547.6739-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|DM4PR12MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: 79cdcf54-9126-4335-9441-08dbfcd0c1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v9M8nqkV4qH/QWvK3gBBpwfWzALwdque8qU/BPSgn9y0ODjMFAcew6BnXTTSOaP9qpmC7khk5/wSlqJxB/nl+IWLXNucvZcYtxfE1Ge154RYWdYIuv3+Fd8bMonW8QbU+ve6go6tltYPbzHc19hsJ4o4udJ2cHZhh3y4BepfGngB8Ze6LZ6BIMs19aDTc71nGQlPFXbv2sZggN16a6RO1Rn9y6LustEx1lh28sEJdL9aXs+nJzUemqf/fpS0sNGgLN/NxI34X5gfnQ2UDHXr4Dy1WJp6d25tyYIVUhxPaLHuOc1P3Toh8A5tR5hII0Jrcfh2gCoZJyxvPhVTrA7NZbjnYZl+8X/6X0hRkmZDlTReJgzkQ7yF2BSW7bzaEpbYxKxsoQtedhCLI6W/nFr8u6JY14QFPm5LLtRIR4nT8fI/1PNSAYrdQWJmpskHGNd0PvprtNtdp3HOIX0fvjsAJiRyzHj2yI7wMitlPzBOsx4/0HOz5cJ/hL7k1J4gWNs4okOEJ16YjHOmbyjHrO6pzZNi0WyJe4FYx6ygJESHaPy8CYtyuBiIHvZhfxIAB73eKsLjUkjUP/P3opJmwkW9PymZi8pGraQyzOCj75XQgfXdfewJO9tl3x7Rx5JuVEofOgqJ8Kd7wjhmW4aWi017GURpcTIC70LYhWT7wpIIUGH5+GI/RzxWfo3oGkWmDaYjBRcn6D0rEL/dnPXc79OKlMItzZ4o5AJqoSMHfBnx3gLE3Mvyy3OfiaNLS3CrQ+us+QFJXpcLqAjGi9NKpf2wa0WjHokGMy/WvmdZjE44v7gKd+kOi22yVlj/5JlnivmM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(44832011)(6916009)(8936002)(16526019)(316002)(8676002)(4326008)(70586007)(83380400001)(336012)(426003)(47076005)(7696005)(6666004)(478600001)(2616005)(26005)(70206006)(5660300002)(2906002)(41300700001)(1076003)(36756003)(81166007)(356005)(36860700001)(82740400003)(86362001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 18:16:13.7869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cdcf54-9126-4335-9441-08dbfcd0c1d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5213
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The SW CTF handler assumes that the read_sensor() call always succeeds
and has updated `hotspot_tmp`, but this may not be guaranteed.

For example some of the read_sensor() callbacks will return 0 when a RAS
interrupt is triggered in which case `hotspot_tmp` won't be updated.

Adjust the logic to catch this circumstance and output a warning.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e1a5ee911dbb..5473fda5c6aa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1163,21 +1163,23 @@ static void smu_swctf_delayed_work_handler(struct work_struct *work)
 	struct smu_temperature_range *range =
 				&smu->thermal_range;
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t hotspot_tmp, size;
+	uint32_t hotspot_tmp = 0, size;
 
 	/*
 	 * If the hotspot temperature is confirmed as below SW CTF setting point
 	 * after the delay enforced, nothing will be done.
 	 * Otherwise, a graceful shutdown will be performed to prevent further damage.
 	 */
-	if (range->software_shutdown_temp &&
-	    smu->ppt_funcs->read_sensor &&
-	    !smu->ppt_funcs->read_sensor(smu,
-					 AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
-					 &hotspot_tmp,
-					 &size) &&
-	    hotspot_tmp / 1000 < range->software_shutdown_temp)
-		return;
+	if (range->software_shutdown_temp && smu->ppt_funcs->read_sensor) {
+		int r = smu->ppt_funcs->read_sensor(smu,
+						    AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
+						    &hotspot_tmp,
+						    &size);
+		if (!r && hotspot_tmp &&
+		    (hotspot_tmp / 1000 < range->software_shutdown_temp))
+			return;
+		dev_warn(adev->dev, "Failed to read hotspot temperature: %d\n", r);
+	}
 
 	dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
 	dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
-- 
2.34.1

