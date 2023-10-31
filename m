Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654A8C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 07:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2D410E409;
	Tue, 31 Oct 2023 07:12:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD71A10E409
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 07:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMYz5y4wLy+xiGm6yTAzwi9hR2wk6ALGqlpdWTlF8OD1EMuf67zsMaC6sejQimRcI7gjotPoM0rnpCxoRzCEEuPJ9RYnpI0tKzVi2+YJB/4gCJpPFEDMkFKu60paIB2j1Cji+LM1D76Nkr9dSxDPZ73QZzAUr8eudOdSyUMcR4Sohk2PCeFpy1Ak5riIMr8fYzRev1cLXCfRnh8BYSr4y/RKwqdYF0M9OqG4f0YFrsj+N1cGLuwrJRVEvRPIhhRDbqBeFnRDPScVfGmWkY+QyWiNPgWXUhNC+jxkH1DkukBeVNfELgkx13l5Vxwn+3pdRdqaZNrC9FefnHERVPNv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRpPEzH4tr8o7mlgzSij5k/ATioaW3DPvcJr9j86aQ0=;
 b=c803179yhxIHqMtD47eX+XDvM/rvJSndgI8QhII2md2Tf7A9HidSGawfxZ49C4SJfB7Rqs/fIqmaBH/YIFLFYyYAO8a2C/DnIM6loj5XXCB5+NtT+HL/WQeFrtMCGqqV+7z3mr8pfnxSPIM//wvGxVVMUGphBYzDvTGTZkvwMPdWtCwLKVbSTN2DmL0HWoxCwTu7o70o15fBParCDm7koi+Aglm10TIBs19r9L9/VtAric10cFylxSdBkQoOyN42YAcTAr/bDj/2AMHpQmiJhrcGdVJ6/67D5ijVckoBa7IWwSM8V3iBsRXov8ZwK++VYyO888zzLtrnJGgcWgG9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRpPEzH4tr8o7mlgzSij5k/ATioaW3DPvcJr9j86aQ0=;
 b=wu0PBFcVdVmB3jPNj3l75KiF2KfHKtPx+ZumACdYlTKideQ0HRTxNFnFd9YQfdKWp7iM5LYAxGSyC86PppjjxMizrebsxCxYv0pd6GnbNK6BVwfNTVFZS/fzkocuEkeSQvD/Vl9zd31/AajytBdwPeWnVnXi9Gzo8ItrGa3g480=
Received: from MW2PR16CA0007.namprd16.prod.outlook.com (2603:10b6:907::20) by
 MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 07:12:42 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:907:0:cafe::5d) by MW2PR16CA0007.outlook.office365.com
 (2603:10b6:907::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Tue, 31 Oct 2023 07:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.0 via Frontend Transport; Tue, 31 Oct 2023 07:12:42 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 02:12:40 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: check recovery status of xgmi hive in
 ras_reset_error_count
Date: Tue, 31 Oct 2023 15:12:31 +0800
Message-ID: <20231031071231.16744-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b4287a-0473-4bc4-3cd2-08dbd9e0c64b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SdvUy9uVb/BDHQgy+of5mjOMx1XT0N2wQyZE7czZiA7GG+1u8kzqKRG0VxHEN1d1MST6A+amYQofqsyUJfiVa+k/lL5ggFuy/GE6zB3U7ydnp0V7HSyqVupsLzdsJbdT+b5EyMb/6/9HnQ+ivvAy8CftTE7W7pnI+USqQiRmmhlQYbLG2ZwWHuwMBUxTyXkAYAXpAhYGzbqlgfdtN+5rTRkm6hRg9xQqs50MqZUZ51HZgRyHNamzTAMcsBFJFu5MPiql+qYD35/zG9Qe8jG4KWKEc+e/nDJZFT04Nq77MX0AZLvVR/Wv5X0RupcpH7cYxXniVVcUziS9v9JucF1TL+2iH9N9VVg8ijabRvlnyqx2HCfna85EqcD0ANPPOUyCzdXNzE1brjvBYdFpSDPbH0UE2XK60+ro0fWFsw8sYNJob42osRklE+U52nsUQ303Wkjr+76D9NhTOKZWIdHgCZNO4Tj3eS97yokKTrMtgX5OexhfZyd3wUdeH2mUUN9mqvABExiRO6dCD5UMt6yNc9s1yFrzdZK1djVIr6oBwsXFs2N2wTv+kKEfbeyw4VPB3a1Hp9hp4gS1SKzb1fsuTNEAMuPi69YVpXenxI+iXt2pUIxrFzsvp/fl8paXIpMJHKwp2fxG2o/9GFtTj+2XbM8SHamQ1EQ6DAWllhsO6s1JI3rgL8m0Vz6u+JjRfqxoVEucp2ZiVyZ//TZdLrlQRGAqFIrXg61tN+53CX332xp115I6iCmTO0GU6qmgMEXMS8/RtpMpCCZsIyzqaq2fpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(478600001)(7696005)(70206006)(70586007)(6666004)(16526019)(336012)(426003)(26005)(1076003)(86362001)(41300700001)(2616005)(2906002)(8676002)(6916009)(5660300002)(54906003)(4326008)(8936002)(316002)(82740400003)(36756003)(83380400001)(36860700001)(47076005)(356005)(81166007)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 07:12:42.4372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b4287a-0473-4bc4-3cd2-08dbd9e0c64b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Handle xgmi hive case.

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 753260745554..0093c28f4343 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1226,6 +1226,8 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
+	struct amdgpu_hive_info *hive;
+	int hive_ras_recovery = 0;
 
 	if (!block_obj || !block_obj->hw_ops) {
 		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
@@ -1237,8 +1239,15 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 	    !amdgpu_ras_get_mca_debug_mode(adev))
 		return -EOPNOTSUPP;
 
+	hive = amdgpu_get_xgmi_hive(adev);
+	if (hive) {
+		hive_ras_recovery = atomic_read(&hive->ras_recovery);
+		amdgpu_put_xgmi_hive(hive);
+	}
+
 	/* skip ras error reset in gpu reset */
-	if ((amdgpu_in_reset(adev) || atomic_read(&ras->in_recovery)) &&
+	if ((amdgpu_in_reset(adev) || atomic_read(&ras->in_recovery) ||
+	    hive_ras_recovery) &&
 	    mca_funcs && mca_funcs->mca_set_debug_mode)
 		return -EOPNOTSUPP;
 
-- 
2.35.1

