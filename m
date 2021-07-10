Return-Path: <SRS0=7Jcp=MC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E426C07E99
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Jul 2021 00:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560A8613C5
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Jul 2021 00:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560A8613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD5D6EAAA;
	Sat, 10 Jul 2021 00:45:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69EDC6EAAA
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Jul 2021 00:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agY27Nydv9iGxo9KV6Ik14Mcjo38mGTWrV7r6FV9BLvT7rm0QiVeda83UvoJhiZC1DRp8Xme/EOMq35thquqQrBSmvpCYBtkOyLFZ0wspbYMC405KF9zmpJHdJYH14gRxdXKwOmZlNMPsAWQNugdyOkglmspe2eiY0lMhiFBIO9OL7q9HNfL6Bxvf82h9VGQLxXEjAw9s6hOjS2XxVJdxe0fBxDKdRBbn1Dy+F/XE6HjaPo9gaSjAAUU2Ah9QnnCIdiCiU55qU1Yqj58AYPRzF8D6IimU/ALpy/hwikeKNS0syhJr3/6LG5nMbYtHBI6DhW/u8aUG/3pQCPNMPOeSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQiq1fe1mCeWQx3va89n/LL0qNwKUJBIr9gyjGFqZVY=;
 b=cmoizd8Sx2XAAoXBV+OzLok6bz0O7OCVdQslHTjKQVcCwS0X0bwdzUCMYKmXkAjfSNeOTARv2YbhH9DGObthbBMsJ2lvl3el+u6cojCY052eOZBkpQByxNO47ch7TWzhUeWfrX0td7QB9qri4jH4UVakR7euVEUe3R/TA/qvDbZm9oj51y1OHldtMUsYVas6osqX5d75+R97JQy+Tg9ZCre3rn36442W5eK1TWjVtjBfq025tURGHaE7S/US2qBGrHry6NLcU7hgRmDDfJgreSuh+zQUax8lAFYjmmb+7G0VnKU6mPMXKe17Rm5ftm45wPH8w4neo/ANVCO727LEnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQiq1fe1mCeWQx3va89n/LL0qNwKUJBIr9gyjGFqZVY=;
 b=adbCskm4HWRbWoIO/xmjoXDXTXroeaKaqWBRhiZjTuiwHOBXVdt3D85iVxueXnrapnlBoM0B7XCJocfeuX/CudEDjBCyvXWEqpu6mOBi3e+PtuZfICah5/xNTjXKzjCzw/HRHf//ebNJ948ldjx7y8mqEMtMK6aZrZ8ZnKRQw70=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Sat, 10 Jul
 2021 00:45:23 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4308.023; Sat, 10 Jul 2021
 00:45:23 +0000
Subject: Re: [PATCH 3/4] drm/amdkfd: report pcie bandwidth as number of lanes
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210621192348.2775943-1-jonathan.kim@amd.com>
 <20210621192348.2775943-3-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <575b4dbf-95fd-5544-f6dd-2738038756e0@amd.com>
