Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D026C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7AE264F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AE264F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B7489DC9;
	Wed, 24 Feb 2021 22:19:32 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E13C89D84
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGvFzRwXOqql4pb3Mf8f3xClr6w124k5xFamIc3U5KXgOtxIQ0vqZcY+Xel3u9i3ZlgJr5r4J7v9f0lQ9pXDT7LFuW+v0BOnPjBxk7MHjsf0S+cmCzFA/j6/V01iGPDIY6wqB27x2sQPqLlxV7HS/licLllQHOTHpBbA1c6duOOTs5tDDotacguujcmWkFH5IIV0Qnu/i/WqekKKTJQ4595ouIP0uTGOp/3tLVZQKRqeOwtXXnOqziTRSyJT9lL+tnVDpgZDixXzPgy6LIW4iX/xeEwpOo/O4pGj+/G9RvL6VbQT29phyOD/tZnu4D/wX+0Qwt6KM92WZ24eAzdmnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr9in4xAft/w7rjiqFEEhkv8aMXH9Kg/TyjcXVAHuhA=;
 b=hBvgAAVNoDLWRYlZSSsJMCpls2mly1qdhICGizkWiIBwti3v3UdHS3rbT3vkWyhou3Q+SJK/pEq2qhtmLMinEwp+dBS6ZNgyYZqFsARjrsRQy377RWYIXfrSukkrUqLFqU9KKYLrCHbyA7olURcAbc6NPRiDovelJwlP/gyIzaha4yLwHnC/PvBezSmXPhUdMCgay46WxaeGDJ77FSQpjcXRMGy0lvknhhJm4g4XR8fP6OOlLNPocNINRDRraoWFORhYKyaOF0hxm5MVL4tvWXkQjIP/u8L6nNQflwi9bp37+Cfna49S5bbxdc50EHZDTvnpFWfR8ngj5PDpW9gNWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr9in4xAft/w7rjiqFEEhkv8aMXH9Kg/TyjcXVAHuhA=;
 b=5anXB4PwI6Zt3V79uMLjQs274Jeso/NxOKhIRy0Yjlbx6MQXMURjOINZin/LmOff9lFUMG5Z/fx7ZlEt0420G7DX3br0VjuT52C8YnI1C/mDJNr2nZzLV1f19ZDNgLrRWtVbtG7S6QtB13LkxOR6bY9YfTWCKo6xDttnC8EIJxM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:19:27 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:27 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 013/159] drm/amdgpu: add soc15 common ip block support for
 aldebaran
