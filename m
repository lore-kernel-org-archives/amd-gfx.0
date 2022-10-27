Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D475DFA3742
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 100BD10E6D5;
	Thu, 27 Oct 2022 18:41:45 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2069.outbound.protection.outlook.com [40.107.212.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5032510E6D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:41:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIG5Uv4LpaJ5YLoDkq+Fgy1O/43XeLkoJTehbxbn1w9G8c3PJTfg4LhxP5u5iq6DAiKx8wEeURAoyMJCqO1P/nnb36Ms2f9ur37kksP7mzkYvvjka3YdtahQCZl5GbgRKx9C9Bneg+nKV7O8pOMqC0CnC3xgnAQ2+m4+rBkhrdsF5bEmxAdwIFvdGLEZhOEFiZ5/zV4cPGmLjvmsvuM4STHsnIsr6NwCY8xwe2ZgVseqzSQCx5AN5Q+q+IIXEaDZL+lrwTg1YrDEqkC55TeurPsmuGWdHDa6ckpwGYtixDFZIXYljhsbVKuGzn1xfdUQx+x8hvCTl3Jp41oCWuwEXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lL+iOW06RuyKh/VmaAFT1kVdsEN10efxhmfXMW+Zvbs=;
 b=jJ6Hzr7y1I/NValkzNSlzRosywbGMiAOV/NUPaCjuoMY6S+ItQOrmnmi8ks2IphEgWYft/YCmQFfSnO50mFfKr2PtSpdMA9rBqvV1T5O/BTDrZIiPPRfv6DWUZbIo+pV+74G14IS+M/qcymNQ4XG79xyZdyXjooR2tl2Nfdnlm/nWxqyVzm2fjZRvnhiCW5Vz6yAEA9HqNw7KAloFs2IPyqioNInm3RCC8cXG0tAxYhehvUS/gLVy0QSxfWYBD/GflUSWCHUfCQ5+0iUjBT4AyFhtFDxehWq8oLJ6cVXsqkotzTexfm0SkoH7ktUYkMN/wfsTAODcc1bF5/D4csC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lL+iOW06RuyKh/VmaAFT1kVdsEN10efxhmfXMW+Zvbs=;
 b=FA0SApKgEdjxuZccWdzUiNUHdHA5yJL2VAJsmUmEZSCz3xL5mkO2hPKN2FIjewT+6dwxXV7U33iwkzS0Pw0Jm55gp3TqE28Jt5fV0gQGrEANIBvGh2hHqsdOKZFKCWVaOQMM9ZHHkd7I3TLJ4rM89kiKIEtaRVYJuimsgFzfm1A=
Received: from BN1PR14CA0025.namprd14.prod.outlook.com (2603:10b6:408:e3::30)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 18:41:39 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::10) by BN1PR14CA0025.outlook.office365.com
 (2603:10b6:408:e3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Thu, 27 Oct 2022 18:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Thu, 27 Oct 2022 18:41:39 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:41:37 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/18] drm/amd/display: Use forced DSC bpp in DML
Date: Thu, 27 Oct 2022 12:35:38 -0600
Message-ID: <20221027183543.1117976-14-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027183543.1117976-1-alex.hung@amd.com>
References: <20221027183543.1117976-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c4e7f4-3ca6-4b3b-034f-08dab84ae296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blTDfZiDWYjmW79ZwQZXABui6lzfun9jGSQ7+CoNeZT1gaOWc7rD40YS4T7cIETa4p0vWm83PSQGpiJAxh92sL1HOXrpWZgWvO+6/Zi+SLdBURuABm+ochr7kmQlsNCEf+2ggiSfSalq2P/gv0LJbEVHJASXd3/2YS1DjU6ALWk9FbSooYEI/pAscrHM6CcHn1WInfuOOSXVabAVOQFY+x8rRWmiKS44cSXdMuu4FZ/8JK/9tBLGLXt+stRsfCgnEdJlqA28wrinWyScSWGqTJe882uV2lBsatn/KMW9rRoSwwURiCymgqwMuMBqGdgtnZ0dKRpQhT0nVskxhfZ7tOI3CewWpdOVhfEn8IgmBSPf5lAiN8HALusJR7Kqng/mWB6zmfKHABopC7Hl3qvPRYNv6G1k0h9Io7woUAW+0ILVDUfR1xEDPgYJqJKXT8t6ISjhKmMajccIrbTH/O8f0ql9JyrHGxFz1tWcJ01PWfwWN155WvIUrXfLqDQknyj5xwc7BctDqg4+VngC63awXFyV/C3MU0cGI5QwlXWxM7DGWtvPtPyFo2LodwYQlnDMY3tOZdm2VrF1gYKoeD9WQA+AWTfpGUR/mmkvXXwBN05cBb3gDv8wvtzBSFbTWOqR+NmmdTiH0XXu7QWACtbO+aiW/wWUaHbAraYb4DoAmXa9SAaL9SlRZJlKo9BlFBPQLbgHZaEYKjeyftlFt8FZ/FWPyS/de5e/HGxjeSTrO/bb3LIbcyQp7hVwim+yasvYJcr3TlJN/dpgMGDEuDZoDPCrJwebCXVQd8yIkUv441xR4XdlXIr2GdQ74Gsy1AO5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(44832011)(316002)(54906003)(40460700003)(26005)(8936002)(4326008)(86362001)(70586007)(36756003)(6916009)(8676002)(41300700001)(5660300002)(2906002)(70206006)(82310400005)(356005)(81166007)(478600001)(83380400001)(7696005)(426003)(186003)(36860700001)(336012)(40480700001)(82740400003)(47076005)(1076003)(2616005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:41:39.4606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c4e7f4-3ca6-4b3b-034f-08dab84ae296
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
 qingqing.zhuo@amd.com, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
DSC config is calculated separately from DML calculations.
DML should use these separately calculated DSC params. The issue is
that the calculated bpp is not properly propagated into DML.

[How]
Correctly used forced_bpp value in DML.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 5b91660a6496..60351b2891d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1627,7 +1627,7 @@ static void mode_support_configuration(struct vba_vars_st *v,
 				&& !mode_lib->vba.MSOOrODMSplitWithNonDPLink
 				&& !mode_lib->vba.NotEnoughLanesForMSO
 				&& mode_lib->vba.LinkCapacitySupport[i] == true && !mode_lib->vba.P2IWith420
-				&& !mode_lib->vba.DSCOnlyIfNecessaryWithBPP
+				//&& !mode_lib->vba.DSCOnlyIfNecessaryWithBPP
 				&& !mode_lib->vba.DSC422NativeNotSupported
 				&& !mode_lib->vba.MPCCombineMethodIncompatible
 				&& mode_lib->vba.ODMCombine2To1SupportCheckOK[i] == true
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 03924aed8d5c..8e6585dab20e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -625,7 +625,7 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		mode_lib->vba.skip_dio_check[mode_lib->vba.NumberOfActivePlanes] =
 				dout->is_virtual;
 
-		if (!dout->dsc_enable)
+		if (dout->dsc_enable)
 			mode_lib->vba.ForcedOutputLinkBPP[mode_lib->vba.NumberOfActivePlanes] = dout->output_bpp;
 		else
 			mode_lib->vba.ForcedOutputLinkBPP[mode_lib->vba.NumberOfActivePlanes] = 0.0;
-- 
2.38.1

