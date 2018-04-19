From: xiyuan <xiyuan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: enlarge the maximum number of cards
 supported
Date: Thu, 19 Apr 2018 22:41:30 +0800
Message-ID: <9cccc0d1-56c3-c26e-a951-2f67a6e8d6c5@amd.com>
References: <20180419135049.31988-1-Xiaojie.Yuan@amd.com>
 <c04ac7a4-cd1e-f666-8d24-324f0cfdb9c3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c04ac7a4-cd1e-f666-8d24-324f0cfdb9c3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, Xiaojie Yuan <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAwNC8xOS8yMDE4IDEwOjI0IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDE5
LjA0LjIwMTggdW0gMTU6NTAgc2NocmllYiBYaWFvamllIFl1YW46Cj4+IDEyOCBpcyB0aGUgbWF4
aW11bSBudW1iZXIgb2YgY2FyZHMgdGhhdCB0aGUga2VybmVsIGNhbiBzdXBwb3J0Cj4+IGF0IHRo
ZSBtb21lbnQuCj4+Cj4+IENoYW5nZS1JZDogSTE1NWI3YjIxNjM1MzA2ZDhlY2M0NDBiODVmYjg5
NTQ1MDFhYjU1OTkKPj4gU2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZdWFuIDxYaWFvamllLll1YW5A
YW1kLmNvbT4KPgo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cj4KPiBJIGFzc3VtZSB5b3UgZG9uJ3QgaGF2ZSBjb21taXQgcmlnaHRzLCBz
byBJJ20gZ29pbmcgdG8gcHVzaCB0aGF0IGFueSAKPiBtb21lbnQuClllYWgsIHRoYW5rcy4KClJl
Z2FyZHMsClhpYW9qaWUKPgo+IFRoYW5rcywKPiBDaHJpc3RpYW4uCj4KPj4gLS0tCj4+IMKgIHRl
c3RzL2FtZGdwdS9hbWRncHVfdGVzdC5oIHwgMiArLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2FtZGdw
dS9hbWRncHVfdGVzdC5oIGIvdGVzdHMvYW1kZ3B1L2FtZGdwdV90ZXN0LmgKPj4gaW5kZXggNjI4
NzU3MzYuLmYyZWNlM2MzIDEwMDY0NAo+PiAtLS0gYS90ZXN0cy9hbWRncHUvYW1kZ3B1X3Rlc3Qu
aAo+PiArKysgYi90ZXN0cy9hbWRncHUvYW1kZ3B1X3Rlc3QuaAo+PiBAQCAtMzAsNyArMzAsNyBA
QAo+PiDCoCAvKioKPj4gwqDCoCAqIERlZmluZSBtYXguIG51bWJlciBvZiBjYXJkIGluIHN5c3Rl
bSB3aGljaCB3ZSBhcmUgYWJsZSB0byBoYW5kbGUKPj4gwqDCoCAqLwo+PiAtI2RlZmluZSBNQVhf
Q0FSRFNfU1VQUE9SVEVEwqDCoMKgwqAgNAo+PiArI2RlZmluZSBNQVhfQ0FSRFNfU1VQUE9SVEVE
wqDCoMKgwqAgMTI4Cj4+IMKgIMKgIC8qIEZvcndhcmQgcmVmZXJlbmNlIGZvciBhcnJheSB0byBr
ZWVwICJkcm0iIGhhbmRsZXMgKi8KPj4gwqAgZXh0ZXJuIGludCBkcm1fYW1kZ3B1W01BWF9DQVJE
U19TVVBQT1JURURdOwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
