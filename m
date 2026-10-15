Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE601CC6B34
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 13:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60D6A112260;
	Thu, 15 Oct 2026 13:59:12 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 669B410E267
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 13:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJrhu4isIrPgIuYBQNUjuVbUXd+JE9OmG+095poscsUfmFbomIll6eiz+3Dlvu0RbVextjejtJ+4+q0JD8QVT6TUaQkoyfJzfSIvac37f3uDNdhdSnjO/uHRpTHV+j+yzEmjC7xfA87khpaLuto1DhYLu2EzNEBxV28dZW6BN7Pqf7BCz2Whlz5LZ7rqQNa/ooEJAYV3v2GWZfN68Sg+Q85L3vg1dmcxTOE4o4OshIuYpH1oXWnIY4UsXjDZY05bLrUpH9Q2dbftGV7sZyBm2vpO878S11v/dy4Fzi8cfjQGpEO7cYuZTLUmmWAvTVaznoh9ubJ6Z06rn7ckteabBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmgS9r23Egy9MlI5qRYziktJD8HTBjnckzK+73lEv0Q=;
 b=Vlkb2BqmasPkx277YYjdxyTLi1wyKQtNM5SPNpej2KLyydAslhgWPghQPm+xceESpXBnDgWkP9ClNyTafEtjeThCv6JVgmsZJvU3vFLdkfcSNd51oZrLjJdwV6kJuZKPU08QilZMUD4tcXJI/mF+2MnZVnc/UApla98HWZrWcYCbbbam/8lCAQnqjWodpuCiON/5xpVC1L6ol1SSjHDzSqg4A1gFBD5czD294tPtOeQ8ihGMjdbY/B4viFraEB9jxdxB81ijbsXZ8CqNDNbrvD3o26vzHNLgDxWNA1QwtrCSdcAqh9uNMlMRBxdTq+9sGByca/tbMifbtmCxe+9yEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmgS9r23Egy9MlI5qRYziktJD8HTBjnckzK+73lEv0Q=;
 b=xCI9hM+5LBpKXrC8iBodWRAT1VUuZReUAI7owMDHG3HdvLy6uoZIkqIg2VQG6RlvLB5Rt3bYTRiW0h2VYh+YoG6G7UfEGEmh5b/BKaiy7HX7QpoK7J3pqnctXl0/G9xkCtlDUbO/b5B5fulqv/HRJh9HrD424/aWdT9wxSeZgzc=
Received: from IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 by CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 13:58:56 +0000
Received: from IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522]) by IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522%6]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 13:58:56 +0000
From: "Hosur, Priya" <Priya.Hosur@amd.com>
To: "Wang, Kevin" <Kevin.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>
Subject: RE: [PATCH v2 1/1] drm/amd/pm: restore the forced performance level
 after a reset
Thread-Topic: [PATCH v2 1/1] drm/amd/pm: restore the forced performance level
 after a reset
Thread-Index: AQHdVxF5LzXLExPlPUWRugi8Q6qB67b+Y4uggAANTACAADmQgA==
Date: Thu, 15 Oct 2026 13:58:56 +0000
Message-ID: <IA0PR12MB88950E1FD00B0A333FB78062F39C2@IA0PR12MB8895.namprd12.prod.outlook.com>
References: <20261008104026.4102222-1-Priya.Hosur@amd.com>
 <20261008104026.4102222-2-Priya.Hosur@amd.com>
 <IA0PR12MB8895E6CA7AF1D2988800EDBBF39C2@IA0PR12MB8895.namprd12.prod.outlook.com>
 <PHXPR12MB99925592BB90114CEA6F2A6071939C2@PHXPR12MB999255.namprd12.prod.outlook.com>
