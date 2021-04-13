Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD59DC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 18:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7E2613B1
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 18:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7E2613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C98E8991D;
	Tue, 13 Apr 2021 18:18:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DADB8991D
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 18:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrBSFHuHpxK/W0XTSGc88wUO4mxgRuXnhlL3IydlhcKP0cZu5Ek4aLRInFpY439Cj9VKd+UBvtp+rQw6zrTo7mUEBdYzMDT/OSJc/30ziOtnrXw8JfncTYfbLkZH/Sb/EzFg3A3xaqbzh9Xh/dkFdu6REeZhjaGnXMPdWcAkuOvssJ4iy5f0LRExJx2W3DTX2VtgdRhoTzL3N9evG38sIJkhQ2MCuoGH8EbjdGDUM5IHJxZ7i1jkqdufTF/QSx6wc5UPICg11ty9nZTbsjfPqEuXmntNxQ/kqdPZruuslma66RfhimZoLB5970L6jit4kgQP1sWmEp72/Ofn47aZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVHGUnbfWPpJ8gBTl3PprVBdvktrzE4jrRmqMYJVg3A=;
 b=kti3Lo/FJSWCAziNYxohm5hP44FLTqomkoftRJPSksV4EIGwi0g/S5dCuhF1mMKyRBGpBRcTah3U4xC1YAIW2mK1hYjLBIF8wZGUcRv+vHQ85Afvw8HKm+Y5oo/cLpUl/eqDnz5RbBBQjfeeM6YRB1vnVkctZ1nkty0fHBULCpioCOHF/luNcluI3M/R70MpC0uuYGdGz6xRsAdzXydYmd2CMYMHVp0M0+RY0hugLD8NqnC5Xug2DPiBDw0I6PEn6TpGdlA4AgeM0oDjIeBqPRHbFsUBgcnPzAGpztaO5u2eRnyK2sY7egtdnHbITOWiksYQF4HeFsP0Qcf1uSCL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVHGUnbfWPpJ8gBTl3PprVBdvktrzE4jrRmqMYJVg3A=;
 b=ARB+Ma6OUBwMm6zZ5tRU8KKLQKNl0V4rR5VhI8S3oYhxYWcn/kKvOymNe3ge55wWJMbHXHEH3i2VFy5+lLGMaUwfuqomRjN+SJZpfqq7Zpjnb0asMdcqjyJ7UOiusEkZAF0GEkD2VOVCDQsnyfcg9OT+v5JV5240iqL5z755liM=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 18:18:26 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 18:18:26 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
 <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
 <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
 <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
 <0224d3c2-1bd0-3941-fa7f-5667027368fa@amd.com>
 <a92e8f96-029f-6d21-4430-7e3116c21dea@amd.com>
 <9ea8f0c1-8d58-f4ab-e2a9-1ef8fd00718c@amd.com>
 <9b9e84ca-b259-b683-ef9d-1f9be95e1734@gmail.com>
 <ae02bdf3-8f4b-ed38-b62d-c3b606554a59@amd.com>
 <8b2db19a-d5f9-a7e3-6662-b990b7b3db2f@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <0fe87232-08ec-d804-ff55-2716b8e09c12@amd.com>
Date: Tue, 13 Apr 2021 14:18:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <8b2db19a-d5f9-a7e3-6662-b990b7b3db2f@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:9da9:a38:3558:d1d1]
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:9da9:a38:3558:d1d1]
 (2607:fea8:3edf:49b0:9da9:a38:3558:d1d1) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.22 via Frontend Transport; Tue, 13 Apr 2021 18:18:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65dc521f-1dd0-48b4-f2cf-08d8fea887e6
