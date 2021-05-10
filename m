Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D21C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 23:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FB861585
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 23:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FB861585
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6D786E974;
	Mon, 10 May 2021 23:35:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 174C46E973
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 23:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBUlSAUsTQnLk7HCpaILFHmy0STMBFSFDuMT2LTlpr9rEz2LeSMlTk0c3dvfTUh8eajIK5NuGAv2haEWwVUi4Qh1JZ1lWbNFbRUomqbQ7lLP2vAXeJF5p2ppOimqzMqDwNC+nEc+uK1tpBgl5jBDyx7OHTffLNt6oAhdrdDDZzSKvNs6A7xEFr8Oo9BhR37PMfwbRRwtzOR/Vu0IwcuNHACgI80N0V8YmujaQTOL2urv/iljEA0anXKe23UyoJK8I+ano4rNavZgnNtErpd4x9MdfA5CKI1Tm3RfNh2RxwYQh3a56wgNEOzKby4ZXBc+xg2I5llmujJbED+ms1hKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQHJH9DjTrTc5UUpHxPyoCh+ipqXn33SAuIltpQ+NYw=;
 b=PvYo0z/O70Ydm/nP6N9nNQ0YXLRPlN1TybWrJ+ebSNAyWhkx8rtFXCms4UYMEeB5ps60UDA0ZLMJeF3azaMrbn0vGpjL17zsD8rz38u7y9JMUZZ1zkcNaqLVoJHMPz4Lyc6/9nOfXg1lpsmK39XftBINSZNqMRCBAxoUAPmhWXMLxLCGyqJlIiGosfJpdz7brXKFR10adW9qfP6MUE3DXWCupYFAm3r7XOCaUdzptCu7mJGS+YChqdT0PffTWsz+y59cFbn/EuiDdlM/j8jCzVLz2C2YXwRR+e0JmIIGlof3Hn8CKw/Ez078ONa9qixYvaUOUR5h25fxvcQzyv/B9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQHJH9DjTrTc5UUpHxPyoCh+ipqXn33SAuIltpQ+NYw=;
 b=eK3yQ6DVf002JvV7zWYKgrnXiwUSGxqwe+u3ZAL6PE3UgeEKU8uQ0R/zy3Ziv81qh/fWWF3fdIHC2mFZJLNoSmE9tmEhRDpZkWcxVxwI2cLbaFRXVSYH4p6HJasFAj5n2dXzAOKNpAtvDzDUcrWIc0HvZc4nr53uaKkue8PV794=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 23:35:52 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 23:35:52 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Arcturus: MTYPE_NC for coarse-grain remote
 memory
