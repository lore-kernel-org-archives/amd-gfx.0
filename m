Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FABBC6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 06:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC3B10E382;
	Thu,  2 Mar 2023 06:45:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 876E510E382
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 06:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kk0BxngOQ+wBzhIcPmbryOYBaMiQ27kQmf4VHLdZCGulN5fsuCdQOL/hl3nqIFmbX7V3e472dqMfbxDRaKX+XqS5BsnG3DFWkT91xspwWbT+qqZ4nGFDUgglkpspHQzPwsOJghAS/J8Bwr5kLxUpXyWi5JMRo2Ps+AD/aZ/1hCElBh6iZnol00xKNpb64Xn4tbhAHnuKzKeg/8WUe6V2yrNbAp3obkQY6Sp1qymkGWyP23YEdIJLnVQN3iBAK389Jgn8WoQoUvjKBNZZayCRdtWJt9H/gsN29Z6f1+ETCBa/LcIzIYwXK3GUG69yqJhhKhx39iIpfhN1BBFsCtdHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VEbPZ135QzvkGTgmmTKJUqA41VPnxJ3WuLC9xIun1k=;
 b=dhARFztdg/mBFcj5aXUuN0sTTsX9gDvNm28vdhQrD+z6m6S71YUIOmKEYXqpmP5Zd0k1qFJmyvW1hAkdIS+cLxWqZMRqZt7GCPe6L+VvR80C2rM+is/aHU2nCBNe1KHjJF7tdrjeX6Kq6hTAiqvkKb4Tzthdd0mX0t0G/skzZoRG0+4QtAGnl7gWIIzpaXRhW0Qnomeg1rlrpwdgTYH1HVnrc/9qR7mXzbBAOG7YMcczDfTEQYsQIuFUn3HSCO5QzblsSPPASHBwH6pQNr9Qz37wNsBv3dSM1jICNK6ynOx/s9QufLBRtKZJ2tvq2J2eWb6GRZk7hCBeJy3SMKJcyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VEbPZ135QzvkGTgmmTKJUqA41VPnxJ3WuLC9xIun1k=;
 b=O+ojXg6wG+tgfq0eFJpTWvs2JASzmNy8tG0LpPkvzuGS2aVpfogLbK5QogP4J2o9kLbgDzQJfxQBHXyJXGfxvnv2CMnm+6lNFOt8lFeYvNQuz7Aaoe1RCxwN4EJ9NQtpto03kOz2xKnONi2au5TuEB+opP2g9lkj9aLBuHFJHcM=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 06:45:26 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103%7]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 06:45:26 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Cui, Flora" <Flora.Cui@amd.com>, "Shi,
 Leslie" <Yuliang.Shi@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove unused variable
