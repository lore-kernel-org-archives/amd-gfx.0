From: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Subject: Re: [PATCH] drm/v3d: Fix calling drm_sched_resubmit_jobs for same
 sched.
Date: Wed, 13 Mar 2019 18:49:53 +0000
Message-ID: <fe6500d4-a362-9623-4b56-6cbd6e710dc2@amd.com>
References: <1552409822-17230-1-git-send-email-andrey.grodzovsky@amd.com>
 <87imworo9v.fsf@anholt.net>
 <CY4PR12MB1446C0DAFA3349227DEB9B0AEA490@CY4PR12MB1446.namprd12.prod.outlook.com>
 <87lg1ioipw.fsf@anholt.net> <fc067a25-260f-d056-f22c-10d9aac7a612@amd.com>
 <87y35ioe3y.fsf@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <87y35ioe3y.fsf@anholt.net>
Content-Language: en-US
Content-ID: <FE491886EADFEA4C8AB4140B9CA7BCD8@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Eric Anholt <eric@anholt.net>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "tomeu@tomeuvizoso.net" <tomeu@tomeuvizoso.net>
List-Id: amd-gfx.lists.freedesktop.org

bnANCg0KQW5kcmV5DQoNCk9uIDMvMTMvMTkgMTo1MyBQTSwgRXJpYyBBbmhvbHQgd3JvdGU6DQo+
ICJHcm9kem92c2t5LCBBbmRyZXkiIDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPiB3cml0ZXM6
DQo+DQo+PiBPbiAzLzEzLzE5IDEyOjEzIFBNLCBFcmljIEFuaG9sdCB3cm90ZToNCj4+PiAiR3Jv
ZHpvdnNreSwgQW5kcmV5IiA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT4gd3JpdGVzOg0KPj4+
DQo+Pj4+IFRoZXkgYXJlIG5vdCB0aGUgc2FtZSwgYnV0IHRoZSBndWlsdHkgam9iIGJlbG9uZ3Mg
dG8gb25seSBvbmUge2VudGl0eSwNCj4+Pj4gc2NoZWR1bGVyfSBwYWlyIGFuZCBzbyB3ZSBtYXJr
IGFzIGd1aWx0eSBvbmx5IGZvciB0aGF0IHBhcnRpY3VsYXINCj4+Pj4gZW50aXR5IGluIHRoZSBj
b250ZXh0IG9mIHRoYXQgc2NoZWR1bGVyIG9ubHkgb25jZS4NCj4+PiBJIGdldCBpdCBub3csIHNv
cnJ5LiAgSSdsbCBtZXJnZSB0aGlzIHRocm91Z2ggZHJtLW1pc2MtbmV4dC4NCj4+IG5wLCBpIGFj
dHVhbGx5IHB1c2hlZCBpdCBpbnRvIG91ciBpbnRlcm5hbCBicmFuY2ggYWxyZWFkeSBzbyB5b3Ug
Y2FuIGRvDQo+PiB0aGF0IG9yIHdhaXQgZm9yIG91ciBuZXh0IHB1bGwgcmVxdWVzdC4NCj4gSSBh
bHNvIGZpeGVkIHRoZSB3aGl0ZXNwYWNlIGluIHRoZSBtb3ZlZCBjb2RlIGFuZCBhZGRlZCB0aGUg
bWlzc2luZw0KPiBGaXhlczogbGluZSwgc28gSSdkIGxpa2UgdG8gZ2V0IGl0IG1lcmdlZCB0aHJv
dWdoIHRoZSBwcm9wZXIgdHJlZSBmb3INCj4gbWFpbnRhaW5pbmcgdjNkLg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlz
dApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
