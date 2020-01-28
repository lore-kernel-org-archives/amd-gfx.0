Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5C0C32771
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 01:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C1C214AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 01:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="grY3Hft7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C1C214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 179AA6EC46;
	Tue, 28 Jan 2020 01:30:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7412A6EC46
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 01:30:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZETq1gbmCfGQ4B38xzhpp7LxSdCVKWmjYIHx+F3CbmLUTZ9O+w8tT5Lon9oTYFzPw181kne1Q2ol9+uTGqJrBbgcPFVn0SyHJ9XVrjc9d09Ok5ZWacnMByg9ZbBnxEMTde7pUpRnJsrPhnMij6r50BavnbTIRdUy15BZWkJkmjpE/HcdYtN8unzTB6a14jCFrlq3u4c7BMT7tbmPLF1glPbKWWK9wDBSerRdmjy0NCyO00vd0m0rVRJypwTc+LSGIQGWBbo7OV/3O3XwxtDZ5/WTApBv0tkTq79nH/SFyB8YbeccyR8OIB9+Lor0rZzu+qqDCOIDnW4g2FPlc7UQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2WB+Pp2A0FN4YhQz6HXH4zlxwVKhF89fgvNhYm/qms=;
 b=aSA6QJ/w/k5tLl4FUlbW7yh1mgYy5D2DIH3wOfTlhLQNYq3ZHL/YMKmY7BqserksAOJ7jfRJ5lZ7Wiym1c+o+z3hILvOKdLp+TCXL6IVOESGntO/tfydzxMAMAGnvTKVCVyovhTadVApcqJcR0tO/pv/2fdNpbp1acvc85n6p7rZ+Gued7DsbiiAJ7hLmbXmLO55cK2Jg8NJ/sCOiOmMNcHZkv4fpA4vErV//64N2eFg9Zv4/UbjPVADGordrQteVO0KfDaiBNAtT5zB3gvPR2DvHNzj2U53/xZeGRLHd2P1qL9CrmZsd341d6IQ2jdEPkq1M6am/E/MvB45FCBk/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2WB+Pp2A0FN4YhQz6HXH4zlxwVKhF89fgvNhYm/qms=;
 b=grY3Hft75lXhN1rPiDRAeUH+wYI5504zyA6LuYOsLfq4K3H411uMWLq0WfVf5TD3CiuuUjXeLN1kQlrNr115SKpIknP6fRx+HzBBq/URHlz4kiPnqLxTVn8yMC/XfKJxgGjxoXFcDDAIOAAym/o7YULkLSF3nSWX64yYO6Xud0Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from SN1PR12MB2366.namprd12.prod.outlook.com (52.132.194.147) by
 SN1PR12MB2592.namprd12.prod.outlook.com (52.132.194.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 01:30:05 +0000
Received: from SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80]) by SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80%7]) with mapi id 15.20.2665.025; Tue, 28 Jan 2020
 01:30:05 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v1 1/5] drm/amdgpu: always enable runtime power management
Date: Mon, 27 Jan 2020 20:29:19 -0500
Message-Id: <20200128012923.25536-2-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
References: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
X-ClientProxiedBy: YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::46) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.21 via Frontend Transport; Tue, 28 Jan 2020 01:30:04 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b95e81ae-bf4a-4738-d87f-08d7a3919a3c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2592:|SN1PR12MB2592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2592F437272D7D936131CD77FE0A0@SN1PR12MB2592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(199004)(189003)(7696005)(52116002)(66946007)(4326008)(478600001)(6486002)(8936002)(44832011)(2906002)(5660300002)(6666004)(956004)(2616005)(26005)(36756003)(86362001)(81166006)(16526019)(1076003)(6916009)(66556008)(81156014)(8676002)(186003)(316002)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2592;
 H:SN1PR12MB2366.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //O3lldg/DUgef4jDJrD1ZA6SU9WMRCQTh159hzYlQf341gdWZ7VHbP8PbkpcH142lk7FSN6QXcCpJ2z07OHv7JO14DiteMXcEGlyAU8ca+VI3KbRMeFdXPNi3K3Tn7ZoKvcE59VOyKx/hh3msXfrnwrqCDAEbYVjij3KkdwjRheUZGEk0NbDRlQ7WKCY+2cmW9WWPYV8c3BvMrUb3i9YU6hn1uTxMQ2zph/MLOmj5yNEgNx8vZ5DOXQBXTFu7gzIG04HGEfR7Dr4MvT7oohntBPLjSAZ6DBSFnLdUzAaUTBRGpaOrjNITbhjkfMzc3nzDlkrKXilzHvXeLt7iZo91HLvIDLMYyLsF9vW81nrOmXsXaP3n0l3eKW8ttURb5nsrBQvQBf8wPZJpyNWvwutAtsmcPWKqISQpMuzZ0ltOt9dQgl/UmL1mjtF0e2rUoK
X-MS-Exchange-AntiSpam-MessageData: XgX81ECeyohpqHoMnLaSZ2CnDAnflgD5EWkr2SHneFoHsZL7wwgNEESBW4s9/BzU4QAOpiKcZpE65WhFZejIjb83mdGcnY8b1uveiFlWR5OTE+EA6Lvq8A/PCIbEP46B3R3OeFfcnCIR2eP9SX+E7g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95e81ae-bf4a-4738-d87f-08d7a3919a3c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 01:30:05.1217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yO5s9GrAT9mZUMHBdBes8z1n91TelBiijurOZCdARUJ5AFV9oW0n4hlyfLmGbDITWTGQR7sksxAFCj1L9G21IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2592
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This allows runtime power management to kick in on amdgpu driver when
the underlying hardware supports either BOCO or BACO. This can still be
avoided if boot arg amdgpu.runpm = 0 is supplied.

	BOCO: Bus Off, Chip Off
	BACO: Bus Alive, Chip Off

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 3a0ea9096498..7958d508486e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -169,11 +169,10 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 		goto out;
 	}
 
-	if (amdgpu_device_supports_boco(dev) &&
-	    (amdgpu_runtime_pm != 0)) /* enable runpm by default */
-		adev->runpm = true;
-	else if (amdgpu_device_supports_baco(dev) &&
-		 (amdgpu_runtime_pm > 0)) /* enable runpm if runpm=1 */
+	/* always enable runtime power management except when amdgpu.runpm=0 */
+	if ((amdgpu_device_supports_boco(dev) ||
+			amdgpu_device_supports_baco(dev))
+			&& (amdgpu_runtime_pm != 0))
 		adev->runpm = true;
 
 	/* Call ACPI methods: require modeset init
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
