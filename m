Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA42EE20A4
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E494010E798;
	Fri,  6 Feb 2026 14:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dxcWTC8W";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41BC710E79A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 14:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDIRle1q2Nse1uW8zu7Z4RqQQdQd9tV69k5plI3zuDEMCoC0f3vsrtNoKh1ObOn/+GDECalApoY6XmRZoVuCyzA/J6GKSgVChy5kI7DC2g68caqzp71ESPIa323nmGNzWzZB/GI82Y2eJPZK5Qr7Ms+FkKEiw+iS4zAgXQe4BJdSlcaE7hk+jF09BhxsvrQe8eO6x5GSHqstQuGzlEIQobvoU1j3OtRCOFahPhslTM8uu0wocg6kfD1Ftag2yhGvgXT5M3Vd3AO1WVOnVC8gh/iT07SPuwcoSIjHOamqM/p/weHxLS0ODxNQpGUWYJL1uLaLUHeCnwo1lHdM7RQHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ/r6F//Lkv/+r9iJL45Q1YRrqNMibnrHDBYlvZFoYM=;
 b=Wur187wE0tGEW3zkkVV0IU6DeKhGQzQALmICEYjuFmkx7mvbsZig/bg/XA6taay7xTmSUfV7hp7XDfhCYNYgZfowNe3ZKij4XvZWAULDqBBq4JjqtpwoG6ZuKOyfJm0A2QVp+TW+9qjoVlXUss2YM0ucVMz7c3hY0O9Bo3lWdq5BQJs900bsCr07L9f9NnmQexXrRhbWcy1RXnm+aqQA5cANV70T8y17fZPg5gnNjGeah3FZk6CXkl0w6rV39ieOl+VWR2aOmnKfzqNi3wlww7scyUUXmHvmYpAsjhjImlro0xeuSch94aXGoC0q4IsDuDviirlOKwRc4Z9lu9hOww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ/r6F//Lkv/+r9iJL45Q1YRrqNMibnrHDBYlvZFoYM=;
 b=dxcWTC8WCRNEnK0FP1nuAg+/3byJb29xxAOD4EZY3NU/tIIJtfVPH+eVUjxKMlTAkb34gpRXjmOkNZgVHGJfh4I8xUIVSpiWjvx7oMxv0uYAykli0QDK3/w5QL4VAlkXx8EsZKkbw80qODiCq41HDHai2/lu4FB4/A0pYqmpjl8=
Received: from MN2PR18CA0010.namprd18.prod.outlook.com (2603:10b6:208:23c::15)
 by SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 14:01:08 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::ab) by MN2PR18CA0010.outlook.office365.com
 (2603:10b6:208:23c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:01:07 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 08:01:03 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v5 01/11] drm/amdgpu: Load TA ucode for PSP 15_0_0
