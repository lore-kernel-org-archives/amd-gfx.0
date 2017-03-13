From: Umang Raghuvanshi <u@umangis.me>
Subject: [PATCH 0/1] drm/radeon: Fix GPU lockups for the R7 M270
Date: Mon, 13 Mar 2017 13:49:52 +0530
Message-ID: <20170313081953.8306-1-u@umangis.me>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0251256944=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: David Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Umang Raghuvanshi <u@umangis.me>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format...

--===============0251256944==
Content-type: multipart/alternative; boundary="----------=_1489393179-6294-60"

This is a multi-part message in MIME format...

------------=_1489393179-6294-60

The AMD Radeon R7 M270 card's OpenGL functionality completely broke down in
Linux kernel v4.10. Before v4.10, the card was incorrectly identified as a
Radeon R7 M265 but worked perfectly (possibly due to the similarities between
the two). It should also be noted that this issue is also present in Windows
but is fixed by a vendor-specific driver by AMD which hasn't made its way to
Linux yet.

After bisecting between the v4.9 and v4.10 tags, I discovered that the commit
3a69adfe5617 ("drm/radeon: drop oland quirks") was the culprit. Due to what I
assume as lack of firmware support for the chip, the quirks which were
addressed in the firmware never made it to the card resulting in this.

Specifically, when an OpenGL app was run with DRI_PRIME=1, the GPU would stall
and the kernel logs would fill up with messages like the following:

"GPU lockup (current fence id 0x0000000010e5 last fence id 0x10ed on ring 0)"
"ring 3 stalled for more than 40952msec"

This issue would crop up everytime DRI_PRIME=1 was used and is present across
various applications - everything from natively supported games to glxgears.
When the aforementioned stall would happen, the screen would freeze and the
only solution would be to restart the X server altogether.

The attached commit reverts this change only for the M270 (the values for
identifying it were obtained experimentally and checked across different PCs).
It fixes the issue completely but I strongly believe that a firmware patch
would be a *much* better solution.

Should the need arise, I am willing to provide any additional information that
would help fix this issue.

Umang Raghuvanshi (1):
  drm/radeon: Fix GPU lockups for the R7 M270

 drivers/gpu/drm/radeon/si_dpm.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.12.0

--
Cheers,
Umang Raghuvanshi.

------------=_1489393179-6294-60
Content-Type: text/html
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

<html><body>
<p>The AMD Radeon R7 M270 card's OpenGL functionality completely broke down=
 in Linux kernel v4.10. Before v4.10, the card was incorrectly identified a=
s a Radeon R7 M265 but worked perfectly (possibly due to the similarities b=
etween the two). It should also be noted that this issue is also present in=
 Windows but is fixed by a vendor-specific driver by AMD which hasn't made =
its way to Linux yet.</p>
<p>After bisecting between the v4.9 and v4.10 tags, I discovered that the c=
ommit 3a69adfe5617 (&quot;drm/radeon: drop oland quirks&quot;) was the culp=
rit. Due to what I assume as lack of firmware support for the chip, the qui=
rks which were addressed in the firmware never made it to the card resultin=
g in this.</p>
<p>Specifically, when an OpenGL app was run with DRI_PRIME=3D1, the GPU wou=
ld stall and the kernel logs would fill up with messages like the following=
:</p>
<p>&ldquo;GPU lockup (current fence id 0x0000000010e5 last fence id 0x10ed =
on ring 0)&rdquo; &ldquo;ring 3 stalled for more than 40952msec&rdquo;</p>
<p>This issue would crop up everytime DRI_PRIME=3D1 was used and is present=
 across various applications &ndash; everything from natively supported gam=
es to glxgears. When the aforementioned stall would happen, the screen woul=
d freeze and the only solution would be to restart the X server altogether.=
</p>
<p>The attached commit reverts this change only for the M270 (the values fo=
r identifying it were obtained experimentally and checked across different =
PCs). It fixes the issue completely but I strongly believe that a firmware =
patch would be a <strong>much</strong> better solution.</p>
<p>Should the need arise, I am willing to provide any additional informatio=
n that would help fix this issue.</p>
<p>Umang Raghuvanshi (1):</p>
<pre>drm/radeon: Fix GPU lockups for the R7 M270</pre>
<pre>drivers/gpu/drm/radeon/si_dpm.c | 5 +++++
1 file changed, 5 insertions(+)</pre>
<p>&mdash; 2.12.0</p>
<p>&mdash; Cheers, Umang Raghuvanshi.</p>

<img src=3D"https://u4914032.ct.sendgrid.net/wf/open?upn=3DfsWdnASKOjVAY-2B=
ZFE2xi1fwAZcbRCnZQ5h6lQPrK11KnK8deIHF2HWde0VQyn86x66Q1ptdh0T2zTOhFPY-2BEPXi=
PKNsX9zjOw48lpqYYpTKQkZFk2kkYZXhDCbKfocZqsIEoMJoDLlQ5LwgE1aql8lX8bfqyjoBVYt=
cbbcTOxg6MvQtHymzJL4M4M0RQQwoSQupr2PWWo3xMiJ-2B69moKJG8-2Fsny9A3S0cooHilRjf=
NQ-3D" alt=3D"" width=3D"1" height=3D"1" border=3D"0" style=3D"height:1px !=
important;width:1px !important;border-width:0 !important;margin-top:0 !impo=
rtant;margin-bottom:0 !important;margin-right:0 !important;margin-left:0 !i=
mportant;padding-top:0 !important;padding-bottom:0 !important;padding-right=
:0 !important;padding-left:0 !important;"/>
</body></html>

------------=_1489393179-6294-60--

--===============0251256944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0251256944==--
