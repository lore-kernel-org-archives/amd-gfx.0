Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE6FC4742C
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 14:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E7E21734
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 14:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AvD7Msz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E7E21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A62E6ED15;
	Wed,  4 Nov 2020 14:12:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E822D6E091
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 14:12:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3JLN2wcSY+EE8vyw2nNj2+s7Fc3GtGfYoyBu0wi3arcS3//dZkZjv7JI3T4wg3iART7yRRdtpfUVcUdJQukgw31fYn1Ukl8KWC81Z3G7Zd815celKtqA3JxLwFKYnrY4PiQUcB3Bv6xSUg5TcaK5ECS/C9lLT5SWkeQTUdSjSDC5GKOmKVXNx8od7vNATSKqOdtGK2z98pwfoC49alLVoOyKBzdifSnfsqtwxD1lFW3uAoFnlUFx4UKW/57E1Xr/+2ED9rkqiiSBgqBFwCoLCJ092wzfebdt8EKyeYrRqQq8fN1XupEdCp1qBH29p8HYav0agJH8Z1isF+znPcfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T61Zqb3FpEhWn8N62kY0C8ZftF8dbZ1by59Fjirqk+Q=;
 b=MvY+tSXgb+/RZiwTH7oeSf3z0TOWKwy71BzNFBo1SOmLIAFCsQIbgLS9b426TD8G88mAityDSCNLV9sUIXf/xuTT8SQzyAZBHck8kT0wLy4Krxv+h8fHmYgeSBACHjK43G7yluAYVrPI2bt8ORm2G13PP/fioUxI+HDo53pDdiorNC9iaeJRUKDCFgUahdMezaPJB9BUsW3a675v/8BULYeuS9SVHlKWsrKzq770oksUEWrS7VWEVkWy08FqtRQqaYgqnRV/wORV+XBU4n7Cdz0xL8q6E/3ibUJll3ur7KLcSAXs9jhRjFgK4MhKjkjC4xKOpEFfjSR1dOSiA7zFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T61Zqb3FpEhWn8N62kY0C8ZftF8dbZ1by59Fjirqk+Q=;
 b=AvD7Msz4HCaChl9eerH3VRNyW++HtRcb1pL9OPpt/zjRDV1IVlEQUSfgfSodGX9ZR/iizqAiy1WOeXRzLQa1qNeFcp160L+olxQFs9iXfBoU7wqS75CyNp8p51o6H8p2VX4mwp9b6V4hRiRvoKleB++XzD80bAcjS9aiHEnE+oY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 14:12:07 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::e89a:3b9a:e967:3a0c]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::e89a:3b9a:e967:3a0c%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 14:12:07 +0000
Subject: Re: [PATCH] drm/amdgpu: clip the ref divider max value at 100
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201103171340.2978395-1-shashank.sharma@amd.com>
 <7f9cc1a0-ad6b-ee9b-ac7b-4a49d08de1f9@amd.com>
 <MN2PR12MB3133BFD54B552B19A512B27CF2EF0@MN2PR12MB3133.namprd12.prod.outlook.com>
 <211bb89a-4433-3fb8-7849-6323cafe20fb@amd.com>
 <MN2PR12MB448848FEEB5717DDCF66F601F7EF0@MN2PR12MB4488.namprd12.prod.outlook.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <b6e345a7-5547-2026-313c-739833c5013f@amd.com>
Date: Wed, 4 Nov 2020 19:41:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <MN2PR12MB448848FEEB5717DDCF66F601F7EF0@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [106.51.107.229]
X-ClientProxiedBy: MA1PR0101CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::19) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.113] (106.51.107.229) by
 MA1PR0101CA0057.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 4 Nov 2020 14:12:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8cdc2194-43b0-46ae-814d-08d880cb9cc3
