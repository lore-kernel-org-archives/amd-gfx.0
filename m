Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C4BC47092
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5F861C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5F861C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30AEF6ED85;
	Wed,  2 Jun 2021 16:49:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61FDB6ED1B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRfMR/EsBGnU8WHV2yFcKm+eLA7L9WRP6RtrwQHmbTgRSp+FRDR8xblZ9IM+OfraBCTpTsujhrH7MJzrHCeTIdRU+tHuD3nD6Ec2Swo3L2OxlX9nSRYTttSyQPvxe1vtZD9lw9VaxJv2yNWEmunI86FFTHCOhUzEeWA5xv4bP+hrOhygmlO5w+E1xuInqyAErOaiQngMceI3RhFYkoOt1+zbDe6TNOMWim4aXFCJU5EtC2yFjN5fum8KhH5DBQuJCd1dUsBa/KAbigshuOF9mUFo5r7rmFvRPJmyfa7ZPc22oHFNRPQFlHNdig5o7sETzUnm76sLHtxF1o+kWbL92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMmWlxOylaiaAyEfzyrldobYfIzp91Ytb19XYnxSqfs=;
 b=OPWphFRkWTImDEM+w+6H3C4wjWZ8UG5Du+8W8rKtK1YOEKK12/Mi5W+Ezix6RaL6ubFZlo2SQIcpJXL3Q97TF6/QcOgUbvLSylqf9tq+u7fiSaDOYzAM28AGcP8RAi+r/LOxWO9df7IyyijslA+LdFNfIVw7cbmdf9V3bF/HNaavGBK8XRE2co/+VMD4LS4dRYqP7jczykakqSu8Ty7thLqsHNDmMmQ7kyZgCO/A2mImY+7p/O9Stcjhpvg10/TlfVwaTSXRunmUNPdU3l7SyZk4/QXEXWwyPNZRK0G84BrxMVxQkzIcDjVtGrytGkwMewP9ycr0oTVrIBiq7Jcggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMmWlxOylaiaAyEfzyrldobYfIzp91Ytb19XYnxSqfs=;
 b=wDJtQo4tvvI5KYnLtix1v5Xz8BR6Mm3jyw00W7BxZWjOvFiLH4WV3XW/bOW+7gQ+V19F1fDMLq7I3b6A8LpMmZtKb2Q0Z54QCuSVtxaAxcU8vGHAxCibkUN9P64a+pEioktrJ79EJg35wfx1Z1WOyK/0fJmioTo1zt4AzZJQiWA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4533.namprd12.prod.outlook.com (2603:10b6:208:266::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 2 Jun
 2021 16:49:43 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:43 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/89] drm/amdgpu: add gfx golden settings for yellow carp (v3)
