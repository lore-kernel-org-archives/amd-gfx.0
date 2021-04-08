Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8861EC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 20:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4110861107
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 20:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4110861107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9695A6E328;
	Thu,  8 Apr 2021 20:39:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D4166E323
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 20:39:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYV2EzHaRn+f9jSxWbsufeSwJbz3dzvEQb6Y+7hAr7F27TIhGz7Rf3R2feo8aDIakp06Ohgh9Tg5B0j9pu4ZdbpaoW8jP36u30x7xlUltueK+gRttucYwPihQpxdNPIGkxaIA/Ga1tod9QV0O5jb9RvnzB7gSKJsBigigUBaN47GP1hW8aQPc6RLn6zrBdxJFI411rjh7H86XPNPc1K7UvctIuUouGsGISD7jZ+nwBsGO0FX+Oq7s/NaS8Q/c61Vk8JYmDX+NdqTwXqhiauiiY/Elzruc1Js3IPYozzwbaDc5AgjQoMW+YVcXXTca8ldrucL2QkHZRh96u46zNJ65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mYpoFBuRRqOoSlj5MtFIQGwDqY1EUQO8A1RveM8D1w=;
 b=dEylxdteuTLBZGItFPY/Y2GpIk0ygy5vqoXvtuBzZb3jVU3BtAdilpznhdbRZFvNIKpds1CdF3E8RiZR0Te7Vb17bspHQJk+wjZWCaNNQITFDaTRisznIVKMj+aJY5NpciaHLfQ6SfsR7ahgdxJkYd1uZAaVwgxKPoc4k9GcRVdb/Kw2NhZwCPmTFWZP7U6fSa0e2PWYAVKUM2EZo6P2+4QaO5i8RGAgPF/J5KeZgGDOV2Cvjk7KlM5SZHyye5A0VqPaibhKYlk6qgbK4g6AHPfaIHFz/bV4NrWALA3ToIaboS5bgQgYme6imAxLhioDNrkN7TqvoM5g5avcsABF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mYpoFBuRRqOoSlj5MtFIQGwDqY1EUQO8A1RveM8D1w=;
 b=CcJUeJaSkDUyn/lcfsEnMcZZ5E8rNECm/r89I4fxyoWwJ+CxO58mzeLuyqCVzdEGrDUjDLhyzJ+Wk3RrJSN6jG15xGc3DwsRao1bLiIJC74+Kx74zb0vO4KGVSk73oxk+MKjRPy1BWEiBJ1F43CxvKzFGQg0k6ZyYhsoW/HdAno=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB4766.namprd12.prod.outlook.com (2603:10b6:805:e2::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 8 Apr
 2021 20:39:06 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 20:39:06 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <d40648ba-9948-5442-23ed-d352f824f8f9@amd.com>
 <DM5PR12MB25330F3CD92C587C2E921424ED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <MN2PR12MB3775531A74B886A207134B1583699@MN2PR12MB3775.namprd12.prod.outlook.com>
 <DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <378fdffb-99b5-2a14-736d-a06f310b040c@amd.com>
 <1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com>
 <51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com>
 <29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com>
 <e37bdceb-cdb2-a826-21cf-8cb88748be08@gmail.com>
 <1e4b766d-b5c2-e6b5-8be6-9b2fae3abc94@amd.com>
 <b67ab565-e4be-0809-7021-cb59fd10464a@amd.com>
 <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
 <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
Date: Thu, 8 Apr 2021 16:39:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:2a1:d154:32b0:ff6]
X-ClientProxiedBy: YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::48) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:2a1:d154:32b0:ff6]
 (2607:fea8:3edf:49b0:2a1:d154:32b0:ff6) by
 YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32 via Frontend Transport; Thu, 8 Apr 2021 20:39:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dca2194c-0ca7-4cdb-450a-08d8face5a58
