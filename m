Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BFDCFC26E
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 06:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D0B210E2AA;
	Tue, 15 Oct 2024 06:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dfQZVA82";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D83A010E2AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 06:23:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFz+voPGma0O/5FTnV5ATY1Zz4TV941kS7Mcim2lj3yK3rrdDn6Y2blmIMt/9q97GpSghKUJ5TlcOGaLKuom5JLycZQ/AvOfNqIjaU5Xvayx7Y6hb7BqzcQvp81oLUcbxzDOOuaZ5i2ngP/PfC8X+JkYfz7z9WH7hUOJx9EPTevDhyTxegIXurRS+ugVuzweNLyl4usfbTzzYzqt1YyQuQdcdSYsIDTKGL5PR7oPk/39S4W4mAqIz/E7UMCdd/EDBMVn6LbKj88rX1gMGHF3iyaTjQU5TjHS7yannRMLVyn1M0WI2kzHPL4BXgiscQopL2ffqDSwze7D6Guas1vo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzP0O8plsSTP9YACP40ZAExAlJppErb9BaX4KxeQ1IA=;
 b=PjK9CqP93a2LMkr9B5T0rrpYHRZ52hqFjc/E4bR35JDTe35eg9i8KnF9ncZ/W5Qv/9hO/BbsY8OdNO1+mRBxpOmRpq+i0ZQj/GuhZvu0g3QCmBA1UzUsvLcNeUSbs/qlzMhs6BV9foHO7Uc11ByoNUAC/rEIICdpZGiK5IZyugXgMyFD9Db+vMfj+wMZ0opDhQYA9AZhCmyzemSrJeu3n6W7HXodAz00/FEwT3dDmuZKokcrcIEiisBcfmoyoYN5HBY7QO4zEaDnReKZnDggee4NTaYxsjW5orByvs4yg7Ph2IE+e9tkQprUNxzNkra5EMt7iL54XcjInGq7hitCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzP0O8plsSTP9YACP40ZAExAlJppErb9BaX4KxeQ1IA=;
 b=dfQZVA82yGtn6SLYEI4qdFXwidyMECfg7yd5/Hk1admK+xbGDvGdIdWMT+2FNXQegvwk2LwKr/D6Q1Ii4rPGhGkc7asvX5btfsjZ1gzC7IyuEqvHSUCjgrMNE4l525NNa7TIsAVJgPftEhg+TkmT6184meOcmoMJlMJdzya6ETA=
