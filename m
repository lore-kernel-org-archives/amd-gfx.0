Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3310FC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 18:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5F764FD4
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 18:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5F764FD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 256E66EB11;
	Thu, 11 Mar 2021 18:42:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 042466EB11
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 18:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ye8gTgE/FATVt63VRAqnOKFgM1IOMoZsRKp6JZYZKrQsE3Fj5ZXYYJiqnWQC1840jJQXzMFiTt0plAdKMk3t2/u7LZNi+3Zyf/SyBVhnI9UKokOhoceYUFg1qlUtyuLCcvMTqVvPuiEVwfFwUWOHI4HvEtJzpZprswrrJSpr5E+gAqBjyr5Wzk8zrQNCgmQpVYhom7EIWq2bY9Z1SqNv9McfZiMMixAmHvTjJAcEHoGsMX4YskJxaTaHgwa2OVWeQMUCoAN3Vtyx/1+bRcpCUiDAH/jILWsJx17uurjZw11TlKElN8y7PCGomsYuAvD2gABE8Mhr/Zl5EIfopEQYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uG4jQ9ac9vhTingWwj93Nxy1IKfe5MCvdaFshWvoqzQ=;
 b=CTnogC5KTQhXXb+YKptxcpLFeAw03IgiL3H1zldnRemuwJQuEggl7NrhAG7/HD1JgpkAS86h+YMO0kfKEzrXww6UI3OwJ29SIGQM/qOhdpmKj6AhLuDVCBOVJxXAJzj8JDun6HVWC5OaLTjPGnQX5fU+SLew9uJDrN7CN7taww4NiMha5dD1EkuE/YDHfzgHp4EEEvT3AzYkNLgOWWzr73+mPji60HkWgywdr0MbUG0a9pBtDbWA9uZ5DUYuJ4gyX1X8YTHZ9xbGbqFFgyX/O43DKNvuQjitUs6P8kQ87yfa/7DtsWT88+/C4YGBNeeDIZLW1AwkaxhqObcjgh/XUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uG4jQ9ac9vhTingWwj93Nxy1IKfe5MCvdaFshWvoqzQ=;
 b=2uAwclzR+e/dlnvmywDUWu7OGHnQEDTB11H7cGoCysx/2eRyYFotIpEw6VBrYcxUQqysVpsotz1YBej1eiSvnAazp+BRo1k1cBMVaoti4JpTggoohJ7uRdpm9qSeGzXRXsEg7DmhdJNMaoJlzNeMrQVmHwx+vrAIUWIdl6eHbqs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Thu, 11 Mar
 2021 18:42:02 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%9]) with mapi id 15.20.3784.031; Thu, 11 Mar 2021
 18:42:02 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: Bump KFD API version
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210309200644.28188-1-Felix.Kuehling@amd.com>
 <MN2PR12MB448886713A8239A84D2FEF69F7929@MN2PR12MB4488.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <52e7128d-f899-08ad-c441-655d8e9988a1@amd.com>
Date: Thu, 11 Mar 2021 13:42:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <MN2PR12MB448886713A8239A84D2FEF69F7929@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::47) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend
 Transport; Thu, 11 Mar 2021 18:42:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f8e60c8-42de-42b6-bc58-08d8e4bd5c27
