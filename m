Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C4DC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 13:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E2F61041
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 13:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E2F61041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 159D66E466;
	Mon, 10 May 2021 13:54:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA4B6E466
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 13:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqrhpgtW5sAZA/OLewiAjP0HxSOq2tEjZ9vjvuQ2ljl6ywD8VmNTIzc0QwyO4jKdKvLwa2Txp7DmhCVVp59n1WKKUBQmjyEWCZECly+lSvMf1/U18FS8IdYj1EF5caoMa81g6HMk1cXZYNdLOgu8qAyhPD9BvjbXKrILNjHs12cHaVJrNmErSBXDzOPtxvNfLH2X7GQf2Pt7z3ji4LaX1Cy8pdLkOB8j4jZiNtrW73DzarsCUTwZafFx4A2TmMJhej25D1bdZ4e84jmrpUawNfMZcOK5zkMB1NuXCF3KAoJ+iWpQ7+RekyeLoRyNfAvjcK6OmidYlrHXMwgoybXIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrkooZjLOF/gzM+8FWXCr9dxRNxhIB6THdsZKEzIGRM=;
 b=C2w1qp6UEWx9u9SWcdDxKDNUa11n+oszmiWS347SiV3Q3UgJR+NAslmbLU1ibgxdsOpOb6UYwiRHUTQijXZZdqOwGPcBHtH9vo5GR5S9c88nFRn7SVeOySsRdKALqW+hLdBR++8WCY2mNoB9On7eYhwa7VDgITTPBqraOLVSHjIY90Ur3NoKwPsmbSRDK9BXVie9Wwb6oCNRhguUBu7F+XsqcbYzhtSQUXzy4FDtiRzh1SSbzpQQ/gHFyD7x7FbWgWYymHTKq2Xh0NoPMgBuSqwVCU7cUI0ZofJI9xdsk7SKMqahiek8JjJOqm4qfD9VkW8P66zCUA/8Sk8sbgpwZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrkooZjLOF/gzM+8FWXCr9dxRNxhIB6THdsZKEzIGRM=;
 b=HpANfxcdCs4VPS6it7woKn3xA8Upz8ByBAVgKZSs5h7+v4gHCnIMZttJlSBh1+ZV62lb8LOfWRLNGlz1phDHI2FBNX/CkVwaNuFBZexvC+QeUSSk6MQgq9YkWHQUZHXUfz8PqgrBwrag/bc3i+1oLwUwG3IS187r3oy3SM9RTDw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 13:54:11 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 13:54:11 +0000
Subject: Re: [PATCH 5/5] drm/amdkfd: classify and map mixed svm range pages in
 GPU
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210507033637.29622-1-alex.sierra@amd.com>
 <20210507033637.29622-5-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <c8d9afee-6dc9-a657-82e1-922ee5c31e5a@amd.com>
