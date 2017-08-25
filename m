From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Add sysfs file for VBIOS
Date: Fri, 25 Aug 2017 09:32:32 -0400
Message-ID: <4202cafb-db5d-4487-e195-ce02a289f79f@amd.com>
References: <1503511940-645-1-git-send-email-kent.russell@amd.com>
 <CADnq5_PD3s8HHPtr49ZJ3DXPVXgP5xyvFZj_YTzsGCi=cnOUKA@mail.gmail.com>
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
 <ebeb7962-c55c-9ba3-6969-6f7cf9934a5b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ebeb7962-c55c-9ba3-6969-6f7cf9934a5b-5C7GfCeVMHo@public.gmane.org>
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

T24gMjUvMDgvMTcgMDk6MDUgQU0sIFRvbSBTdCBEZW5pcyB3cm90ZToKPiBPbiAyNS8wOC8xNyAw
ODo1OSBBTSwgUnVzc2VsbCwgS2VudCB3cm90ZToKPj4gVGhlcmUgaXMgR1BVIFBvd2VyIHVzYWdl
IHJlcG9ydGVkIHRocm91Z2ggYW1kZ3B1X3BtX2luZm8sIHdoaWNoIGFsc28gCj4+IGhhcyBzb21l
IG90aGVyIGluZm9ybWF0aW9uIGFzIHdlbGwuIEknZCBsaWtlIHRoYXQgaW4gc3lzZnMsIGJ1dCBJ
IGFtIAo+PiB1bnN1cmUgaWYgd2UgYXJlICBhbGxvd2VkIHRvIGR1ZSB0byB0aGUgb3RoZXIgaW5m
b3JtYXRpb24gcmVwb3J0ZWQgdGhlcmUuCj4gCj4gSSB0aG91Z2h0IHRoZSBzZW5zb3JzIHdlcmUg
YWRkZWQgdG8gdGhlIERSTSBpb2N0bCBidXQgYXBwYXJlbnRseSBub3QuCgpObyBpdCB3YXMsIHVu
ZGVyIEFNREdQVV9JTkZPIHlvdSByZXF1ZXN0IGluZm8tPnF1ZXJ5ID09IApBTURHUFVfSU5GT19T
RU5TT1IgYW5kIHRoZW4gc3BlY2lmeSB3aGljaCBzZW5zb3IgeW91IHdhbnQgaW4gCmluZm8tPnNl
bnNvcl9pbmZvLnR5cGUgKHNlZSBhbWRncHVfa21zLmMpLgoKU28geW91IGNhbiBhbHJlYWR5IHJl
YWQgdGhpcyBmcm9tIGEgbm9ybWFsIHVzZXIgcHJvY2VzcyB3aG8gaGFzIGFuIG9wZW4gCkRSTSBm
aWxlIGhhbmRsZS4KClRvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
