Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01CBCA5FED
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 08:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A0610E10F;
	Fri,  9 Oct 2026 08:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XMmSVzM6";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4387310E10F
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 08:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPx7yoZqGKvGZhJ/XRhXP9GUZAMHF23Tm1qIsE8Dis9Pt84I769r5Yl/q65ZyroHrfQkYonBhkz2TuKaK8Y6NaMEEOOrAU4DppXRvtB2GIMUxZzwZNFKobD+A4GRFl/IKsoHptwF8WTarSc7wbhTC9VUlm45fWGM6zqbQ34Z78rE8QxErbo9ENluha/g5/+CMKG55auSC2uJOq9XBIbGicxInq7pPsCh3qQiCfIG0NiXwzb6S5xBRCYrmd+PokMk8BvC17ozgFzsiR7itPYHKtLg5cbcs25QWDtDUJBV7dgawPlsCGAHv0/eY3aR6/H9gzBYo45xZImCKJ2E/VKStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2VW1n2BV/7HQa7w58f6gKesgPeaOa2OQ4InHnk2eW4=;
 b=bFWZAnOBB6CKTgxTMo1l2GvNCSOAphZEhyNiKF6GE3XhqPZ5nxuW5r4fbBfxBfQX74jyz+BWBDOkGZKZad30YO27RCTU1e8BUQKXsT49ouRJTNYZ3oztL5gDS2dg0sNzG8xY51RamBKC1nDCdULM5IiIGNiX6E2b2ovVpGy/KGymJSc1E/opNEjzghzLqHnnRqiRWTteUqy1fYfNyBnDJE7MOI/K1bN79L9C7KWXmkfjnS/pbYjxQ+licJyUldXgozcTAJ/ilwqnxYWkfd1MTX61WYSmXU2qAi3+xbSY9dtUtb+ih4H0LWcyScxdGS8RkkMpXXa5eeWH0J1HYoXXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2VW1n2BV/7HQa7w58f6gKesgPeaOa2OQ4InHnk2eW4=;
 b=XMmSVzM6cM34rf0Zh/IZPJeiCPCqY1Yp5G1zeuWEAH66ZH3wXKmpc3YGmKz3em7+v77VNznxndTJqF/PPcH/NcaofL5M9l80YC0X725u27AANrtVUKx0ag13JXkesbinwxxVc75hQc5CFwCFAyltPPl1dnqmg9VYChcBRVkXJes=
