Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88C5C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 03:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6914B64F8E
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 03:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6914B64F8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2181C6EE3C;
	Fri, 12 Mar 2021 03:53:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AB756EE3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 03:53:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idV+Q3jFJOd9cTd3vIoNOeiIfaGZCw7NGG8t83wPJhb1z9i1GRyW+SEaq4PhLnh74Wrd2FV9JwXyux1XOY108MjE1s/VXHy9K1Ce/FToF38dEhqrd+ip5rmPE4itmZha1BNNRkCFQHCFvcSRmZAAU86+cEJhVZcG+ycbJzlGCeV0xYMqhTrSZfMkrfn9Y1YLnjRgdGBE9bu+2bTUOV8haOGiIb2ZqGmoGcXnPYANssQh3GNoRl3ExLWaF9LNnqlUm3ZLyFWLLrWfCOHz8S6AOXiGU3bgw9yfkBywkKThgWFevHVN5IysylSXdXELC0v1puAIomvT689K2mGpQQ5+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGXPfmp2sn81hVFkWHe0hhT6nbrN8WarwOymSg47p8k=;
 b=h/myRqL7sfBVv6DoKHcVr77z0GUJQX5rk0foWPplYHtRJUkSuWhHhtd5zcsfFTAgqkO5iSNWtyqzwZ3RDZXnBHRD2dwtNxJKL2O6LT/wtNI+98bD+49q6gjoiihfKKbmyQGwXEG+eE0377ow+49nd+R0rozXLLu/vcd28y7cFpClHj3lWkcBDJNHyzkxN6bwavwyjdFlt2NPwS0W4v3hRUkOq07GVefwyPsUqjgCZD4DItHJ6aasSQmZ8PhVCpAn5sZx53Z7wd0fzqIhOsnzc0BYTAB1ZIZkAAmvz0qpZAv/pxh4q3tDIGTJb2ZZEeWwuQoZS1P77AiWP1vr+spnfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGXPfmp2sn81hVFkWHe0hhT6nbrN8WarwOymSg47p8k=;
 b=V6df+UA/ZTC/wGuY10SFmgw5ykMydsL/8hxV/ZpGAjW1JcE0nzxCHgwiXDPeU5dt/9n5OZYlincfNnMWmoP44Snb95IzdWvjIw4d5jpsAZk75ZTEx0/SVbxCDmisKVBcc42WgZ2NcW9OoHYRObj2EH/wrHh+YSrm6p09nXLUyOg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:10::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Fri, 12 Mar 2021 03:53:46 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3912.030; Fri, 12 Mar 2021
 03:53:46 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: support query ecc cap for SIENNA_CICHLID
