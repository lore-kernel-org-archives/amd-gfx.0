Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47382C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 03:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65AE910E3DD;
	Tue, 31 Oct 2023 03:07:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5FA910E3DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 03:07:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqchpE3L0Oi4kFQgI2INY3xe4My9VTOPXXD8bIciK4q6E1Xi2ue+fM1lCYwte/kt/tz9FpzEt2NhDnDC3wU5I0zKazLJzgdbEXonAOgpMT9HNGOrhhRsBfDd3CORBq11T3hiSkDjdWZSZ0EWKwOW20Bt6Pmjd+bFK8K/9PHAk3CWYTMxjnUejfYk3tTshVSBgdU35u1G9TTl+ULIfdbGrxEsO9F4kPL9vQ7ofshbpH7hNzNoFea6Ek4lBQ91d4T1Ik2bRNuqjIxt5ZRB/qfOkEO2qu4JECjPwfCUgSZ8eYCoBW0XXZIotMIXhw7oKJU5wwFWYLoiO/t5UMARLNtSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMoe6BIXGQl0aeV1PX0S6+eH4Z7RCT5iE2yFr+xKmJ0=;
 b=Y1i+SYuSo+l6RT2Log8Z7mRn3oPhM+R4tRCcSOSPAJS3bqYJ/JaN3LDe8PIXWbDaV/PbKE2bBMViKBjFeBz4w8THNhoanySoqqfNfKuoeuVG5nuVWj1bpmml5eHPFqCa0pXsKj1VDA+HbwSCmKGuoer9b37hZb3AKXfRjzuaR5DRtX8boJxlCIJeoVEVP/zNtu7cDSRj93UAtJC7r9wFfJRZGwRoMHZ4Wzy36oBzgP+LsWQe+mehQR0fgfbKDyaRYVp421gdcDnWGuk7vPBhaKPzMUfzCApkkm0OkQEig6et28HQmnPCZywJ1K+CN8v/tbB7iARJerLcYOLQb1Dzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMoe6BIXGQl0aeV1PX0S6+eH4Z7RCT5iE2yFr+xKmJ0=;
 b=LcCAxhgh/1T6P45XhVIyvy/oEzTKBOu8vvBUIHHYtZMFQ1RoW2RU6BGA2W+JcBa5l7xEdN7xoZTb4tBbfyhWFkU66XQPTWkbupSRsiU7FKr6tR9gYlSNanS3hzjF+uAiN3h2ZMiBrjnJCiKLldmyz8GxlGAO8YMfcN9ywo/ZFPU=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 03:07:01 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::56ea:81b8:478b:821b]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::56ea:81b8:478b:821b%7]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 03:07:00 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct amdgpu ip block rev info
