Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E986CE7B611
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 13:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B4D210E37B;
	Wed,  4 Oct 2023 13:21:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 729F510E37B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 13:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiXGEycYZ9ZAxMPr0rCdb8yqLHAMCzfvagyLHrYMyt3gG83Qzpy+TYHPdFyGeSQzVxjGd027UF1+AzhKcBge2VBRDhH0KCl18dlfMmmzvWYYjlwuLugCuHPuUEVksSSgkY1yxwXrwg435mNAh0KyE31cflnRcIkrLwfQ/h6Ia3tzcy7/vY44zer4mMAuSKudzQn7R7rbm+LhUN+zSTeanZun8TgVa+dEE+r7NJlSHduaLIBdhB90y/zzYgP/NnTjDipJybs/Obqp3PAVsYtzco4YU19ChObUfWDDh28TEH3lT0oOGIlHpRrHtinR7TP1vnxoKjdxibm9dmHJKDBU+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xW6QcbYeOMgz/++W2wE94o9sovlLcEWcLbwU+z2RgA4=;
 b=A0TPQGAnIZtlRluYUrmRxQ0mOzzjJGNM5iIdAmQy/VAxMT7nWjHtwxEaFGAF6/cTfQ6MmDMBz4GccR1wS5pgRyY8jeL7rnk55b5Bw/cAVzL9/T4MMV8bQsBBykoVLuWdjSwxw/t5yMVn/kBTZOEC6GNYCWOu+Xz1kxAaCEHLeEIseoA1H8++yzj4P6bp3Gs3aIe9OfACQITcxa/ioEEo9eiJ6wkoLWdzhYR0SmHAq0FxJAWR6jwBy2sNP/4VQOfH11Ocy+SijAN/K81WXvSZdCpggbSuXAEBFMFgGzUusRplqVC70RnjzHFZQSqU71nzlfBQOwuefc7kUjGiUcZbeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW6QcbYeOMgz/++W2wE94o9sovlLcEWcLbwU+z2RgA4=;
 b=oIT9w2WGXJ2H/rQX5IMatzVkWnWSH3QDrEYqcbQjN5M5g1HCSPLU69RZ6mqlJtsmlV1mVJnyvJcby4e3aSMfN1IPT0I+7K8Kqbuo1Ipkt399sXXnDBtUJMql9BZJ/AIK6wyjwa+HGQU09UFGqPp2/QcAoZ2nvN/XY0IyOEHZAIc=
Received: from SA9PR13CA0053.namprd13.prod.outlook.com (2603:10b6:806:22::28)
 by DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.25; Wed, 4 Oct 2023 13:21:05 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:22:cafe::a1) by SA9PR13CA0053.outlook.office365.com
 (2603:10b6:806:22::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 13:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 13:21:05 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 08:21:04 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] Documentation/amdgpu: Add FRU attribute details
Date: Wed, 4 Oct 2023 18:50:39 +0530
Message-ID: <20231004132039.1506172-4-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|DM8PR12MB5431:EE_
X-MS-Office365-Filtering-Correlation-Id: 28bd404c-1cac-47dd-13f1-08dbc4dcc3a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iOrjIw7h+jSOjXIGn0G18rhgkBS4OieNGNdZY0xNkuPnFJU1vt9OTifZvwoxszJglvjX1PY5PVsuDDpCExoaEe4NMOP77PwjFkAba7gBCa/sTSNrFXA7r5WPJq0Ch1B2+oa4GpWm4ilihVAs3GH28qXBozLt1VHMM6WLO3frpagr+MqovMyD3Z9D3qvPR+ZH3vAoCEQhXdM2knyiDPL7GBKZhi5nSxgg9qpYM6xMyKGGHQ7Q74Si59TkEd/Jd7S0UOFqupSHZMsymOF0RrDv3NnkswihUn9ziU7K8rVJo13H3D93YuL1YXn0BV8lTiZXYMu1OYxqbwdk1nynrg2rgQcgA+pVwsgLXGVzlyM3x+LSAZuyqO3XaL4WYDQOUuxnMRdniy4B9P5A/5W5/MoOTR/adsfhDYgnhme9/o1uyiWOkimiZ5EzGcxACsCIt4RO3NBtOOOeJINUmLUjUUb2MSy8v86nY5RoHTO2fNc2UQtQkiTqNrg7w4M2ssdlR19TjmsXIB64R8N5RkauCUfjJp96qLlVQv+vqgHgMTlVzKHqABSCqJiJ/NVvxQiKLCN/dvdimA3U/bvQEUKvnQj3i9U14j+i5s+w6xdET/1vgYS4KDV8av8KKERTwlHMqut2L2SO+qr1pxyAtVTvYo/FXh1xcBj46CuniXMzEwkTOL3e7SoFI0fGratUXmigfEu+SGNFDY16TJEL9jmuAS9IfoLHbIfEk7wN0b6TCupqsPhiXdrBwkuKIDbB7Hx4M5jwraKuFA1Z5HFFOl2gIKYbQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(41300700001)(54906003)(44832011)(4326008)(8936002)(8676002)(70206006)(6916009)(5660300002)(47076005)(2616005)(356005)(6666004)(478600001)(426003)(70586007)(1076003)(26005)(16526019)(336012)(82740400003)(36756003)(81166007)(36860700001)(86362001)(316002)(7696005)(40460700003)(40480700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 13:21:05.6591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bd404c-1cac-47dd-13f1-08dbc4dcc3a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5431
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

Add documentation for the newly added manufacturer and fru_id attributes
in sysfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 Documentation/gpu/amdgpu/driver-misc.rst      | 12 ++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 19 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/gpu/amdgpu/driver-misc.rst b/Documentation/gpu/amdgpu/driver-misc.rst
index 82b47f1818ac..e40e15f89fd3 100644
--- a/Documentation/gpu/amdgpu/driver-misc.rst
+++ b/Documentation/gpu/amdgpu/driver-misc.rst
@@ -26,6 +26,18 @@ serial_number
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
    :doc: serial_number
 
+fru_id
+-------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+   :doc: fru_id
+
+manufacturer
+-------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+   :doc: manufacturer
+
 unique_id
 ---------
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 5d627d0e19a4..d635e61805ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -321,6 +321,16 @@ static ssize_t amdgpu_fru_serial_number_show(struct device *dev,
 
 static DEVICE_ATTR(serial_number, 0444, amdgpu_fru_serial_number_show, NULL);
 
+/**
+ * DOC: fru_id
+ *
+ * The amdgpu driver provides a sysfs API for reporting FRU File Id
+ * for the device.
+ * The file fru_id is used for this and returns the File Id value
+ * as returned from the FRU.
+ * NOTE: This is only available for certain server cards
+ */
+
 static ssize_t amdgpu_fru_id_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -332,6 +342,15 @@ static ssize_t amdgpu_fru_id_show(struct device *dev,
 
 static DEVICE_ATTR(fru_id, 0444, amdgpu_fru_id_show, NULL);
 
+/**
+ * DOC: manufacturer
+ *
+ * The amdgpu driver provides a sysfs API for reporting manufacturer name from
+ * FRU information.
+ * The file manufacturer returns the value as returned from the FRU.
+ * NOTE: This is only available for certain server cards
+ */
+
 static ssize_t amdgpu_fru_manufacturer_name_show(struct device *dev,
 						 struct device_attribute *attr,
 						 char *buf)
-- 
2.25.1

