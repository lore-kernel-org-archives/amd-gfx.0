Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565ACC47DDB
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 08:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1023C10E903;
	Thu,  1 Feb 2024 08:57:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC9210E903
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 08:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfOUx0eg6+PIcew64hGCjTAKuAetV0C984XXqXBjqgeHHpLyAoA94C0tW7InoXI9t2ipVs36RNLwFmdwoHohjg4pELeidSj3xTDn6EYipx8baDXO58I/JDOyOBMWZzoQ9IPsR986UPS/3r4Licl7EJQMwP3QTg/bASnw9/+Pbw4dx7q248GkeGJJfUoJh37b+OyADKBOEA6au9NHrtKo5QkmWoEsSvybWjd5ea8VB53bCRcZMB+n5niWnBy01JuizL7rZntak92RLqu15+PUdL6GvtyDGGySu/m4he8qfSr82UMmKhUrzVIOF/iolV0XWJeKyqonTIbF3SCOlBOuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07SwqCrIBTiqTX6BeAmOkHnU3Hb6tyVEAaHhIgM6irQ=;
 b=dbLrPoPDXjER6iH8HpE2/f4TZny6sigKvtgPnvmKpb73uz7gmWQEN3QhhJYk4EMTvOFlOq8z/21TqK8+AvV6L8WsR8oV6gu28MnGxIy1OrG2pZQH7TPWmH7uh1wGSilRo8U6n7ibkri7lVLq2JzkujChosmeikPsUCbiTMQjIFKh3uthyRV/KHRz4iVxVzDxaAH7FJKoh/XD6yMhkaF3EvPTxfLoq+WaO4cN2RYm2MUIKXwzzr+JbKEqRLQi3zFLMgSkJUSmADNVPpCh3u/pRrmaieI3Z+g0ntIGAkp1txvgxsMuDH8ZIHJT6ALVllB25NusVEHDIqmZqL5ULrIHeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07SwqCrIBTiqTX6BeAmOkHnU3Hb6tyVEAaHhIgM6irQ=;
 b=R78tizNDY9diJBx1J5x4S7AhOqvPZMAHfi1tZCoq3XLDa5jwempXjXvimeVs4AxJPRc4KQnHkLM7mXkBv5jE8Qtr/EIcJyof+Sv04lcrFfqwE9UklKlVcCdVuWvxJnQRxF9v7xSi4NoyhOGMZXm3pNp3SvjvAuKcs9CYaZLo3mc=
Received: from BYAPR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:40::39)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Thu, 1 Feb
 2024 08:57:48 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::35) by BYAPR04CA0026.outlook.office365.com
 (2603:10b6:a03:40::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Thu, 1 Feb 2024 08:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 08:57:48 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 02:57:45 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: reset gpu for s3 suspend abort case
Date: Thu, 1 Feb 2024 16:57:35 +0800
Message-ID: <20240201085735.989940-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201085735.989940-1-Prike.Liang@amd.com>
References: <20240201085735.989940-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 6abd1d5c-eab6-4848-1418-08dc2303dd28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: essY8eUTzIBJOqkwoxPaqY1dEoIwf7hr/67NCGsr3IX6iBGF3cEV/HTIEejxNXP5hYKt45hmb6iupYJF4Y9OTcRyMhONMCyfmjgFeztvFNYJ56Mz36iZSkt7teDXOG9ay6Pe7E38IcdvBQ9hYQFfhp+GyOcJvwPN20YaP2DtuXowjsxfiN3B3M71yf/+us9GbmjpPgTCP5eWF7wzKgYTcrhZiQ32fN+GF/E7Soy9zYE/T0gcI1YS/EO2O426kTLIW+vYpNFUKKeY6N47rliNL05KCjcWdhTD9H9vG9R7pY4Z4hOCQ+k0EQhhblw+gd/fHxR9232AUtljVr+gQK0UcRWP/LxaDAqNdlgOzhMQBFZcWGFPiUr9FmIH/JqWM5NNLpmcnL+zIJ7HjBMufhL0TDu3XabAE5k7WRNhBvIIbdoS+2VsufWt20XhlHxeifjeKVW36bl7KkCrl8BR9GCPd29V8PPiis3WUmjasO/G0e0PHvWfKY2a9iVRZevdR+SvhSN+6qf2hzDeN/GY75QFzKv/5i9fDSfmfu67P2XiRopHr42AVkzMv0X+wTZbirsVHQV4xZA6XGlhC1hgOMCYzQtCWu+o9izvnJqMP/qFsQe/KOWWcX4nHVVQa6I50IL4+VAD8iSnJBKOwiGnrUzjZiE7hJUR058z+1ZKoYoPHJ/S0E3DqCgBBPGyDCvgbYDiBD4Wswdh1NzG5J5INucF2tGppmtw43iJ5gxFadLHLVrvS+XNatk4r1nNkhJwY6mu/eC2coD2WPBjuMgjZAjowA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(70586007)(40460700003)(40480700001)(47076005)(2906002)(5660300002)(15650500001)(8936002)(316002)(6916009)(70206006)(54906003)(8676002)(4326008)(82740400003)(478600001)(36756003)(16526019)(81166007)(86362001)(41300700001)(2616005)(356005)(426003)(6666004)(83380400001)(26005)(1076003)(336012)(7696005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 08:57:48.0314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abd1d5c-eab6-4848-1418-08dc2303dd28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
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
Cc: Alexander.Deucher@amd.com, Deepak.Sharma@amd.com,
 Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the s3 suspend abort case some type of gfx9 power
rail not turn off from FCH side and this will put the
GPU in an unknown power status, so let's reset the gpu
to a known good power state before reinitialize gpu
device.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 15033efec2ba..c64c01e2944a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1298,10 +1298,32 @@ static int soc15_common_suspend(void *handle)
 	return soc15_common_hw_fini(adev);
 }
 
+static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
+{
+	u32 sol_reg;
+
+	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
+
+	/* Will reset for the following suspend abort cases.
+	 * 1) Only reset limit on APU side, dGPU hasn't checked yet.
+	 * 2) S3 suspend abort and TOS already launched.
+	 */
+	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
+			!adev->suspend_complete &&
+			sol_reg)
+		return true;
+
+	return false;
+}
+
 static int soc15_common_resume(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (soc15_need_reset_on_resume(adev)) {
+		dev_info(adev->dev, "S3 suspend abort case, let's reset ASIC.\n");
+		soc15_asic_reset(adev);
+	}
 	return soc15_common_hw_init(adev);
 }
 
-- 
2.34.1

