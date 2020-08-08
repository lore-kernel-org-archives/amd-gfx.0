Return-Path: <SRS0=cqfu=BS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBD6C433DF
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Aug 2020 22:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825C5206B5
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Aug 2020 22:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825C5206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 255386E291;
	Sat,  8 Aug 2020 22:21:07 +0000 (UTC)
X-Greylist: delayed 589 seconds by postgrey-1.36 at gabe;
 Sat, 08 Aug 2020 22:21:06 UTC
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net
 [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D846E291;
 Sat,  8 Aug 2020 22:21:06 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "*.hostsharing.net",
 Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
 by bmailout3.hostsharing.net (Postfix) with ESMTPS id 57C8F105E958C;
 Sun,  9 Aug 2020 00:11:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id EBFAD448C31; Sun,  9 Aug 2020 00:11:14 +0200 (CEST)
Date: Sun, 9 Aug 2020 00:11:14 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Daniel Dadap <ddadap@nvidia.com>
Subject: Re: [Nouveau] [PATCH 1/4] drm: retrieve EDID via ACPI _DDC method
Message-ID: <20200808221114.5rfnys76ozoj62wv@wunner.de>
References: <20200727205357.27839-1-ddadap@nvidia.com>
 <20200727205357.27839-2-ddadap@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200727205357.27839-2-ddadap@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: david1.zhou@amd.com, nouveau@lists.freedesktop.org,
 joonas.lahtinen@linux.intel.com, jani.nikula@linux.intel.com,
 intel-gfx@lists.freedesktop.com, dri-devel@lists.freedesktop.com,
 amd-gfx@lists.freedesktop.org, rodrigo.vivi@intel.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, bskeggs@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 27, 2020 at 03:53:54PM -0500, Daniel Dadap wrote:
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -34,6 +34,7 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/vga_switcheroo.h>
> +#include <linux/pci.h>

Nit: Alphabetic ordering.

> +static u64 *get_dod_entries(acpi_handle handle, int *count)
> +{
> +	acpi_status status;
> +	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *dod;
> +	int i;
> +	u64 *ret = NULL;

Nits: Reverse christmas tree.
"ret" is a poor name, I'd suggest "entries" or something like that.
The spec says that _DOD is a list of 32-bit values, not 64-bit.

> +	status = acpi_evaluate_object(handle, "_DOD", NULL, &buf);
> +
> +	if (ACPI_FAILURE(status))
> +		return NULL;

Nit: No blank line between function invocation and error check.

> +	dod = buf.pointer;
> +
> +	if (dod == NULL || dod->type != ACPI_TYPE_PACKAGE)
> +		goto done;

Same.

> +	ret = kmalloc_array(dod->package.count, sizeof(*ret), GFP_KERNEL);
> +	if (ret == NULL)
> +		goto done;

Nit: Usually we use "if (!ret)" or "if (ret)".

> +	list_for_each_safe(node, next, &device->children) {

No, that's not safe because the ACPI namespace may change concurrently,
e.g. because a DSDT patch is applied by the user via sysfs.
Use acpi_walk_namespace() with a depth of 1 instead.

> +		for (i = 0; i < num_dod_entries; i++) {
> +			if (adr == dod_entries[i]) {
> +				ret = do_acpi_ddc(child->handle);
> +
> +				if (ret != NULL)
> +					goto done;

I guess ideally we'd want to correlate the display objects with
drm_connectors or at least constrain the search to Display Type
"Internal/Integrated Digital Flat Panel" instead of picking the
first EDID found.  Otherwise we might erroneously use the DDC
for an externally attached display.

> +struct edid *drm_get_edid_acpi(void)
> +{
> +#if defined(CONFIG_ACPI) && defined(CONFIG_PCI)

No, put an empty inline stub in the header file instead of using #ifdef, see:

https://www.kernel.org/doc/html/latest/process/coding-style.html#conditional-compilation

Patches 2, 3 and 4 need a "drm/" prefix in the Subject, e.g.
"drm/i915: ".

Please cc all ACPI-related patches to linux-acpi.

Thanks,

Lukas
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
