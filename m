Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5A8C10F1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 03:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA44E10E4EE;
	Tue,  7 May 2024 03:20:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ejKOcAJX";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A9B210E46E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 03:20:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsV18mIcbOdwvoVmjL/HWX1M5zTybJq38zL1EdC1TMVzLzVsLhu3T4oIrUYZzwic65eqsyB8+sJ3KxWVOb7QL1uIiHJTOMvtX4aslfaU+8XOH62uENKJ/JfmLh790ucmoLvJ9/47OhHmDVQh7EGvfLVpy2HSxnN/eYaKFlYy7Bjbc8LrTglSXAdb59bxKCqxANAxGml4bzjeOEavOsQ+ricTFh163H9v/hsdlOu/Y2lko7ft4sp4mtxYwTVg569vpg/Q2ILF/4ID76VjLjspaF4aAt5hLPXUkZbL+yOCJm0cZ0m5sDQC3S7gQP2J3GrrHXW+TjqCBujqudfoSMFc/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItS1HbLeUvB65CoUx8progfmV5zD0+9lcLVR55AoZZ0=;
 b=cbIytYDk/qW8BWc6NymdWnCVTKhsTnFo0GLj0jO7VcVQhApus3lWtQbDshjwS51jNqgLasmnzT0QlXFD1zuO83Y+8gG0GtGjfkPKCiZxJRhBOEg3jaQISapkozMSBtYEEtX/Me/nqPH3FN3RpQY16QdyNKVZIXGABHv0qN7IJ7sePBmpEFZHvBEdEkyYObCH/QVTy/sqFiaVtF311fwWw/P22iJ6sx2u4R0bHjVvRbHxpYSKPA6RaDJd7Sth9DonfCDyksnOgzkSY3uz40akXdT/7a+SvPbBA5rKYaq8hn9O/303kQZ9EO6uRidy3gy7Nrpmxt6pYND/YRuiQ0CkCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItS1HbLeUvB65CoUx8progfmV5zD0+9lcLVR55AoZZ0=;
 b=ejKOcAJXhlHnkVQ56b5e+B+na9t13fW4e6UdsslSO0OKWkG5tQ/3RG++H+VdxPRbJS6Q+89V8g30sonMpVRYcoAYrP5X8DlHYOxWeNUo8u0BCkZdHx3SSngf7u/+5/+1oTH80Mrnu1GcoS/sMIdPVw5tDNrehD9DHILtGt8G6uI=
