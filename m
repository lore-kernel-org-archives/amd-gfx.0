Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FB5C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 08:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A04D60EB6
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 08:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9A04D60EB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA1D6E91B;
	Fri, 23 Jul 2021 08:45:54 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 939ED6E91B
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 08:45:52 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id r2so1529647wrl.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 01:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ku3RyrSLF62qsIdIbJRC5KKJP4EK0tOy9bH1BS8/0cg=;
 b=IE2m4Yp0EuZ2x17cnnkZs+20IUPbhao9zs4oKV7lDt1yPz7GjIpIGOltlZKJ5zp/rr
 cxRwMoOuZx7bx47yPZQK7dZIqa4dlIJ8IZO6lcn+BLFxcIMflDoAWtTiRK0Zru9R91Ig
 sSX6H6x28UXzNXd0OWYY4VkChbOTs3D/JWpNCP/Y1eNm5HvY+zI2wPYvItjxX7FCYVwF
 0/6+tjAOXqovjQwmoiKE/+TmxJ1zmzBkSobywT9c+VPrML/pxpnV5TplACWgeWTrAZQ3
 mjsUX2ZcgT2deV/krDDnXp2JUEDIIhx77h6Rqgj6RoN+4JKFDDl1tYbRfhmOlG1TK41j
 sHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ku3RyrSLF62qsIdIbJRC5KKJP4EK0tOy9bH1BS8/0cg=;
 b=EXM0KrCccI8xFpGjuzJVTq6iGYB3gohcNVKdAPQPSqegXOlrG5vAkS5fbcKvy4ukSC
 bR892/9LUtGWXHy2JRYZDIObsdV+UYBWgBq5dksgYKHAQPj3nH6Z/T7rp02YI10Yr7fu
 s9h5daQeLMNzaNRfqdU/VKebO/+EHEx4a2t0xK5z7gU2TmYen7ezJ0ckc4WPqI9/bOu1
 JbaIhYT80/vDi/tz32xKwjSNMhRXhindItgdeTRMJt2cUgKSvaiodZdsKLd1wyxNwxTs
 LyQr2osi397WXi+IZXCI0ZHsj7kUDBLCRpotu4FFgHFj5GShb3nAd4yA2/eKnrv5kJyH
 FTsg==
X-Gm-Message-State: AOAM5305Lij+PR/Flcv2CjGSR+2LhrTnnT8sOVQFoto9Aq9zbAfFwx3L
 N/M9PeB6/BOj3IAiJbPJYtOn5GLyMV0=
X-Google-Smtp-Source: ABdhPJw3AniW8n4HCiEwx3Hu8ZJ8W/QBlDbJKOFgYUmLSHV4FV7USwWqmBJjw1h9XQ55O4+4OkviNQ==
X-Received: by 2002:adf:fb92:: with SMTP id a18mr4088602wrr.182.1627029951237; 
 Fri, 23 Jul 2021 01:45:51 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:a0d7:cc1c:9090:5782?
 ([2a02:908:1252:fb60:a0d7:cc1c:9090:5782])
 by smtp.gmail.com with ESMTPSA id 19sm4642545wmj.2.2021.07.23.01.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jul 2021 01:45:50 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm: add tdr support for embeded hw_fence
To: Jingwen Chen <Jingwen.Chen2@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210721031352.413888-1-Jingwen.Chen2@amd.com>
 <20210721031352.413888-2-Jingwen.Chen2@amd.com>
 <36f53a64-2d9c-947b-a5fb-21d9fc06c5e4@amd.com>
 <20210722104525.okcnb43goxg6uqej@wayne-build>
 <0699ff85-4aec-0e33-711b-665307fbbc24@amd.com>
 <9dacfe83-da10-9806-81e0-70077dedce9f@gmail.com>
 <20210722164704.age63nzbviqg4y7v@wayne-build>
 <37b6c44f-2fa7-c507-7b77-13608285b362@gmail.com>
 <20210723070714.6h5pmxjebopv4zge@wayne-build>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <39e0cad8-c991-d685-1553-cdf87ab2d395@gmail.com>
