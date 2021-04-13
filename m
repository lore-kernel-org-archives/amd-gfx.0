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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5322C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 15:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37C3613B6
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 15:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37C3613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FE1B6E7DD;
	Tue, 13 Apr 2021 15:12:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C2E6E7DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 15:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgaPpTO2kRA28mJlRjwb2vQoDIv+sxWQue0lUjsjpE6ZLjkxgHzifT6Yv2mvevIZeqHaBw/YrPrQwdQ6RPWohY7K13FQtZGH3oflYp9cF/Ulxwy5el6BduQtmsOhEKKgPr2qg8AZbchhVEvwDEN+MH3UTyRQbmtSiUnjcBfu193yfM1kar2t/8kSqvmbAxQN2nYEBE5wbcVDSYTGgFOzt5tU3kkcVc7pToBO8JVI72bmF2v/5OJ3Bhwonvn+5SdEgCv7qt41VGl4Ge/ipneXGlF1nq2rGbh/euTpMCePPPspctVXjdWGrEiS+Av479bbZ9XdSyjZlEPbqrG+lBgiSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2/b0tdVsTfJUIpdbSWtKIY/Jar3XqYuJH3y1SfIuUI=;
 b=Hbk4Jn4465E75msKlk8+aw1+PpQqobisRjiElZeNwcs46rAkKf1z2CEMgAKy5P1RG4yyeK6kPfDDtCwg88pqujJeS/i6npX2i37qr1l89PiLniD1xPMW/T0NJS2QOesxzay2d0UYQe2EYG9N542Rb2mZqWO5OG2yN+zJdn5kuwbm3kCBjX3W5Om28W5ugjZwdueSFhlKKyDt0qDjOhLWOQv4blZxbc7uDCkHYLurRCWum5NCRM8piLheFUpi3g5EG+D8G26YfVeqDZkh7nKm39sVvRZP/jJNUxYmj6h65hcysS7ggzowBvG2xWFDYqGhy569XcM8BW6z8ab1hlEaMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2/b0tdVsTfJUIpdbSWtKIY/Jar3XqYuJH3y1SfIuUI=;
 b=DSQ4NsB95+zK2DE7mHP4981bqBXw0l5fSMQkQINbruL/Uq1UOJ4mc4U0WDWUkKFsmq3ycqgZtDju7QduzbqixWBQXRw/jrG1puYHRtV6XHGVTLZfOew4V72qJ1WPNkztWmsSn9eHWAAbU5/KZt1uFugQk5YrjCRDkw7dai2ywrU=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 15:12:34 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 15:12:34 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
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
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <ae02bdf3-8f4b-ed38-b62d-c3b606554a59@amd.com>
Date: Tue, 13 Apr 2021 11:12:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <9b9e84ca-b259-b683-ef9d-1f9be95e1734@gmail.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:9da9:a38:3558:d1d1]
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:9da9:a38:3558:d1d1]
 (2607:fea8:3edf:49b0:9da9:a38:3558:d1d1) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Tue, 13 Apr 2021 15:12:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01da810d-6cc6-4be1-b65a-08d8fe8e9102
