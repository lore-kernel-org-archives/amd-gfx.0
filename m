Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73FEC83000
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 00:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A29220787
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 00:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ui9Gw3FZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A29220787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23BD96E10C;
	Thu, 30 Apr 2020 00:01:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 656196E119
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 00:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcXa3gdDrDyYrTHTbbItFTEngq/91shYiOctlH0kwyH6/28f9qyN8aCLcgYU+jE+sEtes2ZWhoY7ucr6XYPZ+doZb41+QkkjKQ6jTcamk7kB0osPhrWb5gNF4hILP+B0E5gZ+8VZXdV6aTS3gRuFutBN6BsdJH2df5n9k0MDkGOkXSTB4G/c9I0/Bo/Ov4XdAFyjAWqx95sYWUiCCIbL7WYEUQ0FVxrJBHyY3sjOxnorWFSnxtAGhiDjCj9RicBT7KQ1HFoJK4jF0+duL530PRO7pggSaK0QKxKZEccXZQ3SUwJJ8OFYyJhE6U+0D/eVnB3Y2pop/K9NzZHjdJg2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLNygWqSuFICd7s74BoicrbdmUjzaoW6KJeiqIq5yCY=;
 b=LvMPXpMvlB+rngrLZxVzhHgn6le/Vl1H4nWV3wLFfJsl+G36Gh/z9OPax7HwJVlwO+BiDjNttGEybxVY53/c0hQVxp64mJKCKPJFuoJIS7PxjvTnrKBq+jawsuOy4aiwKzfnJtiz+qTprxwlo1WflRBQTbRMBdDPUt1RziOeu3VUUNK8pAXrUVU/itwLM8DhZdyHh9svRMXyq79Yc1MfG38Wa3yDkWQzHO2kOTb9Umd9E8xGttWztdINhqp8QstIFXWwWeDgSI/MBZbtErz1Im/joxXipZl3SE2NhDBt3ZDDsbqQDWU3IFdhOELBNEr/3zsgyVOJznmwwsStZkDPfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLNygWqSuFICd7s74BoicrbdmUjzaoW6KJeiqIq5yCY=;
 b=ui9Gw3FZAKLjMJAkUwP3JWcy0MmZCOvR6MMbwbnluEpwifv9REyDSFTSjduOJLjxe0vJUqFBYjlGnxqb/fnSTzomNoFYdYzEJOo+0QlvedX2FObc6bzHDU8kWVy6EtLhw4ihUghRfdEO3J64UVcymvn08OVSfYmFc6hL+pfuicc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 00:01:21 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2937.023; Thu, 30 Apr 2020
 00:01:21 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdkfd: Report domain with topology
Date: Wed, 29 Apr 2020 20:00:44 -0400
Message-Id: <20200430000047.31083-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430000047.31083-1-Felix.Kuehling@amd.com>
References: <20200430000047.31083-1-Felix.Kuehling@amd.com>
X-ClientProxiedBy: YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::24) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.211) by
 YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Thu, 30 Apr 2020 00:01:20 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 31c6a062-7888-4103-ce15-08d7ec999d73
