Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D71CC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CB764DAF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CB764DAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A1D789CFA;
	Mon,  1 Feb 2021 15:07:17 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770042.outbound.protection.outlook.com [40.107.77.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F8ED89CFA
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 15:07:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iln8rWgsLpsKdioEDqYM2AsKNS2QhwKPsx4Vl9u8S7wdo+4G5cOKK9BEotL240FpvCWbj6s+kOpfFSyh0o5xcSyl+SburHTlSFDTxWcSR3rFb97yWQjU9ZFTGonAVbtNTM61Ke3rG9at2C6V5MMuW5RxMVwFybo8qED03SP+Lm1DRZkZMPjZHwRnqjuHaxRPcDtOo1CFMnRwnRWAJ+ukk8pa5I2ztQ9ssJ2W5iQhE3RdjnF12kxPWjKqFzYExoTA6l9ywYhVb3VaFNjnFHOIiwEzix7mirNol+6a47K7EmGIwCVgRBNOmjOpdAtUV0HigtEnM1PBhl9Sh4zFN9R1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7zaBC6DAky9aHf9OASG/ONpWgGtEx4FtUmZwEtbPJQ=;
 b=kJyH8EBFLrU87Pf5MQ0vsCY4Wircnb0UoZitoDV0ju1SuGoSGAoVAexKJE8AHO0g598yQL5CDzUUX/04NNl0HpiEB/4xQGjzXBq1NTySheFzZ6A+9YpnhRsK6svruuPF3HGuumdfXkqJRdZdjv31y/zcNh4Fpxsn1CEmqVyh7daLlQqIZFZLUSLan62jzKQQHehaLJlykHVk5e5Ll8YIS2uQL3fq8hgKaJoDmLyKqcO0dl76sHmXgwKXTafdvOiyiwV6E+PgCZjMokeWipNTlNOnMmbtcNjS2jvd25Dbk4zhZV5GPFNP0OR/eaKyJEPv8YtJBkb4rcHa8fh5Yk3gvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7zaBC6DAky9aHf9OASG/ONpWgGtEx4FtUmZwEtbPJQ=;
 b=EtzjLTKM/RRVpLzMbyBhJPsgrzXbCxy+UG1iw10ZK4XQ8FBXtpA2K0L7om8JSHZli6lqI5WPyRolrpjcAwbdqyOOe13h+OEOJy5bnxwEtg6q8L3Y1a6nGMyS2cnPHks15OXHb+2lKaAltFHSIUAPvNI/ZCB+3xTIIsIQs/pFXdc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BY5PR12MB3714.namprd12.prod.outlook.com (2603:10b6:a03:1a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.20; Mon, 1 Feb
 2021 15:07:14 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::dd41:21fb:f94f:eb03]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::dd41:21fb:f94f:eb03%3]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 15:07:14 +0000
Subject: Re: [PATCH] drm/amdgpu: enable freesync for A+A configs
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20210201143408.81475-1-christian.koenig@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <2226fb7c-97e5-ba63-041d-219902e56dbe@amd.com>
Date: Mon, 1 Feb 2021 20:36:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210201143408.81475-1-christian.koenig@amd.com>
Content-Language: en-US
X-Originating-IP: [106.51.20.251]
X-ClientProxiedBy: MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::26) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.68.111] (106.51.20.251) by
 MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 15:07:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f8320c51-02a7-48c8-50be-08d8c6c30ed2
