Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E48C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 00:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461896141E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 00:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461896141E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE68B6E92C;
	Wed, 21 Apr 2021 00:45:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F6656E92C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 00:45:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bg6WWCo25w2C9ViXKrULoI3gh+Id0nSU5t4C/NfnPrlJzDyid7aynDOQ2gk+F+vj1a6LAr/ius2puLF5zRQxnt5QG0v/ZXxL5Eu4SogiEX79i907StWsPLHKIr7AoKkhQWIBPmueSkEb0YKLjKvCG4gSiQNmTlH3XJlzKIHaUEnsibPWtUDUb+6yDdbOhgfdl2r3Ru4V/63WEieRIuMuUA8MmP/Y7TNziynfSgp0KBMXGYNm2VDhHAy4+5MSW9KbUl4IFrgfGWjj8wTmCSR4Y9qeNeEcR6xqkXH/iHN3wokrFSkw9mJp7mLxJonh36hfwouv81lNT7z7FOs8EDOHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZk3lnOlhcC0mQdVMteHwb5wHmnlyj2pC+IzzwgGS9c=;
 b=BbTr8Hb1dhuSnmPWiV7b6ikvnAWXTIlCbO0cO96k4RZPVt6NkGa8O4OPNQT3c/7gQuZV6X3yDNsfLHN/TwdY+Nr2BzBP1Du2Muid8U73cmmvIJhpX687K5IkJhBsWjjOQJ/r5s2Mb9VbRyIVBntSUEg+yXU1TrJaN/cGhhf+/gTYB93L+DImEJcLeyoYNPE1fYf69rtUvhl0YfFHHmphzkMh9zV0ls4OwYk9Fn9U2Rn5l5na8zrumWkWdW3HLZVcXIhIeu0PMpNRfAiHzhtLIeVDmftxPc4DqFKYKeOcc6C4KSp7/zVeBq0uN7ELtJSXBfYTWNzK0glz6Y1lwoW9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZk3lnOlhcC0mQdVMteHwb5wHmnlyj2pC+IzzwgGS9c=;
 b=EvclN4KGrhw9G4DHhnULXv7NIYyj67ocbcciQ5L8/p5dhMARzhzGT9pxkaBg5UEeLKjevo0MUkNsekf9r7P22VeMlzwqLv3UGuTSfmP0qRyt4UQTay0nxfYaXqt21sY/4WKjwktc/O4jMElaCt2x4aGJNWUk8Q18f+uOLkwqZf8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB3693.namprd12.prod.outlook.com (2603:10b6:208:159::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Wed, 21 Apr
 2021 00:45:55 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Wed, 21 Apr 2021
 00:45:55 +0000
Subject: Re: [PATCH] drm/amdkfd: svm ranges creation for unregistered memory
To: amd-gfx@lists.freedesktop.org, Alex Sierra <alex.sierra@amd.com>
References: <20210420015205.9606-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <803e53c6-7268-5521-fd4f-835da994a07e@amd.com>
Date: Tue, 20 Apr 2021 20:45:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210420015205.9606-1-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.180.233]
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.180.233) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Wed, 21 Apr 2021 00:45:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 260d413a-89ed-4a74-7f05-08d9045ed228
X-MS-TrafficTypeDiagnostic: MN2PR12MB3693:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB36933AA92069B6A78200E6E092479@MN2PR12MB3693.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ccsf368Mo5puff04se7hAzjkBWp2G1mzqu62rJ1uylhqdbp06v3v+qJ/FuP3H80dGkbXV1bDLC07lC5yAa33v9RPNeuX7oSBWEd8TTcwVFYiyxIsOvwjBfq9394botM5sivAlSJDYqwVjXD/UFYzL6sA+K7d54qx/VCooRu2KOV5H/g16dTq0Mrq9G6NucFEkxBLCwvrNRI5eAV4bWJQUvJkwchy+PUNdeIBPxByOQwFCvLp5pIYNaJSMnDfZHoeOuq5frYqwkZ3GUchzUrXvYh8tRIJh4vkF0s5GkyuhIGimM2eBZK35E4NRgLn/10Sua3Aab86GNy/r+uQ2BZMJzxVcS4dtb44M5HNSMB7X54/MZQgbuIqOV2IMN4YUcO9eveqiVamMW++cb8udDcMTVEnE5a9ev1c/NVEr+YQM+6K+cvdZ8MqSHjXHM1sJWq50KsO1loD8oP0jdb8gtdnYb4dzV1a6kZVNnqi8svf3XaF2b7a+4CzcvoJoBXVxlO1eK3ZaS8DcQ8AtRkeQ7YV4G8a+UsPtPJjj/YaAhvMRb6IzLZj0JUbmTohiJK2lI+yaob0q9QjCm7yTlhTVNJ/h4encPkI495S6K9qbrD3/GdDKJcKlLkKf2OegeJxpSzWLBUtyaMQlSFgqR8waWEtURsdj49ee7KvKrZS+soznkLF2NhSbp8F4mDtakIAU2K5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(38100700002)(6636002)(8676002)(31686004)(956004)(2906002)(83380400001)(186003)(16526019)(478600001)(26005)(36756003)(86362001)(44832011)(6862004)(31696002)(6486002)(2616005)(66946007)(16576012)(37006003)(8936002)(316002)(66556008)(5660300002)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MmVPN0NDbnBIVEt2N3dhUGYyWDNpR1MxZENCQ2p6YUJpZFlrTlpENktUMGEz?=
 =?utf-8?B?V2JPY1pyZ3JaclNlTzRYc0xpT0xoME1ZL3FjbU9rdk1nWHkreG9hbXRCNnRC?=
 =?utf-8?B?VkQyd0JFOGhZdTNTTGhXU1MxSEV2TStGbjNVbHNBQkN0NTBkN3Z3RVE4azFw?=
 =?utf-8?B?L3p4dG4xZFBHUzJOQ2dCdFREMW1RQk95M09ubVd4ckJ4cmM4K2FPeWQ5ejhx?=
 =?utf-8?B?UzF4NVFESHhqdEJIbVV3UGYzdzkzd1JadFA5ZDlTUjZuYnV1c2dOdXJUNHBM?=
 =?utf-8?B?ZGxRVWNyTE1SMWV3RVFHRkM0TTBub3VrSmEzODM5c3Z6S3F6VzVvajNEQXY1?=
 =?utf-8?B?TndYdFlzSFFLYVdjY3lmTFR0VjFqMklpYkFvWC93Wk0zVzQ0Ymtpb0FBUnIz?=
 =?utf-8?B?WlBNQ2VCVVhTY0FOc0tYd3dZOVpLbXJsMzRlNENEcjc2VDZ1aklGOTJSOEl0?=
 =?utf-8?B?TWlDR2lkc1l6MitKSzVMb01FUXdhR3dWK2pDVU1nR3ZIdUUvbWhWa0l1R0Fv?=
 =?utf-8?B?anQwTG9WaU1uRVY2UUhKbEJsSDEzOWpXWVMzSllWdVp0SmcveC9OZGRYRVFR?=
 =?utf-8?B?SDRqMWhRVURXMTUyTWpqMzMyd3VzN0p0eWR0L0N3c2JIUUVxMldodzRpbTJv?=
 =?utf-8?B?K0FMbXlSVVJucGJsL3BQY0xTM3plSlhSU1ZTR1RVNjZ5TFpicFJlRXR1SmFq?=
 =?utf-8?B?UVVhUlNpL0VldmF6YmN4RDFyM1ZGOE1TSDJRK1F0QUZLZEVNRE1rNVd5dUti?=
 =?utf-8?B?cllDdW5ZeDVBVE1INER1RXg3Ykppc1A4N3RlZXRTNm1rT3h4MzdETnJlSkoz?=
 =?utf-8?B?Ukp2eFpDZlpSZENTbWY4NFppSVZZVmFlVFovY0M5SllHNVhzSnFZb0QxcDVE?=
 =?utf-8?B?Zm5PNEVpQ0hRbE1yMlVuMkYrTFBqR3Y5emVKaytJZElzaEMzUFh2dVpvTVpG?=
 =?utf-8?B?MWl1M0Y3ckxFWGt1TDJGMkFIUGVKUnZqeWxQSDhhVGFuUW1MU2RmQlUzdkt2?=
 =?utf-8?B?MEllRXN0Zld0MS9aTWFLM1dqbmFnakNpRWNLNDI0T0ZnVU9XaFNrWXYzN0JE?=
 =?utf-8?B?YnhLb01xNmM1TTBMQTM3dGZEbjFkUVgyM3FITThQOFNYTnZaMUFveEw0Tkpo?=
 =?utf-8?B?SlFDalpzMTlLcEdvUWIyTkR3Mkd0ZEZxclFoN0ZwbngydG1FcVFjbXpTd09T?=
 =?utf-8?B?Q0QxeDJYK004Vzc4cFM1cDJSbUcxK2hVUXhzOVZ3SzVJUEtSU05pak44Nncx?=
 =?utf-8?B?eDY0QVRMZW9KU1VHRVFhSDlXUFMzaWx5VjZKaEpTMmYrT29rZjYvTVQ2RG02?=
 =?utf-8?B?SzlQaHkxa1NkTTZXc3VRWmdYWGhuQ1BIOUZ3VTRJOU9abHdTSXpicVY2V0kw?=
 =?utf-8?B?NHNVMUJaOGt4SWxYRnc2WnhadTQxWjZEaFREMytHc1Z2OEVkb0luVitEZVpl?=
 =?utf-8?B?UXNuemw2bi9FOVNmYS9XSHVacWZSNVBjVHllSUduRDlXRG1WeHlLM293Z0M4?=
 =?utf-8?B?SDhPWXdvWlZ1V3FPR21XRDJLb1p6dlVucnlYUGV2S1RNcThjZ05pMjgxelVC?=
 =?utf-8?B?THlicTNMa2l1YkRIUjFCS2d1VUZyOXZNTGxnNFRERXd5ZmRQM2NMWDZQT0N1?=
 =?utf-8?B?cmRrNWU0djVYQ3l1QTdQaEpaTHlXdndPNng3OERGci9CZ0tLVHdVMlptQjNa?=
 =?utf-8?B?WmZoQWxOWEFsR0JRUVY2NDNFUW9XMkMrZWdzSlIvTXRGTHNkMXhuRy8xdFAz?=
 =?utf-8?B?Yk9CSU5zUFcrWXNKVEtqeTBaOEtSbmlpM2JGaCszK2lCSkxrMHNuT0lIREx5?=
 =?utf-8?B?ZjlyU21lY0dNOG5qL3dpUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260d413a-89ed-4a74-7f05-08d9045ed228
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 00:45:55.1391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QY2ObTxWJF3LfenaC0HqqeqFhIBiZ3F9FQLzpmsSBiURCnRhYzJ4zUy06cHKd+xALg6jnlvDgmToUTxmmxOxHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3693
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

