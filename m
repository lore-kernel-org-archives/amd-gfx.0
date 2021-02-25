Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38745C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 09:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B841964F31
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 09:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B841964F31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47AA76E0F1;
	Thu, 25 Feb 2021 09:18:14 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E3466E0F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 09:18:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFfYtFCseTmL0KwwqZv0FYnQxyvhf93I/K9fIKfgcs1CllYIe2cwFdKAymKPKheTGaLK7/Wh3fmdXmahmowUiqKPDO2GnaI121+fEKmK3TpXezYx2KGgfFom1us7B4zn/3SwEMsKZqCDpQ+/GkGQcaqD1gCauutaJf5Lf1fKj53ZuyTVew80G6Xi2cVBYBwdNmAuz/I2pIq/PAEbFsFq/1X6l5RMxzIkvKQXQ1LAj5xiD5DXn09N5PDeOv/q+FuacrXHEdH4Cd/QiTNCe8pRKx+IuM2jteW6THm/bD0t0UQ/sgdFw3xdNZahps5tXkUoTd6FvtpVGAM4S2wWqIO6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwqq2BexbcjpCDZkmCcnmyUPXkRiHfcVWQhlmWdHRaU=;
 b=iKkillI7eyMKKShU+RtQB1KQWOYaGBgVP8Dm6Xxm3TCFqg7/YDc/jxnjD3Cdb5BO9GSb2ZWfRlbDzJ8UmYmUTbx0ByK+bjChSpwgai5yBt913SgJAdIyoG1P9iTvwmOg2ywCWg4u7PhFYJ5YzKpgiN+FyDqR7knshOsfLYkfG1Ofeyj1JsxRPKsqNvgJ2P7GbAyK4Ig0FgaovEdQ8+1bLzQBgmhPQF49JlIkhruTb5MeUTiTmu14hS0bG9ryttEBaJPRPsmUSy8dyISzvJdjjKJg2D11qyPpRhW+az2AuPTXy+hRhgy2U83w24unUBwKXfc9te8YN9vsDIsJQzJZww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwqq2BexbcjpCDZkmCcnmyUPXkRiHfcVWQhlmWdHRaU=;
 b=d9r+Aspb9e2KK1ouVSuWqn81UvXSY0rESvE6HE3uwIE5YQRbob/90qig5Mcn4WZjj4d63dJ2Ws0PDzztJgR2p5LE4EzqeHp3DFnvSEv6ccMiKjO90VqNrRZIAgGCwM9Khz6yAPbKJohcfMvEKdO4xVhZQIzNVkn/9tBTd3khsMA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4930.namprd12.prod.outlook.com (2603:10b6:208:1c8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Thu, 25 Feb
 2021 09:18:09 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 09:18:09 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: move inc gpu_reset_counter after
 drm_sched_stop
To: Jingwen Chen <Jingwen.Chen2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210225091645.677055-1-Jingwen.Chen2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <508d32ca-5b99-5119-6d82-1c23cb31d9bf@amd.com>
Date: Thu, 25 Feb 2021 10:18:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210225091645.677055-1-Jingwen.Chen2@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:fc8:43:f4c0:95af]
X-ClientProxiedBy: AM0PR01CA0092.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::33) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:fc8:43:f4c0:95af]
 (2a02:908:1252:fb60:fc8:43:f4c0:95af) by
 AM0PR01CA0092.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Thu, 25 Feb 2021 09:18:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 763d26eb-8826-491b-0f0d-08d8d96e440e
