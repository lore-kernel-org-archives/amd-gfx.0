Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597D0C2D0E2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 19:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46F82371F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 19:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46F82371F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettle.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12B1C6E8DF;
	Tue, 22 Sep 2020 19:34:28 +0000 (UTC)
X-Greylist: delayed 305 seconds by postgrey-1.36 at gabe;
 Tue, 22 Sep 2020 19:34:24 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C63DF6E8DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 19:34:24 +0000 (UTC)
Received: from bender.cb.ettle ([143.159.226.37]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.179]) with ESMTPSA (Nemesis) id
 1MJV5K-1k0wjp3tV2-00JvjW; Tue, 22 Sep 2020 21:29:14 +0200
To: amd-gfx@lists.freedesktop.org
From: James Ettle <james@ettle.org.uk>
Subject: [PATCH] drm/amdgpu/dc: Pixel encoding DRM property and module
 parameter
Autocrypt: addr=james@ettle.org.uk; prefer-encrypt=mutual; keydata=
 mQINBFYtXnUBEADLBCCM2XxZ1+tRoUM9x07BvlUtyoHH66ZxxDYkOpIaHBz4Aa/4/BMuA/r4
 45uYeH9i2x0bRtgQ1vNZ5pZwZOws7NL9Y9eaCJqbPjOFM3rlCtb5v7AtqDsZbbYC6s6nnkUu
 uyHV186ZuWO1kbrim1vzchPffO7j/VItxOQuJto8LOVdwX1BqDXqANaMJWV4s/4FDC1KrCV+
 YdSEGHZoXS10pJEbajttoBIAuk2QNWJqRRaO0aACgNGC0aZ56BhcB7rzYE7y/J5eSu0mj3+C
 fBEGNQvBFJwmk3FnHl7w8zeRDTqAwjd+RBgRKJYjjRRtz3BFH4vUkZLNevNKd1H9rUowgdGO
 E+ODm7cNIYgD7Ml4I9hbRws7qf0lIh3wC1K8HBtFBWoKCF/WmyBufpNXm/z+y1yOgIYvIwKY
 mNt2Qu4JqNCQ9dJ6T9wQb2gcZvVDibfizjeOAflzm8RWnWRKMyf5uOsCgomExCS5fNt6wumR
 u/1P4JQJqhwDXLD2QmxDD6EbMmudAWaZ2D+NQxRJrRVm77CdTv0Qj8Lu5rUnJiD7NwmmBOIG
 RiXb07pjo1ZyWeJnJNAn0yRv2w2Uvyzc/PrOrcpLSjfOvcmBK4nytvSYkZZGtnL1VUJayh3w
 OEnWfVsWlTlREC4nJCHBzFSvUe+Xw4FlShA/RLDY9BtdJzp1+QARAQABtCBKYW1lcyBFdHRs
 ZSA8amFtZXNAZXR0bGUub3JnLnVrPokCOgQTAQgAJAIbAwULCQgHAgYVCAkKCwIEFgIDAQIe
 AQIXgAUCWHksNQIZAQAKCRBxG8Huzr3dD0B9D/9oLzB+gbw8vxKe18h8Z7sm3EagOL3hH1g/
 gRbABekC8SueRbFdU9CczU1Dq2eZw38ptZgafK8L8TQAd+4yn4vNhnFR7n1nQJto9qD1FVWN
 VhPYg1vpmpf5bCF1B8k/aD5xsWU9cklwB5TMVzboHH8FtcVJr8dz0xnEeYmXaJnCwTrLbM8m
 0juh4NnNxU8WrzZJgwMeiYoqmDstA0ccRFZawh9rRtT4KAUByw2v2LlKTPrWldhKWXPTKkEQ
 s1ugp2qP0aPY5+l078kRktvNgDyU47/0bs48ZEgaXDRbZAM62uuqKxgtga7hISxbbg/jOr9P
 pTmH2Uikbh68Ufn6I5cUbyPnw46jIaYX2sECBsuXSSUSpiRUBfeo5o/WSGq7lnqmH3cOJ68X
 LCjew+Tmc6kexvAKyRtSyYagXtv5GPEfwaGv/dl2+JNqSHEs+4b9Z7yHgKyNmGOoclXyu1bB
 aDh+/TOw8kSkALx/xxvE8Ndbu83PufkpFY0GFIm3qHBAea19ekeQUZvSlqI4m9CWxftgYzyT
 jV/IQ/lgZEifnLWYja9w7a/x23iMnsHL5EMvzbIlv9azRxWbNc2aWXno84zJRB2EgWmyvFCH
 2KoPUxx+DbfkAofXHPIr2GECxLp8yH9a4weWqe8jZ52r4PEy1cqUfbDV13pKmiLeHR4MsAZ6
 MrkCDQRbEcBQARAA3mf7UwWBkAiKP5bcgItOyXXAEU+T2wyA8eeB+Mh7PYhzBprc3QULJxNW
 IAmvbSypigFTTyhxcWCgTJY47+IqN0REXOR1zED21GQb46jqwkvR8VilXXfz1s6DpS6A/niW
 4Qvcz2MZ7fpiaLh2Y1F/i9mi+xcy5A2LuD1YSL/YoxamwLDnQN09T7Tt4rp/I9wNg43vC7sO
 C5zksBx2HeH3GZQseaME1cB0XLG0btN4cD8ANibNkIiSaWPR4gP2QyP0TonyAd75g/JIw0c3
 7r1bL+OJwHdkAOyJjNMG3pSmvx8B1ebmhlD4EY8hqRXW449WOp9RTp2mNHTS7imXeDTWaar/
 OFTcO/8Akb8AlNYi41XobhGaPW03VMRlTkwsiR/au+A0Brrc/XbM7AuQtVfhdNPMXb+wUHtm
 G9oO0VoEheyAdQkw1y6bt/wsJCOiTsFsAqbrsObnuVavw8rkt7M3Ish3AQMyO045Cr5bhKzE
 nekrpGC8fYV11On1EaFJYZzgWxK1ql5+Yve35D1GV1Lq5sMD/Y496l5muNeyigEdK2/p+z1+
 MFjCur5jS0uM6wGH6H8YXkcGVELWUjICG7hKDqMuIRGRExKFE8kTaBM+lzt5vYMmjBFeNOFs
 b0jM2y3KZTdyNyLCYWTQWZhX3d8kw0tm9SegcwwY9KsnxsHMWMMAEQEAAYkEbAQYAQgAIBYh
 BE5BoiJq1+y1ERqIF3Ebwe7Ovd0PBQJbEcBQAhsCAkAJEHEbwe7Ovd0PwXQgBBkBCAAdFiEE
 eP/V3uhUT4xkBZ60w9AAbdGpxRIFAlsRwFAACgkQw9AAbdGpxRKLgg/+Obk/w6wKeza+Uo26
 xytHhd2EQjjuV+5Ha1aHoLVH6geW4Yk30uYLf/DZ16DfkeWxCo9sxnsBkn8OntPUDule9hbj
 x9ogIUMdc74hrcbZw7EX4RTEl8YEh+JoBMsL6kTQXjhFz3Oz18kBFbRCcftlh0p/ivApNCEP
 J9C4CrUvQ9aRmVqp5p0/0YEMHvIZkQJThEtWcW8J4XbXVdLT7gYFpaLOcLHON84yJNpsOMLq
 rxbY+2KcgAsCYfTc0l9CazP/Cv/8u4tr3nTF2BIpI7RqubcrI5T5VKpuyK0yG+D4M7yh824A
 a0n9b/Fg8TP41zIXO4HEXtL41BagvJf81eu8iX9Wk72HRafCIkYNqel3+AsBSg8p5oMQu4Q1
 AOqwfWYpMNAZRM1uVRDBYpeu5Lv/7fh8ANwdMLGoxmJ3IY3E54Jmd6ORX7G0o5WVIxlSAAhR
 FdUfA1cVw7VLSI2jEDubu6kqr3x6/pwxJRRx+CpTHSe0oq2kfT+NCrQxR7rS+6eO4Bb5yD3T
 ZBDW8iT1+0axd8A6ba2FRDLRd7VqdwinvTJ2tWSmV2oUe5Fs6eAWANgX2bg4kBTG0EKhrdgf
 ly27+A4IlUcilScYArz6MLy/l7KpekRBU1r2jhD2Vx29xlY0eMTNkYVF5Lu1STypa73PTH9T
 4GFyognKmz2cSQnN3LfOTxAAmoXxOfakroDJtE2uzEuiyv3QZH5AXOjTD/UcVneaF4IR8xtv
 WTaog1PmgPxjk0SVDWz9+z03tOLRQyVhdlkoO4E6FucjSBJ8xIRuk0ihtGMchPiU3cDAePka
 SVeK1cJMKvkEvjGOOs8PHbNE3hU2CV9kBtX21YZq54HG/6ToRkU4pfdsrPr+ZxnJCmszPqz6
 zgR2JO99gBi/AozaM7eIgAUZfcsPMKf69EAiGsJ+kxyGIijI62NBYV6ujhyxa3wlS16RX63z
 IYHm5/r+BJ++OR3GYrFPSM647NkcCh4Lfs6bGop1m4Tlt66mZ0KT2pzVSkm5rV3dMVWkJ4b3
 VBk9N4CE1yH6nwbjMtyQg8YSOOeFpov2NDGz3ZR5qa1Mb1+5aj0zMxelrc7dVe6UoqL583Wk
 BI9+8pR3AVtOJPyx8h8DUzvlCKyCSOVNP4mJuD0W3EikkJHHE24baZer4ZynKwc26XJgE7SB
 uqAH8T267t1g/ygNRfWnGqa7ZES2E37O4ObB7TV2obEy9dA+2gg9NWfSdC+GtS6VQx/wQMvZ
 SZFSOL0M60nTfYHBJRxG4UuMfUb99s3BBDRtDX+wJePq0tpmmlo9EqxRBMBK2AhJy4WVARLE
 23ZZpppn2T1FVsjv/pxtONeDq2TiO7DWeiSRrGrNJGbYvRuVsWbU3u/cbAe5Ag0EXpRCqgEQ
 ALjYzqY/uRltAxAcJ8UBKkd5Uah8ePyurXYgaLxqQGeWSdwI8IPpY4DLTz+0ofDumFkP1yUM
 QqPHde84mQyiWIqZUOnU+YYn7PdTt+bGcZ2+TGPPxuO7gQ+kpP++x0u31FiKDlbyHUNyLdRJ
 bM5LlLyFmy95Nl6c8I+pZ+qIHg8lnDswILzBA3IpodE8D4V0EI/Bbqk2NX7AaMi4I/OB10b3
 aGO70tAekqhkqyFqUAgLGPJn78/Be0xnztcGOiwb7Ol8pzuyp7PLi+fCRXqBIWfiJ0Er22w8
 qvNfIWOS7nO1nLy/iwJyA1WqKOLVRy8zZqPun7W6C9QFdcn275DUL5MfuM9gH8DIwzwTIMkF
 1YMtUjki78wkfwlRX3Yef75+30DZSo1LrcHIteFzD1i6oZ4a4+TcryFbTo824ZxKwURkGCEH
 PnC2vVHhQUIdF0KRwkZwf4WXru6fSFHojEOIkKhHnhgKxVyIDGRthXiqlEAxbt6Xps2I5PmI
 nRbkz7y3K98Kd2BOOv0dY96SjhrSfYHyO8LKbD3Xyo8F/C8St0yFcn933ac4wjegD4I7C1k2
 GZ7T2KiRlKZpzxQS18qjcEUMol3sKbG5gxHybsMogzdYQI1bjvKxv9/sMnz9pLQgrDZTtCv/
 gXVGkKSS1sBH6FS375QlUbxBB70waSiMPD1FABEBAAGJAjYEGAEIACAWIQROQaIiatfstREa
 iBdxG8Huzr3dDwUCXpRCqgIbDAAKCRBxG8Huzr3dDx4xEACKM6C42uvhXg1n2qy/jg4cSIjX
 YczEJhhG0a7crcS/ggokrnJpd7iYszrEQFO4tOHcpgYQ+ZETVDP+z41cXihoTDUTWUl15C9q
 ZDlF0+dlrngfFhI4IG04rq5MfLmMtDAxYAoXQAfcYD1IujAIxixOtoxxcUTttBq9PcwPBCga
 80t+4lfi2qcN+iOKzG3clffOmpZy8U8hjLSycloxfaqzBVWdn901aDWGKr8Sv5X8kmCBKsu2
 L7sm+gKFojFhkG7huembGG0had1P8WC4zFIMfq81xCEIq8xAWkZyzbv2oLnWCn9njNhQGxY2
 exjsbWggA/jsBBE5xzR6DG21F+h6jjQcfetFU2Xzvv83ty0OVpSGIJe1ubK5Q9tEYQ98cQAe
 x+EKiCoAFzrWxF8tNqF35K/o46vBSTMdw89Uco8GRIFBMHWjnPPMLoWBw9vJNbqT/Y3NXB8a
 /4zI4x0xqkpB0iYLfptkA5E/UaIH1dw4zgsh9BwXJWVxBO43NX5iT1HFRznFu9M2KzxcB+KL
 LUGyFFPDQiLwgLLOx8Ne8MrNTLOY2dN3MqmDfkaq52Y+oDurfMxXiNwTicaTgnQr0H+MTUel
 R/VYiYuVsUihDNKS6RwyJDguBN9QCBYbX44bMPpbpT+vXYSYDWEGFCGXviJBzP7nAK1GUZm8
 EXgPHlt7bQ==
