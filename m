Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F64EC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD4D60233
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD4D60233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C365A89DD5;
	Wed, 24 Feb 2021 22:19:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EFE86EB2C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COAc1047mFnAWK0Lo6u6tQqSq1L8AJa5lgfdt6FKiEygLZiEmBhCShwESoqyTE+rYMiao8anvsyCHdqCoUA+aqnA03RHdjWxoxCBr3rWuPePSFJsjTOEIphwbVUn3E7ba9mE6U8LexyYIXB12MW/lpNO5PE1ZGfGQcKQiSA1e6xYUFEmxFnm7sWbSZ94b8tmCJ9bn57per9B72Rp8eXm98k9vj0HvBhBnA7Jm9gxUgWAWUzd4fMqwGH2m2lzmwY9/8KI2eZUAgfxocUHWopCMfhJCTmlpCTxPsD+1RJEx2cy+yC3A3Gtw4WBvgpXjtNnY/p4hIX90vqNjhpmnIrmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sckxxSMPU2vSWYGqctxHV/ic9Gun4p5YvZ1yhh7qAPQ=;
 b=K9qaxkIvklSgNm6WOvhNfXdYwQFu7NIdHm320bVlTPDs9RDC1sOTALwkP716qrPc92z/OrLjsc704PQvai236Ul54frKxE0OKZ7Ffe3tSV1mGENKk+YoBpVvu0VKdz4Os11v/SpYabZyEwF1a9LJJGMehPgyp0tgMs2kSvVJ6UwlLqcEsy61nRsslO2UrkAYJXipCFvAu7YqruaCAYoSNt3DLgKg4hvQ9m6JkqAS4fYxf6afhx4zkmtdS32hwvsBIiIBKuaK9Ef+p9ZRe4Rxo14uHtdUy+etWvfYvWM6bPWbUUHOh7F5QeAJrTzVulZNI2MW/p7e8sljvHiGQHOFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sckxxSMPU2vSWYGqctxHV/ic9Gun4p5YvZ1yhh7qAPQ=;
 b=iKGSt6rxR2Le7ec9sk861unKgANgL/IzwVllh4bi55k5XpEpmsek1InZNVW0xLuTFAuohouo2dnZwbYowjyDheF6PVPj6Do3c7t1mL4jKIg9UpY+VZpWV+5ddjNOzEP9drszGTmIP4nQuN8QLcWVhsXW6mspQRS90vk0o3DgJ+4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 22:19:44 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:43 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 035/159] drm/amdgpu: enable psp v13 ip block for aldebaran
