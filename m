Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC20C4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 05:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B25D10E400;
	Tue, 31 Oct 2023 05:48:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44FC210E400
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 05:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPU8YHzvAxmP7alXxg/z+Ib1w5jrI/2icSQRkywVdJnPcOO+augWb6Ikv1iSkpWpAooe4A8LnX3UD5ENOMh53xsuYVDcd1XNZKoi78phIaopx9wftYhQXhnMSlfzDplAo88cAnIiFJOTDhBYmlb8JoUiZKXzd1pZ+IWYLYUbT100JK00qpmv5CUkm7jbq3JlruWcSjlsLGYqqA1bEvIq1afpcLc2iZm+SCAkx4derXAnnwQ4WWEQpE/c/eTfaZN7cKJNTmI7A66nwFII8G4bfd3Fqt8eptMp/P0hKM4BUD6xO1SEP6KUyDV+V4WdWomG4lK+JbuZOYNueekbDFBOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zsh9jkXENH2GDBZSdsCbmrdd+xFnU/DIGLFv4lHjsH4=;
 b=oW12+Lc73P0yXzbNLYznAjUowPbWwiuogEDtefX3FQv+5CSGSaDADEqb/7gouA5qRn0B9xAADoFdNcimVWlxdTlxI16FtXKWeFAtCkpKmrg0tural1oILQKLlVLlsPrkpvg5Zzig1p33lRi7YO/BJJNG1xC3yqLzGOLLp84MX0GleOlrKzHv6tKNwZviTvoAFxb2cFSciuvrHz9DtzULGHv92xyMkIXw0N+fbCgjsj53pnA407Zzjs7Sc8n8a3hfGI4LsowaREZfhDm2nTpLGsE00AZLl37fW7qhUGJLJyuAGPtSvX9RVmVt3wdSsVzDGDy7TPp3gm+OdZ1Du0dv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zsh9jkXENH2GDBZSdsCbmrdd+xFnU/DIGLFv4lHjsH4=;
 b=1n2/jirZuCWgAqUJBtSc5NEyvGeEQ4Q/0pjLgq1QO51vBsJZjIq5xwAS5gs3TefB0JPyLLRYrafi5IIHAIwuchkDQOVnDTqLERhawzfk/GnpGfguRwMCbYqAOMm12ox6FJzlZjRPcpgNw8aigm23k3VYraTgQ+9rWGAhx8ssFj0=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Tue, 31 Oct
 2023 05:48:18 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::56ea:81b8:478b:821b]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::56ea:81b8:478b:821b%7]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 05:48:17 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix error of MACO flag setting code
