Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC448C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B2A20657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DI/GAjgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B2A20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91EC16ED19;
	Fri, 15 May 2020 18:13:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0451E6ED18
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cl2rXNUsrVP7eYVWXbbcQdxqi2XWTsPUecZkZzux7gYi8p35kqMUNpHt9VgsFK994cyE4PLbC31V2LRtrTMguC+InFv09HLo8ZxT7IEc444tCtCueWoTBLq377QiFBEeCH7KBK8w5338gKLKh32kKYO18+jM28BYnPiYYX83hk9DRu+h/jtJ9nGxhISvnl07o5/8p3LPY4ozmEjLDDF58ttRKwjZxHSLwcpwhCM2ZZXWnaPzcZ1KMp8xoCIPXTjuPLVj17+AdWseIhjqydSKjQSarVxdm5JdculSbN67NQmZ8LsRe20fEoL54mG+UVfxYmhd/d+d+V1pk0E/1uGvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Qkao+BD7Udy7z8tbIQq9n4rTTZz6WxCFhNCtMLKvXU=;
 b=LhFornAu+bnWOvcUC7aAkMOcLnjs66E7Jtac8QevWE8OLOqPL7xuCYoqZ7kcsHUr/IrKNJnrRkwi/Evj1EbXGk6jctqvdhpdmsd38Nio5Acj5RyT2NzbV/Qcz+XDBH6Dyn/h/kx0ihiq2bM5XLne7Z0Ynblw4ULQyHvaxP3wOmL/4cfpzq0jqR2CJQAII5dTMXzR05oSJhGWJLHeihDjOvHkvijLwl1ccQXUgAY011uAaIBTJbwM2BslGdKF+xUB0kbx2XApgxCb/oTGlEJTK0yz629YOuMpNf+m+rnNVoWLttFDWW2qBoJZIM7sQH8+xpM0Wib3Gm4glOCWtthbkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Qkao+BD7Udy7z8tbIQq9n4rTTZz6WxCFhNCtMLKvXU=;
 b=DI/GAjgfmRA4IUEj5PiX4oo4VouAsjx6wntfwMvC7WoWWOlbp+Cd3y6+68Bo9L+0Nl5k7sERHf7h5V/ZLEB79Fjr6z42cdRuhKwK7L41V7wA5bE9D2t3h4+1wove+iF4UNtkKxENCV7W1C7/CwwdSpAo/OxONgytsWrgV3n10+0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3974.namprd12.prod.outlook.com (2603:10b6:610:2e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 18:13:44 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:44 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/27] drm/amd/display: Don't pass invalid fw_bss_data pointer
 into DMUB srv
Date: Fri, 15 May 2020 14:12:54 -0400
Message-Id: <20200515181315.1237251-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:43 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c2b926ce-c191-402d-535a-08d7f8fbb456
X-MS-TrafficTypeDiagnostic: CH2PR12MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB39743F10836423BD5EBD3F9898BD0@CH2PR12MB3974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8oDFXgAcyGdzPJRPwphUfixy7CwIuleiZou3xE1VBS+xu4tWGEUcJMS3JoOFjHW9iu96pRmg+Jfndlq/uVS6z+nuW+WQChGkHDEzw8k4MWyKVmhO8EdaNxnXips9SjpKSnVeYIIvnh3qclCEbYi+m0e3JOcIAwl1vvduM2lHpwOSc5RN/n9R/zZUj0t7VpGmyWbGWeEJtypREpKRFyC4+PrfpIpNAXirb1Z08FcyH6ahRNamK9qoZzyjV8N0DrjMZRc8Rsgk6LoqA1V9Kl9yZL4TVAS6oBP4xlsKGUZDeFX7nAUvr8ZcJk7EtX4/Cb0VzAAIWTpASSttvBnToH7oe9U3glvOPOAlaqBslO4cmZJ7dpSyBiw9YDFH/jl6Gn9FkrV9kwnoDQlkTeT+YMh6V/hrGB5tNEvZyvZgEQEBgZeR64hncGkhh5ifx6ZJB4kL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6506007)(316002)(8676002)(8936002)(86362001)(6486002)(54906003)(6666004)(5660300002)(6916009)(478600001)(6512007)(2906002)(36756003)(66556008)(1076003)(52116002)(16526019)(186003)(2616005)(66476007)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1Ekv3Q+Td4m+MMTjC/BJD18b/DSdNkOTmLu4U2lSvMm5vlbXYYHCxOLHajz9j3734++3nl3m7qdZHjZ2ITCCoN+WgWufMRbJRYirmpzeb/SrgVqDGmiS/nixrUWnxfOj6V56C7vXh3l6pVycIGUYX3RZihjcyXXUckBSqd2Hl1s5Q1gtJQJ9Sj0BAhKLEvPeYjonn38alJg1+JRpZfJFtbox1Emoxo8Q+xMnu9WEGCdu+TcY2gaLV12xf9q83QQZ4qhvzRFyNcfALa/OvH+Fx+zz1jjhDoTDQrF6WPMve/7FsCzh8cRm7GlpG3J9xlRyfQTGfYtrHspewhKNVmHd2Z4eNNgtpneyavHvnPzVPfI42RyVktvm9oAe6utuLRtAdDN0tMbrnbCpMuVDKJ9hM4/h62ByEDq5RO2RvMKO5O9LGM+eRphzvzGN45/l1L1nLZpOJTk+O3MTRL68lV1IYRZHrbebE4rEfS8dTKFmv61bnLgb7ErZ9BCyGloqs/0hVpMVWVfHfZKZHuzaYFQ9eQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b926ce-c191-402d-535a-08d7f8fbb456
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:44.4057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XaJRg1Gf0LAnvSrJV5YGCRVqD+xYqym+Hzo3aVWKo1niU4EOr0zJ7YjDIkmCtdGWhUwTGpAjQL1pGP8e9wNwXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3974
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
Cc: Zhan Liu <Zhan.Liu@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
If bss_data_size is 0 then we shouldn't be passing down fw_bss_data into
the DMUB service since the region isn't really "valid."

[How]
Pass NULL instead if the size is 0.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 60fe64aef11b..d2bb0d9839c9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1211,10 +1211,10 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 					PSP_HEADER_BYTES - PSP_FOOTER_BYTES;
 	region_params.bss_data_size = le32_to_cpu(hdr->bss_data_bytes);
 	region_params.vbios_size = adev->bios_size;
-	region_params.fw_bss_data =
+	region_params.fw_bss_data = region_params.bss_data_size ?
 		adev->dm.dmub_fw->data +
 		le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
-		le32_to_cpu(hdr->inst_const_bytes);
+		le32_to_cpu(hdr->inst_const_bytes) : NULL;
 	region_params.fw_inst_const =
 		adev->dm.dmub_fw->data +
 		le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