Date: Wed, 24 Feb 2021 17:16:33 -0500
Message-Id: <20210224221859.3068810-6-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4735ed84-931f-4e26-f5f6-08d8d9123f8e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41754E00032C8788340C5F90F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVR7Y35uGr/Lse4SAl3YAbLf1vDgIu2D6m+2HzLdzv5/WvcNSG8qPXiEDoxmZxAC3lFeJhUSlM4W2IWrDvVokDXgWfPVx3gaGPmQPXEB/qIvwoReoiKsa10BhTJSD0WUaFK65iv0RawRG9ZSogwB5eRRgJVAWWb0IMXeaQByuDmcv8cL0UT2d92KlSIhM1JIFsRrHbKJxiakeG1AezGwU9vZhmklqBUJDATW5vrvQ7QYvuXtrSgXg4Ra0Ya3n8of+uWn+aW2S8+3jNXFHchmAhvrY2oR/mK53rdEz6VDs4/UHXVBymTRzrwyNVSQX1Jnf3+phDAIr7E9JZAJ5D2qSIXlh+CNiACtBYsD2ADjdyHZbi8us4Deyah5KfrhU7s69x+ZARkWJTB6ocXKeZVPVGv/KZIKy2g8+qSgR9qcK+ohkokVMM8YOHqLv1KUuQuvp8KMJBvWxI/4yxyp81mDT99bc02raDgns9r86//t+vqywOPsrN6P/03N4W3ET3DnMxO3FTPFrhAgVFlPL4ZgS+s9DgAZl+QdTm7XAhZWsh0M7bVNJgjmp5++jXDGsXnhF8YSf1/yBjMgcuy+NCr7mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?e9rgIsye6MSiVv54D76ICOL7SPib2EPbkZnxbYbxaDkaVnk04qspYBOdHK4e?=
 =?us-ascii?Q?dUiLTTpFnN/sDnjJ/lq8MmkX9sTXCwAD0wOJilvbIpNB3OMDW1gszgxZjvYE?=
 =?us-ascii?Q?LHwqSJLLfQXNGev6mtX+6tk8HtQz/PmHm77T0OBbFMQ83W55GLfEgnAMXXuz?=
 =?us-ascii?Q?T2VcQgrcvM4Cl5NGyJi5puNHvAW4ioeN5CXlqRuNYV08E9xJIvxkhoOAYubf?=
 =?us-ascii?Q?3mWGUbRCCh6PjszGQhXJ2DhS+jQNQqeAvv38opZfh0g+znxfAFS4Mo2tk/hB?=
 =?us-ascii?Q?hLpDHP6+IzudachPJJd/zHnH2YMD443ivqpH3PwQB2MuHVg1wYbK5DjrHilB?=
 =?us-ascii?Q?KPOJaLL4lmhQzR9Y5uNQaVrb/eMtx07vqnE+JiutHaF/IhbCkKrso+as2S/B?=
 =?us-ascii?Q?12sbDutCECicxWRC8qPm9PZwol1S2c9u4LX8AwHJkbojMOk+MLF1sC1394V5?=
 =?us-ascii?Q?bN6Ei4VnzyWMghRaAsD+buwMoEgH5TVEjdJerVJ4P8B3YbFdHnQp25aie6ib?=
 =?us-ascii?Q?Gu2HwT2hHmH4NLtf1Ln/T68F6407UM/bV80D4QVb4dfhVpNm4/J875tqslmN?=
 =?us-ascii?Q?bAh9zRcC/0pCft6fWlgNw+8wRNjzWkGLjid+xMBsinSMNjApEU4Jz1Cp3sxF?=
 =?us-ascii?Q?OVhpK4caSVcgskuzhYzf61S1HS5Vht++nt2AMq+08RHKaFQGZySKvxq2dGzt?=
 =?us-ascii?Q?PlXhbWOIt0j4/gvcvEzbpUgdBeHLtxOEl1uIidgHS/bPo8OKeR17wqh7e706?=
 =?us-ascii?Q?cTMyhadIde2XKmAxMDZ0biq9S6DwL9Q84jAgOaxTWp0FlbqGHCT/7VHayQMs?=
 =?us-ascii?Q?ZYSWDBoRZ/8IAQsTtWV4Ay+VcrOLQ2QCKmx+pvg3lx2a8K3E4srLzOOuPEK+?=
 =?us-ascii?Q?ksgTYFjIxnYKMnC2mfWOi6ze3Bn++CjsY0efGFsag4U7ishn2aNE4yPm5RUj?=
 =?us-ascii?Q?7E5Ju2j/Iv9BWbtvCbJE0csLA0OH4vfLoL0cwrfqqAlBYCUD0D8qkOvcCbrT?=
 =?us-ascii?Q?XXA0R95HZI7c2+Bu32IzAdmb0ZrG8mCpnr03HoCEig1Fue0MlA9+Fzb+4s5V?=
 =?us-ascii?Q?5VO9y2to8hx520Ggn/UEXUQy84BZEMKHNntsmGCS0PYQageHWjP5B/IqTMUT?=
 =?us-ascii?Q?UX8kBqkGnQmfvXtUmNvXJZ+/ECfm6ksosal68FbC2GUn82Q/Zz1j+5flHUCb?=
 =?us-ascii?Q?qOOhTt69WPdXVb5oDjzz2EimrWyh3Vw7nXbB3blaGFht0x5oxIxAb32j9DYK?=
 =?us-ascii?Q?x8uFNeiVX2Iu7qy4HYeZKTO50IVYQp4fo7HYKRmLkIpyrXqJqNjdyOdLyB/M?=
 =?us-ascii?Q?PwmZNcFTpUCFlYO2pKBkhIt4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4735ed84-931f-4e26-f5f6-08d8d9123f8e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:27.3849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2HDXlUVviLjYoSrp+ZESO4pz+iYg936JZPDoo91dK0jyL622Jo6nrmsOtPbpxb5M8DlGaggdq6213Lx7+ir6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Initialize aldebaran common ip block

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index fc1eef339d2e..df7d8aea57e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -693,7 +693,8 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.funcs = &nbio_v7_0_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v7_0_hdp_flush_reg;
 	} else if (adev->asic_type == CHIP_VEGA20 ||
-		   adev->asic_type == CHIP_ARCTURUS) {
+		   adev->asic_type == CHIP_ARCTURUS ||
+		   adev->asic_type == CHIP_ALDEBARAN) {
 		adev->nbio.funcs = &nbio_v7_4_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v7_4_hdp_flush_reg;
 	} else {
@@ -702,7 +703,9 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 	}
 	adev->hdp.funcs = &hdp_v4_0_funcs;
 
-	if (adev->asic_type == CHIP_VEGA20 || adev->asic_type == CHIP_ARCTURUS)
+	if (adev->asic_type == CHIP_VEGA20 ||
+	    adev->asic_type == CHIP_ARCTURUS ||
+	    adev->asic_type == CHIP_ALDEBARAN)
 		adev->df.funcs = &df_v3_6_funcs;
 	else
 		adev->df.funcs = &df_v1_7_funcs;
@@ -829,6 +832,13 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
 		break;
+	case CHIP_ALDEBARAN:
+		amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
+		amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1247,6 +1257,11 @@ static int soc15_common_early_init(void *handle)
 				 AMD_PG_SUPPORT_JPEG |
 				 AMD_PG_SUPPORT_VCN_DPG;
 		break;
+	case CHIP_ALDEBARAN:
+		adev->asic_funcs = &vega20_asic_funcs;
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
