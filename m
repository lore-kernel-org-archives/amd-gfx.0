Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D639C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065AA61262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 065AA61262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984B26E8E1;
	Tue, 28 Sep 2021 16:46:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F0096E8E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:45:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAyNEqXpoZzEIDhoL+j/eWKU/f/K6/mQIZu5ymShK7m7PMIy/UKNkiuzcFYDodTpvLrDOm77i77VefckUVh6O5oH1UsrDgklMkxCjHLeKMrnCb8H49xmbqMW91WFPEPcm1lCwoNa3f60HPgKWl+pO1eVOeAuNGfGDIhzXNNGWRzzPEUUw6kRtJmxn8MuqsXEewfB+r/5D9IbAld2X4K/swcrHeQnxjqYY1bq5Bod46q79lAU5NyfdHJSI92MjeT/KGz8ED3AGCTTgD7r+tLz6uqFOqLY9E+sO0PfYB2U9tAurq//TvrsdpZlxPBU80EskGhKq8Uakqfn7e0d6OOKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=SRuP9YC/o6ojUb8XVRaCNi9p00OEiPhNanm7S6xOMZ0=;
 b=DMGWOdB40VutKmYySsTdzO8/LpH+NJ/BcVYOTLjiV5m2UR3RvrF53UdB+cIwSCVT4dyonK2nbpat3lhUrwIGPItXGxaTTUZ3CXjlPoxIbJ7UhMEdcb5luX+3vDenRzRBt3QudgaR+pWRWyVJrIkegVM/EW8NnJaiUJA1KOtDQfqWc3VI7/2/Zq22u6qS4NEOPf8VzcPrCpilqbW8YPBKSQK6U35HRfo3/3nYF0KZWVvLGHLcq0hhAeXRimUfseiuzy8PIlFcbRWlbqaMijJL0HABoP4t9EpsBuYVjXmrLGyx6lyDWrbPcxj2eXu8NR4s+Ln1MacwvS9PfLqJzPceng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRuP9YC/o6ojUb8XVRaCNi9p00OEiPhNanm7S6xOMZ0=;
 b=wQhOQGUuRf9NfNEnTVVZXNhsvJaHWXonwajiE8JfCfKIXycTYCfEnpPWkggNUjtm7juVx0hAfMYk1e1SrwqLFxCh20UuSIXX+7qdslXygiK5c7SU/DeJWt57/N3gj0mtSbmw53I4+Yeh5cjAMpq6C1xePBP7E3Ku95ZK7JLUsh4=
Received: from DM5PR07CA0046.namprd07.prod.outlook.com (2603:10b6:3:16::32) by
 BL0PR12MB5521.namprd12.prod.outlook.com (2603:10b6:208:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 28 Sep
 2021 16:45:57 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::a7) by DM5PR07CA0046.outlook.office365.com
 (2603:10b6:3:16::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:45:57 +0000
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
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:45:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:45:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Guchun Chen <guchun.chen@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 49/64] drm/amd/display: fix error case handling
Date: Tue, 28 Sep 2021 12:42:22 -0400
Message-ID: <20210928164237.833132-50-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3e747a9-a5e5-4e1c-2218-08d9829f71ef
X-MS-TrafficTypeDiagnostic: BL0PR12MB5521:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5521C770414CC53AC6BEC4C6F7A89@BL0PR12MB5521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:350;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ScDOyYzrBdFSZd1eEbkSpoRphyYCbNXs6wOKNa8xGda/xfI2FauLS2nkf/61Kg9Rp1hntrtly1TrQiSip23LMU4l1pXYX0bYPKLvlCAY44JfYIDQwKgPkByQ3BHaLmRT6y6a6BsYy9ur8I04mXOhB1A8FuPvXsHBDfmWwFVat+o4fwyYrGVyWckPwXTPrS8y+dfEpve5pwAKg3X9zR/ldsvu+68kMAQ8KY6LuuaM8wXfC0EbcR7Q4D8QTE7yc3m1lJyuffl6S+YYegGMS2+sPnADd+g13Kbh6m6hm4049SP1r3CRADd9aeUB7KjUiBiDhsD2wYZluUxW5dBG35a2fhwr2O/+ml4egrwfoTe99X9sLZNc3SSm9fOtLcOqhpMBR8XgDZ2WUwzALcm6witILAUH3Qj/MRvgpzcxoIUq0Tn1yBH7Byx6YtFqilfnpFmXfcIZOa+7HAnxEu1fi/4/Ff5UTQKPm8hH6y2WsdjMn9iq5JkceDo/6/ox/nJBdXVVqSJFasrmka3gjY8cSlfM6A4sx6ywqQnWynpQL8YRml7z1rL8W5Sw2XWLJ6j1lsxMPI71P83cGVZvn+oBA5V5sSEvaSZ/XsNm/KzgL4DY5VmK4+B4DZQ24E9KdWDujLHvDNKJjOaiojTBVDXV+W2SRjcC5rRdBm37H3eEWXGp2MAEGHGYQgRLBq5tj13/S2DC2Yi5RJiJBEhVArVryjT7g4CiJKNK1yjOigjJHKuvf24=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(82310400003)(36860700001)(47076005)(7696005)(54906003)(6666004)(5660300002)(16526019)(426003)(186003)(2616005)(26005)(336012)(508600001)(6916009)(8676002)(1076003)(4326008)(8936002)(83380400001)(316002)(70586007)(70206006)(2906002)(36756003)(86362001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:45:57.1684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e747a9-a5e5-4e1c-2218-08d9829f71ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5521
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

From: Guchun Chen <guchun.chen@amd.com>

Otherwise, we will run into error case path.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4cada9df5f9e..c34dc30a6789 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4206,11 +4206,11 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 			}
 			break;
 		default:
-			break;
+			DRM_ERROR("Unsupported DCE IP versions: 0x%X\n",
+					adev->ip_versions[DCE_HWIP]);
+			goto fail;
 		}
 #endif
-		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
-		goto fail;
 	}
 
 	return 0;
@@ -4388,11 +4388,11 @@ static int dm_early_init(void *handle)
 			adev->mode_info.num_dig = 4;
 			break;
 		default:
-			break;
+			DRM_ERROR("Unsupported DCE IP versions: 0x%x\n",
+					adev->ip_versions[DCE_HWIP]);
+			return -EINVAL;
 		}
 #endif
-		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
-		return -EINVAL;
 	}
 
 	amdgpu_dm_set_irq_funcs(adev);
-- 
2.31.1