X-MS-TrafficTypeDiagnostic: SN6PR12MB4720:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB472053383BC9385FBE3FB795EA4F9@SN6PR12MB4720.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upykafX/U/KCH5XVM38KfXUx4vaTrYrKvztDID/6FMEmqRxlw29WPEIbQw6CKrl/dgepIBLDB1ssFzS2pbvMsXYS80aUAfoY4L4gmuDNSMC9duA8k5Pfw9vBG2xaNf1bmRE/aJSCE4+UQI0A04xdp7KRiVrgpkDmP/GNzXH8DpIWcF98rfYMeG/bmWhQj8zIYOSGb0SqVDUt6s8KE4uL1gv0N38HXE/dZiul78wgNl6rDdwMwEHVhWmKbr63sVbqF3q0JbthhH8tUo3LpHRONcAX3HPfZby1PfzdaHWOMv3ExsqBckhXdOiTcCSY2CkBT3BzcJk13YWHMS6xoJ1X4gPuwm2KwVG9eA/9RR/iij5/kvTkOa2w6X9FFRXNc+g2+k09fXVT6qK1+QDTzsd2ipnGqLFRBDJ9a6hL6nBThC+EDOULfy4nH3eGKPdo0SXEMRfUf/x3RUqD57W/Sh4scIeplVYKvy/kK3ixKJPkFFnfUBISKnW6Z/buwOEV7bo2iEUxBxaaZqGj6uxbTTxHsXo+ET67eOQJRathwGAib/OtelpQRCllksg0LK4xWh2LyEXNnORMf5kxwyA/EsMlJgNTGqoj3X6yq9ikVxRxuVgr5QlgbS7CMLEEuX697qEuTZSIwMCWEXYORJ5Ck2TPjsWDamq2g8JUJ4mksBoMARLboJutgtR96glt8mBkg/7Gf8jVEzjoocIn7CyCDJ1Ap2KKqN4h1e68QpwXLlRAXBaHOKey85FlCd/QSEaGkkxk2WKLwdGHITjUb++gdRcOQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(376002)(346002)(366004)(136003)(5660300002)(36756003)(110136005)(45080400002)(16526019)(186003)(31696002)(66574015)(52116002)(66556008)(66476007)(83380400001)(44832011)(8676002)(2616005)(66946007)(53546011)(316002)(8936002)(86362001)(31686004)(6486002)(921005)(966005)(478600001)(38100700002)(2906002)(60764002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MHJsbCtoOW9WaUNBRGJQR2x6N2tVNnFFSGNTOFhOSkt1NU1LSEV4MzRjTkN6?=
 =?utf-8?B?Uk1BZ2FpUDV1cDJXa015ekl6V2VlLzNVbG40cDQ2QzkxWGlZR1R5Z2hiT3pi?=
 =?utf-8?B?SWlMRjhYYkhDQUowcEpYTi9aMEtBSDJsL0hzTnVUK0tRcVlLTXJ4aS9PSG9D?=
 =?utf-8?B?RnhUcGM3U0s5YktGMmNsTGEzOFhMdTllR3pKV001Z1RXTGtyWFpQTU5nRmhz?=
 =?utf-8?B?QlVuSUhXVGVRT1BBNDREZ2RnalkwM3NwZC8yNFhnMWhUaFZUWjE0WjU2eElp?=
 =?utf-8?B?NWxIN0JFR0o4d2tpMUY0MmpoZHFGdE52QVFhSnlQQWRSSGZHd1Z3M2JkY1Zi?=
 =?utf-8?B?SmNHNENrMWFWNnVFUlI5eDFjdUtDUDlJUlhnQmZkRFRDdEs5VHMvcjB2YVEv?=
 =?utf-8?B?bFREeWR6S0gzRHZFaU1XY1dDcHg4YWxtVGVFcTk3T1JQVXowMVArK2dlWFpW?=
 =?utf-8?B?ZzgyZ0tWb2pVS2RBTTdiTys1SGdPbXk4dlNqbFZzTFVsM0NGQjRmOTMvRGlu?=
 =?utf-8?B?M2N1Nm8wMXhGUkd4cG1QWlEzZ0ZraSs5dzNuTjlQL0hnM1E3V2VxZE5LRWt6?=
 =?utf-8?B?Wmd6dURWUlRNbVZBT1RDdGJwdFNnbGxraEJmZnVlS0p0ektRYktzTjVvQ2JP?=
 =?utf-8?B?TkFscU8ycE96T3oyTlNZMmxaNzd5KzNyQ2g3OU9YdkExN1ZXTGNpZWl0b2sr?=
 =?utf-8?B?NWpCOGdsaXJoTmZVY1IrR241OEYxcDFPMVg3T2RLWWxNejdmbkJoemdmczZo?=
 =?utf-8?B?a1hzbFFMMW5pK2RVUjBRVEV1L2t2aGpnWFVVOE53RjFXVGZ0L0FrOUYvdk5o?=
 =?utf-8?B?bTlWVk0rUmkyNVRZMlZEL2hZQlp3TlRDb0xvemZDTHgxWDdnQmFVb0tJOHQ4?=
 =?utf-8?B?dmhnSDByZUdUVHZnYllsalkwcHpxN1B4aWtiK2pZQ21TSks5cUdDSjR2NWRL?=
 =?utf-8?B?K3U0c0ZtZUozc3AvUWJvdmhsT1RYb3ZkSnA5UjM3NHNFQUJrL0YxVEtMTFVU?=
 =?utf-8?B?cDRua1RsdnFtL0d4azZFSEdOak9MV29iL2d6MGR4dWdBenVPL29YMFRWZ0po?=
 =?utf-8?B?bDNoWHpnWUhxWGVWay9rUzY3aVBwRTRRbmh1MkJkZmdiaURJN3VicnIvRkxN?=
 =?utf-8?B?RkNJbkZQVDRBS3RvWkd2NjRrK2grWXZWeVZhRWRldlR2RUxLdnFRTGFRc0Fs?=
 =?utf-8?B?TytXODQxVzdhVnFBd1VTbSt5QVZMazd0OEptWWpLUkNuUy9oNVBUQkcyM3hh?=
 =?utf-8?B?NnZaMjg2OEV6a3BBeWpKTzRIM3IvNExFdmtwU3h2M0d0WEtGdkVJSXRILzlT?=
 =?utf-8?B?Ry9McnVKNStEdTd2TnYxVktsVlJhZjR2bzYrdURzVVlDU0dMSFlQSGNua1Fl?=
 =?utf-8?B?UCtCK0NRT3UrcDBybEJHQzAwOUY4RjFiYXpiWjF6ZnF1SDkweEgzUGcrMEVY?=
 =?utf-8?B?OGdjc1BTRlUxcVZUcHJaWE0vVUZobUlva1ZIeENmaENUTXBaaDJ3SFExUGxI?=
 =?utf-8?B?QWFpRUMzS21VMG0vNVRFUmEzTlhiTzQ2RXhiVnFEeUo1a2pyNlk3eGZqa2Fr?=
 =?utf-8?B?QzluZ1c1K2V5ZXdVajBWTHhVTDVUZG14SzR0bk5NckxBZTB2dTZTcm8rZHFH?=
 =?utf-8?B?K0tNdHIvSXRObGVvdkJjaTFUa1daenFRNVFVbVN4NVovM0xIQlNKZ2tSMkh4?=
 =?utf-8?B?UjZtaDduK25Oc2J4cWFtdng4WHcxNE0vQWduNUpiZGt5QTUzUUR2T0R0UFlT?=
 =?utf-8?B?RUwxUVlLLzNRMXpyenZnWHp3QW5HZWJPSmd6YlpNbDkxWTVocWVFVFcwa3ZE?=
 =?utf-8?B?OHdlSTI1QkR3eTI2VEV0UUxXWkhpU1N0UFpiTWtFZGZiUWloM0p3N0QvRHVY?=
 =?utf-8?Q?54Zmo2gKRcv0Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01da810d-6cc6-4be1-b65a-08d8fe8e9102
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 15:12:34.6999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+tdWkpEZTp4O1n0Zd5AfyF04JpFBOwzgBca3HkZ4zGx3/sMGoxQMi3waHkHOzPcNue8FgJQKW4GltXCraC7+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4720
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

Ck9uIDIwMjEtMDQtMTMgMzoxMCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDEy
LjA0LjIxIHVtIDIyOjAxIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Cj4+IE9uIDIwMjEt
MDQtMTIgMzoxOCBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMTIuMDQuMjEg
dW0gMjE6MTIgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+PiBbU05JUF0KPj4+Pj4+Cj4+
Pj4+PiBTbyB3aGF0J3MgdGhlIHJpZ2h0IGFwcHJvYWNoID8gSG93IHdlIGd1YXJhbnRlZSB0aGF0
IHdoZW4gcnVubmluZyAKPj4+Pj4+IGFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlv
biB3ZSB3aWxsIHNpZ25hbCBhbGwgdGhlIEhXIAo+Pj4+Pj4gZmVuY2VzIGFuZCBub3QgcmFjaW5n
IGFnYWluc3Qgc29tZSBtb3JlIGZlbmNlcyBpbnNlcnRpb24gaW50byAKPj4+Pj4+IHRoYXQgYXJy
YXkgPwo+Pj4+Pj4KPj4+Pj4KPj4+Pj4gV2VsbCBJIHdvdWxkIHN0aWxsIHNheSB0aGUgYmVzdCBh
cHByb2FjaCB3b3VsZCBiZSB0byBpbnNlcnQgdGhpcyAKPj4+Pj4gYmV0d2VlbiB0aGUgZnJvbnQg
ZW5kIGFuZCB0aGUgYmFja2VuZCBhbmQgbm90IHJlbHkgb24gc2lnbmFsaW5nIAo+Pj4+PiBmZW5j
ZXMgd2hpbGUgaG9sZGluZyB0aGUgZGV2aWNlIHNyY3UuCj4+Pj4KPj4+Pgo+Pj4+IE15IHF1ZXN0
aW9uIGlzLCBldmVuIG5vdywgd2hlbiB3ZSBydW4gCj4+Pj4gYW1kZ3B1X2ZlbmNlX2RyaXZlcl9m
aW5pX2h3LT5hbWRncHVfZmVuY2Vfd2FpdF9lbXB0eSBvciAKPj4+PiBhbWRncHVfZmVuY2VfZHJp
dmVyX2ZpbmlfaHctPmFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbiwgCj4+Pj4g
d2hhdCB0aGVyZSBwcmV2ZW50cyBhIHJhY2Ugd2l0aCBhbm90aGVyIGZlbmNlIGJlaW5nIGF0IHRo
ZSBzYW1lIAo+Pj4+IHRpbWUgZW1pdHRlZCBhbmQgaW5zZXJ0ZWQgaW50byB0aGUgZmVuY2UgYXJy
YXkgPyBMb29rcyBsaWtlIG5vdGhpbmcuCj4+Pj4KPj4+Cj4+PiBFYWNoIHJpbmcgY2FuIG9ubHkg
YmUgdXNlZCBieSBvbmUgdGhyZWFkIGF0IHRoZSBzYW1lIHRpbWUsIHRoaXMgCj4+PiBpbmNsdWRl
cyBlbWl0dGluZyBmZW5jZXMgYXMgd2VsbCBhcyBvdGhlciBzdHVmZi4KPj4+Cj4+PiBEdXJpbmcg
R1BVIHJlc2V0IHdlIG1ha2Ugc3VyZSBub2JvZHkgd3JpdGVzIHRvIHRoZSByaW5ncyBieSBzdG9w
cGluZyAKPj4+IHRoZSBzY2hlZHVsZXIgYW5kIHRha2luZyB0aGUgR1BVIHJlc2V0IGxvY2sgKHNv
IHRoYXQgbm9ib2R5IGVsc2UgY2FuIAo+Pj4gc3RhcnQgdGhlIHNjaGVkdWxlciBhZ2FpbikuCj4+
Cj4+Cj4+IFdoYXQgYWJvdXQgZGlyZWN0IHN1Ym1pc3Npb25zIG5vdCB0aHJvdWdoIHNjaGVkdWxl
ciAtIAo+PiBhbWRncHVfam9iX3N1Ym1pdF9kaXJlY3QsIEkgZG9uJ3Qgc2VlIGhvdyB0aGlzIGlz
IHByb3RlY3RlZC4KPgo+IFRob3NlIG9ubHkgaGFwcGVuIGR1cmluZyBzdGFydHVwIGFuZCBHUFUg
cmVzZXQuCgoKT2ssIGJ1dCB0aGVuIGxvb2tzIGxpa2UgSSBhbSBtaXNzaW5nIHNvbWV0aGluZywg
c2VlIHRoZSBmb2xsb3dpbmcgc3RlcHMgCmluIGFtZGdwdV9wY2lfcmVtb3ZlIC0KCjEpIFVzZSBk
aXNhYmxlX2lycSBBUEkgZnVuY3Rpb24gdG8gc3RvcCBhbmQgZmx1c2ggYWxsIGluIGZsaWdodCBI
VyAKaW50ZXJydXB0cyBoYW5kbGVycwoKMikgR3JhYiB0aGUgcmVzZXQgbG9jayBhbmQgc3RvcCBh
bGwgdGhlIHNjaGVkdWxlcnMKCkFmdGVyIGFib3ZlIDIgc3RlcHMgdGhlIEhXIGZlbmNlcyBhcnJh
eSBpcyBpZGxlLCBubyBtb3JlIGluc2VydGlvbnMgYW5kIApubyBtb3JlIGV4dHJhY3Rpb25zIGZy
b20gdGhlIGFycmF5CgozKSBSdW4gb25lIHRpbWUgYW1kZ3B1X2ZlbmNlX3Byb2Nlc3MgdG8gc2ln
bmFsIGFsbCBjdXJyZW50IEhXIGZlbmNlcwoKNCkgU2V0IGRybV9kZXZfdW5wbHVnICh3aWxsICdm
bHVzaCcgYWxsIGluIGZsaWdodCBJT0NUTHMpLCByZWxlYXNlIHRoZSAKR1BVIHJlc2V0IGxvY2sg
YW5kIGdvIG9uIHdpdGggdGhlIHJlc3Qgb2YgdGhlIHNlcXVlbmNlIChjYW5jZWwgdGltZXJzLCAK
d29yayBpdGVtcyBlLnQuYykKCldoYXQncyBwcm9ibGVtYXRpYyBpbiB0aGlzIHNlcXVlbmNlID8K
CkFuZHJleQoKCj4KPgo+Pj4KPj4+Pj4KPj4+Pj4gQlRXOiBDb3VsZCBpdCBiZSB0aGF0IHRoZSBk
ZXZpY2UgU1JDVSBwcm90ZWN0cyBtb3JlIHRoYW4gb25lIAo+Pj4+PiBkZXZpY2UgYW5kIHdlIGRl
YWRsb2NrIGJlY2F1c2Ugb2YgdGhpcz8KPj4+Pgo+Pj4+Cj4+Pj4gSSBoYXZlbid0IGFjdHVhbGx5
IGV4cGVyaWVuY2VkIGFueSBkZWFkbG9jayB1bnRpbCBub3cgYnV0LCB5ZXMsIAo+Pj4+IGRybV91
bnBsdWdfc3JjdSBpcyBkZWZpbmVkIGFzIHN0YXRpYyBpbiBkcm1fZHJ2LmMgYW5kIHNvIGluIHRo
ZSAKPj4+PiBwcmVzZW5jZcKgIG9mIG11bHRpcGxlIGRldmljZXMgZnJvbSBzYW1lIG9yIGRpZmZl
cmVudCBkcml2ZXJzIHdlIGluIAo+Pj4+IGZhY3QgYXJlIGRlcGVuZGVudCBvbiBhbGwgdGhlaXIg
Y3JpdGljYWwgc2VjdGlvbnMgaSBndWVzcy4KPj4+Pgo+Pj4KPj4+IFNoaXQsIHllYWggdGhlIGRl
dmlsIGlzIGEgc3F1aXJyZWwuIFNvIGZvciBBK0kgbGFwdG9wcyB3ZSBhY3R1YWxseSAKPj4+IG5l
ZWQgdG8gc3luYyB0aGF0IHVwIHdpdGggRGFuaWVsIGFuZCB0aGUgcmVzdCBvZiB0aGUgaTkxNSBn
dXlzLgo+Pj4KPj4+IElJUkMgd2UgY291bGQgYWN0dWFsbHkgaGF2ZSBhbiBhbWRncHUgZGV2aWNl
IGluIGEgZG9ja2luZyBzdGF0aW9uIAo+Pj4gd2hpY2ggbmVlZHMgaG90cGx1ZyBhbmQgdGhlIGRy
aXZlciBtaWdodCBkZXBlbmQgb24gd2FpdGluZyBmb3IgdGhlIAo+Pj4gaTkxNSBkcml2ZXIgYXMg
d2VsbC4KPj4KPj4KPj4gQ2FuJ3Qgd2UgcHJvcG9zZSBhIHBhdGNoIHRvIG1ha2UgZHJtX3VucGx1
Z19zcmN1IHBlciBkcm1fZGV2aWNlID8gSSAKPj4gZG9uJ3Qgc2VlIHdoeSBpdCBoYXMgdG8gYmUg
Z2xvYmFsIGFuZCBub3QgcGVyIGRldmljZSB0aGluZy4KPgo+IEknbSByZWFsbHkgd29uZGVyaW5n
IHRoZSBzYW1lIHRoaW5nIGZvciBxdWl0ZSBhIHdoaWxlIG5vdy4KPgo+IEFkZGluZyBEYW5pZWwg
YXMgd2VsbCwgbWF5YmUgaGUga25vd3Mgd2h5IHRoZSBkcm1fdW5wbHVnX3NyY3UgaXMgZ2xvYmFs
Lgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KPj4KPj4gQW5kcmV5Cj4+Cj4+Cj4+Pgo+Pj4g
Q2hyaXN0aWFuLgo+Pj4KPj4+PiBBbmRyZXkKPj4+Pgo+Pj4+Cj4+Pj4+Cj4+Pj4+IENocmlzdGlh
bi4KPj4+Pj4KPj4+Pj4+IEFuZHJleQo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+Pj4gQW5k
cmV5Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+PiDCoMKgwqAgLyogUGFzdCB0aGlzIHBvaW50IG5vIG1vcmUgZmVuY2Ug
YXJlIHN1Ym1pdHRlZCB0byBIVyByaW5nIAo+Pj4+Pj4+Pj4+IGFuZCBoZW5jZSB3ZSBjYW4gc2Fm
ZWx5IGNhbGwgZm9yY2Ugc2lnbmFsIG9uIGFsbCB0aGF0IGFyZSAKPj4+Pj4+Pj4+PiBjdXJyZW50
bHkgdGhlcmUuCj4+Pj4+Pj4+Pj4gwqDCoMKgwqAgKiBBbnkgc3Vic2VxdWVudGx5IGNyZWF0ZWTC
oCBIVyBmZW5jZXMgd2lsbCBiZSByZXR1cm5lZCAKPj4+Pj4+Pj4+PiBzaWduYWxlZCB3aXRoIGFu
IGVycm9yIGNvZGUgcmlnaHQgYXdheQo+Pj4+Pj4+Pj4+IMKgwqDCoMKgICovCj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+PiDCoMKgwqAgZm9yX2VhY2hfcmluZyhhZGV2KQo+Pj4+Pj4+Pj4+IMKgwqDCoCDC
oMKgwqAgYW1kZ3B1X2ZlbmNlX3Byb2Nlc3MocmluZykKPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IMKg
wqDCoCBkcm1fZGV2X3VucGx1ZyhkZXYpOwo+Pj4+Pj4+Pj4+IMKgwqDCoCBTdG9wIHNjaGVkdWxl
cnMKPj4+Pj4+Pj4+PiDCoMKgwqAgY2FuY2VsX3N5bmMoYWxsIHRpbWVycyBhbmQgcXVldWVkIHdv
cmtzKTsKPj4+Pj4+Pj4+PiDCoMKgwqAgaHdfZmluaQo+Pj4+Pj4+Pj4+IMKgwqDCoCB1bm1hcF9t
bWlvCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiB9Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4gQWx0ZXJuYXRpdmVs
eSBncmFiYmluZyB0aGUgcmVzZXQgd3JpdGUgc2lkZSBhbmQgc3RvcHBpbmcgCj4+Pj4+Pj4+Pj4+
Pj4+PiBhbmQgdGhlbiByZXN0YXJ0aW5nIHRoZSBzY2hlZHVsZXIgY291bGQgd29yayBhcyB3ZWxs
Lgo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4gSSBkaWRuJ3QgZ2V0IHRoZSBhYm92ZSBh
bmQgSSBkb24ndCBzZWUgd2h5IEkgbmVlZCB0byAKPj4+Pj4+Pj4+Pj4+Pj4gcmV1c2UgdGhlIEdQ
VSByZXNldCByd19sb2NrLiBJIHJlbHkgb24gdGhlIFNSQ1UgdW5wbHVnIAo+Pj4+Pj4+Pj4+Pj4+
PiBmbGFnIGZvciB1bnBsdWcuIEFsc28sIG5vdCBjbGVhciB0byBtZSB3aHkgYXJlIHdlIAo+Pj4+
Pj4+Pj4+Pj4+PiBmb2N1c2luZyBvbiB0aGUgc2NoZWR1bGVyIHRocmVhZHMsIGFueSBjb2RlIHBh
dGNoIHRvIAo+Pj4+Pj4+Pj4+Pj4+PiBnZW5lcmF0ZSBIVyBmZW5jZXMgc2hvdWxkIGJlIGNvdmVy
ZWQsIHNvIGFueSBjb2RlIGxlYWRpbmcgCj4+Pj4+Pj4+Pj4+Pj4+IHRvIGFtZGdwdV9mZW5jZV9l
bWl0IG5lZWRzIHRvIGJlIHRha2VuIGludG8gYWNjb3VudCBzdWNoIAo+Pj4+Pj4+Pj4+Pj4+PiBh
cywgZGlyZWN0IElCIHN1Ym1pc3Npb25zLCBWTSBmbHVzaGVzIGUudC5jCj4+Pj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4+PiBZb3UgbmVlZCB0byB3b3JrIHRvZ2V0aGVyIHdpdGggdGhlIHJlc2V0IGxv
Y2sgYW55d2F5LCAKPj4+Pj4+Pj4+Pj4+PiBjYXVzZSBhIGhvdHBsdWcgY291bGQgcnVuIGF0IHRo
ZSBzYW1lIHRpbWUgYXMgYSByZXNldC4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4gRm9yIGdvaW5nIG15IHdheSBpbmRlZWQgbm93IEkgc2VlIG5vdyB0aGF0IEkgaGF2ZSB0
byB0YWtlIAo+Pj4+Pj4+Pj4+Pj4gcmVzZXQgd3JpdGUgc2lkZSBsb2NrIGR1cmluZyBIVyBmZW5j
ZXMgc2lnbmFsbGluZyBpbiBvcmRlciAKPj4+Pj4+Pj4+Pj4+IHRvIHByb3RlY3QgYWdhaW5zdCBz
Y2hlZHVsZXIvSFcgZmVuY2VzIGRldGFjaG1lbnQgYW5kIAo+Pj4+Pj4+Pj4+Pj4gcmVhdHRhY2ht
ZW50IGR1cmluZyBzY2hlZHVsZXJzIHN0b3AvcmVzdGFydC4gQnV0IGlmIHdlIGdvIAo+Pj4+Pj4+
Pj4+Pj4gd2l0aCB5b3VyIGFwcHJvYWNowqAgdGhlbiBjYWxsaW5nIGRybV9kZXZfdW5wbHVnIGFu
ZCBzY29waW5nIAo+Pj4+Pj4+Pj4+Pj4gYW1kZ3B1X2pvYl90aW1lb3V0IHdpdGggZHJtX2Rldl9l
bnRlci9leGl0IHNob3VsZCBiZSBlbm91Z2ggCj4+Pj4+Pj4+Pj4+PiB0byBwcmV2ZW50IGFueSBj
b25jdXJyZW50IEdQVSByZXNldHMgZHVyaW5nIHVucGx1Zy4gSW4gZmFjdCAKPj4+Pj4+Pj4+Pj4+
IEkgYWxyZWFkeSBkbyBpdCBhbnl3YXkgLSAKPj4+Pj4+Pj4+Pj4+IGh0dHBzOi8vbmFtMTEuc2Fm
ZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwczolMkYlMkZjZ2l0LmZyZWVk
ZXNrdG9wLm9yZyUyRn5hZ3JvZHpvdiUyRmxpbnV4JTJGY29tbWl0JTJGJTNGaCUzRGRybS1taXNj
LW5leHQlMjZpZCUzRGVmMGVhNGRkMjllZjQ0ZDI2NDljNWVkYTE2YzhmNDg2OWFjYzM2YjEmYW1w
O2RhdGE9MDQlN0MwMSU3Q2FuZHJleS5ncm9kem92c2t5JTQwYW1kLmNvbSU3Q2M3ZmM2Y2I1MDVj
MzRhZWRmZTZkMDhkOGZlNGIzOTQ3JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2Ql
N0MwJTdDMCU3QzYzNzUzODk0NjMyNDg1NzM2OSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpX
SWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZN
bjAlM0QlN0MxMDAwJmFtcDtzZGF0YT02NDM2MlBSQzh4VGdSMlVqMlIyNTZiTWVnVm04WVdxMUtJ
JTJCQWp6ZVlYdjQlM0QmYW1wO3Jlc2VydmVkPTAKPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gWWVz
LCBnb29kIHBvaW50IGFzIHdlbGwuCj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IENocmlzdGlhbi4K
Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+PiBD
aHJpc3RpYW4uCj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4gQW5k
cmV5Cj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+
PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Cj4+Pgo+Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
