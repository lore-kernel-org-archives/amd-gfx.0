Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BFAC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 18:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E802073E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 18:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ianMEgNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E802073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C6D96E0C9;
	Thu, 18 Jun 2020 18:30:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A4F6E0C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 18:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4Nn17MzrXBvEET4wWRsBnmNkpbbl7M4ma/y1iSpy9i8FACvN2ChxKUJ+giFiecggAXAsNswKke8I8d4uHThkdvCW7Ygb3Tip3qch+DaUFTU55GjYje9+sELQsLxkhwKB2RsSCLvaHnQVD/88SFcK4WAibFiQpGcC73Hx4uOGpNybL2LF+i+UjJ2EtVmEOYrvQTT7vR/vEF5fJWMvU7uthdnZbzexyFr17cwIb+pLWvBusqr6ru4byy5QdpC22Ba3+aCLs443e9rHGBQF3T7nMQYdL+y0WRY0OpKTnrZthnlMIIWKXAke/vspXgar/bIi1zgU8doee+tUfw+WZvCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7rwtUHFSOSyCpnfpRwtwo6vScJOaBmiadyQYXGygbs=;
 b=KsekW2UUB1fksjYqrZgm1eV+A0YoePtYE3e9H9rlZRseeyUM1bgee7mdurX+53m9QOzeR4r9kq2fWSAjHVjhStQKqo++mPI/COQIGrjxX2S66xNy2KAbq23DmMR6cEn58oQkK69Tcu4fdXu0EZAIRw+9S+Tr1If9ug6X8pyMoHuVx/IdHC9GgPffk0uKJMBnCp2iUwWmjFzRZgIVLdQy/fl4V9l4gzrDYVqSzqmJ1zPy7gkVoB7uzKIrR5cuLOxsL8XFbB4NX32hZgmpN2wZ9I0fFQnGIViC9xLPdSoCyPdUaZ6SPWFuzCkfDsdAM4/AFr6I9CJ4HwmzqInZZcNpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7rwtUHFSOSyCpnfpRwtwo6vScJOaBmiadyQYXGygbs=;
 b=ianMEgNzv8yA/cCruWkZ8bg+0+ihscHJW2fYTtOU3vWSk5cxtZ3mY7utUQU1pvvTAZYZHvCI1d3ShtdkBqJUpyfCG1Crrw9Au7gvD3pxxO5SqWHtQlmjx4gKGE8KNp22ctxt/MDO8kId9dnyfm5DK0pomY7+IINik5vKk4G25Cs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB2747.namprd12.prod.outlook.com (2603:10b6:5:4a::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Thu, 18 Jun 2020 18:30:31 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1c50:44e9:a4a2:2828]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1c50:44e9:a4a2:2828%6]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 18:30:31 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn: fix cast to restricted __le32 warning
Date: Thu, 18 Jun 2020 14:30:11 -0400
Message-Id: <20200618183011.4248-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::48) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jz-tester.amd.com (165.204.55.251) by
 YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 18:30:30 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb2000e2-41c6-4f39-e56e-08d813b5ae71
X-MS-TrafficTypeDiagnostic: DM6PR12MB2747:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2747F71B71C3C1CF42704AADE49B0@DM6PR12MB2747.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mth1ZAg6ZEcNxbr3HQUAEDYKH3rLwlRVSeLtSH/f5JlgSgYWsLdJoEeEoqDQfMRfH34RDxaLsw0w/8LsaKXv322lgB9ZZymMAIzIra1mC2FiYrOTbiIB1YfNjGOGZa7UYr0RtwZ905J/+fyrusKKP9kCFYms/nHkSWzT91TzKFO4bNJd9m6qTa0w6QCw+hICWVeUC58pKWeG9f/zF9CgRr+VLQKKBivNGxm2Zue23KBIK7VtF3iUl+4SW7WNbpn3ZnlT469pjprlWq8Ft+9eevpCqtcsa7HMBSbflCAlARV3MxECH9PDvUahNfNzVrz5XtIx/wkHvlqtYbabHFZHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(6486002)(956004)(2616005)(83380400001)(1076003)(36756003)(478600001)(86362001)(6916009)(8676002)(8936002)(16526019)(2906002)(26005)(316002)(66476007)(66556008)(4326008)(5660300002)(6666004)(52116002)(7696005)(186003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: g2J196FV6gcKkx5gxfcg14fx495ikEky4loGMwF+/HrGP123aIk7NJikOotbGwhTJaeMpFIrzantQ1WbQtkbHVgO0h285UFKb2Q5sPxBW63QKYIjwFNt/yndM3geUxUcEUwfvnrNGuwORO0guYEGWg/cV32tw1vH3EO9cnnttVLpfbL7A60tTybmJ626GCQ6qf5OfGdp48wZasc82+eygb2iVfjPYX0FT7DdiW8Byvp3q97X4SRsF1Xw/HliP2dSZ/C8A1P9iNKVfnJ+J7vaHkOtYUBcg829iJXggF+OhJnfrQ6p7/HDaZz8MHLUCqIboVEchvx+QLAEduS1abpt1g99uNxDFv2CWFpaXdL3TTFxysLVhXvR8/Dx+q0SfLnNkEtGWoQzPDkHpSYeajIwSK7PtN1WQn4sKRheiReWP6su9kuOEzvi7a23OfABprKS/yRsA/VebFsBfGAijE4T0z/JVQJaIO4WwP83i5KZZgMPse2NScny9T26tgau7Urj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2000e2-41c6-4f39-e56e-08d813b5ae71
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 18:30:31.1822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVkDEbRcpBCFnkStc6Sg9ww4jsE7Nz2UBW6o39BeMjwyL1qRfpMXNyZI/HrerNR/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2747
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

le32_to_cpu's argument needs explicitly be data type  __le32.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 28 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 ++--
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 15ff30c53e24..fa7735932be8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -136,7 +136,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	}
 
 	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
