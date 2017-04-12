From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH 8/8] amdgpu: use sync file for shared semaphores (v2.1)
Date: Wed, 12 Apr 2017 13:17:49 +1000
Message-ID: <CAPM=9twHAA+DkiLvryr4q6GSAttGr4xCkdvngkDOBqjSmZZtRw@mail.gmail.com>
References: <20170411032220.21101-1-airlied@gmail.com>
 <20170411032220.21101-9-airlied@gmail.com>
 <BN4PR12MB0787C6D1CD93D0FCB6F2069DEE030@BN4PR12MB0787.namprd12.prod.outlook.com>
 <CAPM=9txg84JzHVOpA7mfp4774gT_TLcEiya5fXu9cMTSFdWYWg@mail.gmail.com>
 <BN4PR12MB0787177718627EC2282F9B0AEE030@BN4PR12MB0787.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <BN4PR12MB0787177718627EC2282F9B0AEE030@BN4PR12MB0787.namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Mao, David" <David.Mao@amd.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMTIgQXByaWwgMjAxNyBhdCAxMjo0OSwgTWFvLCBEYXZpZCA8RGF2aWQuTWFvQGFtZC5jb20+
IHdyb3RlOgo+IEJ1dCBob3cgdG8gaGFuZGxlIHRoZSBzZW1hcGhvcmUgd2FpdCBpbiB0aGUgdmtR
dWV1ZVByZXNlbnRrSFI/CgpUaGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQgcmVhbGx5IHdlJ2Qgd2Fu
dCB0aGUgcHJlc2VudGluZyBwcm9jZXNzIHRvCmRvIHRoZSBzaWduYWwgb25jZSBpdCBzdWJtaXRz
IHRoZSB3b3JrIGZvciBhY3R1YWwgcHJlc2VudGF0aW9ucyAoYmUKdGhhdCB0aGUgWCBzZXJ2ZXIg
RERYIG9yIHdoYXRldmVyKS4KCkhvd2V2ZXIgdGhhdCBpcyBnb2luZyB0byBiZSBhIGJpdCB0cmlj
a3ksIGZvciByYWR2IEkndmUganVzdCBiZWVuCnN1Ym1pdHRpbmcgYW4gZW1wdHkgY29tbWFuZCBz
dHJlYW0gc3VibWl0LCBvbmNlIHRoZSBYIHNlcnZlcgpsZXRzIHVzIGtub3cgd2UndmUgcHJlc2Vu
dGVkLgoKSSBsb29rZWQgaG93IHRoZSBjb2RlYmFzZSBiZWZvcmUgSSBzdGFydGVkIHdvcmtpbmcg
b24gaXQgd29ya2VkLAphbmQgSSBjYW4ndCBzZWUgaWYgaXQgZGVhbHQgd2l0aCB0aGlzIHByb3Bl
cmx5IGVpdGhlciwgdGhlIGltcHJlc3Npb24gSSBnZXQKaXMgdGhhdCBpdCBtaWdodCBzdWJtaXQg
dGhlIHdhaXQgc2VtcyB2aWEgdGhlIHNlbSBpb2N0bCBvbnRvIGEgY3R4LApidXQgdGhlIFggc2Vy
dmVyIG1pZ2h0IGJlIHVzaW5nIGEgZGlmZmVyZW50IGN0eCwgc28gd291bGQgbmV2ZXIKZXhlY3V0
ZSB0aGUgd2FpdCwgYW5kIHdlJ2QgZXhlY3V0ZSB0aGUgd2FpdCB0aGUgbmV4dCB0aW1lIHdlIGRp
ZAphIGNvbW1hbmQgc3VibWlzc2lvbi4KCkkgc3VwcG9zZSB3ZSBjb3VsZCBqdXN0IHF1ZXVlIHVw
IHRoZSB2a1F1ZXVlUHJlc2VudEtIUiB3YWl0CnNlbXMgaW4gdXNlcnNwYWNlIGluc3RlYWQgb2Yg
YSBOVUxMIGNzIGlmIHRoaXMgc29sdXRpb24gd2FzIGFjY2VwdGFibGUuCgpEYXZlLgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
