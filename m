Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1C5C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 15:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D9F611BF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 15:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D9F611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 312656E1E8;
	Tue, 22 Jun 2021 15:29:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C916E1E8;
 Tue, 22 Jun 2021 15:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElPPwxi0R5Q+6c2XAjso2Y1dllFwiTXaRqcVr8zwJ+0OxDVtuHnRKJDkVdO3SDdf31RyUvwM7xOlfTbbXlMdR1AzuzWdBEDlQ2NR3OyxQ7fDqA1AEqBS19JV6Dgb+6KUmz5XvBDJ4zeRtDoZL6ShCnQX56LO6niGg2JAD4dx8NXGrQbkewd8qGkUOZy/Tb6OIXiF9vt/Ii8glsT1iv3C+1r8mOpbei5mBVnyWM8n1XXVaQNHdx4TTQnuJfOCrDvXpPMO6CO5Ja82rSLQdooRNz0Cs/unwCC9SXyREQB0ZLbToFoJOJBWu9drrEhqGZhDciVb4WDUdrGy4ZMfBQoS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knjqMiy9X5NYSpNKZ3d+soIwHzNGU/oF0zuTMPQMTmo=;
 b=gpZUHURkkbvvWKihwxt0To61Fl21FMSHR6MOZgI/0BD9EcIE+lXP9bxq39HGr3H27xZNY+8FVkX9l5CAOGlb3fHZUWZAU24c6tjt1uqJWmmBAUqhdqxy2xvQgTiOCyMf9yzCV1/p9/pWReGTZex6l2OwX7Jro3cHKdxPlipekpEPH2xx1LF01ATAmz2/rY57+xfd30c+5WElOPXa4wznoe4+OKJTFIQxHjfuXPt2Y9U8iIvxWifEkDfGsQSenkn6RgD4JY67cTu5Lm7Y9iG2t8EYBQEM3Zr2WY3SuUuDUVtvU74wpHSEThYp5flgj1LLzuRGZL5BUEc6CjIgkwXczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knjqMiy9X5NYSpNKZ3d+soIwHzNGU/oF0zuTMPQMTmo=;
 b=Jc+TOv0C5BjyJ+7tvwLSrFy0rn3sjqtZBIV0UT+fVJC7o68XEr2J7z3pHor0pk1aD7nsFZ2ItD0Z1KTjhlrQpNiuHQSqt3E5UANiFebPdv9mSDcUW1YbJ7WNBKEK+Kj04mwXuGbIcgAPPc8qODAYMB3H13BZrBIHvuer3j6mGF4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 15:29:07 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4242.024; Tue, 22 Jun 2021
 15:29:07 +0000
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20210621141217.GE1096940@ziepe.ca>
 <CAFCwf10KvCh0zfHEHqYR-Na6KJh4j+9i-6+==QaMdHHpLH1yEA@mail.gmail.com>
 <20210621175511.GI1096940@ziepe.ca>
 <CAKMK7uEO1_B59DtM7N2g7kkH7pYtLM_WAkn+0f3FU3ps=XEjZQ@mail.gmail.com>
 <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca>
 <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
 <20210622120142.GL1096940@ziepe.ca>
 <d497b0a2-897e-adff-295c-cf0f4ff93cb4@amd.com>
 <20210622152343.GO1096940@ziepe.ca>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3fabe8b7-7174-bf49-5ffe-26db30968a27@amd.com>
