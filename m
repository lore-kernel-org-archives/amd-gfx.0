From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx: fix MEC interrupt enablement for
 pipes != 0
Date: Fri, 9 Jun 2017 10:31:02 -0400
Message-ID: <bcc86ee9-90e4-cc64-5c09-6b1a2f0945e3@amd.com>
References: <1497012570-24173-1-git-send-email-alexander.deucher@amd.com>
 <a0862427-6b30-2f3b-1046-fa4d6c0cf35c@amd.com>
 <CY4PR12MB1653B87B56497B1F48C120DEF7CE0@CY4PR12MB1653.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1653B87B56497B1F48C120DEF7CE0-rpdhrqHFk06apTa93KjAaQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMDkvMDYvMTcgMTA6MjMgQU0sIERldWNoZXIsIEFsZXhhbmRlciB3cm90ZToKPj4gQ291bGQg
dXNlIFdSRUczMl9GSUVMRCgpIGhlcmUgdG8gc2ltcGxpZnkgdGhlc2UuCj4gCj4gVGhhdCBkb2Vz
bid0IHdvcmsgaWYgeW91IGhhdmUgdmFyaWFibGUgcmVnaXN0ZXIgbmFtZXMgYXMgd2UgZG8gaW4g
dGhpcyBjYXNlLgoKV2hpY2ggaXMgd2h5IHdlIGhhdmUgV1JFRzMyX0ZJRUxEX09GRlNFVCA6LSkK
CgpUb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
