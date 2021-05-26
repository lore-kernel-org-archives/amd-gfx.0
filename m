Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0BDC47082
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 11:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016AB6113D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 11:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016AB6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE13A6E0C4;
	Wed, 26 May 2021 11:31:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74DFD6E0C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 11:31:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHOMBFOH4d3ltd4ATKJEnDb2Qaa6eJAFfG9S9sYhDs2zGGNMOeG4LCbdIgmyG++evmcCVE2jjDdxxCwEuDOvEfEV96QKGQq360naZaMAbAfERW1GsdTwWm7gK6Wck/OJabvyBh/fv9G0BPdYPv10uGepBfNFxJMYNDPZGpth649MmePjiZKMYLB84byblXgNHdDqVy/AnJjTtjg1mKZbgtNIbV3rLvQ1mjNvUXb8vzwzs9LEFlo4qjmpeeRRmM2nLBR4XMNLgKE72ZPYv/AYG4hfUxKo345BIOwON0YCO/XDAJLz12a7XnqQFaukIEdtMSZJrY28ZiiWqqzLDr/bfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBlMVND14Uh6U3U2qkTABmnIgAzaMkPIo+3483nqWPg=;
 b=SJI9NxLNYGmID2CS6qZNIgjouoFY3znZy9oLSmAGMVTNxIfD35+Ze/iM+KhpJR6nladWhV3KWzue7hKD1dfbRZ0VHeqpYvHS41rLkENdRMwWrOKy6CGnuZAmE9U2cGZFv+DgtWTUqx0FQTDhTLk4Xce3mQy74MUyI2Fq7k/TAy54eyNWIjXgitYc22N7MTAEYcuPMm5AwahgZv6ASfysBG7WoRrNH5t5ciFBCuhNo1UAkxSh0sQhjDWD23zNSSNtslfwPFUpla5sXQs3PGAZ7wqaYj15qfGGBA84sWj2DJewIdZXMWXyRfggjzC9I3YzwnqHDEY03LBG0wXZyejD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBlMVND14Uh6U3U2qkTABmnIgAzaMkPIo+3483nqWPg=;
 b=BcVJtak1jfUda6+qq/38CjsaRLfDifsUBjTACdyYJjZeHAI/DoE0rNXNWfkdzvrIOqG0MbTH7pLavMkYZCXTWCzMGqIhtgySH87I7TwkNWOc67dAWSZS2LpRJQCNTXzNNZP+BpFP3yCLWphw6xl4lwINCyGD+NHG6T7FRbZ6LeE=
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Wed, 26 May
 2021 11:31:17 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 11:31:17 +0000
