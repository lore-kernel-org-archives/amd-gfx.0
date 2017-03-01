From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 05/15] drm/amd/display: Fix gamma colour corruption for 10
 bit surfaces
Date: Wed, 1 Mar 2017 10:53:59 -0500
Message-ID: <597ce7b0-db0f-3928-ea64-a6680cdeab87@amd.com>
References: <20170301002620.24595-1-harry.wentland@amd.com>
 <20170301002620.24595-6-harry.wentland@amd.com>
 <440e5b55-ec15-a939-1626-f546208e37df@daenzer.net>
 <5b7a6fe3-9ef1-145d-dc09-e238b68be3fc@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5b7a6fe3-9ef1-145d-dc09-e238b68be3fc-5C7GfCeVMHo@public.gmane.org>
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
Cc: Jordan Lazare <Jordan.Lazare-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxNy0wMy0wMSAxMDowMSBBTSwgSGFycnkgV2VudGxhbmQgd3JvdGU6Cj4gT24gMjAxNy0w
Mi0yOCAwODoxNyBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4+IE9uIDAxLzAzLzE3IDA5OjI2
IEFNLCBIYXJyeSBXZW50bGFuZCB3cm90ZToKPj4+IEZyb206IEpvcmRhbiBMYXphcmUgPEpvcmRh
bi5MYXphcmVAYW1kLmNvbT4KPj4+Cj4+PiBHYW1tYSBMVVQgc2hvdWxkbid0IGJlIHVzZWQgZm9y
IDEwLWJpdCBhbmQgYWJvdmUuIFNob3VsZCBpbnN0ZWFkIGJlCj4+PiB1c2luZyBwcmVzY2FsZSBh
bmQgYnlwYXNzaW5nIGlucHV0IGdhbW1hLgo+Pj4KPj4+IENoYW5nZS1JZDogSTU1YzA4Yzc0NmJi
MWUxYWIxNzM5ZTQ3MTYyZGRmMDZkYjEyZmU4NzMKPj4+IFNpZ25lZC1vZmYtYnk6IEpvcmRhbiBM
YXphcmUgPEpvcmRhbi5MYXphcmVAYW1kLmNvbT4KPj4+IEFja2VkLWJ5OiBIYXJyeSBXZW50bGFu
ZCA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT4KPj4+IFJldmlld2VkLWJ5OiBUb255IENoZW5nIDxU
b255LkNoZW5nQGFtZC5jb20+Cj4+PiAtLS0KPj4+ICAuLi4vYW1kL2Rpc3BsYXkvZGMvZGNlMTEw
L2RjZTExMF9od19zZXF1ZW5jZXIuYyAgICB8IDE1ICsrKystCj4+PiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjZTgwL01ha2VmaWxlICAgICAgfCAgMyArLQo+Pj4gIC4uLi9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTgwL2RjZTgwX2lwcF9nYW1tYS5jIHwgNzEKPj4+IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPj4KPj4gVGhlIHJlbW92YWwgb2YgZGNlODBfaXBwX2dhbW1hLmMg
YW5kIGNvcnJlc3BvbmRpbmcgTWFrZWZpbGUgY2hhbmdlIGxvb2tzCj4+IHVucmVsYXRlZCBhbmQg
c2hvdWxkIGJlIGEgc2VwYXJhdGUgY2hhbmdlLgo+Pgo+Pgo+Cj4gVGhlIGNoYW5nZSBpcyByZW1v
dmluZyBkY2U4MF9pcHBfZ2FtbWEuYyBhbmQgaGFzIHRvIHJlbW92ZSBpdCBmcm9tCj4gTWFrZWZp
bGUgYXMgd2VsbCwgdW5sZXNzIHRoZXJlJ3Mgc29tZXRoaW5nIEknbSBub3Qgc2VlaW5nLgo+CgpN
aXNyZWFkIHlvdXIgY29tbWVudC4gWWVhaCwgdGhhdCBzaG91bGQgcHJvYmFibHkgYmUgaW4gYSBz
ZXBhcmF0ZSBjaGFuZ2UuCgpIYXJyeQoKPiBIYXJyeQo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
