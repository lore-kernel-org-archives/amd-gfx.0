Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0FBC2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 07:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE63E61429
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 07:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE63E61429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799476EC22;
	Wed, 26 May 2021 07:42:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 393346EC22
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 07:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eumU7nXIrrEDLaODoBXtAx490O4tcwxylaHQn+wOOp2WCv17P66mWS16ooZH2Ig/7NmLohhKynSl/oY7yXf7RVAtAiVAVCdq79tFrv6dHzTMBBe8HbHUOhlWOJD2UzO1jSsrL+9JViR98NhaOAtU4nyaNp785WEGY20kj1FCpva3KaekJ58OyF2IPj3h4osGlBLRjIc27z3z9xQ0LH5o2booVZVkzvLAikti73nXAVeGunxsyhpzdG25SOvqER6HizlKUUQcoId0P5rSekIiURfYjwCKJL6pi5f/aiYQBUu0e+SJYG4iFVgX9Qn0xtftqegcqbiY0auxgLpszOqkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLudqNyCMz2fxr8RX3JyDJNyd/2Ws7sQQAT7rCrzPZk=;
 b=TSORTCWaJjrEEEx42vNLtX3GTvJP5Q8XGWtdkusXtXirL54yO8UyrNwLAfNEBCz5cm2Z7egWGwsxBkQJwPVr6qPOxgwwstiIWl8MevsW0iD5UqY6jxX3PDZ2tQz3+gXDWL5LNLkJdzuOo+QXCMHsrXXyoBNKiLa576Cz/pEjPsAqDexYzZ5W3sN0AeZ5SHmtMZ1KMUkCFn5YXiWFDEctJu/Nqh5+r7B+7knI9yY5JAD3P76vzxhKD0yAKQOR0zssutv0ORuYln03ThqzOkhNeSExO8amLdQ/YPHPZocprmkZIo4P7eWPwBP31SUp+VNnfJXU6CFhm76e+RLxPS5yQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLudqNyCMz2fxr8RX3JyDJNyd/2Ws7sQQAT7rCrzPZk=;
 b=GVMMjmfSA+Rz7zDdkB4lMkIpZa4XT1OObT7gkCFWIi1azIqHh65z7T99NijxVUjmWx2sqppYyWp4bZ7LU2NxL5d2dnpySetHHeG0YsmJ6EU2/Jsrqqg9RIZ9ALRpHQOAHWCElgwQ3h/EOenZuqgzbJ/HV3mzGD3WIiGKCprFhU0=
Received: from DM5PR05CA0004.namprd05.prod.outlook.com (2603:10b6:3:d4::14) by
 MWHPR12MB1838.namprd12.prod.outlook.com (2603:10b6:300:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 07:42:35 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::45) by DM5PR05CA0004.outlook.office365.com
 (2603:10b6:3:d4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.15 via Frontend
 Transport; Wed, 26 May 2021 07:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 26 May 2021 07:42:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 26 May
 2021 02:42:34 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 26 May 2021 02:42:33 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCHv2] drm/amd/amdgpu:save psp ring wptr to avoid attack
Date: Wed, 26 May 2021 15:40:56 +0800
Message-ID: <20210526074055.30733-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 145d57d8-49ac-4379-83d1-08d92019d414
X-MS-TrafficTypeDiagnostic: MWHPR12MB1838:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1838AAFE7A4185400A875453B7249@MWHPR12MB1838.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e67ctNCZgXxNH4v9+3EHjNfxUdzx83hPB5gE5nuSEC20xWNwUT8FP5LAjZB/PIzkEfZyXYgP2pE/HZ1TQjQBjwAVN6OTrtRt3UJasGZDNfaHoFRQFRvunci3S8G6CKlEoy8jSdmQn2FNvlrMiaHBY7bjRShIA3PeD4aFa9Ti43TnbMc3D3JBRWlaX4fk6qyDYi90ViGZL17H9zmKC7+JFj1CAVWeMMBTisk94Sgv1xJSx/Q7RB1gVbg7mkg8dy8m4QXgrbAndlg8us9S66y6s9phRmDo+/Md4kZ5bQiHlagEw1euL5pG4xHwxZn/o3U3z8lqshA8Dbio1x+I3RDphTQH8hnzsU8vJFLNIJEU9mJsR15My9DsOd2r61qRDEW6yJ/72G24SMEmK28MqJRyg2Y4tClbZT2B4V/tpkRyyS/v2F2yNJjISgtEyn8URvvUPHeVCcYuYwHSxOOdlVEQ4Nc8sMm1UGx+aU+Jo6HA0Vqc36O4G4MqePZwk7ry3s+G4eV/nLwGMip9ClGk7mchGGHB9PdX1cXfhVpIOi4M6pOhJ8nq1+Gm577EmdT+lGtvxSFaNtW3F0BUMjZ4wPvjgokfDOuH238xKLnfbevAtzfixqHYXTcS+tBgkFb+xwxh3WT6DENU+fORnjorENvviVtEQNjYSMiN/xdGx89eDoxup/6fZL7SN5MB/j28yC97
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(6916009)(86362001)(7696005)(4326008)(83380400001)(82740400003)(8936002)(70206006)(5660300002)(6666004)(316002)(356005)(36860700001)(26005)(70586007)(478600001)(2616005)(8676002)(82310400003)(1076003)(54906003)(2906002)(47076005)(36756003)(186003)(81166007)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 07:42:35.3081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 145d57d8-49ac-4379-83d1-08d92019d414
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1838
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>, Victor Zhao <Victor.Zhao@amd.com>,
 monk.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Zhao <Victor.Zhao@amd.com>

[Why]
When some tools performing psp mailbox attack, the readback value
of register can be a random value which may break psp.

[How]
Use a psp wptr cache machanism to aovid the change made by attack.

v2: unify change and add detailed reason

Change-Id: Idee78e8c1c781463048f2f6311fdc70488ef05b2
Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 46a5328e00e0..60aa99a39a74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -76,6 +76,7 @@ struct psp_ring
 	uint64_t			ring_mem_mc_addr;
 	void				*ring_mem_handle;
 	uint32_t			ring_size;
+	uint32_t			ring_wptr;
 };
 
 /* More registers may will be supported */
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 1f2e7e35c91e..0fd1ed918627 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -733,7 +733,7 @@ static uint32_t psp_v11_0_ring_get_wptr(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 
 	if (amdgpu_sriov_vf(adev))
-		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
+		data = psp->km_ring.ring_wptr;
 	else
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
 
@@ -747,6 +747,7 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
 	if (amdgpu_sriov_vf(adev)) {
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102, value);
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101, GFX_CTRL_CMD_ID_CONSUME_CMD);
+		psp->km_ring.ring_wptr = value;
 	} else
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index f2e725f72d2f..908664a5774b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -379,7 +379,7 @@ static uint32_t psp_v3_1_ring_get_wptr(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 
 	if (amdgpu_sriov_vf(adev))
-		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
+		data = psp->km_ring.ring_wptr;
 	else
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
 	return data;
@@ -394,6 +394,7 @@ static void psp_v3_1_ring_set_wptr(struct psp_context *psp, uint32_t value)
 		/* send interrupt to PSP for SRIOV ring write pointer update */
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101,
 			GFX_CTRL_CMD_ID_CONSUME_CMD);
+		psp->km_ring.ring_wptr = value;
 	} else
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
