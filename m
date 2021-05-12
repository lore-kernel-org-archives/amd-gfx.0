Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6EBC43460
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BAC361132
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAC361132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F826EC6C;
	Wed, 12 May 2021 17:31:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 380746EC6C
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V59OQXPE/6t6XDHovOD8trtsqoEvHlxtmoP8fCxa3eul2XSg8h0kLbydiXvzMx5lnCfpWRDsloP6caMZbBQeizg07CSSQbhodLluWlDWqs0jXuzw0qPYj6TGTOVtgdzAtqU157uB3R1HzkAZ4ii+rA2DUHcbmxX97AZdQpojjQamIRkzARUFYt7aj45I8AXZ+V3oawMCmOLgK/zoe9qKD6HJSxNagAeOwY8a4r2TqoBIJlFwYY+E/rvirE8rKUxQw/zxiYyppb8v0TqBCJyPxl5pwpr4ho6p8QBaUV7QxcxR3mMwcwUaJvOJ8fIf2rfaTWkEDGIW13DLoV7Mub/Znw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geRvuOQXXtjUy3UQRJ48NORkLBUKjm8iamhCesyYdkM=;
 b=SPVYCoeQIPEVt1VCvWGbOmHmwpo85c2FCWwzH5bDpvsqtI3jB/eyCD3txF/uBsBFIEIFmDBqjnU67iLm59BLv+TxYwpbOOHMbb6Q3fz8AqPrzdYWW26+H0/iaFbHDteftQCk2q3l7+hFiSbjWnCbnV4MxM8/cbyvIoPOE+4utIYRkV4zSHszibHbJp5eicOd0OivfX1zDSC1KpOVQqCOYGchVvjIGxJWD8xa5Y5CCpobiL4gYLWbPtjatrAJj98axP6CVdjAYWNUeJ8xHx3WAJznsNJ9oTwSVwagU4xJLkIpSU3F/DI1uCX/aClyaHiy9lD3+DaiAQi93pruW397nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geRvuOQXXtjUy3UQRJ48NORkLBUKjm8iamhCesyYdkM=;
 b=X0UA8rwEClRgnsjt8SsgRAy/utk6EBoLv41AFIotNY88/VeflgHPClk0xY1djItKT+ihvGU/Grl323aaWyDttmv7o0d1tH3+wXoDqqYnabO7BLvbc5Nl9mxV0oBltfhNo4M8xJktU6A/e0Yw5QUvUsSrovOQ52NRWha8PEZMEAM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:27 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:27 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/49] drm/amd/amdgpu: add psp support for beige_goby
