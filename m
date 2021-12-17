Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FAAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C1410E651;
	Fri, 17 Dec 2021 21:24:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F09710E651
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Scb/r4lOZNZ4og01CgLVwbgubtBjqKKb0H7H/ZCBw4fdtM8wKahJJZuaa7+4gPvE1UOzxxn3G82v2KACxZqTS0S9Fzox4HblozXcFWnyG1FcAC815nURUSmDqciwvI80RLYcU5nJaVWb8eEY+xH4kEFO7RES+VkELNy1Pobd5yLCEKMEzBz5SOHhOMA81FDIZM+H0UZcY5CxQrShDl9c9SQh67orT16ktV9GMqxkolUxWkuznC8zw4B5UGFeZ93Ik3GBzHoIKUmUuCK8REUwuVwkPMzzGvLxHt0hmi4auiMhlhZezN8Fb1Ehz2MNadoENqt9ijmaYuw1mnGklKQsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xH17BVZkNod1WqKmO7pyvZfUkCQtmW/T4AxHTLpIUe8=;
 b=PLWitzFLLT0xq1gIiTKNhIhaotETpD3sSgBTuMvrqBIF710EhuALlo0dssi0YH4HATImEutxJxcq7qjlSwDs8D9aGHmJUlabECwStAbdtGWh91ajgrmfCoknpEkdr1Z3ZYUlKOtew8NDE7t5aKs3Aizz2/1o6nELvAK+aKJcLr2IHi4BWdiEG2srd+zDejWNHETTEDHf0uIDP6XS9Mr/WQp5Cny+PX1BmjddbaxPHArx/JXvGFsXVt3H8QqB7/lnemg5BgKsbjOdBk8hyZ+KTmVxtbGWNeHmoBYLkDtg/WJDo0Y4lY8wZQJJguLKIUcO5XKXx569mV0iIS6nRqjoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH17BVZkNod1WqKmO7pyvZfUkCQtmW/T4AxHTLpIUe8=;
 b=myD9gPpHwrdrzBzeD+ZFHB6txp3o6LqUVTMkY8HOec5/Ja+sJ8bWBgEuQOlNAKTM0AC39+pY05oyfEB4hGGRKZ9TQdij9+Gni7Xtooux49rfXVvFG41kstcIREYlkn7odDGjDsdLu+eUKkOixyHyAdqOfYfkulAql68T2cqST6k=
Received: from MW4PR03CA0140.namprd03.prod.outlook.com (2603:10b6:303:8c::25)
 by MW3PR12MB4523.namprd12.prod.outlook.com (2603:10b6:303:5b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 21:24:30 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::90) by MW4PR03CA0140.outlook.office365.com
 (2603:10b6:303:8c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.16 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:30 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:28 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/19] drm/amd/display: Fix check for null function ptr
Date: Fri, 17 Dec 2021 16:23:54 -0500
Message-ID: <20211217212407.3583190-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99c30b82-8cd8-4306-a97c-08d9c1a39cf0
X-MS-TrafficTypeDiagnostic: MW3PR12MB4523:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB45239E749BED4AFC5187109598789@MW3PR12MB4523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nai7CsuXVGLH0l0ljW4LmeXl9oA4sYvhVMFH1svvzkDIxb4sQTIVXUG9j/I2YI8zmIvnDSk5YGm5pb0vgSsr58Z/fjtTSgGcQdt+Ur+LJQVVNK/I782jVMF4TQnQj8DYSuyeSAHP3dKZBZQc31Y3SaeJqv5CF1oox48LSKMK9yKulVTApfkKJMx5n6q+bAhYu89fBXEgFdaKgJOPm4pnvlsPNdPJ8APqQhZcumoIBXDVusB5BvXKOI3BGMUV7dQBxNzerQLf1b4JAAbCfMG/NNePbOcSsPXBaTdLMjULrETU6YLjK6jAjP5sQRmbeUCPMCKtO3pdygQeLzwhfWZBTB84ymkNMZESTe31oLib+i4D79yQeovZb7jrP0XVKtq4S/nwLbW+qnrMNgX30Byl7afxXntFTKm01y7GzdPEyJrxEBmg3vajyF/lZoNJAEqg7plUcq0mXQKiqIB2GlVwSxh9KJkKreDlcWjxfcf9vOSlcF1S9qPZzM7to9zo2VaeWVgQDTdDlqQUFEQKb7G/KfpYxOeOyiAablmhOQMqwBugH0oM/ajc1larSX9UM0YB5fX01aXTimTbQLZf8Yd0651LdLrd/yZb6Ptd5dzDRGROfXybedlmtaXGxzndr7H6H5p58pGvcDkoCMPipZqEYfI4+e6kIFr2o3XWMWATYv5TQMyeclP+xYFC2lP5XRRWOxJ62ayzmtkt4aQzqAr5kdAK5uue+54NhPXwlwp8nFfiWkZ7HjUeZTuSS32S7sttl/iRmKapuFFhM42gvSLJfTFE4QUdScFpFW+j26e3li8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(1076003)(336012)(2616005)(86362001)(36756003)(70586007)(82310400004)(8936002)(40460700001)(356005)(36860700001)(2906002)(426003)(508600001)(5660300002)(8676002)(70206006)(6666004)(4326008)(81166007)(26005)(16526019)(54906003)(186003)(83380400001)(6916009)(47076005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:30.4764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c30b82-8cd8-4306-a97c-08d9c1a39cf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4523
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
 Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why]
Bug fix for null function ptr (should check for NULL instead of not
NULL)

[How]
Fix if condition

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index f673a1c1777a..9280f2abd973 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -852,7 +852,7 @@ bool dmub_srv_should_detect(struct dmub_srv *dmub)
 
 enum dmub_status dmub_srv_clear_inbox0_ack(struct dmub_srv *dmub)
 {
-	if (!dmub->hw_init || dmub->hw_funcs.clear_inbox0_ack_register)
+	if (!dmub->hw_init || !dmub->hw_funcs.clear_inbox0_ack_register)
 		return DMUB_STATUS_INVALID;
 
 	dmub->hw_funcs.clear_inbox0_ack_register(dmub);
@@ -878,7 +878,7 @@ enum dmub_status dmub_srv_wait_for_inbox0_ack(struct dmub_srv *dmub, uint32_t ti
 enum dmub_status dmub_srv_send_inbox0_cmd(struct dmub_srv *dmub,
 		union dmub_inbox0_data_register data)
 {
-	if (!dmub->hw_init || dmub->hw_funcs.send_inbox0_cmd)
+	if (!dmub->hw_init || !dmub->hw_funcs.send_inbox0_cmd)
 		return DMUB_STATUS_INVALID;
 
 	dmub->hw_funcs.send_inbox0_cmd(dmub, data);
-- 
2.25.1

