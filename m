Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C33BC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 20:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B43613C0
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 20:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B43613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22A506E8CC;
	Tue, 20 Apr 2021 20:21:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0C456E8CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 20:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxLTz1TkYziLAEfbkQk8vqmh4HwnQGH92jk+AKM2ln57/35B31pXwyveejqVODQ9KFdrA3RX7S+NjXXyCeFcA8DaRzXEpr5UfzTU2dzTgaMJfrd+h0/I9/j/a/2gqTdvHCyrN88AOAwKmGu60jogNsHKk+lRXR5gExhulRALryWjRnaTw20lGI7rb5LzeMywYSXSxNNRTzpRnvLTNy4ZkfVY3WEEcAlPo1c91uGE6iKtK9Ufwhg4n+nijbV05QLWFpfsz0JwB2Fvnt0G0TXYZ5nbJBqhaJcPm8qmz/gTp96MnVR42SXIftVFovod940XeA7oDzCyNoDjiIEdtQYHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLWOVvj03W6dobRnR8Ik4vKGmYSk9DbSEwrGwEmNs/E=;
 b=lMCNo1zY1fElZWsRG3xmNadMmSuERRn5n/wgV2hiimXXLk6MhQlf7tPn974MJ2AO2TqoldaYPjg0VgFl4oAbelBSp0M5sa8SaeLdzVDCrDdzGhlv1LFhzPRHxdzJ/2SSs0LBxX5L++5pP3j+LkrHwuTb7uDYrlSNXUnON5FpJvRtAWfDC6sA551m6ir+GF84vyuEdJkjI2HX8wClxnb8RRXmRVbbT65xESY/qkn6sC0HBVVSPP/Cmgzgff/43MZxSnrCNjIfvcVW4WpPsLfDFRWrMfu8OmUUCuDW8jldC1tpkOZFHMFVV2go6I4L2uhe6OpE6ggq/XPOwCDdn3fZ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLWOVvj03W6dobRnR8Ik4vKGmYSk9DbSEwrGwEmNs/E=;
 b=1nJeJDrID9cA5YznXmdncLzctcTa9RG7+GT36TXn9QWan1a3SdwpNaXa/bdaKP4LW1j6MX1zS+Q6iw5MKn2R65FQe1gbPM/WcES+/+tLEqr5cHQdgCxSkQJRUZywr6V9oNtuf5pSS+GpY6kltYSWs8pbIl6VQ9+cH/gEU5OtNrs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR1201MB2488.namprd12.prod.outlook.com (2603:10b6:3:e1::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.18; Tue, 20 Apr 2021 20:21:42 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.020; Tue, 20 Apr 2021
 20:21:42 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/amdgpu: address remove from fault filter
Date: Tue, 20 Apr 2021 16:21:21 -0400
Message-Id: <20210420202122.4701-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210420202122.4701-1-Philip.Yang@amd.com>
References: <20210420202122.4701-1-Philip.Yang@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::17) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19 via Frontend Transport; Tue, 20 Apr 2021 20:21:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e9a902e-baa9-48ea-d599-08d90439e8ff
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2488EDEDDB7352D78EE7D358E6489@DM5PR1201MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /d8D8Slqrc2NZ4MiuQz0rFk4+tlW2LQjzGK3HRe31e7JUHIerlj43Gbl93QDOuZ7kdQItypk5vAGpYFyBYs39T7NZRtwJjGVaad7W6IKwDa3HfePakIA3tIPpaXCJewcf+AMTR2J3Q1jBcoIufkffetzmP+CsDCJGxJg8YQyoYRN2E2PxG2/AFEAMVXXTC4Ywu6EueD3Yfjd54zwZ1xBFsn+vCV1Br3aBsGR9uTp4spakPwVK5o7+h9g2btBvvTZt/SBu7CgQUbIitLGaXgVRjgRPR6FdUkIcNSTm5Fix7D3t4WnFhqAhZQaesxnXm14LuRNioEHfz4ymtZG9Ywhh2STSl+AAK9LSXfep0vo2e1YQuP56otJRzcvphW7V/4Z9plwK4T81UxDSfLr7ZbEOUviAAN5lWneF2gN6eUOl+dIHl3OVhIn/fvJPbPplyM/VEMiQF45ias40DSM8GwgJ3p90r2jI0poqc6MtIe699kLTt+7FAfYASZkSiSeC4yLPk8YQurICiE1kwuaTzUM29B/x93xNLpxIqSDA8rZujAx8X82aNDwOPlYCSzkqrWqY+uxtFZrFBPE3VSV+tsIYwes9+TvgbQ1qQ/yNK2WrFqUHc4KNZoG1pUlZBRVlzy3rupvGVUgCnbwqocczvUJJuJt+BrtZQbRIoVHYfSEKIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(38100700002)(83380400001)(52116002)(66556008)(38350700002)(1076003)(2616005)(956004)(316002)(2906002)(6486002)(6916009)(36756003)(5660300002)(16526019)(7696005)(8676002)(6666004)(26005)(186003)(478600001)(66476007)(8936002)(4326008)(86362001)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?d03qY6UOii0o6/ZpcJAxIZj4b83s1tYM+Y0oJ9urMeOq6dr/Qz/mR6kH8SNG?=
 =?us-ascii?Q?wyA0nLU8nMLMLyFAQbk2gKn5IgfMbgrnDdrG+v3QynZLeaobzL2wS/E+OXXh?=
 =?us-ascii?Q?sSmcUr1UecJ7/KIAuaSzlWmaEE+m5dSHh++NvQcMPiYG0W3cCkKMyNAQ0ip2?=
 =?us-ascii?Q?PYGpXFlNIYUCVPwJJqYIKv10f9Xy+gUakkWQuKUbcF7S78ZwhIhJ25vh6fPO?=
 =?us-ascii?Q?OES+x2ls973N2l6ZG7r7Fbtu37exPbQt1w9siDkbEt1HG9vuEZh8xqi0Fxag?=
 =?us-ascii?Q?I6QBuG9o/t1HRUi/gpWU+u+jJaLOM1XL6uwq/3oIh/TQr1yKjk5zRkwJYtnU?=
 =?us-ascii?Q?/VV0Olkt6hLoHyf6LYaifRqlVW1B7Ii8C4wsDVjT70UFLGUpEnRgcrb+vUKB?=
 =?us-ascii?Q?mKkW4n/Rz554tgUzgIuk8xHoaFo+tsA2dVQ8oahxtLFTMt2LTqKKbO0dcNv1?=
 =?us-ascii?Q?yKu7Zoz/xxKRNeIx8a2LAOCAeLPow/bp721KdcP109bIzwhVqa7KlR8uZPuF?=
 =?us-ascii?Q?ZVXEP1nfvUOFiKf56WeNPInYXDdzmZS52F5T9fE8t2QBKBbUpWEwYwbr/5mZ?=
 =?us-ascii?Q?YkLXwViinCmU2RGlSdYd5lKYKJXZK9rlummhecHUoMuYkYvfXonthgGhSLWq?=
 =?us-ascii?Q?x6s4AAwGZS4rRpg45ZXRBkWSM5va/XGMvPx7Wczq4TnwKHjJQSz9zbe73xQh?=
 =?us-ascii?Q?dDlNfO7n0NrLIRnsDtaOOELJ3yDn1rBCE0yXbjgiLb9gnHoAVl190W7oP44G?=
 =?us-ascii?Q?zWBYf0PZTflzUQl4VLFCYCzyhPiF06uymKDl+P9riGisyjFQJztsnqOnZ5ET?=
 =?us-ascii?Q?Zp80WwxTbLd85di4bOQWq79JJPrrUt3A3TGNM6WnYqQ///ze7tzYt+cX4AZv?=
 =?us-ascii?Q?pLN+D7jXwgczBEYNYmBUcIyJyJa9A1QhHVw/Gx+sRq458dv96WCrGUGISVNk?=
 =?us-ascii?Q?WykSr9ONIiIY0vu9ivxx9tCZkJhXwba3LvugOzcRdjNIOLqmL11lRROaNESZ?=
 =?us-ascii?Q?6Va9vdDlMe9V7RH0pwwXqmboXIi9a1TRNOtQYjaIFHvs9EF+WnhlS7tvp0mb?=
 =?us-ascii?Q?1JwCTv8/Mycmg6iU5FFeJkEBRl/0VAfWMrofcXqhsjshz0r+EuFlmbd5DQ81?=
 =?us-ascii?Q?8fmQaESCqzzpeHcZhJpHKSkKw+R0cQfrRC91ET+nx4eJD+d212hqy3exlwg+?=
 =?us-ascii?Q?QyR/pId6PLRDKmQk5iEcIjaEvvWeNw4js9Y3tdrJv65gUgDk8CVpj054bcVO?=
 =?us-ascii?Q?EKazhaxlOAfbnapmthIa7tRcbr6b3j9VSN4Ijd0hDaijGlT4qiMKLYwPNfy/?=
 =?us-ascii?Q?+D4L2PpPXCXVQA7Bc9u5/YHm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9a902e-baa9-48ea-d599-08d90439e8ff
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 20:21:41.9712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kswIFKd9aHioS81riTMrdy9Y1WpeMcemQYaXQ6si9yYVSaWmOW9H9JhM6U+bFUal
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2488
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add interface to remove address from fault filter ring by resetting
fault ring entry of the fault address timestamp to 0, then future vm
fault on the address will be processed to recover.