X-MS-TrafficTypeDiagnostic: BY5PR12MB4888:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4888F562FB6D41AEF87F058AF2EF0@BY5PR12MB4888.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8H8hQ5zYumFuDDCgUbhjeoVs4VmAijygbdofhHgncdoHlTqFpXR3m2956ALY2BkLayQnALB5UzNYHAJu5kHwiAGFzGrebc9G6jvRmrkAscqto2kikUoxDlSowiwdPh8nZKnVlJMmmCxkNT7f+jDEQEasbQ/Yb0IlbPRVFyUF98iFYQV/tBirX3VbBBc2zwqn1SNGlMyL2Ug7oKvQaMctXKzemJyif0HMwalMf0M9Fhn1ZNeSfjr3nLh1eTzj10VXmNaBhgo28nWfZbPOJg1/FFvoVQ4hVqyT0Ys/wCVLooNKoCRjZcDx64mMFrAB5DYiN5Z4Pj8C+fLMRsycveSkPz6JRm3H6D+s3K9fKYcUzseAWD9TOsit0VlGmaDDFHEEZKpGYBPCO+xqIImyUruPKJPhtctu18zKdG7o0HQ83nwvKHuSn/Z2nrTa8ArX+DWfJIbmKucFYTvDPQZoZbOmdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(316002)(2616005)(66946007)(2906002)(66556008)(66476007)(956004)(86362001)(52116002)(1006002)(31686004)(6666004)(166002)(16526019)(26005)(19627405001)(8676002)(8936002)(30864003)(66574015)(5660300002)(55236004)(33964004)(53546011)(31696002)(36756003)(966005)(16576012)(110136005)(4326008)(83380400001)(6486002)(186003)(478600001)(44832011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: X1Fj33Afs5AFf+2lp7ONNYzZh2x0wmOmDU7s17u+gn6iRw+N0CUW6yjJz67ds30ZdqmgamLI4EH5Hj6WFi4NC0w4w3FTQZzVrWjmcUSrOKS42Yk2Odpm7PFdTCRC2ZitFjoPsTFTcu68q+IEUSOeRJs6/aj+Itmtif3FFclz9Tp30KzGPCYJfP4Tum+aBMaK96LKiaJrWtmxWiYBNbFN0yZATaJ0mmgxLzVnpozufd4UGML1WCWv0WZ70lvdfwZHICqeT11Jh8nizsCvER3y59hiSBr2532Z7P5O1q6y110Yn2rqujT0KUDllmetHsJbo3qqMk8GMtTEThBReJAPh6DQphhDNR7suMa2jjIjXAX8bypz3OrSsPxpQb2tnS++z4s2c1q2eZWA5+zdAdkyxhkW6QnOFvtTHeB8wlE5qZZ+IntXJc7ELc42Qzy1O59slDkWXAYpHlRG7L/iF8bTiAwp9kW9ocLjgA23t4XGHaoxLzm/GtH5tLj7VY/14uLEt7BThP2HWSpkUN1/OcjV6qpwgPBsAjYF8PjF/3sOPC7CZYoENSmT9gzvE6sqxit6ZSq+E5kJqI7nY/Aj0H8/9b8H+gt+iQwcLrG2X0bfQ4z332ephGcJ1bcc9ODNzxusAlm4Y8Jc/iUCMqnUvYbvrA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdc2194-43b0-46ae-814d-08d880cb9cc3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 14:12:07.3497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOhLXEOtfhIzScooSBq1jCpIBEx63NkbSp8rzpE3m3ECfqg+iINWQNaSAaPsWtm+kXtAwqv9JQLaK5dcbFycHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
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
Cc: "Qin, Eddy" <Eddy.Qin@amd.com>
Content-Type: multipart/mixed; boundary="===============2044787123=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2044787123==
Content-Type: multipart/alternative;
 boundary="------------CBA95B948AA58EF56373469D"
Content-Language: en-US

--------------CBA95B948AA58EF56373469D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

VGhhbmtzIEFsZXgsIFNhbWUgcXVlc3Rpb24gaGVyZSwKClNob3VsZCB3ZSBnbyB0aHJvdWdo
IHNvbWUgZXh0ZW5zaXZlIHRlc3Qgcm91dGluZSBkdWUgdG8gY2hhbmdlIGluIFBMTCB2YWx1
ZXMsIG9yIGlzIGl0IE9LIHRvIGdvIGFoZWFkIGJhc2VkIG9uIG91ciBleHBlcmllbmNlIGZy
b20gUmFkZW9uIHZhbHVlcyA/CgoKUmVnYXJkcwoKU2hhc2hhbmsKCgpPbiAwNC8xMS8yMCA3
OjM2IHBtLCBEZXVjaGVyLCBBbGV4YW5kZXIgd3JvdGU6Cj4gQWNrZWQtYnk6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
PiAqRnJvbToqIEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
Cj4gKlNlbnQ6KiBXZWRuZXNkYXksIE5vdmVtYmVyIDQsIDIwMjAgNjo1NCBBTQo+ICpUbzoq
IFNoYXJtYSwgU2hhc2hhbmsgPFNoYXNoYW5rLlNoYXJtYUBhbWQuY29tPjsgYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPgo+
ICpDYzoqIERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IFFpbiwgRWRkeSA8RWRkeS5RaW5AYW1kLmNvbT4KPiAqU3ViamVjdDoqIFJlOiBbUEFUQ0hd
IGRybS9hbWRncHU6IGNsaXAgdGhlIHJlZiBkaXZpZGVyIG1heCB2YWx1ZSBhdCAxMDAKPiDC
oAo+IEFtIDA0LjExLjIwIHVtIDExOjQwIHNjaHJpZWIgU2hhcm1hLCBTaGFzaGFuazoKPiA+
IFtBTUQgUHVibGljIFVzZV0KPiA+Cj4gPiBIZWxsbyBDaHJpc3RpYW4sCj4gPiBZZXMsIHRo
YXQgMTAwIGlzIGhhcmRjb2RlZCBpbiBSYWRlb24sIGFuZCBnaXQgYmxhbWUgc2F5cyBpdCB3
YXMgb25lIG9mIHlvdXIgcGF0Y2hlcyB3aGljaCBtYWRlIGl0IDEwMCBmcm9tIDEyOCDwn5iK
Lgo+ID4gV291bGQgeW91IG1pbmQgaGF2aW5nIGEgbG9vayBhdCBjb21taXQgaWQ6IDRiMjFj
ZTFiNGI1ZDI2MmU3ZDQ2NTZiOGVjZWNjODkxZmMzY2I4MDYgPwo+Cj4gQWgsIHllcyB0aGF0
IG9uZSA6KQo+Cj4gWWVhaCB0aGUgYmFja2dyb3VuZCBpcyB0aGF0IHRoaXMgd2FzIGp1c3Qg
YW4gZWR1Y2F0ZWQgZ3Vlc3MgYmVjYXVzZSBJCj4gY291bGRuJ3QgZmluZCBhbnlib2R5IHdo
aWNoIGNvdWxkIHRlbGwgbWUgd2hhdCB0aGUgcmVhbCBsaW1pdHMgb2YgdGhlCj4gUExMIGlz
Lgo+Cj4gTG9va3MgbGlrZSB3ZSBqdXN0IGZvcmdvdCB0byBhcHBseSB0aGF0IHBhdGNoIHRv
IGFtZGdwdS4KPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4gPgo+ID4gUmVnYXJkcwo+
ID4gU2hhc2hhbmsKPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiBGcm9tOiBL
b2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPgo+ID4gU2VudDog
V2VkbmVzZGF5LCBOb3ZlbWJlciA0LCAyMDIwIDM6MzUgUE0KPiA+IFRvOiBTaGFybWEsIFNo
YXNoYW5rIDxTaGFzaGFuay5TaGFybWFAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4gPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPjsgUWluLCBFZGR5IDxFZGR5LlFpbkBhbWQuY29tPgo+ID4gU3ViamVjdDog
UmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogY2xpcCB0aGUgcmVmIGRpdmlkZXIgbWF4IHZhbHVl
IGF0IDEwMAo+ID4KPiA+IEFtIDAzLjExLjIwIHVtIDE4OjEzIHNjaHJpZWIgU2hhc2hhbmsg
U2hhcm1hOgo+ID4+IFRoaXMgcGF0Y2ggbGltaXRzIHRoZSByZWZfZGl2X21heCB2YWx1ZSB0
byAxMDAsIGR1cmluZyB0aGUgY2FsY3VsYXRpb24KPiA+PiBvZiBQTEwgZmVlZGJhY2sgcmVm
ZXJlbmNlIGRpdmlkZXIuIFdpdGggY3VycmVudCB2YWx1ZSAoMTI4KSwgdGhlCj4gPj4gcHJv
ZHVjZWQgZmJfcmVmX2RpdiB2YWx1ZSBnZW5lcmF0ZXMgdW5zdGFibGUgb3V0cHV0IGF0IHBh
cnRpY3VsYXIKPiA+PiBmcmVxdWVuY2llcy4gUmFkZW9uIGRyaXZlciBsaW1pdHMgdGhpcyB2
YWx1ZSBhdCAxMDAuCj4gPiBNaG0sIGlzIHRoYXQgMTAwIGhhcmQgY29kZWQgaW4gcmFkZW9u
PyBJIGhhdmUgbm8gaWRlYSB3aGVyZSB0aGF0IGlzIGNvbWluZyBmcm9tLgo+ID4KPiA+IEJl
c3Qgd291bGQgcHJvYmFibHkgdG8gZ3JhYiBhIGhhcmR3YXJlIGVuZ2luZWVyIGFuZCB0cnkg
dG8gZmlndXJlIG91dCB3aGF0IHRoZSByZWFsIG1heGltdW1zIGZvciB0aGUgUExMIGlzIHRv
IHN0aWxsIHByb2R1Y2UgYSBzdGFibGUgc2lnbmFsLgo+ID4KPiA+IENocmlzdGlhbi4KPiA+
Cj4gPj4gT24gT2xhbmQsIHdoZW4gd2UgdHJ5IHRvIHNldHVwIG1vZGUgMjA0OHgxMjgwQDYw
IChhIGJpdCB3ZWlyZCwgSQo+ID4+IGtub3cpLCBpdCBkZW1hbmRzIGEgY2xvY2sgb2YgMjIx
MjcwIEtoei4gSXQncyBiZWVuIG9ic2VydmVkIHRoYXQgdGhlCj4gPj4gUExMIGNhbGN1bGF0
aW9ucyB1c2luZyB2YWx1ZXMgMTI4IGFuZCAxMDAgYXJlIHZhc3RseSBkaWZmZXJlbnQsIGFu
ZAo+ID4+IGxvb2sgbGlrZSB0aGlzOgo+ID4+Cj4gPj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsKPiA+PiB8UGFyYW1ldGVywqDCoMKgIHxBTURHUFXC
oMKgwqDCoMKgwqDCoCB8UmFkZW9uwqDCoMKgwqDCoMKgIHwKPiA+PiB8wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwKPiA+PiArLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tKwo+ID4+IHxDbG9jayBmZWVkYmFja8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfAo+ID4+IHxkaXZpZGVyIG1heMKgIHzC
oCAxMjjCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEwMMKgwqDCoMKgwqDCoCB8Cj4gPj4gfGNh
cCB2YWx1ZcKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8Cj4gPj4gfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gPj4g
fMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gPj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsKPiA+PiB8cmVmX2Rpdl9tYXjCoCB8wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gPj4gfMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNDLCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIw
wqDCoMKgwqDCoMKgwqDCoCB8Cj4gPj4gfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4g
Pj4gfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gPj4gKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsKPiA+PiB8cmVmX2RpdsKgwqDCoMKgwqAgfMKg
IDQywqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyMMKgwqDCoMKgwqDCoMKgwqAgfAo+ID4+IHzC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfAo+ID4+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0rCj4gPj4gfGZiX2RpdsKgwqDCoMKgwqDCoCB8wqAgMTAz
MjbCoMKgwqDCoMKgwqAgfMKgIDgxOTXCoMKgwqDCoMKgwqAgfAo+ID4+ICstLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rCj4gPj4gfGZiX2RpdsKgwqDCoMKg
wqDCoCB8wqAgMTAyNMKgwqDCoMKgwqDCoMKgIHzCoCAxNjPCoMKgwqDCoMKgwqDCoCB8Cj4g
Pj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsKPiA+PiB8
ZmJfZGV2X3DCoMKgwqDCoCB8wqAgNMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA5wqDCoMKg
wqDCoMKgwqDCoMKgIHwKPiA+PiB8ZnJhYyBmYl9kZV5fcHzCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwKPiA+PiArLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tKwo+ID4+Cj4gPj4gV2l0aCByZWZfZGl2
X21heCB2YWx1ZSBjbGlwcGVkIGF0IDEwMCwgQU1ER1BVIGRyaXZlciBjYW4gYWxzbyBkcml2
ZQo+ID4+IHZpZGVtb2RlIDIwNDh4MTI4MEA2MCAoMjIxTWh6KSBhbmQgcHJvZHVjZSBwcm9w
ZXIgb3V0cHV0IHdpdGhvdXQgYW55Cj4gPj4gYmxhbmtpbmcgYW5kIGRpc3RvcnRpb24gb24g
dGhlIHNjcmVlbi4KPiA+Pgo+ID4+IFBTOiBUaGlzIHZhbHVlIHdhcyBjaGFuZ2VkIGZyb20g
MTI4IHRvIDEwMCBpbiBSYWRlb24gZHJpdmVyIGFsc28sIGhlcmU6Cj4gPj4gaHR0cHM6Ly9n
aXRodWIuY29tL2ZyZWVkZXNrdG9wL2RybS10aXAvY29tbWl0LzRiMjFjZTFiNGI1ZDI2MmU3
ZDQ2NTZiOCA8aHR0cHM6Ly9naXRodWIuY29tL2ZyZWVkZXNrdG9wL2RybS10aXAvY29tbWl0
LzRiMjFjZTFiNGI1ZDI2MmU3ZDQ2NTZiOD4KPiA+PiBlY2VjYzg5MWZjM2NiODA2Cj4gPj4K
PiA+PiBDYzogQWxleCBEZXVjaGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPgo+ID4+
IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gPj4g
Q2M6IEVkZHkgUWluIDxFZGR5LlFpbkBhbWQuY29tPgo+ID4+Cj4gPj4gU2lnbmVkLW9mZi1i
eTogU2hhc2hhbmsgU2hhcm1hIDxzaGFzaGFuay5zaGFybWFAYW1kLmNvbT4KPiA+PiAtLS0K
PiA+PsKgwqDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcGxsLmMgfCAy
ICstCj4gPj7CoMKgwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3BsbC5jCj4gPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcGxsLmMKPiA+PiBpbmRleCAxZjIzMDViN2JkMTMuLjIzYTJlMWViZjc4YSAxMDA2NDQK
PiA+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcGxsLmMKPiA+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcGxsLmMKPiA+PiBA
QCAtODUsNyArODUsNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfcGxsX2dldF9mYl9yZWZfZGl2
KHVuc2lnbmVkIG5vbSwgdW5zaWduZWQgZGVuLCB1bnNpZ25lZCBwb3N0Xwo+ID4+wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHVuc2lnbmVkICpmYl9kaXYsIHVuc2lnbmVkICpyZWZfZGl2KQo+ID4+
wqDCoMKgIHsKPiA+PsKgwqDCoMKgwqDCoCAvKiBsaW1pdCByZWZlcmVuY2UgKiBwb3N0IGRp
dmlkZXIgdG8gYSBtYXhpbXVtICovCj4gPj4gLcKgwqDCoCByZWZfZGl2X21heCA9IG1pbigx
MjggLyBwb3N0X2RpdiwgcmVmX2Rpdl9tYXgpOwo+ID4+ICvCoMKgwqAgcmVmX2Rpdl9tYXgg
PSBtaW4oMTAwIC8gcG9zdF9kaXYsIHJlZl9kaXZfbWF4KTsKPiA+PsKgwqDCoAo+ID4+wqDC
oMKgwqDCoMKgIC8qIGdldCBtYXRjaGluZyByZWZlcmVuY2UgYW5kIGZlZWRiYWNrIGRpdmlk
ZXIgKi8KPiA+PsKgwqDCoMKgwqDCoCAqcmVmX2RpdiA9IG1pbihtYXgoRElWX1JPVU5EX0NM
T1NFU1QoZGVuLCBwb3N0X2RpdiksIDF1KSwKPiA+PiByZWZfZGl2X21heCk7Cj4K
--------------CBA95B948AA58EF56373469D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Thanks Alex, Same question here, <br>
    </p>
    <p>Should we go through some extensive test routine due to change in
      PLL values, or is it OK to go ahead based on our experience from
      Radeon values ? <br>
    </p>
    <p><br>
    </p>
    <p>Regards<br>
    </p>
    <p>Shashank<br>
    </p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 04/11/20 7:36 pm, Deucher, Alexander
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB448848FEEB5717DDCF66F601F7EF0@MN2PR12MB4488.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;}</style>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        Acked-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a><br>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
          Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
          <b>Sent:</b> Wednesday, November 4, 2020 6:54 AM<br>
          <b>To:</b> Sharma, Shashank <a class="moz-txt-link-rfc2396E" href="mailto:Shashank.Sharma@amd.com">&lt;Shashank.Sharma@amd.com&gt;</a>;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
          <b>Cc:</b> Deucher, Alexander
          <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Qin, Eddy
          <a class="moz-txt-link-rfc2396E" href="mailto:Eddy.Qin@amd.com">&lt;Eddy.Qin@amd.com&gt;</a><br>
          <b>Subject:</b> Re: [PATCH] drm/amdgpu: clip the ref divider
          max value at 100</font>
        <div>&nbsp;</div>
      </div>
      <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
            <div class="PlainText">Am 04.11.20 um 11:40 schrieb Sharma,
              Shashank:<br>
              &gt; [AMD Public Use]<br>
              &gt;<br>
              &gt; Hello Christian,<br>
              &gt; Yes, that 100 is hardcoded in Radeon, and git blame
              says it was one of your patches which made it 100 from 128
              😊.<br>
              &gt; Would you mind having a look at commit id:
              4b21ce1b4b5d262e7d4656b8ececc891fc3cb806 ?<br>
              <br>
              Ah, yes that one :)<br>
              <br>
              Yeah the background is that this was just an educated
              guess because I <br>
              couldn't find anybody which could tell me what the real
              limits of the <br>
              PLL is.<br>
              <br>
              Looks like we just forgot to apply that patch to amdgpu.<br>
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              &gt;<br>
              &gt; Regards<br>
              &gt; Shashank<br>
              &gt; -----Original Message-----<br>
              &gt; From: Koenig, Christian
              <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
              &gt; Sent: Wednesday, November 4, 2020 3:35 PM<br>
              &gt; To: Sharma, Shashank <a class="moz-txt-link-rfc2396E" href="mailto:Shashank.Sharma@amd.com">&lt;Shashank.Sharma@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
              &gt; Cc: Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Qin, Eddy
              <a class="moz-txt-link-rfc2396E" href="mailto:Eddy.Qin@amd.com">&lt;Eddy.Qin@amd.com&gt;</a><br>
              &gt; Subject: Re: [PATCH] drm/amdgpu: clip the ref divider
              max value at 100<br>
              &gt;<br>
              &gt; Am 03.11.20 um 18:13 schrieb Shashank Sharma:<br>
              &gt;&gt; This patch limits the ref_div_max value to 100,
              during the calculation<br>
              &gt;&gt; of PLL feedback reference divider. With current
              value (128), the<br>
              &gt;&gt; produced fb_ref_div value generates unstable
              output at particular<br>
              &gt;&gt; frequencies. Radeon driver limits this value at
              100.<br>
              &gt; Mhm, is that 100 hard coded in radeon? I have no idea
              where that is coming from.<br>
              &gt;<br>
              &gt; Best would probably to grab a hardware engineer and
              try to figure out what the real maximums for the PLL is to
              still produce a stable signal.<br>
              &gt;<br>
              &gt; Christian.<br>
              &gt;<br>
              &gt;&gt; On Oland, when we try to setup mode 2048x1280@60
              (a bit weird, I<br>
              &gt;&gt; know), it demands a clock of 221270 Khz. It's
              been observed that the<br>
              &gt;&gt; PLL calculations using values 128 and 100 are
              vastly different, and<br>
              &gt;&gt; look like this:<br>
              &gt;&gt;<br>
              &gt;&gt; +------------------------------------------+<br>
              &gt;&gt; |Parameter&nbsp;&nbsp;&nbsp; |AMDGPU&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |Radeon&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
              &gt;&gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
              &gt;&gt; +-------------+----------------------------+<br>
              &gt;&gt; |Clock feedback&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
              &gt;&gt; |divider max&nbsp; |&nbsp; 128&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 100&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
              &gt;&gt; |cap value&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
              &gt;&gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
              &gt;&gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
              &gt;&gt; +------------------------------------------+<br>
              &gt;&gt; |ref_div_max&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
              &gt;&gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 42&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 20&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
              &gt;&gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
              &gt;&gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
              &gt;&gt; +------------------------------------------+<br>
              &gt;&gt; |ref_div&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 42&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 20&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
              &gt;&gt; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
              &gt;&gt; +------------------------------------------+<br>
              &gt;&gt; |fb_div&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 10326&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8195&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
              &gt;&gt; +------------------------------------------+<br>
              &gt;&gt; |fb_div&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1024&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 163&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
              &gt;&gt; +------------------------------------------+<br>
              &gt;&gt; |fb_dev_p&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
              &gt;&gt; |frac fb_de^_p|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
              &gt;&gt; +----------------------------+-------------+<br>
              &gt;&gt;<br>
              &gt;&gt; With ref_div_max value clipped at 100, AMDGPU
              driver can also drive<br>
              &gt;&gt; videmode 2048x1280@60 (221Mhz) and produce proper
              output without any<br>
              &gt;&gt; blanking and distortion on the screen.<br>
              &gt;&gt;<br>
              &gt;&gt; PS: This value was changed from 128 to 100 in
              Radeon driver also, here:<br>
              &gt;&gt; <a href="https://github.com/freedesktop/drm-tip/commit/4b21ce1b4b5d262e7d4656b8" moz-do-not-send="true">
