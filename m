Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A05CC47096
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38586619B2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38586619B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D606EDCC;
	Wed,  2 Jun 2021 16:51:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCC3A6EDDD
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvnCNGIKS+RtGjGvkPvB83JZcTcseWVTkeqYS9bSDcS8ICMrhydjCdiurUS64B9U68TcEzxM5EgLky0FlNRzuiIKXjMiB/6NEAsZL28wHEhG97/HMUZZmGQsgUE0S8vllAC5nQBOBvdOlDWd3kSXxVfrVG0SOMUps8qri7MipsqTYN4c1GY8cRmQk9tocSDdd4i4fNW1bFPEAT8VcWgATAeL4Zf4//dfq7u90C7cRc4hjKTo/Uj8+8FvntIh7RJA50YIKSYAFxkqAJEY5TqUTNkf3A1s/JxDD0kXLYfJTALBZ60Zoq6R41A3goQF3NDfvXHafKsgpuXc+a2D+YP/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBz40NcaJdnzDc/ODNZLfq20pULlFQHIo5Azxkgz73A=;
 b=RehqvQp4trCG8/wYr1SwVs1KZg075RDN7C6XRDloNogvWxWnF+TlwC4lhKa5QPdbb66znPUw4IqALMJpchMLk2O/nTlHzdKmFovR8m745TrLe0sFGj8nuXI0AjKSaGGvicrt7B0NM7u5bjxK9lrzcAweoaQ1H91dG7QkuZT8ezWU7lkli5T5vo7RhBo2n2b0ngWvL+C3SnNFWDmKYrXazJoMie/v+mx+jOdAoomgHLDUG6ablinz56Jr0eO1FiQRpjZvN4MFt6+gviIE+IBSRWH5XxAlEXxL7ApD7FVZQlgQmETSZwBsVl1qqoV0KM2kvSIZZg+3cFAEbofE6zeR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBz40NcaJdnzDc/ODNZLfq20pULlFQHIo5Azxkgz73A=;
 b=qMIGo89GTGL3CGkle8LEaC4lpM3N+BT+CuWVzkt3s6kK5e/hSArP91fNLaK1/uU26nU/T0z8b117+k1IjDWkS1ZRZ8st56u799UtwxnBkXYzvxRl75kP+RAULNtQHI5+yat8dDtUGSOWLi6yh8MG8BgyAebxbx9izpNWgmSCZ3E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:31 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:31 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 89/89] drm/amdgpu: Add DC support and display block for Yellow
 Carp
