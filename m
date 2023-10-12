Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5711CDB47E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 05:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7BB110E0C4;
	Thu, 12 Oct 2023 05:52:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B739F10E0C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 05:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9++oYVr0RbfDa21akkN4X3itxE1GxEeoqehKwRiZ9kxKmgKGAqapByn88PXiPpw1zmdkzPOc8kJcGfS/DvJN9s+S4CzGJ8xzSvsphHm2O8nFvXLEVod39Fx/yojKEkDuKO7m3Oy0vyY21GwSnSLHiOcEX7ycWbD/9ViA62h/5dyZfyiZBaRF9c8+6IMYaL1wU7W0+SEv7Il5I3aBuAyJn4pjieJIU7OZYmNrX1sSQGir+RVctqfx6dp3/Mc9ITE71Z+HBMzEw1CSG4z6zHg82upeoCrebm6yDMY44u6ViFpFA8ZZlyut7YCAER6zVa8MVgBWHUn9Pft1ODaUtSjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsOguSa4mEf0/+/vhuheaUpO2lRaXzwiV6DjNipomgM=;
 b=bdh5afvMOjK4kUkdXHEXTpPuJNXBrmZoxjblcyqNfKwgyiRVAiaHJf5xRuadSmlwzzrbjs6cjG3jtvaqGe9ygXOLpBcJMFgjiPd0x0YJ1Iz95fPyxGyIJmu8uuaKLsEISKgwsQDryMSETG1BMfQRr++BGxOYPtyltA0VcQu1uSbuZnJGKodpPyukFuBBl/QooZxdLMX4NJUtKnc/F0K1QwdkmERfwdMOKFmtRywfTiu22oBAIgH3rhbK5FBM6adbWvV3vk6j1tv9AvMrbFNkYwBrznMG++RViCj8mxc/A/h+kaLXBGZFzaXD3llVc4cpOZwe2KHDayU7qGoVe5MQmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsOguSa4mEf0/+/vhuheaUpO2lRaXzwiV6DjNipomgM=;
 b=nlgv1efW0r9lw8DxrSJQ2SoCSKZJk5a+N4InLEyZpSGbYEOgWXGziH85yaHDHPX7QPuhIM0zgyYkrkTxIC/eSROhIJMzdD/zM/MkVhcNlWKblI+tySBP5XS2ekfC6LJ7I9hh2JMD0utGCPxhS2baUbsh16u5B2Bi3N2EsQqLEjQ=
Received: from CH0PR07CA0016.namprd07.prod.outlook.com (2603:10b6:610:32::21)
 by IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Thu, 12 Oct
 2023 05:52:02 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::4a) by CH0PR07CA0016.outlook.office365.com
 (2603:10b6:610:32::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Thu, 12 Oct 2023 05:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 05:52:01 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 00:51:55 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Restrict PSP OS version read to PF
Date: Thu, 12 Oct 2023 11:21:24 +0530
Message-ID: <20231012055124.112725-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e17bd0e-0a78-46c5-c3ca-08dbcae75ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dY3fVDM+6NOe/AxvN9P1oHHciraWYYwQX+r/CqGsjc4rmFRQ8/jLVqMG2XpBTA8rhb9eKsxNR4Cucknisf99biUNY/t0ymVD9owuzh2dW5vfWR08bov4Dsm+XDkH/cZiCm5YH0Ii76euULqSJPkfTLuqL3QXO4gFA8CEbpzKsVhSBcKOyikBRVG35uHOYnNUuxbQr8ImKDFbFwgvHDxEG4CXWielfU6+KfFJJPuUkacFls/Tk7Wk4Vh9UEzySN7zsgwOEzQC7K0ubdbKseaur5euRjvA9t19IW/lSHuLygaxn+04uKaPjQP/5+V5api0EMm62xfDw+FU1+9QosyE0BFyPufrlo3jvyKXeIvZHLbXwK75Opp9cZL17YWA1BBVBBCJA91mkCARzmoESw1PwJIfAT0pRNmVE9qeKqGW19dDnhFW+9GT+gi9rKhuC7HSKUMH9RdVNA3pSkIdjKYy/pD1WV37TpgFw6K4dDbqGEEK7azLF3ilLU93KjQQJczo0dg58dTSY3j38D9QbF24KDAKpnZw/hxwmozm94/XciCmxf0sy4viMjJDpi19NAUfnCeGCrfpbSg0a3nZTGKSXIlvy0RCCfU/+knN8iqVTQQCV329Ig+oMrJK2son2KgUXN8vq0en6qppdPdKyD90ztnH2bPt6CBT5Vy8sjsCe+zBSUxu3EwR1xXPRGbT0nE9LwHih/6mPz1bIIWgL/XliW0CDiBhddh6nrr16gml3yMzTkvnXdxahhT5qcIsNrA3MYQlKHqK2LAuT3GRuxSFqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(1800799009)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(40460700003)(82740400003)(5660300002)(356005)(41300700001)(81166007)(44832011)(8676002)(4326008)(8936002)(86362001)(4744005)(2906002)(40480700001)(36860700001)(2616005)(16526019)(478600001)(1076003)(426003)(336012)(47076005)(6666004)(7696005)(36756003)(26005)(6916009)(316002)(70586007)(70206006)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 05:52:01.3408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e17bd0e-0a78-46c5-c3ca-08dbcae75ae3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424
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

Only physical function can read PSP OS version register on PSP v13.x
SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 1997260a8156..96ea64e1bf37 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -280,6 +280,9 @@ static inline void psp_v13_0_init_sos_version(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	psp->sos.fw_version = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_58);
 }
 
-- 
2.25.1

