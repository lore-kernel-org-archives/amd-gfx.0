Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35D0C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 19:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4691221E2
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 19:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmercCbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4691221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95DB96E0A1;
	Mon, 10 Aug 2020 19:10:07 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCA1E89C08;
 Mon, 10 Aug 2020 19:10:05 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BF04322B47;
 Mon, 10 Aug 2020 19:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597086605;
 bh=T0tVjBCCXbNXEeU92uTxmw1N0dDtQvtH7f6NELAnp1Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XmercCbQgD1u+sH56W6H+MuOxptXryH2jPIRg3CnxZXjPargev4FA4c8Nhfu+bRIS
 JX3/nKwJ2S52n5GvdlS6oaonntGRt01oCzb/YDiJPtA0pI6cCWXCzGygBmb4ucv+ja
 7RNmSeJuvhr3ORfitahVuvbSnrqOqZgRKsazLQhc=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 48/64] drm/amd/powerplay: suppress compile error
 around BUG_ON
Date: Mon, 10 Aug 2020 15:08:43 -0400
Message-Id: <20200810190859.3793319-48-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810190859.3793319-1-sashal@kernel.org>
References: <20200810190859.3793319-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 Evan Quan <evan.quan@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

[ Upstream commit 75bc07e2403caea9ecac69f766dfb7dc33547594 ]

To suppress the compile error below for "ARCH=arc".
   drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c: In function 'arcturus_fill_eeprom_i2c_req':
>> arch/arc/include/asm/bug.h:22:2: error: implicit declaration of function 'pr_warn'; did you mean 'pci_warn'? [-Werror=implicit-function-declaration]
      22 |  pr_warn("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func__); \
         |  ^~~~~~~
   include/asm-generic/bug.h:62:57: note: in expansion of macro 'BUG'
      62 | #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
         |                                                         ^~~
   drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c:2157:2: note: in expansion of macro 'BUG_ON'
    2157 |  BUG_ON(numbytes > MAX_SW_I2C_COMMANDS);

Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 27c5fc9572b27..e4630a76d7bf5 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2042,8 +2042,6 @@ static void arcturus_fill_eeprom_i2c_req(SwI2cRequest_t  *req, bool write,
 {
 	int i;
 
-	BUG_ON(numbytes > MAX_SW_I2C_COMMANDS);
-
 	req->I2CcontrollerPort = 0;
 	req->I2CSpeed = 2;
 	req->SlaveAddress = address;
@@ -2081,6 +2079,12 @@ static int arcturus_i2c_eeprom_read_data(struct i2c_adapter *control,
 	struct smu_table_context *smu_table = &adev->smu.smu_table;
 	struct smu_table *table = &smu_table->driver_table;
 
+	if (numbytes > MAX_SW_I2C_COMMANDS) {
+		dev_err(adev->dev, "numbytes requested %d is over max allowed %d\n",
+			numbytes, MAX_SW_I2C_COMMANDS);
+		return -EINVAL;
+	}
+
 	memset(&req, 0, sizeof(req));
 	arcturus_fill_eeprom_i2c_req(&req, false, address, numbytes, data);
 
@@ -2117,6 +2121,12 @@ static int arcturus_i2c_eeprom_write_data(struct i2c_adapter *control,
 	SwI2cRequest_t req;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 
+	if (numbytes > MAX_SW_I2C_COMMANDS) {
+		dev_err(adev->dev, "numbytes requested %d is over max allowed %d\n",
+			numbytes, MAX_SW_I2C_COMMANDS);
+		return -EINVAL;
+	}
+
 	memset(&req, 0, sizeof(req));
 	arcturus_fill_eeprom_i2c_req(&req, true, address, numbytes, data);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
