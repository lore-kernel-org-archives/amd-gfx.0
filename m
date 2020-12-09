Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901B0C4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 13:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1945A205F4
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 13:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1945A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C966E176;
	Wed,  9 Dec 2020 13:40:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA5C589BE8
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 13:40:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgOakAoodfTv8d1iYidIKb86phXfkk9I2mJq42sAU8DHKr3g6bHNtWeYdcggGojUOOLmqi8mmVLLvh25mW+MCn2F80jfcfYovgzuzki1mUqjK61CZEF262giHWQusZoKy8KTpGviDQ0msKJTM3uh4/ha7LNu1Fa7rLEMo6NJatKSImsPGirBTdMBRrVFfFZD3i9QsusaqCIqmUei+wrhndvmRvrURPOs3tYh4L5Zr1DqVjEUSiTAyAN567yCNBZ/rjok489wm/3TfgwXgtqTyKFKkNH0B6LPnUmdqTuIsYBM99rb7naDfVBVHn0Hy6YHqzMmYamh3z4jT9jUGNKD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpGsZmQSOIS5M92cnX3j1ihX0vtF6A44WUr2geCAcZw=;
 b=gTS8xfMpxOWZaR53DwWx08t7yVFLMpcpGqRL9vUud5m0NTMYxv6/6DqDE6ceKIOBOxkNORKMH6Wlk4reWmuuScvefJjAlo01URjsfLSfcZh3O0KVNRMs+cUNGZlxlmZparXR1A+AyUvtsSWEWpX6eHcEhGsrO0+Qbppa3Mswu5qTEpUuXtR6MkLrwZ6nAwevbc2pMEN12InBW6PRLnGFUsvWgYeWLRVJ38ycHXE01cZkz2EbD+f1ly3bl47gkZn2BoCOlxHbSSO1eK18p0geAsS9lruG9blo+KZZL5bJjQu03pjtgHbx/9P0jSmLVfijqzUX7cLKHt19zucZy0IXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpGsZmQSOIS5M92cnX3j1ihX0vtF6A44WUr2geCAcZw=;
 b=GdWI8aY8UaxXCbIzJEXp2dhk9/E+7vS1ex4lxuT3mJe+NA7kk7hiI1mNdMGwcyaUBA+bWq4AYvjltVHCA1NTyqOxFPNryd83YoIdcQQrtJZEZW1sdlqHj4AEtCFAvcMPvpLJItLbNadELsHauVxDN58dejKj6MHozu+G9KIOqzI=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.23; Wed, 9 Dec 2020 13:40:07 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%7]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 13:40:07 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: correct pipe offset calculation
