Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8962CDB474
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Oct 2023 16:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56A0288CBF;
	Mon, 16 Oct 2023 16:53:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0090388CBF
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Oct 2023 16:53:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cu2pnw+Fitpljc5EqqKIQujcM7DTRNyGrbfv3mfYIRod5irnJ40NdVJEU5Q56cFaqMF0ZywOBdFX/SA8eiwhmawY69Ko6ZDa0uG1zP3foU1I07HpFBLC9/AQ2kGwv3fMHd7r2jvSQauQiNlQjNPFKp0/IniZ7d9uCBFu6IFIgY0JmEjgMCSEcCfiXehzPdNaYOFcA9E7Xu2F92cbhCZPDDGukWiHopTYwo4QoTM/NYBG4ersVVqIxrI4I+T8IlX7f7XC5civTi2n6p9wRgp3sjOPC0qmEyhn8yD1ElaWK6v7/1954HTm9yJoPAJC2C6BpULFQ43saBgrTw6zpXyWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bt7YaVHAMiGfTrfgUoMojgv2MCZP4vFeWJ8w8MdLJp0=;
 b=bFan8mULUzqnlP8oaLwkzStU2FaoZTcl6wSHZfMGTpzKXWMsYcpKChI6AaCv3VfYV1byhmexElnVYDrzw8ya48nIPwfp8dqEa4l186yLEYPxWkLWupA4FUmmuUMwhVt0H9FvR0MZ28+P1YKw2nRiNkFvgyguPgZh+wpBue3GM4bOdlB9AVSwg9T59YHSEAAdw9PwgHXwz07r8Sw28irRDzSTqb4aj5ZEGwJHil7Rfho+gj1zmxZ4sExGksE8ROWUpoC8W4TC8DMUqCrV4BCJGWiZrQwQJY+drtCTEtFqQQC1kkaHo9rKLFfsO3exDhN7jAKMRkYwix4Y0ZhPAAzxwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bt7YaVHAMiGfTrfgUoMojgv2MCZP4vFeWJ8w8MdLJp0=;
 b=Iko1vflIV2YftRAFtYY3u00ZD3IeXwLpoTsGFhn/ZZ1wOjTK/mTKplZp7xwi2COJdrGcGuNRXi4vWENFaS3HGWoqAWAcLV9yZarXBtWCNZnMteNO4Yy3XCu2jDIgfTqZVQWprazEOFWTXSWqy2WZKKVO49ODt0FbYtDTcRvaTJo=
Received: from MW2PR16CA0048.namprd16.prod.outlook.com (2603:10b6:907:1::25)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 16 Oct
 2023 16:53:32 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:907:1:cafe::e4) by MW2PR16CA0048.outlook.office365.com
 (2603:10b6:907:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 16:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 16:53:31 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 16 Oct 2023 11:53:29 -0500
From: Bokun Zhang <bokun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 1/4] drm/amd/amdgpu/vcn: Add RB decouple feature under
 SRIOV - P1
Date: Mon, 16 Oct 2023 12:52:56 -0400
Message-ID: <20231016165255.2760-1-bokun.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c08cb24-ba35-4485-783e-08dbce686dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TVV27G+kYdva17Z1HL8iC0lG7e5DYhsavKvZYg6ajfUM6iZLHo+ARIrQN4QbTg9t73klPT5SIS3MgaMPvcBHHQMiID9Zclfn+4zmamArvB80bnqdjEkAE6QInpv4g9jsz08FUx2w3I8dqMzEibCT62ZTyI68NutnAFxCpmmfES9JVFiWqi8vfBBDmHYZUusFJqgHuqHJfRoMNriWwbaDlwLbb1StBFaJP1c0sgZUo7aW27KJuRioXk4T7MOdzWNMinP/GX3lFzhJM8+0DGH5iW+nDvuuAPDArVf+8TABRLHjoKT+xngDe7QoEH4cm+d1lCxApvzr0CPespsdEwPDSqOhJwzmvpNNlE3HgBJ0w83u44IikdKJHb7XCgZ5edn3a23c8QAeIRLILxJvJL21zsgPFpvXcQul3tWyuI0zMPHb3N8cDDDiMCHsk6qgRRopd/3MSHy9gLqICgUbjLM2XHTeyeEOxrD7appHqckSMfpu28fadwnVqsDSZowiRtvI9fDkCpD5YnU59D+vwxowXLrVTF1WS3i8hTkkZhTakhwofmDFTC3Jy7BYt5kqQ5QCfEW85dTYAVTp8jDr7FpNuvmAzo9PZjsH2AJMpe61Bi91wUkBrPLMZnds8tgIB3hIYBCvWOBND7/aigacxuvrt1sX3YmDCNawJs0DlERg1Yif4sYIPAsh9oncPdWx+zDF1MxAULAucIAHuMNmNfFJ9DRqcF63YhQrcInBwUedprVSCHD3MK/39kP/ygI6+fJrUFd+H0M/C2+dyshLSz4lwxkKotKAjziK1sWDFuQtBVtaKGcXGaLcfTxNW4Xgep8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(6666004)(7696005)(1076003)(2616005)(4744005)(82740400003)(356005)(36860700001)(86362001)(81166007)(36756003)(40460700003)(47076005)(44832011)(6916009)(316002)(478600001)(336012)(41300700001)(70586007)(2906002)(426003)(83380400001)(5660300002)(26005)(8936002)(16526019)(4326008)(8676002)(40480700001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 16:53:31.5456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c08cb24-ba35-4485-783e-08dbce686dd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218
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
Cc: Bokun Zhang <bokun.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Update SRIOV header with RB decouple flag

Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 104a5ad8397d..51a14f6d93bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -90,10 +90,11 @@ union amd_sriov_msg_feature_flags {
 		uint32_t host_load_ucodes  : 1;
 		uint32_t host_flr_vramlost : 1;
 		uint32_t mm_bw_management  : 1;
-		uint32_t pp_one_vf_mode	   : 1;
+		uint32_t pp_one_vf_mode    : 1;
 		uint32_t reg_indirect_acc  : 1;
 		uint32_t av1_support       : 1;
-		uint32_t reserved	   : 25;
+		uint32_t vcn_rb_decouple   : 1;
+		uint32_t reserved          : 24;
 	} flags;
 	uint32_t all;
 };
-- 
2.34.1