Message-ID: <7cc7d590-f713-2060-6bac-37bed0df618a@ettle.org.uk>
Date: Tue, 22 Sep 2020 20:29:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:9hEKLGcDSw5xdQTVRSD789UxqKUJ7udzkO2KdpvS2uKed3mgiQk
 5MjjZcPcQC9FM9II7uPMPh6uZYP/m+taVhgFVwyuIIsSQl4BrxftR5dOhvDKkj+tN/BgtV5
 zgrqzObfWOdjrV6TStjo6dQmvJcO5Rn+voYcTTrHsr2rlOSrU8HQO4ya1wgYMOjZHiEr45r
 Hdjgghysj17zTUFOGzEbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QpqOaJ+EmHw=:217cW8fKMsByhu19bCRusp
 uMcAB+XZZKmbOL2t+kWAuMhbf28t4gjbLtFXW5ylvwI37X/DnZbntbXuocXekVc5RpXqP0Qcv
 1SKSsKGwhep1BGbLg/NVQPL6se7sAK5cV5XK7y6FxQEOc5sS7/zB5JVLOCBf5fAFglVxtoUO2
 7v9eVbHI24UNtBV/p3TeBkZKM+jcKurZSCh8i93qbzqnz2ZLr3eIJdS9pi4karCs6e4p/pZW8
 wMrZSAYBGoNSiT2fPEshpmlF0bpd98zjRFnkyctmbGREFSTFZt9Z++aAfzv+fVFG5uNZ3+m75
 puZ3EOHLkZUL/F3CKgFrq4fqxc8d7EMaFWrAUi27dNSiO6Db85/t01e8/34efQ5hYENj5BhNh
 P5PlN3zSOEgAV4D3gTVyRn6tmPV1MzKJ9Q8fxtr4mYnI1bU0a9Ph2A6mqM9b0rk3w34ABaUoX
 tOjIVG/Bvyt7wkmT8Rw9WFnCaptutzZkjiveoQo42CkQittXjsO+++uGRQXWuAeZgctSI/exz
 rpYfHou/3Lnxr8TAYvSua5vCVANwjoB+TJdhtaifOcsYxQIoENQYMH9TT6/Gn5XUXB2UpaA4J
 iQxqI6Lw2ABbXKCCmIXstNxzxavSqXp7PtN0rCZxwXvz7dmnhSQwtpW0GqXAq4j+EptujmNXd
 0oU/CFTE2490sXywqpDQqj6PWyswvp1V/Fx1KpUQD2weuU1cw0zeEgSlhmpkYVo2xbonLvUXN
 M7pOffQlcXGe3QvTcReT37tnB/Cq4uce/gAm1/MIVjPSiQYwgwi/ywMLRlvlUaxyYXEw5kSnj
 Tgs2tB6wqHmSo51TSoiICXZe3XLiIPsDwjxFDPNZTbvWGXXRZ0mw49VoEeDQFETYbt2nz9M
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
Cc: hwentlan@amd.com, Rodrigo.Siqueira@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Exposes the pixel encoding as the DRM property "pixel encoding"
and the module parameter pixel_encoding.

