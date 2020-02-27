Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A64CC11D3D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 15:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDEC524688
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 15:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="spjMBvpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEC524688
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B22F66E926;
	Thu, 27 Feb 2020 15:54:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1656E926
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 15:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GavtQX3H4jtv/j0SqekP+7cJRxC5kSsQVbEL3Ykp9XZtJ+5AVbFw0A94P6jWRENPa9DeG6GYUzn3vee/ZHZ1h1dCuhsRNsiKbPVfSyeT1jSsrY7i3uog00iD6B9uQ1QEhQZIcktMzBgH+TmPup5/lZLduTGUfzk5XZ0t4A1DIt+gO5MViNYEexUaB8lwDZbZG+vEDdnUtJxpP9PdPwRI9EZNVA6QVpGA3NYMwo3jvSYjwDEYTAfZRPLWEpcFdedU90IT8gYmlfeTswveM6JU6CKMGTyJUSQCzaHrZmfwucGRR33xqyYJFOHQJRmmaSIGhfh6QlP9jAjNhn0Y2L4xDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD5Vkh9SfYsVU8CTzE3RvafotDYiJeVrhABXhcCCK+g=;
 b=nF9DXOUqsc6yKYgIBLRbUjfFFxWv3RePG/LlWaY8OGZOja5SG2AVbhuRJr4Q4jSz4JrlJzdWTJZuOWNXHLHmqlqvbeoKLmRtDKwREf8uxKvF+vTkZ107n84GYXBhxwmjeo5BNSDuO0TBAkc0WT3SslrVK/pD3cHeWXK/jUTFloXgjWUxLEh2eLySccrslbo0Ho8I+puNjNOn4GlcUcz7rSbfTXSW4lzrFqMLOpFxPFqircupdq50o+oOGr3/O2+RIW4KUq3tn6ZV5JX1YzOQtawcOQvkFSY2GxPoUOpxsZf/LMCVsOpAxdRgn7ebYRxuXCvVDeJBNM1+xVWQfK2Kzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD5Vkh9SfYsVU8CTzE3RvafotDYiJeVrhABXhcCCK+g=;
 b=spjMBvpcbuxT/PUKRVI+giAZwtRxz3SmVERZg6SyytznwyjuQWQjy57RyMix1urlwGG2Gsxe9xaNka9V/WylkPWT1LdAi8H9pqGFmyOpi1Oz8jcXt8czKk2dVJ1ZyYBf3hZImoAGgDI15daKOGede81n5zdQTMoCju6riPj1kXc=
