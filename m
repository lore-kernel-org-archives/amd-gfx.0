Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B82BC2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 14:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38DB2064A
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 14:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZKUXMvFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38DB2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C0076E165;
	Tue, 14 Apr 2020 14:33:34 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760042.outbound.protection.outlook.com [40.107.76.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 411616E165
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 14:33:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkiTeaFkf3kLpZx59W4w1Rd6ZDEZ/d5tIqNIBSa6l9bSLV+I4B0BZH2wuvcIgvXEqDOqW1dWJHI3FGL6Y2DQ4OGJwx8sTNkc32dNeoRNZwSrhJZb7s0nYYEBobQYRFnFIPffHf1GZdiJAu3lxcdXBffI1QLP0IB4l8CsmxoyMWZNfPglS1vuVDD3uCxgJIojvBSODu0Po85ULOMZ+PjDZD4qHvrvzj2u/MwygA5cJjXAnS++A9Wvoaftn58EO0xzKY2vHStJgO9yEKLqK/4/p/Zog48DcyOyj6NithhVDZhib0oNUdiLHZqVNfYCHUctbQfkRK270rceTcCq3gtj4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkLa0bw+hhRAjwi8Z+vaTJpUZNiuymus5mWdPRUePnI=;
 b=lc6n2Jm1noWB4ggb40YWJ+DHWyN7vP2RLvBD098mFss3INKX0JeWJxAlcdQl/sKOJnPOLw7+guEkZ+qNeAwcNZYQkArOFijj6a8a5BW0umMfU54RSW466ebIAP0aBn1V3f6Rs2PRSqZE9S7Y26MPLtuKSyRBYy4PDHjbI+kbMXM5PHoupj6QEFr9lpG8i1KRWfEjsOauRQXy+I9OtrZRzBRPkNBrT3+3TJrZIX9FpkeglJbXQKIXNMnxwnkQdGz2P9U8nPbseGjqwqcaWAuo/tv4bndQIMP8BZKG/AOb+UgXJyPw6Tx3pqE8wEUVfBjEg1Ksa7gcdJyPz9iXX5OFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkLa0bw+hhRAjwi8Z+vaTJpUZNiuymus5mWdPRUePnI=;
 b=ZKUXMvFvQOAFy7xd2fnhBscYYDWXWzfpQLs8P7LxjSDVrr5Iry36mFCKg1vlJZKkrrJ6CDXp5YMT47wsThQtRceruGs4qa2m4q9m7PQFZlNJrKrN3y7+6rFxCcdX5107iKm1zH9arUnxM2wjOwK3DY6pjB7zyHM8H2TPuvDl6e8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Tue, 14 Apr 2020 14:33:32 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::943d:4dcf:f18e:5df]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::943d:4dcf:f18e:5df%2]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 14:33:32 +0000
Subject: Re: [PATCH] drm/scheduler: fix drm_sched_get_cleanup_job
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200414142217.5736-1-kent.russell@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <404ae73e-fb1c-bbcf-5037-4afbc2f66410@amd.com>
Date: Tue, 14 Apr 2020 10:33:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200414142217.5736-1-kent.russell@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::44) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.10] (99.228.232.87) by
 YTOPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Tue, 14 Apr 2020 14:33:31 +0000
X-Originating-IP: [99.228.232.87]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3ea95cc-e48d-4936-d78b-08d7e080ce34
X-MS-TrafficTypeDiagnostic: DM6PR12MB2988:|DM6PR12MB2988:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB298836E4C7C5773BBC696D28EADA0@DM6PR12MB2988.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:283;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(956004)(478600001)(6486002)(2906002)(186003)(31696002)(16526019)(31686004)(316002)(16576012)(36756003)(86362001)(66476007)(66574012)(8676002)(8936002)(81156014)(52116002)(53546011)(4326008)(4744005)(26005)(2616005)(5660300002)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYVeeLPBwbgum6SUmt8jV3kiR2M6NNg6qxPMpdX3b5SUge0HiukUOnsZDSE1JdmfGPD7WXrF9sG1qcv4bcoj+vKY7qDxYbCzQpA0yRwGD3Vy9ZMAbnA+nWM5JwTMo4DbxPsHpXSblsZz9GhFTMKDDO4LjX+zFSgJLo/ZkjeE1kze8xFfybCbUac85pqe3/Qo8yJ3leS9sATwpFpX+xDNcLK2MGjF+0HIGgvW/HTa1ccdTV6bGoX2v8aM+7xAICgKZfEQ/hlmgwkBQZ7P+R2xxKX4wX7orEbDzbGVXVlM+xeFwQYWNwF+pddOAukJbW4WPx1iaWxXu+Ch46XzVOj0NVPriQf52b9v2GeTTHesa/GTvh837Zs608vyRNXNeHvjzlGuoUHnIW7FTzQACEAZZ4xtej51oZyBFXNk78tFEwhvdHZU4P83BimNoxZNbtvK
X-MS-Exchange-AntiSpam-MessageData: YKLBDIJtQE6OCgPSdZ+7qJrhFt+qZG5MOQaSBMfo8H8saUsomeGqcGkO8n7SYdnUYPbctyhz/avYKD95At0LpFB1U7m6w1hqz6ePj1bsi90H+zQ6/625dE4ZBdP3xY8QBnD//VTgSwaeIZuDtny0QQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ea95cc-e48d-4936-d78b-08d7e080ce34
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 14:33:31.9445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNcU2ffJOi0+STQLa83Y78oJHEdwzZBYMhdLeGj0GPrqUPOozsbyvJPhZYdZcKSwRep2ZCf0UR4XQ2WqteeWPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29t
PgoKQW5kcmV5CgpPbiA0LzE0LzIwIDEwOjIyIEFNLCBLZW50IFJ1c3NlbGwgd3JvdGU6Cj4gRnJv
bTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Cj4gV2UgYXJl
IHJhY2luZyB0byBpbml0aWFsaXplIHNjaGVkLT50aHJlYWQgaGVyZSwganVzdCBhbHdheXMgY2hl
Y2sgdGhlCj4gY3VycmVudCB0aHJlYWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS29l
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gUmV2aWV3ZWQtYnk6IEtlbnQgUnVzc2Vs
bCA8a2VudC5ydXNzZWxsQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1
bGVyL3NjaGVkX21haW4uYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVs
ZXIvc2NoZWRfbWFpbi5jIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMK
PiBpbmRleCA4ZTczMWVkMGQ5ZDkuLjJmMzE5MTAyYWU5ZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9z
Y2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4gQEAgLTY3Niw3ICs2NzYsNyBAQCBkcm1fc2NoZWRfZ2V0
X2NsZWFudXBfam9iKHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQpCj4gICAJICovCj4g
ICAJaWYgKChzY2hlZC0+dGltZW91dCAhPSBNQVhfU0NIRURVTEVfVElNRU9VVCAmJgo+ICAgCSAg
ICAhY2FuY2VsX2RlbGF5ZWRfd29yaygmc2NoZWQtPndvcmtfdGRyKSkgfHwKPiAtCSAgICBfX2t0
aHJlYWRfc2hvdWxkX3Bhcmsoc2NoZWQtPnRocmVhZCkpCj4gKwkgICAga3RocmVhZF9zaG91bGRf
cGFyaygpKQo+ICAgCQlyZXR1cm4gTlVMTDsKPiAgIAo+ICAgCXNwaW5fbG9jaygmc2NoZWQtPmpv
Yl9saXN0X2xvY2spOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