Thread-Topic: [PATCH] drm/amd/pm: Fix error of MACO flag setting code
Thread-Index: AQHaC70pFRR0xeH9JU6MG7ACQeDhrLBjZCEQ
Date: Tue, 31 Oct 2023 05:48:17 +0000
Message-ID: <DM4PR12MB5165D2F4153C2DE2C1A5FBE58EA0A@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20231031054254.1912290-1-Jun.Ma2@amd.com>
In-Reply-To: <20231031054254.1912290-1-Jun.Ma2@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=94f04af6-aca2-4e0f-9168-7d8ed7992a51;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-31T05:47:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|PH7PR12MB6588:EE_
x-ms-office365-filtering-correlation-id: d120f069-a20b-4f10-5bd0-08dbd9d4fb80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YLQaHlKlV+yVS/jz+ZNd1hCTMNoCsG1+lAW4ym9nfoDrMfSDHoUoRblWzqWdQuTNq71YYHEkrrTDctZTTEvO/4u5uqTUwR0GSYkxBNexQYth2Bgzbc4wu5BWAZnDebQYHRxeALgtJAAIol3X6yJc1mFuSfUz0c9cDE+gJjclWEeogvELYCCYL52OwgP522QteREx9XhTIuSoJtg2x2yDMK8j3/Ilvjq3M4m/PvNIL19gHd4/XmCCz6XO/GpLC/KMGSUc09yowtmsMrCrpT8Yu0LBddR1iLyX8TjbLvHPnxEQ1DW5pkXly7hvA84ULYw9CkPLDd0O1y4DrAwWhdTVCtojG819dKYiZ101VrZYhAYd7P+Hgc/X0bJ8BrBHhtU/b246noRrxReFKYXe3P82pZl/N4LpcVRvlA6R4LCyBfbh/75mh47LbKj/HDMluuV9Z7l3RLWq1ZNSFA+v8xY4D1Od8aOCVnALRmi4mDOtrjbJIBstQr2KL2Yu1IEt4EUFv6y7cyFbL++b0uEyjajLer5SuJJdFVN3+Mnx+/DsReJctBXA+6myhArcn9/HnVl6VJJKspDWqihUPO5Y4cSuHrEEo1CKmMZWnEC1NsOJ9Hu2n2jDH82I3guDMD8kh8J9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(478600001)(86362001)(5660300002)(38100700002)(53546011)(7696005)(6506007)(9686003)(316002)(6636002)(76116006)(66946007)(64756008)(66476007)(66556008)(66446008)(41300700001)(110136005)(2906002)(26005)(8676002)(8936002)(122000001)(52536014)(71200400001)(55016003)(33656002)(83380400001)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ss37cSElJEaKJm7fhNiLP1pQKlfph/Q/YTxmBVhDcyXGBFmwcku/CdR6/SR+?=
 =?us-ascii?Q?xulB9mwMcecwH+806/BJaaiiZY95HAsNtVIaVowyCg8Rq1bKcQb4NY09krLM?=
 =?us-ascii?Q?h/tekPeMyc1mLUGbK0uv7/skZSspHawjayiwCAz+PzpP90cC2VlyWdLpVtWu?=
 =?us-ascii?Q?xRnZ9mJ1Q7Pyxikvym3l38wTmNTwVrfmPrvVaKFmI8NaKbng2WIuC2/P3evB?=
 =?us-ascii?Q?C4Lv0sZyr41De0x2R0DsXoyNioraj0qxqItSRkFRR8AnKPpFabJpMBzj0ChX?=
 =?us-ascii?Q?tVSWmhLb7Tp2Ir7yIOUg1cTRwwfFUkAuCkPU5z92gUvFF6VHk5RIPHbK0sHh?=
 =?us-ascii?Q?QFKzVN+0Yf5eaZT8XnOYI4N1Wb6yVhtV3UiD+Z3fMVY/Ovh6Syvfu15nAdhr?=
 =?us-ascii?Q?/H2yqxBHT8/0ocaF/VR9v8HcX8T8HYWFPmD01tqtnZziRUhk5/1McJznyZhu?=
 =?us-ascii?Q?towdc4tpF4+mgcWwW8BORr6MDgPSRGBLB33YIBGiQ0fcgBwvD9K0UKaUXSF/?=
 =?us-ascii?Q?26KIkCyadUqnXg1FdJY+Mwl7xT1ULDyLUGJj11nbKwVMmjFL2Tb3pgnvDCXm?=
 =?us-ascii?Q?CDXwQ5P8mhbGWywjciG9bdw06h948ZuLfz0vqJ0TKVrqO9zTbXOsvL+HCGkr?=
 =?us-ascii?Q?ST5A9xYqEcPG/8D4CmcpiHjvYKaRtTU2oxIjwiiE+h2qYa83LnZgiIoEACX1?=
 =?us-ascii?Q?DcuHmDnXG1s4n/Fpdm3ppUxha/oDAsLLERqZeitTD6CkQiskAlzp8/z2xHG+?=
 =?us-ascii?Q?UFqgSVgE1+SlBiUO63a5Wx6F89Dzx5g4lI1Dywj1xwdIyE3em/nh72YhAwqk?=
 =?us-ascii?Q?A+BiQD90eu49KugqVvBqtnTSgttnOd+Jjg56B3RFK3QiKRYndxVyv0+iJHAm?=
 =?us-ascii?Q?DbG6bcRCjJZaPDXh2Q92kMZT4QIbbwqB3wPSYBxt6NKefY55mrbOLFgSNKQu?=
 =?us-ascii?Q?TOAkXgenzSSbtYMiJErm7oMSI35izdhEu4hVZQbWaFUyHQbqXijMHfrHShq7?=
 =?us-ascii?Q?DnzndHzPAzEuO4Y8QxY4G6/3UoyNJ/H+d7KT8hAWOIzDmTOZzkpzlQ3nYcyq?=
 =?us-ascii?Q?Q2FSLalp8nif8Jry4i8rfoTF25obNbC9Cq2th++r/j7dFxnsUMrjQPBn++0w?=
 =?us-ascii?Q?t+xGdsQO+Gkx/In1gXUVlqLzyHTobveX+5LX1AFKB0vf2pTK88rlxYWU+A9z?=
 =?us-ascii?Q?Ky++rqYLfZFMMMBQ34PEWhobzfFD0Bezd82iED2s6sSbns8So7alrKGi27JS?=
 =?us-ascii?Q?lkwooqYUTeIt/6n++Q357yfT0RHR7B3dOY8cFRHQj258xQJJu6BjN9L2hZyI?=
 =?us-ascii?Q?Ec/mBosRQ3ej79Cir0e3B6PHrf4FA85MPb898DZEXwUXmhLXvzGBggOOJNBd?=
 =?us-ascii?Q?nJwbr9PdwkFRynlUAmyAQiR9t0UrZsRE4LMgQmKyqLq4CKbW9gKqpzwSMwe0?=
 =?us-ascii?Q?faG/yFJEpa1DbAUULrhH0pW7yTmdrt482Utj7a6MwNBNl3uDBU7xiRUA6ur4?=
 =?us-ascii?Q?/e6O9JwJ8hU4QuKeZ+VR/ro879BdjfG0d1JGZgK6EN6r2GLMu2PSNiGbodW1?=
 =?us-ascii?Q?RImsfeFIQhlR27VPzs8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d120f069-a20b-4f10-5bd0-08dbd9d4fb80
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 05:48:17.8808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N0YHrm+1aSeraIxzH4TB5fVGGnukRcBqLsfVxlSuZNlPp6BJS4D683knQfrynaB+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588
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

