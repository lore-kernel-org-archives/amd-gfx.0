Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3672DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B1360F9C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 06B1360F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4574C6EE89;
	Fri, 17 Sep 2021 19:26:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8656EE82
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4tIQgh57lP9Vyp1DGJxifOn7Q9E0Mi0CpdQAYRDy43XCAA8Xr0DP9qeZSRE1z/U/HHaXEuLgBK4srq1uv0UnRLHxOY2CFig2q8WjqyRhNZPRHl4H5SyqPcX9wXqfgzjtjZgJutv21jgCj7FQWB3DEFni9T7S1hskWqGvOAwvMbOh9se3wI+xcmklUaAlURyJPfcQ4kp7p+OKIJ3VxLEHWXLiUvtApzVkkMisx/tVVhWgp15EuvrAdhNWItgaYn1cRLHohxUgLrPmRtwhLiKo7y51vbpF6rWlSG3bMi4Ylh0JOCGwLjXGj9jQaHPqkqgMpY3KJF34WZ05YIWDioz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=qZXY++ji7ri4UbrqcaETBGU+Wqc8kqpQ1698/a7LPSs=;
 b=hMtxdI2bColUQHcTgjkDOfhHV8hi8pBkbiGhUuR1R5y8sCjU8xBMFpI0YfyipIm46bAcavkcU+C+8kmGttngqIhsjiZVM7bE8FwFgnu/I1F6NekUkcLgduOn6qK6Ns3Nu1UO933WqSj+kGkXmOKagwuHrFXMFcSfZldiSPWBifWWcCmHlpCUOOuPlWOo6WUs/6rl+DXhT7w2lgCos7dIGih5Iya22luZCS38SZJpG0pILDme7KefjGj3gY9gPJG8IC9c4KL+trWIxSNcKYA0wnhpykXoSq7gXICQZNd/V8LBcKlHOdWhOg8K3X1gj5NawsKN3RYtR18GibQxm/1G3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZXY++ji7ri4UbrqcaETBGU+Wqc8kqpQ1698/a7LPSs=;
 b=1KITDAo2cFm/6/fLTyd6+/F7QEdEChiZbictdSIYhivy+dKcjqbjHJAKMJpGwiDKKV/OYAA0nNkE8XJzFW2xNNkPtQzg88uJL8tWPyOWOPLGzYvval7dn6KePPKHLjNUqdRPCzkzBxHspK4mvqQAav/EzKYpOrq/PAQ4asExsQw=
Received: from BN7PR06CA0041.namprd06.prod.outlook.com (2603:10b6:408:34::18)
 by DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 19:26:00 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::81) by BN7PR06CA0041.outlook.office365.com
 (2603:10b6:408:34::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:25:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:25:59 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:25:58 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, "Liu, Zhan"
 <Zhan.Liu@amd.com>, Jimmy Kizito <jimmy.kizito@amd.com>
Subject: [PATCH 13/18] drm/amd/display: DIG mapping change is causing a blocker
Date: Fri, 17 Sep 2021 15:25:19 -0400
Message-ID: <20210917192524.3020276-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
References: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abd49e35-eeef-437e-ac9b-08d97a10fadc
X-MS-TrafficTypeDiagnostic: DM4PR12MB5214:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5214F6ACC7FCA7BA8C3F156198DD9@DM4PR12MB5214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MkCTltcWQdqD0aWKqRRLNyjqiDGRP/WAli0skHd1ta1ZNWJglcQ01L+xmAcFtfpWclKa9LhsfrKRUs7VWG2tUOZRQIg7ILECRihLLyPCYTcDO6UVYaclSKqi1F4Qh1HFit5gIcDuXnFdIwBmoddG3Ut7rXfQwzDPFjuZV9hOOY4Z2aVfgESs44pt9F3zaITyuFriKuQM92qloQADb1MFq1T5688lT2uyG2aXIlHX0sMQ6zmTUE5lVmLtxysusI/gzRDQooZ+fO8SUcHaJ+P5cvkNdhPGXWranyLc+DTZUseDetrKldR+ZKkH6cp/87+7a1sV2l0KZNWRhXiEwLXseif0TXwBF36eIit67Dt8baHnGCVRLk5l/GTUY8sWMpwhRZqisDndsLYzV/AsM+yxI/VBAjnApqmQ3cc/iVNX2C5bIW4y1IAZDxcvHfRMiTen+1DXv9l2qoz180QcbOBEEDSPUYimuL+4CYovMD8kd9KKPplWuYQFjTNSfUNG9AkB+6bGRhNPRgUju/zYBuTygNWvAQD9Hc2yx3oKtddUHp5AvcpLRBZMWN4W2f5k/3MuL/kihqWGjAvRQTrGV+D+iFxjIny64rYtL5t/BVm5UFAVJ1gXd+iROgPmzAooBKJ4VGpQxYSLGwppN2IKv4rAlJzKt5yx3tg5f4gAeI04ukIWV6AyMC4Kj6DKg4A68NZozs0RAJ7HwtlHlI9KlSxpmENKoemrW/Tc4stykURkn/E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966006)(36840700001)(82740400003)(316002)(356005)(47076005)(26005)(2906002)(336012)(16526019)(70586007)(186003)(1076003)(36860700001)(2616005)(86362001)(426003)(8676002)(81166007)(5660300002)(82310400003)(4326008)(36756003)(6666004)(83380400001)(8936002)(54906003)(478600001)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:25:59.6027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abd49e35-eeef-437e-ac9b-08d97a10fadc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
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

From: "Liu, Zhan" <Zhan.Liu@amd.com>

[Why]
DIG mapping change is causing a blocker

[How]
Revert the change for now. We will re-implement it later.

Reviewed-by: Jimmy Kizito <jimmy.kizito@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Zhan Liu <Zhan.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 0b60ac676423..6f0c788d1904 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1383,12 +1383,6 @@ static struct stream_encoder *dcn31_stream_encoder_create(
 		return NULL;
 	}
 
-	if (ctx->asic_id.chip_family == FAMILY_YELLOW_CARP &&
-			ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
-		if ((eng_id == ENGINE_ID_DIGC) || (eng_id == ENGINE_ID_DIGD))
-			eng_id = eng_id + 3; // For B0 only. C->F, D->G.
-	}
-
 	dcn30_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios,
 					eng_id, vpg, afmt,
 					&stream_enc_regs[eng_id],
-- 
2.25.1

