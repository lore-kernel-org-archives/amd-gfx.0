From: Johannes Hirte <johannes.hirte-rSzmJuYucINa7YElYzY8/Q@public.gmane.org>
Subject: Re: BUG: KASAN: use-after-free in amdgpu_job_free_cb
Date: Fri, 12 Jan 2018 09:54:32 +0100
Message-ID: <20180112085431.GA13901@probook>
References: <20180103083525.GA29629@probook> <20180103093611.GA754@probook>
 <20180109144401.GA11503@probook>
 <b30d8818-727e-906b-9203-47a5a5b03605@amd.com>
 <20180111225505.GA23698@probook>
 <2d0470e3-2d9c-0139-1bd4-493d97e419eb@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2d0470e3-2d9c-0139-1bd4-493d97e419eb-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "Li,
 Sun peng" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOCBKYW4gMTEsIEFuZHJleSBHcm9kem92c2t5IHdyb3RlOgo+IFRoYW5rcyBmb3IgdGhl
IGRtZXNnLCB1bmZvcnR1bmF0ZWx5IG5vdGhpbmcgc3VzcGljaW91cyBmcm9tIHRoZXJlLgo+IAo+
IExvb2tpbmcgYWdhaW4gYXQgS0FTQU4gaXQgaGludHMgYXQgYSByYWNlIGJldHdlZW4gY3Vyc29y
IHVwZGF0ZSBhbmQgbm9uIAo+IGJsb2NraW5nIHBhcnQgb2YgZmxpcCB3aXRoIHJlZ2FyZCB0byBh
Y2Nlc3NpbmcgQ1JUQyBzdGF0ZXMsIG1heWJlIGN1cnNvciAKPiB1cGRhdGUgaXMgbm90IHByb3Bl
cmx5IHN5bmNocm9uaXplZCBhZ2FpbnN0IGEgZmxpcCBpbiBmbGlnaHQgb24gc2FtZSBDUlRDLi4u
Cj4gCj4gUC5TIFdoYXQgaXMgeW91ciBzZXR1cCA/IEhvdyBtYW55IGRpc3BsYXlzID8KPiAKCkl0
J3MgYSBDYXJpenpvIEExMC04NzAwQiBSNiB3aXRoIDE2RyBSQU0sIDUxMk0gYXNzaWduZWQgdG8g
Z3JhcGhpY3MKY2FyZC4gT25seSB0aGUgbGFwdG9wIGRpc3BsYXkgKDE5MjB4MTA4MCkgaXMgY29u
bmVjdGVkIHZpYSBlRFAsIHNvIG5vdGhpbmcgc3BlY2lhbC4KCi0tIApSZWdhcmRzLAogIEpvaGFu
bmVzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
