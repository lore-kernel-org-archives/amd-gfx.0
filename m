Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9446C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 06:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123AB10EA6D;
	Fri, 14 Oct 2022 06:07:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAB2610EA79
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 06:07:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVjg7Gj0VSlyqfkhsnFyl1ChE3O29bb2FwZCtFzPXR3XPnJcqP9muXShlAVxXmzVa6vOB9YhgKXU5kCwa5/a0SIEpAQi1b6gcU6tuc2bONjzjUDBcDkIeBlEryMIf/cvTPD9AYy1lzUEU28q9K99m8pPIGPnZPs1U4W+U7g+nCEG7gM48t9UWQewQUxTwsKx+Tr5jTTVDGNM8czMFF5jWmxp9+CTQxF26yaL2M/OTORS04X/iGG0ezL58mU0tW8GozzgVqLABPd6JJ3i/QJvtR4OdKQ5SbclIqfVSVhRPyMvrues/p4Oc0AOMrTTArOpJFYj1gsfE0+M42CJCCrNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJXdKTi1vRoTXnwe2NY22fPMtsvCnVgDXpCeiM1kc8g=;
 b=aB774oh6y+uVHUuiX4fzchf25N+kJsJDIQHMbMR9OGZi+8MXD5SWO0yJxvFL+VCTj06b6OMXYIZOQJ5Qtv1dJCAXG+mrHGJ1Rqog8+42ylLWUtr/lq/i7/fpej+UK04vIb+Iqj7k/tJcKPqR+pFU7yRBO74zpOIm0DHN/fI9w6/RRQCFKWBzOwGLReWCuGyKJ/XJ3WJalqXYED+IRDKOR9/h0OYSS2tlHJmrH0o/PQ3yUsAhemPWC5EW33wSepuYLuZLxKDUn1vq+HZ1vx8233OMnVz/Vpxd1Z9BVhRPlcm90ZS6BHpJtUPZyzrzit2arzHa7nEm8PC5B/jnAzgrfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJXdKTi1vRoTXnwe2NY22fPMtsvCnVgDXpCeiM1kc8g=;
 b=lqM/UWMFyDzU1mWAA6VikSmGGSw/zj/MMppnq3OQWfuPb3FE/Usr9g0tzc3U1ILRK7qNoeMijat9npZvs9C5K/bLF+Otw7dWPkLfA5Z878zr+dD/eqsVj3tFfmuwBbU5guutiL289mbAwvaeg2Eur/Nz/Kzo05V5pqBCIAn0ZIM=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 14 Oct
 2022 06:07:50 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9%5]) with mapi id 15.20.5709.022; Fri, 14 Oct 2022
 06:07:50 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amd/pm: skip loading pptable from driver on secure
 board for smu_v13_0_10
Thread-Topic: [PATCH 4/8] drm/amd/pm: skip loading pptable from driver on
 secure board for smu_v13_0_10
Thread-Index: AQHY35Gu6sfsoRW3hEiidm40JPeQMa4NZgeg
Date: Fri, 14 Oct 2022 06:07:49 +0000
Message-ID: <DM4PR12MB51811BF7BBD2A0FA4DA7ED4BEF249@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20221014055553.921523-1-Likun.Gao@amd.com>
 <20221014055553.921523-4-Likun.Gao@amd.com>