Thread-Topic: [PATCH] drm/amdgpu: correct amdgpu ip block rev info
Thread-Index: AQHaC6UMb9nw3RM9FEuDz69MBnpizbBjNyNQ
Date: Tue, 31 Oct 2023 03:07:00 +0000
Message-ID: <DM4PR12MB5165C8127CA507E18B458BC98EA0A@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20231031025021.2697459-1-kevinyang.wang@amd.com>
In-Reply-To: <20231031025021.2697459-1-kevinyang.wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8c7db824-48e0-4dd4-84b4-713d8404bbd7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-31T03:06:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|LV8PR12MB9154:EE_
x-ms-office365-filtering-correlation-id: debc1211-0520-4992-eaff-08dbd9be7341
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Tmt7wBdgODfNXEF/VM8gZaE78AupJfknWAtgfP54TTYRqRKaTVaMezpiTAPgWBf4V12NQbiFlPQm9fEKRL4OBD7hHc6M8WzHjjtUENUZchCLeNRbEzIWhWcsjz2nIm1iPLp/VvEDOUqQVmG1N92JNgxzQPv7xaLcmkzHcTaVXF8kQPYRzcsYPdcE0lR7m3X4GMb7sOjdSNpHbLqD1yfyXHVTbz8mFZurI7r8NW0gIXCf+lfLnPBc7FdqHxXplxmltvwCLwPPcK8xF33PhIRTD3tk2L1gXjohPp9zHg49wJKQog+M77oMFKL6d+4losfw5DvXtdFAEDkGywT3SdR/gb1P3gOXBuXsw36p6dCB7VTGk+XVFDHtqbkMwParsGQzMZSc329/vMx6si3WbDJFLxWdySnbifXP8HU/4Hi8FiykEH0aRmskhKFFQfP602UpS65lzxxJLUqjov87/AP/owADZh6QZIkOEB7Ri7JIxKnhBORi/iZUSKhh9yBau/mTSJn1A+Y5pNiVnm6Lh3nAM0PFcjBXGy22bH9gIoforFSPtIHO2h2WMZN8xGRlC3Y29DirSasnfgwbcrG3UU2mhOgi0Uenfqzvs7G6E08d8vobkB8O4UAvmHrqI3VUVzzYkt5MsAU3WS8mC7UoX4CJPDILrEFcuHPLE2casUIIiw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(55016003)(9686003)(26005)(53546011)(478600001)(7696005)(6506007)(71200400001)(83380400001)(4326008)(8676002)(2906002)(41300700001)(110136005)(66946007)(66476007)(66556008)(76116006)(64756008)(66446008)(8936002)(52536014)(316002)(5660300002)(38070700009)(38100700002)(86362001)(122000001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?75oCGT29iBZYNAdSDJyxCfMha3nlKh54ITmMqv4DbRy6h3+HtjF63DU7j0h6?=
 =?us-ascii?Q?uG9/rtkK9gU2p/HZQ4KNcJAKi6ezA1RvDzeWKciJPgkdbauynYR/nxmJ2XOB?=
 =?us-ascii?Q?GYHqtP7lO4ZQyxWoYzOdfufnAPvz1ep/0i4MEwyyVQXiBCpq0o8e1sMPmEO3?=
 =?us-ascii?Q?lNKyWKuE5mk9Lgsoku6W0o18fztkmuD5UjPWckec4x6J22zsuJzEuztiF8Mz?=
 =?us-ascii?Q?Z6TVQznhTxwd8JDJdbgm6KSdJ3ucvlSbK/PCcxz7IY7ezGvLmRoRCV3FdW4b?=
 =?us-ascii?Q?U+baQcKxe8Lo9P6UHRCp8SYBo4taqT1rQgwfKyN3i0Vm0jL3xlD6zmPpVhR7?=
 =?us-ascii?Q?VOpAxtGZgU1UPRsLW8/x6eOM2UpjV42Z/A4yIwHibHUI40vit5a5EwcmOyC+?=
 =?us-ascii?Q?rfqSapMZM+5Wbba2Ua6HE6riAK+/fYl9uT1TnWI9BDMWpWDd7LxENFAISr35?=
 =?us-ascii?Q?FkoLT0RFnC0R1hmvZy31WuwaYiGZRjsJrI3H+EYEzuefHX96f62frJqxHkfy?=
 =?us-ascii?Q?nHhi81iIFQMDsOiBM/ouXyVEPQCZiP0tmtkrFwq95yAJ3R5Wsbnm5TaTqFuV?=
 =?us-ascii?Q?V0Wfr5Is9Ggk/9m9YENxEK9a85BlUOMqgkPjnJxBa8L7M4FODoh2luZhAWUG?=
 =?us-ascii?Q?EHow2aJjZ7snZoj2W0mwc9pdFer08Y8jY92pKqcydkRu7cy3URfp04KhblXw?=
 =?us-ascii?Q?ZXIu2idGUIJ6yLdpEdED3IGqiRLTGVSU+VW7tmunmk1dA4HAKMuRYSP1ff1s?=
 =?us-ascii?Q?PZQ5EPnz9KmibydXyG8oKN4uBIhstGP/5sJU3YWZ4uI2JVVu7NqUH+/ByDR1?=
 =?us-ascii?Q?DKUmN7u4wzUK4Q19y4jOU6vKQBuRwIKsLO+N7ViNsaibF4VR1x/6qm0JSIbC?=
 =?us-ascii?Q?K4Fa7mBlQGTnXrYms1f2TWlCNh4net20quF0vOGGXLhm3ILkM+VsjA5jwgS1?=
 =?us-ascii?Q?1v8LhGAikdV2xA7Wi5lKIx0IKoYW4a05608jz0AxHJlbQA6BiSE3M0NgpAto?=
 =?us-ascii?Q?gdGVMm74Axqsq+GfZS9mj/yotagkivAU7ZHsEx08PZhTInQPqJPHF6jJQekV?=
 =?us-ascii?Q?l9VxOCxCvDA3t6aYEVKZuKTbZLsHAl9C3FxQYzpwE5wR8BAgDcTOKfLqOlw2?=
 =?us-ascii?Q?O8VyYJXz+ni2SZq2n7j8/23NnvR2NnfLjEp3uQfLHmogXIHhTdLsNCXfuJUx?=
 =?us-ascii?Q?wNuAJag8PjmNDIIOsp+R8CSeVAFha48OsxFrK7hvG2kgHuurKO/qG9eVN2bN?=
 =?us-ascii?Q?Ad4/haHBj/QfqNztZZtUpMdIqy3ildZrm7O+1bjn+J19gzyr8fdj6MMkSHJB?=
 =?us-ascii?Q?XdGfYerj7y0ycv51V8SA1sC/ZOU0XVqNXEJKNXh4zT+P79vmytJVtBNw6E8k?=
 =?us-ascii?Q?dqbQRWtKQDgbuoJwDj6uE3Hfh9a9J3BwM75wLTQy9FNc0oUr4XFmmovYw+uL?=
 =?us-ascii?Q?eHH7O0j2ARfqivVJZuDSAoPJLhb99dxII9qyrtlEZxlrhr4FiMQQPKD2s4to?=
 =?us-ascii?Q?Q2sFCBhzUpiDSujEaxMkliNave5/gS9L9t/KX6lwtC828Dy+ceKSI4D6JDph?=
 =?us-ascii?Q?zU+UwXvm5UfnzOS20AA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debc1211-0520-4992-eaff-08dbd9be7341
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 03:07:00.3748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hjDBzuThi5JfGbOrBuSYuGhqz/fTLBhLkrsaWvqC7x/iLTKDgkYtHWKzbyCA7vt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Tuesday, October 31, 2023 10:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: correct amdgpu ip block rev info

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


correct following amdgpu ip block version information:
- gfx_v9_4_3
- sdma_v4_4_2

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 2 +-  drivers/gpu/drm/amd/amdgp=
u/sdma_v4_4_2.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index b3d4458e3889..1c46d205c0ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4295,7 +4295,7 @@ const struct amdgpu_ip_block_version gfx_v9_4_3_ip_bl=
ock =3D {
        .type =3D AMD_IP_BLOCK_TYPE_GFX,
        .major =3D 9,
        .minor =3D 4,
-       .rev =3D 0,
+       .rev =3D 3,
        .funcs =3D &gfx_v9_4_3_ip_funcs,
 };

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index c46bc6aa4f48..c851413ba6b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2048,7 +2048,7 @@ const struct amdgpu_ip_block_version sdma_v4_4_2_ip_b=
lock =3D {
        .type =3D AMD_IP_BLOCK_TYPE_SDMA,
        .major =3D 4,
        .minor =3D 4,
-       .rev =3D 0,
+       .rev =3D 2,
        .funcs =3D &sdma_v4_4_2_ip_funcs,
 };

--
2.34.1

