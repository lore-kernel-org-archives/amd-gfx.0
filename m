Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D41C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 22:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D4810ED71;
	Fri,  8 Jul 2022 22:09:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EA8C10ED6E
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 22:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvmNUQfW5tqGsn5M2asRsBCi9lMtpNEq1/ry8hUmzXrUKh+rJ9s1xzjdTmI0Izx+EkVJUXTVQEVyW5ZPFoliudnWXzp7YJHUiZfkekT0lycF5z6uw+aYqMq11ZZyNTqqCU2mdpHcee1euF13ENxAj06RoJG4XXJw6lftgASDvM7v2m2KGv15CXBtAKFp4++YOHS4yxc/1o2/lKSwHRWCkppR+OR6F5+oGfhqxcMEyLJNd6o/4I03LxptMMCXwdpnlFh88QcwoYqUxDNKvAha+d7j4PdkvBIaGL8JhhrZD8iCAKYaZppTvyy+H61aoQvV36zMJzX/WjmMr7Cm4+svbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6+pYCbxRmgeEsZdSNxh32Riw0YM4Y4mqY+ofZYhVN8=;
 b=fPo+gMDaMAFzBquCnvpTk+6u2m72b9TU3IbWLYBAzbvqJtqjvyZ8yZ+txi42ViK1wlqoRChtcl9rdpmDjBujpnD0lbNk931iRmiOTeouFeLPgoEOGsBFbViFicGxeMWgKfvtOyi9wtEdCEp3cpftaO4AQE2DVap3DPZZFpIJZEtzLuS3Uu6QMKN1XrZF9okIFccJlCidwaUnObo9tOkTpMsETxS0eUO6CbCZMvWzcCRtHPDOcpzLVSX9bWKGnC/S1m36AQExB/VTBbLt/SGO1ylS2JjLQwNl+YWKsOq5Du1X+3En0Ly5+HFiiMZ4KuuCeo9z31o30mGVzWH1UDQIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6+pYCbxRmgeEsZdSNxh32Riw0YM4Y4mqY+ofZYhVN8=;
 b=BB3GRs59WlymaGJk6F5fXSbYOGIOPHkL2JOPOLBQjm5O0GJnuA99CbAuY5zuVx9PbBFL61kEthoLrkyNA64WN2rDYzFkpWs2Tm/yYTSy5Myua5mrojoc6/AvEBCcm+eeLvJg7YNYTPDPwG+2EucQVjhdqPzJo4rdMMSGpJtm4kQ=
Received: from DM6PR05CA0063.namprd05.prod.outlook.com (2603:10b6:5:335::32)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 8 Jul
 2022 22:09:15 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::6f) by DM6PR05CA0063.outlook.office365.com
 (2603:10b6:5:335::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.7 via Frontend
 Transport; Fri, 8 Jul 2022 22:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 22:09:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 17:09:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/9] drm/amd/display: Add DMUB support for DCN314
Date: Fri, 8 Jul 2022 18:08:54 -0400
Message-ID: <20220708220855.1475213-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220708220855.1475213-1-alexander.deucher@amd.com>
References: <20220708220855.1475213-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e995b91-6106-426e-825d-08da612e7ebd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4121:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+/gM++wdWOdmyPIEqQsuvpZWrcwNYcCVmxFQcSB7Djq4Vns7KB3diyriPUcUN1kYHVdXaRYASF+9HmdHLWhcn6zUnQxqooRMJ/nWjHfEgnqGNCgOVyfdOYA8z9gOst5NQ2vuawXLN0XGHFOaB9U7eISR+KpEXWYgovEPkE8EKIk3xSja4u/36AFUPmr+G+UMQBIWupV1vSPTW0/mRIs38ZyWMmErShF2AmRiOo+kKLGKJzT7Xr0cgrSkDK46qLgCPZxj4gtwLev29eIqXndeMO38cUxLcfcX6wuzFCUZ4sXzeKyTFcY1XOOFrA3dUy0Dw1luBltQsudnJgoRnVwvFDpmhK/1qH+9ags9iotmmkSm8kN+8bbfSAK10FdfxpOJEvl3os5av0YuXjDi4HyqAZoRFT1hfzgYU1ywv7N+w7mk2qjmoLFiD92YW7n7MTCBYxhJASCD582aGoWbqwI1RDP0R2JTzT/cLnbc5lgmkhphbmaJSSOhMoxMQ1KD0ynoGLyklVL/zPapzGgEM3gQJDW0rUII2TSoLOKIYxRm1Db2I9DFjJOI63IHWNlyMp40/+1TF6Cwai0pwO71RusTkTh/EZhgiC/0JBO+aII6kAd9Ar79kwyomCfTeIso4lhvXWLgiY8FTFm9FQL69JL0H6AHGTgHZosAwzgNVaLZ4yw6qSEA/buKxQ/utlXXQJAtkidOf1afFvHTQ1Eq12JeEVtWT7P0e6ysprdWK18PwKJDElstEouw3ANhyc4Fiyt3SWm6ziEEPWd8wtx0s0l0E1dX4oSR37IPLhpDdXWvs0AGkMb99dUP4J0TbR8D+yXYrr0J0b7uFcyiokzCESt/2rybXckKl0DGPTx9Bl9JlPzg6fMWfCI7mEUZQCsUgLl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(2616005)(26005)(186003)(36756003)(82740400003)(478600001)(7696005)(2906002)(34020700004)(47076005)(316002)(1076003)(336012)(356005)(16526019)(8676002)(70206006)(41300700001)(4326008)(82310400005)(5660300002)(426003)(86362001)(4744005)(6916009)(54906003)(6666004)(36860700001)(70586007)(8936002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 22:09:14.8147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e995b91-6106-426e-825d-08da612e7ebd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Roman Li <roman.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

Initialize DMUB for DCN 3.1.4.
Use same funcs as DCN31.

Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 4c6a624f04a7..4a122925c3ae 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -223,6 +223,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 
 	case DMUB_ASIC_DCN31:
 	case DMUB_ASIC_DCN31B:
+	case DMUB_ASIC_DCN314:
 	case DMUB_ASIC_DCN315:
 	case DMUB_ASIC_DCN316:
 		if (asic == DMUB_ASIC_DCN315)
-- 
2.35.3

