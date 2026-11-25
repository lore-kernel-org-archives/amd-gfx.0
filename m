Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A041A606A327
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=medichon.fr header.i=@medichon.fr header.a=rsa-sha256 header.s=ovhmo3801317-selector1 header.b=n6tq01IN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BC15112110;
	Thu, 26 Nov 2026 08:09:53 +0000 (UTC)
X-Greylist: delayed 12958 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 19:48:47 UTC
Received: from 16.mo581.mail-out.ovh.net (16.mo581.mail-out.ovh.net
 [46.105.72.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE0810FF76
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 19:48:47 +0000 (UTC)
Received: from director1.ghost.mail-out.ovh.net (unknown [10.110.43.65])
 by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4jZPpl4Fnqz60T3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 16:12:47 +0000 (UTC)
Received: from ghost-submission-7ccd8bbbb6-fqqbg (unknown [10.110.188.223])
 by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 12840C14BE;
 Wed, 25 Nov 2026 16:12:47 +0000 (UTC)
Received: from medichon.fr ([37.59.142.112])
 by ghost-submission-7ccd8bbbb6-fqqbg with ESMTPSA
 id eVV7Nv4IB2s1+hAAh8RzYA
 (envelope-from <abo@medichon.fr>); Wed, 25 Nov 2026 16:12:47 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S006bd52bede-5020-477e-b367-d3994f1f1069,
 7DE1F8E91E93E4FED769CE8C88DE2ED5D32FAA0F) smtp.auth=abo@medichon.fr
X-OVh-ClientIp: 88.190.90.129
From: Arnaud Bonnet <abo@medichon.fr>
To: abo@medichon.fr,
	alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: fix string format compiler warning in
 jpeg_v2_5_sw_init
Date: Wed, 25 Nov 2026 17:11:08 +0100
Message-ID: <20261125161108.214299-1-abo@medichon.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123231150.26328-1-abo@medichon.fr>
References: <20261123231150.26328-1-abo@medichon.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 648236871709515508
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFT3I8eUkQ1i7OQgYRL47Fxo/SHJnyvwq8T/pbzyTkp4gRDTLqg62H2gGAMUwxrpL2gRck4fSyQvTkfoIi6GJ9suzDLjHAEFaHBQHZL+NjIh20s3HSjQrVyYmqsnsIcO7D0sfqf3ipICR5yTaDuO/0cs7Tg/OndexI9exY2R9chC0poaK6iwUFFw+wfBqgz5gQcLNahEA+js+TlcN+OIYkAcyqPBnml2Obb3lnUqtg7B+CRhEoeaVV3gWiv786AWQ8lkBHcDiVuqfSg3y+jz/dYrRYTeFezNCwiM9a6YV2nVdN8rFqvIxJa9zjVoVncj2H1OOkB2eiOazlKsoBIV2+2nQC/3D0C8L+UIrK2fJhNaXkW3uwlY9+SwOF1SP5LOwJ+tDHaO8CXSWR/i8JMbtxWBRTiLgkWGV4qQnHtys9oMpMM0FdAfR4kUhpSOCikAq6zGM1REDpq/nncfFC/aStDaN69+T0/qNq7ymKDOFt2UK8xU6bIGUoJLorfGGOqD+fFhDEhipO33KAw17zyPpFfi9RthbwLCheU13sWmgyNLwMvqpTUVS+V2aFLJDPcXZtf08KQD+BVTYfQxEMm7Um3ni7+9C3IhUoM4g5oZ3HDoJ8RUDJngrL9xAWUlYb/XPDbqzweMh74+icd9cvV7gfunstMwTnI2JvdT3m/gEKa7Q
DKIM-Signature: a=rsa-sha256; bh=WqIe9ECO3tVFR72Txn2dFxGH6QDCReNmtLLpbmW1iTc=; 
 c=relaxed/relaxed; d=medichon.fr; h=From;
 s=ovhmo3801317-selector1; t=1795623167; v=1;
 b=n6tq01INWflxeKHMxLsI6UOMjrxm5wG1sKUyl8XWRt4FQn2KdrSnCNrua2AzsjroSKfkVIHM
 FjCrj/RESYsABjeUOUd19gnJFfDB4zJk7KRn3NUi4CdBn/pHrjMNCXFr7bYhuXFfVOHWnvSfxAc
 48RuVSEHIxexBKP1cNMzsJ754uCuo5JY9x0dMCOfKCFGg954A2m45OD6q8KYeAXEs57WeQkYofk
 lWu379vyel7sKv8ivNzZjqKDdqVmJZiyCazW8TBvyGVVL1geGLBpf64qk5JYznKDumEkQgruVy1
 EW5Xit80S6uFyX2QSXThfL8UELk5clfo8Ezeh++bKCONw==
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:09:32 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When doing sw initialization of JPEG for v2.5, the formatting function
snprintf is used with format string "jpeg_dec_%d", where d formats the
instance index of type int. This leads to the following compiler warning
with several GCC versions as the compiler is unable to derive a safe
upper bound for the formatted index size under W=1:

drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c: In function ‘jpeg_v2_5_sw_init’:
drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c:152:68: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 7 [-Wformat-truncation=]
  152 |                 snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%d", i);
      |                                                                    ^~
drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c:152:58: note: directive argument in the range [-2147483641, 254]
  152 |                 snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%d", i);
      |                                                          ^~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c:152:17: note: ‘snprintf’ output between 11 and 21 bytes into a destination of size 16
  152 |                 snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change to the %hhu format instead, which is safe as the instance count
always fits an unsigned char and allows to build the driver with
CONFIG_DRM_AMDGPU_WERROR enabled.

Fixes: ad0150fa2fad ("drm/amdgpu/jpeg: Fix sprintf buffer overflow warning in jpeg_v2_5")
Signed-off-by: Arnaud Bonnet <abo@medichon.fr>
---
v2:
  * change format from %hd to %hhu for consistency with fix in commit
    0ea554455542 ("drm/amdgpu: Fix snprintf usage in
    amdgpu_gfx_kiq_init_ring")
  * add Fixes: tag

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 966a8a7f28ee..59c9a9283aad 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -149,7 +149,7 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 		else
 			ring->vm_hub = AMDGPU_MMHUB0(0);
 		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + 8 * i;
-		snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%d", i);
+		snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%hhu", (unsigned char)i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst[i].irq,
 				     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
 		if (r)
-- 
2.53.0