X-MS-TrafficTypeDiagnostic: SN1PR12MB2575:|SN1PR12MB2575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2575EB83199B35036B9AEFB592AA0@SN1PR12MB2575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(6512007)(54906003)(186003)(6666004)(6486002)(16526019)(956004)(86362001)(2616005)(4326008)(478600001)(66946007)(69590400007)(36756003)(8676002)(2906002)(6916009)(52116002)(316002)(26005)(5660300002)(1076003)(66556008)(66476007)(6506007)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWSR4D1qrcgW42BYETeq/VP2uwBEpUaN8TCwOsWdqr0F3omWK3Vah1rbBfw7jYm3nXo7c87uIMmkWzgE0Hc1IzUXAXVIFaNEtD/BQOwm6qflaSPzf/rdIZt6YfmRpmJxEyiB1nmSBJ29t0TAw/KFIuGyv8M0l1Ue2cFF7YwpqmHbWVR7nyg3ywVOLmQvJeuJXWCJWTfdiGXXmWB9UTbEAPkNe3p7Yh1b37vNnLOaL9ccFF8XhSHHhB4LhmB0TAPNmJvPKvgiLZEhJ6hApBVmNhAZeeBWXgcihixyv/1KAiQE/ZTG38cLBV+fKsKoSnO8nV9OclKhyS78Nww8SJQhTHqjgtEvLUWYq8EWRT7DRfVd19UDQ3rivOjbf9m3tyvWFIx1k4QxN5bTtKUEGcrj9uaCaKkiSsNemVIRio/lx3Fzh2J8VFU9kQ3zFHERjYTrd/ebOE9r6SCUlhFBi6B/iKcuyI3CCQzEMoEIz6rwdvv67fV0cpIgG7Cw5ubkH7pW
X-MS-Exchange-AntiSpam-MessageData: Ig2C/1Qf7BFBWFY6zWqtW8U93gecxt+aRa1KxrDM9Mj+FeOk+g0y+2yu/f9uXqT+jav+oxu/BC0eWyYQxI1Ix3frL4nmXzUmNWhZUtrw2nlZ4Ib8Bn6Jt3O6m6i2h67nMoMX4OjrmsMul1NU9xsD11PkxdlAf9tgZtgq15BUcl69IwFYnBw1RcG9M0oyjPUUCEhKDPaf8VO9PMVYy5KnGMe7C/NXSM6rupbVyr+K4SpI5te6Gbz5LF/kTn/hrGGnVWOIGvpdLHlVWtOPdubvuh5TVoX5l2jYvaCdo6lLH5342VU5As6RbN4wTd6HMxxY1a1/QiPQFCMyIHB6uxu73OkPnX27G+nAGBF7V9wXgE9wWJhY2D3kIeSFTzjs8V7j38cQvSITle7RrNypnEStzqNfLs7DN+NRsLDXxqX8L16V7V+BTQf0t/h+AYno2BQ61cZ44/QKzPhXWT+MRgEh1oz59ksl1/LHvMap+aTcQxWE5YKbUmM68pgqB4GGkVmIor5zAeU1dMnNKsf6UY6qPy7qLr0lQ4V1/8U2qsDXBMge2f1mDPpG0n7D0p5PohDXct1fIapuaDnoquVse+bDATCV9e73d8H8/6cAnMabz4jgKKxj0gAHenqXbJExEzWxCRBWLSiActc9byB88pCJOxgNWLhYymniPOljuwDUQ+QwQRRjtelTC6HJRzx1VmUwzFaHLWVbNx6NJTGqN8fzTTQgFhgxbafI9hfV2A2f9WsN/LwDefItkSLfobhC2AV9Sw9MG9I3AWuadW5NdkOyjGrxCIg5bvhJGcFpjXPnZTw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c6a062-7888-4103-ce15-08d7ec999d73
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 00:01:21.4656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5ph6GF26cQOIodkK5FuEEOBYujWNE9rFftPspx4Te22QIkaTLyq6UzPRhGhTNNYFIP4hZAEqa4DkSSW8Ym01A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
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
Cc: Ori Messinger <ori.messinger@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ori Messinger <Ori.Messinger@amd.com>

PCI domain has moved to 32-bits to accommodate virtualization,
so a 32-bit integer is exposed for domain to reflect this change.

Domain can be found in here:
/sys/class/kfd/kfd/topology/nodes/X/properties
Where X is the card number

Signed-off-by: Ori Messinger <ori.messinger@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index bc4a22df12d7..bb77f7af2b6d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -478,6 +478,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			dev->node_props.device_id);
 	sysfs_show_32bit_prop(buffer, "location_id",
 			dev->node_props.location_id);
+	sysfs_show_32bit_prop(buffer, "domain",
+			dev->node_props.domain);
 	sysfs_show_32bit_prop(buffer, "drm_render_minor",
 			dev->node_props.drm_render_minor);
 	sysfs_show_64bit_prop(buffer, "hive_id",
@@ -1306,6 +1308,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 			HSA_CAP_ASIC_REVISION_SHIFT) &
 			HSA_CAP_ASIC_REVISION_MASK);
 	dev->node_props.location_id = pci_dev_id(gpu->pdev);
+	dev->node_props.domain = pci_domain_nr(gpu->pdev->bus);
 	dev->node_props.max_engine_clk_fcompute =
 		amdgpu_amdkfd_get_max_engine_clock_in_mhz(dev->gpu->kgd);
 	dev->node_props.max_engine_clk_ccompute =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 0c51bd3dcd59..326d9b26b7aa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -80,6 +80,7 @@ struct kfd_node_properties {
 	uint32_t vendor_id;
 	uint32_t device_id;
 	uint32_t location_id;
+	uint32_t domain;
 	uint32_t max_engine_clk_fcompute;
 	uint32_t max_engine_clk_ccompute;
 	int32_t  drm_render_minor;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
