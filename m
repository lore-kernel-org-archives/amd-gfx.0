Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5FCC25B48
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 01:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194D710E529;
	Wed, 25 Oct 2023 01:44:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8851E10E529
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 01:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BISFH4XU5DlPTownTn7o0EOg45qQW2LtBLdSGBOZkY/rZrG3JclT98wFitmIC6OJ63cZ0Y3e0Iw4ybkAhUboWbUHyvhnLhPhsjsCnn/q7FgYfFl8RPGMqhZ3OnsLb6RuZmkhsMky7DM2WHegIb2hN5LQ1lsEbXyb5G1GUR35yaCw2CykSbFY7RZeLETC+5D3Bu9b4gCta3x7A59LBQ6M7QZ3K6fDpsKgvP7XIYmJTnkAG9X9uNXU/2NO2plOVuohpqquR4/8FvyCBBPITrBPagSCDLdgXKQwqLSckLle3lBnswwnNw4BmEDakYgrN97Ax2IGZ/jD8vOQdNYURk5jzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKBuEHHJ30WNsdnHcW23Dhp9kupd4rO2wrGRqxrME9c=;
 b=Tcju4PyfNi95axaviQQVVc1XI4LTAOJV8ZCsuS6CTGkMNgPT91VNESkMX00xR7YmZh65GBumNo8Scs8GfN3ZIdgLOGGmnK+AV7h+5AKdsHm0319R0GQyD/nZgO2uN5WTnZ2hxKjRQiHUfht2V4ZXtpU57wqoBOcaFk5p280QEkdAkNiBzqxis91CCNTlbl0PwLvAN9ypXacg0SYichSE+WkgsmT29t3A0G/cQCTqUiTVii64lnc5dYST8PBaAkQhGBXa3RWtq4K+Jrp+PFRhgDHoYeHtMCbC0sdKGnXjwn2fQWcWLzhwI5z32/96JNKSRe5stbtiyvN5pl9mcjp93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKBuEHHJ30WNsdnHcW23Dhp9kupd4rO2wrGRqxrME9c=;
 b=HBASpdhPNezSi7PKaVzbegMuycjS2z5vC87EbSniDq7U6OjmI89DCxck9OqMavgARwRREVxLxX3ipSOisVa9OF+cHimh8UYpnEsjJ+VRkrK9DCtf7fJRf93JMSpa6LllTqjb271FR95tkRVcIaBzkwh46iNI7LrHuizGT/71cWg=
Received: from MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 by IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 01:44:16 +0000
Received: from MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::9236:d15e:dad2:96a3]) by MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::9236:d15e:dad2:96a3%4]) with mapi id 15.20.6907.022; Wed, 25 Oct 2023
 01:44:16 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/pm: call smu_cmn_get_smc_version in
 is_mode1_reset_supported.
Thread-Topic: [PATCH v2] drm/amd/pm: call smu_cmn_get_smc_version in
 is_mode1_reset_supported.
