Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B519DC34031
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 08:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8842176D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 08:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fFfWT5di"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8842176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57ED56E17C;
	Tue, 18 Feb 2020 08:04:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE84F6E17C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 08:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVqqOU5maJjpPVhyaTQL53NwpBIlA6LYtzkgI6SUYZyjvNDN+pVgQALO3kGI4BRo5hkNuGHE9DZNKFGPYtfEcH6rr9k4jT0zUHaND1+ScU1l2m9iS1DUC554vzYQtlD0y4VWim63kY4MtjZJysatRIjyKLUZ3/X9YiqPWRRqimsa6cXhhgdwwhKVDb8kU9kmiYXhQ9keA2mvepmTI1St3miEoiu7niAd7YLCnmyrWZhztYYgOBb6VcP+onrX7cPlE+IiLkRT1KgaVcTKX8mr8Lqhh3c/HWFnUdqM+NQ9P+houb4ZvYmqsZgE6UTdh0lGViXAsviXOOunqIxZaJ98eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arDIpKyW17LImc8Cl2/uoZ956FYoEuNH432a9hYbK+g=;
 b=XkgKrCnysaqG+GV5/CY/9evXGXlqllrsYF//5Aa1cY3MGr5AcdR0T+p6KAccP3GWRPu4iTAvFDFcM0CGhx6kkJc1ByyDAkKj27TtzVD40OTnzmVEpZhtowgHyLJccw8sn6X6nC+xUnJgcYTGHaTjdhkpzFKOnYhGATKSkmHAkL26ciNY4WVAjQQTAxfAi96oAjO1YM0bo568ySaYRGQFmBGp0s9/+a1jdrn0Ztqfx7/+bsit+u5vXUlZ/xDUhcWskJAYbko+AsXFUvZx+bogvFR4raFEz3ulsIQ585doOYKOAI4UFzlqPjGnvPmCHjn5ObIe/Dypd+HNoUbgNEmJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arDIpKyW17LImc8Cl2/uoZ956FYoEuNH432a9hYbK+g=;
 b=fFfWT5di2O4SEAqDf0TW1Dd9rBB/mazcLGejW3g5KKftLkEO24Vwnjsaa5ckoc1HwO/oLBGAnq0RQPSW0/5M9JwCa7smpnZZLMcX3MjIwoxnCuCJiSOyetbqWyF5UPtqfAf/HwU53ERhVkGQLsj4xbDN2763eWiUdmdOGQhJ+To=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1273.namprd12.prod.outlook.com (10.168.238.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Tue, 18 Feb 2020 08:04:22 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2729.032; Tue, 18 Feb
 2020 08:04:22 +0000
Subject: Re: [PATCH] drm/amdgpu: fix the wrong logic checking when secure
 buffer is created
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1582006331-32356-1-git-send-email-ray.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d4595b32-a5a2-483b-117b-606c9e28ce25@amd.com>
Date: Tue, 18 Feb 2020 09:04:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <1582006331-32356-1-git-send-email-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR08CA0051.eurprd08.prod.outlook.com
 (2603:10a6:205:2::22) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR08CA0051.eurprd08.prod.outlook.com (2603:10a6:205:2::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Tue, 18 Feb 2020 08:04:20 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1bbeb9d7-29d6-4c9d-b99e-08d7b449294e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1273:|DM5PR12MB1273:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1273A501DD815DEA95631B6183110@DM5PR12MB1273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(189003)(199004)(16526019)(478600001)(2906002)(2616005)(66946007)(31686004)(52116002)(86362001)(186003)(66476007)(66556008)(36756003)(6666004)(4326008)(81166006)(54906003)(316002)(31696002)(8676002)(81156014)(66574012)(5660300002)(8936002)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1273;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raikisNCyfFBpXnlM5womy1I0qqSiO6f2WXL6IyshVXcT9YCVLH8A7da35O8uKmdbHTC2to3VY0IOG97xjdrLBh1SPtxt6IlJp9fANdPA7mIbgK4Ev/Z4hrWtEBW4F5kG/Ngc54ntujPz80IetBXaMY07nbR3CXJo/BwHg2cIJgp94TzmieUAiyk0aRSaqdLo3zYvYt82BI7iao7Z3ROKYtuuhqH0kH0jReyb6uoSxk9tL+9Kbasd0UnLyjMEE9o0WUhtHZVlW4yte4Keraj4ZcHmyJ3TiZ5hTXAEkSorZSHiBvSD7sV2Fr5NiNci6PsSkvPzLmerNLGsaij9+Pd3hNf8XbvfqbUjf42Ncb3+nowZRzdZX9jnBO2hKC3/k/ZNuXBo2UQkhfe2VQgWX1tFd/8t72+QY5gk5Tr+oyxX98UvjdPnIJhJTVXU18d4s6f
X-MS-Exchange-AntiSpam-MessageData: 9ALoMvlYQNCotL2OBL7kgR+Sb7TGfo9ClPqJfEprW2khKFKhSe/TlmKwtHTbYUlB0NUYCBI/owbGXFtF5hNJzUSJ3XVnWf5oxAn+t+7UZ2wmWR2QBaKLVWk8PaI94ci//5YHjh0BvlTZvEAGbTU5pFZtUqJN3s6G2zpNG0trSlOeAsMLB9x8gsvHYaWZpVwxLCW76UeDZGhz4qmuBhNVtQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbeb9d7-29d6-4c9d-b99e-08d7b449294e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 08:04:21.9749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K81WAtl8EfIex57YWjCa2KkND9GlEUcdoJTJxM4MCsAxCVtc3Xb6Eb2dfoIHw8Ns
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1273
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Aaron Liu <aaron.liu@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTguMDIuMjAgdW0gMDc6MTIgc2NocmllYiBIdWFuZyBSdWk6Cj4gV2hpbGUgdGhlIGN1cnJl
bnQgYW1kZ3B1IGRvZXNuJ3Qgc3VwcG9ydCBUTVosIGl0IHdpbGwgcmV0dXJuIHRoZSBlcnJvciBp
ZiB1c2VyCj4gbW9kZSB3b3VsZCBsaWtlIHRvIGFsbG9jYXRlIHNlY3VyZSBidWZmZXIuCj4KPiBG
aXhlczogMTdkOTA3YyBkcm0vYW1kZ3B1OiBpbXBsZW1lbnQgVE1aIGFjY2Vzc29yICh2MykKPgo+
IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+CgpSZXZpZXdlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyB8IDIgKy0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+IGluZGV4IGI1MWEwNjAuLjkxZTQyMzUgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4gQEAgLTIzNSw3ICsyMzUs
NyBAQCBpbnQgYW1kZ3B1X2dlbV9jcmVhdGVfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwg
dm9pZCAqZGF0YSwKPiAgIAlpZiAoYXJncy0+aW4uZG9tYWlucyAmIH5BTURHUFVfR0VNX0RPTUFJ
Tl9NQVNLKQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgIAo+IC0JaWYgKGFtZGdwdV9pc190bXoo
YWRldikgJiYgKGZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfRU5DUllQVEVEKSkgewo+ICsJaWYg
KCFhbWRncHVfaXNfdG16KGFkZXYpICYmIChmbGFncyAmIEFNREdQVV9HRU1fQ1JFQVRFX0VOQ1JZ
UFRFRCkpIHsKPiAgIAkJRFJNX0VSUk9SKCJDYW5ub3QgYWxsb2NhdGUgc2VjdXJlIGJ1ZmZlciBz
aW5jZSBUTVogaXMgZGlzYWJsZWRcbiIpOwoKQlRXOiBUaGlzIG1lc3NhZ2Ugc2hvdWxkIGJlIHJl
bW92ZWQgYmVjYXVzZSBpdCBhbGxvd3MgdXNlcnNwYWNlIHRvIHNwYW0gCnRoZSBsb2dzLgoKPiAg
IAkJcmV0dXJuIC1FSU5WQUw7Cj4gICAJfQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