Date: Wed, 12 May 2021 13:30:26 -0400
Message-Id: <20210512173053.2347842-22-alexander.deucher@amd.com>
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
 Transport; Wed, 12 May 2021 17:31:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e74687af-d0fc-43f5-8d92-08d9156bc565
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2340EFEFCBB9DD4ED5FF465EF7529@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fOJJps+ZQ+skAmyXjA589wC5rDL3oU/XMBQdhGWL8wmpUKnp61M5AVSvuiYwELNNbtRGQLgaavRuPXmdRj24/+lk6JnpB1PzBpsX/3HwIGwdltQPgqxqCw9rGsCO0sPq6dT/t8kElYWcW2uhI02pJjY9couNotpegJKUCFkKtAE0wFk5wMaIM20wrDXJpHsCzApyS4JURRVks0eq3bvx6S/+hM/ixzBWnzgs+X5T7tIpZtKqGHv9BqOf4Z83wRLHylS1D6TRe42bmGyPmkU/4pk3ZHsNccsAxacKg4kwM1DOyL8KshYgEIAIfIgjgWpnuGQaIVbrX3oPzQELqPrpB99qtGH7tU52RXHmygCdodjwDhL+F+oyIm69jC9YQr6yQTwZdCawUz6VJbCpo0HO8DNzUbK4lmviPtRmG9J22vQzefjlSiyoxGlq1Bv6iJ1ECvMZ+Ew5RI7GV+MVKb4+AR4KFVJjp/OjvkmtgBZ4po1Cdo3avq0ZfCfqtXl/6WZ7biUe2/GjphwyijCJ0U1VUX41etpUhlRMvy+aoDQ4My+1/fN+TeKDHiHwO/7pkkNzt3JIfFtt16oEA0n8QfkF9JQAWS97uLk3YVIIqD6q1YhoSmunQJVtFi0akmvH/mKlCzc6hAeqUakbonMpWWr2itCgReSxK+5ze6YyZYGsuBTi4wo6+2670TRTg/CsOBf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(6506007)(26005)(38350700002)(66476007)(38100700002)(86362001)(4326008)(316002)(478600001)(2906002)(8676002)(52116002)(66946007)(66556008)(36756003)(5660300002)(54906003)(6916009)(2616005)(956004)(6486002)(8936002)(16526019)(1076003)(83380400001)(6512007)(186003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4QMlX8G24CtYB8PYP+CFf2EbBScEDeOhP8gmWQWdTPaDzGYdWcC9wgqAzVGV?=
 =?us-ascii?Q?wiFS88syiCfFeLyA56shwml2Xvo9nhe5fLTvMwN7DF62rax55dcRmRBYaull?=
 =?us-ascii?Q?Aaj29J1Uu7zyIHlNRgnFyndQrsg4GE9fZIAYWeHFW/KVtS/hURtz+sN/pq+b?=
 =?us-ascii?Q?YDfGll2CnAgCfTzTOKA2BRhxUCV+U/SSnJWEuze7PeVurRwLG0Ls+FzHQBHK?=
 =?us-ascii?Q?te+8BIoh6Yj8ebZ5aQIHY+W98z3WV4s67xH55ykWWX1LZmjcjs8gMFiTmwlY?=
 =?us-ascii?Q?pV8CDpDELNGfDSIQpAVMVbRc0QQ2ScE+Zyi4VE8oPYPcvAsB7cRReJrShVBe?=
 =?us-ascii?Q?T4juZaC1TzNoFjPId66xG8HGtxfPWKDHf+8La7lVt/TyHIvX0G5/BiASGxsG?=
 =?us-ascii?Q?fDvCgg5bG27J6gXpGgon7rJfFMo04GQcJz7YzbXH3EpXMPSCZdvI0ZzsY5Yn?=
 =?us-ascii?Q?+RygFVERi3w3uMsg0wC3SPH3TMNWko7NpIFkfGq/9HaqruTXf7QTkavK8i2+?=
 =?us-ascii?Q?B9gFtdKz3FKnyHcsObw0/biGBJo3m+g/f/vv5oYrWZ+ABWRbonMAq0ZMhFN7?=
 =?us-ascii?Q?9oR9WfjL6sHrtGBW5cpXcg32ATmtEuYey2ekIz14YjkbQvElqXFG+2WuY+b+?=
 =?us-ascii?Q?64pTjxmHcAfwQ9/0JsE1MgJwiPcZdziukbby9LBd3SOj7OqjEX1swtgfCguj?=
 =?us-ascii?Q?SmnRvk0fc8IkXE239m9ym3wMtefYukOkYQm7mblAEv1sTx56xvOLbipICuQ/?=
 =?us-ascii?Q?2gpDJ5RgCjjU6fvwYMCQXMxRWkJ1npw78qtHF0IXC8hYxFKkH9BUJ9vwTaBk?=
 =?us-ascii?Q?Agn8ehlmbQVqx5bPHrMU05LY9WJOejQGLX769fA5ReJX1Tg12ecvwYKP9Asz?=
 =?us-ascii?Q?jbWBzymSDZKHzo5bAA/Hp48ax4W4p6xt880u7BVKdw7HOXONWBr9IussCMag?=
 =?us-ascii?Q?L6LwOAUndwHQCMUFSt7q2xkr0fP6LMfEoOqqNsTnXeghe6OWhkHMEC9boogF?=
 =?us-ascii?Q?0APY3cqGme97zje12wYaf7D3dk5DUWYHEjCHWnuGy/E7OHi7nqlpH4vbjOz7?=
 =?us-ascii?Q?Z32k06mto+sUmiqG2dL+gOUYnM2yuskw4O18ZLX1VO3w2cnRfVqhr1Vara5K?=
 =?us-ascii?Q?ytDnFBppl5U75nLrrc7LzzMThud4JwbO61KFXio0CwfrvzlgzsjAgLaO2yN7?=
 =?us-ascii?Q?xPwyvC2HH2r03fU/T4Y4+t/ktNTXNRI7vMtWEz6UrCjWz4FhvWEGOCeKY+L8?=
 =?us-ascii?Q?HMfCP7gu8i/pevYHthMffNXNOSY3/vnzeITBozQ1V8bCjIQ05S1VXCeeNzrF?=
 =?us-ascii?Q?5iwIuAJ7i0L/fG7LeWCT/eI3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74687af-d0fc-43f5-8d92-08d9156bc565
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:26.8779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VwqDW+F8HXhcieUxd/M3JRBy64H42qX0ljNnS/gIMiDWWX8qdvhPorX9omT7v9kgSurfE14zCg+WJrofHqZRw==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

add general PSP support for beige_goby

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/nv.c           | 5 +++++
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c    | 9 +++++++++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 17b728d2c1f2..e11aa4b54584 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -104,6 +104,7 @@ static int psp_early_init(void *handle)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		psp_v11_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 47119f91c817..8b502ffd58dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -403,12 +403,11 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_ALDEBARAN:
+	case CHIP_BEIGE_GOBY:
 		if (!load_type)
 			return AMDGPU_FW_LOAD_DIRECT;
 		else
 			return AMDGPU_FW_LOAD_PSP;
-	case CHIP_BEIGE_GOBY:
-		return AMDGPU_FW_LOAD_DIRECT;
 	default:
 		DRM_ERROR("Unknown firmware load type\n");
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 94336a3cb698..06ff5b23c993 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -849,6 +849,11 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
+			amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
+		    is_support_sw_smu(adev))
+			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 589410c32d09..ba50b16d1b1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -63,6 +63,7 @@ MODULE_FIRMWARE("amdgpu/vangogh_asd.bin");
 MODULE_FIRMWARE("amdgpu/vangogh_toc.bin");
 MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_sos.bin");
 MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_ta.bin");
+MODULE_FIRMWARE("amdgpu/beige_goby_sos.bin");
 
 /* address block */
 #define smnMP1_FIRMWARE_FLAGS		0x3010024
@@ -115,6 +116,9 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 	case CHIP_DIMGREY_CAVEFISH:
 		chip_name = "dimgrey_cavefish";
 		break;
+	case CHIP_BEIGE_GOBY:
+		chip_name = "beige_goby";
+		break;
 	default:
 		BUG();
 	}
@@ -200,6 +204,11 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		if (err)
 			return err;
 		break;
+	case CHIP_BEIGE_GOBY:
+		err = psp_init_sos_microcode(psp, chip_name);
+		if (err)
+			return err;
+		break;
 	case CHIP_VANGOGH:
 		err = psp_init_asd_microcode(psp, chip_name);
 		if (err)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
