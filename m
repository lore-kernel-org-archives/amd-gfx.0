Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C7EC2BB1D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D118D2051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yBooeblE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D118D2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 814006E45E;
	Mon, 16 Mar 2020 13:50:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E4336E459
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:50:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muMPjqoN0JDxr35hkjstu4UMyxuKhq3RlPW+KUVLeF1Y8AqSJODCf0hqLEFbKNbzYDMIjNyS5JZHQpC+4c+qXmTgTKuD2POUAcyX1AAzAJ/9GHbVpDw6jLZHHPNlNvcpwhQV11rSa/DFeEG5HwMGHEh3X3fioEVwdayoPjxCnVugjdhZo0F7Bem4MoWHiMF9V92ehanVUUUREbAfIOKA5kDh8HNHsXwlr9hvg3Y6R0Z59KDTBz5WOE3CgcT7bDqmb6072NQUEyNMx1mbTuVjh9nh8eEGAQcvfF1ZHZ2J5rceAanPg6W7TlRanZAl7KlT59BjmUNay4NZR1j35Ls1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUxlX2ZDC1UHZ1MjQKqraexzFB/FhOkXmkj5yCv8kIw=;
 b=Davdqhi5S9haPBECZsAIPiNtuIb29R2tJnAC1nz6GskEjQN4SiF20L1WdtLuXF6zk4/yptLoBEwDyL4Xbgg4gB7upF3rRl899cTzs2roe5hNfgFPilZPrFgCFfVnBaLTTjAFV1/rcl8VCz+lE/0Jicn3QdNDO2duuW1QuKiPWBmH0L828LgDrSBqeE3LAb8F0BmyCclGTb+PXLWVneMxQw7864KOtcvh5caQQb6ZaSxjy76VMqSq4pbJkeLBi2vYJNAx22uO4t+tb4Y29K7nYbQnDfcVsapJAIToSFpNwaG29L889mqTna/OYPMJHQtWjNsuLmZHQ4vU82YJonEfsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUxlX2ZDC1UHZ1MjQKqraexzFB/FhOkXmkj5yCv8kIw=;
 b=yBooeblELwVSRxZa703JZSL41RwR0KLRNOqVhTGuALaOcweCv3cHFBwR5b2KH8xn/JszJH1LcGkT009KoKrQfc0/PDlhV20WF33W6NxZVpMs9kti9coybQYaexI0IIYVvsKEGLWG3zSRtdwYSmJMMOJA8O4dj7+Qz906nZtE3Ac=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2363.namprd12.prod.outlook.com (2603:10b6:907:f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:49:59 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:49:59 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/19] drm/amd/display: Explicitly disable triplebuffer flips
Date: Mon, 16 Mar 2020 09:49:08 -0400
Message-Id: <20200316134920.2526155-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
References: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:49:58 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f229220-5afd-405a-bf5a-08d7c9b0eb06
X-MS-TrafficTypeDiagnostic: MW2PR12MB2363:|MW2PR12MB2363:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB236346AE76D818BE932E861F98F90@MW2PR12MB2363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(199004)(8936002)(16526019)(478600001)(8676002)(7696005)(52116002)(186003)(81156014)(81166006)(6666004)(26005)(6916009)(54906003)(316002)(5660300002)(36756003)(66556008)(66476007)(86362001)(66946007)(2616005)(956004)(2906002)(6486002)(1076003)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2363;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LflJRDikS2cOeX9kA7W1so0R1LM2N5Idv+HLBJdP9gh0KvO6aSsMrCFnkpjHS8YD0VsXoZct6gfjJT/4nRu1D3QQ/6tcPymSI7GpVcTODZcJzwktybb563r7cpCLtIDXQwLeIOUKbdlmIa/RjSGtruMhuR4GyTGY51gMSiTD3molZetXxU8dLYWAjlGVQ4xKR+DwuSHLRrU+hDZvcJu122bQv14ZPlKY75Q7LVGHzywO+D9lzfzmaJt14qeaUPXYqrlKoDQADx9FbbIImO7qSK/IJGIwk9ixX0ejyLqX/sHj0zQrezhIZOhI4yLhNv1Tca2G5abcFLTGiDSz5Xw8/SCNmT+Fssv2GLwHEcFH+DwmGgrxkFIoNWday29btaa9bw9N1gS/VBE2yBhDzy9pHxzkti1sXyE+ZuQPRBlxBARRdANuPZ/F/Hkp5XAbMbdu
X-MS-Exchange-AntiSpam-MessageData: nCPCOZuuU3b/hScG1E2faHG7EUgnNPRUr3UNQkBMSS403XfcXMK12lepgi1kkQjb6W2LQriSDBsc6QW5mglg/JN3kGB3AdROxAAMAZM00Rp9L6jO2G1667wI2MY9IFe53zacOJqfnFT0JUesEMLS6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f229220-5afd-405a-bf5a-08d7c9b0eb06
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:49:59.3278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZoFKwdsOqrPfRDKM6eS8hxdoV6kKZZXr+cU3RjR80RWNi+Tj71xeAsaPRqtG3v2ZxbEbG4tZJCtDsnv6qy5Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2363
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
This is enabled by default on Renoir but there's userspace/API support
to actually make use of this.

Since we're not passing this down through surface updates, let's
explicitly disable this for now.

This fixes "dcn20_program_front_end_for_ctx" warnings associated with
incorrect/unexpected programming sequences performed while this is
enabled.

[How]
Disable it at the topmost level in DM in case anyone tries to flip this
to enabled for any of the other ASICs like Navi10/14.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 914ab411955a..db578d8092d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3021,6 +3021,9 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	if (adev->asic_type != CHIP_CARRIZO && adev->asic_type != CHIP_STONEY)
 		dm->dc->debug.disable_stutter = amdgpu_pp_feature_mask & PP_STUTTER_MODE ? false : true;
 
+	/* No userspace support. */
+	dm->dc->debug.disable_tri_buf = true;
+
 	return 0;
 fail:
 	kfree(aencoder);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
