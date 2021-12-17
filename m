Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA170C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 18:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C48610EFE9;
	Fri, 17 Dec 2021 18:00:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD67010EFE5
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 18:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJ6NFKkB/9hsfSgvcbX3dUXqOpzUbYaGXGoNQmDC7uzlBJN8WOzJbAYVW3se0EGAk9MuHvb2uNJc7zdlHKJiAwaYiL7ZG0XfW/vDZ5FETocYeIulrkX3FD8IBNJP6T8LUcyhcYDh2kHGlnwiIQwE0LFrYm7mZYmGyT6CxGCXSi207Uss2jkfhtrgPJm46rZkEMwb9fuu3qn9TsvS108quApiGn10xT6JaMiNKU0bwKwuLVQh+73NzqDGW3qYy5w/63C/80rGqIufAf2y4YpDwxS1/470NwH10EbwKw1v2Rcbk8n5dW8mEtOUDWzAxX+dkE3BhkX57W2V1xToGlRRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzEMLqHrvUZ8Z8d0bkopRModio1f3FPob9WAEIUdziI=;
 b=fc86kovXylFHS/KEfkYTrpmlGVW1pW+2Y7VKhRZRnUAsTqI3lOj6U6ziZ+gLkfHf4y9/XNIfYFoHM3TFRiGlRsaD5YGvRN0p2AcJgKM4AvxmCT0FEjbdi4Cmiz3RgO6VBMEXKI8xNpXvUij1aWR984kJ82gh5fJdtk24r1gjobvYhOZoGYjNeysE+xkKBhgK+e3jaUx0Er5B7+QnY+TbqrPPzFwV484O3T1vIwTkKkfNM7JUuSbB8xHBp2MVEZ/3OpFSAUeAMDv7Ra1SyhSvwC5RHs+I1/T8kakzSdxNalLyVo4q0Wzc8YXog1Qa+1aucQYQmCyw2TLXhA7Ak4zQrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzEMLqHrvUZ8Z8d0bkopRModio1f3FPob9WAEIUdziI=;
 b=TwMMmb9q5VVpBe4b1Rj/g7waJa969a87CH/eGKw57hUfWQ1NChAsq6lyeswrDxPXf4aifm85+2zXVUxfOQ/cNSooMNYjEeZS1rIhsJV0T91N7BLyT7nsOjvrXiYesiceXRmDwqXTAas4WqLhLINw9ALvgD/jhcQ3Agy3XHYNeHM=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5298.namprd12.prod.outlook.com (2603:10b6:610:d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Fri, 17 Dec
 2021 18:00:03 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563%8]) with mapi id 15.20.4778.017; Fri, 17 Dec 2021
 18:00:03 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Saye, Sashank" <Sashank.Saye@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough
 for sbr handling
Thread-Topic: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough
 for sbr handling
