Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE39C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Dec 2023 14:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECAA610E03D;
	Tue, 12 Dec 2023 14:03:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 394C710E03D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 14:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCcN4fZ/ANH2IrizSezNxG0Yzp3hAvD2RAIYiUMCwmtFzU1C20+1oe1i6TrIFC2+heAgGdhzpXRU2cH/2JPlY4LBjguX3WhIIw7kZO8cf6LIgnD3l2+FR6MS+k8JV+kBCgxLimsgN+GJY4lLxoan1kqp5nXFuPA5O9F4V5LuAkOx5PkGPp/mFwITvVRy9jvVjNapPepTOjvjHibf94bg0WkoSgH1d2sEFZQ/05JxIdLSuzZfeLfh/hJULh61aO1yo9HCFC5E+swhN3tnVvHc9LGc9qMVD1ofy+LTyj5nJQes4UGWkMEg2hYX1gCA8DqWvkGiXKFuu/O5xNlQfSBOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smV21adI1W86NUuEwBHP+4fowaMqIFgbMoWxWKe9SBY=;
 b=j3tSaDoUS4y5y9gJtMW7auA5CKSH31z9rLPK8srM8uvs+0qh//n20RMGHGWNWA1A85VjW1ZMZcol4F9RfNecz3siEyVsKVp1mNLIlMOLkZwzVjS4hiEvkXc8rT1GBKZf9ap90OSGEkxjNTUESGp9GPp3VBzw860/942aCWgVNeFIPCSzMmwPJdgl+52QK3ngLhp+DT34sGOqoIole7PxBb6DyUMLkhGXFLpAbTu8Fv+1GXxMAuQBRLjxAiQ80ILZDdnt6AF3SaSo4RUHPLrDsG8tQZUx4LM1uURb9kkojPDumMcwBkcfqrDxKtrz7sKhGzrko0uYn2uMpMwr784nag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smV21adI1W86NUuEwBHP+4fowaMqIFgbMoWxWKe9SBY=;
 b=TlY+bGG3qjvXSDuuaSyrSbJkxC3cqitUUn0MdDmjI0hKZzZEbVLcp5n9GX/ezyMhI8VG6CUdSUPcMvgx7YzrhYSWxB9IIdajmRYw9Pwa9alXXnjVfM+JMeDdpsQ0tfVYo3/dB5dvkl42KJA38vaccXyoAkw8p0AuHe/gwbybw80=
Received: from CH5PR05CA0016.namprd05.prod.outlook.com (2603:10b6:610:1f0::21)
 by DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 14:03:41 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::2f) by CH5PR05CA0016.outlook.office365.com
 (2603:10b6:610:1f0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Tue, 12 Dec 2023 14:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 14:03:40 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 12 Dec 2023 08:03:34 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Stanley Yang <Stanley.Yang@amd.com>,
 "Yang Wang" <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amdgpu: Switch to aca bank for xgmi pcs err cnt
Date: Tue, 12 Dec 2023 22:03:04 +0800
Message-ID: <20231212140304.11894-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DS0PR12MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 483dd30a-374f-4305-19d5-08dbfb1b24ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dX7ywJQ1souqSDiL8znT8VOxFAL5IuBTvhydfyDwHhC/sABS7ZfhJ1UNEI6lgmzWMqyogNpdjdAxdIHqbZGoJgeyNWBzVeKOjSJSUj1KKcKcjnNZuCaKPBxCL6O5++2s4u5k+osCbi8uKzm4A3WS/9GoAXEvYcePdr/IBpMgVi8GeLQ3AehCaKcjZRWx7CvpUwsNnCIMKucVJfz3yGABwiBTKwwbKI0TAfehhSfMcWxc/GmV9F3hCEXqM6IIBY6E0/XIbACrZJ52us1mMS9LKFWfFrNhpli4xdliNr03/3ksi0KN/zZxN9JB6sTwqX/sw8bhplHIcIl32/Rr9CMmee+GZfbvDNnwlo3TGWAOQ3YUH5szJkYONSlQYif5eAeE5kwrSA8quw079pRidnmEwr1qpVUES1SoTAo2pzi4TZlIHjg5Wv749DdAs/9/7LsotUkzhV5DusB/IdvbuJFuh1ULpVhJubR8R+wud0sI/NurtzV+/x780Be7yV1Ua6Oegb5xauZCIpVdREDi4f4ze20nq9DxjeSaNVIXiuP7zDLTdurFuczihTWn0FG5yvBExyJ7M8WukndUqBV40nQXXabp4FQ9nOWJu6MvFM2Pq6NtiAz6WlvbhdqIjTIq751zBYY2vnmXFERliUWtNwqcSDPKPsFbPKcFe6z3ZZvdJSm+sI8dEJ0jp/YwE+8FL1UZth5LbPwjO+FutMDNk6NXllGxzDZmBY1GuzAtSDBpjdLH1ufoV+dOxKdX0ys1DpejHdHvzYLP0sIrJ9buvqGShA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(46966006)(36840700001)(40470700004)(40480700001)(41300700001)(2906002)(40460700003)(5660300002)(316002)(4326008)(8676002)(8936002)(70586007)(70206006)(6636002)(356005)(82740400003)(2616005)(36860700001)(110136005)(81166007)(86362001)(36756003)(47076005)(16526019)(6666004)(478600001)(336012)(1076003)(7696005)(26005)(426003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 14:03:40.4725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 483dd30a-374f-4305-19d5-08dbfb1b24ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6606
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of software managed counters.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h              | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index e51e8918e667..b399f1b62887 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -46,6 +46,8 @@
 #define MCA_REG__STATUS__ERRORCODEEXT(x)	MCA_REG_FIELD(x, 21, 16)
 #define MCA_REG__STATUS__ERRORCODE(x)		MCA_REG_FIELD(x, 15, 0)
 
+#define MCA_REG__MISC0__ERRCNT(x)		MCA_REG_FIELD(x, 43, 32)
+
 #define MCA_REG__SYND__ERRORINFORMATION(x)	MCA_REG_FIELD(x, 17, 0)
 
 enum amdgpu_mca_ip {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ddd782fbee7a..3998c9b31d07 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2537,13 +2537,15 @@ static int mca_pcs_xgmi_mca_get_err_count(const struct mca_ras_info *mca_ras, st
 					  uint32_t *count)
 {
 	u32 ext_error_code;
+	u32 err_cnt;
 
 	ext_error_code = MCA_REG__STATUS__ERRORCODEEXT(entry->regs[MCA_REG_IDX_STATUS]);
+	err_cnt = MCA_REG__MISC0__ERRCNT(entry->regs[MCA_REG_IDX_MISC0]);
 
 	if (type == AMDGPU_MCA_ERROR_TYPE_UE && ext_error_code == 0)
-		*count = 1;
+		*count = err_cnt;
 	else if (type == AMDGPU_MCA_ERROR_TYPE_CE && ext_error_code == 6)
-		*count = 1;
+		*count = err_cnt;
 
 	return 0;
 }
-- 
2.17.1

