Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393E1C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E953D61E44
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E953D61E44
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8528489E2B;
	Mon,  7 Jun 2021 16:36:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1BEA89E2B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+VMIWYL4XyqSErJGU5sCXn3i+YkW4TonM0qc9aPfUbaWW4JORAPK8nO0KoFa+Cksx8Sj+GMp5uiCPZzCZChzV2IgMIVAHeuW6uXUulXnsJV8vKbQ5oF3C3o0QOZj1dPLJ0DSopRUbr47FkVue9gJQ04CPAv9W/MGFutAc97/OtRiD4+jVV/qsWytHBNUh7W+8sMgAgbn/wGDqemuNekwi6+KzHv5GAv1zlMerV6jM2NMvK60aw/ChuDpP82nf/T+iZPzTxRNR6iPHhQ4xKMY//UAluMoG3qVhKRQhZYxDqTMrxms7k5Hp2HrYwAmhEds2cYuaHwjFLjaQOX6c+bng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4JdtU2bcVcDFkNlIiEVtsy30cH6Yic04KWZ/Y8rlGw=;
 b=nnYVpEq+NllLHQUfoS4kk6MT0AFuvWnqvcmLtTISax1d5jkK/Azo6SVIPzgSLjTjCw0viebE89nZerQ30u+SHsjfHGXb1qMnOW9Lh6cw1majz0jqG9KuiyXnQMh6CIJRNita3O9GRZqJ+CBF6Ssx2ICY7+RH3eLZnIlGdMVa3Wvz/i5BHE15RANfhp368WGd5HpJw/+LksU3ZL8dr8VGzedW9ulWBnaPXHKDphoTjVe0PSEZyY5hbF8hzxA63gC+xu5LDpOG+zZeh+bFQKNdBlVkzWDIAqhoYq2ZO1M9EP/00+3XMQA8ITGn748MRbeQIvoVGsLJ9oFehhpZ5KWJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4JdtU2bcVcDFkNlIiEVtsy30cH6Yic04KWZ/Y8rlGw=;
 b=vdXpb2EJ6Xz3AI9W1gkJcyJYYddE7b+9dmXntGyiH7cifMH6Rvh3Y3DlIIjKYxY6BKGv/jSQ4VGzuTXhZli+07/zvKk/NuGRFSHyvcJfRs3b/s3I7STTG3k2rULqbk8ha1dxJ4rhHkMMx99Pg600Oqt/ZBs1JxbAZu4R2Y2mjXk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 16:36:02 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 16:36:02 +0000
Subject: Re: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on SRIOV
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Khaire, Rohit" <Rohit.Khaire@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>
References: <20210607142343.13509-1-rohit.khaire@amd.com>
 <392d7f26-51d6-f60e-6081-870afe8276b7@amd.com>
 <BL0PR12MB4755039C3515004ADD1051AA87389@BL0PR12MB4755.namprd12.prod.outlook.com>
 <da0025b0-308f-6f2f-e4d8-b5a68117828c@amd.com>
 <BL0PR12MB47552C90D8667E1107279AD487389@BL0PR12MB4755.namprd12.prod.outlook.com>
 <bf87ed0d-d32d-5701-f9bf-c71f6a6b23b6@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <fddc3188-55b9-55e4-485c-4568a621c466@amd.com>
Date: Mon, 7 Jun 2021 12:36:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <bf87ed0d-d32d-5701-f9bf-c71f6a6b23b6@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.203.225]
X-ClientProxiedBy: YTXPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::47) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.203.225) by
 YTXPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.30 via Frontend
 Transport; Mon, 7 Jun 2021 16:36:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72d817f4-47ac-4322-7e92-08d929d25674
