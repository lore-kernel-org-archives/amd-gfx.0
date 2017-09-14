From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 1/3] drm/syncobj: extract two helpers from
 drm_syncobj_create
Date: Thu, 14 Sep 2017 08:56:46 +0100
Message-ID: <CACvgo50uprnZZ_+wXLH59Knq2SUCZwoFsyYH6ydcNJQ9Eiaw3A@mail.gmail.com>
References: <1505248934-1819-1-git-send-email-maraeo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1505248934-1819-1-git-send-email-maraeo@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, ML dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

SGkgTWFyZWssCgpPbiAxMiBTZXB0ZW1iZXIgMjAxNyBhdCAyMTo0MiwgTWFyZWsgT2zFocOhayA8
bWFyYWVvQGdtYWlsLmNvbT4gd3JvdGU6Cgo+ICBpbmNsdWRlL2RybS9kcm1fc3luY29iai5oICAg
ICB8ICA0ICsrKysKUGxlYXNlIHN5bmMgdGhlIGhlYWRlciBhcyBkZXNjcmliZWQgaW4KaHR0cHM6
Ly9jZ2l0LmZyZWVkZXNrdG9wLm9yZy9tZXNhL2RybS90cmVlL2luY2x1ZGUvZHJtL1JFQURNRSNu
NzIKClRsO0RSOiBjZCAuLi4vbGludXg7IG1ha2UgaGVhZGVyc19pbnN0YWxsOyBjcCAuLi4gLi4u
L2RybS9pbmNsdWRlL2RybTsKY2QgLi4uL2RybTsgZ2l0IGNvbW1pdCAtc20gIi4uLi4gJGJyYW5j
aCAkc2hhMS4uLiIKClRoYW5rIHlvdQpFbWlsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2RyaS1kZXZlbAo=
