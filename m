Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1ACC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 14:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A4BE10EA0D;
	Fri,  3 Nov 2023 14:57:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCB9110EA0A
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 14:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ayg4KyDGHO2/8LFRJP9Xp5mnTYvmvfMQsdSJx5OZhTORtayOVPvNRebmTv3mQ0cj+CYvbXnLik3IpMizaFXC9w5lTrQbBA0l24tQAYvDFqVjHa/Q35ALw5F1J7M6S+HLY0M29ORTRvghjw7l0VFeTiY8deOnaLcN5r9X5atkERlXDuD8KOwxhz+b4gFtdODd3ckEsTfFAgDCpsMl0+ybb1qGcZhIyc2Yinu9jqvAqbWrT2cC6DxYcjPIkwL8YL6S40IHAxtqCI5+InJQMAcE+4hprPtp2czWSLQ0GAtU0hBpQ23Z1DANvl8SJGMdBTl3JmEEKBdvfG8w1ZPK0OhPvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wncTctsx1aE0FQBp5Wqz+nAzKarTBXzW5kiqwa0eK4Y=;
 b=TOrjeXSeZ3bRH6G1RxaMmauADG/TnxysTA73UzhHaDZMnDF6mzvYdnvh32SP3dzNifds8+wkh6rJZX+vtx3LMCtAgVaZxMq84xYeaNOo+l59rJ+6afTIV2q1o40Wyogrf8gRosVyBsBW9P/Af3XQoh6Ps0ZeC71j322VXrPWWD3fQd2YWCuwhdcmOowpcsNpY0xVVVmwRgWV0RLpHC/OItm8OeFsNsn9odXIXgvzPESxah50T8Okpep+pABwG94aQas/LYb9pzs8pUCuqkJFFMNOhgJkwKZIdj0ICunmjNWnIwr4wobvPwUQmtjTMiLSYUr9TD+z79pZqR4aQdMvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wncTctsx1aE0FQBp5Wqz+nAzKarTBXzW5kiqwa0eK4Y=;
 b=c+u8URlF1YBcsonNgiEhaYYdBJ2BBQceMc8euB4UUeyV6F/9MCIUuOJMMYGm5SqQycqLh9q4BQ/n7zlX8tal6k4O/9mkYGokRVBxD6jZgux6PBQC1xgyF0MLDwBuiLU+bzOWAp94N4InVCuRViY6HywOD9dCx23YVSNkkl2ss5k=
Received: from BL1PR13CA0149.namprd13.prod.outlook.com (2603:10b6:208:2bb::34)
 by BN9PR12MB5307.namprd12.prod.outlook.com (2603:10b6:408:104::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 14:57:14 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::32) by BL1PR13CA0149.outlook.office365.com
 (2603:10b6:208:2bb::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10 via Frontend
 Transport; Fri, 3 Nov 2023 14:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 14:57:13 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 09:57:11 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Add flag to enable indirect RLCG access for
 gfx v9.4.3
Date: Fri, 3 Nov 2023 10:56:51 -0400
Message-ID: <20231103145654.2651-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <513b2282-2f88-d837-ff37-6bd04641e833@amd.com>
References: <513b2282-2f88-d837-ff37-6bd04641e833@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|BN9PR12MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: 716ef9a6-e8bf-43bd-e943-08dbdc7d2a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1uM39FahQNPSVj/59UoIxNGuutxCYh4CayY3hGmEGBQzg/S8kuzB77eBSYbwDakwJ+VY2vXlIprHD0h7tXt14sQ1KBdcXhRhXylnakOwRaK9aP80A9SAkVq9GdlAVmUm4mpjqV4Ou3ZvC3YbexZWdcDJajOJfxddIf03Bft98pRhvPsMMA9gs4FlP7G/4AHeMVEuaC/QIzjD4+3bpDZJ8WWGg0wXC/qSz8ZKisg0KVIpSQpHu4RZ+6KGcUZDksnR9lbfOdAlJxsDHHM9tzUFZFnGAt24nQqSKbYgZbtErzgzB8hIWmeaUTvq8KYNVeET2cXwKe8r8PJdPJ4pY6ahGIcoAjpSqIz1GfI+1lTDl/KVpdGFCgPnavhVwcrRaThVnm6tvticn73x4ySjLJ0bbwV53ICAs6FXiVWUSExn9tYwYK+ctV5Ij60QJq9f25uDKsr7Xq8zJzz23E4jpu+/Omm7RU7YkXfRmmKrTnbHbJZSf/TjFeByFzOUO6GOacEkiKCZOukpRyvKnKtbfaRdyrmdaVCweLkoMD7uRqmLZJrrZxOBClzblwUCyvCYwwjK8f9nnbi6ogLLAmpXpCnem7JjVrzk/6CLnyk8XpHq/dgM95h/FfzwKkFhkZtnTpQtgKuo90D0WD3JUjiH9ayGCvT1ySI9JHuEl4oES9qwsB4CPN8MHPq0NOCy8qhbljLFkW8gIYE0grGEacG00y3D4+AhZ23zVlQ/o0nk/eiAz+1h9DPeLWDxuEZVJ51Fxxv0dIKHFk2KmDXNXmVLcXZyrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(86362001)(47076005)(83380400001)(26005)(336012)(2616005)(1076003)(16526019)(426003)(7696005)(6666004)(54906003)(6916009)(316002)(70206006)(70586007)(478600001)(81166007)(356005)(36860700001)(82740400003)(41300700001)(8676002)(4326008)(36756003)(8936002)(40480700001)(40460700003)(4744005)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 14:57:13.6994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 716ef9a6-e8bf-43bd-e943-08dbdc7d2a27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5307
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
index a1c2c952d882..ce2a9876369e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1101,6 +1101,7 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 		reg_access_ctrl->grbm_idx = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regGRBM_GFX_INDEX);
 		reg_access_ctrl->spare_int = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPARE_INT);
 	}
+	adev->gfx.rlc.rlcg_reg_access_supported = true;
 }
 
 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
-- 
2.34.1

