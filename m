Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB22C2D0C5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 03:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A24F20716
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 03:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3232LmmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A24F20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 927396E939;
	Tue, 17 Dec 2019 03:47:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 037436E943
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 03:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZya6/KP/ImWv4+GWE1ooPImS06YHkqoDYMnbg9C44GR2ofVzBKo0e9CYr0sAF8ZutJ7ECSPI77BMo8DmwF8li3MyTmPkiXtOLSdxJZOIhhBDJhy2QKk3b5oeyTfRxbX1U58qgZdK3GfoPsFjnQsKp3yCENqf0RgIlEr3KSUXHBrGrISVbR2/FX9vK/IIOT30bh6Vma5GgC1TSCvqqS1WUzW0/D4mNsOfpy7fM6WKC2qJs7n1KcAUrWeOaOc3tk4LNsjt2pQPN1mbfkmAfZ0Kx7aJy7qUbtGJg4ceSiDASo9jLJPIMmlw4uxUnWhY6hdoum/4TQUOOkDXqf7gmJYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJFOqFH+QUt+nKHEkeoOTXpcTCgkmaDUOeSrHfOhGSM=;
 b=TQe73cJHsIdwyRKMHZmXSPEBifRAbWPVpOmRWQijn9Nirrp+XTt+KxOEmcGNJ7xpDzzhRWNEwPNNC+R1ZGWU1GpxYw3ch8fNrKT/ay9ec6qNj7JSR6zrt1ltItD84AABg1hjyPFSQwfjCIz9P2SDY7JYRmplE/xb0wcs1pLa5lNjH9U6zRsVX8OLhlS9LFDGUIQzg+DYmEFZ6wG4m+ogaKG9KNmK83bNEMNaZ3oScJP2ZGeKJpq2T1hsG8DoP3SiRUnAQMwj80AGfCqm83R2NpUzAmlvECr2e9zAmH4Eu0RVwNpIeq8SLQE+sYkRjaLt2qCXsG8qOuQlpZ/qeJ32vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJFOqFH+QUt+nKHEkeoOTXpcTCgkmaDUOeSrHfOhGSM=;
 b=3232LmmGEGdE1njiwuVu6FLyH59spBfE+yVWWKvc930fhVx7JoCU+AAIxx3/gxx3S1aaJC8vvvmGcvMcMNn9wjgUBCz1ZZGD/9D/ab3LsW4WFSbpneCud1kdeArSMLbiHQXjyGdjijpenyJRpKCsW/Q//RLz/T6B7QmrsgRkHXU=
Received: from MN2PR12CA0016.namprd12.prod.outlook.com (2603:10b6:208:a8::29)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Tue, 17 Dec
 2019 03:47:15 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::201) by MN2PR12CA0016.outlook.office365.com
 (2603:10b6:208:a8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Tue, 17 Dec 2019 03:47:14 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Tue, 17 Dec 2019 03:47:14 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Dec
 2019 21:47:14 -0600
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 16 Dec 2019 21:47:12 -0600
From: Yintian Tao <yttao@amd.com>
To: <Alexander.Deucher@amd.com>, <kenneth.feng@amd.com>, <evan.quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: skip soc clk setting under pp one vf
Date: Tue, 17 Dec 2019 11:47:09 +0800
Message-ID: <20191217034709.21719-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(428003)(199004)(189003)(70206006)(70586007)(2906002)(4326008)(186003)(8676002)(336012)(7696005)(110136005)(1076003)(478600001)(6636002)(26005)(2616005)(36756003)(81156014)(6666004)(81166006)(316002)(426003)(5660300002)(356004)(54906003)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4085; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22b21090-feae-4b30-860d-08d782a3ce36
X-MS-TrafficTypeDiagnostic: CH2PR12MB4085:
X-Microsoft-Antispam-PRVS: <CH2PR12MB40859AFA5F5FDA0CED207D13E5500@CH2PR12MB4085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02543CD7CD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T9wJAPf6M8edzCrf7j8rk9BsirUyej6yrEOqyBu/qKGLxp8C2WhAOOlK72iCTJwz7dsWEk3Y/CN6tpMHIHYxXwSD6DrEyqrirts1EG1fpajsnLnRIOI0vCzyFSON/tZQZpcE3AQjbBzDmQ05r0MKCuZIc2Z0VW9gQYkXt4vlnIILzKjMhw97eoN6IsOx789s7qdLswaxs0XoBXb2nXD3Ts2HgJ1yUF0PYZdaxQKFX/M4E3Kkh3DYmsk7IdTgPaoiJHLIoRLqI/taqfcIWnHMIIlFzC2mqhQs8nANln8j4IfxVTCcdYV9feasW34Qw3r/YR0/wS38Qgj6QmCUiEuHaLzeSQr9GtZLv37JloQZCSu9IEu0Xy92m8xq2u7b3Kegrfu+Cff9PBUu3kfKmPHoc1SEW2A67h/KmfWRrvZcqH8ikjDPRsiiTafMB+dqB8Jv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 03:47:14.6764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b21090-feae-4b30-860d-08d782a3ce36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Under sriov pp one vf mode, there is no need to set
soc clk under pp one vf because smu firmware will depend
on the mclk to set the appropriate soc clk for it.

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 148446570e21..92a65e3daff4 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -3538,7 +3538,8 @@ static int vega10_upload_dpm_bootup_level(struct pp_hwmgr *hwmgr)
 	if (!data->registry_data.mclk_dpm_key_disabled) {
 		if (data->smc_state_table.mem_boot_level !=
 				data->dpm_table.mem_table.dpm_state.soft_min_level) {
-			if (data->smc_state_table.mem_boot_level == NUM_UCLK_DPM_LEVELS - 1) {
+			if ((data->smc_state_table.mem_boot_level == NUM_UCLK_DPM_LEVELS - 1)
+			    && hwmgr->not_vf) {
 				socclk_idx = vega10_get_soc_index_for_max_uclk(hwmgr);
 				smum_send_msg_to_smc_with_parameter(hwmgr,
 						PPSMC_MSG_SetSoftMinSocclkByIndex,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