X-MS-TrafficTypeDiagnostic: SA0PR12MB4398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4398B1C3B602593C1D516285EA4F9@SA0PR12MB4398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRHegqPr/BaeBW00EEyvjTh0ttWh9g3FM1uF3D/1cu1nKvC3NSa51XcOMYMsbC8kAH7I/+zI+awahg1nw03d/bOize2OXwVnJUoC9KOO+nfkN2o+z7ix/IPeLCBPeboUEQULaaH2CPO2J22IUcVWloW3esbuuGT67iCkNnlAn9CmYDpgAKk64ACLN0stewx6qjaJcqRi7FkY1NZ/bJaHLNn9Nc+0rC+FfghSMvsFgMSOehRaHXxwazriGP4ToKv+NGrgVmEBSxHe9FIPNaJ2fSXhrrihRo/sbq2bcwBbdbs9bfydjVFvxfNEN0DHveh9y7zItYGOzqUdQhht4Kn4uyXmuj6u6DYJxErwwOxhpWAOgC848oUQrxHohY4S48I0OBMQ5xdKEVhJcOc8+NugjN2RlucFs59f2TGiEOlEiwMh9DSZWZTOxOIdHpTMt6VkNNSwrfCJJSslfdZvbYzJAf6GPBVglRoKDRgooRn2nMVAKjZBcZtWCLI/LQippZQ+tvtX3rG1bTqpOUY1poJqXQdonyvKppGFmWbUL1AdWcijnWzsQifej+V54/A059ybZ5ArkrvE+P36EkMwJhmOqVY/NfCHDFM2BaYjD0RbOVPSC9Kf+0Ugen+JfIatdPuvtPbdZlQ0PqZcrqpJX/5fOUk3C49WqQ3bN0lbP50spzvaTmyrzzBcATmLhdzop5q8sDIiUSqAnWSt6zzUHj41dMttcNzf3ct4okGVu+aPPtLqvMAKAwB3stGc2XrOafqizFMxGbrcvGCMdWHnRewM9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(31696002)(86362001)(44832011)(2616005)(921005)(45080400002)(966005)(36756003)(110136005)(38100700002)(83380400001)(16526019)(5660300002)(8936002)(66574015)(53546011)(186003)(66476007)(31686004)(66946007)(478600001)(6486002)(316002)(66556008)(52116002)(2906002)(8676002)(60764002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b3l2eUdWTVRnR214UzMxbVZYTFdTajE0SForblJkbmpLRTBuU1l5MTVHalEw?=
 =?utf-8?B?aTd6VWFZMkF5TFMrTnNGOEtHWm83U0UvOThHUFJ2anNCNi9nZWtaNzJ2bU9w?=
 =?utf-8?B?eDFIM0thNnFBRDR4Vy9MRnlVd1docWFXZ1hFbC9VNjliUXYxYUFiaXZQdWVN?=
 =?utf-8?B?TldZQWJlZmN2VVRwbndrWUNWc2NNZTBvNC9ZbStkRWFwVWRDdHJlRTFiY0s1?=
 =?utf-8?B?MGFQT2RvL3NJV0J1cTcyQnZFTXFJS2w0RFhiWVFpb0NPK2g0NmtNa2ZkRjNv?=
 =?utf-8?B?R0tlWldBVXVZa1NRRnAwbTFIVDNETW43TXZhaXNWakJJS0dSVFQ5SmU4dGs1?=
 =?utf-8?B?RlRjNzV1MXE2bVJOSUQ5ZTVBQm5rNU5oUWdpKy9kQTRHbWxnTUxUK0tkQ3lh?=
 =?utf-8?B?ZExyZUZ1RkQwaysrYmVhc3Q5N044WE9HMFc2RCtSY3kzd3QxUDdqWlZZRkEw?=
 =?utf-8?B?R1Q2QkJhczNMM3VEK2xaaVVLNEVNZHAxbHVzckg0akNNOUxkTmhhMmNLZi9L?=
 =?utf-8?B?ZGdHTmVYZngwb0NHOFJlM3RhTG0vdVc5VVRFQUtLQjVkaVFmMDZkTjdDcnRq?=
 =?utf-8?B?Qy95K3Z1SEgvL1ZYN2QxWXlJa2gycTc1WG82M1l2TnRMeG5pZmIxbFJqb0Fp?=
 =?utf-8?B?bXdPWEk0bEQwS1loOWYvN1pEOGJoYTdqaDI2M2MwcmFGNmlXWjhEdGVZcnRY?=
 =?utf-8?B?QVc2MUtDQ0RGd0kvc0IxdjdSOUZUamJWclEzcmRCQW4yWWs5MmRjcmNlUkNO?=
 =?utf-8?B?bkFoTEc2cHVpa3dsN1p3dHlWZ2NuYVRxRndvL3FjMDk4VUlWL0U4VkxKZnl5?=
 =?utf-8?B?dEtsSjdMai9MT2wvbzVta1M4WlpWamtwMnpsUkIxc3Mwd2U4K0kvcHVXZEla?=
 =?utf-8?B?d25aZWwyTDNaV3RwdDVRU25ubVRjeEp5WEVCM0pmTjY0emZrc1RHMlFINWk2?=
 =?utf-8?B?OHJ0bW02STlKaGlKb05zODduaTVXU21NVklBRHlpSWNmdnUyRS9iNU4xWDB0?=
 =?utf-8?B?RnNWL1dSemcrbzBmMUhQYzdaZVNhZHpSUEIreEJ6eWJ0aWN4UEZRL3poZ2Ns?=
 =?utf-8?B?ZXZTaGhSeWduQXFRUGdDOUY2dHJrYmFLNW0zdi9uMENkeE1KMktIckdEbkRU?=
 =?utf-8?B?RGl2azdJT3RLS2Y4cDdlc214VGs2bHFkOEoyOHRwbHlnazBhOXB1dHhMYXZT?=
 =?utf-8?B?MVhMS1NNMzdWcWtCcndQRytwNzRzNWJJamdoQ3M4bGtMQy91S3J1ZVl0QWlx?=
 =?utf-8?B?SDJHWWVEVFQ4ZnFtZjgwRDc5bHZKaVY1azVnWHFCZkJ2SDYrdFZvenlla1Jz?=
 =?utf-8?B?MW5nSmhiSE5Pdm83WUdjL012Z2dtdWNxSnhhSmphMVdBeWE3S3grYkNodnJY?=
 =?utf-8?B?dTNjdE1GN0xDdjQrZjlaM2VmOC9Tbnk4dmhvV2QzTmFlQjQvYWhMcEowNXUy?=
 =?utf-8?B?RjNsSnI1L21jdTRIdnNOTGRKdVNPbDV3V005WXBlNnZqZHJHM241b0Z6N0Rq?=
 =?utf-8?B?YTNYRzQrUk1ieWJnWnlNU3FmT0ozVGErclV6ckJodUVJY0d4bHBaZmJTNTFU?=
 =?utf-8?B?WndqcGlZYUlHdndmWGxIeW1tTmp0TlV6R08xSVgrQ3pCb2I2dCtqeWdaakRC?=
 =?utf-8?B?akdTdmwrSTROWEtGbW9uaHJHdXFOWU5VRVJ0RG5yRzNpUnVwaVJRQzNtbEJY?=
 =?utf-8?B?U2lIOXlRa0w2MHh1Vk9Lc0JQUjk0U1AzejBISGd0UXB1QU1oRVRiU2VZQVhy?=
 =?utf-8?B?RHMyVXlwWFZ2MXcybXB3cHVXbzhRby9NSE1QalNrK0VCRk5DRG1iRzZpb2JD?=
 =?utf-8?B?TmR0RGEybWF3eUxoL2E0NDl2SXdEV0JvUXJwb1FneW9MRjNkT1hzdlkycXlL?=
 =?utf-8?Q?cCTbQwmk5ASE0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dc521f-1dd0-48b4-f2cf-08d8fea887e6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 18:18:26.3194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIXC0WA5ClTyCkw1VJ0DHnxcWeNBItQ5RI58pdDgHo3HDknmZbtEABqDKUsF2yRWgxPm4Vmep3+kLEKoccNVMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjEtMDQtMTMgMjowMyBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDEz
LjA0LjIxIHVtIDE3OjEyIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Cj4+IE9uIDIwMjEt
MDQtMTMgMzoxMCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMTIuMDQuMjEg
dW0gMjI6MDEgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+Pgo+Pj4+IE9uIDIwMjEtMDQt
MTIgMzoxOCBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+PiBBbSAxMi4wNC4yMSB1
bSAyMToxMiBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4+Pj4gW1NOSVBdCj4+Pj4+Pj4+
Cj4+Pj4+Pj4+IFNvIHdoYXQncyB0aGUgcmlnaHQgYXBwcm9hY2ggPyBIb3cgd2UgZ3VhcmFudGVl
IHRoYXQgd2hlbiAKPj4+Pj4+Pj4gcnVubmluZyBhbWRncHVfZmVuY2VfZHJpdmVyX2ZvcmNlX2Nv
bXBsZXRpb24gd2Ugd2lsbCBzaWduYWwgYWxsIAo+Pj4+Pj4+PiB0aGUgSFcgZmVuY2VzIGFuZCBu
b3QgcmFjaW5nIGFnYWluc3Qgc29tZSBtb3JlIGZlbmNlcyBpbnNlcnRpb24gCj4+Pj4+Pj4+IGlu
dG8gdGhhdCBhcnJheSA/Cj4+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+PiBXZWxsIEkgd291bGQgc3Rp
bGwgc2F5IHRoZSBiZXN0IGFwcHJvYWNoIHdvdWxkIGJlIHRvIGluc2VydCB0aGlzIAo+Pj4+Pj4+
IGJldHdlZW4gdGhlIGZyb250IGVuZCBhbmQgdGhlIGJhY2tlbmQgYW5kIG5vdCByZWx5IG9uIHNp
Z25hbGluZyAKPj4+Pj4+PiBmZW5jZXMgd2hpbGUgaG9sZGluZyB0aGUgZGV2aWNlIHNyY3UuCj4+
Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IE15IHF1ZXN0aW9uIGlzLCBldmVuIG5vdywgd2hlbiB3ZSBydW4g
Cj4+Pj4+PiBhbWRncHVfZmVuY2VfZHJpdmVyX2ZpbmlfaHctPmFtZGdwdV9mZW5jZV93YWl0X2Vt
cHR5IG9yIAo+Pj4+Pj4gYW1kZ3B1X2ZlbmNlX2RyaXZlcl9maW5pX2h3LT5hbWRncHVfZmVuY2Vf
ZHJpdmVyX2ZvcmNlX2NvbXBsZXRpb24sIAo+Pj4+Pj4gd2hhdCB0aGVyZSBwcmV2ZW50cyBhIHJh
Y2Ugd2l0aCBhbm90aGVyIGZlbmNlIGJlaW5nIGF0IHRoZSBzYW1lIAo+Pj4+Pj4gdGltZSBlbWl0
dGVkIGFuZCBpbnNlcnRlZCBpbnRvIHRoZSBmZW5jZSBhcnJheSA/IExvb2tzIGxpa2Ugbm90aGlu
Zy4KPj4+Pj4+Cj4+Pj4+Cj4+Pj4+IEVhY2ggcmluZyBjYW4gb25seSBiZSB1c2VkIGJ5IG9uZSB0
aHJlYWQgYXQgdGhlIHNhbWUgdGltZSwgdGhpcyAKPj4+Pj4gaW5jbHVkZXMgZW1pdHRpbmcgZmVu
Y2VzIGFzIHdlbGwgYXMgb3RoZXIgc3R1ZmYuCj4+Pj4+Cj4+Pj4+IER1cmluZyBHUFUgcmVzZXQg
d2UgbWFrZSBzdXJlIG5vYm9keSB3cml0ZXMgdG8gdGhlIHJpbmdzIGJ5IAo+Pj4+PiBzdG9wcGlu
ZyB0aGUgc2NoZWR1bGVyIGFuZCB0YWtpbmcgdGhlIEdQVSByZXNldCBsb2NrIChzbyB0aGF0IAo+
Pj4+PiBub2JvZHkgZWxzZSBjYW4gc3RhcnQgdGhlIHNjaGVkdWxlciBhZ2FpbikuCj4+Pj4KPj4+
Pgo+Pj4+IFdoYXQgYWJvdXQgZGlyZWN0IHN1Ym1pc3Npb25zIG5vdCB0aHJvdWdoIHNjaGVkdWxl
ciAtIAo+Pj4+IGFtZGdwdV9qb2Jfc3VibWl0X2RpcmVjdCwgSSBkb24ndCBzZWUgaG93IHRoaXMg
aXMgcHJvdGVjdGVkLgo+Pj4KPj4+IFRob3NlIG9ubHkgaGFwcGVuIGR1cmluZyBzdGFydHVwIGFu
ZCBHUFUgcmVzZXQuCj4+Cj4+Cj4+IE9rLCBidXQgdGhlbiBsb29rcyBsaWtlIEkgYW0gbWlzc2lu
ZyBzb21ldGhpbmcsIHNlZSB0aGUgZm9sbG93aW5nIAo+PiBzdGVwcyBpbiBhbWRncHVfcGNpX3Jl
bW92ZSAtCj4+Cj4+IDEpIFVzZSBkaXNhYmxlX2lycSBBUEkgZnVuY3Rpb24gdG8gc3RvcCBhbmQg
Zmx1c2ggYWxsIGluIGZsaWdodCBIVyAKPj4gaW50ZXJydXB0cyBoYW5kbGVycwo+Pgo+PiAyKSBH
cmFiIHRoZSByZXNldCBsb2NrIGFuZCBzdG9wIGFsbCB0aGUgc2NoZWR1bGVycwo+Pgo+PiBBZnRl
ciBhYm92ZSAyIHN0ZXBzIHRoZSBIVyBmZW5jZXMgYXJyYXkgaXMgaWRsZSwgbm8gbW9yZSBpbnNl
cnRpb25zIAo+PiBhbmQgbm8gbW9yZSBleHRyYWN0aW9ucyBmcm9tIHRoZSBhcnJheQo+Pgo+PiAz
KSBSdW4gb25lIHRpbWUgYW1kZ3B1X2ZlbmNlX3Byb2Nlc3MgdG8gc2lnbmFsIGFsbCBjdXJyZW50
IEhXIGZlbmNlcwo+Pgo+PiA0KSBTZXQgZHJtX2Rldl91bnBsdWcgKHdpbGwgJ2ZsdXNoJyBhbGwg
aW4gZmxpZ2h0IElPQ1RMcyksIHJlbGVhc2UgCj4+IHRoZSBHUFUgcmVzZXQgbG9jayBhbmQgZ28g
b24gd2l0aCB0aGUgcmVzdCBvZiB0aGUgc2VxdWVuY2UgKGNhbmNlbCAKPj4gdGltZXJzLCB3b3Jr
IGl0ZW1zIGUudC5jKQo+Pgo+PiBXaGF0J3MgcHJvYmxlbWF0aWMgaW4gdGhpcyBzZXF1ZW5jZSA/
Cj4KPiBkcm1fZGV2X3VucGx1ZygpIHdpbGwgd2FpdCBmb3IgdGhlIElPQ1RMcyB0byBmaW5pc2gu
Cj4KPiBUaGUgSU9DVExzIGluIHR1cm4gY2FuIHdhaXQgZm9yIGZlbmNlcy4gVGhhdCBjYW4gYmUg
Ym90aCBoYXJkd2FyZSAKPiBmZW5jZXMsIHNjaGVkdWxlciBmZW5jZXMsIGFzIHdlbGwgYXMgZmVu
Y2VzIGZyb20gb3RoZXIgZGV2aWNlcyAoYW5kIAo+IEtJUSBmZW5jZXMgZm9yIHJlZ2lzdGVyIHdy
aXRlcyB1bmRlciBTUklPViwgYnV0IHdlIGNhbiBob3BlZnVsbHkgCj4gaWdub3JlIHRoZW0gZm9y
IG5vdykuCj4KPiBXZSBoYXZlIGhhbmRsZWQgdGhlIGhhcmR3YXJlIGZlbmNlcywgYnV0IHdlIGhh
dmUgbm8gaWRlYSB3aGVuIHRoZSAKPiBzY2hlZHVsZXIgZmVuY2VzIG9yIHRoZSBmZW5jZXMgZnJv
bSBvdGhlciBkZXZpY2VzIHdpbGwgc2lnbmFsLgo+Cj4gU2NoZWR1bGVyIGZlbmNlcyB3b24ndCBz
aWduYWwgdW50aWwgdGhlIHNjaGVkdWxlciB0aHJlYWRzIGFyZSAKPiByZXN0YXJ0ZWQgb3Igd2Ug
c29tZWhvdyBjYW5jZWwgdGhlIHN1Ym1pc3Npb25zLiBEb2FibGUsIGJ1dCB0cmlja3kgYXMgCj4g
d2VsbC4KCgpGb3Igc2NoZWR1bGVyIGZlbmNlcyBJIGFtIG5vdCB3b3JyaWVkLCBmb3IgdGhlIHNj
aGVkX2ZlbmNlLT5maW5pc2hlZCAKZmVuY2UgdGhleSBhcmUgYnkgZGVmaW5pdGlvbiBhdHRhY2hl
ZCB0byBIVyBmZW5jZXMgd2hpY2ggYWxyZWFkeSAKc2lnbmFsZWQsZm9yIHNjaGVkX2ZlbmNlLT5z
Y2hlZHVsZWQgd2Ugc2hvdWxkIHJ1biAKZHJtX3NjaGVkX2VudGl0eV9raWxsX2pvYnMgZm9yIGVh
Y2ggZW50aXR5IGFmdGVyIHN0b3BwaW5nIHRoZSBzY2hlZHVsZXIgCnRocmVhZHMgYW5kIGJlZm9y
ZSBzZXR0aW5nIGRybV9kZXZfdW5wbHVnLgoKCj4KPiBGb3Igd2FpdGluZyBmb3Igb3RoZXIgZGV2
aWNlIEkgaGF2ZSBubyBpZGVhIGlmIHRoYXQgY291bGRuJ3QgZGVhZGxvY2sgCj4gc29tZWhvdy4K
CgpZZWEsIG5vdCBzdXJlIGZvciBpbXBvcnRlZCBmZW5jZXMgYW5kIGRtYV9idWZzLCBJIHdvdWxk
IGFzc3VtZSB0aGUgb3RoZXIgCmRldmljZXMgc2hvdWxkIG5vdCBiZSBpbXBhY3RlZCBieSBvdXIg
ZGV2aWNlIHJlbW92YWwgYnV0LCB3aG8ga25vd3MuLi4KClNvIEkgZ3Vlc3Mgd2UgYXJlIE5PVCBn
b2luZyB3aXRoIGZpbmFsaXppbmcgSFcgZmVuY2VzIGJlZm9yZSAKZHJtX2Rldl91bnBsdWcgYW5k
IGluc3RlYWQgd2lsbCBqdXN0IGNhbGwgZHJtX2Rldl9lbnRlci9leGl0IGF0IHRoZSAKYmFjay1l
bmRzIGFsbCBvdmVyIHRoZSBwbGFjZSB3aGVyZSB0aGVyZSBhcmUgTU1JTyBhY2Nlc3NlcyA/CgpB
bmRyZXkKCj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4KPgo+Pgo+PiBBbmRyZXkKPj4KPj4KPj4+
Cj4+Pgo+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4gQlRXOiBDb3VsZCBpdCBiZSB0aGF0IHRoZSBkZXZp
Y2UgU1JDVSBwcm90ZWN0cyBtb3JlIHRoYW4gb25lIAo+Pj4+Pj4+IGRldmljZSBhbmQgd2UgZGVh
ZGxvY2sgYmVjYXVzZSBvZiB0aGlzPwo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+PiBJIGhhdmVuJ3QgYWN0
dWFsbHkgZXhwZXJpZW5jZWQgYW55IGRlYWRsb2NrIHVudGlsIG5vdyBidXQsIHllcywgCj4+Pj4+
PiBkcm1fdW5wbHVnX3NyY3UgaXMgZGVmaW5lZCBhcyBzdGF0aWMgaW4gZHJtX2Rydi5jIGFuZCBz
byBpbiB0aGUgCj4+Pj4+PiBwcmVzZW5jZcKgIG9mIG11bHRpcGxlIGRldmljZXMgZnJvbSBzYW1l
IG9yIGRpZmZlcmVudCBkcml2ZXJzIHdlIAo+Pj4+Pj4gaW4gZmFjdCBhcmUgZGVwZW5kZW50IG9u
IGFsbCB0aGVpciBjcml0aWNhbCBzZWN0aW9ucyBpIGd1ZXNzLgo+Pj4+Pj4KPj4+Pj4KPj4+Pj4g
U2hpdCwgeWVhaCB0aGUgZGV2aWwgaXMgYSBzcXVpcnJlbC4gU28gZm9yIEErSSBsYXB0b3BzIHdl
IGFjdHVhbGx5IAo+Pj4+PiBuZWVkIHRvIHN5bmMgdGhhdCB1cCB3aXRoIERhbmllbCBhbmQgdGhl
IHJlc3Qgb2YgdGhlIGk5MTUgZ3V5cy4KPj4+Pj4KPj4+Pj4gSUlSQyB3ZSBjb3VsZCBhY3R1YWxs
eSBoYXZlIGFuIGFtZGdwdSBkZXZpY2UgaW4gYSBkb2NraW5nIHN0YXRpb24gCj4+Pj4+IHdoaWNo
IG5lZWRzIGhvdHBsdWcgYW5kIHRoZSBkcml2ZXIgbWlnaHQgZGVwZW5kIG9uIHdhaXRpbmcgZm9y
IHRoZSAKPj4+Pj4gaTkxNSBkcml2ZXIgYXMgd2VsbC4KPj4+Pgo+Pj4+Cj4+Pj4gQ2FuJ3Qgd2Ug
cHJvcG9zZSBhIHBhdGNoIHRvIG1ha2UgZHJtX3VucGx1Z19zcmN1IHBlciBkcm1fZGV2aWNlID8g
SSAKPj4+PiBkb24ndCBzZWUgd2h5IGl0IGhhcyB0byBiZSBnbG9iYWwgYW5kIG5vdCBwZXIgZGV2
aWNlIHRoaW5nLgo+Pj4KPj4+IEknbSByZWFsbHkgd29uZGVyaW5nIHRoZSBzYW1lIHRoaW5nIGZv
ciBxdWl0ZSBhIHdoaWxlIG5vdy4KPj4+Cj4+PiBBZGRpbmcgRGFuaWVsIGFzIHdlbGwsIG1heWJl
IGhlIGtub3dzIHdoeSB0aGUgZHJtX3VucGx1Z19zcmN1IGlzIAo+Pj4gZ2xvYmFsLgo+Pj4KPj4+
IFJlZ2FyZHMsCj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4+Cj4+Pj4gQW5kcmV5Cj4+Pj4KPj4+Pgo+
Pj4+Pgo+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Cj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Cj4+Pj4+Pgo+
Pj4+Pj4+Cj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Cj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+
Pgo+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4+IMKgwqDCoCAvKiBQYXN0IHRoaXMgcG9pbnQgbm8gbW9yZSBmZW5jZSBhcmUgc3VibWl0
dGVkIHRvIEhXIAo+Pj4+Pj4+Pj4+Pj4gcmluZyBhbmQgaGVuY2Ugd2UgY2FuIHNhZmVseSBjYWxs
IGZvcmNlIHNpZ25hbCBvbiBhbGwgdGhhdCAKPj4+Pj4+Pj4+Pj4+IGFyZSBjdXJyZW50bHkgdGhl
cmUuCj4+Pj4+Pj4+Pj4+PiDCoMKgwqDCoCAqIEFueSBzdWJzZXF1ZW50bHkgY3JlYXRlZMKgIEhX
IGZlbmNlcyB3aWxsIGJlIHJldHVybmVkIAo+Pj4+Pj4+Pj4+Pj4gc2lnbmFsZWQgd2l0aCBhbiBl
cnJvciBjb2RlIHJpZ2h0IGF3YXkKPj4+Pj4+Pj4+Pj4+IMKgwqDCoMKgICovCj4+Pj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIGZvcl9lYWNoX3JpbmcoYWRldikKPj4+Pj4+Pj4+Pj4+IMKg
wqDCoCDCoMKgwqAgYW1kZ3B1X2ZlbmNlX3Byb2Nlc3MocmluZykKPj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+PiDCoMKgwqAgZHJtX2Rldl91bnBsdWcoZGV2KTsKPj4+Pj4+Pj4+Pj4+IMKgwqDCoCBT
dG9wIHNjaGVkdWxlcnMKPj4+Pj4+Pj4+Pj4+IMKgwqDCoCBjYW5jZWxfc3luYyhhbGwgdGltZXJz
IGFuZCBxdWV1ZWQgd29ya3MpOwo+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIGh3X2ZpbmkKPj4+Pj4+Pj4+
Pj4+IMKgwqDCoCB1bm1hcF9tbWlvCj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4gfQo+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4gQWx0ZXJuYXRpdmVseSBncmFiYmluZyB0aGUg
cmVzZXQgd3JpdGUgc2lkZSBhbmQgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHN0b3BwaW5nIGFuZCB0aGVu
IHJlc3RhcnRpbmcgdGhlIHNjaGVkdWxlciBjb3VsZCB3b3JrIAo+Pj4+Pj4+Pj4+Pj4+Pj4+PiBh
cyB3ZWxsLgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+
Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+IEkgZGlkbid0
IGdldCB0aGUgYWJvdmUgYW5kIEkgZG9uJ3Qgc2VlIHdoeSBJIG5lZWQgdG8gCj4+Pj4+Pj4+Pj4+
Pj4+Pj4gcmV1c2UgdGhlIEdQVSByZXNldCByd19sb2NrLiBJIHJlbHkgb24gdGhlIFNSQ1UgdW5w
bHVnIAo+Pj4+Pj4+Pj4+Pj4+Pj4+IGZsYWcgZm9yIHVucGx1Zy4gQWxzbywgbm90IGNsZWFyIHRv
IG1lIHdoeSBhcmUgd2UgCj4+Pj4+Pj4+Pj4+Pj4+Pj4gZm9jdXNpbmcgb24gdGhlIHNjaGVkdWxl
ciB0aHJlYWRzLCBhbnkgY29kZSBwYXRjaCB0byAKPj4+Pj4+Pj4+Pj4+Pj4+PiBnZW5lcmF0ZSBI
VyBmZW5jZXMgc2hvdWxkIGJlIGNvdmVyZWQsIHNvIGFueSBjb2RlIAo+Pj4+Pj4+Pj4+Pj4+Pj4+
IGxlYWRpbmcgdG8gYW1kZ3B1X2ZlbmNlX2VtaXQgbmVlZHMgdG8gYmUgdGFrZW4gaW50byAKPj4+
Pj4+Pj4+Pj4+Pj4+PiBhY2NvdW50IHN1Y2ggYXMsIGRpcmVjdCBJQiBzdWJtaXNzaW9ucywgVk0g
Zmx1c2hlcyBlLnQuYwo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+IFlvdSBuZWVkIHRv
IHdvcmsgdG9nZXRoZXIgd2l0aCB0aGUgcmVzZXQgbG9jayBhbnl3YXksIAo+Pj4+Pj4+Pj4+Pj4+
Pj4gY2F1c2UgYSBob3RwbHVnIGNvdWxkIHJ1biBhdCB0aGUgc2FtZSB0aW1lIGFzIGEgcmVzZXQu
Cj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+IEZvciBnb2luZyBt
eSB3YXkgaW5kZWVkIG5vdyBJIHNlZSBub3cgdGhhdCBJIGhhdmUgdG8gdGFrZSAKPj4+Pj4+Pj4+
Pj4+Pj4gcmVzZXQgd3JpdGUgc2lkZSBsb2NrIGR1cmluZyBIVyBmZW5jZXMgc2lnbmFsbGluZyBp
biAKPj4+Pj4+Pj4+Pj4+Pj4gb3JkZXIgdG8gcHJvdGVjdCBhZ2FpbnN0IHNjaGVkdWxlci9IVyBm
ZW5jZXMgZGV0YWNobWVudCAKPj4+Pj4+Pj4+Pj4+Pj4gYW5kIHJlYXR0YWNobWVudCBkdXJpbmcg
c2NoZWR1bGVycyBzdG9wL3Jlc3RhcnQuIEJ1dCBpZiAKPj4+Pj4+Pj4+Pj4+Pj4gd2UgZ28gd2l0
aCB5b3VyIGFwcHJvYWNowqAgdGhlbiBjYWxsaW5nIGRybV9kZXZfdW5wbHVnIGFuZCAKPj4+Pj4+
Pj4+Pj4+Pj4gc2NvcGluZyBhbWRncHVfam9iX3RpbWVvdXQgd2l0aCBkcm1fZGV2X2VudGVyL2V4
aXQgc2hvdWxkIAo+Pj4+Pj4+Pj4+Pj4+PiBiZSBlbm91Z2ggdG8gcHJldmVudCBhbnkgY29uY3Vy
cmVudCBHUFUgcmVzZXRzIGR1cmluZyAKPj4+Pj4+Pj4+Pj4+Pj4gdW5wbHVnLiBJbiBmYWN0IEkg
YWxyZWFkeSBkbyBpdCBhbnl3YXkgLSAKPj4+Pj4+Pj4+Pj4+Pj4gaHR0cHM6Ly9uYW0xMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzOiUyRiUyRmNnaXQuZnJlZWRl
c2t0b3Aub3JnJTJGfmFncm9kem92JTJGbGludXglMkZjb21taXQlMkYlM0ZoJTNEZHJtLW1pc2Mt
bmV4dCUyNmlkJTNEZWYwZWE0ZGQyOWVmNDRkMjY0OWM1ZWRhMTZjOGY0ODY5YWNjMzZiMSZhbXA7
ZGF0YT0wNCU3QzAxJTdDYW5kcmV5Lmdyb2R6b3Zza3klNDBhbWQuY29tJTdDYzdmYzZjYjUwNWMz
NGFlZGZlNmQwOGQ4ZmU0YjM5NDclN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3
QzAlN0MwJTdDNjM3NTM4OTQ2MzI0ODU3MzY5JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJ
am9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1u
MCUzRCU3QzEwMDAmYW1wO3NkYXRhPTY0MzYyUFJDOHhUZ1IyVWoyUjI1NmJNZWdWbThZV3ExS0kl
MkJBanplWVh2NCUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+Pj4+IFllcywgZ29vZCBwb2ludCBhcyB3ZWxsLgo+Pj4+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Cj4+Pj4+Pj4KPj4+Pj4KPj4+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