Thread-Index: AQHaBuQxDctGI5aAlUCHbvt+GNPQQ7BZu7lw
Date: Wed, 25 Oct 2023 01:44:16 +0000
Message-ID: <MW4PR12MB68757D629216D310A80D265591DEA@MW4PR12MB6875.namprd12.prod.outlook.com>
References: <20231025013943.1604055-1-yifan1.zhang@amd.com>
In-Reply-To: <20231025013943.1604055-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b0e7255c-b30f-420a-ae2a-ea7d519d2ea9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-25T01:44:12Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6875:EE_|IA0PR12MB8255:EE_
x-ms-office365-filtering-correlation-id: 2ac1bc38-f5f3-4f81-14f5-08dbd4fbe5d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sMZBgPcg2AwUaePoSH8XEw23s1pMXi7ovLi2qIo30IGHHw43Q2DDyjcP+Ar4u114kHyjv41/pfhGzO5tULzDUkGYFaIaOepFOVN9TUnV8fZuy29WCRhQVZ0sV2+tQzo0kFTKrbG/KY7/B6SVOdDdw9vL6an/Q/EfEqnG+twm9VuovzriKm+MQkWgB3aR75dNxLrckBbhIECZ7UGEqSGrOX7i5cIpIKqPm+Y18bcAxIfb2sKRwAxFNcR1DV8PFw0opOXHWx/nH6Tc06s74dfOax1SNRjKXpo5UAew65WaWvzEL5p78z9uGQs9MnUpuCD6As3e/BsN88FSKCN/EYW+MBntac4BoFtoaNK4UmKJCa1SLIJN357tV3ssnjF43hV7R+In8rySv20ev4JtZFrGLhQBvVFHVA16/9ZiZHF8PpglVMURmWtD+D3VcenHG0e6mr9yZQ6cFxWTp7dZVyLG++a0EGe81zqDiyZcNvX5/iUA1Fzl8dbbwElUh1y4ENtSApXLkZb21cMG/ifHRG1TVboBXHZejTMylOEPZxkFu5TvEwtFzez1jIJxPgTI3b3RrrP4U1YJjg0go85vIOUsv08w6f+BrEwWpM9qtFwulHXgRHotqL+y+pOXaU0AeYCo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6875.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(122000001)(26005)(6506007)(53546011)(38070700009)(8676002)(5660300002)(52536014)(41300700001)(4326008)(8936002)(7696005)(33656002)(38100700002)(2906002)(9686003)(55016003)(66446008)(66476007)(64756008)(478600001)(110136005)(316002)(86362001)(66556008)(54906003)(66946007)(76116006)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WjzvsMsc2aVERsFcaY6VJ2ID6s8Ofj9Hr5oBbM7CEpT4DVlGeyzx2uWH3Qqc?=
 =?us-ascii?Q?cyAVBn03nPpDrN2vwFvrDP9FZqDZL3eqlqcrDWmvVSvIHEp7IpdGp05crzuj?=
 =?us-ascii?Q?c2T4pxfzr6pYqWXrZ2JBH8r2nDkN2GcLVSwHtzx+EX6EI1+jlHXsqLkVe0zs?=
 =?us-ascii?Q?OWI/IqqxV1jyNbK+W9CMIAytluNA+nK6sgmUBNpz6E/HJ6L+StygXGDJsrY5?=
 =?us-ascii?Q?6AFAAsHO4vAS5yEXElr5FLGRZJXm1/ZkdZswLjauJb5ytDHS9Hvyza+65Q8y?=
 =?us-ascii?Q?0P4R5t4OigUy+MdtNgGc36PVMHDcT27iXSNZ4DiUJ7ZV6pZbLOaVh5W8miLf?=
 =?us-ascii?Q?DybwfYxlIXHDH1ebWV0S/N8k9SLjKAx3Gp7M8zDkPI2OKm09fDJve61f6p2Q?=
 =?us-ascii?Q?9e+TcnsYEox5fNNcQDcb+NI08cfWHcN99tACQW3IjlIA6guxjYs4UbZ3R6S4?=
 =?us-ascii?Q?h86QZySiM00jAZPc+CtUiUyLdfDxmnIYXlHNTD0vZEVOAAVOUcb9Pxa+qO28?=
 =?us-ascii?Q?EM3SyNDhUGwCRviD3cRE5Nd9+1udwHlwgxEAhPpk6M4IBS5W9Wg6w/19CFNa?=
 =?us-ascii?Q?+f45QMjxn0EQvx/duD4WJlQYSGuCx+GBNdN9KeHrV4M7eL+n8XD/k+38zGG0?=
 =?us-ascii?Q?8eI5NucOFKWzrM3vebun9iJgK1YrYFTcq1TEMhZ8cYqvr+r4NhzTSnASjGc5?=
 =?us-ascii?Q?a/WEf+S4g+19uBgzrqlvHWRBqR7SukMewFzScaL/C8vDAlEnaQ4FgjgbJ0HT?=
 =?us-ascii?Q?i0FvcFjwvfWtpqN62N0sRDeu0wQsLU31sHzQQ+2r8lKQ7scBpYTBBTClltbv?=
 =?us-ascii?Q?78yiHxQEdVNsfF43troXQvpKbr4W3zjz55+UDz9n+5TxNuGlbUPcrZjC+Zpg?=
 =?us-ascii?Q?r4KOO4vlRwiVosuiFqeF01R1JFmEdZW+Ed72CFKbImY1Xvg9yI/h96t+RIKo?=
 =?us-ascii?Q?TMn01ecXzHqP2Hh7gfEmAKM3Is8wZPHKFPn6u/cGqZNsHV3QLvk+eghL+/Lm?=
 =?us-ascii?Q?UeckUcY04WhuA5sPNNi7FJ14RZXS6acmr+VDXKJcz4/7DyA9ZaBCtA3mO/9n?=
 =?us-ascii?Q?IZTogsHWAj3uJ++UNX4YF3E2gTEL8qaYMkvE6KDb4PO+vVdEmTaiXoOuDRZW?=
 =?us-ascii?Q?nGkyL0UkBjCJkuRmyrNDC01HuKpNqkxi+eo6JPEnpzJgRCDConD75iEEm7a+?=
 =?us-ascii?Q?7em9tBlXnGLvbbD2s+58aYzYlsFOf4t2E7AGlvZx71BTvqMQkGTPwGcG5jPE?=
 =?us-ascii?Q?zGBs3+c8KjQ4nH0f6bIwQP2z2hx4XeenQ9ZQ96ixXOQOBuyuruno9aMRfTLY?=
 =?us-ascii?Q?dfyzAH0Pjw/reNScvk3DVe3NHOCusjD6eF1/lQcm2UgkWBKMEBZGAeLU3Wm0?=
 =?us-ascii?Q?TRYmWL10e45Km7y+8Rcb5WYZt6DGiOQe/i1ef7Q6QoPaJpX54w1faDhlsXwA?=
 =?us-ascii?Q?R85hy97mmsz6+HnHpb70hzrDRTEYaT9EgkLeuNEc0kl6qHrN69yI5rFSkhfp?=
 =?us-ascii?Q?sF0Y13t1CVmUaXDs9AzrTBeHvz1DU64lydikWbZ1nf+i6z46yjmkpqMWfgMD?=
 =?us-ascii?Q?Qx6EmSSOz3lmKnp89Iw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6875.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac1bc38-f5f3-4f81-14f5-08dbd4fbe5d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 01:44:16.0936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNeXTjaUcj/MIldU3OmnspeHNP2jidRBqlD2f2YThWoWEDoUix485vRGxFdjwQ1l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Candice Li <candice.li@amd.com>



