Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DABC47257
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F11B12072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sXVT3qXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11B12072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8F3E6E1E0;
	Sat,  2 May 2020 21:35:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F6B86E1D6
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:35:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7uUMUDUWOhklHCKVPw34NLT57CDfgCYW/M46D6Jng1IN7TNoDwid0JI23A8V6/xAv2fzSuCzgi8l+UqljrU6y3P8/ZyKaBScfAnKyaCGYuqy5ebbaUWZ9n1a8QHweR9EtJXPOGRrVxmIxTy2wJaYLgH4ZTMsKFXrA/pLr0gj2wY3+Hdtde2qD9wLinq5IJPGCeUPM/CCzwSkqbZr+ORAGqL+CPmFm+zWnquZxoXCQL6PZA3KmZk7S5xavaDFMwcHTAjW125Ip3lBHL09jWk0/TESGbXG2gIn5tSfGErFlkxKJQUvgY7JtnllgNQYriSiUrI8nLIFDyZ2QlVnDmLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqD0ImQH0+VJjq1I1Oa4Vg/pXlXYLTmu1pzDDscyLJc=;
 b=TV4HNrk6yz84oXMVLi/HzuF1dscPTSQH9Bs7ZwO+JMYGFDQRzfyfeYHzM/nkImnSc3wpfeMLhtwOmEteXlN54ynHbItFbG5kSbLXGr0shREV4HkduP4RflSDhCl8r3+XkJcdfKKLM5cJmE+Mq4bGcrdObIlN0lfFC4k/1rEku/P+mHYpmcIyCE4UsOgJZjBRRxPu2lQ3nZ/Pqvm9Zq47V+TUgkwzbw6YJdYolXeY6lCtjoe7Q6xZaCHPKVt1AgvgJRGQGAzWXpmL2+OIEK7o2bcmXRuBmWOS9DiTeZjYQ9pFNfrle8WJQkDN3+7TW9n7EAn74vbYcvNkzeDbnldcqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqD0ImQH0+VJjq1I1Oa4Vg/pXlXYLTmu1pzDDscyLJc=;
 b=sXVT3qXoLYNgGZoRgfacw1bhk41bx0iYVy8/Zp7vi16iIcBbv4fH2FF6I0KDWSuCKwFrb2K+bTwebc+0/qjv91+OBKsceobfivFiprryQypR7op0h4LbQYvVm8AK5SjmeVH0O+v5rFKz7gnzVzE5qSk906uSLk+DgFtuJ+5WTz8=
Received: from MWHPR11CA0030.namprd11.prod.outlook.com (2603:10b6:300:115::16)
 by MWHPR12MB1760.namprd12.prod.outlook.com (2603:10b6:300:112::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Sat, 2 May
 2020 21:35:13 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::86) by MWHPR11CA0030.outlook.office365.com
 (2603:10b6:300:115::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 21:35:13 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:35:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:35:11 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:35:11 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:35:11 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/16] drm/amd/display: Add struct field for future use
Date: Sat, 2 May 2020 17:34:43 -0400
Message-ID: <20200502213443.39232-18-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502213443.39232-1-aurabindo.pillai@amd.com>
References: <20200502213443.39232-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966005)(70586007)(70206006)(8676002)(54906003)(7696005)(316002)(478600001)(82740400003)(186003)(356005)(82310400002)(8936002)(26005)(36756003)(47076004)(81166007)(6666004)(4744005)(44832011)(5660300002)(6916009)(336012)(426003)(1076003)(2616005)(2906002)(4326008)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86bb9a59-9346-498e-8393-08d7eee0b25d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1760:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1760621100400A1330F91A5B8BA80@MWHPR12MB1760.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdpM7UQ2zoI96VxZGoLnVKDQQFL8id+dkGSyJRyfDmH1GKZ+aRD6W473Jn7jgTaAMgUOxpGFTOmioko0sfh+gbIViphXPgZ1Wkv0800IPV7kVy8HpdHQxDWj8BqgrfY6ASWEw6ffGHtvJ93hVmVVTUFoU3XK3ycNHY0Fxtdd91DIimmdmPvrjKCfbCQs2kpW3d3eSy+Lb9ETi/TnoHifLojiAZBm313yacIPjbFYkd6HzTxo0xpwNkuJtJ5RqaiS0n5Mvc/xtEq66s7CUx9JB7W4d0DXt4I+6UdjTHDe6qdSx5UjD54+dGCPDViGRJn9ixgCmipKttk+RaE+L2Dp/bnOkNeFMZBDwom0idkZD9ORk+yxvpzbhPEbonfNioLk3HPxjtgkTArGWQHJLO2fCExOJNvgzp2fmirlO6iNPjJOW2oKAXr3Uv+Zm1KjgQTNTeiOTiJ4qqI6j8mfnybmrYZBEocMF8SPMVH9BtiVViFc2dIfcGVtmCoZ7FGqWo1xDjESvKfkAKAH6rVeAHlwgw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:35:12.7073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bb9a59-9346-498e-8393-08d7eee0b25d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1760
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Add dmub related struct field for future use.

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index eb10518dc058..599bf2055bcb 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -262,6 +262,7 @@ struct dmub_cmd_abm_set_pipe_data {
 	uint32_t ramping_boundary;
 	uint32_t otg_inst;
 	uint32_t panel_inst;
+	uint32_t set_pipe_option;
 };
 
 struct dmub_rb_cmd_abm_set_pipe {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
