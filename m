Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E545EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jun 2023 03:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FBC410E5CE;
	Fri, 23 Jun 2023 03:19:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B8110E5CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 03:19:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDjHHeB0fUqI13Pb6NlNTSr0EP3IXvvj1a8xYh+wd2PuzsZz8a+0GzEi4yNIu8wvejgUWXp86/UIQeBNDdwVPWI/9Sjrpix9YZ14zzetcD4Jv28hUEvfc8GYTxsOjxj5VUvtujRRQLdHMIRR5IqwxO5t0AdfHh27z+jzMLd5s89dkX2YcLF0S+lCvuMNP9MDK6UVej0M/8TT5/h4m6HIfjeE5lX7JI/CzWL+lSADmUaxWeOcLzjtcIkEZX/pnvHyop8iBCL5SaJJ+hsrY4hYURIbBedebPfMIaawr7/jpojVh2/eVoSseifCLDG4KJAyAJ34NY+FXz3ALabjo8wpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLwD5FHRBtX0beckqutTYMP8CrwoTVMXSaskqTsseOw=;
 b=NHrXY+vh+7LeB3gczm2nILYI1M5EFL0PlYpDiEiAmx+En/ceNktTqZMwBjE4Y3DgbwIgk6H1CNogInMzOirYZQNpQwJHO4v3a7CzPzmmeHH9YWxQyt2rcoArLNBppuzWf4kiqGrW+YAWbsddlvCmfhhHlSyG4PyQ+A2A4Qc1TAcaC19TypYjRGrBEAlCivhumYH/uh97dw6nBMJWutdKLUD1bzHNQ9L9YCzD3Rhvb26p0gxmdudjB0DSHaVe2XBs91oUISdzB2q+jRPrcnSYpxhjfF5mWFarRhLCkDYK31uEdD8hcXaTX5y/w6ezyHyorEKwXwjaHc/44RooB12nEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLwD5FHRBtX0beckqutTYMP8CrwoTVMXSaskqTsseOw=;
 b=hsOy4CmqE/PW1PqBybxDTWLkSYvm9OZd6EDdjxkt4pVpoh9ewLT2yBTBUHRcij94Az0POB5IKWioQVsCWWn12aDF7gJZqeHDcxMh1dmB3PqEYoeNKdAFh38oVCIZlWXZB4ynVIUA2CQVz77fQlbzl2zjytoywwpsu/n7ZJp8Ehk=
Received: from MW4PR03CA0198.namprd03.prod.outlook.com (2603:10b6:303:b8::23)
 by DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 03:19:16 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::e5) by MW4PR03CA0198.outlook.office365.com
 (2603:10b6:303:b8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Fri, 23 Jun 2023 03:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.42 via Frontend Transport; Fri, 23 Jun 2023 03:19:15 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 22:19:09 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Don't try to enable secure display TA multiple times
Date: Thu, 22 Jun 2023 22:18:39 -0500
Message-ID: <20230623031839.16911-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT068:EE_|DM4PR12MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: 012f7066-c0a3-4444-1a0f-08db73989ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hrm6oPghiwmrVTTiQ4/plhaVnYLYqCLCrpKZxt3PJpF7SmonEeejBicBLQaSfqe+ej7K9ZPu38JyopxxDPRKj1m0EKlM46sdS4UlA0znPvorCXA4x0KnfERvlDWxQNV52AvG6eJDspmvV+DSUflHwIy/j4VjhKBkqKs5liYnqZdK1owcORbKvwOhPua6kusukrD9xBHUqZ43yQ+dq1Z0Ojyq8sQCYdj8qLuNghAv+ot4OCbghbDPLR/MWydfkqFaYiN0ACOqpmEK2BBk27XOV0KgoFbVucD5SIK1QE3pXBPPPqFrven5lQ027MVEAzlcjCo8vtQdxzN1nF6LE9jshp8Bau/CBJbzBKj7tKCGvUMrLCUGJMVdlTh1fcv9iVbq0vcbv4LDNE8Sae0a+9t81tQOLMX4y82fQBOw9uY0604vq0K2vOgIc0iUXoDtRE/OJoXB88sUGQjY9qEFEnCdMTNN8ON7+Y0ddHPlZsoV0EXqXVkJAKF5LhRtB269XXPvn3Ckwb9X16OaOtVAXNEkbAZtq8HMtweC89J+VxMN43L0JRjfxKE/en8e7Kzl86OLzlMJHe/QeEWv15LHqHrA9hmJSpqM/3iLL+lCTaIGCkPMUkkVe9v684/KLDkssFsUx9NEqiYTLEX64aq2JaBtB6n2w5O7ENHMuwfPCeAfyTCzAQbj65bcpPl/o/Vv1ajmX53JYOIPy971bhWadWl6AQkUcenizOu6BiwabISWzX75GfD6t/KQ8VZ/9U+55K4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(70206006)(70586007)(316002)(4326008)(6916009)(16526019)(8676002)(8936002)(26005)(186003)(2616005)(1076003)(41300700001)(40460700003)(54906003)(6666004)(426003)(336012)(966005)(7696005)(82310400005)(2906002)(478600001)(5660300002)(40480700001)(44832011)(81166007)(356005)(82740400003)(47076005)(36860700001)(83380400001)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 03:19:15.7660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 012f7066-c0a3-4444-1a0f-08db73989ffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070
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
Cc: Filip Hejsek <filip.hejsek@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the securedisplay TA failed to load the first time, it's unlikely
to work again after a suspend/resume cycle or reset cycle and it appears
to be causing problems in futher attempts.

Fixes: e42dfa66d592 ("drm/amdgpu: Add secure display TA load for Renoir")
Reported-by: Filip Hejsek <filip.hejsek@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2633
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 89a62df76a12..c4cef3f2af3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1937,6 +1937,8 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 		psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
 		dev_err(psp->adev->dev, "SECUREDISPLAY: query securedisplay TA failed. ret 0x%x\n",
 			securedisplay_cmd->securedisplay_out_message.query_ta.query_cmd_ret);
+		/* don't try again */
+		psp->securedisplay_context.context.bin_desc.size_bytes = 0;
 	}
 
 	return 0;
-- 
2.34.1