Date: Fri, 23 Jul 2021 10:45:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723070714.6h5pmxjebopv4zge@wayne-build>
Content-Language: en-US
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: horace.chen@amd.com,
 "jingwen.chen2@amd.com Jack Zhang" <Jack.Zhang1@amd.com>, monk.liu@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjMuMDcuMjEgdW0gMDk6MDcgc2NocmllYiBKaW5nd2VuIENoZW46Cj4gW1NOSVBdCj4gSGkg
Q2hyaXN0aWFuLAo+Cj4gVGhlIHRoaW5nIGlzIHZtIGZsdXNoIGZlbmNlIGhhcyBubyBqb2IgcGFz
c2VkIHRvIGFtZGdwdV9mZW5jZV9lbWl0LCBzbwo+IGdvIHRocm91Z2ggdGhlIGpvYnMgY2Fubm90
IGhlbHAgZmluZCB0aGUgdm0gZmx1c2ggZmVuY2UuIEFuZCBrZWVwIHRoZQo+IHJlc3QgZmVuY2Vz
IGluIHRoZSBSQ1UgYXJyYXkgd2lsbCBsZWFkIHRvIHNpZ25hbGluZyB0aGVtIGluIHRoZSBpYl90
ZXN0Cj4gcmlnaHQgYWZ0ZXIgQVNJQyByZXNldC4gV2hpbGUgdGhleSB3aWxsIGJlIHNpZ25hbGVk
IGFnYWluIGR1cmluZwo+IHJlc3VibWlzc2lvbi4gV2hhdCBJJ20gZG9uaW5nIGhlcmUgaXMganVz
dCB0cnlpbmcgdG8gY2xlYW51cCB0aGUgZmVuY2VzCj4gd2l0aG91dCBhIHBhcmVudCBqb2IgYW5k
IG1ha2Ugc3VyZSB0aGUgcmVzdCBmZW5jZXMgd29uJ3QgYmUgc2lnbmFsZWQKPiB0d2ljZS4KCkl0
IHRvb2sgbWUgYSBtb21lbnQgdG8gcmVhbGl6ZSB3aGF0IHlvdSBhcmUgdGFsa2luZyBhYm91dCBo
ZXJlLgoKVGhpcyBpcyBmb3IgdGhlIEtJUSEgWW91IG5lZWQgZGlmZmVyZW50IGhhbmRsaW5nIGZv
ciB0aGUgS0lRIHRoYW4gZm9yIAp0aGUgc2NoZWR1bGVyIGNvbnRyb2xsZWQgcmluZ3MuCgpJdCBp
cyBub3Qgb25seSB0aGUgZmx1c2ggam9icywgYnV0IHRoZSBLSVEgbmVlZHMgYSBjb21wbGV0ZSBy
ZXNldCAKYmVjYXVzZSBvZiB0aGUgcmVnaXN0ZXIgd3JpdGVzIHB1c2hlZCB0aGVyZSBhcyB3ZWxs
LgoKPj4gQW5kIHBsZWFzZSBkcm9wIGFueSB1c2FnZSBvZiBETUFfRkVOQ0VfRkxBR19VU0VSX0JJ
VFMuIFRoYXQgaXMgbm90IHNvbWV0aGluZwo+PiB3aGljaCBzaG91bGQgYmUgYWJ1c2VkIGZvciBy
ZXNldCBoYW5kbGluZy4KPj4KPiBUaGUgRE1BX0ZFTkNFX0ZMQUdfVVNFUl9CSVRTIGhlcmUgaXMg
dG8gbWFyayB0aGlzIGZlbmNlIGhhcyBhIHBhcmVudAo+IGpvYi4gSWYgdGhpcyBpcyBub3QgYSBw
cm9wZXIgdXNhZ2UgaGVyZSwgZG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zCj4gYWJvdXQgaG93
IHRvIGlkZW50aWZ5IHdoZXRoZXIgdGhlIGZlbmNlIGhhcyBhIHBhcmVudCBqb2I/CgpZb3UgZG9u
J3QgbmVlZCB0byBtYXJrIHRoZSBmZW5jZXMgYXQgYWxsLiBFdmVyeXRoaW5nIG9uIHRoZSBLSVEg
cmluZyAKbmVlZHMgdG8gYmUgZm9yY2UgY29tcGxldGVkIHNpbmNlIG5vbmUgb2YgdGhlIGZlbmNl
cyBvbiB0aGF0IHJpbmcgaGF2ZSBhIApwYXJlbnQgam9iLgoKQ2hyaXN0aWFuLgoKPgo+IEJlc3Qg
UmVnYXJkcywKPiBKaW5nV2VuIENoZW4KPj4gUmVnYXJkcywKPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4K
Pj4+IEJlc3QgUmVnYXJkcywKPj4+IEppbmdXZW4gQ2hlbgo+Pj4+PiBBbmRyZXkKPj4+Pj4KPj4+
Pj4KPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4+Pj4+Pj4gICDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAvKiBhZnRlciBhbGwgaHcgam9icyBhcmUgcmVzZXQsIGh3IGZlbmNlIGlzCj4+Pj4+Pj4+
IG1lYW5pbmdsZXNzLCBzbyBmb3JjZV9jb21wbGV0aW9uICovCj4+Pj4+Pj4+ICAgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uKHJpbmcpOwo+
Pj4+Pj4+PiAgIMKgwqDCoMKgwqDCoCB9Cj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYwo+Pj4+Pj4+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCj4+Pj4+Pj4+IGluZGV4IGVlY2YyMWQ4ZWMzMy4u
ODE1Nzc2YzlhMDEzIDEwMDY0NAo+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZmVuY2UuYwo+Pj4+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZmVuY2UuYwo+Pj4+Pj4+PiBAQCAtMTU2LDExICsxNTYsMTcgQEAgaW50IGFt
ZGdwdV9mZW5jZV9lbWl0KHN0cnVjdAo+Pj4+Pj4+PiBhbWRncHVfcmluZyAqcmluZywgc3RydWN0
IGRtYV9mZW5jZSAqKmYsIHN0cnVjdCBhbWQKPj4+Pj4+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBqb2ItPnJpbmcgPSByaW5nOwo+Pj4+Pj4+PiAgIMKgwqDCoMKgwqDCoCB9Cj4+Pj4+Pj4+IC3C
oMKgwqAgc2VxID0gKytyaW5nLT5mZW5jZV9kcnYuc3luY19zZXE7Cj4+Pj4+Pj4+IC3CoMKgwqAg
ZG1hX2ZlbmNlX2luaXQoZmVuY2UsICZhbWRncHVfZmVuY2Vfb3BzLAo+Pj4+Pj4+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmcmluZy0+ZmVuY2VfZHJ2LmxvY2ssCj4+Pj4+Pj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZXYtPmZlbmNlX2NvbnRleHQgKyByaW5nLT5p
ZHgsCj4+Pj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlcSk7Cj4+Pj4+Pj4+
ICvCoMKgwqAgaWYgKGpvYiAhPSBOVUxMICYmIGpvYi0+YmFzZS5yZXN1Ym1pdF9mbGFnID09IDEp
IHsKPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qIHJlaW5pdCBzZXEgZm9yIHJlc3VibWl0dGVk
IGpvYnMgKi8KPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHNlcSA9ICsrcmluZy0+ZmVuY2VfZHJ2
LnN5bmNfc2VxOwo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgZmVuY2UtPnNlcW5vID0gc2VxOwo+
Pj4+Pj4+PiArwqDCoMKgIH0gZWxzZSB7Cj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBzZXEgPSAr
K3JpbmctPmZlbmNlX2Rydi5zeW5jX3NlcTsKPj4+Pj4+PiBTZWVtcyBsaWtlIHlvdSBjb3VsZCBk
byB0aGUgYWJvdmUgbGluZSBvbmx5IG9uY2UgYWJvdmUgaWYtZWxzZQo+Pj4+Pj4+IGFzIGl0IHdh
cwo+Pj4+Pj4+IGJlZm9yZQo+Pj4+Pj4gU3VyZSwgSSB3aWxsIG1vZGlmeSB0aGlzLgo+Pj4+Pj4K
Pj4+Pj4+Cj4+Pj4+PiBCZXN0IFJlZ2FyZHMsCj4+Pj4+PiBKaW5nV2VuIENoZW4KPj4+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIGRtYV9mZW5jZV9pbml0KGZlbmNlLCAmYW1kZ3B1X2ZlbmNlX29wcywK
Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmcmluZy0+ZmVuY2VfZHJ2
LmxvY2ssCj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRldi0+ZmVu
Y2VfY29udGV4dCArIHJpbmctPmlkeCwKPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzZXEpOwo+Pj4+Pj4+PiArwqDCoMKgIH0KPj4+Pj4+Pj4gICDCoMKgwqDCoMKgwqAg
aWYgKGpvYiAhPSBOVUxMKSB7Cj4+Pj4+Pj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogbWFy
ayB0aGlzIGZlbmNlIGhhcyBhIHBhcmVudCBqb2IgKi8KPj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYwo+Pj4+Pj4+PiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYwo+Pj4+Pj4+PiBpbmRleCA3YzQyNmUyMjVi
MjQuLmQ2Zjg0OGFkYzNmNCAxMDA2NDQKPj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2pvYi5jCj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9qb2IuYwo+Pj4+Pj4+PiBAQCAtMjQxLDYgKzI0MSw3IEBAIHN0YXRpYyBz
dHJ1Y3QgZG1hX2ZlbmNlCj4+Pj4+Pj4+ICphbWRncHVfam9iX3J1bihzdHJ1Y3QgZHJtX3NjaGVk
X2pvYiAqc2NoZWRfam9iKQo+Pj4+Pj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYV9mZW5j
ZV9zZXRfZXJyb3IoZmluaXNoZWQsIC1FQ0FOQ0VMRUQpOy8qIHNraXAKPj4+Pj4+Pj4gSUIgYXMg
d2VsbCBpZiBWUkFNIGxvc3QgKi8KPj4+Pj4+Pj4gICDCoMKgwqDCoMKgwqAgaWYgKGZpbmlzaGVk
LT5lcnJvciA8IDApIHsKPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGRtYV9mZW5jZV9wdXQoJmpv
Yi0+aHdfZmVuY2UpOwo+Pj4+Pj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgIERSTV9JTkZPKCJT
a2lwIHNjaGVkdWxpbmcgSUJzIVxuIik7Cj4+Pj4+Pj4+ICAgwqDCoMKgwqDCoMKgIH0gZWxzZSB7
Cj4+Pj4+Pj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqAgciA9IGFtZGdwdV9pYl9zY2hlZHVsZShy
aW5nLCBqb2ItPm51bV9pYnMsIGpvYi0+aWJzLCBqb2IsCj4+Pj4+Pj4+IEBAIC0yNDksNyArMjUw
LDggQEAgc3RhdGljIHN0cnVjdCBkbWFfZmVuY2UKPj4+Pj4+Pj4gKmFtZGdwdV9qb2JfcnVuKHN0
cnVjdCBkcm1fc2NoZWRfam9iICpzY2hlZF9qb2IpCj4+Pj4+Pj4+ICAgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBEUk1fRVJST1IoIkVycm9yIHNjaGVkdWxpbmcgSUJzICglZClcbiIsIHIp
Owo+Pj4+Pj4+PiAgIMKgwqDCoMKgwqDCoCB9Cj4+Pj4+Pj4+IC3CoMKgwqAgZG1hX2ZlbmNlX2dl
dChmZW5jZSk7Cj4+Pj4+Pj4+ICvCoMKgwqAgaWYgKCFqb2ItPmJhc2UucmVzdWJtaXRfZmxhZykK
Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGRtYV9mZW5jZV9nZXQoZmVuY2UpOwo+Pj4+Pj4+PiAg
IMKgwqDCoMKgwqDCoCBhbWRncHVfam9iX2ZyZWVfcmVzb3VyY2VzKGpvYik7Cj4+Pj4+Pj4+ICAg
wqDCoMKgwqDCoMKgIGZlbmNlID0gciA/IEVSUl9QVFIocikgOiBmZW5jZTsKPj4+Pj4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+Pj4+Pj4+
IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKPj4+Pj4+Pj4gaW5kZXgg
ZjRmNDc0OTQ0MTY5Li41YTM2YWI1YWVhMmQgMTAwNjQ0Cj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+Pj4+Pj4+IEBAIC01NDQsNiArNTQ0LDcgQEAg
dm9pZCBkcm1fc2NoZWRfcmVzdWJtaXRfam9ic19leHQoc3RydWN0Cj4+Pj4+Pj4+IGRybV9ncHVf
c2NoZWR1bGVyICpzY2hlZCwgaW50IG1heCkKPj4+Pj4+Pj4gZG1hX2ZlbmNlX3NldF9lcnJvcigm
c19mZW5jZS0+ZmluaXNoZWQsIC1FQ0FOQ0VMRUQpOwo+Pj4+Pj4+PiAgIMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGRtYV9mZW5jZV9wdXQoc19qb2ItPnNfZmVuY2UtPnBhcmVudCk7Cj4+Pj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoCBzX2pvYi0+cmVzdWJtaXRfZmxhZyA9IDE7Cj4+Pj4+Pj4+ICAgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZmVuY2UgPSBzY2hlZC0+b3BzLT5ydW5fam9iKHNfam9iKTsKPj4+Pj4+
Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpKys7Cj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2RybS9ncHVfc2NoZWR1bGVyLmggYi9pbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmgKPj4+
Pj4+Pj4gaW5kZXggNGVhODYwNmQ5MWZlLi4wNmMxMDFhZjFmNzEgMTAwNjQ0Cj4+Pj4+Pj4+IC0t
LSBhL2luY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaAo+Pj4+Pj4+PiArKysgYi9pbmNsdWRlL2Ry
bS9ncHVfc2NoZWR1bGVyLmgKPj4+Pj4+Pj4gQEAgLTE5OCw2ICsxOTgsNyBAQCBzdHJ1Y3QgZHJt
X3NjaGVkX2pvYiB7Cj4+Pj4+Pj4+ICAgwqDCoMKgwqDCoMKgIGVudW0gZHJtX3NjaGVkX3ByaW9y
aXR5wqDCoMKgwqDCoMKgwqAgc19wcmlvcml0eTsKPj4+Pj4+Pj4gICDCoMKgwqDCoMKgwqAgc3Ry
dWN0IGRybV9zY2hlZF9lbnRpdHnCoMKgwqDCoMKgwqDCoMKgICplbnRpdHk7Cj4+Pj4+Pj4+ICAg
wqDCoMKgwqDCoMKgIHN0cnVjdCBkbWFfZmVuY2VfY2LCoMKgwqDCoMKgwqDCoCBjYjsKPj4+Pj4+
Pj4gK8KgwqDCoCBpbnQgcmVzdWJtaXRfZmxhZzsKPj4+Pj4+Pj4gICDCoMKgIH07Cj4+Pj4+Pj4+
ICAgwqDCoCBzdGF0aWMgaW5saW5lIGJvb2wgZHJtX3NjaGVkX2ludmFsaWRhdGVfam9iKHN0cnVj
dAo+Pj4+Pj4+PiBkcm1fc2NoZWRfam9iICpzX2pvYiwKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
