Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C021C33CB1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 10:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E8E207FF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 10:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iABPak3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E8E207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B792A6E34D;
	Tue, 14 Jan 2020 10:21:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D4F56E34D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 10:21:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8MHYzqm+PrtCfckztAUZqg9d0829TyyUohxLBr9OBM895SAROIX50J9B2BIc1hr/icAroBx2BUqFT/DXNZGddkRwyfC/wJx8L99GJUcvkW2STDdf1G/l8wOpOPys8fXwAujknh03yzzzQlArd5HLuEJgRkzvjoIFMDDk9mgWQBbjczyovjkCFixk6PWQ04hNyHIi9arZ8PlVYGnzlEzKyeKvUp8P4gTBIu9KCb12SkCpX2vOGLMNkoE1IsEKJ1WIMZy1D+LVAsqBchYfG2d3k0ZbMrREDRcgCuENMMU2fgiPZkdHbFsN3jDPXQJQm2ZpOwalNu387M+LdvJ4KZmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7jprKiVq+xXi7xQ4vOoQDD93oTM/N9LlVNsjdLfJg4=;
 b=TQxi1bOeYVJVSCvb3rpFa3+HoNTQqdyVDmJpFPKpj7dZMyXo8s6Dy3jdi5xUlUjVCzBeBxu1YWxE9AxVBcZ/fGstmdVeLHeFD48mxialSmZ1DZr95m9Bx6fnnriyCHCDMNS8FojHu/fOxQrgHzpmikWwGEVYhYtGI5OtcbCV5Jmt7SxikaiwBk7Ahl3Nqv49zzzZH8nc/Y3oR2fkE5MrUB2tAgVfx01/aR2nBQZQyvCgzrKDb24ZOruyWDwTwbfpRYVPdVzlUdvWPHOGVKY8UNLHdiLHlNYqyJqpAx8zbiw6Lmx0HHsY0H64ITmuUSoucz5I2jSdO7ZpQ1w5+por/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7jprKiVq+xXi7xQ4vOoQDD93oTM/N9LlVNsjdLfJg4=;
 b=iABPak3NA8e6Mu1uPCYGiUb6v4BaimEb6j3MtzSwhYzQQd6xC5O3xFG5U1QsI7l+wHbdqWsciz+ZAYV+YX514uVhO4oc+2fOGAlObeoqyzshYJJO2wWz3LBgD/oZGm41emED8DPIUT4sLvM8OpzdVbddGAwj8HXRlpnob66l0/Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1403.namprd12.prod.outlook.com (10.168.239.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 10:21:54 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 10:21:53 +0000
Subject: Re: [PATCH RESEND] drm/amdgpu: error out on entity with no run queue
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200114095020.7854-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <fd2d3298-6fb0-3537-6af4-1f26b5b7ed34@amd.com>
Date: Tue, 14 Jan 2020 11:21:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200114095020.7854-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR08CA0078.eurprd08.prod.outlook.com
 (2603:10a6:205:2::49) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR08CA0078.eurprd08.prod.outlook.com (2603:10a6:205:2::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13 via Frontend Transport; Tue, 14 Jan 2020 10:21:52 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2def310a-f71a-4e2a-5c2c-08d798db9373
X-MS-TrafficTypeDiagnostic: DM5PR12MB1403:|DM5PR12MB1403:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1403D4CA2C77093D0A954CCB83340@DM5PR12MB1403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(189003)(199004)(66556008)(66946007)(66476007)(478600001)(5660300002)(8676002)(86362001)(16526019)(6666004)(81156014)(8936002)(186003)(2616005)(81166006)(52116002)(316002)(31696002)(36756003)(66574012)(2906002)(4744005)(6486002)(4326008)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1403;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HWuifdqBtdp9h1Z/odJFN5jNk1fdRHcEZ7g06laU3H7FA4jLEv6jheS3nUQz7WG8kFxWgV+NgWNvYsjhdqKddz4UJbUxzwUWFenOd4DA6tKNnonOXp1eoZPZYd08WAEqvRIe85VyHsnNl4zw11ji4P3dXd9opODGL3kO7wJg+QlDqZv23hHh6+bQTOkr1NLSaPxTkSr6ATTtlQhQMxSyPN6WBSeCRM1CbyJr2nQL7C18TslIOjW7tJfXiMVEetjcE57THhjCyNGSVKaMaWc3wm5rr1Rlebromz4vwC1+twFniXdZuvqGm/drJz0eG/4zEGhEk5qn6UY1aOonmgt8jVrqbMXmsC5vyGWlKwLRiHRZTQPtFCfLEUC5PEYlHnciKycQ+QC5ypj7nLf17pKKotIIno9ZLEuCKjTkKZ8lwPnc5NYT0+f6f4L6BbPXn396
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2def310a-f71a-4e2a-5c2c-08d798db9373
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 10:21:53.8323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FW6VMoJ3rJmIBEZTijY7iecaxLsWwWjYbYplYETrBY2FJn0afVYU4EGi8ewyrbNe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1403
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTQuMDEuMjAgdW0gMTA6NTAgc2NocmllYiA6Cj4gRGlzYWJsZWQgSFcgSVAncyBlbnRpdHkg
aW5pdGlhbGl6ZWQgd2l0aCBOVUxMIHJxLiBXZSBzaG91bGQgbm90Cj4gcHJvY2VzcyBhbnkgc3Vi
bWl0IHJlcXVlc3QgZnJvbSB1c2Vyc3BhY2UgZm9yIGEgZGlzYWJsZWQgSFcgSVAuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+CgpSZXZpZXdlZC1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIHwgNSArKysrKwo+ICAgMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2NzLmMKPiBpbmRleCA2MTQ5MTlmMjY1YjkuLjk0M2U2MDc1YmRmOSAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4gQEAgLTkxMyw2ICs5MTMsMTEgQEAgc3Rh
dGljIGludCBhbWRncHVfY3NfaWJfZmlsbChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAg
IAkJaWYgKHBhcnNlci0+ZW50aXR5ICYmIHBhcnNlci0+ZW50aXR5ICE9IGVudGl0eSkKPiAgIAkJ
CXJldHVybiAtRUlOVkFMOwo+ICAgCj4gKwkJLyogUmV0dXJuIGlmIHRoZXJlIGlzIG5vIHJ1biBx
dWV1ZSBhc3NvY2lhdGVkIHdpdGggdGhpcyBlbnRpdHkuCj4gKwkJICogUG9zc2libHkgYmVjYXVz
ZSBvZiBkaXNhYmxlZCBIVyBJUCovCj4gKwkJaWYgKGVudGl0eS0+cnEgPT0gTlVMTCkKPiArCQkJ
cmV0dXJuIC1FSU5WQUw7Cj4gKwo+ICAgCQlwYXJzZXItPmVudGl0eSA9IGVudGl0eTsKPiAgIAo+
ICAgCQlyaW5nID0gdG9fYW1kZ3B1X3JpbmcoZW50aXR5LT5ycS0+c2NoZWQpOwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
