Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E821C2D0DD
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 08:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A5E21655
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 08:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVNSIU7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A5E21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE11A89791;
	Thu,  2 Jan 2020 08:21:54 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB8089791
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 08:21:54 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id w15so25836973wru.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jan 2020 00:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=sNej0FxzXLNzOCrXtYlcRMONzeW/dUQohanaLrJ7gYQ=;
 b=BVNSIU7eMNLSICTbpl5VS4ZD4Vb2gr/IDyVkEIhD50B6S2HSaLQFPJnaR7g0D4AYyY
 IW1XgO7pbqIZFUmGnaMlhPKdT9VYYzcaD/u01HWX5h2wt0o9lmY9i98cvPXrXnCDjzAy
 XasrWDqaovhTyh/+c1Zqpa9LJw1kDe2LtoPsNTXOatZ8W5NbNwGQbjCcrYdwhYMB/Ezo
 i94F2+azzMKDlIu4LRvygfxfVHRdCD6Snk4Y3k1pxp0Z1mkKbqpWeDjoQtOmtXgrFpxr
 s1WQ67AGuorVxzo/pUgxMY8VxM0fDItHGKQW637GjwjmVYuz6C9NSOEh4pR/2fmX9OGC
 CleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=sNej0FxzXLNzOCrXtYlcRMONzeW/dUQohanaLrJ7gYQ=;
 b=QKo9H0jNi/5hgzvGU7BAaqX1oFbxvo20yyAoMFfuRD6aIh9KwVClztdE9KedjRMNgG
 bCzEWwiOK3Li7HhKcTlAhe7OLp3nJ32qUSk+8dZgV+XjnTjvNsh/BERqNyetvZ6AFAua
 fj9ngxj9sDERJxTwM7XJ9Rhp5GpQ5D+Rio/3WRCHKgu5qys8A9T/NNSexzEiOYw7SgQb
 mP5Xkuee6L60mTTnv63WnceRoluyCYLWoVo7BktRY/T1YlGEue0/Dj9sgPqPBiBBjjZW
 Tjh2DEk7d7SIzLmF0dsHQbMDhVUaMbTp8IMxtTb3E3Ie8/6Q/lmXmYr9GZ7uoFRmJp/r
 pNCw==
X-Gm-Message-State: APjAAAWRTsMEdAKWN3y7WeHd17dmBesJL2QxqadyUeqiTUOlayhENZ+K
 mxBZgqEhhC9f+IzF4AVnUSDjR86dXh0dPtGEjsOMfwN0
X-Google-Smtp-Source: APXvYqwb3P1H+GlNWUax+tlgh5SuIPl8h1hllc3N5pIPjIoBAzGJut6KFtStxYsQbCaSXbrursA3K+uUtkOvLCtY8XY=
X-Received: by 2002:adf:b193:: with SMTP id q19mr81193778wra.78.1577953311207; 
 Thu, 02 Jan 2020 00:21:51 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?Q?Yusuf_Alt=C4=B1parmak?= <yusufalti1997@gmail.com>
Date: Thu, 2 Jan 2020 11:21:40 +0300
Message-ID: <CAGzVRjxUUoF=m6-NvnRoqagLRAWQvTDVHA7Hkr=UA-_wRRyAZQ@mail.gmail.com>
Subject: [Error] amdgpu powerplay ip block error with -22.
To: amd-gfx@lists.freedesktop.org
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
Content-Type: multipart/mixed; boundary="===============0440743490=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0440743490==
Content-Type: multipart/alternative; boundary="0000000000009633d2059b23e24b"

--0000000000009633d2059b23e24b
Content-Type: text/plain; charset="UTF-8"

I am having this error with kernel version 4.19 amdgpu driver for a
polaris12 based GPU. What could be the problem? Any suggestions? Thanks.

*Full dmesg:*
[    5.426009] [drm] amdgpu kernel modesetting enabled.

[    5.430109] [drm] initializing kernel modesetting (POLARIS12
0x1002:0x6987 0x1787:0x2389 0x80).
[    5.437591] [drm] register mmio base: 0x20200000

[    5.440899] [drm] register mmio size: 262144

[    5.443888] [drm] add ip block number 0 <vi_common>

[    5.447465] [drm] add ip block number 1 <gmc_v8_0>

[    5.450953] [drm] add ip block number 2 <tonga_ih>