X-MS-TrafficTypeDiagnostic: MN2PR12MB4302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4302E26CDDAB6854436CD49192909@MN2PR12MB4302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kw5OCSjIpcjlKrIWBWvfeA0joP1dq2HYC1UVbpfOYZeHheTOL3AyfbfBWA00wFqmbvOarQIh+HfhX13I0xvLXklKAVAZ9/Q3YkXg6es7INNIgCtnMU+D5bDPwDhnCl6B5E2oPGSDKka+rACgGNS9Br6YdWQpoEFmXhsLzf9m5gupe2oZc1gAD1WCIq8ieu9JIchUVfG0ESmM6cEfDD5RQbPeye4HzPoaN8ynmcZcAm4BDnqCcueEVM8Q8anmbUCDrD5ARLYPsYE5X/1IU36KtQCzqVQdQbPT7pQVlbZkR+iLUnjmTDYuBE5fRuYzyxTymsbecYPuiMVJA7mupUVeakIYc7b/Jh/eOqgePBO1KtN5txUlt7Gnyr5VZGqxMlN9/grsxxUexLMg1m2xb0gmapv86h2tz5EY2v4TfJ0CVo31cBFkcbep28a97JBePAkMcSXdyyHXvvIKnzhPyeXKlpF9bImsDMTWw2zzI0975uws6Cla+GpUIZzIRG2/IUgWNHaCvZwY6LggaxINGZxrw/Rz4pDWIgv7fw/Xwb2lwhJHV+BHZF1Y/D6vCl3wIB/g+3P+7GKAFAL7Q0IkMmBf8KPOw7kkfSkVbzF/12N6+fI5eCHzRMzkMq4QLd88JBESOXyMSWDHQlQolwXRQuRtOM2kS7KAPRDCSEQEhM4HtBR56XKsvfk8b3a2f+BN8siZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(36916002)(31686004)(86362001)(8676002)(52116002)(44832011)(2906002)(478600001)(8936002)(16576012)(316002)(5660300002)(31696002)(83380400001)(966005)(110136005)(36756003)(2616005)(4326008)(53546011)(956004)(26005)(66946007)(66476007)(6486002)(66556008)(186003)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?enNFTGdZWVNlNGh5WWtWeG1rRHBqM3lDY0hab2l1TzdTTi9JUVFxWlNUTzZZ?=
 =?utf-8?B?RkNpYk9FOGlLNnd5UXZWZTVacU8vSGFGclJWSjdqVGw2elpLeVQ1QUJLT0p6?=
 =?utf-8?B?bS84WEJrV3V0UFAyZ2JidldhUys4aUVXd0hGVlo5WlBrV0xZYnMzQnUza3Zt?=
 =?utf-8?B?M0Y2eHdUUHlMcEdNRzc4czNKRUpaa0ROOThlWUVQWE1LaldHS3UrcytRWjVp?=
 =?utf-8?B?QUY0akhqWEhNZXRHYTk4NFgzWis4Si9jMGgyekNMK3JyOENTZ1BpaWF4Q0xK?=
 =?utf-8?B?bDRpR0ZpeTJyY0hmcjhoVTVITXhpd2pyWkkrc0huQWI4SzdlMXM4ak5TOUxi?=
 =?utf-8?B?KzB3eEVkTHFZd1RaalpFQ2twMTR2amxuZ0VSZkpDNERldlBxNENUblMwN3Fh?=
 =?utf-8?B?VUQwK1dwTnBSUnRhMHlweTZHWmpzcVkrYWtndXA3U3ZWekVwbEgyREc0MDRH?=
 =?utf-8?B?alBZcnEvaXBFbktEOVEvSWs0dkFkZ3l1aFRjRkdlZld6Szh5UURLeG9FMUZa?=
 =?utf-8?B?dUI0aEpqcTJEUkthbGIvazBsOGI0OU5nZHNJWC83L3MydkNsVWk1dzZWejZL?=
 =?utf-8?B?SlJkVnd2cTZTNGFycjJoZG1Vd3RMcnQ5bjkvTWJOc0h2alhHWFdEWW5PUFZl?=
 =?utf-8?B?WGlkSjdXcUJnUXV4czFNUlIvSjUwTm1BWGZXV1hyZ1pJQy9YUFJrTFhtWUJu?=
 =?utf-8?B?RkRBNFE4MGovcnJ3STBBTU9qUlIxYVZSQ0hHR25HSlFsM1F0WHp4SDErUDNm?=
 =?utf-8?B?TDJ5OFlXcWRrRFVDSmhBejdwSFJJbHJVZ3hzaWQ3SnN6ZlFtSVhmNXJyN3dy?=
 =?utf-8?B?dFFON3ZzL1dEWVFwNVJsdVh3aFZEbUJqZkpTS1hDLzg3OHM1Q0taaEJVaU1K?=
 =?utf-8?B?dE1EYVNYQUtsSUd0WE5hdHlqWnlTeXdiVTR3a0trZjhsSWtCakZyS0tveW1I?=
 =?utf-8?B?WUFIRXFRSmtUTWZ0bG01VUJaMUpydUdJdTFpQy9mSDFLclBsV291c2VqMEt0?=
 =?utf-8?B?cUFzb3BLR3ZsRzRheGxvTTJ6UGg2UmZRTUlhYkJDK3Zobk0zY3I5VklzeUty?=
 =?utf-8?B?dEtzNWtxeElpVjg3WFNONDZDdWFUcmxZbUFZbkp4L0NjeVNPbFZEU1lydEVK?=
 =?utf-8?B?T2JRbFlVOEpJZjlRUnRVNG5EakZ6VVNKUmxEa0RCRHNQK3IrN0svZ1JHbXJE?=
 =?utf-8?B?UzhkcnVTSjJyT1NGTnEyejlGL2pweDdzM2JlSk1Eekd1Y2VlcXZOa3B3SVlP?=
 =?utf-8?B?UUhJZWV3SEJCU3RDSTA5aHAvSTdwNlFLVVdtYzJJb201RjFXU2hPMnFzR3h0?=
 =?utf-8?B?b2p3VHhMakRqczlrT3JYZkNWSnhlalNaVUNEWU94VzJMZ3FubGFwbEJ6bjJQ?=
 =?utf-8?B?KzBYbHZsMHJ2U0JHekhvM01vS21VYWtlNjdPUGUraFcwamxXaGJiOW16N2c5?=
 =?utf-8?B?eHo3cXRHYzJjc3RsQjFBRXJmVU84cGtLWmRtNnZ0NVl3T0p0Q3hDc3lnSXlZ?=
 =?utf-8?B?bmUyVlRqNG82b3BYaFFHdUU5SHJqVmEvR2FGeU1vUXQwV1k4QXZuazNrSk1I?=
 =?utf-8?B?djl6dUVuSXNXbzF3Z0lEcUtvbWtSVVV0b1owQUpVR2NXdllTdVAva2xteHdy?=
 =?utf-8?B?enVCR0xpVk1wNHQxWmNGQ2h0eXliazlQUjk5U3hnZUd3MGhCVkNrVFpMVDNk?=
 =?utf-8?B?czNSTktpU2U5eUVYWTRtbVJIcUl0bGMyNjREOFhoY2VPNjFrMUZKTmZURldS?=
 =?utf-8?Q?piCXOEvWf6NVFypJS8EbNvPpTUCH2Nikb0HYhJu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8e60c8-42de-42b6-bc58-08d8e4bd5c27
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 18:42:02.0817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kT5bPwpbuzxBMJe5NkTEe13sudHvccJ21JdHHqQpfDeSFr/RkJO407DIc5UOhPKs94OChjCAoRlWsu5WIqseZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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
Cc: "Keely, Sean" <Sean.Keely@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIFRodW5rIGNoYW5nZSB0aGF0IHVzZXMgdGhlIHVwZGF0ZWQgY2FwYWJpbGl0eSBiaXQgaXMg
YXZhaWxhYmxlIGhlcmU6IApodHRwczovL2dpdGh1Yi5jb20vUmFkZW9uT3BlbkNvbXB1dGUvUk9D
VC1UaHVuay1JbnRlcmZhY2UvY29tbWl0LzdjZGQ2MzQ3NWMzNmJiOWY0OWJiOTYwZjkwZjlhOGNk
YjdlODBhMjEKCgpST0NyIHdpbGwgY2hlY2sgdGhlIEtGRCBBUEkgdmVyc2lvbiBpbiBvcmRlciB0
byBrbm93IHdoZXRoZXIgdGhlIFNSQU0gCkVDQyBjYXBhYmlsaXR5IHJlcG9ydGVkIGJ5IHRoZSBU
aHVuayBpcyByZWxpYWJsZS4KCgpSZWdhcmRzLAogwqAgRmVsaXgKCgpPbiAyMDIxLTAzLTA5IDM6
MTcgcC5tLiwgRGV1Y2hlciwgQWxleGFuZGVyIHdyb3RlOgo+Cj4gW0FNRCBPZmZpY2lhbCBVc2Ug
T25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQo+Cj4KPiBJZiB5b3UgaGF2ZSBhIGxp
bmsgdG8gdGhlIHVzZXJzcGFjZSBwYXRjaGVzIHRoYXQgdXNlIHRoaXMsIGl0IHdvdWxkIGJlIAo+
IGdvb2QgdG8gaW5jbHVkZSBpbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24uCj4KPiBBbGV4Cj4KPiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KPiAqRnJvbToqIGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5m
cmVlZGVza3RvcC5vcmc+IG9uIGJlaGFsZiBvZiAKPiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3Vl
aGxpbmdAYW1kLmNvbT4KPiAqU2VudDoqIFR1ZXNkYXksIE1hcmNoIDksIDIwMjEgMzowNiBQTQo+
ICpUbzoqIGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZz4KPiAqQ2M6KiBLZWVseSwgU2VhbiA8U2Vhbi5LZWVseUBhbWQuY29tPgo+ICpT
dWJqZWN0OiogW1BBVENIIDEvMV0gZHJtL2FtZGtmZDogQnVtcCBLRkQgQVBJIHZlcnNpb24KPiBJ
bmRpY2F0ZSB0aGUgYXZhaWxhYmlsaXR5IHJlbGlhYmxlIFNSQU0gRURDIHN0YXRlIGluIHRoZSBu
ZXcgYml0Cj4gaW4gdGhlIGRldmljZSBwcm9wZXJ0aWVzLgo+Cj4gU2lnbmVkLW9mZi1ieTogRmVs
aXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4gLS0tCj4gwqBpbmNsdWRlL3Vh
cGkvbGludXgva2ZkX2lvY3RsLmggfCAzICsrLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51
eC9rZmRfaW9jdGwuaCAKPiBiL2luY2x1ZGUvdWFwaS9saW51eC9rZmRfaW9jdGwuaAo+IGluZGV4
IDE4NDQ5Zjc0NjA5Ny4uYmY1ZTdkNzg0NmRkIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdWFwaS9s
aW51eC9rZmRfaW9jdGwuaAo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9rZmRfaW9jdGwuaAo+
IEBAIC0yOSw5ICsyOSwxMCBAQAo+IMKgLyoKPiDCoCAqIC0gMS4xIC0gaW5pdGlhbCB2ZXJzaW9u
Cj4gwqAgKiAtIDEuMyAtIEFkZCBTTUkgZXZlbnRzIHN1cHBvcnQKPiArICogLSAxLjQgLSBJbmRp
Y2F0ZSBuZXcgU1JBTSBFREMgYml0IGluIGRldmljZSBwcm9wZXJ0aWVzCj4gwqAgKi8KPiDCoCNk
ZWZpbmUgS0ZEX0lPQ1RMX01BSk9SX1ZFUlNJT04gMQo+IC0jZGVmaW5lIEtGRF9JT0NUTF9NSU5P
Ul9WRVJTSU9OIDMKPiArI2RlZmluZSBLRkRfSU9DVExfTUlOT1JfVkVSU0lPTiA0Cj4KPiDCoHN0
cnVjdCBrZmRfaW9jdGxfZ2V0X3ZlcnNpb25fYXJncyB7Cj4gwqDCoMKgwqDCoMKgwqDCoCBfX3Uz
MiBtYWpvcl92ZXJzaW9uO8KgwqDCoCAvKiBmcm9tIEtGRCAqLwo+IC0tIAo+IDIuMzAuMAo+Cj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4
IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
