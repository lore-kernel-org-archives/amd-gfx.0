Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D74C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0B064F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0B064F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7386D6E0BE;
	Wed, 24 Feb 2021 22:19:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AA4E89DD5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMZ5kcnnuNODJZNPyD+YqPzDlEkzHuiV0HMy/NGD38nNiHk9e2c2g9/+1qtczVqyKlvdtATIYx4yL9Uxh06oKl1ObixDuUthTg6ueaSXLOKUhLKTXIFlsPB/beUEb+BbMdXftPvnHUvqnnlPYATYLlRHVkEinBQ6CdVz7OkVzSheDhiPmn93jTjeEV6xQhmDkmMMympWktTmT3/HQXTpnp7MbliqR5C+CES21ROnvwfE27Z4sLYpk5bLpq0XkR8HpAZNabUDdlIwAKURiu2WpZbbuDjEOeFXQ9QRYrMFbUkxAMW/W+D0hZQiKTzPo+vxik568hDtDhKOK2puTmD3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj1y88STM6Cmp5l+y8s6oXUY/v+J2HVbNsdEqtXJACM=;
 b=FYS60+jHvhRpwly1tH8rgebEXiW0DUnPMDIuHkLwAgymiElod09zptP31FzVaxZxBgsqdPcs/GOvM06MQtdJiExw9Cstxlp5Ne7/gRwmupcEHnxZp1zloE3VSrWEeHpgm9ZhOMbrmUEBlvbXV60XrhHaG4nwkkxCuZ9q5nFXpEA3PXP158wr3hN6QeRLxNwPG7nXtcyZkhXPVjVX81YavCV+9RQDkH52W+JGodltIEczZvbIuvXMb47soCjZjqUk0c4N1b35l5ZLLDS5+FRwN397Oajz4eqvZYwBc7E2NWnTXOo6DFRmN6InczZy3OFJoEBKlhAQ4SIm3GCZYvnd3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj1y88STM6Cmp5l+y8s6oXUY/v+J2HVbNsdEqtXJACM=;
 b=sKNAvcTffmFkyy9s/vVmpK9D3kn6KaVd6ye5dw8xg2U1QnRxoGCRmq9vEWWqnVpuiGhrc6AEj+E7Ay99ecgA/ib07GXVqDQrNmkfXH3xW/ovsk8MgPZqM4STdkCypn3EJgpiA0tW52GKkWZBdZ3bQOfxyfqLyRJuUUbEmXHQov8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 24 Feb
 2021 22:19:37 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:37 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 027/159] drm/amdgpu: add sys_drv loading support for psp v13
