Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7FDC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB4564DE1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB4564DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A25C96E2D1;
	Mon,  1 Feb 2021 15:31:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A3906E2D1
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 15:31:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3hAgxmeAGSCcjjRdPq2eczpRF4CHUiRYxqpKJCB3rIJXb1/wPxM6nCTbR2NLbXODN72MgV+Z84UaI2R01vdockYfIxkcO0/EnlFCMGO79g2pMMpqueOLOvvJdNAoaw5+vHVYDriw7ePGd4ZLbx5xiMKG8OhLALiEgDukrEmQBV2tljWtmip/SHc51Ea9qdFaX1rMM/QxOmQFNxqQF5/hlupeanX6iAH6yl2opNz3FmvVq6os+i9QVQbkZkw9IEMuLvhGxKdvOojW7r8PqR/gf0O5qLAHUjL9S9CkM/H2OU5RDI//X6nTwBRd/lGLJrnTtkxnejgFaB5iRhMNgFeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fm6ihL+92ZSS6dDmzy5fNsFpxBmATXAUMwSk5+Dz9k=;
 b=ca+vSC5nSkIyIe+313dhZ9kVgfH0HI87iJOHkG5elAPX/AE9IXt5f7YBE9wzRoTWPwFLyRWQbu6AR0j0wMP8H5ZK0Uz84ghE4K9OEb2ZHAC3uPxD74aFkDBjtQh5zy88osvuRAZTWjU5KhaeJ19PpMeaNmIzha+edFUmR0So3L4V+k2XFHdQk1XgfgCXwP4pfQC8XpadsRpe0wEcwHcroNa1z8lq8RYKVMTGlozHKrpf3itOdkXywuVivtiXnfGtnRfOMfHie45SsNH2pq/GWuB8xHGVCH8aPQ4F1E7RwIYN1Xvioo7nSkPORlJEEBtyoQBhaFlXHC5lSEdZqkmpWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fm6ihL+92ZSS6dDmzy5fNsFpxBmATXAUMwSk5+Dz9k=;
 b=s+YC1y8lLu8rRqG/flfgYUpwTInbu4JK7hDD4aZCI7l1GTdTsDnFyN79FV8elE019EPHAdUhtUthV/PQo56aPJ6ShBT7Fey4yYoqZcKpJ3YNM0oFgDYsj54sDEaYG9EnGo+rqyQzVjzEen4WFT00BFP1icjTktXAI2PbyTZWND0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BYAPR12MB3064.namprd12.prod.outlook.com (2603:10b6:a03:da::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.21; Mon, 1 Feb
 2021 15:31:22 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::dd41:21fb:f94f:eb03]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::dd41:21fb:f94f:eb03%3]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 15:31:22 +0000
Subject: Re: [PATCH] drm/amdgpu: enable freesync for A+A configs
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210201143408.81475-1-christian.koenig@amd.com>
 <2226fb7c-97e5-ba63-041d-219902e56dbe@amd.com>
 <7c3deeb7-8dfd-5a04-297f-292c4d1ded79@gmail.com>
 <101a7093-8dd0-80bf-9f31-79d08af809d7@amd.com>
 <5a8106c6-0998-5347-5508-ad5d6ed7111a@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <3cf9e0b0-a00f-83f2-5257-7ca54eebea8b@amd.com>
Date: Mon, 1 Feb 2021 21:01:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <5a8106c6-0998-5347-5508-ad5d6ed7111a@amd.com>
Content-Language: en-US
X-Originating-IP: [106.51.20.251]
X-ClientProxiedBy: MA1PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::30) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.68.111] (106.51.20.251) by
 MA1PR01CA0136.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 15:31:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a898a2e1-0367-49d2-7562-08d8c6c66dcb
