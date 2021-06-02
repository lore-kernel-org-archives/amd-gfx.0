Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DA1C47092
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE4061C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE4061C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F5016ED82;
	Wed,  2 Jun 2021 16:50:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50C8E6ED82
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCS2Xc3vMRN2bLW0xllWgPTFgi8RSBJ1wBzEA4hCfp4niE8cG8/MSYcmU3qep3rwFno9fWX3OH8t+9t6fqCtV6rAnUURFfXQYd+Se8ABOYIB+s6lB8YU8pWCde0SJzDYVq89DEA74YhDNNPydEvcq+PByYhVDYgDAbopsi8C46x33xi0UpjoN1/lZtJWSnR8Ildj1AAA/jg/q2Nr9RnDwwwQaCZH9ltEMY2NDyTpp/zWSCkczq0pwnKlVp/nnDgpRVQbZI5sH/zfC6TIBk/koOn7bQZCi4W+EztnxmjVXd/WotRioFemFc+Fa9R8nKyCLF39U1OKFAja74hgJL4i3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nkZaQ53dJ0rQRcBoOCF1hkJtQZ7SIjh1wVryQFghFs=;
 b=OHqXgkuwhhqHRaJKD0p5+X4DKN09DBe25aRFiFHH9o5s/+LyTgYpqlLNc6b1PZkTIE6XcI8clFWQZfwEK7Szo/qxp2yAbo/ADsLH9UhXi2zSTjLmYGGFvQSmS2FksB96G/FoYOMDqV4yCBuCw+whycNbqiphQ5wV/ZGx9W3tnl/4e92VVtB44jNxWVxlDuxSgEobY9TQjeaXOk2K25T0CzEQ/fz4nueBa8YLbAMY/WeaCc3PJKzsx1/uIzD8s2O00SR1UP2DVOdgASXlav7xU0iIjn/+zDspuVI4wiT+x+fQAVNW+LBQtqGC9/GOFRUYAevPhoXvZ9GER4JyB7H7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nkZaQ53dJ0rQRcBoOCF1hkJtQZ7SIjh1wVryQFghFs=;
 b=t8mrH1+vo42pGD7ztKd7eOhYlQxhmn6JLAFezQGZwbLNQZmsWAD65iF4/Jpv1dPzyyf8f069l2fbvtXR4syZkrqMAP9sYP7MqFLfJ+uq1LSV2f90s4R0mtGvrUG9OeHAoJhqfG8iV/PiUyuHzSldQKw8iS1MkNEtZuJ4SRZPEuI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:50:23 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:23 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 33/89] drm/amdgpu/pm: enable smu_hw_init for yellow carp