Date: Tue, 22 Jun 2021 17:29:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210622152343.GO1096940@ziepe.ca>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:9dfd:8ca7:7f8d:67e4]
X-ClientProxiedBy: AM0PR06CA0104.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::45) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:9dfd:8ca7:7f8d:67e4]
 (2a02:908:1252:fb60:9dfd:8ca7:7f8d:67e4) by
 AM0PR06CA0104.eurprd06.prod.outlook.com (2603:10a6:208:fa::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 15:29:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 457a4ebd-ca5a-46e4-6e2e-08d93592797e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4237B65BACC81CA72B04FAA683099@MN2PR12MB4237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9hxBR8zSqFRP15CeAapWHmg4ugt3PSfU1WBl5rClu1bgoUtndC/9QNMJ5X+HwSw234Ubw8nnUr59u8aHcFC9VK7wVBvdqH7CNM8gPHDgvHckDOCtpLaJ8o7M6vUvctaYbAqLuo52GlDayPrBYW3M5Hhhd4YTFMvo8W1RnH9UN9w7PcAtJJ6JvQ7JyJSQcr51+ElSJYHhnNJNdITnl7ChtA0fy4flm1IXV7SZsW4X//JJCyPJPenVtssAxhnm1shHp9amVv43F6bTNtUfhGCOai1f8/6OXFe5W6FFZ9TD4uxqzsAlhxNfHHzOkO8DJPcwMerqb70fYAIDa1xQ3DjRmtwAhy04A1hWYdG3IpEyeOMSVnnFhfkOQ9b8NWMmEHUNIPJ3lxiDFVgy/i1VJvR/6gT0uMoC1CxoXxp5kJBryFNNzeLQr/5HVJn8wQIbNuaI4kRv5A2t2+dqxjV08B+y1Prm+n8/qxK6yeJH5UEVKO35KHJRnKUv1PkDJe5pYVSfOsfUISFAuynC/BqBoj/gGnggBfW3WRBVO9luAgiNIszav/pHhFpt2KT9rKd2pzVbkPqTMrhZIXJR/Sild2J/vcbuvha4Wmz4JQ7rDeY7/R4pEDbwqh//qycHcsWrM/+UP6D209Hbqwso8YKnjRh/7sGotLpTRaj09dc6BTQvsZv0BpT0ipkWvqMNT9vJSXqd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(66946007)(53546011)(16526019)(7416002)(66476007)(66556008)(186003)(83380400001)(8676002)(31686004)(86362001)(316002)(54906003)(6666004)(8936002)(478600001)(36756003)(6486002)(6916009)(2616005)(2906002)(31696002)(66574015)(38100700002)(5660300002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUxMbFhYMUNaRE1CTllXdG9WdVhBdnVLNXVkRWR4dUNGWHI5aUY1bE1taUV0?=
 =?utf-8?B?eWJHZUtkYXJGMGd0ejB0NCtiL0NCT1NoZnpZeHdaWER4TUl1SjZSZlpWMUV2?=
 =?utf-8?B?QkhYRk9VU0N2NzJGQ3c4WUJOV2ljMXlJMm1JejR6TXl6bThYT2tORFdpYWZW?=
 =?utf-8?B?RlBoa3lwbStvK3dGMGRaaW5uM2pYTUhHVHVnaWdheUlxbzV5Q2lxRW5rZUF3?=
 =?utf-8?B?ODlLeUNaeldxdlpjU3UvamRTblZtK1ZHU0tWTTJlRWlOQm9mWm5vN1ZyTkY4?=
 =?utf-8?B?OXRkTTZzLzJ3OURpNnZGUUpVdTJNeFJtOGhGOGVLZW9LNEJNNGlKMWcxN3pn?=
 =?utf-8?B?V2xGWGVkNEVSYzZTY0o0REpjUUN5ZlAyTUQrdWJ5V2xaUGcvK0tiV0U2UjQz?=
 =?utf-8?B?K3Y2blVyN0trY0NURTdFMGw1Z2RXV0N3NTNEdEYwdTBrMXB2SHpRT2k0VGFU?=
 =?utf-8?B?Umc5eFBNWlFTZW1ST1V2L2k1RnRvMnlzeGdkUTRvc0xaZXgrQUZOSkt1OTFs?=
 =?utf-8?B?UGZpdS9wM01lTVgvcGlqNUJZL2RPbkFDYzlQWENNZVZmOGVGOENlQ2RKLzk4?=
 =?utf-8?B?UXFwbjBIQVBvUlJJNjkvZXNEZHlTNldVeU9VS0JGMnhoeGZ0QWhFWng1NElu?=
 =?utf-8?B?VkRDUGsvd1pUblMrRnhFUVR2MDY1SEFacjFILzZFVnV0eE01OGNzSFBka096?=
 =?utf-8?B?ZjI0bWdnSWRUVzBnUWZCMDNsa2tzMnRScXFWLzZVYWs2eTdwVldjOEFkakVZ?=
 =?utf-8?B?RXNkUkZydVh3QmZxcjUzaEQ2UlpTVm1GQWhWVkIyTUcxY3VzQWp0RG0xcEpW?=
 =?utf-8?B?MUl5aHNLSWlrano3UjBLaHlTYUdnYVNmSVd5djgvMHJlYWd5Zm56VDY3NkMz?=
 =?utf-8?B?Nkg0WDByR25pS1NnMlpmcmFMYllFcnNNZFVtRVZwSjBwWmY5d0VWL3BxR3hi?=
 =?utf-8?B?QzNBN3pUNDJxZFBPQWFSbWE1N1JwUHNzaVRPTGovY2gzSG5KU3BIbVp6cXQv?=
 =?utf-8?B?RHloUmlnS2pRSFk2NUdrcjBoKzM1NnFyZm8vZkhOMmp0SkFqQ0tKakRLRUhp?=
 =?utf-8?B?c1JrV3o1bEszZmFLdk5pTmxtL2lHYWFqWXZ6ODBvUXdnS3F4bmZIbjJESThS?=
 =?utf-8?B?dXl2VzJDRjBaTTEzVHd1R2NjMmxtMlIrdGQ1S1pTckYybjhYdmdmNGNCbUhk?=
 =?utf-8?B?RSsraWkvejl0d09lTWU0eGNhS1Fud0pGREtHeUZKQkVVeTErTTcxTkhCV0Fo?=
 =?utf-8?B?anJMbzNUTnhrNWtuVjkxbFUrOVpSejFhZ0FKaHNOb2t5WnQvTnc4dzFUdGdB?=
 =?utf-8?B?Lzd1bDVxVFE3YVMzWWFjN3JUcXJtdk1lWDRPc0hjUGNnZytmVVI5UnVNWnpn?=
 =?utf-8?B?Ukt6UGFRWjJ0UnFjak01bHhFQ3FyYWdKckx6SzFxaHpXRmQzbjV4NjZmdVYz?=
 =?utf-8?B?K3N0UjRwcUt0Ym55YzRaVkVSY3E0amYrOVFGV1Uydy9zZGl5cUk4MU10Ukx6?=
 =?utf-8?B?cVRSU0hodnFDNVFKM3Q3eXZGdmVscE1ITDFWOWdObnZZZnlGUHB1QW9RK3pY?=
 =?utf-8?B?eTNSMzRiU2U4aXQ3dVFkbU5vdHVYU3NnVmtOZ205MnIxcnc5enJOaWVrdGdH?=
 =?utf-8?B?N2xWdjZwWmFiLy9JUkd5eGU0NXpBeTdBUXVhTGI3K1BBdE94MThyT1c3cEdt?=
 =?utf-8?B?NkxJOWhNN2VTWUoxcFQwd2dVZVBlc1JrNGVMT1MxZml6SVZUN3MxUGFPNzg4?=
 =?utf-8?B?VmR5TDhQVzVTOU1yUUw1amlJSFR1b0lCbTNlRzU3bWdrZXJ3NzVBbC85cDVD?=
 =?utf-8?B?Y0RQdlMzMk5ObWQrK0NKalNWWlFjZ3JqM1hvZ2cybjdTcEo2Y2hwaWJMOWFY?=
 =?utf-8?Q?/9QjJDBsCmygP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457a4ebd-ca5a-46e4-6e2e-08d93592797e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 15:29:07.1370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gydCSsQr8MUAcX4Y9s8pY9s3oZXDEl5phA3m7Cpx3mLZKPUe4oLpICM3QR0zDd5J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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
Cc: Oded Gabbay <oded.gabbay@gmail.com>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 sleybo@amazon.com, Gal Pressman <galpress@amazon.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Doug Ledford <dledford@redhat.com>, Tomer Tayar <ttayar@habana.ai>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Greg KH <gregkh@linuxfoundation.org>, Alex Deucher <alexander.deucher@amd.com>,
 Leon Romanovsky <leonro@nvidia.com>, Oded Gabbay <ogabbay@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjIuMDYuMjEgdW0gMTc6MjMgc2NocmllYiBKYXNvbiBHdW50aG9ycGU6Cj4gT24gVHVlLCBK
dW4gMjIsIDIwMjEgYXQgMDI6MjM6MDNQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToK
Pj4gQW0gMjIuMDYuMjEgdW0gMTQ6MDEgc2NocmllYiBKYXNvbiBHdW50aG9ycGU6Cj4+PiBPbiBU
dWUsIEp1biAyMiwgMjAyMSBhdCAxMTo0MjoyN0FNICswMzAwLCBPZGVkIEdhYmJheSB3cm90ZToK
Pj4+PiBPbiBUdWUsIEp1biAyMiwgMjAyMSBhdCA5OjM3IEFNIENocmlzdGlhbiBLw7ZuaWcKPj4+
PiA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Pj4+PiBBbSAyMi4w
Ni4yMSB1bSAwMToyOSBzY2hyaWViIEphc29uIEd1bnRob3JwZToKPj4+Pj4+IE9uIE1vbiwgSnVu
IDIxLCAyMDIxIGF0IDEwOjI0OjE2UE0gKzAzMDAsIE9kZWQgR2FiYmF5IHdyb3RlOgo+Pj4+Pj4K
Pj4+Pj4+PiBBbm90aGVyIHRoaW5nIEkgd2FudCB0byBlbXBoYXNpemUgaXMgdGhhdCB3ZSBhcmUg
ZG9pbmcgcDJwIG9ubHkKPj4+Pj4+PiB0aHJvdWdoIHRoZSBleHBvcnQvaW1wb3J0IG9mIHRoZSBG
RC4gV2UgZG8gKm5vdCogYWxsb3cgdGhlIHVzZXIgdG8KPj4+Pj4+PiBtbWFwIHRoZSBkbWEtYnVm
IGFzIHdlIGRvIG5vdCBzdXBwb3J0IGRpcmVjdCBJTy4gU28gdGhlcmUgaXMgbm8gYWNjZXNzCj4+
Pj4+Pj4gdG8gdGhlc2UgcGFnZXMgdGhyb3VnaCB0aGUgdXNlcnNwYWNlLgo+Pj4+Pj4gQXJndWFi
bHkgbW1hcGluZyB0aGUgbWVtb3J5IGlzIGEgYmV0dGVyIGNob2ljZSwgYW5kIGlzIHRoZSBkaXJl
Y3Rpb24KPj4+Pj4+IHRoYXQgTG9nYW4ncyBzZXJpZXMgZ29lcyBpbi4gSGVyZSB0aGUgdXNlIG9m
IERNQUJVRiB3YXMgc3BlY2lmaWNhbGx5Cj4+Pj4+PiBkZXNpZ25lZCB0byBhbGxvdyBoaXRsZXNz
IHJldm9rYXRpb24gb2YgdGhlIG1lbW9yeSwgd2hpY2ggdGhpcyBpc24ndAo+Pj4+Pj4gZXZlbiB1
c2luZy4KPj4+Pj4gVGhlIG1ham9yIHByb2JsZW0gd2l0aCB0aGlzIGFwcHJvYWNoIGlzIHRoYXQg
RE1BLWJ1ZiBpcyBhbHNvIHVzZWQgZm9yCj4+Pj4+IG1lbW9yeSB3aGljaCBpc24ndCBDUFUgYWNj
ZXNzaWJsZS4KPj4+IFRoYXQgaXNuJ3QgYW4gaXNzdWUgaGVyZSBiZWNhdXNlIHRoZSBtZW1vcnkg
aXMgb25seSBpbnRlbmRlZCB0byBiZQo+Pj4gdXNlZCB3aXRoIFAyUCB0cmFuc2ZlcnMgc28gaXQg
bXVzdCBiZSBDUFUgYWNjZXNzaWJsZS4KPj4gTm8sIGVzcGVjaWFsbHkgUDJQIGlzIG9mdGVuIGRv
bmUgb24gbWVtb3J5IHJlc291cmNlcyB3aGljaCBhcmUgbm90IGV2ZW4KPj4gcmVtb3RlbHkgQ1BV
IGFjY2Vzc2libGUuCj4gVGhhdCBpcyBhIHNwZWNpYWwgQU1EIHRoaW5nLCBQMlAgaGVyZSBpcyBQ
Q0kgUDJQIGFuZCBhbGwgUENJIG1lbW9yeSBpcwo+IENQVSBhY2Nlc3NpYmxlLgoKTm8gYWJzb2x1
dGVseSBub3QuIE5WaWRpYSBHUFVzIHdvcmsgZXhhY3RseSB0aGUgc2FtZSB3YXkuCgpBbmQgeW91
IGhhdmUgdG9ucyBvZiBzaW1pbGFyIGNhc2VzIGluIGVtYmVkZGVkIGFuZCBTb0Mgc3lzdGVtcyB3
aGVyZSAKaW50ZXJtZWRpYXRlIG1lbW9yeSBiZXR3ZWVuIGRldmljZXMgaXNuJ3QgZGlyZWN0bHkg
YWRkcmVzc2FibGUgd2l0aCB0aGUgQ1BVLgoKPj4+Pj4+IFNvIHlvdSBhcmUgdGFraW5nIHRoZSBo
aXQgb2YgdmVyeSBsaW1pdGVkIGhhcmR3YXJlIHN1cHBvcnQgYW5kIHJlZHVjZWQKPj4+Pj4+IHBl
cmZvcm1hbmNlIGp1c3QgdG8gc3F1ZWV6ZSBpbnRvIERNQUJVRi4uCj4+PiBZb3Ugc3RpbGwgaGF2
ZSB0aGUgaXNzdWUgdGhhdCB0aGlzIHBhdGNoIGlzIGRvaW5nIGFsbCBvZiB0aGlzIFAyUAo+Pj4g
c3R1ZmYgd3JvbmcgLSBmb2xsb3dpbmcgdGhlIGFscmVhZHkgTkFLJ2QgQU1EIGFwcHJvYWNoLgo+
PiBXZWxsIHRoYXQgc3R1ZmYgd2FzIE5BS2VkIGJlY2F1c2Ugd2Ugc3RpbGwgdXNlIHNnX3RhYmxl
cywgbm90IGJlY2F1c2Ugd2UKPj4gZG9uJ3Qgd2FudCB0byBhbGxvY2F0ZSBzdHJ1Y3QgcGFnZXMu
Cj4gc2cgbGlzdHMgaW4gZ2VuZXJhbC4KPiAgIAo+PiBUaGUgcGxhbiBpcyB0byBwdXNoIHRoaXMg
Zm9yd2FyZCBzaW5jZSBERVZJQ0VfUFJJVkFURSBjbGVhcmx5IGNhbid0IGhhbmRsZQo+PiBhbGwg
b2Ygb3VyIHVzZSBjYXNlcyBhbmQgaXMgbm90IHJlYWxseSBhIGdvb2QgZml0IHRvIGJlIGhvbmVz
dC4KPj4KPj4gSU9NTVUgaXMgbm93IHdvcmtpbmcgYXMgd2VsbCwgc28gYXMgZmFyIGFzIEkgY2Fu
IHNlZSB3ZSBhcmUgYWxsIGdvb2QgaGVyZS4KPiBIb3c/IElzIHRoYXQgbW9yZSBBTUQgc3BlY2lh
bCBzdHVmZj8KCk5vLCBqdXN0IHVzaW5nIHRoZSBkbWFfbWFwX3Jlc291cmNlKCkgaW50ZXJmYWNl
LgoKV2UgaGF2ZSB0aGF0IHdvcmtpbmcgb24gdG9ucyBvZiBJT01NVSBlbmFibGVkIHN5c3RlbXMu
Cgo+IFRoaXMgcGF0Y2ggc2VyaWVzIG5ldmVyIGNhbGxzIHRvIHRoZSBpb21tdSBkcml2ZXIsIEFG
QUlDVC4KPgo+Pj4+IEknbGwgZ28gYW5kIHJlYWQgTG9nYW4ncyBwYXRjaC1zZXQgdG8gc2VlIGlm
IHRoYXQgd2lsbCB3b3JrIGZvciB1cyBpbgo+Pj4+IHRoZSBmdXR1cmUuIFBsZWFzZSByZW1lbWJl
ciwgYXMgRGFuaWVsIHNhaWQsIHdlIGRvbid0IGhhdmUgc3RydWN0IHBhZ2UKPj4+PiBiYWNraW5n
IG91ciBkZXZpY2UgbWVtb3J5LCBzbyBpZiB0aGF0IGlzIGEgcmVxdWlyZW1lbnQgdG8gY29ubmVj
dCB0bwo+Pj4+IExvZ2FuJ3Mgd29yaywgdGhlbiBJIGRvbid0IHRoaW5rIHdlIHdpbGwgd2FudCB0
byBkbyBpdCBhdCB0aGlzIHBvaW50Lgo+Pj4gSXQgaXMgdHJpdmlhbCB0byBnZXQgdGhlIHN0cnVj
dCBwYWdlIGZvciBhIFBDSSBCQVIuCj4+IFllYWgsIGJ1dCBpdCBkb2Vzbid0IG1ha2UgbXVjaCBz
ZW5zZS4gV2h5IHNob3VsZCB3ZSBjcmVhdGUgYSBzdHJ1Y3QgcGFnZSBmb3IKPj4gc29tZXRoaW5n
IHRoYXQgaXNuJ3QgZXZlbiBtZW1vcnkgaW4gYSBsb3Qgb2YgY2FzZXM/Cj4gQmVjYXVzZSB0aGUg
aW9tbXUgYW5kIG90aGVyIHBsYWNlcyBuZWVkIHRoaXMgaGFuZGxlIHRvIHNldHVwIHRoZWlyCj4g
c3R1ZmYuIE5vYm9keSBoYXMgeWV0IGJlZW4gYnJhdmUgZW5vdWdoIHRvIHRyeSB0byBjaGFuZ2Ug
dGhvc2UgZmxvd3MKPiB0byBiZSBhYmxlIHRvIHVzZSBhIHBoeXNpY2FsIENQVSBhZGRyZXNzLgoK
V2VsbCB0aGF0IGlzIGNlcnRhaW5seSBub3QgdHJ1ZS4gSSdtIGp1c3Qgbm90IHN1cmUgaWYgdGhh
dCB3b3JrcyB3aXRoIAphbGwgSU9NTVUgZHJpdmVycyB0aG91Z2h0LgoKV291bGQgbmVlZCB0byBw
aW5nIEZlbGl4IHdoZW4gdGhlIHN1cHBvcnQgZm9yIHRoaXMgd2FzIG1lcmdlZC4KClJlZ2FyZHMs
CkNocmlzdGlhbi4KCj4KPiBUaGlzIGlzIHdoeSB3ZSBoYXZlIGEgc3BlY2lhbCBzdHJ1Y3QgcGFn
ZSB0eXBlIGp1c3QgZm9yIFBDSSBCQVIKPiBtZW1vcnkuCj4KPiBKYXNvbgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