Thread-Index: AQHX820UvsBkio44fky1PIMH6/Vueqw29wEA
Date: Fri, 17 Dec 2021 18:00:03 +0000
Message-ID: <CH0PR12MB5372ECFD1470ED4816BF888AF4789@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211217173850.198047-1-sashank.saye@amd.com>
In-Reply-To: <20211217173850.198047-1-sashank.saye@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-17T17:52:59Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5b8bcc7b-ce3e-456c-b5cf-e74e9604688c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-17T18:00:01Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 88eaba68-b70b-470d-862f-5704fff16886
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfcaddac-c4b4-4b19-d389-08d9c1870d2b
x-ms-traffictypediagnostic: CH0PR12MB5298:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5298C512D16DC86902047A1EF4789@CH0PR12MB5298.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lrQOdoZno6jgGdTVJqvLbykBmKsQRahgM9DZ3VEd+b05EKwfuEQbvauofdgoOvp22mu8rsm5ihNyIYtvipEDFN23jd1uUZ2r2fYVHa9L6PPmUHzSUFTg9ZUSSbPm8d46OZFnh1wJNx9czSrW9Dyf8prGzgRvZx4JG8X+aarPSrATzNVh97vCI/9L1lPOUOyBEhvVi3G25Ak8pyprztLv1eJ1rcsGW5JCz7bqBNrrKqlOWhNmOGlfqNn9tn6v2bXa3/a4rZ3TpnvirH8olw/pPhnns9KzWlJB3/hhSYPtIJ46zcWWOle2/MnBylj5xeZGmWpk97haWl0eVeJXUaOFqSR0xEpQJ1OORn0kgw2sJ2Old/OtyKg7q3Tc6dg0KZCfWf0+cnZEIh3HFUK8bRaeCv8tIFXeUyK6Q8uLJUMTHYuYVVFBoO/k6kqom/JsfLv3ho1Uugspt/RkqGWQ9MWj3LM9Kxj6JQV/No5KmsTOkb5vq4CQfwMthBxeEL74RqWads6Bpe0kt9VzAo9Hjo/6E0oY8C4v54yrAPBoQqyYdtcYVYwdUDHZC7Q/+pHH3DilLqz3lOLL4ckiaZ3UYbGRXZJIDmSkQoFvew061zDr/UfLTWdhJhgeXxbD7GBOugvfQU/2XctEszQDpKY2iT3Ls3QBiBhQlHDnsLiPT//VUAqEhycz0O6LmQVd47KT2enbSTFSU+8lhFJ5yDunJPRhHg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(966005)(5660300002)(4326008)(7696005)(30864003)(8936002)(55016003)(9686003)(6506007)(316002)(8676002)(52536014)(122000001)(71200400001)(38100700002)(33656002)(110136005)(26005)(2906002)(66946007)(66556008)(64756008)(66476007)(66446008)(38070700005)(83380400001)(76116006)(15650500001)(86362001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kN+ZfP0j0x6JIVudZV6tQq/40PWbmFH/r0kJowdoXCoJHkcbmvfLaPy1JGnA?=
 =?us-ascii?Q?IpZU8+6Hus6/x2j5NdJgUNHZdlk+TFNdG35gUjh7d70dBb11FR4HYSGt8glo?=
 =?us-ascii?Q?oFB/Z3O1SlbgfcHLkdcOsagZf92ww8ttY/5DxDDxiPDlHZldwIcLhDEXX/4h?=
 =?us-ascii?Q?mSNAiM4qqnl4jn+0Ko9sDazWz8FCYArKCt/0nR7MsFVRzib8vMcTxm0+q3wd?=
 =?us-ascii?Q?VipeqVs4Y/XC7PhhNDqalKpT+xIF16Lxv1z95ZOey/8PJCBZeaT77XvkAr65?=
 =?us-ascii?Q?6cPnTR5RyKEvEg8o0bcUPygvfkzUwNDrKdsEMQv3D8VjQjq0Fa2cq2fM1E1u?=
 =?us-ascii?Q?vuooYVGG5+OaVzX7YvWr94WMnSdHGuPVL1xx0+CxQFne81B2GACHkrZR3LO4?=
 =?us-ascii?Q?CxnS8RSSeVHpKZOUsDfkFMkXFLat9AGlfjvv6cxZaHbftZFQo9+QrR+KzGIi?=
 =?us-ascii?Q?MSAcK9vKeak8rroJHtsBxumFlhJ4KwD1Opi2y3bsie6XeoNhBdcbb7JmeRSb?=
 =?us-ascii?Q?ir0NAe67byvhE4h78+YTX/rjjuHbhWWyOkK8FJDqRAntmxvutKdHP7054VvR?=
 =?us-ascii?Q?v47dqI2XKdIFWKRsuMk0xSGiIODCP/JFY8rb0HETRVEGvCCcDKYs26HQuKq2?=
 =?us-ascii?Q?l1wBewSS5Da9OzneoHKpTzwweV83qdSNQ/HWJskSWCD3oAjywOEe2n8uZXHW?=
 =?us-ascii?Q?nu8C/iutoWIyTcfzNCRl6/tNjP8KGyXDKRE5c8qyOBfgJMrowa3IdAdo1J//?=
 =?us-ascii?Q?ZZ/4CXxD9qdemGWr3Wv33t4EXo5iIl9sY1g2Se4D9J/2vGtBRyMJbzh6Vxh/?=
 =?us-ascii?Q?IFbn315u3dWrDKylVK9007SnGQb6XGEqmTGzBihkP9ZNLqGWga5cuZEx6if7?=
 =?us-ascii?Q?/lKMaksfP3G9dSYrsxGBVyjbeFLLM6L0fY1IBWZqY3O6yJQGp54IiuM/Mc4y?=
 =?us-ascii?Q?ULpduzP5VF/cvScKwldwJfYGw5xvVcrvIPMxvXQnNknL0I4aWQPyUZIxt+4f?=
 =?us-ascii?Q?NwnEDIQXidTCP5ycqcuvU8+1bFNNk2lE5RTzxaT2x5IoCiGg0dLDxxWFrqX6?=
 =?us-ascii?Q?aqbe2lv98WT9c18XpO87ejLrhtlKAvYDMY3tFD8aGJrYyw4Fmn4sWBx+DhKI?=
 =?us-ascii?Q?amhNijVYHNDFM5BFs8FUAMxGzH0kGV5kS6Xa4cQdiHzKMA1PfAl32vVsPdgj?=
 =?us-ascii?Q?bYyaDF5j17eZHA6P3m8cO/UAXxlLIjiVYSdMo3oIHJYjSrqNg3kvoXTOQ6bz?=
 =?us-ascii?Q?Ne8r8sn/zZx80y4hlaO1N1m0anCwyMdgDoh+076DvtHPnfLe1bxvXrM91kiq?=
 =?us-ascii?Q?/8ezOPHmkCfmoOc+54WtXRQ7ng29PEqDIBqaR464n9myUwo9D1HA8LjoJblI?=
 =?us-ascii?Q?2PqAMamnpNPOgDBdUNyW4f34DULmjbWmtMs7/IEA/jbH4GDLDgCMVQ0DBifv?=
 =?us-ascii?Q?xPldjC54uDKCUPax1JCEhPG5CMCEDHPbCJaI59mQL3Xgg4I1OnmoIfgJMwjw?=
 =?us-ascii?Q?xqOD0i94Oee2kyRCJqdO8UQo6tmsBJeoCcLbrCsEQp9OHZPw/2dUZxLC+lXa?=
 =?us-ascii?Q?uFhIuJxW3wJBXGO+Ks0V0Zq8lQgTB+qxPwTLC9L3zweRNLp3y9IUW7tF8qHW?=
 =?us-ascii?Q?AwDeBdaoZbVwqHV/3EEv3HA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5372ECFD1470ED4816BF888AF4789CH0PR12MB5372namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcaddac-c4b4-4b19-d389-08d9c1870d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 18:00:03.4342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a1fH8Y45VXtqxSrXRN6gQM5vldHQPcbupSHj8+DrOuRuAWfxzUsLTrbFRMBbRtdX8/iknFsguowQkXrmlOaNCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5298
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
Cc: "Saye, Sashank" <Sashank.Saye@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5372ECFD1470ED4816BF888AF4789CH0PR12MB5372namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

