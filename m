From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH AUTOSEL 4.19 044/167] drm/amdgpu: validate user pitch
 alignment
Date: Tue, 3 Sep 2019 18:40:43 +0200
Message-ID: <7957107d-634f-4771-327e-99fdd5e6474e@daenzer.net>
References: <20190903162519.7136-1-sashal@kernel.org>
 <20190903162519.7136-44-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190903162519.7136-44-sashal@kernel.org>
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
To: Sasha Levin <sashal@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOS0wOS0wMyA2OjIzIHAubS4sIFNhc2hhIExldmluIHdyb3RlOgo+IEZyb206IFl1IFpo
YW8gPHl1emhhb0Bnb29nbGUuY29tPgo+IAo+IFsgVXBzdHJlYW0gY29tbWl0IDg5ZjIzYjZlZmVm
NTU0NzY2MTc3YmY1MWFhNzU0YmNlMTRjM2U3ZGEgXQoKSG9sZCB5b3VyIGhvcnNlcyEKClRoaXMg
Y29tbWl0IGFuZCBjNGEzMmIyNjZkYTdiYjcwMmU2MDM4MWNhMGMzNWVhZGRiYzg5YTZjIGhhZCB0
byBiZQpyZXZlcnRlZCwgYXMgdGhleSBjYXVzZWQgcmVncmVzc2lvbnMuIFNlZSBjb21taXRzCjI1
ZWM0MjllODZiYjc5MGU0MDM4N2E1NTBmMDUwMWQwYWM1NWE0N2MgJgo5MmIwNzMwZWFmMmQ1NDlm
ZGZiMTBlY2M4YjcxZjM0YjlmNDcyYzEyIC4KCgpUaGlzIGlzbid0IGJvbHN0ZXJpbmcgY29uZmlk
ZW5jZSBpbiBob3cgdGhlc2UgcGF0Y2hlcyBhcmUgc2VsZWN0ZWQuLi4KSSdtIGFsc28gYSBsaXR0
bGUgbmVydm91cyBhYm91dCBvdGhlcnMgd2hpY2ggY2hhbmdlIHZhbHVlcyBieSBhbiBvcmRlcgpv
ZiBtYWduaXR1ZGUuIFRoZXJlIHdlcmUgY2FzZXMgYmVmb3JlIHdoZXJlIHN1Y2ggcGF0Y2hlcyB3
ZXJlIGJhY2twb3J0ZWQKdG8gYnJhbmNoZXMgd2hpY2ggZGlkbid0IGhhdmUgb3RoZXIgY29ycmVz
cG9uZGluZyBjaGFuZ2VzLCBzbyB0aGV5IGVuZGVkCnVwIGJyZWFraW5nIHN0dWZmIGluc3RlYWQg
b2YgZml4aW5nIGFueXRoaW5nLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAg
ICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cHM6Ly9yZWRoYXQuY29tCkxpYnJlIHNvZnR3YXJl
IGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Bl
cgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2
ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
