Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D66C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 11:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86669610CB
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 11:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86669610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 256936E03F;
	Mon, 17 May 2021 11:39:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBB676E03F
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 11:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJokESTkRhg9cdCZ4cpXeMUmXrYmDsAt74TGjjZPWYJ5IDfSaYKvBqYaI8LLaCGATnb+LQJuh1+6ZJYAE7n19UK5xz4MJCqvkciccuECI/T3aq9mBPJK9FqD3eRUEn+hTLQ4q2BNePKw2rFK/aRqx0C6vPCcw75C9OzRYgdMYkWK3y7JVFKgEG4jmKNxRwDNwFDYx3oaV1MeaZcTi8Th8hpLT3vMr+rWiv9TXWvnGv0iuD1L0d9qBQp1lNvAtPUBWxfdlQGWP/YYgdgnFPuriEQsdt9+eicL6rpDMXobDznL3/oJGGt40xlKOoPY6pISesGPkQWTNST1oM+yY5Getg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkSjydTn6tJjnic/6xGEn+ggBOCbjMMldYBhhejQ/3g=;
 b=X8PsFnDShDQ65+F9SpdV8wR9Q8/U3Z+m7btaOruBps6COWnw/2ESOGmYgCtKgx3nV0SzLDRMXTRAbJoFH6cqVKXwfe6xvEz2f9C9HKMxKu62vu22wvn9losOnyaF/cqXkX4NA7zfn39RiNK8P7qBoTY49ULIuejcv5cYo88ZioUqVx3BbrvoltAmmunNFmILqrzadHgHxOoww7vQUg85mSsA/crqO5uHqnEM5lU5uUU6lSGOsnXdoLlzI+WZCz6gLVIG7QoU6mIUoTuZuhz2CV3PFionRettZcgsjCup2VpHmDs9CpeVYihwT/YdqBHG7WMqTxMMu9XXB9iXalMyIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkSjydTn6tJjnic/6xGEn+ggBOCbjMMldYBhhejQ/3g=;
 b=DtN55UpS2b0fQY7aGFUWJ8OxCmViqL9nTcWjj4nLnngsH4m9lpemBYOPMbqeF+5cbrvSsog4cmBGeTikj9MD0Z+OtEELDmTnoTDYUSBS1O+5LbaLMwIfl+1pi4Mp2gByZrx6ELQxrkdcvR8kgbYyfnx6fJlK1YiW7/PYOtdegHM=
