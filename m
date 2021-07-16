Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3845C07E95
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 14:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F78613F7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 14:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F78613F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3676E98F;
	Fri, 16 Jul 2021 14:09:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6F406E98F
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 14:09:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsGSoDQbuS6yir+FYk24KlRA/wCjHvnqvW7GkXFFT2DBZXWlD8AcyZo+6/2Gd8VSrQaJmB6LvW4uz5xm5Y5Okr4uzdPPjvfJErOEriVbqhN/CxgnFjHpkdO9BIsDxg0gupzIZqFIB5/1VVFAQDDm6l7htsiCA+7ODSSfoNW0acog5xaeGLaqoC9gNUawAassuY+0EzaM3DJjF2N/t1NVUjEZMJ90bhQIBrp2YGHvbdBe8se3glzlw+j/ThpQOwEOLpaFdtgW1ryRJyy/xV564Upi0Dem8yJs+aVaGQAS8AkP+36d4+57rN02JChzzfMK70B3k6VYHl8RdsZDs28yeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx2AjZuQ90NDZQ4ec1BYE+lqZjqoIieAlESzCYwbr78=;
 b=lX2gifTXpO3nz14B8Dl4Q1dwlt/OGZRY0LOt4nUr04fvWKNXEzWrrEjyl31zwJqbFsetElnw5trdb/XUOwlrH5rkkHKuO10UlSEwfPzDf64v7yNYjGWEwAQ5jvdd1/8I9yAkOsi9yGZ3ntf7Lulntfm2uNdq65srrfvFzeKibqWgKkcLwIox0PAwcnpzPzCjE9xI5xS0asMrwo6UiRdgTB11hxDiDGv/Blu/7V2bx8bqIEArisRsbqROvXJoVTeYLIwg7TRjfPMvc8FZ+yRIjx9RawCIv6WahKgACyr/KlfzFxfjdJqf9HVu9CHB9853VvqAebT0qO3BnBPUkKgXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx2AjZuQ90NDZQ4ec1BYE+lqZjqoIieAlESzCYwbr78=;
 b=1ffKEaGHqlr44OtfCTnQx+JUXRO86NvJiwuVPLXFv1dJnEToEtIR0fWH3jFq0kW0shX06hR6RQYOHb9XW0ISkZL4let019GwUtKXx5fNsELxho/rZ2zsCOC3xTfUIFIJsQbn1aWEhLu0bbk89wPsxGY8vrq7ovVkw7aj8VeMUyk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Fri, 16 Jul
 2021 14:09:02 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4331.027; Fri, 16 Jul 2021
 14:09:02 +0000
Subject: Re: [PATCH 5/5] drm/amdkfd: Fix a concurrency issue during kfd
 recovery
To: Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1626399273-21347-1-git-send-email-Oak.Zeng@amd.com>
 <1626399273-21347-6-git-send-email-Oak.Zeng@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1b825e67-e9b9-06dc-11cd-f07f818b374f@amd.com>
