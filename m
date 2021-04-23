Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CFAC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 12:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD043611C1
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 12:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD043611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 205EC6EB84;
	Fri, 23 Apr 2021 12:50:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F40C16EB8A
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 12:50:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzgMbEKR6zYekaMFS3RRybaYPx/yDuZu+9A2ahkyhBZgVC0SKGs5pNwVF2JI9mTZAtgdeQ1Mj7aMlM78HCaEjHeLWB1gEc0SWal4SV895B+UoIB88b7tHDp68Z5MM7oenPiBHAIn3bHUjmfFDy57ccB2lP/gIqQAKDX7SMQeYxmtrjwhHmtFA6lMQowgyPJ7J4VGgGxedexHj8yuxjbXx1h+1fp/jOl1i2M9tRbJJyyRBWrOKLkSP+bpx0srTDzl8syB4XfMPa1DvBsBDvLixkXu8Tu8YyUFOtwuQQZI34zJ4n+WS9LxpUbUyQpXHx/oX5UjPEv9ZTqRhLeZueXbHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqjPF1eh04Ztoj1+o2+w5BtsuKEpTz06QYEhj/DcN+k=;
 b=AWQU709L3YnNU9T4uiRbcG7/64jB0x9zAB6ldT5jjf2bGaprJ0Qce0TSP/cv1ka7O0E9FPOkIlL9vymJnwssXorPPOGY0NDkm3y05MgVpkxw9Y4nxSthXpuYatfFdqqr/MIkSsGzr9+TZdCwcmhY1In55FV4QCe1yyl9t6b+MIhIq4GiSv6SvSernXuWiudJhder4V0RLI7DhjkEkpQy1HP/QD4o/YfpJ8+wx5sPTxREp9+hnLkRHPZgLEW593Euo3ngeqLKbA7cWuCnVOUniWrD/mJHON3AJZxGYJPsp+fjiJXedDto3Xu6xmoyybZTBiLeksYGrw+1ga2ukISSmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqjPF1eh04Ztoj1+o2+w5BtsuKEpTz06QYEhj/DcN+k=;
 b=RjdR40lV7PKNNfbjmaP9uRQWcWTXMMIgIEv61x8UZCfGGSF2dnYXfdDkU7VjY/l+AngllKd/KJnX7mlJO9WYHzBG27LNdKO6Z5OPS4oE+qTlJUhzjsg68e6lko8hAibihYfXI08/iVSrYqw6ipByB+C7XYQiwGHxWHjovtD84tE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Fri, 23 Apr 2021 12:50:23 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4065.025; Fri, 23 Apr 2021
 12:50:23 +0000
