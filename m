Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27673C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 01:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720A661414
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 01:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720A661414
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA1236E932;
	Wed, 21 Apr 2021 01:25:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5DF36E932
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 01:25:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUr1r9B6rpfztH5DMr0UB2t9y+yHYtIOYYd3A082aPFNXbvz5zHl+sFOgld/q+1XUt3Dxtez0sF3dr4IKg/kIA9XfMHLaaDPQcPe8PyAo7MxiBHmpdmGP7QaAzm0by9CA9gYqSofe0sJ0pTqHqY7ERYj4zWRZw4H7wzQyxIcjd6t2qXzIYfdeICSeEOfQS+vqGAmCfzaBO0WXtIeUfq293Jl6T1cMkxh5lk/8ynZcyEnizPHaZYp9UFMDBIs937zUL13VE/TBEIDpljUnXOMT+dc+hFDhHuTlCAH/ZEGvKPZP1GkL9x8cfAhStq+pBHbM12EFPZNQnw8Ta1197k/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE5P+t0wo2+Y82nNhPBkFX6GDqhST0tzs8Fe/IIC4DI=;
 b=gtfFAej4YpyvPFw9DBEoqhd/3mGM+yC5Q2WJ7hYqm+xPbBIX72G2QcUhcFb2uI+32PXMWuR/3o5UbukO22OjaMgATMH1vAR8DDiz5sb6aVKJMOo4HSjblj27ND32cygHN19L+Zwx9Jt3MAix9vJzaBLoHh1KPmHa0uwLcleVx02m09gAAmHrNpcX3RFx8hQTEIPLLGXBMfAzzViOw9nH3X7WBiN5zRrDzPvaiALQpZPdmW9UdjAa3HZUFF2/qBMXIu4CnCLxgRCqAavf0Xr20lNJ+P8td2bH4jdh0GOlehXjikwJIZ97RaCpSLBaf8etAq61qPjfsVdyxFzXMRdNzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE5P+t0wo2+Y82nNhPBkFX6GDqhST0tzs8Fe/IIC4DI=;
 b=TOWrY2LYvceaxMx8x8jAW57Mv7X2fmOQqhGuAQf1RSLS8ry/9PShXixI5Uu0dhd0E8cCgJWZiT+6MmI45SO+hyQDkEOKdB5QXmJJqGCKCnGy8M+S53x9RLJqPJcwjivYsPaPUSEBHOK7LJg7Af1Tnhu2j1g0NUtfXePZMxA2okA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4783.namprd12.prod.outlook.com (2603:10b6:208:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 01:25:04 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Wed, 21 Apr 2021
 01:25:04 +0000
Subject: Re: [PATCH] drm/amdkfd: svm ranges creation for unregistered memory
From: Felix Kuehling <felix.kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex Sierra <alex.sierra@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20210420015205.9606-1-alex.sierra@amd.com>
 <803e53c6-7268-5521-fd4f-835da994a07e@amd.com>
Message-ID: <bcd32802-4b03-c7a8-03b6-34e6f3ee0710@amd.com>
Date: Tue, 20 Apr 2021 21:25:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <803e53c6-7268-5521-fd4f-835da994a07e@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.180.233]
X-ClientProxiedBy: YTOPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::41) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.180.233) by
 YTOPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19 via Frontend
 Transport; Wed, 21 Apr 2021 01:25:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33b3ebc6-3fce-4eb2-4352-08d904644aaa
