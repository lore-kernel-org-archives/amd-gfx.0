Return-Path: <SRS0=yA2I=GB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1D5C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Dec 2020 10:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF52207BC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Dec 2020 10:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF52207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 661FD8929C;
	Tue, 29 Dec 2020 10:13:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B46408929C
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Dec 2020 10:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q87lsuhNBzgXTq9uWKMOTeirzzur8oPg+AxTEljhyCfMEd05zCtYsJE++09sO00os44hAGgdiY/OPgaOGccZ5IoM5KLfzOokys7N5NnTA6ut4pNomnya+Amg/bBAZ/iAPLoobccfbogmkNlzzh+dZoJsiH/Ob5ReZOs+E9EOnTeVPkAPBBBSWWierkmwUTQ4L8dsmcGaI86rg5uU+VM6x6g+lcYtTzg6zYePO/2FQ7dVvcDk1c8AfA6CWytcQLbPJlvG8VGG/PhRIBmr8asnHWJoUDiyRZpLN2xd0TsJuQtlHq8HF/zea+w5326WlO6xO0sLbU55PWcR9Z4oq+8rVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5a/3g+m3ZaCDx3WYpdCLfbAfvacRL9SIJIvnPcU36Q=;
 b=oZBb4a7L+OyIi9AwiiMahPxQM4hcldGCch3c4/U1XJtRpYaYIHU9Kq6U3n9kSQ4Hxxp4cB0f0nPVH/x8FWjqwK6g2Og50XNZMVD2l0aotry6yHIVSmyVU5z/ZxxODngSYGwWoKpIKRkuSfFwpsfDALQiSiMKbLO201Erkl/3tsEXb/f28asSR69FmwEpPYlb7M6VCEc3SoDWKqKMoJppRnTUWbwmHkC6+z3UCJ1ebf9r/hivBVUiSp+XaEbxsTpdN6zGH1tQviDd+rbsj9wOTyWoGcPX5wNChRqDbD9I4YowDjZj3SRr4A0ZkhBB4y0yvQrRkfro9eWsLB8plg+KmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5a/3g+m3ZaCDx3WYpdCLfbAfvacRL9SIJIvnPcU36Q=;
 b=AMdixxBpBHBGH/uD4dl6gHMJWga45LQQFkEoQBmNwyzQ7Ft0YureVxLZWD4WtxfDAQ1eBGXRhP9Cg784tTpvv7rIaZkafiApvrklcFIqCI5V/mscqNxj8h3Wj1Vy4riTyMtjfis0LCpsvf0lHYehgn57SPirtbnbRntA4Fz256E=
