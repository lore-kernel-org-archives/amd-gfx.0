Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728BEC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 04:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3A4F10E268;
	Tue,  8 Feb 2022 04:30:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E03610E268
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 04:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clVy8+MOGmFhZ/m3pZr1+r4l/MN+z6cOq3txxB5YZr30HCGLBCvbErl9Ol+jdQuKqsOBsz4Jp7Kv5bsgl0+ztBdkhxCPWkikIPJJ3BKboWrq8n9joTbJ1VJtsKWZKC+VfJo0uOTUMmUQT/lfoNBetEqW6PP/8zLdJAdgWeFqP+9gxawEPZ7Ja+NNct+ijyb2I4yVionwQCFXVNfI+Eov5mQ4qqN5Aut1ah9eA91AFdxwz2BgL4Y7YFpLoRKOvYLgzqKOqFm0ffq4dINKuaj8ktCjMm6wkvzJPHwawigRZrihwxCLoicYrM79+L5QOm8dHFg2hCRMOCLMdbkqRnajOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL8mz0SUkh7HMAgkS4jSHzLAA49l7vjUJQ17t7W0eu4=;
 b=W76E9DXlHPg0WEYoxn66sRkVWQ6EDtxzwuSNr5mi2K2L79YighaOCHE1VJjfzbSgkXvysy2Bs8pVtnPk9yiuc3MjAA+PcBW8vbnZGHuRePHlaSto/0HzoarHtrEMHHkh0ZTCQs1n7fXiDMgewhMtPzno6L55gaecbM7ZVdLiTpKkmP9A9gyrpsiloE9yYgfHZZfib3fTJBGa8fd0UKdS/kUtSE+lwoLlADId5TuYv2Z2ad923RJM/+wF5ueBInQM7OJ1VZ/+kRL98nw1tW40YOJmTjQstiw4YB/28YShNKxDSZjr8D+4CRyNBOWTAhCgXP5Fd7bcT0sCRd2A/LG0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL8mz0SUkh7HMAgkS4jSHzLAA49l7vjUJQ17t7W0eu4=;
 b=lRd86+ff8rNOrLucfPwnKc/vBWSyWTyL4tYw6Ms413oXr2bdl3LnHVRaYr0ZVWCaBKJMM0he1h/ieJW0WwD9BCWIs9Wao6xLAFi/H7o8KLzWecAfDVeRTvk91zjIRM9gP4j6Td9mUC5XCyAZlFqcRGjzF+ODSnaivEu4PWdh9co=
Received: from DS7PR03CA0212.namprd03.prod.outlook.com (2603:10b6:5:3ba::7) by
 DM6PR12MB3369.namprd12.prod.outlook.com (2603:10b6:5:117::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Tue, 8 Feb 2022 04:30:43 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::6e) by DS7PR03CA0212.outlook.office365.com
 (2603:10b6:5:3ba::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Tue, 8 Feb 2022 04:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 04:30:43 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Feb
 2022 22:30:40 -0600
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: disable GetPptLimit message in sriov mode
Date: Tue, 8 Feb 2022 12:30:27 +0800
Message-ID: <20220208043027.127195-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19df1a6f-b389-4775-7f19-08d9eabbc500
X-MS-TrafficTypeDiagnostic: DM6PR12MB3369:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3369DCF78B831022088D39A5822D9@DM6PR12MB3369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgFAs1hijt5Rm/+ttDftT1bNTvevCEPr5HJAqn/RSpTnbNyFyn0oLec6+VQkWiLddH/3PrLPlclDtL6KKHGdLumAI79uGn8zqXegavf9hKKW/48JRh8R5quNI+IQ8SBtdcmMkkauOmLA0BhmEEV1Ipks5EY5O4/W828RxFsFHQeGEIkMeFKTwR0D38ScRTt8GmlX2onpdbJc2jhJiE3CladTQpakeTLnKqwDf3w+DENCim/rJQr1PJGeYw1GxuDhI4GwxBrRmODlSxHDPvmnOnwinJuPFR3eALHJg8jbieaotOfnnd7ja1Scs6goo8eohWoDpO+fsxBLBr8gcAqThC+5Mr8KEj5/YfaSAgxf+HKfN39wpwrvat1cePxiNEDkRoJi40tQyzmeiO6stq4M3V6+HuwE/U2AEsF6U6bfqDT5Dbn9wiL7J/UD16LARUjAaAueECdTpUwffa8J9r9xkopglVmCnsdf7BlDFx9OUDziJRejyGfciJ7Yn9AcUqnd4O7KBjRWOXtWm0DaWPqfoXL/s5n+B4EITtzm+SyGYSYpTmq9OZ5m6DXZFEZ0PsmJwgsemzMWfpdFiKXJiAlAtlyIeKnhoihzKSo3EBk5xVwQ6i+cXVXR/b6R1ZA8HfgNIDD9v2PSCUVXCd4C83QsGka8fPwL20m4IM0p/diWoDlBU5U0Vg+AeUqAd2ohtE0prygdevG/LxKuXVc0V8r38Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(316002)(2616005)(47076005)(508600001)(426003)(15650500001)(356005)(86362001)(81166007)(54906003)(6916009)(4326008)(2906002)(7696005)(6666004)(70586007)(70206006)(8936002)(8676002)(36756003)(40460700003)(36860700001)(5660300002)(26005)(186003)(1076003)(83380400001)(16526019)(82310400004)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 04:30:43.3470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19df1a6f-b389-4775-7f19-08d9eabbc500
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3369
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
Cc: lijo.lazar@amd.com, Kenneth.feng@amd.com,
 Yang Wang <KevinYang.Wang@amd.com>, Marina.Nikolic@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the pmfw is not allowed GetPptLimit message in virtualzation mode.

Fixes: 3e4a01689daa ("drm/amd/pm: Enable sysfs required by rocm-smi toolfor One VF mode")

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 804e1c98238d..2a7da2bad96a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -140,7 +140,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         1),
 	MSG_MAP(AllowGfxOff,			PPSMC_MSG_AllowGfxOff,                 0),
 	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff,              0),
-	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 1),
+	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
 	MSG_MAP(GetDcModeMaxDpmFreq,		PPSMC_MSG_GetDcModeMaxDpmFreq,         1),
 	MSG_MAP(ExitBaco,			PPSMC_MSG_ExitBaco,                    0),
 	MSG_MAP(PowerUpVcn,			PPSMC_MSG_PowerUpVcn,                  0),
-- 
2.25.1

