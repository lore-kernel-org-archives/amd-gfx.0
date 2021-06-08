Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A00C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 12:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305BC61351
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 12:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305BC61351
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D6F6E160;
	Tue,  8 Jun 2021 12:02:40 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FFD06E160
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 12:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRU+452n7TBtcmS2hHcCxHgps3weG5EYzN4dywng+ZiWTwDq/QdoPe1ntjqxgPDSGhhVDvzrbynsl106vVkeS+BEwqfNspTSTqP9cEf6pu3SUxaLE8Vco5lVs8lRfOqSV0aXAzMHBIa1n5eTxJJe11PmFk4nmxisAMr8+ROB9zPXhJLhz0MvJRC0EyWQFmt2wmEUP4nv0MxAGcOoh8k9pBGP4D7dub8ymZg+IkQhtQBLRHWx0d/J7gWHOIqGlnNuI89sog359dhvv6qjOQT6G0Ay9xgG/HEgKo8IoShsVNMWHFBEOIKrCnfKEh2xgg3Um/8/0dkaB0Ci9tFPbmXhlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WH31lkGjKVD0EcKlUuxFZxn60srUtJjk1phIvgTimgM=;
 b=XW9fT8hRoH7p2se/UCavI4BbyN6e9EABFc53IJhjazGtYO5+Kx6Au5EW9ZgJahdRM8ZQhJjoU59KVoBOsqT+ANq0t+s/B/jgrU65DzNdj9ra/UoMO2E9NWR1rLeEeQADWv6VUaI+ZON+Yd+BrXFH5odNi5W3n9dunLOGf4EtNJB8xq2sdBH6b22GKA9g6pA19ctBKL5Ixeup0XRNiZR4jUyNBNACs42YFoWnKnXU1pSl9f8y/qe0u+yTxYTQ/PPOeCZ5O8XPgby8h/wNU1L8mz58GdkFaSXP55Bc5tld6Tlf5bPsDbS+FwhPnPpa/dB2B+QUQSq9IYzjJomQLd8plQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WH31lkGjKVD0EcKlUuxFZxn60srUtJjk1phIvgTimgM=;
 b=wt+T5uqCwZLs+hbV6udqOKeCMKRUzUzIuXLbXTfz2naszc2vztiDsr5Wmg9SZwMgvOUVkhAM2eBEi7POSe/BgcHnTwk9p1yH980pHBbV/S0tAgIf4huTX5ozVJ2fHE7CKzKHiZa5KPtqmVT3r9+bcl4k3QpeHKYln77N9xioxZE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5494.namprd12.prod.outlook.com (2603:10b6:8:24::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.22; Tue, 8 Jun 2021 12:02:37 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.037; Tue, 8 Jun 2021
 12:02:37 +0000
Subject: Re: [PATCH v2 1/1] drm/amdkfd: use allowed domain for vmbo validation
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20210608112714.50475-1-nirmoy.das@amd.com>
 <915174f0-0341-6465-5775-4220de577720@gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <b1c3b109-38d3-cda3-a733-147f904c038d@amd.com>
Date: Tue, 8 Jun 2021 14:02:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <915174f0-0341-6465-5775-4220de577720@gmail.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f2b:6400:c449:165a:413d:7e84]
X-ClientProxiedBy: PR3P193CA0017.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::22) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2b:6400:c449:165a:413d:7e84]
 (2003:c5:8f2b:6400:c449:165a:413d:7e84) by
 PR3P193CA0017.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.20 via Frontend Transport; Tue, 8 Jun 2021 12:02:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c13416f8-4703-4583-5031-08d92a754ee4
