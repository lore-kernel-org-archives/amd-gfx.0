Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1795BC43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 21:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF5120866
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 21:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uGLeTM7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF5120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 919766E150;
	Fri, 20 Dec 2019 21:40:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 762CE6E150
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 21:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gk2MKREZFGv01DoRyhOceI9kI15/dXPvcL6VDyXEiqrBuZXcqCuW7D2MBDQrOIMGVQas4fUX1nCNslzod+Loui2xC+ZO0wJzCPlfUZNVEt0kee3EWsp8BfMObtJJvR+IVRozAmkD0FYRxCo5jzETinvZryNbe6+kmx4yMr1uUf3X31DIuUx5H3o2RcEKFUYqtmoRegoAiF/ULvbPGPtJcH/R9k6Y3d2gh0iRfoSKGqlmAY/Hs525XL4thxj6+LcEXuoeIGRo5hx3qQpuHaXZstrtssLjfv2zCNRCTcfj8GMfBBs2K+cetYLvtERkh3vCSMbX+oF+zsdic+qf5pz54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9wCqee5eIwChVbYpHf+yISg66peJk8ms5TrDMuQElI=;
 b=mlnAnP0XjEurd4m5bK4kM5qsODbUUsJAqMMRIOs0teN9/trvoLboCgumORzbQ0geeb4ury6eNl/QxkQ1jm/+9h/DkKuXUAvcpyeh2sOnxrIqVXy7uLszTkG1Cq8CS/Q8/u1eGKhcM4SQYc9T7TwKj6es3FspA+bWm5GoNhvGiAneSWJixKNF2aCk40whrhc4Z+qgR0kjDzX8kyucO2qiYjABG/3BYfEQGpe7nv98tUtDJhuw5sOwx5hCBiR4sbUT/6tFCeYM3AMMt9+KEK/5oGq8DLtvFKL1nzuXtMW7E7Ww4wVRy9x3xW8ZgmldwaUIMIyAfTKkb1OoXt30F5x3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9wCqee5eIwChVbYpHf+yISg66peJk8ms5TrDMuQElI=;
 b=uGLeTM7EnXJQ9lv+nwnkuItb/ZcM+AwO0CWEaRFZZvB69o2uGUz1yuRFMIls8qS5FU3vg/ChiCVB2ri+1XR2IKNzKj3zOawhE4iKRAmNXrvcJJd8gBOa3qboNE8pOD7hY/rWrjy+MyoZG7/WdNycyd/YgslfinCzLgFtPEEdJNU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (10.255.237.150) by
 MN2PR12MB3134.namprd12.prod.outlook.com (20.178.241.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Fri, 20 Dec 2019 21:40:26 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08%6]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 21:40:26 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu: invalidate BO during userptr mapping
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191220062442.33635-1-alex.sierra@amd.com>
 <20191220062442.33635-5-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <59ee465f-6c21-c5e5-9951-616c2ff2f60e@amd.com>
Date: Fri, 20 Dec 2019 16:40:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191220062442.33635-5-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::49) To MN2PR12MB3949.namprd12.prod.outlook.com
 (2603:10b6:208:167::22)
