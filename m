Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B740DC433E1
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 08:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7539A20792
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 08:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ovp85Ene"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7539A20792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A3989FCE;
	Wed,  5 Aug 2020 08:24:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 280E989FCE
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 08:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8588m0qQ6xMS7Zb3L+I1spaaqhbXfhsBtIrPj5S7oQapeKcYEUtrFkUOW5VmkrAH1I8ut05NR8iAwodr2Agt1gBVMvXHVh31ih39aaSuN6oYRXA18eaEoHpmVvuGyrZq3APd71lAzRB/RyLgz7rzs3/8ZDa5lqL19y/kysIAq9yLEcYrGGkRbT20CcKFZL2PaGLauZM6DW8mGx55pZMBfxBDQ5VcvqfkLhwcHqMotUI8iL3f1Zv4aUgKJmwQcd3eqxU7TszS8GrqaYTG5O4um/q2c39BCMbXZqdjOMfJuqJuyM76e3x2pr3JAcn9q2ywU/hXSudC5j81lORjhDJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkNkMNz1KQmTZtA9jTjs2DsmXXG76/Ntv5ZKhhdAq/A=;
 b=b6zbLCWQhAJJMHF1slbg/+KnlnGOou3cVx4eapsGXUBo25+3NBd9FMpeEzgkSqrkI4MjBS3IhysP3nsN7oNRh+hnDfVHj6XhpNb/jzcQjF8f4gv+qrv/fVMArc9j7eTEJu+sH1aHwMyYeYjpdDboDzYR7u09bALWh4RHZ0y01dktrrESkRA/Rv0RBXwYsT1MI+yd1XnP1fMAE0WeePjApQ+USO/HLsSeNeNJd2hVEJcZ4eZpuVGAw/E6iUqCOf9drGM2IkrWvOPUiFYxTGhzAwqm48n1vz9S44skrF/uBifxKL3qBCdFrh7u+Nmv9oQjz8v5FW4w618smK2ekJFCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkNkMNz1KQmTZtA9jTjs2DsmXXG76/Ntv5ZKhhdAq/A=;
 b=ovp85EneKgwYQFtR/K3wVDEesIaQKlkdXRH8CyvuwNQWD7IH6Db/GOaxp/ciczCjRi4rdqi2ToanehBKK2HMGxGZT8EPQZuhqBhB+ra7umXTOScNsyLBMjCGxEIXCtSpA4HAWflZr0e16rhYprSgdco3BQbpx0YkHYwDQeakQko=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Wed, 5 Aug
 2020 08:24:27 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::d85e:c081:c3d:9db3]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::d85e:c081:c3d:9db3%4]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 08:24:27 +0000
Subject: Re: [PATCH] drm/amdgpu: new ids flag for tmz (v2)
To: christian.koenig@amd.com,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200730135457.38848-1-pierre-eric.pelloux-prayer@amd.com>
 <93bcdc83-24b6-5a66-2e73-adea528c2edb@gmail.com>
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Message-ID: <c47ca91b-4391-05ec-bd48-df941bb37f7d@amd.com>
Date: Wed, 5 Aug 2020 10:23:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <93bcdc83-24b6-5a66-2e73-adea528c2edb@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0175.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::19) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.243] (109.190.135.109) by
 PR0P264CA0175.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.16 via Frontend Transport; Wed, 5 Aug 2020 08:24:25 +0000
