Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7FBC2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FE302082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x5v1S4vY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE302082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDFBB6FC40;
	Fri, 31 Jan 2020 22:17:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 644376FC3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHTgXDL/kXyaSqVfUnvCf1EkZEohvzvGgdbi8WAtArPThwzqz/CwNncyZ8ZQL65A5Tc90Bb32DBFYKj6odF5ONzIE80yUo8tWW/YvOALsw5vNbfrRBQNM3ZwGIIXstOmxp8BKtTgRuZw8/OStDRxdzTpEayjnJ51/TEU8BMWqCVt0E3UnTF5NseTvtDx0nKV5MFmvqIIHI5xvDtH/1z+/aCvhGqXGuspywujqdcLdA7pAIW0fwU1VUV+lGhweVi86LhE3wXWsbUMik1z4DIizqKBuT4YbIQQRIpyjPrmQ5weSEGNI20j+CAxyiVsByx8sr5fiUmDBcXxYv/TRgSZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqzCtNEMQISoaphXbSlAsdPC8/Wyi3lJarVffuTNqkQ=;
 b=VR5cGA+2+Xf83CIs/MmyBPuM1SlL+nJA1S9JXu21qXahDi/yNtk/cgoboDiBjijBZrwsGWfepISnZ03Ia2oLdthb/6kYwV4+FFQ2OY5nCkR4Mz83nqvoeyR6Edon3+Kn1tnpgYd1L6Ki2FOK9NtXqm9HlebFEXN4ytQ+lcwA1q6/s5ZXdhXW4IJta8bGS8aiFMSHWHFwAPTXtUme3ADnwsulEibGnC4b3gPIsD+Rm14lPr1Iw30nkBVUFDfLumYJPzMiGq6iSXXjC29FfyzEnure787zoHGltjjm6pRxGhaVfCL6tIe4KGo357cKWH+Yg3VBqXOylZ7r9sSsrkA3sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqzCtNEMQISoaphXbSlAsdPC8/Wyi3lJarVffuTNqkQ=;
 b=x5v1S4vYGfdYRZUa6YKSgT1yUbNvuSn5DImWbcBzd9CVJlHCRuRFM6izABBryeZyXjsp8TKg0K82f/767bKbzEl5Niy3JLoXTwvzoviQrkx1rQlscDZnXmygsLDOFKJyoajePu+9/AnTFvHytJjYBVBMKmnF+VC+PgSPfH87+YI=
Received: from DM3PR12CA0084.namprd12.prod.outlook.com (2603:10b6:0:57::28) by
 BY5PR12MB3668.namprd12.prod.outlook.com (2603:10b6:a03:194::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29; Fri, 31 Jan
 2020 22:17:16 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by DM3PR12CA0084.outlook.office365.com
 (2603:10b6:0:57::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:16 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:15 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:07 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:06 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/33] drm/amd/display: dc_get_vmid_use_vector() crashes when
 get called
Date: Fri, 31 Jan 2020 17:16:25 -0500
Message-ID: <20200131221643.10035-16-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(428003)(189003)(199004)(6916009)(7696005)(54906003)(4744005)(2906002)(1076003)(70586007)(70206006)(8676002)(5660300002)(81156014)(81166006)(4326008)(336012)(8936002)(2616005)(26005)(186003)(316002)(426003)(36756003)(86362001)(356004)(478600001)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3668; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f01a1f6-8bf6-4382-3507-08d7a69b5443
X-MS-TrafficTypeDiagnostic: BY5PR12MB3668:
X-Microsoft-Antispam-PRVS: <BY5PR12MB36680D68C27E09550D1AB6EFF9070@BY5PR12MB3668.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1AELrW7nrRYyOMqoNk1s/fu25Zez0EFhnM7ebffWPRBLbKW711tY70f1rwVnl43gZtAefMjFtbQpVRgzZn/Ly+OCOM6/WxCNMuHw7xJWn4QrWJWcbHzjmRLiLO+6udJqKQJuGeaFO9qZAthAleYl+XPKiZLxC3Qf/PPWLqZ9olDlS/cE0V3zBcYUssvGrDt9/1msAChhWyVZv7xdS4o4G8AtUH43gY6g6SXw+qChwAYMj6gcrHEh9YMAfRrxN6pxlQtwTFsFgYsPv6xuxpQfbyOHBwopSjMrOFjbhMx0cmxGSoIzuIrTmqbzgctVkMcpu9LJEMA63HpjQu4sLQWnrQ1nIKxJ0Sd+DOm8mw64j8Ir911LoOLI0mAyTqw+dAOX0HXpCv6vRJEfLVwoHlKNIws3nTfQb9a0yS6asREv7eOjo8aEbr+YZcfm/P51Xze
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:15.8445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f01a1f6-8bf6-4382-3507-08d7a69b5443
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3668
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
 Peikang Zhang <peikang.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Peikang Zhang <peikang.zhang@amd.com>

[Why]
int i can go out of boundary which will cause crash

[How]
Fixed the maximum value of i to avoid i going out of boundary

Signed-off-by: Peikang Zhang <peikang.zhang@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
index a96d8de9380e..f2b39ec35c89 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
@@ -62,7 +62,7 @@ int dc_get_vmid_use_vector(struct dc *dc)
 	int i;
 	int in_use = 0;
 
-	for (i = 0; i < dc->vm_helper->num_vmid; i++)
+	for (i = 0; i < MAX_HUBP; i++)
 		in_use |= dc->vm_helper->hubp_vmid_usage[i].vmid_usage[0]
 			| dc->vm_helper->hubp_vmid_usage[i].vmid_usage[1];
 	return in_use;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
