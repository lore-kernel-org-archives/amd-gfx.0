Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D9FC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 14:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C04619BD
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 14:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C04619BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F21F6E90F;
	Tue, 30 Mar 2021 14:22:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919006E90F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 14:22:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDDwWdPKn/lNll5Fkhoq2ZG5vgab10aaxW6W3JI2dJGK30RTJo6zVMPAKHyJoOgxSTiD9KL+HpkyVwWpeoam78+5NmLLZrztQmDJDHNHtPOyExDazdSZCNMVDTEdmUkwLIfEVu29cCYA/qwdpQqDjNBASmBkk374kSQZ4oct1UXyN7wPXAD1Ovx7bjBiYrc7zs3vs8lJBc/9bjfy5vsJy5CIJ8DQqZCxiqYjqoLWjQ8DZbldq19zNfNolr+sEkiQogXUZInwmQxAcUtiVMsXR2EPGYevuwBrtxiYvH4uDbciM3g2hLz5pIdXIja3Z+umH2BXPQaPxPcU3g6Zdhshhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOSaS5PNG3en96lMe1qyCDd/EiahKDMFjxgaSaUahWU=;
 b=dd4uS9Uo2Bb8erIvX3cVrnR88aL9JeOder4gRg4P5VgGxTkEtU8CWBvUVbIh4jQh9uPsKGwF/2pPQChGYCJcnNAXGfyqxyaO8c+nKD8AvbIm/mUgcxJL+Ma7Iv10oZ+6NFVNr5rQcguRLljTDK8ywMwWFWrN2fU6+YYNaZ6LhHCdRpkfy8C/rEZ/K2fNo4okXmajwbT9RLQO8U4sVpEIUDmLvrg3ZFeFP44WQ/4oaFGu9QM4rnqWXAIJ01lt2af04mRQ6Re+2/onciOJnYSpdzDHGZm8x7AH4uoV1ZIvsAabQAKTNe0TTmvJP/z5cMZWQjuA4YABDAI/4DPwceiCjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOSaS5PNG3en96lMe1qyCDd/EiahKDMFjxgaSaUahWU=;
 b=lNIcfFPVxfG6rdiqGIIeCrir5TcczhbMuBK4C5iVic5G0fObfmTZHQLoe3Dbg50SzaA9bkBkU/6vzn/VYMCUF3eSLhMQI/01vSk5mBapy6VIKkWRHCjKASSp/pNvWI9txvobExpkbiqBRwp0VrTVe7J458eYv324jn9XOv/SGQs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 14:22:50 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 14:22:50 +0000