From your explanation , seems  SMU always need this special handling  for S=
BR on  passthrough mode , but in the  code , that only apply to XGMI config=
uration.  Should you change that as well ?  Two comments inline.

Regards
Shaoyun.liu



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of sashank =
saye
Sent: Friday, December 17, 2021 12:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Saye, Sashank <Sashank.Saye@amd.com>
Subject: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough f=
or sbr handling

For Aldebaran chip passthrough case we need to intimate SMU about special h=
andling for SBR.On older chips we send LightSBR to SMU, enabling the same f=
or Aldebaran. Slight difference, compared to previous chips, is on Aldebara=
n, SMU would do a heavy reset on SBR. Hence, the word Heavy instead of Ligh=
t SBR is used for SMU to differentiate.

Signed-off-by: sashank saye <sashank.saye@amd.com<mailto:sashank.saye@amd.c=
om>>
Change-Id: I79420e7352bb670d6f9696df97d7546f131b18fc
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  6 +++---
 drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h       |  4 +++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            |  6 +++---
 drivers/gpu/drm/amd/pm/inc/smu_types.h             |  3 ++-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h             |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  6 +++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 11 +++++++++++
 9 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f31caec669e7..01b02701121e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2618,11 +2618,11 @@ static int amdgpu_device_ip_late_init(struct amdgpu=
_device *adev)
        if (r)
                DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);