MIME-Version: 1.0
Received: from [172.31.19.228] (165.204.54.211) by
 YTOPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::49) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 20 Dec 2019 21:40:26 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 52a03ff9-94dd-4434-595c-08d7859539f0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3134:|MN2PR12MB3134:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3134AC5821C80574C5ADC8FA922D0@MN2PR12MB3134.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 025796F161
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(199004)(189003)(31696002)(5660300002)(66946007)(478600001)(81156014)(81166006)(44832011)(86362001)(36756003)(31686004)(186003)(6486002)(4001150100001)(16526019)(66476007)(8936002)(8676002)(2906002)(316002)(956004)(52116002)(53546011)(66556008)(16576012)(26005)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3134;
 H:MN2PR12MB3949.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykWMutXi1WHB6Q51xzxwlN9QeN5aBtCDEK7JazgpsBdl43re9GNX/j7ERUKusijMe9RUoHwjXAjoZZiHD4oIZDsPBU3c6kcAOCrGEJQPBPVXP3dtenDu1JR2miTBryjQVI38GaSKlVHR5QYtYLA5n5d2VLjCnKJGlwNe58uBu9GLh6PyqkrWTV0Eid2pwpAILzdL2J377t8XNZa4tnHGLlWK2o0u+WD0f5Z/X20v693fPtgxOhrNIksh721TarJXPtXVZ44P/+ppp85pmvHJnNSBnRKou6HH2q7v23wqIIBFnSka/W1cABji6Ds5xfpaeTyE/R4pPE8gKnA4WJhkDG+4Vn7pp23T5UNKj1Y2iwG+EgYT+dXEU3xEMjCP5gAGI85nZ5tqBN1wLspHCVsDX6YQlrMsyf/EwHeKPq7cbQkuw1HI/ONoSIiv/A0x1VVt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a03ff9-94dd-4434-595c-08d7859539f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 21:40:26.6697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovSNQcsd5ylW6ukX1W+ebapdSJ03Ei30fFietwfoQBXVmKw80USKIeTZTxRGHDO+Ffk7Gsy3/YfzGEzUbU4ntg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3134
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSB0aGluayB0aGlzIHBhdGNoIGlzIGp1c3QgYSBwcm9vZiBvZiBjb25jZXB0IGZvciBub3cuIEl0
IHNob3VsZCBub3QgYmUgCnN1Ym1pdHRlZCBiZWNhdXNlIHRoZXJlIGFyZSBzdGlsbCBzb21lIGtu
b3duIGxvY2tpbmcgaXNzdWVzIHRoYXQgbmVlZCB0byAKYmUgc29sdmVkLCBhbmQgd2UgZG9uJ3Qg
aGF2ZSB0aGUgY29kZSB5ZXQgdGhhdCBoYW5kbGVzIHRoZSByZWNvdmVyYWJsZSAKcGFnZSBmYXVs
dHMgcmVzdWx0aW5nIGZyb20gdGhpcy4KClJlZ2FyZHMsCiDCoCBGZWxpeAoKT24gMjAxOS0xMi0y
MCAxOjI0LCBBbGV4IFNpZXJyYSB3cm90ZToKPiBUaGlzIGlzIHJlcXVpcmVkIGZvciBITU0gZnVu
Y3Rpb25hbGl0eSBvbmx5IG9uIEdGWHY5IEdQVSwgd2hpY2ggc3VwcG9ydHMKPiByZWNvdmVyYWJs
ZSBwYWdlIGZhdWx0cy4KPgo+IFtXaHldCj4gSW5zdGVhZCBvZiBzdG9wcGluZyBhbGwgdXNlciBt
b2RlIHF1ZXVlcyBkdXJpbmcgYSB1c2VycHRyIG1hcHBpbmcuCj4gVGhlIEdGWHY5IHJlY292ZXJh
YmxlIHBhZ2UgZmF1bHQgaXMgdXNlZCB0byByZXZhbGlkYXRlIHVzZXJwdHIgbWFwcGluZ3MuCj4g
Tm93LCB0aGlzIHdpbGwgYmUgZG9uZSBvbiB0aGUgcGFnZSBmYXVsdCBoYW5kbGVyLgo+Cj4gW0hv
d10KPiBJbnZhbGlkYXRlIGJ1ZmZlciBvYmplY3RzIHRoYXQgY29ycmVzcG9uZCB0byB0aGUgc3Bl
Y2lmaWMgYWRkcmVzcyByYW5nZQo+IG9uIHRoZSBtbXUgbm90aWZpZXIuCj4KPiBDaGFuZ2UtSWQ6
IEk5NGI4ZmVlOGQ4OGZmMjQwYjYxOWNiYTFjNTQ1OGFiYTk4YjE3NzM2Cj4gU2lnbmVkLW9mZi1i
eTogQWxleCBTaWVycmEgPGFsZXguc2llcnJhQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW4uYyB8IDU2ICsrKysrKysrKysrKysrKysrKysrKysr
Ky0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW4uYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tbi5jCj4gaW5kZXggMzkyMzAwZjc3
YjEzLi4wNjQxNWQ4YWQzYzEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X21uLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
bW4uYwo+IEBAIC0xODcsNiArMTg3LDQ1IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9tbl9pbnZhbGlk
YXRlX25vZGUoc3RydWN0IGFtZGdwdV9tbl9ub2RlICpub2RlLAo+ICAgCX0KPiAgIH0KPiAgIAo+
ICsvKioKPiArICogYW1kZ3B1X21uX2ludmFsaWRhdGVfYm8gLSBpbnZhbGlkYXRlIGEgQk8KPiAr
ICoKPiArICogQGJvOiBhbWRncHUgYnVmZmVyIG9iamVjdCB0byBpbnZhbGlkYXRlCj4gKyAqIEBh
ZGV2OiBhbWRncHUgZGV2aWNlIHBvaW50ZXIKPiArICoKPiArICogQmxvY2sgZm9yIG9wZXJhdGlv
bnMgb24gQk8gd2hpbGUgaXMgY2xlYXJlZC4KPiArICovCj4gK3N0YXRpYyBpbnQgYW1kZ3B1X21u
X2ludmFsaWRhdGVfYm8oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gKwkJCQkgICAgIHN0
cnVjdCBhbWRncHVfYm8gKmJvKQo+ICt7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X3ZtX2JvX2Jhc2UgKmJv
X2Jhc2U7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2JvX3ZhICpib192YTsKPiArCXN0cnVjdCBrZ2RfZGV2
ICprZ2QgPSAoc3RydWN0IGtnZF9kZXYgKilhZGV2Owo+ICsJbG9uZyByID0gMDsKPiArCWxvbmcg
dG1vOwo+ICsKPiArCXRtbyA9IG1zZWNzX3RvX2ppZmZpZXMoMTAwKTsKPiArCWZvciAoYm9fYmFz
ZSA9IGJvLT52bV9ibzsgYm9fYmFzZTsgYm9fYmFzZSA9IGJvX2Jhc2UtPm5leHQpIHsKPiArCQli
b192YSA9IGNvbnRhaW5lcl9vZihib19iYXNlLCBzdHJ1Y3QgYW1kZ3B1X2JvX3ZhLCBiYXNlKTsK
PiArCQlyID0gYW1kZ3B1X3ZtX2JvX3VwZGF0ZShhZGV2LCBib192YSwgdHJ1ZSk7Cj4gKwkJaWYg
KHIpCj4gKwkJCWJyZWFrOwo+ICsKPiArCQlyID0gZG1hX2ZlbmNlX3dhaXRfdGltZW91dChib192
YS0+bGFzdF9wdF91cGRhdGUsIGZhbHNlLCB0bW8pOwo+ICsJCWlmIChyIDw9IDApIHsKPiArCQkJ
aWYgKHIgPT0gMCkKPiArCQkJCXIgPSAtRVRJTUVET1VUOwo+ICsKPiArCQkJYnJlYWs7Cj4gKwkJ
fSBlbHNlIHsKPiArCQkJciA9IDA7Cj4gKwkJfQo+ICsKPiArCQlhbWRncHVfYW1ka2ZkX2ZsdXNo
X2dwdV90bGJfcGFzaWQoa2dkLCBib19iYXNlLT52bS0+cGFzaWQpOwo+ICsJfQo+ICsJcmV0dXJu
IHI7Cj4gK30KPiArCj4gICAvKioKPiAgICAqIGFtZGdwdV9tbl9zeW5jX3BhZ2V0YWJsZXNfZ2Z4
IC0gY2FsbGJhY2sgdG8gbm90aWZ5IGFib3V0IG1tIGNoYW5nZQo+ICAgICoKPiBAQCAtMjUwLDYg
KzI4OSw3IEBAIGFtZGdwdV9tbl9zeW5jX3BhZ2V0YWJsZXNfaHNhKHN0cnVjdCBobW1fbWlycm9y
ICptaXJyb3IsCj4gICAJCQkgICAgICBjb25zdCBzdHJ1Y3QgbW11X25vdGlmaWVyX3JhbmdlICp1
cGRhdGUpCj4gICB7Cj4gICAJc3RydWN0IGFtZGdwdV9tbiAqYW1uID0gY29udGFpbmVyX29mKG1p
cnJvciwgc3RydWN0IGFtZGdwdV9tbiwgbWlycm9yKTsKPiArCXN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2ID0gYW1uLT5hZGV2Owo+ICAgCXVuc2lnbmVkIGxvbmcgc3RhcnQgPSB1cGRhdGUtPnN0
YXJ0Owo+ICAgCXVuc2lnbmVkIGxvbmcgZW5kID0gdXBkYXRlLT5lbmQ7Cj4gICAJYm9vbCBibG9j
a2FibGUgPSBtbXVfbm90aWZpZXJfcmFuZ2VfYmxvY2thYmxlKHVwZGF0ZSk7Cj4gQEAgLTI3NSwx
MSArMzE1LDE5IEBAIGFtZGdwdV9tbl9zeW5jX3BhZ2V0YWJsZXNfaHNhKHN0cnVjdCBobW1fbWly
cm9yICptaXJyb3IsCj4gICAJCWl0ID0gaW50ZXJ2YWxfdHJlZV9pdGVyX25leHQoaXQsIHN0YXJ0
LCBlbmQpOwo+ICAgCj4gICAJCWxpc3RfZm9yX2VhY2hfZW50cnkoYm8sICZub2RlLT5ib3MsIG1u
X2xpc3QpIHsKPiAtCQkJc3RydWN0IGtnZF9tZW0gKm1lbSA9IGJvLT5rZmRfYm87Cj4gICAKPiAt
CQkJaWYgKGFtZGdwdV90dG1fdHRfYWZmZWN0X3VzZXJwdHIoYm8tPnRiby50dG0sCj4gLQkJCQkJ
CQkgc3RhcnQsIGVuZCkpCj4gLQkJCQlhbWRncHVfYW1ka2ZkX2V2aWN0X3VzZXJwdHIobWVtLCBh
bW4tPm1tKTsKPiArCQkJaWYgKGFtZGdwdV90dG1fdHRfYWZmZWN0X3VzZXJwdHIoCj4gKwkJCQkJ
CWJvLT50Ym8udHRtLCBzdGFydCwgZW5kKSl7Cj4gKwkJCQlpZiAoIWFtZGdwdV9ub3JldHJ5ICYm
Cj4gKwkJCQlhZGV2LT5mYW1pbHkgPj0gQU1ER1BVX0ZBTUlMWV9BSSkgewo+ICsJCQkJCWFtZGdw
dV9tbl9pbnZhbGlkYXRlX2JvKGFkZXYsIGJvKTsKPiArCQkJCX0gZWxzZSB7Cj4gKwkJCQkJc3Ry
dWN0IGtnZF9tZW0gKm1lbSA9IGJvLT5rZmRfYm87Cj4gKwo+ICsJCQkJCWFtZGdwdV9hbWRrZmRf
ZXZpY3RfdXNlcnB0cihtZW0sCj4gKwkJCQkJCQkJYW1uLT5tbSk7Cj4gKwkJCQl9Cj4gKwkJCX0K
PiAgIAkJfQo+ICAgCX0KPiAgIApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
