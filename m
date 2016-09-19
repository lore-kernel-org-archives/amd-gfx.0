From: Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH] drm/amd/powerplay/smumgr: mark symbols static where
 possible
Date: Mon, 19 Sep 2016 15:43:46 +0800
Message-ID: <20160919074345.GA4278@hr-amur2>
References: <1474270119-8500-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1474270119-8500-1-git-send-email-baoyou.xie@linaro.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Baoyou Xie <baoyou.xie@linaro.org>, amd-gfx@lists.freedesktop.org
Cc: nils.wallmenius@gmail.com, arnd@arndb.de, Jammy.Zhou@amd.com, funfunctor@folklore1984.net, xie.baoyou@zte.com.cn, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, JinHuiEric.Huang@amd.com, Young.Yang@amd.com, alexander.deucher@amd.com, Qingqing.Wang@amd.com, Flora.Cui@amd.com, Rex.Zhu@amd.com, christian.koenig@amd.com, Monk.Liu@amd.com
List-Id: amd-gfx.lists.freedesktop.org

SGkgQmFveW91LAoKT24gTW9uLCBTZXAgMTksIDIwMTYgYXQgMDM6Mjg6MzlQTSArMDgwMCwgQmFv
eW91IFhpZSB3cm90ZToKPiBXZSBnZXQgYSBmZXcgd2FybmluZ3Mgd2hlbiBidWlsZGluZyBrZXJu
ZWwgd2l0aCBXPTE6Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG93ZXJwbGF5L3Nt
dW1nci90b25nYV9zbXVtZ3IuYzoxNDY6NTogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBl
IGZvciAndG9uZ2FfcHJvZ3JhbV9qdW1wX29uX3N0YXJ0JyBbLVdtaXNzaW5nLXByb3RvdHlwZXNd
Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG93ZXJwbGF5L3NtdW1nci9maWppX3Nt
dW1nci5jOjgxNjo1OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yICdmaWppX3Nh
dmVfdmZ0X3RhYmxlJyBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCj4gZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvLi4vcG93ZXJwbGF5L3NtdW1nci9wb2xhcmlzMTBfc211bWdyLmM6NzQzOjU6IHdh
cm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3IgJ3BvbGFyaXMxMF9hdmZzX2V2ZW50X21n
cicgWy1XbWlzc2luZy1wcm90b3R5cGVzXQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4u
L3Bvd2VycGxheS9zbXVtZ3IvaWNlbGFuZF9zbXVtZ3IuYzoxNjc6NTogd2FybmluZzogbm8gcHJl
dmlvdXMgcHJvdG90eXBlIGZvciAnaWNlbGFuZF9wcm9ncmFtX2p1bXBfb25fc3RhcnQnIFstV21p
c3NpbmctcHJvdG90eXBlc10KPiAuLi4uCj4gCj4gSW4gZmFjdCwgdGhlc2UgZnVuY3Rpb25zIGFy
ZSBvbmx5IHVzZWQgaW4gdGhlIGZpbGUgaW4gd2hpY2ggdGhleSBhcmUKPiBkZWNsYXJlZCBhbmQg
ZG9uJ3QgbmVlZCBhIGRlY2xhcmF0aW9uLCBidXQgY2FuIGJlIG1hZGUgc3RhdGljLgo+IFNvIHRo
aXMgcGF0Y2ggbWFya3MgdGhlc2UgZnVuY3Rpb25zIHdpdGggJ3N0YXRpYycuCj4gCgorIGFtZC1n
ZnggbWFpbCBsaXN0LgoKVGhhbmtzIHRvIHlvdXIgcGF0Y2guIEJ1dCBwb3dlcnBsYXkgcGFydCBp
cyByZWZhY3RvcmVkIHJlY2VudGx5IGJlbG93LCBzb21lCmZ1bmN0aW9ucyBhcmUgYWxyZWFkeSB1
cGRhdGVkLiBTbyB5b3UgbWlnaHQgbmVlZCByZWJhc2UgdGhlbS4gOi0pCgpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9hcmNoaXZlcy9hbWQtZ2Z4LzIwMTYtU2VwdGVtYmVyLzAwMjExOC5o
dG1sCgpUaGFua3MsClJ1aQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmkt
ZGV2ZWwK
