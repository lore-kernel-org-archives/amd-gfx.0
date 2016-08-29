From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/4] fix GFX8 dma frame scheme
Date: Mon, 29 Aug 2016 11:13:54 +0800
Message-ID: <1472440438-9429-1-git-send-email-Monk.Liu@amd.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <y>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

U3luYyBnZng4LjAgRE1BZnJhbWUgdG8gd2luZG93cyBzY2hlbWU6CjEpb25seSBvbmUgU1dJVENI
X0JVRkZFUiB0byB0aGUgZW5kIG9mIENTCjIpaW5zZXJ0IDEyOCBub3AgYmVmb3JlJmFmdGVyIFZN
IGZsdXNoeSB0byBwcmV2ZW50IENFIHZtIGZhdWx0CjMpdXNlIENPTlRFWFRfQ09OVFJPTCB0byBk
eW5hbWljYWxseSBjb250cm9sIHByZWFtYmxlIElCIHNraXBwaW5nCgpNb25rIExpdSAoNCk6CiAg
ZHJtL2FtZGdwdTphZGQgc3dpdGNoIGJ1ZmZlciB0byBlbmQgb2YgQ1MKICBkcm0vYW1kZ3B1Om5l
dyBtZXRob2QgdG8gc3luYyBjZSZkZQogIGRybS9hbWRncHU6Y2hhbmdlIGpvYi0+Y3R4IGZpZWxk
IG5hbWUKICBkcm0vYW1kZ3B1OmltcGxlbWVudCBDT05URVhUX0NPTlRST0wKCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCAgICAgfCAxMyArKysrKystCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyAgfCAxNCArKysrKysrLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2liLmMgIHwgMjggKysrKysrKystLS0tLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMgfCAgMiArLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y4XzAuYyAgIHwgNjMgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tCiA1IGZpbGVzIGNoYW5nZWQsIDg3IGluc2VydGlvbnMoKyksIDMzIGRlbGV0aW9ucygtKQoK
LS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