-       /* For XGMI + passthrough configuration on arcturus, enable light S=
BR */
-       if (adev->asic_type =3D=3D CHIP_ARCTURUS &&
+       /* For XGMI + passthrough configuration on arcturus and aldebaran, =
enable light SBR */
+       if ((adev->asic_type =3D=3D CHIP_ARCTURUS || adev->asic_type =3D=3D
+CHIP_ALDEBARAN ) &&
            amdgpu_passthrough(adev) &&
            adev->gmc.xgmi.num_physical_nodes > 1)

[shaoyunl] , Should this apply to none  XGMI configuration as well?

-               smu_set_light_sbr(&adev->smu, true);
+               smu_handle_passthrough_sbr(&adev->smu, true);

        if (adev->gmc.xgmi.num_physical_nodes > 1) {
                mutex_lock(&mgpu_info.mutex);
diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm=
/amd/pm/inc/aldebaran_ppsmc.h
index 35fa0d8e92dd..ab66a4b9e438 100644
--- a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
@@ -102,7 +102,9 @@

 #define PPSMC_MSG_GfxDriverResetRecovery       0x42
 #define PPSMC_MSG_BoardPowerCalibration        0x43
-#define PPSMC_Message_Count                    0x44
+#define PPSMC_MSG_HeavySBR                      0x45
+#define PPSMC_Message_Count                    0x46
+

 //PPSMC Reset Types
 #define PPSMC_RESET_TYPE_WARM_RESET              0x00
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index 2b9b9a7ba97a..ba7565bc8104 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1257,9 +1257,9 @@ struct pptable_funcs {
        int (*set_fine_grain_gfx_freq_parameters)(struct smu_context *smu);

        /**
-        * @set_light_sbr:  Set light sbr mode for the SMU.
+        * @smu_handle_passthrough_sbr:  Send message to SMU about special =
handling for SBR.
         */
-       int (*set_light_sbr)(struct smu_context *smu, bool enable);
+       int (*smu_handle_passthrough_sbr)(struct smu_context *smu, bool
+enable);

        /**
         * @wait_for_event:  Wait for events from SMU.
@@ -1415,7 +1415,7 @@ int smu_allow_xgmi_power_down(struct smu_context *smu=
, bool en);

 int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);

-int smu_set_light_sbr(struct smu_context *smu, bool enable);
+int smu_handle_passthrough_sbr(struct smu_context *smu, bool enable);

 int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type eve=
nt,
                       uint64_t event_arg);
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/p=
m/inc/smu_types.h
index 18b862a90fbe..ff8a0bcbd290 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -229,7 +229,8 @@
        __SMU_DUMMY_MAP(BoardPowerCalibration),   \
        __SMU_DUMMY_MAP(RequestGfxclk),           \
        __SMU_DUMMY_MAP(ForceGfxVid),             \
-       __SMU_DUMMY_MAP(UnforceGfxVid),
+       __SMU_DUMMY_MAP(UnforceGfxVid),           \
+       __SMU_DUMMY_MAP(HeavySBR),

 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)  SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/p=
m/inc/smu_v11_0.h
index 2d422e6a9feb..acb3be292096 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -312,7 +312,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *sm=
u,

 void smu_v11_0_interrupt_work(struct smu_context *smu);

-int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable);
+int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool
+enable);

 int smu_v11_0_restore_user_od_settings(struct smu_context *smu);

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index af98fa140d83..76f95e8ada4c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3058,13 +3058,13 @@ static int smu_gfx_state_change_set(void *handle,
        return ret;
 }

-int smu_set_light_sbr(struct smu_context *smu, bool enable)
+int smu_handle_passthrough_sbr(struct smu_context *smu, bool enable)
 {
        int ret =3D 0;

        mutex_lock(&smu->mutex);
-       if (smu->ppt_funcs->set_light_sbr)
-               ret =3D smu->ppt_funcs->set_light_sbr(smu, enable);
+       if (smu->ppt_funcs->smu_handle_passthrough_sbr)
+               ret =3D smu->ppt_funcs->smu_handle_passthrough_sbr(smu, ena=
ble);
        mutex_unlock(&smu->mutex);

        return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 58bc387fb279..505d2fb94fd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2472,7 +2472,7 @@ static const struct pptable_funcs arcturus_ppt_funcs =
=3D {
        .deep_sleep_control =3D smu_v11_0_deep_sleep_control,
        .get_fan_parameters =3D arcturus_get_fan_parameters,
        .interrupt_work =3D smu_v11_0_interrupt_work,
-       .set_light_sbr =3D smu_v11_0_set_light_sbr,
+       .smu_handle_passthrough_sbr =3D smu_v11_0_handle_passthrough_sbr,
        .set_mp1_state =3D smu_cmn_set_mp1_state,  };

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index 28b7c0562b99..4e9e2cf39859 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1724,7 +1724,7 @@ int smu_v11_0_mode1_reset(struct smu_context *smu)
        return ret;
 }

-int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable)
+int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool
+enable)
 {
        int ret =3D 0;

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7433a051e795..2813ab2cc336 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -141,6 +141,7 @@ static const struct cmn2asic_msg_mapping aldebaran_mess=
age_map[SMU_MSG_MAX_COUNT
        MSG_MAP(SetUclkDpmMode,                      PPSMC_MSG_SetUclkDpmMo=
de,                  0),
        MSG_MAP(GfxDriverResetRecovery,              PPSMC_MSG_GfxDriverRes=
etRecovery,          0),
        MSG_MAP(BoardPowerCalibration,               PPSMC_MSG_BoardPowerCa=
libration,           0),
+       MSG_MAP(HeavySBR,                            PPSMC_MSG_HeavySBR,   =
                     0),
 };

 static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] =3D =
{ @@ -1912,6 +1913,15 @@ static int aldebaran_mode2_reset(struct smu_contex=
t *smu)
        return ret;
 }

+static int aldebaran_smu_handle_passthrough_sbr(struct smu_context
+*smu, bool enable) {
+       int ret =3D 0;
+       //For alderbarn chip, SMU would do a mode 1 reset as part of SBR he=
nce we call it HeavySBR instead of light
[Shaoyunl], Don't use "//" for comments , use "/*   */ " if you want.   See=
ms this comment is not needed here .

+       ret =3D  smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_HeavySBR, ena=
ble ?
+1 : 0, NULL);
+
+       return ret;
+}
+
 static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)  {=
  #if 0 @@ -2021,6 +2031,7 @@ static const struct pptable_funcs aldebaran_p=
pt_funcs =3D {
        .get_gpu_metrics =3D aldebaran_get_gpu_metrics,
        .mode1_reset_is_support =3D aldebaran_is_mode1_reset_supported,
        .mode2_reset_is_support =3D aldebaran_is_mode2_reset_supported,
+       .smu_handle_passthrough_sbr =3D aldebaran_smu_handle_passthrough_sb=
r,
        .mode1_reset =3D aldebaran_mode1_reset,
        .set_mp1_state =3D aldebaran_set_mp1_state,
        .mode2_reset =3D aldebaran_mode2_reset,
--
2.25.1



--_000_CH0PR12MB5372ECFD1470ED4816BF888AF4789CH0PR12MB5372namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12pt;"><=
a name=3D"_msipheader9f8d35bc"></a>
<div><font face=3D"Arial" size=3D"2" color=3D"blue"><span style=3D"font-siz=
e:10pt;">[AMD Official Use Only]<br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">From=
 your explanation , seems&nbsp; SMU always need this special handling&nbsp;=
 for SBR on&nbsp; passthrough mode , but in the&nbsp; code , that only appl=
y to XGMI configuration.&nbsp; Should you change that as well ?&nbsp;
Two comments inline.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Shao=
yun.liu</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of sa=
shank saye<br>

Sent: Friday, December 17, 2021 12:39 PM<br>

To: amd-gfx@lists.freedesktop.org<br>

Cc: Saye, Sashank &lt;Sashank.Saye@amd.com&gt;<br>

Subject: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough f=
or sbr handling</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">For =
Aldebaran chip passthrough case we need to intimate SMU about special handl=
ing for SBR.On older chips we send LightSBR to SMU, enabling the same for A=
ldebaran. Slight difference, compared
to previous chips, is on Aldebaran, SMU would do a heavy reset on SBR. Henc=
e, the word Heavy instead of Light SBR is used for SMU to differentiate.</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: sashank saye &lt;<a href=3D"mailto:sashank.saye@amd.com">sashank=
.saye@amd.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Chan=
ge-Id: I79420e7352bb670d6f9696df97d7546f131b18fc</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp; 6 +++---</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |&nbsp; 4 +++-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 +++---</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/inc/smu_types.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 ++-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/inc/smu_v11_0.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 6 +++---</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c&nbsp; |&nbsp; 2 +-</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;=
 2 +-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 11 +++++++++++</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 9 f=
iles changed, 28 insertions(+), 14 deletions(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_device.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x f31caec669e7..01b02701121e 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
2618,11 +2618,11 @@ static int amdgpu_device_ip_late_init(struct amdgpu_dev=
ice *adev)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;enable mgpu fan boost failed (%d).\n&quot=
;, r);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For XGMI + passthrough configuration o=
n arcturus, enable light SBR */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_ARCTUR=
US &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For XGMI + passthrough configuration o=
n arcturus and aldebaran, enable light SBR */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type =3D=3D CHIP_ARCTU=
RUS || adev-&gt;asic_type =3D=3D </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+CHI=
P_ALDEBARAN ) &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu=
_passthrough(adev) &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&=
gt;gmc.xgmi.num_physical_nodes &gt; 1)</span></font></div>
<div><font size=3D"2" color=3D"red"><span style=3D"font-size:11pt;">&nbsp;<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"red"><span style=3D"font-si=
ze:11pt;">[shaoyunl] , Should this apply to none&nbsp; XGMI configuration a=
s well? </span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; smu_set_light_sbr(&amp;adev-&gt;smu, true);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; smu_handle_passthrough_sbr(&amp;adev-&gt;smu, true);</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_phys=
ical_nodes &gt; 1) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; mutex_lock(&amp;mgpu_info.mutex);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm/amd=
/pm/inc/aldebaran_ppsmc.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 35fa0d8e92dd..ab66a4b9e438 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
102,7 +102,9 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine PPSMC_MSG_GfxDriverResetRecovery&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
x42</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine PPSMC_MSG_BoardPowerCalibration&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x43</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x44</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine PPSMC_MSG_HeavySBR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x45</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+#de=
fine PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x46</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> //P=
PSMC Reset Types</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine PPSMC_RESET_TYPE_WARM_RESET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/i=
nc/amdgpu_smu.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 2b9b9a7ba97a..ba7565bc8104 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1257,9 +1257,9 @@ struct pptable_funcs {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_fine_grain_gfx_freq_=
parameters)(struct smu_context *smu);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @set_light_sbr:&nbsp; Set light s=
br mode for the SMU.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @smu_handle_passthrough_sbr:&nbsp=
; Send message to SMU about special handling for SBR.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_light_sbr)(struct smu_context *=
smu, bool enable);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*smu_handle_passthrough_sbr)(struct =
smu_context *smu, bool </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ena=
ble);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @wait_for_event:&nbsp;=
 Wait for events from SMU.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1415,7 +1415,7 @@ int smu_allow_xgmi_power_down(struct smu_context *smu, bo=
ol en);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-int=
 smu_set_light_sbr(struct smu_context *smu, bool enable);</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 smu_handle_passthrough_sbr(struct smu_context *smu, bool enable);</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t event_=
