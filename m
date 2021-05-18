Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F31C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 16:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515F5611CE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 16:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515F5611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 000E66EC26;
	Tue, 18 May 2021 16:17:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A386EC26;
 Tue, 18 May 2021 16:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqmoapXBy5yZWLq1gMBgQVOZWiEXwqssDEeMsAhy6COxyz09JTVs0Ov2oum/ZR119sgcLe0TrOdJ/eMfNbtkwQ6nQF9OJeDok0okyUGcP2lCOFR2TkpRV/oruloO1mg+9aIOw4TPOthpMj622tNoaQn7ewIVvQbgCWuHgqSWFAeAOU/Ek2UNHa3PtpGWCYILbsT30jUe81IhXNjOQEF75xRwxOi8jUzaZjf6Q6VSWzyqMeaoekH4zWN2/rvln3yBDmb/bGBpMzcjaVuyLT9yvdP4yGPWab6HuYQfuPK1cU0Sgl2PShnhiqqnQNzhABSUqpYgcOAYqIcNxbCCzwKlBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZrtBWzw3cC0Q/E2EdQLqYcCt/kbyTNStxCP5zLj2to=;
 b=Gv6Xvj+LZg9G15ANJg10mRAYy43Hksxuo639Thjn/sXJf4rMznNobhdXD6SVr/1OT/YALp2CpVP0UmmvZnTniTAQ0lwUA7FEYXEZKLaBsz1tA22RGLWfI/yfAMWj3VK1nyNTh2spDDopKMUkT/TvXslB9nlhQ++btvxcnNlWIBuwSUj+UddAkFJldoPQFR7rrR3QbN2RHI6eqEPGoQwiolJCkhQzd7erfrgp74w602wjk4kHBnjU2t+5hmDeSix694xiJniSbwGaup7YzRxEosxuFo0vW+qIp+BX5AOcvV/ZK2jDiQfUjy8P7mmWZr4IP+JoolEa9LWaF9ejbHiYtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZrtBWzw3cC0Q/E2EdQLqYcCt/kbyTNStxCP5zLj2to=;
 b=lWeYuLycjiW6JCZkjvgnbhtYmHWMUEd80gTriut/3HRrRcMoU3OsJ/3YuE3DENsLkHohEuC214T09JFjh0mnOO31y9ZgrNpRw5pBG0YD0oen+7+EYr5MjRB2kEk48UoZfIHBF/TAS1BRSi8tLq68bEweQ69289rDYY1jE3x1/gQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 16:17:54 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 16:17:54 +0000
Subject: Re: [PATCH v7 13/16] drm/scheduler: Fix hang when sched_entity
 released
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-14-andrey.grodzovsky@amd.com>
 <9e1270bf-ab62-5d76-b1de-e6cd49dc4841@amd.com>
 <f0c5dea7-af35-9ea5-028e-6286e57a469a@amd.com>
 <34d4e4a8-c577-dfe6-3190-28a5c63a2d23@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <da1f9706-d918-cff8-2807-25da0c01fcde@amd.com>
Date: Tue, 18 May 2021 12:17:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <34d4e4a8-c577-dfe6-3190-28a5c63a2d23@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:19e2:b915:59c1:4860]
X-ClientProxiedBy: YT1PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::16) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:19e2:b915:59c1:4860]
 (2607:fea8:3edf:49b0:19e2:b915:59c1:4860) by
 YT1PR01CA0107.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Tue, 18 May 2021 16:17:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a0613f1-6129-4011-2620-08d91a187dc6