Received: from SJ0PR13CA0121.namprd13.prod.outlook.com (2603:10b6:a03:2c6::6)
 by PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 03:20:02 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::96) by SJ0PR13CA0121.outlook.office365.com
 (2603:10b6:a03:2c6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Tue, 7 May 2024 03:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 03:20:01 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 22:19:22 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu: Fix out-of-bounds read of df_v1_7_channel_number
Date: Tue, 7 May 2024 11:18:49 +0800
Message-ID: <20240507031849.269814-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 3105e829-9502-4d17-47c6-08dc6e449520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P+37gUSAtrrjHemiUz7ZyLbh2+4Y2/gL8GyNHfURDg/9UCmXeulLfqL6evSN?=
 =?us-ascii?Q?r4Sw9DfxjXsblEAqYhXLE0OJVwDaLgJhbb1gzQsymsIY/E3uCFVdBZUvIEA8?=
 =?us-ascii?Q?Uw6J0uiAtXxKjWHaWyROz3l7ShEbino6Ro1rV5lmpDof26ajmJKzQJDHY5cR?=
 =?us-ascii?Q?jqMhk992U6fFtGszB0DUnrs44qvngoU0zI+uvsuHXEkJoRmqBhHPO0fTPysc?=
 =?us-ascii?Q?te702tOgJfbAD398Dk3nyg79gITEwmihGJEP/LzJqfDc8jmUVaLW6aKqQcn9?=
 =?us-ascii?Q?cyxKUFiL8ShtncMO8tR29R9N5JNbY2FMIvDDfRWn42A7chxuRtixP9fCIzKV?=
 =?us-ascii?Q?zfvpv2cELYqcgVOk6uNnNbMVUFSSAndlwpBzwrnOTjWlVGvE01AAbwgbcLeu?=
 =?us-ascii?Q?N97eq3bNLG+QFIH58LJ1/N8X9d8rp95GEsRDxFB4x29RNa8C4Vfyup1huEyS?=
 =?us-ascii?Q?bdcLMj2ck/9b74aVthf/yL+1Ny4bVqrRdCEP2Kpz27GCj2Q3PlnsuU+xFoKQ?=
 =?us-ascii?Q?otXJOqydBPDpY+QBCyoVgQHZpZOXMI4jRCGTqS87n75Uv3AUEE3Ui340Ux92?=
 =?us-ascii?Q?If9d7Jc0D6i3buRPRxIjxycyS3TM1ruAfTrc3quID/agQmAd1+g3D6FMGXkS?=
 =?us-ascii?Q?X3C+vhZ2FKVjq1NTIIbL9L3drNkIeKDgyH5Xb3aJevr6X3VuYnNSixx0n18L?=
 =?us-ascii?Q?+dSoOeYjKd7X1BvY3lgG4+BN4vACgQiAUOfxkB+lcGaN5hw0Ulh4T2B4uWQb?=
 =?us-ascii?Q?QZIQL0Jp4QwuXd9ps8Hd4d8NybiM5hLtIJdJmnpIpzeV2eMjpPeZ76XLZD0Q?=
 =?us-ascii?Q?AsYWTy09Hy6vizjm7Jbgh0Jjb66Wh5RJtEKJl9vA15knnuwmq4P7uBdsQy0P?=
 =?us-ascii?Q?F7JRkYQGb53fdWcKCGRdh6nge4Ixrv6Gyr2x27vG/taawvfSTqQqF3Ug4Klt?=
 =?us-ascii?Q?/X8C0g4p6Pt0yS0cqT+WFryQzo2C4sr7vz2ApF8TIlot6yMSpxCqu6eyVK+D?=
 =?us-ascii?Q?f5xK4XWPGnMWTkluLB1whDh66pcG0QZPLgZBCQnif2XrggLiYszFv+0NLi4D?=
 =?us-ascii?Q?wuf0qN3mlXjpNEKvEKapV6UvRDtTcTJRg8i09rMb3+PexG/G9MVMVUHyZ9of?=
 =?us-ascii?Q?m91heE+5cded75XpJfkRJsBBQA85kYVtChl/8zEBiNBhXUI0hna0aIDVYn+X?=
 =?us-ascii?Q?+XTypRNtwYmDUMdSmHXMAiIdmozLxnuU0udSkyqB5QlSFelDmC1XZNhnLTAp?=
 =?us-ascii?Q?+4IIkbJVqyfGf0/lk4dQhvzyKSfj8NK2GXlcd8vALogVPNPAjGOMOtOjnf1W?=
 =?us-ascii?Q?jerjv3tx55BiAKDuf/OTTRj4zPyq+4zbCO1lOOTWqG036KhKkJ+JXOKX2Ig4?=
 =?us-ascii?Q?1VP7KDraMJ206/vsl6JVbU9dqfE6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 03:20:01.7582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3105e829-9502-4d17-47c6-08dc6e449520
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472
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

Check the fb_channel_number range to avoid the array out-of-bounds
read error

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
index 5dfab80ffff2..cd298556f7a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
@@ -70,6 +70,8 @@ static u32 df_v1_7_get_hbm_channel_number(struct amdgpu_device *adev)
 	int fb_channel_number;
 
 	fb_channel_number = adev->df.funcs->get_fb_channel_number(adev);
+	if (fb_channel_number >= ARRAY_SIZE(df_v1_7_channel_number))
+		fb_channel_number = 0;
 
 	return df_v1_7_channel_number[fb_channel_number];
 }
-- 
2.34.1

