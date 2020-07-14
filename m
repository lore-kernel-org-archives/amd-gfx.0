Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371C2C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F144321582
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CVBQUH9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F144321582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B342D892E6;
	Tue, 14 Jul 2020 08:07:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4324D892E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:07:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpCsKGfrw9YxCTK3wGRdZ731168irfnbBnxL2j8B27xWCVWxslU+FM2bpKQ6T6ck01iQsAOdl0lYGqoxcHYrg4//kcaF2RrjZKDlYVq9ogoIstat5eOfJWfRfHgDqhlIAiV4tJzT/spCN0meI3zzCe1dCRzULXGMay1n/p6PMirkpi0NZo8oVCfDcNXMMQ5w+HKxHyZMa27rP4LjWqDJnz5kxjkEdVVZ3VxUH19OlM9Z8UdQicb/BBYr/VJVMedYPu2FkHjUGVDxwrUP4VHr8y9Lly6XMoQtvxjpAA9RXKSwalXZS7Vv9frXwh6ktoOtAwLawpOMZaJy1odl6M/M3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPXcCupNVuwNuBteSxeRZob/A54NFEFiT3fUiA4JJmQ=;
 b=AMAewejR19FPesOYQTTr/inJn3d53E5VcTP8WGNmqIMxjScipssItV2JgI4X8vouN+NV2ndQVoW7DYWpvtxnIXGIerZ0eTbIWrb9iAeGSm+o+0fm8tQidgOhl9ktOd0stFN5lab1q6h2t9R4F9drc3B3VWxZj1b53dycg942WnnYP18BZVs849l+dk/+BmVGXN4toUZD+XA58Zp3ZDWTtXmmRphRsvRhqYhTANtjvqi+hxlZRUEtI5ygi2oYSL1/SCLo2vSx9gHOhbElg5JD9u6snuFZ7fr43HCXoSUiKsx4anTcJ/gDsCq4pdxXdkw/O8uv/7Ihp2uz8/QXdyXmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPXcCupNVuwNuBteSxeRZob/A54NFEFiT3fUiA4JJmQ=;
 b=CVBQUH9xmszFHIhoTYzo0/xSsb1VyvShjAdNnUBVtHVzn9WNMwNF3phfdPl/0sYtoB8y0tXvl8nfimxyHfv1gLwZreKnG6nt/Ao3h9Ls6/9WGWWdXkbshw956UYPskpvEKZF0qR5m7xlxyKQA1Eco9u+ft60YUSnUKEr7ON/zbc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 08:07:18 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:07:18 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/17] drm/amd/powerplay: revise the calling flow on OD table
 update
Date: Tue, 14 Jul 2020 16:04:15 +0800
Message-Id: <20200714080416.6506-16-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714080416.6506-1-evan.quan@amd.com>
References: <20200714080416.6506-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0078.apcprd04.prod.outlook.com
 (2603:1096:202:15::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0078.apcprd04.prod.outlook.com (2603:1096:202:15::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 08:07:14 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a315298a-e54e-4f5e-20bb-08d827ccebe5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4355B3F79E86F6E3DA1DD67DE4610@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t0Cv8lVNtIcRiPBChE+8MjwTlab6iXwraCRroyHfnLY6XQ6VkwOhCRr5esVJB5iNMxqIEPrIzaC/blYwIWy6W52R4eUDOOFJSk1PSrosJc9tSSeGLnEs3KT3Bxx2jtmRZk/cdNdyBrckkaQNwpgGUWWc8F0K/NJCjmhGFSwfOL+5ZgDMyebyS5fQh5MAInC6fAcJv7JQkD9T96Y9ogsM0ehigeNySd5p3NYIG3bL4F/VvwugxGHHvKsk42BzDleDC+wpHxM+AihGm//uUqWNWwz+cJvFTQM9pqbI+KsSK/rkwwfzjh+Ei9i2TfBBSIKIJEArO6qC8djsfgEmNskYZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(83380400001)(316002)(4326008)(2616005)(8936002)(8676002)(36756003)(66946007)(66556008)(1076003)(44832011)(2906002)(956004)(66476007)(6486002)(5660300002)(52116002)(186003)(86362001)(7696005)(16526019)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: C4uz0qqJEUZcjUtYh0FK5hQIVjZ9rKHufbNhrEwG9da4OMjdDKVyGiCm2Bf8YdC1zp8ndlt4wdvtf87j6Sn+fPyeso6ILLR7bTsyBqHB5sDXE/YIRR7iyVtS8I1jzu56/BdPdhKiyUJVIpsoH592Ul4RDw/7Ug4ah8ldypyyayhZ0uljm3mOtNWAsaaR4j2o2O+5pHBYrTZj7fCBjbGCD0+LLQlzHPR4eyOa0mZwtxsZGGCF2N1434hqULk7CpHCFN7CintW84zc+HmzuIlIRvYfiRVag6WMGf+FCUyhaiAwlivME7plzvkMf6TVfhobIKKes+bJ66St/rjMOiiKPPGmUGUWlbcA6AWgE9aA2uDWtsgYXSq7Pb6TbgMPp1wPtra2g0/xSPbM6WW64MFq0o+pMmRSDUJmDZvs3nUhu7+qJlr54tcGz7J9t1bo0VHdUm2vgAVZznrRR0LTHAzy1UopUzKIhrJ7uVllxvTrK+0eL8Cbcg+n3FE7ao350+Kh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a315298a-e54e-4f5e-20bb-08d827ccebe5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:07:18.3343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkCpyqE90Mkd810LjsgWaY8Umyk+pN9JN4FtpBJbkWTkfQJ/UFpS60US9VWQ0vHw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This can eliminate the cross callings and maintain clear
code layer.

Change-Id: Ie1e12a365f9d337d9efca48cdb9a2e8d341b8364
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 8 +++++++-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 7 -------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index f32a64c91dd3..ebf8928660b8 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1900,8 +1900,14 @@ int smu_od_edit_dpm_table(struct smu_context *smu,
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->od_edit_dpm_table)
+	if (smu->ppt_funcs->od_edit_dpm_table) {
 		ret = smu->ppt_funcs->od_edit_dpm_table(smu, type, input, size);
+		if (!ret && (type == PP_OD_COMMIT_DPM_TABLE))
+			ret = smu_handle_task(smu,
+					      smu->smu_dpm.dpm_level,
+					      AMD_PP_TASK_READJUST_POWER_STATE,
+					      false);
+	}
 
 	mutex_unlock(&smu->mutex);
 
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 32719ca93b46..9ed2377ababa 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2108,13 +2108,6 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
 			dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
 			return ret;
 		}
-		// no lock needed because smu_od_edit_dpm_table has it
-		ret = smu_handle_task(smu, smu->smu_dpm.dpm_level,
-			AMD_PP_TASK_READJUST_POWER_STATE,
-			false);
-		if (ret) {
-			return ret;
-		}
 		break;
 	case PP_OD_EDIT_VDDC_CURVE:
 		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE)) {
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
