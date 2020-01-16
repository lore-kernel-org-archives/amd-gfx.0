Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4B4C33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E310206D9
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IzHGW9NJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E310206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E21536E480;
	Thu, 16 Jan 2020 20:14:35 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770042.outbound.protection.outlook.com [40.107.77.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E58436E2E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHU0fEuw1DJQXmGO7esH8P7PhaKW48AVRDpkvB6abLhGqal34eXDkbBJQxem5lpiLDlthDzp9Oyu+qHspso7YXJy8PLkeJIujoymULolt6SfeNuvr9quTQgjuKaY9P2eA6zzDfphnDDLPDu9iZwyzC/nYO+1r7CymdAx/Vh0UqYWCLdSW7Q55qQh/wIpfpJOP7wlInEfGX1OtWZlltFfvA2AGgeBzCjifMrtWHsZMl9nKdIOExAM25y+VwoDe7npK//QbZnXnRWxvC1zPEcZJ+aGKIF7D38mZovZbeBj51tLwgr8dsoNRsYquSc68hJoAU50NKbqCE+rG0ejiAXAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9PdVEtu/W3bQnuk89/ehE3YRyqDWVDpbP8LkSrEiMo=;
 b=l3A/pbEFV7kZ0qQ10VRLekeWcnKcCd2T2+5+sUA0YQ3gmfoMVtaqjMnrXNACvYG8ocwyubcYbG29YQkvQmZvzFNz46PzOf0Btngxrw6kwaWBrPWpyP/nmoR8566erCvggNHpdPrLZ7fnUFltgJOm3pW8Z/sBUBWVrrZYOHYgpAspx9y/+ViQvMpfCq1aDApmQlUEx8QFFhjo7pKUYidCkZ+EbDTSZosI66Tjru7ZpCZ9lo8MH0K+f7GEg5wHzM5eu8dYyM3XiPdOpF2GKk5xBNYvoHet1SHiKzrKjctODMjD/93kW0u5uDZD0V8mVAifGFiYxoSr/kCT2NAg/eCl8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9PdVEtu/W3bQnuk89/ehE3YRyqDWVDpbP8LkSrEiMo=;
 b=IzHGW9NJw97Kx7JLs1imlBSGvrgUaGco1rQCsZU45brlmkdcUT2qd3FVgKs1Rd52uGxj1XGNZZxbaULQmJgV6CqW/9340hXwOB008iylt4dhE+e03SxuaHF9eWyKlnEWrT9bioABOc8vZK0JOawqk0DksiA4UPEvV9+5o5C7C/c=
Received: from MN2PR12CA0012.namprd12.prod.outlook.com (2603:10b6:208:a8::25)
 by CY4PR1201MB2470.namprd12.prod.outlook.com (2603:10b6:903:d1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.14; Thu, 16 Jan
 2020 20:14:32 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::202) by MN2PR12CA0012.outlook.office365.com
 (2603:10b6:208:a8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:32 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:30 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:30 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:30 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/22] drm/amd/display: Call ATOM_INIT instead of ATOM_ENABLE
 for DMCUB
Date: Thu, 16 Jan 2020 15:14:12 -0500
Message-ID: <20200116201418.2254-17-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(428003)(199004)(189003)(8936002)(81166006)(81156014)(478600001)(86362001)(2616005)(5660300002)(54906003)(8676002)(356004)(6666004)(6916009)(186003)(7696005)(70586007)(4326008)(70206006)(316002)(2906002)(36756003)(26005)(426003)(336012)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB2470; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6145aa6-3f0c-4e14-bf4e-08d79ac0b296
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2470:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB24709AAECFFCD7C9AC785547F9360@CY4PR1201MB2470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZqjygnR+W8wfJ7L2UQjTLKk+Ht1T7ZlpO4fMaEV4n+hASNyIsU6Ak4DKgE4r4utgipJPL4zyXRVNsz8brMR6o4RuCaxFw+IG7tN7GKlJzvNWUdXoEQ1kz7rGEox2qiyiUdpe3kb26Bd+fKGajOOT4wjYqhbirF8UGpqfAd/9PPMy0SJ8BMygG6twpB4nHdt0xDn3N1zK0JLwJNFTtrbCcOoBuzRlZVAPHBI6P++aHPDVNkVh1y8O6/lCqi4WYSB4OarWjAxgrQ7wJcj1rOvYbaUdcBtoRg++2tIsztFyArrZ68KSsfN20/q7WWBW2G5a0XHWpncufm0CD3E+H75QxOkML+j9b2tq70yl1RT0RFQ8l4j04dc1EVgbLapR8TwJdO2eYKEEQ4ZC9rObzspTJcBC8S3jU9sZk6Io2g5QG2fViZrctSxdpFHHcnQn9Qvn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:31.5234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6145aa6-3f0c-4e14-bf4e-08d79ac0b296
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2470
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
DMCUB command table doesn't support ATOM_ENABLE/ATOM_DISABLE anymore
so we never end up calling the DCN init path in DMCUB.

[How]
Map ATOM_ENABLE to ATOM_INIT only for DMCUB command table offloading.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index c4ba6e84db65..629a07a2719b 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -711,6 +711,10 @@ static void enable_disp_power_gating_dmcub(
 	power_gating.header.sub_type = DMUB_CMD__VBIOS_ENABLE_DISP_POWER_GATING;
 	power_gating.power_gating.pwr = *pwr;
 
+	/* ATOM_ENABLE is old API in DMUB */
+	if (power_gating.power_gating.pwr.enable == ATOM_ENABLE)
+		power_gating.power_gating.pwr.enable = ATOM_INIT;
+
 	dc_dmub_srv_cmd_queue(dmcub, &power_gating.header);
 	dc_dmub_srv_cmd_execute(dmcub);
 	dc_dmub_srv_wait_idle(dmcub);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
