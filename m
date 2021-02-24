Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DEFC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C81564ED6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C81564ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A28756EB62;
	Wed, 24 Feb 2021 22:21:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C255B6EB5D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tm5mcOU26GNWInwexF31YpGhmYBGYrMsci9aNdVfdzxn6Q65QJJ7g2d/iI/wT7o+ctDVyHmJEKd1Z0h8phJ0MK1GFGN//e6PRB5QhzOxW9PiirynOF3Xk5GF3e1mHPM7L7FQoIyo1JfjmlSGKWzVV++VFYO4I/Gg1L8mFx4anTF4GWtSob7eUWK+SXrnOaMW5bZZ1t/5EnpuozdzPMt+AXIBHpPyIf/ut4uadogbeCzbzqNwjuaoLISKqHMgsy9btumg80idgu59iIncloptweVNmyClVaOiALIFf9MQxVBl+Nr6Mo8D0B05KZdh3QWSvAdNycLG0aKV6rP0KZIV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6fYhpQmrwzoaWpR7omf1bXY+pfqLiOIgt4wZyiIDEQ=;
 b=OLhz1Htndf0cTHycwwytnCjlVA/DN0lCfS/vY30g2bfZ0erYz8cfpS1H+AvJal1GGxwBn74NYuA9usvYQM78SgqQblpT5I97Xa6v9Y0hyu5CusAL5fdgOJt8GaCPkEzveZAdNyKVvwQ/TKaUcxVOkG7kWQ4gXvFHSgNYDYlOcPG3tRkf6hd4fAmqoEEXLTqVgqRMYtSZvz/kQ4oSw5kyhFSt7//cng+/nshPK2ZdZ7HfJ6LLS26hWgOP5unsCbCPCN2D1MKC19fDz6eUgjgwqVLMpGwK4y56WJQmSuqWmxNdyB4z6vsMZOaBNXnX49LDBGjwbBFoGyjcqtYRvNiN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6fYhpQmrwzoaWpR7omf1bXY+pfqLiOIgt4wZyiIDEQ=;
 b=Rei4OajpV9Y6YrKuI7tYnFA3hVJgU098D7O1KxKfzcESd4vshk+Xk2lGle3GJ0OAyzvg745ms2l6dKZpoN6yobHz8VFEGEy7Td8vEqKuZPtBqhsb7nWs/WQp7I3EtL7rwNNmy1MXdynX+KsuP8vlqSlKuXfX4zTepbhIE3xPGHg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:05 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:05 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 078/159] drm/amdgpu: add sdma ras error reset callback for
 aldebaran
