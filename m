Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EAEC2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 17:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6211A6117A
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 17:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6211A6117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2C06EA9A;
	Tue, 25 May 2021 17:56:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C8E6EA99
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 17:56:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTzdNIS5TDCN9BVv0rdUz6A+2bb7i52mfkzqymaZR8+V02vjZLnvwltpKn+buZNsZqbtvA24VbJJropcOG7TJvCWFhQz0fr0JdCu+AoHzmHHIt3Ln98eFP6yKlOSbEhsXt65+gdMWXrNk2T1Hxcv1hWqLJc+Wiw93r6L3xbFNJsDrU1hCYg0cBLRvgXnUGFvp/t4ZzO96vQF3C5nu5X96KQZWlFwuvRm19H97BpEUTw7SJ9gYExy4WvDzhEjIxK5lA1lUyq32RtceHZpQdN4nNavqaMBPaObGGWrxu0xr7So39/MLkoExyYe9xAry0aHBNyf8iOVX9KuyEbv56f4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uywbqm10RPioDSXSg+KXP1i/lxlSf3m4hfmRCGzXa5U=;
 b=kym7dfHBTWgXwfIj5zx+P8UNXo7JBHQIVbMZ9qx+4+HGwglKcVZrhdOPDAwCFdXVV9fFFNvWjpGeZcT//TTciLmMBDQ7EU2sE7vuzIcViAFtKiTrdumvlW/Nlwcw+tLOHxX/8p7HOgui9Dm9qQvZeH8Fu8tr6m+efyZOcGwcS7Yzm6oD7DtDXK8CadGpymoMsBAguNm3yBHz8rMTDY8PWCFNcCOZVuT0m73/CO35iqSlu+URK+h1uhvogBjjPPzJ25qhYz0Hf+IIvhgr2NLxk1PjpYmcLyO60YQB/im79NwnTvQPFS4JDTz5oRqrVyNiwJAyNKlTMaXBaHQwhWou4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uywbqm10RPioDSXSg+KXP1i/lxlSf3m4hfmRCGzXa5U=;
 b=PUIT1LqiXiTryOQjV6YI3PgwQYb8rPryAHezvgl6LRLjTmIVX7AhfkKoOz11HHxh1grV0KA20Hv1Q0PPVnHoDupO+JB+hPdhUcfL4RtcKcK1oc+sdYb+KSXNfRn29Sn627nj5qWl1KMSqONUaPDzXbx5rMjExHdulfNWkYV59SI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM6PR12MB3801.namprd12.prod.outlook.com (2603:10b6:5:1cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 17:56:35 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510%10]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 17:56:35 +0000
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdgpu: Don't flush HDP on A+A
Message-ID: <92d943b2-7a72-e1a2-f29c-b5b54cf80d20@amd.com>
Date: Tue, 25 May 2021 13:56:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
Content-Language: en-US
X-Originating-IP: [2607:9880:2048:122:3896:81ae:189c:c63b]
X-ClientProxiedBy: YT1PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::25) To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:3896:81ae:189c:c63b]
 (2607:9880:2048:122:3896:81ae:189c:c63b) by
 YT1PR01CA0146.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27 via Frontend Transport; Tue, 25 May 2021 17:56:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98196227-48a5-4c55-e4dc-08d91fa66fd6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3801:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3801094FC86CAF3F5C3CB49F82259@DM6PR12MB3801.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:130;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBLZxzFXMt40cNMDyEFXAW1mBFJ00AYi/lXUmxI+xChNgu43hwaWC2xa2yVgb8aSC8+fMjeIqMPkTzUaD/c3F33EPskmTyYn6himnPew7rtpFYHb37x8AizPu/dBZjxtuOXNUUuLtpLS6LeMxTyoiJrTnIFNai0KFc1/CWCFIXnEFeVG2YUofJmvzRfRumKZh3ixReGF0zxuIZ83ZP575236pUOtAGAoMfvdyzcR/KBtZeyLo16mJGroPy811AAn5yHoY/Ef6mXixM4CeGqdlTtKNCPw4WbLf1Gg1LHtrliAQePtyMOgJaWgIsa1flS8c1yL/qbB76UqqpeBW1nKxSoptmm8fbVZ6HkWvc8bj+dlOwwXOGzYMsDZI4lHzG+AR68hsO5gwcZWo/yW6Qx/wfPE7+XCh06sFWL6/JqbGL4EHWaGbUyj9Kh30wlEqbQ2RzsXpqXfxkFAieM3QI0sMfpmMtptN5y89SMBYM8pjomTmmkBAVhpDp/t/YR+nOEf09dmsw2L7w1WO3bYixK6MgyuFiT1ygWygs7V3dZ8BLxbCuQYiLRhQg2FJiDaJTVPZi2Ni28uCvKfiXd+tKlMBbfIyq7vjlX6lPjFRJsJIltStfRo03eqAVJeGAdeta920zpsfRAX5ya1gSAS85G0tFVzbkaFkdtuC3On3twRF1TdgFMUejmWYr72CzEju/tU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(376002)(396003)(366004)(346002)(136003)(66946007)(316002)(5660300002)(478600001)(66556008)(2906002)(83380400001)(6486002)(4744005)(36756003)(66476007)(186003)(31686004)(16526019)(31696002)(2616005)(8676002)(86362001)(38100700002)(6916009)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WDBZZlhpRlA0T201YXk1Tzc2QlppNityWkxnSFI2NUJoVjNySVVxbzVuU2NP?=
 =?utf-8?B?VFlLaEliNlhjeFY5NVZMcDI3N1N3UG9meWZQNXp6NnJsejdzMnE5QUk4Y2dE?=
 =?utf-8?B?OXMxS0JJcnVFbTJaMU5qK1ExNEdrdS9tMWE2ZXVwMGVlMEhBbk9FVWRBelBS?=
 =?utf-8?B?anM1cVpUVmJDUEdsYTRGL1RFS0huOGV5NFhxR3BYVXhkR3gyeHRWTkRtMERP?=
 =?utf-8?B?ckQydnpTNFQyb01uWi9JUUwxOEtpYWFsT0g4cGVhTmdORkJ3QzdQQWhCeUli?=
 =?utf-8?B?WlQwejFMVnh1L0UzMXNpTmQxbU9uSnV0VC84WmQxNTkyaEVraDR1bGY1Qkl6?=
 =?utf-8?B?Q3RyWUs5ZnhIRDBQTTZiVkpvY2d1ODRManB0NWxwUjdtQW9DTjFiSjRycXFz?=
 =?utf-8?B?WkZaTFl4akJKK2Nqd3pLMytvcy8xOUM0RHlubUhmaXN0eEZJYXBpb2x4eVlm?=
 =?utf-8?B?U2owUXNpcUI0d0NwRG1TRzZJc1RabVNBMVY4bjgxczBoc0FFT29xUVdTb0dy?=
 =?utf-8?B?dThneHFYWmZJM1RYNmc0am41SldtZEJZYXIySW9SZ0tpd002T0p3WjhlUjc3?=
 =?utf-8?B?K2cxZTZwbVRNMVNwaXhJdDQ2WG1iOTk0QlpkeXBjc216MzZlV2F3MmhUU1RF?=
 =?utf-8?B?MWZRTTdEbmpiOHpid1NHdm1BVFBUQjNvcEd2V2RJMjBDaHNaMzIwRDYzOHow?=
 =?utf-8?B?Tmh3TGxNZzZRZUtETXBBL2U4Q0NyZzIxMXJ4UkJpb2lpNUNaN1JYN2pqVVYz?=
 =?utf-8?B?dHNodHRZQWVvUXJVRWthVTBvT0tHdTlwL3VwRmFqSDFURm5KdXVyZ0JXL25V?=
 =?utf-8?B?NEUxYUF6REp3OEVYUGl2c1pVZmp4ZWNKTFR6d3l3OGJDTG01M1NxeWJpWEp2?=
 =?utf-8?B?TFN0eSszMUNsaEJhSFRQWUxiOEoxc2xWeGtkeGZnSWNhNE8wazdFU1VndkdT?=
 =?utf-8?B?TGV5eGF4dVZmRForUGxZb3dSbVEzZy9tM1IzNHlXemNaNnRGMjVMZU1tdDBz?=
 =?utf-8?B?b0NSWnFmNUNncWdmaktpelhJTFNjd1FrcWp5MDFsL00rbVdsVktEODM3aElU?=
 =?utf-8?B?N00yYWtxSUhhTGFadU1TWUNsWGxhTUU0YVJOMFFQTkdEaGlwcHBlYWx5OUMr?=
 =?utf-8?B?ODlOQStpZU5JQzhmT0kxQ2lvZFZzSld5UVBwei92NGhZU21jdzc4VEs0NitT?=
 =?utf-8?B?SnJWNXlILzdSK0o4Wnp0NG9SdWxRelpmVXlEUnJRUlpUdWZuT3dqYlpsU3Rn?=
 =?utf-8?B?WnQ5MThMZ3lib05PL25rK0ZpaG80NDdHa2NkT0RyTWVkQkNhRWVnNHBNdW1T?=
 =?utf-8?B?OUNvTktoNEVhUzgzdzBFaDlUOVk3aHJYKzFWbGNFOWtXOVFLNzN1MVJQbFBu?=
 =?utf-8?B?VmZyaTI1YkdCQXpGSGYwWGcwemhMa2cwSDBEbkVKd1BhU0RBTUtjeFBtM3RP?=
 =?utf-8?B?eURDKzZTa1ZwR01PR1hTdTM3ZTdmWUtROFh1QmZlcFM1U1ZFVFNpNnhRdFFT?=
 =?utf-8?B?ZThTUElCTTFsVGgzejNsMHNTbnJiU25tbHpIMk9pZFJEMUFHcjYwVFUzYjJO?=
 =?utf-8?B?Rk9oU015dXh6VHZPSGNTL1pWMzVDVG0vWDJyb25McGRvZm5RQXZkQWpJM3hN?=
 =?utf-8?B?YWhpM0RYMmRLVHVKQ2hVQVJKNlRLR2c0Ykh5a044WmNlWGxmOEczeml6WUZu?=
 =?utf-8?B?L2RaQUdyZ1NyWFZvQWpGRG5Na1p6UXBEVWNrY1JQRzVsNmVSVWlZV2N2RnRp?=
 =?utf-8?B?Skl6WWlLVlFKVmh0UEtOOWhuWnpRZllpaFZ4NFlJMzk5TjFEU0FzaEt0bG5s?=
 =?utf-8?B?RDdJR3J1YnpEZXlnZUo0V29ZTmJvVVZUaE1pcjh0K1M4UXljMEgzQlJNWm0r?=
 =?utf-8?Q?z3xjfy+jU+aHj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98196227-48a5-4c55-e4dc-08d91fa66fd6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 17:56:35.1971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqzI65ySzBbfNON7t19Drrg10V/XzSycJ0rm4kahY8aXqGDUD/WsyU1st5ZRK9kuOLoUa7/Z6W4rLZULE1uZmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3801
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

