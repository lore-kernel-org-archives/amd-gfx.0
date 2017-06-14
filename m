From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: syncobj wait patch
Date: Wed, 14 Jun 2017 12:02:24 +1000
Message-ID: <20170614020225.24654-1-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

SSdtIGdvaW5nIHRvIHB1c2ggdGhlIHN5bmNvYmogYW5kIHN5bmNfZmlsZSBpbnRlcmFjdGlvbiAK
cGF0Y2hlcyBpbnRvIGRybS1uZXh0LCBidXQgSSB0aGluayB0aGlzIHBhdGNoIHN0aWxsIG5lZWRz
CmEgZmV3IG1vcmUgdHJpcHMgb24gdGhlIG1lcnJ5IGdvIHJvdW5kLgoKSSd2ZSBkZWNpZGVkIHRv
IHJlYWQgRGFuaWVsJ3MgaW9jdGwgZ3VpZGUsIHVzZSBzZWMvbnNlYywKYW5kIGNvbnZlcnQgdG8g
dGltZXNwZWMgaW50ZXJuYWxseSB0aGVuIHVzZSB0aW1lc3BlYyBhcyBtdWNoCmFzIHBvc3NpYmxl
LgoKRGF2ZS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
