Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4551CC4708C
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 16:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2AD7613E3
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 16:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AD7613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98E4A6F5FB;
	Fri, 28 May 2021 16:26:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF416F5FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 16:26:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWL30h9w17yCa1gZm6NTqaL9Fb+QJ9nbxzEab9yBpLgzY671qWgdFzxhDQtmPsa9FuMQca6DSTibNTaiLIAWr3b+PwrDujxlqVZ6s0LLsXn8RBBgqBlwatwXoHs2Gx/7Hgk6eKAVdXTBEATP8E9AbqL86GxDJpwAtGyMgoLsqSLxRjI/46paCPAD5i0n5maNIy+VjRwPksO53anJ83AECI1TratCVqDx/MASz01rRCDjED+zqjHhziz+0nI8iPp3Q6ATfQIOJrPfeUB4fzz+MIslGEJtT1Tpd1rsrCdVGQbR5PiCNp2+Bub+BBRLgWDeH1aeii/DtD2JabFanDk4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LXXZSgJdS/sXATQzFFT6uayInwRnwY8UlZ0qCkEIEs=;
 b=Ff5kmd3kld0nT/zL0UfVx1vJ+2YTz1YZGLWwb/ApGfHu2yr+HsCIBa7+uwTM9YmN8cJtogzw5WHqL08ycEIkMVTmtZ5FfTjLzRKONa2FV3GBPGpCia3+zYa0YCty9ufR9ChqO7d0ln98uSkXcVPl1v0SsEALQp/b5MuEpMLe89c2+6HBbqBgfnCuKJ7YcgKjCOiYf6OD1S4RbCjh6CvylQqw88vcOCSJI+ydFCyZpgKUR2ICUchz0EzkFNUNMxklU8+C7Qfv8VCvwK0YMQbwozbOAccFlHxsLqJrtTwUWTWYHeumeAeK3QJwKEzwS1Uas87zxFrWoVL+2m+TYfeYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LXXZSgJdS/sXATQzFFT6uayInwRnwY8UlZ0qCkEIEs=;
 b=f8rfLgyxQ9jNJ8SKyc4POpu5cDkinMapF8Elv1wynfytcxSRBSXDd3zclv59huz4qUq6ZaNtmdMdaznkcsliPqvUC1aFfCFCdohuW2xk/9wISFcA0HSJG7Azhoxzp/Q1dgqHLfZPP7cOkCbFHE8Gu3AkHm+YM5SXRtWc6wwgwO8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:39f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 16:26:21 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 16:26:21 +0000
Subject: Re: [PATCH 1/1] drm/amd/display: WARN_ON cleanups
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 harry.wentland@amd.com
References: <20210527121448.33713-1-nirmoy.das@amd.com>
 <6d5e5cda-02b2-6357-f486-4562ac79f523@gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <670114ce-7333-0a3a-e27e-973ed03feaa6@amd.com>
