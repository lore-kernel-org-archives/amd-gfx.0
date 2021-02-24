Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9F9C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C0964F19
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C0964F19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0F036EB2B;
	Wed, 24 Feb 2021 22:19:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A9F589DD5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuGtZlOs582zDqjrc0t2/a0DpurhwZeUyKDK6J8r4/2641rLVvJEKuH3GM5Z8keJbqk9x8wsw9EA8oQ5bteUjdmd8My3JRQwtBxJo0mxiGTooWq5W8AyHoFKnAlvGu9JWrzm5/Agf1SrVYexCxVVsZD1+s0jAHvSWcGupDDpNMF6ic8KMcU/g8nDvOXbV0XindXBBzXrnUJrCO6iL1t9RPkjwF6GeIxibQVxflfHX3mWWG7W/d25YiDPg5lPRBUjjK28KtVgPbdFnL+nJB2WZr9CNR7U425615Flr++4G157SmKsO5f9OSE8o8GYu8WGOUByxJTx4vWMN65XMMGoig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGJjJempyX3t0yWQmbKd5nja/AGAb0CASBOz48ckDW4=;
 b=dwYmTbKLCAOpKA8ccSKPnmq8kB+1cbzjYSZ4+5osJ/lPEP23Cc/WdaD/biz+5lndB5Wt7Y9A9rc/YWbUwdK8qEbTu+K9GK4BjSnsWGYrpJL9gfuHqrIvFjddV1Ts41+4IcahXKZ9HNDWHbTYMquAPtdOC1boMacD46iEeuHXFx6bE/z6tC/oLoNQq0r9eMpPR6FMgZ5RYWTXLOJm3bMu4u6UZSw/Ad7zhaxkGmXeXdkCom4y0Efa2BM22Ob+VdCaB/9POuRs/JqpkCv/9CoChE1HOBUDRuhG0yi798dyMdEq926KyjvlpR/DxQBaW+FuhQ197T5xbi6iPf6pV7m0rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGJjJempyX3t0yWQmbKd5nja/AGAb0CASBOz48ckDW4=;
 b=0VoTkT9dDgMP24VAtZ7JQ/Az4BJTy5As4G9/P4WIdo0NEdpbFFXVf/LBVNgV2rR+tGwlN3R2Edp2vSrdQD0Zjn0OtfbSiMkeAB9wJ1tsBit2HUvsuAiqQKY0fAc2AhSk/JRix9Dgv0PbDnsKZvFDA3KobFg7LnKdvSE2o62dUkM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 24 Feb
 2021 22:19:39 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:38 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 028/159] drm/amdgpu: add tOS loading support for psp v13