Authentication-Results: loongson.cn; dkim=none (message not signed)
 header.d=none;loongson.cn; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4815.namprd12.prod.outlook.com (2603:10b6:208:1bf::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31; Tue, 29 Dec
 2020 10:13:03 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 10:13:02 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix macro name _AMDGPU_TRACE_H_ in
 preprocessor if condition
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20201226085607.155289-1-lichenyang@loongson.cn>
 <1898b3da-9958-ebd9-dc58-26168ee67653@molgen.mpg.de>
 <9dd7dbb4-cea0-da1d-042c-a2b5e69ef1bd@gmail.com>
 <72cdedf8-8850-2ad8-b8bc-d26eb1e2996f@molgen.mpg.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c77518e2-6e7b-6f32-e081-b88a408575d9@amd.com>
Date: Tue, 29 Dec 2020 11:12:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <72cdedf8-8850-2ad8-b8bc-d26eb1e2996f@molgen.mpg.de>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR02CA0080.eurprd02.prod.outlook.com
 (2603:10a6:208:154::21) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0080.eurprd02.prod.outlook.com (2603:10a6:208:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend
 Transport; Tue, 29 Dec 2020 10:13:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 77f7c778-4ebb-4adb-72f1-08d8abe2539a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4815:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4815219CA5CE0D76A3AC9F2E83D80@MN2PR12MB4815.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PScR+TyP74Gh9IUKbK5vA2TKk/hzlvgtTj5ODlNk3e551PzSrfieRkG0NxitgIK1wr2PhjcEILdalrgU1ygjqElABfM+SgjnFkHKrHmt7M+j9AkUrgrPRrTXzxSASyoT6MduIAqKjHW7Jt9jo67UA2GQj0UoBZLSGp49iscQmSjgGfuvPmVFZBcZ/b171kCkH8Bcccl1ghnED74GO2uHgSnyFUSlmaZ5ZtoD5jW9+KEEalPZMVOHMPmtDNRoPGwg4c0LO1dcY+jVTye63oOBu+Sbe0OfPwncsp0Nk8fqvxIT7ZWI6hqtJx75k0IzVM7l4+UeyW33yWhX9qgmZ5MDX1Ve5aslf/v6rx9/xjeoquVbFA8kFC594XsARh0y7/r+0ZvGmU0e+13oHcAkBhaJgv1hcDGT3shPvDHsffDIND34K8chc28P0VA/UBj0t7aT3mZ5IV1GODpQtCgW/WDXZXvjo0sxPDMGgpqUvKsxp0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(316002)(478600001)(16526019)(110136005)(31696002)(66476007)(31686004)(54906003)(66556008)(86362001)(5660300002)(66946007)(4326008)(36756003)(6486002)(52116002)(6666004)(2616005)(2906002)(8936002)(186003)(83380400001)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SVhSaXpLWS9xRDFodzR1MlhyMWFRQVlXb2ZEb0NwNUIyU0QwSEEvbjVGdGZk?=
 =?utf-8?B?NkNGT3dtUmJJZEZYZ2ZSS1E0eVRHMVVBdmtrZ3lKdWpTbVo2WUI0aTJ4Q3p0?=
 =?utf-8?B?OXhYN1ZneUE3eHJ3TUhDTkh5VDFaZjlqUlFPTk13Q0FnTWFiMm43dFQxT2NE?=
 =?utf-8?B?MmsxeVFQVXJLLzU3NzJxbjVCbnJhbUs2YTRIR1ZDYXRsY3ZBQWlmMldXalhT?=
 =?utf-8?B?TFRWdjYrckNpbkhDUXpGK3V0LzdiWGxzM25pWkt3MHJQTzd6d3JGYlpLNWpo?=
 =?utf-8?B?UzJUQktnSGFWcDFFMCt0TVkxV2tEMXcyMG1tYTJHbDhlcUxpcXo0c0FoREVy?=
 =?utf-8?B?SUVPZ09XUzEwRmMvRGJJUDJzZkZaQnRYWFRJMzZDUlhDNmFzMlVTbzQrSCsx?=
 =?utf-8?B?YmVpWHpPVGVSWXgwcXoyWFhPeXBQTGdoRXdQdy9yb01OQTJsbWpnTXphdyt4?=
 =?utf-8?B?L0l1Q3RMU1l3aDdmcGxxUklvVzdNSC9NSENWdWlXYWxpZkY0VmJZUHdFTmJj?=
 =?utf-8?B?R1hRU04rOUx4Q0U2eWx3VWxrTlpzMnRWNCt6SHY0WGk3VGwvenBpTGRjb04y?=
 =?utf-8?B?MitpWm0vSDJQeStxRVRMZEd2cFMwRjRuRGRTbnVWUCtYV2hYZnNjMlZzZkFK?=
 =?utf-8?B?Unl3eWNyelVGb2hCUnRXMGMyNElaSDhQZk9jYVRmT0kyYnowd29hekxubkln?=
 =?utf-8?B?eFhHRjlTNGQreWNEb0lRNmFFSG5UNnBYZHNDVFVlSWFnbVNkMWR2cXhna0lt?=
 =?utf-8?B?OFQ2RkJvOTVqNlBGaWNzcW1yZ0RMYWtYaGFTekJkNE1hMTFlYWU4Vit0bXl3?=
 =?utf-8?B?VTVPMzRvWjFqZEV4V2RZbGZuVzBvdWNJMVRMajhib1VROVhtZzJSandraHcy?=
 =?utf-8?B?WTJwbmpCcWNZK1BYTnJrQkJuWWdua1FLZkFRNDFxWnRsSFBRUGdXRWNsYlpz?=
 =?utf-8?B?eDRQS2Nyd2NsTnNQWTV6OVFRME9JTFJxSFhqYkJzVm9Zdlc0NXNtYXgzV20z?=
 =?utf-8?B?LzlOblRjUEQzZ1BTNnN5NmNwTk9Bc0xvQ0gycHhiR1NoMW11cHRCOUw5ek5W?=
 =?utf-8?B?eXdWMkNOSGUwQWVaUVhOU08way9zZWZUWlVCY1BUR24xQ2xqdnhxcWszcDUv?=
 =?utf-8?B?bUM5a1ZCQVlVVFFrdVl4VGw1SXhHYTlwdEtpVEk2THpWbWszQTRYTUYyQkhl?=
 =?utf-8?B?Y1QxOUhuNmxYak4zYVdCaFlQMkZHNWswWXVPTTlHekVCQkxIZHdacnV0RWJt?=
 =?utf-8?B?SitkaStrcngvTnA2NGtIUWE2NDZXTThXREtyazlZczVNTEEycnZESEk1MnVV?=
 =?utf-8?B?V1gvSUtRUUpqUFZHUEVFNUNobkREM0JoUjNJOEVaeTI4OFBqRks5NmtsQklm?=
 =?utf-8?B?cUtmZjNIdGp6MS94MUt3RjBaTzdwekRqeUI3cy9OeEljWm9DZHEyNDhKeUN0?=
 =?utf-8?Q?zbMn4il6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 10:13:02.3486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f7c778-4ebb-4adb-72f1-08d8abe2539a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8EJHvQ4NQMcaG0HzlpcqFhDcw438fyTBsCO+E8NeTzRVcM2pRBPNptT8K+uBgpM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4815
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Chenyang Li <lichenyang@loongson.cn>, Chen Guchun <Guchun.Chen@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjcuMTIuMjAgdW0gMTE6NTMgc2NocmllYiBQYXVsIE1lbnplbDoKPiBEZWFyIENocmlzdGlh
biwKPgo+Cj4gQW0gMjcuMTIuMjAgdW0gMTA6Mzggc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+
PiBBbSAyNi4xMi4yMCB1bSAxNDoxNiBzY2hyaWViIFBhdWwgTWVuemVsOgo+Cj4+PiBBbSAyNi4x
Mi4yMCB1bSAwOTo1NiBzY2hyaWViIENoZW55YW5nIExpOgo+Pj4+IEFkZCBhbiB1bmRlcnNjb3Jl
IGluIGFtZGdwdV90cmFjZS5oIGxpbmUgMjQgIl9BTURHUFVfVFJBQ0VfSCIuCj4+Pj4KPj4+PiBG
aXhlczogZDM4Y2VhZjk5ZWQwICgiZHJtL2FtZGdwdTogYWRkIGNvcmUgZHJpdmVyICh2NCkiKQo+
Pgo+PiBXZWxsIHRoaXMgRml4ZXMgdGFnIGlzIHN1cGVyZmx1b3VzL21pc2xlYWRpbmcgYW5kIHNo
b3VsZCBwcm9iYWJseSBiZSAKPj4gcmVtb3ZlZC4KPgo+IFdoeSBpcyBpdCBtaXNsZWFkaW5nPwoK
VGhlIHB1cnBvc2Ugb2YgYSBGaXhlcyB0YWcgaXMgdG8gZGlzdGluY3QgaW50byB3aGljaCBzdGFi
bGUgc291cmNlcyBhIApwYXRjaCBzaG91bGQgYmUgYWRkZWQuCgpFLmcuIGlmIHNvbWVib2R5IG1h
aW50YWlucyBhIGJhY2twb3J0IHdoaWNoIGhhcyB0aGUgb3JpZ2luYWxseSBidWdneSAKcGF0Y2gg
dGhlbiBoZSBjYW4gZmlndXJlIG91dCB0aGF0IGhlIG5lZWRzIHRoaXMgb25lIGFzIHdlbGwuCgpC
dXQgc2luY2UgdGhpcyBwcm9ibGVtIGlzIHRoZXJlIGZvciBhcyBsb25nIGFzIHRoZSBkcml2ZXIg
ZXhpc3RlZCB0aGF0IAppcyBwcmV0dHkgbXVjaCBzdXBlcmZsdW91cyBhbmQgY29uZnVzaW5nLgoK
Pgo+PiBXaHkgd2FzIHRoYXQgYWRkZWQ/Cj4KPiBJIGFza2VkIGZvciB0aGF0LCBiZWNhdXNlIHRo
YXQgaXMgdGhlIGNvbW1pdCBpbnRyb2R1Y2luZyB0aGUgaXNzdWUsIAo+IGFuZCB3aXRoIHRoYXQg
dGFnIGl04oCZc8KgIG1vcmUgbGlrZWx5IHRvIHBpY2tlZCBmb3IgdGhlIHN0YWJsZSBzZXJpZXMu
CgpBaCwgeWVzIHRoYXQgaXMgYSByYXRoZXIgZ29vZCBpZGVhLiBCdXQgd2Ugc2hvdWxkIHByb2Jh
Ymx5IHVzZSBhICJDQzogCnN0YWJsZUBrZXJuZWwub3JnIiB0YWcgaW5zdGVhZCBzaW5jZSB0aGlz
IHBhdGNoIGNhbiBiZSBhZGRlZCBwcmV0dHkgbXVjaCAKZXZlcnl3aGVyZS4KClRoYW5rcywKQ2hy
aXN0aWFuLgoKPgo+IFvigKZdCj4KPgo+IEtpbmQgcmVnYXJkcywKPgo+IFBhdWwKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