Date: Mon, 10 May 2021 19:35:27 -0400
Message-Id: <20210510233528.1633-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510233528.1633-1-Felix.Kuehling@amd.com>
References: <20210510233528.1633-1-Felix.Kuehling@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::39) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YTXPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Mon, 10 May 2021 23:35:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21f09f72-2d30-42b2-1529-08d9140c599e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5050:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB50508D39222526D9C24D101B92549@BN9PR12MB5050.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gnQpKM71cD1wpDVMdfw5tKJZoSAta7gXlJiiOpaxN3hvCOeqQWcW5WarYoJsr4GuhO4fnWhzNmBOf622wW1JLxqPPzEWR8DRFqxcFTXPevwnWeeGWidZzlQNKqQhk0/Vs8lUYIyBCmqYoV6ydnncSxWSDeVzXQZhB4FNV90TtIdF+a61MaA55QsGlkJol1qgBKsaAt/ERHmxCzpfFxBkyyaVQ/69FgNjqr1w+PeCrcfYDeMBq1c4bxDSzib5H35FjscSv11y628tzyTHVuIqIzDalABFLeXtIipya2Zy+drrg0FXL8Ibx8ajtgYHhCABYHgb57Gn7ceFAU1+Wl8VpExX97JygoTMDQJITg4jMWi8L4AeH3iSTXhBUFRXkl5qKURTU7KNvufOhI8kPkNPKGbrIqrrn3Ua1XjZS9ZKT+JNjpzGT0lrJTfathwka2UF+5sWTou59wNY4Vtyd2t8LVfE71CVRZ8dmZF8KM7JWLxzqCKQQXAVZpHqglxixKlkBPDAKmBMq9BiK80AM2A0uC0iJESusclYsWLicHVOAJMz0J0muoqeQMYtzWLlxk4iEEi6gbhA+78IVKTRBqFbiJCZeU6Xef3hGxV5a6EeAmKX+tv4h2RxDm1lIfeGQS86kGWRt7SEx/h80+Bwcs6YtuINhVM5h8gzCQZtSoKs13E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(52116002)(8676002)(7696005)(66946007)(956004)(26005)(66476007)(83380400001)(478600001)(5660300002)(2906002)(1076003)(36756003)(8936002)(6916009)(2616005)(38100700002)(316002)(38350700002)(6486002)(86362001)(4326008)(6666004)(186003)(16526019)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1sxQVfnSul8XXCy7kxJUDGZ8B/9OTn+2WyjJO2egljWcQbnjeDpMqFZYzWTk?=
 =?us-ascii?Q?LhGIuEJptKcy1TXN0Oa/GTAPAdIvoMa4Tb4UmZ5NyJtAlZQ+GDX2Hojh193K?=
 =?us-ascii?Q?g8gkhOgNFIMUtonEXG4TaLacS4Cmywgfd6ePfaqB6gXrM6TgFy1BR/45crIJ?=
 =?us-ascii?Q?Q73QvKbNHSNlPh1JtDpfIXySQX0hY3+nEqXOf34zuy2bvRpt3gZ56chb055a?=
 =?us-ascii?Q?WppPbfdtCNsW8aq200nw75hRKtskbWzyvxWifL/rE7D79yZM/PAVb55hxUIx?=
 =?us-ascii?Q?h9j4yNarcGSdBoNozSZeRTdg8//oLUdl987awa6easqBN2rgvGLGABe2uYnK?=
 =?us-ascii?Q?20waIJzygDZGrFvLhNnxvZo3xDPiERyEaFeMxRPFkRAZdINRGljsjFJs5AaD?=
 =?us-ascii?Q?0J6ynHgLFhwiVC5757dWZD4t6arb2SNrhclcrX6KbbMvmAW/UdYXOzB/9Xk7?=
 =?us-ascii?Q?8onMu67zubdf44IXQHKgTYMqcqeRaUyPxOh0mJWVvcNT5kpkeDUdGG2/SXNj?=
 =?us-ascii?Q?tbSlc9G3jCWwPuyH2mNJCBNv3wBWcC97m0oBY6yk/CDM9i1ezz/rIHz39k3G?=
 =?us-ascii?Q?719z+uJEvtlFTHPoksy8zxrfYzp8PlLfxVggVhdeyHA+Pm96Rsw00b5cIC/K?=
 =?us-ascii?Q?Y944DYlFF9s7IYmwdiEJ1WeYg4RvOYBWPUMAsWPJtVu72Tlb+7zw3Eoo7pLJ?=
 =?us-ascii?Q?779tC8hD5P9PgEFlmY5tjFoZTdggqBhQBAT1JDBumiUtvTK/OHuTHX90k7R6?=
 =?us-ascii?Q?jQH/VAupTm4++i8jEA5VcZnu9QcxAkkTZ+Qt8w/FXMjNjOihQOpeEHHG2dSx?=
 =?us-ascii?Q?2aSRyvldGlM0rT4QLcpI1FoIA65r0uUMIOaS29BAOkG2NTmET6TDhbk9sQXU?=
 =?us-ascii?Q?LPIwOR2xcwVW/A4EU5IKlNLdWKKeZFu2CRFoxaGKpUhLrRD8y/oZ9WeiFJrr?=
 =?us-ascii?Q?hMJyTvCKpn8QYEAtAkv5HnjuJifUC4w7qZbQPLAomOwoLESLJj2zNt8IbTMd?=
 =?us-ascii?Q?5X0mWB6lfHxsWNz8JJ8DVbYYTUD5TF2weSx4Mrf/f7EDsDK+HDUOU19kODjN?=
 =?us-ascii?Q?tqzKTOA+ZAKd5P0M59oBZusZqbqLBmZcmGoM2B4u5AbxSGs1mNsa8JILXtcp?=
 =?us-ascii?Q?0pslLRObOM7yY8omoQVzgFK/lvpCBU7GhgB487o1sumHOlv8xZQrZBAtk87O?=
 =?us-ascii?Q?dojlXTavnouHCnvAXKFnkWDtm2F/23LGmNpflrZuk0qVKvtdpo0CySyznXVK?=
 =?us-ascii?Q?HRkjrSb+wqZh2BQHq5p5zlkouwhQTZgkLFHTs1gnnTuhiJxKcWcZPQGoBDBn?=
 =?us-ascii?Q?ZWeiZmHWL59ARsJm1VBCOhHT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f09f72-2d30-42b2-1529-08d9140c599e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 23:35:52.7870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLmrOsHElvO8IG6QP3SF2vfjiWvaN56c5sAnXvy7oRjmuIu4MhZ1vjd03WCiYSaN7sbeU4TsQv9bzsFJGTsifg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050
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
Cc: joseph.greathouse@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MTYPE UC was used for a specific use case that ended up not being
implemented. Use NC for better performance for coarse-grained memory where
cache coherence during shader execution is not required.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index dfa025d694f8..941a204d28f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -433,7 +433,8 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 				mapping_flags |= coherent ?
 					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
 			else
-				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+				mapping_flags |= coherent ?
+					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 		} else {
 			mapping_flags |= coherent ?
 				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index a165e51c4a1c..b11f2b364bbf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1016,7 +1016,8 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange)
 				mapping_flags |= coherent ?
 					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
 			} else {
-				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+				mapping_flags |= coherent ?
+					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 				if (amdgpu_xgmi_same_hive(adev, bo_adev))
 					snoop = true;
 			}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
