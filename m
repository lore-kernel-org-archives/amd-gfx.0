Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F763C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027EB61420
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027EB61420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DAF06EC62;
	Wed, 12 May 2021 17:31:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A34976EC62
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4oM8BMJJa2I99hicrlL4tiAtTnQ8ekwjyonGknAQiMeVG406K8cbkb5o5s3wGiSQS0FzyPE2o9y+s8QAi8y7MhlnL9kswNskd6ODWMRtrKRs/iomM7CtNqR6FvRwYRVtaWZiyEY8+RVUt9wXmNvySi7v1ZjKjsjLPQIoHXPGLwKRdCPwFDDevN5YC2mfyXjLyJeeJnq1akOsuvD3p3S5v3oUJZo26A9MINz7t9vV7M1avyY09WtYiQSe08TqHgPhhJKT+gXDA4zDLifKTQeKT40BhCrYeM04u+SWR19YRcaD6juNhznMtBkCWTHULx6jUMiA34MMVtXO0tlMgokUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnAJ8XdBSlHjwhK+UPgO2RZFHpDN+irHX1Y5bsr82BM=;
 b=TjuFpQcAkPrIfQJvThdBJ7WkLDfeaQkUoQvAvuLS/jq7M0PMX5Ceb6/kzlfgTQ4tkJOslWEMRdK1FOeKtVw4ly1E5gferY3q1GJLhLYCPGcpxbrqcc/aBeuM122NAJ8Lo8Jm6vv1n2jdDrz9dzbA+XcyH1/kWZNkNKhIxbFkDvPEMMCeJch9yilDubmFFybv5snua8P/hSZLFmKASppLxkVvv4ld2BdetiJHsr4cv2nZTSL07JbpSceeX2RgMV2LQsaB/KbuT/kv3Q6H1WiQHTTkHnmIU+yvUKNVjIOij4EmJ2VcjDZfH/J87jqxNO6SoUjJcU0pz87Dt+f79HGzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnAJ8XdBSlHjwhK+UPgO2RZFHpDN+irHX1Y5bsr82BM=;
 b=ar3JFm83qQad9eRx8NeFiSb5X7aLYykzb1mCxPYWMY7Lx+rX1VNprY92kmxzLmapgOab7rtxVYsAekrUPXVSHMAYoC+VVvR56vCyD2LGwEhoEqfQSaNDTEOczHVpr025ixlcrzxLoQneRiwKu8Rs3K3N1RuBANmd8kp4x9K3ITg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:28 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:27 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/49] drm/amdgpu: add mmhub client support for beige goby
