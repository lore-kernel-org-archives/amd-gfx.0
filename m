Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35ADC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 12:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EDE864F6B
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 12:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDE864F6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F9889EA3;
	Tue,  9 Mar 2021 12:37:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50D4E89EA3
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 12:37:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nujWMjBu6DPEPxqTH6fAcShdieUUVsCP2gbKvKme0cIaQpgbf4zY4Y9xHBhjsaot16PDO3d5Dw/mLbx6xQXEGk/w9NSTHsvFSf8dnE5JV29dgF6FE1trVCuInxz93QZL5Z4HwlUXKml9OFWiN7rAYilKsyTlSL/vGxVzG3nrtA0MGje/RKECOTMSHnVj/aFileo/e5bTRi5F15ZQExapqkitbyEwk8pXBP/scrioFazwMRvh6bmCfiYaSp3tfD5D8nL+IPLf6QhKitiC9guLqHmUNF2NJVRCxDlx7ewF6OKQFl/x1ZGwG7dJ9e48g7oWS1IgGCO5BIHvCAii9v1aqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jofLszgk/TBmZZMLUEF+5/Xzo13C33PYb6EpVMvv0A4=;
 b=TNKvp3X0SFkWthDdhdP7jLwnV0uN0+E3012eAE6c/tS9N9CW4x1yVE0800O78gQcwwKkPR0WH/t4lBryUwx75+omGHPiT9aOurb1wn0I6oZ+aobZ9lIciELyt+Pn8qyEkCMHseroRbUyDbs9NTgw23pi0nDDMf0vxec7ms4vXFowZ3ys6s0PtFMqDpDKosjoJxryp9R8g+T11cKSM4WPLTLs/KCyXP6hnDhxSUOog7zF3xKq/GtknU+jw5ECmv9EgNYggEGITK+4fQc6hB3GEWvO3CEPPeXyvrVNgVDJH+6s/XyepE2bW/vDYlhsXMTa687cRj/2aJdxovNZi1A49g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jofLszgk/TBmZZMLUEF+5/Xzo13C33PYb6EpVMvv0A4=;
 b=FzpfSttUUl6wvUAtakps5bxzgxB0FzS01MsQGfwN9KAOtFDHz04hXxBzcFtHBmdeBz6WJfNVClxKVKr1bn3VmTlw6HshPUyJO5AezgjkMynNJycIBtbpWAidy96B0orKYFUnYCge6uZh10q5e6iEr2dfH/5NILsft8RV3Lj/Wt0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4000.namprd12.prod.outlook.com (2603:10b6:208:16b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 9 Mar
 2021 12:37:26 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 12:37:26 +0000
Subject: Re: [PATCH v2 2/5] drm/amdgpu: introduce struct amdgpu_bo_user
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210309084659.37649-1-nirmoy.das@amd.com>
 <20210309084659.37649-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0423b294-ded4-5fab-a32e-f2574a4c6dc9@amd.com>
Date: Tue, 9 Mar 2021 13:37:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210309084659.37649-2-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:7f9b:4f7c:c70d:c3fe]
X-ClientProxiedBy: AM8P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::28) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:7f9b:4f7c:c70d:c3fe]
 (2a02:908:1252:fb60:7f9b:4f7c:c70d:c3fe) by
 AM8P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 12:37:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e791a3b-a7de-476a-d8ea-08d8e2f81895
