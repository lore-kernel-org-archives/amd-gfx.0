Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E03CA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 20:05:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92F2E10E4C3;
	Mon, 18 Aug 2025 20:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AVXK4OOl";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5413210E4C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 20:05:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPXLq+sah/imdPx9KUWaT7Dbdrkfanzx9LTFJzdeabpo6QqwKUO+QeRcDOtXYKciWYNGeobGFFfNfzwke7gmMsbNXBxPdigJGTdqxDGDfD50n2yfWEEBPOa8lKtekscnjNtLIuvk43/a0DZ/xixr6nD6jzf4laGQegJCcoNQDHMaeK7k3FhrzxcP+pBQnfng8wNx4FiRvVpN6SzfvoDydb0/RHb3y5hWYVYlQSGqIeBFwdvqGg3meHg/5t2EunZnbj2vtfWy29NNIO+NZ8uvC5Zhk+/8ttb3tu3tYFl6wV1LWalw+R5Vu5Pl0YruIoZf8w3mIQzlt3hbI9vO0X371Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vigunu6oel+B7kX9LDIQrtjeBOM4gaChiQ4Xbq03WCs=;
 b=rl7zbwXR3UpZx0vgX/bEoRJ48APM0YusDjuN6/nS5fskz6spY5fWNDiGs59C9ilSk8Udp6nBBlDF4lptiR3wwkZ/e10sAQwUMVDuk5m+04UiITjCNxvokHi/3/8Nmr+UgtVjPhOiiw+4Y0kMM70r4EDJo3C7K4snLpqO82qboBLzJISgjWIq8nO3V9xq2t6di24Xsc66A1qCOMQ1MNWq4G/nraZW/qyUsLTQeIt1B5JMnuh4dVXFpMvt1ZxDeZRx2b1VunYzLzYVQEE7VvMQYAJvI32SmXkkSMSkkcPeic0v0tpHKAJOPpA8l+Iv7pL7AXAo5//6C0UqxAk6Txl9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vigunu6oel+B7kX9LDIQrtjeBOM4gaChiQ4Xbq03WCs=;
 b=AVXK4OOlwBihnT4wYSNSzWleamCQlFr6bL5gViCjapfd1NvmIk4Q+hItC6L3v8JdlC9IM3PozD8Cl0fdSxmwEVYhWGiNgxOEqDPRZ5iSIe7/VXu7YAnOh1J93pCide8ZM0vNUJSE182COApCperu6MHrX+wnI0HnsrhSoW1vOGg=
