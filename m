Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A813EC43470
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F5861422
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F5861422
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E7D76EC6A;
	Wed, 12 May 2021 17:31:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E93B26EC62
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7A6ENdZj161E8Wm8kyFrB5FLdrpnWsUPj0UVSUdsVQSdJUVRZDq1E3nYAxQVNKlh/pgpkZZ5MRJLj9eCCuTfPvwsdhyKTZAfORQ492KKt7+i2n93J/cXwYn6bt4+YpehQGFnveZgFy4G+AxCwVx6vlawBdd2hqDgkE5pBn/ST4C83uDdaPKu5XAgzqT6fWPxRB6n3FSSyBDK5v+RIoEPjF2/ABPacYtgAKgpsP2JwKse/NtrlVL+b5omh6WQNTEwSJgqs1BYhXsjEd/8ULZYRIwvE+VHlmWsIm84pEhYF4MZnZmH/Bl0NrNk2gDkq4vI4gJgC4GPVNGcEcC8kRm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hT+jyG/kaCch9CoSFYNyYm9ZUqqd4K07deT2O7L2nA=;
 b=CLl9wXxl2Hpnzbgpqbkc3CM4z+czyxdjGdjxRyNUXOYb8YHev9xRzhhdMsNmDfCXOUA85PEuVzMfArlF0V69RVGMFAeSwXJsQ6ad7WHbjTVdRCvuQo7+IW4ST6zE36p7NpIEA+S8H4vdusFBfZkdzyj7TDw9SYdX2VnR6BhIXioo3kPIM09cxEw0VU1YIFXfn9Q+Mvhv7P7INXfz6A0uzLvkNV5lnIq5wh5Def19gbsHnI1ZEXbU92l/FZfcDlDXf+3jizmWGCISua24nVrd946nqZenYTU/F2G9nnpmMrk16hssXavyfWPeQxzVRE942REQyJoP1fyD2LRwxBjb/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hT+jyG/kaCch9CoSFYNyYm9ZUqqd4K07deT2O7L2nA=;
 b=nXErli6x6i2KhJ2N6IZTxYCQNhzk9VV2jOScp2E1LGyLVim9XDZI9plaaop29R47CJ2V/nXObPZLA925rQOIAdMyuq4CZfZHbR70dr2MzJWSlqThBXyW8Y0OG0jtyQ3L947G658P53MPji13hHUgAvOs5JNTSGvbWrhkps7P060=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:28 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:28 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/49] drm/amdgpu: add gc_10_3_5 golden setting for beige_goby
