Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBD9C47080
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 10:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2298E6103E
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 10:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2298E6103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E936E8D9;
	Mon, 31 May 2021 10:56:49 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EDF26E8D9;
 Mon, 31 May 2021 10:56:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJjEepJQEQvH1e5CGlLcwyJDQOCAb4CElzwDGBS/E3OJyEiXzrITNlZqk9RvEkOwubxb5ZH2XevyyOPJOuHjzRCX0DluSMwvixS+zqLjgqyRL+vvxMZnI4SKGBY9EmAWqJLcMMVSP8aAtuUg4FVVoee3wLjzzJiqjMhH8mII4BVYs6vo5wwl6aO5t6ItdSSbM9FBPPwCND+rEFodlwqBsjp2flW5LenhCJ1EibDT8TCMuyiRm9JqITuJMEDS2QugUyBB1hvmDD8nNPP1riljmtJtRC/9QO2eQ3lg8EFWA8fhOxKfEtaT0D1EatAcp3HkvHd479SV/GtcGaG0g52RLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWcGf49ZFliK7WjzOT4mBm/m/mE6K3rQcWpYjHi08gI=;
 b=dFgcQJBB6kWX/HWvykGj/ExMEHZQNJ9p2CCjc5NqazH/u+wlzQu5qT5FhJ6kIVBYbA3Y2syw916o/JTsYgluyHZbcynOxzVGmdEBCZjfzEpp6I9V0QdEgJPoY7PBKxKIcRojcPNI70XS9GdKFnTaqYt6gqz3iFj079xIslxzW3fGfMLgk87foUq35XFOTIVj5hPPZwq1FKNp1aPkJzZTDpaubP/eJ0kOlR+z+i0EQYOMhoHI3XwJ83Ks19tIiEMk+0LcGlXLSwdyjtSJbU6G35sdMti0Jc5LtQsypWF9cJb0MDMHsY5+MUxpzwN/J2g0wVqgo9pMHpF72WmQYxjXdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWcGf49ZFliK7WjzOT4mBm/m/mE6K3rQcWpYjHi08gI=;
 b=g4q3BNiVAvTSXfui5AmSSSs//TTEWW2AaAzQj4sXiM8Op2Cs57I7P1Xo7FFWSVsA6AfjD454L4Bs5igEuphGIPb2wXHI7Uphsa9bNCoWHuRPdClDDkaaPiHMHHMvm2ZVg2RjvhMe55HzIn0mLFB9kLZRN9OKfpfIzEjc3Qo4vZo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 10:56:44 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 10:56:44 +0000
Subject: Re: [PATCH 1/2] drm/ttm: cleanup and add TTM_PL_FLAG_TEMPORARY
To: =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= <thomas_os@shipmail.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Yu, Lang" <Lang.Yu@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210527013051.4302-1-Lang.Yu@amd.com>
 <DM6PR12MB4250B79297F587313D7645EBFB3F9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <14d7f047-cf6d-c84a-14ff-3f1d833a770b@shipmail.org>
 <883bd629-e3ad-07a2-8952-994f42cb02be@gmail.com>
 <86054733-9b7d-de96-4ab2-21dca85f1e6e@shipmail.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <888c52a5-ec10-0dee-c462-93cef8510e9f@amd.com>