Date: Fri, 28 May 2021 18:26:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <6d5e5cda-02b2-6357-f486-4562ac79f523@gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.72.6]
X-ClientProxiedBy: AM3PR07CA0060.eurprd07.prod.outlook.com
 (2603:10a6:207:4::18) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.54.68] (165.204.72.6) by
 AM3PR07CA0060.eurprd07.prod.outlook.com (2603:10a6:207:4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.9 via Frontend Transport; Fri, 28 May 2021 16:26:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c76888cf-56b6-4cfd-6ede-08d921f55465
X-MS-TrafficTypeDiagnostic: DM4PR12MB5343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53436FCCAE67ED00A2D319718B229@DM4PR12MB5343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dF21ocwSMjyQkmKETbrk+3sXT7WqrrnoNz1+7bABDUwWtoCtEtQ0U2NzVPboSNqWy5gO5lu+X4Mirag9wCi5qk/C/uGi8jsnmmUpIvqltQBaFb1GANyXJPIvDf959IxudfWt77sjHa831Z8NS0YcCzu1BkvKITedwhJk6hAgH20hGFFKKo3STn5Qs8PtbXwZgP5UGOuD1uplL2ZrfSi+YPd6sLlePAjzUpKZ4BNk9CpFPKDcVd2hBfUQo4/6uh/fWdUW2o+zRA+y6jDEhCzQ3KF638X0fl+MjAF7QSlJKr1TdgjbRordGZmLGjbR8jruHOCh184jJ4bEDxsL3VdVC4Qt+c6Mf6Liji10cqBI5nDS+1fOqiG1vzaYPaVcWBQ/49onOgYoezLIf/uUOyyvPP5ZiacOT67zXZyOQPQx8AxbaXvVi+y7wfPCNUeMr4c3iwZQsO9NaslNYrdGAH/2SXgo5zXQ4iyadCGT6ySGnBCSW+wP5AfuWPIH+TDxM53htMPmDGaMf7SJGVQo9v9M1L1mcIZ4pmvB+xX99ELvYAwEdqIPhrGBfav/8dmcJrYi1laHQH88XIpniLtaDwfMiHNHNhzRVzTmIE+z2mB/XzgI+QARSght3NbKgi81EqRDD+LaQnl3VhGMvXr7045VDx3ZKYPICN/KPmv+vUYy/HMIk7v3jlNBGuXINMnAFoALT4MnVODsdONWKxnZ6uPWoBWvpSb9LUhvHy1dijjLDFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(6486002)(956004)(6636002)(4326008)(478600001)(316002)(2906002)(8936002)(16576012)(8676002)(52116002)(16526019)(186003)(53546011)(2616005)(38350700002)(38100700002)(66556008)(66476007)(66946007)(31696002)(86362001)(31686004)(83380400001)(66574015)(26005)(6666004)(36756003)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZThraHJmYkNwNWRxckhIOTh5WHpkMHlURWJEVzJMQjdLUThIcVU3ampkU1Vr?=
 =?utf-8?B?Ri8rSHZEWmZGdWcya1lRNFBFWGtyR3M3VHlhVlZMbE9uQ2FXV3hGZ004NGZN?=
 =?utf-8?B?b0FYQlhHbDlqMXQ4ZmZnTkxiZUF3OHZHNithNkdjeVdsWWFTRkZhK1ZTRTRn?=
 =?utf-8?B?K2JjMWd3ei8wQ0dNZnN2dFZWS0hldjhhaitxUVBYOE1mWDNsMGtVbFppbXZt?=
 =?utf-8?B?ZU1hRXM1RVhhaXVnWU5Da3k5OTJza0ZFZmVtUTVGNGJOa21neU9JeTZRU3Bt?=
 =?utf-8?B?TEo3em9QSXdGS1lhTWpFQ2JRQlJPcGtWMCtGcXFGY011TnlVZlZXSkZHWnE3?=
 =?utf-8?B?TUI1ZDd4MjhuUXpwMkNFU0E0OG1rQlNycFNlTmVLVGVHMWo3NnByRHREczQx?=
 =?utf-8?B?S2ZDSXdPMnV2RENYNXQ2cm9aTGxVU09INzh5aEVzQ1BQL1h1Qld6WTlveThx?=
 =?utf-8?B?dUhZb0R4dmpqalk3SWU2SW1sbjlzUzhvUnIzQUowR1J0bVVSc01lT1ZRZGVk?=
 =?utf-8?B?SW0wRXJNNEdRZEd0Njh3V3lKWDBqVEpjMWVROG04T0pvWitEREQwNmp6a1hi?=
 =?utf-8?B?NXZXWjdob0hHbSt3MlVzbzBZNW9Kc3hMZVhyTy9NWWRaTXB0MmlNR1gwYzZi?=
 =?utf-8?B?aXdTNDVNMkZkZlYzL2taVU5pTFB4WkloK3A1QllDekdxQ1ZMeG42SnZTd2Fv?=
 =?utf-8?B?Rzlwb2FFb2NDSklVc3pON1lmRWl0a2VtZ0VIVXlvc0htT0JQWVczMEM3SWFa?=
 =?utf-8?B?N3VVSDl4Z2pnMHB3TjBsQThVMlJTSzl1NUhDWTZqbGpyQWFhR29GN3lJUFda?=
 =?utf-8?B?cG8yb293c1Z2TjlGdThGekordmVpcmNRaS9saWVpUlMybDBkSS92dXBxVUx5?=
 =?utf-8?B?VzdQc0hleTA5YUpLTWRlc0d2MTNyRXZoR0tFa3NsQUtOcm81MWZnejN1clBO?=
 =?utf-8?B?c0dUdnJ6emtpTzRnaDRBaXhqOVJ4NW5SNUFQK3hDQmNHQjhrZ0pXUFc3dFQx?=
 =?utf-8?B?NzRGOWdTdno2TkJDc1RRVldFZkdsNHcvWTRtMEZmZG9IdWNqRUZ1QnJtQnVy?=
 =?utf-8?B?ZmVWcUVuejdJSGVQbGZpMjBQTDExUWdtdzRrU2JhUEpoYStDZWk5cVRleTZr?=
 =?utf-8?B?Y3RzandkRXpNV05VTWtzd09ubWI3MU4zaUhWeDI0YjVzaXo3WlUxUHdNSW1N?=
 =?utf-8?B?bENwTDZhOXpXQzFKMmVHMGtXU0ljN0lJZ01wd0VLWXF4YnQ3aXplYVRBRXFY?=
 =?utf-8?B?eUNPSmhzeVdGUHo2ZGh6U0N6aXFXMnBPY3JvaXEyOUFyMVp1YWs0MnJlUVh6?=
 =?utf-8?B?RGVJYjdRVUI5R0YySzZWVEpkOGpKb0orMjlQRThiTDJxbjI3Nm5TaEdtbWIx?=
 =?utf-8?B?M0h3Z1IxTU5TOTN5SFhaM2V3M09tWWdMSFZDNkNGdjg5SkRLK0piMm1DclFl?=
 =?utf-8?B?Uy9JODlHbGErSDBwcnlld25tdWZhbERBd2RDWi9IY0FDVEtBYVFjZCtGN093?=
 =?utf-8?B?TmdsVFZtR2NUbUczK2l2aXF6OElyNVhvWlFEQ1BJVFZQdFd2MFUvZ1FMUEE0?=
 =?utf-8?B?WDRETEV0ZEwrQTA0MXF6cklnZjVtdXYrMGtGazR3UytJWmJJVWgwU2k1dWRB?=
 =?utf-8?B?KzFlNFA1U3orYSszNzNFU3dGeW5aWnBlNnBMblAxbW9OYlZkVG9ZbTZhUitv?=
 =?utf-8?B?dW5CK292Q2RBVG5NUnBvWlBmUDc4b3l5NExRNVlkMVBaRmN5WWlhODJPR1VT?=
 =?utf-8?Q?DzmQAm9yn2sbr3OAay6uqSMFRyL+rKED2hJUe8C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76888cf-56b6-4cfd-6ede-08d921f55465
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 16:26:21.8294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26NhZDeq6QlTU2RWwWz+P4Y07YAzLFBAncY/f7bjY1FWmUhU0/FESBIzeyW4LwT7W0YTmyiwf1ESR7E6pe0Miw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDUvMjgvMjAyMSA1OjI4IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4KPiBBbSAy
Ny4wNS4yMSB1bSAxNDoxNCBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IFV1c2UgV0FSTl9PTigpIGlu
c2lkZSBpZi1jb25kaXRpb24gd2hlbiBwb3NzaWJsZS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTmly
bW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDExICsrKystLS0tLS0tCj4+IMKg
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4+Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9k
bS5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2Rt
LmMKPj4gaW5kZXggZjJlZDUxNDg0OTgwLi43MzZlYjUzN2E4ZTQgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+PiBAQCAt
MzE1LDggKzMxNSw3IEBAIGdldF9jcnRjX2J5X290Z19pbnN0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LAo+PiDCoMKgwqDCoMKgIHN0cnVjdCBkcm1fY3J0YyAqY3J0YzsKPj4gwqDCoMKgwqDC
oCBzdHJ1Y3QgYW1kZ3B1X2NydGMgKmFtZGdwdV9jcnRjOwo+PiDCoCAtwqDCoMKgIGlmIChvdGdf
aW5zdCA9PSAtMSkgewo+PiAtwqDCoMKgwqDCoMKgwqAgV0FSTl9PTigxKTsKPj4gK8KgwqDCoCBp
ZiAoV0FSTl9PTihvdGdfaW5zdCA9PSAtMSkpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biBhZGV2LT5tb2RlX2luZm8uY3J0Y3NbMF07Cj4+IMKgwqDCoMKgwqAgfQo+Cj4gV2hpbGUgYXQg
aXQgeW91IGNvdWxkIGFsc28gZHJvcCB0aGUgZXh0cmEge30gaGVyZS4KCgpJIG1lcmdlZCBpdCB0
aGlzIG1vcm5pbmcgOi8gSSB3aWxsIHNwZWFrIHdpdGggQWxleCB0byBjbGVhbiB0aGlzIHVwLgoK
Ck5pcm1veQoKCj4KPiBBcGFydCBmcm9tIHRoYXQgcGF0Y2ggaXMgQWNrZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgCj4gPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uCj4KPiBDaHJpc3RpYW4uCj4K
Pj4gwqAgQEAgLTM5Nyw4ICszOTYsNyBAQCBzdGF0aWMgdm9pZCBkbV9wZmxpcF9oaWdoX2lycSh2
b2lkIAo+PiAqaW50ZXJydXB0X3BhcmFtcykKPj4gwqDCoMKgwqDCoCBlID0gYW1kZ3B1X2NydGMt
PmV2ZW50Owo+PiDCoMKgwqDCoMKgIGFtZGdwdV9jcnRjLT5ldmVudCA9IE5VTEw7Cj4+IMKgIC3C
oMKgwqAgaWYgKCFlKQo+PiAtwqDCoMKgwqDCoMKgwqAgV0FSTl9PTigxKTsKPj4gK8KgwqDCoCBX
QVJOX09OKCFlKTsKPj4gwqAgwqDCoMKgwqDCoCB2cnJfYWN0aXZlID0gYW1kZ3B1X2RtX3Zycl9h
Y3RpdmVfaXJxKGFtZGdwdV9jcnRjKTsKPj4gwqAgQEAgLTY2OTgsOSArNjY5Niw4IEBAIHN0YXRp
YyBpbnQgZG1fY3J0Y19oZWxwZXJfYXRvbWljX2NoZWNrKHN0cnVjdCAKPj4gZHJtX2NydGMgKmNy
dGMsCj4+IMKgIMKgwqDCoMKgwqAgZG1fdXBkYXRlX2NydGNfYWN0aXZlX3BsYW5lcyhjcnRjLCBj
cnRjX3N0YXRlKTsKPj4gwqAgLcKgwqDCoCBpZiAodW5saWtlbHkoIWRtX2NydGNfc3RhdGUtPnN0
cmVhbSAmJgo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1vZGVzZXRfcmVxdWlyZWQoY3J0
Y19zdGF0ZSwgTlVMTCwgCj4+IGRtX2NydGNfc3RhdGUtPnN0cmVhbSkpKSB7Cj4+IC3CoMKgwqDC
oMKgwqDCoCBXQVJOX09OKDEpOwo+PiArwqDCoMKgIGlmIChXQVJOX09OKHVubGlrZWx5KCFkbV9j
cnRjX3N0YXRlLT5zdHJlYW0gJiYKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtb2Rlc2V0
X3JlcXVpcmVkKGNydGNfc3RhdGUsIE5VTEwsIAo+PiBkbV9jcnRjX3N0YXRlLT5zdHJlYW0pKSkp
IHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+IMKgwqDCoMKgwqAgfQo+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
