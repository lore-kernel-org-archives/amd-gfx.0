Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AFFC433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 06:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 996826196A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 06:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996826196A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20C4A6E850;
	Tue, 30 Mar 2021 06:49:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CE516E850
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 06:49:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpMDFsufje3PNSyYItWlIR6t3t7/Pmd1v8sgCQD1fIPDds3CLG2d8oOAQV9mPyFN9+Rq6JIYWmq/qq+PjzjVTas7C40jUuQYh1tDFXaR9Bbduy9ZO/QuUQQPpKW0NqYqqmB9G4dUzoESYBKKtblM9d9VAXC/ak0o9ZVJuc7Qwtzd/OI8nJBKOypeCWNBOyXOIjK8sMsPZea+G/pmB+cAFq9aPguseYC9UQOtOUQjYXMpUFabEmAKo2W1RjKV/ki2tJ3W6uSHpDAYZaAWCrm8eswFEONqW3XzCrrQ0xEiMdUQ+knKFx5o0nvL7bqUobTNF8F473UlNuvMBxia5sZM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGTa6Hl9lDnUmNwjdvv1NC9120tq24TR2h+al2V+yR0=;
 b=ZWrN0HA5Fq9LjHC0d5UdD3Os2IYhiskOzqYBl8bzloEjbkHH84jWoFaw8xLE3fIHxej+9SIpJpAYg/txwZHtHomikALqwQXMJy1yfCmSUNb3G8o2yTfNMTmNuov5JLH9I5/aJI9GsWL8nKbzvwrLjLnAZIgvclmoWzAM36mxheQ3PLjLJB0yalnSOCGJUqZGS91HZqVfteqaYIdBIY6DYD/JboftsevY5e4AGD6xVB1yV90JuyMz9mYQKzRlm1cidsQTHsH2RiC/eNVo8Xvt+Wjq6Wrx5C8Z+6tpM+RCYoyy6Zo1+KAa+CTNkxKyVfxNrW7pl+833ELgwcR2HX1h4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGTa6Hl9lDnUmNwjdvv1NC9120tq24TR2h+al2V+yR0=;
 b=1MKSOasal2glkFenzyEICrakBXqEDhU3lsreuONuuQLQu3bc/R88N5VebPmIxDS9Di1tyYdaLlPaHppexIcmOXsJm/RmCo3IYei8rE4uG4R1O8pOy9HNoBn5C0+BbMF2QUDvyJGOS2sNkItIftAVZe9SSka7Ll6VIrSqfEOnicA=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Tue, 30 Mar
 2021 06:49:27 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::19f5:ee37:5c06:900e]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::19f5:ee37:5c06:900e%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 06:49:27 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
Thread-Topic: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
Thread-Index: AQHXJR8Ohgx3JdF1t0uq39aEX+fkiqqcE/Sw
Date: Tue, 30 Mar 2021 06:49:26 +0000
Message-ID: <BY5PR12MB48854A0C129A2F6BE99503E8EA7D9@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
 <20210330044147.57802-6-Emily.Deng@amd.com>