X-MS-TrafficTypeDiagnostic: BYAPR12MB3064:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3064F942ADAB2D398A8BDB01F2B69@BYAPR12MB3064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUAfjiX4KPG1be7QxNzn1CjI3aXQQ4ZVP+vrrX238ZW6ZxBlfiw0gCAP9URpaol5FO9NEUKcTg0V/oDeJg75C2RivyRami9NenZMdzNpBwuDMl/j0Tke29hL73NJvNTVinA9/U092YhESdMcxEXYIE/oR4ATLLpNmxCYnNYj3M/FuDlXqkrXXJqPIi7lkbk0SvawWR40OdXW0r1SZQyff5wfK58d/uGCGvO2lu7b7ywsxLfNdkDAFZ5j9j0gtClnXxPV4M3HF3tEvezKCrmH5NfvVX1qcUS6Nip/oVAZUk0uFIcj2XkSwQkiKRqZGmos+UOrPI8cj2id/bOlGfAu+Hjh5AxIjWcdDl2c2+JAJ3158BUBllz9ikW0VEasHMmW8droncYaYqeETxqEBZAQ20RgJQQAKCQyccmGdoeHG6Xs4hHly+v60LreXPRixh5N+nydwpEevOAFGjqq0qX2vYEy5GEWBga+F6goAE9f8Smpj/W/8lg9Vroif0DlRuwvC/w1xETu3b4/IunxT1pdrLOlbK1VeksUdDesa2R+IMLshfQ5M86UJ9alRFDaKpcJWBbXB07QbZftrfnus4nhsHYiqjlpktX7qT/VYSes7ko=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(956004)(52116002)(6486002)(36756003)(2616005)(16576012)(31686004)(316002)(66574015)(5660300002)(8676002)(44832011)(26005)(16526019)(2906002)(86362001)(186003)(31696002)(1006002)(66946007)(6666004)(83380400001)(478600001)(55236004)(8936002)(66476007)(66556008)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y1FWZjh5VEJQYW9MWUZKdi8ybkZJSzFPNEhkYXpEZTBBTC9INGNLYTFJTit1?=
 =?utf-8?B?NEgwK0pkYTh0QmZ3K0NhMnA4QnphUEZQTGw0NlNMWW9WTTNaY1luUnAwNE1q?=
 =?utf-8?B?OUE1eHR1ck52dzZtOVdzYzhGOGUreGhFOFBBd0ZSbEhjTGkwM3J2L2MxU2dM?=
 =?utf-8?B?bXNUSVh2RnpHanh1cmlwL3ZVUHpxYmdLd3NHL2diai9XWnd6YnNKOU1FWUVB?=
 =?utf-8?B?UmJCeUppeGN1WjAyVGY1M0MrZFdJNDZ6aWhMZEdRbjVVaUhlUzBmVEhWQTMz?=
 =?utf-8?B?bXhsOXdkZ1BGazFYM1l0NTZ5UmQ2NmYwbFM5SXk1c0xmT0dlc3BDSmFhV25s?=
 =?utf-8?B?WHVDeko3bElaM1lLS2xuS08rdWNNZThlTDlNUEdXOVdjWHorcXV0TFBUT0VS?=
 =?utf-8?B?MEYrNDFva2pOK3BndmhLLzN5VjRQdG8zTGEyaE5WTGlBTkhSRStJejJvMy80?=
 =?utf-8?B?dStGc0lMbVJOc0kyVW8zblRCeFNxbDlmaTJEdlNDd2Zqdis4N2Iyd1RNMmZR?=
 =?utf-8?B?b2dBRW02YUpScVFNM2E3Z2RaQytuMlVsZi9WSi9LcnJvcElVSVdjZks5c0Jk?=
 =?utf-8?B?RnFERlJ4UUdMc2ptU0loeFU0QlJ6UklaV1YrS1hySTR6YU9kQ3N5S3ltRXVF?=
 =?utf-8?B?ZEdIOXlLN1QvUVA1YVpScEl0cURab2doaUdKVHdBTUFsOGM4aGhMVnFaa29r?=
 =?utf-8?B?K08rNUNuU0tGa3dSKzJnVDJob21MRDhjVVYweEV4cGdRczZCQitXS2g4cm9H?=
 =?utf-8?B?OUNMQWpPNDBhWXJ1ZlVxM3dKRUZpbzRxbVNIT0U5REpuYUpKSG93NFEreHdw?=
 =?utf-8?B?aDcxTmc0U2xWd05jeUZEZWVMd0s0Z1ZCVmYvSW9OcE81c0NJUUF5Rm5HWHVr?=
 =?utf-8?B?alNBREVBRUx0ZXg5VmVTSUN3OGRQbzRLVFRicjFKeEg2OFVDSTFHaCszTGpT?=
 =?utf-8?B?Ky80V09CelVucmJoTTFXa1p5TXF5UUJ1elB0YjJ2Rld0WUN2TFdtOXRQS1RC?=
 =?utf-8?B?UDQ5TlNLQlJOWEtJanoxSHk0VmdRMCt3dkhyNXBBSFFXZlJuTkpNeGZQeWVG?=
 =?utf-8?B?YjNwdEU0ekZLNVBnRFd0S3oyVk5Mc25SQm1RMXpXWFkrS1dqRXFyOWRjZTd2?=
 =?utf-8?B?SlVpTFZQWTNxdWJBY0M2MVJQUzVxNkdSRXNpVTA2NkQ3VVQvUi9qTlNuMTY4?=
 =?utf-8?B?K01JblNXN3BsVG5HK0JGMDcyV3BycklHYS92ZWd3YzdLeHgvTUEySzZMQUo5?=
 =?utf-8?B?MjBHQXFoMHUrMnVDem9XR0JIek8rL3M5aGtOUUVVeUFocVE5TW8vaDV2NFVR?=
 =?utf-8?B?ZXowZmZpVkRsb0hIZEM4RDN1clIwd0p4bzA5aU5ucjJpNFZQd3pFU2hJVWts?=
 =?utf-8?B?RkVwSTNNSlNWZ1NiR2NaQkhtb1hEQ3N0U01aalpsSWsrMllaYVZYdDRTMUtF?=
 =?utf-8?Q?js1r2/TQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a898a2e1-0367-49d2-7562-08d8c6c66dcb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 15:31:22.2179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ticj03VqAAuoH48HQtXrIMg5vNz3EefUugbOZSg86SjRt2ovqYqrkjIaFXcJl3aJlESaShpNZA1NizdHZioNPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3064
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

