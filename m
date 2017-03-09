From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Shared semaphores for amdgpu
Date: Thu, 9 Mar 2017 13:52:06 +1000
Message-ID: <CAPM=9tw3nbGe+gaOpoBZeXfmS5+C3R4eK=uT8AL3krL0PMR0LA@mail.gmail.com>
References: <544E607D03B20249AA404517E498FC469A558B@exchange01.valvesoftware.com>
 <BN4PR12MB0787AE3A185BE4D6916CE42AEE600@BN4PR12MB0787.namprd12.prod.outlook.com>
 <a25fdfeb-be5d-2d23-d7b1-ef14891ba6d5@gmail.com>
 <CAPM=9txG2KEw7AH553uFtuvoGYFK1=kmkPRJEHuA=8fq_JcY=w@mail.gmail.com>
 <58B4D68E.5080606@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <58B4D68E.5080606-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Mao,
 David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, Andres Rodriguez <andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Cui,
 Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Pierre-Loup Griffais <pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>

T24gMjggRmVicnVhcnkgMjAxNyBhdCAxMTo0NiwgemhvdWNtMSA8ZGF2aWQxLnpob3VAYW1kLmNv
bT4gd3JvdGU6Cj4gSGkgRGF2ZSwKPgo+IFRoZSBhdHRhY2hlZCBpcyBvdXIgc2VtYXBob3JlIGlt
cGxlbWVudGF0aW9uLCBhbWRncHVfY3MuYyBpcyBkcm0gZmlsZSwgdGhlCj4gb3RoZXJzIGFyZSBr
ZXJuZWwgZmlsZS4KPiBBbnkgc3VnZ2VzdGlvbj8KVGhhbmtzLAoKSSd2ZSBidWlsdCBhIHRyZWUg
d2l0aCBhbGwgdGhlc2UgaW4gaXQsIGFuZCBzdGFydGVkIGxvb2tpbmcgaW50byB0aGUgaW50ZXJm
YWNlLgoKSSBkbyB3b25kZXIgaWYgd2UgbmVlZCB0aGUgc2VwYXJhdGUgc2VtIHNpZ25hbC93YWl0
IGludGVyZmFjZSwgSSB0aGluawp3ZSBzaG91bGQganVzdCBhZGQKc2VtYXBob3JlIGNodW5rcyB0
byB0aGUgQ1MgaW50ZXJmYWNlLgoKSSdtIGp1c3QgcGxheWluZyBhcm91bmQgd2l0aCB0aGlzIG5v
dy4KCkRhdmUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
