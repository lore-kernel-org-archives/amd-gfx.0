Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147BEC48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 15:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69B0615A0
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 15:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69B0615A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 745436E3C4;
	Tue, 15 Jun 2021 15:34:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F156E3B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 15:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6TZxeGfO4/5Z0Cgk/WimHaHIucNcVXmYpatI5HdPE3xPrbGP1alS/eqgFnNNMIU99qC1JM9FvWl01BqPXdXriJkTUxdyGDEZd1ZCF0Sjm/MhDpppR0EFpdWpSvVDL06EfcQ1uRJXpo7/dJ/yWZ8mW8moI8+sn+qzlN1hCKKazX3xp2S7/YRRjigz/IIOx/wwUi5kD5lyXGJj+LZ+ld1YBPU834BLjQFAmrW82MwuOl0Q7A0jy3xCSDOTnlo5RclcQdmvFL2XhEgOF5J1Hjk/PVfJysFFCO6o7MrVjGTCstwZ8wLo4bFpK6+0giNsRJb5sk5IeqapzUW1YMBomxt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJXDedaC5I4+bZGJ/HBFuSADmwj7mGTMh1w0tnCBpdo=;
 b=YkYNlTkDFxNZplzt7tEdPw0vcBHCHHptBfdR6eF+VoR6dTfQDHnMKHfRcEww5w4mZSkRIPXTc5RbktTCIiRe5LQ2KjQcsOyafoRULkLqurAS0mmsxGWqsiSEqy+i2rf9gEGZ+LlU0G/R0Rc6d5TRH9hOsPTvsaHaBVD36fgozUSX7PQDpgncxQlqXqdQ321x4kuZj7RFBCz0X8QhvV3Oi7j+Swc+29crkfcAN+QrodPougOND9Ybnbaoxql+YfXWQpIgX7MjI0xm0vr5fHuBjTVlb3gkSVfuY7pEhHvXbibIxrlInkGY5a8b8Tpf/kK5jLbu/gYX8YOawaAN21AVHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJXDedaC5I4+bZGJ/HBFuSADmwj7mGTMh1w0tnCBpdo=;
 b=TbiPG/B5z/5NdjQHyWd+c0srXkoojkN3YosBCyDFgFWlEUCpacaKwXDIYoF5pCUO6mdowkDqGektjfa6qtC2LFWrdFfcDGE8vAiPcUMICp+CIU+vx1aq0PER0PAA7DROcSEH14yIEBuCIWu5fB53V/ThTdJj66ZzssnrPR901Ao=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5148.namprd12.prod.outlook.com (2603:10b6:408:119::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 15:34:09 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 15:34:09 +0000
Subject: Re: [PATCH] drm/amdkfd: Fix a race between queue destroy and process
 termination
From: Felix Kuehling <felix.kuehling@amd.com>
To: xinhui pan <xinhui.pan@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210615080233.14596-1-xinhui.pan@amd.com>
 <8717418e-8036-944d-b688-586655fe9081@amd.com>
Message-ID: <55b08be1-20d5-c456-e7b3-b5bf36c454d3@amd.com>
Date: Tue, 15 Jun 2021 11:34:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <8717418e-8036-944d-b688-586655fe9081@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.203.225]
X-ClientProxiedBy: YT1PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::15)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.203.225) by
 YT1PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Tue, 15 Jun 2021 15:34:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abd45d29-54e5-4412-f395-08d9301304db
