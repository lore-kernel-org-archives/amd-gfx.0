Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0A7EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 03:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFBD810E127;
	Wed,  9 Aug 2023 03:20:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1054810E127
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 03:20:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BERqMH0g5Xyw5q7P29/xYIAVuU6EGPk3mPSkvYnVnF4z/4iz5d2rYruYCVKCUU/nL7xL4qDKd1/64S0AsnVBABezVvAajhgejE9XplU0BQ9xCezx+aJcMPpsGgJ9AIgDhmuj1+vwZkApBjMybltyA8blmaScuu8RnuSUZwNQSX5AVu74yqomZmJGJ2bdx4pAY7xufBRxyFygZFjMG0xDviskdUlEcophungFA/5wdPjbUL8ziq7hSREvwiYj3LrBVK6hiGkbnVhfz+sq1rWgYXIsIOIBw7hzdjxrosHAfwuTe4QrDq+Uj5tErJ6a9xNBEYuee5rl0ra+Z9EgCmrZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDsOYQ78e6IrDsX9HprujTMzRyjIqbEkOzXOTz5sPuA=;
 b=B3qGtt85HOe2f9TVDWMhZ2rhMMYrNVfWmgw6bbN6EGytXRf6Cu6wEQh8AaIaRKD+U6zQd6tz89LIDvQPJCO/EhIV607+59fJwnhot6fJT/tKdXi7VANBwK5tIL6jPtv8h+vEc8pggW2QN/XPeFQAanTisPt4Yb56IccXKZVd+tFvym3amVv/sTBvGLy7CjJEcWKb4hZodbfnNbYXjfQW72ff2jYKpkRVSrxWtKIioehQKAi3hMq8NTHWQoEtXBEOKSFIsZyM6w8w6RTDlHiTGa6YY8xVf0yXUuoHodDPymyK1TyJziNpdivfM/lmXD28gZynl2LkHacGu+kwjEvQhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDsOYQ78e6IrDsX9HprujTMzRyjIqbEkOzXOTz5sPuA=;
 b=y683U8HIwJwAEQ8gFUpeY/Hm5TybTmUP4voCVyVO3o+CBMcaAdxEQIIrQFe7IUv2XW1wqEmVaXd4XAyfo/5kkIMxL/mq/cQO6IKzKkh7Lil2YLHW57c6kQCIr7RrCNhIPMw/BuWR/IohkvVZT6glBSSkzIUO/Iwl3o/wrZGWrQ8=
Received: from CYXPR02CA0088.namprd02.prod.outlook.com (2603:10b6:930:ce::11)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 03:20:54 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::9c) by CYXPR02CA0088.outlook.office365.com
 (2603:10b6:930:ce::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 03:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 03:20:53 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 22:20:52 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable mcbp if parameter zero is set
Date: Wed, 9 Aug 2023 11:20:36 +0800
Message-ID: <20230809032036.533108-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 93302be2-7dbe-43f7-9c74-08db9887a3c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GCY1PKz9MFOImO2KTfI+L8qdTFRM05jmbMfDmuZKegANBWZ7Gl4hGllVL4GmE82g2TSrofpkfuBlIAUpNaA5jYyCLHsnkct85jmXXd9dG02P0F3DvxmLT/y6AELD2K8zlkUUYBU+q3FjRN2vU7KvN9NSKIOn3C27rzqPlKiUuBEtM/YYjiQzP3nIr9ACF49T17lEcUDG+98j8DMknUaXBn512hr1tmriMIAOQSg4FgM2JFEdN9DgC22LkE+OpGReP6w1l6XayC3Aj/5SUgocBHSGwU5hoiLrZCZhvBRmS8insXrJ08jkGqJQ8xnMl8KzaIKrUS3sp/9LZYsd476gmson9TEiNED5IDjvR5/JNnHLWfcCotEsGBUJU+rAkwfFUhjwU9nf3zf4boiC9kgUgAz6xMxzEIFydiUgGHcU3nkaUw6buoU8IXULv3Rrdnc6IljI1Lhr2Ts0tqj/+XPhxLTbZj28kbsSWFhdJuotH6+StG5HuaHafvjGBaqC0zZ9xXzxtJeKOWkHYmx4ludBzzeSBxwa1/W86Z+iuM1nb7OXpAWZKG2DYAIr+iNAMHYiJ2K5zyB7SD5oLvtO48aq/60HQtAsb0GInvdP76efUW3UyNz50RddhGteCJXvxAdqDVdW/MMCKzxJBbRQeUIeAnnQjpS1VBoKhDjQDaJiYrEPsO7GtojsN7PuKuZcOCVYVYsmQXDxsRVvBPDL6HYupmFaK6QX3Lc8ZzJnxXWUZp7R2qNP7I9PAGuvEQ6044u2I2c7Dou3WecyVijkC09CdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(186006)(1800799006)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(2616005)(36756003)(1076003)(26005)(7696005)(6666004)(81166007)(356005)(478600001)(82740400003)(16526019)(336012)(70206006)(70586007)(4326008)(6916009)(316002)(41300700001)(426003)(8936002)(8676002)(5660300002)(40460700003)(2906002)(2876002)(36860700001)(47076005)(83380400001)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 03:20:53.7738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93302be2-7dbe-43f7-9c74-08db9887a3c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452
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
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

The parameter amdgpu_mcbp shall have priority against the default value
calculated from the chip version.
User could disable mcbp by setting the parameter mcbp as zero.

v2: do not trigger preemption in sw ring muxer when mcbp is disabled.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 9 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7314529553f6..615669dcabc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3699,10 +3699,11 @@ static void amdgpu_device_set_mcbp(struct amdgpu_device *adev)
 {
 	if (amdgpu_mcbp == 1)
 		adev->gfx.mcbp = true;
-
-	if ((adev->ip_versions[GC_HWIP][0] >= IP_VERSION(9, 0, 0)) &&
-	    (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 0, 0)) &&
-	    adev->gfx.num_gfx_rings)
+	else if (amdgpu_mcbp == 0)
+		adev->gfx.mcbp = false;
+	else if ((adev->ip_versions[GC_HWIP][0] >= IP_VERSION(9, 0, 0)) &&
+		 (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 0, 0)) &&
+		 adev->gfx.num_gfx_rings)
 		adev->gfx.mcbp = true;
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index b779ee4bbaa7..e1ee1c7117fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -397,7 +397,7 @@ void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring)
 	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
 
 	WARN_ON(!ring->is_sw_ring);
-	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT) {
+	if (adev->gfx.mcbp && ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT) {
 		if (amdgpu_mcbp_scan(mux) > 0)
 			amdgpu_mcbp_trigger_preempt(mux);
 		return;
-- 
2.25.1