-	adev->vcn.fw_version = le32_to_cpu(hdr->ucode_version);
+	adev->vcn.fw_version = le32_to_cpu((__le32)hdr->ucode_version);
 
 	/* Bit 20-23, it is encode major and non-zero for new naming convention.
 	 * This field is part of version minor and DRM_DISABLED_FLAG in old naming
@@ -144,30 +144,30 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	 * is zero in old naming convention, this field is always zero so far.
 	 * These four bits are used to tell which naming convention is present.
 	 */
-	fw_check = (le32_to_cpu(hdr->ucode_version) >> 20) & 0xf;
+	fw_check = (le32_to_cpu((__le32)hdr->ucode_version) >> 20) & 0xf;
 	if (fw_check) {
 		unsigned int dec_ver, enc_major, enc_minor, vep, fw_rev;
 
-		fw_rev = le32_to_cpu(hdr->ucode_version) & 0xfff;
-		enc_minor = (le32_to_cpu(hdr->ucode_version) >> 12) & 0xff;
+		fw_rev = le32_to_cpu((__le32)hdr->ucode_version) & 0xfff;
+		enc_minor = (le32_to_cpu((__le32)hdr->ucode_version) >> 12) & 0xff;
 		enc_major = fw_check;
-		dec_ver = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf;
-		vep = (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
+		dec_ver = (le32_to_cpu((__le32)hdr->ucode_version) >> 24) & 0xf;
+		vep = (le32_to_cpu((__le32)hdr->ucode_version) >> 28) & 0xf;
 		DRM_INFO("Found VCN firmware Version ENC: %hu.%hu DEC: %hu VEP: %hu Revision: %hu\n",
 			enc_major, enc_minor, dec_ver, vep, fw_rev);
 	} else {
 		unsigned int version_major, version_minor, family_id;
 
-		family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
-		version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
-		version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
+		family_id = le32_to_cpu((__le32)hdr->ucode_version) & 0xff;
+		version_major = (le32_to_cpu((__le32)hdr->ucode_version) >> 24) & 0xff;
+		version_minor = (le32_to_cpu((__le32)hdr->ucode_version) >> 8) & 0xff;
 		DRM_INFO("Found VCN firmware Version: %hu.%hu Family ID: %hu\n",
 			version_major, version_minor, family_id);
 	}
 
 	bo_size = AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_CONTEXT_SIZE;
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
-		bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
+		bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu((__le32)hdr->ucode_size_bytes) + 8);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -306,11 +306,11 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
 
 			hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
 			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-				offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
+				offset = le32_to_cpu((__le32)hdr->ucode_array_offset_bytes);
 				memcpy_toio(adev->vcn.inst[i].cpu_addr, adev->vcn.fw->data + offset,
-					    le32_to_cpu(hdr->ucode_size_bytes));
-				size -= le32_to_cpu(hdr->ucode_size_bytes);
-				ptr += le32_to_cpu(hdr->ucode_size_bytes);
+					    le32_to_cpu((__le32)hdr->ucode_size_bytes));
+				size -= le32_to_cpu((__le32)hdr->ucode_size_bytes);
+				ptr += le32_to_cpu((__le32)hdr->ucode_size_bytes);
 			}
 			memset_io(ptr, 0, size);
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 6dcc3ce0c00a..23d8c192ff34 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -118,7 +118,7 @@ static int vcn_v1_0_sw_init(void *handle)
 		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
 		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
 		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
+			ALIGN(le32_to_cpu((__le32)hdr->ucode_size_bytes), PAGE_SIZE);
 		DRM_INFO("PSP loading VCN firmware\n");
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index c0e4133a6dd5..c8ff3f632eb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -121,7 +121,7 @@ static int vcn_v2_0_sw_init(void *handle)
 		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
 		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
 		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
+			ALIGN(le32_to_cpu((__le32)hdr->ucode_size_bytes), PAGE_SIZE);
 		DRM_INFO("PSP loading VCN firmware\n");
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index e99bef6e2354..06c2f7ef1935 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -149,13 +149,13 @@ static int vcn_v2_5_sw_init(void *handle)
 		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
 		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
 		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
+			ALIGN(le32_to_cpu((__le32)hdr->ucode_size_bytes), PAGE_SIZE);
 
 		if (adev->vcn.num_vcn_inst == VCN25_MAX_HW_INSTANCES_ARCTURUS) {
 			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id = AMDGPU_UCODE_ID_VCN1;
 			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev->vcn.fw;
 			adev->firmware.fw_size +=
-				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
+				ALIGN(le32_to_cpu((__le32)hdr->ucode_size_bytes), PAGE_SIZE);
 		}
 		DRM_INFO("PSP loading VCN firmware\n");
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 90fe95f345e3..bb8075975ef4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -121,13 +121,13 @@ static int vcn_v3_0_sw_init(void *handle)
 		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
 		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
 		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
+			ALIGN(le32_to_cpu((__le32)hdr->ucode_size_bytes), PAGE_SIZE);
 
 		if (adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) {
 			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id = AMDGPU_UCODE_ID_VCN1;
 			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev->vcn.fw;
 			adev->firmware.fw_size +=
-				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
+				ALIGN(le32_to_cpu((__le32)hdr->ucode_size_bytes), PAGE_SIZE);
 		}
 		DRM_INFO("PSP loading VCN firmware\n");
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