Date: Mon, 31 May 2021 12:56:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <86054733-9b7d-de96-4ab2-21dca85f1e6e@shipmail.org>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:b94:4956:bad4:7c81]
X-ClientProxiedBy: AM9P193CA0001.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::6) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:b94:4956:bad4:7c81]
 (2a02:908:1252:fb60:b94:4956:bad4:7c81) by
 AM9P193CA0001.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 10:56:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b8ee5da-3d1f-4eab-42f6-08d92422c72f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4333A032717C4C09262D24F2833F9@MN2PR12MB4333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: whRE/LL7xIqt6I3VpEMzb0N2NMNy/kVWCmxeyZK3a+l6X9v5axiyhqhFWuz8OX6kd7K6DFEO/A4LDxGKb/tg51yj35o3n0p7UasHqo2fnFTsHavDyGUH7UyVtmu8/SjoHKcYRsYfKEbm8Lqi07IyQsSkZ4pOLbEnSdtB867cjXW0eONhpTMOkAhlxHzMWXh4lVgviX6EHyzEFcIRfnjiL+EHKC2OHz90rGPBg/IXbkSYD/HWwo0NqE+BX7rLYW7g9N0tVoGokfAnHTkCajRNLNcN9GfW1yI0BIaoBSHDtqwg3EHRkHJpaCV313Lgq6+plury1it6SqAlvau/VUOj6EgapQIuZBC0i9e4oi6tVc9o4/iP1wklXjHXEeHjNFQEXKaJPJ2JU39P952Hi9N22h/syqOpxWNn7C5PcMycbj+bKEjQGgbW6ZCcRBcAw7z2H4icJNZ44L9WSofzRCRh1wwrKKm7fYnjhVdjmm/NcJOsTZpgQkjvvMRiJQQgwacQoHVFY9Hb9UCQJwYBO57zg2S3/8c0DhsY5iL78WsHM+aBI/IQvbyVOSKWcH/V0jhmo4dAMSCfw4bulSh7D6GLdFJ74CvOsKBaeltkPZ7+A1zgdC/TWtmMJkKDs1ActJOI01Rv1QO+rPUXesnwTphuVB0KmzQhr3MtZS2Wcpm8MTmQLP522/QLV5nc7ZsaQo4CzTFSXpbFxPLoNGOB6G+37VsS9vkM9BAj63U9ZKTc3Qo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(45080400002)(478600001)(966005)(316002)(66946007)(38100700002)(8936002)(8676002)(36756003)(2906002)(86362001)(110136005)(186003)(16526019)(66556008)(53546011)(66574015)(31686004)(6666004)(66476007)(5660300002)(83380400001)(2616005)(6486002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d21NUTZkMWJ3MWN0dmZKUEhzTkYxbmZNdHFYbzRtNkdYUDZ1aXhlQ3dzMEEr?=
 =?utf-8?B?SXZZYW1nVDVqTDBmM3F4bFphQ25tY2dielZ1OWNlSUYvcXF6RDAwdXE3NXNE?=
 =?utf-8?B?UVQ2VjhDb0JPRGVGWG53T0dnTk5ZS2hWQnpSMU4ydklXM0tTRFI2SVVOeDJU?=
 =?utf-8?B?Qm5TZ2dVRFgwb2VxbGlZNlVsVFB3Y2JYNUx5NlNBcHNCdXAwSG5Sc0dMNkJy?=
 =?utf-8?B?TEdSVGVlL09NaU9kaDByMXM2N3lEVlpsQW0zTnVGQXVQVGVmdnBOT09Id1Nh?=
 =?utf-8?B?cExlZEdselk1WkJWNDhScXlaYUc0NUJKSERmTXNMR1pQU3d5QkhtNmpZeStN?=
 =?utf-8?B?OG5QY0ZGUUNlU29iSEZFY2Nvc0JQRHE5cEdKdVd1THdXZkdteSs4Ukc1cnpW?=
 =?utf-8?B?VzNESTdwelFTWTRRNEd0SE1DbVVIQkRCYVlMQ01OWW1meEUyQ3B1YlFjWWhq?=
 =?utf-8?B?NjgxZEFXd29lQkphcEZjU213Rk53WnhDeWxjTS9BTXZiVjJzd05iZDNJMHRy?=
 =?utf-8?B?MTk3KzJ6ZEpQNHhna0VUTGRlOW9tTE0vcWFPMmJMM1pxakRFcEptWTNiSUhK?=
 =?utf-8?B?UzRjblBueTZJT2dSUGI0UUxQZk5GVXJZWVVILzJkbnNueFptUXZkMTNMamRT?=
 =?utf-8?B?SEpZbTA1dCtLcWlnVWdocU8wSU5YMkhBTHFZSkpmNFcyMm9JV0hiQUUyeFh1?=
 =?utf-8?B?cytkZ3dXSDRrZG53T0V3YlZuTzdyb3ZCY3VmN2NvVkhCRUtvMnFLNy9xZ0k0?=
 =?utf-8?B?N2tidlFieEh1ZEtRWnVrUGVlVStzYTlLa3RDUnZyRDByUmdhdTdrTVFXbUFj?=
 =?utf-8?B?Z2Y3NDg1ZTBZSTI5dVM1L2hyQ1dXMDZkanBMZS9kcGx6Qi90MnJGVzRrRE1W?=
 =?utf-8?B?RUc3ZE1ZSEVIOG9WanNGaThFV2VvcDZmWWxHczhBeHpMam5IeGo5Z1pjL2lR?=
 =?utf-8?B?T3NQa2pJeURDMi9uUjFsUmR4ZEhBTGhtekhCV2FIcGtRQW5lYkNzdVdKWncx?=
 =?utf-8?B?eFRMcmM2Y0FtVVUvSGdOOE1oY21EWGFuSklpeWdXWjUybU9zMnBnMk9OL281?=
 =?utf-8?B?YkJSclpHa25GSmhEbHFoYXlweUhjdzNxNlo1T0d5YWE2ZHJQdldKbFpHRk4z?=
 =?utf-8?B?MFV4MnZOLzl2WkFPaTdFeWYySHlJeklwdkhTQW1yMHA0cE9qcThqdXpIdFgw?=
 =?utf-8?B?SVZvbEEyNlNoOVlIUlZobmswNjViN29tbUJ6eEtOZ3E5Qnlocy9vYzBVZnJj?=
 =?utf-8?B?Ni9sOTArM21tNm9NRjJNblc1b1ZkaXpCOWh3TnNTQ2JPSjAyMWVDZURjczVa?=
 =?utf-8?B?T3VkREVBY0ZWZXdERmpLV1VTc2U2VFRFSm5DMElyT0J5aTBZeU56VHlXMkhD?=
 =?utf-8?B?V0RlU3c5ZHZGNVZwR0ltU3lObkt4SWpKc1RsNkN4blBCSEJpRWxRcjkzTmRl?=
 =?utf-8?B?dU1BOHVMMjFqTHFNN0QyWHVsM1NsVDJ0TElCczBwa1FDNGd0dWF1aEV0TUlj?=
 =?utf-8?B?c1VOYmpoR2ZJNy9lZ1hTVHZDR2FoM0xmTWFrdmE5V0JnVjJwT1I4eW9WS1hF?=
 =?utf-8?B?OGxqbEMvcHJxaVBHRU8yRU15eENSdm1rRTlQSGlmVTRPZzBkbHBJSFlsdlFt?=
 =?utf-8?B?OTcvVjBMZmF1d0JFWGpSaHZPbFpVY3JTbHJJNkJ5bGRpVEdSWnhlZXYwQm45?=
 =?utf-8?B?WFNBQnpVRExUMGNqcUdQYTdBUTdCTVFwS2Z4cWszNjNHNWNpMDh3OUUveWIy?=
 =?utf-8?B?YVdzdnZPc1pYTENzSW5XU0lHdkUrOHRUOU9wNDliSHZ3ZXJES0pVYVpJRlJk?=
 =?utf-8?B?c1pzcUhmVEZ0MFZ4aTB5V1RwWDNmVTl3UDBLbzNNWk5rd29PVXN4MWJiRjZM?=
 =?utf-8?Q?bHSqVB23JRqNh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8ee5da-3d1f-4eab-42f6-08d92422c72f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 10:56:44.2405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgRCa82Bj2MFgONlN6m4cxhVN6UUQG1IWxC2FhpkAfPBxS3fwer6xHlwvhNx7ET7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
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

QW0gMzEuMDUuMjEgdW0gMTI6NDYgc2NocmllYiBUaG9tYXMgSGVsbHN0csO2bSAoSW50ZWwpOgo+
Cj4gT24gNS8zMS8yMSAxMjozMiBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMzEu
MDUuMjEgdW0gMTE6NTIgc2NocmllYiBUaG9tYXMgSGVsbHN0csO2bSAoSW50ZWwpOgo+Pj4gSGks
IExhbmcsCj4+Pgo+Pj4gT24gNS8zMS8yMSAxMDoxOSBBTSwgWXUsIExhbmcgd3JvdGU6Cj4+Pj4g
W1B1YmxpY10KPj4+Pgo+Pj4+PiBIaSwKPj4+Pj4gT24gNS8yNy8yMSAzOjMwIEFNLCBMYW5nIFl1
IHdyb3RlOgo+Pj4+Pj4gTWFrZSBUVE1fUExfRkxBR18qIHN0YXJ0IGZyb20gemVybyBhbmQgYWRk
Cj4+Pj4+PiBUVE1fUExfRkxBR19URU1QT1JBUlkgZmxhZyBmb3IgdGVtcG9yYXJ5Cj4+Pj4+PiBH
VFQgYWxsb2NhdGlvbiB1c2UuCj4+Pj4+IEdUVCBpcyBhIGRyaXZlciBwcml2YXRlIGFjcm9ueW0s
IHJpZ2h0PyBBbmQgaXQgZG9lc24ndCBsb29rIGxpa2UKPj4+Pj4gVFRNX1BMX0ZMQUdfVEVNUE9S
QVJZIHdpbGwgYmUgdXNlZCBpbiBjb3JlIFRUTSwgc28gc2hvdWxkIHdlIAo+Pj4+PiBpbnN0ZWFk
IHNldAo+Pj4+PiBhc2lkZSBhIG1hc2sgaW4gdGhlIFBMIGZsYWcgZm9yIGRyaXZlci1wcml2YXRl
IHVzZT8KPj4+PiBIaSBUaG9tYXMsCj4+Pj4KPj4+PiBUaGFua3MgZm9yIHlvdXIgY29tbWVudHMg
YW5kIGFkdmljZSwgR1RUIG1lYW5zIEdyYXBoaWNzIFRyYW5zbGF0aW9uIAo+Pj4+IFRhYmxlIGhl
cmUsIHNlZW1zCj4+Pj4gYSBnZW5lcmFsIGFjcm9ueW0uIFRUTV9QTF9GTEFHX1RFTVBPUkFSWSBt
YXkgYWxzbyBiZSB1c2VkIGJ5IG90aGVyIAo+Pj4+IGRyaXZlcy4KPj4+PiBJIGhhdmUgbWFkZSBv
dGhlciBwYXRjaGVzIGZvciB0aGlzLiBQbGVhc2UgaGVscCByZXZpZXcuCj4+Pj4KPj4+PiBSZWdh
cmRzLAo+Pj4+IExhbmcKPj4+Pgo+Pj4gTXkgcG9pbnQgd2FzIHJlYWxseSB0aGF0IHRoZSBmbGFn
IG5hbWluZyBhbmQgZG9jdW1lbnRhdGlvbiBzaG91bGQgCj4+PiByZWZsZWN0IHdoYXQgY29yZSB0
dG0gaXMgZG9pbmcgd2l0aCB0aGF0IGZsYWcuIElmIHRoZXJlIGlzIG5vIAo+Pj4gc3BlY2lmaWMg
Y29yZSBUVE0gdXNhZ2UsIElNTyB3ZSBzaG91bGQgbW92ZSBpdCB0byBhIGRyaXZlciBzcGVjaWZp
YyAKPj4+IGZsYWcgdG8gYXZvaWQgZnV0dXJlIGNvbmZ1c2lvbi4gSW4gcGFydGljdWxhciBhIHdy
aXRlciBvZiBhIGdlbmVyaWMgCj4+PiBUVE0gcmVzb3VyY2UgbWFuYWdlciBzaG91bGQgYmUgYWJs
ZSB0byBrbm93IHdpdGhvdXQgbG9va2luZyBhdCBhbiAKPj4+IG9sZCBjb21taXQgbWVzc2FnZSB3
aGF0IHRoZSBwbGFjZW1lbnQgZmxhZyBpcyBpbnRlbmRlZCBmb3IuCj4+Pgo+Pj4gU28gaGVyZSB3
ZSBhZGQgYSBmbGFnIHdoZXJlIGNvcmUgVFRNIGZvcmNlcyBhIGJvIG1vdmUgb24gdmFsaWRhdGUg
Cj4+PiBhbmQgdGhhdCdzIGl0LiBBbmQgdGhhdCBhcHBlYXJzIHRvIGJlIGhvdyBpdCdzIHVzZWQg
d2hlbiBhbiBhbWRncHUgCj4+PiBibyBpcyBldmljdGVkIHRvIEdUVCwgKGJ0dyBzaG91bGQgaXQg
YmUgYWNjb3VudGVkIGluIHRoaXMgc2l0dWF0aW9uPykKPj4+Cj4+PiBUaGUgb3RoZXIgdXNlIGlz
IHRvIGZvcmNlIHRoZSBhbWRncHUgZHJpdmVyIHRvIHRlbXBvcmFyaWx5IGFjY2VwdCBpdCAKPj4+
IGludG8gR1RUIHdoZW4gdGhlcmUgaXMgYSBsYWNrIG9mIHNwYWNlLCBhbmQgSU1ITyB0aGF0J3Mg
YSBkcml2ZXIgCj4+PiBzcGVjaWZpYyB1c2UgYW5kIHdlIHNob3VsZCBhbGxvY2F0ZSBhIG1hc2sg
Zm9yIGRyaXZlciBzcGVjaWZpYyBmbGFncyAKPj4+IGZvciB0aGF0Lgo+Pj4KPj4+IFNvIHNob3Vs
ZG4ndCB0aGlzIGJlIHR3byBmbGFncywgcmVhbGx5Pwo+Pgo+PiBXZWxsIG9uZSBmbGFnIG1ha2Vz
IHNlbnNlIGZvciB0aGUgdXNlIGNhc2UgYXQgaGFuZCB0aGF0IGRyaXZlcnMgd2FudCAKPj4gdG8g
c2lnbmFsIHRvIFRUTSB0aGF0IGFuIGFsbG9jYXRpb24gaXMgb25seSB0ZW1wb3JhcnkgYW5kIG5v
dCAKPj4gY29uc2lkZXJlZCB2YWxpZC4KPj4KPj4gVGhhdCB3ZSB0aGVuIHVzZSB0aGlzIGZsYWcg
dG8gaW1wbGVtZW50IHRlbXBvcmFyeSBHVFQgYWxsb2NhdGlvbnMgdG8gCj4+IGF2b2lkIHByb2Js
ZW1zIGR1cmluZyBldmljdGlvbiBpcyBqdXN0IGV4dGVuZGluZyB0aGF0IHVzZSBjYXNlLgo+Pgo+
IE9LLCBidXQgaXQgbG9va2VkIGxpa2UgdGhlcmUgd2VyZSBhY3R1YWxseSB0d28gdXNlLWNhc2Vz
LiBPbmUgZm9yIAo+IHBvc3NpYmx5IGxvbmctdGVybSBWUkFNIGV2aWN0aW9ucyB0byBHVFQsIHRo
ZSBvdGhlciBmb3IgdGhlIHRlbXBvcmFyeSAKPiB1c2UtY2FzZSB3aGVyZSB0aGUgaG9wIHJlc291
cmNlIGFsbG9jYXRpb25zIHNvbWV0aW1lcyBmYWlsZWQuIE9yIGRpZCBJIAo+IG1pc3VuZGVyc3Rh
bmQgdGhlIGNvZGU/CgpPayBzb3VuZHMgbGlrZSB3ZSBuZWVkIG1vcmUgZG9jdW1lbnRhdGlvbiBo
ZXJlLiBUaGF0J3MgcmVhbGx5IG9uZSB1c2UgY2FzZS4KCktleSBwb2ludCBpcyB3ZSBuZWVkIHRl
bXBvcmFyeSBhbGxvY2F0aW9uIGR1cmluZyBtdWx0aWhvcCB3aGljaCBzaG91bGQgCmJlIGhhbmRs
ZWQgZGlmZmVyZW50bHkgdG8gbm9ybWFsIGFsbG9jYXRpb25zLgoKV2hlbiBMYW5nIGlzIG9rIHdp
dGggdGhhdCBJIHRoaW5rIEkgd2lsbCBwaWNrIHVwIGhpcyBwYXRjaGVzIGFuZCAKZG9jdW1lbnQg
dGhlbSBhIGJpdC4KCkNocmlzdGlhbi4KCj4KPiAvVGhvbWFzCj4KPgo+PiBDaHJpc3RpYW4uCj4+
Cj4+Pgo+Pj4gVFRNX1BMX0ZMQUdfRk9SQ0VfTU9WRQo+Pj4KPj4+IGFuZAo+Pj4KPj4+IEFNREdQ
VV9QTF9GTEFHX1RFTVBPUkFSWQo+Pj4KPj4+IFRoYW5rcywKPj4+Cj4+PiAvVGhvbWFzCj4+Pgo+
Pj4+PiBUaG9tYXMKPj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4+Pj4gRnJvbTog
WXUsIExhbmcgPExhbmcuWXVAYW1kLmNvbT4KPj4+Pj4gU2VudDogVGh1cnNkYXksIE1heSAyNywg
MjAyMSA5OjMxIEFNCj4+Pj4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4+PiBDYzogS29lbmlnLCBDaHJpc3RpYW4g
PENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IEh1YW5nLCBSYXkKPj4+Pj4gPFJheS5IdWFuZ0Bh
bWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsK
Pj4+Pj4gWXUsIExhbmcgPExhbmcuWXVAYW1kLmNvbT4KPj4+Pj4gU3ViamVjdDogW1BBVENIIDEv
Ml0gZHJtL3R0bTogY2xlYW51cCBhbmQgYWRkIFRUTV9QTF9GTEFHX1RFTVBPUkFSWQo+Pj4+Pgo+
Pj4+PiBNYWtlIFRUTV9QTF9GTEFHXyogc3RhcnQgZnJvbSB6ZXJvIGFuZCBhZGQgVFRNX1BMX0ZM
QUdfVEVNUE9SQVJZIGZsYWcKPj4+Pj4gZm9yIHRlbXBvcmFyeSBHVFQgYWxsb2NhdGlvbiB1c2Uu
Cj4+Pj4+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IExhbmcgWXUgPExhbmcuWXVAYW1kLmNvbT4KPj4+
Pj4gLS0tCj4+Pj4+IGluY2x1ZGUvZHJtL3R0bS90dG1fcGxhY2VtZW50LmggfCA1ICsrKy0tCj4+
Pj4+IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pj4+
Cj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS90dG0vdHRtX3BsYWNlbWVudC5oCj4+Pj4+
IGIvaW5jbHVkZS9kcm0vdHRtL3R0bV9wbGFjZW1lbnQuaCBpbmRleCBhYTZiYTRkMGNmNzguLjlm
NWNmYzdjMmQ1YSAKPj4+Pj4gMTAwNjQ0Cj4+Pj4+IC0tLSBhL2luY2x1ZGUvZHJtL3R0bS90dG1f
cGxhY2VtZW50LmgKPj4+Pj4gKysrIGIvaW5jbHVkZS9kcm0vdHRtL3R0bV9wbGFjZW1lbnQuaAo+
Pj4+PiBAQCAtNDcsOCArNDcsOSBAQAo+Pj4+PiDCoCAqIHRvcCBvZiB0aGUgbWVtb3J5IGFyZWEs
IGluc3RlYWQgb2YgdGhlIGJvdHRvbS4KPj4+Pj4gwqAgKi8KPj4+Pj4KPj4+Pj4gLSNkZWZpbmUg
VFRNX1BMX0ZMQUdfQ09OVElHVU9VU8KgICgxIDw8IDE5KQo+Pj4+PiAtI2RlZmluZSBUVE1fUExf
RkxBR19UT1BET1dOwqDCoMKgwqAgKDEgPDwgMjIpCj4+Pj4+ICsjZGVmaW5lIFRUTV9QTF9GTEFH
X0NPTlRJR1VPVVPCoCAoMSA8PCAwKQo+Pj4+PiArI2RlZmluZSBUVE1fUExfRkxBR19UT1BET1dO
wqDCoMKgwqAgKDEgPDwgMSkKPj4+Pj4gKyNkZWZpbmUgVFRNX1BMX0ZMQUdfVEVNUE9SQVJZwqDC
oCAoMSA8PCAyKQo+Pj4+Pgo+Pj4+PiAvKioKPj4+Pj4gwqAgKiBzdHJ1Y3QgdHRtX3BsYWNlCj4+
Pj4+IC0tIAo+Pj4+PiAyLjI1LjEKPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+Pj4gYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1h
aWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q0NocmlzdGlhbi5L
b2VuaWclNDBhbWQuY29tJTdDMzg2OGFmMmJkNWQ5NGFlZGE5NGIwOGQ5MjQyMTViM2ElN0MzZGQ4
OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NTgwNTQ3OTgwMTkwMzkx
JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1
TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPUM3YjV3
ejhLcGg1Yk04ZmtGVnlYS3dTTmtTajNsRGF4R1Vud3c0alklMkZlTSUzRCZhbXA7cmVzZXJ2ZWQ9
MCAKPj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