From: "Das, Nirmoy" <Nirmoy.Das@amd.com>
To: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] free the metadata buffer for sg type BOs as well
Thread-Topic: [PATCH] free the metadata buffer for sg type BOs as well
Thread-Index: AQHXUeG+p6+Ztr8pF0aiomc4snQOhar1oE0A
Date: Wed, 26 May 2021 11:31:17 +0000
Message-ID: <DM4PR12MB51369BF470126FB43D17BEF08B249@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <20210526034625.5805-1-shiwu.zhang@amd.com>
In-Reply-To: <20210526034625.5805-1-shiwu.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-26T11:31:15Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=13974f8d-4b19-416c-91e0-3f3fb71bba8b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2003:c5:8f26:4300:d522:207b:ae82:4dad]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88b71f9f-2982-4eb8-2635-08d92039c6f7
x-ms-traffictypediagnostic: DM4PR12MB5088:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB50888565899C2986C65C4D848B249@DM4PR12MB5088.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:184;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EdX0TsZnQRUh0KNddNF9iPzxrd1MX6yq97z6tHKXSNroPVY4RLegAa8kB0+uYVWggRlGeddkDb5dikXOau3v22FxFcKK2EjIHxPkZvqOfZQEKFP2VCFG3/15/kWvgAmrc9QgxURaYvDjr6GSceu3zWPrJjv8tU5SoV5tRoZO/gvDDYNpHqTUkzHhoa11dnzQwuo64ZnasmH75ZFDnyh4cESYJdq4HqTZzXwij+qIANFzjNRM0Ga1i95WNd+O04s723LPiBGF1cQzitolUHwftsIHxPt45Ckdcpc5ZdZHKsl/9HYcOeKBThXmt1z3n2PZzKSn9m5FQnSTF0O/U8LNp/iybSvjlHPLhRc8SIx0veyUVI8kEZU1pSxoaoe32VM6cz+gGQOcFu79FNgHJvaSHNGmw85c0M04vRofEheJAx/+MOtUIZdsmm5tV9OvSq3BVHR94YhE5qi+fKNPwAPw6paNS65+InC3ATUech5SroNN6westtxnkL3f7jxxYcs02lwNApb1TbPZS/ifGepEbcHej6ryruwdpkai5QGSaKzs2+GOoJShcQA/8TRcXYBMHLlMLSsBWuB5syibg5y9I+NLbMH3lw3om34lOtmSY0U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(66556008)(110136005)(86362001)(66446008)(4326008)(5660300002)(66946007)(38100700002)(52536014)(478600001)(8936002)(76116006)(64756008)(2906002)(66476007)(316002)(9686003)(33656002)(83380400001)(55016002)(71200400001)(122000001)(4744005)(6506007)(186003)(8676002)(53546011)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mFjVeTkCqBMW/L6x3G9TKFSJ70m82eh6A4IohHx5s0HWIJ1/scATVWGkzxoE?=
 =?us-ascii?Q?ybVLC413ngMiuYL1A/3pXwKg/sM09au6vOgIWVCDV6PBLlAQ31KwhzUqWx0E?=
 =?us-ascii?Q?DaKvE5iO8lqxbjhN8HJMIaUO6TaPmYDKe5NDBqo4OBJgK0OuD1wa6+oQq4a0?=
 =?us-ascii?Q?kEQiYy5pr9Kw3HnTh4/kTfC5KVK3ymI2XrM2Ku+kTy5XpVFo4vX2TyxpJkt1?=
 =?us-ascii?Q?cYOkryT5jECl0WC51lv6G1X6ZWdjGrb+P5ZpOOGfjX6HZhN+6PA5lumi24lv?=
 =?us-ascii?Q?pHfCrlXpYDlKkpGf9JIv+0GK/RhIM5iRpKmw8iwPUZXM8r9DwXe7d3DQTwp7?=
 =?us-ascii?Q?Np2yx4LWyyut28peFAe62zhr/UfIzFnWAatLaygS7QtyWW39T1gnEqMzai+c?=
 =?us-ascii?Q?x6/zJgoLK4JHOLd3o72h3EbuI+yVqEi/kFRzd1Z/1ssKUAAUTMBLjjwA5xOi?=
 =?us-ascii?Q?aGoGkewYBPVKSOxfcKyG6HmkEUtmL52CMr+wOOanXQ51k1zw8Ckye8Ko8mPo?=
 =?us-ascii?Q?zhBfcxLa7+QpRRo6nx1mvxt1ugBQbltQZ/3ieU5v8UEgNa5aSc85AAcTbC4n?=
 =?us-ascii?Q?4P66n2a39L4Emfd1ss/8xdsYPP0wd8j5zFtB7vRvjYTMao0N+sh2NiJTaZav?=
 =?us-ascii?Q?/DGd1gwWNwdqOe7fE9ixnqTMomSSS5A7Kn92NrE+jCD39NpRuCPyac5i8BmF?=
 =?us-ascii?Q?kDlALFIfT6vSuj1DtM/72aXBoaMBVOAkw3FE71OX5bFvNV5ngndCDYgTmjhz?=
 =?us-ascii?Q?Z7XMqZqlfkyTBQZPJsxeSowV/aI1F0Mtmai6JHv/rwsHKAoV5RYI5NOudQmE?=
 =?us-ascii?Q?Yd6+4Jt6WZi+HLgGHH7v/kjURj1coGIKmvH94g1fNatdkh/E0awUdpQIYIeN?=
 =?us-ascii?Q?ZU9+vQN4GEwk4Vezbz8Iyo6LnQrG1SH6xNij5yAYKocvTvYPoZXTud+nku/b?=
 =?us-ascii?Q?e1OseMI9f0PjDtGgtYDaRT75bigzeo27BC6UUoh7eVHWOGSHK4aejLy5BMat?=
 =?us-ascii?Q?jNdw9BI6nvlfA4zOiV1R37LkTkP8LZG4s6pDxSsW9PvKn2jexmucszdITfvJ?=
 =?us-ascii?Q?WN8erUxTpKE9ItcbZzOLCXROyHbYpXdtggI9Wt4XtE7EFY89hZujGdX9N1/p?=
 =?us-ascii?Q?apyBKp5MD2mvrRvsP1qzRcxw/5/dbmrdtS+K4x/VzwDVN82wfr5M7OSfAaxP?=
 =?us-ascii?Q?V4J58hrJgZxsDkj4tNchxvV4PIFiErSsB1Ea2apFrxHVtoR2yRBKHiNmHb8j?=
 =?us-ascii?Q?wLuxetT1q50HJWIN+Ez0+p5O+XmQBQt0G5fO3nc5OAjGWrJwCGBOjukc14DJ?=
 =?us-ascii?Q?AqIUAIEDR+y++FWeH4bcsH4JNdvLSQ/HgsK2tVQnaY4fNzzRYalGX3LR91Wc?=
 =?us-ascii?Q?Yagmz8I=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b71f9f-2982-4eb8-2635-08d92039c6f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 11:31:17.1512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SA8JcJurlS1Uug0ZA2++y4m73MCDzzN8mpUta7vDtiNy8irx05ahOAmkb87JIUvMsIHxPCYMbBj3JsrwmajZUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5088
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Please add a commit message as well.

With that, this is Acked-by: Nirmoy Das <Nirmoy.das@amd.com> but Christian should review it as well.

Nirmoy
-----Original Message-----
From: Zhang, Morris <Shiwu.Zhang@amd.com> 
Sent: Wednesday, May 26, 2021 5:46 AM
To: amd-gfx@lists.freedesktop.org; Das, Nirmoy <Nirmoy.Das@amd.com>
Subject: [PATCH] free the metadata buffer for sg type BOs as well

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 2d876e1eaa7c..e9f8701fd046 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -95,7 +95,7 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 	}
 	amdgpu_bo_unref(&bo->parent);
 
-	if (bo->tbo.type == ttm_bo_type_device) {
+	if (bo->tbo.type != ttm_bo_type_kernel) {
 		ubo = to_amdgpu_bo_user(bo);
 		kfree(ubo->metadata);
 	}
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
