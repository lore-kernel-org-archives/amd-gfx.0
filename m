Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF7CC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 02:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A306101D
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 02:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A306101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A4756E3E5;
	Thu, 20 May 2021 02:59:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 345E46E3E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 02:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlQ1uLlgolgYOV1Vm9CbSs2GvtNRO+Vd5S9A+0JOpEE+cu/qWD7EFdDZBaj4u/QfHpo4DibDj4tB8ksVDPuMsdwklGWE7amjp1Bzh+tc+u8sckzwtE7ml1coWGd7iM20/ZVwWAVvfvQ9OIppPXpk/J0Z1p8jKzLGVDB1Py3jDveOL+hFhWe/j2MsUyMhii350BbKF3Rg4xVrmPnYsu+inV0ZKGXAd2cO2I+xvxo8FY2kx7i8Co0UlILLoDLZr47t6fKyS/XMK3L/QglNx1imsCRLmq+Qt2ZkCcwdmGO1T9U6Mikr+B873gl0j6L62Lggx6VQOv5EKZPxXP3h9Kv2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RW6W7DtEZpd9YlDLnNMAtM1SgBqVqB5V+b4OWXwJRY=;
 b=j2wWiwSMKa2l9Mg/GudXEfoCAamm+JQLQgjGNhkHf3ouxeclDtU/sOEtre6xICLQkGEzn8AeytbUFWSPeNSjefFm8rYKRMkG1GYaNi8eq3/2TvdeVtxB4e8X9itmeFcTcXXGY40EJguuuElX6rsGgtlhYsntOSLq5gs/Vvut04ojjo6yJo8HfhYGqfRpDS15r+Ev/vh/Ey7Yj6BSdFDiYNvQN/WTrv0G6a36y3HDijVhZ+X+hcTc1BIHmmiE39gevrJxWdMGPJZNs+P8DuI98Ip5PITKNapuG6iEVj8iS6cqS83xo2sd/l51QTvCgEsJZisjvq0+cjuzVSLHpn9rzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RW6W7DtEZpd9YlDLnNMAtM1SgBqVqB5V+b4OWXwJRY=;
 b=XHTHV3FQz5EcxX7eoW7tFeXDlVuhdRy3dwaF+oHyuGGw6XLh4fM7dN0M1kmAR6kEcN/Njy9VB7PHSsIJwMv4dJmJCF+QcvsLIBgrTyVlqgQoSID50fJ6uJFlQ5doFzZ3V33qoSZnAQ22M5AzpZgaIEjK1YvSaa/XtV16D/4IgD0=
