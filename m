Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A83EB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 05:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0341F10E64C;
	Fri, 11 Aug 2023 05:18:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D998510E64C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 05:18:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ga+pWoiCAcQAmE9HSnlq0CkiEaDtcfQt5Y80YnPV7jh11NLAiBJsa3S6+hiEqZB1zXT/wa2M1ThPyxngCyCt0nh0mcGT6DeHNokZSR7eMtghOj1QBTz/TYbI8wrFzGphImIlXkNYQVHDBr8VCV4ZZ+i4xQ6M14/Qe+U6UyLW2Q+Tk9pUrahc5x1qCYKZ2WH3Dbx3EQvXijdz0gcMBH9J06LHqUyQrtAWkrvvAkliETRJX0fiqaj2zpqjn10L/wU/hKesNpmeqGaR4GDmxIQCTit5YppxKqpJRPc039WMTqnTAx3jF26nadE3C7RsFEPbni4GyafhzfmSpS9MZm+Vpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNEkS9yfK0kTmXsNx7T3c0/VONbG4vVIeeG5nTo9/8I=;
 b=gaszkKvHKhlrAy/NzbATN6B1s4mMMPdox5E+BZqT0r6k3fHxplN3fECth9cVpdLwp3z6QttUr9VFIOlCBxZQvHNRMCQvUFcxkjstfSzvFtyNjgTm9vd1dgqRPAshlzI3SGzT32FHlRNqMsUDbkfnB75IjFIFqv5Ai3Ozn7Wn21OoiRZsgkjrD9qz7/8PxghtsEuv32pXqEifXFXg4SwBJ10a6R9axK7but6vxvsyMgBW04doGfq3SokJImzclvN8d54oMSSg+/ZA/ZnZqVrBcwlYfwxXdL1qDpa72b+7ABI5cq9N7NshOhBVHRgkuZ5trIEqMP+3M85L6CluAWSspQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNEkS9yfK0kTmXsNx7T3c0/VONbG4vVIeeG5nTo9/8I=;
 b=JuKz357uwA+XIFIjpsYqFQdLDfS3asgbK+GqBAZyifB+cdmj8h9fm4mSWGQMnDGeKi5ygPfOLBL7VETbSQsA86Uz/ulje7BmJ/BbsNRWrRjkrP4yAzYfLCsc8z7f4x0mLUXuYzTgtxICc2ngbTlJKeJbnFAofCpYPkBxUY8bfyk=
Received: from MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::6) by
 DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 05:18:48 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::4) by MW4P223CA0001.outlook.office365.com
 (2603:10b6:303:80::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 05:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 05:18:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 00:18:13 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Unset baco dummy mode on nbio v7.9
Date: Fri, 11 Aug 2023 10:47:53 +0530
Message-ID: <20230811051756.653422-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811051756.653422-1-lijo.lazar@amd.com>
References: <20230811051756.653422-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed1a163-726f-467d-8c9b-08db9a2a70fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLakoe14jvFRePGF5XLa5Fr/8rm5Kq6FO2n0IjVI+0QSvCs2kzfhEjp8+IdT8gOUiWuygaQUWiDnb3w9EhZHgeBJOKh2jbIUsCWOQ3QtBcsZMXZlRp+N75mKmtH0LjyUkQBTSmgIIZ9ubMnoKpDo31l2x2UwDKMfxN903MYDZhO+fQ15lWiPwyZ10VUBWwCDeql3n3CHWV/WlbLiz37Tx85akiAYUCNnYExj/aMO/h+LIFJ/9r/Yf96R8sHnikB2wRvfrDppoIUnRFivE6c/gFDPutT/oUFqY6xmH5Klpoeaf5v3V7LGb7bJgEVsjhF3EvCsG9pX4eDq0tvbfGzoU+UyCJnaRHv1ETvf0a2SEdhpv5ZI5lSpkRTcYd2CjGnvRFsL0YWbcUGk5/BdVPQNWrFIhQjEsXqk4YMhqynjcz4BHcsRSC6rEfZUtCpptaWq6NtvmFc581veznLA5jezG36GKlq3KO/KZOtpVOw9DJ2j0ITjPrm20oW/BUu4zStE6PlphLQ3+Cma5GTZN8njZWn163/AgczipazavTfxhOP6U2j1uEYYMjbiUbgO7fGn7wPa8MiDP87GfCColR4DJs1O4DYuNMPVYRX8FeWtLd59btwvNHlWQf9QqF3E/QphC7xIisl9mzBnNTP6hvFlVRtAAYwaSFbNRbBeBNasXGmB/OQnLDph5/4E/TuQXgXGJGoeqSwRl/TnIRj2HvXJcr/0pzaE1gKw7gFe/BW7/OkUJ8FjKtB2pkjn/uORYtjphcBvp02rnpvX01arRMfqYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(1800799006)(186006)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(6916009)(70206006)(16526019)(26005)(336012)(1076003)(6666004)(70586007)(478600001)(36756003)(54906003)(83380400001)(47076005)(36860700001)(2616005)(41300700001)(426003)(316002)(44832011)(7696005)(2906002)(4326008)(86362001)(8936002)(356005)(81166007)(8676002)(5660300002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 05:18:47.6619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed1a163-726f-467d-8c9b-08db9a2a70fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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
Cc: Alexander.Deucher@amd.com, Le Ma <le.ma@amd.com>,
 Asad Kamal <asad.kamal@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

BACO dummy mode could be set under reset conditions and that affects
framebuffer access. Check If baco dummy mode is set, unset it if so.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Tested-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 9ea072374cb7..f85eec05d218 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -437,6 +437,24 @@ static void nbio_v7_9_init_registers(struct amdgpu_device *adev)
 			XCC_DOORBELL_FENCE__SHUB_SLV_MODE_MASK);
 
 	}
+
+	if (!amdgpu_sriov_vf(adev)) {
+		u32 baco_cntl;
+		for_each_inst(i, adev->aid_mask) {
+			baco_cntl = RREG32_SOC15(NBIO, i, regBIF_BX0_BACO_CNTL);
+			if (baco_cntl & (BIF_BX0_BACO_CNTL__BACO_DUMMY_EN_MASK |
+					 BIF_BX0_BACO_CNTL__BACO_EN_MASK)) {
+				baco_cntl &= ~(
+					BIF_BX0_BACO_CNTL__BACO_DUMMY_EN_MASK |
+					BIF_BX0_BACO_CNTL__BACO_EN_MASK);
+				dev_dbg(adev->dev,
+					"Unsetting baco dummy mode %x",
+					baco_cntl);
+				WREG32_SOC15(NBIO, i, regBIF_BX0_BACO_CNTL,
+					     baco_cntl);
+			}
+		}
+	}
 }
 
 static u64 nbio_v7_9_get_pcie_replay_count(struct amdgpu_device *adev)
-- 
2.25.1

