Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2F9C12002
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 08:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E510B613C3
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 08:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E510B613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DA1E6E944;
	Fri, 16 Jul 2021 08:34:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF9166E944
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 08:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeyNl7Y1hYJ7Ng7wJStxn6dueJcbojQz/8XIrqHMttnjKd4OLTLwzveRiJx7yeov5INpV54exP2agNHCwhAWvtuOX/JfNIJV+Lcs9I1/rdJ7HG5Jh6WlnM0gikBO6RqIe/Uj0O7Y6WxEX2qg+CeqoTID3dhCPfC27NL+o1U9N3AY7VI68223lXaO6KYADg+MAsFpUy76UHOJ0qugfwgamcISaYrUdREUmbZK42z274up4DorYyX0TdHejanOePab2qpfMYJZ2x/ka1SUMZ68IkbHgHta2rQmchRZVFd1L67Qt3UChqN5cTW8wrnz9D73Zp1e1uVB15mhbo8HdRB4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vsfE5l6Fxh39D+ocIv13nu5IDMmQYsZSFd0iLiTYU4=;
 b=Q8l2Jc7efAKVmnEgiqRMNvPn2q8emmDnd7ATmk7tv3qhvnIzYr1V0CnwCXUhDhcCeFFED9kZscUQ/AsxfPcGv6n94fatNHMIWOgeLj74YsCh48HuZFYU1BZiH9wlsw0xPrxufZnaFZ6+yUm0rlO9LmyYT877ek088Izo6Z9IwfwtK/G0REBfMVqkvANS4xcniABgcBxi1iYcd8kkNwXg4YbkmzZerJBo9BdCyCJ04Gam52YDpn/4KHU0NBX6bSRLuALCCS5uK1WqbfgVP+y5+LAOHbq21NNRWFwT3A3Sl1elRVBJlMEszHu6DQwyhuk3gPa+4EnXKkV1PcjgLxcshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vsfE5l6Fxh39D+ocIv13nu5IDMmQYsZSFd0iLiTYU4=;
 b=ynjPdXWqC8HkgYwaqE5FbhzpATio9O0bzo6IQ6ePLoJAsMlf8k0ZeWUJJ836eLvekOQJkzFs50a9D6uRfBU4HKd5+Mm+JQvbY8ez4EfOAwrX4D7bVWqfay0M8nTX5EnhgDeVRBb+/XFJVCEwi0nv/kMhEQazaBUO+45zn+o3JFs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4608.namprd12.prod.outlook.com (2603:10b6:208:fd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 08:34:16 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 08:34:16 +0000
Subject: Re: [PATCH v3 1/3] drm/amdgpu: split amdgpu_device_access_vram() into
 two small parts
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210716082334.879149-1-kevin1.wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <694e2560-55c6-6520-d22d-9b3b4e79516d@amd.com>
Date: Fri, 16 Jul 2021 10:34:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210716082334.879149-1-kevin1.wang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0149.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::17) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:e013:2fad:8ece:8234]
 (2a02:908:1252:fb60:e013:2fad:8ece:8234) by
 PR0P264CA0149.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 08:34:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 215bfe39-2929-4096-12bd-08d948347ee2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4608:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB46080E1022DFBE3FCDCCD96A83119@MN2PR12MB4608.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z29bqXy2JLSYqb6Wmx7IvtCnX6swtp8agkG92RH0d7Yng/iHHjLnTjTEkoQNTOpnk29dvsOmxjryrdgeteykC7XP+5CD8yqmQSie0NqaHr1lsb8ImggyFIhlohDGm2/NoQQ8eY4WV72NWmhtbc+2nFkt9G4sBFS0J3QmcbTLYLK6CHqplQmCcryWItk4sleFEkNJVwOyVNgxG6R/iAB0lrsRnK5+Y0ic/2TDE7QTqaGjo+sz0Ja2vRWH1CfrvM3gL624K+9S4T9mrIzYPTPjTaUJWTegWknd6WXDBQoTKQ6yHUjAzwId9Og0WigpT2MWCWQP9ASK8rSiwFPV47uQHaj1BeLyUqvCLuJjcwbfhd/TUNHe3t1hmBp2pu/4/48Ld6fk67VJ+7AMwpSUzXt1ODt5HIpz5+sTlakzQ/DPK9k685m41HI8kAfCANXCRJLIzwhZJUv1Rz5cxZSVc4qxUTKs1G1LK8SG4KSDpwh0nCptGMh2bndk3S28GQQgy7a3ulBvFwxZBIKd6LfrGGelNsQ8xQ+wVIw3yXc6dRkm/9NhjCkLWUoAStVXtEdu6OZknk2ETia2sv2NfCrAar/QSnvt7J1Fm0V4Okv72kcQB5fYwZuPka7xaDeBc29OvKnWcGWp5YDPoPihwF6P8PtBVaVCqDNMTXYjnTT1Zb8rhtp3Rc2ObKpXTKgHRPgLPj93bYqybCPFM+iG/n93eA0ANTuWILJe0b7apZg4oCutW6l0vtqn9z91B299h54nVbzA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(478600001)(36756003)(31696002)(38100700002)(66574015)(186003)(86362001)(2906002)(316002)(6486002)(31686004)(5660300002)(6666004)(66556008)(83380400001)(4326008)(8676002)(8936002)(2616005)(66946007)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjRLSU1BdlRyOVJkZ0NzNGdvME9zQ1VsT0hYMU1qTGZkNFg2WFBtWllRVnkx?=
 =?utf-8?B?blZONlQ3dk5YeTRKbFdPcDFpQkVQWGFkb21UQStJS0wxSnRKeXFvRjdhY2NY?=
 =?utf-8?B?NXFHdENMcThMUURJWmRLTzlnRDB2QUpITlRUb21MK2orYW4xSjhERzZuRUZD?=
 =?utf-8?B?YlZmM08vaTVpdCtEOGdxa0NsQTg5ME9yUlllUmxDb3BzY0Jlbmtnak5BNGNr?=
 =?utf-8?B?RDdBcWRDN0k1TW5IOTVaUVE0blpqZ3BqQ0h4ZHN1OVVTR1BYRlFsMFNyeWYw?=
 =?utf-8?B?RUc3WURnUGZIVnF1SmZRWW10Umd0OVFTdWZRWUZCa0pKRTJqYkVyakp4RUZS?=
 =?utf-8?B?K2l6Q2pFanZjeDFNWGQ3UkJ5NTMyYWtVSkdwTkdjenBrUW9jM2YvcVFrZ3dB?=
 =?utf-8?B?VjBZeVJ2WHZoM21oN0JENHJlUy9uV0FlODBNOVZ5UW12eExpbGg1LzNZQWdP?=
 =?utf-8?B?U01rRHJQK253dktyQXVUR1VKMUt5YkMvckhBNjFocGQxTGZ0TnllMUJ5NzMz?=
 =?utf-8?B?aUYxSUd6d1JIL1lFV3NyQnNrK3BXR1lUZ0tYa1NmUWJpaHRTbFlpbkdsaCsr?=
 =?utf-8?B?ZnNBM2RTZksxYk9vVFdEZXpWdnNTV3lZWFpxa0lYcWtyQnFQcDM3WDZoQXNt?=
 =?utf-8?B?SjBoMW1OMmUwS2pCQkkrSHR1d3hmeXBDUzR1OFowUXd6VUptRExadFB4cVhK?=
 =?utf-8?B?NERabHhiTEUwaWJOM3dYZ3Bqb3piR2VpWTNDTGJmOW5xUEdSYStnS3VqeEh3?=
 =?utf-8?B?TFN4V3QrMmMxcGMwc0l1dEdRN284cCs0d0MrWnZwcEVldGZPeWJvTXhqMmpM?=
 =?utf-8?B?endLVnpHZDNiOVdzaU1wL0h0ZS9NenpMK0x0WXZ1S2hhNjhwSUNrR0M0NnlF?=
 =?utf-8?B?c21RU2p1dkNCajRob0o4cDhubmswaEdjUEhzUldLckdKVjgrWHhVWGo4RW9w?=
 =?utf-8?B?Q1BvZFBudkJ2V3pIZURveklkZHBQSm5pQkhQR0tpS2hsUTZkWjZVK0hNZnI0?=
 =?utf-8?B?NzE0Nk5BL2pXN1l6MGhSR2tuRUp3clNxTHROTVdBaEZqcmJkRG9NQ1hvc1Zi?=
 =?utf-8?B?eFZWL3l4YnFDQlhwSjFQaTZsVGwzUGxFd2UweGhWOUR6cFVsckdESzQ1eit3?=
 =?utf-8?B?dVE5eU9ON3JRWXBVUDhoajQ2b0dOS0pyeWtENFovYnpaWHhJOFNWeTZ4ZnZx?=
 =?utf-8?B?UVBCMlpxd2RaRjFJZ0hJdklHK2FpUDcrSjBaQzMrcUcrbWQ1SHdSSHlKRStC?=
 =?utf-8?B?VHM2WXpxR3RzTDIvV3cxVG5DZ3RIaUdUc3FubHdFMzJNY09GUm83U2xGVEla?=
 =?utf-8?B?OWFDeWVkeTJiS09zNzlzdzdiT1R1RitVdVlaU3ZxZUxSbnFaK0o1SHROUGZV?=
 =?utf-8?B?dGZwZlFSd2czWFh3czlEaHg4bU5SN3FHakhrdDRpY1JWNmdGNFZKYWFqMVNr?=
 =?utf-8?B?bHF4b1MzalBkZEREZlFFZTJPK3JFUkc5b3JrMnNHV1djUDdjYnYyNm52VThP?=
 =?utf-8?B?cnVlWVBGVmhSY2MyZGtjbjZuK1RkY0VySElIR0VjRGIyYU50NHRDVm1aYXBr?=
 =?utf-8?B?RnpDdmE3N0xjNnRhSUQ1QWxpVlk4Wk52ZnppRkhjRmxnMWVrUndSV1hPV2hk?=
 =?utf-8?B?VW5EZzN2Q0RpcUFCMlJXb0VpZXZNcnIvOVR6RUR3N3diMklqdFFsaCtkRE9P?=
 =?utf-8?B?eUltMXVrT1lESDJkTnBuQUd6TENESkVkcGV3bm1GdHVIUDUrWnRwWWY1akxI?=
 =?utf-8?B?b3hpK2hzTUNZbDlPMEt2by9yeUtIWW1ISGVyZ3lyZDcySVBQbEU2OCtpWCs0?=
 =?utf-8?B?dXhrb0Q0UnJ5RnNVRU8wV1pVQWVkdnZFbWlQUUlQbU44MkpIT0hyakNnbFda?=
 =?utf-8?Q?POiOELJOF6cxD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215bfe39-2929-4096-12bd-08d948347ee2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 08:34:15.6448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRLYAc3PAVXoEP3J1tZsU4zkE51KSk0CXTy9M+1nSA8QgpFvTlP1fXtRJ6KqtxUt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4608
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
Cc: alexander.deucher@amd.com, lijo.lazar@amd.com, frank.min@amd.com,
 hawking.zhang@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTYuMDcuMjEgdW0gMTA6MjMgc2NocmllYiBLZXZpbiBXYW5nOgo+IHNwbGl0IGFtZGdwdV9k