Date: Wed,  2 Jun 2021 12:48:12 -0400
Message-Id: <20210602164908.2848791-33-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7079a268-e820-44e6-5d6d-08d925e6710b
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB467522DC2CBA6137BC611331F73D9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /aC/Pfz7jddNyaHSRLFQ/eef5GC1ngo2C88D3iFkyYF0M5bhlGd2tn7fXyARmypHhSfGjJsl7cfRS6rgpIIpqtNxkiMIggTRxkv5lzs0hi9ynfZkS7Q+qvuPF7HqSFU9AoCttGoWKwQY1Bz/tSvR9zxBxsJCTYHtSea8cOzIK1g7iW/7MQOM9AQ3LUfExZU0sJvTiCPdOk+11qHpoMxLiLayur2aXVurgkTSQvF74tR2hLdC1RWBhuykbXzIWnZjV48NeyB6nxnDNjDRI90Z9beU1untNonAjPoSMKZ2YYWg+32hKgx3bAFIO6eFNOVAb8HHpk/WeVTfiJFw8V55ptuXuM5CZzbDBpckO+TOeFykKyyeEv940jyf4aIjpdHSI8+uCQfaURaABvL7eJHLSXVXrSOMDXdw3U94F32ySf8p+gemzjBdddtkJ9d1JF5eA8CXn0v84vdMnfPK3/8F6jQ62v3WdStVh935StKKjFBi4fOnHS577n3xCGLoF/5slNcW5lq9KeMNHN9rQyMF9f7EAvQCOqauaP/FGH8FkCWPYdQSsW3xrVqPHXtx0CnJNzexKHkgniSj9/hZeRaD+fVRBCMnX6cMaGOYjTW5dsiQS9v7JI1IlICKV/FK79yUBjAypqYhsCSSS2Atbtr3s49NWt8QnnGIUjjHZDumXlBZqVTNtNutsPoOwI+wzBV9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(52116002)(6486002)(956004)(6666004)(26005)(5660300002)(6506007)(2616005)(36756003)(4744005)(6512007)(478600001)(38350700002)(66476007)(66556008)(83380400001)(8676002)(2906002)(4326008)(86362001)(1076003)(16526019)(316002)(186003)(54906003)(6916009)(66946007)(38100700002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4OgxHfrE00Bfwd7LWkE6UI2PkzjpLDFxHOn+qnxXSzHwlBd6To0eBuE0VyGJ?=
 =?us-ascii?Q?YTnJ16NA1zCfAWmkY37x/fHpEtJZum7eWNN6k0ixGToJCQtvqU3nyIhmyqh2?=
 =?us-ascii?Q?62fMV1sSLNa02bGulIgZZ0LNJBbPxM40dcKvGBSm9vibSr1RSSLqrquhZQHG?=
 =?us-ascii?Q?4dev4zJoNExlefNJeJQg4gQOISAlKoHu2FDm/fu0tHdf4X02WbDJMDyMjvyj?=
 =?us-ascii?Q?Hfb1MPAJA5gV+pJB9nNh6u3wjX6Lu27+b8Nc0fRzG45SxrbceG/TbhfvuMBc?=
 =?us-ascii?Q?GVk0BkE72FU+IgcnBSQhoTBQWTwF3/LLcIUFTvj6jt5SvGngOlBka8nKfOua?=
 =?us-ascii?Q?l4XWKWnmq24fZkq+i4wTMLw5xZ7EbRujDdrdnvLKfeTrp2+D4NCTaaLuYH25?=
 =?us-ascii?Q?NuMdh9cRB/3hJ92vr+A2qFEQFxAHjsFWeCVENa1sFuZqkJQyEtRqNfI97GZl?=
 =?us-ascii?Q?cUSZ+eI/ZpcGn5JljsYkIjfEUghb+0YmKVQhc9vYjuHEIRfz6p7/DhrqXXrM?=
 =?us-ascii?Q?jteM0eMQGiXrWfP74kkZ8S05/MWSvrYrp4MzFvTdaN7ra2o4VsTJephagoVC?=
 =?us-ascii?Q?6dPQY4d3ndzQxalfFM/V5UlJOlMO/aMmxD4oO+vQkcDcidzUxKHJXu07LcfF?=
 =?us-ascii?Q?AxpKfVyzjJT2Se6rG3ic6Jw1YxARPpMLV1QtgLSFbA3Fw9HAbNDFP30T5uFd?=
 =?us-ascii?Q?b7Gdg4011y46LOF7dUT52dB0/noEy5T6kPDIs4QtpOpOMQt1gkLgGgQLKNrB?=
 =?us-ascii?Q?kav18Da+IRi+YWMaoFq2xrtAwofNObsJ3QaNxpjo1mK6/kGKqPP+SrAmKYQe?=
 =?us-ascii?Q?rHspY0+EVoWa1lfmP2jSad6xXC6+LH0A0TwdTfavEpgTtIJqgx6IkhQjuSo/?=
 =?us-ascii?Q?0sc4IKQAEzoE0EDnoZh4nO4/hSQqRsfu59kQiBX7hUwIBZDO6PDlXnTxXpaY?=
 =?us-ascii?Q?G9YrlMYy1VuESZSQBFIMy3vTQtSwDPT6QHHoWmiDZ84NEto5On1WVQBP/Ctw?=
 =?us-ascii?Q?3pxB/QgyDWSkSKnSYmPl8m5O3YzLdmk3bTBz4FA6ZT4LJ//wHL65xl1GPKaM?=
 =?us-ascii?Q?d/joZoHKsUfmuXyZbvIi3kuLfwvTGYva3+1CC1leLuAtJNZV7leFd3tsBDv3?=
 =?us-ascii?Q?7CwSZOqSCpdnHc7GJmtwEJrF1+Ps8o/Dwb62zgtRF/qw0KtvCOniiiBST/oo?=
 =?us-ascii?Q?1SdtdBtPGuiUCoauaaODkcQl5Buk+DOEsklGfsrYyKmmPnOZB9hbTJgyng/U?=
 =?us-ascii?Q?16BtZNtqAyh1QNy/D1SrN64SknJxu5+SDzbx54q2dSb1tfK/9J2lMg/3wTCY?=
 =?us-ascii?Q?8+XdgAmtZ2gXg/OlJytnFn73?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7079a268-e820-44e6-5d6d-08d925e6710b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:52.0365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ou2HqWSIUb2IT3z5u80NhZeEEpuXv3i+WsrlVFddD3VcWdaEc6ZbiWvtv0NTFt5JbiZm8mX8cNaInMbDOwyKHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

This patch is to enable smu_hw_init for yellow carp.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6a41f78ac376..bb2c42d8afed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1310,9 +1310,6 @@ static int smu_hw_init(void *handle)
 		smu_set_gfx_cgpg(&adev->smu, true);
 	}
 
-	if (adev->asic_type == CHIP_YELLOW_CARP)
-		return 0;
-
 	if (!smu->pm_enabled)
 		return 0;
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