Date: Mon, 10 May 2021 09:54:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210507033637.29622-5-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YT2PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::13) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YT2PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Mon, 10 May 2021 13:54:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f980c61-0087-4a54-e62a-08d913bb16b7
X-MS-TrafficTypeDiagnostic: BN9PR12MB5306:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5306F389E77085B3C30CE14D92549@BN9PR12MB5306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8RbdySf5Fw5xwSHMD366VYS3pATbWjcNavb/iYhAQm56l+gXX+logQ5uu/5edtZkX2JEaOFiF6feUntXrItDKXAc2elrQhcXSMMHHMRV1G9RmLo8z6Pa42Ekqav2dN3J7f79RceIrRaPYxNkhazOSJ/XYTyn+JK428kM+kPI3+uOrPUu5FcmRlNGyJILkt5gxtju4OTB1J7c7awnbz87HqP9h49tZxyM2kloMPG3e/mOpQ+G2vyGcndDiFnduIk6YkSit3PZEZtjkMNUPWLxFG67KZK/907JYjWnYJgLbTCKpK+zK08cnvCQj0ZWtRsR9t8Kklwe3a/SoagJhcK2MJdJvlIFKktWdeypktV9SkOMAenzrK4+g1h/rTMBQ6syCY6ODB3QznVGbYY0/dpahOt8dnGEskQ2CmLuJLQTyXsa8ZECttwRRI7EAnxL4BdXfqxQZxCeEihubhIyUbHy1+olAFyMNiU2QRLHFaUPl31HRZFNPkvACBwcVnTYfdDikMh0e4fmpnjOBxEuGyQy8Y+Bu7gDQiou+whyA/WbkTRiQWsL5orCAqD05BReoK8Ilga9tTlTvuJA81U0YnxUBYmqopP4wjK1UDr+/ADfk+pFOetFnxPEWQIkhecXNpyKe8HwPQ2Yr0q7dS7IqynKdKn1Nqlhg6PO5v74S2uz/Z4Zr9NS6/YKu4hXyPDOnSLm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(31696002)(44832011)(31686004)(83380400001)(66946007)(66556008)(36756003)(2906002)(66476007)(316002)(16576012)(5660300002)(2616005)(6486002)(8936002)(956004)(86362001)(38100700002)(16526019)(8676002)(186003)(26005)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dGowYlgxOGlSUDNnTVBTNTJFdWwycVAvL1kvMXpqdkRxa0tkTmxGd1BNak0x?=
 =?utf-8?B?eHRlVkJvaVNCaUVwTk1ZQ0RrVUtETjA2SHpLNkltZG9BSE13VFNoSXBkT3Yz?=
 =?utf-8?B?RlhpbFNlNEp5VHFpZEp3d3ZJMDFSSDJkQW1Id2w2OWRZV0k1TkxVNlFKQnZS?=
 =?utf-8?B?R1VhRTQ2Q1puRFdORUJya09EYVhDd2NnakJQcGhTN2pBYmdRS1c2Qk5xekJp?=
 =?utf-8?B?TWVQSG80aWk2QWRONEdFTjgrbUt2OVFFSDd6ZXdsdkJJTEhvMXlISUpTRTlU?=
 =?utf-8?B?QXNtWllUcDU1ZHBOVU5sVCt5d2lDS2w3Q2xzdnh6c3hncy9zU3hQQlI0alVp?=
 =?utf-8?B?cnBrSmVBTWpDYUFuVjQrMTRIdTJuRHFWTC9GNy8rUkZQOXBaWnMvQ0sycGF6?=
 =?utf-8?B?OEhmbC8zU3NEeklIWng1TzJVR0tFMCtCYnpGTHZ3dit5d0tpUWVXdmZDdGxu?=
 =?utf-8?B?eEliOUdjRnBrd05lc2ZLaGdhazFpQlIxcUE0VW5qdE9xVFlqV040dG1YQ2JD?=
 =?utf-8?B?Wk1iWVFzTzBpZUtiU0tQTXpHNm1RTjJYZHI5UlZBQ3hzUzNYUkJNOHpqMTkx?=
 =?utf-8?B?TTIxdGU1RTl3cHFtQWx2ZlI1bnZjZTQ4SHF0c0ljSE4zYmd1b2NSSkdjcTRi?=
 =?utf-8?B?NE40M0FYbU12NWdNOEtsRlllb3VVZ0JuUzZZN1pVSFgwd1I2WER3Z2pSSS9M?=
 =?utf-8?B?QkhxdTlxeWp5MTlFU1d0Qyt2YUJGMFN5M2ZieXVjdFhhc1pXV2JZNUwwZERo?=
 =?utf-8?B?aXlYdmpGbVk4YnZHZ3NVYzVTeE5EYmlKMVpwcmtnR0dhZE1hM09nK0hIM1g1?=
 =?utf-8?B?dG03QitDdFpHcEJlaDhwYXlDb1dXTDNzcGNkdTBWNk1XRFpRN2htMkxZcU5y?=
 =?utf-8?B?ZG9jRklaY0dNc0tpdkM3MFVVRFpRTEpXajcyMXppUnFEU3RqOFJWaDlKUGU0?=
 =?utf-8?B?NzNPbUZSSUZtQkVGdjJsUjRZaEVPMlVmU2ErYi9aSGZGQ2FmU3owblNrVm9I?=
 =?utf-8?B?Ym5lTWpqYmEzNTYySFBDY0NZeEtJdnRHeFNhZ0orRFhjS2VYZXpMSmNMRktn?=
 =?utf-8?B?bHFVeGFFeFY2M05OcWZoQ1pjRW41MDNsVkhFNzFUdVRpVmxINk1nZE9HVVpI?=
 =?utf-8?B?RVdvUFZiMFRCZzE1cytQVTBEeWJKa0V5MjZzWEFIdUNjTUJKcFBBWTdsRXF2?=
 =?utf-8?B?RDIrTkpIREx2M0Q4VWhSejc4V3podzJLSkFFSWsxZXdJeVZEcktOR1FEeWxH?=
 =?utf-8?B?ZVF2REl2T24xeThpV2tNYWt3QjdSWGVjMENBaUw3OXJnbGtseFh6TzNiWXhj?=
 =?utf-8?B?OG9nSjFQa3lGM0o2QVVNRG1ML2JMMlJYQ0dXRWtRNHMzTU5KTG5GckgwYzF2?=
 =?utf-8?B?bDNXMkFSdTFiY3JXREVLQkRyUDd5THVuWXdhMkNIbERNc2g3ZmYrQnM4c040?=
 =?utf-8?B?MWZRcFV0Y0ZCN1YvZlVmQ0tkVWhCRURQSEZPdE4vWmdJOEdJVXdDWS9UbjBF?=
 =?utf-8?B?UkY3eTIyRytZZy85MUhCcnAzL3Nab1p5SS85d3VwZDgvSWloNGNTcllrVnFR?=
 =?utf-8?B?OHE1TzBLdzJoQ3h0aVZGdFpKTkp6azN0N0RFQWpSNnVrWnUxbFpDTkJya2Y4?=
 =?utf-8?B?SkxNWDBmOG9kMXRZeVc1N1UzWjc4aFByY1J6SHU3ZlF1YnppMisxUHdtUUo0?=
 =?utf-8?B?SVVyMUtvOS94VlNSTGNUTmo0UVhieDRJNHNoRGN1OFBqQUpOVXNtRHZJd05F?=
 =?utf-8?Q?Q0cysw46Ugexl4q9DuHAZtVz5xLhN3uqK6vdauI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f980c61-0087-4a54-e62a-08d913bb16b7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 13:54:11.1743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0roA3+iVTpK8gT2z/bgbOcCxlJnO64yTItMdkF5mFYJtkt3E0fPRzfA+kFuYOYHELCL1gvgfPm8+CNdUHby7g==
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