Received: from MWHPR08CA0044.namprd08.prod.outlook.com (2603:10b6:300:c0::18)
 by BYAPR12MB2613.namprd12.prod.outlook.com (2603:10b6:a03:69::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Thu, 27 Feb
 2020 15:53:57 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::bb) by MWHPR08CA0044.outlook.office365.com
 (2603:10b6:300:c0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21 via Frontend
 Transport; Thu, 27 Feb 2020 15:53:56 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 15:53:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 27 Feb
 2020 09:53:55 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 27 Feb
 2020 09:53:54 -0600
Received: from hersenwu-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 27 Feb 2020 09:53:54 -0600
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/display: navi1x copy dcn watermark clock
 settings to smu resume from s3
Date: Thu, 27 Feb 2020 10:53:49 -0500
Message-ID: <20200227155349.10993-1-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(136003)(428003)(199004)(189003)(26005)(6916009)(86362001)(7696005)(2616005)(81156014)(81166006)(8676002)(8936002)(70206006)(426003)(1076003)(70586007)(54906003)(478600001)(4326008)(316002)(186003)(36756003)(5660300002)(6666004)(2906002)(356004)(336012)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2613; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16f7e405-23a1-49a5-c7e5-08d7bb9d40a5
X-MS-TrafficTypeDiagnostic: BYAPR12MB2613:
X-Microsoft-Antispam-PRVS: <BYAPR12MB261361DB654B92C952C1BCE7FDEB0@BYAPR12MB2613.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03264AEA72
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7QKCqXVrxWrwgdEz5Oyr0/yzmyXFzH6pxI69P+40bsOU7Ri7rgSOlpVfMFRd26l5mNNw9YWuL2O4utJm8fOdzaoxFvSnd3EUYMFUINpttn99CZ+g0G64KRrJrHOJALGvMQoAhoU0MTtGdRD0KgqH8SP9BtKWdGFIOTupAoz1VFUExIy9Lb/sgdpwzivbVUYu2TnnUCz1mYTN3mU3T6RfN+MuOfDLp/n8P8+3kaJHhFxIAu8D3JYELnf7DOjDeIhZdYoGDUXNDqpUJz/bKP5cOFDwsAqLE1mpVzql+tqbiwTf6J1A9xyA1sQVokWtnmlAbDevMDwzQu0pLGdss+rRLG4Z7FcYOjjto4c6XCK5szTXnpxFRTggjtMELNhsZXZzUhovvPNZKV4QydngzQEyLWWMokTaTVOMre1E1SmWVM0gPw7GMSnHMATxVhMt29QOZa0hEuKEu63U85d9P/lrGJ3e37jveFBin4ApHnNg1bUshWnUJti3T/miOi1DWW9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 15:53:56.3501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f7e405-23a1-49a5-c7e5-08d7bb9d40a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2613
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
Cc: Hersen Wu <hersenxs.wu@amd.com>, evan.quan@amd.com, kenneth.feng@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 This interface is for dGPU Navi1x. Linux dc-pplib interface depends
 on window driver dc implementation.

 For Navi1x, clock settings of dcn watermarks are fixed. the settings
 should be passed to smu during boot up and resume from s3.
 boot up: dc calculate dcn watermark clock settings within dc_create,
 dcn20_resource_construct, then call pplib functions below to pass
 the settings to smu:
 smu_set_watermarks_for_clock_ranges
 smu_set_watermarks_table
 navi10_set_watermarks_table
 smu_write_watermarks_table

 For Renoir, clock settings of dcn watermark are also fixed values.
 dc has implemented different flow for window driver:
 dc_hardware_init / dc_set_power_state
 dcn10_init_hw
 notify_wm_ranges
 set_wm_ranges

 For Linux
 smu_set_watermarks_for_clock_ranges
 renoir_set_watermarks_table
 smu_write_watermarks_table

 dc_hardware_init -> amdgpu_dm_init
 dc_set_power_state --> dm_resume

 therefore, linux dc-pplib interface of navi10/12/14 is different
 from that of Renoir.

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 931cbd7b372e..c58c0e95735e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1435,6 +1435,68 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 		drm_kms_helper_hotplug_event(dev);
 }
 
+static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = &adev->smu;
+	int ret = 0;
+
+	if (!is_support_sw_smu(adev))
+		return 0;
+
+	/* This interface is for dGPU Navi1x.Linux dc-pplib interface depends
+	 * on window driver dc implementation.
+	 * For Navi1x, clock settings of dcn watermarks are fixed. the settings
+	 * should be passed to smu during boot up and resume from s3.
+	 * boot up: dc calculate dcn watermark clock settings within dc_create,
+	 * dcn20_resource_construct
+	 * then call pplib functions below to pass the settings to smu:
+	 * smu_set_watermarks_for_clock_ranges
+	 * smu_set_watermarks_table
+	 * navi10_set_watermarks_table
+	 * smu_write_watermarks_table
+	 *
+	 * For Renoir, clock settings of dcn watermark are also fixed values.
+	 * dc has implemented different flow for window driver:
+	 * dc_hardware_init / dc_set_power_state
+	 * dcn10_init_hw
+	 * notify_wm_ranges
+	 * set_wm_ranges
+	 * -- Linux
+	 * smu_set_watermarks_for_clock_ranges
+	 * renoir_set_watermarks_table
+	 * smu_write_watermarks_table
+	 *
+	 * For Linux,
+	 * dc_hardware_init -> amdgpu_dm_init
+	 * dc_set_power_state --> dm_resume
+	 *
+	 * therefore, this function apply to navi10/12/14 but not Renoir
+	 * *
+	 */
+	switch(adev->asic_type) {
+	case CHIP_NAVI10:
+	case CHIP_NAVI14:
+	case CHIP_NAVI12:
+		break;
+	default:
+		return 0;
+	}
+
+	/* pass data to smu controller */
+	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
+			!(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+		ret = smu_write_watermarks_table(smu);
+
+		if (ret) {
+			DRM_ERROR("Failed to update WMTABLE!\n");
+			return ret;
+		}
+		smu->watermarks_bitmap |= WATERMARKS_LOADED;
+	}
+
+	return 0;
+}
+
 /**
  * dm_hw_init() - Initialize DC device
  * @handle: The base driver device containing the amdgpu_dm device.
@@ -1713,6 +1775,8 @@ static int dm_resume(void *handle)
 
 	amdgpu_dm_irq_resume_late(adev);
 
+	amdgpu_dm_smu_write_watermarks_table(adev);
+
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
