Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC280C11F68
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 11:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 726116141C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 11:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726116141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1882E6E871;
	Tue, 29 Jun 2021 11:42:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD6BB6E871;
 Tue, 29 Jun 2021 11:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YArEC3mzqRkUYVU1n26RFRRAIosRONcDEf6qGuX2yauqNTkq+vOVnnP+qYIfuNCqOWrcz9ICwPy+CDzhYs+jV2v8nYZNtg2AENc/ZPApszuTy39DRBjDyLwYSmrqUGRJ7jiS9KkmGhg13n8qXx4hoapRZOYnfMNrwGMjdypMEZBcsAJ28ykcmBz+l85wWpPNPhiL4vyVfP2bGE+K+AzwYoCqeiWCbMeKuf0rZvoRWCuRdzyQFj+yk6NppKmqcrj8puA/tTIuHQoAH1c+rloN6pp0UQ87VChMFew2ixYjuHXOqoMIUn30KaSgO2OPhx1MxkmbwK2HGSdOXKZwTxkvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqgZSA0Jrn+SPQHyzn9GggvqSFHRmT+drsX5H12djBM=;
 b=QwB1Rpi+2gUWCRB4s7LPST/CM62+J77BqSARxFQdKKm+YFPBkDMz3QuOs2Y2PzwssXuM9HEPWBwfPZuA6qsETzDYBS072++ciiSU+uAWQyOhCeIE54SbGGaoqzoMMxfFUORgtFfIGMOqDAgrAykCoJyCKUVIiljzfHhib+l1BFR4A1WOBQaLTcurew4WBe9kWCNwdKnS2Di5Gk1zN/617XNjURQNP56GElXEP22OYdFIeBOJOw0N0zXx+G0q2wRq33ORbrfOP1gtgRiALrEtJA2dLT2byAtsR/m2dat7H5a9yHf/ryftBVNsLfWmq9JqG2SetDVPEmqqhkifH9bgDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqgZSA0Jrn+SPQHyzn9GggvqSFHRmT+drsX5H12djBM=;
 b=a4boC5y6IGRIOdDcaz0qZs7hGmWcUwqJi0eCz2KQLgxvG6UFZwx2mEOX7BuMdx139eAXthmdQt/G5bdLe5RYUlSGOUxnYk3Ny1NnVFdmcs37b0pDhpMAb2cxZh8o3KMgVq4eR5MB3N/3AFAb2lUG3g5Nn4V5gTFLKk5hROYuExM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 11:42:24 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 11:42:24 +0000
Subject: Re: [PATCH -next] drm/radeon: Add the missed drm_gem_object_put() in
 radeon_user_framebuffer_create()
To: Jing Xiangfeng <jingxiangfeng@huawei.com>, alexander.deucher@amd.com,
 airlied@linux.ie, daniel@ffwll.ch