Date: Wed, 24 Feb 2021 17:16:47 -0500
Message-Id: <20210224221859.3068810-20-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45242f77-30f9-4aa8-a633-08d8d9124570
X-MS-TrafficTypeDiagnostic: MN2PR12MB4174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4174E3E66770AFC2E7F25B75F79F9@MN2PR12MB4174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9zDlxXiikUvdAPnJe4Cy7VXr3vb6DC63TeWBOvHQTMcR07A2RC+QcVrT7gE9OKdc4LhAOBK+vicFcMcsR653g8Rb2eT3asLf8gvXab9dcWlpZo2Im222ka1SWedvssajwawetOetur/hak+5jaBOaR1IdFpHLkuuGF1jrwIohUC3wLx7/XFxzOLsvfeF3Zw2fu84+EjAUK98kV19J2VG57yhqJZ22V0/RCxJVsBF5sBD0MkejUwDnUg2dYrVY0ZHSUOih+GJ5hjzSO6zoEsKHQbm4tu0PYs3HJ5pUoEvODR5+zpz3LGuR4sedhNLsX86G3w24ddBIj5NuK88XgjCUnx5NnIyJbnSDxBNTgRfxLlwB35utqcCE4zqtPVIyQU+FuCXyPUDptn2wmfuiEU7Fh6tzz84SdOizAbNFS/7lpQtTWTlNHDf8dMMiWuu74Bbog7pBe/sUoYEigLrl4Pcj+B+AvGfAK2oZSgFQ2zVOwxY09pBzzxivGHeXeIlcPEphnoM6UmFfUsAUVNg45pDNXy4huKvAWGRxJo6Ysi6us3WheMn5vf58VejijqBFsfCIC29BScV6gKWfE2obH4ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(8936002)(52116002)(4326008)(186003)(2616005)(83380400001)(1076003)(956004)(6506007)(26005)(6486002)(6512007)(54906003)(66556008)(316002)(2906002)(86362001)(66476007)(66946007)(6916009)(16526019)(6666004)(69590400012)(36756003)(5660300002)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+KBFBih1tqFXMzOoampBi3Jwm4dkmMvhuJ02LKLUfLY4N4rCWXTRjQywMiah?=
 =?us-ascii?Q?KQVxlnu/cnwwgw8RYaAA4uH+FSD5Y+YC36/1V+immt3DjXw5NJ87tTWP27bm?=
 =?us-ascii?Q?5n5YgkD4nDtc8Vk6f02ExTEVbi5nX6oCdD6S6zQQAzAwa2P8SC+EoJdSL1+Q?=
 =?us-ascii?Q?oVFrHjlZ8rAyQ+HNlQNWXsjZL2nBCII1Ur5Ri9jTp+6LrdGzhZ9RSZjBUqoG?=
 =?us-ascii?Q?q35P5iH9j0LHXnhAqa3/fEGzDhabbiC0SFy9SpHs6j2bFvEaNq25LyjEAbA9?=
 =?us-ascii?Q?w8GKklV6FATEcefbw2D3J2k5FqXgmwa32+zbermi1De5U2u1vXngM4IIo5xX?=
 =?us-ascii?Q?JSCiuRTZav0XkMM9vmTHF/b+4RmvEV/WCCeO/SlX2wYQQE+0dUq0n3p0AM65?=
 =?us-ascii?Q?UYnjt344pv0zcE7aTyUFe2+1G54WHEthGnDRv0TK50TdUos5HHeUYGXny7J6?=
 =?us-ascii?Q?9wDIry1QERo6ogILu4kbEOP8lOnmt0V70BLAFm0eqCvyPdNc85UfmD9A6/P1?=
 =?us-ascii?Q?+QYPtpVNl6VIgqFh8uuBHM/V0pMktii6VrkursUzgSURVHqB7gce+6vLu6dt?=
 =?us-ascii?Q?WfhLQCKgB6rJbvPRc1Wkxoq0nQ7C8J9n1nq2NXDgsiV2eGBloFwGfd6vxmGK?=
 =?us-ascii?Q?ooD4no5mEBRRPfppRFm0jgIMiuHyhqji7Ui4bMAtwTQMqlH7YJSkkZtQSZwW?=
 =?us-ascii?Q?cnlhHJ3rmEiS8YBeXS/yOU3xfo5V3+qlEIlage1GJk21gat9R1wJb/lf92bs?=
 =?us-ascii?Q?UdRj1J+6bxOpgJ14yYMZDuiWz4l9qfNAGYADCdAL7CyXllbDG1eGApVQMOC0?=
 =?us-ascii?Q?Zk2qJyZ8nB9l0khAxZUDD0ibdbVKk8dBKTJ6/q9sPvYP9+FrSM2mz/+/wfsZ?=
 =?us-ascii?Q?LteBoCgrJT/mwGInPJVsVaW9Z2gErNZp2UrrH8CVb4wFcxx6mlMR5L5/loQ3?=
 =?us-ascii?Q?IMVOjbB/AQ6cnXDqW6BmSPTqdcV4LWWeF3i50sfdVjqdsnObWZgGWz72ccH3?=
 =?us-ascii?Q?7RtU6nvLO0qLJ0groD52RhGYjwj1ot62CCI+0BTlwJXBeKtZHOi7LiicM6RX?=
 =?us-ascii?Q?YEqY92G5uzi9VjcBoeCV+DBjkMWaoxIB4i31dNqcBjxfUlUqBKeUAL6ds2CK?=
 =?us-ascii?Q?0DbdcTmFhv48hY1mONc9RARGYEDvoni5xK7MpRlcKuAn5Q7yxgpGEsTURjnL?=
 =?us-ascii?Q?Oi8Zni+SwzknDOmnYCcEr1/b7kvefeXWH1ZlC0AwSxAz5iImPnLxSf+EyOp7?=
 =?us-ascii?Q?tbBNSnD4/GyclUHiDNtm0ze/Gxoaw47WJ4iio6AslkItg8l4277euBOGqHNO?=
 =?us-ascii?Q?4HcSYkItUQ35+mTungoO3YLf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45242f77-30f9-4aa8-a633-08d8d9124570
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:37.2376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GJKxey9OEv6pvpj1QomZ0olpuVgsK1KE9czVcE4h4UfmlLxQA/nO6Iz25jJlYAWVPL1QKVulcx6dkMnWqFh1w==
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

Add callback function to support sys_drv firmware
loading for psp v13

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 276dc2fdcbfd..a76fa572258a 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -116,9 +116,46 @@ static int psp_v13_0_bootloader_load_kdb(struct psp_context *psp)
 	return ret;
 }
 
+static int psp_v13_0_bootloader_load_sysdrv(struct psp_context *psp)
+{
+	int ret;
+	uint32_t psp_gfxdrv_command_reg = 0;
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
+	/* Copy PSP System Driver binary to memory */
+	memcpy(psp->fw_pri_buf, psp->sys_start_addr, psp->sys_bin_size);
+
+	/* Provide the sys driver to bootloader */
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36,
+	       (uint32_t)(psp->fw_pri_mc_addr >> 20));
+	psp_gfxdrv_command_reg = PSP_BL__LOAD_SYSDRV;
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_35,
+	       psp_gfxdrv_command_reg);
+
+	/* there might be handshake issue with hardware which needs delay */
+	mdelay(20);
+
+	ret = psp_v13_0_wait_for_bootloader(psp);
+
+	return ret;
+}
+
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
 	.bootloader_load_kdb = psp_v13_0_bootloader_load_kdb,
+	.bootloader_load_sysdrv = psp_v13_0_bootloader_load_sysdrv,
 };
 
 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
