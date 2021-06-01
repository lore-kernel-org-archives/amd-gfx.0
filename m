Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B78C4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 19:07:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9A7611CA
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 19:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9A7611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D5A6EAD2;
	Tue,  1 Jun 2021 19:07:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C5DB6EACB
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 19:07:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6rTKvrSCpZnWifeiXK+Mjvx74lkjrXnM+MkIYebHPyrSZf6+SrftuZyEpazfFYBPoqxOlry5k+CDEBfG2f7L1J3qc4CqKRcXUn8O65846bmNIAvYPbAq0Gij3ew6jQSQDfLVtUMkMEqko2W3rFxzwvwsgejpaUitmT7fXvmBjSbIKLMMYs6rbREI7rLm87Edga2Gee/eaOy0TwdwTzD1QDv5gk5c5N5tvWMav2v24c1Zm2ayDzD8yPEvzgVXXc6DNqv3nJeqpR9vZRquC7XOswpdtIh13nEjl3XrPCQTPXPYzedACp4zMCXbvKLpBTMlhdLRPtW4szdkRPQoqvJYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cFh2qqiHavF7o9SGp5X1YXd5H6NQ2Riapgsj6Tcuxo=;
 b=MmkrUylK2I9YeY5vNMuLze/kI1BZ0drxc3ndkYA22xCWswQ/g9pCz4/ZtBB24017muxzbpFPq8vq5FVWlW++CMXFlnr3s626uhqER5f0P2Wgq5m+IldiNHya94Jek3FHLZ3XwmeFR6nV7OXAEc8O8+/CDQO/MyOpoPCtuxbPDpqrJbBLFwu3yJZRTVyPrYtpt9TsefS69pruK1xmaQpDt76zgG5MM3+uikj4H4jpQZ2xwUP1oBZR4TogJJke8J6kp6rMZPwEWQES9SCdOpDxkD3qAWtmbBgGhBsFkJJhTxwdgYYFsC6kN/Hxonk9+59mB2gN0kPL2tODEfPYkdjj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cFh2qqiHavF7o9SGp5X1YXd5H6NQ2Riapgsj6Tcuxo=;
 b=5SB2grmTgt99P3kcvU7pFV90jRlpl7cUNyi7rKPdIKp8zHbUu8+zgs6IkC0L0TrA5x8zOnpzffp6jweRlZUdNxdW430mTG1h4CO/3dJvHRpiafRigaw07TPn7j7YdH/7qDIZVs/VeF2PPeY/6h+Uwb72Y4ufjZ1n3WzPUhWoSl8=
Received: from DM5PR04CA0058.namprd04.prod.outlook.com (2603:10b6:3:ef::20) by
 CY4PR12MB1336.namprd12.prod.outlook.com (2603:10b6:903:40::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.21; Tue, 1 Jun 2021 19:07:52 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::fb) by DM5PR04CA0058.outlook.office365.com
 (2603:10b6:3:ef::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 19:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 19:07:52 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 1 Jun 2021
 14:07:51 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdkfd: Patch memory parameters for all CPU nodes
Date: Tue, 1 Jun 2021 14:07:37 -0500
Message-ID: <1622574457-4447-4-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622574457-4447-1-git-send-email-Oak.Zeng@amd.com>
References: <1622574457-4447-1-git-send-email-Oak.Zeng@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07be4bff-4ade-4cfc-6278-08d925308e2d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1336:
X-Microsoft-Antispam-PRVS: <CY4PR12MB13364B54FF96D9A16AD5C0E5803E9@CY4PR12MB1336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InZsGf7B5jIE1HxdpAAk8VDqx/Dios+i9LyxmOUVwXsiCIjsAGn6TOZMHhsWXryGY/OfdgZQ7Qr20QM7XpT+A+eywEJfXrRN+iM0PbUDsabI+30jyVpDWZCJJlk0RyH7/1FCtqSnRwBsIxD40HZmrGMsUgQu/HOgb2+1vgoD3g7CcHNjOCYemIWDfFZy+biNd/mN6mgRo186dZQspKoA4W7P0TEaQMkMkPWpZwdUoTMevbeh1wIzRf2iexqt5TiByvwEnFtUNhpDkIxMtr9DgqVR30FzpSpHRkODqK0GGqbUgxilZxYIBAMx4A1gQsz4Nrdq7T/0oQGeFE73DJf5qid5GnvHT5lKMjc9c7Tdtt1YE6MYb/HDjj7ZxshH5h1tO6wZ7dB5DUo98N+0LrWTM+JQzCoAttUfCUzkZyGomASs5IyYW4Q9DnboYH6CZExheevUPp3/9owcdCORFOnfkYUMT5+ZIXVXK/Ovy5xW3u5HCMIT228G1Ilg7Y2L44BgJKz4hPYmnsB5GKNLktLQJu3wdxWAJIfeya0vnQUxTkfsFVcG9ALxp4fc8T3kvjoRLqhgInnScNxkmKZEo9QdQFuH9SEP+hUlPUQ/bNAbI0rxwcrGo+hjmb2juQry+gpkMXSf9jEMDQqdmsuFFIFnvU3ZUxqbNsVWPueC1iTCeEIgmyJRf3EbZyWi6oZG6jlL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(136003)(376002)(346002)(36840700001)(46966006)(36860700001)(83380400001)(82310400003)(8936002)(70206006)(81166007)(82740400003)(70586007)(356005)(36756003)(316002)(478600001)(6666004)(16526019)(2906002)(336012)(426003)(26005)(54906003)(7696005)(4326008)(47076005)(186003)(4744005)(86362001)(2616005)(5660300002)(6916009)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 19:07:52.2613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07be4bff-4ade-4cfc-6278-08d925308e2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1336
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
Cc: jinhuieric.huang@amd.com, felix.kuehling@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There can be more than one CPU nodes. Patch memory width
and clock info for all CPU nodes, instead of only the first
one.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 9be66ba..e982829 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1073,10 +1073,10 @@ int kfd_topology_init(void)
 	if (cpu_only_node) {
 		/* Add additional information to CPU only node created above */
 		down_write(&topology_lock);
-		kdev = list_first_entry(&topology_device_list,
-				struct kfd_topology_device, list);
+		list_for_each_entry(kdev, &topology_device_list, list) {
+			kfd_add_non_crat_information(kdev);
+		}
 		up_write(&topology_lock);
-		kfd_add_non_crat_information(kdev);
 	}
 
 err:
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
