Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1D6C07545
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 20:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5BAF10E70E;
	Wed, 25 Oct 2023 20:53:22 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8D7C10E70E
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 20:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUE3ldVYvNKyEUFr3iRsNDxsFtlAjq0WNwAg7wZ102WPESLokCp+tK7FvJx++RaNsX5X5cqcvIX+SzJZxEDVaV8ZjeiFqtDuf/GTPqrnoONX6JjOGwPjTJS87F7jvHQ/vAhoRKdMg4hTSw2PxU2cPxXjTavvx0B37/bwEtOHWF/HUolTgKaBl5Q0FtTs1yIsxCrKIgy89UZlUm2oHzqN7/AaJMFcm3jbfYe0ZBUWkVgfH8owVfalZddbyFoa8hj9ttysZLq9GLklObg5WQVO+9mQjsRYhiC7CfszN7AMOcxJu0mbf507/EeQ9QM1VRMouxyUoJ+5xCGvkbDJp0BBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDs+g8ZaWk869XVWBqk/WX0yJLUUoGF37V6O3HNGzgQ=;
 b=gU+etene6vByZDUQxPG4nQk9l98Fc1O5aOA6gwkmREWakareLwfVONwXydicreCLMV1Cx0MLqrH86Ej4U7booAD+sBG3cnOwvRrfx5FXjL4oYsUiS1xLutZIvBPrIGocBPbTZoLQd+bG87oqqPl0Rvkd/8MsZo0K4UqWPa7LR9lusKSPh/ee1ZuZXfqQ80/qcJhCh9XTOu6nohjsPGWwVCi2BElNmRsrUq4TUV2BT1qjFFRzhsp0IfySMR/EXlOFWkagT919ZS7CwKGuCw4mkKo1pM7RAzqGP/MF9LFE3keJoqD6Mh9aFEN3NO97comVJDM0MPEqB3rnc4rntZMQVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDs+g8ZaWk869XVWBqk/WX0yJLUUoGF37V6O3HNGzgQ=;
 b=iqx6k5PJvlSvQk8LUGhQrwmaXpy+R0XimDHxPb9lbID94ZVudeV6zpOmYEUMlwz6lVtDhQpKkGJ9qLv1t/L9I6dhyep0cEBVm0qclV8puJr3DJ7Bg/suwsjLAnDlNrPgHXwOWeVddZ1KqAP+1pe2BWdZaQai00U7D8+sFNDgVrY=
Received: from CH5PR02CA0011.namprd02.prod.outlook.com (2603:10b6:610:1ed::28)
 by MW4PR12MB6684.namprd12.prod.outlook.com (2603:10b6:303:1ee::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 20:53:19 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::ab) by CH5PR02CA0011.outlook.office365.com
 (2603:10b6:610:1ed::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 20:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Wed, 25 Oct 2023 20:53:18 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 15:53:17 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: Add flag to enable indirect RLCG access for
 gfx v9.4.3
Date: Wed, 25 Oct 2023 16:52:38 -0400
Message-ID: <20231025205242.40490-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f68e701c-518d-9782-7da6-2f62f4aaa368@amd.com>
References: <f68e701c-518d-9782-7da6-2f62f4aaa368@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MW4PR12MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a04c37d-9f2f-42c9-27b1-08dbd59c6ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 91gHcsSINyXXZ4El5EN8raIvLaFKj6QhgH1FzDCKN24rMpkNT6FK1+UgjszYC5SRHyp5ZEPIeiYA0uopsX4IN6RchZW0xjJGyQAX0QlzIyi3nMh8mYOJ8ZCz+9/pzw8scWMIYAr09UL8khCc+0t4mFE12RZR7wx+DqZ0OAJwS5k4+ur24Jrl3sWxXNYSMjul4QQLrlpPoDy6pFOZ/qJgH8o/JE4sb8xSAHOBmUTd4hC7JxMrhVYu9rIY67lSsOQuvruwTkeRhmOm2TLGfOqnWb5YNK3//FsJL15IU+i8syLuKHvEesgO71732swGau05cCJ2Zo0k1gVtKyepGsFSMxNVPa06PztU/8M+6W1OXc6H8mST1nqPevr/Uf0OZGqBiustvF88e2T5E1Tx+KxKV5Qk23aL6qY1uwS/1SXbAv0lgZUh7p9IdABNFHDplzaRMOWBtvn3Hwe4WPg0YlRx1+SN0n3tCoEWBHX5xFS0HET5e7zbki91lCr+2FeZ/EhW5fn4a0tpNnNCrGsAQwpFN31Kx027WR1tGIUsZmlwcfhyp9pNCZd3pW/LWfcXvNKzEMlmIRWhwLioEvSw2bujlrhNjclXIM0VU+1PuuQod/Mqt2JLBKF7ywwCIhGfNFV3+OU6yHSGvrQduullaFKLSbiIcuPkcx+oIijkJluMzVGcIWq44ot61gO4D3NVwu8K4XkzqsOvlQshr/DxDS3sZY7q2dKCX775kux+KvlMQ5GpslaYwEVDMEntwmudv9qekayss8CRntvNsZhfYaaSRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(356005)(81166007)(82740400003)(7696005)(336012)(2616005)(426003)(26005)(1076003)(16526019)(6916009)(70586007)(83380400001)(316002)(54906003)(70206006)(41300700001)(8676002)(4326008)(8936002)(478600001)(6666004)(36860700001)(47076005)(4744005)(5660300002)(2906002)(86362001)(40460700003)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 20:53:18.7031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a04c37d-9f2f-42c9-27b1-08dbd59c6ae1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684
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
Cc: lijo.lazar@amd.com, davis.ming@amd.com,
 Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The "rlcg_reg_access_supported" flag is missing. Add it back in.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 41bbabd9ad4d..386804f2e95c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1102,6 +1102,7 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 		reg_access_ctrl->grbm_idx = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regGRBM_GFX_INDEX);
 		reg_access_ctrl->spare_int = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPARE_INT);
 	}
+	adev->gfx.rlc.rlcg_reg_access_supported = true;
 }
 
 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
-- 
2.34.1

