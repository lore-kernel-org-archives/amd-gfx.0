Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9261C4706F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Dec 2023 08:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F33010E12C;
	Mon, 25 Dec 2023 08:04:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE8D10E0F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Dec 2023 08:03:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T85tS5Ow5kq86KzbNlAUezuqGWlkYJjsxuptsSHo3dZl7xOmgg6K4kJkKvUkxmhU1QS1yFyYk60CchsbyALIIFNSBNUcD3E3onp7ekZot/YTAzbMnK48/G4gU4e8qPjsWTcD4JysAI3EqD0Jt2DOTvJU64ellwfYjRsBzndIrIaGz54sZ4ICkMbwuxCDYZtHgq8w8/qW0cm3nl3Mb1vTAQZ1KjusiFgxS/gZz0riBTDvNsH8Pdx2fqPle23uKfO6KhyJ6XReetL/Kn32QITeWSEkq59irOROHogJBeajs2cV31Tg631lj90mPzpEboip7R/H3V8d/PfqZBJMSj8aeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkPpxao2hzejaZkFZY9JoSK46JRv5CXntNkycOwRdm0=;
 b=WAoNBrN+MTv5lPM+bsw5/futr9FNSN3i+go0nlupOijgZQfXC4Fbo+fKSXQVgPV6OZci5bFatkENh/FBwV1km/qtcVrS2cWl+E62uRjlIPaGnNWABWeFWZgYp66m+dX4uMONs4P1qdOTQJ17GEoEOEQxYGpbr/hOJzRG3rLuvVjguMGDPTl5P972Uqq4uwJDoRU8vPyxbOgDl38bJSdRgoOmgfoZNBVRU5+ZI54S2bn7906wN8nF8CjgnatltRxkwz6Dsv8RroyGTlr/ekf2wc1rQIZ0ezD0BDJyo9MS2QAWPZXeBTyOL6RgXPjGQsEBZ0hSIzBP65LkWnf8zcgXDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkPpxao2hzejaZkFZY9JoSK46JRv5CXntNkycOwRdm0=;
 b=Mp1uIT3dMlzCOohTv+/LqENzfym73Zl/zgrVIt1Ypvop1La0Z1I+ZxzBkypuw2qCCpod1dzhbRVTXMTu5OjtxqG+XuNHOR4h746/zWOQzIDarNuyZIefUV8x0FD8W4w9kC1feU+PC+nmmfYr1oDE6Qh/D+REJzQABbNjcV9BR3k=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by DM4PR12MB5135.namprd12.prod.outlook.com (2603:10b6:5:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 08:03:55 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::4a15:c24b:91e2:8ea2]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::4a15:c24b:91e2:8ea2%4]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 08:03:55 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 1/4] drm/amd/pm: Use separate metric table for APU
