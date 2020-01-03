Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502C2C2D0C2
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214D321734
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1QNCrPZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214D321734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C7A589B18;
	Fri,  3 Jan 2020 09:48:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 847F589B18
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 09:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEPkzxjBO0+Iy0zzdMPDJj1wLedSX9sgHMOfqMf2p1jPU9C8jAbNsRQ0O+A9DeiYdzpFR1SHNIu7LCeS5Li97thqRCKCht/xdU5ZMmDJ0L+RQh+PbYlwCS3yBUWQmUYBUXpisnxJMUeeBQH28xyQ1HT2/61dT17ZCb4FVT9f9GbE22LsRwHbpWLX46ouJcwr2uu8W+1clrv6r/2Ygy40K1gsv7rxkEcGeu2ZUQ+7V0mafoMZBinBrmj9YgHWrsp/YgxvsIxGmKJrvUDa5TBE8mJHePh1kuy2Kx+whJwcnFRxX3rSb5A4i17ImTMFdHiqVpe/P0ReryJ2kRT6Ixowsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMMwg7jgG/QIF1VgVZ4zDzK5aWQPfcWM8prignye4XY=;
 b=OftnAnZZH7TDqjSRARAdVIGwhRt3I/Cwr4eFaUz67azhCwpthfqTTZhUkiVR/I4M7ByQllpRdIFmWEbbHcw0rUPpqb893f0oeyDxY6imNbX97j1xtgBl5B8pvLwPFdvxysJrod7DjuQ0rIe3AerBFkdYZV/TiW5djNfkwZdUITgSBBY1h7fiSQhUdMbW8YZ71gBQwuZFA7kD/wQInRJiBtDEMYew0Em/S3NRQEt7z3+m0jsbwItzHLdK43iJ45NXA+NfHWUnMQSX3Um8yRH3fgn/IoABrhytrb6Qb1HNvpMYq3nlJyDGp3WJiG4bDVj5l5GriejnjDGgRaIPF2Z94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMMwg7jgG/QIF1VgVZ4zDzK5aWQPfcWM8prignye4XY=;
 b=1QNCrPZXVSLIRj2tNdAIZ5PmoytqJvHiqkJxuRRTAJTsYs2v4C5Zxr4C0UxbUGt09M5WghHDIuNM9p8yFmedg86ycy73zrWqgvqyI7pdYMUg1KUc8T/wjeu5m4fpBSLZtOmDQ0zUVXJ09Gh6F+rdn1YpVa/NLKcelLI6JqbzCO8=
Received: from DM3PR12CA0081.namprd12.prod.outlook.com (2603:10b6:0:57::25) by
 DM6PR12MB3321.namprd12.prod.outlook.com (2603:10b6:5:3c::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Fri, 3 Jan 2020 09:48:28 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::204) by DM3PR12CA0081.outlook.office365.com
 (2603:10b6:0:57::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10 via Frontend
 Transport; Fri, 3 Jan 2020 09:48:28 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2602.11 via Frontend Transport; Fri, 3 Jan 2020 09:48:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Jan 2020
 03:48:27 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Jan 2020
 03:48:27 -0600
Received: from guest.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 3 Jan 2020 03:48:20 -0600
From: Jane Jian <Jane.Jian@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Leo.Liu@amd.com>, 
 <Frank.Min@amd.com>
Subject: [PATCH 4/5] drm/amd/amdgpu: L1 Policy(4/5) - removed
 SPI_GDBG_TRAP_CONFIG from VF
Date: Fri, 3 Jan 2020 17:47:43 +0800
Message-ID: <20200103094744.2127-4-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103094744.2127-1-Jane.Jian@amd.com>
References: <20200103094744.2127-1-Jane.Jian@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(428003)(199004)(189003)(6666004)(356004)(316002)(70586007)(1076003)(8676002)(478600001)(81166006)(81156014)(110136005)(86362001)(54906003)(70206006)(4326008)(26005)(6636002)(36756003)(7696005)(5660300002)(336012)(186003)(2616005)(8936002)(2906002)(426003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3321; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c6699e2-fa8c-4285-89b7-08d7903215a5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3321:
X-Microsoft-Antispam-PRVS: <DM6PR12MB33211504A156FD21C695FA4AFF230@DM6PR12MB3321.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-Forefront-PRVS: 0271483E06
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eoTn5oS4tIa5D4CL2ePbnp9Byjt1kqob1c2y16AiL5Gh7Vp8sruT0Cl0nO704Ie1hZ+Bvl/MbQ1bW0nVLrdwovKx0uAmA3p5cc4uQcIPEAUjtft00jH0hjmAhEoZxe8jap3vztwNWCQQiVUPoq/rUjznE+rYOaEl6iv1UIZFdCExQwckW/2Ic+MHXnsa02vtU9WlBvBJ1q2or0CzDLUoc+D/yUbPXG/0mPkEp+NlBLaDkAgd+TnOSSlFZ7OD2aOLmkseKqc8ekOT0kTnSBfpUtLxvxBXxaLeFitdCU5/y8qls/LN4PkIGdCXRjTIQAHfTyF/7hfmuY63J6Diqg2rDA823AIbzeqtcFkiaV5o3iu0AKWZkjOlyN0Or1ggrlm0MKJ7B/Rv7mTYfjLyCWQlxExNi4YqAl39MJflQbmDuZGKXNmggPpwl85cjPn0bjaB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 09:48:28.1718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6699e2-fa8c-4285-89b7-08d7903215a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3321
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
Cc: Zhigang Luo <zhigang.luo@amd.com>, Jane Jian <jane.jian@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhigang Luo <zhigang.luo@amd.com>

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
Signed-off-by: Jane Jian <jane.jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 35384f543664..bf02ca198283 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2252,6 +2252,19 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
 	}
+
+	if (!amdgpu_sriov_vf(adev)) {
+		data = 0;
+		data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
+				VMID_SEL, trap_config_vmid_mask);
+		data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
+				TRAP_EN, 1);
+		WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
+
+		WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA0), 0);
+		WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA1), 0);
+		WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
+	}
 }
 
 static void gfx_v9_0_init_gds_vmid(struct amdgpu_device *adev)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
