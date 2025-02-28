Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AC3C282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 13:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79E8910E42C;
	Mon,  3 Mar 2025 13:58:04 +0000 (UTC)
X-Greylist: delayed 811 seconds by postgrey-1.36 at gabe;
 Fri, 28 Feb 2025 15:59:34 UTC
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5389D10ECE9
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 15:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1740758371; x=1741363171; i=markus.elfring@web.de;
 bh=GcdKCf558++2vu5m7gIvfuqBTLz7S1RpSdIWX3ae9fw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=bSqbBUylKthcEwHdN8Snx6/afY8TR9cAcGF8T2AfLezl3tJcWn3o/zlyCWdsqqSx
 yF/90Y+/e47qL1+9WioMD3Lku/WrsrYMqOEtonfWen6JGSDr+XRA3gMlvbHCfCcmP
 0JBX+SCkK7OXTtWRfd4Jr1a7fJXn+P3tud3841OygAtzDZCeSdoRo53t62svSIppl
 yMOkXgUxgtdkIV8AiyJMa0rdm//6rXJmZe5k1Cbf66Uj46uo4YnekJGT4EAFW+suL
 8lnvdOlb7MYEa9a89aQyElidl2kkC0U1dxPYDFv8Bep0eBrE30mLVaJX2mw10zK3h
 4YiNolOBFUn0iLNBDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.27]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MS17h-1thfiL4BYZ-00Umnj; Fri, 28
 Feb 2025 16:45:55 +0100
Message-ID: <9574279b-6e02-467c-8e0f-28a037e061d9@web.de>
Date: Fri, 28 Feb 2025 16:45:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Boyuan Zhang
 <boyuan.zhang@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>,
 Ma Jun <Jun.Ma2@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Sunil Khatri <sunil.khatri@amd.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Qasim Ijaz <qasdev00@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/amdgpu: Simplify maximum determination in
 si_calc_upll_dividers()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6tzxbNamT2aPgHgoiVfifWqE5cSnMfgN/z4TiYhCFMyrRahLu1+
 q1i3Zv9l20qaiEfl5hKVEsg41xdcfWn2gpa1qMuyaE9kc8GlSzbmTnWeLflPgmUBNei33vn
 YUb0xv7PyLuJlxYeIcRKtOi2iRIgPxqAtCgCxCM3c+mRJmAr+W/Hf4nNuA1hv97DM9t6a0o
 eFHJegx6AhnsXQ9OilIhA==
UI-OutboundReport: notjunk:1;M01:P0:tyzpg2d/ym8=;3wANVc6ZkILcAj+X+P8hIdgSSCq
 EU+Ir+ZcehT4TircFzddcj1sZtqs/m08AC/gYZU1FLWvX2WET+8lDxdcvHiUFEF2mbLzGC+Vu
 hzzYSFoKCM3ZnULAea6tHkYeywfKnwUaNopuAAS7WKI848Y9OCf7YGTYgJvybEgTj+SoFuaQJ
 ct3Az7Zdex9Dapj1cHgXvOM06qRRXGj/VY873wiDw9llzDeaHPwaSUX5et6yuvXnafLTWM6YN
 zJwJkDYPABK1tszRaSHngowBLKIgkrm9z501FM0clrWzxxwLIAjxA8g3Mx9/zro3rdyTToIcZ
 ghsysNB7GoDWDg9YaWssA2jIr4qBVV3G3x+k8+uEwuzgBjQhR+2Ah52n24d2MRg6lzoHQn7t1
 18R6kmO8ovz6pC89mwYzubwNrikb0NoghR35EKyC/8ZILuTY7tlMPfXNvG5rarPqEymS0B5iJ
 7CUud169OkgIhrOL9AORutzYGMS9UKeN6b9DjkmGVNINS3BGYHoyXVJqbZMz8S982xwuxrg09
 c/TeXQ4/CLAPhky3DYDk66YSndn+VbuwKqPvnJlSNsiqV/ja8GHTo2nfs6bfcmQq60t6t+/Ss
 YYxJidk04K3UfBPq8O6kBQh7e3tx+pv0tyS0wPnTs7q4DGL7OWbhUNojVfyh3qvfDy6w/JgcC
 x6YbsbPU8fviMwpWlxD8iUEwjNOVhg6vsqwhXbdqJuk5uOi2edMcSSYLlAC+JW/qCr2m5lY3R
 bEFzsLk4lV3mXGSjEF78iDe5bA035lCKfxCKoW8SR9TId03M0uZ8gTYOS3rGZUzqrPDmqBrzv
 Lbrr9zyfn5ddwYktRiFfS6Nw7EgiTO7XFEU/49wDMmEis3XF6gUjuwCk25/XDBcW/PF6VfdKY
 alKpj+qaahtKdjE2h8aYzkh2fT0Gl523Y7F8cRMe0R5R9Vcy0A360H7cBZe9osxSiTmaeDud8
 Fas9OEuYNYjXBQMo//DgPnhi03EYTnWXtr3PF5rxJmu4BjoXVIFXWhgYxwtz5vHHkaauSHR3s
 mMmDGZm8sofdVXhSoaA7uLVX0sH7iEG1QqP95X/zSTNE/2vVbY8QVxfYVBVNflZ2bLsL6cWZ5
 n046U0os28EmDTD3F162FoLigqt2et9DydZ9f12+oKsy+ntqWB3cblPH5mIa+5daW3HCEzXDu
 NdVg0aHuNpXVTlh5MHxLNsaZUjTuxvCRFDd0NTVPj+rUmIpinpFmD27B8G6ZFBfa3s1mlWmEw
 +8e+SD8X/YHo24b6RV1VCeYBL4uo+Uy6FBMbrxv0+WK9yGPN6cVIFmuYcDVrb9e4457SXEh5j
 91tXt6qBOrzRqD5wKTP/+l3MX+UhHwq3zL8VNwMEnvQcW6hXnSKZqVuBpX6iL0MzdAPEtKmCP
 v7adPZkelzNq550ey/j3XBnbQq9bbRbjUByLA/EWWiPnaQ01FdimHFU9brJJAtTdbmAWalawU
 QL+pmIg==
X-Mailman-Approved-At: Mon, 03 Mar 2025 13:58:00 +0000
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 28 Feb 2025 16:37:00 +0100

Replace nested max() calls by single max3() call in this
function implementation.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/amd/amdgpu/si.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/=
si.c
index 026e8376e2c0..2a255fb15768 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1726,7 +1726,7 @@ static int si_calc_upll_dividers(struct amdgpu_devic=
e *adev,
 	unsigned optimal_score =3D ~0;

 	/* Loop through vco from low to high */
-	vco_min =3D max(max(vco_min, vclk), dclk);
+	vco_min =3D max3(vco_min, vclk, dclk);
 	for (vco_freq =3D vco_min; vco_freq <=3D vco_max; vco_freq +=3D 100) {
 		uint64_t fb_div =3D (uint64_t)vco_freq * fb_factor;
 		unsigned vclk_div, dclk_div, score;
=2D-
2.48.1

