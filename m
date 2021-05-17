Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D856EC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 17:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959B96109E
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 17:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959B96109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 896DF6EA1E;
	Mon, 17 May 2021 17:43:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4356EA1E
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 17:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pi4++knZCCT6eAc6lPbobkVBqerC4XVWfe5Ht5vLIrREslgshcMGsalVM9+mhNSxatqClK9gbVdH/BWpRGayevSeljACYRMWonsxq7rWPTr1ixW7kn6BgKj/rVunNYC/P6RVbpE3jsmP52btUf1nyrzyPoEYi3hm3tq8e4T9ioNIag3UqBy95DV5INUi2UcautbkpZNqEZPwp/ZddLLcytAR4jYPgz5nn89jPahrrwhXe2GpRJMIefbWPx7hRwMlXdYD3iAZZE7vj2mJ2neN+s0f86qNAlFmfFXzV4Rl5G2pWVN6WNTtE3WVyEreuTNhNaIhD3Okj5s+mzEpcFqXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqE1hT++jcazOrxm9ksd4QmbYYB8L9dN3WvZh/fUMFQ=;
 b=fMHmuy5WjVAs9ej/uSZsf8BovGR5DIz6MZjYcm3qnzAYubDOGz7hYVDTPCVYMmfpiifX5DY5jrPpbqsgDQDLpLVrcTK0kyRsCfXtxD1slRZZUZNyuocRRXiNLBd+IccYjAzOwtuVO5G4XHL17b9QjB58qB9SvrdYK0cXdPyOEq/psILGmPMg0RdKoAB1vitp+8zk/RnLywAaZQavGwtJW+egmuHSgpkv+J8rSwqZuIvBLaxlZvG9k4Wl/5wnKxR16sSURO1hrBJLMfw3fp4+7gTg6yE05WmTOneMmhvTu9P989Rr84VNSWyo4WobOuR/P4z5ArvElXejo8u5YtVPTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqE1hT++jcazOrxm9ksd4QmbYYB8L9dN3WvZh/fUMFQ=;
 b=v0ea6CGCmmWdUrP6yEx2Yl7+3b0cqQmWd+y5tbmWq6dNfWkGUedV9F5SAt37M2SYgH5aUnOLb5wsxBGElVt/iCvwVr37XL1tNC24pRgF0EipQPtRyJ4D4DCejKLdqPdrI7nzf2ICE4ebXO2nH+1XJCWFgceH9EtIS9HUMRHdSv0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM6PR12MB3948.namprd12.prod.outlook.com (2603:10b6:5:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 17:43:04 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd%5]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 17:43:04 +0000
Subject: Re: [PATCH v2 1/2] drm/amdgpu: enhance amdgpu_vcn_suspend
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1621263428-8631-1-git-send-email-James.Zhu@amd.com>
 <1621266752-11959-1-git-send-email-James.Zhu@amd.com>
 <85106a30-90ee-6e04-65cd-90f8e290c3d2@amd.com>
 <15dbc004-f5d6-6722-d7bf-40ade20d2cee@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <3c6a0bf3-b4b4-0a93-573e-fd9ae02f16a8@amd.com>
Date: Mon, 17 May 2021 13:43:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <15dbc004-f5d6-6722-d7bf-40ade20d2cee@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2088:19:1758:bad7:3f3b:2001]
X-ClientProxiedBy: YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::34) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2088:19:1758:bad7:3f3b:2001]
 (2607:9880:2088:19:1758:bad7:3f3b:2001) by
 YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Mon, 17 May 2021 17:43:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76b4581c-50c4-485c-f621-08d9195b3907