X-MS-TrafficTypeDiagnostic: MN2PR12MB4783:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB478374EFE7E9C021E0EE22C192479@MN2PR12MB4783.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CYwBH6fJ/JmJGJKRsAz4olK43KWj188O2csrlwi32SMRAVdoD4EqLFsjn5IYJ1OWxMDOlIwa8v43m12pm8uLYwX1Z1TFl+bsxAtNfP/0yAdY97cdvB3IpL6n9oanAriaBJ3CUKi6oDCLo8fsnhCNlr6clKkKMRi0JI5CdehwoyNQEQybNzwU0m67cj0a1mTZwBHqq4FYIUBLKBMmBNdTGT6zgUZjUjzLxJ9IsoCzFPDjm+RxazTEvxEJGA5qSb90/vKtOweexWW1yCxhoee71VkmYXTfqWBM6qWCoSY7fYSBWx+GySRiE5NX3Bxokuj82sjpaCNGKWiMUVLbpidoFGJtLZ6wlF8FYzTbN0uE4K7LiwqquUST8GxCOjB0rIZffCYgPSudj744kDv4w9hCYWX5aC61xv1A3IZbnRHQUTrt13vJH72oy93o66ESMpqpkw0Pp8hdWNE7+vGBJ70ZXgpFoUMFQ/Js8ReGNXZL3WEYR/dIYt9PA3ZtO71UiVuEN51V3bW7KPxMQtQDKWuaChp/uOZpVNwNGgiQ2MrPH6B95FSrWUwIBedtZkOjsfeFv7HvppcyFlI69begslXyXHy9zY1+Gf4zCOxpF9Qr/dmmptS7Bpz+PWDO/erWXDR/spLtZ7p5Vs3RCHkClMm8lESjOByb97q65AuLqZC6NAwwT1VAgC/R9UhZr7yttktbfFSiRJfELzI7nuUyYj4jz/hAfSEVWzRopCoTxqwNPFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(2616005)(316002)(66476007)(6486002)(110136005)(16576012)(36756003)(5660300002)(8676002)(66556008)(31696002)(31686004)(2906002)(956004)(478600001)(38100700002)(8936002)(16526019)(6636002)(86362001)(186003)(966005)(44832011)(66946007)(26005)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?czNQdkp1ZzFkVi96dGRUV3JDbmRIMWlmbnNwQkN5VnZUQlp6VEtDL2hnMmo1?=
 =?utf-8?B?N0w2dkI0TG1uTGdWTFlLUjArSTAvczFQbTBTemtxbUtxRTYxd2s5bXArYmVi?=
 =?utf-8?B?eUdqamRSd29ySUdYQzdOQ1FlbmxmUmhXUEhJUW9yR3lzQjVadGdINTkxWE5F?=
 =?utf-8?B?a01iWkdHdEdXZzVDY1BWaGdHMUlrYW1ENHZGQVl3OU1tL292b2V3a280WFc3?=
 =?utf-8?B?ME1wT0JlM3RJUVd2OVhLVHNvSWRRbk13MmswRWdjOVNoOGF5Y1ZIWnBXRG9S?=
 =?utf-8?B?UEk5MC9ZV0YrWUl2TW1QZWpyZjc0OTB2YU9BL1hBaU0wSFp2dnM2eTU3OUQz?=
 =?utf-8?B?Rm0xSjJuYjJRWjBYRUNVZE8yR1ZaMjBoSG44MVNFOSs1d3F4eDRaM0dsUmxr?=
 =?utf-8?B?OFJEd1c3ZUNVQmw0U0VCdWR6bmIxRUM3dzN5UlVsSjB6YW1xVFNsb2w4Slg0?=
 =?utf-8?B?QTFwREFTZXdXT0xhTFRaSC9yak5mTzNUM2QwQVZkQ2I5bEVRUXd1Z2JHckNX?=
 =?utf-8?B?UUJYbmd2WFhOZStralNod1dmR3EwUE9mZVIvRlI1T1hlRWREMVJEQWladXdE?=
 =?utf-8?B?Z290dzRQWk96WVpmVzRSaHlXS1ZxdEFiRlI3VWxOQWRaYkt2SkcxT2o2aFhn?=
 =?utf-8?B?VW5UeEJZdmJqbFhaY1ZTRHJuNHdSN2VyLzc1eklLVGZpdXNOTklReDNFZVhj?=
 =?utf-8?B?THRQd01ZV1krWE1tY0tIWHFvcGRXWXRlYUhZUmlNcUlNdUVUalF6cTR5RVkr?=
 =?utf-8?B?ZlQ5dnpEMHJiZGpBVFBFVE5FOUlBSDB6b3ZzNGk2endIKzRqOFlKU1FoNVBs?=
 =?utf-8?B?N1oxcDFNdHJMaWtGQmd5RHY5MG93ZjhXaUJ5YnhMdTVkbHM0cURkSjZIZk9D?=
 =?utf-8?B?ajh1Sitxa095eU14ZEk0dTZROFRYQnk3RFZFUmhjV1lua1BqNHNmUHYxSDZR?=
 =?utf-8?B?bUpLeGVmOVJSOUxYQjFjdTNYT291VVdOcytrZlVIMFVvTlpQcHNiVC9XdmEx?=
 =?utf-8?B?dWx1UmJIMWt1TnJuN0Z0ZjNrdnAxUU1CL01GcDc3bm82T2xtZElSWm5mRS9F?=
 =?utf-8?B?Q2dLdVJvNzZ5Vlc0azhDOU4wSUFrdHJOTUxWNTZuTDlkTnUzck1YTEljbjNO?=
 =?utf-8?B?azMxTS9BcmE5MVhBbXJ6dmt2THNrNVVld0dtOUliWTZ0VmpGMTZUQklYMHpl?=
 =?utf-8?B?SlpEaGE3Rmo2V3FnaDdqdzRYMDlyMDE1bERzOVh3UXBmdW1ONVF2c1RDZkZO?=
 =?utf-8?B?U1J2SnJWOTBqbEtpam91clZSOVEvTXJWZXhtYVFzdFhMUzJIK2UzMTRJZDBQ?=
 =?utf-8?B?T0RZYUxBZnRUZ24xTW8zVzk3SXJoSHpHaDV6ekkzdmdzTHAxMEluQmVQVmx4?=
 =?utf-8?B?VnIxeFBhZWwzYndxT1JpcFBYL2JKTDRFYy9JRjVramZHbmM4UGo5MmI0Tzh3?=
 =?utf-8?B?MkhEeUxpclVQS2kwYWgvWDYrY2QzWi9CdE0rb3VLZWl0eTlxUjJ5SlJSTkRI?=
 =?utf-8?B?T2s1QzFZbkxzWUY4WE1RaWhRV3VDQ3FHYXFWSlpNVU1lVEJhN1lvNkY3ZmZj?=
 =?utf-8?B?elVRWSt6YkNLbGFscHN2TmIvVTVSNm90NXVLV1lRUjZSUGV1MzlqTXdRaGMx?=
 =?utf-8?B?MURZT2F4aC8yRVY0b0FwNDYxQUN1WllubHVkeW9BM3Rsd1dxVENjQkNQMkV4?=
 =?utf-8?B?N0hCc2xhWmw1d2gzd0M4RjJXQ1RqR2lpTEwwS1dnZUNESGFGNW5YUjRDZkJL?=
 =?utf-8?B?cnFzcnpIYjV0S0tpS1h4T2VhajlHeG1hUEZkeWEvRzhnbUNSYWxiRWlESis0?=
 =?utf-8?B?RVpyTWQydDhnQnhyV2FKQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b3ebc6-3fce-4eb2-4352-08d904644aaa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 01:25:04.7221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjl6MBlv0Kz7GpddH3e5QI/B8TXFC6mXOr7Y1/UvaMycyH724MKZuvJu2/pv9+fkX8S8NPExzYRDXJJTsloxfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4783
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

