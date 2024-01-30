Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C1AC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 08:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16CCE10F847;
	Tue, 30 Jan 2024 08:31:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C0D710F847
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 08:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmrAAgyWmqOp6yRXrk4rZR1xxw7ZKyfpMDepd3BOQgvYC1mAny5YAeYjskETllwENuLJmP59i7Li25QixNvgp3y1w4Y8WTLUPScS0QmyBUP1ldUI5PdgZoBNpZMYotM8G+j0FRkG1eRXABX/b0ykzuNN3CiaEgnXXEYK2qVaMz+dTBlAmGNCPYLtmZnmrtNk+IGaPg1VwzbzIyeAXy7Vs4xpzSxnE9Fj57O5zhLtrmx7//smOodSg/uk81HGqHi3yNK6/+YjN7129k23AJ1xw6xWCXWBLIXNMox4GFPYWnDliS4TsvUB+FosEqPUFeanRj0BINRlF6MawNMLAZeHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX2gik9esS9pID8reTlgNxA1ayAKIWzZVhGxLn/C7lQ=;
 b=k2IgodusVSiz9ICsJKhaVgoeAEBbpm3AK0CgqAyXDnn1JETYXvrtsZs1A/VKrK7wJZ2Tj5FezIiofhLiqDM/p2IOoBiW1NlmEeRSR1b8fsBIcyzPQt196D0LRLtE8GeWoFnAH3fZk4Kb7Pre7h4NaehKEY0IJ8YsN3ct2XAAQKvgM4QaDd3huoVWIcdP4CxDfz7YzejO7U4imAlEU/iC18Hy0SCWmmF7zVA33L6eW0YtZaGN4lxbP18VGtSniYkci9FB4D1iIrT46ekWR5Ka6fvYpvttFkHJPGwTjN7ttN+GpezEHX4dDX/AjKjhMXK2nDK/UQIC+g3/liL85vnSfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX2gik9esS9pID8reTlgNxA1ayAKIWzZVhGxLn/C7lQ=;
 b=Z3ntxPDibIOLW5y+bAxE1BX7oTjGwoprULlYxNfZXy90CcTP0OEchu0JlxTBNRp3GhboJW5MTdBFPegOjMLlJJhODXYYp3pxXMqKXa4rHOjPV0mbTivoroV7OSdp6qrlR2nus/hd+D0NyX3L4ZSIW2q5CCs2HGERQIKBkttQWtw=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 08:31:31 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::2481:719a:5a7a:d6ad]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::2481:719a:5a7a:d6ad%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 08:31:31 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: drm/amdgpu: remove golden setting for gfx
 11.5.0
Thread-Topic: [PATCH v2] drm/amdgpu: drm/amdgpu: remove golden setting for gfx
 11.5.0
