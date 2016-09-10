From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: amdkfd - misc fixes + get_local_mem_info() port [V.2]
Date: Sat, 10 Sep 2016 11:31:32 +1000
Message-ID: <1473471099-16914-1-git-send-email-funfunctor@folklore1984.net>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

VGhlIGZvbGxvd2luZyBzZXJpZXMgYXBwbGllcyBvbiB0b3Agb2YgZWl0aGVyIG1hc3RlciBvciB0
aGUgZHJtLW5leHQtNC45CmJyYW5jaC4gQXBhcnQgZnJvbSB0aGUgY291cGxlIG9mIG1pc2MgZml4
ZXMgaGVyZSB3ZSBwb3J0IG91dCB0aGUKJ2dldF9sb2NhbF9tZW1faW5mbygpJyBoZWxwZXIgb3V0
IG9mIHRoZSBST0NtIGtlcm5lbCBwYXRjaCBtb3VudGFpbgphbmQgaG9vayB0aGF0IHVwIHNvIHRv
IGJlIG1haW5saW5lZC4KClBsZWFzZSByZXZpZXcsCgpFZHdhcmQgTydDYWxsYWdoYW4gKDcpOgoK
ICBbUEFUQ0ggMS83XSBhbWRrZmQ6IFRpZHkgdXAga2ZkX2dlbmVyYXRlX2dwdV9pZCgpIHVpbnQ2
NF90IGJpdHNoaWZ0CiAgW1BBVENIIDIvN10gcmFkZW9ua2ZkL2FtZGtmZDogSW1wbGVtZW50IGdl
dF9sb2NhbF9tZW1faW5mbygpCiAgW1BBVENIIDMvN10gYW1ka2ZkOiBBZGQgc29tZSBtaXNzaW5n
IG1lbXNldCB6ZXJvJ2luZyBpbiBxdWV1ZSBpbml0CiAgW1BBVENIIDQvN10gZHJtL2FtZGtmZDog
TWFrZSBrZmRfbG9va3VwX3Byb2Nlc3NfYnlfcGFzaWQoKSB3ZWxsCiAgW1BBVENIIDUvN10gZHJt
L2FtZGtmZDogUmVtb3ZlIGR1cGxpY2F0ZSBwcW1fdW5pbml0KCkKICBbUEFUQ0ggNi83XSBkcm0v
YW1ka2ZkOiBSZXVzZSBmdW5jdGlvbiB0byBmaW5kIGEgcHJvY2VzcyB0aHJvdWdoCiAgW1BBVENI
IDcvN10gZHJtL2FtZGtmZDogRml4IHBvc3NpYmxlIGluZmluaXRlIGxvb3AKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
