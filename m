Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EE4C433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 20:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B50760200
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 20:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B50760200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E63589F73;
	Wed,  5 May 2021 20:03:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 158B589F73
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 20:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoIQpwm1j/aZCoU3ABYmky1og8xsrdVCYhZywS7+2JKaImNKmvtYSXfEYQVp27GfxgAojIwH9Upe+Gt5ThsHBuaAi76ekcipBrUd63Y2WuHn5CtcCTP33CKBL27pdVq3eGs9hgfNO3P4iffMngG7/lhnHQtS1NQ9IkhOtToHOhboQuc8jQKXys71QbvDw4Us3lj1n6qdZ/bttlDIrD7xXUf93K9ml5iFYwjXbwxjVS0A0a3DDtW0m7YlBXESCkdIaeVEweKbJ5O8USBWY1+4WN/rLiAxdWSE+GCOPVldTJWPV7WKkyZUnEq+gp3TLNtEMoWi+6dKM0TUNZ+oc/V+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1J30KO6ZXbl/vEsCKsHQaXm5zCb9Nhiwvwbt/4WxuFE=;
 b=c3InVeWDL2sLzZWqkkX+vPpu2TbUSkaXorZsnoeIYIPJkra1/M0VW2UaU4hOAhCk6iD2gD0MKvg7+syqhJ8bpt4haS0II0ia7YqE/FrgeKz2xxvvdhWkSOj7GLzHZe3Cz1ZUWrW+h7WXf2DnEPuh5BDhUTz2RjYQtzYuV6xG8I8IA0Zjor1Xqk5O7mIaToQLP8p9QuuGYUy7TpSdq4dFkYjDA67V2IZp0Eh8IDXfaqx31hJ7WmA2dKFVSxTGBMPLCfkf6wkY5zIhwdNrpmRI9fa2ArmFahwuWhH5ubZgzBToxsFE61ZepeAsBCWcYLFfWRLCSW7ntL2E1baTTwszHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1J30KO6ZXbl/vEsCKsHQaXm5zCb9Nhiwvwbt/4WxuFE=;
 b=pyjn+WE5rYMY0PhZNOXK9pusgeG2uBCIwLTpl32nuFOumeBpC+0U9oukruc9w+7CBvMOOX+RRKVlLSO+wKArIGDo09y+qiyVKX6kWr2ZrHCZBqcpHnJBn/Mw8/TAtEQvSZNQDaCw8YX7axm949FPh6zyoiuo4ju0jwYLntEeqZ0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Wed, 5 May
 2021 20:03:46 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4087.039; Wed, 5 May 2021
 20:03:46 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: set new unregistered range accessible by
 GPU
To: amd-gfx@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
References: <20210505175617.30404-1-Philip.Yang@amd.com>
 <20210505175617.30404-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <96378cfe-61ae-2a09-de25-ee65ad11e0ef@amd.com>