In-Reply-To: <20221014055553.921523-4-Likun.Gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-14T06:07:48Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d41a87bd-ff96-456f-8f96-4dcabb6c9faa;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-14T06:07:48Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: fc8930de-153b-4765-bb71-3e96a342d2a4
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|MW3PR12MB4521:EE_
x-ms-office365-filtering-correlation-id: 2c6ea90d-3eb5-40c3-d546-08daadaa6c57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j427igV8ygzOEKBdvFBg1A2FrCHvkBvefq4GUdB+3bWIPZ7O/XZHIrRHSngbEFsfNX7Mc7Qryr67+Pna1Jut/Pge0hk9CGMwJAOl/Bm9J1po7AfW/hyP5q/lChm2egqEj3O7/Hlf7Bb1l6HPXTv3TzvHL24UsIBKgVhUmNOsW/g3ILq1CznX+5A3bYI03kqR6y9JJR5cy+uYrcVGlslXQ1rwjW8xonZmuL/NPdfSZbnnrdKCXiIUcGGz/arTp4s2XysAe0X+Wea1kIQuwYfFTao1TlJl6Xv2SMx6znfSS4j1IPSue1Cj9AWog+DYr/Wn0X14p8go4IsxbDiCf19PnIfBtciEsR64Q3i0AWieM5lvEl0T5ngd6v1xRwvmM+3yxcAilALkGp4n+Xne8CDg5ceTc+qZmfZaw6I1EWQtFdDYIBuNvVZEM09a/C20J+1v5n10m/vaXMwp0TuxxGzqs+JJgzZ0KE7g6t6T5sIK9DzrzkQvYc42kny9dx1E0nluIj3hwE/yEfl6GojHimKmIk4ltmv8OCXPeb9DS8HvpbH9QgFy5lPbF1VpqQd8Pw5uPEA7a3ri0vjs0558SFpmtPzJ/xYUuF5CeFuQOVLy3thtaCRx2rB2cdUWeoXGjBVt2gDd7A1MevXV4CHRpqT9z/epzcobCgDow53xpAbfGDr/VIdO1Odg32cmAGSze7AA6hq33HsC5jmkp3aWthrNQpD5cNjN30Mk3BHyo4XwI1utSIH9MJnsEoKNRYV+VmWciKhiOq/KEtqPU2pnfC8cAg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(186003)(66476007)(9686003)(83380400001)(38100700002)(122000001)(8676002)(4744005)(38070700005)(64756008)(2906002)(8936002)(55016003)(76116006)(316002)(52536014)(478600001)(66446008)(6506007)(41300700001)(26005)(66556008)(71200400001)(7696005)(5660300002)(66946007)(6916009)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZqxWecvf9wGvRW01PP6xKmCFkI0rwpHDH5hUlF3U9ZLozCxpila+IL014yqh?=
 =?us-ascii?Q?DUej01yz3OyKYUO40sJ5JQ87ZfdMki5ZTxzSiIN4fTQEtdQa9KOeeON7rijq?=
 =?us-ascii?Q?yw4CkE4WB0gN/jq/ZB5yxFrXy2JMeJ7ycDaTCeKiLgQsoENdtBy4xtOeZk55?=
 =?us-ascii?Q?SjRCTrYEWxP788aBnMKSqeRsiv6prTqr6bUaWD/RKGoF9YiQNLECNuCxL2PT?=
 =?us-ascii?Q?fjb1SlkxBH4c6UhQ2lTQI5i5rn5do530dMsgOyZR7e8tSIe6Lu3wlKLnXw/s?=
 =?us-ascii?Q?ailkNNAkd84+VVqoDToJFhAJSXTpNQuGw7Z4yG+jZi2KTxoeZP1u3ZiN7spu?=
 =?us-ascii?Q?Vz5ANUeGi1dY/N6Eymaaq893saBXns2BZ0BfevKi74R5Om31rOA9ZCEViYgt?=
 =?us-ascii?Q?ds1fE1EeCIQ4465Mr6akATOkmyhgT9NPX4qDzv4I3QWChsclvhqo1nbA7P9F?=
 =?us-ascii?Q?xJjsT1oYnkMFFkbESmpIsDm6pMOP8RpBnTVfpe6cCOJg1SZyXeDXfLFU+EyW?=
 =?us-ascii?Q?/Qxpy3qULFKiFCzB95s4aCQaBHh3bntqrDKSRYvXRd6wstPZ0CSC4oBal0j+?=
 =?us-ascii?Q?TL8qgxDLrD4zOJqfwTkwUdTjYsTTEuVLyKzuOqwc6HJs2AGtvTRJHUY/RrdT?=
 =?us-ascii?Q?HrhJfQBnQcRErr8jep4FDCMm3fP4CnqC/dSAkDbVRhnNgX5FE/c/vcwREEtP?=
 =?us-ascii?Q?Ck3sr4NKdAd8kN7v9cC6/AleHB1cZOwXf3kmyMKn6uj3bYwLg9P0FMnTlEAN?=
 =?us-ascii?Q?e5adDTLE1UTFShMyP1ZndCs+lNPLFLhddXQPO6oy2j/mBpX4bnI2ashW7E56?=
 =?us-ascii?Q?NDglfHtZRVA7NvrTslTvsZtyKMMoPOmOzEBTN3eTZRANYl66VFjY4PD8uE3Q?=
 =?us-ascii?Q?KqOgVsbbjBqSIRk+/1b2SS3oThc/WHkWfcUI5O82bCpYB2SyFvAIy61ponux?=
 =?us-ascii?Q?XCEFw3mXYm7JQGuA52TPDfl3DZPSS+biyCqndfn4DfAQysZiTfomyC4RRqES?=
 =?us-ascii?Q?QfZk8UuI/AmT9rypRTwWEfpJhv3Vwk+jFWwECe30PD3DqD64Bj8Xqj0z/wPC?=
 =?us-ascii?Q?5mv5czMMrxuIKia1YpGltTyS6lwURU6SmRZC7bKtN+S0xgHUDnJZkzoW9y5i?=
 =?us-ascii?Q?hyk6R95ktRCZ4Uf/5osEeHXXur86oYyGY6XGO2X8+7kwLjZ9fMJN+67OA8LE?=
 =?us-ascii?Q?7JnHkkENozFgLCiYsu2dieb68eZ8EgVOdlIaptBhl+sRZLX5CTbxmYnc5Fgp?=
 =?us-ascii?Q?0APvMbwx1UARUzVZSSVo+nSOOVQGxiEDjE1Cyt/sen9mF/XubCgip/zkOX7Z?=
 =?us-ascii?Q?lQQECpChcGT0dDMvRNSrcUpfYRaoTPii5cXn60CXz33BrOKMfZP1nf6XHGnt?=
 =?us-ascii?Q?vgnZxCMBiJWoKBdhbxvm0CC7nYBioaANGCQbzvB5LDT+JtjTXQbHJox0xkG3?=
 =?us-ascii?Q?l8UZ/8hoqYJtWCeILNsYFA2UXeDyBQd4iPn0o4udTRt1Ec+KzFUqAsOvcy5v?=
 =?us-ascii?Q?7XsLA//JgbzizLR6SfhlU2W4ezKXSrxrlY2YZPM4cG54xbbbIKroPrqQuKxW?=
 =?us-ascii?Q?8MwwQtCFUTgxpdk9hBU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6ea90d-3eb5-40c3-d546-08daadaa6c57
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 06:07:49.9462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IW96Ujla18GWkpYqu1EmSMbY0Y/qGbFd5UUW2k1TsNBH2Eia8Pxw7gXROX2Skco7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
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

skip loading pptable from driver on secure board since it's loaded from psp=
.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Guan Yu <Guan.Yu@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index f8f75d1a67e4..fa15b454d25f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -211,7 +211,8 @@ int smu_v13_0_init_pptable_microcode(struct smu_context=
 *smu)
 		return 0;
=20
 	if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 7)) ||
-	    (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 0)))
+	    (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 0)) ||
+	    (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 10)))
 		return 0;
=20
 	/* override pptable_id from driver parameter */
--=20
2.25.1
