Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CE9C55185
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6DF02071C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NnMhI4/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DF02071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6A196E134;
	Wed, 22 Apr 2020 22:08:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FF4B6E134
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPQvm430Yuc22i/crfOye5a9P/vPJxVB/ecZhzU5Jhzq59mv6+tB2y5HUZUyo72qV7/l5orOXZAvMHD01vn8nj9pFfiE4AK2Ejev3/2TAo0dlcZQjHHWANyZ3eaFvUW0kSDdYMJ2180o5a4R5eYbpJ5NXUImq8/tRmYuasO2I4NJsZLw8ODlYkRbtAI02+2+rMZ02AjpR9Jv5i4I2rxfrcnFxzYs8C/bNzvGukf3qHnsAhD4kTx8yS9KLvdclRvKPfO5dfOcHN/YrnwajCvJSXTWrXwJz4NtFVgQnDW7pFcU46n7V5VVXHz1vKkMxPRT9X2nD4EgkRJBQ9oNXYdwqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAd2EPK8/nWLD4OI13JIhuzhDALgeY+0FakKrp5OcnY=;
 b=m8OX3Q0FLTNf6Em3y7oXewjT8G4YzSl65OCwBzif0SdwKThQtukFzQ/eNpYgNM55CF8ekGWkf/lWm/PNpzvK2WRAHbAzYgYldXrYhDsEHAVsoUnF0UYB+nT4DUIihiZzt7xdS/EgsYPLopwezS5zcMqHllEzZIKPAEFAAYP0OErT5ENHcsZztt6+Vn0LWvky79cfG3kS68vYDTXeEQCCRTa3rqT6Hg+W06LbTfiUP3hGsVPg/H3vErC0QnGa9kD459MoWhtEz4+BcOjxV/Ks9DcQavYf2vEqdGpRzmOZLVp5NTSLs93oHBkz5RH2F3VHb2BgUwBMS7m5SGyBZo5+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAd2EPK8/nWLD4OI13JIhuzhDALgeY+0FakKrp5OcnY=;
 b=NnMhI4/H9CtMWVkd/vEH+JB9WxXbTeQW79oLQsXPmXDOCE+Xq6K1K6wLkxrhp/i0rdAvlHv0X601lNmX2ZFORm4vqKHz0LQUOuFxAhmyLWbPZYnCN8pMkSekFwZtaiuB389s8/NBvqVIIe6zE41JU5awnSS1zYwQecDLOhaZEd8=
Received: from MWHPR20CA0011.namprd20.prod.outlook.com (2603:10b6:300:13d::21)
 by CY4PR1201MB0263.namprd12.prod.outlook.com (2603:10b6:910:18::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 22 Apr
 2020 22:08:34 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::20) by MWHPR20CA0011.outlook.office365.com
 (2603:10b6:300:13d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:34 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:32 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:32 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:31 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/19] drm/amd/display: 3.2.83
Date: Wed, 22 Apr 2020 18:08:04 -0400
Message-ID: <20200422220805.15759-19-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(428003)(46966005)(2616005)(86362001)(6916009)(47076004)(44832011)(82740400003)(81166007)(356005)(82310400002)(2906002)(1076003)(70206006)(8676002)(4744005)(4326008)(6666004)(70586007)(336012)(54906003)(81156014)(426003)(5660300002)(186003)(8936002)(26005)(7696005)(478600001)(36756003)(316002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df8426ee-14a6-439c-050a-08d7e709b2d3
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0263:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB026335DBF989AC8BC34952D98BD20@CY4PR1201MB0263.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYDKiq8v+/fUCXhCNCdudvANpcseXPg4xUzxrtbza2YG/ouF/32U0XRCyNSiQ+lhJ2FYtPJlnBkXVQ+oZLAJ0XKFsvmlXbw8mD/m5OomQ2MHt+nw5dPHxM2MQfphW1U9VBqIuMMkYjPLYQZOZFTXWymnJFWb5u44sPExbMHH+4LZWXwRQg8UYFBXvPbDXxOzO4pz4krs3YR/UckaVXQO5gkHTa17IhKJB8hvTvvj7gv4gTYvs3f156Y4Oq0WiNcpFJ81ozhoLd/npkNfknK7tdDztLyyF4VPvOn/RFWOgjH8wV6th0fTf0mQ9LK2C9YVvG+WmiPNN9yiIhVyrxbvtEpW5NKgT05gqXQTGba6KTTFkBbJ+gCZd8To+fyrZdVZmMKt0GxrSy2gB4U6uuuaPszgxp+S+7RjpFaB67+EyGfgH0ve/JB5iKOeeysNYUOYNiOGde0BwplCIP80w/0VyC1/BDXXN7TbcpkrWtFHnKFtxaXQLEEBi2f7qsd+q4mjaxahk5GOceHHA0iI40yvmQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:33.5501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df8426ee-14a6-439c-050a-08d7e709b2d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0263
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Rodrigo.Siqueira@amd.com, Harry.Wentland@amd.com
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
index b4aeb5d8a818..8957429c6a24 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.82"
+#define DC_VER "3.2.83"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
