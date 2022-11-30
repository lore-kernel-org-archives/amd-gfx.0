Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA3BC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 06:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C67D510E40E;
	Wed, 30 Nov 2022 06:39:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFBBA10E293
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 06:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bX0cpGfNUjjSfNqDya9dXxTBnNjKl2RHw5DIe9+OJE1xv6QO/bzj1gkw77s1sne9obiCAYE4Qd7pMgFpEa1Ny/8R+Sws77nVzYKZFxRVWzm3Qz7hpvvLXR0iwk7ciUlNtSMc8X1vj5Z8aiB+bN2BTGBNHXinA81SaB6U4G2zvdiwrqJmwxKJwNYjRzH8pqSP8XTCGrqhxykvc+j3SbHWLCMOt8Q7R3QMaBQZBvlEHfdjh59eFqhbVNrqQ1SZplKhIahDLnGV+QcP2sBPOfJ4oLTPupXuykQBC1Z3UPQFR9clQklmfSSoNkgaM3MwbKHkITXuN5mxT5SUT5zX36GH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdpHEBWhquppo1loMQfEk4EPIABOE+GrjmjGE74H5gM=;
 b=SLrG51+Kl78bhfFgEDsO/eYKDTwco/zWngniWiOpBJUHFxfeFgekWOy3qqoYqGkQy5TvLlVWcT5grV0AfgNIxpSOcOQrGEy+N+5MEsBe6YJwSk7TelGn6SF33o1kLX7S8eW7n/gVhAP/VUlek9mNQ/xMNW3jqsdAIdmq58vxTtzzyLsLCWxnRBhevGu9FsUmffOSG/9LcurPK42xgdHH2ASLakaEgGpBSAKsulf7m2BAekc5kY0G+Y7JETuYeN7idLLsw64fPoVzXbRppLu6y8hYxQuB4N65h6MKZuFco3L1EUiW+2CuHa1Dr6bW3jkZejoFMYkHdth5UZbZXZloNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdpHEBWhquppo1loMQfEk4EPIABOE+GrjmjGE74H5gM=;
 b=EH35GHPI7apfYZUaXvxRP2TgJu8Ey/fd/3neNLxqr8Z2/2svi4ott0rGUEod/ss4oxY8eF7vyZ40iSEd+MMH1z7Axz/Li8RSY58qiA221xIX2//F8+qp3uYclNNYGoQ2eTnCEP9r6KXJ6mXrLAQJF+Gymb156xsCctb08PY6olI=
Received: from BN8PR15CA0004.namprd15.prod.outlook.com (2603:10b6:408:c0::17)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 06:39:51 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::8d) by BN8PR15CA0004.outlook.office365.com
 (2603:10b6:408:c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17 via Frontend
 Transport; Wed, 30 Nov 2022 06:39:50 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Wed, 30 Nov 2022 06:39:48 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 00:39:44 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/14] drm/amd/display: read invalid ddc pin status cause
 engine busy
Date: Wed, 30 Nov 2022 14:36:21 +0800
Message-ID: <20221130063627.2398341-9-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130063627.2398341-1-stylon.wang@amd.com>
References: <20221130063627.2398341-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e52f4f2-8871-46f8-6ca0-08dad29dad93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8CXudA2odR7j3whpujgjmUzjylyJrkLL4cPnJlYqkfkAw2gbGicQnkUo8Y5sziHC34wUnwxI2mMr/pKIKaJ+jwsZwiB4LXGemK3SWjucxHxbW6pgtjWKF5Dw61+qR2bSW7+sXdF6Fb8wLxXJgpSAo1LEHnmvU7MhQCl9YUMy47/IT06Bm4TfgocGjolBzLbsbftyphfsHBdoyCH15aVfdMTcRO2uofigToFeIf4wnlk2+JwG6/fR91mEiueFAIDOwTIOrxxUCSyJN6dKwZB4atm5A3A+zdhpwGDJM7El3GnUqRk9KqgXmAutxTyiWX9lEaevuP32+wl0c4Bn+ISa4W7RanMEyA2UP4TySMi8jSPuu+65vuro0Z0r9q1jlIg37wQlTknkeicNhl19t46MvH+gvER72O9byOIUhoaSbbLsqedfM4bZ2fOCDEPIsVy3kYvJyUT00FhlbCtQOszYKbg0ppchhmG+LbaIRIRebx5tsSKMhqBPaaaoOAKVIA9M9ZoZOjI9PXEhAaBTx5idMsxxP+qAHzQCdAGNMUsWwKPy5y3bT4qhB8hEKCoRP4++81uMRgoetWCXZYoiIe1KyvV4fPcjmVmurWBFPWV8WcMWZ8d3J3LXvZP02fHiZjTRtw77vJfpxIdhgbJ1gkDvMXmaNPZV1+H/vH1ynyHakMshMGZN44w1jDS5ME38pkgqvwhkCzQnnqwrPsIau2eZhf82bnuS1jkVkqS2ZMBaiw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(36840700001)(46966006)(40470700004)(81166007)(356005)(40460700003)(86362001)(54906003)(316002)(82740400003)(36756003)(82310400005)(6916009)(40480700001)(478600001)(8936002)(2906002)(5660300002)(70586007)(8676002)(44832011)(4326008)(70206006)(41300700001)(83380400001)(36860700001)(7696005)(6666004)(26005)(336012)(186003)(2616005)(63370400001)(47076005)(1076003)(426003)(63350400001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 06:39:48.9852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e52f4f2-8871-46f8-6ca0-08dad29dad93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Paul Hsieh <Paul.Hsieh@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <Paul.Hsieh@amd.com>

[Why]
There is no DDC_6 pin on new asic cause the mapping table is
incorrect. When app try to access DDC_VGA port, driver read
an invalid ddc pin status and report engine busy.

[How]
Add dummy DDC_6 pin to align gpio structure.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Paul Hsieh <Paul.Hsieh@amd.com>
---
 drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
index 0ea52ba5ac82..9fd8b269dd79 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn32/hw_factory_dcn32.c
@@ -256,8 +256,8 @@ static const struct hw_factory_funcs funcs = {
  */
 void dal_hw_factory_dcn32_init(struct hw_factory *factory)
 {
-	factory->number_of_pins[GPIO_ID_DDC_DATA] = 6;
-	factory->number_of_pins[GPIO_ID_DDC_CLOCK] = 6;
+	factory->number_of_pins[GPIO_ID_DDC_DATA] = 8;
+	factory->number_of_pins[GPIO_ID_DDC_CLOCK] = 8;
 	factory->number_of_pins[GPIO_ID_GENERIC] = 4;
 	factory->number_of_pins[GPIO_ID_HPD] = 5;
 	factory->number_of_pins[GPIO_ID_GPIO_PAD] = 28;
-- 
2.25.1

