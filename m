Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EFCC4743C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 19:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD85B611C1
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 19:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD85B611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59D4E6E980;
	Wed, 23 Jun 2021 19:05:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561856E979
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 19:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVXf24ojRhAeNwccwJE5m+ranZC18cdDXIJtvOomFmR0zD9ILEVMDyleZIF/U3MV9fcY+071PAbzACoEDS0/OwQLKR+sFPnKFB4Pv6DRlbuLT8D3tpwZCZXeltYZ7M1Uec5sXCh7g9h7ATLoNyirIMNOsAnlYRBdhJ4F38Kq7/g1S78TuAZWftmKQ/3Sq3gim8KoqpYTAuLCMKsBEA1XR/dZNVtX4jzgzFNbVHcRkZSZ6dpQu3lUxektL4p5cag3nRLGtrba4T/FHXj5TFvZvlwR07QGPZEmv6Z4Fl3WvPxvUCqBmYRjW2Hk0x0sRHWVX50YRDSTnaXpWhrjNYcCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yJBizuK3hd8HgNKetCD+drh8Ky7BJE7JqPo2TMH1E0=;
 b=mbrvvquO575SUUomJ1XORbCRBtgUTx6YwRJ8c+/PPsqnDpv6XZtxdhfN0lwSEdQfamPiVm28qBj2WEDIcOjBqYb+HPyC0zIJcBADw9jGoHNbgX2W+PPuWie9ohr+MgPAFsgA7llHk2eb6yh49jqFrgvhJwplyIk/VV94igs1P6+acH5luwVj0eDX1XtCh+eXU58/G+5U5VdA4jxxpReLoP3JjCImHNgOVeZeKX7yQW6z0JDB6i1gBmGH8jhiJDz27R6fnUSVeGzoRHMK3lBdCSEqPHeI5o3ojpDN2WKR9GLm/FYDJCQI3KlQx5lU6TD7su+5WXMTipi4lWxu+nw/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yJBizuK3hd8HgNKetCD+drh8Ky7BJE7JqPo2TMH1E0=;
 b=pYKRaOZ/pF4m6EWHI+FQJaiN5ZNvk4W2gQ64uJ1+QGCBeCpKmJTWFqMrXdPrOSTSQOm7pVtD4kzGttKtWcHTlAVIwiLPRE7E4r968djni1FGJEDqKY0u8+cliiYS4yx5juf//bHNA+xUb8nN1aD2mO0GkPCb8BFcbxjeKiYuJ6I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5228.namprd12.prod.outlook.com (2603:10b6:408:101::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 19:05:55 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 19:05:55 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: free pasid early before converting a vm
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210623122506.7397-1-nirmoy.das@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <9a1c3cc2-c0df-0e05-c241-c5041cacc913@amd.com>
Date: Wed, 23 Jun 2021 15:05:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210623122506.7397-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::16) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Wed, 23 Jun 2021 19:05:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6799255-2661-422e-a552-08d93679ed89
X-MS-TrafficTypeDiagnostic: BN9PR12MB5228:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB52284F26DB2C05BFBAAA083792089@BN9PR12MB5228.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fFxh0bB4m2pw6dGlFyJUQiNGSdczuUiLViHouEOpGQI59Cgfp7E1xDpb/Mr3MUcxvDuLiDnb3hcx3B19jvBKNx3QI5LWqGcrUrZhb37D5Zsj/SvsN4HdGgL1TCwyBJa7WyLonhAqpo6xZerMVghN/jQAAhxtixvyIJyrZdl3ElZE/TRXHrjUc+6TBfgh59e8P3kBIrkUSVAdTg0PVsrYyXjAnkCPUs68cdUxhp/qyuejrLMZQ7cpxGpUR5bDkk8Jzf19jMsStlzCli1oAr3H+NtQxgasRqnEF2WvlR9RjA62RayA+It1dFaYXH9+CvKhHjVLck3uXndbmMJRnDgxBAkr6cLDdIslZJbIUxubc+Ecz8v3FblvLXelkrJCdN/DoTuK57NmLYISFgVjwRs6dqruy46i2lHONW3sOWGcEXhUsVPYMHu0+yF7y9nOmXKGW3wXwa+raC4KhEDc2lcImFDCk0481wcUkUJkL0HVZ/ZWgTIiuWASeFhFvjgePg8TJ/iZVq9WieIlASynDdzUcxefdJSIOwpHE4mQI4JjX7s+0Ajkpn7NjjWgo/BhuK/QrzBe8Vfkw7FGCD1vBV+TxRM27iVN1Fxd9YR/GtiZOzrcXpjQbhfBYr/F9XNxi0CLckC93iQGcAeNyPu+nOHVK9pxHLrGZbQsS2F4QmLM35kcc35k6P/3NqRvPHc8VS3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(36756003)(4326008)(6486002)(16526019)(31696002)(53546011)(26005)(5660300002)(38100700002)(186003)(36916002)(2616005)(66946007)(86362001)(478600001)(83380400001)(31686004)(44832011)(8676002)(66556008)(8936002)(66476007)(2906002)(16576012)(956004)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2graHFMa2g1a1FCTXhGTHJqbFdFSXlvblhrRlpsQjVCK1BaQVQ0d3NPT0pD?=
 =?utf-8?B?RDJ6bjZkTjBoOTN2Ym52QlBXeXVpQU9KZS91b0RtcTFiYTJHU0t1VEJqUzlZ?=
 =?utf-8?B?ajJPbkNIQWxqODdHeTZHT1FYbUJxNnFZeGNIaWxJSE92Ri9VZjFML0ZBWVJu?=
 =?utf-8?B?cEpvbERSMThlK2krZllxVWtYZC9yN2U3WEFCQlRZcmhnL2p6MUp0dG9Qc3pv?=
 =?utf-8?B?Y0J1ZzcxM0tjMWFnVjQzc2llWmNyTlJGendNQlcrWndYWFlxa3VSWHZ1WDAy?=
 =?utf-8?B?ZlZPeUZHMjEyaDhCR25Xa0RWODVyWHhFMm5ucSt5YXJJdUhzZVA4MEgzVk1r?=
 =?utf-8?B?N2s4OFdsMi9GaktqTisyNGRFQTRvb1ZVU1V2a0l0UURWdW9YaTZvczJydXBr?=
 =?utf-8?B?RHJCQk9NTGd6RndUMGNjSzhWM2R5WHpnY1N6ZmJXMTJiUmlhb2xXMGR4ajdT?=
 =?utf-8?B?VkJlTTlEMitzTjhMOEJPVi9keWZ6QmZLQTZuL21CVmFoTHRiUFc2TDVrVzN4?=
 =?utf-8?B?ZG1wbEw0a0JsOE4vSEFKK2cwNWlJTXV1WW9JSm5LK2pOczY2a3dzOFhlb1Z1?=
 =?utf-8?B?RGFsTWx0clQ0dWhXeFRLN1NXTy9ObGhqbkgzTk0zUXJWQi9YUnJxcjQ5a3cv?=
 =?utf-8?B?UlZyNE03cmU5dW1XSzEvTFpqVk9yaUFWaUZ5MTF2QVVrZjdtZmJ1MXZ0UjBn?=
 =?utf-8?B?Z1NrQXY2MUtDTE5ZZVk2cGpqK1VhMExFOFdQbC8vWktEQ1UvaHFpMGhKK2Nn?=
 =?utf-8?B?alNjT3p0UW1PRjBjOW5hYkdFYmk0aUJwWENkWXRpYmpKUkVKbFFibUZ6enIr?=
 =?utf-8?B?cUZ4RWl5ZjUxcDI2MXZLbGp2amNOOUVoTm10eTZ3V3craXVUWDNyeFJEZkJs?=
 =?utf-8?B?Q0hTeUhxdHlqV29xazNZcjBOd2Zhb0ttelNuNlI2TTIwcFlNOWQ1MzgybHdF?=
 =?utf-8?B?dDlPYjZMbUpCRncwRXBGejJrRDFBNW81QkFvZUNTb29ueXA4ZHA0TERaMEpB?=
 =?utf-8?B?VnBOelpPOTY3SXdwazFreG43ZnAwSUxPNFVIVkVjd2VMQ0FXemNoejJEOHJu?=
 =?utf-8?B?a2Y4ZzRacWVWY241SEJOVGMyNFZxakZOQlkzdEEzdWhqWEY0cFF2VndnN0I1?=
 =?utf-8?B?Q2I3Vld3N3g2M0ZQKzYwZFNSYkNwMDF1blEvVlNTMHNoUEdxNHhtZGVIKzZq?=
 =?utf-8?B?R3lSbEhsNGY3R1o5ekd4amhET1JUVENxd1ZsMXMrZWw0bCswWDNvaHZQU0ph?=
 =?utf-8?B?aTkrSEsxT2MybmhUejZDcFdVODJVN01NSXFlU3BzZll6NlNJZ2dmU2p5UGhp?=
 =?utf-8?B?eGw5QXVFM3NxakpXNzcxQTFmRUdvU0V3OXJFeENSeFdtZWZqTWNwRnQ5L1dm?=
 =?utf-8?B?eSt2czBZSVhiUVY3bkh2YVdKaVNRYU83aEJJTHlNWldRVEwxeEdNWXlOS2tF?=
 =?utf-8?B?Mk42NnZRZ2swK3hYU29uQ0VCMDNhd2hiaUxzVGJHZHFMb09KbndyUFZISktn?=
 =?utf-8?B?SENUazFxSmpLeTJmNzFZb29LY0ZkSkQwVWNsV3VZU1ZjWG5icEJzOXNyZW1j?=
 =?utf-8?B?djZJdFFYMVN3NWErdjVDMU1xMDhQU1lXU0Iya0E2ME9Fdk9MZjNXWjhQbnQr?=
 =?utf-8?B?N0RRN2NOZEsxempBaDFpc0d5VUlYbDN3Z0lwWDJDSUlSdGM3YlBQMlFwOTNa?=
 =?utf-8?B?b0NoUUR2TVgxcXFPWXJQRXN3VTVBeThYZUFZM0dzRE9ZNDZoeDNnVEoydUpG?=
 =?utf-8?Q?SHAbH3HWILI5e3lJ8z1OPhf5jw02GQD8Ne0IXDE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6799255-2661-422e-a552-08d93679ed89
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 19:05:55.5432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srsJI+k+qXK60hg5rH/ld2hRBt2WZ7tU0rl0ybjXKA8xrRcCVpGpqgd19K6lGIW0g4uUa0C9I1Yy/A79DGlwOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5228
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
Cc: Christian.Koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNi0yMyA4OjI1IGEubS4sIE5pcm1veSBEYXMgd3JvdGU6Cj4gVk0gY29kZSBzaG91
bGQgbm90IGJlIHJlc3BvbnNpYmxlIGZvciBmcmVlaW5nIHBhc2lkIGFzIHBhc2lkCj4gZ2V0cyBh
bGxvY2F0ZWQgb3V0c2lkZSBvZiBWTSBjb2RlLCBiZWZvcmUgaW5pdGlhbGl6aW5nIGEgdm0uCj4K
PiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4gLS0tCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgfCA2ICsr
KysrKwo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgICAgICAgICAg
IHwgNSAtLS0tLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2FtZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZF9ncHV2bS5jCj4gaW5kZXggZjk2NTk4Mjc5NTkzLi40MmUyMmIxZmRmZWUgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4gQEAg
LTEyODcsNiArMTI4NywxMiBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9hY3F1aXJlX3Byb2Nl
c3Nfdm0oc3RydWN0IGtnZF9kZXYgKmtnZCwKPiAgIAlpZiAoYXZtLT5wcm9jZXNzX2luZm8pCj4g
ICAJCXJldHVybiAtRUlOVkFMOwo+ICAgCj4gKwkvKiBGcmVlIHRoZSBvcmlnaW5hbCBhbWRncHUg
YWxsb2NhdGVkIHBhc2lkLAo+ICsJICogd2lsbCBiZSByZXBsYWNlZCB3aXRoIGtmZCBhbGxvY2F0
ZWQgcGFzaWQKPiArCSAqLwo+ICsJaWYgKGF2bS0+cGFzaWQpCj4gKwkJYW1kZ3B1X3Bhc2lkX2Zy
ZWUoYXZtLT5wYXNpZCk7Cj4gKwoKSWYgYW1kZ3B1X3ZtX21ha2VfY29tcHV0ZSBmYWlscywgYW1k
Z3B1X2RyaXZlcl9wb3N0Y2xvc2Vfa21zIHdpbGwgdHJ5IHRvIApmcmVlIHRoZSBQQVNJRCBhIHNl
Y29uZCB0aW1lIGJlY2F1c2Ugdm0tPnBhc2lkIHN0aWxsIHBvaW50cyB0byBpdC4gWW91IApjb3Vs
ZCBmaXggdGhhdCBieSBtb3ZpbmcgdGhlIGFtZGdwdV9wYXNpZF9mcmVlIGFmdGVyIGEgc3VjY2Vz
c2Z1bCAKYW1kZ3B1X3ZtX21ha2VfY29tcHV0ZSBjYWxsLiBCdXQgdGhhdCBzdGlsbCBtZWFucyB5
b3UncmUgbWFraW5nIGFuIAphc3N1bXB0aW9uIGFib3V0IHRoZSBzaWRlIGVmZmVjdCBvZiBhbWRn
cHVfdm1fbWFrZV9jb21wdXRlIG9uIHZtLT5wYXNpZC4gCklNSE8sIHNwbGl0dGluZyB0aGUgYW1k
Z3B1X3Bhc2lkX2ZyZWUgYW5kIHRoZSB2bS0+cGFzaWQgPSAwIGludG8gdHdvIApkaWZmZXJlbnQg
ZnVuY3Rpb25zIGlzIGEgbWlzdGFrZS4KClJlZ2FyZHMsCiDCoCBGZWxpeAoKCj4gICAJLyogQ29u
dmVydCBWTSBpbnRvIGEgY29tcHV0ZSBWTSAqLwo+ICAgCXJldCA9IGFtZGdwdV92bV9tYWtlX2Nv
bXB1dGUoYWRldiwgYXZtLCBwYXNpZCk7Cj4gICAJaWYgKHJldCkKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYwo+IGluZGV4IDYzOTc1YmRhOGU3Ni4uYmU4NDFkNjJhMWQ0IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtMzA5NCwxMSAr
MzA5NCw2IEBAIGludCBhbWRncHVfdm1fbWFrZV9jb21wdXRlKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwKPiAgIAkJc3Bpbl9sb2NrX2lycXNhdmUoJmFk
ZXYtPnZtX21hbmFnZXIucGFzaWRfbG9jaywgZmxhZ3MpOwo+ICAgCQlpZHJfcmVtb3ZlKCZhZGV2
LT52bV9tYW5hZ2VyLnBhc2lkX2lkciwgdm0tPnBhc2lkKTsKPiAgIAkJc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmYWRldi0+dm1fbWFuYWdlci5wYXNpZF9sb2NrLCBmbGFncyk7Cj4gLQo+IC0JCS8q
IEZyZWUgdGhlIG9yaWdpbmFsIGFtZGdwdSBhbGxvY2F0ZWQgcGFzaWQKPiAtCQkgKiBXaWxsIGJl
IHJlcGxhY2VkIHdpdGgga2ZkIGFsbG9jYXRlZCBwYXNpZAo+IC0JCSAqLwo+IC0JCWFtZGdwdV9w
YXNpZF9mcmVlKHZtLT5wYXNpZCk7Cj4gICAJCXZtLT5wYXNpZCA9IDA7Cj4gICAJfQo+ICAgCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
