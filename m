Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98328C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 21:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 531976109F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 21:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531976109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B3C6E05D;
	Mon, 21 Jun 2021 21:01:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E10CB6E05D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 21:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mplO5s47DmEf2opp/LYbbXJi+1ni7BD2x9XUPe7Z9JH0fS/AHy8L7UkkP92TZol0Cgm2yidNFNCKUm1D+yw1TqAFcBuVM7hTR4671ED+vmW6Spzfj3DwY2CrDFta9AmLOjBpecLUmLbmn14ZdN6dqcLJKo9inQzskhQG/PxMwhrPrZvRODsieTHkg/Frlpj6alyePKJIk8HvO72af28rBOJKDuJtML6Dm+ZtnEjJLGrS9fGjcED43DogjrD3ImhAhnf1aJyVP4D6yivxBbKUUzWSHopbK0WFy/oRrChqv+4Ha83FipcePSA7+JyH7+OrAgx/S2ny/hSrWTYzqdzG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnzYzwfhGJ82EPzI/wOJH5fvY54+5deAA0wSihVcUkY=;
 b=QCC/b1qBf3FkXOThckrySl3Q90LBKkLKSpDpQMTxMYoWYg4fWlW5k1FtIfmpj+jgk9KL9N364Krgoz+xpODI7Y2RFhI5usgKKh85XyHlR7sm5WQBhmrEj51P/gBdqseXd5Bsymv0oa4IPtqBekCW8PU4D7TR5kUTismmSsT5IbMJ+3gHM7I3NA11SGcM7lJ1H1oQyYHzTxblyjdWoUgybiavDgLipAuaJb7kv2Vv7TyXBV3sLVxAX2inkb0hxhLueusdLgCp4Ev95QRmS6lXL+qHlACfp5H0EaSLYGxeO1Ztn3YGrniSQ6tRxbVjcBhAUq7u6Vv8b49p2an5D9lCBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnzYzwfhGJ82EPzI/wOJH5fvY54+5deAA0wSihVcUkY=;
 b=JDmMgdZvs9Miz4Tl3VFRH0+cIbM8x9aYXVLhfK2uHMOxBtaB2/EIUej4bap+a+bWFbIfCKEG+oX5zNFFZXIcXpPbQwylvra1Atm2ws6e+/N8MCjkwaCLoZ6VhuPPlEpAqlncQaOEA5Quv+GIF/hLTS+3tT6stnRbnlbtAZ1u5Xo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 21:01:11 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 21:01:11 +0000
Subject: Re: [PATCH 07/10] drm/amdkfd: skip migration for pages already in VRAM
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210621160423.3517-1-alex.sierra@amd.com>
 <20210621160423.3517-7-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <af96d224-6135-ac5c-d688-32943611d774@amd.com>
