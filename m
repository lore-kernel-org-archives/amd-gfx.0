From: "H.Habighorst" <h.habighorst-g/b1ySJe57IN+BqQ9rBEUg@public.gmane.org>
Subject: QHD Bug (FDO #108940) - possible solution,
 need validation / information
Date: Sun, 07 Apr 2019 21:00:47 +0000
Message-ID: <-LB8FYvICVORX0ESqBzuQU6zxmqQBO_wphgoJdV2CAcl0tspGOXfaNWQ_Cj-5ktTt9BMiaqhPY-fvx3tXc7SIWN4GlwvWnnRGAySbrj1ehc=@protonmail.com>
Reply-To: "H.Habighorst" <h.habighorst-g/b1ySJe57IN+BqQ9rBEUg@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="b1_d04f47c19cc33a6f9d02c27ccdaec596"
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.

--b1_d04f47c19cc33a6f9d02c27ccdaec596
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

this bug: https://bugs.freedesktop.org/show_bug.cgi?id=3D108940#add_comment=
 has annoyed a lot of people...

I'm neither an C programmer nor an "expert" in driver programming, so my "s=
olution" is based on experience in other programming languages...

My code is - I guess - crappy as hell, sorry for that. My mainboard is an A=
sRock B450M Pro4, with latest BIOS P3.10 03/07/2019 and an AMD Ryzen 5 2400=
G.

When looking at the dmesg output, I noticed that reading the clock values i=
n function dcn_bw_update_from_pplib changed from kernel version to kernel v=
ersion.

In 5.1+, both FCLK and DCFCLK are printed correctly.

In 5.0, FCLK is printed correctly, DCFCLK is printed as "Invalid clock".

In < 5.0, only DCFCLK is printed (as "Invalid clock")

--
5.0.7:

DM_PPLIB: values for Invalid clock
DM_PPLIB:        0 in kHz
DM_PPLIB:        0 in kHz
DM_PPLIB:        0 in kHz
DM_PPLIB:        1600000 in kHz
WARNING: CPU: 2 PID: 276 at drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/=
dcn_calcs.c:1380 dcn_bw_update_from_pplib+0x171/0x290 [amdgpu]
RIP: 0010:dcn_bw_update_from_pplib+0x171/0x290 [amdgpu]
DM_PPLIB: values for Invalid clock
DM_PPLIB:        300000 in kHz
DM_PPLIB:        600000 in kHz
DM_PPLIB:        626000 in kHz
DM_PPLIB:        654000 in kHz

--
5.1_rc3
DM_PPLIB: values for F clock
DM_PPLIB:        0 in kHz
DM_PPLIB:        0 in kHz
DM_PPLIB:        0 in kHz
DM_PPLIB:        1600000 in kHz
WARNING: CPU: 6 PID: 292 at drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/=
dcn_calcs.c:1373 dcn_bw_update_from_pplib+0x174/0x2a0 [amdgpu]
RIP: 0010:dcn_bw_update_from_pplib+0x174/0x2a0 [amdgpu]
DM_PPLIB: values for DCF clock
DM_PPLIB:        300000 in kHz
DM_PPLIB:        600000 in kHz
DM_PPLIB:        626000 in kHz
DM_PPLIB:        654000 in kHz

--

After a bit of try and error, I found out that deep in the bios is an optio=
n to set the "System configuration" to 6 possible values and that this rela=
tes to the cTDP settings.

(3 Commercial, 3 Customer).

Each of these settings lead to different results - depending on the number =
of levels set.

With the 45W TDP commercial setting, I got the following F clock results:

DM_PPLIB: values for F clock
DM_PPLIB:   0 in kHz
DM_PPLIB:   400000 in kHz
DM_PPLIB:   933000 in kHz
DM_PPLIB:   1067000 in kHz

Then, I took a deeper look at the source code - and changed the validation =
in verify_clock_values (drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_=
calcs.c)

Before, every khz setting =3D=3D 0 was regarded as an "fatal" error, leadin=
g to no possible initialization.

I guess that this isn't entirely wrong as 0 makes no sense. But in my case =
- and when I understood the code correctly - it's not entirely right, too, =
as there are some levels that could be used.

My assumption is that the BIOS should provide these values in a fixed order=
, but (as I even had to change bios settings to just get the basic clock va=
lues right) - the ASRock BIOS simply does nothing right...

>From my understanding, the previous code in dcn_bw_update_from_pplib is alr=
eady based on the assumption that there is no fixed number of levels provid=
ed, but that there must be at least 3 and a maximum of 4 levels provided.

Instead of taking the results directly from the "dm_pp_clock_levels_with_vo=
ltage" struct, I gathered the valid clock KHz values and converted them to =
hertz in the validation function, returning the clocks as an array. An addi=
tional parameter to the function contains the actual (not maximum) number o=
f correct values gathered.

This fixes the initialization and removes the annoying BREAK_TO_DEBUGGER ou=
tput.

I think it is still not correct, as the FCLK values are not provided by the=
 BIOS - and the approach to just bail out, because something is not provide=
d by the bios, seems wrong to me.


There is a comment in the function that suggests that there is a better way=
, which sounds more sane to me:

/* TODO: This is not the proper way to obtain fabric_and_dram_bandwidth, sh=
ould be min(fclk, memclk) */

Is memclk DFCLK? Or how can one get the memclk values?

I hope that someone could fix this properly or at least verify that my assu=
mptions are correct - so I can maybe work out a better patch.

Thanks in advance,

Henning











--b1_d04f47c19cc33a6f9d02c27ccdaec596
Content-Type: text/x-patch; name="amdgpu_dcn_calc_rework_validation.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=amdgpu_dcn_calc_rework_validation.patch

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9kY25fY2Fs
Y3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9kY25fY2FsY3MuYwpp
bmRleCBlYjYyZDEwYmI2NWMuLmQ5N2MwNjBlOGI5OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NhbGNzL2Rjbl9jYWxjcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9jYWxjcy9kY25fY2FsY3MuYwpAQCAtMTMyNywxOSArMTMyNywyNiBA
QCB1bnNpZ25lZCBpbnQgZGNuX2ZpbmRfZGNmY2xrX3N1aXRzX2FsbCgKIAlyZXR1cm4gZGNmX2Ns
azsKIH0KIAotc3RhdGljIGJvb2wgdmVyaWZ5X2Nsb2NrX3ZhbHVlcyhzdHJ1Y3QgZG1fcHBfY2xv
Y2tfbGV2ZWxzX3dpdGhfdm9sdGFnZSAqY2xrcykKK3N0YXRpYyBmbG9hdCogdmVyaWZ5X2Nsb2Nr
X3ZhbHVlcyhzdHJ1Y3QgZG1fcHBfY2xvY2tfbGV2ZWxzX3dpdGhfdm9sdGFnZSAqY2xrcywgaW50
ICp2YWxpZF9jbG9ja19sZXZlbHMpCiB7Ci0JaW50IGk7Ci0KLQlpZiAoY2xrcy0+bnVtX2xldmVs
cyA9PSAwKQotCQlyZXR1cm4gZmFsc2U7CisJaW50IGksIGxldmVsID0gMDsKKwlzdGF0aWMgZmxv
YXQgdmFsaWRfY2xvY2tzX2h6WzRdOworCWlmIChjbGtzLT5udW1fbGV2ZWxzID09IDApIHsKKwkJ
KnZhbGlkX2Nsb2NrX2xldmVscyA9IGxldmVsOworCQlyZXR1cm4gdmFsaWRfY2xvY2tzX2h6Owor
CX0KIAotCWZvciAoaSA9IDA7IGkgPCBjbGtzLT5udW1fbGV2ZWxzOyBpKyspCisJZm9yIChpID0g
MDsgaSA8IGNsa3MtPm51bV9sZXZlbHM7IGkrKykgewogCQkvKiBFbnN1cmUgdGhhdCB0aGUgcmVz
dWx0IGlzIHNhbmUgKi8KLQkJaWYgKGNsa3MtPmRhdGFbaV0uY2xvY2tzX2luX2toeiA9PSAwKQot
CQkJcmV0dXJuIGZhbHNlOworCQlpZiAoY2xrcy0+ZGF0YVtpXS5jbG9ja3NfaW5fa2h6ID09IDAp
IHsKKwkJCWNvbnRpbnVlOworCQl9CisJCXZhbGlkX2Nsb2Nrc19oeltsZXZlbF0gPSBjbGtzLT5k
YXRhW2ldLmNsb2Nrc19pbl9raHogLyAxMDAwLjA7CisJCSsrbGV2ZWw7CisJfQorCSp2YWxpZF9j
bG9ja19sZXZlbHMgPSBsZXZlbDsKIAotCXJldHVybiB0cnVlOworCXJldHVybiB2YWxpZF9jbG9j
a3NfaHo7CiB9CiAKIHZvaWQgZGNuX2J3X3VwZGF0ZV9mcm9tX3BwbGliKHN0cnVjdCBkYyAqZGMp
CkBAIC0xMzQ3LDI4ICsxMzU0LDM0IEBAIHZvaWQgZGNuX2J3X3VwZGF0ZV9mcm9tX3BwbGliKHN0
cnVjdCBkYyAqZGMpCiAJc3RydWN0IGRjX2NvbnRleHQgKmN0eCA9IGRjLT5jdHg7CiAJc3RydWN0
IGRtX3BwX2Nsb2NrX2xldmVsc193aXRoX3ZvbHRhZ2UgZmNsa3MgPSB7MH0sIGRjZmNsa3MgPSB7
MH07CiAJYm9vbCByZXM7CisJaW50IHZhbGlkX2Nsb2NrX2xldmVscyA9IDA7CisJZmxvYXQgKnZh
bGlkX2Nsb2Nrc19oejsKIAogCS8qIFRPRE86IFRoaXMgaXMgbm90IHRoZSBwcm9wZXIgd2F5IHRv
IG9idGFpbiBmYWJyaWNfYW5kX2RyYW1fYmFuZHdpZHRoLCBzaG91bGQgYmUgbWluKGZjbGssIG1l
bWNsaykgKi8KLQlyZXMgPSBkbV9wcF9nZXRfY2xvY2tfbGV2ZWxzX2J5X3R5cGVfd2l0aF92b2x0
YWdlKAotCQkJY3R4LCBETV9QUF9DTE9DS19UWVBFX0ZDTEssICZmY2xrcyk7Ci0KKwlyZXMgPSBk
bV9wcF9nZXRfY2xvY2tfbGV2ZWxzX2J5X3R5cGVfd2l0aF92b2x0YWdlKGN0eCwgRE1fUFBfQ0xP
Q0tfVFlQRV9GQ0xLLCAmZmNsa3MpOwogCWtlcm5lbF9mcHVfYmVnaW4oKTsKIAotCWlmIChyZXMp
Ci0JCXJlcyA9IHZlcmlmeV9jbG9ja192YWx1ZXMoJmZjbGtzKTsKLQogCWlmIChyZXMpIHsKLQkJ
QVNTRVJUKGZjbGtzLm51bV9sZXZlbHMgPj0gMyk7Ci0JCWRjLT5kY25fc29jLT5mYWJyaWNfYW5k
X2RyYW1fYmFuZHdpZHRoX3ZtaW4wcDY1ID0gMzIgKiAoZmNsa3MuZGF0YVswXS5jbG9ja3NfaW5f
a2h6IC8gMTAwMC4wKSAvIDEwMDAuMDsKKwkJdmFsaWRfY2xvY2tzX2h6ID0gdmVyaWZ5X2Nsb2Nr
X3ZhbHVlcygmZmNsa3MsICZ2YWxpZF9jbG9ja19sZXZlbHMpOworCX0KKworCURSTV9ERUJVR19E
UklWRVIoCisJCSJEQ05fQ0FMQ19DUzogUmVhZGluZyBGQ0xLIHZhbHVlcyAlcyAtIG51bWJlciBv
ZiB2YWxpZCBjbG9jayBsZXZlbHM6ICVkXG4iLAorCQkocmVzICE9IGZhbHNlID8gIndhcyBzdWNj
ZXNzZnVsIiA6ICJmYWlsZWQiKSwKKwkJdmFsaWRfY2xvY2tfbGV2ZWxzCisJKTsKKworCWlmIChy
ZXMgJiYgdmFsaWRfY2xvY2tfbGV2ZWxzID49IDMpIHsKKwkJZGMtPmRjbl9zb2MtPmZhYnJpY19h
bmRfZHJhbV9iYW5kd2lkdGhfdm1pbjBwNjUgPSAzMiAqIHZhbGlkX2Nsb2Nrc19oelswXSAvIDEw
MDAuMDsKIAkJZGMtPmRjbl9zb2MtPmZhYnJpY19hbmRfZHJhbV9iYW5kd2lkdGhfdm1pZDBwNzIg
PSBkYy0+ZGNuX3NvYy0+bnVtYmVyX29mX2NoYW5uZWxzICoKLQkJCQkoZmNsa3MuZGF0YVtmY2xr
cy5udW1fbGV2ZWxzIC0gKGZjbGtzLm51bV9sZXZlbHMgPiAyID8gMyA6IDIpXS5jbG9ja3NfaW5f
a2h6IC8gMTAwMC4wKQotCQkJCSogZGRyNF9kcmFtX2ZhY3Rvcl9zaW5nbGVfQ2hhbm5lbCAvIDEw
MDAuMDsKKwkJCQkodmFsaWRfY2xvY2tzX2h6W3ZhbGlkX2Nsb2NrX2xldmVscyAtIDNdKSAqCisJ
CQkJZGRyNF9kcmFtX2ZhY3Rvcl9zaW5nbGVfQ2hhbm5lbCAvIDEwMDAuMDsKIAkJZGMtPmRjbl9z
b2MtPmZhYnJpY19hbmRfZHJhbV9iYW5kd2lkdGhfdm5vbTBwOCA9IGRjLT5kY25fc29jLT5udW1i
ZXJfb2ZfY2hhbm5lbHMgKgotCQkJCShmY2xrcy5kYXRhW2ZjbGtzLm51bV9sZXZlbHMgLSAyXS5j
bG9ja3NfaW5fa2h6IC8gMTAwMC4wKQotCQkJCSogZGRyNF9kcmFtX2ZhY3Rvcl9zaW5nbGVfQ2hh
bm5lbCAvIDEwMDAuMDsKKwkJCQkodmFsaWRfY2xvY2tzX2h6W3ZhbGlkX2Nsb2NrX2xldmVscyAt
IDJdKSAqCisJCQkJZGRyNF9kcmFtX2ZhY3Rvcl9zaW5nbGVfQ2hhbm5lbCAvIDEwMDAuMDsKIAkJ
ZGMtPmRjbl9zb2MtPmZhYnJpY19hbmRfZHJhbV9iYW5kd2lkdGhfdm1heDBwOSA9IGRjLT5kY25f
c29jLT5udW1iZXJfb2ZfY2hhbm5lbHMgKgotCQkJCShmY2xrcy5kYXRhW2ZjbGtzLm51bV9sZXZl
bHMgLSAxXS5jbG9ja3NfaW5fa2h6IC8gMTAwMC4wKQotCQkJCSogZGRyNF9kcmFtX2ZhY3Rvcl9z
aW5nbGVfQ2hhbm5lbCAvIDEwMDAuMDsKKwkJCQkodmFsaWRfY2xvY2tzX2h6W3ZhbGlkX2Nsb2Nr
X2xldmVscyAtIDFdKSAqCisJCQkJZGRyNF9kcmFtX2ZhY3Rvcl9zaW5nbGVfQ2hhbm5lbCAvIDEw
MDAuMDsKIAl9IGVsc2UKIAkJQlJFQUtfVE9fREVCVUdHRVIoKTsKIApAQCAtMTM3OSwxNCArMTM5
MiwyMCBAQCB2b2lkIGRjbl9id191cGRhdGVfZnJvbV9wcGxpYihzdHJ1Y3QgZGMgKmRjKQogCiAJ
a2VybmVsX2ZwdV9iZWdpbigpOwogCisJRFJNX0RFQlVHX0RSSVZFUigKKwkJIkRDTl9DQUxDX0NT
OiBSZWFkaW5nIERDRkNMSyB2YWx1ZXMgJXMgLSBudW1iZXIgb2YgdmFsaWQgY2xvY2sgbGV2ZWxz
OiAlZFxuIiwKKwkJKHJlcyAhPSBmYWxzZSA/ICJ3YXMgc3VjY2Vzc2Z1bCIgOiAiZmFpbGVkIiks
CisJCXZhbGlkX2Nsb2NrX2xldmVscworCSk7CisKIAlpZiAocmVzKQotCQlyZXMgPSB2ZXJpZnlf
Y2xvY2tfdmFsdWVzKCZkY2ZjbGtzKTsKKwkJdmFsaWRfY2xvY2tzX2h6ID0gdmVyaWZ5X2Nsb2Nr
X3ZhbHVlcygmZGNmY2xrcywgJnZhbGlkX2Nsb2NrX2xldmVscyk7CiAKIAlpZiAocmVzICYmIGRj
ZmNsa3MubnVtX2xldmVscyA+PSAzKSB7Ci0JCWRjLT5kY25fc29jLT5kY2ZjbGt2X21pbjBwNjUg
PSBkY2ZjbGtzLmRhdGFbMF0uY2xvY2tzX2luX2toeiAvIDEwMDAuMDsKLQkJZGMtPmRjbl9zb2Mt
PmRjZmNsa3ZfbWlkMHA3MiA9IGRjZmNsa3MuZGF0YVtkY2ZjbGtzLm51bV9sZXZlbHMgLSAzXS5j
bG9ja3NfaW5fa2h6IC8gMTAwMC4wOwotCQlkYy0+ZGNuX3NvYy0+ZGNmY2xrdl9ub20wcDggPSBk
Y2ZjbGtzLmRhdGFbZGNmY2xrcy5udW1fbGV2ZWxzIC0gMl0uY2xvY2tzX2luX2toeiAvIDEwMDAu
MDsKLQkJZGMtPmRjbl9zb2MtPmRjZmNsa3ZfbWF4MHA5ID0gZGNmY2xrcy5kYXRhW2RjZmNsa3Mu
bnVtX2xldmVscyAtIDFdLmNsb2Nrc19pbl9raHogLyAxMDAwLjA7CisJCWRjLT5kY25fc29jLT5k
Y2ZjbGt2X21pbjBwNjUgPSB2YWxpZF9jbG9ja3NfaHpbMF07CisJCWRjLT5kY25fc29jLT5kY2Zj
bGt2X21pZDBwNzIgPSB2YWxpZF9jbG9ja3NfaHpbdmFsaWRfY2xvY2tfbGV2ZWxzIC0gM107CisJ
CWRjLT5kY25fc29jLT5kY2ZjbGt2X25vbTBwOCA9IHZhbGlkX2Nsb2Nrc19oelt2YWxpZF9jbG9j
a19sZXZlbHMgLSAyXTsKKwkJZGMtPmRjbl9zb2MtPmRjZmNsa3ZfbWF4MHA5ID0gdmFsaWRfY2xv
Y2tzX2h6W3ZhbGlkX2Nsb2NrX2xldmVscyAtIDFdOwogCX0gZWxzZQogCQlCUkVBS19UT19ERUJV
R0dFUigpOwogCg==


--b1_d04f47c19cc33a6f9d02c27ccdaec596
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--b1_d04f47c19cc33a6f9d02c27ccdaec596--