Received: from MW4PR03CA0205.namprd03.prod.outlook.com (2603:10b6:303:b8::30)
 by MWHPR12MB1198.namprd12.prod.outlook.com (2603:10b6:300:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 20 May
 2021 02:59:00 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::d1) by MW4PR03CA0205.outlook.office365.com
 (2603:10b6:303:b8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend
 Transport; Thu, 20 May 2021 02:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Thu, 20 May 2021 02:58:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 19 May
 2021 21:58:58 -0500
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 19 May 2021 21:58:56 -0500
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <david.nieto@amd.com>, <maraeo@gmail.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Date: Thu, 20 May 2021 10:58:46 +0800
Message-ID: <20210520025846.10789-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff3d9345-e57d-4e45-bd42-08d91b3b3789
X-MS-TrafficTypeDiagnostic: MWHPR12MB1198:
X-Microsoft-Antispam-PRVS: <MWHPR12MB11989E2164372C64FC528623F82A9@MWHPR12MB1198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgrZudlPxTPlFfioUXXRx1o1Q/kPotZyMSZcLIxwZgH4iVyj0H+DTBRPkqgat39YnR1vqvNuk2sNQWynO7XvMQZ4MolC0GQlJ1XSgx2L7tLSOWlpVS1N+bKQJtPBhQoasgjhaUHqn3zSC22iHrPwv1l5EXgun1Li/2shA4XujNRBqA/hYtioDXGvTcD4jzVl6gaubYilY13PRCQMcD0zXg0ryu8r8KEJMPQ1alucLnE49CI5ux+OGaXLZnibUXObAosQYuEo4tEIcDmhvQRIFFDbTyh8QYBszF7bB/6aknkEcDCRv+lOqnYXf448ZAxYwVGidN3GQzGbdipb1tIQ1XwK4JtL+YbEE1jcyMS60eegoBfT7EyGrQN0VbOBinibed8y7cNqPnCGXSb9eDzVwJGhwpZrPA498E9H1UXA+mcVvTL033djuYzWswiMJ347ugZ3qlJXZjrTfcMiQ7Ma3z3PyKf4qRY2pC6GslbWIDN34EiTQE9FhC24OvFZEFAXsBSVPdXpapmiRD0mpkvRarYr4KE/8VY3r7SF05+i0XMX/3/NYanq/b/2iBY0ZbFXOPTL8kwvjkFq/KERpIiBwkEl18KG9LS0L04litFanztisHEPUQfJ8get3u8iOEizuPcdVn+Xmmf5Y73lIsr5D/BQxCoq7uLmPrJo1+vE6co4/ytODiCTac8VVzl1nkIU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(8676002)(70206006)(26005)(70586007)(86362001)(82310400003)(6636002)(5660300002)(8936002)(82740400003)(4326008)(83380400001)(36756003)(356005)(6666004)(81166007)(54906003)(478600001)(47076005)(36860700001)(316002)(2906002)(110136005)(186003)(7696005)(426003)(2616005)(336012)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 02:58:59.6860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3d9345-e57d-4e45-bd42-08d91b3b3789
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1198
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

Add AMDGPU_INFO_VBIOS_INFO subquery id for detailed vbios info.

Provides a way for the user application to get the VBIOS
information without having to parse the binary.
It is useful for the user to be able to display in a simple way the VBIOS
version in their system if they happen to encounter an issue.

V2:
Use numeric serial.
Parse and expose vbios version string.

V3:
Remove redundant data in drm_amdgpu_info_vbios struct.

V4:
64 bit alignment in drm_amdgpu_info_vbios.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  15 ++
 drivers/gpu/drm/amd/amdgpu/atom.c          | 172 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/atom.h          |  10 ++
 drivers/gpu/drm/amd/include/atomfirmware.h |   5 +
 include/uapi/drm/amdgpu_drm.h              |  11 ++
 5 files changed, 213 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8d12e474745a..524e4fe5efe8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -861,6 +861,21 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 					    min((size_t)size, (size_t)(bios_size - bios_offset)))
 					? -EFAULT : 0;
 		}
+		case AMDGPU_INFO_VBIOS_INFO: {
+			struct drm_amdgpu_info_vbios vbios_info = {};
+			struct atom_context *atom_context;
+
+			atom_context = adev->mode_info.atom_context;
+			memcpy(vbios_info.name, atom_context->name, sizeof(atom_context->name));
+			memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_context->vbios_pn));
+			vbios_info.version = atom_context->version;
+			memcpy(vbios_info.vbios_ver_str, atom_context->vbios_ver_str,
+						sizeof(atom_context->vbios_ver_str));
+			memcpy(vbios_info.date, atom_context->date, sizeof(atom_context->date));
+
+			return copy_to_user(out, &vbios_info,
+						min((size_t)size, sizeof(vbios_info))) ? -EFAULT : 0;
+		}
 		default:
 			DRM_DEBUG_KMS("Invalid request %d\n",
 					info->vbios_info.type);
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 3dcb8b32f48b..6fa2229b7229 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -31,6 +31,7 @@
 
 #define ATOM_DEBUG
 
+#include "atomfirmware.h"
 #include "atom.h"
 #include "atom-names.h"
 #include "atom-bits.h"
@@ -1299,12 +1300,168 @@ static void atom_index_iio(struct atom_context *ctx, int base)
 	}
 }
 