Thread-Topic: [PATCH 1/4] drm/amd/pm: Use separate metric table for APU
Thread-Index: AQHaNOtpWnbI9N1beUezC8urmu8FprC5p9Gg
Date: Mon, 25 Dec 2023 08:03:54 +0000
Message-ID: <PH0PR12MB5404C53A3367D73484D1A0D7F699A@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20231222152727.411440-1-asad.kamal@amd.com>
In-Reply-To: <20231222152727.411440-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=42b5aae5-d39d-4577-a457-523adb2fee9e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-25T08:03:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|DM4PR12MB5135:EE_
x-ms-office365-filtering-correlation-id: b1db637b-6341-4950-1123-08dc05200a11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f2HlerDH28UUxDU23No/s2ivtQmcznwkO9FsnCJ8JknEeLWd5ssifzd+5XOymUvz/yZfZ6na5qTNyWDpUELdVEU0psfsuVSKgga3n1h2dUyPl8UOUF7oyrxq34SuzkBuUYIz9gUBkbcyqNd6scrMXPBx1hDuPa3hV4q7LM3GlMoRQQcaRr/VVnaECAwKjcfbk4Lzp++h87F4k+E2JyO08TYBOeSutMIh1HEYWnTNBMkl0qQsDArnANjOTJWcOvQ0KLuTqy5Hi47P6+5+cEw6BHFxfrbMbBUJ3fRgTNOedm8d1WgiXMRGkSL37DoWitQiPoAxAyDa+5LRffHCGItsGgzT2zd8YX/k3B+Gu0oSsjn+0zDBaPs/SGceX/V4QPHZB6lnh9PlRi3dytTJPBAE47yef1+2ijhge5TdeJgU2ZmhesBWNH2Ma3mem+ArZVdGbqge+3I8OMHESi3IW3DqgO88FEhfoGXZiYWR4ezjiJa8iQg9YMfUymlbpz/ZravK9QXrV0eOtpEKaYerphjLCcpF2q/DIknxFv2hBAKt1ndVxVcrLNaSDAzKOv7M0XBhIe8IeOmIKFXg4w2LFoeTGz/g1HFU8NzgQLbCdA0V6a/J/72sOjDkYPB+TXVUfNeC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(478600001)(52536014)(8936002)(8676002)(4326008)(55016003)(71200400001)(38100700002)(122000001)(7696005)(26005)(86362001)(64756008)(54906003)(6636002)(316002)(66946007)(66446008)(76116006)(66476007)(66556008)(110136005)(6506007)(9686003)(53546011)(83380400001)(5660300002)(30864003)(2906002)(33656002)(41300700001)(38070700009)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hp17WcCE6TsZfgfLiE0tBmm4H/OWcOKNHdoHqjOWKMSGRKJ7wT3QZVhISHhv?=
 =?us-ascii?Q?ylHtJJyxKjXkLh5aqGMueAJuohc+DCeCwR9PqdLPPH0dncMwmEluZhmPLVBA?=
 =?us-ascii?Q?tliM8kttNdWjA++wt+xYVTZFicwAnuh1ceP6vbZYZPRWx/ORCtiZ0KMYIoes?=
 =?us-ascii?Q?VlLy11NxRSoMLZR0uz5S19H6iXwSwWOqVlHi9K7C48HVX7AuBk8vLgf75Rbj?=
 =?us-ascii?Q?m+IDIW8qF2MQH1RbkN4TJTYXxT+a6ue2w7O53hruKo3ZSZuXiun7JpABrUcd?=
 =?us-ascii?Q?TAZhHozEfyUVLXUuoDHVPZUC7t0oHevsuBTIDIjta544WXaMOPE3Cxh1N8XC?=
 =?us-ascii?Q?J03vD4B8+sfUKdvC0+iLT1g6/7n6Ur500tn52Z7soUzTjkLm0X30iMGGVIsd?=
 =?us-ascii?Q?48pFSybsdb99j19oLjo84oUSGGaY8dEAiWsbiS4M7khR2EgWqqlzRawA7Uoh?=
 =?us-ascii?Q?ccbZibWpAkJl5snHTH3LCzkjgsKir2BX/l/GQQxetzNjivo5WZ2LlP258D6l?=
 =?us-ascii?Q?cdp1dJUsNADzRZi8iJh2TyPDvj08W7wBuTP798EtmMixPQ38XDyjsJ7reRUa?=
 =?us-ascii?Q?Q5DTZkb05iSRcX7Z1GDBn4fVs1peYcIhYEOuZEeAXNQSTMlxJrqkcqqRu6Pu?=
 =?us-ascii?Q?JeiwuVmlSFnS5LQEJCCXTevTGcYPXC4LPjcBcSdl+h+j+KDeS0kAxwXjp0wK?=
 =?us-ascii?Q?jFIsGDFzeQ35tEQiSL2mc0zkNZIg8DIYi0QO74HOHMdsGfEOMferdIYgebLg?=
 =?us-ascii?Q?zQPQzFBH3yXsBFb1GzZZqz6Og7i/bx+dan8XKPZRBADRU4Qw1gKtECElr9kh?=
 =?us-ascii?Q?TqQlkCUIudS3iNMEOAq1nWnpw0+q/7a32csS6qXfbECQCLU4chV35yGAIscf?=
 =?us-ascii?Q?A20QKR90Y3LDM17bXTxdawDB4oOz4ynUxTp4b9eidN5uMzgGC+eouqz3pdP8?=
 =?us-ascii?Q?j/DeLYrZo3BGSbrNkChEEF5Ld1elrxjH/sui7namqRHXdfH5h4GooZ/00Pqv?=
 =?us-ascii?Q?z8Ozh2O4p1GLOXNu4Hz7Kzl4u1QH85ReCofRTlVMUCkrTIv3ag/3tHfnbHfw?=
 =?us-ascii?Q?W33a4IddNkcgSVzlzedqIFACMwGaSRPJH9MNxmYLwPtf2Pn3tp9a3JwkC9MJ?=
 =?us-ascii?Q?mn11MOcwIRCfhlKhlAtSPWBkPTtzEd0Vjirohlhb0lCWFlkKExf/fNELQvL4?=
 =?us-ascii?Q?fGKZYUYCYU+fi/8JXfymce1xxj8c2iBFtgh7PV6ICa+/ZBl9T+j/lyEA8egD?=
 =?us-ascii?Q?ttTG5Ybj04EAcwuE5jO8w+3Sv16hB+d13QqIbXFoQWeWwGDofa8eKVWb/WyA?=
 =?us-ascii?Q?6J7NCiXY75vdXeMhLMmk/BzIscxfrrwF+HRYjy+SOKh2AtbwXwAFYVoCCzUu?=
 =?us-ascii?Q?9cAmDtZBCPFOiv4sNfQ4kcI8Fxy1tfM7K5GMGvn5NL/5icL71mCAD7nHbI+3?=
 =?us-ascii?Q?iOeSW/PYy13WOWhuouPWv6+zGNHbkWtieRluDJ/8waYnGJetwl8kkX3e6hgV?=
 =?us-ascii?Q?7pORZa1vv2/6CtZntJGrFU0WMlXiIsS/op1MWTKhTy/isC8DQ+sWbKMX+evQ?=
 =?us-ascii?Q?OQ527mRNCEtWZtay2mk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1db637b-6341-4950-1123-08dc05200a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2023 08:03:54.5349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fqbn1irySlkba3dAgV2lqhzPLe0f5b+jlkOWB7dvpbTY9H5C1/jrYhCme+ZtY4pT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5135
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
Cc: "Oliveira, Daniel" <Daniel.Oliveira@amd.com>, "Cheung,
 Donald" <donald.cheung@amd.com>, "Khatir, Sepehr" <sepehr.khatir@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is Reviewed-by: Le Ma <le.ma@amd.com>

> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Friday, December 22, 2023 11:27 PM
> To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>;
> Zhang, Morris <Shiwu.Zhang@amd.com>; Oliveira, Daniel
> <Daniel.Oliveira@amd.com>; Cheung, Donald <donald.cheung@amd.com>;
> Khatir, Sepehr <sepehr.khatir@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
> Subject: [PATCH 1/4] drm/amd/pm: Use separate metric table for APU
>
> Use separate metric table for APU and Non APU systems for smu_v_13_0_6 to
> get metric data
>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h   |  90 ++++++++++++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 124 ++++++++++--------
>  2 files changed, 156 insertions(+), 58 deletions(-)
>
> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
> index fef2d290f3f2..8f166aa3043c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
> @@ -219,7 +219,95 @@ typedef struct __attribute__((packed, aligned(4))) {
>    uint32_t PCIenReplayARolloverCountAcc;  // The Pcie counter itself is
> accumulated
>    uint32_t PCIeNAKSentCountAcc;           // The Pcie counter itself is =
accumulated
>    uint32_t PCIeNAKReceivedCountAcc;       // The Pcie counter itself is
> accumulated
> -} MetricsTable_t;
> +} MetricsTableX_t;
> +
> +typedef struct __attribute__((packed, aligned(4))) {
> +  uint32_t AccumulationCounter;
> +
> +  //TEMPERATURE
> +  uint32_t MaxSocketTemperature;
> +  uint32_t MaxVrTemperature;
> +  uint32_t MaxHbmTemperature;
> +  uint64_t MaxSocketTemperatureAcc;
> +  uint64_t MaxVrTemperatureAcc;
> +  uint64_t MaxHbmTemperatureAcc;
> +
> +  //POWER
> +  uint32_t SocketPowerLimit;
> +  uint32_t MaxSocketPowerLimit;
> +  uint32_t SocketPower;
> +
> +  //ENERGY
> +  uint64_t Timestamp;
> +  uint64_t SocketEnergyAcc;
> +  uint64_t CcdEnergyAcc;
> +  uint64_t XcdEnergyAcc;
> +  uint64_t AidEnergyAcc;
> +  uint64_t HbmEnergyAcc;
> +
> +  //FREQUENCY
> +  uint32_t CclkFrequencyLimit;
> +  uint32_t GfxclkFrequencyLimit;
> +  uint32_t FclkFrequency;
> +  uint32_t UclkFrequency;
> +  uint32_t SocclkFrequency[4];
> +  uint32_t VclkFrequency[4];
> +  uint32_t DclkFrequency[4];
> +  uint32_t LclkFrequency[4];
> +  uint64_t GfxclkFrequencyAcc[8];
> +  uint64_t CclkFrequencyAcc[96];
> +
> +  //FREQUENCY RANGE
> +  uint32_t MaxCclkFrequency;
> +  uint32_t MinCclkFrequency;
> +  uint32_t MaxGfxclkFrequency;
> +  uint32_t MinGfxclkFrequency;
> +  uint32_t FclkFrequencyTable[4];
> +  uint32_t UclkFrequencyTable[4];
> +  uint32_t SocclkFrequencyTable[4];
> +  uint32_t VclkFrequencyTable[4];
> +  uint32_t DclkFrequencyTable[4];
> +  uint32_t LclkFrequencyTable[4];
> +  uint32_t MaxLclkDpmRange;
> +  uint32_t MinLclkDpmRange;
> +
> +  //XGMI
> +  uint32_t XgmiWidth;
> +  uint32_t XgmiBitrate;
> +  uint64_t XgmiReadBandwidthAcc[8];
> +  uint64_t XgmiWriteBandwidthAcc[8];
> +
> +  //ACTIVITY
> +  uint32_t SocketC0Residency;
> +  uint32_t SocketGfxBusy;
> +  uint32_t DramBandwidthUtilization;
> +  uint64_t SocketC0ResidencyAcc;
> +  uint64_t SocketGfxBusyAcc;
> +  uint64_t DramBandwidthAcc;
> +  uint32_t MaxDramBandwidth;
> +  uint64_t DramBandwidthUtilizationAcc;  uint64_t PcieBandwidthAcc[4];
> +
> +  //THROTTLERS
> +  uint32_t ProchotResidencyAcc;
> +  uint32_t PptResidencyAcc;
> +  uint32_t SocketThmResidencyAcc;
> +  uint32_t VrThmResidencyAcc;
> +  uint32_t HbmThmResidencyAcc;
> +  uint32_t GfxLockXCDMak;
> +
> +  // New Items at end to maintain driver compatibility  uint32_t
> + GfxclkFrequency[8];
> +
> +  //PSNs
> +  uint64_t PublicSerialNumber_AID[4];
> +  uint64_t PublicSerialNumber_XCD[8];
> +  uint64_t PublicSerialNumber_CCD[12];
> +
> +  //XGMI Data tranfser size
> +  uint64_t XgmiReadDataSizeAcc[8];//in KByte
> +  uint64_t XgmiWriteDataSizeAcc[8];//in KByte } MetricsTableA_t;
>
>  #define SMU_VF_METRICS_TABLE_VERSION 0x3
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 81b217bbdebb..96777a365133 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -248,6 +248,8 @@ struct PPTable_t {
>  #define SMUQ10_TO_UINT(x) ((x) >> 10)
>  #define SMUQ10_FRAC(x) ((x) & 0x3ff)
>  #define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >=3D
> 0x200))
> +#define GET_METRIC_FIELD(field) ((adev->flags & AMD_IS_APU) ?\
> +             (metrics_a->field) : (metrics_x->field))
>
>  struct smu_v13_0_6_dpm_map {
>       enum smu_clk_type clk_type;
> @@ -330,7 +332,8 @@ static int smu_v13_0_6_tables_init(struct smu_context
> *smu)
>               SMU_TABLE_INIT(tables, SMU_TABLE_PMSTATUSLOG,
> SMU13_TOOL_SIZE,
>                              PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>
> -     SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS,
> sizeof(MetricsTable_t),
> +     SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS,
> +                    max(sizeof(MetricsTableX_t), sizeof(MetricsTableA_t)=
),
>                      PAGE_SIZE,
>                      AMDGPU_GEM_DOMAIN_VRAM |
> AMDGPU_GEM_DOMAIN_GTT);
>
> @@ -338,7 +341,8 @@ static int smu_v13_0_6_tables_init(struct smu_context
> *smu)
>                      PAGE_SIZE,
>                      AMDGPU_GEM_DOMAIN_VRAM |
> AMDGPU_GEM_DOMAIN_GTT);
>
> -     smu_table->metrics_table =3D kzalloc(sizeof(MetricsTable_t),
> GFP_KERNEL);
> +     smu_table->metrics_table =3D kzalloc(max(sizeof(MetricsTableX_t),
> +                    sizeof(MetricsTableA_t)), GFP_KERNEL);
>       if (!smu_table->metrics_table)
>               return -ENOMEM;
>       smu_table->metrics_time =3D 0;
> @@ -469,9 +473,11 @@ static ssize_t smu_v13_0_6_get_pm_metrics(struct
> smu_context *smu,  static int smu_v13_0_6_setup_driver_pptable(struct
> smu_context *smu)  {
>       struct smu_table_context *smu_table =3D &smu->smu_table;
> -     MetricsTable_t *metrics =3D (MetricsTable_t *)smu_table->metrics_ta=
ble;
> +     MetricsTableX_t *metrics_x =3D (MetricsTableX_t *)smu_table-
> >metrics_table;
> +     MetricsTableA_t *metrics_a =3D (MetricsTableA_t
> +*)smu_table->metrics_table;
>       struct PPTable_t *pptable =3D
>               (struct PPTable_t *)smu_table->driver_pptable;
> +     struct amdgpu_device *adev =3D smu->adev;
>       int ret, i, retry =3D 100;
>       uint32_t table_version;
>
> @@ -483,7 +489,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct
> smu_context *smu)
>                               return ret;
>
>                       /* Ensure that metrics have been updated */
> -                     if (metrics->AccumulationCounter)
> +                     if (GET_METRIC_FIELD(AccumulationCounter))
>                               break;
>
>                       usleep_range(1000, 1100);
> @@ -500,29 +506,29 @@ static int smu_v13_0_6_setup_driver_pptable(struct
> smu_context *smu)
>                       table_version;
>
>               pptable->MaxSocketPowerLimit =3D
> -                     SMUQ10_ROUND(metrics->MaxSocketPowerLimit);
> +
>       SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketPowerLimit));
>               pptable->MaxGfxclkFrequency =3D
> -                     SMUQ10_ROUND(metrics->MaxGfxclkFrequency);
> +
>       SMUQ10_ROUND(GET_METRIC_FIELD(MaxGfxclkFrequency));
>               pptable->MinGfxclkFrequency =3D
> -                     SMUQ10_ROUND(metrics->MinGfxclkFrequency);
> +
>       SMUQ10_ROUND(GET_METRIC_FIELD(MinGfxclkFrequency));
>
>               for (i =3D 0; i < 4; ++i) {
>                       pptable->FclkFrequencyTable[i] =3D
> -                             SMUQ10_ROUND(metrics-
> >FclkFrequencyTable[i]);
> +
>       SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequencyTable)[i]);
>                       pptable->UclkFrequencyTable[i] =3D
> -                             SMUQ10_ROUND(metrics-
> >UclkFrequencyTable[i]);
> +
>       SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequencyTable)[i]);
>                       pptable->SocclkFrequencyTable[i] =3D SMUQ10_ROUND(
> -                             metrics->SocclkFrequencyTable[i]);
> +                             GET_METRIC_FIELD(SocclkFrequencyTable)[i]);
>                       pptable->VclkFrequencyTable[i] =3D
> -                             SMUQ10_ROUND(metrics-
> >VclkFrequencyTable[i]);
> +
>       SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequencyTable)[i]);
>                       pptable->DclkFrequencyTable[i] =3D
> -                             SMUQ10_ROUND(metrics-
> >DclkFrequencyTable[i]);
> +
>       SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequencyTable)[i]);
>                       pptable->LclkFrequencyTable[i] =3D
> -                             SMUQ10_ROUND(metrics-
> >LclkFrequencyTable[i]);
> +
>       SMUQ10_ROUND(GET_METRIC_FIELD(LclkFrequencyTable)[i]);
>               }
>
>               /* use AID0 serial number by default */
> -             pptable->PublicSerialNumber_AID =3D metrics-
> >PublicSerialNumber_AID[0];
> +             pptable->PublicSerialNumber_AID =3D
> +GET_METRIC_FIELD(PublicSerialNumber_AID)[0];
>
>               pptable->Init =3D true;
>       }
> @@ -824,7 +830,8 @@ static int smu_v13_0_6_get_smu_metrics_data(struct
> smu_context *smu,
>                                           uint32_t *value)
>  {
>       struct smu_table_context *smu_table =3D &smu->smu_table;
> -     MetricsTable_t *metrics =3D (MetricsTable_t *)smu_table->metrics_ta=
ble;
> +     MetricsTableX_t *metrics_x =3D (MetricsTableX_t *)smu_table-
> >metrics_table;
> +     MetricsTableA_t *metrics_a =3D (MetricsTableA_t
> +*)smu_table->metrics_table;
>       struct amdgpu_device *adev =3D smu->adev;
>       int ret =3D 0;
>       int xcc_id;
> @@ -839,50 +846,50 @@ static int smu_v13_0_6_get_smu_metrics_data(struct
> smu_context *smu,
>       case METRICS_AVERAGE_GFXCLK:
>               if (smu->smc_fw_version >=3D 0x552F00) {
>                       xcc_id =3D GET_INST(GC, 0);
> -                     *value =3D SMUQ10_ROUND(metrics-
> >GfxclkFrequency[xcc_id]);
> +                     *value =3D
> SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency)[xcc_id]);
>               } else {
>                       *value =3D 0;
>               }
>               break;
>       case METRICS_CURR_SOCCLK:
>       case METRICS_AVERAGE_SOCCLK:
> -             *value =3D SMUQ10_ROUND(metrics->SocclkFrequency[0]);
> +             *value =3D
> SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency)[0]);
>               break;
>       case METRICS_CURR_UCLK:
>       case METRICS_AVERAGE_UCLK:
> -             *value =3D SMUQ10_ROUND(metrics->UclkFrequency);
> +             *value =3D
> SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency));
>               break;
>       case METRICS_CURR_VCLK:
> -             *value =3D SMUQ10_ROUND(metrics->VclkFrequency[0]);
> +             *value =3D
> SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency)[0]);
>               break;
>       case METRICS_CURR_DCLK:
> -             *value =3D SMUQ10_ROUND(metrics->DclkFrequency[0]);
> +             *value =3D
> SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency)[0]);
>               break;
>       case METRICS_CURR_FCLK:
> -             *value =3D SMUQ10_ROUND(metrics->FclkFrequency);
> +             *value =3D SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequency));
>               break;
>       case METRICS_AVERAGE_GFXACTIVITY:
> -             *value =3D SMUQ10_ROUND(metrics->SocketGfxBusy);
> +             *value =3D
> SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy));
>               break;
>       case METRICS_AVERAGE_MEMACTIVITY:
> -             *value =3D SMUQ10_ROUND(metrics->DramBandwidthUtilization);
> +             *value =3D
> SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization));
>               break;
>       case METRICS_CURR_SOCKETPOWER:
> -             *value =3D SMUQ10_ROUND(metrics->SocketPower) << 8;
> +             *value =3D SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower))
> << 8;
>               break;
>       case METRICS_TEMPERATURE_HOTSPOT:
> -             *value =3D SMUQ10_ROUND(metrics->MaxSocketTemperature) *
> +             *value =3D
> SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature)) *
>                        SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>               break;
>       case METRICS_TEMPERATURE_MEM:
> -             *value =3D SMUQ10_ROUND(metrics->MaxHbmTemperature) *
> +             *value =3D
> SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature)) *
>                        SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>               break;
>       /* This is the max of all VRs and not just SOC VR.
>        * No need to define another data type for the same.
>        */
>       case METRICS_TEMPERATURE_VRSOC:
> -             *value =3D SMUQ10_ROUND(metrics->MaxVrTemperature) *
> +             *value =3D
> SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature)) *
>                        SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>               break;
>       default:
> @@ -2071,63 +2078,66 @@ static ssize_t
> smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>               (struct gpu_metrics_v1_4 *)smu_table->gpu_metrics_table;
>       struct amdgpu_device *adev =3D smu->adev;
>       int ret =3D 0, xcc_id, inst, i;
> -     MetricsTable_t *metrics;
> +     MetricsTableX_t *metrics_x;
> +     MetricsTableA_t *metrics_a;
>       u16 link_width_level;
>
> -     metrics =3D kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
> -     ret =3D smu_v13_0_6_get_metrics_table(smu, metrics, true);
> +     metrics_x =3D kzalloc(max(sizeof(MetricsTableX_t),
> sizeof(MetricsTableA_t)), GFP_KERNEL);
> +     ret =3D smu_v13_0_6_get_metrics_table(smu, metrics_x, true);
>       if (ret) {
> -             kfree(metrics);
> +             kfree(metrics_x);
>               return ret;
>       }
>
> +     metrics_a =3D (MetricsTableA_t *)metrics_x;
> +
>       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 4);
>
>       gpu_metrics->temperature_hotspot =3D
> -             SMUQ10_ROUND(metrics->MaxSocketTemperature);
> +
>       SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature));
>       /* Individual HBM stack temperature is not reported */
>       gpu_metrics->temperature_mem =3D
> -             SMUQ10_ROUND(metrics->MaxHbmTemperature);
> +             SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature));
>       /* Reports max temperature of all voltage rails */
>       gpu_metrics->temperature_vrsoc =3D
> -             SMUQ10_ROUND(metrics->MaxVrTemperature);
> +             SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature));
>
>       gpu_metrics->average_gfx_activity =3D
> -             SMUQ10_ROUND(metrics->SocketGfxBusy);
> +             SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy));
>       gpu_metrics->average_umc_activity =3D
> -             SMUQ10_ROUND(metrics->DramBandwidthUtilization);
> +
>       SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization));
>
>       gpu_metrics->curr_socket_power =3D
> -             SMUQ10_ROUND(metrics->SocketPower);
> +             SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower));
>       /* Energy counter reported in 15.259uJ (2^-16) units */
> -     gpu_metrics->energy_accumulator =3D metrics->SocketEnergyAcc;
> +     gpu_metrics->energy_accumulator =3D
> GET_METRIC_FIELD(SocketEnergyAcc);
>
>       for (i =3D 0; i < MAX_GFX_CLKS; i++) {
>               xcc_id =3D GET_INST(GC, i);
>               if (xcc_id >=3D 0)
>                       gpu_metrics->current_gfxclk[i] =3D
> -                             SMUQ10_ROUND(metrics-
> >GfxclkFrequency[xcc_id]);
> +
>       SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency)[xcc_id]);
>
>               if (i < MAX_CLKS) {
>                       gpu_metrics->current_socclk[i] =3D
> -                             SMUQ10_ROUND(metrics->SocclkFrequency[i]);
> +
>       SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency)[i]);
>                       inst =3D GET_INST(VCN, i);
>                       if (inst >=3D 0) {
>                               gpu_metrics->current_vclk0[i] =3D
> -                                     SMUQ10_ROUND(metrics-
> >VclkFrequency[inst]);
> +
>       SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency)[inst]);
>                               gpu_metrics->current_dclk0[i] =3D
> -                                     SMUQ10_ROUND(metrics-
> >DclkFrequency[inst]);
> +
>       SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency)[inst]);
>                       }
>               }
>       }
>
> -     gpu_metrics->current_uclk =3D SMUQ10_ROUND(metrics-
> >UclkFrequency);
> +     gpu_metrics->current_uclk =3D
> +SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency));
>
>       /* Throttle status is not reported through metrics now */
>       gpu_metrics->throttle_status =3D 0;
>
>       /* Clock Lock Status. Each bit corresponds to each GFXCLK instance =
*/
> -     gpu_metrics->gfxclk_lock_status =3D metrics->GfxLockXCDMak >>
> GET_INST(GC, 0);
> +     gpu_metrics->gfxclk_lock_status =3D
> GET_METRIC_FIELD(GfxLockXCDMak) >>
> +GET_INST(GC, 0);
>
>       if (!(adev->flags & AMD_IS_APU)) {
>               link_width_level =3D
> smu_v13_0_6_get_current_pcie_link_width_level(smu);
> @@ -2139,38 +2149,38 @@ static ssize_t
> smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>               gpu_metrics->pcie_link_speed =3D
>                       smu_v13_0_6_get_current_pcie_link_speed(smu);
>               gpu_metrics->pcie_bandwidth_acc =3D
> -                             SMUQ10_ROUND(metrics-
> >PcieBandwidthAcc[0]);
> +                             SMUQ10_ROUND(metrics_x-
> >PcieBandwidthAcc[0]);
>               gpu_metrics->pcie_bandwidth_inst =3D
> -                             SMUQ10_ROUND(metrics->PcieBandwidth[0]);
> +                             SMUQ10_ROUND(metrics_x-
> >PcieBandwidth[0]);
>               gpu_metrics->pcie_l0_to_recov_count_acc =3D
> -                             metrics->PCIeL0ToRecoveryCountAcc;
> +                             metrics_x->PCIeL0ToRecoveryCountAcc;
>               gpu_metrics->pcie_replay_count_acc =3D
> -                             metrics->PCIenReplayAAcc;
> +                             metrics_x->PCIenReplayAAcc;
>               gpu_metrics->pcie_replay_rover_count_acc =3D
> -                             metrics->PCIenReplayARolloverCountAcc;
> +                             metrics_x->PCIenReplayARolloverCountAcc;
>       }
>
>       gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();
>
>       gpu_metrics->gfx_activity_acc =3D
> -             SMUQ10_ROUND(metrics->SocketGfxBusyAcc);
> +             SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusyAcc));
>       gpu_metrics->mem_activity_acc =3D
> -             SMUQ10_ROUND(metrics->DramBandwidthUtilizationAcc);
> +
>       SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilizationAcc));
>
>       for (i =3D 0; i < NUM_XGMI_LINKS; i++) {
>               gpu_metrics->xgmi_read_data_acc[i] =3D
> -                     SMUQ10_ROUND(metrics->XgmiReadDataSizeAcc[i]);
> +
>       SMUQ10_ROUND(GET_METRIC_FIELD(XgmiReadDataSizeAcc)[i]);
>               gpu_metrics->xgmi_write_data_acc[i] =3D
> -                     SMUQ10_ROUND(metrics->XgmiWriteDataSizeAcc[i]);
> +
>       SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWriteDataSizeAcc)[i]);
>       }
>
> -     gpu_metrics->xgmi_link_width =3D SMUQ10_ROUND(metrics-
> >XgmiWidth);
> -     gpu_metrics->xgmi_link_speed =3D SMUQ10_ROUND(metrics-
> >XgmiBitrate);
> +     gpu_metrics->xgmi_link_width =3D
> SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWidth));
> +     gpu_metrics->xgmi_link_speed =3D
> +SMUQ10_ROUND(GET_METRIC_FIELD(XgmiBitrate));
>
> -     gpu_metrics->firmware_timestamp =3D metrics->Timestamp;
> +     gpu_metrics->firmware_timestamp =3D GET_METRIC_FIELD(Timestamp);
>
>       *table =3D (void *)gpu_metrics;
> -     kfree(metrics);
> +     kfree(metrics_x);
>
>       return sizeof(*gpu_metrics);
>  }
> --
> 2.42.0

