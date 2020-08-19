Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2369BC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 12:37:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA277206FA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 12:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DiOOm9eU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA277206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84CDE6E091;
	Wed, 19 Aug 2020 12:37:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 264506E091
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 12:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loyz6/8vhCVPo22s8WEzfFIX/rmRZuSLmoszo7UsB6QpyTyQfZaeYXU277VYek3Tqj6VZ+g1g+LOHybShqC+GIQCLlgttCLT8Z2gYFM5Lba8a7rB+UMCkZHtXWdfTVm7B6IBjS1lzMbLYX4qFhl4kBsvTTFwuQxrgX/SH6ScB0iMJGLIQw7Ivj/cRlDQHMVmjzxsgkFEVJaEKlkzbp/yHkVh4Fxt+rfGDuapZerUUkfaLpqxGRgdWzaWFWtwCaMwmsgcO/g3EljqsCxKYB+nbusd5PfiMfk9zxPG9aAhGmntPFp0mbEG2dV0K1otagqLWcOd6QOxKe0jPx0X3vJhBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t9kBs+u64MQQGsFL0YrM5QIJ83Zf9phaOCunlPcBjs=;
 b=T88BNciwKIdj4N/WPodnP74HeX0a2jTlfB0FoNQg9TvUxqjMutvj8Jb5UxgGIZ8fyW6bgoBGcjNRWLn+8P3E6BB6zJjKZT3DJoZO6LaXKrOjIYSkLmuQu9wYJ41S6jgqr+6soJNZvI0EA03BkzrF3cpQK94M1KK2pz3vVTQ4b/+P/7rqq2vkZ/eWQUx6ESRfB+hzEl/h5spV/YKIXRcC2EAZaZvIojHK43xfe9MoqGUBLf0xlIDKDGyUAP89kC6FDhoWub98tbD7geqsZaief65R1tSL6UAfg8EaC31UQ8qO8McjdOEh7QXCYU5kVnVMngY4FCZsbCBnvPWRzY+Ucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t9kBs+u64MQQGsFL0YrM5QIJ83Zf9phaOCunlPcBjs=;
 b=DiOOm9eUe2iIScyyZlA0AtO2G8dLBYAU4aIozcbRUP5uf2BqgLqrkTmLkzAWyBmQhxgt9+0gjEXguKPctRFin8cdsAAIxaT24CGqgDhvc0lMrd9YT6Kic6ffsEEDP7gHMvImjuKGFh95YNonYBYN3C/wR77NL15P8jaqk5uo4kY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BYAPR12MB2792.namprd12.prod.outlook.com (2603:10b6:a03:65::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Wed, 19 Aug
 2020 12:37:25 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4%5]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 12:37:25 +0000
Subject: Re: [PATCH v4] drm/amdgpu: add new trace event for page table update
 v3
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20200813030414.188468-1-shashank.sharma@amd.com>
 <35be9cda-025a-8f45-1648-00b96f57720e@amd.com>
 <ea572a64-37e4-d3db-f884-59f34bbdce38@amd.com>
 <7dbb15c2-9b28-6c30-872c-e64fc51d4879@amd.com>
 <3cc6b2fe-995d-581a-5e56-913a0cf60b42@amd.com>
 <42ef3112-81fb-d58b-4335-c19655f5db07@gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <99ecca3a-c2bb-f11a-6786-e0dfb853ba88@amd.com>
Date: Wed, 19 Aug 2020 18:07:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
In-Reply-To: <42ef3112-81fb-d58b-4335-c19655f5db07@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: MAXPR0101CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::32) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.113] (106.51.110.102) by
 MAXPR0101CA0046.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Wed, 19 Aug 2020 12:37:24 +0000