X-MS-TrafficTypeDiagnostic: MN2PR12MB4000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4000E70B1E9C0ECF380F695183929@MN2PR12MB4000.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5CIdkfr0cKiAvkyapxdvdjWLAi4dzQve82IV1PESIdGNzMrnkMIyTgnTvM5cz/MoOivEsquoiKYr2EbT2/QMcaY1nmp/SP8NbRVmE62NFw9HP4ejSZyTlRAiWef7yRTjIyfZBSyk36qTBQLVKrxr+Zedfiq8Li/ITlzquxIySYeZRo1xcSosQcZ3Cc1Hvd5QB2rQ9NvmFS9PSGiAoXR1G7rWPzqc6frwKJqKOSb0sKc1TkmDuauL+qMnMwT/EzZUu5HYlsUrM1tkFkpi5+G55j00Fb33hdXeJvI+6xN6P4S+cYtcVAR/T+KloitEC+uYut8M7QEBJ6OnXXcRZmFIRTGp5aeBNLKS39AqL06Vn/eUkCBfK1Ewh6arat+vonZcYvYZKzCmY/zxa6haYB4qeSHxTkB0jXLrzjq1XRubWOKVBHz6W/LVzZIlljQHEXxQJwxelw/uTNf3OAfKDKz38/kpGBNqJeI/pHHzSC9Gay5kXNJ/VgFw2aADJR22Bumq7d4KANEy0ESJ6NiCsfb1ECKabF1M0mpQjYo8ODzcX0Err9pmLVu+8dYoaxpqgbohknZMPopbaHKJYHXO95v4QHnK7w/sdEsUHI0EuaIYaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(8676002)(6862004)(52116002)(66574015)(16526019)(6486002)(6636002)(8936002)(4326008)(186003)(83380400001)(2906002)(6666004)(86362001)(2616005)(66556008)(5660300002)(66476007)(478600001)(37006003)(316002)(66946007)(31686004)(36756003)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bUpSeDI4V0o4L2JDSytubnhkM2c1MzN6TWRyNVNGYXI5WVEyWkdmTmJqY0ZQ?=
 =?utf-8?B?c09zL3NJOG16ZzhhWk1XdjBSMGZObDZnMGNDdVNPN1JweW5jeGQzTzhGRjgx?=
 =?utf-8?B?MnZxL2FuUWFqYWJNay9YZ0dSQkd4TkRMaDE2YjNxbnp2Z2w5dWNNeVlsL3pH?=
 =?utf-8?B?bVV0RE9VZFNsNWtvWmxnYXM4ajJkeHpiaVgwc3VGaXByeXpqZzJWOXBRaFo3?=
 =?utf-8?B?RVlLZjdRSEVJaTJ4dGpuYnpyN3hrZUVHWnhkVnZ1WE80bktNblRGV0JZdGxn?=
 =?utf-8?B?bm5EcXZsYzNITWUvbDROSVRPOTh6dVlBNTdqTFY0ZUprMm1JNHBVZTNPWjFR?=
 =?utf-8?B?YzBlOFZuQ1c3dkZGb1dWeElEd0NSckdialdPUXRVb2IydmYwcGFJWHl6Y0Ru?=
 =?utf-8?B?ODVWay9qbkZGb1lnNW9VUzAva01wWTFXRGhOOFpnYjBrTDhjWm51Yk41ZGNt?=
 =?utf-8?B?dkVnRmtmOHUvR3VzRnZVTkV6WXV2eklVMjlqWlgyQWdLWEM5V1ZtdVFlN2Zz?=
 =?utf-8?B?REpacXpDMGh5bmFDcEhwaElNNk9UTGdmY1d0STkwYVRRZkpacmxnZWZjQWFG?=
 =?utf-8?B?VlNuQXdNdzdrSW1jcXdNdGtxWlJ0LzJ6OXM4ZU9BLzJRb1E0NjRKdzNDOWYw?=
 =?utf-8?B?bzFSUGhhY2pGUkUvWFpkK202Z2lxcENUYUJXckpOUjMwUWYwdGEyNVdJV1Rl?=
 =?utf-8?B?RFI3L29tTm82WHNObThqZDJ3SE9aNCtUajlsTHk5QVdHOFZyV2lYbXlFUzdB?=
 =?utf-8?B?ZlNlQzZuZ3dDMWQ5eGd0NFpaa2tQK201YW9acU9pdVpiendXYnp6ZTVKanB3?=
 =?utf-8?B?RkJQdmxpZDBMZlJ2dFlhbzk0OFJwQ05aOUlNUmREbHhUdWVodzgwdTBWRXhV?=
 =?utf-8?B?RzlJbkxVZjUrYmdZQkttSXp0KzltV254TzZDcGJ1dkV4N2s0dms0N3RwT3NP?=
 =?utf-8?B?R0V6UlVTTU1pZjlmbDBGUXFWWUY2U01KUy9vaS9yekZudVdZVE5Hc3YwQlQw?=
 =?utf-8?B?QzhYUmpIc0NBMEwxanVQaGRnMjdoem8xTldObEZFU3g3dUk3UmdoaWQwWk1r?=
 =?utf-8?B?dmlBTzc3TzZvTmdLOWRpK3pDMnY5TklYNG9sTDkwbEdtMmQ4QnBFd2VFck1U?=
 =?utf-8?B?bVg5aTAyUkhkQWd2bi94WFVTbEVPRVNpM3NuMjd0Y1d4aVcyNCt3Nk1LWVdT?=
 =?utf-8?B?RnEvRjFuOUxzVXdYNit4d1V5UXIyK0NONW9DU0hGR1NiY3hOcFVmV0dGaDhv?=
 =?utf-8?B?M29pSWpQNkx6UEEvekwvRTI4b0JGQXU3NDhVVDY0b1dYYkRsYmJwZ2JleHc0?=
 =?utf-8?B?bXRnK3FkVmxqNU1sc0J1L3dwaEFGcXBqL3ZNbDV3NUZkWnM2REFPSm9nV215?=
 =?utf-8?B?VVdTaW5JRk5ZWWdxTjBETFJQTlQrcU44QVJ2OXpCVlBXV3J2TXcwS3JtNUt5?=
 =?utf-8?B?aHBQUHhmNEtrdE5BTFRpbWJyMjVtK3F1VTRYeHFLcmRqeTlTbTRBZnZwWUZJ?=
 =?utf-8?B?UGxYV2ZhRkFYM3NXQVFVMVN2MmxxbEpxVUxGL0NFd0kvaGN6OGV2Q0JUa0hV?=
 =?utf-8?B?QXRoT2JYanc2TjRjd1ArbFUyS3h6ZzZwTjJjWHFQVTZoU1RqQzZ5Tkxhdzk0?=
 =?utf-8?B?d0p4a1NYY0RKdGx6Uzk3KzkvUHlhQ0pLS1dRbFlqa29QNkJuWk0yY1h6SldK?=
 =?utf-8?B?bGFSSGhWVE1SZGlvOEptcHVXQnFXS25LU3hFUEU1ZFZLWW9hK0NIZTNIRkhP?=
 =?utf-8?B?VlNjSWxXUVV4cEtnU3V4RTYwaHlXUWRuVFl4dlczdEdjZW4wM2JJOHhMMFBw?=
 =?utf-8?B?d2VPc3ByV0RFS3gzaFV3UHh1SEpkUkFRWWFuemJXOG1DblNXQUYzK2huV3Ar?=
 =?utf-8?Q?ShLfTSk8pRNj9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e791a3b-a7de-476a-d8ea-08d8e2f81895
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 12:37:26.7304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cm5MbNz54b4Hrx7CCJP6LISFfPMGT/wy6xdLrSXwHK+J09qRGnJYU9QVpacyyt5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4000
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDkuMDMuMjEgdW0gMDk6NDYgc2NocmllYiBOaXJtb3kgRGFzOgo+IEltcGxlbWVudCBhIG5l
dyBzdHJ1Y3QgYW1kZ3B1X2JvX3VzZXIgYXMgc3ViY2xhc3Mgb2YKPiBzdHJ1Y3QgYW1kZ3B1X2Jv
IGFuZCBhIGZ1bmN0aW9uIHRvIGNyZWF0ZWQgYW1kZ3B1X2JvX3VzZXIKPiBibyB3aXRoIGEgZmxh
ZyB0byBpZGVudGlmeSB0aGUgb3duZXIuCj4KPiB2MjogYW1kZ3B1X2JvX3RvX2FtZGdwdV9ib191
c2VyIC0+IHRvX2FtZGdwdV9ib191c2VyKCkKPgo+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMg
PG5pcm1veS5kYXNAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X29iamVjdC5jIHwgMjggKysrKysrKysrKysrKysrKysrKysrKwo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oIHwgMTQgKysrKysrKysrKysKPiAg
IDIgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+IGluZGV4IGMzMGYxMGY5MzFmYy4uYmQ4OWQ0NGEx
ZjJmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+
IEBAIC02OTQsNiArNjk0LDM0IEBAIGludCBhbWRncHVfYm9fY3JlYXRlKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAo+ICAgCXJldHVybiByOwo+ICAgfQo+Cj4gKy8qKgo+ICsgKiBhbWRncHVf
Ym9fY3JlYXRlX3VzZXIgLSBjcmVhdGUgYW4gJmFtZGdwdV9ib191c2VyIGJ1ZmZlciBvYmplY3QK
PiArICogQGFkZXY6IGFtZGdwdSBkZXZpY2Ugb2JqZWN0Cj4gKyAqIEBicDogcGFyYW1ldGVycyB0
byBiZSB1c2VkIGZvciB0aGUgYnVmZmVyIG9iamVjdAo+ICsgKiBAdWJvX3B0cjogcG9pbnRlciB0
byB0aGUgYnVmZmVyIG9iamVjdCBwb2ludGVyCj4gKyAqCj4gKyAqIENyZWF0ZSBhIEJPIHRvIGJl
IHVzZWQgYnkgdXNlciBhcHBsaWNhdGlvbjsKPiArICoKPiArICogUmV0dXJuczoKPiArICogMCBm
b3Igc3VjY2VzcyBvciBhIG5lZ2F0aXZlIGVycm9yIGNvZGUgb24gZmFpbHVyZS4KPiArICovCj4g
Kwo+ICtpbnQgYW1kZ3B1X2JvX2NyZWF0ZV91c2VyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAo+ICsJCQkgIHN0cnVjdCBhbWRncHVfYm9fcGFyYW0gKmJwLAo+ICsJCQkgIHN0cnVjdCBhbWRn
cHVfYm9fdXNlciAqKnVib19wdHIpCj4gK3sKPiArCXN0cnVjdCBhbWRncHVfYm8gKmJvX3B0cjsK
PiArCWludCByOwo+ICsKPiArCWJwLT5mbGFncyA9IGJwLT5mbGFncyAmIH5BTURHUFVfR0VNX0NS
RUFURV9TSEFET1c7Cj4gKwlicC0+Ym9fcHRyX3NpemUgPSBzaXplb2Yoc3RydWN0IGFtZGdwdV9i
b191c2VyKTsKPiArCXIgPSBhbWRncHVfYm9fZG9fY3JlYXRlKGFkZXYsIGJwLCAmYm9fcHRyKTsK
PiArCWlmIChyKQo+ICsJCXJldHVybiByOwo+ICsKPiArCSp1Ym9fcHRyID0gdG9fYW1kZ3B1X2Jv
X3VzZXIoYm9fcHRyKTsKPiArCXJldHVybiByOwo+ICt9Cj4gICAvKioKPiAgICAqIGFtZGdwdV9i
b192YWxpZGF0ZSAtIHZhbGlkYXRlIGFuICZhbWRncHVfYm8gYnVmZmVyIG9iamVjdAo+ICAgICog
QGJvOiBwb2ludGVyIHRvIHRoZSBidWZmZXIgb2JqZWN0Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+IGluZGV4IDhlMmI1NTZmMGI3Yi4uMDZiNmZhMzVkYjk5
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3Qu
aAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+IEBA
IC0zNyw2ICszNyw4IEBACj4gICAjZGVmaW5lIEFNREdQVV9CT19JTlZBTElEX09GRlNFVAlMT05H
X01BWAo+ICAgI2RlZmluZSBBTURHUFVfQk9fTUFYX1BMQUNFTUVOVFMJMwo+Cj4gKyNkZWZpbmUg
dG9fYW1kZ3B1X2JvX3VzZXIoYWJvKSBjb250YWluZXJfb2YoKGFibyksIHN0cnVjdCBhbWRncHVf
Ym9fdXNlciwgYm8pCj4gKwo+ICAgc3RydWN0IGFtZGdwdV9ib19wYXJhbSB7Cj4gICAJdW5zaWdu
ZWQgbG9uZwkJCXNpemU7Cj4gICAJaW50CQkJCWJ5dGVfYWxpZ247Cj4gQEAgLTExMiw2ICsxMTQs
MTUgQEAgc3RydWN0IGFtZGdwdV9ibyB7Cj4gICAJc3RydWN0IGtnZF9tZW0gICAgICAgICAgICAg
ICAgICAqa2ZkX2JvOwo+ICAgfTsKPgo+ICtzdHJ1Y3QgYW1kZ3B1X2JvX3VzZXIgewo+ICsJc3Ry
dWN0IGFtZGdwdV9ibwkJYm87Cj4gKwl1NjQJCQkJdGlsaW5nX2ZsYWdzOwo+ICsJdTY0CQkJCW1l
dGFkYXRhX2ZsYWdzOwo+ICsJdm9pZAkJCQkqbWV0YWRhdGE7Cj4gKwl1MzIJCQkJbWV0YWRhdGFf
c2l6ZTsKPiArCj4gK307Cj4gKwo+ICAgc3RhdGljIGlubGluZSBzdHJ1Y3QgYW1kZ3B1X2JvICp0
dG1fdG9fYW1kZ3B1X2JvKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqdGJvKQo+ICAgewo+ICAg
CXJldHVybiBjb250YWluZXJfb2YodGJvLCBzdHJ1Y3QgYW1kZ3B1X2JvLCB0Ym8pOwo+IEBAIC0y
NTUsNiArMjY2LDkgQEAgaW50IGFtZGdwdV9ib19jcmVhdGVfa2VybmVsKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAo+ICAgaW50IGFtZGdwdV9ib19jcmVhdGVfa2VybmVsX2F0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LAo+ICAgCQkJICAgICAgIHVpbnQ2NF90IG9mZnNldCwgdWludDY0
X3Qgc2l6ZSwgdWludDMyX3QgZG9tYWluLAo+ICAgCQkJICAgICAgIHN0cnVjdCBhbWRncHVfYm8g
Kipib19wdHIsIHZvaWQgKipjcHVfYWRkcik7Cj4gK2ludCBhbWRncHVfYm9fY3JlYXRlX3VzZXIo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gKwkJCSAgc3RydWN0IGFtZGdwdV9ib19wYXJh
bSAqYnAsCj4gKwkJCSAgc3RydWN0IGFtZGdwdV9ib191c2VyICoqdWJvX3B0cik7Cj4gICB2b2lk
IGFtZGdwdV9ib19mcmVlX2tlcm5lbChzdHJ1Y3QgYW1kZ3B1X2JvICoqYm8sIHU2NCAqZ3B1X2Fk
ZHIsCj4gICAJCQkgICB2b2lkICoqY3B1X2FkZHIpOwo+ICAgaW50IGFtZGdwdV9ib19rbWFwKHN0
cnVjdCBhbWRncHVfYm8gKmJvLCB2b2lkICoqcHRyKTsKPiAtLQo+IDIuMzAuMQo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
