Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5D5C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 07:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674A361937
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 07:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674A361937
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB8989F07;
	Mon, 22 Mar 2021 07:55:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E3F89F07
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 07:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGemTBZmWnq7Zsfl7pGQBusB98B2SvfcX4Zl/f7ZL+4LKwU4H3RgyWsCNuK0aSrn+PGgidqkxZeKiNqgbMrO06pbn462OtYgVKTCO6LCyKAIEAsUDzvrCN1Slh/HQbl7bBvT89mVwZ3TY+LBgKvwsmXotIR5ZhExFp0eQ/NnbTEdpVoNjgQ+9QWJlE9AqWdPQbjMXO06o4fRPoLkzF/71yWHTv/ZuaO5ZMkZgOEhzoivR4w3eG6uqc3EtjkikpGAAY6MngZJW+r3S5836RZiOdlC+5McaJkjFgdKNa2aqIyVs7dhj5OAOn7K4LsEgjS09a8sMvudPUw0Azf0fKpDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqvfdH4zdoc15F3Uv747sOpdGCicmMFnDyMGQAAqWKU=;
 b=IMYunG2ME07Thx3cLMrGSxUV/SQxtowGxSbODZKOTWjnlUVSINHu7oomLmEBv94AIjiCN05qvKROfSgeAYARWJZ5Zo1y6+/PerMpVWnbtblwlVMmy6bYDEoFJAWjBiZAsOTNmuFJ7tF2PYt0E8mxbYGG/yJHfzCzz1vxj9CZrFJ1y5IMTVw74diuOoDt96LrXNSDXVPZbzsTpvLs7cB2A2o6KsybMzKZ92OX5jDTHwfRoDgz7p0SNytoH4t5pB3Cmt12k5glE9cqI6L9sdaCoCpj6zjsDnvG703nvyQ2pCruNU6n4Ss/t8oKN6ToJmEK/Snkm+y5AqLu8CuvDf110A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqvfdH4zdoc15F3Uv747sOpdGCicmMFnDyMGQAAqWKU=;
 b=FvCjsysf6k6SwgOQRUTySEoxf//5DkSGP507QI1L4qzEFGadsc1DjKJNms9ympyKfxDoG6pOzwXpcbh1cw7BRxXnvMlTMvrHf/C0BYxe7m7oUy3JToYcC0vgFQis7Fn6eICAN5sIY+Ssvhy781jt2xDoxD9Dqo1MZuFBiXIUogg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3696.namprd12.prod.outlook.com (2603:10b6:208:169::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 07:55:20 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 07:55:20 +0000
