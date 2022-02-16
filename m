Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6314C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 08:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C6110E9B2;
	Wed, 16 Feb 2022 08:46:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD7D510E9B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 08:46:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boxfMfsUpoVGpDOatOzSF2MOymWKvRlpAnqOEgkRD5N3UQY7cGec2+vvv5jxYPObKOQN/7RLaCg6mcpGhplV4gVRovQ4+I/Jkdswf36GvB4ixadujLOf+fUU6CrWNIoO3J2RVGfmtQlQkI2Hf+jv4AlFm0U2JaqAaF7OoZqwBEwYdinljRAlEayR8UeXeSo09t6FRVMcUVsZFYcHX1pGzCoi8A+I0BQyI6jr57ce3krfAHIFa8pkwinzf/Y7aMB9Z9UvE2yN+04mNBnVs4vBa6grhf8NIbFJXTejZOPbjBDS0Pv9+swUQhm4i166CCTePXM3NkP3SRxYcMVuOAowSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=re3U6DBKvBs0rm9E2+kVsHDYFP3YZxVIxqBNSUsE3yQ=;
 b=AvbdJdNt6i/19bbC8rk3+xi3SOp1irxVnINtMJnsUf/f8O8haz1BlEu7g9NJE0wt6dKzYAlkgpXVjxzIn14KOzpL235miYLEjoCfRTf8pBFKF+5NcRgQxMccRThSRpiS/H6lTTA0iKNh1NPaXJR1JrQsF9P9i2HgEhHBLEGF3RTmQ0PyNq1Rz/xeHxosKBQyoahGOGrUL7d6Y+XZUtw0EVDV8hxwGgwZ6YhHyNmZU9wd3MaH6zdWw3irc/a3H6612mnM955ljMPZP7FfZMdMn3jp1HxQ00QgAywxRPeLQ+buEzAi9xNuKwZy+i2AbPeQOTa7GDdRIa8Us3drVFelDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=re3U6DBKvBs0rm9E2+kVsHDYFP3YZxVIxqBNSUsE3yQ=;
 b=R8DK810Vky2Y7wCh9j6SGUETdtXzDNG/gXdI6/ytZrbcI/eG0UBOC5DkN9EC9Q2HUNnPU4krp2rGZnCT61fSCLov49Y1TWLHTf6OTm4GuDgSarSQLQ666bIghCkOPntl2sOtCsy1WSVLzxzgfUEc5rr+jr0+qjzsx8xE7D9gtU4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4987.namprd12.prod.outlook.com (2603:10b6:5:163::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 08:46:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::bc82:1b0d:96db:25aa]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::bc82:1b0d:96db:25aa%7]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 08:46:47 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdkfd: add return value check for queue eviction