In-Reply-To: <PHXPR12MB99925592BB90114CEA6F2A6071939C2@PHXPR12MB999255.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-15T09:37:48.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8895:EE_|CY8PR12MB8411:EE_
x-ms-office365-filtering-correlation-id: a8d1c1d1-7530-4492-8eac-08df2ac4744d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|22082099003|18002099003|3023799007|921020|11063799006|261009223027099003|261009221227099003|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info: mCpqESf45G1dORd0udb9hPVSGm5P1vE+dZjrFytcxDh7K9J2BC7ZnYV5D+8sL50wYvrjsyRFXmkva/THCFVa/6tRPYwqQ//+vS7VpYYIJ6N6C0kuzIZGbiNYqayeOcWEYPhh19NblbZtxFxYMjOkgnsBQxzJUugPyup3gXYlf1kvXOk4U2fCA/GoJXLsBSnVhQaqvKVcPiKNtVXpIUpS+SHXNNJBHQbeXztdhi6Vj48lNJE2jGItAzn9j96NYSS7KfC1vCfSmy0mfdIn7SMhPvkJsVisY/acuVx8oceHkHsCbs4Gto08me1LMM8jCM6bLmZ24GX6l/yRhvuV5qcaAJfUPAX3piV/DHrbfGbNkYjS1rkjAHHZfvbevubTSotRrmgyKwQoTPnzWurh9WrCKIwAonb5PUZzor/EjOkIAkD5QQCCqNPhPDZf5r30Ttv7qPqdF76n4qQcgjLSTg4ePO+P1DHkaXM0MNFrWDpediRb1/Fe6+EyimKWL4L5j3z2QCq0CQo265q+phlypvmZ16QSniNAXK98eXtLX4WqVCwpZ+93VbQmj0y7iuTaRLShmy9cMGd+sC88qzXSrNBQZzTs4zgeOfgAX9qnBeFgMExmUeq5FeBc3s1NNRaEojyJLWZcowtEMHcssX+anYE6a+gBtrMzmsHGtC6sIGhVoi4lLKIHAds3xK2S1eU08EdGxJoU16vs0RChBjzio0ssavPtV5+aNmqCOPLZza9Ftsc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8895.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(3023799007)(921020)(11063799006)(261009223027099003)(261009221227099003)(4143699003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1/dfRIfdl58It2xtbC7G6VfU0hZgygLFrm5Qe9FQ5pxYYFzXK5Rp+KcV+Fzk?=
 =?us-ascii?Q?15H9hfS0eb/kF6LvHHzrkvGNrFjumS8b9EmG5TbRqa4VsfEgrhZFTBnICsPo?=
 =?us-ascii?Q?wB5svEjX5HQe/pUCnAitPd+mqol05Bmq84DgX6UojlZQnjyuDLcEVc1rx2JO?=
 =?us-ascii?Q?nTZ/kP4pldRPD6DxSPNI4qRErlWmZdqPhtkTLNVhQMBdP08vkj4XVEsLulrH?=
 =?us-ascii?Q?OoFqRRwItROBshRvYgbg3vUTFCHTxF8GfAkYtoG+zW4uzTEEyC73YFhZt1W2?=
 =?us-ascii?Q?h2E1iz5muokjkTJM1vrV9axV+acTINaYyD6UZyhipByRRxGqJ0zhkiRrkyFr?=
 =?us-ascii?Q?hD5VJs+WEJBcW8vbglfmnlh5nW8YMSCqoQFeK3/QKxQmBs5i69HrmCePDEHb?=
 =?us-ascii?Q?dXxScD1BqXaRjlpAXrDTQuwuMdFN09JNdia4+aHxKG5jkp5U8/H73tqpfcL3?=
 =?us-ascii?Q?OLpOppQDZ7/MFZEWhN8UYdiYsOMfQrwv7oFCpz4cuUNT6DgWaDEs0U926SF/?=
 =?us-ascii?Q?CilOcGKqe4qrsYtn5OgwvU4tkbqSGxxjPokiWqG+tspJYaIrB1yClsI6Ze12?=
 =?us-ascii?Q?qPPvcIJkFBXra9xcQI8ll9GlKgwCbQuVA0b/CuCVsZgM0XKRuPN37Na1/K+F?=
 =?us-ascii?Q?uWm1kjzGT00dXO9XlJ9YJh+XVGRLjzZTZZYnnVn9djBBdVHJPpyV4ToQryTx?=
 =?us-ascii?Q?Jc3mqcAr17SsxJ9VX0Tlk/q0cTxkxRTSdP2NhNq+PYUVFYxiuuaawnb3Mjg6?=
 =?us-ascii?Q?Mfbolno0j7Qujia7tBtV3qBLnXmlGkEg4clw1aN9GNT6AIjzzw10qTLumIh3?=
 =?us-ascii?Q?cSHYBiQAgzU08qC4e6HeUGfbF/XVDirvymMCVNAlU00zz+bmZCAZNOo6vtSf?=
 =?us-ascii?Q?edQqgx+js957+l0GzR9JpP3JWPQdTq5i8QI+Iflr5lA25iKRbI7wrGV4rmW6?=
 =?us-ascii?Q?I0dmBxD7TLEmhkW2Wyg795fhJPKrZMr+93aoyZN2SN2UIfqy/6TK5+jnk+mM?=
 =?us-ascii?Q?6Vj7cyd7ugFp4YYALhguarkXknwSROIcmSN34foq9pqTMQfE/mUBCdMdiCxe?=
 =?us-ascii?Q?x1/q8ZjMBsTm/2Vv5sqxc0gZK5REZ+msvvJWuOPuJRVeS/w+uCvRqy+iEv6a?=
 =?us-ascii?Q?teRp1kvkd4fgWGb6OmbFZfm+vMMsEMIklX1x5m7VVmeoBaV+Hd0hH2V8eecN?=
 =?us-ascii?Q?HvZ4wbVy2PO4Tm+viCoGlL6H/vjeTdrMhHITp8VIg/hJz5mHZMDeRmbyWZ5k?=
 =?us-ascii?Q?U5ScEnEsQnUZQT7STaebWxr3WawfPqJ8wmCF6VxIUxSDW1ZXe7kjCQkJoYx5?=
 =?us-ascii?Q?rrc0lNFhmwrOO6MyOM3nyIQqnBV8nfXpZdL1y5Bo/7h17JT6GOwkzxD3wYJQ?=
 =?us-ascii?Q?9vnjBzFaJ3O1Dr9s45ThlnfHCs/2XC9nYQCaF3ogYJ/CnTUpIBluDZXRu602?=
 =?us-ascii?Q?7aMYe2baDXMZtjjjQDn+8Ns1z+JeVgjmaTgtMloRUDwgXPMs8SckusEPPcpi?=
 =?us-ascii?Q?KvE+K/wdGFajw8yEh8l3kSJ3YWoEiEqBMabCvkqNWAzk3yS+wnAw8TG5h+Bz?=
 =?us-ascii?Q?n+ij7ie0u23r/GkzdGX5DX0JYgiTVf1qgI64X7xe0SAJdLIeoziuQD6lhAfh?=
 =?us-ascii?Q?phaKOubbpESJ5Ros6ch1M1QMMCCN08BqRf0CgAcwW4Aj0YBd6RQO8fIqlgRF?=
 =?us-ascii?Q?fSJl/5Nz/0pRk3via/EnBsQNfPpPrSnQzdoZXuNt4Tj6X2w1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d1c1d1-7530-4492-8eac-08df2ac4744d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 13:58:56.1927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ci/8PdSou0CKb+bmNSamjZ9kxYS3A8TCpizBYBMgjTD1o9jF/YVV8JY/mi5PcoHTX3O8adQqQEu+UIb66jB0FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8411
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