Subject: Re: [PATCH] drm/radeon: avoid potential null pointer access
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210330140405.14086-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a1b9d823-7169-fcdd-ce17-f34f76fa84c2@amd.com>
Date: Tue, 30 Mar 2021 16:22:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210330140405.14086-1-guchun.chen@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:8ca4:a46e:6aa7:208c]
X-ClientProxiedBy: AM4PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:205:1::48) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:8ca4:a46e:6aa7:208c]
 (2a02:908:1252:fb60:8ca4:a46e:6aa7:208c) by
 AM4PR07CA0035.eurprd07.prod.outlook.com (2603:10a6:205:1::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.16 via Frontend Transport; Tue, 30 Mar 2021 14:22:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0bd69eb0-f7d1-4898-d64e-08d8f3874c42
X-MS-TrafficTypeDiagnostic: MN2PR12MB4318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4318F3978ADFCE4675CE1B65837D9@MN2PR12MB4318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7CXD1TZ6fi0u0oYoZoYJ4fVaknXPaUMNh0DuMG3PIUSNw1947EVb/Ul+gc0gHSFOIqiljqusX0A8Fq8bxnC3/UJG1cbpm3QTWghfq0+vmhNx+xrz22dNsucDyzRnVH8EJHOL6b9dOLL37zKaD5zVM7hwLcPGLROTNjncn/KfbhKiLEBmckizx5HfyOHMBl9Qkil1E1DAe6Ar4P5mZ02DjBnmwg8qPM9EOtkTritdrZdbBAc7JwhED0SFbycR90La80b4JW+trGSc9x9CqAKgYe//FuE6rp5dZS3FwdxmA6nzGEKcm9Pgz7oV+uYgCK3PeCfhUz4nr/XOHLE6/Y1xnYBlXvTOKp1enHSgiXWCfb3iGlhVXgox/nwgEVDZVUiOZyPfMjeKDByby/MMaIQyYqG+u1DqWh8juSeSmCLARZUhBPYd/sRod7OvTcrhmxzz2hL+jKehTiys1XFVtzbIQJHXAgsu4OnuyJ4h6wJ1DlZPJxpqiodev1QR0dBy3TjQb1K4sHgJzfEwOOqMAYkxYQGz28HpRQl2cmlRSUAgEht11eLrgyNHfiY1XyxCwdOshRKkWAAjcjlhZ4lKz6qfRP5SstcBH84y+4DQLVX+BOX2q+/RhqN5mIqiD0jcgJzNR6xTWkzwRAfT4Xa7akB5lHTs5kH3yPrlOZAoIDyHzPsgaa2XQNUEV9z5zndSu714xRZYCDJQi8KJ3pbpVo88EJ4VhdnArtsnE1s+y0Nicg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(6486002)(31686004)(6666004)(83380400001)(38100700001)(2616005)(8676002)(2906002)(8936002)(316002)(4744005)(16526019)(66574015)(66476007)(186003)(66556008)(478600001)(31696002)(86362001)(52116002)(66946007)(5660300002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aFI1eHBVN0NWUTFTVW9Ma1VKZzRUSlVSaVJVTnc3Q3ZabjZqeXVTWFQ2SXJs?=
 =?utf-8?B?TlhDcUd0aWlsZ29JeUNFYzJCNnNiZmZkWVprY2hGM3BwajZkejdTclVFeWNI?=
 =?utf-8?B?bzZEQ1IrNHBsV0ZtNGlBQ2tEOS9aUUx2Vnl5RElySWJ6LzFSMStrY3hMQVQx?=
 =?utf-8?B?U1FyS1REVGtlb2RiZURoN3cyUFJjRE1XUHg5YW9ITGRlaVFsNmJsRlNTZ3RD?=
 =?utf-8?B?YzlBNWV5RVg0bUFrYkNON0tZVFR5b3NVYWdpLzBZUkJzdmdmRU9neVpoK3I0?=
 =?utf-8?B?b0J3K3c4TUQ5K3dFQzRIK1U3eUUrUXoyM3h1eUNiZTlYVGNVNkxHUmo0L241?=
 =?utf-8?B?SUh0bU10SmlMbW94SmNFQUNYbERmMmM1VDhHdGlRd3BnNG1MbFlkVUNhRDlL?=
 =?utf-8?B?WTRnVTNiSm0zaGpPNDRzcnl1UzFraXNkTC9IK293a2JLc2NVeWRKOTZuMlRN?=
 =?utf-8?B?cndFdlRZck1Gbm80N0NjeHpRRHRUZ29FaEZQTE5uckQ2RnppMGRWTzN3SjhF?=
 =?utf-8?B?RzZOOGloNTBzV1Vrc2VvSnJkV3ZHMnE5cW5icnIyR0VVR0VCMFk2WVBWNzBu?=
 =?utf-8?B?ZzhCdnhCVmlUTUtFMGU1MzNVZVB5R2d2cmlac1lmMFd3dGVNRjFkRkpUcUhO?=
 =?utf-8?B?RjRUWTloaWhlZVp6UVh2QUFlK3hRY1F5NUxXd0t3ZTMxYTQ2ODNPT0FCOXF2?=
 =?utf-8?B?K2hsejBta2MrSUg1MkhpRHFYNU50c29WdWRwVzBQSHVZRFZwVFFneWpyZXVT?=
 =?utf-8?B?NFZDZEVQQ2M3VEY5Wkxvc3kzb0tFZDJBS0RabGxYVStJR3dMV2hxekh0UnFH?=
 =?utf-8?B?d3R6RHRRVjYwSkNFZTBWUnBrZVVpa3JMVHl5cjFDZi94S1cxdjFFeWRncUg2?=
 =?utf-8?B?bjArTGwvOXZVUENWWEhzRkRPYWt2Q3hxSVZ1Z0FDb2xMZStGeENaTXhFWGZz?=
 =?utf-8?B?bFN0SUg4aWl0RksvVm0vSFptTXJHaE9yY2JYcnVmVmF1c1owWXJTNFpCQVM2?=
 =?utf-8?B?dUsvRkxWTjJPRkZUMDA4OVFDU3lxNVZvZytISzA4OCtnSGt3azlCcVh0ZmYr?=
 =?utf-8?B?YU9MTmlPS01scXd0WUlnWU9CVDMwWkxXSTlOcEF6bE5jMG9DOTJrdHpRRlJD?=
 =?utf-8?B?cUd4cENpaTY3Zy8zZnozTmFVNnJKQXc0TkVnSHFDK2xqSG5qNW1RTEo0elhK?=
 =?utf-8?B?TFFVUHFtZWNjTjAzY0I1ZHNBREpsV3d6bzNNQ2pyRmxtbVYzTVYvbWwwR1R1?=
 =?utf-8?B?bkhVVWFsSzZEbnN5ZFBvUjJIRUJIMlBia1gxQVlCQkNBalVjN0VlczEwWHpt?=
 =?utf-8?B?Ukp5d2g3aDdmQVMxZnZCWWQwTTJNWmxKRWR6YUxEUTBRenJSOFYzYUJQUFJM?=
 =?utf-8?B?RjkzWmUxdGkrVlMyUFZWRzJCVkcwWk8zajczbmk4SWZCQzJEK1g1SW05b2I3?=
 =?utf-8?B?SzVvcXFpeDhJNEZVbUY2OXRsNldDTVArK1hhdlF1a25yMVc1elY2dWNuMXZT?=
 =?utf-8?B?dEs5VFB0LzNmenA2S3o4a1hndVlEVkdIMkVmTy9IK2VNcFNOT2hQZDFTdkJ1?=
 =?utf-8?B?c0JJdkNRa2t0dDVPN1FqVnh3KzVqRHBTK3U4OGJ2MFV0eWpndXJUQjM1ZUlo?=
 =?utf-8?B?L3hIK2NXVkJ4T1Rrd25yZmgraFhwRFppdG9kZTRXQWFWNEk2QjhxSmQ5Qk9S?=
 =?utf-8?B?bm5HSWgvMTRwTDdOR3JKamsrZlFKVEVUR25qMENXOUpZR2tmUUdwVDVRRGRO?=
 =?utf-8?B?Q2hPNXdOU2IvY2NIb3AzbTEvelUwSWdVZmRpVWtmbTlybmU4MEk4NVhuc25k?=
 =?utf-8?B?M0JMekVZMjBsS3ZnQ2hYY01RYTJaM054blVYcjYvK1VOdXBxTEFxL3hzNzMx?=
 =?utf-8?Q?vYOKtCRP1Lg+J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd69eb0-f7d1-4898-d64e-08d8f3874c42
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 14:22:50.0767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zu/YpIczVpGd0u5frrMilXV35vGVnO8Z9zKBv4Z2cPePo4iujVMZpK3zFrgkKxij
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
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

QW0gMzAuMDMuMjEgdW0gMTY6MDQgc2NocmllYiBHdWNodW4gQ2hlbjoKPiBMZXZlcmFnZSB0aGUg
c2FtZSBsb2dpYyBmcm9tIGFtZGdwdV90dG1fdHRfdW5waW5fdXNlcnB0ci4KPgo+IFNpZ25lZC1v
ZmYtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRl
b25fdHRtLmMKPiBpbmRleCAzN2FjNDJkNjc0MGYuLjJhNjFjZmYzMjVlNCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX3R0bS5jCj4gQEAgLTQxNSw3ICs0MTUsNyBAQCBzdGF0aWMgdm9p
ZCByYWRlb25fdHRtX3R0X3VucGluX3VzZXJwdHIoc3RydWN0IHR0bV9kZXZpY2UgKmJkZXYsIHN0
cnVjdCB0dG1fdHQgKgo+ICAgCQlETUFfQklESVJFQ1RJT05BTCA6IERNQV9UT19ERVZJQ0U7Cj4g
ICAKPiAgIAkvKiBkb3VibGUgY2hlY2sgdGhhdCB3ZSBkb24ndCBmcmVlIHRoZSB0YWJsZSB0d2lj
ZSAqLwo+IC0JaWYgKCF0dG0tPnNnLT5zZ2wpCj4gKwlpZiAoIXR0bS0+c2cgfHwgIXR0bS0+c2ct
PnNnbCkKPiAgIAkJcmV0dXJuOwo+ICAgCj4gICAJLyogZnJlZSB0aGUgc2cgdGFibGUgYW5kIHBh
Z2VzIGFnYWluICovCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