X-MS-TrafficTypeDiagnostic: SN6PR12MB4766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB47669E453B3E4BFABA5ACBE0EA749@SN6PR12MB4766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ChsaECbL36bWJuia/9LCaTwpQwrRGncdAG8n/jMLBt1BTZgCAjDRBxklSizmcjIxr3iBpxQMm4p7TA36RTa1DQ43jerfiQDsho1kl17yWPH2zVf45z+KAcbn7pdeYuef6qFzUUZi57TBJFQBuH06aRmvDpSMl4sRpDMWpPOtcJa3KJ4E9a4bZBkTS+HFfQqwzREbaK3j/TRQJR2mN9WMXuNyukbGaQOhN3RHENj6qYDo+1KpcZye/Z+k4nvHss7yoOpr/vSQ1r2mJmHKioC6Ie/IpXzW8axuKsI9yRZjqpcu20lcZ00aBhc9r8ljHvyXu/cQp/b9hYTt7lnkmq9sHE5ZB+K+AbtN8s08CgtE6Q+LbuE4Sr3gvQ0T3chv3YGeobzsUWe6CdQ3OzRuqcWIElrc49AXUgld8JAPB8Sxt/1LXBDh8BElgA9RlG+hGGq1i7w2uDGKt4NjX3ykZUx7z3LybLmlVRNo5rueiRmCfRyw+EGwQlxuVwCljGxdxk9oAWTmVUbZAmbGWifK9y97wnTJqizcH7TA5zYexSQb/P4cDufhc0dU3V4PSmn51QeRRG73OL/SyCXnhrJPHrghszHbpZRhnyJR95h+LmKCweAjzptfKr6c1E4uAWguaPCDONFwRmrJNArxrach4aeUi3ttp6MLU9QLbGwLj++p3pXksc95v6U1IpYJIzaXyrSOIeCH5sF32OM2AtMmuEHiFS+OTkMUWyWObRJrWVr8G/OtkZ2voQlHYG2fEoIg6ktQQAogFhp9bDUpYkV5dzHrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(316002)(6636002)(966005)(31686004)(5660300002)(2616005)(921005)(478600001)(8936002)(83380400001)(16526019)(36756003)(66574015)(53546011)(86362001)(38100700001)(66556008)(110136005)(66946007)(8676002)(44832011)(66476007)(31696002)(52116002)(186003)(6486002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MVhHdnVrRnp6WGZkM3EyWDZFekN0c092bmFFUkxwYVNid2NXalI0dmdkU3VH?=
 =?utf-8?B?aTU0NXcza0lKdTBYTElUT0R5Z2dRYUhCb2hZMnJPSGloc3oveW5rVXVXTHQz?=
 =?utf-8?B?bXdSYy9rYlFldDJJTUxLblJkQUJ2alJaZ0Y2ZnN1eGF2ZWdpOHR0UFFia05U?=
 =?utf-8?B?UHl6NTZyR0RMWWIramcvZHBJZnNUelYrS2JwbjJLZ1d1RjBsVEhZMWw5MmhQ?=
 =?utf-8?B?QTFXeHdCWjFXWWljbTFJemJsdEEwMm4vYVMxNUtVZFlSV01XYkNqSEhFUHUz?=
 =?utf-8?B?RndFakhVak1FbU1NMzlWeU9od1NQbVdnS2ZRM2tBTjFBcVV3RU5LVko1Nk5k?=
 =?utf-8?B?TWdTdmhZSlZEVWRSOERZTW1nd25KSUY1WGdtdklYa0QzaUlIZGZlcXNwaE1k?=
 =?utf-8?B?TnRSdVk2MWtKa0Z1VDFmSE5pZFpicFlrQUZwZEdxUkU2RHhnUVVvaGpubTgx?=
 =?utf-8?B?TVVNY2NkVUFrUmtJa2YwNkwwS2FWakRqN0lRWjRrVjhCKzVIdGtXNGNLWnJC?=
 =?utf-8?B?MDVnSlZ5SzZuNWEzQSs1dDdDcGV1QW1ld2RENzdWenRTNjU1TTladzBiZHNS?=
 =?utf-8?B?OUFucjcvL0YvdU5YSm8yRjAvdkp0bEZQcjhkR1h3eGlFYUYxL2JtS2E2eWMv?=
 =?utf-8?B?VkNERWYrV0E2elV4NHltbVM1SE1MTW1uNXFFUlQxaGR2SUxtcTUxOEk1bEVw?=
 =?utf-8?B?K3NOS1lpVFBDRDhuRStCL3dkU1F6NDlQb1hoZmU3TmV5MGZOZWltcWtPUVVK?=
 =?utf-8?B?cmtublhtRHRtRDFnKy9PdGI5TVlwbmRYMk5kbFR1QjhUdGNTcEtaKzNlTmJK?=
 =?utf-8?B?U2g0clk5VnRibW90V1NOcjNUZmNHMWNBSTVreHI1ZTRLOWpSclhmcDJMelA5?=
 =?utf-8?B?Sk9QOHZjRmFJWkpxMWdyMUtkdXZZODVaMStZcmk3RzlOUXFYa3ZwaDU0T29V?=
 =?utf-8?B?SlFuUE1GVE11OTYxcHBvWUtFdGFwaWZuWFVXYkk1SjdTZFZUaEMyT3Rsa2Zr?=
 =?utf-8?B?YTl4OW9nc0VGd2t1NTRYajJvUUNqK2VaMGZWeVFONGpyWkVjTGFxYmk5YW9o?=
 =?utf-8?B?aERyQ0tyWlZOWkl5YWo3SVJSckhrM0w2QXRWZjNpZzhpcFo0YnhvK1pXTnBo?=
 =?utf-8?B?akhmT2d3WmNnL3dhWTluU05nbDYwMWJ5UW1nOGNJaXpLNGFwVCtzNStOMGp3?=
 =?utf-8?B?ZjNOTnJVKzJ0R2x4emQ0eUhjN1hKSE5Uc0VtcmNPSXplZGRHOVZnSHZkSlVE?=
 =?utf-8?B?aWhEdzJWN2hVRlBSSDRPT3RTNzhQVzZQZnhtVjdialI5c2JZbE55SjhmbTFP?=
 =?utf-8?B?ZytwMVNONzdLY2RUL0pnN1N4Y0pQTzRDT1hRYnQxSnVuQlhMWHZmLzlaOTh4?=
 =?utf-8?B?NHBaa1NoNGI1TTJKVTVuU28rMCswK2FBT2FvbjJHb1laKzBHazg4Snh5OFRs?=
 =?utf-8?B?QVVKUFVJKzZRc0ppbGxySHFlUTVldmV5ZnRvdy91STZIUldpT2tFQTN4ZWo1?=
 =?utf-8?B?SHBxLzNNN1kyb1ZVakVKanBwTTk3ek8zMUVLMUxqUU9MUktnbFZIaDJKL0Y3?=
 =?utf-8?B?bFQxSTBhQ2pydkovdHZVVVhoWEw1VTB5RGYyWU10cjZ0cWZQMU1md0hIM0E1?=
 =?utf-8?B?U2haZU05dW1PdEQ3VkZ1aEhLak5QcWlOZUI1VVJMSVAxKy9LNHFSWDZ6NnNS?=
 =?utf-8?B?aS9CN014aW5MTHhSTG9VTXg0WDgrclBRUE15cld2NHVyd0puc1lOYTdTcmJD?=
 =?utf-8?B?dlBqZEZkVUhENlZNdDFUbUovR0M1RDJzTjMrQkdra0gvWGxXWWwvUllKQUFR?=
 =?utf-8?B?VG1GUW9XbGFBaWQ2cDNEZXFzWUxjam1HNmRCT2RoanBDbUE5SXNHOVRyaWtZ?=
 =?utf-8?Q?ZTDMjt+XDyPUs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca2194c-0ca7-4cdb-450a-08d8face5a58
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 20:39:06.0645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEnrAMKnj1YJvCeC1bUDe9eXaeotm8QtZvfLy3nlS3oh5QH7Jll5352hEvZfAT6RoQCiDNHF3vbCiXn99pqXBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4766
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjEtMDQtMDggMjo1OCBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDA4
LjA0LjIxIHVtIDE4OjA4IHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+IE9uIDIwMjEtMDQt
MDggNDozMiBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMDguMDQuMjEgdW0g
MTA6MjIgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Pj4+IFtTTklQXQo+Pj4+Pj4KPj4+Pj4+
Cj4+Pj4+Pj4gQmV5b25kIGJsb2NraW5nIGFsbCBkZWxheWVkIHdvcmtzIGFuZCBzY2hlZHVsZXIg
dGhyZWFkcyB3ZSBhbHNvIAo+Pj4+Pj4+IG5lZWQgdG8gZ3VhcmFudGVlIG5vwqAgSU9DVEwgY2Fu
IGFjY2VzcyBNTUlPIHBvc3QgZGV2aWNlIHVucGx1ZyAKPj4+Pj4+PiBPUiBpbiBmbGlnaHQgSU9D
VExzIGFyZSBkb25lIGJlZm9yZSB3ZSBmaW5pc2ggcGNpX3JlbW92ZSAKPj4+Pj4+PiAoYW1kZ3B1
X3BjaV9yZW1vdmUgZm9yIHVzKS4KPj4+Pj4+PiBGb3IgdGhpcyBJIHN1Z2dlc3Qgd2UgZG8gc29t
ZXRoaW5nIGxpa2Ugd2hhdCB3ZSB3b3JrZWQgb24gd2l0aCAKPj4+Pj4+PiBUYWthc2hpIEl3YWkg
dGhlIEFMU0EgbWFpbnRhaW5lciByZWNlbnRseSB3aGVuIGhlIGhlbHBlZCAKPj4+Pj4+PiBpbXBs
ZW1lbnRpbmcgUENJIEJBUnMgbW92ZSBzdXBwb3J0IGZvciBzbmRfaGRhX2ludGVsLiBUYWtlIGEg
Cj4+Pj4+Pj4gbG9vayBhdAo+Pj4+Pj4+IGh0dHBzOi8vY2dpdC5mcmVlZGVza3RvcC5vcmcvfmFn
cm9kem92L2xpbnV4L2NvbW1pdC8/aD15YWRyby9wY2llX2hvdHBsdWcvbW92YWJsZV9iYXJzX3Y5
LjEmaWQ9Y2JhYTMyNDc5OTcxOGUyYjgyOGE4YzdiNWIwMDFkZDg5Njc0ODQ5NyAKPj4+Pj4+PiBh
bmQKPj4+Pj4+PiBodHRwczovL2NnaXQuZnJlZWRlc2t0b3Aub3JnL35hZ3JvZHpvdi9saW51eC9j
b21taXQvP2g9eWFkcm8vcGNpZV9ob3RwbHVnL21vdmFibGVfYmFyc192OS4xJmlkPWUzNjM2NWQ5
YWI1YmJjMzBiZGMyMjFhYjRiMzQzN2RlMzQ0OTI0NDAgCj4+Pj4+Pj4KPj4+Pj4+PiBXZSBhbHNv
IGhhZCBzYW1lIGlzc3VlIHRoZXJlLCBob3cgdG8gcHJldmVudCBNTUlPIGFjY2Vzc2VzIHdoaWxl
IAo+Pj4+Pj4+IHRoZSBCQVJzIGFyZSBtaWdyYXRpbmcuIFdoYXQgd2FzIGRvbmUgdGhlcmUgaXMg
YSByZWZjb3VudCB3YXMgCj4+Pj4+Pj4gYWRkZWQgdG8gY291bnQgYWxsIElPQ1RMcyBpbiBmbGln
aHQsIGZvciBhbnkgaW4gZmxpZ2h0wqAgSU9DVEwgCj4+Pj4+Pj4gdGhlIEJBUiBtaWdyYXRpb24g
aGFuZGxlciB3b3VsZAo+Pj4+Pj4+IGJsb2NrIGZvciB0aGUgcmVmY291bnQgdG8gZHJvcCB0byAw
IGJlZm9yZSBpdCB3b3VsZCBwcm9jZWVkLCBmb3IgCj4+Pj4+Pj4gYW55IGxhdGVyIElPQ1RMIGl0
IHN0b3BzIGFuZCB3YWl0IGlmIGRldmljZSBpcyBpbiBtaWdyYXRpb24gCj4+Pj4+Pj4gc3RhdGUu
IFdlIGV2ZW4gZG9uJ3QgbmVlZCB0aGUgd2FpdCBwYXJ0LCBub3RoaW5nIHRvIHdhaXQgZm9yLCB3
ZSAKPj4+Pj4+PiBqdXN0IHJldHVybiB3aXRoIC1FTk9ERVYgZm9yIHRoaXMgY2FzZS4KPj4+Pj4+
Pgo+Pj4+Pj4KPj4+Pj4+IFRoaXMgaXMgZXNzZW50aWFsbHkgd2hhdCB0aGUgRFJNIFNSQ1UgaXMg
ZG9pbmcgYXMgd2VsbC4KPj4+Pj4+Cj4+Pj4+PiBGb3IgdGhlIGhvdHBsdWcgY2FzZSB3ZSBjb3Vs
ZCBkbyB0aGlzIGluIHRoZSB0b3BsZXZlbCBzaW5jZSB3ZSAKPj4+Pj4+IGNhbiBzaWduYWwgdGhl
IGZlbmNlIGFuZCBkb24ndCBuZWVkIHRvIGJsb2NrIG1lbW9yeSBtYW5hZ2VtZW50Lgo+Pj4+Pgo+
Pj4+Pgo+Pj4+PiBUbyBtYWtlIFNSQ1UgJ3dhaXQgZm9yJyBhbGwgSU9DVExzIGluIGZsaWdodCB3
ZSB3b3VsZCBuZWVkIHRvIHdyYXAgCj4+Pj4+IGV2ZXJ5IElPQ1RMICggcHJhY3RpY2FsbHkgLSBq
dXN0IGRybV9pb2N0bCBmdW5jdGlvbikgd2l0aCAKPj4+Pj4gZHJtX2Rldl9lbnRlci9kcm1fZGV2
X2V4aXQgLSBjYW4gd2UgZG8gaXQgPwo+Pj4+Pgo+Pj4KPj4+IFNvcnJ5IHRvdGFsbHkgbWlzc2Vk
IHRoaXMgcXVlc3Rpb24uCj4+Pgo+Pj4gWWVzLCBleGFjdGx5IHRoYXQuIEFzIGRpc2N1c3NlZCBm
b3IgdGhlIGhvdHBsdWcgY2FzZSB3ZSBjYW4gZG8gdGhpcy4KPj4KPj4KPj4gVGhpbmtpbmcgbW9y
ZSBhYm91dCBpdCAtIGFzc3VtaW5nIHdlIGFyZcKgIHRyZWF0aW5nIHN5bmNocm9uaXplX3NyY3Ug
Cj4+IGFzIGEgJ3dhaXQgZm9yIGNvbXBsZXRpb24nIG9mIGFueSBpbiBmbGlnaHQge2RybV9kZXZf
ZW50ZXIsIAo+PiBkcm1fZGV2X2V4aXR9IHNjb3BlLCBzb21lIG9mIHRob3NlIHNjb3BlcyBtaWdo
dCBkbyBkbWFfZmVuY2Vfd2FpdCAKPj4gaW5zaWRlLiBTaW5jZSB3ZSBoYXZlbid0IGZvcmNlIHNp
Z25hbGVkIHRoZSBmZW5jZXMgeWV0IHdlIHdpbGwgZW5kIHVwIAo+PiBhIGRlYWRsb2NrLiBXZSBo
YXZlIHRvIHNpZ25hbCBhbGwgdGhlIHZhcmlvdXMgZmVuY2VzIGJlZm9yZSBkb2luZyB0aGUgCj4+
ICd3YWl0IGZvcicuIEJ1dCB3ZSBjYW4ndCBzaWduYWwgdGhlIGZlbmNlcyBiZWZvcmUgc2V0dGlu
ZyAKPj4gJ2Rldi0+dW5wbHVnZ2VkID0gdHJ1ZScgdG8gcmVqZWN0IGZ1cnRoZXIgQ1MgYW5kIG90
aGVyIHN0dWZmIHdoaWNoIAo+PiBtaWdodCBjcmVhdGUgbW9yZSBmZW5jZXMgd2Ugd2VyZSBzdXBw
b3NlZC10byBmb3JjZSBzaWduYWwgYW5kIG5vdyAKPj4gbWlzc2VkIHRoZW0uIEVmZmVjdGl2ZWx5
IHNldHRpbmcgJ2Rldi0+dW5wbHVnZ2VkID0gdHJ1ZScgYW5kIGRvaW5nIAo+PiBzeW5jaHJvbml6
ZV9zcmN1IGluIG9uZSBjYWxsIGxpa2UgZHJtX2Rldl91bnBsdWcgZG9lcyB3aXRob3V0IAo+PiBz
aWduYWxsaW5nIGFsbCB0aGUgZmVuY2VzIGluIHRoZSBkZXZpY2UgaW4gYmV0d2VlbiB0aGVzZSB0
d28gc3RlcHMgCj4+IGxvb2tzIGx1Y2sgYSBwb3NzaWJsZSBkZWFkbG9jayB0byBtZSAtIHdoYXQg
ZG8geW91IHRoaW5rID8KPj4KPgo+IEluZGVlZCwgdGhhdCBpcyBhIHJlYWxseSBnb29kIGFyZ3Vt
ZW50IHRvIGhhbmRsZSBpdCB0aGUgc2FtZSB3YXkgYXMgCj4gdGhlIHJlc2V0IGxvY2suCj4KPiBF
LmcuIG5vdCB0YWtpbmcgaXQgYXQgdGhlIGhpZ2ggbGV2ZWwgSU9DVEwsIGJ1dCByYXRoZXIgd2hl
biB0aGUgCj4gZnJvbnRlbmQgb2YgdGhlIGRyaXZlciBoYXMgYWNxdWlyZWQgYWxsIHRoZSBuZWNl
c3NhcnkgbG9ja3MgKEJPIHJlc3YsIAo+IFZNIGxvY2sgZXRjLi4uKSBiZWZvcmUgY2FsbGluZyBp
bnRvIHRoZSBiYWNrZW5kIHRvIGFjdHVhbGx5IGRvIHRoaW5ncyAKPiB3aXRoIHRoZSBoYXJkd2Fy
ZS4KPgo+IENocmlzdGlhbi4KCiBGcm9tIHdoYXQgeW91IHNhaWQgSSB1bmRlcnN0YW5kIHRoYXQg
eW91IHdhbnQgdG8gc29sdmUgdGhpcyBwcm9ibGVtIGJ5IAp1c2luZyBkcm1fZGV2X2VudGVyL2V4
aXQgYnJhY2tldHMgbG93IGVub3VnaCBpbiB0aGUgY29kZSBzdWNoIHRoYXQgaXQgCndpbGwgbm90
IGluY2x1ZGUgYW5kIGZlbmNlIHdhaXQuCgpCdXQgaW5zZXJ0aW5nIGRtcl9kZXZfZW50ZXIvZXhp
dCBvbiB0aGUgaGlnaGVzdCBsZXZlbCBpbiBkcm1faW9jdGwgaXMgCm11Y2ggbGVzcyBlZmZvcnQg
YW5kIGxlc3Mgcm9vbSBmb3IgZXJyb3IgdGhlbiBnb2luZyB0aHJvdWdoIGVhY2ggSU9DVEwgCmFu
ZCB0cnlpbmcgdG8gaWRlbnRpZnkgYXQgd2hhdCBwb2ludCAocG9zc2libHkgbXVsdGlwbGUgcG9p
bnRzKSB0aGV5IGFyZSAKYWJvdXQgdG8gYWNjZXNzIEhXLCBzb21lIG9mIHRoaXMgaXMgaGlkZGVu
IGRlZXAgaW4gSEFMIGxheWVycyBzdWNoIGFzIERDIApsYXllciBpbiBkaXNwbGF5IGRyaXZlciBv
ciB0aGUgbXVsdGkgbGF5ZXJzIG9mIHBvd2VycGxheS9TTVUgbGlicmFyaWVzLiAKQWxzbywgd2Ug
Y2FuJ3Qgb25seSBsaW1pdCBvdXItc2VsZiB0byBiYWNrLWVuZCBpZiBieSB0aGlzIHlvdSBtZWFu
IEFTSUMgCnNwZWNpZmljIGZ1bmN0aW9ucyB3aGljaCBhY2Nlc3MgcmVnaXN0ZXJzLiBXZSBhbHNv
IG5lZWQgdG8gdGFrZSBjYXJlIG9mIAphbnkgTU1JTyBrZXJuZWwgQk8gKFZSQU0gQk9zKSB3aGVy
ZSB3ZSBtYXkgYWNjZXNzIGRpcmVjdGx5IE1NSU8gc3BhY2UgYnkgCnBvaW50ZXIgZnJvbSB0aGUg
ZnJvbnQgZW5kIG9mIHRoZSBkcml2ZXIgKEhXIGFnbm9zdGljKSBhbmQgVFRNL0RSTSBsYXllcnMu
CgpPdXIgcHJvYmxlbSBoZXJlIGlzIGhvdyB0byBzaWduYWwgYWxsIHRoZSBleGlzdGluZ8KgIGZl
bmNlcyBvbiBvbmUgaGFuZCAKYW5kIG9uIHRoZSBvdGhlciBwcmV2ZW50IGFueSBuZXcgZG1hX2Zl
bmNlIHdhaXRzIGFmdGVyIHdlIGZpbmlzaGVkIApzaWduYWxpbmcgZXhpc3RpbmcgZmVuY2VzLiBP
bmNlIHdlIHNvbHZlZCB0aGlzIHRoZW4gdGhlcmUgaXMgbm8gcHJvYmxlbSAKdXNpbmcgZHJtX2Rl
dl91bnBsdWcgaW4gY29uanVuY3Rpb24gd2l0aCBkcm1fZGV2X2VudGVyL2V4aXQgYXQgdGhlIApo
aWdoZXN0IGxldmVsIG9mIGRybV9pb2N0bCB0byBmbHVzaCBhbnkgSU9DVExzIGluIGZsaWdodCBh
bmQgYmxvY2sgYW55IApuZXcgb25lcy4KCklNSE8gd2hlbiB3ZSBzcGVhayBhYm91dCBzaWduYWxs
aW5nIGFsbCBmZW5jZXMgd2UgZG9uJ3QgbWVhbiBBTEwgdGhlIApjdXJyZW50bHkgZXhpc3Rpbmcg
ZG1hX2ZlbmNlIHN0cnVjdHMgKHRoZXkgYXJlIHNwcmVhZCBhbGwgb3ZlciB0aGUgCnBsYWNlKSBi
dXQgcmF0aGVyIHNpZ25hbCBhbGwgdGhlIEhXIGZlbmNlcyBiZWNhdXNlIEhXIGlzIHdoYXQncyBn
b25lIGFuZCAKd2UgY2FuJ3QgZXhwZWN0IGZvciB0aG9zZSBmZW5jZXMgdG8gYmUgZXZlciBzaWdu
YWxlZC4gQWxsIHRoZSByZXN0IHN1Y2ggCmFzOiBzY2hlZHVsZXIgZmVuY2VzLMKgIHVzZXIgZmVu
Y2VzLCBkcm1fZ2VtIHJlc2VydmF0aW9uIG9iamVjdHMgZS50LmMuIAphcmUgZWl0aGVyIGRlcGVu
ZGVudCBvbiB0aG9zZSBIVyBmZW5jZXMgYW5kIGhlbmNlIHNpZ25hbGluZyB0aGUgSFcgCmZlbmNl
cyB3aWxsIGluIHR1cm4gc2lnbmFsIHRoZW0gb3IsIGFyZSBub3QgaW1wYWN0ZWQgYnkgdGhlIEhX
IGJlaW5nIApnb25lIGFuZCBoZW5jZSBjYW4gc3RpbGwgYmUgd2FpdGVkIG9uIGFuZCB3aWxsIGNv
bXBsZXRlLiBJZiB0aGlzIAphc3N1bXB0aW9uIGlzIGNvcnJlY3QgdGhlbiBJIHRoaW5rIHRoYXQg
d2Ugc2hvdWxkIHVzZSBzb21lIGZsYWcgdG8gCnByZXZlbnQgYW55IG5ldyBzdWJtaXNzaW9uIHRv
IEhXIHdoaWNoIGNyZWF0ZXMgSFcgZmVuY2VzIChzb21ld2hlcmUgCmFyb3VuZCBhbWRncHVfZmVu
Y2VfZW1pdCksIHRoZW4gdHJhdmVyc2UgYWxsIGV4aXN0aW5nIEhXIGZlbmNlcyAKKGN1cnJlbnRs
eSB0aGV5IGFyZSBzcHJlYWQgaW4gYSBmZXcgcGxhY2VzIHNvIG1heWJlIHdlIG5lZWQgdG8gdHJh
Y2sgCnRoZW0gaW4gYSBsaXN0KSBhbmQgc2lnbmFsIHRoZW0uIEFmdGVyIHRoYXQgaXQncyBzYWZl
IHRvIGNhbCAKZHJtX2Rldl91bnBsdWcgYW5kIGJlIHN1cmUgc3luY2hyb25pemVfc3JjdSB3b24n
dCBzdGFsbCBiZWNhdXNlIG9mIG9mIApkbWFfZmVuY2Vfd2FpdC4gQWZ0ZXIgdGhhdCB3ZSBjYW4g
cHJvY2VlZCB0byBjYW5jZWxpbmcgd29yayBpdGVtcywgCnN0b3BwaW5nIHNjaGVkdWxlcnMgZS50
LmMuCgpBbmRyZXkKCgo+Cj4+IEFuZHJleQo+Pgo+Pgo+Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
