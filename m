Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EB1C0044D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 18:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B788620736
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 18:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="asNWY29I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B788620736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A7F76E9E1;
	Wed, 11 Mar 2020 18:43:39 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690055.outbound.protection.outlook.com [40.107.69.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A04256E9E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 18:43:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJGUlqPcv9TRT4Mubx+qMD5hbP4A0WwE+FnkO1NvOq+JWlFEgwpVsP22Ag9DUcDrdhTcbdWYBMO06GqhdXZ7Avs4Cy0erOc8wKeTxbCNEkePHIPnXofvIA5gAcDiQSkDpyy+htyR3z73XYTz2wpbsQ1ol16k1oDHf4Fouek7r37KNeuG7WnT3K9U81qnuTzUlY8qOFR2uAYlbM+lXrs9lF3LO2DveW/DllbFfR3epiYpse1RGxHu96hXv89rBL5AU19+LdLLJb/a0/1aiQaH5HHrYX4/Wng4PDD/fDuqWbHJyOtNCNdRzSDivRhe5bZa/eS0shDW1ZZQmz1Vw9717A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWvXy/VbPInRyicHrxL9d8ySVYaENvz2vfatAupeGyM=;
 b=bGr06ASlbkVR9+UEVM7HcjdaECI4HpmCg10SH2xjtnGB6LAUftRZcJWXuW5IBVaYZp914rAzc2Aa6gLt9YsqRX4JFCFCKCCo2d/1UoDIaVBZM5EcDJ9OwXN1kp8F4tC8efzNdX3eoIpz6WU2DIXuq9irUEQHLVvW1JY4gD5zLs7aICpJSF1DEb0Le6SQEUtPT9RRh0AY94gaCsBHySMnAELaQkX0Ie40HCFGkXWRcgbYirMBqjCvxjmyBLWmCN5MH4a+K1E9hrNK+WHO2Ts0/6Ws/LqDT5QzwgZtduU+kmNXkDvRug7vQUVu4kr9aZV7iFimejEHacghV7884k5wOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWvXy/VbPInRyicHrxL9d8ySVYaENvz2vfatAupeGyM=;
 b=asNWY29IQYZyKv1xqaQkOOriqVcavYwWnnu6d7ZRXma8kbZWYE2sCAOzuZLnZP1F8nkkP8MENy8JZgHiypEsARekhgSM43eU/rB6OweBgCh2yxawbND2jfSec+ffTaBcAPZmO8KHPfCm3pIttZpCEwnSeODTGiokwAK5xvSeE9o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1372.namprd12.prod.outlook.com (2603:10b6:3:77::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 18:43:37 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 18:43:37 +0000
Subject: Re: [RFC PATCH 2/2] drm/amdgpu: disable gpu load balancer for vcn jobs
To: christian.koenig@amd.com, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200311171809.7115-1-nirmoy.das@amd.com>
 <20200311171809.7115-2-nirmoy.das@amd.com>
 <09a20385-ef17-f2df-bd0b-ca60bb82cbcc@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <e775ab90-fc51-4079-1095-7079bb270449@amd.com>
Date: Wed, 11 Mar 2020 19:47:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <09a20385-ef17-f2df-bd0b-ca60bb82cbcc@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::22) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f28:ae00:bd65:d97d:c346:e601]
 (2003:c5:8f28:ae00:bd65:d97d:c346:e601) by
 FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.14 via Frontend Transport; Wed, 11 Mar 2020 18:43:35 +0000
