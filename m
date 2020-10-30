Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD81C388F9
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 11:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD8120728
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 11:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VV95sLkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD8120728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF396E9A5;
	Fri, 30 Oct 2020 11:06:29 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760059.outbound.protection.outlook.com [40.107.76.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A45236EDAE
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 11:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f30Oox6ene7IDo0wD20U5BskyVEKDmTZ6RSFrPnxXexvmU26f91TQd6RzgIPcCstC6cvfF/weCLk7gMCBvn0lTE2dtoLrQTDsjsm8eJkdvq0VZImTtOAauh7UqE/a6s/mz4A837Ajzf8y7dhQQovQU9f7Yeh4/2D2D7vWRB9QcXifQjfj6/hOXJJlu9aee0oAyE+DHUbCrHY6MhO1KLf5HxCc494C1hvycSVouFk/82xjsg5XYXglmR593BmLfRP8bgFkeXT6z+5yaYsXOUIOYLbwKpXjtDhx9jinZbYsxpxmqYSgma5FhDrUKCb/CmWWnWlIBUczVOWAqhP/oZ3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjZOsW1HesMKdaI6IxPGKo0UfGOdSInA4vpR+97B1fE=;
 b=TE86FcG2hU/SEXHQsZOU90hD09hytUJ0MpHIrraI8iKAAabpvYGJVL0zM5tR8C3u31RiO5ZIGaprprycGDDGh14AJV+DWXkWO36uDU5bvHlx4+vvRrh6P5KpLQlAV0KtbQscPE4PdWvsm2//kdgrCf62PcIdvDV3gobFXbPh6InDW8mTaKcht6ZmpkQkiQfh2S1AzEo0q0dcl2ozBd4F5jreE0sHnJ+KaF+Tdi1PlK370wT5JTYIXY5fw4X7BXojhaxQwYgCX42PQQPXpx6BYQOTiGy9DVaPJzyR0TcQ/tQwfv9J907YA167bartF6B60x7ciQp5j2lkQBxABFjB7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjZOsW1HesMKdaI6IxPGKo0UfGOdSInA4vpR+97B1fE=;
 b=VV95sLkHHcNC/YW4ExSmx6x1SJd67/NNh2EAbUER+noLaaPvb0XE27O+BbIg8W5L0oj0+gq5A4PAaRaULKg02DyjrZplfgEfikifWGvCr3AIOwD0TW6Cs+A4bo38C0a1Lk0miND196NZOk3MqRUOPW6IUAEhMUzD4kLe70XBBsE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 11:06:27 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::21a4:4ed1:c6bb:5437]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::21a4:4ed1:c6bb:5437%5]) with mapi id 15.20.3499.027; Fri, 30 Oct 2020
 11:06:26 +0000