Date: Wed, 5 May 2021 16:03:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210505175617.30404-2-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YTXPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::49) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YTXPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39 via Frontend
 Transport; Wed, 5 May 2021 20:03:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b811f151-599f-4f85-06bd-08d91000e40f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5368D8B92CC78855998978B792599@BN9PR12MB5368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VQJ1MMj0QOrdwN/eGQoBOLeM8JUIlLgiZr3UYLmi3A5eSLGr3DXtWW6JLmePk20dxFTcTl3hvjwS/lUAMZZL6i/v2o1eyNVfro4pb++ACH8tH1nCrNng3QKj0l5WM+HR/nwtj0Emm7GhcAtTdmUmb4BXUDF4n9Kx0iVYDizqfUg2GrpluQVPdZX/y0KXpotMuC7tKfmFg8Rkht4z7ZLg1V2vdalXBIp9L7OBuUMEIFTE+xfntu/W1nFIGoUUK7Sm+6nxL8soOFM9TfHpOpX6hUDvInyJ1FS03yWdGBfZHCfnI1OLAfQRHWrWKgckw7j0z7sIM5Vr1BUL1mNtuSrAcUUe8YwM2Vv8bGdrjzOnGTR0h29l2iQIvFqoIbtlGKoyXHSkkh0ginNndGLzEpKcqx3UKoihimu2OLUWOlPHxO71PzHbbkwBL/okhpThQdIvUGkM3QUZcL8mRjg1lKD9pa9ndMheEXcooB4jTX021FUCKsKwGo0pWDkvVLjMRnxV2/W1TQQ7cUgB6lG/Y6ycQhMdVv1pYpwQrpEnWlyZp5UHstcgDZVkUivY7XVfNdHclZpn60Ts+JnYAenpaivlZBVY2rm1FQg2oNymggD7SSAin+yXOtTZhWXMrn1Men3lt+5wXIqGUwaDvF6Et5EwBfKdblSaRoWCwQakMCkY3ZAlwC9LftGbt87pEPckI8N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(83380400001)(6636002)(2906002)(36756003)(38100700002)(86362001)(44832011)(31686004)(478600001)(2616005)(6486002)(16526019)(186003)(66556008)(16576012)(66946007)(66476007)(8936002)(956004)(8676002)(37006003)(5660300002)(316002)(26005)(6862004)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cmRhNlB3a2l6NkZZTUJKVjVxTnpJUmxOWUlhOXR4VjJNemV1aFRoREU3SUov?=
 =?utf-8?B?N0MrRVBJOEhFa3FCU3ZwOVpMak9CWExwaEJPVy9MSjNZa0s2ME9NRVcrTytW?=
 =?utf-8?B?cS9iV3o3UVFiZm5wa1ZzYkVueU5yMnZKTWVGU214T3ZWYlRXdTAxYmxER0M4?=
 =?utf-8?B?Skw0blNNS3luRG81ZGNrZGtKWHpQalh0c0hCbnVSOFFRT3RtNU5ZTlVIVTR4?=
 =?utf-8?B?OTNQeUxxMVdOVnRNeGQycWk2UDhwQlloNEFJWU5DY0ppbGdoMk1XTC9GaDAw?=
 =?utf-8?B?ODhJZFd5OXZJc2VnemRqUjE2dTdrWm9CbEF2dHo5cXord0g2Wm5IaDFDaDRM?=
 =?utf-8?B?SkhVbWZWc2VwOFpLcHlwMk9nVVpFUzdpazkraU5wK0FJQUdLSWdsUUxzbXBS?=
 =?utf-8?B?MTR5S1pNUXhmU01XS1pZTGxuaU1oMUZzb25FVUUrN2NtUFlwQlVjeEpqd0dG?=
 =?utf-8?B?YVZPUHRkWTNXei9oYzlzekxvVjQwaFN1TnQxYmkrWmdTTFlOM3J0OU5Nb0Zu?=
 =?utf-8?B?VW14NEpKcTFkdU95YW42Y2NTdzBlbUZVZTh3WFFUaTZsbUt3Q0Q0b2Joc1U3?=
 =?utf-8?B?Vy9sdVhEM0xyS05KbUF2cndpaDdXNkxybmNNQUxESmcySU5NL2VLQkxZT0w0?=
 =?utf-8?B?c0IwQUFKTDVCNlpvZ1o0K1prNVFHMGs4TXZUbkh0S3JZVjBic2JSSkJNQ3lD?=
 =?utf-8?B?WmFESUhYTFdFVlViNGU0Qi9GelhLNHRnTzBsejJhQ25mOUdNUmRjTE5SUXlR?=
 =?utf-8?B?SWV2TFNpNFF6bVBYT0pUUXF2R2s2b0V2d3hhbEJkVmdVMnlzWmRGOVJOMmtW?=
 =?utf-8?B?bDJQLytGT0hTSlJPc3FadXRjZEZkWkhDa2d0SytWUWpwd0pORUt1YkZvVkM4?=
 =?utf-8?B?UGdoWERCTTRPSzNuWTZzZU5VeVAvcXFUdU82VUVJZWd2VjRKcEVXaXl2d1F2?=
 =?utf-8?B?M3l0YnJYZzI5MjhSUDZLMVVOUTBROStJVHJmWElLekthSDlKdkJSM3RYTXUr?=
 =?utf-8?B?RU9FbThCY1FIU1N5bFB6UUhtYUFPQWJiUXVKTEtsVjlUSytuOWdxYzhiQnpP?=
 =?utf-8?B?Q3M4c2wxVDdSS2dHTFBUNjBVU1F1b2VSNFVjbWZyMHRKcFlTVGFZRGRRNzhi?=
 =?utf-8?B?dHNhdDgxSEFjN3NxOFExcEg0QzhkQ2cvNmZBOWE2aG00cHlJdkNjZVVjc2Qy?=
 =?utf-8?B?RmZDTU9YMFlGRVp0bWpJN3VaaWFULzF6Ymd1c09xMXYrbzdPUTNZTWJ6TXNP?=
 =?utf-8?B?b0lCcThmc0J1RUZkWk1LdTF2c09SOGtkRVluTzV4U1ZmL0RLaTBNM1Flcjl1?=
 =?utf-8?B?NkpSbEJYMXpEUHc4WVRtODBod3pycG5semZ3NDR1eVhmMzRsYlorTllINzJn?=
 =?utf-8?B?TlEzMm1YYkVKdU1HaTAwMkxhc0hBK0E4WEpWYkJZT0E4dEFZb3pMNDM5ZGNt?=
 =?utf-8?B?bWVWeEpWV3ZjdWtBV3ZBZXY0VVl6bGhzL3l3bTJmbWlzZ1lSSFlFOTBic0hJ?=
 =?utf-8?B?MllrQVVqTWF0eWZxQ2VpK0JzZC92cE9FZjc0a0s4ZVhXc0JlajFQMUlxSXFD?=
 =?utf-8?B?RlJZTHdEZ1h5NUJnenk1THZUZmFXTW1GajhtZW5kR0xjcHN5dE5nVFl5R3lu?=
 =?utf-8?B?blA3K0dHTitiamx0ZkY0cXdmalRHVWdUMGM3VW5uM0tObUdQc2R3U3pFbjBG?=
 =?utf-8?B?MVF4aERJVVZyMm4wVS9jSHh1MWFXZjh6OWxSSElyVG9nSFVBR1dtNnFlWU01?=
 =?utf-8?B?ZXJUUTdGREREK05pdEtRaC96S3NzaENKMHNmWW4vRjFyWXpCK0Y1V3dPUjVZ?=
 =?utf-8?B?dEhMRUtSSDUxR2RmMU9Zdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b811f151-599f-4f85-06bd-08d91000e40f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 20:03:46.3104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuiYkQqLUmR0GccHUqkSTX1EXHbyCOoS+crYQelOCC4wUDJbxRjDmphLa2CSz7HDYrqFRz76smnLsBqitqRLjw==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNS0wNSB1bSAxOjU2IHAubS4gc2NocmllYiBQaGlsaXAgWWFuZzoKPiBHUFUgcmV0
