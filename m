Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F4FC47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 19:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C560760FF0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 19:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C560760FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8619A6EAAB;
	Tue,  8 Jun 2021 19:07:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 922E86EAAB
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 19:07:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ged3MR5pQsu9XjAONR5XhxRvbuQI9KzysrSRU+M7MpLzu4pZhwEOffKomRTnzxFVtXBo3xUNptp6fY2LdxwrbB29yv0xkSVEh8JdnbCookCYmlYqNjt2kom70nCUcAM41pkrWfTeQf01liA7q2Ml6tfrBQ7CmPNof5iDu0yVOWxCfVrUztBAll8By8Ori60pcgHrcmRu5bKy+4bjQMkKbLCIaSl0tLMIlk/ElmTJaiwnwsWSBJgjd0rcn/83MkRS4CO9Da6hRjftis5HKo/d4Zn/cr2IAuuOlfpYQiKFA82IybTYA31v2EYiv3Msm/8dhOdBBffKP+6V5MpqXW6Fjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STYkJ33kZvzB0mwNRIYluyrg7NLWt+I3j6bL+HG03iM=;
 b=euhr/13KFk/SWcRO5PG1Dmhn+q9VOTBkgeHUygm5UyrQGeggQ711n/OVCRSaA3g09WPzkoSag4OZedl5JIpcFGSRbaubz3jvWVnbtcumKbC8pxmtAHYfEKwlMpD29NqURayyncID7JVkWxGwnSI8qDUfFpUQT74bWquwyDivItBoizUTTbJzKsUHKS03zpZAOD+2/x7hzkieqGtT1jY6HFPcswI4wz1J+UZGgm39zntXWdam/j0o9ZlA2MEQP01fiVA7TJRgktN/NpsfGZhhqa7V5p8XWC3M1uQvYCgb3TPT3HhijiCLKDoYEWJ3FXbHhLDPzmUFpCyA3+FTuZvJrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STYkJ33kZvzB0mwNRIYluyrg7NLWt+I3j6bL+HG03iM=;
 b=KA4/c2XXnBmDnWXGgOPuOq0toPtiItUP9CEWnCFmpKC/v2aWSAKZI7wif/Y70/DrL0tRulZEjbpckaeD9p7cwKb1F6Jj1SYsAakTPMmeG6+zidcA5vnNnfz3agATnzu0tlPdYgU+ajGW2DJYjCHoxyXV3CzouHTJLRxc8uRgvY8=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5490.namprd12.prod.outlook.com (2603:10b6:303:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 8 Jun
 2021 19:07:22 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f455:b0b4:439:2753]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f455:b0b4:439:2753%3]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 19:07:22 +0000
Subject: Re: [PATCH] drm/amd/display: Fix overlay validation by considering
 cursors
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Sean Paul <seanpaul@google.com>
References: <20210514114734.687096-1-Rodrigo.Siqueira@amd.com>
 <857025a9-2ac0-ed37-bc9e-a2be9e1780a9@amd.com>
 <CAC0gqY77ztqBfi3g_JYPVEqmahXVJ+bGePMK40WaPmgm4m6gVw@mail.gmail.com>
 <CAJUqKUrM6jrUrZkcfF=R7vNeoj4KvwymwM4tMVy09ndsPci-9Q@mail.gmail.com>
 <20210518185806.gsrzfcxcwo6o47kc@outlook.office365.com>
 <CAOw6vbLBTW03h1-amysV0rAn3YiT6z0C6jds5vPMz1rAEcDGow@mail.gmail.com>
 <517b3280-f7aa-eab3-472e-5e23ad5dc243@amd.com>
 <CAOw6vb+SAOsp-2Da6UMf+Xgx7V=P3MDjFqm1tjRyV6bZk_HPyg@mail.gmail.com>
 <3dfd5d78-f36f-388f-0995-fa9f421bdf0a@daenzer.net>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <3f0316a1-6374-38ad-2010-8e71274d5e01@amd.com>
