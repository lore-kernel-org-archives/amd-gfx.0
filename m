Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740D5C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 04:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA1361027
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 04:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA1361027
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B77246EB5B;
	Wed,  2 Jun 2021 04:37:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D516EB5B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 04:37:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlf9MqrElcygC1uzHDLzoQgFMjFsmgDUfb9XRoNvK5XVJwaMnPtadJpz4YZM6pHm6oBpdTeTTU/PrnpKq7/6DJAF+YE0o+R8SCdUm9BAI3a/ADyZEzVi7c7rbGyys3Tfpe3mNxpu2HNLvR5gpKcqMqLawWKg6HfETg0+qbJK0Jply+6sEkrMUxy0gssU2E0/biA76hHN3fB5RdhTwYzhTQTgpWRDY6spva9/rFB5fed28SvSj73/+X2kaccr4K3iJPcz28PSvRqvZuB1v4jWwod92RT9kMaqCXi7T2me4QJjHLfP+arSVWUmMiXTNAHy+1q8GKpozF/72wMC8yC+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7JMr5AnweIx8D7Vrw4QDP/V9+T//HgHcpqPBwaGy6Y=;
 b=m7i5KQwOdqzDz6DjutYVoywpyeyP8rlU1Mx+V/qJrOFr/NRI9jQ4SqTBjdv5V4wCUvz0IwSnfICtwLmKfuP47zzR2sGXwnk1jhofTdRoV0k5UIH7A7bcs7DwjtOTnnM/lcvJ6ubSuinUb5Q2477+N5HVC8mOB5A70spwKzGP+TkqIOjzVcer3iJZEjPZzrVFbznCtWtnv1d3ee3++N/aWe3LZvoAjhHczoat6BtPzIR4Sofq670vFjyvmJoQZeCjiiv3L9uWx8wosrPkRebE8ZJOjc/eynszZFpyv0OlSYSQKfQP/PtXv4tto90c8fKgVrOX5pL5m5z/p+uKO2I7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7JMr5AnweIx8D7Vrw4QDP/V9+T//HgHcpqPBwaGy6Y=;
 b=3u6BadinxZviY90EkuVnKCkdgmytQ+r30ZCplAf4MxvEfij6CGZwHUg7gpEYEqrY8iHkoSbuipWu3Orej6Z6zJhYHwl76011Lhqm9L7z9kl+OQR4BCit3cmRG/gC+xKow4xG06A5hmiSlMQgW1e8I2k5ZVCOABZiOwxYgAnC+xo=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20; Wed, 2 Jun 2021 04:37:28 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 04:37:28 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
Thread-Topic: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
Thread-Index: AQHXVxHsBLX08fID40O0gD3ZLnSdeKsAIp2g
Date: Wed, 2 Jun 2021 04:37:27 +0000
Message-ID: <DM6PR12MB26199099168565AAFB6690ACE43D9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210601181231.24773-1-Graham.Sider@amd.com>
 <20210601181231.24773-4-Graham.Sider@amd.com>