X-MS-TrafficTypeDiagnostic: BL0PR12MB4930:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB49307D7FD96F4997867F1D40839E9@BL0PR12MB4930.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GE1328gk++dGsw6iaE/c1s2jpy6p27CAPnBsTIPMyihw2vdtZ72hmrWKy+zBwn8W9OJD4Ooqkynuri2liefgbz+WibDuXArWlHWW+lX5dfPZuMmOnJjafZIxpNYGkLLQc4HNJObUhu08lsUNvYX1MBNyZGxGGZhTNuYWjHVZMTjaEM5R1i4/ngvTjF2pRJja0itHZo7J6DEqqx9EEFliWos2kYoZA+VX5QvnVWdCK10Z3bqd9PxD8Kifrqt7icWk1d2hx9n72Esp4izv9qLZHtVk3yj7lG7+ocwJ0mxwaqWL3UzJCNt/CDJMT/HhexafwU6hUYBewzzHeO2HU/atuS6zxHTbAymd6GsxqVPUSpKoDJui7zDhS4dxxFbV6SrE0N7t8gmp/QVqJ+Ag/9JVKoMkOcSY8ACMnb0jY54VVPDFpeYAlcTkUZNqL/02vlppjBBA/QvCF7yUSwtieRhnBEw6zCX/Vo3Rjv0pHiOUQC9rOXcgvPuX2ijDALL1OpUV4N1iHzfzvrk/PnoKlOcPVQZb0DU45bjqmIE4Bko07gkS6NoUCix5OrWWl6XLbdnJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(8676002)(5660300002)(6666004)(31686004)(8936002)(86362001)(31696002)(4326008)(66574015)(52116002)(83380400001)(316002)(186003)(16526019)(66946007)(2906002)(2616005)(6486002)(66476007)(66556008)(36756003)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UGJ0VlR3NjNwNTlIekovcUJ2akR6MWNqVDhIRjIrY2dLc1VLZU96NkcrYytT?=
 =?utf-8?B?dFZ4ZGFNQTZkUTlpVW02RWtpV1NFdWw2UDk3SUNmRjNIZWtKbFU2NFh3USt4?=
 =?utf-8?B?SE9VWWN0WDlPdmxWektqYUdxYThHcGhicm4zSEEwMEhIS0MzM050dEdrUThW?=
 =?utf-8?B?ZnVadkZiVVdsT3NJRysrdUdJdFN6OU1zV2tHMHBibFpOMVZxRTVjWU5jQTRS?=
 =?utf-8?B?eDlGdTBzR0V3b1VTL1VoeDFQd1FEMzh0NU56VitvYnBKR1A4M2hmY2hHUUlo?=
 =?utf-8?B?dldabHRTaUJWNVBJR2J2QlhJdjNmK0h5TnMxQXpaWHNXUWRnRjdNSkpIWHVS?=
 =?utf-8?B?UkhnajhIYmR1aHdpdVFxOUZ5ZVlsdWUvY3dVdkc4RUtDZ0R0T0hPR2lhNmtk?=
 =?utf-8?B?VGMzdjZWd2ZKQVhaR1kvZWZ4Yjg1bUNJeTI4Ym1YMHdOS0luSkhKMDdZWTZU?=
 =?utf-8?B?QWhjekozcmh0dVBSU0UvcmlkSkI2V2xLaFhEV2VoOFdHOXoyRVlSRzBxUFRH?=
 =?utf-8?B?QXVoaGFCTjB3RTdHcGNiWlQ2dlJ3NUU3akJyMFgvRjVEZ2NhYXhNbFh4NGdQ?=
 =?utf-8?B?K3BiSlEvS0N6bEhPM05keHBvN2NkYVdlazhBSk1xUWNYamF0cHRoRWlETTQ0?=
 =?utf-8?B?OFB4d2ljdENEMXBqRlRwQXFERkNpRzgyeER6SFN0cERzUzZ3QmloYTAzeldG?=
 =?utf-8?B?V2RKaTVTOFZyZXlJWnFpcGV4b3pJeDNxaVQ1RmVDb3NSUEc5NXBCL0M0RW00?=
 =?utf-8?B?OXdUbmkxbFNGRDR5MnQrQlgvb0NSVHZ0T1ZxcXBNdUFkZmF0MFVhNmllYVRy?=
 =?utf-8?B?R0lNbm1uVFduK1JWdys3OXVNZUNFeEpLdllaUUNtUk5Qd0JrMENMdnBmcWta?=
 =?utf-8?B?SFU1emxKWWk5UCt0ZXU3NVhjdnlWZVVaKzMwZXNvL0puZE1hemltQkRPdFly?=
 =?utf-8?B?RFZZTEZNVng0WWZqYUFJTnpBTWw4NUlPeFFGRFpwREFvWUJOdldqbHc0b1hs?=
 =?utf-8?B?U2hkVUwrdEg3cGsxbVZpeTM3QTBlbHpZSW9jNGJKdVZocXlicVZvNDZFc2J6?=
 =?utf-8?B?elkyN20rU3BlZk5raDltc3JHWWcyY2pDRzZ5ejJrcTRwVmhLeE45YTBZME9y?=
 =?utf-8?B?bTlXQWJKMzI0amJvMFZXUkFLZVA5NjhGZVFsdm9sN0hsUUVGSW5XUUl3bURV?=
 =?utf-8?B?N2d3aS9kNmtub2ovZlpPTnAyZ1NmTGhUbVdDRS9Bb21hcWk4YjdsTVBnUFJ6?=
 =?utf-8?B?dGRLTG96V25EeHh3aWErWjZXMVAvTjBzOS9zaElWanlNVDhRalRCOVVXZE9U?=
 =?utf-8?B?MGNrcnBQYVdUR0p4OHdJM2Vjb2krRDZDbFlibUJmc25uZklCalh4ODBUbytj?=
 =?utf-8?B?YVdzWllmN2FNdUZELzBZNzA5cWpDUzBITGtiUWxROTRzMGc1bmhSclpVSlVC?=
 =?utf-8?B?aFk3cXFlcUV3RGg4TEhPNEtEVzRMZ3YyeUpub2lraWVJaW4zVjNNdk1xRHdU?=
 =?utf-8?B?SzNTS0FSRG5KcENZaGxqUmRHTE1wZ3NkUVdOTmU2Zy85TXovZlh4c0JIVUZJ?=
 =?utf-8?B?V0Naemc3VFRuTEQzNGlwYTdsOUNkZVhUaGxyMFI2ZVMzRGx0TDk2UlJvUjVC?=
 =?utf-8?B?RnVrYmxSMU5uVTZXeEZjbWRrclRCMmRHalNtMDVudXU2TWpjWER5aVlLWmg5?=
 =?utf-8?B?cG5lcGJQbHlWcEJjU2JwYjlqanJMQXFMaVVydmRxKzBRME1XZWU4UWh5U1RZ?=
 =?utf-8?B?dFZ6S25zUVdzb3RvdnJabkRCekdpdG05VVZ0T3J3VzgyNkxnb2h0d2lEaWQz?=
 =?utf-8?B?L3dNNHUxUGpJM1RLdGQ5NzNUODVMbVdld2dvY3BQMjg5Qm5pbGR0YUdINFo5?=
 =?utf-8?Q?+Jkk3mkUrRnjy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763d26eb-8826-491b-0f0d-08d8d96e440e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 09:18:08.9124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omvLepThY5R6ov+EHCgWreOuT3coaHvQW+fW2n5ItBfeRaP8+fJUqumx4vWtySbF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4930
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
Cc: monk.liu@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjUuMDIuMjEgdW0gMTA6MTYgc2NocmllYiBKaW5nd2VuIENoZW46Cj4gTW92ZSBncHVfcmVz
ZXRfY291bnRlciBhZnRlciBkcm1fc2NoZWRfc3RvcCB0byBhdm9pZCByYWNlCj4gY29uZGl0aW9u
IGNhdXNlZCBieSBqb2Igc3VibWl0dGVkIGJldHdlZW4gcmVzZXRfY291bnQgKzEgYW5kCj4gZHJt
X3NjaGVkX3N0b3AuCj4KPiBTaWduZWQtb2ZmLWJ5OiBKaW5nd2VuIENoZW4gPEppbmd3ZW4uQ2hl
bjJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jIHwgMyArKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMKPiBpbmRleCBmMGY3ZWQ0MmVlN2YuLjcwM2I5NmNmMzU2MCAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBAQCAtNDQ0Nyw3ICs0NDQ3LDYgQEAg
c3RhdGljIGJvb2wgYW1kZ3B1X2RldmljZV9sb2NrX2FkZXYoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsCj4gICAJCWRvd25fd3JpdGUoJmFkZXYtPnJlc2V0X3NlbSk7Cj4gICAJfQo+ICAgCj4g
LQlhdG9taWNfaW5jKCZhZGV2LT5ncHVfcmVzZXRfY291bnRlcik7Cj4gICAJc3dpdGNoIChhbWRn
cHVfYXNpY19yZXNldF9tZXRob2QoYWRldikpIHsKPiAgIAljYXNlIEFNRF9SRVNFVF9NRVRIT0Rf
TU9ERTE6Cj4gICAJCWFkZXYtPm1wMV9zdGF0ZSA9IFBQX01QMV9TVEFURV9TSFVURE9XTjsKPiBA
QCAtNDcwOCw2ICs0NzA3LDcgQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCQlpZiAobmVlZF9lbWVyZ2VuY3lfcmVzdGFydCkK
PiAgIAkJCQlhbWRncHVfam9iX3N0b3BfYWxsX2pvYnNfb25fc2NoZWQoJnJpbmctPnNjaGVkKTsK
PiAgIAkJfQo+ICsJCWF0b21pY19pbmMoJnRtcF9hZGV2LT5ncHVfcmVzZXRfY291bnRlcik7Cj4g
ICAJfQo+ICAgCj4gICAJaWYgKG5lZWRfZW1lcmdlbmN5X3Jlc3RhcnQpCj4gQEAgLTUwNTAsNiAr
NTA1MCw3IEBAIHBjaV9lcnNfcmVzdWx0X3QgYW1kZ3B1X3BjaV9lcnJvcl9kZXRlY3RlZChzdHJ1
Y3QgcGNpX2RldiAqcGRldiwgcGNpX2NoYW5uZWxfc3RhCj4gICAKPiAgIAkJCWRybV9zY2hlZF9z
dG9wKCZyaW5nLT5zY2hlZCwgTlVMTCk7Cj4gICAJCX0KPiArCQlhdG9taWNfaW5jKCZhZGV2LT5n
cHVfcmVzZXRfY291bnRlcik7Cj4gICAJCXJldHVybiBQQ0lfRVJTX1JFU1VMVF9ORUVEX1JFU0VU
Owo+ICAgCWNhc2UgcGNpX2NoYW5uZWxfaW9fcGVybV9mYWlsdXJlOgo+ICAgCQkvKiBQZXJtYW5l
bnQgZXJyb3IsIHByZXBhcmUgZm9yIGRldmljZSByZW1vdmFsICovCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