Received: from DS7PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:3bb::30)
 by CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 06:23:46 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::2a) by DS7PR03CA0085.outlook.office365.com
 (2603:10b6:5:3bb::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 06:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 06:23:44 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 01:23:41 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <leo.liu@amd.com>,
 <sathishkumar.sundararaju@amd.com>, <sonny.jiang@amd.com>, Hao Zhou
 <hao.zhou@amd.com>
Subject: [PATCH] drm/amdgpu: Save VCN shared memory with init reset
Date: Tue, 15 Oct 2024 11:53:16 +0530
Message-ID: <20241015062316.3050046-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: ca59a690-0bf8-4937-e8e0-08dcece1ebff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MECzlRmpDwRC2Tm1RMo38EnbwpnkWnYs8rYc7F7+U3PK9PgMiICyw68kF9AL?=
 =?us-ascii?Q?/fjOX+L4ct+rS5kL3QVB7kBeyPJDb5LehSxztbNgerKD6q2xhqUJ9v4OfQnI?=
 =?us-ascii?Q?ybGTkQFgRdmPSSP8/WcwqlnRChIswKgFV6OSLieFzmhCsf9R8eKZJJItY93C?=
 =?us-ascii?Q?wKm+/wobYO/E+F13nYxNYFR5canlC/OVPsF26fvuVrTmh4U7qIjkxmqguQZJ?=
 =?us-ascii?Q?mUL4fRDFtSudBsD5Ke+dpoERR95/4wuTllncul5aN/1KmQNXjjDYoipzevvH?=
 =?us-ascii?Q?gg+Qumupvyl5MsJgkne4ot/W29sOzG861sRPXreZYtiQE8w7PJwCE5QyKfOF?=
 =?us-ascii?Q?+h959b+Bei4vk3H2GLwmplGYMPgL8cjJjmdMYUFs8aWPN9ZsCO3/1KeuLS0V?=
 =?us-ascii?Q?ff00jPr21VWkV+hdR5kfKuC4aJt1iv64ynqg6Ncg7daHrG1p6taGtCnmS0TB?=
 =?us-ascii?Q?wn7DjGBn3Q8D2oMFD2UL9aU13rA/fwgrZRo8i8LjGKZ3msMIULRMdVCrDs2s?=
 =?us-ascii?Q?7HcgYrSQYj/9WwFKHQOurT9ThIjZeq1Z9IYdMA6FntOd8pB1zkzi62F/RL/Q?=
 =?us-ascii?Q?Rj7ggonHtVhgjkZRWl/c7Gkh+G0vZUxFq+qzZp30Zt9PWHre2kLGvveGxLNX?=
 =?us-ascii?Q?v6bI75gy+OxofD5TVkHuCHOtVziVeBKt4qmjEkDP3ZCAbkxcqQVo3mVRHmao?=
 =?us-ascii?Q?03wxt+C7R7y6tOSWS5wr41z76DTZ6DyDzPMYY/IwsrMPLte4k/YkYhmL6ML1?=
 =?us-ascii?Q?QILNVLjmeKwbZ/rQyZ5LzG4xnU9Dis+ai5shVMyxVMDW/1QqR2iNJt3n/Sb1?=
 =?us-ascii?Q?x6ETz2H3kVfiwXPDPG+JFYqTTO1i0GOrZBqkCa3dUP6ULiOjJLDlOBk3ay6i?=
 =?us-ascii?Q?QBw+gWDh4N3GCzzxlfFzJludnbFbSKEzXH7cN2pITEzg659akiG53xzm/NcT?=
 =?us-ascii?Q?2h1LaARHqfMFJ+xbG65Pt6QJWlFWpd8v0xQMSg2YJbqzyW872fnhr/7TMjr/?=
 =?us-ascii?Q?VbNXax2GZkvaQsQDl+LrPv6+cqEga4JK6wv9En9eVwnzKj+IFbOvVaRJK2/t?=
 =?us-ascii?Q?Yx+SGPb0cDrgMQG5iN4PThAaBhmhtniRx5hgFzyyx1boLthgS/IR81e6RQag?=
 =?us-ascii?Q?Hzfc+QFTV2ozCQrjl61al+yqKqcqUKf/QVHr4kjjKHqr5HB9JCC8Mhy7K1Yw?=
 =?us-ascii?Q?5vWLgevOoHkL8/Q2xcyFoqaBj01T2XxquEQjKPGt8dulTVEYBxA/Zea4SjEs?=
 =?us-ascii?Q?GoviN8ZCWO8uSYqOMf0LHmYKywOS6RuvmevHXl3WmjsVNIIxCwOgBydWDmB1?=
 =?us-ascii?Q?DcNQLRsIioVkoavkumjYcJkqvuG79OxdlXS5+fioltbefdYPFx10YIuXa4qs?=
 =?us-ascii?Q?UwV62Jo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 06:23:44.9887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca59a690-0bf8-4937-e8e0-08dcece1ebff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645
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

VCN shared memory is in framebuffer and there are some flags initialized
during sw_init. Ideally, such programming should be during hw_init.

Make sure the flags are saved during reset on initialization since that
reset will affect frame buffer region. For clarity, separate it out to
another function.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: Hao Zhou <hao.zhou@amd.com>

Fixes: 1b665567fd6d ("drm/amdgpu: Add reset on init handler for XGMI")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 26 ++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  1 +
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 3e2724590dbf..ea1e128362a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -49,6 +49,12 @@ static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.hw = false;
 	}
 
+	/* VCN FW shared region is in frambuffer, there are some flags
+	 * initialized in that region during sw_init. Make sure the region is
+	 * backed up.
+	 */
+	amdgpu_vcn_save_fw_shared_region(adev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 43f44cc201cb..3a1e83fa3d1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -294,21 +294,12 @@ bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type t
 	return ret;
 }
 
-int amdgpu_vcn_suspend(struct amdgpu_device *adev)
+int amdgpu_vcn_save_fw_shared_region(struct amdgpu_device *adev)
 {
 	unsigned int size;
 	void *ptr;
 	int i, idx;
 
-	bool in_ras_intr = amdgpu_ras_intr_triggered();
-
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
-
-	/* err_event_athub will corrupt VCPU buffer, so we need to
-	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
-	if (in_ras_intr)
-		return 0;
-
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
@@ -327,9 +318,24 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 			drm_dev_exit(idx);
 		}
 	}
+
 	return 0;
 }
 
+int amdgpu_vcn_suspend(struct amdgpu_device *adev)
+{
+	bool in_ras_intr = amdgpu_ras_intr_triggered();
+
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+
+	/* err_event_athub will corrupt VCPU buffer, so we need to
+	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
+	if (in_ras_intr)
+		return 0;
+
+	return amdgpu_vcn_save_fw_shared_region(adev);
+}
+
 int amdgpu_vcn_resume(struct amdgpu_device *adev)
 {
 	unsigned int size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 2a1f3dbb14d3..14713a5c6a28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -518,5 +518,6 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 
 int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 			       enum AMDGPU_UCODE_ID ucode_id);
+int amdgpu_vcn_save_fw_shared_region(struct amdgpu_device *adev);
 
 #endif
-- 
2.25.1

