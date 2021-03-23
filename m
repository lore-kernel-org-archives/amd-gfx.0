Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F87AC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 15:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66497619BB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 15:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66497619BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 299FF6E905;
	Tue, 23 Mar 2021 15:42:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C49AF6E905
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 15:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXbEWRPu6fR1MGS9Aa5IhBuDJxpV2QJBLlVIkvzoA5GN6jkpFTtCuQJOwfZPipTmZEcybyrHyFaCm5yLKUXXRsgMTC19h9VGaRBt0SjGGURtU00OHlP5d+ZB+lQ05h3UIIAUvEqPoYGg9SLnJliIXUoG0+5zZ/6MQAXySoxrd2rMxZIYgVlOk58cpemcFKOAG8vmtV6VIyicC9uVGwgf9l9ofpt0yoDBm/aWGG/XlMFTNRL5NajR/bnY/KWSDhFS07orbn4bpAoTt+Md9kmCkMAt1LLl7nV0R6vfAcsFWxdp15AOQtO8/a0F+QnX/o1Vf30zZhcNjPXYfWSm6gaH1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEucnm27j5WsPjoNOI5H/Iu1c0MmPZGU/726sbhApuc=;
 b=Raen+nfy33NuN28km9owUKhhLnsF2AtqozYOvOvrdLj1wygWg20kgbW+KhPKS05PZwu81voXcqaQFASN3tqU4fDGFFCcfe1umJf1VxOghLjKmiUMV8BMx7SLFp7vH/TdwUjiHqyN0JRKMnW4aOp7f8cGSPvNvvE4ZC/bYBCOeS36uNZJ8NaaPdTpTfEnnvXqHown6HUV3URnYsDgKhCKwVb7fNtMrlas9H3eiM7i3ftZEBGalSJxvq1CNHtP8H/j3rV2gZ0DthIZAA5iNd60BCK8PJGBBHLCk4t/nYVY5Fsb3oveoXPxxUiT9rGNQ4ZDyitrpgnxreqOJFCwA6hHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEucnm27j5WsPjoNOI5H/Iu1c0MmPZGU/726sbhApuc=;
 b=KtlJOKGBeaW3faVp1Ei/MN433TRnSbrYx6ov8UekCUkw7TC2wSmm5pq8hVdpid+ejpX/sKHlLRgDz4FOTEen+FdYzZwo+3ru+U/5nuRCvlkcoGlUIBUqpGnMjyBV4lxfENZxPRkiEwSVN/ZgKsJMWsavSlaR7/9H5cfbjk9c56E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1830.namprd12.prod.outlook.com (2603:10b6:903:127::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Tue, 23 Mar
 2021 15:42:34 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 15:42:34 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: re-apply "use the new cursor in the VM
 code""
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20210323145458.38910-1-christian.koenig@amd.com>
 <20210323145458.38910-2-christian.koenig@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <c6e95087-600d-8b3e-8ab1-c247067d98e5@amd.com>
Date: Tue, 23 Mar 2021 16:42:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210323145458.38910-2-christian.koenig@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.110.215]
X-ClientProxiedBy: AM3PR03CA0073.eurprd03.prod.outlook.com
 (2603:10a6:207:5::31) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.110.215) by
 AM3PR03CA0073.eurprd03.prod.outlook.com (2603:10a6:207:5::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 15:42:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2e9d3a4-3859-44d9-fadd-08d8ee124735
X-MS-TrafficTypeDiagnostic: CY4PR12MB1830:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1830354DC9029E360723BCAB8B649@CY4PR12MB1830.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e3QY5kK9G8udQykTx3+liUiSDt9WctjYr8Pd/sVD7YM8v7ION9g5F1fBV6Z9+G5rd9qTpRTtRXI9o/qr3AfQu46RjR/ggojroD37h6/QwWrwaGZuA3qqv8ehxR2JvSuLSObt1Tg99eOpB0ByVXmxubRFJIWtDm35YOkm1exEehnhFEHGX7r1CWBKOKQUb7jiVquRuTJ/VgUfVAzPgzchy6ZMVXDW9JphfHU5rg/CmlnBR6pDueksMT2jK1HTfgeq0CmIIdGbilpctynX/UE+Ig0qTwPpeH90bSTl6BATEJIOxKVxp8laX+HPv+IpQhdZWxp00ODdWVZWlIOBpw+RFUwrNy07QhS4W6h5PCh2KRVgd3DfZgvLIDjra9zfKOGyXuE2UV88AEHW5PAWWfevJvrV1uhc2GvW1g2GTv55SXrUOOEu3WKitRbojIZRwDA8lLxenTCL05K9d9+48a2Z3iRrkW6vhasdXaYM1j6XY6QkyXx2ZLHlvC/4tTE29JGh6Ui9og+Zc+sTApuPMdJESDRGngcAU6STPSs36UP9A3TxX104xwfh0iin8LbpJENhhUMiu+5z1k0xbPlZuNNAQa9xXmK2bbXRAPo/mBO4fiOSBt+z8z9NFpo25WFtPZLiqczx4xjh5Js6Chq+gCTPX9410tZ5LT6Dyt4/8+05kNYf3VnmnV6he+aQ+LCTNyAWX9ResC3+WtIVZ+qhqqZ0kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39850400004)(66574015)(8676002)(83380400001)(6666004)(5660300002)(16526019)(53546011)(6486002)(2616005)(31686004)(956004)(66946007)(8936002)(66476007)(316002)(66556008)(478600001)(38100700001)(186003)(2906002)(36756003)(52116002)(4326008)(26005)(31696002)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VTd3L2hVNGF4RjJnR3phYS9MK1YxaUhiVVlUWXRSTXpuLzBYekJoNXpWdXpQ?=
 =?utf-8?B?dVhpeVlxSldrL0FVczk1dTdkaGZZTHNQOXRkQlB0QlBlL1lTVFZqVStVWEVl?=
 =?utf-8?B?d0hFZkZXR01PaDZBMDYwY01VQXNIZklCdlN3dUNZSkxjTWRQRzk3Qk9sNXcy?=
 =?utf-8?B?Q05mbWtGWjVmU2xJQWpkM2dKcmVHSVlDWVJpYWo4VmRSdmVCbi9Yekt2NGFN?=
 =?utf-8?B?SGJwcFF6M1ZTZW1XM3JSTWRJQmpodjZQUCtremc3NDhyKzhiamJZY0IxQWYy?=
 =?utf-8?B?M2Z2bVJTT2xBemkxelFtSmxPVHEyTjJCYWo5a0VTalZ1NkdWOVBtcjh0bzB5?=
 =?utf-8?B?Y3FadXpOV3pPSTE2R0g1VDUrWW51VXZRN0pMSGVTbkk3dnErZFo3M3ZtSzgz?=
 =?utf-8?B?b2QzRklWZ05CVjA5bllJZlRJSExvMFNneW5oV3IrbHVubjZib2p4OEluVmd2?=
 =?utf-8?B?di9UNkFvQnpoWVljTU50bnpyU2YxK3RRUlB3N0Jhdkt6WkRQSXhTS09VR0pI?=
 =?utf-8?B?ZHVUQXpyVTdlYjZPNE94U1pkMm5wcHMyS3BaclNlRlBvMzluYXoxREdueUVM?=
 =?utf-8?B?bUwybStNMGdZR3JLa0JPUDQwd2ZvSHVRcWJ3NE5oZUFiSTFtc2ozM2xSQWpU?=
 =?utf-8?B?Q0NsQW1iWkU5TzJZMkI4bmcxSVRzdHp3V2ZXQnFyQ3dNUWcrY01oMENFaDlT?=
 =?utf-8?B?bjdUYnpzY1FiVnhsUVE2UmJtMVhCdnVoK1JMM2YzZzJ3b2NqQW5rYmRNTEdZ?=
 =?utf-8?B?MU02U1ZIMkhsYmdvK0dZdjFta2J1bGMvNWpBVTdyRXdxUnJGUytpT1VXOElJ?=
 =?utf-8?B?NjFTVE1ITEtoMlFobnNkUjVibXFPNWp4azUveHdkc3d2UVZKbStNR1V0c3N5?=
 =?utf-8?B?eThPT2lYSUp1T3ErN281T3A5cnFSRG1JVWo1MDNFU3JGNXlXTEpFa2JiNllI?=
 =?utf-8?B?NERxQUU1cnd5NHFJOHdkSnNxRm5MOUhTOW5hVWJJaGRJeGEwUjVjQTNGMXdv?=
 =?utf-8?B?Zkh3WXgrTC9QN3F3RWxPOThqaFlTQ0hPWUtSR2VEQzNib0VKYVQ2a3NGWVBL?=
 =?utf-8?B?dGxZN2txOXFKY1daMnpjdFc3Ly9FeEFtRjRGMGpxSm9PQjlXOW91N3cwazlD?=
 =?utf-8?B?d0hxbStjTElPd2hiRTFMSWt6L21YSERtd0tzWS83OGRnZmZMNnhjUEhFYUxV?=
 =?utf-8?B?aEVYNFM1eENlZjIxeWdVUitPZURXbDNzelVlOXVzaWlqV3k2VGlyMXNxbWty?=
 =?utf-8?B?c3o0eE1TSnB4U3RGNlpKMG5hRDF4eWs0dkhBZ25jZ3hjay95WVBOKzNKU3pV?=
 =?utf-8?B?R1BpL3lvZHdESmI1eWU3VENDQUFPZzB1LytYRkp6MzdpRUh0cUk3WmhPOU56?=
 =?utf-8?B?R1lkd0pabU9Lb2w4YW1ueTcreEZacDMxRm1ybUNWOTZHenpZd3hYRW8xZ1dB?=
 =?utf-8?B?Wkpac3U3UURXNUljenp6UithV2lPRFpmL29XY3c1bU5OSko3TDQrZWp2SFMw?=
 =?utf-8?B?NWRJR29vbkR3WEhDdnUzaE5EYStOQnRZWGdjTTduRU9xanpRRlVpS09qM3c0?=
 =?utf-8?B?cEpobkJQZU5SMjBDa3lUdlB1Q05NdndYdXJvbVArV1NEN1B4S0ZKUTJhR2da?=
 =?utf-8?B?c3NZVnFqNG1XaU5lbWpKSC85WStYMFBsR0hhL2h1bUUrdjZ4djBvWTJCQXNV?=
 =?utf-8?B?ODI4R3ZBZGM3L1JqZWNudFRWWThudUJUdURVYzZvbGoxOEFjMVBNSGk3TmJp?=
 =?utf-8?Q?5fDHsyr89wQ1/SW6rwsS7vmNM6CFAK7PZq+MKc8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e9d3a4-3859-44d9-fadd-08d8ee124735
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 15:42:34.6826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F458CD2yw5VS6rmIbHahVAKagRuWX3CxkPysPg2PftJ1s2fkyylJ9n5tFfKcDMw9f+eXx/BZmeH+FcP9sq/Vig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1830
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
Cc: Guchun.Chen@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGVzdGVkIG9uIE5hdmkxeCB3aXRoICJwaWdsaXQgcnVuIG9wZW5nbCByZXN1bHRzL3Rlc3QiLgoK
VGhlIHNlcmllcyBpcyBUZXN0ZWQtYnk6IE5pcm1veSBEYXM8bmlybW95LmRhc0BhbWQuY29tPiBm
cm9tIG15IHNpZGUuCgoKQ3VyaW91cyB0byBrbm93IGhvdyB0aGlzIGhvbGRzIHVwIGFnYWluc3Qg
R3VjaHVuJ3MgVnVsa2FuIGN0cyB0ZXN0LgoKClJlZ2FyZHMsCgpOaXJtb3kKCgoKT24gMy8yMy8y
MSAzOjU0IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IE5vdyB0aGF0IHdlIGZvdW5kIHRo
ZSB1bmRlcmx5aW5nIHByb2JsZW0gd2UgY2FuIHJlLWFwcGx5IHRoaXMgcGF0Y2guCj4KPiBUaGlz
IHJldmVydHMgY29tbWl0IDg2N2ZlZTdmODgyMWZmNDJlNzMwODA4OGNmMGMzNDUwYWM0OWMxN2Mu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8
IDU1ICsrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTggaW5z
ZXJ0aW9ucygrKSwgMzcgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uYwo+IGluZGV4IDkyNjhkYjExNzJiZC4uYmMzOTUxYjcxMDc5IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtMzcsNiArMzcsNyBAQAo+ICAg
I2luY2x1ZGUgImFtZGdwdV9nbWMuaCIKPiAgICNpbmNsdWRlICJhbWRncHVfeGdtaS5oIgo+ICAg
I2luY2x1ZGUgImFtZGdwdV9kbWFfYnVmLmgiCj4gKyNpbmNsdWRlICJhbWRncHVfcmVzX2N1cnNv
ci5oIgo+ICAgCj4gICAvKioKPiAgICAqIERPQzogR1BVVk0KPiBAQCAtMTU4Myw3ICsxNTg0LDcg
QEAgc3RhdGljIGludCBhbWRncHVfdm1fdXBkYXRlX3B0ZXMoc3RydWN0IGFtZGdwdV92bV91cGRh
dGVfcGFyYW1zICpwYXJhbXMsCj4gICAgKiBAbGFzdDogbGFzdCBtYXBwZWQgZW50cnkKPiAgICAq
IEBmbGFnczogZmxhZ3MgZm9yIHRoZSBlbnRyaWVzCj4gICAgKiBAb2Zmc2V0OiBvZmZzZXQgaW50
byBub2RlcyBhbmQgcGFnZXNfYWRkcgo+IC0gKiBAbm9kZXM6IGFycmF5IG9mIGRybV9tbV9ub2Rl
cyB3aXRoIHRoZSBNQyBhZGRyZXNzZXMKPiArICogQHJlczogdHRtX3Jlc291cmNlIHRvIG1hcAo+
ICAgICogQHBhZ2VzX2FkZHI6IERNQSBhZGRyZXNzZXMgdG8gdXNlIGZvciBtYXBwaW5nCj4gICAg
KiBAZmVuY2U6IG9wdGlvbmFsIHJlc3VsdGluZyBmZW5jZQo+ICAgICoKPiBAQCAtMTU5OCwxMyAr
MTU5OSwxMyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAkJCQkgICAgICAgYm9vbCB1bmxvY2tlZCwgc3RydWN0
IGRtYV9yZXN2ICpyZXN2LAo+ICAgCQkJCSAgICAgICB1aW50NjRfdCBzdGFydCwgdWludDY0X3Qg
bGFzdCwKPiAgIAkJCQkgICAgICAgdWludDY0X3QgZmxhZ3MsIHVpbnQ2NF90IG9mZnNldCwKPiAt
CQkJCSAgICAgICBzdHJ1Y3QgZHJtX21tX25vZGUgKm5vZGVzLAo+ICsJCQkJICAgICAgIHN0cnVj
dCB0dG1fcmVzb3VyY2UgKnJlcywKPiAgIAkJCQkgICAgICAgZG1hX2FkZHJfdCAqcGFnZXNfYWRk
ciwKPiAgIAkJCQkgICAgICAgc3RydWN0IGRtYV9mZW5jZSAqKmZlbmNlKQo+ICAgewo+ICAgCXN0
cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyBwYXJhbXM7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X3Jl
c19jdXJzb3IgY3Vyc29yOwo+ICAgCWVudW0gYW1kZ3B1X3N5bmNfbW9kZSBzeW5jX21vZGU7Cj4g
LQl1aW50NjRfdCBwZm47Cj4gICAJaW50IHI7Cj4gICAKPiAgIAltZW1zZXQoJnBhcmFtcywgMCwg
c2l6ZW9mKHBhcmFtcykpOwo+IEBAIC0xNjIyLDE0ICsxNjIzLDYgQEAgc3RhdGljIGludCBhbWRn
cHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJ
ZWxzZQo+ICAgCQlzeW5jX21vZGUgPSBBTURHUFVfU1lOQ19FWFBMSUNJVDsKPiAgIAo+IC0JcGZu
ID0gb2Zmc2V0ID4+IFBBR0VfU0hJRlQ7Cj4gLQlpZiAobm9kZXMpIHsKPiAtCQl3aGlsZSAocGZu
ID49IG5vZGVzLT5zaXplKSB7Cj4gLQkJCXBmbiAtPSBub2Rlcy0+c2l6ZTsKPiAtCQkJKytub2Rl
czsKPiAtCQl9Cj4gLQl9Cj4gLQo+ICAgCWFtZGdwdV92bV9ldmljdGlvbl9sb2NrKHZtKTsKPiAg
IAlpZiAodm0tPmV2aWN0aW5nKSB7Cj4gICAJCXIgPSAtRUJVU1k7Cj4gQEAgLTE2NDgsMjMgKzE2
NDEsMTcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJaWYgKHIpCj4gICAJCWdvdG8gZXJyb3JfdW5sb2NrOwo+
ICAgCj4gLQlkbyB7Cj4gKwlhbWRncHVfcmVzX2ZpcnN0KHJlcywgb2Zmc2V0LCAobGFzdCAtIHN0
YXJ0ICsgMSkgKiBBTURHUFVfR1BVX1BBR0VfU0laRSwKPiArCQkJICZjdXJzb3IpOwo+ICsJd2hp
bGUgKGN1cnNvci5yZW1haW5pbmcpIHsKPiAgIAkJdWludDY0X3QgdG1wLCBudW1fZW50cmllcywg
YWRkcjsKPiAgIAo+IC0KPiAtCQludW1fZW50cmllcyA9IGxhc3QgLSBzdGFydCArIDE7Cj4gLQkJ
aWYgKG5vZGVzKSB7Cj4gLQkJCWFkZHIgPSBub2Rlcy0+c3RhcnQgPDwgUEFHRV9TSElGVDsKPiAt
CQkJbnVtX2VudHJpZXMgPSBtaW4oKG5vZGVzLT5zaXplIC0gcGZuKSAqCj4gLQkJCQlBTURHUFVf
R1BVX1BBR0VTX0lOX0NQVV9QQUdFLCBudW1fZW50cmllcyk7Cj4gLQkJfSBlbHNlIHsKPiAtCQkJ
YWRkciA9IDA7Cj4gLQkJfQo+IC0KPiArCQludW1fZW50cmllcyA9IGN1cnNvci5zaXplID4+IEFN
REdQVV9HUFVfUEFHRV9TSElGVDsKPiAgIAkJaWYgKHBhZ2VzX2FkZHIpIHsKPiAgIAkJCWJvb2wg
Y29udGlndW91cyA9IHRydWU7Cj4gICAKPiAgIAkJCWlmIChudW1fZW50cmllcyA+IEFNREdQVV9H
UFVfUEFHRVNfSU5fQ1BVX1BBR0UpIHsKPiArCQkJCXVpbnQ2NF90IHBmbiA9IGN1cnNvci5zdGFy
dCA+PiBQQUdFX1NISUZUOwo+ICAgCQkJCXVpbnQ2NF90IGNvdW50Owo+ICAgCj4gICAJCQkJY29u
dGlndW91cyA9IHBhZ2VzX2FkZHJbcGZuICsgMV0gPT0KPiBAQCAtMTY4NCwxNiArMTY3MSwxOCBA
QCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwKPiAgIAkJCX0KPiAgIAo+ICAgCQkJaWYgKCFjb250aWd1b3VzKSB7Cj4gLQkJ
CQlhZGRyID0gcGZuIDw8IFBBR0VfU0hJRlQ7Cj4gKwkJCQlhZGRyID0gY3Vyc29yLnN0YXJ0Owo+
ICAgCQkJCXBhcmFtcy5wYWdlc19hZGRyID0gcGFnZXNfYWRkcjsKPiAgIAkJCX0gZWxzZSB7Cj4g
LQkJCQlhZGRyID0gcGFnZXNfYWRkcltwZm5dOwo+ICsJCQkJYWRkciA9IHBhZ2VzX2FkZHJbY3Vy
c29yLnN0YXJ0ID4+IFBBR0VfU0hJRlRdOwo+ICAgCQkJCXBhcmFtcy5wYWdlc19hZGRyID0gTlVM
TDsKPiAgIAkJCX0KPiAgIAo+ICAgCQl9IGVsc2UgaWYgKGZsYWdzICYgKEFNREdQVV9QVEVfVkFM
SUQgfCBBTURHUFVfUFRFX1BSVCkpIHsKPiAtCQkJYWRkciArPSBib19hZGV2LT52bV9tYW5hZ2Vy
LnZyYW1fYmFzZV9vZmZzZXQ7Cj4gLQkJCWFkZHIgKz0gcGZuIDw8IFBBR0VfU0hJRlQ7Cj4gKwkJ
CWFkZHIgPSBib19hZGV2LT52bV9tYW5hZ2VyLnZyYW1fYmFzZV9vZmZzZXQgKwo+ICsJCQkJY3Vy
c29yLnN0YXJ0Owo+ICsJCX0gZWxzZSB7Cj4gKwkJCWFkZHIgPSAwOwo+ICAgCQl9Cj4gICAKPiAg
IAkJdG1wID0gc3RhcnQgKyBudW1fZW50cmllczsKPiBAQCAtMTcwMSwxNCArMTY5MCw5IEBAIHN0
YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LAo+ICAgCQlpZiAocikKPiAgIAkJCWdvdG8gZXJyb3JfdW5sb2NrOwo+ICAgCj4gLQkJ
cGZuICs9IG51bV9lbnRyaWVzIC8gQU1ER1BVX0dQVV9QQUdFU19JTl9DUFVfUEFHRTsKPiAtCQlp
ZiAobm9kZXMgJiYgbm9kZXMtPnNpemUgPT0gcGZuKSB7Cj4gLQkJCXBmbiA9IDA7Cj4gLQkJCSsr
bm9kZXM7Cj4gLQkJfQo+ICsJCWFtZGdwdV9yZXNfbmV4dCgmY3Vyc29yLCBudW1fZW50cmllcyAq
IEFNREdQVV9HUFVfUEFHRV9TSVpFKTsKPiAgIAkJc3RhcnQgPSB0bXA7Cj4gLQo+IC0JfSB3aGls
ZSAodW5saWtlbHkoc3RhcnQgIT0gbGFzdCArIDEpKTsKPiArCX07Cj4gICAKPiAgIAlyID0gdm0t
PnVwZGF0ZV9mdW5jcy0+Y29tbWl0KCZwYXJhbXMsIGZlbmNlKTsKPiAgIAo+IEBAIC0xNzM3LDcg
KzE3MjEsNiBAQCBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwgc3RydWN0IGFtZGdwdV9ib192YSAqYm9fdmEsCj4gICAJc3RydWN0IGFtZGdwdV9ib192
YV9tYXBwaW5nICptYXBwaW5nOwo+ICAgCWRtYV9hZGRyX3QgKnBhZ2VzX2FkZHIgPSBOVUxMOwo+
ICAgCXN0cnVjdCB0dG1fcmVzb3VyY2UgKm1lbTsKPiAtCXN0cnVjdCBkcm1fbW1fbm9kZSAqbm9k
ZXM7Cj4gICAJc3RydWN0IGRtYV9mZW5jZSAqKmxhc3RfdXBkYXRlOwo+ICAgCXN0cnVjdCBkbWFf
cmVzdiAqcmVzdjsKPiAgIAl1aW50NjRfdCBmbGFnczsKPiBAQCAtMTc0Niw3ICsxNzI5LDYgQEAg
aW50IGFtZGdwdV92bV9ib191cGRhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVj
dCBhbWRncHVfYm9fdmEgKmJvX3ZhLAo+ICAgCj4gICAJaWYgKGNsZWFyIHx8ICFibykgewo+ICAg
CQltZW0gPSBOVUxMOwo+IC0JCW5vZGVzID0gTlVMTDsKPiAgIAkJcmVzdiA9IHZtLT5yb290LmJh
c2UuYm8tPnRiby5iYXNlLnJlc3Y7Cj4gICAJfSBlbHNlIHsKPiAgIAkJc3RydWN0IGRybV9nZW1f
b2JqZWN0ICpvYmogPSAmYm8tPnRiby5iYXNlOwo+IEBAIC0xNzYxLDcgKzE3NDMsNiBAQCBpbnQg
YW1kZ3B1X3ZtX2JvX3VwZGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFt
ZGdwdV9ib192YSAqYm9fdmEsCj4gICAJCQkJYm8gPSBnZW1fdG9fYW1kZ3B1X2JvKGdvYmopOwo+
ICAgCQl9Cj4gICAJCW1lbSA9ICZiby0+dGJvLm1lbTsKPiAtCQlub2RlcyA9IG1lbS0+bW1fbm9k
ZTsKPiAgIAkJaWYgKG1lbS0+bWVtX3R5cGUgPT0gVFRNX1BMX1RUKQo+ICAgCQkJcGFnZXNfYWRk
ciA9IGJvLT50Ym8udHRtLT5kbWFfYWRkcmVzczsKPiAgIAl9Cj4gQEAgLTE4MTAsNyArMTc5MSw3
IEBAIGludCBhbWRncHVfdm1fYm9fdXBkYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBz
dHJ1Y3QgYW1kZ3B1X2JvX3ZhICpib192YSwKPiAgIAkJciA9IGFtZGdwdV92bV9ib191cGRhdGVf
bWFwcGluZyhhZGV2LCBib19hZGV2LCB2bSwgZmFsc2UsIGZhbHNlLAo+ICAgCQkJCQkJcmVzdiwg
bWFwcGluZy0+c3RhcnQsCj4gICAJCQkJCQltYXBwaW5nLT5sYXN0LCB1cGRhdGVfZmxhZ3MsCj4g
LQkJCQkJCW1hcHBpbmctPm9mZnNldCwgbm9kZXMsCj4gKwkJCQkJCW1hcHBpbmctPm9mZnNldCwg
bWVtLAo+ICAgCQkJCQkJcGFnZXNfYWRkciwgbGFzdF91cGRhdGUpOwo+ICAgCQlpZiAocikKPiAg
IAkJCXJldHVybiByOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
