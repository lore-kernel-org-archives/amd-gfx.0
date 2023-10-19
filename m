Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA41CDB483
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CCEC10E4F3;
	Thu, 19 Oct 2023 13:34:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3234F10E4EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiTJvMsIdYfFfr/B6DHFM+YizGKY+6jqAUzhq0fU41fausyH6aCAnFYne1Nq2hBLsrQhnD5mgyftpv4vVkwntAPGkj2a7sHzgW9B21VSzMAop4Mk30jYVknNq6UNP6HQHn9khPY6HNpKISJKCl7s30VRCgxfN9Qqv9m+GlYPyy8+m/cSzHmS3bcmNSLLfv9cWjxOLf8Mp6Ttp/CKVlR2FLsEgVJZIjjPAOjNiIRAICLPxauiHyzjATbH9357D57YceQRp4Lu14XVBo6img+cPMGPizI0dzBxRugOmaE3EWBrQd5VyTeF9LvV+yFUcMueuDPVM9tAn5ev8dHjcdNr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wa1ThB/uEQyiP3goBUcMlhfh/Es7LxzCJoagz2FTNIo=;
 b=NkCEHWPXMzOvx93DxHv2vQA95w/12jmtYcqmIH7UDTe5nC7/JoQkaaUeLKssghp1br9XQh8GMDe9Nm/qNOMOzo45fCIRLby09mLHNcDaX9akQyL1Dv9xERfbiRcWdjCPAV3DXsr4iWerSClW0DQmecN3xqm2fsqJ0HqhgU21yUEdILW695DaXlwUnNm37kAh4NPs2nODnF+sOP/LCYeqaGA8tMndbFwtGEm0avLnSf7MEWOSdx8h1KZepMqJNs53IvjYMCJIUhSSLXz5BXaZ/7GbnPmqBcS2UURgplk0Dy1YnoChND4nWUuW4mcZQtHLQImBkzchMGRJG+sX9iC9AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wa1ThB/uEQyiP3goBUcMlhfh/Es7LxzCJoagz2FTNIo=;
 b=XPX1BsI1fxz/eEw9neGQk7uH/gF8SJUw4Ty1c81mEK6JSP3GTXnuIkz4gUjxLNFpOJlDuumm0/jL9FuU7oWxTFY20vNgGqmvXwgMleMuVS+HQhXzuTOjLA0TY0QTjnJNTds5ajmMW7pZPI6QpxZA8GV8S0ZSN2lBFv+5s7bkq/Q=
Received: from BYAPR02CA0020.namprd02.prod.outlook.com (2603:10b6:a02:ee::33)
 by CH0PR12MB5203.namprd12.prod.outlook.com (2603:10b6:610:ba::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 13:34:34 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a02:ee:cafe::18) by BYAPR02CA0020.outlook.office365.com
 (2603:10b6:a02:ee::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Thu, 19 Oct 2023 13:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Thu, 19 Oct 2023 13:34:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:34:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:34:21 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:34:20 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 21/24] drm/amd/display: 3.2.256
Date: Thu, 19 Oct 2023 09:32:19 -0400
Message-ID: <20231019133222.1633077-22-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|CH0PR12MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: 2742aa3e-13f3-4e19-f2f3-08dbd0a821ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tw1d0N0Vf7J5XY6ULQceD1sFDBt5bc8mr9WZ+s9sM2B4pn4cF9YzQt/wo+nORpvaYu+gKFyahoL4gN5jW+J0Ai3pHhhTkZu6rgu9535BpZswSy5w+N7uQzRBm8lIJ3m1uA1c4CX6LADrBucnvFETUFMaJaIejP22aVga9W5XkbIt1o5Akbap/FdtZkd4fBNkY3e8DUQrh+61cXYk+Oo0IIXXoQ85wXmTTp9sNuVJ0/67PZyOE7i3lEKDNO4iAlMYS8Qin2y1+NEP5g6spcGTjqs/G2qzg7s8l7xquoggqjan116foY2UhvJjwNUnAV+8+fZBs4IY8uY+szbB145x2GpRzMdQZNW+7XEPyYdGbFVzOPXzx9shQOTvNsGB5ZL8UKs6+SIkX0A4YeDFF7zq4B8ryX9IP4OdQNOmFUCM4M0l7mCsSxLXBYjfh0mLIAXNV5c6fvihL8dWKTfjjEkaWHMXzvNL6gkiVeNZdkELuDmuQ6Tcs5NDe+kBIxtjD59MKqeWTSRcEtZgZRDgASz59Ts6QLBOoQT0AV72ht8/09z/Ygl+8gtQTsnr8cJj4cC8kS8CHw1cihYMDTEyG12AomPSriufeT4BPC76KL8DlECUuARxO23v4JAVZuCSAD9LH/0EXLoeWFR8lWy4U5pTBiPS8ncfGlJFo8PtrFRg7NwnTvnUBkrLZq7LkW2z4/myR7KxgVB/JpQlNdXV7rMbzQd7S6upxIf04EddorC07nyQZhAwmFGVW1yhdJNZLm6Ly0RNpdhnM1TTqkVOTihpxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(82310400011)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(41300700001)(2906002)(2876002)(40480700001)(40460700003)(478600001)(5660300002)(4326008)(8676002)(8936002)(70206006)(70586007)(316002)(54906003)(6916009)(86362001)(47076005)(36860700001)(83380400001)(36756003)(7696005)(82740400003)(26005)(336012)(81166007)(2616005)(356005)(426003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:34:33.9852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2742aa3e-13f3-4e19-f2f3-08dbd0a821ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5203
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

DC v3.2.256
Summary:
* Fixes null-deref regression after
  "drm/amd/display: Update OPP counter from new interface"
* Fixes display flashing when VSR and HDR enabled on dcn32
* Fixes dcn3x intermittent hangs due to FPO
* Fixes MST Multi-Stream light up on dcn35
* Fixes green screen on DCN31x when DVI and HDMI monitors attached
* Adds DML2 improvements
* Adds idle power optimization improvements
* Accommodates panels with lower nit backlight
* Updates SDP VSC colorimetry from DP test automation request
* Reverts "drm/amd/display: allow edp updates for virtual signal"

Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 47b767fb1ee8..aa4684be1d62 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -49,7 +49,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.255"
+#define DC_VER "3.2.256"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

