Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD61E7B615
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 13:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0605310E37D;
	Wed,  4 Oct 2023 13:21:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F100610E37B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 13:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hx99Kf9yUDJ1iDjWSmQ8wekFS0cXXsfMLp6r28dVws4kNOf9ciESkR7FNh52PfAjjGiOYv1FrULCrBLhuezoX8bYe9KCJQu6SpMSnImVeF9i+nWN6eCB7gg72V7hLtvbrhX+OpX56Rdn2oNrtAmP9gHoPTVveIF18Ab0DhK2Faffk1I/6FzKQQeu6VdhP868oDuQLwnamFKfH7gMzZ2na8YKiW1XiO8iP5aBRCytYoKonzOGamrEAOk2IU6tZZo2bNyWe25MRgetZAeHyuYax6m30jX8LyWLWGW3Npzj8Z63c7uldHDD4KPGj7dQr0trOs9iGRqeJ/mRneiKBLmSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBZZg4o/jKZZC9Syn8e2ojk6HNQVlkF3pO/sBdqimhs=;
 b=GeD+CNXlYiGSRaMy/HiBpr5rO11QITWxz8Ic/5GpOuuU3bqrrOV51/HxAtzM9zd66o+jHfEgDG6PPNUSYNMpyknZ5GEeIV1e0UqcmJQK49mOgO12qa5p+5nmYX5+VATSQrWhCAVY06gYeBvi0Zno1pj8MHKJrkhctnaD93/NfklHCF3iy4wpdVUYueuS+87cGHjMMPQfWJ9xuP1RSG8DrBo34SrYsnMJchKedwAO43FNm124D6KBoFJH4Bx0h1QMWrtoR5sj96AVRtigZex30ZdkkKR2d0DSp/4JokFUlZ+2H6+X7hocnxz7sJwD3f3WP9fZ5DccxOGlUQWwMKUIHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBZZg4o/jKZZC9Syn8e2ojk6HNQVlkF3pO/sBdqimhs=;
 b=zZUl+MB7Ku/LUO7vyr98LzjKV5n+JZyUShT65NkdpJGu54aTfh/9tdL9wQng+H1cWSAbRbozclm5TX90J9+FoszMC3n9dMwzScS8Giw9O1/bmY3VDVH2+NzaEFhd6ajWKkJ9BzbSfdhWweYCsq6oS3nDkwC1LAxCJcbQEAz/vW8=