ZXZpY2VfYWNjZXNzX3ZyYW0oKQo+IDEuIGFtZGdwdV9kZXZpY2VfbW1fYWNjZXNzKCk6IHVzaW5n
IE1NX0lOREVYL01NX0RBVEEgdG8gYWNjZXNzIHZyYW0KPiAyLiBhbWRncHVfZGV2aWNlX2FwZXJf
YWNjZXNzKCk6IHVzaW5nIHZyYW0gYXBlcmF0dXJlIHRvIGFjY2VzcyB2cmFtIChvcHRpb24pCj4K
PiBTaWduZWQtb2ZmLWJ5OiBLZXZpbiBXYW5nIDxrZXZpbjEud2FuZ0BhbWQuY29tPgoKUmV2aWV3
ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gZm9yIHRo
ZSBzZXJpZXMuCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1Lmgg
ICAgICAgIHwgIDcgKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYyB8IDk4ICsrKysrKysrKysrKysrKystLS0tLS0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNzkg
aW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHUuaAo+IGluZGV4IDYxYTA4OTdlOTg0YS4uNTRjZjY0N2JkMDE4IDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKPiBAQCAtMTEwOSw4ICsxMTA5LDEzIEBAIGludCBhbWRn
cHVfZGV2aWNlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICB2b2lkIGFtZGdw
dV9kZXZpY2VfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7Cj4gICBpbnQgYW1kZ3B1
X2dwdV93YWl0X2Zvcl9pZGxlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKPiAgIAo+ICt2
b2lkIGFtZGdwdV9kZXZpY2VfbW1fYWNjZXNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBs
b2ZmX3QgcG9zLAo+ICsJCQkgICAgIHZvaWQgKmJ1Ziwgc2l6ZV90IHNpemUsIGJvb2wgd3JpdGUp
Owo+ICtzaXplX3QgYW1kZ3B1X2RldmljZV9hcGVyX2FjY2VzcyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwgbG9mZl90IHBvcywKPiArCQkJCSB2b2lkICpidWYsIHNpemVfdCBzaXplLCBib29s
IHdyaXRlKTsKPiArCj4gICB2b2lkIGFtZGdwdV9kZXZpY2VfdnJhbV9hY2Nlc3Moc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsIGxvZmZfdCBwb3MsCj4gLQkJCSAgICAgICB1aW50MzJfdCAqYnVm
LCBzaXplX3Qgc2l6ZSwgYm9vbCB3cml0ZSk7Cj4gKwkJCSAgICAgICB2b2lkICpidWYsIHNpemVf
dCBzaXplLCBib29sIHdyaXRlKTsKPiAgIHVpbnQzMl90IGFtZGdwdV9kZXZpY2VfcnJlZyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAkJCSAgICB1aW50MzJfdCByZWcsIHVpbnQzMl90
IGFjY19mbGFncyk7Cj4gICB2b2lkIGFtZGdwdV9kZXZpY2Vfd3JlZyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
Cj4gaW5kZXggZWIxZjNmNDJlMDBiLi4zN2ZhMTk5YmU4YjMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gQEAgLTI4NSw3ICsyODUsNyBAQCBib29s
IGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfc21hcnRfc2hpZnQoc3RydWN0IGRybV9kZXZpY2UgKmRl
dikKPiAgICAqLwo+ICAgCj4gICAvKioKPiAtICogYW1kZ3B1X2RldmljZV92cmFtX2FjY2VzcyAt
IHJlYWQvd3JpdGUgYSBidWZmZXIgaW4gdnJhbQo+ICsgKiBhbWRncHVfZGV2aWNlX21tX2FjY2Vz
cyAtIGFjY2VzcyB2cmFtIGJ5IE1NX0lOREVYL01NX0RBVEEKPiAgICAqCj4gICAgKiBAYWRldjog
YW1kZ3B1X2RldmljZSBwb2ludGVyCj4gICAgKiBAcG9zOiBvZmZzZXQgb2YgdGhlIGJ1ZmZlciBp
biB2cmFtCj4gQEAgLTI5MywxOSArMjkzLDYwIEBAIGJvb2wgYW1kZ3B1X2RldmljZV9zdXBwb3J0
c19zbWFydF9zaGlmdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQo+ICAgICogQHNpemU6IHJlYWQv
d3JpdGUgc2l6ZSwgc2l6ZW9mKEBidWYpIG11c3QgPiBAc2l6ZQo+ICAgICogQHdyaXRlOiB0cnVl
IC0gd3JpdGUgdG8gdnJhbSwgb3RoZXJ3aXNlIC0gcmVhZCBmcm9tIHZyYW0KPiAgICAqLwo+IC12
b2lkIGFtZGdwdV9kZXZpY2VfdnJhbV9hY2Nlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
IGxvZmZfdCBwb3MsCj4gLQkJCSAgICAgICB1aW50MzJfdCAqYnVmLCBzaXplX3Qgc2l6ZSwgYm9v
bCB3cml0ZSkKPiArdm9pZCBhbWRncHVfZGV2aWNlX21tX2FjY2VzcyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgbG9mZl90IHBvcywKPiArCQkJICAgICB2b2lkICpidWYsIHNpemVfdCBzaXpl
LCBib29sIHdyaXRlKQo+ICAgewo+ICAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4gLQl1aW50MzJf
dCBoaSA9IH4wOwo+ICsJdWludDMyX3QgaGkgPSB+MCwgdG1wID0gMDsKPiArCXVpbnQzMl90ICpk
YXRhID0gYnVmOwo+ICAgCXVpbnQ2NF90IGxhc3Q7Cj4gICAKPiArCUJVR19PTighSVNfQUxJR05F
RChwb3MsIDQpIHx8ICFJU19BTElHTkVEKHNpemUsIDQpKTsKPiArCj4gKwlzcGluX2xvY2tfaXJx
c2F2ZSgmYWRldi0+bW1pb19pZHhfbG9jaywgZmxhZ3MpOwo+ICsJZm9yIChsYXN0ID0gcG9zICsg
c2l6ZTsgcG9zIDwgbGFzdDsgcG9zICs9IDQpIHsKPiArCQl0bXAgPSBwb3MgPj4gMzE7Cj4gICAK
PiArCQlXUkVHMzJfTk9fS0lRKG1tTU1fSU5ERVgsICgodWludDMyX3QpcG9zKSB8IDB4ODAwMDAw
MDApOwo+ICsJCWlmICh0bXAgIT0gaGkpIHsKPiArCQkJV1JFRzMyX05PX0tJUShtbU1NX0lOREVY
X0hJLCB0bXApOwo+ICsJCQloaSA9IHRtcDsKPiArCQl9Cj4gKwkJaWYgKHdyaXRlKQo+ICsJCQlX
UkVHMzJfTk9fS0lRKG1tTU1fREFUQSwgKmRhdGErKyk7Cj4gKwkJZWxzZQo+ICsJCQkqZGF0YSsr
ID0gUlJFRzMyX05PX0tJUShtbU1NX0RBVEEpOwo+ICsJfQo+ICsKPiArCXNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJmFkZXYtPm1taW9faWR4X2xvY2ssIGZsYWdzKTsKPiArfQo+ICsKPiArLyoqCj4g
KyAqIGFtZGdwdV9kZXZpY2VfdnJhbV9hY2Nlc3MgLSBhY2Nlc3MgdnJhbSBieSB2cmFtIGFwZXJh
dHVyZQo+ICsgKgo+ICsgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCj4gKyAqIEBwb3M6
IG9mZnNldCBvZiB0aGUgYnVmZmVyIGluIHZyYW0KPiArICogQGJ1ZjogdmlydHVhbCBhZGRyZXNz
IG9mIHRoZSBidWZmZXIgaW4gc3lzdGVtIG1lbW9yeQo+ICsgKiBAc2l6ZTogcmVhZC93cml0ZSBz
aXplLCBzaXplb2YoQGJ1ZikgbXVzdCA+IEBzaXplCj4gKyAqIEB3cml0ZTogdHJ1ZSAtIHdyaXRl
IHRvIHZyYW0sIG90aGVyd2lzZSAtIHJlYWQgZnJvbSB2cmFtCj4gKyAqCj4gKyAqIFRoZSByZXR1
cm4gdmFsdWUgbWVhbnMgaG93IG1hbnkgYnl0ZXMgaGF2ZSBiZWVuIHRyYW5zZmVycmVkLgo+ICsg
Ki8KPiArc2l6ZV90IGFtZGdwdV9kZXZpY2VfYXBlcl9hY2Nlc3Moc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIGxvZmZfdCBwb3MsCj4gKwkJCQkgdm9pZCAqYnVmLCBzaXplX3Qgc2l6ZSwgYm9v
bCB3cml0ZSkKPiArewo+ICAgI2lmZGVmIENPTkZJR182NEJJVAo+ICsJdm9pZCBfX2lvbWVtICph
ZGRyOwo+ICsJc2l6ZV90IGNvdW50ID0gMDsKPiArCXVpbnQ2NF90IGxhc3Q7Cj4gKwo+ICsJaWYg
KCFhZGV2LT5tbWFuLmFwZXJfYmFzZV9rYWRkcikKPiArCQlyZXR1cm4gMDsKPiArCj4gICAJbGFz
dCA9IG1pbihwb3MgKyBzaXplLCBhZGV2LT5nbWMudmlzaWJsZV92cmFtX3NpemUpOwo+ICAgCWlm
IChsYXN0ID4gcG9zKSB7Cj4gLQkJdm9pZCBfX2lvbWVtICphZGRyID0gYWRldi0+bW1hbi5hcGVy
X2Jhc2Vfa2FkZHIgKyBwb3M7Cj4gLQkJc2l6ZV90IGNvdW50ID0gbGFzdCAtIHBvczsKPiArCQlh
ZGRyID0gYWRldi0+bW1hbi5hcGVyX2Jhc2Vfa2FkZHIgKyBwb3M7Cj4gKwkJY291bnQgPSBsYXN0
IC0gcG9zOwo+ICAgCj4gICAJCWlmICh3cml0ZSkgewo+ICAgCQkJbWVtY3B5X3RvaW8oYWRkciwg
YnVmLCBjb3VudCk7Cj4gQEAgLTMxNywzMCArMzU4LDM3IEBAIHZvaWQgYW1kZ3B1X2RldmljZV92
cmFtX2FjY2VzcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgbG9mZl90IHBvcywKPiAgIAkJ
CW1lbWNweV9mcm9taW8oYnVmLCBhZGRyLCBjb3VudCk7Cj4gICAJCX0KPiAgIAo+IC0JCWlmIChj
b3VudCA9PSBzaXplKQo+IC0JCQlyZXR1cm47Cj4gLQo+IC0JCXBvcyArPSBjb3VudDsKPiAtCQli
dWYgKz0gY291bnQgLyA0Owo+IC0JCXNpemUgLT0gY291bnQ7Cj4gICAJfQo+ICsKPiArCXJldHVy
biBjb3VudDsKPiArI2Vsc2UKPiArCXJldHVybiAwOwo+ICAgI2VuZGlmCj4gK30KPiAgIAo+IC0J
c3Bpbl9sb2NrX2lycXNhdmUoJmFkZXYtPm1taW9faWR4X2xvY2ssIGZsYWdzKTsKPiAtCWZvciAo
bGFzdCA9IHBvcyArIHNpemU7IHBvcyA8IGxhc3Q7IHBvcyArPSA0KSB7Cj4gLQkJdWludDMyX3Qg
dG1wID0gcG9zID4+IDMxOwo+ICsvKioKPiArICogYW1kZ3B1X2RldmljZV92cmFtX2FjY2VzcyAt
IHJlYWQvd3JpdGUgYSBidWZmZXIgaW4gdnJhbQo+ICsgKgo+ICsgKiBAYWRldjogYW1kZ3B1X2Rl
dmljZSBwb2ludGVyCj4gKyAqIEBwb3M6IG9mZnNldCBvZiB0aGUgYnVmZmVyIGluIHZyYW0KPiAr
ICogQGJ1ZjogdmlydHVhbCBhZGRyZXNzIG9mIHRoZSBidWZmZXIgaW4gc3lzdGVtIG1lbW9yeQo+
ICsgKiBAc2l6ZTogcmVhZC93cml0ZSBzaXplLCBzaXplb2YoQGJ1ZikgbXVzdCA+IEBzaXplCj4g
KyAqIEB3cml0ZTogdHJ1ZSAtIHdyaXRlIHRvIHZyYW0sIG90aGVyd2lzZSAtIHJlYWQgZnJvbSB2
cmFtCj4gKyAqLwo+ICt2b2lkIGFtZGdwdV9kZXZpY2VfdnJhbV9hY2Nlc3Moc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsIGxvZmZfdCBwb3MsCj4gKwkJCSAgICAgICB2b2lkICpidWYsIHNpemVf
dCBzaXplLCBib29sIHdyaXRlKQo+ICt7Cj4gKwlzaXplX3QgY291bnQ7Cj4gICAKPiAtCQlXUkVH
MzJfTk9fS0lRKG1tTU1fSU5ERVgsICgodWludDMyX3QpcG9zKSB8IDB4ODAwMDAwMDApOwo+IC0J
CWlmICh0bXAgIT0gaGkpIHsKPiAtCQkJV1JFRzMyX05PX0tJUShtbU1NX0lOREVYX0hJLCB0bXAp
Owo+IC0JCQloaSA9IHRtcDsKPiAtCQl9Cj4gLQkJaWYgKHdyaXRlKQo+IC0JCQlXUkVHMzJfTk9f
S0lRKG1tTU1fREFUQSwgKmJ1ZisrKTsKPiAtCQllbHNlCj4gLQkJCSpidWYrKyA9IFJSRUczMl9O
T19LSVEobW1NTV9EQVRBKTsKPiArCS8qIHRyeSB0byB1c2luZyB2cmFtIGFwcmVhdHVyZSB0byBh
Y2Nlc3MgdnJhbSBmaXJzdCAqLwo+ICsJY291bnQgPSBhbWRncHVfZGV2aWNlX2FwZXJfYWNjZXNz
KGFkZXYsIHBvcywgYnVmLCBzaXplLCB3cml0ZSk7Cj4gKwlzaXplIC09IGNvdW50Owo+ICsJaWYg
KHNpemUpIHsKPiArCQkvKiB1c2luZyBNTSB0byBhY2Nlc3MgcmVzdCB2cmFtICovCj4gKwkJcG9z
ICs9IGNvdW50Owo+ICsJCWJ1ZiArPSBjb3VudDsKPiArCQlhbWRncHVfZGV2aWNlX21tX2FjY2Vz
cyhhZGV2LCBwb3MsIGJ1Ziwgc2l6ZSwgd3JpdGUpOwo+ICAgCX0KPiAtCXNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJmFkZXYtPm1taW9faWR4X2xvY2ssIGZsYWdzKTsKPiAgIH0KPiAgIAo+ICAgLyoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
