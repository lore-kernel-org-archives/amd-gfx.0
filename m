Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECC6C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 08:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FBB22078E
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 08:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="awyA8wTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBB22078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97256892A8;
	Mon, 20 Apr 2020 08:27:40 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760073.outbound.protection.outlook.com [40.107.76.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D05AD892A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 08:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQVNdIgNaerJmpjoTvY8YDopJJdLkhNtin31j7fopyblqhuZuN3gYOcFdLzHeUSyAApejLYhStIr3Hc8T6gK7gP36K+KC2UHE1hbcLPVb2AGs9At6H0LOFrcicqj3W3lidRM/aWy7e1sR0IQ9UUICBYenBLWRj/JKIFPheMCTWv0OP/xMM8BQKgPZoat3BN1EMmaySwRh1rEz1UUOAzpWFaYfhqJz9yMjaxm+wVQC9YtysyrR0fb17JR4yPHQWhVae+vxyJvsBJHJYC9B6QywEbSXeoZsff/kCpqDCL2EsgXxI324hXq8vX7X+evEBj+9i94IrX/4hDHS+o5QcA2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP7BfaOe94lpTFZJsr3a9EwmmI2Nl3OgM6UPTaQe/Jw=;
 b=EsAS88h2T5hw83Jox4E77uhBw7fw0lXq3P0BbrM+oK2XMJW189cyVQPefIU7lnMOBDg3iwjeGEbd16me5fkpp6eMH7FIROesS+mcGb8lOprfBKJRpFp+8PHKBZn2RXzIHDG6uCM4F1VQSHLjCLf++7LfHxRJnvh+FBKdeAu4vSj/Yeq0n5dxkbUKuo/Zj8i7SW9y4dqp5MHDI6z/we7DuNEozCLLl40d4O1iDD/3mAQT+KeOyCHJ2HfNvkvyCbYFxya8dMvjpKAX19Uwqqv8YI5YK0+GT0DLieqnzRVkVWQkkoUgCECWOCweQT9HbFL8a978qetxJP17lZlm1eIYow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP7BfaOe94lpTFZJsr3a9EwmmI2Nl3OgM6UPTaQe/Jw=;
 b=awyA8wTPD3OSEdx8mMTYycDjA+hQNqdxN0wHWglfZ1wY7qGY1b14hJQj3ybmP+qPyAhWXZZ8/d8xTh8lubyIHBJ7iWkW+zl+viQDvPNMKyBMsdl9dM8J1EwZ0i/h3nYV2giSy+gdo6w0ADHea3MX7hozCnR7xg5b4S/DA4qzmMs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3579.namprd12.prod.outlook.com (2603:10b6:5:11f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Mon, 20 Apr
 2020 08:27:37 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 08:27:37 +0000
Subject: Re: drivers: gpu: drm: is it a memleak in function
 radeon_user_framebuffer_create
To: =?UTF-8?B?5Lq/5LiA?= <teroincn@gmail.com>, alexander.deucher@amd.com,
 David1.Zhou@amd.com
References: <CANTwqXCMA+UBi15oTcB53RQSqKZ0N39STDiwAoX7Lpg8AEo-Wg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9689fd6a-f45a-9f97-f983-3c9353fac87c@amd.com>
Date: Mon, 20 Apr 2020 10:27:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <CANTwqXCMA+UBi15oTcB53RQSqKZ0N39STDiwAoX7Lpg8AEo-Wg@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0086.eurprd02.prod.outlook.com
 (2603:10a6:208:154::27) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0086.eurprd02.prod.outlook.com (2603:10a6:208:154::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Mon, 20 Apr 2020 08:27:36 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 04555415-af5a-41f7-f67b-08d7e504af22
X-MS-TrafficTypeDiagnostic: DM6PR12MB3579:|DM6PR12MB3579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35790F7892908AFDB390DAA883D40@DM6PR12MB3579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(66556008)(52116002)(36756003)(478600001)(8676002)(31696002)(81156014)(4326008)(66476007)(86362001)(66946007)(6486002)(5660300002)(31686004)(6636002)(2616005)(2906002)(16526019)(8936002)(186003)(316002)(6666004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o5DWytWw9Tf3KyBhHqZjyxrNMG8lAaBLLV6Xzb4hdm7tgg3KVlG6j40PAjhVcgQ7WdH8TxaaawKpv0FAT3OtchQCKwpC5VBaFEHhNK0XBB51koZuCODaAxIZ2L3Gw0dmBFzv2QrmgaaH4q/DD5zHRF00sQ+4qabIr9fkBZHjBA+ZOLCKiyA/5cuGXZsuYnBH7lO+Nhld/47mAAXZaSHyQDoI5ahTKFCJ6f0FJm7JXcmEE6UV/HaZCSmbpyUm0sLrxxcIPcHAjmnYmfYd0atYyx/A4a3f7IMX/IPhBPjhevhZgha/XmOGhdm8N32ZX1089s2sdPfEn4APr9iPZs+tEaKf4c4XiAspg1gX+2TRNCd/lbGU6Awre7S+YncmirQIhZJDwAFSNQNCO7FTMr07Dc6HgSxp1H5y3iE+oL89KVPb+3RabUJTBRp7rBLgnwrf
X-MS-Exchange-AntiSpam-MessageData: xSZR70ENGsxJBpB75NtsqlsEUosVolWhWYYDjbryijLz0GI0Ru29fbuG9wIQUsxNYHRO2HLRqSjKc0Oxe7HMqJexnlhCbaCxZJ00Y8kYLJndknXn8qeVF43/SVMhBvixA+Y3PacC0xOUBcytA9p5xQdtA3WQWUCtycfT6335iI8xqJqEvlL2myF9Hs/3KOwrTcGgb0y628aSa38OqOBjfK3woVFYgrxo/KJk71ZIJdoVV1JoGa/yu3wh6PlKmpzsqC+GYRB/fstEWpf3ulnx2CfUuSqMEYXIb+bc8yMDpudEp5wl365zaVXVZUQD1bgSEyJJ1tN3r1YQSanjzgyQRnUqw+sb3jSVIU24fDhaDh/46N7tYHuIRWnm4grTL45tlC+sp1jbJrKj+ItUv6Bnu9Xri7GRSjHH316Bj3Fo2v5PzvXxFrlyQSMT8ixSyiDeg0ibM9Rgw/W4JlxSq0fdGv/CEHa7hQhOPVkL8/VEjbaZuoUuHj8+zOT8kXrbcwWpOUDCAVC/um3++NM30Ijj3o6oQjGBt6TbCVqWm9HkY+kSbeRHRrQ7Cvx+LYrgL5mo4m9/bFjCBgKYeGD1XGScVh2uI1JOVHHTyr9asiE4P/ABPwQmSpdPcfVfIc96LkdNeer2qWrz4rGeogvhN6PBWsVez4PMA4jL7BhF8+4ra02UDrRP+g65DkWrw/TfgjkxcmmYhKWOP985ugGAvtXmG1ZkiyyhzmNc7NfY5rd4l27hEohgLvOKpCACCv2+8LU6Aq74b9VPbVuzSNmshVQNRvYJm5izXrPW96fLah0dgr1LOGBNmWJJT2itd50n71/grLgeZ9s6JIrAcVty1A8bJnd5oYEE80ZceiHNpPX8bwk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04555415-af5a-41f7-f67b-08d7e504af22
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 08:27:37.8034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4TLdQGpEdDVVtGNt2+FLNPW+Tuj1WJaxpcqeO9dk9rDPUbAiFFwU/bz1458lhW8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3579
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

R29vZCBjYXRjaCwgeWVzIHRoYXQgZXJyb3IgaGFuZGxpbmcgc2VlbXMgdG8gbGVhayB0aGUgYnVm
ZmVyIGhhbmRsZSBpbiAKdGhpcyBjYXNlLgoKRmVlbCBmcmVlIHRvIHByb3ZpZGUgYSBwYXRjaCB0
byBmaXggdGhpcyBhbmQgQ0MgbWUuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgpBbSAyMC4wNC4yMCB1
bSAwOTozNyBzY2hyaWViIOS6v+S4gDoKPiBIaSwgYWxsOgo+ICAgICAgV2hlbiByZXZpZXdpbmcg
ZnVuY3Rpb24gcmFkZW9uX3VzZXJfZnJhbWVidWZmZXJfY3JlYXRlLCAgd2hhdCBpZgo+IG9iai0+
aW1wb3J0X2F0dGFjaCBpcyBub3QgTlVMTCwgaXQgcmV0dXJuIGRpcmVjdGx5IHdpdGhvdXQgcmVs
ZWFzZSBvYmoKPiByZWZlcmVuY2UgaG9sZGVkIGluIGZ1bmN0aW9uIGRybV9nZW1fb2JqZWN0X2xv
b2t1cC4KPiBpdCBpcyBhIG1lbWxlYWsgb2Ygb2JqLgo+IHN0YXRpYyBzdHJ1Y3QgZHJtX2ZyYW1l
YnVmZmVyICoKPiByYWRlb25fdXNlcl9mcmFtZWJ1ZmZlcl9jcmVhdGUoc3RydWN0IGRybV9kZXZp
Y2UgKmRldiwKPiAgICAgICAgIHN0cnVjdCBkcm1fZmlsZSAqZmlsZV9wcml2LAo+ICAgICAgICAg
Y29uc3Qgc3RydWN0IGRybV9tb2RlX2ZiX2NtZDIgKm1vZGVfY21kKQo+ICAgICAgewo+ICAgICAg
ICAgIHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqOwo+ICAgICAgICAgIHN0cnVjdCBkcm1fZnJh
bWVidWZmZXIgKmZiOwo+ICAgICAgICAgIGludCByZXQ7Cj4KPiAgICAgICAgICBvYmogPSBkcm1f
Z2VtX29iamVjdF9sb29rdXAoZmlsZV9wcml2LCBtb2RlX2NtZC0+aGFuZGxlc1swXSk7Cj4gICAg
ICAgICAgaWYgKG9iaiA9PSAgTlVMTCkgewo+ICAgICAgICAgICAgICBkZXZfZXJyKCZkZXYtPnBk
ZXYtPmRldiwgIk5vIEdFTSBvYmplY3QgYXNzb2NpYXRlZCB0bwo+IGhhbmRsZSAweCUwOFgsICIK
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiY2FuJ3QgY3JlYXRlIGZyYW1lYnVmZmVyXG4i
LCBtb2RlX2NtZC0+aGFuZGxlc1swXSk7Cj4gICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT0VO
VCk7Cj4gICAgICAgICAgfQo+Cj4gICAgICAgICAgLyogSGFuZGxlIGlzIGltcG9ydGVkIGRtYS1i
dWYsIHNvIGNhbm5vdCBiZSBtaWdyYXRlZCB0byBWUkFNCj4gZm9yIHNjYW5vdXQgKi8KPiAgICAg
ICAgICBpZiAob2JqLT5pbXBvcnRfYXR0YWNoKSB7Cj4gICAgICAgICAgICAgIERSTV9ERUJVR19L
TVMoIkNhbm5vdCBjcmVhdGUgZnJhbWVidWZmZXIgZnJvbSBpbXBvcnRlZCBkbWFfYnVmXG4iKTsK
PiAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7Cj4gICAgICAgICAgfQo+Cj4g
ICAgICAgICAgZmIgPSBremFsbG9jKHNpemVvZigqZmIpLCBHRlBfS0VSTkVMKTsKPiAgICAgICAg
ICBpZiAoZmIgPT0gTlVMTCkgewo+ICAgICAgICAgICAgICBkcm1fZ2VtX29iamVjdF9wdXRfdW5s
b2NrZWQob2JqKTsKPiAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4gICAg
ICAgICAgfQo+Cj4gICAgICAuLi4uLi4KPgo+ICAgICAgfQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