Subject: Re: [PATCH] drm/amdgpu: apply dm_pp_notify_wm_clock_changes() for
 Polaris only
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201030110445.1662217-1-evan.quan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ee27f030-05a6-6a21-94fd-c70e53325de5@amd.com>
Date: Fri, 30 Oct 2020 12:06:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201030110445.1662217-1-evan.quan@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR02CA0010.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::23) To BY5PR12MB3764.namprd12.prod.outlook.com
 (2603:10b6:a03:1ac::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0010.eurprd02.prod.outlook.com (2603:10a6:208:3e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 30 Oct 2020 11:06:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b99c453-9e1c-467d-f0cb-08d87cc3d87f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB408440AFF850FFD57B6C7B9283150@BY5PR12MB4084.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcQFdpTapWfeoTzBzc4JDuXW1zsn8PYveB8Bt2g3N1sL6HUbsR8PGncEXPFZEVKtIblOEpGKkVik20byJD6Z6h3mYpRzTii0HqHhYM0QLbNZlE+3b2lhtoGNqvfZJJvm64VVcF6aCS6SzhwGzvlkt8M4iX4guV73b98SJ24LBsTlppCQenVJfPOceiE/omFbNDi8F22ZyCSXICGizCSbQiermr9Ue4oMcqERWs/mknYhFVLiA+vtohhfN2at1hhWQaeEPM9xE2T/JTKEIzGup7c3HY4pk/uOQGwQXTZx5hVUYEiu8GwhIgAOvTF/0YtrrrB6/l9ZZieF6wy2QnU0kWznkb94Fcw2UqupwwLgiYjePqmIspzbk0HJjY5F8y87
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(6666004)(6486002)(52116002)(478600001)(186003)(16526019)(4326008)(36756003)(316002)(2616005)(2906002)(66574015)(83380400001)(8936002)(86362001)(8676002)(31696002)(66476007)(66556008)(5660300002)(31686004)(66946007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uKFIie7GHTRdBBcpMA+fBCGcUOu2CJK6KJX1Ppy6R9N8u7Kc2SY/1qC0ubp4bw5laR22VWkjg8vgRQ6/qk/0FcXjEhJ3fDRCAExdrDkf1/OwGJ51IxlzSzgTk5wSnFpAZAp+VHNuYgwjeSu0X2HAENjAKxCI0uirlG50sXs9LH733Ce5ujMK9h194or4lmQPk7lgvMncyPkXmWmgATDZHSEDdxFkWhKFbQbjs6Nav8zRqkWQSjEmI8VQFcNQHtQNmG9NODUdXif9EiPV+ULjFptuU4FDwfYUnEw++ac4SJQnWPC5VFGvPyeYryLtUadSO00OmZjlkroPW7+7iy8Zm5/+QlFBkDcJ0RU5hthg0IH2ElnQvLn3k4CN73sbpIyrJFR6M7pRrBd2RXmDI7LhcaUUgRY+v3BJha0zRPegHGwQPD/GPJmBEdWe7EsuP/iP9HmPth+yDlPRtJIQZX9um57JlUp86yIcFkoiHhD54EZcrYY8sQIHDG0wdlnZnKRc2CXuPtvxFaezsYyGNT24g8ktyvOl9YakylgAmLCr8wwZ4MpmqUGCqR9ibQFw+luCq4fi6Mf39qNIpfR/+b9HlP8FK8N7UdJ2JLPp19rwtfxm799iU3oOz+i6O2ofhgMSo1qEICiGtoyAuLX71L12L0wsUkv8Q6PjqEen0aidzAb7nys49PabDxHVvz5WHvA3hjXhU3l4CllqlaK4vujD3A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b99c453-9e1c-467d-f0cb-08d87cc3d87f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 11:06:26.9453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUveGDKB9UFpqVUYxEoogyevYdOnEjg6BFcTdms36AsymoJEPhpFUAlbCOLN76Hw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
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
Cc: Alexander.Deucher@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMzAuMTAuMjAgdW0gMTI6MDQgc2NocmllYiBFdmFuIFF1YW46Cj4gV2lsbCBleHBhbmQgaXQg
dG8gb3RoZXIgQVNJQ3MgYWZ0ZXIgdmVyaWZpZWQuCj4KPiBDaGFuZ2UtSWQ6IEkwM2UwNzRlYTBl
OTIxYTk4NGViODE5YjIyMmU0MzRlODg4ODhlMzc1Cj4gU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFu
IDxldmFuLnF1YW5AYW1kLmNvbT4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+CgpJIGFzc3VtZSB0aGlzIGZpeGVzIG15IGlzc3VlIG9uIFZlZ2Ey
MD8KClRoYW5rcywKQ2hyaXN0aWFuLgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BwX3NtdS5jIHwgNyArKysrKystCj4gICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fcHBfc211LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9wcF9zbXUu
Ywo+IGluZGV4IGZkMzlkZDY3YmZhNC4uODQwNjVjMTJkNGI4IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BwX3NtdS5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fcHBfc211
LmMKPiBAQCAtNDYyLDcgKzQ2MiwxMiBAQCBib29sIGRtX3BwX25vdGlmeV93bV9jbG9ja19jaGFu
Z2VzKAo+ICAgCXZvaWQgKnBwX2hhbmRsZSA9IGFkZXYtPnBvd2VycGxheS5wcF9oYW5kbGU7Cj4g
ICAJY29uc3Qgc3RydWN0IGFtZF9wbV9mdW5jcyAqcHBfZnVuY3MgPSBhZGV2LT5wb3dlcnBsYXku
cHBfZnVuY3M7Cj4gICAKPiAtCWlmIChwcF9mdW5jcyAmJiBwcF9mdW5jcy0+c2V0X3dhdGVybWFy
a3NfZm9yX2Nsb2Nrc19yYW5nZXMpIHsKPiArCS8qCj4gKwkgKiBMaW1pdCB0aGlzIHdhdGVybWFy
ayBzZXR0aW5nIGZvciBQb2xhcmlzIGZvciBub3cKPiArCSAqIFRPRE86IGV4cGFuZCB0aGlzIHRv
IG90aGVyIEFTSUNzCj4gKwkgKi8KPiArCWlmICgoYWRldi0+YXNpY190eXBlID49IENISVBfUE9M
QVJJUzEwKSAmJiAoYWRldi0+YXNpY190eXBlIDw9IENISVBfVkVHQU0pCj4gKwkgICAgICYmIHBw
X2Z1bmNzICYmIHBwX2Z1bmNzLT5zZXRfd2F0ZXJtYXJrc19mb3JfY2xvY2tzX3Jhbmdlcykgewo+
ICAgCQlpZiAoIXBwX2Z1bmNzLT5zZXRfd2F0ZXJtYXJrc19mb3JfY2xvY2tzX3JhbmdlcyhwcF9o
YW5kbGUsCj4gICAJCQkJCQkodm9pZCAqKXdtX3dpdGhfY2xvY2tfcmFuZ2VzKSkKPiAgIAkJCXJl
dHVybiB0cnVlOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
