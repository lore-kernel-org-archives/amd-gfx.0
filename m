Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE9FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 14:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD5164F3E
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 14:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD5164F3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C726E5B0;
	Wed, 17 Mar 2021 14:46:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA4E6E5B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 14:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEoZhuUqiosU3KFhL6NKedew86tVotqQRvM262AVq0IY3DMx7GKwrnS51SCR0Ri9s2WuXpcLdaZMu4Rb9pN9lq0z2C9Mw5948/BAOUG5E2MMCIdMk+kePrSc8VFq3tSjTrFe1c0vw8XV/H6MlFnle2HGuQWh8lGghMOPzbYJ4oxQWWfKqEDiEac7nrlLsJVJtYW7fO3nKatt/cNlxHXi+XYMP/fSTeJrmTayvNSVPyZiaDdfkbCABNPvfJGQyjpgz8+aLNSM+MF6OZ7C5P9k8MFEVqF29OGIzqsUz5+gWgh1njvX6PBb7Pb/nJ9MbwY1dzKvS0XdNPo1FjMRMdTeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyvJDg9cTNkhmPOlQgPtF4s+cGA0X0TP8ORZFXEMq4g=;
 b=XVDQaP1UIeb32/pOfKFiUMCiCS2BZkMEEyMyWQ4QF9ulabiqAiJuSSJwKG6uWfsIeUeWgIkwqFq/J5usnYcu5yWX5EQW/+fAqJ4d0HX0DXt5/EopJXQhr7VYygLqFc/xXGXa2kXk1pViNRwhf02edWn7Mp+7ItyWvSXC34CjkJwxVxIFnq4Ht/imEvBXIYOzwdHqSIk+Xpyt520nlJ0P9Hnuc9dFUdCcK1qU9Q6aTKcvby+hKMkxBZOqscD+rhYMXiQHLncCQaU1xXFiAavNBiT1/fPGaiSRyPckWpkabD1BqyaHPzjwxc7lYI/JVEzgvGoagqO/hbHiKm9LcEFueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyvJDg9cTNkhmPOlQgPtF4s+cGA0X0TP8ORZFXEMq4g=;
 b=2n2099grShFYB3HWGwFf+viGig0bVMiwwe33gRKsIlzK1d5y7eijkQrCQ+A9RPGVhZJCiy/gZwTFTHEATTNC6KSLIy37yFJqzf38RxaQSxBJ+kDl6hhW07UibAFUzy7yVSZskrzDdBc/G8GCkdwaiK93WYMo6xqINWJyeWB0q7s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 14:46:31 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 14:46:31 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display/dm: add missing parameter documentation
