Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41976C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2DDB60234
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DDB60234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D746EE13;
	Wed, 19 May 2021 16:22:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EEAC6EE13
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 16:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/tklZlPR1hk5A4ABfvyU2wH1LA0JuAAEdYSd9oIC0aNMnw3fKmkQA8BslBUaouLgkCA7cuGa+E+AVNK+ZrTcJFunltUPe7asgt2Hk1jInhRGv27K2aGn+btfLcj79mrr9Xs3Pfg8TfWYIXdff0WGsfHHMEW06B2pkR9ubjYHXCZfAvsPC8FkNGtafhAnzHxpK4dlhPMFeagssQP6j+GchjVf8GB/HvoDjJfIoInjDBd5N/hZGdgWi+AwG4+dHpd7DEY0RAG9KnzBsbcmR03YmC0sD+4xZavGOOQlczH2m3+oytAQphayuKhvjE1Pr0VJf09tLXmoQl+1XLu9rV5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcodhxgihFeM87NeqvsFNJe6IrqF2zXJbHnFSMgBzhM=;
 b=jvgIGyXirhoZ5QfclnkBn6x0R9lWlfAdN+7d09pVW4QtyMYqERRKWdI/mT6AP7Jb1TVn4wa3GlB809B9t96GOSIcyRGIz8DhWXN6Y3bC+C2MSLatWBBPXk7j1l6wAhnpeMrtYn1Lzz/5c9qJeB870xOIuC50OkUjmtgtcgXQ9VbBVbCeJr9dZC87vGzNgdcaCjWyzqKz8srwJAYDphfxMOWlfmntKukTPtnXmP1eMNvIj+RwSlz1eVm34ZpsMRugWY0ZyoOtAOLi7308tV3p29T1HCocHV0denQNgFdTSlLpulUQYWXFjW4KM5zbDJ/6QKvugkfw0yH3gEJjRMonrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcodhxgihFeM87NeqvsFNJe6IrqF2zXJbHnFSMgBzhM=;
 b=NzMWTQIOo/p2c+W4FAfJZfhVJ/u+BN4io2WvS3Tj2bJ7LiyE1fZUY1ou2y0K5BOQQklJTc1QvWvdMf8QnvdsCwTS8WxKmsigd1pdusSxL67F43+FnCZpHbX8Arnfz5vAAfCmOBy5C4dAslcK1eevH8tYFXpj/xzG3UcY+FqNxH4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3259.namprd12.prod.outlook.com (2603:10b6:5:180::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Wed, 19 May 2021 16:22:54 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 16:22:54 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/7] drm/amdgpu/vcn2.0: add cancel_delayed_work_sync before
 power gate
