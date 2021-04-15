Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFACC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 21:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FD8610F7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 21:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FD8610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C76496EB0D;
	Thu, 15 Apr 2021 21:51:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4046EB0A
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 21:51:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UH+5Ed4zxWJE7BUOUlWWLqD439dlCNS5/dYHB17UThCEdKLKipg3VW1Fo5XRoff87io/M12+eICuUwFBOUY+E9BbQL4ULTHwegrfxuOr/nEZsnwhhYQd9yoLajcowivagJd/kf6X/Ug3MWYyFLdQ8kGMYNrPOOzkycef3EPyEK5S2SkWcymG61M9JqYxzbVDUhXRFMJ3kp8cma1nEZxk5lxgfLy5QE/3vlwNS7AaOoDXu6MyZZ292zNsVU2EIJIL7S2c0c/L+S8j7z1WzA8LXwh9xq7f76P2B8AAP+WwtoFRWpYueQFlmUki4l2fmABnyBTTSoUcFvdN79xAC/tUpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HShwtbVTPxfeM6VSbbNV6D1rRt8HU7AL7mSK7BagaOA=;
 b=D2B+5EOOK4DzzHGIcqPWwQfAcF/2nuvXfVNd3jd+TC3a0cDK1lDlvSkT0oedMHE5VNm3aKpKW7DfiEXGkLBDCBF9Wrz8y8zMhrjGro84DC7MjViTBEDbNxx7LbB7MzVop2+TfBcn/1duPo33WKh4tR98vIFEDw3EbmJAuCsOffGqLtNqkfjUzDUNcWSaUMjXTcWiP8U+bC1v2Ii4qEbUEHgAqYsH87ZTkxwY/6EAnFVCn6r05rQiXjMGmebrBefu+nDir2LnFC4+PghF8DcDOYgfHaAIJ14K3AOJAqSASB9wxQIvt0CF1FEG/HvE4oYcVn07tYhl9qZlH7+odq+0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HShwtbVTPxfeM6VSbbNV6D1rRt8HU7AL7mSK7BagaOA=;
 b=1HWmW/X9ubLfpLFzMrh4q7+Ahp/UyKFBVFtuvVZP1BSPeJAxNUH+4T8mAEsmtHr/tC7ufE4orXb4UKigPPaXZAEe5YxToLOGEG3e8GB2FgiBKVieC+5NMeGtqceG/tghirhJXOuIzRGd8p7v51yw9FHhnCnTy4yiErrwrcfD63k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2546.namprd12.prod.outlook.com (2603:10b6:207:3f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 15 Apr
 2021 21:51:51 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Thu, 15 Apr 2021
 21:51:51 +0000
Subject: Re: [PATCH] drm/amdkfd: set memory limit to avoid OOM with HMM enabled
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210415214332.9631-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <72c15b2b-c71f-45b9-cb3c-1c56cb20bc3e@amd.com>
Date: Thu, 15 Apr 2021 17:51:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210415214332.9631-1-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.180.233]
X-ClientProxiedBy: YT1PR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::10) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.180.233) by
 YT1PR01CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Thu, 15 Apr 2021 21:51:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7e4e70f-689f-49bb-042f-08d90058ad3b
