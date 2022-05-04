Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757D3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 14:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBD1710EC55;
	Wed,  4 May 2022 14:40:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A97BE10EC3B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 14:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLEuwzf+1qWXj0AAisrAamCXhYQ49t1RhyLJ8blQEyNeWAF7htJtlsD5Hp5OZFhKs3iAaVdHeph4j1ZPlerErM+1D7tsPscXcKVk8H/us0de50CrEPOYR3stEdd9eEUYi9KaNJb2KXS61dAYmiuz5SaziAMNeb+//wl0dakJsNfBMSVLB5qaiYPxvgPtvIWtnM+2p6+FeIW2yChbwGtq3B1XpktqEl3j+qZCWP4qTaS98emauXnX82clCuJC961eZWYsEDzK0q1RexD1W6ZxDH6j0aps3d9CaG3hGs2wicgM1iz2CJTBwMgJRoDSPcbL3laOzIlHUARKO9+6/aP+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYJAG/jHjiqsmNkooSe1nEvfKw9yjjPTWGrcRW07x4E=;
 b=NBuPyOy7u6W26GQ3wkvfFgDXSGl/KD3Fz6OiT62jNOXUtWKphD1+/xK2HQWpLnn3DbZx1O0JDHgU9bXImwr+91i1+7wIdVJDqhUeLWw1dx8EhVwbVdFmKV5rOM4qedxc1EIZF7054SiEwlx/Oh6YVZL9k/1CM8lOEUEjOoQm4UGR0/glwl5lvRs5manUDVNgs6NYsz+TC/lJoGGHtIuPXnx/iXzaZtP6xEZDZvLQcLR1EasCDLWDa0MoWYTZaYGc1cnJmEYwnFzKwF2vxdIq7KZNzg2/iNWdAOS2M/oLYQngAhgrdUmg4tlEMtOGS9tMFa0eL0jE1Uzz63RXAt8R4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYJAG/jHjiqsmNkooSe1nEvfKw9yjjPTWGrcRW07x4E=;
 b=xiwUZGT1cGiS5t4mNHgfHq9g9ma9PpuqYK8UjEabNjHcyObE3VZZpn5sgmzMdy7VNb34iVzjt+Ag4aQPdLXKibcot+KDPNqqExYdIu+PaEgydHkOpdraVAMLu2g1NQQDVDV+b/sD+mlfWpgHPGaxbim2HbTQjW6b2ew6GSs6/BA=
Received: from DS7PR05CA0059.namprd05.prod.outlook.com (2603:10b6:8:2f::32) by
 CY4PR12MB1157.namprd12.prod.outlook.com (2603:10b6:903:3b::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Wed, 4 May 2022 14:40:33 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::9) by DS7PR05CA0059.outlook.office365.com
 (2603:10b6:8:2f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.6 via Frontend
 Transport; Wed, 4 May 2022 14:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 14:40:33 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 4 May 2022 09:40:32 -0500
From: Alice Wong <shiwei.wong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/psp: Return failure when firmware failed to load
 in SRIOV
Date: Wed, 4 May 2022 10:40:09 -0400
Message-ID: <20220504144009.2052312-1-shiwei.wong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0575e7d-e217-4e0c-752f-08da2ddc0b77
X-MS-TrafficTypeDiagnostic: CY4PR12MB1157:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB115735AD7A2B00743B8C8DB7EBC39@CY4PR12MB1157.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FM9eq78GnCmQ1nxtuqnKBN3kl0h5rWZLDle28ZZTPcMWsb0gP5ZPnOxvhMjnOqTS8Z6pIdfuBiuR57/x3uwy+qUo69Nn6XtUcmWDChODAnstP2yoHSYjvUhLlBUkpEpUWX4lbq+Hi4yIS9KcPCtafGMLzEzBua/GMx1VpJTkUjkBVM0D4JlnZqKJfAhQvlw99Cgkl0U74RRi+jIYHpLWzfkdsV4/p3z1naLJNAOhlfwX2Yyf5RYSj2fqed5AByL1iW5IgxcKT/K1AtbuSjCdY/v3AXKwBG8vUo46vDnMWk7GSuWA/CtFRXk7HeuD7cFm4xXX/tKHcMadELQgD/PSo4m3/EnG56cqcMkjuzd034n3CkbKgsYbSJrmZhftzAgHegzAWfpKkFMLeKTQMhdUzfk2nvC/iQhkaDHdcUXAz4U2Sezo9AfLbZCxc7rTFrgjHeAb4RnarTwriCDGPmRGPOJsNAR+QyKoaVUumjwyqrG38h5xbgWP71hxtvWpnLwTXO7dpFZlfYVYYRV7zsvohSaQavMSuMAeS358no0kUsASr8eiZbtRmGfRgk5hY6JkwFwcj6qw+C0pXuGcedvR5APouf8XSp4oHwbcunNTop2I1/6120PvEC9EG8r7k4JR3LDqiDTklUc40pQiO4X6WvkB2ev5XcxqYtY6LOcrUpKXmAo1FFUEzWMDvn9s3YXXxCb79PtvglKc6tpuHfK0mA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(5660300002)(7696005)(82310400005)(4326008)(70206006)(70586007)(8676002)(8936002)(6666004)(81166007)(356005)(2906002)(316002)(1076003)(6916009)(26005)(2616005)(83380400001)(36756003)(40460700003)(16526019)(186003)(86362001)(336012)(426003)(47076005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 14:40:33.3686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0575e7d-e217-4e0c-752f-08da2ddc0b77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1157
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
Cc: Alice Wong <shiwei.wong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV, PSP will block incompatible firmware from loading. When this
happens, driver should be prevented from continue initialization and
start cleanup. Return failure in psp_cmd_submit_buf when firmware load
failed in SRIOV.

Signed-off-by: Alice Wong <shiwei.wong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7f9ab12ae1ab..7859d70af596 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -626,10 +626,11 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		DRM_WARN("psp gfx command %s(0x%X) failed and response status is (0x%X)\n",
 			 psp_gfx_cmd_name(psp->cmd_buf_mem->cmd_id), psp->cmd_buf_mem->cmd_id,
 			 psp->cmd_buf_mem->resp.status);
-		/* If we load CAP FW, PSP must return 0 under SRIOV
-		 * also return failure in case of timeout
+		/* If any firmware (including CAP) load fails under SRIOV, it should  
+		 * return failure to stop the VF from initializing. 
+		 * Also return failure in case of timeout
 		 */
-		if ((ucode && (ucode->ucode_id == AMDGPU_UCODE_ID_CAP)) || !timeout) {
+		if ((ucode && amdgpu_sriov_vf(psp->adev)) || !timeout) {
 			ret = -EINVAL;
 			goto exit;
 		}
-- 
2.25.1

