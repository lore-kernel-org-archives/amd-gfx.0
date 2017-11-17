From: Feifei Xu <feifxu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amd/include:cleanup vega10 hdp header files.
Date: Fri, 17 Nov 2017 12:38:39 +0800
Message-ID: <73edd3c9-6fd4-b6c0-8c3a-b1b753df849b@amd.com>
References: <1510819404-4543-1-git-send-email-Feifei.Xu@amd.com>
 <1510819404-4543-2-git-send-email-Feifei.Xu@amd.com>
 <999d4551-7032-b5a4-0775-43bbad024049@gmail.com>
 <DM5PR12MB17694F9575D58E3CB0DA2E81FE2E0@DM5PR12MB1769.namprd12.prod.outlook.com>
 <972ef372-bf2b-c0d2-836b-8fde6c88bff3@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <972ef372-bf2b-c0d2-836b-8fde6c88bff3-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Xu, Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

CgpPbiAxMS8xNy8yMDE3IDEyOjAxIEFNLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPiBPbiAxNi8x
MS8xNyAxMToyOSBBTSwgWHUsIEZlaWZlaSB3cm90ZToKPj4gUmVzZW50IHRoZSBwYXRjaCAjMSwg
eWVzLCBpdCBpcyB0b28gbGFyZ2UgZHVlIHRvIHRoZSBoZWFkZXIgZmlsZSBtb3ZlbWVudC4KPj4g
QW5kIEkgd2lsbCBzZW5kIHRoZSBjb21pbmcgY2xlYW51cCBwYXRjaGVzIHNlcGFyYXRlbHkgdG8g
YXZvaWQgbWVzc2FnZSBkcm9wcGluZy4KPiBUaGVyZSdzIG5vIG5lZWQgZm9yIGFueWJvZHkgdG8g
ZG93bmxvYWQgbWVnYWJ5dGVzIG9mIGUtbWFpbCBmb3IgcGF0Y2hlcwo+IHdoaWNoIGp1c3QgKHJl
KW1vdmUgZmlsZXMuIFBsZWFzZSB0cnkgZmxhZ3Mgc3VjaCBhcyAtLWZpbmQtcmVuYW1lcyAvCj4g
LS1pcnJldmVyc2libGUtZGVsZXRlIHdpdGggZ2l0IGZvcm1hdC1wYXRjaC4KPgo+ClRoYW5rcy4g
VG8gYXZvaWQgZHVwbGljYXRpb24gb2YgaGVhZGVyIGZpbGVzLCBhIGxvdCBvZiBoZWFkZXIgZmls
ZXMgd2lsbCAKYmUgcmUvbW92ZWQuCkkgd2lsbCBzZW5kIG91dCBmb2xsb3dpbmcgY2xlYW51cCBw
YXRjaGVzIGFzIHN1Z2dlc3RlZCB0byBhdm9pZCBodWdlIApwYXRjaGVzIGZsdXNoLgoKLS0gCi1G
ZWlmZWkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
