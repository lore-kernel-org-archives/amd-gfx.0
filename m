Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F46C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 18:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91155613BD
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 18:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91155613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F786E2C7;
	Tue, 13 Apr 2021 18:25:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA0EE6E2C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 18:25:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWT4aIKFzIijOtmGKzLhXDNcUApzD70jBr6Mz1B5cuL5Ofk8p7yX6Dc9WO92FD9Lpy2ieI+9DWsWl0D8Fvu93+Ibs7TW4ky/01JmijWTF2O/iq7A0wPFGCZDqqtXyPtKQSJBo0UtvDmcgwOmynxuKkQjSfC2XAIVDy5OrMEXi912Zm0Z/00kWsXJ6A1eU+TzoyJYUk7MNNleiXZvv36AGY2t0xe95MO0nTXArMFlS4NfxT1NpPKQIF+sZBd1XsnKDocB9N7jAy9rr0fcljiAhPakX2EzN8M+tkOWkUZYcjXL+0+5YQu3cK6VIgPrE79c+8er2BIOy1d177+fD5LpOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5mSf+bYpsuw3RvpQz25y6MrhxVplqXL8sEOOs5a0FY=;
 b=OySQVxKZFnOR21Cygp2t2ZjzYW0XyXbya7HPArEjxnc96ollX/LVVEe2yGf/DIcT3bDZf2nbxnYJc14tYlqX2JGG1uQ/mgvQk0C2n52AOa/2PjRwCE2zTwlesUIWA5HWL+EomErRbwbgXZ6LCR9yQEcJf96ymUYZcnUyZE6s4pdUcIGWuVdU1lMejZYnOaDGjmtLpyoizftrvFgitnEpyUurIG5bJSqE/3kMrZpfdB65opmXWmvhTxuTRLvfZoYFmwq3Uu4qMfaQadid6NUY5qt3Q4JAing+etlckG+CK7ljw4lDlfEt7WKyeJ7d6BJcuSRRTQR2shYGtFlcY7zkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5mSf+bYpsuw3RvpQz25y6MrhxVplqXL8sEOOs5a0FY=;
 b=o2c95NELzCJdpGvZSPx6Ncv2bLgiRX+aCm2P9evke0tZga5PlciO4XoAwEfMG7fVensr/VCE8LSE6aP35n9XVqarGrXK6841s+rZmX5mOWn2kW4Gp6qT8wav42lTz4HXX+/JbeigXnouMFxdvXgrX8/CdrXHiycwCZ7J9UOfEqE=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2515.namprd12.prod.outlook.com (2603:10b6:207:40::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 18:25:14 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 18:25:14 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
 <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
 <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
 <0224d3c2-1bd0-3941-fa7f-5667027368fa@amd.com>
 <a92e8f96-029f-6d21-4430-7e3116c21dea@amd.com>
 <9ea8f0c1-8d58-f4ab-e2a9-1ef8fd00718c@amd.com>
 <9b9e84ca-b259-b683-ef9d-1f9be95e1734@gmail.com>
 <ae02bdf3-8f4b-ed38-b62d-c3b606554a59@amd.com>
 <8b2db19a-d5f9-a7e3-6662-b990b7b3db2f@amd.com>
 <0fe87232-08ec-d804-ff55-2716b8e09c12@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e37d6954-46e7-e7eb-22c3-a5b19829fe6c@amd.com>
Date: Tue, 13 Apr 2021 20:25:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <0fe87232-08ec-d804-ff55-2716b8e09c12@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:68fb:3c11:fcc3:c883]
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:68fb:3c11:fcc3:c883]
 (2a02:908:1252:fb60:68fb:3c11:fcc3:c883) by
 AM8P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 18:25:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c09b12f-3e71-4a72-8f94-08d8fea97b1f