Ck9uIDAxLzAyLzIxIDg6NTMgcG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMDEuMDIu
MjEgdW0gMTY6MTMgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+IE9uIDAxLzAyLzIxIDg6Mzkg
cG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAwMS4wMi4yMSB1bSAxNjowNiBzY2hy
aWViIFNoYXNoYW5rIFNoYXJtYToKPj4+PiBIZWxsbyBDaHJpc3RpYW4sCj4+Pj4KPj4+PiBPbiAw
MS8wMi8yMSA4OjA0IHBtLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+PiBTb21lIG5ld2Vy
IEFQVXMgY2FuIHNjYW5vdXQgZGlyZWN0bHkgZnJvbSBHVFQsIHRoYXQgc2F2ZXMgdXMgZnJvbQo+
Pj4+PiBhbGxvY2F0aW5nIGFub3RoZXIgYm91bmNlIGJ1ZmZlciBpbiBWUkFNIGFuZCBlbmFibGVz
IGZyZWVzeW5jIGluIHN1Y2gKPj4+Pj4gY29uZmlndXJhdGlvbnMuCj4+Pj4gU2hhbGwgd2UgYWRk
IHNvbWUgbW9yZSBkZXRhaWxzIGFib3V0IGhvdyB0aGlzIHBhdGNoIGhlbHBzIHdpdGggVlJSLCBs
aWtlICJXaXRob3V0IHRoaXMgcGF0Y2gsIGl0IHdvbid0IGJlIHBvc3NpYmxlIGZvciB0aGUgSUdQ
VSB0byBmbGlwIGJ1ZmZlcnMgd2hpY2ggYXJlIGNvbXBvc2VkIG9uIGFuIGV4dGVybmFsIEdQVSIg
b3Igc29tZXRoaW5nIGluIHRob3NlIGxpbmVzID8KPj4+IEhvdyBhYm91dDoKPj4+Cj4+PiAiV2l0
aG91dCB0aGlzIHBhdGNoIGNyZWF0aW5nIGEgZnJhbWVidWZmZXIgZnJvbSB0aGUgaW1wb3J0ZWQg
Qk8gd2lsbAo+Pj4gZmFpbCBhbmQgdXNlcnNwYWNlIHdpbGwgZmFsbCBiYWNrIHRvIGEgY29weSIu
Cj4+IFllcCwgbG9va3MgZ29vZCBlbm91Z2guIFRoZXJlIGlzIGp1c3Qgb25lIG1vcmUgdGlueSBj
b21tZW50IGJlbG93LCBwbGVhc2UgY2hlY2sgdGhhdCBvdXQgdG9vLgo+Pgo+Pj4gVGhhbmtzLAo+
Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4+PiAtLS0KPj4+Pj4gICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyB8IDggKysrKysrLS0KPj4+Pj4gICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jICB8IDIgKy0KPj4+Pj4gICAg
MiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Pj4+Cj4+
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxh
eS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYwo+Pj4+PiBp
bmRleCBhNjM4NzA5ZTljOTIuLjgyM2JjMjVkODdkZSAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYwo+Pj4+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jCj4+Pj4+IEBAIC05MzAsOCArOTMw
LDEwIEBAIGFtZGdwdV9kaXNwbGF5X3VzZXJfZnJhbWVidWZmZXJfY3JlYXRlKHN0cnVjdCBkcm1f
ZGV2aWNlICpkZXYsCj4+Pj4+ICAgIAkJCQkgICAgICAgc3RydWN0IGRybV9maWxlICpmaWxlX3By
aXYsCj4+Pj4+ICAgIAkJCQkgICAgICAgY29uc3Qgc3RydWN0IGRybV9tb2RlX2ZiX2NtZDIgKm1v
ZGVfY21kKQo+Pj4+PiAgICB7Cj4+Pj4+IC0Jc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmo7Cj4+
Pj4+ICAgIAlzdHJ1Y3QgYW1kZ3B1X2ZyYW1lYnVmZmVyICphbWRncHVfZmI7Cj4+Pj4+ICsJc3Ry
dWN0IGRybV9nZW1fb2JqZWN0ICpvYmo7Cj4+Pj4+ICsJc3RydWN0IGFtZGdwdV9ibyAqYm87Cj4+
Pj4+ICsJdWludDMyX3QgZG9tYWluczsKPj4+Pj4gICAgCWludCByZXQ7Cj4+Pj4+ICAgIAo+Pj4+
PiAgICAJb2JqID0gZHJtX2dlbV9vYmplY3RfbG9va3VwKGZpbGVfcHJpdiwgbW9kZV9jbWQtPmhh
bmRsZXNbMF0pOwo+Pj4+PiBAQCAtOTQyLDcgKzk0NCw5IEBAIGFtZGdwdV9kaXNwbGF5X3VzZXJf
ZnJhbWVidWZmZXJfY3JlYXRlKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCj4+Pj4+ICAgIAl9Cj4+
Pj4+ICAgIAo+Pj4+PiAgICAJLyogSGFuZGxlIGlzIGltcG9ydGVkIGRtYS1idWYsIHNvIGNhbm5v
dCBiZSBtaWdyYXRlZCB0byBWUkFNIGZvciBzY2Fub3V0ICovCj4+Pj4+IC0JaWYgKG9iai0+aW1w
b3J0X2F0dGFjaCkgewo+Pj4+PiArCWJvID0gZ2VtX3RvX2FtZGdwdV9ibyhvYmopOwo+Pj4+IElz
IGl0IHBvc3NpYmxlIHRoYXQgdGhlIGJvIGNhbiBiZSBOVUxMID8gSSBtZWFuIGRvIHdlIG5lZWQg
YSBOVUxMIGNoZWNrIGhlcmUgPwo+PiBUaGlzIG9uZSA6KQo+IE5vLCB0aGlzIGlzIGp1c3QgYSB0
eXBlIGNhc3QuCj4KPiBDaHJpc3RpYW4uCgpXZWxsLCBhbGwgaXMgd2VsbCB0aGVuICHCoAoKClJl
Z2FyZHMKClNoYXNoYW5rCgo+PiAtIFNoYXNoYW5rCj4+Cj4+Pj4+ICsJZG9tYWlucyA9IGFtZGdw
dV9kaXNwbGF5X3N1cHBvcnRlZF9kb21haW5zKGRybV90b19hZGV2KGRldiksIGJvLT5mbGFncyk7
Cj4+Pj4+ICsJaWYgKG9iai0+aW1wb3J0X2F0dGFjaCAmJiAhKGRvbWFpbnMgJiBBTURHUFVfR0VN
X0RPTUFJTl9HVFQpKSB7Cj4+Pj4+ICAgIAkJZHJtX2RiZ19rbXMoZGV2LCAiQ2Fubm90IGNyZWF0
ZSBmcmFtZWJ1ZmZlciBmcm9tIGltcG9ydGVkIGRtYV9idWZcbiIpOwo+Pj4+PiAgICAJCXJldHVy
biBFUlJfUFRSKC1FSU5WQUwpOwo+Pj4+PiAgICAJfQo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4+Pj4+IGluZGV4IDU2ODU0YTNlZTE5Yy4uMGJkMjJl
ZDFkYWNmIDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfb2JqZWN0LmMKPj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X29iamVjdC5jCj4+Pj4+IEBAIC05MDAsNyArOTAwLDcgQEAgaW50IGFtZGdwdV9ib19waW5fcmVz
dHJpY3RlZChzdHJ1Y3QgYW1kZ3B1X2JvICpibywgdTMyIGRvbWFpbiwKPj4+Pj4gICAgCQlyZXR1
cm4gLUVJTlZBTDsKPj4+Pj4gICAgCj4+Pj4+ICAgIAkvKiBBIHNoYXJlZCBibyBjYW5ub3QgYmUg
bWlncmF0ZWQgdG8gVlJBTSAqLwo+Pj4+PiAtCWlmIChiby0+cHJpbWVfc2hhcmVkX2NvdW50KSB7
Cj4+Pj4+ICsJaWYgKGJvLT5wcmltZV9zaGFyZWRfY291bnQgfHwgYm8tPnRiby5iYXNlLmltcG9y
dF9hdHRhY2gpIHsKPj4+PiBXaXRoIHRoZSBhYm92ZSBjb25jZXJucyBhZGRyZXNzZWQgKG9yIHJl
YXNvbmVkIDopKSwgcGxlYXNlIGZlZWwgZnJlZSB0byB1c2U6Cj4+Pj4KPj4+PiBSZXZpZXdlZC1i
eTogU2hhc2hhbmsgU2hhcm1hIDxzaGFzaGFuay5zaGFybWFAYW1kLmNvbT4KPj4+Pgo+Pj4+IC0g
U2hhc2hhbmsKPj4+Pgo+Pj4+PiAgICAJCWlmIChkb21haW4gJiBBTURHUFVfR0VNX0RPTUFJTl9H
VFQpCj4+Pj4+ICAgIAkJCWRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX0dUVDsKPj4+Pj4gICAg
CQllbHNlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
