Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26A8C38A29
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AD321841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mwVYzHVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AD321841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D71E890F5;
	Thu, 16 Apr 2020 23:41:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8AF86E271
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnCXwE34XfTat+fWgVyRPciziXLDjQq/0bxbbjPcqTh7SmVAelkAhHNYSvJ4gMuNMwFEuix6hPq7Nln5DIrjt+vE+Vb8gzD8TT32PSOi1pyT1E3lIGnbzfi8HkGhdYiBQ2u3D/MMMntbImrJw7+gLIDKnWwU2T79DqNdXhBgfhNq08K5gEdPfA4dKBE67SaVuQY4kf8XS62g5rPVDQCPkW449jwRzZm01C6vPVP4Jxp+9tl4cNNqHkc9urgukNT7w85/JBVriuIRFQLCD+Eq53wr+LOgXOHUSE6Ik3kBZ4Mdy7UVRtMXZNQldFJERuz0BWXiO9eRlzzAveihiQCRHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2bDzvvyoZMA6Uz6iKYU7ARPjEf4PWisA08JsWApOZc=;
 b=nQZ4SlJq6ZYKLz+4qS96Sh4MlIsaUa1R3vgC7X0SJsOYPcVXNgTQKVIaOCura3K0z/32xdexNubnmQ6FGMPdgMK77cj/syWlJYyLykRJmlDIq+hucjWzFg7K3EL2FTV4JdIlI4vn4Z8asIqritw+ESLCz3bGloNY86z8au62rWkFfxB2hwc26f85ySJXi4IyH1VRADXmi8mvHNryZMnp1tMIrV1BmJfOfBUvGVAS3tJFSrvYyvY9xLR8TgEhh4hCHAoh7y+BYx/EuMwngfQjpevvhVx9k89kXeGd6omo7krS3/Hk2JFouQGofr21xxZ10UWfiJbsxnIJogT+yypbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2bDzvvyoZMA6Uz6iKYU7ARPjEf4PWisA08JsWApOZc=;
 b=mwVYzHVEqRZIwxcv9kgPjCtd5VDPIAyWzDC3NBAB22suhWKMZxUpEftvSg+lypR0vzWNmQiSvU+0ehy4+5UNf2CCmmz/xOY78JzMVmVCtPrIEUv+Q7H8dhbJUGrFpqlUrYHllUZf1Arz2La6VEbiQpbm+uCfmAZHdzYoarNZraA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:25 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:25 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/35] drm/amd/display: Set meta_chunk_value to 0 in DML if
 DCC disabled in DCN2.1
Date: Thu, 16 Apr 2020 19:40:21 -0400
Message-Id: <20200416234044.2082886-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:24 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d58abaf-c8b8-4020-7802-08d7e25fad3e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2459DC2FEA8ACAFE982B897F98D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3rxiaqT7i89ViscqpkUXw/gUJ5iiJUae94OYJ5QYbW3Tt9MD5A0NaKglR7c604+4rJfI1zoZoL1RFhih5WrVFA1UFnAyRWTrWn6FAOWpH8H4NKT0UbcjVaMzkfmFiotgulO87i5shKaxLorBoqQH2xQzkgj8qBcguGnt4JY+TkidNfJgV5lzAuXooNp0y2ULj+wSjYWO9WZUSDt1oBTxjS4treebta0iGYSk+pULHZf9joCbmliiqAJ/Slcs6wCX1dDuQzRuQt7SFME6DuHITIU/fiSwyLBoh/R0tXmdZsm/CM4VAKmLlLUsbCINQgtaLoPkfRWxB90b0fAK250yZ6K3/x6XJp/VPqtpTvSUlBUj5EMLx4nukYxHaYnw/UKHezhFodNmv9bhA4XfylUeE/2nJLrE3s3+Zn4yFQToXdZfnM1YihTyCpdLVkzCWCM
X-MS-Exchange-AntiSpam-MessageData: 0Mofpw1mNYUVeR7vSHBqCI0irYD4huqWanzOFBSxHWp5SRxd2/KWjtTN6thWHMYEoAcNmyPmo+KsFn6YidEZc/QBHC8kMluyGn7MUCRArxWuhrDXBCT3fPtVbF7HxpEidHMgytIo2N97U2IwGVlhzkusgZjEY9a3kVnzsCD6BJQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d58abaf-c8b8-4020-7802-08d7e25fad3e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:25.5105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjbhWQLtlrvtJETp7qWUGB6K4T9LSnYS6tFtI3qutUI4SWl2KJj9wEHM6C3drot80TjYGvNK289xoUpFfjKHvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Sung Lee <sung.lee@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]:
Calculating refcyc_per_meta_chunk_vblank_l when DCC is disabled may lead
to a large number causing an assert to get hit. In VBA, this value is 0
when DCC is disabled.

[HOW]:
Set value to 0 to avoid hitting the assert.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c    | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index a38baa73d484..5430ced02bac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -1500,9 +1500,12 @@ static void dml_rq_dlg_get_dlg_params(
 				< (unsigned int)dml_pow(2, 13));
 	}
 
-	disp_dlg_regs->refcyc_per_meta_chunk_vblank_l =
+	if (src->dcc)
+		disp_dlg_regs->refcyc_per_meta_chunk_vblank_l =
 			(unsigned int) (dst_y_per_row_vblank * (double) htotal
 					* ref_freq_to_pix_freq / (double) meta_chunks_per_row_ub_l);
+	else
+		disp_dlg_regs->refcyc_per_meta_chunk_vblank_l = 0;
 	ASSERT(disp_dlg_regs->refcyc_per_meta_chunk_vblank_l < (unsigned int)dml_pow(2, 13));
 
 	disp_dlg_regs->refcyc_per_meta_chunk_vblank_c =
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
