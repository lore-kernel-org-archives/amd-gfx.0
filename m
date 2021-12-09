Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308B7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 17:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76EDC10E190;
	Thu,  9 Dec 2021 17:02:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2283B10E364
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 17:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vp+xIxgofkbBHfVzKfi8DzfoDSlR0VupoCuYezKElsTigyqve8sXf7mDx8x7d55ZyGwKb/t+wqMcy8P2DV45S3mqAys8PukOoZCcp6BFXTGvARHzatu3YH/+gPSwVoqGFlbge3IDpx86FWd4cW5KJUPAC7wUCZ2qubIAImUgkYCzkN3Lvv3UJI/aSfMn7+70qVx4r1xzjq7JKCDewCjj+qE7/BiQCOFzhrQQ3aClq3/2nmiPPETMqXzY0SVBezxeytiKRaRc4RDFdfIiHCo1Hyg/pIAlAcqo8PiXZisrT2cM3T7kzTf7eOQJ9tLFIKEmq+fVhWa6J84ijIoOx6zUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kUX1Ptb7k8stGeefeakEtxqTcOfz6DKyAt3gmnlfno=;
 b=W4ZUsJJszMtxsVga74S0oFH49IMAWkwL/ztg7kNSXL+5srCaybNh/QoKLRHotMP7ct3xrFv9cd2NCGmgvrgLt0DlFJHVQ12rVrwPyA+fBxTuBrgGmJFy1Su0vTDVC4L7XDnsZ2yKqhbsVZe1ifnyZ5VyDKuaGSiBPf7FryImgf0kkFgwTy5IXQmzD/I2zg0x3nlW75IAG+YKFNXPLkZotN7kKQ6IlSJ9DvEltCX65Q89oICc0ui75TGxYDCuzK/5kS/Iqje4aAOPKoZGna9ObqjtlwG5+hhoAg0qFzZ38zlcBbUGuT1IxNcA2pHqQJiwTvUG9zm+2yPJbNDpeGa8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kUX1Ptb7k8stGeefeakEtxqTcOfz6DKyAt3gmnlfno=;
 b=WTs0JX6TZE38Spsk78KOnQ1EEKbYp4UKpW8MdTKw/BxsFLAcjvprg2TNVQ6qXzUqg3RNq3DJ4TFFcZgoyEjdfJ3r9o6aehWp0wJ1V7DXwNBvJrRJ+6EFy+sDhw7meTqUKNEx3mK5WBpLYdd8i9YCL+Jbk5v8A4UwEstfbnwKrUQ=
Received: from BN0PR04CA0022.namprd04.prod.outlook.com (2603:10b6:408:ee::27)
 by DM6PR12MB4633.namprd12.prod.outlook.com (2603:10b6:5:16f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Thu, 9 Dec
 2021 17:02:27 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::f5) by BN0PR04CA0022.outlook.office365.com
 (2603:10b6:408:ee::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Thu, 9 Dec 2021 17:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 17:02:27 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 9 Dec
 2021 11:02:26 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: SRIOV flr_work should use down_write
Date: Thu, 9 Dec 2021 17:02:11 +0000
Message-ID: <20211209170211.506360-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44665ae4-2e5a-41b8-566e-08d9bb35ae08
X-MS-TrafficTypeDiagnostic: DM6PR12MB4633:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB463396364C3FC98BC4260FBC8B709@DM6PR12MB4633.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TkcZU9ykmSgSM2yRzuf7lALi8XtlepVtTbAI+NNAp3uWXjulnNz5dXk2m3xU+pMqbcYgIlZmeeFG1LzUt/+MO27EzAx+AwtE84Ax67ndbD6jOoZ98gF2X42UKEYaBpv7+ujtV3sVbhBMX+TairwbieeqAawOwH2noQxPkK7eeHKtpxBr1g3NOkkRmiEHHOktyK6909pGg6kFXw6Iub8TdF/po844ycbQ5epk7rZhYT1C1gP3DcRc5Xn3kQLLhUh5iKMOFZvA+T943frC4r7nEkuZaGu6/R/MUqixWbDSE+09th5bloHyldDx4Cd5oK15jmn1PMtXW01Ox2SPdz3m8WHD9MEFsSMx3wWLft6h8cisrkTrrMLG5QsJaW2kFg6IH1udWVWPlwjvINkqo9QFWpYbqSaYraYoD7TuF3Pwf0kGWRDe1qk5Ys7PoQaNR6M3WunXsZWuIQoWjDlXo0gs8mJmKFoLrLicQp0vujgXzKFvJNVP0PGiz0NuTXz+dYYzGB8QyvcY4RxszSSNux2HZykj4qEgCCTAzS+PEyXAQTlPmj/UDNXQTbHDvmXqxjbT3D1u197G/3lpv+Z/4l7zA3KLzEe4EOfrXoXzxYp70MW4eqvxDL+yq0P/LOhzOH3IMYLrcAoZVN3Y3QnFkqm4qmdoXrH2VRSRRLL7JLeOOgbOmIQwsRyQ9kZOerXUSOo83iKxpP4EYWhfvTTZHBVbPqp4DUEzCgXj+ytCnwb0/cYdY5zBjBU3p6/ApYCVssiKRm0rQ3WUcbkCLoyZAimpuukegEIhr3dSE3I12tLq5Hc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(6666004)(26005)(4326008)(6916009)(16526019)(7696005)(1076003)(82310400004)(2906002)(426003)(316002)(508600001)(2616005)(70206006)(336012)(70586007)(40460700001)(36756003)(8936002)(186003)(44832011)(356005)(81166007)(36860700001)(5660300002)(83380400001)(47076005)(8676002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 17:02:27.6297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44665ae4-2e5a-41b8-566e-08d9bb35ae08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4633
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
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Host initiated VF FLR may fail if someone else
is already holding a read_lock. Change from
down_write_trylock to down_write to guarantee
the reset goes through.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index cd2719bc0139..e4365c97adaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -252,11 +252,12 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	 * otherwise the mailbox msg will be ruined/reseted by
 	 * the VF FLR.
 	 */
-	if (!down_write_trylock(&adev->reset_sem))
+	if (atomic_cmpxchg(&adev->in_gpu_reset, 0, 1) != 0)
 		return;
 
+	down_write(&adev->reset_sem);
+
 	amdgpu_virt_fini_vf2pf_work_item(adev);
-	atomic_set(&adev->in_gpu_reset, 1);
 
 	xgpu_ai_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 2bc93808469a..1cde70c72e54 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -281,11 +281,12 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	 * otherwise the mailbox msg will be ruined/reseted by
 	 * the VF FLR.
 	 */
-	if (!down_write_trylock(&adev->reset_sem))
+	if (atomic_cmpxchg(&adev->in_gpu_reset, 0, 1) != 0)
 		return;
 
+	down_write(&adev->reset_sem);
+
 	amdgpu_virt_fini_vf2pf_work_item(adev);
-	atomic_set(&adev->in_gpu_reset, 1);
 
 	xgpu_nv_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
 
-- 
2.25.1