+static void atom_get_vbios_name(struct atom_context *ctx)
+{
+	unsigned char *p_rom;
+	unsigned char str_num;
+	unsigned short off_to_vbios_str;
+	unsigned char *c_ptr;
+	int name_size;
+	int i;
+
+	const char *na = "--N/A--";
+	char *back;
+
+	p_rom = ctx->bios;
+
+	str_num = *(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS);
+	if (str_num != 0) {
+		off_to_vbios_str =
+			*(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_STRING_START);
+
+		c_ptr = (unsigned char *)(p_rom + off_to_vbios_str);
+	} else {
+		/* do not know where to find name */
+		memcpy(ctx->name, na, 7);
+		ctx->name[7] = 0;
+		return;
+	}
+
+	/*
+	 * skip the atombios strings, usually 4
+	 * 1st is P/N, 2nd is ASIC, 3rd is PCI type, 4th is Memory type
+	 */
+	for (i = 0; i < str_num; i++) {
+		while (*c_ptr != 0)
+			c_ptr++;
+		c_ptr++;
+	}
+
+	/* skip the following 2 chars: 0x0D 0x0A */
+	c_ptr += 2;
+
+	name_size = strnlen(c_ptr, STRLEN_LONG - 1);
+	memcpy(ctx->name, c_ptr, name_size);
+	back = ctx->name + name_size;
+	while ((*--back) == ' ')
+		;
+	*(back + 1) = '\0';
+}
+
+static void atom_get_vbios_date(struct atom_context *ctx)
+{
+	unsigned char *p_rom;
+	unsigned char *date_in_rom;
+
+	p_rom = ctx->bios;
+
+	date_in_rom = p_rom + OFFSET_TO_VBIOS_DATE;
+
+	ctx->date[0] = '2';
+	ctx->date[1] = '0';
+	ctx->date[2] = date_in_rom[6];
+	ctx->date[3] = date_in_rom[7];
+	ctx->date[4] = '/';
+	ctx->date[5] = date_in_rom[0];
+	ctx->date[6] = date_in_rom[1];
+	ctx->date[7] = '/';
+	ctx->date[8] = date_in_rom[3];
+	ctx->date[9] = date_in_rom[4];
+	ctx->date[10] = ' ';
+	ctx->date[11] = date_in_rom[9];
+	ctx->date[12] = date_in_rom[10];
+	ctx->date[13] = date_in_rom[11];
+	ctx->date[14] = date_in_rom[12];
+	ctx->date[15] = date_in_rom[13];
+	ctx->date[16] = '\0';
+}
+
+static unsigned char *atom_find_str_in_rom(struct atom_context *ctx, char *str, int start,
+					   int end, int maxlen)
+{
+	unsigned long str_off;
+	unsigned char *p_rom;
+	unsigned short str_len;
+
+	str_off = 0;
+	str_len = strnlen(str, maxlen);
+	p_rom = ctx->bios;
+
+	for (; start <= end; ++start) {
+		for (str_off = 0; str_off < str_len; ++str_off) {
+			if (str[str_off] != *(p_rom + start + str_off))
+				break;
+		}
+
+		if (str_off == str_len || str[str_off] == 0)
+			return p_rom + start;
+	}
+	return NULL;
+}
+
+static void atom_get_vbios_pn(struct atom_context *ctx)
+{
+	unsigned char *p_rom;
+	unsigned short off_to_vbios_str;
+	unsigned char *vbios_str;
+	int count;
+
+	off_to_vbios_str = 0;
+	p_rom = ctx->bios;
+
+	if (*(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS) != 0) {
+		off_to_vbios_str =
+			*(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_STRING_START);
+
+		vbios_str = (unsigned char *)(p_rom + off_to_vbios_str);
+	} else {
+		vbios_str = p_rom + OFFSET_TO_VBIOS_PART_NUMBER;
+	}
+
+	if (*vbios_str == 0) {
+		vbios_str = atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 64);
+		if (vbios_str == NULL)
+			vbios_str += sizeof(BIOS_ATOM_PREFIX) - 1;
+	}
+	if (vbios_str != NULL && *vbios_str == 0)
+		vbios_str++;
+
+	if (vbios_str != NULL) {
+		count = 0;
+		while ((count < BIOS_STRING_LENGTH) && vbios_str[count] >= ' ' &&
+		       vbios_str[count] <= 'z') {
+			ctx->vbios_pn[count] = vbios_str[count];
+			count++;
+		}
+
+		ctx->vbios_pn[count] = 0;
+	}
+}
+
+static void atom_get_vbios_version(struct atom_context *ctx)
+{
+	unsigned char *vbios_ver;
+
+	/* find anchor ATOMBIOSBK-AMD */
+	vbios_ver = atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, 3, 1024, 64);
+	if (vbios_ver != NULL) {
+		/* skip ATOMBIOSBK-AMD VER */
+		vbios_ver += 18;
+		memcpy(ctx->vbios_ver_str, vbios_ver, STRLEN_NORMAL);
+	} else {
+		ctx->vbios_ver_str[0] = '\0';
+	}
+}
+
 struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 {
 	int base;
 	struct atom_context *ctx =
 	    kzalloc(sizeof(struct atom_context), GFP_KERNEL);
 	char *str;
+	struct _ATOM_ROM_HEADER *atom_rom_header;
+	struct _ATOM_MASTER_DATA_TABLE *master_table;
+	struct _ATOM_FIRMWARE_INFO *atom_fw_info;
 	u16 idx;
 
 	if (!ctx)
@@ -1353,6 +1510,21 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 		strlcpy(ctx->vbios_version, str, sizeof(ctx->vbios_version));
 	}
 
