Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015D7C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 13:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919AB20784
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 13:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gJjWj+eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919AB20784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3442E6E0F3;
	Tue, 31 Mar 2020 13:57:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55E9F6E0F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 13:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ad6Kv6PWVQFyFd1R4kdYp0HELpEya6Tm+xlfqdjn53fDxWNzJfGdZ5dPdjJPgB+av+q8CLsRmDmacz1WMCd69xGyGcK4MVCA2pYNPITeWKXLqZIRV+GVFn2wpvNByafNnJTWjdEDRR7SqyaEaXPq9rYHHzlhT96KqRVCwJ8blzqWcVMvxJzisJMamZypy7jAaJs2+kReJRU6TSp6m8xvkiaHKPKHSX94X4Oq35Pei7yXk+yfguGmQquVfDUY8F1IVTwJqEeiL62nVCULDZxUG7Yd0rmaHO2rooY4/byOUqdDnAGw0YXB1/xwN4npQOSQ69HeICHnCnT9lFmZFiVqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2Nh5L791huNoZxpOBakJbDDxrie1a2U0qpTuUzm8Ao=;
 b=Dj0dCwtshYSU0i5njlLs9eDlWBMyhopp296zUobkx+WwZrskOSQrI14RouITajDFjs2F8ngKTiiuTLlgMP8U1+LcnetH0HLAuM9OnDRmle6APWx0NvHgj1ckapdpFFfXT2aI2J1aE+RoHHOiHz4sL8aIEx+wAY/hvPiJWhgtOoZGAs+LjfFIIg/e1MyjmHqCKmuJU0d3Yh9YnLe20n17qP6BSWEaJYnvRSSXho1sKwWjoRypZM6XaAhkOj/uLBHPuPbZN88+leMSf1G0WkiOP9Le/16bADtZHRdLR4tv5Hul3jaybMEaY2uH3sLZzvp90jD1UCUfAfNjBX4uq9W4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2Nh5L791huNoZxpOBakJbDDxrie1a2U0qpTuUzm8Ao=;
 b=gJjWj+egf6O7WPPonFwMColgAITytdq44rkNNndQe4AZHQI6m2I7fMUwXf39NXDtOu3TynO6Dy/vqwW+dQ7WrhYMG7VpfrdXUEuXOfOCdn/JX8hr+yjiVwmbArbvHbqgk0O3z4nDf040+zpKF7m6JlhJx704734ToB6pCtdxEbU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3257.namprd12.prod.outlook.com (2603:10b6:5:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 13:56:59 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2%4]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 13:56:58 +0000