Received: from BN9PR03CA0537.namprd03.prod.outlook.com (2603:10b6:408:131::32)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 11:39:11 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::13) by BN9PR03CA0537.outlook.office365.com
 (2603:10b6:408:131::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 11:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 11:39:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 06:39:10 -0500
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 17 May 2021 06:39:08 -0500
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <david.nieto@amd.com>, <maraeo@gmail.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Revert vbios info ioctl patches
Date: Mon, 17 May 2021 19:38:44 +0800
Message-ID: <20210517113844.24829-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2844d915-f5d1-40b8-f7e3-08d9192863aa
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:
X-Microsoft-Antispam-PRVS: <MW2PR12MB24099AE5E236C1A9603F98DDF82D9@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40DhmL7zLNNSEeLJ+COEciWrkdSfl/xXK75dbvzZHc2688ciNSk2Hbq7dNZR40J9nwg8hynj/KIQfYhlflnZwsOuAPHxLeqOmTlbsznrxvo8hh5JJyKbhk/it/1CLyFSbxVuCRl1s1ZpQM0ruaXJ3r7w1poBeK/VlcukyctQrsQEd+mbk7o0J6cYpG1Bs5PLGbFjkTe9SuLIa3OInBNbTU31sUxdkY5Cn/2BHJSM+kGkVA58jvmfiitXWkA74wxzf5D27VgmnxbsUfoR3SKE0+aXeNLL4C5Ejz05Wi4dTq7eGY+bEsk+D6IS5jeND0K6TkZS6IpLq5M3rv8MGAQNCSGwhYG4gDtRnexVoFrCvCxZ9AGvtc1+eSOS3eHA1YyIivsJnL/ajd6eysTwrvntE7FK31hHo807TDB+iPIl0W/BcOe/ehMhLDLEdCnCgYP5wrVgATEYosvoKpxDON+EQar9OADSo/Lg9vxJ03afiuj3OZDJJdUg8+IEvJaM4Y1xUpn3HaHgVnXsHY53CYo5KC8nyKfkbQ/aEhJC5+bBJebUulp7UzOYLPttOhpzrVRrHwcw1VVdg+Dd/fjNSLqpi9ObxAWvumy4B60ALaVF8344LDAjDb2P+vne1r3S1e2M9DDSLosw1L1+8hOwbn/mVmDXuiavr/WLHR8u7LR+Foj/McEBRfHuv8fofg20WmMh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(36840700001)(46966006)(2616005)(316002)(36860700001)(26005)(478600001)(2906002)(36756003)(47076005)(5660300002)(336012)(8676002)(6666004)(81166007)(82310400003)(82740400003)(8936002)(6636002)(83380400001)(356005)(70586007)(86362001)(70206006)(1076003)(426003)(110136005)(186003)(7696005)(4326008)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 11:39:11.0731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2844d915-f5d1-40b8-f7e3-08d9192863aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2409
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
Cc: emily.deng@amd.com, Jiawei Gu <Jiawei.Gu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Revert "drm/amdgpu: Add vbios info ioctl interface"
Revert "drm/amdgpu: Field type update in drm_amdgpu_info_vbios"

This reverts commits:
d75a789ace808b738081322f27dcb1abe5cc9aa9.
50c70d479041e2d8a6a22b2ee4d76cfea1327576.

Reason for revert: Step back to update uapi in a single patch

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  19 ---
 drivers/gpu/drm/amd/amdgpu/atom.c          | 158 ---------------------
 drivers/gpu/drm/amd/amdgpu/atom.h          |  11 --
 drivers/gpu/drm/amd/include/atomfirmware.h |   4 -
 include/uapi/drm/amdgpu_drm.h              |  15 --
 5 files changed, 207 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index e1008a79b441..8d12e474745a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -861,25 +861,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 					    min((size_t)size, (size_t)(bios_size - bios_offset)))
 					? -EFAULT : 0;
 		}
-		case AMDGPU_INFO_VBIOS_INFO: {
-			struct drm_amdgpu_info_vbios vbios_info = {};
-			struct atom_context *atom_context;
-
-			atom_context = adev->mode_info.atom_context;
-			memcpy(vbios_info.name, atom_context->name, sizeof(atom_context->name));
-			vbios_info.dbdf = PCI_DEVID(adev->pdev->bus->number, adev->pdev->devfn);
-			memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_context->vbios_pn));
-			vbios_info.version = atom_context->version;
-			memcpy(vbios_info.date, atom_context->date, sizeof(atom_context->date));
-			vbios_info.serial = adev->unique_id;
-			vbios_info.dev_id = adev->pdev->device;
-			vbios_info.rev_id = adev->pdev->revision;
-			vbios_info.sub_dev_id = atom_context->sub_dev_id;
-			vbios_info.sub_ved_id = atom_context->sub_ved_id;
-
-			return copy_to_user(out, &vbios_info,
-						min((size_t)size, sizeof(vbios_info))) ? -EFAULT : 0;
-		}
 		default:
 			DRM_DEBUG_KMS("Invalid request %d\n",
 					info->vbios_info.type);
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 0e2f0ea13b40..3dcb8b32f48b 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -31,7 +31,6 @@
 
 #define ATOM_DEBUG
 
-#include "atomfirmware.h"
 #include "atom.h"
 #include "atom-names.h"
 #include "atom-bits.h"
@@ -1300,153 +1299,12 @@ static void atom_index_iio(struct atom_context *ctx, int base)
 	}
 }
 
