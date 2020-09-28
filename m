Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F545C2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 20:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 746122080A
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 20:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746122080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettle.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE38B89F27;
	Mon, 28 Sep 2020 20:45:49 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C26C889F27
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 20:45:48 +0000 (UTC)
Received: from murex.cb.ettle ([143.159.226.37]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.179]) with ESMTPSA (Nemesis) id
 1N7zNt-1kRF1a2okN-0151j3; Mon, 28 Sep 2020 22:45:41 +0200
Message-ID: <f46d8474e60cdee31c106955d266dcb27f790051.camel@ettle.org.uk>
Subject: Re: [PATCH] drm/amdgpu/dc: Pixel encoding DRM property and module
 parameter
From: James Ettle <james@ettle.org.uk>
To: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Sep 2020 21:45:39 +0100
In-Reply-To: <CADnq5_MffJ5_0fjkJW+k9_OCDkocrMOQm=NS8gS93HDSB9AZ8g@mail.gmail.com>
References: <7cc7d590-f713-2060-6bac-37bed0df618a@ettle.org.uk>
 <CADnq5_OEzoEP93+MsGN1tspy0OrxVTkujKUhs+6LryVApvERkw@mail.gmail.com>
 <286845a3-4903-c169-aa36-1eb986492ea3@ettle.org.uk>
 <CADnq5_O8Wzddr3LryTuQ5Jqc5yt51wqkxv6zbSbr0_RBSQCA4g@mail.gmail.com>
 <967f82b1-cf5b-473b-c9b3-d9f9df588cc7@amd.com>
 <ad59a8c59d52c40a89b7b4fd032df043e0747f27.camel@ettle.org.uk>
 <6583647a-7147-4f5b-0412-d3be77ca7fe2@gmail.com>
 <aa941ec6-994e-30c0-74fc-0d13734204bf@amd.com>
 <4e81ba76607f5919a6a1b9210b15f10668fb704b.camel@ettle.org.uk>
 <CADnq5_MffJ5_0fjkJW+k9_OCDkocrMOQm=NS8gS93HDSB9AZ8g@mail.gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
X-Provags-ID: V03:K1:NE43sO18PreqniBWJ6z/zsZrduQGhMnktMiGXBqw3tCGw0zzGWd
 0g9NWa4nyPX5jtNU+HXVhGiU+Rwp7tzAyh3cDJKl3a/vyRCVi8zYIAE5/MPMZ2XnPb3qqDT
 dJzTX8aCIqOW9ruVN3Wf8w6fGAIivcoQxh52D5fYFS6M+DalyDUj3Ee3RPdDlBIsusH9kvu
 2FXTFfjh1BA3IRKaXdWmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0mNHdJi+awA=:XVwpdT1hVXDZ15oojmYlz3
 z41ZkHHQetL5Y/6CoBNcdvnz/19AVl6qzTqdZFWmbXtWCYYLw+wPJ6tTKj0LYnJCXe5npgkyc
 NbYSRViggrbi90buBWcZReYIglldZwXHCEk6hmTq16Vxo5fdK76j92djswPTP2oyZspbnzE2v
 i1Efw/sZxIuQ0xCQxWuUxLrXjwRGhwoRzvivVyTocDfsS8xy6N3is5Kvv5Scrr7Odz1v43OuZ
 cvyc3kleuTmageDAIt98T7hqkX8MHKJbsmNVJ6+oWBnDCayOLtK4Ws3Vi9+uda5XoVAUrgcbo
 u9OmWoMYe1ePRvoiUQHKdmN8QD1mOwBwDZ4CPnSNNnIIRhvZhmW2CX1iUIFw7wkrs1cbfMjJf
 wSH82RwLy+xD4PPYEaAKSucFU4BXsdKTkKg8AdBmrtQajkr/IY1UwbEHhvq6oO0yqzP6Ij3q3
 euSEpbEM8r4Gzpqx2xAoNo07t0qkCXONtjsT54U9bFu1fb0M8UdJ7q2gmZLFf45NFuVt7IVgW
 /1AYRNgWKE+jpebUB+K0upEwqzf74Njyyzh20M5H2q3PJsE4tQ76q3X2oCoeUhJKr3WWiemMX
 EGTs7eNiaTO5nSDoOzCqcGkDApLJKqn+eB3x3LFljVZq5pq7IgHNIPtuSBSvlpWMT8npe+VHK
 W3RfOCGqXrfncIkxaucFhSHcM8U32C6AaScGlH/BEVn3QrEkdZJHcCOBvdqIOl96d20yhnQTn
 sAGHkB4+u7IUvE5fPCfWpuXv+GMdBbyB/UIkOEbOxDvgArOR2sS2AERbERz4x9+WDZMgLEYSO
 dlx1C1J4sA3EteBHtm7g4hZnQvrirz9X01zaeX+by8WFWrghNbDw37VhHlZEryYFDdPUfy6
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
Cc: Harry Wentland <harry.wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>, Harry Wentland <hwentlan@amd.com>,
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 2020-09-28 at 16:32 -0400, Alex Deucher wrote:
> Yes, but module parameters global for all devices claimed by that
> driver.  E.g., if you have a system with 2 or 3 AMD GPUs in it, that
> will be applied to all of them.  I think if we want to be able to set
> KMS properties on the kernel command line, we should add the
> functionality to the drm core so it works for all drivers and
> properties.  We already have this for basic modesetting.
> 
> Alex

Thanks for clarifying that -- I see what was meant now.

Personally I'm not wedded to the module parameter, but I think if this
is to be of use to those who are experiencing problems it does need
*some* way of specifying the encoding pretty early on (for things like
boot splashes and GDM -- which I believe is on Wayland).

-James


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
