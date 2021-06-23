Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E24FC49EA7
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 21:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F022F61185
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 21:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F022F61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64B656E93C;
	Wed, 23 Jun 2021 21:50:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC9D6E93C;
 Wed, 23 Jun 2021 21:50:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0C7XNgHI1JUDozTMMQ4A+DK1B8grBsXIuWnB1ge78DxyO7LHpyzj/EIEE3O4PbWdfAcYVbyOHM+hOoaZVfQF0vVRqL/TPQLCD82VS8A3W6RH9rfNVhtR75+KISPToLorj8AhMdKDReqmSkO+SVKXiI7uRujm+LCOQQnodBEkra4gQ3GCgyooiOr2vcGX5JMHitsjugjK7a2+NCKUEwjl3UxAnVTIaVkNhSzWdaBsW5pgjOY8wAx8U6kcyl6p2dtW8c8i3mZ61Q0SprQ/Q0372goYmeVa8VJxYpQgDI4mqC04Ovw/Bf2aeSRGS6T/Fus/YSMzXjoeIFnzwayJMvYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBTW5P+of7HEnWXdrxStEno5fmAMW8oM9NjtASYe0zA=;
 b=XvHOH90RjVN4Q/NITQu6X9QcCekf38B6sCvc3cXp1sMY+xrTCKvae7BlsNI/zorpHockvbc7cTUalMBiulcmuFrzlxINhC+zpAISen4oICiISSp/Bdsb9APd06PBm6LruoS1RJ3nllzTJ4+dhAOpvkeuLkIrTbKP/gmoFna3z07qdwr33uS1yPV1foJnLQidoURFKcegXR8S+9UcPVHGJf81RCy13vkmYpn9Uy8IQkxkQQeeSTIVv8I19rpzofvErHZ6gb46whHz9SRDW5Up95eM6hp8JScXCSKTMFsRixHHBwoEy01x7OETMxPzbn94oL3omGPhgkhLEmJgU/7X5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBTW5P+of7HEnWXdrxStEno5fmAMW8oM9NjtASYe0zA=;
 b=cJ2rCU3PqY4/ykUghCuoePEb/+ffhfByPhd3hUBKiAGrH0n8MQLXM4wDSi80HtYs1PR64aUp6IVM9lt5jj9zh8h5kACOC7YPQMHv1TYLuicYxRYe0CflIua/hQYPpqnZPPQ/UvXje7MxHQGKNnK3LP8YDVAxbkpS4HjeZ2Q2h1Q=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5193.namprd12.prod.outlook.com (2603:10b6:408:11a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 21:49:57 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 21:49:57 +0000
Subject: Re: [PATCH v3 0/8] Support DEVICE_GENERIC memory in migrate_vma_*
To: Theodore Ts'o <tytso@mit.edu>, Alex Sierra <alex.sierra@amd.com>
References: <20210617151705.15367-1-alex.sierra@amd.com>
 <YM9NXrGlhdp0qb7S@mit.edu>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <905418d1-9099-0ea8-a6e6-84cc8ef3d0b0@amd.com>
Date: Wed, 23 Jun 2021 17:49:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YM9NXrGlhdp0qb7S@mit.edu>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::23) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 21:49:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bc692f2-f6ed-4fb2-506b-08d93690d7ca
X-MS-TrafficTypeDiagnostic: BN9PR12MB5193:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5193FAB392B8B593F04B01EE92089@BN9PR12MB5193.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrezoUU6IOnFEeu3djH/YR/WhfEQHbaOIDpKJuWh4dGhVtsYJ/6nYA9B+zJ3GyvCHYXH9gMmWmByKtHSmkaCoBum8HzWK2gP5wxDa7b7AVqMsoGMdlGBsLwoJi5NXJFOPQ6H2rAbe3Sop2CHduetv1yRtCsRALJGZAIVfQwC2D+YouCZN5FbWQYE7FEENVGKC+mTHkdMMcGR+P6l+536Wc156qY2tCtqDXZVFQCy3BV1MoIhuWib5/a2ey2E6+XDMSR0Bk/TPDHwVCPMk/8xohQS6wrdBlEsDSHyEvAAQC0ErpyIJlEvYWni90DiGNiXL+N9Ximck8+TIid7uafHZ4gtS1e5bQjH4Nwvl+lwK2aetixwsdIRQHWOomRX12d9/CS66kcVNx6D7Jn0WJoOMrmapd26qF8ReJ8xqSOxVp3W4FSBkEs3Bg5hpXO3/SeScT8UWtFEYx0mDoY+Egv9i+/2waHdrHrYsy8Tlyv0PiCTN2RcwoRHFUovn6/+eh281q1iuDJ6tveXHTaAgGSp6utGJ3b+NTpOJC9NI9ihyHLP75WZn8LZE+ZheJ9m75Yy9Ad8olF/OZaISVt4Qz+9WYTgLJgZUsy4yS4ueNOc3VQGPGcNKpntsKtY+3UXXULBvMrRGPyqOCb6iLEQGlY6rxvALBtMGh8McjcyH+png3yxFciP/kUcygw1wKvnKTFYg8LQD9vwsHNYo5vOQScIfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(66556008)(36756003)(66946007)(956004)(66476007)(2616005)(2906002)(8676002)(44832011)(86362001)(5660300002)(316002)(110136005)(8936002)(31696002)(16576012)(7416002)(478600001)(26005)(83380400001)(31686004)(186003)(16526019)(53546011)(36916002)(6486002)(4326008)(6636002)(38100700002)(41533002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDMrUzkrR3pqREpnbDVjL1FLTkVONVJrMTQ0cThzS08walhtWVU1YkFnclNL?=
 =?utf-8?B?a1NxYmIzVjAzM0U4cGFtOWRQbDlJcEVoL21pWjR6V1lza01YNE5wVnJudndJ?=
 =?utf-8?B?bVJTbkxMYkRVSGV2RVlTYnkzek1sMDUvYXlUSWtsMVBXalV1WjVkOGxYK2NB?=
 =?utf-8?B?akN6eEJiSVNRdEZMR2NObHdqTktocTZjME1TMVM4bE40dFZIdUY3c1NWWVhI?=
 =?utf-8?B?YVNKbkp6U0diOXRqa3c0R1BnelA1RFZOTnFwbFJCVnVRSWNyblNhT0tlRS9B?=
 =?utf-8?B?L3hMZ012RTR0K3FraVBZanJLWWZTeTNDVGZ6aWgvQVM4ampVSzZZTDF1TFRu?=
 =?utf-8?B?alhDUmpiQVh2ZUZMNWQ2bFowV1FGOHhrTVYyUm5Pd01WODZYRjhPNmM2bkJF?=
 =?utf-8?B?Y2ZIOHFSMHJQdHZ2eDVZM0lqV2Q0S3VvOC90dmU2VjBydEk3QmxsSjVZTTdw?=
 =?utf-8?B?MURwNWQzM1JtTEtTSGVLK3N0MmlnU2NPcytuT2dKNVhNa1VYSkx6bk9yNndt?=
 =?utf-8?B?Y0NtUWVEWnQ1eVdNK29YQlBHYlM2RjZaZndtblJsOWdiVllQeldCc2hUMnl3?=
 =?utf-8?B?b0t1MGMrOExqTFo5cW9BWXQ5dDR4MmVzakcxMmZuYTB4bXdETVdXUzNTanJJ?=
 =?utf-8?B?WmdIc2N6SWJxajAwVUdqK2tzN2lLWnNmc21oZ3pTK3ZHSFVISUh0TTNYVlJk?=
 =?utf-8?B?S01SNEpoZDh1VGFTejcrK3RVNGFiYXkrUyttcVJrVlZmcFFmUnpoUU5PZkhV?=
 =?utf-8?B?UXA4Tk9qYUNEQUxHVS9GQ1hERDAyYnVrSXBwcWZCcnpZR3IxaWhwajY0TXJY?=
 =?utf-8?B?Q2x2WGhocFRxVmNWZEIwdmNYcXRMcDRwcFpmTHd2WlllSzhxL1J5bENOUXFK?=
 =?utf-8?B?Y1pEbndsZjJpdHJlMG0wZkU5bnpkdmhIUHg3K3dVU3R6c3pOamFLV1F5WjVk?=
 =?utf-8?B?R0d3R0QvYm0xWVVSRVdWblFRVXdUak5ua3pEWDEzakh0VERrYnpOdkxIb2tF?=
 =?utf-8?B?Z3hPSzRFQ0YwRHg1aHhBUmdweFl5RTVvYjgxYnE1NjB0QnFQOFJ1VTJoNHN4?=
 =?utf-8?B?M2k4V3NKdk90QWhHck1OcHphQ3NuM0RGVjBLK0NpU1dUeFpodzZhRUxoM2RP?=
 =?utf-8?B?NnBnMldVS2dybWlWV01vYWNSaVl1UVEwRDRrWlJsTnBQdjMwSmU0ZHRBSGdB?=
 =?utf-8?B?UWdQaTA0NUZGN0FBOGdpNmNYUlF0SzdVYnNmbTdxWkpPakVYajhWclRGRHRh?=
 =?utf-8?B?QXlWWFB1SHRLTkFicDBOSVZGTW9qQXJQWFZZYnE2YVlCYXV6NzFUZGxKSm12?=
 =?utf-8?B?Y1lBbEF3QWVsVG0za1VBeGxLbWJ5YndLamk1cGFQZnhqY2J2YytSV2ZyY2h0?=
 =?utf-8?B?cWNRUjV4SGZaUWx0aG52QkloT05YUFBSZjg1ZDBxRkZua240QzhQSjk0K1lR?=
 =?utf-8?B?UXFoUUtoLzJ0WXZBQlExWklIL1YzaU04NFROTENMRllxWXNrTU96SzVCWmZE?=
 =?utf-8?B?aHNYazMxTE9XWklYNEZtODF5Wm1MejNaL2Fyb0lmS1dReVU3dVVJUG9GaDQw?=
 =?utf-8?B?NnF3T2ZFY21RMWFBeU4waWhhSFdoeUgxc0lKTGx2QStJNzJxREZXUjh0ODZF?=
 =?utf-8?B?UTJhVmQ4bEQ5cFIxVk03N0hqbGlRQklVUk8xT25qZlVQZTJOWDREWVdqRnR6?=
 =?utf-8?B?SlpWZ0k3VWR0eTh6OWFqeG5ObHJaRzRianhYM0dUaXB1eGlHbmhkQm80YTRi?=
 =?utf-8?Q?QX8SC5FkRlFLuraKlOAg2UHSvu9Xp5sjWj411OP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc692f2-f6ed-4fb2-506b-08d93690d7ca
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 21:49:57.7258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvnQ839/BpuSVazH0KanZfR2qCpFNOk9uLrnIPN1iw9z73/16mZJHZce3EPEVUKjujv39i8d4rLCy7wR0ohH/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5193
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
Cc: rcampbell@nvidia.com, amd-gfx@lists.freedesktop.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com,
 dri-devel@lists.freedesktop.org, jgg@nvidia.com, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNi0yMCAxMDoxNCBhLm0uLCBUaGVvZG9yZSBUcydvIHdyb3RlOgo+IE9uIFRodSwg
SnVuIDE3LCAyMDIxIGF0IDEwOjE2OjU3QU0gLTA1MDAsIEFsZXggU2llcnJhIHdyb3RlOgo+PiB2
MToKPj4gQU1EIGlzIGJ1aWxkaW5nIGEgc3lzdGVtIGFyY2hpdGVjdHVyZSBmb3IgdGhlIEZyb250
aWVyIHN1cGVyY29tcHV0ZXIgd2l0aCBhCj4+IGNvaGVyZW50IGludGVyY29ubmVjdCBiZXR3ZWVu
IENQVXMgYW5kIEdQVXMuIFRoaXMgaGFyZHdhcmUgYXJjaGl0ZWN0dXJlIGFsbG93cwo+PiB0aGUg
Q1BVcyB0byBjb2hlcmVudGx5IGFjY2VzcyBHUFUgZGV2aWNlIG1lbW9yeS4gV2UgaGF2ZSBoYXJk
d2FyZSBpbiBvdXIgbGFicwo+PiBhbmQgd2UgYXJlIHdvcmtpbmcgd2l0aCBvdXIgcGFydG5lciBI
UEUgb24gdGhlIEJJT1MsIGZpcm13YXJlIGFuZCBzb2Z0d2FyZQo+PiBmb3IgZGVsaXZlcnkgdG8g
dGhlIERPRS4KPj4KPj4gVGhlIHN5c3RlbSBCSU9TIGFkdmVydGlzZXMgdGhlIEdQVSBkZXZpY2Ug
bWVtb3J5IChha2EgVlJBTSkgYXMgU1BNCj4+IChzcGVjaWFsIHB1cnBvc2UgbWVtb3J5KSBpbiB0
aGUgVUVGSSBzeXN0ZW0gYWRkcmVzcyBtYXAuIFRoZSBhbWRncHUgZHJpdmVyIGxvb2tzCj4+IGl0
IHVwIHdpdGggbG9va3VwX3Jlc291cmNlIGFuZCByZWdpc3RlcnMgaXQgd2l0aCBkZXZtYXAgYXMg
TUVNT1JZX0RFVklDRV9HRU5FUklDCj4+IHVzaW5nIGRldm1fbWVtcmVtYXBfcGFnZXMuCj4+Cj4+
IE5vdyB3ZSdyZSB0cnlpbmcgdG8gbWlncmF0ZSBkYXRhIHRvIGFuZCBmcm9tIHRoYXQgbWVtb3J5
IHVzaW5nIHRoZSBtaWdyYXRlX3ZtYV8qCj4+IGhlbHBlcnMgc28gd2UgY2FuIHN1cHBvcnQgcGFn
ZS1iYXNlZCBtaWdyYXRpb24gaW4gb3VyIHVuaWZpZWQgbWVtb3J5IGFsbG9jYXRpb25zLAo+PiB3
aGlsZSBhbHNvIHN1cHBvcnRpbmcgQ1BVIGFjY2VzcyB0byB0aG9zZSBwYWdlcy4KPj4KPj4gVGhp
cyBwYXRjaCBzZXJpZXMgbWFrZXMgYSBmZXcgY2hhbmdlcyB0byBtYWtlIE1FTU9SWV9ERVZJQ0Vf
R0VORVJJQyBwYWdlcyBiZWhhdmUKPj4gY29ycmVjdGx5IGluIHRoZSBtaWdyYXRlX3ZtYV8qIGhl
bHBlcnMuIFdlIGFyZSBsb29raW5nIGZvciBmZWVkYmFjayBhYm91dCB0aGlzCj4+IGFwcHJvYWNo
LiBJZiB3ZSdyZSBjbG9zZSwgd2hhdCdzIG5lZWRlZCB0byBtYWtlIG91ciBwYXRjaGVzIGFjY2Vw
dGFibGUgdXBzdHJlYW0/Cj4+IElmIHdlJ3JlIG5vdCBjbG9zZSwgYW55IHN1Z2dlc3Rpb25zIGhv
dyBlbHNlIHRvIGFjaGlldmUgd2hhdCB3ZSBhcmUgdHJ5aW5nIHRvIGRvCj4+IChpLmUuIHBhZ2Ug
bWlncmF0aW9uIGFuZCBjb2hlcmVudCBDUFUgYWNjZXNzIHRvIFZSQU0pPwo+IElzIHRoZXJlIGEg
d2F5IHdlIGNhbiB0ZXN0IHRoZSBjb2RlcGF0aHMgdG91Y2hlZCBieSB0aGlzIHBhdGNoc2V0PyAg
SXQKPiBkb2Vzbid0IGhhdmUgdG8gYmUgdmlhIGEgY29tcGxldGUgcWVtdSBzaW11bGF0aW9uIG9m
IHRoZSBHUFUgZGV2aWNlCj4gbWVtb3J5LCBidXQgc29tZSB3YXkgb2YgY3JlYXRpbmcgTUVNT1JZ
X0RFVklDRV9HRU5FUklDIHN1YmplY3QgdG8KPiBtaWdyYXRlX3ZtYV8qIGhlbHBlcnMgc28gd2Ug
Y2FuIHRlc3QgZm9yIHJlZ3Jlc3Npb25zIG1vdmluZyBmb3J3YXJkLgoKSGkgVGhlb2RvcmUsCgpJ
IGNhbiB0aGluayBvZiB0d28gd2F5cyB0byB0ZXN0IHRoZSBjaGFuZ2VzIGZvciBNRU1PUllfREVW
SUNFX0dFTkVSSUMgaW4gCnRoaXMgcGF0Y2ggc2VyaWVzIGluIGEgd2F5IHRoYXQgaXMgcmVwcm9k
dWNpYmxlIHdpdGhvdXQgc3BlY2lhbCBoYXJkd2FyZSAKYW5kIGZpcm13YXJlOgoKRm9yIHRoZSBy
ZWZlcmVuY2UgY291bnRpbmcgY2hhbmdlcyB3ZSBjb3VsZCB1c2UgdGhlIGRheCBkcml2ZXIgd2l0
aCBobWVtIAphbmQgdXNlIGVmaV9mYWtlX21lbSBvbiB0aGUga2VybmVsIGNvbW1hbmQgbGluZSB0
byBjcmVhdGUgc29tZSAKREVWSUNFX0dFTkVSSUMgcGFnZXMuIEknbSBvcGVuIHRvIHN1Z2dlc3Rp
b25zIGZvciBnb29kIHVzZXIgbW9kZSB0ZXN0cyAKdG8gZXhlcmNpc2UgZGF4IGZ1bmN0aW9uYWxp
dHkgb24gdGhpcyB0eXBlIG9mIG1lbW9yeS4KCkZvciB0aGUgbWlncmF0aW9uIGhlbHBlciBjaGFu
Z2VzIHdlIGNvdWxkIG1vZGlmeSBvciBwYXJhbWV0cml6ZSAKbGliL2htbV90ZXN0LmMgdG8gY3Jl
YXRlIERFVklDRV9HRU5FUklDIHBhZ2VzIGluc3RlYWQgb2YgREVWSUNFX1BSSVZBVEUuIApUaGVu
IHJ1biB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92bS9obW0tdGVzdHMuYy4KClJlZ2FyZHMsCiDC
oCBGZWxpeAoKCj4KPiBUaGFua3MsCj4KPiAJCQkJCS0gVGVkCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
