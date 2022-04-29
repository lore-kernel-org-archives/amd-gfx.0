Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66742C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45CDA10F893;
	Fri, 29 Apr 2022 18:02:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 042C610F892
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xsbg3qbo8b+7Ze4VDPuapVBbr4Qcc1U/RznCj9Ge01R/NZt79vYA8T8CjDmw7YtMz3BbOOnHl8C//LmWWpXU25QW+HVMEUef0rxa3exigGdiV+1wJw0oh5sKhVr0POweiEroNTOuXzozr63rw4Sxiywa+5W2vonjI+pH0WgMEbBq5iimKzryDLvMWIxhg3lo3rM2YaQVqV9EGKIF+zFcGMvfRpeNGOLbGXd6d3mXTrOReM8uswbeQjas0N0jZsxCP8PCGwVFtxMjJBOAevu0bUhWBNwbP3qESrfCCxXGJZbYoe1AUq17Mo3GrBvIWi7dujq6Lq+0zVAvIQMMOGEtPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgIR8kxAgobstjlxAHfXaOTsnTQgx25RXnD8naw1yIQ=;
 b=Gl3V+TIug8zV0msPpfYBmqWZZ4bWdPEtZe/BZH93+wnEHOt0KooSzjFXpiXkav+MuFweqjVPCkGDe2UHdKNoARvwVOJhbVstb01+7QK0OsLTfs/4fPniFBc5Ptky1kBrrBKGbdb7G62v2KUcjWQh2XmfgImQ2fik6s+N5xxRKska+g9clDctwYzesIKrT/Qpnco8qsNJZpgImiTRl8pahLIG4RLV1GML3HEiet5gboS05t8te5Dvt4O+qUdjJ9Wkf+MBcAewyFDso+MlFGytsHqnVYDfVOGipjvb8ucj8EcKStt7kn/n4a9ooxQ698tHpDCB3S+3XjJS03VveKaYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgIR8kxAgobstjlxAHfXaOTsnTQgx25RXnD8naw1yIQ=;
 b=VNRzt74CYtgttXC7FKsLqirSMivrDgSQuSJPgXe0Ra9y6yb/BG4NR5fa9g+kAU2itepl+boNcc2gGqMYfyTzF6T+5go0C2Ol1EJSVpqMAJR1ZnfdBj5SPYMbH165DKRdUvCreAgvfcDhjws4RMm3ByRxuDv6FQPBLyEvFMb18YY=
Received: from MW2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:907::23) by
 CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Fri, 29 Apr 2022 18:02:44 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::43) by MW2PR16CA0010.outlook.office365.com
 (2603:10b6:907::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/29] drm/amdgpu: add convert for new gfx type
Date: Fri, 29 Apr 2022 14:02:03 -0400
Message-ID: <20220429180226.536084-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac1133ea-695f-46f4-fe1f-08da2a0a762c
X-MS-TrafficTypeDiagnostic: CY5PR12MB6299:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6299033142F3CA32BE9F5272F7FC9@CY5PR12MB6299.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WzW1BuLtKaExnsGsxB2YyJC+GPKpxcRKQL6ZpV0U4vmmpQO72iQGAZFgchIf7DL88WroqAS7A96T20pe+3sEznJbz5+1hcDi0Rz4jNy9inUQmyxWWmvRLoUqeZn6tBbdYT1nVA4mCGq+EDT3x/Gk4kzfCeAnv3Oq3I9mKL3LEd82cpy+Hf6tb2RrUU5uaH0MfQodnzaIfPKKjiW2SYH9X4Vbu1aFstEUAnIffXItkaKDhmyMMjUCVw5NYW39ScPRWmoRjK9Nx9Xa6w5qRtpnvvF2uN2ikHBqf/eWIu8yccj+kQ0Bb6a75x5wPCIvBAEDxoWwfZ1Y907OSU5Eiwsg7S4YBhUsdaQGzDdLDKKS4GRt4kBSznbd/jtkNX9InnzrPefGzaTknSanSiRmP9DK58dH4939jgc46MP25I4R+aikaUnsghbszFWICIlcUyCjft16MMA7nM/9haBz8zMw8JkmRxB45qmJGzBNrGePxY0bhQeqfutdcYvC74iqovVMG9SkLj56n28Ece7/ivDf5unFpEuWwviARXIg1mnjh9b5Zsl13KRFUaxUY5/6IuVlP/4ezqW2bzc9PdPwmIIzMveKfwLaKd5835OEogCyedECMiakPkJAW5nuFCWW7wWN95ccMa/CcqxA+gZV1q5wPJjXuoFMEcbIOHtZvermb4eV8Nx3G0YAN4qvelW0aOrgFO8A7OoPyGYrq0SjUAFVsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(8936002)(5660300002)(26005)(70586007)(81166007)(86362001)(8676002)(4326008)(70206006)(316002)(54906003)(7696005)(356005)(6666004)(6916009)(1076003)(47076005)(186003)(336012)(82310400005)(16526019)(426003)(36860700001)(40460700003)(36756003)(2906002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:44.5171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1133ea-695f-46f4-fe1f-08da2a0a762c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add convert for CP RS64 related gfx ip type.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 33 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 11 ++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 8b42d87f55ce..c615fe095bd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2289,6 +2289,39 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_IMU_D:
 		*type = GFX_FW_TYPE_IMU_D;
 		break;
+	case AMDGPU_UCODE_ID_CP_RS64_PFP:
+		*type = GFX_FW_TYPE_RS64_PFP;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_ME:
+		*type = GFX_FW_TYPE_RS64_ME;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC:
+		*type = GFX_FW_TYPE_RS64_MEC;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_PFP_P0_STACK:
+		*type = GFX_FW_TYPE_RS64_PFP_P0_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_PFP_P1_STACK:
+		*type = GFX_FW_TYPE_RS64_PFP_P1_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_ME_P0_STACK:
+		*type = GFX_FW_TYPE_RS64_ME_P0_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_ME_P1_STACK:
+		*type = GFX_FW_TYPE_RS64_ME_P1_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P0_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P0_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P1_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P1_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P2_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P2_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P3_STACK;
+		break;
 	case AMDGPU_UCODE_ID_MAXIMUM:
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 127c034202a9..273432b75fda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -389,6 +389,17 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_CP_CE,
 	AMDGPU_UCODE_ID_CP_PFP,
 	AMDGPU_UCODE_ID_CP_ME,
+	AMDGPU_UCODE_ID_CP_RS64_PFP,
+	AMDGPU_UCODE_ID_CP_RS64_ME,
+	AMDGPU_UCODE_ID_CP_RS64_MEC,
+	AMDGPU_UCODE_ID_CP_RS64_PFP_P0_STACK,
+	AMDGPU_UCODE_ID_CP_RS64_PFP_P1_STACK,
+	AMDGPU_UCODE_ID_CP_RS64_ME_P0_STACK,
+	AMDGPU_UCODE_ID_CP_RS64_ME_P1_STACK,
+	AMDGPU_UCODE_ID_CP_RS64_MEC_P0_STACK,
+	AMDGPU_UCODE_ID_CP_RS64_MEC_P1_STACK,
+	AMDGPU_UCODE_ID_CP_RS64_MEC_P2_STACK,
+	AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK,
 	AMDGPU_UCODE_ID_CP_MEC1,
 	AMDGPU_UCODE_ID_CP_MEC1_JT,
 	AMDGPU_UCODE_ID_CP_MEC2,
-- 
2.35.1

