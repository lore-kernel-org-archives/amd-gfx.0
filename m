Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C59C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED0664EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED0664EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2411B6EB8A;
	Wed, 24 Feb 2021 22:22:00 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680058.outbound.protection.outlook.com [40.107.68.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 073716EB7E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXjFS4mdCe+VKBDrO/azG/0zGpGBVEtH7vs/D3WfT9JT2pQWvs5Ckm1FYrVzN27za0XNnJSWzbTkxx6gfYTJTemN7RZyyUtzuDIpG0/eFw+dXDHCAhv36ASbdhUw6f+ufLtpAH8LLJOsBpUYYiBxD5wRqrQnDWEYdF/qzH7uxl87lg5QikeghcwqUp4oXlhePByTXGPb7UH4U3KnbB+7HFVB37NiChPKKg22zvefb3LEN8fFGSGxxHv3tAcZQ0L7uTJ9mOUPt5p7OBsy0K1fgc20T5tUd4HK3RVNvIcuog5nSdG58DK8K3m8gu8B8HMXqaQNPpsD2zbDzTDuNnQgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPc0b+GgE/Oye8Z0F3YqRmQU1bbXQOqD2qIc+Ztp7LU=;
 b=jpIJSMYL7VVqb2G7favWA0kxOQ1TlNFJtUcfEPkwc9WF971o9yp4mzQS83KcbySkd6tnXvtpGa8d7KDzN5wBUlw+wFcWBytchWsrYensA4UmC6dqx/taz9nge4UuIE235Ep95GXcHmPWiOLj2FM+PQcpR8ox6aeIcUDZW2hZhMhkF3+DvLNF/RwrcYCFLJyRcHp3Nsea2K1pYHo0Z/RIFXRwX6mP9F2QYUZPjwKoAe5/NmB6E1ghn0QtDpmWqZtleZsSbDyvJaM3n7hCm3G2Tvmyr222Sr6I7Nk9YVZwCckFHdnCt1m0qg5i4d6ly3/7OPaw/TveRSNArxnoFIV4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPc0b+GgE/Oye8Z0F3YqRmQU1bbXQOqD2qIc+Ztp7LU=;
 b=CBPi9CJe3VLifjXSjD2hIMjPMiTt5pE2acpFYFcWXqNDt5S9SDiqMoXZZo9PkU38SD62QWQD7Ic5GZyC5ZCzgdWdhr5XVDIhh9wXC8MH1XnA+KQSG3R80sXDdp+fFtSBnHtyXGq/XkbGReo9fQHIdsnjw7tXxHVfqsNHB9B8h5Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 22:21:48 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:48 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 118/159] drm/amdgpu: Use free system memory size for kfd
 memory accounting