X-MS-TrafficTypeDiagnostic: BY5PR12MB3714:
X-Microsoft-Antispam-PRVS: <BY5PR12MB37147D61E2722F19A45A30B8F2B69@BY5PR12MB3714.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUpDOX8Ginaa3KtViM7XbcvRDdsUCb4z+65oiNe9vrhepxBFulT/7yhzuJuoFPsoFoR4whps+UdfEc+TpXsiPDIXw8Jbm/F6vZc4C0iChArN6LdAT8IzXmqUcWhH0SKUrp6dLY1YEHPN46RYZZrEjb9QPEpI0sBSHX7Ht3Kw2L2+y+PuRQhfO2yZb/gh8ICZOy4U/gPqSWm105/OWQtm2ZvKfA0YgCjearcbjSfn19RUSfMiI4YnI7rQk60GqK2oemLI4goX0r2EK3nbBNcsb8hPldRKKxawDmKbPI3lw0klMWpzW7XneDeWRybyrRboLyDQwcli9v3iwLRrUnDoCZWNdEY9tC+ksu773/EdWUGH6e/egV1J+hFNIzPpNlnYDdOZH7TAT3isaVg7ax1reVbwixsBznXlhJ9Ag9iCp2LnfSX1FnTmaHiKr/GGth4o9qhz3fl91LpOd/eh3Aqpz+24Oe7sn47SCFAmpCzbOiD5hj1xqRZkD/sHaYUJQhn4/CLl/iWLNfXZmWVhesmYhacRS3uBwJMbTwrybLlPd0MYTpJEhdR+yUzC+dyeyx9nDw0PsPWa0Pbors7qSIJBupuoQQsU92/qsFjWu6HHEDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(31686004)(26005)(186003)(16526019)(5660300002)(31696002)(316002)(1006002)(6666004)(6486002)(478600001)(52116002)(66574015)(36756003)(86362001)(55236004)(16576012)(53546011)(44832011)(66476007)(66556008)(956004)(66946007)(83380400001)(2616005)(2906002)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YkVib2JHc0kzWGVPOGkybDV1RVVwTWJwaytEUkZ0c0F3WG1IKzhha3A2RUFa?=
 =?utf-8?B?OHZHSndzNllJcC94ZlhySGRPMHRyWVRFSU1NWGI1S1NxRTdkZ3J3bXJjSTU2?=
 =?utf-8?B?eFcwT3Y2SU8zVU5DQVJHclY5VjQ3dzc4dWVNMElRY1dPNjBXeUdFcFM1czhr?=
 =?utf-8?B?M2lYQjFDd24reVh4Z1gxM09Uc0UyRU9ZZnB6ZGoyaWZPYkhackN0NVdJQ1RI?=
 =?utf-8?B?TDh2YTZMMzFEVmJackNmdkFKeTBMUWNmdFdhYzAyWWFuUjliVUlsVkdWOW9n?=
 =?utf-8?B?a2lkMFhHd2pZcFJwN1dyZ2VxRytETWg1ZmlURlZGUlJKV3ZWRkhodytZZmRR?=
 =?utf-8?B?N096Rk9GejlEUU5qS3ovNG9sdlQ1OGhRUWdwaEdOQTBlZXZtVk5DWkw2SGsy?=
 =?utf-8?B?WENMMDlXV3YwM2RkY0kwZEcxZmIrdGRYTHFjenozN2RUWXVxanhCcXZJdS9V?=
 =?utf-8?B?di85ZlZMcXZmNlhjTCs3dlpGWk0vZHF4S2FsSytKZDNvdDZ1cldLbFlXWHhD?=
 =?utf-8?B?ZW9JeFZZbkt4blJlL3lZNklhREtBQ21lNi8wUmI4ckRZWlBtRUl5dkNzRXIz?=
 =?utf-8?B?RThFempVaEViV1BNWUlDdXptV0lIaVZ4MkIvWUwyZEt1dm9lY1dpSWJYdjRK?=
 =?utf-8?B?Y3krSXUrd2EvWVZtTUxWMzNKK1BxYVJKYjcvMm9neVNPSGNvVVRPdUh6KzJr?=
 =?utf-8?B?eTBodXA0TzB4MlgwT1VyY045c0lOTTRGbWFGUTgyK05tdXl1ajNFell0WlFk?=
 =?utf-8?B?bmF6bll5RGUrTHFqanJ4SlZWZ0FLWlR3elJhNFlraWxwNW9raUFKSWF2VWxi?=
 =?utf-8?B?Qm9OK1lKWGhPbWhQRHg5LzArdG85ejRIRTBBc0xtN0FVVGNIamNzVlNWdGlz?=
 =?utf-8?B?dWoyRDAydzJzNStMTEl0R3h2bjVISy90M01ranA4WmJ4ZjdKdExEYlhYRm80?=
 =?utf-8?B?ZTM3dzZkR2xwQnBScVF4OVc2a0g0RGFkbUNmYkNyTHZKWGpSZDZpeUtTV3l3?=
 =?utf-8?B?bkd6d3M2UWZZbmFLeEUyeVMxVWpUQ3ZDa0FlczBrcnIyRHZKeTI4dkFBd2wz?=
 =?utf-8?B?bTUxZzhKQnJBTDZ3SVl2bzh3N3Y3K3Vad2dNVlRTN0NhTXYxYVlGcjNZU2w0?=
 =?utf-8?B?aCtDRjJlNXlxZnkvZEJlWWQ3VVZNNUxlSXFWazkrSEVWS3JFaUtOQkZoUXVq?=
 =?utf-8?B?VGh1OTRrVW5wTDFTOHZzaWo3Z29TcXltOUdqK0VtZk93M0F3ZUlMUkVWckRs?=
 =?utf-8?B?MjUrR2UxU1gwRGVyWXo0NzlMak8xaUVHWkJVd0xEWGZQalAvZlVpMFgxSW0r?=
 =?utf-8?B?YTdYVFVMSGJwNG4zUUwzSXMvZmlZeFNEMDZoYjdyOFN1SDJacElwYUVTWGIx?=
 =?utf-8?B?ZytqSzBqMDZvWlpjd3orYmdTUXVxTE5raDhLUFlvTWtPNmN1bDBsN1lQTlVz?=
 =?utf-8?Q?wjBb+WaT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8320c51-02a7-48c8-50be-08d8c6c30ed2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 15:07:14.5200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RX0mEseOhAPbVB+bitgm1CftBXbL/CzsQyYZhUVgcRCCTjhHneg9upNoYYOY90/JqC7wZfuPMzyDnDKwAxs/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3714
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGVsbG8gQ2hyaXN0aWFuLAoKT24gMDEvMDIvMjEgODowNCBwbSwgQ2hyaXN0aWFuIEvDtm5pZyB3
cm90ZToKPiBTb21lIG5ld2VyIEFQVXMgY2FuIHNjYW5vdXQgZGlyZWN0bHkgZnJvbSBHVFQsIHRo
YXQgc2F2ZXMgdXMgZnJvbQo+IGFsbG9jYXRpbmcgYW5vdGhlciBib3VuY2UgYnVmZmVyIGluIFZS
QU0gYW5kIGVuYWJsZXMgZnJlZXN5bmMgaW4gc3VjaAo+IGNvbmZpZ3VyYXRpb25zLgpTaGFsbCB3
ZSBhZGQgc29tZSBtb3JlIGRldGFpbHMgYWJvdXQgaG93IHRoaXMgcGF0Y2ggaGVscHMgd2l0aCBW
UlIsIGxpa2UgIldpdGhvdXQgdGhpcyBwYXRjaCwgaXQgd29uJ3QgYmUgcG9zc2libGUgZm9yIHRo
ZSBJR1BVIHRvIGZsaXAgYnVmZmVycyB3aGljaCBhcmUgY29tcG9zZWQgb24gYW4gZXh0ZXJuYWwg
R1BVIiBvciBzb21ldGhpbmcgaW4gdGhvc2UgbGluZXMgPwo+IFNpZ25lZC1vZmYtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyB8IDggKysrKysrLS0KPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jICB8IDIgKy0KPiAgMiBmaWxlcyBj
aGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMKPiBpbmRleCBhNjM4NzA5ZTljOTIuLjgy
M2JjMjVkODdkZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGlzcGxheS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rp
c3BsYXkuYwo+IEBAIC05MzAsOCArOTMwLDEwIEBAIGFtZGdwdV9kaXNwbGF5X3VzZXJfZnJhbWVi
dWZmZXJfY3JlYXRlKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCj4gIAkJCQkgICAgICAgc3RydWN0
IGRybV9maWxlICpmaWxlX3ByaXYsCj4gIAkJCQkgICAgICAgY29uc3Qgc3RydWN0IGRybV9tb2Rl
X2ZiX2NtZDIgKm1vZGVfY21kKQo+ICB7Cj4gLQlzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iajsK
PiAgCXN0cnVjdCBhbWRncHVfZnJhbWVidWZmZXIgKmFtZGdwdV9mYjsKPiArCXN0cnVjdCBkcm1f
Z2VtX29iamVjdCAqb2JqOwo+ICsJc3RydWN0IGFtZGdwdV9ibyAqYm87Cj4gKwl1aW50MzJfdCBk
b21haW5zOwo+ICAJaW50IHJldDsKPiAgCj4gIAlvYmogPSBkcm1fZ2VtX29iamVjdF9sb29rdXAo
ZmlsZV9wcml2LCBtb2RlX2NtZC0+aGFuZGxlc1swXSk7Cj4gQEAgLTk0Miw3ICs5NDQsOSBAQCBh
bWRncHVfZGlzcGxheV91c2VyX2ZyYW1lYnVmZmVyX2NyZWF0ZShzdHJ1Y3QgZHJtX2RldmljZSAq
ZGV2LAo+ICAJfQo+ICAKPiAgCS8qIEhhbmRsZSBpcyBpbXBvcnRlZCBkbWEtYnVmLCBzbyBjYW5u
b3QgYmUgbWlncmF0ZWQgdG8gVlJBTSBmb3Igc2Nhbm91dCAqLwo+IC0JaWYgKG9iai0+aW1wb3J0
X2F0dGFjaCkgewo+ICsJYm8gPSBnZW1fdG9fYW1kZ3B1X2JvKG9iaik7CklzIGl0IHBvc3NpYmxl
IHRoYXQgdGhlIGJvIGNhbiBiZSBOVUxMID8gSSBtZWFuIGRvIHdlIG5lZWQgYSBOVUxMIGNoZWNr
IGhlcmUgPwo+ICsJZG9tYWlucyA9IGFtZGdwdV9kaXNwbGF5X3N1cHBvcnRlZF9kb21haW5zKGRy
bV90b19hZGV2KGRldiksIGJvLT5mbGFncyk7Cj4gKwlpZiAob2JqLT5pbXBvcnRfYXR0YWNoICYm
ICEoZG9tYWlucyAmIEFNREdQVV9HRU1fRE9NQUlOX0dUVCkpIHsKPiAgCQlkcm1fZGJnX2ttcyhk
ZXYsICJDYW5ub3QgY3JlYXRlIGZyYW1lYnVmZmVyIGZyb20gaW1wb3J0ZWQgZG1hX2J1ZlxuIik7
Cj4gIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7Cj4gIAl9Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+IGluZGV4IDU2ODU0YTNlZTE5Yy4uMGJkMjJlZDFk
YWNmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+
IEBAIC05MDAsNyArOTAwLDcgQEAgaW50IGFtZGdwdV9ib19waW5fcmVzdHJpY3RlZChzdHJ1Y3Qg
YW1kZ3B1X2JvICpibywgdTMyIGRvbWFpbiwKPiAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgCj4gIAkv
KiBBIHNoYXJlZCBibyBjYW5ub3QgYmUgbWlncmF0ZWQgdG8gVlJBTSAqLwo+IC0JaWYgKGJvLT5w
cmltZV9zaGFyZWRfY291bnQpIHsKPiArCWlmIChiby0+cHJpbWVfc2hhcmVkX2NvdW50IHx8IGJv
LT50Ym8uYmFzZS5pbXBvcnRfYXR0YWNoKSB7CgpXaXRoIHRoZSBhYm92ZSBjb25jZXJucyBhZGRy
ZXNzZWQgKG9yIHJlYXNvbmVkIDopKSwgcGxlYXNlIGZlZWwgZnJlZSB0byB1c2U6CgpSZXZpZXdl
ZC1ieTogU2hhc2hhbmsgU2hhcm1hIDxzaGFzaGFuay5zaGFybWFAYW1kLmNvbT4KCi0gU2hhc2hh
bmsKCj4gIAkJaWYgKGRvbWFpbiAmIEFNREdQVV9HRU1fRE9NQUlOX0dUVCkKPiAgCQkJZG9tYWlu
ID0gQU1ER1BVX0dFTV9ET01BSU5fR1RUOwo+ICAJCWVsc2UKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
