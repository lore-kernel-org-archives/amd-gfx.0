From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Add sysfs file for VBIOS
Date: Fri, 25 Aug 2017 15:36:03 -0400
Message-ID: <250c9909-3ae3-792b-6c0a-62a883b3ac57@amd.com>
References: <1503511940-645-1-git-send-email-kent.russell@amd.com>
 <BN6PR1201MB018010027CA78E203F629BA7859A0@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <DM5PR1201MB023503F29269CEC80DC7DAD8929A0@DM5PR1201MB0235.namprd12.prod.outlook.com>
 <CADnq5_Piyp7mtHi+4GZ0pUw1kMNT68ZVyA6jp1TR4VhbCjWAOA@mail.gmail.com>
 <BN6PR1201MB01804846B5629D28766FDFA0859A0@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <fa2dddb4-5ceb-87f3-6305-fb5f6e6e5c2d@vodafone.de>
 <BN6PR1201MB0180502DC4720A3C33D642DB859A0@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <4cec0dad-502e-68f2-68c9-b5d0103d7093@amd.com>
 <BN6PR1201MB01803DD5EBD0049397F4E9F0859B0@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <0a3d4d07-e3cd-6216-466b-30bc60c8a26a@vodafone.de>
 <22c4b9e2-67e2-bd0a-1147-6e896843783e@amd.com>
 <BN6PR1201MB01806ACF078801D91460C110859B0@BN6PR1201MB0180.namprd12.prod.outlook.com>
 <BN6PR12MB16526CDFB29BC696816F2326F79B0@BN6PR12MB1652.namprd12.prod.outlook.com>
 <88a3901d-d05b-15c2-919a-03a5c90961ac@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <88a3901d-d05b-15c2-919a-03a5c90961ac-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjUvMDgvMTcgMDM6MzMgUE0sIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+IEkgdGhpbmsgdGhl
IHBvd2VyIG1lYXN1cmVtZW50IGlzIGEgYml0IG9mIGEgaGFjayByaWdodCBub3cuIEl0IHJlcXVp
cmVzCj4gcGluZ2luZyB0aGUgU01VIHR3aWNlIHRvIHN0YXJ0IGFuZCBzdG9wIHRoZSBtZWFzdXJl
bWVudCwgYW5kIHdhaXRpbmcgZm9yCj4gc29tZSB0aW1lIChidXQgbm90IHRvbyBsb25nKSBpbiBi
ZXR3ZWVuLiBJIHRoaW5rIGlmIHdlIHdhbnQgdG8gZXhwb3NlCj4gdGhpcyB2aWEgaHdtb24sIHdl
J2xsIG5lZWQgdG8gaGF2ZSBzb21lIGtpbmQgb2YgdGltZXIgdGhhdCBwb2xscyBpdCBpbgo+IHJl
Z3VsYXIgaW50ZXJ2YWxzIGluIHRoZSBiYWNrZ3JvdW5kIGFuZCB1cGRhdGVzIGEgdmFsdWUgdGhh
dCBjYW4gYmUKPiBxdWVyaWVkIHRocm91Z2ggSFdNb24gd2l0aG91dCBkZWxheS4KCldlIGhhZCB0
aGlzIGRlYmF0ZSBhYm91dCA4IG1vbnRocyBhZ28gOi0pCgpJIGRvbid0IGtub3cgaWYgYWRkaW5n
IGFuIGV2ZXIgcHJlc2VudCBrdGhyZWFkIGp1c3QgZm9yIHRoaXMgdGhvdWdoIGlzIGEgCnN1cGVy
IHVzZSBvZiByZXNvdXJjZXMuCgpJbiB1bXIgd2hlbiBJIHJlYWQgaXQgSSByZWFkIHRoZSBzZW5z
b3JzIGluIGEgc2VwYXJhdGUgdGhyZWFkIGZyb20gdGhlIAptYWluIFVJIHNvIHRoYXQgaXQgZG9l
c24ndCBtZXNzIHdpdGggdGhpbmdzLgoKVG9tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