arg);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/in=
c/smu_types.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 18b862a90fbe..ff8a0bcbd290 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/inc/smu_types.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/inc/smu_types.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
229,7 +229,8 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(BoardPowerCali=
bration),&nbsp;&nbsp; \</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(RequestGfxclk)=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(ForceGfxVid),&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(UnforceGfxVid),</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(UnforceGfxVid),&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(HeavySBR),</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #un=
def __SMU_DUMMY_MAP</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine __SMU_DUMMY_MAP(type)&nbsp; SMU_MSG_##type</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/in=
c/smu_v11_0.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 2d422e6a9feb..acb3be292096 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
312,7 +312,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> voi=
d smu_v11_0_interrupt_work(struct smu_context *smu);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-int=
 smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable);</span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool </span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ena=
ble);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> int=
 smu_v11_0_restore_user_od_settings(struct smu_context *smu);</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm=
/swsmu/amdgpu_smu.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x af98fa140d83..76f95e8ada4c 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
3058,13 +3058,13 @@ static int smu_gfx_state_change_set(void *handle,</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-int=
 smu_set_light_sbr(struct smu_context *smu, bool enable)</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 smu_handle_passthrough_sbr(struct smu_context *smu, bool enable)</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mutex)=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs-&gt;set_light_sbr)<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D smu-&gt;ppt_funcs-&gt;set_light_sbr(smu, enable);</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs-&gt;smu_handle_pass=