[    5.454442] [drm] add ip block number 3 <powerplay>

[    5.458018] [drm] add ip block number 4 <dm>

[    5.460979] [drm] add ip block number 5 <gfx_v8_0>

[    5.464466] [drm] add ip block number 6 <sdma_v3_0>

[    5.468042] [drm] add ip block number 7 <uvd_v6_0>

[    5.471531] [drm] add ip block number 8 <vce_v3_0>

[    5.475047] [drm] UVD is enabled in VM mode

[    5.477928] [drm] UVD ENC is enabled in VM mode

[    5.481154] [drm] VCE enabled in VM mode

[    5.712355] ATOM BIOS: 113-ER16BFC-001

[    5.714830] [drm] GPU posting now...

[    5.833704] [drm] vm size is 64 GB, 2 levels, block size is 10-bit,
fragment size is 9-bit
[    5.840950] amdgpu 0001:01:00.0: BAR 2: releasing [mem
0x220000000-0x2201fffff 64bit pref]
[    5.847930] amdgpu 0001:01:00.0: BAR 0: releasing [mem
0x210000000-0x21fffffff 64bit pref]
[    5.855688] [drm:.amdgpu_device_resize_fb_bar [amdgpu]] *ERROR* Problem
resizing BAR0 (-2).
[    5.855706] amdgpu 0001:01:00.0: BAR 0: assigned [mem
0x230000000-0x23fffffff 64bit pref]
[    5.869663] amdgpu 0001:01:00.0: BAR 2: assigned [mem
0x240000000-0x2401fffff 64bit pref]
[    5.876582] amdgpu 0001:01:00.0: VRAM: 4096M 0x000000F400000000 -
0x000000F4FFFFFFFF (4096M used)
[    5.884160] amdgpu 0001:01:00.0: GART: 256M 0x0000000000000000 -
0x000000000FFFFFFF
[    5.890519] [drm] Detected VRAM RAM=4096M, BAR=256M

[    5.894093] [drm] RAM width 128bits GDDR5

[    5.896941] [TTM] Zone  kernel: Available graphics memory: 4062380 kiB

[    5.902177] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB

[    5.907402] [TTM] Initializing pool allocator

[    5.910464] [TTM] Initializing DMA pool allocator

[    5.919973] [drm] amdgpu: 4096M of VRAM memory ready

[    5.923659] [drm] amdgpu: 4096M of GTT memory ready.

[    5.927358] [drm] GART: num cpu pages 65536, num gpu pages 65536

[    5.932957] [drm] PCIE GART of 256M enabled (table at
0x000000F400000000).
[    5.939122] [drm] Chained IB support enabled!

[    5.948873] [drm] Found UVD firmware Version: 1.79 Family ID: 16

[    5.953647] [drm] UVD ENC is disabled

[    5.975818] [drm] Found VCE firmware Version: 52.4 Binary ID: 3

[    6.404774] amdgpu: [powerplay] Failed to send Message.

[    6.835902] amdgpu: [powerplay] SMU Firmware start failed!

[    6.840086] amdgpu: [powerplay] Failed to load SMU ucode.

[    6.844184] amdgpu: [powerplay] smc start failed

*[    6.847498] amdgpu: [powerplay] powerplay hw init failed *

*[    6.852281] [drm:.amdgpu_device_init [amdgpu]] *ERROR* hw_init of IP
block <powerplay> failed -22*
*[    6.859883] amdgpu 0001:01:00.0: amdgpu_device_ip_init failed *

*                                              [    6.864330] amdgpu
0001:01:00.0: Fatal error during GPU init  *
*                                         [    6.868689] [drm] amdgpu:
finishing device. *




*[    7.339427] pcieport 0001:00:00.0: AER: Corrected error received:
0001:00:00.0                                            [    7.345374]
pcieport 0001:00:00.0: PCIe Bus Error: severity=Corrected, type=Data Link
Layer, (Transmitter ID)             [    7.353993] pcieport 0001:00:00.0:
device [1957:0824] error status/mask=00001000/00002000
          [    7.361047] pcieport 0001:00:00.0:    [12] Timeout    *

[    7.706137] amdgpu: [powerplay]

                last message was failed ret is 0

[    8.127667] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[    8.966331] amdgpu: [powerplay]

                last message was failed ret is 0

