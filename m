Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A2CC47087
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 07:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884F06108D
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 07:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884F06108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F7F6E372;
	Fri, 28 May 2021 07:54:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EFEA6E372
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 07:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InOVB2rQQn4OP9xY9KhBBCEbTfePdT+kJ8T9b5DnMmfFx/zVpXT8Wkb08T4UuVxo2avRSabsPsCJYYNpAVZ/PPKRBAI2kl2UBNR6CJDsqGKbWc53f7yzce9GC8CWuekIXtd9RGOYn77DdMSaS62rfkNmD9EJXn0ZrTesjrGPECWBBVDYuxZwNm8yl5nV+FqkSNzgxO+a7F8JQ7jE0oj9BfUHNGqfsP15Lx92bB3dbnjbOtHrk4+x1xO7lmOC2aQgSBMgLr0azaSAd3Vq1E2gJWZ0s0d6aVNH0pGzJg+8YKyYRjId9+UZyjKt+xTXA3L7ilWYOpIfOunQmtKWBNvWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0Dg7HVOsNMlK6lES443QUANHYwHzEu6Pc960lc2SGo=;
 b=Nb4oTgIxmVhSv4jwBLCn1JmYgDoITRsOgIP+M1XjF5xo1gx+lx3OVInqqorw7PgDA59pGxN83AxcwIYXdWi808vC+UNjQEvvRraTJG4FiClHxztJgjvYMXYUnuAUIeCbMhcmehRCBbwQ8ZlfDUnvxgkOd730h8owkVQivEIOR1qxXxwMGv9gDy2JMuNkGN4JL4X4IxBMOvcOzkWoHN850UScHdw7n7E616Wqweb93HMNCcYzOfnpmiPx5Xb7nsDREIefYW1WIH/PmF7RemlDG2tk2dbcqLlNBRh6CiAR/tUg/9VqYWWSZc58SQY1kY63Bn13KzX1eO2ZKvMe890zKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0Dg7HVOsNMlK6lES443QUANHYwHzEu6Pc960lc2SGo=;
 b=K4BROJ2lyf+NOBoez09dJGnUyrRoSI/naaB3vLNZbVAruV2Em0Kej9iEyHfChvE7CsaGTDRWc8P9LirDinPNMa8P52B0LPaTBzNDArulRJD2uKAGwa0R2VNzKMAQq1zADQtiQtJw7VuKybd2AndQnJNKRDgRBeOj9MMEQ+Qcw4k=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2548.namprd12.prod.outlook.com (2603:10b6:207:41::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Fri, 28 May
 2021 07:54:52 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 07:54:51 +0000
Subject: Re: [PATCH 3/6] drm/admgpu: add two shadow BO helper functions
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210527115343.20133-1-nirmoy.das@amd.com>
 <20210527115343.20133-3-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f0281805-ccb1-6d65-d004-6ccbcc70aca8@amd.com>
Date: Fri, 28 May 2021 09:54:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210527115343.20133-3-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:2960:4608:1392:c6ae]
X-ClientProxiedBy: AM0PR03CA0021.eurprd03.prod.outlook.com
 (2603:10a6:208:14::34) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:2960:4608:1392:c6ae]
 (2a02:908:1252:fb60:2960:4608:1392:c6ae) by
 AM0PR03CA0021.eurprd03.prod.outlook.com (2603:10a6:208:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.21 via Frontend Transport; Fri, 28 May 2021 07:54:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df028ba0-1642-4ece-4ee1-08d921addf89
X-MS-TrafficTypeDiagnostic: BL0PR12MB2548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB254883A719531218FD68254983229@BL0PR12MB2548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +z7cDN7l2V1NE33nynUXnRMyjQMU438pxx/5p13c5DUeGtBhn8FbBQKb0ICeheElFYVFyIV6cxapnHE+XeXLo1wY6vUf909yjiY/5g7UqLuQ8PZKTMNqHSoHo0+1s+WL+b887HmKleuSITtB4J8F9Fx4nBIOFJujcIHQakAMPMQt7qrYQscpndkcMaxF6wBtjBsI2M3FpQL/4t1UgGdgUeCC2ed9/m98h701jXm2TaC24a76kEQyseCUjlLv9SFUcheN9ywqA5gT8j7n91pbMVQG7Z6r1P0FO1bIAK+KiUiSyApApD5TTPJEZIE6f/Z/VwQAiBqUr4nuuL4egWQWQzvu8ZJMOwRAtuzuaTEUP+2NVSvhk6vt0gmoDAlMJj+VqpLO1ovWFmI+F6C0hehADvNvBCPkAJjAOVaygocWIBVUNnquRwNe3RjxU+PtBw2r/1YIpIKvQitOVC7+D9uoOKBvIRoZxkiAb6FhpbHUfcOmFo4MlAjOfEB+YgXH3pQ6XDOr8kbqtYZ1gFRdQuIe6KlmENxyuH8ySXGSTAxR3X2X2yUU7cCrSg7p44YvJJCRieXdFJBF7f+XqwLdmktrFBm4XqQD7zR8uvKjrhmiNmOqfDnl9rMinL4hpkgsbfXyDT93t34jxP/MprW3rssDZvcfN8o9QrMZzHDatcP9thV3o6AOHocRvNUuFCDg9wBR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(186003)(16526019)(8676002)(31696002)(38100700002)(8936002)(31686004)(6666004)(36756003)(86362001)(2616005)(66556008)(66946007)(316002)(66476007)(2906002)(478600001)(83380400001)(66574015)(4326008)(5660300002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TjVIaVc2bTRnMkhObjBvRUNOOGxEangwSHUzV0g2RnliZjEzR1oyUVMrNlR5?=
 =?utf-8?B?MFhsbnRXOFlqUmUrMlRjYWtNVE9wRmN2eFp6c3V2WjVMSGJOZERSZmcyb2xJ?=
 =?utf-8?B?RHlpakR6Ykg2RGkzS2RnMmdLMndCNVhWOVlrNU9TQUJaVHNYbnVNVHM0dXNp?=
 =?utf-8?B?cnJhU0thMzVmTzJRajhGdVlDQy83T2E5Z1JEck9qcTViNEpjaEtXcnQ2eGRE?=
 =?utf-8?B?ck9TK2owSDlZaGZhRUNKMTM1d2hsanRLYnMrRk9Rc0pQMzEzSERva29pdVN1?=
 =?utf-8?B?MUxITDJTcW1HTFpSQXMyRVBWaVk2OEZlaFdIY0xueDRlTTdnUUs2RkdSUFc0?=
 =?utf-8?B?ZHFHQVVGa01FdElxRFdIQTdVMnVhclZIamVWT1M3YVlmSTQ2M3lmeDVyNGxr?=
 =?utf-8?B?b3J0cU9JK1Z0eTF1ejJEOC8xRnBGSi80UVJ3ZTJBUDdVWGZmRmxnbjVGSlVx?=
 =?utf-8?B?WUEycTVxTnNYK2R5QS9HYzNjbHpMYnN5bDNwOVlRTHIySFhrZkdjWkpiT0pm?=
 =?utf-8?B?Unhqb1ZOQTdnQysrY3ZBL0Fhb0RDaHlYb1hIUE9EUk10YXE0NWxrQVU1NXZq?=
 =?utf-8?B?OHdRSzZrTmR0VHg4dGNDeFZudjYwU2R5clNweWtCUm9JenJVZFphS1ZVTlRs?=
 =?utf-8?B?bnhIUFhVNkRidy84dWNJdFd3ZU9wK2Rtdm8yempPb0U0NDdSdG5DK1g5aVMr?=
 =?utf-8?B?SWd2SWtWRFdzRzVrK0VUbUhpR2V1bkRYdlViTEZ6TXBsTGRJK25pdHU1YjAx?=
 =?utf-8?B?U21VeTQxY3pPL2lHS3FON2JnUGFTWWh2bytDN3hRQjhOd1ZZd2F4L2ljNWY1?=
 =?utf-8?B?NEpXVWtENVI4WEhiZkhod1pzdFR2UzN2QWo3VTVhcGV2ZHJVN2NyTmdWQTlT?=
 =?utf-8?B?SzcraXQ4aWZSZ1lJNHBjaXRLZklvQTBCRGFmNlJQc0tMMGRIYlh2aGlTbzZy?=
 =?utf-8?B?dm9SNnl1ZVEvWFdYOUxjZG50TDhPSVVKUHM2RFZibStnN2YzckEycmJSeS9z?=
 =?utf-8?B?U0lMc2MveDhGa0JycTlDVEJlem90MTd5WkwzRHR2UlJhUS95U0pwcmpYVHk2?=
 =?utf-8?B?bFRaODhtVkhUQjVvUXczOTVmRi9DRFdrb2NJZWpkcDZYU2dlbFF3ODIvTThj?=
 =?utf-8?B?TFY5V3lWZ3dsOUN4Q2JldGpMU3ZUbUg4bFVXL3VodEZPT0pzdFVBb1prN29v?=
 =?utf-8?B?WE5VR0NkVDdxTXZoSFhZSytBTVdmSS9PZzBBTGRCM0pFVzVoTTZObzZxYmxj?=
 =?utf-8?B?LzV6SXpPVmViZnZMNEtySW9zR01KN2JRamQ2OWFLTzFSdDZ2Z1paN0xlN2RO?=
 =?utf-8?B?M21McnVtdUtDTHd2aUV0amRPdjRIRU5BVXpaVHZpVDVBZ21jeEJFcUN3WUls?=
 =?utf-8?B?MUllbXFtV2QzK3l2M0FxdTUrbXl6eDFXTHpkZTBLWmZPQ0hmc3ZEUTB6TEZB?=
 =?utf-8?B?Zjk3YjRLRUJhOGxXbFMxcmxzcnFMNXZRS2o0SDFEbDBramVwSWVySHcxQWMw?=
 =?utf-8?B?U1p5clZwMm9kR1dwT042Y2pjVS9HSGFRNHdlSnMwVDE0ekpJOUlVSm9GTkR1?=
 =?utf-8?B?WCsyV0s2dkFBMXJxS0NUOG5MM3NTV05mcFZrY3ZIL1Q4azRVQU9hRXZXT2or?=
 =?utf-8?B?WWZaZmxpSXhVTmNpb1BFY0JsTHZGdXJzdFBIbWFXcW1pcW1oaFQvY3RWdmZP?=
 =?utf-8?B?c3UrTGdhdEpCd1d4NFF4SUEyZmNwYmRhNHArRUJvZC9ISHEwcDcwMisxTjJr?=
 =?utf-8?B?WUI0SDhHTndSU2QzZmFoZnprcEN2bFI2TGVBbzFIZG1xd29JN256MGFIYVJp?=
 =?utf-8?B?ZGZaa1JDcDFDQ0tzOEtGZ1pySHVuUkRmMExWbG5lTzNlblg2WEIwV3JzeVlr?=
 =?utf-8?Q?enlinTnwEX5al?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df028ba0-1642-4ece-4ee1-08d921addf89
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 07:54:51.4491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vF1lWrAZh1HmsteRya847f4AFaIZ3tvzgOpz/gtWvL7TYLztY5glcU54JmzjkDod
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2548
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

QW0gMjcuMDUuMjEgdW0gMTM6NTMgc2NocmllYiBOaXJtb3kgRGFzOgo+IEFkZCBhbWRncHVfYm9f
YWRkX3RvX3NoYWRvd19saXN0KCkgdG8gaGFuZGxlIHNoYWRvdyBsaXN0Cj4gYWRkaXRpb25zIGFu
ZCBhbWRncHVfYm9fc2hhZG93ZWQoKSB0byBjaGVjayBpZiBhIEJPIGlzIHNoYWRvd2VkLgo+Cj4g
U2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgoKUmV2aWV3ZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgfCAxNiArKysrKysr
KysrKysrKysrCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0Lmgg
fCAxNyArKysrKysrKysrKysrKysrKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25z
KCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29i
amVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gaW5k
ZXggNjg3MGNjMjk3YWU2Li5hNjNiNDUwY2Q2MDMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gQEAgLTc2MCw2ICs3NjAsMjIgQEAgaW50IGFtZGdw
dV9ib192YWxpZGF0ZShzdHJ1Y3QgYW1kZ3B1X2JvICpibykKPiAgIAlyZXR1cm4gcjsKPiAgIH0K
PiAgIAo+ICsvKioKPiArICogYW1kZ3B1X2JvX2FkZF90b19zaGFkb3dfbGlzdCAtIGFkZCBhIEJP
IHRvIHRoZSBzaGFkb3cgbGlzdAo+ICsgKgo+ICsgKiBAYm86IEJPIHRoYXQgd2lsbCBiZSBpbnNl
cnRlZCBpbnRvIHRoZSBzaGFkb3cgbGlzdAo+ICsgKgo+ICsgKiBJbnNlcnQgYSBCTyB0byB0aGUg
c2hhZG93IGxpc3QuCj4gKyAqLwo+ICt2b2lkIGFtZGdwdV9ib19hZGRfdG9fc2hhZG93X2xpc3Qo
c3RydWN0IGFtZGdwdV9ibyAqYm8pCj4gK3sKPiArCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gYW1kZ3B1X3R0bV9hZGV2KGJvLT50Ym8uYmRldik7Cj4gKwo+ICsJbXV0ZXhfbG9jaygmYWRl
di0+c2hhZG93X2xpc3RfbG9jayk7Cj4gKwlsaXN0X2FkZF90YWlsKCZiby0+c2hhZG93X2xpc3Qs
ICZhZGV2LT5zaGFkb3dfbGlzdCk7Cj4gKwltdXRleF91bmxvY2soJmFkZXYtPnNoYWRvd19saXN0
X2xvY2spOwo+ICt9Cj4gKwo+ICAgLyoqCj4gICAgKiBhbWRncHVfYm9fcmVzdG9yZV9zaGFkb3cg
LSByZXN0b3JlIGFuICZhbWRncHVfYm8gc2hhZG93Cj4gICAgKgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmgKPiBpbmRleCBhN2ZiZjVmNzA1MWUuLjlhZmNjZjZj
NjZmMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2Jq
ZWN0LmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmgK
PiBAQCAtMjU5LDYgKzI1OSwyMiBAQCBzdGF0aWMgaW5saW5lIGJvb2wgYW1kZ3B1X2JvX2VuY3J5
cHRlZChzdHJ1Y3QgYW1kZ3B1X2JvICpibykKPiAgIAlyZXR1cm4gYm8tPmZsYWdzICYgQU1ER1BV
X0dFTV9DUkVBVEVfRU5DUllQVEVEOwo+ICAgfQo+ICAgCj4gKy8qKgo+ICsgKiBhbWRncHVfYm9f
c2hhZG93ZWQgLSBjaGVjayBpZiB0aGUgQk8gaXMgc2hhZG93ZWQKPiArICoKPiArICogQGJvOiBC
TyB0byBiZSB0ZXN0ZWQuCj4gKyAqCj4gKyAqIFJldHVybnM6Cj4gKyAqIE5VTEwgaWYgbm90IHNo
YWRvd2VkIG9yIGVsc2UgcmV0dXJuIGEgQk8gcG9pbnRlci4KPiArICovCj4gK3N0YXRpYyBpbmxp
bmUgc3RydWN0IGFtZGdwdV9ibyAqYW1kZ3B1X2JvX3NoYWRvd2VkKHN0cnVjdCBhbWRncHVfYm8g
KmJvKQo+ICt7Cj4gKwlpZiAoYm8tPnRiby50eXBlID09IHR0bV9ib190eXBlX2tlcm5lbCkKPiAr
CQlyZXR1cm4gdG9fYW1kZ3B1X2JvX3ZtKGJvKS0+c2hhZG93Owo+ICsKPiArCXJldHVybiBOVUxM
Owo+ICt9Cj4gKwo+ICAgYm9vbCBhbWRncHVfYm9faXNfYW1kZ3B1X2JvKHN0cnVjdCB0dG1fYnVm
ZmVyX29iamVjdCAqYm8pOwo+ICAgdm9pZCBhbWRncHVfYm9fcGxhY2VtZW50X2Zyb21fZG9tYWlu
KHN0cnVjdCBhbWRncHVfYm8gKmFibywgdTMyIGRvbWFpbik7Cj4gICAKPiBAQCAtMzIyLDYgKzMz
OCw3IEBAIHU2NCBhbWRncHVfYm9fZ3B1X29mZnNldF9ub19jaGVjayhzdHJ1Y3QgYW1kZ3B1X2Jv
ICpibyk7Cj4gICBpbnQgYW1kZ3B1X2JvX3ZhbGlkYXRlKHN0cnVjdCBhbWRncHVfYm8gKmJvKTsK
PiAgIHZvaWQgYW1kZ3B1X2JvX2dldF9tZW1vcnkoc3RydWN0IGFtZGdwdV9ibyAqYm8sIHVpbnQ2
NF90ICp2cmFtX21lbSwKPiAgIAkJCQl1aW50NjRfdCAqZ3R0X21lbSwgdWludDY0X3QgKmNwdV9t
ZW0pOwo+ICt2b2lkIGFtZGdwdV9ib19hZGRfdG9fc2hhZG93X2xpc3Qoc3RydWN0IGFtZGdwdV9i
byAqYm8pOwo+ICAgaW50IGFtZGdwdV9ib19yZXN0b3JlX3NoYWRvdyhzdHJ1Y3QgYW1kZ3B1X2Jv
ICpzaGFkb3csCj4gICAJCQkgICAgIHN0cnVjdCBkbWFfZmVuY2UgKipmZW5jZSk7Cj4gICB1aW50
MzJfdCBhbWRncHVfYm9fZ2V0X3ByZWZlcnJlZF9waW5fZG9tYWluKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