-static void atom_get_vbios_name(struct atom_context *ctx)
-{
-	unsigned char *p_rom;
-	unsigned char str_num;
-	unsigned short off_to_vbios_str;
-	unsigned char *c_ptr;
-	int name_size;
-	int i;
-
-	const char *na = "--N/A--";
-	char *back;
-
-	p_rom = ctx->bios;
-
-	str_num = *(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS);
-	if (str_num != 0) {
-		off_to_vbios_str =
-			*(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_STRING_START);
-
-		c_ptr = (unsigned char *)(p_rom + off_to_vbios_str);
-	} else {
-		/* do not know where to find name */
-		memcpy(ctx->name, na, 7);
-		ctx->name[7] = 0;
-		return;
-	}
-
-	/*
-	 * skip the atombios strings, usually 4
-	 * 1st is P/N, 2nd is ASIC, 3rd is PCI type, 4th is Memory type
-	 */
-	for (i = 0; i < str_num; i++) {
-		while (*c_ptr != 0)
-			c_ptr++;
-		c_ptr++;
-	}
-
-	/* skip the following 2 chars: 0x0D 0x0A */
-	c_ptr += 2;
-
-	name_size = strnlen(c_ptr, STRLEN_LONG - 1);
-	memcpy(ctx->name, c_ptr, name_size);
-	back = ctx->name + name_size;
-	while ((*--back) == ' ')
-		;
-	*(back + 1) = '\0';
-}
-
-static void atom_get_vbios_date(struct atom_context *ctx)
-{
-	unsigned char *p_rom;
-	unsigned char *date_in_rom;
-
-	p_rom = ctx->bios;
-
-	date_in_rom = p_rom + OFFSET_TO_VBIOS_DATE;
-
-	ctx->date[0] = '2';
-	ctx->date[1] = '0';
-	ctx->date[2] = date_in_rom[6];
-	ctx->date[3] = date_in_rom[7];
-	ctx->date[4] = '/';
-	ctx->date[5] = date_in_rom[0];
-	ctx->date[6] = date_in_rom[1];
-	ctx->date[7] = '/';
-	ctx->date[8] = date_in_rom[3];
-	ctx->date[9] = date_in_rom[4];
-	ctx->date[10] = ' ';
-	ctx->date[11] = date_in_rom[9];
-	ctx->date[12] = date_in_rom[10];
-	ctx->date[13] = date_in_rom[11];
-	ctx->date[14] = date_in_rom[12];
-	ctx->date[15] = date_in_rom[13];
-	ctx->date[16] = '\0';
-}
-
-static unsigned char *atom_find_str_in_rom(struct atom_context *ctx, char *str, int start,
-					   int end, int maxlen)
-{
-	unsigned long str_off;
-	unsigned char *p_rom;
-	unsigned short str_len;
-
-	str_off = 0;
-	str_len = strnlen(str, maxlen);
-	p_rom = ctx->bios;
-
-	for (; start <= end; ++start) {
-		for (str_off = 0; str_off < str_len; ++str_off) {
-			if (str[str_off] != *(p_rom + start + str_off))
-				break;
-		}
-
-		if (str_off == str_len || str[str_off] == 0)
-			return p_rom + start;
-	}
-	return NULL;
-}
-
-static void atom_get_vbios_pn(struct atom_context *ctx)
-{
-	unsigned char *p_rom;
-	unsigned short off_to_vbios_str;
-	unsigned char *vbios_str;
-	int count;
-
-	off_to_vbios_str = 0;
-	p_rom = ctx->bios;
-
-	if (*(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS) != 0) {
-		off_to_vbios_str =
-			*(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_STRING_START);
-
-		vbios_str = (unsigned char *)(p_rom + off_to_vbios_str);
-	} else {
-		vbios_str = p_rom + OFFSET_TO_VBIOS_PART_NUMBER;
-	}
-
-	if (*vbios_str == 0) {
-		vbios_str = atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 64);
-		if (vbios_str == NULL)
-			vbios_str += sizeof(BIOS_ATOM_PREFIX) - 1;
-	}
-	if (vbios_str != NULL && *vbios_str == 0)
-		vbios_str++;
-
-	if (vbios_str != NULL) {
-		count = 0;
-		while ((count < BIOS_STRING_LENGTH) && vbios_str[count] >= ' ' &&
-		       vbios_str[count] <= 'z') {
-			ctx->vbios_pn[count] = vbios_str[count];
-			count++;
-		}
-
-		ctx->vbios_pn[count] = 0;
-	}
-}
-
 struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 {
 	int base;
 	struct atom_context *ctx =
 	    kzalloc(sizeof(struct atom_context), GFP_KERNEL);
 	char *str;
-	struct _ATOM_ROM_HEADER *atom_rom_header;
-	struct _ATOM_MASTER_DATA_TABLE *master_table;
-	struct _ATOM_FIRMWARE_INFO *atom_fw_info;
 	u16 idx;
 
 	if (!ctx)
@@ -1495,22 +1353,6 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 		strlcpy(ctx->vbios_version, str, sizeof(ctx->vbios_version));
 	}
 
