Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E36DC11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 11:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197B161D03
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 11:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197B161D03
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAF8A6E859;
	Tue, 29 Jun 2021 11:15:58 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D6B06E859
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 11:15:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHzzkquoNs1uDQf+MiHzG81EZ7WbDkL3bXwR32RDDMVjb9Otuv1JFo1ST/8h0YCFk5aRmZt3D0VhbjP1Q7ir+1XpdCFLvXsVOMNKgdXuOFzZ8OG8/wsDj7qrqYIyOYKMYT7lvbb4V1rZRS+jyCUIm4rm3uqy+2Fau3NCbAMgr/5LZoBZlDJLOhjSRB3tfACLw8xw29VeOIjRSyt/v1b1QP8lLe8YzDVe5p5lfH4SaEwGvkW5TwONPJGNgS0UZMOf6G7wCRnFp3dVdJ9lS/SRT/R/dzRaIkPxGK/rFTejhSS15eaKxfn0jQ/6e9eHHUpBMeAEzAlq3uBgJdw1KQptqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JavQTY1SvTcsCOQ5pUqnoiDB4C12s4N/nLvo0awbL6g=;
 b=NkNc4KZ4j7WhJxEokVnfZ2PWzBGXEEYvMVgAUeph9AyMtI3m7Fb/E17LM7z9WJoH1aBv8EbqBHdn+5OQlE073A3Do4xJbjzGn8bfYZIm4Rkf6xmV/LQpiL++xwvUzhU8WSLUs69LI3DBGAUosERf1IJL2BGb4oEEC6wk8rFAgv44CzMx3WuB7UVIHEZGBo9F/bTKhMi9je8ZcDNxHrDKfXezS/C4V2QUqkLyT/ACWbI9DUm72ckHwJqhA+3nDIpivABNRQVBj2dHh8MZhBdH6N5+IPgPsfLo0XjehV7PmImMUjZoslMaQyw+FJgQ3/JdEC2jC/t5/CIiYIXVpFDNSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JavQTY1SvTcsCOQ5pUqnoiDB4C12s4N/nLvo0awbL6g=;
 b=OeSbqJfmZps2wOK5HZKKF6owb0kdgUgYuMt18QhQvpnaUdDXuwxjvaOfpnE/oR3zOey76NTofwxwO26CexLOCSJHaCJJL+x4OXasKeag/29mTWYu4bgLV0re19iLggUIcHG0NGkCl0caZ2TH/FDNML6D+iaQZBjrNxwwEGZp9M0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Tue, 29 Jun
 2021 11:15:54 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 11:15:54 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210629094719.1912299-1-YuBiao.Wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <fcfff6cb-2274-6daa-a76a-f75d4ac5cca0@amd.com>