CkFtIDIwMjEtMDQtMjAgdW0gODo0NSBwLm0uIHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4gQW0g
MjAyMS0wNC0xOSB1bSA5OjUyIHAubS4gc2NocmllYiBBbGV4IFNpZXJyYToKPj4gU1ZNIHJhbmdl
cyBhcmUgY3JlYXRlZCBmb3IgdW5yZWdpc3RlcmVkIG1lbW9yeSwgdHJpZ2dlcmVkCj4+IGJ5IHBh
Z2UgZmF1bHRzLiBUaGVzZSByYW5nZXMgYXJlIG1pZ3JhdGVkL21hcHBlZCB0bwo+PiBHUFUgVlJB
TSBtZW1vcnkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggU2llcnJhIDxhbGV4LnNpZXJyYUBh
bWQuY29tPgo+IFRoaXMgbG9va3MgZ2VuZXJhbGx5IGdvb2QgdG8gbWUuIE9uZSBtb3JlIG5pdC1w
aWNrIGlubGluZSBpbiBhZGRpdGlvbiB0bwo+IFBoaWxpcCdzIGNvbW1lbnRzLiBBbmQgb25lIHF1
ZXN0aW9uLgoKSSBmb3VuZCBhbm90aGVyIHBvdGVudGlhbCBkZWFkbG9jay4gU2VlIGlubGluZS4g
WytQaGlsaXBdCgoKPgo+Cj4+IC0tLQo+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3N2bS5jIHwgMTAzICsrKysrKysrKysrKysrKysrKysrKysrKysrLQo+PiAgMSBmaWxlIGNoYW5n
ZWQsIDEwMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX3N2bS5jCj4+IGluZGV4IDQ1ZGQwNTUxMThlYi4uYThhOTJjNTMzY2Y3IDEw
MDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMKPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jCj4+IEBAIC0yMTc5LDYgKzIx
NzksODQgQEAgc3ZtX3JhbmdlX2Jlc3RfcmVzdG9yZV9sb2NhdGlvbihzdHJ1Y3Qgc3ZtX3Jhbmdl
ICpwcmFuZ2UsCj4+ICAKPj4gIAlyZXR1cm4gLTE7Cj4+ICB9Cj4+ICtzdGF0aWMgaW50Cj4+ICtz
dm1fcmFuZ2VfZ2V0X3JhbmdlX2JvdW5kYXJpZXMoc3RydWN0IGtmZF9wcm9jZXNzICpwLCBpbnQ2
NF90IGFkZHIsCj4+ICsJCQkJdW5zaWduZWQgbG9uZyAqc3RhcnQsIHVuc2lnbmVkIGxvbmcgKmxh
c3QpCj4+ICt7Cj4+ICsJc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWE7Cj4+ICsJc3RydWN0IGlu
dGVydmFsX3RyZWVfbm9kZSAqbm9kZTsKPj4gKwl1bnNpZ25lZCBsb25nIHN0YXJ0X2xpbWl0LCBl
bmRfbGltaXQ7Cj4+ICsKPj4gKwl2bWEgPSBmaW5kX3ZtYShwLT5tbSwgYWRkcik7Cj4+ICsJaWYg
KCF2bWEgfHwgYWRkciA8IHZtYS0+dm1fc3RhcnQpIHsKPj4gKwkJcHJfZGVidWcoIlZNQSBkb2Vz
IG5vdCBleGlzdCBpbiBhZGRyZXNzIFsweCVsbHhdXG4iLCBhZGRyKTsKPj4gKwkJcmV0dXJuIC1F
RkFVTFQ7Cj4+ICsJfQo+PiArCXN0YXJ0X2xpbWl0ID0gbWF4KHZtYS0+dm1fc3RhcnQsCj4+ICsJ
CQkodW5zaWduZWQgbG9uZylBTElHTl9ET1dOKGFkZHIsIDJVTCA8PCAyMCkpID4+IFBBR0VfU0hJ
RlQ7Cj4+ICsJZW5kX2xpbWl0ID0gbWluKHZtYS0+dm1fZW5kLAo+PiArCQkJKHVuc2lnbmVkIGxv
bmcpQUxJR04oYWRkciArIDEsIDJVTCA8PCAyMCkpID4+IFBBR0VfU0hJRlQ7Cj4+ICsJLyogRmly
c3QgcmFuZ2UgdGhhdCBzdGFydHMgYWZ0ZXIgdGhlIGZhdWx0IGFkZHJlc3MgKi8KPj4gKwlub2Rl
ID0gaW50ZXJ2YWxfdHJlZV9pdGVyX2ZpcnN0KCZwLT5zdm1zLm9iamVjdHMsIChhZGRyID4+IFBB
R0VfU0hJRlQpICsgMSwgVUxPTkdfTUFYKTsKPj4gKwlpZiAobm9kZSkgewo+PiArCQllbmRfbGlt
aXQgPSBtaW4oZW5kX2xpbWl0LCBub2RlLT5zdGFydCk7Cj4+ICsJCS8qIExhc3QgcmFuZ2UgdGhh
dCBlbmRzIGJlZm9yZSB0aGUgZmF1bHQgYWRkcmVzcyAqLwo+PiArCQlub2RlID0gY29udGFpbmVy
X29mKHJiX3ByZXYoJm5vZGUtPnJiKSwgc3RydWN0IGludGVydmFsX3RyZWVfbm9kZSwgcmIpOwo+
PiArCX0gZWxzZSB7Cj4+ICsJCS8qIExhc3QgcmFuZ2UgbXVzdCBlbmQgYmVmb3JlIGFkZHIgYmVj
YXVzZSB0aGVyZSB3YXMgbm8gcmFuZ2UgYWZ0ZXIgYWRkciAqLwo+PiArCQlub2RlID0gY29udGFp
bmVyX29mKHJiX2xhc3QoJnAtPnN2bXMub2JqZWN0cy5yYl9yb290KSwKPj4gKwkJCQkgICAgc3Ry
dWN0IGludGVydmFsX3RyZWVfbm9kZSwgcmIpOwo+PiArCX0KPj4gKwlpZiAobm9kZSkKPj4gKwkJ
c3RhcnRfbGltaXQgPSBtYXgoc3RhcnRfbGltaXQsIG5vZGUtPmxhc3QgKyAxKTsKPj4gKwo+PiAr
CSpzdGFydCA9IHN0YXJ0X2xpbWl0Owo+PiArCSpsYXN0ID0gZW5kX2xpbWl0IC0gMTsKPj4gKwo+
PiArCXByX2RlYnVnKCJ2bWEgc3RhcnQ6ICVseCBzdGFydDogJWx4IHZtYSBlbmQ6ICVseCBsYXN0
OiAlbHhcbiIsCj4+ICsJCSAgdm1hLT52bV9zdGFydCA+PiBQQUdFX1NISUZULCAqc3RhcnQsCj4+
ICsJCSAgdm1hLT52bV9lbmQgPj4gUEFHRV9TSElGVCwgKmxhc3QpOwo+PiArCj4+ICsJcmV0dXJu
IDA7Cj4+ICsKPj4gK30KPj4gK3N0YXRpYyBzdHJ1Y3QKPj4gK3N2bV9yYW5nZSAqc3ZtX3Jhbmdl
X2NyZWF0ZV91bnJlZ2lzdGVyZWRfcmFuZ2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+
ICsJCQkJCQlzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsCj4+ICsJCQkJCQlzdHJ1Y3QgbW1fc3RydWN0
ICptbSwKPj4gKwkJCQkJCWludDY0X3QgYWRkcikKPj4gK3sKPj4gKwlzdHJ1Y3Qgc3ZtX3Jhbmdl
ICpwcmFuZ2UgPSBOVUxMOwo+PiArCXN0cnVjdCBzdm1fcmFuZ2VfbGlzdCAqc3ZtczsKPj4gKwl1
bnNpZ25lZCBsb25nIHN0YXJ0LCBsYXN0Owo+PiArCXVpbnQzMl90IGdwdWlkLCBncHVpZHg7Cj4+
ICsKPj4gKwlpZiAoc3ZtX3JhbmdlX2dldF9yYW5nZV9ib3VuZGFyaWVzKHAsIGFkZHIgPDwgUEFH
RV9TSElGVCwKPj4gKwkJCQkJICAgJnN0YXJ0LCAmbGFzdCkpCj4+ICsJCXJldHVybiBOVUxMOwo+
PiArCj4+ICsJc3ZtcyA9ICZwLT5zdm1zOwo+PiArCXByYW5nZSA9IHN2bV9yYW5nZV9uZXcoJnAt
PnN2bXMsIHN0YXJ0LCBsYXN0KTsKPj4gKwlpZiAoIXByYW5nZSkgewo+PiArCQlwcl9kZWJ1Zygi
RmFpbGVkIHRvIGNyZWF0ZSBwcmFuZ2UgaW4gYWRkcmVzcyBbMHglbGx4XVxcbiIsIGFkZHIpOwo+
PiArCQlnb3RvIG91dDsKPiBZb3UgY2FuIGp1c3QgcmV0dXJuIGhlcmUsIHNpbmNlIHlvdSdyZSBu
b3QgZG9pbmcgYW55IGNsZWFudXAgYXQgdGhlIG91dDoKPiBsYWJlbC4KPgo+Cj4+ICsJfQo+PiAr
CWlmIChrZmRfcHJvY2Vzc19ncHVpZF9mcm9tX2tnZChwLCBhZGV2LCAmZ3B1aWQsICZncHVpZHgp
KSB7Cj4+ICsJCXByX2RlYnVnKCJmYWlsZWQgdG8gZ2V0IGdwdWlkIGZyb20ga2dkXG4iKTsKPj4g
KwkJc3ZtX3JhbmdlX2ZyZWUocHJhbmdlKTsKPj4gKwkJcHJhbmdlID0gTlVMTDsKPj4gKwkJZ290
byBvdXQ7Cj4gSnVzdCByZXR1cm4uCj4KPgo+PiArCX0KPj4gKwlwcmFuZ2UtPnByZWZlcnJlZF9s
b2MgPSBncHVpZDsKPj4gKwlwcmFuZ2UtPmFjdHVhbF9sb2MgPSAwOwo+PiArCS8qIEd1cmFudGVl
IHByYW5nZSBpcyBtaWdyYXRlIGl0ICovCj4+ICsJcHJhbmdlLT52YWxpZGF0ZV90aW1lc3RhbXAg
LT0gQU1ER1BVX1NWTV9SQU5HRV9SRVRSWV9GQVVMVF9QRU5ESU5HOwo+IElzIHRoaXMgcmVhbGx5
IHNwZWNpZmljIHRvIHN2bV9yYW5nZV9jcmVhdGVfdW5yZWdpc3RlcmVkX3JhbmdlPyBPcgo+IHNo
b3VsZCB3ZSBhbHdheXMgZG8gdGhpcyBpbiBzdm1fcmFuZ2VfbmV3IHRvIGd1YXJhbnRlZSB0aGF0
IG5ldyByYW5nZXMKPiBjYW4gZ2V0IHZhbGlkYXRlZD8KPgo+IFJlZ2FyZHMsCj4gwqAgRmVsaXgK
Pgo+Cj4+ICsJc3ZtX3JhbmdlX2FkZF90b19zdm1zKHByYW5nZSk7Cj4+ICsJc3ZtX3JhbmdlX2Fk
ZF9ub3RpZmllcl9sb2NrZWQobW0sIHByYW5nZSk7Cj4+ICsKPj4gK291dDoKPj4gKwlyZXR1cm4g
cHJhbmdlOwo+PiArfQo+PiAgCj4+ICAvKiBzdm1fcmFuZ2Vfc2tpcF9yZWNvdmVyIC0gZGVjaWRl
IGlmIHByYW5nZSBjYW4gYmUgcmVjb3ZlcmVkCj4+ICAgKiBAcHJhbmdlOiBzdm0gcmFuZ2Ugc3Ry
dWN0dXJlCj4+IEBAIC0yMjI4LDYgKzIzMDYsNyBAQCBzdm1fcmFuZ2VfcmVzdG9yZV9wYWdlcyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgaW50IHBhc2lkLAo+PiAgCXN0cnVj
dCBrZmRfcHJvY2VzcyAqcDsKPj4gIAl1aW50NjRfdCB0aW1lc3RhbXA7Cj4+ICAJaW50MzJfdCBi
ZXN0X2xvYywgZ3B1aWR4Owo+PiArCWJvb2wgd3JpdGVfbG9ja2VkID0gZmFsc2U7Cj4+ICAJaW50
IHIgPSAwOwo+PiAgCj4+ICAJcCA9IGtmZF9sb29rdXBfcHJvY2Vzc19ieV9wYXNpZChwYXNpZCk7
Cj4+IEBAIC0yMjUxLDE0ICsyMzMwLDM0IEBAIHN2bV9yYW5nZV9yZXN0b3JlX3BhZ2VzKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCBpbnQgcGFzaWQsCj4+ICAJfQo+PiAgCj4+
ICAJbW1hcF9yZWFkX2xvY2sobW0pOwo+PiArcmV0cnlfd3JpdGVfbG9ja2VkOgo+PiAgCW11dGV4
X2xvY2soJnN2bXMtPmxvY2spOwo+PiAgCXByYW5nZSA9IHN2bV9yYW5nZV9mcm9tX2FkZHIoc3Zt
cywgYWRkciwgTlVMTCk7Cj4+ICAJaWYgKCFwcmFuZ2UpIHsKPj4gIAkJcHJfZGVidWcoImZhaWxl
ZCB0byBmaW5kIHByYW5nZSBzdm1zIDB4JXAgYWRkcmVzcyBbMHglbGx4XVxuIiwKPj4gIAkJCSBz
dm1zLCBhZGRyKTsKPj4gLQkJciA9IC1FRkFVTFQ7Cj4+IC0JCWdvdG8gb3V0X3VubG9ja19zdm1z
Owo+PiArCQlpZiAoIXdyaXRlX2xvY2tlZCkgewo+PiArCQkJLyogTmVlZCB0aGUgd3JpdGUgbG9j
ayB0byBjcmVhdGUgbmV3IHJhbmdlIHdpdGggTU1VIG5vdGlmaWVyLgo+PiArCQkJICogQWxzbyBm
bHVzaCBwZW5kaW5nIGRlZmVycmVkIHdvcmsgdG8gbWFrZSBzdXJlIHRoZSBpbnRlcnZhbAo+PiAr
CQkJICogdHJlZSBpcyB1cCB0byBkYXRlIGJlZm9yZSB3ZSBhZGQgYSBuZXcgcmFuZ2UKPj4gKwkJ
CSAqLwo+PiArCQkJbXV0ZXhfdW5sb2NrKCZzdm1zLT5sb2NrKTsKPj4gKwkJCW1tYXBfcmVhZF91
bmxvY2sobW0pOwo+PiArCQkJc3ZtX3JhbmdlX2xpc3RfbG9ja19hbmRfZmx1c2hfd29yayhzdm1z
LCBtbSk7CgpJIHRoaW5rIHRoaXMgY2FuIGRlYWRsb2NrIHdpdGggYSBkZWZlcnJlZCB3b3JrZXIg
dHJ5aW5nIHRvIGRyYWluCmludGVycnVwdHMgKFBoaWxpcCdzIHBhdGNoIHNlcmllcykuIElmIHdl
IGNhbm5vdCBmbHVzaCBkZWZlcnJlZCB3b3JrCmhlcmUsIHdlIG5lZWQgdG8gYmUgbW9yZSBjYXJl
ZnVsIGNyZWF0aW5nIG5ldyByYW5nZXMgdG8gbWFrZSBzdXJlIHRoZXkKZG9uJ3QgY29uZmxpY3Qg
d2l0aCBhZGRlZCBkZWZlcnJlZCBvciBjaGlsZCByYW5nZXMuCgpSZWdhcmRzLArCoCBGZWxpeAoK
Cj4+ICsJCQl3cml0ZV9sb2NrZWQgPSB0cnVlOwo+PiArCQkJZ290byByZXRyeV93cml0ZV9sb2Nr
ZWQ7Cj4+ICsJCX0KPj4gKwkJcHJhbmdlID0gc3ZtX3JhbmdlX2NyZWF0ZV91bnJlZ2lzdGVyZWRf
cmFuZ2UoYWRldiwgcCwgbW0sIGFkZHIpOwo+PiArCQlpZiAoIXByYW5nZSkgewo+PiArCQkJcHJf
ZGVidWcoImZhaWxlZCB0byBjcmVhdGUgdW5yZWdpc3RlcmQgcmFuZ2Ugc3ZtcyAweCVwIGFkZHJl
c3MgWzB4JWxseF1cbiIsCj4+ICsJCQlzdm1zLCBhZGRyKTsKPj4gKwkJCW1tYXBfd3JpdGVfZG93
bmdyYWRlKG1tKTsKPj4gKwkJCXIgPSAtRUZBVUxUOwo+PiArCQkJZ290byBvdXRfdW5sb2NrX3N2
bXM7Cj4+ICsJCX0KPj4gIAl9Cj4+ICsJaWYgKHdyaXRlX2xvY2tlZCkKPj4gKwkJbW1hcF93cml0
ZV9kb3duZ3JhZGUobW0pOwo+PiAgCj4+ICAJbXV0ZXhfbG9jaygmcHJhbmdlLT5taWdyYXRlX211
dGV4KTsKPj4gIAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
