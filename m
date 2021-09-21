Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC086C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A236F61184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A236F61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 119506EA8A;
	Tue, 21 Sep 2021 18:08:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCE3E6EA75
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GptFOt0vdQMzOdBHlynYPDNDtVgO9+uYh0E++p5TdztXbR2lfZzIfkvVZx2kjlBgBDHL2hmyXpKuQDAHuatRsYGmaEKjnlMaPo8pMiFLq5E1N8U+GtpXL0YjwhAZUzKP8F50JzAvmIlpTObtXV7NyK4XfNkuIGQyXNpCOgmK2Xosz8XwLMVCKSChk3juz3WVmMWIGjguxLeFJo5bhQlGaOSIRzv8N+1Yw1OQNYtfN/BL5Q8NNDXCZvKZ/OPrAM0JbvYkelL1SiMNlxfvkJ98+Oa4xwKSQVOW4pta+8WkK2cJG/AhoZ9o2IClHt/61e5DWMOkejCvqzgB7mIIsmvPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Z1cEtxJ1POvY+PoZr/fOKKTUblPoi89mm3mTnZZker8=;
 b=Ie3WsQSSo0eFwG8SKsZSXTl1MIOv9hL5wz4OavDK+lOdTPgfVj4mDbiLNfhr0YLOBuYsG0s9aYf4TS3ThqwW8yHLciLphi+sACi2TpgFvMp+Zz/5da4SoyJAdnt0zK8H/ffxljDqLRuy6b68pUnPO3IU4Qv0Kol16wcmCVtdt9C5iFJrhhf738GK48s8nb84aNFENTFQ5toe2kdf1RMXHPtcWtf7ECI4GOwP8h1TLHP/d2rV8EozdlGTDqNIxZey8UbC7L7hpI2m5TEovNIEa8KtYm11RmiTbSWU31M+3EYjke+ZIh77cjeC+hZNbmtC5XoPrLOJW4Vp+kWEdjWcPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1cEtxJ1POvY+PoZr/fOKKTUblPoi89mm3mTnZZker8=;
 b=XxAWcNU1zveet18cxEtUBhr3jDEQ8t3znv2wlCn4oBe+jiOnP7lBUiVtBg8559oE8MnOLiHFP6FFTY4N8geXFNxR6/mNZlTu60aCSvoul9xLDSieutsWOwTlXhID6aJLeqHRrr9sKPnCRcC33IcEZz/2PzWoGF29MkFqP7fV0z4=
Received: from DM3PR12CA0055.namprd12.prod.outlook.com (2603:10b6:0:56::23) by
 CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 18:08:06 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::9) by DM3PR12CA0055.outlook.office365.com
 (2603:10b6:0:56::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:08:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 51/66] drm/amdgpu: add VCN1 hardware IP
Date: Tue, 21 Sep 2021 14:07:10 -0400
Message-ID: <20210921180725.1985552-52-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 062c5cf4-c4d2-44d3-da36-08d97d2ac2f0
X-MS-TrafficTypeDiagnostic: CO6PR12MB5475:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5475334F8A3337E5D5CCD3F4F7A19@CO6PR12MB5475.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3aRzwYniaiRtTO+w+G2jEyiFNuOnltqd7UySqrV1lvb6pqtqU108pJV6ZcgYqsqs2zwf/LyUHD4zI4rqgWV4+YaMo7FdBvTavVZvGTrNCwICBLTEne8dkbgG/+tbV3krisPy0aFyCHhpeQXNnyZtD7+PM8qdMHQ1914sfEt/AVkUZ/Wk284oJFA6pNRsyBIxyx0RI/2HmdEYiJeKdBkyIspPXtNKtHA9tas9/2KwLiqhGPWOKx70FfbmJr8BtLSUU1Xd11gdfX0Pn8fAFzgC97tiQdPtto1GkdSj1w3p3Gz9WSpUKAtioh4Wl7MxCqHqshKWX4lem85BqL5si09Mr0bJ4otN/fTlhwNiv4m15tFY23uUSKRwPDHeE6ZU35cWULNd3tA3zRlpDfJO9mTiru26QV2GjV8cDt+kILispzOnmx3iR27JW1cfm0lzGy0Ix38dnbb87IhqbW8dEwExF0zA7ekRbDP5qvs9q/NV5j3dtm/b5kO90wYRws3pzLp3WbkBTHgDzJGSK4cwxLiNGd0KhXMBNZCNvMSn/5Mg1/XagsZF901+oqJgtAJeCITFm+5kTtcmseeBBq22u8Drvwz0RaUyW+knHylyrikO9/T0YYBlX/GwrNoYk0tOVzMH1MIrLTLYLNdezn8tNDhkmg3Nz1hdtLNQrlqQdtkGZXgITkUfsIpTLDKAs8ajR4qLI75Loqeeb7BYp9uqpFMpor8CUOa4ML+q4KKQA1jBY9c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(82310400003)(4744005)(5660300002)(7696005)(70206006)(316002)(356005)(426003)(186003)(81166007)(70586007)(4326008)(36756003)(2616005)(6916009)(36860700001)(83380400001)(16526019)(47076005)(6666004)(8676002)(86362001)(336012)(508600001)(26005)(1076003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:06.1439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 062c5cf4-c4d2-44d3-da36-08d97d2ac2f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
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

So we can store the VCN IP revision for each instance of VCN.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 815db33190ca..b153c3740307 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -744,6 +744,7 @@ enum amd_hw_ip_block_type {
 	UVD_HWIP,
 	VCN_HWIP = UVD_HWIP,
 	JPEG_HWIP = VCN_HWIP,
+	VCN1_HWIP,
 	VCE_HWIP,
 	DF_HWIP,
 	DCE_HWIP,
-- 
2.31.1

