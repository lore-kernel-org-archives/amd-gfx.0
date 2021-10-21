Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CEAC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 07:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E11260F9F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 07:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E11260F9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D985B6EB7D;
	Thu, 21 Oct 2021 07:19:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52D136EB7B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 07:19:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nssQnXdJ7ecQbFaKxSJtiBrMlsFJyyVRy9tEWMwY4vemg49ZXEhUp7JX34848iMwaNpEsfWaP6EJk5f3HJcSb7YequunqwYDJg+IaxVUngGDP6yLvLsNy71Y0ZkB1Vnt8yGF+rDztG5Wj/1kbGE3B8bszc6TXq0QwoZrzMtZU7804wFkO0JIoNl00Q2vcnGvbQx8qkpW/aPosOFNARfaKCH9+DgMhUyPDUTgZmsSdZAs5ym5gglQg2RS7bUdha9WOmh3Ww8buyhJIOocgd5OzdyKz+yNcGoWIVs7ERZT1+RyJERCRlnrZNrXpOwzMpqN56XXKbCHoK5NEefEgkWnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTsEQ37/69AsyHqB7IDBbu2PH9boUfsW0gjtTzfW7jo=;
 b=gJb5chBy59OujZKd3VmTBM9PG+Yhs0l1KC+81F5DBeSnkayhHSCA2QWtESWhkbLsBxqWKwRnjxWGuseWhRZM4d7BS/Ps4XHP7On4/oeCpv0F/yDbujqeg6c67L8P/lpoUJK7ht1jbN/YsAuHN0YMacxUDnvbiOJnhOqjRj2w8VqhIV1uKqutfyQ9fhYmgcKTuKRCCQ1M5iLMTHlrfmW01aHDb97YHQ19b03y/GhucewiDR97uZtvyYcLTaxlTvdcNoMrZ0GT+Fxb+nG18I4NZ7P1SRx8rztmIfRLFdLeXbNGB9Tv9I87HgyFqjMiRNfmstIGYNfpV9EBO/1iXNerlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTsEQ37/69AsyHqB7IDBbu2PH9boUfsW0gjtTzfW7jo=;
 b=BrGXFOfBAXbdICfU8mLWJ5lVHLsCFCEJMJTcQN1H7u16Fb8Jhoggzg0JZrT6fj5fee5LBgDDRDO7w9f8NX5pW2M70JpVn0XfwpRwElwUn+7lJp94MQLJJP7M2u8BoF3f601/4sfgBovKRNU5YXSeSOKGRodLt5H+tg01HDKHJAk=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR12MB1516.namprd12.prod.outlook.com (2603:10b6:4:5::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Thu, 21 Oct 2021 07:19:49 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 07:19:49 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: FW: [PATCH 1/3] drm/amdgpu: fix a potential memory leak in
 amdgpu_device_fini_sw()
Thread-Topic: [PATCH 1/3] drm/amdgpu: fix a potential memory leak in
 amdgpu_device_fini_sw()
Thread-Index: AQHXxkvO0oo45Yb2ZkG4WAfo4m9Q46vdC1Yw
Date: Thu, 21 Oct 2021 07:19:49 +0000
Message-ID: <DM6PR12MB4250B78B1C9E96581C88310EFBBF9@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211021071750.2912140-1-lang.yu@amd.com>
In-Reply-To: <20211021071750.2912140-1-lang.yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-21T07:19:46Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5da1cafa-4197-4c3d-b481-d95224775800;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57f665b5-0e98-4c46-bab0-08d994632b04
x-ms-traffictypediagnostic: DM5PR12MB1516:
x-microsoft-antispam-prvs: <DM5PR12MB1516B780803420EAA35D7022FBBF9@DM5PR12MB1516.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +dZr8BkI79gpgKtEp1xwXMrcm9PhAski9Tmt+U5wSCleedKGrULMR+I8KWs7/0a2dbtuzmF/Kwu0/2zeCofeG4X8TkWPefuWnVUjbonXTDitViMqHTGkimtrnFwirRDJlaTHbsjeFAxSHC8M408XLUPMG2F1Vkzqi6Qhnwu9ibQU5c6hCP1UYf+X5GjGelH0UFIYPugHIBGQxKPNm5khnGktmLvr3mJaNLTZ7bCXBW+60PzNcEDwr7zkWFJXHgQctcxzxrb2ykm7tRfwY261B+G36J+qV5Eu2fRcxGYETJs8R1h6lz1tnG8Zi+C5v1M9hKH8zC4B2J2s3prmG+UoRS1Cgd7gwf0kbUa6ZHX6dZkXj32JhuTDt3T+rPQN9hMn57K1fxx2nOzKUwMoEAOIBIhgThx0zAvPLFmFwA4uQtl1h1E8ZlF0ur9R10dP2WYKxU5Xiu6z1+kSgYRmvBGeetJiInQL9PqpyJG/JPyeBbAcQ19pyZkUf5vT5nYKK1QMiaZ+yfMnRSD63qAh5ygMo2HqqbmCqo2p5AnrTK6WNTzscuZ3qoTFwEUWizj+gmepRCL2leAa4+r7KFPRmVLU+YUzhY9y8Tuu3sJ8GC8NBuVVog69wRq1FmKmEsxAGmurR5G3+NhZ6tCjp3X1kDQfOdLZXvjYIgGQrgityqSUrJHCx8sHnygo2yN0YlEt8FnSmWlCH0qR39obzX6X+zHtFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(86362001)(38100700002)(83380400001)(8676002)(76116006)(5660300002)(71200400001)(6916009)(8936002)(26005)(7696005)(2906002)(66476007)(66446008)(64756008)(66556008)(66946007)(33656002)(186003)(122000001)(6506007)(38070700005)(52536014)(508600001)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TW3blUUb+sKsMN40Wo8rdA0hZKXVzQiV9d5RO5vqspdXo1OrAU/Ke23NxvnP?=
 =?us-ascii?Q?oZWxP8eaAP3SX2+XDIecU1iiiUCVkjW+BhAeKOhFzxQYNyGGC3Niqx0yJEQk?=
 =?us-ascii?Q?c+wyCHeziDC0WQD6ZIK3mkv9yJd1BjU911tNwpmWNX/rr6hKKjjQnlfR8OH8?=
 =?us-ascii?Q?THNjCJIVZQoheVS77tW6uJlmtg1QXT1qzj0PnZ+ZXGfivKc7FxfpHfSj65aC?=
 =?us-ascii?Q?dUZtdwEbWtM/8JTymPmq5zAFthcY4DZNXF1DW2rxSgfKdBdDK9xCzkKoYLFu?=
 =?us-ascii?Q?zTnqkR2fc7g2VyLYnkZEDKX3xC22bBAmpCyq0WSC9HHdr7IwwBrPVAX6/XQC?=
 =?us-ascii?Q?zPMAmue2jC6sC6LNyoySfiPqLgXT7XpeCyOLH8ilExuCteMvrOR7Gbt1FVOK?=
 =?us-ascii?Q?17n28P2DLftESObqOv+yfUyR4JJqDNuI7yuBiEhPHt3tFpp7XS/jXyrP8uCX?=
 =?us-ascii?Q?ET1XAG65HagV/iOOkQ5mMKPcvRqH5BLfJMZioQioVne8VDMTVgnlLywNh00A?=
 =?us-ascii?Q?i+OyDaehg7zzdzd4pZetsDQxaxMF+D2qniTjYQG8uS4mmUzyqGZ0fPzVt2i2?=
 =?us-ascii?Q?X9fTjqqulXxftbGabP6tsdsq1VCtc3qCovK+w5MU5s1QDtmEa3UN63Hy5ki4?=
 =?us-ascii?Q?39mjnEshEv+nXPiOs4VE+3F6V57aE7GP8LUT3gcfdMj/Endx01DMUeJ2tkjF?=
 =?us-ascii?Q?hYZKtOZL39tQ+3HJ1vlshZ7jmZFco/3DGYVntodVntMglv8qwM9GtR+ZVfmk?=
 =?us-ascii?Q?tD4WQEliK9ngo3+FOX8fZuHhC9Ocm/c1J9b2+SqtdeXdEl57YXOy1fedi7GR?=
 =?us-ascii?Q?txdCWcyTsi3zorysE410CaIK/8LOza5DeARfc3h4/MFYfsHbim2SFQxbxZHD?=
 =?us-ascii?Q?dUp2kpCwCkUtqpsFcyWDaz2JX0acBs23wORxJ7u+N8Jb2Q1cJzehlJxrv0m8?=
 =?us-ascii?Q?inTRKhl0nnsbqoinVCJIamBNkPmMpwhYwnk6d/TWx/2JcW1uKoMUe2M0cAMc?=
 =?us-ascii?Q?IAtY5yhjKqP3F1ictVtjS3IXW3Z/dLSZR6XKz1LQhIJ/GkaDvzoPTxmb8+w7?=
 =?us-ascii?Q?QCfcpMGSrhhKhl/ux0+AxPLOqAWERMXXgjb75xWXS8e6Ijlcp/ZqOfdBNpbT?=
 =?us-ascii?Q?Jbg86J8VAXHp1rGMmog9yJBqmvFwvi1jsvj/b8fzdSt9otNffQ38dLk6l7hS?=
 =?us-ascii?Q?JzQpCwv1Q3wuo59GSfU6MG1rkhldoSmtW0sN23NIjM6KK9Ong+hw9oy1cJ/b?=
 =?us-ascii?Q?fmvUgwXVGDNlXTZN7m55E0YmLykisgH5Foa8hRtAa+h37j2d0r5kz4LfO5Nj?=
 =?us-ascii?Q?P37dUwLhfMmELFyrIoyEtd25?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f665b5-0e98-4c46-bab0-08d994632b04
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 07:19:49.2904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: langyu12@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1516
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



>-----Original Message-----
>From: Yu, Lang <Lang.Yu@amd.com>
>Sent: Thursday, October 21, 2021 3:18 PM
>To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Yu, Lang
><Lang.Yu@amd.com>
>Subject: [PATCH 1/3] drm/amdgpu: fix a potential memory leak in
>amdgpu_device_fini_sw()
>
>amdgpu_fence_driver_sw_fini() should be executed before
>amdgpu_device_ip_fini(), otherwise fence driver resource won't be properly=
 freed
>as adev->rings have been tore down.
>
>Fixes: 72c8c97b1522 ("drm/amdgpu: Split amdgpu_device_fini into early and =
late")
>
>Signed-off-by: Lang Yu <lang.yu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 41ce86244144..5654c4790773 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -3843,8 +3843,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device
>*adev)
>
> void amdgpu_device_fini_sw(struct amdgpu_device *adev)  {
>-	amdgpu_device_ip_fini(adev);
> 	amdgpu_fence_driver_sw_fini(adev);
>+	amdgpu_device_ip_fini(adev);
> 	release_firmware(adev->firmware.gpu_info_fw);
> 	adev->firmware.gpu_info_fw =3D NULL;
> 	adev->accel_working =3D false;
>--
>2.25.1
