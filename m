From: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] amdkfd: always select MMU_NOTIFIER
Date: Thu, 19 Apr 2018 13:47:15 -0400
Message-ID: <57c0cfd4-7be6-2572-0bb8-6e1d3e87ef33@amd.com>
References: <20180328155340.2253343-1-arnd@arndb.de>
 <664e2827-5237-160b-6ecf-c2da163569e1@amd.com>
 <CADYN=9LTmdLzeszPDeLZ1==9g1ciS1ubunC6jdjLJUiv6J6N3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CADYN=9LTmdLzeszPDeLZ1==9g1ciS1ubunC6jdjLJUiv6J6N3Q@mail.gmail.com>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Anders Roxell <anders.roxell@linaro.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOC0wNC0xOSAwNjo1NiBBTSwgQW5kZXJzIFJveGVsbCB3cm90ZToKPiBPbiAyOCBNYXJj
aCAyMDE4IGF0IDE4OjA0LCBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+IHdyb3RlOgo+PiBBbSAyOC4wMy4yMDE4IHVtIDE3OjUzIHNjaHJpZWIgQXJuZCBCZXJnbWFu
bjoKPj4+IEJ1aWxkaW5nIGFtZGtmZCB3aXRob3V0IE1NVSBub3RpZmllcnMgaXMgYnJva2VuOgo+
Pj4KPj4+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfbXFkX21hbmFnZXJfdmkuYzoyODoKPj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9wcml2Lmg6NTg0OjIyOiBlcnJvcjogZmllbGQgJ21tdV9ub3RpZmllcicKPj4+IGhhcyBpbmNv
bXBsZXRlIHR5cGUKPj4+Cj4+PiBUaGlzIGFkZHMgdGhlIG1pc3NpbmcgJ3NlbGVjdCBNTVVfTk9U
SUZJRVInIGxpbmUgdG8gbWFrZSBpdCBidWlsZAo+Pj4gY2xlYW5seSBhbGwgdGhlIHRpbWUuCj4+
Pgo+Pj4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KPj4KPj4g
QWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4sIGJ1
dCBJIHdvdWxkIHdhaXQgb24KPj4gd2hhdCBGZWxpeCBzYXlzIHRvIHRoYXQuCj4gVGVzdGVkLWJ5
OiBBbmRlcnMgUm94ZWxsIDxhbmRlcnMucm94ZWxsQGxpbmFyby5vcmc+Cj4KPiBSYW5keSBzZW50
IHRoZSBzYW1lIHBhdGNoIFsxXSBhbmQgaXRzIHN0aWxsIHJlcXVpcmVkLgo+Cj4gQ2hlZXJzLAo+
IEFuZGVycwo+IFsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwMzQwODg1
LwpZZXMsIGxvb2tzIGdvb2QuIEkgdGhpbmsgdGhpcyBwcm9iYWJseSBicm9rZSB3aGVuIHdlIHJl
bGF4ZWQgdGhlCmRlcGVuZGVuY3kgb24gaW9tbXV2Mi4KClJldmlld2VkLWJ5OiBGZWxpeCBLdWVo
bGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKPgo+Pgo+
Pj4gLS0tCj4+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcgfCAxICsKPj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQvS2NvbmZpZwo+Pj4gaW5kZXggZWQyZjA2YzlmMzQ2Li41YTI2YWNiOTBlMTkgMTAw
NjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9LY29uZmlnCj4+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9LY29uZmlnCj4+PiBAQCAtNCw2ICs0LDcgQEAK
Pj4+ICAgICBjb25maWcgSFNBX0FNRAo+Pj4gICAgICAgICB0cmlzdGF0ZSAiSFNBIGtlcm5lbCBk
cml2ZXIgZm9yIEFNRCBHUFUgZGV2aWNlcyIKPj4+ICsgICAgICAgc2VsZWN0IE1NVV9OT1RJRklF
Ugo+Pj4gICAgICAgICBkZXBlbmRzIG9uIERSTV9BTURHUFUgJiYgWDg2XzY0Cj4+PiAgICAgICAg
IGltcGx5IEFNRF9JT01NVV9WMgo+Pj4gICAgICAgICBoZWxwCj4+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRy
aS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
