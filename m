Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916E4C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 18:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4529320791
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 18:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kMsZi8hh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4529320791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ABF66EA85;
	Thu, 13 Aug 2020 18:18:44 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750072.outbound.protection.outlook.com [40.107.75.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B3ED6EA85
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 18:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixKo0fJ2ju6Nl+FqxJ4GrH3x5XLf31qPUfB77Wo3RpqJqknfs3qo6otwtZz1P0HQBxTTHmypnltjHmcUetaaFtqR5aagy5WhwR2wsl8V2Ixqy9zNQMXSW2yrbrCZo2KDJu9uz9XZxiGoa1A8BC+u1JM/1NE+ZsNDXoKjLGXettIdh5QF8TUTUUnmkHpHN4rsgbKueA7DLeTTdzoLjD8yaMNvOQTp08rORB1FFmKy2Ygtv4TLjL6YkVpnkq/I5uoKgFhxIbhigLIH4O+s5LMJ9MFmZwtl4bwlWIXfjMDhrspi37JUk0+LYz11FGRJ4qs3PLdCA4oZCQEJXvsErXazWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+MNEbzADhFhwzOYUzxajE+QfKHNs0xhqaDvY3dN/VM=;
 b=JUawJnRWVGKb5Y52qEqTwrNmO6mbHTWiWuZcu85ZThmv9iUXyljPF8vuFL9/N3i3b1CitMu1fvxsUwQSoIkpdtltOWbx67Qk27Yu9tOb1r3g0sI4zUj6LwBgLKbM9/dJoh93CAC2llQ1U29prcSBWj12PF2AOKFn8HEmHQrmiEfN23BMmZGMUGDUi7LGpzTsRJBz3WKdhjKNuEHbdPEyitb0waKG05XWQC0zOOcDJ2Y8mjSrhU4Tq9ZdK19Rue5iwL0TSkDgE11f9ZcTODTo9LcldH6CCT91ROo1OSJCFfcPGQTF/UkNK3rpcwEg+Xsmw2x4UGvfpYrghP8v6cgIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+MNEbzADhFhwzOYUzxajE+QfKHNs0xhqaDvY3dN/VM=;
 b=kMsZi8hhRfVZOh6CG13an1IeUYTH5VGC9sKW9jypHb4AKpuCv5VTA08a4lEbFv/sd0EVOQExlzU07YCZe3crWReirFKPEJT6Cfw36cRsaAFJbHDI1nQKICKbfLC0wzDJA7sXy72qqanfsxNEc6G0oQUzyL1zE0MZM//U1GqcTS4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.20; Thu, 13 Aug 2020 18:18:37 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::f5e6:e937:2eac:18cf%3]) with mapi id 15.20.3261.025; Thu, 13 Aug 2020
 18:18:37 +0000
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: add initial support for pci error
 handler
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200811133053.71123-1-nirmoy.das@amd.com>
 <1795711a-9261-2cb4-642e-44bc25afc9ce@amd.com>
 <9770d7a3-0d4e-f609-4530-991154ef1a49@amd.com>
 <b6e878c0-bade-77a5-fda7-6be234c2f6b7@amd.com>
 <50cab62a-e8d4-0e0d-438b-b274c09d0972@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <1fb93957-e1c7-779c-953f-c575a0b6c74d@amd.com>
Date: Thu, 13 Aug 2020 14:18:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <50cab62a-e8d4-0e0d-438b-b274c09d0972@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN8PR16CA0029.namprd16.prod.outlook.com
 (2603:10b6:408:4c::42) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:c172:76b1:4560:8a64]
 (2607:fea8:3edf:49b0:c172:76b1:4560:8a64) by
 BN8PR16CA0029.namprd16.prod.outlook.com (2603:10b6:408:4c::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 18:18:36 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:c172:76b1:4560:8a64]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: add80b1e-bfba-48a0-2bd9-08d83fb54c0e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43384665B42ECB38F02C3234EA430@DM6PR12MB4338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLqdeE6a1CjVuH4YswMSggrMe79OXMCHqWCZdZ9VYtaWoOCCOOtC3IYM5ZlYmgfSqOX6i4I4hFxtbr9KNaIywLFMJ/7m8vx9hq9CjgCURwkI14Wb0qmUuW1pEtLKw4gKWR+JaNdm3wLYMmrQF4lKdwLp3sT9NmrVEgF6+I/HvRcmOzEk1Q1HsnJRj0eScO5TX/pM9324zO3bH5TlGYzW0GE11oHf0jjPpQYwGat4vMkaTDkHzA91T+iuKPggKKr76/W91G9UWjxTQcNhEPp31NqiyF4iLt77TkR6sD9IBsjPxIhf+VjiPX3GQPVRH84L8nictbCPP1lu6a1peA3726T+jKCvaJ4WjgwTc/YcD4ITUTSRzmzb19apdriSkcctpamJFPS0Chqft57QGE7mFbNSfcJbWKjZJsqhcGnoRJO31INIYKcXuzFHfOTrgPgxfcjVk71XqJGxo2r1OOdrFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(2616005)(8676002)(86362001)(478600001)(110136005)(6486002)(316002)(966005)(31696002)(36756003)(6666004)(66946007)(2906002)(52116002)(5660300002)(16526019)(186003)(66556008)(66476007)(4326008)(8936002)(83380400001)(31686004)(53546011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 33ELgiNW1x/ojfPr6eLpwsSXl2wWSFGsP5cIcGbbA4iEOfFQr7kpimsXhL1tjvlBTqw95Wxh7IQaj/IUngnT8CUiqoVpL92BS9oLWfArKNIcottbhyu9H0PiYZoPOdm+OW055dOLFWUQ+3aWjyqzF0zKpfkXs3ZySE4nFUhQbefVuoCTvOgUbG4lXhSIxVxgNdHFAzKPVNApt0YPg3OhBIG7z+mQIljyspOq7/QRQeHGJCFAuO4RqB5hDKLaJUo86QKeoD6GoHT1H5YKibbMN9CdZ8wXd8eAt+6AHnYKU+kb6ebu1wq4LHRkfI2gquznKx4T+hKyZ5+rpfk2htkyV+5qqmtzIWWx48Ji9lJBfaEFJ9x1MbJ3QqhphBEXJk9B3Fx7cG8Idti0+rZX8eOJs/l1NkuXIPyZTYgdD6MvDkrj0YYR3yejnrN6wjk9RGtsozfcLfVWI8eeIFjdwJPGxdo6wudIqxjQ0rL/XkfsmsCoUI3jATzf9RN1h2LpKR6uBd6B4QKqPA/L9tGKTksRxCI37IE/vIl5e/1tQ2x9gUTvmR3HKiBUzHBnDWEL4AFOcYy0Q32SS+XBm/3t2zUH6klgTE8kfh+oYbJypb6LsvMRAPszhUUMAD9aoo2WjX2FbYo9biaRp7cv/4HN9OAWsg2bCRQG0RNuB964B2wwIT1PmcgWFFF0RFuEFZ1FOobupgNeKLEMpiKgCkuyn08Jig==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add80b1e-bfba-48a0-2bd9-08d83fb54c0e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 18:18:37.2494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1aMd4Re5Pk9TYO8NALYLb33AcFJiNaYILTd+e6qFzGsKvjlvq96bNXDPjIg6Trs+LsV5wn/DpQSR5RPQiorxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDgvMTMvMjAgMTE6MDYgQU0sIE5pcm1veSB3cm90ZToKPgo+IE9uIDgvMTMvMjAgMzozOCBQ
TSwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6Cj4+Cj4+IE9uIDgvMTMvMjAgNzowOSBBTSwgTmly
bW95IHdyb3RlOgo+Pj4KPj4+IE9uIDgvMTIvMjAgNDo1MiBQTSwgQW5kcmV5IEdyb2R6b3Zza3kg
d3JvdGU6Cj4+Pj4KPj4+PiBPbiA4LzExLzIwIDk6MzAgQU0sIE5pcm1veSBEYXMgd3JvdGU6Cj4+
Pj4+IFRoaXMgcGF0Y2ggd2lsbCBpZ25vcmUgbm9uLWZhdGFsIGVycm9ycyBhbmQgdHJ5IHRvCj4+
Pj4+IHN0b3AgYW1kZ3B1J3Mgc3cgc3RhY2sgb24gZmF0YWwgZXJyb3JzLgo+Pj4+Pgo+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+Pj4+IC0tLQo+
Pj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCA1NiArKysr
KysrKysrKysrKysrKysrKysrKystCj4+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA1NCBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4+Pgo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIAo+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+Pj4+PiBpbmRleCBjMTIxOWFmMmU3ZDYuLjJiOWVkZTMw
MDBlZSAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2Rydi5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYu
Ywo+Pj4+PiBAQCAtMzUsNiArMzUsNyBAQAo+Pj4+PiDCoCAjaW5jbHVkZSA8bGludXgvcG1fcnVu
dGltZS5oPgo+Pj4+PiDCoCAjaW5jbHVkZSA8bGludXgvdmdhX3N3aXRjaGVyb28uaD4KPj4+Pj4g
wqAgI2luY2x1ZGUgPGRybS9kcm1fcHJvYmVfaGVscGVyLmg+Cj4+Pj4+ICsjaW5jbHVkZSA8ZHJt
L2RybV9hdG9taWNfaGVscGVyLmg+Cj4+Pj4+IMKgICNpbmNsdWRlIDxsaW51eC9tbXVfbm90aWZp
ZXIuaD4KPj4+Pj4gwqAgwqAgI2luY2x1ZGUgImFtZGdwdS5oIgo+Pj4+PiBAQCAtMTUxNiw2ICsx
NTE3LDU4IEBAIHN0YXRpYyBzdHJ1Y3QgZHJtX2RyaXZlciBrbXNfZHJpdmVyID0gewo+Pj4+PiDC
oMKgwqDCoMKgIC5wYXRjaGxldmVsID0gS01TX0RSSVZFUl9QQVRDSExFVkVMLAo+Pj4+PiDCoCB9
Owo+Pj4+PiDCoCArc3RhdGljIHBjaV9lcnNfcmVzdWx0X3QgYW1kZ3B1X3BjaV9lcnJfZGV0ZWN0
ZWQoc3RydWN0IHBjaV9kZXYgKnBkZXYsCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBjaV9jaGFubmVsX3N0YXRlX3Qgc3RhdGUpCj4+Pj4+ICt7
Cj4+Pj4+ICvCoMKgwqAgc3RydWN0IGRybV9kZXZpY2UgKmRldiA9IHBjaV9nZXRfZHJ2ZGF0YShw
ZGV2KTsKPj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRldi0+ZGV2
X3ByaXZhdGU7Cj4+Pj4+ICvCoMKgwqAgaW50IGk7Cj4+Pj4+ICvCoMKgwqAgaW50IHJldCA9IFBD
SV9FUlNfUkVTVUxUX0RJU0NPTk5FQ1Q7Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDCoCBzd2l0Y2ggKHN0
YXRlKSB7Cj4+Pj4+ICvCoMKgwqAgY2FzZSBwY2lfY2hhbm5lbF9pb19ub3JtYWw6Cj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoCByZXQgPSBQQ0lfRVJTX1JFU1VMVF9DQU5fUkVDT1ZFUjsKPj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4+PiArwqDCoMKgIGRlZmF1bHQ6Cj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoCAvKiBEaXNhYmxlIHBvd2VyIG1hbmFnZW1lbnQgKi8KPj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIGFkZXYtPnJ1bnBtID0gMDsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qIFN1c3BlbmQgYWxs
IElPIG9wZXJhdGlvbnMgKi8KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGFtZGdwdV9mYmRldl9zZXRf
c3VzcGVuZChhZGV2LCAxKTsKPj4+Pj4gKyBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYt
PmRlbGF5ZWRfaW5pdF93b3JrKTsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkg
PCBBTURHUFVfTUFYX1JJTkdTOyArK2kpIHsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c3RydWN0IGFtZGdwdV9yaW5nICpyaW5nID0gYWRldi0+cmluZ3NbaV07Cj4+Pj4+ICsKPj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFyaW5nIHx8ICFyaW5nLT5zY2hlZC50aHJlYWQp
Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4+Pj4+ICsK
Pj4+Pj4gKyBhbWRncHVfam9iX3N0b3BfYWxsX2pvYnNfb25fc2NoZWQoJnJpbmctPnNjaGVkKTsK
Pj4+Pgo+Pj4+Cj4+Pj4gWW91IG5lZWQgdG8gY2FsbCBkcm1fc2NoZWRfc3RvcCBmaXJzdCBiZWZv
cmUgY2FsbGluZyB0aGlzCj4+Pj4KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4+Pj4gKwo+Pj4+
PiArwqDCoMKgwqDCoMKgwqAgaWYgKGFkZXYtPm1vZGVfaW5mby5tb2RlX2NvbmZpZ19pbml0aWFs
aXplZCkgewo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWFtZGdwdV9kZXZpY2Vf
aGFzX2RjX3N1cHBvcnQoYWRldikpCj4+Pj4+ICsgZHJtX2hlbHBlcl9mb3JjZV9kaXNhYmxlX2Fs
bChhZGV2LT5kZGV2KTsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZQo+Pj4+PiAr
IGRybV9hdG9taWNfaGVscGVyX3NodXRkb3duKGFkZXYtPmRkZXYpOwo+Pj4+PiArwqDCoMKgwqDC
oMKgwqAgfQo+Pj4+PiArCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBhbWRncHVfZmVuY2VfZHJpdmVy
X2ZpbmkoYWRldik7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBhbWRncHVfZmJkZXZfZmluaShhZGV2
KTsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qIFRyeSB0byBjbG9zZSBkcm0gZGV2aWNlIHRvIHN0
b3AgYXBwbGljYXRpb25zCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogZnJvbSBvcGVuaW5nIGRy
aSBmaWxlcyBmb3IgZnVydGhlciBJTyBvcGVyYXRpb25zLgo+Pj4+PiArwqDCoMKgwqDCoMKgwqDC
oCAqIFRPRE86IFRoaXMgd2lsbCB0aHJvdyB3YXJuaW5nIGFzIHR0bSBpcyBub3QKPj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqAgKiBjbGVhbmVkIHBlcnBlcmx5ICovCj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oCBkcm1fZGV2X2ZpbmkoZGV2KTsKPj4+Pgo+Pj4+Cj4+Pj4gSSB0aGluayB1c2VyIG1vZGUgYXBw
bGljYXRpb25zIG1pZ2h0IHN0aWxsIGhvbGQgcmVmZXJlbmNlIHRvIHRoZSBkcm0gZGV2aWNlIAo+
Pj4+IHRocm91Z2ggdGhyb3VnaCBkcm1fZGV2X2dldCBlaXRoZXIgYnkgZGlyZWN0bHkgb3Blbmlu
Zwo+Pj4+IHRoZSBkZXZpY2UgZmlsZSBvciBpbmRpcmVjdGx5IHRocm91Z2ggaW1wb3J0aW5nIERN
QSBidWZmLCBpZiBzbyB3aGVuIHRoZSAKPj4+PiBsYXN0IG9mIHRoZW0gdGVybWluYXRlIGRybV9k
ZXZfcHV0LT5kcm1fZGV2X3JlbGVhc2UtPi4uLi0+ZHJtX2Rldl9maW5pCj4+Pj4gbWlnaHQgZ2V0
IGNhbGxlZCBhZ2FpbiBjYXVzaW5nIHVzZSBhZnRlciBmcmVlIGUudC5jIGlzc3Vlcy4gTWF5YmUg
YmV0dGVyIHRvIAo+Pj4+IGNhbGwgaGVyZSBkcm1fZGV2X3B1dCB0aGVuIGFuZCBzbyBkcm1fZGV2
X2Zpbmkgd2lsbCBnZXQgY2FsbGVkIHdoZW4gdGhpcwo+Pj4+IGxhc3QgdXNlciBjbGllbnQgcmVs
ZWFzZXMgaGlzIHJlZmVyZW5jZS4KPj4+Cj4+Pgo+Pj4gZHJtX2Rldl9maW5pKCkgc2VlbXMgdG8g
YmUgY2xlYW5lci4gUHJvYmxlbSBpc8KgIHdpbmRvdyBtYW5hZ2VyKHN3YXkpIG5ldmVyIAo+Pj4g
Z2V0cyB0ZXJtaW5hdGVkIGFmdGVyIHRoZSBBRVIgZXJyb3IgYW5kIGRybSBmaWxlcyByZW1haW5z
IGFjdGl2ZS4gU2ltcGxlIGNhdCAKPj4+IG9uIGRyaSBmaWxlcwo+Pj4KPj4+IGdvZXMgdGhvdWdo
IGFtZGdwdSBhbmQgc3BpdHMgb3V0IG1vcmUgZXJyb3JzLgo+Pgo+Pgo+PiBXaGF0IGhhcHBlbnMg
aWYgeW91IGtpbGwgdGhlIHdpbmRvdyBtYW5hZ2VyIGFmdGVyIHlvdSBjbG9zZWQgZHJtIGRldmlj
ZSB3aXRoIAo+PiB5b3VyIG9yaWdpbmFsIGNvZGUgYXBwbGllZCA/IEkgd291bGQgZXhwZWN0IGRy
bV9kZXZfZmluaSB0byBiZSBjYWxsZWQgYWdhaW4KPj4gZm9yIHRoZSByZWFzb24gaSBleHBsYWlu
ZWQgYWJvdmUgYW5kIHRoaXMgd291bGQgb2J2aW91c2x5IHdvdWxkIGJlIHdyb25nIHRvIAo+PiBo
YXBwZW4uCj4KPiBIaSBBbmRyZXksCj4KPgo+IGhtbSBJIHF1aWNrbHkgdHJpZWQgdGhhdCwgS2Vy
bmVsIGNyYXNoZWQgYW5kIGxhdGVyIHJlYm9vdGVkIGFmdGVyIHNvbWV0aW1lLiBJIAo+IGRvbid0
IGhhdmUgYSBzZXJpYWwgY29uc29sZSB0byBjaGVjayBsb2dzIGFuZCB0aGVyZSB3YXMgbm8gbG9n
cyBhZnRlcndhcmRzIGluIAo+IGpvdXJuYWxjdGwuCj4KPiBkcm1fZGV2X3B1dCgpIGhhZCBzaW1p
bGFyIGJlaGF2aW9yLCBrZXJuZWwvbWFjaGluZSB3YXMgaW5hY2Nlc3NpYmxlIG92ZXIgc3NoLgo+
Cj4KPiBEaWQgeW91IGZhY2Ugc2FtZSBiZWhhdmlvciB3aGlsZSB0ZXN0aW5nIGdwdSBob3RwbHVn
ID8KPgo+Cj4gTmlybW95CgoKWWVhLCBpbiBteSBjYXNlIGRldmljZSBzeXNmcyBzdHJ1Y3R1cmUg
d2FzIHJlbW92ZWQgb24gcGNpX3JlbW92ZSB3aGlsZSB3aGVuIGxhc3QgCnVzZXIgY2xpZW50IGRy
b3BwZWQgcmVmZXJlbmNlIGFuZCB0aGlzIGxlZAp0byBkcm1fZGV2X2ZpbmkgdG8gYmUgY2FsbGVk
IHRoZXJlIHdlcmUgbW9yZSBzeXNmcyBlbnRyaWVzIHJlbW92YWwgdGhlcmUgd2hpY2ggCmxlYWQg
dG8gYSBjcmFzaC4gQnV0IGhlcmUgaSBkb24ndCB0aGluayB0aGUgc3lzZnMgZm9yIGRybV9kZXZp
Y2UKaXMgcmVtb3ZlZCBiZWNhdXNlIHRoZSBkZXZpY2UgaXMgbm90IGV4dHJhY3RlZC4uLgoKQW5k
cmV5CgoKPgo+Cj4+Cj4+IEFuZHJleQo+Pgo+Pgo+Pj4KPj4+Cj4+Pj4KPj4+PiBBbHNvIGEgZ2Vu
ZXJhbCBxdWVzdGlvbiAtIGluIG15IHdvcmsgb24gRFBDIHJlY292ZXJ5IGZlYXR1cmUgd2hpY2gg
dHJpZXMgdG8gCj4+Pj4gcmVjb3ZlciBhZnRlciBQQ0llIGVycm9yIC0gb25jZSB0aGUgUENJIGVy
cm9yIGhhcyBoYXBwZW5lZCBNTUlPIHJlZ2lzdGVycyAKPj4+PiBiZWNvbWUKPj4+PiB1bmFjY2Vz
c2libGUgZm9yIHIvdyBhcyB0aGUgUENJIGxpbmsgaXMgZGVhZCB1bnRpbCBhZnRlciB0aGUgUENJ
IGxpbmsgaXMgCj4+Pj4gcmVzZXQgYnkgdGhlIERQQyBkcml2ZXIgKHNlZSAKPj4+PiBodHRwczov
L3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9QQ0kvcGNpLWVycm9yLXJlY292ZXJ5Lmh0
bWwgc2VjdGlvbiAKPj4+PiA2LjEuNCkuCj4+Pj4gWW91ciBjYXNlIGlzIHRvIHRyeSBhbmQgZ3Jh
Y2VmdWxseSB0byBjbG9zZSB0aGUgZHJtIGRldmljZSBvbmNlIGZhdGFsIGVycm9yIAo+Pj4+IGhh
cHBlbmVkLCBkaWRuJ3QgeW91IGVuY291bnRlciBlcnJvcnMgb3Igd2FybmluZ3Mgd2hlbiBhY2Nl
c3NpbmcgSFcgCj4+Pj4gcmVnaXN0ZXJzIGR1cmluZyBhbnkgb2YgdGhlIG9wZXJhdGlvbnMKPj4+
PiBhYm92ZSA/Cj4+Pgo+Pj4KPj4+IEFzIGRpc2N1c3NlZCBvdmVyIGNoYXQsIGl0IHNlZW1zIGFl
ciBnZW5lcmF0ZWQgd2l0aCBhZXItaW5qZWN0IHRvb2wganVzdCAKPj4+IHRyaWdnZXJzIGtlcm5l
bCBQQ0kgZXJyb3IgQVBJcyBidXQgdGhlIGRldmljZSBpcyBzdGlsbCBhY3RpdmUgc28gSSBkaWRu
J3QgCj4+PiBlbmNvdW50ZXIgYW55IGVycm9ycyB3aGVuIGFjY2Vzc2luZyBIVyByZWdpc3RlcnMu
Cj4+Pgo+Pj4KPj4+IE5pcm1veQo+Pj4KPj4+Cj4+Pj4KPj4+PiBBbmRyZXkKPj4+Pgo+Pj4+Cj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4+Pj4gK8KgwqDCoCB9Cj4+Pj4+ICsKPj4+Pj4g
K8KgwqDCoCByZXR1cm4gcmV0Owo+Pj4+PiArfQo+Pj4+PiArCj4+Pj4+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IHBjaV9lcnJvcl9oYW5kbGVycyBhbWRncHVfZXJyX2hhbmRsZXIgPSB7Cj4+Pj4+ICvC
oMKgwqDCoMKgwqAgLmVycm9yX2RldGVjdGVkID0gYW1kZ3B1X3BjaV9lcnJfZGV0ZWN0ZWQsCj4+
Pj4+ICt9Owo+Pj4+PiArCj4+Pj4+ICsKPj4+Pj4gwqAgc3RhdGljIHN0cnVjdCBwY2lfZHJpdmVy
IGFtZGdwdV9rbXNfcGNpX2RyaXZlciA9IHsKPj4+Pj4gwqDCoMKgwqDCoCAubmFtZSA9IERSSVZF
Ul9OQU1FLAo+Pj4+PiDCoMKgwqDCoMKgIC5pZF90YWJsZSA9IHBjaWlkbGlzdCwKPj4+Pj4gQEAg
LTE1MjMsMTAgKzE1NzYsOSBAQCBzdGF0aWMgc3RydWN0IHBjaV9kcml2ZXIgYW1kZ3B1X2ttc19w
Y2lfZHJpdmVyID0gewo+Pj4+PiDCoMKgwqDCoMKgIC5yZW1vdmUgPSBhbWRncHVfcGNpX3JlbW92
ZSwKPj4+Pj4gwqDCoMKgwqDCoCAuc2h1dGRvd24gPSBhbWRncHVfcGNpX3NodXRkb3duLAo+Pj4+
PiDCoMKgwqDCoMKgIC5kcml2ZXIucG0gPSAmYW1kZ3B1X3BtX29wcywKPj4+Pj4gK8KgwqDCoCAu
ZXJyX2hhbmRsZXIgPSAmYW1kZ3B1X2Vycl9oYW5kbGVyLAo+Pj4+PiDCoCB9Owo+Pj4+PiDCoCAt
Cj4+Pj4+IC0KPj4+Pj4gwqAgc3RhdGljIGludCBfX2luaXQgYW1kZ3B1X2luaXQodm9pZCkKPj4+
Pj4gwqAgewo+Pj4+PiDCoMKgwqDCoMKgIGludCByOwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
