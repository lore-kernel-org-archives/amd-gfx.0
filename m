Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF0FC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF9F22EBE
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF9F22EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 314BE6EA49;
	Fri, 22 Jan 2021 20:07:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B136EA40
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 20:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX+GrtUnC18KJl18Vy+lbRun+vXQl5lM088FcgXzFOnvx8ScA3K6Z0c6wZeIrV/QKbR3Z3VSW8Hq1XvC33STfFZcOLgGqsHRx/t4wLp42jBRcGPfguXmYgVeKAy1UNhUqc5IfJcAw2Ie40CnrNTN/vRymc+waACjpwu6+nMsT35pY1V3PtpryA1Pab8wcUZSqJ6VFbiDKkOtSjcVS535UrEMlHemnJjESY4xmQ4vd4G7ObZ6HDUJh3J3cmSueS7YL4FDu1/U+NwY9yhJpcqzu8rVf+W103uAv4Om04EDLPTinAn92Od2Z5SuQ/W0RXJVqTiMpOiVgkgXnQ/Wp7vXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oL3s6oaGAPilqz6ey/1fSP6UA84MaB4YrVTHvaGYmqs=;
 b=hPymIOig4nY18EWk3NDuFMA2CCJxH4AUEuDI42hA7Lkx78W8gBdkIs/Q9gDYJHCqQm6Kp/FhOGEG53kZ+oAiblHSNqkGqad49mwlRG05vVQ9NRTTBer3ntiyhT8OiNyD0N/CcAOnpb3/DruUBq6BtsqewC/WVUUkK90YXrjpJXsomuundOEz6QkeHIXiMDjL5eVjHZ8OwwNMf2V8duZ2ktkv7XLEm+06mIKov72gXqaypbjT1mmHsvjCpeZXXNv6osWI0Br8PVoibidS/vHk7CE+gRoxh8fmH0XWOqohz3mqdt8SmNaDyr6EbEAD/mQGbZIbeo5XANmNpo6K3O16Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oL3s6oaGAPilqz6ey/1fSP6UA84MaB4YrVTHvaGYmqs=;
 b=Ucsol10a3+Sn99BPRYeMmVKcvAho/zbZrVSP6qg7G0LL4ACC3L0ZoroimHA0dUVd2yI5cbAfGFx8YLjTPgkP8F32rnnwovVmzS+mrzmVm8NwKgI6bKZgABFLA9sjc0w2LyHbji/SQieHF5RdVWu2nmY42ryIMy7i9ygkeMiV6To=
Received: from MW4PR04CA0204.namprd04.prod.outlook.com (2603:10b6:303:86::29)
 by CY4PR12MB1879.namprd12.prod.outlook.com (2603:10b6:903:125::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Fri, 22 Jan
 2021 20:07:02 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::92) by MW4PR04CA0204.outlook.office365.com
 (2603:10b6:303:86::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Fri, 22 Jan 2021 20:07:02 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 20:07:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:00 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:00 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 22 Jan 2021 14:06:59 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/12] drm/amd/display: Fix DPCD translation for LTTPR
 AUX_RD_INTERVAL
Date: Fri, 22 Jan 2021 15:06:42 -0500
Message-ID: <20210122200652.197934-3-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122200652.197934-1-Anson.Jacob@amd.com>
References: <20210122200652.197934-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aebf777f-7c46-421b-92f5-08d8bf1147d8
X-MS-TrafficTypeDiagnostic: CY4PR12MB1879:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1879C124ED3E7B3CBCBA1FD9EBA00@CY4PR12MB1879.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QoFJDWRxBR6fnxPD2yGwzvzNcy3JG3ZAXQNa3XbcxEHvfxSm4GkppSIg9cCEWFlf5YjDNTzMvE8jN1i68YEKtLGTdnJcgsiOkdi6DmFZqJ/b7LhGaXCJM7t1/Fs2ZYbiCVBbyMhIuxyAPufndO0oOZy2yjcIceZv7PnHhGGHRPtIz5UpwWTF9upujlSQ6sWE9za5N0VYz1/i3sLcwomBukIrVsAKmwnjqiBR3/t+sBk1PiHwCs18Wb9Kfom7DEKzaZEFu1AQU/FgJ+FNDGrVmFKqXL5QoyQ9B0SLQXS3bx+/BNUlB+PX2wkvyq7zlh4IDm82FULo6z0IWW8AtZyM1/x3af2gopjoxvK/LXJQhBjNkeQ5g6yKN1P5x0IrXyaUERzJIuniWLHTXFUJk26Qz+gs6RIE1ehfcziGZ+QTelwUxgsTgtRaIgA6B6lA25z3bdpV87cNhMHcwopNYv2eiq7j1qDr2VonFwRIicUnODGF/+r31rBAsrLrjpGl/vLZX7HjjnwLZra3m2jP0ct5V1roj+x9Jje7h0SpQYvSWKaBoBIUR85MpDDjYFhK0P4kotXF8QF7LQXo8sCNgQCbslAHYqWqpsR9ww/5VQou/6pPegwjbBzd3uO4bLrkRJZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966006)(2616005)(70206006)(8936002)(47076005)(5660300002)(4326008)(478600001)(70586007)(186003)(82310400003)(8676002)(82740400003)(316002)(83380400001)(6916009)(86362001)(7696005)(336012)(36756003)(26005)(356005)(54906003)(81166007)(6666004)(2906002)(1076003)(426003)(36610700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 20:07:01.2021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aebf777f-7c46-421b-92f5-08d8bf1147d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1879
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, George Shen <george.shen@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
The translation between the DPCD value and the specified AUX_RD_INTERVAL
in the DP spec do not match.

[How]
Update values to match the spec.

Signed-off-by: George Shen <george.shen@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 4149b8771462..78857c97289d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -892,13 +892,13 @@ static uint32_t translate_training_aux_read_interval(uint32_t dpcd_aux_read_inte
 
 	switch (dpcd_aux_read_interval) {
 	case 0x01:
-		aux_rd_interval_us = 400;
+		aux_rd_interval_us = 4000;
 		break;
 	case 0x02:
-		aux_rd_interval_us = 4000;
+		aux_rd_interval_us = 8000;
 		break;
 	case 0x03:
-		aux_rd_interval_us = 8000;
+		aux_rd_interval_us = 12000;
 		break;
 	case 0x04:
 		aux_rd_interval_us = 16000;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
