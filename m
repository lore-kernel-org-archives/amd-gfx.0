Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81F1C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 14:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2000612B03B;
	Mon, 20 Dec 2021 14:34:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C711D12B03A
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 14:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOpWzjmTlEvJ3QYWouZtoREdZn/zOpb72vZVLcyZMm7hXYID7Cko8z3zLLczwaYbgcZLEhvPpZynSAGnkIOIJmelDeKGyE/L/HNSDIWYS8uzycrC9zZwjMNxJAs/egPf1zoIq8La51F6jmEphVwzVHlXasu8CF2Bd7etKARMqtX4reifgV+eRRfgUW2KR/pbIWIVeHlwrnylyTfSn60InIgvMsrLatWjfaCx/p4hWYiW/NrhkvpKi01aw0UyLpIrxfkaypxz/eUCGVU4m7/0HWM3mcBzHKt00BcQ6Fw2GadEeairz5At7rO8JIOc+9WBWMDd6P6IfLiGa5fACmb08g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvowWoRn59oq/6QU2X/ltCVFH9TeV0lZ4AfKhNrOC+k=;
 b=AJjOdfuzkRVIcpOIMR4xyUECUX56Ukk3YzZJwWDG+VPnrCaBgokgxTOWCi0KqRxGJX8pzOCOPynHeN+RblCA739hTH2eaAcSsQgg1KSUrEiFvLywA1tMMMp9LvN6Mh2V+dJYKUN0BCBHDlniijIuil6Rf2G02/AO2Hc3muBcbJ6epZ3fqxbb4OEGHofliISTkKhEMk9tf1v68yVoMpDiInS+ivoraBMgVT3msU0Yz7LH0eMGQ1ieshMhDVon+YQ1nsWtVL432KeSQa2C+YjpDPPaWyb56RIzEWHNEiJOCvM+B36H/dqaJeCdHyyEAAQTMAjnYdzOytaRWhbXG1B66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvowWoRn59oq/6QU2X/ltCVFH9TeV0lZ4AfKhNrOC+k=;
 b=dXTY9zwXMF0pjqzqwLiJSUArqCESAuVsV8CrfLkSLaJvEUTQawxW+JbC6a2BoEtaOYW1Qvxks1MyzhcA3kR25kZinxtMM2rLXsfIG3rlpHcwhAvTu/nB/CyjGVDAMGAfRuo/y15EugMNWFZ/LTiHTGyl3Y9Os5eQdyjwEzBtpjo=
Received: from DM6PR08CA0038.namprd08.prod.outlook.com (2603:10b6:5:1e0::12)
 by BY5PR12MB4935.namprd12.prod.outlook.com (2603:10b6:a03:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.16; Mon, 20 Dec
 2021 14:34:40 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::56) by DM6PR08CA0038.outlook.office365.com
 (2603:10b6:5:1e0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17 via Frontend
 Transport; Mon, 20 Dec 2021 14:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Mon, 20 Dec 2021 14:34:40 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Dec 2021 08:34:38 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: drop redundant semicolon
Date: Mon, 20 Dec 2021 22:33:40 +0800
Message-ID: <20211220143340.8702-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 154acdd9-6452-427d-6aad-08d9c3c5db68
X-MS-TrafficTypeDiagnostic: BY5PR12MB4935:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB49357CC0B258B220249AC82EF17B9@BY5PR12MB4935.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbPeZ1FAbiNYZaWj22BREDkBDCpwD7B9PMoBs7nkVUsyxsZPaZMOBmJY2bWlCmK/EDkZ3yYuMtaBMSAyOCR6SZtuh+01pLLx7HTr/vF3eBg82e8Sx9bW6tkmhqlSUU7v2t6gPPW/cK137EApI7L4STaTz38fmgBHm3ufVGFabl757VzX10TgMPUR/puoVGrl/vGGg1ZmSaAIW0rwv+Cp6FOpjp9p454VElYxag978Eb68pf8xQm3uBE7Z89pliY4bdK9e9EYt1pcAa9WROmjCEJ1WCtG+yBK3uHSObPbrWmP56cDXkpIUFXaZaMYCpIr//4wGK3wC99R7CJTEmi4lGlPjTNYLhIJiBNeZTSCpRC0beVvsV7G+PWeHWdE/u+oJuwkV8uWl1TqbeS52n7wmjGB+w1Uhz663hWSF/dBv5kvSXciv2EivOJ5Dg2Nr5dPEDDQtnKJ5tYjrc1v0/qsNWmk0nE5VTqj3wMjDvfMiDLlVrw1c48iwlzub4waTKXLwHD0YWIB1XlKJsoS+DCX5+Xwtpc/szl3rr59sIDpaPoTIHsq8pRIq/ISvCUXsw6xPqtFWFh6KSMMZlj5bTkerXhKnmWKWacIz2hH/UztP8SE8asugw0wy0LQZcAFkE+gHHBUo7XXwzWIPe7Fhta03NKAiYHyMfyGSqi6io3RCGbhQzUcdI92KsQJR9unqMgOCPjTsSYpadiTbq46e+fzV6xgD2qOTaiuwM8wcK9nkS+CaXpDuMc4i18hJTrZ9+wQARUHHaX0IKYDbdKjir/kCpiS4vqVRGho2UjYep8HqHi7wxUzA3eSRTu8WT/q63Qz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(316002)(6666004)(508600001)(110136005)(26005)(40460700001)(7696005)(44832011)(2616005)(336012)(70586007)(426003)(8676002)(2906002)(1076003)(36860700001)(70206006)(356005)(36756003)(81166007)(82310400004)(86362001)(8936002)(186003)(4744005)(47076005)(6636002)(4326008)(5660300002)(16526019)(83380400001)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 14:34:40.5881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 154acdd9-6452-427d-6aad-08d9c3c5db68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4935
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A minor typo.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b13db855cc9a..580a5b387122 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1023,7 +1023,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
 		break;
 	default:
-		break;;
+		break;
 	}
 	return 0;
 }
-- 
2.17.1

