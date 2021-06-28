Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F48C49361
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 16:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8902161C75
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 16:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8902161C75
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35DEC6E4C9;
	Mon, 28 Jun 2021 16:47:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C40506E4C9;
 Mon, 28 Jun 2021 16:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fd+k30fhtqq1U9Fgds+yWflHzIFlDYRo/kNZr8B7TnbpVAcuEXMb4elql7sKbdcxguIqRprY9iV9xWr1nf5HNo/yr58YyIkrBNf01WiKo/L1BlNoE2jP5qX0U7avdS9fpjyHxaS+QhH1y/vrpuoNahtxIQBVeEgINVPXavpv2aM+R5uHXoQ5DdXLJO+WAkuEi/3WwNv3cOY0C7u7pLpeBVTVAirDFL/Q+rHRF/qTmndOhNRkM/nYeUV2oVe2xwB0s4hDbPbs1xYp/mYdZ7V8RcYHZdPoJJIPKkI68RYp1nmmUjNQ1n9K576gehCltLqrmoAJjTBLsE2xnlafJCa6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6xa9nBhRPhAbXzugk+lM3GMXBxPAV3UekqYIKTOlWc=;
 b=TflTfz+2u/S8IsYPJJc0/hbRt1z1/r/AKmgn6ai7GSvVWn/P+/h5Nw7Ru6+lcf0XvHsstIVRLq4/fCRtM/DObOLUvkaOZ3puflD14o/5MMG2vqBszgHSrUGwf6ZHQfG/M01k0kUri2gBMdK8+bIBjwDs6cz1RoiN0V0+7mPCD4/Bdf7uCKkYm6qV82nXisfV2/irMSYZjxsHo79kDFUAbyHX1NUkR/FqM2TXrk7IyNq1wa9wvKHEiZJ+ygil4FqIGtemfc00poHOmUka/Gzqce1KHdoyvZRzNIn7qBEFVYCu0mBI8mYwHLo4vdCIe6s5YM0n7iK5HyTYxJse4Xx7Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6xa9nBhRPhAbXzugk+lM3GMXBxPAV3UekqYIKTOlWc=;
 b=mV2XbJ6GCKvtnxgrcEc/o11zIXwKKBO62A6ggocLLLAqZlz94iY5+PSLPcZBBSNxXL0ZLNYAR72+ztytB3NaiF5hRsYaoa7pucQrMC4uGXzxwuDbP9JbTqhOmY0XRZ979NrA0EA2GEHnTKS949xfDvZELFob4QZDSDui+tgbaeM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 16:47:02 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 16:47:02 +0000
Subject: Re: [PATCH v3 2/8] mm: remove extra ZONE_DEVICE struct page refcount
To: Ralph Campbell <rcampbell@nvidia.com>, Alex Sierra <alex.sierra@amd.com>, 
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, "Yang, Philip" <Philip.Yang@amd.com>
References: <20210617151705.15367-1-alex.sierra@amd.com>
 <20210617151705.15367-3-alex.sierra@amd.com>
 <7163dbb6-67b5-6eef-5772-500fd2107e5c@nvidia.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <cecd2164-ebfd-382b-af73-992cdc4304b7@amd.com>
