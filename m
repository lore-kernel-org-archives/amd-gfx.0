Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7F2C2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 16:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A44217F4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 16:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wgGDVjlL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A44217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B93E6F5DB;
	Wed, 22 Jan 2020 16:24:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF76E6F5DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 16:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6weY0NAYle7f87BRp/1meP5RjXL8y5ujRYlPrLOETikpKrsY1E5idZXBLIzpo3uF1F5b6sO1chNhFlXCF6mEAvO1UE/jjcdDZXh504tKYrVw/EUin8wgOFpboLe590paFCSSkCg3Qcir/ixtg4ZL+I3lTaNvjWnd5Kxa/pJvmCSDOcHwOMM5Jl8OVVF7M41ZP/cklxXb4ZWi+RR3NaT11aUjzBPjRb/96hvmsVymR20POe6Pt/bQ5BA5Hc3h4pLKeed6wQEDDW50JAiK/SR9auhfS5Pc7rr3BMp9i6GwpIOvFRJPk0eNLTrzz4zUAhF+6HAlPM74huEqjLI9MR+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFOAU4a5gquDet6/XdRIuiA/dqHjmdd1tnW0Ikt4pG4=;
 b=AEZElw3fSQlY1pALWZI8AXSNwZniv4QR+1ZadjKMPWrUS4OPkPKWwpCs9kgOO3yEE+cZOnesI9jJk7pKh5KEeElLgp205OhHiPr2iA/8L0PBCvswROiN2hVrwFRO1jB23rCA72zhTnyuewxwS7nGHR7IKLGLuWPgj9YbOE/E52QNbHobIYaCaFk17WR8HBSwKCccLH2/mQbZZDo6lvWeUUTFwAr5D+LQqTZX5HMQutSSSo8UTvztBejdNha+/iQO1bRZ9Qm2NUL2csXdkXKjUN+NDKcSqL5Hbup6MHTZ+q3QOTVKWNW5poVhebwVqGMoQBE4glgOCdN8Zoxh4PwoZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFOAU4a5gquDet6/XdRIuiA/dqHjmdd1tnW0Ikt4pG4=;
 b=wgGDVjlL9dxK8nMaH9F2fD3V4k+hHMQMYs0HAzPqrJBDA2C/dmA7gRkwF4J+B+n2pT7Mare1wV/BBwTg773Sa12ZGloIG4ZNPRrgLIQi+Y9O1rJiJB1MNLX6xw+oP+1uLBGv2lyHYqwtJnHgwgB5DwFLeF3UwgCJmc7NOaS4qhs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3724.namprd12.prod.outlook.com (10.255.174.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 22 Jan 2020 16:24:32 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 16:24:32 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: individualize amdgpu entity allocation
 per HW IP
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200121165002.3709-1-nirmoy.das@amd.com>
 <3d159a30-f7f5-a4f7-b63a-26b9f5df0ec2@amd.com>
 <6fbc12e5-ded7-ebc6-f905-f75f8faf5e1d@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <ce850bcf-7b1e-5a97-5c24-eefe16010b0c@amd.com>
Date: Wed, 22 Jan 2020 11:24:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <6fbc12e5-ded7-ebc6-f905-f75f8faf5e1d@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::22) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Wed, 22 Jan 2020 16:24:31 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e0c8cb6-ae1c-40cc-9570-08d79f578fe2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3724:|DM6PR12MB3724:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37246B32218741206319BFD4990C0@DM6PR12MB3724.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(199004)(189003)(31696002)(6506007)(53546011)(186003)(16526019)(26005)(316002)(6512007)(478600001)(52116002)(110136005)(8676002)(66476007)(31686004)(5660300002)(2906002)(8936002)(66556008)(81156014)(4326008)(81166006)(66946007)(2616005)(956004)(6486002)(44832011)(36756003)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3724;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Gj9UMBUFHibIRWoUqBuPbYIi4zu/64uvbPHX63PLiXj3Yzz5gWl0flriZwgUagBAv4dHr3G6v5QxapoTHEQ82MO74S722fDjPKjdSadNx5CTPmXnQjZlwONUy+JBoyTJrHOMTSZbJ6IVIVXuuOBbdmtZAYthZYsWxbItoERfwU9blZP6cvisyka5YMFgjggr6PAoeXpfz+WcaQnRncfVn9mVMxVXKNxQV5ODTbqVgwgDLBfjugXbTcuu7fHAclGkSKXxN8Ey29SZC8pqBKOiFltZuyIDEdriOAC1gvnmXVJrYsr2pccP7UW8AKwpF0gP2GIHx6J04G60twAbUMDrGF2z/ZE1mvak3DVJFz3iOSkEGYdViPsGv1YS/PfOQEt/LIOdpRLuuqofZoLOHsMu7p6E0Z7yqo0WffyW2udLzvLh5L+32xUrDKJ87U/r2Up
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0c8cb6-ae1c-40cc-9570-08d79f578fe2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 16:24:32.2786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elLp2gke/1IjT8/5G6KopRE80BYtGawsdA6Rmgdcvxt+3Bsfc74qqpApy6OJIiTk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3724
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMS0yMiA0OjMyIGEubS4sIE5pcm1veSB3cm90ZToKPiAKPiBPbiAxLzIyLzIwIDEy
OjM0IEFNLCBMdWJlbiBUdWlrb3Ygd3JvdGU6Cj4+Cj4+PiArCQlmb3IgKGogPSAwOyBqIDwgYW1k
Z3B1X2N0eF9udW1fZW50aXRpZXNbaV07ICsraikgewo+Pj4gKwkJCXN0cnVjdCBhbWRncHVfY3R4
X2VudGl0eSAqZW50aXR5ID0gJmN0eC0+ZW50aXRpZXNbaV1bal07Cj4+PiAgIAo+Pj4gLQkJa2Zy
ZWUoZW50aXR5LT5mZW5jZXMpOwo+Pj4gLQkJZW50aXR5LT5mZW5jZXMgPSBOVUxMOwo+Pj4gKwkJ
CWtmcmVlKGVudGl0eS0+ZmVuY2VzKTsKPj4+ICsJCQllbnRpdHktPmZlbmNlcyA9IE5VTEw7Cj4+
PiArCQl9Cj4+PiArCj4+PiArZXJyb3JfY2xlYW51cF9lbnRpdHlfbWVtb3J5Ogo+PiAiY2xlYW51
cCIgcmVmZXJzIHRvIHNvbWV0aGluZyBzcGlsbGVkLCBvciBzb21ldGhpbmcgdG8gYmUgY29sbGVj
dGVkLgo+IEl0IGlzwqAgY29sbGVjdGluZyBtZW1vcnkuCgpCdXQgaXQgcmVhbGx5IGlzIGRvaW5n
IGEgImtmcmVlKCkiLiBGcmVlaW5nIHByZXZpb3VzbHkgYWxsb2NhdGVkCm1lbW9yeS4gVGhlIHRy
YWRpdGlvbmFsIHdvcmtpbmcgaXMgbW9zdCBhY2Nlc3NpYmxlLCBpbiBteSBvcGluaW9uLgoKPj4g
KE9yIHdpbm5pbmcgaW4gYSB3YWdlcmVkIGdhbWUgb2YgY2hhbmNlLikgQWxzbyBhdCAibW9kdWxl
X2V4aXQiLCBtYXliZS4KPj4KPj4gVGhlIGtlcm5lbCBoYXMgdHJhZGl0aW9uYWxseSB1c2VkICJ1
bnJvbGwiIGFuZCAiZnJlZSIgZm9yIHRoaXMuIE5vdywgc2luY2UKPj4geW91J3JlIHVucm9sbGlu
ZyB0aGUgbG9vcCAobm90aWNlIHRoYXQgaXQgc2l0cyBhZnRlciB0aGUgInJldHVybiAwOyIpLCB0
aGVuCj4+IHlvdSBjYW4gYmFja3RyYWNrIGFuZCBuYW1lIGl0IGxpa2UgdGhpczoKPj4KPj4gRXJy
b3JfdW5yb2xsX2ZyZWUxOgo+PiAJZm9yICggOyBpID49IDA7IGktLSkKPj4gCQlmcmVlKG15X2Fy
cmF5W2ldKTsKPj4KPiBJIHByZWZlciB0aGUgZXhpc3Rpbmcgc3R5bGUgbWFrZXMgaXQgbW9yZSBy
ZWFkYWJsZS4KPiAKPiAKPiBSZWdhcmRzLAo+IAo+IE5pcm1veQo+IAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
