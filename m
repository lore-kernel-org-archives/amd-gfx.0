From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
Subject: RFC: unpinned DMA-buf exporting
Date: Fri,  9 Mar 2018 20:11:40 +0100
Message-ID: <20180309191144.1817-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

VGhpcyBzZXQgb2YgcGF0Y2hlcyBhZGRzIGFuIG9wdGlvbiBpbnZhbGlkYXRlX21hcHBpbmdzIGNh
bGxiYWNrIHRvIGVhY2ggRE1BLWJ1ZiBhdHRhY2htZW50IHdoaWNoIGNhbiBiZSBmaWxsZWQgaW4g
YnkgdGhlIGltcG9ydGVyLgoKVGhpcyBjYWxsYmFjayBhbGxvd3MgdGhlIGV4cG9ydGVyIHRvIHBy
b3ZpZGVkIHRoZSBETUEtYnVmIGNvbnRlbnQgd2l0aG91dCBwaW5uaW5nIGl0LiBUaGUgcmVzZXJ2
YXRpb24gb2JqZWN0cyBsb2NrIGFjdHMgYXMgc3luY2hyb25pemF0aW9uIHBvaW50IGZvciBidWZm
ZXIgbW92ZXMgYW5kIGNyZWF0aW5nIG1hcHBpbmdzLgoKVGhpcyBzZXQgaW5jbHVkZXMgYW4gaW1w
bGVtZW50YXRpb24gZm9yIGFtZGdwdSB3aGljaCBzaG91bGQgYmUgcmF0aGVyIGVhc2lseSBwb3J0
YWJsZSB0byBvdGhlciBEUk0gZHJpdmVycy4KClBsZWFzZSBjb21tZW50LApDaHJpc3RpYW4uCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwg
bWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