In-Reply-To: <20210330044147.57802-6-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=94eb1d52-a1ed-4f72-a46f-4ffdcee5b90b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-30T06:37:04Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 74da4736-a73c-4082-8342-08d8f347f640
x-ms-traffictypediagnostic: BY5PR12MB4163:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB41630A9630D00971554C8CCAEA7D9@BY5PR12MB4163.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PowEYMiEKKqmpH6eVPoeywVKucBwG9OOYDYgTRb5SPw2RX5D9hdesAFMaLOkfrqongcXKTnZoI02AJ/Qg0UwdSYJnO0yXs+hdAX7DLTgLk3kEts++PvsybuC9egGAQRpxBSxuz1JYquVNrQcmTy7GOJRwneNjFcLdDdQIhCwXZuA0yAnxyvAOfUTzAMv1oPIm8tNchQGlVp7103Y5R4LFwWclI6CTOzaHkEGfRED9cGwtlAshPs8M2fTLcnlhfsuMmfrRQq7gZXI0rw3D3x776ZJ4lJrewoYjhmPf0M9Ge1iN6cu7pnM0eAmfe/hfnUxG/M6W9Zcs4pfwmNykZbIk0oEKN6Tii7HzVJBuHmenwIoYOD37r+eWA7CfRFCZ2J0MJkqCldTKfaIu6BCUM0Z3q4IjvAlRfrWiY9CTKoDUkM87QdfZDo0qmO3JacxIUxIKYXnYgYQqztz2/a4zpqbnHTP4ngxrY6bA375Zlr0QZ/JEz13xYU0u4wxzMatKjVT+9WvsR41tX/AFaSpk7Exb3aUFLPzMiXaMa6biNvEzslsB/Eo4dR0yovEm0FqvKzs/2bqCI6jhdVIdbudFKqOwlfZKQyjvcEujy93xUfUc9PF1/svPzrk+UCzOt8ZkxlY2Ny1BPz2YNlIwZxO2wq87EJAvBoKJRLeyV5V+sZh9Dfc7eCj/S6RLYOkpdZBIan2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(966005)(2906002)(83380400001)(5660300002)(26005)(6506007)(53546011)(478600001)(33656002)(186003)(45080400002)(71200400001)(4326008)(9686003)(55016002)(110136005)(8676002)(7696005)(66946007)(76116006)(66556008)(64756008)(66476007)(52536014)(8936002)(66446008)(316002)(38100700001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AzdaOhtYvywBFX/mHN8EJJNuzZvXmXtBgENvjyPlX63x/+lMaTMjV+BdKNyP?=
 =?us-ascii?Q?X84KdGZacu89TCtaxg3GB4+2iWs14p08N5B+KssqiK5VhH/CFBhHHrZNFG/X?=
 =?us-ascii?Q?AA69GZI/kbti1lM3u3sj5TYZsb8lUd6Eevy6vp4sYpf1M31RYpegqVobHINl?=
 =?us-ascii?Q?MP1yQr2bzph/b4EIoPKeqXFbjAs0Pn9mVP1SViAh+FGV7An5U9v7Qfns+8xS?=
 =?us-ascii?Q?oZ8EGnqIHH5A5YDaEOkfpZEVjMzw5VJ5WPA3XSDzVchJOcMNEvuP3j8tfk+X?=
 =?us-ascii?Q?DrZ5TP1LbQPeJ66ux3dF97Hjus48U/eM3XIj4+riT1Gf9xzJgWG5AqLjguRI?=
 =?us-ascii?Q?RCOR2TRhkUu0iKNAKmHIShM15VBXG/nbLNBNUIqg6KTivBH+kTMC57VVa06t?=
 =?us-ascii?Q?ePf047bQ2CXk4bx6WIo92Jy+vG0DdBwUYClHgUKim9/rzOEn8kPLF2sKOEAK?=
 =?us-ascii?Q?iaI/3fehnJdh9aCZktParfYE7aLD/TRnm3COl5NBKQETiH5Uqbsg9s+coBO8?=
 =?us-ascii?Q?1ybJAE3nBDHIilLIvFuMcQt+RXdWW/Qh4kIP6bVUi39uWPIPDTgs0ujW/3Ol?=
 =?us-ascii?Q?uIEElKN4zbY09t+5DFwtQFOPSaI/+6ZrkxP4gqbq0fvOjPHHcsZj3vH0MVIf?=
 =?us-ascii?Q?c7RZxeqUG3PbqcaS+jeoLafkgumlE69hjx78HjAULwwzxB7ZVZicM2x/r93c?=
 =?us-ascii?Q?IBOF+ZXlTRYKBbU6+mE+IrWs7J7NuCEmZSJ6dOyH5FHvJ9bC34uR+vHxgx2o?=
 =?us-ascii?Q?o4WeEjs9TFPfgnOklod7Vly7pJwhCdvyGdfCOeIY+/FXbOcukacqiKB/CNCH?=
 =?us-ascii?Q?0UiiaSluPvbvPszUYyNsE3GPSKmjYeNyotMQ+FZEiaiCADk4Q78C61EiJW9M?=
 =?us-ascii?Q?Ri+u1tAL7PF8MJFBetAFyAIl5PP3oqfEwLpYhwmcrvUJXXbtoJe3kEsUNuhw?=
 =?us-ascii?Q?/Xe0mKy9fs30d+0w2JSM5+l3Gv4A1d/olzVrGdL19rhscIeI7y7kE7wibucI?=
 =?us-ascii?Q?HSmoay3kPh9dTxBUnHm9GX8GmiupOOS8/OtqBwk39aHJT8+Mt2AHWHjg1r+w?=
 =?us-ascii?Q?5gphwfxxhRBjGsvn2iHKCs+l/ONH1lPiE0a3rxWdzUnxjXIjBTV+0YhpVYFf?=
 =?us-ascii?Q?cjJCUqW+flHAQqUhWirOXXehekWf5b3JTVjA7Ndyod5PcrLl92X+eIz4hizf?=
 =?us-ascii?Q?uEANLNozofhO0cwcePKps35aV0V6oEpTqgtJ74w739CPjtlbG5B99VA5znfv?=
 =?us-ascii?Q?6LB60WGaebjI8A1iDMCqcEzp8HEZpoUknzLrflDNWQJ3OhistQliLPtlSdN5?=
 =?us-ascii?Q?TbKSvjnSCNP1DbQ+zE93k372?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74da4736-a73c-4082-8342-08d8f347f640
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 06:49:27.0086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DvZotKiCBpGo7KDu/Svek0qgnUba3KBujJvL4GwxRfWO4989Q4STNPKRWOC3UiTBtLmnWT4+grO9Yi5RSX190g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

I still wonder how the issue takes place? According to my humble knowledge in driver model, the reference count of the kobject
for the device will not reach zero when there is still some device mem access, and shutdown should not happen.

Regards,
Jiansong
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily Deng
Sent: Tuesday, March 30, 2021 12:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: Fix driver unload issue

During driver unloading, don't need to copy mem, or it will introduce some call trace, such as when sa_manager is freed, it will introduce warn call trace in amdgpu_sa_bo_new.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e00263bcc88b..f0546a489e0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -317,6 +317,9 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 struct dma_fence *fence = NULL;
 int r = 0;

+if (adev->shutdown)
+return 0;
+
 if (!adev->mman.buffer_funcs_enabled) {
 DRM_ERROR("Trying to move memory with ring turned off.\n");
 return -EINVAL;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7C1b4c71d7b962476a367508d8f3362f40%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637526761354532311%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=RxRnZW0fmwjKSGMN1nf6kIHRdAPVs9J5OBluDYhR6vQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
