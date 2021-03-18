Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5EAC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 16:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1451A64DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 16:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1451A64DCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C33206E8AB;
	Thu, 18 Mar 2021 16:05:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70EBE6E8F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 16:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgP2+wO4/+7iygkHtSpFYVwtl/u7wMWgHQRKG8vqeAi2iOegTzyXGH5j6kuloJAQyIanyjceacFK4BJtkuE/IQKXSh3gT0wuNLOqLVjrpkWYcmLi8d3KlJOQVUxOiDpP9vZHIyOqovZ2Q56n0jzXchIC7enXMSpf1ddqxPcIdHPBeGIa+DHyTS+O26lXGdduYQYqWNrm3Z2jqGGrAp9gxASQCOBmB+hbWrGlJPdxiy0S/xg+KQVJOcrZXG/GVO5SjqF1ySu7mGgXQP88khwtLy/J8D7v04euRg8G4VFurMcrl6Zr6IocdSHG2WQh3//ivTDY0MmOOBeSVzdybP5yww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UxvTubYd9dzKK2IIq7Baf0SN0tyB6I6gpnFRVW/abE=;
 b=LmzS+JaZ06XgtK2ZAgXvmCId5Qkm9buQ1fgqNmaJaUH+f1lAj6yyOfxsoBrU6+vwtN+wY70D6wvfjGMtYyaA5RUWgo0oc12/FOySvCPYa2nd7NPVEDuy2hYrTrmOt3OUP/8UZ118+h3uamaIxlsJkBRU8BQA98ep/s3WRhIH1FukJ3PrXgResZXCf81X3xOY3IDTqc94T1zRPQ5s+A8vxtkAU8YZYI+IDMVtMZI9qhq6uTJnabIqZHiqlzi1XQ+WPouxgjM//52WX2YdbXobPwVn0dPbBSG+OSIQE6kgh2SWv967+KX6CuFw5OHEiq5emoPJAamqROCG2JGVJHcJsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UxvTubYd9dzKK2IIq7Baf0SN0tyB6I6gpnFRVW/abE=;
 b=rQS6FZZJVKWcJZ3AY2+IC3Lzqi7apw6rwb63+L5hTh5VP33RYGxNf5ux4hr6aXXwfHPOCh6dxTxXsiTYQa1BI3feUxunT1LzwVjc1qnnRd7bq6X6t3AGwzuTOUIoKokaPfgdC3fbs0JEGJ5RnSqC0ol2SiQkZzMxvh4Cuoe6p0Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4638.namprd12.prod.outlook.com (2603:10b6:208:ff::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 16:05:53 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 16:05:53 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: Mark Albebaran HW support as experimental
Date: Thu, 18 Mar 2021 12:05:30 -0400
Message-Id: <20210318160530.260-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.11.250]
X-ClientProxiedBy: MN2PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:208:fc::47) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.11.250) by
 MN2PR02CA0034.namprd02.prod.outlook.com (2603:10b6:208:fc::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 16:05:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 07fe5e80-7b43-4236-aa8d-08d8ea27b509
X-MS-TrafficTypeDiagnostic: MN2PR12MB4638:
X-Microsoft-Antispam-PRVS: <MN2PR12MB463876D1F108A9C201FBD75492699@MN2PR12MB4638.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QqRF2ONU32edgfAuCQWMk8UGpDtFEXogC518a0MGAhMKAIWanmx9nA4YyaBxPx1qLW+nUUosRVUxM1euuH1kvlnPZSKYGixlPnFzXecjAYv9dLcKtCw2WLpFuyY3IJsfKd9PxMfmLT2eKHJm2M5nx6rQ2a3ynAfPS7iUnzCiOsohII2oF0cy5EtQwMe44hTR1lGZW+j9ZSNgyBve21qvvt0TDvO32iHf8cZoGDv6LRr+4BPXjcPcIKjPF6KEkqkDoiL+YYmsNbkLwBK36YDHIyGKKRaNAxNKuiUZ2+m0vPn5aDYSRaI7ALU0L0bqMax81uELR3t7dGccuxSSSHPNjv3AX2hU0CMqqfacH8cz5Bbad/9G3QbzMLC8hnB4vzTktJXs98a8FeadQ+8XNQl1ptk7gamBPHWcrPZtoLGKXwilIhTL92wMuwJXOEpJwUpxQ8gVXDGtmBLD7/EPLGEWGbXyWIs0n4g80NWos8P0iPy/QX00V5sU4qoGCh4Os7bjZMpacbiUbBFZhutuG5EChQv0hkQzbD0KX8hy693dzc0r1vLEap/oN+wNKYyI39jU94bMluPVIWOLAPDYwFUU/731mFricW82t/wxAqWFsmzt+CgTffy/bWMZ4RxjSHpHvUrmfnYOzKBqDMZ8b+c/Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(6512007)(86362001)(69590400012)(36756003)(6506007)(956004)(8936002)(316002)(2616005)(6486002)(83380400001)(38100700001)(52116002)(8676002)(66946007)(66476007)(26005)(16526019)(186003)(66556008)(6916009)(1076003)(2906002)(6666004)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vdR5tWuEisI05951I/3a9VUQSaIpaExJ51i1MEU5fjEqGngIcTiU/XM5UpCO?=
 =?us-ascii?Q?mNKr8DPltn34/ZO0qrGIjVdfuO5ZJG4pbpCOdqTL1y1FBTdp6M2BYuT5D7GP?=
 =?us-ascii?Q?mZ/oGhsOHNv16YBXZK+bic7+f/WaU0a/BxoYSI0tO11LQ2SoshEzp76/CSMZ?=
 =?us-ascii?Q?2MPob3IlFzQK+y56ahasFrSAmQvMg3EPTWU3lYYi5M84Q0mBlQzfdWSE7Cb9?=
 =?us-ascii?Q?4I6OGYk0flmfcfK0NfhM+FgNOGf/+pzaKVh2MFsyFzp8leCl+PvCPY+4Rsl1?=
 =?us-ascii?Q?L8mw6U8oSJafi0Yua1kSjKtePfb5vx+NCqzIVR3OjjowiWfHl71R7YIH+gFF?=
 =?us-ascii?Q?wr1TxZs2w/WjP0qVzVvOu2/mqp/sfirc6ubUg4oYvq9FfhlxHcjjpQvhrksL?=
 =?us-ascii?Q?i6Nyx4YoVwAtPChKOO7NFPdFDi4+7dm9bRAQdbIm1j3aVX9bS0PrYkHlTAU5?=
 =?us-ascii?Q?y0sZnzQB6CDaV9BFR3HCdBqRTYu0MtzGSGLKny092ZsAasWsvDcUg3seG8rp?=
 =?us-ascii?Q?DiLzVXUC8V6xp++uj75ue0o4vUAwp63ZxdPDe26fKlWzzdZQRtEzMyoRe/tC?=
 =?us-ascii?Q?LaRfit3vdzu5nPlQhirsio24p3pXSnfV/6gPrdCURNjnmS+dgEsioqyQF8p6?=
 =?us-ascii?Q?LzPc7VHN+ksxvxA8PNJZrFJeBwQwwFJc4m9Qgf/OuGF/Gu4zmZAv/aZVmKnC?=
 =?us-ascii?Q?DxyuL7vZmJYooUGC3GNuaQuZa4s9PhYuZ+8+opsn5zis5lDPzHFpUikgUkGt?=
 =?us-ascii?Q?pPmYHCBnIZM5Z75qtFGRsfYV/Nou+uK74AsLD9UCLsOZrffQktq6wgrQ3rqt?=
 =?us-ascii?Q?P9AtjDBVpGoEqKzXBl6n/bMMg0P9BCDEj05nI/OnfTxPUhjPIFpehSCVcLoD?=
 =?us-ascii?Q?bGqE/iYRKgQtV8UD/svVnH1Sdqsznoa+P2BGxfiD9DyqZcxsROpYmxDEQkGe?=
 =?us-ascii?Q?M5Pz9WxanCPv+SvcBaya4AL+V7bCDcM4sBX4yFjcJVpyK/5C+OafUwbX6lVG?=
 =?us-ascii?Q?UcqQgf3OIIw+lXFaO6EKAlHxICXn6I61NglDY8NI/2ujpbLy6l3sgqtMsKJl?=
 =?us-ascii?Q?pVGpAlYACFl43h0uJr5BXDviFu8pEsZCRanyJEE/tF8sX1mJ9njsnXfJMiyE?=
 =?us-ascii?Q?g21suHITKf2Tx3fLRBQBFpT+b8JyOeRmDm/IgsPWUlpOziOXTLlFXcPd8Rpd?=
 =?us-ascii?Q?fiPa1d41YEcdxNF8qjOY3Iwdj4Akx5HT8OKtwVPO2/DogPGiO3aY+zw/0JXn?=
 =?us-ascii?Q?yIQLUdMQviE0/JUEeCaL22R7N5ec0hvd/mQQyW9rmQnzp0SBgkxYWxaVw8CD?=
 =?us-ascii?Q?J3H0omdDqVZnN/gRJnl+XwOH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fe5e80-7b43-4236-aa8d-08d8ea27b509
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 16:05:53.6252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jCgIiLV5RcSPDmFMl5luIBp9zeVjS8bp37DGE3PlX2N7+C1zk6frLA8/kzITsuhbvBOb2J0ADWU4ASO8xiP2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4638
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The HW is not in production yet. Driver support is still in development.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2e7b5d922f31..a3e3760e8d62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1179,9 +1179,9 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x73FF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
 
 	/* Aldebaran */
-	{0x1002, 0x7408, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
-	{0x1002, 0x740C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
-	{0x1002, 0x740F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
+	{0x1002, 0x7408, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
+	{0x1002, 0x740C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
+	{0x1002, 0x740F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
 
 	{0, 0, 0}
 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
