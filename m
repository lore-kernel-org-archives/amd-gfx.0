Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0D4C35DF5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 11:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BC521556
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 11:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dCMB+Kng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BC521556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 409566EA96;
	Tue, 25 Feb 2020 11:19:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 487B16EA96
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 11:19:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKLtxrFndkcLwoJd9Ku3xp1HXzpontolMx831idktOes8M+m10QPaRFxiIWtjreYeoOy8wclnCTUrQxxOKs+36T4iczc0UwY6/6Pfmxg81Oq26QmrDOnyx5kXyl9dCINMDTIooeSgz1mJRfBk8DDdT8QNELC3GKqXWhZ/bk1NsCDsc7VmdcoWeDkFfl3C5OemUZk0bfqXkBppW2niQaKfLvC/oCIJnjO+xJu9f2XMALic1kFnz0xvvoL4KkZxkX6J/vdKgglAJJhLMBZsYaWKGNB61+5zAbvx52HoKojUJvi/PLMHYRtVJRlFDC8lWasw8qcUQEBE1VCKU4KXTFzbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4tIjtRa5TC6AP7eCJB2eTnHVvLsriFAYSDP/Hb1hNE=;
 b=d4ApeXze1fDVPzQKdeTKsCor6yLlpkNskat8ayfAqTIep6xs5f8ZWFD6ovheOjj7JVkXpiAMJbk9m2bb/y15+xEARUfLtIswEyNKZNz2NvtQzJBWseDn0DLxrYh0hCGce2/vc2U/BgqZ0Gre27Y21w3sPlvQqbZdMoEeILPFBxbiwbV+XmtTVHjS/TPcKGZTm4YUkmQSSK9Zk+KC08xois9/raC4JxHHCI5z/6nYIlhaASuY/wjxlUOVq7Oy+ZdhqxANfxqmUd5pgNfIp4OuxY8bJ3BU0PB/yDnw9mBFyZG/4aXFPoo/QbSZM79lEnU16BlCwBDSGY+mS+NIBjBHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4tIjtRa5TC6AP7eCJB2eTnHVvLsriFAYSDP/Hb1hNE=;
 b=dCMB+KngCckXp5hrQCt7urk/aoYQtx4fQIf4qCJ8ZH3QTNIwSxWiYv4ndWFoAKXzNM+3CvJ7w7w0PG/azHx4Dq0zT98a+1Llfg/a7Lu/T2FlD+CKT5Y/dqbm8/Rx+u0pIemr20zthMHEztxfN2pl5livw8SOKK+GyL/V3nAnkCs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 11:19:34 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2750.021; Tue, 25 Feb
 2020 11:19:34 +0000
Subject: Re: [PATCH] drm/amdgpu: cleanup amdgpu_ring_fini
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200225111921.14453-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <18173419-8478-1d3f-b9b1-41b42ff67e2f@amd.com>
Date: Tue, 25 Feb 2020 12:19:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200225111921.14453-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0044.eurprd02.prod.outlook.com
 (2603:10a6:208:d2::21) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0044.eurprd02.prod.outlook.com (2603:10a6:208:d2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21 via Frontend Transport; Tue, 25 Feb 2020 11:19:33 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 64f01950-ce69-41d3-5ed9-08d7b9e4976b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:|DM5PR12MB1548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1548926FFC51B999C844810283ED0@DM5PR12MB1548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8676002)(81156014)(66946007)(316002)(8936002)(81166006)(2906002)(2616005)(36756003)(5660300002)(66476007)(4326008)(66556008)(66574012)(52116002)(478600001)(16526019)(186003)(31686004)(31696002)(6666004)(6486002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1548;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efRi9SomKqEk2WkhVgQQwqtp9vqxT6xF2ZVeE3X66tknezT7Rub49HKaqj9yaqbMCLMwnnkG3I6S0MV+avvEkz9rYb5qQTd3sa/znRClsPrtSb+JEGhRNjheapfJW4xpmpueq1Og+gjylQmE5KYMV/bXnG/nRt7u8Xo9EdPjkCHn9DxczbMt4ha7CiflZ1TQB0lFhurFEB1kuQ/ScptFXDZo9y0K0Rb9VBk4ukNCflvsJ88hrBfGZnPiAkQmNkOZmLsDH2ThfpCBPDHcr7YnJ9URdI8Q8G2GcxVlXa2I8VeyVT0JnmNkhqlKnFHwXRsWUk3YbWM7VOq5pYViGvyPq0T75H/3okddcMw75sVHwND2GtY5rkWJ7iBqDSBguDIu9Be7cTEDaGRfG7sGodLGe6a30MU+7QgMtHPCH5x04EsBky2iYsCNYYMvVGvx/TqD
X-MS-Exchange-AntiSpam-MessageData: l5mgKNTCvbgkkVORhl9Qk3HMG2rwBAz3MpofjwMJGc3FVZ9dXUG4p+AQuNeT//gMutyoSG5gYOYOIFd6zL8JoBe75uHaMEdZy6RVZdu9CSTmh5BkYm2sY+tS7kXpiEv7h1b25mQJxDRos8MbYLO3N1kVcjHNbiJo5I2TZdadbiJKEhRUcI6k5YT3jP/uMsh1uWGyQ2eCJYcSJeIp1i/Z5A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f01950-ce69-41d3-5ed9-08d7b9e4976b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 11:19:34.2331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71qChtU8K6BfV31dURk8VXBWGB4YFiqIOYgwYeVJc0pTl0JcydLJkLtCE5IJeIjx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjUuMDIuMjAgdW0gMTI6MTkgc2NocmllYiBOaXJtb3kgRGFzOgo+IGNsZWFudXAgYW1kZ3B1
X3JpbmdfZmluaSB0byBjaGVjayB0aGUgcHJlcmVxdWlzaXRlcyBiZWZvcmUgY2hhbmdpbmcgcmlu
Zy0+c2NoZWQucmVhZHkKPgo+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNA
YW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jp
bmcuYyB8IDMgKystCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3JpbmcuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMKPiBpbmRl
eCA1MzliZTEzODI2MGUuLjE4ZTExYjBmZGMzZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3JpbmcuYwo+IEBAIC0zNDQsMTIgKzM0NCwxMyBAQCBpbnQgYW1kZ3B1X3Jp
bmdfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9yaW5nICpy
aW5nLAo+ICAgICovCj4gICB2b2lkIGFtZGdwdV9yaW5nX2Zpbmkoc3RydWN0IGFtZGdwdV9yaW5n
ICpyaW5nKQo+ICAgewo+IC0JcmluZy0+c2NoZWQucmVhZHkgPSBmYWxzZTsKPiAgIAo+ICAgCS8q
IE5vdCB0byBmaW5pc2ggYSByaW5nIHdoaWNoIGlzIG5vdCBpbml0aWFsaXplZCAqLwo+ICAgCWlm
ICghKHJpbmctPmFkZXYpIHx8ICEocmluZy0+YWRldi0+cmluZ3NbcmluZy0+aWR4XSkpCj4gICAJ
CXJldHVybjsKPiAgIAo+ICsJcmluZy0+c2NoZWQucmVhZHkgPSBmYWxzZTsKPiArCj4gICAJYW1k
Z3B1X2RldmljZV93Yl9mcmVlKHJpbmctPmFkZXYsIHJpbmctPnJwdHJfb2Zmcyk7Cj4gICAJYW1k
Z3B1X2RldmljZV93Yl9mcmVlKHJpbmctPmFkZXYsIHJpbmctPndwdHJfb2Zmcyk7Cj4gICAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
