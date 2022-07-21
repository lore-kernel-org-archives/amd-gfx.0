Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93659C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 09:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A0822BCF6;
	Thu, 21 Jul 2022 09:52:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C168BE45
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 09:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XL2NlALnsLc9GE7WpnBXo+05AVy3bn9zYAxZoSKts/R7NaNx4ua+8o3VFu9nDIBuFYv9Lyc7C/5sTZjlhqzidHOghQ0jhll2p0K2xKx/jSMIbw7FZgbX/4um4WlPhiNLhySWqzIO5oF5j9l85tDBZnJkqInhrMxZzU2CREE5SEFYMCDghq11JdZNZKsNnth3uk45+bHHMariOINnFeUlItS8tK18pKK08qiWcFKY9CKjArE8NU86qcnmfK0EPvxiiKTA44I1IY1Y+vQjv/C74jvX061wlnMbxJPxRUG/8ilBNw9xlk4U6YzOgzhDqn0beya0xwlZIh1vBVC/O1vy1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBE22+QNnWHDpBuZg+FiTtjvQ6AklxdFe+itTFfxkko=;
 b=oUYK+9sIKba7OUCSaw1LakbJ4PSq30O6eWMg+DK0MfZZeAM+WDnhogegCT6U7VWMaDcBtXAC/ORCXemITXaxwNC+SqUgr2sOBlVVuYsRaCUuVbfX9aOIlAA4+XEn8xQBo9vMikkd/HMPTAu/e8/M8+r9hcX4V48u3xTOpu1PVlaj724pEtoZh9KqUn3DotjQ0TbGPXbbuTQGAZev3OyXuTv7Bs/XyijPImFsr1OUdKIrkGqmduvTIDcqClp1RACuyywwaSMyw6UqSSpMuqSX3Ukp15RupkisOYPzSr1KsP2n2oZxGrxfJu+tWjsurQObWCtj8mwt92HbSNpr4+PjhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBE22+QNnWHDpBuZg+FiTtjvQ6AklxdFe+itTFfxkko=;
 b=xL6/jHcEFfBkCRPHk1jn69CwAVKtY0fBzj/Wc1Fe/Zh6RkrMQDWN9w8RuI0ciTwyO77RKv8nFNm6PdF96YtFu0wcvJp+nTxkuywcw1I+oEv6/u+2ItQQfsvTs/NflYS1k54Upzl5lAMTx4gb/25MrU2m2hLeGpBCKhKYu3PpT/g=
