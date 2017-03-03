From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 6/9] present: Flush before flipping
Date: Fri,  3 Mar 2017 18:07:42 +0900
Message-ID: <20170303090745.2254-6-michel@daenzer.net>
References: <20170303090745.2254-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170303090745.2254-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpUaGlzIGlzbid0
IG5lY2Vzc2FyeSBmb3IgRFJJIGNsaWVudHMsIGJ1dCB0aGUgUHJlc2VudCBleHRlbnNpb24gY2Fu
IGFsc28KYmUgdXNlZCBmb3IgcHJlc2VudGluZyBub3JtYWwgcGl4bWFwcyByZW5kZXJlZCB0byB2
aWEgdGhlIFgxMSBwcm90b2NvbC4KCihQb3J0ZWQgZnJvbSByYWRlb24gY29tbWl0IDkwMzViNmFi
ZWE1NTc4MjhlNjcyZWU0NTVmMGM4NGU0M2RhMDkwNmYpCgpTaWduZWQtb2ZmLWJ5OiBNaWNoZWwg
RMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KLS0tCiBzcmMvYW1kZ3B1X3ByZXNlbnQu
YyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9z
cmMvYW1kZ3B1X3ByZXNlbnQuYyBiL3NyYy9hbWRncHVfcHJlc2VudC5jCmluZGV4IGQzODFlMTVl
MC4uM2M0YmM1MjU5IDEwMDY0NAotLS0gYS9zcmMvYW1kZ3B1X3ByZXNlbnQuYworKysgYi9zcmMv
YW1kZ3B1X3ByZXNlbnQuYwpAQCAtMzI3LDYgKzMyNyw4IEBAIGFtZGdwdV9wcmVzZW50X2ZsaXAo
UlJDcnRjUHRyIGNydGMsIHVpbnQ2NF90IGV2ZW50X2lkLCB1aW50NjRfdCB0YXJnZXRfbXNjLAog
CiAJZXZlbnQtPmV2ZW50X2lkID0gZXZlbnRfaWQ7CiAKKwlhbWRncHVfZ2xhbW9yX2ZsdXNoKHNj
cm4pOworCiAJcmV0ID0gYW1kZ3B1X2RvX3BhZ2VmbGlwKHNjcm4sIEFNREdQVV9EUk1fUVVFVUVf
Q0xJRU5UX0RFRkFVTFQsCiAJCQkJIHBpeG1hcCwgZXZlbnRfaWQsIGV2ZW50LCBjcnRjX2lkLAog
CQkJCSBhbWRncHVfcHJlc2VudF9mbGlwX2V2ZW50LAotLSAKMi4xMS4wCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
