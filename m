Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099C9C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC3F22248
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC3F22248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EDF36E7EF;
	Fri,  8 Jan 2021 08:55:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0208F6E7F1
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 08:55:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQt+7BLR8HlJNqxr8+iF8YIuJ46diz5TKUF0P6ESsJsTilgqAvw7qH1fsAYKLCm/GiiMigxWFAR2omMKYtQWmMeIOuYPrLu67l1w7QI/YMNB4MoOe6vrPCWus/Br1SXQrSXt0BIpMnWDOJSetu5MBnhlU6pHg8zevue/prBT/FMwGBSOZoryzyM4PzXduGmocwtBjwsuHDpqYAccbKmZ7/tPsR+m7WBsa01yw0rphk01W0bFGHbz3X3osbhu0vviwjHT4VqWEZLpA9PM213hbhsSoSlbCKCRC+/37+sx1YTRbJkzlnaOKjAyf+5nUpAXKzDcyTkzvCzz40wKw5ZKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQpFaUzmZLFclJJ/agPHFR5FXk7JCxSWqzUHFQHRh/g=;
 b=QEkm6SpjgndX/RhVA5kVzMhroOKEvBdAFN4bwFpNcmUf1pO84u3vp2jn7kEjycsBzDGubaoBkb0BnA/fMfznvNzQooTjt2/WgdqoWfTutc89SSUnGi+iZSIggoKlO6r5Qjbp++8O0c3xksjKxDaWPXUtg7JjsR7XAaJXv9jsuAuo3FHKedaqjxQw5KVrhuV9fa9GkJlg64zhf1CcAtFgllCkEAZn2HFgUsZaKNez+hbV0W59RXdW4601jbxV2VFge/WFjj6dHIjuUc/p40sFklmadmo6toF4G75FUb5Ynam1vzvKlLwV6l7n+eFfi+sNLrH5hBMKuEZ1qL8PBjOdmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQpFaUzmZLFclJJ/agPHFR5FXk7JCxSWqzUHFQHRh/g=;
 b=iF5aG3Zt+PMWswWUszzjhSFbLR6UhgRbFCBpNdueUXlqSPsTNXE/Ux6DRtDwN2qswCXOTBqR2Izyp6dZvzjeWR1RL5g30x1uMttuo9XsE7FRADuIMfoWLBfhL+1fUcw75SD4J6GGmNLmjvELN9aR47IiFUU5y9kt6EYYPT4wDIA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2458.namprd12.prod.outlook.com (2603:10b6:907:8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 8 Jan
 2021 08:55:36 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 08:55:36 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/7] drm/amd/pm: clean up get_allowed_feature_mask function
