From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: access stolen VRAM directly on KV/KB
Date: Tue, 8 Nov 2016 10:23:47 +0100
Message-ID: <f04a0ad6-e2cb-98c9-cb09-8af3218b9dca@vodafone.de>
References: <1478510481-1768-1-git-send-email-deathsimple@vodafone.de>
 <9d218698-d588-090a-eb47-d0142cfdb623@daenzer.net>
 <7be5b56d-fae3-d71b-485f-01227172859d@vodafone.de>
 <8372afd6-8a51-1102-99a3-28a719088fa6@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8372afd6-8a51-1102-99a3-28a719088fa6-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMDguMTEuMjAxNiB1bSAwODozMSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDA3LzEx
LzE2IDA2OjMzIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAwNy4xMS4yMDE2IHVt
IDEwOjI5IHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+PiBPbiAwNy8xMS8xNiAwNjoyMSBQTSwg
Q2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+PiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+Pj4KPj4+PiBXZSBkb24ndCBuZWVkIHRvIHVzZSB0aGUg
UENJIEJBUiBvbiBBUFVzLiBUaGlzIGFsbG93cyB1cyB0byBhY2Nlc3MKPj4+PiB0aGUgZnVsbCBW
UkFNIGRpcmVjdGx5IHdpdGhvdXQgYmVpbmcgbGltaXRlZCBieSB0aGUgQkFSIHNpemUuCj4+Pj4K
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cj4+PiBUaGUgc2VyaWVzIGlzCj4+Pgo+Pj4gUmV2aWV3ZWQtYnk6IE1pY2hlbCBEw6Ru
emVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgo+Pj4KPj4+Cj4+PiBXZSBjb3VsZCBhbHNvIGRy
b3AgdGhlIEhEUCBmbHVzaGVzIC8gaW52YWxpZGF0ZXMgaW4gdGhpcyBjYXNlLCByaWdodD8KPj4g
Q291bGQgYmUsIGJ1dCBJJ20gbm90IDEwMCUgc3VyZSBob3cgdGhvc2UgYXJlIGFjdHVhbGx5IHdp
cmVkIHVwIG9uIEFQVXMuCj4+Cj4+IE1pZ2h0IGJlIHRoYXQgdGhleSBhcmUgTk9QcyBhbnl3YXks
IGJ1dCBjb3VsZCBiZSB0aGF0IGF0IGxlYXN0IHRoZQo+PiBmbHVzaGVzIGFyZSBzdGlsbCB2aXRh
bC4KPiBNeSBhc3N1bXB0aW9uIGlzIHRoYXQgc2luY2UgQ1BVIGFjY2VzcyB0byBWUkFNIGRvZXNu
J3QgZ28gdGhyb3VnaCB0aGUKPiBIRFAgYXQgYWxsIHdpdGggdGhpcyBjaGFuZ2UsIEhEUCBmbHVz
aGVzIC8gaW52YWxpZGF0ZXMgY2FuJ3QgaGF2ZSBhbnkKPiB1c2VmdWwgZWZmZWN0LgoKV2VsbCB3
cml0ZXMgdG8gR1RUIHN0aWxsIHVzZSB0aGUgSERQIGlmIEkgdW5kZXJzdGFuZCBpdCBjb3JyZWN0
bHkuCgpTbyB3ZSBzdGlsbCBuZWVkIHRvIGhhbmRsZSBlaXRoZXIgZmx1c2hlcyBvciBpbnZhbGlk
YXRpb25zIChJIGRvZXNuJ3Qgb2YgCmhhbmQgcmVtZW1iZXIgd2hpY2ggd2FzIHRoYXQpLgoKUmVn
YXJkcywKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