X-MS-TrafficTypeDiagnostic: BN9PR12MB5148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51482E2600D98EC48EAC13FE92309@BN9PR12MB5148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZmaCyliBLxKjJrLeWrm5Yqd2jwHPTpglExmV8vamhV1K70n2D4AXbYdKlH7P2qLvyk1yv0u6YcSoEOCPSCseitLcfA8MeMT0Rpv2VStkGnO0nixL0C1yq4nJ1PwK1T2f5dUzLUpXDBJ/awSbdaMWC5nP0uWxIZ65mOH+nIk6OiE9cRCfNi88oJOthOADGZJ5z9y3mHl7gDtCmqijENyyNofXEGe9aZH58XR3Howu0ahN4SZwKvShbPvZtCj2EU3JA7aK8XXmoMPCwoa11t80rlQgJPcZj70X3TFgOIjEdlfXUo+sMvQTpbughk0dXO0KcXGN/Qc/9NfoQZbgTgf41H5fp9+sSVrMVBFVGNeGn+jN2A69tQ/LN0PKHdIy7hZgnRUsZUn/7ewW6sCeVcr5nhgsDET46DMyQLoIr4qQ4Mh0VyaW3OSXAKyG5nW2UvSe2TtFIHW9JAERvK/Zo+36GUjdVXKeUdkQwowhvbNZJm7ZTSo7MW6xVVU7s7rkCA1PmL4PYvW0e1v+9djLBdIhQj3BmBb+esJEDh1c3FgszzjiMkTM4D7K8AmLrdgaH9l4AScNIiNbuIu0euz8qPJf6BSyfxjI+GF1ijl9Mb7nDZAJdWDKumVsAMua9QNSifCg0jlYJiHt8IyhjP02NGMvWk68OlkVG/VDHR52J5UpyJhDqf6fcc28FVMpdxW/+eE7Lr/WtkXEAxBvXiq5IOxWLKIG3iG9lLZSJzigX101sQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(316002)(6486002)(26005)(478600001)(16576012)(966005)(4326008)(2906002)(36756003)(86362001)(956004)(16526019)(31686004)(186003)(83380400001)(2616005)(38100700002)(8676002)(66556008)(66476007)(110136005)(5660300002)(31696002)(44832011)(8936002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEZuTVcyTHhlbmFNZVJZbG5YYzF5QTBvbnUwdkVFY24yZzJrR2J1MUYvWC9T?=
 =?utf-8?B?WmhWOW1zSUtvUmMwMklicHRMdEFaUHVQZVI0SE1ac0svL2NGT2ZCZVkvSGtm?=
 =?utf-8?B?aS8rcXZQdFNnZmY1Ly9lMWR6ZGVtOXNYNm1acXhOcWNrSStYY01PNDhzb1dL?=
 =?utf-8?B?VFBmNFpCVk1XdVpMckxaRjlyZFl4YU1QSGVDZjFkRlF4QnhOVUxubkdNa2NP?=
 =?utf-8?B?ZWlWWFRCcFE1eGlaNTRrQURudFlHQm5RNkNhQzRGVEwyZUJKUmZ5aGorV1Nm?=
 =?utf-8?B?L0RRQnBlUDVjNnZaQVRuN2FIRk9zeGZYS3NHc0tYQ3ZoNThJOE1pMU92NDZ1?=
 =?utf-8?B?MmdPdHVnSWhnSVBFdDRPQURwV0lSSjk0SnBiYVBiTHI3OFZIQ3IvY01Fb2xJ?=
 =?utf-8?B?dWdCLytCS2ZUcTRlc1JwREpRRUVlQ0E3b3hJSzFkWXp2ek5rNm5iYTJVOTBh?=
 =?utf-8?B?cng2TWZKck9lTlJvT3ErMzJrV1M2N0RyNVVCVXYrbGhGMHdaUm9Ld2dQTm5m?=
 =?utf-8?B?UkxXcjU3d1M0SWhHWS9tcWIrRFJDN1c0eTlyTDZtSFJ6ZXc4NkNlWlovM3Z5?=
 =?utf-8?B?K3h4SmVJbnFTMFJpRW0vZ1JLZ3N3NE1FVFg5NGVFQXFibDFVZ1hCY3VQdDJZ?=
 =?utf-8?B?UGlqcjczTkRPdkdDWDNWZ1J1b080YmQ2a1oyVUhwN2hNNnM1Y0d0ODhnWjlZ?=
 =?utf-8?B?bU9ORTlNUjRUWTU5UnUrOGp1eE56eStLaTNjUDdwOXFReVdrWW9WYmh2Ymhw?=
 =?utf-8?B?UEZIWmRGMjh1RlZIQ3FuNVZwWTZUc1Z4OHdRUDU0VldzbGRhWjdhUnl2blNI?=
 =?utf-8?B?bU80UnVlcllmVnJwTWwrRjM4MlhxdlUxdDZVZmt0R1A1MmJkMGJQQkVUcjM3?=
 =?utf-8?B?OVdPbGR4M3pvaWRFdG95NjNVSWVNTlR5T3BjUnVjZ1plSEpRaTBRT3VsRzQ5?=
 =?utf-8?B?MGxaY1lpcUljd3d1M2g0WDJncFJJQXB5NGZNSnZpMW9uY3NETThmZHpYb21Y?=
 =?utf-8?B?T0J1MWZSb0gvSTJvQWdQQVZRdVdydmlUM1ppa2thQVVZRUZoSHBubnNzNWtj?=
 =?utf-8?B?U2hDL3NZQ1J1VldYUUxnTHBNWGg2V09hVUsySFNCYjk1ZzY5OEpNWkNOaHIw?=
 =?utf-8?B?Vjc4bEljQ2tmdlNBclpIdmNyb3BOd1BSSDFaR0M4T3ZZcjBTejZBcUZFaTJF?=
 =?utf-8?B?T3hqQTlPNUVQZ3lmUzlWR0NwenVLV0R4dUp0bklsOWxOWnZNUUduNmZlbUky?=
 =?utf-8?B?RmJZWXQyR1UvVVBNbmhBamJGL2lkdUxHWXZWdDJiVHdxTmJJY2Z3S1R4VFNq?=
 =?utf-8?B?d2JJOVhjSStlQno0YzFFckczMGJrTEVPcG9FV0FValJtTDdUYWpwMk5IMzRG?=
 =?utf-8?B?TnNKVnJLdjhMZWE3SFNHZ0xFU1RYRmwyVXpVT3RzUFVKYzBVSVNyZ2ltaVJy?=
 =?utf-8?B?MlVtbWZCM2lsYjRuU092cXY2OEJFREdlS1JjMWpTOUQ4bTJqTENHZG1Ra3Jl?=
 =?utf-8?B?MnpudFRWMHFVMS9JWEloaWZRMEZwODdZTjBTNGwzbGZPZ0ZnQ3BzOWtJeGhB?=
 =?utf-8?B?K3ZGL0lJRUMwQVA2NWV0RGltR2hycGtHUUt0cFJ3MVFScVZweTAwZldzdmI2?=
 =?utf-8?B?RS9IRTRnRTlJK3ZoMHF6a0NMLy90ZEpOVllHSEo4cSt3aTZxYjYyRUxoMTQ3?=
 =?utf-8?B?QXM1bnBuTFhTWjFCRzJlUWdsWFJUTXVQemt2Vnc5TmQ0NGZDZTd5VTBlcjR6?=
 =?utf-8?Q?dgNJSyoqHl/GHyxq3E3bstDuATBopixKQzm9fgc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd45d29-54e5-4412-f395-08d9301304db
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 15:34:09.4666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LY+QQsG3SkhCktMPFwHONTh3jsapEaym28G1dEhHRt03YJ0T2okOP91kunQifz6dSkGcLAHc6RtkmkIDbO3zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5148
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNi0xNSB1bSAxMTozMiBhLm0uIHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4gWytB
bWJlciwgbW92aW5nIGFtZC1nZnggdG8gQkNDXQoKQWN0dWFsbHkgZGlkbid0IG1vdmUgaXQgdG8g
QkNDLiBCdXQgbGV0J3Mgbm90IG5hbWUgdGhhdCBOUEkgYnJhbmNoIGluCnB1YmxpYy4gOykKClRo
YW5rcywKwqAgRmVsaXgKCgo+Cj4gQW1iZXIgd29ya2VkIG9uIGEgcmVsYXRlZCBwcm9ibGVtIG9u
IGFuIE5QSSBicmFuY2ggcmVjZW50bHkgaW4gdGhlCj4gbm9jcHNjaCB2ZXJzaW9uIG9mIHRoaXMg
Y29kZS4gV2Ugc2hvdWxkIHBvcnQgdGhhdCBmaXggdG8KPiBhbWQtc3RhZ2luZy1kcm0tbmV4dC4g
VGhlbiBsZXRzIGNvbWUgdXAgd2l0aCBhIGNvbW1vbiBzb2x1dGlvbiBmb3IgdGhlwqAKPiBjcHNj
aCBjb2RlIHBhdGggYXMgd2VsbC4KPgo+IFNlZSBvbmUgY29tbWVudCBpbmxpbmUuCj4KPgo+IEFt
IDIwMjEtMDYtMTUgdW0gNDowMiBhLm0uIHNjaHJpZWIgeGluaHVpIHBhbjoKPj4gV2UgY2FsbCBm
cmVlX21xZCB3aXRob3V0IGRxbSBsb2NrIGhvbGQsIHRoYXQgY2F1c2VzIGRvdWJsZSBmcmVlIG9m
Cj4+IG1xZF9tZW1fb2JqLiBGaXggaXQgYnkgdXNpbmcgYSB0bXAgcG9pbnRlci4KPj4gV2UgbmVl
ZCB3YWxrIHRocm91Z2ggdGhlIHF1ZXVlc19saXN0IHdpdGggZHFtIGxvY2sgaG9sZC4gT3RoZXJ3
aXNlIGhpdAo+PiBsaXN0IGNvcnJ1cHRpb24uCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBw
YW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4KPj4gLS0tCj4+ICAuLi4vZHJtL2FtZC9hbWRrZmQva2Zk
X2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMgICB8IDE3ICsrKysrKysrKysrKystLS0tCj4+ICAxIGZp
bGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdl
ci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2Vy
LmMKPj4gaW5kZXggZTYzNjZiNDA4NDIwLi41NzVjODk1ZmMyNDEgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jCj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5j
Cj4+IEBAIC0xNDg0LDYgKzE0ODQsNyBAQCBzdGF0aWMgaW50IGRlc3Ryb3lfcXVldWVfY3BzY2go
c3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0sCj4+ICAJc3RydWN0IG1xZF9tYW5hZ2Vy
ICptcWRfbWdyOwo+PiAgCXVpbnQ2NF90IHNkbWFfdmFsID0gMDsKPj4gIAlzdHJ1Y3Qga2ZkX3By
b2Nlc3NfZGV2aWNlICpwZGQgPSBxcGRfdG9fcGRkKHFwZCk7Cj4+ICsJdm9pZCAqcHRyID0gTlVM
TDsKPj4gIAo+PiAgCS8qIEdldCB0aGUgU0RNQSBxdWV1ZSBzdGF0cyAqLwo+PiAgCWlmICgocS0+
cHJvcGVydGllcy50eXBlID09IEtGRF9RVUVVRV9UWVBFX1NETUEpIHx8Cj4+IEBAIC0xNTQzLDEw
ICsxNTQ0LDEyIEBAIHN0YXRpYyBpbnQgZGVzdHJveV9xdWV1ZV9jcHNjaChzdHJ1Y3QgZGV2aWNl
X3F1ZXVlX21hbmFnZXIgKmRxbSwKPj4gIAlwcl9kZWJ1ZygiVG90YWwgb2YgJWQgcXVldWVzIGFy
ZSBhY2NvdW50YWJsZSBzbyBmYXJcbiIsCj4+ICAJCQlkcW0tPnRvdGFsX3F1ZXVlX2NvdW50KTsK
Pj4gIAo+PiArCXN3YXAocHRyLCBxLT5tcWRfbWVtX29iaik7Cj4+ICAJZHFtX3VubG9jayhkcW0p
Owo+PiAgCj4+ICAJLyogRG8gZnJlZV9tcWQgYWZ0ZXIgZHFtX3VubG9jayhkcW0pIHRvIGF2b2lk
IGNpcmN1bGFyIGxvY2tpbmcgKi8KPj4gLQltcWRfbWdyLT5mcmVlX21xZChtcWRfbWdyLCBxLT5t
cWQsIHEtPm1xZF9tZW1fb2JqKTsKPj4gKwlpZiAocHRyKQo+PiArCQltcWRfbWdyLT5mcmVlX21x
ZChtcWRfbWdyLCBxLT5tcWQsIHB0cik7Cj4+ICAKPj4gIAlyZXR1cm4gcmV0dmFsOwo+PiAgCj4+
IEBAIC0xNzA5LDYgKzE3MTIsNyBAQCBzdGF0aWMgaW50IHByb2Nlc3NfdGVybWluYXRpb25fY3Bz
Y2goc3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0sCj4+ICAJZW51bSBrZmRfdW5tYXBf
cXVldWVzX2ZpbHRlciBmaWx0ZXIgPQo+PiAgCQlLRkRfVU5NQVBfUVVFVUVTX0ZJTFRFUl9EWU5B
TUlDX1FVRVVFUzsKPj4gIAlib29sIGZvdW5kID0gZmFsc2U7Cj4+ICsJdm9pZCAqcHRyID0gTlVM
TDsKPj4gIAo+PiAgCXJldHZhbCA9IDA7Cj4+ICAKPj4gQEAgLTE3MzcsOCArMTc0MSw2IEBAIHN0
YXRpYyBpbnQgcHJvY2Vzc190ZXJtaW5hdGlvbl9jcHNjaChzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21h
bmFnZXIgKmRxbSwKPj4gIAkJCQlxcGQtPm1hcHBlZF9nd3NfcXVldWUgPSBmYWxzZTsKPj4gIAkJ
CX0KPj4gIAkJfQo+PiAtCj4+IC0JCWRxbS0+dG90YWxfcXVldWVfY291bnQtLTsKPj4gIAl9Cj4+
ICAKPj4gIAkvKiBVbnJlZ2lzdGVyIHByb2Nlc3MgKi8KPj4gQEAgLTE3NzAsMTMgKzE3NzIsMjAg
QEAgc3RhdGljIGludCBwcm9jZXNzX3Rlcm1pbmF0aW9uX2Nwc2NoKHN0cnVjdCBkZXZpY2VfcXVl
dWVfbWFuYWdlciAqZHFtLAo+PiAgCS8qIExhc3RseSwgZnJlZSBtcWQgcmVzb3VyY2VzLgo+PiAg
CSAqIERvIGZyZWVfbXFkKCkgYWZ0ZXIgZHFtX3VubG9jayB0byBhdm9pZCBjaXJjdWxhciBsb2Nr
aW5nLgo+PiAgCSAqLwo+PiArCWRxbV9sb2NrKGRxbSk7Cj4+ICAJbGlzdF9mb3JfZWFjaF9lbnRy
eV9zYWZlKHEsIG5leHQsICZxcGQtPnF1ZXVlc19saXN0LCBsaXN0KSB7Cj4+ICAJCW1xZF9tZ3Ig
PSBkcW0tPm1xZF9tZ3JzW2dldF9tcWRfdHlwZV9mcm9tX3F1ZXVlX3R5cGUoCj4+ICAJCQkJcS0+
cHJvcGVydGllcy50eXBlKV07Cj4+ICAJCWxpc3RfZGVsKCZxLT5saXN0KTsKPj4gIAkJcXBkLT5x
dWV1ZV9jb3VudC0tOwo+PiAtCQltcWRfbWdyLT5mcmVlX21xZChtcWRfbWdyLCBxLT5tcWQsIHEt
Pm1xZF9tZW1fb2JqKTsKPj4gKwkJZHFtLT50b3RhbF9xdWV1ZV9jb3VudC0tOwo+PiArCQlzd2Fw
KHB0ciwgcS0+bXFkX21lbV9vYmopOwo+PiArCQlkcW1fdW5sb2NrKGRxbSk7Cj4gVGhpcyBzdGls
bCByaXNrcyBsaXN0IGNvcnJ1cHRpb24gYmVjYXVzZSB0aGUgbGlzdCBjYW4gYmUgbW9kaWZpZWQg
d2hpbGUKPiB0aGUgbG9jayBpcyBkcm9wcGVkLiBIb3dldmVyIHlvdSBjYW4gbWFrZSBpdCBzYWZl
IGJ5IGNoYW5naW5nIHRoZSBsb29wCj4gdG8gc29tZXRoaW5nIGxpa2UKPgo+IAlkcW1fbG9jayhk
cW0pOwo+IAl3aGlsZSAoIWxpc3RfZW1wdHkoLi4uKSkgewo+IAkJcSA9IGxpc3RfZmlyc3RfZW50
cnkoLi4uKTsKPiAJCWRxbV91bmxvY2soZHFtKTsKPiAJCS4uLgo+IAkJbXFkX21nci0+ZnJlZV9t
cWQoLi4uKTsKPiAJCS4uLgo+IAkJZHFtX2xvY2soZHFtKTsKPiAJfQo+IAlkcW1fdW5sb2NrKCk7
Cj4KPiBSZWdhcmRzLAo+IMKgIEZlbGl4Cj4KPgo+PiArCQlpZiAocHRyKQo+PiArCQkJbXFkX21n
ci0+ZnJlZV9tcWQobXFkX21nciwgcS0+bXFkLCBwdHIpOwo+PiArCQlkcW1fbG9jayhkcW0pOwo+
PiAgCX0KPj4gKwlkcW1fdW5sb2NrKGRxbSk7Cj4+ICAKPj4gIAlyZXR1cm4gcmV0dmFsOwo+PiAg
fQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1k
LWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
