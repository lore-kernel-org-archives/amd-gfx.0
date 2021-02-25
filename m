Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0458C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 03:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6966D64E90
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 03:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6966D64E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4BD56EC32;
	Thu, 25 Feb 2021 03:15:51 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACA026EC32
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 03:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nie/3i3GlP4lGHX0ILtArmQeWXUVgmX4LCbJeEJ2kfzBiB90L4o6J3O1eTrjeOMvUswd26UWO9a01F9hzfPPsSD+loB6mXsTU6cPJu8LFnsObmXEfn0Pwer/DGcGwb3LWyoi6osD762ERG81vZyRAJzjoooHpPc0duUyot39BtILW70ALWKE86b5G8GUzyBqp2xzTxhix3XTs3G3g0rdkecTkA4E8P4MDev6L6GPGFsVtuHLI/gIUAoPNmQJMGPgOjgDNzh5b8ongzzQfcoLpd9+pJpcgos8t2Fe2DsJr7KeST0PwXUIVZiLy97ZSCGTj5RMKG4Dkl8dT7Ixr9tXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWYZLx1LfBhMu48fuFBBLQGPXXkd5S9DStOfych91LM=;
 b=AwD45YingbYBiUpIMgMzy/MJJCWfNBJnVoYjK14LxkrdoiJ/1A9FzHyFNN6VkyBAIlT0VIzArpbDH0y1zApGGgs6u2+jbycim6TVPLtXAgX1pUlEeTTBwN0gmLyziuseRZpIBwPz0ts9h86CXpB4S4Z4d0cuIwmLYiMkmC7hXrGM5sK9tZUndeloXw2aGaGY5m75P/TbaWob9qX89Z5blrYZ3QkSv0uFH+zXRb4zFNJ/ZO46xvWj1nQrIAD+PCbvh5eDiU75dx1IP9h++Hf8psy259sYPX1DU589HQoziKC/kwoDUJ+iYngiXtj4JnSyD4SnMNy0yf0wnqF08h+jMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWYZLx1LfBhMu48fuFBBLQGPXXkd5S9DStOfych91LM=;
 b=NkLazlvsnWkIBxv/o6J40YSmnCZY4tqZ7HMYtGjo+xEhVVm5xfRbBlnsOiBfyiPI7lcLHUA5RuSwB8G7MpNDBvGWewrgKgFvvBsg4QpytIgZv5Rz55wYoj1M0aSS/jLnd+C1eKtMS3eCNMFgxuIp8eJQ/xJDruMYHDUqbnK+RuQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4705.namprd12.prod.outlook.com (2603:10b6:208:88::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Thu, 25 Feb
 2021 03:15:48 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3784.030; Thu, 25 Feb 2021
 03:15:48 +0000
Subject: Re: [PATCH] drm/amdgpu: add ih call to process until checkpoint
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210223211026.116403-1-jonathan.kim@amd.com>
 <6d30f52e-7a7a-5662-a66f-db832b8386ae@amd.com>
 <DM5PR12MB4680F60D6590680E40A90AF5859F9@DM5PR12MB4680.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <92ddf2b3-3ee7-d481-2794-b57daed40ef9@amd.com>
Date: Wed, 24 Feb 2021 22:15:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM5PR12MB4680F60D6590680E40A90AF5859F9@DM5PR12MB4680.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::34) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.38 via Frontend Transport; Thu, 25 Feb 2021 03:15:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5034fc51-1489-4eb4-286e-08d8d93ba61f
X-MS-TrafficTypeDiagnostic: BL0PR12MB4705:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4705FA9ABBD004099B9D04E7929E9@BL0PR12MB4705.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x8G4HCFQ2VSKiSMOI7KgvQyaEbcAds+9zh0eACMdRvXcPY20mBKnWXdygVCY9Z7IAeqxDz8S7d88V2PAJXpQ4IEXpdyQPz/iSTkVx2UdokIgiPiuUeJC6hHP0aRpBhkXHFMl9eXXopkUDBvMFigAawfEEPq0Lu2J8eB2dSvICmxDYsIxkRFZdDYDmToO8cRUdUNNCN55Q0qT8MxssIuXwxw1R1FkEy6zh6bV+0idBslcRwGyg5cYkfJCNlozSoPgQ5ZSAv1l3u2nvecRuFQGG7IbR4pV1UUH8fYG/A3g1hB4SImIEV0nh5dIGykpESW9DpyTwfQMQHzD6F8ORcYLqlZiQTq6GSDKzDUQXsUm8brZQCslypgVWq4J0aCAU4oCtTk2/Gr+KC3WZmf44UbJc8Jp7QuaxEZk6A9XwTg5ySmSzSgQtLzhdMGcBDQxHqAvFHkq9p0PXALJkHmSQwRhRrMkFAMG4qp+u+jPXpcg3Xjh4rzqDJO9fsHqiuUvT1beZlzs66rPciPTQimXg/1qr3xmptEbJs1uha18+XJDObycVFio21jxNwLCFhm16kVehRF1J0cdGbW0owErof3Vm3Ev+NPCfXyEa1+cePjZNzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(31696002)(86362001)(110136005)(44832011)(26005)(8676002)(2616005)(53546011)(66946007)(66476007)(31686004)(2906002)(4326008)(6486002)(36756003)(5660300002)(956004)(66556008)(316002)(186003)(16526019)(52116002)(83380400001)(16576012)(36916002)(8936002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TXdqWmRUOW9yd2dKc3VkdXBvYmRQc1RmbXZQTXJ4MWhsc2YxcFdWT2t3OVRX?=
 =?utf-8?B?bUxKalNEaVZwUER3U2Zla3V5MStjU1VuYWhqYXV5clYxa1FMemJ5T0tzVTZK?=
 =?utf-8?B?aDNjQzlacENVVm9aa2FlODVKbXpmYzNubW15bmM0OVAwN3M3VWYxaW9ZSHJx?=
 =?utf-8?B?RTRVRjdld3JyUUhJcmlCdzFiTHE5OGUvdk1qOXhNZDNMTmR2ckNpRjRLNm9N?=
 =?utf-8?B?QTJneVBkQWJ6M1k5cy82dzY1blZsdXJPVnJURE0ySmEwWFdTaUhpMTlqdWQx?=
 =?utf-8?B?dDQwQ2xwVGw1Snk4TEtIQTdGaDlsOFk2ZUl5RjZnWm1pU1ZLS045M092bXhM?=
 =?utf-8?B?WlBZaWJ1QnEzTnc2cnovY0c5V25kQ0VJeGs3dzJpMm1uRk5mdWZZWDZiTUV2?=
 =?utf-8?B?OVFBTWZmcHE0N3cyVDhmTzVsVkFSY2dVWHdjU2VJdHByK2xTU3hTWDB4Sndn?=
 =?utf-8?B?eWdRR0x3ZGRmN091RzF1NklNSVkvSExpb2pIUDlabTBDUlE2VXVjSEZ1b1ow?=
 =?utf-8?B?cUgxVGlqZXJ1RUxERGNNOURERWwvMlUzZklMY1Y1L3BIWWh6alIydFIzTkg1?=
 =?utf-8?B?NjlpdTE1OElpc1hieFFZSHpZQjM5b0dNVWFTYWVQRGpxMHFhS2dQRUF5Z3NS?=
 =?utf-8?B?T0hhcVVxVDlKTDJvV2k3ZGd5TitEWVB5RWpRbnUyTlBqNlBHdjBnUGhoNjUy?=
 =?utf-8?B?cEw2RndOTDBaTm9xN2hzMTFUU0FpdWI1RDBzVGZsUjNkYnZSSHptRWxJc2Q2?=
 =?utf-8?B?NW1wS01ya28xODk5RmQxS1E2KzAzVEQyMGduL0NhL1BReFdMNFFCRG8vRnIz?=
 =?utf-8?B?TjFQVGVYcUw5S3Y1MWZsWEFCaUNKUC9RaTlacC9JVCtodDFNZ0prYnlYZS9t?=
 =?utf-8?B?MVIzREFIMFhjQmkzbWRPZzBiMHZ0Y3A4clliVStpWVUvUStyWThMT2h6eFpD?=
 =?utf-8?B?Qk9PUUpiRy84Z012M0ljU2JEYkdDcUJQbVduOW1pSEJUVGFQNW1WcmtaS0xD?=
 =?utf-8?B?YVU4d0lTbCtYdE1jUjNsZm9iT1puckx2TE01TzlVb3NyQkQ2clpCVUJHeXNU?=
 =?utf-8?B?cXpodEdWelZTK1Y3WVRQNU5UL2ZNbGlUTmsvdVRGaXFUbEpZUHFBNjlHT3R6?=
 =?utf-8?B?VkM2Sk5ML080RThOcmVNVVg3dnowRFlBZmRBN2l0eEl0UER6Um9pUTB6SEk4?=
 =?utf-8?B?bXNQRXhIUitEdmZobFc3SEdCUUdsZVN2akw2WDhqUzBaWGhSVkRxNkxYazE4?=
 =?utf-8?B?dGxVSWhRVENyL2o1OWpodE9ESWZKcEhYVXpjL3FDQXNydDFaeDRlTC8xQUFY?=
 =?utf-8?B?eFNsSEhWd09MNWVLM2hRUEFHVEZGVTN4bzhqTWpuY1JyMG01U2FiU0FwbFd3?=
 =?utf-8?B?Y05mZ3gwaWZiMzdGVi9lRjRpdXh5c09NRWduKzU4ZHVzVEJSZm9CckhPMWVv?=
 =?utf-8?B?TlNYS0JCNDZRcnVEOUVFQVZ0SXR1bk9YM08yRFNuREJsUmJXWHg4MlRvVFcx?=
 =?utf-8?B?T2VzNUJlRTYycTNpM3NBWXBwTjZmWWhQRVAwdm5lVEFqZGZNMFJWOVJMVzdx?=
 =?utf-8?B?UGRsKzRKeDREVTVhTkJhMFdkOERCenF2WlR6elBDaHluT05sbTQ2eVgyaEE3?=
 =?utf-8?B?OWp0UEtVWVE0VjBWNDhNeTJNM1ZNRmR5cVl1ZWZldzNZc2orTlE5c1ZzWUNv?=
 =?utf-8?B?cXo5REMrY042MnlreThYZndtUkpiOVArNit1UXQ5Y0NKdnF6SEg0UjhneHFD?=
 =?utf-8?Q?OWeXUZJ6ZnTRtDQdi3YoCPhEr743s6jrZito3xf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5034fc51-1489-4eb4-286e-08d8d93ba61f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 03:15:48.8144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16tM0jLB4oRVDl8NBqmaGauBRFC0TVPY2MXjPT/Kw210LFCL360/BIVvVYxjQPhpQy0KIUNbvOCGVV4SKAHHzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4705
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMi0yNCAxMDo1NCBhLm0uLCBLaW0sIEpvbmF0aGFuIHdyb3RlOgo+IFtBTUQgT2Zm
aWNpYWwgVXNlIE9ubHkgLSBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0KPgo+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQo+PiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPgo+PiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDI0LCAyMDIxIDQ6
MTcgQU0KPj4gVG86IEtpbSwgSm9uYXRoYW4gPEpvbmF0aGFuLktpbUBhbWQuY29tPjsgYW1kLQo+
PiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IENjOiBZYW5nLCBQaGlsaXAgPFBoaWxpcC5Z
YW5nQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXgKPj4gPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+
Cj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGFkZCBpaCBjYWxsIHRvIHByb2Nl
c3MgdW50aWwgY2hlY2twb2ludAo+Pgo+PiBBbSAyMy4wMi4yMSB1bSAyMjoxMCBzY2hyaWViIEpv
bmF0aGFuIEtpbToKPj4+IEFkZCBJSCBmdW5jdGlvbiB0byBhbGxvdyBjYWxsZXIgdG8gcHJvY2Vz
cyByaW5nIGVudHJpZXMgdW50aWwgdGhlCj4+PiBjaGVja3BvaW50IHdyaXRlIHBvaW50ZXIuCj4+
IFRoaXMgbmVlZHMgYSBiZXR0ZXIgZGVzY3JpcHRpb24gb2Ygd2hhdCB0aGlzIHdpbGwgYmUgdXNl
ZCBmb3IuCj4gRmVsaXggb3IgUGhpbGlwIGNvdWxkIGVsYWJvcmF0ZSBiZXR0ZXIgZm9yIEhNTSBu
ZWVkcy4KPiBEZWJ1Z2dpbmcgdG9vbHMgcmVxdWlyZXMgdGhpcyBidXQgaXQncyBpbiBleHBlcmlt
ZW50YWwgbW9kZSBhdCB0aGUgbW9tZW50IHNvIHByb2JhYmx5IG5vdCB0aGUgYmVzdCBwbGFjZSB0
byBkZXNjcmliZSBoZXJlLgoKT24gdGhlIEhNTSBzaWRlIHdlJ3JlIHBsYW5uaW5nIHRvIHVzZSB0
aGlzIHRvIGRyYWluIHBlbmRpbmcgcGFnZSBmYXVsdCAKaW50ZXJydXB0cyBiZWZvcmUgd2UgdW5t
YXAgbWVtb3J5LiBUaGF0IHNob3VsZCBhZGRyZXNzIHBoYW50b20gVk0gZmF1bHRzIAphZnRlciBt
ZW1vcnkgaXMgdW5tYXBwZWQuCgpSZWdhcmRzLAogwqAgRmVsaXgKCgo+Cj4+PiBTdWdnZXN0ZWQt
Ynk6IEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGluZ0BhbWQuY29tPgo+Pj4gU2lnbmVkLW9m
Zi1ieTogSm9uYXRoYW4gS2ltIDxqb25hdGhhbi5raW1AYW1kLmNvbT4KPj4+IC0tLQo+Pj4gICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmMgfCA0Ngo+PiArKysrKysrKysr
KysrKysrKysrKysrKysrLQo+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2loLmggfCAgMiArKwo+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9paC5jCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9p
aC5jCj4+PiBpbmRleCBkYzg1MmFmNGYzYjcuLmNhZTUwYWY5NTU5ZCAxMDA2NDQKPj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5jCj4+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguYwo+Pj4gQEAgLTIyLDcgKzIyLDcgQEAKPj4+
ICAgICAqLwo+Pj4KPj4+ICAgICNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGluZy5oPgo+Pj4gLQo+
Pj4gKyNpbmNsdWRlIDxsaW51eC9wcm9jZXNzb3IuaD4KPj4+ICAgICNpbmNsdWRlICJhbWRncHUu
aCIKPj4+ICAgICNpbmNsdWRlICJhbWRncHVfaWguaCIKPj4+Cj4+PiBAQCAtMTYwLDYgKzE2MCw1
MCBAQCB2b2lkIGFtZGdwdV9paF9yaW5nX3dyaXRlKHN0cnVjdAo+PiBhbWRncHVfaWhfcmluZyAq
aWgsIGNvbnN0IHVpbnQzMl90ICppdiwKPj4+ICAgIH0KPj4+ICAgIH0KPj4+Cj4+PiArLyoqCj4+
PiArICogYW1kZ3B1X2loX3dhaXRfb25fY2hlY2twb2ludF9wcm9jZXNzIC0gd2FpdCB0byBwcm9j
ZXNzIElWcyB1cCB0bwo+Pj4gK2NoZWNrcG9pbnQKPj4+ICsgKgo+Pj4gKyAqIEBhZGV2OiBhbWRn
cHVfZGV2aWNlIHBvaW50ZXIKPj4+ICsgKiBAaWg6IGloIHJpbmcgdG8gcHJvY2Vzcwo+Pj4gKyAq
Cj4+PiArICogVXNlZCB0byBlbnN1cmUgcmluZyBoYXMgcHJvY2Vzc2VkIElWcyB1cCB0byB0aGUg
Y2hlY2twb2ludCB3cml0ZQo+PiBwb2ludGVyLgo+Pj4gKyAqLwo+Pj4gK2ludCBhbWRncHVfaWhf
d2FpdF9vbl9jaGVja3BvaW50X3Byb2Nlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2UKPj4gKmFkZXYs
Cj4+PiArc3RydWN0IGFtZGdwdV9paF9yaW5nICppaCkKPj4+ICt7Cj4+PiArdTMyIHByZXZfcnB0
ciwgY3VyX3JwdHIsIGNoZWNrcG9pbnRfd3B0cjsKPj4+ICsKPj4+ICtpZiAoIWloLT5lbmFibGVk
IHx8IGFkZXYtPnNodXRkb3duKQo+Pj4gK3JldHVybiAtRU5PREVWOwo+Pj4gKwo+Pj4gK2N1cl9y
cHRyID0gUkVBRF9PTkNFKGloLT5ycHRyKTsKPj4+ICsvKiBPcmRlciByZWFkIG9mIGN1cnJlbnQg
cnB0ciB3aXRoIGNoZWNrdHBvaW50IHdwdHIuICovCj4+PiArbWIoKTsKPj4+ICtjaGVja3BvaW50
X3dwdHIgPSBhbWRncHVfaWhfZ2V0X3dwdHIoYWRldiwgaWgpOwo+Pj4gKwo+Pj4gKy8qIGFsbG93
IHJwdHIgdG8gd3JhcCBhcm91bmQgICovCj4+PiAraWYgKGN1cl9ycHRyID4gY2hlY2twb2ludF93
cHRyKSB7Cj4+PiArc3Bpbl9iZWdpbigpOwo+Pj4gK2RvIHsKPj4+ICtzcGluX2NwdV9yZWxheCgp
Owo+Pj4gK3ByZXZfcnB0ciA9IGN1cl9ycHRyOwo+Pj4gK2N1cl9ycHRyID0gUkVBRF9PTkNFKGlo
LT5ycHRyKTsKPj4+ICt9IHdoaWxlIChjdXJfcnB0ciA+PSBwcmV2X3JwdHIpOwo+Pj4gK3NwaW5f
ZW5kKCk7Cj4+IFRoYXQncyBhIGNlcnRhaW4gTkFLIHNpbmNlIGl0IGJ1c3kgd2FpdHMgZm9yIElI
IHByb2Nlc3NpbmcuIFdlIG5lZWQgc29tZQo+PiBldmVudCB0byB0cmlnZ2VyIGhlcmUuCj4gVGhl
IGZ1bmN0aW9uIGlzIG1lYW50IHRvIGJlIGp1c3QgYSB3YWl0ZXIgdXAgdG8gdGhlIGNoZWNrcG9p
bnQuCj4gVGhlcmUncyBhIG5lZWQgdG8gZ3VhcmFudGVlIHRoYXQgInN0YWxlIiBpbnRlcnJ1cHRz
IGhhdmUgYmVlbiBwcm9jZXNzZWQgb24gY2hlY2sgYmVmb3JlIGRvaW5nIG90aGVyIHN0dWZmIGFm
dGVyIGNhbGwuCj4gVGhlIGRlc2NyaXB0aW9uIGNvdWxkIGJlIGltcHJvdmVkIHRvIGNsYXJpZnkg
dGhhdC4KPgo+IFdvdWxkIGJ1c3kgd2FpdGluZyBvbmx5IG9uIGEgbG9ja2VkIHJpbmcgaGVscD8g
IEkgYXNzdW1lIGFuIHVubG9ja2VkIHJpbmcgbWVhbnMgbm90aGluZyB0byBwcm9jZXNzIHNvIG5v
IG5lZWQgdG8gd2FpdCBhbmQgd2UgY2FuIGV4aXQgZWFybHkuICBPciBpcyBpdCBiZXR0ZXIgdG8g
anVzdCB0byBwcm9jZXNzIHRoZSBlbnRyaWVzIHVwIHRvIHRoZSBjaGVja3BvaW50IChtYXliZSBh
ZGp1c3QgYW1kZ3B1X2loX3Byb2Nlc3MgZm9yIHRoaXMgbmVlZCBsaWtlIGFkZGluZyBhIGJvb2wg
YXJnIHRvIHNraXAgcmVzdGFydCBvciBzb21ldGhpbmcpPwo+Cj4gVGhhbmtzLAo+Cj4gSm9uCj4K
Pj4+ICt9Cj4+PiArCj4+PiArLyogd2FpdCBmb3IgcnB0ciB0byBjYXRjaCB1cCB0byBvciBwYXNz
IGNoZWNrcG9pbnQuICovCj4+PiArc3Bpbl9iZWdpbigpOwo+Pj4gK2RvIHsKPj4+ICtzcGluX2Nw
dV9yZWxheCgpOwo+Pj4gK3ByZXZfcnB0ciA9IGN1cl9ycHRyOwo+Pj4gK2N1cl9ycHRyID0gUkVB
RF9PTkNFKGloLT5ycHRyKTsKPj4+ICt9IHdoaWxlIChjdXJfcnB0ciA+PSBwcmV2X3JwdHIgJiYg
Y3VyX3JwdHIgPCBjaGVja3BvaW50X3dwdHIpOwo+PiBTYW1lIG9mIGNvdXJzZSBoZXJlLgo+Pgo+
PiBDaHJpc3RpYW4uCj4+Cj4+PiArc3Bpbl9lbmQoKTsKPj4+ICsKPj4+ICtyZXR1cm4gMDsKPj4+
ICt9Cj4+PiArCj4+PiAgICAvKioKPj4+ICAgICAqIGFtZGdwdV9paF9wcm9jZXNzIC0gaW50ZXJy
dXB0IGhhbmRsZXIKPj4+ICAgICAqCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2loLmgKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2loLmgKPj4+IGluZGV4IDZlZDRhODVmYzdjMy4uNjgxN2YwYTgxMmQyIDEwMDY0NAo+Pj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmgKPj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oCj4+PiBAQCAtODcsNiArODcsOCBA
QCBpbnQgYW1kZ3B1X2loX3JpbmdfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4g
c3RydWN0IGFtZGdwdV9paF9yaW5nICppaCwKPj4+ICAgIHZvaWQgYW1kZ3B1X2loX3JpbmdfZmlu
aShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0Cj4+IGFtZGdwdV9paF9yaW5nICpp
aCk7Cj4+PiAgICB2b2lkIGFtZGdwdV9paF9yaW5nX3dyaXRlKHN0cnVjdCBhbWRncHVfaWhfcmlu
ZyAqaWgsIGNvbnN0IHVpbnQzMl90ICppdiwKPj4+ICAgICAgdW5zaWduZWQgaW50IG51bV9kdyk7
Cj4+PiAraW50IGFtZGdwdV9paF93YWl0X29uX2NoZWNrcG9pbnRfcHJvY2VzcyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZQo+PiAqYWRldiwKPj4+ICtzdHJ1Y3QgYW1kZ3B1X2loX3JpbmcgKmloKTsKPj4+
ICAgIGludCBhbWRncHVfaWhfcHJvY2VzcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3Ry
dWN0Cj4+IGFtZGdwdV9paF9yaW5nICppaCk7Cj4+PiAgICB2b2lkIGFtZGdwdV9paF9kZWNvZGVf
aXZfaGVscGVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+Pj4gICAgc3RydWN0IGFtZGdw
dV9paF9yaW5nICppaCwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
