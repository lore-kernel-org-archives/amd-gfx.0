From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: lock/unlock mismatch in ttm_bo.c
Date: Fri, 19 Jan 2018 13:14:47 -0500
Message-ID: <1713476e-c17f-9eea-ebd3-6999c760b678@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGkgYWxsLAoKSW4gdGhlIGZ1bmN0aW9uIHR0bV9ib19jbGVhbnVwX3JlZnMoKSBpdCBzZWVtcyBw
b3NzaWJsZSB0byBnZXQgdG8gbGluZSAKNTUxIHdpdGhvdXQgZW50ZXJpbmcgdGhlIGJsb2NrIG9u
IDUxNiB3aGljaCBtZWFucyB5b3UnbGwgYmUgdW5sb2NraW5nIGEgCm11dGV4IHRoYXQgd2Fzbid0
IGxvY2tlZC4KCk5vdyBpdCBtaWdodCBiZSB0aGF0IGluIHRoZSBjb3Vyc2Ugb2YgdGhlIEFQSSB0
aGlzIHBhdHRlcm4gY2Fubm90IGJlIApleHByZXNzZWQgYnV0IGl0J3Mgbm90IGNsZWFyIGZyb20g
dGhlIGZ1bmN0aW9uIGFsb25lIHRoYXQgdGhhdCBpcyB0aGUgY2FzZS4KClRob3VnaHRzPwoKVG9t
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