The DRM property may take values "auto" (current behaviour
when a display is plugged in), "rgb" for RGB, or "ycbcr444" for
YCbCr 4:4:4.

The module parameter may only be set on boot and is of the format
[connector-name:]encoding[,...] where encoding is one of the
same values as are valid for the DRM property.

https://gitlab.freedesktop.org/drm/amd/-/issues/476
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  33 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   8 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 247 ++++++++++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  12 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 +
 7 files changed, 289 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index d76172965199..37748f35c52b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -614,6 +614,31 @@ static const struct drm_prop_enum_list amdgpu_dither_enum_list[] =
 	{ AMDGPU_FMT_DITHER_ENABLE, "on" },
 };
 
+static const struct drm_prop_enum_list amdgpu_user_pixenc_list[] =
+{	{ AMDGPU_USER_PIXENC_AUTO, "auto" },
+	{ AMDGPU_USER_PIXENC_RGB, "rgb" },
+	{ AMDGPU_USER_PIXENC_YCBCR444, "ycbcr444" },
+};
+
+bool amdgpu_user_pixenc_from_name(
+	enum amdgpu_user_pixenc *user_pixenc,
+	const char *pixenc_name)
+{
+	/* user_pixenc only modified if name found */
+	bool found = false;
+	if (pixenc_name && (*pixenc_name != '\0')) {
+		const int sz = ARRAY_SIZE(amdgpu_user_pixenc_list);
+		int i;
+		for (i = 0; !found && i < sz; ++i) {
+			if (strcmp(pixenc_name, amdgpu_user_pixenc_list[i].name) == 0) {
+				*user_pixenc = amdgpu_user_pixenc_list[i].type;
+				found = true;
+			}
+		}
+	}
+	return found;
+}
+
 int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
 {
 	int sz;
@@ -666,6 +691,14 @@ int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
 						"abm level", 0, 4);
 		if (!adev->mode_info.abm_level_property)
 			return -ENOMEM;
