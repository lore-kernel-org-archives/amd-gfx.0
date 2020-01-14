Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4D6C33CB1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 10:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80F924670
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 10:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wZFifFgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80F924670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BDE86E34E;
	Tue, 14 Jan 2020 10:22:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE3F6E34E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 10:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCjWOKSppR4rsxrAcCj1v7wlOi7QaJGjsuUk9Hp/gClepD1nxAwVaH2gYfSS+knElCbUI1vkYSh1Aqjv2TuV2B/GzBs/Ik1N+uYYUSzpgzioWWvGBQmbyif0gUyL76x7l3aSf8pFbbRjwAokZxd60kB2JmGel1EoK9sKdVTylbRVAjpqfnFOKWlXpY4MWMAtPKLckxYZqZOay+EZM0Yp3MqSCfOGuFVKBkfr1bOyFVwrOdj1hjX1y0hdVfMJcJB+w7tiwZO9J+19t+bUlnFYID5T91c495ehA7LreU9+DHS0eOGAfrmgxfnMIfSVwlzQkbYqvwxZM/GB8dJlOjRF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9O5NNVSQMvo+oDvrA5sLF9Ektogn3ExcgxQalAs0IM=;
 b=XyamIct8zkl6/V2xx+Mx8CN+TH0JlXAzUnkFH2OFIMiydxbn7OkRsp4iSBZU/Q6Sh0/KxI7y424oEhqqG9WVz+9TGldajycxHKyVYjGH3+6tgeJ+mAg5+tEa9bqVIE9qipFYqaGUZVk+x3I4wz6mSKav0ipnpWHd8abOD+3g2w/BUq7HvOnpCjiF+lt8dy5gSJsdS2bOr6/WTxan9CFgaX4K7FcTbZb2RwarsdSObQybJVCtPWbnC0srOtyUi95Su6NHU4WCuHuxlKzCGlOjEp/EdrY2zRlqphDk/Zq+MBKZbd+EKxNaYhOegjRC8VZ2yowQxsmz/PJCOGa5O2o/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9O5NNVSQMvo+oDvrA5sLF9Ektogn3ExcgxQalAs0IM=;
 b=wZFifFguvGlzCLOCXbWrudkoEWy/XRD/DoCr5Yyx9Jpz41aIgLu0+1uZbU2loxHbxSlmReCXELTawp4V4vyFrHrXGcSIZGGx+smLZnKi276JTgdNtrMg6oWQUbmohfFNu4JzoOLndI72pm0rqgiS0sj0rYUpPedxBpHKeVrqDEg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1403.namprd12.prod.outlook.com (10.168.239.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 10:22:49 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 10:22:49 +0000
Subject: Re: [PATCH] drm/scheduler: fix documentation by replacing rq_list
 with sched_list
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200114095819.8373-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <38f1780d-38ea-dd5f-0ab5-eca3d1f7ea47@amd.com>
Date: Tue, 14 Jan 2020 11:22:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200114095819.8373-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR08CA0071.eurprd08.prod.outlook.com
 (2603:10a6:205:2::42) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR08CA0071.eurprd08.prod.outlook.com (2603:10a6:205:2::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10 via Frontend Transport; Tue, 14 Jan 2020 10:22:47 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c8f793e1-8983-4f6d-e6b0-08d798dbb453
X-MS-TrafficTypeDiagnostic: DM5PR12MB1403:|DM5PR12MB1403:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1403BF96536A25FCECA2701F83340@DM5PR12MB1403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(189003)(199004)(66556008)(66946007)(66476007)(478600001)(5660300002)(8676002)(86362001)(16526019)(6666004)(81156014)(8936002)(186003)(2616005)(81166006)(52116002)(316002)(31696002)(36756003)(66574012)(2906002)(4744005)(6486002)(4326008)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1403;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VDNNDUGugYcIekVevudTMROM4d3wq4kpj2wm2qWoMhDMaUqPqkAPrxzC9sJoatDpIl5LTrCTOPWBd2KIZROSrG5atFnReRkV4In5Gg3EU7vnTxZ5cbBYt5cQW/XUImM1Ti5S3/12pZkuWSGAtW/IoWZeY9jbkDphfutx0bXx/C13byzfwbNgag5opnCgYQ6m7Y6Ra1PrSdA0h4AS+irf0C1hRzrZIvO2jw+26sECVJOCw9yqdF/0yjjcYJeOZHFJ2u/rWlNvHNzlNdljXsSGA9py6n1Im3d3aYOV+EP6UqRbf0A+0cr7u0sqghSqgM9OVn22qWuzOb9HkXajh9a3ZNmd4gcXoYqRmr3i9cnvzHoik7dmK3H82WTeuA7BGORl97RkfDSZKpoth0P8Ss1fZO8zWMISyPZIqpaIg+pTeUqYK7ToQtXARp8C8/U2VbG7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f793e1-8983-4f6d-e6b0-08d798dbb453
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 10:22:49.0250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yma/7zFNhHBLuLVuh49pO6xAtdBwiiHOeUzuANMZHRQ8QqmyudlJHMyZPAHIWI9K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1403
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTQuMDEuMjAgdW0gMTA6NTggc2NocmllYiBOaXJtb3kgRGFzOgo+IFNpZ25lZC1vZmYtYnk6
IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVy
L3NjaGVkX2VudGl0eS5jCj4gaW5kZXggMmUzYTA1OGZjMjM5Li42MmJjY2E4NTVjNjkgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKPiBAQCAtNDUsNyArNDUs
NyBAQAo+ICAgICogQGd1aWx0eTogYXRvbWljX3Qgc2V0IHRvIDEgd2hlbiBhIGpvYiBvbiB0aGlz
IHF1ZXVlCj4gICAgKiAgICAgICAgICBpcyBmb3VuZCB0byBiZSBndWlsdHkgY2F1c2luZyBhIHRp
bWVvdXQKPiAgICAqCj4gLSAqIE5vdGU6IHRoZSBycV9saXN0IHNob3VsZCBoYXZlIGF0bGVhc3Qg
b25lIGVsZW1lbnQgdG8gc2NoZWR1bGUKPiArICogTm90ZTogdGhlIHNjaGVkX2xpc3Qgc2hvdWxk
IGhhdmUgYXRsZWFzdCBvbmUgZWxlbWVudCB0byBzY2hlZHVsZQo+ICAgICogICAgICAgdGhlIGVu
dGl0eQo+ICAgICoKPiAgICAqIFJldHVybnMgMCBvbiBzdWNjZXNzIG9yIGEgbmVnYXRpdmUgZXJy
b3IgY29kZSBvbiBmYWlsdXJlLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
