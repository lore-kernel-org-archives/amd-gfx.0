Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C0AC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DAFD206F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AEXO5ob4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAFD206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C20A6E962;
	Thu, 30 Jul 2020 19:12:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBF9E6E960
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAJrfCRj1rmb/EZzjglxyCm+M3IiRH6lyOyJebDgHEmOvLLsyLvLt8lFvkCZOwFscXhVRWOy9048Tch7li9eFiEhnk/jbYW4crJT4YEAFIeWVMOk8W1fsUUbm3S7/J7tbfdYTu4gSsyEYdnYdIPXKND+IZELRnFdVA//Hwk18X8b3n6XEGLwJX7uKmzGJq45Wneu6jr4RF2UPeF+JFsYVysZitDmfQYHbRtJQcyfRCnlrxc+sB9hVlGEk0xCnkWIjMtBWStcpjDdmhb5i5ebIHuVu64jdz/NIg/RTwCTOthFs2ZizD+ZBlVWd0vv6hEe/k+lYXdk6/L7llLMZDU40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1LWNuv5sLL5mYeT9MvccWxmFFC1mto5tZsXuBk/kns=;
 b=BNjm1lXvPY7NMRkDvrJS0QKva4OHqaLiM2Op4LlBOdXiVfrrIVKiEKFRNUz/l5P/OLYjFO/quV7+2olt6d9t9Tgk3EZEZZfzYjavyEdyg+dibDhXS+uCvLoV5rQdeb8kEfL6XkrSlbi22n0N48BbIAupgfjd0GuBJgZmtJwU8sABiLIZpgjgY+3ktgZ3LBMuo7Lq07MVRvUXVt1OqMNKpUSJsYFYTbTb2EeY4HDFIBELZkcPIQg0wDylDLoJ85VySBpuePokdpm5Ag/rNN8CIjWeww2Gbs0ZP+BBiiLL/oufWvqkvDfnssUhIFTyZDZ9ldKzxcwEjviBbTc3CIpUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1LWNuv5sLL5mYeT9MvccWxmFFC1mto5tZsXuBk/kns=;
 b=AEXO5ob4JyuoGHArRxmsWZEXcOY6LZVFT/Y4WFllFdzKqf+yI/1Ss8iP94VqhFB7IVXHUb4pOFirUAv8Qs2R2aATxf91AqCcrcvhpsHE7gsTxG/Yyu9TShoQBtdGbewkPcJD2GpQB9zrAPX+DQ2uq47rR5AtV+24OxyFV2n6aIw=
Received: from BN4PR12CA0023.namprd12.prod.outlook.com (2603:10b6:403:2::33)
 by SN1PR12MB2448.namprd12.prod.outlook.com (2603:10b6:802:28::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 30 Jul
 2020 19:12:43 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:2:cafe::8e) by BN4PR12CA0023.outlook.office365.com
 (2603:10b6:403:2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Thu, 30 Jul 2020 19:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.20 via Frontend Transport; Thu, 30 Jul 2020 19:12:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:42 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:42 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 14:12:36 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/16] drm/amd/display: 3.2.97
Date: Thu, 30 Jul 2020 15:11:46 -0400
Message-ID: <20200730191146.33112-17-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730191146.33112-1-aurabindo.pillai@amd.com>
References: <20200730191146.33112-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fcc6dfe-d263-4e70-a533-08d834bc8938
X-MS-TrafficTypeDiagnostic: SN1PR12MB2448:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24488133C1742391BC4551D98B710@SN1PR12MB2448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j7MgM7uBJq05teuTlXjb42I1FfPmisAwge2umiD7psdEU25SY6rFrviHQuopi/sFw1Pdhm5aLdXGyOE9FtV19c26EtEWzP5oiJvKT6/OH1f/EYb2T0ZtkmUEF9YYN5/IhM95FHifcE2erUe46OrdxY5RsERD6fImWbqWPbDtirkMpeKtA+056IzsS6ru0RMJA458t19SE4GnU9vnch3DaIVaB52kMdvBWD5Wc/dMav3TrxSqNbNqRNPOGIHPUW83h9PRA9j0fY0lh0VGU82yy8mbx8x8R2YeEaYIgRcsfkhuvDux1T0xhsR1u159tnd4Bdg3+44t2zbg1IS3aU8rYiDcdTlPtuGzGfjq9P7Xy9dLyAdW/04xiFEKciZ2g7ifTWEl0GWBF4PI2G1+nNXCeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966005)(5660300002)(316002)(54906003)(8936002)(36756003)(6916009)(83380400001)(6666004)(336012)(426003)(4326008)(44832011)(8676002)(2616005)(2906002)(47076004)(7696005)(70586007)(356005)(81166007)(1076003)(82310400002)(26005)(70206006)(186003)(478600001)(4744005)(86362001)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 19:12:43.3172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcc6dfe-d263-4e70-a533-08d834bc8938
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2448
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ae0e27c67ef9..6d4cab948607 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.96"
+#define DC_VER "3.2.97"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
