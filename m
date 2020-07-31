Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59301C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 06:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C99520829
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 06:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0hNTk18A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C99520829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE926E9E6;
	Fri, 31 Jul 2020 06:58:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82CF26E9E4;
 Fri, 31 Jul 2020 06:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNAgaY73+tJhoQfO78OFh0IT8dl21MNe+6lixvu+Q7zcjvz+MMYcf1WYEcYVZ3wgfHWRHF4TL8Pl0L0PbWKKLI9Vly0TfoXYXBYVyY5DraCtyaI6KVs9VHJzkP6hY0IFiK/9/9vWHNSGD26+CUJAuS8+eBPs2VGV+bfZVCymSMchNLae6C9SBAtr9S4zUJGRXDIaKMj5PVzdPYbk75AyMSDt6bzaJCxYict4HYa16Dowk0A5A/JBLCoe1ImX1aomo1F7pzCkzWVDbbzHFThPi2/6i0m/bTkoXqZ4I9SQfmasHedCwnuQmuwFMjHBYKNwLhjQC+ljv8dZCWkuxnnKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiGJwtdPGT/hh1eIRZDNKFNn8IjlOFp2g6vBWdKnsBY=;
 b=TaHqAHmZR/Cgid83/IMjaik9zcGzAeozsjL58hfGbrFhLLCAudoLEkiB1a4wBPnpg3gvqj9JwgMo2GHuyV7HSr27Ps26hmaAVJoQiHsfjHxFwXL/r12uju1e+3nACXHXX/kXAuM3xnRg/9p0YT8I6Qbkht7ANy9a8842L4dsumCZwAB+5JlFQZZ6S95gMsONm4KecS2JYE+OIKfSP43V4X/MxWcS6g4eZTBR9A7Po9Is9LV1hQhA7qIB4GEUuy+XXmEmdvKgtsjGdp3ynIKDdjKBL2l80eocTDBGLApZvd/dWU/pjaBxMF30newvgAEmceKRzUlBjADf/+DMniUmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiGJwtdPGT/hh1eIRZDNKFNn8IjlOFp2g6vBWdKnsBY=;
 b=0hNTk18Af7vdcGVK87s6rqP5XNvzW8bXGKf9ID7SdPidV/8Lr8q6MM7uLu327bLA970/FeWXIZ+uYblSmnm8rbruF5vEVNh/oyNHK+wZnQm12VR19gjROMuTrFiPUV1YgFRkEhd8rloWFlhqGayLzocV+yKtQ/H33qQRbcKamBY=
Authentication-Results: lists.linuxfoundation.org; dkim=none (message not
 signed) header.d=none;lists.linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 31 Jul
 2020 06:58:01 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 06:58:01 +0000
Subject: Re: [Linux-kernel-mentees] [PATCH] drm/amdgpu: Prevent
 kernel-infoleak in amdgpu_info_ioctl()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Luben Tuikov <luben.tuikov@amd.com>
References: <20200728192924.441570-1-yepeilin.cs@gmail.com>
 <30b2a31f-77c2-56c1-ecde-875c6eea99d5@gmail.com>
 <CADnq5_NXOiAc7q5gQqF_wwtJD1o6nHjXM4O3gY6EwAQe9iOtXw@mail.gmail.com>
 <8c5cf518-12d2-7495-7822-c7ebf8e61972@amd.com>
 <20200731065322.GA1518178@kroah.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <690213fd-d3d2-2253-dcb2-367a65b34f38@amd.com>
