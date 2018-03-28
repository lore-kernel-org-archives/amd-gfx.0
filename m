From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/8] PCI: Add pci_find_common_upstream_dev()
Date: Wed, 28 Mar 2018 17:07:20 +0200
Message-ID: <613a6c91-7e72-5589-77e6-587ec973d553@gmail.com>
References: <20180325110000.2238-1-christian.koenig@amd.com>
 <20180325110000.2238-2-christian.koenig@amd.com>
 <20180328123830.GB25060@infradead.org>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180328123830.GB25060-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
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
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

QW0gMjguMDMuMjAxOCB1bSAxNDozOCBzY2hyaWViIENocmlzdG9waCBIZWxsd2lnOgo+IE9uIFN1
biwgTWFyIDI1LCAyMDE4IGF0IDEyOjU5OjU0UE0gKzAyMDAsIENocmlzdGlhbiBLw7ZuaWcgd3Jv
dGU6Cj4+IEZyb206ICJ3ZGF2aXNAbnZpZGlhLmNvbSIgPHdkYXZpc0BudmlkaWEuY29tPgo+Pgo+
PiBBZGQgYW4gaW50ZXJmYWNlIHRvIGZpbmQgdGhlIGZpcnN0IGRldmljZSB3aGljaCBpcyB1cHN0
cmVhbSBvZiBib3RoCj4+IGRldmljZXMuCj4gUGxlYXNlIHdvcmsgd2l0aCBMb2dhbiBhbmQgYmFz
ZSB0aGlzIG9uIHRvcCBvZiB0aGUgb3V0c3RhbmRpbmcgcGVlcgo+IHRvIHBlZXIgcGF0Y2hzZXQu
CgpDYW4geW91IHBvaW50IG1lIHRvIHRoYXQ/IFRoZSBsYXN0IGNvZGUgSSBjb3VsZCBmaW5kIGFi
b3V0IHRoYXQgd2FzIGZyb20gCjIwMTUuCgpUaGFua3MsCkNocmlzdGlhbi4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