Thread-Topic: [PATCH] drm/amdkfd: correct pipe offset calculation
Thread-Index: AQHWziK8COmEX6qZU0G07MOu08ve9KnuxBvA
Date: Wed, 9 Dec 2020 13:40:07 +0000
Message-ID: <DM6PR12MB407503A705E5831DAA2D37C0FCCC0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201209115911.30391-1-Jiansong.Chen@amd.com>
In-Reply-To: <20201209115911.30391-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-09T13:40:05Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=75913eea-0b32-4c9a-a12d-cd09a9f56899;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40267e63-0a56-4b2a-6dd7-08d89c47f10d
x-ms-traffictypediagnostic: DM6PR12MB4155:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB415562EEDA867F542B1BADBCFCCC0@DM6PR12MB4155.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XH+9qqF3vQkhyX4t/VyOfzO3nAAsddR598kFEkCcWUp90C3Y3+Qj3S8MjVo98DrZG3bBzKcSu5kI2REmAfpiERJm8SVQo0NunWCQK7xVvDuvLwjovPYhG6zgcsyUfjl+NY3L0E9waPRTTQveln4iLRR3A2GfnjCAA6bMn04PkcUAW7LRpy7O8rM9v71RWPDuP3oqGWJ9MO9e4rFAbLQeoxJjvfegpUR2IwUhkhRLLnf/v3S5A1xxuHkYB6MOn5iEZmUVr7riHYPJK/8xapyAf3DWfy2BnWsC8FHgRczlWhdiNesq4kf72Jm3IaGUqAujVwGIyKsa93AR/q5vJNUyKw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(64756008)(110136005)(8936002)(8676002)(186003)(66476007)(66556008)(66446008)(76116006)(83380400001)(33656002)(55016002)(66946007)(52536014)(7696005)(9686003)(53546011)(2906002)(4326008)(508600001)(54906003)(5660300002)(26005)(86362001)(71200400001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Wj1Xv2nZN8kLObWBM8h+26U/3O1gEPKQk8V7pbXLrx6GOjrEJIu93yCJR0cw?=
 =?us-ascii?Q?41FMRv77pXS2Bf25g2uXrxXUiCPPLLkaTMZi50pgUSUnsWSoTHO25VmCArkO?=
 =?us-ascii?Q?4eirL1hC0cL2HGoW6DAZ0VNXPd9jHSnkQfsKjagY9YFTVL588tQ4Ksi02ZMD?=
 =?us-ascii?Q?8K26LUuGh3KwZjllaNqfqtHX93AU0UnQy2K2ehWv3BhNfOtp2BBm7hu9UmaO?=
 =?us-ascii?Q?ZtIHFphdpIE1Rxw3N79d7GWKrAGOo08SHG53SWH5w+2n3Dh53jOK8gCAwLfN?=
 =?us-ascii?Q?TEJzzlFQYTaD+tlo9HL/0wqfwOWzibvlUyVTvT9loYzZEcI23ylg6t1kHSF9?=
 =?us-ascii?Q?NNO7NTLTa8yuV4Tv0KGmK/BYEo7Rq/fIkPyzKWEW1Kg5yI5RWn/4re/YAL8P?=
 =?us-ascii?Q?5dMS2iqeKp9RCtSwvJY7wvhRzhrZ1+ZxebPY0w76iapw67kHc+yoj4PdghtK?=
 =?us-ascii?Q?hTVt/Zv3zOymnKP1P9z6qpWK+hnz6+ZD6PsWYORAowH+4iwhG2OHMQJCm8do?=
 =?us-ascii?Q?IZeEiackEV3kRBNlrYZ6jKkZPOc7J+4Aud4FZOMxu1ejn1drw6TXPImvN3jL?=
 =?us-ascii?Q?m0wAdjXi5f+/JPv+si0johciMCGRDUGu1Hn2VT0Y5hRmDhBUuso833YrdIe6?=
 =?us-ascii?Q?mizYn5gD6qx+Y4H/iQaSDOJi0qb2PL8hEtvp84NFlzdZRrL6iYmUjQvGeJuy?=
 =?us-ascii?Q?xP7sfiGxQBSGFhCXkB+hJ9K2wWQ5IJcXa95mXDlf54ssTVN5BvMWBKqREp2C?=
 =?us-ascii?Q?0kOX5Es5MbaKH1PHV6moCs+D962VRohzQfHC4by6uNHGRIXpi1nGPg+I3z2z?=
 =?us-ascii?Q?jlUCWQB5Kc+6ZTZOYVbPhW3BjoapsCnKxS0hboJPQfq/4QtDyqF8SRtAjDmC?=
 =?us-ascii?Q?lCVeN5FGAfwvs6kKxnU6f0rZ1Vmnf1lnxOoeuZ4RPxgTIeh221M36VuSoykQ?=
 =?us-ascii?Q?fFm9zgSXmaFPjzWyzFP0lPQUblfxhQcIhD4HUsZ+V0epba8poPCTafwQnqr6?=
 =?us-ascii?Q?M7sl?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40267e63-0a56-4b2a-6dd7-08d89c47f10d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 13:40:07.2650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUdzLE30kCij6EEevZ9yC0RLDfP/zb/j+qV7NkraDhZ4bRUjUxbkcn1HEnN9d+7vZiLRmTcUpFPfutwt7VyuyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Good catch. I guess we are just lucky that we always need to specify the mec to 0 in real use case.

The patch is 

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com> 
Sent: Wednesday, December 9, 2020 19:59
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amdkfd: correct pipe offset calculation

Correct pipe offset calculation in is_pipe_enabled function, it should be done in queues.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I826aa532ca1e5073e3329212a8096f8f5a0be057
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c579615451ba..c37e9c4b1fb4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -72,8 +72,8 @@ enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)  static bool is_pipe_enabled(struct device_queue_manager *dqm, int mec, int pipe)  {
 	int i;
-	int pipe_offset = mec * dqm->dev->shared_resources.num_pipe_per_mec
-		+ pipe * dqm->dev->shared_resources.num_queue_per_pipe;
+	int pipe_offset = (mec * dqm->dev->shared_resources.num_pipe_per_mec
+		+ pipe) * dqm->dev->shared_resources.num_queue_per_pipe;
 
 	/* queue is available for KFD usage if bit is 1 */
 	for (i = 0; i <  dqm->dev->shared_resources.num_queue_per_pipe; ++i)
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