Date: Tue, 29 Jun 2021 13:15:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210629094719.1912299-1-YuBiao.Wang@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:acb7:5516:6a55:2bf5]
X-ClientProxiedBy: AM8P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::31) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:acb7:5516:6a55:2bf5]
 (2a02:908:1252:fb60:acb7:5516:6a55:2bf5) by
 AM8P190CA0026.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.19 via Frontend Transport; Tue, 29 Jun 2021 11:15:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b809627d-c81f-4b2e-7ab7-08d93aef42e3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4390:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4390275F0103D3797527D20D83029@MN2PR12MB4390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rcZML2vf1Dmdpd/LFja4e7OGGR9L4LFPjPtcq51AnClosM5Bjj0JqPRJLhOtUTXUDIt+mJeXPzSvyIF49fRiY2PVB07i0BY1mATSgJcqG0Vhwvsvc5WEo/QNz9ehuNs9ZR1jZxA1wCUId1iaj0PQ05AK/EopLAuUHfsaH9lm9N1y6AgFRm2WVfTAaVPBB82mqh/xOPvzie4dMmOH5i5gW6aXBR5q4/13SgQ85VEeE7oKxmXWdFMf9lGhhvst1u0lAlRociljROrd9KVp9okGyJu8ZqJGUmAAhvUL3M1husaNt32RuqiWaAGZZHcpAzear5fqzf4fxuSDAD8H/EOD3kwed6KB9OJLVWW5ht5Z/kL2yPRcFzXPu+FXCDXda7lRr++JYHaAGh5AJvYAj8iZ5vcZSlFQC2NOQxxE4Qs2MnG9ogo7ABWv18N4Eur4ZZ4G7BxP0pou+ItDBHcGHOoO4r+3NBEnpw1ADUnOjGVKmuCjszOWlUkYPSdJ9zPyVH+TvyYl6sMMsealWUxYd1qx/m9BdcJyx20G/G+10cii0TLzexPBD3bHpbGvtD+ClXlGyKVVbZwSUnAVUtjf8U3H4/j7qP5Qg0rj+a0vJMCL84vf0y2HJ4OLtnPNld1YnL9/T/aFWoOYwuK53IqozrEI5wOhJx6Dh8vuZke0pzBncNaOBSCtZ+03oM5tYLJXGWOa2m595kfB9TITsRBH8j0u8eQCtjX849gW/Ad8OKqZmgt54ry6bVMFwlVgTEUcosAV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(6666004)(478600001)(38100700002)(6486002)(31686004)(86362001)(83380400001)(54906003)(2906002)(31696002)(316002)(2616005)(36756003)(66556008)(66946007)(8676002)(4326008)(66476007)(5660300002)(8936002)(186003)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0taKzFvbXduaFNLTWg4bXlmVnUwaWRzcEVwRHlra0pzMWp5THlkYUJLajYr?=
 =?utf-8?B?YmFrb3JuVVlVNXJOK0Jib3ZvNnlFY1U4WnBSS1dTNE1Ta0Z2b1FHVVR3S3hD?=
 =?utf-8?B?N1BwM294T0ZBQnBhRFBmTE9aUmN5S0xKcm81dmYvTWpKL25VQlJyUkg2MUpr?=
 =?utf-8?B?Tk8xMGRsNStTbE55enpwZ2k0STBTaWQ5SEJzZWZJQ0k3SWxWbUMySDNvQ29X?=
 =?utf-8?B?OUdxRW9iK0lvRW9rMDhORXJSWko0bDV6dEFERGJaeE5EMUkrVVdHWndSbExN?=
 =?utf-8?B?cXh5eDdlM3QvSGJQRzdsMUM3NW96ZWh2dGYrSTNRd3pkbDVaUlp2QWQxTEh4?=
 =?utf-8?B?S2d2RTYrVTkrMmdWQWVVOHhpVUJVQisrRFVub0JsTmkzZ0dOWnJiSHBtS3FG?=
 =?utf-8?B?YzRwOXFMandtL2lRSFhoLzlsTm5rN0ZGVldOaXFGcHpaYTlSM1pUTEt5MC83?=
 =?utf-8?B?bUp6c3Z6SVdxOThkTDhrbWZTV3BPNWN4Nm9TVnNTYUZRUGlZcDJmQUR2ZFlr?=
 =?utf-8?B?V2NMSEF0L2djMnJEYUdjeWF1NzBZWnpRQnd6M0lEbURoUkNGQjUwSUVCL3FY?=
 =?utf-8?B?MXBYSjhBMjZ4aER6Lzl1SFdVSzFnZk9zN0xYc2UyeU5DK3U4OTdOSmpRWEdM?=
 =?utf-8?B?MWUvaEZpcTgxWklVQzZtcmxJVGpGTzBGanJLTjRxQjdxNlliRFBTbmNGZjM4?=
 =?utf-8?B?TmN4ZjhhOVdYTjgrNmp0SXV5MnhiTkhoSElJaFlSVzR6MjZpTW9XREg1YzVY?=
 =?utf-8?B?cHB5Q0l5NnRrVStnWTk1am92R01hZjQ5bWoyVVQyOGdIZU9keFZLbUFYcEdP?=
 =?utf-8?B?TVdvWVM3SFNnMTdkcVhKZGVUYlJTblFUTGpJYVlEYjkrM255MVJwNTh2M1cw?=
 =?utf-8?B?bS9ZT1hPWFJXaldjdExIS29Ec0NyOEZkL3hISXRPQmY3bTJ1bmpjNlhiNDB3?=
 =?utf-8?B?YzRwTTc1Y2dvbzR1bG15ejJEbnFZeStDNXNLOFErODExR3hJOVVxdzdzMGJu?=
 =?utf-8?B?djlZSWNCTzFsWXd0RXpuYjhEclVOeEtEa1laQ1NHZXJISC8yRmJlSEVnV05z?=
 =?utf-8?B?R1hzdXFpOEduT1p0NDZCcW5SeWQ0TTYwbHh1dS9hT1BIbkVRS1FRdTlyVkw1?=
 =?utf-8?B?ai83VGN3dVFUUWRValMzQ0UrbTRwRkhFRGJPbVlRMGNHbTNPL2RSc0UycEox?=
 =?utf-8?B?ekF0MCs0Sm9tS0ZBUXhWWDVjWmYrS0tRcFJ2aU5Dd2lRY3kxQ3VsOFhpdnR1?=
 =?utf-8?B?TlFzMVRlNzRGcjJwQTN2VlVFN2FJZWNXbG4reG85cTIzNUNCbDdseEs1cWh6?=
 =?utf-8?B?ZUNza0c1Uk4rS1BZb2tkTk1xU05kSHFFUE9TTVRTVUQwQmo5amlCcUJadWhx?=
 =?utf-8?B?dm9BNG1OMkhwV2dWQThEOGY2THBXYnc3aDBxWjV0Tm9FQ0swNWV3NDlXdFZC?=
 =?utf-8?B?VlEwVU1XZFJsV1BuM2hQMVZOZkpHMmdrYVVQZnBlZFBuak9yTGhQY0N6YURG?=
 =?utf-8?B?Ylp0Vm93SStoZkdjRjMwRkhLL0xTOXZqcEZVYzBFTmZidDlxQWlLaWk4aVJm?=
 =?utf-8?B?emNBWXJCZmljemJJL1Yxbnc1VVFlRFZKWU50Y0hOcjFhNUhZZkdjSnhORmRW?=
 =?utf-8?B?RTBjSmQwSjdQbzJzdVdzb0ZncTJuN3NWSFFYV0tmcGUxdFU3dnprWGx5enU0?=
 =?utf-8?B?enorR2ZkMHdEUTJYaVhaSmxWWDVVbWZoakhEQXZUK0VPc1ZyS0xvdW4yTU1G?=
 =?utf-8?B?emx6WTdyM2Y1MWRpR1M1ME40UUZqUkQ2VnBFdVRTc1RFTXRKdWFIOTJYbEFI?=
 =?utf-8?B?K0RGNm9tcFl4SnBuZEN4ekE4Wit6QmszYzY3T2RYb01CWXRvSUU4cWxNcC8z?=
 =?utf-8?Q?2nCiGbbp2t0EU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b809627d-c81f-4b2e-7ab7-08d93aef42e3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 11:15:54.4584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHKeUvvBTG2B1ZaUG9PZpLU7zer2OWInfbbL4NFCCPCY3IJ2GWQ9xxFfuhjFsk4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjkuMDYuMjEgdW0gMTE6NDcgc2NocmllYiBZdUJpYW8gV2FuZzoKPiBbV2h5XQo+IEdQVSB0
