Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7DEC2BB86
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 08:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02BE420692
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 08:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ok4dB+1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BE420692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB8786E419;
	Mon, 13 Apr 2020 08:54:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C136E419
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 08:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHO1Ymddclvq6mLH6+XSWLHDNtRq38/V+kDfFJvMz0jMDLosSJI+0MmLJJM7bHqqIiPnvG60aPyCi/4UrZDABGrDq8yOcrRC0SxFUGk/Oc4h/8Vkbw5T9LCqHYiex3THK2VvKH+M/iLkS5dxmottd9PJGlaN0vr5UcB3X9vJWhpM3GmwQWtFPAt3xq/NlhLNm7Wk3O9ezh6hoNwcdyX5GJOysD0qyB/n53zqLw2I/hrTgKfbUDAdD/dAOKL/VVK8vQR7jlnN0u5oSoKpCdLSwhZcH6CmaCouiAsfhDVLvjGJFRWBm0mEb8Q/O90LT2N4HJxMO3eZHnmTDpZuBA1O1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvXHVKvWdAKZMxttQbvjpZAL58IPhr97MNMi1gpa3hA=;
 b=OPPkukj1stnqMOdGRgTEjQXGiLJJRC5E2CspUx8ywro+q/64wiO/nNnvtDcoIJHAx4i0aBsuXwoKUXDOd/yubitHxvATHhiuQ//9gNpGtiy5FAuC+e8Eo9m56gYgmaOlmj0LKQ73g1Zm63iuamYH7dTF3rrWkQxRDWy2gVYuaIRtMWU8UnVE0+Ak0tvB+klfODI9YLdztR9q4epo7ZPMajgzy95oRSgWFOwRPFOqhb6Y4r5n0sxm9dn9dMM8Cn3AWDFDRmk0FD5GfH/6PeJc78br/ynR9QNj3nzMrdc2y+CLHalUWTKSX2u9ZCFB10HfmyztKjBv+bduhvEfisKTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvXHVKvWdAKZMxttQbvjpZAL58IPhr97MNMi1gpa3hA=;
 b=ok4dB+1Td5GRcXRL5LlWbiO0V01q33e1aFUcu05LaIiqaxLQkKme64yO50xKZUaMu+V3hm/bQjUnvxRyIsPqqYQxRgD6/3mt5SKeDu1nNm3M4lVA8nlK7f3TAm1BKdqn3LE6GUa/lUdj48LECEHrUWG4E4d6vOlzfjOYO8ozVAU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3241.namprd12.prod.outlook.com (2603:10b6:5:186::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.24; Mon, 13 Apr 2020 08:54:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 08:54:15 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/powerplay: bump the NAVI10 smu-driver if version
Date: Mon, 13 Apr 2020 16:53:47 +0800
Message-Id: <20200413085347.590-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200413085347.590-1-evan.quan@amd.com>
References: <20200413085347.590-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR0302CA0015.apcprd03.prod.outlook.com (2603:1096:202::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Mon, 13 Apr 2020 08:54:14 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28aabd42-87e9-4c1e-bfb0-08d7df883e9e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3241:|DM6PR12MB3241:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32413B517E3E807A171F00AAE4DD0@DM6PR12MB3241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(66946007)(66476007)(478600001)(16526019)(186003)(1076003)(316002)(4744005)(5660300002)(2616005)(66556008)(6666004)(52116002)(44832011)(7696005)(6916009)(956004)(86362001)(26005)(8936002)(6486002)(8676002)(36756003)(2906002)(4326008)(81156014);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W0Wo0pbLRndnzVq3lv9rBL7MW72cHrWnkRIG+a4AL+6yG/j8nKTgYfK+Vxv1zxTZTq3RP7Cl4X+3CQRL0thlpOvyNEYHIZ+lohGepxY5hw8OKKkfi+8AhpSNgAbRVzhd+usnDZMy1W4tY3L3iFpSJKjADRx2NRi0SYjk9HHrWEsWU+xzfNZv7qYiD4MyEhLbATwCgyoCHp8a3MdKhQ20Y9/u1BHyl33yxGGDE8kPKaD/fglm/x6liJYcce/ZwmMp3B90c6p+ohdk6Hw4CBDkMMrZehTCUjyspKqS0FonX8A8vzjCSvI5lrzal874ClmPmoB8LH+KhmNlVQpH3FAyF4ef7RVdcFu3RECmH40NlDrVZTVU0F0FMGQ6DZ2l5fgWQicXHqZjCxvly1tjrZAIQU/JJ+ITgpe99+ftdvahakK5p/WmxUqjW7WdoSO31e8t
X-MS-Exchange-AntiSpam-MessageData: jgxp+Qf83eUkAJZmvjXyvAk1Vn6ldsPkLXFzic6R+od/4PelRCQxYRIp5GVnsnQnlJVWS5zUIRpZM3gQHBeOvWcnrr0g1eZwoXb3ppQdDUd3qc9edhh02dBhzoLTvv1CW0Zu/P6OLHLx7XvW2ea20Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28aabd42-87e9-4c1e-bfb0-08d7df883e9e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 08:54:15.9309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZ/UFAzfPzGPgH6D4sqBS5Qpx2W7c15YrFZwf2hKlUJtgPyI71NuHQCYbX1/N9wM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3241
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 kenneth.feng@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To fit the latest SMC firmware 42.53 and eliminate the
warning on driver loading.

Change-Id: I3f524d03e53ec6778b7118ef72652a538eec4ace
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 674e426ed59b..e786d63b1e79 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -28,7 +28,7 @@
 #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU11_DRIVER_IF_VERSION_VG20 0x13
 #define SMU11_DRIVER_IF_VERSION_ARCT 0x12
-#define SMU11_DRIVER_IF_VERSION_NV10 0x35
+#define SMU11_DRIVER_IF_VERSION_NV10 0x36
 #define SMU11_DRIVER_IF_VERSION_NV12 0x33
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
 
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