Date: Mon, 28 Jun 2021 12:46:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <7163dbb6-67b5-6eef-5772-500fd2107e5c@nvidia.com>
Content-Language: en-US
X-Originating-IP: [142.186.84.51]
X-ClientProxiedBy: YTOPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::22) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YTOPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Mon, 28 Jun 2021 16:47:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7479cdc7-c6ed-431e-8b72-08d93a545a74
X-MS-TrafficTypeDiagnostic: BN9PR12MB5211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5211C013EE36A1D13AAACBFD92039@BN9PR12MB5211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /NR3t/uGbDaaIgg8ksVn/h+K83WHFeFoNel23/yWfhDcqb8Bt1WJtgsXQ5O3p5dAW7I8GAIKaLN/7zP9umDTTmvKkcNZ44j++fcDkr/q8mn8Nyel7z0cXckSvVCcqWZZdIrafpopfweP5mFkg3Fcc2oJ3sqx7YM1SN/83QiV0aBl5XZAVOmrmRmeOIM53Fd6QxItIrAoX1uzsyTceavolJrSIzqqVQEscyLgiUx8EAkQf6ecIls3rLg5dYeXuz5y/fovd88AcsZVJoB9GmnNPM8xhIJfuCJC9VoMNXJbpaVrKi6ta1S58qM3RnhgCXEZgDpAWoOsXTpshLoRNKS8PnTRALW9nmD/Qhth5T9CWZ9qkYhojEcC9wUNHlocsF4BTAl2bXBUxkibbmCW1PnwvzuSSB7Jb5F8d1H916Qnn7/OqzXrEldzVo00Z4zYyIS7C29mtQMyx6qfSyXhK/esDb/1cuVsJ2qsYop8sds7twTZTXtLHv2BBYCjZgBzP5zvEgg4noMNRUsoqpiKl0tv4k8BaJoZM5NenjTGXJYlnu/PLYNtF8HoKZaEhHlErkKM2lnRlCMO1hmZikhe2+mrNMx0cS2OXexrofeyycSJjAdlFVTD8yAtyCDMSFyVgUBRbdr+evUgGeXticsIRDx23MtNcNdLBU6qJ6H4V4C1NpRU2fb/7PjvXwWmBsucvE0/7mJqEORaXYmK9W65avq9gQI/ZxphUz/uUzDGURhUAOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(316002)(16576012)(6486002)(26005)(7416002)(110136005)(16526019)(186003)(38100700002)(4326008)(83380400001)(956004)(478600001)(8676002)(86362001)(5660300002)(31686004)(44832011)(2906002)(6636002)(2616005)(31696002)(66946007)(36756003)(8936002)(53546011)(66556008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWdHWXdxZ25sNlhna1MyQWJCYVpFT0tJRkVEdmUzZUZaSzVQRFpmZUFWOVFF?=
 =?utf-8?B?OHBrSUlHOEY0dFZFOHBPaExhdTgydDRwRnRWQmtVd1ZjVWtqL3NlUk1uOEg5?=
 =?utf-8?B?alU4TEM2ZmFzdklSa1lEb2NYVkRtZDRvZzMxUVRvN0U1MElicXVQaS9UQ2c4?=
 =?utf-8?B?M2xiWklzNGo2eloyb1VxL0twdGpSVHVrQThsUU5rbDFCRHdhZzJ0VTNZSU5u?=
 =?utf-8?B?RFJTbm9sbFc1R0M4OHJNQVpQSzFTM3Q5YzNRVmJyOXJhbEpWR1FESWI1WUJC?=
 =?utf-8?B?WHhhU2R0bmN5WjFwa01Zdm8zQWdnbUwyVTlmS3kvcUxGVEp6TG5wL0tQYlQy?=
 =?utf-8?B?MlhOSlUvdmZOeWdKS1BvZnFLWFZCajkvOTYvOTVDTFJzc3ZJTThTMlFQcVBQ?=
 =?utf-8?B?WE1xeTg5bFc2YWVpZ0ZPTWtxZzRqcEJDU3c5blNJWDVPb0RtOFFXVjRub3RG?=
 =?utf-8?B?RzlDbmxsNkpwMmkyb2ZqRTE3bnpLNkhhbjV1ald0V0RQSjhEZDEzZ042MmpP?=
 =?utf-8?B?VzliRWZ5cHNJVnUzTytXZ3FOUmRBODByVVMzQVpEZG52SjNKOTFTQzdJd2t0?=
 =?utf-8?B?amxESnpMMytxeHZvc0d4WnNxVHVZSFVmU1pEY2lwUFNDU1h2SUZYcVpwa3N2?=
 =?utf-8?B?dGh3bjIxajF4alRWdmRQYUlEdkVBSHBYWkxLemZUUWF1RTJqbG5GeW0ySUo4?=
 =?utf-8?B?ejgzV0FOUjRGK2NKMCtmL3dOL0FwUUtJTUFlUkRJb1JuS1c3Y1RFWHluNFhR?=
 =?utf-8?B?cjBSa0tvZ1oxOXlxcHBKT1dyWnFlNzBMbjVhdWpYWWZMYTZtVnloZWduaXBR?=
 =?utf-8?B?NlhxK1N6dlE0cnlHQnpycktWTytIeVJzbVZRb1cwY1NYMmRsLzhnN2w0dFlj?=
 =?utf-8?B?MzhTWXJSdXMzU1hkQXlscEpJMHhIZE9HWU5KOVhFSmdNckorblVndjN6MWxW?=
 =?utf-8?B?Y0RGWllFbjFJZ1JZT1V2eENla3FpUmRIVXNSai94NE9uVnN1L2QvRlM4bkpH?=
 =?utf-8?B?M3R2YkVZU3NOekRGVUROeExEalBjSm1aY0ovcXFkSnlYRDcwMUhQVUtVRUNR?=
 =?utf-8?B?MDd3dSs2V1FOZThuQ0FZaFovRmZDbVR1Mmp1bTBaOG9uUTI1VDNGY3hoci9i?=
 =?utf-8?B?L0J6NzlRYmFncUljTG43YUdScWkzcjdtbGc3VFVNNEE5TDFnU1JzK1R3Qnk4?=
 =?utf-8?B?UUd5R0JuK05Zd0N2MU5xdFRMRWt1TkwrMFFkdHdDN2V4Q3dRUG1TNnlBSkFw?=
 =?utf-8?B?RDd2WmI5UFQxcE02V05LWXBNbEZIdytqd1REYnZETmRHQVVBOEZWVmdlM3RV?=
 =?utf-8?B?dVlFTmFnTld6dzI0cXlYVDdWM1ExaW1FWVZzZDFTTTc3bWkwTjRVdVdkUGRi?=
 =?utf-8?B?UnRtT3E2cERjVXZQREpUdGc2RWRKejF1b1cydFAwOVgzaWZzVmdzeTIvZWxO?=
 =?utf-8?B?Tkphd28rellIZE1hVEFJZ0gvWkF3WlBjaGRiR0phWDZoc0hCZEhWU1hDY2xk?=
 =?utf-8?B?NEtSdjhqT2p3Z1E3ZHpLMFpOQ29tV01SN05RM0p1S2lRWmtTTklraURyODdC?=
 =?utf-8?B?eDB5VlVuai9oTWZmZ0ZvZitLMkdKRmtwd0hmNEFjSjBhRFA2dW9MVFhSMTAv?=
 =?utf-8?B?ZlNrTEFldHB5aUF1cXF6dFY0U0tGV1lSRy9BQThmVGNESXM5T3pOb3h1Y1lR?=
 =?utf-8?B?LzFzWlhwb3JzRFF1Rm5uRUU5VlRYM3R3UE9QS245ODkyWUNaeEhLVFJQZ3o5?=
 =?utf-8?Q?He4bFy7utaHOf1pmhQn9wFr33oa2pUGB+rq+x2a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7479cdc7-c6ed-431e-8b72-08d93a545a74
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 16:47:02.1087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CFlwEuYWaNAl2aHlm31gbOgkdpjwdw9ar4WlDQA9RYcEvPIs1iYdodtcaRBpLVFZBmCKx3+2NsyUsHURc6XZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211
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
Cc: jglisse@redhat.com, jgg@nvidia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDIwMjEtMDYtMTcgdW0gMzoxNiBwLm0uIHNjaHJpZWIgUmFscGggQ2FtcGJlbGw6Cj4KPiBP
biA2LzE3LzIxIDg6MTYgQU0sIEFsZXggU2llcnJhIHdyb3RlOgo+PiBGcm9tOiBSYWxwaCBDYW1w
YmVsbCA8cmNhbXBiZWxsQG52aWRpYS5jb20+Cj4+Cj4+IFpPTkVfREVWSUNFIHN0cnVjdCBwYWdl
cyBoYXZlIGFuIGV4dHJhIHJlZmVyZW5jZSBjb3VudCB0aGF0Cj4+IGNvbXBsaWNhdGVzIHRoZQo+
PiBjb2RlIGZvciBwdXRfcGFnZSgpIGFuZCBzZXZlcmFsIHBsYWNlcyBpbiB0aGUga2VybmVsIHRo
YXQgbmVlZCB0bwo+PiBjaGVjayB0aGUKPj4gcmVmZXJlbmNlIGNvdW50IHRvIHNlZSB0aGF0IGEg
cGFnZSBpcyBub3QgYmVpbmcgdXNlZCAoZ3VwLCBjb21wYWN0aW9uLAo+PiBtaWdyYXRpb24sIGV0
Yy4pLiBDbGVhbiB1cCB0aGUgY29kZSBzbyB0aGUgcmVmZXJlbmNlIGNvdW50IGRvZXNuJ3QKPj4g
bmVlZCB0bwo+PiBiZSB0cmVhdGVkIHNwZWNpYWxseSBmb3IgWk9ORV9ERVZJQ0UuCj4+Cj4+IHYy
Ogo+PiBBUzogbWVyZ2VkIHRoaXMgcGF0Y2ggaW4gbGludXggNS4xMSB2ZXJzaW9uCj4+Cj4+IFNp
Z25lZC1vZmYtYnk6IFJhbHBoIENhbXBiZWxsIDxyY2FtcGJlbGxAbnZpZGlhLmNvbT4KPj4gU2ln
bmVkLW9mZi1ieTogQWxleCBTaWVycmEgPGFsZXguc2llcnJhQGFtZC5jb20+Cj4+IC0tLQo+PiDC
oCBhcmNoL3Bvd2VycGMva3ZtL2Jvb2szc19odl91dm1lbS5jwqDCoMKgwqAgfMKgIDIgKy0KPj4g
wqAgZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbm91dmVhdV9kbWVtLmMgfMKgIDIgKy0KPj4gwqAg
ZnMvZGF4LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDQgKy0KPj4gwqAgaW5jbHVkZS9saW51eC9kYXguaMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICstCj4+IMKgIGluY2x1ZGUvbGludXgv
bWVtcmVtYXAuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDcgKy0tCj4+IMKgIGlu
Y2x1ZGUvbGludXgvbW0uaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fCA0NCAtLS0tLS0tLS0tLS0tLS0tLQo+PiDCoCBsaWIvdGVzdF9obW0uY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQo+PiDCoCBtbS9pbnRl
cm5hbC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDggKysrCj4+IMKgIG1tL21lbXJlbWFwLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDY4ICsrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tCj4+
IMKgIG1tL21pZ3JhdGUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDUgLS0KPj4gwqAgbW0vcGFnZV9hbGxvYy5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArKwo+PiDCoCBtbS9zd2FwLmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgNDUgKystLS0tLS0tLS0tLS0tLS0KPj4gwqAgMTIgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0
aW9ucygrKSwgMTQ3IGRlbGV0aW9ucygtKQo+Pgo+IEkgdGhpbmsgaXQgaXMgZ3JlYXQgdGhhdCB5
b3UgYXJlIHBpY2tpbmcgdGhpcyB1cCBhbmQgdHJ5aW5nIHRvIHJldml2ZSBpdC4KPgo+IEhvd2V2
ZXIsIEkgaGF2ZSBhIG51bWJlciBvZiBjb25jZXJucyBhYm91dCBob3cgaXQgYWZmZWN0cyBleGlz
dGluZwo+IFpPTkVfREVWSUNFCj4gTUVNT1JZX0RFVklDRV9HRU5FUklDIGFuZCBNRU1PUllfREVW
SUNFX0ZTX0RBWCB1c2VycyBhbmQgSSBkb24ndCBzZWUgdGhpcwo+IGFkZHJlc3NpbmcgdGhlbS4g
Rm9yIGV4YW1wbGUsIGRldl9kYXhfcHJvYmUoKSBhbGxvY2F0ZXMKPiBNRU1PUllfREVWSUNFX0dF
TkVSSUMKPiBzdHJ1Y3QgcGFnZXMgYW5kIHRoZW46Cj4gwqAgZGV2X2RheF9mYXVsdCgpCj4gwqDC
oMKgIGRldl9kYXhfaHVnZV9mYXVsdCgpCj4gwqDCoMKgwqDCoCBfX2Rldl9kYXhfcHRlX2ZhdWx0
KCkKPiDCoMKgwqDCoMKgwqDCoCB2bWZfaW5zZXJ0X21peGVkKCkKPiB3aGljaCBqdXN0IGluc2Vy
dHMgdGhlIFBGTiBpbnRvIHRoZSBDUFUgcGFnZSB0YWJsZXMgd2l0aG91dCBpbmNyZWFzaW5nCj4g
dGhlIHBhZ2UKPiByZWZjb3VudCBzbyBpdCBpcyB6ZXJvICh3aGVyZWFzIGl0IHdhcyBvbmUgYmVm
b3JlKS4gQnV0IHVzaW5nCj4gZ2V0X3BhZ2UoKSB3aWxsCj4gdHJpZ2dlciBWTV9CVUdfT05fUEFH
RSgpIGlmIGl0IGlzIGVuYWJsZWQuIFRoZXJlIGlzbid0IGFueSBjdXJyZW50Cj4gbm90aW9uIG9m
Cj4gZnJlZSB2ZXJzZXMgYWxsb2NhdGVkIGZvciB0aGVzZSBzdHJ1Y3QgcGFnZXMuIEkgc3VwcG9z
ZSBpbml0X3BhZ2VfY291bnQoKQo+IGNvdWxkIGJlIGNhbGxlZCBvbiBhbGwgdGhlIHN0cnVjdCBw
YWdlcyBpbiBkZXZfZGF4X3Byb2JlKCkgdG8gZml4IHRoYXQKPiB0aG91Z2guCgpIaSBSYWxwaCwK
CkZvciBERVZJQ0VfR0VORVJJQyBwYWdlcyBmcmVlX3pvbmVfZGV2aWNlX3BhZ2UgZG9lc24ndCBk
byBhbnl0aGluZy4gU28KSSdtIG5vdCBzdXJlIHdoYXQgdGhlIHJlZmVyZW5jZSBjb3VudGluZyBp
cyBnb29kIGZvciBpbiB0aGlzIGNhc2UuCgpBbGV4IGlzIGdvaW5nIHRvIGFkZCBmcmVlX3pvbmVf
ZGV2aWNlX3BhZ2Ugc3VwcG9ydCBmb3IgREVWSUNFX0dFTkVSSUMKcGFnZXMgKHBhdGNoIDggb2Yg
dGhpcyBzZXJpZXMpLiBIb3dldmVyLCBldmVuIHRoZW4sIGl0IG9ubHkgZG9lcwphbnl0aGluZyBp
ZiB0aGVyZSBpcyBhbiBhY3R1YWwgY2FsbCB0byBwdXRfcGFnZS4gV2hlcmUgd291bGQgdGhhdCBj
YWxsCmNvbWUgZnJvbSBpbiB0aGUgZGV2X2RheCBkcml2ZXIgY2FzZT8KCgo+Cj4gSSdtIGV2ZW4g
bGVzcyBjbGVhciBhYm91dCBob3cgdG8gZml4IE1FTU9SWV9ERVZJQ0VfRlNfREFYLiBGaWxlCj4g
c3lzdGVtcyBoYXZlIGNsZWFyCj4gYWxsb2NhdGUgYW5kIGZyZWUgc3RhdGVzIGZvciBiYWNraW5n
IHN0b3JhZ2UgYnV0IHRoZXJlIGFyZSB0aGUKPiBjb21wbGljYXRpb25zIHdpdGgKPiB0aGUgcGFn
ZSBjYWNoZSByZWZlcmVuY2VzLCBldGMuIHRvIGNvbnNpZGVyLiBUaGUgPjEgdG8gMSByZWZlcmVu
Y2UKPiBjb3VudCBzZWVtcyB0bwo+IGJlIHVzZWQgdG8gdGVsbCB3aGVuIGEgcGFnZSBpcyBpZGxl
IChubyBJL08sIHJlY2xhaW0gc2Nhbm5lcnMpIHJhdGhlcgo+IHRoYW4gZnJlZQo+IChub3QgYWxs
b2NhdGVkIHRvIGFueSBmaWxlKSBidXQgSSdtIG5vdCAxMDAlIHN1cmUgYWJvdXQgdGhhdCBzaW5j
ZSBJCj4gZG9uJ3QgcmVhbGx5Cj4gdW5kZXJzdGFuZCBhbGwgdGhlIGlzc3VlcyBhcm91bmQgd2h5
IGEgZmlsZSBzeXN0ZW0gbmVlZHMgdG8gaGF2ZSBhIERBWAo+IG1vdW50IG9wdGlvbgo+IGJlc2lk
ZXMga25vd2luZyB0aGF0IHRoZSBzdG9yYWdlIGJsb2NrIHNpemUgaGFzIHRvIGJlIGEgbXVsdGlw
bGUgb2YKPiB0aGUgcGFnZSBzaXplLgoKVGhlIG9ubHkgdGhpbmcgdGhhdCBoYXBwZW5zIGluIGZy
ZWVfem9uZV9kZXZpY2VfcGFnZSBmb3IgRlNfREFYIHBhZ2VzIGlzCndha2VfdXBfdmFyKCZwYWdl
LT5fcmVmY291bnQpLiBJIGd1ZXNzLCB3aG9ldmVyIGlzIHdhaXRpbmcgZm9yIHRoaXMKd2FrZS11
cCB3aWxsIG5lZWQgdG8gYmUgcHJlcGFyZWQgdG8gc2VlIGEgcmVmY291bnQgMCBpbnN0ZWFkIG9m
IDEgbm93LiBJCnNlZSB0aGVzZSBjYWxsZXJzIHRoYXQgd291bGQgbmVlZCB0byBiZSB1cGRhdGVk
OgoKLi9mcy9leHQ0L2lub2RlLmM6wqDCoMKgIMKgwqDCoCBlcnJvciA9IF9fX3dhaXRfdmFyX2V2
ZW50KCZwYWdlLT5fcmVmY291bnQsCi4vZnMvZXh0NC9pbm9kZS5jLcKgwqDCoCDCoMKgwqAgwqDC
oMKgIMKgwqDCoCBhdG9taWNfcmVhZCgmcGFnZS0+X3JlZmNvdW50KSA9PSAxLAouL2ZzL2V4dDQv
aW5vZGUuYy3CoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgVEFTS19JTlRFUlJVUFRJQkxFLCAw
LCAwLAouL2ZzL2V4dDQvaW5vZGUuYy3CoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgZXh0NF93
YWl0X2RheF9wYWdlKGVpKSk7Ci0tCi4vZnMvZnVzZS9kYXguYzrCoMKgwqAgcmV0dXJuIF9fX3dh
aXRfdmFyX2V2ZW50KCZwYWdlLT5fcmVmY291bnQsCi4vZnMvZnVzZS9kYXguYy3CoMKgwqAgwqDC
oMKgIMKgwqDCoCBhdG9taWNfcmVhZCgmcGFnZS0+X3JlZmNvdW50KSA9PSAxLApUQVNLX0lOVEVS
UlVQVElCTEUsCi4vZnMvZnVzZS9kYXguYy3CoMKgwqAgwqDCoMKgIMKgwqDCoCAwLCAwLCBmdXNl
X3dhaXRfZGF4X3BhZ2UoaW5vZGUpKTsKLS0KLi9mcy94ZnMveGZzX2ZpbGUuYzrCoMKgwqAgcmV0
dXJuIF9fX3dhaXRfdmFyX2V2ZW50KCZwYWdlLT5fcmVmY291bnQsCi4vZnMveGZzL3hmc19maWxl
LmMtwqDCoMKgIMKgwqDCoCDCoMKgwqAgYXRvbWljX3JlYWQoJnBhZ2UtPl9yZWZjb3VudCkgPT0g
MSwKVEFTS19JTlRFUlJVUFRJQkxFLAouL2ZzL3hmcy94ZnNfZmlsZS5jLcKgwqDCoCDCoMKgwqAg
wqDCoMKgIDAsIDAsIHhmc193YWl0X2RheF9wYWdlKGlub2RlKSk7CgpSZWdhcmRpbmcgeW91ciBw
YWdlLWNhY2hlIGNvbW1lbnQsIGRvZXNuJ3QgREFYIG1lYW4gdGhhdCB0aG9zZSBmaWxlCnBhZ2Vz
IGFyZSBub3QgaW4gdGhlIHBhZ2UgY2FjaGU/CgpSZWdhcmRzLArCoCBGZWxpeAoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