Received: from MW4PR03CA0104.namprd03.prod.outlook.com (2603:10b6:303:b7::19)
 by DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 09:52:36 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::83) by MW4PR03CA0104.outlook.office365.com
 (2603:10b6:303:b7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20 via Frontend
 Transport; Thu, 21 Jul 2022 09:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 09:52:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 04:52:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 04:52:34 -0500
Received: from horace-sm-debug2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Thu, 21 Jul 2022 04:52:31 -0500
From: Horace Chen <horace.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amdgpu: refine virtualization psp fw skip check
Date: Thu, 21 Jul 2022 17:52:09 +0800
Message-ID: <20220721095210.37519-5-horace.chen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721095210.37519-1-horace.chen@amd.com>
References: <20220721095210.37519-1-horace.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 778fe69e-6ac8-4577-99b3-08da6afebdcd
X-MS-TrafficTypeDiagnostic: DS0PR12MB6558:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hAQjmD4ck3wYUCwMOaYSArIHOYT1vD5GmpcWAPu5gA7EJO0NfDEu9GQjciXDI63G5BXUymQdZXdgurXQYPj9hfB/zW4SvMcnj5i5x7vIO4yqixbdVeH3SK7JaUR5OXu0JwxZ71P4vCINQNMa8A7j037zna9rT0HDLC9wBGdMOpL2q1/3ixjvsZ7LCimeHNKguhEKSUflDSXYA64Z4w8trqJXOujos3R4UGPbkMWE8PLkYAEg+Xq9jfq/6DsA27LfCeAKhegT0hipP6F/HjwwRfExbFJH/l9T0caF0FizWzO28Udz5udvr+WKiBxUZyCEk79IuXhGs/CecRWz7zzues12ALd+MSuACaO7DyNo4LEcq3tmevS8c0oLsT40XHp9yLr6EvGKEiqyxEuHz6W6lNLxvIrNTy1N8dSXaD7xhJQ6o9siGN3+DIkjNu3UMlLk+IkvT/VY6plsTEqJvzMUcxgL2k99++kamxPeNJxXKx6P/P9wypxZbjzU39IrYEsufG3OljGLQ+quRAjvOyC1+6y3Es1/++hGaFOzSm8VQceklue0M8IfD8DIaN8wNrkwuabV6rSJ2F6mZRWHM1pyGmoYOTam0Hd1qDsT1mxfUTu4d3QsBgXTPrsB4B/EjFIYqrpLkwPdZDBc01LdynFaqrVlVdccn25Wr2xq97Fi0yNhQLIC75/tkK3RPMR80lmPoYrZQsrs95tYdTrHxqrvmdEiukNNbG/BNzK/faiw+GTLhf2v1uuhOIk/e0qOjvS+SOXurS0ySBn5kjcBv9b6Xc32AeCCvNR6WKa1MAUkiKUNTMH/tW2iOiT6anbSepzOwbGyCZKHDTcfrSfsI5/HwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966006)(40470700004)(36840700001)(81166007)(82740400003)(40480700001)(356005)(426003)(36860700001)(47076005)(83380400001)(70206006)(8676002)(4326008)(70586007)(316002)(36756003)(54906003)(6916009)(478600001)(82310400005)(6666004)(26005)(7696005)(5660300002)(86362001)(2906002)(40460700003)(41300700001)(336012)(2616005)(44832011)(186003)(1076003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 09:52:36.3077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 778fe69e-6ac8-4577-99b3-08da6afebdcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SR-IOV may need to load different firmwares for different ASIC inside
VF.
So create a new function in amdgpu_virt to check whether FW load needs
to be skipped.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 17 +++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 29 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  2 ++
 3 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6540582ecbf8..a601d0f67b1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -334,11 +334,12 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 		ret = psp_init_cap_microcode(psp, "aldebaran");
 		ret &= psp_init_ta_microcode(psp, "aldebaran");
 		break;
+	case IP_VERSION(13, 0, 0):
+		break;
 	default:
 		BUG();
 		break;
 	}
-
 	return ret;
 }
 
@@ -2389,19 +2390,7 @@ static bool fw_load_skip_check(struct psp_context *psp,
 		return true;
 
 	if (amdgpu_sriov_vf(psp->adev) &&
-	   (ucode->ucode_id == AMDGPU_UCODE_ID_SDMA0
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA1
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA2
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA3
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA4
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA5
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA6
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA7
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_G
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_SMC))
+	    amdgpu_virt_fw_load_skip_check(psp->adev, ucode->ucode_id))
 		/*skip ucode loading in SRIOV VF */
 		return true;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index ab55602ff534..ba367799d087 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -807,6 +807,35 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
 	return mode;
 }
 
+bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t ucode_id)
+{
+	/* this version doesn't support sriov autoload */
+	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 0)) {
+		if (ucode_id == AMDGPU_UCODE_ID_VCN1 ||
+		    ucode_id == AMDGPU_UCODE_ID_VCN)
+			return false;
+		else
+			return true;
+	}
+
+	if (ucode_id == AMDGPU_UCODE_ID_SDMA0
+	    || ucode_id == AMDGPU_UCODE_ID_SDMA1
+	    || ucode_id == AMDGPU_UCODE_ID_SDMA2
+	    || ucode_id == AMDGPU_UCODE_ID_SDMA3
+	    || ucode_id == AMDGPU_UCODE_ID_SDMA4
+	    || ucode_id == AMDGPU_UCODE_ID_SDMA5
+	    || ucode_id == AMDGPU_UCODE_ID_SDMA6
+	    || ucode_id == AMDGPU_UCODE_ID_SDMA7
+	    || ucode_id == AMDGPU_UCODE_ID_RLC_G
+	    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL
+	    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM
+	    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM
+	    || ucode_id == AMDGPU_UCODE_ID_SMC)
+		return true;
+
+	return false;
+}
+
 void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
 			struct amdgpu_video_codec_info *encode, uint32_t encode_array_size,
 			struct amdgpu_video_codec_info *decode, uint32_t decode_array_size)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 239f232f9c02..cd6fce05978f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -343,4 +343,6 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 		       u32 acc_flags, u32 hwip);
 u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 		      u32 offset, u32 acc_flags, u32 hwip);
+bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev,
+			uint32_t ucode_id);
 #endif
-- 
2.25.1

