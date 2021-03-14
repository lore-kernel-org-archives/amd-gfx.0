Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CACC433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 08:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F035364E13
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 08:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F035364E13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1C4E89D61;
	Mon, 15 Mar 2021 08:04:22 +0000 (UTC)
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-oln040092255033.outbound.protection.outlook.com [40.92.255.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5595B6E209
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Mar 2021 06:08:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cn2LkkyvBgRhrOi+0VRXZgBvAeU3bm8S5Pp7Gvy0IDs3zY/wMEMN27/ArcxAxetYZu2fxKxFd8w8J6asv51dftMqM0QeOIJYdmudTJfpRmuxWvMSl2Jypv6Banib9TAXjDke4WPS3ULYw/NrWps7G6yg58mtQ2NBhYekJP+eXVBGlR/7+RmJ/Vmk73iIVCExO89HPh2ksdGn4UR8vC9aIpO1qSUEO4KQ7PkAPhke7pmWz0CWWNeycBMP5OqyczOWD6utcEcZDzGztQDK+ji0ONlmdSS22NougSuxytQlM6b8MINQxm44UOmt5gvGfyh+5NBkMdpSGUuh/gLUqPvekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gjhpcX0ZSPsdban9+dDtklB78YoRgpn0OL1Ioo/Ayc=;
 b=S+Zq0yMFGONJOuAbzPM4ifTTx+YYhoba3nxCEqFlMj7vKV4Mew9phpacMgC4b8Dk3Nlm7aS4oHfNcUe95XTroHLCIJGYggNC+ubpdwQjZVDMzgvNrSaLsZl7M1aCLOxn8OMIu+CKZyTLxu84YsqXCIlrxkcL3oHQSh2NAqJUSSbnysBEwYxm0sfv5Fs9akHNJYsxAX1g8N9ikLg0Z64LKdt5K2WFRhky6xF/W3bujoHoDyovfNNzjEwb/ir3jpthOy1ZUxg15F4Okfw43YWQj/Z60+YQUQjmdXBzyl0hOD3cHl4ZYb+v33ibPsnlKPjFD/GS19sQNGbBoMNQSn/9hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT043.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::4c) by
 SG2APC01HT102.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::253)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Sun, 14 Mar
 2021 06:08:27 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (2a01:111:e400:7ebd::40)
 by SG2APC01FT043.mail.protection.outlook.com
 (2a01:111:e400:7ebd::285) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.30 via Frontend
 Transport; Sun, 14 Mar 2021 06:08:27 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:B76199E54BAE92E0738D8DDE4D2E750E00F2F093BD44B57F43B14C55B9FFF1A7;
 UpperCasedChecksum:0B85A35C5E9E7027C6258E5B2E65912FEE98E513DAD6685735A79623657EDE76;
 SizeAsReceived:7558; Count:44
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::415f:2d37:68bd:23eb]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::415f:2d37:68bd:23eb%10]) with mapi id 15.20.3933.032; Sun, 14 Mar
 2021 06:08:27 +0000
Date: Sun, 14 Mar 2021 14:08:20 +0800
From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] amdgpu: use MMIO to init atombios if device is
 Thunderbolt / USB4 attached
Message-ID: <PSXP216MB0438E23D0F4C2DFF2D9B8686806D9@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Disposition: inline
X-TMN: [uFEYpc1z/XmAHuoxWb71DOH0HKc9NYuRqWBHJNbu8UMebdvEDj3BwAQwjfeQSl4p]
X-ClientProxiedBy: MEXPR01CA0111.ausprd01.prod.outlook.com
 (2603:10c6:200:2c::20) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
X-Microsoft-Original-Message-ID: <YE2oVJaFCFjhRb0m@nicholas-dell-linux>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nicholas-dell-linux (2001:4479:c200:d00:be34:878c:be91:5d31) by
 MEXPR01CA0111.ausprd01.prod.outlook.com (2603:10c6:200:2c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Sun, 14 Mar 2021 06:08:25 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 44
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 98b0a258-6de2-42fa-b39d-08d8e6af9531
X-MS-TrafficTypeDiagnostic: SG2APC01HT102:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PIUFmfZrkDD5wJOyQ++F+jdeJ84i1IL+0rP0PsSKBpCJQ2GhdvCzf8s9QXafBD2O3Ih+lQFhba3br9dFxfbOfREmEGEl0Ymsqskbd85CPCyk5HP1oZ9bn+3xd2AIx+TE5+d5mxOgzUuoTJw7lb3PVzxegBbaFtk9vQieuYq3fmK1991Lxm4+RdJqwN8cb293k2E3p6aZ/vZoYwMufNU38iNRyGMwx0q1Ggv9akEzdBJCLvnqBxCs9/uCqte7uvgtuoxdo/2neGSGse9xohBh6JZNc/0S373+1d/7BrHsEJObv1JQabmOoLPcqhlN3S1q16q0cXdCNUG2tP/xmpqYVnE0+UYnwT99GrkKbhAEhZnRUHhQjxxVTLGvWkjfTrhoJXo4YdDl0zqUUv5uWdxfQ==
X-MS-Exchange-AntiSpam-MessageData: R4O+U1oPv0t7Jk6bacbGaOJkdiHowmSbPzazJ9DjaiF6nTAV5vW8zfLcJ+dfUI4Q3JREo6AEIGm+RBquK8Cr1Wm6R3wSY7Rb1t+iLj58YDMVPqoqrjk8XJGczuv6JCZ9bZDQLtvXf6WAKUvNJtMshGE9Rg8mcOjU2lg6TmYDAA94aZP5auX6ChDM7vt+v5m6AW5t7uJ1J6NR3M6sHaZcQg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b0a258-6de2-42fa-b39d-08d8e6af9531
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2021 06:08:27.1871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT043.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT102
X-Mailman-Approved-At: Mon, 15 Mar 2021 08:04:21 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When using some Thunderbolt hosts using BIOS-assisted PCI enumeration
with IO BAR assigned, we get an atombios timeout, such as:

[drm:atom_op_jump [amdgpu]] *ERROR* atombios stuck in loop for more than 20secs aborting
[drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck executing B456 (len 304, WS 4, PS 0) @ 0xB51B
[drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck executing B104 (len 183, WS 0, PS 8) @ 0xB17E
amdgpu 0000:08:00.0: amdgpu: gpu post error!
amdgpu 0000:08:00.0: amdgpu: Fatal error during GPU init
amdgpu: probe of 0000:08:00.0 failed with error -22

A workaround is to use MMIO to access ATOMBIOS when device is
Thunderbolt / USB4 attached.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 86add0f4e..5d16ec10d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1999,11 +1999,15 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
 	atom_card_info->reg_read = cail_reg_read;
 	atom_card_info->reg_write = cail_reg_write;
 	/* needed for iio ops */
-	if (adev->rio_mem) {
+	if (adev->rio_mem && !pci_is_thunderbolt_attached(adev->pdev)) {
 		atom_card_info->ioreg_read = cail_ioreg_read;
 		atom_card_info->ioreg_write = cail_ioreg_write;
 	} else {
-		DRM_DEBUG("PCI I/O BAR is not found. Using MMIO to access ATOM BIOS\n");
+		if (pci_is_thunderbolt_attached(adev->pdev))
+			DRM_DEBUG("Device is attached via Thunderbolt / USB4. Using MMIO to access ATOM BIOS\n");
+		else
+			DRM_DEBUG("PCI I/O BAR is not found. Using MMIO to access ATOM BIOS\n");
+
 		atom_card_info->ioreg_read = cail_reg_read;
 		atom_card_info->ioreg_write = cail_reg_write;
 	}
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