Date: Mon, 21 Jun 2021 17:01:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210621160423.3517-7-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::27) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 21:01:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4e506b3-b50e-4c22-378e-08d934f7b2a2
X-MS-TrafficTypeDiagnostic: BN9PR12MB5368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB536860A199CD0A65D90B50CB920A9@BN9PR12MB5368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6kSbZrlffKuCKXuc2t+hd40a8MME7HgOZfg9Y+FOMXX7f5oTuC7L2n/2C9/Xm9jUXQZ/iS2+T/A7NzmMJHkzAib59O7MSJhZv5NGXRGcDxIIRQ8jAstxvNM/G2Lhtk9IQBepCyJSO1niHYwSIBAjf5yCCvyGVH/ZELi8O1FgvkadzBJmZMv3tc1SsmBxFgyfY7EyILw0IfnSj0d66EdfWIhcutb2eCs38azoVn2yUDI2flQd6R/UBcvjkiLPgBpt9BX6hHouBntSIU/yN+LoMb9/ykBgQTrziebUl7enm6a93MnRJ0R/L3pht9K7nHVsNAtuhL+YRctpL/FbYM8iFGOlEoUl9i3/E+Fm2v/kzQj1C4Z6zC5nEQId7FN/nT1xtSuZVFupcLpIE+pma9pCboJ0uJfe8eMqEP5OMPWjyMRdIdyl2AlDTFCEB5gwnLFK1MCC93hS41VNmrKGUOgk/xy4hla9AHbXN0L17AZjRFCRPa6sKBc0doeyeIUrd6WkcAZrO/Im0xKnR1uJppF0yk4aHav+bfLZPfABAoJhardh8D/wumBxKKsjUVmuMuO67BDgnnwQkBAsryyGtloYju9jIN//yICqW5/BWgHTXwWUzZ2GaM946JzaalLvl3n3Nz9ICU2e8/O10o9Qf4jWhgesk7FybNGoo67b6jp6FGN2RhJf430YcwObXwJSMivR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(31696002)(44832011)(316002)(36756003)(86362001)(8676002)(5660300002)(956004)(83380400001)(2616005)(38100700002)(186003)(31686004)(478600001)(6486002)(16526019)(66476007)(8936002)(53546011)(36916002)(66556008)(2906002)(66946007)(16576012)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDZRc3JQQjZBeHB5Ly9NcDBNRSt1ckVnQlpBaUVVYzE4YnVsc3duMlcva3FK?=
 =?utf-8?B?ZWFVWmpsNnoyUExyUVF0eEUvVFYrTGVXdUE2UExTWmo4WjJjU0tPK1Rjd0p3?=
 =?utf-8?B?OS9mS1h2aWVxbEZLSTNTcFNqUm5yZzlFYmU4VkEwczE3elJFRGFXS1F2SHFM?=
 =?utf-8?B?TEtyMUJCSDgxa3YwUm5DTUhpMEhLV3Mza25TdE9yUEJaMXphY2FFbW41aVI2?=
 =?utf-8?B?VWo3Y09weEFFZTA0R1hOeWlFVGFFbmpPVzB1cXpwUFROOGw5aXNhWWNic0JQ?=
 =?utf-8?B?b01Pc2VVby9uVGt0VFA3c3AxM1V0aUtZa3h3b3ZwZzhCS1lSdm41Vk5KbjlV?=
 =?utf-8?B?SG52NWtVOHJNakY4MlFYQkcyRnQ0TEpNb1N1bnRqNHRIbTVSd0M3RWI5NGpV?=
 =?utf-8?B?dHBPR0c0aER0NVdwbzRteS92MHdtZVRoYitXQ3ZXUEhaLzFBOWlZenF1WkNk?=
 =?utf-8?B?RjRRcTAzU1lYOWVEcDdUUk1PTitPVGthcW9VTmdXYmFhVit4dGZKbHJLSzJT?=
 =?utf-8?B?dEFaSFNjTi9RSG5WM1FiU1pLVVl4cXRpOEE3d3RsUHBrVWpkbWs0N1pKSDZq?=
 =?utf-8?B?S2V3UTIzUWxzeCtBM0NpMTRabk9IS2N3bDJMU1FHMTRqYVdOTE5nS04rOFlm?=
 =?utf-8?B?MHE2MlFrdGNLRFRmZmlMYUxTcTdVVHdwem9oZUx4R1hoNW5TTnFzamkrak50?=
 =?utf-8?B?UUhCNWhCcWN6WThhMVBoWDFEUFJSVkZPYWp5Wk9DTGdQbVVBWFJLaU1iWlBm?=
 =?utf-8?B?NG1yWlFlUkRXQUxtNXlZQUptK0VTSTRkTkdzV294clRXTHdXaHVNOERZcEZR?=
 =?utf-8?B?SzZDbVJHdlR0YjdvUHFtSlMwaGMxYmZjZkFySUxXMDJRazNkU3JMNlJiN1hB?=
 =?utf-8?B?TWNIaDdPQUg1M0VoREFMaEtLVEd1WHNvVGsxRlM5V2w0Vm4vTUJPcUlrY1lu?=
 =?utf-8?B?ZGpSdjhadVBsbHRCWWljN2I1WUFydDBIMlpSMlM2cXJYK3RCdTRCTW9MSE5M?=
 =?utf-8?B?Z2l4WnlJSTZoelAyaXR0enY3emV3ZDQxaE1VdnFwdXZVb0luVXJ1b056azJy?=
 =?utf-8?B?c05pMUJqVU9SNXRiT2dtN0pESmZNSDM3NUt1ZWQ0RzhwZUNmTFN1ekRvVktJ?=
 =?utf-8?B?Zi9MNXhwdDY4TXk2TEgxanVpTE1DQmNYc1pyemc3T1NSMEc0OUFkNXc2ZkI2?=
 =?utf-8?B?a2h6OUpiSFk5ZWpNUzFRV3JVdmgyL0ltdzNNbU5ndmFCcG0zR3JIbmMyWEsx?=
 =?utf-8?B?VFVlRFFwMEQyQ3FCak80V2dNMFlyZmwxT1lkYVFWc0lUMUx5RTBkZ2g5Rm01?=
 =?utf-8?B?R0RibmJURDFiS1AvK3poQUJuOW9hMDdoZU9hSnNWZUxUSjJRNUVtdWVTNWRx?=
 =?utf-8?B?MHJCVUUyRGxuVUlubUI5bHB4VmpXZ2luNnJDS3JBTzY3SGhoYUlhMkh5Z3BB?=
 =?utf-8?B?Vi9zeGszeFdtTGZYWlVtZGpKWDZ3TTV1M25pYTJkNXYzTGlPbFhFOC92OUto?=
 =?utf-8?B?NWU5T1psLzYwcUxnZXZYV3ZXRE9MOXRUSEhCRHBzKzZhMG93Sk1aL085RDE2?=
 =?utf-8?B?MkJmRUJaTXFNUUhMZUhQN0IxMm8rdGVXcWQvb2RyNHdNQlJQcWlzTWwzNGRZ?=
 =?utf-8?B?RDZYSU40S2QvQXR0a3NQNkl2YUJYZStXclM3bS9wb1ExbGFGNUMyaHMxZC8w?=
 =?utf-8?B?bzZ3aWp3aEltRmp2TDlQczBwVWI1WFNWcStrMEJSTFRidW90bzdIT1RjT3lq?=
 =?utf-8?Q?iRuhFSu3y5/+Rm6mTyvurndQeZRlL2c9kBioawJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e506b3-b50e-4c22-378e-08d934f7b2a2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 21:01:10.9691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ev9NHkGe2i2JninL9C33D83FOxvzlX2LpFIIDdYj8GWKnTmMapBNcTdyGZZp+TcOQw/HX+D74TZ8obn+spasuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wNi0yMSAxMjowNCBwLm0uLCBBbGV4IFNpZXJyYSB3cm90ZToKPiBNaWdyYXRpb24g
