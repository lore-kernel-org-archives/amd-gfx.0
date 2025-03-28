Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CA5C36016
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Mar 2025 15:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6893310E2B5;
	Sun, 30 Mar 2025 15:24:17 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C109610E1DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 21:09:10 +0000 (UTC)
Received: from fedori.lan (51b692a2.dsl.pool.telekom.hu
 [::ffff:81.182.146.162]) (AUTH: CRAM-MD5 soyer@irl.hu, )
 by irl.hu with ESMTPSA
 id 0000000000080649.0000000067E70FF3.0006D659; Fri, 28 Mar 2025 22:09:07 +0100
From: Gergo Koteles <soyer@irl.hu>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Alex Hung <alex.hung@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>,
 stable@vger.kernel.org
Subject: [PATCH v2] ACPI: video: Handle fetching EDID as ACPI_TYPE_PACKAGE
Date: Fri, 28 Mar 2025 22:08:56 +0100
Message-ID: <61c3df83ab73aba0bc7a941a443cd7faf4cf7fb0.1743195250.git.soyer@irl.hu>
X-Mailer: git-send-email 2.49.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Mailman-Approved-At: Sun, 30 Mar 2025 15:24:12 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The _DDC method should return a buffer, or an integer in case of an error.
But some Lenovo laptops incorrectly return EDID as buffer in ACPI package.

Calling _DDC generates this ACPI Warning:
ACPI Warning: \_SB.PCI0.GP17.VGA.LCD._DDC: Return type mismatch - \
found Package, expected Integer/Buffer (20240827/nspredef-254)

Use the first element of the package to get the EDID buffer.

The DSDT:

Name (AUOP, Package (0x01)
{
	Buffer (0x80)
	{
	...
	}
})

...

Method (_DDC, 1, NotSerialized)  // _DDC: Display Data Current
{
	If ((PAID == AUID))
        {
		Return (AUOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.AUOP */
	}
	ElseIf ((PAID == IVID))
	{
		Return (IVOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.IVOP */
	}
	ElseIf ((PAID == BOID))
	{
		Return (BOEP) /* \_SB_.PCI0.GP17.VGA_.LCD_.BOEP */
	}
	ElseIf ((PAID == SAID))
	{
		Return (SUNG) /* \_SB_.PCI0.GP17.VGA_.LCD_.SUNG */
	}

	Return (Zero)
}

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/Apx_B_Video_Extensions/output-device-specific-methods.html#ddc-return-the-edid-for-this-device
Cc: stable@vger.kernel.org
Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4085
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
Changes in v2:
 - Added comment
 - Improved commit message
 - Link to v1: https://lore.kernel.org/all/4cef341fdf7a0e877c50b502fc95ee8be28aa811.1743129387.git.soyer@irl.hu/

 drivers/acpi/acpi_video.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index efdadc74e3f4..103f29661576 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -649,6 +649,13 @@ acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length
 
 	obj = buffer.pointer;
 
+	/*
+	 * Some buggy implementations incorrectly return the EDID buffer in an ACPI package.
+	 * In this case, extract the buffer from the package.
+	 */
+	if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 1)
+		obj = &obj->package.elements[0];
+
 	if (obj && obj->type == ACPI_TYPE_BUFFER) {
 		*edid = kmemdup(obj->buffer.pointer, obj->buffer.length, GFP_KERNEL);
 		ret = *edid ? obj->buffer.length : -ENOMEM;
@@ -658,7 +665,7 @@ acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length
 		ret = -EFAULT;
 	}
 
-	kfree(obj);
+	kfree(buffer.pointer);
 	return ret;
 }
 
-- 
2.49.0