X-Originating-IP: [106.51.110.102]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e17a2bfb-c4c6-47eb-2cd1-08d8443ca086
X-MS-TrafficTypeDiagnostic: BYAPR12MB2792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB27921F28160AA69105C77AE3F25D0@BYAPR12MB2792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3074Wrib1SpjbSZS/3wF2JlUpHfuRJjNJQr09RdmyVSlyMRKG2tIFOsWhq9Jdr3HAIq2a37gM/+UNAOqXiNDg0uISE5ByL2YdzKa8o5cUR806oT5Li4+JKNcysavS0aK7x6Er5tHFrvZY9LaNru3AJz00gb7EfsyPivMSNJ6QaKuCpG8SznqNzUv9C+oKjo599Y32/FKBz37mZwz6VC3zqlO+D6xftmFZOr/IuSN31Zu1Tdw/0dZ60Do6bn/g9jkzZh9sT/Y8dAwpbZ3/IaCNs83u84KqEewVoleDUODSvqbKAVnl0h0L9MRWPj4x01qGTb48DZSJ3T16DlYvflevvS/iDAy0O0Du8B+WFh0NWLk2EFrH5rTQ1ZiPQpLM+kPD55/ruLzACapQnuwzD/SpOjC7SZT2E5ClVQdWwDs7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(966005)(55236004)(45080400002)(6486002)(83380400001)(31686004)(15650500001)(66556008)(31696002)(52116002)(36756003)(2616005)(44832011)(66476007)(86362001)(2906002)(478600001)(53546011)(4326008)(16576012)(956004)(66946007)(316002)(66574015)(1006002)(186003)(26005)(16526019)(8936002)(8676002)(6666004)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nDbhC86Zb6MUWXD4yYEzs0okrDfTK2nEKrtLY7TsAptuH4Gw2KjuLQ2B1rqTkfoU3ctpc+QCUYUNVvt566cpCelpwvL+3ZL90BVLpZcin+GoMQ2nvnQ89zMOCmrKXzvA1ffDYDz9qb6k8xKtMo8Uz4i4Sf/pmWFjjXgO/nSsEiOrv6grcaQzOm/s3ByoTsf7vlr86Wxc5WBGpUVBgAmUDLvGyzUpAR1yTUFSclHijaaOQmCz7NIy2TgjpmvzVb7MyFuleEo2T+RgRvpKyRCT8OTrQWice7wODj7dy9H5sYMGDB8q64D8wlJ5pAjH6gH/Pe+lX2qhBXpI69Cb2k+mEDljszoiJkkvbDhRh8DU2tErL6W3eCBKTglzFhERY2/HnqnCwR86+Hm/2KFUVSt0NgnhsssTm/msSkBW7oazbTsBgKaXf97E337dWp/OQbcFIL3yELMCzO+udAi/787k2l7aK7hHIxQVcfgYt58UoqQIHvGGZwQvWEOFOuuJzHcuLLr+k0/ILIccbucDjEh+8qdWYH4n7jIX7gh7jevptV0CvHNW52I0LAtpvjVtWpyADfWrman+XkXdBfXw8Heg0GHoktjZaMzdNrWIJKTzjlXk/cj1jybdGt9v+G+Ff7+6HVqyJYLT+KoXQxlolHhoGw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17a2bfb-c4c6-47eb-2cd1-08d8443ca086
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 12:37:25.5629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCDsrvr1Im6eJ3+KkC3JIA6e9aVSpo/II28w9ROsXlpTEsbw0ZFqi7GvMJwgm2Jpddyj1j9HMSAP+N7busy+1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2792
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDE5LzA4LzIwIDY6MDMgcG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTkuMDgu
MjAgdW0gMTQ6MTkgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+IE9uIDE5LzA4LzIwIDU6Mzgg
cG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAxOS4wOC4yMCB1bSAxMzo1MiBzY2hy
aWViIFNoYXNoYW5rIFNoYXJtYToKPj4+PiBPbiAxMy8wOC8yMCAxOjI4IHBtLCBDaHJpc3RpYW4g
S8O2bmlnIHdyb3RlOgo+Pj4+PiBBbSAxMy4wOC4yMCB1bSAwNTowNCBzY2hyaWViIFNoYXNoYW5r
IFNoYXJtYToKPj4+Pj4+IFRoaXMgcGF0Y2ggYWRkcyBhIG5ldyB0cmFjZSBldmVudCB0byB0cmFj
ayB0aGUgUFRFIHVwZGF0ZQo+Pj4+Pj4gZXZlbnRzLiBUaGlzIHNwZWNpZmljIGV2ZW50IHdpbGwg
cHJvdmlkZSBpbmZvcm1hdGlvbiBsaWtlOgo+Pj4+Pj4gLSBzdGFydCBhbmQgZW5kIG9mIHZpcnR1
YWwgbWVtb3J5IG1hcHBpbmcKPj4+Pj4+IC0gSFcgZW5naW5lIGZsYWdzIGZvciB0aGUgbWFwCj4+
Pj4+PiAtIHBoeXNpY2FsIGFkZHJlc3MgZm9yIG1hcHBpbmcKPj4+Pj4+Cj4+Pj4+PiBUaGlzIHdp
bGwgYmUgcGFydGljdWxhcmx5IHVzZWZ1bCBmb3IgbWVtb3J5IHByb2ZpbGluZyB0b29scwo+Pj4+
Pj4gKGxpa2UgUk1WKSB3aGljaCBhcmUgbW9uaXRvcmluZyB0aGUgcGFnZSB0YWJsZSB1cGRhdGUg
ZXZlbnRzLgo+Pj4+Pj4KPj4+Pj4+IFYyOiBBZGRlZCBwaHlzaWNhbCBhZGRyZXNzIGxvb2t1cCBs
b2dpYyBpbiB0cmFjZSBwb2ludAo+Pj4+Pj4gVjM6IHN3aXRjaCB0byB1c2UgX19keW5hbWljX2Fy
cmF5Cj4+Pj4+PiAgICAgICAgYWRkZWQgbnB0ZXMgaW50IHRoZSBUUHByaW50IGFyZ3VtZW50cyBs
aXN0Cj4+Pj4+PiAgICAgICAgYWRkZWQgcGFnZSBzaXplIGluIHRoZSBhcmcgbGlzdAo+Pj4+Pj4g
VjQ6IEFkZHJlc3NlZCBDaHJpc3RpYW4ncyByZXZpZXcgY29tbWVudHMKPj4+Pj4+ICAgICAgICBh
ZGQgc3RhcnQvZW5kIGluc3RlYWQgb2Ygc2VnCj4+Pj4+PiAgICAgICAgdXNlIGluY3IgaW5zdGVh
ZCBvZiBwYWdlX3N6IHRvIGJlIGFjY3VyYXRlCj4+Pj4+Pgo+Pj4+Pj4gQ2M6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4+Pj4+IENjOiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5
OiBTaGFzaGFuayBTaGFybWEgPHNoYXNoYW5rLnNoYXJtYUBhbWQuY29tPgo+Pj4+Pj4gLS0tCj4+
Pj4+PiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmggfCAzNyAr
KysrKysrKysrKysrKysrKysrKysrKwo+Pj4+Pj4gICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jICAgIHwgIDkgKysrKy0tCj4+Pj4+PiAgICAgMiBmaWxlcyBjaGFuZ2Vk
LCA0NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4+Pj4KPj4+Pj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaCBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+Pj4+PiBpbmRleCA2M2U3MzRhMTI1
ZmIuLmRmMTJjZjg0NjZjMiAxMDA2NDQKPj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdHJhY2UuaAo+Pj4+Pj4gQEAgLTMyMSw2ICszMjEsNDMgQEAgREVGSU5FX0VW
RU5UKGFtZGdwdV92bV9tYXBwaW5nLCBhbWRncHVfdm1fYm9fY3MsCj4+Pj4+PiAgICAgCSAgICBU
UF9BUkdTKG1hcHBpbmcpCj4+Pj4+PiAgICAgKTsKPj4+Pj4+ICAgICAKPj4+Pj4+ICtUUkFDRV9F
VkVOVChhbWRncHVfdm1fdXBkYXRlX3B0ZXMsCj4+Pj4+PiArCSAgICBUUF9QUk9UTyhzdHJ1Y3Qg
YW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnAsCj4+Pj4+PiArCQkgICAgIHVpbnQ2NF90IHN0YXJ0
LCB1aW50NjRfdCBlbmQsCj4+Pj4+PiArCQkgICAgIHVuc2lnbmVkIGludCBucHRlcywgdWludDY0
X3QgZHN0LAo+Pj4+Pj4gKwkJICAgICB1aW50NjRfdCBpbmNyLCB1aW50NjRfdCBmbGFncyksCj4+
Pj4+PiArCVRQX0FSR1MocCwgc3RhcnQsIGVuZCwgbnB0ZXMsIGRzdCwgaW5jciwgZmxhZ3MpLAo+
Pj4+Pj4gKwlUUF9TVFJVQ1RfX2VudHJ5KAo+Pj4+Pj4gKwkJCSBfX2ZpZWxkKHU2NCwgc3RhcnQp
Cj4+Pj4+PiArCQkJIF9fZmllbGQodTY0LCBlbmQpCj4+Pj4+PiArCQkJIF9fZmllbGQodTY0LCBm
bGFncykKPj4+Pj4+ICsJCQkgX19maWVsZCh1bnNpZ25lZCBpbnQsIG5wdGVzKQo+Pj4+Pj4gKwkJ
CSBfX2ZpZWxkKHU2NCwgaW5jcikKPj4+Pj4+ICsJCQkgX19keW5hbWljX2FycmF5KHU2NCwgZHN0
LCBucHRlcykKPj4+Pj4gQXMgZGlzY3Vzc2VkIHdpdGggdGhlIHRyYWNlIHN1YnN5c3RlbSBtYWlu
dGFpbmVyIHdlIG5lZWQgdG8gYWRkIHRoZSBwaWQKPj4+Pj4gYW5kIHByb2JhYmx5IHRoZSBWTSBj
b250ZXh0IElEIHdlIHVzZSBoZXJlIHRvIGlkZW50aWZ5IHRoZSB1cGRhdGVkIFZNLgo+Pj4+Pgo+
Pj4+PiBDaHJpc3RpYW4uCj4+Pj4gSSBwcmludGVkIGJvdGggdm0tPnRhc2tfaW5mby5waWQgVnMg
Y3VycmVudC0+cGlkIGZvciB0ZXN0aW5nLCBhbmQgSSBjYW4gc2VlIGRpZmZlcmVudCB2YWx1ZXMg
Y29taW5nIG91dCBvZiAuCj4+Pj4KPj4+PiBnbm9tZS1zaGVsbC0yMTE0wqAgWzAxMV3CoMKgwqAg
NDEuODEyODk0OiBhbWRncHVfdm1fdXBkYXRlX3B0ZXM6IHN0YXJ0OjB4MDgwMDEwMmU4MCBlbmQ6
MHgwODAwMTAyZTgyLCBmbGFnczoweDgwLCBpbmNyOjQwOTYsIHBpZD0yMTI4IHZtaWQ9MCBjcGlk
PTIxMTQKPj4+Pgo+Pj4+IHBpZCBpcyB2bS0+dGFza19pbmZvLnBpZD0yMTI4IHdoZXJlYXMgY3Bp
ZD0yMTE0IGlzIGN1cnJlbnQucGlkLgo+Pj4+Cj4+Pj4gV2hpY2ggaXMgdGhlIG9uZSB3ZSB3YW50
IHRvIHNlbmQgd2l0aCB0aGUgZXZlbnQgPwo+Pj4gVGhhdCBpcyB2bS0+dGFza19pbmZvLnBpZCwg
c2luY2UgdGhpcyBpcyB0aGUgUElEIHdoaWNoIGlzIHVzaW5nIHRoZSBWTQo+Pj4gZm9yIGNvbW1h
bmQgc3VibWlzc2lvbi4KPj4gZ290IGl0Lgo+Pj4+IFRyYWNlIGV2ZW50IGJ5IGRlZmF1bHQgc2Vl
bXMgdG8gYmUgYWRkaW5nIHRoZSBwcm9jZXNzIG5hbWUgYW5kIGlkIGF0IHRoZSBoZWFkZXIgb2Yg
dGhlIGV2ZW50IChnbm9tZS1zaGVsbC0yMTE0KSwgd2hpY2ggaXMgc2FtZSBhcyBjdXJyZW50LnBp
ZAo+Pj4+Cj4+Pj4KPj4+PiBBbHNvLCBpcyBpdCBvayB0byBleHRyYWN0IHZtaWQgZnJvbSBqb2It
PnZtaWQgPwo+Pj4gT25seSBpbiB0cmFjZV9hbWRncHVfdm1fZ3JhYl9pZCgpLCBpbiBhbGwgb3Ro
ZXIgY2FzZXMgaXQncyBwcm9iYWJseSBub3QKPj4+IGFzc2lnbmVkIHlldC4KPj4gT2ssIGxldCBt
ZSBjaGVjayBob3cgY2FuIHdlIGdldCB2bWlkIGZyb20gdGhpcyBjb250ZXh0IHdlIGFyZSBzZW5k
aW5nIHRoZSBldmVudCBmcm9tLiBPciBtYXliZSBJIHdlIHNob3VsZMKgIGtlZXAgVjUgd2l0aCBw
aWQgb25seSwgYW5kIGxhdGVyIHNlbmQgYSBzZXBhcmF0ZSBwYXRjaCB0byBhZGQgdm1pZCA/Cj4g
SSdtIG5vdCBzdXJlIGhvdyB5b3Ugd2FudCB0byBnZXQgYSBWTUlEIGluIHRoZSBmaXJzdCBwbGFj
ZS4gV2UgCj4gZHluYW1pY2FsbHkgYXNzaWduIFZNSURzIGR1cmluZyBjb21tYW5kIHN1Ym1pc3Np
b24uCj4KPiBTZWUgdGhlIGFtZGdwdV92bV9ncmFiX2lkIHRyYWNlIHBvaW50LgoKQWN0dWFsbHkg
SSB3YXMgYWRkaW5nIHZtaWQgdG8gYWRkcmVzcyB0aGlzIGxhc3QgY29tbWVudCBvbiBWNDrCoAo+
IGFuZCBwcm9iYWJseSB0aGUgVk0gY29udGV4dCBJRCB3ZSB1c2UgaGVyZSB0byBpZGVudGlmeSB0
aGUgdXBkYXRlZCBWTS4KCkkgYXNzdW1lZCB5b3UgbWVhbnQgdGhlIHZtaWQgYnkgdGhpcywgaXMg
dGhhdCBub3Qgc28gPwoKClJlZ2FyZHMKClNoYXNoYW5rCgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+IC0g
U2hhc2hhbmsKPj4KPj4+IENocmlzdGlhbi4KPj4+Cj4+Pj4gUmVnYXJkcwo+Pj4+Cj4+Pj4gU2hh
c2hhbmsKPj4+Pgo+Pj4+Pj4gKwkpLAo+Pj4+Pj4gKwo+Pj4+Pj4gKwlUUF9mYXN0X2Fzc2lnbigK
Pj4+Pj4+ICsJCQl1bnNpZ25lZCBpbnQgaTsKPj4+Pj4+ICsKPj4+Pj4+ICsJCQlfX2VudHJ5LT5z
dGFydCA9IHN0YXJ0Owo+Pj4+Pj4gKwkJCV9fZW50cnktPmVuZCA9IGVuZDsKPj4+Pj4+ICsJCQlf
X2VudHJ5LT5mbGFncyA9IGZsYWdzOwo+Pj4+Pj4gKwkJCV9fZW50cnktPmluY3IgPSBpbmNyOwo+
Pj4+Pj4gKwkJCV9fZW50cnktPm5wdGVzID0gbnB0ZXM7Cj4+Pj4+PiArCQkJZm9yIChpID0gMDsg
aSA8IG5wdGVzOyArK2kpIHsKPj4+Pj4+ICsJCQkJdTY0IGFkZHIgPSBwLT5wYWdlc19hZGRyID8g
YW1kZ3B1X3ZtX21hcF9nYXJ0KAo+Pj4+Pj4gKwkJCQkJcC0+cGFnZXNfYWRkciwgZHN0KSA6IGRz
dDsKPj4+Pj4+ICsKPj4+Pj4+ICsJCQkJKCh1NjQgKilfX2dldF9keW5hbWljX2FycmF5KGRzdCkp
W2ldID0gYWRkcjsKPj4+Pj4+ICsJCQkJZHN0ICs9IGluY3I7Cj4+Pj4+PiArCQkJfQo+Pj4+Pj4g
KwkpLAo+Pj4+Pj4gKwlUUF9wcmludGsoInN0YXJ0OjB4JTAxMGxseCBlbmQ6MHglMDEwbGx4LCBm
bGFnczoweCVsbHgsIGluY3I6JWxsdSwiCj4+Pj4+PiArCQkgICIgZHN0OlxuJXMiLCBfX2VudHJ5
LT5zdGFydCwgX19lbnRyeS0+ZW5kLCBfX2VudHJ5LT5mbGFncywKPj4+Pj4+ICsJCSAgX19lbnRy
eS0+aW5jciwgX19wcmludF9hcnJheSgKPj4+Pj4+ICsJCSAgX19nZXRfZHluYW1pY19hcnJheShk
c3QpLCBfX2VudHJ5LT5ucHRlcywgOCkpCj4+Pj4+PiArKTsKPj4+Pj4+ICsKPj4+Pj4+ICAgICBU
UkFDRV9FVkVOVChhbWRncHVfdm1fc2V0X3B0ZXMsCj4+Pj4+PiAgICAgCSAgICBUUF9QUk9UTyh1
aW50NjRfdCBwZSwgdWludDY0X3QgYWRkciwgdW5zaWduZWQgY291bnQsCj4+Pj4+PiAgICAgCQkg
ICAgIHVpbnQzMl90IGluY3IsIHVpbnQ2NF90IGZsYWdzLCBib29sIGRpcmVjdCksCj4+Pj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4+Pj4gaW5kZXggNzFlMDA1Y2Yy
OTUyLi5iNWRiYjVlOGJjNjEgMTAwNjQ0Cj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMKPj4+Pj4+IEBAIC0xNTEzLDE3ICsxNTEzLDIyIEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFy
YW1zLAo+Pj4+Pj4gICAgIAkJZG8gewo+Pj4+Pj4gICAgIAkJCXVpbnQ2NF90IHVwZF9lbmQgPSBt
aW4oZW50cnlfZW5kLCBmcmFnX2VuZCk7Cj4+Pj4+PiAgICAgCQkJdW5zaWduZWQgbnB0ZXMgPSAo
dXBkX2VuZCAtIGZyYWdfc3RhcnQpID4+IHNoaWZ0Owo+Pj4+Pj4gKwkJCXVpbnQ2NF90IHVwZF9m
bGFncyA9IGZsYWdzIHwgQU1ER1BVX1BURV9GUkFHKGZyYWcpOwo+Pj4+Pj4gICAgIAo+Pj4+Pj4g
ICAgIAkJCS8qIFRoaXMgY2FuIGhhcHBlbiB3aGVuIHdlIHNldCBoaWdoZXIgbGV2ZWwgUERzIHRv
Cj4+Pj4+PiAgICAgCQkJICogc2lsZW50IHRvIHN0b3AgZmF1bHQgZmxvb2RzLgo+Pj4+Pj4gICAg
IAkJCSAqLwo+Pj4+Pj4gICAgIAkJCW5wdGVzID0gbWF4KG5wdGVzLCAxdSk7Cj4+Pj4+PiArCj4+
Pj4+PiArCQkJdHJhY2VfYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKHBhcmFtcywgZnJhZ19zdGFydCwg
dXBkX2VuZCwKPj4+Pj4+ICsJCQkJCQkgICAgbnB0ZXMsIGRzdCwgaW5jciwKPj4+Pj4+ICsJCQkJ
CQkgICAgdXBkX2ZsYWdzKTsKPj4+Pj4+ICAgICAJCQlhbWRncHVfdm1fdXBkYXRlX2ZsYWdzKHBh
cmFtcywgcHQsIGN1cnNvci5sZXZlbCwKPj4+Pj4+ICAgICAJCQkJCSAgICAgICBwZV9zdGFydCwg
ZHN0LCBucHRlcywgaW5jciwKPj4+Pj4+IC0JCQkJCSAgICAgICBmbGFncyB8IEFNREdQVV9QVEVf
RlJBRyhmcmFnKSk7Cj4+Pj4+PiArCQkJCQkgICAgICAgdXBkX2ZsYWdzKTsKPj4+Pj4+ICAgICAK
Pj4+Pj4+ICAgICAJCQlwZV9zdGFydCArPSBucHRlcyAqIDg7Cj4+Pj4+PiAtCQkJZHN0ICs9ICh1
aW50NjRfdClucHRlcyAqIEFNREdQVV9HUFVfUEFHRV9TSVpFIDw8IHNoaWZ0Owo+Pj4+Pj4gKwkJ
CWRzdCArPSBucHRlcyAqIGluY3I7Cj4+Pj4+PiAgICAgCj4+Pj4+PiAgICAgCQkJZnJhZ19zdGFy
dCA9IHVwZF9lbmQ7Cj4+Pj4+PiAgICAgCQkJaWYgKGZyYWdfc3RhcnQgPj0gZnJhZ19lbmQpIHsK
Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gYW1k
LWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0
cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNB
JTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdm
eCZhbXA7ZGF0YT0wMiU3QzAxJTdDc2hhc2hhbmsuc2hhcm1hJTQwYW1kLmNvbSU3QzI5NGMwY2Yw
NDYwODQ3OTUzZTgzMDhkODQ0M2MxNjNjJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4
M2QlN0MwJTdDMCU3QzYzNzMzNDM3MjE0NzE1NjY3NCZhbXA7c2RhdGE9M3NXWmN1TGNXVlRjc3B4
aFJxNmdUMVNNJTJCdkhRQ3JKcW1KaWpLZ1JFa3MwJTNEJmFtcDtyZXNlcnZlZD0wCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