Subject: Re: [PATCH] drm/amdgpu: fix concurrent VM flushes on Vega/Navi v2
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20210423092933.1310-1-christian.koenig@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <0e55a867-7c52-3713-51d4-0d0e048480c5@amd.com>
Date: Fri, 23 Apr 2021 08:50:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210423092933.1310-1-christian.koenig@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::43) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.230.192] (165.204.55.251) by
 YTBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Fri, 23 Apr 2021 12:50:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba1d28d6-baaf-4249-a72d-08d906565be2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4579:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4579D3A88AF3AD587048D735E4459@DM6PR12MB4579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BJ0bY+M4U1/eRZjjx7/eJLMNFtC4NuOz90hHQ5oh210K4QYjrUURu156NR6qVEY4xDx7c62f0EFQWrQwKsbL1JU4ZuYi0knSZPYmKACpgyr9KegZNKrMb6l4ql52wz099Y4bmjOpqPxh0/BihFhkV1uq/C/mAIcKWCOk5Trw/63cS0aTierf/IaNoTg41ELiATYnAgcGCGp/PWPqphu9+e5lirqgrg5IBKB7IaLFBof8jpiFieX3EQWaLsYkjlNCrkdXJyUi59rueq8xm0uIWIISDs/yZKXvHd3xUkdESOhLsIHFxPbwNjT7wPVesbzS/xYdP7vTGE59x2Z7HqaoVODIn8+hbgpX1FeYREjiWRBO9GyR408P6EXXW9KEGCVwGAlxXL5KwpUGRtanaLdXShRuhiamRVrU9jkOQiujik8s5BpUKHnIKMISyT+nACekYUozK1kZdVll2YOUSAgoBrm+iN9O9xqc1VGDgU1y2dDswa/Qv5RxMsIVtgphRBvuNWuUIQ7Dr8SCOJrW7kD2jpckkDgO/P1hLfzVAvXH0HFqe7/GLtsRVaCSaOskuKbzneHkEz4/d5XRgN/gJy8bmKSPKNfLLV65geBdZ4QnWGaV3tHIRefoVTiVHjFYvBS12tKbUxKwfrs4zFfBUHUpHWJrRNYDHrZTr4Mz7Wy+wwLMDlLYYM0gEIku8GMewyWXl2YQM8K14h5Zta407cbcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(376002)(136003)(366004)(396003)(6486002)(2906002)(16576012)(8676002)(31696002)(52116002)(316002)(36916002)(53546011)(8936002)(38350700002)(16526019)(186003)(478600001)(26005)(83380400001)(31686004)(36756003)(38100700002)(2616005)(956004)(5660300002)(66946007)(66556008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WDB6Y0hibFZaU2Y4YUIvVllFOVZic3VINFJGZGNySk8xczUrNlh4Q25pd0hL?=
 =?utf-8?B?enVJZW82a1pTbHQzeGNuOWJLbm5MSTBaa1lnL2h5VzRkQWs4cGl4bFo2Wjlm?=
 =?utf-8?B?K0ZjZFgrOE4vNEl4enRiYUVPVXlNNEFNWVJnV0EwT1lPYzl4ejlIdHUvRGxC?=
 =?utf-8?B?ODJaMklaenN0TmU3dDh4U2tjMWdUcURBdmVYZFZrUkwxL2ZtUjM4T0lpNVB5?=
 =?utf-8?B?U01Na2tNWnlxYkdzVUFWc2FkTzBTcUEzYzFRVmUzbDJITTVyZmRkSTRNUDV1?=
 =?utf-8?B?ZFRaS05QOVRTd0RXQ1FvRlVLdEJMQ3RGZC9hYVF0N3VyUlF4aUtqKzRTOWZT?=
 =?utf-8?B?ZW1JUlpnUTRubklIMWx2NlgvZjd0SWhrMEFXRGtEek5DY2hBK2x5QTVhR3FI?=
 =?utf-8?B?QS9kcS80T21WWW56Sk4yU3BwVW56TVNhYXdEbGd3QVppOGx3UWRnZ2s5d0ZI?=
 =?utf-8?B?QTF1bjhMY2hLTmxsZkNHR1hmYkRpVVlPc2IvUzlXclFCQWVHNWlHTEFwTnA4?=
 =?utf-8?B?cGNsUWV4TEJEa3BTZTNWOGJSRlowUUZxWmV5bjdQQVFZa25PQVI3QzNMQlFa?=
 =?utf-8?B?K2xUbVB3SkZiVGJnKzgrRFd4N0trYmZjTnEybCtGKzJtS2FaeTZiTkxQM09Z?=
 =?utf-8?B?QXArdlhpVXo1OGxlZTlNdlZQUExGKzZPMlpHOHhubDZYQ2kvMVdVOENFWGNR?=
 =?utf-8?B?cS9QbVRyOEZGWmpSb3dBUDVvVDNJZlpyV2xHT1NRSkVYWW9oNTM0M3ZZbXUw?=
 =?utf-8?B?Uk9IZ3Z0RGdFTWRGQmZUekNWdTRWQklKb0hWeFZHSHcxRHB2clMzRVczTFZk?=
 =?utf-8?B?UG5XaGlBOUNyUlltYi9Vc2FaVzloSlc2aWcxWUJBMkxFUGEvaGxWdFJyK2xo?=
 =?utf-8?B?NVczVnBrcWNpN3A2aGlnYkVnQzFMdzhFNGFvOEZYbTFLZGJGM09kSXBkWVN4?=
 =?utf-8?B?VmJTYWE3Uk9Kc0J4ZTVZbzdsMjNTVktVOExjWFBsVE9NWWw0UVpzajdiUWxM?=
 =?utf-8?B?WnBucnVsd0JnMTF5N1FpT25Wcks4S3lGRFFoVjB3WHp1WGVsTG9JK2xIejgr?=
 =?utf-8?B?SW9IQUVmdmhSMHh1YlpBTDFHSVRpOHVGSFNzNGdTaW83cWtldFJvWXlyVXlI?=
 =?utf-8?B?VU56b2toYTBqNy9EUklYWlpwTXp6Qy9HUE9KYVJpaWNPbUVkMnR4b2pQTGk1?=
 =?utf-8?B?aFJoUXNJMjM4aFJhdnlMK3Y5WFQ1UEZmdTZVaEYzUWhrd3F1YVA3QS9TeFl4?=
 =?utf-8?B?bEFiUHladGs2VmpianFIVllZUUVINXJGd0VlZ3daTTlIeStHdXlhb01GWjI3?=
 =?utf-8?B?cUJqeVBRNW1TbmVtWER3WDFQSm1HSzJVbnlIKzVpbjd4REV1UlhTQzBsdjBE?=
 =?utf-8?B?b0J6eGlNcGgwc1NNWGgvbEV6bUg1U0NSejU1eUphVUxJeDlKdlpMTVpEQS9l?=
 =?utf-8?B?SWdWK0Y0NDkzckVWcVptYWd4amdYVkN1akRYbmdkb2o4NkszZHZrQmFRSEZY?=
 =?utf-8?B?azFUUWV5NHQwNTBUNkVMTE84c3hEaWVQM1Q5bkJaZDFrVmhPR0lzQXVGL1Ja?=
 =?utf-8?B?M3VGRVh5cDIvUUZocElnSVRFZEJpMXZKK2FKVGJHaGhGUkpVb2dHWnBTN0ZH?=
 =?utf-8?B?bWY2TXlPcFkzZEJCNXl3R2JpbitVU1BFMzEwZlpSMXRzblZzTEVnNmIvK1By?=
 =?utf-8?B?RHVEbWlYTTFpaTYrb3hJVjRjczRYVHpYQXVuVEhaOFlrdXZrcUpTMUVOQjlP?=
 =?utf-8?Q?0fIvmVfgD+mJc9237FiGXyemYQiGE9X0QiNBWjL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1d28d6-baaf-4249-a72d-08d906565be2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 12:50:23.0189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elO1K8Si5LOMUzexXKZE6f06F5gU1kxOyKCx7ECgblssWRpnSadBO7krB4z2Uu/r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
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

UmV2aWV3ZWQtYnk6IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+ClRlc3RlZC1ieTogSmFt
ZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4KCkphbWVzCgpPbiAyMDIxLTA0LTIzIDU6MjkgYS5t
LiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBTdGFydGluZyB3aXRoIFZlZ2EgdGhlIGhhcmR3
YXJlIHN1cHBvcnRzIGNvbmN1cnJlbnQgZmx1c2hlcwo+IG9mIFZNSUQgd2hpY2ggY2FuIGJlIHVz
ZWQgdG8gaW1wbGVtZW50IHBlciBwcm9jZXNzIFZNSUQKPiBhbGxvY2F0aW9uLgo+Cj4gQnV0IGNv
bmN1cnJlbnQgZmx1c2hlcyBhcmUgbXV0dWFsIGV4Y2x1c2l2ZSB3aXRoIGJhY2sgdG8KPiBiYWNr
IFZNSUQgYWxsb2NhdGlvbnMsIGZpeCB0aGlzIHRvIGF2b2lkIGEgVk1JRCB1c2VkIGluCj4gdHdv
IHdheXMgYXQgdGhlIHNhbWUgdGltZS4KPgo+IHYyOiBkb24ndCBzZXQgcmluZyB0byBOVUxMCj4K
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWRzLmMgfCAx
OSArKysrKysrKysrKy0tLS0tLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYyAgfCAgNiArKysrKysKPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5oICB8ICAxICsKPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgOCBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfaWRzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWRzLmMKPiBp
bmRleCA5NGIwNjk2MzBkYjMuLmI0OTcxZTkwYjk4YyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWRzLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfaWRzLmMKPiBAQCAtMjE1LDcgKzIxNSwxMSBAQCBzdGF0aWMgaW50IGFt
ZGdwdV92bWlkX2dyYWJfaWRsZShzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwKPiAgIAkvKiBDaGVjayBp
ZiB3ZSBoYXZlIGFuIGlkbGUgVk1JRCAqLwo+ICAgCWkgPSAwOwo+ICAgCWxpc3RfZm9yX2VhY2hf
ZW50cnkoKCppZGxlKSwgJmlkX21nci0+aWRzX2xydSwgbGlzdCkgewo+IC0JCWZlbmNlc1tpXSA9
IGFtZGdwdV9zeW5jX3BlZWtfZmVuY2UoJigqaWRsZSktPmFjdGl2ZSwgcmluZyk7Cj4gKwkJLyog
RG9uJ3QgdXNlIHBlciBlbmdpbmUgYW5kIHBlciBwcm9jZXNzIFZNSUQgYXQgdGhlIHNhbWUgdGlt
ZSAqLwo+ICsJCXN0cnVjdCBhbWRncHVfcmluZyAqciA9IGFkZXYtPnZtX21hbmFnZXIuY29uY3Vy
cmVudF9mbHVzaCA/Cj4gKwkJCU5VTEwgOiByaW5nOwo+ICsKPiArCQlmZW5jZXNbaV0gPSBhbWRn
cHVfc3luY19wZWVrX2ZlbmNlKCYoKmlkbGUpLT5hY3RpdmUsIHIpOwo+ICAgCQlpZiAoIWZlbmNl
c1tpXSkKPiAgIAkJCWJyZWFrOwo+ICAgCQkrK2k7Cj4gQEAgLTI4MSw3ICsyODUsNyBAQCBzdGF0
aWMgaW50IGFtZGdwdV92bWlkX2dyYWJfcmVzZXJ2ZWQoc3RydWN0IGFtZGdwdV92bSAqdm0sCj4g
ICAJaWYgKHVwZGF0ZXMgJiYgKCppZCktPmZsdXNoZWRfdXBkYXRlcyAmJgo+ICAgCSAgICB1cGRh
dGVzLT5jb250ZXh0ID09ICgqaWQpLT5mbHVzaGVkX3VwZGF0ZXMtPmNvbnRleHQgJiYKPiAgIAkg
ICAgIWRtYV9mZW5jZV9pc19sYXRlcih1cGRhdGVzLCAoKmlkKS0+Zmx1c2hlZF91cGRhdGVzKSkK
PiAtCSAgICB1cGRhdGVzID0gTlVMTDsKPiArCQl1cGRhdGVzID0gTlVMTDsKPiAgIAo+ICAgCWlm
ICgoKmlkKS0+b3duZXIgIT0gdm0tPmltbWVkaWF0ZS5mZW5jZV9jb250ZXh0IHx8Cj4gICAJICAg
IGpvYi0+dm1fcGRfYWRkciAhPSAoKmlkKS0+cGRfZ3B1X2FkZHIgfHwKPiBAQCAtMjkwLDYgKzI5
NCwxMCBAQCBzdGF0aWMgaW50IGFtZGdwdV92bWlkX2dyYWJfcmVzZXJ2ZWQoc3RydWN0IGFtZGdw
dV92bSAqdm0sCj4gICAJICAgICAhZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKCgqaWQpLT5sYXN0X2Zs
dXNoKSkpIHsKPiAgIAkJc3RydWN0IGRtYV9mZW5jZSAqdG1wOwo+ICAgCj4gKwkJLyogRG9uJ3Qg
dXNlIHBlciBlbmdpbmUgYW5kIHBlciBwcm9jZXNzIFZNSUQgYXQgdGhlIHNhbWUgdGltZSAqLwo+
ICsJCWlmIChhZGV2LT52bV9tYW5hZ2VyLmNvbmN1cnJlbnRfZmx1c2gpCj4gKwkJCXJpbmcgPSBO
VUxMOwo+ICsKPiAgIAkJLyogdG8gcHJldmVudCBvbmUgY29udGV4dCBzdGFydmVkIGJ5IGFub3Ro
ZXIgY29udGV4dCAqLwo+ICAgCQkoKmlkKS0+cGRfZ3B1X2FkZHIgPSAwOwo+ICAgCQl0bXAgPSBh
bWRncHVfc3luY19wZWVrX2ZlbmNlKCYoKmlkKS0+YWN0aXZlLCByaW5nKTsKPiBAQCAtMzY1LDEy
ICszNzMsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bWlkX2dyYWJfdXNlZChzdHJ1Y3QgYW1kZ3B1
X3ZtICp2bSwKPiAgIAkJaWYgKHVwZGF0ZXMgJiYgKCFmbHVzaGVkIHx8IGRtYV9mZW5jZV9pc19s
YXRlcih1cGRhdGVzLCBmbHVzaGVkKSkpCj4gICAJCQluZWVkc19mbHVzaCA9IHRydWU7Cj4gICAK
PiAtCQkvKiBDb25jdXJyZW50IGZsdXNoZXMgYXJlIG9ubHkgcG9zc2libGUgc3RhcnRpbmcgd2l0
aCBWZWdhMTAgYW5kCj4gLQkJICogYXJlIGJyb2tlbiBvbiBOYXZpMTAgYW5kIE5hdmkxNC4KPiAt
CQkgKi8KPiAtCQlpZiAobmVlZHNfZmx1c2ggJiYgKGFkZXYtPmFzaWNfdHlwZSA8IENISVBfVkVH
QTEwIHx8Cj4gLQkJCQkgICAgYWRldi0+YXNpY190eXBlID09IENISVBfTkFWSTEwIHx8Cj4gLQkJ
CQkgICAgYWRldi0+YXNpY190eXBlID09IENISVBfTkFWSTE0KSkKPiArCQlpZiAobmVlZHNfZmx1
c2ggJiYgIWFkZXYtPnZtX21hbmFnZXIuY29uY3VycmVudF9mbHVzaCkKPiAgIAkJCWNvbnRpbnVl
Owo+ICAgCj4gICAJCS8qIEdvb2QsIHdlIGNhbiB1c2UgdGhpcyBWTUlELiBSZW1lbWJlciB0aGlz
IHN1Ym1pc3Npb24gYXMKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IGlu
ZGV4IGY5NWJjZGE4NDYzZi4uYWRjNDQ4MWIwNWZiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtMzE0OSw2ICszMTQ5LDEyIEBAIHZvaWQgYW1kZ3B1X3Zt
X21hbmFnZXJfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIHsKPiAgIAl1bnNp
Z25lZCBpOwo+ICAgCj4gKwkvKiBDb25jdXJyZW50IGZsdXNoZXMgYXJlIG9ubHkgcG9zc2libGUg
c3RhcnRpbmcgd2l0aCBWZWdhMTAgYW5kCj4gKwkgKiBhcmUgYnJva2VuIG9uIE5hdmkxMCBhbmQg
TmF2aTE0Lgo+ICsJICovCj4gKwlhZGV2LT52bV9tYW5hZ2VyLmNvbmN1cnJlbnRfZmx1c2ggPSAh
KGFkZXYtPmFzaWNfdHlwZSA8IENISVBfVkVHQTEwIHx8Cj4gKwkJCQkJICAgICAgYWRldi0+YXNp
Y190eXBlID09IENISVBfTkFWSTEwIHx8Cj4gKwkJCQkJICAgICAgYWRldi0+YXNpY190eXBlID09
IENISVBfTkFWSTE0KTsKPiAgIAlhbWRncHVfdm1pZF9tZ3JfaW5pdChhZGV2KTsKPiAgIAo+ICAg
CWFkZXYtPnZtX21hbmFnZXIuZmVuY2VfY29udGV4dCA9Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmgKPiBpbmRleCA4NDhlMTc1ZTk5ZmYuLjE2Mzc2M2Y4YjQxOCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaAo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCj4gQEAgLTMzMSw2ICszMzEsNyBA
QCBzdHJ1Y3QgYW1kZ3B1X3ZtX21hbmFnZXIgewo+ICAgCS8qIEhhbmRsaW5nIG9mIFZNSURzICov
Cj4gICAJc3RydWN0IGFtZGdwdV92bWlkX21ncgkJCWlkX21ncltBTURHUFVfTUFYX1ZNSFVCU107
Cj4gICAJdW5zaWduZWQgaW50CQkJCWZpcnN0X2tmZF92bWlkOwo+ICsJYm9vbAkJCQkJY29uY3Vy
cmVudF9mbHVzaDsKPiAgIAo+ICAgCS8qIEhhbmRsaW5nIG9mIFZNIGZlbmNlcyAqLwo+ICAgCXU2
NAkJCQkJZmVuY2VfY29udGV4dDsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
