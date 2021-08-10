Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26820C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 03:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB93160F6F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 03:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB93160F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600EA89E15;
	Tue, 10 Aug 2021 03:03:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CB0489E15
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 03:03:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAu8zLijwJqJ7liW/N7anQmZBFxUMgH7glmB/aVoU99Vu6bpQq2kFFRZDipuxPzGwPZqAbln/5xI4g96xoQNjgmjUInwMrnTPBy0mIyKyEhCcAaWMG4OeI919TVMDqj4DmFhsZmie6qwhvVVPIvxKISa2hBqsflrfT5aadii19qq2+BVbINfLrlNKvfMyKQvWuqcqAGMwbJWkrdr4Iqw10H8uUXkxMHIdBOvsnhWHKF7xRBsuV1YH3mUOwWSACZgVJ0QGXYBCmSBrcha6RD6ftIUgIvnPyxLrx7VH9yjSAWBqrgi6tWJcJXQXk0cE7OF7GTcSyJWsYzX6PxcTreNxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyW3pLXOFmkvz6MXfu1evar1A8hcxKlIYqElJiPEgFk=;
 b=QxDLr4xmCVgSA16RKTn8J1jKsAfmgOVT2DswlFaGjzn8D1QAp5JpEsmtdvITkKMVYT5wEARAkJE2Kk290+W0q1W+dlIU0qY7u0s8vrwaxMQKFEXWyQyL3xZ9G07bGalK0WCvTW1T9D+NtdCbuEy3O3+mmBiTydtzo8cg81+acZTShEOoHZiTuF7oDtP0JWhT/U4Sg4T+MG289oex6YRGUVpnI0k5lEwHDglpTtLZ4saYYAMoOKuUql7iq6fJ4Y9dI8G8xJdrgeaGbjTLOc/Qo4D/Lggv4aTPK+orwg9dB1Q6t08maBI0s+g7OC5GNw6n2mc+uwnJ68EDM8ShGiouMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyW3pLXOFmkvz6MXfu1evar1A8hcxKlIYqElJiPEgFk=;
 b=sP6OhuueWe2BXscLqD2/JKH0DqVaGY76lsBdPlxyzQAs5ZYywCKiNZS/iP27KibPOiJnng2NC8/UrDCSWmTKxh4TF7GBPK5Sou6Qn68x2RzkcFVoifIewENYjPbrWHmV0iskxyeQUx9O1vtqzLWAnuYTSYeEA8664AwgVvNy4bc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 03:03:32 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 03:03:32 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	James Zhu <James.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu: handle VCN instances when harvesting (v2)
