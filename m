Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3939CC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 09:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00350206DD
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 09:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aXeEpZgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00350206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DA26E027;
	Fri, 22 May 2020 09:00:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A7436E027
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 09:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNBymdOnlInlaTWqWwphukXc2QqiP2b2+WxSpwsH4TwzJzV7aL1u2fxK4utpiml6AvKBW6oA+yYqtqkcwbVf3DX3Xcz4w29oFjU26vxgxlX0POt0TzrV/vCsIsAWqk9pLjJMcxAZHsy9OVO1UFkAJFcLPYVjoFgpYPcnkw78v0sbb+U5cQciZ8yPe1gjixm15qXE1yLxragSYrqUi1lqp/CPr2QPIM5O25Qw5yqFFgEwaX56Ko6oC2p6hOAIaEySCESx7FNlULMYLv7rBfMZmNhiOAft7c4/w6Yk+Z0Yc1b0nw/RfziCpj5Q+0Nr5Ume+y3KeOoLAFAgUujd+/v1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NPxefBy2FFKygUXDa8viNtvQvNP2+RYJQUAAnDilZo=;
 b=W2TsiR6JT/qShip/Yg1O5NXeeJ87Qt16sEUD/vR7cN6SFU+O8n4Wdje2zarjVs00HV+5bQURWigNHYrfUWBTmmg7iP5z7EqfluEmoMI4Yy1vO7zlbwKXspfmydHAol+K4or2Oh+Rm11auEED4OorApsyOAkCgbduNp9lNj06yJS4pWqXz3HGtRpCFD+8zyh0Gq62MZPY7nJw9t+dV1waPEe6iyJXCMPvXyc84iL30+5iU1WrStRdiwfNKNUQhNkCi2F/PzSVrWuPC/XIEIFJrrckvbbR3Sq7ZiJ/Kz2ulcOBjYnHreQoBKS9l9WbLVOFy3w9NK+4+aRWXIA7pzjcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NPxefBy2FFKygUXDa8viNtvQvNP2+RYJQUAAnDilZo=;
 b=aXeEpZgd4+1lHPSmpys/fzBk5+4P8fkNrWwMoxhVmihRU6dQBSZMHquL/nPsTyQa8Mcu/yTVIQLeWsDUPOnQ6Oh46LJmHFVXCRuBUx05giwRTOy0k2vRmwpST01Cu+QcQwXDX+03Dw7U3x23eQRke4/XAhmHoVtGodlJyZpsBqg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3706.namprd12.prod.outlook.com (2603:10b6:5:1cc::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 22 May
 2020 08:59:57 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.3021.026; Fri, 22 May 2020
 08:59:57 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: Sync with VM root BO when switching VM to
 CPU update mode
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200520225159.977-1-Felix.Kuehling@amd.com>
 <14ac63e1-a212-7540-fe65-523451bf6a89@gmail.com>
 <2cd1235f-9d2c-7f48-66ea-90e361d5178b@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ce69695d-f42a-3db9-b3be-b336164f78a6@amd.com>
Date: Fri, 22 May 2020 10:59:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <2cd1235f-9d2c-7f48-66ea-90e361d5178b@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0501CA0058.eurprd05.prod.outlook.com
 (2603:10a6:200:68::26) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR0501CA0058.eurprd05.prod.outlook.com (2603:10a6:200:68::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend
 Transport; Fri, 22 May 2020 08:59:56 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c48864e-61f7-4ac8-5d38-08d7fe2e8069
X-MS-TrafficTypeDiagnostic: DM6PR12MB3706:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37061AE286444CE3358523C383B40@DM6PR12MB3706.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NwVXNnGmBS88E/f/fAlaCnOb0IOgW+fb6AJLX2T/syNAR8B2lx6eQ5JFOkiBHKCtF12wgiExl0YuDpynPc+qqqlhz/dD1uubaBMOdiW09bXe6n1f7HQPCx4bnE2AAUxz1cGovQY8ZsNzqclXLtCMJzmiBSBU7KTgDjfLhn9LhNW9EErKFSAC6S8e872gLl9XL9CItBH5J/3GQjzVFX3ofOFJtGbm+AZCGDrImBDvhPvRmZ+yKZ8ZIEtB2p7Dv5308KmPqnNXFmYhqDlUbanAvhjXQhbBMfECcw/dfvNy8lKHKTV2AdKTFmS5C62PeOW6RLtx2zqAI3Gyp1B+hOrRGebw4xJkl33r/PTkDWrinAICQqGyFA5cjvlEnLmirbnS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(5660300002)(31696002)(4326008)(186003)(16526019)(8676002)(8936002)(316002)(2906002)(66556008)(86362001)(66946007)(478600001)(66476007)(15650500001)(36756003)(52116002)(66574014)(6486002)(31686004)(2616005)(6666004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ClYgG0bdmwri9UIcz6N45gwgzwMI7yCDePfumT1AswQwRAPTevE70mUuhYQLArbfmzQ5F53lBHKJaRKP4kf4ot5LELhDpNRGaaNAZnF2Hp4YwL6A//DIpCs6BaExQFDmaof5ZhuQcbJzIXthDafCRYIciRBzslun3yMrOxekmgZXcabLqIgQeayMEHPZlbQrQlYG53KDUjMyl4MqxlTL9xv6TxW7N/RnDCKvWxqNI2vsQKZQ7GhgZTNrUkGqz2PtXdpEJ+g6dBnfSM1bn3mDqktHl1CxEn6ip1xS8v6HHz+nEVVO3+usa9UScP0RiDvnqoEwXY3AkboojZ9KCUidJvbpN9VWYAn93MdxgXe5OTqmkWcm7lY2FSbq/WV4yAvLSLtbQ0r/1dxgDu4Bf8XTSA0lj7fQjYg0koLo2j9HAm5MceFTv0NWxAFqRi0gnBQY8ic9emO8A8VAzUXa5fOmU5LAukSOWr53mS2LzEdLpSDrnkVPzgVLoXy7V9sqczuU3Ndpa6u8NQeqQTEbvax6DqB+rrxInxzpgPKCTRTdvYQcK1rAUL+CJ+gifB01ATKr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c48864e-61f7-4ac8-5d38-08d7fe2e8069
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 08:59:57.4316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKrl28BEtbtunQNr+3msjkgY9pvAkSX4LfXI/9T8+Ys/kL7Us0cPUzoQVcxrMty+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3706
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
Cc: jay.cornwall@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjEuMDUuMjAgdW0gMTk6MDYgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBBbSAyMDIwLTA1
LTIxIHVtIDk6NTAgYS5tLiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+IEFtIDIxLjA1LjIw
IHVtIDAwOjUxIHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+PiBUaGlzIGZpeGVzIGFuIGludGVy
bWl0dGVudCBidWcgd2hlcmUgYSByb290IFBEIGNsZWFyIG9wZXJhdGlvbiBzdGlsbCBpbgo+Pj4g
cHJvZ3Jlc3MgY291bGQgb3ZlcndyaXRlIGEgUERFIHVwZGF0ZSBkb25lIGJ5IHRoZSBDUFUsIHJl
c3VsdGluZyBpbiBhCj4+PiBWTSBmYXVsdC4KPj4gTWhtLCBtYXliZSBiZXR0ZXIgYWRkIHRoaXMg
dG8gYW1kZ3B1X3ZtX2NwdV9wcmVwYXJlKCkuCj4+Cj4+IFRoaXMgd2F5IHdlIGNvdWxkIChpbiB0
aGVvcnkpIHN3aXRjaCBiZXR3ZWVuIENQVSBhbmQgU0RNQSBiYXNlZAo+PiB1cGRhdGVzIG9uIHRo
ZSBmbHkgZWxzZXdoZXJlIGFzIHdlbGwuCj4gVGhhdCB3b24ndCB3b3JrLiBJIHdhbnQgdG8gd2Fp
dCBmb3IgRkVOQ0VfT1dORVJfVk0gZmVuY2VzLCBzbyBJIG5lZWQgdG8KPiB1c2UgRkVOQ0VfT1dO
RVJfVU5ERUZJTkVELiBCdXQgdGhlbiBJIHdvdWxkIGFsc28gZW5kIHVwIHdhaXRpbmcgZm9yCj4g
RkVOQ0VfT1dORVJfS0ZEIGV2aWN0aW9uIGZlbmNlcywgd2hpY2ggd291bGQgdHJpZ2dlciB1bndh
bnRlZCBldmljdGlvbnMuCj4KPiBUaGlzIHdvcmtzIE9LIGluIGFtZGdwdV92bV9tYWtlX2NvbXB1
dGUgYmVjYXVzZSBpdCBydW5zIGJlZm9yZSB0aGUKPiBldmljdGlvbiBmZW5jZSBpcyBhdHRhY2hl
ZCB0byB0aGUgVk0uCgpPaywgaW4gdGhpcyBjYXNlIHRoZSBwYXRjaCBpcyBSZXZpZXdlZC1ieTog
Q2hyaXN0aWFuIEvDtm5pZyAKPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uCgo+Cj4gUmVnYXJk
cywKPiAgwqAgRmVsaXgKPgo+Cj4+IENocmlzdGlhbi4KPj4KPj4+IEZpeGVzOiAxMDhiNGQ5Mjhj
MDMgKCJkcm0vYW1kL2FtZGdwdTogVXBkYXRlIFZNIGZ1bmN0aW9uIHBvaW50ZXIiKQo+Pj4gUmVw
b3J0ZWQtYnk6IEpheSBDb3Jud2FsbCA8SmF5LkNvcm53YWxsQGFtZC5jb20+Cj4+PiBUZXN0ZWQt
Ynk6IEpheSBDb3Jud2FsbCA8SmF5LkNvcm53YWxsQGFtZC5jb20+Cj4+PiBTaWduZWQtb2ZmLWJ5
OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gIMKg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMTEgKysrKysrKysrLS0K
Pj4+ICDCoCAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+
Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
Ywo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4gaW5kZXgg
NDE0YTBiMWMyZTVhLi43NDE3NzU0ZTkxNDEgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMKPj4+IEBAIC0zMDAwLDEwICszMDAwLDE3IEBAIGludCBhbWRncHVf
dm1fbWFrZV9jb21wdXRlKHN0cnVjdAo+Pj4gYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFt
ZGdwdV92bSAqdm0sCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICFhbWRncHVfZ21jX3Zy
YW1fZnVsbF92aXNpYmxlKCZhZGV2LT5nbWMpKSwKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICJDUFUgdXBkYXRlIG9mIFZNIHJlY29tbWVuZGVkIG9ubHkgZm9yIGxhcmdlIEJBUiBzeXN0ZW1c
biIpOwo+Pj4gIMKgIC3CoMKgwqAgaWYgKHZtLT51c2VfY3B1X2Zvcl91cGRhdGUpCj4+PiArwqDC
oMKgIGlmICh2bS0+dXNlX2NwdV9mb3JfdXBkYXRlKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgLyog
U3luYyB3aXRoIGxhc3QgU0RNQSB1cGRhdGUvY2xlYXIgYmVmb3JlIHN3aXRjaGluZyB0byBDUFUg
Ki8KPj4+ICvCoMKgwqDCoMKgwqDCoCByID0gYW1kZ3B1X2JvX3N5bmNfd2FpdCh2bS0+cm9vdC5i
YXNlLmJvLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFNREdQ
VV9GRU5DRV9PV05FUl9VTkRFRklORUQsIHRydWUpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChy
KQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBmcmVlX2lkcjsKPj4+ICsKPj4+ICDC
oMKgwqDCoMKgwqDCoMKgwqAgdm0tPnVwZGF0ZV9mdW5jcyA9ICZhbWRncHVfdm1fY3B1X2Z1bmNz
Owo+Pj4gLcKgwqDCoCBlbHNlCj4+PiArwqDCoMKgIH0gZWxzZSB7Cj4+PiAgwqDCoMKgwqDCoMKg
wqDCoMKgIHZtLT51cGRhdGVfZnVuY3MgPSAmYW1kZ3B1X3ZtX3NkbWFfZnVuY3M7Cj4+PiArwqDC
oMKgIH0KPj4+ICDCoMKgwqDCoMKgIGRtYV9mZW5jZV9wdXQodm0tPmxhc3RfdXBkYXRlKTsKPj4+
ICDCoMKgwqDCoMKgIHZtLT5sYXN0X3VwZGF0ZSA9IE5VTEw7Cj4+PiAgwqDCoMKgwqDCoCB2bS0+
aXNfY29tcHV0ZV9jb250ZXh0ID0gdHJ1ZTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