X-MS-TrafficTypeDiagnostic: BL0PR12MB2515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB251511F84F211FCBCF864A70834F9@BL0PR12MB2515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2l9PFr6xdA58ELkt1CweDcL7uF9FM6WM6N7XgAh0z/CD2yRD9Hns+T/HcYPyi55jbNGkvA1qPB/GmCOIUDR/KhLqZZxT7XdNAStojk+Tx0uZXn5p5MLDCzXwgEzBcCBA8QFV66RWBJ+V3wHFD4sk8wfEr8a439fTw4YECdptiEpdVuoyFmWJQJY7Ql2xu8jcGC/4aDUjLA/awFp7IZw4ll7H47WzlBgW77GgMxNmJvSA2i8K+0e7g3tv1JqY6OfXZUVx+XiZ2lrUaARe6u/ZmHrRBiDptym33rr0zp2hw0J7CGUgdtVrCNZqzQiDTHCv0+oro5eFv2HvBqQ8CjCpv5uCG+xTiFdIxtrhCu9jQ+D2MxtT4F7DctyKQ7L2LLnnX4TZ1m3qSwzcQl2KynSzn5EcC2k8D43F77X4VqnywQW7LDOpXIm5LWQhstgSYAiMYG5dcip2SyCEpWqzjS60ugKHfvuYmfPp2hEf/JygK4w/7gMwc0aSvxp4vvukn6UvCftLlXwAGCsYN1cGoNHdrdFNoYhnf2tS26vGazTksYsCWgZRhe40iMb+Oa8vZIBbBttU2GxPBdiJH2ILNWRLxTB5LuDr86OfV2Q/m+3gMhR9djjvHCCpHiY6+KPIszLeIxtDIWbUt2jKMGcHnBJgYfjGYREc35p9ScutCuRqql1XwHicCE87Al1Juo9J7UB/6btuwDcE8x8SnV4wvtt+nyGPujUQ9Tob8giuhIxu7g2fk6yROM+NArmqJyU3Q0jfVAJWRrY4wYeGpya/Ncvww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(366004)(346002)(396003)(136003)(376002)(86362001)(36756003)(966005)(16526019)(45080400002)(478600001)(31696002)(6486002)(66946007)(6666004)(83380400001)(2616005)(52116002)(8676002)(2906002)(110136005)(53546011)(66556008)(38100700002)(66574015)(921005)(186003)(66476007)(31686004)(5660300002)(316002)(8936002)(60764002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UTdsVlg3YUFjUUkzejk0TUwxZ2I1eGUrSStCNVN6VTJBcHp5TWRFN0JWUDZu?=
 =?utf-8?B?UitCdTNKUHErWGZ5cU53RGppM3ZkL3lYVkpLNnlWeHVKaWtGN1RNcjlOVVdW?=
 =?utf-8?B?azVra3NwTnFvTEo2MzJTNFdVMTdsWmhJcUxYN2xtVENqL0FxRXZWaVB2dGRO?=
 =?utf-8?B?M0o4NDV4NGtSRU5TMGxQcDJ4OXQ3bzI0T2pQa0NIbHVZdWw4MFVjaTUwbWd0?=
 =?utf-8?B?R2xvSHN5aW9CemNiRzliSENiRGEyWkpSZGRBZ252WXRudDVhaWNrdkZrVHZz?=
 =?utf-8?B?Vzg1dExFTkF3TVFBM1IzV1JLa2hVU1Z6VlVUMmRRWmN5N2RNWk5NMHBWb2J1?=
 =?utf-8?B?Sjk5MG9qQzU4Mm9lNENuWGFyWEk2N1Brb0QvMXpBRHcvaFVGRG50M3o2VVRh?=
 =?utf-8?B?Wk8xVDA5ZldTMnFnQmpmR2g5dEFvWllybVdoREVoWU51TjRBZzBhWmFzc2hP?=
 =?utf-8?B?aVFkV2pQaE5oTDdwYmVBMjQ3TUdRdjMrR1diWThTeUN6S05Hd1FSNGtNS1U0?=
 =?utf-8?B?Z3ltVE82OHB2Qm1LRmVIemNVTWtud25zdWdQenQ2UnpyZGU1bkMzb05VbU9p?=
 =?utf-8?B?bWhDOVlUZDZsZmVxQ2NxSTVNRXc3ajVRd0Z6Wi9KbTUwWGc3OXlmSGhiVklr?=
 =?utf-8?B?M3lKMEY0djZMaUVCNjBDK3VITlFySm9ZZzVGbFhMTGdSY1FJME9WL092YnBI?=
 =?utf-8?B?SEJPWW9LRnVhMFdZQWVFcHEvZkNINk5lR3ZiZ295N0VFb2tLL3E1cjg2RXhI?=
 =?utf-8?B?bFRUVENYdGFIUk5IRmlER0ZEdkMzeXpFUTB1TVdJeWZqaDRQaDl4YWhiUUd5?=
 =?utf-8?B?SHU2cXpDYVBLYnZBejZDYXBFWFZPUi9meW1CS0UxNU8xWmtxMGE5dEU4NEQr?=
 =?utf-8?B?NHlFZFNDRDMwR0tsWnRoWHQzWXpHanFuMDVRenRxVzd3YUJ6S3E0V29sVWJZ?=
 =?utf-8?B?NkwwNVJtWmg1TnAyRGNsb0lyNFhKdnVQZGJLempOZ2JzSVpCRjVBN1ZpQllq?=
 =?utf-8?B?OWFoME1qcFRybkVsQ0hpcThCeHN3Y3FPRWhKRSsybDZNbGR1bUhMY0VMU1pl?=
 =?utf-8?B?TXVQTExGSmNCd0gyRURSR1ppT0d0ZWpjSVVtNzZrNE9rT3JjVWkyQnRuY3Qr?=
 =?utf-8?B?bjhDSXRWekg3OFZ3YUtIVmpTYkZ4a05obEM0d2N0Ym5YdUsrMHVySy9nRUI0?=
 =?utf-8?B?UXJ0QmZSUlJCN1ZGeTNBNklGUW0zcGVPcHh6WHdtcTVTMWxmK240TXRyNjU4?=
 =?utf-8?B?UDU2NDJVM0hQRExTTC9PQUxubkYwb3Q3UmFJYldUVzI1TzQxNUxudmRFSkhm?=
 =?utf-8?B?Wml6U0ZrZ1c0UisxRXpYVTd4MTBFaWR0bDlQSlZGMUVRQyttSlVrYTd1Q3hK?=
 =?utf-8?B?VlZGa1pWc2ZZd3QxWHoyTEZod1lraGROd2l5S2l4TllPRE90Qzd6WEVkRDVT?=
 =?utf-8?B?aEJvbHFsbWl3TnZpb2ZkT0JsZFJ3VDhZdjlxNmlnUnBOR21lcVpzd0l2TC9V?=
 =?utf-8?B?OCt3di8zU1FLNVVMeklzWU52QkZXYThDbVVIUS9zY3ZyYjdkSFI1ZHhBeHNO?=
 =?utf-8?B?SDNOWkRyVzMzNk4zQnRtZFFpWmZLUVNuamxzdUE3cXdiYXVyN21qeVVtdlZZ?=
 =?utf-8?B?MmkwNXBFQlVjUUF4ekFjT1g5VTBBclFDa2FyVnlTTEFwZlhIUUsxZ3RCejFQ?=
 =?utf-8?B?d2tIWk5ueU1vY09PQUF1aktPTzgrQXI2K21KZjU0U1BFc252bHJ1elpreU9R?=
 =?utf-8?B?SlVyc05tb0N2UDFTMTRNWkpIdlNEMTRsNUYzS3MrRFp2eSt2aHZCRWJWbi81?=
 =?utf-8?B?N0I0cEliZXV2a3dLeW9aT0U3U3hsQVdKc2s1d2NjZ0RqQWZzOFR2aHNKRzlV?=
 =?utf-8?Q?icp2IdNBys9W1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c09b12f-3e71-4a72-8f94-08d8fea97b1f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 18:25:14.2968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rfkypzmc5NSCIa4aXsJ970eH+8EuT1Xh0n7uXJemiroEnSDLCvBnJOJG/tUGfBm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2515
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

CgpBbSAxMy4wNC4yMSB1bSAyMDoxOCBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Cj4gT24g
MjAyMS0wNC0xMyAyOjAzIHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDEzLjA0
LjIxIHVtIDE3OjEyIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Pgo+Pj4gT24gMjAyMS0w
NC0xMyAzOjEwIGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4gQW0gMTIuMDQuMjEg
dW0gMjI6MDEgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+Pj4KPj4+Pj4gT24gMjAyMS0w
NC0xMiAzOjE4IHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4+PiBBbSAxMi4wNC4y
MSB1bSAyMToxMiBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4+Pj4+IFtTTklQXQo+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+IFNvIHdoYXQncyB0aGUgcmlnaHQgYXBwcm9hY2ggPyBIb3cgd2UgZ3Vh
cmFudGVlIHRoYXQgd2hlbiAKPj4+Pj4+Pj4+IHJ1bm5pbmcgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9m
b3JjZV9jb21wbGV0aW9uIHdlIHdpbGwgc2lnbmFsIAo+Pj4+Pj4+Pj4gYWxsIHRoZSBIVyBmZW5j
ZXMgYW5kIG5vdCByYWNpbmcgYWdhaW5zdCBzb21lIG1vcmUgZmVuY2VzIAo+Pj4+Pj4+Pj4gaW5z
ZXJ0aW9uIGludG8gdGhhdCBhcnJheSA/Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBXZWxs
IEkgd291bGQgc3RpbGwgc2F5IHRoZSBiZXN0IGFwcHJvYWNoIHdvdWxkIGJlIHRvIGluc2VydCAK
Pj4+Pj4+Pj4gdGhpcyBiZXR3ZWVuIHRoZSBmcm9udCBlbmQgYW5kIHRoZSBiYWNrZW5kIGFuZCBu
b3QgcmVseSBvbiAKPj4+Pj4+Pj4gc2lnbmFsaW5nIGZlbmNlcyB3aGlsZSBob2xkaW5nIHRoZSBk
ZXZpY2Ugc3JjdS4KPj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4gTXkgcXVlc3Rpb24gaXMsIGV2ZW4g
bm93LCB3aGVuIHdlIHJ1biAKPj4+Pj4+PiBhbWRncHVfZmVuY2VfZHJpdmVyX2ZpbmlfaHctPmFt
ZGdwdV9mZW5jZV93YWl0X2VtcHR5IG9yIAo+Pj4+Pj4+IGFtZGdwdV9mZW5jZV9kcml2ZXJfZmlu
aV9ody0+YW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uLCAKPj4+Pj4+PiB3aGF0
IHRoZXJlIHByZXZlbnRzIGEgcmFjZSB3aXRoIGFub3RoZXIgZmVuY2UgYmVpbmcgYXQgdGhlIHNh
bWUgCj4+Pj4+Pj4gdGltZSBlbWl0dGVkIGFuZCBpbnNlcnRlZCBpbnRvIHRoZSBmZW5jZSBhcnJh
eSA/IExvb2tzIGxpa2UgCj4+Pj4+Pj4gbm90aGluZy4KPj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IEVh
Y2ggcmluZyBjYW4gb25seSBiZSB1c2VkIGJ5IG9uZSB0aHJlYWQgYXQgdGhlIHNhbWUgdGltZSwg
dGhpcyAKPj4+Pj4+IGluY2x1ZGVzIGVtaXR0aW5nIGZlbmNlcyBhcyB3ZWxsIGFzIG90aGVyIHN0
dWZmLgo+Pj4+Pj4KPj4+Pj4+IER1cmluZyBHUFUgcmVzZXQgd2UgbWFrZSBzdXJlIG5vYm9keSB3
cml0ZXMgdG8gdGhlIHJpbmdzIGJ5IAo+Pj4+Pj4gc3RvcHBpbmcgdGhlIHNjaGVkdWxlciBhbmQg
dGFraW5nIHRoZSBHUFUgcmVzZXQgbG9jayAoc28gdGhhdCAKPj4+Pj4+IG5vYm9keSBlbHNlIGNh
biBzdGFydCB0aGUgc2NoZWR1bGVyIGFnYWluKS4KPj4+Pj4KPj4+Pj4KPj4+Pj4gV2hhdCBhYm91
dCBkaXJlY3Qgc3VibWlzc2lvbnMgbm90IHRocm91Z2ggc2NoZWR1bGVyIC0gCj4+Pj4+IGFtZGdw
dV9qb2Jfc3VibWl0X2RpcmVjdCwgSSBkb24ndCBzZWUgaG93IHRoaXMgaXMgcHJvdGVjdGVkLgo+
Pj4+Cj4+Pj4gVGhvc2Ugb25seSBoYXBwZW4gZHVyaW5nIHN0YXJ0dXAgYW5kIEdQVSByZXNldC4K
Pj4+Cj4+Pgo+Pj4gT2ssIGJ1dCB0aGVuIGxvb2tzIGxpa2UgSSBhbSBtaXNzaW5nIHNvbWV0aGlu
Zywgc2VlIHRoZSBmb2xsb3dpbmcgCj4+PiBzdGVwcyBpbiBhbWRncHVfcGNpX3JlbW92ZSAtCj4+
Pgo+Pj4gMSkgVXNlIGRpc2FibGVfaXJxIEFQSSBmdW5jdGlvbiB0byBzdG9wIGFuZCBmbHVzaCBh
bGwgaW4gZmxpZ2h0IEhXIAo+Pj4gaW50ZXJydXB0cyBoYW5kbGVycwo+Pj4KPj4+IDIpIEdyYWIg
dGhlIHJlc2V0IGxvY2sgYW5kIHN0b3AgYWxsIHRoZSBzY2hlZHVsZXJzCj4+Pgo+Pj4gQWZ0ZXIg
YWJvdmUgMiBzdGVwcyB0aGUgSFcgZmVuY2VzIGFycmF5IGlzIGlkbGUsIG5vIG1vcmUgaW5zZXJ0
aW9ucyAKPj4+IGFuZCBubyBtb3JlIGV4dHJhY3Rpb25zIGZyb20gdGhlIGFycmF5Cj4+Pgo+Pj4g
MykgUnVuIG9uZSB0aW1lIGFtZGdwdV9mZW5jZV9wcm9jZXNzIHRvIHNpZ25hbCBhbGwgY3VycmVu
dCBIVyBmZW5jZXMKPj4+Cj4+PiA0KSBTZXQgZHJtX2Rldl91bnBsdWcgKHdpbGwgJ2ZsdXNoJyBh
bGwgaW4gZmxpZ2h0IElPQ1RMcyksIHJlbGVhc2UgCj4+PiB0aGUgR1BVIHJlc2V0IGxvY2sgYW5k
IGdvIG9uIHdpdGggdGhlIHJlc3Qgb2YgdGhlIHNlcXVlbmNlIChjYW5jZWwgCj4+PiB0aW1lcnMs
IHdvcmsgaXRlbXMgZS50LmMpCj4+Pgo+Pj4gV2hhdCdzIHByb2JsZW1hdGljIGluIHRoaXMgc2Vx
dWVuY2UgPwo+Pgo+PiBkcm1fZGV2X3VucGx1ZygpIHdpbGwgd2FpdCBmb3IgdGhlIElPQ1RMcyB0
byBmaW5pc2guCj4+Cj4+IFRoZSBJT0NUTHMgaW4gdHVybiBjYW4gd2FpdCBmb3IgZmVuY2VzLiBU
aGF0IGNhbiBiZSBib3RoIGhhcmR3YXJlIAo+PiBmZW5jZXMsIHNjaGVkdWxlciBmZW5jZXMsIGFz
IHdlbGwgYXMgZmVuY2VzIGZyb20gb3RoZXIgZGV2aWNlcyAoYW5kIAo+PiBLSVEgZmVuY2VzIGZv
ciByZWdpc3RlciB3cml0ZXMgdW5kZXIgU1JJT1YsIGJ1dCB3ZSBjYW4gaG9wZWZ1bGx5IAo+PiBp
Z25vcmUgdGhlbSBmb3Igbm93KS4KPj4KPj4gV2UgaGF2ZSBoYW5kbGVkIHRoZSBoYXJkd2FyZSBm
ZW5jZXMsIGJ1dCB3ZSBoYXZlIG5vIGlkZWEgd2hlbiB0aGUgCj4+IHNjaGVkdWxlciBmZW5jZXMg
b3IgdGhlIGZlbmNlcyBmcm9tIG90aGVyIGRldmljZXMgd2lsbCBzaWduYWwuCj4+Cj4+IFNjaGVk
dWxlciBmZW5jZXMgd29uJ3Qgc2lnbmFsIHVudGlsIHRoZSBzY2hlZHVsZXIgdGhyZWFkcyBhcmUg
Cj4+IHJlc3RhcnRlZCBvciB3ZSBzb21laG93IGNhbmNlbCB0aGUgc3VibWlzc2lvbnMuIERvYWJs
ZSwgYnV0IHRyaWNreSBhcyAKPj4gd2VsbC4KPgo+Cj4gRm9yIHNjaGVkdWxlciBmZW5jZXMgSSBh
bSBub3Qgd29ycmllZCwgZm9yIHRoZSBzY2hlZF9mZW5jZS0+ZmluaXNoZWQgCj4gZmVuY2UgdGhl
eSBhcmUgYnkgZGVmaW5pdGlvbiBhdHRhY2hlZCB0byBIVyBmZW5jZXMgd2hpY2ggYWxyZWFkeSAK
PiBzaWduYWxlZGZvciBzY2hlZF9mZW5jZS0+c2NoZWR1bGVkIHdlIHNob3VsZCBydW4gCj4gZHJt
X3NjaGVkX2VudGl0eV9raWxsX2pvYnMgZm9yIGVhY2ggZW50aXR5IGFmdGVyIHN0b3BwaW5nIHRo
ZSAKPiBzY2hlZHVsZXIgdGhyZWFkcyBhbmQgYmVmb3JlIHNldHRpbmcgZHJtX2Rldl91bnBsdWcu
CgpXZWxsIGV4YWN0bHkgdGhhdCBpcyB3aGF0IGlzIHRyaWNreSBoZXJlLiBkcm1fc2NoZWRfZW50
aXR5X2tpbGxfam9icygpIAphc3N1bWVzIHRoYXQgdGhlcmUgYXJlIG5vIG1vcmUgam9icyBwdXNo
ZWQgaW50byB0aGUgZW50aXR5LgoKV2UgYXJlIHJhY2luZyBoZXJlIG9uY2UgbW9yZSBhbmQgbmVl
ZCB0byBoYW5kbGUgdGhhdC4KCj4+Cj4+IEZvciB3YWl0aW5nIGZvciBvdGhlciBkZXZpY2UgSSBo
YXZlIG5vIGlkZWEgaWYgdGhhdCBjb3VsZG4ndCBkZWFkbG9jayAKPj4gc29tZWhvdy4KPgo+Cj4g
WWVhLCBub3Qgc3VyZSBmb3IgaW1wb3J0ZWQgZmVuY2VzIGFuZCBkbWFfYnVmcywgSSB3b3VsZCBh
c3N1bWUgdGhlIAo+IG90aGVyIGRldmljZXMgc2hvdWxkIG5vdCBiZSBpbXBhY3RlZCBieSBvdXIg
ZGV2aWNlIHJlbW92YWwgYnV0LCB3aG8gCj4ga25vd3MuLi4KPgo+IFNvIEkgZ3Vlc3Mgd2UgYXJl
IE5PVCBnb2luZyB3aXRoIGZpbmFsaXppbmcgSFcgZmVuY2VzIGJlZm9yZSAKPiBkcm1fZGV2X3Vu
cGx1ZyBhbmQgaW5zdGVhZCB3aWxsIGp1c3QgY2FsbCBkcm1fZGV2X2VudGVyL2V4aXQgYXQgdGhl
IAo+IGJhY2stZW5kcyBhbGwgb3ZlciB0aGUgcGxhY2Ugd2hlcmUgdGhlcmUgYXJlIE1NSU8gYWNj
ZXNzZXMgPwoKR29vZCBxdWVzdGlvbi4gQXMgeW91IHNhaWQgdGhhdCBpcyByZWFsbHkgdGhlIGhh
cmQgcGF0aC4KCkhhbmRsaW5nIGl0IGFsbCBhdCBvbmNlIGF0IElPQ1RMIGxldmVsIGNlcnRhaW5s
eSBoYXMgc29tZSBhcHBlYWwgYXMgCndlbGwsIGJ1dCBJIGhhdmUgbm8gaWRlYSBpZiB3ZSBjYW4g
Z3VhcmFudGVlIHRoYXQgdGhpcyBpcyBsb2NrIGZyZWUuCgpDaHJpc3RpYW4uCgo+Cj4gQW5kcmV5
Cj4KPj4KPj4gUmVnYXJkcywKPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4KPj4+IEFuZHJleQo+Pj4KPj4+
Cj4+Pj4KPj4+Pgo+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gQlRXOiBDb3VsZCBpdCBiZSB0aGF0
IHRoZSBkZXZpY2UgU1JDVSBwcm90ZWN0cyBtb3JlIHRoYW4gb25lIAo+Pj4+Pj4+PiBkZXZpY2Ug
YW5kIHdlIGRlYWRsb2NrIGJlY2F1c2Ugb2YgdGhpcz8KPj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4g
SSBoYXZlbid0IGFjdHVhbGx5IGV4cGVyaWVuY2VkIGFueSBkZWFkbG9jayB1bnRpbCBub3cgYnV0
LCB5ZXMsIAo+Pj4+Pj4+IGRybV91bnBsdWdfc3JjdSBpcyBkZWZpbmVkIGFzIHN0YXRpYyBpbiBk
cm1fZHJ2LmMgYW5kIHNvIGluIHRoZSAKPj4+Pj4+PiBwcmVzZW5jZcKgIG9mIG11bHRpcGxlIGRl
dmljZXMgZnJvbSBzYW1lIG9yIGRpZmZlcmVudCBkcml2ZXJzIHdlIAo+Pj4+Pj4+IGluIGZhY3Qg
YXJlIGRlcGVuZGVudCBvbiBhbGwgdGhlaXIgY3JpdGljYWwgc2VjdGlvbnMgaSBndWVzcy4KPj4+
Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IFNoaXQsIHllYWggdGhlIGRldmlsIGlzIGEgc3F1aXJyZWwuIFNv
IGZvciBBK0kgbGFwdG9wcyB3ZSAKPj4+Pj4+IGFjdHVhbGx5IG5lZWQgdG8gc3luYyB0aGF0IHVw
IHdpdGggRGFuaWVsIGFuZCB0aGUgcmVzdCBvZiB0aGUgCj4+Pj4+PiBpOTE1IGd1eXMuCj4+Pj4+
Pgo+Pj4+Pj4gSUlSQyB3ZSBjb3VsZCBhY3R1YWxseSBoYXZlIGFuIGFtZGdwdSBkZXZpY2UgaW4g
YSBkb2NraW5nIHN0YXRpb24gCj4+Pj4+PiB3aGljaCBuZWVkcyBob3RwbHVnIGFuZCB0aGUgZHJp
dmVyIG1pZ2h0IGRlcGVuZCBvbiB3YWl0aW5nIGZvciAKPj4+Pj4+IHRoZSBpOTE1IGRyaXZlciBh
cyB3ZWxsLgo+Pj4+Pgo+Pj4+Pgo+Pj4+PiBDYW4ndCB3ZSBwcm9wb3NlIGEgcGF0Y2ggdG8gbWFr
ZSBkcm1fdW5wbHVnX3NyY3UgcGVyIGRybV9kZXZpY2UgPyAKPj4+Pj4gSSBkb24ndCBzZWUgd2h5
IGl0IGhhcyB0byBiZSBnbG9iYWwgYW5kIG5vdCBwZXIgZGV2aWNlIHRoaW5nLgo+Pj4+Cj4+Pj4g
SSdtIHJlYWxseSB3b25kZXJpbmcgdGhlIHNhbWUgdGhpbmcgZm9yIHF1aXRlIGEgd2hpbGUgbm93
Lgo+Pj4+Cj4+Pj4gQWRkaW5nIERhbmllbCBhcyB3ZWxsLCBtYXliZSBoZSBrbm93cyB3aHkgdGhl
IGRybV91bnBsdWdfc3JjdSBpcyAKPj4+PiBnbG9iYWwuCj4+Pj4KPj4+PiBSZWdhcmRzLAo+Pj4+
IENocmlzdGlhbi4KPj4+Pgo+Pj4+Pgo+Pj4+PiBBbmRyZXkKPj4+Pj4KPj4+Pj4KPj4+Pj4+Cj4+
Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pgo+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+
Pj4+Pj4KPj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoCAvKiBQYXN0IHRoaXMgcG9pbnQgbm8gbW9yZSBmZW5j
ZSBhcmUgc3VibWl0dGVkIHRvIEhXIAo+Pj4+Pj4+Pj4+Pj4+IHJpbmcgYW5kIGhlbmNlIHdlIGNh
biBzYWZlbHkgY2FsbCBmb3JjZSBzaWduYWwgb24gYWxsIHRoYXQgCj4+Pj4+Pj4+Pj4+Pj4gYXJl
IGN1cnJlbnRseSB0aGVyZS4KPj4+Pj4+Pj4+Pj4+PiDCoMKgwqDCoCAqIEFueSBzdWJzZXF1ZW50
bHkgY3JlYXRlZMKgIEhXIGZlbmNlcyB3aWxsIGJlIAo+Pj4+Pj4+Pj4+Pj4+IHJldHVybmVkIHNp
Z25hbGVkIHdpdGggYW4gZXJyb3IgY29kZSByaWdodCBhd2F5Cj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKg
wqAgKi8KPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoCBmb3JfZWFjaF9yaW5nKGFk
ZXYpCj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIMKgwqDCoCBhbWRncHVfZmVuY2VfcHJvY2VzcyhyaW5n
KQo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIGRybV9kZXZfdW5wbHVnKGRldik7
Cj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIFN0b3Agc2NoZWR1bGVycwo+Pj4+Pj4+Pj4+Pj4+IMKgwqDC
oCBjYW5jZWxfc3luYyhhbGwgdGltZXJzIGFuZCBxdWV1ZWQgd29ya3MpOwo+Pj4+Pj4+Pj4+Pj4+
IMKgwqDCoCBod19maW5pCj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIHVubWFwX21taW8KPj4+Pj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+IH0KPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+Pj4+Pj4+PiBBbHRlcm5hdGl2ZWx5IGdyYWJiaW5nIHRoZSByZXNldCB3cml0ZSBzaWRlIGFu
ZCAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHN0b3BwaW5nIGFuZCB0aGVuIHJlc3RhcnRpbmcgdGhlIHNj
aGVkdWxlciBjb3VsZCB3b3JrIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gYXMgd2VsbC4KPj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+IEkgZGlkbid0IGdldCB0aGUgYWJv
dmUgYW5kIEkgZG9uJ3Qgc2VlIHdoeSBJIG5lZWQgdG8gCj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHJldXNl
IHRoZSBHUFUgcmVzZXQgcndfbG9jay4gSSByZWx5IG9uIHRoZSBTUkNVIHVucGx1ZyAKPj4+Pj4+
Pj4+Pj4+Pj4+Pj4gZmxhZyBmb3IgdW5wbHVnLiBBbHNvLCBub3QgY2xlYXIgdG8gbWUgd2h5IGFy
ZSB3ZSAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4gZm9jdXNpbmcgb24gdGhlIHNjaGVkdWxlciB0aHJlYWRz
LCBhbnkgY29kZSBwYXRjaCB0byAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4gZ2VuZXJhdGUgSFcgZmVuY2Vz
IHNob3VsZCBiZSBjb3ZlcmVkLCBzbyBhbnkgY29kZSAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4gbGVhZGlu
ZyB0byBhbWRncHVfZmVuY2VfZW1pdCBuZWVkcyB0byBiZSB0YWtlbiBpbnRvIAo+Pj4+Pj4+Pj4+
Pj4+Pj4+PiBhY2NvdW50IHN1Y2ggYXMsIGRpcmVjdCBJQiBzdWJtaXNzaW9ucywgVk0gZmx1c2hl
cyBlLnQuYwo+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4gWW91IG5lZWQgdG8gd29y
ayB0b2dldGhlciB3aXRoIHRoZSByZXNldCBsb2NrIGFueXdheSwgCj4+Pj4+Pj4+Pj4+Pj4+Pj4g
Y2F1c2UgYSBob3RwbHVnIGNvdWxkIHJ1biBhdCB0aGUgc2FtZSB0aW1lIGFzIGEgcmVzZXQuCj4+
Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+IEZvciBnb2luZyBt
eSB3YXkgaW5kZWVkIG5vdyBJIHNlZSBub3cgdGhhdCBJIGhhdmUgdG8gCj4+Pj4+Pj4+Pj4+Pj4+
PiB0YWtlIHJlc2V0IHdyaXRlIHNpZGUgbG9jayBkdXJpbmcgSFcgZmVuY2VzIHNpZ25hbGxpbmcg
Cj4+Pj4+Pj4+Pj4+Pj4+PiBpbiBvcmRlciB0byBwcm90ZWN0IGFnYWluc3Qgc2NoZWR1bGVyL0hX
IGZlbmNlcyAKPj4+Pj4+Pj4+Pj4+Pj4+IGRldGFjaG1lbnQgYW5kIHJlYXR0YWNobWVudCBkdXJp
bmcgc2NoZWR1bGVycyAKPj4+Pj4+Pj4+Pj4+Pj4+IHN0b3AvcmVzdGFydC4gQnV0IGlmIHdlIGdv
IHdpdGggeW91ciBhcHByb2FjaMKgIHRoZW4gCj4+Pj4+Pj4+Pj4+Pj4+PiBjYWxsaW5nIGRybV9k
ZXZfdW5wbHVnIGFuZCBzY29waW5nIGFtZGdwdV9qb2JfdGltZW91dCAKPj4+Pj4+Pj4+Pj4+Pj4+
IHdpdGggZHJtX2Rldl9lbnRlci9leGl0IHNob3VsZCBiZSBlbm91Z2ggdG8gcHJldmVudCBhbnkg
Cj4+Pj4+Pj4+Pj4+Pj4+PiBjb25jdXJyZW50IEdQVSByZXNldHMgZHVyaW5nIHVucGx1Zy4gSW4g
ZmFjdCBJIGFscmVhZHkgCj4+Pj4+Pj4+Pj4+Pj4+PiBkbyBpdCBhbnl3YXkgLSAKPj4+Pj4+Pj4+
Pj4+Pj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwczolMkYlMkZjZ2l0LmZyZWVkZXNrdG9wLm9yZyUyRn5hZ3JvZHpvdiUyRmxpbnV4JTJG
Y29tbWl0JTJGJTNGaCUzRGRybS1taXNjLW5leHQlMjZpZCUzRGVmMGVhNGRkMjllZjQ0ZDI2NDlj
NWVkYTE2YzhmNDg2OWFjYzM2YjEmYW1wO2RhdGE9MDQlN0MwMSU3Q2FuZHJleS5ncm9kem92c2t5
JTQwYW1kLmNvbSU3Q2M3ZmM2Y2I1MDVjMzRhZWRmZTZkMDhkOGZlNGIzOTQ3JTdDM2RkODk2MWZl
NDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzUzODk0NjMyNDg1NzM2OSU3Q1Vu
a25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlM
Q0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT02NDM2MlBSQzh4
VGdSMlVqMlIyNTZiTWVnVm04WVdxMUtJJTJCQWp6ZVlYdjQlM0QmYW1wO3Jlc2VydmVkPTAgCj4+
Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+PiBZZXMsIGdvb2QgcG9p
bnQgYXMgd2VsbC4KPj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Cj4+Pj4KPj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