Date: Wed, 24 Feb 2021 17:16:48 -0500
Message-Id: <20210224221859.3068810-21-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0427f925-aff5-41d6-94a7-08d8d9124650
X-MS-TrafficTypeDiagnostic: MN2PR12MB4174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4174F8026E87191344E47337F79F9@MN2PR12MB4174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LqQe8ju8gDQMe5mCJx8+m0Bt/wvGxW4/08zzMsDK5aTun5ODANq09YE/C4178lZbxk+shjFejDmS3vig//AFpfiCIIFCzDdUYSVdR06hjTjbvjkdC+luTrhIZ82EO9ZvVZ7bsFFxQRdsBZsy6JIFVDeVvl0BeeyxBo5izUeLvQ1DDorlJay1N2OtMrW2JZg/35Zv4X3+TJqECyWhKcbLwWBFeqCOKy/9E51CFWJLaEOg5gCeA4QMAZgkyvzGVJaBpSqTZqB3J4pogHT9BeH/hTvBKqxDlW0vyHr2jwwQztgc8+pk9cDAOJDcPddxj8ljpbTbDxqVXwTraaWrjy6zLz7ZOegaX1qS5v9BnLeOeAlu784eV++uxdoCndHKmcy/jY0ikHT6bQrmd8FHNIHkeWM65pAiTmivNo/uOk4WiXgDB1ppHekpFxLc62X6PKnwL/g334VJ6XQcS+rbbK7M8PKoNa87oZKLXD8WeI1nCC27xZyHmu/lLxTKKEEE8B787B242VgrXMNUquQmDG7qC86G3/qh0myONORRItLsrDzm5ZTUPLQhF2J/UKwkhgarOuiFh3Qedn3uf/ft1eRY9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(8936002)(52116002)(4326008)(186003)(2616005)(83380400001)(1076003)(956004)(6506007)(26005)(6486002)(6512007)(54906003)(66556008)(316002)(2906002)(86362001)(66476007)(66946007)(6916009)(16526019)(6666004)(69590400012)(36756003)(5660300002)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ibMgsbNCiZETWRB2lzpEalQYgH2oIup5IbZDnqrX+yKCP40hDJgAkjbSBjFQ?=
 =?us-ascii?Q?gRpeTw6op74aAEEL4UhUyJaG2FhxfRQU29y7uLIcGpjEoumtqDCAZlkmoeUo?=
 =?us-ascii?Q?pHgeh1Zsp68ZHavS46G9uqpTdnNzR4kIgCwoEhvai9gGtU69XLnLUzRFD+ba?=
 =?us-ascii?Q?KfwkCrjDAGgKObyCgV0msuQG+SIVIKfojcSP8vDrJeODfSW//OWQAaMYGdjO?=
 =?us-ascii?Q?fjTxcACS63jaugNUMBHupfX/ETxdD743JXrVOHDq8jzAnteZkIOATWXqmyrV?=
 =?us-ascii?Q?wmBm6pgdiRStBdkZnhSWW/pyPqajbKcnXxs43suuu8EnhRBzjA/U2ATkySH3?=
 =?us-ascii?Q?gnAG5KluElkH1Oz0tVY89h7ky9WdYKBBOcEOeI9+aOzDZ8Ghu8u1fFkQUhFi?=
 =?us-ascii?Q?5RnAaXG+MHRkEo0VP68wxDH7MRXW146iMhELrGgi4nfsXB/CmsaGZUkNUG2l?=
 =?us-ascii?Q?n1KeGpLsA0T+gH/suugW9BmThnoajWgfuwA0rjYqbc5ORPviFfdjU61dWP28?=
 =?us-ascii?Q?5TeDWlf6y7kDX822Tx5Q86h6dtF8FdgR620d60KcGLttO5SBWomQbzllZqWS?=
 =?us-ascii?Q?d8rhGisInpJiRRULS92SZWDGLmKtAZ4bVobFyLiN7Ses1s8J5TEvm0G8JIpI?=
 =?us-ascii?Q?sTeDUINRy07wtChoyulZz4VCYvGRaMZlxVam2M6ZVz2nJcm5HlDiAof4dEhd?=
 =?us-ascii?Q?dgcrO3ETt3+fAXy2YRP/YY2ECWTNDdo/+y7jnxpeUMfStEQBzzJxI9F7l/pc?=
 =?us-ascii?Q?i7gBdsNKYgaQA2gzPPIlGeKuoaYdbrrDYZjCU2GuYA+E+3g9m9w1AY6HdjAB?=
 =?us-ascii?Q?wWDSwBBJp/TXtD1PtMpJzVtVQ1VGBAswfTrijx+8QZwKohSBhCixiqcmXM/v?=
 =?us-ascii?Q?uGPIQgUvflTZvFei/t5p93H6NfO35ECS8aMFrMNoSpiKPOWxADnKvBbgwzRK?=
 =?us-ascii?Q?UwAS85NaqFttNd94n/OufrPN+RRITJNIKvVBWgdfuC4RECuDAvopqg5P6+lo?=
 =?us-ascii?Q?Y9zxBNRobjM+/vfQBvAwqMLhR7uFKCOwcYilOsnua85WtJykB2EabjiRyCp+?=
 =?us-ascii?Q?HoEya8xsekyEIl7DKEQK9+A2jQHnvsCJfefg/cRSuD0i0Zc3bAQKwiB6pnjh?=
 =?us-ascii?Q?sf1CXS6kX4rmDYXf/PUN/+ZN1ylOgnHDuCC/OyUDHAxGeec/6GqgnsCxbE1q?=
 =?us-ascii?Q?/OL0qfOfv6MtkgTYG+3eyWNONZbXUkz3Zbo6/D29SFeZgLh2VWzl7TECWg7q?=
 =?us-ascii?Q?Bb4eiHq1M4trQt4kheycueb/ZXhu+vbP8NFykh8BgE0sWodtJaoJyaCY5bOe?=
 =?us-ascii?Q?1hDSQtl202wUV0quDqHPaT+B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0427f925-aff5-41d6-94a7-08d8d9124650
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:38.7231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86T8FE93ecBaAmJVDDF19+gboIB3+B3jEsEwreKBzaK3XFakq4iKVleYDFsAD2FtJLNGuRGKMLdF93Rk0INECg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Kevin Wang <kevin1.wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add callback function to support trusted os
loading for psp v13

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index a76fa572258a..6bdea3f35f3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -152,10 +152,48 @@ static int psp_v13_0_bootloader_load_sysdrv(struct psp_context *psp)
 	return ret;
 }
 
+static int psp_v13_0_bootloader_load_sos(struct psp_context *psp)
+{
+	int ret;
+	unsigned int psp_gfxdrv_command_reg = 0;
+	struct amdgpu_device *adev = psp->adev;
+
+	/* Check sOS sign of life register to confirm sys driver and sOS
+	 * are already been loaded.
+	 */
+	if (psp_v13_0_is_sos_alive(psp))
+		return 0;
+
+	ret = psp_v13_0_wait_for_bootloader(psp);
+	if (ret)
+		return ret;
+
+	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
+
+	/* Copy Secure OS binary to PSP memory */
+	memcpy(psp->fw_pri_buf, psp->sos_start_addr, psp->sos_bin_size);
+
+	/* Provide the PSP secure OS to bootloader */
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36,
+	       (uint32_t)(psp->fw_pri_mc_addr >> 20));
+	psp_gfxdrv_command_reg = PSP_BL__LOAD_SOSDRV;
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_35,
+	       psp_gfxdrv_command_reg);
+
+	/* there might be handshake issue with hardware which needs delay */
+	mdelay(20);
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_81),
+			   RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81),
+			   0, true);
+
+	return ret;
+}
+
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
 	.bootloader_load_kdb = psp_v13_0_bootloader_load_kdb,
 	.bootloader_load_sysdrv = psp_v13_0_bootloader_load_sysdrv,
+	.bootloader_load_sos = psp_v13_0_bootloader_load_sos,
 };
 
 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
