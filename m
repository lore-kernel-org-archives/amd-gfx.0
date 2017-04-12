From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH 5/8] sync_file: add support for a semaphore object
Date: Thu, 13 Apr 2017 07:41:28 +1000
Message-ID: <CAPM=9tzx8TjPUQ0qH0j=b=U_RyGerCjCNb+2feTuuONB9iRkqA@mail.gmail.com>
References: <20170411032220.21101-1-airlied@gmail.com>
 <20170411032220.21101-6-airlied@gmail.com>
 <20170411075057.GA2724@nuc-i3427.alporthouse.com>
 <CAPM=9tzgNoSXPoZfJbRcoRmGZL9gENo+TTZCbauMjB7mwayZxw@mail.gmail.com>
 <20170412103116.GL4250@nuc-i3427.alporthouse.com>
 <CAPM=9tyiKAH-T2rxwcqxc=LWZ8o_5TyxV3GVhy_JKZv3PZQsCw@mail.gmail.com>
 <20170412200132.GJ12532@nuc-i3427.alporthouse.com>
 <20170412203929.GM12532@nuc-i3427.alporthouse.com>
 <CAPM=9tyk2NvVTfzEmm+psYv2BfL3xNKhEq_CE7gGeHmS3R9BMg@mail.gmail.com>
 <20170412211301.GN12532@nuc-i3427.alporthouse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170412211301.GN12532@nuc-i3427.alporthouse.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Chris Wilson <chris@chris-wilson.co.uk>, Dave Airlie <airlied@gmail.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

Pgo+IFRoZSBwcm9ibGVtLCBhcyBJIHNlZSBpdCwgaXMgdGhhdCB5b3UgYXJlIHRha2luZyBmdW5j
dGlvbmFsaXR5IGF3YXkgZnJvbQo+IHN5bmNfZmlsZS4gSWYgeW91IGFyZSB3cmFwcGluZyB0aGVt
IHVwIGluc2lkZSBhIHN5bmNfZmlsZSwgd2UgaGF2ZSBhCj4gZmFpciBleHBlY3RhdGlvbiB0aGF0
IG91ciBjb2RlIHRvIGhhbmRsZSBzeW5jX2ZpbGVzIHdpbGwgY29udGludWUgdG8KPiB3b3JrLgoK
V2hhdCBjb2RlPyB0aGVyZSBpcyBubyBjb2RlIGV4aXN0aW5nIHRoYXQgc2hvdWxkIGJlIHNoYXJp
bmcgc3luYyBvYmplY3RzCndpdGggc2VtYXBob3JlcyBiYWNraW5nIHRoZW0sIGFuZCB0cnlpbmcg
dG8gdXNlIHRoZW0gYXMgc3luY19maWxlcy4KClRoaXMgaXMgcGFyYWxsZWwgZnVuY3Rpb25hbGl0
eS4KCkRhdmUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
