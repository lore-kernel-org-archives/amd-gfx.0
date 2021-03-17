Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F04C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B5864F92
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B5864F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 245A489E1D;
	Wed, 17 Mar 2021 08:13:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6656E89E1D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 08:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmCaA+ekU8hNK2RcAj0EX2Z5Qsla05UFp3u3W9ic458z5nVHOGzRudl+rb3RqPd84PFxk9ouWakiedH82fe5rHXWC3/b26kQV7C9febn8cwJk/r+laXMD8pze/6sDBNwTy2FJCmc7Zc8PqlZLg6uBwKTrfUdG7jS6RuzwGj86FpRirxNcCR3ISrwyu+vXuXBY+mdBOv9Nqm9Te7Bx9KZ+1YgRCp1o2gM5wk7qDVJ9ClMKf6Etgq4HKf4KQDmKBabbDhuFyl01z54lRu/nZvL0VkJAsxRoXrDwQWeTuF3TwT5fQvlS0dxXsUap+L4/uVVE+aCvLRXw+fuI256lPcIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt9S3uewc9XROR1YDT6yhO3OVyHpjRrQpvCZnKkTVJM=;
 b=jyhz1o2Md6OoQQp8grRe5JBV6eFxitjs11Bix/787TzVquNUFsHOhRz8IKmUpt3qYef1mKfQbIXJyDd09u9kqpeCJlEjpcSPpptDORIuGKUbRX7DK1h+fkWA4g4iPJQyuILOKBoD3P8s60ZhNeD2NydLk6/h+lDZLKWCSHf+WTQXoVRTzgsyz8D3DazabhBis4rNWzJWTatnozBjkhF3xOmSLj1RcZHssygQg8l8jck+6bBYPBO5NF1InRaHK5lIpGKJFW8VgLytqiapz1O51+CG4PQmJHrZ/yD4Q/6i3IJiIXKV8Vr+/a9oN0hZVe6h2xVxKC5NthV1OLNCkG6lFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt9S3uewc9XROR1YDT6yhO3OVyHpjRrQpvCZnKkTVJM=;
 b=rnPpGraJzzQZoWOAubUBQyspBCvSMJ3fxvHnYnhHZRofLwDZyF3YPbfNZZZKIV8O/zSsFLRbqPW7wfNgb9I9WgF9S7+hUtze317dgo90OzVNY03CvUj8uMy6YsBh3EQaPdqkyTUoys1V+k3I6eq5T/sBbAAqQ74g3eeowHkJeGg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1640.namprd12.prod.outlook.com (2603:10b6:910:11::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 08:13:38 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 08:13:38 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu: use amdgpu_bo_dmabuf for shared prime
 count
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>
References: <20210317074716.5547-1-nirmoy.das@amd.com>
 <20210317074716.5547-4-nirmoy.das@amd.com>
 <c5931d1c-a535-b253-52d5-2fa069b7554d@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <93907598-3673-cf4d-3edd-21ca22e31a4c@amd.com>
Date: Wed, 17 Mar 2021 09:13:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <c5931d1c-a535-b253-52d5-2fa069b7554d@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.96.184]
X-ClientProxiedBy: AM8P189CA0027.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::32) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.96.184) by
 AM8P189CA0027.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 08:13:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 52d1ec7d-d6ee-4384-1d3a-08d8e91c912b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1640EFE368213C90116E3F318B6A9@CY4PR12MB1640.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLsChoNwXzq6VpMjR/H7gmJErvdm8uHrqYa+RXQbP06/DW8j9ZQPdQFI16/n5dpIdqq42xQ+ArZGnnWH0QVGUYNHlsM8nnuOrVb9feYu4GkyUPWrBXi1OabbuENYj0cWW2CdiV7imnRrOk3RLXYQhJP99fD3/bPuYzaMKl4BasHoGPpYyJUTB4NtGOYS3DWbcBQYbXutrMKnnC7yUh5WCUnF6vvm0o10oPoOVYWzGtpuzp/3m/FqHP9dGvw2E5Q17v1QPgk8aoni30BRiiIcpcAdIMrYTyLTEYXX/ETRyk0GNk9ULy5aIsArlM/wZ8dgaAxIL05v3IlbjkoBLIiZN3+4UzkEl1nxODxjx3Dj92t9mM9Yt6YA2U5XdWXRPtfFvafCcKaQny0awpwmwO/VuL5gu37bgzDBXdRxQjLXLrsA9CtsHV0iy8wDYOV4YmQ+sVK3GtajD6p1oQg0fbe0jsMbCld3UbvjdryCHxptKaTl0MizVpGzhrRAcSFxtX/ouGCPNDApJE+TDluZ+NsMRO1PKEV4ggfgDKIA6BMlD5ouvP3Rvr+8zixnDUGtUSe7OdeMNFSz0gppbGbqIiWOKgvD4Ul22hwt+6kYMkLmvXd2qig7feoagciDmWy7e4dbMk3XBWLZakFdfUq1dz5zRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(316002)(52116002)(16576012)(66574015)(66476007)(110136005)(31686004)(36756003)(956004)(6666004)(5660300002)(2616005)(66556008)(66946007)(83380400001)(6486002)(53546011)(31696002)(16526019)(2906002)(26005)(8936002)(6636002)(4326008)(8676002)(186003)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bkRjZ3dSdVduV09oeCtRNlNuOWFrRE95TmFRWGZmL1d5SHdDOHNZNWFIbjZS?=
 =?utf-8?B?YnJ2Q3VnRjNUL2N2anEwRnQ3dTdGMXQ1YXM1S0g3YXBUejIyUHJQSzVWYUw2?=
 =?utf-8?B?bzIxYStjRWdFRlVaM1JhVEhTbXE5MlBKejl5S0hENVZ4K1dKWndTbUhLa0R5?=
 =?utf-8?B?aXhueTJUYjVTUUN3eUJmK1BMcUMxSi8vL3RKUlN0Z3p2WWJjQjRRQmNYd1RG?=
 =?utf-8?B?OTBUTUtvYlB4YXE2cDZaWHl0Qys5MWVqOWYyM010VmZJTXF5cjlpZHBCYnRt?=
 =?utf-8?B?Y21aMExiNmZYNEJSRGZ1MkQ0MDZRSC9xS3dtQWFKaklNQUZvRHBlZW52Y1ZQ?=
 =?utf-8?B?K3pwcExVcGdTV1VsSHFmOHZORFQwajNsT05xSW1DY3d6QjR2eTZScG5CMTVm?=
 =?utf-8?B?N2d2WmRmVExxNDFqdVpObEs3S2x6V1UzaHlTdTBRTzdpWERLMU1sYzZlZ1Bk?=
 =?utf-8?B?R2VRTklqZXNNdXN4bDY2YkJNZmZOMjBTUW1UQnBJTTk0MktBRlQ3S2RYMHY3?=
 =?utf-8?B?a0J1eUVsSk5RYzVOMTFpRm9QYXluRFF0QWFBbitRRmQvNXk2ZHN6NFg0T0xS?=
 =?utf-8?B?WGU5WVg2RnpBTXJWcEVub2hHdmdqUVpjVVFGb2ZHalZ1aFF6SXBFNHA5cldk?=
 =?utf-8?B?MUlnQ2t5RURkelA4OXhVOGJSOUFHOStPOFZIV0h2QTMxa0RqMGVUcGV3cE81?=
 =?utf-8?B?aHdjUHpTdHl3b2prVjNjQmpaOVpKd2tCVnNEeXA3MkZFY0xCeTBGcFpnaEx5?=
 =?utf-8?B?bEhnUmQvdUtOSjBGSFVoVGRBV2VvZFhybFRUem1jeVJlbE1Mcy9vcHhURUJo?=
 =?utf-8?B?Q0wvOTk0WkJQRjkzelRlWFFMOWpBazllY1hPcG5ZWVducmN1b0xZbnZLdFdL?=
 =?utf-8?B?SCtrVVZKb05kTkRqNGltazNISjVtTHpUdXpwaVJPT3dhOVZJMjRlYldpK0pv?=
 =?utf-8?B?eDNyanM5Ly9tOFdYVFVKN3oyZGFDcEJ3N0xQd0E3cThlbFF6WHNEalZmbnlj?=
 =?utf-8?B?dDJ3eFJVNVlnRXk4OFp3QUM2ZUhaempKQk0zSkhCbloxc1RIQ2JvNlNZcmZG?=
 =?utf-8?B?NEIvNS9uZjh4M3hGWDdKY2tscFRIY1RDTFYzWmpwU2lXMHI4aXJFSXZMNzda?=
 =?utf-8?B?WENvQmE2RW5vczRrZlIvM3FMQWp0V3FTQXZWWjdEUGhpZTUyLzVPaGxzR00x?=
 =?utf-8?B?WlMwaEtreE1FUlZCclBtOTI1SE82KytTQm92VkNiTmJCVG9MdnJ2YzVBOUE3?=
 =?utf-8?B?T0RJbEFKWXgvcndQODEzejRvMlNydWVXMU45Z0FlVjZ0UmliNStwUERmMkZJ?=
 =?utf-8?B?OHdPdElzd0FYL0RmQlZNZER5cWp3N21kQ2kwWnpaTThoMERoNlcyWmord1Jy?=
 =?utf-8?B?c3RJZEJMbTRadXNTUm90R2FFdURKSSs1TW5IN0dhSkFSLzNjVTMwdWo3YnNZ?=
 =?utf-8?B?SzNYR2ZkaXMvcVFJZ3JsQmh4aXYvUjdpby9zNXpCTEsrWVhGMTYremk1Q3FB?=
 =?utf-8?B?cEYzZzFjTXVWSjFMTlphZ1pEcUZhVXVyWW96ZXg5WUl0dHhwMk9sSUlBVkVz?=
 =?utf-8?B?NUxiS214WTRIQVNxYldNZTlYcjA1NUlyaFlJYjlPRXhJUXcvWjFZQm84a2Ez?=
 =?utf-8?B?b3ZOODBsQUROeFZrZ01rc0tiQkNpL3NOUlplUWFsOFhKZndDNjZyWC9DNW04?=
 =?utf-8?B?OG1mNEFPNDhyYWR6TklYYzU4cHM0YlBydDJOWVg1eGJJNm16VTRQYStWSjhP?=
 =?utf-8?Q?EYjFdKfFcY2UyIGvhtZ38tZHP6dgx5BlpdOw4rS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d1ec7d-d6ee-4384-1d3a-08d8e91c912b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 08:13:37.9811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqM8SacOBREwkTA/5EM2tKBATg5qNyo3Wd38JoAaUeiqpkCIfPpV9j+b/mQujgO89LBWx+XrGxSfzLmWqQ/JKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1640
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDMvMTcvMjEgOTowNiBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBUaGF0IHdob2xl
IGFwcHJvYWNoIHdvbid0IHdvcmsgOikKPgo+IFRoZSBwcmltZV9zaGFyZWRfY291bnQgaXMgb24g
dGhlIGV4cG9ydGVkIEJPIGFuZCBub3Qgb24gdGhlIGltcG9ydGVkIG9uZS4KPgo+IFNvIGFueSB1
c2VyIEJPIGNhbiBiZSBleHBvcnRlZC4KCgpTbyBhbnkgQk8gZnJvbSBhbnkgZHJtIGRyaXZlciBp
cyBwb3NzaWJsZS4gTm8gd29uZGVyIGl0IHdvcmtlZCB3aXRoIAphbWRncHUtYW1kZ3B1IHRlc3Qg
bWFjaGluZS4KCk9LIHNjcmFwcGluZyB0aGUgc2VyaWVzIDovCgoKVGhhbmtzLAoKTmlybW95CgoK
Pgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4gQW0gMTcuMDMuMjEgdW0gMDg6NDcgc2Nocmll
YiBOaXJtb3kgRGFzOgo+PiBSZW1vdmUgcHJpbWVfc2hhcmVkX2NvdW50IGZyb20gYmFzZSBjbGFz
cyBhbmQgdXNlIHRoYXQKPj4gdGhlIHN1YmNsYXNzLCBhbWRncHVfYm9fZG1hYnVmLgo+Pgo+PiBT
aWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+IC0tLQo+PiDC
oCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuY8KgwqDCoMKgwqAgfMKgIDIg
Ky0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYyB8IDEy
ICsrKysrKysrLS0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Vt
LmPCoMKgwqDCoCB8wqAgMiArLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfb2JqZWN0LmPCoCB8wqAgMiArLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfb2JqZWN0LmjCoCB8wqAgMSAtCj4+IMKgIDUgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9jcy5jCj4+IGluZGV4IGI1Yzc2Njk5ODA0NS4uMDQ5OTQ3NTdjYzljIDEwMDY0NAo+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+PiBAQCAtNjE4LDcgKzYxOCw3
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2NzX3BhcnNlcl9ib3Moc3RydWN0IAo+PiBhbWRncHVfY3Nf
cGFyc2VyICpwLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ibyAqYm8gPSB0
dG1fdG9fYW1kZ3B1X2JvKGUtPnR2LmJvKTsKPj4gwqAgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIE1h
a2Ugc3VyZSB3ZSB1c2UgdGhlIGV4Y2x1c2l2ZSBzbG90IGZvciBzaGFyZWQgQk9zICovCj4+IC3C
oMKgwqDCoMKgwqDCoCBpZiAoYm8tPnByaW1lX3NoYXJlZF9jb3VudCkKPj4gK8KgwqDCoMKgwqDC
oMKgIGlmIChpc19hbWRncHVfYm9fZG1hYnVmKGJvKSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZS0+dHYubnVtX3NoYXJlZCA9IDA7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBlLT5ib192
YSA9IGFtZGdwdV92bV9ib19maW5kKHZtLCBibyk7Cj4+IMKgwqDCoMKgwqAgfQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYyAKPj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jCj4+IGluZGV4IGUwYzRm
N2M3ZjFiOS4uM2NmNTdlYTU2NDk5IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kbWFfYnVmLmMKPj4gQEAgLTE0Myw2ICsxNDMsNyBAQCBzdGF0aWMgaW50IGFt
ZGdwdV9kbWFfYnVmX2F0dGFjaChzdHJ1Y3QgZG1hX2J1ZiAKPj4gKmRtYWJ1ZiwKPj4gwqAgewo+
PiDCoMKgwqDCoMKgIHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqID0gZG1hYnVmLT5wcml2Owo+
PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm8gKmJvID0gZ2VtX3RvX2FtZGdwdV9ibyhvYmop
Owo+PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfYm9fZG1hYnVmICpkYm8gPSB0b19hbWRncHVfYm9f
ZG1hYnVmKGJvKTsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGFt
ZGdwdV90dG1fYWRldihiby0+dGJvLmJkZXYpOwo+PiDCoMKgwqDCoMKgIGludCByOwo+PiDCoCBA
QCAtMTcyLDcgKzE3Myw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RtYV9idWZfYXR0YWNoKHN0cnVj
dCBkbWFfYnVmIAo+PiAqZG1hYnVmLAo+PiDCoMKgwqDCoMKgIGlmIChyKQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgZ290byBvdXQ7Cj4+IMKgIC3CoMKgwqAgYm8tPnByaW1lX3NoYXJlZF9jb3VudCsr
Owo+PiArwqDCoMKgIGRiby0+cHJpbWVfc2hhcmVkX2NvdW50Kys7Cj4+IMKgwqDCoMKgwqAgYW1k
Z3B1X2JvX3VucmVzZXJ2ZShibyk7Cj4+IMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+IMKgIEBAIC0x
OTQsMTAgKzE5NSwxMSBAQCBzdGF0aWMgdm9pZCBhbWRncHVfZG1hX2J1Zl9kZXRhY2goc3RydWN0
IAo+PiBkbWFfYnVmICpkbWFidWYsCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgZHJtX2dl
bV9vYmplY3QgKm9iaiA9IGRtYWJ1Zi0+cHJpdjsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1
X2JvICpibyA9IGdlbV90b19hbWRncHVfYm8ob2JqKTsKPj4gK8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1
X2JvX2RtYWJ1ZiAqZGJvID0gdG9fYW1kZ3B1X2JvX2RtYWJ1Zihibyk7Cj4+IMKgwqDCoMKgwqAg
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBhbWRncHVfdHRtX2FkZXYoYm8tPnRiby5iZGV2
KTsKPj4gwqAgLcKgwqDCoCBpZiAoYXR0YWNoLT5kZXYtPmRyaXZlciAhPSBhZGV2LT5kZXYtPmRy
aXZlciAmJiAKPj4gYm8tPnByaW1lX3NoYXJlZF9jb3VudCkKPj4gLcKgwqDCoMKgwqDCoMKgIGJv
LT5wcmltZV9zaGFyZWRfY291bnQtLTsKPj4gK8KgwqDCoCBpZiAoYXR0YWNoLT5kZXYtPmRyaXZl
ciAhPSBhZGV2LT5kZXYtPmRyaXZlciAmJiAKPj4gZGJvLT5wcmltZV9zaGFyZWRfY291bnQpCj4+
ICvCoMKgwqDCoMKgwqDCoCBkYm8tPnByaW1lX3NoYXJlZF9jb3VudC0tOwo+PiDCoCDCoMKgwqDC
oMKgIHBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koYWRldl90b19kcm0oYWRldiktPmRldik7Cj4+
IMKgwqDCoMKgwqAgcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoYWRldl90b19kcm0oYWRldikt
PmRldik7Cj4+IEBAIC00MzEsNiArNDMzLDcgQEAgYW1kZ3B1X2RtYV9idWZfY3JlYXRlX29iaihz
dHJ1Y3QgZHJtX2RldmljZSAqZGV2LCAKPj4gc3RydWN0IGRtYV9idWYgKmRtYV9idWYpCj4+IMKg
wqDCoMKgwqAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBkcm1fdG9fYWRldihkZXYpOwo+
PiDCoMKgwqDCoMKgIHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqZ29iajsKPj4gwqDCoMKgwqDCoCBz
dHJ1Y3QgYW1kZ3B1X2JvICpibzsKPj4gK8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvX2RtYWJ1ZiAq
ZGJvOwo+PiDCoMKgwqDCoMKgIHVpbnQ2NF90IGZsYWdzID0gMDsKPj4gwqDCoMKgwqDCoCBpbnQg
cmV0Owo+PiDCoCBAQCAtNDQ5LDEwICs0NTIsMTEgQEAgYW1kZ3B1X2RtYV9idWZfY3JlYXRlX29i
aihzdHJ1Y3QgZHJtX2RldmljZSAKPj4gKmRldiwgc3RydWN0IGRtYV9idWYgKmRtYV9idWYpCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycm9yOwo+PiDCoCDCoMKgwqDCoMKgIGJvID0gZ2Vt
X3RvX2FtZGdwdV9ibyhnb2JqKTsKPj4gK8KgwqDCoCBkYm8gPSB0b19hbWRncHVfYm9fZG1hYnVm
KGJvKTsKPj4gwqDCoMKgwqDCoCBiby0+YWxsb3dlZF9kb21haW5zID0gQU1ER1BVX0dFTV9ET01B
SU5fR1RUOwo+PiDCoMKgwqDCoMKgIGJvLT5wcmVmZXJyZWRfZG9tYWlucyA9IEFNREdQVV9HRU1f
RE9NQUlOX0dUVDsKPj4gwqDCoMKgwqDCoCBpZiAoZG1hX2J1Zi0+b3BzICE9ICZhbWRncHVfZG1h
YnVmX29wcykKPj4gLcKgwqDCoMKgwqDCoMKgIGJvLT5wcmltZV9zaGFyZWRfY291bnQgPSAxOwo+
PiArwqDCoMKgwqDCoMKgwqAgZGJvLT5wcmltZV9zaGFyZWRfY291bnQgPSAxOwo+PiDCoCDCoMKg
wqDCoMKgIGRtYV9yZXN2X3VubG9jayhyZXN2KTsKPj4gwqDCoMKgwqDCoCByZXR1cm4gZ29iajsK
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyAK
Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKPj4gaW5kZXggNTM2
NmE4MDZiZTJiLi43Y2NlOGFhMjlmZDcgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ2VtLmMKPj4gQEAgLTc4Myw3ICs3ODMsNyBAQCBpbnQgYW1kZ3B1X2dlbV9vcF9p
b2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCAKPj4gdm9pZCAqZGF0YSwKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIGJyZWFrOwo+PiDCoMKgwqDCoMKgIH0KPj4gwqDCoMKgwqDCoCBjYXNlIEFNREdQ
VV9HRU1fT1BfU0VUX1BMQUNFTUVOVDoKPj4gLcKgwqDCoMKgwqDCoMKgIGlmIChyb2JqLT5wcmlt
ZV9zaGFyZWRfY291bnQgJiYgKGFyZ3MtPnZhbHVlICYgCj4+IEFNREdQVV9HRU1fRE9NQUlOX1ZS
QU0pKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoaXNfYW1kZ3B1X2JvX2RtYWJ1Zihyb2JqKSAm
JiAoYXJncy0+dmFsdWUgJiAKPj4gQU1ER1BVX0dFTV9ET01BSU5fVlJBTSkpIHsKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgciA9IC1FSU5WQUw7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGFtZGdwdV9ib191bnJlc2VydmUocm9iaik7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGJyZWFrOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X29iamVjdC5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9v
YmplY3QuYwo+PiBpbmRleCBhZDYxNWVlYzFlOGMuLjQzNWJmODU5OTFlNSAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+PiBAQCAtOTY1LDcgKzk2
NSw3IEBAIGludCBhbWRncHVfYm9fcGluX3Jlc3RyaWN0ZWQoc3RydWN0IGFtZGdwdV9ibyAKPj4g
KmJvLCB1MzIgZG9tYWluLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+
IMKgIMKgwqDCoMKgwqAgLyogQSBzaGFyZWQgYm8gY2Fubm90IGJlIG1pZ3JhdGVkIHRvIFZSQU0g
Ki8KPj4gLcKgwqDCoCBpZiAoYm8tPnByaW1lX3NoYXJlZF9jb3VudCB8fCBiby0+dGJvLmJhc2Uu
aW1wb3J0X2F0dGFjaCkgewo+PiArwqDCoMKgIGlmIChpc19hbWRncHVfYm9fZG1hYnVmKGJvKSB8
fCBiby0+dGJvLmJhc2UuaW1wb3J0X2F0dGFjaCkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KGRvbWFpbiAmIEFNREdQVV9HRU1fRE9NQUlOX0dUVCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZG9tYWluID0gQU1ER1BVX0dFTV9ET01BSU5fR1RUOwo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgZWxzZQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X29iamVjdC5oIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3Qu
aAo+PiBpbmRleCAzZDIzYWQyNDdiMWIuLjJmMWFiY2M0ZTFlNyAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oCj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+PiBAQCAtOTMsNyArOTMsNiBAQCBz
dHJ1Y3QgYW1kZ3B1X2JvIHsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3TC
oMKgwqAgdGJvOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCB0dG1fYm9fa21hcF9vYmrCoMKgwqDCoMKg
wqDCoCBrbWFwOwo+PiDCoMKgwqDCoMKgIHU2NMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBmbGFnczsKPj4gLcKgwqDCoCB1bnNpZ25lZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJpbWVf
c2hhcmVkX2NvdW50Owo+PiDCoMKgwqDCoMKgIC8qIHBlciBWTSBzdHJ1Y3R1cmUgZm9yIHBhZ2Ug
dGFibGVzIGFuZCB3aXRoIHZpcnR1YWwgYWRkcmVzc2VzICovCj4+IMKgwqDCoMKgwqAgc3RydWN0
IGFtZGdwdV92bV9ib19iYXNlwqDCoMKgICp2bV9ibzsKPj4gwqDCoMKgwqDCoCAvKiBDb25zdGFu
dCBhZnRlciBpbml0aWFsaXphdGlvbiAqLwo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
