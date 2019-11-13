Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3343C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 18:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D2C206F0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 18:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D2C206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E946EDF1;
	Wed, 13 Nov 2019 18:39:28 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680046.outbound.protection.outlook.com [40.107.68.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D7356EDF1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 18:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XI87myiTOcNPIkSPWy6fuAlbeKrEOxPV62HPkltHWGqwEJPfyNgfLjZydwIRnSAjaLxzW+wiEnDR5kdOGOfndv3xwm9U0WO3qQlD1L1qBZ56hNdVQCOzcr2RJ9tFbd18xWX6oexKimoBKHZ4WVo0ksXo4LW91DbQGX21hOvw4eAkeoamxd6MXLhQjwHZOw1H/I+zA3j8y24Li34ypg+mioSHHYaW2gUjiqqmezjq+A7c9Bcldy7oAgLc3iv6HQDqXCrvdFoaXF4PX6Rvxc4YpFjm3/ipTeXa65YowMfZfiZ0ka3Xhtocxaa5HSjpeWZzJY8Hl8icDxp+L+n0WmHI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59xIL4/9eJGCNaxHWxmj8veWqwXq52Wc+he1Mbyj/JY=;
 b=f69J/IHdYb8yQXKAVN5kImjITIoL09ak3rF+QJmXzBjzXoMXkFDAtxcyrvoeWuVSw952W/LXKWUqd6t+qj/P6+SRlKUklcRxY3lzgi62Dc2UY6pXbw68G/istz+UYMsXhiqRDNLBjG6xCERZEGSGrfuvXDo4TKltPQU5b7El9bEdO282OeYfbp1c8Q9OG2A3d2vMqu3YNmK6Ce6rCkB0JyilYz7gQ+k8pQaqQE1YWnm2J5Of/W7V2EtcfmX3jL0csA2JstKrTwpemddpqi1gY3ijfOXHVdm60tHGv4UhjypfXX5Sj6UZYUVoFvTGUhL0oGVIdRzJjDjMI1pQdzCWKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3013.namprd12.prod.outlook.com (20.178.55.219) by
 BYAPR12MB3414.namprd12.prod.outlook.com (20.178.196.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Wed, 13 Nov 2019 18:39:24 +0000
Received: from BYAPR12MB3013.namprd12.prod.outlook.com
 ([fe80::1174:3feb:de01:4fb9]) by BYAPR12MB3013.namprd12.prod.outlook.com
 ([fe80::1174:3feb:de01:4fb9%6]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 18:39:24 +0000
Subject: Re: [bug report] drm/amd/display: Add MST atomic routines
To: Dan Carpenter <dan.carpenter@oracle.com>, mikita.lipski@amd.com
References: <20191113182849.7qzsh2odtr6dw2u3@kili.mountain>
From: Mikita Lipski <mlipski@amd.com>
Organization: AMD
Message-ID: <3408ea61-d82b-e321-f611-99a7e08cdf17@amd.com>
Date: Wed, 13 Nov 2019 13:39:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20191113182849.7qzsh2odtr6dw2u3@kili.mountain>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::27)
 To BYAPR12MB3013.namprd12.prod.outlook.com
 (2603:10b6:a03:a9::27)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 581fe28c-f975-40ce-2159-08d76868ce46
X-MS-TrafficTypeDiagnostic: BYAPR12MB3414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB34142081E25A9F6C11B8A968E4760@BYAPR12MB3414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0220D4B98D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(65956001)(65806001)(47776003)(6666004)(36756003)(11346002)(478600001)(58126008)(8676002)(66066001)(25786009)(3846002)(6116002)(2616005)(6512007)(6436002)(6486002)(476003)(50466002)(486006)(31696002)(446003)(23676004)(5660300002)(2486003)(36916002)(52116002)(305945005)(230700001)(7736002)(26005)(6246003)(81156014)(8936002)(186003)(229853002)(14454004)(14444005)(66556008)(66476007)(316002)(2906002)(6636002)(31686004)(99286004)(66946007)(4326008)(386003)(6506007)(53546011)(81166006)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3414;
 H:BYAPR12MB3013.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0GivIDJz/3NGcpS+JgFpfXw6QGogx02biOZRv3T/4g6ODORVOj7ZGg4BYzlydf1eajd0U6USk/thnxK8aDGsFNAuM+I4syNs4WVXHJLn6vqMlzyN/1r++Xt5QloCAQEPlHcBnNa02xr6EgB9NYBMZjW6v//HRUd/Mh2X9jYTJvZfTja/tCB/6FoPS+UkMdPFDfVXo7dEKLveGFucEv8VJ2tePdfpgWVSNCTqqfNXzl6tOt5F6uhPBxe0XNIi3j8eSvpPtYYRRCqPAOeRIP5rBYLfLoVd5wOV49JGeJ4M9eIOIoKoYvGK3EhJcHVjS1CknKqv61CY7mxBnGNNBm9dUZGihMrLUAMHtAvOouzxy3/5nPVCrT4x6IFviFfqeYsp0SK5KHsK4V6xJ6xxwUnqmN0u/zNjB6wPgo8Thj0Xr2ZMKOGzullU5Qn+B+Wac9m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581fe28c-f975-40ce-2159-08d76868ce46
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 18:39:24.5712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXXvFmo5dwUOsZgIAsnunIY10nAgOl7yGQ2UTaKpnyw9wb4/hV+6sG2yV5pabxiZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3414
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59xIL4/9eJGCNaxHWxmj8veWqwXq52Wc+he1Mbyj/JY=;
 b=CYVO/ONgAelN1728XmzfWHW8nqcmlJ8Bi6z0mbs1k+fJ4EVt272a08lIIiuRMd4XZYZgZhdzgbF7QpzIG3PdOkdqM3oPLgyK2zttt4xmJO58nni5GTR8/4jThVPAcqJzf2GLmV4Rw32UYGmAeKQTPBbkQf4LkZE+fLp/MD/J0II=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mikita.Lipski@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113183921.nRxDg9VXhir88FvIR_IcekZLdIt9iAt9Nx9-lGMA4QQ@z>

SGkgRGFuLAoKVGhlIGJ1ZyBoYXMgYmVlbiBmaXhlZCBieSB0aGUgcGF0Y2ggImRybS9hbWQvZGlz
cGxheTogRml4IHVuc2lnbmVkIAp2YXJpYWJsZSBjb21wYXJlZCB0byBsZXNzIHRoYW4gemVybyIg
YnkgR3VzdGF2byBBLiBSLiBTaWx2YQoKVGhhbmtzCgpPbiAxMy4xMS4yMDE5IDEzOjI4LCBEYW4g
Q2FycGVudGVyIHdyb3RlOgo+IEhlbGxvIE1pa2l0YSBMaXBza2ksCj4gCj4gVGhlIHBhdGNoIGI0
YzU3OGYwODM3ODogImRybS9hbWQvZGlzcGxheTogQWRkIE1TVCBhdG9taWMgcm91dGluZXMiCj4g
ZnJvbSBOb3YgNiwgMjAxOSwgbGVhZHMgdG8gdGhlIGZvbGxvd2luZyBzdGF0aWMgY2hlY2tlciB3
YXJuaW5nOgo+IAo+IAlkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uYzo0ODcwIGRtX2VuY29kZXJfaGVscGVyX2F0b21pY19jaGVjaygpCj4g
CXdhcm46IHVuc2lnbmVkICdkbV9uZXdfY29ubmVjdG9yX3N0YXRlLT52Y3BpX3Nsb3RzJyBpcyBu
ZXZlciBsZXNzIHRoYW4gemVyby4KPiAKPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+ICAgIDQ4NTEgICAgICAgICAgaWYgKCFhY29u
bmVjdG9yLT5wb3J0IHx8ICFhY29ubmVjdG9yLT5kY19zaW5rKQo+ICAgIDQ4NTIgICAgICAgICAg
ICAgICAgICByZXR1cm4gMDsKPiAgICA0ODUzCj4gICAgNDg1NCAgICAgICAgICBtc3RfcG9ydCA9
IGFjb25uZWN0b3ItPnBvcnQ7Cj4gICAgNDg1NSAgICAgICAgICBtc3RfbWdyID0gJmFjb25uZWN0
b3ItPm1zdF9wb3J0LT5tc3RfbWdyOwo+ICAgIDQ4NTYKPiAgICA0ODU3ICAgICAgICAgIGlmICgh
Y3J0Y19zdGF0ZS0+Y29ubmVjdG9yc19jaGFuZ2VkICYmICFjcnRjX3N0YXRlLT5tb2RlX2NoYW5n
ZWQpCj4gICAgNDg1OCAgICAgICAgICAgICAgICAgIHJldHVybiAwOwo+ICAgIDQ4NTkKPiAgICA0
ODYwICAgICAgICAgIGlmICghc3RhdGUtPmR1cGxpY2F0ZWQpIHsKPiAgICA0ODYxICAgICAgICAg
ICAgICAgICAgY29sb3JfZGVwdGggPSBjb252ZXJ0X2NvbG9yX2RlcHRoX2Zyb21fZGlzcGxheV9p
bmZvKGNvbm5lY3RvciwgY29ubl9zdGF0ZSk7Cj4gICAgNDg2MiAgICAgICAgICAgICAgICAgIGJw
cCA9IGNvbnZlcnRfZGNfY29sb3JfZGVwdGhfaW50b19icGMoY29sb3JfZGVwdGgpICogMzsKPiAg
ICA0ODYzICAgICAgICAgICAgICAgICAgY2xvY2sgPSBhZGp1c3RlZF9tb2RlLT5jbG9jazsKPiAg
ICA0ODY0ICAgICAgICAgICAgICAgICAgZG1fbmV3X2Nvbm5lY3Rvcl9zdGF0ZS0+cGJuID0gZHJt
X2RwX2NhbGNfcGJuX21vZGUoY2xvY2ssIGJwcCk7Cj4gICAgNDg2NSAgICAgICAgICB9Cj4gICAg
NDg2NiAgICAgICAgICBkbV9uZXdfY29ubmVjdG9yX3N0YXRlLT52Y3BpX3Nsb3RzID0gZHJtX2Rw
X2F0b21pY19maW5kX3ZjcGlfc2xvdHMoc3RhdGUsCj4gICAgNDg2NyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbXN0X21nciwKPiAgICA0ODY4ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc3RfcG9ydCwKPiAgICA0
ODY5ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkbV9uZXdfY29ubmVjdG9yX3N0YXRlLT5wYm4pOwo+ICAg
IDQ4NzAgICAgICAgICAgaWYgKGRtX25ld19jb25uZWN0b3Jfc3RhdGUtPnZjcGlfc2xvdHMgPCAw
KSB7Cj4gICAgICAgICAgICAgICAgICAgICAgXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXl4KPiBJbXBvc3NpYmxlIGNvbmRpdGlvbi4KPiAKPiAgICA0ODcxICAgICAgICAgICAg
ICAgICAgRFJNX0RFQlVHX0FUT01JQygiZmFpbGVkIGZpbmRpbmcgdmNwaSBzbG90czogJWRcbiIs
IChpbnQpZG1fbmV3X2Nvbm5lY3Rvcl9zdGF0ZS0+dmNwaV9zbG90cyk7Cj4gICAgNDg3MiAgICAg
ICAgICAgICAgICAgIHJldHVybiBkbV9uZXdfY29ubmVjdG9yX3N0YXRlLT52Y3BpX3Nsb3RzOwo+
ICAgIDQ4NzMgICAgICAgICAgfQo+ICAgIDQ4NzQgICAgICAgICAgcmV0dXJuIDA7Cj4gICAgNDg3
NSAgfQo+IAo+IHJlZ2FyZHMsCj4gZGFuIGNhcnBlbnRlcgo+IAoKLS0gClRoYW5rcywKTWlraXRh
IExpcHNraQpTb2Z0d2FyZSBFbmdpbmVlciwgQU1ECm1pa2l0YS5saXBza2lAYW1kLmNvbQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