cnkgdm0gZmF1bHQgb24gdW5yZWdpc3RlcmVkIGFkZHJlc3MsIG5ldyByYW5nZSBpcyBjcmVhdGVk
IHRvCj4gcmVjb3ZlciB0aGUgcmV0cnkgdm0gZmF1bHQuIEluc3RlYWQgb2Ygc2V0dGluZyBuZXcg
cmFuZ2UgcGVyZmVycmVkX2xvYwo+IHRvIEdQVSwgYWRkIEdQVSB0byBuZXcgcmFuZ2UgYWNjZXNz
X2JpdG1hcCwgdG8gYmUgYWJsZSB0byB1cGRhdGUgR1BVCj4gcGFnZSB0YWJsZSBhZnRlciBuZXcg
cmFuZ2UgbWlncmF0ZSB0byBWUkFNLiBUaGUgbmV3IHJhbmdlIHByZWZlcnJlZF9sb2MKPiBpcyBk
ZWZhdWx0IHZhbHVlIEtGRF9JT0NUTF9TVk1fTE9DQVRJT05fVU5ERUZJTkVELgo+Cj4gQ29ycmVj
dCBvbmUgdHlwby4KPgo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcCBZYW5nIDxQaGlsaXAuWWFuZ0Bh
bWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMgfCA3
ICsrKy0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMKPiBpbmRleCAzYjY0MDc3MmQ5
YzUuLjVhNDg2ZTBmYmYxOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfc3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMK
PiBAQCAtMjI0Myw3ICsyMjQzLDcgQEAgc3ZtX3JhbmdlICpzdm1fcmFuZ2VfY3JlYXRlX3VucmVn
aXN0ZXJlZF9yYW5nZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgCj4gIAlwcmFuZ2Ug
PSBzdm1fcmFuZ2VfbmV3KCZwLT5zdm1zLCBzdGFydCwgbGFzdCk7Cj4gIAlpZiAoIXByYW5nZSkg
ewo+IC0JCXByX2RlYnVnKCJGYWlsZWQgdG8gY3JlYXRlIHByYW5nZSBpbiBhZGRyZXNzIFsweCVs
bHhdXFxuIiwgYWRkcik7Cj4gKwkJcHJfZGVidWcoIkZhaWxlZCB0byBjcmVhdGUgcHJhbmdlIGlu
IGFkZHJlc3MgWzB4JWxseF1cbiIsIGFkZHIpOwo+ICAJCXJldHVybiBOVUxMOwo+ICAJfQo+ICAJ
aWYgKGtmZF9wcm9jZXNzX2dwdWlkX2Zyb21fa2dkKHAsIGFkZXYsICZncHVpZCwgJmdwdWlkeCkp
IHsKPiBAQCAtMjI1MSw5ICsyMjUxLDggQEAgc3ZtX3JhbmdlICpzdm1fcmFuZ2VfY3JlYXRlX3Vu
cmVnaXN0ZXJlZF9yYW5nZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgCQlzdm1fcmFu
Z2VfZnJlZShwcmFuZ2UpOwo+ICAJCXJldHVybiBOVUxMOwo+ICAJfQo+IC0JcHJhbmdlLT5wcmVm
ZXJyZWRfbG9jID0gZ3B1aWQ7Cj4gLQlwcmFuZ2UtPmFjdHVhbF9sb2MgPSAwOwo+IC0JLyogR3Vy
YW50ZWUgcHJhbmdlIGlzIG1pZ3JhdGUgaXQgKi8KPiArCj4gKwliaXRtYXBfc2V0KHByYW5nZS0+
Yml0bWFwX2FjY2VzcywgZ3B1aWR4LCAxKTsKCkJ5IGRlZmF1bHQsIHdpdGggWE5BQ0sgZW5hYmxl
ZCwgdGhlIGRlZmF1bHQgc2hvdWxkIGJlIHRoYXQgYWxsIEdQVXMgaGF2ZQphY2Nlc3MgdG8gbWVt
b3J5IChidXQgbm90IGFjY2VzcyBpbiBwbGFjZSkuCgpSZWdhcmRzLArCoCBGZWxpeAoKCj4gIAlz
dm1fcmFuZ2VfYWRkX3RvX3N2bXMocHJhbmdlKTsKPiAgCXN2bV9yYW5nZV9hZGRfbm90aWZpZXJf
bG9ja2VkKG1tLCBwcmFuZ2UpOwo+ICAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
