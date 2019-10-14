From: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/radeon: Fix EEH during kexec"
Date: Mon, 14 Oct 2019 03:54:22 +0000
Message-ID: <20191014035423.30DCD2083B__26157.6935112075$1571025275$gmane$org@mail.kernel.org>
References: <20191009181503.20381-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191009181503.20381-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, kmahlkuc-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

SGksCgpbVGhpcyBpcyBhbiBhdXRvbWF0ZWQgZW1haWxdCgpUaGlzIGNvbW1pdCBoYXMgYmVlbiBw
cm9jZXNzZWQgYmVjYXVzZSBpdCBjb250YWlucyBhIC1zdGFibGUgdGFnLgpUaGUgc3RhYmxlIHRh
ZyBpbmRpY2F0ZXMgdGhhdCBpdCdzIHJlbGV2YW50IGZvciB0aGUgZm9sbG93aW5nIHRyZWVzOiBh
bGwKClRoZSBib3QgaGFzIHRlc3RlZCB0aGUgZm9sbG93aW5nIHRyZWVzOiB2NS4zLjUsIHY1LjIu
MjAsIHY0LjE5Ljc4LCB2NC4xNC4xNDgsIHY0LjkuMTk2LCB2NC40LjE5Ni4KCnY1LjMuNTogQnVp
bGQgT0shCnY1LjIuMjA6IEJ1aWxkIE9LIQp2NC4xOS43ODogQnVpbGQgT0shCnY0LjE0LjE0ODog
QnVpbGQgT0shCnY0LjkuMTk2OiBCdWlsZCBPSyEKdjQuNC4xOTY6IEZhaWxlZCB0byBhcHBseSEg
UG9zc2libGUgZGVwZW5kZW5jaWVzOgogICAgNmY3ZmU5YTkzZTZjMCAoImRybS9yYWRlb246IEZp
eCBFRUggZHVyaW5nIGtleGVjIikKICAgIGE0ODFkYWE4OGZkNGQgKCJkcm0vcmFkZW9uOiBhbHdh
eXMgYXBwbHkgcGNpIHNodXRkb3duIGNhbGxiYWNrcyIpCiAgICBhODAxYWJlNDc3M2RhICgiZHJt
L3JhZGVvbjogd2lyZSB1cCBhIHBjaSBzaHV0ZG93biBjYWxsYmFjayIpCiAgICBiOWI0ODdlNDk0
NzEyICgiUmV2ZXJ0ICJkcm0vcmFkZW9uOiBhbHdheXMgYXBwbHkgcGNpIHNodXRkb3duIGNhbGxi
YWNrcyIiKQoKCk5PVEU6IFRoZSBwYXRjaCB3aWxsIG5vdCBiZSBxdWV1ZWQgdG8gc3RhYmxlIHRy
ZWVzIHVudGlsIGl0IGlzIHVwc3RyZWFtLgoKSG93IHNob3VsZCB3ZSBwcm9jZWVkIHdpdGggdGhp
cyBwYXRjaD8KCi0tIApUaGFua3MsClNhc2hhCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
