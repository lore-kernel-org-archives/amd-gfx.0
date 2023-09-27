Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0955CE7F154
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 03:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC2B10E45C;
	Wed, 27 Sep 2023 03:14:04 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7025410E45C
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 03:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTeass55N5CT9GSLws7IHXHK65MMh53vPg6rgtgaeIsyCX4fJTEBpYog7UG1XezEy10t+o9NB9SunYmxq5qu4WqE9FrdUljA8YjGuUU+qRFCpkB0SCFXcIm/oAavtNd0c7uQtEUbh85mjL48MmBhwD/O8F44jtAY+GzWQVpTjIAzVtfOq5dldGOrcaWtoXmzXi+4ARWVs8/fPHtKz5NWquiiH3xKuGj5SphQE2g61nATVSbNkBXhfddB/pqnqEodi40EFUwm2QtCJujDUgTnsFU0BuzMi7T65c+hx7FbqDdx4hZqt3YpRBMCMef2Vonx/nBk9Xd4V9HyFLQOuy8CMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pG/Pb7YEARB86hR6TJguc0hTh4GHuSvutB8F9spepYo=;
 b=ZCYYfWvOkwUNtLze4PisS07OhpbNRTtHrmCmp02Fz9FsPz81r4TiOVtE5gvpFQQ+jP4lXbNLqwaWRY0NkQ/6OUkpgCU6HHbjzOGFFQ6Ffc9F9yp62Q7gJkN1vS3QFdhvNw8UeUuDKIH25Was7R8YBfCWOWrqPcBLCUj4TXBTA6gMHwfv1KWB/MLA0l6oqlPivTufhWA3Xy7pLq6cHymktJP9P7goCmyVJQzYK/XXFycrpTjiI04ZqRgZfAQLJVDmniRyvMw8aunV3rOA7G0/leEZDSNUEDUomC7Js2GTNLnF8D2ILicW2SbAjz7L6vk0VBcNetLLbsYjAwbyaXTDvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG/Pb7YEARB86hR6TJguc0hTh4GHuSvutB8F9spepYo=;
 b=iCDwoXudXz/euCwtAYtgS3J2law+P0Qrm3NKJw6282bDy12yEl4ZerbQd99YvIgXLflaeqTK7tMW5+AXNhzgH0oDaPM+Xi3Tqxk6M6NDLGFJa3DJsbUWhBLClI++wBch2tjM+T5BcfH1prBTKKkI9JOhmLr4K8K9i2pDmpRZEq8=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.31; Wed, 27 Sep
 2023 03:13:58 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::2d0:bf6d:1f10:a57c]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::2d0:bf6d:1f10:a57c%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 03:13:58 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix a race condition of vram buffer unref in
 svm code
Thread-Topic: [PATCH] drm/amdkfd: Fix a race condition of vram buffer unref in
 svm code