[AMD Official Use Only - General]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Tuesday, October 31, 2023 1:43 PM
To: amd-gfx@lists.freedesktop.org; Feng, Kenneth <Kenneth.Feng@amd.com>; De=
ucher, Alexander <Alexander.Deucher@amd.com>
Cc: Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amd/pm: Fix error of MACO flag setting code

MACO only works if BACO is supported

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 8 ++++----  drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 9 +++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 2f3ffe9c0cf0..9f038e544270 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -355,12 +355,12 @@ static int smu_v13_0_0_check_powerplay_table(struct s=
mu_context *smu)
        if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_HAR=
DWAREDC)
                smu->dc_controlled_by_gpio =3D true;

-       if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_BAC=
O ||
-           powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_MAC=
O)
+       if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_BAC=
O)
+{
                smu_baco->platform_support =3D true;

-       if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_MAC=
O)
-               smu_baco->maco_support =3D true;
+               if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM=
_CAP_MACO)
+                       smu_baco->maco_support =3D true;
+       }

        if (!overdrive_lowerlimits->FeatureCtrlMask ||
            !overdrive_upperlimits->FeatureCtrlMask)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index bc48347a4949..dc2316d8914c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -346,12 +346,13 @@ static int smu_v13_0_7_check_powerplay_table(struct s=
mu_context *smu)
        if (powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFORM_CAP_HAR=
DWAREDC)
                smu->dc_controlled_by_gpio =3D true;

-       if (powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFORM_CAP_BAC=
O ||
-           powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFORM_CAP_MAC=
O)
+       if (powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFORM_CAP_BAC=
O)
+{
                smu_baco->platform_support =3D true;

-       if (smu_baco->platform_support && (BoardTable->HsrEnabled || BoardT=
able->VddqOffEnabled))
-               smu_baco->maco_support =3D true;
+               if ((powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFOR=
M_CAP_MACO)
+                                       && (BoardTable->HsrEnabled || Board=
Table->VddqOffEnabled))
+                       smu_baco->maco_support =3D true;
+       }

        if (!overdrive_lowerlimits->FeatureCtrlMask ||
            !overdrive_upperlimits->FeatureCtrlMask)
--
2.34.1

