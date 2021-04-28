Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D835C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 08:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4151613BD
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 08:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4151613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5543B6EAC3;
	Wed, 28 Apr 2021 08:18:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD85E6EAC3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 08:18:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxCBIKVmj/5KrMe6PUiJSnLELz3weh3aBsA5bWTKTbszpKzBHmnpMP52HwZtHzDayVLUh3F3KiN+z6vPJaJfs+ylxYekWJE58SBljiFpF9c5/+K77eKG4wxj5c4D7XZuZ3Kx0r83RsX5MPAPpN6pkQ+b96ExqT7YpYIBBgyKPqBBXcqw0qdYR64rYD9nFNW4qASzvFsA/9cFPunnj/IKgf5p7I8thNBTOgPwQ9ewy83IHBQbzC3IerDcUgXxcyXDbugX+WOLabOaeM9DK1vEUOybsS0AiHolE3NTFBMmeFZkfCfKOl7FcQPHYgF7KGcyURbuoYnEhDqpgJzjWpuCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phKI8MogLqvTNwrYaQLU7IsKsTsciJk8fgg9KsZB+Fo=;
 b=TFok9PRuQgZ74/sfNwnU/tr9O4tt1Fo2ZetdmABlZEKeI/Towwq1g70FaCdrE6oIy1Ul8LeKz8q4D4u2732XB/XKABMCz5V5rRHCMRfyBlZXfqAqpph+owNvuc9xqcZrWKZCFaffija2R4vM4wDpS+ta8IKuvamUBCUYNBOdaof45VkUAup2oMD4s4kLVGBCr58wVNQZqr/nDmyUBtBHXa+XvhikCeIP9YBXQOdds0w+giL8Rld0Fl6v7sNmdlVwewHy/+5ZJMKFMirdD7smY1CDDGT7Jo8/0jZ+dJywlB5YwtsSmUuQJ3q7D2Nk9bGLUTygZ7qwwmXoDCxGDB4jKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phKI8MogLqvTNwrYaQLU7IsKsTsciJk8fgg9KsZB+Fo=;
 b=kyoILtunuO6dzVaIhVi9Su7IkfURsZZeRXdC63/Hl6OY+bNqmcG0iAchlZ8YjN9bmvpA+ityzgxGDN9Cu6rQzBzNskRhql0G2Vy3kt9F/H551E4rUy+1Sy1ThbNdaCuWSAEdFYQdsJjwZ5HYnQYPb3nPe2+Tvk/zsQbNb28kx34=