Date: Wed, 24 Feb 2021 17:18:18 -0500
Message-Id: <20210224221859.3068810-111-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d989972-9aa1-471b-f2e8-08d8d9126d5e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB450343625FC5301FA889084EF79F9@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrxnsdceXVC1RHlc2Q+8j6xQ9kKKSu+8kxbGWORJaicr5/wfnE51tfzlPKvPSSykkWHnl5/mrxwOHl24b8HGEoWIa6CGrlDpIQa8qnVdnN6xKG72UGSVuHuaiAOHuSH3XBrM4MMOB7SlQS8qyQE9OtR6vAlP1b9G05wo38llk7SoRKyGGVCNlvgbgcpuo1kFHc3eJlUTIMkOewm2VMzjBc4ExqPrloX8NjZu2s9805HohR5k+3y8t2t8kKpXl2wV3NKBGJqc5ZslXIPOxS4EqtkYKgy2qpEgtG0fTSg7CFAE/Ap8JwuumezmhuANbJjwJxq/dFGgE8JS2AkFlxeWs0n8o7d+ZzprSTHhOrqTFdBVOizUEfFQBK/Y9x0RGC6AAlFzsecT3Snxh1gNzRDBBxmfhPqJcNpdj+cW7ru0Sy12+VotjI+4D8kHYGyWVZeAi0gbgcgV5PpNeh6AQVg+rjn4XnDav5AmG3Cna/uUXkssoGPMW3AVxq1fhqH/Qvkp2G4xlVXlQeBbDyhdBVt7ISM1ikGI3dog2lH6Qx7AVo7eVr4ucSnq2f/+b21X8IoHCI86I+qBL8ESCFDRHaEmNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(6916009)(52116002)(478600001)(5660300002)(1076003)(4326008)(36756003)(54906003)(6506007)(6486002)(6512007)(66556008)(6666004)(83380400001)(186003)(26005)(66476007)(8676002)(8936002)(2616005)(316002)(956004)(15650500001)(2906002)(86362001)(66946007)(69590400012)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mN98WiMGTo52VdtBc1dN7xSM1p03bC9a9QrfcdZUshcJJMKLSgCC4NiTMJnl?=
 =?us-ascii?Q?k38TXEd5VEJdsTojVFTCO2YHcsk7DGlZfJEZ6q5yi2N/+krCCKjxdskL6Svs?=
 =?us-ascii?Q?iSbeMFWHyYiErDpDDgmYjrHIYZFULj3VwPhgrTuFlb4NDmaKARMUQTSUPiGg?=
 =?us-ascii?Q?MLkPq+tsVYV7utAEvh9XxFvxznzIJ+pWnfhW33vbPWUPOAExyzOvBTKGvzLX?=
 =?us-ascii?Q?PzDh3jT2fl2P6AIuaUpSbBUYaehESKDmADUnbhT046iTdFK2UdUVD8MHazed?=
 =?us-ascii?Q?VHEnhOBOukaa8g6dWNWGhOl/c+x5VdjG0AAx1uvO88rtVcguUySny5H3DwFG?=
 =?us-ascii?Q?pKhTUTx30TR9/juCVaxX2EuEFqKoBuCimbEGeQzO0qMhAlsHcDMcnmFA6HdO?=
 =?us-ascii?Q?Bxs56iSb0QIOLO4g9FJCa73aUOv5BOmx183cJIW/LjAIev0SsZmuPQi4ZcCE?=
 =?us-ascii?Q?EdqDdbuDixTa5nF+xFfyVvulwAEnpxU/IIjiCr8GwHxfRXjUnphfYe0va52p?=
 =?us-ascii?Q?QZYru5e1g3zpEh9rRjiZJpFuCb1nfLON/x7gteo2rlM6aXf9ntuZQKkEKBde?=
 =?us-ascii?Q?TNq0aPS965azq4NL60vM6pFgr0O2uvpnzK8rxjfXs24/P/4cQr5cHKzPMeP1?=
 =?us-ascii?Q?Tm6lKoUr1TBzPoDNnd6kSbFw//KOiPcIpthGT0+1iwW8PC0f4fJpKmHtoPnX?=
 =?us-ascii?Q?kbdr/s3EN798xvbRqNTxJm+NbulzUODTKZUiO1X3f3YY8ltRXbsS4jrSA0b0?=
 =?us-ascii?Q?Vjs7tA03BZP/z8Qn3gW9x7RBZbl4IrzauHoACKOflKTabFwAj3KRkWSc0xRI?=
 =?us-ascii?Q?8N086Ut31jBcI+C1xGPlXRrYBooYLPqFjr38/pa8oY+MyMR5mOkE3d6tGmE/?=
 =?us-ascii?Q?ypz7jak13g161RmHgcg3Sm8+eADugcpVJ8uA/H28eIsvh58IfHd4G3Ki7j1h?=
 =?us-ascii?Q?YKH3gMwVGD2aDHlobzZSr3MBKlowlStXQ/e40xXH+yjcTc9Lh5QI/c8/+zFj?=
 =?us-ascii?Q?snwGOku3PtoAgNzduo/jfyB485KtMpRk3EWIt3RwdWqP5OGnFyycHJDZsuVF?=
 =?us-ascii?Q?JuQl0yAKv1y5LyECfDgr4WTShcwQKO5LIt0JQp6kHX20g+inM7B6EfLOmPE5?=
 =?us-ascii?Q?ddb7rbtzFt+kGAR390c0P1O48YdtPl+vU0rEI3akV8yRNyk7Wrs20+ltQo19?=
 =?us-ascii?Q?S6COKc8fNaE+E7GRm9gTkrURFU1OHTg4h1aee7V/bX7ut235iBf27mle+Xtc?=
 =?us-ascii?Q?gGyUCFCspKVB5iXe6uhlrqIwUTR6v8mr7jyPi9JNGLUjVpbNKHDnFC6ZgCiY?=
 =?us-ascii?Q?HxzqllGSqBhxQT1qiYtFi+/k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d989972-9aa1-471b-f2e8-08d8d9126d5e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:44.2613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjPi0wZyeGRwHymLBEKLs1ia15DCoVy+XEU+3jGzraEW7pA+haAe6xnYcBewxCWb4JkP7eD7wYFFMcXkH8gDoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Oak Zeng <Oak.Zeng@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

With the current kfd memory accounting scheme, kfd applications
can use up to 15/16 of total system memory. For system which
has small total system memory size it leaves small system memory
for OS. For example, if the system has totally 16GB of system
memory, this scheme leave OS and non-kfd applications only 1GB
of system memory. In many cases, this leads to OOM killer.

This patch changed the KFD system memory accounting scheme.
15/16 of free system memory when kfd driver load. This deduct
the system memory that OS already use.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Suggested-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index c5343a5eecbe..f44185f512de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -44,7 +44,7 @@ int amdgpu_amdkfd_init(void)
 	int ret;
 
 	si_meminfo(&si);
-	amdgpu_amdkfd_total_mem_size = si.totalram - si.totalhigh;
+	amdgpu_amdkfd_total_mem_size = si.freeram - si.freehigh;
 	amdgpu_amdkfd_total_mem_size *= si.mem_unit;
 
 	ret = kgd2kfd_init();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 30e41d1b3256..a74f21889f48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -96,7 +96,7 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
 	uint64_t mem;
 
 	si_meminfo(&si);
-	mem = si.totalram - si.totalhigh;
+	mem = si.freeram - si.freehigh;
 	mem *= si.mem_unit;
 
 	spin_lock_init(&kfd_mem_limit.mem_limit_lock);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