X-MS-TrafficTypeDiagnostic: BL0PR12MB2546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2546F954012677B6646AB996924D9@BL0PR12MB2546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vxi3dr+ZTXxVt2anl+zpn19VA4Ptyi3Po3MgN8jXSEI+7EtRkRgtFjjFfEi8+Y03JFOuiwr2hMEqCV7ktBwh107NlaABm/5cVDmfsllrBFAC6TlFTdivJBYqICBAhqfIfmleuknadJqew8y5qeIVUtDjKJErNcEE+jmYvQc6jzzx+dYZ+qGmOTO7RJIjMCWlxRF2E6DXXkTFYM9zyDI/3Qapfwkn16josFw3DkEU7hf15Tn+MH3Fe2Au5/G3pUFVNq+/caNmPmlwfp07iyWTuRZldr13oeuuQHjKMcBq4w23i7bICs4yfJ20ODHZGlkghS/4QFGT301svmHj7YqmAbM5mX/KyEtX6D45QxMILSyT1bg9tOWn/2Z7Uke6AdehU4KLZpj+e7vyeaH5EX6dwlqH2TZZrjCpPba2kaE7S9Fwk1A2558y5uCYd/IPD1XmutqlbntAJDui4yOodoujWRY1VG7zkdI5uNxvgbJqDqT0EAwg+51ugMaVACLetGr9BcxUW1d/tHjyAaVmZB7FYPUFcRu/8yKwoIIuHgsP0XMGDvt2YBMthTtFuP38lmGNnYbs0qyYeGyRrDxQQ7b5/lk6CtoY2KhBTKB07z1RfH9uWG+pobtqKcsUD8eTBwJ/G82slKLMtxWmXALlpgoRwAEow8HrVAyhwR+hKcmnCj9QT7eQcLZmtUXG3IW7YuqS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(478600001)(8676002)(6486002)(66556008)(44832011)(5660300002)(8936002)(16526019)(186003)(38100700002)(26005)(316002)(16576012)(2906002)(83380400001)(956004)(2616005)(31696002)(86362001)(36756003)(66476007)(31686004)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NFNEZjE4K0hrcmFWTEVzVnQzTlplUkJJWk9TZENOQkhOTnFSZHFPbXJzTDhG?=
 =?utf-8?B?NVR2Q1g1eENMYWhJRTJCelhmTlc2N2lPM2g1MHNTdGtUSWpEZUtwRXlUSFhK?=
 =?utf-8?B?S0RvdjFVaWMzRFY0dlJpY2FVaWNCU0RXMjY1RE5qcm1JelVjWWlZWmRYV29Z?=
 =?utf-8?B?L2cwcVNPSTZYb25GSzA3NEYyMElUdmQ3dDF1dTVtM1FaR2JPcjBvczRIN0lX?=
 =?utf-8?B?VG1COWdEZlpITDRYenRVODQyNmdzRURpclpXS1dWK3Fsc21nWDdyRy9FTHdn?=
 =?utf-8?B?K1JzWGtkamgzc2RqWlRKM2hmVmxYcHpUNUVjS241dFZVWVdyM1VkR2I5UVBh?=
 =?utf-8?B?KytMeXEzZVFOWkJSU01uTkZ4V3VKeFdGUUhCMGYxczdXOGFCejVlT2JhUW0v?=
 =?utf-8?B?djVSLzNNUzN5NVZSODhhS0V0SS9oTTUySWlCTU8rUDNKT3RGbmZ6MEJBMXkv?=
 =?utf-8?B?UnljRTN3b2xYMDZ2d2lBMWlGaU9OZGZCaXU0aXB4VWJLRGZ2TDRmREdxaHVW?=
 =?utf-8?B?ak9SK2RQdjc2RDZUbUc1UlQxSC9MOTVjRjd0MEtoTHJiTGZRcHhQWmRnZjFL?=
 =?utf-8?B?dkM0NEJzM3pEWlJOQnF1bzlTd0MvdkVMakFYUzUwbWswYU5LUEFmU2JFSEg4?=
 =?utf-8?B?cDhMemhVTkloUTRYd050MnRNVHJtTlVVT0F4VUIrTkRndWNGY1lneUY4VEVD?=
 =?utf-8?B?ZVp1UkNqL0luVlloTmVkQU84ZDNBajhaWk01d09DYkZSRkRJQm1JbFdLeUh5?=
 =?utf-8?B?Y1VzaEUxODJ2Z29vRXBBV2lPdVc3NjM4OWhEUkpBdlVWZU95YVB1d0M4bHBJ?=
 =?utf-8?B?dDgzWDcyOHlQTVA4SFNCYTAzemc5NXBsRmpKay9pVktxZVc3aDVVV2F5NW8w?=
 =?utf-8?B?NnZ6bTNtRmNEWDErSHlZNnQ2REY1emJ1YWRldkRvT2V4RUFNVDhhZlA3cE9y?=
 =?utf-8?B?bi8ySk9Ic2tmL2wwa2tOZzZna1NIOC9Sd0ZOYTh1Y0NqVEplend0VjhWWE4z?=
 =?utf-8?B?RXhXWk5KeEJ2VUZ0NUxTVWo0cE1hcDVPZXcwYTMwRDIzRGgwak90RjZhZUd3?=
 =?utf-8?B?czZTTkJtWHc2VUVTL2Z0cTJiM1p4RXBrbnJaZXl4TG9TdmxWSmpRSmc5WGkw?=
 =?utf-8?B?NWZWM1lOY0gxMDFpSzFQWVNLSkFTUVBLZ0M3Z2pwaTkxTG1VcWFVazRKQjNr?=
 =?utf-8?B?aEN5VkI1b3Vndjc1YVpPOXgxZnlZcmtQVDBwcXFKR3RxMFZHWUtrVzdFWEhD?=
 =?utf-8?B?NnVCSlVXckFsTVZYYzJQRGNxSm4zUzYvb040OHVwU2xTQXQ2eVk3THdPYUs5?=
 =?utf-8?B?ZWxoWXh5M1hCT3MxdTRrREdhbkpDRE5UTlJkaTZZNzY3TlRtelhIUVhnVWNZ?=
 =?utf-8?B?bklza2xUWDJrNmQ2aEJUT0lGK05ubUhGQXg4eUE1TDlVWnVlYzE4eVZTcTRx?=
 =?utf-8?B?NWliRE52cmgrdE05QmFMaGFYUzVHNlpKNFgwNkhxdUFoV0ViY1VYVDZaWk5y?=
 =?utf-8?B?ZGFwdTU1ZzFMaFNhTXdKQldZMjBkcC9aelFYTjZoNUlBeDE3azE1SHo5cnVG?=
 =?utf-8?B?ZjlMZVllSXU5N2RDcHBDQ05ucExIRVVJNlM4U0J0OElSOWVqbkxIUW10WTBL?=
 =?utf-8?B?UExiMFRheFVmZVMxRWlDNTdpcGtGeUhjV1RhY3krVytlY3pyQnJSVTdWUlZ3?=
 =?utf-8?B?My9KUGhGeXJNNDJlcHdoWTZJOG1UOTdad3QrZ1U0VHg1Nk45OGhhenhkN3hl?=
 =?utf-8?B?UXAxZVNHTWcwczNUSGZJNWtWQWFacVNaVWhQQmorM281VzIvV3BtbUtQczYw?=
 =?utf-8?B?eXNoUnR3RmFzSTdldHMvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e4e70f-689f-49bb-042f-08d90058ad3b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 21:51:51.3980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFMWj7FR5OB8FMYbv39IzssinUJ3voa8HMEDH0tX6TWBzrbsAKASXECSRrrGIyphlKEBwTPbLebhDsQFBXr2fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2546
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