+
+		sz = ARRAY_SIZE(amdgpu_user_pixenc_list);
+		adev->mode_info.pixel_encoding_property =
+			drm_property_create_enum(adev->ddev, 0,
+				"pixel encoding",
+				amdgpu_user_pixenc_list, sz);
+		if (!adev->mode_info.pixel_encoding_property)
+			return -ENOMEM;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
index 3620b24785e1..72f82e3f4e32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
@@ -45,4 +45,8 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 				       struct drm_file *file_priv,
 				       const struct drm_mode_fb_cmd2 *mode_cmd);
 
+bool amdgpu_user_pixenc_from_name(
+	enum amdgpu_user_pixenc *user_pixenc,
+	const char *pixenc_name);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 37ba07e2feb5..3c21ecf3d259 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -123,6 +123,12 @@ enum amdgpu_flip_status {
 	AMDGPU_FLIP_SUBMITTED
 };
 
+enum amdgpu_user_pixenc {
+	AMDGPU_USER_PIXENC_AUTO,
+	AMDGPU_USER_PIXENC_RGB,
+	AMDGPU_USER_PIXENC_YCBCR444
+};
+
 #define AMDGPU_MAX_I2C_BUS 16
 
 /* amdgpu gpio-based i2c
@@ -333,6 +339,8 @@ struct amdgpu_mode_info {
 	struct drm_property *dither_property;
 	/* Adaptive Backlight Modulation (power feature) */
 	struct drm_property *abm_level_property;
