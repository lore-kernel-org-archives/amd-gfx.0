Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBFBCD6E41
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 12:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75F5D10E7F8;
	Thu, 13 Nov 2025 12:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="48hoX8ol";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F4910E7F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 12:35:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Twn5CVvbysQfaSFUOEehId/6CN3aePnGmNAOPhd7XViGm0CRIA4UjJVIMK6AqHgtp0oFwd7YNHUslkqRmenkaIcGMhEzmVLUgYtdAhq9O5HROYfw/6fdKj8NkClJvqKQhdVxlNVYhqLkF7ybn8t8cUF4+p8YtxmKSS7fhJzGFf3+IxzpeenCjP0LXIrLw6OZRWnLVoIufWYQ26DqvT9Es1pfjHBzN+EPf0gvi6QJ2QX7HM6b+MdRk/xN9XafgoUV3zCLlQEpyp4wyeCb4uQroS7M6qBGnufI869El5EOwV/vGMbBlxQ2ATP3KAZ1PKxeNh6s9jIRSF6tBdIGxdVFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rgz9ftUF9TDYCykE9y8lzuv8hKheq2/rOnAqHMdXUok=;
 b=L72Qc+rcl5kp1yoZv5ldIVC2xnjQXy/c8S5pGrRKXEIZqk0x9dGVw5xmWoLgF+t8XQe3yQuOACq9SxhcMavfDU0QHLwAVHBr4jGX6T6kEXhoWzJNJ5pZGdj3vT7hN2zc9W7RYqC/fySKr8+lk40hioWIvnq5XFngEb9B3mGJsxeLn6yG2/chfEGreWB0D5X7PhyZ7D2q/ZMriLdJIItlmqCTNoRsLb3HLyrVtsg3QxcRvj7AhmqXrnfDNqy3IEkfmJSGrv9+zaWqnuJHMfLGFPI5imlFL5msiR2i1GMzCFXk2tT8/pEIw4EZr+afdDm2bmjRxI7n9VrOipXADEGUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rgz9ftUF9TDYCykE9y8lzuv8hKheq2/rOnAqHMdXUok=;
 b=48hoX8olOWt4fkjm24UwCbKU/HmCQCBjT+KbiwOCbZPkogHbHBU0kQ6k76Uom9i8qxfQVwKeeggY8xkbQx1+tsUIhOxSx5ufPcKOZ1sBeO3Gu09jGvqu3WkY948XRWUsdG4boCKDwNhJAGB54R+0X5C1lX4xAGNgX6sp5Nnu1uI=