X-MS-TrafficTypeDiagnostic: SA0PR12MB4493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4493C3BDABF806CBC57A9727EA2C9@SA0PR12MB4493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpVLGVYqcmjNcMoG89A+C2RbkkFk4DAW5D8ZFgWPGfvGgcMj7YLDnfzTSj9gfVIrKH89GvrXdSoZz6yiNYf4FNwZ4qQyiVwrX2pyIgZ+hYqnB98HQM+5mpw5yHPaTNrPtpxM2cOIfAfU0dI4gFdq67BsAvC/40KveiI24pn+pdl1AZraCoqu587MbFv7t9M1H7GVcH1e9kn/KmY2Jt7YMy3gyaHFoVmh9y7YKWH40KXO2XNbB31nwuheuYSY2nvAsB1HjR0ykesmgjCL2jIN2lJYs/TWjdMcZOzF4Ek9lHkPQ+Oh4GE0LXYWlJZrPoicQRU0b24sLN18ZtR+0I/xuA2odpvI4ht4wt/cjRk4jCmcj52SctudRqCSpn2MmEpgdIsCBrOHJfoz5IvAsSXFoJVP18jQZG6hR5yitasBDnwp8TsooEQQPPwKRItJ1LAGwZJ7+UNhjL/DK+r8gFB9AUR8a1zdITO8RRyoQI+WmsIEBRrTdH+mzKCiR275h0dg5XRnRCGWc4N4NFk9emFfYDtSDmcWLOODqtoOSpJVptN6IMUy8T+tYrAEoTV9Y8djSJaJNqHyV6p3CeCyxKlbnuPcR7zmABmD0nXoDYsRxh1tSeXH9jwveQdkhJf4xJYbrFp8J2H7tZXSEg8qxqyyfk3Q7ieiYtdKWBH+IOlq6wzBB1cjvEWf4pYUqUyx9mb3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(6486002)(53546011)(52116002)(2616005)(498600001)(66946007)(66476007)(8676002)(66556008)(31686004)(31696002)(6636002)(16526019)(83380400001)(86362001)(8936002)(44832011)(38100700002)(186003)(36756003)(2906002)(4326008)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UzI4NWNTMmhSL0dzVjlsRHZ2RnVyMzRSMUV1Wm81Z0luZm9hTlVadElFWHdm?=
 =?utf-8?B?ZmVvUnZNUFordm1EQlZ4MzQ3c294T2ErYUdSQTRiWXVqcms2Yi91cWlWN09Y?=
 =?utf-8?B?cjJSNEV6d2lnR2g2aG81RWR5SDJaTlRlQnFhdlA3MFBOcmpNZjVnQ1crdmZv?=
 =?utf-8?B?YXc0NkVmMmEyc2dmSWZ6YlZkK0F6SEF0aDBkS3FwcnM4UVhKRkk0cVpmbE9p?=
 =?utf-8?B?SDFMZkFBRXZqZ0cvS2hOR1R1ZlROS24zY0k2MDJRSGNGSTFxdUJneVdNeUtS?=
 =?utf-8?B?WjJPN3MrenBJRURkM3l3Q3libkx1c1Z4M2huSStwbmswZElQYmJMMkhuSnMy?=
 =?utf-8?B?dktGMGlBWFNrN3dnZU1IQzZFcm5uVitVRGJTM3FtSzdabkhvdTB0WXAraWFX?=
 =?utf-8?B?bC80Z2d6WlorZXFpcUNsOERaV0cxWEVoRnhOdE9uMjB1ZTh6YWdwVmVUaHpm?=
 =?utf-8?B?bXkrUDNodmluZmNWKy85Uy9MbFhpRVdwYkRHSC9WaEV5cEowaE1mN3BtQlR0?=
 =?utf-8?B?SnhNbENkU0Y1aGJTTlBCM3pjSTJBcmI5TmZiS0o5NGorbUJQYW90RkczaW5V?=
 =?utf-8?B?RkR1UHJCbHRVWWpGQ3ltei9QRi9TNllxU2dxVnI0NHpISy9pL050cldaOGVz?=
 =?utf-8?B?SUgydEtsNldqSGVOVW1DcTROb1I4MG9yUTd1Um40bmh6L3pyY2NGNmRQMXBY?=
 =?utf-8?B?cmhuZFdHSWlyWUl4R2V0K2dnbmpxdE5GMVVoaVp2UjdMdHdxSnNocEhxY1d1?=
 =?utf-8?B?TkN3Ky9uTzdGQ09GYWdvaE92L3E4c0Z5TzlaUE9oU0dmNUJGNW16NHFSZ3Vk?=
 =?utf-8?B?bXkvcHVwNnhxc3ZxZS80VS9ZeXdKdUF5cUhDWnp3N082YlBORnc3RFZaWjVQ?=
 =?utf-8?B?RXN5RmFaRnprNGV4c2pTWUp1UkJCNGxUaVVxa1I2UnRTdXoxS0k1R25WYWsw?=
 =?utf-8?B?YjNGWUZzcTVKN1p1YmZNb2VOTDNqd0IyZDFHZWlRWkNoeENKUUtuT2hGZUow?=
 =?utf-8?B?REp4T3dMSUNGeE9SRGlyME1HTTc1WUczV0lVVmxLQzJJLzYxRmFOdjdyMGRW?=
 =?utf-8?B?SlFVQ3FMem5XbkFuaUIzdFZUamVzdWY5ejAvSTJMNGxISjN5eTdOYm5oYlpz?=
 =?utf-8?B?RjV1eGtkZnNNVXBLV3JpVStVS1Q0Vm1PdElhL0hmaUxsVCs4M2kxaU9VNFlu?=
 =?utf-8?B?YTV3Mm9sUFNsYVVWL3V2RFBZaTRUOTZNQ1JRWVRJcXdHM05vRURnZ1RrNk1a?=
 =?utf-8?B?VzV4UGJYNktRM0F4KzFIVzAyb3pYYjZNMnFxWHdhQVVaaUdhajN3Q1FzZXh3?=
 =?utf-8?B?Wmt2VlRXVlg2c2ZvOGJoeDdTQ2lHTnZkQk84Y3hoSGJ3bVcrY0YzamxhYVVV?=
 =?utf-8?B?ZmdXb2Z3czM5amtGZU9WcERrQ2lXeW5lZlFOSUNJU3FKWnhTak5JU0ZzczZu?=
 =?utf-8?B?c21wS1VYSkdvQndFa3Y0ejdtQ1lwYkNTRHE4ek5VdXlvQnFWb3Z3d3oyeExl?=
 =?utf-8?B?M0RlRVBVdUFuK2htVStUM3Y2bWlkUHZKbXZ6NC90NUg3S05aOWFWY1AzWE1l?=
 =?utf-8?B?ZlYvWmlITm9zVEowMVJoN0N3bjliVFZNZVhEMktoSTI0b2RVUkdlT2NjdVRE?=
 =?utf-8?B?NktWRVdLdWk1bEI5RngzL0RHbDRiY3YrUmFDRyt5YytDNWxCckVzbjFLd3hL?=
 =?utf-8?B?a0cwVkRNY09ZcnFkc00wK1hTOFFiYjNLRjFJTXBWUHJuMWwzZWNCWU1palYz?=
 =?utf-8?B?RUlkV1NqbDhsbU5yUDE0cnl2bnVGMVZRRklTQXpnd1hFbk1YTUNPU1ZXSUJv?=
 =?utf-8?B?cUpFZEhPLzNSM1E2MEh3UHhqVWZCMHIxUEo4SkUvZVNMR0U2U3pvQWxZMFJi?=
 =?utf-8?B?S2pPbXZreFhKOWhRcFZzR0h1NnpodlhTT0NxOHJrcG5aQkE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0613f1-6129-4011-2620-08d91a187dc6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 16:17:54.4139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bjlEye6PTX0m2PRTLM0psnQwzGkxTdvYBAvYig9sWXG//SEb2BSA4xwoSxTszgOuVsdGdDarooqTpQC6D5lLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIxLTA1LTE4IDExOjE1IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0g
