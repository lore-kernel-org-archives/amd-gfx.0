Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8B9C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB2661090
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB2661090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB0456EC7E;
	Thu, 29 Apr 2021 06:10:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A496EC7E
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 06:10:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuMEVehapo93xbOMOfKVhYHsA56d8BGB8xg7Wh3xuW7PjiGdIVy+gRC0XDzzeBAzqFl4tTJdG3/Uvw3zy+huGGFS9i9tm7p4Z+Qtk2G9O5GDqhSaR7uFCUI8z+gLerKGtcWUwKJySfT+chu7+YFc74MpzMyGr8hN1MtU/A161fLceSSuUorBQyQHeoQqMFpbIXQSOqCdR1oS6l2jLbj0fJhNuqntA6ZhcCPAxKWGxagR3GU4p9gdae4IHd6hzX0qVfELUYd9KN3gBxC4muVK/bOEczlYKuN/htPsihmPsobJ9Il2BotKKD7MkrNaEdzziMnxUHKKPgWh3Lg0uMUe/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8zcrxXYJxlqsoKl9i8ZWp5YkxF1HS60JGJiYAv8KcA=;
 b=BJFuAbG8n/H55N+0piidoeU0+VPyR8vqCuF/KMsjBzWgOMSkOQL9v2kRt4xn4u5syErTjUzo/+NYylfbi9ZqzzrBXONBLU5HSrNvpTj1AFRxMtF1kS+VbhkyI4TO1rrrTObmdS3ESoIVDBEm8Q8Nts8+CTkiJB+HC/320JQ7YHyPAz07T5Nt/J+xcQAbfIWUKYaf5GqUuUZCgZdW1WoTeotNllmc6Oc5DtS7xwOM94XGCI206LXnKIckvBsy2fDIS1Q+2bkK228XmePv/FoEIx4+HYIf68nx1ujNBuRh+p8CcXQG9v6LU/GAm258xAAfpoDsxOjk5k6DBRWtGNwiwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8zcrxXYJxlqsoKl9i8ZWp5YkxF1HS60JGJiYAv8KcA=;
 b=05ql3cCCmvQHixlm4JqkfRMeRSq74yy6vD2pfC1fs80/Qq6TzUzz773BKwgyayJyt4o8DX2xw6nnQAy+cN0W8G8B9WFYwTI6fj3yZv4PwHrmwMAdtB/WsAufTVGewQrZ1QjLj6OvYa1A0mSx8onRpaJY2EfnygMclUkNtiekWwM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 06:10:33 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 06:10:33 +0000
Subject: Re: [PATCH 1/2] drm/amdkfd: wait migration done only if migration
 starts