Received: from SA1PR02CA0016.namprd02.prod.outlook.com (2603:10b6:806:2cf::22)
 by DM4PR12MB7766.namprd12.prod.outlook.com (2603:10b6:8:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Wed, 4 Oct
 2023 13:21:04 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:2cf:cafe::16) by SA1PR02CA0016.outlook.office365.com
 (2603:10b6:806:2cf::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 13:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 13:21:04 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 08:21:02 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: Add more FRU field information
Date: Wed, 4 Oct 2023 18:50:38 +0530
Message-ID: <20231004132039.1506172-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004132039.1506172-1-lijo.lazar@amd.com>
References: <20231004132039.1506172-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|DM4PR12MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a65fe5-f529-497c-466b-08dbc4dcc2bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ml7cdzw9gBvc+kIQXATq5sNK3snLR5UvyuPt0KlYg2AQxqV8zB0EW9Q0kDABZYyBuQDNltrZ+OFa+8EMFqMjnio5Dz9JNpwTIDEqJPeFGiPnSKDY4T77QEUeTe2silE2mXj1jTNv17WTN1J8ZtE6FGpgLGro48Y0j0F+z1OtLksLN68TRe1mrCdKI4M0l5wETfehMlc+rx38cUh1ZKxYdq/dEr7CeMyHRmAm9nSl/PYHW0jiJbQfR6BRadLLL4UCamb5RbuW+EhDwjpyZzA4dkuNU+iCqYE7la1QCzSJrV6kZvnyT+2YBVm/WwIcZTslLSaMDDbj34ZtcExMnYxTrziFkC+8EVIIRxvbNHpvg1fMqeEz2H8/FYS9NM7UZtGeLiT7hBOE8NZPXhocHUdIMeOkz3fmentzrDD+Cv5UNOvCCIsoE6L+tH1Braa9CA7A32IEb/aWYAHPf9S/Wi87B5VE8cW+KpNDhw4Ts+qGsI1KajQHdBNebrTCIt6CVs9hIDsI48t+xlYlsvEaa9GhsoKr1TyfBdbXgfiJwHtIuRRQiUfPQam4z0VGOXYfWU7X97yYsPhFRGxG7avXkER3DNk5lUXK69chi9moFgIxDNsLn1sKLIrJWlK+iX2Je8Ts5C2u4m13CFM38LuPaywVwgWppahoZ1FgSvhVzCYvcqhXR281/tzZCv9mur9YsxjGsWG6NC80onpg3jRCekw3tYQT0pRt/Y5dHZwR22bdS2eimF6wWxVmAKGcXA3hbyUYOfcBpROnwZROuSDZZSQuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(186009)(82310400011)(1800799009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(7696005)(40460700003)(16526019)(26005)(426003)(336012)(2616005)(86362001)(1076003)(36860700001)(82740400003)(81166007)(356005)(83380400001)(36756003)(5660300002)(44832011)(40480700001)(478600001)(70586007)(6666004)(8936002)(47076005)(41300700001)(4326008)(6916009)(54906003)(70206006)(316002)(8676002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 13:21:04.1596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a65fe5-f529-497c-466b-08dbc4dcc2bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7766
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support to read Manufacturer Name and FRU File Id fields. Also add
sysfs device attributes for external usage.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 52 +++++++++++++++++--
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h    |  2 +
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 79ba74dfc576..5d627d0e19a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -200,10 +200,19 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 
 	/* Now extract useful information from the PIA.
 	 *
-	 * Skip the Manufacturer Name at [3] and go directly to
-	 * the Product Name field.
+	 * Read Manufacturer Name field whose length is [3].
 	 */
-	addr = 3 + 1 + (pia[3] & 0x3F);
+	addr = 3;
+	if (addr + 1 >= len)
+		goto Out;
+	memcpy(fru_info->manufacturer_name, pia + addr + 1,
+	       min_t(size_t, sizeof(fru_info->manufacturer_name),
+		     pia[addr] & 0x3F));
+	fru_info->manufacturer_name[sizeof(fru_info->manufacturer_name) - 1] =
+		'\0';
+
+	/* Read Product Name field. */
+	addr += 1 + (pia[addr] & 0x3F);
 	if (addr + 1 >= len)
 		goto Out;
 	memcpy(fru_info->product_name, pia + addr + 1,
@@ -229,6 +238,18 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	memcpy(fru_info->serial, pia + addr + 1,
 	       min_t(size_t, sizeof(fru_info->serial), pia[addr] & 0x3F));
 	fru_info->serial[sizeof(fru_info->serial) - 1] = '\0';
+
+	/* Asset Tag field */
+	addr += 1 + (pia[addr] & 0x3F);
+
+	/* FRU File Id field. This could be 'null'. */
+	addr += 1 + (pia[addr] & 0x3F);
+	if ((addr + 1 >= len) || !(pia[addr] & 0x3F))
+		goto Out;
+	memcpy(fru_info->fru_id, pia + addr + 1,
+	       min_t(size_t, sizeof(fru_info->fru_id), pia[addr] & 0x3F));
+	fru_info->fru_id[sizeof(fru_info->fru_id) - 1] = '\0';
+
 Out:
 	kfree(pia);
 	return 0;
@@ -300,10 +321,35 @@ static ssize_t amdgpu_fru_serial_number_show(struct device *dev,
 
 static DEVICE_ATTR(serial_number, 0444, amdgpu_fru_serial_number_show, NULL);
 
+static ssize_t amdgpu_fru_id_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	return sysfs_emit(buf, "%s\n", adev->fru_info->fru_id);
+}
+
+static DEVICE_ATTR(fru_id, 0444, amdgpu_fru_id_show, NULL);
+
+static ssize_t amdgpu_fru_manufacturer_name_show(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	return sysfs_emit(buf, "%s\n", adev->fru_info->manufacturer_name);
+}
+
+static DEVICE_ATTR(manufacturer, 0444, amdgpu_fru_manufacturer_name_show, NULL);
+
 static const struct attribute *amdgpu_fru_attributes[] = {
 	&dev_attr_product_name.attr,
 	&dev_attr_product_number.attr,
 	&dev_attr_serial_number.attr,
+	&dev_attr_fru_id.attr,
+	&dev_attr_manufacturer.attr,
 	NULL
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
index c99c74811c78..bc58dca18035 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
@@ -31,6 +31,8 @@ struct amdgpu_fru_info {
 	char				product_number[20];
 	char				product_name[AMDGPU_PRODUCT_NAME_LEN];
 	char				serial[20];
+	char				manufacturer_name[32];
+	char				fru_id[32];
 };
 
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev);
-- 
2.25.1

