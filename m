Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7425DC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 23:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B55F22E00
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 23:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B55F22E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6B9F89F2A;
	Tue,  5 Jan 2021 23:00:27 +0000 (UTC)
Received: from svt-ETHLX-2.amd.com (unknown [165.204.54.251])
 by gabe.freedesktop.org (Postfix) with ESMTP id B56C989F31
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 23:00:26 +0000 (UTC)
Received: by svt-ETHLX-2.amd.com (Postfix, from userid 0)
 id 5B5DC184013A; Tue,  5 Jan 2021 17:54:21 -0500 (EST)
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/amdgpu: add instance_number check in
 amdgpu_discovery_get_ip_version
Date: Tue,  5 Jan 2021 17:54:08 -0500
Message-Id: <20210105225408.19511-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The original code returns IP version of instantce_0 for every IP.
This implementation may be correct for most of IPs.

However, for certain IP block (VCN for example), it may have 2 instances and
both of them have the same hw_id, BUT they have different revision number (0 and 1).

In this case, the original amdgpu_discovery_get_ip_version cannot correct reflects
the result and returns false information

Change-Id: I6d2e5a10cd2ee61874012598b9662b544f63e455
Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 306077884a67..141ea0d28fb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -536,7 +536,7 @@ int amdgpu_mem_train_support(struct amdgpu_device *adev)
 	uint32_t major, minor, revision, hw_v;
 
 	if (gddr6_mem_train_vbios_support(adev)) {
-		amdgpu_discovery_get_ip_version(adev, MP0_HWID, &major, &minor, &revision);
+		amdgpu_discovery_get_ip_version(adev, MP0_HWID, 0, &major, &minor, &revision);
 		hw_v = HW_REV(major, minor, revision);
 		/*
 		 * treat 0 revision as a special case since register for MP0 and MMHUB is missing
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b2dbcb4df020..073c35884641 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -325,7 +325,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
+int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
 				    int *major, int *minor, int *revision)
 {
 	struct binary_header *bhdr;
@@ -357,7 +357,7 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
 		for (j = 0; j < num_ips; j++) {
 			ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
 
-			if (le16_to_cpu(ip->hw_id) == hw_id) {
+			if ((le16_to_cpu(ip->hw_id) == hw_id) && (ip->number_instance == number_instance)) {
 				if (major)
 					*major = ip->major;
 				if (minor)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 8f6183801cb3..c8c9c33fe4bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -29,7 +29,7 @@
 
 void amdgpu_discovery_fini(struct amdgpu_device *adev);
 int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev);
-int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id,
+int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
                                     int *major, int *minor, int *revision);
 int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
