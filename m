Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EA4C433ED
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAAF661029
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAF661029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4E46E0F6;
	Sat, 10 Apr 2021 02:04:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C89C6EC73
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 02:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJj/XPBGK9kcacsiUueB6/Tslnv9dye7MmP5/jc1etUESCOehyzMv9ov4mOhVH99nYFE3HlXsaoTw9MjR0TCWQx11OIZZ+R3M7ey7fRRI66KW9DX9CqSParuGbQKFr3E+D3rGITvwUwvR0pmZ4HX0Gjrwawt6d/GnvP8G3XROU41TkvaCWUCZdIctvomoXWth7WqBnPjeM9wMaJppizvOK2/7BnNaAvcOybjzffsmirdOrc2Z4mMvqsy3Es/od5xwSgt4g9zNtBHNDbS+ywEUX9IL37x9aNaBUTZJNVVfNZ+bjQnxjUjDmUOhGBgiAaP26mU+/mSkSub/dbdvEADRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWIU74/QGEKQO5KNT7woZ0LD9TM6/X6OdLWiACVx18Q=;
 b=hHIy8oHhelJygnfPlRmQvrLoOt97HNAZlZ0IGtWdwph1XR+cyzSfggfH6QQWRfNOEEHX7DT+LtYD3ZHJYjuaG7EpZleRMw3bUR/fYfW1uUu9dQUpi9BzlUa3WpgHwiThcpR9+bP5mQmSegmmYRivlfdoh+E8ZyLOkIo1ZGFJvVEyI+PJMfThD2H59NGwof4Os05Cu7LV0WN7MfWVcE7LIIYpSzebFK4/IXbnCS1EXr1/Ypm5z99c8XtC35T8YZMgwEHDjpAoXMv3iVMQC3y9s81UO51rhn/Y/KYl0TTuTQ62BWW+3+dpfpFs7jAEWrQfWpHLqWvWmBdVRbbmHPuNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWIU74/QGEKQO5KNT7woZ0LD9TM6/X6OdLWiACVx18Q=;
 b=m6vY/OHgciqaJ1TdaKGU2TKeQNCEoYK/AvYqMpIivEEskt0G/5sQcoSiEkL/s3Y+pRkQhINzvYLCgI1+5k+OV3rl/q/cG5M0eL5SllPRnG6yPsHfY185lEeRG+7lKnPhxJ3wW2xV5U7V//w55wLpIyv1WiEwXZahCeKFnKFbTng=
Received: from MWHPR11CA0029.namprd11.prod.outlook.com (2603:10b6:300:115::15)
 by CY4PR12MB1814.namprd12.prod.outlook.com (2603:10b6:903:125::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Sat, 10 Apr
 2021 02:04:52 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::9e) by MWHPR11CA0029.outlook.office365.com
 (2603:10b6:300:115::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Sat, 10 Apr 2021 02:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 02:04:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:49 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 21:04:48 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/16] drm/amd/display: Remove unused flag from stream state
Date: Fri, 9 Apr 2021 22:03:53 -0400
Message-ID: <20210410020401.1100228-9-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410020401.1100228-1-bindu.r@amd.com>
References: <20210410020401.1100228-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 582141c3-58a4-4b5b-4d3e-08d8fbc50702
X-MS-TrafficTypeDiagnostic: CY4PR12MB1814:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1814BF39411681857E30AA6BF5729@CY4PR12MB1814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJKV9XgVC4FEjnj8q/PnK8Gr8l3M46r0RCTi1qnqHTuIbp68eXrPUzNEenjusUlnxVQtyLACfwKPDpCCiHz5FoxL7Tfc0vaPvwahCj2nmzF5UFRQ3KE4aGzF6lUfdwaV4r2y9ZyBxJfRv+MIKRTQQ53Zn6x3GdWUQHum18DcPnelNBfHkvrgrvoDZ8J5FDzief/WNr5/hmPKrpcwdgddbBYTjfUPhlJ+CZzqwC0LHvjHxzyqOWRNJjXfpayP9pe4/E8fP8Tt42irPjLwfYeRuYtfUX+HeBlF2bZugwSpvl4Ey/TifybhyVJqqMFRu8YSOvUchfRG1dSchSEl2d186XFXa+NdDydi+3sHw/quXZInDD0zCOWoBogUtmnYGmlOSHHW47Ic8NrNiGKwlMixjNRqFgfLtWmJ09OxH/GZqbf6MHBgQK7L01dO6gv9aLuTRE+thekCVOmf3Uxh37cfRiwv9hqkeH8nRL2oGRRFg+85WBuENIbEtzjcRVZ2XQshuQTlBAodRD9kx3PqVTZl+ieP6mOVVnmzYXko7oBAMLbpKMK3l/JNxy1caf4Asmcn8KUXWipkxaLS6Vf66LwH75MKB5y9N/ylUxbTlBqY1jBt2DFP3IYRHI1eFYLcP5eIr7Bs85nhYR8KAUwvxecZ2IYgbVtRoo/jq8f15c3rUrOsELnFxTtWbM5Aje9AMT0x
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(36840700001)(46966006)(1076003)(4326008)(2906002)(54906003)(86362001)(81166007)(7696005)(82740400003)(47076005)(356005)(36860700001)(82310400003)(26005)(186003)(6666004)(8936002)(8676002)(2616005)(5660300002)(426003)(83380400001)(336012)(316002)(36756003)(478600001)(70586007)(6916009)(4744005)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 02:04:51.5876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 582141c3-58a4-4b5b-4d3e-08d8fbc50702
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1814
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bindu Ramamurthy <bindur12@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why & how]
Removing unused DSC flag which is incorrect and is not used.
We are only using stream->timing.flags.DSC for DSC's current
state. Stream state as an input parameter and should not contain
any past status flags.

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Acked-by: Bindu Ramamurthy <bindur12@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_stream.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index b0297f07f9de..13dae7238a58 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -238,7 +238,6 @@ struct dc_stream_state {
 	bool apply_seamless_boot_optimization;
 
 	uint32_t stream_id;
-	bool is_dsc_enabled;
 
 	struct test_pattern test_pattern;
 	union stream_update_flags update_flags;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