+	atom_rom_header = (struct _ATOM_ROM_HEADER *)CSTR(base);
+	if (atom_rom_header->usMasterDataTableOffset != 0) {
+		master_table = (struct _ATOM_MASTER_DATA_TABLE *)
+				CSTR(atom_rom_header->usMasterDataTableOffset);
+		if (master_table->ListOfDataTables.FirmwareInfo != 0) {
+			atom_fw_info = (struct _ATOM_FIRMWARE_INFO *)
+					CSTR(master_table->ListOfDataTables.FirmwareInfo);
+			ctx->version = atom_fw_info->ulFirmwareRevision;
+		}
+	}
+
+	atom_get_vbios_name(ctx);
+	atom_get_vbios_pn(ctx);
+	atom_get_vbios_date(ctx);
+	atom_get_vbios_version(ctx);
 
 	return ctx;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
index d279759cab47..0c1839824520 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.h
+++ b/drivers/gpu/drm/amd/amdgpu/atom.h
@@ -112,6 +112,10 @@ struct drm_device;
 #define ATOM_IO_SYSIO		2
 #define ATOM_IO_IIO		0x80
 
+#define STRLEN_NORMAL		32
+#define STRLEN_LONG		64
+#define STRLEN_VERYLONG		254
+
 struct card_info {
 	struct drm_device *dev;
 	void (* reg_write)(struct card_info *, uint32_t, uint32_t);   /*  filled by driver */
@@ -140,6 +144,12 @@ struct atom_context {
 	uint32_t *scratch;
 	int scratch_size_bytes;
 	char vbios_version[20];
+
+	uint8_t name[STRLEN_LONG];
+	uint8_t vbios_pn[STRLEN_LONG];
+	uint32_t version;
+	uint8_t vbios_ver_str[STRLEN_NORMAL];
+	uint8_t date[STRLEN_NORMAL];
 };
 
 extern int amdgpu_atom_debug;
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 275468e4be60..28deecc2f990 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -197,6 +197,9 @@ enum atom_dp_vs_preemph_def{
   DP_VS_LEVEL0_PREEMPH_LEVEL3 = 0x18,
 };
 
+#define BIOS_ATOM_PREFIX   "ATOMBIOS"
+#define BIOS_VERSION_PREFIX  "ATOMBIOSBK-AMD"
+#define BIOS_STRING_LENGTH 43
 
 /*
 enum atom_string_def{
@@ -215,6 +218,8 @@ enum atombios_image_offset{
   MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      = 20,  /*including the terminator 0x0!*/
   OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   = 0x2f,
   OFFSET_TO_GET_ATOMBIOS_STRING_START        = 0x6e,
+  OFFSET_TO_VBIOS_PART_NUMBER                = 0x80,
+  OFFSET_TO_VBIOS_DATE                       = 0x50,
 };
 
 /****************************************************************************   
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9169df7fadee..90bcd64c0147 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -756,6 +756,8 @@ struct drm_amdgpu_cs_chunk_data {
 	#define AMDGPU_INFO_VBIOS_SIZE		0x1
 	/* Subquery id: Query vbios image */
 	#define AMDGPU_INFO_VBIOS_IMAGE		0x2
+	/* Subquery id: Query vbios info */
+	#define AMDGPU_INFO_VBIOS_INFO		0x3
 /* Query UVD handles */
 #define AMDGPU_INFO_NUM_HANDLES			0x1C
 /* Query sensor related information */
@@ -949,6 +951,15 @@ struct drm_amdgpu_info_firmware {
 	__u32 feature;
 };
 
+struct drm_amdgpu_info_vbios {
+	__u8 name[64];
+	__u8 vbios_pn[64];
+	__u32 version;
+	__u32 pad;
+	__u8 vbios_ver_str[32];
+	__u8 date[32];
+};
+
 #define AMDGPU_VRAM_TYPE_UNKNOWN 0
 #define AMDGPU_VRAM_TYPE_GDDR1 1
 #define AMDGPU_VRAM_TYPE_DDR2  2
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
