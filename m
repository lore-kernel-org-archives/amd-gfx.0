Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204EAC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 10:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7A860FF1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 10:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7A860FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 454CE6E048;
	Mon, 17 May 2021 10:22:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 175BD6E048
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 10:22:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+00BsJRpFvMXMvNyvouMUIWdOGcBnjpGfIyrNlXI/s0E6wzV2iGySYDd5qxwMp/P5pxk1CN+Ell1jA2W1UI1ZECt82d3xnyGEYvNYeJBG6B0VmNtzFjFuttrHwWF2jIAxyDLPoKUL9amuLgxFXBxj0tRr0Yx9zCWT6A/z0lfKo1sC8cxlSDXtkdR6DcLTke3gJOmoQ4Y0tOCDoauPjrbil+o2noHl2IdlcfOmnJmXprfUl6/y/goayClsGJ+SzU47ZH6bRHnlOOyfETj1kibw8Q/nW8jaZRx8yRxLCaXgCUb1GJtX/bNv2fJ9b4kmvatULvzN9G95cbRwtV6G07Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pV1IUG4JPBoNrK9ORmX+cZ+YRa3Zm6a602ljkqFeKqI=;
 b=aP6Yucf1ajMR7zhbUQ0L6zwI0pNSHznEZi4HrB+CmJYoUIzyFtKXMnBV+h+pUAJD1Mb0tFMUyRsaOUswwFhgKkKdhBz0ct/JUx1OFw+uaXLe9Lr63pPEuvJCJObFfzFusbCC1pCvhNcvyNxFiYvocbAUy6caHcWJSmuYvtl6medgUD7LX0lIWDsltSVKy0UYmFsHdzDwBGHxgLweg2i3xsv0Yx41VlrPnaHj1naBx1O0hkqrOBXnwBT7AyzALVVIlE9iwmyLkCmyveEQ+PiwQSIbeWNJeJ1EpVIfr1sEwQV74iLlpFQOes8gn+fRKH7wlGDONf/SZ+CcbgSaJ26QxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pV1IUG4JPBoNrK9ORmX+cZ+YRa3Zm6a602ljkqFeKqI=;
 b=W3gLWhc6QQswNHvwKYf/DUtI+IU9Vh42y9v4t5P71bKRb1z0aXXUruFZFYyEVMMjvjSi6WUegfnGk5fRdMeU8xaKzJxyEbzMKGjd/bDzu3W1QKnn/HJIsUil999xDaBaK+bqWFW5CYdeRUNiKREfmucRJSRDfm/y4CohUg5wzoU=
