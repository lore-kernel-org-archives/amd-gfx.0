Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E652C4743C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 08:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032EA60238
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 08:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032EA60238
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxedocomputers.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 800A06E862;
	Mon,  7 Jun 2021 08:00:47 +0000 (UTC)
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 404236E848;
 Mon,  7 Jun 2021 08:00:46 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by srv6.fidu.org (Postfix) with ESMTP id CFDD9C800A2;
 Mon,  7 Jun 2021 10:00:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
 by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id Vz3RaQVqPJhP; Mon,  7 Jun 2021 10:00:44 +0200 (CEST)
Received: from [IPv6:2003:e3:7f4f:6000:f5f4:4cdd:8015:9770]
 (p200300E37F4f6000F5f44cdD80159770.dip0.t-ipconnect.de
 [IPv6:2003:e3:7f4f:6000:f5f4:4cdd:8015:9770])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: wse@tuxedocomputers.com)
 by srv6.fidu.org (Postfix) with ESMTPSA id 480A0C800E6;
 Mon,  7 Jun 2021 10:00:31 +0200 (CEST)
Subject: Re: [PATCH 2/4] drm/uAPI: Add "active bpc" as feedback channel for
 "max bpc" drm property
To: Maxime Ripard <maxime@cerno.tech>
References: <20210604171723.10276-1-wse@tuxedocomputers.com>
 <20210604171723.10276-3-wse@tuxedocomputers.com>
 <20210607074037.oxm7qbhcx7gsg6yd@gilmour>
From: Werner Sembach <wse@tuxedocomputers.com>
Message-ID: <55a45d9e-9784-0288-fc1f-144f99dc6c19@tuxedocomputers.com>
Date: Mon, 7 Jun 2021 10:00:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210607074037.oxm7qbhcx7gsg6yd@gilmour>
Content-Language: en-US
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
Cc: sunpeng.li@amd.com, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 airlied@linux.ie, amd-gfx@lists.freedesktop.org, tzimmermann@suse.de,
 rodrigo.vivi@intel.com, alexander.deucher@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 07.06.21 um 09:40 schrieb Maxime Ripard:
> Hi,
>
> On Fri, Jun 04, 2021 at 07:17:21PM +0200, Werner Sembach wrote:
>> Add a new general drm property "active bpc" which can be used by graphic drivers
>> to report the applied bit depth per pixel back to userspace.
> Just a heads up, we'll need an open source project that has accepted it
> before merging it.
>
> See https://www.kernel.org/doc/html/latest/gpu/drm-uapi.html#open-source-userspace-requirements
Yes, I know.
>
>> While "max bpc" can be used to change the color depth, there was no way to check
>> which one actually got used. While in theory the driver chooses the best/highest
>> color depth within the max bpc setting a user might not be fully aware what his
>> hardware is or isn't capable off. This is meant as a quick way to double check
>> the setup.
>>
>> In the future, automatic color calibration for screens might also depend on this
>> information available.
>>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> ---
>>   drivers/gpu/drm/drm_atomic_uapi.c |  2 ++
>>   drivers/gpu/drm/drm_connector.c   | 40 +++++++++++++++++++++++++++++++
>>   include/drm/drm_connector.h       | 15 ++++++++++++
>>   3 files changed, 57 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
>> index 268bb69c2e2f..7ae4e40936b5 100644
>> --- a/drivers/gpu/drm/drm_atomic_uapi.c
>> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
>> @@ -873,6 +873,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
>>   		*val = 0;
>>   	} else if (property == connector->max_bpc_property) {
>>   		*val = state->max_requested_bpc;
>> +	} else if (property == connector->active_bpc_property) {
>> +		*val = state->active_bpc;
>>   	} else if (connector->funcs->atomic_get_property) {
>>   		return connector->funcs->atomic_get_property(connector,
>>   				state, property, val);
>> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
>> index 7631f76e7f34..5f42a5be5822 100644
>> --- a/drivers/gpu/drm/drm_connector.c
>> +++ b/drivers/gpu/drm/drm_connector.c
>> @@ -1195,6 +1195,13 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
>>    *	drm_connector_attach_max_bpc_property() to create and attach the
>>    *	property to the connector during initialization.
>>    *
>> + * active bpc:
>> + *	This read-only range property is used by userspace check the bit depth
>> + *	actually applied by the GPU driver after evaluation all hardware
>                                  ^ display
>
> Depending on the system, the display component might have a GPU attached
> or not, and the GPU might have a display component or not.
Ok, I try to bee more clear in the wording
>
>> + *	capabilities and max bpc. Drivers to use the function
>> + *	drm_connector_attach_active_bpc_property() to create and attach the
>> + *	property to the connector during initialization.
>> + *
>>    * Connectors also have one standardized atomic property:
>>    *
>>    * CRTC_ID:
>> @@ -2150,6 +2157,39 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
>>   }
>>   EXPORT_SYMBOL(drm_connector_attach_max_bpc_property);
>>   
>> +/**
>> + * drm_connector_attach_active_bpc_property - attach "active bpc" property
>> + * @connector: connector to attach active bpc property on.
>> + * @min: The minimum bit depth supported by the connector.
>> + * @max: The maximum bit depth supported by the connector.
>> + *
>> + * This is used to check the applied bit depth on a connector.
>> + *
>> + * Returns:
>> + * Zero on success, negative errno on failure.
>> + */
>> +int drm_connector_attach_active_bpc_property(struct drm_connector *connector,
>> +					  int min, int max)
>> +{
>> +	struct drm_device *dev = connector->dev;
>> +	struct drm_property *prop;
>> +
>> +	prop = connector->active_bpc_property;
>> +	if (!prop) {
>> +		prop = drm_property_create_range(dev, 0, "active bpc", min, max);
>> +		if (!prop)
>> +			return -ENOMEM;
>> +
>> +		connector->active_bpc_property = prop;
>> +	}
>> +
>> +	drm_object_attach_property(&connector->base, prop, 0);
>> +	connector->state->active_bpc = 0;
> I guess we want to default to 8?
>
> Maxime
The default state should only be active when no display is connected or 
the display is off, so I thought 0 makes more sense, as no active 
display = no active bpc.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
