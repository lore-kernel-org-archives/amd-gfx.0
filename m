Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31B8C982DE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E05910E52C;
	Mon, 21 Sep 2026 07:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PCNrBF0D";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3DA10E52C
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOdTE07N/tuyr/o17pFk4YaSgckmoF20y9gqm5EiB8lvOX37PCobgjMTihUuFpkEFVHNRDLSGDuuLPwgt1jK5fnnyyRO6VMcyowUae0m0O8ItdSD7yZBDk8ioTuW4QtUkWQgWHJ2O1eSRu6iUgqnEAfhMoAkZ9x+2V7l5KBd9OneCsiNVuRHYyieJb+5qCuBllVKFbEzgi925qDu8+6Zmsdzm67bxf5M5+W8lybmvzGgxCuJJiRucAzPmin/UIr6vx8T28VZfH0rsgsLhUlOT2P54i6zX9OxXazdlVqA15wzlyVbqBr1oUfXRcXq7f+nadeiJKogIxEoJ/o4XGyRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHIlKgWOkIpvOwtu7OWyy8hIBZ/AjZa80G/o4Xq97JA=;
 b=imo3zT/sxIx7QbFdyTBFp+HVzXO6n9lmpSQTd5wucF/wwuMKjXGm8ovV2vJ2HJfd5Mszo7uLJKgeyWvzm6k25sOqafef7bAqxnHG5pvWYD+hdTU+6KdmQNPQB3MQ5KAkSejqprgi8XPpoPKIzfdSObv/v6szBPQ9c0cXGG7q+va1SoCLHChKuhQdRd5p/XlpoA8udEWK2Wr3PliOyxXLIOJz0wc6SzWlctdC0BGefonfD52uidMpOUy3hrq3F53Q5NaG9sBVXbVofNk8XLiQ3nrPNf2acHsTt4rNh8znvWyVej9al2VHubld2U+Uh/xE5YAsOn/B1Oc2DpJdyMQdZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHIlKgWOkIpvOwtu7OWyy8hIBZ/AjZa80G/o4Xq97JA=;
 b=PCNrBF0D9XAVBK3tzlz9T487a2TenLqYuOmIFs+6z010AVfpH9SnGFO2GTaMFvxOp+AxSV5+e5rQH+GT85bkYbPVw4GT5j7+wyf+kJ2M6bHYh4ISNT3bSZz+XxI/8F3rXhaQH2QfOmwzsc+nUnb3PJI5jBgElZQZwrCqbU7mT8M=
Received: from SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10)
 by IA5PR12MB999278.namprd12.prod.outlook.com (2603:10b6:208:603::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:54:07 +0000
Received: from BY1PEPF00026957.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::7c) by SJ0PR03CA0245.outlook.office365.com
 (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026957.mail.protection.outlook.com (10.167.244.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:54:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:54:01 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:53:59 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 15/21] drm/amdgpu/gfx: add a gfx ME pipe reset capability
 helper
Date: Mon, 21 Sep 2026 15:51:22 +0800
Message-ID: <20260921075326.2409021-15-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026957:EE_|IA5PR12MB999278:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e419124-641b-42d1-8cc2-08df17b583d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: DfrPCarJWubw+8Yfu1uYXAOnWLN8RJUJvenG/A2/9wJp9mqiiByn/Kka9Apt47HsBrWcAavISIDXb125GjsANPmfreJd78ozlzOFnaSOC7xc6gDNnnWPQELadxR2AFzpv2a0c4pAmN2wppWObsoFXPTEcxBESOq8n8EqMaZY5VHkceKFSy6QBL9NjUUWBViG81z4ZxKy/e7gft8lomj+VmiPn6uJVh3ZsOzpaNaT7AFLq2fN4u1JSirPkoBP4nyC4Kxjsn02m7apVc3t97prgDi4reE0qjytULpDBGUTpyP0FuJ8XrrXBbaIC+7pLmqU/JQURlrm8245PuX/T1LwU4O2OeJO/gWKlv2A4i/ZaBbIT/ufoqjafts5sw8knhrZIF/3D+xd3tJVE+Uej7303ccPSjA5LXvOi7FZXL0ODPk9W2tFEm48bLSbvuV4bstVTwqzLheKYxJ/JoWRsLvp0I8mmOWz1pl/Df+daXjiH+u3OFpcTSICtGQaOdeX46eY7cwPq5csi++7JjraWxnst/Bv+tzyJUVWc/60BZASb570Aw9wq/5SncangmHll04eMtDVxzRzzyKn6w+K4rR/Hih1aOI3QZz7OVC4oOcIwSkm2V1oDxhWuN9nmSFcJHeJtOlhzSS7+g8Rulej2OxP9eR9JiyET3YRqIvLON2R7N3fG6Dp5amoOsMyu6HzL4dlbhZYabgSHwRuRo7e675Wsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gNzEicxoDvuNHCGDZWrCuXx9lGl+F5OATQ3KU7ns5M0J0826SkWjKh3G4uxMN1TOhB1LV/Tfy4a1LGPkcAsDoMIJhoPIhUK/S5Id+e2ub6sVu2p45a77d0Ja8KFeFVo7UNDi2I4J47vtVVjidnKtA1Ui1F3f8jBPro0Y2uJCd3/M1dfb8os3Nwg5LKWhZFHnJQaGNMorUYOH9P2pquvUykqaHocr5sNeifG/M1WWTTmCkHXnv6PWGRcSGB79fLENBVpJIMNe7Nm0a7nXva3cafqhvFSaafSK+lgPJQ+R0aLVQZ/RbFtb7WTZqMFVIskP6n+EYGW7Fl+fdBlti4eq4nkZM64VUKFuLHIbUAMH5IL5RgQXwnZVomkG9JABwpHbg07YbiJTQ7F0Db/2wMpurzBPGPcDOoz9n8Dre5rJo62sf4LCW85cSc5SZWvQKiCj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:54:07.7303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e419124-641b-42d1-8cc2-08df17b583d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026957.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999278
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

Use gfx_supported_reset's PER_PIPE bit to report GFX pipe reset support
through a shared helper.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2da839228911..7c597dab5b2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2376,6 +2376,16 @@ static void amdgpu_gfx_reset_stop_compute_scheds(struct amdgpu_device *adev,
 	}
 }
 
+bool amdgpu_gfx_me_pipe_reset_supported(struct amdgpu_device *adev)
+{
+	if (!!(adev->gfx.gfx_supported_reset & AMDGPU_RESET_TYPE_PER_PIPE))
+		return true;
+	else
+		dev_warn_once(adev->dev, "Please use the latest MEC version to see whether support pipe reset\n");
+
+	return false;
+}
+
 /* Caller holds reset_mutex and attempted MES suspend before HQD lookup. */
 void amdgpu_gfx_pipe_reset_prepare(struct amdgpu_device *adev,
 				   struct amdgpu_ring *guilty_ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 855651f0c930..5939e1fb3b24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -707,6 +707,7 @@ struct amdgpu_gfx_pipe_reset_ctx {
 	unsigned long replay_mask;
 };
 
+bool amdgpu_gfx_me_pipe_reset_supported(struct amdgpu_device *adev);
 void amdgpu_gfx_pipe_reset_prepare(struct amdgpu_device *adev,
 				   struct amdgpu_ring *guilty_ring,
 				   u32 me, u32 pipe,
-- 
2.49.0