In-Reply-To: <20210601181231.24773-4-Graham.Sider@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-02T04:37:25Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1160a2c4-c7ad-40a2-846e-0d6c59d370a7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a668a5b8-1c43-4bd1-cebf-08d925802095
x-ms-traffictypediagnostic: DM6PR12MB4603:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB460363A9F91275FF87441F87E43D9@DM6PR12MB4603.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I2noNzM1Z1R8NrJG016wrM7K0Uuhnvyv+pSjWirEh114+4QzpJ40Oaz9PHYfLPQ93QtsLQUYFsn0zixZs503fnZYzN7i54/BhPJPNEfMsspu6q5jQyljDglkzGwSmAp6kriT7WgoioGhzqlQ/VTLcwHqFf8rElAraNW1guD4MKjz/FdxJOrpZMmnkhMi1JYLpMCul51Ivui8TGPI07dlFI402xDS4zT1IPetTFxBEELXm3wlKz62AemG917mB3OeUnXtCZ46Z7QNtyUsdNUTmtUuDVYluea0Sm5nWlWkHxBYOOHA7pPi7FHVrKtgl78Mzb0csopgw6ByXLTPtUK16BZxyUN9fOC0KrYgZ/pachEnGCUsw45siFSoAupzDpsTEX0aWk4tnT0K3PkZo9usgTytAjMw4IX64oebcmGs8IEsGWEAvQS6w+2hrzM/fsA3EMKPhMXTngcRSpwZVKWDd+nyd0HP5p/EW5lWkIT1FJB4UoqUEI1dmkrOgsA0O/55Uvn05QTPeNLVYHWURP+D5rGkQOaDuodHApv7TGgW1N3V2JOt+WNPs2DtTqIxSxSaSwh1xgFu6bwKmCCrMngeflJgV5vi1wyOqKupB5iduFrzbCyun4sZD4VDcsvHRNNjHvSWHy/hoHV+d9w1kpV1GQ3/vbdcvY8Ws0/74SkFD9nAixRP8yBjEv++B4fXzsaq/30wTrByF+rQisR9L6rwVmUo7K2fdCRq7atU7i3TjotAd3p3Hztrt64FDnTszP3FnBfq6ENW/FWDPIDf2DQnUT9jEnUBTjkYYdHGRvHYaSk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(9686003)(966005)(45080400002)(6506007)(2906002)(7696005)(53546011)(478600001)(38100700002)(26005)(110136005)(86362001)(316002)(54906003)(4326008)(33656002)(8936002)(66946007)(8676002)(186003)(76116006)(5660300002)(71200400001)(83380400001)(122000001)(66476007)(66556008)(55016002)(52536014)(66446008)(64756008)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/XUdDbDGCe3Bjz4fpnkZLfCSDsI5IpFjJlx37b+9d6JxbP6oyB1b1TeKo5no?=
 =?us-ascii?Q?Xxc/k+d85cTVOh5roJLMJjbHK8qfwQHSJVPjxjwzbsPaOT3oOdqN7RHK8i9/?=
 =?us-ascii?Q?b2Ssh1R4iTDYjttmC/3wKmFQ2LEhgG2gPvcVbtK5kNez7QiowOQXg/MRNZhg?=
 =?us-ascii?Q?/HvC+jZNvEmLnAx7SJMcw82erq1HUdKBFNqI/cEzvqqQg/gQWs2R9XRkyUWH?=
 =?us-ascii?Q?HF/S50xfj32492IkUpcabvDz0ZN0O9vOwXQCwKsm0Tl6MVRXqltsYmDd8Gqr?=
 =?us-ascii?Q?MIV+jUPGv8l+cuZ0rywyCBKD0dYDdF0mdHFye+LzaN3xitwwKLLFHYYz5NMo?=
 =?us-ascii?Q?kF+MGc6iANnphqU4DZXf0xRCSvHiqW2UQSVeE3DsfN/OBmaLDPaUdPCk/nfq?=
 =?us-ascii?Q?iH3KMhQDww25bAycpfbJesf7KVXW2Q7vXhA2B0psDtiUnFZrmtGHlnXkAO2L?=
 =?us-ascii?Q?gy6A/3aNihaLHR3LfWjbnOf8sjJIe04Y2tMErW/UQuN4iYXidCqJh/hMhkwC?=
 =?us-ascii?Q?Ia5MnMLyxL5po5R3wLIhb1UqOaR3MX8GEw+BlYXjmllc4bcDbjJReO35by/e?=
 =?us-ascii?Q?hCC75EqyKCpkUL6v0JY9xzigrivAt4Zk6nbvvrOLB4aX+5z9/SqHesnfTHzu?=
 =?us-ascii?Q?Fy13wVxPr/i4ah4ZsT9poMYT0c29Bah7sYzsro88C27ez6et4jDhWSNe0BWZ?=
 =?us-ascii?Q?6Hd0z6gDgoCJci/Bar5wU5BlFrTWdU4hvvytE24QLbEYoKdY9+9uZB6+rQXQ?=
 =?us-ascii?Q?usBnKUa1a+zt1XpjonvIAUnY13DYGwQTvGPvDR6IguTMNQnUBZIF6nuZ9Cma?=
 =?us-ascii?Q?O3vDLFzAX4GnDjgMOhk1j/Izs+KYQC+Yd31l01Jg37OOk3CTBO3PfEwBjwQa?=
 =?us-ascii?Q?GHJfCkPIdmyg+5Wa5tPVPPHp5g03IKBJyvsnjcF+UVpQOAbgumw4ksyKPw/1?=
 =?us-ascii?Q?HX1OURcdLXCeI7J/+4EWZFsa1ZTuD8sxN+7H2AaPt20Hh9l125yTLL32ZTEo?=
 =?us-ascii?Q?xp1GV1DFOikxwL+03PEG/xWMR4aRHbgSK2OpFoACcymIWHlx07B84paSR1TO?=
 =?us-ascii?Q?+YkqKGhqlsu/hXldozevsUhbBpAEbjHzx5kY4BxTTnard3IllQ6Kg/aOdosc?=
 =?us-ascii?Q?Kt6wboMz5V6gzNahTHCHzHNzUw2aWtwkQS9+iz4FP9ya8832pZG8Nk0RQdX+?=
 =?us-ascii?Q?2KVRL93RlXa0J+mbzB1nJQ7vRXqzYztTa2escQPWoxcd9I8cX2gR58+ZetNv?=
 =?us-ascii?Q?wpEgaktEW76suG8Dex111cwnoLZNj4/qb5n/5DkIiR4SDSlpkweYao5kshs4?=
 =?us-ascii?Q?OCbW3WcSroHrFaR3jcfmtd8B?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a668a5b8-1c43-4bd1-cebf-08d925802095
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 04:37:28.0317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DCH5OxI7StgIf4iWuEkiecCJNEUGNrq1X9s7y9Bl4ysNgAv1ctGu2Hmhhw1dIhGt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4603
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>, "Sider,
 Graham" <Graham.Sider@amd.com>, "Sakhnovitch,
 Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Graham Sider
