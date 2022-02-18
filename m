Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC4CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AFAC10EEE5;
	Fri, 18 Feb 2022 15:04:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A0810EEE5
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 15:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkujnmSTfJ8b2wlrfngWi6W6jLgstFzeOxhCs+tI6YHkuDjpD3hhAo8JSZNrnxHGoy8ZIXivc/EUjIZZEAb5Pn7+ZrkoMosf/+l4LiDB5Qaz9GkbuPd9XzDn04Ca8RcboA1DyemlNpO61f5RENgh8/n9deu/b371/wPrS+df5kv9e0HdqptnGCP0WOsy6a2qIdLirlQrQytNh0CrfIXVSLtv9paQYOUvB0CN5a7t7vZjgZx3jztbDT9ck9MfuHWE5fzg1i0pAEivH9Ej9sAxgCfCUQs6md7++ByxMp5Y3uQwu8jqmBJzPMzQuR4+jqJDOMtBogoOG0thzid7hffzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1qrBkNdStAvuDxjYutASZwtg1ByvGfWFVcCsk8kuxk=;
 b=c78ti2KMi93wrWN8g9HhX+W/RVbCUvKFbKSWksIlgOyku8fBteE5IvA4Rws0gFQuULD8+Ih0I3iJLeEWIm2jFhGlCsW64UP7Iw98Qp7hwf+IPUww453Xzppxg9cXH21YzAplfvl1Bq7fom7/mN2GrRWhufb+gOX+zpOm+OFc6XLckC7ar/pBkAgOwsSgkuhIshkbLWX6nfk3POw0L/HLnh9kNTqJZGDkRFjXBnxMwr0ua7rb/NZhAQKYzfCSCr5u4eTceyVEjlzya1TprRnxIJXHMIsEbMAXaR29QM3x/4Lyr6ELgFzHF5b9XALFP+SU06zURWKNTqLqri6E4ONFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1qrBkNdStAvuDxjYutASZwtg1ByvGfWFVcCsk8kuxk=;
 b=3rkfVomuN0kEAEi+FptTb2UIopYKKc3nnALMQBbUJ6+x7XxsgX3C71c7k5KMY9congLYJCvM8XUviC72pKkQ4h1mFPPd90ts1/+Wn2GYyiyWKc4P8+urCXEG3u+A0w7jARacozhcoWLXWg/NeWjpe6NVzlBFC+DjfszJXTjJRbI=
Received: from DS7PR03CA0304.namprd03.prod.outlook.com (2603:10b6:8:2b::16) by
 MN2PR12MB2973.namprd12.prod.outlook.com (2603:10b6:208:cc::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Fri, 18 Feb 2022 15:04:35 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::87) by DS7PR03CA0304.outlook.office365.com
 (2603:10b6:8:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Fri, 18 Feb 2022 15:04:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 15:04:35 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 09:04:29 -0600
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amd/display: Ignore Transitional Invalid Link Rate
 Error Message
Date: Fri, 18 Feb 2022 23:03:23 +0800
Message-ID: <20220218150329.7976-7-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218150329.7976-1-solomon.chiu@amd.com>
References: <20220218150329.7976-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caad564d-c970-4862-1872-08d9f2eff9fa
X-MS-TrafficTypeDiagnostic: MN2PR12MB2973:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2973596D306BF438470C3C2D97379@MN2PR12MB2973.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 48K+0lmcl1IO3hLv+p5TgSE31LuqpJsbsh4FoqpI1/rlg2pESJknrApgiZtPgzT9kyfMMEzCIjt1kNRXu5NP1V5mTfCHQZTB486S3wqlEyORGwy6zbBNBoffVov8NDk0Xl43kKsdLnHsuWx6RnWsEKA8pa3RLnPJwoP88O/4+fnar/F0Ch64rVej5y8v1AK5Ym0AIE5MdsLz+kdA7UBmt2gFz16+FY1VJMGErTC4VQpokNlCnSsHYHBOGA3BP0J9tdqgrATi2V53RROeUgekpagbcGKAmuNYK4WR2CmcKDY4Y8dnx7HtWM6jqmmmCyIECh1wFsUgs7SYALGw1zKjTEQmWTS7VN6Ni30m5KUSeEMLdkhMHCm4pJPMbDr8T7SlflvKcs13Tg/QaGUV+RovryvA6WnsrBp0Sdt21PDAvVjTcLTYQQiLODgLCiPs+dVTe3HhSfOcFRpkYRazPWqqPNZnOXIqFXZy65JdB6Ax1Cg5uKrtvzlkVBGaFLevfbRIycCr3HhegFRBNeiIWJNicWAe6kmIy90eFhtM3gXaD62/qlg1+/wFheaCO+sL8zLQGg2EAr/Aa1hT5BxZZdGiqQIuhO0mJGYHfumqwP7XzoWhKpbJZmu1PGpAIDULuZYCtuQF/50j2TxvYQyeQQ27m1lv/Wo0jLf7ZygQkvpP9erGQQy/S23JLaoT37HdS99cP1gUUn3r/V+ftJKGcZncCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(15650500001)(2906002)(86362001)(7696005)(16526019)(82310400004)(356005)(316002)(70586007)(70206006)(8676002)(4326008)(2616005)(81166007)(186003)(8936002)(5660300002)(54906003)(1076003)(336012)(508600001)(83380400001)(6916009)(36860700001)(36756003)(40460700003)(47076005)(44832011)(426003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:04:35.3408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caad564d-c970-4862-1872-08d9f2eff9fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2973
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[Why]
When hotplug or unplug happens, each stream disabled one by one, and then
enable any alived streams. Link phy and payload table is cleared when 1st
stream is disabled. That causes the error message pops up when disable 2nd
stream. There is no active stream after link_rate is cleared.
After all streams are disabled, link will be trained again and link rate is
assigned to any alived streams.

Therefore there is no harm for the error message that represents invalid
link rate value in the atomic reset transitional time period.

[How]
Downgrade the log level from ERROR to DEBUG.

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c553d0ea63d3..1d6b6ed3f24c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3921,7 +3921,7 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 				&link->mst_stream_alloc_table);
 		break;
 	case DP_UNKNOWN_ENCODING:
-		DC_LOG_ERROR("Failure: unknown encoding format\n");
+		DC_LOG_DEBUG("Unknown encoding format\n");
 		return DC_ERROR_UNEXPECTED;
 	}
 
-- 
2.25.1

