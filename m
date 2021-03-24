Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAD7C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 21:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF5861A01
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 21:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF5861A01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 437AF891EC;
	Wed, 24 Mar 2021 21:26:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBEE8891EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 21:26:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUb5TD0SgHe5hMGmN+89rzohJGTxTE3s0CB8KkYVAeyZ7QkRV/sDPRQcBKs30TuMaQpT+TuaMkcVdo15Bs5jKPpIq8343tk5kVnZOoV4JfzRvzXbn+h1fgxpqIX6k6e6E9WGH/NuYPD76cDW/pMcB4k/7iPjDlZTC/YTX8NFMKlca+zOMcHxuKVjjcBlK2dx87hI0TDktaoW3aZxh3Tvy/24/n3NzcQSYDfIn9QtQfkA8hnaoy+HOtjFHRrdO1ZW6eySEEMqcxEjxOuttfAGrVDLnOkONnF2qVpTBetlP0G1A9O3wyjnULDODwNppMHFhvS0yzmFG9kfq0o8k5kq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMwhGGy9uQZn/XZj+H1NnOvgQWflVRiJMa7Kw4Ek81E=;
 b=GYeqOQiYyT76E03k934qOqZYAPU5R937vc+F7e4t4Lsu29r6oOEsaf1GTmlcKpbSyUKuy96Lds+SBgcX9ft2yvmjKfyiyIdKewruxAZtejvRchheEiNKHMCAzTl5zf0uJu/AxGGg5CO9HYjLkmxfV9t67eW/C9BUUT8jN6l6/NOCxkpKDxVYi4u79fulj/N1VEs+0NHwOuL0u/JOsengOKhNkHMdbynvKhLlEHocQlvgz1PE+dXDqzZqFs50HKQrt0hWSqifMeQIeAaa5ozuqYRkNR57Jr8LSOAy6JrRI/uLNnqPZNkkiIpdcZ8TQnucU9IXpjmXxI3J5lqJMXkcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMwhGGy9uQZn/XZj+H1NnOvgQWflVRiJMa7Kw4Ek81E=;
 b=lyQlTmOoA3y1Xlsp86IhwkwCNcFQhQKEmTcbyMaurmgG7tZk0jH4YGc2FqHKcD21duznUVrEG/ygcRdKYIez2wSA3qjlCpUnRAnrMYTGzfccDS3z/5ZEblXXAoexoZpvYwP3HCMi1G3HDyz4ha12Lw7U7Tvy+Wf3SeQlUzmFE+8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Wed, 24 Mar
 2021 21:26:49 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8%7]) with mapi id 15.20.3977.024; Wed, 24 Mar 2021
 21:26:49 +0000
Subject: Re: [PATCH] drm/amdgpu/display: fix dmub invalid register read
From: Harry Wentland <harry.wentland@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, mail@thomaslambertz.de,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
References: <3eb98a62-12f4-d191-97b8-15e2f8ca06e3@thomaslambertz.de>
 <CADnq5_Oq8nBVuLomgPJm0o054ZTDoeuZSCJNkGe+ZhODDp93eQ@mail.gmail.com>
 <67f5ccb8-7bb7-6d8f-f15f-7a8397c42e29@amd.com>
