Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587B2C11F69
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 07:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2031B61DBC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 07:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2031B61DBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B50C789220;
	Tue, 29 Jun 2021 07:48:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E06D89220
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 07:48:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEsjQ7HOqTiIOB5Zg96Z8sP8qIj41H+Ra17bPZbIesETocUWs06m8lgDAFujLyU4Ay0Xa1gD/bzX5VGqr0+w3AT5GIbw3TZuDz/aVjEcLKxxQdbRXwZpVr89SCpcimbPW8b7z9BCS+BCEU0Un7lxLMclmBBCPoWmb2qdKrNFBsJQGwPkvjrtc27P244lrRe3L0aqq/yo8JbAuYm3tYyql26oTNkE/4sCq8JYFJhwqDa2JMgqXgF+iYXJRGRp2awgLB+zsOh4zsoPmioeSISFEAf3emG4TMH4X7bIB6LfcCE7X/9Ba9gL/yRiDvBOZphyk/l3e5gZNbGp+lO5dnwtXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpdl8DRDOIl987tAilKXA7+PnVuRxrevgkfIDQDzBM0=;
 b=KSdaWpCEW+wMXYuL0w3nnam4MBKTAeO0TbLYeU/ZmknAGccqznlh3Xt+27McWs/5YOgl3re48uBUw7WXur1hGefVXe7tzLNoJlm4h9han0A0AQ3RKrQ95iqDm77m72AdNEF335IU3qOV7S5vIg9b6Gt8L8vwwCCaPP71YE2QPCR9iTU6CtjiIKXslDJcay44EeLhBd3gZCX2b7rGiHUm4pUU8a0fBgY3VATSQHknVL5xXQXTYQzWERwNCBEZ6qKoqyBxo1XonmFeq6EEnmwzjTV6N0d734Vc+7ECrCAAYanqiq5YrbggDmmU2qlXFe4tTL5Nmem28xupOk2j+gSdMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpdl8DRDOIl987tAilKXA7+PnVuRxrevgkfIDQDzBM0=;
 b=Lt5udj0SGsZqcXZYkEbBGoRGIhDAucv62ImQS7CYR3UAjLSxgk8wg4RukCyLt+7QVINLF7+ddSKaB9REUIpnhsCCZqckb9vnDzTZJSn4xSluybHiQDKVUutpfKMkgzKb1X9CauKHfHXUeZltqFIavF/tdIlP4qd8KbIUJZLw7GA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 07:48:34 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%4]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 07:48:33 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: free pasid early before converting a vm
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210623122506.7397-1-nirmoy.das@amd.com>
 <9a1c3cc2-c0df-0e05-c241-c5041cacc913@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <c16b93f9-3f78-b11f-b5a4-a6a912984194@amd.com>