Received: from MW4PR04CA0050.namprd04.prod.outlook.com (2603:10b6:303:6a::25)
 by DM6PR12MB3227.namprd12.prod.outlook.com (2603:10b6:5:18d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 08:18:41 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::d3) by MW4PR04CA0050.outlook.office365.com
 (2603:10b6:303:6a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Wed, 28 Apr 2021 08:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 28 Apr 2021 08:18:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 28 Apr
 2021 03:18:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 28 Apr
 2021 03:18:39 -0500
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 28 Apr 2021 03:18:38 -0500
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Date: Wed, 28 Apr 2021 16:18:28 +0800
Message-ID: <20210428081828.10610-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55c42560-d803-414c-38f6-08d90a1e3b32
X-MS-TrafficTypeDiagnostic: DM6PR12MB3227:
X-Microsoft-Antispam-PRVS: <DM6PR12MB322768EE98228349AF49F155F8409@DM6PR12MB3227.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0W4lusKlRaEzFvNvvkEPyrAXuOGp8cWZXHKWvlkee0KI3rZF9dcQXouxSqcQaSJC95N6jVdx3ofWv6Sk4iiPq3jmMTJ4LNottd/mLq22AtAenxLSzk3Sd3TfezBviTcn/0lrJ1UIvwLQZjZh9YB9eKZTAMw2CKAZ7C4GBg8wOD+9JSUuOLp8qxfK/SIkCSg4aTE+dAo3Vz0f27QnEGuW6bNCwqKaZ8yCYU7IsD2t+eWIfhLc4M1hosl3Dc2fMREnKRS36dt5mFmCYlppZKd1tsmFW7pEjVtt7DR0m+je/+HWuV+sYvGfloQFHZ6ExE7CcVbHiBYqAXT8TJj7hqNf50fPbH+wD6Kpw0381fKFf8jLRG/Xa3PvE0IVbK3Cj675lOSLaBImQGsYpEC2otM+4nfvuPZFJEl6Wo863G4YJ2fNbnT7iSsj5ZOvyVUSGCgT+J8uZRFfoYcWgvTkY5dAZa4luf0x5gbs1YKZf66aWXDviOeNShAep85g+jXha5vZyWLGGIYyON5PPqMd4JOxOu86Jd9QPJZUAkOCrRL87AAXKpnZIoLgv8hl6C5Tr8b7zYFpk6SOqGQHSZYXtO2iYnpqPzJF1HypJSLvGdbIW0PIdptvFTvClRjBGCKRRfd9uY9TbdablkicClqMFR6l2ZttCaYdnQgsoasb+AZXsaRNP5oLOT+RxLDcD16IpkC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966006)(36840700001)(336012)(82740400003)(426003)(86362001)(7696005)(2616005)(8936002)(47076005)(2906002)(8676002)(70206006)(4326008)(81166007)(6666004)(70586007)(316002)(6916009)(82310400003)(1076003)(26005)(5660300002)(54906003)(36756003)(83380400001)(356005)(36860700001)(186003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 08:18:40.6420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c42560-d803-414c-38f6-08d90a1e3b32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3227
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
Cc: Jiawei Gu <Jiawei.Gu@amd.com>, christian.koenig@amd.com,
 david.nieto@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add AMDGPU_INFO_VBIOS_INFO subquery id for detailed vbios info.

Provides a way for the user application to get the VBIOS
information without having to parse the binary.
It is useful for the user to be able to display in a simple way the VBIOS
version in their system if they happen to encounter an issue.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  19 +++
 drivers/gpu/drm/amd/amdgpu/atom.c          | 158 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/atom.h          |  11 ++
 drivers/gpu/drm/amd/include/atomfirmware.h |  16 ++-
 include/uapi/drm/amdgpu_drm.h              |  15 ++
 5 files changed, 213 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 39ee88d29cca..a20b016b05ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -861,6 +861,25 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 					    min((size_t)size, (size_t)(bios_size - bios_offset)))
 					? -EFAULT : 0;
 		}
+		case AMDGPU_INFO_VBIOS_INFO: {
+			struct drm_amdgpu_info_vbios vbios_info = {};
+			struct atom_context *atom_context;
+
+			atom_context = adev->mode_info.atom_context;
+			memcpy(vbios_info.name, atom_context->name, sizeof(atom_context->name));
+			vbios_info.dbdf = PCI_DEVID(adev->pdev->bus->number, adev->pdev->devfn);
+			memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_context->vbios_pn));
+			vbios_info.version = atom_context->version;
+			memcpy(vbios_info.date, atom_context->date, sizeof(atom_context->date));
+			memcpy(vbios_info.serial, adev->serial, sizeof(adev->serial));
+			vbios_info.dev_id = adev->pdev->device;
+			vbios_info.rev_id = adev->pdev->revision;
+			vbios_info.sub_dev_id = atom_context->sub_dev_id;
+			vbios_info.sub_ved_id = atom_context->sub_ved_id;
+
+			return copy_to_user(out, &vbios_info,
+						min((size_t)size, sizeof(vbios_info))) ? -EFAULT : 0;
+		}
 		default:
 			DRM_DEBUG_KMS("Invalid request %d\n",
 					info->vbios_info.type);
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 3dcb8b32f48b..0e2f0ea13b40 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -31,6 +31,7 @@
 
 #define ATOM_DEBUG
 
+#include "atomfirmware.h"
 #include "atom.h"
 #include "atom-names.h"
 #include "atom-bits.h"