Date: Wed, 19 May 2021 12:22:33 -0400
Message-Id: <1621441358-14685-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621441358-14685-1-git-send-email-James.Zhu@amd.com>
References: <1621441358-14685-1-git-send-email-James.Zhu@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34)
 To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 16:22:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5153487-ee35-4c8d-6bf2-08d91ae25ae4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3259:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3259CD8DBCCD252D9AE8F067E42B9@DM6PR12MB3259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4wbNqahtMYKOXhoSFR7u1pUEqNDa10XKf/cBeBiqZvMCR5h3jUIneWJMzyJH0PDj94FVm6M63AlLfbYC754Gg8vBgmHg6+vNyhHHnphrvCZk9KvNBec2wnzuzjVYzcpmtE9muHTlmT5lLQzgx7fx3pDIdu16bfk8vtlbDjMmXnWHBbts5EeK/6f6OhqNyzlhBlOXWlwr2qu4uOn7RXbrcDkjK51aGD2hAv/+unjNMTeutdPgWYA07ZrLaFT0XMrXqjNQ/o2UlE5H61eJsjDv0WfUIgWCBdw1R902asaBEAD1q93HrdP+XewTxV3BvXhSCXZCpSh6jQkGviGAPHiYihJKbudKg9157Z40Y7Nnt/bUC9+3t0pojDs/+TFZJc4JYcQoAtxqJvfVWNMrAR3c3QdRmeWTICg2zd0Aas9IKRXWl8g/uQ3KK9ihkTUdQjyUkvTAl3OLRiB3Dtfr6QpqKQDYxhB98b8Zw2FKS153pqWZwOfkKsjpZirtg94TxFQ7Ph9TNW6s4RdFOsT/SLRyhNWKhkBSd5c7K/6t6ODrnBRzKLEfPDzruNjhJkYUxmQ7L/alOTx0valR3UG5oF7Se4VGl4zQGnem8WHbMl+b1bsIcSPMBqzKfshlVaNo07WFGkhyFACNXsN3rICpcS3MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(186003)(36756003)(4326008)(66556008)(956004)(6916009)(8936002)(16526019)(4744005)(26005)(7696005)(66476007)(6666004)(52116002)(8676002)(38100700002)(66946007)(38350700002)(2906002)(2616005)(5660300002)(6486002)(86362001)(316002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?J640JLd9kw4YI6v8tfUZIkqiY6u0iIa3ckFJJJCJv4NfE4xvXDy/GHq5KIWL?=
 =?us-ascii?Q?NoMBHB0bMYdK6VryVWOU8numFLIZwJjUqZg2O/QHma0BOYQKMy5tFO9lI3K1?=
 =?us-ascii?Q?Pnd2/+/EB5VIcM8ADRGM2sDdtbxgGndgNIptdVB0ll64Iv3l8eswno4Rj0KA?=
 =?us-ascii?Q?BJuzFdoSNWhldvhYDpCPRNexXNYboB4oELHclBArHRWhQ1gsnguePfXRbghR?=
 =?us-ascii?Q?X1aIXt+wb+52ptUhAUVHY/5stLUdK3rtP62uN+jSqt1zxt6/Q3LgH4oMdbdu?=
 =?us-ascii?Q?xvpf1pMBD8nOyhc5zKYnPoCjjyxo5NuOAYari2Q5GKfrUTzC/A1AmGeugl3P?=
 =?us-ascii?Q?6B0Ek6MhhtBdITBdqazpSdsVMsMLZaZop5E6cTYr6KtmjlWhonBbpU51FZy9?=
 =?us-ascii?Q?VDJ3+3tna/wY/WxNtvd21BTUT4w4lWIP0lzeA/EC2DzQdKcbeW1wrApmCuWb?=
 =?us-ascii?Q?cVWWgLdkp0J0KVJu5v9URCPnWyDzkut4Y1ykiWuy09efMOOLG0XwYjEaoU7I?=
 =?us-ascii?Q?gkMakVsC0wu3b/XcAn85Cc/e/a0jKJboscnFLN6TNj4Il8bu6RUUgDIsL9Fj?=
 =?us-ascii?Q?hM8BZaIyiDnXU/C3P/9fBy1PKy7nYp8F/K9c4iPHOjh4+w+FGy5tDOoRG2YK?=
 =?us-ascii?Q?88I6R8M583YyC+V/n5bsAbqZVifkWEQh4swBfjUCABmvd1yfJeehbtVDjxfZ?=
 =?us-ascii?Q?5ouinEzTv3htmrBYwQWvHbdBM2cNFU4GpHT/XyBVlwKfOQ7eT+hiemkyJu6e?=
 =?us-ascii?Q?z6d+QAKBuooDikl3dKj/xd+QmLPaVsk8OkPK0p4BXgojkVf8ugbISuItPsLe?=
 =?us-ascii?Q?rGKOlIuoKC9ieEwkT/DwQU5w14oTQGl7/yeV+ePknVxopg7s3u1ZvRTYfl6N?=
 =?us-ascii?Q?ct7ep0pcy9W5ZTGcGZHKLA8yJPhVpPHsfvqrqJu9gepLZieAFNzOTKVFN1Qr?=
 =?us-ascii?Q?kJiMTymTOitCawof8fo7AeJOTc0JX/t9c6s5rNbZf3QUrbb8cneLEYW+W/nJ?=
 =?us-ascii?Q?NrPr2BICZ47lFBHsQF9HD5CUSBwpVA2tyFfDb9rVfBeN2aauz8mVc6sV6wi7?=
 =?us-ascii?Q?sKe7tcwoBL7MsmpNSHPt45qPnr+kQEXSyYNCOAUUABIBSKYHwWp/NI01LF2+?=
 =?us-ascii?Q?57UMV9KlRUAlV4UrINYKSd83IfdQpH8tYagvvVwO4sEBwQpMIwbwyUEKyL7y?=
 =?us-ascii?Q?3gyFexWlyTi0DyQCLLcrFgVzedj7KZrJb/1yI2XJMhwgXmtQAZBP9sTCKJJ3?=
 =?us-ascii?Q?h4BJq8OUxSplw65yFJH++VcgAM2Wmg5rWHLRalVlQYCVax4YZ+KDjDKxRCYb?=
 =?us-ascii?Q?2dzT4U6G/SfgIKvmVYQYMEdN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5153487-ee35-4c8d-6bf2-08d91ae25ae4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 16:22:54.1794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V377lXLJXGRvSQk8anRZ1P+X24POIs7on7X5sdcrnH1N/d1SiJRqW6MGjxYx1y77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3259
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add cancel_delayed_work_sync before set power gating state
to avoid race condition issue when power gating.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 116b964..8af567c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -262,6 +262,8 @@ static int vcn_v2_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
