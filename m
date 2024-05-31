Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AF9C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F2F10FE52;
	Fri, 31 May 2024 06:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u+3mN153";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB48910F2E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czvovv3mRmxyE46CPJ5z0SRCEd1U9UMpDNa/92OmMieUQ5KX6gjrqT/3VG77XBeYXy61b908TNyyrOCPzCXl7g5/YATJf8EE9INbJBIv7qCWn/a2ucjcX0+8fV2GnX+nXwQa4uVXuSlYU2y1uzfwHQUSWEkKtgmZMnjJByh1/zXy4u9ELNDuFycV1zCghfVb9N25lVQhyAAjCPeyOC/Y52sh1mmVGDRrjqoe2tEklHnagG2Jw61iB0O7mH0H+hXvNTZj+ve2bApRodv7QjUwh5ZZocv+GfAdTGd00v4tNAkUVZ92Sc4LNK5aos7vPxHUPV54aR3WHqvwVKIUolOgwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUNX449iSsoM+1IH/fDl97WrY4B/MzCZuR0SvwqVhQg=;
 b=b47gjBLIUOj1UeeGVZ2V++k8tq58LPYMC9tep2Z6fyC2wfCg8ELF2bmGP8gy0T7n3KC3fW0qsxgz9PfHl5E5VzalI0322LN1twApnoyzaPB0CyWrHARNXteqgVbETi2NtlB80bpui3CcOPPaqq0T+oiZuwHXsqegP3lbPUEDku9KIux8UqzzVkgCfs5bL/Mlb4gf/8SfTBw2T35ZoCSogm0uPsZT/Kwj+HafAPhxm+FYR815tBp9CftQTgE9Tq/of0qSrpWl+e3v94FWxsi/WTB+qcMrthEQfPJYboEppZj4EvtSn/cl8M4s6HPpb1tzzaTaMgFEJexW//vZT9uveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUNX449iSsoM+1IH/fDl97WrY4B/MzCZuR0SvwqVhQg=;
 b=u+3mN153f0GiS0ijiv42KD3CB7Y8kM6boaTCgIyAK2UyRjOzsy7r2suqUSzxopT/k/tWjvIEd0PBsi/mxY03SWCAuEkMuzq+wmOaI0Eub/xaZjMUciaa9Jk5fX+/QJMLRq+kD/+o3z58m/meBSpvdbmdbdjF6K40gP0cArWAx18=
Received: from BYAPR05CA0071.namprd05.prod.outlook.com (2603:10b6:a03:74::48)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 06:53:05 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::79) by BYAPR05CA0071.outlook.office365.com
 (2603:10b6:a03:74::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.8 via Frontend
 Transport; Fri, 31 May 2024 06:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:05 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:53:01 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 02/18] drm/amdgpu: refine gpu_info firmware loading