+	/* User HDMI pixel encoding override */
+	struct drm_property *pixel_encoding_property;
 	/* hardcoded DFP edid from BIOS */
 	struct edid *bios_hardcoded_edid;
 	int bios_hardcoded_edid_size;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b51c527a3f0d..8901271d1902 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -158,7 +158,6 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
 static int amdgpu_dm_atomic_commit(struct drm_device *dev,
 				   struct drm_atomic_state *state,
 				   bool nonblock);
-
 static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state);
 
 static int amdgpu_dm_atomic_check(struct drm_device *dev,
@@ -172,6 +171,13 @@ static bool amdgpu_dm_psr_enable(struct dc_stream_state *stream);
 static bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream);
 static bool amdgpu_dm_psr_disable(struct dc_stream_state *stream);
 
+/**
+ * DOC: pixel_encoding (string)
+ * Specify the initial pixel encoding used by a connector.
+ */
+static char amdgpu_pixel_encoding[MAX_INPUT];
+MODULE_PARM_DESC(pixel_encoding, "Override pixel encoding");
+module_param_string(pixel_encoding, amdgpu_pixel_encoding, sizeof(amdgpu_pixel_encoding), 0444);
 
 /*
  * dm_vblank_get_counter
@@ -4214,6 +4220,103 @@ static bool adjust_colour_depth_from_display_info(
 	return false;
 }
 
+
+/* convert an amdgpu_user_pixenc to a dc_pixel_encoding */
+static bool drm_prop_to_dc_pixel_encoding(
+	enum dc_pixel_encoding *dc_pixenc,
+	enum amdgpu_user_pixenc user_pixenc)
+{
+	bool ret = false;
+	switch(user_pixenc) {
+	case AMDGPU_USER_PIXENC_AUTO:
+		*dc_pixenc = PIXEL_ENCODING_UNDEFINED;
+		ret = true;
+		break;
+	case AMDGPU_USER_PIXENC_RGB:
+		*dc_pixenc = PIXEL_ENCODING_RGB;
+		ret = true;
+		break;
+	case AMDGPU_USER_PIXENC_YCBCR444:
+		*dc_pixenc = PIXEL_ENCODING_YCBCR444;
+		ret = true;
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+
+/* convert an dc_pixel_encoding to a amdgpu_user_pixenc */
+static enum amdgpu_user_pixenc dc_pixel_encoding_to_drm_prop(
+	enum dc_pixel_encoding pixel_encoding)
+{
+	enum amdgpu_user_pixenc user_pixenc = AMDGPU_USER_PIXENC_AUTO;
+	switch(pixel_encoding) {
+	case PIXEL_ENCODING_RGB:
+		user_pixenc = AMDGPU_USER_PIXENC_RGB;
+		break;
+	case PIXEL_ENCODING_YCBCR444:
+		user_pixenc = AMDGPU_USER_PIXENC_YCBCR444;
+		break;
+	default:
+		break;
+	}
+	return user_pixenc;
+}
+
+/*
+ * Tries to read 'pixel_encoding' from the pixel_encoding DRM property on
+ * 'state'. Returns true if a supported, acceptable, non-undefined value is
+ * found; false otherwise. Only modifies 'pixel_encoding' if returning true.
+ */
+bool get_connector_state_pixel_encoding(
+	enum dc_pixel_encoding *pixel_encoding,
+	const struct drm_connector_state *state,
+	u32 color_formats)
+{
+	bool ret = false;
+	struct dm_connector_state *dm_state;
+
+	if (!(dm_state = to_dm_connector_state(state))) {
+		return false;
+	}
+
+	/* check encoding is supported */
+	switch (dm_state->pixel_encoding) {
+	case PIXEL_ENCODING_RGB:
+		ret = (color_formats & DRM_COLOR_FORMAT_RGB444);
+		break;
+	case PIXEL_ENCODING_YCBCR444:
+		ret = (color_formats & DRM_COLOR_FORMAT_YCRCB444);
+		break;
+	default:
+		break;
+	}
+
+	if(ret)
+		*pixel_encoding = dm_state->pixel_encoding;
+
+	return ret;
+}
+
+/*
+ * Writes 'pixel_encoding' to the pixel_encoding DRM property on 'state', if
+ * the enum value is valid and supported; otherwise writes
+ * PIXEL_ENCODING_UNDEFINED which corresponds to the "auto" property state.
+ */
+void set_connector_state_pixel_encoding(
+	const struct drm_connector_state *state,
+	enum dc_pixel_encoding pixel_encoding)
+{
+	struct dm_connector_state *dm_state;
+
+	if (!(dm_state = to_dm_connector_state(state)))
+		return;
+
+	dm_state->pixel_encoding = pixel_encoding;
+}
+
 static void fill_stream_properties_from_drm_display_mode(
 	struct dc_stream_state *stream,
 	const struct drm_display_mode *mode_in,
@@ -4235,18 +4338,20 @@ static void fill_stream_properties_from_drm_display_mode(
 	timing_out->h_border_right = 0;
 	timing_out->v_border_top = 0;
 	timing_out->v_border_bottom = 0;
-	/* TODO: un-hardcode */
-	if (drm_mode_is_420_only(info, mode_in)
-			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
-		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
-	else if (drm_mode_is_420_also(info, mode_in)
-			&& aconnector->force_yuv420_output)
-		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
-	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCRCB444)
-			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
-		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
-	else
-		timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
+
+	if (!get_connector_state_pixel_encoding(&timing_out->pixel_encoding,
+		connector_state, connector->display_info.color_formats)) {
+		/* auto-select a pixel encoding */
+		if (drm_mode_is_420_only(info, mode_in) && stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
+			timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
+		else if (drm_mode_is_420_also(info, mode_in) && aconnector->force_yuv420_output)
+			timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
+		else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCRCB444)
+				&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
+			timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
+		else
+			timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
+	}
 
 	timing_out->timing_3d_format = TIMING_3D_FORMAT_NONE;
 	timing_out->display_color_depth = convert_color_depth_from_display_info(
@@ -4294,6 +4399,7 @@ static void fill_stream_properties_from_drm_display_mode(
 
 	stream->out_transfer_func->type = TF_TYPE_PREDEFINED;
 	stream->out_transfer_func->tf = TRANSFER_FUNCTION_SRGB;
+
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
 		if (!adjust_colour_depth_from_display_info(timing_out, info) &&
 		    drm_mode_is_420_also(info, mode_in) &&
@@ -4302,6 +4408,9 @@ static void fill_stream_properties_from_drm_display_mode(
 			adjust_colour_depth_from_display_info(timing_out, info);
 		}
 	}
+
+	/* write back final choice of pixel encoding */
+	set_connector_state_pixel_encoding(connector_state, timing_out->pixel_encoding);
 }
 
 static void fill_audio_info(struct audio_info *audio_info,
@@ -4818,6 +4927,9 @@ int amdgpu_dm_connector_atomic_set_property(struct drm_connector *connector,
 	} else if (property == adev->mode_info.abm_level_property) {
 		dm_new_state->abm_level = val;
 		ret = 0;
+	} else if (property == adev->mode_info.pixel_encoding_property) {
+		if(drm_prop_to_dc_pixel_encoding(&dm_new_state->pixel_encoding, val))
+			ret = 0;
 	}
 
 	return ret;
@@ -4863,6 +4975,9 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
 	} else if (property == adev->mode_info.abm_level_property) {
 		*val = dm_state->abm_level;
 		ret = 0;
+	} else if (property == adev->mode_info.pixel_encoding_property) {
+		*val = dc_pixel_encoding_to_drm_prop(dm_state->pixel_encoding);
+		ret = 0;
 	}
 
 	return ret;
@@ -4912,6 +5027,50 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 	kfree(connector);
 }
 
+
+/*
+ * Returns the default pixel encoding, depending on the pixel_encoding
+ * module parameter if given.
+ */
+static enum dc_pixel_encoding pixel_encoding_reset(
+	const struct drm_connector *connector)
+{
+	char *param_str = NULL;
+	char *param_str_ptr = NULL;
+	char *param_item = NULL;
+	char *param_item_sep = NULL;
+	char *pixenc_mode = NULL;
+	enum amdgpu_user_pixenc user_pixenc;
+	enum dc_pixel_encoding pixel_encoding = PIXEL_ENCODING_UNDEFINED;
+
+	/* default in absence of module param */
+	if (*amdgpu_pixel_encoding == '\0')
+		return PIXEL_ENCODING_UNDEFINED;
+
+	/* decode param string */
+	param_str = kstrdup(amdgpu_pixel_encoding, GFP_KERNEL);
+	param_str_ptr = param_str;
+	while ((param_item = strsep(&param_str_ptr, ","))) {
+		param_item_sep = strchr(param_item, ':');
+		if (param_item_sep) {
+			if (strncmp(connector->name, param_item,
+				   param_item_sep - param_item) == 0) {
+				   pixenc_mode = param_item_sep + 1;
+				   break;
+			}
+		} else
+			pixenc_mode = param_item;
+	}
+
+	/* compare mode string and set */
+	if (amdgpu_user_pixenc_from_name(&user_pixenc, pixenc_mode)) {
+		drm_prop_to_dc_pixel_encoding(&pixel_encoding, user_pixenc);
+	}
+
+	kfree(param_str);
+	return pixel_encoding;
+}
+
 void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
 {
 	struct dm_connector_state *state =
@@ -4934,7 +5093,7 @@ void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
 		state->pbn = 0;
 		if (connector->connector_type == DRM_MODE_CONNECTOR_eDP)
 			state->abm_level = amdgpu_dm_abm_level;
-
+		state->pixel_encoding = pixel_encoding_reset(connector);
 		__drm_atomic_helper_connector_reset(connector, &state->base);
 	}
 }
@@ -4961,6 +5120,7 @@ amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector)
 	new_state->underscan_vborder = state->underscan_vborder;
 	new_state->vcpi_slots = state->vcpi_slots;
 	new_state->pbn = state->pbn;
+	new_state->pixel_encoding = state->pixel_encoding;
 	return &new_state->base;
 }
 
@@ -6175,6 +6335,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 	return amdgpu_dm_connector->num_modes;
 }
 
