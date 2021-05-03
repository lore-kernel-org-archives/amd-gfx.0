Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CFDC433B4
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 18:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F0B611AC
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 18:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F0B611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F13636E0EE;
	Mon,  3 May 2021 18:09:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AFCB6E0EE
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 18:09:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVKQnSvZ4oeqAoL7jcwHHSykfe3hTcJsOtLdjTndymrH63+DNZYLtW+a+PM+jdzi94rJCYkwPZIYCx3y9juLJwE5VHefTyX2seTu5n58+J7mMn9Fsf2U+c/FSxLtdp+Tj+o1tMOSH9Tn3CGhLDju/hYqUOoTSxRtItNeoy5aEFaCxZDBltoUx5+weSAnC31Wj3U6TeN13SWMGZbfTbUWQbDZGdwNG72WzHv4/CcWKL7AKbyZ2vS7dh9lh6FXLGSCf/zNUYrQ61BFWUqNulruEgbjDrvKtjtCl1xw44BdytqiYwJDb/qYjgprhhGXv2rHJRMcp76H4v09uXYtw7Y+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYqs+dhuSo3Dbv0S67/jCzW+2LoJ6/aZwVbgRV0CyzY=;
 b=YLABjyGmSYJ5W+fE0rTUWp5dY/eZvsldwRY7RRhRKkyUaoMt/vsuNErtJp770ZUP0tkqKZsBS+SsJRslq6DkGtS0kIJ24EvkapDa50QpXw9Nu61a68S0LyTEkA9sLSaBccSN7XilOaVOMdkMwWIzZX1PrqNQnrXVgtOJ93Y6qkHLWgjfuZwlEsoYL1faEdEofwgGOdvWWOsH5EXgBs/HX5jkkvZ93iDDcZhpvj1iqE93az/aaOvdt0VMyz+BndxSzXzdAb1r6yh+wpTYlL9hgxMo43WTlHq97U27KenDqgBW/b0dyJWMcbSuHPtzMkUkMVXjYdUuqo80yl4dPUB6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYqs+dhuSo3Dbv0S67/jCzW+2LoJ6/aZwVbgRV0CyzY=;
 b=0A6JsnqOd52H1mlScoC/5T6zA2OwSaaF3G8DVVR92WxABUo7dqPWHFuZcWUlU8P8fKNbz8XsNiEWIP1O0n+NtNxYZK+5gbckAML2ugRfHGh9W/2AN8uEKaExpe4PmbgDUCtYOcAmcFzDv1P2JeP01OpapN6jocmZVA6WDx+1QD0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Mon, 3 May
 2021 18:09:31 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4087.039; Mon, 3 May 2021
 18:09:31 +0000