References: <20210629114455.12963-1-jingxiangfeng@huawei.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5ff91e15-6014-bc72-40ca-3fa8b834f692@amd.com>
Date: Tue, 29 Jun 2021 13:42:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210629114455.12963-1-jingxiangfeng@huawei.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:acb7:5516:6a55:2bf5]
X-ClientProxiedBy: PR0P264CA0142.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::34) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:acb7:5516:6a55:2bf5]
 (2a02:908:1252:fb60:acb7:5516:6a55:2bf5) by
 PR0P264CA0142.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1a::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 11:42:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc92c463-8598-4194-cbd2-08d93af2f64e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3774:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB377482601007A1CA8F42B76B83029@MN2PR12MB3774.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T05zHbcNcoIFGNvwW0y9z6qxupxVDFXNnRi5/aS1QHAcNcOpENvx8f59I1SjggPrYqk7LRMQv/aPHkSebPwh6PYhKgbj0YKdD3KgeS6ljSmsQXjalwYUnuwSLC+ilHEho6jEDcZt/sO7jNpUArt+eX4iybAKvvfnLgUyTwCAVdtyUDa6L6TLlLgkIjXDf3XgTN4Eqt2Nn7DEcS1Prys/aYAmUPNt+ZqfPA/c0ZnkDzKBqXGXJDIhH+skw8902tiDMTIzU26dLLTuSVeDqLvNIJYIquUPPpEPpk17rh7IAygZLu3n+IrkrhdjHce9d8qrBhQf8sJdhj5suoarGjha4sX7ty1OmpfkmM5VpTHjUSWDW9YdkO3Vv4Zd3+Tm5YsYC0XBJipCE37ToxM26r7UKxk+dwXnX3TvA9KYaImnrWOCr6lWyHDXWbOXYakQPj/Fg2XQG10SMz9uXMkYprdvTxwansxDYF6xNq8dIhHiiWQaiaglPgUfiPldnaJv2CWbUVjNkw6T6c2HeAu3TXgvlWTeGL4rodRSBbF7jw44e1/oVGCCbwguNgARgasAVKHgsXqxpaEfXWjAtFr/mn9drKYefTDXiY9AZBC4C6M0IJxRoZrN+XqtxoC/EymEyZU8H/OWaOEAzTJSZCo8SJJN5EeFuSf39sDbPbXAihEpcT4X4DezWvw+BEWhh5c5A30q6z0ru5it6qFrkCCYfScexa/K2U5LBeHGQE4czoZphcSHzs9GZg2MZA6cx4ev8OjC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(4326008)(6486002)(38100700002)(8676002)(316002)(36756003)(8936002)(31696002)(478600001)(31686004)(2616005)(66946007)(66476007)(6666004)(186003)(16526019)(66556008)(86362001)(2906002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1FDc2FHbWFybUNoRnErSDBrY24vYUlBRHkydlUwNDBja0pXd2NUQ2tXdmR0?=
 =?utf-8?B?enlWVHFkby8zMXlxWXJtOG1wZFE5RE16djd2T3lHdWc3VUZZcUFxMmxHSGYr?=
 =?utf-8?B?S3FlakcwKzFiSTVNb1BkSlhtRFd5eEUzYWlubW9waEJIK1I1K0MvOENOVDFV?=
 =?utf-8?B?a1IvQ20wdGlBVlIzVmlMQWxnVlk2WWM3Vm9JMi93VHlrNmtaM1pwajZIQ3pF?=
 =?utf-8?B?SWcrbGJkQjgwelB6NkQ0ZTVtL0szQXdzSjF4OFU0eWJKa2Jsd1pxZE1MSGI5?=
 =?utf-8?B?Mm5WL1BvN2R2OUtGMkMrVmNsSnYvbm9uOVplcU9lV0hmTmpvWklLOVQrK250?=
 =?utf-8?B?UmNFZ0VQWHIzcE50SWFJWTdUWm11NlJSMnNKT0xUWUVGZG5PZDFIQXp1d1VM?=
 =?utf-8?B?MFY2ZFAyNi9jQkoxVHNLMUZEZDVaR1Qyb0NPejVNeGx1aHZiK3BVd0d1aHZ4?=
 =?utf-8?B?Y2kybjZJdmRkS1FKOG5LV1RvQ3BFY2tCd0hTSlBUSHIrUVdOUUpuaHp1a3lR?=
 =?utf-8?B?VUhSb0pRV1lpbzI5TDhPNzZSZkNSekNrS2NLeWozdEw5VXliMW13SGtDQjIv?=
 =?utf-8?B?dmVOWkEveW8xeEVFNFAzeFpFOE1CeVZJU1N5dXpybGJFUkVuM0hBRTAzU3l2?=
 =?utf-8?B?MllMMlV5S1JsMEFNRER6eWFsUDYwRVJ1eW1aQ2NkcFR0UlRTbjhHM0xpNUR0?=
 =?utf-8?B?K1h1TzdVMUI4SlNId3lPL0doR2ZHYkszdlVFVi9tRUVhRWRGZjRrMCtML2Vo?=
 =?utf-8?B?VCtMdkxYTG00UkJENWFxbWlMaHdYdnJCcG9PVk5sd2duUW1HbktnRmJkN1hB?=
 =?utf-8?B?dnRBS2h4UnBxeUpMV3lvMFJ0a1YwVjN1V2lFUTFhdTVEZUdhSlVJT2NPSkxm?=
 =?utf-8?B?MXI1MU84cmh3RWhqUDA5SlhqRzdhQmxvNXBPeWpobGxLenkyblUyc2thTlBa?=
 =?utf-8?B?NmJETUVTNlA5dk9VWE5nWTQwUGFXSlFXeFZwMGJKYjAzZ2NsWGN0RFlqdmVp?=
 =?utf-8?B?NEFKUnpNRzY0VTRhajd5d1dZdXozOGg5bUc3NmMvNGw3emdYZStDMFR2Qnow?=
 =?utf-8?B?VG1OL1BPbS9BTE81cGRTMWkyTlJUVDlSWURPSEh6MGc2YlhuOUtkWk9wMUdn?=
 =?utf-8?B?emJPcHdVUDdJZmxJS0dHWTB5VHExSkN0aVpNd2o1S1FhMWtCZWZtc0FvYWw4?=
 =?utf-8?B?MTVTZVY3Z1pjb2NrTjhiTktYNTF0bzcyTVJTRTdOMm5kM1FOTUpOL3VvMjdu?=
 =?utf-8?B?QlFPWmFPVnRtSnhjQjA2MXErUTlTQlllRThnclJDT0QwZFozMDY1b2EyODFR?=
 =?utf-8?B?Z05lcENSTEpDRnpZRkFYR3pkWk5QTng5NDhuZnJHT1VXdmpTK210Qm50QXNW?=
 =?utf-8?B?dWtONmdFRm9ydW9iQlFaQk4zTktYM2R0RmVGOENaMEFHNjlIU3NibUM5ZVRo?=
 =?utf-8?B?UzRyRnFrK3J5eEZqVW9TSDBWSHJjVDIvaW00d0hKSWptUS9aM2FpUWNOUWNE?=
 =?utf-8?B?SmNsdld1ejM1RndJamE3VmF3UHNMWXRUZGZRdlo5LzV3b1lwenVJYUhteVVs?=
 =?utf-8?B?cTdRUVlNTUZ0MzFURmJpM2NnU0FVbmRFVTR0eTRmeFl4UUUwelIveGdwVDNj?=
 =?utf-8?B?UzUrd2hycU5PeVl4dlpyWmxRZlIzOGpjeElOYWVyS1ZzdUhBb3dXUGp5ZWV6?=
 =?utf-8?B?dXl1RDg1KzdoWk8vNmQvSlJDdzBwaGJROEd4L05jdCtUM1hhK2hVSi80b0ZL?=
 =?utf-8?B?TEY5T3VtaFZaak5BbFhaRHVSaWpWcXRsYzEzRTJYaUpPQXE2Si8zbTQrZVVE?=
 =?utf-8?B?Qkx5MjY3anZlcm10cDJUOU9FRWl1TzFhLzJsTiszOWpOSUhoaE9Wd24rZWNj?=
 =?utf-8?Q?l1WnkFwuSKkwy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc92c463-8598-4194-cbd2-08d93af2f64e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 11:42:24.0590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVX7S/t3ew0+oJEUmo3QLk0QyQ762zVqF7dGhu84tb+pfWVTDMwSUzegpgSa+knI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3774
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjkuMDYuMjEgdW0gMTM6NDQgc2NocmllYiBKaW5nIFhpYW5nZmVuZzoKPiByYWRlb25fdXNl
cl9mcmFtZWJ1ZmZlcl9jcmVhdGUoKSBtaXNzZXMgdG8gY2FsbCBkcm1fZ2VtX29iamVjdF9wdXQo
KSBpbgo+IGFuIGVycm9yIHBhdGguIEFkZCB0aGUgbWlzc2VkIGZ1bmN0aW9uIGNhbGwgdG8gZml4
IGl0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogSmluZyBYaWFuZ2ZlbmcgPGppbmd4aWFuZ2ZlbmdAaHVh
d2VpLmNvbT4KCkknbSBwcmV0dHkgc3VyZSB0aGF0IEkgYWxyZWFkeSByZXZpZXdlZCB0aGUgc2Ft
ZSBwYXRjaCBhIGZldyB3ZWVrcyBhZ28sIApidXQgaXQgbG9va3MgbGlrZSBpdCBuZXZlciB3ZW50
IHVwc3RyZWFtLgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KCk1heWJlIGFkZCBDQzogc3RhYmxlIGFzIHdlbGw/CgpSZWdhcmRzLApDaHJp
c3RpYW4uCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5j
IHwgMSArCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMgYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMKPiBpbmRleCA2NTJhZjdhMTM0YmQuLjFkMDNlYzc2
MzYwNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMKPiBAQCAt
MTMyNSw2ICsxMzI1LDcgQEAgcmFkZW9uX3VzZXJfZnJhbWVidWZmZXJfY3JlYXRlKHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYsCj4gICAJLyogSGFuZGxlIGlzIGltcG9ydGVkIGRtYS1idWYsIHNvIGNh
bm5vdCBiZSBtaWdyYXRlZCB0byBWUkFNIGZvciBzY2Fub3V0ICovCj4gICAJaWYgKG9iai0+aW1w
b3J0X2F0dGFjaCkgewo+ICAgCQlEUk1fREVCVUdfS01TKCJDYW5ub3QgY3JlYXRlIGZyYW1lYnVm
ZmVyIGZyb20gaW1wb3J0ZWQgZG1hX2J1ZlxuIik7Cj4gKwkJZHJtX2dlbV9vYmplY3RfcHV0KG9i
aik7Cj4gICAJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOwo+ICAgCX0KPiAgIAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
