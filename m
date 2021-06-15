Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23880C48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 11:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A4D6140C
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 11:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A4D6140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A40188C3D;
	Tue, 15 Jun 2021 11:57:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 749D088C3D
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 11:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMrkmvnDX06+Qnyhchg0XdiX55ugo+cKEK6neyylGPWxJTBb3PYuDRTMDBeaUsMq8SsKhFczq/qZpCAKaGUapU2F51rAzi16K8I5gnApb1mrKtJYbstUKlC+yDId3EsAETY0ykpiSxmZPK9dBUXeBfQ6MNyl0ioxz0theGXlzrTISCDjACq/K4uQpCLPJkE8c3c+PEYbrkK2kO++bF4qU1hytHzgK7voaAuVetEPlEYxGJJAEOEZx1zjtBnopGQ1oAmHAjqRss+dZe4fctPWEDm5PSpWJJdw30ed1jYDLUe8aNYzjvoiFCHW6evAqQWBT6y2sjo8DqJ7t/ulcG2Trw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXzeUBdaSYao0Rmn2pISHTC/nOJ7GOAskwKRghmdnhU=;
 b=jfmE9Ga/cbWOMWmWXUnI9SeeAKT4x+XfoDcr8yZKMbSHdvNtEZu2R6PF3YbpYLTcqbMp6mHQ+IZO/ntGF4JajBkv9LkxBavcDq43HjWC0vGymAANO7EXWghHTwjHMojsm5DFFXSP6SHsNb7QtFkZRi66NGyU6Ryub9cmv7YIODoHKLnYfhsq2+Vl2B6fC9NzBFf1BjaChtJKr4XeztesBzhjT+TrJNoFccE4fdHTUFtJkWD4qzbNbiLD48N6jk+xy+zOwHO3zNaQvyxdQ0D8sMB3lKa0O5mQfisQ59lD/RhopNej75lRraapSHeD6D8YLl56cguy1ThSEZwJZUZFww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXzeUBdaSYao0Rmn2pISHTC/nOJ7GOAskwKRghmdnhU=;
 b=YTe9u6/x8+yC4CAk7wTRZXr5UQyibI3TYxAEFpvWugeHWTel8UeYLG3pmBpGrkVRln4xR762Hug0XkCURaH5nrtgR83s7F1mcxbtXVEnXOLFFAB1CLJRN0gK8TDWmGecaDqUm+o8ezh8ErYFBFOQmR5HhkHcpFxJb3bq58SRMCY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 15 Jun
 2021 11:57:22 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 11:57:22 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: move shadow_list to amdgpu_bo_vm
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210615115112.50301-1-nirmoy.das@amd.com>
 <20210615115112.50301-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a1a9f8aa-eb22-afd0-f893-bb340b990894@amd.com>
Date: Tue, 15 Jun 2021 13:57:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210615115112.50301-2-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:f438:4e93:3853:400c]
X-ClientProxiedBy: FR3P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::7) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:f438:4e93:3853:400c]
 (2a02:908:1252:fb60:f438:4e93:3853:400c) by
 FR3P281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.9 via Frontend Transport; Tue, 15 Jun 2021 11:57:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a9c2f8a-197a-4df1-d151-08d92ff4bc16