To: amd-gfx@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
References: <20210429015339.13047-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <15106a30-9f85-f0ca-5e4c-b53c60c83474@amd.com>
Date: Thu, 29 Apr 2021 02:10:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210429015339.13047-1-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT1PR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::17) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT1PR01CA0108.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Thu, 29 Apr 2021 06:10:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eca0385-dcf4-41e9-823f-08d90ad57f9f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4408:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4408E7D50E4A15BF69147C33925F9@MN2PR12MB4408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89SfmRHUZYZejcwWpL2Q/3mvagKbNg7lcpf2MF1ENJz5Dla8htBwuRW9AEn/9xbqaQGFV9dGOtdFxd+EsqzrVJppYRRYwC4MINHKlKpwMyp7PgxVMeSdE+gv+hKsues9yDlJZQT/zPtJ76IvUcQNteEl4OHM+jXFzqidJenOHgfGuP5cyJiPUvgIsvMKkMoqQqbBhstSPi809BKWfXBITwWU6VFf6s70Gz4cEYe+HgFq4oU3zpLoI0do2hU8kDJp5tjCAH6VBfNQvL21np75bxwV5qKlREql1+UyxX2bwpemrcTpyWOApRL7stO47tzsKmaTm8vfjve2sCPKdSuvF01oD62SYsIznAzsyqfUwW+2r/2J/WzGUWe+J12FGrP+g8EJ49C9D7putO3j/TNKjx6ZjQmksSX3Cbd8a/K6cTxiODRU7Ppt1Kbm1mZ1M3M6xa95U9jV/55HTloeINbygNNtUKDX0vxp51uaSoUy4REZS6v+Oie111N6hv2dNFWMC4CXYTXQNK0hPfEBUxl7zVljqitcbQT2BD0EHwE0hbMn+unZnfQB46TdfUrb0wky3dmXTbnhbzv3VZ7icKhc156wElBWen4d0m4vz5wTnX8ogMc558Zyk/NdnA+unkaIOuLkAM2bTc7UhKrBtmRqF3XiUtLfoBtNL8OqgDetEVCYZXCsA+uKOOVEoMtoyYuj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(478600001)(31686004)(66476007)(86362001)(8676002)(16576012)(44832011)(16526019)(31696002)(38100700002)(186003)(6862004)(26005)(316002)(36756003)(83380400001)(956004)(8936002)(2616005)(5660300002)(2906002)(6636002)(6486002)(37006003)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bytRQVdpTjhrSDFVa2pHTWM3WHhpaVhiTnZ0OHVPQ0FYWjUzam92MUVOZ3FZ?=
 =?utf-8?B?WGU4MUhYYWY5OGJ1b1ZhNllpMWw3SW5lVWdXUWtvZUZEUkNBMWc5dHgyVSsx?=
 =?utf-8?B?UlZsdEhlWUtXb2hHeS9iSjQ1bkF4WWNSK0EyWUxYNXRielRaRFpKRmJOQ1NG?=
 =?utf-8?B?My90T052T0NpYmVHbVc5KzMxczl1UDhSbGN5WEQ4S2NnYm00Zi8xeGZHcTVv?=
 =?utf-8?B?TkFBRkU2dzZNbHZvRFlZQ2drbnZTVlJxYXlFaEtwYnZ6WWpLSEc3bTFyQ3Ar?=
 =?utf-8?B?cDlwMjltRGFlaVc0RjFydldsZUpqVzU0RnRvS1A4c1pybEM3R2VNeVI4dUs5?=
 =?utf-8?B?aXpIbkl3WFZuL2JOZkp3S2hhQTFPVXBWTG0wT0dtVTZFRmZkYVkrRkJVaFg1?=
 =?utf-8?B?eWxsVlJEeHZPenUzZWlNbXFnYmhtSE5ob2xmcXlSWlc3TDlpb1l6NlJFWU5I?=
 =?utf-8?B?enRMY1MwbFZZOVdYV2lZOUUrblYvd3YxNGIxM3FxV24yc0FpRTdMSkJpaXJ3?=
 =?utf-8?B?ejFuTHU5cko0ajdpeE9rZEVpVVEwM3BVMXpsZCtCTEVHbnVvNWZCRjRvYldo?=
 =?utf-8?B?Wm82dlQ2V0trQXBBaUU0N2J0a3NTcisrS1gxditYK2tPdUY0UHhYNTl0ek01?=
 =?utf-8?B?ODlSVnArUEJaNXkxNmg2aDJhVDM4SUJjYzVJWFBJRHdEMm5pUTBWWXVYb1I0?=
 =?utf-8?B?aVJOOTBXV21CQXdabG1uM2kvY3dLckpvTFRrWkR6RWlXOEJqb205bzJSUUE1?=
 =?utf-8?B?WG4vZ3NmRVk0ci91djc3MEFyelQ5NjZqWERyaFFmWnJSejBhMHR2RDNDR1Ir?=
 =?utf-8?B?Qkk3cXVQY2U4VklTSHp2RGZVdnhzLzQwU2xrY1J1MkZ4RzV5TGdHRFcreTEw?=
 =?utf-8?B?ODZWNGtXYzJ2L1M1U0FvcERiWktmTE5VeDkrcEkzVkNqdkMyUC9rVnRsbDFC?=
 =?utf-8?B?czlnTVQ3ZU1yN1NyY1JzVzdVSG9YakNjdDB6WjBPNWNjUXh5Rk92cFNONGxN?=
 =?utf-8?B?MlFYelNYYUNEcmZWbDBObGNENHhkeWxrbEhnU1lyVCtXMDRlallBVEpLQWd5?=
 =?utf-8?B?bXQwQ3lUNmFmWUNUUDh2M3VTWURiL2tDbkxHdlFxbWVkTEp4dUV1cmExSDMz?=
 =?utf-8?B?TFk4Z3c3NFdkVTd3VDZuRXp0N3VMbXZNdjRod1UwL1NVRjZBYlNDNll4Yk1a?=
 =?utf-8?B?aitSZGIyczYraXJmcFIwcjliSlNjVVNaQStrcHhRMkFUL21vQ1RnNEVIeWF3?=
 =?utf-8?B?V0ZMSk83bHU0Yjd0ZDNaWUl5bFJhenVLVC9Lc1dBSHlBbnV2OElLRmlXbXZS?=
 =?utf-8?B?SDhoMmhWRWl6OGVkUDZwc3RZNEE4SkdEYTJiRWtiazhJSmh6KzgzNlpwZ0tR?=
 =?utf-8?B?c0JxOHk0ak05SEFnKzRoWlhnbmNQdXlwbXJMc0tzQjBaOVZpTEtWS1k5QlVt?=
 =?utf-8?B?eDJuaUlVaFc2bEhGZHFpclRnR1JBQThrL04yV0hIUzZqNGhxRm0zc2J5aThl?=
 =?utf-8?B?ODhramY4TWNvaERjR21iYXhJVnIzQ1duOHhpR0o0ZW5MVEFnelUvZnNmdE5I?=
 =?utf-8?B?aGJsdUVNUElxOXdkTVN5VlF0ei9GNVRTanNJbitzaGVGOVh0OHdkbzJpQWpQ?=
 =?utf-8?B?NnZVN1M0RGhNeFlCUFJRWnBiS3FaQ0p1ZmRrWmNKaURPTFdzT0c1RTNpK3hv?=
 =?utf-8?B?TnB6eEdUNisvQWJibGUrZkNwdHk5ZEE2b0VFVk8ybUc5YVlmYU1WVVhGWmNP?=
 =?utf-8?Q?LfCBdq6vy/YoiQ2m3IXAlV4Qrm8SBLxdSwMNRbZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eca0385-dcf4-41e9-823f-08d90ad57f9f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:10:33.6989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7TDU1y6Szsh9NQaKJ2f2zSIOwUe9RoxySifu9wH1ckHJKFbxRVHrvlKjfcs41xzxnQLRQi9QrTs5CEXsip2eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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