X-MS-TrafficTypeDiagnostic: BN9PR12MB5337:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB53375A4C8F96A6F2932FCA9492389@BN9PR12MB5337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z14Pba04iazXDHjFPFET1xLPwCrXJeyZKjWj/AwlSHQFnNfH8eRP/syTql30QDHDrxJYkr+ds0uQCFmWM4SPkZJa5Y6SEHesrAJ3AVJBrZakC5e+kvOb3sfe3ZkcyOq9pQPdUUodYAL6JKKuGPUk5VXUuxHYvoISiZ0tTETzJwcgB7XcLfLMNaFuu4NRb/SeV+ERidvf+pgDsVRQgdQH3ieoaYHf2r4db2K5xjOnubl6kSfH29hXVabLjLrX/CruVuU52GWBTvoMTUiS2MRedB2u7FPDlMm4SHthVGziB3a33G3QGOXmhZNaM3jcbZOLp+eeTjg+tEzbFlVRacbMxvkTtvwsIHeduTUR4bu3JtnrGR5qkOG26gHmNIeoY13OINAyAlHC3OjwWm/fodzDR3kW5FSUShtsxjbibN/HvdDBUN02YrJcM/EEXmXABG9cA9D3BZ0x3aMHgSYiDUR5TNIhRIfq4tY9QYKfQj5LJ5vMlJpW5MUf0nleB075en7SBEv5bgR6it3lSPPzMb3MmJiXFdkiKXonkVeUEEvAKmpC33OPCPVMIa92fGtGEe2mvEo4ql7GBMCnYpNvvCrm0QoCeVow71IgygO9T2KNe55iVv0RULEUVmXuxfo1TOQ5/1rb2xg65vIq2G3eUMA8liMYuXmNL6colJg4WgJX7IIeL1ABTzvS177YHWQW8kx8rYBgl3Qi2Ko08AvOi+HHuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39840400004)(366004)(6636002)(8936002)(8676002)(478600001)(4326008)(83380400001)(44832011)(921005)(5660300002)(6486002)(66574015)(2616005)(956004)(38100700002)(26005)(186003)(66476007)(31686004)(31696002)(16576012)(86362001)(36756003)(316002)(53546011)(66946007)(110136005)(66556008)(16526019)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L09tWGJ3SmRMOTRONXh2U0VLSmpmY3ZOdU0vamNyUHJxcFgzMVVPREFZVXhm?=
 =?utf-8?B?NmxjMXJ2VTFySThtOE10cEdkbzljTTBSczdGclNzeHNNSzA0czViNzFpVmZF?=
 =?utf-8?B?RFNZeHExRDBRcmdIUEVsclg4WWdiRHZaR3UzSjU0TDQvdDE4VnY4VFJRNUpt?=
 =?utf-8?B?TTlHTUhXMDhnbjJYdXVPenN1YzQ1cVRhcms0bDArS3JHYXhBb29Qdld0NFRU?=
 =?utf-8?B?dGVXTmRlRXlJTEJpYkVFdnMzMFl3eFBHdis5bFJVN013eURtb3hjc0UvTTdx?=
 =?utf-8?B?dDNPSzJRekQ1U1RWWndNb1lhQldNenBKZXYrbEloaU4rS2ZKbVRsdWlqZ3RJ?=
 =?utf-8?B?UlMvUGxabk81VjFsVFlKYlRyNmxkRTFUL051TGU3K0RtOHN1eStCMkFhTlJy?=
 =?utf-8?B?cXdKYzlDK01iWkhzd0MycndZZ0Z2bVByNmo0cVZicFZvT29lTjV3WUh4ZWxn?=
 =?utf-8?B?d3d1cnVhU0pyNlRzSy9qd0RKdzU5OTZLWDhCK0lvc2F3VWROZEpsVzZndjF0?=
 =?utf-8?B?Nm11RWxsZW1WN0NFT2dMUU5zZ3hFRkxGOGg2U3RLTVVlN1FBSE1TOERiWW1i?=
 =?utf-8?B?b0k1bE4wU0lpVEZzZlVpZVZHcXF5WGQ1V2UxTGp3MzQ3bVFFbTFqOGovMFFE?=
 =?utf-8?B?dldra08yek9QYjlIL2JxYnZoV0YySFR2UXNzTkFOMmJteWJTcVVjQ2VqWGJN?=
 =?utf-8?B?cm95ZlFRaUZYRStEKzdXVlQ2VzFmay84NWZVZGxVa3ljWCs1TnNFKzVMelBu?=
 =?utf-8?B?OTljK2xJNXJpdXNUOW4rL3RxVnpIeFdLSjh0L3lQODhYaDlodTlRakhUMldZ?=
 =?utf-8?B?eVU0dXAyVkNGR3FYT1UrQUMrelFlWkNJY0FRM0dkbUt2WStqUkpZdk9DeW8w?=
 =?utf-8?B?Q25VUDAxMm1XeCsyUW9HejdNQjlMOHJFb0FyV1RjSDZWekdkWnFxMTZORS9X?=
 =?utf-8?B?MGJFdkpZK1F6SmhCLzMzd0lnSkRUdUNhbjI4VWIzeCtJcmxxQTFxWnJBNHFw?=
 =?utf-8?B?VFB0KzZaakdZcFhqQmFWZFpFdVNkUEVYL2ZLNEszcUlHeTRmWE1OQUdUZ3p2?=
 =?utf-8?B?SEg2MjVrQ1dubFNLMGNac1dlbFVpM2IrMDFPSHpOVU52R2pBczRJLzZJRTdi?=
 =?utf-8?B?ZVFtakgyWVhkblcrWGs5RDhqTGJKTlN4SEdmMkJZZ1gzbFQ0YjFCQnkzcitU?=
 =?utf-8?B?Z0FKSWRCSHRqMUwrUlRKN1o2MHZ5bmJxM1pjMWU5QmVHUlhVOFhmT2VObkFY?=
 =?utf-8?B?WXlwYXFTY2xJNDhNMGRKeTFHS29oblZWUWpSS2pzbndCS016djNNaUNOS2I0?=
 =?utf-8?B?WGNERGZESlF3Y3JRYmd4dFUxeFBBSnV4UkNLWng1d2NmSnlXUEN5RDBuWDU4?=
 =?utf-8?B?SVQvUHZaL0hYTVdWTmM3VEJ3c2dhMU1LcWg0VjZNeUlzU0IzbWIzSnc0cFdE?=
 =?utf-8?B?bWVrKyt5N2NSYlBMVVdLUDRqcHdIR2ExTGxiVFZha3VQUjRhN251VVpMNG5y?=
 =?utf-8?B?M0szczZZQlg3QkJlODNyQkxwTmJ5L0pVc1dkNjJtQzlLWkl4eWJtZkVDbmI3?=
 =?utf-8?B?bHpQNHFrQUhoN2s4TlR2NGZyd2M5WlFzNWVibHcwYXh0aEdLVUhrWVFaazVh?=
 =?utf-8?B?RmNZN0xVeERRQm5nSjVQTlRDSldhQ2tDY3VVdVNoRlo0VVJVS0JMc3pBbXlj?=
 =?utf-8?B?UVFpeEJCMkF6NXJ0Y3JTbUREbG4rNFNIQ0xYb0piN3Ura0JiMldRRE5jK0Zx?=
 =?utf-8?Q?9a21HIG2vjElPSM1saBUGUbvyOEpjn7Gg25BjoE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d817f4-47ac-4322-7e92-08d929d25674
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:36:02.1296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZ4D8s54xcHMHbZ8q0Hgv4NFLdfaJkgdeOuEU9EUIYKGGepdQeApjTFlddnHudegYsW9EzLx5mV1KLIJYowfgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
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
Cc: "Ming, Davis" <Davis.Ming@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V2l0aCBTUklPViwgdGhlIGludGVycnVwdCByb3V0aW5nIGlzIHNldHVwIGJ5IHRoZSBoeXBlcnZp
c29yIGRyaXZlci4gV2UKbmVlZCB0aGUgc2Vjb25kYXJ5IElIIHJpbmdzIGluIGNhc2UgdGhlIGh5
cGVydmlzb3IgZW5hYmxlZCByZXJvdXRpbmcgb2YKcGFnZSBmYXVsdCBpbnRlcnJ1cHRzLiBJJ20g
bm90IHN1cmUgd2hhdCB0aGUgaHlwZXJ2aXNvciBkcml2ZXIgZG9lcyB0b2RheS4KClJlZ2FyZHMs
CsKgIEZlbGl4CgoKQW0gMjAyMS0wNi0wNyB1bSAxMjoyOSBwLm0uIHNjaHJpZWIgQ2hyaXN0aWFu
IEvDtm5pZzoKPiBUaGF0J3MgYSB3b3JrYXJvdW5kIGZvciBiYXJlIG1ldGFsIGFuZCBhcyBmYXIg
YXMgSSBrbm93IGRvZXNuJ3QgYXBwbHkKPiB0byBTUklPVi4KPgo+IFdlIG9ubHkgbmVlZCB0aGUg
YWRkaXRpb25hbCBJSCByaW5ncyBmb3IgcGFnZSBmYXVsdCBoYW5kbGluZyBvciBsb2cKPiBoYW5k
bGluZyBhbmQgYXMgZmFyIGFzIEkga25vdyB0aGF0IGlzIGluY29tcGF0aWJsZSB3aXRoIFNSSU9W
IGZvciB0aGUKPiBtb21lbnQuIEJ1dCBGZWxpeCBtaWdodCBoYXZlIHNvbWUgbW9yZSB1cGRhdGVz
IG9uIHRoaXMuCj4KPiBTbyBhcyBsb25nIGFzIHdlIGRvbid0IHN1cHBvcnQgdGhhdCB1bmRlciBT
UklPViB3ZSBkb24ndCBuZWVkIHRoaXMKPiBwYXRjaCBlaXRoZXIuCj4KPiBDaHJpc3RpYW4uCj4K
PiBBbSAwNy4wNi4yMSB1bSAxNzo1OSBzY2hyaWViIEtoYWlyZSwgUm9oaXQ6Cj4+IFtBTUQgUHVi
bGljIFVzZV0KPj4KPj4gVGhlIGhhc2ggaXMgNWVhNmY5Ywo+Pgo+PiBSb2hpdAo+Pgo+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+PiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPgo+PiBTZW50OiBKdW5lIDcsIDIwMjEgMTE6NTggQU0KPj4gVG86
IEtoYWlyZSwgUm9oaXQgPFJvaGl0LktoYWlyZUBhbWQuY29tPjsKPj4gYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcgo+PiA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Owo+PiBEZW5n
LCBFbWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPjsgTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29t
PjsgWmhvdSwKPj4gUGVuZyBKdSA8UGVuZ0p1Llpob3VAYW1kLmNvbT47IENoZW4sIEhvcmFjZSA8
SG9yYWNlLkNoZW5AYW1kLmNvbT4KPj4gQ2M6IE1pbmcsIERhdmlzIDxEYXZpcy5NaW5nQGFtZC5j
b20+Cj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IFVzZSBQU1AgdG8gcHJvZ3Jh
bQo+PiBJSF9SQl9DTlRMX1JJTkcxLzIgb24gU1JJT1YKPj4KPj4gRG8geW91IGhhdmUgdGhlIGhh
c2ggZm9yIHRoaXMgY29tbWl0Pwo+Pgo+PiBUaGFua3MsCj4+IENocmlzdGlhbi4KPj4KPj4gQW0g
MDcuMDYuMjEgdW0gMTc6MzAgc2NocmllYiBLaGFpcmUsIFJvaGl0Ogo+Pj4gW0FNRCBQdWJsaWMg
VXNlXQo+Pj4KPj4+IFdlIGRvbid0IG5lZWQgUklORzEgYW5kIFJJTkcyIGZ1bmN0aW9uYWxpdHkg
Zm9yIFNSSU9WIGFmYWlrLgo+Pj4KPj4+IEJ1dCBsb29raW5nIGF0IHRoZSBkZXNjcmlwdGlvbiBv
ZiB0aGUgb3JpZ2luYWwgY29tbWl0IG1lc3NhZ2UgaXQKPj4+IGFmZmVjdHMgUklORzAgdG9vPwo+
Pj4KPj4+ICIgZHJtL2FtZGdwdTogYWRkIHRpbWVvdXQgZmx1c2ggbWVjaGFuaXNtIHRvIHVwZGF0
ZSB3cHRyIGZvciBzZWxmCj4+PiBpbnRlcnJ1cHQgKHYyKQo+Pj4KPj4+IG91dHN0YW5kaW5nIGxv
ZyByZWFjaGVzIHRocmVzaG9sZCB3aWxsIHRyaWdnZXIgSUggcmluZzEvMidzIHdwdHIKPj4+IHJl
cG9ydGVkLCB0aGF0IHdpbGwgYXZvaWQgZ2VuZXJhdGluZyBpbnRlcnJ1cHRzIHRvIHJpbmcwIHRv
byBmcmVxdWVudC4KPj4+IEJ1dCBpZiByaW5nMS8yJ3Mgd3B0ciBoYXNuJ3QgYmVlbiBpbmNyZWFz
ZWQgZm9yIGEgbG9uZyB0aW1lLCB0aGUKPj4+IG91dHN0YW5kaW5nIGxvZyBjYW4ndCByZWFjaCB0
aHJlc2hvbGQgc28gdGhhdCBkcml2ZXIgY2FuJ3QgZ2V0IGxhdGVzdAo+Pj4gd3B0ciBpbmZvIGFu
ZCBtaXNzIHNvbWUgaW50ZXJydXB0cy4iCj4+Pgo+Pj4gUm9oaXQKPj4+Cj4+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQo+Pj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5L
b2VuaWdAYW1kLmNvbT4KPj4+IFNlbnQ6IEp1bmUgNywgMjAyMSAxMDozMSBBTQo+Pj4gVG86IEto
YWlyZSwgUm9oaXQgPFJvaGl0LktoYWlyZUBhbWQuY29tPjsKPj4+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIKPj4+IDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47Cj4+PiBEZW5n
LCBFbWlseSA8RW1pbHkuRGVuZ0BhbWQuY29tPjsgTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29t
PjsgWmhvdSwKPj4+IFBlbmcgSnUgPFBlbmdKdS5aaG91QGFtZC5jb20+OyBDaGVuLCBIb3JhY2Ug
PEhvcmFjZS5DaGVuQGFtZC5jb20+Cj4+PiBDYzogTWluZywgRGF2aXMgPERhdmlzLk1pbmdAYW1k
LmNvbT4KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IFVzZSBQU1AgdG8gcHJv
Z3JhbSBJSF9SQl9DTlRMX1JJTkcxLzIKPj4+IG9uIFNSSU9WCj4+Pgo+Pj4gV2h5IGFyZSB0aGUg
cmluZyAxJjIgZW5hYmxlZCBvbiBTUklPViBpbiB0aGUgZmlyc3QgcGxhY2U/Cj4+Pgo+Pj4gQ2hy
aXN0aWFuLgo+Pj4KPj4+IEFtIDA3LjA2LjIxIHVtIDE2OjIzIHNjaHJpZWIgUm9oaXQgS2hhaXJl
Ogo+Pj4+IFRoaXMgaXMgc2ltaWxhciB0byBJSF9SQl9DTlRMIHByb2dyYW1taW5nIGluCj4+Pj4g
bmF2aTEwX2loX3RvZ2dsZV9yaW5nX2ludGVycnVwdHMKPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6
IFJvaGl0IEtoYWlyZSA8cm9oaXQua2hhaXJlQGFtZC5jb20+Cj4+Pj4gLS0tCj4+Pj4gwqDCoMKg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9paC5jIHwgMjAgKysrKysrKysrKysr
KysrKysrLS0KPj4+PiDCoMKgwqAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvbmF2aTEwX2loLmMKPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25hdmkx
MF9paC5jCj4+Pj4gaW5kZXggZWFjNTY0ZThkZDUyLi5lNDExODhjMDQ4NDYgMTAwNjQ0Cj4+Pj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMKPj4+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYwo+Pj4+IEBAIC0xMjAsMTEgKzEy
MCwyNyBAQCBmb3JjZV91cGRhdGVfd3B0cl9mb3Jfc2VsZl9pbnQoc3RydWN0Cj4+Pj4gYW1kZ3B1
X2RldmljZSAqYWRldiwKPj4+PiDCoMKgwqDCoMKgwqDCoCBpaF9yYl9jbnRsID0gUkVHX1NFVF9G
SUVMRChpaF9yYl9jbnRsLCBJSF9SQl9DTlRMX1JJTkcxLAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJCX1VTRURfSU5UX1RIUkVTSE9MRCwgdGhyZXNo
b2xkKTsKPj4+PiDCoMKgwqAgLcKgwqDCoCBXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JC
X0NOVExfUklORzEsIGloX3JiX2NudGwpOwo+Pj4+ICvCoMKgwqAgaWYgKGFtZGdwdV9zcmlvdl92
ZihhZGV2KSAmJgo+Pj4+IGFtZGdwdV9zcmlvdl9yZWdfaW5kaXJlY3RfaWgoYWRldikpIHsKPj4+
PiArwqDCoMKgwqDCoMKgwqAgaWYgKHBzcF9yZWdfcHJvZ3JhbSgmYWRldi0+cHNwLCBQU1BfUkVH
X0lIX1JCX0NOVExfUklORzEsCj4+Pj4gaWhfcmJfY250bCkpIHsKPj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBEUk1fRVJST1IoIlBTUCBwcm9ncmFtIElIX1JCX0NOVExfUklORzEgZmFpbGVk
IVxuIik7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4+ICvCoMKgwqDC
oMKgwqDCoCB9Cj4+Pj4gK8KgwqDCoCB9IGVsc2Ugewo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBXUkVH
MzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX0NOVExfUklORzEsIGloX3JiX2NudGwpOwo+Pj4+
ICvCoMKgwqAgfQo+Pj4+ICsKPj4+PiDCoMKgwqDCoMKgwqDCoCBpaF9yYl9jbnRsID0gUlJFRzMy
X1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMX1JJTkcyKTsKPj4+PiDCoMKgwqDCoMKgwqDC
oCBpaF9yYl9jbnRsID0gUkVHX1NFVF9GSUVMRChpaF9yYl9jbnRsLCBJSF9SQl9DTlRMX1JJTkcy
LAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJCX1VT
RURfSU5UX1RIUkVTSE9MRCwgdGhyZXNob2xkKTsKPj4+PiAtwqDCoMKgIFdSRUczMl9TT0MxNShP
U1NTWVMsIDAsIG1tSUhfUkJfQ05UTF9SSU5HMiwgaWhfcmJfY250bCk7Cj4+Pj4gK8KgwqDCoCBp
ZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpICYmCj4+Pj4gYW1kZ3B1X3NyaW92X3JlZ19pbmRpcmVj
dF9paChhZGV2KSkgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocHNwX3JlZ19wcm9ncmFtKCZh
ZGV2LT5wc3AsIFBTUF9SRUdfSUhfUkJfQ05UTF9SSU5HMiwKPj4+PiBpaF9yYl9jbnRsKSkgewo+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERSTV9FUlJPUigiUFNQIHByb2dyYW0gSUhfUkJf
Q05UTF9SSU5HMiBmYWlsZWQhXG4iKTsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm47Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4+PiArwqDCoMKgIH0gZWxzZSB7Cj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIFdSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfQ05UTF9SSU5HMiwg
aWhfcmJfY250bCk7Cj4+Pj4gK8KgwqDCoCB9Cj4+Pj4gKwo+Pj4+IMKgwqDCoMKgwqDCoMKgIFdS
RUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfQ05UTDIsIGloX2NudGwpOwo+Pj4+IMKgwqDCoCB9
Cj4+Pj4gwqDCoMKgIAo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
