Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D48C4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 09:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4389C60F8F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 09:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4389C60F8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxedocomputers.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07CBC6E48D;
	Tue,  3 Aug 2021 09:38:23 +0000 (UTC)
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09BC06E48D;
 Tue,  3 Aug 2021 09:38:22 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by srv6.fidu.org (Postfix) with ESMTP id 2E4CEC800B5;
 Tue,  3 Aug 2021 11:38:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
 by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id j5zpKJ9d8Toa; Tue,  3 Aug 2021 11:38:19 +0200 (CEST)
Received: from [192.168.178.30] (host-212-18-30-247.customer.m-online.net
 [212.18.30.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: wse@tuxedocomputers.com)
 by srv6.fidu.org (Postfix) with ESMTPSA id 64657C80073;
 Tue,  3 Aug 2021 11:38:19 +0200 (CEST)
From: Werner Sembach <wse@tuxedocomputers.com>
Subject: New uAPI for color management proposal and feedback request v2
To: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Pekka Paalanen <ppaalanen@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-ID: <e452775c-5b95-bbfd-e818-f1480f556336@tuxedocomputers.com>
Date: Tue, 3 Aug 2021 11:38:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Greetings,

Original proposal: https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg62387.html

Abstract: Add "preferred color format", "active color format", "active bpc", and "active Broadcast RGB" drm properties,
to control color information send to the monitor.

It seems that the "preferred-" properties is not what is actually the most useful for the userspace devs.

Preferable (Note: with only a sample size of 2 people) would be a "force color format" property. If the color format is
not available for the current Monitor and GPU combo. the TEST_ONLY check should fail and the property should not be setable.

This however opens another problem: When a Monitor is disconnected and a new one is connected, the drm properties do not
get resetted. So if the old monitor did allow to set for example ycbcr420, but the new monitor does not support this
color format at all, it will stay permanently black until the drm property is set to a correct value by hand. This is
not an expected behavior imho.

So a discussion questions: Does it make sense that connector properties are keep for different Monitors?

If no: On connecting a new Monitor all atomic drm properties should be reset to a default value.

I have an idea how this could be implemented (correct me if i'm wrong): When an atomic property is attached it get
assigned an inital value. But if I understood the docu correctly, this value is ignored because atomic properties use
the getter and setter methods when their values are read or written. My implementation suggestion would be to iterate
over all attached atomic properties once a new monitor is connected and reset them to this initial value, which should
be unchanged since initialization? This assumes that besides the initial value being unused it's still a sane default
for all drivers.

Kind Regards,

Werner Sembach

