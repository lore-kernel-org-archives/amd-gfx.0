Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9FDC4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 04:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166D82389E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 04:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166D82389E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E476E0EB;
	Wed,  9 Dec 2020 04:19:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64EBD6E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 04:19:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih4esCyqeJUUvlJvD6Q65PvkEaJmI+qq1RKPxLXFltwVWvMqbm2ogVxu7t5luUQU+4q3nz/bwiDRdDBBS/5S/NyBYvft965OuTBDUbm1aaQltsqNArPDPPlYXz8zxih/gO6uSGjapEApbZekTFkvXA3uDt/M7DIH6W8B7fMck4iYqB9WaNC0xAGbt0E2vXhf40ThJo4DeayUA+busz5lahRDxGIzUBI8gkXqw4KcLmux6QCPfgkGgjlX3cqxJyhi8cYNeYNcGkcFTf7HY5T6l3YXt8vXjMfXqtKZm51909uEwWy9PBnN4xDAeK3HRud7bCn+vUc5GCyCfvVS6dk6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDgJHLcTgSIjKR7NSQb91HQ3MiFKXlYT3qYZJhiXUgk=;
 b=OCEkvAnyGRLJc5SHf7r9UaLGrT+HRq3i3dMH4WvmeCz3aFPE6rMa+FGkHjwy2wahVks5ow8an2vnD4aisZ+3aNLW4zI8uh6l29l0GkYWh1KKMT3Nng/CxB0j5cEkHSn9uNIZNwjs3nSt2N5OFD3AMDKkaiZPkpldmatdj2xsifmSRio5uibbEuUzs85Tx4DQOpFjJ793L0eroPNMkxRb+bpUrgGrWNrUw7avO5Q+18ByQEW+aMcSZnQrNz+7+YK4eeecMwPj3gsfSkxEensgCeZVmhWMsfnlycQBTRT2lw4Y4+KBKKAJ4yQ6C6IiUImrCgh6FcZ8KP1fM+BhgI8Opg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDgJHLcTgSIjKR7NSQb91HQ3MiFKXlYT3qYZJhiXUgk=;
 b=mPT2Dsoi/QtNn1hehQYoUOrqPDc1JfsftirLt7VQ5xNyICSNhRbLD7Lj0CeKEWkQvkyGYaa0V78GGIGglCIEcgtrw7VPAB9R48oGFY5YkNUYcd095cDh8atRH4hiDoZnmbObiOTa+QxtEWlUubk1dK9XERQhi7nuWTR7QFHvqhw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2505.namprd12.prod.outlook.com (2603:10b6:3:ea::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Wed, 9 Dec 2020 04:19:12 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Wed, 9 Dec 2020
 04:19:12 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amd/pm: fulfill sienna cichlid 2nd usb2.0 port
 workaround
Date: Wed,  9 Dec 2020 12:18:36 +0800
Message-Id: <20201209041836.143264-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201209041836.143264-1-evan.quan@amd.com>
References: <20201209041836.143264-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:203:c9::11) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HKAPR03CA0024.apcprd03.prod.outlook.com (2603:1096:203:c9::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.5 via Frontend Transport; Wed, 9 Dec 2020 04:19:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b03e528-f7fa-4347-aacd-08d89bf9956e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2505:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2505220251ADFA60A51037CEE4CC0@DM5PR1201MB2505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWvAHn3lKFCuX71bmjYhnjV8Ftb42jOw1DnVzRntoyUgCVMs/7VPkn0K8+PL4rSvzhdH2rh8xvxZRKa2Xab3dnso48rW2DfC3voLFhbCI2Tp+TDkvePBUzOSNOIcrmX2ot7PXYpd/9pE05qjf8ZbnLWsSxHslK8zeI54ffR5qrsX/3bSZN5S8ntAxfVGwQWPHU6lvqwPYlKzgXavXSIVI/8a5zysZ4bkaL4pedX08ZOBJAlCc1vw/XXvAR2nRMQWdKZEWB4gv4Nc8eui0rbW5Kh1JDzhCVT1/VJK/H4ZJ6/S1nuhZkKQHhiZ+PVMhaxoBEzL+jXyKAueqt+aEBPwqkHPuY2UypFtuHoLeX9flmcoeVisVhAC/uwc7vCeQGbn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(8936002)(7696005)(66556008)(66946007)(66476007)(52116002)(508600001)(186003)(16526019)(44832011)(6916009)(8676002)(6666004)(1076003)(36756003)(83380400001)(26005)(86362001)(2906002)(34490700003)(4326008)(6486002)(5660300002)(956004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KA0YqZ95vxzLV0Z6rHpWw1STdXqp4VUNzBiPbQdF5C+fDnA7OKYKMeqfDKF2?=
 =?us-ascii?Q?XgqX48GpPUOMcuXoqTJ5oRE/J1w9kprF5fIcYFncWx05qERZg5ZZJ535p++d?=
 =?us-ascii?Q?vnxtAxv9iFqFTpFVoLW3ihFC9G1jZd74+uRBUW1GXatUR5pgIxjWRKWqA/A3?=
 =?us-ascii?Q?khUvRzse5/r/xmRR6iBXZrbYQZB42WrfDEN5dEDnMWGhBXflqVIPo1qkcVi7?=
 =?us-ascii?Q?BToV1Ah7ARHfkS4jNSKXEC1MfiEM4butiasuo8NtfO/WhFFsx1m6uZQame3M?=
 =?us-ascii?Q?SWeS+3I4N5ACQx6J8jlJho8nCDmmYe9N+LAnE7xWh6QzAecatrZJ8pFtvjqz?=
 =?us-ascii?Q?hyNrgQKzD//+/GxIeJK6VNZsavw+jOu4JYpabPGDDuDAEcIKihSV8hPWRRFf?=
 =?us-ascii?Q?PhP848NG3yZoN9WLgFz7rLPVs4QF7L43i7uThBPZ4bndbHg8prIn0ndZ1+cj?=
 =?us-ascii?Q?ugcC98k4EUPSzKxCpPfwldLAFuD+A1dhraOuQ6c6WWaouRMDC2jz4W19diok?=
 =?us-ascii?Q?uC3PKkxJFmzaLmRsJIyFhMkGeysyfksH8ccKIgnfLtkBYI6htNlGUOt8V7E7?=
 =?us-ascii?Q?UsrChjYCK8jTDi2DXNS2plRu9Z6z0srGOj2J4uTfDLo3Bn+VeL2T6j2rQnzm?=
 =?us-ascii?Q?NQViitviv0dLkWBILfSV5P5fNaqIiaU7M9JN/1UyOkehzY/KHMJ9gXZ5qu19?=
 =?us-ascii?Q?HF+W4IBE51CkUSEn6x517jQ5WSc3oNmgzwXm90gNUCpyFf6YE22InCu3HgLY?=
 =?us-ascii?Q?12wh15nMr+IvOTBh6Mxg2+eGxg4tTrCTJzX/xyQBJNBpvActTKrFgj9V9bkE?=
 =?us-ascii?Q?+b5hIW2iZjaazY+sR43KtzbGDdwPddMlMEur4v2PDNF0Wa9U0lFK4TntTlPQ?=
 =?us-ascii?Q?TE+v0M2iDT/omd6Si4I/p8PhWUvOP1K8Gw7gZjpvT1MhDzJJakrGhC2AnXsv?=
 =?us-ascii?Q?+aWETKGE5P1xXEh8UoH3rRVSj2rhEsnemgT08asnXj4akDgPDw1V2NjAQXBn?=
 =?us-ascii?Q?LYda?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 04:19:12.8565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b03e528-f7fa-4347-aacd-08d89bf9956e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjZ2O2acSHxcyEqFFVrhiRazAtBLvRXCVri0398/RqtCCIBiz/0pdQuCrmPFFd1P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2505
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fulfill the 2nd usb2.0 port workaround for sienna cichlid.

Change-Id: Id5a89a468787846ed0050b56cd318a9574185567
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 38 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 47d4f92d5ead..74cf027e4a41 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3247,6 +3247,42 @@ static int sienna_cichlid_gpo_control(struct smu_context *smu,
 
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
+static int sienna_cichlid_system_features_control(struct smu_context *smu,
+						  bool en)
+{
+	int ret = 0;
+
+	ret = sienna_cichlid_notify_2nd_usb20_port(smu);
+	if (ret)
+		return ret;
+
+	return smu_v11_0_system_features_control(smu, en);
+}
+
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
@@ -3287,7 +3323,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
-	.system_features_control = smu_v11_0_system_features_control,
+	.system_features_control = sienna_cichlid_system_features_control,
 	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
 	.send_smc_msg = smu_cmn_send_smc_msg,
 	.init_display_count = NULL,
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
