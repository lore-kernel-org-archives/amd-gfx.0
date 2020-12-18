Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB76DC3526B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964D723B5D
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964D723B5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 411FD89453;
	Fri, 18 Dec 2020 22:29:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2083.outbound.protection.outlook.com [40.107.100.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 014BF89453
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 22:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9fq5aNaEJezw0h0KRoeFcv5BEomx/sL7D674CDSPnqMWMJBnjtQ3hRi6871Nrtim4xeFT06eZ+gQIwYGPuVuaM1/A0Q8QppGZ4Fozh8ANcLbroCZhB5L/Y7OssiPY71Fp6z5//WwE9olqLRRJyUQ4/N9KgtJLaDVhC3TpYOB9Js/xvkRat1M2HPuGVDkUhQX+zTWID6vXzsHva/jDaAjzy9XYtKGpaf44eeYNbX0qQuunJfTkGTYQKS05S30nzwuHijSkEonhSUBDKFrhAYnr8rG0me7xXhFVxFb5siI2wiOY4sM3rnPyc7abCUfjciwUoGBLeHT46bEgwPrnULhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecYnjrVhVzMh1Yp2MOc5gdhyJCyG+DpMNhDV++0l0L4=;
 b=FDSUMufNFUKASwHukde8LCKFhl+pAuluFzeSj88Oyxn0UbaQ+v/4RTtuU0oqFQdR+mmV1xFbQi+yK7aLCOmdlSAAhgcpsW3sQJUcaffj5IwigNE3JuXmkDjJiSInpPvIWwmE4ODltDaXj8cw++POpg+ak0QnxNlSMte9A3o/f4sgKJ2xx6wKnghfxu41vWP/oWoNS8GeaVaBjXT8C2X5iARvbKrsAhYD1p75aUh57B03TQuPcZujvpX2PZtfo7weNCiiovjybSfjp9lvmm84cxgYNGZSdNPNuvdeMmeh7F7MUapj+Nx+UdzQMw0yA8RfYe6vnfey4/wWW3ZrCSy9AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecYnjrVhVzMh1Yp2MOc5gdhyJCyG+DpMNhDV++0l0L4=;
 b=apBef6kRAM0tcvQIIhh9uyCXlfYLORAn5ogSi4+hREM0K3JqyhA+gubSNz2y0vWVijdRxmATO3HdMd8RWuRxlpLembPo1EjdDBeY3UMmn5LVvA8/sUnt54Ww2KLNwDGk9RMxQ0r3RTjpKYlXZutIahrHiKoUjs6CvX5OXww996Y=
Received: from BN6PR02CA0037.namprd02.prod.outlook.com (2603:10b6:404:5f::23)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Fri, 18 Dec
 2020 22:29:55 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:5f:cafe::c3) by BN6PR02CA0037.outlook.office365.com
 (2603:10b6:404:5f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Fri, 18 Dec 2020 22:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 18 Dec 2020 22:29:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:29:52 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:29:52 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 18 Dec 2020 16:29:51 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/14] drm/amd/display: To modify the condition in indicating
 branch device
Date: Fri, 18 Dec 2020 17:28:54 -0500
Message-ID: <20201218222904.393785-5-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218222904.393785-1-bindu.r@amd.com>
References: <20201218222904.393785-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b37b753-f97c-479f-43b1-08d8a3a47163
X-MS-TrafficTypeDiagnostic: SA0PR12MB4480:
X-Microsoft-Antispam-PRVS: <SA0PR12MB44807516312EAEA167120342F5C30@SA0PR12MB4480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Fwwvhb17zvaA6Bhy4D5fuYfe85D2y1inV5BHZoc6ezU4V2vwI1P8CK8smcP9BXW5G+RCOhnaUoY7x75GvzIVhRGrpXJHktFb4Q1Re27y5twU7v8fb4ReoqGg0XPLatr5jdRzIFpMQUPoWtFtChMbQr/K8UoE+U0NPIJr6f4jYtMxYg3M3cj+GIDI2LdsYimq48u+h12R9qVGIuMRBf1jfbFy2yyCbMEzeg2T7y0iOQ3DLH3RhxmeF799Da7Pgm/HqNfxCPxYWoYBDukDDrrzmlCJI/pdFIEmSAO9xhRjqkLEQKHP5Kc1q1o+kWy55JpSiXVRW0Ol03IHasI96TlkOGFkYNKCBm+dciO7kt7ZctcFme2P0suLM4uxv/O9KcY7gHkdnyamctSRmKz9FZ8xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(46966005)(7696005)(316002)(2616005)(426003)(4326008)(8936002)(86362001)(356005)(5660300002)(8676002)(26005)(83380400001)(478600001)(70206006)(70586007)(6916009)(1076003)(54906003)(82310400003)(81166007)(2906002)(186003)(82740400003)(336012)(36756003)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 22:29:54.4780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b37b753-f97c-479f-43b1-08d8a3a47163
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480
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
Cc: Martin Tsai <martin.tsai@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Tsai <martin.tsai@amd.com>

[why]
The sink count change HPD_IRQ will be ignored if the branch device has only
DP DFP.

[how]
To remove the port type restriction.

Signed-off-by: Martin Tsai <martin.tsai@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 6b11d4af54af..2fc12239b22c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3173,13 +3173,7 @@ static void get_active_converter_info(
 	}
 
 	/* DPCD 0x5 bit 0 = 1, it indicate it's branch device */
-	if (ds_port.fields.PORT_TYPE == DOWNSTREAM_DP) {
-		link->dpcd_caps.is_branch_dev = false;
-	}
-
-	else {
-		link->dpcd_caps.is_branch_dev = ds_port.fields.PORT_PRESENT;
-	}
+	link->dpcd_caps.is_branch_dev = ds_port.fields.PORT_PRESENT;
 
 	switch (ds_port.fields.PORT_TYPE) {
 	case DOWNSTREAM_VGA:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
