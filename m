From: Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 00/13] mmu_notifier kill invalidate_page
	callback
Date: Thu, 31 Aug 2017 19:29:52 -0400
Message-ID: <20170831232951.GB20888@redhat.com>
References: <20170829235447.10050-1-jglisse@redhat.com>
 <f46585ee-7a89-1d68-5698-b6de76152cde@amd.com>
 <20170831135953.GA9227@redhat.com>
 <4a58e441-5430-3b9d-a5e8-7b88b46f82cf@amd.com>
 <20170831190021.GG9227@redhat.com>
 <9a76dd3e-e266-c77e-721a-379092d714f1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <9a76dd3e-e266-c77e-721a-379092d714f1@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gVGh1LCBBdWcgMzEsIDIwMTcgYXQgMDc6MTk6MTlQTSAtMDQwMCwgRmVsaXggS3VlaGxpbmcg
d3JvdGU6Cj4gT24gMjAxNy0wOC0zMSAwMzowMCBQTSwgSmVyb21lIEdsaXNzZSB3cm90ZToKPiA+
IEkgd2FzIG5vdCBzYXlpbmcgeW91IHNob3VsZCBub3QgdXNlIG1tdV9ub3RpZmllci4gRm9yIGFj
aGlldmluZyBCIHlvdSBuZWVkCj4gPiBtbXVfbm90aWZpZXIuIE5vdGUgdGhhdCBpZiB5b3UgZG8g
bGlrZSBPRFAvS1ZNIHRoZW4geW91IGRvIG5vdCBuZWVkIHRvCj4gPiBwaW4gcGFnZS4KPiBJIHdv
dWxkIGxpa2UgdGhhdC4gSSd2ZSB0aG91Z2h0IGFib3V0IGl0IGJlZm9yZS4gVGhlIG9uZSBwcm9i
bGVtIEkKPiBjb3VsZG4ndCBmaWd1cmUgb3V0IGlzLCB3aGVyZSB0byBzZXQgdGhlIGFjY2Vzc2Vk
IGFuZCBkaXJ0eSBiaXRzIGZvciB0aGUKPiBwYWdlcy4gTm93IHdlIGRvIGl0IHdoZW4gd2UgdW5w
aW4uIElmIHdlIGRvbid0IHBpbiB0aGUgcGFnZXMgaW4gdGhlCj4gZmlyc3QgcGxhY2UsIHdlIGRv
bid0IGhhdmUgYSBnb29kIHBsYWNlIGZvciB0aGlzLgo+IAo+IE91ciBoYXJkd2FyZSBkb2Vzbid0
IGdpdmUgdXMgbm90aWZpY2F0aW9ucyBvciBhY2Nlc3NlZC9kaXJ0eSBiaXRzLCBzbyB3ZQo+IGhh
dmUgdG8gYXNzdW1lIHRoZSB3b3JzdCBjYXNlIHRoYXQgdGhlIHBhZ2VzIGFyZSBjb250aW51b3Vz
bHkKPiBhY2Nlc3NlZC9kaXJ0eS4KPiAKPiBJJ2QgYXBwcmVjaWF0ZSBhbnkgYWR2aWNlIGhvdyB0
byBoYW5kbGUgdGhhdC4gKFNvcnJ5LCBJIHJlYWxpemUgdGhpcyBpcwo+IGdvaW5nIGEgYml0IG9m
ZiB0b3BpYy4pIEEgcG9pbnRlciB0byBhIGRvY3VtZW50IG9yIHNvdXJjZSBjb2RlIHdvdWxkIGJl
Cj4gZ3JlYXQuIDopCgpJbiBpbnZhbGlkYXRlX3JhbmdlX3N0YXJ0KCkgaWUgc2FtZSBwbGFjZSBh
cyB3aGVyZSB5b3UgdW5waW4gYnV0IGluc3RlYWQKb2YgdW5waW5pbmcgeW91IHdvdWxkIGp1c3Qg
Y2FsbCBzZXRfcGFnZV9kaXJ0eSgpCgpKw6lyw7RtZQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9pbnRlbC1nZngK
