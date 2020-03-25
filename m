Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E38C54FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 03:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE735206F6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 03:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EsI9ZBV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE735206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BBC06E0E9;
	Wed, 25 Mar 2020 03:58:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B0336E0E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 03:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXqx2C4qOtfSZHqT4+Hvu00jrJIMTu/dgskEvrU4XdHF5MucWoy/kUBEPAxDTcnmqEL07740/KwuEtuJ8sakTanRGiAl9mcozl68f4ZedHdJqtbqTph1rg8T9VLGpFkEgkU+bCy41wOxDUn+dp/SPSsNNSD/BLsgfdV1bhgCFQghcE7zFqeRLIbMTE7aY+O9mTfY+Ikg8XWrdffzfFCU1MSOKdL/Rvue7aQ8b2yopVQytjtNv+65+OhR0m6ejuGz0+z1oNWxvHClvEAxsEw0tC5jOlMuri+bM92sKu/UUfuJQ5mgAOlmXc4jghmNntIG50mHYrY65jPz/CUEWuud6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63ISs6ENsSyZmuW/1yB61y0455HMMeogauj8kv3eDbU=;
 b=CC7A3/6+NyXheDzwofqMxG6IDnGSY8drXl1TFXkzD8P6hHg5IQchStw0CkgCyhpET/evqMfeoGNs6oCpAORwEneBi/zs5eO/22RY2ZE7oSIcSnyQxmdjqQ40CYdlWz9/MG9XNjM15SD2ooqhjPR2guyg0w+I3FXredXYLk+C1gw2BnYWw8IH9W/DGku2HX1a4X3wbOCqdYRdkxOnKQdJI6g32M1onRpW5tLHkCI8728CHUY2LWQnurh1PBN/8cqWXk2npTaxBgmPgLu3EnCcufeSGJY9r20MTUz+dWsbNDXTyirt04R9lK2y0nJzvHh1GDDnjtlFmSyqKvoddHHJ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63ISs6ENsSyZmuW/1yB61y0455HMMeogauj8kv3eDbU=;
 b=EsI9ZBV8E63Ohm/ghmhIa0A/5A7jN/VUOfQ+YXASFAQnoKeesGgaYE5YoV5O8QSBd1r9Ych+HUS/g3AAJzhCZ2SG8q5X6l9bmSGDjEVJQLZzn9Bc9bKRLbhMLceGo1v8Ji+XaiFzijNUIRd0oLees5/PEMYRBgKWcQTx0rszT70=
Received: from BN8PR16CA0025.namprd16.prod.outlook.com (2603:10b6:408:4c::38)
 by SN6PR12MB2701.namprd12.prod.outlook.com (2603:10b6:805:6f::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Wed, 25 Mar
 2020 03:58:55 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::fe) by BN8PR16CA0025.outlook.office365.com
 (2603:10b6:408:4c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend
 Transport; Wed, 25 Mar 2020 03:58:55 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 25 Mar 2020 03:58:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 22:58:54 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 22:58:54 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Mar 2020 22:58:53 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amdgpu: postpone entering fullaccess mode
Date: Wed, 25 Mar 2020 11:58:42 +0800
Message-ID: <1585108722-19098-7-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585108722-19098-1-git-send-email-Monk.Liu@amd.com>
References: <1585108722-19098-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(428003)(46966005)(316002)(6666004)(81166006)(8676002)(86362001)(47076004)(81156014)(26005)(4326008)(356004)(82740400003)(186003)(2906002)(2616005)(7696005)(426003)(336012)(70206006)(478600001)(5660300002)(8936002)(6916009)(36756003)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2701; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efe8f6ae-0ac3-4836-5d94-08d7d070d65f
X-MS-TrafficTypeDiagnostic: SN6PR12MB2701:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2701BE4B0C2019810932391F84CE0@SN6PR12MB2701.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0353563E2B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3EHlkRijfo+05dTNF8CNrTELSedAMT7n/el+imZEMQZRuXCxUuVCniZESDE93ly38IXLX6edcaXL5SFHqVGKuovtUyQIBNezf1RfEJqKo9js+T3W0RkbPAKxaRnrjH6U8Kss8pOu69dg36/AXeLLIJTCKvd8WiKyIMtPvXHv+W2ihkyt7HMXJmcANlVT/ZooaRXnjZx+EjrAgMh5syXH4MHVZS5h7GrZqLnOMan9Xh/DG00GQaNVMEa6eeOVTZ+rA0accdBxdnmrBYxeYcaH8+5TVGC6chJYXPE6rMJR1OVaAnDyG8EDXw16HFG+diGpdWWl8V+uFF0S3S1W/8yVFxf84kQ0xxVDCobaJp13wEkS+z3AslD+dW3et6sCmleVp3OmZSjk2xhJfUZnubU+pe0V0YRDu8yhL8kc7Fro14gjDBx9Lb856rE1B4943voPW4I6aAMzr/1J/WIVyiZg3Ut+yvh6VEBOqTJ5QjioYFS9rzfmZZy6rBjE/rjNihvb2Mclyb0xMU3DH15wZLmEgw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 03:58:54.7263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efe8f6ae-0ac3-4836-5d94-08d7d070d65f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2701
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

if host support new handshake we only need to enter
fullaccess_mode in ip_init() part, otherwise we need
to do it before reading vbios (becuase host prepares vbios
for VF only after received REQ_GPU_INIT event under
legacy handshake)

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 724ad84..b61161a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1814,10 +1814,14 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 				return r;
 			}
 		}
+	}
 
+	/* we need to send REQ_GPU here for legacy handshaker otherwise the vbios
+	 * will not be prepared by host for this VF */
+	if (amdgpu_sriov_vf(adev) && adev->virt.req_init_data_ver < 1) {
 		r = amdgpu_virt_request_full_gpu(adev, true);
 		if (r)
-			return -EAGAIN;
+			return r;
 	}
 
 	adev->pm.pp_feature = amdgpu_pp_feature_mask;
@@ -1977,6 +1981,12 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	if (amdgpu_sriov_vf(adev) && adev->virt.req_init_data_ver > 0) {
+		r = amdgpu_virt_request_full_gpu(adev, true);
+		if (r)
+			return -EAGAIN;
+	}
+
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (!adev->ip_blocks[i].status.valid)
 			continue;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