Date: Fri, 6 Feb 2026 14:00:38 +0000
Message-ID: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|SA3PR12MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: e68c3857-7bc4-4f6b-1ac3-08de65882d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DjdLvmk8azQQn5v98QoNabxqHvGzJKgUnZSSRc3F47zq8aSi8+z5zK8cFHTh?=
 =?us-ascii?Q?6v81742LQ+9PSPfHM9pyv0WsVIrHerSUgFMU8GhBtSJt5B6GZuuCxk2Yuhia?=
 =?us-ascii?Q?HBsYeF8JB37isTA2pNZhgzwM3VTh1mTp62CRt9lBGYC8ShBovo2bgvdf2t70?=
 =?us-ascii?Q?fcekAZrS6gwOIKch2ai/8HWXehtT21amwRcSeDbaScOYYXPwE+B8SPxBzpol?=
 =?us-ascii?Q?RwpHrcZ+fv4HUE5609aS6ERSn9Ch5zCzlYQ556k3FVpV+/8yDWvb1TUCIwm/?=
 =?us-ascii?Q?I1snOMJNVdSSeKzSgVBsm1mDLf7d52zJSBo1x3RIh+4g6i8vf68CQB2dzZlz?=
 =?us-ascii?Q?ByhrC1J7dRb05Ds6YCiVEadfldp96B/LaxzlSwQVfdgmSrIUE/EfkzxbcR+g?=
 =?us-ascii?Q?Wns0+sentNyu2XF14KqmVteXCgMobUsZ+gLf2eP4mGGquLhBR9NEpOZ6Bdo/?=
 =?us-ascii?Q?vx4SbWipwHzdXQtCVHlnnfJ8r3T8gbP1XRR9uMbsB4QyiLwxmuQl01S6TfSI?=
 =?us-ascii?Q?wW5gPyjirnuCEz2ph2NDccXYWK31nb2SE4JM1xw7Uw7oqmgaZ89Mm3ToFxCb?=
 =?us-ascii?Q?G0rz5v6pxHnJym5D5ADyC1CFJX2zJUEYx9JNAurOaIIMj9wx7618KmUzl2ug?=
 =?us-ascii?Q?LQ57V/l1iWt3Xe+1+1s9ApIgPPmikrWf/tVuRghJiIeZUte1yUn9Xni8xK1J?=
 =?us-ascii?Q?5jJwhrEDJXNar9tkmc1AngXKEYpEwDvJmOntimjz+NGkqXGIH1SXL7ER1UcR?=
 =?us-ascii?Q?gJr+JB/zn5R73yLLVNtPIZz26bjfxLEH+htXVRkxd297twLoy97IGKaHjV0M?=
 =?us-ascii?Q?OXib9bAZYP0isKHLNx8Y5lLuT6cYZF8erRq8ruz3bLN1AnGdhAcgdk17emH7?=
 =?us-ascii?Q?GmD2I/1hhAGBx2B6iVWUEwhdbQTm8M9cA7haRORC8c+eoYqldfEtGv32SLXN?=
 =?us-ascii?Q?aCiBkrtI35GXSmAsrqVPRKsQN6ug5BkaGS+tM91Mpe7Fxsc+9dal42GeDldu?=
 =?us-ascii?Q?uAeA4AED3kDXm139zSCy+PeRnMZSvxEKsa5opR0rQ/CtJCS2bi6waYQhIOTH?=
 =?us-ascii?Q?BDDGMyjeBsT633XfHO0pR35YUTWigw393k65DzgbaYVHghi4R68Ro4RNqBom?=
 =?us-ascii?Q?uWlWUQx2RQL4wct7Isqgp41mfTqJBGGIgwFPldqksPsS7QuDt53Rwf4dcUui?=
 =?us-ascii?Q?2/2jBLI/qI2ZjFMLRB4NbafqAd4HaTOlM8BonnfNXx7CLNM8GrZ/o5JeOeoH?=
 =?us-ascii?Q?1Ixo2cRv+Pn1XbY3/uZmslVA0onHnEF+5C5k9FJyvU63rBaXZ1Y6uIEzXKnt?=
 =?us-ascii?Q?Pun3OAN6cQ9yR/ysgCTNUN+yQbttmCWbCThu0xQX2fTysLZD7/vKmaecSwXq?=
 =?us-ascii?Q?8Q8m7WAHwXyJHSABP8nWLawYV7JiXiIRHfWxwD+5Y5QSWOQx8VtwSEh8Ryok?=
 =?us-ascii?Q?sp8aTV1ZOAhaO5FBAPyFp7JwVMirUCNpAm9A1zQnNRx1GuPI5nMKqL4WUeA7?=
 =?us-ascii?Q?W67RnS33wYMTDCS4G8C3a/QkuKdTro/zGVKLa7W/xuzEheUj+G7QXFTRykAm?=
 =?us-ascii?Q?lnYmHAsCqwWDghdm80jxASkwQOFV/kIOSVPrh/ljIjk9vEuRAZAjpLn6OyTW?=
 =?us-ascii?Q?vFEb+lP4Ji89ZL5Y8wMLtjsVeT4ee4028XhhGg54xbl7aQ0T7bTI7gTGmpms?=
 =?us-ascii?Q?/BDzyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PFMMQSpngoz78Js1tkxLtvIzI3tIohnUfHzTS6ewHh3hUyj2ckFwH1Woaqyh4bNJ6rcUUbfmhJYq4Tt5pPDU+pI4aCYAfRqI5rioij8/nwAFHXSDpLHcD2WdemNfoSdBFsu/LwASAosh3rydLdfFFsb8Tj/q9wOkbCAycJDw+WrtemHHuYzrm+X7WR3Bj2aJLbEwng/j9LLOEnGV1jDl3LVKKFW8aR5JqKHSgBkY4W8E0fZ4f9faFLxkFBwNPvYGp76IK1kwpswlcCg/2nyPIaMUI4FdITsA+97B5wlfDNhLB68cRdxnxA590efD2qWd/GFKtfzZF2SFbCNy0OgKp1jEFsmOgL3DjaLrdImSRkGFQ2dcnK4qDI/57w2amLkSsQ+lp/hJZFH4yRfpAmLGlIQpZVCE6jRpKfLvTCSu+TuE3/SI9DdcmxQ7K9oyxaT9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:01:07.8203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e68c3857-7bc4-4f6b-1ac3-08de65882d09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7975
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

TOC and TA both are required

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
index 3aca293e2f0c..723ddae17644 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -45,6 +45,10 @@ static int psp_v15_0_0_init_microcode(struct psp_context *psp)
 	if (err)
 		return err;
 
+	err = psp_init_ta_microcode(psp, ucode_prefix);
+	if (err)
+		return err;
+
 	return 0;
 }
 
-- 
2.43.0

