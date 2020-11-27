Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA23C64E75
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4472222C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m5+u/P4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4472222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069586EDE4;
	Fri, 27 Nov 2020 14:11:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 300ED6EDE1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 14:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbIi+mU1bdZBeh16Rfdo3g4yqKNM5sc7Wuxih3XI3cbylPvYsJZcCEFV+Wm5Ii9eLlNzauOHG+AjYHNNWNsoLaD32jzUop3slc1gkl4QSid7BgsjUVKEJ8HXv6WfIFQByGSGqH9XRXry7EKRhQByHuw0ag+YMVRsxxbcIS2bPz7eeS09Vt9MlZyqMdm2NGz7MIUxsiDfbRA2I+c+HFlBcxmloebry4rOESl6/2p+EjChhgG0tWYHEmmdcsdmsRlBU2DqaQmt54T4R1JofR4pCVpma9CaS9vQrfxLarZlTiLNA5KoFtIyf68t6TQQIgf7xJ1Xpu/IoIuxroVqIiXgaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIjgJ1iahlq/12WzaQ6KuuHoxBaemd9pOi4aYqeI1Fk=;
 b=eSlIEbmsuYSVkw8mSWn0qnUcNRUQtZXKMZjO13qiHpjQo1io0wVsswpgtar2ORKi+8HKfYuC2We9SWjorNfV+F44obWNFca3e+UKci2E/dVkyLzmOOZ9216xM0jKHp3a3Hxo7suQB8UDKCjbMDYBuWM0BEV/4/Xek+Ere3KjFbMG5VTLQuDLF2x3gHtYWI4SfnRl3JT6TfaYOxDvGWwDB9NRSSKi8PAabjOFvrW/Oasn4aodFkyD2hl9zAgCPDmcwHclmQ+APrITPMFtHCciFaNqssYh2bwqDHVHr9ldPpqULZmbTdOAe6LgH7AmNu1QkKLIoLlI9dn9kJDYJ+LQsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIjgJ1iahlq/12WzaQ6KuuHoxBaemd9pOi4aYqeI1Fk=;
 b=m5+u/P4ZrMzVs1Pkpx8lP13pn4jq6Cr1JapCiCAg6N03c+M8x6N7Oz6F7byk3lOZ2YFzJs18Y8Zwo/y9JLyNKeQgKn+PRIZN1hW4zAlRX433werXsRNgmVJm4D/oKTkvQuFNCg2CA7LN+QncJIvDvA0n89sbcgcHKrAEaXXrCAM=
Received: from MWHPR1701CA0015.namprd17.prod.outlook.com
 (2603:10b6:301:14::25) by BYAPR12MB3045.namprd12.prod.outlook.com
 (2603:10b6:a03:ac::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 27 Nov
 2020 14:11:18 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::dc) by MWHPR1701CA0015.outlook.office365.com
 (2603:10b6:301:14::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25 via Frontend
 Transport; Fri, 27 Nov 2020 14:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Fri, 27 Nov 2020 14:11:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:16 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:16 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 27 Nov 2020 08:11:15 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/11] drm/amd/display: Update dram_clock_change_latency for
 DCN2.1
Date: Fri, 27 Nov 2020 09:11:00 -0500
Message-ID: <20201127141107.7731-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127141107.7731-1-aurabindo.pillai@amd.com>
References: <20201127141107.7731-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a31efc23-8b4d-4a69-d3ee-08d892de4edc
X-MS-TrafficTypeDiagnostic: BYAPR12MB3045:
X-Microsoft-Antispam-PRVS: <BYAPR12MB30450A696856686A15985F4D8BF80@BYAPR12MB3045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ivkqf+5ud9I88dHcKg+MnVC/bvWltf9Rx/cGgPbSM2dteYXVI/dH/gbR6MHKhAibSOPbunSP8b9UhKP1Tu+fqAJSCpCaR5C2kzQp7wCY0loJrpDVXxGcfDZqyQ2hg92n55QG5s5E/8/zDiWfzhftQ738RKTj4UPwKxfxhamZAOpQuJmquIr3bKQkfd43Laf+1N8q5tOe6IWtBn8QQg6J8svyMZsOkcvOEKeOz1co/4ZdsTZS/MFBPOIpCl+Lrzpa9mrFYIHhYlKJxhWufGEYH6ikvau4zukxOhgY+rgrJ7AezdpZntqi7ZC2ynEBapHduufuX8v7VQUCwujmp1OfKcIaao/hXlcMRTpd79i4/ePVYeajpFTO+yDlz+6d2K9qcN2DPFgT8eAsiP7pq97Alw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966005)(82310400003)(186003)(478600001)(26005)(15650500001)(426003)(1076003)(6916009)(2906002)(8936002)(44832011)(8676002)(83380400001)(82740400003)(86362001)(4326008)(70206006)(2616005)(6666004)(5660300002)(336012)(36756003)(316002)(81166007)(54906003)(356005)(47076004)(70586007)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 14:11:17.4676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a31efc23-8b4d-4a69-d3ee-08d892de4edc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3045
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
Cc: Sung Lee <sung.lee@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
dram clock change latencies get updated using ddr4 latency table, but
does that update does not happen before validation. This value
should not be the default and should be number received from
df for better mode support.
This may cause a PState hang on high refresh panels with short vblanks
such as on 1080p 360hz or 300hz panels.

[HOW]
Update latency from 23.84 to 11.72.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 1c88d2edd381..b000b43a820d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -296,7 +296,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 	.num_banks = 8,
 	.num_chans = 4,
 	.vmm_page_size_bytes = 4096,
-	.dram_clock_change_latency_us = 23.84,
+	.dram_clock_change_latency_us = 11.72,
 	.return_bus_width_bytes = 64,
 	.dispclk_dppclk_vco_speed_mhz = 3600,
 	.xfc_bus_transport_time_us = 4,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
