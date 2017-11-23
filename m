From: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [amdgpu] script to generate a VCE 1.0 amdgpu compatible firmware
Date: Thu, 23 Nov 2017 00:53:24 -0500
Message-ID: <647a0989-7c2a-0dc8-c4c9-a20a661331d3@gmail.com>
Reply-To: alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-GB-large
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>

SGksCgpJIGp1c3Qgd2FudCB0byBsZXQgeW91IGtub3cgdGhhdCBJJ20gc3RpbGwgYWxpdmUgYW5k
IHN0aWxsIGNvbW1pdHRlZCB0bwpwb3J0aW5nIFZDRSAxLjAgZnJvbSByYWRlb24gdG8gYW1kZ3B1
LiBIb3dldmVyLCBmb3IgbWFueSByZWFzb25zLCBJJ3ZlCmJlZW4gcHJldHR5IG11Y2ggdW5hYmxl
IHRvIHdvcmsgb24gdGhlIGNvZGUgc2luY2UgbXkgbGFzdCBjb21tdW5pY2F0aW9uLgoKVGhhdCBi
ZWluZyBzYWlkLCBJJ3ZlIGNyZWF0ZWQgYSBzY3JpcHQgYmFzZWQgb24gUGlvdHIgUmVkbGV3c2tp
J3Mgd29yawp0byBnZW5lcmF0ZSBhIGNvbXBhdGlibGUgVkNFIDEuMCBmaXJtd2FyZSB3aXRoIGFt
ZGdwdS4gVGhlIHNjcmlwdCBjYW4gYmUKZm91bmQgb24gR2l0aHViR2lzdDoKaHR0cHM6Ly9naXN0
LmdpdGh1Yi5jb20vT3hhbGluL2JhOWFhOWMxYzE5MTJlNjhmNzZkYWRjYWQ0MzZkMWE0CgpOb3cs
IEkndmUgcmVhZCB0aGUgcGF0Y2hzZXQgc2VudCBieSBSZWRsZXdza2kgZm9yIGFkZGluZyBVVkQg
b24gR0NOIDEKZGV2aWNlcy4gQ2hyaXN0aWFuLCBzaW5jZSB5b3Ugd2VyZSB0byBzZWUgaWYgQU1E
IGNvdWxkIHJlbGVhc2UgYSBuZXcgVVZECmZpcm13YXJlIHdpdGggaGVhZGVyIGFuZCBjb3JyZWN0
IDQwYml0IGFkZHJlc3NpbmcsIGNvdWxkIHlvdSBhc2sgaWYgYW4Kb2ZmaWNpYWwgVkNFIDEuMCBm
aXJtd2FyZSB3aXRoIGFuIG9mZmljaWFsIGhlYWRlciAoYW5kIHdoYXRldmVyIGVsc2UKY291bGQg
YmUgbmVlZGVkKSBiZSByZWxlYXNlZCBhdCB0aGUgc2FtZSB0aW1lPwoKQ2hlZXJzCgotLSAKQWxl
eGFuZHJlIERlbWVycwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