V2l0aCBYR01JIGNvbm5lY3Rpb24gZmx1c2hpbmcgSERQIG9uIFBDSWUgaXMgdW5uZWNlc3Nhcnks
Cml0IGlzIGFsc28gdG8gb3B0aW1pemUgbWVtb3J5IGFsbG9jYXRpb24gbGF0ZW5jeS4KClNpZ25l
ZC1vZmYtYnk6IEVyaWMgSHVhbmcgPGppbmh1aWVyaWMuaHVhbmdAYW1kLmNvbT4KCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fY3B1LmMgCmIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX2NwdS5jCmluZGV4IGFjNDVkOWM3YTRlOS4u
YWVmYjNkMjkyN2Q1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm1fY3B1LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX2Nw
dS5jCkBAIC0xMDgsNiArMTA4LDggQEAgc3RhdGljIGludCBhbWRncHVfdm1fY3B1X3VwZGF0ZShz
dHJ1Y3QgCmFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwLAogwqBzdGF0aWMgaW50IGFtZGdwdV92
bV9jcHVfY29tbWl0KHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcCwKIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0
cnVjdCBkbWFfZmVuY2UgKipmZW5jZSkKIMKgeworwqDCoMKgwqDCoMKgIGlmIChwLT5hZGV2LT5n
bWMueGdtaS5jb25uZWN0ZWRfdG9fY3B1KQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gMDsKIMKgwqDCoMKgwqDCoMKgIC8qIEZsdXNoIEhEUCAqLwogwqDCoMKgwqDCoMKgwqAg
bWIoKTsKIMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9hc2ljX2ZsdXNoX2hkcChwLT5hZGV2LCBOVUxM
KTsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