Subject: Re: [PATCH] drm/amdgpu: Use correct size when access vram
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210322005326.9745-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <196295a3-30cd-dd59-a3d5-36baa66faf95@amd.com>
Date: Mon, 22 Mar 2021 08:55:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210322005326.9745-1-xinhui.pan@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:e345:6f8e:fa4b:2c52]
X-ClientProxiedBy: AM0PR03CA0016.eurprd03.prod.outlook.com
 (2603:10a6:208:14::29) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:e345:6f8e:fa4b:2c52]
 (2a02:908:1252:fb60:e345:6f8e:fa4b:2c52) by
 AM0PR03CA0016.eurprd03.prod.outlook.com (2603:10a6:208:14::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 07:55:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97d9f682-acd1-4599-e7b7-08d8ed07d6cb
X-MS-TrafficTypeDiagnostic: MN2PR12MB3696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB36966456A2C44027C58CBFE883659@MN2PR12MB3696.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5AeFstE1dIoVu7WAXm/tvWB6d71UWlff7ZTHl/5/JGlc1LtOJhT4Uzf+BDPXQLWxN1fGps7+jyvA5F3E8rJRyYLrlmLklaT6xR4X89kp0zRs9Sm+X7UmsZUfOz9b3V5Cu6qa2NPnzEqX+iUAw25ntsh71LONay3fOUasn7rQoRXpVFd9LKLxxVG34rz3UHyQ4+pjSuhOZWx2bNUNoen0cWKWwZ+3fQ8QJu605GhoqBolE7nj/0JLugmxYfpa1c115i3Ff8WviIsO+X3IOxy81OHEiYk9y2ryulCDfIQR9n2ehyvhDGTPfQEwqKhrZuB++cgVoPYZ1jGekDUurxpm6Phciak7A9/LRlujPTkM3r47IpAigeBGOPEA3loGHN4NBmvGF4u8mtn2lduaND0CyQiST/TN/gOycqxf79vGYuR5jBw9Qg2Q3jKkVMBWOFdm/oZUCpgDf8/paMfbJGIY6DSoW/x3N4gui4NwHXkAobFg6YxxxtU3gYelT6kooqxhkckK1mwhrdrRGEKz9Yuqx2Fmmqqpb3drtgBWkhO8UWumxHRC0vq8ruZK9gzWpS+u5r4Mem/IJEBGLhEKFrsJxzUWOLRZHXeIm7GsPQaY0I4/IA7p9geAmcI50ayRoUuFV/VCcf+KiJxR+5tYemasXk+FwSsWnbAL+acUq7yqbeenuJ9AAHpU4l+Jo9Vefq1yNpTAvWs9g7IVJ1PuHGxNm6aWWHNSo9pMmrQSec3ZzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(6666004)(16526019)(66574015)(86362001)(66946007)(478600001)(316002)(2616005)(66476007)(186003)(2906002)(5660300002)(66556008)(38100700001)(31686004)(6486002)(4744005)(8936002)(4326008)(31696002)(36756003)(8676002)(83380400001)(52116002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OG1KZFhiNXI5TG1TWEo0SllMdTNhUjV3RjZoMkVGdVFQbjhVcnZKZjVqUnFv?=
 =?utf-8?B?Mm5zVkZIdGhpczVOdUFZcjE4U0wrbW9qZEJWc01rQThFUll6d0dJUlRTMVZw?=
 =?utf-8?B?eXdFek1zaXk0eW5HN2dudmFheWJrTHg0M0Nia1A1c0lBK1l2bi9BcUVVWWZT?=
 =?utf-8?B?ZEpVRndseUdFckFUMWxkVDExTTBMcFd5eEpWQjQxejI1UXpYdzVtQmg1Snp0?=
 =?utf-8?B?RHRYN2YyTkhOMVIwc3JUKzRTRUtuYWhUMG5JSEEzNGJBMXVZdHFFSTJMMGRB?=
 =?utf-8?B?TzdrOWZBMjcxdW1xSU5HRWJhY3ljcUNIUXA3c0IwN2dIZm9meFIzMjg1STRZ?=
 =?utf-8?B?NkxYb3Z2VzUxa2dickFmZGQ4cEx3dC9BSlM5bFhFT3psZEhQRDJicGJabDVi?=
 =?utf-8?B?QXh1MW51SHhqZno1cjY0L0hmemY2dVhXMjE2M04xYWJLKzlOVVFEOUswblpT?=
 =?utf-8?B?OVhxZ0dybEtnQm5hNzQ4aGM0L2hTckdUSzFaOGZPY3h5NlduL29WNk1LYS8w?=
 =?utf-8?B?dm5kY3lDWFJidjY0SmQrbElkeTgxV0VNbUNFZzVLaUFCOEw4SmxSdXF3bzR4?=
 =?utf-8?B?NFN0U0E4SHhVMXJQUjN2RUdlU0R2WVJHTzVJUHJ2V1orODZ6UythUkZsQUdW?=
 =?utf-8?B?ZVNWSVhGUnNpc2xGMVJRb25xTTVHTzZlUERoRkRPN05wNjU4R2dZckp6NGkz?=
 =?utf-8?B?NHR6dm8vQWwyMnJCMTFYSmhOWmFYV29SbWhSV3dZbHVMZ3JqeXRNT3lYOVJO?=
 =?utf-8?B?YkQwd1F3SjRGUnVQaGI4MC9OemhJM2wraGJxMElBR2k2cForL24xbWd0SU12?=
 =?utf-8?B?eUJ2VTZQbS9kcXBka0hqM0JaS2tuSmNMVm04WE04K3gvOUxSa016TUs0S3I3?=
 =?utf-8?B?MGRxKytYbXJnek1iMnd6aVZQcW1kdE1ORlluQmhibnNlYVduUGoraTlVRWhF?=
 =?utf-8?B?SkViV2JHaWJGclg4TjBQSGJOL3E5bEZFQTFKRDRLM1FLZEZRQWcyNEV6TWt0?=
 =?utf-8?B?TWJUNXRJODZldHNHMHoxeEk5bmhZRkdyWGt2SHkzeG1zSGppcnh6aGlEUEtz?=
 =?utf-8?B?c052M0pGQ0NLRzdGWkViakJhMDZIcXhVK1VDWG9keTAzb0M0WHVLVHVHT2ZX?=
 =?utf-8?B?UUl2ZGtCWEJEQUlDVHBaOHBHQ0VtTWxtR0ZTeGlRMHV2RHgwci9LQnp4Wm9C?=
 =?utf-8?B?a05wdnRqcTFXTUE1ZUtpN2h0RHVXNmRFMFQxa3ZWWlgvZ0ZZUDlqWTBVVUNz?=
 =?utf-8?B?M1drTU1KUTN0ZXJhanhjNXMwRk1DckI1SWZxS0lGOUlMTUpFMmthMzhTQXBy?=
 =?utf-8?B?VUpUM1RUcjNyQmkwSEpjRDVwQUQ4YVl5M1ByeUUySWJZQmVtU1N1aXVhd0tK?=
 =?utf-8?B?VnBMdVM4Qk1MVnI2VEhFTzhXVW5mekJlTERTQlhFbjF3UXB3N3B4QU1sSml2?=
 =?utf-8?B?SU5GaEFRUm9qTkk1YWFpWlhkN2djcnZLeUticVliNUxzOWJ1Wm1pclZRaFNY?=
 =?utf-8?B?RDZMTTJZb3hPdEJYOHYxYVUwdGdPb3IwbXNOSkJRT2pxV2E2aFhHQ3dwSWFw?=
 =?utf-8?B?OEVyS0RoOE0wdkxtQzJLNEFqN1ozK25NU21TcGVKV0FDU1VQNlMwV1hJWG5M?=
 =?utf-8?B?QUFwYURleDdrKzJ2Z0MyT1krdG5wdlVySHo1WmZFZlJKZjVFZ0ZZbjhOOVY1?=
 =?utf-8?B?RnNieHlFcHd3N09nM1haRGZpNVhBRGhoaTczTHQvc1pscEZxNFRFalNLY01s?=
 =?utf-8?B?N3pjQitBaTk1Q2FoL080TXV5eS8zZlA4VUFpOS95R3hoNjU0d3U1L0szblNE?=
 =?utf-8?B?QmJPOVltT0xRSXhlSWZ3ays4TVJ1R2NNQjF0cWh5UWUxaHd3NTZYdGVjL00y?=
 =?utf-8?Q?BZd/JSAQM3Q28?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d9f682-acd1-4599-e7b7-08d8ed07d6cb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 07:55:19.9415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sl4wHlvXHHcDYylc30QnBFBX7bomxlJ8mAvb80Ry/F9hAq4KOR5Mr6rmE83AJ3D6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3696
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjIuMDMuMjEgdW0gMDE6NTMgc2NocmllYiB4aW5odWkgcGFuOgo+IFRvIG1ha2Ugc2l6ZSBp
cyA0IGJ5dGUgYWxpZ25lZC4gVXNlICZ+MHgzVUxMIGluc3RlYWQgb2YgJjNVTEwuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFtZC5jb20+CgpHb29kIGNhdGNoLiBQ
YXRjaCBpcyBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0u
YyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0u
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+IGluZGV4IDZkNWNm
MDUyNTMyNS4uNDFhNGM0NTY5NjFjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90dG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90dG0uYwo+IEBAIC0xNTAzLDcgKzE1MDMsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV90dG1f
YWNjZXNzX21lbW9yeShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAo+ICAgCQkJCW1lbWNw
eShidWYsICZ2YWx1ZSwgYnl0ZXMpOwo+ICAgCQkJfQo+ICAgCQl9IGVsc2Ugewo+IC0JCQlieXRl
cyA9IGN1cnNvci5zaXplICYgMHgzdWxsOwo+ICsJCQlieXRlcyA9IGN1cnNvci5zaXplICYgfjB4
M1VMTDsKPiAgIAkJCWFtZGdwdV9kZXZpY2VfdnJhbV9hY2Nlc3MoYWRldiwgY3Vyc29yLnN0YXJ0
LAo+ICAgCQkJCQkJICAodWludDMyX3QgKilidWYsIGJ5dGVzLAo+ICAgCQkJCQkJICB3cml0ZSk7
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