Thanks,
Candice

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Wednesday, October 25, 2023 9:40 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Li, Candice <C=
andice.Li@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH v2] drm/amd/pm: call smu_cmn_get_smc_version in is_mode1_re=
set_supported.

is_mode1_reset_supported may be called before smu init, when smu_context
is unitialized in driver load/unload test. Call smu_cmn_get_smc_version
explicitly in is_mode1_reset_supported.

v2: apply to aldebaran in case is_mode1_reset_supported will be
uncommented (Candice Li)

Fixes: 5fe5098c64d9 ("drm/amd/pm: drop most smu_cmn_get_smc_version in smu"=
)
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  8 +++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c     | 10 +++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  8 +++++++-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 090249b6422a..77c3d76c76a2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2461,12 +2461,18 @@ static bool sienna_cichlid_is_mode1_reset_supported=
(struct smu_context *smu)
 {
        struct amdgpu_device *adev =3D smu->adev;
        uint32_t val;
+       uint32_t smu_version;
+       int ret;

        /**
         * SRIOV env will not support SMU mode1 reset
         * PM FW support mode1 reset from 58.26
         */
-       if (amdgpu_sriov_vf(adev) || (smu->smc_fw_version < 0x003a1a00))
+       ret =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
+       if (ret)
+               return false;
+
+       if (amdgpu_sriov_vf(adev) || (smu_version < 0x003a1a00))
                return false;

        /**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index f082cd4b40c1..1a6675d70a4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1931,11 +1931,19 @@ static bool aldebaran_is_mode1_reset_supported(stru=
ct smu_context *smu)
 #if 0
        struct amdgpu_device *adev =3D smu->adev;
        uint32_t val;
+       uint32_t smu_version;
+       int ret;
+
        /**
         * PM FW version support mode1 reset from 68.07
         */
-       if ((smu->smc_fw_version < 0x00440700))
+       ret =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
+       if (ret)
                return false;
+
+       if ((smu_version < 0x00440700))
+               return false;
+
        /**
         * mode1 reset relies on PSP, so we should check if
         * PSP is alive.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index b1433973380b..648d5eafb27b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2615,13 +2615,19 @@ static int smu_v13_0_0_baco_exit(struct smu_context=
 *smu)
 static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu)
 {
        struct amdgpu_device *adev =3D smu->adev;
+       u32 smu_version;
+       int ret;

        /* SRIOV does not support SMU mode1 reset */
        if (amdgpu_sriov_vf(adev))
                return false;

        /* PMFW support is available since 78.41 */
-       if (smu->smc_fw_version < 0x004e2900)
+       ret =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
+       if (ret)
+               return false;
+
+       if (smu_version < 0x004e2900)
                return false;

        return true;
--
2.37.3

