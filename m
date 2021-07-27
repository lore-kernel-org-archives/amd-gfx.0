Return-Path: <SRS0=HC41=MT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F050C4320A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 18:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283E360F37
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 18:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 283E360F37
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BF916E88F;
	Tue, 27 Jul 2021 18:17:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5531F6E0F6;
 Tue, 27 Jul 2021 18:16:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjHjWwaA70rw0oLKSAajlLQq99kFphSBIOAKaMMFJUscUzwrHKcH8mqLtgsPG1PPVCbyDxLOQHKwVuRpCDuoLEaoWU47FWgU+3kmrrShzCYqaWCt6d+UAcEiqMQzNgJtUd+d4LXK6LPF2m7NHHR0Mg6+1Xsg3J6QZS9c5Ocm8q3DEPv+RirdJwihu0c6fFMwFJ77jB8aJC42f91fEgGY++LODQdSsgkm7KVUmIcnd/HsT3cdco2tlH5rqkgSlqTs43/+PuJ5ltsuYa8q9Y5e+al7Uus2a/JqRBABzoYgLVRGomkmlELBNmQlCDY9QpzPMywbU3dyP3R1Kg4UoPiMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hahvPfWSuFcLBXv+omPK6TMFftjbjBYgzXJdbYE8hQg=;
 b=EqZVnYqAHrRMLK6z3oAKZfYy6PQmyI7Ps4IhPHviLAQTg8wLi0BfhGWe5WwOiBI3LR8v+wv7pbSR4OZiTmlOItEtY87a4EAbD4JfIY6kzIHFmoNOEZMhFJN5cWEpPe4hQswg5gWOMMvsTy/2a51ka54GNoViAc7j/ZtrvqamUg/NZzzZo5BCW4hqCxTiZPPd5arcE4AYIBM3SeOcRAOuRBFYtqQe8wTmwPCM+bzzkoKKvTRoHtnlSoWgnWP3YFVL8FfMZRXlGn8YyugBFyyJL3XxlQjPHufGLVuSwBzQentfEr3qnqqcUrSTquffZUvSxgze7dOFf68r6lBmiMS+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hahvPfWSuFcLBXv+omPK6TMFftjbjBYgzXJdbYE8hQg=;
 b=CO7DSjIjMg10YPONHpRx83BjedpsxwNJTSEtMN5Cpo0GiA0qmsND6mktDOysE7i9zXAaOIExp0Ja53SnhY6iPqDkhzWNhwroL+qv386yDouyPCEgH0VALaG5v82S59egsM5ow+D2EAZ/I9+VDmFZw/2uz+rCQ2e7sEUqciIFsRk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5210.namprd12.prod.outlook.com (2603:10b6:408:11b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Tue, 27 Jul
 2021 18:16:56 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 18:16:56 +0000
Subject: Re: [PATCH] drm/amdkfd: move PTR_ERR under IS_ERR() condition
To: Cai Huoqing <caihuoqing@baidu.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
 daniel@ffwll.ch
References: <20210720063435.373-1-caihuoqing@baidu.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <7b968d16-9306-8fce-e93a-f88c964f46e3@amd.com>
Date: Tue, 27 Jul 2021 14:16:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210720063435.373-1-caihuoqing@baidu.com>
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::6) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.144.73) by
 YT2PR01CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18 via Frontend Transport; Tue, 27 Jul 2021 18:16:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a84574ac-053b-40e0-5b4e-08d9512ab7d2