Check fault address from fault ring, add address into fault ring and
remove address from fault ring are serialized in same interrupt deferred
work, don't have race condition.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c39ed9eb0987..338e45fa66cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -387,6 +387,30 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 	return false;
 }
 
+/**
+ * amdgpu_gmc_filter_faults_remove - remove address from VM faults filter
+ *
+ * @adev: amdgpu device structure
+ * @addr: address of the VM fault
+ * @pasid: PASID of the process causing the fault
+ *
+ * Remove the address from fault filter, then future vm fault on this address
+ * will pass to retry fault handler to recover.
+ */
+void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
+				     uint16_t pasid)
+{
+	struct amdgpu_gmc *gmc = &adev->gmc;
+
+	uint64_t key = addr << 4 | pasid;
+	struct amdgpu_gmc_fault *fault;
+	uint32_t hash;
+
+	hash = hash_64(key, AMDGPU_GMC_FAULT_HASH_ORDER);
+	fault = &gmc->fault_ring[gmc->fault_hash[hash].idx];
+	fault->timestamp = 0;
+}
+
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 9d11c02a3938..498a7a0d5a9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -318,6 +318,8 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
 			     struct amdgpu_gmc *mc);
 bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
 			      uint16_t pasid, uint64_t timestamp);
+void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
+				     uint16_t pasid);
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
