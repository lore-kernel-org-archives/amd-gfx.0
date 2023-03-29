Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19712C761AF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2498010EB73;
	Wed, 29 Mar 2023 15:48:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF83C10EB72
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9nTljdNfcYhVXG/MIgKKWZBeOTmKdwG5t2i3Gmw8QTXknZZEvlDQRwIIHyBWKw6F+f7vHS2OMCmn89attYDAaFKCzo5JqXlNhpPviKw0cQ8PPFTgJsQDZubes+ycbARj7XnWqYwxY2UepvVqpDN5hOGm9jK8TsS4SuBu/6yVdGu2lsLMvwY29LlZdqSIEqstIAcdnoEvByETs3HC3wIxWXgOxaeXsrrJ44YKI/KGPjDXoCujMTilBADRXUHeeLp9eU0suMO7w2mgRlgwRwfbttovhFlal7R/QKrzPZ0FP5QSOy2kekOxJIbx+R0MI1NAAfcIdWaAH7KwM+iDcSSXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShAdo0ArL3xP5KmZaNZyruhT9cbGFDz4hqpkzaTsaVI=;
 b=Q6rMaDcZ11Mu/eiX3sv5Q2710VLZ36oiuMP9hKMEQSOu/T1GnV/LpfsYK5BgnujW97bvc9AvljWv7lBQyG/+OsqoJCzGlxQyIMNJ0NcWlry4EOnwCPcGIF93JCy+WwH/OxO4GSqehPv7ejvvP/LiI9Bg37NU4RSp3Y1Ez3sYK9kV4Ez8uhxf7m4sgBnAzB/emYBgLY2i1/qopwfCJYdcMg58jGzZewmhfxeHv8ectP7AXyPyBYwXD/QlNkR7KmTII1Jl/1lRz0yIoPmEfhCx/BA9nEUTj+a7e42q+X3xp1qseHso/JpZMeGZMoYzmiCRqbgHp4UUuCygosautLIV5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShAdo0ArL3xP5KmZaNZyruhT9cbGFDz4hqpkzaTsaVI=;
 b=g1P0F8UZgy9RIc4/gtBJl8RRja52gnlx7XqqbcoCa0PaDHJZ+kDLuvKEgjbL6FpGQ4wyp5zIjZfGd0qukBPI2GrFKM/IQu7M4wiIlySITDztNIS4PnKElTkMmoS3z5wZkNmlmO5wPeT+279/DUGeSFJN+38s3ZXzgpuvdJxduBE=
Received: from DS7PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:3b7::7) by
 MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 15:48:28 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::9) by DS7PR03CA0092.outlook.office365.com
 (2603:10b6:5:3b7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21 via Frontend
 Transport; Wed, 29 Mar 2023 15:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.21 via Frontend Transport; Wed, 29 Mar 2023 15:48:28 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:48:26 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/16] drm/amdgpu: initialize ttm for doorbells
Date: Wed, 29 Mar 2023 17:47:45 +0200
Message-ID: <20230329154753.1261-9-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329154753.1261-1-shashank.sharma@amd.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|MN2PR12MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: 39cf19d5-3a08-4d52-e212-08db306d0a3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gsx+cLDzGHwYCK0xdAWvyJLinhiAFsZVXY1jNNmAhgHpSOhYjYSHv+8VCXP3yN9ipFlTkA+udrbSwGJDQ/Il6XFLTUn1/ynE7q7nS6SwDB/eSLDQQJY/0hlSBpMoS9gOW42+L1G3MMSycOD+XT+LowzxRIf+T/hAjrc1zfmk6KD/O3xnBQ9b4ArF4I3Q9rW7zuCcmk2CdkhU9tFYee29KWXohQps6ygPYHzl1UiFCFcPHKs5J9nn10CCb9fsD3KDjXDhoyr+vD/RddcatnHSkxzmlkSTyUmk0A/WugDyYESgsl8XRTKxIVmdZw2//iB/98DrLeZldjWfq6JiBC+Z7TEqjmW8Xtay1z2pc0Tq2hdL7B6zYL1DfbHS4lJieq5iyBG6FB5Imtspc8Rvesfb68YG7XbaTxmzQxoF/pX5lgWeV/UGtQLCugX05mUQ9oEl3eVYyTjNpikX4yAxDHPBB3Ci/tkZJX01RY5Yo0qUHPOamh8yyuZNjGl5/ErKVbzyPu8UXzj/XLh5exPnVTHhrkEiGSFcULRsnhHXNmABkuwr95dKa213H4xktq4G8Ci0fLKjYrL8p86Ck7xphLbxTsgmYBPXUBx8mgjPxZowSSAXz68k1LTr/8HrTbtoS9swQxV2rMP/12Zo1a3w6VZB26LkMpFtOW8/11uLs4H6bFQNQkejZyVbJYRu8bqL23PIqp6SZwoDD8RTt9oD9Qe5FXHmRhq6EFBQ78NPKAFm8c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(26005)(1076003)(6666004)(356005)(82740400003)(81166007)(70206006)(478600001)(2616005)(47076005)(426003)(36860700001)(186003)(16526019)(44832011)(336012)(8936002)(2906002)(5660300002)(40460700003)(40480700001)(36756003)(82310400005)(54906003)(316002)(41300700001)(4326008)(6916009)(86362001)(8676002)(70586007)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:48:28.3672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cf19d5-3a08-4d52-e212-08db306d0a3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
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
Cc: Mukul
 Joshi <mukul.joshi@amd.com>, Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch initialzes the ttm resource manager for doorbells.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 6f61491ef3dd..203d77a20507 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1858,6 +1858,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
 		 (unsigned)(gtt_size / (1024 * 1024)));
 
+	/* Initiailize doorbell pool on PCI BAR */
+	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL,
+				    DIV_ROUND_UP(adev->doorbell.size, PAGE_SIZE));
+	if (r) {
+		DRM_ERROR("Failed initializing doorbell heap. \n");
+		return r;
+	}
+
 	/* Initialize preemptible memory pool */
 	r = amdgpu_preempt_mgr_init(adev);
 	if (r) {
-- 
2.40.0

