From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/3] PCI: Add #defines for Enter Compliance, Transmit Margin
Date: Tue, 12 Nov 2019 11:35:01 -0600
Message-ID: <20191112173503.176611-2-helgaas@kernel.org>
References: <20191112173503.176611-1-helgaas@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191112173503.176611-1-helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, David Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: Frederick Lawler <fred-AA42j+p7l0JWk0Htik3J/w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>

RnJvbTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KCkFkZCBkZWZpbml0aW9u
cyBmb3IgdGhlIEVudGVyIENvbXBsaWFuY2UgYW5kIFRyYW5zbWl0IE1hcmdpbiBmaWVsZHMgb2Yg
dGhlClBDSWUgTGluayBDb250cm9sIDIgcmVnaXN0ZXIuCgpTaWduZWQtb2ZmLWJ5OiBCam9ybiBI
ZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPgotLS0KIGluY2x1ZGUvdWFwaS9saW51eC9wY2lf
cmVncy5oIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2luY2x1ZGUvdWFwaS9saW51eC9wY2lfcmVncy5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Bj
aV9yZWdzLmgKaW5kZXggMjlkNmU5M2ZkMTVlLi41ODY5ZTU3NzhhMDUgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvdWFwaS9saW51eC9wY2lfcmVncy5oCisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9wY2lf
cmVncy5oCkBAIC02NzMsNiArNjczLDggQEAKICNkZWZpbmUgIFBDSV9FWFBfTE5LQ1RMMl9UTFNf
OF8wR1QJMHgwMDAzIC8qIFN1cHBvcnRlZCBTcGVlZCA4R1QvcyAqLwogI2RlZmluZSAgUENJX0VY
UF9MTktDVEwyX1RMU18xNl8wR1QJMHgwMDA0IC8qIFN1cHBvcnRlZCBTcGVlZCAxNkdUL3MgKi8K
ICNkZWZpbmUgIFBDSV9FWFBfTE5LQ1RMMl9UTFNfMzJfMEdUCTB4MDAwNSAvKiBTdXBwb3J0ZWQg
U3BlZWQgMzJHVC9zICovCisjZGVmaW5lICBQQ0lfRVhQX0xOS0NUTDJfRU5URVJfQ09NUAkweDAw
MTAgLyogRW50ZXIgQ29tcGxpYW5jZSAqLworI2RlZmluZSAgUENJX0VYUF9MTktDVEwyX1RYX01B
UkdJTgkweDAzODAgLyogVHJhbnNtaXQgTWFyZ2luICovCiAjZGVmaW5lIFBDSV9FWFBfTE5LU1RB
MgkJNTAJLyogTGluayBTdGF0dXMgMiAqLwogI2RlZmluZSBQQ0lfQ0FQX0VYUF9FTkRQT0lOVF9T
SVpFT0ZfVjIJNTIJLyogdjIgZW5kcG9pbnRzIHdpdGggbGluayBlbmQgaGVyZSAqLwogI2RlZmlu
ZSBQQ0lfRVhQX1NMVENBUDIJCTUyCS8qIFNsb3QgQ2FwYWJpbGl0aWVzIDIgKi8KLS0gCjIuMjQu
MC5yYzEuMzYzLmdiMWJjY2QzZTNkLWdvb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
