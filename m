Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99C6CA9EA0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 08:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8399C20B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 08:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8399C20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10DBA6E4AA;
	Mon, 28 Oct 2019 08:24:08 +0000 (UTC)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49D706E384;
 Mon, 28 Oct 2019 06:04:54 +0000 (UTC)
Received: by mail-pg1-x543.google.com with SMTP id p12so6160119pgn.6;
 Sun, 27 Oct 2019 23:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=lW+AMEtlabITQrPIpkqEPcUL1c8hvMDtNJcO22Y71bs=;
 b=XLFsV3p4eLWe/NzPqy15ubnx9L/GRgzfB9L31JBlsmr+GbAc0itTqWFK79N/els9wi
 wAjtCgPEuUFn8zb8JgGSPyy9E2CpbOAmu1rjyPdIhMnPcv9v/ZITeTytcfI8iOnJqabA
 yzy8wYEuWkbCUcVvvPUpP/P9XZjNPUk5FU5vD3NRs+e9bpizTspoDIhXdfq4eJM8ef88
 sBbPZmmSiPz4LEbMD8g3cp8lVWCaQxqZ97cyapOb9RVSWT/aUZiB6ywWWlb3Vc1QHkWc
 VGEbSWp4aD3HXdD22vtDTV5FI4Q2d37fDwIpYav3yqwOVuM9ORgAM+jrOf2ZNcHu8mpZ
 FQSA==
X-Gm-Message-State: APjAAAVrvdpkgXzE6dByh/dgmvbpjeEPg5pxNOF5Ve8BHXENNRwfWUxh
 AgIZemSoSZM4a2ZEUKKflIs=
X-Google-Smtp-Source: APXvYqypO2kpkDNISVJ7fsyBWXgUnI5+CNeeFIO21EiBsPoZf30U5WuHHFkB6bbCN9JfOQOvi3YBew==
X-Received: by 2002:a62:1454:: with SMTP id 81mr18453438pfu.43.1572242693463; 
 Sun, 27 Oct 2019 23:04:53 -0700 (PDT)
Received: from madhuparna-HP-Notebook.nitk.ac.in
 ([2402:3a80:539:cf3b:393e:2dcf:24de:b4fb])
 by smtp.gmail.com with ESMTPSA id d25sm1008366pfq.70.2019.10.27.23.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2019 23:04:52 -0700 (PDT)
From: madhuparnabhowmik04@gmail.com
To: harry.wentland@amd.com,
	alexander.deucher@amd.com
Subject: [PATCH] Drivers: gpu: drm: amd: display: amdgpu_dm: amdgpu_dm.h:
 Fixed a documentation warning
Date: Mon, 28 Oct 2019 11:34:43 +0530
Message-Id: <20191028060443.14997-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Mon, 28 Oct 2019 08:24:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=lW+AMEtlabITQrPIpkqEPcUL1c8hvMDtNJcO22Y71bs=;
 b=fA1GFgr0M7qMTfbFv+f/Ka2HxjRPYS4lE5hTtV7aQ/+wsXdC92oDJdyfBV8WlQXp+9
 EgaWvx17CWE7JOG/QdpW7S8nJtT4Yf6W4E0NZgO9bzQQIuwl3D39yXc7bnnl3KJcIPaN
 EVBLmGLrza4ev6kL97i+ybUziWXmpK7hdBVIbwKr0XEibvi7rkLUUZzD80/ov+7myDXg
 mMoHsByScueJM0AcBxi6wW05VZplyaKf6EUG7aFJdA8ufZZOndv4vBD5WYqTHsLCSeBD
 lk/GQJgJgH758N9hVMj3fW1uIgW9evdI80GELTyi3O+MKyh4oW9OHHr8gRqWhWVCRXnI
 NdwA==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
 linux-kernel-mentees@lists.linuxfoundation.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028060443.0dM__EQ6uw6Vz2MFLSM_hzPIVzynGZ-ouCM4NdjDw5c@z>

RnJvbTogTWFkaHVwYXJuYSBCaG93bWlrIDxtYWRodXBhcm5hYmhvd21pazA0QGdtYWlsLmNvbT4K
ClRoaXMgcGF0Y2ggZml4ZXMgdGhlIGZvbGxvd2luZyAgd2FybmluZzogSW5jb3JyZWN0IHVzZSBv
Zgoga2VybmVsLWRvYyBmb3JtYXQ6ICAgICAgICAgICogQGF0b21pY19vYmoKYnkgYWRkaW5nIGEg
Y29sb24gYWZ0ZXIgQGF0b21pY19vYmouCgpTaWduZWQtb2ZmLWJ5OiBNYWRodXBhcm5hIEJob3dt
aWsgPG1hZGh1cGFybmFiaG93bWlrMDRAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5oIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uaAppbmRleCBjOGM1MjVhMmI1MDUuLjgwZDUz
ZDA5NTc3MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbS5oCkBAIC0xMjgsNyArMTI4LDcgQEAgc3RydWN0IGFtZGdwdV9kaXNwbGF5X21h
bmFnZXIgewogCXUxNiBkaXNwbGF5X2luZGV4ZXNfbnVtOwogCiAJLyoqCi0JICogQGF0b21pY19v
YmoKKwkgKiBAYXRvbWljX29iajoKIAkgKgogCSAqIEluIGNvbWJpbmF0aW9uIHdpdGggJmRtX2F0
b21pY19zdGF0ZSBpdCBoZWxwcyBtYW5hZ2UKIAkgKiBnbG9iYWwgYXRvbWljIHN0YXRlIHRoYXQg
ZG9lc24ndCBtYXAgY2xlYW5seSBpbnRvIGV4aXN0aW5nCi0tIAoyLjE3LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
