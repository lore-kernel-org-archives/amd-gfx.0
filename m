From: Adam Jackson <ajax-TAsg7VrFCGc@public.gmane.org>
Subject: Re: [PATCH v4 xserver 0/4] modesetting: add DRI2 page flip support
Date: Fri, 02 Sep 2016 14:01:39 -0400
Message-ID: <1472839299.2852.14.camel@nwnk.net>
References: <1471860858-25190-1-git-send-email-Qiang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xorg-devel-bounces-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
In-Reply-To: <1471860858-25190-1-git-send-email-Qiang.Yu-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.x.org/mailman/options/xorg-devel>,
 <mailto:xorg-devel-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.x.org/archives/xorg-devel>
List-Post: <mailto:xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:xorg-devel-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.x.org/mailman/listinfo/xorg-devel>,
 <mailto:xorg-devel-request-go0+a7rfsptAfugRpC6u6w@public.gmane.org?subject=subscribe>
Errors-To: xorg-devel-bounces-go0+a7rfsptAfugRpC6u6w@public.gmane.org
Sender: "xorg-devel" <xorg-devel-bounces-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
To: Qiang Yu <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>, xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org
Cc: michel-otUistvHUpPR7s880joybQ@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCAyMDE2LTA4LTIyIGF0IDE4OjE0ICswODAwLCBRaWFuZyBZdSB3cm90ZToKPiBIaSBn
dXlzLAo+IAo+IFRoaXMgcGF0Y2ggc2V0IGlzIGZvciBhZGRpbmcgRFJJMiBwYWdlIGZsaXAgc3Vw
cG9ydCB0byBtb2Rlc2V0dGluZwo+IGRyaXZlci4gSSBtYWlubHkgdGFrZSByZWZlcmVuY2Ugb2Yg
YW1kZ3B1IEREWCBhbmQgcmV1c2UgcHJlc2VudAo+IHBhZ2UgZmxpcCBjb2RlIGluIHRoZSBtb2Rl
c2V0dGluZyBkcml2ZXIuCgpyZW1vdGU6IEk6IHBhdGNoICMxMDY5MDIgdXBkYXRlZCB1c2luZyBy
ZXYgYTU4NmJmOWNjZjYwYjJjYzY2OTUzNTU1ZTgyZWViNmE4ZTBiNGNhOS4KcmVtb3RlOiBJOiBw
YXRjaCAjMTA1NTAyIHVwZGF0ZWQgdXNpbmcgcmV2IDRmMWViNzg2NGI2MWQwYzk5MmM1ZWZmMzMz
OTA4NWU4ODc3OTIwNDguCnJlbW90ZTogSTogcGF0Y2ggIzEwNjY0NiB1cGRhdGVkIHVzaW5nIHJl
diA0YTgzOWRhNjI3NGI3NjQyNGVlN2NiYzJkZWJhMjY5M2U5N2U4MTg2LgpyZW1vdGU6IEU6IGZh
aWxlZCB0byBmaW5kIHBhdGNoIGZvciByZXYgZjA2YWVmMzFjMGIyYWI2MmQ5MTVhNDY5YTM5OWQ4
MmExYTczYWMyOC4KcmVtb3RlOiBJOiAzIHBhdGNoKGVzKSB1cGRhdGVkIHRvIHN0YXRlIEFjY2Vw
dGVkLgpUbyBzc2g6Ly9naXQuZnJlZWRlc2t0b3Aub3JnL2dpdC94b3JnL3hzZXJ2ZXIKICAgN2Qz
M2FiMC4uZjA2YWVmMyAgbWFzdGVyIC0+IG1hc3RlcgoKLSBhamF4Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCnhvcmctZGV2ZWxAbGlzdHMueC5vcmc6IFgu
T3JnIGRldmVsb3BtZW50CkFyY2hpdmVzOiBodHRwOi8vbGlzdHMueC5vcmcvYXJjaGl2ZXMveG9y
Zy1kZXZlbApJbmZvOiBodHRwczovL2xpc3RzLngub3JnL21haWxtYW4vbGlzdGluZm8veG9yZy1k
ZXZlbA==
