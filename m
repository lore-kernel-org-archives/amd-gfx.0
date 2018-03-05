From: Samuel Li <samuel.li-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Mon, 5 Mar 2018 10:31:02 -0500
Message-ID: <1a7473df-7dfe-75f9-af1a-4633cb516ed7@amd.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <67ca0059-9cde-d92f-3127-dc832c2cba98@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <67ca0059-9cde-d92f-3127-dc832c2cba98-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

VGhlcmUgYXJlIHRocmVlIG1ham9yIG9wdGlvbnMgd2hlbiBTRyBjYXBhYmlsaXR5IGlzIGVuYWJs
ZWQsCjEpIEFsbG9jYXRlIGV2ZXJ5dGhpbmcgd2hlbiBwb3NzaWJsZSBmcm9tIEdUVCBtZW1vcnkK
MikgQWxsb2NhdGUgZXZlcnl0aGluZyB3aGVuIHBvc3NpYmxlIGZyb20gVlJBTQozKSBBbGxvdyBi
b3RoIFZSQU0vR1RUIHRvIGJlIGF2YWlsYWJsZQpFYWNoIGhhcyBpdHMgb3duIHByb3MvY29ucywg
YW5kIGl0IGhhcyBub3QgYmVlbiBkZWNpZGVkIHdoaWNoIGRpcmVjdGlvbiBpcyBnb2luZyB0byBi
ZSB1c2VkIGZvciBhbGwgUENzLiBTbyBpdCBzZWVtcyBiZW5lZmljaWFsIHRvIHByb3ZpZGUgYWxs
IHRoZSBvcHRpb25zLgoKU2FtCgpPbiAyMDE4LTAzLTA1IDA1OjE3IEFNLCBNaWNoZWwgRMOkbnpl
ciB3cm90ZToKPiBPbiAyMDE4LTAzLTAzIDEyOjI1IEFNLCBTYW11ZWwgTGkgd3JvdGU6Cj4+IEl0
J3MgZW5hYmxlZCBieSBkZWZhdWx0LiAtMSBpcyBhdXRvLCB0byBhbGxvdyBib3RoIHZyYW0gYW5k
IGd0dAo+PiBtZW1vcnkgYmUgYXZhaWxhYmxlLCBmb3IgdGVzdGluZyBwdXJwb3NlIG9ubHkuCj4g
Cj4gRG8gd2UgcmVhbGx5IG5lZWQgYSBtb2R1bGUgcGFyYW1ldGVyIGZvciB0aGlzPyBUaGVyZSdz
IGFscmVhZHkgdG9vIG1hbnkKPiBvZiB0aGVtLiBUaGUgZHJpdmVyIHNob3VsZCBrbm93IHdoaWNo
IHRvIHVzZSBpbiB3aGljaCBjYXNlcywgYW5kCj4gZGV2ZWxvcGVycyBjYW4gZWFzaWx5IHR3ZWFr
IHRoZSBjb2RlLiBVc2VycyBzaG91bGQgbmV2ZXIgbmVlZCB0byBjaGFuZ2UKPiB0aGlzLgo+IAo+
IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
