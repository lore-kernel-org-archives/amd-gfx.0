From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH AUTOSEL 4.20 034/117] drm/amdgpu: Correct
 get_crtc_scanoutpos behavior when vpos >= vtotal
Date: Wed, 9 Jan 2019 10:20:49 +0100
Message-ID: <199e52c4-7e19-03c0-2d60-c638dda86bd4@daenzer.net>
References: <20190108192628.121270-1-sashal@kernel.org>
 <20190108192628.121270-34-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190108192628.121270-34-sashal@kernel.org>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOS0wMS0wOCA4OjI1IHAubS4sIFNhc2hhIExldmluIHdyb3RlOgo+IEZyb206IE5pY2hv
bGFzIEthemxhdXNrYXMgPG5pY2hvbGFzLmthemxhdXNrYXNAYW1kLmNvbT4KPiAKPiBbIFVwc3Ry
ZWFtIGNvbW1pdCA1MjBmMDhkZjQ1ZmJlMzAwZWQ2NTBkYTc4NmE3NDA5M2Q2NThiN2UxIF0KPiAK
PiBXaGVuIHZhcmlhYmxlIHJlZnJlc2ggcmF0ZSBpcyBhY3RpdmUgWy4uLl0KClZhcmlhYmxlIHJl
ZnJlc2ggcmF0ZSAoRnJlZVN5bmMpIHN1cHBvcnQgaXMgb25seSBsYW5kaW5nIGluIDUuMCwKdGhl
cmVmb3JlIHRoaXMgZml4IGlzbid0IG5lZWRlZCBpbiBvbGRlciBrZXJuZWxzLgoKCi0tIApFYXJ0
aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDov
L3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAg
ICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcmktZGV2ZWwK
