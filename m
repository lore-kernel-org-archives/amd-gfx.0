From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/v3d: Fix calling drm_sched_resubmit_jobs for same
 sched.
Date: Wed, 13 Mar 2019 16:36:21 +0000
Message-ID: <fc067a25-260f-d056-f22c-10d9aac7a612@amd.com>
References: <1552409822-17230-1-git-send-email-andrey.grodzovsky@amd.com>
 <87imworo9v.fsf@anholt.net>
 <CY4PR12MB1446C0DAFA3349227DEB9B0AEA490@CY4PR12MB1446.namprd12.prod.outlook.com>
 <87lg1ioipw.fsf@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <87lg1ioipw.fsf-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Content-Language: en-US
Content-ID: <39D6E7A27C84E54B93B12BC694274331-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org" <tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org>

DQpPbiAzLzEzLzE5IDEyOjEzIFBNLCBFcmljIEFuaG9sdCB3cm90ZToNCj4gIkdyb2R6b3Zza3ks
IEFuZHJleSIgPEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+IHdyaXRlczoNCj4NCj4+IFRoZXkg
YXJlIG5vdCB0aGUgc2FtZSwgYnV0IHRoZSBndWlsdHkgam9iIGJlbG9uZ3MgdG8gb25seSBvbmUg
e2VudGl0eSwNCj4+IHNjaGVkdWxlcn0gcGFpciBhbmQgc28gd2UgbWFyayBhcyBndWlsdHkgb25s
eSBmb3IgdGhhdCBwYXJ0aWN1bGFyDQo+PiBlbnRpdHkgaW4gdGhlIGNvbnRleHQgb2YgdGhhdCBz
Y2hlZHVsZXIgb25seSBvbmNlLg0KPiBJIGdldCBpdCBub3csIHNvcnJ5LiAgSSdsbCBtZXJnZSB0
aGlzIHRocm91Z2ggZHJtLW1pc2MtbmV4dC4NCg0KbnAsIGkgYWN0dWFsbHkgcHVzaGVkIGl0IGlu
dG8gb3VyIGludGVybmFsIGJyYW5jaCBhbHJlYWR5IHNvIHlvdSBjYW4gZG8gDQp0aGF0IG9yIHdh
aXQgZm9yIG91ciBuZXh0IHB1bGwgcmVxdWVzdC4NCg0KQW5kcmV5DQoNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
