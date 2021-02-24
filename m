Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B29FC43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E900660233
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E900660233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13DCC6EB2E;
	Wed, 24 Feb 2021 22:19:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C856E054
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWurfrtXfy935lIpH3kHmTOZxCIqKxMsyP9JcRnJ4NRQtYpkuvrEWz0mIiwXyuo06K2VK4axFlX627o9xkYDoZYhY7MHwYA1FZdE+a38aMwIYe2gnLY3yaDZ0/v9lRIwLGnpuwSQloEYDi6tO5ey7AS7SVHyx0cVJh4UrALITNdj2Bq395bbqLmFHQ3j4OzzUfXP75Sb60u7iIVTttFEZ6ieN/2tTNVZ1ZASnUSAc/+5fQn/3fnJn9zHqEHvuhusrpXeR50bNS5k1qzyYQablACTulUgFTzR1q26i9WV27RAfHPresdYjk0YNlemra/CmeeqFVAeGO7yIfvR2Pacqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1G/Xm3noZMs0r25ql8QoGydPzF68nV2SMb29HqL52M=;
 b=KtlMZJ6ApzSNUj/SwW9jDbLNlafJm2A4x/d44qsIHBY9aC+IzURXxXGcMAoH3Eoh6LVhbtyPu9//NHMoYy5Q3XMynAu8vAlzXfnwI/D6+iT5LzFhs7zIsvbIZlIKvpCFeoQn74A2KUq57wc8+mS1HeFBxZJ4v5U7OeNEUK0hpnIY98f+dICYUBKLL4CV4tfCWLrnRcoaEtI27KVJG79RFus4drmvt7dPk68HNLAoWn913J0BKXHka7gIkiVWf7+/WRLRMBxxLbhYI+JZZWfHGQ4N4u7oOYczMKpDdFEq6lrhjFr5C/zhfL+E+Bx5PiGe/BTxx+01S2j+jyVjVd99Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1G/Xm3noZMs0r25ql8QoGydPzF68nV2SMb29HqL52M=;
 b=ulgifllLlzm9+S0R4bTYWCXMkcWiQA4HqcYngfkPNO4lBvsWjnKg0LbyKax5UXTh7Bc7zh//3VmsGNJJwZ40YJwrYw8fzibPMiQqhYk99jv2odX7xPqn5Tx+iSAbg6IcOKG+Gs6Ca8U7R0jMVRG6O7bJSYlpAGRzKE4aeNPPn1c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 24 Feb
 2021 22:19:36 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:36 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 026/159] drm/amdgpu: add kdb loading support for psp v13
