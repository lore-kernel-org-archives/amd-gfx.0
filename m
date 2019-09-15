From: Mikhail Gavrilov <mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: gnome-shell stuck because of amdgpu driver [5.3 RC5]
Date: Mon, 16 Sep 2019 00:47:30 +0500
Message-ID: <CABXGCsNA+p8QCGPduiTfOwdYsk+qGMXL9JTGsQXGtnDEDy4-xg@mail.gmail.com>
References: <20190830032948.13516-1-hdanton@sina.com>
 <CABXGCsNywbo90+wgiZ64Srm-KexypTbjiviwTW_BsO9Pm11GKQ@mail.gmail.com>
 <5d6e2298.1c69fb81.b5532.8395SMTPIN_ADDED_MISSING@mx.google.com>
 <CABXGCsMG2YrybO4_5jHaFQQxy2ywB53pY63qRfXK=ZKx5qc2Bw@mail.gmail.com>
 <CAKMK7uH9q09XadTV5Ezm=9aODErD=w_+8feujviVnF5LO_fggA@mail.gmail.com>
 <5d6f10a6.1c69fb81.6b104.af73SMTPIN_ADDED_MISSING@mx.google.com>
 <20190904083747.GE2112@phenom.ffwll.local>
 <CABXGCsMEjP-UQ5A1xpL-xWHxtFEsOUO14+cmWJUS1ff1hgReFA@mail.gmail.com>
 <CAKMK7uHQFpQjE8qxw5UUDg6xdbzcr0zaZ7P6WsBK7m0ksKdg3g@mail.gmail.com>
 <CABXGCsN_r6614xDft_FY5N-B1QRFkhz27Q5U7nnr=mwtOWyCUw@mail.gmail.com>
 <1d23703e-f6df-e663-a205-45c98cd125e8@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1d23703e-f6df-e663-a205-45c98cd125e8-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Hillf Danton <hdanton-k+cT0dCbe1g@public.gmane.org>, Linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

T24gTW9uLCA5IFNlcCAyMDE5IGF0IDE0OjE1LCBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPiB3cm90ZToKPgo+IEkgYWdyZWUgd2l0aCBEYW5pZWxzIGFuYWx5c2lz
Lgo+Cj4gSXQgbG9va3MgbGlrZSB0aGUgcHJvYmxlbSBpcyBzaW1wbHkgdGhhdCBQTSB0dXJucyBv
ZiBhIGJsb2NrIGJlZm9yZSBhbGwKPiB3b3JrIGlzIGRvbmUgb24gdGhhdCBibG9jay4KPgo+IEhh
dmUgeW91IG9wZW5lZCBhIGJ1ZyByZXBvcnQgeWV0PyBJZiBub3QgdGhlbiB0aGF0IHdvdWxkIGNl
cnRhaW5seSBoZWxwCj4gY2F1c2UgaXQgaXMgcmVhbGx5IGhhcmQgdG8gZXh0cmFjdCBhbGwgbmVj
ZXNzYXJ5IGluZm9ybWF0aW9uIGZyb20gdGhhdAo+IG1haWwgdGhyZWFkLgoKaHR0cHM6Ly9idWdz
LmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTExNjg5Ckl0J2xsIGRvPwoKLS0KQmVz
dCBSZWdhcmRzLApNaWtlIEdhdnJpbG92LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
