Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36984C55178
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEAF9206A5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TN+6ShU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAF9206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C1786EB52;
	Fri,  6 Nov 2020 23:19:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16B196EB53
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 23:19:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCGWlmxj9f4Zltf7E0DFxCOtYPc1frj90DliFgaO0tTNmXl5YdbsW1Kas2JoQYpGV51iJhWE2bTHrKo+r0xKPJPaegE8PRjqw7MUgDSrYvNA8JbiZsYVuLv5BudX/9J40D5EopizPaFS0V344BDFpJeC0b5qfV/vyUYjlq8Q1Truj3RU7NiAxYAq451spGBnOK+hQjat7DyzB/G8mzV2l11bBYZZLyBMwda+gi+JmhS59FHAriay9qyS6JO6WNP8rH5BZ+5n6REjEdhGxObdfp5uCAoZNef45Z8uH0PhtSU3jhoANg/aVKJmLNCtDWLSREWCHX6GvVV/9kq1pXoZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXz9gQBT6B8vQcVqrmYO7uym4xq+xDW1POza8DoRgMI=;
 b=MLdlbKMMg0KwxuIJHxtb83DgZcVzY3UTlCgWdNLGU3nvF2whPL44IawqLo4HErfnhzv+iJcOcOumtnbeNXok+WAQXfNKf9HZo6dJ9TiRiixGTl2yYRh5VXRjE3MYLNixY68B645U1PKEXM3zKaLuVoflkNymerFavZ3s+11JqNi6NhGxZYl3ekjCjjbHryy2xBTszyoNj+1kuOoXpXebCBpwXiBzb3RnlFYiotYR1Z55P61dypCnrBemAN++4p4qPnlTIZLHM6fT8BgV3it0fyH+swrXg+knPyn3b6NylzTk+b6+UnqymWTkC7WgMIARseRTkmbIfymxp+LkMNdKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXz9gQBT6B8vQcVqrmYO7uym4xq+xDW1POza8DoRgMI=;
 b=TN+6ShU29Xx7gcknCSqt3gPZQfHft/MIJPB0+zDwFEPL8sCuPt4EcV2OC5jeXpUCD/qyvszA74TIOhtNnJrf9+XUJfIThkNLfR7h44U/6djxOEVX79nHpF5YAHG3jlnu+I8QyzmdsjY6CIJ4BTKg7ID6on3KA55T5F8mYZBCs9U=
Received: from CO1PR15CA0091.namprd15.prod.outlook.com (2603:10b6:101:21::11)
 by BYAPR12MB4726.namprd12.prod.outlook.com (2603:10b6:a03:98::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 6 Nov
 2020 23:19:23 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::70) by CO1PR15CA0091.outlook.office365.com
 (2603:10b6:101:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 6 Nov 2020 23:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 6 Nov 2020 23:19:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:19 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:19 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 6 Nov 2020 17:19:18 -0600
From: Bindu R <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/14] drm/amd/display: correct dml dsc bpc assignment
Date: Fri, 6 Nov 2020 18:17:00 -0500
Message-ID: <20201106231710.1290392-5-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106231710.1290392-1-bindu.r@amd.com>
References: <20201106231710.1290392-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d40b226a-38b8-4ca7-545c-08d882aa6438
X-MS-TrafficTypeDiagnostic: BYAPR12MB4726:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4726786C11E7D5B056CE5E88F5ED0@BYAPR12MB4726.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: waLTODe/3+Av26wWaHZ9nL5BOBSEhM1nHZsAwvMiq3GgvGMcEgKlIoOKuiiTJFpa+LPNCCS8Gs8tZv5cWwQwqv+HxgxszyVbHdBzuL/195KOhE828lVFB5MFyVCokPKPJIJTI4ndNz2kGdsSHpraNc6B6EDTXbLtZkvK1vNORCfS/9vy6AIFNDXRELnamvX3D/M4OPbWGkYdpXvoSR7BECSXo2PAcRxxiEzdr4CZ7+uUcjqLM7KeYddBKrRyJdf2pv7bMX2eI/BuawtK0Oz16Lt6q22AUHtwsNz67OwbSc3qtQmo5e0mt/2xqD5mPb2WMwbN8oL1xJz32+lzt/HB2lW0XYuofg7e37zzVU7Gr0lkSWI6PpIhiakL26D3ELG0r2828oeE0hv/K5krcN5+QQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966005)(82740400003)(47076004)(1076003)(6916009)(83380400001)(8676002)(426003)(336012)(478600001)(186003)(70206006)(81166007)(82310400003)(8936002)(70586007)(356005)(316002)(2906002)(26005)(4326008)(5660300002)(7696005)(54906003)(2616005)(36756003)(6666004)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 23:19:20.8390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d40b226a-38b8-4ca7-545c-08d882aa6438
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4726
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index b32093136089..0fa489f9cb7f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -471,8 +471,7 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		mode_lib->vba.DSCEnable[mode_lib->vba.NumberOfActivePlanes] = dout->dsc_enable;
 		mode_lib->vba.NumberOfDSCSlices[mode_lib->vba.NumberOfActivePlanes] =
 				dout->dsc_slices;
-		mode_lib->vba.DSCInputBitPerComponent[mode_lib->vba.NumberOfActivePlanes] =
-				dout->output_bpc == 0 ? 12 : dout->output_bpc;
+		mode_lib->vba.DSCInputBitPerComponent[mode_lib->vba.NumberOfActivePlanes] = dout->output_bpc;
 		mode_lib->vba.WritebackEnable[mode_lib->vba.NumberOfActivePlanes] = dout->wb_enable;
 		mode_lib->vba.ActiveWritebacksPerPlane[mode_lib->vba.NumberOfActivePlanes] =
 				dout->num_active_wb;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
