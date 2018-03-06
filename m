From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Tue, 6 Mar 2018 19:02:24 +0100
Message-ID: <cd4659cb-f030-4938-af44-2fa1389ccdfb@gmail.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <3f0a85f6-ac67-cd8c-716e-1c1655d40226@gmail.com>
 <c23ddc4b-c785-be3b-8321-416bb8417b6d@amd.com>
 <CADnq5_OAnM2p2NHnOAduCd+yomFXKqKhrag+JaayZD1Ri9z_2Q@mail.gmail.com>
 <BY1PR12MB05044ACBE8424866B3CCA243F5D90@BY1PR12MB0504.namprd12.prod.outlook.com>
 <898d3377-ee2b-a33d-dbff-b4cb692d650d@amd.com>
 <BY1PR12MB050407EA9472CB2B6E101CE7F5D90@BY1PR12MB0504.namprd12.prod.outlook.com>
 <e416ff00-018b-f206-123e-90b09b4ccd9f@gmail.com>
 <ebe01500-9fa5-e541-86c3-30ff0168e792@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ebe01500-9fa5-e541-86c3-30ff0168e792-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMDYuMDMuMjAxOCB1bSAxODo1MSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDMtMDYgMDY6NDQgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDA2LjAzLjIwMTgg
dW0gMTg6MjIgc2NocmllYiBMaSwgU2FtdWVsOgo+Pj4+IGFkZGl0aW9uIHRvIHRoYXQgSSBhZ3Jl
ZSB3aXRoIE1pY2hlbCB0aGF0IHRoZSBtb2R1bGUgcGFyYW1ldGVyIGlzCj4+Pj4gb3ZlcmtpbGwu
Cj4+PiBUaGF0IEkgYWxyZWFkeSBleHBsYWluZWQuIEN1cnJlbnRseSBTRyBkaXNwbGF5IGZlYXR1
cmUgbmVlZHMgdG8KPj4+IHByb3ZpZGUgb3B0aW9ucyBmb3IgYWxsIGtpbmRzIG9mIHVzZSBjYXNl
cy4gQWxsIGFtZCBkcml2ZXJzIHNvIGZhcgo+Pj4gcHJvdmlkZXMgb3B0aW9ucywgYW5kIHRoZSBk
ZWZhdWx0IGNvbmZpZ3VyYXRpb24gaXMgYWN0dWFsbHkgdG8KPj4+IGFsbG9jYXRlIGV2ZXJ5dGhp
bmcgZnJvbSBHVFQgd2hlbiBwb3NzaWJsZS4KPj4gVGhhdCBpc24ndCBqb2Igb2YgdGhlIGtlcm5l
bCB0byBoYXZlIHRoaXMgcGFyYW1ldGVyLiBTYXlpbmcgdGhhdCB3ZQo+PiBzaG91bGQgcHJvYmFi
bHkgYWRkIGEgRERYIGFuZC9vciBlbnZpcm9ubWVudCBvcHRpb24gdG8gY29udHJvbCB0aGF0Lgo+
IFdoeSB3b3VsZCB3ZSBuZWVkIHRoYXQ/IEl0J3MgdGhlIGtlcm5lbCBkcml2ZXIncyBqb2IgdG8g
aGFuZGxlIHRoaXMgYXMKPiBuZWVkZWQuCgpCdWZmZXIgcGxhY2VtZW50IGlzIHNwZWNpZmllZCBi
eSB0aGUgRERYL01lc2EsIHdoZW4gd2Ugb3ZlcnJpZGUgdGhhdCBpbiAKdGhlIGtlcm5lbCB3ZSBq
dXN0IGZvcmNlIHVubmVjZXNzYXJ5IGJ1ZmZlciBtb3Zlcy4KClJlZ2FyZHMsCkNocmlzdGlhbi4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