aW1pbmcgY291bnRlcnMgYXJlIHJlYWQgdmlhIEtJUSB1bmRlciBzcmlvdiwgd2hpY2ggd2lsbCBp
bnRyb2R1Y2UKPiBhIGRlbGF5Lgo+Cj4gW0hvd10KPiBJdCBjb3VsZCBiZSBkaXJlY3RseSByZWFk
IGJ5IE1NSU8uCj4KPiB2MjogQWRkIGFkZGl0aW9uYWwgY2hlY2sgdG8gcHJldmVudCBjYXJyeW92
ZXIgaXNzdWUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBZdUJpYW8gV2FuZyA8WXVCaWFvLldhbmdAYW1k
LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwg
MTMgKysrKysrKysrKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+IGlu
ZGV4IGZmN2U5ZjQ5MDQwZS4uMTkxYjllM2VlM2VhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3YxMF8wLmMKPiBAQCAtNzYxMCw2ICs3NjEwLDcgQEAgc3RhdGljIGludCBnZnhf
djEwXzBfc29mdF9yZXNldCh2b2lkICpoYW5kbGUpCj4gICBzdGF0aWMgdWludDY0X3QgZ2Z4X3Yx
MF8wX2dldF9ncHVfY2xvY2tfY291bnRlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAg
IHsKPiAgIAl1aW50NjRfdCBjbG9jazsKPiArCXVpbnQ2NF90IGNsb2NrX2xvLCBjbG9ja19oaSwg
aGlfY2hlY2s7Cj4gICAKPiAgIAlhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIGZhbHNlKTsKPiAg
IAltdXRleF9sb2NrKCZhZGV2LT5nZnguZ3B1X2Nsb2NrX211dGV4KTsKPiBAQCAtNzYyMCw4ICs3
NjIxLDE2IEBAIHN0YXRpYyB1aW50NjRfdCBnZnhfdjEwXzBfZ2V0X2dwdV9jbG9ja19jb3VudGVy
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCQkJKCh1aW50NjRfdClSUkVHMzJfU09D
MTUoU01VSU8sIDAsIG1tR09MREVOX1RTQ19DT1VOVF9VUFBFUl9WYW5nb2doKSA8PCAzMlVMTCk7
Cj4gICAJCWJyZWFrOwo+ICAgCWRlZmF1bHQ6Cj4gLQkJY2xvY2sgPSAodWludDY0X3QpUlJFRzMy
X1NPQzE1KFNNVUlPLCAwLCBtbUdPTERFTl9UU0NfQ09VTlRfTE9XRVIpIHwKPiAtCQkJKCh1aW50
NjRfdClSUkVHMzJfU09DMTUoU01VSU8sIDAsIG1tR09MREVOX1RTQ19DT1VOVF9VUFBFUikgPDwg
MzJVTEwpOwo+ICsJCWNsb2NrX2hpID0gUlJFRzMyX1NPQzE1X05PX0tJUShTTVVJTywgMCwgbW1H
T0xERU5fVFNDX0NPVU5UX1VQUEVSKTsKPiArCQljbG9ja19sbyA9IFJSRUczMl9TT0MxNV9OT19L
SVEoU01VSU8sIDAsIG1tR09MREVOX1RTQ19DT1VOVF9MT1dFUik7Cj4gKwkJaGlfY2hlY2sgPSBS
UkVHMzJfU09DMTVfTk9fS0lRKFNNVUlPLCAwLCBtbUdPTERFTl9UU0NfQ09VTlRfVVBQRVIpOwo+
ICsJCS8vIElmIGNhcnJ5IGhhcHBlbnMsIGNvbnRpbnVvdXNseSByZWFkIHVudGlsIG5vIGNhcnJ5
IGhhcHBlbnMKPiArCQl3aGlsZSAoaGlfY2hlY2sgIT0gY2xvY2tfaGkpIHsKPiArCQkJY2xvY2tf
bG8gPSBSUkVHMzJfU09DMTVfTk9fS0lRKFNNVUlPLCAwLCBtbUdPTERFTl9UU0NfQ09VTlRfTE9X
RVIpOwo+ICsJCQljbG9ja19oaSA9IGhpX2NoZWNrOwo+ICsJCQloaV9jaGVjayA9IFJSRUczMl9T
T0MxNV9OT19LSVEoU01VSU8sIDAsIG1tR09MREVOX1RTQ19DT1VOVF9VUFBFUik7Cj4gKwkJfQoK
VGhpcyBjb3VsZCBiZSByZWZpbmVkIGludG86CgpkbyB7CiDCoMKgwqAgY2xvY2tfaGkgPVJFQURf
Li4uCiDCoMKgwqAgY2xvY2tfbG8gPSBSRUFEXy4uLi4KfSB3aGlsZSAodW5saWtlbHkoY2xvY2tf
aGkgIT0gUkVBRF8uLi4uKSkKCkFwYXJ0IGZyb20gdGhhdCBsb29rcyBsaWtlIGEgZ29vZCBpZGVh
IHRvIG1lLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPiArCQljbG9jayA9ICh1aW50NjRfdCljbG9j
a19sbyB8ICgodWludDY0X3QpY2xvY2tfaGkgPDwgMzJVTEwpOwo+ICAgCQlicmVhazsKPiAgIAl9
Cj4gICAJbXV0ZXhfdW5sb2NrKCZhZGV2LT5nZnguZ3B1X2Nsb2NrX211dGV4KTsKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