X-MS-TrafficTypeDiagnostic: DM6PR12MB3948:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3948ECB0585CA055207DE941E52D9@DM6PR12MB3948.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2ZogHgpdKQxvGcydO91h736OlXlSL1C3fIoeeuoOkorY1K4sXfr3k5ZCFa/1x2iqByx61Ms0Ea2ECDzfl/ipRee/091QlK9Y1BXstsO1CxaDMIUerellc4CnaI9lV/Sr5scuuMfvdgt0vO29wMU3cN/ymiLx+STV3A/cKa1zjWp4pqmi7Xbpb4Qy6MT2qo/XjyQ0/3Yp58FXDW7jA8cysU+/Sa3qGRW4brof8IHa+3KrEC9E/TxlL/DcQs/8bjIwSZG6QjXN2OjO14GKXZXWkuxq6VyEbZ6fqMvSdS23n8L7iX5M0PGkCof3jmeSO9yaKhh2mQSOganQ43uAFLZZ8t5vFNwGWAFxyg2mtwFYUful4lPqP4jlj/Bic5dUMf2ov/rtI5heB3dYGY52hi6rEqDk2kYvoYy8NtVfBZn1jG1EDlgdthi+roiM40O1A6Mlcgz7JDcCVKb66ui9cNggs4e1yQtMUseFbxMigr24pdBDUdavietSXc96d/KMosTRSZ9xQ3U0AAcYJ56i5+SGW+i6rg9yvldt/6hi0d7LsO2YNbm2nnH7soIvXfdzEO0oE15O0dKF/ez+CJIG8LQOWD+EQwR9bDYFeZ6mWQr9ie3N4heELQ+PPR+c6IPsEK1i7TG+5eIBvzOJSc8mAw2cXXm9NQm3C+IOB+Am/xSgGE9Tx9Mc/cZSoHzNiGKOSkK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(66556008)(66476007)(66946007)(6486002)(8936002)(8676002)(31686004)(5660300002)(31696002)(86362001)(53546011)(2616005)(44832011)(38100700002)(2906002)(16526019)(478600001)(186003)(110136005)(316002)(83380400001)(36756003)(52116002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TVdKUFRxOVNYV3lYY1pkTEQ5eWx6b0M2cjlTTUxjWEtrUFJRMWMwZG54dm9w?=
 =?utf-8?B?TzgyQTU4VzNDd3oybkpQNlJuczFaUGtUOW9MRnlEekdkQWRiUDF4YWI0by9K?=
 =?utf-8?B?V2UvUFhNVzFMRGRBL0YwSWFzdEVEblFGMUZmTERMNEFQRHZDVWRJdXZ0d1hz?=
 =?utf-8?B?SmNUbnhNNGgydlpnU1prMWs4eFBYVnBKanM1cHJZa3JLT2VrSFdpTi9pQzU5?=
 =?utf-8?B?TDhWbHBVSCtDVi8yK3NpOG5XMnJuZFlKVGZOUHFEM2RGTmdzT2NCSkZPK3Ba?=
 =?utf-8?B?YUpaRzFxMTVtVkhzNE90UHdKUTExL3lITXN2ZDhOWGEvaVNnYWEwUExMdWcw?=
 =?utf-8?B?OG5KcFZqNFFud1lRQ0E0bmlvYktWWkl0SGtIQTVTSFprVTJpVXBINXMxZTRq?=
 =?utf-8?B?Wm5oSHBvYklZWW0vd21oL0dSKzNDRDZsWjluejMrNEhNVWIyZm9UTFA5c0x0?=
 =?utf-8?B?QlpyL0FYQzlzQjAyY2ZnYzZOZkRtakNzUnJmUHZHN1d5NCthbTVoZnVValJ0?=
 =?utf-8?B?NE9iZWRFaTdJazlZSkJ1MW5aVTM2M2E3eEZiNVZKL2xJR00wTEJ1WlRqYkxx?=
 =?utf-8?B?WGpBTXdHUTJKY0NpN3FlL3kxa1FieEV6QVBrVkFwLythOW9UR2FsVi9NYmNQ?=
 =?utf-8?B?eE42OHFoV0hKZFdIUlhVUWw1c29LcjlRNjNqS3I3TDJuemJhdk0rdjh4SDVl?=
 =?utf-8?B?aGI5SjExWlZRYW1WRVlXQlMwUEFXeGZ0SnFYdkczZ2NvdDlDZFVsejg4SktM?=
 =?utf-8?B?Szl5WFlxOUFOUGF3cFVHcEk3MHQ0MXd4M3FpWkpXRFl6OXp5d1ViSkRMdW5S?=
 =?utf-8?B?UEdWUmtISzlFZmVCVUE0Y2FzZTBxVkpMNElKR0RLVXFPUXRYZllFOVUrbmNp?=
 =?utf-8?B?SytDVWg5QTNKQmphVGFEeHk0ZURUeE5QVzB6RDJRcVAvQ2MzWFVzZ25TOW15?=
 =?utf-8?B?WCtRbXViSWh6MjlQVUk4bGFQRjlrelV2NVpVL3hzQUFIWGJTNGFiNUQ5N0lW?=
 =?utf-8?B?UTBzTjRuem1GbjBla0RUUllPZmdzVWVoTmZsN3VzZExXbWN1c0tXWE1MeWt6?=
 =?utf-8?B?K1ZYVXl2Q1RzSjNmZGt0N0lEcUQvYktPTWxPUjcvaDViYldYNDBWajE1OGtN?=
 =?utf-8?B?aUVLSUtzVSsvZ1dtTjFQa2U4MGR0Z0p4MVdhVW9wUlF3SnhBSFRaOVZMVGJL?=
 =?utf-8?B?c0cyc2h0aHVmZHJ2V2FoMkFoakxuNHQraTZ5ak5lQzBNU09BV05TVTR1Rmkv?=
 =?utf-8?B?UXNIdzFIZjUrZmhUQk1wUDZVTUpMVmpMNStvSEZzRUQ0QVcvYnJRdmExczdV?=
 =?utf-8?B?S2NoZEVuT2YyS0VZTzU4bStyVVROcFRYWUlkSmUrVG5ZVTlSQU5qWVFySElO?=
 =?utf-8?B?WlJ2KzI1L1J5YS9vc3NRWWpmbmYrdzJPRFBVWDVSOWtZam9EMER1MmRXRUlj?=
 =?utf-8?B?dHdtY3JrUGg1dWJvdlRabjFKUGNKdEtNT212RjhNNDdwK3BHcnBjSUhseGtG?=
 =?utf-8?B?ckhiamtKcTAzeHBmajY2SS9ydmR0SVRFOUFrbHdHeEJCVlYxZm9nVHkxblhG?=
 =?utf-8?B?WDZFN3F4K3ZrWlo1VGFUVkZ3V2NRZlNJb21ISFFzblpHZ09UUllFeW9VMHpD?=
 =?utf-8?B?WVJiU0dsSGZGYzU1TG5RMWcvUmt2RUdka0ZNdEx4by9FZW1VbUs3dWVWbGlq?=
 =?utf-8?B?NW9vQzBkR2t1eDRpM1pNK291cVZvREFsRlB1Q0N5TUhpZ0VLY0t0RWxXYVQ2?=
 =?utf-8?B?bUZCbkRkYUJpbS9XemYyTmdVUHVGWklhRm8xR0NaelZRcEJSMlhoS1FyWTFR?=
 =?utf-8?B?YW8wRUt6OHZlU1ExTUVXVDlFRzQyQTBlaHRXajd2TisvMEVLeDZkbTZidDcr?=
 =?utf-8?Q?hz9lhBvn0HNRl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b4581c-50c4-485c-f621-08d9195b3907
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 17:43:04.0576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuszPi2eGo82ybIvzQcD2CQKHPgbfWZhtNQsMbNlLwz80SWwsajh9pvcyrsUszgt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3948
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

Ck9uIDIwMjEtMDUtMTcgMTI6NTQgcC5tLiwgSmFtZXMgWmh1IHdyb3RlOgo+IEkgYW0gd29uZGVy
aW5nIGlmIHRoZXJlIGFyZSBzdGlsbCBzb21lIGpvYnMga2VwdCBpbiB0aGUgcXVldWUsIGl0IGlz
IAo+IGx1Y2t5IHRvIGNoZWNrCgpZZXMgaXQncyBwb3NzaWJsZSwgaW4gdGhpcyBjYXNlIGRlbGF5
ZWQgaGFuZGxlciBpcyBzZXQsIHNvIGNhbmNlbGxpbmcgCm9uY2UgaXMgZW5vdWdoLgoKCj4KPiBV
VkRfUE9XRVJfU1RBVFVTIGRvbmUsIGJ1dCBhZnRlciwgZncgc3RhcnQgYSBuZXcgam9iIHRoYXQg
bGlzdCBpbiB0aGUgCj4gcXVldWUuCj4KPiBUbyBoYW5kbGUgdGhpcyBzaXR1YXRpb24gcGVyZmVj
dGx5LCB3ZSBuZWVkIGFkZCBtZWNoYW5pc20gdG8gc3VzcGVuZCAKPiBmdyBmaXJzdC4KCkkgdGhp
bmsgdGhhdCBzaG91bGQgYmUgaGFuZGxlZCBieSB0aGUgc2VxdWVuY2UgZnJvbSAKdmNuX3YzXzBf
c3RvcF9kcGdfbW9kZSgpLgoKCj4KPiBBbm90aGVyIGNhc2UsIGlmIGl0IGlzIHVubHVja3ksIHRo
YXTCoCB2Y24gZncgaHVuZyBhdCB0aGF0IHRpbWUsIAo+IFVWRF9QT1dFUl9TVEFUVVMKPgo+IGFs
d2F5cyBrZWVwcyBidXN5LsKgwqAgdGhlbiBpdCBuZWVkcyBmb3JjZSBwb3dlcmluZyBnYXRlIHRo
ZSB2Y24gaHcgCj4gYWZ0ZXIgY2VydGFpbiB0aW1lIHdhaXRpbmcuCgpZZXAsIHdlIHN0aWxsIG5l
ZWQgdG8gZ2F0ZSBWQ04gcG93ZXIgYWZ0ZXIgY2VydGFpbiB0aW1lb3V0LgoKClJlZ2FyZHMsCgpM
ZW8KCgoKPgo+IEJlc3QgUmVnYXJkcyEKPgo+IEphbWVzCj4KPiBPbiAyMDIxLTA1LTE3IDEyOjM0
IHAubS4sIExlbyBMaXUgd3JvdGU6Cj4+Cj4+IE9uIDIwMjEtMDUtMTcgMTE6NTIgYS5tLiwgSmFt
ZXMgWmh1IHdyb3RlOgo+Pj4gRHVyaW5nIHZjbiBzdXNwZW5kcywgc3RvcCByaW5nIGNvbnRpbnVl
IHRvIHJlY2VpdmUgbmV3IHJlcXVlc3RzLAo+Pj4gYW5kIHRyeSB0byB3YWl0IGZvciBhbGwgdmNu
IGpvYnMgdG8gZmluaXNoIGdyYWNlZnVsbHkuCj4+Pgo+Pj4gdjI6IEZvcmNlZCBwb3dlcmluZyBn
YXRlIHZjbiBoYXJkd2FyZSBhZnRlciBmZXcgd2FpbnRpbmcgcmV0cnkuCj4+Pgo+Pj4gU2lnbmVk
LW9mZi1ieTogSmFtZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jIHwgMjIgKysrKysrKysrKysrKysr
KysrKysrLQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Zjbi5jIAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMK
Pj4+IGluZGV4IDIwMTY0NTkuLjlmM2E2ZTcgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92Y24uYwo+Pj4gQEAgLTI3NSw5ICsyNzUsMjkgQEAgaW50IGFtZGdwdV92
Y25fc3VzcGVuZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4+IMKgIHsKPj4+IMKgwqDC
oMKgwqAgdW5zaWduZWQgc2l6ZTsKPj4+IMKgwqDCoMKgwqAgdm9pZCAqcHRyOwo+Pj4gK8KgwqDC
oCBpbnQgcmV0cnlfbWF4ID0gNjsKPj4+IMKgwqDCoMKgwqAgaW50IGk7Cj4+PiDCoCAtwqDCoMKg
IGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+dmNuLmlkbGVfd29yayk7Cj4+PiArwqDC
oMKgIGZvciAoaSA9IDA7IGkgPCBhZGV2LT52Y24ubnVtX3Zjbl9pbnN0OyArK2kpIHsKPj4+ICvC
oMKgwqDCoMKgwqDCoCBpZiAoYWRldi0+dmNuLmhhcnZlc3RfY29uZmlnICYgKDEgPDwgaSkpCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBy
aW5nID0gJmFkZXYtPnZjbi5pbnN0W2ldLnJpbmdfZGVjOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJp
bmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKgwqAgZm9yIChq
ID0gMDsgaiA8IGFkZXYtPnZjbi5udW1fZW5jX3JpbmdzOyArK2opIHsKPj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJpbmcgPSAmYWRldi0+dmNuLmluc3RbaV0ucmluZ19lbmNbal07Cj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByaW5nLT5zY2hlZC5yZWFkeSA9IGZhbHNlOwo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIH0KPj4+ICvCoMKgwqAgfQo+Pj4gKwo+Pj4gK8KgwqDCoCB3aGlsZSAocmV0
cnlfbWF4LS0gJiYgCj4+PiBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPnZjbi5pZGxl
X3dvcmspKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIG1kZWxheSg1KTsKPj4KPj4gSSB0aGluayBpdCdz
IHBvc3NpYmxlIHRvIGhhdmUgb25lIHBlbmRpbmcgam9iIHVucHJvY2Vzc2VkIHdpdGggVkNOIAo+
PiB3aGVuIHN1c3BlbmQgc2VxdWVuY2UgZ2V0dGluZyBoZXJlLCBidXQgaXQgc2hvdWxkbid0IGJl
IG1vcmUgdGhhbiAKPj4gb25lLCBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMgcHJvYmFibHkgcmV0
dXJuIGZhbHNlIGFmdGVyIHRoZSBmaXJzdCAKPj4gdGltZSwgc28gY2FsbGluZyBjYW5jZWxfZGVs
YXllZF93b3JrX3N5bmMgb25jZSBzaG91bGQgYmUgZW5vdWdoIGhlcmUuIAo+PiB3ZSBwcm9iYWJs
eSBuZWVkIHRvIHdhaXQgbG9uZ2VyIGZyb206Cj4+Cj4+IFNPQzE1X1dBSVRfT05fUlJFRyhWQ04s
IGluc3RfaWR4LCBtbVVWRF9QT1dFUl9TVEFUVVMsIDEsCj4+IMKgwqDCoCDCoMKgwqAgVVZEX1BP
V0VSX1NUQVRVU19fVVZEX1BPV0VSX1NUQVRVU19NQVNLKTsKPj4KPj4gdG8gbWFrZSBzdXJlIHRo
ZSB1bnByb2Nlc3NlZCBqb2IgZ2V0IGRvbmUuCj4+Cj4+Cj4+IFJlZ2FyZHMsCj4+Cj4+IExlbwo+
Pgo+Pgo+Pj4gK8KgwqDCoCBpZiAoIXJldHJ5X21heCAmJiAhYW1kZ3B1X3NyaW92X3ZmKGFkZXYp
KSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKFJSRUczMl9TT0MxNShWQ04sIGksIG1tVVZEX1NU
QVRVUykpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl93YXJuKGFkZXYtPmRldiwg
IkZvcmNlZCBwb3dlcmluZyBnYXRlIHZjbiBoYXJkd2FyZSEiKTsKPj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHZjbl92M18wX3NldF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LCBBTURfUEdfU1RB
VEVfR0FURSk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgfQo+Pj4gK8KgwqDCoCB9Cj4+PiDCoCDCoMKg
wqDCoMKgIGZvciAoaSA9IDA7IGkgPCBhZGV2LT52Y24ubnVtX3Zjbl9pbnN0OyArK2kpIHsKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoYWRldi0+dmNuLmhhcnZlc3RfY29uZmlnICYgKDEgPDwg
aSkpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