MTguMDUuMjEgdW0gMTc6MDMgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4KPj4gT24gMjAy
MS0wNS0xOCAxMDowNyBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gSW4gYSBzZXBh
cmF0ZSBkaXNjdXNzaW9uIHdpdGggRGFuaWVsIHdlIG9uY2UgbW9yZSBpdGVyYXRlZCBvdmVyIHRo
ZSAKPj4+IGRtYV9yZXN2IHJlcXVpcmVtZW50cyBhbmQgSSBjYW1lIHRvIHRoZSBjb25jbHVzaW9u
IHRoYXQgdGhpcyBhcHByb2FjaCAKPj4+IGhlcmUgd29uJ3Qgd29yayByZWxpYWJsZS4KPj4+Cj4+
PiBUaGUgcHJvYmxlbSBpcyBhcyBmb2xsb3dpbmc6Cj4+PiAxLiBkZXZpY2UgQSBzY2hlZHVsZXMg
c29tZSByZW5kZXJpbmcgd2l0aCBpbnRvIGEgYnVmZmVyIGFuZCBleHBvcnRzIAo+Pj4gaXQgYXMg
RE1BLWJ1Zi4KPj4+IDIuIGRldmljZSBCIGltcG9ydHMgdGhlIERNQS1idWYgYW5kIHdhbnRzIHRv
IGNvbnN1bWUgdGhlIHJlbmRlcmluZywgCj4+PiBmb3IgdGhlIHRoZSBmZW5jZSBvZiBkZXZpY2Ug
QSBpcyByZXBsYWNlZCB3aXRoIGEgbmV3IG9wZXJhdGlvbi4KPj4+IDMuIGRldmljZSBCIGlzIGhv
dCBwbHVnZ2VkIGFuZCB0aGUgbmV3IG9wZXJhdGlvbiBjYW5jZWxlZC9uZXdlciAKPj4+IHNjaGVk
dWxlZC4KPj4+Cj4+PiBUaGUgcHJvYmxlbSBpcyBub3cgdGhhdCB3ZSBjYW4ndCBkbyB0aGlzIHNp
bmNlIHRoZSBvcGVyYXRpb24gb2YgCj4+PiBkZXZpY2UgQSBpcyBzdGlsbCBydW5uaW5nIGFuZCBi
eSBzaWduYWxpbmcgb3VyIGZlbmNlcyB3ZSBydW4gaW50byB0aGUgCj4+PiBwcm9ibGVtIG9mIHBv
dGVudGlhbCBtZW1vcnkgY29ycnVwdGlvbi4KCkJ5IHNpZ25hbGluZyBzX2ZlbmNlLT5maW5pc2hl
ZCBvZiB0aGUgY2FuY2VsZWQgb3BlcmF0aW9uIGZyb20gdGhlCnJlbW92ZWQgZGV2aWNlIEIgd2Ug
aW4gZmFjdCBjYXVzZSBtZW1vcnkgY29ycnVwdGlvbiBmb3IgdGhlIHVuY29tcGxldGVkCmpvYiBz
dGlsbCBydW5uaW5nIG9uIGRldmljZSBBID8gQmVjYXVzZSB0aGVyZSBpcyBzb21lb25lIHdhaXRp
bmcgdG8KcmVhZCB3cml0ZSBmcm9tIHRoZSBpbXBvcnRlZCBidWZmZXIgb24gZGV2aWNlIEIgYW5k
IGhlIG9ubHkgd2FpdHMgZm9yCnRoZSBzX2ZlbmNlLT5maW5pc2hlZCBvZiBkZXZpY2UgQiB3ZSBz
aWduYWxlZAppbiBkcm1fc2NoZWRfZW50aXR5X2tpbGxfam9icyA/CgpBbmRyZXkKCj4+Cj4+Cj4+
IEkgYW0gbm90IHN1cmUgdGhpcyBwcm9ibGVtIHlvdSBkZXNjcmliZSBhYm92ZSBpcyByZWxhdGVk
IHRvIHRoaXMgcGF0Y2guCj4gCj4gV2VsbCBpdCBpcyBraW5kIG9mIHJlbGF0ZWQuCj4gCj4+IEhl
cmUgd2UgcHVyZWx5IGV4cGFuZCB0aGUgY3JpdGVyaWEgZm9yIHdoZW4gc2NoZWRfZW50aXR5IGlz
Cj4+IGNvbnNpZGVyZWQgaWRsZSBpbiBvcmRlciB0byBwcmV2ZW50IGEgaGFuZyBvbiBkZXZpY2Ug
cmVtb3ZlLgo+IAo+IEFuZCBleGFjdGx5IHRoYXQgaXMgcHJvYmxlbWF0aWMuIFNlZSB0aGUgam9i
cyBvbiB0aGUgZW50aXR5IG5lZWQgdG8gCj4gY2xlYW5seSB3YWl0IGZvciB0aGVpciBkZXBlbmRl
bmNpZXMgYmVmb3JlIHRoZXkgY2FuIGJlIGNvbXBsZXRlZC4KPiAKPiBkcm1fc2NoZWRfZW50aXR5
X2tpbGxfam9icygpIGlzIGFsc28gbm90IGhhbmRsaW5nIHRoYXQgY29ycmVjdGx5IGF0IHRoZSAK
PiBtb21lbnQsIHdlIG9ubHkgd2FpdCBmb3IgdGhlIGxhc3Qgc2NoZWR1bGVkIGZlbmNlIGJ1dCBu
b3QgZm9yIHRoZSAKPiBkZXBlbmRlbmNpZXMgb2YgdGhlIGpvYi4KPiAKPj4gV2VyZSB5b3UgYWRk
cmVzc2luZyB0aGUgcGF0Y2ggZnJvbSB5ZXN0ZXJkYXkgaW4gd2hpY2ggeW91IGNvbW1lbnRlZAo+
PiB0aGF0IHlvdSBmb3VuZCBhIHByb2JsZW0gd2l0aCBob3cgd2UgZmluaXNoIGZlbmNlcyA/IEl0
IHdhcwo+PiAnW1BBVENIIHY3IDEyLzE2XSBkcm0vYW1kZ3B1OiBGaXggaGFuZyBvbiBkZXZpY2Ug
cmVtb3ZhbC4nCj4+Cj4+IEFsc28sIGluIHRoZSBwYXRjaCBzZXJpZXMgYXMgaXQgaXMgbm93IHdl
IG9ubHkgc2lnbmFsIEhXIGZlbmNlcyBmb3IgdGhlCj4+IGV4dHJhY3RlZCBkZXZpY2UgQiwgd2Ug
YXJlIG5vdCB0b3VjaGluZyBhbnkgb3RoZXIgZmVuY2VzLiBJbiBmYWN0IGFzIHlvdQo+PiBtYXkg
cmVtZW1iZXIsIEkgZHJvcHBlZCBhbGwgbmV3IGxvZ2ljIHRvIGZvcmNpbmcgZmVuY2UgY29tcGxl
dGlvbiBpbgo+PiB0aGlzIHBhdGNoIHNlcmllcyBhbmQgb25seSBjYWxsIGFtZGdwdV9mZW5jZV9k
cml2ZXJfZm9yY2VfY29tcGxldGlvbgo+PiBmb3IgdGhlIEhXIGZlbmNlcyBvZiB0aGUgZXh0cmFj
dGVkIGRldmljZSBhcyBpdCdzIGRvbmUgdG9kYXkgYW55d2F5Lgo+IAo+IFNpZ25hbGluZyBoYXJk
d2FyZSBmZW5jZXMgaXMgdW5wcm9ibGVtYXRpYyBzaW5jZSB0aGV5IGFyZSBlbWl0dGVkIHdoZW4g
Cj4gdGhlIHNvZnR3YXJlIHNjaGVkdWxpbmcgaXMgYWxyZWFkeSBjb21wbGV0ZWQuCj4gCj4gQ2hy
aXN0aWFuLgo+IAo+Pgo+PiBBbmRyZXkKPj4KPj4+Cj4+PiBOb3Qgc3VyZSBob3cgdG8gaGFuZGxl
IHRoYXQgY2FzZS4gT25lIHBvc3NpYmlsaXR5IHdvdWxkIGJlIHRvIHdhaXQgCj4+PiBmb3IgYWxs
IGRlcGVuZGVuY2llcyBvZiB1bnNjaGVkdWxlZCBqb2JzIGJlZm9yZSBzaWduYWxpbmcgdGhlaXIg
Cj4+PiBmZW5jZXMgYXMgY2FuY2VsZWQuCj4+Pgo+Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+IEFtIDEy
LjA1LjIxIHVtIDE2OjI2IHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Pj4gUHJvYmxlbTog
SWYgc2NoZWR1bGVyIGlzIGFscmVhZHkgc3RvcHBlZCBieSB0aGUgdGltZSBzY2hlZF9lbnRpdHkK
Pj4+PiBpcyByZWxlYXNlZCBhbmQgZW50aXR5J3Mgam9iX3F1ZXVlIG5vdCBlbXB0eSBJIGVuY291
bnRyZWQKPj4+PiBhIGhhbmcgaW4gZHJtX3NjaGVkX2VudGl0eV9mbHVzaC4gVGhpcyBpcyBiZWNh
dXNlIAo+Pj4+IGRybV9zY2hlZF9lbnRpdHlfaXNfaWRsZQo+Pj4+IG5ldmVyIGJlY29tZXMgZmFs
c2UuCj4+Pj4KPj4+PiBGaXg6IEluIGRybV9zY2hlZF9maW5pIGRldGFjaCBhbGwgc2NoZWRfZW50
aXRpZXMgZnJvbSB0aGUKPj4+PiBzY2hlZHVsZXIncyBydW4gcXVldWVzLiBUaGlzIHdpbGwgc2F0
aXNmeSBkcm1fc2NoZWRfZW50aXR5X2lzX2lkbGUuCj4+Pj4gQWxzbyB3YWtldXAgYWxsIHRob3Nl
IHByb2Nlc3NlcyBzdHVjayBpbiBzY2hlZF9lbnRpdHkgZmx1c2hpbmcKPj4+PiBhcyB0aGUgc2No
ZWR1bGVyIG1haW4gdGhyZWFkIHdoaWNoIHdha2VzIHRoZW0gdXAgaXMgc3RvcHBlZCBieSBub3cu
Cj4+Pj4KPj4+PiB2MjoKPj4+PiBSZXZlcnNlIG9yZGVyIG9mIGRybV9zY2hlZF9ycV9yZW1vdmVf
ZW50aXR5IGFuZCBtYXJraW5nCj4+Pj4gc19lbnRpdHkgYXMgc3RvcHBlZCB0byBwcmV2ZW50IHJl
aW5zZXJpb24gYmFjayB0byBycSBkdWUKPj4+PiB0byByYWNlLgo+Pj4+Cj4+Pj4gdjM6Cj4+Pj4g
RHJvcCBkcm1fc2NoZWRfcnFfcmVtb3ZlX2VudGl0eSwgb25seSBtb2RpZnkgZW50aXR5LT5zdG9w
cGVkCj4+Pj4gYW5kIGNoZWNrIGZvciBpdCBpbiBkcm1fc2NoZWRfZW50aXR5X2lzX2lkbGUKPj4+
Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNr
eUBhbWQuY29tPgo+Pj4+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Cj4+Pj4gLS0tCj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxl
ci9zY2hlZF9lbnRpdHkuYyB8wqAgMyArKy0KPj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1
bGVyL3NjaGVkX21haW4uY8KgwqAgfCAyNCAKPj4+PiArKysrKysrKysrKysrKysrKysrKysrKysK
Pj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
Pj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2Vu
dGl0eS5jIAo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+
Pj4+IGluZGV4IDAyNDljNzQ1MDE4OC4uMmU5M2U4ODFiNjVmIDEwMDY0NAo+Pj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKPj4+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4+Pj4gQEAgLTExNiw3ICsxMTYsOCBA
QCBzdGF0aWMgYm9vbCBkcm1fc2NoZWRfZW50aXR5X2lzX2lkbGUoc3RydWN0IAo+Pj4+IGRybV9z
Y2hlZF9lbnRpdHkgKmVudGl0eSkKPj4+PiDCoMKgwqDCoMKgIHJtYigpOyAvKiBmb3IgbGlzdF9l
bXB0eSB0byB3b3JrIHdpdGhvdXQgbG9jayAqLwo+Pj4+IMKgwqDCoMKgwqAgaWYgKGxpc3RfZW1w
dHkoJmVudGl0eS0+bGlzdCkgfHwKPj4+PiAtwqDCoMKgwqDCoMKgwqAgc3BzY19xdWV1ZV9jb3Vu
dCgmZW50aXR5LT5qb2JfcXVldWUpID09IDApCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHNwc2NfcXVl
dWVfY291bnQoJmVudGl0eS0+am9iX3F1ZXVlKSA9PSAwIHx8Cj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IGVudGl0eS0+c3RvcHBlZCkKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7Cj4+
Pj4gwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jIAo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVk
dWxlci9zY2hlZF9tYWluLmMKPj4+PiBpbmRleCA4ZDEyMTFlODcxMDEuLmEyYTk1MzY5M2I0NSAx
MDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+
Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+Pj4gQEAg
LTg5OCw5ICs4OTgsMzMgQEAgRVhQT1JUX1NZTUJPTChkcm1fc2NoZWRfaW5pdCk7Cj4+Pj4gwqDC
oCAqLwo+Pj4+IMKgIHZvaWQgZHJtX3NjaGVkX2Zpbmkoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVy
ICpzY2hlZCkKPj4+PiDCoCB7Cj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAq
c19lbnRpdHk7Cj4+Pj4gK8KgwqDCoCBpbnQgaTsKPj4+PiArCj4+Pj4gwqDCoMKgwqDCoCBpZiAo
c2NoZWQtPnRocmVhZCkKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAga3RocmVhZF9zdG9wKHNjaGVk
LT50aHJlYWQpOwo+Pj4+ICvCoMKgwqAgZm9yIChpID0gRFJNX1NDSEVEX1BSSU9SSVRZX0NPVU5U
IC0gMTsgaSA+PSAKPj4+PiBEUk1fU0NIRURfUFJJT1JJVFlfTUlOOyBpLS0pIHsKPj4+PiArwqDC
oMKgwqDCoMKgwqAgc3RydWN0IGRybV9zY2hlZF9ycSAqcnEgPSAmc2NoZWQtPnNjaGVkX3JxW2ld
Owo+Pj4+ICsKPj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFycSkKPj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjb250aW51ZTsKPj4+PiArCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHNwaW5fbG9j
aygmcnEtPmxvY2spOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5KHNf
ZW50aXR5LCAmcnEtPmVudGl0aWVzLCBsaXN0KQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC8qCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFByZXZlbnRzIHJlaW5zZXJ0aW9u
IGFuZCBtYXJrcyBqb2JfcXVldWUgYXMgaWRsZSwKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICogaXQgd2lsbCByZW1vdmVkIGZyb20gcnEgaW4gZHJtX3NjaGVkX2VudGl0eV9maW5pCj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGV2ZW50dWFsbHkKPj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICovCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc19lbnRpdHkt
PnN0b3BwZWQgPSB0cnVlOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBzcGluX3VubG9jaygmcnEtPmxv
Y2spOwo+Pj4+ICsKPj4+PiArwqDCoMKgIH0KPj4+PiArCj4+Pj4gK8KgwqDCoCAvKiBXYWtldXAg
ZXZlcnlvbmUgc3R1Y2sgaW4gZHJtX3NjaGVkX2VudGl0eV9mbHVzaCBmb3IgdGhpcyAKPj4+PiBz
Y2hlZHVsZXIgKi8KPj4+PiArwqDCoMKgIHdha2VfdXBfYWxsKCZzY2hlZC0+am9iX3NjaGVkdWxl
ZCk7Cj4+Pj4gKwo+Pj4+IMKgwqDCoMKgwqAgLyogQ29uZmlybSBubyB3b3JrIGxlZnQgYmVoaW5k
IGFjY2Vzc2luZyBkZXZpY2Ugc3RydWN0dXJlcyAqLwo+Pj4+IMKgwqDCoMKgwqAgY2FuY2VsX2Rl
bGF5ZWRfd29ya19zeW5jKCZzY2hlZC0+d29ya190ZHIpOwo+Pj4KPiAKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