Date: Fri, 9 Jul 2021 20:45:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210621192348.2775943-3-jonathan.kim@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::42) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20 via Frontend Transport; Sat, 10 Jul 2021 00:45:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bfc19c3-4f67-4e74-d227-08d9433c0017
X-MS-TrafficTypeDiagnostic: BN9PR12MB5211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5211A1F3416C28C58FA102A592179@BN9PR12MB5211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /vVsXf3ffuIyacZIl20Iz0ftu++uZ5lzb/NiXzxg+duHvFXbzH1cTkUDpnC9w/KmXbxIb0WAvLOG82fGrpt61d/zJjn2Um2kBz/BKpiNjncOi+0Xxw7QvUhHOi9xvZmPeC333AQkY4gCdiZS7o1xLeAPleBlqdrbk/Gt+5YxibF1NLQxiAB45RmN407Uoli4cAWQUwjJiEql6dy3AcltbOMzUq99RQZ6KPomYi7P0W5TNr7HMAzrmQvs8H3kVt/cBRiVPxqhpDwpriv3Oe3mbvkK0TVJQKcnI+TgUBkwstEMGDP64v/wocWgS6jw/RJaOJBm3+bo3xYPnsPBu5bCg4axqvWcMrLnel8++fY6oJrg8mHNNfiwQyWRZBHrlZqXMt+nTcv/N7Ap8x+7ec4zEKqL3zLUdtZ4ze2ZN6HQbYu66AFchpSlMGfp0xDVyjuUwRtaoRSS7pXVB5ipkaXjjJ2hpmYAQLSv4tsYP1eW/zhrenSmHx+JL0qA3SUOKLYYantdnmi/1TOXsrpKVhlHD2iJH5IAumFLTYyD4WHW3NgK6DfuJwORVEgfA20FGRr6lqsOX1tqTjN7Usfmrr59+EC/tsyvD6Rjl00pD4xASHoreOmxbHRMPa2UuG50DLAK9yh0bv/ObS5k/LXYXjRDF+Zh+fO1+7/8NXSqTYRllnMznpjLCMqPX9J8iPOpPx8pSproHYxJH9RATQEQV3nUqlujmy+rCS91/LDvA5E9EOzs4ETO3nXwrq085xUVIeh2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(16576012)(478600001)(66556008)(956004)(66946007)(2906002)(44832011)(2616005)(31686004)(53546011)(36916002)(26005)(66476007)(316002)(83380400001)(38100700002)(186003)(31696002)(5660300002)(4326008)(6486002)(86362001)(36756003)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UC83Slk5dXVCYWpMN3M0ZitRMzlTb2JNd2p2Qi92LzRIcGsxSk1mWVlvcEpB?=
 =?utf-8?B?S0hQTWhmdnRBZnlwWkJVdHg0d2l3RTN5TWFvQzFoRXhlS3Y5WG9raHJRUWRl?=
 =?utf-8?B?OHB6cWVGRFJMdGljNzkwcml2Um1iVXhzcTRvK2hOR1V2UDVELzVndlhJdXpO?=
 =?utf-8?B?K09RYlJDRGVjS0dqZkVQZGlsbnJRQXhPOWQ3ZktlZ0M1TnFadlhaQVFWWFJF?=
 =?utf-8?B?YS93OTdDbXV0OG13Z0JXQmUxTGU4N3M4VUtkdEFVSTV3VjE5LzdPSnIwVDFS?=
 =?utf-8?B?V2xDWFhDWUJ0NkR4VlBaWktFYkFBczZGa1M1K213RnFvKytHV1ZpblBONnJS?=
 =?utf-8?B?SkVCWjR4bEp2ZXBYTEtBaFJPS3FnbmpLQy9VQ3h4R2dSOGlaL0d1aXE3YVkv?=
 =?utf-8?B?QkdIL0FBa0YxUE5NTTI3UWd6ZGlscVJKcWRRWW10QUYrajFwOWpPM3FBQTRH?=
 =?utf-8?B?a25KcEdqaXQyaXRLeTRaK2VXdVlOemw0RWZDM0diNmVUN0YwbGZDK0VzbDU0?=
 =?utf-8?B?RE0vejRpd0doNGVRUFpIdnFuR09ORWVqenlFYlNUUXZNOEFaK28rL1NvVTlk?=
 =?utf-8?B?aldiR0JxRG1pdTNlL1ZWK295NWRqQjJTdFlRdEIwRW5OdlNnTXlPeEtQeFBk?=
 =?utf-8?B?SzVaM0RDYWgydmpCYWhMZ29OYThiWU0zVlF2RE9xdHd3ZG84TWZQM3FScTlL?=
 =?utf-8?B?WFNEZklkTlJibXk5M2o3ZDJuYzh6bmxzUjBqRWJ4STA3MXR6alljQ1pVQ0lD?=
 =?utf-8?B?UUJmUno1YlRiRDZDa3B6cFFYUGZFRUtsUVBBUXNJbmNUUFVuditKVGMrQTEv?=
 =?utf-8?B?QmxBZWg0QVVYcmgzT3ZGTU00YUxRVklFUXpDamprYzV2YmhpUjNhZEplQnRq?=
 =?utf-8?B?bUIwUHFtVFFtRkxUWEIwK2pIYzdHODdXQlBqb0hIcVMvRkhXN0I0QllDMFNU?=
 =?utf-8?B?OGhtK2RBZCtjeVVNVTBSZUxtZHVET3A0amwwclpQWEdVelpUMDFMRkpPck9h?=
 =?utf-8?B?TVl0a1ZyNldTaWNnSHlnZnQ5RGVwdlNxUkhMTkEvSVRFTmxhVGsxeGpjL041?=
 =?utf-8?B?OWxJNk5iRUx0ZHp6QlhCM0xZWStrazNYVGZrbkoyTzhseDNvMWRZOGZXWVNn?=
 =?utf-8?B?UFV5WXQ3OGozZjMrQnVIb3E4dlp3RHNMYUZFRExrYUdwa3ovZXJET3Z6K1dK?=
 =?utf-8?B?V2NRRXVNbExCY2ZqUU1HYXNvQVFEWmtlcW9sRCszL3RtcmZEWmpTR1Bta09j?=
 =?utf-8?B?Zmt4YTVSRmtQUkZXYjF2K2hnUGJ0NjZRVTZZRG9ERUdVZmhkMHg1ajRjRTJ5?=
 =?utf-8?B?R2J5Qmo1WWdqRnVMeGFOejBscmxFdGZZaUJtQ3V5Qi9sOUNoMlBnaXRBVk9R?=
 =?utf-8?B?cEVGcDlkeDk1cnJpWlZaNktpQkFGQS9IMjY3N2ptek5PSXFuSDQydGlIcExw?=
 =?utf-8?B?WVRBRkI1TVluRWh4U0ZjRk5HYXlCZ1RGZitOUFI1alMzMDc1M1AyTkZMN2hC?=
 =?utf-8?B?ZUYySWxsVXZrM3c5VllBd25zdUVTc1NyM01tQ2NBL21UZW9EeEloYnZCRkht?=
 =?utf-8?B?WmhBYTRkRWRzWjJtMi9QY1REMkoreW9Vc0lOQU84ekZjM3FJbEJtM2NadzNt?=
 =?utf-8?B?TmZ3WWtobXJ6WGV1UGY5cHFyVFl3cm9xbngvcTE5NG9UOHBRSmMxc2dVeUY1?=
 =?utf-8?B?NlBYdGxYcGZ5NDJkVEYzVFVHUWdiU1MxR0lLRUJCYkVZeFBxdXRkTmVGOW93?=
 =?utf-8?Q?fkg7vEpdNbVkU/FUmxTH8k4FjP1jCcaOSnm1xLw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfc19c3-4f67-4e74-d227-08d9433c0017
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2021 00:45:22.9291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDKwvsKlVJn/5MNeoSZzEpNo4hSZiyj6u2/VLW9yLV9bONooR31troWGxOlOJyd6GXnHCOlfFZbti3BRiyVZqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211
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
Cc: Hawking.Zhang@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNi0yMSAzOjIzIHAubS4sIEpvbmF0aGFuIEtpbSB3cm90ZToKPiBTaW1pbGFyIHRv
IHhHTUkgcmVwb3J0aW5nIHRoZSBtaW4vbWF4IGJhbmR3aWR0aCBhcyB0aGUgbnVtYmVyIG9mIGxp
bmtzCj4gYmV0d2VlbiBwZWVycywgUENJZSB3aWxsIHJlcG9ydCB0aGUgbWluL21heCBiYW5kd2lk
dGggYXMgdGhlIG51bWJlciBvZgo+IHN1cHBvcnRlZCBsYW5lcy4KPgo+IFNpZ25lZC1vZmYtYnk6
IEpvbmF0aGFuIEtpbSA8am9uYXRoYW4ua2ltQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgfCAyNCArKysrKysrKysrKysrKysrKysr
KysrCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmggfCAgMyAr
KysKPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMgICAgICB8ICAzICsr
Kwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCj4gaW5kZXggYzg0OTg5ZWRhOGViLi45OWM2
NjJiNzA1MTkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2FtZGtmZC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZC5jCj4gQEAgLTU2OCw2ICs1NjgsMzAgQEAgdWludDhfdCBhbWRncHVfYW1ka2ZkX2dldF94Z21p
X251bV9saW5rcyhzdHJ1Y3Qga2dkX2RldiAqZHN0LCBzdHJ1Y3Qga2dkX2RldiAqc3IKPiAgIAly
ZXR1cm4gICh1aW50OF90KXJldDsKPiAgIH0KPiAgIAo+ICt1aW50MzJfdCBhbWRncHVfYW1ka2Zk
X2dldF9wY2llX21pbl9sYW5lcyhzdHJ1Y3Qga2dkX2RldiAqZGV2KQo+ICt7Cj4gKwlzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWRldjsKPiArCWlu
dCBtaW5fbGFuZV9zaGlmdCA9IGZmcyhhZGV2LT5wbS5wY2llX21sd19tYXNrID4+Cj4gKwkJCQlD
QUlMX1BDSUVfTElOS19XSURUSF9TVVBQT1JUX1NISUZUKSAtIDE7Cj4gKwo+ICsJaWYgKG1pbl9s
YW5lX3NoaWZ0IDwgMCkKPiArCQlyZXR1cm4gMDsKPiArCj4gKwlyZXR1cm4gMVVMIDw8IG1pbl9s
YW5lX3NoaWZ0Owo+ICt9Cj4gKwo+ICt1aW50MzJfdCBhbWRncHVfYW1ka2ZkX2dldF9wY2llX21h
eF9sYW5lcyhzdHJ1Y3Qga2dkX2RldiAqZGV2KQo+ICt7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWRldjsKPiArCWludCBtYXhfbGFuZV9z
aGlmdCA9IGZscyhhZGV2LT5wbS5wY2llX21sd19tYXNrID4+Cj4gKwkJCQlDQUlMX1BDSUVfTElO
S19XSURUSF9TVVBQT1JUX1NISUZUKSAtIDE7Cj4gKwo+ICsJaWYgKG1heF9sYW5lX3NoaWZ0IDwg
MCkKPiArCQlyZXR1cm4gMDsKPiArCj4gKwlyZXR1cm4gMVVMIDw8IG1heF9sYW5lX3NoaWZ0Owo+
ICt9Cj4gKwo+ICAgdWludDY0X3QgYW1kZ3B1X2FtZGtmZF9nZXRfbW1pb19yZW1hcF9waHlzX2Fk
ZHIoc3RydWN0IGtnZF9kZXYgKmtnZCkKPiAgIHsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWtnZDsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCj4gaW5kZXggMjBlNGJmY2U2MmJlLi44ODMyMmM3MmE0
M2QgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZC5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCj4g
QEAgLTMxLDYgKzMxLDcgQEAKPiAgICNpbmNsdWRlIDxsaW51eC93b3JrcXVldWUuaD4KPiAgICNp
bmNsdWRlIDxrZ2Rfa2ZkX2ludGVyZmFjZS5oPgo+ICAgI2luY2x1ZGUgPGRybS90dG0vdHRtX2V4
ZWNidWZfdXRpbC5oPgo+ICsjaW5jbHVkZSAiYW1kX3BjaWUuaCIKPiAgICNpbmNsdWRlICJhbWRn
cHVfc3luYy5oIgo+ICAgI2luY2x1ZGUgImFtZGdwdV92bS5oIgo+ICAgCj4gQEAgLTIyNyw2ICsy
MjgsOCBAQCB1aW50MzJfdCBhbWRncHVfYW1ka2ZkX2dldF9hc2ljX3Jldl9pZChzdHJ1Y3Qga2dk
X2RldiAqa2dkKTsKPiAgIGludCBhbWRncHVfYW1ka2ZkX2dldF9ub3JldHJ5KHN0cnVjdCBrZ2Rf
ZGV2ICprZ2QpOwo+ICAgdWludDhfdCBhbWRncHVfYW1ka2ZkX2dldF94Z21pX2hvcHNfY291bnQo
c3RydWN0IGtnZF9kZXYgKmRzdCwgc3RydWN0IGtnZF9kZXYgKnNyYyk7Cj4gICB1aW50OF90IGFt
ZGdwdV9hbWRrZmRfZ2V0X3hnbWlfbnVtX2xpbmtzKHN0cnVjdCBrZ2RfZGV2ICpkc3QsIHN0cnVj
dCBrZ2RfZGV2ICpzcmMpOwo+ICt1aW50MzJfdCBhbWRncHVfYW1ka2ZkX2dldF9wY2llX21pbl9s
YW5lcyhzdHJ1Y3Qga2dkX2RldiAqZGV2KTsKPiArdWludDMyX3QgYW1kZ3B1X2FtZGtmZF9nZXRf
cGNpZV9tYXhfbGFuZXMoc3RydWN0IGtnZF9kZXYgKmRldik7Cj4gICAKPiAgIC8qIFJlYWQgdXNl
ciB3cHRyIGZyb20gYSBzcGVjaWZpZWQgdXNlciBhZGRyZXNzIHNwYWNlIHdpdGggcGFnZSBmYXVs
dAo+ICAgICogZGlzYWJsZWQuIFRoZSBtZW1vcnkgbXVzdCBiZSBwaW5uZWQgYW5kIG1hcHBlZCB0
byB0aGUgaGFyZHdhcmUgd2hlbgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfY3JhdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYwo+
IGluZGV4IDc1MDQ3Yjc3NjQ5Yi4uZjcwZDY5MDM1ZmU3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfY3JhdC5jCj4gQEAgLTEwMzYsNiArMTAzNiw3IEBAIHN0YXRpYyBpbnQga2Zk
X3BhcnNlX3N1YnR5cGVfaW9saW5rKHN0cnVjdCBjcmF0X3N1YnR5cGVfaW9saW5rICppb2xpbmss
Cj4gICAJCQlwcm9wcy0+bWF4X2xhdGVuY3kgPSBpb2xpbmstPm1heGltdW1fbGF0ZW5jeTsKPiAg
IAkJCXByb3BzLT5taW5fYmFuZHdpZHRoID0gaW9saW5rLT5taW5pbXVtX2JhbmR3aWR0aDsKPiAg
IAkJCXByb3BzLT5tYXhfYmFuZHdpZHRoID0gaW9saW5rLT5tYXhpbXVtX2JhbmR3aWR0aDsKPiAr
Cj4gICAJCQlwcm9wcy0+cmVjX3RyYW5zZmVyX3NpemUgPQo+ICAgCQkJCQlpb2xpbmstPnJlY29t
bWVuZGVkX3RyYW5zZmVyX3NpemU7Cj4gICAKPiBAQCAtMTk5Myw2ICsxOTk0LDggQEAgc3RhdGlj
IGludCBrZmRfZmlsbF9ncHVfZGlyZWN0X2lvX2xpbmtfdG9fY3B1KGludCAqYXZhaWxfc2l6ZSwK
PiAgIAkJc3ViX3R5cGVfaGRyLT5tYXhpbXVtX2JhbmR3aWR0aCA9IDE7Cj4gICAJfSBlbHNlIHsK
PiAgIAkJc3ViX3R5cGVfaGRyLT5pb19pbnRlcmZhY2VfdHlwZSA9IENSQVRfSU9MSU5LX1RZUEVf
UENJRVhQUkVTUzsKPiArCQlzdWJfdHlwZV9oZHItPm1pbmltdW1fYmFuZHdpZHRoID0gYW1kZ3B1
X2FtZGtmZF9nZXRfcGNpZV9taW5fbGFuZXMoa2Rldi0+a2dkKTsKPiArCQlzdWJfdHlwZV9oZHIt
Pm1heGltdW1fYmFuZHdpZHRoID0gYW1kZ3B1X2FtZGtmZF9nZXRfcGNpZV9tYXhfbGFuZXMoa2Rl
di0+a2dkKTsKClNpbWlsYXIgdG8gWEdNSSwgSSBkaWQgbm90IG1lYW4gdG8gZGlyZWN0bHkgcmVw
b3J0IHRoZSBudW1iZXIgb2YgbGFuZXMgCmhlcmUuIEluc3RlYWQsIHVzZWQgaXQgdG8gY2FsY3Vs
YXRlIHRoZSBhY3R1YWwgYmFuZHdpZHRoIGluIE1CL3MuCgpSZWdhcmRzLAogwqAgRmVsaXgKCgo+
ICAgCX0KPiAgIAo+ICAgCXN1Yl90eXBlX2hkci0+cHJveGltaXR5X2RvbWFpbl9mcm9tID0gcHJv
eGltaXR5X2RvbWFpbjsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