Date: Fri, 12 Mar 2021 11:53:16 +0800
Message-Id: <20210312035316.2631-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210312035316.2631-1-Hawking.Zhang@amd.com>
References: <20210312035316.2631-1-Hawking.Zhang@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0036.apcprd03.prod.outlook.com
 (2603:1096:203:c9::23) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-System-Product-Master.amd.com (180.167.199.189) by
 HKAPR03CA0036.apcprd03.prod.outlook.com (2603:1096:203:c9::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.11 via Frontend Transport; Fri, 12 Mar 2021 03:53:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be970b0c-39fd-449a-cc50-08d8e50a700d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB14494C2671A414F3DBFAE5F7FC6F9@DM5PR12MB1449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /SWR+AsSi1z8j4U4biFVC5QEvax7TAcWBBKiolBAy4Y2Tw4e6D3HJOW71ht7MOZA32EmY3a9ZbWadOr3kggbf8ogVljwCdvIo98IpFWCY4Ef5J1KxOmXOEb1hJ2X/IdOTYQXdwKyRK7xEsZ+LycgmYOAPCOp/BMihDEqiZxSkWhGnoZENMbLZn0MWJ2BFNlatPiW9DeMliAq1iudUjXpAvfxaG+K9yMMw/4KA6R1+BJDpuMpTK6LFf6AXNt9bJtidUnrNaoCUEF9PcfVCfy6fPhJBq/nuNca0izCO9hnLo2m/fP6KIHqp0UeUONk+nAO3MnbdfGT1RzP9pHzzqjGn5xrSjQDqvLUL+0fiqS3FhAXK3ib6iKwZywsDSEGGn1F59j8xRCM9BdH4HSm5Pa6W2izoPkTAdUzAwLmhW2qW+3Wp/k7EKAUTbYWJVk8bMPfIGhrz8Nk4eauHuXVY0LvmSpVgs+byAIXRfSvcCOmqjWpjdlvd+fy1JiiElHSKMaFDIIAUtt91zO9N8+NO6dEzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(36756003)(316002)(26005)(6486002)(2906002)(478600001)(8936002)(7696005)(6916009)(956004)(2616005)(1076003)(6666004)(8676002)(66556008)(66476007)(86362001)(66946007)(5660300002)(186003)(16526019)(52116002)(4326008)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZBpnFk/K+mmzbZ8TBmUs4zxlFbeaU6jjBlYYvMB0FQU0da9lxqIASnBdsojH?=
 =?us-ascii?Q?rOUIDzSiJhSaw3yHUIHQN/sfFunQY6l+0khvfhClLGJkkYW0cnbuI1o0vnlX?=
 =?us-ascii?Q?P2mJfjxzxKFL9Sbzmgl8uhnbX9FHYL4qXU2LeWHBxtZ1m/oy4w8kWyTmwAWX?=
 =?us-ascii?Q?8P0CVcNus8+hDPiSwKk90s6kR3PpY8LVr6nHz+PyqMik0YM3sCEBp4bMnNFh?=
 =?us-ascii?Q?ujTaaw2f3Y0fvXVDWJiiBLwfFGIcaHw9l+8vIjCcAPDn3kVFNN8OVkjWF4m2?=
 =?us-ascii?Q?dzoktVjuKbk3PuvbXqMp8r8xb8HoBNJlCqAjUfh8KSst5WUjcy6PDxqJnu/o?=
 =?us-ascii?Q?36Q+DT7a1aLjyUms/l2a3wCxBsX2q9KluTT1hQSQUbXgOtHlUGzS5GVBaw5W?=
 =?us-ascii?Q?X/g3vlHmxSnIb/mU1ow5UjKa7pgAQ+33LiIeitPCGR7dtFzVhaIQHqhGSgWd?=
 =?us-ascii?Q?DTKzwN1PeiirW3KEd4cV36YiBEf4VJ39f9kSCW1T9qWTmWDODWgj+5P0T5Q+?=
 =?us-ascii?Q?Sw4JhoLrzwSlTltQFSYztaoAgYYQMHZafxLXB7dhRzFzOG2XbFPtjcD6RhHH?=
 =?us-ascii?Q?CMKFUTaUu7UqXA6rIS6xspc1brY3vWmEJHVgp1ACBYU7lVobNwKXJQLUfJ2y?=
 =?us-ascii?Q?MSIBZtuTMlIFs3aNI2xuWlwG8oP6fuBH/mHOp9xouEk304lcywUtSo7qmdK0?=
 =?us-ascii?Q?d/eInjyKYdiI4jOQRH2YWtlghrnWxbaYq4fWePUwYu+N9r3CPXeynXTrbh4B?=
 =?us-ascii?Q?6nfytQH0MtZly1a3wD0L75KrkwIjSgfh+Ug/w7Y/X6PTD2MH/rHzCe2sxdcd?=
 =?us-ascii?Q?ZUvsuLlTapPnUGOKqEi1w9RBuH1XG2eXIPLEAqvDwGWzlOMMFS5GMqCfJsss?=
 =?us-ascii?Q?9ytSxsJh4MkMSD74hnnDLXbIDj3MhR31jJGs43WEnmV+aAeecNSMat+/budA?=
 =?us-ascii?Q?W+vGGSvRE2RvytCIYsl6yxbw4+Ozq8BjXG9OMqY1x+KbCZgknra8g1eui7ac?=
 =?us-ascii?Q?HQ3tWPLICbioyumKJ/y4A1JuaT2S3t1ani2XK6Tc3ztFmJLPwdmZlr8x+Pgy?=
 =?us-ascii?Q?WbswAR6DPc3qdd7FYIgXF+Hi3/iTD04YsHQCglphfrPqicDJ9K/0YFx2NigL?=
 =?us-ascii?Q?6nVIvkvq7zrfnQt8cMQGCjmVpcquhjFXAvIcST1LhcbAUCsaEmIj9Ahok41g?=
 =?us-ascii?Q?zNpDUjByUzkoSjInsdl02/+JZEYji1yAv/550+5IK/jR8j73OY22x/seEbXr?=
 =?us-ascii?Q?e7+INcutzwjfFLTqgssKUK8pDqlGaHILsMzUqTE5fd2IgmvbypYTFecFHok4?=
 =?us-ascii?Q?T2vLthkxo0tib1BqbUik4NNqoaDBZezyARg0yaaup/P+nA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be970b0c-39fd-449a-cc50-08d8e50a700d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 03:53:46.6914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLFEXQL3oZKLXVtHF7AKs0ADezvErEMFnLp9SJFXm+TWoseCs44KrXlNPbtlkP+A8McJi2lWhS/SHwUg1LFy8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

driver needs to query umc_info_v3_3 for ecc capability
in sienna_cichlid

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 28 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  4 +--
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index fd1d2cface2e..0612300284fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -117,6 +117,8 @@ union igp_info {
 
 union umc_info {
 	struct atom_umc_info_v3_1 v31;
+	struct atom_umc_info_v3_2 v32;
+	struct atom_umc_info_v3_3 v33;
 };
 
 union vram_info {
@@ -343,13 +345,29 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev)
 
 	if (amdgpu_atom_parse_data_header(mode_info->atom_context,
 				index, &size, &frev, &crev, &data_offset)) {
-		/* support umc_info 3.1+ */
-		if ((frev == 3 && crev >= 1) || (frev > 3)) {
+		if (frev == 3) {
 			umc_info = (union umc_info *)
 				(mode_info->atom_context->bios + data_offset);
-			ecc_default_enabled =
-				(le32_to_cpu(umc_info->v31.umc_config) &
-				 UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true : false;
+			switch (crev) {
+			case 1:
+				ecc_default_enabled =
+					(le32_to_cpu(umc_info->v31.umc_config) &
+					 UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true : false;
+				break;
+			case 2:
+				ecc_default_enabled =
+					(le32_to_cpu(umc_info->v32.umc_config) &
+					 UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true : false;
+				break;
+			case 3:
+				ecc_default_enabled =
+					(le32_to_cpu(umc_info->v33.umc_config1) &
+					 UMC_CONFIG1__ENABLE_ECC_CAPABLE) ? true : false;
+				break;
+			default:
+				/* unsupported crev */
+				return false;
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 93699ea4860c..ce025aa4e332 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1915,11 +1915,11 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 		return;
 
 	if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
-		dev_info(adev->dev, "HBM ECC is active.\n");
+		dev_info(adev->dev, "MEM ECC is active.\n");
 		*hw_supported |= (1 << AMDGPU_RAS_BLOCK__UMC |
 				1 << AMDGPU_RAS_BLOCK__DF);
 	} else
-		dev_info(adev->dev, "HBM ECC is not presented.\n");
+		dev_info(adev->dev, "MEM ECC is not presented.\n");
 
 	if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
 		dev_info(adev->dev, "SRAM ECC is active.\n");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
