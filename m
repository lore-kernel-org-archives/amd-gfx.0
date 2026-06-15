Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF59CD98E5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B16C10E786;
	Mon, 15 Jun 2026 23:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uIab96PR";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012020.outbound.protection.outlook.com
 [40.107.200.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBEAD10E77F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUqL6xk8951x5ZU8iXPwmbxU9XZqzXzjBaN0QaSfDjFiD5y3lFSLDPPQnTk8QjP4/E3TrTVaY6RVH2eWIZNfiATwtuTPHEeUiGrGFTPYXqIcA2IsELPJcqXoRPbesjTp/SsbWEzkUgnQJZQPEczJeVUaSCJ21xgNuAgLc9uJD5VP7XvfzNkyjnYFAOXH5QANhXeJkMw0YIXKgizvRA6Fjr0gF3pRgeFK6FMuPUOGRRz8pHerRA0/XT3t27Ewo/1B0zcOVgDv2WljKL85y3ndOHW5+E9zkxodk0eMKVidfc7SVszCTjOz9EWFxcMkdoeuBR5aNEgLa4pt3js/gxvZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25s0MaGZG0yA3iwMobPIxH+VBDSRYWW2oElr5KyOk1M=;
 b=TeSkzisvTiRrSl93Rzjlox9FTr6m6tj7piG6QJrI2XYCGbPt+DOwLvaqgUGGBvl4otmNkUkNk+PLKI5q3I+IrYMEvvhyOj5ux3WMBfSv/q2yhAxcpb63Uyjp6ILzKHAbzIOraisHD7afBSpaGXiAg5IaKBmDiATMh6rrc/Mei4xfwJ8eain6D5nUFsnuocqpIfJ08LghovfBto//rkuW8X0kbG4ccyEZ30H/oPQuS4pL9l3zcod3AC6JvVyYMTyi8DG/nwFxZftb47q4xm+GjlIbINfRouh0W/bJJDzju9DLfh5iRDefm8Jf4pcm4p32jMh/GCXpMYzzj/ZwfK3Mmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25s0MaGZG0yA3iwMobPIxH+VBDSRYWW2oElr5KyOk1M=;
 b=uIab96PRKbODrbrUb+TJqCBSFhAtn8hzJOFLBzkrExcSGF6JxKVf7ea6daRKZttB9CwcTPQh1fPSfTgwx06kx2si6OQhuT/w9NSWEdWENAwgOrqH10q/0PLCnCK6kUKvMnQJE4olGP9tH5sXIbyqJsQDose/k1I+etvLhTHGekg=
Received: from CY5PR22CA0038.namprd22.prod.outlook.com (2603:10b6:930:1d::6)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Mon, 15 Jun 2026 23:57:12 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:930:1d:cafe::7d) by CY5PR22CA0038.outlook.office365.com
 (2603:10b6:930:1d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/43] drm/amdgpu/imu12: WARN() rather than BUG()
Date: Mon, 15 Jun 2026 19:56:29 -0400
Message-ID: <20260615235645.737189-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 21384605-df45-4bbd-794f-08decb39d16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: LgFNDUlUo5oF5jfKamjWVeVDKAysXWqSmjxyzZZHOmtKEfkhHsG3reXHYoPvkdwSZasDgX4QeMdKYxvqv98Q3gIK5gur3TBeSlakpA1yADEjXiwHFV5jahQQlEesN1tubW+ced8YZ73rPApkLzpABJpn04rI6XgtlrM6DfSPIazfrUCrxH/cYOG5KIL47QUVXqqSRTryiu9kdFtLEJwHkOsP9bDSmIsFkyN1z+KfhQTbNO3muLbpxS2I6wUai5AZuvWZtluONuhGNyq3D2M2gHGtvJdQuQ0BnOCGf8V6UXw0HuwJX8a3cC8vCqWl+Eh2DY2+YXYlLXLyBFRGYaoZ3nPfmRxabz+Yp5huN5hCFXhoTMyQMP7AVWltzeXKREP4mrszxKw8sB7OkII9Fhulnae+AEm7V+1N7OQwAj0sgS58yVU2vtRbaz464DFMBLxC81NHYY6Y15IF9nrfVakqjgbjtQLDj3P2codI7qZmKbX5C1+IyKEQFlfNEdW5B3/q/svdqjO2vhex3ao/TqW1ly2EFg3PLsyJUenlYTODJgJMdAXhxxR5qr6lFpLCHwMftzsNJdgImMrWi2mT/bYO9xfLzW/QaVHhpR4t9/zK/f/Vdm4IzGJAUjcl94tROJBwA8M0M1lsO+FWLnzkF15Sss9EnUsTAIaojzP+f/OZuKqh/Spr8F8blt+kgh1sQJlI2ap8nx36DjTr6hijRocUWF6wJOwrb5JeyonDHsmjD0M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V951/5ai2Wi1J6hbfhQnuz1LHd3k9G24CvDc11UkNlhnWKkacQh02M9vRnvAdxLIZ+f4bbubvDz5GQG2MGBztYa/e4KjL/zXS76VHoZIL/EohCJ2+KRkJB0TrFddtApGc3w9DsK92RR3YaVez+5maSSA8S/oHTTfjwKOsiP9r1eWnwF9qOWp1J0N6l4DzL4WWS0ZyBi8YCM0+0FZDgqv4GPk6y/ghNpO4Sh0U/Jic2OW/ftQcCPMPceDkPcsTiSAm5f9SL510mdCKLDrZyMsdo+iyPMHkJTsK7zZ1WmOSQROOViL6Zw6HiiGkrE/AXTu9s3rA59twA3osm4vn7rkl0dTLBimeh7PDgEP6+dJgcSW9jbGqxGAmvDFJkslXIVnDKxlGQMoZRktOqVncfYo0w9ueSaza01LyK+WjPKi5ALzpxpuzCBxL0DQ8Nx3vjmn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:11.9932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21384605-df45-4bbd-794f-08decb39d16b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435
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

There's no need to crash the kernel for this case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
index 58cd87db80619..2943ec9521eee 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
@@ -382,7 +382,8 @@ static void imu_v12_0_program_rlc_ram(struct amdgpu_device *adev)
 				(const u32)ARRAY_SIZE(imu_rlc_ram_golden_12_0_1));
 		break;
 	default:
-		BUG();
+		WARN(1, "Invalid GFX/IMU IP version 0x%08x\n",
+		     amdgpu_ip_version(adev, GC_HWIP, 0));
 		break;
 	}
 
-- 
2.54.0