X-MS-TrafficTypeDiagnostic: DM8PR12MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54945F7268B24948EB9277018B379@DM8PR12MB5494.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XNV8KWaJSJnZPM+90IP1ek4iX4Od+rmqtBPKFtfq1lp1WCINuZZMGHF7brLLisFPxHKcaw//qbT5wMUZ5MQm9+JF33AkBBedWnnHyaeUAzt4N7hmVg54ynEpIbO2cTCxDALEcNGH0D6L/JFaB14yISJ5NFATlVaqYMtQgSKcq703opFcIlcpXfvsU5HeW6fN9cyQsSAXobFVe4U/e1dMYK6R77tNe1XBvZdK0QvRuiPkHUgWmZmC5I6ed0vfAC1uFTkM3NYLGDsS4f7DHhYBcws+mr4qTDEAP7JPKNlwd9QHi40Jl39EjSop/j8BDPrm2TeNyEbo/0jmvTrkp38zdsZDyGRZJZz3RrmL1M1LkiLcILXp5YdyUUCfJ3pzXVM645YBYjTpvn6mWh0CX6s+v1vR8umxmKEPH2D06STYv3fSIO/XOUhk8uHP77nGIUwGlzKHAQlse0WI6IFu2NQrBA5REn0gFloaR5ApvK/AVVQSTSpMCku4iNYwKV8l6p0Xf90Dv1hbQLhZLDXnw/jizxWYvkYqnO5wQnbiQPG5LuLNTOWu/VMSau5PWtzXmesjItDNmsW+gOaOvZdjz6t4+K/HkoskyOiXq0nDF+DkfKO75KCofitPK6DuQBeEDPncMzOiZfDSxdM2fkWlBUYtsygiV2R7aq3N0/bKTPhmf5gfYtRjUhMwHaXOglyyks+4hkvW5qbqc4C8u42a8o9iX9grHTdmoZl1/FkwGzP5pbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(2616005)(36756003)(478600001)(45080400002)(6666004)(2906002)(966005)(31696002)(4326008)(52116002)(66574015)(5660300002)(31686004)(53546011)(83380400001)(86362001)(316002)(6486002)(66476007)(66556008)(66946007)(8936002)(16526019)(38100700002)(8676002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzVTcTRFNytQM0JRb0xPNlJOVU9HcWpmRklsdkpGOTZGTVdzQnVzby9ZZVVx?=
 =?utf-8?B?WW5iZkl6SWp6UDdadW5kTWRULzN2dWFQVHUxQkxndktYK2REeFc4Y2UxY0Rr?=
 =?utf-8?B?azg1elN0cjlER3liWVpIRUZDWm1IWWszZitlTlRtV2NhRlYzMEhzSzREb0ov?=
 =?utf-8?B?Rm1YQnFKRUxYc01XWWhGWHRsQlF1NVF0R0RrdFpQNXJIYTBrSk5KQmEreXV1?=
 =?utf-8?B?RUJCUkcvQ09NQ2tMUjJneVJqT3QzNFlqaCtmQTVKT0lqVUpKTnJvVWlpQTFs?=
 =?utf-8?B?OGE2dmpOQjlIMUFoaEI2VGgydXJDbkdBeU5aeGFJZExEV0RmQ3p4b3JqVWhL?=
 =?utf-8?B?T1dsOTliQ0hkcXYwdWgyd0xydkNLQmVIZnN0WS9jWmF3cG55cytWSVBPc1Ru?=
 =?utf-8?B?UmhhbUp6cnlpLzRmamFSYVdpa2p2TGYxbEtHakVWR0RSY1Q5d3pDNW5pWW00?=
 =?utf-8?B?bVNtTFRYT3pDdUZuajMyKy9GU1lHbEpmQUZqbWRrT0ZhVSsyblFnNnQzdGFz?=
 =?utf-8?B?MXBHMmtjelJ6azFtdnFPZVQ1ajUzMWFqZ3ZobC9Xa0ZrU25ZQjVaRUU2VG82?=
 =?utf-8?B?Y0FwcndlcGxoaUNEVVBrTWVIYkZRSVJSSm5laHdWOHJjN2MzalFydXZTMmty?=
 =?utf-8?B?KzV4RnlNUGtxMHhtMmJuWkZ3OThDeWRqampOdzVNSUE0WTc1VE9jeEJYVlNM?=
 =?utf-8?B?VXRFdVB0Z2FENWd4c1UvWmNWZXVlaDVXQ3JTQUtFVmhOSG41R1l5VmUxUk8r?=
 =?utf-8?B?S1hONUl1RC9JU0hNVENVbkVWbUlmL2F2bEtONVp2ZzdBWXJSdVJyRDE0Qldz?=
 =?utf-8?B?MlJmSTZlT2FKSHRmR0c2bHFoSkRLR0t4M1NhQ0ZFTnM5OVE0ZkZqTFFSY0V5?=
 =?utf-8?B?YW9OZnVLWnh6aFdmcitrM2NVMzBkQW9teUFLcTV1NzdBZ1VzMUZyWlRCZ0hr?=
 =?utf-8?B?NFVBSXUvVzhhVk93eUJuL2tlZTNocHJPTnR4WXBhelZ6VmtOS0tXRVdrMWN3?=
 =?utf-8?B?TEtodmV2YjdIYVgwTndmYWxodGpPTEFiUnFDZTFhZ08yQWNCK0s3UE5MM1ht?=
 =?utf-8?B?a3dWN2JJYURXUitXQjh6Z1hubzJwM0lpVC9LalZmWGU1TGx1VExFMmlScFNx?=
 =?utf-8?B?WlUrL1VodHQxL2NWZ0s2bnRqSEhXVXgyVjB3WFVuR21Bc3AzQ1FwS0NENzZQ?=
 =?utf-8?B?QitiejFSdWx2OURWT29Qbjk3NVY3Wkl3UFJRSHJhS3VwQmVsbGJ1Y0NZbVo3?=
 =?utf-8?B?bm1CMTBzQ3pZY0pua2xKVzB4VGI5dCtVOW04VXpmL1ZjbitaKzVZaUdUOG11?=
 =?utf-8?B?SW1SenBMdTNKbDdDdTBBMzl0Q2wrcDIyQVlNb3lzdkMwY20rZVVtOTZydTZp?=
 =?utf-8?B?VXYweDgyQ1laT1F1K2g3SXppT29WZ01NaExiT1NFSjdDcHV4amZTamtOSWhQ?=
 =?utf-8?B?Rzh3eVdxMXhwdFZEemVYeG9velBYNVJ3MjVjUkxtN3k1a2RURUNybEEycUln?=
 =?utf-8?B?RmVNQnU4S1RUV2k3UWFwN21qMzY3S3h5UzlwdVhQU2FxT0lKYTc2Ujk5V3VY?=
 =?utf-8?B?ME1tR1I0a1p1bEZyNHZXZlZLV3RLTzhick94WTFjN3FBNEdYR1ZnUkxqUnlt?=
 =?utf-8?B?L3BaV2FzaUc2SjlnVzRaL2ZJYklRa0ZJK0RKZU51dmdPV1hJclZ3WkdoZHIz?=
 =?utf-8?B?YU4zQTJybWYvTkNFS3hJMkI0UUFYVFZkSWJyUUFTNzI3ejJEQ1FXVjkxaUJE?=
 =?utf-8?B?MFo1cC9SckxySGhSSnVYRzN3REJTYXZJOFQ0Vmh2ZTlsbldQTGQ3YkM5dDU4?=
 =?utf-8?B?dGgydlAwQURCaU0ybXVVeDArZmVQMURiRkR1QmMwOG5EOUlFUVJVai9WZUJp?=
 =?utf-8?Q?kysTd/TVxnZFO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13416f8-4703-4583-5031-08d92a754ee4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 12:02:37.4563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahHy9XQvrRpCczz7e8I+S1hWyPP663Fmje8GWdx9FnnJZEt5QfqF0ghkFDG2St2WUGdONBmDJSCIwQINKuMj/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5494
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
Cc: Felix.Kuehling@amd.com, Christian.Koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDYvOC8yMDIxIDE6NDIgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4KPgo+IEFtIDA4
LjA2LjIxIHVtIDEzOjI3IHNjaHJpZWIgTmlybW95IERhczoKPj4gRml4ZXMgaGFuZGxpbmcgd2hl
biBwYWdlIHRhYmxlcyBhcmUgaW4gc3lzdGVtIG1lbW9yeS4KPj4KPj4gdjI6IHJlbW92ZSB1bndh
bnRlZCB2YXJpYWJsZS4KPj4gwqDCoMKgwqAgY2hhbmdlIGFtZGdwdV9hbWRrZmRfdmFsaWRhdGUg
aW5zdGVhZCBvZiBhbWRncHVfYW1ka2ZkX2JvX3ZhbGlkYXRlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5
OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgfCAxNSArKysrLS0tLS0tLS0t
LS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0p
Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1k
a2ZkX2dwdXZtLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZF9ncHV2bS5jCj4+IGluZGV4IGQ2Y2I3Y2Y3NjYyMy4uMDIxZjI1MDg1NzYwIDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+
IEBAIC0zNDgsMTEgKzM0OCw5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2FtZGtmZF9ib192YWxpZGF0
ZShzdHJ1Y3QgCj4+IGFtZGdwdV9ibyAqYm8sIHVpbnQzMl90IGRvbWFpbiwKPj4gwqDCoMKgwqDC
oCByZXR1cm4gcmV0Owo+PiDCoCB9Cj4+Cj4+IC1zdGF0aWMgaW50IGFtZGdwdV9hbWRrZmRfdmFs
aWRhdGUodm9pZCAqcGFyYW0sIHN0cnVjdCBhbWRncHVfYm8gKmJvKQo+PiArc3RhdGljIGludCBh
bWRncHVfYW1ka2ZkX3ZhbGlkYXRlX3ZtX2JvKHZvaWQgKl91bnVzZWQsIHN0cnVjdCAKPj4gYW1k
Z3B1X2JvICpibykKPj4gwqAgewo+PiAtwqDCoMKgIHN0cnVjdCBhbWRncHVfdm1fcGFyc2VyICpw
ID0gcGFyYW07Cj4KPiBUaGUgc3RydWN0dXJlIGRlZmluZSBvZiBhbWRncHVfdm1fcGFyc2VyIGlz
bid0IHVzZWQgYW55IG1vcmUgaWYgd2UgCj4gZHJvcCB0aGlzIGFzIHdlbGwsIGlzbid0IGl0PwoK
ClJpZ2h0LCBJIG1pc3NlZCB0aGF0LiBJIHdpbGwgcmVzZW5kLgoKCk5pcm1veQoKPgo+IENocmlz
dGlhbi4KPgo+PiAtCj4+IC3CoMKgwqAgcmV0dXJuIGFtZGdwdV9hbWRrZmRfYm9fdmFsaWRhdGUo
Ym8sIHAtPmRvbWFpbiwgcC0+d2FpdCk7Cj4+ICvCoMKgwqAgcmV0dXJuIGFtZGdwdV9hbWRrZmRf
Ym9fdmFsaWRhdGUoYm8sIGJvLT5hbGxvd2VkX2RvbWFpbnMsIGZhbHNlKTsKPj4gwqAgfQo+Pgo+
PiDCoCAvKiB2bV92YWxpZGF0ZV9wdF9wZF9ib3MgLSBWYWxpZGF0ZSBwYWdlIHRhYmxlIGFuZCBk
aXJlY3RvcnkgQk9zCj4+IEBAIC0zNjYsMjAgKzM2NCwxNSBAQCBzdGF0aWMgaW50IHZtX3ZhbGlk
YXRlX3B0X3BkX2JvcyhzdHJ1Y3QgCj4+IGFtZGdwdV92bSAqdm0pCj4+IMKgIHsKPj4gwqDCoMKg
wqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvICpwZCA9IHZtLT5yb290LmJhc2UuYm87Cj4+IMKgwqDCoMKg
wqAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBhbWRncHVfdHRtX2FkZXYocGQtPnRiby5i
ZGV2KTsKPj4gLcKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X3ZtX3BhcnNlciBwYXJhbTsKPj4gwqDCoMKg
wqDCoCBpbnQgcmV0Owo+Pgo+PiAtwqDCoMKgIHBhcmFtLmRvbWFpbiA9IEFNREdQVV9HRU1fRE9N
QUlOX1ZSQU07Cj4+IC3CoMKgwqAgcGFyYW0ud2FpdCA9IGZhbHNlOwo+PiAtCj4+IC3CoMKgwqAg
cmV0ID0gYW1kZ3B1X3ZtX3ZhbGlkYXRlX3B0X2JvcyhhZGV2LCB2bSwgYW1kZ3B1X2FtZGtmZF92
YWxpZGF0ZSwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZwYXJh
bSk7Cj4+ICvCoMKgwqAgcmV0ID0gYW1kZ3B1X3ZtX3ZhbGlkYXRlX3B0X2JvcyhhZGV2LCB2bSwg
Cj4+IGFtZGdwdV9hbWRrZmRfdmFsaWRhdGVfdm1fYm8sIE5VTEwpOwo+PiDCoMKgwqDCoMKgIGlm
IChyZXQpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHByX2VycigiZmFpbGVkIHRvIHZhbGlkYXRl
IFBUIEJPc1xuIik7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+PiDCoMKgwqDC
oMKgIH0KPj4KPj4gLcKgwqDCoCByZXQgPSBhbWRncHVfYW1ka2ZkX3ZhbGlkYXRlKCZwYXJhbSwg
cGQpOwo+PiArwqDCoMKgIHJldCA9IGFtZGdwdV9hbWRrZmRfdmFsaWRhdGVfdm1fYm8oTlVMTCwg
cGQpOwo+PiDCoMKgwqDCoMKgIGlmIChyZXQpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHByX2Vy
cigiZmFpbGVkIHRvIHZhbGlkYXRlIFBEXG4iKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biByZXQ7Cj4+IC0tIAo+PiAyLjMxLjEKPj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlv
bi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJG
bWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDbmlybW95LmRh
cyU0MGFtZC5jb20lN0M1OTUwOTJhMDU1ZTk0NmJhZmE4NjA4ZDkyYTcyODAzNCU3QzNkZDg5NjFm
ZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc1ODc0OTM1MzA4MjkwMjElN0NV
bmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklp
TENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9N1hXVCUyRmNK
NFNuV0c4NUtFZU9hd0VDdHdxJTJCTWNFT3Fvbzg4bzAxUzBYNWclM0QmYW1wO3Jlc2VydmVkPTAg
Cj4+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