+
 void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 				     struct amdgpu_dm_connector *aconnector,
 				     int connector_type,
@@ -6263,6 +6424,12 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 		if (adev->dm.hdcp_workqueue)
 			drm_connector_attach_content_protection_property(&aconnector->base, true);
 #endif
+
+		if (adev->mode_info.pixel_encoding_property) {
+			drm_object_attach_property(&aconnector->base.base,
+				adev->mode_info.pixel_encoding_property, 0);
+			DRM_DEBUG_DRIVER("amdgpu: attached pixel encoding drm property");
+		}
 	}
 }
 
@@ -7332,6 +7499,37 @@ static int amdgpu_dm_atomic_commit(struct drm_device *dev,
 	/*TODO Handle EINTR, reenable IRQ*/
 }
 
+static void update_stream_for_pixel_encoding(
+	struct dc_stream_update *stream_update,
+	struct drm_connector *connector,
+	struct dm_crtc_state *dm_old_crtc_state,
+	struct dm_crtc_state *dm_new_crtc_state,
+	struct dm_connector_state *dm_new_con_state)
+{
+	struct amdgpu_dm_connector *aconnector =
+		to_amdgpu_dm_connector(connector);
+	struct dc_stream_state *new_stream = NULL;
+	if (aconnector)
+		new_stream = create_validate_stream_for_sink(
+			aconnector,
+			&dm_new_crtc_state->base.mode,
+			dm_new_con_state,
+			dm_old_crtc_state->stream);
+	if (new_stream) {
+		dm_new_crtc_state->stream->timing =
+			new_stream->timing;
+		stream_update->timing_for_pixel_encoding =
+			&dm_new_crtc_state->stream->timing;
+
+		dm_new_crtc_state->stream->output_color_space =
+			new_stream->output_color_space;
+		stream_update->output_color_space =
+			&dm_new_crtc_state->stream->output_color_space;
+
+		dc_stream_release(new_stream);
+	}
+}
+
 /**
  * amdgpu_dm_atomic_commit_tail() - AMDgpu DM's commit tail implementation.
  * @state: The atomic state to commit
@@ -7508,7 +7706,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		struct dc_stream_update stream_update;
 		struct dc_info_packet hdr_packet;
 		struct dc_stream_status *status = NULL;
-		bool abm_changed, hdr_changed, scaling_changed;
+		bool abm_changed, hdr_changed, scaling_changed, pixenc_changed;
 
 		memset(&dummy_updates, 0, sizeof(dummy_updates));
 		memset(&stream_update, 0, sizeof(stream_update));
@@ -7534,7 +7732,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		hdr_changed =
 			is_hdr_metadata_different(old_con_state, new_con_state);
 
-		if (!scaling_changed && !abm_changed && !hdr_changed)
+		pixenc_changed = dm_new_con_state->pixel_encoding !=
+				 dm_old_con_state->pixel_encoding;
+
+		if (!scaling_changed && !abm_changed && !hdr_changed && !pixenc_changed)
 			continue;
 
 		stream_update.stream = dm_new_crtc_state->stream;
@@ -7557,6 +7758,13 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			stream_update.hdr_static_metadata = &hdr_packet;
 		}
 
+		if (pixenc_changed) {
+			update_stream_for_pixel_encoding(&stream_update,
+				connector,
+				dm_old_crtc_state, dm_new_crtc_state,
+				dm_new_con_state);
+		}
+
 		status = dc_stream_get_status(dm_new_crtc_state->stream);
 		WARN_ON(!status);
 		WARN_ON(!status->plane_count);
@@ -7911,7 +8119,6 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 							     &new_crtc_state->mode,
 							     dm_new_conn_state,
 							     dm_old_crtc_state->stream);
-
 		/*
 		 * we can have no stream on ACTION_SET if a display
 		 * was disconnected during S3, in this case it is not an
@@ -8578,6 +8785,12 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		if (dm_old_con_state->abm_level !=
 		    dm_new_con_state->abm_level)
 			new_crtc_state->connectors_changed = true;
+
+		if (dm_old_con_state->pixel_encoding !=
+		    dm_new_con_state->pixel_encoding) {
+			new_crtc_state->connectors_changed = true;
+			new_crtc_state->mode_changed = true;
+		}
 	}
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index dd1559c743c2..e46bdd279d0f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -450,6 +450,7 @@ struct dm_connector_state {
 	uint8_t abm_level;
 	int vcpi_slots;
 	uint64_t pbn;
+	enum dc_pixel_encoding pixel_encoding;
 };
 
 #define to_dm_connector_state(x)\
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 92eb1ca1634f..24743ee9d9da 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1881,6 +1881,11 @@ static enum surface_update_type check_update_surfaces_for_stream(
 
 		if (stream_update->output_csc_transform || stream_update->output_color_space)
 			su_flags->bits.out_csc = 1;
+
+		if (stream_update->timing_for_pixel_encoding) {
+			su_flags->bits.pixel_encoding = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL);
+		}
 	}
 
 	for (i = 0 ; i < surface_count; i++) {
@@ -2183,6 +2188,10 @@ static void copy_stream_update_to_stream(struct dc *dc,
 			update->dsc_config = NULL;
 		}
 	}
+
+	if (update->timing_for_pixel_encoding) {
+		stream->timing = *update->timing_for_pixel_encoding;
+	}
 }
 
 static void commit_planes_do_stream_update(struct dc *dc,
@@ -2211,7 +2220,8 @@ static void commit_planes_do_stream_update(struct dc *dc,
 			if ((stream_update->hdr_static_metadata && !stream->use_dynamic_meta) ||
 					stream_update->vrr_infopacket ||
 					stream_update->vsc_infopacket ||
-					stream_update->vsp_infopacket) {
+					stream_update->vsp_infopacket ||
+					stream_update->timing_for_pixel_encoding) {
 				resource_build_info_frame(pipe_ctx);
 				dc->hwss.update_info_frame(pipe_ctx);
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index d9888f316da6..0e1ef24d8855 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -126,6 +126,7 @@ union stream_update_flags {
 		uint32_t gamut_remap:1;
 		uint32_t wb_update:1;
 		uint32_t dsc_changed : 1;
+		uint32_t pixel_encoding:1;
 	} bits;
 
 	uint32_t raw;
@@ -262,6 +263,7 @@ struct dc_stream_update {
 
 	struct dc_writeback_update *wb_update;
 	struct dc_dsc_config *dsc_config;
+	struct dc_crtc_timing *timing_for_pixel_encoding;
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 	struct dc_transfer_func *func_shaper;
 	struct dc_3dlut *lut3d_func;
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
