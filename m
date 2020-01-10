Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4655DC33CA3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC372082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M6ZtNs3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC372082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFFF66EA4C;
	Fri, 10 Jan 2020 14:47:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770087.outbound.protection.outlook.com [40.107.77.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51AFA6EA4C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLpSLY8ZVfWAzJNBs5wNVOPoSljfuUzaNJ0fT/qPDzWbjnyEIM7ozqjDPQdmmE2HHI0tdMnzi513FpFmvbVwe10vpigcdSRSK0aMB6CGm6ZF/ZmFqo0s6bHbGOSTf0JRyMOalpkToU+EqpkaievStk0dP4ODRsePMor7pov0OTfnC+YnSRJojtH30SIMouiCjOC1D4xK2jjl+21QyN80LBm1gBwU63g/P1+Pe6qbN6PDTov1tcGmyj/rrT307oa+OprYxi/F2jxGavkajfx8x8Gta0ZUjPbKCRElNBOojUsjXT6SbjBlYROzfAtkHuWIaum0Sm5JdB5/sfxOZVmnBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NXvACt8b9hAwynVJ+h+6hbn6HMOZpevUMnF0NeLnl8=;
 b=d/zAj7dbZKJjNXxp+Q8NK+3jZRViBQ21/zazM+gmTy9Cx5lHaqmCEMYrxTWF5hdw5jo0Ih3/5SyQgaEeiLnJxEjPNQCoIOUhET1hqkpFwbAAbOtVBXRw/lXU7qaHFDr1XeusskHyJgg2t2S+ZhrFygUKq6Fh+dvW/JxNbQUs8m6B5GqjXEOiIQ8KsXWqsIS0205C26QBQLFdq/JDFeb1lGD/jG95h7L5X3ykms+I++6eQDnDx7z4STbcDoZPdLiO0HEzN4p1mGULW5iVnDbfS8tLNNb41hLSzc7qX6TlTTiPQqgVZ20PPSDTRKuLHnyT/zqBjc8LmCLF6k2PgyjuAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NXvACt8b9hAwynVJ+h+6hbn6HMOZpevUMnF0NeLnl8=;
 b=M6ZtNs3L7qBrwPzrubOrpu7Iz42j/lcC8wfEEFb7IM8wggn80PrZ32+p6iI6yC1YdX2sVS6W6PSE3496CDtDVzQ53mQ+Gbnt8uLG5LytXW3sT2noyBWJWte/9gViAFjzEpOG9mXUx+cFUkg5/22kPbhaw6AkMZIqFNudHEXb9sE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2378.namprd12.prod.outlook.com (52.132.183.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 14:47:46 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:46 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/43] drm/amd/display: Use SMU ClockTable Values for DML
 Calculations
Date: Fri, 10 Jan 2020 09:46:41 -0500
Message-Id: <20200110144655.55845-30-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:45 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3eee734a-6c8b-4e0a-9cda-08d795dc0e6c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:|MW2PR12MB2378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23782CD677CD86690B26F02898380@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(54906003)(52116002)(8676002)(81166006)(81156014)(86362001)(478600001)(7696005)(6916009)(26005)(2906002)(316002)(8936002)(16526019)(186003)(66556008)(4326008)(6666004)(6486002)(36756003)(66476007)(5660300002)(956004)(2616005)(66946007)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2378;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 68xEEuDJAv9fEVrHwIW274gdJfb5I4mZpV4Ca8z5QxPqY3o8z/jbHtJhTj9I9OtpRx/+jAI9m6KiS/IIbrodz6BuQL/eFlE01bZNogN8HrvZsh6yr06COG97NL+V8Zq5qr/l7IzbXxiHNYg4NF7pXfIpD2Peywjk3C4pt5u9l5CdgVbKbP0UO+Rv4AhA9T66Z32bVJteV49IhzRcs5i8q0tvOlDX66EVkzYQbZpr4eWSzU/Mw9+hM6+9dFS8by3NhHcqkek9qPt/w0D3JjI1axx/8wFv43ZWvGejaKkdPfhXdEbElVJAqfrNWduzN06cVEQJ+q5XOK7Eo5cTjshJE/40Ojjj/WAFARZFAc2boybnPp7mMP1BvsvM35Fa1h2LExztDtWccE6eFETkYWdCjSevBH17pvBzyhWlXKUnxr3BOkvymwKGg4CrKDBVhAUT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eee734a-6c8b-4e0a-9cda-08d795dc0e6c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:46.5026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Q2NTKeW1krnF4zUzpLOKCX3QAw7AU/FHR3u9Xyr7ZfnjXE3x7XTt8Zu0d73a2M9DvWwj/VKmvQu+TfgYGzYKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Sung Lee <sung.lee@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Tony Cheng <Tony.Cheng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[Why]
DML Initialization was previously done on dcn21_resource initialization.
This meant that DML soc struct was populated with hardcoded values.

[How]
Move DML initialization to after updating bounding box, to use clock table
values from SMU.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 0c02120311b6..1d741bca2211 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1349,6 +1349,10 @@ static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	}
 	dcn2_1_soc.clock_limits[i] = dcn2_1_soc.clock_limits[i - 1];
 	dcn2_1_soc.num_states = i;
+
+	// diags does not retrieve proper values from SMU, do not update DML instance for diags
+	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) && !IS_DIAG_DC(dc->ctx->dce_environment))
+		dml_init_instance(&dc->dml, &dcn2_1_soc, &dcn2_1_ip, DML_PROJECT_DCN21);
 }
 
 /* Temporary Place holder until we can get them from fuse */
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