Thread-Topic: [PATCH] drm/amdgpu: remove unused variable
Thread-Index: AQHZTNJQeUeSGh3whUC20nRloiMwiq7nC3Lg
Date: Thu, 2 Mar 2023 06:45:26 +0000
Message-ID: <DM5PR12MB246985BACB1614DCD730B41AF1B29@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230302064330.87355-1-bob.zhou@amd.com>
In-Reply-To: <20230302064330.87355-1-bob.zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|BY5PR12MB4132:EE_
x-ms-office365-filtering-correlation-id: 7f3a5299-9300-4bf2-5721-08db1ae9b49d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /xf5cGV0/WuqZS9IUMMIkjXR4NfGdXCWhUq7DJyA2KEW0NacRKNmpZnWyY6cY3CM4O49pblS2s3PM4TR153zv+Eot2tmBUdL2Oe723A0IHSn2AclV9j2e+5qtVLMrCz+gUYt0k7QNZDckJNKYe2nixWTsyHtV0w9oBfntTtEcIn6laU8STCWn54kN8K8q0nfIQinhY79cT8+dTTZMlxmnreee97R4Nl3U1ieJes93mDD5ejhvoeJrBSQK5bhEiwjCCntorZYW13UBeDDY6s/ZckTR3HkRhknvrPCSboAUWGMpgMbr7fmGjlwI1XxMoCTf4pntxkSLiWZkKTc5ZKHB5gXoyKZR5KOTCVeasPX89JVVt7FWuSMpn9HULRFmTHDmi0FhixXF5ZuvMsMRxCHuCEO8k3C/10cAs0rGDd9AwzJ0loozsDqRdHpCPu1A5LHMBuMAzPvZJhSf8KOxvP7lKZdlexmvW1Vj5NcMRaG/c4NU+eMY9DIjIm4b3o+jZEtPorF3LK5897549XDePIpQFpw0SD0q2DbEuSE88uoZ8nDCdut6NjoQdTq5aaiy7L2n0FB4cni7tmR9ilter4QrxsS1oEq83fCiCxnA2BG+/Z0tUiqg0fT8Qgf0UoKH2lXGVPD8wGsUmmT8OXuIosIWhxjFeWxeDIP1OOT2xgsc49zl73RBJ+99qg4ibuv9MildV6CHtFFCJ+Ri5CPJGhEOQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(83380400001)(38100700002)(122000001)(5660300002)(478600001)(8936002)(52536014)(66556008)(33656002)(86362001)(38070700005)(55016003)(26005)(186003)(9686003)(53546011)(71200400001)(6506007)(66946007)(64756008)(66446008)(66476007)(8676002)(7696005)(2906002)(76116006)(316002)(4326008)(41300700001)(110136005)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nibt5DIniz4VhY//HCi0k7X7E9J2gIIR8G8SB6Up4F0yseWBUTY2qu9+MKrl?=
 =?us-ascii?Q?dO2NYe6JRMbTlw+NqHSBbg1Gx24a0ReO+SHxi0cgqOk0acWvizoljCLlisIx?=
 =?us-ascii?Q?KSCX2csLCYmB+s8M0yQrOyjfrUB0We+B+602S4z0l2bj1yZO58c/gIWhmZQ2?=
 =?us-ascii?Q?6MAaVCG5j3/UOU/7miZLmIUy2huYVvvXV+3+O/lSHoX6HnEn3IZR2CFOv6aA?=
 =?us-ascii?Q?ZAMuDBs4lvmw7ENoQw+l4ExS8sd7EjErXNB2u2wylzOFjiZdnD3HFyBPKjx6?=
 =?us-ascii?Q?MBiTQTFBXW+lKv6CdOMy5MkTh6bgfpUFtpciu2mu6RznblWgLtFLZsXWE63h?=
 =?us-ascii?Q?2PVTvJrLoYwJ+GpJmyPXH14aVyX4+RnLx3UlWTi07S2zfr5f/Gk7sVMLW7zv?=
 =?us-ascii?Q?6+z/cVMIOas+6vG/8W3LjXFpKuRSqIFON8X6YezJsjRsuxJAyggejgdMonH1?=
 =?us-ascii?Q?bgAtlq0HFIhUDEtoNI4UEfosdOYJapcsgJ6jh5KPIp/Eg4c8EVeBNyfJMHUr?=
 =?us-ascii?Q?STLL3nMIp2utZIMywCQ05n/Aq4s68xDClXfWrm1BRVQayMCbfeTv3xqlBNBH?=
 =?us-ascii?Q?3VwHWo1vf0mg5tzEnh3OoUuOSspGtdJzGrfJr8dxv91qpLrVR63VU5o2JGp3?=
 =?us-ascii?Q?nSl2KKPIHO4wI2c+Cj35VWvJtOfPHqR8CrvdQBHwj+H2pKdcDa00pS/Y4RSR?=
 =?us-ascii?Q?Y0E8meaFC1iu126Tv3KebFNb3mfNEkIMkdd+fw3jIfpejjcZiJepVi5PHKZr?=
 =?us-ascii?Q?o5V+cZH0042fzOKAnkNLsoCEvGhmrZp6dLVs+1dEbqBEo+WlDLWaHkDsSAn7?=
 =?us-ascii?Q?EjP8aukYHEdaX4HlENDzPS1GZy02p1sNngUI1C+Og9dqptAgVdZ9Ht+q871a?=
 =?us-ascii?Q?aYJShXszIGlKTLpL2yqvvdBiYVoJG3AfeX8WRipZmUi7higk6q698raQrNNt?=
 =?us-ascii?Q?Lw73G4OtMUXRt14Eb+uqSJarIhc6+eInIWOiJGfzhvk0zsKY12bs+C5JDtmW?=
 =?us-ascii?Q?DN5jW/k4Qaq91s+/E/BEOGSibaLwfUEwnWT2srdqqJv2sBwW19AsbEmIAi3S?=
 =?us-ascii?Q?kDZnWOlZcwqPzcJ/2Ot/KJuAkuzC7zlMLtC/ZcV4SdZFR43mOy/SKcwtfNrS?=
 =?us-ascii?Q?bZ6ryKTCpOA7BdAl/y85wNTJ5aNV//J4IK2GOYl10dv0SS+eZ8p1+TDQm6c7?=
 =?us-ascii?Q?xx6n5hmQwLeUlVr6OX+cUgFgEa41uya7sNqCgGqfGEId1OtzgJLBRKx/+3UN?=
 =?us-ascii?Q?DPUPUTtqw6U3hXIX1rbWajEILMe+1f+v2xTeEFHOTOh1iXhgMjLJxHClzN0B?=
 =?us-ascii?Q?QAFuhZRonGLg3pZP61Xc8VHtKL3hPjwWz16LWkV0sCYOQ41E9J+pDEEeHE/B?=
 =?us-ascii?Q?YNA1AWyO0dsSy5vfFUpLMrkHRTEqHvisHIxDbW+kvYNFAguGh5DK6H7ZM0ds?=
 =?us-ascii?Q?JaHTzkSl2cOCTXcW4RqMCHkuEl/IKea/4lUHmBuUAuyZ0bWJrujSj5J9liZw?=
 =?us-ascii?Q?+qKfBjvzG7h7L9LkDs1qkxu5W8nU20Pli1T1QT5gTJ3wayeCz6k8VNLNn4UT?=
 =?us-ascii?Q?lW24nr4AJQErW/1p4TZWskQlCeaAHWeFXjD7kPhi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3a5299-9300-4bf2-5721-08db1ae9b49d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 06:45:26.2344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vu2G35t/xn7QNDn3EUfYSVA2XZ2IR4Q7CgFjodcSiOPx0tE0dIS03bZK/0KeH6kuA9VV9Ps/BW2hk3vnMUGUKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
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
Cc: "Zhou, Bob" <Bob.Zhou@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: bobzhou <bob.zhou@amd.com>=20
Sent: Thursday, March 2, 2023 2:44 PM
To: amd-gfx@lists.freedesktop.org; Chen, Guchun <Guchun.Chen@amd.com>; Cui,=
 Flora <Flora.Cui@amd.com>; Shi, Leslie <Yuliang.Shi@amd.com>; Ma, Jun <Jun=
.Ma2@amd.com>
Cc: Zhou, Bob <Bob.Zhou@amd.com>
Subject: [PATCH] drm/amdgpu: remove unused variable

building with gcc and W=3D1 reports
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:7292:11: error:
unused variable 'tmp' [-Werror=3Dunused-variable]
  uint32_t tmp;
           ^~~

tmp is not used so remove it.

Signed-off-by: bobzhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 073f5f23bc3b..516409989235 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7266,7 +7266,6 @@ static int gfx_v10_0_hw_fini(void *handle)  {
 	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
 	int r;
-	uint32_t tmp;
=20
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
--
2.34.1