Received: from PHXPR12MB999255.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::12) by SA0PR12MB4479.namprd12.prod.outlook.com
 (2603:10b6:806:95::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Fri, 9 Oct
 2026 08:26:43 +0000
Received: from PHXPR12MB999255.namprd12.prod.outlook.com
 ([fe80::4045:7ee8:a423:d926]) by PHXPR12MB999255.namprd12.prod.outlook.com
 ([fe80::4045:7ee8:a423:d926%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 08:26:37 +0000
From: "Wang, Kevin" <Kevin.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: add zero fan stop temperature support on smu
 14.0.2
Thread-Topic: [PATCH] drm/amd/pm: add zero fan stop temperature support on smu
 14.0.2
Thread-Index: AQHdV8bsai0h5zw5ZU+GQTBqvfcCj7b032vw
Date: Fri, 9 Oct 2026 08:26:37 +0000
Message-ID: <PHXPR12MB99925563868BE562C228E0D66F93922@PHXPR12MB999255.namprd12.prod.outlook.com>
References: <20261009081930.2028915-1-kenneth.feng@amd.com>
In-Reply-To: <20261009081930.2028915-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-09T08:23:39.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PHXPR12MB999255:EE_|SA0PR12MB4479:EE_
x-ms-office365-filtering-correlation-id: 8c167079-70a4-438c-615e-08df25df092a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|18002099003|6133799003|22082099003|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: fZl7GPz4HRmne/9WqWHKqRaXqp7fKZhs9kPcBzHBNdDOTD5TonOe6uF0jXvKYF8cBSDgZlM3H5uKk1JRGrOtIU6SoJK65ZI0LYtgIuMg4tadNcQdMtBNcw6DlxdrDzBq0ZsVXr0aNydesQkbHxCvfj5EZq27z4zfdJVQq2aiQcEAeQDAEV02tSrl5SgzujMhMECRuWZ+m0F971+tX3ubzaGadaBSRZuHV383fNevBcFfu/8wM8qXfrYBnSE5HoqHOkFD3/mPVwuX9QQuB4JXA5n/3Y6wK7+swdgHpPcvkvi02OvdmP7ubsp1LutBhIKTC3jcCjIKbzv/dZbMPPNEqZ/+Os+XaLiadglj4j7Mxr0RQhWhKgqWiNOpv9scbtx7oIMRAfy016oeT+gpdujgeQ+pQZH8phPGVjV5eTw57TP8AgF/vbBhzZvekUn+ikJme+aNXx1AzByM6spkiB1zFGDv8ieR9nL1V/eCwr6kKOrYI7SCNR9+fCeHkJdvvhxHvowlX512a8YKgninX9oow8Okk39gmx2Jfc6WAU5qm0SY4GjlCmveOvRnKe0vnhWaNzpQPsTcFuxIUVrdwciYnXUES9GtTeo+PlB43sJ+kIk/rvBVZKAuRjj9M5DnQZ0x2bstaPVWWlMixRw30h8zgd9jII5zSqKhhOt/qhL1Vs0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999255.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(18002099003)(6133799003)(22082099003)(56012099006)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xQxRkr+j6391JSTjK0loGdI3k3gn5MUkQFN8sE2O6GeNJVHbummHb7/ds83i?=
 =?us-ascii?Q?kWpC9x/SmqQzQqeFfyr10GSo6sCUShKmc+d+TWPZuXJg0fwudWVLCcNcvOai?=
 =?us-ascii?Q?joBRDH5swim1M02G5ifuBNRy4zrnWtbxYDSGc6sRigfSZ2TtDN4LYGoExk2S?=
 =?us-ascii?Q?yAELQwPsu9DfGGoIdroBn4tKkLPwxsTAPH5t3VF/0ZplE2X/ryPL9vBW8gh/?=
 =?us-ascii?Q?whWoWqm0Uv6JCCAd6foX+Zy/0Gb1M5Tv+inWrXHrfOxzJSI7VbtxIgpObz0r?=
 =?us-ascii?Q?iFeipeKrzcgM0ocvKYqiG0Gy2K1ieg+2vuBE6/GqE2xmIHmS9qqRuOx5CClb?=
 =?us-ascii?Q?OhUzbmKiUdEOCcnnhgcOAC0UxA1eg3Q6I/x/Wxj+NHyKZGTVxpOof5lg/HeX?=
 =?us-ascii?Q?m30/WABuvFSVX44BcxrIcGAjX4T4+eGgY6ONgBLodckYr2/ybQvBHt6NlgOv?=
 =?us-ascii?Q?grHyXDJM4sTFOAVqaYGBcK2aeb6R74kEAiateT0xTZZt1SFEeGx/2hO8AEEb?=
 =?us-ascii?Q?21Bo8S/ypKCeh+U62h3lnqPuggsFG6K3TsVX6M7t0D0eo9fVr9aJWPz9fNAN?=
 =?us-ascii?Q?HVo3or6M66wqr/pTDOkv66Uv8z1OsZoNIJYpe1L6pblt7fq8HuKod5K8XDbL?=
 =?us-ascii?Q?3YiNJwh9O9hn5gBkFbEgw1WQBy55KD/YrvLZfQAziC+DE3yIag1CiuOzdVPD?=
 =?us-ascii?Q?8BIJLKw9pwrGdGTyyZ8Hr4R8+bHXurCyZzqmzPz8l8R9GgFS/JjTZ9MOJMer?=
 =?us-ascii?Q?/Q7m+xysQQ5/JFUh1AHD0w8EfgDKVxCbWIKQujy7j/gmqlaeljeA1VyXCw5v?=
 =?us-ascii?Q?CMNcjX+aAcjYDBrx9ROPlOczqKjpG3derGmCn5QQAgr+qVw4Y7CD/s06xpY/?=
 =?us-ascii?Q?qgftxkrfVfoxSZwWKVF3P/+roYcYuLYdWOrOfsFU0IgewIjlaGUB/KrYhWkr?=
 =?us-ascii?Q?NXMFHlsrvdBLPqkbTn84RbcDFVKxBEKV3OsX6bo2hZ76G+NHz032a7cf4YSg?=
 =?us-ascii?Q?X7KwWRD//t832f+kBeiUi5Xv4sjRmQDH95u3svxpw6kGFvB5ZQWahBJznL+y?=
 =?us-ascii?Q?4Pewd2LcXTYDq2p+mr1EPRGYVPaxYIgSNGmPJIwQFtiF8JKS/lXBQg0Lff+V?=
 =?us-ascii?Q?rEzvuRuMLGplcAM4IGIcvhhIiu3rElnRST3L5jPrNMhI/KMBgxY85PeqNQMA?=
 =?us-ascii?Q?gWkBu2FUslX1HeyXmfZB99bwbsT5rbQkAuskueVAufeJvZMxqFOsFXlmA1yY?=
 =?us-ascii?Q?hr1+43AB0rxEsy0DRIRVXcNmsyrnnxZ9MJ0y6Ojk6Tj8qf1bHtVqg6BM8AMz?=
 =?us-ascii?Q?HmsP1gU9jIeX6e4GL9k/ROBsL2p8cDG3ScOG0GeyAHkK/DYNeM3JUFisZ92q?=
 =?us-ascii?Q?Bn5qTgyDrNuTHN4s549fEtMkeLfnjANy767reOxIFyb2zH711tKhHWc3w4RY?=
 =?us-ascii?Q?uanByL1dgshcIPAzgQBDBQzvYf7jQPe3jmrYB7WdWdrP1rL/10qwJUXeMpzm?=
 =?us-ascii?Q?x4A+kAzVv+PeqGm/26AOyNvHh6v8oqyjiZkXJGMZQQyvPWUDdvdyK0/qEQ8t?=
 =?us-ascii?Q?d6J3MmKbf1BMriy6NBPgnbcD5/DfQHt0dopqLo/WTqi52UPHqnSpMzjlwSRM?=
 =?us-ascii?Q?DD4BQ4LM8vZrq3CJfJnCrbNrYoVeA6pj7mNgTMUoqHKbBwFmby55BYg3UQjF?=
 =?us-ascii?Q?eChNHa4LZs0u0oMxKOBCeI2Lo9pBINrK0uPPIVH4EcbNnLF/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999255.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c167079-70a4-438c-615e-08df25df092a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 08:26:37.1570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wy9oK5v+nnxpdgaa0E7XWkTPMgEnGOO9R5rU/vZNCKleqMYRpTWMX3MW+qKg4Hi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
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

Hi Kenneth,

Please add "Closes:" tag in commit message.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5905

Reviewed-by: Kevin Wang <kevin.wang@amd.com>

Best Regards,
Kevin

> -----Original Message-----
> From: Kenneth Feng <kenneth.feng@amd.com>
> Sent: Friday, October 9, 2026 16:20
> To: amd-gfx@lists.freedesktop.org
> Cc: Wang, Kevin <Kevin.Wang@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>
> Subject: [PATCH] drm/amd/pm: add zero fan stop temperature support on smu
> 14.0.2
>
> add zero fan stop temperature support on smu 14.0.2
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 55 ++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 1054c4b4b03e..e095bebecfbd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -89,6 +89,7 @@ static const struct smu_feature_bits
> smu_v14_0_2_dpm_features =3D {
>  #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE         9
>  #define PP_OD_FEATURE_FAN_MINIMUM_PWM                        10
>  #define PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE            11
> +#define PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP         12
>
>  static struct cmn2asic_msg_mapping
> smu_v14_0_2_message_map[SMU_MSG_MAX_COUNT] =3D {
>       MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,
> 1),
> @@ -1020,6 +1021,10 @@ static void smu_v14_0_2_get_od_setting_limits(stru=
ct
> smu_context *smu,
>               od_min_setting =3D overdrive_lowerlimits->FanZeroRpmEnable;
>               od_max_setting =3D overdrive_upperlimits->FanZeroRpmEnable;
>               break;
> +     case PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP:
> +             od_min_setting =3D pptable->SkuTable.MsgLimits.FanStopTempM=
in;
> +             od_max_setting =3D pptable->SkuTable.MsgLimits.FanStopTempM=
ax;
> +             break;
>       default:
>               od_min_setting =3D od_max_setting =3D INT_MAX;
>               break;
> @@ -1244,6 +1249,24 @@ static int smu_v14_0_2_emit_clk_levels(struct
> smu_context *smu,
>                                     min_value, max_value);
>               break;
>
> +     case SMU_OD_FAN_ZERO_RPM_STOP_TEMP:
> +             if (!smu_v14_0_2_is_od_feature_supported(smu,
> +
> PP_OD_FEATURE_ZERO_FAN_BIT))
> +                     break;
> +
> +             size +=3D sysfs_emit_at(buf, size,
> "FAN_ZERO_RPM_STOP_TEMPERATURE:\n");
> +             size +=3D sysfs_emit_at(buf, size, "%d\n",
> +                                     (int)od_table-
> >OverDriveTable.FanZeroRpmStopTemp);
> +
> +             size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> +             smu_v14_0_2_get_od_setting_limits(smu,
> +
> PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP,
> +                                               &min_value,
> +                                               &max_value);
> +             size +=3D sysfs_emit_at(buf, size,
> "ZERO_RPM_STOP_TEMPERATURE: %u %u\n",
> +                                   min_value, max_value);
> +             break;
> +
>       case SMU_OD_RANGE:
>               if (!smu_v14_0_2_is_od_feature_supported(smu,
> PP_OD_FEATURE_GFXCLK_BIT) &&
>                   !smu_v14_0_2_is_od_feature_supported(smu,
> PP_OD_FEATURE_UCLK_BIT) && @@ -2308,7 +2331,9 @@ static void
> smu_v14_0_2_set_supported_od_feature_mask(struct smu_context *smu)
>
> OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
>
> OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET |
>
> OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_RETRIEVE |
> -
> OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET;
> +
> OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET |
> +
> OD_OPS_SUPPORT_FAN_ZERO_RPM_STOP_TEMP_RETRIEVE |
> +
> OD_OPS_SUPPORT_FAN_ZERO_RPM_STOP_TEMP_SET;
>  }
>
>  static int smu_v14_0_2_get_overdrive_table(struct smu_context *smu, @@ -=
2389,6
> +2414,8 @@ static int smu_v14_0_2_set_default_od_settings(struct smu_cont=
ext
> *smu)
>                       user_od_table_bak.OverDriveTable.FanMinimumPwm;
>               user_od_table->OverDriveTable.FanZeroRpmEnable =3D
>                       user_od_table_bak.OverDriveTable.FanZeroRpmEnable;
> +             user_od_table->OverDriveTable.FanZeroRpmStopTemp =3D
> +                     user_od_table_bak.OverDriveTable.FanZeroRpmStopTemp=
;
>       }
>
>       smu_v14_0_2_set_supported_od_feature_mask(smu);
> @@ -2443,6 +2470,11 @@ static int smu_v14_0_2_od_restore_table_single(str=
uct
> smu_context *smu, long inp
>                                       boot_overdrive_table-
> >OverDriveTable.FanZeroRpmEnable;
>               od_table->OverDriveTable.FeatureCtrlMask |=3D
> BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
>               break;
> +     case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
> +             od_table->OverDriveTable.FanZeroRpmStopTemp =3D
> +                                     boot_overdrive_table-
> >OverDriveTable.FanZeroRpmStopTemp;
> +             od_table->OverDriveTable.FeatureCtrlMask |=3D
> BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
> +             break;
>       case PP_OD_EDIT_ACOUSTIC_LIMIT:
>               od_table->OverDriveTable.AcousticLimitRpmThreshold =3D
>                                       boot_overdrive_table-
> >OverDriveTable.AcousticLimitRpmThreshold;
> @@ -2749,6 +2781,27 @@ static int smu_v14_0_2_od_edit_dpm_table(struct
> smu_context *smu,
>               od_table->OverDriveTable.FeatureCtrlMask |=3D
> BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
>               break;
>
> +     case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
> +             if (!smu_v14_0_2_is_od_feature_supported(smu,
> PP_OD_FEATURE_ZERO_FAN_BIT)) {
> +                     dev_warn(adev->dev, "Zero RPM setting not supported=
!\n");
> +                     return -ENOTSUPP;
> +             }
> +
> +             smu_v14_0_2_get_od_setting_limits(smu,
> +
> PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP,
> +                                               &minimum,
> +                                               &maximum);
> +             if (input[0] < minimum ||
> +                 input[0] > maximum) {
> +                     dev_info(adev->dev, "zero RPM stop temperature sett=
ing(%ld)
> must be within [%d, %d]!\n",
> +                              input[0], minimum, maximum);
> +                     return -EINVAL;
> +             }
> +
> +             od_table->OverDriveTable.FanZeroRpmStopTemp =3D input[0];
> +             od_table->OverDriveTable.FeatureCtrlMask |=3D
> BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
> +             break;
> +
>       case PP_OD_RESTORE_DEFAULT_TABLE:
>               if (size =3D=3D 1) {
>                       ret =3D smu_v14_0_2_od_restore_table_single(smu, in=
put[0]);
> --
> 2.43.0

