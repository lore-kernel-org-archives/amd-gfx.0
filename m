Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB72AC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 20:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C85E613B3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 20:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C85E613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC4FA6F4AB;
	Thu, 29 Apr 2021 20:13:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 837206F4AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 20:13:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZASOqkHBsbJIVR4qN7X38NsjTaab9d7jj0HLq6Ht7gOS0DuxlsPXa/1dM8kuaD1IH9RHSICDDoCwRGkAoU7El2GUf98iG26FnuOmLHulsi5ttkcFkHxKG64uIX7qoMv04vXMRKrERO/48660UZB/8/PSS5jQXhC6pvY7TVkBWbJG4uEighbf+OdMGY3OLDUVZ+xulMDml52Mt8aZ4ij2ckR4dGJSS5gdzOPKOV24vL+92q711R3Su0sG0QbU193X6TMd4JtJ3WJRHLSvAmg241dSpe5b/S0/YEO67lwNWCyA/VxkuuYz7gJsp7NOV8oY+h93Eqjtk+BalWr6Ycz/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru9dm37PfWCBDWZn/+cUvdGBsfva2YMMES2+6PF2/xI=;
 b=SDRffY5xx6z7iCSUYFHlayRMT96w234HpZtT74V1NvFYQWlW7ewyBH6DMTT5cOilf47gRwBR8p2fvXaWktlvRKaenLZs2xFH6y6AjyT4mj+X7m518HOvix3GO1ShzsZng2ojGeJr1H9UtsuZYzHXqUROwgbfwNFVVyNwBIsVgDpQYFpXtvf7WwPVHJ1IJfmm/GVit2yYRQvryfKN8dTLJfzZYLbViy9N+mgm9BeA6ycZEi5/xP8Cpes1tyAcr1ZepVQ6jUpYQsUxmhnYa0DzVqorfkcsSLnDdSRdx9TuSw6Hs4p3cJ8jYsm8OTB2RVDOXQbnkPCK15oikn7BJkJ7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru9dm37PfWCBDWZn/+cUvdGBsfva2YMMES2+6PF2/xI=;
 b=c9bdSXj0JPp3eHwLF7HdLcmTvleLTqsMtx5jsT4WyLRxjhTF/VBST1+46QKicn8B0z41kE3kFwBHCRpZsz0g+VSVkeen7HIGKAHSJh6AY3lS18YISMQMg1pNNGDDI1USca6oOX2w7WVybq8YrEbUIn1WrHp4fnBQEiGlTHKNDLo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31)
 by DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 20:13:43 +0000