Received: from CY5PR19CA0124.namprd19.prod.outlook.com (2603:10b6:930:64::21)
 by IA0PPF52B16157D.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 12:35:51 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:64:cafe::cf) by CY5PR19CA0124.outlook.office365.com
 (2603:10b6:930:64::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 12:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 12:35:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 04:35:48 -0800
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdgpu: Unregister mce notifier
Date: Thu, 13 Nov 2025 18:05:31 +0530
Message-ID: <20251113123531.1830492-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|IA0PPF52B16157D:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbd920c-caa7-46e0-b6ee-08de22b12df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2Byhfcf87T4ixp1LRg79lvcxe+2450R8Rk5NoEAMcGGKLr8+COFev4PaFUVK?=
 =?us-ascii?Q?7iwPjg6cjwHStAlsSvE262VwlfG5v81Y272nCxmv0yw/BZXWsgKaaK5uLVey?=
 =?us-ascii?Q?KP2DIghFYTmiK73MZxMA/5lMvxlAFS9rU49Hwqd6/tlaCyNVacyazD8LSsKC?=
 =?us-ascii?Q?MkN/Phc4ZBMOnFq0cZ/2Ckxlh3/IumZpDeqvZpgTHZoo2IPGNros8JmGaEWH?=
 =?us-ascii?Q?ozQfsqq9EpKiePFdDNAU+Mlj7vDrizFZwivjCtvbn125JFhgFq+By5bcK2WI?=
 =?us-ascii?Q?xVD65DTLgV6VFcIuecSI/g+yc55/++MMxvZsw4pRr6PQtmeO5H/ekSw/gKUQ?=
 =?us-ascii?Q?gUSO59WsvwDwDAJBFtSsPmpxvR4egnnkMUNCE+BBaI1NFzGuKJhNaPAuX4NP?=
 =?us-ascii?Q?5JjLpbBdW138dngqXlKBKijDs4xs0a7g9Vtq+wIHK7+S9vr11d2NFxOAxDqg?=
 =?us-ascii?Q?q9daZQPHpyvPZe8K7Z3s4TRyu2CB2u4O6DWVqxEzbsoFu1S8erYCZC28CgqJ?=
 =?us-ascii?Q?WI1dP94+y5SwE2ivaFqqRhGG+lCVYV4Vw/X6VrnUcgTLwrs64pr9WQgeZH1/?=
 =?us-ascii?Q?m30A9QCl70RuTSzDfYbPJ4r+SEJRxGwkhQf7rvoB5rcF9EzTQ1l35GTNlwob?=
 =?us-ascii?Q?Q6vbpcgoU0HnJNS83UVDcGplljWgnZlX9wBvm4GrbsjHN4bjfEpRIMZXznDF?=
 =?us-ascii?Q?ExK9gEe9LY69EoCIno+Ml6ppFeOZvPIjXcMD6IvXq7cRYHrfdysvU55948Jm?=
 =?us-ascii?Q?to9pHwGVmGA0WouwSN/FAU9oz+qvAzAhILOCI6+Y+WziZXhm06T0+s1A47nU?=
 =?us-ascii?Q?jl8bUynIesCE8j3I2cMmvg6jgYSeYF1Nkt0xL7fgrqEsaIWuF4CRheWy+8ih?=
 =?us-ascii?Q?SIxiR3I0pFTkM8A20iTGX/pwNTM1zEjnVmUZyzuh5LJ4LKZNyeJ3p5cNLxbJ?=
 =?us-ascii?Q?2VHi/qDLyHy5ZWGe9zSnd5daEI5JMc2I3nPZtOYtq9o0x3F9uZzX5hZEgqg6?=
 =?us-ascii?Q?bPg3/Cu4z1vWyEb61VBpXrBNw2DTDoxUsAAOS7HgtdYvQznV6KA7+Jni91i6?=
 =?us-ascii?Q?tTijNbK8oE8/PWK7Ohf5x3psU5pyKzJDYWwKRFfv1rtU6QbElgtc22qTJlyd?=
 =?us-ascii?Q?6jzSV/ynVhiawxhv+DI5OHnQqKw10Ol3iOejVIMEek6lqiwYRp0ixj/NovlJ?=
 =?us-ascii?Q?uAm6ax8O617MQwznFHoE/P748OlGpjv5p9SifaS8h2U+Lsp39ekFU6uBvUhn?=
 =?us-ascii?Q?ByVsYPC8dN0g9iRDUZT93epJF0uAJsX5wv8Yd4yRZMI7wlya1CsY2udrvZvc?=
 =?us-ascii?Q?ZqhTfJ1qQChNTT3e81KUjzW+EwKca+svWQ3EAcstOT3JnYUZRTHdzy4FWaqX?=
 =?us-ascii?Q?fr4j6htGRftwvhdwZfMeRObCOSNXKsJ7YYQyt9yiTP2HCx4afkV2XFjIwJNN?=
 =?us-ascii?Q?wXXhJKm4zqqXe+5sAViAg9nLDwWgaZtQT44cPVXEmapgCbBUHg/pFcXWuRGq?=
 =?us-ascii?Q?5WOZwQQlzqF3KBF1S/lv7g+in89BCybTA+Al2xi1/e4yMS5UqQ4ckrxEoGOh?=
 =?us-ascii?Q?WwiOjy8IhO8NGwxPyfQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 12:35:50.8207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbd920c-caa7-46e0-b6ee-08de22b12df9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF52B16157D
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Unregister mce notifier on unload.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 28 ++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 434a7e057dc9..d5f132f5ae63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -150,6 +150,8 @@ static void amdgpu_ras_critical_region_fini(struct amdgpu_device *adev);
 
 #ifdef CONFIG_X86_MCE_AMD
 static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *adev);
+static void
+amdgpu_unregister_bad_pages_mca_notifier(struct amdgpu_device *adev);
 struct mce_notifier_adev_list {
 	struct amdgpu_device *devs[MAX_GPU_INSTANCE];
 	int num_gpu;
@@ -3954,7 +3956,9 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 	mutex_unlock(&con->recovery_lock);
 
 	amdgpu_ras_critical_region_init(adev);
-
+#ifdef CONFIG_X86_MCE_AMD
+	amdgpu_unregister_bad_pages_mca_notifier(adev);
+#endif
 	return 0;
 }
 /* recovery end */
@@ -4989,6 +4993,28 @@ static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *adev)
 		notifier_registered = true;
 	}
 }
+static void amdgpu_unregister_bad_pages_mca_notifier(struct amdgpu_device *adev)
+{
+	int i, j;
+
+	if (!notifier_registered && !mce_adev_list.num_gpu)
+		return;
+	for (i = 0, j = 0; i < mce_adev_list.num_gpu; i++) {
+		if (mce_adev_list.devs[i] == adev)
+			mce_adev_list.devs[i] = NULL;
+		if (!mce_adev_list.devs[i])
+			++j;
+	}
+
+	if (j == mce_adev_list.num_gpu) {
+		mce_adev_list.num_gpu = 0;
+		/* Unregister x86 notifier with MCE subsystem. */
+		if (notifier_registered) {
+			mce_unregister_decode_chain(&amdgpu_bad_page_nb);
+			notifier_registered = false;
+		}
+	}
+}
 #endif
 
 struct amdgpu_ras *amdgpu_ras_get_context(struct amdgpu_device *adev)
-- 
2.49.0

