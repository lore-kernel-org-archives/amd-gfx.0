Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F38C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 05:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640D960F4B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 05:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 640D960F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8B076E0DD;
	Mon, 13 Sep 2021 05:55:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15DAB6E0DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 05:55:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq+fxOx48r0aX2kGmwJnhIIMBMYiqlzkuFmb6Pcf2vNJtpJsbO66fCyhib5YxzY6/77Q67NRnTd/lUtEjNdGyZnjRi9uYozVFXlT8bHV+p3mDRbHCQ33LyMCFrlvSw/dp6fmDivyxzd3T47D7IoroLj1dad+Ysxvbwxejuz7TexLwha07G5/RmofMGOdYV9e+yD5b0sXXGEGdSDz7fH0FQPR8XLctHULb9VvGUkKFkemVhwFNRnQXYbvnMQd/kkRgpbSuKDnZqOvjysHLwf495XKzJXj4U8T9TjZASW3jVquxf5tAtR74JBqamHanmE9xB/xCBvGZOKYXnaWzx95mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=SyWhbZFi8lnblOeSh6zNTxPOS3qKtl8vxhAc6FJvv4c=;
 b=lU63q2Hu5JHgMuD0RK4+oCy6VidjCenxMqNNdNzM+AgMtmDbdyEli6YCvgSVR8KRrbve0Udt2vPXizKmyCB+LnTYfz8bbkYCrcQzP34HvtmnnEzJxEUeAngsWDrzwEhNfrwm1zY47YjD5Swcen3CXLj3kR83aLFxWyUpU7JJzLyBZ9I2K27BxVvds7UBOT0sHTCZHNyc7/qTC/xZsCMymml6j/plAIehSKYUZVE5SfNC0OBI2YR6QPkuvGXAYQ34vFhHz3zSzKpTK/ufW781eGvDN+ORiyzh6DWPAk3d/M5QJYshqqqf04/YUPg+HT8Np9hqo1/fyiOdLy8RjvSWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyWhbZFi8lnblOeSh6zNTxPOS3qKtl8vxhAc6FJvv4c=;
 b=VfNlq3PzR8EDfsPjeN0eVwhzn3W3d8wh58iE/Mpg39lMwQzx/admwfezFavySk+Dy383QO7wW9GG7j4CLvH4h26dhvsSLzSoSsnVz5MmsUGosXr8SeD3KF6R1vMMTkTP4tOUxyQorXZNiQuVUyCWJzN+opxkDiFdH1rLky7H6WE=
Received: from MWHPR18CA0025.namprd18.prod.outlook.com (2603:10b6:320:31::11)
 by CY4PR12MB1942.namprd12.prod.outlook.com (2603:10b6:903:128::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 05:55:37 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::da) by MWHPR18CA0025.outlook.office365.com
 (2603:10b6:320:31::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 05:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 05:55:36 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 00:55:33 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, xinhui pan <xinhui.pan@amd.com>
Subject: [RFC PATCH 1/2] drm/amdgpu: Introduce ring lock
Date: Mon, 13 Sep 2021 13:55:20 +0800
Message-ID: <20210913055521.27341-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bcf5889-d8a7-4e68-412f-08d9767b1b7c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1942:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1942C7270E03092B0031F73F87D99@CY4PR12MB1942.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEzqfLlu167RkQwEwxm/zl7685eTVIG5HabpK9hNfjay7dv0GeICbIxEoey6aq6TE8426+opaoS+ygHbHS07jLlE5QJWWbcj5vdL67xXcqBEkUSyDRk/q9raDM64rB52aYPRNA+XUkpxfxS1/j+7iOYECm0CIqwbwKI0WEv40xUQV7t7yacQ/Ctr8k7uAA6Iq4pJgg5ZCal4iC9j3gQ/G420rWyq5U9Degy3Uxfb2hmmrkSmrMQda4WZ8zqO1zITnsJ9+UIeBDw1Pqy/Pxt/lc1wcj7OQK1OUEui1Bdwa1uGMIf5ojU7d+O8dk8PUlRr/ls97+2M0M8oCarcaiN83Ga13ctZvmlS4OiQI2r0RzM54MX28KzGy0bwWh6kljs2RTi+p8TEsBSZTJyYXmrQfwuGW0+9REe5Xh07LLPds3p71EI/1t+wVNxn98VK/g76priLMSf0J6UYEGIGHv8Xb7ewsudAyIvAxh5BaJGa/UX32vc7sJBaB7dLtY8ktkFp63zND/z4UYy7xncvxcpaeZQ6/WRgRLnCZWlx1w+292+X6+w18dmLfV9Qb63hycixZ6NF39FlCldvLfqEvsuhLDp8Q1XIbubfxZuJJlwy2KGVo9f1YJ5jB1RMy1zjtrkjcI2UihTATzuU1e5UncldssIMDGxnkC7ixw0YCbbRTsfw1nNJeyI4iW3wv+V1Iw8YsYE7dztCH8X/ZU9oJ0DjKLMVrrdhgyNOzQgFncpBF1k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(36840700001)(81166007)(8676002)(86362001)(5660300002)(4326008)(6916009)(7696005)(8936002)(36756003)(54906003)(186003)(478600001)(82310400003)(2906002)(16526019)(316002)(70586007)(47076005)(336012)(426003)(1076003)(82740400003)(6666004)(26005)(356005)(70206006)(2616005)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 05:55:36.2239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcf5889-d8a7-4e68-412f-08d9767b1b7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1942
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

This is used for direct IB submission to ring.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index ab2351ba9574..f97a28a49120 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -184,6 +184,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	else if (ring == &adev->sdma.instance[0].page)
 		sched_hw_submission = 256;
 
+	mutex_init(&ring->lock);
+
 	if (ring->adev == NULL) {
 		if (adev->num_rings >= AMDGPU_MAX_RINGS)
 			return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 4d380e79752c..544766429b5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -215,6 +215,7 @@ struct amdgpu_ring {
 	struct amdgpu_fence_driver	fence_drv;
 	struct drm_gpu_scheduler	sched;
 
+	struct mutex		lock;
 	struct amdgpu_bo	*ring_obj;
 	volatile uint32_t	*ring;
 	unsigned		rptr_offs;
-- 
2.25.1

