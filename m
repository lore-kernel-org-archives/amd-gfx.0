Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D0EEB8FC7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D506B10E631;
	Wed,  6 Sep 2023 12:49:33 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AD7710E625
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:49:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcAFf/Alby0O9cGBnm1Dy5IU7boRgEN5sR9jekuIiEhedt4UU2ijuIl3fAA0wvBVF7lR5M2DvW82EiVBYXCCzS0E5D72pgmDbMyHSnbSLdLJc5gn31iQfmR8pBStovJ2aNt3mn57Dfl2b4LSPfF4rCTXICDgBcQ9s6o+9qD2oxIOp5hnC6cOS47YSQ3KRFyYcdFA9VttK0CN8N5Qcwb/wqn4iNVwAMFB4uJDfqi+oVGZfiEYyfp+XQ2/vXWUFG44rk2O8pp3HSZ9MCDNvqH724GpVPrWHIOJl+dxRLMTHUNydPFFlgLEWcVS0PJnZ6nWLxQuRlfPW0eDiQWA61UE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLFiLn01dL9knNS2osFatxw9aTyAne0j8J3wSuLLTpg=;
 b=P+aIL22ruCkBN6SykFjgIoglOX0sIjht7bbaN5UY++m8l0JVaCGlWBsMI6EQi9CIzPyXph8VjwGBIxScIiFfk8HP97R1Dy+18hxU1b1SFCGk3UP/1tv/WNRLNzh1dAqPLP6O/DtUbiMFbWese3Mx/JEErtMLFTaIdsJMcUc7PdddpjN0o1Ysl+aCwID9VXqCXt66SpwPPjxG1jdFqE73lxstwjpjgp9PRTFMgjtDWHfsCn66hX8/0ctVD321VA1ej6sHnt6+J7xJjHfaXGWqyYLbaYiczfTb0vMWFYKynVa+6i/zx1siWxa8AqNCh+b128UyMM3/IlVMjaMYpGO0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLFiLn01dL9knNS2osFatxw9aTyAne0j8J3wSuLLTpg=;
 b=Oz1nJeLgCGDiQU8G5YtDGDatUG5gPdDzKj2HWq4b/MNAQnxudUctG5b0hciE3Pw5MXkOYOXEKxoqk50S+Dp5YJVFFoIG/x3Tb6c8J70X/hz5JKgKfcgBY344w/Poav/aWx/gAs+UEc174qHmr6NjpOPQOrb2S7a/hseFvlTo8lg=
Received: from CYZPR14CA0040.namprd14.prod.outlook.com (2603:10b6:930:a0::22)
 by SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 12:49:27 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:a0:cafe::d8) by CYZPR14CA0040.outlook.office365.com
 (2603:10b6:930:a0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 12:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:49:27 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:49:22 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/28] drm/amd/display: [FW Promotion] Release 0.0.181.0
Date: Wed, 6 Sep 2023 20:28:11 +0800
Message-ID: <20230906124915.586250-7-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SJ0PR12MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e5a62a9-d9e8-464e-65ec-08dbaed7b48a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ER5MhBYauiqS8Rur9Tr7fezRPIK9s8JpSb57Gn3GpbJV4q/4U9E3JwZgnADmZXRD5d37FcYM5Fel8zMUwt3oCX40DYipedoyNlJVGLHe0BQ9EogFx8s+RIp2UCOMGPMwvm/Qen2HzAVCdHAjU4LfhIveBmlx1lFXwmSvGvv8MefuYN0+yf3lRlumNV8YztwdhdDhXrTD07MaxDpG0cEFf7WpOOuDDmQRTPtgmNNb+p5bM5HjVuYgTolTDQKZRT2rsMwYu6thmiMciCOEdn+qt7H/mWyUe7mMhwkt5+JlcgQV6eZkm9c02VF4WNNOXu5zwzuJWEmDYiM0vfwMzwtud9tVvNs3+dGT9P7D/rKKC+T4qyOfIpsiE0cmCVA0fmOpXlyZO0x6HJY9mW0WvBSjN3T2iJaidq3+kOUNcfQa2ENu0bBTYTBfKvIJjlvONsC2o66QA0UJej8wIHZsus+rh8xdfu4UTcInL9IoGkuvhH0zMSExb5ngU+2XdzrYCWb4tt8HLgcwhXBkPGUZQ8pD2ixjIkXWIl7Cz814WzbWolGKbY+hbedUUOef9r7pg72tLqGIsaar2uxGl3FarI9Rw6OKcxN3MA5Eo0iOWI5/UzmuLvQKDbCcWs9BO9ShZw3fAHCGO4WJHdmwjjE3sXHtnwzA6iwdTiPw1tcr4CTwW5aG0W5kJict+3vHzoG6Icrqdkx1QaeWKBEmw6CD3gADFDZL1CR99ARpVhJIf/Y/G/ozcZGF7NQhyoX46hcOqoMzy/fX4Jq+Y+btaMePzzs5iA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(82310400011)(1800799009)(451199024)(186009)(36840700001)(40470700004)(46966006)(6666004)(40480700001)(86362001)(44832011)(5660300002)(8676002)(40460700003)(2906002)(4326008)(4744005)(8936002)(36756003)(16526019)(81166007)(356005)(478600001)(2616005)(426003)(83380400001)(82740400003)(7696005)(26005)(47076005)(336012)(1076003)(70206006)(70586007)(54906003)(36860700001)(316002)(6916009)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:49:27.1508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5a62a9-d9e8-464e-65ec-08dbaed7b48a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616
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
Cc: stylon.wang@amd.com, Anthony Koo <anthony.koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

 - Add new params to dmub_feature_caps for checking replay
   support in FW

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index e2aebba29f68..0367d0850495 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -450,6 +450,8 @@ struct dmub_feature_caps {
 	uint8_t reserved[4];
 	uint8_t subvp_psr_support;
 	uint8_t gecc_enable;
+	uint8_t replay_supported;
+	uint8_t replay_reserved[3];
 };
 
 struct dmub_visual_confirm_color {
-- 
2.42.0

