From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] drm/amd/powerplay: Fix missing break in switch
Date: Tue, 29 Jan 2019 00:35:15 +0000
Message-ID: <20190129003516.65C2320870__21498.2935738348$1548722128$gmane$org@mail.kernel.org>
References: <20190125215533.GA4878@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190125215533.GA4878@embeddedor>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sasha Levin <sashal@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>
Cc: stable@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

SGksCgpbVGhpcyBpcyBhbiBhdXRvbWF0ZWQgZW1haWxdCgpUaGlzIGNvbW1pdCBoYXMgYmVlbiBw
cm9jZXNzZWQgYmVjYXVzZSBpdCBjb250YWlucyBhICJGaXhlczoiIHRhZywKZml4aW5nIGNvbW1p
dDogY2Q3MGYzZDZlM2ZhIGRybS9hbWQvcG93ZXJwbGF5OiBQUC9EQUwgaW50ZXJmYWNlIGNoYW5n
ZXMgZm9yIGR5bmFtaWMgY2xvY2sgc3dpdGNoLgoKVGhlIGJvdCBoYXMgdGVzdGVkIHRoZSBmb2xs
b3dpbmcgdHJlZXM6IHY0LjIwLjUsIHY0LjE5LjE4LCB2NC4xNC45Ni4KCnY0LjIwLjU6IEJ1aWxk
IE9LIQp2NC4xOS4xODogQnVpbGQgT0shCnY0LjE0Ljk2OiBGYWlsZWQgdG8gYXBwbHkhIFBvc3Np
YmxlIGRlcGVuZGVuY2llczoKICAgIFVuYWJsZSB0byBjYWxjdWxhdGUKCgpIb3cgc2hvdWxkIHdl
IHByb2NlZWQgd2l0aCB0aGlzIHBhdGNoPwoKLS0KVGhhbmtzLApTYXNoYQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0
CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
