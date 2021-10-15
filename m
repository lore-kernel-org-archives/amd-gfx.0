Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B79DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5D460C4A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C5D460C4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CC826E3C6;
	Fri, 15 Oct 2021 18:43:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F24636E3C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PC4RZ6hpvkLw50cmuUoQnrFgRk/6m0fmQQBwR3tiFVMpLt3SFGZ6URAXICdk0xqIJsxOcmAoTygyx932T4qeDL1WAHZkUCNco8QkHOLrOQCH1vGWTYLy60NIkJeFkS53ZOXpP9SW4rduCiFmx2aL+lv8kPcSKtOtFKyGPcgAbMrp3k3jRHMIxP/mbCwvT+aL8iXASofaNZIh61mrvIok3WpnrIX9j9QFcGAtAO4/PnNseP3wTQdsvuIt993UayCJpEThuYtfnQUyejFvAbssmcQf/DNbybwm9oLe0SepG4cFu6bZonDN022LCnoL5BCIoeqRojEp7A4pill7CJYpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm/NoxMJGj3n1OwYit3vnFZke3rA2Zs9HiKrcFw+kbY=;
 b=etuC01kCyudyXOXlWXC+O/+piaQ8dsOK8BMhQAq4j304tQzWsYfolctwUiFFLO9iImT5GzFhQO5LeY7ebyxh9TqphoBNVEUjbJgvEOqcu2wq/neJx4803/K81+8ktZPDlyzy3WstGQMs92x0mMyMFEWQ/cg1xDJZjk8qr1o0vN6UJPsPCUIDgJ/k3nfg3vrzP/K/5Q9IWRAzVqFh6u0Pwu/ijdPosv8R0E9zrb5wTjrUtZCeIKGJPFAr/p9Dt4f9U8kJAiOZ9Bl41Qv23qdxfvSQFiPhX89tmjMGOAb0/BFn2EHhKP0zUtO0+7FSruLJkn+24krzPdtcDjEU1dluEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm/NoxMJGj3n1OwYit3vnFZke3rA2Zs9HiKrcFw+kbY=;
 b=c0pP4ha/L6ce6pliVjxtXXh5dnToClo6Gz5TcUjj2h5/dsEuCe12JrncEUcm5L8pDF4obniguUtXQ+bx80D+uQQIUNKJdRdekcElTxLJafQgZ7ovQL6SBArlR+ilFkMYC22XNbgd+ZPukxGQrQlftSWYdSljvvos99vmz2UH1t8=
Received: from DM6PR08CA0023.namprd08.prod.outlook.com (2603:10b6:5:80::36) by
 BYAPR12MB3303.namprd12.prod.outlook.com (2603:10b6:a03:131::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 18:43:51 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::8a) by DM6PR08CA0023.outlook.office365.com
 (2603:10b6:5:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:43:51 +0000
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
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:43:50 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:43:48 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Jimmy Kizito <Jimmy.Kizito@amd.com>,
 Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>, Jun Lei
 <Jun.Lei@amd.com>
Subject: [PATCH 02/27] drm/amd/display: Clear encoder assignment for copied
 streams
Date: Fri, 15 Oct 2021 14:43:07 -0400
Message-ID: <20211015184332.221091-3-agustin.gutierrez@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4f0c8ed4-ac53-4a22-4822-08d9900bbaf7
X-MS-TrafficTypeDiagnostic: BYAPR12MB3303:
X-Microsoft-Antispam-PRVS: <BYAPR12MB33039383A5CF485FC3213ABBF5B99@BYAPR12MB3303.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: of9HfmJqBJUxqFHodHJ6yUIDGDd113gWUf3DudMZsgnyJXtbc1jKe6zFEHCcZaAPw0RO+wus4Cu4FDNwBD+wtKqI8l8J1XESZaRKzYHvUq3zlwFuAT6OX53Evtv12PNlaEhdULhDsNPrNCQjXZfpzGr2X5F7SY+5EP/P6Xel6bOdri1Jx11TYSslPvxR6CvkamN/0LkOp3SZp3bFlljv/GXl++xA7xD/LyzJ5Di5sUD72/WL9tf3/Q2DI2gJsjeFPQ5Mqt3S7LKp2ppnsTEBW0QkjhfORkZCpEkKpK17tPH3eKVeBXjyjb/EvnCmWgiVESQjf0JB7qoWj8viQct9gzp23pi+TRzjo92OP4vtvHUTIQe+GHKNfVM3GQHhZ+JaswR7xRaEoZhh0TayjSPjJ8m4JOkq7K6x1iSA6/fgh8JGutuROTMmMHYSAb/ITu9m5z2WN+cRmdC87pgQEL5/LoeP4aCz75qAPspStnUguWg8JSEsf30CSNKjMsHivxs+p/6FGsnaOfr2ZH+Nw7Ociv3O6oh4WyXSaOnjoUDXcOP9x3uioO1jfW8ZjgyoQKcNuycJBdUL2/vpP4ifIlo4P0KbVya+5YyCckUG8MeHIqWjC0Xptn5xQ7bIQF12xCoQRdTwYAr8mmaNKJJhhkYAsOzrusHLzNf5OmiavbPHGR/BAhb0enpUW7L8oj4ywPVqG1IVrTFAPvli2THpgNOQ47dWRlu4LxOY1e/seu1jy8k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4326008)(36860700001)(508600001)(82310400003)(47076005)(6916009)(356005)(54906003)(81166007)(8676002)(336012)(86362001)(16526019)(26005)(44832011)(8936002)(1076003)(316002)(2906002)(70206006)(70586007)(426003)(6666004)(2616005)(36756003)(186003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:43:50.4644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0c8ed4-ac53-4a22-4822-08d9900bbaf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3303
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
When copying a stream, the encoder assigned to it is copied too.
Encoder assignment should only happen when executing the encoder
assignment function link_encs_assign().

[How]
Clear the link encoder pointer for copied stream.

Reviewed-by: Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index f0f54f4d3d9b..57cf4cb82370 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -202,6 +202,10 @@ struct dc_stream_state *dc_copy_stream(const struct dc_stream_state *stream)
 	new_stream->stream_id = new_stream->ctx->dc_stream_id_count;
 	new_stream->ctx->dc_stream_id_count++;
 
+	/* If using dynamic encoder assignment, wait till stream committed to assign encoder. */
+	if (new_stream->ctx->dc->res_pool->funcs->link_encs_assign)
+		new_stream->link_enc = NULL;
+
 	kref_init(&new_stream->refcount);
 
 	return new_stream;
-- 
2.25.1