Date: Wed,  2 Jun 2021 12:48:01 -0400
Message-Id: <20210602164908.2848791-22-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:49:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f64efb1-63a9-4644-d800-08d925e66bcc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4533:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4533A279B016FA5CC5DD369BF73D9@MN2PR12MB4533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJjX8FJRoYTt3syRy/8RMMVJOjFolqcrjpYvOcAEcngEi3uCF3xe3abqUvsbr2bJi+FoYutiREXTJ2Q/JmO9bnINJyrMuLqUBOh7uFfq+EVElmpNgsK3swoFRiowfJwhvnGocaeqaWEbJ6vPnOkE8nSElQf3+rtf4FwNa3+5LnCFmWvbpUyF1D7Kj6kQbyKWVyynO4ZPn4cXqEKNlu175yoyDjFiXKwX5fKe7HQSr2AW+NoDzDpYbueTZ30sHVp9OnVMFbRBTX9nTgkhJPRvwu0Z1XK/JOGqG/B4sgpeqpyzBl1d2b+bK9RhA3k+dT3G+AnFPYvSHRtz4lxEXdVmglCXTO1VcG5DbrsPLv04pyboP10RAVTDLYse764oKx5RqTZBTy3hI2KUaKph+o5Gv0/anEnNMNi2oYKe/7Qy8/OTZdUqGQSV7IYgW6VYg+RGTUj18V9D6rddDcCAntuDL23qSGJOLaF1hatt4EsdKNWQRFdZhhwNla/odzGlBXLKG3RtRlKa1Qi/LFs3kARQMZ7KOwg1v4BF4Fb4+RhiolT9FdRvEc33Zm+tzg8ev5Kfzix4qrCzn8Du+44s8IhuNYou05knyJnIPLndz+DkAULhfTzbY4r9nK6y0/7VEebEU1ONJ0s0aTyW3YkwNWwMmFE7LqKY+o5oDfGvRtqO7em3SfxWzWEcTnrEeXH4bGSH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(4326008)(36756003)(5660300002)(1076003)(6916009)(52116002)(6486002)(8936002)(6512007)(38350700002)(38100700002)(6666004)(8676002)(86362001)(66946007)(956004)(478600001)(66476007)(66556008)(16526019)(186003)(2616005)(26005)(6506007)(2906002)(54906003)(316002)(83380400001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6/0dwkBcXvewHnWnhCKsiVcygWKkbaof7DEulm7zBchslToQ4auurvLMZ0ZW?=
 =?us-ascii?Q?EmDv1WqVZAt4SjSWkmDY3lMU51QC7zriwVrtVO3aqJF/IykTxdgIPjefOkCl?=
 =?us-ascii?Q?9eE13FKTEohu7rktqegXMgprO667x/MDPqju0zvaEHP8/KYpSvD7n0n+OO5Q?=
 =?us-ascii?Q?E/wyoDMvuo0xvSh8TXpCXD3LmpGfVfOKdirgj8NDLONXHs4zcNxi/37qmWFE?=
 =?us-ascii?Q?PLBgoKg/Jwwwb5eWWRgX2CJXqEJCoSGPkD+MkubV4+7SHoftlF+GwElO69kp?=
 =?us-ascii?Q?1iECYg2CT6LHuI3Xw/bJAQzroFgFcJGUxGY3hnnpXKa0dxG7COopCU1vkdm4?=
 =?us-ascii?Q?CYSfy1xQ5eWy8WkCL432Kw3MeXJihsWESVEAE5lZQtM5RATz1QZJaGb78Gzc?=
 =?us-ascii?Q?7GGfmJAp5dYnsWEJXEt/7PppPAJL3ftBl6COXffWGh3Ajs8z/7dnEz6IQ5zz?=
 =?us-ascii?Q?4WsKWhKAxR7rGKH2usAY4+dWuvBsXo0ijhQpnxTCgc4YX783f90f/IoJr0bj?=
 =?us-ascii?Q?Uuy2cO+Jh+jMbdqsWnsLup9tepxB4lwZlO/vCb6pua0Us2IwTpDOlTu6A4pN?=
 =?us-ascii?Q?kduWPZZgOmFvc0YMPSkCf1OB8LQZ0OX3KQch2NZcB9bNdQ7jzhLypb5PFmxp?=
 =?us-ascii?Q?Ui+Zmctzzf6hgtGZBfUR8fzFLSgLc9twrjJIUiw9M2xQXmT8hYOnWIQLD/eZ?=
 =?us-ascii?Q?Ne9+ACujCdfEjTBwamP3ugnIRk9cD/kAF1f76346HAzI8PLGI0VI4jhbjBnP?=
 =?us-ascii?Q?k5MinjMqd40BWhHAXFMUPxMbOZPaSkdKiEZrY/4rc/jl2g32xbLXILNn7JJy?=
 =?us-ascii?Q?efm+UJNzrliRWbrb5KnSqhTTB8jnnxHv40sAD0DF/mN2mEDyKH0KG+4Qo6pH?=
 =?us-ascii?Q?UKb87dBWPUI/O8d1ttApjgEM5woSpPJRmnqqdRpy+VloTKdi/r2e4W5k8jPK?=
 =?us-ascii?Q?vNlOgjmCOi9GyTUaEQBqJrn6shHgAo9EY2QX4uXuruiyILuNf9z8WxzCiD96?=
 =?us-ascii?Q?7a0G97zfN+4nXCw50pghsFznL3GVv9yBolFMKkyTFRCMkOW7rxoy/6fBASXb?=
 =?us-ascii?Q?7rvTtpgJ9x23wejeC1tV4x0UR3R6qq/mXCSGjIA0fCK6rCsiww4YdPPmhB/t?=
 =?us-ascii?Q?B237nMLlgUQVRgummZZwrh2BFM1OKFuFciUWI0Lc8sEVjeMwG8bVgz01RgMC?=
 =?us-ascii?Q?2yLImBMJ89KzdgcI/N832Uw168G3KOyFajtEbIo4dMkoTlgSPIpMfgZ+CsTL?=
 =?us-ascii?Q?xgOoqHGYnRl4vo5/07Ts94ARom3dtIYqsTQp11ZiY7Kp5nOxlAf6d390LNWO?=
 =?us-ascii?Q?7ixLFIzTJUjrdt+cu3V58Bdd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f64efb1-63a9-4644-d800-08d925e66bcc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:43.2730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7xFMwhMkRZ1p68R/14OIQl5iY6Y7bV3LpFl1pF6GhcrNH6wtLoPmi4Zpki3c94RFbj0qyJ9k5YEH6tyjo0bwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4533
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

This patch is to add gfx golden settings for yellow carp post si.

v2: squash in updates (Alex)
v3: squash in LDS update (Alex)

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 110e0e8dbd69..3f6184451b9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3381,6 +3381,30 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_vangogh[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x00000020),
 };
 
+static const struct soc15_reg_golden golden_settings_gc_10_3_3[] =
+{
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CS_CLK_CTRL, 0xff7f0fff, 0x78000100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCH_PIPE_STEER, 0x000000ff, 0x000000e4),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c200),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1807ff, 0x00000242),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff, 0x000000e4),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0, 0x77777777, 0x32103210),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1, 0x77777777, 0x32103210),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xfffffff3),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xfffffff3),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CM_CTRL1, 0xff8fff0f, 0x580f1008),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL3, 0xf7ffffff, 0x00f80988),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG, 0x000001ff, 0x00000020),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_CL_ENHANCE, 0xf17fffff, 0x01200007),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_TIMEOUT_COUNTER, 0xffffffff, 0x00000800),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0xffffffbf, 0x00000820),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00100000)
+};
+
 static const struct soc15_reg_golden golden_settings_gc_10_3_4[] =
 {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CS_CLK_CTRL, 0x78000000, 0x78000100),
@@ -3670,6 +3694,11 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_gc_10_3_vangogh,
 						(const u32)ARRAY_SIZE(golden_settings_gc_10_3_vangogh));
 		break;
+	case CHIP_YELLOW_CARP:
+		soc15_program_register_sequence(adev,
+						golden_settings_gc_10_3_3,
+						(const u32)ARRAY_SIZE(golden_settings_gc_10_3_3));
+		break;
 	case CHIP_DIMGREY_CAVEFISH:
 		soc15_program_register_sequence(adev,
                                                 golden_settings_gc_10_3_4,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
