Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3482EC388F9
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 23:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF562137B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 23:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XlySIfA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF562137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F5796E073;
	Fri, 23 Oct 2020 23:19:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AC4D6E073
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 23:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXjMWYYwjfzIvButM0gIavmpR9yo6p+3t6j2zn0OocsjXMka175bbffLEt6TTZB8ikdFFjR1S1UhaA14VqH01jkRBDvSAtqdLncQgH2HMpFGdXpOqQ10rThPY1yjf3sH8GikAPn5O+NWXp/oeTgD8285a34pXseQwWse6+fbAVansZJkL2lK8M+MhFyZB25G84suxuafgAQXbp9ZtHl/rSc0EgtAn5wh1298Y4RMKFVFCpVvAGk2H25Wfwfx+IzKXwHD6hBKJ5zGBb5sAn0dKtudMNyHUs7mGrjQl4NFTR8Gmsn+93SscxxJv6sOepeQ0vVyHy9njjMmW+9MoeZwiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZDkW82xXKw/p/jl3wNWaMjSCEJNMDQZrnVv8eyVTh4=;
 b=Ski8KTQE8gBaTeI2rU6qbvWDBX6Vqe34I2FmT6MdFSqNIq7sGnVuMkoMvSfUNM25VU3DSiWC0QnHsgndMvlxym0TtihQnjowuHZK6ISl12Q/9/9mHsj4XeVtaJhO4N1GX13MoIUh8UAjve75vRLndChmEEKEDx5B6YvFrj2BmEzrs7uKmnRA9+w/Si5beiCbM2lhMbEBORVOy+6oht71qqdMT2R3HzWcd7+RZ9eIpRQQV+WHnstISthCHCX/zOTXfPj4PrNShRPPh8ugp9rRuM1iziB+E2g1F61SncMqABMwynGq1vgXtlPIwRY6iQjDAIfHksEjSTXyctLki0YA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZDkW82xXKw/p/jl3wNWaMjSCEJNMDQZrnVv8eyVTh4=;
 b=XlySIfA9QT3gCuEfPptmLIBqJji5fgw2Qm5w1C8Q57rPBf6S37Ce1xpfcNnRP/X1VIzwXSHM9VFNScx6VhXq8uDogQqT1iFJ+0MiX+JoRUI+mDRaA5xgAHEWIUPTi4hu2K1J8DQchx3mBcw9+pq3eXkdcFGRv4dNBlVRXJTmsgU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (10.255.175.85) by
 DM6PR12MB3178.namprd12.prod.outlook.com (20.179.107.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Fri, 23 Oct 2020 23:19:51 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067%7]) with mapi id 15.20.3477.029; Fri, 23 Oct 2020
 23:19:51 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix size calculation when init onchip memory
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201023054112.3307-1-xinhui.pan@amd.com>
 <a71b6131-5d5b-d00b-fb46-973d333d73fb@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <7ebfd8ba-9d8a-0874-2fde-271f751067c2@amd.com>