@@ -1299,12 +1300,153 @@ static void atom_index_iio(struct atom_context *ctx, int base)
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
@@ -1353,6 +1495,22 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 		strlcpy(ctx->vbios_version, str, sizeof(ctx->vbios_version));
 	}
 
+	atom_rom_header = (struct _ATOM_ROM_HEADER *)CSTR(base);
+	ctx->sub_dev_id = atom_rom_header->usSubsystemVendorID;
+	ctx->sub_ved_id = atom_rom_header->usSubsystemID;
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
 
 	return ctx;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
index d279759cab47..c729f7ceba4f 100644
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
@@ -140,6 +144,13 @@ struct atom_context {
 	uint32_t *scratch;
 	int scratch_size_bytes;
 	char vbios_version[20];
+
+	uint8_t name[STRLEN_LONG];
+	uint8_t vbios_pn[STRLEN_LONG];
+	uint32_t version;
+	uint8_t date[STRLEN_NORMAL];
+	uint32_t sub_dev_id;
+	uint32_t sub_ved_id;
 };
 
 extern int amdgpu_atom_debug;
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index c77ed38c20fb..3a8e404099b0 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -197,6 +197,8 @@ enum atom_dp_vs_preemph_def{
   DP_VS_LEVEL0_PREEMPH_LEVEL3 = 0x18,
 };
 
+#define BIOS_ATOM_PREFIX   "ATOMBIOS"
+#define BIOS_STRING_LENGTH 43
 
 /*
 enum atom_string_def{
@@ -209,12 +211,14 @@ atom_bios_string          = "ATOM"
 #pragma pack(1)                          /* BIOS data must use byte aligment*/
 
 enum atombios_image_offset{
-OFFSET_TO_ATOM_ROM_HEADER_POINTER          =0x00000048,
-OFFSET_TO_ATOM_ROM_IMAGE_SIZE              =0x00000002,
-OFFSET_TO_ATOMBIOS_ASIC_BUS_MEM_TYPE       =0x94,
-MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      =20,  /*including the terminator 0x0!*/
-OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   =0x2f,
-OFFSET_TO_GET_ATOMBIOS_STRING_START        =0x6e,
+  OFFSET_TO_ATOM_ROM_HEADER_POINTER          = 0x00000048,
+  OFFSET_TO_ATOM_ROM_IMAGE_SIZE              = 0x00000002,
+  OFFSET_TO_ATOMBIOS_ASIC_BUS_MEM_TYPE       = 0x94,
+  MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      = 20,  /*including the terminator 0x0!*/
+  OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   = 0x2f,
+  OFFSET_TO_GET_ATOMBIOS_STRING_START        = 0x6e,
+  OFFSET_TO_VBIOS_PART_NUMBER                = 0x80,
+  OFFSET_TO_VBIOS_DATE                       = 0x50,
 };
 
 /****************************************************************************   
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 8b832f7458f2..77980445d486 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -758,6 +758,8 @@ struct drm_amdgpu_cs_chunk_data {
 	#define AMDGPU_INFO_VBIOS_SIZE		0x1
 	/* Subquery id: Query vbios image */
 	#define AMDGPU_INFO_VBIOS_IMAGE		0x2
+	/* Subquery id: Query vbios info */
+	#define AMDGPU_INFO_VBIOS_INFO		0x3
 /* Query UVD handles */
 #define AMDGPU_INFO_NUM_HANDLES			0x1C
 /* Query sensor related information */
@@ -951,6 +953,19 @@ struct drm_amdgpu_info_firmware {
 	__u32 feature;
 };
 
+struct drm_amdgpu_info_vbios {
+	__u8 name[64];
+	__u32 dbdf;
+	__u8 vbios_pn[64];
+	__u32 version;
+	__u8 date[32];
+	__u8 serial[16];
+	__u32 dev_id;
+	__u32 rev_id;
+	__u32 sub_dev_id;
+	__u32 sub_ved_id;
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
