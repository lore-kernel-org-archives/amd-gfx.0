Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C8BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7F210F481;
	Tue,  3 May 2022 20:37:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB01710F45F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqQ+vrtcOJw61r1JUnCNLl19GbiBHF6meY9ASLZdat+dJGddKFphw7oVf0tKA66gvnQu93Qo+pgmc6tGSr1IuT3YSucgtgjK7bpC/thFSt17Wd+wKM4/zVTfE+aZQRHcL4JaBv7c3j/B8DVU+lhppxLDzJ1q6MlThsnffZxQIuV9X6OQMKDYuIiR5FhrwZdYrr5jzHuRmw5nB4HAMp03Mu0bBdlFamBYqUh093JWbX8RMfg0RkkvcxmEfjZdoorCxNlCzcspeSGcTSXA4TlyDMl1iKBHL4MtBZwNFCdyjdWHmNZRxInSZ9wT6DHaii8k0Gdd+ji5UECBoTjc+IdlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HU0sbF40AEII4ru81VhosK8rx9eAVyPWQtnFSIxG2Ok=;
 b=bPhZ+cyngLyn1jp/rSRarftNduMnL9HppbDx3YcslA5zkEdJGZ58qg0ol51oYlWZBWVhkOl3e2X8WdPQKvjmJIq53Jf0mOMGf554Ai0WbmuenGNkfYRjqDb3c/VH4b04vKozp2RZXEcSM7rH9jTgIs7IGdnSPhishewVfrSgtpnT2SRXBp9wY9AhMJvs0RQ3w0h55CRKNH7zgRbOKuWx2ifuixC5dbc9lQDcFHFrHoLRN1C6byTiqD9c38Y5Sq1DJa/YwAF6IRAsjBSqjutFyWLUkQ4+yJQOf3MCUSN56vMK+sJEgb4vQt062AwENCsyG55rlNWwVvUREAcXc752iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU0sbF40AEII4ru81VhosK8rx9eAVyPWQtnFSIxG2Ok=;
 b=AMazE04vEqqw4Gjn9jlT2dRE19jL5pMgmX23bTo7pgJFa3yfKE0PaMqzatURbhEuIFOfanspiAcLovcvahYnLaN2dwBsuJGcG901YX6iok/2kljV8q7Lu2Ko365BtgfEEcydf/4Lg3+R+YoaqGt5VnqxZeGPAGDvXedHAFNQDrY=
Received: from MW4PR04CA0141.namprd04.prod.outlook.com (2603:10b6:303:84::26)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Tue, 3 May
 2022 20:37:44 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::fc) by MW4PR04CA0141.outlook.office365.com
 (2603:10b6:303:84::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:37:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/26] drm/amd/pm: enable pmlog support for smu_v13_0_7
Date: Tue, 3 May 2022 16:37:14 -0400
Message-ID: <20220503203716.1230313-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30d71fbc-ef9f-48b3-7f77-08da2d44c687
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB44357F7AA2903FDA6340F9ACF7C09@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qOqqYC2lK408Pw0vcBVZxNuTPX03/gbB7LEO8s22RhxcOZ1xZnpeyliPqDH4xxetIr8AisGzl9XPMpncutxvjBLL7pq8I3Xl+91+1rfpIhCllNH8H4lvGysEkwcScfKoo6Xzq7tKnWEMtuNtYsPwj2A/jgu2ZJQHCqtUbSYazzDpZ4ETde3tgReSJIucyENGvQwae1D1K2FaghJQUFbDoZQ8MkNY2dgliUPU6KFrSYHP53SaZG+VMFlFdG6EC6X+WTnUzt082E1on9nkFuWC152HwT/pNorV0XMGVwrwGN80sTRHSkVQFMUws63UrgBFCOOwk72MRO77xEtzqgqNti3NyKe7z3zzgoGvRVQMfpS+eSV/BIbq0vxnoKOj3lKQoGH6GezDk8XbXwjiGcDK6I4GA0w57dgn5SwLPzv+tNExxA9PEnnCRmGPDkUeWXnnekqZOUzhpQQtm3EHwJT1Wd9BjkRWTincdisGOcGen6qnN6t3HDhnF5JcVu8+zADMiKTyxf59WVgDofdvkNORSqYwUU8Q+73Mi/2HQ4ah1bvFLaZxe6rc2mNpRVflIUoZRA85CuGaPT4tIK2U/v5+vM/pTISKYvJuEz1fNkgJ4E8XNuAwatTHUnAzy8t4F6K9gMuycs9fM09swkbjrEFXO6w1o8FpIV1Xle3xVaGQQgkoRviiAaJJ9CICHR0hbwZiU2EEpaetGhdlK4Kk/vIzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(508600001)(5660300002)(86362001)(6666004)(2906002)(26005)(7696005)(356005)(81166007)(47076005)(36860700001)(2616005)(1076003)(40460700003)(186003)(426003)(336012)(16526019)(70206006)(70586007)(36756003)(82310400005)(316002)(54906003)(6916009)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:43.6266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d71fbc-ef9f-48b3-7f77-08da2d44c687
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Yang Wang <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yang Wang <KevinYang.Wang@amd.com>

enable pmlog support for smu 13_0_7.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 4ed5b557ecc9..eff9adad0bbe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1496,6 +1496,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.enable_mgpu_fan_boost = smu_v13_0_7_enable_mgpu_fan_boost,
 	.get_power_profile_mode = smu_v13_0_7_get_power_profile_mode,
 	.set_power_profile_mode = smu_v13_0_7_set_power_profile_mode,
+	.set_tool_table_location = smu_v13_0_set_tool_table_location,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.35.1