[    9.320290] pcieport 0001:00:00.0: AER: Corrected error received:
0001:00:00.0
[    9.326226] pcieport 0001:00:00.0: PCIe Bus Error: severity=Corrected,
type=Data Link Layer, (Transmitter ID)
[    9.334845] pcieport 0001:00:00.0:   device [1957:0824] error
status/mask=00001000/00002000
[    9.341899] pcieport 0001:00:00.0:    [12] Timeout

[    9.387975] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   10.226636] amdgpu: [powerplay]

                last message was failed ret is 0

[   10.648275] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   11.486932] amdgpu: [powerplay]

                last message was failed ret is 0

[   11.908570] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   12.747228] amdgpu: [powerplay]

                last message was failed ret is 0

[   13.168866] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   14.007523] amdgpu: [powerplay]

                last message was failed ret is 0

[   14.429161] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   15.267816] amdgpu: [powerplay]

                last message was failed ret is 0

[   15.689456] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   16.528114] amdgpu: [powerplay]

                last message was failed ret is 0

[   16.949756] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   17.788411] amdgpu: [powerplay]

                last message was failed ret is 0

[   18.210051] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   19.048710] amdgpu: [powerplay]

                last message was failed ret is 0

[   19.470347] amdgpu: [powerplay]

                failed to send message 261 ret is 0

[   19.786774] [TTM] Finalizing pool allocator

[   19.789696] [TTM] Finalizing DMA pool allocator

[   19.793004] [TTM] Zone  kernel: Used memory at exit: 0 kiB

[   19.797209] [TTM] Zone   dma32: Used memory at exit: 0 kiB

[   19.801410] [drm] amdgpu: ttm finalized

*                            [   19.804496] amdgpu: probe of 0001:01:00.0
failed with error -22  *

