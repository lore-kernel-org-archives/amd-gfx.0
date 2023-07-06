Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18ACAEB64DC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 16:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2C5C10E438;
	Thu,  6 Jul 2023 16:25:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F6A10E438
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 16:25:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LN503pCHPHZPVa9Lql3vmMz7GGo1rxGwjDj2DLVUErcn8hAkuyUtciblhAzA32IADOT68r4cqZb/xhl7I1+JMY8NO7UAeRKLaDwt5LNuNqA6Q4Urh9yTicKdLtM91dysCEa7lBUTMjKquRafI0HezSIT3bLXXZO2T5f9gHdHiJIbFZd5ltjjT7u4k3McAYXXfBMfZ8oNGB0xcS1CRXIunjdCkqegc+zpaL/N4Diig7Y1IILiM4Kbvcht97CTLMcLtcDVd814gHp6fiscwO9jnhZBFjee+PIOpLGFAqFRBdL0JXgLu9KTej2lS9WlCDBWyq0v9HB3l09iQYGzM50clA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3FhJA12cgrlsrFlWS+b+4vegRsl9F3pl7P3psIwkhU=;
 b=Jl302LQRnLR6rrnslgzjqSH6nuWvhp94V/EQtp/nkwvvLLobWotIp2Mjsf54VhsHn12ut4abXjjEfSSwOeFT4Kyz3JRW/oV+/BkIOCwXhKOYoMvqDcWmONwkp8aKkJrnfR0AwcU5LQVo25YJaVW5zmS43sMGI5bmUphzlwls9oxwr9E472ayePVTUsk755aZNTIVQbEpnYeX6uHCAjIFCYzHGxjLUBz/3fKoNVdz8q4n5vlcupfo9jgPzYTnCofmzuy3Hb464KhQcp8OchmMJU6KQoaYwT5AB105+tyHi9pHE+mre3jPq8LrYXRUeBsU0QZRq5yEvvzu+KIHCEBTbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3FhJA12cgrlsrFlWS+b+4vegRsl9F3pl7P3psIwkhU=;
 b=uG5CDa8Rf5s+tkhUhGhn5o8QXV7foSIs7CMqwnQsUi66hFoRGQU6Oy54o08iywzSoXwytSBip9hJUelMDVVbNGreKNwUTBJj5w0LU6RNLO4RRprVJG+PK/v1UuFWhMTh4zf22Ekzh3IEjAKAX94Sy8w6ZMjr2COQZ/Oy98/AC78=
Received: from SJ0PR13CA0151.namprd13.prod.outlook.com (2603:10b6:a03:2c7::6)
 by BN9PR12MB5066.namprd12.prod.outlook.com (2603:10b6:408:133::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 16:25:52 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c7:cafe::94) by SJ0PR13CA0151.outlook.office365.com
 (2603:10b6:a03:2c7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.12 via Frontend
 Transport; Thu, 6 Jul 2023 16:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 16:25:51 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 11:25:49 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: init TA microcode for SRIOV VF when MP0 IP is
 13.0.6
Date: Thu, 6 Jul 2023 12:25:28 -0400
Message-ID: <20230706162528.17739-2-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230706162528.17739-1-Zhigang.Luo@amd.com>
References: <20230706162528.17739-1-Zhigang.Luo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT045:EE_|BN9PR12MB5066:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f4511b-1c41-4736-b955-08db7e3daa08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AJLVjw2TPjbjBbUuo4m9dKTsAw7A4Wlm+pyONsJpNz8i8mTVk9VN8b0VyX48DGnBlRGuZFxIlCqAIXqBJWgsmRGh+B75KOPdVYVLZrDOxzrpKmA7sb2qMa171jcU/Wdr21rBVeDXO4ncWD68UQLndT2QzdGAAHGw70aTJT/OV79Uat6rJaTx0B8na6vAWnAfpqRIkI+Lm9v0XbtO8pvLB4dFj3X102AAkZBtFxb24mYTZR+owSmT7T4PgeFMLFp9T/FyX/ORXydiRxEegxt/NXCBfBgMc3Kb7MalVO3W1q0PttzA9/m+/9Koi7BR1KWVcTOZhMkMjmQNJME5qzPUla9FqqEL8pqrw4vfBc/zfIyoWxJPC8Jc3WjRAjA/gfRwDLxFrKac2z+a8dmbBgHCcx3I+NMk2s+HvfkRQ7qA+ZPSPO06wwZ9moRrRwyLL7nEtbyW5TTXZ8UVf+vS3uzYh3evh3GebDcMs7OBBaeBSVLO3bjsKyfgMcgnGl5a32Fc0f8AXj2Vdvq85n3oODriPtRPK8CJ+9T3J/1S3GL3ngNGBItCq+T82INxGAM9BGdR3WhooVEQOC41PGs1KC88ymELsk0LT2m5rDr5sjbzYp0D5dP2hJjMT2DKYUtKkIlufDXhULqnB70eo+9KMw+0Ugg0z6pYl0q2Y2lwyo1OctII+HkQ3aIuAzClbj8gsthgiNijNnD32x7otuqETDjbMrn4nrIAu9ao53cJYTgCsGL4+KoRlYTJu983DIrf7Tptj4kQTPEekbiYFo7RGSs5cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(70586007)(186003)(16526019)(2616005)(40480700001)(2906002)(5660300002)(26005)(8936002)(8676002)(1076003)(40460700003)(4744005)(70206006)(41300700001)(356005)(426003)(81166007)(7696005)(82740400003)(336012)(6916009)(36756003)(4326008)(47076005)(316002)(54906003)(6666004)(478600001)(82310400005)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:25:51.3079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f4511b-1c41-4736-b955-08db7e3daa08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5066
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
Cc: alexander.deucher@amd.com, Zhigang Luo <Zhigang.Luo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
Change-Id: I71524c69c7137c6db4968b95e480c910aba24703
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 21438ff61c6e..de9a2a7f5459 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -145,6 +145,7 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 		break;
 	case IP_VERSION(13, 0, 6):
 		ret = psp_init_cap_microcode(psp, ucode_prefix);
+		ret &= psp_init_ta_microcode(psp, ucode_prefix);
 		break;
 	case IP_VERSION(13, 0, 10):
 		adev->virt.autoload_ucode_id = AMDGPU_UCODE_ID_CP_MES1_DATA;
-- 
2.25.1

