Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3543AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006F161041
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 006F161041
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC2CE6EDBC;
	Fri, 15 Oct 2021 18:43:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 291446EDAD
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3Ip1XJShWy8VCZXGWQFGGuwTBZFnotMZd0cbClzUQdQr5pc8W0WmZtBt2OhcoCUjzpV85ZatukIFeVpn23gXkTffF48fnCtnIsSKMigDIgRRQreK8dk9b2HVohvFB8KhoS/FBDSeYD2qYq5LSj4xzCcWOrXdgVJQTwcDRB2B3kBeyxf5GA+AAxSnDJ51FJ6P92rMd+iPK1espkYFrsvHzn5yfzI2Vmwi835sdsZdgikJmfi61XdlFYsuHrdXze2QrKwnxesrXPb2cTzPXVb7rv0LUAfze7YrS6D/JbNimUGE42wZNKa8J1Jkhdhra3OjEG/fT3nEhuQ6NAHKm226A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjMiqHqRGBVj373+R//3MZX3OHEmxs4LiFbkB3j/gGk=;
 b=gTAuv6rpzCrCVoOVmRfz/OUS2lHOFP7cC2/WQsP5RIu0cd/e/Vq+E9ej2drqDtZd7slympWCs5y8QfArDib3gv2r3Kh4MzeTul9HGoMau9pLetPBLpyZJ3Da61EAhaGy/4VOQp2KXDZyhLYM2aXfvvf4uIclQz5239RClbu2dWCoHI76kYFT64VM2eR1iUe6ZURS3ezd1QwRYOPJWIYQt/U78D3n26qy0IEsW3tOnVN2IruS5yX3a4OYh6FiOx9YoaUKfPAeH9KvWByfXBmPScuZ/+HsbV5fgNIfQ4rcrOau0cT2pXAo8kLYaxT/1KCPufiqP4mW5yWJRE/loJnw1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjMiqHqRGBVj373+R//3MZX3OHEmxs4LiFbkB3j/gGk=;
 b=PdP59XznPv7hFiLgqe/X+RzR0UwMQv1gDlu0FX4MIaE1Bby+QfN1d82iUT9LPibC8sF0A3yD+PdfgPE7Dycddn/b6HxNlUjYXQJvN6WyueepwsiOlnsM9AEMgJbOPcZc59zE9z6mTiK8m9RWtUBCAttdoCXKTKdPMe/WzhnSy74=
Received: from DM6PR08CA0013.namprd08.prod.outlook.com (2603:10b6:5:80::26) by
 BY5PR12MB4999.namprd12.prod.outlook.com (2603:10b6:a03:1da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 18:43:56 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::da) by DM6PR08CA0013.outlook.office365.com
 (2603:10b6:5:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:43:55 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:43:53 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, "Ariel
 Bernstein" <eric.bernstein@amd.com>
Subject: [PATCH 07/27] drm/amd/display: correct apg audio channel enable
 golden value
Date: Fri, 15 Oct 2021 14:43:12 -0400
Message-ID: <20211015184332.221091-8-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2707ff69-e977-4bbc-7cd7-08d9900bbe13
X-MS-TrafficTypeDiagnostic: BY5PR12MB4999:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4999129D96AF2947AFCFF09EF5B99@BY5PR12MB4999.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kI0eft/eDMC59xCe7pUnfyRVNm6aw+RXJEyW3YyKNITLLJLoLmuHS66w2hmnJCoRdYg5OPZEIw7HK3ibSpfRowwk82FFxsvQy5GjQO8dsVPiuFD/BJd8XVyFqAlPIrxYnIRmdmqFZaxlfwIQl8ALVLPHbpkwr2OhUYz3wwUyLx5LTUz270r5sR/5eJKBTeOLBBxUd8GdlLu8EqMa9UrBhwQPy13SiRDhL25+f82aMVcd/K643oTj33tRyu88j1b9LefZQosAQSR8EXnvec4T0z/LCipRfvVk7XnuhIMCIP+Tcab7iaFRcMj6ojvYLfOjVfkuVsqjw3si6WkGq0EwTYZLk9/KefBXmwOi5D1j8vYPkVGSCBKY6nHGalrvw/aLGsFjhk2btJCTEdITzqBlZWJdkvbFlxv18+IA+6yiUIj+mYEUqaBtjo/mLienNS4Y8K7A0xBZJqufXLGQ+VrTw/UTpLCfZnk85PIn6PcdLYRBQVEU7jU8NxgPnaxvWy3F63IWqGRvvqqLNOTnOnF0wqD+tQRELzeX9ab4+ADWlBCC16PllHlqRjttQQYKfkqacu0YteAIpx7nd0ZLZHvDqkTEvn53AdYuCRo9ek+g5PXtcTHTLV5UyhENcB9LDBVfDuXHtk7Ta8JeNfSDV6qNZ+6aPp04UytrCftDEXOAtJwhDKHe3WMufVGwneeHBCd9zYRkGxZcYKlMR4Vcrs92bzxmHKUp66GA0nxuc7YCZKY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(70586007)(4326008)(356005)(316002)(5660300002)(6666004)(47076005)(36860700001)(70206006)(83380400001)(36756003)(82310400003)(81166007)(86362001)(1076003)(16526019)(2906002)(2616005)(426003)(336012)(44832011)(186003)(26005)(8676002)(8936002)(6916009)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:43:55.6824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2707ff69-e977-4bbc-7cd7-08d9900bbe13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4999
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

From: Wenjing Liu <wenjing.liu@amd.com>

Hardware team has recommended to generically hard code this register to
0xFF as part of the effort to eventually remove this control.  However
we set it to 0xF instead.
This causes 4 of audio 8ch to be muted.

Reviewed-by: Ariel Bernstein <eric.bernstein@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
index 6bd7a0626665..de5e18c2a3ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
@@ -129,7 +129,7 @@ static void apg31_se_audio_setup(
 
 	/* When running in "pair mode", pairs of audio channels have their own enable
 	 * this is for really old audio drivers */
-	REG_UPDATE(APG_DBG_GEN_CONTROL, APG_DBG_AUDIO_CHANNEL_ENABLE, 0xF);
+	REG_UPDATE(APG_DBG_GEN_CONTROL, APG_DBG_AUDIO_CHANNEL_ENABLE, 0xFF);
 	// REG_UPDATE(APG_DBG_GEN_CONTROL, APG_DBG_AUDIO_CHANNEL_ENABLE, channels);
 
 	/* Disable forced mem power off */
-- 
2.25.1

