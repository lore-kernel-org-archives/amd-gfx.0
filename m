Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9126C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 12:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591AA61040
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 12:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591AA61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4EA86E250;
	Mon, 10 May 2021 12:57:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D05A26E250
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 12:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HERQRVBfa/VPOZFzLINYLHjuofj5y0yNhT/mhgwh5K0I/4STF9aineu3UOcBalLs/ImewvcnAyyAIhwoe07d2dBfxHBnvRKcmDFxEIcS9E+7I8zEVtLexYhzr9EkdANeaq9QPnXPjCHVAsdVAJeyG8FrAKMtJPizvFadJ6DNOP+B930Q+KRO42xYGqdYvEjWJH1tzOcsc+mtCXPLpxNwSUbQUBH7G8LF+vC63xqWiEtRlt4asVJBEgXyTN+PLUkQDcmx6/mzFO1kIfmxte5LpnDZ2uBfrmxW7PBPhs7zBMq27RSdb9nHyAUOO8sG774GlSunUn5WJovlO2d2Rbe0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMLQa9MmkU5hnjLj9qEnqzaKSiQ2fFu9UfW0jFyEVwE=;
 b=WVjAgPrZ5TItc5xrNL8aRtWrLgi5BTabICV11JhftzPCyiDPbn5EJML8f8Llho4eMQKLHrNXegVuoIS9HXoad4QRn7zquvnQlxLXtmzlS/BJbOSKk68QJPFOUvFdz3knsFQ4tUM11x7aRx8+1/88X/JqJmcEUdVVr83w4dj/txxl/xqKfCZ2uUBDGVCPAw1Sgpz34bU8MmOQv5CTZGQx5C5WXKYa/+NhAjh+3FfKKb0IIZRfqlmoNTeMortowByc8G18xvHCha5+IlNQIQIPPiNSvckNZJbvmaY2rL3VE7CAGVEBCFqHx2mosP7TsOnRkkUCBs2rydSeZ7oHEnEboQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMLQa9MmkU5hnjLj9qEnqzaKSiQ2fFu9UfW0jFyEVwE=;
 b=NtWXX2Gc7oO1zqQFB7mt1jExYk1474fIYXf9Kgzut6NtuS6lMqBkvfuS17FLzsr9jP5s/zmN+/Ai27BMUDPaxZS51RFQFXgdygQ6EpUoUvxj7ojCcF7V9ALIbXaoDnQ1ZCRIXKkf1cI6LQQ3CO8PEy3supzsY7N6kMXiXXjhLWU=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1510.namprd12.prod.outlook.com (2603:10b6:910:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 12:57:52 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835%4]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 12:57:51 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Shi, Leslie" <Yuliang.Shi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: avoid undefined return value
