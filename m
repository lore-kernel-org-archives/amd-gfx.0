Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46167C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A3A2071C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bOOmnkaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A3A2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15B7F89C0D;
	Mon, 25 May 2020 18:13:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A82289BF1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtJKcRdfZZBS1ZngnJcsKjO9aMb0BkWB5DRahaBHD9TDhSZSlD5lRw4thCO480VrH0P1eWhrPIcWX9CvkvTtUF/r+SJzbI/MZ6zHIZ87Av3mRchtlfhZoOrvSQZXaWKoruENCky4mN+PS8tV5vvMQni3auMHJsl5h4toEWJ7TZu4MvsFtvK/NfhPb5hwe4MN15YW0hwU2a0v1kVzqSAq9q/hMuFGIDhceD5z7bJcVFnkyW6k99+J+EcPu94LkkKkDptdvzs3M3D27WRY/7efqx7xzXn+SdHfJ4tXhNcWgiPW8IfObaU9Z1aG6tDFqO5vW8IDs+j3pKEyU2adTx+KUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeHLaKyXzR/TerLGyttv5HRxb0T3ttk9tvfIOm4hQXE=;
 b=XYnBl0vXo969RRAOGXMipmnNoaYDrZNilH82dZ1YDRARXI4AOi46WHVw002DcIoKe7cEby5+d9Ihw30y/cOJofVmoLEBYRT2ihpEd+g8m6nqBvTXOmfdX99FffHynxys73fD4VZ/yxzG1m5xKRAsbDq4k7cf5wxLaNNVxUgYeusCmnYmPskQVYJ1xSs63nQawo3BSSeEvX4srTFgGoOTFzdCaD8BLams91Fv2NdQ00PVxHsL/RaGhkggl2raQB3Kah5zELItAf1TaxNZIaOc1iQd73afENUN9yTQ7ap7kphIc21NzwjUM6GCEd+KpA6/CTZ2l+AYHD0EaA9BXu9DHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeHLaKyXzR/TerLGyttv5HRxb0T3ttk9tvfIOm4hQXE=;
 b=bOOmnkaNDWprrjWlk3iv3pcW9zH4JnzvEHlvS6AaaZ/VESv/pNPvpX5xLMN0J7IJ8w95023unP7sDNmGn5sPfNWa6UMCtCbuSvQEhn8O+T4ePIPhmMveVwHjb4fntGtd1cLiSPoiRTSK+C+o2FSRBa1hRfZkn6Y8sNLjnmlYeE4=
Received: from DM6PR02CA0049.namprd02.prod.outlook.com (2603:10b6:5:177::26)
 by BN6PR12MB1153.namprd12.prod.outlook.com (2603:10b6:404:19::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Mon, 25 May
 2020 18:13:10 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::92) by DM6PR02CA0049.outlook.office365.com
 (2603:10b6:5:177::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Mon, 25 May 2020 18:13:10 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 18:13:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:08 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:08 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 May 2020 13:13:07 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/16] drm/amd/display: 3.2.86
Date: Mon, 25 May 2020 14:12:51 -0400
Message-ID: <20200525181306.3749-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525181306.3749-1-qingqing.zhuo@amd.com>
References: <20200525181306.3749-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(46966005)(6916009)(8676002)(2616005)(5660300002)(44832011)(426003)(54906003)(4744005)(8936002)(86362001)(478600001)(4326008)(316002)(26005)(1076003)(356005)(82310400002)(336012)(70206006)(186003)(70586007)(82740400003)(47076004)(36756003)(81166007)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 783e71c2-09a9-47a5-0bad-08d800d747da
X-MS-TrafficTypeDiagnostic: BN6PR12MB1153:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1153AA9878BA8258BA8D83F1FBB30@BN6PR12MB1153.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHiXmrguW3Xg7TJzL15xTBnNcdycFhV7ypCh9hFOhRm/hfGOMeXLHUsn+ql9Ot0zq7Z96w8dwKr5wPXPRi0tXQGov5+vC+l2+MtU7mkVJfhuMM6sMLqSzJ535hphkVbFXAIIxvZVIp9IcZzrwoTXsxJ56XjOjy81xCF7Aszvay+rToQ+SwjwdOjb8mNKeGkHy4wNapFa5nlc63cQl+BW75KLclHeT7BAlr+mdd4WcEUY9JCqLS22fTRWl3bTSPU/99BXopBjEnKLOU+RzXkN1SGD/w5XRIHujWfcUPjZUxe2ji/F1ZpsgQWU4SSkzcISsqybQOrAvTZ4ZrNzRGb0ngFCLx8SUKSdMq+ZdP5eeZ6C4+4aW8MbxbzERevBP8ZaV8y5/D+LcbogryMEZLWzkw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 18:13:09.5386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 783e71c2-09a9-47a5-0bad-08d800d747da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1153
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
Cc: Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 11ac4b7ab174..687faf83a54c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.85"
+#define DC_VER "3.2.86"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
