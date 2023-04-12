Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DD6C7619A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 16:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821CE10E8A5;
	Wed, 12 Apr 2023 16:26:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FAFC10E89A
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 16:26:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfhN28J3Qy78gEs6xqT41p9aWk5vir26H49g+75GVopQZpOUTBG+QMZvXp6PwxBuRnDUzyiRDJAnYUv4XJrLnEWcHT//REziulPX7y5Wx9GsZTLsJJIAOWPeYse2LKJ9b4kENZki9+GYqaO/FTuy/3mI/rsx7JAyrHdi359gXFPxqJ77ovKMC73iUzAF8j4dBt8xw9mHr/GuVn3kjniCxzqH7vQRR9IGIaBVWtlZqJbaxwVL/AImhJZSBr7z1dbMVhcuR2f1BojUP6g/Tl1bUpvek0G15CrguuJhlnnHHlFnf1ROlJNbNr2xEEsRdi2y88U3KP35TPyge2gyszyK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3nAi/dMRPhRCYlwTGaxSKqti7VmjdHGJT43/sBqBb0=;
 b=GzpOJO/oYCrTF0bVdgVMtD95g3AxttC8jE3ocxYE7JvngEnQWYrTq0c99Ag+LK7umcUwaiSFOxrOiTxLUm3nhjdWJl3PAchYTqz+7dIac/8F1aI/Dy1l6iC3gK6s5qerA5AqlwTmZlXPzWMPF2is578cZ2tomn07GbSTHrfnqIQcgbmWkxFkjIr1nfXVGX2PBargWbfB5YkMBR5osSA+u+uK38K5HpeKRCHpcWTnAMYglklTZbwx93gwWGn4g1WUJpzpMqe3CrL/B4idXxUygGGeXtbfa1iPPt65TlJvgbWPaqA36ts+QBBfsVuPzOCBu/TZVsFrOyAN5AVqhOm5oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3nAi/dMRPhRCYlwTGaxSKqti7VmjdHGJT43/sBqBb0=;
 b=Y+7j0YuSJVYyVR6+/nJV1fOXI7c3UXnA1wt6RqJLbg1YxP6BS675vr6+6ft22uuM+FRZ42Fg+xwOt/VgJXVqIekQDMnII8fXpmaLzF+GxyTq9jhtKFFzP9HfzFXKFzOw32L3y11Cc6iyV0CkPXnAub5eywYaj7u011RLWxqeUPY=
Received: from BN9PR03CA0440.namprd03.prod.outlook.com (2603:10b6:408:113::25)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 16:26:33 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::70) by BN9PR03CA0440.outlook.office365.com
 (2603:10b6:408:113::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Wed, 12 Apr 2023 16:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Wed, 12 Apr 2023 16:26:33 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 11:26:31 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 07/12] get absolute offset from doorbell index
Date: Wed, 12 Apr 2023 18:25:31 +0200
Message-ID: <20230412162537.1357-8-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230412162537.1357-1-shashank.sharma@amd.com>
References: <20230412162537.1357-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: c7603ca9-ae93-42f8-4390-08db3b72ae17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZiOT3aYeu3yVvfCjNfMJ11nDeOgHxFcqepGJx3e/J7uS7BJcGOTPwJNQQy7TlXQPCf4Wf0K6iCCMqw+aJXs0hoDwxKXBqyl7pOmkdo7Iw2O3X0Sv4bMardlWTfPCy2s29BmsueTFlRnNi7tLLKdy6K71FHS9ZPYNPdIf/VLIBGY3I3iB+sVT38MVb8nR2rWCjtlZKqvnxO7gCS8wVehfIO/ikuSQznlZTfz0kvcbfkOJ1OK03+qeqx2JKHOZpZDKqezavNwcN3CS6FDo/aBn2H9jRwPu7D7QTL+2YEF2DaaTsrIHRrPiW6Uh5vL2i0ZTXYNBOrRVuCv7sPEfR30Jo2mDRg814ySD+x5CPFnEY+SRVkJj1YR0XOqmI/xa3ggj6/Sji6/T4ifdUPcWaJVxhWs+yNpyCx9QZsy+sLVwZEnKG7eB70F0hSkeGNiNirdmcciwIzd4xJrfNco9rA5e4NO24+FFxopEqXAGx11aRsr2RG/Nk0Pcq5hKSBt8QioljaZueNAGYiAbJhm9qU1rDSQyy3TebhAgi5ff2hOCmsWDS7PvWbwE0zL5ilz1AYeNeXMAHue0eRRwHjljTCTaXmJHEsygcKnhOHEjs8YQHb9PtnowL5p0ee5Y7pUJ3tGtyM9y8mcXMyFCvDZ7j0l246HT83uYPhsjt9qXBkEaE6NeBm4O8lTeP7xm1WFggvkRnHmRiTd0H/IdqxZNFX261ftSECYbMDmr4CKpxngl48=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(336012)(426003)(70206006)(70586007)(47076005)(2616005)(478600001)(7696005)(16526019)(26005)(186003)(54906003)(1076003)(44832011)(2906002)(36756003)(5660300002)(81166007)(356005)(6916009)(82740400003)(4326008)(82310400005)(41300700001)(40460700003)(8936002)(8676002)(316002)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:26:33.5190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7603ca9-ae93-42f8-4390-08db3b72ae17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357
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
Cc: mukul.joshi@amd.com, Shashank Sharma <shashank.sharma@amd.com>,
 arvind.yadav@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds a helper function which converts a doorbell's
relative index in a BO to an absolute doorbell offset in the
doorbell BAR.

V2: No space between the variable name doc (Luben)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  3 +++
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 21 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index fbbff12a14cd..b110e002bad2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -317,6 +317,9 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v);
 int amdgpu_doorbell_init(struct amdgpu_device *adev);
 void amdgpu_doorbell_fini(struct amdgpu_device *adev);
 int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev);
+uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
+				       struct amdgpu_bo *db_bo,
+				       uint32_t doorbell_index);
 
 #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
 #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index 8be2dfa8fa74..a99cd56e8bf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -108,6 +108,27 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
 }
 
+/**
+ * amdgpu_doorbell_index_on_bar - Find doorbell's absolute offset in BAR
+ *
+ * @adev: amdgpu_device pointer
+ * @db_bo: doorbell object's bo
+ * @db_index: doorbell relative index in this doorbell object
+ *
+ * returns doorbell's absolute index in BAR
+ */
+uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
+				       struct amdgpu_bo *db_bo,
+				       uint32_t doorbell_index)
+{
+	int db_bo_offset;
+
+	db_bo_offset = amdgpu_bo_gpu_offset_no_check(db_bo);
+
+	/* doorbell index is 32 bit but doorbell's size is 64-bit, so *2 */
+	return db_bo_offset / sizeof(u32) + doorbell_index * 2;
+}
+
 /**
  * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells for graphics
  *
-- 
2.40.0

