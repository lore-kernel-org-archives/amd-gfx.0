Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF59C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 08:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A50810E630;
	Fri, 21 Jul 2023 08:20:49 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AADD310E618
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 03:53:30 +0000 (UTC)
Received: from mail.208.org (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTP id 4R6bJ82nHxzBRDtB
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 11:53:28 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1689911608; x=1692503609; bh=EV1nMV2DEsYn3s4L7x/locP5eq+
 nsZH2TFRR4al9MOI=; b=P3hINwebdkVqLqRSRAURbCkxh+oG5TAgzlmV28pB8vx
 Ow99HynbMP32Ksri8TbAYYIacXwE2LQSETplBvAF+RdhIkJWxU4p8f7nL2LzLVCE
 svKWSjCoiQHug48PKTwSMDWTuxahbJhepMh37Dsyerjy+JO9xr8SaHkG1dXHNREv
 piGZJC9tOSVgszsGgxPII8wgH+vG92C2zRWzmJJ1b09MyokSzMZlBf9C53kucnBf
 YGmjV6hZ5Vlt1KZOx9GML11NDlb9GyhTwN5XnNscztrFRaNfELkhApXDZ+SWVZob
 HblGDIV/DgUKVvM5YZJlndmWBHeRiorF7uMOk5wTgBw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
 by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id WgJuFsBFPCIn for <amd-gfx@lists.freedesktop.org>;
 Fri, 21 Jul 2023 11:53:28 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
 by mail.208.org (Postfix) with ESMTPSA id 4R6bJ80fkQzBHXhJ;
 Fri, 21 Jul 2023 11:53:28 +0800 (CST)
MIME-Version: 1.0
Date: Fri, 21 Jul 2023 11:53:28 +0800
From: sunran001@208suo.com
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amd/pm: open brace '{' following struct go on the same
 line
In-Reply-To: <20230721035225.4986-1-xujianghui@cdjrlc.com>
References: <20230721035225.4986-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <f2e8d7241330934429e19a960a232f9c@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 21 Jul 2023 08:20:41 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ERROR: open brace '{' following struct go on the same line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h 
b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index ddc488251313..0cf564ea1ed8 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -429,10 +429,10 @@ int amdgpu_pm_load_smu_firmware(struct 
amdgpu_device *adev, uint32_t *smu_versio
  int amdgpu_dpm_handle_passthrough_sbr(struct amdgpu_device *adev, bool 
enable);
  int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, 
uint32_t size);
  int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu_device *adev, 
uint32_t size);
-int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,enum 
pp_clock_type type,
-				  uint32_t *min,uint32_t *max);
-int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,enum 
pp_clock_type type,
-				   uint32_t min,uint32_t max);
+int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev, enum 
pp_clock_type type,
+				  uint32_t *min, uint32_t *max);
+int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev, enum 
pp_clock_type type,
+				   uint32_t min, uint32_t max);
  int amdgpu_dpm_write_watermarks_table(struct amdgpu_device *adev);
  int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev, enum 
smu_event_type event,
  		       	      uint64_t event_arg);
