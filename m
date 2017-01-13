From: Donny Yang <work-QPJ2QlwrfUw@public.gmane.org>
Subject: Undervolting RX480 from amdgpu
Date: Fri, 13 Jan 2017 20:07:19 +1100
Message-ID: <CACsxjPZzSBKhMEbZmyyGyY5fdpm=Zq8xaW97U=HK4CoNutuGfg@mail.gmail.com>
Reply-To: work-QPJ2QlwrfUw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1637765369=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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

--===============1637765369==
Content-Type: multipart/alternative; boundary=001a114740b6a2b0410545f62b6b

--001a114740b6a2b0410545f62b6b
Content-Type: text/plain; charset=UTF-8

Hello

A phoronix user reported success undervolting their RX470 under amdgpu-pro (
https://www.phoronix.com/forums/forum/linux-graphics-x-org-drivers/amd-linux/918649-underclocking-undervolting-the-rx-470-with-amdgpu-pro-success),
but I noticed they only edited a file that is in the non-pro version as
well.

So I performed a similar edit (see below patch) for my RX480 (specifically,
a MSI Gaming X 8GB one) that should immediately cause instabilities at the
higher DPM levels, yet did not happen after installing and rebooting.
Further more, FPS and temperatures stayed the same, suggesting that it
didn't have any effect at all. The printk was working though, so I know
that the driver installed correctly.

What could be going wrong? Does amdgpu-pro do some things that "unlocks"
voltage editing, that the normal amdgpu doesn't?

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c
b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c
index 4e1c36e9..7a94e09e 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smc.c
@@ -91,7 +91,11 @@ static int polaris10_get_dependency_volt_by_clk(struct
pp_hwmgr *hwmgr,
        for (i = 0; i < dep_table->count; i++) {
                /* find first sclk bigger than request */
                if (dep_table->entries[i].clk >= clock) {
-                       *voltage |= (dep_table->entries[i].vddc *
+                       printk("%u: depends on %umV\n", clock,
dep_table->entries[i].vddc);
+                       if (dep_table->entries[i].vddc > 881)
+                               *voltage |= (881 * VOLTAGE_SCALE) <<
VDDC_SHIFT;
+                       else
+                               *voltage |= (dep_table->entries[i].vddc *
                                        VOLTAGE_SCALE) << VDDC_SHIFT;
                        if (SMU7_VOLTAGE_CONTROL_NONE ==
data->vddci_control)
                                *voltage |=
(data->vbios_boot_state.vddci_bootup_value *

--001a114740b6a2b0410545f62b6b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGVsbG88YnI+PGRpdj48YnI+QSBwaG9yb25peCB1c2VyIHJlcG9ydGVk
IHN1Y2Nlc3MgdW5kZXJ2b2x0aW5nIHRoZWlyIFJYNDcwIHVuZGVyIGFtZGdwdS1wcm8gKDxhIGhy
ZWY9Imh0dHBzOi8vd3d3LnBob3Jvbml4LmNvbS9mb3J1bXMvZm9ydW0vbGludXgtZ3JhcGhpY3Mt
eC1vcmctZHJpdmVycy9hbWQtbGludXgvOTE4NjQ5LXVuZGVyY2xvY2tpbmctdW5kZXJ2b2x0aW5n
LXRoZS1yeC00NzAtd2l0aC1hbWRncHUtcHJvLXN1Y2Nlc3MiPmh0dHBzOi8vd3d3LnBob3Jvbml4
LmNvbS9mb3J1bXMvZm9ydW0vbGludXgtZ3JhcGhpY3MteC1vcmctZHJpdmVycy9hbWQtbGludXgv
OTE4NjQ5LXVuZGVyY2xvY2tpbmctdW5kZXJ2b2x0aW5nLXRoZS1yeC00NzAtd2l0aC1hbWRncHUt
cHJvLXN1Y2Nlc3M8L2E+KSwgYnV0IEkgbm90aWNlZCB0aGV5IG9ubHkgZWRpdGVkIGEgZmlsZSB0
aGF0IGlzIGluIHRoZSBub24tcHJvIHZlcnNpb24gYXMgd2VsbC48YnI+PGJyPlNvIEkgcGVyZm9y
bWVkIGEgc2ltaWxhciBlZGl0IChzZWUgYmVsb3cgcGF0Y2gpIGZvciBteSBSWDQ4MCAoc3BlY2lm
aWNhbGx5LCBhIE1TSSBHYW1pbmcgWCA4R0Igb25lKSB0aGF0IHNob3VsZCBpbW1lZGlhdGVseSBj
YXVzZSBpbnN0YWJpbGl0aWVzIGF0IHRoZSBoaWdoZXIgRFBNIGxldmVscywgeWV0IGRpZCBub3Qg
aGFwcGVuIGFmdGVyIGluc3RhbGxpbmcgYW5kIHJlYm9vdGluZy4gRnVydGhlciBtb3JlLCBGUFMg
YW5kIHRlbXBlcmF0dXJlcyBzdGF5ZWQgdGhlIHNhbWUsIHN1Z2dlc3RpbmcgdGhhdCBpdCBkaWRu
JiMzOTt0IGhhdmUgYW55IGVmZmVjdCBhdCBhbGwuIFRoZSBwcmludGsgd2FzIHdvcmtpbmcgdGhv
dWdoLCBzbyBJIGtub3cgdGhhdCB0aGUgZHJpdmVyIGluc3RhbGxlZCBjb3JyZWN0bHkuPGJyPjxi
cj48L2Rpdj48ZGl2PldoYXQgY291bGQgYmUgZ29pbmcgd3Jvbmc/IERvZXMgYW1kZ3B1LXBybyBk
byBzb21lIHRoaW5ncyB0aGF0ICZxdW90O3VubG9ja3MmcXVvdDsgdm9sdGFnZSBlZGl0aW5nLCB0
aGF0IHRoZSBub3JtYWwgYW1kZ3B1IGRvZXNuJiMzOTt0Pzxicj48L2Rpdj48ZGl2PjxkaXY+PGJy
PmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvcG9sYXJp
czEwX3NtYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3BvbGFyaXMx
MF9zbWMuYzxicj5pbmRleCA0ZTFjMzZlOS4uN2E5NGUwOWUgMTAwNjQ0PGJyPi0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9wb2xhcmlzMTBfc21jLmM8YnI+KysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3BvbGFyaXMxMF9zbWMuYzxicj5A
QCAtOTEsNyArOTEsMTEgQEAgc3RhdGljIGludCBwb2xhcmlzMTBfZ2V0X2RlcGVuZGVuY3lfdm9s
dF9ieV9jbGsoc3RydWN0IHBwX2h3bWdyICpod21nciw8YnI+wqDCoMKgwqDCoMKgwqAgZm9yIChp
ID0gMDsgaSAmbHQ7IGRlcF90YWJsZS0mZ3Q7Y291bnQ7IGkrKykgezxicj7CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLyogZmluZCBmaXJzdCBzY2xrIGJpZ2dlciB0aGFuIHJlcXVlc3Qg
Ki88YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChkZXBfdGFibGUtJmd0O2Vu
dHJpZXNbaV0uY2xrICZndDs9IGNsb2NrKSB7PGJyPi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqdm9sdGFnZSB8PSAoZGVwX3RhYmxlLSZndDtlbnRyaWVzW2ld
LnZkZGMgKjxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cHJpbnRrKCZxdW90OyV1OiBkZXBlbmRzIG9uICV1bVZcbiZxdW90OywgY2xvY2ssIGRlcF90YWJs
ZS0mZ3Q7ZW50cmllc1tpXS52ZGRjKTs8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIChkZXBfdGFibGUtJmd0O2VudHJpZXNbaV0udmRkYyAmZ3Q7IDg4
MSk8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqdm9sdGFnZSB8PSAoODgxICogVk9MVEFHRV9TQ0FMRSkgJmx0OyZsdDsgVkRE
Q19TSElGVDs8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGVsc2U8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAqdm9sdGFnZSB8PSAoZGVwX3RhYmxlLSZndDtlbnRyaWVzW2ldLnZkZGMg
Kjxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVk9MVEFHRV9TQ0FMRSkgJmx0OyZsdDsgVkREQ19T
SElGVDs8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoU01VN19WT0xUQUdFX0NPTlRST0xfTk9ORSA9PSBkYXRhLSZndDt2ZGRjaV9jb250cm9sKTxi
cj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqdm9sdGFnZSB8PSAoZGF0YS0mZ3Q7dmJpb3NfYm9vdF9zdGF0ZS52ZGRjaV9ib290
dXBfdmFsdWUgKjxicj48L2Rpdj48L2Rpdj48L2Rpdj4NCg==
--001a114740b6a2b0410545f62b6b--

--===============1637765369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1637765369==--
