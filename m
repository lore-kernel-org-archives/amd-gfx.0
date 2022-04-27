Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD8BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 03:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F2710F3CA;
	Wed, 27 Apr 2022 03:02:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B4910F3CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 03:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgbHHjbpy5f90Oam6vp8XEAjSl60yIPFfnh3vbPGoM6tIBVoGK6YYxS43Cj2aIv5wYY2ioY3SafiR1NrerIbWd1H/a45GfrphlhFxTVM/mzbU8c1IQ4keAX/JI5fs/pZ29M+Th2DCjDvk1TFmHsa7Bt5440vTdXPxVklrnbwK6y7aPMDLsXD/jToKunh7Z1ENYRxtfBPZlD+AELAn7dnvkD9+xVRtMuD85cFGZ0cRIx0e+sEboElFSnRxpRuJd4rcCDv3lEPDTjUfsNg3p2RkVHyo+fE4hckwm+BELf0FOH2MoJU6kNnSEy60JXVRjXcpO56npLQnaNL6/E5J1dRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjQM1wjMkLzhCR3TYRxXNeeE+Tnhlp4sFhcvo4/tZYo=;
 b=DPw7/sbTdj9t4t3eRG5bb+hrfcLZ6M1MUgDz90BIbMrPzKIUMK+bR1/kzG377H5EAQ12zw5BWHq3mghjjJVhwaGRn9Q7l7u28WmrZc8KpbaKaxWbRYXY6ReGk2LEP9dKPtpE2VkhRDc9PTBrfd0Oc/beE3cHBP6JofvwiPetSzB4NO2c1939zOw/1On0O7THkfbNXsKVYb9yqoxyUlrlfn5n3Lg7iRM2ijmXdAe4lrTTR44iMrKFWqN86E5JjnmgLG2FVtxlPWfzpKVhFvQS7w4C5XGwnL/NHXYvZo2ucAq52YE7jULNwS6afwjYpuCtil4fpZ4drP/p7G80MQQEwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjQM1wjMkLzhCR3TYRxXNeeE+Tnhlp4sFhcvo4/tZYo=;
 b=2vWxfepN0L8I0j8A5+w32uvzeyUHbgGArnFo5cdm77tpNO4I7ASnKltYgO+mRlMakepqxugQDjzssKU6p2cS0LLq+Jip6V4IHno+u9IcHqkHq+zC46h2GoKrLsl/0+xlwNDjW8gCThhTtvtGNc7xk+PWmLnJedKCR1hUaUpJA5E=
Received: from MW4PR03CA0061.namprd03.prod.outlook.com (2603:10b6:303:b6::6)
 by BN6PR12MB1652.namprd12.prod.outlook.com (2603:10b6:405:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 03:02:19 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::78) by MW4PR03CA0061.outlook.office365.com
 (2603:10b6:303:b6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 27 Apr 2022 03:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 03:02:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 22:02:13 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 26 Apr 2022 22:02:09 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amd/display: 3.2.184
Date: Wed, 27 Apr 2022 11:00:59 +0800
Message-ID: <20220427030059.1242868-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427030059.1242868-1-Wayne.Lin@amd.com>
References: <20220427030059.1242868-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67403922-deb1-4fce-1d6f-08da27fa56ec
X-MS-TrafficTypeDiagnostic: BN6PR12MB1652:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB165250F76767A4D2A8147139FCFA9@BN6PR12MB1652.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJEFtv5Ijk7LkekDuuBOqEwYzMJkjBuKP2qeTi9AuTWrP619ZiSRDHY7gd1QmQSK/JJ5Hc4Qk3jb60I5Zsy2DTdtTBOU0t5y3rPo9Zdq19a+mUF4SpZIgOQW6QxFSsfcnzUyWDtatPCDbShYmSeLKVR4KEVibWAjFcMjxRII3ZNQb0eYicF8ARjnzHSegXn4yMdCqRPe9VINQd+g3+GnzLuUdX5zucY06XxycDpha2F5/CLovDHOXK7XrfGVNFiaYOkIZpn/I+F+Ch71YylfjSvxSdNOvCqc7KkL39M2UwWPE+IvO4q8e0FyEpxniU3xLgy7AkHOmlgqrUqj8XkzMZwFtP6mEALzfQ3+uZnV4mc2t/8SB3U534ELu5nnv7iJEQ+zih7jt3reQ4SIzhsjWArGWoRWXHDDpR/4mRHTC1t1pu0bCSgm4jcaJVewZc/75YBdc3p7txKI1kFIs6yyiffOIQ//PjwPnaox+wx30Yt6hyJd2LUtdETPzL6eyoG/bOqu6+CVSt5MGkAlaucLSuVylTeNc1H194g4vNGJm3FjlJ0r7r/0AG16Yx2+HA8Zzaa4RpHMzcothF4bCHrePeJGgK+lHThM9f8/sOrYsrrDY6xrheuVztRbWsfDDOed70i3nZfYiXTt06/QADnXQw+i57q86AHGYL6f3503ML2nbBFpnrASA0CUYfHjfZKK2qjHwxulxdsvwx2KpXfYoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(316002)(2616005)(86362001)(82310400005)(26005)(54906003)(336012)(1076003)(186003)(36860700001)(8676002)(4326008)(70206006)(4744005)(70586007)(8936002)(2906002)(81166007)(40460700003)(47076005)(426003)(83380400001)(356005)(6916009)(36756003)(508600001)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 03:02:17.7468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67403922-deb1-4fce-1d6f-08da27fa56ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1652
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Have optc3 function accessible to newer DCN
- Add CM boot option for USB4 tunneling
- Fix system hang issue when game resolution is changed
- Remove outdated register for dcn3+
- Add new DSC interface to disconnect from pipe
- Clean up pixel format types in enum surface_pixel_format

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a649aec78868..942bfb8fd851 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.183"
+#define DC_VER "3.2.184"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.36.0