QW0gMjAyMS0wNC0xNSB1bSA1OjQzIHAubS4gc2NocmllYiBQaGlsaXAgWWFuZzoKPiBITU0gbWln
cmF0aW9uIGFsbG9jIHNpemVvZihzdHJ1Y3QgcGFnZSkgb24gc3lzdGVtIG1lbW9yeSBmb3IgZWFj
aCBWUkFNCj4gcGFnZSwgaXQgaXMgMUdCIHN5c3RlbSBtZW1vcnkgcmVzZXJ2ZWQgZm9yIDY0R0Ig
VlJBTS4gVG8gYXZvaWQKPiBhcHBsaWNhdGlvbiBPT00sIGluY3JlYXNlIHN5c3RlbSBtZW1vcnkg
dXNlZCBzaXplIGJhc2VkIG9uIFZSQU0gc2l6ZSBvZgo+IGFsbCBHUFVzLCB0aGVuIGFwcGxpY2F0
aW9uIGFsbG9jIG1lbW9yeSB3aWxsIGZhaWwgaWYgc3lzdGVtIG1lbW9yeSB1c2FnZQo+IHJlYWNo
IHRoZSBsaW1pdC4KPgo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcCBZYW5nIDxQaGlsaXAuWWFuZ0Bh
bWQuY29tPgo+IFJldmlld2VkLWJ5OiBPYWsgWmVuZyA8T2FrLlplbmdAYW1kLmNvbT4KClJldmll
d2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KClRoYW5rcy4g
SSdsbCBhcHBseSB0aGlzIHRvIGFtZC1zdGFnaW5nLWRybS1uZXh0IHRvZ2V0aGVyIHdpdGggdGhl
IGJpZwpITU0gcGF0Y2ggc2VyaWVzLgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+IC0tLQo+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmggICAgICAgfCAxICsKPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIHwgNSArKysrKwo+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5jICAgICAgICAgfCA4ICsr
KysrKysrCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuaCBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuaAo+IGluZGV4IDAyNWU4YmFkZThjOC4u
MmNiN2Y4YzMwYjlmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hbWRrZmQuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmQuaAo+IEBAIC0yNzIsNiArMjcyLDcgQEAgdm9pZCBhbWRncHVfYW1ka2ZkX2dwdXZtX2lu
aXRfbWVtX2xpbWl0cyh2b2lkKTsKPiAgdm9pZCBhbWRncHVfYW1ka2ZkX2dwdXZtX2Rlc3Ryb3lf
Y2Ioc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gIAkJCQlzdHJ1Y3QgYW1kZ3B1X3ZtICp2
bSk7Cj4gIHZvaWQgYW1kZ3B1X2FtZGtmZF91bnJlc2VydmVfbWVtb3J5X2xpbWl0KHN0cnVjdCBh
bWRncHVfYm8gKmJvKTsKPiArdm9pZCBhbWRncHVfYW1ka2ZkX3Jlc2VydmVfc3lzdGVtX21lbSh1
aW50NjRfdCBzaXplKTsKPiAgI2Vsc2UKPiAgc3RhdGljIGlubGluZQo+ICB2b2lkIGFtZGdwdV9h
bWRrZmRfZ3B1dm1faW5pdF9tZW1fbGltaXRzKHZvaWQpCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+IGluZGV4IGQ3MGEyMWVhNTc2ZC4u
NmVhMTAzOWIwOGEwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hbWRrZmRfZ3B1dm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hbWRrZmRfZ3B1dm0uYwo+IEBAIC0xMDUsNiArMTA1LDExIEBAIHZvaWQgYW1kZ3B1X2Ft
ZGtmZF9ncHV2bV9pbml0X21lbV9saW1pdHModm9pZCkKPiAgCQkoa2ZkX21lbV9saW1pdC5tYXhf
dHRtX21lbV9saW1pdCA+PiAyMCkpOwo+ICB9Cj4gIAo+ICt2b2lkIGFtZGdwdV9hbWRrZmRfcmVz
ZXJ2ZV9zeXN0ZW1fbWVtKHVpbnQ2NF90IHNpemUpCj4gK3sKPiArCWtmZF9tZW1fbGltaXQuc3lz
dGVtX21lbV91c2VkICs9IHNpemU7Cj4gK30KPiArCj4gIC8qIEVzdGltYXRlIHBhZ2UgdGFibGUg
c2l6ZSBuZWVkZWQgdG8gcmVwcmVzZW50IGEgZ2l2ZW4gbWVtb3J5IHNpemUKPiAgICoKPiAgICog
V2l0aCA0S0IgcGFnZXMsIHdlIG5lZWQgb25lIDggYnl0ZSBQVEUgZm9yIGVhY2ggNEtCIG9mIG1l
bW9yeQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0
ZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYwo+IGluZGV4IDdk
ODY1OTUxNzQ0Ny4uMTM3M2NlOWFmODkwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfbWlncmF0ZS5jCj4gQEAgLTg3Niw2ICs4NzYsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IGRldl9wYWdlbWFwX29wcyBzdm1fbWlncmF0ZV9wZ21hcF9vcHMgPSB7Cj4gIAkubWlncmF0ZV90
b19yYW0JCT0gc3ZtX21pZ3JhdGVfdG9fcmFtLAo+ICB9Owo+ICAKPiArLyogRWFjaCBWUkFNIHBh
Z2UgdXNlcyBzaXplb2Yoc3RydWN0IHBhZ2UpIG9uIHN5c3RlbSBtZW1vcnkgKi8KPiArI2RlZmlu
ZSBTVk1fSE1NX1BBR0VfU1RSVUNUX1NJWkUoc2l6ZSkgKChzaXplKS9QQUdFX1NJWkUgKiBzaXpl
b2Yoc3RydWN0IHBhZ2UpKQo+ICsKPiAgaW50IHN2bV9taWdyYXRlX2luaXQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCj4gIHsKPiAgCXN0cnVjdCBrZmRfZGV2ICprZmRkZXYgPSBhZGV2LT5r
ZmQuZGV2Owo+IEBAIC05MTIsNiArOTE1LDExIEBAIGludCBzdm1fbWlncmF0ZV9pbml0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAJCXJldHVybiBQVFJfRVJSKHIpOwo+ICAJfQo+ICAK
PiArCXByX2RlYnVnKCJyZXNlcnZlICVsZE1CIHN5c3RlbSBtZW1vcnkgZm9yIFZSQU0gcGFnZXMg
c3RydWN0XG4iLAo+ICsJCSBTVk1fSE1NX1BBR0VfU1RSVUNUX1NJWkUoc2l6ZSkgPj4gMjApOwo+
ICsKPiArCWFtZGdwdV9hbWRrZmRfcmVzZXJ2ZV9zeXN0ZW1fbWVtKFNWTV9ITU1fUEFHRV9TVFJV
Q1RfU0laRShzaXplKSk7Cj4gKwo+ICAJcHJfaW5mbygiSE1NIHJlZ2lzdGVyZWQgJWxkTUIgZGV2
aWNlIG1lbW9yeVxuIiwgc2l6ZSA+PiAyMCk7Cj4gIAo+ICAJcmV0dXJuIDA7Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