X-MS-TrafficTypeDiagnostic: BN9PR12MB5210:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5210BBC3E192BEAEC8D214C992E99@BN9PR12MB5210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIEbqsXjxIBNhywdH5iECbdSU28ZXLB5PDiketxI1r9u370bhjuyD4UiG130TOqGg7TOkWXnpz52m6ixg1pEYp0oMHVlAEsS6LHZSCiBr+FhSVMIQXHeMOPn/JQOkfiV1VTOF95TzQ7dN724ndfL+FlH20ZZFAZ2vyMuYHNWRFxompml/JufxWCaS9xGRvkrY0kuSTnopTVQi3O7BN9M/RNkxX4XksZTjngknI+PuJDl5nz+aXfECSs3ru5RY0RsNXFIT2AexpZTynYQOzM1LRiindPIM2cNZcFEuWn2qoZsyXYBYYq7ZzG/cwh3XzpluebtQ/R5/IrYcsg8VTNDXJhMWNsAjSzTTiA6SOPdljnMXoDE7GOXUgbcOkNeAEEvZLG6wKIUtjww0kYixyVjJbImzeb/BAfz2K9K+bJyCHRptStS78YlNWm4exKqLwIrS+E6ZL0DQQ9CbsNhsJyGHsrMu30z39CnLdHJFZWKlx6PUDCvHHq46AKqb8SbpCKw617X49wudMV6MedVakY54w8te7zK3JZ6AEG9/gszNDR2J9Px+mlmqP6I1oRCfHav0FOrK+3GjQ+RjXEAS6L7ko5gKRk7IkZ6V4kP1zE8E+pE/8k5u5+85Yl1S1mGRo/zlahqjJEW92anTZqF6vM0Nq7jpK2vSxvqvDe21flEnom4dzIr68Vq77DkXwhyLbkUKXWEN9VBJkNj87lHqrG4Wr2lnPS+KEBmHEej8F8xGCMnOjwXAOJGEVRadilhP/7y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(2616005)(31686004)(31696002)(8936002)(186003)(478600001)(36756003)(4326008)(5660300002)(38100700002)(2906002)(16576012)(83380400001)(86362001)(44832011)(6486002)(66946007)(956004)(26005)(8676002)(66556008)(66476007)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1hzY2tSOFowN1cxaENtVDEvYzJqMkxEK3ZwcWF1WnZTeFV4V2Y4UmgwRjd2?=
 =?utf-8?B?VlBBaWVxVzB3YXNqczdwY2pMVktidGUzd1lpWUUwWUt6b3hRbnBkMnFOdm5U?=
 =?utf-8?B?eHZHTTRCRXZxUlRsYWMvbEh6REFMNmZiYThXN3psM2V1MFVDdE11TnljTWxz?=
 =?utf-8?B?Q2V2czlqVTBSelErNkVJQnRHdDlLVGN3d1dXenVZaXNSSms2d09ueC9xL3VM?=
 =?utf-8?B?TVVKdlpDSEZNclhJbG1KQll4VE16RVJhV1FEQnFKaXI2TzQwbDFZellYcFcx?=
 =?utf-8?B?VDBjV1VIRFlnYkZid24vV3lIZDhmRmlNaGgvUkJYdnhHNDNxY2pCK0FOMmFl?=
 =?utf-8?B?dXV0alpaWkhFL3ZnN0ZieEwxNEhEMjZNZHl0c0VzSkhkK084a3Z1Y3lzVG1Q?=
 =?utf-8?B?cm1xOU42TktKbFpVTUNQVFdmYjhMcGNJNDRKeU9kNEVZMllPSDR4UDFXeTAz?=
 =?utf-8?B?QXRJS0s0RXhBTW8vbDlpeVRGT1Y5bkVvaEJEeTQzdndJbFRRS1RwRXExL1Yv?=
 =?utf-8?B?VGFVZnpJQ0FQR3ZmSjZWYnpnMkpkNU4wUmNLNjZqQmNkNXI0bXBmYnl4VHht?=
 =?utf-8?B?ZmFKYmh6T3l2TVVKSGd4cGFma0lNcGYwY1dkNXpXcGR3akNpY3A2cFZUbnVD?=
 =?utf-8?B?Q1dEanlwOTlFT2M3SFJzZWFpQWNnY1Y4dmErZFN0akFhWnliaVJ2cUpsMDJz?=
 =?utf-8?B?QksrNjhuTVpnekExZEw3VXhOdlRQM2VCNzZQQll3SVFUaHltTWtlUUF4V1ov?=
 =?utf-8?B?dVM4ZWVoWWJSTHJ2eDRZam1KZ2RZSUU0eGdXSnFXa3FEQk52OTVYcHdJNTBG?=
 =?utf-8?B?WHZYNTVUbCt2UVVXTTFFb1c3dU54NkFVeDlydDlXVEl5ejRZWVlSUVlFSFpS?=
 =?utf-8?B?Y3JTTW5vMkYrWlRlVHNlaU9MMXQwanBGRC9LRXU4TTVQaTZzTi9PdHZyQmxF?=
 =?utf-8?B?c05IdE8zT2ppLzZLc25CL1hCWHJkTnJJelB5MDMrY0trdXgrTVpqQXdHQ3hP?=
 =?utf-8?B?K0lFbmhpeEIxWXlzVW9VTXV5dXdsQzQ0Q0tpa05VcVhWU2xrem5oeXlaSlB2?=
 =?utf-8?B?Sk0rU3JRVURqcXNvOUxlTlhRalF6KzAzTEEvWE5ETU1XR2lyTW5ybmlSQlFJ?=
 =?utf-8?B?N2NKN2pWWGlBbEp3dVYxMlFKZXpuZXZQcjl1T2w0QlpGOVhoclNETUlObElQ?=
 =?utf-8?B?TU5MTStsOUdUM1JockVIOHNCZWNRRG5lUUZVT203OTM0bjQ0YWdQa2Z0Z2c0?=
 =?utf-8?B?a3IxYUlqWmRnU1luZk5zZitocDN1bkY2SldaZW5IaGdaZTJzZzhlaUViTE94?=
 =?utf-8?B?SWkyOGZOWDlOMDRtR2FKSzdKd25FVnBFNWtqNnVKdkhJa1BnR1lHS0draGhM?=
 =?utf-8?B?TDFQOEhwN3Y5Wk9MWlQ3WXJsTS9KUmhIdVJ6bTM4NzhYdjdGa1pzU0MwY3cr?=
 =?utf-8?B?ZmpXaGFzdjYzRVRDYjV6S204emthWDNZYkhvMzNDQjUwUy9mdUZhOTdCa01C?=
 =?utf-8?B?cDdrckowd0ZuOTFDQ09vSWNRMzlNeDlaV1M0TGUycjM3SWZndng4RVd4ZXFx?=
 =?utf-8?B?YW9IOHVPR3ZxUWxvQ0MrYlFXNFpsZm55YXpINXA2cXJpMllOa1RMMkFQZm5j?=
 =?utf-8?B?Q2YvZHJEdnUzK3VkTlVCSlVlWWxpODY5UzVrdlZJSVpRT0JvNStmNFhlN2U1?=
 =?utf-8?B?SVNhYm10WG5oNDAvQ21kblQ0c2NsbWh6WXcrTHU1RHdYM0NJYXF0T3ZCaDhT?=
 =?utf-8?Q?5g66rwhySu8We/1qZp5i2/jjmYtY5s9Ob7WkRxt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84574ac-053b-40e0-5b4e-08d9512ab7d2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 18:16:56.5592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QjSwswYOGAIob7Sari2ide9azxVmldzvRb57ePVmrhSMs39MVVjT8G7VqsOyoVJfeKBcqYSzCqAzeLSqvgFYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5210
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgSHVvcWluZywKCllvdXIgcGF0Y2ggaXMgdGVjaG5pY2FsbHkgY29ycmVjdC4gSG93ZXZlciwg
SSBkb24ndCB0aGluayBpdCBmaXhlcyBhbnkKYWN0dWFsIGJ1ZywgYW5kIGl0IGNoYW5nZXMgYSBj
b2RlIHBhdGggdGhhdCBoYXMgbm8gcGVyZm9ybWFuY2UKaW1wbGljYXRpb25zLiBUaGVyZWZvcmUg
SSB3b3VsZCBqdXN0IGxlYXZlIGl0IGFzIGl0IGlzLgoKUmVnYXJkcywKwqAgRmVsaXgKCgpBbSAy
MDIxLTA3LTIwIHVtIDI6MzQgYS5tLiBzY2hyaWViIENhaSBIdW9xaW5nOgo+IG5vIG5lZWQgdG8g
Z2V0IGVycm9yIGNvZGUgd2hlbiBJU19FUlIgaXMgZmFsc2UKPgo+IFNpZ25lZC1vZmYtYnk6IENh
aSBIdW9xaW5nIDxjYWlodW9xaW5nQGJhaWR1LmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYyB8IDEwICsrKysrKy0tLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwo+IGluZGV4IGU0OGFjZGQwM2MxYS4uNzEwNjU5YjNjMWYw
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jCj4gQEAgLTcy
LDE2ICs3MiwxOCBAQCBpbnQga2ZkX2NoYXJkZXZfaW5pdCh2b2lkKQo+ICAgICAgICAgICAgICAg
ICBnb3RvIGVycl9yZWdpc3Rlcl9jaHJkZXY7Cj4KPiAgICAgICAgIGtmZF9jbGFzcyA9IGNsYXNz
X2NyZWF0ZShUSElTX01PRFVMRSwga2ZkX2Rldl9uYW1lKTsKPiAtICAgICAgIGVyciA9IFBUUl9F
UlIoa2ZkX2NsYXNzKTsKPiAtICAgICAgIGlmIChJU19FUlIoa2ZkX2NsYXNzKSkKPiArICAgICAg
IGlmIChJU19FUlIoa2ZkX2NsYXNzKSkgewo+ICsgICAgICAgICAgICAgICBlcnIgPSBQVFJfRVJS
KGtmZF9jbGFzcyk7Cj4gICAgICAgICAgICAgICAgIGdvdG8gZXJyX2NsYXNzX2NyZWF0ZTsKPiAr
ICAgICAgIH0KPgo+ICAgICAgICAga2ZkX2RldmljZSA9IGRldmljZV9jcmVhdGUoa2ZkX2NsYXNz
LCBOVUxMLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNS0RFVihr
ZmRfY2hhcl9kZXZfbWFqb3IsIDApLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBOVUxMLCBrZmRfZGV2X25hbWUpOwo+IC0gICAgICAgZXJyID0gUFRSX0VSUihrZmRf
ZGV2aWNlKTsKPiAtICAgICAgIGlmIChJU19FUlIoa2ZkX2RldmljZSkpCj4gKyAgICAgICBpZiAo
SVNfRVJSKGtmZF9kZXZpY2UpKSB7Cj4gKyAgICAgICAgICAgICAgIGVyciA9IFBUUl9FUlIoa2Zk
X2RldmljZSk7Cj4gICAgICAgICAgICAgICAgIGdvdG8gZXJyX2RldmljZV9jcmVhdGU7Cj4gKyAg
ICAgICB9Cj4KPiAgICAgICAgIHJldHVybiAwOwo+Cj4gLS0KPiAyLjI1LjEKPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
