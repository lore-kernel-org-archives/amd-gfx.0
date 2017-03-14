From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH libdrm] libdrm/amdgpu: add interface for kernel semaphores
Date: Tue, 14 Mar 2017 12:52:20 +1000
Message-ID: <CAPM=9tzegdtiyEmbW+PqmVeQ+bXrNtrdKXuE3kB0dPMKnMir+Q@mail.gmail.com>
References: <20170314005054.7487-1-airlied@gmail.com>
 <20170314005054.7487-2-airlied@gmail.com>
 <58C74ECE.3090703@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <58C74ECE.3090703@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: zhoucm1 <david1.zhou@amd.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Mao,
 David" <David.Mao@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMTQgTWFyY2ggMjAxNyBhdCAxMjowMCwgemhvdWNtMSA8ZGF2aWQxLnpob3VAYW1kLmNvbT4g
d3JvdGU6Cj4gSGkgRGF2ZSwKPgo+IENvdWxkIHlvdSB0ZWxsIG1lIHdoeSB5b3UgY3JlYXRlIHlv
dXIgbmV3IG9uZSBwYXRjaD8gSSByZW1lbWJlciBJIHNlbmQgb3V0Cj4gb3VyIHRoZSB3aG9sZSBp
bXBsZW1lbnRhdGlvbiwgV2h5IG5vdCBkaXJlY3RseSByZXZpZXcgb3VyIHBhdGNoZXM/CgpUaGlz
IGlzIHBhdGNoIHJldmlldywgSSdtIG5vdCBzdXJlIHdoYXQgeW91IGFyZSBleHBlY3RpbmcgaW4g
dGVybXMgb2YKZGlyZWN0IHJldmlldy4KClRoZSBwYXRjaGVzIHlvdSBzZW50IG91dCB3ZXJlIHJl
dmlld2VkIGJ5IENocmlzdGlhbiwgaGUgc3RhdGVkIGhlCnRoaW5rcyB0aGlzIHNob3VsZAp1c2Ug
c3luY19maWxlLCBJIHdhcyBpbnRlcmVzdGVkIHRvIHNlZSBpZiB0aGlzIHdhcyBhY3R1YWxseSBw
b3NzaWJsZSwKc28gSSBqdXN0IGFkYXB0ZWQKdGhlIHBhdGNoZXMgdG8gY2hlY2sgaWYgaXQgd2Fz
IHBvc3NpYmxlIHRvIGF2b2lkIGFkZGluZyBhIGxvdCBvZiBhbWQKc3BlY2lmaWMgY29kZQpmb3Ig
c29tZXRoaW5nIHRoYXQgaXNuJ3QgcmVxdWlyZWQgdG8gYmUuIEhlbmNlIHdoeSBJJ3ZlIHNlbnQg
dGhpcyBhcwphbiByZmMsIGFzIEkgd2FudAp0byBzZWUgaWYgb3RoZXJzIHRoaW5rIHVzaW5nIHN5
bmNfZmlsZSBpcyBhIGdvb2Qgb3IgYmFkIGlkZWEuIFdlIG1heQplbmQgdXAgZ29pbmcKYmFjayB0
byB0aGUgbm9uLXN5bmNfZmlsZSBiYXNlZCBwYXRjaGVzIGlmIHRoaXMgcHJvdmVzIHRvIGJlIGEg
YmFkCmlkZWEsIHNvIGZhciBpdApkb2Vzbid0IGxvb2sgbGlrZSBvbmUuCgpJIGFsc28gcmV2aWV3
ZWQgdGhlIHBhdGNoZXMgYW5kIG5vdGVkIGl0IHNob3VsZG4ndCBhZGQgdGhlIHdhaXQvc2lnbmFs
CmludGVyZmFjZXMsCnRoYXQgaXQgc2hvdWxkIHVzZSB0aGUgY2h1bmtzIG9uIGNvbW1hbmQgc3Vi
bWlzc2lvbiwgc28gd2hpbGUgSSB3YXMgaW4KdGhlcmUgSSByZQp3cm90ZSB0aGF0IGFzIHdlbGwu
CgpEYXZlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpk
cmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
