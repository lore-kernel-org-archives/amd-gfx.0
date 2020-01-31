Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED68C35240
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D737920CC7
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zgcdZz9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D737920CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A2A6FC31;
	Fri, 31 Jan 2020 22:17:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B93056FC32
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAaq1cBqPyWDSRmrjaI3XHzGA2zvu9VvsCgO0VBGuEbBCCo0GVwagD43ow5/HV1y7nCtX4xKzn7w2p1RawdKTY7Dv94SoZOaGBD2MyLDqCYpb0ooxG4j7v4Ny/TdMvh0b+87/yn0fDvpnBNarnmtbk2KlbTFiqSRlwDpxML+AfZ5D+RKL6Hdxv6vjcjW70gNqZt3mSK+NWle+T+pSmFpdpOY/iosilBMGvUnhyb007YatmfZpb+ZMZX5+sVxXwe4+v2p3sExjehK8m8WiMIaphQxaLP7dwPC/RK3xOxkOGjKVvljdgl6EzYAvTxqghFMp2NWN1loJrM8DHFz9P6Psg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlVq5msc6rg/jTRBj/rUyAU6ZkuOthr6LkD/ufsOmzc=;
 b=ToMoUEf9P1sUNdjIy123/YheLZmQ4+IaefEDll8s8iZiijpI0F4kBWZavW8ioSkIBAgOQoBDsiIDzQHmf0s2HZoNR2JLxANldFARiUK4S+MHC916iP60AlDa+I23cV5b5wizTpJUtirMIBDmrKFflE5L58t4AgfgSvloXhLYxQgTjebabsKOIUyh8+SUm8lxx4LnYkdem87UW2jb3KH0r0/BD4TeEVTxRX60YNaiLTjTXS2eJDGLwcFGUtBS46mB3/HD6N0VFBBsrepiJAmiSPPs6ufKhsc+FegEARWKhbQLqQOfYyV6At3aHoIODCufcgyN9aso+ffbIf+7YoUzoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlVq5msc6rg/jTRBj/rUyAU6ZkuOthr6LkD/ufsOmzc=;
 b=zgcdZz9ZbmTYqBib8UlDMhimX5WLeobw0/4H9O7ZxnVFgj6ADcObdZ3kgsrVDTri5FJoeQBclycZwCGAuTJY7zd5iRgoOls/Qlfn36VaSlGTB2a6aZQ4KksjUMAHHc5UW0OSDxqAUqpFdziet45FuzQCE1bBPZ5qyHCHtM01n8U=
Received: from BN6PR1201CA0019.namprd12.prod.outlook.com
 (2603:10b6:405:4c::29) by BN6PR12MB1202.namprd12.prod.outlook.com
 (2603:10b6:404:1c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22; Fri, 31 Jan
 2020 22:17:04 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::203) by BN6PR1201CA0019.outlook.office365.com
 (2603:10b6:405:4c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:03 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:02 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:02 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:02 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/33] drm/amd/display: Do not set optimized_require to false
 after plane disable
Date: Fri, 31 Jan 2020 17:16:15 -0500
Message-ID: <20200131221643.10035-6-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(428003)(199004)(189003)(26005)(186003)(7696005)(70206006)(86362001)(6666004)(316002)(356004)(54906003)(4326008)(70586007)(1076003)(5660300002)(81166006)(2616005)(426003)(36756003)(81156014)(8676002)(336012)(2906002)(6916009)(478600001)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1202; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b409dead-428f-424d-8bdd-08d7a69b4ce6
X-MS-TrafficTypeDiagnostic: BN6PR12MB1202:
X-Microsoft-Antispam-PRVS: <BN6PR12MB120264D9FE55A60519AF6646F9070@BN6PR12MB1202.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgkUeu+9OVORfyFgsPangysLxZR+muMVu0hA22khplRNx06UBdu9DL655xPVhPmL6vHC5oooUJL0KaAQozqIzCWy0KhjwmupR49fbUDUTxJW3oyECGPkOSAdRNWJ8sCbpoyChOtdMTs9FVbjIyD+Rg6V32VCIBSBMCNT1ugjWVfh8Qg/6nW2teURI134nKEYU9tRgO05Z3Y1RV/HJHTtiN5R1B9+xyDD6Y/H/kz7oQGfFb037xXbnKTToo6tmJ74Syicce2EAOX2IGQwyk35R8Cl9jVGLwTfpMKPF59OMd118/ZCT6Ygokw/ihjHpvkK2YEPt5ZcXEPrcqh7Gx3wBMPGdhC5mzsBrm6x+gnZ158pTx/tjwVp/1nV7NYG8RtcWxcqmBT5i71ftLc3+6fhgTZoEdGkTXqNrqMGe+J1/cj5xwDjkghBheV/qsSrN9Cm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:03.6113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b409dead-428f-424d-8bdd-08d7a69b4ce6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1202
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, Sung Lee <sung.lee@amd.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
The optimized_require flag is needed to set watermarks and clocks lower
in certain conditions. This flag is set to true and then set to false
while programming front end in dcn20.

[HOW]
Do not set the flag to false while disabling plane.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index cfbbaffa8654..a444fed94184 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -572,7 +572,6 @@ void dcn20_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	dpp->funcs->dpp_dppclk_control(dpp, false, false);
 
 	hubp->power_gated = true;
-	dc->optimized_required = false; /* We're powering off, no need to optimize */
 
 	hws->funcs.plane_atomic_power_down(dc,
 			pipe_ctx->plane_res.dpp,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
