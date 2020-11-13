Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270A1C56202
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE562224F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1Gj5d/W4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE562224F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C7076E843;
	Fri, 13 Nov 2020 20:58:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14B4A6E844
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:58:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvuJ5mqyeiev5daFvTQMuNSsRsbB191mzPrN8q3ANNLRgRi23vMUsbOVH/CM0RuXNicnGuym+olUY+Yx9XjfIPr0jobSlImqrhtuAorwVoTGUeZqZJxEXV90h0pw+iCOrBRdHwejUGD/vbnIK0TFEc78QejDX+w7TOmHp+295Lwk/a3H/aHE3ZErkO2a+UeP/ZKHNAGtxs4PyvaXXawqxxnZaoQ5O5CDuJILMS2AeCuSDfpJddZcPPxbY5hFkCgqXbGJKc6R5wTApyuvGdb8dvIQtVsydWPuNpKWf1NjBdfPcFSw8bgtlieQLI6NOo0Yr/3Vg3RACN1cOdT8MpVJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJpPCSIiXMyv8mja8YzSJg/vmyrVhaY1kHcwMIHY+CM=;
 b=EXiXfCXnj7/NbbQi1ilPsD/+5peVlBMcQFSVpthbOguoqsN5a6arhTiOy3N54Z+WMtuNTUV/SCZQEq7MHoAcAK5aqArW9STYtkSEcEvFx2yv8QV5gICVyrWoZ3LQKvAUSohuYrQRAFndaqmkvZRo7NluR2c4FAlkd04eiYlrE4ei2AuowVhhv1ICV4OX+/3D5pklqlIJ2FrD7agHzB5xhxlx3J4YJKyzYkEm/GE8aA9w7SnPTDca2mQ3269h5zZum/rTLmYSnjZ1H++LIkEIiiaQtnOk0pQ9cbC4964nLAUpD2W83MTS4zMZhWcWfhmfmWtr5N1Q6Qn2nPYULYPxyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJpPCSIiXMyv8mja8YzSJg/vmyrVhaY1kHcwMIHY+CM=;
 b=1Gj5d/W4eq+1sD7ZsgfRfLMheiqvetRAR9mvroWKD3dDYhFJih8vNkRDOM5Pgn6CNXnlgHAAVtTKzMYO7BdEFl2qwhaBP/5x2Tqu4fr88NiAgeKUofRYyn2JxbWXaSUiFXKiMNGYiiGRHbfHYv4xoJC02+cUjrnDRRJEg9uMusg=
Received: from DM5PR2201CA0020.namprd22.prod.outlook.com (2603:10b6:4:14::30)
 by DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 20:58:10 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::6c) by DM5PR2201CA0020.outlook.office365.com
 (2603:10b6:4:14::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 20:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:58:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:09 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:09 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 13 Nov 2020 14:58:08 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/17] drm/amd/display: correct data type
Date: Fri, 13 Nov 2020 15:56:42 -0500
Message-ID: <20201113205645.640981-15-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113205645.640981-1-bindu.r@amd.com>
References: <20201113205645.640981-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1443bfc7-f828-4696-6d72-08d88816d412
X-MS-TrafficTypeDiagnostic: DM6PR12MB3435:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3435F5308A367F916990D952F5E60@DM6PR12MB3435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajF15elfzC9+hXO97tefyyynXzZpDq0aRtVNVTgLtOZ27zZvQ1BhqZ1lS8CIV9DWZo+ncW3FUJpeRf2nRRjWW1JtEd9ps67diKBigiEgvjPc2NiAT5K9kXyAaTtBUlmLdaMzsON7gy1XZIfWGTxAAkn4TdQMgF4KYMOV4nII28duS8uxOL/CnlJoNEcQ8q0jISTixBDKtxYIXN59yhqin0Fiq+IW/d49Bz0EAIta3M6N6UsLBdLrFM5LnsmFQrMm4pHYynC92zR2GPpUxiEjCmMCh3E6yQX4CGRPzMA/WpuDLd2droG91/kz0u8ZHzP5vmaqcRoWjG/EEBzAAdH1kq8+5MDvT/9ps9Fuu40GzIFm6CVGp74265InSFFtgSs6jnSQe08HrdkqfvuKYJUigw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(46966005)(478600001)(426003)(82740400003)(6666004)(47076004)(70206006)(54906003)(6916009)(8936002)(2616005)(336012)(186003)(4326008)(4744005)(7696005)(70586007)(5660300002)(83380400001)(8676002)(26005)(356005)(36756003)(1076003)(2906002)(86362001)(316002)(82310400003)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:58:10.0581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1443bfc7-f828-4696-6d72-08d88816d412
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3435
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
Cc: Eryk.Brol@amd.com, Raymond Yang <rayyang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Raymond Yang <rayyang@amd.com>

[Why]
We should use int for counting variable

[How]
Change type from bool to uint32_t

Signed-off-by: Raymond Yang <rayyang@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e282c2211f42..96ff556e2567 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -483,7 +483,7 @@ struct dc_debug_options {
 	bool scl_reset_length10;
 	bool hdmi20_disable;
 	bool skip_detection_link_training;
-	bool edid_read_retry_times;
+	uint32_t edid_read_retry_times;
 	bool remove_disconnect_edp;
 	unsigned int force_odm_combine; //bit vector based on otg inst
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