Message-ID: <4909e8bf-984a-a13c-b682-27115e7ef730@amd.com>
Date: Wed, 24 Mar 2021 17:26:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <67f5ccb8-7bb7-6d8f-f15f-7a8397c42e29@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN7PR06CA0056.namprd06.prod.outlook.com
 (2603:10b6:408:34::33) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.7.77] (165.204.84.11) by
 BN7PR06CA0056.namprd06.prod.outlook.com (2603:10b6:408:34::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.26 via Frontend Transport; Wed, 24 Mar 2021 21:26:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f54de8b9-8d0e-498d-bc9d-08d8ef0b88b0
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4553B7C28F9FB6E46F3390FC8C639@MW3PR12MB4553.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ec7zF3cPcNDCb0QamRFb10XJgSZIThEekdn2KaI3NH/6PNLDvIJIJCw4IKrARarxNi26uF4hQBYJEFS+7aq5t0XK7BLSdeuMv6eNoIunhgHZBne5sbSlNBTiirEgyyhYRJoy2KxwAqKwD56oMEdmOWHVO7Uzf5SCTt84qP80fdfjOvdHmXj7w876N9jqupfSSzvq2tsT3suC+Uo9GI2JNWU2NA0H8pzr8cdW0jAJfnclEnyePE+APIGUTMVW0Tkj7pCBk/jjcQGXmgsBOPxLsPxlhUhmebJ1eLiuijiEdpaqkkfx/TTfbB0MyN4d/j2WcSeJZX0ledIN9wNTGK8toTX/kBQuUFo4eKmlU1hHkjK8cyQhJUqbMM1u0H8kYg22Lfxka69dVnNTQHvnOwYjDNmBxxzxZhBwXvIuNvOwXftYAbuVyzAxfe70um45HFCZQamQ6ylo3MBT+Yo28n04nRIeXrteRofc9hQhhKVpdWN0omOGahrzC6iu3V6ZbG2+b4ebfF5XdYZuHGC3Z+y+HyKImfXiw9WKR1ONtHAWhQU950OTUPbwy0in9IIn0QwGFW6PWS1JVJqL/ngYcF0rBAL+Jl6P4ygUbqw8bbPFLl1z9+YbX1OHnJ52B1+lBiApnQtggy+7rkEsWKz8eZz+ueesk3C7KjMuy7KXoEucLJgo+pHfEWQ6euVNxPhDwzgB6D+oj9sJKm//NTxFb5yF1f4dpiqWRQ0wYo1Wn1/Kd0lw74P8epbrzZDdoXYw7HxB9Ox40JzzFxiOx2MGoj0yrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(83380400001)(110136005)(54906003)(8936002)(86362001)(966005)(2616005)(36756003)(956004)(4326008)(26005)(66556008)(38100700001)(53546011)(66476007)(66946007)(2906002)(6636002)(6486002)(5660300002)(6666004)(31696002)(44832011)(316002)(8676002)(186003)(478600001)(16576012)(31686004)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NEVERWRnNlNlOHZEaVdaSDFlbk5CZlJqdGF2YjRPZGRKZFd2STA5bzJGc3Nh?=
 =?utf-8?B?akZMeFdwZG1QZmVRRjNQMDN6U014TklJd0FQdXg5T2lxV1kyZjkwRXBTKzIy?=
 =?utf-8?B?R0VlRktmTnJpeGZRTFhVWnhiRjhBV3dnYnRubzR6MmU1dkpLaUdNM0o4b0Jz?=
 =?utf-8?B?VWppZkxESkh4UU83czN3cnBrNmxOZjB6NkJYN2ZCdTUwcXlMZ3FaOTRKMklQ?=
 =?utf-8?B?NGFrOWp3UEhsamhkeWJFdmJ2OHc1R0dLWWIvVk1QVHpjeWt1U09MaEFlaEVj?=
 =?utf-8?B?ZkRKcy91aEpKZW1RMEtnSFl0RXJrSlBVcHRaczN4VXNnVnZoeEtXWEdZanZu?=
 =?utf-8?B?VFArZjJETDczVXF0SWRVSS9TdWd5YnAvdUJYVmN1bzhqVnBwMGYwY3VSU0xt?=
 =?utf-8?B?aGFoZ2lpemQ4M3JvM0FnaW80anM4UjZVSnRIZWxHWkU0UlA5VzhIakd5QVRW?=
 =?utf-8?B?Y2JWck9YbGZIbmpuZWNielo0amU2OGE4MnF0cU4vNytQOGNKeFQ1Umhwbk9y?=
 =?utf-8?B?aHVOS1dGK3hwMG9nd0o4QWN4SkVhbkNDMEl1RVJ2MFdwMkQ4YTlTN1c1V1Uw?=
 =?utf-8?B?dC9PeVV2ZkZkTWRCaDBqZWhpeVY2bUlyNjFzZWUxUk03Ni91d3NhL0tIaHUw?=
 =?utf-8?B?STJ0RG5QbFJRYUV1MmJKbGJpUDk3eDFqZVBYM2EyMjJYNWgvaEVtMURDbVpE?=
 =?utf-8?B?ZGdQTUNQYlg4bHEwdkhhVGxYV3J2QkRvNUxEMlBFY3BtTjBSMFdLS0dlcVJU?=
 =?utf-8?B?bUZ3bUU5ZndaL2o5RXlPTmUvUnRiM3Jiek14UElQcFlPMzMydFV0R0JyMENE?=
 =?utf-8?B?Ym5SWXhLQ1JndWU3SlpwU2F3T0FqYzJ4SlZCR1UwWGZxZ3NjUVhIcytqTWsz?=
 =?utf-8?B?MzVzYVhwc21YYnhuZU5mY3B0RWRJYnpJLzRCR0s2SUltK1I2ZDIxV1IvRWor?=
 =?utf-8?B?YWdjYlZDb1lPbEhhcmFYUThtTm9jKzNzdlJBdlZRUU90SEhkSDFUUVFMVVU4?=
 =?utf-8?B?aW1jSUVIYnlFMzRTVC9jZFVjVW1PY2hBNjZZWjFJUnVSMkZzT0xoNHJVbGhy?=
 =?utf-8?B?Ukk4Y1V2OGNUSGdjdmlidnltWFdscFJheUxtRHR1S1RHUFlsWEFPSlRNT0JV?=
 =?utf-8?B?YStpYVo0eWpUc3YzK0EzaFRYc1Rua3c2bmtDcTlnR01IVEoyYnJoMlZCUEZR?=
 =?utf-8?B?K0Rrb2ZPOWYyZXdnUjViYzc4WXJGSU9SRHMxaVJCTExCRm5UZytiYkJtOEFj?=
 =?utf-8?B?TTFTUG1FUXc3K29LQ2xtd2svd1FiYjhpbGI3enNrZTNBZmZkdDRESWJTdUhj?=
 =?utf-8?B?L2w1eXlIWGFQeHJUb1d6MnRtTWh4dnNTQ3oxUTFqZDZiUHRMWlljdXJPbHZq?=
 =?utf-8?B?QzNzKzErY05yMVY1VDh0SUxXaHkxZFQ4Z0JDb0xCTUhNS2R3WGdheFpSTzh1?=
 =?utf-8?B?elJvczhLclFhM2syQ1I5REp4T21BZHdjL01KVmg3R2gyQVAvNUVmR2NtZzBa?=
 =?utf-8?B?Q3JnMjQ1S0JyYWxHWlIvTStGeFJtSGswU3htOE50TzN6cktRbWtib0xtR1dH?=
 =?utf-8?B?Wi95Qjg4V2wySDE4LzMxNVdiTjZJclJ5cDFzTTFtQ2hoOUw0Rllaa0tnb1FL?=
 =?utf-8?B?R1RuL2pWU1pQeks4b3N2dEJQY0hvc0REOXRRdkRGWlRyUEdwTXNnVHBxSXk1?=
 =?utf-8?B?eXdlNjBCOGd0T0NXZVAzK01XMjYvS2J0c1Y2bkE2bHgxdnIzSFlIZFF0eHMz?=
 =?utf-8?Q?NxL60bVnxn6XZzoe5Ps3O50soIiFL5p0llCdHt5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54de8b9-8d0e-498d-bc9d-08d8ef0b88b0
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 21:26:49.2018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZoxmP2OQrlINnTZ0E/ydfdsGBp+RoHb6bracBS0pk8DSUQFwBvKP6ApmSAZA5TulW8tRjziClLWaBgkV6nMJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
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
Cc: Leo Li <sunpeng.li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIxLTAzLTI0IDU6MTMgcC5tLiwgSGFycnkgV2VudGxhbmQgd3JvdGU6Cj4gK05pY2ss
IEJoYXdhbgo+IAo+IE9uIDIwMjEtMDMtMjQgNDozOSBwLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6
Cj4+IE9uIFR1ZSwgTWFyIDIzLCAyMDIxIGF0IDQ6MTggQU0gVGhvbWFzIExhbWJlcnR6IAo+PiA8
bWFpbEB0aG9tYXNsYW1iZXJ0ei5kZT4gd3JvdGU6Cj4+Pgo+Pj4gRE1DVUJfU0NSQVRDSF8wIHNv
bWV0aW1lcyBjb250YWlucyAweGRlYWRiZWVmIGR1cmluZyBpbml0aWFsaXphdGlvbi4KPj4+IElm
IHRoaXMgaXMgZGV0ZWN0ZWQsIHJldHVybiAwIGluc3RlYWQuIFRoaXMgcHJldmVudHMgd3Jvbmcg
Yml0LWZsYWdzCj4+PiBmcm9tIGJlaW5nIHJlYWQuCj4+Pgo+Pj4gVGhlIG1haW4gaW1wYWN0IG9m
IHRoaXMgYnVnIGlzIGluIHRoZSBzdGF0dXMgY2hlY2sgbG9vcCBpbgo+Pj4gZG11Yl9zcnZfd2Fp
dF9mb3JfYXV0b19sb2FkLiBBcyBpdCBpcyB3YWl0aW5nIGZvciB0aGUgZGV2aWNlIHRvIGJlY29t
ZQo+Pj4gcmVhZHksIHJldHVybmluZyB0b28gZWFybHkgbGVhZHMgdG8gYSByYWNlIGNvbmRpdGlv
bi4gSXQgaXMgdXN1YWxseSB3b24KPj4+IG9uIGZpcnN0IGJvb3QsIGJ1dCBsb3N0IHdoZW4gbGFw
dG9wIHJlc3VtZXMgZnJvbSBzbGVlcCwgYnJlYWtpbmcgc2NyZWVuCj4+PiBicmlnaHRuZXNzIGNv
bnRyb2wuCj4+Pgo+Pj4gVGhpcyBpc3N1ZSB3YXMgYWx3YXlzIHByZXNlbnQsIGJ1dCBwcmV2aW91
c2x5IG1pdGlnYXRlZCBieSB0aGUgZmFjdCB0aGF0Cj4+PiB0aGUgZnVsbCByZWdpc3RlciB3YXMg
Y29tcGFyZWQgdG8gdGhlIHdhbnRlZCB2YWx1ZS4gQ3VycmVudGx5LCBvbmx5IHRoZQo+Pj4gYm90
dG9tIHR3byBiaXRzIGFyZSB0ZXN0ZWQsIHdoaWNoIGFyZSBhbHNvIHNldCBpbiAweGRlYWRiZWVm
LCB0aHVzCj4+PiByZXR1cm5pbmcgcmVhZGluZXNzIHRvIGVhcmx5Lgo+Pj4KPj4+IEZpeGVzOiA1
ZmU2Yjk4YWUwMGQgKCJkcm0vYW1kL2Rpc3BsYXk6IFVwZGF0ZSBkbXViIGNvZGUiKQo+Pgo+PiBC
dWc6IAo+PiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8x
NTE4IAo+PiBIYXJyeSwgTGVvLCBSb2RyaWdvLCBhbnkgaWRlYXM/Cj4+Cj4gCj4gV2hlbiBJIGNo
ZWNrZWQgd2l0aCBvdXIgRE1VQiBleHBlcnRzIHllc3RlcmRheSB0aGV5IHNhaWQgdGhleSdkIG5l
dmVyIAo+IGV4cGVjdCB0byBzZWUgMHhkZWFkYmVlZiBpbiBTQ1JBVENIMC4KPiAKPiBUaGF0IHNh
aWQgYmFzZWQgb24gVGhvbWFzJ3MgdGVzdCBpdCBkb2VzIGxvb2sgbGlrZSB3ZSdyZSBnZXR0aW5n
IAo+IGRlYWRiZWVmIGF0IHJlc3VtZSBzbyBJJ20gYWxtb3N0IGluY2xpbmVkIHRvIEFDSyB0aGlz
IHBhdGNoLiBJdCBkb2Vzbid0IAo+IHJlYWxseSBkbyBhbnkgaGFybS4KPiAKCkFwcGFyZW50bHkg
YW4gb2xkZXIgdmVyc2lvbiBvZiB0aGUgcmVub2lyX2RtY3ViIChhbmQgbGlrZWx5IG90aGVyIAp2
ZXJzaW9ucykgaGFkIGEgMHhkZWFkYmVlZiB3cml0ZSB0byBTQ1JBVENIMC4gSW4gb3JkZXIgdG8g
c3VwcG9ydCB0aGVzZSAKb2xkZXIgRlcgdGhpcyBwYXRjaCBpcwpSZXZpZXdlZC1ieTogSGFycnkg
V2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CgpJIHJlY29tbWVuZCB1cGRhdGluZyB0
byB0aGUgbGF0ZXN0IEZXIGZyb20gbGludXgtZmlybXdhcmUgaWYgYW55IG90aGVyIAppc3N1ZXMg
YXJlIG9ic2VydmVkLgoKSGFycnkKCj4gSGFycnkKPiAKPj4gQWxleAo+Pgo+Pj4gU2lnbmVkLW9m
Zi1ieTogVGhvbWFzIExhbWJlcnR6IDxtYWlsQHRob21hc2xhbWJlcnR6LmRlPgo+Pj4gLS0tCj4+
PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9kY24yMC5jIHwg
OCArKysrKysrLQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2Rt
dWJfZGNuMjAuaCB8IDIgKysKPj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kbXViL3NyYy9kbXViX2RjbjIwLmMgCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kbXViL3NyYy9kbXViX2RjbjIwLmMKPj4+IGluZGV4IDhlOGU2NWZhODNjMC4uZDZm
Y2FlMTgyZjY4IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rt
dWIvc3JjL2RtdWJfZGNuMjAuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RtdWIvc3JjL2RtdWJfZGNuMjAuYwo+Pj4gQEAgLTMyMyw4ICszMjMsMTQgQEAgdWludDMyX3Qg
ZG11Yl9kY24yMF9nZXRfZ3BpbnRfcmVzcG9uc2Uoc3RydWN0IAo+Pj4gZG11Yl9zcnYgKmRtdWIp
Cj4+PiDCoCB1bmlvbiBkbXViX2Z3X2Jvb3Rfc3RhdHVzIGRtdWJfZGNuMjBfZ2V0X2Z3X2Jvb3Rf
c3RhdHVzKHN0cnVjdCAKPj4+IGRtdWJfc3J2ICpkbXViKQo+Pj4gwqAgewo+Pj4gwqDCoMKgwqDC
oMKgwqDCoCB1bmlvbiBkbXViX2Z3X2Jvb3Rfc3RhdHVzIHN0YXR1czsKPj4+ICvCoMKgwqDCoMKg
wqAgdWludDMyX3QgdmFsdWU7Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKgIHZhbHVlID0gUkVHX1JF
QUQoRE1DVUJfU0NSQVRDSDApOwo+Pj4gK8KgwqDCoMKgwqDCoCBpZiAodmFsdWUgPT0gRE1DVUJf
U0NSQVRDSDBfSU5WQUxJRCkKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXR1
cy5hbGwgPSAwOwo+Pj4gK8KgwqDCoMKgwqDCoCBlbHNlCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzdGF0dXMuYWxsID0gdmFsdWU7Cj4+Pgo+Pj4gLcKgwqDCoMKgwqDCoCBzdGF0
dXMuYWxsID0gUkVHX1JFQUQoRE1DVUJfU0NSQVRDSDApOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gc3RhdHVzOwo+Pj4gwqAgfQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9kY24yMC5oIAo+Pj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9kY24yMC5oCj4+PiBpbmRleCBhNjJiZTljMDY1
MmUuLjk1NTdlNzZjZjVkNCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kbXViL3NyYy9kbXViX2RjbjIwLmgKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kbXViL3NyYy9kbXViX2RjbjIwLmgKPj4+IEBAIC0xNTQsNiArMTU0LDggQEAgc3Ry
dWN0IGRtdWJfc3J2X2NvbW1vbl9yZWdzIHsKPj4+Cj4+PiDCoCBleHRlcm4gY29uc3Qgc3RydWN0
IGRtdWJfc3J2X2NvbW1vbl9yZWdzIGRtdWJfc3J2X2RjbjIwX3JlZ3M7Cj4+Pgo+Pj4gKyNkZWZp
bmUgRE1DVUJfU0NSQVRDSDBfSU5WQUxJRCAweGRlYWRiZWVmCj4+PiArCj4+PiDCoCAvKiBIYXJk
d2FyZSBmdW5jdGlvbnMuICovCj4+Pgo+Pj4gwqAgdm9pZCBkbXViX2RjbjIwX2luaXQoc3RydWN0
IGRtdWJfc3J2ICpkbXViKTsKPj4+IC0tIAo+Pj4gMi4zMS4wCj4+PiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QK
Pj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+PiBodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZnggCj4+Pgo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QK
PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeCAKPiAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