Thread-Index: AQHZ8O8QIVd9P9NOZUGSi2T5Q+b9hbAt/zcw
Date: Wed, 27 Sep 2023 03:13:58 +0000
Message-ID: <DM4PR12MB5152E3F0711C6B17723D012BE3C2A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20230927030008.278066-1-xiaogang.chen@amd.com>
In-Reply-To: <20230927030008.278066-1-xiaogang.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7322b9ac-0725-4119-a7e1-e3de5172555f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-27T03:13:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MW3PR12MB4411:EE_
x-ms-office365-filtering-correlation-id: b1101edb-5fcc-445c-b4b7-08dbbf07ca8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ou5qG2qVJlvTIDBT3Yv9ujZR2f+1gVv1QyoC19BePUZPwqk0nTCrqUXrXf9NvbI8YfXO7V7iwrP4lqRUTg9725JizuVgArPY8Y0giYwfAFx/k7rhGrrloVbLL+mSK+2ihYdDk5WavoQK+AW+VJKwfrYaWkA0v2nzBwkFnkHeZ7Q0ZcS9anQiZSOJZ71Xbu0+g8OMpqbGjXhxND8sDM3wXOiyLvQZCtxqfqp2UgiOy6Om+UhdUXt9Bc2qVUt/cD71LDonNArfg7xAsViW8QFKIuPjEuQ5QyJjdJSMGalofsDGvRNjd3P6/TXiBQ/h5H8YdayUPy532a1D84319NyPnv+z7ZRLVZIK+XA1fcpfgEPy5pKhnrstVRSAYBzgLu6xDv+gyJPuyBkuaN2jROllUcEV2F+BujQbWbolHHWLUGiv5CJRKrzq9Ip1Myc8hfCPhbihawrqxmNbWG7cDjwEEzuP4bAV6ck5QIHUZ0mo1R365vkmP0kP3qwlRLQAjo1AQbcQus3Hj31YzMY561kJXS4MYRWIgqLWtBmk8WohfjBkHVa+U1bjZ5VHxZaHbWlEaqE9lJ2FE3XQeX73TnpYH7alqIRac8wtX6pdwlYvwTeEbLXO73uXPyw9KFDFlcRT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(478600001)(71200400001)(83380400001)(38100700002)(38070700005)(122000001)(9686003)(55016003)(26005)(53546011)(316002)(6506007)(7696005)(110136005)(66946007)(66446008)(54906003)(66476007)(76116006)(66556008)(64756008)(41300700001)(2906002)(33656002)(86362001)(5660300002)(8936002)(8676002)(4326008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kCZ/qoYPUBBrbNe12shto5Vx8YYGSFlh1zQhU1qkaDVPUcgLXqZyHBz6T5iA?=
 =?us-ascii?Q?3OQJksa+AcmpEGDlZA6ww0vr/nprKqb5ft6a1u4AiBwh56BX7XvJpF6ybELc?=
 =?us-ascii?Q?2cNgePPD6pw3NDnGz3gdXqExmMH4bi0t9axsk+RwhsYXjdffbW8kyTn8YAFR?=
 =?us-ascii?Q?5wbfxP9lBg2BFxr24gb/aTUn/3u/B/4c0EEJ6tZJCzXZd2PmR/blwluJVKyn?=
 =?us-ascii?Q?HkK/l06RDVZYmrXNjWoPBB1kn/H1zR/oXNLCaOkDfV8B/KXLEw7Gao5aN5SR?=
 =?us-ascii?Q?lOxNFEXY72hFIIQk6lBNoaLPASfgCS985ep5Do21aNSmjOfib4HTLcxZuOPz?=
 =?us-ascii?Q?VzMX5ZYEfrudv+WrCcJO6uXCc6mK578O0H7vZ7JxYCY6V4Zn+XSEyW9ILAQb?=
 =?us-ascii?Q?aOE4E2AJVh++NFwz6awqXF7FsltHxNFs/00EWIUsIc05qG6oPN1y3gSw9Lbu?=
 =?us-ascii?Q?ET2cZxL66Pi5ReF8Urhr9a5XdTlsUufovz5xE7ZiA3PWZ/v+oZT1crv7z3kt?=
 =?us-ascii?Q?A+qaHOUxek0JGhE3DXP5z1Hbup5EaB1YL1KdG6erc2k7dsUBKhsJ9QkIG5vw?=
 =?us-ascii?Q?zSzZbf66JGA1PAP38BElChmmA4Ltnv1LhpPPWHHd45u+eE9ckJV4P3wXUVYA?=
 =?us-ascii?Q?C1CPSdkxQv7HPlFKtVBTO0pRUsBAnEaMPnvEr+nIxfQhPUenbsjT2Jha0eyD?=
 =?us-ascii?Q?yKm2EYc7gD1xWweDWD0cuJe4R74WafsrFQQlK4FJg8t1xOHJ52CekeU5qpex?=
 =?us-ascii?Q?snVe0SNEw6YLoHDRY1kOJDS1lAr98+pZMGyxypy8jazBbrslNt1mmzpIVMWF?=
 =?us-ascii?Q?B9EhPGri+pxn5pWQMmXC9xZI+hSditnXeWUkws1CWwWPq9IK6KGNmXO+Stwp?=
 =?us-ascii?Q?sqOgDBhxaRgP4p9qbrQVVby+AXHZdOpHnSIA6bQxmvTsJzi61KX9le07+APa?=
 =?us-ascii?Q?hhfWU2WgE/qsNVBSZIuCWzVbaiPaZ9fk6RIiBb1whiEVZP41N+Pc3cAhtP78?=
 =?us-ascii?Q?k6GG8MNGw7jlDK+1T4q4E6OA3cTDcgBvucwlLJFfyHaSSPCL8aOc9viqRAGm?=
 =?us-ascii?Q?BMFsrhLy8s282yVfgyZ96kZKLczefiZfCGAbS+sg/bMsoUInAjX4lxkS9q5A?=
 =?us-ascii?Q?aDkmj4xwnXus6HrRcPG1pKjfWr1Ge1rexuMmAjigWlpr0l3JgeTmfST+cDDH?=
 =?us-ascii?Q?cMyuvVNmmKmisTe0UjuUCjh9SgtSIspj8svZ3gO7S8UnLASem080jgK62Isr?=
 =?us-ascii?Q?BJ9yvUYB7pnuNVOCz8ezbyIY472gcDk5f9RnpC1zvh4AIWeO4FiibLInzal/?=
 =?us-ascii?Q?bijBVBkN42vrh9fpKt2BMPhDRiQFPdSMkfwbc9+EViV/sJxqbKTx6yV9DP4Y?=
 =?us-ascii?Q?Zl4RJBNq90lJ5yNZNT6UPwSLAvUsGmKz5/0sS+MuFCchHALjhAdzpmuh2mMQ?=
 =?us-ascii?Q?6UN0uLrJu7BsP58fCWUjMtiRbzfEFcHQRWuf+19vObHjr9nRvdGX+GwLFEoN?=
 =?us-ascii?Q?RU6v8Oe+PPSH33+qYv/oFpI/scV7sNNfV01kb1QWakrgBV5R6aKf4RqyhhTv?=
 =?us-ascii?Q?h6jdcM0Ep5vMDe7VpwY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1101edb-5fcc-445c-b4b7-08dbbf07ca8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 03:13:58.6908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kxc50gB2SiHA5pNkXT2TX3D6nsY7v8oGSYD5nzIgrBZbKKLRoCbzbb5UXO4gXMrQmh4+76YgLcU9KQHyHqjKWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
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
Cc: "Sierra Guiza, Alejandro \(Alex\)" <Alex.Sierra@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
-----Original Message-----
From: Xiaogang.Chen <xiaogang.chen@amd.com>
Sent: Wednesday, September 27, 2023 11:00 AM
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd=
.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Sierra Guiza, Alejandro (Al=
ex) <Alex.Sierra@amd.com>; Chen, Xiaogang <Xiaogang.Chen@amd.com>; Chen, Xi=
aogang <Xiaogang.Chen@amd.com>
Subject: [PATCH] drm/amdkfd: Fix a race condition of vram buffer unref in s=
vm code

From: Xiaogang Chen <xiaogang.chen@amd.com>

prange->svm_bo unref can happen in both mmu callback and a callback
prange->after
migrate to system ram. Both are async call in different tasks. Sync svm_bo =
unref operation to avoid random "use-after-free".

Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 70aa882636ab..8e246e848018 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -637,6 +637,15 @@ void svm_range_vram_node_free(struct svm_range *prange=
)  {
        svm_range_bo_unref(prange->svm_bo);
        prange->ttm_res =3D NULL;
+       /* serialize prange->svm_bo unref */
+       mutex_lock(&prange->lock);
+       /* prange->svm_bo has not been unref */
+       if (prange->ttm_res) {
+               prange->ttm_res =3D NULL;
+               mutex_unlock(&prange->lock);
+               svm_range_bo_unref(prange->svm_bo);
+       } else
+               mutex_unlock(&prange->lock);
 }

 struct kfd_node *
--
2.25.1