Subject: Re: [PATCH] drm/amdkfd: fix no atomics settings in the kfd topology
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210503155705.102068-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <099773f7-ba4c-2024-bbb7-b8f3c2206acd@amd.com>
Date: Mon, 3 May 2021 14:09:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210503155705.102068-1-jonathan.kim@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YTXPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::43) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YTXPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.39 via Frontend Transport; Mon, 3 May 2021 18:09:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80b43829-950f-42c2-496e-08d90e5e9913
X-MS-TrafficTypeDiagnostic: BN9PR12MB5306:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5306A34EB2CC50849DF96A64925B9@BN9PR12MB5306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJnbGKXISXVsRwFj25FQf3SPZAwbjproZm44aIC6Zk4/RI3rMVG2yiVipEwFD0NA/uyvwAL0KlzYAGbEYWpJyGblthqfOb2L9ahffbr58UNbcqKTFQYjJjoxvUpVE/Spya3C63puQY8YwXivlR90mJ/W4etgeEX7dqjqIvr3tJcrHMCoPpbwSKxCNsnW8/cdOnKvQi/FtK186TX6JNODtIheKaWFu1BK3d1q8NPKw2m2OkTlythkz6bzjHV+Rbh42orLKDXjVr6fvyEF7MWfGXIZf+vTDDFSecfiL6CbQuTGTVszIZt8jpXqoxGH4cWd1CBiK7I6vaBpl8Vt6VGM3MDNga9u1809tyx5cYmkDnGpFabnAMVt/mfuMM+1P4WKxak6TdbCWb079/P6VJr7g8OcKEGoRnuOy40X+NyfHya2UmcUKAKv9XQNtryw8h9Rnit6DZDwFwkgCxdMzTYwn3ivkIUG9WTi23S7gjoegE6D+v8HwQTFck03yxckZ4AV4qDTovvDDqD6eiYR75grUlZCNFOshzkbRMUn81ELOwD1Jih1ZFjbyuABeD5TzIWaTI4eSVjs6cppdsw4OWs7Am2q3QDSPnNRX3mPj2hTE5qqVhVyPEPlui+FkC7wNkNxbFHNq9EwfDG5a+ZsYOyYUptJFLpgCrI5cMP6Heo7GYH6Vxn9vAbrBwHehfXh3cCq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(478600001)(31686004)(6486002)(66476007)(8676002)(83380400001)(86362001)(36756003)(66946007)(66556008)(956004)(8936002)(2906002)(16526019)(316002)(44832011)(16576012)(38100700002)(2616005)(31696002)(186003)(5660300002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V3dpQndTT0tUZC85em8yUEVPdHhsd2xFQ1BMVU5lMXRmMVFRejV6RmFNa3FT?=
 =?utf-8?B?VlhhQVlWUXR1cmU2YmJQMGE2QkgvOSs3UEJGSG02VU1SMDRxcXBQaFMwS1d0?=
 =?utf-8?B?QWU2ZlorZVdDMmNLK2NmYnAzSm9UMHo4c2R1YndtUXc2T0RVRk1HcE9mb1Vv?=
 =?utf-8?B?NWRrSm5QemdJbVpPVWNPMDRkUjArMGltVUpUcHEyemQvNEZxVzd3K2p5QTFQ?=
 =?utf-8?B?SUlsWGNET0lFdnlxZlN3Q0JrSDU4aWhSQ2cwMTJrcThmMHlXZmZRVWZhRVYr?=
 =?utf-8?B?T2s2cHdiY1V0N3lRNnhqS2VROFhHZGNINHFZWU9ybGpLb01ub3lhVFZUM0lz?=
 =?utf-8?B?TXgxOS9sRFF5WUo5RE9sWVRyekVabDV6bHlnTjdTT2k4L3ROQjZkUitjSUtF?=
 =?utf-8?B?TVJwTEd3UE9heG5pcHBGR2REQUhDUGVacGtxVXQyWlJKbEFWRHZScVJ5T084?=
 =?utf-8?B?WlZSdG9udlo2Nnp0akRRVU1QUmJnd1gzOGROd0w3UXJINktpTmx4T3A5ZFVK?=
 =?utf-8?B?ckZBcVFXMWg0aHQ2NEg5NjhDTlNYR2RrUzRPR0l4ZFhYT2s4bkRCdnFDUDE0?=
 =?utf-8?B?TGNUZWRHWU9wdHJPSWNieittZ0c0WlNCbktGR0VhVTlVdjRtWXM2dCtINEpq?=
 =?utf-8?B?cWdFOWRJbmpheDJRcEMrdjY2bjR6SVlFUVE3eXhPOTdoZmJNV0hOQk5XMnE2?=
 =?utf-8?B?cVQxbXdSWkxUR1FkUk5zV1k1Q083MDBJaTRVUWdDbFpqNkhJbTMwWnFhUkhH?=
 =?utf-8?B?Yjk2VHRTaSt2SytxRjgvd3VDdFN1Z2Q5NUhDUlc1cldHVXpjeWQwOVZYRGlV?=
 =?utf-8?B?NFMySk9uTTN5VVZrbHQ0endxc1Z2TG54ajM4SVVNUXJ2RkhUdG9rMTh1L3ZQ?=
 =?utf-8?B?UHpmNGNkQ1p5NW9uVUcwUlVRbVR3ZEJ1TmxQNUFLODRubUNvUVorbnB2UWlQ?=
 =?utf-8?B?S0VOT1hvK21ZUHMrSExZL1VoWERIOUg5ZGQyRndRLzdnNlg0aFNxWGdIbXJn?=
 =?utf-8?B?ejJrek5CSjBodW0xc3JhYUQ2MFMyZFl1eUczeDcrRDcwaDV4ZHJaUmJHRFlV?=
 =?utf-8?B?VkFna2p4L1cxY29yb0ZobEt2OHB0c3FvVnpZSmtuRXUwS1NqM1k5ZjFOYk1j?=
 =?utf-8?B?RU52WmNwbGM4c0VwUTRTNlNham12YkJMQmtRcXdxY3NoanZ4cW9xMUZ2V3pI?=
 =?utf-8?B?M0Yva0w1aDZBK2JXV1ZqTlNiQVUwbzFNK0VyK0ZldUY1dG9PbG1VaS9tc2VI?=
 =?utf-8?B?RTRxUWphSG5jSlZEQlVYK1NlbXFYWTlvd2VXOHhBT0VpbXlPdkMwOElmaUFp?=
 =?utf-8?B?K2lDMG9aZ0FkYk1yMm5lVW5jUHRpcVRGOUw5anRLM1oyZTZSVzl3Y3F6eDlO?=
 =?utf-8?B?bGNBWlpRaTB6TjkyL3RpNmlzNzk2Wks5MHRNbktIaitudWQzYmJXWFdZSWdB?=
 =?utf-8?B?SWMvc1ZKcDEyS2xNQmY5WngyNDVDU09LUHYrejU1R0cvdHcybC9XcTdCbmpn?=
 =?utf-8?B?MUJNSnd3T2xrdThsQU16aWNNQzc4S0JlVC9QcFkzS2ZqS084RXluWTJMTFdK?=
 =?utf-8?B?UGFKNjN4aVdGMFVyV2YvNFlHNlhjLzZVaUhlUVFOeEdHQ1g5VlZSR24wQm1t?=
 =?utf-8?B?dFJSeWUxL1V6Tk1hSThqUFEvSTNMeFpoU1dqYkZZbXh3NHFRbVpPZEttYkNN?=
 =?utf-8?B?c0kvbStGSXRVYVR5TUNLWXJSeWlTalpURDVqUTY1OUpyRTJnVjBiZzExaS9J?=
 =?utf-8?Q?Ui6E+iFRUTtM9WAKZLsnQx+uS54Q3bKUIQcu6wp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b43829-950f-42c2-496e-08d90e5e9913
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 18:09:30.8812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHTljGzvvb6Ah3pkmbuvWdcvG/S0Rs8zsihyiPw6pxNGoicRYn7ZILQ/JNq6YRjEzsWJ0HHgO46zGw3a8u9XIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5306
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

QW0gMjAyMS0wNS0wMyB1bSAxMTo1NyBhLm0uIHNjaHJpZWIgSm9uYXRoYW4gS2ltOgo+IFRvIGFj
Y291bnQgZm9yIHZhcmlvdXMgUENJZSBhbmQgeEdNSSBzZXR1cHMsIGNoZWNrIHRoZSBubyBhdG9t
aWNzIHNldHRpbmdzCj4gZm9yIGEgZGV2aWNlIGluIHJlbGF0aW9uIHRvIGV2ZXJ5IGRpcmVjdCBw
ZWVyLgoKVGhhbmtzLCB0aGlzIGxvb2tzIHJlYXNvbmFibGUuIFNvbWUgbW9yZSBuaXQtcGlja3Mg
YWJvdXQgbmFtaW5nIGFuZApjb2Rpbmcgc3R5bGUgaW5saW5lLgoKCj4KPiBTaWduZWQtb2ZmLWJ5
OiBKb25hdGhhbiBLaW0gPGpvbmF0aGFuLmtpbUBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyB8IDU1ICsrKysrKysrKysrKysrLS0tLS0t
LS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3ku
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jCj4gaW5kZXggMzA0
MzBhZWZjZmM3Li40MGFjN2ZlMmE0OTkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfdG9wb2xvZ3kuYwo+IEBAIC0xMTkyLDQ3ICsxMTkyLDYwIEBAIHN0YXRpYyB2b2lkIGtm
ZF9maWxsX21lbV9jbGtfbWF4X2luZm8oc3RydWN0IGtmZF90b3BvbG9neV9kZXZpY2UgKmRldikK
PiAgCQltZW0tPm1lbV9jbGtfbWF4ID0gbG9jYWxfbWVtX2luZm8ubWVtX2Nsa19tYXg7Cj4gIH0K
PiAgCj4gLXN0YXRpYyB2b2lkIGtmZF9maWxsX2lvbGlua19ub25fY3JhdF9pbmZvKHN0cnVjdCBr
ZmRfdG9wb2xvZ3lfZGV2aWNlICpkZXYpCj4gK3N0YXRpYyB2b2lkIGtmZF9zZXRfaW9saW5rX25v
X2F0b21pY3Moc3RydWN0IGtmZF90b3BvbG9neV9kZXZpY2UgKmRldiwKPiArCQkJCQlzdHJ1Y3Qg
a2ZkX3RvcG9sb2d5X2RldmljZSAqdGFyZ2V0X2dwdV9kZXYsCj4gKwkJCQkJc3RydWN0IGtmZF9p
b2xpbmtfcHJvcGVydGllcyAqbGluaykKPiAgewo+IC0Jc3RydWN0IGtmZF9pb2xpbmtfcHJvcGVy
dGllcyAqbGluaywgKmNwdV9saW5rOwo+IC0Jc3RydWN0IGtmZF90b3BvbG9neV9kZXZpY2UgKmNw
dV9kZXY7Cj4gLQlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldjsKPiAtCXVpbnQzMl90IGNhcDsK
PiAtCXVpbnQzMl90IGNwdV9mbGFnID0gQ1JBVF9JT0xJTktfRkxBR1NfRU5BQkxFRDsKPiAtCXVp
bnQzMl90IGZsYWcgPSBDUkFUX0lPTElOS19GTEFHU19FTkFCTEVEOwo+IC0KPiAtCWlmICghZGV2
IHx8ICFkZXYtPmdwdSkKPiArCS8qIHhnbWkgYWx3YXlzIHN1cHBvcnRzIGF0b21pY3MgYmV0d2Vl
biBsaW5rcy4gKi8KPiArCWlmIChsaW5rLT5pb2xpbmtfdHlwZSA9PSBDUkFUX0lPTElOS19UWVBF
X1hHTUkpCj4gIAkJcmV0dXJuOwo+ICAKPiAtCWFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KikoZGV2LT5ncHUtPmtnZCk7Cj4gLQlpZiAoIWFkZXYtPmdtYy54Z21pLmNvbm5lY3RlZF90b19j
cHUpIHsKPiAtCQlwY2llX2NhcGFiaWxpdHlfcmVhZF9kd29yZChkZXYtPmdwdS0+cGRldiwKPiAr
CS8qIGNoZWNrIHBjaWUgc3VwcG9ydCB0byBzZXQgY3B1KGRldikgZmxhZ3MgZm9yIHRhcmdldF9n
ZXRfZGV2IGxpbmsuICovCj4gKwlpZiAodGFyZ2V0X2dwdV9kZXYpIHsKPiArCQl1aW50MzJfdCBj
YXA7Cj4gKwo+ICsJCXBjaWVfY2FwYWJpbGl0eV9yZWFkX2R3b3JkKHRhcmdldF9ncHVfZGV2LT5n
cHUtPnBkZXYsCj4gIAkJCQlQQ0lfRVhQX0RFVkNBUDIsICZjYXApOwo+ICAKPiAgCQlpZiAoIShj
YXAgJiAoUENJX0VYUF9ERVZDQVAyX0FUT01JQ19DT01QMzIgfAo+ICAJCQkgICAgIFBDSV9FWFBf
REVWQ0FQMl9BVE9NSUNfQ09NUDY0KSkpCj4gLQkJCWNwdV9mbGFnIHw9IENSQVRfSU9MSU5LX0ZM
QUdTX05PX0FUT01JQ1NfMzJfQklUIHwKPiArCQkJbGluay0+ZmxhZ3MgfD0gQ1JBVF9JT0xJTktf
RkxBR1NfTk9fQVRPTUlDU18zMl9CSVQgfAo+ICAJCQkJQ1JBVF9JT0xJTktfRkxBR1NfTk9fQVRP
TUlDU182NF9CSVQ7Cj4gLQl9Cj4gLQo+IC0JaWYgKCFhZGV2LT5nbWMueGdtaS5udW1fcGh5c2lj
YWxfbm9kZXMpIHsKPiArCS8qIHNldCBncHUgKGRldikgZmxhZ3MuICovCj4gKwl9IGVsc2Ugewo+
ICAJCWlmICghZGV2LT5ncHUtPnBjaV9hdG9taWNfcmVxdWVzdGVkIHx8Cj4gIAkJCQlkZXYtPmdw
dS0+ZGV2aWNlX2luZm8tPmFzaWNfZmFtaWx5ID09Cj4gIAkJCQkJCQlDSElQX0hBV0FJSSkKPiAt
CQkJZmxhZyB8PSBDUkFUX0lPTElOS19GTEFHU19OT19BVE9NSUNTXzMyX0JJVCB8Cj4gKwkJCWxp
bmstPmZsYWdzIHw9IENSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfMzJfQklUIHwKPiAgCQkJ
CUNSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfNjRfQklUOwo+ICAJfQo+ICt9Cj4gKwo+ICtz
dGF0aWMgdm9pZCBrZmRfZmlsbF9pb2xpbmtfbm9uX2NyYXRfaW5mbyhzdHJ1Y3Qga2ZkX3RvcG9s
b2d5X2RldmljZSAqZGV2KQo+ICt7Cj4gKwlzdHJ1Y3Qga2ZkX2lvbGlua19wcm9wZXJ0aWVzICps
aW5rLCAqY3B1X2xpbms7Cj4gKwlzdHJ1Y3Qga2ZkX3RvcG9sb2d5X2RldmljZSAqY3B1X2RldjsK
ClRoZSBuYW1lcyBjcHVfbGluayBhbmQgY3B1X2RldiBhcmUgc3RpbGwgbWlzbGVhZGluZy4gV2hl
biBHUFVzIGhhdmUgWEdNSQpsaW5rcyB0aGVzZSBsaW5rcyBtYXksIGluIGZhY3QsIGJlIG90aGVy
IEdQVXMgYW5kIHRoZSBYR01JIGxpbmtzIGZyb20KdGhvc2UgR1BVcy4gSSB0aGluayBhIGJldHRl
ciBuYW1lIHdvdWxkIGJlICJwZWVyX2RldiIgYW5kICJpbmJvdW5kX2xpbmsiLgoKCj4gKwl1aW50
MzJfdCBmbGFnX2VuYWJsZSA9IENSQVRfSU9MSU5LX0ZMQUdTX0VOQUJMRUQ7CgpZb3UgZG9uJ3Qg
bmVlZCB0aGlzIHZhcmlhYmxlLiBKdXN0IHVzZSBDUkFUX0lPTElOS19GTEFHU19FTkFCTEVEIGJl
bG93LgoKCj4gKwo+ICsJaWYgKCFkZXYgfHwgIWRldi0+Z3B1KQo+ICsJCXJldHVybjsKPiAgCj4g
IAkvKiBHUFUgb25seSBjcmVhdGVzIGRpcmVjdCBsaW5rcyBzbyBhcHBseSBmbGFncyBzZXR0aW5n
IHRvIGFsbCAqLwo+ICAJbGlzdF9mb3JfZWFjaF9lbnRyeShsaW5rLCAmZGV2LT5pb19saW5rX3By
b3BzLCBsaXN0KSB7Cj4gLQkJbGluay0+ZmxhZ3MgPSBmbGFnOwo+ICsJCWxpbmstPmZsYWdzID0g
ZmxhZ19lbmFibGU7Cj4gKwkJa2ZkX3NldF9pb2xpbmtfbm9fYXRvbWljcyhkZXYsIE5VTEwsIGxp
bmspOwo+ICAJCWNwdV9kZXYgPSBrZmRfdG9wb2xvZ3lfZGV2aWNlX2J5X3Byb3hpbWl0eV9kb21h
aW4oCj4gIAkJCQlsaW5rLT5ub2RlX3RvKTsKPiArCj4gIAkJaWYgKGNwdV9kZXYpIHsKClRvIG1p
bmltaXplIGluZGVudGF0aW9uLCBJJ2QgZG8KCglpZiAoIXBlZXJfZGV2KQoJCWNvbnRpbnVlOwoK
PiAgCQkJbGlzdF9mb3JfZWFjaF9lbnRyeShjcHVfbGluaywKPiAtCQkJCQkgICAgJmNwdV9kZXYt
PmlvX2xpbmtfcHJvcHMsIGxpc3QpCj4gLQkJCQlpZiAoY3B1X2xpbmstPm5vZGVfdG8gPT0gbGlu
ay0+bm9kZV9mcm9tKQo+IC0JCQkJCWNwdV9saW5rLT5mbGFncyA9IGNwdV9mbGFnOwo+ICsJCQkJ
CSAgICAmY3B1X2Rldi0+aW9fbGlua19wcm9wcywgbGlzdCkgewo+ICsJCQkJaWYgKGNwdV9saW5r
LT5ub2RlX3RvID09IGxpbmstPm5vZGVfZnJvbSkgewo+ICsJCQkJCWNwdV9saW5rLT5mbGFncyA9
IGZsYWdfZW5hYmxlOwoKVG8gbWluaW1pemUgaW5kZW50YXRpb24sIGFuZCB0byBhdm9pZCB1bm5l
Y2Vzc2FyeSBsb29wIGl0ZXJhdGlvbnMsIEknZCBkbwoKCWlmIChpbmJvdW5kX2xpbmstPm5vZGVf
dG8gIT0gbGluay0+bm9kZV9mcm9tKQoJCWNvbnRpbnVlOwoJaW5ib3VuZF9saW5rLT5mbGFncyA9
IEtGRF9JT0xJTktfQ1JBVF9GTEFHU19FTkFCTEVEOwoJa2ZkX3NldF9pb2xpbmtfbm9fYXRvbWlj
cyhwZWVyX2RldiwgZGV2LCBpbmJvdW5kX2xpbmspOwoJYnJlYWs7CgpSZWdhcmRzLArCoCBGZWxp
eAoKCj4gKwkJCQkJa2ZkX3NldF9pb2xpbmtfbm9fYXRvbWljcyhjcHVfZGV2LCBkZXYsCj4gKwkJ
CQkJCQkJY3B1X2xpbmspOwo+ICsJCQkJfQo+ICsJCQl9Cj4gIAkJfQo+ICAJfQo+ICB9Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
