Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC66C4708F
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 06:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F09600D1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 06:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F09600D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D863D6E867;
	Mon, 31 May 2021 06:57:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC136E867
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 06:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGLZCC3TgZ9C97Ti4h93j+aYdhlh9BjyFrOrfXLnqkcKf286HeSkz6LvfrPyn/JzAPxufs48T4SNxBMXiQDbrvcw+9bvBsN5sBUtbJEbnc1s/oIYM+mcIMFN70Hv+/plcoHt2VlmJ0Lu4RT2PXIQXxZnMcvRb4veeiG8Fn+plbQG3ft5tq5tujapt6OtEheT3EuF3BhEiRjjZcZL5kLowuBOhnNZN1aOn0KBui+QoItmFtB1qOOqRDlYBJ8OLUEgjKB4z/fP7pwJMXW2B6pK9mk55IPtuUnQp4xpnfOrngV6y2VV8dnTvXNCvMZJPKgwcAQxaltwIY3Z1oRI2DXtLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U7ctMPIX+gzIg+a2H+tfHsGdVVCfptv5h1SQfscc7Y=;
 b=ixIm4Apbi0w9Yh2P+UPRwQgrSj2ogITiCPbOVmaoON4Cl3C0la/Kl+06SVvPi7JQxSAoJAXPK6AUtq+irbn3BJ8+amaJHfVYqzTsqHVLgbPrpzgBMBm1qOU9R/yRKEUxOSSnV5WAy7cz2YfZnLF5BxvjhkocKTFv0WkHqFn4psPND4b/Q0dfzGBg5/7azq2K83d8Tcc/F5q7+tte5ZuLulhrZovG9I56jMzKR3HCyyne/d6WUiFM+baNva3GY98nc3sTOeOoo/y7sUF8ewlmsios1R1dfR+nw8haYzw8Qe9TbPHqPCFsdbOcaJk21O09rjprT4PtbwrZAXr071lv+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U7ctMPIX+gzIg+a2H+tfHsGdVVCfptv5h1SQfscc7Y=;
 b=HOK4ekmDRotA58Gusx4G23pnu0Qm0CX0m2QgGMhEaC611SW5Y2/FY2Ykr0TJr+ILqU3u1+BJmNe9xfL71WcJaLP5LZc2qqBNgo0M8nFcPRkAnbsU97EF/wJ87T3xBOPha4/C6Kz8DrSz7hZmyeQzdk1/NmWObDq64YHVac1lNzg=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5331.namprd12.prod.outlook.com (2603:10b6:610:d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Mon, 31 May
 2021 06:57:45 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 06:57:45 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: use attr_update if the attr has it
Thread-Topic: [PATCH] drm/amd/pm: use attr_update if the attr has it
Thread-Index: AQHXU5fHFim/tsZvBUGdYSlO/DeIR6r9LThQ
Date: Mon, 31 May 2021 06:57:45 +0000
Message-ID: <CH0PR12MB5348BC85234445A0E7ACD8E8973F9@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210527042342.29763-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20210527042342.29763-1-sathishkumar.sundararaju@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-31T06:57:41Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=20dbf477-16b4-4b8e-870d-d15eaf488156;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [59.97.59.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97a88d2d-f66b-4fc4-eaf0-08d9240164f5
x-ms-traffictypediagnostic: CH0PR12MB5331:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB53316C0CD3718B346A4AC588973F9@CH0PR12MB5331.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bEb4A3DI12VNs+rFyIoBRMiGT4DHj3EUHAX/DiDG9d9h83O6ByOll+g25rNaUSWhNv8Mkx+nud0z8Z+9BWFRqvTsc/YZk/lrKYgyGzPkoVhXtJO6P8SJp3b+G7Bh44n5XqBSD/HDWr4sZiBZbJfehcZOBPxVWbPauLc3945FbQn3u22JOLHErgbTyIprp7mLd02wQura7WqgQ7YEIU9E5wkxgGt92nM2KPoYvJTzPDfV64IoBcjmP/eaKGSdg2Wntts/x7M0r9o50eHHcKa+GlYpC2omwEwXEq1VC/IcRmmY2OQgcRdiTjPytvYKfaFJYGMvM5t5TuyDrFP6dw3KeidO4Yr7xwkiYdBKSMcERTHB4o6EqT7nkA3ReDg1CPbrc97EC0bAI7sVo9G6tfXpJt9kTtk8KYhDfXtebn6XtB1KoFcr0kdKgEgAgjyZTOk+7XqB+JSovJP4tZ4ZfctWC676Tki2UeAB9cfvvvHTSs6hHDkTRFnNCZyAxj63MKwWNsFB/hs15UV0meiIHu1rl6irt2Wv2RxSY2Rl7E9GLYMTIwISJdBiugUj8pE1YTgQVanp/Bs1btpZ1OA9wBNf+wzgcsRSuOI4h2bPFbNAE4WB89MthLJtKJgzZfJHDnphR1qJfXCJwkDfw2iVIvl4ZQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(478600001)(8936002)(110136005)(83380400001)(33656002)(8676002)(76116006)(86362001)(26005)(316002)(53546011)(52536014)(66556008)(966005)(66446008)(64756008)(66946007)(71200400001)(7696005)(2906002)(186003)(4326008)(9686003)(5660300002)(122000001)(6506007)(54906003)(66476007)(45080400002)(38100700002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hKk+ov0SMyZUP2N5t0nYNfEODuClr2IUla5mIw6Er8Gqef+Oprp17P+ip4QB?=
 =?us-ascii?Q?pLOQ26rvNLYJ31PklM0AVvffSrEkuhEMjG/rhxab4x6Yhpa+gsYUjObtwVDj?=
 =?us-ascii?Q?pFWY3mr3O3U6Ygb5HpKXkTlTRIVWtuCOnEvteZ6FEJ+nGilFEdwA57Ffi9Wz?=
 =?us-ascii?Q?I9MyYLVapXrtgyH9pH+4R7oZhCs7lQKHJHRTRj3SeZcN7HbgNIzJ+jvpCNe8?=
 =?us-ascii?Q?6sy+g63ufEter6DJKtp2M25it6nI+fusZAy2QmRH3sHnIw2E5+8tOUBvMwUM?=
 =?us-ascii?Q?moacpoHov9Wcz1q2GxSVAefP5kG89v/xGSpylS/faBzUd1trzBTW8Ja/zSSS?=
 =?us-ascii?Q?4oafN2KtyUH+CD1CVScY5if5q6NdloGweywpXa0eeQNDmqh1XY1Jre7pQvKJ?=
 =?us-ascii?Q?RT1CMah6rBk6QNMcKRxBHvd97rxqVfdcy72DxgrPG3IwVfp1WDUU2Mcl1rNq?=
 =?us-ascii?Q?srvOdjHcTwtAczN/2xgV4cUzoDKlwI62FKSf6BQx6j5WTbtoXEe2g39mQg1/?=
 =?us-ascii?Q?pVDASIU+6G2fMO0qI09Za1x/UEUDv+jOfHMFBa8J9LrMcvxiVIRAH3Reet/S?=
 =?us-ascii?Q?MZljTa7cZirxsjQq2JxVcmKxMXsHFWNWzNp7HtsiR1gH3/Bt+XYNEBqAxJiS?=
 =?us-ascii?Q?n2Vb+rt45ppAoHVCB9ta4a430EuBUREX59DeYHqkI5eZxSi8xfreshLVxSvl?=
 =?us-ascii?Q?t9KM7g1C9t05bLEuT5BupOGUmLwOpL/yaazfSol8bcY5ulnwjrSHA7trJKyl?=
 =?us-ascii?Q?pPaLHfy8u4DCH3BGtCkrcr59EfU5K9Hhqpi6jF9qmUOXk1LgAwKylO7+JCyn?=
 =?us-ascii?Q?ReItqO+XviNulsSDYhCOh+z3nGRHdQE3JdF0/x+e7rGvYOSZBKEeTdq8gZJI?=
 =?us-ascii?Q?im3ZGvZsnnIyDxK7LPiMF6TYsyE/Lz3PqVwgRxdLc+VMGPJ49QetHm7YCusm?=
 =?us-ascii?Q?rLP1fVCR5Bb3c93H3d3b+275U39Rn8XWSxES2Bo4V6U8wkJ6DSL6RqReTGcA?=
 =?us-ascii?Q?gQ9kzmWrfxy2pAtOUARp3MS12JvPxJEJsoOTUxEBltD3aVTWDu+yOeacsKmo?=
 =?us-ascii?Q?OzVfPGYZX+8x5u5fA+Y+vjuu+G7cDr0ftbeku2KE34J8smas992yxz2iiPHq?=
 =?us-ascii?Q?RsR70bv+Ll3YS+xfYXb2ln+uvci80eA1xwNmhJRH9enoXGbJtVCbAxZg/xwg?=
 =?us-ascii?Q?lBJkoo+bwLdSs5dx85pGfgBIzQJzF3GfokcXCeC67AD3/DMm7HwttLkLOHiB?=
 =?us-ascii?Q?MBz4LMmqxpA+P3LtugMQDkT4alNOWFcv1bXZSMpI8ID/lOtXppOQ6XFVuHbK?=
 =?us-ascii?Q?YDY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a88d2d-f66b-4fc4-eaf0-08d9240164f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 06:57:45.6095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWdH7honWle/jABG2j3vvvQnJTZ/RreV6IJMyHHl/s3qd3ZsVcddYm+4yOJGd+8W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5331
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sundararaju,
 Sathishkumar" <Sathishkumar.Sundararaju@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sathishkumar S
Sent: Thursday, May 27, 2021 9:54 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>; Sharma, Shashank <Shashank.Sharma@amd.com>
Subject: [PATCH] drm/amd/pm: use attr_update if the attr has it

use attr_update if its available as part of the attribute.
default_attr_update was used even if attr->attr_update is true.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Shashank Sharma <Shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 13da377888d2..f48132bc089d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1942,7 +1942,7 @@ static int amdgpu_device_attr_create(struct amdgpu_device *adev,
 
 	BUG_ON(!attr);
 
-	attr_update = attr->attr_update ? attr_update : default_attr_update;
+	attr_update = attr->attr_update ? attr->attr_update : default_attr_update;
 
 	ret = attr_update(adev, attr, mask, &attr_states);
 	if (ret) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cdc81930600ef4ac8e5fe08d921aee79c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637577857384896071%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=SH2QzceVG3P9l30SzIQ5sgTd9cUjUr1Dr7y87PR7Ie4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