QW0gMjAyMS0wNC0yOCB1bSA5OjUzIHAubS4gc2NocmllYiBQaGlsaXAgWWFuZzoKCj4gSWYgbWln
cmF0aW9uIHZtYSBzZXR1cCwgYnV0IGZhaWxlZCBiZWZvcmUgc3RhcnQgc2RtYSBtZW1vcnkgY29w
eSwgZS5nLgo+IHByb2Nlc3MgaXMga2lsbGVkLCBkb24ndCB3YWl0IGZvciBzZG1hIGZlbmNlIGRv
bmUuCgpJIHRoaW5rIHlvdSBjb3VsZCBkZXNjcmliZSB0aGlzIG1vcmUgZ2VuZXJhbGx5IGFzICJI
YW5kbGUgZXJyb3JzCnJldHVybmVkIGJ5IHN2bV9taWdyYXRlX2NvcHlfdG9fdnJhbS9yYW0iLgoK
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXAgWWFuZyA8UGhpbGlwLllhbmdAYW1kLmNvbT4KPiAt
LS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYyB8IDIwICsrKysr
KysrKysrKy0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9taWdyYXRlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5jCj4g
aW5kZXggNmI4MTA4NjNmNmJhLi4xOWIwODI0N2JhOGEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMKPiBAQCAtNDYwLDEwICs0NjAsMTIgQEAgc3ZtX21pZ3Jh
dGVfdm1hX3RvX3ZyYW0oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBzdm1fcmFu
Z2UgKnByYW5nZSwKPiAgCX0KPiAgCj4gIAlpZiAobWlncmF0ZS5jcGFnZXMpIHsKPiAtCQlzdm1f
bWlncmF0ZV9jb3B5X3RvX3ZyYW0oYWRldiwgcHJhbmdlLCAmbWlncmF0ZSwgJm1mZW5jZSwKPiAt
CQkJCQkgc2NyYXRjaCk7Cj4gLQkJbWlncmF0ZV92bWFfcGFnZXMoJm1pZ3JhdGUpOwo+IC0JCXN2
bV9taWdyYXRlX2NvcHlfZG9uZShhZGV2LCBtZmVuY2UpOwo+ICsJCXIgPSBzdm1fbWlncmF0ZV9j
b3B5X3RvX3ZyYW0oYWRldiwgcHJhbmdlLCAmbWlncmF0ZSwgJm1mZW5jZSwKPiArCQkJCQkgICAg
IHNjcmF0Y2gpOwo+ICsJCWlmICghcikgewo+ICsJCQltaWdyYXRlX3ZtYV9wYWdlcygmbWlncmF0
ZSk7Cj4gKwkJCXN2bV9taWdyYXRlX2NvcHlfZG9uZShhZGV2LCBtZmVuY2UpOwoKSSB0aGluayB0
aGVyZSBhcmUgZmFpbHVyZSBjYXNlcyB3aGVyZSBzdm1fbWlncmF0ZV9jb3B5X3RvX3ZyYW0Kc3Vj
Y2Vzc2Z1bGx5IGNvcGllcyBzb21lIHBhZ2VzIGJ1dCBmYWlscyBzb21ld2hlcmUgaW4gdGhlIG1p
ZGRsZS4gSQp0aGluayBpbiB0aG9zZSBjYXNlcyB5b3Ugc3RpbGwgd2FudCB0byBjYWxsIG1pZ3Jh
dGVfdm1hX3BhZ2VzIGFuZApzdm1fbWlncmF0ZV9jb3B5X2RvbmUuIElmIHRoZSBjb3B5IG5ldmVy
IHN0YXJ0ZWQgZm9yIHNvbWUgcmVhc29uLCB0aGVyZQpzaG91bGQgYmUgbm8gbWZlbmNlIGFuZCBz
dm1fbWlncmF0ZV9jb3B5X2RvbmUgc2hvdWxkIGJlIGEgbm8tb3AuCgpJIHByb2JhYmx5IGRvbid0
IHVuZGVyc3RhbmQgdGhlIGZhaWx1cmUgc2NlbmFyaW8geW91IGVuY291bnRlcmVkLiBDYW4KeW91
IGV4cGxhaW4gdGhhdCBpbiBtb3JlIGRldGFpbD8KClRoYW5rcywKwqAgRmVsaXgKCgo+ICsJCX0K
PiAgCQltaWdyYXRlX3ZtYV9maW5hbGl6ZSgmbWlncmF0ZSk7Cj4gIAl9Cj4gIAo+IEBAIC02NjMs
MTAgKzY2NSwxMiBAQCBzdm1fbWlncmF0ZV92bWFfdG9fcmFtKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCBzdHJ1Y3Qgc3ZtX3JhbmdlICpwcmFuZ2UsCj4gIAlwcl9kZWJ1ZygiY3BhZ2VzICVs
ZFxuIiwgbWlncmF0ZS5jcGFnZXMpOwo+ICAKPiAgCWlmIChtaWdyYXRlLmNwYWdlcykgewo+IC0J
CXN2bV9taWdyYXRlX2NvcHlfdG9fcmFtKGFkZXYsIHByYW5nZSwgJm1pZ3JhdGUsICZtZmVuY2Us
Cj4gLQkJCQkJc2NyYXRjaCk7Cj4gLQkJbWlncmF0ZV92bWFfcGFnZXMoJm1pZ3JhdGUpOwo+IC0J
CXN2bV9taWdyYXRlX2NvcHlfZG9uZShhZGV2LCBtZmVuY2UpOwo+ICsJCXIgPSBzdm1fbWlncmF0
ZV9jb3B5X3RvX3JhbShhZGV2LCBwcmFuZ2UsICZtaWdyYXRlLCAmbWZlbmNlLAo+ICsJCQkJCSAg
ICBzY3JhdGNoKTsKPiArCQlpZiAoIXIpIHsKPiArCQkJbWlncmF0ZV92bWFfcGFnZXMoJm1pZ3Jh
dGUpOwo+ICsJCQlzdm1fbWlncmF0ZV9jb3B5X2RvbmUoYWRldiwgbWZlbmNlKTsKPiArCQl9Cj4g
IAkJbWlncmF0ZV92bWFfZmluYWxpemUoJm1pZ3JhdGUpOwo+ICAJfSBlbHNlIHsKPiAgCQlwcl9k
ZWJ1ZygiZmFpbGVkIGNvbGxlY3QgbWlncmF0ZSBkZXZpY2UgcGFnZXMgWzB4JWx4IDB4JWx4XVxu
IiwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
