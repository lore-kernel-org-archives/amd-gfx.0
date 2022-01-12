Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B42C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 10:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38029113C4C;
	Wed, 12 Jan 2022 10:39:20 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C8A113C4F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 10:39:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWeDIub2D6gqsjm4LaPI/9Su1p9M+wBRf8aVCmdA2+6ddiqaoYZcwTBYb0LHuV+e/3+zvEus0JitVbqK0L5sOG7g+YJ0lHp8OoxskGSjatlXQUc69xXmB2h0uITHeEo4ZBC+hTXe6SvKZKFAZDrovQ/Qgpsnxl48OC08yQLedCVVztP5AwPgGIx47N/955BwO2AW6s8gqOSGxuVtq20YCpXuHal5jdfs8sFs5czvcw6LOj1HEnkEMdgHC3Q5rlu7R77I7kO+79rW/ohIF33FULfBKJFWy1OMI3MDBaHolA65FanZBj4Q9oY3ZLuj/wn4E/3JJk39xIgMZTx7l7MM5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG9cK54IUnwa2Yh047G/pZlu7Eeq/odVr0c/cxub01I=;
 b=jdiw6WYO9emOFCtKmb2SvWqqdpXS9vzKN/3SV5J4Sw7hW1FpdUeT1qrU+Xy5Hgtr0wwqT7P3PNAgZtJTyXf0u5xBkIUCt6vJVvWDyrAxohtVsMwU17eAlntMXD4z11z7+RJXz9mo2mWaJ/OcxaAwboPyWzl9lPNvIQd1w84JxZBkxlthdYHY5GIDHWT2OhyrElaqNTELf9td6TQ3j4bEaUg7a2X9Hza/6WYHapB4435EDuQpcAOIoox7mb123gtI3KRLEvS+7/m7mjmJ115SN2zdEHneQD8PxX+axUuaZUf5Fvr9EvKnkPzdLaQhdumApd3Fyxb2RL4acA2hG+g0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG9cK54IUnwa2Yh047G/pZlu7Eeq/odVr0c/cxub01I=;
 b=XjTDWUUXk8iijcfQuwHIniy9rUL+cLW+PiyVqRstcjpZblawNxffo5QQ9SBLPT7eVsOFslixY5G3+FyuAKtg90YpkWTodH/im6BeXtZdUtdaOAo7qVp1oz6XQSqfRTZiTVcct48GU0z4vTTwJPLWav3XufdY6P/8PkCbGRsJYVI=
Received: from DS7PR05CA0045.namprd05.prod.outlook.com (2603:10b6:8:2f::7) by
 DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Wed, 12 Jan 2022 10:39:15 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::86) by DS7PR05CA0045.outlook.office365.com
 (2603:10b6:8:2f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.5 via Frontend
 Transport; Wed, 12 Jan 2022 10:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Wed, 12 Jan 2022 10:39:15 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 12 Jan
 2022 04:39:13 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/2] drm/amdgpu: No longer insert ras blocks into ras_list
 if it already exists in ras_list
Date: Wed, 12 Jan 2022 18:38:32 +0800
Message-ID: <20220112103832.2910237-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220112103832.2910237-1-YiPeng.Chai@amd.com>
References: <20220112103832.2910237-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 119faaaf-eb04-484b-c9a1-08d9d5b7c794
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3514002B196F57D4FEB8209EFC529@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VuRE4dEQuciq/ozVKpbtHIASq4FXKLQg9HEuXvpy8uYIO3qN0atmrD5qm4gZORmTjYbYLAdqQYVqMB5aiNpLtIzJXkpQVMYJJlTj2QbyR+CFOCIpzgg5Q3On3UT2ZQMc7dVNPd0nMuzCS2z9BXYi8NrMkZ46WRZVKU9jnGeriynMTxd4pdVGklGyugvKshvNq/sctXKpzrhlF3my3dQqu5VQTFJo46uG5mMfnXO+OKY2danboBoTqmUtlyTRI0gFFpiCkCzFhx4cD5Uwyr3QjxbsfpJ8d0J0T0uHyuppHKSx96h5LDnZfWWSyeKjJ+oW5prVQo+5IOmgn7ni4Cb6mrS/3KGwxqI//JwGNjcIj5q7tMH7bGXAaN72b7Ib4j5ydi6H4v2EAEGa/qFQghFNyjiMxfuILFgOjx8AIBY7BV+mPClp/6unOyYGtL8tYLGR9IiYeTdlmgi5oKLbCDIW5bHo3dnOhOxfi34D6Ub3u8Bo2JExf4wJbrjMHoN4JU79FqwLCdwJh8tEz19DaSlpfh7G1J/KFtnVo6y1vG00dko9FREIg+KdPG0pQGyu1GyHDTCoF5BBR79l6QuzFjpcCDWNuw4FRZ9105M9GRG5dwYeWndGtbq+S8b9oF61m1TBZyE6Fj7RncSxNN7FicRjRjDyCosArU9QB5aNo81kDiN6hdCqUcrPOllqekIRAp2PUdo5rYuasZS0EzwheYqnPLMv+LvrhuWwBSKzPrJVqpXvK5TZnvrlTpRhK4Mt66QTCzaVIrj/B0tv2ytLdGawrO0n6gxk08IdXIb8j/2oeXCTf0luOIWbLJTKDaC0/3amqYZV2Mqq/45FohdvzjwG4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(2906002)(47076005)(7696005)(4326008)(81166007)(6666004)(508600001)(36860700001)(316002)(2616005)(40460700001)(356005)(6916009)(54906003)(26005)(82310400004)(1076003)(8936002)(83380400001)(36756003)(5660300002)(86362001)(186003)(16526019)(426003)(336012)(70586007)(8676002)(70206006)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 10:39:15.2846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 119faaaf-eb04-484b-c9a1-08d9d5b7c794
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No longer insert ras blocks into ras_list if it already exists in ras_list.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 614ae8455c9f..d208fde509de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2754,12 +2754,20 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 		struct amdgpu_ras_block_object* ras_block_obj)
 {
+	struct amdgpu_ras_block_object *obj, *tmp;
 	if (!adev || !ras_block_obj)
 		return -EINVAL;
 
 	if (!amdgpu_ras_asic_supported(adev))
 		return 0;
 
+	/* If the ras object is in ras_list, don't add it again */
+	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
+		if (obj == ras_block_obj) {
+			return 0;
+		}
+	}
+
 	INIT_LIST_HEAD(&ras_block_obj->node);
 	list_add_tail(&ras_block_obj->node, &adev->ras_list);
 
-- 
2.25.1

