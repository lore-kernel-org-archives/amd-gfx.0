Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CB8C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 09:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AEA660F14
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 09:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7AEA660F14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A6489C88;
	Tue,  7 Sep 2021 09:16:16 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B603189C88;
 Tue,  7 Sep 2021 09:16:14 +0000 (UTC)
Date: Tue, 07 Sep 2021 09:16:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1631006172;
 bh=kb+kPQrQ0XOUiHCLlMhIRUuVEoyp2oTFgoWLLWS5944=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=GOt3t+4li9I7nI45sPvj7K7hWjJycfLSx2Jwj/5xlOePb4qVgyAYVy18TpPWZEPOk
 cKdfFOs1afgalDVzhKVb6JEC8lFXtRjo2no3/9Ny8Gy/AAqXa07Z6tCDf8xcKovvGL
 LNY/TaRfvo6e+15FxBUNt6yhFmrAYSM9PC4y280dWKkskWnYO0rp6Qyvw8NPbWsGEV
 sUWw9WVFkigNbSRCoMsMO+M9lS1bF3yl51/+ZK114/N8ky4vKNasAF7Sy6CFapogP4
 VI14O6Gvr5SAeTOkgiHVIYimnSsZHtghEv0jWIwOUxpEEbv7Hnq5ul3hJOp+o7ab/E
 IXS+cupywY46g==
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Cc: harry.wentland@amd.com, alexander.deucher@amd.com, michel@daenzer.net,
 pekka.paalanen@collabora.com, daniel@fooishbar.org, daniel@ffwll.ch,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 0/7] drm: add per-connector hotplug events
Message-ID: <K_o7SuToYSYL9tTtvLoykIFhHGamEksX-WI1P5skYeWJqO55oOgKurPlx4Ix0xl0PEpVVdt7xQPWM4MbpihIQ2B__rVyB1thiTTXmmcQ7mk=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Simon Ser <contact@emersion.fr>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping, anyone up for a review?