Thread-Index: AQHaUzv9HWHQ+u322EaopZLj1j4uCLDyBs7A
Date: Tue, 30 Jan 2024 08:31:31 +0000
Message-ID: <MW6PR12MB889810F1F6985C4AC19550E9FB7D2@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20240130051930.3418642-1-yifan1.zhang@amd.com>
In-Reply-To: <20240130051930.3418642-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=36ac0eee-3bf9-479f-9b6e-25db321b8046;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-30T08:31:03Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|LV2PR12MB5967:EE_
x-ms-office365-filtering-correlation-id: 6c7f78e9-db67-4c47-4c46-08dc216ddc8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P8EWQhuzc9SCN4sr1opMt+BOqAf/Sq2sGZzAUxPd7GTsoLlmMAEXLIgDlAq17NfWDEXW0EXKJhIteKjbroMytVbsMHaKwmKuxqPjuCDYj4iWjR2T56LpINhKZ7hiXP2rQ8CQO0fj/9tyabf3Mi8YONOv8huB2+CXjkptv+PEqga6YzBFyOylMb3TDcGYTDYZQ41MUrsQZvsiusdcyxTOzPMaEzD8uHAyxgf2E+PWzh3VladLtRS2O5xqfxwIj3kQzJCF8+h5jQSAEVAvnAdRbnwsD/OepIyvEBQ8p1QzuE4FvJ/CRCG2Pgq5vs9EdiIPvoisd7ee/GtRtRrAigs5gxdAW90spO0eHW+1fSf9CkPisrXghOXDN6/2Q4Za15J0UiPQRjx5cI5jnaeaYjl2PzvPnes6E4VCeIqp4Tu6AprUw3a1HtR/WZuR3VfZd2YZ7zS7W7TAHOdVFZv5THDI86epmMom5rw/qJOkk73bG/ogWDKtvz+c5t/0/79fU1sIJHIqNLRNrdAkUAB0UnXxckCyw2Ge6ruQumXgDdSYOdh1BVCFBrIFYyS8/aOT9/E0YQNxVdPc6Pt3/0/LlMaJWB9l//5QiXgHiQMPt2EVuaWF2hHioiOvnOfBOJ2ZxSG9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(52536014)(8936002)(4326008)(76116006)(2906002)(5660300002)(66946007)(33656002)(110136005)(8676002)(86362001)(66446008)(64756008)(54906003)(38070700009)(66476007)(38100700002)(9686003)(122000001)(66556008)(7696005)(6506007)(71200400001)(478600001)(83380400001)(41300700001)(55016003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eFrZdhjSQYoPH12kbf+pzcchapUJt/Wbd4E0ypuQWBTjaaMy3z57nRgj4ZOB?=
 =?us-ascii?Q?KcxVyTF1bcc2KMXs5zPfEJkvCWfJsDL60RT3HzWtpQMaq9l5A6q+/ELEZ7do?=
 =?us-ascii?Q?MMfkP6ewVjDnudf6oIqPQTGYNIw+2BFfLzD/gekH7e8MIit9ByirEYoYImHI?=
 =?us-ascii?Q?pC79gxWp3PAerNLhIpsyg1Q96DhpAfgmg0UWeeImyxQ0OTQ1th4HKoQ7LS3r?=
 =?us-ascii?Q?gZ2W679gVklALu7x7jrYIKsuwl0jA5iHm2ai5Lj8EVy5uplEvY2RqqZ9ZZEn?=
 =?us-ascii?Q?qoLLWoQD3Q0pJOTMepdXTyBVep8pL9/Jxhh4GgnhV3gFc04b5vbSjVAMPxeF?=
 =?us-ascii?Q?kMOWVrz9gzskmwbd/j8+Do+VMKnPysKmCWzxPyKZftXY0kJ7F8lzqRLXRac+?=
 =?us-ascii?Q?GruNQhYfLwZ/ECN0FU4f7dKNms69Xc4Sl+jkDnu7bPBiQZYRwaCk6Cp6//ej?=
 =?us-ascii?Q?7g4mGRA18S+hbcHBSe1v28VCgoBm96e7AmvGC36Mk/1y+Jg9tQUYCGn9+Qrf?=
 =?us-ascii?Q?DV5DZb9L5H5DVjkQ1BzOxI0UeMgNP6ITQvFxSF6TEp9OGJLEeg05yDJcsnWw?=
 =?us-ascii?Q?nfqW30B9/8SQY8gwO3fHfkA7UDDEq2gmx1ZlZx1UH+J3ZoU1AhTwONOYqdnF?=
 =?us-ascii?Q?nhBDk8QHrStbhb8qMfPa2skW+E0OR/G2Spqxxxl/1QrpVlXkMH5ZdX/de7Pq?=
 =?us-ascii?Q?zl18mKLsQ2iLdG9DNdK36xugI5ZKz4oKsKclBb4a+g2A/xoqGhgyyKLtpaof?=
 =?us-ascii?Q?dxIqOOUBTgfCJEWKQOQ7Guz3+iUpgflpw0Ab5nskCKqi3CuLFSeVRbjUr7GQ?=
 =?us-ascii?Q?IHFU2+uXoHdNtqETrEkygxyfNn0+MJkdjAklmZQ6/tYRsyTz0gcg9rEyn5fV?=
 =?us-ascii?Q?JS8SVht4liasQWtcmif1CLQiV4XjGxsO3IJMj9ktskOv+VLzV5NsLNG5vkMv?=
 =?us-ascii?Q?nGI63cj7KlTbnwIRFj7MIlZTHn9LM9z0BlxNZkEd2mo6qmUQNaZBSPHqlVOP?=
 =?us-ascii?Q?XLC4jiMFBmG/j+vZcN1qP1Uz1Yxbc0RkOEjkoW79wMwvXYava+f4bVNa8+lo?=
 =?us-ascii?Q?8xUl4R0+7Nfl5iAwxeumWNIHQztQuhyrsdeIsr7rUDFYqJ9IJGqv8GeKktlZ?=
 =?us-ascii?Q?1EJB5gzypMFjJg5O8AqN7H4dU8Ny0FysCxRNwjlVpi7ZS/INv4+4oDdkZ75J?=
 =?us-ascii?Q?dnhOy0A/TtfTw9eMy9SaerTR36wFYfMVTl9csgIUjfuAKakD7oforMoj8I+l?=
 =?us-ascii?Q?fmtLoyaDBEZZ2LTz9CVsW0Kxzludx66ZhFQL78hggBe0Khxf7Mc1b1vD3QgL?=
 =?us-ascii?Q?N/aYJocCRq3kydOPh7LJxVvSqLgHZn80i3/PQpq26zlZjI/bChcDhy+fPzi/?=
 =?us-ascii?Q?0qOzQ2fLId8bcGfN+8yJl+aL/WLDtVpHyfvck7razHTNjwtvUuFiGYJ8LZNU?=
 =?us-ascii?Q?K3loS5BqmpAi9DDRkDgCs+jMvUsQbhV8U0LM474OQSd1afTFLzKKQPZ8ogG1?=
 =?us-ascii?Q?TGtPHE8Eiwimxxqvhs4N4yJlpXDUZzt00uUs4Y9Jm+yez6ozV/5HRh1agmgU?=
 =?us-ascii?Q?gs2+W+Xur5xB4Cdxr4Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7f78e9-db67-4c47-4c46-08dc216ddc8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 08:31:31.4602 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+99BTv1rJoUDGKFvceLHuoa62cq1IgWQKaZdGlku4OFr+XTbqxATgDJdXAyL0Cqheh+TIUzVomTfw+zmtu8hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Lang Yu <lang.yu@amd.com>

