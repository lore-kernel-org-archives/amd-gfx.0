Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26404C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 09:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE9564FD6
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 09:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE9564FD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F1B6F51D;
	Fri, 12 Mar 2021 09:49:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF616F51D
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 09:49:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ub6/Hnu2yE0zPZt1VteEjBg4DXWK0J4h8iFrKI8CIBr4REg0CjkwKFauH6KnJLr9yXMg9TiKlx0jgmH+x07x1HzGAB+ORLFTqRZwnjmSNs2KUBL5Q+zDAWLn9bFgTj1Ag5LIG7uIXIUHjImoYKSdNmKi1bTIwswcWinfjaAEO7L/OszuaPAaI08OkKDlsKCkvuZvcLtpdiVyK98Ka7PDnLbMIE1B+Zjdc27fpq8kCBJXneNLpj1bbnjWYJEIKNY5QI7AOYQZmGqHM4xWqTm9dtIcq8EVAxaBgv9ZQ3enhHc4aH2jbX5E1afXRxrWDyUadI67LCxAiUpo44krTWqapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46kGNZZxB3eVacnAHlulhhC2mHNke0vcyGMPmnfEhpQ=;
 b=fXnnHZzrpbDZAy4ShfLtWa/TXdiQG4HbI5oRtZo4aDXb459pBv5q6q8iFImJ8EwbqxFppDGcXAx4EwHS5Pqx+ehp5TVQUS7HVtklnKRJejiwpsXYEOeEZOQcNiZlAzZqPEGLStptZTjjrqAyOH2F5ta6fK1aqckGJPMbfiklqXBqJxn+nz50/Rc0KaBPM69uKneFy2A+nHwzhWndAFOcGCLB2nl6TRg9b3WwuDGF0LlUCYRPnUdX+gGm4mfdxWLqByEJ1hkWtUb+OQ/nU0cB933lHakBo4DKDJv/0ZCS/79oCRit6js9H1xeqR3UQ5rQhfyP8BXXZQCD7l2PDgz9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46kGNZZxB3eVacnAHlulhhC2mHNke0vcyGMPmnfEhpQ=;
 b=ezMgBoJOEn1wLHcGRzukZCXWxIDWcNEvLkEiOzJFjMKkdYEjFmn4BcbdznLXdbI79RG3QCAlBpaOfEH+Kbq/Ge4jX8MCUQRClXQKVaP/EJw5M2RSNb2uEZnjenliNzUgT7JRQAGvDJxeIyKd5pEpqUoiIRB5dswkJco2jbSTtUU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB0165.namprd12.prod.outlook.com (2603:10b6:910:1c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Fri, 12 Mar
 2021 09:49:13 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 09:49:12 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/1] drm/amdgpu: wrap kiq ring ops with kiq spinlock