Date: Wed, 24 Feb 2021 17:17:38 -0500
Message-Id: <20210224221859.3068810-71-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82aaa9bb-527a-4312-703a-08d8d9125b3f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40469DF4B4DB6512FE611688F79F9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vuA6PCteXOo+71WF1CTMMpY6kgIoFwzHc1hQAnGoznyPXeRXzf+dgV/c/2HziYsKpA4sE1he3Q3/UHbygKy3Fxi1yNByeQG71ikPkxjmmvat84okEYjybXUKjQ5V/58XyW4BYgb+xxqvMFKb3D83AWfRXyUHtL8dZySutKkm0+DAJkbi0lV1JH60qy4vvU6LmS6h8Lt0rMnGLFu5OrZpVdBy3StUA7IgCwYbzp55w0pqyxY7h0nHhWZz2msZsGjBkvvAgVdGLyrkhMaGvOkM5HcVGy/yoypseXCaJmRi/PltZ8yViWtPeRh0Y9W1MIYyrJThVSTLPhsCWmQouRU310m8NvDEY419C/GiXQ0wBnVT7gWyOpsr5Qo+uHUKUJx1ReyFoMj3yzsn1Shsbabzrzjs5gq00CrRAPVHuJDkeBVwvEepN8tQl6dC/h5jfpisn+aRT2ltQi5C4AWyZEx0D204FDuzFUDMuKsnHHY1Tzr7e87iXFzoI9p9MnNr/BVQG+de8d8HeMWoddb5P00AYNiK4SK83ZNs4QRwYpLSgA4YnFuOfD6mIVkjqTrU3qAtbHSoRSCk4g4cADumcpyFPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(83380400001)(86362001)(4326008)(956004)(2906002)(6486002)(2616005)(478600001)(69590400012)(6916009)(8676002)(8936002)(1076003)(6512007)(66556008)(66946007)(5660300002)(66476007)(26005)(6666004)(186003)(52116002)(6506007)(54906003)(36756003)(316002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EmCNk6n7W3OVprYxeDS2JLthSNynR92+p+5Sart0MG6EfKWLjgkC/koYQpz1?=
 =?us-ascii?Q?GtwLEWT8A60PDKv3o1tEyATVCUAwRQFLWuM2+iaaaFLOUHjc2Bp9IeMMbeDs?=
 =?us-ascii?Q?5gB42V+JLojjcJV8lceSuFQvgmi07kMSuV+eUEc5szuuWmVlBeZRbF3gCfqA?=
 =?us-ascii?Q?gtfsrpr2PRyrgK/isv/W5zHHieNiUd7jLMLxJ2rHsRlIgMRAn4rjNkBJoJvE?=
 =?us-ascii?Q?2LiCTK8av4AImrM1wi54vzhnnS123btLNRQoQ4Nik4I4Xlr+fY7/LUHN80Pe?=
 =?us-ascii?Q?TNhqOH3FeLzPHmVVGfy+NBn5BRRXRCnlMNTKvfYdMxbtIIJtmNzEh/+HN0oU?=
 =?us-ascii?Q?fZTqibd6AO2wEqOH5MNjFOB2SMZDVWj3XgSXCM38snejJ7GEl2szsfmtgry6?=
 =?us-ascii?Q?xjx0RfYDy93CtT0udC9F+dAGLQOz8PwalXTs5eN1YSEhVF3zw1ebPlGPpdyx?=
 =?us-ascii?Q?/GXJNzkLxGPKwZraFZdTrpqEgbPe8EmI6Bw2fCE282Q50loLhXzl4ubqGzsq?=
 =?us-ascii?Q?6ZZZ29RMBOyXd1VO8pVhwfUfXI+cTJR9UUuri2dR9Mk1GRsOtZjz2vkP5Jfs?=
 =?us-ascii?Q?UrfLqjW+/mfyaPpA+0A+tYvPZ28MtPByUGmn6EvVCJJan3DIz45/jZx05MbD?=
 =?us-ascii?Q?xWgl5S5loAUArpNuIvYcLSNOg4gHnxYJEFRsIXU3XZe3d/V7K425rgvj354i?=
 =?us-ascii?Q?iDTcTK1SfbIAzECDTmX7KWabyJJ4xvZHzhuzoDkiOKKz740N0B3L2lzDcEXa?=
 =?us-ascii?Q?N+uthVIl9m+TjMHHeE3jA4dEa3y0257TIb2TipmhC6vBCW5/fBVT8RIQLUcM?=
 =?us-ascii?Q?LfSZNJtrUl7UXjuP5ahlqSTrDw3P/zmYTbwHTEIk5abqBKknyJTPv4djMAV/?=
 =?us-ascii?Q?iU5h0GGUqugZmIzc+e6nidjCDQrOhXLjUwAFvqVFFWkdX+oJkWKU01Rny0JN?=
 =?us-ascii?Q?Q39sIYHwCD+hnanetwiyVMNoz4t4TzNq5rCQ14lPAY5q2vbsblU7dkMwFX+z?=
 =?us-ascii?Q?YR1/hX+QVfOtXAARXHEs/YmywfOMAworSA9snYUAy9wMSSbUCG7tWxi6YLCb?=
 =?us-ascii?Q?xZ8YXoWK9EKqudAN2ABGbMd/kRdMSqbbRXnR2Xzyfn2pt1NL88t9Y3pEf+Ci?=
 =?us-ascii?Q?sMPEGG8JdaBOcv3Kqq/7/giDv/kDZ9z1LJ1HGgztxgMInBLsrK6XQ2Qy3F3/?=
 =?us-ascii?Q?fNgxEWpBsf3mMC0LZocIK+dCy5GDjCyPhoqVWyPNfCUubVxWATQk2QvFqgi/?=
 =?us-ascii?Q?xBGZwgoORbajvsiI+OOuGw3lZREI+HHRDcK0z3rB3+dnpkcRV/+T1/Z3DnUE?=
 =?us-ascii?Q?SWVwu5TyDI0S4+T7RZTA0zaY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82aaa9bb-527a-4312-703a-08d8d9125b3f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:13.8439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhDGyCGhoz90G1I9fuNvx57z6RrEYpeMA9qgHcxcs755kFnKYKYeGhpONUY0yVx2AGgCCrAPxAlUlAT27kmqrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

The callback will be invoked to reset sdma ras error
counters when needed.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Dennis Li<Dennis.Li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
index 3a5d0a6bc578..6fcb95c89999 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
@@ -208,8 +208,25 @@ static int sdma_v4_4_query_ras_error_count(struct amdgpu_device *adev,
 	return 0;
 };
 
+static void sdma_v4_4_reset_ras_error_count(struct amdgpu_device *adev)
+{
+	int i;
+	uint32_t reg_offset;
+
+	/* write 0 to EDC_COUNTER reg to clear sdma edc counters */
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		for (i = 0; i < adev->sdma.num_instances; i++) {
+			reg_offset = sdma_v4_4_get_reg_offset(adev, i, regSDMA0_EDC_COUNTER);
+			WREG32(reg_offset, 0);
+			reg_offset = sdma_v4_4_get_reg_offset(adev, i, regSDMA0_EDC_COUNTER2);
+			WREG32(reg_offset, 0);
+		}
+	}
+}
+
 const struct amdgpu_sdma_ras_funcs sdma_v4_4_ras_funcs = {
 	.ras_late_init = amdgpu_sdma_ras_late_init,
 	.ras_fini = amdgpu_sdma_ras_fini,
 	.query_ras_error_count = sdma_v4_4_query_ras_error_count,
+	.reset_ras_error_count = sdma_v4_4_reset_ras_error_count,
 };
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
