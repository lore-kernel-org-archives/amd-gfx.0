Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79B5C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 08:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78708218AC
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 08:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="abIScMTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78708218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13DBB6E416;
	Mon, 20 Apr 2020 08:05:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AFC96E416
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 08:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvUSJvmQJLk1Vih/hJ12WedngvI1pAio1QU2KSP2h0zITZJXr6Uom41+qdW9lLs6IpV5K3Rp6hFvOyISqf91Yts1gIoTkAkO7MIZFu/dw2k+wr29WEOg4+tfzLi5mlmdfYXk81Xza9yNDewKmXI2GfhL5AIXsRwyIlPNPlSIEU2PPReYvY8vYH8UIeiHDUY5y8KCI8AW235xnyymxwCEEqI9ktATj4BNzqEl1NfpwzbsojlUC0z23RGhx28mmZ/p73r84rlWi1mM+IeoHjFYLb/OPbzmbmx1C8X6FJ951pee6yfKglUP2yNC5B5fy+wIkfZ55b6klu5IwC4MMylZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mexwxzgM3/qndOU3/TL4rl7TVtj/EAahZShMb8iAMrY=;
 b=mD8LfCjTnoWnNFfTslkgzx4P3/HFHpb47Umv2trP9itOppUQWkNx01WQpvms/lBJ6kVINEpokz+CMpqm5KOay4UkrUNJt9y8CQcgj/7qAlqg1/TS0mmPBEgXzsPBTL0qePLYMOQIWH6hU3lvvlIEnUKQzMsZnLXWZkP5xwaQK16H+/ZezNE7v+krub2VvcQQHQpMnuPXOZWbp0XnulUcPBJbzUJPSWCbDJ9j4PBscd89PvTDK9it8raBSmWKLm5/PcWbozPxe2tF2ny7TGMuHG/Bxeszl0bwfp6u8id2cLYX89FshLlWY+NhJJsJk3/btRPeaIS0+A9k5Wt1U6HdpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mexwxzgM3/qndOU3/TL4rl7TVtj/EAahZShMb8iAMrY=;
 b=abIScMTT8aUFBqVG70ZDkK4/jB0MwDV2/V5OdMR/tFOjuV7a7igZGsa2LKolJs7yu6AqC1NKqqKdG/5PmcezlvOFQKUosu6tnHnTI2y7eXWM9rsiXoCLPeeUGK1AY2kliXTofp07ZYRSEdo/ZHiZXxu8D9dUgZAU2p2S3sDhc7w=
Received: from MN2PR11CA0025.namprd11.prod.outlook.com (2603:10b6:208:23b::30)
 by CH2PR12MB3800.namprd12.prod.outlook.com (2603:10b6:610:2d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Mon, 20 Apr
 2020 08:05:26 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:23b:cafe::76) by MN2PR11CA0025.outlook.office365.com
 (2603:10b6:208:23b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend
 Transport; Mon, 20 Apr 2020 08:05:26 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 08:05:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 20 Apr
 2020 03:05:19 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 20 Apr
 2020 03:05:19 -0500
Received: from jiansong-dev.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 20 Apr 2020 03:05:18 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: limit smu support to Arcturus for onevf
Date: Mon, 20 Apr 2020 16:05:00 +0800
Message-ID: <20200420080500.26212-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(428003)(46966005)(336012)(186003)(2616005)(6666004)(1076003)(2906002)(426003)(8676002)(316002)(8936002)(81156014)(4744005)(5660300002)(54906003)(36756003)(47076004)(6916009)(7696005)(86362001)(478600001)(81166007)(356005)(70206006)(26005)(82740400003)(4326008)(70586007);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5166187b-bd3c-43ce-6664-08d7e501955e
X-MS-TrafficTypeDiagnostic: CH2PR12MB3800:
X-Microsoft-Antispam-PRVS: <CH2PR12MB380061D1DFFD1EE7F5F2159DEAD40@CH2PR12MB3800.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 03793408BA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNAXa77tQdJ27ykfCzQTwO4XBidL6+p4XpdACt/Q1ldhfQsEUGLuCpIuv96Bia9TIoLiVG7XvT4/LpFg+qLXOYxER0WLXLZHqfTO+Ukwk0xRB1iN4iLxmOp0J+97W9eO0H1fPfmk8M9OuX8cVwYlO1x+kxGZD2PBmxuglSaHA5O5vfVUE2cuYjhef1bxHnD8KyqoaONf+1kIbatTC9MuxpIRvoRjI5xVt6tfeFR0gAFUpFQs0IUC3pwepB1OTibQECrobYexaFAReVECBIJxVwUftbW4xTy7BmrjIPHbacDMtfNv9u8YsVINRGc2ynEfMMMpVlFo5UTt80UIbHCQlp2aQLqqf/+tPwMBEirCgdRHnzTON8UxLK1xC0mjhX6M3GXAj7akynIzrXLsPejq3qf9PjPEvSRY7sIsHEFj48SV/SXPUFhxnBF7L00Diis3Kbt1HYikSpndtIIc+h0r84HWB1Hm7Y+rFcRgPcMWkW5DZpeYG9EtY68Sk1JTtAskHEHhbLsEJ79GK9Es4+QsgQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 08:05:25.9494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5166187b-bd3c-43ce-6664-08d7e501955e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3800
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
Cc: Jack.Zhang1@amd.com, Evan.Quan@amd.com,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Under onevf mode the smu support to other chips is not well
verified yet.

Change-Id: Idbc166bea203cabba7615a255541eb283f18e1a0
Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index d4599fa6dc0b..88b4e5642302 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -571,7 +571,10 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
 	if (adev->asic_type == CHIP_VEGA20)
 		return (amdgpu_dpm == 2) ? true : false;
 	else if (adev->asic_type >= CHIP_ARCTURUS) {
-		if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
+		if (amdgpu_sriov_vf(adev) &&
+		    !(adev->asic_type == CHIP_ARCTURUS &&
+		      amdgpu_sriov_is_pp_one_vf(adev)))
+
 			return false;
 		else
 			return true;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
