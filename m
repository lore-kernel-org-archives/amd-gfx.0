Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDAFC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 20:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7497864D74
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 20:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7497864D74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D2506E0EC;
	Thu, 18 Mar 2021 20:45:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E18036E0EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 20:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEP0byn0wLi8vEloFCsGV+RMUfzSd1UIIIrZY8Hrhow0pM4OZZ25fvPz61b/8hRGD75alZKKHE0qZkaX3RW4oWDVHkrhWqG7iMkE4rbHx+2PNCN4MOoSpABwryYnYeiviw2p47GPoBzHKEm8Br7sU5UxmphPPaCyG0cpyCbsEFJL0NzhqVNCA9r8K8i/o9+BRb61KQ4uaRcfIaXeHlK+fF/mG4fbhveErCfZL+xOvY0ADGvz23eIFQW5dVxJHzpQU+keqhfvDx1d8RUFXvJ3MiEdZwhnJT4DytC8/ScPpxvRhsRzTYJKIYN2YIMuAzrVcfyAtb7NaU6t5fXrmRM7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HhvmfmbLCSa0RQmkYSBDo+OZPSsNyuMKFfxRQFJGMs=;
 b=Pqk0CRFKbBofaOV+KWzx3yDWgA//9gUWcS8/XO+cWxSmyAgclJyjHBeD3D+raoYn+3UX5Wd6O/aVRwFspy9evtJJAEYs7SseWM2mxuCtQKsnCwAyV644o6zLauxwXFbYO9N/BcJF0mvBPaMl+Leo275WRl/H87C20wuFyaNDyHeMPIXwcZfwwuq+RJXswaJ8s85EoQiL4A97xM9U+iuNLK+HoeF2dmtglPwC8q3HcAqVPKMCIEeVoUTXCHdrxS23AN80KtrQirkVjLgq879MRBu8D87lIK71WGnWIk1upvx3uuIljipLTHC1y9sOabkGpyGAIz0fJ0vaEDRD4uHXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HhvmfmbLCSa0RQmkYSBDo+OZPSsNyuMKFfxRQFJGMs=;
 b=MFz4nnAHf30NC7lyEOws/FRA0i4oZ7o6AK/2ol3DsItNSizbbgGfKgnjiXNdrdqoZ5iYCISj+EQnrd1B4YALTpHWN5eB4oe4ojk2JHf/0sUDZQs9joEXQlk810HtIyi2gB28FZLIihOOtI1Y11lJ66B4dQpmIX6XvcRYIpSxsKA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3760.namprd12.prod.outlook.com (2603:10b6:208:158::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 20:45:20 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 20:45:20 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add additional Sienna Cichlid PCI ID
Date: Thu, 18 Mar 2021 16:45:06 -0400
Message-Id: <20210318204506.453258-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL0PR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:207:3d::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL0PR02CA0037.namprd02.prod.outlook.com (2603:10b6:207:3d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 20:45:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 106fd8a8-998b-4403-4ab3-08d8ea4ebee8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3760:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB37603750899423B71A8C4588F7699@MN2PR12MB3760.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0WXzNaJUR7rAR9DEuP++2pq6iL3oz6IY0dRceEWuUIGX0H8Hu7Pfw5y8BFDg9Mh+kDR4vNueWUqH+yV3JD/bmPDCYFJq6y24cKRSU6JBkNl7qVMBq0SvYk8Z0ZyZjBhx8jie1Pu/DCo6c7/EVDXkAvK1JhnqQQDpP3WU2OujxcIm1DYhVXggZWr2pNEnlRmGCV5tATDWhe96JHjEs3PKPTi1K0s13WLu3whaLfQKynM4NLj5g31gIKjGCovW3XXI0fPj9B5VmlcEwnQ2qdg/KXuU6lJBuF7Dxwf/XWcBqog8cGicPgMe22DMKl0pPYYzjZTNEF6VsRPlzuduO6/cnVwbW+MZK7F0/pg57uSQ68RyOulJhtUcSghTNEYem7VGK4/3YtO8Xe6Ck/083yT+YakS2lITaMpFoZiI1Yp1WmqAc/TwDXYdxLL1+upXZ5oVIPhD743SkZcSj/ozIbbhuUHGowInwMRHQYuEk2DjAqKTEWG8Xe6s+E1pMmB+Y1XZjAkOhu+shATAD8sGextk5hplDPW1Q5me0aGwqZYHJEJ5D+cwj+mVv/mF4JSiy/tDvun3Ds2W+npwQdB/CmhN3l/Xr57javPJfrgZSjsgM/bn3hm1wAgAglNXWLWaqJg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(8676002)(7696005)(86362001)(2906002)(66946007)(26005)(6916009)(36756003)(186003)(2616005)(38100700001)(956004)(1076003)(6486002)(8936002)(66556008)(52116002)(16526019)(5660300002)(4326008)(6666004)(478600001)(4744005)(66476007)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?73E7R82+8G1TFctAmdIwcJhGB/hW7OPh2PRddO/l6PrHU0EdNIPtPJidDgYC?=
 =?us-ascii?Q?UzNEa311CqM4EyxxY+gV54WiCd81G818f8Tlyh3AaTPtTuSL6uKn32yibwCw?=
 =?us-ascii?Q?DZVjABIj0Ozq3nEw8QCGZ51zSZO6BHFs0YPnnKLuDupmKRgM4l2ImkFIctw2?=
 =?us-ascii?Q?QJXVBe3vF9O0v46dLjRD3AIDbheZWkNz63EaGVcPPQ14EZU7beVBmlcA2INX?=
 =?us-ascii?Q?AarxsCX1XIjTbFF1ASKwnXbeNgKOvE505WgiO/LJC8tvhzGj/1mgfaI9qPpi?=
 =?us-ascii?Q?7WRNwCBXCNG+hfEh8DxPxNcefQmfhElVi9cq5UtQaLp3cOC59cD8tUdr18iz?=
 =?us-ascii?Q?hRz613Qm9qTGdvpn1TIBq7C/mxr+fKvn3SWTr0/LSasyI2WgoUxkP36263tQ?=
 =?us-ascii?Q?tpejU11OWsUTOQQKMQ1vUQCWXYhe19Ui+oc3G38Dxwg2vurygEZRCU1kmAVG?=
 =?us-ascii?Q?u/aAwaXpBytly/YfkYb3DejIfRxG2vo/akapBavpY7xI6iclz63n3+Axhtrm?=
 =?us-ascii?Q?dAiagbng+JBQH6wUqH4RVGDZBXUjcv28QYdmTjaQnB3ihqRNqipyMGkIlM4x?=
 =?us-ascii?Q?ckEAal3ugW9/RV9K62AVQ5hoPk69Yem37x887jwmFndewdouXJiEY18mx0HM?=
 =?us-ascii?Q?bzXBf+tqwHLQL4AT7T0//N3uIYRRorGLOx5+Srb66HIiihethbeXXO2x6UeB?=
 =?us-ascii?Q?oDv/oP6HHZptW+iJKw9mKTGVkOCVIZ3pgNAm+e7Z9y+XW4JHqEXCVzHr5BXC?=
 =?us-ascii?Q?f14h0y+F0CgQLUalKLUg4nhX8RDEUgQxAFC5QUFGT/xMzqLtBRzQoNn+Y8IS?=
 =?us-ascii?Q?EndfBUKOVOcIs65n/f/UCAaLfmTgZeDjwjqddEx1KEwr+3kybh/lwfDNRt96?=
 =?us-ascii?Q?SgzrbbMwKWXFqbc5VvCo2RXt2Daz6m2Ktu2CE8QeoCdbpJtg+inITONIJBhi?=
 =?us-ascii?Q?6E7Jxmf5W2H+hhE0+OYGp7X0K9fhHvSdgktDZmZMKK87dMX1Lf65pUMh8Ice?=
 =?us-ascii?Q?kz6HnypwG8GMu/1ZIFKSsYIqXaJqM+kRqDK+5sXIk4S9oE4Myl+2763wI8NM?=
 =?us-ascii?Q?k42s08h6WijH67QWW33q7P0xcVXNYWdy69HTwj4G0S3eoWv9ldDGtawyRwOH?=
 =?us-ascii?Q?Q1F925qNtJbB5uqdj1MIH2AW+GqHARIPwC7QUoloD93TMX4IuOSWjI6U+WaC?=
 =?us-ascii?Q?/iRInk8eKQIjTYHE0VezwuW9d0R8M6wKwiu44HOB2zJ1eeo59T4AC2Lt5ito?=
 =?us-ascii?Q?UzHhm34O9KlszAvmlj0laozJDdrxrVbSeGEL0izQItHbPD7i4NPUt3kGd28x?=
 =?us-ascii?Q?R78B64dpNQZ9vzD66g8zNHhO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106fd8a8-998b-4403-4ab3-08d8ea4ebee8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 20:45:20.6020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCvX99GFLw7Q9NXyy44l0wAlwBbnI5RQFzWN6NUgrg/Y8JVrXw5j3RDc2tVuZmFRcnCxuyFbG1EedRCHoq4oHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3760
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add new DID.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5438a4d3d517..6c78107db789 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1162,6 +1162,7 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x73A3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73AB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73AE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73AF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73BF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 
 	/* Van Gogh */
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