QW0gMjAyMS0wNC0xOSB1bSA5OjUyIHAubS4gc2NocmllYiBBbGV4IFNpZXJyYToKPiBTVk0gcmFu
Z2VzIGFyZSBjcmVhdGVkIGZvciB1bnJlZ2lzdGVyZWQgbWVtb3J5LCB0cmlnZ2VyZWQKPiBieSBw
YWdlIGZhdWx0cy4gVGhlc2UgcmFuZ2VzIGFyZSBtaWdyYXRlZC9tYXBwZWQgdG8KPiBHUFUgVlJB
TSBtZW1vcnkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IFNpZXJyYSA8YWxleC5zaWVycmFAYW1k
LmNvbT4KClRoaXMgbG9va3MgZ2VuZXJhbGx5IGdvb2QgdG8gbWUuIE9uZSBtb3JlIG5pdC1waWNr
IGlubGluZSBpbiBhZGRpdGlvbiB0bwpQaGlsaXAncyBjb21tZW50cy4gQW5kIG9uZSBxdWVzdGlv
bi4KCgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMgfCAxMDMg
KysrKysrKysrKysrKysrKysrKysrKysrKystCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMDEgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfc3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3Zt
LmMKPiBpbmRleCA0NWRkMDU1MTE4ZWIuLmE4YTkyYzUzM2NmNyAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfc3ZtLmMKPiBAQCAtMjE3OSw2ICsyMTc5LDg0IEBAIHN2bV9yYW5nZV9i
ZXN0X3Jlc3RvcmVfbG9jYXRpb24oc3RydWN0IHN2bV9yYW5nZSAqcHJhbmdlLAo+ICAKPiAgCXJl
dHVybiAtMTsKPiAgfQo+ICtzdGF0aWMgaW50Cj4gK3N2bV9yYW5nZV9nZXRfcmFuZ2VfYm91bmRh
cmllcyhzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsIGludDY0X3QgYWRkciwKPiArCQkJCXVuc2lnbmVk
IGxvbmcgKnN0YXJ0LCB1bnNpZ25lZCBsb25nICpsYXN0KQo+ICt7Cj4gKwlzdHJ1Y3Qgdm1fYXJl
YV9zdHJ1Y3QgKnZtYTsKPiArCXN0cnVjdCBpbnRlcnZhbF90cmVlX25vZGUgKm5vZGU7Cj4gKwl1
bnNpZ25lZCBsb25nIHN0YXJ0X2xpbWl0LCBlbmRfbGltaXQ7Cj4gKwo+ICsJdm1hID0gZmluZF92
bWEocC0+bW0sIGFkZHIpOwo+ICsJaWYgKCF2bWEgfHwgYWRkciA8IHZtYS0+dm1fc3RhcnQpIHsK
PiArCQlwcl9kZWJ1ZygiVk1BIGRvZXMgbm90IGV4aXN0IGluIGFkZHJlc3MgWzB4JWxseF1cbiIs
IGFkZHIpOwo+ICsJCXJldHVybiAtRUZBVUxUOwo+ICsJfQo+ICsJc3RhcnRfbGltaXQgPSBtYXgo
dm1hLT52bV9zdGFydCwKPiArCQkJKHVuc2lnbmVkIGxvbmcpQUxJR05fRE9XTihhZGRyLCAyVUwg
PDwgMjApKSA+PiBQQUdFX1NISUZUOwo+ICsJZW5kX2xpbWl0ID0gbWluKHZtYS0+dm1fZW5kLAo+
ICsJCQkodW5zaWduZWQgbG9uZylBTElHTihhZGRyICsgMSwgMlVMIDw8IDIwKSkgPj4gUEFHRV9T
SElGVDsKPiArCS8qIEZpcnN0IHJhbmdlIHRoYXQgc3RhcnRzIGFmdGVyIHRoZSBmYXVsdCBhZGRy
ZXNzICovCj4gKwlub2RlID0gaW50ZXJ2YWxfdHJlZV9pdGVyX2ZpcnN0KCZwLT5zdm1zLm9iamVj
dHMsIChhZGRyID4+IFBBR0VfU0hJRlQpICsgMSwgVUxPTkdfTUFYKTsKPiArCWlmIChub2RlKSB7
Cj4gKwkJZW5kX2xpbWl0ID0gbWluKGVuZF9saW1pdCwgbm9kZS0+c3RhcnQpOwo+ICsJCS8qIExh
c3QgcmFuZ2UgdGhhdCBlbmRzIGJlZm9yZSB0aGUgZmF1bHQgYWRkcmVzcyAqLwo+ICsJCW5vZGUg
PSBjb250YWluZXJfb2YocmJfcHJldigmbm9kZS0+cmIpLCBzdHJ1Y3QgaW50ZXJ2YWxfdHJlZV9u
b2RlLCByYik7Cj4gKwl9IGVsc2Ugewo+ICsJCS8qIExhc3QgcmFuZ2UgbXVzdCBlbmQgYmVmb3Jl
IGFkZHIgYmVjYXVzZSB0aGVyZSB3YXMgbm8gcmFuZ2UgYWZ0ZXIgYWRkciAqLwo+ICsJCW5vZGUg
PSBjb250YWluZXJfb2YocmJfbGFzdCgmcC0+c3Ztcy5vYmplY3RzLnJiX3Jvb3QpLAo+ICsJCQkJ
ICAgIHN0cnVjdCBpbnRlcnZhbF90cmVlX25vZGUsIHJiKTsKPiArCX0KPiArCWlmIChub2RlKQo+
ICsJCXN0YXJ0X2xpbWl0ID0gbWF4KHN0YXJ0X2xpbWl0LCBub2RlLT5sYXN0ICsgMSk7Cj4gKwo+
ICsJKnN0YXJ0ID0gc3RhcnRfbGltaXQ7Cj4gKwkqbGFzdCA9IGVuZF9saW1pdCAtIDE7Cj4gKwo+
ICsJcHJfZGVidWcoInZtYSBzdGFydDogJWx4IHN0YXJ0OiAlbHggdm1hIGVuZDogJWx4IGxhc3Q6
ICVseFxuIiwKPiArCQkgIHZtYS0+dm1fc3RhcnQgPj4gUEFHRV9TSElGVCwgKnN0YXJ0LAo+ICsJ
CSAgdm1hLT52bV9lbmQgPj4gUEFHRV9TSElGVCwgKmxhc3QpOwo+ICsKPiArCXJldHVybiAwOwo+
ICsKPiArfQo+ICtzdGF0aWMgc3RydWN0Cj4gK3N2bV9yYW5nZSAqc3ZtX3JhbmdlX2NyZWF0ZV91
bnJlZ2lzdGVyZWRfcmFuZ2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gKwkJCQkJCXN0
cnVjdCBrZmRfcHJvY2VzcyAqcCwKPiArCQkJCQkJc3RydWN0IG1tX3N0cnVjdCAqbW0sCj4gKwkJ
CQkJCWludDY0X3QgYWRkcikKPiArewo+ICsJc3RydWN0IHN2bV9yYW5nZSAqcHJhbmdlID0gTlVM
TDsKPiArCXN0cnVjdCBzdm1fcmFuZ2VfbGlzdCAqc3ZtczsKPiArCXVuc2lnbmVkIGxvbmcgc3Rh
cnQsIGxhc3Q7Cj4gKwl1aW50MzJfdCBncHVpZCwgZ3B1aWR4Owo+ICsKPiArCWlmIChzdm1fcmFu
Z2VfZ2V0X3JhbmdlX2JvdW5kYXJpZXMocCwgYWRkciA8PCBQQUdFX1NISUZULAo+ICsJCQkJCSAg
ICZzdGFydCwgJmxhc3QpKQo+ICsJCXJldHVybiBOVUxMOwo+ICsKPiArCXN2bXMgPSAmcC0+c3Zt
czsKPiArCXByYW5nZSA9IHN2bV9yYW5nZV9uZXcoJnAtPnN2bXMsIHN0YXJ0LCBsYXN0KTsKPiAr
CWlmICghcHJhbmdlKSB7Cj4gKwkJcHJfZGVidWcoIkZhaWxlZCB0byBjcmVhdGUgcHJhbmdlIGlu
IGFkZHJlc3MgWzB4JWxseF1cXG4iLCBhZGRyKTsKPiArCQlnb3RvIG91dDsKCllvdSBjYW4ganVz
dCByZXR1cm4gaGVyZSwgc2luY2UgeW91J3JlIG5vdCBkb2luZyBhbnkgY2xlYW51cCBhdCB0aGUg
b3V0OgpsYWJlbC4KCgo+ICsJfQo+ICsJaWYgKGtmZF9wcm9jZXNzX2dwdWlkX2Zyb21fa2dkKHAs
IGFkZXYsICZncHVpZCwgJmdwdWlkeCkpIHsKPiArCQlwcl9kZWJ1ZygiZmFpbGVkIHRvIGdldCBn
cHVpZCBmcm9tIGtnZFxuIik7Cj4gKwkJc3ZtX3JhbmdlX2ZyZWUocHJhbmdlKTsKPiArCQlwcmFu
Z2UgPSBOVUxMOwo+ICsJCWdvdG8gb3V0OwoKSnVzdCByZXR1cm4uCgoKPiArCX0KPiArCXByYW5n
ZS0+cHJlZmVycmVkX2xvYyA9IGdwdWlkOwo+ICsJcHJhbmdlLT5hY3R1YWxfbG9jID0gMDsKPiAr
CS8qIEd1cmFudGVlIHByYW5nZSBpcyBtaWdyYXRlIGl0ICovCj4gKwlwcmFuZ2UtPnZhbGlkYXRl
X3RpbWVzdGFtcCAtPSBBTURHUFVfU1ZNX1JBTkdFX1JFVFJZX0ZBVUxUX1BFTkRJTkc7CgpJcyB0
aGlzIHJlYWxseSBzcGVjaWZpYyB0byBzdm1fcmFuZ2VfY3JlYXRlX3VucmVnaXN0ZXJlZF9yYW5n
ZT8gT3IKc2hvdWxkIHdlIGFsd2F5cyBkbyB0aGlzIGluIHN2bV9yYW5nZV9uZXcgdG8gZ3VhcmFu
dGVlIHRoYXQgbmV3IHJhbmdlcwpjYW4gZ2V0IHZhbGlkYXRlZD8KClJlZ2FyZHMsCsKgIEZlbGl4
CgoKPiArCXN2bV9yYW5nZV9hZGRfdG9fc3ZtcyhwcmFuZ2UpOwo+ICsJc3ZtX3JhbmdlX2FkZF9u
b3RpZmllcl9sb2NrZWQobW0sIHByYW5nZSk7Cj4gKwo+ICtvdXQ6Cj4gKwlyZXR1cm4gcHJhbmdl
Owo+ICt9Cj4gIAo+ICAvKiBzdm1fcmFuZ2Vfc2tpcF9yZWNvdmVyIC0gZGVjaWRlIGlmIHByYW5n
ZSBjYW4gYmUgcmVjb3ZlcmVkCj4gICAqIEBwcmFuZ2U6IHN2bSByYW5nZSBzdHJ1Y3R1cmUKPiBA
QCAtMjIyOCw2ICsyMzA2LDcgQEAgc3ZtX3JhbmdlX3Jlc3RvcmVfcGFnZXMoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsIHVuc2lnbmVkIGludCBwYXNpZCwKPiAgCXN0cnVjdCBrZmRfcHJvY2Vz
cyAqcDsKPiAgCXVpbnQ2NF90IHRpbWVzdGFtcDsKPiAgCWludDMyX3QgYmVzdF9sb2MsIGdwdWlk
eDsKPiArCWJvb2wgd3JpdGVfbG9ja2VkID0gZmFsc2U7Cj4gIAlpbnQgciA9IDA7Cj4gIAo+ICAJ
cCA9IGtmZF9sb29rdXBfcHJvY2Vzc19ieV9wYXNpZChwYXNpZCk7Cj4gQEAgLTIyNTEsMTQgKzIz
MzAsMzQgQEAgc3ZtX3JhbmdlX3Jlc3RvcmVfcGFnZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsIHVuc2lnbmVkIGludCBwYXNpZCwKPiAgCX0KPiAgCj4gIAltbWFwX3JlYWRfbG9jayhtbSk7
Cj4gK3JldHJ5X3dyaXRlX2xvY2tlZDoKPiAgCW11dGV4X2xvY2soJnN2bXMtPmxvY2spOwo+ICAJ
cHJhbmdlID0gc3ZtX3JhbmdlX2Zyb21fYWRkcihzdm1zLCBhZGRyLCBOVUxMKTsKPiAgCWlmICgh
cHJhbmdlKSB7Cj4gIAkJcHJfZGVidWcoImZhaWxlZCB0byBmaW5kIHByYW5nZSBzdm1zIDB4JXAg
YWRkcmVzcyBbMHglbGx4XVxuIiwKPiAgCQkJIHN2bXMsIGFkZHIpOwo+IC0JCXIgPSAtRUZBVUxU
Owo+IC0JCWdvdG8gb3V0X3VubG9ja19zdm1zOwo+ICsJCWlmICghd3JpdGVfbG9ja2VkKSB7Cj4g
KwkJCS8qIE5lZWQgdGhlIHdyaXRlIGxvY2sgdG8gY3JlYXRlIG5ldyByYW5nZSB3aXRoIE1NVSBu
b3RpZmllci4KPiArCQkJICogQWxzbyBmbHVzaCBwZW5kaW5nIGRlZmVycmVkIHdvcmsgdG8gbWFr
ZSBzdXJlIHRoZSBpbnRlcnZhbAo+ICsJCQkgKiB0cmVlIGlzIHVwIHRvIGRhdGUgYmVmb3JlIHdl
IGFkZCBhIG5ldyByYW5nZQo+ICsJCQkgKi8KPiArCQkJbXV0ZXhfdW5sb2NrKCZzdm1zLT5sb2Nr
KTsKPiArCQkJbW1hcF9yZWFkX3VubG9jayhtbSk7Cj4gKwkJCXN2bV9yYW5nZV9saXN0X2xvY2tf
YW5kX2ZsdXNoX3dvcmsoc3ZtcywgbW0pOwo+ICsJCQl3cml0ZV9sb2NrZWQgPSB0cnVlOwo+ICsJ
CQlnb3RvIHJldHJ5X3dyaXRlX2xvY2tlZDsKPiArCQl9Cj4gKwkJcHJhbmdlID0gc3ZtX3Jhbmdl
X2NyZWF0ZV91bnJlZ2lzdGVyZWRfcmFuZ2UoYWRldiwgcCwgbW0sIGFkZHIpOwo+ICsJCWlmICgh
cHJhbmdlKSB7Cj4gKwkJCXByX2RlYnVnKCJmYWlsZWQgdG8gY3JlYXRlIHVucmVnaXN0ZXJkIHJh
bmdlIHN2bXMgMHglcCBhZGRyZXNzIFsweCVsbHhdXG4iLAo+ICsJCQlzdm1zLCBhZGRyKTsKPiAr
CQkJbW1hcF93cml0ZV9kb3duZ3JhZGUobW0pOwo+ICsJCQlyID0gLUVGQVVMVDsKPiArCQkJZ290
byBvdXRfdW5sb2NrX3N2bXM7Cj4gKwkJfQo+ICAJfQo+ICsJaWYgKHdyaXRlX2xvY2tlZCkKPiAr
CQltbWFwX3dyaXRlX2Rvd25ncmFkZShtbSk7Cj4gIAo+ICAJbXV0ZXhfbG9jaygmcHJhbmdlLT5t
aWdyYXRlX211dGV4KTsKPiAgCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