X-Originating-IP: [109.190.135.109]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38fb812b-b2b8-4029-5591-08d83918f789
X-MS-TrafficTypeDiagnostic: DM6PR12MB4483:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4483A5919A1696BD9386F7208D4B0@DM6PR12MB4483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLtOGo4C9KWg9v/PJ6wjDLQdQbcIAoN7903aIridw598qzqs+TdIGfTTKGxqnRWLU5PwJM44Y7q8zys3iNFX7SypoAZ+Zk7RkkORMjbFDAHH86MX6wdLCPnyk0aIhGf0QZdiIQlqkBZ9cdGJZ6ZVSp9EnAEYplDXF+agFJQsr8i+VNaXKOFVDTUIdd0f/kPV4ZBv7mdOwwEVixtzSJtLsp03W09fn9JKy6ZK7auWKGz6UsUdgR8ouQsOd5UhsB1fbPi4dUIyj9SJGYsXW78+xUWqMTwkEOXwpp3tLP2L4BqK+09a4krR1juxIIrF2hnh3Anx0svkOilcjoKPpNSemhER9TR8cwrw6X8ezOSXAs0fbhuw6+YGUoTJdpMwSILh7dybpmnleg3a3AJFSkK8dnDyxcodO8sivVPmZBpqKeA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(86362001)(6486002)(16576012)(66556008)(2906002)(316002)(8936002)(66946007)(66476007)(36756003)(6666004)(31696002)(8676002)(5660300002)(478600001)(31686004)(966005)(16526019)(186003)(956004)(26005)(2616005)(55236004)(52116002)(53546011)(83380400001)(66574015)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kngpdbA5H6es2VcBbu3zuQZYKqqt7mHuYqTltl+2TeZPSeXPZ4rou2lvfzk4ALjHYKsHMPmPeDy6QfaHy2QU5OCSeBxvpiGk+xn6IqLbgrP89HHZCJW4yzPV1d24v6ZhpYhmwjpTAT+rVDVgis99x4yQeLqhcJYRVOietT7EHdDiMlgBIqlDtpwNSYsZLbh2Fn1tMQqh6WLrXjdUbvwgmz8UT+0mKJEMCyUXyYaipCeQiO8JG313UnxqWPTN4Wi2GPcfd3QEkgU8ivBbbVgiZoAIoWlo6Ynp6UkQ5BY+OuTe+fjYgcA+h20ASzpsbwYwSG6ZqbO32UDqonuxgviFanbkgTaTVvTV+g8lxVVz0rtsvgfgRzpQuu2WBeG2OqCirCfeBuSM/Mx5I3KNZJzPTau7PwOnPQK6eub9hueTUwtiB9GzoA6DG43OlE0NiorLrgVNtO/qAS2z/s/ROuqBjcRgUZVrPhO6G+LjmuXEbd3i+tOQLNI9pKQA21Q4yKyeXbmic+/YFc+0skONgYN4ym4Y3fzBrDICUsxjDEwOQ7OC8fmQm/hEc6Ngm828EtLxesc9m7hauD6xqLaLV5zhoqP6csbd0tj0cyobJc2+y8u7d3tebqtiXqi1HJTyGCoJ7ACpoP9F76OcOjfm4vER5w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fb812b-b2b8-4029-5591-08d83918f789
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 08:24:27.0025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lw9Y3JKjwHP8KnZivCPWvFBz6u+E9TcAUVAEiXYJ+X0+/4cQ5q5PpCS+Q7RQJYjc23VAJ9X/zNhA+fKCfyA/SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQ2hyaXN0aWFuLAoKT24gMzAvMDcvMjAyMCAxNjo0NiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90
ZToKPiBBbSAzMC4wNy4yMCB1bSAxNTo1NCBzY2hyaWViIFBpZXJyZS1FcmljIFBlbGxvdXgtUHJh
eWVyOgo+PiBBbGxvd3MgVU1EIHRvIGtub3cgaWYgVE1aIGlzIHN1cHBvcnRlZCBhbmQgZW5hYmxl
ZC4KPj4KPj4gVGhpcyBjb21taXQgYWxzbyBidW1wcyBLTVNfRFJJVkVSX01JTk9SIGJlY2F1c2Ug
aWYgd2UgZG9uJ3QKPj4gVU1EIGNhbid0IHRlbGwgaWYgImlkc19mbGFncyAmIEFNREdQVV9JRFNf
RkxBR1NfVE1aID09IDAiIG1lYW5zCj4+ICJ0bXogaXMgbm90IGVuYWJsZWQiIG9yICJ0bXogbWF5
IGJlIGVuYWJsZWQgYnV0IHRoZSBrZXJuZWwgZG9lc24ndAo+PiByZXBvcnQgaXQiLgo+Pgo+PiB2
MjogdXNlIGFtZGdwdV9pc190bXooKSBhbmQgcmV3b3JkZWQgY29tbWl0IG1lc3NhZ2UuCj4gCj4g
WW91ciBzaWduZWQtb2ZmLWJ5IGxpbmUgaXMgbWlzc2luZywgYnV0IGFwYXJ0IGZyb20gdGhhdCB0
aGUgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KCgpUaGFua3MsIEknbGwgYWRkIG15IHMtby1iIHRhZyBiZWZvcmUgcHVzaGlu
ZyB0aGUgcGF0Y2guCgpQaWVycmUtRXJpYwoKPiAKPj4gLS0tCj4+IFBhdGNoIGZvciB1c2luZyBp
dCBpbiBNZXNhIGlzIGF0IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9tZXNhL21lc2Ev
LS9tZXJnZV9yZXF1ZXN0cy82MDQ5Cj4+IChhYy9ncHVfaW5mbzogYWRkIGRldGVjdGlvbiBvZiBU
TVogc3VwcG9ydCkuCj4+IEkndmUga2VwdCB0aGUgQU1ER1BVX0lEU19GTEFHU19UTVogbmFtZSB0
byBtYXRjaCB0aGUgZXhpc3RpbmcKPj4gQU1ER1BVX0lEU19GTEFHU19QUkVFTVBUSU9OIGZsYWcu
Cj4+Cj4+IFBpZXJyZS1FcmljCj4+Cj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kcnYuYyB8IDMgKystCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9rbXMuYyB8IDIgKysKPj4gwqAgaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmjCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8IDEgKwo+PiDCoCAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ry
di5jCj4+IGluZGV4IDYyOTFmNWYwZDIyMy4uNmRjYWIyNTkxNGNmIDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4+IEBAIC04OCw5ICs4OCwxMCBAQAo+PiDC
oMKgICogLSAzLjM3LjAgLSBMMiBpcyBpbnZhbGlkYXRlZCBiZWZvcmUgU0RNQSBJQnMsIG5lZWRl
ZCBmb3IgY29ycmVjdG5lc3MKPj4gwqDCoCAqIC0gMy4zOC4wIC0gQWRkIEFNREdQVV9JQl9GTEFH
X0VNSVRfTUVNX1NZTkMKPj4gwqDCoCAqIC0gMy4zOS4wIC0gRE1BQlVGIGltcGxpY2l0IHN5bmMg
ZG9lcyBhIGZ1bGwgcGlwZWxpbmUgc3luYwo+PiArICogLSAzLjQwLjAgLSBBZGQgQU1ER1BVX0lE
U19GTEFHU19UTVoKPj4gwqDCoCAqLwo+PiDCoCAjZGVmaW5lIEtNU19EUklWRVJfTUFKT1LCoMKg
wqAgMwo+PiAtI2RlZmluZSBLTVNfRFJJVkVSX01JTk9SwqDCoMKgIDM5Cj4+ICsjZGVmaW5lIEtN
U19EUklWRVJfTUlOT1LCoMKgwqAgNDAKPj4gwqAgI2RlZmluZSBLTVNfRFJJVkVSX1BBVENITEVW
RUzCoMKgwqAgMAo+PiDCoCDCoCBpbnQgYW1kZ3B1X3ZyYW1fbGltaXQgPSAwOwo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCj4+IGluZGV4IGVlYmJlMjEwM2UzMi4uZDM1
M2RlZDM1M2JiIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfa21zLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5j
Cj4+IEBAIC03MzYsNiArNzM2LDggQEAgc3RhdGljIGludCBhbWRncHVfaW5mb19pb2N0bChzdHJ1
Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRhLCBzdHJ1Y3QgZHJtX2ZpbGUKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2luZm8uaWRzX2ZsYWdzIHw9IEFNREdQVV9JRFNfRkxB
R1NfRlVTSU9OOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGFtZGdwdV9tY2JwIHx8IGFtZGdw
dV9zcmlvdl92ZihhZGV2KSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2luZm8u
aWRzX2ZsYWdzIHw9IEFNREdQVV9JRFNfRkxBR1NfUFJFRU1QVElPTjsKPj4gK8KgwqDCoMKgwqDC
oMKgIGlmIChhbWRncHVfaXNfdG16KGFkZXYpKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBk
ZXZfaW5mby5pZHNfZmxhZ3MgfD0gQU1ER1BVX0lEU19GTEFHU19UTVo7Cj4+IMKgIMKgwqDCoMKg
wqDCoMKgwqDCoCB2bV9zaXplID0gYWRldi0+dm1fbWFuYWdlci5tYXhfcGZuICogQU1ER1BVX0dQ
VV9QQUdFX1NJWkU7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB2bV9zaXplIC09IEFNREdQVV9WQV9S
RVNFUlZFRF9TSVpFOwo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJt
LmggYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAo+PiBpbmRleCA3NjVhOTRlYzQ0MjAu
LmI4MjZmMmQ2ZWZlMSAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJt
LmgKPj4gKysrIGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKPj4gQEAgLTY3Niw2ICs2
NzYsNyBAQCBzdHJ1Y3QgZHJtX2FtZGdwdV9jc19jaHVua19kYXRhIHsKPj4gwqDCoCAqLwo+PiDC
oCAjZGVmaW5lIEFNREdQVV9JRFNfRkxBR1NfRlVTSU9OwqDCoMKgwqDCoMKgwqDCoCAweDEKPj4g
wqAgI2RlZmluZSBBTURHUFVfSURTX0ZMQUdTX1BSRUVNUFRJT07CoMKgwqDCoCAweDIKPj4gKyNk
ZWZpbmUgQU1ER1BVX0lEU19GTEFHU19UTVrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4NAo+PiDC
oCDCoCAvKiBpbmRpY2F0ZSBpZiBhY2NlbGVyYXRpb24gY2FuIGJlIHdvcmtpbmcgKi8KPj4gwqAg
I2RlZmluZSBBTURHUFVfSU5GT19BQ0NFTF9XT1JLSU5HwqDCoMKgwqDCoMKgwqAgMHgwMAo+IAo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdm
eCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
