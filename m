Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603F0C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 03:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E55056EB93;
	Fri,  3 Dec 2021 03:06:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 178096EB93
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 03:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEFnJ8wVMD8XW3coCROKEwZ41OspUNqdNCcQV92jDb3toCO4b157/HTY8dcqa/Ifhc6FUyVMSvqJBsQVBx9aj/edHJrEkiy92RtFihwicittusvtA9WiHFbfQGO7URIkX2uEdkmq5pqW2MNZ9JglMtSZuioK7IKBhzrK9W2x6GCwhoKUkhmBFWgEl+YuXRPICFddMoOocuVSG0hurkVyAr27zRX1jVOahXqh890KoCJXRTMeGYK4kM/Z0Nrrxid+1M5AM9vVO/CPxBBEgi1i9xBt8t/CNmDQga0rNI+hvxZXvStR5C4SJ3Bl9gLPceab5QP7wBecmdMve6FCm+LpnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jT94wBRiPimh3kOJ0YOA4PmwesGerAx5w4JKBVp4fUA=;
 b=LuwY+cNA4qFYpYFDsIK+BbjVHNoY9NKR2DFfwIfKRBTgMTuEFTFVw1zPDFR9x7lM5y1qHaWSSm4yTlXV+zj3Lh+6dJYN0L+WMiWydcdJ2uTH5ZdJeALxi97zNouJmrfl4W0t+Dkku9vU2zotarMUZ0U97qxJyOQI+rYJD4hs5U5pNsFjzVd1ht2kG+e2UU75UVpqfcCuF7M3CHR0hA6S/ErGfAisi0wk67UaCxRMqSlnS3QwbwJE4m2GjDO2SIfUsQnP8qAeHajDoyg+Wch/+14WwN8de2lTImFWhc3Yvy8k4qrc0Hhi7SCOtzddCLsrZ9G5qQO0G71Ku4OF+jKvKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jT94wBRiPimh3kOJ0YOA4PmwesGerAx5w4JKBVp4fUA=;
 b=GGnkhYGd3gv/YJOMP9AFbA7thS2RKP7PydEUvs6ycY9UULsiN7CBrbFUY2LZVDQ7lYs5l5U2wTkhl1ypQpVioMlMmFiJ0bKJ1uUltqO4Q2Euzhyv7cTd4+CVujYSAg4bLfkKeznrEwtoO4a9C1W3ghO8xd4pCAebgd5M4eZMexQ=
Received: from MWHPR20CA0005.namprd20.prod.outlook.com (2603:10b6:300:13d::15)
 by BN6PR1201MB0081.namprd12.prod.outlook.com (2603:10b6:405:4f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Fri, 3 Dec
 2021 03:06:17 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::48) by MWHPR20CA0005.outlook.office365.com
 (2603:10b6:300:13d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 03:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 03:06:16 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 21:06:14 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V4 08/17] drm/amd/pm: move pp_force_state_enabled member to
 amdgpu_pm structure
Date: Fri, 3 Dec 2021 11:05:31 +0800
Message-ID: <20211203030540.1710564-8-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211203030540.1710564-1-evan.quan@amd.com>
References: <20211203030540.1710564-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abd454a9-10e7-4632-afbf-08d9b609df5d
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0081:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00811D7351E528347807E6FCE46A9@BN6PR1201MB0081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 91TiFw6yo6VxzLVF74AFj39ALggqul9jyTSIBVekTZGBGO4frHSSYAF0CBYfe4J+Mu8uLXrHMEQzS2CGPieKwhxSmIOPz2ddafJ2ifFbFKcBTfSV967/9JW1PQlOJwodDQVUh3VE8ygoEJhtuP/R6gywHNkKGt2UVOzGAo68TQf2oezrsyHi37XhGentKSw9CRqmroFvDGo0FozX7Wos2XT1VJpkvmLxsm/1FZ9nJOX64AniDy1CRXJeZctNeOPgJpv3ZSmxmX/AeOgNYQ82/usBpmpCm8oyTM2xJZN2kO2PZXfpeP8i0rr+tZOFp4s/eyfpO3Fj4SHlCGCZG0/nD0CZN2CbaMHJJXn91SLQ4ubL8J/kAAVY7e94PYN7tpqJ0ICuXOOkZrYBQyTpUP5JRy26xvslfWxbFikpdKZdL1/FqYoroSq8x6alFZBPcsi5faX/IPMFe8bpEppZOq0jX2pzptu0H0vOU9RlQUZqGrcg2PRrwlQDKiMC4XzvKwSRp45ms5/8HV+F8jsQ3ZRk5BcP/YD0tdRoZtIRWNCpLXAZEXG4ap+L8wSIjtHhA+mNBFVpgBr0KE++99KEq5TlwsEEt3HAtYDpIc3nLwDRHeseA4DjXWqNeNpNxU72l8xm5HX/30P1zNq9G62XVFRZzAvXKqT7Wn6k97xG+g4Liomq0B26JY3x/WWLBRqR3NqxhnijLA4EtPPXnMFtyqZo0iBwbs9a+aH3dziacyO1UtMyo68YQbDcffcWMY5dl4NQ0XE35tjUKv/oLqlukYJ566nNs1k/hWd9eC1EQCX++x4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(81166007)(7696005)(47076005)(54906003)(40460700001)(5660300002)(86362001)(44832011)(1076003)(70586007)(6666004)(36756003)(6916009)(186003)(8936002)(8676002)(16526019)(508600001)(26005)(2906002)(4326008)(82310400004)(336012)(426003)(316002)(36860700001)(83380400001)(70206006)(2616005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 03:06:16.6463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abd454a9-10e7-4632-afbf-08d9b609df5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0081
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As it lables an internal pm state and amdgpu_pm structure is the more
proper place than amdgpu_device structure for it.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I7890e8fe7af2ecd8591d30442340deb8773bacc3
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 -
 drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 6 +++---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 2 ++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c5cfe2926ca1..c987813a4996 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -950,7 +950,6 @@ struct amdgpu_device {
 
 	/* powerplay */
 	struct amd_powerplay		powerplay;
-	bool				pp_force_state_enabled;
 
 	/* smu */
 	struct smu_context		smu;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 3382d30b5d90..fa2f4e11e94e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -469,7 +469,7 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	if (adev->pp_force_state_enabled)
+	if (adev->pm.pp_force_state_enabled)
 		return amdgpu_get_pp_cur_state(dev, attr, buf);
 	else
 		return sysfs_emit(buf, "\n");
@@ -492,7 +492,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	adev->pp_force_state_enabled = false;
+	adev->pm.pp_force_state_enabled = false;
 
 	if (strlen(buf) == 1)
 		return count;
@@ -523,7 +523,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 		if (ret)
 			goto err_out;
 
-		adev->pp_force_state_enabled = true;
+		adev->pm.pp_force_state_enabled = true;
 	}
 
 	pm_runtime_mark_last_busy(ddev->dev);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 89caece4ab3e..b7841a989d59 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -335,6 +335,8 @@ struct amdgpu_pm {
 	struct list_head	pm_attr_list;
 
 	atomic_t		pwr_state[AMD_IP_BLOCK_TYPE_NUM];
+
+	bool			pp_force_state_enabled;
 };
 
 #define R600_SSTU_DFLT                               0
-- 
2.29.0

