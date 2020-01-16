Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200B5C33CB1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 04:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CE2206B7
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 04:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xHlokSjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CE2206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B30D6EBCA;
	Thu, 16 Jan 2020 04:47:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F87E6EBCA
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 04:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzH2MgXM6JcV7K21yelw95jERuoS+IF6j9Ilr7mG/6BoRksCkOzVmyIxVaLAeR8G3vLRRelaONpKjC0Z+zBxTgJqIGuBlV7qEVytel7MW66byhr9/MhZMokcjRLa+IYGVY1A6GPTAjt6i2qLaCfNZIEpTyWm06g+da1p68MQhwt36y1c9ROjLptO+5anyx6q9MzlsL3++QntiIsYV5IJwuTHBuyqBsueULTjk0ZPbEPvepwD5PoHB2sEc/mbNsHE/U4VaYzx3XAiWCOFEfjhlVRTpebHf7jFwmfBSWKooNwdEJzshbBpSULi8VoGhjv8OGCgh3fMyx9lzdWmNKtnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfQHZl9DXQLaeXN5lLxHLHQDQobxQzKMeDB8tijH7is=;
 b=YxOm1YWM2BdXvjCYc4ecgApECS9gkzSIZZbdDMeuLfWhTk4XGjWjnjyfZRcye/l8Cq/WWkqqEdEd4nfsvL0iwea49VZUJaTDY4YuTG4Yucye3Be6nW+qKUrzoPv2O7emb1O+OO3YPG/DHq5VxlNboXHddwOwzGhGVYplokVBOopMUM6sH7jKYBYipGwBbRJ3kdx+TE5J/q38M5d0owhSjGrIUxIM2gIJqiNbz5/K/ub2Fteot5mox/ttFiYSQApdNxitjh92LunuQed8kSBnC63ldxwXSfe2WyQSx8fTbP0r/XWdMlCRkGFcXtHzTGI3CriDsSk+MXGAudMvaVCsig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfQHZl9DXQLaeXN5lLxHLHQDQobxQzKMeDB8tijH7is=;
 b=xHlokSjSQdCcfgBUdrw9RRuaTEzSNkI1JUqmmPXkcGHcnqHTin8c0oNNuHcs5lsFy7JdmA2w0zP3StJ5p/aCqLtP8Lr48vEW4F34pfbKtwUsR++uDCH2ga6ijuNfiwaW0y5qde/zmY2zvNzk919ZrlnSNvs342EOyuKZvarx1wk=
Received: from MN2PR12CA0028.namprd12.prod.outlook.com (2603:10b6:208:a8::41)
 by CH2PR12MB3957.namprd12.prod.outlook.com (2603:10b6:610:2c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18; Thu, 16 Jan
 2020 04:47:19 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::203) by MN2PR12CA0028.outlook.office365.com
 (2603:10b6:208:a8::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Thu, 16 Jan 2020 04:47:19 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 04:47:19 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 15 Jan
 2020 22:47:15 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 15 Jan 2020 22:47:12 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Guchun Chen <Guchun.Chen@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, John Clements <John.Clements@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add arcturus to gpu recovery check code path
Date: Thu, 16 Jan 2020 12:47:05 +0800
Message-ID: <20200116044705.9398-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116044705.9398-1-Hawking.Zhang@amd.com>
References: <20200116044705.9398-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(428003)(189003)(199004)(2906002)(8936002)(336012)(4744005)(86362001)(4326008)(70586007)(2616005)(81156014)(478600001)(426003)(70206006)(7696005)(36756003)(110136005)(1076003)(186003)(26005)(316002)(356004)(6636002)(5660300002)(8676002)(81166006)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3957; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec1e176b-fef1-4877-8f74-08d79a3f2b2a
X-MS-TrafficTypeDiagnostic: CH2PR12MB3957:
X-Microsoft-Antispam-PRVS: <CH2PR12MB39579A9A8111C1F199F377BFFC360@CH2PR12MB3957.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2JcuIICuaT52hH7aUTIrK5/lv7x2tEx6Vd0J3M2inU5Ep5z8wjUvTdgtbKFNS1QNXa6BE7ur5AUi8nQADFdJ8hoJKaHCdpUqHrnrLK/4bbGGm19IX+jua8qttI0vt1LrP7yjRSiypxBQdbZKlMjyfM4VtkF02GfIgP5+e0Y4/kfBwXaExpi0/mydAx4+63V8SrPbj+923yH9UDiPDf1G9zKIxEVqR1UXbCH1buank+xB1M+IsaitFes02Vtqjg4Bg+VmvIYOMtuZTSQvKSLNEbpIuj1ZFZUcuUyR+PHkeYsVhg1YB+qquZ8LU0wh5OaDSBTy9loItDI6q5yxA8R4a1cry6pJPZAcMSU0e6jZvt/Pacp6iVJjEhqTQRS2RISFCnaQnLsxXOIbrYKJseJ6koaWCgYGd03tl/0B7tWVKf8clNmKxCosBDgBZM/DBHf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 04:47:19.3200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1e176b-fef1-4877-8f74-08d79a3f2b2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3957
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

support check if dirver should try gpu recovery for
arcturus

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 706a30e81fcc..8e2f0a380461 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3799,6 +3799,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 		case CHIP_VEGA10:
 		case CHIP_VEGA12:
 		case CHIP_RAVEN:
+		case CHIP_ARCTURUS:
 			break;
 		default:
 			goto disabled;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
