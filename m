Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171A1C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 08:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C607323A5B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 08:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C607323A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7973A6E0AD;
	Tue,  8 Dec 2020 08:28:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E836E953
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 08:28:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLD7I/OmnkCM2uRvwNz7P5LjCWPZdmiUOQdTEOD+L/p6GG/nvuDMOQULUgVv3PoWtSmyJhnA4wqyNCPD11GqGee7hPOY/eLA1ZfcXIk9aRPoEJ38j2xUvoigdgpCO6xqkQf2Vr3/N3vq0S7AS9GGYqC93rKjtCsjyJJHDqc58+bsUyvkkaVJfD7iqRo2CpmhwNYKKIyADIovXExmFzzCK0gKcgph6FT7fRsYRR43246mCOL9y8SAZey17xjpBy72lns5pn3hzft2uUZvLZw76vLWxCyltCcHCFj/I/a0lIjdvvlLQEfsxS3orlW42IwonDsaKh+DJ/rJR+teGh3FeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKof5yKhWcmB4cB5B3NfmeeXUP6C6hzLfTTQTKVdpPE=;
 b=Ve8UOhYtA88aYU3/KvR1jV5Losyha8TOrzAmA1iiGKNWJIRqEkocORwR1mG3qKuqoLn01vbGUBdXv35rxdGAmchKqxJkEYmdrvdLW9gKxSJZDhVV5aQc8k4yhozIHu4GWb6rEatCrw9z9b/sDDPljfDYxaiVAoeHltqAqmS0aXR7N1ZQqeP/vsjm8UBDBDqjhBrrY72vm2x0IVJt55MRyqyXnvN5a4bFcuPUBVT/pp3Y4RmAxh8u3pXYaOvVstgiQNrxizQZdvXxsiftIi3/9swsViy0j99fbAzgG13j1T80PyIt4C8XtRyol1dM2VZRuhe2vEpLqDxf2/1DHZBlwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKof5yKhWcmB4cB5B3NfmeeXUP6C6hzLfTTQTKVdpPE=;
 b=I+DZoBh+vfC7WZQWyazkmH78XvUCva5lLpb3GpQjWnaA+/cMthRDDZRUvHzBgIAYTRfYOEH9IJNojLuypxUJl81TtwKhLe56+h1m6C45vfPTWP6ITbP9Udgxc+0zfGbvDP7ZxnXB0VfpWolujI+0r02f+UB2P2FIQTlUxPGp/iE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2507.namprd12.prod.outlook.com (2603:10b6:3:e9::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.18; Tue, 8 Dec 2020 08:28:14 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 08:28:14 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/6] drm/amd/pm: fulfill sienna cichlid 2nd usb2.0 port
 workaround
