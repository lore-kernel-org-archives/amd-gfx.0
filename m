Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F14C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 10:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AEEB20714
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 10:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4e6klCq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEEB20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D5CD6E11B;
	Tue, 21 Jul 2020 10:29:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDDE76E11B
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 10:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvoL0xpCVuvokXP60sDyweiUBd3t/BkNQGcC0QHHqhRtZ3+cV/IYa3XqS/4qY1PUdqTMoJ8L9HpWXTSxM38pq41sJyAExMaHY4/93rlmdZk57OHwPos5UKw69Kt2u5IfHsaNpKlzrx7WqWaVXWmjKpSu1+zt+vcU237TAO6KVga42bFVe9rP9N0x4oVz+6bOHEIHlHHNEW44AHPLZhwGZZvw4moAjUU6hdhuGsClhcvynEoLQxkWEylXxWxU/tYN7bx7dr0PV11faD6jH2PVgPdb7aTVyYxdouiH39arIwP9QWvJC8JCu7CVbb77w2fHX2o3CH2+SRLr9G2Xz70rSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNjeCukexbP51bC4SgO2RM+HSbj/nbe4kNzhswv+MUs=;
 b=dIAQ53b/02lKJ3rlSemi3O3bmpD5vcgOMe3/1OMT7z2MmuR3jmwnaYSVEi7LXf18cjAU5mlPyfZQIAnLk20sRZXFnyOePV1OxCpRTOy4tOsLWcWy8gn137o+B/BL0VzIP3TkKKScNVPWpKaOH+JQhHOdDHzLgn4UBT/FL9ujUcZAwEP0rCX/B+EKr9herDWow4f1Xqj+mAKziiLAIJ1nqLLpFYBEjbTb1v1ZnhpFq0suKyuGOiyO9LlhIq5jmf9qlNhTbu0NqcJcqaMiutZvHgA8Af93+E7I1UECYaNRsOj2iv3no8bIhjBCiXhOwEw9ZUvpE5pQXMchO1iB8MAs+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNjeCukexbP51bC4SgO2RM+HSbj/nbe4kNzhswv+MUs=;
 b=4e6klCq03dmx+HvVUs1JLeI7ST9mvHkSxTsVMjaQ9iItnjzHyRDipuifdsU/fVvU0z37pZ/nRsnDzdjZbZdsVPaSj/Bkq5ndSm+EwlPn4dK99+X3Pm6dDlP9XR5NN1KmwcpycN0TC1anaeYwo2ivb3JwdfL4bc0+SmAYzv7wcJg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 10:29:34 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3216.020; Tue, 21 Jul 2020
 10:29:34 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/5] drm/amdgpu: cleanup gmc v10 ip block
Date: Tue, 21 Jul 2020 18:29:14 +0800
Message-Id: <1595327359-120379-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HKAPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:d0::18) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-intel.amd.com (58.247.170.245) by
 HKAPR04CA0008.apcprd04.prod.outlook.com (2603:1096:203:d0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 10:29:33 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c62a28ae-2208-43d3-9550-08d82d60f61d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4144DD4854A393B4225FDEC8EC780@MN2PR12MB4144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a2RNs3s1yZfZUJ4/jDX71pLjY7XDCipTPNhs/jYWiQBSGYrKgAq9VtaYYj3tj5yc5jkVcBNuBD0LTYk8YLNMzMHySewWkx34zWh6kCd8V9+2eC7N2j2ICQlj5T04/la3fImyafe7M2jvBKDn25Bo0mm9JQqsa1HS3+qFCuYZPsdmP/Rny5miywmMYEtFINY1ynlowBg2sMUZibpNStjpGNobgLKe061jL5YWcRREiVSRiHl7N7bcUnUW3zmMs/Vlp++tOQyQOkG2rpN+XRWxyhNAZ9Axj/GtxhvTu6tjgnV9aw5JjVznmwW5qOLw3DUIQMiZ656e9KEbcNUs6ArBlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(956004)(2616005)(7696005)(26005)(478600001)(16526019)(186003)(4326008)(52116002)(6486002)(6666004)(2906002)(66476007)(66556008)(36756003)(83380400001)(5660300002)(86362001)(66946007)(8676002)(6916009)(8936002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cjCWSjCzH9f1qo6NfsSuyVHMxCEhos87hNrtUsx8dUqIfI3zwrRf5o+VyNvqqAu5Wmk9DLJeNJoBClga0zAXlDFEbAAX5BV39ugX73rhY1doWQTWGvVt8WkkYafNICoqyd1PdWRmdlgpslSNZvoc1liprUSTvELb6zBm7fR7Ozln6yzQ38AhX+fVTjS2bJ2VtpQZ4DvgfASRyVeWE6dUkY2dKY/ybU56IXSK7DfDPTpFuFPLATglAd3zZiIqslr0rsSJF8ToqsawYsqli3MMpJkt/1xnL40SCO9lR7rVuAAqgaSXW95axw8AGOG4219YNYG8rgrvHNa+HmyjBxeNgI8Aw4+2ViPh8wA/GT+hkhTAR1SBXg5zIR0w4ub2Klx1tWYGL2+cv1hIou3qL3nlVeBI8CY3OXRjWzkLw02tTJ8JXEJSEM3BaCGL7tTAIMpA48larAOAcePQsfJaJSqCQFJemNEJKXAlUUIJqWas7PI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62a28ae-2208-43d3-9550-08d82d60f61d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 10:29:34.7296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqw8qtfhVUb8uhIomZM0xBpgBcd6qO0g354xNAVp6sM1WOAS0Wysezm840N4tPWANkPQOdxqglNQzNWDgfnY3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
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
Cc: Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GMC v10 includes gc and mmhub header files. It's not good to support multiple
versions of gfxhub and mmhub. Because it may bring up the register mismatches.

So this cleanup is to remove gc and mmhub headers in gmc_v10.c and introduce
vmhub funcs helper to move all programming and accessing to the gfxhub/mmhub
level.

Thanks,
Ray

Huang Rui (5):
  drm/amdgpu: add member to store vm fault interrupt masks
  drm/amdgpu: abstract set_vm_fault_masks function to refine the
    programming
  drm/amdgpu: add vmhub funcs helper
  drm/amdgpu: move get_invalidate_req function into gfxhub/mmhub level
  drm/amdgpu: won't include gc and mmhub register headers in GMC block

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  20 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  14 ++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c |  63 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c |  63 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 106 +++----------------------------
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  |  63 ++++++++++++++++++
 6 files changed, 232 insertions(+), 97 deletions(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
