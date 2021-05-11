Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C96BC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 14:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF354613C1
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 14:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF354613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40A6F6E5CF;
	Tue, 11 May 2021 14:52:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 302326E5CF;
 Tue, 11 May 2021 14:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXgK7TeVCGzCo0T8a3YGAl5y677BijffAIjV+WBJ8NmQzv9zSa2kNzEhakHJc58/pJf8PiGttU2OuLxEaCb5xKLGThXd1t0AIRBn33pk1v8/14r4SHT3qSyMnI02tngzEp9so6zZwKFKnoHcxf3MQkDvDMeOw2sfO7P5LraV+exkqLwYd7GKjDfuaMR8N9XDstvK6USVaXEwK+OpYk517uRVllhCEojerrEedBS+KmNRnE0s1UA+rxMYtmQ6VrzhRoUvuuxXnANBObnRcCl+VZPD52rNYQI3O0blAOFOLjvccPpaCwAV74ABjYExFim3dZ+rUbJLLhuNCnfI9BBcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6aneeaHTVTvXAydXphYgKKOEtqIpSUmu5ae+sbnIJc=;
 b=Bhok0rkswEJJTrNk8RHwJwTJ+Oze3VwslM3gPl//puvLoy4q01N+XpvKc78aI4CpRDtQI5r97nRN0iTkYyr9xQ0ll21jwuwDm6Xk1XzN3JZ8pbjZwcrfD12rEMroIk00xHKEWdrUkJtd8JkUaivFPAktaC3O20YZawXW3/HDmctOlsbsSBKE7IQxRxjPEX3qq8eEY+GvheUeJJymyfrC7txtapsggluz7lyIh+d8EmpruK0l/DW0692YeZlS4OLJyUCJ9gwMZXrwl5NwivplwTQcdrCFIiOSRHyzxz5p+I0eekpkAsEJ9tlRla6YRXjvf8xfFewg+rLOW0olSUr4Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6aneeaHTVTvXAydXphYgKKOEtqIpSUmu5ae+sbnIJc=;
 b=X6EXm721Qy9Fcrr6XqFmt5lOa7ILSx1mZVmx5D4VIu+yZbVvQ7j0jBqMvw3EYWi7ZR2nsUF+2h3UgMZneLe9PCtBaNYxYYuz0bzEVjqPdClqXiK0K9lSaaWnfuKa0ZADI5hVqX/AcxZiTj0CjEp4wbzGw2Q/J1S0T0r6tViWMQE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2703.namprd12.prod.outlook.com (2603:10b6:805:75::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Tue, 11 May
 2021 14:52:47 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 14:52:47 +0000
Subject: Re: [PATCH v6 04/16] drm/amdkfd: Split kfd suspend from devie exit
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210510163625.407105-1-andrey.grodzovsky@amd.com>
 <20210510163625.407105-5-andrey.grodzovsky@amd.com>
 <8805dbc5-a607-a36a-d069-6c7c8b72a6b3@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <3fcc8a49-8e7a-40ad-81fe-e37426008cd0@amd.com>
Date: Tue, 11 May 2021 10:52:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <8805dbc5-a607-a36a-d069-6c7c8b72a6b3@gmail.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:6a5:47b8:e610:f6a3]
X-ClientProxiedBy: YTXPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::28) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:6a5:47b8:e610:f6a3]
 (2607:fea8:3edf:49b0:6a5:47b8:e610:f6a3) by
 YTXPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Tue, 11 May 2021 14:52:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33fc0c14-64a1-4b06-dd80-08d9148c70ea