Thread-Topic: [PATCH] drm/amdkfd: add return value check for queue eviction
Thread-Index: AQHYIwZY5qwoDOiLs0KQi54YUmykfKyV3UiA
Date: Wed, 16 Feb 2022 08:46:47 +0000
Message-ID: <BN9PR12MB5257C8F0E2F4FEB0D254E35CFC359@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220216072500.17911-1-tao.zhou1@amd.com>
In-Reply-To: <20220216072500.17911-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-16T08:46:45Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2afda41e-23c9-4c2e-8e10-5e9620e1bfaa;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba7938f2-b562-4c2c-f86d-08d9f128de1c
x-ms-traffictypediagnostic: DM6PR12MB4987:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4987553F49E18327725EC9E1FC359@DM6PR12MB4987.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RWXgBUjkeV1QHX6NaZww4u7XMaqUjL1KgsmvaIseUA2xgzQ7L+FIqDkhdBM3FJWGBk0GmbBp54yagVY61X2TpRTD6TBDpol8CZE8pi6KvnAajkmLHxGZWyZr1FqMmmIVzJ9bJszOvnVHLweiyWLKnOD2wEKNy0Fp0byNB+SkMbFnzQoGGOHbqtE2QLpQouTzA8Pmes5ZmFqm2Jbt5mgfqW4aFLnDHBhh0Fk6ctWBVFm2Lwk+WPx4ie+FC8li8LEGaTZb7EW0F6WPWd/fOr6k2skXyzsieioKWbg2gJvTQumI150Kz2UJEGjf13+A/bBELSgUxruxRCVjBocq74FRKHl5V5iRMMSnSshNTdAK5cFKO9yn87wu2XpMVSSou2E/Hs9rsf61gMGhL+bTwZIx62HG441R82qr9AEoA3XqLaAqktXUeLDrCqqYoxH1biqHPxYeQSTH/hvwbFA8j4+EZEYF7Q61f4oXnU0xX6WxLWiWBE8PL1rlVrFTjNV12t1GK3oDyFfRVapK//HwcHCrmnwhMKtz7e5yZf6KPIAC8bBTud7W0/rI/Qes9e9W1H6QYuQfScnuzyHLiQT88Jjvpc0NQiQlTjCEuPjz+aUtJ/rCUj01eoEnfWDFXLE5UpSIWzmfwGMxi9370pDiWaMzZ0irmWQQzmbf+dq0Km//DrtcwiITov3ZVKS3gvhlaQ0mqTYBUVN6WdfhRK+OGExp0g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(5660300002)(64756008)(66446008)(122000001)(8936002)(38100700002)(76116006)(186003)(38070700005)(52536014)(86362001)(66476007)(2906002)(66556008)(26005)(7696005)(71200400001)(66946007)(110136005)(6506007)(55016003)(316002)(6636002)(508600001)(9686003)(83380400001)(53546011)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pLUtmoHyuSMBj62ElKGHWORhynYU1Wh++MYoB0PHJ9Vc/cZ3bHTw/JM0K9gk?=
 =?us-ascii?Q?M5TXccoOKaw4eb+py5N8ztOiGrOBFvQte6ZEgNPJ40ZqB27bEkbl8pvIU1P7?=
 =?us-ascii?Q?p27LpMpR8GdoCBdVpKHo/gkiK+ewl/Zd2Ub6/HDHrPvlu2PdO50MCbGqhG9K?=
 =?us-ascii?Q?nCCf0JIkMVtuB7KKPnmnMIuedZHemNwbxdNOp6chbHFlkLC9fbkAJzH+7FQ3?=
 =?us-ascii?Q?D3zLl+l+ayEd4LIRcbYWcFuxYhzT8ak0Kk/5RGd48ElsWZMji9a0bw6c+GiO?=
 =?us-ascii?Q?28iGaAb04DuggXZae3knmw+8fGmBrJu5rMPazhcR+fhcZxCP2U4XsOU3lK5H?=
 =?us-ascii?Q?+zQN8KM1aYy9cS76W5wtq81nX/lBlIfctydmeeDRNaKwp0O9ONWDQXnvcPyS?=
 =?us-ascii?Q?YThy+iXH8s9v8S3FoYYJMbxdWh/61p8cac/OPYpztgoOjGYT9tLkKommrSf/?=
 =?us-ascii?Q?1jXeTPvap16CNtPEe6XBmPHcI3NuKhg7m6DIljKsu9R9/8CqXj0qTU++cHTh?=
 =?us-ascii?Q?XaMM8q+PIhMgr4O7VBp7jfnBVtlP24+e0bd1YLIeMCJs51f24dpnRf68QxvM?=
 =?us-ascii?Q?yMYlhUjgRdlIIjJgBxglSZX6Bs9oACMKVuVG1eL7tDNi9i5wgRanne7vEx1M?=
 =?us-ascii?Q?XO/ePgEIIAq2KAIsukVq4e/b7VeXM2v5EzwYJvQEB88Z+YfHb9AYUCaoy7Iw?=
 =?us-ascii?Q?4/F7MEE/EjId/AHgB3Uzy6dN+t3xgcqfoM/AYFYsPd9XMljFNlmLBILZgwZk?=
 =?us-ascii?Q?7mYTsgebF/1iu9Yztvx+WA+jvM4rNH2vt3xno9KxLfOHuyIqjnq2OihDsbWQ?=
 =?us-ascii?Q?NlzwKygypv1BF+RmHf7ZbSQq7m7DegUFXdom0bLRoYuV+dZl/ekZfSXbtJ7H?=
 =?us-ascii?Q?f2HLX74kk4BJRxcr82TjYZYiLpSMn4EuEPC95W3ftva/A6HG2t++rRg2rhvC?=
 =?us-ascii?Q?Dphdb57JgqCbucWEPtrsikJGTYUoWoq3S+3bdNEAKrybKLV7lpt7ThsmwEtx?=
 =?us-ascii?Q?u5CLvIC1U1ZMJ362lgx01X4QZBk+aZGefeS9JoUBIpniT2JIyE9jHTIekT2s?=
 =?us-ascii?Q?1xsGXxkSe9lYjyEJFeMsyyzaNMNhzmm+28w+/W4oJwVM96R8YxjaDyVdqGjq?=
 =?us-ascii?Q?reED+g4t44zBx0hw6TxpHiPImePW6ZlfSWKCJwwRtNIN/yQyuj2Og7FyIQ/N?=
 =?us-ascii?Q?XJi+ib/qpvTWF+fmpwVkaedEBmSGPjfORBGa+9Yn4WRKbgwCUfNgnanZ9Sye?=
 =?us-ascii?Q?x6fHd51MStanMK3JsPdrQSeuXOJkqqJjgu17BgQ70lW8/P/FTfLa9gdiAAl9?=
 =?us-ascii?Q?3XC0bn6Td2q3w8biTQMnhVFQFlzJv1qZqRND4IinA4+4gFU8Q27EeKy65EKc?=
 =?us-ascii?Q?EwiajhHJag7X7jP3H40nvmJAANVLgWeZvOibXyrA4h07+YVUIrQVVdNjQjto?=
 =?us-ascii?Q?6MXaRtbvzb/X/nKTKS8qCsNqlNhzw91cAsbjpJQ3W1ddg+BgvO09MTASfXkU?=
 =?us-ascii?Q?/KZNLj5mueqQFlMO6hlElpBIh5CeHbMYSleo99OLfz9Ph0oV0/ryFwYZU//W?=
 =?us-ascii?Q?T/0JnmQT9ZQ5xvl09LeLUU5S6TINRBVe9zpeUePIS8uI/Vv+JJDy46dMAAId?=
 =?us-ascii?Q?1YGx4uoFWR6Hz+YL2TFqRbc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7938f2-b562-4c2c-f86d-08d9f128de1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 08:46:47.6425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hFo4RFPUQePxxVPYoaBPZTWTIYeHb3QL/X2nNT+HLB2Ru+RY3pMW99ipAXVStxKDTdZ0ap8/aHXjyyPiVWaNrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4987
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Wednesday, February 16, 2022 15:25
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdkfd: add return value check for queue eviction

Otherwise gpu reset will be triggered unconditionally in poison consumption=
.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index 6830a88f0326..7eedbcd14828 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -110,7 +110,7 @@ static void event_interrupt_poison_consumption(struct k=
fd_dev *dev,
=20
 	switch (source_id) {
 	case SOC15_INTSRC_SQ_INTERRUPT_MSG:
-		kfd_dqm_evict_pasid(dev->dqm, pasid);
+		ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
 		break;
 	case SOC15_INTSRC_SDMA_ECC:
 	default:
--
2.17.1