Date: Wed, 12 May 2021 13:30:28 -0400
Message-Id: <20210512173053.2347842-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a13c0373-2653-4a67-fc4c-08d9156bc61d
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB23407752F8C076168590299CF7529@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3EjOpkNQ3cQYt18NayLmuFaQ04saNjIEAKd3JqbSgjpjFe1+l0TxFXxpQ1C9/cEW1fJ/NMCy7RZtb/VBF0VwSxx2Ub0qQPn72kVswUFZc64DbEgnSHRS0X7vTfBFiN6Fp48Gi675rUq+iGUDehGDOCl8c6LDde6lf2xEGMZhsgEqfxpePzSoUbR+J8lFj2Jq5HTFhJ7R//ppxoW4oDqDgzu2lPq0yaBPv3Z086h3wx5R08DfpndnGClXHM/PLdwJri86B1K+t+3hYFUaLV27Eq0MdmAsV7zrpxXVAkhslQiDs1Ltr1LCf4M3chiBreKH6PY1s8QHcQChN4uqeEcdCbmzGFt6gS99WNExDy+uwUyJ8Mx0vZxxLilbDZzOyV7WhK6BZkW0vHSgmXA7jNc9tmvRcpgMJAz5Tk1XeresD5W0LeES87QQMBqF/QiG9eJrDKcrUPZZDUAELyfQ1Wd6N2+1+j0WQOdZIuOhDNBYQSFaR/Ppge4LGROzu4YAPYrzZeQmtvgOr1awAbUzSkWZFv2oUMafkZc56mq7zwf+zYxcFBdeNBMnwisCU25tQCjiuhle0Y+ut2lZK8Q+P/yEJo1iE+D0BYXWTnCrCKrcoHrzRNFgvDb1qCnt7gTxYPI13aQ93kpuRp1xnyevtvmcEQeLEGQq18cGRJIdNIPzN19P99UBUeq70Z40J/MenHEO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(6506007)(26005)(38350700002)(66476007)(38100700002)(86362001)(4326008)(316002)(478600001)(2906002)(8676002)(52116002)(66946007)(66556008)(36756003)(5660300002)(54906003)(6916009)(2616005)(956004)(6486002)(8936002)(16526019)(1076003)(6512007)(186003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?V96ZGDE577BLyYAr3YVAM2DUg3ccAzbOO0IIbWi8itg8ZT/A66GxcSNfSvWD?=
 =?us-ascii?Q?9SIKJK/+WdyCF3LS5BRXkcyHotK7D3Bw/OQrasy18AEWwVWbQoEhTZ13WYsS?=
 =?us-ascii?Q?RECRBsFGkY+4UEcqDB9QyKMMVxh6XrYSu6aG+ZXR2pvam4N6sZX8hDmPzyDN?=
 =?us-ascii?Q?bYeZfxIo+7QIuGpq12IDnZ7DkGfev6uCEcDbZPdptfH5NVFQL6bF3XBlViTy?=
 =?us-ascii?Q?b+OvXiCdrgr6A9+bZFvGhITLv5vm16aAQaHcykYfTs23gOKJgPWnOSWhr/m8?=
 =?us-ascii?Q?tm4nh7HtglX6jomUG5aj3JuilIoucMTmgtB1iYGF72UhOEPCaGSFjddtEr/Q?=
 =?us-ascii?Q?XofJMqIj1J3brfBeyYu8toufsrM2Br4A3usRSosvAJYaG5b1MajHvYyV2GnV?=
 =?us-ascii?Q?niG0K8/5oO/zLERnJwB/jWpNHDxPVi6VK3pMiw8ad1hmU/0FCZa4tfDq2rT8?=
 =?us-ascii?Q?TLaSxe5fI4afDh35HnkwWSMi8okMeA0hSlsN/CsZ+I1E/a0R0gbp97dbFu3h?=
 =?us-ascii?Q?SpYsJdE4TnsE3aMqQBt4435gAegmqptQPj7Dx0/GXVbbhBVr5VQHjawNLA8b?=
 =?us-ascii?Q?LN1MzrUjxTN4gTuUiIqFkKAhv2mH6C5qadKTAoxvCFhOn5No3CSEzqNGVh1a?=
 =?us-ascii?Q?OAXNxEsSVHs7omR7YLVllMnzsUVBeWLb4kzPPPF4rkrymH2byZ/UD/vrjCgI?=
 =?us-ascii?Q?WiaME3vEv0FUxr6gJOwIttY4YaxrrQGiUX9PJVMYIUXpRCUMMukQOlMFESlR?=
 =?us-ascii?Q?QZIf757TUWbTiaHSrRSCCjIoqZG68j5KQBd+WzWyoFv3ykiFp46sYpMGJwnN?=
 =?us-ascii?Q?eWV4oh1XXhB3zZ55r2rf2k6/ML8JgzU4OweCMmZxgA0WQ37mypBf/J/PXnFE?=
 =?us-ascii?Q?rNOVZMN7APdK2qR2NntJqPKUCBMSwOsZECtjLQq5f1nA3aq0OofOUguKtS4a?=
 =?us-ascii?Q?a5kWITIXU6YANSrXusX9MYYdXvARhg7fQKSo3Zr5PnmFD3tInfuD2gg6hCuX?=
 =?us-ascii?Q?F2O5jqFf2MFBCS4bAuGvRdlhoMq2ePNfN8ALgPXhuZlOo1CjZ1+294Qvk9pX?=
 =?us-ascii?Q?cQYYVJH7ZY9pQcCG/G0wIBL92/xcgpU4IYfW4bTq6csKfOL+kEbEPweFV1xi?=
 =?us-ascii?Q?qJjv+zYjJ5Ww3YlBBW9qy7uSwTKQlDYsb3RpUHScdsLCXtx8uogpDzedsbPh?=
 =?us-ascii?Q?GMdDv5NXafluwe8FTNrRppN4ME+EPgYHpmU71vVi6fiAK8nnNxan7PswVXYE?=
 =?us-ascii?Q?qjGconRr+RRJBAKEpbfAogqR8u46bAtXnlSBENoR2OvZvo7UZRonIfQOwREB?=
 =?us-ascii?Q?WFExPlFb6BddQgP1H82IGoDo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13c0373-2653-4a67-fc4c-08d9156bc61d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:28.1085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYTOipM+o3GOOaQIyoUmaaQUR4xS7vlQtXP9ARJNHkW8SLPX2+Zc947SxOmTnGUWIBjVHNlR+hcGXDNzL158WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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
Cc: Jiansong Chen <Jiansong.Chen@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

execute gc_10_3_5 golden registers one-time initialization

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b7cc5a4247ad..20665117e777 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3415,6 +3415,39 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_4[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x00000020)
 };
 
+static const struct soc15_reg_golden golden_settings_gc_10_3_5[] = {
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CS_CLK_CTRL, 0x78000000, 0x78000100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CM_CTRL1, 0xff8fff0f, 0x580f1008),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL3, 0xf7ffffff, 0x00f80988),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG, 0x000001ff, 0x00000020),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_CL_ENHANCE, 0xf17fffff, 0x01200007),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_CONFIG, 0xe07df47f, 0x00180070),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER0_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER1_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER10_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER11_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER12_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER13_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER14_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER15_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER2_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER3_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER4_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER5_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER6_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER7_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER8_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT, 0xf0f001ff, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX,0xfff7ffff, 0x01030000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00a00000)
+};
+
 #define DEFAULT_SH_MEM_CONFIG \
 	((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
 	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
@@ -3635,6 +3668,11 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
                                                 golden_settings_gc_10_3_4,
                                                 (const u32)ARRAY_SIZE(golden_settings_gc_10_3_4));
 		break;
+	case CHIP_BEIGE_GOBY:
+		soc15_program_register_sequence(adev,
+						golden_settings_gc_10_3_5,
+						(const u32)ARRAY_SIZE(golden_settings_gc_10_3_5));
+		break;
 	default:
 		break;
 	}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
