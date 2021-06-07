Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF01C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 08:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49895610FC
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 08:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49895610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED49A6E887;
	Mon,  7 Jun 2021 08:59:22 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 529C56E887
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 08:59:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDvsSxIJUItYMxfgJJo1ooapG8GIZx2pY0i/O4aLtImG+zSBk6aGU9Xc9NHVqGdM+KDJBK0xmbCrgs/05YMc1jvARuhiAbpP7SKIj/jQMliBUT4ORA37aGUtPbomHZLzeM1Aem9YqGsy8W6su5Qqnu2qsozB4TNa51fbMT0eeWW3n1N8KRFTCBhbXkHK9idIT5KYuH6Ue8yWqZvHjyj4sY1IgNJPDEu4atSneTqHgYOGydHstTJH2g1UYRwIlsvAZ5JlOWAU+8/3Va5DA+UY0/Xlca4xVgY8wz8EtfmUXPowDRqSddpcqtCE8BjXum8PmGmBhUzeI4iJRAsxnwiROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaDoFk1e+3mpgzYiUhhI9ezSwwV1KG66BESo/oL9pDQ=;
 b=WU884SzCKjAXYspNS25uJk/CvGVibr/RZgyMf9hE3MM32iGuBmCRKQaShMQiyepbAPHNc6e1zX3JR9ddp3CaBy04d73pJORaV0uPDV/VcOLyhopLCyrc3V5fJcymqveHi7r1S4dth0EnFdmPIOu0qneQckmU6C65y1o2m6M9PnTCl4rSq3Owtz6OqcC+wy0jUyCVMqhR0F36YMdVfY+1dQ+TNL5UugRJE2ybuPs0hTK5wkZMvWUVwnojcunCBFLxFfnQMEXQSvaEy6lMMkffpr4vBZ6TgFyW7lMGOdLCEydvsq+UwawgJLrt0gaVpxRBw5gNBTt2MwtkOsDBXsQMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaDoFk1e+3mpgzYiUhhI9ezSwwV1KG66BESo/oL9pDQ=;
 b=D+7Kl3MVwbjmU3eLcqU4StP2Ts8VSN6wbseY28tyA5FFnBQYWYZ+Lj15aKhxOq0yR3XirRngotLetcOB2QXivtbnj/sAHx3DLOKeAoL3QxsK9KxyofAwPcU9KNcFWxLbkT1btDEBVzp7ltpp5qvLYVjeZG6K1DnA9+WH0LcFJSg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5117.namprd12.prod.outlook.com (2603:10b6:5:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 08:59:21 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.037; Mon, 7 Jun 2021
 08:59:21 +0000
Subject: Re: [PATCH] drm/amdgpu: fix VM handling for GART allocations
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Agustin.Gutierrez@amd.com
References: <20210605145155.1468-1-christian.koenig@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <dc24d382-c2ca-a8b9-b481-cfda5549a341@amd.com>
Date: Mon, 7 Jun 2021 10:59:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210605145155.1468-1-christian.koenig@amd.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f23:f000:35b7:4019:acfe:19dd]
X-ClientProxiedBy: FR3P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::9) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f23:f000:35b7:4019:acfe:19dd]
 (2003:c5:8f23:f000:35b7:4019:acfe:19dd) by
 FR3P281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.10 via Frontend Transport; Mon, 7 Jun 2021 08:59:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d7e21a6-f2e7-4f1d-6280-08d929928a0d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5117:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51179D5E1222D3E2B140BE508B389@DM4PR12MB5117.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5JH14LvPlO2BvU4qVvr/GqwD+JbvXIkPphxYSJq2z1TBhWqTvGIzmNiUtx+NqTJ8/OcrQydAAwOYtR9zG+cS67omQUi1m77Eib5hASWqbQ2wy/8NmYdfmLLHrTzBM5IauSRbxG3lsJL3AMztBbHwz533zUjB6ifa0LLNhbRPV9olQaBdDkpaT/7UMY5Fk5mOnDKfaERwdiHDGBEEkO9+/2APiFh71rVV/udZfajJhTh6W0ul/4vfW2cBZXm3oq1MnRjl4LsQz8JKuU3qMh/fBmW14tY2Z/ieRjDwhGeSlSbu/2VYaRCxGNa7gPxFPBz0MASx0QW2CSef1xaXPb2JU2tKTdXeimzlhCYQ9Nk97mLJFyWvKEGryKNNtXCgt+DuVYLosbS1Aj0H6/1den5gW4CoGFxppyjeiy8N1ob/efCR1pBMIPnYhsJB0f/ohpILfPg3vnOiUoIUySYzuFy2Et6QIKWbzrNRKQLz9P8mnOCFGC5Tx/adZ9lVg1J68eE+yJY9R8hefH9SM2dP0oo5uC8ijncG2U8I5POQlGMppNBwOuA3nUoHhZ5UbDLueXyxcOc9TXWVRX7fnPPBy9vVrGGZbvy3hofRunAOEzc1kk4PUJkxNzluGwG5EtNgyfTzewGPOoL3t0+fe4rqXnA7+1nIWA+vyq4kdODm2vERjbpWs/aY6Zv6ShQIDuZiE8UH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(6486002)(38100700002)(53546011)(31686004)(2906002)(186003)(6636002)(36756003)(16526019)(86362001)(83380400001)(8676002)(2616005)(66556008)(52116002)(66574015)(66476007)(6666004)(5660300002)(66946007)(478600001)(8936002)(316002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TlpTYkcwMTNwU2hwZEp4bFh6M3VQVDVKRWdkV2hkSzhCbGlVOW55S3lmWGlE?=
 =?utf-8?B?MHI0QUNjdDRlZTVrQitsaUNxU1JyUUtJeVhCMUZUU21kVjZFSFFaaFlEK014?=
 =?utf-8?B?Mm5PazN3OFpQWk9XTVpGKzhEWFVEbXFJeU4yU0pvTFNwNno4ek4yNG8yTElG?=
 =?utf-8?B?U1c2NmhGUUs1SFVMUHVjUGcrbGR4TTJ4THhsdk5JcHdEOXBRWml6cm8rNW1U?=
 =?utf-8?B?bGlPdy9KOURCTk5odEFheUZTV2pjeS9xR1cyeStwQnJMbHlWOVVwcS9YVG5X?=
 =?utf-8?B?UG5EeDdhRnI0OXFYeW9EdGZ5K1BMWTRpYXUwNEhRclRJTHE0Z1BPaUFzOXlX?=
 =?utf-8?B?UEhYZlIvcGgzZytUUVA1aitlMEtibmN6cndXL0pQL0RvY1Y3NVJldGFhUzlO?=
 =?utf-8?B?eGNJVG5OSHpDT0d3eDJMT01UdEJIQUUxMHBtbnMwQ0dWOENiUnhybUJnQ0xX?=
 =?utf-8?B?eDZXNDcxcVZRNGJqakZ3QnVBS0hmU1Nua0dnREt5MWVNS0FuOENXMDNXeWVy?=
 =?utf-8?B?VXFVUXJRN1ljd1IvcFUxaVlEWVVoOGNUZDdwRzF0WkNONnhieFJEanNHdi9V?=
 =?utf-8?B?LzF0YlhpbjVDUDZtVm5BcnBaL0Iwc1F4RGJoMGxScXJQd282OXNOc2Z1VmF3?=
 =?utf-8?B?eWRoRHBuemdHTngraU9udDFvc0lYanZyVEx6RG9LZUxBalRheUxDanJmbFZL?=
 =?utf-8?B?Zllhbkc5a09xZ1FlUkxTT0VCY0dqN2I2Yk50Q3lMSmRIdk1RVEtoNjFSS0NZ?=
 =?utf-8?B?UFFma0pjb0l0TThqUjNBZDNtRGdwYnByNWo3TlVkUnUvRHpHOTlsQWJBdkhx?=
 =?utf-8?B?clJaUW8vTUhVaHhiSlYxU3MraTdkZ042S2xHcEhRRDdGRTlJZ2JKRmJnYmFK?=
 =?utf-8?B?U1RtWE9IM0wzVkgyL2VIbW14Wnp0NnRrdFZxS0ZVeUs5cXAwWVdUQnV2dHRy?=
 =?utf-8?B?QngzNzlISG5nN0I5Rjd4Zlgway9NSjF2ZFhXeG9PQ3RPRzIrb3pYR3oraVA5?=
 =?utf-8?B?UWROQXlmSEtuY1lQRVk3SmNXRFhJZmJ2TVdtUlFyL0kxZE1jbFdOSmVvZCtt?=
 =?utf-8?B?WXdqcEF4dEgrYy9TcDQ1SnJYTWZOWFNWek5WUmdtWENaVWJTWmpNRGlUU3B2?=
 =?utf-8?B?L0NwUDFJVkNXdWhzSVFLa25Ycy8zSUtJc0F6cVk1eWhIK1ZVQjdzeVZpTXJI?=
 =?utf-8?B?cDVIRnZxaC9wWkZmTEVDK1kwR2s2aWJveUNZeE9DZGNmb0RGMzBKazk0a3gz?=
 =?utf-8?B?SW1nOVRLWVlLSVg2VDNXaFh6TFAzTkFUcGUwOGkyTC9jZlcwOHovZjRnaEJ6?=
 =?utf-8?B?ZlMwcEZkVmw3dHEycXBhd2o0eGdEZlJBMzlkbDZUZGVKOWZQRHArcXJwQTAr?=
 =?utf-8?B?bmdKSjNnSTg4RUFMSnc3WisrL1JjVll3cUwxZFc4UmV4V09sSnh3MVJKcmdl?=
 =?utf-8?B?ZUxiSStTeVREODJDcmtXOFprYXI0cWZKdUNxdG8xOWxqSzFPSUdhWjlhS2dG?=
 =?utf-8?B?eHlpNDNlN1ZCV1F1TkwrQTlGRmpBZFJWWGp0NlBtTjhXbzJZY1Z6UWVDNlBN?=
 =?utf-8?B?K3EyeVlKNVFweWFEYkgzRjhOMkJQNWtBMTBIcHNPd1grR2h1TXNLOWdhTllQ?=
 =?utf-8?B?blZPeTZ2NHpMbHpTZWFoejQvZThwUkxla3JjNkJTVmJ4R0Yvbnd2MDFsYjk3?=
 =?utf-8?B?amtkbXZ5em92WVRVTDZHOGpwaHdicmRGUmJwTS9RR3ZORlNSejVidHN3WkdI?=
 =?utf-8?B?Z3NNS3RmQm9QWFpqbUUxQU1pcmt2VUZteHZHVVh2RDJxV2M3QzduNDNMdkQ0?=
 =?utf-8?B?NmpIWFBhMHpyK25Cc2g0WThlWExDV3p5ZE9xSTMyaXdMeGw1amtBSkhiTFBv?=
 =?utf-8?Q?bXgYcgQ8i/qA1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7e21a6-f2e7-4f1d-6280-08d929928a0d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 08:59:20.9614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbzJX2HH3AH2DlQcVufcyWSVlL91vzXp+bepFAPxZwiKIDPABQnoIDq1rYU491VjExPNznOBzz13cSLRtaMl3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5117
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

UmV2aWV3ZWQtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KCk9uIDYvNS8yMDIx
IDQ6NTEgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gRm9yIEdUVCBhbGxvY2F0aW9ucyB3
aXRoIGEgR0FSVCBhZGRyZXNzIHRoZSByZXMgY29udGFpbnMgdGhlIFZNSUQwCj4gYWRkcmVzc2Vz
IGFuZCBjYW4ndCBiZSB1c2VkIGZvciBWTSBoYW5kbGluZy4KPgo+IFNvIGlnbm9yZSB0aGUgcmVz
IHdoZW4gdGhlIHBhZ2VzIGFycmF5IGlzIGdpdmVuIG9yIHdlIGZpbGwgdGhlIHBhZ2UKPiB0YWJs
ZXMgd2l0aCBub25zZW5zZS4KPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jIHwgNCArKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMKPiBpbmRleCBjMjlmYWQ5N2I2M2EuLjQzMzY0MmIzZTQ5OCAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTE3MDUsOCArMTcwNSw4IEBAIGludCBhbWRn
cHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJ
aWYgKHIpCj4gICAJCWdvdG8gZXJyb3JfdW5sb2NrOwo+ICAgCj4gLQlhbWRncHVfcmVzX2ZpcnN0
KHJlcywgb2Zmc2V0LCAobGFzdCAtIHN0YXJ0ICsgMSkgKiBBTURHUFVfR1BVX1BBR0VfU0laRSwK
PiAtCQkJICZjdXJzb3IpOwo+ICsJYW1kZ3B1X3Jlc19maXJzdChwYWdlc19hZGRyID8gTlVMTCA6
IHJlcywgb2Zmc2V0LAo+ICsJCQkgKGxhc3QgLSBzdGFydCArIDEpICogQU1ER1BVX0dQVV9QQUdF
X1NJWkUsICZjdXJzb3IpOwo+ICAgCXdoaWxlIChjdXJzb3IucmVtYWluaW5nKSB7Cj4gICAJCXVp
bnQ2NF90IHRtcCwgbnVtX2VudHJpZXMsIGFkZHI7Cj4gICAKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