X-MS-TrafficTypeDiagnostic: SN6PR12MB2703:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2703D89C22AC92D97DDA1836EA539@SN6PR12MB2703.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEqkXmnow5pZbDKPqp63MJAETyRkHOwgwqvzF7pX0sYQHm28yInRcG0hxRyCmxx8XBcyzz1NExWicVIRYbiXLx3WCpIybCfXDfRTtbr09COfy6nU/O+UDLNp3/1a/zStvz2rJwIeQWJI3MSLfjR9k+UNcoIsoJI0bqra8dlDVbMKidrxMfC2kaKrzKHdj6TtQnCtfPyC078I+l7oYRkrTZOauGEWVTAMM72aVDeXKAYvRwiZJCOur/CXrTbhgD/metj4z4pW+00XHuEtsyZfssn3AO120uqhNEUbTFkICeyvUq2+ZfYRKda5ZrejeSpcItEHyPHWX/Zyucm4tZLQgq/Oo+aRM8ppTE6YyJu1noZMPltACnbshgy8VuKF4skTch96hj5Tn7dJQkSKJ8WzwKHt3PU7XyPB0ATCNWk1h6WfMY8nODnwZTIyDOVtJAZVxiPFTXJWggiQOSmve33+zBWcBtD5bbLs2e1DK57gLZfBCkCFxKiqPjv/qG9LZZLRVS9VE49aaM7E6ChKjmcnSSFgtvKbLkNjyrPJKPpiC7TOcwg7VAYi2qShhTP7GPjaGE/VsmiBg59i66zmRG4syZRXW8VWfVwolIhFZLEOYjsXD/G/QFC8RYfMcOMaSLn6WfUgQMFI1lmJEWjxoDxBXNmb2nUI4xzyk/TrN4JTS9oTnmA1oRS1rsWoEZ2mZO4+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(2906002)(5660300002)(31686004)(36756003)(83380400001)(66574015)(16526019)(6636002)(478600001)(6486002)(4326008)(38100700002)(66556008)(8936002)(53546011)(31696002)(66946007)(52116002)(2616005)(8676002)(44832011)(86362001)(66476007)(316002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bEVCMjJsNDJXcjNOZTJwUUtwVk5nby9SOTdKeEw3RC9HdWZlMHdpcXFjaUh4?=
 =?utf-8?B?Y0ROWUsxZ3NGOHV4eEV2SWsyd3g4bGQyWG55cmpaLzYrKy9MVHU0OGZveU11?=
 =?utf-8?B?VUc0ZWJsdGZGSmY0SEh3c2RPYnNzbWNJeWRhQ3VwNXdzTFE2N1p4NnRDM0FP?=
 =?utf-8?B?bTlpOW10Y09PSE1lUGYrUXp0aGpWYlVhZGY1R2R4dVBuRTF6bjNYRjhYSElp?=
 =?utf-8?B?a2V0aVQxSEl4SmdURjNtUUU0TWZwd2FQbEVkR1llN0tRNTF5eGxMRXkxdXpu?=
 =?utf-8?B?RUFpNVZxdGVFTDNDTlE3bnd1T0I1d09BR0xWSzZDNzZhbUo0OUJBQjZZZ1NU?=
 =?utf-8?B?QWI1cjU4TVc2elJBdGxKb1ZkOUFxeThaTS9GdGpPbmx6WTdyeXl6NzMzQmtU?=
 =?utf-8?B?blkzbDZlUXlTWWU3cHF1eUN4NmtIU0kwMFJvTC9iTmRrSWJUeUdjditRSHdw?=
 =?utf-8?B?WVJHT1JiTU1yZWJzREVwOUZGdThTb3RiZVRTZi9vWnkrdUE2TVN2NEtRUDVM?=
 =?utf-8?B?eURlbGIwM3MrZ1dlTWIxMURqc21vRjRGcks5aUIwdmxScW9KZHpKYk0xNUxt?=
 =?utf-8?B?MHV5L2pQVk9xYmJqcUI5TDRyaWsycUxkZXJXaTJaWW9meElaOWRCenIwUEJl?=
 =?utf-8?B?emVONmJVK0Ftc1BxcTU5SGE0QnFWMlhMT0FDakk0bjRQRTBiNlJ3bk1tQm1Q?=
 =?utf-8?B?MWhkOHFIZ1lMR1dydXpNRlFaOEF1QjZHMGpKT25pdG5mVkJaaUFHZFN3ZzNs?=
 =?utf-8?B?NUhCNm9tYnR1YVBlVnlGN0hKTytUYkpIMEh1ZzdSZUNjMUFQaytDTm96dTZD?=
 =?utf-8?B?SkkrUDdlRmZUU2dXd1lSRXVDbXhKYVJPUUpTSXNyaVlJYnlBT0dZd25yaXFP?=
 =?utf-8?B?cjJ2bFYxMjUwMFRNREpuRnJEV1A2VEh6QUdzSW1TMDNQRi81SDFHeHQybzFx?=
 =?utf-8?B?Um9IY0JHay9oNTRMMGRVYjBROUFvTWlKM09PaHBZaVN5Um11aXR6VVgrc0tY?=
 =?utf-8?B?RDVUekQvSlZ4TzhCU1hXUmI2c0htdXY2ZUNjd3FmUkZZQXptQ3lTbUd2K0ZL?=
 =?utf-8?B?cFNOV0haM21hM3BsQlR6TWlScUt1L2UwcFZkZm5NeCtZU0cwTkNZYzcvRllm?=
 =?utf-8?B?WGM4Zk43eVh5R243c2VIU0xYbVQ5alZjTWhVYzI1YWhSSndsVlBFdXYyemhl?=
 =?utf-8?B?QS8xNlowQ1dybW94NmY5bjV6UzRqZXpTU2p6eldmYWQ0a1RaRHhXc1hhYTdq?=
 =?utf-8?B?QzVBQ0p3blAyS1c2MjF6S01oQXg4RDNsa3BQZ1AwSkFvMi8wajZMWHZyd3pv?=
 =?utf-8?B?L2J6RDhyZE9IelZCa1AxaHhrQVFMck05N3hNd1ZNY2dXLzlQa2xxWUcxMVlh?=
 =?utf-8?B?NVhSOVNMZkJtWEdGTTRZVDBqZ1dCUEw5MVg4V3A3UHUraWRSczMzYTZxMkN2?=
 =?utf-8?B?Z0diME0vQ1hJTnFmV0dyZWZXc1pjNW1NK2doNE5EdnRkdlZCSmpMY3dyY1hw?=
 =?utf-8?B?VkxDcmZaeFhOL2t3NTYwa3FsdjAxaHpwUUErNHBXbXlNcTg1VTZFL3loT1p5?=
 =?utf-8?B?WHJXc1hZbmlkTGhtcitYWm5ncnVVSEw2TWVGS3RuTHJCZThUTjRhTjZEa3Bl?=
 =?utf-8?B?RlYrUVB3czdDcFVFVTdkV3ZNWUlGOCtSMG1McXovT3dsWU95ME5nOGF4Ym1v?=
 =?utf-8?B?bGtpSXBnYjB6TExXN0hJVkdnNmphdCtPUkx6M1JPM3FvNGlyVi80WU9XWktL?=
 =?utf-8?B?bTdiWld2c0kzVmlIc29kSzJEbjYvc2lTWGxpU2FDb2w5RnNFVHpHQjFsZ29h?=
 =?utf-8?B?VFRKSUxERFQrZHZCbWgzbXFqVHZlRXVOR0xzenlkMWk3eXE2cW5CZ3ViRVlC?=
 =?utf-8?Q?0yZHrACqDx3fr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fc0c14-64a1-4b06-dd80-08d9148c70ea
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 14:52:47.7040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRJIxF2RypkU5wzWk2Uxe4GCOXvF5kDuoPlS72t91fy2/AGZMyeqrLK2LOw3SYC6dSuEhpQT1rKHQvjFGTNRSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2703
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIxLTA1LTExIDI6NDAgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAx
MC4wNS4yMSB1bSAxODozNiBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+PiBIZWxwcyB0byBl
eHBkaXRlIEhXIHJlbGF0ZWQgc3R1ZmYgdG8gYW1kZ3B1X3BjaV9yZW1vdmUKPj4KPj4gU2lnbmVk
LW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+Cj4+
IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgfCAy
ICstCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuaCB8IDIg
Ky0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jwqDCoMKgIHwg
MyArKy0KPj4gwqAgMyBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
YW1ka2ZkLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5j
Cj4+IGluZGV4IDVmNjY5NmEzYzc3OC4uMmIwNmRlZTlhMGNlIDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKPj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCj4+IEBAIC0xNzAsNyArMTcwLDcgQEAg
dm9pZCBhbWRncHVfYW1ka2ZkX2RldmljZV9pbml0KHN0cnVjdCAKPj4gYW1kZ3B1X2RldmljZSAq
YWRldikKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgIH0KPj4gLXZvaWQgYW1kZ3B1X2FtZGtmZF9kZXZp
Y2VfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4gK3ZvaWQgYW1kZ3B1X2FtZGtm
ZF9kZXZpY2VfZmluaV9zdyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4gwqAgewo+PiDC
oMKgwqDCoMKgIGlmIChhZGV2LT5rZmQuZGV2KSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBrZ2Qy
a2ZkX2RldmljZV9leGl0KGFkZXYtPmtmZC5kZXYpOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuaAo+PiBpbmRleCAxNGY2OGMwMjgxMjYuLmY4ZTEwYWY5
OWMyOCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZC5oCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQu
aAo+PiBAQCAtMTI3LDcgKzEyNyw3IEBAIHZvaWQgYW1kZ3B1X2FtZGtmZF9pbnRlcnJ1cHQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgCj4+ICphZGV2LAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjb25zdCB2b2lkICppaF9yaW5nX2VudHJ5KTsKPj4gwqAgdm9pZCBhbWRncHVfYW1ka2ZkX2Rl
dmljZV9wcm9iZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7Cj4+IMKgIHZvaWQgYW1kZ3B1
X2FtZGtmZF9kZXZpY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7Cj4+IC12b2lk
IGFtZGdwdV9hbWRrZmRfZGV2aWNlX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwo+
PiArdm9pZCBhbWRncHVfYW1ka2ZkX2RldmljZV9maW5pX3N3KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KTsKPj4gwqAgaW50IGFtZGdwdV9hbWRrZmRfc3VibWl0X2liKHN0cnVjdCBrZ2RfZGV2
ICprZ2QsIGVudW0gCj4+IGtnZF9lbmdpbmVfdHlwZSBlbmdpbmUsCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3Qgdm1pZCwgdWludDY0X3QgZ3B1X2FkZHIsCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgKmliX2NtZCwgdWlu
dDMyX3QgaWJfbGVuKTsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9kZXZpY2UuYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNl
LmMKPj4gaW5kZXggMzU3YjliZjYyYTFjLi5hYjZkMmE0M2M5YTMgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYwo+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMKPj4gQEAgLTg1OCwxMCArODU4LDExIEBAIGJv
b2wga2dkMmtmZF9kZXZpY2VfaW5pdChzdHJ1Y3Qga2ZkX2RldiAqa2ZkLAo+PiDCoMKgwqDCoMKg
IHJldHVybiBrZmQtPmluaXRfY29tcGxldGU7Cj4+IMKgIH0KPj4gKwo+PiArCj4gCj4gTG9va3Mg
bGlrZSB1bm5lY2Vzc2FyeSB3aGl0ZSBzcGFjZSBjaGFuZ2UgdG8gbWUuCj4gCj4+IMKgIHZvaWQg
a2dkMmtmZF9kZXZpY2VfZXhpdChzdHJ1Y3Qga2ZkX2RldiAqa2ZkKQo+PiDCoCB7Cj4+IMKgwqDC
oMKgwqAgaWYgKGtmZC0+aW5pdF9jb21wbGV0ZSkgewo+PiAtwqDCoMKgwqDCoMKgwqAga2dkMmtm
ZF9zdXNwZW5kKGtmZCwgZmFsc2UpOwo+IAo+IFdoZXJlIGlzIHRoZSBjYWxsIHRvIHRoaXMgZnVu
Y3Rpb24gbm93Pwo+IAo+IENocmlzdGlhbi4KCkluIHBhdGNoICdkcm0vYW1kZ3B1OiBBZGQgZWFy
bHkgZmluaSBjYWxsYmFjaycgaW4KYW1kZ3B1X2RldmljZV9pcF9maW5pX2Vhcmx5LT5hbWRncHVf
YW1ka2ZkX3N1c3BlbmQtPmtnZDJrZmRfc3VzcGVuZAoKQW5kcmV5Cgo+IAo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgZGV2aWNlX3F1ZXVlX21hbmFnZXJfdW5pbml0KGtmZC0+ZHFtKTsKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGtmZF9pbnRlcnJ1cHRfZXhpdChrZmQpOwo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAga2ZkX3RvcG9sb2d5X3JlbW92ZV9kZXZpY2Uoa2ZkKTsKPiAKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
