Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6959C25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 17:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B71610E842;
	Thu, 26 Oct 2023 17:29:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6873710E841
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 17:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k30UVenKG2Rf52Rr/X8OF1VJsWHitbeTsbXwQfO1nCQcX8wNJZ5wKQc7LRr+MJfJH3R0Gy9ZGhhhGcdGLmj9DUa2ghbg9uD4q3pe/1FFOV5CoSbmfF30LlP5XovLsLbhltJCNlNesaZ2Hb7jY3fDUkAyJvLUplCXSvQwrJfbfJfr9rUp/ielAlw+vBUZ0jRUPjUxvSng96KNCOyUqthS5W84PbDnQwuRwWEz9XMIZ2CWxh9h4z7V/WDgBGZzGHMx9SX5399VCUl82fH0dWpiZMEAZsE4hqxKtRzdpucLVZPSIUMwbcvRxL8XaR3OhdGxRe3E9o903luiU/dEm6jfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FCIzuAEjWtTz/nXCdh7cpJ/KAKDEWOnYrx11uzdyLk=;
 b=ATAvUFBiwXlRaeCSkWr3MUaBkatSW2L2rK6Nj+dvYUYs6rYFpuVIqgW+UXOzlRtFi7r8ONDgFATjHiD1zM3PW6xqAlehJMMRi1JLri/+tvvO8QwxUu6ijpc4CLMB5tAW9Yc1eLIUSUG9KDp0MKHq6T1aF0EuGxVnm9puez529+XDFI5Vp7Fs2qSPsWzsR63v4y/z3DSIl5LgieyEoQTupQXpa0mQZTrf0Qz829MhxS4bCt+6dZecjrXxczuKhHMNjzTvk1m0aBCt7PCI3Tdudiz1t9tuHZzrLszYm4NSZpsKbxs43vQKyLUb0iG7x4fLzViRTqX+QzarA2KyzQEurg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FCIzuAEjWtTz/nXCdh7cpJ/KAKDEWOnYrx11uzdyLk=;
 b=LjV0vr/tK8GNOIP6QJK9oc+wTd0fInQf15qrSz5zjooHECdCiwgsmePqVgqAN+QzMIBzrsXny6zXd9ZHYlQyu3DRa2Fmp4hk5qk8TJTJEA/GTpr2py4teUQs5h6FUwFvsbSCDZJ2RG1GbYmQjsN0p6jIsCU6pBlxtw1xxb84kEc=
Received: from SA9PR13CA0099.namprd13.prod.outlook.com (2603:10b6:806:24::14)
 by CH2PR12MB4860.namprd12.prod.outlook.com (2603:10b6:610:6c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 17:29:34 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::b1) by SA9PR13CA0099.outlook.office365.com
 (2603:10b6:806:24::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8 via Frontend
 Transport; Thu, 26 Oct 2023 17:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 17:29:30 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 12:29:25 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix S/G display enablement
Date: Thu, 26 Oct 2023 13:29:14 -0400
Message-ID: <20231026172914.31796-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CH2PR12MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: b25aba13-923c-4478-1f77-08dbd6491d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPoZVpvnW/6E/tbxG8m8a8Gs/2namBNFeQraqEklLQl3lYzl2p6UlIsPUrxZCwO0YMSkY8YF0nIU/Agta3Fc3JhUX13kKNFLAZASVRguHpDsypStapUnt3KtJB1Hb9687HqV+jm9L5PfkFMOfjw0LtgPVDPUfnutIiTyagmXmrOuJGsdZXJKaSB7YmhtwWjXpdLyWVDRmDoH54qA3YI9pve6O8hIlxSVKzlzGHcGKD5Rqbpv/03/IIZ+S3jWKlkA9KCPD0EazasyiorDHDuvE3pVhBp6PGhMTcWrhe/Xs+dwElCPpbFqz/T0ZToxh1HsIOak+3ZUxhuX4YRTqp2HA+AQ835DqqWG5Z2Bk2mOoeruyjvUepjDLMjGTFYXHuyNmjv952MBgIxa6UkIeMma9K2EXmpZ6wVQwQpNPsgxHmq7phNVBhhsY112HCgfXFXGEmvxnixTFKGXOkKYpdhRO4dyeJyjWIG9lzKU+DJSDrzM6T/cHP3BtaHFOTiyHu2DvSzcbDjlnnLFSZ9Gd0KoVIZX0y8n5j+eNrtHjcMnWUNRVhU+wf9+tv9J00pssdoOU4Hs56Z2QTeLk5Tb5WlBezqabKWV6uK5c14taMsl9vXM+w0du9jgYAVQilGft9uUUBehcnzB7ZkHA+532Z3NJyy8hlFOThkNe3az33oIWy9Oa/kc/85mDzbmosqnNCATm0EkW0sRm9F6PXD6+7N7h2OJhCt4+m0cO1kLQtjD+9tYb4F1qJl0Lj3xKtlFZb/xF3w/PEPpbodsUPvnkTYD7rnjiwus5FHcFS2OtCac/EtnDeDFPAXeGHfvfF0VyAMK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(2906002)(4326008)(8936002)(8676002)(83380400001)(356005)(44832011)(81166007)(82740400003)(41300700001)(5660300002)(86362001)(316002)(6916009)(336012)(478600001)(1076003)(426003)(26005)(47076005)(16526019)(2616005)(6666004)(54906003)(36756003)(70586007)(40460700003)(70206006)(40480700001)(36860700001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 17:29:30.6610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b25aba13-923c-4478-1f77-08dbd6491d2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4860
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>,
 Mark Broadworth <mark.broadworth@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Hamza
 Mahfooz <hamza.mahfooz@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

An assignment statement was reversed during a refactor which effectively
disabled S/G display outright. Since, we use
adev->mode_info.gpu_vm_support to indicate to the rest of the driver
that S/G display should be enabled and currently it is always set to
false. So, to fix this set adev->mode_info.gpu_vm_support's value to
that of init_data.flags.gpu_vm_support.

Fixes: d059c2ec6a23 ("drm/amd/display: enable S/G display for for recent APUs by default")
Reported-by: Mark Broadworth <mark.broadworth@amd.com>
Tested-by: Mark Broadworth <mark.broadworth@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 781d04eda3d4..adbeb2c897b5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1641,7 +1641,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		init_data.flags.gpu_vm_support = (amdgpu_sg_display != 0) && (adev->flags & AMD_IS_APU);
 	}
 
-	init_data.flags.gpu_vm_support = adev->mode_info.gpu_vm_support;
+	adev->mode_info.gpu_vm_support = init_data.flags.gpu_vm_support;
 
 	if (amdgpu_dc_feature_mask & DC_FBC_MASK)
 		init_data.flags.fbc_support = true;
-- 
2.42.0