--0000000000009633d2059b23e24b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5JIGFtIGhhdmluZyB0aGlzIGVycm9yIHdpdGgga2VybmVsIHZl
cnNpb24gNC4xOSBhbWRncHUgZHJpdmVyIGZvciBhIHBvbGFyaXMxMiBiYXNlZCBHUFUuIFdoYXQg
Y291bGQgYmUgdGhlIHByb2JsZW0/IEFueSBzdWdnZXN0aW9ucz8gVGhhbmtzLjxicj48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PjxiPkZ1bGwgZG1lc2c6PC9iPjxicj48L2Rpdj48ZGl2PlsgwqAg
wqA1LjQyNjAwOV0gW2RybV0gYW1kZ3B1IGtlcm5lbCBtb2Rlc2V0dGluZyBlbmFibGVkLiDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwvZGl2PlsgwqAgwqA1
LjQzMDEwOV0gW2RybV0gaW5pdGlhbGl6aW5nIGtlcm5lbCBtb2Rlc2V0dGluZyAoUE9MQVJJUzEy
IDB4MTAwMjoweDY5ODcgMHgxNzg3OjB4MjM4OSAweDgwKS4gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgPGJyPlsgwqAgwqA1LjQzNzU5MV0gW2RybV0gcmVnaXN0ZXIgbW1p
byBiYXNlOiAweDIwMjAwMDAwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgwqA1LjQ0MDg5OV0gW2RybV0gcmVnaXN0ZXIgbW1pbyBz
aXplOiAyNjIxNDQgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqA8YnI+WyDCoCDCoDUuNDQzODg4XSBbZHJtXSBhZGQgaXAgYmxvY2sgbnVt
YmVyIDAgJmx0O3ZpX2NvbW1vbiZndDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgPGJyPlsgwqAgwqA1LjQ0NzQ2NV0gW2RybV0gYWRkIGlwIGJsb2NrIG51
bWJlciAxICZsdDtnbWNfdjhfMCZndDsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCDCoDUuNDUwOTUzXSBbZHJtXSBhZGQgaXAgYmxvY2sg
bnVtYmVyIDIgJmx0O3RvbmdhX2loJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNS40NTQ0NDJdIFtkcm1dIGFkZCBpcCBibG9j
ayBudW1iZXIgMyAmbHQ7cG93ZXJwbGF5Jmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+WyDCoCDCoDUuNDU4MDE4XSBbZHJtXSBhZGQgaXAgYmxv
Y2sgbnVtYmVyIDQgJmx0O2RtJmd0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNS40NjA5NzldIFtkcm1dIGFkZCBp
cCBibG9jayBudW1iZXIgNSAmbHQ7Z2Z4X3Y4XzAmZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgwqA1LjQ2NDQ2Nl0gW2RybV0gYWRk
IGlwIGJsb2NrIG51bWJlciA2ICZsdDtzZG1hX3YzXzAmZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj5bIMKgIMKgNS40NjgwNDJdIFtkcm1dIGFk
ZCBpcCBibG9jayBudW1iZXIgNyAmbHQ7dXZkX3Y2XzAmZ3Q7IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgwqA1LjQ3MTUzMV0gW2RybV0g
YWRkIGlwIGJsb2NrIG51bWJlciA4ICZsdDt2Y2VfdjNfMCZndDsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCDCoDUuNDc1MDQ3XSBbZHJt
XSBVVkQgaXMgZW5hYmxlZCBpbiBWTSBtb2RlIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj5bIMKgIMKgNS40Nzc5MjhdIFtkcm1d
IFVWRCBFTkMgaXMgZW5hYmxlZCBpbiBWTSBtb2RlIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj5bIMKgIMKgNS40ODExNTRdIFtkcm1dIFZD
RSBlbmFibGVkIGluIFZNIG1vZGUgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCDCoDUuNzEyMzU1XSBBVE9NIEJJ
T1M6IDExMy1FUjE2QkZDLTAwMSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNS43MTQ4MzBdIFtkcm1d
IEdQVSBwb3N0aW5nIG5vdy4uLiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNS44MzM3MDRdIFtk
cm1dIHZtIHNpemUgaXMgNjQgR0IsIDIgbGV2ZWxzLCBibG9jayBzaXplIGlzIDEwLWJpdCwgZnJh
Z21lbnQgc2l6ZSBpcyA5LWJpdCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDxicj5bIMKgIMKgNS44NDA5NTBdIGFtZGdwdSAwMDAxOjAxOjAwLjA6IEJBUiAy
OiByZWxlYXNpbmcgW21lbSAweDIyMDAwMDAwMC0weDIyMDFmZmZmZiA2NGJpdCBwcmVmXSDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNS44
NDc5MzBdIGFtZGdwdSAwMDAxOjAxOjAwLjA6IEJBUiAwOiByZWxlYXNpbmcgW21lbSAweDIxMDAw
MDAwMC0weDIxZmZmZmZmZiA2NGJpdCBwcmVmXSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNS44NTU2ODhdIFtkcm06LmFtZGdwdV9kZXZp
Y2VfcmVzaXplX2ZiX2JhciBbYW1kZ3B1XV0gKkVSUk9SKiBQcm9ibGVtIHJlc2l6aW5nIEJBUjAg
KC0yKS4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPlsg
wqAgwqA1Ljg1NTcwNl0gYW1kZ3B1IDAwMDE6MDE6MDAuMDogQkFSIDA6IGFzc2lnbmVkIFttZW0g
MHgyMzAwMDAwMDAtMHgyM2ZmZmZmZmYgNjRiaXQgcHJlZl0gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPlsgwqAgwqA1Ljg2OTY2M10gYW1kZ3B1IDAw
MDE6MDE6MDAuMDogQkFSIDI6IGFzc2lnbmVkIFttZW0gMHgyNDAwMDAwMDAtMHgyNDAxZmZmZmYg
NjRiaXQgcHJlZl0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgPGJyPlsgwqAgwqA1Ljg3NjU4Ml0gYW1kZ3B1IDAwMDE6MDE6MDAuMDogVlJBTTogNDA5Nk0g
MHgwMDAwMDBGNDAwMDAwMDAwIC0gMHgwMDAwMDBGNEZGRkZGRkZGICg0MDk2TSB1c2VkKSDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+WyDCoCDCoDUuODg0MTYwXSBhbWRn
cHUgMDAwMTowMTowMC4wOiBHQVJUOiAyNTZNIDB4MDAwMDAwMDAwMDAwMDAwMCAtIDB4MDAwMDAw
MDAwRkZGRkZGRiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCA8YnI+WyDCoCDCoDUuODkwNTE5XSBbZHJtXSBEZXRlY3RlZCBWUkFNIFJBTT00
MDk2TSwgQkFSPTI1Nk0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgPGJyPlsgwqAgwqA1Ljg5NDA5M10gW2RybV0gUkFNIHdpZHRoIDEyOGJpdHMgR0REUjUg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgPGJyPlsgwqAgwqA1Ljg5Njk0MV0gW1RUTV0gWm9uZSDCoGtlcm5lbDogQXZhaWxhYmxl
IGdyYXBoaWNzIG1lbW9yeTogNDA2MjM4MCBraUIgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDC
oCDCoDUuOTAyMTc3XSBbVFRNXSBab25lIMKgIGRtYTMyOiBBdmFpbGFibGUgZ3JhcGhpY3MgbWVt
b3J5OiAyMDk3MTUyIGtpQiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNS45MDc0MDJd
IFtUVE1dIEluaXRpYWxpemluZyBwb29sIGFsbG9jYXRvciDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+WyDCoCDCoDUuOTEwNDY0XSBb
VFRNXSBJbml0aWFsaXppbmcgRE1BIHBvb2wgYWxsb2NhdG9yIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj5bIMKgIMKgNS45MTk5NzNdIFtkcm1d
IGFtZGdwdTogNDA5Nk0gb2YgVlJBTSBtZW1vcnkgcmVhZHkgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCDCoDUuOTIzNjU5XSBbZHJtXSBhbWRn
cHU6IDQwOTZNIG9mIEdUVCBtZW1vcnkgcmVhZHkuIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgwqA1LjkyNzM1OF0gW2RybV0gR0FSVDogbnVt
IGNwdSBwYWdlcyA2NTUzNiwgbnVtIGdwdSBwYWdlcyA2NTUzNiDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDxicj5bIMKgIMKgNS45MzI5NTddIFtkcm1dIFBDSUUgR0FSVCBvZiAyNTZNIGVu
YWJsZWQgKHRhYmxlIGF0IDB4MDAwMDAwRjQwMDAwMDAwMCkuIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsg
wqAgwqA1LjkzOTEyMl0gW2RybV0gQ2hhaW5lZCBJQiBzdXBwb3J0IGVuYWJsZWQhIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj5bIMKg
IMKgNS45NDg4NzNdIFtkcm1dIEZvdW5kIFVWRCBmaXJtd2FyZSBWZXJzaW9uOiAxLjc5IEZhbWls
eSBJRDogMTYgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCDCoDUuOTUzNjQ3
XSBbZHJtXSBVVkQgRU5DIGlzIGRpc2FibGVkIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj5bIMKgIMKgNS45NzU4
MThdIFtkcm1dIEZvdW5kIFZDRSBmaXJtd2FyZSBWZXJzaW9uOiA1Mi40IEJpbmFyeSBJRDogMyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+WyDCoCDCoDYuNDA0Nzc0XSBhbWRncHU6
IFtwb3dlcnBsYXldIEZhaWxlZCB0byBzZW5kIE1lc3NhZ2UuIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj5bIMKgIMKgNi44MzU5MDJdIGFtZGdwdTogW3Bvd2Vy
cGxheV0gU01VIEZpcm13YXJlIHN0YXJ0IGZhaWxlZCEgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqA8YnI+WyDCoCDCoDYuODQwMDg2XSBhbWRncHU6IFtwb3dlcnBsYXldIEZh
aWxlZCB0byBsb2FkIFNNVSB1Y29kZS4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgPGJyPlsgwqAgwqA2Ljg0NDE4NF0gYW1kZ3B1OiBbcG93ZXJwbGF5XSBzbWMgc3RhcnQg
ZmFpbGVkIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgPGJyPjxiPlsgwqAgwqA2Ljg0NzQ5OF0gYW1kZ3B1OiBbcG93ZXJwbGF5XSBwb3dlcnBsYXkg
aHcgaW5pdCBmYWlsZWQgPC9iPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgPGJyPjxiPlsgwqAgwqA2Ljg1MjI4MV0gW2RybTouYW1kZ3B1X2RldmljZV9pbml0IFthbWRn
cHVdXSAqRVJST1IqIGh3X2luaXQgb2YgSVAgYmxvY2sgJmx0O3Bvd2VycGxheSZndDsgZmFpbGVk
IC0yMjwvYj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPjxiPlsgwqAg
wqA2Ljg1OTg4M10gYW1kZ3B1IDAwMDE6MDE6MDAuMDogYW1kZ3B1X2RldmljZV9pcF9pbml0IGZh
aWxlZCA8L2I+wqAgwqAgwqAgwqAgwqAgwqAgwqAgPGI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPlsgwqAgwqA2
Ljg2NDMzMF0gYW1kZ3B1IDAwMDE6MDE6MDAuMDogRmF0YWwgZXJyb3IgZHVyaW5nIEdQVSBpbml0
IMKgPC9iPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8Yj7CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNi44
Njg2ODldIFtkcm1dIGFtZGdwdTogZmluaXNoaW5nIGRldmljZS4gPC9iPsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj48Yj5bIMKg
IMKgNy4zMzk0MjddIHBjaWVwb3J0IDAwMDE6MDA6MDAuMDogQUVSOiBDb3JyZWN0ZWQgZXJyb3Ig
cmVjZWl2ZWQ6IDAwMDE6MDA6MDAuMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgNy4zNDUzNzRdIHBjaWVw
b3J0IDAwMDE6MDA6MDAuMDogUENJZSBCdXMgRXJyb3I6IHNldmVyaXR5PUNvcnJlY3RlZCwgdHlw
ZT1EYXRhIExpbmsgTGF5ZXIsIChUcmFuc21pdHRlciBJRCkgwqAgwqAgwqAgwqAgwqAgwqAgPGJy
PlsgwqAgwqA3LjM1Mzk5M10gcGNpZXBvcnQgMDAwMTowMDowMC4wOiDCoCBkZXZpY2UgWzE5NTc6
MDgyNF0gZXJyb3Igc3RhdHVzL21hc2s9MDAwMDEwMDAvMDAwMDIwMDAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPlsgwqAgwqA3LjM2MTA0N10gcGNpZXBv
cnQgMDAwMTowMDowMC4wOiDCoCDCoFsxMl0gVGltZW91dCDCoCDCoDwvYj4gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCDCoDcuNzA2MTM3XSBhbWRn
cHU6IFtwb3dlcnBsYXldIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBsYXN0IG1lc3NhZ2Ugd2FzIGZhaWxlZCByZXQgaXMgMCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+WyDCoCDCoDguMTI3
NjY3XSBhbWRncHU6IFtwb3dlcnBsYXldIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBmYWlsZWQgdG8gc2VuZCBtZXNzYWdlIDI2MSByZXQgaXMgMCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKg
IMKgOC45NjYzMzFdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJy
PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxhc3QgbWVzc2FnZSB3YXMgZmFpbGVkIHJldCBpcyAw
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IDxicj5bIMKgIMKgOS4zMjAyOTBdIHBjaWVwb3J0IDAwMDE6MDA6MDAuMDogQUVSOiBDb3JyZWN0
ZWQgZXJyb3IgcmVjZWl2ZWQ6IDAwMDE6MDA6MDAuMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgOS4zMjYy
MjZdIHBjaWVwb3J0IDAwMDE6MDA6MDAuMDogUENJZSBCdXMgRXJyb3I6IHNldmVyaXR5PUNvcnJl
Y3RlZCwgdHlwZT1EYXRhIExpbmsgTGF5ZXIsIChUcmFuc21pdHRlciBJRCkgwqAgwqAgwqAgwqAg
wqAgwqAgPGJyPlsgwqAgwqA5LjMzNDg0NV0gcGNpZXBvcnQgMDAwMTowMDowMC4wOiDCoCBkZXZp
Y2UgWzE5NTc6MDgyNF0gZXJyb3Igc3RhdHVzL21hc2s9MDAwMDEwMDAvMDAwMDIwMDAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPlsgwqAgwqA5LjM0MTg5
OV0gcGNpZXBvcnQgMDAwMTowMDowMC4wOiDCoCDCoFsxMl0gVGltZW91dCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIMKgOS4zODc5NzVd
IGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGZhaWxlZCB0byBzZW5kIG1lc3NhZ2UgMjYxIHJldCBpcyAwIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgMTAu
MjI2NjM2XSBhbWRncHU6IFtwb3dlcnBsYXldIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBsYXN0IG1lc3NhZ2Ugd2FzIGZhaWxlZCByZXQgaXMgMCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+
WyDCoCAxMC42NDgyNzVdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
PGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZhaWxlZCB0byBzZW5kIG1lc3NhZ2UgMjYxIHJl
dCBpcyAwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgPGJyPlsgwqAgMTEuNDg2OTMyXSBhbWRncHU6IFtwb3dlcnBsYXldIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsYXN0IG1lc3NhZ2Ugd2FzIGZhaWxl
ZCByZXQgaXMgMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCA8YnI+WyDCoCAxMS45MDg1NzBdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZhaWxlZCB0byBzZW5k
IG1lc3NhZ2UgMjYxIHJldCBpcyAwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgMTIuNzQ3MjI4XSBhbWRncHU6IFtwb3dlcnBsYXld
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsYXN0IG1l
c3NhZ2Ugd2FzIGZhaWxlZCByZXQgaXMgMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+WyDCoCAxMy4xNjg4NjZdIGFtZGdwdTogW3Bv
d2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGZhaWxlZCB0byBzZW5kIG1lc3NhZ2UgMjYxIHJldCBpcyAwIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgMTQuMDA3NTIzXSBhbWRn
cHU6IFtwb3dlcnBsYXldIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBsYXN0IG1lc3NhZ2Ugd2FzIGZhaWxlZCByZXQgaXMgMCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+WyDCoCAxNC40Mjkx
NjFdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGZhaWxlZCB0byBzZW5kIG1lc3NhZ2UgMjYxIHJldCBpcyAwIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAg
MTUuMjY3ODE2XSBhbWRncHU6IFtwb3dlcnBsYXldIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsYXN0IG1lc3NhZ2Ugd2FzIGZhaWxlZCByZXQgaXMgMCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8
YnI+WyDCoCAxNS42ODk0NTZdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZhaWxlZCB0byBzZW5kIG1lc3NhZ2UgMjYx
IHJldCBpcyAwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgPGJyPlsgwqAgMTYuNTI4MTE0XSBhbWRncHU6IFtwb3dlcnBsYXldIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsYXN0IG1lc3NhZ2Ugd2FzIGZh
aWxlZCByZXQgaXMgMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCA8YnI+WyDCoCAxNi45NDk3NTZdIGFtZGdwdTogW3Bvd2VycGxheV0gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZhaWxlZCB0byBz
ZW5kIG1lc3NhZ2UgMjYxIHJldCBpcyAwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgMTcuNzg4NDExXSBhbWRncHU6IFtwb3dlcnBs
YXldIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsYXN0
IG1lc3NhZ2Ugd2FzIGZhaWxlZCByZXQgaXMgMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+WyDCoCAxOC4yMTAwNTFdIGFtZGdwdTog
W3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGZhaWxlZCB0byBzZW5kIG1lc3NhZ2UgMjYxIHJldCBpcyAwIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsgwqAgMTkuMDQ4NzEwXSBh
bWRncHU6IFtwb3dlcnBsYXldIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBsYXN0IG1lc3NhZ2Ugd2FzIGZhaWxlZCByZXQgaXMgMCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+WyDCoCAxOS40
NzAzNDddIGFtZGdwdTogW3Bvd2VycGxheV0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGZhaWxlZCB0byBzZW5kIG1lc3NhZ2UgMjYxIHJldCBpcyAwIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPlsg
wqAgMTkuNzg2Nzc0XSBbVFRNXSBGaW5hbGl6aW5nIHBvb2wgYWxsb2NhdG9yIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDxicj5bIMKg
IDE5Ljc4OTY5Nl0gW1RUTV0gRmluYWxpemluZyBETUEgcG9vbCBhbGxvY2F0b3IgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPlsgwqAgMTku
NzkzMDA0XSBbVFRNXSBab25lIMKga2VybmVsOiBVc2VkIG1lbW9yeSBhdCBleGl0OiAwIGtpQiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj5bIMKgIDE5Ljc5NzIwOV0g
W1RUTV0gWm9uZSDCoCBkbWEzMjogVXNlZCBtZW1vcnkgYXQgZXhpdDogMCBraUIgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+WyDCoCAxOS44MDE0MTBdIFtkcm1dIGFt
ZGdwdTogdHRtIGZpbmFsaXplZCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8Yj7CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+WyDCoCAxOS44MDQ0OTZdIGFtZGdw
dTogcHJvYmUgb2YgMDAwMTowMTowMC4wIGZhaWxlZCB3aXRoIGVycm9yIC0yMsKgIDwvYj48YnI+
PC9kaXY+DQo=
--0000000000009633d2059b23e24b--

--===============0440743490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0440743490==--
