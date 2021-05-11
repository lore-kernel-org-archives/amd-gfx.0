Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2347C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 03:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7E961154
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 03:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7E961154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5750D6E9AA;
	Tue, 11 May 2021 03:52:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AF646E9AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 03:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UogP/8soWPWWlUEew2pgm9Qt5HFxLMMUFfGZN4tOT6wRmfd7tiz/avo4NFKW/chv81p3HymwA7ivVMJ5h1LD9Fq2kF7SHYUlTsYzT7jfaBZL5+HQLpr6AyMEouhtJ1zSTGvcLhA7jPkaJSjB7dtiN4kTn2nrdRTjBK1NoBWu2ELAEtHLdN8aOQabkbTLC5rAypIR7ceukNmPMZjI1B9wvKLWibXL/fb7vbC2s6lvxMOSdmhqCesw3kb6ZYMlb0hrxWPtMN0Tts8ChNUmBoT8Yj8nJhWYvpGE7kabfRv2SS94m85f3q/lXIm4dizMfxjHNtqvTVnRjeRbSB97e2P/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBWLyEly7Bjhok5Vk5duUNJ2fby84d98G9nucQ3o1dI=;
 b=n7rfcDSb/+ahCglBKrOsvrG+ab8gf1p70IES1FpLS0wRKlO+d4ZnLBDv0BvEEywcDG+kvKgNGpHbCEB/Oj9G5rSp5TTegxcDslHlji0JSWnKhTLEwHbethC+tsqtbdlH+443cMYDmPv4+OwwG+FFCxJ9c1qelkcrKn6/Wfbmf98U3Azq87n2JKN3RNu6YCliodRxIiVBU3t4z+E0CEC+GlqPlgrKgn7AJIEUTNMaTmZFSX4qYX+dDh7SFv3e7uO1bo0g3dq95Y2BHHffVnm94Oa9MBMSdDEfn1RLIO23jUzp6D/6xbPtCQt2hHf3KDCSIcxSyENng2UaCzLvi3FcRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBWLyEly7Bjhok5Vk5duUNJ2fby84d98G9nucQ3o1dI=;
 b=UsOdgB7T15X55gwoD5nxoXJJ2bjZwAJML1Cs0BkN6+xMyF3fzCoaVP2XsDtfIG5t2jvXbJWYYt+91AJkJU8FEE0sps+meC5UfTI5DnTqNJSOFkDaCSmaSUS6U3Z4e987UtQxPniaDO3v0qxoxfSXEDKmx0GM61rlKRPWnRvkmeI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30; Tue, 11 May
 2021 03:52:38 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::41bb:78fe:94ff:aba1]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::41bb:78fe:94ff:aba1%2]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 03:52:38 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: add judgement when add ip blocks
