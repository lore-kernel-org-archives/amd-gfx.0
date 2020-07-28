Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FB2C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 05:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AEE520759
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 05:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zzMaDe4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEE520759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D9786E17E;
	Tue, 28 Jul 2020 05:27:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51A166E17E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 05:27:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4oMs7fiibyYHPOamOhSJsVaMdFeUv2sXCxz2WiqgWBXwWib6I1TlCU+aLKhwRpr4yynul7tm7QCsetum9Rfkk3bHcYhp2OedwGCcM95hGFEjMHKWWor71Spi51jIh15KhJ2Tzws5aBHw4rLAE7A98Huy5JvZXpMStY72DNGvutC22wJboc/jWrNDfC1FFbTJJ1k7cOkky0q0hqXEtE0LAUrkLwFnbuuq7X+45mTVY00BqcAqdtvrdFR1Xvk2ZG4JjYX+ij48T9T6I4/NALTuGsbyCSQMVCX5Qx3pknBuLXgOUL1DLJij7fEkmdwN/kSD3nvJBMNRHhcac7vj6TNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUU0qguvmt4HJSzw9UhJJZbowmMzloAz1FA/Jj3taps=;
 b=IviYJnxeP5YvVl8DlfpB9IwK2TFaT3VXIcGYZGU4TODc+RlRLOMnEL5F5547NuwoPD/ezKr5LGOewfZbs7QeQNFjsd/ZBH8nla6lee8HD41C7rcgBQvIotQh5T3oE1aNQ9imoPleXD6EKOlDQwgYItkGpnX9jo8KnMxIX8FPZkdgVZQqqWuC74RPIpr1SGYYg12qOHHdaVreQ8VB1QD5evTZ/1ymeNnbFOIUspHXEnpUj2+/jiFjY0qjDVdxDhUm7w3UqKx7+O8gzIKt0/K/GGw6dqPQDHl6VCNhhcFM7/yeUN6+6MJDHqLz83IJVbegkTYozom1L4jSOI4gtjXm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUU0qguvmt4HJSzw9UhJJZbowmMzloAz1FA/Jj3taps=;
 b=zzMaDe4SffO60Yv6OJ3ctC6AZ2hRvdGMmMGmYpP3SweCwmZp434qSIwb4qMt6c/5fcD/S7EgHoTBxCmr2/i61ub8JOYnj2JzdIt2S1PXXz+EfYIrYSreRA4lB3YRMJuBlnv7kx+y4u+MIjOvD9nDCsDar6qeZZupj3cMtHHbFoM=
Received: from BN8PR04CA0037.namprd04.prod.outlook.com (2603:10b6:408:d4::11)
 by DM6PR12MB3372.namprd12.prod.outlook.com (2603:10b6:5:11b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 05:27:28 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::45) by BN8PR04CA0037.outlook.office365.com
 (2603:10b6:408:d4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Tue, 28 Jul 2020 05:27:28 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Tue, 28 Jul 2020 05:27:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 00:27:26 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 00:27:25 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 28 Jul 2020 00:27:23 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x
 after GFXOFF exit
Date: Tue, 28 Jul 2020 13:27:17 +0800
Message-ID: <20200728052717.21071-2-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728052717.21071-1-tianci.yin@amd.com>
References: <20200728052717.21071-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c32b3852-146b-44a8-a57f-08d832b6ea1c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3372:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3372F1944E8B0B47F63278DB95730@DM6PR12MB3372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CnzdEkXvRAItWVRKBcsbmYuyqo7AyjEUP2mr1jiQlVpCAKivAkfx4X+DneGQFuqqTu7glS/Y8wA3Lmk1vNJRePqVlvsamF8/GTfS6lUBfwahT1TeRMFJH0LtcxXZx44Ag5WVRpr2FRK1KJk1uZFzAeAMd8aysPLlvVUA9/UqLBWVRJmiMJVpt+J8aSwWhRGkFYk2Mrxqx3cZHSEBrsn8pzsQ17idGsRmihaILGka/MREBYhfYyqHWoYceuEhYhDhQqDZwn5cjH2Jn6Mosge7qleSZ7i5QAuheZhrm/2wI10Hts5gLLz7/M61NBXL4451L7lg8LTliedGCggiXBCDyJYuwqOn2BrStGsMpTpXnlD0/jHe2texAwc+oztAsYbO3/mrzGFO2fen6zjPGClHYOo5Wtt0y78lt7FDIhOh/qE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966005)(336012)(47076004)(356005)(5660300002)(81166007)(54906003)(86362001)(44832011)(2616005)(82740400003)(8676002)(8936002)(82310400002)(6666004)(36756003)(7696005)(70586007)(26005)(4326008)(186003)(426003)(6916009)(1076003)(83380400001)(2906002)(70206006)(316002)(478600001)(32563001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 05:27:26.5398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c32b3852-146b-44a8-a57f-08d832b6ea1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3372
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Tianci Yin <tianci.yin@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Hesik Christopher <Christopher.Hesik@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Swamy
 Manjunatha <Manjunatha.Swamy@amd.com>, Evan Quan <evan.quan@amd.com>, Feng
 Kenneth <Kenneth.Feng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

On Navi1x, the SPM golden settings will be lost after GFXOFF enter/exit,
reconfigure the golden settings after GFXOFF exit.

Change-Id: I9358ba9c65f241c36f8a35916170b19535148ee9
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 55463e7a11e2..5da0436d41e0 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1309,6 +1309,7 @@ static int smu_enable_umd_pstate(void *handle,
 
 	struct smu_context *smu = (struct smu_context*)(handle);
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
+	struct amdgpu_device *adev = smu->adev;
 
 	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
 		return -EINVAL;
@@ -1324,6 +1325,16 @@ static int smu_enable_umd_pstate(void *handle,
 			amdgpu_device_ip_set_clockgating_state(smu->adev,
 							       AMD_IP_BLOCK_TYPE_GFX,
 							       AMD_CG_STATE_UNGATE);
+
+			if (adev->asic_type >= CHIP_NAVI10 &&
+			    adev->asic_type <= CHIP_NAVI12 &&
+			    (adev->pm.pp_feature & PP_GFXOFF_MASK)) {
+				if (adev->gfx.funcs->init_spm_golden) {
+					dev_dbg(adev->dev,"GFXOFF exited, re-init SPM golden settings\n");
+					amdgpu_gfx_init_spm_golden(adev);
+				} else
+					dev_warn(adev->dev,"Callback init_spm_golden is NULL\n");
+			}
 		}
 	} else {
 		/* exit umd pstate, restore level, enable gfx cg*/
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
