Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D17CDB483
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C97EC10E4F8;
	Thu, 19 Oct 2023 13:34:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB7610E4FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luwuzsGZrdyNgP5HHwqSo/6Vt1k5smkrgC2PLFs8jMUUED/yhMG/mndtpSN6xeJgJtZQkwejmqRHtUJ2EyQXIS7lcQPGkhqsPAYWUcnJFjPb7YlbeS/5How74JHpAT6cXU2xz88RkWuAZ+h+gGUUq6Hg/7FGdcEar/IQuAY+8mA1FJY3g1w2CEGgPY5jcZJm91VFe/Ueg2H9gWklMU9mCMJxgj5SrwwofkbEhW5CNyhBBV9dkJocf9+llfLe2zoblmYC8xtCw6hqFQmF3pkhJaC3yhzlWsJ9tvgJR49KTnTNI+/Lxe0uTwHiC/ZA5aNAHmVj2p6DU/4oDJNUxPoApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzzUv63CTHMW0FJM0QJY3yNTsk6CfAk0mqdGnsYIfQw=;
 b=OlmjDmcRzfGCq7u2dDK/7qtE1QC6NUIML61jsiiKUSoJnS2fedquW53IG2HhPm3QDLgCW4dCz1WuJqr9vwSHmEZ/AI1Xl/zuUM6/cRWM9YMf8mPKSmVjqnWJ7kI3ONSpgwmbnDNvoX2v7eSMfzM3hDJriyGjhzDEtGw0HXzUq6bZB6jdtSweOGCeLxeEVSiI/S0CuCxNMF1PnECL2n3WX3N1q3ZAKU0ctsm0xzZV/EhTMElwh6L+CBqmKjCCHrIH1HbwjbyNZ/NyqcBD+8b4LKsbHUP7C1jumzt8Bp/aY+MyGqs01u6PmA5+DqPDrOZIT80hjoxCUsr6J7+XuJXcew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzzUv63CTHMW0FJM0QJY3yNTsk6CfAk0mqdGnsYIfQw=;
 b=IlGjlhVhMlOXKr5jWy1zmL9uAPvKFgQIiKKoF2fysPByx3l8YhM0sAEW9vN0kzq6p9rXeWbPFZLhIYvuc8o6GJStIl70INHPJxSECL76D2F9y2w9a9lIKrnlibShbZjwZmKXA8LHMoVMoG9KvDdM/FM/bDAxZNzN/6h3cidjZnQ=
Received: from SJ0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:a03:2ef::31)
 by PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.41; Thu, 19 Oct
 2023 13:34:47 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::8f) by SJ0PR03CA0206.outlook.office365.com
 (2603:10b6:a03:2ef::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Thu, 19 Oct 2023 13:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Thu, 19 Oct 2023 13:34:46 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:34:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 06:34:20 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:34:20 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 20/24] drm/amd/display: Fix shaper using bad LUT params
Date: Thu, 19 Oct 2023 09:32:18 -0400
Message-ID: <20231019133222.1633077-21-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|PH8PR12MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b2e4ed-a2df-4afe-d6d8-08dbd0a82950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3SKfFC0/POyqTn9CZhIILZWbvWRp0nprbQvPgaZC5Lm4CPrNTJ2mRup9kvxMiIvLHFz9s35wnc1Z0qe/4TAijqiwcxfDSqtlnMH2G+JlJRZYszGMmQiOFN7UFuKAetUT1twzpm7H2UOBls049kXBoPUfEAO6gYvUHHkOd4xy7L7ab4LdzOwcGvhaTSaS3KYAC4XT/GjxHm1Z6WYNEeerf4CU3bu2ZDVf/QvBO24+zUHYFZ/Jn8bvGWA7Er1dgIAKsIRC+wxxGa+nL6dUn56AvS4jf4wPjx2+YEDs57MqE1qDM6xHqAgRqfHvS/6VNLKZ7TJ7jSt5bowCnC5P5XZ6FUqfAYW18Au9zqe3W6EUhJyvmSHAcdHk4vMWnGYSkwBVhG9ZbYBqTYo4/7msd7fN3d98IHA48whhg0sDRO0U4tGhsZEV3zfRFcObaIM++9iaQkKc/SlY6+iOw/H8GHZ9YiUqLW/K448l7PpcmBam+DLkAxYQ3M3DnGDhu2Vlk3K6HWAtDf24eKHm5eOsnACvwAcfK6fdzVHf/cgTydeXiYjc2atpAc+CJ3UCQTojLQi1U6qFRFqk+RM9V29Rsa8/8yGeurh3v4hvMoA8Tfzmi19J5qrBeVz8h5qiMNoqaPVpFul2oTpozqeWX+5frf8RNR0r/BNLhFP49QbMRQcQyZr35imHHbWi2O0TpdbOXVFm5UqnytL4QofbAVeHLZ8BJx5V+lOALB5UAwgLUtVJ75uJlLs8vGjEuhXSnbSDGnnx1EMfmigK4cdm8+QN/K1KxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(356005)(47076005)(82740400003)(36756003)(426003)(81166007)(26005)(336012)(6916009)(54906003)(70586007)(70206006)(316002)(2616005)(2876002)(86362001)(36860700001)(1076003)(478600001)(40460700003)(2906002)(7696005)(8676002)(4326008)(5660300002)(8936002)(40480700001)(4744005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:34:46.7741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b2e4ed-a2df-4afe-d6d8-08dbd0a82950
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987
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
Cc: stylon.wang@amd.com, Ilya Bakoulin <ilya.bakoulin@amd.com>,
 Krunoslav Kovac <krunoslav.kovac@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

[Why]
LUT params are not cleared after setting blend TF, which can lead to
same params being used for the shaper, if the shaper func is bypassed.

[How]
Set lut_params to NULL after program_1dlut.

Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index e837554b8a28..1b9f21fd4f17 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -494,6 +494,7 @@ bool dcn32_set_mcm_luts(
 		}
 	}
 	result = mpc->funcs->program_1dlut(mpc, lut_params, mpcc_id);
+	lut_params = NULL;
 
 	// Shaper
 	if (plane_state->in_shaper_func) {
-- 
2.34.1

