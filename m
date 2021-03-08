Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9845AC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 14:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50CDA65020
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 14:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CDA65020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E26A89DBF;
	Mon,  8 Mar 2021 14:06:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C75D689DBF
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 14:06:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8wLYTGmqmM47xqfiD4nv72wMlvlw2uhsgObv/B3maP0PLzO+o52QWX8FD7u6defNOu5aa3evK2Wa5eIFc8wCHFeYQsLl9HBmPUflYDaupy2u8iRceYs7b6UBZtiW4EhFC3y6QwWIpxwb89ci8NrOsAmjAuiFGXf+HF6WuzxO5FK7q1EyD9gKidT22BScsizbaXYwoDxd6MSR1XHSKVGbpj084Hh+iaGCWsSFRwcnvA9355Wl12AqnI3pY7iKo+HVlqPOjolOTalru8UAeHNCRFWKH3xgGssnZkX/v567rJdH4l+BbXP0u/em56Dqdi2bwp/lfFoDJcifm9w+0Hnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcX6wGk37zch6WsRpcxJxay2KKIitYYsinAS9H/RJqA=;
 b=KSPly6Vcac+RKXrmMkhi71vx38OSzAW5uXUi9A/AD3FxrMm7Rfn2fFcAUD2EP4mNzf/nHe7l7X1wKwT4Tj8CM0dqiMamzwB676QlPmypVW4tJPW7Cr4Tmty7mAR3mpy0F7MhdLZiGY03TabyVkFBJqQQDxua4i916ieV8EhMSmic4XIa2ndXvS7ndkRBT8iug4dtHF6eDGX+MtrLpOkEmDmnfU8rU6sZoKJ56yBgMpxVLky50ANeO95le5iZhcl3YcRvBUw+YIf4jTcRM6z9FPQwApxmGtW2zXXgwWrn6EhSEdKJAcpa+mkGm7NuPBXhNBM+u8YdC5tdObfyktZPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcX6wGk37zch6WsRpcxJxay2KKIitYYsinAS9H/RJqA=;
 b=BQbjDS5ETZdjS+4cphdzFxQm0PtNf1lPDEKvFimZMwI6k1lmsnNtMbBi4TynHyjObAxWl90MMqRxm1chonI9S7cZ9C42UUoI7ePQz8idrhJ9qTFVA0xXnjucpEASxOfWGfXfKh0w6dE2ljPBSTvzzCktood/7QVMe560VzY87VU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1864.namprd12.prod.outlook.com (2603:10b6:903:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 14:06:12 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 14:06:12 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu: use amdgpu_bo_create_user() for gem object
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Nirmoy Das <nirmoy.das@amd.com>
References: <20210305143532.5936-1-nirmoy.das@amd.com>
 <20210305143532.5936-3-nirmoy.das@amd.com>
 <0d083697-b194-99ac-71b5-866d2974a6a8@gmail.com>
 <ede649d0-2e9a-1826-28c8-e2d348887d1a@amd.com>
 <a3c7d386-8e64-b579-4f20-03634cfe4df7@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <58601878-db7d-a738-8fc1-54b3cbc7b90a@amd.com>
Date: Mon, 8 Mar 2021 15:06:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <a3c7d386-8e64-b579-4f20-03634cfe4df7@amd.com>
Content-Language: en-US
X-Originating-IP: [93.229.42.112]
X-ClientProxiedBy: AM0PR06CA0116.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::21) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (93.229.42.112) by
 AM0PR06CA0116.eurprd06.prod.outlook.com (2603:10a6:208:ab::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 14:06:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 07b792d8-a5d1-48b9-78cd-08d8e23b547f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1864:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1864495698CC066ECD54FE658B939@CY4PR12MB1864.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8Y3a59htDuMRKYil2iYrON3oEaiLAi+iSnWVt6umob05/MHQokcqkNkBT91m1J/PGax4fa/Q6Z2y3pYY7WFJ0iXKaO9gNMIG8SCftMNGo+K/LsmcycrTYB3BjkoLeix4qAuqsFmVwGJZoevl3ngwNxoIEGNkjTipkDpZT1jvzOVc+WiQhXTQxVurjLPoQ0nq9Vno+ySbkM0f4nc73vOeRbv/g+hk5sFtx+aylKeZu+Yfy1QAU9MVfQdZW7463gS/EtMRKq+8eFK75KNqClQCJBIsxgFi72c1N5/qVGBoGs0AMVHwzVyZTO61AWTvgBlQbm+vDrikGOq62OOqErrbnm6Zf0ooZgxHBAgY8kfv3IX261QR44JvYtrgttA+/EG/Ckr+mB5HF8DV3I4LVICiiYG9V9WnTEpu7VYtXrCKwrOzMrZHvTNsU9H/L8Y15u5p7x5mW7LHAO2P9ZoFQ/+epERIEMcNmn/bjcrf4881CECyFDRJXXnAKwvU+q6lR2NCs1K1v1bNRlJaQEZvDGPUjA20jR+nMPJO6LenuQKQ4ON25AOOwAOTR/WZLps1hZRNX7dKf6Ld6NpuhrfBNHGNr9TMEAUXic00jO4+Je6xtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(110136005)(16526019)(5660300002)(52116002)(6636002)(31686004)(26005)(66574015)(6666004)(4326008)(83380400001)(8676002)(2616005)(6486002)(8936002)(316002)(53546011)(956004)(16576012)(2906002)(31696002)(66556008)(66476007)(66946007)(478600001)(36756003)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?amhCNG52TVRDSGQ3WlBXV0JqZFp5NmJubDZOeEFZdWxNRkk4VGU3WmtBZTlU?=
 =?utf-8?B?Si9Oblc3UUFia0Yxd3g4S0JXeW14QXpoc2lzUGJyaUhwRjlTVDVoYnE5b1BZ?=
 =?utf-8?B?UUJsSWc0QUFLQ0RtWTlVRStSV0NnaTlndXNpcldBM01yaWVrWElmWitndmtt?=
 =?utf-8?B?WHlQZ0VXMmNtbEZPNG9GU3o1YXltNWpoUUpSUTE1dGZ2WnRkazU2RFZ2Z3RM?=
 =?utf-8?B?MG1ZQUhOdzdpWFFRdUJxeWpQS1g3RWFHd2VQSGpaNGdXbDAxbSs0Z2sycUNJ?=
 =?utf-8?B?bCswamVwWnZiOE0wcmJiN2NtSGFEZExReWJCZWJ4NnJVVWlmdldDZ1NlSmtp?=
 =?utf-8?B?Ym01cmhlZ3NoREx1WkpudldDWHU5bXJ1elNLL1hUWCs5ayt4U1dvcDV2cndE?=
 =?utf-8?B?OS9CdHBjVnpTWEJLNjZEeHFFYVYyQ1NIcmE1VU80UllobTRvcWR1bmdQSnhD?=
 =?utf-8?B?M2VBcFhFU25xbDdIdituaG9tbXFDeHh4V1pPU1JSRHJLTGpCZEJIMFZkbkdS?=
 =?utf-8?B?L0dwa2FLQ1N3T2lZRmRzSmdObldDTGtwZWlya2RLNXIyWE9oTjVIVEFhL1c3?=
 =?utf-8?B?RDVXalBaWGI5b3czVGFjNTVod0FBSXVCMnUrUk51MzIwcVVqaVJ0Y1pwUlF4?=
 =?utf-8?B?ekpXbzlsRWtYR2wrT1pyWUJOTVZvWVY3L3JmK3pLYWd0QTREd0QwUlVqd0J1?=
 =?utf-8?B?WVJYYXZUd094SHIvakdVMm5Ed2pMVzJBNGJ6M0RXZzc0RTlvNHAycUFVd0dy?=
 =?utf-8?B?OHBRbUFSSE9PNzVFYVg5aUd1YnRDWml1a3hqb1d2YlBZajc4NjUrcVV4bC9Q?=
 =?utf-8?B?T01WTXpjeXByMDJZV3BwU3FXNXJGUlNPYmpReCswOGc0NDl4OVRyRmpUc3pV?=
 =?utf-8?B?NURlbnRiVWlHTExNT3JCN2loZzE0S2VvMStObE5GNlV3K0NDWU1JZWlDNzVy?=
 =?utf-8?B?WHVSVGJlUzN3OVB6cENvUlo1ZXN6eTJxOU9GWENlZG5CQWl3OVZwb1lBMTgv?=
 =?utf-8?B?UkM4V2pBZHdXRFZ1ZlZIenNCWTMvdzN2UHg2OXhWaDB6RVhKU3NqM1N5aElj?=
 =?utf-8?B?K0xpZURTYm5vVlpzOW02SHp6eDBDU2lPSmVEUUlSR29yVWVHbHFpbUhvWHhk?=
 =?utf-8?B?ZHliWW0wc2FBemVmUjg0cEZmS0NRTXFkQlRremdOb3V3dytqVXlEMnZLdTFG?=
 =?utf-8?B?ak5rdVdmSSthSUxteGxoQW9UK2hsdmxyZ1lOWlBlUmZSUUh0RTNtQVpoOENM?=
 =?utf-8?B?OEY0Uzhja0FYZXdTcDdIREtVM3pudWQ0QUpsUTdCUVNHVlRSSXNTVUtwNmhl?=
 =?utf-8?B?bzkzWEdOcnRBNEtocEc0N0JOMWpkQnh4bFNXN3BabU9hZ3VCMVJ1Mkxpb29i?=
 =?utf-8?B?SVU4VmtaV1NUaXhGdnJVVkNOZ0EvWDNkUFZRcVM4U2VwQS81cThPZkk5ak91?=
 =?utf-8?B?Y09MYlRNa3ZNTHFZMzYrZ1dzSzVxc2crUndUcjdFdkhNbndhOWloRTkrU0ZD?=
 =?utf-8?B?ZWhrTUJldS8za05SMUFUeUxDOXNTZlB0WnpGMm1qRlk0U2I0ZmgzcTNiZVd0?=
 =?utf-8?B?bEZXWmFJN1pqdld5OG5FZ3MveExhQVk5OXFUZWFhVW1JYzhoODJ5Qk1ISUdX?=
 =?utf-8?B?N0hOd0VsTytvZUQzV29BK1IzM01aSnBWSWlCeUliVm5HaWMxL2JETVZ6dk5D?=
 =?utf-8?B?Zi9LUWVza2t6RFIvK2FraVBMRmdWKzlqWUVFcG1PK3BPV0t4RGhpTklGWStX?=
 =?utf-8?Q?Ab6FC0vw4nZbTbdBMQ1D+o7imUQrCKYFVsNYZVi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b792d8-a5d1-48b9-78cd-08d8e23b547f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 14:06:12.2942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+KyRK5Al+dLTf8bn7zFbEb/Y2bXbndhPmgMUcSZlriUJrFKzFjVjijpepguKawq+xaap8Br0UwSHrk8QLGdMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1864
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDMvOC8yMSAyOjU4IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4KPiBBbSAwOC4w
My4yMSB1bSAxNDo1NiBzY2hyaWViIE5pcm1veToKPj4KPj4gT24gMy81LzIxIDQ6MTEgUE0sIENo
cmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBXZSBtaWdodCBuZWVkIHRvIHVzZSB0aGlzIGZvciB0
aGUgS0ZEIGFzIHdlbGwuCj4+Cj4+IERvIHlvdSBtZWFuIGZvciBhbWRncHVfYW1ka2ZkX2FsbG9j
X2d3cygpID8KPgo+IEZvciBleGFtcGxlLCB5ZXMuIEJhc2ljYWxseSBhbGwgcGxhY2VzIHdoZXJl
IEtGRCBhbGxvY2F0ZWQgYW4gQk8gd2l0aCAKPiB0aGUgVFRNIHR5cGUgZGV2aWNlL3VzZXIuCgoK
VGhhbmtzIENocmlzdGlhbiEKCgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KPj4KPj4KPj4g
UmVnYXJkcywKPj4KPj4gTmlybW95Cj4+Cj4+Cj4+Cj4+Pgo+Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+
IEFtIDA1LjAzLjIxIHVtIDE1OjM1IHNjaHJpZWIgTmlybW95IERhczoKPj4+PiBHRU0gb2JqZWN0
cyBlbmNhcHN1bGF0ZSBhbWRncHVfYm8gZm9yIHVzZXJzcGFjZSBhcHBsaWNhdGlvbnMuCj4+Pj4g
Tm93IHRoYXQgd2UgaGF2ZSBhIG5ldyBhbWRncHVfYm9fdXNlciBzdWJjbGFzcyBmb3IgdGhhdCBw
dXJwb3NlLAo+Pj4+IGxldCdzIHVzZSB0aGF0IGluc3RlYWQuCj4+Pj4KPj4+PiBTaWduZWQtb2Zm
LWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+Pj4gLS0tCj4+Pj4gwqAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIHwgNCArKystCj4+Pj4gwqAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4+Cj4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyAKPj4+PiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+Pj4+IGluZGV4IDhlOWI4
YTZlNmVmMC4uOWQyYjU1ZWIzMWMyIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nZW0uYwo+Pj4+IEBAIC01NCw2ICs1NCw3IEBAIGludCBhbWRncHVfZ2VtX29i
amVjdF9jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgCj4+Pj4gKmFkZXYsIHVuc2lnbmVkIGxv
bmcgc2l6ZSwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0
IGRybV9nZW1fb2JqZWN0ICoqb2JqKQo+Pj4+IMKgIHsKPj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBh
bWRncHVfYm8gKmJvOwo+Pj4+ICvCoMKgwqAgc3RydWN0IGFtZGdwdV9ib191c2VyICp1Ym87Cj4+
Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvX3BhcmFtIGJwOwo+Pj4+IMKgwqDCoMKgwqAg
aW50IHI7Cj4+Pj4gwqAgQEAgLTY4LDcgKzY5LDcgQEAgaW50IGFtZGdwdV9nZW1fb2JqZWN0X2Ny
ZWF0ZShzdHJ1Y3QgCj4+Pj4gYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgbG9uZyBzaXpl
LAo+Pj4+IMKgIHJldHJ5Ogo+Pj4+IMKgwqDCoMKgwqAgYnAuZmxhZ3MgPSBmbGFnczsKPj4+PiDC
oMKgwqDCoMKgIGJwLmRvbWFpbiA9IGluaXRpYWxfZG9tYWluOwo+Pj4+IC3CoMKgwqAgciA9IGFt
ZGdwdV9ib19jcmVhdGUoYWRldiwgJmJwLCAmYm8pOwo+Pj4+ICvCoMKgwqAgciA9IGFtZGdwdV9i
b19jcmVhdGVfdXNlcihhZGV2LCAmYnAsICZ1Ym8pOwo+Pj4+IMKgwqDCoMKgwqAgaWYgKHIpIHsK
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHIgIT0gLUVSRVNUQVJUU1lTKSB7Cj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfQ1BV
X0FDQ0VTU19SRVFVSVJFRCkgewo+Pj4+IEBAIC04NSw2ICs4Niw3IEBAIGludCBhbWRncHVfZ2Vt
X29iamVjdF9jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgCj4+Pj4gKmFkZXYsIHVuc2lnbmVk
IGxvbmcgc2l6ZSwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gcjsKPj4+PiDCoMKgwqDCoMKgIH0KPj4+PiArwqDCoMKgIGJvID0gJnViby0+
Ym87Cj4+Pj4gwqDCoMKgwqDCoCAqb2JqID0gJmJvLT50Ym8uYmFzZTsKPj4+PiDCoCDCoMKgwqDC
oMKgIHJldHVybiAwOwo+Pj4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
