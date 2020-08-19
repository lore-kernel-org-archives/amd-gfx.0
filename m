Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5852FC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 12:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058852063A
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 12:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h7U4bbKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058852063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C0176E2CF;
	Wed, 19 Aug 2020 12:08:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831C76E2DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 12:08:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NP6Ax5tkTwql8J4zafnZENcga7FuSdez7nJMp+4atN8ViW8jJbeYAVOv3eVlCU7mITnq4641youdhDCeGZalgL3VaGym0SWlfbdyUQNC8egS43OyfOU9nzT9dXJwvnPR6R4MKUN/zeSQ903upTimdOUsNvZTOIrhMtJLsRIwUNVVuYZ5y+8JYY4TlnrRYSL+P0IgASh4UbVeg+ykukOXI3/9bv2T8O85yCiz8t8EImCozQ1cbh5qpJVPeOdA6N9ApLhpmrLiRa7AxDLvysC2s7v2GQ60b1o+Xitbx/okzkhlrtsmax4oxDbpadBti3WYtOhhuVjEZESC9ebLWwHeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wy7iI9dgahESFtyNxbtJxpjY100s5l1O56IUuP06B6U=;
 b=Cs2MGOuPaBgGzItVRXyUswM3J3Dgw4RcXbXwwbikbH0X7kP1sSFwGv12HoKv5OxJAgkFQlGCtSVT3DrAxwzMHOFLw1r6vPphodEXVa/mDRV+Fh/lbVqf+1QPV2J1U6k/TNLGp+jKWD2qm5csu5/3ZNZCtE9y8W9MGQaTWNJTPf72DyUhRTk5JHSWu/PZDlxsykL11lpHcfMSTSIB0tPyZJ8wJwwCsr11imNgQFUaV9SRFqk+bwnSv3IlTkcBP6xPLxwD3Xy1eQ88OGxyIgNvQJj3pQiUMqZpm1/j/yWcMAX/bLzDAekkQJ2xrZt1whB//YwkoV+vLsD/fi70ZCcZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wy7iI9dgahESFtyNxbtJxpjY100s5l1O56IUuP06B6U=;
 b=h7U4bbKO8E0hPMNJtnbuXmHfEKmH1o/sglbKFdtFo4QYt8OGIkIMD1Yhi9wQxWJ4ZwYoTksChLDEfmIFWIhZ0H6tU/essE/PQlax5LSn9tUBjF7TQt4mNAlshMHWp3+be9bkIT3Vs0gNx8P53vr2Kha1A1vdZP32KVIUMGMu+a8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3679.namprd12.prod.outlook.com (2603:10b6:208:159::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 19 Aug
 2020 12:08:54 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 12:08:54 +0000
Subject: Re: [PATCH v4] drm/amdgpu: add new trace event for page table update
 v3
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200813030414.188468-1-shashank.sharma@amd.com>
 <35be9cda-025a-8f45-1648-00b96f57720e@amd.com>
 <ea572a64-37e4-d3db-f884-59f34bbdce38@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7dbb15c2-9b28-6c30-872c-e64fc51d4879@amd.com>
Date: Wed, 19 Aug 2020 14:08:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <ea572a64-37e4-d3db-f884-59f34bbdce38@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0117.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::22) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR06CA0117.eurprd06.prod.outlook.com (2603:10a6:208:ab::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 12:08:53 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c37c5242-f2a1-4141-056e-08d84438a448
X-MS-TrafficTypeDiagnostic: MN2PR12MB3679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3679125B4B3EF07D146B2340835D0@MN2PR12MB3679.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7kL8RU2osZAc4reA5Vy/yytR+kulTRvYrCxTdj/YnSFv7D9k01AKOPRcYLfrBwkK/Lbc2Rw04xl3Jp/5E3ds3Mz9teei7Xs0ZvuoWmU7PRl8le3v3VyhPSDcwdeS19HOC2+R206s2Hqx9OhKz8ceeWJV1ryYPsGtG+nzTlvfKwMWN96Zdzc/fGWIa/s7uwwQI02gruALVIWGJbwvp2nQvWi1y7YDb8OMm/lWULxcKYR18DUEN4hMSUYBeOTtznuTnCVO8HKH3+aj6rT4AxtMKUJX8rqrYw1Qf8IPJEEozXpOLeezAmHFr1jwF+9apl/6+AreLYnZifKVI+GzolBzSSJG9pIw/0vNv1UiDcCgW7GhttyLBFdzdR8DIJ5neP6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(2906002)(53546011)(31696002)(16526019)(186003)(52116002)(2616005)(66574015)(8936002)(83380400001)(86362001)(36756003)(5660300002)(66556008)(15650500001)(4326008)(8676002)(6666004)(478600001)(66946007)(316002)(66476007)(6486002)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uNeUWzdZyMIy+736Ax1/5Jj5YMA0Um98YBwqKG4FeIkgux+B7z8eFPH0nPya88p55jHmcFNc7j/63dritAFyXweZTK4eWqmrYAbXQc1iFBmmecycelSuM49KOkap84YAkA4vAyzUr0+71qryy+SkpEgBGFirC3L4A5B7PYGHyu7yvesaOumv7S0KeikEM99UHCwMTinLhWEC6f9mbZJAZArgq3qGotkALyxcyoUNqAWl/r6biilQ3khC3cfXtukEiFVeMHzWf6KNgLfAhqcgGBa6/JLqQJcAo479iha+oqZ+T8LulMRBDgAtifnlDMn/CDCsQbyCk9fQ/cMVnsywQsivxd4n1y2Gtwhs+DhSsnX5Zr/ElMXfsPuJifrsW9DczzIo8gLQwV8fyLIdCUqKgjf4Jd5i7KVSnaTJ0GpxJSo9FpQNSRoME3vkZ6vQNjQewP+EgzvzJXSv43zRU7aFrUm27IS9I63u1h390qv/FgA/PF2Zigq5gYWlQq6hL173FM2D2NvGFXO9FvYDWb/PNHLLHYEP8dxpXHQPpR1D1ZRosDqz81YIUUEL0quKM1ts1aAJR2SMCuLn6kBpVCW/SWO1TnF5DneRF7uiVQVzfvPb9kjQ0vFYfJ+5rH7jlTCHbK0WqIiX9zHKZvpz6qfQwr65vGgwsQtirryA10qbdvmxKyFJQj9cPvGS0i/JnP1jcB9cdYYT0dEsA44RKWXSzA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37c5242-f2a1-4141-056e-08d84438a448
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 12:08:54.0424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oak96arU2RBrpCYYnc2N4BzBvEhiSoBNX+Uahz1RgEyA2zg8bjDzFFlVwIswoPIL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3679
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

QW0gMTkuMDguMjAgdW0gMTM6NTIgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4gT24gMTMvMDgv
MjAgMToyOCBwbSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMTMuMDguMjAgdW0gMDU6
MDQgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+PiBUaGlzIHBhdGNoIGFkZHMgYSBuZXcgdHJh
Y2UgZXZlbnQgdG8gdHJhY2sgdGhlIFBURSB1cGRhdGUKPj4+IGV2ZW50cy4gVGhpcyBzcGVjaWZp
YyBldmVudCB3aWxsIHByb3ZpZGUgaW5mb3JtYXRpb24gbGlrZToKPj4+IC0gc3RhcnQgYW5kIGVu
ZCBvZiB2aXJ0dWFsIG1lbW9yeSBtYXBwaW5nCj4+PiAtIEhXIGVuZ2luZSBmbGFncyBmb3IgdGhl
IG1hcAo+Pj4gLSBwaHlzaWNhbCBhZGRyZXNzIGZvciBtYXBwaW5nCj4+Pgo+Pj4gVGhpcyB3aWxs
IGJlIHBhcnRpY3VsYXJseSB1c2VmdWwgZm9yIG1lbW9yeSBwcm9maWxpbmcgdG9vbHMKPj4+IChs
aWtlIFJNVikgd2hpY2ggYXJlIG1vbml0b3JpbmcgdGhlIHBhZ2UgdGFibGUgdXBkYXRlIGV2ZW50
cy4KPj4+Cj4+PiBWMjogQWRkZWQgcGh5c2ljYWwgYWRkcmVzcyBsb29rdXAgbG9naWMgaW4gdHJh
Y2UgcG9pbnQKPj4+IFYzOiBzd2l0Y2ggdG8gdXNlIF9fZHluYW1pY19hcnJheQo+Pj4gICAgICAg
YWRkZWQgbnB0ZXMgaW50IHRoZSBUUHByaW50IGFyZ3VtZW50cyBsaXN0Cj4+PiAgICAgICBhZGRl
ZCBwYWdlIHNpemUgaW4gdGhlIGFyZyBsaXN0Cj4+PiBWNDogQWRkcmVzc2VkIENocmlzdGlhbidz
IHJldmlldyBjb21tZW50cwo+Pj4gICAgICAgYWRkIHN0YXJ0L2VuZCBpbnN0ZWFkIG9mIHNlZwo+
Pj4gICAgICAgdXNlIGluY3IgaW5zdGVhZCBvZiBwYWdlX3N6IHRvIGJlIGFjY3VyYXRlCj4+Pgo+
Pj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4+IENj
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+PiBTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBTaGFzaGFuayBTaGFybWEgPHNoYXNoYW5rLnNoYXJtYUBhbWQuY29tPgo+Pj4g
LS0tCj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaCB8IDM3
ICsrKysrKysrKysrKysrKysrKysrKysrCj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYyAgICB8ICA5ICsrKystLQo+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCA0NCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+PiBpbmRleCA2M2U3MzRhMTI1ZmIuLmRmMTJjZjg0NjZj
MiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFj
ZS5oCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+
Pj4gQEAgLTMyMSw2ICszMjEsNDMgQEAgREVGSU5FX0VWRU5UKGFtZGdwdV92bV9tYXBwaW5nLCBh
bWRncHVfdm1fYm9fY3MsCj4+PiAgICAJICAgIFRQX0FSR1MobWFwcGluZykKPj4+ICAgICk7Cj4+
PiAgICAKPj4+ICtUUkFDRV9FVkVOVChhbWRncHVfdm1fdXBkYXRlX3B0ZXMsCj4+PiArCSAgICBU
UF9QUk9UTyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnAsCj4+PiArCQkgICAgIHVp
bnQ2NF90IHN0YXJ0LCB1aW50NjRfdCBlbmQsCj4+PiArCQkgICAgIHVuc2lnbmVkIGludCBucHRl
cywgdWludDY0X3QgZHN0LAo+Pj4gKwkJICAgICB1aW50NjRfdCBpbmNyLCB1aW50NjRfdCBmbGFn
cyksCj4+PiArCVRQX0FSR1MocCwgc3RhcnQsIGVuZCwgbnB0ZXMsIGRzdCwgaW5jciwgZmxhZ3Mp
LAo+Pj4gKwlUUF9TVFJVQ1RfX2VudHJ5KAo+Pj4gKwkJCSBfX2ZpZWxkKHU2NCwgc3RhcnQpCj4+
PiArCQkJIF9fZmllbGQodTY0LCBlbmQpCj4+PiArCQkJIF9fZmllbGQodTY0LCBmbGFncykKPj4+
ICsJCQkgX19maWVsZCh1bnNpZ25lZCBpbnQsIG5wdGVzKQo+Pj4gKwkJCSBfX2ZpZWxkKHU2NCwg
aW5jcikKPj4+ICsJCQkgX19keW5hbWljX2FycmF5KHU2NCwgZHN0LCBucHRlcykKPj4gQXMgZGlz
Y3Vzc2VkIHdpdGggdGhlIHRyYWNlIHN1YnN5c3RlbSBtYWludGFpbmVyIHdlIG5lZWQgdG8gYWRk
IHRoZSBwaWQKPj4gYW5kIHByb2JhYmx5IHRoZSBWTSBjb250ZXh0IElEIHdlIHVzZSBoZXJlIHRv
IGlkZW50aWZ5IHRoZSB1cGRhdGVkIFZNLgo+Pgo+PiBDaHJpc3RpYW4uCj4gSSBwcmludGVkIGJv
dGggdm0tPnRhc2tfaW5mby5waWQgVnMgY3VycmVudC0+cGlkIGZvciB0ZXN0aW5nLCBhbmQgSSBj
YW4gc2VlIGRpZmZlcmVudCB2YWx1ZXMgY29taW5nIG91dCBvZiAuCj4KPiBnbm9tZS1zaGVsbC0y
MTE0wqAgWzAxMV3CoMKgwqAgNDEuODEyODk0OiBhbWRncHVfdm1fdXBkYXRlX3B0ZXM6IHN0YXJ0
OjB4MDgwMDEwMmU4MCBlbmQ6MHgwODAwMTAyZTgyLCBmbGFnczoweDgwLCBpbmNyOjQwOTYsIHBp
ZD0yMTI4IHZtaWQ9MCBjcGlkPTIxMTQKPgo+IHBpZCBpcyB2bS0+dGFza19pbmZvLnBpZD0yMTI4
IHdoZXJlYXMgY3BpZD0yMTE0IGlzIGN1cnJlbnQucGlkLgo+Cj4gV2hpY2ggaXMgdGhlIG9uZSB3
ZSB3YW50IHRvIHNlbmQgd2l0aCB0aGUgZXZlbnQgPwoKVGhhdCBpcyB2bS0+dGFza19pbmZvLnBp
ZCwgc2luY2UgdGhpcyBpcyB0aGUgUElEIHdoaWNoIGlzIHVzaW5nIHRoZSBWTSAKZm9yIGNvbW1h
bmQgc3VibWlzc2lvbi4KCj4gVHJhY2UgZXZlbnQgYnkgZGVmYXVsdCBzZWVtcyB0byBiZSBhZGRp
bmcgdGhlIHByb2Nlc3MgbmFtZSBhbmQgaWQgYXQgdGhlIGhlYWRlciBvZiB0aGUgZXZlbnQgKGdu
b21lLXNoZWxsLTIxMTQpLCB3aGljaCBpcyBzYW1lIGFzIGN1cnJlbnQucGlkCj4KPgo+IEFsc28s
IGlzIGl0IG9rIHRvIGV4dHJhY3Qgdm1pZCBmcm9tIGpvYi0+dm1pZCA/CgpPbmx5IGluIHRyYWNl
X2FtZGdwdV92bV9ncmFiX2lkKCksIGluIGFsbCBvdGhlciBjYXNlcyBpdCdzIHByb2JhYmx5IG5v
dCAKYXNzaWduZWQgeWV0LgoKQ2hyaXN0aWFuLgoKPgo+Cj4gUmVnYXJkcwo+Cj4gU2hhc2hhbmsK
Pgo+Pj4gKwkpLAo+Pj4gKwo+Pj4gKwlUUF9mYXN0X2Fzc2lnbigKPj4+ICsJCQl1bnNpZ25lZCBp
bnQgaTsKPj4+ICsKPj4+ICsJCQlfX2VudHJ5LT5zdGFydCA9IHN0YXJ0Owo+Pj4gKwkJCV9fZW50
cnktPmVuZCA9IGVuZDsKPj4+ICsJCQlfX2VudHJ5LT5mbGFncyA9IGZsYWdzOwo+Pj4gKwkJCV9f
ZW50cnktPmluY3IgPSBpbmNyOwo+Pj4gKwkJCV9fZW50cnktPm5wdGVzID0gbnB0ZXM7Cj4+PiAr
CQkJZm9yIChpID0gMDsgaSA8IG5wdGVzOyArK2kpIHsKPj4+ICsJCQkJdTY0IGFkZHIgPSBwLT5w
YWdlc19hZGRyID8gYW1kZ3B1X3ZtX21hcF9nYXJ0KAo+Pj4gKwkJCQkJcC0+cGFnZXNfYWRkciwg
ZHN0KSA6IGRzdDsKPj4+ICsKPj4+ICsJCQkJKCh1NjQgKilfX2dldF9keW5hbWljX2FycmF5KGRz
dCkpW2ldID0gYWRkcjsKPj4+ICsJCQkJZHN0ICs9IGluY3I7Cj4+PiArCQkJfQo+Pj4gKwkpLAo+
Pj4gKwlUUF9wcmludGsoInN0YXJ0OjB4JTAxMGxseCBlbmQ6MHglMDEwbGx4LCBmbGFnczoweCVs
bHgsIGluY3I6JWxsdSwiCj4+PiArCQkgICIgZHN0OlxuJXMiLCBfX2VudHJ5LT5zdGFydCwgX19l
bnRyeS0+ZW5kLCBfX2VudHJ5LT5mbGFncywKPj4+ICsJCSAgX19lbnRyeS0+aW5jciwgX19wcmlu
dF9hcnJheSgKPj4+ICsJCSAgX19nZXRfZHluYW1pY19hcnJheShkc3QpLCBfX2VudHJ5LT5ucHRl
cywgOCkpCj4+PiArKTsKPj4+ICsKPj4+ICAgIFRSQUNFX0VWRU5UKGFtZGdwdV92bV9zZXRfcHRl
cywKPj4+ICAgIAkgICAgVFBfUFJPVE8odWludDY0X3QgcGUsIHVpbnQ2NF90IGFkZHIsIHVuc2ln
bmVkIGNvdW50LAo+Pj4gICAgCQkgICAgIHVpbnQzMl90IGluY3IsIHVpbnQ2NF90IGZsYWdzLCBi
b29sIGRpcmVjdCksCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4g
aW5kZXggNzFlMDA1Y2YyOTUyLi5iNWRiYjVlOGJjNjEgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+IEBAIC0xNTEzLDE3ICsxNTEzLDIyIEBAIHN0YXRp
YyBpbnQgYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFt
cyAqcGFyYW1zLAo+Pj4gICAgCQlkbyB7Cj4+PiAgICAJCQl1aW50NjRfdCB1cGRfZW5kID0gbWlu
KGVudHJ5X2VuZCwgZnJhZ19lbmQpOwo+Pj4gICAgCQkJdW5zaWduZWQgbnB0ZXMgPSAodXBkX2Vu
ZCAtIGZyYWdfc3RhcnQpID4+IHNoaWZ0Owo+Pj4gKwkJCXVpbnQ2NF90IHVwZF9mbGFncyA9IGZs
YWdzIHwgQU1ER1BVX1BURV9GUkFHKGZyYWcpOwo+Pj4gICAgCj4+PiAgICAJCQkvKiBUaGlzIGNh
biBoYXBwZW4gd2hlbiB3ZSBzZXQgaGlnaGVyIGxldmVsIFBEcyB0bwo+Pj4gICAgCQkJICogc2ls
ZW50IHRvIHN0b3AgZmF1bHQgZmxvb2RzLgo+Pj4gICAgCQkJICovCj4+PiAgICAJCQlucHRlcyA9
IG1heChucHRlcywgMXUpOwo+Pj4gKwo+Pj4gKwkJCXRyYWNlX2FtZGdwdV92bV91cGRhdGVfcHRl
cyhwYXJhbXMsIGZyYWdfc3RhcnQsIHVwZF9lbmQsCj4+PiArCQkJCQkJICAgIG5wdGVzLCBkc3Qs
IGluY3IsCj4+PiArCQkJCQkJICAgIHVwZF9mbGFncyk7Cj4+PiAgICAJCQlhbWRncHVfdm1fdXBk
YXRlX2ZsYWdzKHBhcmFtcywgcHQsIGN1cnNvci5sZXZlbCwKPj4+ICAgIAkJCQkJICAgICAgIHBl
X3N0YXJ0LCBkc3QsIG5wdGVzLCBpbmNyLAo+Pj4gLQkJCQkJICAgICAgIGZsYWdzIHwgQU1ER1BV
X1BURV9GUkFHKGZyYWcpKTsKPj4+ICsJCQkJCSAgICAgICB1cGRfZmxhZ3MpOwo+Pj4gICAgCj4+
PiAgICAJCQlwZV9zdGFydCArPSBucHRlcyAqIDg7Cj4+PiAtCQkJZHN0ICs9ICh1aW50NjRfdClu
cHRlcyAqIEFNREdQVV9HUFVfUEFHRV9TSVpFIDw8IHNoaWZ0Owo+Pj4gKwkJCWRzdCArPSBucHRl
cyAqIGluY3I7Cj4+PiAgICAKPj4+ICAgIAkJCWZyYWdfc3RhcnQgPSB1cGRfZW5kOwo+Pj4gICAg
CQkJaWYgKGZyYWdfc3RhcnQgPj0gZnJhZ19lbmQpIHsKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
