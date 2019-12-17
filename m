Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827B6C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 10:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0CA206B7
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 10:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M5J/7z2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0CA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECD326E040;
	Tue, 17 Dec 2019 10:20:15 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750054.outbound.protection.outlook.com [40.107.75.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE4C66E040
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 10:20:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ar8Pe6UUNLPM0ly/AJpgVkMzORPkASrpnDAiwP52MH2AoPlb1XDIxFs5G42xm1mVTZbmJSt5Xujv/H2T3hWjXC/Tv8VkO7emexjnVv7DZpK9q1HUCa03OUI9Cax2CYv/ajI13pJHcw+2vBp+OE3tAcgAz6s4Q5WXqYihVAF8UgCadOBLlzUBbNwX+G7ZgOn2oJnPQMMb/zBogXKo5hjQbIyn6Fz6iGhuouvh1NMJ8XsMIJqIxDvc5/iWXNX7KLYAT1jvo4YTN88wbDValPW9SwcHaaJlZpd5HQnBNSiXop27he6JfbbuwSFu8fpz6OLij7K88Ign2hGDVk3uELBlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhltFPDpppMslaGItwNcAYyMziElS92B0TVr0612i3A=;
 b=oHqwRjHHQRRZ18jJ9/UL3vsmSVEmItseaTvRADODMSFqYiOQt0rd6UQzbvKSTk/gFuN3rmrKCdykLrZvvS7Toi4XkB96NZGigdCR+rlKMZpr0NwZxk+vWnY+sLugu7P8ToiXfFvxb8F/WP1eqNQrtkY9uLApcHqoEVQSJF1hhwo/VNTYgv/J2PSOdeLaiBYKEJZCvrWoXvzW9xTX7IZq4iyDkQb9sjLTBz3OESvM6+hnGKNfGsBDs14XT05yeZTXI451zY6s+qIDEw1eY306ueTxNmjGXPi+rwzquaDfJyryqhrlhxiOo5lQgGVqFEumSRcGRp3OzhVA8T60XOmEgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhltFPDpppMslaGItwNcAYyMziElS92B0TVr0612i3A=;
 b=M5J/7z2FN1rjbvzvpp9S08qSoxI4ixBQeGgGD82k8re1Dd+BRvr5X4De0OEyn6gxNtXijD1j67sRSG9ntyu1p+5bo/S6MOFN192xzmJpt+h5QSHduP+HPVUlnWlZIt0vB0erdSD4bjVBjc8WCBdzrMJSkZaslJlK8znuG3RCkZw=
Received: from SN1PR12CA0105.namprd12.prod.outlook.com (2603:10b6:802:21::40)
 by CY4PR12MB1352.namprd12.prod.outlook.com (2603:10b6:903:3a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.20; Tue, 17 Dec
 2019 10:20:11 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::209) by SN1PR12CA0105.outlook.office365.com
 (2603:10b6:802:21::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18 via Frontend
 Transport; Tue, 17 Dec 2019 10:20:11 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Tue, 17 Dec 2019 10:20:10 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 17 Dec
 2019 04:19:57 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 17 Dec 2019 04:19:57 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: fix double gpu_recovery for NV of SRIOV
Date: Tue, 17 Dec 2019 18:19:53 +0800
Message-ID: <1576577994-12874-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(428003)(199004)(189003)(336012)(86362001)(426003)(8936002)(5660300002)(4326008)(2906002)(36756003)(70586007)(70206006)(26005)(356004)(6666004)(81156014)(81166006)(186003)(2616005)(316002)(478600001)(7696005)(8676002)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1352; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8634da30-3570-433e-ef0c-08d782dab2b5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1352:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1352F7DC51AF564BC7BD0FE584500@CY4PR12MB1352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02543CD7CD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PA8sQrI/8fEPlM3oOTA/qNTlvIay0lt91OD3KJW/Q0u+N8dPdfoLeu7JYlbv7uQm9llIWavIdP5jgvjbf8y9fqQNTX0CnYeTwMh9AEmUFJkl3x7LEt4ljq+X8g+mmVqxnPk69MYiBi2d0Xg0gGVtCxrYFwTR85V4EK1xjqioPZ0Z5rMZ7d0ZV2kLT7nroKhDEhBeSh5s0xAO+fasZdgSMhbFur/UZy82VWYxAjoeMp+hxiiQIAOqgo44N0mV+GcL7DWXQFpjvzL6ao471KFn9W3Xxl5tQRYqyroOcnWYFh+okRu3EPI/lCGPfUWeePgTUag1a5wvaodE2oTcTY7ACyFlprXcxaHp2DIRcfS/7hQZJyBysXgi0hIdbWUwFTAkSrmZ0mswBYZcoBU3b/AFiPhfaydQQR3mQ7WC6MhYGbge3rzWwSUjVdsPz/k6vLaH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 10:20:10.8543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8634da30-3570-433e-ef0c-08d782dab2b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1352
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

issues:
gpu_recover() is re-entered by the mailbox interrupt
handler mxgpu_nv.c

fix:
we need to bypass the gpu_recover() invoke in mailbox
interrupt as long as the timeout is not infinite (thus the TDR
will be triggered automatically after time out, no need to invoke
gpu_recover() through mailbox interrupt.

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 0d8767e..1c3a7d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -269,7 +269,11 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	}
 
 	/* Trigger recovery for world switch failure if no TDR */
-	if (amdgpu_device_should_recover_gpu(adev))
+	if (amdgpu_device_should_recover_gpu(adev)
+		&& (adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
+		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
+		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
+		adev->video_timeout == MAX_SCHEDULE_TIMEOUT))
 		amdgpu_device_gpu_recover(adev, NULL);
 }
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