Date: Wed,  2 Jun 2021 12:49:08 -0400
Message-Id: <20210602164908.2848791-89-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:50:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 281a9f1a-d140-4baa-1641-08d925e6872d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45347A36226509CDEE66CFB0F73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:323;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xzTKaJkD34YNZQtMgm4asJYSOzOJIyoIpwN5/p8TiTqwX93PfxwSxs3BQgi0PV8D0Sm91kao56zFKWPwstlPY8N6Apnk9kc/vP1SHQKcOZeHx1fWMx2NCQ2Bh6RMI2XQoRGkW8HZ+v9a1Fh9nAQ+orPSLCJVUwHNo998+ylft26/rN90UiNPXnXxQsb1Maf2NiAfw+TdAofnewCbu9fyz17Qjq8gvxAD47rUMMdPVQsqgLDGrC7x7xHo0IjhI3UHEVcy6qnUyLCz6YDX0KGz20LMGwMP7JDNaWWVgvjeiUIMCVOBhe4dr4BoPhs4ig0u7TCXXmb16LpjXwPe0kbOQgSZgB4PW3wwx5PetKObrLZ7zGqmfL/7nzUdjEcqjuPJdEr7M0oKLSQghsK49fkhnq4I4V6Y2aZom02AVco1P36kAIGR3LsAavJBPnH79xtKpm7c7qdZIMCGqS4Gd+W+ZSNs7DGfkh1F1KDuX+ITs/eDDHiIfzoPetFb0KvdrgC6yfE9HoMcgdrc3KOWLhz+8ue41nKTFmb/E7/azf4AL/8sgSaUc9sn5px5xK6wMmTPrebRXjfz4H8T558Z2OU+DcaB/jxazSi+5DuBobzEb1AGntV8jlKxVGCAu60NJ6VaOAqYkl6IRYpI5apIfX0UVulDEY0Y17cg5KOew8O8ocPOZHh7NVGPVIV/IsroLcj6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nzFushV++WTKf2uQuqAbYPTOYX0fQk50lF15xulIbJ1nv8+ureocfXANxYWQ?=
 =?us-ascii?Q?ShxB/RDBm3cpC8BIVL7IDb/lgMTtqTq9eMG/HCL1xWxSZG8iqsYOescHMJHs?=
 =?us-ascii?Q?+N+Ran47knatcHP1a1Oin2FH4S0LqPtxfeEF3atxegOKGbYq4NSAA59L38wu?=
 =?us-ascii?Q?M2z08XU82NkI6vNUGfadjxf5dgOA472DCQgfyuJWPPrjFkMI7K2Xwt6pqDNH?=
 =?us-ascii?Q?njL06uLEpGO5Y7MyaHAYwWbgJJsHh9sE4o2BI3lpzPfxxnz99WSpJPKc4PPM?=
 =?us-ascii?Q?ha8uhdK9Kz5q9zrefjy5z72EEvYUUIW3m4JbssTgQKFAjraGWCP/nyEqDYkV?=
 =?us-ascii?Q?0oyejw+rkQXxzaVx2pGXoYVSMDF3s6SV+eKceicXwuF5dvmNzC5O/9+r9DEj?=
 =?us-ascii?Q?OWtgL+lFQG4YktAr0fa12RYdgWZ1ykBs63nud+ncaEVeGnMArKuiV4ncL3ZI?=
 =?us-ascii?Q?ZNQdDqYXtp5FF/GNyHuVMxM+HknFkdza7yjsBK8m//QWcLzNGUoFGs1D2Owb?=
 =?us-ascii?Q?u24aYJBaFYCYCvqHQ3Bl7ml3ECJpNl3HdllJMrrw2v1bsS6fWarMETwp5vm8?=
 =?us-ascii?Q?0o1TjuWHUHm6ztZKLU0nrtpgNDuTGpTF79B3NOn/dlOE31TbV+kCuzQvsDJm?=
 =?us-ascii?Q?pN7KCsdszs7ohN8zKC0LOLD9WHnpyVbFz6uY698myhce5ktQdrNR6BikUZ51?=
 =?us-ascii?Q?KKDYug60Du2tiz85ayUyX+NhxzNpqnXwA7Ha2E9YToAVZcRzuxi8eTpk54tV?=
 =?us-ascii?Q?ERmQRymkqV0yzs/xbU6j6eeAX65FSuRVn0qbngE54FeiWXze/6vgdz7DqmO3?=
 =?us-ascii?Q?/xeb6uFvqvMOUYtE31x8Oce8plagMlKkvQiaPyFky7IEA+yve6UEadgeP/mM?=
 =?us-ascii?Q?aQ8CzMcFbNkXk3Xr79EoiuBd1f0leZP9Dkqhnta78KmYfNNnJBCQDtrEm24K?=
 =?us-ascii?Q?t96k1fPtFM2sALkTuVsn1sGSxmNfEKdI021RXplllOYkVfwf7Kh3Vp35hrO8?=
 =?us-ascii?Q?zFrqsYHxK0GPlbwrqPJLxBT38G45f41LtNk8pMj81dglVUShCiuBY4p7FFzV?=
 =?us-ascii?Q?LFYz/ahaS3nfjDm6QUz7EfmFxi+itTDNxfbRYGqVFnnyZKpMSpbTTzsG6Nmn?=
 =?us-ascii?Q?HXI3AY1U4s33n9BTwmExrU6EZU/uUxAhyvGFv4KscTS9Oiwswg3GZ0AdnpQA?=
 =?us-ascii?Q?rT7g+KFLN6eQEWPYfPaxm0Cc+Er5NmqQ+0DI9LjD2ADUtiTcjB09hrkvg8Su?=
 =?us-ascii?Q?2Js4NsiMp9fr1sIjDYHwlaiNnPN3S9MJt9MWZaobSHubNJW3YGmukp1M1BoW?=
 =?us-ascii?Q?8e2DT/fS3/PpBpv7N1MBAHN4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281a9f1a-d140-4baa-1641-08d925e6872d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:29.1714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVhJaDDiojhX7v7eKhw2+9T9HjWNGT5VB7RJ+CvZ/HCh0fFR1IEJWiRGQz7RcaEk/hTD6s4PWEs8H6Qc6+QWcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

To enable output on real display instead of virtual.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c            | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0b38771ffc79..0c875d68ac41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3125,6 +3125,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
 	case CHIP_VANGOGH:
+	case CHIP_YELLOW_CARP:
 #endif
 		return amdgpu_dc != 0;
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 11b292131c02..455d0425787c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1001,7 +1001,12 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
-
+		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
+			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
+#if defined(CONFIG_DRM_AMD_DC)
+		else if (amdgpu_device_has_dc_support(adev))
+			amdgpu_device_ip_block_add(adev, &dm_ip_block);
+#endif
 		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
 		break;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
