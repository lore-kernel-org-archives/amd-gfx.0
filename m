Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89820C11F68
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 04:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CD861D2B
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 04:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CD861D2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99F06E923;
	Wed, 30 Jun 2021 04:06:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 595CD6E923
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 04:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLnXVU63K9JxV8CKxSJKFfVRgyJck16o5yijfkR9MwHnwATWNaOQaS8yfExIuSKMWc3ncjSh5rOwysoWLptHZRtTuFmlOZM8od+9h3xshI+ZdQwsTkFM9CRVchoMY3joUIBXPY9dY5LWokYxyt/yySz7imYXISTYfrsILL2tK4YL+I7OFB7aD23WjHWg+kQ9wzChWemAQAMT0oR3JLxxzTdWCgKaR8DrDk6jjfp+9KZwGwjJ2T3nLjGDmFOmowhGT6QyPGYUyyHzywh8/y+oS0scUP/qPLSEdLvPqX2ivvDSDBLSDxuwLDkxusFX/1VwL2WFKOAHN3V0eZbeh7IRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OaZmoO4c0lsUeZH9tRCitJaCRtgdiS4px2CwntR+KY=;
 b=MXV7TvUc8K2Ol5zxPrViRZCEwirLBEzP5c5zLPW/ksVdwZM7BFBP2BacvY6WekOrujbMTUnJpfYUv1AfXxuimqGAaFznzSO9IJysX8Oz/aiQomiwGsE4D+Uy6SJZejD3A+iKdU0iBoxMR90KIA0rFocJdorUx2HbMb0chIvX+IV0HW7qwYL6cN5oyxvMwsD15R1jT29+jM4KydS0qxV2Fz/Su1vqlbfh+TPzKJ/bA81oV1IV0juwAlx5+tFuh2A7TlCaBG0cWwNFX4lAEQlizPADG889m4PiraWUz93KEjI96XbJntjgihme7RYWqQceaKV0afZxby05+ejtURxsgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OaZmoO4c0lsUeZH9tRCitJaCRtgdiS4px2CwntR+KY=;
 b=ummcEL2KazbA3WaD7BDt27CKOmvY15VjuNvhbWXTfXfHhXfJpLgDY5tnYQGCtNxKp70TzdqIJFN5EjnwoSgrxynAQF3pV+kWAFQ8nPxW5bbAzYyeqTGbzrvwRdEdKQlNsILDcrBGMY97ktihjzFPiN99c04OG9YRkMPsr+Umpw0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5355.namprd12.prod.outlook.com (2603:10b6:408:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Wed, 30 Jun
 2021 04:06:49 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 04:06:49 +0000
Subject: Re: [PATCH 01/11] drm/amdkfd: device pgmap owner at the svm migrate
 init
From: Felix Kuehling <felix.kuehling@amd.com>
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210629180206.8002-1-alex.sierra@amd.com>
 <163561d9-7731-d0cd-e539-b754d3349be3@amd.com>
Message-ID: <adcd54f4-9172-f1e8-abb7-64d92fcc62b5@amd.com>
Date: Wed, 30 Jun 2021 00:06:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <163561d9-7731-d0cd-e539-b754d3349be3@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.84.51]
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.19 via Frontend Transport; Wed, 30 Jun 2021 04:06:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24fa18c9-0792-40c1-98fe-08d93b7c7be2
X-MS-TrafficTypeDiagnostic: BN9PR12MB5355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5355C27A4C69136C8149315592019@BN9PR12MB5355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7NlwsHDBLr44jMOB4ZofV/XxDcTEEMCBiawzo7Bx9X4KYPH2C6p+X1CsxYm4OOC6GNyU5rkcw144Rk3PaFItEP9SXWJo7LnyP1RDPNqZLQZCTTp2sRRNwjG94/UZp0dtZSIFudB4cldb8QsjNOhz5qP+Pm9AnA2MTTgDy5u2UqI5gs8J7kob2+4mrnWn/WH+CB1Ghpd3h7JJIAPGLqay5A+qY4yhX8TFSkT5FtV8yELiWuH6eIbDPcSx9mQ4g9Kyr9HzyimKiaazEJClRtF/5I+ZO4hwxDJ2JLen93lyuJ7VbA13WCUOtFoFRfHzmtpAMSTYt/z0xZG6Koca+NXID9tQuqciDMTQyRBdtjheaCHnfl7VkxMYTIqSgFrZBOS4AfFk+GbT999o2gXiW0Dd1EjX0QIesk3dpuGQ88uSOAXI04urTfwAfSjJTv7EzbQ2z2v4GD2HGj/IBmhke6aCofi0yk6Gf9279//YTocFB5RfFlsbfRXMzKsdvZtPLhAUb0JmRDzTQycBVWBpSBPiShm7+ppAadXAnLhbcNLWDA4ZEPoEYzd1NkicmwxaIQHwzWJgqTFY4aWj9I3JqadKElDav/WUsfQE8e/5sm8sMOZywIS6UJaWKmxYNQbGddZkHQvFJySDBaznovZi9WTqOEEg4Ki1u5TNB6bGn9JldYZAmwURR1OI8XPjIFK4Jy9G9jSFMA4nwDLA3FPFiD9K1yxWSYFMWNfvNhdTGcPBZTsG4YkbUHZsMcr83+3gWy7gfenk5u5nZHTbXKfTUJmSVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(86362001)(26005)(16576012)(83380400001)(38100700002)(31696002)(8936002)(66946007)(44832011)(316002)(6486002)(478600001)(31686004)(956004)(2616005)(5660300002)(186003)(966005)(66556008)(66476007)(8676002)(16526019)(2906002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEJNUzFpRnZHTmk1L3oyOUVBb0p2Uy9BY1pZUmgyWXZ4eVZ0bmo3T3c5MUpQ?=
 =?utf-8?B?K2p3bjR1L3Y1V3JERmFCOHJjMWl1TFpWcFhMM09LZVB5WE1nbldEcUpDRWdr?=
 =?utf-8?B?b2ovdmhEL0dPRHg1K3NGYkY4bitpUE1qZ0Z2WUlSWC95SDd5UlhTaC9GdFFO?=
 =?utf-8?B?NERaMEplSFZ3ejdmVFZ1TVArbWxreXJVYUtpZnFnU2NjdjZiZ1h6T1h3ZUcr?=
 =?utf-8?B?VVVNdmcxWWRyRllOUkRabXRTZ2MwNVlVZXJGTzdVS3QyWStnN1VFRmhOZVlT?=
 =?utf-8?B?RlZid2Y1TnNiSTAzWUVCL0hOWmZRSVF3aS9NMURiOENQckVWR2JJY3lWdjBk?=
 =?utf-8?B?QmhjeFJWOG9lNGQ2MjdGTEVBbnIyMEZrT1hBTDlJYm1Ndmg1Z0p4VUd1TTJR?=
 =?utf-8?B?aitabUNmS1JjeWw0djZpZklIc2tkcXVubWxTQ2pSci9NMCtYeXdXOWNMczYy?=
 =?utf-8?B?NkJ2SERLdXVaUlJsbDE1bFhRTXVnRmZUc0hWT0lMNkV0SFE5S0ZrbEp3QU5y?=
 =?utf-8?B?a0oxVjVFT25mc3JMOTZUcnZJSE96SDB4OGFEbmtPbjFYYTZ0T0hFd0tNZTlt?=
 =?utf-8?B?NWEvZng0MGRUZjVrSTBtZ1E4a0tmNW9Ua292V0pkRlJBOXFnamcvQlRRcU1V?=
 =?utf-8?B?U2VzZENxTnAvdSs2Y3l1NVZxTWhDQk5pbzBiSlJvc0k0dytMUlpubUphM29X?=
 =?utf-8?B?Nko5ZWkrSUJxRFVVenMvMFpjWE5JY1RKTGMxS1loQmZheGtLQXRGVXdmR0kr?=
 =?utf-8?B?eHVDQ1pIa3hEYXZ4VFRVak1MRFByYklGWEN6ckJzeVVyUCtKWWVXS3dodkNq?=
 =?utf-8?B?cVV4eVpnUmlsQjliNUNaWG5YYXNxcUsyQ1FvdmY5MWF1MTZRRFRseExVZzIw?=
 =?utf-8?B?SktadGdQZ3pjVlhuMnNLZkRZZWw2eGFJRXg0azcybHA4aFhGVFBqb0JOOTUx?=
 =?utf-8?B?aTBSNEgwUE5hbFcxNGE1ZWRqOWxQMjB2bWVsQmdoRW8xN2wzendPSm1nd0c5?=
 =?utf-8?B?SVJzRVZZQ3lZMVRJU1lIL0FMSjR2K3ZGOU9wQ2M3WVh0djJZanNvVjJITFVz?=
 =?utf-8?B?V3kycitiUXMycWw5MzljbWNjSlJsQU9mYitPUGhKZXl3TDlXam02MXEvS0pL?=
 =?utf-8?B?VTZ1bWh5Sm42MDdXaG1WMm8zOFIyY0dOekU0ZDYrbkNQMVhsU2JqRlR1NEtF?=
 =?utf-8?B?OUFhVmJXMHhNaU5OZkdrRDd2VTBka1dHbnR4bmUyNGgrNEduekd4WGFCRm44?=
 =?utf-8?B?TUVwVThwOFViajhCbFp3aUFITzlVMnZtQmx2R1FycmpONXp2UE0vN0J1ZXVO?=
 =?utf-8?B?djhJenEvNlp5a0pyRms3NTBVVUUrVG9TT20vUnRTbUdzWWhzZTdvK04rL2Nz?=
 =?utf-8?B?R0tEczY2WW5zNHJNSnJQSUJQYktoR21wNFJ3QlQ3dlVNZjhSclpmZFF2aGRZ?=
 =?utf-8?B?T0pMYmtXdjdjZHNDS0VJc3hXNWVvZ1NHZEJVYlVsRm1oeHllWDBVNDJ5Vjgw?=
 =?utf-8?B?UlluQ0FNYk1vYXJSeXZoZ216VmI3Nmw0ZnRJVEFEczJOZnNmak0wNkJtNXN2?=
 =?utf-8?B?UU9XTDlMMlh3S0k5ejZQaVVOWHJtVGxya1I3NlRwdjYwLzBYRldhcDg5b0VM?=
 =?utf-8?B?anJ2TjhXSmZOQ1NsN1U1emp3TlRpZ0RxQWN2V3hiZDlJQ3lxK3Fad2FRejhD?=
 =?utf-8?B?TGZ3V245SE8yeGtxQkVoTXpMOEh5bFU5a21BZ1RUWUYxT2NxcHprV29iR2Ur?=
 =?utf-8?Q?AVq4bGg7+Bn9eU3JyH8aOwogUxYJ/gWXcLIOkJG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fa18c9-0792-40c1-98fe-08d93b7c7be2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 04:06:49.1431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+7dV2E9VY4aV7/B/Hz/h8ZDVfF+1KWVl/pYG9YUeNUmdLnU9zzFvqcVHrWApAt688s277HmSv/uu9QubsLYXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5355
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T3RoZXIgdGhhbiB0aGUgdXBkYXRlZCBwYXRjaCBkZXNjcmlwdGlvbiBmb3IgcGF0Y2ggMSwgdGhl
IHNlcmllcwoocGF0Y2hlcyAxLTEwKSBpcwoKUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxG
ZWxpeC5LdWVobGluZ0BhbWQuY29tPgoKUGF0Y2ggMTEgd2FzIGFscmVhZHkgcmV2aWV3ZWQgYW5k
IHJldmlzZWQgc2VwYXJhdGVseS4KClRoYW5rcywKwqAgRmVsaXgKCgpBbSAyMDIxLTA2LTMwIHVt
IDEyOjAwIGEubS4gc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBBbSAyMDIxLTA2LTI5IHVtIDI6
MDEgcC5tLiBzY2hyaWViIEFsZXggU2llcnJhOgo+PiBwZ21hcCBvd25lciBtZW1iZXIgYXQgdGhl
IHN2bSBtaWdyYXRlIGluaXQgY291bGQgYmUgcmVmZXJlbmNlZAo+PiB0byBlaXRoZXIgYWRldiBv
ciBoaXZlLCBkZXBlbmRpbmcgb24gZGV2aWNlIHRvcG9sb2d5Lgo+IFBsZWFzZSB1cGRhdGUgdGhl
IGNvbW1pdCBkZXNjcmlwdGlvbiBiZWZvcmUgc3VibWl0dGluZyB0aGUgY2hhbmdlOgo+Cj4gR1BV
cyBpbiB0aGUgc2FtZSBYR01JIGhpdmUgaGF2ZSBkaXJlY3QgYWNjZXNzIHRvIGFsbCBtZW1iZXJz
JyBWUkFNLiBXaGVuCj4gbWFwcGluZyBtZW1vcnkgdG8gYSBHUFUsIHdlIGRvbid0IG5lZWQgaG1t
X3JhbmdlX2ZhdWx0IHRvIGZhdWx0Cj4gZGV2aWNlLXByaXZhdGUgcGFnZXMgaW4gdGhlIHNhbWUg
aGl2ZSBiYWNrIHRvIHRoZSBob3N0LiBJZGVudGlmeWluZyB0aGUKPiBwYWdlIG93bmVyIGFzIHRo
ZSBoaXZlLCByYXRoZXIgdGhhbiB0aGUgaW5kaXZpZHVhbCBHUFUsIGFjY29tcGxpc2hlcyB0aGlz
Lgo+Cj4KPj4gU2lnbmVkLW9mZi1ieTogQWxleCBTaWVycmEgPGFsZXguc2llcnJhQGFtZC5jb20+
Cj4+IFJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4K
Pj4gLS0tCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5jIHwgNiAr
KystLS0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uaCAgICAgfCAzICsr
Kwo+PiAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYwo+PiBpbmRleCA0NWI1
MzQ5MjgzYWYuLjhjZTcxYzgxNDJhYSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX21pZ3JhdGUuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfbWlncmF0ZS5jCj4+IEBAIC00MjcsNyArNDI3LDcgQEAgc3ZtX21pZ3JhdGVfdm1hX3Rv
X3ZyYW0oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBzdm1fcmFuZ2UgKnByYW5n
ZSwKPj4gIAltaWdyYXRlLnN0YXJ0ID0gc3RhcnQ7Cj4+ICAJbWlncmF0ZS5lbmQgPSBlbmQ7Cj4+
ICAJbWlncmF0ZS5mbGFncyA9IE1JR1JBVEVfVk1BX1NFTEVDVF9TWVNURU07Cj4+IC0JbWlncmF0
ZS5wZ21hcF9vd25lciA9IGFkZXY7Cj4+ICsJbWlncmF0ZS5wZ21hcF9vd25lciA9IFNWTV9BREVW
X1BHTUFQX09XTkVSKGFkZXYpOwo+PiAgCj4+ICAJc2l6ZSA9IDIgKiBzaXplb2YoKm1pZ3JhdGUu
c3JjKSArIHNpemVvZih1aW50NjRfdCkgKyBzaXplb2YoZG1hX2FkZHJfdCk7Cj4+ICAJc2l6ZSAq
PSBucGFnZXM7Cj4+IEBAIC02NDksNyArNjQ5LDcgQEAgc3ZtX21pZ3JhdGVfdm1hX3RvX3JhbShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IHN2bV9yYW5nZSAqcHJhbmdlLAo+PiAg
CW1pZ3JhdGUuc3RhcnQgPSBzdGFydDsKPj4gIAltaWdyYXRlLmVuZCA9IGVuZDsKPj4gIAltaWdy
YXRlLmZsYWdzID0gTUlHUkFURV9WTUFfU0VMRUNUX0RFVklDRV9QUklWQVRFOwo+PiAtCW1pZ3Jh
dGUucGdtYXBfb3duZXIgPSBhZGV2Owo+PiArCW1pZ3JhdGUucGdtYXBfb3duZXIgPSBTVk1fQURF
Vl9QR01BUF9PV05FUihhZGV2KTsKPj4gIAo+PiAgCXNpemUgPSAyICogc2l6ZW9mKCptaWdyYXRl
LnNyYykgKyBzaXplb2YodWludDY0X3QpICsgc2l6ZW9mKGRtYV9hZGRyX3QpOwo+PiAgCXNpemUg
Kj0gbnBhZ2VzOwo+PiBAQCAtOTIxLDcgKzkyMSw3IEBAIGludCBzdm1fbWlncmF0ZV9pbml0KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+PiAgCXBnbWFwLT5yYW5nZS5zdGFydCA9IHJlcy0+
c3RhcnQ7Cj4+ICAJcGdtYXAtPnJhbmdlLmVuZCA9IHJlcy0+ZW5kOwo+PiAgCXBnbWFwLT5vcHMg
PSAmc3ZtX21pZ3JhdGVfcGdtYXBfb3BzOwo+PiAtCXBnbWFwLT5vd25lciA9IGFkZXY7Cj4+ICsJ
cGdtYXAtPm93bmVyID0gU1ZNX0FERVZfUEdNQVBfT1dORVIoYWRldik7Cj4+ICAJcGdtYXAtPmZs
YWdzID0gTUlHUkFURV9WTUFfU0VMRUNUX0RFVklDRV9QUklWQVRFOwo+PiAgCXIgPSBkZXZtX21l
bXJlbWFwX3BhZ2VzKGFkZXYtPmRldiwgcGdtYXApOwo+PiAgCWlmIChJU19FUlIocikpIHsKPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uaCBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uaAo+PiBpbmRleCBhOWFmMDM5OTRkMWEuLjFm
ODhiZGZkYmNjMiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3N2bS5oCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uaAo+PiBA
QCAtMzUsNiArMzUsOSBAQAo+PiAgI2luY2x1ZGUgImFtZGdwdS5oIgo+PiAgI2luY2x1ZGUgImtm
ZF9wcml2LmgiCj4+ICAKPj4gKyNkZWZpbmUgU1ZNX0FERVZfUEdNQVBfT1dORVIoYWRldilcCj4+
ICsJCQkoKGFkZXYpLT5oaXZlID8gKHZvaWQgKikoYWRldiktPmhpdmUgOiAodm9pZCAqKShhZGV2
KSkKPj4gKwo+PiAgc3RydWN0IHN2bV9yYW5nZV9ibyB7Cj4+ICAJc3RydWN0IGFtZGdwdV9ibwkJ
KmJvOwo+PiAgCXN0cnVjdCBrcmVmCQkJa3JlZjsKPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
