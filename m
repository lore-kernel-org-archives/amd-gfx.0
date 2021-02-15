Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7F8C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 12:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E3564DEC
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 12:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E3564DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C78E96E1F7;
	Mon, 15 Feb 2021 12:43:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789696E1F7
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 12:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=newq24kYx8lHhK+P2R+WdHUUrtX+5STO4Cv0Dzl21ONPSqF1qiwq50tk6/dDmLASg91j+ZeubC8FH34U1apoj/fB9BY6vWTUSQXgJKsI6Ow+H7TopXDQR6mnvq6sHW5+9dTLRxKb5Xoxkzch4t+a03sTAQ8d8BktcNfp+oWhzeovEGgxOpZSIr/URX6/mzYWgBs840H7l42w6cGgxg2Z7LXzqQmldKQ8pCZLa2mEuM6lkNMX9a3imiVYcWIrgpYLHHq/mepTHSuOH/IgslU3HhJAW1s/Ns7FtHTxq2BtZKMbhj5SYMumUa5U9NSPnD6eLgVCGllggue1zgBfcO7vmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKubFFCPc0jqCqPfTf8ihTAvImm3/KAXP+bdZYVS2dk=;
 b=g6ZdEmjsgzvwES8EuWW4/I1F/rXjYUP+086avU13UiS6JVE6WVgqts5l/epMuX31IIPXRL0GJPU9L7OaxiZMJ28EcLh9MQ3I1KHNSYVk5ClSDxoSU0ZY+dbJemCugx/SgPXUdU8J7ycijo1/qDMKxuF9/4UJScYxAlGCIwH5Ujn7sXq/8ht+Xi6luLMpltSZByHxsajnB2L0capf9fWsySf4q7lKQ5bZnLCGc5XyvULJ7oVWfIVFdqJGHWfpb0J6OvjJGt/DbzlX/GhnyK/resaHwvLp70PI+yfRMjOLkyPXBxfNETl4DJh1NfYa0+pAD0gAWMce7UZbPDhMujz14A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKubFFCPc0jqCqPfTf8ihTAvImm3/KAXP+bdZYVS2dk=;
 b=cUcrYL+sVgrbo7A4b3Yj6Ez1oLianjqoTmKlm0vtFovcLktoICv38JfLOgw2N7WrLdYpdvQwbydhWlUB/uyH+1FpQfc4CtKmNnhI28hl6yrI40el2bVj9kjtYMQqcSJ9BCRMYPK2vUYE4bsgoLGAEOacFsu1LDrHdYp7hhlF/Sc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3915.namprd12.prod.outlook.com (2603:10b6:5:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Mon, 15 Feb
 2021 12:43:10 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.039; Mon, 15 Feb 2021
 12:43:10 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: print pci link status
Date: Mon, 15 Feb 2021 13:42:58 +0100
Message-Id: <20210215124258.88479-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [93.229.46.81]
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.46.81) by
 FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.11 via Frontend Transport; Mon, 15 Feb 2021 12:43:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57f78cb3-ed88-4382-d1a5-08d8d1af401d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3915406C99EDD4FB6AC472298B889@DM6PR12MB3915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2GehR4CmVVg2dP/864s+rvmtSZHz9DSWTS47C3uYb++he89wSxCrIofvoopaP7/9CEnLObd1LLEqqESyx8CnIqxKJRuKrf3dWHY0wSrQYs/5H8B4PM6tPc195km3IVwgEaE1wSQLkSMOHcrSlo6XOzGQAYDGBIFnAe5c2jDAXuSBkeOkXAX2Iis7tuWfStdHJJFo483MWVNzSyxX5KroCUBx0R+O8Pg7o8PDga6iP1DNX4qs8eFMuk9K10a8ggOXOeG+YpT3NueoOFxpw7IM4QMhPth/JmC1yKmXHeeIlvLzBJDMQrZhLh2V4uuD945y3j6Q+ZRmjldpuxZ690LLTFEpRKvR7HizAa+2Ympf/etIYTlWQg+sbst55JxWkZbOVKxCTboCaDb89zhtJsVsc40XmFKckC00gXAxCZCz1po0RtHNN3dEOzH2wXQi+GxMGMmo5U8B3xdzbLs/zXoO/CzaIj626DJoAINxArW+TdA7QQJIvUroBF4uVZIT7OHyKehS82kYDx6++yPKtBhdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(86362001)(6486002)(16526019)(8676002)(52116002)(6916009)(6506007)(26005)(186003)(83380400001)(316002)(2616005)(956004)(66556008)(66946007)(6512007)(44832011)(8936002)(66476007)(2906002)(36756003)(4326008)(6666004)(5660300002)(478600001)(1076003)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jkIAfaIogbNXJI2dqfiw8c+j4o45Q42JTkKCZzlTtPnhYg/uVUmPHoMUI8A5?=
 =?us-ascii?Q?F8K1NRlHqY7F2z7ettO+aqF3kcz87qb/IPgOUe0ABfwhd/I/gsJ24T3EY5yH?=
 =?us-ascii?Q?35DftrNwSoBz6ZeOhNdYrGJIjYbvKY0r7FFRkS6CXj5RZVNXeMeb0tTo2rJJ?=
 =?us-ascii?Q?ognEN6cJrqjNWp8PAB7jZWZzpXzIoeuwwfJErU6LxUTVtPa3KPvmtY347VkL?=
 =?us-ascii?Q?wabxyAC2FwdvRwtrRsc/FEv2QkO50UX9Y1dMTGmEfm8CuCWJwtT8BlEuAJDq?=
 =?us-ascii?Q?jIyLZ/iNgIHQ3W7iTfDBfB3ZqCI/rUAov1GB4XOSB7g5QrMkqHr2aS++ccSm?=
 =?us-ascii?Q?237EmHkyS9umGsIWbS6wz640uAUyUYpL5/p7TqwNz5vrJm3dLrKtHcL+ZAY5?=
 =?us-ascii?Q?Utyx2p9G8tcghOQlHm662ZITArBA0whABrFS6aPwYpWw2a30jEWLugNnL4dt?=
 =?us-ascii?Q?aUikkmAE5WB+BFPyAhsFNqJd2ng+d4l7jH2BBRhEPL5hOJpZM3CZU3sHz//f?=
 =?us-ascii?Q?bIJzlpV4VKLb34n4sqAc9C4PDX9K4l0byjEdk9COqdJvDfeQ1WVnlt/th/+j?=
 =?us-ascii?Q?vC9zUCOev9rizJ++dKzLSJkjZpLMPY5oPF0mHe0aZrF+sAnTEsGGMxzf2N/z?=
 =?us-ascii?Q?xGZuw61F3Ce8Dl/Tqqy8RZw2ipFJ0wDlbuyYhZH0T2cF95i23MldObE7U3XG?=
 =?us-ascii?Q?+WQaffr6AEYBmlKzwUkuo3YmAaMGHK7cSuRJqgqJ2YLWshTwGwL9IURuRWLG?=
 =?us-ascii?Q?F0RScyUMhO3GJ/mLr8TxUP1k06lUicHtegsdiJankyHRPdpl6rbiToZbAunR?=
 =?us-ascii?Q?QzSv6dj8x+wX+EPac+66P90dH9ESuIn/uHYz7T9GvAhy3OcMNT9o0z7apDHM?=
 =?us-ascii?Q?guQ02booqp3RKBn3f1uIVBD75ZsKnGC6vxJ3Urddv06ej49eXAUCESYeTK2q?=
 =?us-ascii?Q?Nvi+jI8+K9D9bTngTEISez8+56jQ3UpRaYMqJ6RiUp5GsJDszp24PpoLWWAM?=
 =?us-ascii?Q?to7/yc28bGhYoHkJS/4DL2Ad1qyRytOXHHRTdxB7UXDgf/rbiGJxkEGEW68m?=
 =?us-ascii?Q?sWccEDsuAgzvRxwKJCf1BDyD6k1D69JlwE8E8SC2/U44wbMUkWm8U8fYQQod?=
 =?us-ascii?Q?Ybr5I7kJSnc/KTm8BXPjJYC0yMRH2O5Hp4NhCp8RA45ujt6xYzoQTlX7D65d?=
 =?us-ascii?Q?aP70IFdKvygkAFNavuoG72sD6knkhCJqiMVnd+OeeKyKVl90z76bv/G4q48L?=
 =?us-ascii?Q?lbg/oXzK4je5vxN/6rplK8FO7/vuIFdjOYR5X9mPlT+r5EbfpvnMeREM6aY7?=
 =?us-ascii?Q?dZhxvmP2apG7yvt8p8CT6pPb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f78cb3-ed88-4382-d1a5-08d8d1af401d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2021 12:43:10.1251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGYQWDBWdcPypMGKEnDLLgLCQMFemtvsawV0a9FgAqrOWAJtZQQZyvFy9Q3e53ZFtdunCTgZWo6QeCQBRgbuvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3915
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
Cc: Alexander.Deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Printing PCI link status will help user detect scenarios
when the device is placed in a pci slot which has
less bandwidth than the device's capability.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b7ee587484b2..ad1b9f148a8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1237,6 +1237,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);

+	pcie_print_link_status(pdev);
+
 	return 0;

 err_pci:
--
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
