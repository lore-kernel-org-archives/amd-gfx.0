From: Chih-Wei Huang <cwhuang-/Cx9OjMEmUl75Oa3hH2JBw@public.gmane.org>
Subject: [PATCH 1/2] android: add rules to build amdgpu.ids
Date: Wed, 19 Jul 2017 18:18:02 +0800
Message-ID: <1500459483-5795-1-git-send-email-cwhuang@linux.org.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Chih-Wei Huang <cwhuang-Xh+NVF5n0LIoRNOVWjJ6hg@public.gmane.org>

U2lnbmVkLW9mZi1ieTogQ2hpaC1XZWkgSHVhbmcgPGN3aHVhbmdAbGludXgub3JnLnR3PgotLS0K
IGRhdGEvQW5kcm9pZC5tayB8IDkgKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRp
b25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgZGF0YS9BbmRyb2lkLm1rCgpkaWZmIC0tZ2l0IGEv
ZGF0YS9BbmRyb2lkLm1rIGIvZGF0YS9BbmRyb2lkLm1rCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cmlu
ZGV4IDAwMDAwMDAuLjNjMWZkN2MKLS0tIC9kZXYvbnVsbAorKysgYi9kYXRhL0FuZHJvaWQubWsK
QEAgLTAsMCArMSw5IEBACitMT0NBTF9QQVRIIDo9ICQoY2FsbCBteS1kaXIpCisKK2luY2x1ZGUg
JChDTEVBUl9WQVJTKQorTE9DQUxfTU9EVUxFIDo9IGFtZGdwdS5pZHMKK0xPQ0FMX01PRFVMRV9U
QUdTIDo9IG9wdGlvbmFsCitMT0NBTF9NT0RVTEVfQ0xBU1MgOj0gRVRDCitMT0NBTF9NT0RVTEVf
UEFUSCA6PSAkKFRBUkdFVF9PVVRfRVRDKS9od2RhdGEKK0xPQ0FMX1NSQ19GSUxFUyA6PSAkKExP
Q0FMX01PRFVMRSkKK2luY2x1ZGUgJChCVUlMRF9QUkVCVUlMVCkKLS0gCjEuOS4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
