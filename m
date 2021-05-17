Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DEBC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 04:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F3C610E9
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 04:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F3C610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91F1E6E1D3;
	Mon, 17 May 2021 04:39:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 111356E037
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 04:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnDpNHnZbtQky8tzu8FWkKGUX5cFDIOY0VRvpzu5Dx/0DlzDHq4nwgxJseHmSUVhypoGj9MMqT3RKljNuJuF9sh1u3BMHVM/SrlWzmF9pne++Dued7dD6cuafQWErQ3sxsHCBY/cJGAVW0RalIicOUrBj4szkL34XTYQsBTnySDesWNrDBSYod9zMamwwQh2fFbfxfFSukpilr8fJ9A3zsL8+XVgHoUMH6d8/Zoo6Qd2ZPEiza+WU3KjHFnBXR6tXPs6h2eLsRTho8VgbKcnwdXr4cegMbeuuCJPeUTE9dy4Mi7nSHU3YZvLMdmSxEyqMaEN2vkHjjIJHo6rTPN0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+ZrpzZXn/Hdw8bZm+J7D67LI9jwHOohLIdyTsInhco=;
 b=igucoDzGTr366UcRb4X3eJ9WAdur7Z9RKYECvJRiOUuwgUIkOxWrBc5zFLV8kwXDDEAYCfK/pJ+kzCKj2ZP6ct9b1AcF6z01kJhgkGnsONRSkStLRMD2WWIylRk/e3tsoMH9rZ1ns2Q1Ips9gcVy7vkcEJlNuvPnY0OsHKM51Cmj4d0cu5TewwLi9TaJH2OCq1ts/QAp8AYwI6xBse1sAjVcdd0hWfJT28C1WYFf2tCdVdRXb5wFXd7CHIN7aamliUJ0dF5gEEslSPmhHODets3nOtYJmdTQt/PO0fFghlH/9PIyojc3Ac1VgUEqkTJZGlCeZsFiRYc0tfWgwsjvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+ZrpzZXn/Hdw8bZm+J7D67LI9jwHOohLIdyTsInhco=;
 b=jv6QLYRhdQvMr0vfs3geoifXM2W0oI94higeNJS+P0vvqNcQqvJcQgFlnIg0Zb7Y2E5a1efskSJANaTwBCiBfx06HVpTSUe1i0ryIYmc2sQzkN39zVXZOxUGUgkS1bzhveLlc3xwOAJuiXDQmtkuIjMJfUOb/2TTOGCgibibx+I=
Received: from DM5PR20CA0032.namprd20.prod.outlook.com (2603:10b6:3:13d::18)
 by BL0PR12MB2484.namprd12.prod.outlook.com (2603:10b6:207:4e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 04:39:51 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::5a) by DM5PR20CA0032.outlook.office365.com
 (2603:10b6:3:13d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 04:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 04:39:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 16 May
 2021 23:39:50 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Sun, 16 May 2021 23:39:49 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: optimize to drop preamble IB for old GPUs
Date: Mon, 17 May 2021 12:39:40 +0800
Message-ID: <20210517043940.99603-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 831d3355-7837-4bc4-2a0c-08d918edcf3a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2484:
X-Microsoft-Antispam-PRVS: <BL0PR12MB24846A68269A24AC50D932BBEA2D9@BL0PR12MB2484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCvaFoxtQux+WRPhqB3wEHCG0UQ1dTlsmHy6TPa0ZhGheGpOh05n4H+zQHkwQF71KoP0DcWAA6vfB/P4H7fEN5xxdQC8zrmez1MQKW54nC9SV6kkWrG8IiwAE88a9IMp8e5k1oD9W0AojvDwXVJuFTj3Ut+0nAop2EvGmMJjyDLhegbAULfkYfcna75FOQcsaUTHQCQp4Dv8QKGwQuAidSVPAiq6N0Vv/x5Et4FsB3V0qKrqTb1GaZ+vp4TCiIK0lxrGeR5i3fIjSbSb4QoSSFfP+vJxjpXSo4GXtA+1zdCsGn96YDbAr26bP3mJMiYxpwJX5J3enqIlL1rgW++iQ6yCe4ygFjEaTEyCIjXF+Z4lsex1eZefUoB2+A0aDlICivLEBj5t+85GBOF2+VRh6i4TAtfSB+2co0m+qtFdpoFoncndAxAnSKqY7YAhDbD+NXx39nbYJVE5jxMOrbKdkSBUuE/y1QozONpddu9n/6oYZUknHmACG4835GsIQGB45UuiuS1Tmb+7GWSSPEl0ONEXc8STmNG4O2aw0AEVa5kcRO02ONM6UeA2xUAXo0jTr3xoVv4x6Kgg35TdxvNSX7Bd4DhwN38W2B8GzBPrkKCLckVMfMxnexj+FDiAmUKCgzv4UlETTUTe1EyE2heRAwuyTw/IZ1LM3gPQn7b2L7/jgKr06n1AU8Jy0Mgix69j
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(36840700001)(46966006)(36860700001)(316002)(70586007)(26005)(1076003)(70206006)(8936002)(186003)(5660300002)(2616005)(2906002)(356005)(82740400003)(4326008)(81166007)(86362001)(478600001)(7696005)(82310400003)(54906003)(6666004)(336012)(36756003)(6916009)(47076005)(426003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 04:39:51.1657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 831d3355-7837-4bc4-2a0c-08d918edcf3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2484
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
Cc: christian.koenig@amd.com, Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The optimization is safe for old GPUs and can help performance.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: Id3b1250f1fe46dddbe8498894fb97e9753b7cafe
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 3a8d52a54873..c915cc439484 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1873,6 +1873,12 @@ static void gfx_v6_0_ring_emit_ib(struct amdgpu_ring *ring,
 		amdgpu_ring_write(ring, 0);
 	}
 
+	/* drop the CE preamble IB for the same context */
+	if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
+	    !(flags & AMDGPU_HAVE_CTX_SWITCH) &&
+	    !(flags & AMDGPU_PREAMBLE_IB_PRESENT_FIRST))
+		return;
+
 	if (ib->flags & AMDGPU_IB_FLAG_CE)
 		header = PACKET3(PACKET3_INDIRECT_BUFFER_CONST, 2);
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index c35fdd2ef2d4..6d9ccae48024 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2269,6 +2269,12 @@ static void gfx_v7_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 		amdgpu_ring_write(ring, 0);
 	}
 
+	/* drop the CE preamble IB for the same context */
+	if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
+	    !(flags & AMDGPU_HAVE_CTX_SWITCH) &&
+	    !(flags & AMDGPU_PREAMBLE_IB_PRESENT_FIRST))
+		return;
+
 	if (ib->flags & AMDGPU_IB_FLAG_CE)
 		header = PACKET3(PACKET3_INDIRECT_BUFFER_CONST, 2);
 	else
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