>-----Original Message-----
>From: Zhang, Yifan <Yifan1.Zhang@amd.com>
>Sent: Tuesday, January 30, 2024 1:20 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Yu, Lang
><Lang.Yu@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
>Subject: [PATCH v2] drm/amdgpu: drm/amdgpu: remove golden setting for gfx
>11.5.0
>
>No need to set GC golden settings in driver from gfx 11.5.0 onwards.
>
>Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 22 ----------------------
> 1 file changed, 22 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>index c1e000010760..2fb1342d5bd9 100644
>--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>@@ -107,23 +107,6 @@ static const struct soc15_reg_golden
>golden_settings_gc_11_0_1[] =3D
>       SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xfcffffff,
>0x0000000a)  };
>
>-static const struct soc15_reg_golden golden_settings_gc_11_5_0[] =3D {
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regDB_DEBUG5, 0xffffffff,
>0x00000800),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGB_ADDR_CONFIG, 0x0c1807ff,
>0x00000242),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGCR_GENERAL_CNTL, 0x1ff1ffff,
>0x00000500),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2A_ADDR_MATCH_MASK,
>0xffffffff, 0xfffffff3),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_ADDR_MATCH_MASK,
>0xffffffff, 0xfffffff3),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL, 0xffffffff, 0xf37fff3f)=
,
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL3, 0xfffffffb,
>0x00f40188),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL4, 0xf0ffffff,
>0x80009007),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_CL_ENHANCE, 0xf1ffffff,
>0x00880007),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regPC_CONFIG_CNTL_1, 0xffffffff,
>0x00010000),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL_AUX, 0xf7f7ffff,
>0x01030000),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL2, 0x007f0000,
>0x00000000),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xffcfffff,
>0x0000200a),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regUTCL1_CTRL_2, 0xffffffff,
>0x0000048f)
>-};
>-
> #define DEFAULT_SH_MEM_CONFIG \
>       ((SH_MEM_ADDRESS_MODE_64 <<
>SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
>        (SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
>SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \ @@ -304,11 +287,6 @@
>static void gfx_v11_0_init_golden_registers(struct amdgpu_device *adev)
>                                               golden_settings_gc_11_0_1,
>                                               (const
>u32)ARRAY_SIZE(golden_settings_gc_11_0_1));
>               break;
>-      case IP_VERSION(11, 5, 0):
>-              soc15_program_register_sequence(adev,
>-                                              golden_settings_gc_11_5_0,
>-                                              (const
>u32)ARRAY_SIZE(golden_settings_gc_11_5_0));
>-              break;
>       default:
>               break;
>       }
>--
>2.37.3

