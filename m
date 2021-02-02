Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B150AC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 10:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5D164F2C
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 10:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5D164F2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B056B6E0E5;
	Tue,  2 Feb 2021 10:22:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D1FB6E0E5
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 10:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUjo4GS+kpEdXEJy+OxVma5czh/Bk0Pw5HsyYlZhqjdSNPw0AjocUxletMrA9BxZqn3nHVE/TKDyO7GKGTFoWNLhYrNiz/FzVz39fTDkEfTebnSl3XY+CypFjqldH9iyZHxAqamI//I3LbZQYgAiOpwI/gG+XB+HWfRHm4Wbn0gqCdRzJJdhx51Fmi/OmhsFSfZLdT+5Qo5rlltMgASOHeINh9tw9zhe84cgn4J+TfiOZuhei5UgVYNwQHZMu6v1ruK255/FkTO2cCz2AIGsFz8GQ/8VbOXJZspH8h4AXIbuZ02I8L00FXYNYmBgadbgn1sjw6EQMkgImy8GJ4Ow3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgpAjwUxxnLQXqjAJqAfM0CcH9Cx4XK9k1V529xU7j4=;
 b=RemztFSSiJHLCUbkiAXNKLYr58i3nsbVdzLUG5C8LGM6QeZxjgh4IrFQW1DHWPxal4SgnEq7AgwGJayH6Pm+C8gat0H8UVeF3RH5pgZjmYmSecEHX6iZKFVcPQ2PWETV1vx70BkYIjuZbR9tHNOKfV0mLZazdySurIpD+xEfqYrmsLWbaTz/BgRmVJaDoc8CHV9+X7x/uusi0/1btG50CB0jSrbiaWm2XFFMAYeE2ABl7r2quSs9Ssaw6By+rNE+sYvOOYlsUF95RiCAXzhC1f7kABsW1+u2ArN4sIzEWgeQq7WfADC+Ha7TK/vlMSqpvla5G6tJCNl7Go/WYagYEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgpAjwUxxnLQXqjAJqAfM0CcH9Cx4XK9k1V529xU7j4=;
 b=HzHHk9J6JkH/JTjeQRaH+XXGtIc6LXG3watnevaR6QrQSqORdzEOZXMfvQjNsT8UcvcHjeGc9dG0EYZaZjq7x81H4lrJGnJ+FTCQVY5bTy31FJV6jcHoyOMVklBNdIXAdUzzYZ+E9H4qrE/UEHgCtktLZpSw9shCMdrq5LF0mP4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR1201MB0091.namprd12.prod.outlook.com (2603:10b6:4:57::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Tue, 2 Feb
 2021 10:22:48 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Tue, 2 Feb 2021
 10:22:48 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu: cleanup struct amdgpu_ring
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20210201155155.103360-1-nirmoy.das@amd.com>
 <ececcadc-6be5-124c-74b7-7addae2abf76@amd.com>
 <CADnq5_PYxEUT8m7DewKW7T11qvg3ez7DW+af5JwDA_7=rgG8Rw@mail.gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <02314296-2849-028c-0b5a-648ac6dc3d2b@amd.com>
Date: Tue, 2 Feb 2021 11:22:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <CADnq5_PYxEUT8m7DewKW7T11qvg3ez7DW+af5JwDA_7=rgG8Rw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [93.229.32.71]
X-ClientProxiedBy: AM0PR06CA0136.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::41) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (93.229.32.71) by
 AM0PR06CA0136.eurprd06.prod.outlook.com (2603:10a6:208:ab::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17 via Frontend Transport; Tue, 2 Feb 2021 10:22:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 554e77a9-4fd5-4f5e-4a77-08d8c7647d18
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0091:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB009108D2FD771E3A758501328BB59@DM5PR1201MB0091.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9KVlZvy5udQhfZ+rDzqvyqWJDT/v3l4RJi5RlH0gLSlYfbHR6dNj9s/BZaiZeb5jtbXA4lopkwLKjJ4yUIxN9ynF9S4ga4t6rNuYLgvyZoPtTDFviwfnj22rBKBqozos/kjl6CqzpypTBWz9Pqz0fKKYCTomn1fCkLIAged+LsZKs6IUL4Dq7DRbSR0VhzaxFwVqskpk3J/E5F3b5ij5Eu/xg9x0BVt6HVsA5XKgPp05vAtPDoibhHlC82PANZZtlQryKx1VqHkao5XuXGHh2UYci2oZDXaErMdVRquYiuMuZxcfFhX5Bz0w8EprSQGFOK9Kn783VFn1nklLa9FeSdDs6gNDFPl+PBBYVtWk6MBUcV9+LYq+IoT6xU5+ZNp1GyNRim1WJNX/FCQX/mmLLijW156XePokUc1WJng1O3+FECvERkgtFqwBM/5VdwQxfhpoTGBiueIKJuLXZx0vI6s7ZW29VhSDAXqDutpP9LceSDVDO0hrM0zOOn+jttcxwqW8UanGwbdXIK93Lsm5CpEjzfDZWFZ32bsvgX4rO7aYimdNNYQ3WHbn436clTCCprUWrdi2uP4QwYqc5A5usRDMGjuOSToTYxtTkUp6CehDq5PR9X8X3phFYMp6fNesoTk8Kbcnp116j5aqlTSKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(83380400001)(66574015)(52116002)(6636002)(6486002)(31686004)(31696002)(8676002)(16576012)(8936002)(110136005)(54906003)(26005)(16526019)(186003)(53546011)(36756003)(2906002)(66556008)(66946007)(5660300002)(66476007)(6666004)(316002)(966005)(45080400002)(956004)(2616005)(478600001)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QnpldWE0UW1ORmNEZElDcDNxWUllWUtsS3dUbVZVOVhDMmZLMFFFV095Vzhj?=
 =?utf-8?B?M1E4UFhJKzluZ096ay8wTUhSZ2NKaXg2ZTBxZkxFMXNvOXhJaWVpRzBUL2Ns?=
 =?utf-8?B?bHQrV0w1YVl4Q2c3VEo3UkhEZEEwMUpHTWxnQ0VScTFXVGU4RTZkV2x0VUtQ?=
 =?utf-8?B?Y0V5dzcxbEcxMTVhWVJaNVYrSHlaZVRuZTBqWXJucFA3RlkvUFc4OEZJdDM5?=
 =?utf-8?B?ZG4zUHcwcU8rN1FJaDMvd1poc2pRaC9TU2Jmb1FVblNjcEZXU0lNY21XbGRW?=
 =?utf-8?B?SGd3OC9kQzNSMnM3T3BPN0lJYUdpcW9CSExna0pTS1pkRWVuT21LZHZBTUdx?=
 =?utf-8?B?ZlMvRmppaXE3cnArWklZK0I2QTZqT0NBUHJSYzM3d0FjeEFWT1dWRjd2bkdl?=
 =?utf-8?B?TEEyRXIxZ2xlZ0REcTFMZWk3TGhpWGdRUXZrbjQ3SUorMFErY3NZb3JpQ0k2?=
 =?utf-8?B?emV2ZjhWZE9MOXg1WnhXL2F4bHlPN0N2aFBBeDdHUWxQNDd6U0hjV2VVTzU2?=
 =?utf-8?B?dFJzQ0dhTGNTcHZsODNqKy9aRFZuTlV0QzFsUVBwQTVnek9zdkZFNzZ2eVY0?=
 =?utf-8?B?c3RReG1oN21Ea0t3bC9NV2ZPaUEzZktXbFFQQmoxS2I0SDhRajVUbGRDVE1B?=
 =?utf-8?B?UkJpcU5NV3F2bmY1cnAwYXRmWWNnZm5QTHBtZlFiTjRveWY2ZG5oRTJKbk1P?=
 =?utf-8?B?MUNjYmRXT2Vva091WE1KYlRvbVZlSWRadkQ5U25FSDYzcXpZN251UU1BQzhQ?=
 =?utf-8?B?bDhSWFB4YnVtYk1DcVZqNkRKc2pGWGphcTBiVW5iZUkvemsxbXZNK2VDd3ZG?=
 =?utf-8?B?aVU5NXFwQmpoWW1VQXMxQlNLdzJIcjhmcS9TYVBLOERHblEvOGtUbk9lRHl2?=
 =?utf-8?B?UHQyNHVPeTdBVVRVdUI4R2ZzeE5qSlpqWmJrbzIrbFpMbUpVM0NLR1VPS2Mz?=
 =?utf-8?B?djlGMjU0aU5naC9ZNGVDQ0U5QWZIWmhkUTl2bUM0ekJLQVArYTNEek9HVFJu?=
 =?utf-8?B?RUZraHhsclBYUUxrMFBPNDFiNXc1OVovek9IV1dQK2V6bDVyTzZDMm85dXF0?=
 =?utf-8?B?bEwvVFVSV0FBWFArU0tHZzQ3cHZqK3RMMm03OXNyUHNzN1FRL2FBZTNQT0t5?=
 =?utf-8?B?anhFazFBKzFtZ3dqdXZEZzltKzZqUDdUb0FOejFaSWp6bXNFcXVUTTJEWW92?=
 =?utf-8?B?UWd4RTZnQkdWWVVvYXNZcCt4czRxWVZTazU4UVhDMG51Y1lQWVNucUY3RmJr?=
 =?utf-8?B?T1h1UG8ycG93U3ZuUjh1V1FpNG5teUNPSUdjeUpnQnFZMUpUUll6eFJFYXBK?=
 =?utf-8?B?YjA5NVJPc1hNVXJKeG9uNUEzM1VMNTdqY0E1UStMOTlSb0lEMkc2MnZvdnpv?=
 =?utf-8?B?NmdWWkU5Y2VwS0pwVGJuR2xqSmwrMTdxUytJbHNPSFlYSmpiQ2hwaFZqMStE?=
 =?utf-8?Q?eQhVeXHE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554e77a9-4fd5-4f5e-4a77-08d8c7647d18
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 10:22:48.6173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98g0hAcj06s+BwpwW3cCACVPd5rLaPiTVPM2u7vEU4Dfg1hYzBE/xW7Uv7Dz+n3W4zKdi1hqT9Rdcot7NCsRWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0091
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
Cc: Alan Harrison <Alan.Harrison@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Nirmoy Das <nirmoy.das@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIvMS8yMSAxMDozNCBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IE9uIE1vbiwgRmViIDEs
IDIwMjEgYXQgMTE6MTMgQU0gQ2hyaXN0aWFuIEvDtm5pZwo+IDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+IHdyb3RlOgo+PiBBbSAwMS4wMi4yMSB1bSAxNjo1MSBzY2hyaWViIE5pcm1veSBEYXM6
Cj4+PiBUaGlzIHBhdGNoIGNvbnNpc3Qgb2YgYmVsb3cgcmVsYXRlZCBjaGFuZ2VzOgo+Pj4KPj4+
IDEgUmVuYW1lIHJpbmctPnByaW9yaXR5IHRvIHJpbmctPmh3X3ByaW8uCj4+PiAyIEFzc2lnbiBj
b3JyZWN0IGhhcmR3YXJlIHJpbmcgcHJpb3JpdHkuCj4+PiAzIFJlbW92ZSByaW5nLT5wcmlvcml0
eV9tdXRleCBhcyByaW5nIHByaW9yaXR5IHJlbWFpbnMgdW5jaGFuZ2VkCj4+PiAgICAgYWZ0ZXIg
aW5pdGlhbGl6YXRpb24uCj4+PiA0IFJlbW92ZSB1bnVzZWQgcmluZy0+bnVtX2pvYnMuCj4+Pgo+
Pj4gdjM6IHJlbW92ZSByaW5nLT5udW1fam9icy4KPj4+IHYyOiByZW1vdmUgcmluZy0+cHJpb3Jp
dHlfbXV0ZXguCj4+Pgo+Pj4gRml4ZXM6IDMzYWJjYjFmNWExNyAoImRybS9hbWRncHU6IHNldCBj
b21wdXRlIHF1ZXVlIHByaW9yaXR5IGF0IG1xZF9pbml0IikKPj4+IFNpZ25lZC1vZmYtYnk6IE5p
cm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gZm9yIHBhdGNoICMxLCAjMwo+PiBhbmQg
IzQuCj4+Cj4+IE1heWJlIHBpbmcgQWxleCBmb3IgYW4gcmIgb24gcGF0Y2ggIzIuCj4gU2VyaWVz
IGxvb2tzIGdvb2QgdG8gbWUgdG9vLiAgTWF5YmUgYWRkIHNvbWV0aGluZyB0byB0aGUgY29tbWl0
Cj4gbWVzc2FnZSBmb3IgcGF0Y2ggMyB0byBleHBsYWluIHdoeSB3ZSBkb24ndCBuZWVkIHRoaXMg
b24gZ2Z4MTAgc28KPiBzb21lb25lIGRvZXNuJ3QgdHJ5IGFuZCBtYWtlIHRoZSBjaGFuZ2UgdGhl
cmUgaW4gdGhlIGZ1dHVyZS4gIFdpdGgKPiB0aGF0IGZpeGVzIHNlcmllcyBpczoKPiBSZXZpZXdl
ZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKClRoYW5rcyBB
bGV4LCBJIHdpbGwgZG8gdGhhdC4KCgpOaXJtb3kKCj4KPiBBbGV4Cj4KPgo+Cj4+IENocmlzdGlh
bi4KPj4KPj4+IC0tLQo+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jp
bmcuYyB8IDggKystLS0tLS0KPj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yaW5nLmggfCA2ICstLS0tLQo+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmluZy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3JpbmcuYwo+Pj4gaW5kZXggMWE2MTJmNTFlY2Q5Li5iNjQ0Yzc4NDc1ZmQgMTAwNjQ0Cj4+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jCj4+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jCj4+PiBAQCAtMTY2LDcg
KzE2Niw3IEBAIGludCBhbWRncHVfcmluZ19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LCBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCj4+PiAgICAgICAgICAgICAgICAgICAgIHVuc2ln
bmVkIGludCBtYXhfZHcsIHN0cnVjdCBhbWRncHVfaXJxX3NyYyAqaXJxX3NyYywKPj4+ICAgICAg
ICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGlycV90eXBlLCB1bnNpZ25lZCBpbnQgaHdfcHJp
bykKPj4+ICAgIHsKPj4+IC0gICAgIGludCByLCBpOwo+Pj4gKyAgICAgaW50IHI7Cj4+PiAgICAg
ICAgaW50IHNjaGVkX2h3X3N1Ym1pc3Npb24gPSBhbWRncHVfc2NoZWRfaHdfc3VibWlzc2lvbjsK
Pj4+ICAgICAgICB1MzIgKm51bV9zY2hlZDsKPj4+ICAgICAgICB1MzIgaHdfaXA7Cj4+PiBAQCAt
MjU4LDggKzI1OCw3IEBAIGludCBhbWRncHVfcmluZ19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCj4+PiAgICAgICAgfQo+Pj4KPj4+ICAg
ICAgICByaW5nLT5tYXhfZHcgPSBtYXhfZHc7Cj4+PiAtICAgICByaW5nLT5wcmlvcml0eSA9IERS
TV9TQ0hFRF9QUklPUklUWV9OT1JNQUw7Cj4+PiAtICAgICBtdXRleF9pbml0KCZyaW5nLT5wcmlv
cml0eV9tdXRleCk7Cj4+PiArICAgICByaW5nLT5od19wcmlvID0gaHdfcHJpbzsKPj4+Cj4+PiAg
ICAgICAgaWYgKCFyaW5nLT5ub19zY2hlZHVsZXIpIHsKPj4+ICAgICAgICAgICAgICAgIGh3X2lw
ID0gcmluZy0+ZnVuY3MtPnR5cGU7Cj4+PiBAQCAtMjY4LDkgKzI2Nyw2IEBAIGludCBhbWRncHVf
cmluZ19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3Jpbmcg
KnJpbmcsCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICZyaW5nLT5zY2hlZDsKPj4+ICAgICAg
ICB9Cj4+Pgo+Pj4gLSAgICAgZm9yIChpID0gRFJNX1NDSEVEX1BSSU9SSVRZX01JTjsgaSA8IERS
TV9TQ0hFRF9QUklPUklUWV9DT1VOVDsgKytpKQo+Pj4gLSAgICAgICAgICAgICBhdG9taWNfc2V0
KCZyaW5nLT5udW1fam9ic1tpXSwgMCk7Cj4+PiAtCj4+PiAgICAgICAgcmV0dXJuIDA7Cj4+PiAg
ICB9Cj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yaW5nLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oCj4+PiBp
bmRleCA3MTEyMTM3Njg5ZGIuLjJhZGE4MGNlNDJmNSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmgKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmgKPj4+IEBAIC0yNDIsMTEgKzI0Miw3IEBAIHN0cnVj
dCBhbWRncHVfcmluZyB7Cj4+PiAgICAgICAgc3RydWN0IGRtYV9mZW5jZSAgICAgICAgKnZtaWRf
d2FpdDsKPj4+ICAgICAgICBib29sICAgICAgICAgICAgICAgICAgICBoYXNfY29tcHV0ZV92bV9i
dWc7Cj4+PiAgICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgbm9fc2NoZWR1bGVyOwo+Pj4g
LQo+Pj4gLSAgICAgYXRvbWljX3QgICAgICAgICAgICAgICAgbnVtX2pvYnNbRFJNX1NDSEVEX1BS
SU9SSVRZX0NPVU5UXTsKPj4+IC0gICAgIHN0cnVjdCBtdXRleCAgICAgICAgICAgIHByaW9yaXR5
X211dGV4Owo+Pj4gLSAgICAgLyogcHJvdGVjdGVkIGJ5IHByaW9yaXR5X211dGV4ICovCj4+PiAt
ICAgICBpbnQgICAgICAgICAgICAgICAgICAgICBwcmlvcml0eTsKPj4+ICsgICAgIGludCAgICAg
ICAgICAgICAgICAgICAgIGh3X3ByaW87Cj4+Pgo+Pj4gICAgI2lmIGRlZmluZWQoQ09ORklHX0RF
QlVHX0ZTKQo+Pj4gICAgICAgIHN0cnVjdCBkZW50cnkgKmVudDsKPj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QK
Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRl
c2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAx
JTdDbmlybW95LmRhcyU0MGFtZC5jb20lN0MzOWM3MWNiMGNkOGQ0YTBmNTFmYzA4ZDhjNmY5MzVh
YyU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc0NzgxMjA5
NDU0ODA2NzAlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pR
SWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2Rh
dGE9SVlSV1JJcCUyQkNOMElaYjh6Mm5TaDFWb0x0UDViczVBYWVLYnRuZmFYYVRnJTNEJmFtcDty
ZXNlcnZlZD0wCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
