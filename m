Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7D0C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 02:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7204204FD
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 02:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RlhKVMtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7204204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381BC6E02E;
	Thu, 13 Aug 2020 02:31:16 +0000 (UTC)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D9D6E954;
 Wed, 12 Aug 2020 22:36:20 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f346ead0000>; Wed, 12 Aug 2020 15:35:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 12 Aug 2020 15:36:19 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 12 Aug 2020 15:36:19 -0700
Received: from [172.20.40.66] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Aug
 2020 22:36:10 +0000
Subject: Re: [Nouveau] [PATCH 1/4] drm: retrieve EDID via ACPI _DDC method
To: Lukas Wunner <lukas@wunner.de>
References: <20200727205357.27839-1-ddadap@nvidia.com>
 <20200727205357.27839-2-ddadap@nvidia.com>
 <20200808221114.5rfnys76ozoj62wv@wunner.de>
From: Daniel Dadap <ddadap@nvidia.com>
Message-ID: <3aa06548-b7b4-6753-7169-88e9b2d80acc@nvidia.com>
Date: Wed, 12 Aug 2020 17:37:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200808221114.5rfnys76ozoj62wv@wunner.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1597271725; bh=+3RY+3wKmyCcynqQxctHpRsdsTNqLQPOVnfLwun4B10=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
 Content-Language;
 b=RlhKVMtAoSeXnAb9P9eDvWVgMPkPjHjMTuO9rTSK7WNXJuzu8pEzvVRGrC4zOU4Jh
 3LdfOg6hLKghFAQ5hB2XT1Is8gHazilI2+Hfs8RZZ8swN058QCTMlNNRSJVO3GiTMV
 nRoO0LsH9Kh8tmozg0JGrgPCUCf4u39skbAqAu24DDoKTsgV891JuVP7alnk/o2UBQ
 uT9deepHkqmGMLRahVlCoV5vd4YbpL4ymIHMzy8tjnxAm2TC12zDlAXXuRXXf9KU+N
 3Ah4yt4HrmXjxF0LHLTIqH7apH9w0MN8Z0RKwEf77Xiv+Af7DNNkDUvLmLVn3x6mer
 gUwnw+tQNX4WQ==
X-Mailman-Approved-At: Thu, 13 Aug 2020 02:31:14 +0000
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks, Lukas. I've incorporated your feedback into my local tree, but 
will wait for additional feedback from the individual DRM driver 
maintainers before sending out a series v2.

On 8/8/20 5:11 PM, Lukas Wunner wrote:
> On Mon, Jul 27, 2020 at 03:53:54PM -0500, Daniel Dadap wrote:
>> +             for (i = 0; i < num_dod_entries; i++) {
>> +                     if (adr == dod_entries[i]) {
>> +                             ret = do_acpi_ddc(child->handle);
>> +
>> +                             if (ret != NULL)
>> +                                     goto done;
> I guess ideally we'd want to correlate the display objects with
> drm_connectors or at least constrain the search to Display Type
> "Internal/Integrated Digital Flat Panel" instead of picking the
> first EDID found.  Otherwise we might erroneously use the DDC
> for an externally attached display.


Yes, we'd definitely need a way to do this if this functionality ever 
needs to be extended to systems with more than one _DDC method. 
Unfortunately, this will be much easier said than done, since I'm not 
aware of any way to reliably do map _DOD entries to connectors in a GPU 
driver, especially when we're talking about possibly correlating 
connectors on multiple GPUs which mux to the same internal display or 
external connector. All systems which I am aware of that implement ACPI 
_DDC do so for a single internal panel. I don't believe there's any 
reason to ever retrieve an EDID via ACPI _DDC for an external panel, but 
a hypothetical design with multiple internal panels, more than one of 
which needs to retrieve an EDID via ACPI _DDC, would certainly be 
problematic.


On at least the system I'm working with for the various switcheroo and 
platform-x86 driver patches I've recently sent off, the dGPU has an ACPI 
_DOD table and one _DDC method corresponding to one of the _DOD entries, 
but the iGPU has neither a _DOD table nor a _DDC method. Either GPU can 
be connected to the internal panel via the dynamically switchable mux, 
and the internal panel's EDID is available via _DDC to allow a 
disconnected GPU to read the EDID. Since only the DGPU has _DOD and 
_DDC, and there's no obvious way to associate connectors on the iGPU 
with connectors on the dGPU, I've implemented the ACPI _DDC EDID 
retrieval with the "first available" implementation you see here. I'm 
open to other ideas if you have them, but didn't see a good way to 
search for the "right" _DDC implementation should there be more than one.


As for preventing the ACPI EDID retrieval from being used for external 
panels, I've done this in the individual DRM drivers that call into the 
new drm_edid_acpi() API since it seemed that each DRM driver had its own 
way of distinguishing display connector types. If there's a good way to 
filter for internal panels in DRM core, I'd be happy to do that instead.

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
