Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C4BC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 08:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389BA206C3
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 08:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qejZbQQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389BA206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75736E8CB;
	Wed, 12 Aug 2020 08:32:23 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700062.outbound.protection.outlook.com [40.107.70.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D52F6E8C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 08:32:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/tgD9w3ei6jBC0fK6d36gxIZ4ZKhgtIN8JAfvEzO30+fhXYOferPWxXf3im+C2UlMmu6jgBsUUYFqo1XHPIEgYpbuQ5lzBsxfP1Il4CWWJc/IukMI/Y8sNL3S39LyK3MhGOa5ICoqMzX9bt3xNzNUMjsRfBFPccasRxal6r0m0XlMScd/GAvebSVg/U57VSxp/wGdIYHmCgcF5VOKDBhdZunQrfG34sI8Eepe8vEzvSO2KLTYeQkruZZOeaD2TabwMR8sTeHASdW2UD8JReiZ0ICHEfxJ0OXRfj+6audq9jtjgzcdHo+URngQVaA+aZtvzkhUwc64UVwrGorgMPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0SqEFPdckYsrHAGL/1WVbcjPU07LFOG2dC0svTd+TQ=;
 b=KKFw2AhS1eCchsJh3Bt/AX44REhmfxTtGp6iOc0IRjdtxV3H8w9W0ZlcjO9qOfXuDPDqPjsYhgFt+K89K4raKEyskKth/VFwU+2NxYLBcejFrzjWctk5FZagzA+iNxaRfwbdndE88p1bGt6CGuqGmjJwpjJlpxs9KsNJ738NlNlYZQ0J7eO4HWHI3SgUY1OKlPSzC6rbFrLrr8tkWCMsdQ6Z/qYLtlR55fwVAvpWZ5/6r0vJvHRozOZK4OGbAkXP1YZ+q3pqlDjVLZN0msHBFgH76f0n0kq0ybeSL6QF6cfgaTpcypGWiAXHdGOhaMJjMlRbd9fZTSlSf/d/+sQLlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0SqEFPdckYsrHAGL/1WVbcjPU07LFOG2dC0svTd+TQ=;
 b=qejZbQQ9rACu6F+JcJMJlrMNc9wcIKnhjXIO45RItdCdEV5BlalT20HmOywb+1lc7i2IIHMF8X0E73Mkeq85rmW0QiQvhT76bN5l/ZJ0l4VYbObad5JBfQonKYZLHlmkewRTCZjsXgzfBIZYYGK/yAgdcc655SwhH44kI01YkhQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3725.namprd12.prod.outlook.com (2603:10b6:208:162::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 12 Aug
 2020 08:32:14 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3283.015; Wed, 12 Aug 2020
 08:32:14 +0000
Subject: Re: [PATCH v3] drm/amdgpu: add new trace event for page table update
 v3
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200812043336.127057-1-shashank.sharma@amd.com>
 <e32e6e5c-d808-44eb-7136-9b258c0201c1@gmail.com>
 <43f137f7-90cd-bb8b-f27f-a80a6c18aedc@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <be160250-b879-3478-2788-fee82dd60d53@amd.com>
Date: Wed, 12 Aug 2020 10:32:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <43f137f7-90cd-bb8b-f27f-a80a6c18aedc@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0109.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::14) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR01CA0109.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Wed, 12 Aug 2020 08:32:13 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 582bab1e-ac42-458a-4809-08d83e9a36ce
X-MS-TrafficTypeDiagnostic: MN2PR12MB3725:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3725D585DB385B53F37BFA5F83420@MN2PR12MB3725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKWRgzxRtCyLbkMMyflZztEC7rDIjIYSPGznZHEg33VSQcYaUNcxWYl1d9/nm5kjEuVX4Rcjfo4tmXP3Zhv61H5AxEYAgUzNlhwt11fBTQqHXvbF0UP8f0+X1GAF1Y6wf+Gqz7OQwoN/iL2o1ERwmpaxk6FsykRq671AgIZguDwPGdzPqUMpiC5Lucr2Ttgeg6J1+VOn8jJdsF4AhLpCAK2UkNAONNZC7wY0IZLDD2QEeA/L9SZKm5QZtZ9nF8Dn9Xr/1d1GCUbRmveaM5+SbxhoboddaRKk9ELA27pZQo9ZTKQyMK2feegRHfxkxw9CrDfPo1u00Kt7rYbzrCor2Qoxht/CGJyKdNgJj+OWFP3t+1b7jZV+nhP9CWuH60sL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(186003)(478600001)(86362001)(316002)(6486002)(66556008)(8936002)(2906002)(16526019)(8676002)(31686004)(66476007)(2616005)(66946007)(36756003)(66574015)(53546011)(83380400001)(52116002)(4326008)(31696002)(15650500001)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2Sg/bXOxmdJpOy9t49s+1YAa9ZnGJTeEQCFSGlVMv5NGnTPLPxTHip5R19uqGe2HP1tg8vAaObEMBHJpiLB0ueJJyhmKi0ARkOK5go7QVwKMtEK1hp9gAOczaKLWK9pIxax4x95ogApixvV32szMV5HpKt+kwNCYwSHlfGDODTJ3V8H8sim+yADqOrx2y5aV75msstpIaYJWpdbguzuGsIvlMbQHqxXxmY8swhfWDV0Ci3bEnjYTrRrPlzYQM24wUmsmNiuJe5uqz+5QG4ZpS9M6O/zUz9fckJ/e4YpdJ0cqGmkuwlCJYXgfxPsorkTCPINwb8UopL5cexTJpW/u3VGr9jJOCuaAEe1kSby8GddqLHXBqfKTCtbySlVhQ+4LoIA8WdvjX32udOAk4DeRGuoSlUx/16D9i605cxDiQ4C6WQ/vJADbekadWO3m7znkJUsZKdyJzyzaXpvPtLLKV7Cbgx15ThZeIwqdG/n6X7H6bCZCcsc40fR9gRcKp5fEcRnGYG/Wzo0L0at/uKOxTGUWqAey0FqUGzyazMMvXZ/D4B1/HH+8MjETm3PURRRfXmcKt1UPYYIxOvQ6ZfdbP8jD7MuqCrFqW24Y7eBOs05uaVGe8fPihjQ1HGski96FJ6tVfurTlX0oRqGW5H9GUOsuJ/m8M2gNUQ+d9849jxQuTghQu3wjp08/2rlcb/LBqV8KsJm3Gn/BFnELWjAiTA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582bab1e-ac42-458a-4809-08d83e9a36ce
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 08:32:14.1347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcZShkOoR1o183ej7ViSzFUYidPq+T6D8lWuwLNdxwZZVQ442j0Wt45D5OuAWvfS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3725
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTIuMDguMjAgdW0gMTA6MTUgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4gSGVsbG8gQ2hy
aXN0aWFuLAo+Cj4gT24gMTIvMDgvMjAgMTI6MTUgcG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6
Cj4+IEFtIDEyLjA4LjIwIHVtIDA2OjMzIHNjaHJpZWIgU2hhc2hhbmsgU2hhcm1hOgo+Pj4gVGhp
cyBwYXRjaCBhZGRzIGEgbmV3IHRyYWNlIGV2ZW50IHRvIHRyYWNrIHRoZSBQVEUgdXBkYXRlCj4+
PiBldmVudHMuIFRoaXMgc3BlY2lmaWMgZXZlbnQgd2lsbCBwcm92aWRlIGluZm9ybWF0aW9uIGxp
a2U6Cj4+PiAtIHN0YXJ0IGFuZCBlbmQgb2YgdmlydHVhbCBtZW1vcnkgbWFwcGluZwo+Pj4gLSBI
VyBlbmdpbmUgZmxhZ3MgZm9yIHRoZSBtYXAKPj4+IC0gcGh5c2ljYWwgYWRkcmVzcyBmb3IgbWFw
cGluZwo+Pj4KPj4+IFRoaXMgd2lsbCBiZSBwYXJ0aWN1bGFybHkgdXNlZnVsIGZvciBtZW1vcnkg
cHJvZmlsaW5nIHRvb2xzCj4+PiAobGlrZSBSTVYpIHdoaWNoIGFyZSBtb25pdG9yaW5nIHRoZSBw
YWdlIHRhYmxlIHVwZGF0ZSBldmVudHMuCj4+Pgo+Pj4gVjI6IEFkZGVkIHBoeXNpY2FsIGFkZHJl
c3MgbG9va3VwIGxvZ2ljIGluIHRyYWNlIHBvaW50Cj4+PiBWMzogc3dpdGNoIHRvIHVzZSBfX2R5
bmFtaWNfYXJyYXkKPj4+ICAgICAgIGFkZGVkIG5wdGVzIGludCB0aGUgVFBwcmludCBhcmd1bWVu
dHMgbGlzdAo+Pj4gICAgICAgYWRkZWQgcGFnZSBzaXplIGluIHRoZSBhcmcgbGlzdAo+Pj4KPj4+
IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+PiBDYzog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+Pj4gU2lnbmVkLW9mZi1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4gU2lnbmVk
LW9mZi1ieTogU2hhc2hhbmsgU2hhcm1hIDxzaGFzaGFuay5zaGFybWFAYW1kLmNvbT4KPj4+IC0t
LQo+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmggfCAzOCAr
KysrKysrKysrKysrKysrKysrKysrKwo+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMgICAgfCAgOSArKysrLS0KPj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgNDUgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdHJhY2UuaAo+Pj4gaW5kZXggNjNlNzM0YTEyNWZiLi5iOWFhZTc5ODNiNGIg
MTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2Uu
aAo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPj4+
IEBAIC0zMjEsNiArMzIxLDQ0IEBAIERFRklORV9FVkVOVChhbWRncHVfdm1fbWFwcGluZywgYW1k
Z3B1X3ZtX2JvX2NzLAo+Pj4gICAgCSAgICBUUF9BUkdTKG1hcHBpbmcpCj4+PiAgICApOwo+Pj4g
ICAgCj4+PiArVFJBQ0VfRVZFTlQoYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzLAo+Pj4gKwkgICAgVFBf
UFJPVE8oc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwLAo+Pj4gKwkJICAgICB1aW50
NjRfdCBzdGFydCwgdWludDY0X3QgZW5kLAo+Pj4gKwkJICAgICB1bnNpZ25lZCBpbnQgbnB0ZXMs
IHVpbnQ2NF90IGRzdCwKPj4+ICsJCSAgICAgdWludDY0X3QgaW5jciwgdWludDY0X3QgZmxhZ3Mp
LAo+Pj4gKwlUUF9BUkdTKHAsIHN0YXJ0LCBlbmQsIG5wdGVzLCBkc3QsIGluY3IsIGZsYWdzKSwK
Pj4+ICsJVFBfU1RSVUNUX19lbnRyeSgKPj4+ICsJCQkgX19maWVsZCh1NjQsIHN0YXJ0KQo+Pj4g
KwkJCSBfX2ZpZWxkKHU2NCwgZW5kKQo+Pj4gKwkJCSBfX2ZpZWxkKHU2NCwgZmxhZ3MpCj4+PiAr
CQkJIF9fZmllbGQodTY0LCBpbmNyKQo+Pj4gKwkJCSBfX2ZpZWxkKHVuc2lnbmVkIGludCwgbnB0
ZXMpCj4+PiArCQkJIF9fZHluYW1pY19hcnJheSh1NjQsIGRzdCwgbnB0ZXMpCj4+PiArCSksCj4+
PiArCj4+PiArCVRQX2Zhc3RfYXNzaWduKAo+Pj4gKwkJCXVuc2lnbmVkIGludCBpOwo+Pj4gKwo+
Pj4gKwkJCV9fZW50cnktPnN0YXJ0ID0gc3RhcnQ7Cj4+PiArCQkJX19lbnRyeS0+ZW5kID0gZW5k
Owo+Pj4gKwkJCV9fZW50cnktPmZsYWdzID0gZmxhZ3M7Cj4+PiArCQkJX19lbnRyeS0+aW5jciA9
IGluY3I7Cj4+PiArCQkJX19lbnRyeS0+bnB0ZXMgPSBucHRlczsKPj4+ICsKPj4+ICsJCQlmb3Ig
KGkgPSAwOyBpIDwgbnB0ZXM7ICsraSkgewo+Pj4gKwkJCQl1NjQgYWRkciA9IHAtPnBhZ2VzX2Fk
ZHIgPyBhbWRncHVfdm1fbWFwX2dhcnQoCj4+PiArCQkJCQlwLT5wYWdlc19hZGRyLCBkc3QpIDog
ZHN0Owo+Pj4gKwo+Pj4gKwkJCQkoKHU2NCAqKV9fZ2V0X2R5bmFtaWNfYXJyYXkoZHN0KSlbaV0g
PSBhZGRyOwo+Pj4gKwkJCQlkc3QgKz0gaW5jcjsKPj4+ICsJCQl9Cj4+PiArCSksCj4+PiArCVRQ
X3ByaW50aygic2VnOjB4JTAxMGxseC0weCUwMTBsbHgsIGZsYWdzOjB4JWxseCwgbnB0cj0ldSwg
cGdzejolbGx1LCIKPj4+ICsJCSAgIiBkc3Q6XG4lcyIsIF9fZW50cnktPnN0YXJ0LCBfX2VudHJ5
LT5lbmQsIF9fZW50cnktPmZsYWdzLAo+Pj4gKwkJICBfX2VudHJ5LT5ucHRlcywgX19lbnRyeS0+
aW5jciwKPj4gVGhpcyBpcyBub3QgY29ycmVjdC4gVGhlIGluY3JlbWVudCBpcyBOT1QgdGhlIHBh
Z2Ugc2l6ZSwgYnV0IHJhdGhlciB0aGUKPj4gcGFnZSBzaXplIHJvdW5kZWQgZG93biB0byBhIHBv
d2VyIG9mIDUxMis0Sy4KPj4KPj4gSW4gb3RoZXIgd29yZHMgcGFnZSBzaXplIGNhbiBiZSA0Sywg
OEssIDE2SywgMzJLLCA2NEsuLi4uMU0sIDJNLAo+PiA0TS4uLi41MTJNLCAxRywgMkcuLi4uCj4+
Cj4+IEJ1dCB0aGUgaW5jcmVtZW50IGNhbiBvbmx5IGJlIDRLLCAyTSwgMUcuLi4uCj4gVW5kZXJz
dG9vZC4gQnV0IEkgdGhpbmsgdGhlIHJlcXVpcmVtZW50IGhlcmUgaXMgZm9yIGluY3JlbWVudC4g
TXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZSB0b29sIG5lZWRzIHRvIHNhdmUgdGhlIHBhZ2Ug
ZW50cmllcywgYW5kIGZvciB0aGF0LCBpdCB3aWxsIG5lZWQgc3RhcnQgb2YgdmlydHVhbCBtZW0s
IHN0YXJ0IG9mIHBoeXNpY2FsIG1lbSwgbWFwcGluZyBzaXplIGFuZCBzdGVwIHRvIGluY3JlbWVu
dCB0aGUgZW50cmllcy4gSWYgdGhhdCdzIHNvLCB3ZSBjYW4gcmUtbGFiZWwgdGhpcyBlbnRyeSBh
cyAic3RlcCIgaW5zdGVhZCBvZiAicGFnZSBzaXplIi4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHlv
dSB0aGluayBpdCdzIHRoZSByaWdodCB0aGluZyB0byBkby4KCldlIGNvdWxkIHN0aWNrIHdpdGgg
dGhlIG5hbWluZyBpbmNyZW1lbnQgaWYgdGhhdCBoZWxwcywgYnV0IHRoaXMgY2FuIAphbHNvIGJl
IGRlcml2ZWQgZnJvbSB0aGUgbnVtYmVyIG9mIGRlc3RpbmF0aW9uIGFkZHJlc3NlcyB3ZSBoYXZl
LgoKT24gdGhlIG90aGVyIGhhbmQgZXhwbGljaXRseSBtZW50aW9uaW5nIGl0IHByb2JhYmx5IHdv
bid0IGh1cnQgdXMgZWl0aGVyLgoKQW5kIGJ5IHRoZSB3YXkgd2hhdCBkb2VzICJzZWciIG1lYW4/
CgpDaHJpc3RpYW4uCgo+PiBBbmQgZG8gd2UgbmVlZCB0aGUgbnB0ZXMgaGVyZT8gV2UganVzdCBu
ZWVkIGl0IHRvIHByaW50IHRoZSBjb3JyZWN0Cj4+IG51bWJlciBvZiBkZXN0aW5hdGlvbiBhZGRy
ZXNzZXMuCj4gQWdyZWUsIHdlIGRvbid0IHJlYWxseSBuZWVkIG5wdGVzIGhlcmUsIEkgd2lsbCBy
ZW1vdmUgdGhhdCBhbmQgc2VuZCBWNC4KPgo+IC0gU2hhc2hhbmsKPgo+PiBSZWdhcmRzLAo+PiBD
aHJpc3RpYW4uCj4+Cj4+PiArCQkgIF9fcHJpbnRfYXJyYXkoX19nZXRfZHluYW1pY19hcnJheShk
c3QpLCBfX2VudHJ5LT5ucHRlcywgOCkpCj4+PiArKTsKPj4+ICsKPj4+ICAgIFRSQUNFX0VWRU5U
KGFtZGdwdV92bV9zZXRfcHRlcywKPj4+ICAgIAkgICAgVFBfUFJPVE8odWludDY0X3QgcGUsIHVp
bnQ2NF90IGFkZHIsIHVuc2lnbmVkIGNvdW50LAo+Pj4gICAgCQkgICAgIHVpbnQzMl90IGluY3Is
IHVpbnQ2NF90IGZsYWdzLCBib29sIGRpcmVjdCksCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYwo+Pj4gaW5kZXggNzFlMDA1Y2YyOTUyLi5iNWRiYjVlOGJjNjEgMTAwNjQ0
Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+IEBAIC0xNTEzLDE3
ICsxNTEzLDIyIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKHN0cnVjdCBhbWRn
cHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLAo+Pj4gICAgCQlkbyB7Cj4+PiAgICAJCQl1aW50
NjRfdCB1cGRfZW5kID0gbWluKGVudHJ5X2VuZCwgZnJhZ19lbmQpOwo+Pj4gICAgCQkJdW5zaWdu
ZWQgbnB0ZXMgPSAodXBkX2VuZCAtIGZyYWdfc3RhcnQpID4+IHNoaWZ0Owo+Pj4gKwkJCXVpbnQ2
NF90IHVwZF9mbGFncyA9IGZsYWdzIHwgQU1ER1BVX1BURV9GUkFHKGZyYWcpOwo+Pj4gICAgCj4+
PiAgICAJCQkvKiBUaGlzIGNhbiBoYXBwZW4gd2hlbiB3ZSBzZXQgaGlnaGVyIGxldmVsIFBEcyB0
bwo+Pj4gICAgCQkJICogc2lsZW50IHRvIHN0b3AgZmF1bHQgZmxvb2RzLgo+Pj4gICAgCQkJICov
Cj4+PiAgICAJCQlucHRlcyA9IG1heChucHRlcywgMXUpOwo+Pj4gKwo+Pj4gKwkJCXRyYWNlX2Ft
ZGdwdV92bV91cGRhdGVfcHRlcyhwYXJhbXMsIGZyYWdfc3RhcnQsIHVwZF9lbmQsCj4+PiArCQkJ
CQkJICAgIG5wdGVzLCBkc3QsIGluY3IsCj4+PiArCQkJCQkJICAgIHVwZF9mbGFncyk7Cj4+PiAg
ICAJCQlhbWRncHVfdm1fdXBkYXRlX2ZsYWdzKHBhcmFtcywgcHQsIGN1cnNvci5sZXZlbCwKPj4+
ICAgIAkJCQkJICAgICAgIHBlX3N0YXJ0LCBkc3QsIG5wdGVzLCBpbmNyLAo+Pj4gLQkJCQkJICAg
ICAgIGZsYWdzIHwgQU1ER1BVX1BURV9GUkFHKGZyYWcpKTsKPj4+ICsJCQkJCSAgICAgICB1cGRf
ZmxhZ3MpOwo+Pj4gICAgCj4+PiAgICAJCQlwZV9zdGFydCArPSBucHRlcyAqIDg7Cj4+PiAtCQkJ
ZHN0ICs9ICh1aW50NjRfdClucHRlcyAqIEFNREdQVV9HUFVfUEFHRV9TSVpFIDw8IHNoaWZ0Owo+
Pj4gKwkJCWRzdCArPSBucHRlcyAqIGluY3I7Cj4+PiAgICAKPj4+ICAgIAkJCWZyYWdfc3RhcnQg
PSB1cGRfZW5kOwo+Pj4gICAgCQkJaWYgKGZyYWdfc3RhcnQgPj0gZnJhZ19lbmQpIHsKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