Date: Tue, 29 Jun 2021 09:48:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <9a1c3cc2-c0df-0e05-c241-c5041cacc913@amd.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f27:5d00:9499:a270:2927:4d86]
X-ClientProxiedBy: PR1PR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::15) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f27:5d00:9499:a270:2927:4d86]
 (2003:c5:8f27:5d00:9499:a270:2927:4d86) by
 PR1PR01CA0002.eurprd01.prod.exchangelabs.com (2603:10a6:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Tue, 29 Jun 2021 07:48:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d8f6922-11ba-4e65-8961-08d93ad24b94
X-MS-TrafficTypeDiagnostic: DM4PR12MB5133:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5133847E04A1FE4EF5EE79358B029@DM4PR12MB5133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IuKGWtYyuBTWHUSy2ziDoP4WdRQPfRXPv8pwHdiYlxYF8LbPCH7Kh4rHftgjRB2AvN/prH2JcnTioP+9EEsuYJ1Lz9OgHKK1eYrlp6OMUl21HPdRsYN20uuD2XTsdmDBncNidGtcq7O+8jx5948Hc3+mLgpoP1GvgnW40yMAthRqi37TSXsX8ibodjXEnPu1ueWebK24vsPeakMCy6lzYkGWldDiAOWUNksHz9LW1ebRv1nt7nodsoLMf9GXqNoNhy7t25u9Hcb/CwbG9A5ZvZXu8rGwmHL4BVrE4UOVo/u6oxBfqKKrwZlshauw94h1mR90tFx7KzSM8O24MP4z5y/uCqH3n68Al3qIzMpGW/7Uccyfsb5jLcTKRmy2xiWuiHqiKhdOoSKfjwoE7DCPrwnSkgVvB7+fF6efbMmXN03zBtvOlX5cKCg+ED5fY1x9VHbKuibwXgG5PdxKaghrUPsea1Uslhv5c+8iSyuvXNHGEq7jcXw/8U7/HMqPlhe80ZjxbXl1ZlmazVL9UspaBhcnKxPIVm7IyMmPftLmAv4IzwU2hGScC4oFBv3GY6TRZM40NMfre1C0dB2SU8Fx/4PSN+lTMzKpjqlfK/5o9P5iGIcBv6usiSrdXzUsAnIEMEc6+XCusLhN5OHqaQPTVkxq/Cbpw0TZq6ckpyGwFZYYA4JZNODTJNjjJmXu15Kt6UgofI4lSY945jM1mS6fpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(52116002)(6486002)(8676002)(53546011)(316002)(8936002)(31686004)(4326008)(16526019)(186003)(2616005)(478600001)(66476007)(38100700002)(66946007)(6666004)(66556008)(5660300002)(83380400001)(31696002)(2906002)(86362001)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFpjVGg1VnFPVldzNU9ndnVhYTJLRHlHajJ5Y0hXUnErR2d6dWVoOWtxT1hE?=
 =?utf-8?B?R0g4RWJMSU9sckN1UWxSZlNycVAxb1FUelJRTnpINXZHU1VQWnJNSi9tWHdr?=
 =?utf-8?B?d3plQ1E0dDkwQmpiazN1S2dYbzdseFQycWF2OUlJMVpoYXhDVXpUWG1QK0dQ?=
 =?utf-8?B?eGQxajNPUm5WT0RmY2htblN6VEZPS2FGUlZKNXdkQVRVWTM3ZW1YVm4vTnZJ?=
 =?utf-8?B?aGwyTjVCZDJIekx5SGZRejV3OWgwWWtFYmFrSmxtV3QzOGJ0NVoyeU9FaHJZ?=
 =?utf-8?B?ZTFCNWJjNWxleTVmanhia1Q5aTd0ZlFqRlMyTlVUS1M5Z1MrSVducEVmSzNL?=
 =?utf-8?B?dHVlblppb3VLQzhWTkdoaHprR0VScmRZRGFJeHY0RzRac0hFRllKSDNIOVpi?=
 =?utf-8?B?eTNYckJoVDJ1Q0s4U0pML2QrRzk3bGNibmluUkJMejNxSlk1VzdqRnpYYURM?=
 =?utf-8?B?aGdFb28rc0lwdWE1QzdGeEdadlY4VHllNytVejNYdzMxVlVlbENZc0ZoeGNk?=
 =?utf-8?B?K2tOanR4azZDS0pFVXMxbkYzTVJIZ29tZEJEdmg0UGZzOTY1cFVjdGdwNHM4?=
 =?utf-8?B?eTFPZnJldGNaYmdGVnZXSkRHT0FXbFRkZHViQXV5RjQ4T0dlbWdOOUVtSjYz?=
 =?utf-8?B?aDhNNjZSVW5KbUtVSHZTYURycVI5NWhJdFc5dnNOTnRqRi9mLytISGFZZVhu?=
 =?utf-8?B?cGZmVkdhQWJKek9wSGVtWUI5RndvaGdqdytaNkdMdnFKcTdGL1cxNFUxM0pQ?=
 =?utf-8?B?TDBCMXhxV3ord2F3OTRwSmxzZHlMVlR1OUtUMEtHTVRjWUZwUkdIWlVUS3hm?=
 =?utf-8?B?R2pTcVJPYW5DUXdaem9wK1NmNUJod2ZTdjRRR3ByMzUzNlZacWNPNXVDamwv?=
 =?utf-8?B?Y3dzR29UNHNXNWRVSnJyT0tidWxxTFNranpFVmp4bHJlcG0rQXlldGhsNXJ0?=
 =?utf-8?B?R2lRQXFZSzFsenl0bkYvKys0dlV0MmF0QkM3ci9HaW93d0x0d1dDaHF0K1JJ?=
 =?utf-8?B?bnpiMXEwc0hIUmlKazZ1Rmd0UE92TW5kY0ZTeFBwcUtlWGJYNGFsdWh3d3BT?=
 =?utf-8?B?ZEtDb0s4cnBqR1h4YXF4RmNieUlnNWgzVTlxMUFXQ2hnMmlEWWNMbkZjYmNj?=
 =?utf-8?B?Slo1bWRZNkt1VkloT0ZCdU9TSndIaTFKN2JRZjloendWZ1F5OWpSVUx2ZS9E?=
 =?utf-8?B?cTBlUTNmblNISDhhZTBWelA1bDlHOW51R0hKNkVYa0drcS9XWXBFTFpBQTFD?=
 =?utf-8?B?aXN5N25SWEE0TzJ2ekx6U0VzV1ZxSzd1WS9MQzBzeXRjbUEzbk1uNWwvaGZP?=
 =?utf-8?B?U2JBU1RyN2RRc2hQTmV1YTJTSUNDTi9KbC8xQkd2R0Z0MlpoRWFSc1ZsVWhH?=
 =?utf-8?B?eSswS1hiL1czV0liYkVTMnRpV0VMMXUwK2MvY3J1VlFyVzBnVWszSVIwOHFT?=
 =?utf-8?B?K3hjdmQraVRIRStUbDlkR3JTOW5tVE1PUWJnV3ZMK21pUndmTThhc3QyYk9Y?=
 =?utf-8?B?UmJLV2JhTU52cXB2dnpPYWN0emRrMkVFN0p0b3dpOGtTQmp0VklZcmNsZ0lC?=
 =?utf-8?B?ZDhvVVNJUU4zNUdCUGRSeUpneW1GZ1I0OUZsUUdmWTd4Z3Y5N2RyQ0NsRFNM?=
 =?utf-8?B?b3FtZmw2TVVNR2d6RHlYQlFwanlodHVQeUh5TzRsYUxBajBGRkltT29KSXpK?=
 =?utf-8?B?WUFwUHhoa09ISE5yd0xRWDNBL0c4a0J4VlFRaXFlaHZZbW9jTHZEZU5Lcks3?=
 =?utf-8?B?aUVZVk9wNVVwdlBiUzJ0dVRGZEx2SWRzdlFmeW9BTnhHTnNnSmlxcFRLeHZB?=
 =?utf-8?B?a211WFdiNHk0enlsMnU0K2x4dUZxcUFtMzdOc3FxVTVzdGR1cGhvUThTandm?=
 =?utf-8?Q?MYt5Gb0MzUhU6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8f6922-11ba-4e65-8961-08d93ad24b94
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 07:48:33.6807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpZLw+HWafWBZ3sR0F95ZouzFVdhenT5gZWqDSiIFQyg6g5uLzq9pQDSq0dOknT2XS8T3TENLCHWITopkf5XMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
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

Ck9uIDYvMjMvMjAyMSA5OjA1IFBNLCBGZWxpeCBLdWVobGluZyB3cm90ZToKPiBPbiAyMDIxLTA2
LTIzIDg6MjUgYS5tLiwgTmlybW95IERhcyB3cm90ZToKPj4gVk0gY29kZSBzaG91bGQgbm90IGJl
IHJlc3BvbnNpYmxlIGZvciBmcmVlaW5nIHBhc2lkIGFzIHBhc2lkCj4+IGdldHMgYWxsb2NhdGVk
IG91dHNpZGUgb2YgVk0gY29kZSwgYmVmb3JlIGluaXRpYWxpemluZyBhIHZtLgo+Pgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgfCA2ICsrKysr
Kwo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uY8KgwqDCoMKgwqDC
oMKgwqDCoMKgIHwgNSAtLS0tLQo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPj4gaW5kZXggZjk2NTk4Mjc5NTkzLi40MmUyMmIx
ZmRmZWUgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmRfZ3B1dm0uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
YW1ka2ZkX2dwdXZtLmMKPj4gQEAgLTEyODcsNiArMTI4NywxMiBAQCBpbnQgCj4+IGFtZGdwdV9h
bWRrZmRfZ3B1dm1fYWNxdWlyZV9wcm9jZXNzX3ZtKHN0cnVjdCBrZ2RfZGV2ICprZ2QsCj4+IMKg
wqDCoMKgwqAgaWYgKGF2bS0+cHJvY2Vzc19pbmZvKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIC1FSU5WQUw7Cj4+IMKgICvCoMKgwqAgLyogRnJlZSB0aGUgb3JpZ2luYWwgYW1kZ3B1IGFs
bG9jYXRlZCBwYXNpZCwKPj4gK8KgwqDCoMKgICogd2lsbCBiZSByZXBsYWNlZCB3aXRoIGtmZCBh
bGxvY2F0ZWQgcGFzaWQKPj4gK8KgwqDCoMKgICovCj4+ICvCoMKgwqAgaWYgKGF2bS0+cGFzaWQp
Cj4+ICvCoMKgwqDCoMKgwqDCoCBhbWRncHVfcGFzaWRfZnJlZShhdm0tPnBhc2lkKTsKPj4gKwo+
Cj4gSWYgYW1kZ3B1X3ZtX21ha2VfY29tcHV0ZSBmYWlscywgYW1kZ3B1X2RyaXZlcl9wb3N0Y2xv
c2Vfa21zIHdpbGwgdHJ5IAo+IHRvIGZyZWUgdGhlIFBBU0lEIGEgc2Vjb25kIHRpbWUgYmVjYXVz
ZSB2bS0+cGFzaWQgc3RpbGwgcG9pbnRzIHRvIGl0LiAKPiBZb3UgY291bGQgZml4IHRoYXQgYnkg
bW92aW5nIHRoZSBhbWRncHVfcGFzaWRfZnJlZSBhZnRlciBhIHN1Y2Nlc3NmdWwgCj4gYW1kZ3B1
X3ZtX21ha2VfY29tcHV0ZSBjYWxsLiBCdXQgdGhhdCBzdGlsbCBtZWFucyB5b3UncmUgbWFraW5n
IGFuIAo+IGFzc3VtcHRpb24gYWJvdXQgdGhlIHNpZGUgZWZmZWN0IG9mIGFtZGdwdV92bV9tYWtl
X2NvbXB1dGUgb24gCj4gdm0tPnBhc2lkLiBJTUhPLCBzcGxpdHRpbmcgdGhlIGFtZGdwdV9wYXNp
ZF9mcmVlIGFuZCB0aGUgdm0tPnBhc2lkID0gMCAKPiBpbnRvIHR3byBkaWZmZXJlbnQgZnVuY3Rp
b25zIGlzIGEgbWlzdGFrZS4KCgpNYWtlcyBzZW5zZSwgSSB0aGluayBJIGNhbiBleHBvcnQgYW1k
Z3B1X3ZtX3NldF9wYXNpZCgpIGFuZCB0aGVuIGtlZXAgCmFtZGdwdV9wYXNpZF9mcmVlIGFuZCB0
aGUgdm0tPnBhc2lkID0gMCB0b2dldGhlci4KCgpSZWdhcmRzLAoKTmlybW95Cgo+Cj4gUmVnYXJk
cywKPiDCoCBGZWxpeAo+Cj4KPj4gwqDCoMKgwqDCoCAvKiBDb252ZXJ0IFZNIGludG8gYSBjb21w
dXRlIFZNICovCj4+IMKgwqDCoMKgwqAgcmV0ID0gYW1kZ3B1X3ZtX21ha2VfY29tcHV0ZShhZGV2
LCBhdm0sIHBhc2lkKTsKPj4gwqDCoMKgwqDCoCBpZiAocmV0KQo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gaW5kZXggNjM5NzViZGE4ZTc2Li5iZTg0MWQ2MmEx
ZDQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
Cj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+IEBAIC0z
MDk0LDExICszMDk0LDYgQEAgaW50IGFtZGdwdV92bV9tYWtlX2NvbXB1dGUoc3RydWN0IAo+PiBh
bWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgIHNwaW5fbG9ja19pcnFzYXZlKCZhZGV2LT52bV9tYW5hZ2VyLnBhc2lkX2xvY2ssIGZs
YWdzKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlkcl9yZW1vdmUoJmFkZXYtPnZtX21hbmFnZXIu
cGFzaWRfaWRyLCB2bS0+cGFzaWQpOwo+PiBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZhZGV2LT52
bV9tYW5hZ2VyLnBhc2lkX2xvY2ssIGZsYWdzKTsKPj4gLQo+PiAtwqDCoMKgwqDCoMKgwqAgLyog
RnJlZSB0aGUgb3JpZ2luYWwgYW1kZ3B1IGFsbG9jYXRlZCBwYXNpZAo+PiAtwqDCoMKgwqDCoMKg
wqDCoCAqIFdpbGwgYmUgcmVwbGFjZWQgd2l0aCBrZmQgYWxsb2NhdGVkIHBhc2lkCj4+IC3CoMKg
wqDCoMKgwqDCoMKgICovCj4+IC3CoMKgwqDCoMKgwqDCoCBhbWRncHVfcGFzaWRfZnJlZSh2bS0+
cGFzaWQpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgdm0tPnBhc2lkID0gMDsKPj4gwqDCoMKgwqDC
oCB9Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