Received: from DM6PR12MB3308.namprd12.prod.outlook.com
 ([fe80::e944:a64c:ce89:112e]) by DM6PR12MB3308.namprd12.prod.outlook.com
 ([fe80::e944:a64c:ce89:112e%7]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 20:13:42 +0000
From: Zhigang Luo <zhigang.luo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: Add Aldebaran virtualization support
Date: Thu, 29 Apr 2021 16:13:12 -0400
Message-Id: <20210429201312.10498-2-zhigang.luo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429201312.10498-1-zhigang.luo@amd.com>
References: <20210429201312.10498-1-zhigang.luo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::16) To DM6PR12MB3308.namprd12.prod.outlook.com
 (2603:10b6:5:182::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Zhigang-WS.amd.com (165.204.55.250) by
 YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Thu, 29 Apr 2021 20:13:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 209a91b9-cf81-4dc5-9487-08d90b4b4928
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB243883F093EA5514E311DFE6F15F9@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8LrzYgboUnI0pft6ku1Qh9yLJBUHsz9jZkE0NQnqgFgGuOq2fAYgJRhzANMeneFnvPL7mEuhyW0CbZmPpWGWoHLCPCVHDLbk/4137e3ImaEo3fKcnloIQr0tulILcz0pHY8OnVCy10eGpKsqiXLcJD/pJRyo8C5dkunEVYFEtESn2xbcZb8LuD3raedrqnkT2sLEY4nymxrFegJUCZ+m7MgipijlfzaOSEt078BFg71PlHJGUHDLsky4bJkUAqIGrKs/TkfVgOiEh4zvvcAk3eFUVxVtXyw3GgTToqP4E16zdbiigLt5L+p5/iFiYEDXXwVMo0e9WtvxPpC/syxURNXLDNnI/otfcUWUv5UY6RlyG4V0XL8eCcafUmRnoDyA3REkEJKRRS92ljIXGR0Z8o6K+CCUFRd84Q//9JeJGT53w8PBkfChGfJJg4e22nhjG1GW4Dy2vfio6/nZ9Tt8WwqMJa4owFe368kJnybYwgY+Y9axcTVcO4WuS9elIvw+QZFlXj4C74u0yLQ444Wuj2sPCZTz4r8k4nCC93ksXFQuNWFOiE0aNMs72BV+GX8sKUi+hURmSCLFQFPVcpdqLLj66neEOK3R05E20g/KLtbapbHkKZyRrD7v/u81I4d7XTl/VOaGX2RdbnpyGv/lw/dgscpzCpFi8SgkiShH8V8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39850400004)(44832011)(8676002)(38100700002)(6666004)(1076003)(4326008)(956004)(38350700002)(16526019)(7696005)(66556008)(8936002)(2906002)(66946007)(86362001)(52116002)(83380400001)(186003)(26005)(5660300002)(316002)(6916009)(6486002)(2616005)(478600001)(36756003)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QKHM+Fhm+VC37UaXFGtpVgtbSn0A6yuPzfFNs80k46juP/OOR9HGZYYNBe9G?=
 =?us-ascii?Q?bhtQjCjkxDY7zFIg3dQpjIxaYvLyfGFd2qWK2621s5kyG/QAtSlf9gIyKMPe?=
 =?us-ascii?Q?ojez5IO1ETnhNbOKXre9QOVFEzdn88eS39EQxOLSj/sz6yMduOxuGaux6co6?=
 =?us-ascii?Q?hL8qy9iy9KhxigpACodTCxC0sqxylc8F6mKbvU6278nVrwIx8nHj/w62rrhm?=
 =?us-ascii?Q?mfz+1DhuMseVslW9LgXsxDRy5edgwoEiXWKbwhpe+VJK8c1wZMQZpz4D99qq?=
 =?us-ascii?Q?iyAdAksUR+TR7WYx8xvOTenvTqBZxup8Vhf5VNZZ9kkOAIktJUT2hpzo8UlL?=
 =?us-ascii?Q?/1+E7I/ba0o6o8E/AoDTJeug2EgM64wR/gomRTcEzCANmjVESkXTZhHBpLdO?=
 =?us-ascii?Q?sEkT5xDrNmKDyYm2Qjm7ExDm3DeZIxjr7EgKFZM6OYhzFuGZ8/YTHF8H6TNe?=
 =?us-ascii?Q?nC3QlFqn5UADJDlVY4ubSE3/feTIJfCK9oIbOwzbgHgQQAlD7pyckiA928Rp?=
 =?us-ascii?Q?ymglnDeGlu1+AtldiLXlj6h89Rt2Ud7m/Co8sLVbMBsOGlJj0Z/zxpF41fh2?=
 =?us-ascii?Q?BrQv1Ika5xn+d6cYo3E+ufrVpIcfUfj+GHTUvFHfc+3ynyeo+hAvLcaC5dr8?=
 =?us-ascii?Q?0Np3D0w/wqof9+WXenvi0rzMMNe8wVLC+VSP636HlBx9z7LLM4ELX+vlgrWA?=
 =?us-ascii?Q?f5yHyTjPb+MKdOnEmDMfqJPe4liXjF8wYOzlccu6m0rihBmfra0kZQDv3wMe?=
 =?us-ascii?Q?OlyiKN2q39CHEmny6pKBUFu4dG11lOcWiDQheF6FHKRhHUtG7Ea1vH1uLnxZ?=
 =?us-ascii?Q?iP+EcF1jRlroYOCv3xDI+iKIUH+70Dd6rSm7vgppiidEIjEHOlEIwyuY99x/?=
 =?us-ascii?Q?sa9RkgukS5rvQtD6bZW/dhHd3ysQNtPgMPRV76KIfbKUC48cSKZEjNSjASGr?=
 =?us-ascii?Q?rnrHKhwpowmHPr2dlOA6Sl6AMWTgOJZF2Pnqas0O3ZGU9+z82Wdp9kN5FhSu?=
 =?us-ascii?Q?ml7QgCBS/B2b8MbMR3g6IIgneqSx5jd57oluPkq6mgQjKSdnrcWwIOsSuNfc?=
 =?us-ascii?Q?ce3gfLiwlw4vgc0jBIx1f4Cl/Oy8xqUam2KuoXaRfHyRkB6Sx5BbOh48+ObP?=
 =?us-ascii?Q?U1YNQ4NQUXL/82FWqohwIOH4v2r3Rp9dMHBvD3El/m/a0li73lbP11m7JxPH?=
 =?us-ascii?Q?1em8J3rHPOjIn0NgIaYqJT3tRX08it5wHJDoHgyeXxOQnZQqNqs6zOnT0Xg5?=
 =?us-ascii?Q?rAk5ly3GCyGc8+n5VpXyFwPnFLh8v+16mZxMqqeCZPM4ajIIdWSR8SgjArue?=
 =?us-ascii?Q?Gnn399TRsFiQHfsVFrOCM+Dg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209a91b9-cf81-4dc5-9487-08d90b4b4928
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 20:13:42.8724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i00wLhJhHr7+IwZLA5n0MJEDgy8e4xlecjd5JgYPoiSKjlSgBiHddQJyaSbGIZ91
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
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
Cc: Zhigang Luo <zhigang.luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. add Aldebaran in virtualization detection list.
2. disable Aldebaran virtual display support as there is no GFX
   engine in Aldebaran.
3. skip TMR loading if Aldebaran is in virtualizatin mode as it
   shares the one host loaded.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 623044414bb5..17b728d2c1f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -422,6 +422,7 @@ static bool psp_skip_tmr(struct psp_context *psp)
 	switch (psp->adev->asic_type) {
 	case CHIP_NAVI12:
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_ALDEBARAN:
 		return true;
 	default:
 		return false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 0c9c5255aa42..691066e9c1f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -50,9 +50,11 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
 	struct drm_device *ddev = adev_to_drm(adev);
 
 	/* enable virtual display */
-	if (adev->mode_info.num_crtc == 0)
-		adev->mode_info.num_crtc = 1;
-	adev->enable_virtual_display = true;
+	if (adev->asic_type != CHIP_ALDEBARAN) {
+		if (adev->mode_info.num_crtc == 0)
+			adev->mode_info.num_crtc = 1;
+		adev->enable_virtual_display = true;
+	}
 	ddev->driver_features &= ~DRIVER_ATOMIC;
 	adev->cg_flags = 0;
 	adev->pg_flags = 0;
@@ -679,6 +681,7 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 		case CHIP_VEGA10:
 		case CHIP_VEGA20:
 		case CHIP_ARCTURUS:
+		case CHIP_ALDEBARAN:
 			soc15_set_virt_ops(adev);
 			break;
 		case CHIP_NAVI10:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