https://github.com/freedesktop/drm-tip/commit/4b21ce1b4b5d262e7d4656b8</a><br>
              &gt;&gt; ececc891fc3cb806<br>
              &gt;&gt;<br>
              &gt;&gt; Cc: Alex Deucher
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
              &gt;&gt; Cc: Christian König
              <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
              &gt;&gt; Cc: Eddy Qin <a class="moz-txt-link-rfc2396E" href="mailto:Eddy.Qin@amd.com">&lt;Eddy.Qin@amd.com&gt;</a><br>
              &gt;&gt;<br>
              &gt;&gt; Signed-off-by: Shashank Sharma
              <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a><br>
              &gt;&gt; ---<br>
              &gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c | 2 +-<br>
              &gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
              &gt;&gt;<br>
              &gt;&gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c<br>
              &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c<br>
              &gt;&gt; index 1f2305b7bd13..23a2e1ebf78a 100644<br>
              &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c<br>
              &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c<br>
              &gt;&gt; @@ -85,7 +85,7 @@ static void
              amdgpu_pll_get_fb_ref_div(unsigned nom, unsigned den,
              unsigned post_<br>
              &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned
              *fb_div, unsigned *ref_div)<br>
              &gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
              &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* limit reference * post divider to a
              maximum */<br>
              &gt;&gt; -&nbsp;&nbsp;&nbsp; ref_div_max = min(128 / post_div,
              ref_div_max);<br>
              &gt;&gt; +&nbsp;&nbsp;&nbsp; ref_div_max = min(100 / post_div,
              ref_div_max);<br>
              &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
              &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get matching reference and feedback
              divider */<br>
              &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ref_div = min(max(DIV_ROUND_CLOSEST(den,
              post_div), 1u),<br>
              &gt;&gt; ref_div_max);<br>
              <br>
            </div>
          </span></font></div>
    </blockquote>
  </body>
</html>

--------------CBA95B948AA58EF56373469D--

--===============2044787123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2044787123==--
