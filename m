Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088BCC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 12:16:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA74E60FF1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 12:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA74E60FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECE366EB4A;
	Tue, 18 May 2021 12:16:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C66E6EB4A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 12:16:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkVOxJNu5rBZ3T8OptIuwXrJ9s3TF1cXOt2Ai//kv93REwhELqesKG4OLBAQTpwbdmKfDnBOMFlHkLbqDRMvbRSKPZYLhUHBPV+DjAATqNtZGlTqcgZffr1/UYwhmaCAKSCBNUccvZTQzXN6Uu3L6XSz8OCEkngox6Lbh+DjnBWEuT8/a9mvxwQj9t6oE3WqqQV09ns0e9cWUHIN3qvtZMIGd/in6BQ824qaox8cF5/CGW0jM+kzCfsRVYOSzjSgm/6eDELbe2Ze0Hhf+KoM1d2emAwf87T1EUl2YSeJ2k6QbqrPsBmpTMfAM6IWDgBsjmNa4AJQL0GoyidYKm11Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62xSFxrk7irNboA6l0sdRnPshCN1vH83KhQ7b25WxaA=;
 b=iSxiPeadrnvkWRDq7tUQRnPkdR33tSvLopxehqIlM7us6ak0xqULzQZr1TLaVCQY3rS6Co+48qi6jeJVsgiRUlRbCgaYqGRxq59og3ralAdRTO8TaExQvLSdRQ8OMAFBrz6DrqARPw+HOGzz6usv6RrzTw5BqOULjNoqzK/aX4THW/wtgm/sFAoby8MixUjX5zmF4cDJ/qL3Op1G0BbPoEIVT+QlpT1uDlQg9sPSPWq3c6ajXSGRXyqY+DB5ZgvVv+U5r27RIVVWDi8jjBa/l4IlfzGLeRi3Yl+laAkL+QnEnj6tt6LIKvoUms5yTHVZD9ne1H8zwUjT8b29Avtydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62xSFxrk7irNboA6l0sdRnPshCN1vH83KhQ7b25WxaA=;
 b=t8C5WLtKwcMtM3Sikwq2Fr+Br+KGNsDvE3ZLraN/zS++kNs7erF0gnvXHueVWstNnDSfGXDPvQVvjp2dTgIIAr5h7UdBNIUlNAAt4/EghHd7VLLMlMyRDu5q/rjZMEPekZeI3wecibPqUPIBrNN444DEdjLaq7feqrP7YV/3rC0=
Received: from DS7PR03CA0084.namprd03.prod.outlook.com (2603:10b6:5:3bb::29)
 by BN8PR12MB3636.namprd12.prod.outlook.com (2603:10b6:408:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 12:16:36 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::72) by DS7PR03CA0084.outlook.office365.com
 (2603:10b6:5:3bb::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 18 May 2021 12:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 12:16:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 18 May
 2021 07:16:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 18 May
 2021 07:16:35 -0500
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 18 May 2021 07:16:33 -0500
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <david.nieto@amd.com>, <maraeo@gmail.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Date: Tue, 18 May 2021 20:16:28 +0800
Message-ID: <20210518121628.9811-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44932557-8b7d-42c3-d309-08d919f6c83d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3636:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3636698DE3D2796EA1C1FECDF82C9@BN8PR12MB3636.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IyFV7QCkb0VbU1ZxalksSgwffQXUrcjIKODQMGF3URqXaYuVdvUWV/gT6V7zgYQReFKPx7uZ50PPrbBO3b8sN0nr1AR2VEjwPXFoiWEyqRNHfgObh3IdxDN6Mam+UofbD/gaRbnxrjhBAlSKuGUlHBqEnOs56Yr1Sq2F1+d3lyM74EGHI8h7dGy3O57xrfJ90zEqPc5ql1nLPtIqBGzXtTZ0cDmrm1EZUlZzgLr663sCpPOM2TZNF2QMF8eD/sZr9OIKvv6luUKu25Qb0CgimYUgQ+PX4NlSkOmR0ks/njv1naAdxnUypoZW3vMJ3dwYqBH/LtZeJmkuHgLO48JRqAzjrRYyGLhNy5mNE8qkEt5m7syiFBplMQFaKpyDjApbkt1GhGXy4ZjIZa6Py/k/CTZ0ALlFOZcMrvf8Ep8vQjr3YMLGoXvxrk4cjDtFNpjtF+aSs5jbZLHML43uNGXHouRJ6NYyCS8D+j5pajQqaz6HUpKG8jtRYneobaDKUwJCI60YHHCMnTcrDlOc6m3zJO6ckVFNLHNI4UOW5cVNCt7bHX4jlG1Ny3RZzawS14B1rpdiuXP+6xLJf38xpeWSD0YsCl69WAff576Ni7Lw3si3at6c8r3cM4FIk1NWPdYB/dgtLg9YBH/9dF8B0Ogbyxhs7PemedsKkrcA3Vdw7NoQeNCSC2LXPkhEa5XWwLxJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(136003)(376002)(396003)(46966006)(36840700001)(5660300002)(336012)(356005)(81166007)(478600001)(47076005)(426003)(6666004)(7696005)(82740400003)(186003)(86362001)(26005)(82310400003)(83380400001)(4326008)(2906002)(36860700001)(110136005)(54906003)(2616005)(36756003)(8936002)(1076003)(70586007)(6636002)(70206006)(316002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 12:16:36.0790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44932557-8b7d-42c3-d309-08d919f6c83d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3636
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

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  15 ++
 drivers/gpu/drm/amd/amdgpu/atom.c          | 172 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/atom.h          |  10 ++
 drivers/gpu/drm/amd/include/atomfirmware.h |   5 +
 include/uapi/drm/amdgpu_drm.h              |  10 ++
 5 files changed, 212 insertions(+)

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
index 9169df7fadee..155fd9918b4d 100644
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
@@ -949,6 +951,14 @@ struct drm_amdgpu_info_firmware {
 	__u32 feature;
 };
 
+struct drm_amdgpu_info_vbios {
+	__u8 name[64];
+	__u8 vbios_pn[64];
+	__u32 version;
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
