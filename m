Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FE0C10F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 12:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1523D2464B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 12:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bh7OrESP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1523D2464B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CADC56E1F9;
	Tue, 10 Mar 2020 12:23:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 189B46E1F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 12:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbNo2hb7itEa3DHZqsQCabZUXVBUqyIIxB8zgP6eCfh9DVdWpJx9ryQNF1UkPCcGA7PmiSqH3wlM3H/7TjQHCT59JRPFyLohNFsCmwnEKK3gkY3P/LtpR7lwZKUSh3s2yEPqg5iWisR+P3noWf1ags+ppMkILZGFc2YWxIg7t92mF6wx6Op0Zd1HJJ5VE3hH0zDNoQYUeb80WoT5HuU5rsGEuE4jT+4aHtDIhi45CzA0hPn2hwKa5RtJHG4t4oMcLpz0YU+j8kbAI0+lcD4NLsnRbcXEngELVUtiDznsrpRgm9cRmnHsAX7SG28j5RctuXLjjBOP42I2TKR1cahlOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyB27aYStlHt8d5CHFQUaNMN15dFrzwsHWUQQqioOTI=;
 b=gpYkkhN9DxLLjv6M3wTmBg82X3ZaxYE3KgkObAh6niRa0uFOwyZvaZtbp13bSsGCqcurpP4/azR6nDyL4KfPSgiRO+gjWQbPESf5s8z7Mc61bKBsYTRxFIipJi+14cl45+/Jk2Qsa58lefT0GmMg7jepox6Xy3SUHOzdcwtXJ0xOVTz93ySmjST3WSnboPO2XCblF9nJ8QdqfNAipBUKDFAxuSr/t8Z9DRtk7J2hTrRiChpgCgjXW0gRLWKOGKK/s7WuqVyOQI7MsolcotF8/g1mXtvwuf8JHeJWetA3QqQC24BvXPvT/zG+L3FSP7+RcJuhgHWR94C7tV87xx9NPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyB27aYStlHt8d5CHFQUaNMN15dFrzwsHWUQQqioOTI=;
 b=bh7OrESPIiv7LgF5zlikkoPUTUD/W39XWkNF0PstAyokm2gWv7YVkL6kbbAGlaWpVyNg0OFsaV7YKk5j26i1XQXNct7edsCZmwLwd+f9rq6LRB1TtiDWSlIgRnw578ZkIzUspxRFWR0ei6OJjMmEwMvmoxaHsIqhML0J8Mmbmy4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1307.namprd12.prod.outlook.com (2603:10b6:3:79::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Tue, 10 Mar
 2020 12:23:18 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2793.013; Tue, 10 Mar
 2020 12:23:17 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: do not set nil entry in compute_prio_sched
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200310122456.3240-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e1648076-a679-b616-fb73-9c83f5ee65cd@amd.com>
Date: Tue, 10 Mar 2020 13:23:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200310122456.3240-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0038.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::7) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZR0P278CA0038.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.14 via Frontend Transport; Tue, 10 Mar 2020 12:23:15 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e7761ae-bae7-46a6-d8bf-08d7c4edd025
X-MS-TrafficTypeDiagnostic: DM5PR12MB1307:|DM5PR12MB1307:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB130768B915DED42E35DE7A3D83FF0@DM5PR12MB1307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(199004)(189003)(316002)(2906002)(5660300002)(52116002)(4326008)(16526019)(186003)(2616005)(81166006)(81156014)(8936002)(31686004)(6486002)(86362001)(31696002)(8676002)(478600001)(66556008)(36756003)(6666004)(66476007)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1307;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8slSr70KFWVzUYSfasLHQoTN1ACkR/kWI0PD8jPbDSI3tY4hlPUmy562qTy/jZvFgW2ym4AHAO7EpxhyPDYinlscFJcV0fGwOL/GcxpmgMgxv9wIscaNrWvwwgMJZ+Xf4Yijsyqhs12tDW/IvM2uPuI7ayrKBYaaurwfVpkXmcZHHG7o7YdueUtcU7wetRWaTZ5W/xA8jcAJ2NGHWkYF8HLI7+l8krt+acjbczyV9gG1t30O04gleI6HnnI/Gb8/+2lx0t3sV12gySY+ynvvRH8wNXEq+1uzDAAtrqXbn60yyp8FEWw9WblNjWF5bynxlCu+r6g9Fw9ZvbC022yBLQvHIFzLOuDtARb2EfXxbfqKlyHvOXoypP8qpL1RZWPZcGzpTVeX332+9r/gYyug6ffns+SRyXMsOYVluKwekuBVGxrPjaunc1nOS5Y0K2F
X-MS-Exchange-AntiSpam-MessageData: Nk9OclKYOTn1BqRgCtxWjlECnqOJLtQjud4W7ZU/owUI49lLZs/qDPzoKmDSe/MApI+gmTrGQI5pkgawc9tEQR94stv4ttqxSHIbZ7vXpa2/pJXosZ43dIv7Y6su5G4L1eUVLwoQouAizFX5v7v5ixXc6huQCxrFGbmQNp9rOx+BMeawXtyUFPEKg9rAQkPDxXXnt9XP04soK6SpA2k3nw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7761ae-bae7-46a6-d8bf-08d7c4edd025
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 12:23:17.6987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86ZJfNAcg1oZ7Kft7kypyvx2g4TboK8/ZTVtAeX+N+m6RQygXpzhTWcwl0GW/bSN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1307
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTAuMDMuMjAgdW0gMTM6MjQgc2NocmllYiBOaXJtb3kgRGFzOgo+IElmIHRoZXJlIGFyZSBu
byBoaWdoIHByaW9yaXR5IGNvbXB1dGUgcXVldWVzIGF2YWlsYWJsZSB0aGVuIHNldCBub3JtYWwK
PiBwcmlvcml0eSBzY2hlZCBhcnJheSB0byBjb21wdXRlX3ByaW9fc2NoZWRbQU1ER1BVX0dGWF9Q
SVBFX1BSSU9fSElHSF0KPgo+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNA
YW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+IGZvciB0aGlzIG9uZS4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfY3R4LmMgfCAxNSArKysrKysrKysrKy0tLS0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9jdHguYwo+IGluZGV4IDNiMjM3MGFkMWU0Ny4uZmE1NzViZGMwM2M4IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+IEBAIC02ODYsMTAg
KzY4NiwxNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfY3R4X2luaXRfY29tcHV0ZV9zY2hlZChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAlhZGV2LT5nZngubnVtX2NvbXB1dGVfc2NoZWRb
aV0gPSBudW1fY29tcHV0ZV9zY2hlZF9ub3JtYWw7Cj4gICAKPiAgIAlpID0gQU1ER1BVX0dGWF9Q
SVBFX1BSSU9fSElHSDsKPiAtCWFkZXYtPmdmeC5jb21wdXRlX3ByaW9fc2NoZWRbaV0gPQo+IC0J
CSZhZGV2LT5nZnguY29tcHV0ZV9zY2hlZFtudW1fY29tcHV0ZV9zY2hlZF9oaWdoIC0gMV07Cj4g
LQlhZGV2LT5nZngubnVtX2NvbXB1dGVfc2NoZWRbaV0gPQo+IC0JCWFkZXYtPmdmeC5udW1fY29t
cHV0ZV9yaW5ncyAtIG51bV9jb21wdXRlX3NjaGVkX25vcm1hbDsKPiArCWlmIChudW1fY29tcHV0
ZV9zY2hlZF9oaWdoID09IChBTURHUFVfTUFYX0NPTVBVVEVfUklOR1MgLSAxKSkgewo+ICsJCS8q
IFdoZW4gY29tcHV0ZSBoYXMgbm8gaGlnaCBwcmlvcml0eSByaW5ncyB0aGVuIHVzZSAqLwo+ICsJ
CS8qIG5vcm1hbCBwcmlvcml0eSBzY2hlZCBhcnJheSAqLwo+ICsJCWFkZXYtPmdmeC5jb21wdXRl
X3ByaW9fc2NoZWRbaV0gPSAmYWRldi0+Z2Z4LmNvbXB1dGVfc2NoZWRbMF07Cj4gKwkJYWRldi0+
Z2Z4Lm51bV9jb21wdXRlX3NjaGVkW2ldID0gbnVtX2NvbXB1dGVfc2NoZWRfbm9ybWFsOwo+ICsJ
fSBlbHNlIHsKPiArCQlhZGV2LT5nZnguY29tcHV0ZV9wcmlvX3NjaGVkW2ldID0KPiArCQkJJmFk
ZXYtPmdmeC5jb21wdXRlX3NjaGVkW251bV9jb21wdXRlX3NjaGVkX2hpZ2ggLSAxXTsKPiArCQlh
ZGV2LT5nZngubnVtX2NvbXB1dGVfc2NoZWRbaV0gPQo+ICsJCQlhZGV2LT5nZngubnVtX2NvbXB1
dGVfcmluZ3MgLSBudW1fY29tcHV0ZV9zY2hlZF9ub3JtYWw7Cj4gKwl9Cj4gICB9Cj4gICAKPiAg
IHZvaWQgYW1kZ3B1X2N0eF9pbml0X3NjaGVkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