Date: Wed, 24 Feb 2021 17:16:55 -0500
Message-Id: <20210224221859.3068810-28-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c120ce5d-b44b-4df2-870b-08d8d912494b
X-MS-TrafficTypeDiagnostic: BL0PR12MB4865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB486586D0DCE7F6CE4D20B810F79F9@BL0PR12MB4865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I39gEIytgueQ/Za34AY4S0N3KtoL8ClucKar/Z0EthAv13X/2wUO8RImLZyeDpzm2wr/IX1tz6Nksq/gJS6C0TKUoiuvkkU2EiOqZfYeNUqJlFDqeCJBiSTN4S0TRn8ntdFEc0W79iF9JRjRkVmxmaMxr7bUz0Vk0D2c4V0yznfx3iwK9nv92FEHz67SWDQjUub4nk93YZaVCK8JENGJukrnuNdRoQ8BxQQNotBTeS9kZqgDU/lzMJ+Uqr/j9JgWuLvKlv+IwfHZg4zzXB9iKaHJU5v7TbCWM2I2kFCO1rWk9geQYJgogWkbnCC5n9FCElkFyx6XM05TOgZLf4P3n9uTAY1DfhCz35kfMUKSC4oa6I4iGFb68lfpJ59jv7nf+1rNaEwat/77dLBrKL+2d5wWZX2qDlLXeWphRGJZdPSCQMwVB+lU5rPuBe+ubBhKjbsLYBCdnh55PDvRDzKvGLUPeW+h37XmENKlj0Gp3MruuaJzV9l96YxP+B4VedDllYOfbxjR0VMgG5fOB0/6znmuXq5bUJmAlQI4JvXEpcgWZ1HzKZv5Uzar1nZTc7rfuPXS27KxTwwXLsbMXERSag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(6506007)(478600001)(316002)(66476007)(66556008)(86362001)(2616005)(5660300002)(6916009)(8676002)(956004)(36756003)(1076003)(2906002)(6486002)(6512007)(26005)(4326008)(52116002)(186003)(66946007)(69590400012)(54906003)(8936002)(16526019)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sAfeOmbAQwLVaUtZR/0B8rYiP53JpjJGyucWt6axNhWlCzLE43SMRviy34rr?=
 =?us-ascii?Q?+H8SGgtpGQqUg5BDuNv/+KER09G5AVVR0fqymH1k7NuteLKYMmZSj2veycad?=
 =?us-ascii?Q?to2Z+scT/zTiL73D34K/Rq/WVXNLFs+i3hwQD0SuEkiHydFDRiQR86Xnd8YC?=
 =?us-ascii?Q?/n4KKsavuhHBtUd1rIbq9ln2n1fXnGWsw3+KX/mY8sz3i0aDibAhIJGVBosB?=
 =?us-ascii?Q?FsI/NAyxkIbZKwZDzzgvq1PErWNnWLPD2LwSNlRt6Rn+vPJssJvUXMEHtRKj?=
 =?us-ascii?Q?JOTNRWQArT1pRozvv5DGv6kytmzIas+ce06w+YxhcUDpJeWW/N4BFpFKWeuV?=
 =?us-ascii?Q?cJxHCQOki6IUvyYRPurwHWlmLCX9qsT/g/pEwpXlGtt4PB47gCXti0/Aq95V?=
 =?us-ascii?Q?auAlFvqKNyrfCXUWluJ5N68c5RMUFQq5TXMvMXnnzdYLFVdj+WDWeBmxS7/w?=
 =?us-ascii?Q?0tuJHFkklQSiiCS0t9xM6pO8TwthOcsToDfu0p3+MNkgVqt/C9F8eDczBtU4?=
 =?us-ascii?Q?3wfKT7axnHVkHwyEFHGELmpeZWFuQhN150HqbP2NsZIlmoYXGwb51aFIZnUu?=
 =?us-ascii?Q?asuGyKHxBBa0W1WmDKIyTEZs2nP7fITPMHJotfGhbGDZENlWPe03CkTqDS3J?=
 =?us-ascii?Q?OEWGpPiVabOmuJVES2R5CyQbc9IL36IE5Zo2BhSjQJ224ei8ZALvWRPFSs2J?=
 =?us-ascii?Q?H4wY6HdGvDTO/LD12EU6t/FvahL9jVhpr37MzzIW9yCiFL6CNLpKoe5sNYug?=
 =?us-ascii?Q?j5tJGgrq1ahd2l7OrrMNAhghY6R2NVJeh0uiSpMpca8FUONqD79S7oVmvHRo?=
 =?us-ascii?Q?sVyoZE35AOqDKQzDhze5CdJX+NMeJTnSgwhGlUh1DWpe6WH12LTkz8olAIvu?=
 =?us-ascii?Q?MVrEmwZ2/6nggvo/NfGl4PQIoj6TCkVSCA/Ke24V0H2/6DLK9UgB1x/vJaD/?=
 =?us-ascii?Q?oGWTSjwwrozVMKkth0s2MX13HTDNQcEV6QQgrx5qHitdgRxhGCZdn2owRQsu?=
 =?us-ascii?Q?/bYVisOkKZYIyJ4m4FtLiE+t2i9MqvfrmQUBrq8qbKmr4AzZXoc8WssUy/jJ?=
 =?us-ascii?Q?ERRVKnBLlDMrLmOwnZw7IRwrwv2kmrxzDYKsjYAVzFChH0wEDVpJasmhlzsb?=
 =?us-ascii?Q?S4n/LYOeL2g4ezDSN7l2ju7D0th6id1+dRiSvWvys5UQsE4b24btra0WMd7Y?=
 =?us-ascii?Q?J5eBKo6cqbYTxSoJp0B2dOBAOUsnP3DFbU0h7XxZ/vhecoMKp2GVvsPpcSCV?=
 =?us-ascii?Q?W0h3Hdfbv96cB321p/+edEeLv0sfCVbaD6Qeeej+WXhpMPKpOA8mtYP7L6aP?=
 =?us-ascii?Q?1seaR4muKb53uokuHX6t6swk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c120ce5d-b44b-4df2-870b-08d8d912494b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:43.8177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzaCpgnCM2F5ZeuQx6o3aB1Wj9fTGj6JBEmJGan0yKmPCTFILXe1uUNjTFEdasL/BQaqofmdhjA9hTZQ6P5kxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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

Add psp v13 ip block to soc ip init list for aldebaran

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 12 +++++++++++-
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a5f79b09de9c..abcb2721df15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3057,3 +3057,11 @@ const struct amdgpu_ip_block_version psp_v12_0_ip_block =
 	.rev = 0,
 	.funcs = &psp_ip_funcs,
 };
+
+const struct amdgpu_ip_block_version psp_v13_0_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_PSP,
+	.major = 13,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &psp_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index cb50ba445f8c..2ba6490fa487 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -365,11 +365,13 @@ struct amdgpu_psp_funcs {
 extern const struct amd_ip_funcs psp_ip_funcs;
 
 extern const struct amdgpu_ip_block_version psp_v3_1_ip_block;
-extern int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
-			uint32_t field_val, uint32_t mask, bool check_changed);
-
 extern const struct amdgpu_ip_block_version psp_v10_0_ip_block;
+extern const struct amdgpu_ip_block_version psp_v11_0_ip_block;
 extern const struct amdgpu_ip_block_version psp_v12_0_ip_block;
+extern const struct amdgpu_ip_block_version psp_v13_0_ip_block;
+
+extern int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
+			uint32_t field_val, uint32_t mask, bool check_changed);
 
 int psp_gpu_reset(struct amdgpu_device *adev);
 int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
@@ -400,7 +402,6 @@ int psp_securedisplay_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 
 int psp_rlc_autoload_start(struct psp_context *psp);
 
-extern const struct amdgpu_ip_block_version psp_v11_0_ip_block;
 int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
 		uint32_t value);
 int psp_ring_cmd_submit(struct psp_context *psp,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index df7d8aea57e7..d379fcd48b31 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -835,7 +835,17 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 	case CHIP_ALDEBARAN:
 		amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+
+		if (amdgpu_sriov_vf(adev)) {
+			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
+				amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
+			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+		} else {
+			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
+				amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
+		}
+
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
 		break;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