Date: Tue, 11 May 2021 11:52:18 +0800
Message-Id: <20210511035219.2291350-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0075.apcprd04.prod.outlook.com
 (2603:1096:202:15::19) To DM4PR12MB5181.namprd12.prod.outlook.com
 (2603:10b6:5:394::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HK2PR04CA0075.apcprd04.prod.outlook.com (2603:1096:202:15::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 03:52:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 904851ff-7a28-41a4-5035-08d91430382d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5198:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5198C98AAA7979CF79716DC0EF539@DM4PR12MB5198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hfpxxz57Uv9F/IB0PsLRDKg/CEicnoFaCTjLQE4yfYWFKGk/YABy3L3V5LRD963tLIK6F9er1IIYdN3XIf3IpotuprvFKQaQngnIXlyGTGYDTTe4EOQmEg3OKE3Rjr2J6I1g0HhJB+eLnP1iL1ICXBCVIXu2iUy/TVETvHo+uDi2txNcUubfSWRMsvOogSH7BVyX5BrzUUb7ncpwa3rKq/NbnD97LuT37iGwKs+3k/vfWI01w3Tq+kJr336i2s3blvZhjHMCCbLFwrq7M6V3FDqhIELhlr+8BFTRXzsjZJHfMzCp7MSN8/U9Vg9Dmp9Ek3KttuBmm2U+XakWG0VFRD4pT+8dn7Asm7Tu8h4HYx+yx7tnW87C8oAJNYDgrcBKBhN9v7eF10Mf2Ws3y5stu79cRf6qw494VDWZr5Ezqe8NgcJU0wOSgKWzRCPlUVbzR/GEVobTF+GQ1Za3kot4/ru2iY5FZOzfrloMHSLPl8Bl8dP+hzjvrXXbLdCOeth+7iFRoJ3Cz0bWXTBvRgOWtm1pxHJjDugJaFowa1tfF6dbRv7tqtJ74WHvQrhPOl6s+rNT44zQk0Q3hTVasL6Ee4VHktLIsGoqQy8133rbY8xdjxnA1KggLNPnbQNO746Mp+/DmTRuNgK25BohJJ1iaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(6916009)(316002)(2616005)(6666004)(86362001)(6486002)(7696005)(44832011)(8676002)(83380400001)(5660300002)(478600001)(52116002)(54906003)(26005)(1076003)(186003)(2906002)(8936002)(956004)(36756003)(4326008)(38350700002)(66476007)(38100700002)(66946007)(16526019)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YzAxFLR5tK4uz2rKa/l7T5HHnlJV8b9ceSKpbpjLBS8AfDmSOs+xn7UnGyBy?=
 =?us-ascii?Q?FVhwHTEk3BR2YF1JbdxJVojon4vI0Gn70BJX1VoFP1+b9VaYwk8LwBXGOHBy?=
 =?us-ascii?Q?iR/9if/2tdFVjEjJjIeOOrYnKg2YZ8Bbixku4UKycFNkLnixBS0JxuyLLouX?=
 =?us-ascii?Q?5bqFan3PsPGTu2bTqbdzYLhP3aN3Tnf2C1DsqEwsxc15Ru5Bn+4F5vZwIRxE?=
 =?us-ascii?Q?NKg00VnUB8Obsu4/P6oQ/YTBDJXOaQbT+CTKSV17q6GC038eqjZCGTg2eSZt?=
 =?us-ascii?Q?GqjvLMgu+7Dmi9deKhh9P39RDJID5m83+WQx4Balvvc7G3GXb8f4Yh5fQIJn?=
 =?us-ascii?Q?7KJEF3YdnmMNUN5R9tpGhdTSXVTAUQnsYklNzF87ZWO3toqJbO1epJk0u0Fg?=
 =?us-ascii?Q?49wwC3Nq4ren8JfQAqVsAQ4JLmrzS+bijYRUwmYQZqSHfUmZWvDTo8Xf+zgF?=
 =?us-ascii?Q?Jia9krWnQugbAUyI5/jcWt1mG4zlhO8I6iePvXuU+SM+B7Dam+nEkEvtQWHY?=
 =?us-ascii?Q?0bn51CcYUvf0ws3MhqmvfqtD4MvMwyh6YA56lb1fJG42WjlcHIliwzLG1VKf?=
 =?us-ascii?Q?zz2//D4bpLNI/K6OM/aXDJudQkpUQQcJ2A+9Siecpk6rjwrtmDu1KcNafYMu?=
 =?us-ascii?Q?zQO5SENrxIRRbH85YvCz5H5z1ztxYCNLEBQ588HqjvkJEt8WZd74jsYMdePQ?=
 =?us-ascii?Q?To2LROFtHpRK+JwxpMTFzujkEFdpjGRXj66KkdGCbTztXmfayqOe5s8a0klT?=
 =?us-ascii?Q?9+Q0u4Bng4Mf9BgJ3a2sGzoj8GOpNFdB0N2yyLy3bGeQF6zYIHwaxsiD5xEq?=
 =?us-ascii?Q?imF6gIdcNTjE/co5sL1pfzmMzXW0/EM9U5OrNtgecphVGJ/U2Do17gMe3wuS?=
 =?us-ascii?Q?kPJBYU+hMIDMBgSNiD/Phcd/DsDkeBe7DWRlK94OIAp/HsD+ezgsxVlIR/4z?=
 =?us-ascii?Q?fsTsv1y2Jg+74S8Pl2ytHOPKlohMdWcixi0gbiXs+sP8CcNxVzrBeaBGl8Ul?=
 =?us-ascii?Q?yAg7+9DcRv25iFsGq7tuJpiGWX84AhDjPQzmAD/bXARhre+tVjPYRWNsn90z?=
 =?us-ascii?Q?IrWSlp+DgnW7Xpt4MZp5AZp13YNIrNZcpJxOYI/oRbP7c/gTanNtDxpvtZ5L?=
 =?us-ascii?Q?UAUJusgv3Dt129mP6v9a8oM8tNssznXQqIPUGl5gxtk6dbcCVBnlAyy0B1At?=
 =?us-ascii?Q?LXB8vYWpucNhrEqTbHWqMuggjukFQqapQXV6HKXCydON4RLoJCKgMrpJtwg0?=
 =?us-ascii?Q?YPJmT7qnVGpOCgky+BdBu8P3caVv//BIbgpgd4P9PiCWm6gep6GzFwyD7uo7?=
 =?us-ascii?Q?I+7xg4qACaophoAi+glwl867?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904851ff-7a28-41a4-5035-08d91430382d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 03:52:38.5146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IG8ynZ9BX9Q58vNIdyglmkheKNzhKz2wfwhj/Hd0EgFRc5ajvTrb1ozRxXF6+n4I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Likun GAO <Likun.Gao@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Asher Song <asher.song@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun GAO <Likun.Gao@amd.com>

Judgement whether to add an sw ip according to the harvest info.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 15 +++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 30 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  1 +
 drivers/gpu/drm/amd/amdgpu/nv.c               |  8 ++++-
 drivers/gpu/drm/amd/include/amd_shared.h      |  6 ++++
 6 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 10d9a8a237fd..3147c1c935c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1010,6 +1010,7 @@ struct amdgpu_device {
 	struct amdgpu_df                df;
 
 	struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
+	uint32_t		        harvest_ip_mask;
 	int				num_ip_blocks;
 	struct mutex	mn_lock;
 	DECLARE_HASHTABLE(mn_hash, 7);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b0543f409039..6881015f40be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1683,6 +1683,19 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 	if (!ip_block_version)
 		return -EINVAL;
 
+	switch (ip_block_version->type) {
+		case AMD_IP_BLOCK_TYPE_VCN:
+			if (adev->harvest_ip_mask & AMD_HARVEST_IP_VCN_MASK)
+				return 0;
+			break;
+		case AMD_IP_BLOCK_TYPE_JPEG:
+			if (adev->harvest_ip_mask & AMD_HARVEST_IP_JPEG_MASK)
+				return 0;
+			break;
+		default:
+			break;
+	}
+
 	DRM_INFO("add ip block number %d <%s>\n", adev->num_ip_blocks,
 		  ip_block_version->funcs->name);
 
@@ -3111,7 +3124,6 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
 	return amdgpu_device_asic_has_dc_support(adev->asic_type);
 }
 
-
 static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 {
 	struct amdgpu_device *adev =
@@ -3274,6 +3286,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	adev->vm_manager.vm_pte_funcs = NULL;
 	adev->vm_manager.vm_pte_num_scheds = 0;
 	adev->gmc.gmc_funcs = NULL;
+	adev->harvest_ip_mask = 0x0;
 	adev->fence_context = dma_fence_context_alloc(AMDGPU_MAX_RINGS);
 	bitmap_zero(adev->gfx.pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b2dbcb4df020..99255c2f08f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -373,6 +373,36 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
 	return -EINVAL;
 }
 
+void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
+{
+	struct binary_header *bhdr;
+	struct harvest_table *harvest_info;
+	int i;
+
+	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	harvest_info = (struct harvest_table *)(adev->mman.discovery_bin +
+			le16_to_cpu(bhdr->table_list[HARVEST_INFO].offset));
+
+	for (i = 0; i < 32; i++) {
+		if (le32_to_cpu(harvest_info->list[i].hw_id) == 0)
+			break;
+
+		switch (le32_to_cpu(harvest_info->list[i].hw_id)) {
+			case VCN_HWID:
+				adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
+				adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
+				break;
+			case DMU_HWID:
+				adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
+				break;
+			default:
+				break;
+		}
+	}
+
+	return;
+}
+
 int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 {
 	struct binary_header *bhdr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 8f6183801cb3..1b1ae21b1037 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -29,6 +29,7 @@
 
 void amdgpu_discovery_fini(struct amdgpu_device *adev);
 int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev);
+void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev);
 int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
                                     int *major, int *minor, int *revision);
 int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 82a380be8368..d261f459c982 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -635,6 +635,8 @@ static int nv_reg_base_init(struct amdgpu_device *adev)
 			goto legacy_init;
 		}
 