Date: Wed, 12 May 2021 13:30:27 -0400
Message-Id: <20210512173053.2347842-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d69c9eab-b547-4789-66ee-08d9156bc5c0
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2340D08D7BAD9B6DAAFFAA95F7529@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3A3/2lad1dDhSdQumXB8MXlCElVgK1F0VvEGRI0FqPpRMcYXNCRsPx22iks4xaJKCOX6zcbBy8TZw7Dd/YL1i5cbV0yGFnMDI7ibtJGYk5c1i/qxJ4X0/oNjVGZlj+2PUL8sjQLSY0s2rzBdjBVcBBKw5EEXaaZygFuPFiwjuYtN4e3vksSCrbXB5iM3OOvIxjHntQ28hJguCxnTAcP9wQs9WllJjvr3LiYErk9rvBEDN9czn3qTcnoip9UagFnJIvBAI3j8j3SJdw/w1Kuk8cb4vdqx3o3m8GpRo63iFUNE31z72Q0c5dBL8yCrBuJyibxD8+qVVXvuXB64iA3HgR75+tNN88wofn7xuLYnqcU1RcVg7kC9MLH4oTLNM7tzLCh2Nm7syjG9QYg9M5XMRIwD1foAK3/TuAnE2KsPIzOz5t2pKElaqfwBsbbYWgbpnp1S0mTNNaLBTfzG6qgG7rmWkqi5LSk2kX19cy1a4aXlNZRZ7gcuQ/0Ee478lH/SU4d1q5mnLbZbxOeSGdS9ixbiqz0v3kBv08JmpBXi93xONew1iaJzTuHCa2qUTgPYMyUTXmSxUPAE5lhtkmZahKgsSpOt6BReEWZ2bgT5ePUXTVwFxkE7QG/u0z6XU4dP8PUqrmDtVr4JKEZn1XrdpxGZ17lN+rn0OTgytF+yNZd4eU/lTG5eyUEuGQ293yeO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(6506007)(26005)(38350700002)(66476007)(38100700002)(86362001)(4326008)(316002)(478600001)(2906002)(8676002)(52116002)(66946007)(66556008)(36756003)(5660300002)(54906003)(6916009)(2616005)(956004)(6486002)(8936002)(16526019)(1076003)(83380400001)(6512007)(186003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?y+W5oX+WJj8p1trgHrK5jFahdmzYMZvcGAe8Ncxesg/8Mh5fzlKlngXTECX+?=
 =?us-ascii?Q?8R3I51G5TxXRR/zLQlOFOrFxT8kElYtDrFSvQ3RIriCVX+h0R57gvahPrdxz?=
 =?us-ascii?Q?r3BJ1MtjW0t9P5HJlJYrxImusF/tzIEZ0wzP7fafLpG6fFc9xBiEKANzSs1w?=
 =?us-ascii?Q?HnLWAwOWTClfB4Xxo4cvycBFCKAgAC/g3jXBDffrtmnDO9mD3kk/aINxbXZs?=
 =?us-ascii?Q?EQgtrx1uBsrhQTBsK+y5iCaNqewOAOWR40L3pP3mSCb5AxgO7LcJGK8jnXje?=
 =?us-ascii?Q?xlLcz39S58sjcTCBxu4Mc0urIMr7ywXNiL9aygLBISfXYh8te09gXgUQ1wdH?=
 =?us-ascii?Q?DXfuOnCi2oF+gzQUQ/dU3BHjJQq9QXAVaf28sk0tQL7lx7osvhz9TEwKY/Nu?=
 =?us-ascii?Q?YMN2KkrGei/3g+3J5/oYhYaVO+AItNnqdv4Sy5vzl0Ky2bH0DVw0HgXHl+ZT?=
 =?us-ascii?Q?vA3lWsAVryoMBcAvRibU8tO0zR21nnx7XJIM2sMLneTxvzCX4MxuvfzwocZ4?=
 =?us-ascii?Q?GGfG//Ot8JErAzHV6DQRDvm+SMWVhY8Xv8SMCUcW6K6ltRZzZ5Q/xciQJf5d?=
 =?us-ascii?Q?x5dQTgqGBaE9AZZJMWR0CwZW4nZjdM2bsDg9Y5SVrFd5sEpZAqfcx/4cVbVf?=
 =?us-ascii?Q?zvrY79iuK77rWa75FqE8bBhSFVojIX/3rP0k7VivwVoEtcwGDu/kn1vLGf+o?=
 =?us-ascii?Q?moa2QKS04lxxnO3sjOyNf+RqmU5uILKNaQejB6xKqcyDF7tLxnaiPZHBocyh?=
 =?us-ascii?Q?RdPEaskMosoibb7gUJUfKK85b1GNDfFLirxtT3hqsu2uw3MgqaZ6C980G4e3?=
 =?us-ascii?Q?qaJqz0Cd6G4nSYvp4IpfDTr900fd0HZ/0SRraMy3hx559lZDxqGIc1wTn8aX?=
 =?us-ascii?Q?kQZDRm/kDWoUMMFy8JugwaFqjbVdpY5UvMU1CZjvXjzV1+51szwmovIlpSeb?=
 =?us-ascii?Q?2/YXf7EcxJeH3zL7JN2hqptBfjtfJ0ue9qtdltzoav9Z946CfZHxVpGWwxFt?=
 =?us-ascii?Q?WMKMwjUSoKwuDFUzigIIa2RmcphpawCLvRT8OuUqsKS7kdeiptoM9hQl5/RN?=
 =?us-ascii?Q?bXxA4/kpt6fVLpjP+he/9GNY2EiGGmFd7BL6W5oQeWzWkanniSol5+7weJFg?=
 =?us-ascii?Q?odrNFWtW1TXA4P2wjq5gJz1hte0ScFpX0yKx2L2JhJJdp/raiKTb4sLAeZir?=
 =?us-ascii?Q?pzelllngxXHf+dXdbWRsVYBRgdPAHhgdvD0Fd9HMmLvY8jUWEsmtgRBx020J?=
 =?us-ascii?Q?iuGd4KNkvpC6oFsLBxRV7BctMcExwwRaPjWlhZ/xqSaUb7BQqKkG4o7k7Bnc?=
 =?us-ascii?Q?yDgi2UgyQ8EvHuDTmrIuyn86?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69c9eab-b547-4789-66ee-08d9156bc5c0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:27.4285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0deEWrbztB+dlWzqYUyG3qJTiGwB7OX2E5l94xqaUSiPjj7fHD5pAxY4PoP4glNmhFYUrZZmGvymBvEAP14yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For decoding GPUVM page faults.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 72d9c8f8d9f2..655c3d5f3d35 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -93,6 +93,30 @@ static const char *mmhub_client_ids_sienna_cichlid[][2] = {
 	[15][1] = "OSS",
 };
 
+static const char *mmhub_client_ids_beige_goby[][2] = {
+	[3][0] = "DCEDMC",
+	[4][0] = "DCEVGA",
+	[5][0] = "MP0",
+	[6][0] = "MP1",
+	[8][0] = "VMC",
+	[9][0] = "VCNU0",
+	[11][0] = "VCN0",
+	[14][0] = "HDP",
+	[15][0] = "OSS",
+	[0][1] = "DBGU0",
+	[1][1] = "DBGU1",
+	[2][1] = "DCEDWB",
+	[3][1] = "DCEDMC",
+	[4][1] = "DCEVGA",
+	[5][1] = "MP0",
+	[6][1] = "MP1",
+	[7][1] = "XDP",
+	[9][1] = "VCNU0",
+	[11][1] = "VCN0",
+	[14][1] = "HDP",
+	[15][1] = "OSS",
+};
+
 static uint32_t mmhub_v2_0_get_invalidate_req(unsigned int vmid,
 					      uint32_t flush_type)
 {
@@ -139,6 +163,9 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	case CHIP_DIMGREY_CAVEFISH:
 		mmhub_cid = mmhub_client_ids_sienna_cichlid[cid][rw];
 		break;
+	case CHIP_BEIGE_GOBY:
+		mmhub_cid = mmhub_client_ids_beige_goby[cid][rw];
+		break;
 	default:
 		mmhub_cid = NULL;
 		break;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
