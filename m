Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84722CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 12:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B124204FD
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 12:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B124204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B17FC6E84C;
	Mon, 28 Oct 2019 12:47:35 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D89E6E50D;
 Mon, 28 Oct 2019 09:32:31 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id AAD97303C5BBEF6020BB;
 Mon, 28 Oct 2019 17:32:28 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0;
 Mon, 28 Oct 2019 17:32:23 +0800
Subject: Re: [PATCH 0/3] drm/amd/display/dc/dce: remove some not used variables
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
References: <1570602312-49690-1-git-send-email-zhengbin13@huawei.com>
From: "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <96590591-d35f-6553-1b93-6d69a043590a@huawei.com>
Date: Mon, 28 Oct 2019 17:32:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1570602312-49690-1-git-send-email-zhengbin13@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 28 Oct 2019 12:47:35 +0000
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028093222.V6Ms424TH6K_0eUvdkzMqPRHIoO_F4q8LI7FRpGxelU@z>

cGluZwoKT24gMjAxOS8xMC85IDE0OjI1LCB6aGVuZ2JpbiB3cm90ZToKPiB6aGVuZ2JpbiAoMyk6
Cj4gICBkcm0vYW1kL2Rpc3BsYXk6IFJlbW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxlcwo+
ICAgICAnYmxfcHdtX2NudGwnLCdwd21fcGVyaW9kX2NudGwnCj4gICBkcm0vYW1kL2Rpc3BsYXk6
IFJlbW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxlICd2YWx1ZTAnCj4gICBkcm0vYW1kL2Rp
c3BsYXk6IFJlbW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxlcyAncmVndmFsJywnc3BlYWtl
cnMnCj4KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYWJtLmMgICAg
ICAgICAgICB8IDggKysrKy0tLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
ZS9kY2VfbGlua19lbmNvZGVyLmMgICB8IDMgKy0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY2UvZGNlX3N0cmVhbV9lbmNvZGVyLmMgfCA1ICstLS0tCj4gIDMgZmlsZXMgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKPgo+IC0tCj4gMi43LjQKPgo+
Cj4gLgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
