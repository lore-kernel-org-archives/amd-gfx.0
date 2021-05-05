Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A74C433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 20:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 757AC613C1
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 20:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757AC613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C08F6E509;
	Wed,  5 May 2021 20:02:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D1D6E509
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 20:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LE5LiAnt6Qiim2dti5yQEhwBHzqHRayibOTw9J7aqjUGCPhNxvCzq/TuCpQq20ahNarWQK8A1/rx2rLSgn+TyTZxUCqkNvAHxJ2R3kzmDzR1+jp/SgD1MU6DVDUIQ9zRngl/Hyp6RrxjbsIlh2djoF1jNW70KZTn46IFdLEvXlCnSBui/VC6LXOpLica6JxooVBaehEw+PLKCuDiOuCrUwv6w7gYndAjOjvyya1uSbPkLTv0uGPKAs+S+ZfTwq5QRP8xWXIleszdFl3IDeCluLP6rTvF5rCvJeonBmaCZOtYBjOphoTuBoHtPbOgI8L8pWW6w5GvcgI3RC/g4WtxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhKsTH7kKNH5qD/c6jgQoILBEn2XquL3rsxU2E1XzpY=;
 b=Rx6MidOR0e5k0tMSjydFX9GqNFZZ1tbLAumFQ7PcWMF0lg1i74upQp8CZxyxIgiy93swVNe6OtjhjXP84vwFoE1k2Gi1Gl1XCnyGo4QhJnCZgsNoyGgysrSXKiPEXxys6v1eX3oBLksvoYiMW23WRyCO3xXNRUleSAveTrvzyXITK4SzPwp3wLa6ud3BO1pb3O/MdMbmuKajYbde3BStpbvo3k8vMRVs9yj7qsH+JDQ9hMFoOdBjTTEfLXsSivnjvN4QSS0x/VR2dKKCI58IG7CMFhQZs1q//h3VuzrCixYV786zt566FU5GXNHewL5JKBOv8m0ihhPLmk1a6xlXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhKsTH7kKNH5qD/c6jgQoILBEn2XquL3rsxU2E1XzpY=;
 b=BXshOFNk5pwYhIzVCCu/3ikG5BnkKQek9W1JQ9s6AY7A/zq2968F8iV5LYXuv/ImbxP9/0dukp2DyByiQAEKwin9kyCSWKAn905+8UVO6o5898r6CJckKHzuGLTBPt6pfQwMPBMnJ5Ah9KlgA1ql5gLV04jcvVK7F/cwZ9ICqHU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5164.namprd12.prod.outlook.com (2603:10b6:408:11d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 20:01:58 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4087.039; Wed, 5 May 2021
 20:01:58 +0000
Subject: Re: [PATCH 1/2] drm/amdkfd: set prefetch GPU has access attribute
To: amd-gfx@lists.freedesktop.org
References: <20210505175617.30404-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2d145a22-a185-22d2-7ab2-a3ae06ccc97f@amd.com>
Date: Wed, 5 May 2021 16:01:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210505175617.30404-1-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.37 via Frontend
 Transport; Wed, 5 May 2021 20:01:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95d8f673-c7ee-432b-1f53-08d91000a39d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5164:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5164544D4AC94B96FD56897592599@BN9PR12MB5164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9FRr187VZMhr0BiPHS9V0i445VStyPsC6jT8/p5dLtz6xy1fW8Jpgws4ihpsAMXDxHXBpdnxQr6RYsCC3GTXiy0Bus5bc0v4TVhCBBx3c8L8wWCKYLv5hEAJ+fzlaqZJGfaYNXaZx33GVc50rq6bCH12VSWzFbODGfTwJCaYg9ONKX36JJtQfzLu/85DDzODzjeoSJ1qXPi0R8l+jbwrafQUp2RifbFPVDWcKeuHhWZeWV230GnkCb3HMsTFppZZXBoU/Wvnq5ZsMAXgc79aUUIyqMZCITKzecbX/4I4sMHwATGcIsoqHwZUUL441DS0S03g7646UWOxDI0hzNU8uiwWstj8fhNcFE7S4xBfOdvK6pZ7Cjd21Mn6YCY7OKXVQl6kN52dRZdxsp+t95141hC+HdaQhZp8N0XvHQp+qxoAYZiLU6BtfCqBFqc8evKplmJ+WoUhwUuiy/Soa+kIjoUF7ccppvLcy9AaJyC2UmTBVoXknYjkkSS3r/A/JpmjRJKToK4xKkhbnt0GTWwwNTuyJwFD7UYimop8BsygMejCz9emhxC2vmxh+Hl+dK4ynDfFjcnCCjQdwfRI+UX3hhqsaBiNrDivITFK8RhX+TDX5KT12TQ+LhUJlGulyJwX9HAO59Cq1Mrx7Fg8dS33rs/Nk/VwDFRXE1yymNUXiJnl7cG0hD4pHG9PTQ7ghDs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(6916009)(66556008)(44832011)(31686004)(36756003)(5660300002)(2906002)(956004)(186003)(66946007)(38100700002)(31696002)(8676002)(16526019)(2616005)(83380400001)(16576012)(316002)(86362001)(26005)(8936002)(6486002)(66476007)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V3ZhRHF2VDNmbnV4QytPN3BDNmZLcDZhTTgrd3hSY0xXejdXc0dqa01uNXlL?=
 =?utf-8?B?aElweWF3SE5oRTcwQmF0aER1aWJadHdaSUVyd3dZVm8zZTJIalBvaFNHZTds?=
 =?utf-8?B?M3NSdHdHTWZ5TlZFcjhKb00yeUNlbnNyTVhPZkxRWE5nNURxYS9TSjg4ZDlK?=
 =?utf-8?B?NjcxbXlXUFVFbVlTclBhZTFIaHpaODE5L3MyZEdkVHNsM0NKdTlITkVnamVE?=
 =?utf-8?B?YlN3MS9lcVUySkpMQUJlQUhKTVM5bW9HWE5xUzJ0alNqSVZPSzZCcExoaFY3?=
 =?utf-8?B?aHNtRjNjblJiNHZyaEhBUjU0aWcvekk4dVJBaUY4bnhBaXRFdnExZitCYW5N?=
 =?utf-8?B?Y0I3aXBSbmxab1hLU2dnQzkrdUZHaVVkTkp3OHN3MFVGQTdhZCt1REJZSWZQ?=
 =?utf-8?B?TFhoL0NvYVhKeGgvYWg1Qm42ODJ3ejRpeUY3UWpDd3JHeVNIL21OTlRCTjZv?=
 =?utf-8?B?QlVvb0hNSVRLTDUzZkw2cnFEZS9YTVhaQS83OEtNemVwRjRSUkVPamthYkI5?=
 =?utf-8?B?SHdoalNTN25lK3VWVXVndjUxNXpadllld0NreEZ0YjJaenMvTHJiRzhjOHor?=
 =?utf-8?B?NEh0RFE3OHRTZ2N3b3BOZkNmbElkVFFhamxVRGQrc3BycEhabnZnZ0VLejh2?=
 =?utf-8?B?dVJHL1ZvZ2RpWTJ4VjN5dEpGVlh3UlJFUFh0OVpCRzFaNTk5OFJwZjJRbmlm?=
 =?utf-8?B?Q2s5UHoxUStKMXVuTFI2T1VyUi9nM1BBVjNXYmJaVEw1TnQ3QTF4SWtwZGlQ?=
 =?utf-8?B?MnlSVUFDMVRlZE4zMHN3RXVxYUdKS1Z2cW5UWjEvYUg4bG1EU2grSjRMY3hD?=
 =?utf-8?B?dDN6RkUrZHZOWGZGMXkrZkZpQWRWTFRLck00Z1dRZCt6UG1rTkdkYkpmcXph?=
 =?utf-8?B?WjVycEdZZVY2SVZRVzY4YzVVWEM4dkdScXBiTndlNUdVTFBLc2doUTU5bjFj?=
 =?utf-8?B?ZStVMWlOR3RsYk90N1RlMGtPSVM1VGFzbU9tMHhFaG5yNElDZnRKaFBMZmN5?=
 =?utf-8?B?MWVXdk1yWXZJU2IzeHBhZkg1K1d5a2VxVnVhRXBtaExLMUxKbldJZjlsUkNF?=
 =?utf-8?B?dDNKYjBZSnVsb3VHbHczQUNuK1ZacmpOSHA3MXcrL1pHSHovNEtYZys2aVRS?=
 =?utf-8?B?R0NNdnZERElZaWRlamEyRjMrTm1rSXN3YU1HN1pMOGFSQ0hwNmNVYjY2QTRO?=
 =?utf-8?B?NURIa0tEd0c4VTBRR3ZhQkNmcm1tV3Z6cDBkSTZDU1NlTFhTM3RtQTE5R2ZR?=
 =?utf-8?B?WFRVSkJ6QURzQlRLY3JJRE1vbEhlWU5DVEpsOGMvd3RhOXZ4WFF3aHBtNFc2?=
 =?utf-8?B?bHpRRkN6MCtmNG4zVVVlRmtnM1pRcU93VUtPM01zUnJQRnVmN1RHelAzNHha?=
 =?utf-8?B?T3FEb2dZQldpNGR3MWNsd2U3N0xVSGVKU2t0OGpLRm85YkR5YlJXNE5EZ0Nk?=
 =?utf-8?B?QWE5OUZqeEZvT3RYVnJQYzNEZklBUFFKTThaaEplMGN6eXFMQ0ZqTWlqNkZi?=
 =?utf-8?B?Skt5dGVHR091ekIwaVJOK1Z3TTFzdGhsRWtHb1oxbHQ0SmRLanBjRmpETllo?=
 =?utf-8?B?Y2JuZDlFL3o1S0FTVy93ajZFcmtXY3J6UnRIdzQ2dTNZT0lwUVo5UjdocjF2?=
 =?utf-8?B?R0tlajZWcXhNOHpwSENoQ05BRThXSDRmSmhKSTNJSjhkMGxXRmRRblBSOVpj?=
 =?utf-8?B?L3RNbjJoL0JPekF1U0NnQkE2UkNsMGRGeVlSd1kwd0hRZHQybzM5YXhmWDVV?=
 =?utf-8?B?SU5hZ0VaNzVSWXE2ZUd3ZFFvRUt0dUJiU1dnRXBvSmRqcjFLcGdiSXorS3VK?=
 =?utf-8?B?SGYwa29EbzR6ZTZYRTQ2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d8f673-c7ee-432b-1f53-08d91000a39d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 20:01:58.2077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXFwGRcnJDl1kKiK8VHGGfxIIF4L5GLDtgBmzxhyflpd7ju3MQkjnaV5Gqu6j9E+XsNaZBQNz+oMjEA+2w33TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5164
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

QW0gMjAyMS0wNS0wNSB1bSAxOjU2IHAubS4gc2NocmllYiBQaGlsaXAgWWFuZzoKPiBBZnRlciBz
dm0gcmFuZ2UgcHJlZmV0Y2ggYW5kIG1pZ3JhdGUgdG8gR1BVLCBpZiBHUFUgaGFzIG5vIGFjY2Vz
cyBvcgo+IGFjY2VzcyBpbiBwbGFjZSBhdHRyaWJ1dGUsIGFkZCBHUFUgdG8gcmFuZ2UgYWNjZXNz
X2JpdG1hcCB0byBiZSBhYmxlIHRvCj4gdXBkYXRlIEdQVSBwYWdlIHRhYmxlLgoKSSBkb24ndCB0
aGluayB3ZSBzaG91bGQgY2hhbmdlIHRoZSBiaXRtYXBfYWNjZXNzLCBiZWNhdXNlIHRoaXMgaXMK
cGVyc2lzdGVudCBhbmQgY2FuIGJlIHF1ZXJpZWQgYnkgdXNlciBtb2RlLiBDaGFuZ2luZyB0aGlz
IHdvdWxkIG5vdCBiZQpleHBlY3RlZCBieSB0aGUgYXBwbGljYXRpb24uIEkgdGhpbmsgaW5zdGVh
ZCB3ZSBzaG91bGQgZWl0aGVyIHBhc3MgdGhlCnByZWZldGNoIGxvY2F0aW9uIHRvIHRoZSBncHVp
ZHggcGFyYW1ldGVyIG9mIHZhbGlkYXRlX2FuZF9tYXAgKHdlIHNob3VsZApvbmx5IGRvIHRoYXQg
aXMgeG5hY2sgaXMgZW5hYmxlZCksIG9yIGNoYW5nZSB0aGUgbG9naWMgaW4KdmFsaWRhdGVfYW5k
X21hcCB0byBhZGQgdGhlIHByZWZldGNoIGxvY2F0aW9uIHRvIHRoZSBiaXRtYXAuCgpJIHRoaW5r
IHRvIG1ha2UgdGhpcyByZWxpYWJsZSB3ZSdsbCBuZWVkIHRvIGFkZCBtb3JlIHNhbml0eSBjaGVj
a3MgdG8KcHJlZmV0Y2ggdG8gbWFrZSBzdXJlIHRoZSBwcmVmZXRjaCBsb2NhdGlvbiBpcyBjb21w
YXRpYmxlIHdpdGggYWxsIEdQVXMKdGhhdCBoYXZlIGFjY2Vzc19pbl9wbGFjZS4gT3RoZXJ3aXNl
IHdlIGhhdmUgdG8gcmVqZWN0IHRoZSBwcmVmZXRjaC4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKPgo+
IFNpZ25lZC1vZmYtYnk6IFBoaWxpcCBZYW5nIDxQaGlsaXAuWWFuZ0BhbWQuY29tPgo+IC0tLQo+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMgfCAxMSArKysrKysrKysrKwo+
ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9zdm0uYwo+IGluZGV4IGQ5MTExZmVhNzI0Yi4uM2I2NDA3NzJkOWM1IDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYwo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYwo+IEBAIC0yODY5LDYgKzI4NjksMTcgQEAg
c3ZtX3JhbmdlX3NldF9hdHRyKHN0cnVjdCBrZmRfcHJvY2VzcyAqcCwgdWludDY0X3Qgc3RhcnQs
IHVpbnQ2NF90IHNpemUsCj4gIAkJCWNvbnRpbnVlOwo+ICAJCX0KPiAgCj4gKwkJaWYgKG1pZ3Jh
dGVkICYmIHByYW5nZS0+cHJlZmV0Y2hfbG9jKSB7Cj4gKwkJCWludCBncHVpZHg7Cj4gKwo+ICsJ
CQlncHVpZHggPSBrZmRfcHJvY2Vzc19ncHVpZHhfZnJvbV9ncHVpZChwLAo+ICsJCQkJCQkJcHJh
bmdlLT5wcmVmZXRjaF9sb2MpOwo+ICsJCQlpZiAoZ3B1aWR4ID49IDAgJiYKPiArCQkJICAgICF0
ZXN0X2JpdChncHVpZHgsIHByYW5nZS0+Yml0bWFwX2FjY2VzcykgJiYKPiArCQkJICAgICF0ZXN0
X2JpdChncHVpZHgsIHByYW5nZS0+Yml0bWFwX2FpcCkpCj4gKwkJCQliaXRtYXBfc2V0KHByYW5n
ZS0+Yml0bWFwX2FjY2VzcywgZ3B1aWR4LCAxKTsKPiArCQl9Cj4gKwo+ICAJCXIgPSBzdm1fcmFu
Z2VfdmFsaWRhdGVfYW5kX21hcChtbSwgcHJhbmdlLCBNQVhfR1BVX0lOU1RBTkNFLAo+ICAJCQkJ
CSAgICAgICB0cnVlLCB0cnVlKTsKPiAgCQlpZiAocikKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
