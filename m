Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31683CDB471
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD5E410E552;
	Mon, 22 Jun 2026 08:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c8nRzipP";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011025.outbound.protection.outlook.com
 [40.93.194.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDFC010E551
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWhZsT+k9EL0sWQBvikf7Nd0KUZirxViMsFsiRomCjqWpynwDG/5IPAtavoTrwU2IEO38oHX+ByxoHGAYO06Go+PRI26WA8HLLf0sOzWBJF9KlHZt6tk+cy7BKBMzzNlGjOO5/qnCwwjsKKwMS8mPp8Y7QhCISNHJQILZGCv48zxmo6nM0rVq/jBD4gbK4bV0EnGvGQq0vIqrsSBSJy4T/C7j0jxQrDUB/1bz7JQFpqkKSOwuqoygF7xBdWUFRZsTtgwvbUg56/tURBy2DbelnaraVxBCzFJx/uXIITzvXIVGu18m7nQzbEp4u8fDVSpCMTUeiNNp4mCnDgQkV9Dvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QptOuY1tPsWBNuPUDVqephV/QsWBI8uBGnYuOO+fxSg=;
 b=YbQ7yoAUOZMwuw3VPRNVQ+eet047obhcpM8J96djzxY5uM0jFRcMC4GDVZSAKW9Y18/XDmqKzqF2neE9k7AqESaMFdm+ItQ/FLVVewZCOS94AvjOeKoAR887zCnNTDNIlFToLp8tXKXQ5sb6OAEnnWmNg6tCtipBmPE/rOcCh2IkkricsUu92ErMGMO05HiOHteTOXXHrCa4dY1TdRSP4+YbnnWU9DY/qovURIvC90/6ayAxwCghCrK5ixe/i7oMTTiv6ErP2m/PuVCcdsMg6JEeaFLGwTGupHSnngDb22s44dKwJSCplC0vVFB5Hu4d+bYoidVawmIb2kg0KpqECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QptOuY1tPsWBNuPUDVqephV/QsWBI8uBGnYuOO+fxSg=;
 b=c8nRzipP6Dln4I1MeaLoD+chQ1a4eUskENHpKFXFefbaPruJeoAm9pwp9ZXQI0o1FLsVB0H2ea7DEW+owtFxj5FpJuC0hdNrbhuQMQPRIqK7Yx6OW3kOoNF7Nyn/uPQjsoOvChDaB/Ca9RevJg+9yU/8Z09w6WBLiU6sbpXkstI=
Received: from DS7PR06CA0043.namprd06.prod.outlook.com (2603:10b6:8:54::25) by
 DS0PR12MB8504.namprd12.prod.outlook.com (2603:10b6:8:155::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Mon, 22 Jun 2026 08:45:21 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::65) by DS7PR06CA0043.outlook.office365.com
 (2603:10b6:8:54::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 08:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:45:20 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:17 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 05/48] drm/amdgpu: retire ACA support for jpeg v5.0.1
Date: Mon, 22 Jun 2026 16:44:07 +0800
Message-ID: <688965fca9d9d01d965684974b6eb0cc8dcaa1cb.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DS0PR12MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: 98437cf6-da2a-4313-e502-08ded03a97b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yY6cBIys67sSzmb0tkmIrkfbDnTdB2kj+neg5NQGU6GHu9hmL3Zpi7phQXjkMe766ubOyjoXBlTqVqEf4LG1DazL329ZOdVR8+RXESvpKmVnzS3EW8gHDiyQ7Gfb9cshJatx5G90eToC5qRO51KbxRs+WdxdzvqZuN1KgRTR6LEF/8/SCald5JTI7Hil8GAJonaerTbyUtC00zUiquf4nigV/6g49t1Z9WfYarisSewAeZvBhZTEW9MKCsVv37XpAZPHLX0T9gCwGSH5NLXo5h/7cJd1eDR0Ycz0zuyCu+Fv4MgxTdIOtxsJrV9xvwVn1dK078RRKzCOJoPCtJufWZD9859S/GfS9B7LC5smvznHd4TPohQCzknnf4ra376Q2gkXdCB/B877nhVRZ6OqUy+X36Z+dmvrKPa3067vNKNb0Wiz8hv62A7jh/z8cQtwj64DoxSeCt74vXCWzJqqv2s/j4nqPbJ62X94iHDX5TwvkT/57uY/bO4XUk4FuuMxJk5X17KHNQv6t/mapqC3BIDHTyHoVdDPyH5c6oH9aKBIByN4i/JcDsABWqr5kni0EdzjKHB0S/crreie5HshTlo8UOJ7JlfZY3h36matCIHoaZpGpxoaneD6NtpSpqhORljLmT7PUZncX1rXwG05QiWvBMzLWwqFXYHTHQEsScemkPXXNTEbf3v+QDpR55QwC7Z2Mub/2m9r7sD7BMFefA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J6+6BofBexzm/ZSG5HdVYGIoe6f+yOWQ6Mi1I6zYCeemQtYMHH9/48lNTgOsTFQeZWylMsUczaLc+kXRpRmP6u57a2Y1zME8e4A8k/QOuJ/cD12hkTz4Hb8wViPP+OjzZ9UaWekBU485RQOLjKixap1EAeg8pba1jeTliHxKZbkXt8TNEXpJXtX9bQqk5ewprb3IHBpaH5nwhodRzzNTTcitaxpzlnHCHCYv0d2d/4zs2/RkCYQ4qCR1+Uwet/jvy4PvaqiiIdYlEoBBNa8EBAgFs6LjZPgDq4cCP25qdkPBBVipM7N9PcN1lKZGUCqZ7mo6m0CDF7xqqg72q/fvtWtdFYrFm1ilg6S2PVTZeVOFLBMMhfLVxbpgvSsjkwBfBlclspp0ZmemJtT4n4UyjBb3MFoSbN9cPiXTmgkUTFD2wSC6F+Pw8RTtZ9XbtpV8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:45:20.4553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98437cf6-da2a-4313-e502-08ded03a97b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8504
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Retire ACA support for jpeg v5.0.1

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 96 ------------------------
 1 file changed, 96 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index a562369d2d81..ed66d5425c95 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -1017,105 +1017,9 @@ static const struct amdgpu_ras_block_hw_ops jpeg_v5_0_1_ras_hw_ops = {
 	.query_poison_status = jpeg_v5_0_1_query_ras_poison_status,
 };
 
-static int jpeg_v5_0_1_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
-				      enum aca_smu_type type, void *data)
-{
-	struct aca_bank_info info;
-	u64 misc0;
-	int ret;
-
-	ret = aca_bank_info_decode(bank, &info);
-	if (ret)
-		return ret;
-
-	misc0 = bank->regs[ACA_REG_IDX_MISC0];
-	switch (type) {
-	case ACA_SMU_TYPE_UE:
-		bank->aca_err_type = ACA_ERROR_TYPE_UE;
-		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
-						     1ULL);
-		break;
-	case ACA_SMU_TYPE_CE:
-		bank->aca_err_type = ACA_ERROR_TYPE_CE;
-		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
-						     ACA_REG__MISC0__ERRCNT(misc0));
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-/* reference to smu driver if header file */
-static int jpeg_v5_0_1_err_codes[] = {
-	16, 17, 18, 19, 20, 21, 22, 23, /* JPEG[0-9][S|D] */
-	24, 25, 26, 27, 28, 29, 30, 31,
-	48, 49, 50, 51,
-};
-
-static bool jpeg_v5_0_1_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
-					 enum aca_smu_type type, void *data)
-{
-	u32 instlo;
-
-	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
-	instlo &= GENMASK(31, 1);
-
-	if (instlo != mmSMNAID_AID0_MCA_SMU)
-		return false;
-
-	if (aca_bank_check_error_codes(handle->adev, bank,
-				       jpeg_v5_0_1_err_codes,
-				       ARRAY_SIZE(jpeg_v5_0_1_err_codes)))
-		return false;
-
-	return true;
-}
-
-static const struct aca_bank_ops jpeg_v5_0_1_aca_bank_ops = {
-	.aca_bank_parser = jpeg_v5_0_1_aca_bank_parser,
-	.aca_bank_is_valid = jpeg_v5_0_1_aca_bank_is_valid,
-};
-
-static const struct aca_info jpeg_v5_0_1_aca_info = {
-	.hwip = ACA_HWIP_TYPE_SMU,
-	.mask = ACA_ERROR_UE_MASK,
-	.bank_ops = &jpeg_v5_0_1_aca_bank_ops,
-};
-
-static int jpeg_v5_0_1_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	int r;
-
-	r = amdgpu_ras_block_late_init(adev, ras_block);
-	if (r)
-		return r;
-
-	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__JPEG,
-				&jpeg_v5_0_1_aca_info, NULL);
-	if (r)
-		goto late_fini;
-
-	if (amdgpu_ras_is_supported(adev, ras_block->block) &&
-		adev->jpeg.inst->ras_poison_irq.funcs) {
-		r = amdgpu_irq_get(adev, &adev->jpeg.inst->ras_poison_irq, 0);
-		if (r)
-			goto late_fini;
-	}
-
-	return 0;
-
-late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
-
-	return r;
-}
-
 static struct amdgpu_jpeg_ras jpeg_v5_0_1_ras = {
 	.ras_block = {
 		.hw_ops = &jpeg_v5_0_1_ras_hw_ops,
-		.ras_late_init = jpeg_v5_0_1_ras_late_init,
 	},
 };
 
-- 
2.34.1