+		amdgpu_discovery_harvest_ip(adev);
+
 		return 0;
 	}
 
@@ -777,7 +779,6 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 		if (!amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
-
 		if (adev->enable_mes)
 			amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
 		break;
@@ -1154,6 +1155,11 @@ static int nv_common_early_init(void *handle)
 		return -EINVAL;
 	}
 
+	if (adev->harvest_ip_mask & AMD_HARVEST_IP_VCN_MASK)
+		adev->pg_flags &= ~(AMD_PG_SUPPORT_VCN |
+				    AMD_PG_SUPPORT_VCN_DPG |
+				    AMD_PG_SUPPORT_JPEG);
+
 	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_init_setting(adev);
 		xgpu_nv_mailbox_set_irq_funcs(adev);
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 43ed6291b2b8..9ab706cd07ff 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -216,6 +216,12 @@ enum PP_FEATURE_MASK {
 	PP_GFX_DCS_MASK = 0x80000,
 };
 
+enum amd_harvest_ip_mask {
+    AMD_HARVEST_IP_VCN_MASK = 0x1,
+    AMD_HARVEST_IP_JPEG_MASK = 0x2,
+    AMD_HARVEST_IP_DMU_MASK = 0x4,
+};
+
 enum DC_FEATURE_MASK {
 	DC_FBC_MASK = 0x1,
 	DC_MULTI_MON_PP_MCLK_SWITCH_MASK = 0x2,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