Subject: Re: [PATCH v2 1/2] drm/amdgpu: sync ring type and drm hw_ip type
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200331135905.13045-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <228140f6-41e8-ebe4-4407-d54cb9b8c809@amd.com>
Date: Tue, 31 Mar 2020 15:56:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200331135905.13045-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0093.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::34) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR06CA0093.eurprd06.prod.outlook.com (2603:10a6:208:fa::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Tue, 31 Mar 2020 13:56:57 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69f70585-bcd3-4952-ce49-08d7d57b6140
X-MS-TrafficTypeDiagnostic: DM6PR12MB3257:|DM6PR12MB3257:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3257BDB33AE4C9CA8ECEE2A683C80@DM6PR12MB3257.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:95;
X-Forefront-PRVS: 0359162B6D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(6666004)(31696002)(478600001)(86362001)(81166006)(8676002)(16526019)(81156014)(2616005)(8936002)(186003)(36756003)(52116002)(5660300002)(6486002)(4326008)(2906002)(66556008)(66476007)(316002)(31686004)(66946007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZouZ3y4AM5txhcZ8MteO9wkmaFklJvg6wIe+XZJeDv/qshq/yPG/Qc4Zo6PjmIp+DQ1QCaNmsGYzs7b2eXeLUe56qH7aZWQsFhEpS5RM3H0wWj7A2T7ko79hkzcgtVlbg84ffS24dv7VngiBpqfH5xCqEWX64BXTwA+/3axnj36DdDARUkHL6OP49a/cFOAvSjuExHBlI3ruuY4MIidF7gJQxQpc0nfsGFYOhlpLsLew9jU6rewOpF8Qx+NAjOHozUFaZT3Fcxe0H+kc4/+nnsP+yWSWF4ct8hY6kB5WnWn7YF9Ism23N32JQ+i5UDBDEzWa4SsYSANl0x4ZEvFWwT/R8KKvjAMb/6EFgjeO8Rx31RjE5L/yi6oZ6PyIMREfuXQJku30gkPyJQ0dhBDxyu6C4558HF0IqTSz0K2eY5qoUWphXiEpTjHVwZR7pww
X-MS-Exchange-AntiSpam-MessageData: i5T1GSd7c6ves77owU/x99xGrGWgDPLGZHHYD0/HyX6VSuSnub+vVCHDE0zBagRSPYHI9z2e1G4kiRVNIAj23i4gi8JACFzv/QEtNWt/7RogeafsWDC2wd+dQzV5STJwEuuhBFwF8/sro79m6Fbz1FgfGBax06T50IsqGCEw3xuj1o6J+LMLK+ufyb4vJSkMmjId2+9ttF50SBJUoPDPDw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f70585-bcd3-4952-ce49-08d7d57b6140
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 13:56:58.7954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adA4kkVrxKxIG4oN8cmxi0eko4mGcAMN2coswu/NsJXutuei6wCZKhT0WsAOcREL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMzEuMDMuMjAgdW0gMTU6NTkgc2NocmllYiBOaXJtb3kgRGFzOgo+IFVzZSBBTURHUFVfSFdf
SVBfKiB0byBzZXQgYW1kZ3B1X3JpbmdfdHlwZSBlbnVtIHZhbHVlcwo+Cj4gU2lnbmVkLW9mZi1i
eTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oIHwgMjAgKysrKysrKysrKy0tLS0tLS0tLS0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuaAo+IGluZGV4IDA4MDAyNGQy
MWQzZS4uNTBhYmM2M2Y3Y2M1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yaW5nLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmluZy5oCj4gQEAgLTQ3LDE2ICs0NywxNiBAQAo+ICAgI2RlZmluZSB0b19hbWRncHVfcmlu
ZyhzKSBjb250YWluZXJfb2YoKHMpLCBzdHJ1Y3QgYW1kZ3B1X3JpbmcsIHNjaGVkKQo+Cj4gICBl
bnVtIGFtZGdwdV9yaW5nX3R5cGUgewo+IC0JQU1ER1BVX1JJTkdfVFlQRV9HRlgsCj4gLQlBTURH
UFVfUklOR19UWVBFX0NPTVBVVEUsCj4gLQlBTURHUFVfUklOR19UWVBFX1NETUEsCj4gLQlBTURH
UFVfUklOR19UWVBFX1VWRCwKPiAtCUFNREdQVV9SSU5HX1RZUEVfVkNFLAo+IC0JQU1ER1BVX1JJ
TkdfVFlQRV9LSVEsCj4gLQlBTURHUFVfUklOR19UWVBFX1VWRF9FTkMsCj4gLQlBTURHUFVfUklO
R19UWVBFX1ZDTl9ERUMsCj4gLQlBTURHUFVfUklOR19UWVBFX1ZDTl9FTkMsCj4gLQlBTURHUFVf
UklOR19UWVBFX1ZDTl9KUEVHCj4gKwlBTURHUFVfUklOR19UWVBFX0dGWAkJPSBBTURHUFVfSFdf
SVBfR0ZYLAo+ICsJQU1ER1BVX1JJTkdfVFlQRV9DT01QVVRFCT0gQU1ER1BVX0hXX0lQX0NPTVBV
VEUsCj4gKwlBTURHUFVfUklOR19UWVBFX1NETUEJCT0gQU1ER1BVX0hXX0lQX0RNQSwKPiArCUFN
REdQVV9SSU5HX1RZUEVfVVZECQk9IEFNREdQVV9IV19JUF9VVkQsCj4gKwlBTURHUFVfUklOR19U
WVBFX1ZDRQkJPSBBTURHUFVfSFdfSVBfVkNFLAo+ICsJQU1ER1BVX1JJTkdfVFlQRV9VVkRfRU5D
CT0gQU1ER1BVX0hXX0lQX1VWRF9FTkMsCj4gKwlBTURHUFVfUklOR19UWVBFX1ZDTl9ERUMJPSBB
TURHUFVfSFdfSVBfVkNOX0RFQywKPiArCUFNREdQVV9SSU5HX1RZUEVfVkNOX0VOQwk9IEFNREdQ
VV9IV19JUF9WQ05fRU5DLAo+ICsJQU1ER1BVX1JJTkdfVFlQRV9WQ05fSlBFRwk9IEFNREdQVV9I
V19JUF9WQ05fSlBFRywKPiArCUFNREdQVV9SSU5HX1RZUEVfS0lRCj4gICB9Owo+Cj4gICBzdHJ1
Y3QgYW1kZ3B1X2RldmljZTsKPiAtLQo+IDIuMjUuMQo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
