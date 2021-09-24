Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEFDC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBB8610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EBBB8610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A2DD6E22B;
	Fri, 24 Sep 2021 19:10:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94CD16E22B
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuqFB4jGsAuBXyBh2ap0B58VeNL8OkfOH5g0/onbRcyjugFWUCu6kDIKplV5nzYTrFj2SmzPdB3JFvy/R9qKG8yEkQIMJoKds7ZKz2nD2O83/OoedEESM6Qvb9rVddzq1hn3Ysi5AfE+nOJebdLxRSbSDA2tHiojCTGRcsVsDq55jaDOzWy8Dksa9F8+Jb3B+2jBU1FE+OndqGjoyDU9nPtfy0KBf0pfwFZ4rstS1KfsBRBmPf6t6IPVgWO0MXkQ7OpeQN2bOSDBZ/aPlh3JZTeBXwoIOK2JU6kClCtH6olBIxY0Tpx5BRjMx9ZqHb0Bo6+KYQexRK8hBz7v2BB3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=3Mh4cuvrlywYZe6tICuSH1cCXLNZzWRKnsHM2Wzk44k=;
 b=Ejh3I1/autN3StmvCniTi8fDRoa4IVJ74GXkIYcLG67CyGrHlkAAo5aMZKD9V37vDlcva4xOr2FwHnrZFs4sDlUqh7lbgpuxTumacM/CU1GHdUdsa9XEo4sBGWik/7oz/pWMov4rCSdXZkKfAbvAfqb5kf1uTPOYFQTuT0J9Sm03O9k1ZRqys7IF6JvrUfTTSq1QwcLqbjqsRfI0juvj4kMO9FR/JpDzLqAtiH/YT3q1ouj04N3MgRTPo45UvITlmOfFTlD/2pWDb2S+ohr9Za5+iWjssi4KV0qBsBzPjShA2W6gw/h6cFhud2vmxKnIPc1motEo1lLlcWI3ymGa1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Mh4cuvrlywYZe6tICuSH1cCXLNZzWRKnsHM2Wzk44k=;
 b=CLh3jIBv2quhmCp6SHMiwatYiptRSL/lInsAtXIEkQKYUEe0XQcWFDRYsIj9D2Pcadj0GLs7Vp6BrLpPSY1D8bytpPV3HRo5HBdrR0Hd8YlOKfB3OGqugRCaZq/clcF7Qwktgg3wo/L6MuZmSegWWn65E6fmBbh7Ej+06Li2RSQ=
Received: from DM6PR10CA0010.namprd10.prod.outlook.com (2603:10b6:5:60::23) by
 BL0PR12MB2580.namprd12.prod.outlook.com (2603:10b6:207:3e::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Fri, 24 Sep 2021 19:10:42 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::d3) by DM6PR10CA0010.outlook.office365.com
 (2603:10b6:5:60::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:42 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 12:10:40 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:10:39 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, George Shen
 <george.shen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 22/24] drm/amd/display: Handle Y carry-over in VCP X.Y
 calculation
Date: Fri, 24 Sep 2021 15:09:32 -0400
Message-ID: <20210924190934.1193379-23-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7151948f-922d-424c-5c07-08d97f8f00f2
X-MS-TrafficTypeDiagnostic: BL0PR12MB2580:
X-Microsoft-Antispam-PRVS: <BL0PR12MB25809F7D75B3AD9ED6F539E4EBA49@BL0PR12MB2580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvLVYZx7T/ZjHHsU/3gQiVSkWF8V4j7XCnWZiDjho+56nBVCdIJoDhVn7bK8VKLMTg98tOsOVztgbh8zOB5uRQ3QDK1Es7Y3ABRRMTl3u/2Pc5nmdX6ELPF/6wWUyERMr+jFemqFaqdnLYSFOswNycnl3MHLSHNt64vHQT5JrcMZdUTBwzb9YdBkdKvmD7ZmxTkitFxE65JFkySnqRkVJt7N/NJDenRaF1nBxvn/5z7EMrVLf4H9z1EunTkD12+acFmuCMdNizJAaooe+800Zb3CRw8akdlvwtZibewfRsc4+7wZs5srmkXbk2gT8tOlN5wZzgYUx17P7vyTWezlJKjPpiU/Lovvfr7cnGdZhvz5Na2TDvapk9tNRinGnfkvrXIqbrzU2bXmlT+flBvC7BPtH85VXqsSLpoAjLyiSjjWwPY8BKux1NvSan8cRAgI2EkbZuJRa3RBMMq6ZGqShO1EfS1Xn9rSuCqOPiDykud5xWYJrohGe8CIPBF0wbUiRXg5LAp4iTt0ceXn1Xi6p8Du2NUpnS3TJv7ViHvhvgKT7cn9i2DbLSF7zawFV/bGO83CDi01VW2L+RKtONVBuLg2kKiW9RR8yw4wwYFTuPTrTsgjs5vzo0D8A5bx8njXbuh9d6H6r/ELxusns8+uLW+eoEnMDrFRQKIEVX1GrJozZLcwU/+7/0zIazsyPDhzpSROlUKs2P7drDkws+WePESUJuEQTKb3uZGBb7T9Zpc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(1076003)(36756003)(8676002)(508600001)(47076005)(2616005)(6916009)(26005)(186003)(7696005)(54906003)(2906002)(336012)(70206006)(5660300002)(316002)(4744005)(6666004)(81166007)(356005)(70586007)(86362001)(8936002)(4326008)(36860700001)(82310400003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:42.1770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7151948f-922d-424c-5c07-08d97f8f00f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2580
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why/How]
Theoretically rare corner case where ceil(Y) results in rounding
up to an integer. If this happens, the 1 should be carried over to
the X value.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index 687c3c6881a9..b0c08ee6bc2c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -647,6 +647,12 @@ void enc1_stream_encoder_set_throttled_vcp_size(
 				x),
 			26));
 
+	// If y rounds up to integer, carry it over to x.
+	if (y >> 26) {
+		x += 1;
+		y = 0;
+	}
+
 	REG_SET_2(DP_MSE_RATE_CNTL, 0,
 		DP_MSE_RATE_X, x,
 		DP_MSE_RATE_Y, y);
-- 
2.25.1