-	atom_rom_header = (struct _ATOM_ROM_HEADER *)CSTR(base);
-	ctx->sub_dev_id = atom_rom_header->usSubsystemVendorID;
-	ctx->sub_ved_id = atom_rom_header->usSubsystemID;
-	if (atom_rom_header->usMasterDataTableOffset != 0) {
-		master_table = (struct _ATOM_MASTER_DATA_TABLE *)
-				CSTR(atom_rom_header->usMasterDataTableOffset);
-		if (master_table->ListOfDataTables.FirmwareInfo != 0) {
-			atom_fw_info = (struct _ATOM_FIRMWARE_INFO *)
-					CSTR(master_table->ListOfDataTables.FirmwareInfo);
-			ctx->version = atom_fw_info->ulFirmwareRevision;
-		}
-	}
-
-	atom_get_vbios_name(ctx);
-	atom_get_vbios_pn(ctx);
-	atom_get_vbios_date(ctx);
 
 	return ctx;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
index c729f7ceba4f..d279759cab47 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.h
+++ b/drivers/gpu/drm/amd/amdgpu/atom.h
@@ -112,10 +112,6 @@ struct drm_device;
 #define ATOM_IO_SYSIO		2
 #define ATOM_IO_IIO		0x80
 
-#define STRLEN_NORMAL		32
-#define STRLEN_LONG		64
-#define STRLEN_VERYLONG		254
-
 struct card_info {
 	struct drm_device *dev;
 	void (* reg_write)(struct card_info *, uint32_t, uint32_t);   /*  filled by driver */
@@ -144,13 +140,6 @@ struct atom_context {
 	uint32_t *scratch;
 	int scratch_size_bytes;
 	char vbios_version[20];
-
-	uint8_t name[STRLEN_LONG];
-	uint8_t vbios_pn[STRLEN_LONG];
-	uint32_t version;
-	uint8_t date[STRLEN_NORMAL];
-	uint32_t sub_dev_id;
-	uint32_t sub_ved_id;
 };
 
 extern int amdgpu_atom_debug;
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 14d0d7d58255..275468e4be60 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -197,8 +197,6 @@ enum atom_dp_vs_preemph_def{
   DP_VS_LEVEL0_PREEMPH_LEVEL3 = 0x18,
 };
 
-#define BIOS_ATOM_PREFIX   "ATOMBIOS"
-#define BIOS_STRING_LENGTH 43
 
 /*
 enum atom_string_def{
@@ -217,8 +215,6 @@ enum atombios_image_offset{
   MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      = 20,  /*including the terminator 0x0!*/
   OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   = 0x2f,
   OFFSET_TO_GET_ATOMBIOS_STRING_START        = 0x6e,
-  OFFSET_TO_VBIOS_PART_NUMBER                = 0x80,
-  OFFSET_TO_VBIOS_DATE                       = 0x50,
 };
 
 /****************************************************************************   
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 2d9e84658bbc..9169df7fadee 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -756,8 +756,6 @@ struct drm_amdgpu_cs_chunk_data {
 	#define AMDGPU_INFO_VBIOS_SIZE		0x1
 	/* Subquery id: Query vbios image */
 	#define AMDGPU_INFO_VBIOS_IMAGE		0x2
-	/* Subquery id: Query vbios info */
-	#define AMDGPU_INFO_VBIOS_INFO		0x3
 /* Query UVD handles */
 #define AMDGPU_INFO_NUM_HANDLES			0x1C
 /* Query sensor related information */
@@ -951,19 +949,6 @@ struct drm_amdgpu_info_firmware {
 	__u32 feature;
 };
 
-struct drm_amdgpu_info_vbios {
-	__u8 name[64];
-	__u32 dbdf;
-	__u8 vbios_pn[64];
-	__u32 version;
-	__u8 date[32];
-	__u64 serial;
-	__u32 dev_id;
-	__u32 rev_id;
-	__u32 sub_dev_id;
-	__u32 sub_ved_id;
-};
-
 #define AMDGPU_VRAM_TYPE_UNKNOWN 0
 #define AMDGPU_VRAM_TYPE_GDDR1 1
 #define AMDGPU_VRAM_TYPE_DDR2  2
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
