Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3668C34031
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 20:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B4C8206F4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 20:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cYkFI1Od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4C8206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F06346EA77;
	Tue, 18 Feb 2020 20:55:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81BE26EA77
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 20:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxZ/Fn6eQKGPLtATBu+B9V5LrYtiVgxG6pdtiyZ/Zef4EZhcOg1TStVrD531iD5qLkx64m0JvEyWWaJoD2eRzpS4FhvmVOvyZqWAGm7ajLfkEYdDP2og8Jqq1gjxFN9CTGgotqafqm9aJJ01YXYZmuv4fLnBhImHW2Rms3FPm0wfBIZXUnFP0AC4fRLQG09ioMu3Pkspl5VeY6NWxaYIYPeqeh6fChqc9HBl3PNjH8U80WSwN68Gfq+4spNRaIILcPXjM3sQGHwANh6gPWJfGTSs8fSFY7Twlmx3v0Rk/4OHR8EJv5G5XRXAWMURbDALXX8eJhx/ObTTRZ9lcchNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOVgGWOuNxa93K8H8dOmNJjhm4ZXMtYiyOBtHM0yEPU=;
 b=fa2KL83G5P1QVxUry6QV7w+JCMNX49Xnr2HLzLrIGgJPY15HIVVD1sgDDNrTVQG6rZmQL3A8hKWr1ltFzyMGujZHORPh5glVsYFD+4lm8wy77kRuc1woqYp1hxAEqnqqNCzdzjDueW34o8mC7oqKWf2kFdY3pFvEhHuTFGmLKcwNafY+ZgWZ1IriE9HiWyGcn+5AaOl0uqzt/LZ7zx7U9G71cKO6MkE+8TTRUsZo/lsDAt5Q3AN/RkfZpKF/vA9Vy6fbrCebLWPVEYMTn56/vsDsYkAPm9qpSTZJBdIaMB55y7lSD9VtBOY/IRwEtTUM5dwci9p7pVNieDFMS9a/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOVgGWOuNxa93K8H8dOmNJjhm4ZXMtYiyOBtHM0yEPU=;
 b=cYkFI1Od8YYftIM7XNIAEr9UYBRCqBXyRm/3Abp3D9cbmF4mf7ysqn302mrw/V6nbzN78/LdlHKENRgCUaD2vXbgjh1bTfK3sibx2uYSrOri7JWGXmK7eo/nYFw89FTEBks8kab7ow6a1O7UWtvI6XdvwuAbtz+C4vrbUfHKIyA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3625.namprd12.prod.outlook.com (20.178.29.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Tue, 18 Feb 2020 20:55:10 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 20:55:09 +0000
Subject: Re: [PATCH] drm/amdgpu: fix the wrong logic checking when secure
 buffer is created
To: Huang Rui <ray.huang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <1582006331-32356-1-git-send-email-ray.huang@amd.com>
 <d4595b32-a5a2-483b-117b-606c9e28ce25@amd.com>
 <20200218082703.GA6610@jenkins-Celadon-RN>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <83fbdd37-7a4c-9b9b-8d7a-4cc52987f413@amd.com>
Date: Tue, 18 Feb 2020 15:55:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <20200218082703.GA6610@jenkins-Celadon-RN>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::29) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.55.250) by
 YTOPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend
 Transport; Tue, 18 Feb 2020 20:55:09 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a4ff829c-4860-4308-d6dd-08d7b4b4d75d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3625:|DM6PR12MB3625:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB36255AD26C037C30B3E1FF8A99110@DM6PR12MB3625.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(16526019)(956004)(6506007)(53546011)(2616005)(36756003)(110136005)(8936002)(316002)(44832011)(478600001)(54906003)(186003)(26005)(6512007)(31686004)(6486002)(66946007)(6636002)(81166006)(81156014)(4326008)(66556008)(52116002)(2906002)(8676002)(86362001)(66476007)(5660300002)(31696002)(66574012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3625;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N444PyS3m8+vZ8FUJrTBfM00FdAVf1Y33V9PgHCzr7U98S1TFRzj4Wi/th61rY9ur/VwGeMazr6N5TUnTntai5edfBuXUbvoPhPf+Y6Acic3hnCON/rYth8qNtj2wjHSCxPhy6VnWKbPMjcrOzSJLhi7bWWZ+Hd/0832md0bxiu+EHIGRngUmMYWzHcXa0h2siX+5xlFRSE9Xf/0ATmXqQPf/iLvmmnaHvmLU8sFoE1K+0u/vHnBcwDHsnGEinvVPb2vS9uzm2ZAEW4ifAqrqD7uIimF8acoyTtEFJySBsNtdU0S0ThPoT5YAj8eH0HlbnToSM9sMRNLJAbC9Glqy0Y6pxKPfR/+0c4CKs/JHhzKcs0JMBOzikZunkvEyD4+V9v3I/Debq9g7AXTtdkH39oQPoX1iRgtVNMC6InVexM0Kw982lco5jqVgxTopf7Q
X-MS-Exchange-AntiSpam-MessageData: 7h1WOfQqH78hB8FvWQyBIrbxPFGMTjlh8T19CSlnZziF9vQcEtVHW0Q8PD3t/KShLfD+m3lo5hlYfZXUGt+t0EhnK6moyBYpACzuOLlUIy+cSrlbAP83pkq8xTnmPO2eNl8HrqmlEz+GsJVbudkh5A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ff829c-4860-4308-d6dd-08d7b4b4d75d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 20:55:09.8907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrYjMVwL6FRl1wlVKpp4hA4+BbAJ75XaeWVa63hA1bfQeCZ1/H2mKpTIEICxiAIi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3625
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMi0xOCAzOjI3IGEubS4sIEh1YW5nIFJ1aSB3cm90ZToKPiBPbiBUdWUsIEZlYiAx
OCwgMjAyMCBhdCAwNDowNDoxNVBNICswODAwLCBLb2VuaWcsIENocmlzdGlhbiB3cm90ZToKPj4g
QW0gMTguMDIuMjAgdW0gMDc6MTIgc2NocmllYiBIdWFuZyBSdWk6Cj4+PiBXaGlsZSB0aGUgY3Vy
cmVudCBhbWRncHUgZG9lc24ndCBzdXBwb3J0IFRNWiwgaXQgd2lsbCByZXR1cm4gdGhlIGVycm9y
IGlmIHVzZXIKPj4+IG1vZGUgd291bGQgbGlrZSB0byBhbGxvY2F0ZSBzZWN1cmUgYnVmZmVyLgo+
Pj4KPj4+IEZpeGVzOiAxN2Q5MDdjIGRybS9hbWRncHU6IGltcGxlbWVudCBUTVogYWNjZXNzb3Ig
KHYzKQo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+
Cj4+Cj4+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cj4+Cj4+PiAtLS0KPj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dlbS5jIHwgMiArLQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dlbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4+
PiBpbmRleCBiNTFhMDYwLi45MWU0MjM1IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZ2VtLmMKPj4+IEBAIC0yMzUsNyArMjM1LDcgQEAgaW50IGFtZGdwdV9nZW1f
Y3JlYXRlX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsCj4+PiAgIAlp
ZiAoYXJncy0+aW4uZG9tYWlucyAmIH5BTURHUFVfR0VNX0RPTUFJTl9NQVNLKQo+Pj4gICAJCXJl
dHVybiAtRUlOVkFMOwo+Pj4gICAKPj4+IC0JaWYgKGFtZGdwdV9pc190bXooYWRldikgJiYgKGZs
YWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfRU5DUllQVEVEKSkgewo+Pj4gKwlpZiAoIWFtZGdwdV9p
c190bXooYWRldikgJiYgKGZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfRU5DUllQVEVEKSkgewo+
Pj4gICAJCURSTV9FUlJPUigiQ2Fubm90IGFsbG9jYXRlIHNlY3VyZSBidWZmZXIgc2luY2UgVE1a
IGlzIGRpc2FibGVkXG4iKTsKPj4KPj4gQlRXOiBUaGlzIG1lc3NhZ2Ugc2hvdWxkIGJlIHJlbW92
ZWQgYmVjYXVzZSBpdCBhbGxvd3MgdXNlcnNwYWNlIHRvIHNwYW0gCj4+IHRoZSBsb2dzLgo+Pgo+
IAo+IEZpbmUuIFRoaXMgY2FuIGJlIHJlbW92ZWQuCgpJIGFscmVhZHkgc3VibWl0dGVkIHRoaXMg
Zm9yIHJldmlldywgYWxvbmcgd2l0aCB0aGUgZmxhZ3MgYnVnZml4Lgo/Pz8KCldoYXQncyBnb2lu
ZyBvbj8/Pz8KClJlZ2FyZHMsCkx1YmVuCgoKPiAKPiBUaGFua3MsCj4gUmF5Cj4gCj4+PiAgIAkJ
cmV0dXJuIC1FSU5WQUw7Cj4+PiAgIAl9Cj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