Date: Fri, 31 May 2024 14:52:33 +0800
Message-ID: <20240531065249.1746350-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531065249.1746350-1-kevinyang.wang@amd.com>
References: <20240531065249.1746350-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|CY8PR12MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 13937456-d685-483d-e5ab-08dc813e52a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iZ4SQo6/FGNmBQP6Cc98BIl2+KNgwHNBChjvG/kHnUz7y9/JP+PPHzEv80+r?=
 =?us-ascii?Q?1wlLSqa39Aj+H1SYP86xmob8oDg9/XaGyOTp7F72191l2f4koIYOKIn/H1GU?=
 =?us-ascii?Q?VFa52HyTm89GUGkRyJPDPeBfJd5PMDypyrXVh6XOFEeOtwEVsJfwv0ae41Fg?=
 =?us-ascii?Q?puLtiZqVe2vgTivZOo9hd06rM4e/5PHnXJxbeKxkWZhia4jPy0kNwT5YxKb2?=
 =?us-ascii?Q?o/Y+hwOx2dUDJlZ1mBnaMlQWLR3ga+KO9ivtNY6JGzGrGxLJf7h1o29e/K7W?=
 =?us-ascii?Q?pw7bzXI65mcZU1nydCRXkFCCg6Iz1/3zpW46ogftEtMmisRROs+lWpC3D0Z9?=
 =?us-ascii?Q?DBjYS/kV/1c6hPjLYj9YpR/2PHtEDI6oL4Dbsl+4J0WZmlZCGG8HkUTA6Ujz?=
 =?us-ascii?Q?ZENyeWJRPx9Zk7BDXXP8A61ZxdoSisobN51zBMboJW7rxa3p8YH/bhi1osMY?=
 =?us-ascii?Q?7vqReUxY+Fkm4QV8cSD+bflGHLia3UcPWVIH4U13h3lBKJR/S/P1x+a8CZbz?=
 =?us-ascii?Q?ksj0l2yByxuS4cv45/BmTb5+PQtWNerVLRX1eVHu0z6DKlk3PfsUJnTcvCfe?=
 =?us-ascii?Q?r8LjK+6bzdiNiBASyBd/g4CGodP1Fy8hyE+wCusa9m27NFGyaw0msTqkHNQF?=
 =?us-ascii?Q?eC/RlhFmg0V7nT1ROvbZYtWLXPl00Q25oEPIT+VZ5Kx7kOKpRazU2BbDKjR8?=
 =?us-ascii?Q?CgscqVhNDwtMv4lci+8Am3DFvoeCVgIqrThjdK5rSkNE6wIdBoLFPmMJS+jK?=
 =?us-ascii?Q?HNUjO6N8muu4fga9kYxGKmznJluKvxbYnNy5rm25y9VAzq5XhKdJkr1PIdxQ?=
 =?us-ascii?Q?6BIb8chhexWhpIBHQH5FdXf54lpGl7w1FxSpz2rr6XLQBz82j6oF8S2cyHsJ?=
 =?us-ascii?Q?7RDI2jy97xfFg6WFdmy50ZOQMnQMteRE0YqvX2mNzkrI4e0QtoO9f/cjaK6A?=
 =?us-ascii?Q?FNQaJzSfXKYCTlRzKM5mAgZbC7NdDib9B0CZqI/pobLiiKctJmddldOUQGdm?=
 =?us-ascii?Q?9/LoF9Reb/7I4SgsatItbR/5+QIDbgy9cd3+ScQAJXFFxGyFGVJrSzGYWjcw?=
 =?us-ascii?Q?Tk12u59Sy1J5usS9vPV+zMn8VganpewXizr65i8nzqif020/pJANrNxUoqiB?=
 =?us-ascii?Q?no+bhLVHKp58XeSNbsW8OYK+aBwpUsVVszj5N1uluyGey8adizSIVPqCLY8/?=
 =?us-ascii?Q?FAQ4r345zyYkxKITgi4pnEvks7e/9is8s9durSE2y2H3CiuuanwHVxkV+hTd?=
 =?us-ascii?Q?Zw8muPi3bClG8ScPClTXzWHeI0MZmvZ+XVqUOuTzyl7IhLQFCbSZon7j5awE?=
 =?us-ascii?Q?NFhZBSQ93s8P1h3zV7CplP9rcDIvFCE2l9sM7A6xZhkJAtrblgQrdDZ7dTdK?=
 =?us-ascii?Q?Mk3zH82LmoELy1FKG1A2q0d08Zxx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:05.2920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13937456-d685-483d-e5ab-08dc813e52a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196
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

refine gpu_info firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6711836054f9..a6af15fb203c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2350,7 +2350,6 @@ void amdgpu_device_set_sriov_virtual_display(struct amdgpu_device *adev)
 static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[40];
 	int err;
 	const struct gpu_info_firmware_header_v1_0 *hdr;
 
@@ -2384,12 +2383,12 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 		break;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_gpu_info.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->firmware.gpu_info_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->firmware.gpu_info_fw,
+				   "amdgpu/%s_gpu_info.bin", chip_name);
 	if (err) {
 		dev_err(adev->dev,
-			"Failed to get gpu_info firmware \"%s\"\n",
-			fw_name);
+			"Failed to get gpu_info firmware \"%s_gpu_info.bin\"\n",
+			chip_name);
 		goto out;
 	}
 
-- 
2.34.1

