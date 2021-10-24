Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E90C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A790560724
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A790560724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D626E123;
	Sun, 24 Oct 2021 13:32:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C176E11C
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuW1R/ZkJ/XArgVsxPIl9eb+wrq7i9uaUb7iP1LKz+fLMulyyRjVx8qBlrQFbc/u9WHPz5sfIPKgzIDTNBAadL9XZg0E8RPYxeIRo2mWokmfrwkKOaTwX1isL85+NgA39Vkb3sYOQFKSPwSBcZ6lqZN6RaNs/KQya7FwqHKdlFS3icQc9IYHyewQvJV7ArbUDp9KGDHCgVZFmZR5sfyPycq+J7IgMB6Rcl5m4oQuvHcK9C3kLCxGWR4yDywDRac1yPudKK1gjre5FhWrkGtNib8f8qCeYM1Q6fFwjdvf62oNcWlwBRO7Fb/jaIkbm1HDcgUVXJMNCxuntI3s3cP4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+vsIz6PwrzS4KABTypg1rmPPlxCA+AhAXsB+w7FkLQ=;
 b=CId5UGkjbTZhVF3thAIDIYGWl4cm9f5OLCUyDq5ZsdZuhROad21MD5hlaDhM63glFLGpmB2Gp4ycZh8F5L+0DrlffU4jRNQJmIVLg0bFTv/zFnJas2k/0donhVqkgDgv3JkfWUszgyqtxbdQorVqvMNssIhvR4fvz38pJeNmvRUsQ7S67PKhZswYQlnrMxK7WTHyiaVi7olhHvLsRnzOKGlxSAPs7xGEGkbaTn1Y0+7ifTHndMoeE7TpXcGrVoYnJqsLREN/NXIkUhINmKTyFipJpa7L+EsbOP/mGmXBvfUvQ6dzsyoG8ez1IzT8Yun2kywAmKAKwoj05uPIkycX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+vsIz6PwrzS4KABTypg1rmPPlxCA+AhAXsB+w7FkLQ=;
 b=j7vdL6LBVL2ZP5sP3723ITPZClJF6YrR8zzWH56qjY0cud+IxCuWJjY7rShHVlTZIRBywF+zbufT1aP5SMbCratcADzVChHnntMM6IItO37wD7Tf57Yyk7wEPvnCPC7vyfluS/JG1Kg7BYrvtitO0BBHcbhd0cgJsHV4X6Ki+VE=
Received: from MWHPR1401CA0018.namprd14.prod.outlook.com
 (2603:10b6:301:4b::28) by DM4PR12MB5294.namprd12.prod.outlook.com
 (2603:10b6:5:39e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:34 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::f5) by MWHPR1401CA0018.outlook.office365.com
 (2603:10b6:301:4b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:33 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:32 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 22/33] drm/amd/display: 3.2.159
Date: Sun, 24 Oct 2021 09:31:30 -0400
Message-ID: <20211024133141.239861-23-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f44f96e4-32e6-4b9a-3b3b-08d996f2bc84
X-MS-TrafficTypeDiagnostic: DM4PR12MB5294:
X-Microsoft-Antispam-PRVS: <DM4PR12MB529467CA6547A8EC3EEE147C98829@DM4PR12MB5294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRGcChCwqnkt84UC7DZV/eF0d54SI/5tXq3mzbtdpGrIcLwgzL4ZtqC9zObfGIWpcZdET5d6eMoGWRHxHaDZXhVj0Ndz9PrwdHX8/lTcTUF9099aWSpUO/TWEnzQ3url5Z65LKCK9js/M3UxsSgiJ/+pjn4my3VdBqO+yQlkH+csYedrI0GH5BO5jyi6lnTio1XRp2M2zwhcsQkwUSmJ/vMHNDJ0OiAY2Tevlmt9lKcPKfOHjZ56Fl5PjlvSNB2b3eg6aUMXd32y4TS48Yo/2g0m/orz7NYnYxYO67KGH11wzQQUm3FfJNKif/Yeo40mn+zQZ/pA5gwtOrhnk73Caux1JNKHTWWB17q4Oal2+6dlObXoq/01hox8LzORebZebM6SDtch6bLAHw+RfIbZ/w3U9TxplKYPmwz6WF6gqXAaB4GK9pT1EY+td9PXDZPQvWfogwFty+fDglfewnPl1w4cO2g21HB9wi6kOwgL78++DRZkauUdx1gt+70GM6erS22ARxn78UdDqQd0FlXUfrWVkJUCBpfsqd/0DAgUKnZ+sbSO1x4XHQAAIehzTJwFPkoO1sTA3ZzPpYa7+vu4SJFKTY/4coqX3oyISgxyh9Csi42+w7vZdVuwjRh14WTMpdbfNs0x6JgG12rD8ASAY/U0SmVV0RwYB5dzCW/cSaPXZIfCKRIMq+0Pkr9NjX+USLmS61s5xo7IKaOzlUYeljhBFopkb9gsFfrrNCb0Ovo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4326008)(316002)(26005)(426003)(356005)(186003)(70206006)(70586007)(5660300002)(86362001)(36756003)(16526019)(36860700001)(2906002)(54906003)(508600001)(8936002)(83380400001)(6916009)(47076005)(4744005)(8676002)(2616005)(81166007)(82310400003)(336012)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:33.7131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f44f96e4-32e6-4b9a-3b3b-08d996f2bc84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
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

From: Aric Cyr <aric.cyr@amd.com>

This new DC version brings improvements in the following areas:
- Improvements for USB4;
- Isolate FPU code for DCN20, DCN301, and DSC;
- Fixes on Linking training;
- Refactoring some parts of the code, such as PSR;

Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4cd26ca26fe0..33c4f74a0add 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.158"
+#define DC_VER "3.2.159"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

