Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4714C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 11:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7737261289
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 11:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7737261289
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BD9B6E117;
	Tue,  8 Jun 2021 11:00:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C586E117
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 11:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhLdRCRh8kO81jbR0bctcwGPl1UBdTod+Oqpf5kUOP378Ycrz8IbVigWpSszC8Lj0q9gff958GNcTUuVl/gsbx9f+7WZfup3VK7ag5glGvFjUJT7PMvY8GJhpXCPrWSeTQB7QNFEaq6sMdP3boa9hBAsVEqpPFe1t6REds2DpOqwLWyBNZKj/ymZHD0BaOshBU7Ar0196qDgyEr+ipinmCrQJEsn6lXxQeP0nSMxVLDkWjlNZ4C257Naz2bzu1Pabc1DnJ3quVdgmdIcGQSHtV2wxyxUWcBW0N2LqE67BlDgas0o6QVqon04uET9Rlutsve34l2HMMq6zsf2eua2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz5JamtlAvXI4U5Y4p0DHnJHtMGx4wJ0eiUwS/6TXls=;
 b=J1F5ziP+S2VcwLgk/m0UiiOvFF5gcA5NVlO44zluy+L9MekR8fneZ1OBjSyjfCa6Mmb0rAnOhDkz0r0Zp+msckJHLbGLgLqpQtfi2lGVwIifmJ67FIIlXiZ+mng1IJn0g+Cw2mkoD9GAeWtQtEx3aeqK70JtT1EJ/sCMCPtebHUoivPXN+J+TnW0sinTxHy4A3Kx+8KKLYR7IjZz81APkZjB7JhoYGPEL5S5cXAd/8SSsEhGJiQmqHxj0iOnOcQAcxSsTzHw5tmF1DLQLY5iZSkMZZK7K17ltYAT/9MT5HnGeUkom6kkYhIq+o8ZM7652+4pQL38PDQjDsy83MFSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz5JamtlAvXI4U5Y4p0DHnJHtMGx4wJ0eiUwS/6TXls=;
 b=dk5+V7U2pJzkH2dxXDYAdFkOvLtPwqH/iHdVvLc1Q660TT8l8xAVrRoi/f6p32I/fU0oks3M7ehTg1eZH6u2tDxIIZPRRN0EPLp+GPfS899O+IuMTRX6QxLrjzDxfFwXA4VjlGp+pp6B/YLmkrhkDUb1SJfYd7PApxDoudHzcN4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 11:00:21 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 11:00:21 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: use allowed domain for vmbo validation
To: "Das, Nirmoy" <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210608093213.8269-1-nirmoy.das@amd.com>
 <63f66fd0-7162-ea31-41e3-1f145d8a6ddd@amd.com>
 <192dab49-1a3b-5874-2f41-995073c0706a@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9ccbbf9f-3719-a843-4f37-b24e1e498384@amd.com>
