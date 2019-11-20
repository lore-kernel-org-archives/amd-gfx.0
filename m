Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CEDC43141
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 00:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C005220878
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 00:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C005220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 751846E9AA;
	Wed, 20 Nov 2019 00:23:44 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740057.outbound.protection.outlook.com [40.107.74.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A711E6E9AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 00:23:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqbfYFhYG+sj2IvlSgfk0rylx2Kobw2jjbG5ILT8y6hm7jLxspbippEvGnDb1GAn8mdF2AU1AzS4EnTwvz419BAV9WB2Sk0ohgVXv+6DSyf1w1dew0Rf6ufUOI14S9rz57cAy3iAYImzb5m+sapEmnasLUhAlL5s7cJk8EmwTQCRnVZMQ4xRy2RB+4jDR6ovFzNgZleijrasINjKdQ0RtwW3DU2TLuD9fSUK6ZP/rG91uBJOnb9bE5aoeGb2PPQrYENE4GX74RkcKdwcpm2pnt0fw4okE42PYgW5gBaHzQt42jMJcRavE409khWdbwV+RU+AKQn9OiuH6UruzrnAew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLXdqHPtpZ2W/2e4xUyMAcocbaXLmZ01BdoEo6g3fMU=;
 b=FaGDXA3PwzPPMK+ZWRfjM/ApyuidegShZxKzJPh0nMqDOROJpbbaeLanDcUWlhW5uJa3XU03nw4+rEGE32+Ab22wgawFQu3W8c20ucoj+rU6za+u34DUWR+4fhcaDitZoYoxnZCoyH7j28zolgZiqtzlSi1bgN9z0d5Blhgw/kl8PtYCVFleT9b2nMqbgpBi81Y9RWNKDgCxMeDBFfP2yVFLjgaGRevP58PSObhGkg1M+/QeZRkYDBmo9MvgOH7L0LuKvaaQP6436LxGKM5cYRP1NMMcELx0X1odhbTTvWECFUFBbq7Y7ECXDSfC1g6Obt8ApNhpIyu/42APwgX7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN8PR12MB3348.namprd12.prod.outlook.com (20.178.211.221) by
 BN8PR12MB2980.namprd12.prod.outlook.com (20.178.208.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Wed, 20 Nov 2019 00:23:41 +0000
Received: from BN8PR12MB3348.namprd12.prod.outlook.com
 ([fe80::a158:1dcd:18f4:8b81]) by BN8PR12MB3348.namprd12.prod.outlook.com
 ([fe80::a158:1dcd:18f4:8b81%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 00:23:41 +0000
Subject: Re: Potential BUG: [PATCH 2/8] drm/amdgpu: add a generic fb accessing
 helper function(v3)
To: Iago Abal <iago.abal@gmail.com>, "Tianci.Yin" <tianci.yin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <CAGbDTvpmPfrK=7a=mbnR-gKgi2ah+w6AeGYDU+9M9JOnWTzhBQ@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <2361d8f1-c43b-9581-5957-76deb15d3ef3@amd.com>
Date: Tue, 19 Nov 2019 19:23:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <CAGbDTvpmPfrK=7a=mbnR-gKgi2ah+w6AeGYDU+9M9JOnWTzhBQ@mail.gmail.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::17) To BN8PR12MB3348.namprd12.prod.outlook.com
 (2603:10b6:408:47::29)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7cf6e337-7054-4454-b9b1-08d76d4fe549
X-MS-TrafficTypeDiagnostic: BN8PR12MB2980:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2980AE478DABF46FA81434EA994F0@BN8PR12MB2980.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(189003)(199004)(6486002)(386003)(966005)(316002)(53546011)(8676002)(2906002)(31686004)(4001150100001)(81156014)(476003)(81166006)(2616005)(6246003)(99286004)(14444005)(86362001)(58126008)(5660300002)(7736002)(305945005)(31696002)(478600001)(50466002)(44832011)(486006)(6512007)(6636002)(14454004)(8936002)(2870700001)(6306002)(110136005)(6506007)(26005)(6436002)(186003)(36756003)(25786009)(66476007)(47776003)(66556008)(4326008)(66946007)(65806001)(66066001)(65956001)(6116002)(3846002)(229853002)(76176011)(11346002)(446003)(23676004)(52116002)(2486003)(41533002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB2980;
 H:BN8PR12MB3348.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b8PHavlBvRL647WgjD19v1FrEVW+XUDezh5ILn7KDgScB5sX7chf1qsmRfMP0gvFKWrdVlU7vYg+VOZQq8zUedfrjP8PaKsz6coRhx2OEmXhIsw+Oh794dHaPd6m3/iVp997FstI7RPd6MQc3CuK7PfrfWFP9GecOJEhO7mH2GZZhWw4jd3N0l6WT/JoBVk1SQaNWNJq9XngmaegC9kt1Ygz0FI+zjEbFNgu8BbfqcfMi9UU31Eyof19xDRWBgmtW6Sfv1PSOHubP6pjIpUvn7hKOAVMCPZbBKWxyioslHkJr8s35EkX6i+ZfuzDBRpy9TCOGR9vNP93aVg4c0TFjXzI4jOkWkfmNGH8ku7CjfikLJK5JU/4ughKRHLN6wpTEbliAQ8GtUm/2nDaCIhXrEN9/JqXCUut6VeQ8J+LFbplZZGB6Z89efTYNFhgzifFSzHiF6+1hcgUXCxe6OvOXhNeZCGyRkSHB2OuTKIbiHE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf6e337-7054-4454-b9b1-08d76d4fe549
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 00:23:41.4471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1dUYkaeOwhmhSRcle6CDRp038NWMNCQWXj/e+/GjyO7vWzuyZx1Sois51ZgOga6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2980
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLXdqHPtpZ2W/2e4xUyMAcocbaXLmZ01BdoEo6g3fMU=;
 b=RH8XuTZ7MVh+0Ygu0xvWdy6qy2ok3EsnJI8avHfirvnrKLaMNhB5i+GuZOI03ax6L2DDQ8N/9TtpuHQsvl57qbEQu8Qy18yke3aCpF1BJk8dmm6FGrcV7lcbzEk8lPgiFQyouQPRNjPozY4RR3nZvHzGCZ2JycHMqiTomUc7EIQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120002340.i1uBU06wmKz_iAr74-l22NH6oSU7jMC3LiHY3IcgGps@z>

SGkgSWFnbywKClRoYW5rIHlvdSBmb3IgZmluZGluZyBhbmQgcmVwb3J0aW5nIHRoaXMgcG90ZW50
aWFsIGRvdWJsZSBsb2NrLgoKWWVzIGluZGVlZCwgSSBzZWUgaXQtLWl0IGNhbiBpbmRlZWQgaGFw
cGVuLgoKTm93LCBzaW5jZSB0aGUgcHJpbWl0aXZlcyB1c2VkLS1tYWNyb3MgdXNpbmcgImFtZGdw
dV9tbV8ocnx3KXJlZ1woLipcKSItLWluCiJhbWRncHVfZGV2aWNlX3ZyYW1fYWNjZXNzKCkiIGRv
IHVzZSB0aGVpciBvd24gcmVnaXN0ZXItYWNjZXNzIHNwaW5sb2NrcywKaXQgbWF5YmUgd2lzZSB0
byByZW1vdmUgdGhlIHNwaW5sb2NrIHRha2UvcmVsZWFzZSBpbiAiYW1kZ3B1X2RldmljZV92cmFt
X2FjY2VzcygpIi4KCldlJ2xsIGxvb2sgaW50byBpdCBhbmQgcG9zc2libHkgc3VibWl0IGFub3Ro
ZXIgcGF0Y2guCgpUaGFua3MgYWdhaW4uCgpSZWdhcmRzLApMdWJlbgoKT24gMjAxOS0xMS0xNiAx
MToyMSBhLm0uLCBJYWdvIEFiYWwgd3JvdGU6Cj4gSGksCj4gCj4gV2l0aCB0aGUgaGVscCBvZiBh
IHN0YXRpYyBidWcgZmluZGVyIChFQkEgLSBodHRwczovL2dpdGh1Yi5jb20vSWFnb0FiYWwvZWJh
KSBJIGhhdmUgZm91bmQgYSBwb3RlbnRpYWwgZG91YmxlIGxvY2sgaW4gTGludXggTmV4dCB0YWcg
bmV4dC0yMDE5MTExNSwgZmlsZSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMuCj4gCj4gVGhpcyBidWcgc2VlbXMgdG8gYmUgaW50cm9kdWNlZCBieSBjb21taXQKPiBl
MzVlMmIxMTdmNCAoImRybS9hbWRncHU6IGFkZCBhIGdlbmVyaWMgZmIgYWNjZXNzaW5nIGhlbHBl
ciBmdW5jdGlvbih2MykiKS4KPiAKPiBUaGUgc3RlcHMgdG8gcmVwcm9kdWNlIGl0IHdvdWxkIGJl
Ogo+IAo+IDEuIFN0YXJ0IGluIGZ1bmN0aW9uIGBhbWRncHVfZGV2aWNlX3ZyYW1fYWNjZXNzYC4K
PiAyLiBFbnRlciBmb3ItbG9vcCBgZm9yIChsYXN0ICs9IHBvczsgcG9zIDw9IGxhc3Q7IHBvcyAr
PSA0KWAuCj4gMy4gRmlyc3QgbG9jazogYHNwaW5fbG9ja19pcnFzYXZlKCZhZGV2LT5tbWlvX2lk
eF9sb2NrLCBmbGFncylgLgo+IDQuIENhbGwgdG8gYFdSRUczMl9OT19LSVEobW1NTV9JTkRFWCwg
KCh1aW50MzJfdClwb3MpIHwgMHg4MDAwMDAwMClgLgo+IMKgIMKgNS4gTm90ZSBgI2RlZmluZSBX
UkVHMzJfTk9fS0lRKHJlZywgdikgYW1kZ3B1X21tX3dyZWcoYWRldiwgKHJlZyksICh2KSwgQU1E
R1BVX1JFR1NfTk9fS0lRKWAuCj4gwqAgwqA2LiBDb250aW51ZSBpbiBmdW5jdGlvbiBgYW1kZ3B1
X21tX3dyZWdgLgo+IMKgIMKgNy4gVGFrZSBlbHNlLWJyYW5jaCBpbiB0aGUgdGhpcmQgaWYtc3Rh
dGVtZW50Lgo+IMKgIMKgOC4gRG91YmxlIGxvY2s6IGBzcGluX2xvY2tfaXJxc2F2ZSgmYWRldi0+
bW1pb19pZHhfbG9jaywgZmxhZ3MpYC4KPiAKPiBJIHRoaW5rIHRoZSBjb250cm9sIGZsb3cgY291
bGQgcmVhY2ggdGhhdCBzZWNvbmQgbG9jaywgYnV0IHlvdSBtYXkga25vdyBiZXR0ZXIuCj4gCj4g
SG9wZSBpdCBoZWxwcyEKPiAKPiAtLSBpYWdvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
