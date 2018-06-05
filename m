From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix clear_all and replace handling in the VM
Date: Tue, 5 Jun 2018 10:45:47 +0200
Message-ID: <c9988a0c-9166-fb64-87d5-d848995e3e6d@gmail.com>
References: <20180604105952.72796-1-christian.koenig@amd.com>
 <96ad02c2-4792-a12e-3002-385f30140971@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <96ad02c2-4792-a12e-3002-385f30140971-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDQuMDYuMjAxOCB1bSAxMzowMiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDYtMDQgMTI6NTkgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFdlIG5lZWQgdG8gcHV0
IHRoZSBsb3NlIGVuZHMgb24gdGhlIGludmFsaWQgbGlzdCBiZWNhdXNlIGl0IGlzIHBvc3NpYmxl
Cj4+IHRoYXQgd2UgbmVlZCB0byBzcGxpdCB1cCBodWdlIHBhZ2VzIGZvciB0aGVtLgo+Pgo+PiBT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
Cj4gRG9lcyB0aGlzIG5lZWQgdG8gZ28gdG8gc3RhYmxlPwoKWWVzLCBnb29kIHBvaW50LiBKZXJy
eSBpZiB5b3UgaGF2ZW4ndCBhbHJlYWR5IGNvbW1pdHRlZCB5b3VyIGZvbGxvdyB1cCAKcGF0Y2gg
dGhlbiBwbGVhc2UgYWRkIGEgIkNDOiBzdGFibGVAdmdlci5rZXJuZWwub3JnIiB0YWcgdG8gaXQu
CgpUaGFua3MsCkNocmlzdGlhbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