X-Originating-IP: [2003:c5:8f28:ae00:bd65:d97d:c346:e601]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1013ba56-49dd-4243-36a2-08d7c5ec1c21
X-MS-TrafficTypeDiagnostic: DM5PR12MB1372:|DM5PR12MB1372:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13721732F0B9138F94C38D448BFC0@DM5PR12MB1372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(199004)(5660300002)(66946007)(66556008)(66476007)(31686004)(478600001)(16526019)(2616005)(316002)(8936002)(36756003)(81166006)(8676002)(186003)(81156014)(31696002)(4326008)(6486002)(2906002)(53546011)(52116002)(6666004)(66574012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1372;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uc2UHF18SOwAAGRjx5HB0TJprwiwR7kfyWmAIKi16OiLmUUZb8EaRvyyGMNwjUvtmATEWgZGJmlLdEIVlZmgx9mhfMn9Ow7mTxaTH59bUKQiA030yrAajejkLRL6vglhNdylYfMEVcgjYl60FvgBz45i8ldyOzw8d/bKbb7/XhxhtO1cZYW7tgOn0QqhDhn8yf0LJdeP0qSfBg9dU98z92HB/RaibonPhakWqEqtY2F27tj23TYXORQgyzXVERVXpV0B5wwKrB8Oz9k5PCqr/lQeYwkaQ7wn/fv79DNdkw48IK7JJA9PaSMSy6ID2vf+2YVeP3VeSLQHIlZe/+8aE6t/+nV+V1smjKVoXAkWTEi9HJPDd37dnC9HCgVD/EJ6BlSjJmxqoO831gpuoDwfy22dDS7oUrIsaVKdJLm6LRPyeyHDTgSywoG7+gDm2Auk
X-MS-Exchange-AntiSpam-MessageData: Yxl1btfXuWAVvlHyU2NZ8Tv4Kfgn5Y9dDhc4xNpg1v+iTmltNlO12dw73roK9zNZhtHg3Yxvo9iGPnNUdPKGgF4KVdEx0T4K81+7NlDsnQWt51MVKExSaMSLkfF/73S+sxNW2nyUibEx6b/9AVQwZ8JN1NW++QpuHI1t6NkkBS1KSWX/rGyWZg2oBgRkUf3GHI2Bwh1ld71LjnAs2mEmYw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1013ba56-49dd-4243-36a2-08d7c5ec1c21
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 18:43:37.3225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkLn3gsmTMU5D2J7yIQ+Q9BVFtdMqxU3qlxnV8qqNcS8EgZYFjQcdN71Z0j+vecq7F2+NEP3DociKiXnB5uXjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1372
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Boyuan.Zhang@amd.com,
 nirmoy.das@amd.com, alexander.deucher@amd.com, James.Zhu@amd.com,
 Leo.Liu@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDMvMTEvMjAgNzowMyBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAxMS4wMy4y
MCB1bSAxODoxOCBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IFZDTiBIV8KgIGRvZXNuJ3Qgc3VwcG9y
dCBkeW5hbWljIGxvYWQgYmFsYW5jZSBvbiBtdWx0aXBsZQo+PiBpbnN0YW5jZXMgZm9yIGEgY29u
dGV4dC4gVGhpcyBtb2RpZmllcyB0aGUgZW50aXR5J3Mgc2NoZWRfbGlzdAo+PiB0byBhIHNjaGVk
X2xpc3QgY29uc2lzdCBvZiBvbmx5IG9uZSBkcm0gc2NoZWR1bGVyLgo+Pgo+PiBTaWduZWQtb2Zm
LWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuY8KgIHzCoCAxICsKPj4gwqAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysr
KysrKwo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmggfMKgIDIg
KysKPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jIHzCoCAxICsK
Pj4gwqAgNCBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyAKPj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+PiBpbmRleCA4MzA0ZDBjODc4OTkuLjAwMDMy
MDkzZDhhOSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2NzLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPj4g
QEAgLTEyNTcsNiArMTI1Nyw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2NzX3N1Ym1pdChzdHJ1Y3Qg
Cj4+IGFtZGdwdV9jc19wYXJzZXIgKnAsCj4+IMKgwqDCoMKgwqAgcHJpb3JpdHkgPSBqb2ItPmJh
c2Uuc19wcmlvcml0eTsKPj4gwqDCoMKgwqDCoCBkcm1fc2NoZWRfZW50aXR5X3B1c2hfam9iKCZq
b2ItPmJhc2UsIGVudGl0eSk7Cj4+IMKgICvCoMKgwqAgYW1kZ3B1X2N0eF9saW1pdF9sb2FkX2Jh
bGFuY2UoZW50aXR5KTsKPj4gwqDCoMKgwqDCoCBhbWRncHVfdm1fbW92ZV90b19scnVfdGFpbChw
LT5hZGV2LCAmZnByaXYtPnZtKTsKPj4gwqAgwqDCoMKgwqDCoCB0dG1fZXVfZmVuY2VfYnVmZmVy
X29iamVjdHMoJnAtPnRpY2tldCwgJnAtPnZhbGlkYXRlZCwgCj4+IHAtPmZlbmNlKTsKPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyAKPj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKPj4gaW5kZXggZmE1NzViZGMw
M2M4Li41N2I0OTE4ODMwNmQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9jdHguYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfY3R4LmMKPj4gQEAgLTEzOSw2ICsxMzksNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jdHhfaW5p
dF9lbnRpdHkoc3RydWN0IAo+PiBhbWRncHVfY3R4ICpjdHgsIGNvbnN0IHUzMiBod19pcCwgY29u
c3QKPj4gwqDCoMKgwqDCoCBpZiAocikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyb3Jf
ZnJlZV9lbnRpdHk7Cj4+IMKgICvCoMKgwqAgZW50aXR5LT5od19pcCA9IGh3X2lwOwo+PiDCoMKg
wqDCoMKgIGN0eC0+ZW50aXRpZXNbaHdfaXBdW3JpbmddID0gZW50aXR5Owo+PiDCoMKgwqDCoMKg
IHJldHVybiAwOwo+PiDCoCBAQCAtNTU5LDYgKzU2MCwzMCBAQCB2b2lkIGFtZGdwdV9jdHhfcHJp
b3JpdHlfb3ZlcnJpZGUoc3RydWN0IAo+PiBhbWRncHVfY3R4ICpjdHgsCj4+IMKgwqDCoMKgwqAg
fQo+PiDCoCB9Cj4+IMKgICtzdGF0aWMgdm9pZCBsaW1pdF92Y25fbG9hZF9iYWxhbmNlKHN0cnVj
dCBhbWRncHVfY3R4X2VudGl0eSAqY2VudGl0eSkKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1Y3QgZHJt
X2dwdV9zY2hlZHVsZXIgKipzY2hlZHMgPSAmY2VudGl0eS0+ZW50aXR5LnJxLT5zY2hlZDsKPj4g
Kwo+PiArwqDCoMKgIGlmIChkcm1fc2NoZWRfZW50aXR5X251bV9qb2JzKCZjZW50aXR5LT5lbnRp
dHkpID09IDEpCj4KPiBUaGF0IGNoZWNrIGRvZXNuJ3Qgd29yayBjb3JyZWN0bHksIHRoZSBqb2Ig
bWlnaHQgYWN0dWFsbHkgYWxyZWFkeSBiZSAKPiBwcm9jZXNzZWQgd2hlbiB3ZSBoaXQgaGVyZS4K
CgpPa2F5IG5vdyBJIGtub3cgd2hhdCBBbmRyZXkgbWVhbnQuIEkgd2lsbCByZXNlbmQgYSB1cGRh
dGVkIHBhdGNoLgoKClRoYW5rcywKCk5pcm1veQoKCj4KPj4gKyBkcm1fc2NoZWRfZW50aXR5X21v
ZGlmeV9zY2hlZCgmY2VudGl0eS0+ZW50aXR5LCBzY2hlZHMsIDEpOwo+Cj4gSnVzdCBhbHdheXMg
dXBkYXRlIHRoZSBzY2hlZHVsZXIgaGVyZS4KPgo+PiArCj4+ICt9Cj4+ICsKPj4gK3ZvaWQgYW1k
Z3B1X2N0eF9saW1pdF9sb2FkX2JhbGFuY2Uoc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0
eSkKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2N0eF9lbnRpdHkgKmNlbnRpdHkgPSB0
b19hbWRncHVfY3R4X2VudGl0eShlbnRpdHkpOwo+PiArCj4+ICvCoMKgwqAgaWYgKCFjZW50aXR5
KQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Cj4gVGhhdCBjaGVjayBsb29rcyBzdXBlcmZs
dW91cyB0byBtZS4KPgo+PiArCj4+ICvCoMKgwqAgc3dpdGNoIChjZW50aXR5LT5od19pcCkgewo+
Cj4gQmV0dGVyIGdldCB0aGUgcmluZyBmcm9tIGVudGl0eS0+cnEtPnNjaGVkIGluc3RlYWQuCj4K
Pj4gK8KgwqDCoCBjYXNlIEFNREdQVV9IV19JUF9WQ05fREVDOgo+PiArwqDCoMKgIGNhc2UgQU1E
R1BVX0hXX0lQX1ZDTl9FTkM6Cj4KPiBNYXliZSBiZXR0ZXIgdG8gbWFrZSB0aGF0IGEgZmxhZyBp
biB0aGUgcmluZyBmdW5jdGlvbnMsIGJ1dCB0aGlzIHdheSAKPiB3b3JrcyBhcyB3ZWxsLgo+Cj4g
UmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KPj4gK8KgwqDCoMKgwqDCoMKgIGxpbWl0X3Zjbl9sb2Fk
X2JhbGFuY2UoY2VudGl0eSk7Cj4+ICvCoMKgwqAgfQo+PiArCj4+ICt9Cj4+ICsKPj4gwqAgaW50
IGFtZGdwdV9jdHhfd2FpdF9wcmV2X2ZlbmNlKHN0cnVjdCBhbWRncHVfY3R4ICpjdHgsCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRybV9zY2hlZF9l
bnRpdHkgKmVudGl0eSkKPj4gwqAgewo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2N0eC5oIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9jdHguaAo+PiBpbmRleCBkZTQ5MGYxODNhZjIuLmQ1MmQ4ZDU2MmQ3NyAxMDA2NDQKPj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5oCj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguaAo+PiBAQCAtMzMsNiArMzMsNyBA
QCBzdHJ1Y3QgYW1kZ3B1X2Zwcml2Owo+PiDCoCDCoCBzdHJ1Y3QgYW1kZ3B1X2N0eF9lbnRpdHkg
ewo+PiDCoMKgwqDCoMKgIHVpbnQ2NF90wqDCoMKgwqDCoMKgwqAgc2VxdWVuY2U7Cj4+ICvCoMKg
wqAgdWludDMyX3TCoMKgwqDCoMKgwqDCoCBod19pcDsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgZHJt
X3NjaGVkX2VudGl0ecKgwqDCoCBlbnRpdHk7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGRtYV9mZW5j
ZcKgwqDCoCAqZmVuY2VzW107Cj4+IMKgIH07Cj4+IEBAIC05MCw1ICs5MSw2IEBAIHZvaWQgYW1k
Z3B1X2N0eF9tZ3JfZmluaShzdHJ1Y3QgYW1kZ3B1X2N0eF9tZ3IgKm1ncik7Cj4+IMKgIMKgIHZv
aWQgYW1kZ3B1X2N0eF9pbml0X3NjaGVkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKPj4g
wqAgK3ZvaWQgYW1kZ3B1X2N0eF9saW1pdF9sb2FkX2JhbGFuY2Uoc3RydWN0IGRybV9zY2hlZF9l
bnRpdHkgKmVudGl0eSk7Cj4+IMKgIMKgICNlbmRpZgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9qb2IuYwo+PiBpbmRleCA0OTgxZTQ0M2E4ODQuLjk1NWQxMmJjODlhZSAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jCj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYwo+PiBAQCAtMTU0
LDYgKzE1NCw3IEBAIGludCBhbWRncHVfam9iX3N1Ym1pdChzdHJ1Y3QgYW1kZ3B1X2pvYiAqam9i
LCAKPj4gc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSwKPj4gwqDCoMKgwqDCoCBhbWRn
cHVfam9iX2ZyZWVfcmVzb3VyY2VzKGpvYik7Cj4+IMKgwqDCoMKgwqAgcHJpb3JpdHkgPSBqb2It
PmJhc2Uuc19wcmlvcml0eTsKPj4gwqDCoMKgwqDCoCBkcm1fc2NoZWRfZW50aXR5X3B1c2hfam9i
KCZqb2ItPmJhc2UsIGVudGl0eSk7Cj4+ICvCoMKgwqAgYW1kZ3B1X2N0eF9saW1pdF9sb2FkX2Jh
bGFuY2UoZW50aXR5KTsKPj4gwqAgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gwqAgfQo+Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