Date: Fri, 12 Mar 2021 10:49:01 +0100
Message-Id: <20210312094901.20245-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
X-Originating-IP: [217.86.104.81]
X-ClientProxiedBy: AM0PR03CA0032.eurprd03.prod.outlook.com
 (2603:10a6:208:14::45) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.104.81) by
 AM0PR03CA0032.eurprd03.prod.outlook.com (2603:10a6:208:14::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 09:49:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce214f48-36c5-4acd-f177-08d8e53c175e
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0165:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0165FD8B05CF6F697BD9BB648B6F9@CY4PR1201MB0165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7uzwn7yZRJVubV9e1W3CbJ0xJGmnlQDJLet+abhFHydDYmIvPLNUC7KxJbPOYaPH3wHbDCAL4NqlIB56qk9s/ARXXE0QqAT7MH6eJfU+KkWopVaU9q9wbmdih8j6dd4bn/Su8SPn2wvxqASmEDPaR5AnQ9u04ond83efb+EAbd3PGHRRk2Vbv8+u+ReT7SyHn7M7fNhSDGT/eWBaAvyzC9fyfeZ5LxQnj1IqlS4wWZEo+Xca+BwVw9rrWl9IOkkmKMZfMjuk8OowWlEHEHj7VjfMfXSntkIdI12uiS1HQ15ri39w2+08bo+kMmomiTKiiARFeWpI9B3KGfThUCnB54QAWPjCJ+cheYoIMXgbHrOl+MxdRLmgdDKnW15X6o7mBTz6b8bdfMfviGvQ84ZPCc76pkwbY/XT1Lf7rC0tznCC3kCypgA1VWquP0YhtxTZqxpHwFSzmheds5lQfyilkVq/a0fZGFB5ASBgkxxy8o6+VFLwhaHplVxTSZxCPjx7Kd82eoLCiRZmJUOuKL6wQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(83380400001)(2906002)(6486002)(6512007)(8936002)(37006003)(66946007)(316002)(5660300002)(8676002)(4326008)(34206002)(86362001)(66476007)(66556008)(186003)(36756003)(6666004)(6506007)(478600001)(52116002)(1076003)(956004)(6636002)(26005)(2616005)(44832011)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?32biO/Sju5OleXpDgC62wDutuEtWInJUkqwXPHdshsTum7DTxVP1BTzCIUZi?=
 =?us-ascii?Q?/7BeyHBN5heez8Y3uZY4p+C/imXmAV3pd11TjA9puvaUUOrBwQEjEaCNsgjU?=
 =?us-ascii?Q?EpzO0dL84fv7j19UQxSiPiaN6g1wRLy9GgO7rbi+5VnsjIdb3UdDmChBk3Sg?=
 =?us-ascii?Q?oqDtOQR19HArLD1/BkgpWQwdSnSDgZoYUqzxoHXDKBNX83YGJltfNgcYGlgQ?=
 =?us-ascii?Q?nud0bRdoiXc9lIn+tOqowkJxOJ3n6D/tjpn/3s/HSdoL2pnvP5IXBfityLZs?=
 =?us-ascii?Q?KL59/WqejMn3L44a8inMh0Z9SZQXvze+KOdUQnYOJftdClcMfcjxzo4XOuA6?=
 =?us-ascii?Q?yppQUdj5ayaTSLeXrI6XSQ+xgLyS+KeLFRsrKwC4DfuJwcvS1Hn+EK2CSfuT?=
 =?us-ascii?Q?plWh5KnlIlv66UUYPLqV3o5AS7t1qQlPGBU+f8JemFE5Gb1F2r+sfa7i+R+y?=
 =?us-ascii?Q?p2I1Pp2Dcz/Hfn0MANknFc2oZoB2o6VcY4VfYLgusPKR1fZQS193MrBUJcdK?=
 =?us-ascii?Q?Hy+JQozjJZsHc9kGZKd1juagST2ptnhm2wf3VhAApcO3XS4hRyiqPtDVJVMx?=
 =?us-ascii?Q?9OAd5pA33fmSJat8HNMRFNWINbyEbHsTLMpVbtGSwnS/DNZAkdQxEzZB6fTp?=
 =?us-ascii?Q?6MV14ziWH7WzEC6NCKJf6Ja+Gw6wnvLhWVZh8PSYpp2EdRr0RYPlxTM02ACt?=
 =?us-ascii?Q?NbP23fCXiqrelNvQ2Q/M2AsgokQaDq2omrP8fwd8ycIgGInz8tZ/mfJPvUQY?=
 =?us-ascii?Q?9WsYx78ZqtsHRPK/DffVE9ljwD2InwKZqfs/ny2CmCYl5Nq7OxpIMxfD2VIC?=
 =?us-ascii?Q?+Crjj91u5H5Y670R0aFm3Jq9J5ta6qTrWsL1qGmB9e7UsRKII5jsS8qL1bhW?=
 =?us-ascii?Q?AzD+w3Hn0tlxv2tR348mG9He66CulBJTHQBOsTKqZi3UAIYDHhyIz1H3UvXl?=
 =?us-ascii?Q?RPb0ghBpISTvRbqs5CneQKj7q7JGysQthl6kVB0mvt3VcAal8UET5HlXWLJt?=
 =?us-ascii?Q?wmr//C0hEZQlXieZ1tBaSRPvY0twVjEGOvkJTZguzq+lFu31Hi54r4/pV+JM?=
 =?us-ascii?Q?uN34MdMPLj1tYF2tZTY/XagdqluiJ2lMz8HgbC6YATia/C5vyisUz0qd43I0?=
 =?us-ascii?Q?v+Y3HdIm0dQmb9V85UienVnlzOWMOZTRaqPcNC6f7QwEMc5ipRpkl5aHKAJN?=
 =?us-ascii?Q?j+lw9I/Qd5vFHnvRwK/B6vEWyHkb3F2cXtgo/RgDldDGISjftS61N0aHfXCW?=
 =?us-ascii?Q?CD4w0lh18g8I0SE/24+0Gbv2L8GW48V733xYBWBg7vvryR7SJaMV/3UOjWFI?=
 =?us-ascii?Q?0zf76C5B9/CvIRZLVY95P2Wt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce214f48-36c5-4acd-f177-08d8e53c175e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 09:49:12.8540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsf65Tn3cN4K6oqzSI4UWG/YYnkwHUZGHqFmsUJOcQ5AAViUD2V8evL6+rgfhSBaLmr8bCFmy6bINDQuXzUCbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0165
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

KIQ ring is being operated by kfd as well as amdgpu.
KFD is using kiq lock, we should the same from amdgpu side
as well.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 1915b9b95106..8fe370e5358d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -467,13 +467,17 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev)
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	spin_lock(&adev->gfx.kiq.ring_lock);
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
-					adev->gfx.num_compute_rings))
+					adev->gfx.num_compute_rings)) {
+		spin_unlock(&adev->gfx.kiq.ring_lock);
 		return -ENOMEM;
+	}
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
 		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ring[i],
 					   RESET_QUEUES, 0, 0);
+	spin_unlock(&adev->gfx.kiq.ring_lock);
 
 	return amdgpu_ring_test_helper(kiq_ring);
 }
@@ -518,18 +522,20 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
 
 	DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
 							kiq_ring->queue);
-
+	spin_lock(&adev->gfx.kiq.ring_lock);
 	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
 					adev->gfx.num_compute_rings +
 					kiq->pmf->set_resources_size);
 	if (r) {
 		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+		spin_unlock(&adev->gfx.kiq.ring_lock);
 		return r;
 	}
 
 	kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
 		kiq->pmf->kiq_map_queues(kiq_ring, &adev->gfx.compute_ring[i]);
+	spin_unlock(&adev->gfx.kiq.ring_lock);
 
 	r = amdgpu_ring_test_helper(kiq_ring);
 	if (r)
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
