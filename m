From: Colin Ian King <colin.king@canonical.com>
Subject: re: drm/amd/display: Add HDCP module - static analysis bug report
Date: Thu, 3 Oct 2019 23:08:03 +0100
Message-ID: <951eb7dc-bebe-5049-4998-f199e18b0bf3@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Hi,

Static analysis with Coverity has detected a potential issue with
function validate_bksv in
drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c with recent
commit:

commit ed9d8e2bcb003ec94658cafe9b1bb3960e2139ec
Author: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Date:   Tue Aug 6 17:52:01 2019 -0400

    drm/amd/display: Add HDCP module


The analysis is as follows:

 28 static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
 29 {

CID 89852 (#1 of 1): Out-of-bounds read (OVERRUN)

1. overrun-local:
Overrunning array of 5 bytes at byte offset 7 by dereferencing pointer
(uint64_t *)hdcp->auth.msg.hdcp1.bksv.

 30        uint64_t n = *(uint64_t *)hdcp->auth.msg.hdcp1.bksv;
 31        uint8_t count = 0;
 32
 33        while (n) {
 34                count++;
 35                n &= (n - 1);
 36        }

hdcp->auth.msg.hdcp1.bksv is an array of 5 uint8_t as defined in
drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h as follows:

struct mod_hdcp_message_hdcp1 {
        uint8_t         an[8];
        uint8_t         aksv[5];
        uint8_t         ainfo;
        uint8_t         bksv[5];
        uint16_t        r0p;
        uint8_t         bcaps;
        uint16_t        bstatus;
        uint8_t         ksvlist[635];
        uint16_t        ksvlist_size;
        uint8_t         vp[20];

        uint16_t        binfo_dp;
};

variable n is going to contain the contains of r0p and bcaps. I'm not
sure if that is intentional. If not, then the count is going to be
incorrect if these are non-zero.

Colin