Date: Mon,  9 Aug 2021 23:03:13 -0400
Message-Id: <20210810030313.997451-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:408:fd::24) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BN9PR03CA0109.namprd03.prod.outlook.com (2603:10b6:408:fd::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15 via Frontend Transport; Tue, 10 Aug 2021 03:03:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dac4ccb-78f4-4d35-e06d-08d95bab7004
X-MS-TrafficTypeDiagnostic: BL1PR12MB5269:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5269A6CB782AB9F231996177F7F79@BL1PR12MB5269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43Rab+sS3BTsuw41A3Lk4Zrivbfl41KUYMPK3bwksaGm5iBXhH79htMWGLi+qZ/6NzPJfQecDykXuyt/t5daQ1Fmy6otFn2fpi+Wte/JmYvJPxxYw8ZwNuXKJC7GyYgtE4lPJwg0qDqjQiT6nj8OWXuSNv7f67pHvVIWeUA/6V+yoJp0e2J1ZKlK6JTjenDZJOlljBYJyDCMNQjlF7xCHk4haSBqjbuQ5GQjePP3GSaQDZibN4yALIWsOHHK19sdKH4Ob3aXAKTGYccwgCUFCk+J7lcwslx7Y5f2zWXM4+oGV1V3nXvmSlLII8qjXrSJqEcoq4+9bQzMOlQQAhaE5J4DlBNvSrn7GX7w4CiNigOX3kX1D7bDOtQfD7S2YXIOSh7kzF5QEdk/syC0mMvThSDdaeO8/BxvYgBejLxG/9QCiR+E9c7T5G0/nX5q/o/vF8VfAwjx0aLnLsOLj2bdeIhH8Qrss7fZrP4V0/bX5HHgU9oUHOu8l+d6Oz7J2DMVKAz0sPRNoPVPIH/DoghehTCR65qmX5nEZJ2Owj+ek1HDBPgvPtVIq2qCcL2XhTXreNPakSQBWQDNnObsvFbaoAecBcAoQvim4eB7GmV94UFp1HEMG3m2wiSb/jK7VYyK3kxPy7ze62EJqGj+G+iuHdaSAdGDLWU8k2wW8jQY6J1wKi52kwEpLlSzDQNLeWhyHTeUqtrHhb9cRns0PsmN9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(4326008)(6666004)(6486002)(8936002)(478600001)(8676002)(36756003)(1076003)(966005)(7696005)(6916009)(2906002)(26005)(52116002)(54906003)(66476007)(83380400001)(38100700002)(186003)(38350700002)(66946007)(66556008)(2616005)(956004)(5660300002)(86362001)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qvE4az/MTOdIXMft2dFIks2Y2WgP77MbiOu66GDo0cy7Xe9+3Ky600iNp87o?=
 =?us-ascii?Q?ygLJWsancIFOmKLBaqNg4P2vDxW5yvm9ArFi85yiAlzo0ZIDBsmFsPZWXbc3?=
 =?us-ascii?Q?HbaHrQJGaZ2hkpWzBqxXQ5YEClgEklZxharbXIIKsUdAcpY1TUHKx52zQEYe?=
 =?us-ascii?Q?+GnNmh1FSeT/bcjqGi8xGa8Db5OrkdzZGA0XmJEvrg/4KBEhgWfxJCb7r9uO?=
 =?us-ascii?Q?aV5H7HXipYgwnAMymM2LIAiH0Uvz8t0gYStg8s1FqAYkGsHR5gtlgrdFgjeq?=
 =?us-ascii?Q?YY2Cp+SmKXh/y2S0dETatJyn1FXQrmTXBtabdl9n442ILY5E6BrXg8ayYlUj?=
 =?us-ascii?Q?ZSyJmiuL45Sdv7/NlG7FsnUBLxqcHgVrDKjH/5IQ5Z0bB/u/cJfAVN99OP4T?=
 =?us-ascii?Q?695YSbmUmlGskZy65Wk5n8xaFVsfiovV46NCSGvYJzA+qzOHy16uydp4zJHa?=
 =?us-ascii?Q?ZIMvzZld9e/3PDS1WZOIevxlsTG63hIh9u2f9wjPdMDDBNkNAo9/crPFD0XI?=
 =?us-ascii?Q?Do/ezmEenq4lvgdARyla+3l979C1ayGMqHNmY/0hdUxIQiDCsZ+xDTXHaI4I?=
 =?us-ascii?Q?+1j1ChA3xpG1bHrDG2BXG9K84nDKV9fJQSz7fb7TCbAh6Rx/K60D/uUulKFB?=
 =?us-ascii?Q?bYVA21GMev5BNdJbtNi1azT604SVL2B6iBDLLlPTTr30Wojk1aSFoMD2xJDP?=
 =?us-ascii?Q?87Xh4ddtomlMs1P4F+OYM1FpnelY1tKdy9NfB0GyQYana7vNdNw/JjW4B7/5?=
 =?us-ascii?Q?KPtG6PQ95rcl0Sx2KqggiJeHtcqfl+ftMCxR0USa0v45MWMakBjKq6SfNvDC?=
 =?us-ascii?Q?rRu6v9AQb6bFLS5JcJSz3KKK9StT8fZ+hohVh8aiFw0PWGPWoWA/YQ4XSu7O?=
 =?us-ascii?Q?eUti2qDdc2dvLHF12mhM1p1i00NWUUWgSiWwTVTFvt2UrmZkw6mZjzyn9aga?=
 =?us-ascii?Q?CE4k8D2xL8HyB9EKMoH5ZFPIhEFX13TmdolCIX2fL6MsnauBZvjCU1zjvshE?=
 =?us-ascii?Q?ocH35sPF2ZoocxNnz7/JOAg73THESycsBMENVpIyRb2jS0EjrWzFV31K4SKD?=
 =?us-ascii?Q?xNZwB0r0H2yYUHCNJEtrYQEHGNu5tQCozsfEtbV6P8eam+SJwLD95IQhLGQM?=
 =?us-ascii?Q?3vVnF35JAPTn/rxDFdwDxlssJppu281OdaZltZix66Nt3j4GtI/eD+kA4HS/?=
 =?us-ascii?Q?65o1tY80bs6UWc/rTb6SIfclLVlW1JKW9uhIXMAylQAuq4qv/DAGsa2HunUY?=
 =?us-ascii?Q?GyXxcFrQAWQUHttSU0U+2dlQg5T6sOlsjFnqwven5kmsUZ4aDj3uQYxT1o6b?=
 =?us-ascii?Q?kexvDStXdQD1AYJ5pA4FxhbT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dac4ccb-78f4-4d35-e06d-08d95bab7004
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 03:03:32.8072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jT5mpgXWXM3JzKRctsBYz5KuDxztIKNS0NIU4AYPMFPviGOaRsWrtMofo7QckR4Oo8xAciHi8Pt9dZI3wxkyfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There may be multiple instances and only one is harvested.

v2: fix typo in commit message

Fixes: 83a0b8639185 ("drm/amdgpu: add judgement when add ip blocks (v2)")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1673
Reviewed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 43e7b61d1c5c..ada7bc19118a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -299,6 +299,9 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				  ip->major, ip->minor,
 				  ip->revision);
 
+			if (le16_to_cpu(ip->hw_id) == VCN_HWID)
+				adev->vcn.num_vcn_inst++;
+
 			for (k = 0; k < num_base_address; k++) {
 				/*
 				 * convert the endianness of base addresses in place,
@@ -385,7 +388,7 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 {
 	struct binary_header *bhdr;
 	struct harvest_table *harvest_info;
-	int i;
+	int i, vcn_harvest_count = 0;
 
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
 	harvest_info = (struct harvest_table *)(adev->mman.discovery_bin +
@@ -397,8 +400,7 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 
 		switch (le32_to_cpu(harvest_info->list[i].hw_id)) {
 		case VCN_HWID:
-			adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
-			adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
+			vcn_harvest_count++;
 			break;
 		case DMU_HWID:
 			adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
@@ -407,6 +409,10 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 			break;
 		}
 	}
+	if (vcn_harvest_count == adev->vcn.num_vcn_inst) {
+		adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
+		adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
+	}
 }
 
 int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
-- 
2.31.1