AMD General

Hi Kevin,

Thanks, I checked that patch.

It gates on the UMD profile levels:

  case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
  case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
  case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
  case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
          break;
  default:
          ret =3D 0;
          goto unlock;

in amdgpu_dpm_reapply_umd_profile(), and the same switch in smu_reapply_per=
formance_level() returns -EINVAL for default.

The reported issue is with power_dpm_force_performance_level set to high, w=
hich is AMD_DPM_FORCED_LEVEL_HIGH,
so it takes the default path. low and manual are the same.

AMD_PP_TASK_COMPLETE_INIT also still passes force_performance_level =3D fal=
se:

  case AMD_PP_TASK_COMPLETE_INIT:
          ret =3D smu_adjust_power_state_dynamic(smu, level, true, false);

so the behaviour of the smu_late_init() path is unchanged.

My patch makes that path re-apply the retained level after a reset.
Tested on an SMU 14.0.1 APU with high set: gfxclk 2784MHz before the reset =
and 2799MHz
after. Without the patch it drops to 600MHz.

Thanks and Regards,
Priya Hosur

-----Original Message-----
From: Wang, Kevin <Kevin.Wang@amd.com>
Sent: Thursday, October 15, 2026 3:55 PM
To: Hosur, Priya <Priya.Hosur@amd.com>; amd-gfx@lists.freedesktop.org; Laza=
r, Lijo <Lijo.Lazar@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com=
>; Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kue=
hling@amd.com>
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veera=
badhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Hosur, Priya <Priya.=
Hosur@amd.com>
Subject: RE: [PATCH v2 1/1] drm/amd/pm: restore the forced performance leve=
l after a reset