Date: Fri, 23 Oct 2020 19:19:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <a71b6131-5d5b-d00b-fb46-973d333d73fb@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YT1PR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::10) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YT1PR01CA0101.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.23 via Frontend Transport; Fri, 23 Oct 2020 23:19:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fdfa40bf-f24d-47e2-fdd8-08d877aa2431
X-MS-TrafficTypeDiagnostic: DM6PR12MB3178:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3178C71B9F3254A115696E2D991A0@DM6PR12MB3178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Oosgb7Q2slpUGXHONuj8juVbixd/lg1gYQ96KCKsDb2IoL9zXjfHHVnSe+RrGUFfCMejiFZEXB9ER3I7SJZba/7XOgae6F0BcnWPWV6apps564Tjlufi4K5y+gabIRSCyFw0CSuSBGIi8fUYcqcxX5mhy9tzxlHrf4a482CF+w9Fr0u6Ii/+//6Bbn6J8ElxJwpP5T5fEuMdKRO4YemUhfbvIaA9fOu9iDini85zW3kCAG3QeoaHlNxfRvRiPiwSuwjluFmDrBjQweK052St1EqjIUCFurbYg//KP6S7fchbf6mPmlMNq0aIzQscrxyl6K4SXsy/r+iKGPeaIRjfH7I+54pdafG+PDpKogC+vtHNSm/6mDD/1BpE0EsYgWJpxyibjh0/6vpIBTSUUGTiihlBArQlSrHnfc1OECSwlk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(966005)(4001150100001)(86362001)(31686004)(6486002)(5660300002)(110136005)(316002)(16576012)(478600001)(4326008)(45080400002)(956004)(186003)(16526019)(44832011)(2616005)(66476007)(53546011)(66556008)(83380400001)(66946007)(26005)(2906002)(31696002)(6666004)(8936002)(8676002)(52116002)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MgU7yFQNlfKL83FQqKRM3wvL5X4qknldeJJ7JYzVVH36/p/3X0w+2WTTS0AcmH2G10f5tghZlHp/wB3bacmWbyYjOGdctuawPH9N4QzcKOAfM9hhFM34cWkxhhAYq7qe9+k97ttxVBKBFl8Q6Yog0N/RSulYImf7v4CYMVmhxR1gLnVfEfypCbicR6uevyaeJ/IX6BKpgFeb621i1f/YrJ5K7rQOvcK+SwBQmN8YDp3ejnt81/O0itlGHOrlqwaSd9tS34rRRSjHgfiApj7H5y3fPQc5hmddc4f+6ZmEFA0mPIi/TFwMoXCxygtN4Wv7skI8uLBv4CEK7CCX6KAxGOQBywPYqYqotW+aby1vz00cwBPt7qGjnpLg5TBL9i6s2eh6MqmJGBB1UY/B+5fFDac1z5Ix1FIgOzVjAuBIlbylhy/ALQBtNY4b0HHU/dUYTuziIudD/uyIE6zlr8iyQirrj8bUyYH+P3cy2oAG0W7w/WkdgKgBItQW/XyhjlhvP0cTSSsP/NlW9psBfdNDhlUf2thPyWQ9PNn1HumYN3jHD47ZqR/bXLNTy7obaZOKc9hyNVR6Isd9R66IDf+FJF+tRKaKEXE5Dpo8SEkz2CbEwsBjh04ZyY5bKsj0wgNA+CQSgON1L3tOA1R67w8gow==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfa40bf-f24d-47e2-fdd8-08d877aa2431
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 23:19:51.0455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwVm+3RV6SmQboYfUQTbXYKwFcNQh0VQ/kthJnlTu3dGygAjz9TFtN+ig0C7/DH1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3178
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
Cc: alexander.deucher@amd.com, Guchun.Chen@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0xMC0yMyAwMzoxMiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyMy4xMC4y
MCB1bSAwNzo0MSBzY2hyaWViIHhpbmh1aSBwYW46Cj4+IFNpemUgaXMgcGFnZSBjb3VudCBoZXJl
Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFtZC5jb20+Cj4g
Cj4gQWggeWVzIHRoYXQgb25lIGFnYWluLiBBdCBzb21lIHBvaW50IHdlIHJlYWxseSBuZWVkIHRv
IGNsZWFuIHRoYXQgdXAuCj4gCj4gUGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7Zu
aWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAKPj4gLS0tCj4+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgNCArKy0tCj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90dG0uYwo+PiBpbmRleCA0YTg1ZjhjZWRkNzcuLjExZGQzZDllYWMxNSAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+PiBAQCAtNjUs
MTEgKzY1LDExIEBACj4+ICAgCj4+ICAgc3RhdGljIGludCBhbWRncHVfdHRtX2luaXRfb25fY2hp
cChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4gICAJCQkJICAgIHVuc2lnbmVkIGludCB0
eXBlLAo+PiAtCQkJCSAgICB1aW50NjRfdCBzaXplKQo+PiArCQkJCSAgICB1aW50NjRfdCBzaXpl
X2luX3BhZ2UpCj4+ICAgewo+PiAgIAlyZXR1cm4gdHRtX3JhbmdlX21hbl9pbml0KCZhZGV2LT5t
bWFuLmJkZXYsIHR5cGUsCj4+ICAgCQkJCSAgVFRNX1BMX0ZMQUdfVU5DQUNIRUQsIFRUTV9QTF9G
TEFHX1VOQ0FDSEVELAo+PiAtCQkJCSAgZmFsc2UsIHNpemUgPj4gUEFHRV9TSElGVCk7Cj4+ICsJ
CQkJICBmYWxzZSwgc2l6ZV9pbl9wYWdlKTsKCldoeSBkb24ndCB3ZSBjYWxsIHRoaXMgInBhZ2Vf
Y291bnQiIG9yICJudW1fcGFnZXMiPwoic2l6ZV9pbl9wYWdlIiBpcyByZWFsbHkgY29uZnVzaW5n
IGFuZCBub3Qgc29tZXRoaW5nIHBlb3BsZQpzYXkgYW5kIHVzZSBpbiBFbmdsaXNoLgoKUmVnYXJk
cywKTHViZW4KCj4+ICAgfQo+PiAgIAo+PiAgIC8qKgo+IAo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9y
ZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q2x1YmVu
LnR1aWtvdiU0MGFtZC5jb20lN0M4NjhjOTIzMmNiOTI0NDQxYzAyMzA4ZDg3NzIzMDdlNCU3QzNk
ZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzczOTAzMzk2NDY0OTA4
MDElN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYy
bHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9SDVy
OUMlMkJqM3pWRXNHU0ROVWx4bDElMkJnN2x5dGNzY3pPN0twU3ltSXYlMkYwRSUzRCZhbXA7cmVz
ZXJ2ZWQ9MAo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