Date: Fri, 16 Jul 2021 10:09:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <1626399273-21347-6-git-send-email-Oak.Zeng@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::8) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YT2PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 14:09:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3804f60-6fe2-4d3f-f46b-08d9486343b7
X-MS-TrafficTypeDiagnostic: BN9PR12MB5211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB52115B349DA9BC34C7FD562F92119@BN9PR12MB5211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYIOp4d6Yie7JJKOQQEgw+CN7lLpsDjBIN3oJlJKQuqF3eWki8dB3P/APBD91dtFoARigLPMApx7OnookF9zPdkhuqEqzN9XBvxQEwO4Nxj7GwTm7DSX8Q8YoX2sTltCc0f9/5HWTTmvhT7Fpksr2seonFDcr/4VXXZ/iNzI9gnpuYIKHyJ0Rif/76Vx5qxcKfzAW9K5FLdElftvCajsswU1FS55XuMmj0+WlrCefuaAAEKlG/QtMS21JZijCmhCObGzHRBHzJD8qiaUTHDHkG1YDC/2OU/rcTaZunohJjIFn7BQ9I3cfOrKiCdv5sMO5QhHL2Ws/gAg7lxFMH/AKKpMUYZlZYGBNjI8oUnOkNq8yROTCn9RcJ7y6UCSJ25FuvtnvhNGRqHcqu0Y9vtXznBWDWBKWdydkbS1DhDe03/87Ve5F7lA/+aJonCwYWmHmWQ39us28bjtkwlGDWA9kWxoV27UH1bOb8F/UuaG8Dc+TKUENRgadyRYejEz8QKYWpnNswgWTu6sSoaLKJs1Urtrf3oGmlMQ2YMJQjykmyXv2uWDj2WyxmQNFn/q1NkHguFmn4RhCUWtI2SuVDCIf1gkq3NIukuA9pVEHJZR/kbAqpMIhjjjAI+5SmyfpUh1OQg7M8OXIxA7nMXCLl/1sS/ZKDwDCmecfzt4jL/DzXTmtN0EttSG7lF9XqrakGMWQQr0XU2UhHOzKV7OQ9gqTPfSLU2SPihicg6aRxN986YsJETl9eu1fGnkSuBrIsXx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(16576012)(956004)(5660300002)(44832011)(2616005)(31696002)(8676002)(8936002)(26005)(83380400001)(4326008)(186003)(6486002)(66556008)(31686004)(36756003)(86362001)(66476007)(66946007)(508600001)(2906002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVIxWFM1NEJHRS85eFlHR1dPNjY4OG9YREVYNUkrQUxpQnBhVmc2dlFybW5S?=
 =?utf-8?B?dkpnM2pld0NMRUIrTjJqbmJIMkRYVHRqTm96T21HaEVwR2NIdmlXSjhxQTkr?=
 =?utf-8?B?aDhUMEZxcWZGdlk2dkFMb3dtcjBOT2h4RDI3RG9oRXN0TU1RMTlxR3hhKzRK?=
 =?utf-8?B?ZjJ2eUJGTytHL09YYnNlZGZORnJUV0F1akFwclRsVGxjREYwWmdwRXVkdVdQ?=
 =?utf-8?B?UnFGaUJncG1BU09BWkJ3dUR5VklvT0tpM0IzN0hiL0x4aHNaMnB4N0lPY015?=
 =?utf-8?B?M00rcDV2NEJvREltUVpHUzNuTnY4K1h1NGNjQnFNK0g2WWEzR2pPcWYrWkcz?=
 =?utf-8?B?M0EvdUVhb0ZmTG1jSFF3cFlYNUJFdkY3MjlDUXYyVHVsUXMwMkZyUnAvTEVa?=
 =?utf-8?B?ZFpoeFFLdHVGSFVjVENlVTFzcUlRbDJvOGNOSnhob3dKWGtsMmlEd3l4eURq?=
 =?utf-8?B?dG1aazgrck1NQnJYZzNlV3FPK2hoaEVTOERIV3Fwd3hxZ1BiZ0Z3Y2c1SUpm?=
 =?utf-8?B?SVFlRUUrR1N3TVJSTmhLZ1BXMnBSeXdleDJSN2RBWWxJZzVwOW9HUllFSHN4?=
 =?utf-8?B?KzVSVmFsbU0rM0x1Zk93MVlwWmpZZ2RPcDQ0VXlvaHM5TmJoczU3OW9ZaXU0?=
 =?utf-8?B?SllnVHNNVXhaMVZKdUZtT09xa2dORHNqUWd3YlR3TkhCVlFjZXhXL0hPVnFH?=
 =?utf-8?B?SFVCUWhiQStlc3ZabXdDL2dROHZrQ2tLd3F6N1R3a3Y1cW9zcFFWNzA1amNV?=
 =?utf-8?B?K290amRLSE81elBwZ1NBZVFMalEzUC9mQWZTYkhBNGdydUR4cDdodWlpUWZD?=
 =?utf-8?B?RWRtaXVrZmc1SWxZa3BSSTdEbmdxYThMV0dqQk5qTU82a3F4NnQrUXpON2s3?=
 =?utf-8?B?dFBZc0NKQWxXY0NLT3p1ZFlrN0dHNys0TVVjOVNVQU5pSXAzUTN4aGtEdW5t?=
 =?utf-8?B?ZmgwcGt6VjZpTHNXcDNYenlTNUpVVGJCYVo0NHVpanFGOG5aWWk3bWEwS0dS?=
 =?utf-8?B?N0lEbzZlWXkvb0doY1c3UmNsUi9FdG11NmhKL3VTWDFzNnBNQ0tUK2ZIOG5X?=
 =?utf-8?B?b2NpaUo3bWUwYTB0TzRRQ2d3NG1IOXBnV2VQa2tGMDRGUURjZTRoaVgvMGxM?=
 =?utf-8?B?SnRDWit4SnBzdUJaV2FMVGtNMlppQ1JzeGw5NHJNQ2dCWXZteFNhVlZJUUxG?=
 =?utf-8?B?R3lYZWdCVVQ3NWZRbXRFM3ZzeWJTR0wycGtzL3JUcm42Y1VTQUM2RU41RHZx?=
 =?utf-8?B?NWM0OWxDc2s2RWp3RkQ2K01ISXJDVklZdUlPSC84TXdKZURDWjJuMUVQUlFG?=
 =?utf-8?B?RDFGRFBNNTROVWJuNkFpbldUWjcxZGU1N1hnak1FeFVPN0ZyT0hsK2JmMXpt?=
 =?utf-8?B?dmdZb3BIQlNPZnI4bjFzNmpkQzBqV0NJZGpDRU1ldkpmUkU1dmZtQWNicnFT?=
 =?utf-8?B?b2ZJT0ZxY2d2VlZDWTl1NVovUlc5Y0NTdWpKUkFwMHRaZ3ArSVJKY0VRYnFL?=
 =?utf-8?B?SXpTVFJ1RnBrN3BhMlpMMXRHSDFmS24wSGRwQzJ0WmNYVEpwdjJaTWNnSVhm?=
 =?utf-8?B?VDRLSlMvNEZHckZFemZ1ZnlaRXpYRGhFcU9XQWc5bzMrT1BHMWkrYndCVmJ3?=
 =?utf-8?B?bDZIRXhkbUF2cUUxdForV1c5OUtWZlkxQzB4Y0JiY1ZrQjVRb1pKYXB0VG9W?=
 =?utf-8?B?VTV2VnVmQWNMMjhRZjA3bFo5OXBIaEFqdFpNZHV2RDJNajVhTEtFcVAvUmxF?=
 =?utf-8?Q?gfAZ/ME6azDbsuTgx2JUQ/838gV+gxt8jV5hlgf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3804f60-6fe2-4d3f-f46b-08d9486343b7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 14:09:02.6180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uq5yKIc6UWsDd1+P+3mqjCVYbzFMcbxcZX/foqPpKlkHxsXUqP1fJW/C+R/6AeRy82EpwH4bthNdZPXXQ4TvPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211
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
Cc: feifei.xu@amd.com, leo.liu@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDIwMjEtMDctMTUgdW0gOTozNCBwLm0uIHNjaHJpZWIgT2FrIFplbmc6Cj4gc3RhcnRfY3Bz
Y2ggYW5kIHN0b3BfY3BzY2ggY2FuIGJlIGNhbGxlZCBkdXJpbmcga2ZkIGRldmljZQo+IGluaXRp
YWxpemF0aW9uIG9yIGR1cmluZyBncHUgcmVzZXQvcmVjb3ZlcnkuIFNvIHRoZXkgY2FuCj4gcnVu
IGNvbmN1cnJlbnRseS4gQ3VycmVudGx5IGluIHN0YXJ0X2Nwc2NoIGFuZCBzdG9wX2Nwc2NoLAo+
IHBtX2luaXQgYW5kIHBtX3VuaW5pdCBpcyBub3QgcHJvdGVjdGVkIGJ5IHRoZSBkcG0gbG9jay4K
PiBJbWFnaW5lIHN1Y2ggYSBjYXNlIHRoYXQgdXNlciB1c2UgcGFja2V0IG1hbmFnZXIncyBmdW5j
dGlvbgo+IHRvIHN1Ym1pdCBhIHBtNCBwYWNrZXQgdG8gaGFuZyBod3MgKGllIHRocm91Z2ggY29t
bWFuZAo+IGNhdCAvc3lzL2NsYXNzL2tmZC9rZmQvdG9wb2xvZ3kvbm9kZXMvMS9ncHVfaWQgfCBz
dWRvIHRlZQo+IC9zeXMva2VybmVsL2RlYnVnL2tmZC9oYW5nX2h3cyksIHdoaWxlIGtmZCBkZXZp
Y2UgaXMgdW5kZXIKPiBkZXZpY2UgcmVzZXQvcmVjb3Zlcnkgc28gcGFja2V0IG1hbmFnZXIgY2Fu
IGJlIG5vdCBpbml0aWFsaXplZC4KPiBUaGVyZSB3aWxsIGJlIHVucHJlZGljdGFibGUgcHJvdGVj
dGlvbiBmYXVsdCBpbiBzdWNoIGNhc2UuCj4KPiBUaGlzIHBhdGNoIG1vdmVzIHBtX2luaXQvdW5p
bml0IGluc2lkZSB0aGUgZHBtIGxvY2sgYW5kIGNoZWNrCj4gcGFja2V0IG1hbmFnZXIgaXMgaW5p
dGlhbGl6ZWQgYmVmb3JlIHVzaW5nIHBhY2tldCBtYW5hZ2VyCj4gZnVuY3Rpb24uCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBPYWsgWmVuZyA8T2FrLlplbmdAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jICAgICAgICAgICAgICAgfCAgOCArLS0tLS0t
LQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIu
YyB8IDEwICsrKysrKysrLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3BhY2tl
dF9tYW5hZ2VyLmMgICAgICAgfCAgMyArKysKPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRp
b25zKCspLCA5IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9k
ZXZpY2UuYwo+IGluZGV4IGM1MTQwMmIuLmFkYzIzNDIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2RldmljZS5jCj4gQEAgLTEzODMsMTggKzEzODMsMTIgQEAgdm9pZCBrZ2Qy
a2ZkX3NtaV9ldmVudF90aHJvdHRsZShzdHJ1Y3Qga2ZkX2RldiAqa2ZkLCB1aW50MzJfdCB0aHJv
dHRsZV9iaXRtYXNrKQo+ICAgKi8KPiAgaW50IGtmZF9kZWJ1Z2ZzX2hhbmdfaHdzKHN0cnVjdCBr
ZmRfZGV2ICpkZXYpCj4gIHsKPiAtCWludCByID0gMDsKPiAtCj4gIAlpZiAoZGV2LT5kcW0tPnNj
aGVkX3BvbGljeSAhPSBLRkRfU0NIRURfUE9MSUNZX0hXUykgewo+ICAJCXByX2VycigiSFdTIGlz
IG5vdCBlbmFibGVkIik7Cj4gIAkJcmV0dXJuIC1FSU5WQUw7Cj4gIAl9Cj4gIAo+IC0JciA9IHBt
X2RlYnVnZnNfaGFuZ19od3MoJmRldi0+ZHFtLT5kcG0pOwo+IC0JaWYgKCFyKQo+IC0JCXIgPSBk
cW1fZGVidWdmc19leGVjdXRlX3F1ZXVlcyhkZXYtPmRxbSk7Cj4gLQo+IC0JcmV0dXJuIHI7Cj4g
KwlyZXR1cm4gZHFtX2RlYnVnZnNfZXhlY3V0ZV9xdWV1ZXMoZGV2LT5kcW0pOwoKVGhpcyBmdW5j
dGlvbiBzaG91bGQgbm93IHByb2JhYmx5IGJlIHJlbmFtZWQgdG8gc29tZXRoaW5nIGxpa2UKZHFt
X2RlYnVnZnNfaGFuZ19od3MuIE90aGVyIHRoYW4gdGhhdCwgdGhpcyBwYXRjaCBsb29rcyBnb29k
IHRvIG1lLgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+ICB9Cj4gIAo+ICAjZW5kaWYKPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2Vy
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIu
Ywo+IGluZGV4IGYyOTg0ZDMuLjQ0MTM2ZDIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+IEBAIC0xMTY0LDYg
KzExNjQsNyBAQCBzdGF0aWMgaW50IHN0YXJ0X2Nwc2NoKHN0cnVjdCBkZXZpY2VfcXVldWVfbWFu
YWdlciAqZHFtKQo+ICAKPiAgCXJldHZhbCA9IDA7Cj4gIAo+ICsJZHFtX2xvY2soZHFtKTsKPiAg
CXJldHZhbCA9IHBtX2luaXQoJmRxbS0+ZHBtLCBkcW0pOwo+ICAJaWYgKHJldHZhbCkKPiAgCQln
b3RvIGZhaWxfcGFja2V0X21hbmFnZXJfaW5pdDsKPiBAQCAtMTE4Niw3ICsxMTg3LDYgQEAgc3Rh
dGljIGludCBzdGFydF9jcHNjaChzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSkKPiAg
Cj4gIAlpbml0X2ludGVycnVwdHMoZHFtKTsKPiAgCj4gLQlkcW1fbG9jayhkcW0pOwo+ICAJLyog
Y2xlYXIgaGFuZyBzdGF0dXMgd2hlbiBkcml2ZXIgdHJ5IHRvIHN0YXJ0IHRoZSBodyBzY2hlZHVs
ZXIgKi8KPiAgCWRxbS0+aXNfaHdzX2hhbmcgPSBmYWxzZTsKPiAgCWRxbS0+aXNfcmVzZXR0aW5n
ID0gZmFsc2U7Cj4gQEAgLTExOTksNiArMTE5OSw3IEBAIHN0YXRpYyBpbnQgc3RhcnRfY3BzY2go
c3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0pCj4gIGZhaWxfc2V0X3NjaGVkX3Jlc291
cmNlczoKPiAgCXBtX3VuaW5pdCgmZHFtLT5kcG0sIGZhbHNlKTsKPiAgZmFpbF9wYWNrZXRfbWFu
YWdlcl9pbml0Ogo+ICsJZHFtX3VubG9jayhkcW0pOwo+ICAJcmV0dXJuIHJldHZhbDsKPiAgfQo+
ICAKPiBAQCAtMTIxMSwxMiArMTIxMiwxMiBAQCBzdGF0aWMgaW50IHN0b3BfY3BzY2goc3RydWN0
IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0pCj4gIAkJdW5tYXBfcXVldWVzX2Nwc2NoKGRxbSwg
S0ZEX1VOTUFQX1FVRVVFU19GSUxURVJfQUxMX1FVRVVFUywgMCk7Cj4gIAloYW5naW5nID0gZHFt
LT5pc19od3NfaGFuZyB8fCBkcW0tPmlzX3Jlc2V0dGluZzsKPiAgCWRxbS0+c2NoZWRfcnVubmlu
ZyA9IGZhbHNlOwo+IC0JZHFtX3VubG9jayhkcW0pOwo+ICAKPiAgCXBtX3JlbGVhc2VfaWIoJmRx
bS0+ZHBtKTsKPiAgCj4gIAlrZmRfZ3R0X3NhX2ZyZWUoZHFtLT5kZXYsIGRxbS0+ZmVuY2VfbWVt
KTsKPiAgCXBtX3VuaW5pdCgmZHFtLT5kcG0sIGhhbmdpbmcpOwo+ICsJZHFtX3VubG9jayhkcW0p
Owo+ICAKPiAgCXJldHVybiAwOwo+ICB9Cj4gQEAgLTIxMDQsNiArMjEwNSwxMSBAQCBpbnQgZHFt
X2RlYnVnZnNfZXhlY3V0ZV9xdWV1ZXMoc3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0p
Cj4gIAlpbnQgciA9IDA7Cj4gIAo+ICAJZHFtX2xvY2soZHFtKTsKPiArCXIgPSBwbV9kZWJ1Z2Zz
X2hhbmdfaHdzKCZkcW0tPmRwbSk7Cj4gKwlpZiAocikgewo+ICsJCWRxbV91bmxvY2soZHFtKTsK
PiArCQlyZXR1cm4gcjsKPiArCX0KPiAgCWRxbS0+YWN0aXZlX3J1bmxpc3QgPSB0cnVlOwo+ICAJ
ciA9IGV4ZWN1dGVfcXVldWVzX2Nwc2NoKGRxbSwgS0ZEX1VOTUFQX1FVRVVFU19GSUxURVJfQUxM
X1FVRVVFUywgMCk7Cj4gIAlkcW1fdW5sb2NrKGRxbSk7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wYWNrZXRfbWFuYWdlci5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX3BhY2tldF9tYW5hZ2VyLmMKPiBpbmRleCBiMTMwY2MwLi4wMTIzZTY0
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wYWNrZXRfbWFu
YWdlci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3BhY2tldF9tYW5h
Z2VyLmMKPiBAQCAtNDQ4LDYgKzQ0OCw5IEBAIGludCBwbV9kZWJ1Z2ZzX2hhbmdfaHdzKHN0cnVj
dCBwYWNrZXRfbWFuYWdlciAqcG0pCj4gIAl1aW50MzJfdCAqYnVmZmVyLCBzaXplOwo+ICAJaW50
IHIgPSAwOwo+ICAKPiArCWlmICghcG0tPnByaXZfcXVldWUpCj4gKwkJcmV0dXJuIC1FQlVTWTsK
PiArCj4gIAlzaXplID0gcG0tPnBtZi0+cXVlcnlfc3RhdHVzX3NpemU7Cj4gIAltdXRleF9sb2Nr
KCZwbS0+bG9jayk7Cj4gIAlrcV9hY3F1aXJlX3BhY2tldF9idWZmZXIocG0tPnByaXZfcXVldWUs
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
