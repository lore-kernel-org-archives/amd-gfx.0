Return-Path: <SRS0=L/30=DT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77A1C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 10:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ACF4206B6
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 10:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="G9Fceu5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACF4206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A110B89F92;
	Mon, 12 Oct 2020 10:54:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E147A6E2C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2020 10:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkDeu+mueK79Qb7Ork7OHfOst1mAmoIIy2x+M7j2JQgPgkdJ5ptv+2+R6yTB8wluWUhtxac/gOiXdDzHUQJFupULDW0LcyCb1K8FvYCZR7FHrUj7RGeVRhz7yq28dFcjl+OdJdnKa6O1HWsL7HBcT1EVMWgc83+yuRNZIVo9hepfR4M172Ernu2iq06tIMJBk8yQkl+uAuO+tbuPQQjOTB1QA3j0A1ZrQ70WZBKQG7mprHHYqbStEdrzPP3Q4s+bWWu6FYYNoqxN5pUeBEGgcv1dhAVmWCt1e8LiN8NlgHtMftCN+VqwcmDPZxLAJjdMax0mJnnOtBRlrufiI7zj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=542pD8A3303/50ueDTr3lKg4YcpjZWJSCT0A+L0H8j4=;
 b=KK5J7IPQzeIfMtPcaEzJm+nemnC+b6H3vM0bp5e7v78/x0jQ3MxVD3kfl6K6+aNzONk6RwDg1lz1Oa2hP6qeggWJXwIB1dOxfBUkSPfImQPTPeCRKRabnaF2ODDqe1ePlXkie3i1TSBfPMFLnIlFbxZywGjJrTv8hk13hvAcIsfws98CZeESex5d4T8sOVhQZ1N+JdT+LsyXV3vAupevzpXZXwTpvXbEI/7kKL97wSOOr7oVB8o6NGyE7XThiTD/1EaB0cMQU6gss49vI730MijDI9QxN5zxkQt8cqUb0+/yIH1dhIniz5aEpW0uT+uEYNNOGYkydDEA1HEUArZjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=542pD8A3303/50ueDTr3lKg4YcpjZWJSCT0A+L0H8j4=;
 b=G9Fceu5waguCtuBXLghri11HHzmSv8cl2mMuk61wnUhQcIGzRfVEGWnK5uPF+WLeCl5H8N0oyPXpnZxE63CsNCHoal7/l4iMi5UVnWhhhMOL8uD2mulBVF68nZbx3u2TV2nWVpEsp+BA6X0UGqm4zyyqQcDA+4eiQNDBsWjOALw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3696.namprd12.prod.outlook.com (2603:10b6:208:169::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Mon, 12 Oct
 2020 10:54:17 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 10:54:17 +0000
Subject: Re: [PATCH v3] drm/amdgpu: Add debugfs entry for printing VM info
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
To: "Patel, Mihir" <Mihir.Patel@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201012090159.28825-1-mihir.patel@amd.com>
 <d2d63bd0-61a0-33ce-67da-78143412d6b1@amd.com>
 <DM6PR12MB44527C86830BA20463BCFE6BE8070@DM6PR12MB4452.namprd12.prod.outlook.com>
 <64b13a59-f5c1-ff4c-f76a-0e1a00b249a0@amd.com>
 <DM6PR12MB4452CDAE4721D598694241B8E8070@DM6PR12MB4452.namprd12.prod.outlook.com>
 <24df1d90-04ad-e444-306d-7c2e16979b80@amd.com>
Message-ID: <3d9496e3-74ec-288d-4736-eb583d0f1c92@amd.com>
Date: Mon, 12 Oct 2020 12:54:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <24df1d90-04ad-e444-306d-7c2e16979b80@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR04CA0116.eurprd04.prod.outlook.com
 (2603:10a6:208:55::21) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR04CA0116.eurprd04.prod.outlook.com (2603:10a6:208:55::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.22 via Frontend Transport; Mon, 12 Oct 2020 10:54:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4372cb0d-0430-4bba-3170-08d86e9d2a39
X-MS-TrafficTypeDiagnostic: MN2PR12MB3696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3696192E7289B3A2A93D7C4983070@MN2PR12MB3696.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BcG/dpcRZ7bfY+YvNv5fXymg+NG+nlXK1AtM/KYUJCF10gZLB99HaDiVf5I6Wb74ryAvURhdzyi253fVLqGzwzfwic0RidSq3yu7lVUwYNjJV8n+ok40ZUdzD6w3aXT5WMCpv7oFz59e/8M6K4F+rzBiryCw+f/JznsjC0YxNOJVjMTnv5VyaMcSCVXVyGteqH/Z//2Fg+7MzWQj/A5JEBkgwztVngLXR8wE7LpPWunBILlFrurXpgxgukfGd9vobmkrrCmnKYnM6GO8dPWjtsqZhwof7Mh22Yhj7OQT/S1K7If26Cm//Or39MwXR/V5+W1wcSZ06vn5K1gxGZBRXsjZ9a/oJ/wHjCFT1SWEPiFKOemoj7RFZfTWlPUOqr+Zh6SXocZ0bRTSNYNfA3p1P/g9QC3/Iniy3sH81iT6WsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(4326008)(83380400001)(2616005)(5660300002)(52116002)(31696002)(316002)(16526019)(86362001)(186003)(8676002)(31686004)(8936002)(54906003)(36756003)(66946007)(53546011)(66476007)(66556008)(6486002)(478600001)(110136005)(2906002)(966005)(6666004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: wHDOcpaMLjnX2v2lQYFMowwN5DaHsCCaxLPdJP2gEzTkg4cMiI0MyFlwSvCa0N74WLoA6sUKQ8V3nkL8GV0hJ9XTTE9vv525NcN+YQH0m4mHrsfwRXM1YXeB+2RFXNlybwMjvVVA1EEScUPOebnKXo2sTb8dqT3J6IWxtiTfFM7KKfXkUKyFfQyNQT1kyqrrMJV40J6L1OofU3RIgTe8VpVqtsxNy03WnnZjBgSo5Noq0GfTym16gcsSJT16VrdlwCAybsUKqZ3zYk+QL/XH7+2ju+mOKJ1b9kkIkA/XsDXqhmBil6UpHvlxmDL32/ua4uCM+XEYlQyX4UMVQkU2wjlUbw/PXc+6kZYMR/NBdxxJeOFmDGeKbP/qBGModzNUsjxqv17C9z7TP26UgCBsDuzJTTg+EQPd6koICnFLKgH/Ulm5zta/Zup3bz1E7YwcanRFTSDYvNKokGmRA6pkkngPORv3hK8Uz7hhxm4TbHArVThRLv6OfBvpj5m57OoXatF3MBvYCEiYngAOtdoLEPvdG6AIShGmrba7zXUOXGorjmSct8vithjWTAZI8+9htd3gM+sW6MqchF9BOm7q8/VniNsfLQd3Kz3BJwrSjumDPo0Cv+amNQZaiFy9V063BFIeepQB07T6utP9S6DQE/OxZ56Nc4w9zcvgibkcvBxS+VtOM5GkqmDiuydsWRPTmL9PpWw2DviTgk7Yn+n/NA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4372cb0d-0430-4bba-3170-08d86e9d2a39
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 10:54:17.2356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mWk2OGoZL+HodvKcJ/Jk/mgozriSLEOYEp/r9XG5BVg0DRZyQMuhSqa9iKcP8H0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3696
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
Cc: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Kamliya,
 Prakash" <Prakash.Kamliya@amd.com>, "Surampalli,
 Kishore" <Kishore.Surampalli@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTIuMTAuMjAgdW0gMTI6NTAgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFtIDEyLjEw
LjIwIHVtIDEyOjAwIHNjaHJpZWIgUGF0ZWwsIE1paGlyOgo+PiBbQU1EIE9mZmljaWFsIFVzZSBP
bmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4+Cj4+Cj4+Cj4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tCj4+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29l
bmlnQGFtZC5jb20+Cj4+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxMiwgMjAyMCAzOjE0IFBNCj4+
IFRvOiBQYXRlbCwgTWloaXIgPE1paGlyLlBhdGVsQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+PiBDYzogQ2hhdWhhbiwgTWFkaGF2IDxNYWRoYXYuQ2hhdWhhbkBhbWQu
Y29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIAo+PiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IFN1cmFtcGFsbGksIEtpc2hvcmUgCj4+IDxLaXNob3JlLlN1cmFtcGFsbGlAYW1kLmNvbT47IEth
bWxpeWEsIFByYWthc2ggPFByYWthc2guS2FtbGl5YUBhbWQuY29tPgo+PiBTdWJqZWN0OiBSZTog
W1BBVENIIHYzXSBkcm0vYW1kZ3B1OiBBZGQgZGVidWdmcyBlbnRyeSBmb3IgcHJpbnRpbmcgVk0g
Cj4+IGluZm8KPj4KPj4gW1NOSVBdCj4+PiBIaSBDaHJpc3RpYW4sCj4+PiBPbmUgcXVlc3Rpb24g
cmVnYXJkaW5nIGdldHRpbmcgdG90YWwgYWxsb2NhdGlvbnMgYnkgYXBwIGFuZCBhbHNvIAo+Pj4g
c3dhcHBlZCBzaXplIGZvciB0aGUgYXBwLgo+Pj4gU2hvdWxkbuKAmXQgd2UgcHJpbnQgbWFwcGVk
IGVudHJpZXMgYXMgd2VsbCB0byBnZXQgdG90YWwgYWxsb2NhdGlvbiBieSAKPj4+IHRoZSBwcm9j
ZXNzID8KPj4+IEFsc28gd2hpY2ggbGlzdCB3b3VsZCByZXByZXNlbnQgc3dhcHBlZCBtZW1vcnk/
Cj4+IE5vbmUsIHdlIGRvbid0IHJlYWxseSBoYXZlIHRoYXQgaW5mb3JtYXRpb24gYW55d2hlcmUg
c2luY2Ugd2UgZG9uJ3QgCj4+IHJlYWxseSBoYXZlIGEgc3dhcHBlZCBzdGF0ZS4KPj4KPj4gU2Vl
IHdoZW4gdGhlIGFwcGxpY2F0aW9uIGFsbG9jYXRlcyBhIEJPIGluIFZSQU0gdGhlIGtlcm5lbCBk
cml2ZXIgaXMgCj4+IGZyZWUgdG8gc3dhcCBpdCBvdXQgdG8gR1RUIGFuZCBzdGlsbCBkbyBjb21t
YW5kIHN1Ym1pc3Npb24uIE9ubHkgd2hlbiAKPj4gaXQgaXMgZnVydGhlciBzd2FwcGVkIG91dCB0
byB0aGUgQ1BVIGRvbWFpbiBpdCBpcyBub3QgYWNjZXNzaWJsZSBhbnkgCj4+IG1vcmUuCj4+Cj4+
IFNvIHdoYXQgeW91IGNhbiBkbyBpcyB0byBsb29rIGF0IHRoZSBCT3MgaW4gdGhlIENQVSBkb21h
aW4sIGJ1dCB0aGlzIAo+PiBvbmx5IGdpdmVzIHlvdSBhIGNlcnRhaW4gaGludCBvbiB3aGF0J3Mg
Z29pbmcgb24uCj4+Cj4+IFJlZ2FyZHMsCj4+IENocmlzdGlhbi4KPj4KPj4gVGhhbmtzIENocmlz
dGlhbiBmb3IgY2xhcmlmeWluZyBhYm91dCBzd2FwcGVkIG1lbW9yeS4gSG93IGFib3V0IHRvdGFs
IAo+PiBhbGxvY2F0ZWQgc2l6ZT8gQ2FuJ3Qgd2UgcHJpbnQgbWFwcGVkIEJPcyBzaW5jZSBhbWRn
cHVfZ2VtX2luZm8gaXMgCj4+IEZJTEUvZ2VtIGhhbmRsZSBiYXNlZD8KPgo+IFRoYXQncyB3aGF0
IHlvdSBhcmUgYWxyZWFkeSBwcmludGluZy4gRS5nLiBpZiB5b3Ugc3VtIHVwIGFsbCB0aGUgQk9z
IAo+IGluIGFsbCB0aGUgZGlmZmVyZW50IHN0YXRlcyB0aGVuIHlvdSBoYXZlIHRoZSB0b3RhbCBh
bW91bnQgb2YgCj4gYWxsb2NhdGVkIG1lbW9yeSBmb3IgdGhpcyBwcm9jZXNzLgo+Cj4gRXZlbiBp
ZiBzb21lIG9mIHRoYXQgbWVtb3J5IGlzbid0IG1hcHBlZCBpbnRvIHRoZSBWTS4KClRoaW5raW5n
IGEgYml0IG1vcmUgYWJvdXQgaXQsIHdoZW4geW91IGFsc28gbG9vayBhdCAKYm8tPnByZWZlcnJl
ZF9kb21haW5zIGFuZCBjb21wYXJlIHRoYXQgd2l0aCB0aGUgY3VycmVudCBkb21haW4geW91IGNh
biAKYWxzbyBmaWd1cmUgb3V0IGlmIGEgQk8gaXMgc3dhcHBlZCBvdXQgb3Igbm90LgoKQ2hyaXN0
aWFuLgoKPgo+IENocmlzdGlhbi4KPgo+PiBSZWdhcmRzLAo+PiBNaWhpcgo+Pj4gVGhhbmtzLAo+
Pj4gTWloaXIKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
