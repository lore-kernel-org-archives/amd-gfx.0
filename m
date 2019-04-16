From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: dynamic DMA-buf sharing between devices
Date: Tue, 16 Apr 2019 20:38:29 +0200
Message-ID: <20190416183841.1577-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

SGkgZXZlcnlib2R5LAoKY29yZSBpZGVhIGluIHRoaXMgcGF0Y2ggc2V0IGlzIHRoYXQgRE1BLWJ1
ZiBpbXBvcnRlcnMgY2FuIG5vdyBwcm92aWRlIGFuIG9wdGlvbmFsIGludmFsaWRhdGUgY2FsbGJh
Y2suIFVzaW5nIHRoaXMgY2FsbGJhY2sgYW5kIHRoZSByZXNlcnZhdGlvbiBvYmplY3QgZXhwb3J0
ZXJzIGNhbiBub3cgYXZvaWQgcGlubmluZyBETUEtYnVmIG1lbW9yeSBmb3IgYSBsb25nIHRpbWUg
d2hpbGUgc2hhcmluZyBpdCBiZXR3ZWVuIGRldmljZXMuCgpJJ3ZlIGFscmVhZHkgc2VuZCBvdXQg
YW4gb2xkZXIgdmVyc2lvbiByb3VnaGx5IGEgeWVhciBhZ28sIGJ1dCBkaWRuJ3QgaGFkIHRpbWUg
dG8gZnVydGhlciBsb29rIGludG8gY2xlYW5pbmcgdGhpcyB1cC4KClRoZSBsYXN0IHRpbWUgYSBt
YWpvciBwcm9ibGVtIHdhcyB0aGF0IHdlIHdvdWxkIGhhZCB0byBmaXggdXAgYWxsIGRyaXZlcnMg
aW1wbGVtZW50aW5nIERNQS1idWYgYXQgb25jZS4KCk5vdyBJIGF2b2lkIHRoaXMgYnkgYWxsb3dp
bmcgbWFwcGluZ3MgdG8gYmUgY2FjaGVkIGluIHRoZSBETUEtYnVmIGF0dGFjaG1lbnQgYW5kIHNv
IGRyaXZlciBjYW4gb3B0aW9uYWxseSBtb3ZlIG92ZXIgdG8gdGhlIG5ldyBpbnRlcmZhY2Ugb25l
IGJ5IG9uZS4KClRoaXMgaXMgYWxzbyBhIHByZXJlcXVpc2l0ZSB0byBteSBwYXRjaHNldCBlbmFi
bGluZyBzaGFyaW5nIG9mIGRldmljZSBtZW1vcnkgd2l0aCBETUEtYnVmLgoKUGxlYXNlIHJldmll
dyBhbmQvb3IgY29tbWVudCwKQ2hyaXN0aWFuLiAKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