Date: Wed, 17 Mar 2021 10:46:14 -0400
Message-Id: <20210317144614.786749-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: BL1PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:208:257::6) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 BL1PR13CA0031.namprd13.prod.outlook.com (2603:10b6:208:257::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.11 via Frontend Transport; Wed, 17 Mar 2021 14:46:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 545a5229-bfdd-405c-0bf1-08d8e95373e9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4080:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB408033F3DAB3990E8A7BD9C8F76A9@MN2PR12MB4080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHGgMQob5uo0x2pgjru5+/mKEMZh+NO650j33ElRGq1f4gyiRF7o7+FLfMYdZHvZKuNt0RQwqwzon0Ds1J0vCYEp+BV2YbhyOrgoI+oWSg8MYYo7MPHnSkY5uz77HBResjlJe+oACqLTY9WnDIKmkoX7gw+o3INog2yIIJSJrFt5smqIGiVow05xFDqiGu8IAwbXODdVf+maCBw0b35dapuE4Qgwkgq74lxxDwLQ9hhCYcfaroofikhl8mHjmPlojnWvU/Y85LCkY8cofZETkLJ5wjb4RSSptVkI9ZSBM8GESIdTZApEE2Lli8B1CEXgmV2X1Tqw60nCiqG8EqGlwff/OEzTKPd4RZ6+iB+hEpvKJ6yp/p/OVec7dCafSpBKp9eQW0GD9vSItqUTRQoRkEFKmyoeG9Cj0CIQuP5jPrGoIl8yLzN4gNZ8Maq8lBrlWvcabjwvGJD7FTyf5I14TeskU8ZZS+ixAyaHMDpZVGXbEPatnbTekG+ONtxHZ2CXznFqTRFadFrkyIEwfCpMtvKpqmcxwDNcVxfLTVWYAMZL3YUGHGYPFYccpMdb3ZB0EKZQCs2ZnQEtmbnjSWBSAxE9gQfULM2iJT1V8prMBd9TAK0kCqaG1mlo0L2JBGnU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(36756003)(54906003)(4326008)(1076003)(69590400012)(956004)(4744005)(8936002)(2616005)(6512007)(86362001)(316002)(66946007)(66556008)(5660300002)(8676002)(52116002)(66476007)(6916009)(26005)(6486002)(6666004)(83380400001)(6506007)(478600001)(2906002)(16526019)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?57DaGWxqmWT41JeyZMBKDe5kAOMthi9CAL2uapkNt8Uuhl5e27yqd8fpsPOX?=
 =?us-ascii?Q?igoc1DVnYoEgKnLXIWjx3aKsWsjsw6DlUBvbzJUaJrVZD9wC6wi3IoAlfDOm?=
 =?us-ascii?Q?nQR7X9tjG3XcShp1/m6GLjfDTrqP2bgkoN7tuQAaLj+LF/PrOaAyh61ytDGK?=
 =?us-ascii?Q?lG9Uw6BHzgi9g10r160s/jFI05V/bAymJdTkGmWtxjqJOiOBHe/Q51oVejEh?=
 =?us-ascii?Q?M/eU7GSqZnABa0SFfDZ5+IXHvr2bKPKM+bMNuOiAaeihd4bnDMLdce5KB4v1?=
 =?us-ascii?Q?8ooov7OrnQqmBnzSpwwPOZbQL+AUbkxLVtBbr4DtDlSxUY0NxdqH1WlDRXXQ?=
 =?us-ascii?Q?+I2S0SA484DavYsR44ocwOlKUZQx0IDIjr3oiyIrmERFySsHfmUVOhbYz2/E?=
 =?us-ascii?Q?mOqVfjsZazoyzCNnrvuEImpyc0eOb4bVdokrBiZ1SX/fmEel7clPRM4oS9se?=
 =?us-ascii?Q?ornVmHVm+HX3Q2KnqLeEMOekWl24Uc/QB0qcR/BhAG7foTBy4UON0csIpWIO?=
 =?us-ascii?Q?3gtUTdJt4LPe8n7FDz2FtsNa5oqaQNhze+Uh7CVmaet2fJ93ohk9yG6IOWWY?=
 =?us-ascii?Q?zgKkSqNFHkPruBS3yhFXnCelc48IMtLkF0NZjc0vwNXk1/bOEku24BO/qtAa?=
 =?us-ascii?Q?NBCCYvRqWZP0WaPPEl1UNGz3WilM4JW9v2E4TWK9EpecefA+HiHaIXAZSVE/?=
 =?us-ascii?Q?O6ifhZg7omojgJgBSjRSoql/cMD6+Coptn19VxVlB2MI0M8O6CXOoop1i9M7?=
 =?us-ascii?Q?xRpx/8ZtcOTktGDm25V5zFQTS+E3KufQkg6grk50TSkpTtPjwJmgHjex3TBI?=
 =?us-ascii?Q?JORycu46bpDNeSTS7xhVgDJda2x5jOiCzLTKjOXygaILHIO0WkQQCBaCvekW?=
 =?us-ascii?Q?b9v+22tLuvttVaC+qp2bZmBVr/q3mEh+RvLA3Sw9B5Pv6F8q9AiJCgrXwYS1?=
 =?us-ascii?Q?ihTRwvFfzZyM9amLm+yXV1NkGK3TncGjuWh58jeoNdKCaeYmi0mpP2UdAKUR?=
 =?us-ascii?Q?zbcBhcZGP4+X9BMkqC2ZV4NDwivLGdxGAigzxATW6Lz93GUgiYmvUvlgVu9E?=
 =?us-ascii?Q?MTEDyrSv9EoJ/7yGTHy2fH7cTuWxEH8vh2KxYfdqUUPGGBU9I9v74Aq+C3tr?=
 =?us-ascii?Q?Ag34/jT5tOjL1xddjuIc4DhcX6qCfJZv4FcHnXKf3+aP3Q9NdCZZPPVvzHXs?=
 =?us-ascii?Q?8OED088Icxl7aUgxhBCOIGPO0Ojozb04ZLSq+FFosbzd1Cu6jb2UuTn3t2t5?=
 =?us-ascii?Q?RyBbJngv3Nq+BEFtxorS1jpOLjRZhMmw3gM6piYlkp4xWt5b7UTtJ2jW7Zgm?=
 =?us-ascii?Q?gZpikN/YR+bFXCFrTjQ7FBE/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545a5229-bfdd-405c-0bf1-08d8e95373e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 14:46:31.1783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nteexmLe/fZKCLcmtPwqeKEkYgx+CzSMI3D3ToPdFDsCEmdkNNkHee0T5j74F+6m613F7FFAiJ2HRAjPLJCJow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
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
 Stephen Rothwell <sfr@canb.auug.org.au>, Xiaogang Chen <xiaogang.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Added a new parameter and forgot to update the documentation.

Fixes: b6f91fc183f7 ("drm/amdgpu/display: buffer INTERRUPT_LOW_IRQ_CONTEXT interrupt work")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index d3c687d07ee6..a682b070f12c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -73,6 +73,7 @@
  * @handler_arg: Argument passed to the handler when triggered
  * @dm: DM which this handler belongs to
  * @irq_source: DC interrupt source that this handler is registered for
+ * @work: work struct
  */
 struct amdgpu_dm_irq_handler_data {
 	struct list_head list;
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