Date: Tue,  8 Dec 2020 16:27:33 +0800
Message-Id: <20201208082733.126647-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201208082733.126647-1-evan.quan@amd.com>
References: <20201208082733.126647-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0061.apcprd03.prod.outlook.com
 (2603:1096:202:17::31) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR03CA0061.apcprd03.prod.outlook.com (2603:1096:202:17::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.7 via Frontend Transport; Tue, 8 Dec 2020 08:28:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 99c241a3-679d-42c9-7d87-08d89b53349d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2507:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB25078F655CB6D000E5F7F321E4CD0@DM5PR1201MB2507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FR4maHoIKU68KrE2JnyABaMfLtMNeodYFDDFRpzruogR5uvJFN2fn+rnVigcEcPTp8f1fZmdbSTaHPwzOaPvzRR/4arfebGopIShggzIFPyj2sJHjOnBNLp58fn1AhhwpOWTcwDwg14UEbeB/e65Bc6/7b8CwrhC3iYdLcmvuGqf2zCIivEkINQ/ieCdBhWtNS+RW6MF8FFWOleXAnezHLbM5MiW4XV/gW3qAmgNBbKNOOY1W/rtMf1VuHizizmytlg48URet8pvWunZ+B+RLhdGyEE+liKCaBaBRITsOhCccTxgOCFaeFXZbRkV1FA1PeLFpFi71TNjYU0x8U8pWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(2906002)(4326008)(8676002)(52116002)(66476007)(66556008)(7696005)(66946007)(2616005)(83380400001)(478600001)(316002)(8936002)(26005)(44832011)(956004)(186003)(36756003)(6666004)(16526019)(5660300002)(6916009)(6486002)(1076003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Do9nbrJ0IKmEadwJI+9i+MfQhOD+1dqODsD5JcUfsyGB9UnuPiZ1stUf5L2O?=
 =?us-ascii?Q?YCJy8OsLeDm/19qdAhVEc8+HOwT8BXMkkpoDiA5T3zKANIRqap6LFplhgwkY?=
 =?us-ascii?Q?wvUTStZTNWDc4OkkrS9QLV0gIGBNmFVoE+s8hgUZvNTJ7Ro+wA8vRpK8tp+y?=
 =?us-ascii?Q?7eOXTHgH5v5RW1fUUtImcFiLXfYsCWZeeXJFjZNU2l/1M1pvGdyBZtAk5U4E?=
 =?us-ascii?Q?rpYThTIlWrZVr6PvY+/d5HwKKPBknFHFlkFrx+8wOOfCGrQdYUlm3eXAhkyB?=
 =?us-ascii?Q?tHNRj7o/vcsXlb1oZltjz71ryPue0BlDoYpdPnpk11faagf+iy19sJ0abBFz?=
 =?us-ascii?Q?dxzU1Ai6NvHn9/ind7IY1+ZsX1TwaJONI0Flz2p24QzmaFnncv1lwsBYOBQ2?=
 =?us-ascii?Q?BBaB6xRaYlmbkHSxOsK3cLQKpluKNxnA8u/zyPJcHV3SrSAJ3kMYbyErrBHF?=
 =?us-ascii?Q?VsejJy6mohbXIiKjlIPYCK6IpT9ue+SHVYwoXJcaGQ36orAkB8gBi5URr5kQ?=
 =?us-ascii?Q?7Fjiiq0IVqqRQTulQcVpdVvrHc4FhYi7LBDKHsxuj6OXFVUJP7OgnwNTbmmq?=
 =?us-ascii?Q?7ww0BH+A+55QhP+/ZtPcBgBuwHKe3nl42C2icd2Q1bwN4GgYfOP8HebBjUII?=
 =?us-ascii?Q?QVCeqys5HKg7MWMmXRSaYX4paBGm4KwR57+G6MMs6wOHtmrX39VMR8dtx5BE?=
 =?us-ascii?Q?eIYS62SLddp8QWiO2qH/QKQgfrJsDqEBN9RidvmUCoeubu/Stlzjwgssxszg?=
 =?us-ascii?Q?n0Pm9qaFy/Jv/jMmI+oaI/6giyu93eVpIl5joszIJfcZyTy3FEySJea8FbrV?=
 =?us-ascii?Q?C+sQ8jOkI/BskUlh1nG1kt92vorwD6vgD4oLTlbAsezPVC9xxtjbHYMt4wuf?=
 =?us-ascii?Q?IfEbLUn35ldpOLdVPUrxzvd33VGui9W1XHMhPuZwezBjeF5HLGUmt4bo1qce?=
 =?us-ascii?Q?PNJoOTURkP21Hfu1sLkmPcwhxEdkc9AtMb4RlHlAffa8j7S5k0CB18QCDb+2?=
 =?us-ascii?Q?jW3W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 08:28:13.9902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c241a3-679d-42c9-7d87-08d89b53349d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbqW0pRI+LUSz4K4s8QEIQGRzkPX9unHMvax3D2vBdAEJoE87mLf6ACnLw/xILih
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2507
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fulfill the 2nd usb2.0 port workaround for sienna cichlid.

Change-Id: I912660ee590e9ce352a20bbdf8903a61f88cd59e
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 47d4f92d5ead..48b9787cfb78 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3247,6 +3247,30 @@ static int sienna_cichlid_gpo_control(struct smu_context *smu,
 
 	return ret;
 }
+
+static int sienna_cichlid_notify_2nd_usb20_port(struct smu_context *smu)
+{
+	uint32_t smu_version;
+	int ret = 0;
+
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (ret)
+		return ret;
+
+	/*
+	 * Message SMU_MSG_Enable2ndUSB20Port is supported by 58.45
+	 * onwards PMFWs.
+	 */
+	if (smu_version < 0x003A2D00)
+		return 0;
+
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_Enable2ndUSB20Port,
+					       smu->smu_table.boot_values.firmware_caps & ATOM_FIRMWARE_CAP_ENABLE_2ND_USB20PORT ?
+					       1 : 0,
+					       NULL);
+}
+
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
@@ -3332,6 +3356,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_fan_parameters = sienna_cichlid_get_fan_parameters,
 	.interrupt_work = smu_v11_0_interrupt_work,
 	.gpo_control = sienna_cichlid_gpo_control,
+	.notify_2nd_usb20_port = sienna_cichlid_notify_2nd_usb20_port,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