Date: Fri,  8 Jan 2021 16:55:03 +0800
Message-Id: <20210108085507.1164588-4-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108085507.1164588-1-ray.huang@amd.com>
References: <20210108085507.1164588-1-ray.huang@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HK2PR02CA0162.apcprd02.prod.outlook.com (2603:1096:201:1f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 08:55:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 476c502d-3259-43ff-a849-08d8b3b32a50
X-MS-TrafficTypeDiagnostic: MW2PR12MB2458:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2458B2001B3DC712960B0BC2ECAE0@MW2PR12MB2458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yR9o/YfybWcQuNElhj/LCbuQadR3CGmpoTbT0a5ue03alXeTYeswW9SsTBkfxGuh4VsqjlJTkPCm7EG0P/dAix1wDq4GpJceEC8it0e3oAavJkzmRrgv8GfvMts19PEglio6C8lRHrtMnVI16Z4vzEQhPQIDWKgpY+eaqq150SWm6c5VsyWvqeH61DjCK/A6rrBRgPnueTg4A02K8qoeKo84n8mN610ovR5J0MW0HHep5f8hdJisjrx8WzlrIQdBgvzBPHWd5v6ZApWPjI5AYaxbtLOEEnXpxJ9v+XBrOYTyQ5Y6K6BX80wfspFi7DpFYPlzkST+FtJcUZZmzt3bPus4VuZhqZN5TtebnBnMifcPqdG4EltZQnIBO9PDS2UGNTmWANxpsY19HMiRE6RrXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(2616005)(956004)(83380400001)(36756003)(26005)(1076003)(7696005)(86362001)(4326008)(66946007)(6916009)(186003)(2906002)(8676002)(8936002)(52116002)(6666004)(6486002)(478600001)(316002)(66476007)(54906003)(66556008)(5660300002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7Jxem6Lo+wpBl3M3m3m/ZSu5FJF+fWLdMlh/dGzd6Xt2HikiajUVfRQr0ayp?=
 =?us-ascii?Q?gRqCA110RZ75t41PcmtaTyulS6g+gkq+JoOEZ7rQVBC5v4EHWNOxI/vuV6XZ?=
 =?us-ascii?Q?Ejd1v0OSCEwyxQnSA9eLaDaCDM8HrYhbZLmFzytVm1jlPK6X+4quBMh0a5ud?=
 =?us-ascii?Q?iiWpIOytI82O0oYSeMMuzoLS18QlDscOEmt/CRhT9OkBGWarNDAHEOEQt3Y+?=
 =?us-ascii?Q?CQxqThsyEh7eDMA4X9yc2G1NaX+Zyw8PXspPl4VGkgD7J9NkireB227yYe/S?=
 =?us-ascii?Q?he0AT86QU9bwUV1Ohd7GHsIciMNVW/U1XT5aRUJvdYPZ1qsHCL/Mvzcq7VmI?=
 =?us-ascii?Q?uslylN7TfymiMRK9aXjuTda2mgruTWyAP7WFfvHI3G/Dn1jaw4mqWXTUSkTF?=
 =?us-ascii?Q?RED0mlxB1hIKdqB1gCqAPX+hME+iR36JRTfhygK0LbXN230au5b02qwwSUNR?=
 =?us-ascii?Q?0vcqChpjx5cLo+NgPZXdVJMvn3A2843oSGWIrtc4Jcgu1Dte3h2tDG8+NOBd?=
 =?us-ascii?Q?QrBwIvT+t2a/yo7tCj9tVQvSfq/LWSQPGV9jXSUYyC2vDk1XgRqK71U409us?=
 =?us-ascii?Q?Ep7IBgYh2y/kgMFSSmh9YnuS0rK0QeoVKREdR0t8rZhvk8k+kNhXa1fKWEkI?=
 =?us-ascii?Q?IKD0g7Kn/KZMOJczqN6eTnen4VsjqDChS9CfnBPcJ/X+0OQ7StD15r96gC5H?=
 =?us-ascii?Q?99DsxfOTb0Rn28gEvHneXMK0Biz7xT1kQw8mfRObQWgeQLi6hjWE43Gt8Ubj?=
 =?us-ascii?Q?5bXZfP9vRuZWM+eVkow6j2BswHwZJdQR1jUz4Rf0XTIadbAO2jzeWmx8n2VJ?=
 =?us-ascii?Q?yfQu5YauMPa0UTvCaBGHYdPNfMWIAPU0LDab05SAeHWqHJWpAVgXRTBX5UJv?=
 =?us-ascii?Q?0rBfecX1qFdx45R5K1P4OkVBfcaozM5QSGDcR0zaarkvUIGiijCwysp+d5JW?=
 =?us-ascii?Q?xhoTDFpmWQ40fbkCte/UwwNLDQQ5DE41oHq2jIBzTDCje2mXWp1aVxGi6Zk8?=
 =?us-ascii?Q?61UG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 08:55:36.1173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 476c502d-3259-43ff-a849-08d8b3b32a50
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oR5gdYmIlHvEQ+CopT7DquB/KrA3ooEWD9ulcNQdHXfanzWDHDK5dB2SS8ZmGvWrFsmAe+zOZKXaZVdCRp4zGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2458
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Xiaojian Du <xiaojian.du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The get_allowed_feature_mask is superfluous on vangogh.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 43 -------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index fc091091eaed..3687cd1dc24f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -359,48 +359,6 @@ static int vangogh_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 	return ret;
 }
 
-static int vangogh_get_allowed_feature_mask(struct smu_context *smu,
-					    uint32_t *feature_mask,
-					    uint32_t num)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	if (num > 2)
-		return -EINVAL;
-
-	memset(feature_mask, 0, sizeof(uint32_t) * num);
-
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_DPM_BIT)
-				| FEATURE_MASK(FEATURE_MP0CLK_DPM_BIT)
-				| FEATURE_MASK(FEATURE_SOCCLK_DPM_BIT)
-				| FEATURE_MASK(FEATURE_VCN_DPM_BIT)
-				| FEATURE_MASK(FEATURE_FCLK_DPM_BIT)
-				| FEATURE_MASK(FEATURE_DCFCLK_DPM_BIT)
-				| FEATURE_MASK(FEATURE_DS_SOCCLK_BIT)
-				| FEATURE_MASK(FEATURE_PPT_BIT)
-				| FEATURE_MASK(FEATURE_TDC_BIT)
-				| FEATURE_MASK(FEATURE_FAN_CONTROLLER_BIT)
-				| FEATURE_MASK(FEATURE_DS_LCLK_BIT)
-				| FEATURE_MASK(FEATURE_DS_DCFCLK_BIT);
-
-	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_SOCCLK_DPM_BIT);
-
-	if (adev->pm.pp_feature & PP_DCEFCLK_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DCFCLK_DPM_BIT);
-
-	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FCLK_DPM_BIT);
-
-	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_DPM_BIT);
-
-	if (smu->adev->pg_flags & AMD_PG_SUPPORT_ATHUB)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ATHUB_PG_BIT);
-
-	return 0;
-}
-
 static bool vangogh_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
@@ -1464,7 +1422,6 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.init_power = smu_v11_0_init_power,
 	.fini_power = smu_v11_0_fini_power,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
-	.get_allowed_feature_mask = vangogh_get_allowed_feature_mask,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
 	.send_smc_msg = smu_cmn_send_smc_msg,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