Received: from MW4PR03CA0078.namprd03.prod.outlook.com (2603:10b6:303:b6::23)
 by BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 10:22:11 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::bb) by MW4PR03CA0078.outlook.office365.com
 (2603:10b6:303:b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 10:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 10:22:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 05:22:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 05:22:09 -0500
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 17 May 2021 05:22:06 -0500
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <david.nieto@amd.com>, <maraeo@gmail.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add vbios version string
Date: Mon, 17 May 2021 18:21:55 +0800
Message-ID: <20210517102155.23753-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bc6868c-5e0e-4507-b7ae-08d9191da1b2
X-MS-TrafficTypeDiagnostic: BL0PR12MB4882:
X-Microsoft-Antispam-PRVS: <BL0PR12MB48824D4B27215274C27C3EAAF82D9@BL0PR12MB4882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K003qf+M2UbPyNxAxBMjTj/ldfjl/J5+UiRvsDZHvmixLc6aT/F6f/5nWSmEdAs0SUCzePU3BlEKUPZaSTUiD1Kcs12zoL1BCyqRm8+/9NOyHsfimxpKH60sOEeFh08I2ASxR2kFSSSaESlLRtBXbSMS1BTrhQBZ1Kq/ZVXdFGV1tv5ujIPk0lJGWzrABIWBKJ471gL/i9MFRNQm+Sr9TXh/fBRfu+rL9yruEyaCZ40DdN0TIgmaOjypkRnOM7C24VXago+76g7F16vYQ4hyuWwweTrg0Cyt4/Fr0Of3AwALeSFIoC1ZajTHaM9ux8pRVNQci/WoZaPCpmF3bsncKNct7478o4DoeICiqVtTZMmCkJVbsgJo1aW8C2l9Vh6kgBf1v0L9B7/T3PIZTFob5i1roglKamR+uZ30c/nXKw/pZOOMnNth+GqlnCOhwSb3kfp/B5pYRF0ogBEPf2EU+BiHutc8Jkoun+UwSugW8jhfEu+q5ktwLdvw44EjdaKxeZUgjnxmHB6H9XsxCAIp3efDuHfM5Mhee7Qe85FApL21W8g3PBXgjPXRRGXqrkQRDV/xcVv5YhWAGLG8IjzkGTf0qKEOl3e5Mh6XzDrt4+hcPPvtl5utkGRPgVctpciKwsvllaxTN3JXDvOA97npT9NDcOYvHUvJiF5cqUe2rCChmvnk1ErvqU7x4ilzWFsjKYzQk6zhhAOMNW6Nyj1bVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(46966006)(110136005)(82740400003)(1076003)(186003)(36756003)(86362001)(36860700001)(81166007)(336012)(356005)(8676002)(47076005)(26005)(316002)(2616005)(82310400003)(54906003)(6636002)(426003)(5660300002)(6666004)(8936002)(4326008)(70206006)(7696005)(70586007)(478600001)(2906002)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 10:22:10.5676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc6868c-5e0e-4507-b7ae-08d9191da1b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4882
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

Expose XXX.XXX.XXX.XXX.XXXXXX vbios version string in
AMDGPU_INFO_VBIOS_INFO ioctl

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 ++
 drivers/gpu/drm/amd/amdgpu/atom.c          | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/atom.h          |  1 +
 drivers/gpu/drm/amd/include/atomfirmware.h |  1 +
 include/uapi/drm/amdgpu_drm.h              |  1 +
 5 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index e1008a79b441..30e4fed3de22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -870,6 +870,8 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			vbios_info.dbdf = PCI_DEVID(adev->pdev->bus->number, adev->pdev->devfn);
 			memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_context->vbios_pn));
 			vbios_info.version = atom_context->version;
+			memcpy(vbios_info.vbios_ver_str, atom_context->vbios_ver_str,
+						sizeof(atom_context->vbios_ver_str));
 			memcpy(vbios_info.date, atom_context->date, sizeof(atom_context->date));
 			vbios_info.serial = adev->unique_id;
 			vbios_info.dev_id = adev->pdev->device;
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 0e2f0ea13b40..542b2c2414e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1438,6 +1438,21 @@ static void atom_get_vbios_pn(struct atom_context *ctx)
 	}
 }
 
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
@@ -1511,6 +1526,7 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 	atom_get_vbios_name(ctx);
 	atom_get_vbios_pn(ctx);
 	atom_get_vbios_date(ctx);
+	atom_get_vbios_version(ctx);
 
 	return ctx;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
index c729f7ceba4f..6463ce6e756d 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.h
+++ b/drivers/gpu/drm/amd/amdgpu/atom.h
@@ -148,6 +148,7 @@ struct atom_context {
 	uint8_t name[STRLEN_LONG];
 	uint8_t vbios_pn[STRLEN_LONG];
 	uint32_t version;
+	uint8_t vbios_ver_str[STRLEN_NORMAL];
 	uint8_t date[STRLEN_NORMAL];
 	uint32_t sub_dev_id;
 	uint32_t sub_ved_id;
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 14d0d7d58255..28deecc2f990 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -198,6 +198,7 @@ enum atom_dp_vs_preemph_def{
 };
 
 #define BIOS_ATOM_PREFIX   "ATOMBIOS"
+#define BIOS_VERSION_PREFIX  "ATOMBIOSBK-AMD"
 #define BIOS_STRING_LENGTH 43
 
 /*
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 2d9e84658bbc..e0f98ca9a755 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -956,6 +956,7 @@ struct drm_amdgpu_info_vbios {
 	__u32 dbdf;
 	__u8 vbios_pn[64];
 	__u32 version;
+	__u8 vbios_ver_str[32];
 	__u8 date[32];
 	__u64 serial;
 	__u32 dev_id;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
