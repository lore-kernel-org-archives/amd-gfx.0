From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] udev_monitor_receive_device() will block when hotplug
 monitor
Date: Wed, 14 Dec 2016 12:03:10 +0900
Message-ID: <056cefae-e2c6-7cd7-c7fd-461e1cb8bf25@daenzer.net>
References: <1481618006-29239-1-git-send-email-Jim.Qu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1481618006-29239-1-git-send-email-Jim.Qu-5C7GfCeVMHo@public.gmane.org>
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
To: jimqu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTMvMTIvMTYgMDU6MzMgUE0sIGppbXF1IHdyb3RlOgo+IHVkZXZfbW9uaXRvcl9yZWNlaXZl
X2RldmljZSgpIHdpbGwgYmxvY2sgYW5kIHdhaXQgZm9yIHRoZSBldmVudCBvZiB1ZGV2Cj4gdXNl
IHNlbGVjdCgpIHRvIGVuc3VyZSB0aGF0IHRoaXMgd2lsbCBub3QgYmxvY2suCj4gCj4gQ2hhbmdl
LUlkOiBJNGU4ZjQ2Mjk1ODAyMjJlOTRmNTVhNGMwMzA3MDc0MWJmNWY0MDI0Ywo+IFNpZ25lZC1v
ZmYtYnk6IEppbVF1IDxKaW0uUXVAYW1kLmNvbT4KClJldmlld2VkIGFuZCBwdXNoZWQsIHRoYW5r
cyEKCgpQLlMuIFBsZWFzZSBydW4KCmdpdCBjb25maWcgLS1nbG9iYWwgdXNlci5uYW1lICJKaW0g
UXUiCmdpdCBjb25maWcgZW1haWwucHJlZml4ICJQQVRDSCAkKGJhc2VuYW1lICRQV0QpIgoKaW4g
eW91ciBHaXQgdHJlZS4KCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1
c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