CkFtIDIwMjEtMDUtMDYgdW0gMTE6MzYgcC5tLiBzY2hyaWViIEFsZXggU2llcnJhOgo+IFtXaHld
Cj4gc3ZtIHJhbmdlcyBjYW4gaGF2ZSBtaXhlZCBwYWdlcyBmcm9tIGRldmljZSBvciBzeXN0ZW0g
bWVtb3J5Lgo+IEEgZ29vZCBleGFtcGxlIGlzLCBhZnRlciBhIHByYW5nZSBoYXMgYmVlbiBhbGxv
Y2F0ZWQgaW4gVlJBTSBhbmQgYQo+IGNvcHktb24td3JpdGUgaXMgdHJpZ2dlcmVkIGJ5IGEgZm9y
ay4gVGhpcyBpbnZhbGlkYXRlcyBzb21lIHBhZ2VzCj4gaW5zaWRlIHRoZSBwcmFuZ2UuIEVuZGRp
bmcgdXAgaW4gbWl4ZWQgcGFnZXMuCj4KPiBbSG93XQo+IEJ5IGNsYXNzaWZ5aW5nIGVhY2ggcGFn
ZSBpbnNpZGUgYSBwcmFuZ2UsIGJhc2VkIG9uIGl0cyB0eXBlLiBEZXZpY2Ugb3IKPiBzeXN0ZW0g
bWVtb3J5LCBkdXJpbmcgZG1hIG1hcHBpbmcgY2FsbC4gSWYgcGFnZSBjb3JyZXNwb25kcwo+IHRv
IFZSQU0gZG9tYWluLCBhIGZsYWcgaXMgc2V0IHRvIGl0cyBkbWFfYWRkciBlbnRyeSBmb3IgZWFj
aCBHUFUuCj4gVGhlbiwgYXQgdGhlIEdQVSBwYWdlIHRhYmxlIG1hcHBpbmcuIEFsbCBncm91cCBv
ZiBjb250aWd1b3VzIHBhZ2VzIHdpdGhpbgo+IHRoZSBzYW1lIHR5cGUgYXJlIG1hcHBlZCB3aXRo
IHRoZWlyIHByb3BlciBwdGUgZmxhZ3MuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IFNpZXJyYSA8
YWxleC5zaWVycmFAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX3N2bS5jIHwgNTEgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmggfCAgMSArCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzUg
aW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX3N2bS5jCj4gaW5kZXggOTQwMTY1ZjQ0MzdkLi4xNDQwZTRlNTU1ZjEgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jCj4gQEAgLTE0MSw2ICsxNDEsMTIgQEAgc3ZtX3Jh
bmdlX2RtYV9tYXBfZGV2KHN0cnVjdCBkZXZpY2UgKmRldiwgZG1hX2FkZHJfdCAqKmRtYV9hZGRy
LAo+ICAJCQlkbWFfdW5tYXBfcGFnZShkZXYsIGFkZHJbaV0sIFBBR0VfU0laRSwgZGlyKTsKPiAg
Cj4gIAkJcGFnZSA9IGhtbV9wZm5fdG9fcGFnZShobW1fcGZuc1tpXSk7Cj4gKwkJaWYgKGlzX3pv
bmVfZGV2aWNlX3BhZ2UocGFnZSkpIHsKPiArCQkJYWRkcltpXSA9IGhtbV9wZm5zW2ldIDw8IFBB
R0VfU0hJRlQ7Cj4gKwkJCWFkZHJbaV0gfD0gU1ZNX1JBTkdFX1ZSQU1fRE9NQUlOOwo+ICsJCQlw
cl9kZWJ1ZygidnJhbSBhZGRyZXNzIGRldGVjdGVkOiAweCVsbHhcbiIsIGFkZHJbaV0gPj4gUEFH
RV9TSElGVCk7Cj4gKwkJCWNvbnRpbnVlOwo+ICsJCX0KPiAgCQlhZGRyW2ldID0gZG1hX21hcF9w
YWdlKGRldiwgcGFnZSwgMCwgUEFHRV9TSVpFLCBkaXIpOwo+ICAJCXIgPSBkbWFfbWFwcGluZ19l
cnJvcihkZXYsIGFkZHJbaV0pOwo+ICAJCWlmIChyKSB7Cj4gQEAgLTExMzEsMzIgKzExMzcsNDMg
QEAgc3ZtX3JhbmdlX21hcF90b19ncHUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVj
dCBhbWRncHVfdm0gKnZtLAo+ICAJCSAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmJvX2FkZXYs
IHN0cnVjdCBkbWFfZmVuY2UgKipmZW5jZSkKPiAgewo+ICAJc3RydWN0IGFtZGdwdV9ib192YSBi
b192YTsKPiArCXN0cnVjdCB0dG1fcmVzb3VyY2UgKnR0bV9yZXM7Cj4gIAl1aW50NjRfdCBwdGVf
ZmxhZ3M7Cj4gKwl1bnNpZ25lZCBsb25nIGxhc3Rfc3RhcnQ7Cj4gKwlpbnQgbGFzdF9kb21haW47
Cj4gIAlpbnQgciA9IDA7Cj4gKwlpbnQ2NF90IGk7Cj4gIAo+ICAJcHJfZGVidWcoInN2bXMgMHgl
cCBbMHglbHggMHglbHhdXG4iLCBwcmFuZ2UtPnN2bXMsIHByYW5nZS0+c3RhcnQsCj4gIAkJIHBy
YW5nZS0+bGFzdCk7Cj4gIAo+IC0JaWYgKHByYW5nZS0+c3ZtX2JvICYmIHByYW5nZS0+dHRtX3Jl
cykgewo+ICsJaWYgKHByYW5nZS0+c3ZtX2JvICYmIHByYW5nZS0+dHRtX3JlcykKPiAgCQlib192
YS5pc194Z21pID0gYW1kZ3B1X3hnbWlfc2FtZV9oaXZlKGFkZXYsIGJvX2FkZXYpOwo+IC0JCXBy
YW5nZS0+bWFwcGluZy5ib192YSA9ICZib192YTsKPiAtCX0KPiAgCj4gLQlwcmFuZ2UtPm1hcHBp
bmcuc3RhcnQgPSBwcmFuZ2UtPnN0YXJ0Owo+IC0JcHJhbmdlLT5tYXBwaW5nLmxhc3QgPSBwcmFu
Z2UtPmxhc3Q7Cj4gLQlwcmFuZ2UtPm1hcHBpbmcub2Zmc2V0ID0gcHJhbmdlLT5vZmZzZXQ7Cj4g
LQlwdGVfZmxhZ3MgPSBzdm1fcmFuZ2VfZ2V0X3B0ZV9mbGFncyhhZGV2LCBwcmFuZ2UpOwo+ICsJ
bGFzdF9zdGFydCA9IHByYW5nZS0+c3RhcnQ7Cj4gKwlmb3IgKGkgPSAwOyBpIDwgcHJhbmdlLT5u
cGFnZXM7IGkrKykgewo+ICsJCWxhc3RfZG9tYWluID0gZG1hX2FkZHJbaV0gJiBTVk1fUkFOR0Vf
VlJBTV9ET01BSU47Cj4gKwkJaWYgKChwcmFuZ2UtPnN0YXJ0ICsgaSkgPCBwcmFuZ2UtPmxhc3Qg
JiYKPiArCQkgICAgbGFzdF9kb21haW4gPT0gKGRtYV9hZGRyW2kgKyAxXSAmIFNWTV9SQU5HRV9W
UkFNX0RPTUFJTikpCj4gKwkJCWNvbnRpbnVlOwo+ICAKPiAtCXIgPSBhbWRncHVfdm1fYm9fdXBk
YXRlX21hcHBpbmcoYWRldiwgYm9fYWRldiwgdm0sIGZhbHNlLCBmYWxzZSwgTlVMTCwKPiAtCQkJ
CQlwcmFuZ2UtPm1hcHBpbmcuc3RhcnQsCj4gLQkJCQkJcHJhbmdlLT5tYXBwaW5nLmxhc3QsIHB0
ZV9mbGFncywKPiAtCQkJCQlwcmFuZ2UtPm1hcHBpbmcub2Zmc2V0LAo+IC0JCQkJCXByYW5nZS0+
dHRtX3JlcyA/Cj4gLQkJCQkJCXByYW5nZS0+dHRtX3Jlcy0+bW1fbm9kZSA6IE5VTEwsCj4gLQkJ
CQkJZG1hX2FkZHIsICZ2bS0+bGFzdF91cGRhdGUpOwo+IC0JaWYgKHIpIHsKPiAtCQlwcl9kZWJ1
ZygiZmFpbGVkICVkIHRvIG1hcCB0byBncHUgMHglbHhcbiIsIHIsIHByYW5nZS0+c3RhcnQpOwo+
IC0JCWdvdG8gb3V0Owo+ICsJCXByX2RlYnVnKCJNYXBwaW5nIHJhbmdlIFsweCVseCAweCVsbHhd
IG9uIGRvbWFpbjogJXNcbiIsCj4gKwkJCSBsYXN0X3N0YXJ0LCBwcmFuZ2UtPnN0YXJ0ICsgaSwg
bGFzdF9kb21haW4gPyAiR1BVIiA6ICJDUFUiKTsKPiArCQl0dG1fcmVzID0gbGFzdF9kb21haW4g
PyBwcmFuZ2UtPnR0bV9yZXMgOiBOVUxMOwo+ICsJCXB0ZV9mbGFncyA9IHN2bV9yYW5nZV9nZXRf
cHRlX2ZsYWdzKGFkZXYsIHByYW5nZSk7Cj4gKwkJciA9IGFtZGdwdV92bV9ib191cGRhdGVfbWFw
cGluZyhhZGV2LCBib19hZGV2LCB2bSwgZmFsc2UsIGZhbHNlLCBOVUxMLAo+ICsJCQkJCQlsYXN0
X3N0YXJ0LAo+ICsJCQkJCQlwcmFuZ2UtPnN0YXJ0ICsgaSwgcHRlX2ZsYWdzLAo+ICsJCQkJCQlw
cmFuZ2UtPm9mZnNldCArCj4gKwkJCQkJCSgobGFzdF9zdGFydCAtIHByYW5nZS0+c3RhcnQpIDw8
IFBBR0VfU0hJRlQpLAo+ICsJCQkJCQl0dG1fcmVzID8gdHRtX3Jlcy0+bW1fbm9kZSA6IE5VTEws
Cj4gKwkJCQkJCXR0bV9yZXMgPyBOVUxMIDogZG1hX2FkZHIsCj4gKwkJCQkJCSZ2bS0+bGFzdF91
cGRhdGUpOwo+ICsJCWlmIChyKSB7Cj4gKwkJCXByX2RlYnVnKCJmYWlsZWQgJWQgdG8gbWFwIHRv
IGdwdSAweCVseFxuIiwgciwgcHJhbmdlLT5zdGFydCk7Cj4gKwkJCWdvdG8gb3V0Owo+ICsJCX0K
PiArCQlsYXN0X3N0YXJ0ICs9IHByYW5nZS0+c3RhcnQgKyBpICsgMTsKClRoaXMgbG9va3Mgd3Jv
bmcuIEl0J3MgZWl0aGVyCgrCoMKgwqAgbGFzdF9zdGFydCArPSBpICsgMTsKCm9yCgrCoMKgwqAg
bGFzdF9zdGFydCA9IHByYW5nZS0+c3RhcnQgKyBpICsgMTsKCldpdGggdGhhdCBmaXhlZCwgdGhl
IHNlcmllcyBpcwpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFt
ZC5jb20+CgoKPiAgCX0KPiAgCj4gIAlyID0gYW1kZ3B1X3ZtX3VwZGF0ZV9wZGVzKGFkZXYsIHZt
LCBmYWxzZSk7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9z
dm0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uaAo+IGluZGV4IDA4NTQy
ZmUzOTMwMy4uZTY4YWE1MTMyMmRmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9zdm0uaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9z
dm0uaAo+IEBAIC0zNSw2ICszNSw3IEBACj4gICNpbmNsdWRlICJhbWRncHUuaCIKPiAgI2luY2x1
ZGUgImtmZF9wcml2LmgiCj4gIAo+ICsjZGVmaW5lIFNWTV9SQU5HRV9WUkFNX0RPTUFJTiAoMVVM
IDw8IDApCj4gICNkZWZpbmUgU1ZNX0FERVZfUEdNQVBfT1dORVIoYWRldilcCj4gIAkJCSgoYWRl
diktPmhpdmUgPyAodm9pZCAqKShhZGV2KS0+aGl2ZSA6ICh2b2lkICopKGFkZXYpKQo+ICAKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