X-MS-TrafficTypeDiagnostic: MN2PR12MB4237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42376633DAE03266C65E3E7D83309@MN2PR12MB4237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TqQsZLQgPDykxb447EBBdeIlXy0jJ1M3BIwHJwIoV3X4SpM1nn76nDoNGcfv8D8g4WVwtzjW4o+ALj9V0sWIVoS7SdAxjTlGzEq0UyR4DxtbrzpuXrigWl5HpXhFKetXekc/zuEEeWG//Zez2Cx7okbx321z7yRwGmrujPuG9bzWhEYbVlgdJ4bZ4FW4MZrmexCp+DiWweB1vxntyqowrr8TiSJf+EclmOruNKttJllRoub4WfmfPUHgBHGwQM0DOEVSXrNhhARzqMNlS065nxY6ZMiS4SFslkDN+ZJAsA5HK/We+hhNqtmYF2H1XzKa9PavYoOl7g2+ShqrqN/S0k5EfYASVGac2JOxZxIYEDie73KpxWnCv2P5kkJqNVNTwZKEGV/kyFdswnEO99JhECHC1CTlzQxgHYwZxOt6GOuLkFxPnJP8A0ipp7slUrqY8JgLvLgCSRYOSGzGH4pH0k6SURDRnbXyO1lgdcQBmsh1MsNRh7yFOx9JolCYrlMVD/ukYAH9Y+XMBhcRG9JMvzMK11tyqiLeuMyxl/4Vzc8qiXN83/5Dh6ssw2JbSlibfuFp9LZiBrgk9nmtxJJu4ZdZI/9A5jNe46OA0m4xsHCxgJSDlYwKOez3JVDLBcyJu50gICBtE+UN+w6pfkp/z5FnRD3GYoJFygGU/v89+q8s42YbAgJN0wXXyKdXWngI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(316002)(31696002)(6666004)(5660300002)(66556008)(186003)(86362001)(66946007)(38100700002)(16526019)(66476007)(478600001)(36756003)(6486002)(83380400001)(66574015)(2906002)(8936002)(8676002)(31686004)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnFyMUs0bkllSVJ6bjF1bmdncFdySk82N3YyK1BvQVRnVjZhaDRZWVpvSExB?=
 =?utf-8?B?K05JTEJSU2IybmxKa1BGdTAybjFVYjRYVm9ma0NYVmJoU0JZSzYrZXpZSlBB?=
 =?utf-8?B?RDRSNjR4MDQrYU5WMENpR29uMFVRV1g5bTNoMTNIcVdLNW9qQjlTMkZUbGkr?=
 =?utf-8?B?VmFEZVpSMWYvaVdVbGpnUU5CRm4zaTY4dWZ6WVErWmJaU2JjWURxQVl5SUlU?=
 =?utf-8?B?bzZ5NzExNWtEa1o4eDFuMTZzZmp5ZHEwczQrV2ZGK3hmUFdLc0ExZnI2RnRU?=
 =?utf-8?B?Ujk0WW9JdGV3ZldxVlBpS3c3N29DT2J6TmNZMGtnOGN5N3ZhbWRTRFlCbTh1?=
 =?utf-8?B?R3dnV0lyaWM1ZVJ4ZWlkckdpWWxnY2F6YTJ0ZXp4U0poVHJPS1g0QStYWHBI?=
 =?utf-8?B?dDlkUnVVaHkzS1lwSDZnYkJDTmp0M081NlhUR3JlY0xuVDlsVjRreGZlQkpy?=
 =?utf-8?B?cDZ6d2dRK3htb09BTnNFM2pPV2JPVlhQSDZVK1VDRlNhM2VJUUhvU0RrbFBF?=
 =?utf-8?B?UXJmWHM5VjdZNWwyalQzcjdudUppRnlBUGFid3R3a1kvS2hIYitRdkt4UjNu?=
 =?utf-8?B?TW54QVNPTWE2NjBkNi9JcE9naU1NMUVXNFFWdUhxQW1SK1NRWVUyQXVrUCtm?=
 =?utf-8?B?UzlZVGowcnBpelZRWnkzVDRwNENveCs4dWtxM0VHakxjalNUZWRRK1NDblBu?=
 =?utf-8?B?UDVCaTVtYXYxMEZJcWN0aVNXKy9ZNnE5TWt4ZUJCWGhzL01XMzZySTZ4YXRJ?=
 =?utf-8?B?ZkhRQ25SQ0k1TE8yZHBMcnh4RXBSbEk0ZmlHWTM1RTRHNG5ZWlMzYXB4QTIx?=
 =?utf-8?B?ZmJwb1hSeUtneEY4SDAzYlcrMGI3cnRubGNHSyt2WW1DaElHd3Rocmp5VEdZ?=
 =?utf-8?B?RDNCdnU4UDk1ZzRpbWN6ekswWEc4ZHpyc3E4MW9iOWRxN0tYZkFhbWxHaitP?=
 =?utf-8?B?MzJxSjZFYm0xaE05YU5TbXNSbzFiTlB5R2lHTDlXai9OMkVjQnMzdldzbTJ3?=
 =?utf-8?B?YnZ0L0JIVDE4R1ZKd2dDRWxxeFgveEVhaWxyWXZLWW1OcDdNL21SN1Y2cDhy?=
 =?utf-8?B?aHFmT0Q4RVI0TVpQUDZrNUU0dnVJTDAvUkFSRGJtL2k2dm1iNTBDQTNCRXZZ?=
 =?utf-8?B?aWNRTWtMaDdxUXorRnhMRmpxQVFlSUpQQlJNQm5IZVdPeEt6SllQZy8zcGJY?=
 =?utf-8?B?VGhxZ1g5SGNkYUpDMlNFMU1SRlRqa0RRcnMrK3l4WUt6NWZJVWM1VEVjMGpS?=
 =?utf-8?B?b2oyNXBWbys3THhyemw2c2JVU1d1SEdYTmZOUW1KazhUZTdxV3huQlhSUXN4?=
 =?utf-8?B?cEhlZllPbDh2Q2pTMnY1eWduSXVya3V6aXd6bWhBZUxnNnR0bFhkbC85SmYy?=
 =?utf-8?B?d29Md05Tbmc0SkxtclNzbTg0Mmd3SjhtaEVkRS9UZDdQNmNNRzNvZ2NHNnpW?=
 =?utf-8?B?T0hPWmVSMWV4UkJwdHdRT21QbEZ4Zi9JQ29DQStUakRQRVFYUDh6OWF1NmtM?=
 =?utf-8?B?Q2VMZ2hsTVM2Q0pOTnhlZXdiTHZFbjRtTFM4ODZENFJVOXVmZWNGSE9pazVM?=
 =?utf-8?B?Y1J2Tnd1ZnRoalNSMjdTQXpTOWhmK1drNmo2MDF6SWtTcE00bmw4bHRnWEgw?=
 =?utf-8?B?SzZsSmtYcTFPY1BvSlJ0ZEgyNzcrWTlhZDJGdE5udzVmdnJONmhKNm1hU1Qv?=
 =?utf-8?B?bnhSNFNlUXo0NytibEFSQlpRNG82TW5OZ0RodEdQZWUwK1VYdXk3TFFBeUlY?=
 =?utf-8?B?dzZqR3IweFFiV3U1TjY5K2xTcDhJY1ZRdGxiZ0x5Y2hsZWVwbDJZZWlvcUsv?=
 =?utf-8?B?STBvRHhJU1pEdzh2Y0NOa2Y2Ym9QeDhUQ1dhUDZoRFFNZVlhc1EzQU9wNXIz?=
 =?utf-8?Q?JzwyijEG7yeMF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9c2f8a-197a-4df1-d151-08d92ff4bc16
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 11:57:22.6481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrbnFqs8I+FiiDrNq23JIUAMiiolUBOuZR48DVw6p3Oix1akpuGIaUXNgQtGQYPW
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAxNS4wNi4yMSB1bSAxMzo1MSBzY2hyaWViIE5pcm1veSBEYXM6Cj4gTW92ZSBzaGFkb3df
bGlzdCB0byBzdHJ1Y3QgYW1kZ3B1X2JvX3ZtIGFzIHNoYWRvdyBCT3MKPiBhcmUgcGFydCBvZiBQ
VC9QRCBCT3MuCj4KPiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5j
b20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMg
fCAgNSArKystLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5j
IHwgMTQgKysrKysrKystLS0tLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9vYmplY3QuaCB8ICA2ICsrLS0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMgICAgIHwgIDIgKy0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygr
KSwgMTMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jCj4gaW5kZXggZjI2MzZmNDExYTI1Li4zZjUxYjE0MmZjODMgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gQEAgLTQwNjMsNiArNDA2
Myw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9yZWNvdmVyX3ZyYW0oc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCj4gICB7Cj4gICAJc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UgPSBOVUxM
LCAqbmV4dCA9IE5VTEw7Cj4gICAJc3RydWN0IGFtZGdwdV9ibyAqc2hhZG93Owo+ICsJc3RydWN0
IGFtZGdwdV9ib192bSAqdm1ibzsKPiAgIAlsb25nIHIgPSAxLCB0bW87Cj4gICAKPiAgIAlpZiAo
YW1kZ3B1X3NyaW92X3J1bnRpbWUoYWRldikpCj4gQEAgLTQwNzIsOCArNDA3Myw4IEBAIHN0YXRp
YyBpbnQgYW1kZ3B1X2RldmljZV9yZWNvdmVyX3ZyYW0oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCj4gICAKPiAgIAlkZXZfaW5mbyhhZGV2LT5kZXYsICJyZWNvdmVyIHZyYW0gYm8gZnJvbSBz
aGFkb3cgc3RhcnRcbiIpOwo+ICAgCW11dGV4X2xvY2soJmFkZXYtPnNoYWRvd19saXN0X2xvY2sp
Owo+IC0JbGlzdF9mb3JfZWFjaF9lbnRyeShzaGFkb3csICZhZGV2LT5zaGFkb3dfbGlzdCwgc2hh
ZG93X2xpc3QpIHsKPiAtCj4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KHZtYm8sICZhZGV2LT5zaGFk
b3dfbGlzdCwgc2hhZG93X2xpc3QpIHsKPiArCQlzaGFkb3cgPSAmdm1iby0+Ym87Cj4gICAJCS8q
IE5vIG5lZWQgdG8gcmVjb3ZlciBhbiBldmljdGVkIEJPICovCj4gICAJCWlmIChzaGFkb3ctPnRi
by5tZW0ubWVtX3R5cGUgIT0gVFRNX1BMX1RUIHx8Cj4gICAJCSAgICBzaGFkb3ctPnRiby5tZW0u
c3RhcnQgPT0gQU1ER1BVX0JPX0lOVkFMSURfT0ZGU0VUIHx8Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+IGluZGV4IGVhNTRmZDczOWM0MS4uZWEzMzllYWFj
Mzk5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+
IEBAIC0xMDMsMTEgKzEwMywxMyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfYm9fdm1fZGVzdHJveShz
dHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKnRibykKPiAgIHsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiA9IGFtZGdwdV90dG1fYWRldih0Ym8tPmJkZXYpOwo+ICAgCXN0cnVjdCBhbWRn
cHVfYm8gKmJvID0gdHRtX3RvX2FtZGdwdV9ibyh0Ym8pOwo+ICsJc3RydWN0IGFtZGdwdV9ib192
bSAqdm1ibzsKPiAgIAo+ICsJdm1ibyA9IHRvX2FtZGdwdV9ib192bShibyk7Cj4gICAJLyogaW4g
Y2FzZSBhbWRncHVfZGV2aWNlX3JlY292ZXJfdnJhbSBnb3QgTlVMTCBvZiBiby0+cGFyZW50ICov
Cj4gLQlpZiAoIWxpc3RfZW1wdHkoJmJvLT5zaGFkb3dfbGlzdCkpIHsKPiArCWlmICghbGlzdF9l
bXB0eSgmdm1iby0+c2hhZG93X2xpc3QpKSB7Cj4gICAJCW11dGV4X2xvY2soJmFkZXYtPnNoYWRv
d19saXN0X2xvY2spOwo+IC0JCWxpc3RfZGVsX2luaXQoJmJvLT5zaGFkb3dfbGlzdCk7Cj4gKwkJ
bGlzdF9kZWxfaW5pdCgmdm1iby0+c2hhZG93X2xpc3QpOwo+ICAgCQltdXRleF91bmxvY2soJmFk
ZXYtPnNoYWRvd19saXN0X2xvY2spOwo+ICAgCX0KPiAgIAo+IEBAIC01ODMsNyArNTg1LDYgQEAg
aW50IGFtZGdwdV9ib19jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJaWYg
KGJvID09IE5VTEwpCj4gICAJCXJldHVybiAtRU5PTUVNOwo+ICAgCWRybV9nZW1fcHJpdmF0ZV9v
YmplY3RfaW5pdChhZGV2X3RvX2RybShhZGV2KSwgJmJvLT50Ym8uYmFzZSwgc2l6ZSk7Cj4gLQlJ
TklUX0xJU1RfSEVBRCgmYm8tPnNoYWRvd19saXN0KTsKPiAgIAliby0+dm1fYm8gPSBOVUxMOwo+
ICAgCWJvLT5wcmVmZXJyZWRfZG9tYWlucyA9IGJwLT5wcmVmZXJyZWRfZG9tYWluID8gYnAtPnBy
ZWZlcnJlZF9kb21haW4gOgo+ICAgCQlicC0+ZG9tYWluOwo+IEBAIC03MTMsNiArNzE0LDcgQEAg
aW50IGFtZGdwdV9ib19jcmVhdGVfdm0oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJ
CXJldHVybiByOwo+ICAgCj4gICAJKnZtYm9fcHRyID0gdG9fYW1kZ3B1X2JvX3ZtKGJvX3B0cik7
Cj4gKwlJTklUX0xJU1RfSEVBRCgmKCp2bWJvX3B0ciktPnNoYWRvd19saXN0KTsKPiAgIAlyZXR1
cm4gcjsKPiAgIH0KPiAgIAo+IEBAIC03NTcsMTIgKzc1OSwxMiBAQCBpbnQgYW1kZ3B1X2JvX3Zh
bGlkYXRlKHN0cnVjdCBhbWRncHVfYm8gKmJvKQo+ICAgICoKPiAgICAqIEluc2VydCBhIEJPIHRv
IHRoZSBzaGFkb3cgbGlzdC4KPiAgICAqLwo+IC12b2lkIGFtZGdwdV9ib19hZGRfdG9fc2hhZG93
X2xpc3Qoc3RydWN0IGFtZGdwdV9ibyAqYm8pCj4gK3ZvaWQgYW1kZ3B1X2JvX2FkZF90b19zaGFk
b3dfbGlzdChzdHJ1Y3QgYW1kZ3B1X2JvX3ZtICp2bWJvKQo+ICAgewo+IC0Jc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYgPSBhbWRncHVfdHRtX2FkZXYoYm8tPnRiby5iZGV2KTsKPiArCXN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2ID0gYW1kZ3B1X3R0bV9hZGV2KHZtYm8tPmJvLnRiby5iZGV2
KTsKPiAgIAo+ICAgCW11dGV4X2xvY2soJmFkZXYtPnNoYWRvd19saXN0X2xvY2spOwo+IC0JbGlz
dF9hZGRfdGFpbCgmYm8tPnNoYWRvd19saXN0LCAmYWRldi0+c2hhZG93X2xpc3QpOwo+ICsJbGlz
dF9hZGRfdGFpbCgmdm1iby0+c2hhZG93X2xpc3QsICZhZGV2LT5zaGFkb3dfbGlzdCk7Cj4gICAJ
bXV0ZXhfdW5sb2NrKCZhZGV2LT5zaGFkb3dfbGlzdF9sb2NrKTsKPiAgIH0KPiAgIAo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmggYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmgKPiBpbmRleCBhOGM3MDI2MzRl
MWIuLjE4Y2IyZjI4ZTRkZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfb2JqZWN0LmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfb2JqZWN0LmgKPiBAQCAtMTA5LDkgKzEwOSw2IEBAIHN0cnVjdCBhbWRncHVfYm8gewo+ICAg
I2lmZGVmIENPTkZJR19NTVVfTk9USUZJRVIKPiAgIAlzdHJ1Y3QgbW11X2ludGVydmFsX25vdGlm
aWVyCW5vdGlmaWVyOwo+ICAgI2VuZGlmCj4gLQo+IC0Jc3RydWN0IGxpc3RfaGVhZAkJc2hhZG93
X2xpc3Q7Cj4gLQo+ICAgCXN0cnVjdCBrZ2RfbWVtICAgICAgICAgICAgICAgICAgKmtmZF9ibzsK
PiAgIH07Cj4gICAKPiBAQCAtMTI3LDYgKzEyNCw3IEBAIHN0cnVjdCBhbWRncHVfYm9fdXNlciB7
Cj4gICBzdHJ1Y3QgYW1kZ3B1X2JvX3ZtIHsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2JvCQlibzsKPiAg
IAlzdHJ1Y3QgYW1kZ3B1X2JvCQkqc2hhZG93Owo+ICsJc3RydWN0IGxpc3RfaGVhZAkJc2hhZG93
X2xpc3Q7Cj4gICAJc3RydWN0IGFtZGdwdV92bV9ib19iYXNlICAgICAgICBlbnRyaWVzW107Cj4g
ICB9Owo+ICAgCj4gQEAgLTMzMyw3ICszMzEsNyBAQCB1NjQgYW1kZ3B1X2JvX2dwdV9vZmZzZXRf
bm9fY2hlY2soc3RydWN0IGFtZGdwdV9ibyAqYm8pOwo+ICAgaW50IGFtZGdwdV9ib192YWxpZGF0
ZShzdHJ1Y3QgYW1kZ3B1X2JvICpibyk7Cj4gICB2b2lkIGFtZGdwdV9ib19nZXRfbWVtb3J5KHN0
cnVjdCBhbWRncHVfYm8gKmJvLCB1aW50NjRfdCAqdnJhbV9tZW0sCj4gICAJCQkJdWludDY0X3Qg
Kmd0dF9tZW0sIHVpbnQ2NF90ICpjcHVfbWVtKTsKPiAtdm9pZCBhbWRncHVfYm9fYWRkX3RvX3No
YWRvd19saXN0KHN0cnVjdCBhbWRncHVfYm8gKmJvKTsKPiArdm9pZCBhbWRncHVfYm9fYWRkX3Rv
X3NoYWRvd19saXN0KHN0cnVjdCBhbWRncHVfYm9fdm0gKnZtYm8pOwo+ICAgaW50IGFtZGdwdV9i
b19yZXN0b3JlX3NoYWRvdyhzdHJ1Y3QgYW1kZ3B1X2JvICpzaGFkb3csCj4gICAJCQkgICAgIHN0
cnVjdCBkbWFfZmVuY2UgKipmZW5jZSk7Cj4gICB1aW50MzJfdCBhbWRncHVfYm9fZ2V0X3ByZWZl
cnJlZF9waW5fZG9tYWluKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gaW5kZXggNGM0YzU2NTgxNzgwLi44MTJjMjI1NTM4
YTcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC05MzYs
NyArOTM2LDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fcHRfY3JlYXRlKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAo+ICAgCX0KPiAgIAo+ICAgCSgqdm1ibyktPnNoYWRvdy0+cGFyZW50ID0g
YW1kZ3B1X2JvX3JlZihibyk7Cj4gLQlhbWRncHVfYm9fYWRkX3RvX3NoYWRvd19saXN0KCgqdm1i
byktPnNoYWRvdyk7Cj4gKwlhbWRncHVfYm9fYWRkX3RvX3NoYWRvd19saXN0KCgqdm1ibykpOwoK
WW91IGNhbiBkcm9wIHRoZSBleHRyYSAoKSBwYWlyIGhlcmUuCgpBcGFydCBmcm9tIHRoYXQgdGhl
IHNlcmllcyBpcyBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyAKPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KClRoYW5rcywKQ2hyaXN0aWFuLgoKPiAgIAo+ICAgCXJldHVybiAwOwo+ICAg
fQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