> Sent: Wednesday, June 2, 2021 2:12 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>; Sider, Graham
> <Graham.Sider@amd.com>; Sakhnovitch, Elena (Elen)
> <Elena.Sakhnovitch@amd.com>
> Subject: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
> 
> Perform dependent to independent throttle status translation
> for navi1x. Makes use of lookup table navi1x_throttler_map.
> 
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 43
> +++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 78fe13183e8b..bf376b1be08d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -238,6 +238,28 @@ static struct cmn2asic_mapping
> navi10_workload_map[PP_SMC_POWER_PROFILE_COUNT] =
>  	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
> 	WORKLOAD_PPLIB_CUSTOM_BIT),
>  };
> 
> +static const uint8_t navi1x_throttler_map[] = {
> +	[THROTTLER_TEMP_EDGE_BIT]	=
> (SMU_THROTTLER_TEMP_EDGE_BIT),
> +	[THROTTLER_TEMP_HOTSPOT_BIT]	=
> (SMU_THROTTLER_TEMP_HOTSPOT_BIT),
> +	[THROTTLER_TEMP_MEM_BIT]	=
> (SMU_THROTTLER_TEMP_MEM_BIT),
> +	[THROTTLER_TEMP_VR_GFX_BIT]	=
> (SMU_THROTTLER_TEMP_VR_GFX_BIT),
> +	[THROTTLER_TEMP_VR_MEM0_BIT]	=
> (SMU_THROTTLER_TEMP_VR_MEM_BIT),
> +	[THROTTLER_TEMP_VR_MEM1_BIT]	=
> (SMU_THROTTLER_TEMP_VR_MEM_BIT),
[Quan, Evan] I'm wondering why you map the two ASIC dependent bits to the same non ASIC independent bit. Instead of defining two non ASIC independent bits.
> +	[THROTTLER_TEMP_VR_SOC_BIT]	=
> (SMU_THROTTLER_TEMP_VR_SOC_BIT),
> +	[THROTTLER_TEMP_LIQUID0_BIT]	=
> (SMU_THROTTLER_TEMP_LIQUID_BIT),
> +	[THROTTLER_TEMP_LIQUID1_BIT]	=
> (SMU_THROTTLER_TEMP_LIQUID_BIT),
[Quan, Evan] Same question here and for Patch4.

BR
Evan
> +	[THROTTLER_TDC_GFX_BIT]		=
> (SMU_THROTTLER_TDC_GFX_BIT),
> +	[THROTTLER_TDC_SOC_BIT]		=
> (SMU_THROTTLER_TDC_SOC_BIT),
> +	[THROTTLER_PPT0_BIT]		=
> (SMU_THROTTLER_PPT0_BIT),
> +	[THROTTLER_PPT1_BIT]		=
> (SMU_THROTTLER_PPT1_BIT),
> +	[THROTTLER_PPT2_BIT]		=
> (SMU_THROTTLER_PPT2_BIT),
> +	[THROTTLER_PPT3_BIT]		=
> (SMU_THROTTLER_PPT3_BIT),
> +	[THROTTLER_FIT_BIT]		= (SMU_THROTTLER_FIT_BIT),
> +	[THROTTLER_PPM_BIT]		=
> (SMU_THROTTLER_PPM_BIT),
> +	[THROTTLER_APCC_BIT]		=
> (SMU_THROTTLER_APCC_BIT),
> +};
> +
> +
>  static bool is_asic_secure(struct smu_context *smu)
>  {
>  	struct amdgpu_device *adev = smu->adev;
> @@ -524,6 +546,19 @@ static int navi10_tables_init(struct smu_context
> *smu)
>  	return -ENOMEM;
>  }
> 
> +static uint64_t navi1x_get_indep_throttler_status(
> +					const unsigned long dep_status)
> +{
> +	uint64_t indep_status = 0;
> +	uint8_t dep_bit = 0;
> +
> +	for_each_set_bit(dep_bit, &dep_status, 32)
> +		indep_status |= smu_u64_throttler_bit(dep_status,
> +			navi1x_throttler_map[dep_bit], dep_bit);
> +
> +	return indep_status;
> +}
> +
>  static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
>  					      MetricsMember_t member,
>  					      uint32_t *value)
> @@ -2673,6 +2708,8 @@ static ssize_t
> navi10_get_legacy_gpu_metrics(struct smu_context *smu,
>  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> 
>  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +
> 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> 
>  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> 
> @@ -2750,6 +2787,8 @@ static ssize_t navi10_get_gpu_metrics(struct
> smu_context *smu,
>  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> 
>  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +
> 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> 
>  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> 
> @@ -2826,6 +2865,8 @@ static ssize_t
> navi12_get_legacy_gpu_metrics(struct smu_context *smu,
>  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> 
>  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +
> 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> 
>  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> 
> @@ -2908,6 +2949,8 @@ static ssize_t navi12_get_gpu_metrics(struct
> smu_context *smu,
>  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> 
>  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +
> 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> 
>  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> 
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cf05ba28afbe0417ac
> 54008d925290dc0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> 7581680520671680%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
> PzZzTHlRh0ygXIJdQeN8%2Ff4ojC9KcCy4Ia5POPGw1nI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