Date: Tue, 8 Jun 2021 13:00:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <192dab49-1a3b-5874-2f41-995073c0706a@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:197a:8536:afbe:3762]
X-ClientProxiedBy: PR0P264CA0283.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::31) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:197a:8536:afbe:3762]
 (2a02:908:1252:fb60:197a:8536:afbe:3762) by
 PR0P264CA0283.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20 via Frontend Transport; Tue, 8 Jun 2021 11:00:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af823532-8be8-403e-dc25-08d92a6c9c0e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4549:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45491D4817570D026744122E83379@MN2PR12MB4549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vw7NFL5+JbVBaaduEfTqnymHr0rpxdE6CKAefz52Mc8s+J2sR0OEAKZtiowYgEa8/5WDgZ6UA/7wG2Skq14yKa8k5cI1/P9p7CTeH4Ze7WcETMHWHpJfpnpr9mbRDVR5FeQaWE3jQYEsKdCgxO4zRrK5VMqBKM3huA/kNQ+X2fhebfv2vj3Ag3Ck27KUVmgXRWhN4CHWYcf4w56c2zkrcqdYJvKVJVdJuVu69L+UiHut9PlCvbkaJVpwaloooj6/EwMHfFXKiSdGdVFJ00xWCpnHmYSSdq16WF8IVGT3Tf4ShQ0ZfR4quW3M2oQsJmjuSxBud08tqDU1gVcy0pCjNQl6Qkgi8drezXRCphytkBnXXpSDJnHvD1O08XJDVMH4sr7hpmmDPhfjE0amjDgbZtA0xfTaH1i85zL3711F0SKRt+tzPnwib/g5CUnzgC3S1/IVt/mxp+WsSs6QlTGcdKkodzKY08n6TFJA5jmc8xzOyQrCVUwl7L1PK/k+hSJ0E+OVWOj8I13oZQMoFwZ5+QVq1d5EbJHxL1Qzn8uUx/r0VqZPvSNDsYcaRk83OBdsUN77s8eJ/4UdM7YF8dKaUJmvuvdpoOX+s29dAYuGoP1LPlSfFPVU9LBlJS1jLgFkWl1TzwEwQvj+1zq361wsTTDAjqHvjFprY+vVvX5BmQKLsJGOb2Ph+5/42oOC+OQW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(8936002)(66574015)(478600001)(66556008)(316002)(31696002)(83380400001)(186003)(36756003)(31686004)(4326008)(16526019)(38100700002)(2906002)(6486002)(6666004)(2616005)(66476007)(5660300002)(66946007)(8676002)(86362001)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDhmQ1F6TTQ3K0FHOTMxejhqWUx6WlVPZHlDM216QlhGaUJVblU2Y1U3OWFq?=
 =?utf-8?B?WlVuN3ZqUnU5aDNGYVlCaWNzR3M0VjJlanNlQTdhQ1dpdHhPUVRyak5wQUc1?=
 =?utf-8?B?T3MwSlhxL2w0Zm84OTdSbmVMNGtaejUrTnJuTXUvSHdSTHg3RkczK3lJc1VW?=
 =?utf-8?B?Vk0vZmNNZjUrdU0yYlhSczg3TXNtRkgvWjV2T280VzRDb3E3d2VtY1prTXNM?=
 =?utf-8?B?aStGbTR3Szh0bXpsUlpWbFIrek1adjJsZElFNUJ6SVJwYVYwcHdCK2ZhRmRD?=
 =?utf-8?B?VVZGQittSlBNRVc0bUNmWkoyc2V0TGZPbmpNTWRLTkhpU2ZFWVpUdzhNb2lk?=
 =?utf-8?B?WGZmblJMNHJuMTNpQVYyaTBVamZWM0g5VjFHWUhLcTgwZ24yS2xEVWsrN1pq?=
 =?utf-8?B?L1J5ejhkbFJ6RlV2dXN2STFrRDZ4L0t3QldIeHlZTUtFWk5mRExJTTdUQlFq?=
 =?utf-8?B?N2syVFZOdk50TjMwQVJvRDJob3ByTG5Rb2tGc2hUVmpmWlk4RjZIL1BwZmtz?=
 =?utf-8?B?RThOempURi9tVkhLbEQxRkNIeWg4eUw5eTNvTXVhUHZsYWhtcHFuWHBvZU1G?=
 =?utf-8?B?VlRrWTJOVVFxQnRDaENrR1BsODFpRlNRR3pVTkErenlVUHE3c2VyVzlVdUFZ?=
 =?utf-8?B?b2xRc2J1ZXZyTVFMZWhkcW5EY3pNZ2poUVhxSEwycGovNmlhbE96dGVtMGJB?=
 =?utf-8?B?ellIRm50c0RPQXBoTTQvMW1kQXgzZEhZVjlqclYxWnlFU21xWEpqS1UyWkFP?=
 =?utf-8?B?dVJkOUI5KzBtbmk1QWxiRFh6eHZDRjdvTk42Vlc2b1JDVDY5Q203SE9DSG0w?=
 =?utf-8?B?M0NBcVNHSmZPOVJ0VnlWZ3V5UXJJWk5nUStCQmtSWjJwUGZPSk12R0E4dmxq?=
 =?utf-8?B?elJpQ0hvRlkwTTEycC9iQTFscDcya01sbFpWUWFDUFZqZnJJUER4TWZXNzcr?=
 =?utf-8?B?bXg3SE9pZVdrdHRkcVJ1V1dqR3dFeU1yY1VvNERIY2lGdmoxdS93eE1PNXVX?=
 =?utf-8?B?c3FzenFTUlNpVG92aEFpVkYzVXhTSTNXQXVkNzcyZFcya0dJQThFL3lwRi96?=
 =?utf-8?B?aFY3SjdzWlZjZ3ZlVGFTdCtTMTNDbnljZkRZemtuMUZoNmloMXZZRWtoK3Rr?=
 =?utf-8?B?REdQSUZ1TlVhSm5EYnJlZTNpR0twY2wvQWJEWGg3OTl6ZWl2SVB3MTFua2RT?=
 =?utf-8?B?RmhSeFVHb1NsRmpvamJlYk0yM0RTdGxLWFIyMm9uT0hrK01jQnJmOUZ5eHRm?=
 =?utf-8?B?Z0ZEYnlHM3hTc2pnVEVoamppZzJGcncxTTVWMkc1SzREbEpSS2I1SzlyYVhw?=
 =?utf-8?B?bk9mK1hqUEoyeG9EcTV5bHRLQ0F0Vy96dWFyM25CRnl4dFI3cVJRaVRhRFN5?=
 =?utf-8?B?Qm4zZ2dwOFJyWjRQWnJhTEk3dHo0ZnlPd2VuaE43cW40cE15dk9KYXM4amg3?=
 =?utf-8?B?bTdadmYyQ3JoNndQZjlzYVZUaE9NUG41Z21xTmlERXFOYzNOTk8zS1gyZjFG?=
 =?utf-8?B?eHpNUk1Ray9ZL21YekZXdHVmNjRtWWRVbXgxTkljU2U5M2ZTSzAvNUhESEN6?=
 =?utf-8?B?REQ0bjhEaXZUeC9GQ3pxR3QzS3lwSlNsS1JIQk54QjVEYWRzdTkvRXMrYjBF?=
 =?utf-8?B?WTdldXY4U1BtYTlYSXBDenh5eVdyMVUrNE9JcmZpKytoNHBvYkp4RE94OWVj?=
 =?utf-8?B?cmNyL0dNVDV6WHFzV1dKRHJ6VzFDdDVncENaK3p1OWZwcW11V1BMMEN6SStL?=
 =?utf-8?B?eGFhdmcyaUlxVm9Pcys2a0tTZ1dUWXNJL216YzE2MFRqUnBVbWpKeTdnbWpr?=
 =?utf-8?B?MUFjeUlzTEd1dGtPblhzWFRhNU1qUUwzdTdTZ0MwOVVjZUFSVnBjT3hUSE5w?=
 =?utf-8?Q?mDFIXkvWQlEph?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af823532-8be8-403e-dc25-08d92a6c9c0e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 11:00:21.4268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubbknms/qhrn/BzWROl9cBADSIJ1/GadPcpLCkUaO+mQEyGzrxl2/zI2N3IwVix+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4549
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
Cc: Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAwOC4wNi4yMSB1bSAxMTo1OCBzY2hyaWViIERhcywgTmlybW95Ogo+Cj4gT24gNi84LzIw
MjEgMTE6MzcgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDA4LjA2LjIxIHVtIDEx
OjMyIHNjaHJpZWIgTmlybW95IERhczoKPj4+IFJlbW92ZSBmaXhlZCBkb21haW4gYW5kIHVzZSBC
TydzIGFsbG93ZWQgZG9tYWluIGZvciBQVC9QRAo+Pj4gQk8gdmFsaWRhdGlvbi4KPj4KPj4gIkZp
eGVzIGhhbmRsaW5nIHdoZW4gcGFnZSB0YWJsZXMgYXJlIGluIHN5c3RlbSBtZW1vcnkiLgo+Pgo+
PiBBbmQgSSB0aGluayB5b3UgY2FuIG5vdyByZW1vdmUgdGhlIHZhbGlkYXRlIHN0cnVjdHVyZSBh
cyB3ZWxsLgo+Cj4KPiBEbyB5b3UgbWVhbiAiIHN0cnVjdCBhbWRncHVfdm1fcGFyc2VyIHBhcmFt
OyAiID8KClllcywgZXhhY3RseSB0aGF0IG9uZS4KCkNocmlzdGlhbi4KCj4KPgo+IFRoYW5rcywK
Pgo+IE5pcm1veQo+Cj4+Cj4+IENocmlzdGlhbi4KPj4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBO
aXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyB8IDMgKy0tCj4+PiDCoCAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyAK
Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+
PiBpbmRleCBkNmNiN2NmNzY2MjMuLmE0NWVhZGZiZjQxNyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+Pj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+PiBAQCAtMzM2
LDcgKzMzNiw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2FtZGtmZF9ib192YWxpZGF0ZShzdHJ1Y3Qg
Cj4+PiBhbWRncHVfYm8gKmJvLCB1aW50MzJfdCBkb21haW4sCj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAiQ2FsbGVkIHdpdGggdXNlcnB0ciBCTyIpKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiAtRUlOVkFMOwo+Pj4gwqAgLcKgwqDCoCBhbWRncHVfYm9fcGxhY2VtZW50X2Zyb21fZG9t
YWluKGJvLCBkb21haW4pOwo+Pj4gK8KgwqDCoCBhbWRncHVfYm9fcGxhY2VtZW50X2Zyb21fZG9t
YWluKGJvLCBiby0+YWxsb3dlZF9kb21haW5zKTsKPj4+IMKgIMKgwqDCoMKgwqAgcmV0ID0gdHRt
X2JvX3ZhbGlkYXRlKCZiby0+dGJvLCAmYm8tPnBsYWNlbWVudCwgJmN0eCk7Cj4+PiDCoMKgwqDC
oMKgIGlmIChyZXQpCj4+PiBAQCAtMzY5LDcgKzM2OSw2IEBAIHN0YXRpYyBpbnQgdm1fdmFsaWRh
dGVfcHRfcGRfYm9zKHN0cnVjdCAKPj4+IGFtZGdwdV92bSAqdm0pCj4+PiDCoMKgwqDCoMKgIHN0
cnVjdCBhbWRncHVfdm1fcGFyc2VyIHBhcmFtOwo+Pj4gwqDCoMKgwqDCoCBpbnQgcmV0Owo+Pj4g
wqAgLcKgwqDCoCBwYXJhbS5kb21haW4gPSBBTURHUFVfR0VNX0RPTUFJTl9WUkFNOwo+Pj4gwqDC
oMKgwqDCoCBwYXJhbS53YWl0ID0gZmFsc2U7Cj4+PiDCoCDCoMKgwqDCoMKgIHJldCA9IGFtZGdw
dV92bV92YWxpZGF0ZV9wdF9ib3MoYWRldiwgdm0sIAo+Pj4gYW1kZ3B1X2FtZGtmZF92YWxpZGF0
ZSwKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