Date: Fri, 31 Jul 2020 08:57:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200731065322.GA1518178@kroah.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0145.eurprd05.prod.outlook.com
 (2603:10a6:207:3::23) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR05CA0145.eurprd05.prod.outlook.com (2603:10a6:207:3::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 06:57:58 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d729d82f-a85e-4670-7983-08d8351f1070
X-MS-TrafficTypeDiagnostic: MN2PR12MB4253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4253ADC9EAA0C67BE4A3A0BD834E0@MN2PR12MB4253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/R+ORIk3Lh7K50Msjj8z7g1kDpZfBdn7jT7ufslLalIPfSOeprtQsjYWTacVkoAI2KMPyu1EXrATGTT3VKbLzjtqXOUXKww7+hmH903VamgQKr0g8LlPrCNIRmeFc4XZqMxIXkBgJeb8WQue9Q4SxIyN7O4/1+c49u4tv9TnGhQElFh0UO2SepcNBc7XHqHQ7pUxHD1+jVreLvLuxFVpxI0WbTixeLzaLTSkKUgRop+gwK2QFKujOTwTXc2z7X2XIBskhbOtrcW2eLrVaCW4xgjqjzxjHjvCIjx891/kOwuRxheFcT1xyrUGCflx08bZlaBuygEkSkHq0E3uG9SJAUabyAlLgibLUWUvjif1KXsmoc0dV4vZsQTD3+FqQJ4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(478600001)(83380400001)(2906002)(2616005)(6636002)(8936002)(8676002)(31686004)(7416002)(4326008)(31696002)(5660300002)(52116002)(6486002)(316002)(66556008)(66476007)(86362001)(66946007)(54906003)(110136005)(36756003)(6666004)(53546011)(16526019)(186003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4qYWsVXA6Y8X9JWufzUJ8Y/Mzo1l6rjXh0YIKnZFXHuYqU9KMMdwkzz8wmYLBQqAfyWNhnUU819ApE+fER41zbK0KdQaA2uIHQG1egCtyKrRzACoyJ4rj6W+tImbguz99/zmZkXHvgLlxq465axLcXLwAKOb/sbMPLOpqaSJubipvvZyq/qoK5Fpcg5mi4UHukaKGzWRWd2p8CZ1cmAXBLMNPAxAdhzeqZ/rtITW4OMa6rxzFtsrwdT7G9HRbl9dN2gEYtNW4QismAGxWKllbYsYFgiJ8hCfKfXnYLab6rVur1qN47L4K8/gyqGk+s9Wv7bSrLyjPQjYobg4mAIQ50miSudVz/AnR6LWaqy3r/QmB9NE2MVm8we3fZi/iy1YG7YoPYISJOIVwZETzAcBjoLkiHlf5FUbbwVKsIJvX7VBU1KLTaS+M2FMMW3EBtWH7QmlAsbYqnBxX6OFAJhP2/HiQ7yTYZ2Hz0ejng8nk95xKSMZRjSiFDrnISaD1d5rjPQhJdzx2Jb94JOlmyiW3e5iquC8j/vSxDOMJWuQoy09Toe+/uIR0KclDO+fp4rjSE5xJMdNvXCg19uJrpY5Zc4E1fuR2lQUoyOB+0k7kTBVszPQDAUVZbzuai4yeIMt5/4Vo1blwYah69PpJVddN09x/ReJwNITGaKTGiviOP7oUhPw3HBLgB9TX6YvfcVYpo9ygpDJ+FujFoKZkDPrUg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d729d82f-a85e-4670-7983-08d8351f1070
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 06:58:01.5226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6UtAKS1hfGcILrXzOJZ0IGwwmbn0dXmpupQBIfWkWnsZlC8xFKh8dvCB3W1b9wu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
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
Cc: Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
 David Airlie <airlied@linux.ie>,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Felix Kuehling <Felix.Kuehling@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Peilin Ye <yepeilin.cs@gmail.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
 Hans de Goede <hdegoede@redhat.com>, Trek <trek00@inbox.ru>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Leo Liu <leo.liu@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMzEuMDcuMjAgdW0gMDg6NTMgc2NocmllYiBHcmVnIEtyb2FoLUhhcnRtYW46Cj4gT24gVGh1
LCBKdWwgMzAsIDIwMjAgYXQgMDU6MDk6MDdQTSAtMDQwMCwgTHViZW4gVHVpa292IHdyb3RlOgo+
PiBPbiAyMDIwLTA3LTI5IDk6NDkgYS5tLiwgQWxleCBEZXVjaGVyIHdyb3RlOgo+Pj4gT24gV2Vk
LCBKdWwgMjksIDIwMjAgYXQgNDoxMSBBTSBDaHJpc3RpYW4gS8O2bmlnCj4+PiA8Y2tvZW5pZy5s
ZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Pj4+IEFtIDI4LjA3LjIwIHVtIDIxOjI5
IHNjaHJpZWIgUGVpbGluIFllOgo+Pj4+PiBDb21waWxlciBsZWF2ZXMgYSA0LWJ5dGUgaG9sZSBu
ZWFyIHRoZSBlbmQgb2YgYGRldl9pbmZvYCwgY2F1c2luZwo+Pj4+PiBhbWRncHVfaW5mb19pb2N0
bCgpIHRvIGNvcHkgdW5pbml0aWFsaXplZCBrZXJuZWwgc3RhY2sgbWVtb3J5IHRvIHVzZXJzcGFj
ZQo+Pj4+PiB3aGVuIGBzaXplYCBpcyBncmVhdGVyIHRoYW4gMzU2Lgo+Pj4+Pgo+Pj4+PiBJbiAy
MDE1IHdlIHRyaWVkIHRvIGZpeCB0aGlzIGlzc3VlIGJ5IGRvaW5nIGA9IHt9O2Agb24gYGRldl9p
bmZvYCwgd2hpY2gKPj4+Pj4gdW5mb3J0dW5hdGVseSBkb2VzIG5vdCBpbml0aWFsaXplIHRoYXQg
NC1ieXRlIGhvbGUuIEZpeCBpdCBieSB1c2luZwo+Pj4+PiBtZW1zZXQoKSBpbnN0ZWFkLgo+Pj4+
Pgo+Pj4+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+Pj4+PiBGaXhlczogYzE5M2ZhOTFi
OTE4ICgiZHJtL2FtZGdwdTogaW5mb3JtYXRpb24gbGVhayBpbiBhbWRncHVfaW5mb19pb2N0bCgp
IikKPj4+Pj4gRml4ZXM6IGQzOGNlYWY5OWVkMCAoImRybS9hbWRncHU6IGFkZCBjb3JlIGRyaXZl
ciAodjQpIikKPj4+Pj4gU3VnZ2VzdGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVy
QG9yYWNsZS5jb20+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFBlaWxpbiBZZSA8eWVwZWlsaW4uY3NA
Z21haWwuY29tPgo+Pj4+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Cj4+Pj4KPj4+PiBJIGNhbid0IGNvdW50IGhvdyBtYW55IG9mIHRob3Nl
IHdlIGhhdmUgZml4ZWQgb3ZlciB0aGUgeWVhcnMuCj4+Pj4KPj4+PiBBdCBzb21lIHBvaW50IHdl
IHNob3VsZCBwcm9iYWJseSBkb2N1bWVudCB0aGF0IHVzaW5nICI9IHt9IiBvciAiPSB7IDAgfSIK
Pj4+PiBpbiB0aGUga2VybmVsIGlzIGEgcmVhbGx5IGJhZCBpZGVhIGFuZCBzaG91bGQgYmUgYXZv
aWRlZC4KPj4+IE1vcmVvdmVyLCBpdCBzZWVtcyBsaWtlIGRpZmZlcmVudCBjb21waWxlcnMgc2Vl
bSB0byBiZWhhdmUgcmVsYXRpdmVseQo+Pj4gZGlmZmVyZW50bHkgd2l0aCB0aGVzZSBhbmQgd2Ug
b2Z0ZW4gZ2V0IHJlcG9ydHMgb2Ygd2FybmluZ3Mgd2l0aCB0aGVzZQo+Pj4gb24gY2xhbmcuICBX
aGVuIGluIGRvdWJ0LCBtZW1zZXQuCj4+IFRoZXJlIGFyZSBxdWl0ZSBhIGZldyBvZiB0aG9zZSB1
bmRlciBkcml2ZXJzL2dwdS9kcm0sIGZvciAiYW1kLyIsICJzY2hlZHVsZXIvIgo+PiBkcm0qLmMg
ZmlsZXMsCj4+Cj4+ICRmaW5kIC4gXCggLXJlZ2V4ICIuL2RybS4qXC5jIiAtb3IgLXJlZ2V4ICIu
L2FtZC8uKlwuYyIgLW9yIC1yZWdleCAiLi9zY2hlZHVsZXIvLipcLmMiIFwpIC1leGVjIGVncmVw
IC1uIC0tICIgKj0gKnsgKih8TlVMTHwwKSAqfSIgXHtcfSBcKyB8IHdjIC1sCj4+IDM3NAo+PiAk
Xwo+Pgo+PiBPdXQgb2Ygd2hpY2ggb25seSAxNiBhcmUgb2YgdGhlIG5vbi1JU08gQyB2YXJpZXR5
LCAiPSB7fSIsCj4+Cj4+ICRmaW5kIC4gXCggLXJlZ2V4ICIuL2RybS4qXC5jIiAtb3IgLXJlZ2V4
ICIuL2FtZC8uKlwuYyIgLW9yIC1yZWdleCAiLi9zY2hlZHVsZXIvLipcLmMiIFwpIC1leGVjIGVn
cmVwIC1uIC0tICIgKj0gKnsgKn0iIFx7XH0gXCsgfCB3YyAtbAo+PiAxNgo+PiAkXwo+Pgo+PiBQ
ZXJoYXBzIHRoZSBsYXR0ZXIgYXJlIHRoZSBtb3JlIHByZXNzaW5nIG9uZXMsIHNpbmNlIGl0IGlz
IGEgQysrIGluaXRpYWxpemVyIGFuZCBub3QgYSBJU08gQyBvbmUuCj4gSXQgb25seSBtYXR0ZXJz
IHdoZW4gd2UgY2FyZSBjb3B5aW5nIHRoZSBkYXRhIHRvIHVzZXJzcGFjZSwgaWYgaXQgYWxsCj4g
c3RheXMgaW4gdGhlIGtlcm5lbCwgYWxsIGlzIGZpbmUuCgpXZWxsIG9ubHkgYXMgbG9uZyBhcyB5
b3UgZG9uJ3QgdHJ5IHRvIGNvbXB1dGUgYSBDUkMzMiwgTUQ1IG9yIGFueSAKZmluZ2VycHJpbnQg
Zm9yIGEgaGFzaCBmcm9tIHRoZSBieXRlcyBmcm9tIHRoZSBzdHJ1Y3R1cmUuCgpUaGVuIGl0IGZh
aWxzIGhvcnJpYmxlIGFuZCB5b3Ugd29uZGVyIHdoeSB0aGUgY29kZSBkb2Vzbid0IHdvcmtzIGFz
IApleHBlY3RlZC4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiB0aGFua3MsCj4KPiBncmVnIGst
aAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
