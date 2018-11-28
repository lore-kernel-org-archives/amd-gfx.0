From: Yang Xiao <YangX92-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] drm/amd/display: fix uninitialized symbol 'id' in
 bios_parser_get_src_obj
Date: Wed, 28 Nov 2018 02:02:33 +0000
Message-ID: <HK0PR01MB21639A567D2727C37D1D360FADD10@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "harry.wentland-5C7GfCeVMHo@public.gmane.org" <harry.wentland-5C7GfCeVMHo@public.gmane.org>, "sunpeng.li-5C7GfCeVMHo@public.gmane.org" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, "alexander.deucher-5C7GfCeVMHo@public.gmane.org" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "David1.Zhou-5C7GfCeVMHo@public.gmane.org" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>
Cc: Yang Xiao <YangX92-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, "Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, "Tony.Cheng-5C7GfCeVMHo@public.gmane.org" <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

RnJvbTogWW91bmcgWGlhbyA8WWFuZ1g5MkBob3RtYWlsLmNvbT4KClNlZSBjb21taXQgYThmOTc2
NDczMTk2ICgiZHJtL2FtZC9kaXNwbGF5OiBCdW5jaCBvZiBzbWF0Y2ggZXJyb3IgYW5kCndhcm5p
bmcgZml4ZXMgaW4gREMiKSBmb3IgZGV0YWlsLgoKU2lnbmVkLW9mZi1ieTogWW91bmcgWGlhbyA8
WWFuZ1g5MkBob3RtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Ymlvcy9iaW9zX3BhcnNlci5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvYmlvcy9iaW9zX3BhcnNlci5jCmluZGV4IDBlMWRjMWIuLjY0MjA1NDYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXIuYwpAQCAtMTg4
LDcgKzE4OCw3IEBAIHN0YXRpYyBlbnVtIGJwX3Jlc3VsdCBiaW9zX3BhcnNlcl9nZXRfc3JjX29i
aihzdHJ1Y3QgZGNfYmlvcyAqZGNiLAogCXN0cnVjdCBncmFwaGljc19vYmplY3RfaWQgKnNyY19v
YmplY3RfaWQpCiB7CiAJdWludDMyX3QgbnVtYmVyOwotCXVpbnQxNl90ICppZDsKKwl1aW50MTZf
dCAqaWQgPSBOVUxMOwogCUFUT01fT0JKRUNUICpvYmplY3Q7CiAJc3RydWN0IGJpb3NfcGFyc2Vy
ICpicCA9IEJQX0ZST01fRENCKGRjYik7CiAKQEAgLTIwNCw3ICsyMDQsNyBAQCBzdGF0aWMgZW51
bSBicF9yZXN1bHQgYmlvc19wYXJzZXJfZ2V0X3NyY19vYmooc3RydWN0IGRjX2Jpb3MgKmRjYiwK
IAogCW51bWJlciA9IGdldF9zcmNfb2JqX2xpc3QoYnAsIG9iamVjdCwgJmlkKTsKIAotCWlmIChu
dW1iZXIgPD0gaW5kZXgpCisJaWYgKG51bWJlciA8PSBpbmRleCB8fCAhaWQpCiAJCXJldHVybiBC
UF9SRVNVTFRfQkFESU5QVVQ7CiAKIAkqc3JjX29iamVjdF9pZCA9IG9iamVjdF9pZF9mcm9tX2Jp
b3Nfb2JqZWN0X2lkKGlkW2luZGV4XSk7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