Date: Wed, 24 Feb 2021 17:16:46 -0500
Message-Id: <20210224221859.3068810-19-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6e614b2b-1a53-40f7-4df6-08d8d9124506
X-MS-TrafficTypeDiagnostic: MN2PR12MB4174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB417494E1FE2383FC7E5F63FFF79F9@MN2PR12MB4174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSm7F0BLP3oJNRD/7k3aI3K2iURg4+8Z/U48ODcXEr0tdtQtTySN605WyE4WzYk+Xh3Gb6LW0BMk+XW7gcjX+Baphz7ZIfBly+QhQQz9Ustac/CxCbD5Ivf2M9MohYmogMhyFIGd0IhHtNUiiNA20mVtYirQZBOYGcdD7iT81FPs2idlbcchExvvlrV+OaEqhYwJaQNpAt3+jDV+65SH/Hfhji7tB63r4Dse1rzvyX431sQSk5lxEEQem7+Edwe0EADjXWiQ9LX2CHPiY0OhysPl8JkycfQKS5NYXpcBezdwbbq93WHMduG3HhdxURqD69TkAN1YWBsvsr9QsZh/M/YShCOywA/sCtcKHsdbd3rlgD9OEnCJf55zswyVxWbCtHIULvM12i6a6bfx0daqujtGd/t6QfdBEIPFznRY9XTIIG7LcBVdAIau6Jgx3gLC0SoUmpy2iwTMMi763hNBCCjavlzin6XB1dHCWyoq43B9zm4wnB7p/gVwWVft4H104A4Wrs54CPIH4PRzuABXx96Jd29p5YCiRZsh453bt2bgolcYd+9YBCsUxRAfYT3zzPLIQJ02u784aOcKocX06A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(8936002)(52116002)(4326008)(186003)(2616005)(83380400001)(1076003)(956004)(6506007)(26005)(6486002)(6512007)(54906003)(66556008)(316002)(2906002)(86362001)(66476007)(66946007)(6916009)(16526019)(6666004)(69590400012)(36756003)(5660300002)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UUY1rQZhCHjWVWO36W9ydvGQOGua7XZzGs82XgLu5LL8dhX+U2WvZBloYNcQ?=
 =?us-ascii?Q?yTUxh8Bo2bdBchvXhdOnFI+K6MHQSiS0qu3OkmHpIokG1tQ+uVtWweGncMyv?=
 =?us-ascii?Q?Zdmw9kuXYTNzssJXijzVrUmhke3r37mxL1/Su31TWPKbxXsoogtBNQ9ukfnM?=
 =?us-ascii?Q?YO/Akuzx4ryapP4sgCbQiuRoO+fOkTdYJvhKW/RsQm1VAhj1bRtkcEn3Lq2b?=
 =?us-ascii?Q?wv3T5QavAN/XtugUvrSadCKYSftuJ0oEEVuAbOCBJXhWPVqtKjYFXYpabH13?=
 =?us-ascii?Q?Kam6eaPM6/JqcywtgoDBTD/n3XAWYox8n29jhrWVuDyGw+5FrCm2ITOW4uxL?=
 =?us-ascii?Q?qYzIvBmsLX50gupQ1iYeKlmr94ONW5JbNk/AphnVfioOoiATJH9AhpYSubcf?=
 =?us-ascii?Q?xEI3ZPdkMQjK92GStc6gEXekxNvLa+YgjN0Z+nahBAmjGWdKw2zqLMYWg8lC?=
 =?us-ascii?Q?GFiI3DhGme84BwthNnKx1bfNR9VLYwdz1iE9ABSJ75WNHYXA8KhEw/SNd3xU?=
 =?us-ascii?Q?keCrbXyJOKbJwVsR6V0GUJaVCOciNGNaQ5iqR9b2R6w/FFxX4MghiXP7R+FX?=
 =?us-ascii?Q?ECziS/LAQTs1lmnh/nJq3GRYOm7dB/cXezVYOGZ4HJlqA6o7zHtiys/syOzd?=
 =?us-ascii?Q?ldKSbFNyS90hcObQPzl0Ov3xlVvRAvGj6GwLoacLqzyTj4VTqxeq2hD6wslH?=
 =?us-ascii?Q?JJw/GIaPWwbF1Qg7R+0Uzu06q9GRBO+P7TRRMLh3uof/Q8QhveKSPHIdS1hz?=
 =?us-ascii?Q?9/NhaQaG9mIn3iA/6wuMyJ3n65f8P5B72Cjsak/D5VuxrFqJ9gLe65R19QiT?=
 =?us-ascii?Q?5kGhU44y7U6X0eUFmdrgUrHAQrYZYqKuZMPoLhfvrWDj+RxkbyovwrdUO1Ck?=
 =?us-ascii?Q?t5lY1IVVGTCjUvPgo7E5vMPY+OxqDNQvoOUsonbcjurvFILPzxIrTUSH3Z8z?=
 =?us-ascii?Q?Lt/FedpPL2ulDyy7EvBYkquCPBhcUIjjwv0I00w965ku5NY2WlGcSaDmhr2s?=
 =?us-ascii?Q?QPUF0ddfWzHvZ61n6yo1+Rg0MIEwQG7cgE0d8xJXJuZw/K+Kt/wevXlQnpxY?=
 =?us-ascii?Q?TxhM8nQPaSf9FtipbSgbcFcewZ7IyVZaSye2edZFJ8R49zCp1VkrvqMO70S9?=
 =?us-ascii?Q?IomawaNlAgQ6VVQrhJsciMs4ssSN48Xz3oahpG+on66SyvYnMuwWobVM8yDW?=
 =?us-ascii?Q?SlQgNlh7Ax1fCDZLINeA1fXnG8BHr2W2IhiDo1/B1LYAXZJc28O8YrDOgVf9?=
 =?us-ascii?Q?ORIyyrQgZX1n4GtDByMeFVWNDHNNrwGreyD+ugY9sYQpmUBBsJrYfyGKfUTW?=
 =?us-ascii?Q?S8cZ1xoQ9VAp4NrFVyF2hJ5q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e614b2b-1a53-40f7-4df6-08d8d9124506
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:36.5815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdUS+ptuX7gNowr2UGljTHIauTbIohp0nS2sPSPgRy3350N1HbSMyndwT2HDUlZU8xb8tLTDTMFz+veYlLUcGw==
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

Add callback function to support key database firmware
loading for psp v13

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 70 ++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index ad0328fc640c..276dc2fdcbfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -26,6 +26,9 @@
 #include "soc15_common.h"
 #include "psp_v13_0.h"
 
+#include "mp/mp_13_0_2_offset.h"
+#include "mp/mp_13_0_2_sh_mask.h"
+
 MODULE_FIRMWARE("amdgpu/aldebaran_sos.bin");
 
 static int psp_v13_0_init_microcode(struct psp_context *psp)
@@ -47,8 +50,75 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	return err;
 }
 
+static bool psp_v13_0_is_sos_alive(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t sol_reg;
+
+	sol_reg = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+
+	return sol_reg != 0x0;
+}
+
+static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	int ret;
+	int retry_loop;
+
+	for (retry_loop = 0; retry_loop < 10; retry_loop++) {
+		/* Wait for bootloader to signify that is
+		    ready having bit 31 of C2PMSG_35 set to 1 */
+		ret = psp_wait_for(psp,
+				   SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
+				   0x80000000,
+				   0x80000000,
+				   false);
+
+		if (ret == 0)
+			return 0;
+	}
+
+	return ret;
+}
+
+static int psp_v13_0_bootloader_load_kdb(struct psp_context *psp)
+{
+	int ret;
+	uint32_t psp_gfxdrv_command_reg = 0;
+	struct amdgpu_device *adev = psp->adev;
+
+	/* Check tOS sign of life register to confirm sys driver and sOS
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
+	/* Copy PSP KDB binary to memory */
+	memcpy(psp->fw_pri_buf, psp->kdb_start_addr, psp->kdb_bin_size);
+
+	/* Provide the PSP KDB to bootloader */
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36,
+	       (uint32_t)(psp->fw_pri_mc_addr >> 20));
+	psp_gfxdrv_command_reg = PSP_BL__LOAD_KEY_DATABASE;
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_35,
+	       psp_gfxdrv_command_reg);
+
+	ret = psp_v13_0_wait_for_bootloader(psp);
+
+	return ret;
+}
+
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
+	.bootloader_load_kdb = psp_v13_0_bootloader_load_kdb,
 };
 
 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