through_sbr)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ret =3D smu-&gt;ppt_funcs-&gt;smu_handle_passthrough_sbr(smu, enable=
);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;mute=
x);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/dr=
m/amd/pm/swsmu/smu11/arcturus_ppt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 58bc387fb279..505d2fb94fd9 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
2472,7 +2472,7 @@ static const struct pptable_funcs arcturus_ppt_funcs =3D =
{</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .deep_sleep_control =3D smu_v1=
1_0_deep_sleep_control,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_parameters =3D arctur=
us_get_fan_parameters,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .interrupt_work =3D smu_v11_0_=
interrupt_work,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_light_sbr =3D smu_v11_0_set_light_sb=
r,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_handle_passthrough_sbr =3D smu_v11_0=
_handle_passthrough_sbr,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state =3D smu_cmn_set=
_mp1_state,&nbsp; };</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/a=
md/pm/swsmu/smu11/smu_v11_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 28b7c0562b99..4e9e2cf39859 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1724,7 +1724,7 @@ int smu_v11_0_mode1_reset(struct smu_context *smu)</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-int=
 smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable)</span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+int=
 smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool </span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+ena=
ble)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/aldebaran_ppt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 7433a051e795..2813ab2cc336 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
141,6 +141,7 @@ static const struct cmn2asic_msg_mapping aldebaran_message_=
map[SMU_MSG_MAX_COUNT</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetUclkDpmMode,&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetUclkDpmMode,&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(GfxDriverResetRecovery=
,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; PPSMC_MSG_GfxDriverResetRecovery,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0),</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(BoardPowerCalibration,=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; PPSMC_MSG_BoardPowerCalibration,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(HeavySBR,&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_H=
eavySBR,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> };<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] =3D { @@=
 -1912,6 +1913,15 @@ static int aldebaran_mode2_reset(struct smu_context *s=
mu)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> }</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+sta=
tic int aldebaran_smu_handle_passthrough_sbr(struct smu_context </span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+*sm=
u, bool enable) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //For alderbarn chip, SMU would do a mode=
 1 reset as part of SBR hence we call it HeavySBR instead of light</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"red"><span style=3D"font-si=
ze:11pt;">[Shaoyunl], Don't use &quot;//&quot; for comments , use &quot;/*&=
nbsp;&nbsp; */ &quot; if you want.&nbsp;&nbsp; Seems this comment is not ne=
eded here . </span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D&nbsp; smu_cmn_send_smc_msg_with_p=
aram(smu, SMU_MSG_HeavySBR, enable ? </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+1 :=
 0, NULL);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)&nbsp; =
{&nbsp; #if 0 @@ -2021,6 +2031,7 @@ static const struct pptable_funcs aldeb=
aran_ppt_funcs =3D {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_gpu_metrics =3D aldebaran=
_get_gpu_metrics,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset_is_support =3D al=
debaran_is_mode1_reset_supported,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode2_reset_is_support =3D al=
debaran_is_mode2_reset_supported,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_handle_passthrough_sbr =3D aldebaran=
_smu_handle_passthrough_sbr,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset =3D aldebaran_mod=
e1_reset,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state =3D aldebaran_s=
et_mp1_state,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode2_reset =3D aldebaran_mod=
e2_reset,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.25=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font size=3D"2"><span style=3D"font-size:11pt;">&nbsp;</span></font><=
/div>
</span></font>
</body>
</html>

--_000_CH0PR12MB5372ECFD1470ED4816BF888AF4789CH0PR12MB5372namp_--