Received: from SJ0PR05CA0183.namprd05.prod.outlook.com (2603:10b6:a03:330::8)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 20:05:09 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::c5) by SJ0PR05CA0183.outlook.office365.com
 (2603:10b6:a03:330::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.12 via Frontend Transport; Mon,
 18 Aug 2025 20:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 20:05:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 15:05:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: add support for cyan skillfish gpu_info
Date: Mon, 18 Aug 2025 16:04:44 -0400
Message-ID: <20250818200445.437007-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818200445.437007-1-alexander.deucher@amd.com>
References: <20250818200445.437007-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|DS0PR12MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: cc141bda-8d81-404a-3075-08ddde928859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2KlT1/wcg4Aa49rvuujMHZaFiWXiWlFgc4ScYyrVMDuvuV9VNFpCd12aPz3H?=
 =?us-ascii?Q?tSOee9KpshvCz1kKCfFFtSM4cbLlvELSvndYHPWsKV4M9a/ePBU730OT+rLy?=
 =?us-ascii?Q?3Q2qzvwEv9+BKRQMAjzQm7rAV9CxQgrHogiJPaqgbn8xHQpy/2JuF3lcjp5W?=
 =?us-ascii?Q?DfbC9qX4MtGvCfcuDt2Qo8iaZnKSSMp9nNNs0mcR6PrJWABh0VrUUE7Fg3/1?=
 =?us-ascii?Q?0nfhehqmyW5MVnobV3Cvdmt2yhWIp2DcISoUrecR2OtgB+AKep016OWwRpX1?=
 =?us-ascii?Q?T80NbnoZGMKnKc70t0B8JlZY3pGOAknGprPpgCu/sdbXftGNxglECN84NS2Y?=
 =?us-ascii?Q?StI22KWuN+sNjrrRLlUKAEJvefjTQfAxRY3jnzD1svyaRRYG67A4RFP7qZW8?=
 =?us-ascii?Q?8WQqfwulKJKu6S4guEpLUbb1bH942x7pvri2Nl4u/HmrmLtnWCImaA6Xi3RQ?=
 =?us-ascii?Q?/GUCnNbSrCjpvy7p1QX24NL1I009/xI+g40Jmov9UTVYLh8WDbKNTC3uuv46?=
 =?us-ascii?Q?gzQmS4SY6rZzuGhR7OxRBVozECqSbnEGaQzunKCYtjo2aWTO4xu+Y5ld5KWj?=
 =?us-ascii?Q?FgbeND6xW+KlsDZGG64MPKrVsd5TXyoehpkK+/fxj5+RfVIetGsDsIFDx8HN?=
 =?us-ascii?Q?RW07GXjBXRPphxRNQe5z4hDTkh+y8/19C70ehrtqMcBV3GsXNyfRe38XU1IT?=
 =?us-ascii?Q?euZnBNwK9WoHbloykyslHZZEaiEsKmjdCpCi+OpVjpE1YURGXmaY9jEccghk?=
 =?us-ascii?Q?SS4gFmJz2bfbrvYgiGLh3YbuPsJ2C7XEdQaNXvr3NfzVtcN8ztX83B7e8BFu?=
 =?us-ascii?Q?d6F1quop2uJeY+cEtj/Fq4lANnfCEA5IVEVY0NFywS+CqYUN8ORMCa5G5Up/?=
 =?us-ascii?Q?z2W5T2gGcE2uaEIfr06Bi9esXQUTnlb2c7ru3fyJnUL8rjIVeOMU+K9EL+7j?=
 =?us-ascii?Q?QLIDsG5q0LeEQgA1eAjl4arYKWsyJTzU+RXy/hVVmq4njuES7rU6xyt+EozD?=
 =?us-ascii?Q?R2pIEUQf9VY0bsUbQ1iKlQiCAGry5w0UX9c35bQ3giQYvMi3ZLZYPeyaToFq?=
 =?us-ascii?Q?pdh+C0skM4OHRr4AHL/1mCO0lS5k+WnGQBOjlTo9H/GrAro+FOhq0VZnsjTh?=
 =?us-ascii?Q?EWb4crKX1wtzP7GnTLnAq3UvReR38CWjD6Rm6uly55Q5PdqzPYP5ynAJVdzD?=
 =?us-ascii?Q?cJK/oogxn55g43OKKym3SJ7h9e6NC/yec3AYBnGK2uYt74zrCAsy/oCTDo9g?=
 =?us-ascii?Q?Pxt08XZfN3syoq4GCn2aa3KlXsMtS7e15KKrgfxE5fJT2vQlsMONxXEyEWL2?=
 =?us-ascii?Q?1POniBN3/T8MCgzVLztOfT1gl/WfRP6/pmWoo+QzqBaySA5/phTECTdmQ1YD?=
 =?us-ascii?Q?B2XtFhgbjsz8eLAnCKSApiSY0/d4EIjNVSlssnAUwaoEMsA/ezpVqVbFyLKC?=
 =?us-ascii?Q?O5LYjBfdRVGJ+9BbmkmQsR3N3QQxyuwfiVv4prbdzic3OVYShoYnrXGHM33I?=
 =?us-ascii?Q?WONv0V+EdzahiwiNl6Elde/FEpFwTigbbvWM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:05:08.9285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc141bda-8d81-404a-3075-08ddde928859
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747
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

Some SOCs which are part of the cyan skillfish family
rely on an explicit firmware for IP discovery.  Add support
for the gpu_info firmware.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6afa392290450..334f36c09e093 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -95,6 +95,7 @@ MODULE_FIRMWARE("amdgpu/picasso_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/raven2_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
+MODULE_FIRMWARE("amdgpu/cyan_skillfish_gpu_info.bin");
 
 #define AMDGPU_RESUME_MS		2000
 #define AMDGPU_MAX_RETRY_LIMIT		2
@@ -2597,6 +2598,9 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 			return 0;
 		chip_name = "navi12";
 		break;
+	case CHIP_CYAN_SKILLFISH:
+		chip_name = "cyan_skillfish";
+		break;
 	}
 
 	err = amdgpu_ucode_request(adev, &adev->firmware.gpu_info_fw,
-- 
2.50.1

