Return-Path: <SRS0=l8SD=DP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A43C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2020 17:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F99221FC
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2020 17:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zmTBwGU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F99221FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F3EA6EAB1;
	Thu,  8 Oct 2020 17:16:16 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690079.outbound.protection.outlook.com [40.107.69.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2F806EAB1
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2020 17:16:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZAdmeK2FEZHbUYxcmr1zE8nledMnI9KSeWN9Ge09LPaYB8bdbIEUG2/bnvWjJepnOAM8U3SQixvf2cgNYdxuIhJ0fBJSUvDTKNrbnSlpLfwfxw4+LHsio+OIx6BK9ouhadMuBZbuo0rslpLvGnIjchDuQ0hnopEVHl6gSpYq4a3nhh3+n4NCmBduW8V2vNjJoQmOmcHXEdQd8DvQVrolHS8VbdB0VjO/FSP/3WatMmS7Su3ef/1/amlwg/Kc2vNH7RfpaJxfewJw7wsmFl20q1e3zb1fPaX55yqNjC62VXXmWso+ltlUUsj2Y0DDcF41hvbHkszkg2K930j+1XxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=td4GwyOHb7QIOVKexIDUKT9Dugba9W6Z2yZJgfGZSfs=;
 b=TDECIEl0HFk5qcEwqpZzMmfFiKOqek6y3oA7ZNSrJx6qs0wyCY1iVmItm6zjsEZUlDA1IYZh33MPnQfxIklKYVcDcuqxkgS3XiOWiAepq+BpY2DiQG1MD/0kDZJDkXlD3B3wV6VUgjkx5NwgBK4Yl5lYDEqTcRJ0nP3Kxf2crnMq+MpT9jHiCeVIJ/4nTW8fYnXUIc6qZaBwmDmi+I5++Y8OflHrHsI3Z6MLGMv3Ik1/2+4yk7SB/Ob7sY1SjZbOeYd2+hbFqrtj1UrRSaf99oKdNee4NLoR9ubXrwqIBjvm7/UlDOEqZv3B0N09xBWQ+NtSoVEbPANVHgMuM6Eefg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=td4GwyOHb7QIOVKexIDUKT9Dugba9W6Z2yZJgfGZSfs=;
 b=zmTBwGU0XG/va77fMKttVHsv1e14qgByVv3B26ujBV7SdGE+1aSHPxxnARmzZmA0wvFpB5K/o4V/ovb83ysshuCSEBqRiEFiFnDlhIifumQsmW/cAALb3dGFX+FwfCpQmuFNhYUn75wO60U90Ymho2BO3RJhDbEeI+kH4Q3WZd4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3290.namprd12.prod.outlook.com (2603:10b6:5:189::14)
 by DM6PR12MB3289.namprd12.prod.outlook.com (2603:10b6:5:15d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Thu, 8 Oct
 2020 17:16:09 +0000
Received: from DM6PR12MB3290.namprd12.prod.outlook.com
 ([fe80::1970:cf59:2847:1647]) by DM6PR12MB3290.namprd12.prod.outlook.com
 ([fe80::1970:cf59:2847:1647%6]) with mapi id 15.20.3455.024; Thu, 8 Oct 2020
 17:16:09 +0000
From: Gang Ba <gaba@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Change the way to determine framebuffer type
Date: Thu,  8 Oct 2020 13:15:57 -0400
Message-Id: <20201008171557.29071-1-gaba@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::20) To DM6PR12MB3290.namprd12.prod.outlook.com
 (2603:10b6:5:189::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Devmachine.amd.com (165.204.55.251) by
 YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 17:16:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a770a88-0b95-4276-e8d3-08d86badd96a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3289:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32892B2FDD9066416E0E19E5FF0B0@DM6PR12MB3289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDdCTK1uTRFodHfE6DMaktsrQ1pP4F0Zr9mfJq31XEiZzDa9WE1ja8cqpmR6qM7mej7IqU2Jsnkd541EGvNoSZUlkdeL1Tu9OT+3qLUhyM2ztQ3oYziYxvydHc4d0CJeNtDIKWmxOyAA1fUvWTfR5NMiFjcjNcFR1MOsqVenKKBRBPDwvErwo19Zmjh/AKwZCY7vjP5YbL7uM0HZ8xbo6pmrxhq23VJ/CGDkhJ8SQOUVsxKXZKlBEQUDn3A0u8sB/2m33yHVrp1wilQpqbUiulw8jpNVa6jBUEgBIB2/k7eqAbRyaY7p87d8gU9FKBin6KkPM951acYjwIvMXOG/rvIcsyAo6EcXbfHzvJ2fadCmpPO38vOaLuyNozpGNf7u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3290.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(2906002)(6486002)(66556008)(66476007)(66946007)(36756003)(6666004)(16526019)(8676002)(2616005)(956004)(186003)(8936002)(6916009)(83380400001)(26005)(7696005)(316002)(52116002)(478600001)(1076003)(4326008)(5660300002)(43043002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +vluE4n4WJDMP7EKPN81ePwkpszmyeUQxv0/L7I2JFFxAb3BIiH5TAQk0/WON9y8k7RAHN23X7En3hoq1UjQB3+kOt7yJNb60hkIUa8rDgvfUOoS7Mt6kyNJLt9WQiGbPgG5KD07mNDD5Ehj9CtFcKk12aj6eOAQVMqqaJ4hisoke0mNRfMa+LXOYmAoNFHdBouUcr/u52lugvDSTfHtMNuMCmizHDhD1I/FTpjltXM17Nks5KAniDguCnq/6R5kyXP7G89EvJmT6VBaU7JKyVfEiE3VWlUtSaywhvt0yKTv9CMic8r2z0JxdRu6Y280Lrt4eJ3G4+0IYgkhrTGiYleVj63JGaGYET/TOLtDFpCkY7dAWL2W7GIysyOxBS7lN/PUNUpabNqakPQYAhqWf8OqYJQx8h1kkmZjpKYUfa3/4i6LhI9nyfIIRBXSszWpgPZ89yxswKjokJUMh/t4ZZfC/MrottKujIXg+SIAGZQXgWqYy+ZIRdQ3dKbu1ySai5DpPSDCECcSwMDlkqYnHwwghawKV5kXtzockJ5DYXjTFzFwF/u9crwQW7nDAB318bMQ/fm16ba7ET9QYZFCELOnUBpMX0nRY+VNe32bfkSN8AfeN2Qi2dJCVkXGsrB8Ej5YjJv4HhvBCPRBLfwX/A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a770a88-0b95-4276-e8d3-08d86badd96a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3290.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 17:16:09.6836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ei449Dz7FbQJQzvPCjssbElqT4FFHms4Qxotm3gWrcVLXd7ThwrqiFNcrCAALnPb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3289
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
Cc: Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Determine FRAMEBUFFER_PUBLIC/PRIVATE only based host-accessibility,
not peer-accesssibility

Signed-off-by: Gang Ba <gaba@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 5aa7dbaf6e76..f066696338d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -390,23 +390,17 @@ void amdgpu_amdkfd_get_local_mem_info(struct kgd_dev *kgd,
 				      struct kfd_local_mem_info *mem_info)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-	uint64_t address_mask = adev->dev->dma_mask ? ~*adev->dev->dma_mask :
-					     ~((1ULL << 32) - 1);
-	resource_size_t aper_limit = adev->gmc.aper_base + adev->gmc.aper_size;
 
 	memset(mem_info, 0, sizeof(*mem_info));
-	if (!(adev->gmc.aper_base & address_mask || aper_limit & address_mask)) {
-		mem_info->local_mem_size_public = adev->gmc.visible_vram_size;
-		mem_info->local_mem_size_private = adev->gmc.real_vram_size -
-				adev->gmc.visible_vram_size;
-	} else {
-		mem_info->local_mem_size_public = 0;
-		mem_info->local_mem_size_private = adev->gmc.real_vram_size;
-	}
+
+	mem_info->local_mem_size_public = adev->gmc.visible_vram_size;
+	mem_info->local_mem_size_private = adev->gmc.real_vram_size -
+						adev->gmc.visible_vram_size;
+
 	mem_info->vram_width = adev->gmc.vram_width;
 
-	pr_debug("Address base: %pap limit %pap public 0x%llx private 0x%llx\n",
-			&adev->gmc.aper_base, &aper_limit,
+	pr_debug("Address base: %pap public 0x%llx private 0x%llx\n",
+			&adev->gmc.aper_base,
 			mem_info->local_mem_size_public,
 			mem_info->local_mem_size_private);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