Date: Tue, 8 Jun 2021 15:07:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <3dfd5d78-f36f-388f-0995-fa9f421bdf0a@daenzer.net>
Content-Language: en-US
X-Originating-IP: [198.200.67.154]
X-ClientProxiedBy: YQBPR0101CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::8) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (198.200.67.154) by
 YQBPR0101CA0135.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 19:07:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26378034-faf4-4a9d-c2bd-08d92ab0a4d4
X-MS-TrafficTypeDiagnostic: CO6PR12MB5490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5490BB4E978A520274439C748C379@CO6PR12MB5490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p5Bn5JWTCRCfh7l/vnk2pqMcdyPQz7Zx3Bm0gyMUSMGLPySK0O8WuwTGpfLMLqPrdAB8aUN/xOZ85f4wtzXzfEqER8FvPSfI9KZNXA8C7oOdRL7UL/Qv+9sAs3RBtEXFovhgVwrMi0jWW0DBNXYX6dQfYes9Qsuth+JuNNdajhSxwnH5AQZOi2EwPOcnfWys5n136hnCWkVNskMzaVrFhu/ji4PLpHNRe7m8Ir6Ez86H9j17W9gTbOBPGhM+ebdOmuymR3kvFDwmbOYlmzaGOSz/8O/mmCMrNKJBRlp9D+0rbYd7MNAcvdFgvgNIITE7q/KFr4CySybm4nNrlgOhjkGTaborCYZfqmbDQ6yVQJB98W7aoig1mrSda2icMRMj0tdwE+jRh1EPYI0ba4d03nP8aX+u63nPhqePdkdZQt8Sokpz2QyOZcP8oJpgAGHHcpBuMw+HvvgueKJ128if4k2FBlzIZB2mavOPvkCZQRtZYYMbjuf/So707Zw/iaz4fC9fV5d/w3uXujhS8CLoBMEpVPLcSkWLh7WtGyv6Kwfn++ZUgp6qnDfud37IGqhKFZXXGHTp2g+VYc6NMw2/E3u7btR+cWkt6lt32q+JOblHDo+nJQ0bfI77B8xVBTtJJbHQIXwTTL9yWx4dbmn5n5xZs2GpWHaZBXEiGEeKjB5hTBzPbey10rM26FD8bdXh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(31686004)(4326008)(83380400001)(8676002)(956004)(110136005)(86362001)(316002)(16576012)(478600001)(66574015)(44832011)(2616005)(31696002)(53546011)(2906002)(8936002)(26005)(6486002)(38100700002)(66946007)(186003)(66476007)(66556008)(16526019)(36756003)(5660300002)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXV1TUhwbTdLcXl5c1BobXR4RWFnWVB1bjQ2Vmd5RGQzRFd2TGk0ZFFaZ3ps?=
 =?utf-8?B?TW5qTTVKU2JIbmlwQVJFNFNqZVRIYUVqZjVWWWtiZlI5eDNQQ2dZajRhcEFS?=
 =?utf-8?B?NTQ5TW1qY2tXN0lzWGZ5Ull5WFJtMDV4QzFONVBIOW5rTms1bTREOVplZFB4?=
 =?utf-8?B?UG9UYXJHMkx3RWRCTnluQUsvT1pTQkZSeW4rSjIzaW9id25mdzIrOWwycmx2?=
 =?utf-8?B?dERNUHpFSy9RVExnekZ4YU5ySHorUHZSbkk4eDd6TjRzV2xOYU9rNVNQb2pB?=
 =?utf-8?B?QUJYNXp0M1grWDRIR1N6OWlrMmdwLzMvaitncnE3UzY2Snpjdms3YnJnbXFT?=
 =?utf-8?B?czJTeE9JeXpOSElhOTk5d1g4aEcwNHR2MVd1SSttcU9ISWU2T2ZoRGRqbjZa?=
 =?utf-8?B?RkpiOGlmZTZaMWJ1NTE4RUxmU2ErM3RVUXFUM2I3Umh0aG5iZldhR2pmekhF?=
 =?utf-8?B?c1lRZEg2UGhUOUV3SlFaZkJoOFFWSVg0ZlpLb0thaUFBTGJKaVJ1S29VT25U?=
 =?utf-8?B?NmxKeitqOUZGbVA3ZGRMNTF3NVovNUN5azlSOTdnK2gyV3BaMlZhYS9SWFJi?=
 =?utf-8?B?RU1YUjFDMlFVZklkR2o0MFNhSmRnc1V2djd5QTM2NzlwNElKTkZhalF0ZmFB?=
 =?utf-8?B?SmRrMFJURVBCSnAxaGJPTzA5cXZMeXBMbitGVE0vZEJtVURxTi9Sc3I4V1l6?=
 =?utf-8?B?NHhHakpmQjM2ci9nWnpPU2ZtTzZNRGt6ZERlUzdnYjhXRm1QOXJ5OEROMnBv?=
 =?utf-8?B?UkRvVk90dFA4R1VxVXBZb0pJaHBYei9wRjNxQjJvVkVObVpCQTJySFBRWFBL?=
 =?utf-8?B?VVU5NmFoTnhsZU1jcVZNWi9BQjkwb05lSFdiZUdYVmtCK2xYTW4wWVp0S0Jw?=
 =?utf-8?B?QmdwbXdRTnlXbUVkd2VFcng4bEhxSkxHMkJiekVzVUdQZGxoZGxmREZncFhi?=
 =?utf-8?B?ZTd5bHp0MnhOMzJFNGwzR1JLQjRHQ1RPWnZkK3JZTFp6SUdBenF0NUV2Zkhv?=
 =?utf-8?B?Rk5hRVB5STNxSE5TTStiQkRGeWd0Yi93SEVjN2JWZkt1bUkvUVhoU094M3pZ?=
 =?utf-8?B?L0Q4Z2N4bUdBb0NOV0g5bjBrQlpGUUJmcDFjVEhRckxSay8vYU92ZU40QTRN?=
 =?utf-8?B?V0FwVEtaTE9uQWlmdGFYanUzN0FrM2FqazJIb2hVcS9mWjgralhhRXk1S3JE?=
 =?utf-8?B?RElTK293MS80NEpRL2NrN1pjWXFkM2U1WnNwbDNBZUVqQUF1OGJrVEptbnUy?=
 =?utf-8?B?QTBKbTMvTTZoS1dNQXVDc2dSbW1wbDN4c214SnJkd3JHdHd4WDNLUm55S3BG?=
 =?utf-8?B?S2tUeXlYVys3RU55L1lJVTJIL3hhSnhWajRRODVkYmVKaGplMjJCU1ljWDg3?=
 =?utf-8?B?ai81SHNJeC9naytaYmNvL2tINHpvSlU1RlNtNEVwdGpGeWtxVVVBZEtzeWhm?=
 =?utf-8?B?UE96NDlzOWk4ODFWckVHQm1hUTZhbngyd011OFR4eC9IMUZTcldLSTF2ODJJ?=
 =?utf-8?B?QVBmd0Rjc3VOdmp4RVo2SXFESENiTlBCU1o2WTBoVFZHcldyU2VGcWZ6S01Y?=
 =?utf-8?B?aDQ3NlZYelVOYVFENFFFTEtjTDBibWtSOU1ZdTV0SHIwN21UbGE0SWl0RTV5?=
 =?utf-8?B?ZUg5a2kyaWJjTzhFZk1ZWmFJdEZZOFlmSGFwTTVHNmgzUGtkYmtnSFRTK2dI?=
 =?utf-8?B?TnFtUVhlY3g0R3Z3N1ZWYkMvcVNSdStWSVIvK0NlQ09mWmYrczZMS2JJd0gz?=
 =?utf-8?Q?Mr1mWcsBqNSAI88UvFslJrxGXTeblrXV+xSym0M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26378034-faf4-4a9d-c2bd-08d92ab0a4d4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 19:07:22.1446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShH4EcF/BSJNU9dxG7agAWoTS4SnN7ftygUQeBRUFE8O4p/RgJWAELVz497Rr6Vbbm8tKrYSnDtskQqFwHdvVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5490
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
Cc: Mark Yacoub <markyacoub@chromium.org>, "Tianci . Yin" <tianci.yin@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Nicholas Choi <nicholas.choi@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Mark Yacoub <markyacoub@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIxLTA2LTA4IDM6NDcgYS5tLiwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjAy
MS0wNi0wNyA4OjQ1IHAubS4sIFNlYW4gUGF1bCB3cm90ZToKPj4KPj4KPj4gT24gTW9uLCBKdW4g
NywgMjAyMSBhdCAyOjM3IFBNIEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29t
IDxtYWlsdG86aGFycnkud2VudGxhbmRAYW1kLmNvbT4+IHdyb3RlOgo+Pgo+PiAgICAgT24gMjAy
MS0wNi0wNyAyOjE5IHAubS4sIFNlYW4gUGF1bCB3cm90ZToKPj4gICAgID4gT24gVHVlLCBNYXkg
MTgsIDIwMjEgYXQgMjo1OCBQTSBSb2RyaWdvIFNpcXVlaXJhCj4+ICAgICA+IDxSb2RyaWdvLlNp
cXVlaXJhQGFtZC5jb20gPG1haWx0bzpSb2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+PiB3cm90ZToK
Pj4gICAgID4+Cgo8c25pcD4KCj4+ICAgICA+PiBIaSBNYXJrIGFuZCBTZWFuLAo+PiAgICAgPj4K
Pj4gICAgID4+IEkgZG9uJ3Qga25vdyBpZiBJIGZ1bGx5IGNvbXByZWhlbmRlZCB0aGUgc2NlbmFy
aW8gd2hpY2ggaW4gbXkgcGF0Y2gKPj4gICAgID4+IG1pZ2h0IGNhdXNlIGEgQ2hyb21lT1MgY3Jh
c2gsIGJ1dCB0aGlzIGlzIHdoYXQgSSB1bmRlcnN0b29kOgo+PiAgICAgPj4KPj4gICAgID4KPj4g
ICAgID4gQ2hyb21lIGNvbXBvc2l0b3Igb25seSBkb2VzIGFuIGF0b21pYyB0ZXN0IHdoZW4gdGhl
IGxheW91dCBnZW9tZXRyeQo+PiAgICAgPiBjaGFuZ2VzIChpZTogcGxhbmUgaXMgYWRkZWQvcmVt
b3ZlZC9yZXNpemVkL21vdmVkKS4gVGhpcyBkb2VzIG5vdCB0YWtlCj4+ICAgICA+IGludG8gY29u
c2lkZXJhdGlvbiB0aGUgY3Vyc29yLiBPbmNlIHRoZSBhdG9taWMgdGVzdCBoYXMgYmVlbiB2YWxp
ZGF0ZWQKPj4gICAgID4gZm9yIGEgZ2l2ZW4gbGF5b3V0IGdlb21ldHJ5IChzZXQgb2YgcGxhbmVz
L2ZicyBhbG9uZyB3aXRoIHRoZWlyIHNpemVzCj4+ICAgICA+IGFuZCBsb2NhdGlvbnMpLCBDaHJv
bWUgYXNzdW1lcyB0aGlzIHdpbGwgY29udGludWUgdG8gYmUgdmFsaWQuCj4+ICAgICA+Cj4+ICAg
ICA+IFNvIHRoZSBzaXR1YXRpb24gSSdtIGVudmlzaW9uaW5nIGlzIGlmIHRoZSBjdXJzb3IgaXMg
aGlkZGVuLCBhbgo+PiAgICAgPiBvdmVybGF5LWJhc2VkIHN0cmF0ZWd5IHdpbGwgcGFzcyBpbiB0
aGUga2VybmVsLiBJZiBhdCBhbnkgdGltZSB0aGUKPj4gICAgID4gY3Vyc29yIGJlY29tZXMgdmlz
aWJsZSwgdGhlIGtlcm5lbCB3aWxsIHN0YXJ0IGZhaWxpbmcgY29tbWl0cyB3aGljaAo+PiAgICAg
PiBjYXVzZXMgQ2hyb21lJ3MgR1BVIHByb2Nlc3MgdG8gY3Jhc2guCj4+ICAgICA+Cj4+ICAgICA+
IEluIGdlbmVyYWwgSSdtIHVuZWFzeSB3aXRoIHVzaW5nIHRoZSBjdXJzb3IgaW4gdGhlIGF0b21p
YyBjaGVjayBzaW5jZQo+PiAgICAgPiBpdCBmZWVscyBsaWtlIGl0IGNvdWxkIGJlIHJhY3kgaW5k
ZXBlbmRlbnQgb2YgdGhlIGlzc3VlIGFib3ZlLiBJCj4+ICAgICA+IGhhdmVuJ3QgZG92ZSBpbnRv
IHRoZSBoZWxwZXIgY29kZSBlbm91Z2ggdG8gcHJvdmUgaXQsIGp1c3QgYQo+PiAgICAgPiBzcGlk
ZXktc2Vuc2UuCj4+ICAgICA+Cj4+Cj4+ICAgICBJc24ndCB0aGUgY3Vyc29yIHN1cHBvc2VkIHRv
IGJlIGp1c3QgYW5vdGhlciBwbGFuZT8gSWYgc28sIHNob3VsZG4ndAo+PiAgICAgYWRkaW5nL3Jl
bW92aW5nIHRoZSBjdXJzb3IgdHJpZ2dlciBhbiBhdG9taWMgdGVzdD8KPj4KPj4KPj4gQ2hyb21l
IGlzIHVzaW5nIGxlZ2FjeSBjdXJzb3IuCj4+Cj4+IFllcyBpdCB3aWxsIHRyaWdnZXIgYW4gYXRv
bWljIHRlc3QgaW4gdGhlIGtlcm5lbCwgYW5kIHRoYXQgYXRvbWljIHRlc3Qgd2lsbCBmYWlsLiBV
bmZvcnR1bmF0ZWx5IENocm9tZSBkb2VzIG5vdCBleHBlY3QgYSBmYWlsdXJlIHNvIGl0IHdpbGwg
Y3Jhc2guCj4gCj4gVGhlIHNvbHV0aW9uIGlzIHByb2JhYmx5IGluZGVlZCBmb3IgYXRvbWljIGNo
ZWNrIHRvIHJlamVjdCBzdGF0ZSB3aGljaCBjb3VsZG4ndCB3b3JrIGlmIHRoZSBjdXJzb3Igd2Fz
IGVuYWJsZWQsIGV2ZW4gaWYgdGhlIGN1cnNvciBpcyBjdXJyZW50bHkgZGlzYWJsZWQuIE90aGVy
d2lzZSBvbmUgY2FuIGhpdCB2YXJpb3VzIHN1cnByaXNpbmcgZXJyb3JzIHZpYSBsZWdhY3kgQVBJ
cywgYXMgZGVzY3JpYmVkIGluIGI4MzZhMjc0Yjc5NyAiZHJtL2FtZGdwdS9kYzogUmVxdWlyZSBw
cmltYXJ5IHBsYW5lIHRvIGJlIGVuYWJsZWQgd2hlbmV2ZXIgdGhlIENSVEMgaXMiLgo+IAoKQWdy
ZWVkLgoKSXQncyBhIGJpdCB1bmZvcnR1bmF0ZSBidXQgdGhlIG9ubHkgd2F5IHRvIGRlYWwgd2l0
aCB0aGlzIGJldHRlciBpcyBpZiB3ZSBoYWQgc29tZSB3YXkgZm9yIERSTSBtYXN0ZXIgdG8gdGVs
bCB1cyB3aGV0aGVyIGl0IHdpbGwgb25seSB1c2UgdGhlIGF0b21pYyBJT0NUTCBvciB1c2UgbGVn
YWN5IElPQ1RMcyAoaW5jbHVkaW5nIGEgY29tYmluYXRpb24gb2YgYXRvbWljIGFuZCBsZWdhY3kp
LgoKSGFycnkKCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