c2tpcHBlZCBmb3IgcGFnZXMgdGhhdCBhcmUgYWxyZWFkeSBpbiBWUkFNCj4gZG9tYWluLiBUaGVz
ZSBjb3VsZCBiZSB0aGUgcmVzdWx0IG9mIHByZXZpb3VzIHBhcnRpYWwKPiBtaWdyYXRpb25zIHRv
IFNZUyBSQU0sIGFuZCBwcmVmZXRjaCBiYWNrIHRvIFZSQU0uCj4gRXguIENvaGVyZW50IHBhZ2Vz
IGluIFZSQU0gdGhhdCB3ZXJlIG5vdCB3cml0dGVuL2ludmFsaWRhdGVkIGFmdGVyCj4gYSBjb3B5
LW9uLXdyaXRlLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBTaWVycmEgPGFsZXguc2llcnJhQGFt
ZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5j
IHwgMTcgKysrKysrKysrLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMo
KyksIDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX21pZ3JhdGUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdy
YXRlLmMKPiBpbmRleCA2ZmQ2ODUyOGM0MjUuLjhhM2YyMWQ3NjkxNSAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYwo+IEBAIC0zMjksMTQgKzMyOSwxNSBAQCBz
dm1fbWlncmF0ZV9jb3B5X3RvX3ZyYW0oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVj
dCBzdm1fcmFuZ2UgKnByYW5nZSwKPiAgIAlmb3IgKGkgPSBqID0gMDsgaSA8IG5wYWdlczsgaSsr
KSB7Cj4gICAJCXN0cnVjdCBwYWdlICpzcGFnZTsKPiAgIAo+IC0JCWRzdFtpXSA9IHZyYW1fYWRk
ciArIChqIDw8IFBBR0VfU0hJRlQpOwo+IC0JCW1pZ3JhdGUtPmRzdFtpXSA9IHN2bV9taWdyYXRl
X2FkZHJfdG9fcGZuKGFkZXYsIGRzdFtpXSk7Cj4gLQkJc3ZtX21pZ3JhdGVfZ2V0X3ZyYW1fcGFn
ZShwcmFuZ2UsIG1pZ3JhdGUtPmRzdFtpXSk7Cj4gLQo+IC0JCW1pZ3JhdGUtPmRzdFtpXSA9IG1p
Z3JhdGVfcGZuKG1pZ3JhdGUtPmRzdFtpXSk7Cj4gLQkJbWlncmF0ZS0+ZHN0W2ldIHw9IE1JR1JB
VEVfUEZOX0xPQ0tFRDsKPiAtCj4gLQkJaWYgKG1pZ3JhdGUtPnNyY1tpXSAmIE1JR1JBVEVfUEZO
X1ZBTElEKSB7Cj4gKwkJc3BhZ2UgPSBtaWdyYXRlX3Bmbl90b19wYWdlKG1pZ3JhdGUtPnNyY1tp
XSk7Cj4gKwkJaWYgKHNwYWdlICYmICFpc196b25lX2RldmljZV9wYWdlKHNwYWdlKSkgewo+ICsJ
CQlkc3RbaV0gPSB2cmFtX2FkZHIgKyAoaiA8PCBQQUdFX1NISUZUKTsKPiArCQkJbWlncmF0ZS0+
ZHN0W2ldID0gc3ZtX21pZ3JhdGVfYWRkcl90b19wZm4oYWRldiwgZHN0W2ldKTsKPiArCQkJc3Zt
X21pZ3JhdGVfZ2V0X3ZyYW1fcGFnZShwcmFuZ2UsIG1pZ3JhdGUtPmRzdFtpXSk7Cj4gKwkJCW1p
Z3JhdGUtPmRzdFtpXSA9IG1pZ3JhdGVfcGZuKG1pZ3JhdGUtPmRzdFtpXSk7Cj4gKwkJCW1pZ3Jh
dGUtPmRzdFtpXSB8PSBNSUdSQVRFX1BGTl9MT0NLRUQ7Cj4gKwkJfQo+ICsJCWlmIChtaWdyYXRl
LT5kc3RbaV0gJiBNSUdSQVRFX1BGTl9WQUxJRCkgewo+ICAgCQkJc3BhZ2UgPSBtaWdyYXRlX3Bm
bl90b19wYWdlKG1pZ3JhdGUtPnNyY1tpXSk7CgpJIHRoaW5rIHNwYWdlIGlzIGFscmVhZHkgc2V0
IGNvcnJlY3RseSBoZXJlLiBZb3Ugc2hvdWxkbid0IG5lZWQgdG8gCmFzc2lnbiBpdCBhZ2Fpbi4K
CkFsc28sIGlzIHRoaXMgY29uZGl0aW9uIChtaWdyYXRlLT5kc3RbaV0gJiBNSUdSQVRFX1BGTl9W
QUxJRCkgcmVhbGx5IApuZWVkZWQ/IEl0IHNlZW1zIHRvIG1lLCBtaWdyYXRlX3BmbiBzZXRzIHRo
YXQgZmxhZyB1bmNvbmRpdGlvbmFsbHkuIFNvIAp5b3UgY2FuIGp1c3QgY29udGludWUgdGhlIHBy
ZXZpb3VzIGlmLWJsb2NrLgoKUmVnYXJkcywKIMKgIEZlbGl4CgoKPiAgIAkJCXNyY1tpXSA9IGRt
YV9tYXBfcGFnZShkZXYsIHNwYWdlLCAwLCBQQUdFX1NJWkUsCj4gICAJCQkJCSAgICAgIERNQV9U
T19ERVZJQ0UpOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