AMD General

>> [PATCH] drm/amd/pm: reapply umd profile state after recovery

Could you please double check this change? It seems it already covers your =
case as I see.

Best Regards,
Kevin

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Hosur, Priya
> Sent: Thursday, October 15, 2026 17:47
> To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan,
> Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Hosur,
> Priya <Priya.Hosur@amd.com>
> Subject: RE: [PATCH v2 1/1] drm/amd/pm: restore the forced performance
> level after a reset
>
> AMD General
>
> Hi Team,
>
> Gentle reminder on this patch.
>
> Lijo, v2 follows your feedback to restore the forced level rather than
> report the default. Could you take a look when you get a chance?
>
> Thanks and Regards,
> Priya
>
> -----Original Message-----
> From: Priya Hosur <Priya.Hosur@amd.com>
> Sent: Thursday, October 8, 2026 4:10 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig,
> Christian <Christian.Koenig@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Cc: Hosur, Priya <Priya.Hosur@amd.com>; Vishwakarma, Pratik
> <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veerabadhran (Veera)
> <Veerabadhran.Gopalakrishnan@amd.com>
> Subject: [PATCH v2 1/1] drm/amd/pm: restore the forced performance
> level after a reset
>
> smu_late_init() re-applies the DPM level after a reset with
>
>   smu_handle_task(smu, smu->smu_dpm.dpm_level,
> AMD_PP_TASK_COMPLETE_INIT);
>
> but smu_adjust_power_state_dynamic() only programs the hardware when
>
>   if (smu_dpm_ctx->dpm_level !=3D level)
>
> and smu_dpm_ctx is &smu->smu_dpm, so the level is compared against itself=
.
> The branch is never taken for this caller and
> smu_asic_set_performance_level() is never called.
>
> PMFW is reinitialised by the reset and comes back on its default
> curve, while smu_dpm.dpm_level still holds the level the user forced.
> The device therefore runs at the default level while sysfs keeps
> reporting the forced one. On an SMU 14.0.1 APU gfxclk drops from
> 2.8GHz to 600MHz while sysfs still reports high. Writing the same
> level again does not help either, as
> amdgpu_dpm_force_performance_level() returns early when the requested
> level matches the cached one.
>
> Sync the cached level with the state PMFW came back in before
> re-applying the forced level, so that it is programmed again.
> Suspend/resume is not covered, as PMFW retains its state across s2idle an=
d the forced level still applies on resume.
>
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index a65aa2129845..2d318726c521 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -998,9 +998,18 @@ static int smu_late_init(struct amdgpu_ip_block
> *ip_block)
>
>         smu_get_fan_parameters(smu);
>
> -       smu_handle_task(smu,
> -                       smu->smu_dpm.dpm_level,
> -                       AMD_PP_TASK_COMPLETE_INIT);
> +       if (amdgpu_reset_in_recovery(adev)) {
> +               enum amd_dpm_forced_level level =3D
> + smu->smu_dpm.dpm_level;
> +
> +               /* PMFW is reinitialised by the reset, so sync the cached=
 level
> +                * before re-applying the forced one
> +                */
> +               smu->smu_dpm.dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO;
> +               smu_handle_task(smu, level, AMD_PP_TASK_COMPLETE_INIT);
> +       } else {
> +               smu_handle_task(smu, smu->smu_dpm.dpm_level,
> +                               AMD_PP_TASK_COMPLETE_INIT);
> +       }
>
>         ret =3D smu_apply_default_config_table_settings(smu);
>         if (ret && (ret !=3D -EOPNOTSUPP)) {
> --
> 2.43.0