Thread-Topic: [PATCH] drm/amdgpu: avoid undefined return value
Thread-Index: AQHXRYK3Yji5MqokpESzgg8NLfXTeKrcrOlg
Date: Mon, 10 May 2021 12:57:51 +0000
Message-ID: <CY4PR12MB128710529F050C6D516B84BAF1549@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210510095601.2091-1-Yuliang.Shi@amd.com>
In-Reply-To: <20210510095601.2091-1-Yuliang.Shi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-10T12:57:47Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f793670b-a5b4-4310-8a5a-20d62a4abe48;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [101.229.235.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee5ed474-1cf5-49a0-d0ae-08d913b3388f
x-ms-traffictypediagnostic: CY4PR12MB1510:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB15106908F1B20B10269FE54CF1549@CY4PR12MB1510.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y8URV/Ram9d3N0DDbfltFvgsujfvx0xGpvE5zCUbkxnIOtKKxRgq24cJM4ixClsjygOs4cZ2vyLsYPBcLcwOhB2A6huJASiLA8IeQgmOUhOIsVHSdG7zjRLdyj1QmKqQQAmwlpFIQSwJP2X5PDL5mNGJD5w7bhts7UpL/AdykkjbsIzMlHgX7XJbXWUuEp1VRUqB8AHcUgHjgIZde8fa2iy8RneHXKpvDtq3eZdaw7KR5A588DXTP5JbpX90NNYmE5s6v4dVOlik9euzgQwYrePnpxGhrm9URHz7LWYMMmqfYFD6UVWXl9x+MVhBtFCXiWhA8oBHduFIWxWt2HOiVQzf0kdnF9M6EptnyR2yhRefV0PFpQ8SOzmjY1r42Suz8tQBHLXhXyFpy12WjLOK/9O9GJgX2vPIn7mjLCkVdxFL5aikQFBNCClF5EpwVg0/oQ3bbfvqZX1lDeX9aw9x4zwIgLJ1qik4wOUr7eRIAFnMajZdD1dm/hdYiBJiUHMZCLl41ErBbAmOQUdAP0JJLhEsJ0DjGi/l1CUrAAe3yTeDYL20yIroFoD2RA5qKtOxQq79apnAFZPcCZD5HtZD/zJWGIgcDdnK73tEzO8pgrk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(39850400004)(136003)(110136005)(316002)(6636002)(76116006)(66946007)(186003)(71200400001)(26005)(5660300002)(7696005)(38100700002)(66556008)(64756008)(86362001)(66476007)(66446008)(122000001)(83380400001)(478600001)(52536014)(33656002)(55016002)(53546011)(4744005)(9686003)(8936002)(8676002)(6506007)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ovKe2R/poRGVSdb97GXwyP3VPndO40gF8sj0RxxTtUGUFny7Ri2Q+G/wUBba?=
 =?us-ascii?Q?Jb4dJYTqMOovhtWQW8DOZe2a0c5vy82wXZCTOtAIuqq16mzr3i9RbZLfGAfp?=
 =?us-ascii?Q?LZS/oqsH0SmVpPiLBo0DR3eUEqtGHaImAEKIRZPD74/wvel2zS2VwHJMwHqe?=
 =?us-ascii?Q?zg+v0U26g++Ob8s+SN8zoRTaM2dX4jsSH7NWqWuoFoY3NtpJrAK1oqYLGp4b?=
 =?us-ascii?Q?7Aa+EKA+vpqb1Gqort739wyHrDNgx/BRevUMRFX1jcJQaNbEaOa9ApfWFU6O?=
 =?us-ascii?Q?VpjnRQpdfvSmXnQSdPGFYJzFCdQs3qSM072XLp/MFOqn1pyeko2jCYB7jO22?=
 =?us-ascii?Q?kJtULHL5SB4f7pjwIxMqb/3sfRSvTM8MQ39WXYgZS1G6nHqWBhxCitTTFHvf?=
 =?us-ascii?Q?ect37tk4I+2AEqnI7mlvKXr7gW8FjtPUi16c0xF+WYAC0PGLbcpKTQ5mCc/O?=
 =?us-ascii?Q?fiq77OCdM1uAnyZmLmfkiDIH+7UtrJhPdo5g3n012mEGcymew5smyJdH/CDJ?=
 =?us-ascii?Q?Qs+wre21OfNlw7Gzp2PRGWlwvy22l+cYa4GUJ3p9v/2IktlYx9xRqc4fc/IC?=
 =?us-ascii?Q?8oyUBHgjRJpSC8bF5wIfx0na+Eh/VWrcK0/QkvrCdQt0CvmrpionNABleBAX?=
 =?us-ascii?Q?fNs8KRI8RUiafeWhXUoyCiKobm9idkKuPkSayezMRL4cHCgqR6R47Ock81/6?=
 =?us-ascii?Q?EdBRcyGdZarV8NARvoqNHLujOvUw1BlI/HuEWoYbQY2IqjjbMAjv+YY9kXLh?=
 =?us-ascii?Q?/2YHi5dnit+K77KER5+JYwZ/rpCDGPUGk650dutz2pXE2aND3/QugZMbKp7A?=
 =?us-ascii?Q?ZAaA32wByG36oJFUr+20U0XQoabtb4tcGFqmFe4f+C8bL0Lb9h1puwide7Lo?=
 =?us-ascii?Q?n1p69Kvj/3SilZjO1a3W7nE/qYQPSdW0roSAqB0LWSK0kqcNnsVD/d6h9EM1?=
 =?us-ascii?Q?9w/o33+PWKiPjMdFkfuq4OmGrOhKMh4mhAE9yHnVdrTtbTbPgejpGJaCHF2n?=
 =?us-ascii?Q?tJYyYJRgMZy3gQO+/7vua7LBU3QVjq9vjjTYxi247NujJFCVC3kk8lKlKYLg?=
 =?us-ascii?Q?htuTrjzbwxvVgzCKMoUmpf1vIlOl2xqTIthIYyLBDDzj9KzdDXbet9NLItg3?=
 =?us-ascii?Q?yJ18bCKwQPbq0wdTwmnAM4XJge/Y/s06n1LKPT/Gv8DUyqlSx7umGTw9Wx8N?=
 =?us-ascii?Q?HbSZYAAApN29xEF2sMoHSY4u6WAhrzGmYzbRcMNxLDHySRrKYM6r8JxsnKoR?=
 =?us-ascii?Q?eaEq/nna6vtIXJJ2BYZo8yNip2Lsn0HToXvOjnm50dZ056jNgmcfaTeA7aDZ?=
 =?us-ascii?Q?nZNBjO8bb8byC/9+Pq6ZJLMB?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5ed474-1cf5-49a0-d0ae-08d913b3388f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 12:57:51.6799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CEP4zawGiXS97CParIQJX3JenhDvN1k9M5tFfjxMvE2c3jP5MhRgWkGfR1FKoDRadlEfxgN4FriycCQqj2b8rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1510
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Shi, Leslie <Yuliang.Shi@amd.com> 
Sent: Monday, May 10, 2021 5:56 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: avoid undefined return value

Fixes: a7c22df2fd07 ("drm/amdgpu: clean up non-DC suspend/resume handling")

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 7d4af8fc7e97..f3b2762f6f53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1554,7 +1554,7 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 	struct drm_crtc *crtc;
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
-	int r;
+	int r = 0;
 
 	/* turn off display hw */
 	drm_modeset_lock_all(dev);
-- 
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
