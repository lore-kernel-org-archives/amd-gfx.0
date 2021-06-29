Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D299C11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 07:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10BD261DAC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 07:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BD261DAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A856E829;
	Tue, 29 Jun 2021 07:43:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 669726E827
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 07:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVhQ9XkJTxJ1UR5/MCytRj/PDfN904lmK+ks80Keh0481G04AE8uXCWuem6PRpFyvWDHERFb01dNzeKJjFT/U6jsp1W/q+hGhdqfQLvht8EF2NVM8N7qJtyq5buTZTfSZWOLlJdqe0QfoIdonram8jHNfyYdStRRvD+t1eSJpNnBQHOyQCrHLttl98pjU3kOq514eclEUTQdN52qN1xlLBZCitKfS8HQHTx8CD8I234SU2uStUOyNgn/mGyC8veZn28X7Aj7Ey2hbIYUP8uTI2REdlAcIiH2bWkq/wGPCNb0gyFpObb93Ovcfj1sdGC+yC5YykUbD9/Q/b1GxtqkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izMU3/7M2HQBQmMobtf/WL4n+zVVV0ikPmbsKWqEcac=;
 b=B0dkGR0n0JN9pYgidYLt+LxMqcPlMp6kaG8EzbW9xatsGAZr6R85fjlGb1ZB8+Lg/dHgbWzGeSxGJ9ivI4v7WPk29Vv/Q1mPQQv1lwMJiEAK5FeJ/JW5DbV4FH0SNmjWxwtqDNCSMbOgNsswkI1VZq/n7ZxCXgdxbDFUoWbS8w0aeNoFURtGsVfelo7Rw8YHZOKTCgTX/C6VfZc2euQGHsoa3yIW2CD6Blp/SYbk6kZaWAsJ54mE3/hDv3cN46P7jdwA9DNhz6n6y2s+uWrP1Ly2GWgBg8zJPbLngFP8piY24tPUn+LHf9oenBa4Grvoy01P+KaSJnojd3hk0prtiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izMU3/7M2HQBQmMobtf/WL4n+zVVV0ikPmbsKWqEcac=;
 b=rosKrPC0s8YHscAbuCWv43clZ1XXCHJcw3KxMyFiWK4lNUtBlN+y+boijQw8rTQ7PBJbPTxSynRdIM0SNB756B0xDlON62tQCfd21IWCtCbTfNO99MvpfzMjjzEDUBJESiT4N5Vd564nchU/vMagqAgCuBk5id547fMz/7B2bP4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.19; Tue, 29 Jun 2021 07:43:49 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 07:43:49 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: update the gpu metrics data retrieving
 for Sienna Cichlid
Thread-Topic: [PATCH 1/2] drm/amd/pm: update the gpu metrics data retrieving
 for Sienna Cichlid
Thread-Index: AQHXaZnS3tnW57ggTUOcbwWfISbVqKsqocKw
Date: Tue, 29 Jun 2021 07:43:49 +0000
Message-ID: <DM6PR12MB2619200667C88C0127C9BC3BE4029@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210625081203.978006-1-evan.quan@amd.com>
In-Reply-To: <20210625081203.978006-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-29T07:43:47Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b7e3223e-de89-445d-bfc9-c097eb3b53ec;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 515bfb73-240f-4d62-8c96-08d93ad1a265
x-ms-traffictypediagnostic: DM6PR12MB4220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4220E4B1F5C1442C323F219DE4029@DM6PR12MB4220.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 38W8uHMNClLgvkontTnDLYqjR5N0DJvw9vdhH0CitHNGk5uDsMLwhIvu91nQ60J1zVjB4VMz5PF3B2VpvCFGGsZ8AJMRZNfXnSUr0b1GyTeDkjeyQua+YJMN+rwTsqIy5jqRf6RU0h/ZpmZ3ET6L2RVIjYabBV6FuuJDNzAuHfeYTM8u+jPW0iOtkl3yr6oEr4h6euuAV32Wc+oXk8P/772BBtWUj9OAFfX7el2uo+twreHYQaUdMHVGgUDdi2xiht4g2P6OJTE4jB88Rt7auMP9iCXY5EY8py2c3mo0sNPYsqwInmH4jFizR3bGSh78Abj9BiOrzNYEVIa/nViHDdOoQzhmMAmIX7WCPk6NBEjNKKcdgJ+QoC7PU71GxM1v0pb+CSkM1oIg5O5HcxTncJzblCpTZVFOSat/VD74kpebKD4AxBMsU9+pVhNi3zOEdMhEotbfweJ7Z2sIHb0ayJ3v0f6nWIJ5J3Tys01lNw+BGwx9R9bBP03EzQbFjmgV3Dn0bva0ntg/nWND/9wqVdCn4MAwhpkxw8vAPolOY48ujoz4p14zcmoGWndHdR+ovzFTwFSklFdn87fVOFjiebFIPd0ut+TjFTzQP06j9j+qDHeXqY9eI9qSZ5+qoepljI7VFrWvy5qvn1jPcH62ew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(478600001)(4326008)(6506007)(38100700002)(55016002)(186003)(26005)(33656002)(9686003)(2906002)(53546011)(83380400001)(122000001)(6916009)(316002)(7696005)(86362001)(52536014)(76116006)(15650500001)(71200400001)(19627235002)(66476007)(64756008)(8676002)(66446008)(66556008)(8936002)(66946007)(30864003)(5660300002)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gSGeYESMf4HjACyYSYuUEDLeT30qPO5Y/AP1OTRHzMQqzIMnx8UJl+o+CUA7?=
 =?us-ascii?Q?9Bhxcl+N3dEGbPpjHUxRSLfP9u4RUoL6GBEhW2tsvM4UFdxicIsMiSJ2xCAg?=
 =?us-ascii?Q?UeX8o3sKPzgiJRtjgpPPzHHZYvfBauQdVRIQVpSHKSuoGQVfTCdPc8dygG0v?=
 =?us-ascii?Q?kY8wLjihJ25pxrpQgKlkXnaTjoyP6o7Q0kvmw7amookdFck7pGEsGGeyy3+z?=
 =?us-ascii?Q?AebwdqeSQnVxmoVicm65NZn3yZummKKKCfGbyXZPt0KryLAHLkuUXvyeX3Wd?=
 =?us-ascii?Q?lbDJyI1qN+0Kk6LscWR7KQD0N+VsSxJxwYhfs5mgTjOXxB5T4lSdleQ6DTyC?=
 =?us-ascii?Q?3OcxQ3vwefwAfhwhwFW5IHIAibPdS1xqxCvW3o9LhVdGfroVP3hZzyvCW5fE?=
 =?us-ascii?Q?R2VYpfXbxc7SPcdE5+ISlP4DzRKGvJbX73hipleTcCz8r2H9atfr3oDQ4SCb?=
 =?us-ascii?Q?5KQJlQqAoF9SV6hd8WJKY93iu7wZY4U2qvtHvpUE3qcvDaW7cr/gTZjnNopL?=
 =?us-ascii?Q?liJfEcDHzvdDAfkFBJG6LOn2OGhqlTmMAP0aRUg1T98i+q+gRIml1pIAYxJs?=
 =?us-ascii?Q?2jtHuCgO1RSX4pG3cus8ji7xmwoykmFAp6+ZWp5iVGSo0k+mnfALbJ1eDU7Q?=
 =?us-ascii?Q?OOR86iMXbjcu8oRrxFVk2K1h3mat8DOT2NZ5dqUrJUX/15pPqIsYQpNj8/ZN?=
 =?us-ascii?Q?ZHHZtaEj0VdEiOKSyQoPpPzm9B9YrMrsyXwsHnDF8jgXZ5P+Kp+3TAobs7ZE?=
 =?us-ascii?Q?eF+Kc3HjYUwFM1m4ZzpQLlc1GuuTf3tv1I3po26XnE5Ul2K9ovdQRW6daaUM?=
 =?us-ascii?Q?8PhhQcHxKxoO9KvqV1+uomqBKv9IMXmrDbgUL2FxHaUYwxg5FLYIDCVl6oD4?=
 =?us-ascii?Q?n0sOMJjA9U+wug9uT/XO1lUSSvQeKmR7IGiiICm05C4/fBWgwbmsMosgZeNz?=
 =?us-ascii?Q?kkChQXWZKoaYgEyhgYIAGBADk/WMZe8xuNYX/GEWmaFR9O6nfWPdOgGiwJ+T?=
 =?us-ascii?Q?1qhV3OcCqWdp6HpskD9B6AH3kb43zUl2G/jzd9oSPphUOphYOEHvgV1oZkt6?=
 =?us-ascii?Q?jf8voNp7l0x3edi+PHfIin7QC+KPepfUupMCqeWQW8zoc6vfeR+luxmVrgT+?=
 =?us-ascii?Q?4GRE2sswAGbeGSHMboQfNUi4fbGov8EbZnuB1KUwIP8vP5lD1nvQt/z6WjeN?=
 =?us-ascii?Q?HeH0ySkS2KyUbwPqF9AqW3HESju5vXH1aByjcMqTGSyNHigXBaEx+Ei55vEp?=
 =?us-ascii?Q?0J186O1LtF45wKLh3jBO4pdDfePhBjckFnSSeBKi1Bn3Wcjr+SZfTOWCCQJB?=
 =?us-ascii?Q?psYP5t5i0X7t911hi85Z2ApP?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515bfb73-240f-4d62-8c96-08d93ad1a265
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 07:43:49.5176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xeDJvWfxWAWYfZY+1bkSwAAcU9XjmVyG+lsn/GOGjQd5sezTmUJKCXJIri1s8oas
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Ping..

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Friday, June 25, 2021 4:12 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: [PATCH 1/2] drm/amd/pm: update the gpu metrics data retrieving
> for Sienna Cichlid
> 
> Due to the structure layout change: "uint32_t ThrottlerStatus" -> "
> uint8_t  ThrottlingPercentage[THROTTLER_COUNT]".
> 
> Change-Id: Id5c148b0584d972ae73fb9d7347a312944cec13d
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  .../pm/inc/smu11_driver_if_sienna_cichlid.h   |  63 ++++-
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 234 ++++++++++++------
>  2 files changed, 222 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> index 61c87c39be80..0b916a1933df 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> @@ -211,6 +211,7 @@ typedef enum {
>  #define THROTTLER_FIT_BIT          17
>  #define THROTTLER_PPM_BIT          18
>  #define THROTTLER_APCC_BIT         19
> +#define THROTTLER_COUNT            20
> 
>  // FW DState Features Control Bits
>  // FW DState Features Control Bits
> @@ -1406,7 +1407,67 @@ typedef struct {
>  } SmuMetrics_t;
> 
>  typedef struct {
> -  SmuMetrics_t SmuMetrics;
> +  uint32_t CurrClock[PPCLK_COUNT];
> +
> +  uint16_t AverageGfxclkFrequencyPreDs;  uint16_t
> + AverageGfxclkFrequencyPostDs;  uint16_t AverageFclkFrequencyPreDs;
> + uint16_t AverageFclkFrequencyPostDs;  uint16_t
> + AverageUclkFrequencyPreDs  ;  uint16_t AverageUclkFrequencyPostDs  ;
> +
> +
> +  uint16_t AverageGfxActivity    ;
> +  uint16_t AverageUclkActivity   ;
> +  uint8_t  CurrSocVoltageOffset  ;
> +  uint8_t  CurrGfxVoltageOffset  ;
> +  uint8_t  CurrMemVidOffset      ;
> +  uint8_t  Padding8        ;
> +  uint16_t AverageSocketPower    ;
> +  uint16_t TemperatureEdge       ;
> +  uint16_t TemperatureHotspot    ;
> +  uint16_t TemperatureMem        ;
> +  uint16_t TemperatureVrGfx      ;
> +  uint16_t TemperatureVrMem0     ;
> +  uint16_t TemperatureVrMem1     ;
> +  uint16_t TemperatureVrSoc      ;
> +  uint16_t TemperatureLiquid0    ;
> +  uint16_t TemperatureLiquid1    ;
> +  uint16_t TemperaturePlx        ;
> +  uint16_t Padding16             ;
> +  uint32_t AccCnt                ;
> +  uint8_t  ThrottlingPercentage[THROTTLER_COUNT];
> +
> +
> +  uint8_t  LinkDpmLevel;
> +  uint8_t  CurrFanPwm;
> +  uint16_t CurrFanSpeed;
> +
> +  //BACO metrics, PMFW-1721
> +  //metrics for D3hot entry/exit and driver ARM msgs  uint8_t
> + D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
> +  uint8_t D3HotExitCountPerMode[D3HOT_SEQUENCE_COUNT];
> +  uint8_t ArmMsgReceivedCountPerMode[D3HOT_SEQUENCE_COUNT];
> +
> +  //PMFW-4362
> +  uint32_t EnergyAccumulator;
> +  uint16_t AverageVclk0Frequency  ;
> +  uint16_t AverageDclk0Frequency  ;
> +  uint16_t AverageVclk1Frequency  ;
> +  uint16_t AverageDclk1Frequency  ;
> +  uint16_t VcnActivityPercentage  ; //place holder, David N. to provide full
> sequence
> +  uint8_t  PcieRate               ;
> +  uint8_t  PcieWidth              ;
> +  uint16_t AverageGfxclkFrequencyTarget;  uint16_t Padding16_2;
> +
> +} SmuMetrics_V2_t;
> +
> +typedef struct {
> +  union {
> +    SmuMetrics_t SmuMetrics;
> +    SmuMetrics_V2_t SmuMetrics_V2;
> +  };
>    uint32_t Spare[1];
> 
>    // Padding - ignore
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 0c3407025eb2..f882c6756bf0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -80,6 +80,13 @@
>  		(*member) = (smu->smu_table.driver_pptable +
> offsetof(PPTable_t, field));\  } while(0)
> 
> +#define GET_METRICS_MEMBER(field, member) do { \
> +	if ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) && (smu-
> >smc_fw_version >= 0x3A4300)) \
> +		(*member) = ((void *)(&(((SmuMetricsExternal_t *)(smu-
> >smu_table.metrics_table))->SmuMetrics_V2)) + offsetof(SmuMetrics_V2_t,
> field)); \
> +	else \
> +		(*member) = ((void *)(&(((SmuMetricsExternal_t
> +*)(smu->smu_table.metrics_table))->SmuMetrics)) +
> +offsetof(SmuMetrics_t, field)); \ } while(0)
> +
>  static int get_table_size(struct smu_context *smu)  {
>  	if (smu->adev->asic_type == CHIP_BEIGE_GOBY) @@ -489,13
> +496,33 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
>  	return -ENOMEM;
>  }
> 
> +static uint32_t sienna_cichlid_get_throttler_status_locked(struct
> +smu_context *smu) {
> +	struct smu_table_context *smu_table= &smu->smu_table;
> +	SmuMetricsExternal_t *metrics_ext =
> +		(SmuMetricsExternal_t *)(smu_table->metrics_table);
> +	uint32_t throttler_status = 0;
> +	int i;
> +
> +	if ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) &&
> +	     (smu->smc_fw_version >= 0x3A4300)) {
> +		for (i = 0; i < THROTTLER_COUNT; i++) {
> +			if (metrics_ext-
> >SmuMetrics_V2.ThrottlingPercentage[i])
> +				throttler_status |= 1U << i;
> +		}
> +	} else {
> +		throttler_status = metrics_ext->SmuMetrics.ThrottlerStatus;
> +	}
> +
> +	return throttler_status;
> +}
> +
>  static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>  					       MetricsMember_t member,
>  					       uint32_t *value)
>  {
> -	struct smu_table_context *smu_table= &smu->smu_table;
> -	SmuMetrics_t *metrics =
> -		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))-
> >SmuMetrics);
> +	uint32_t *data_u32;
> +	uint16_t *data_u16;
>  	int ret = 0;
> 
>  	mutex_lock(&smu->metrics_lock);
> @@ -510,78 +537,100 @@ static int
> sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
> 
>  	switch (member) {
>  	case METRICS_CURR_GFXCLK:
> -		*value = metrics->CurrClock[PPCLK_GFXCLK];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> +		*value = data_u32[PPCLK_GFXCLK];
>  		break;
>  	case METRICS_CURR_SOCCLK:
> -		*value = metrics->CurrClock[PPCLK_SOCCLK];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> +		*value = data_u32[PPCLK_SOCCLK];
>  		break;
>  	case METRICS_CURR_UCLK:
> -		*value = metrics->CurrClock[PPCLK_UCLK];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> +		*value = data_u32[PPCLK_UCLK];
>  		break;
>  	case METRICS_CURR_VCLK:
> -		*value = metrics->CurrClock[PPCLK_VCLK_0];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> +		*value = data_u32[PPCLK_VCLK_0];
>  		break;
>  	case METRICS_CURR_VCLK1:
> -		*value = metrics->CurrClock[PPCLK_VCLK_1];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> +		*value = data_u32[PPCLK_VCLK_1];
>  		break;
>  	case METRICS_CURR_DCLK:
> -		*value = metrics->CurrClock[PPCLK_DCLK_0];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> +		*value = data_u32[PPCLK_DCLK_0];
>  		break;
>  	case METRICS_CURR_DCLK1:
> -		*value = metrics->CurrClock[PPCLK_DCLK_1];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> +		*value = data_u32[PPCLK_DCLK_1];
>  		break;
>  	case METRICS_CURR_DCEFCLK:
> -		*value = metrics->CurrClock[PPCLK_DCEFCLK];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> +		*value = data_u32[PPCLK_DCEFCLK];
>  		break;
>  	case METRICS_CURR_FCLK:
> -		*value = metrics->CurrClock[PPCLK_FCLK];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> +		*value = data_u32[PPCLK_FCLK];
>  		break;
>  	case METRICS_AVERAGE_GFXCLK:
> -		if (metrics->AverageGfxActivity <=
> SMU_11_0_7_GFX_BUSY_THRESHOLD)
> -			*value = metrics->AverageGfxclkFrequencyPostDs;
> +		GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
> +		if (*data_u16 <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
> +
> 	GET_METRICS_MEMBER(AverageGfxclkFrequencyPostDs,
> &data_u16);
>  		else
> -			*value = metrics->AverageGfxclkFrequencyPreDs;
> +
> 	GET_METRICS_MEMBER(AverageGfxclkFrequencyPreDs,
> &data_u16);
> +		*value = *data_u16;
>  		break;
>  	case METRICS_AVERAGE_FCLK:
> -		*value = metrics->AverageFclkFrequencyPostDs;
> +		GET_METRICS_MEMBER(AverageFclkFrequencyPostDs,
> &data_u16);
> +		*value = *data_u16;
>  		break;
>  	case METRICS_AVERAGE_UCLK:
> -		*value = metrics->AverageUclkFrequencyPostDs;
> +		GET_METRICS_MEMBER(AverageUclkFrequencyPostDs,
> &data_u16);
> +		*value = *data_u16;
>  		break;
>  	case METRICS_AVERAGE_GFXACTIVITY:
> -		*value = metrics->AverageGfxActivity;
> +		GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
> +		*value = *data_u16;
>  		break;
>  	case METRICS_AVERAGE_MEMACTIVITY:
> -		*value = metrics->AverageUclkActivity;
> +		GET_METRICS_MEMBER(AverageUclkActivity, &data_u16);
> +		*value = *data_u16;
>  		break;
>  	case METRICS_AVERAGE_SOCKETPOWER:
> -		*value = metrics->AverageSocketPower << 8;
> +		GET_METRICS_MEMBER(AverageSocketPower, &data_u16);
> +		*value = *data_u16 << 8;
>  		break;
>  	case METRICS_TEMPERATURE_EDGE:
> -		*value = metrics->TemperatureEdge *
> +		GET_METRICS_MEMBER(TemperatureEdge, &data_u16);
> +		*value = *data_u16 *
>  			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>  		break;
>  	case METRICS_TEMPERATURE_HOTSPOT:
> -		*value = metrics->TemperatureHotspot *
> +		GET_METRICS_MEMBER(TemperatureHotspot, &data_u16);
> +		*value = *data_u16 *
>  			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>  		break;
>  	case METRICS_TEMPERATURE_MEM:
> -		*value = metrics->TemperatureMem *
> +		GET_METRICS_MEMBER(TemperatureMem, &data_u16);
> +		*value = *data_u16 *
>  			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>  		break;
>  	case METRICS_TEMPERATURE_VRGFX:
> -		*value = metrics->TemperatureVrGfx *
> +		GET_METRICS_MEMBER(TemperatureVrGfx, &data_u16);
> +		*value = *data_u16 *
>  			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>  		break;
>  	case METRICS_TEMPERATURE_VRSOC:
> -		*value = metrics->TemperatureVrSoc *
> +		GET_METRICS_MEMBER(TemperatureVrSoc, &data_u16);
> +		*value = *data_u16 *
>  			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>  		break;
>  	case METRICS_THROTTLER_STATUS:
> -		*value = metrics->ThrottlerStatus;
> +		*value = sienna_cichlid_get_throttler_status_locked(smu);
>  		break;
>  	case METRICS_CURR_FANSPEED:
> -		*value = metrics->CurrFanSpeed;
> +		GET_METRICS_MEMBER(CurrFanSpeed, &data_u16);
> +		*value = *data_u16;
>  		break;
>  	default:
>  		*value = UINT_MAX;
> @@ -3564,68 +3613,103 @@ static ssize_t
> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>  	struct smu_table_context *smu_table = &smu->smu_table;
>  	struct gpu_metrics_v1_3 *gpu_metrics =
>  		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
> -	SmuMetricsExternal_t metrics_external;
> -	SmuMetrics_t *metrics =
> -		&(metrics_external.SmuMetrics);
> -	struct amdgpu_device *adev = smu->adev;
> -	uint32_t smu_version;
> +	uint32_t *data_u32;
> +	uint16_t *data_u16;
> +	uint8_t *data_u8;
>  	int ret = 0;
> 
> -	ret = smu_cmn_get_metrics_table(smu,
> -					&metrics_external,
> -					true);
> -	if (ret)
> +	mutex_lock(&smu->metrics_lock);
> +
> +	ret = smu_cmn_get_metrics_table_locked(smu,
> +					       NULL,
> +					       true);
> +	if (ret) {
> +		mutex_unlock(&smu->metrics_lock);
>  		return ret;
> +	}
> 
>  	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
> 
> -	gpu_metrics->temperature_edge = metrics->TemperatureEdge;
> -	gpu_metrics->temperature_hotspot = metrics-
> >TemperatureHotspot;
> -	gpu_metrics->temperature_mem = metrics->TemperatureMem;
> -	gpu_metrics->temperature_vrgfx = metrics->TemperatureVrGfx;
> -	gpu_metrics->temperature_vrsoc = metrics->TemperatureVrSoc;
> -	gpu_metrics->temperature_vrmem = metrics-
> >TemperatureVrMem0;
> +	GET_METRICS_MEMBER(TemperatureEdge, &data_u16);
> +	gpu_metrics->temperature_edge = *data_u16;
> +
> +	GET_METRICS_MEMBER(TemperatureHotspot, &data_u16);
> +	gpu_metrics->temperature_hotspot = *data_u16;
> +
> +	GET_METRICS_MEMBER(TemperatureMem, &data_u16);
> +	gpu_metrics->temperature_mem = *data_u16;
> +
> +	GET_METRICS_MEMBER(TemperatureVrGfx, &data_u16);
> +	gpu_metrics->temperature_vrgfx = *data_u16;
> +
> +	GET_METRICS_MEMBER(TemperatureVrSoc, &data_u16);
> +	gpu_metrics->temperature_vrsoc = *data_u16;
> +
> +	GET_METRICS_MEMBER(TemperatureVrMem0, &data_u16);
> +	gpu_metrics->temperature_vrmem = *data_u16;
> 
> -	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
> -	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
> -	gpu_metrics->average_mm_activity = metrics-
> >VcnActivityPercentage;
> +	GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
> +	gpu_metrics->average_gfx_activity = *data_u16;
> 
> -	gpu_metrics->average_socket_power = metrics-
> >AverageSocketPower;
> -	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
> +	GET_METRICS_MEMBER(AverageUclkActivity, &data_u16);
> +	gpu_metrics->average_umc_activity = *data_u16;
> 
> -	if (metrics->AverageGfxActivity <=
> SMU_11_0_7_GFX_BUSY_THRESHOLD)
> -		gpu_metrics->average_gfxclk_frequency = metrics-
> >AverageGfxclkFrequencyPostDs;
> +	GET_METRICS_MEMBER(VcnActivityPercentage, &data_u16);
> +	gpu_metrics->average_mm_activity = *data_u16;
> +
> +	GET_METRICS_MEMBER(AverageSocketPower, &data_u16);
> +	gpu_metrics->average_socket_power = *data_u16;
> +
> +	GET_METRICS_MEMBER(EnergyAccumulator, &data_u32);
> +	gpu_metrics->energy_accumulator = *data_u32;
> +
> +	GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
> +	if (*data_u16 <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
> +		GET_METRICS_MEMBER(AverageGfxclkFrequencyPostDs,
> &data_u16);
>  	else
> -		gpu_metrics->average_gfxclk_frequency = metrics-
> >AverageGfxclkFrequencyPreDs;
> -	gpu_metrics->average_uclk_frequency = metrics-
> >AverageUclkFrequencyPostDs;
> -	gpu_metrics->average_vclk0_frequency = metrics-
> >AverageVclk0Frequency;
> -	gpu_metrics->average_dclk0_frequency = metrics-
> >AverageDclk0Frequency;
> -	gpu_metrics->average_vclk1_frequency = metrics-
> >AverageVclk1Frequency;
> -	gpu_metrics->average_dclk1_frequency = metrics-
> >AverageDclk1Frequency;
> -
> -	gpu_metrics->current_gfxclk = metrics->CurrClock[PPCLK_GFXCLK];
> -	gpu_metrics->current_socclk = metrics->CurrClock[PPCLK_SOCCLK];
> -	gpu_metrics->current_uclk = metrics->CurrClock[PPCLK_UCLK];
> -	gpu_metrics->current_vclk0 = metrics->CurrClock[PPCLK_VCLK_0];
> -	gpu_metrics->current_dclk0 = metrics->CurrClock[PPCLK_DCLK_0];
> -	gpu_metrics->current_vclk1 = metrics->CurrClock[PPCLK_VCLK_1];
> -	gpu_metrics->current_dclk1 = metrics->CurrClock[PPCLK_DCLK_1];
> -
> -	gpu_metrics->throttle_status = metrics->ThrottlerStatus;
> +		GET_METRICS_MEMBER(AverageGfxclkFrequencyPreDs,
> &data_u16);
> +	gpu_metrics->average_gfxclk_frequency = *data_u16;
> +
> +	GET_METRICS_MEMBER(AverageUclkFrequencyPostDs, &data_u16);
> +	gpu_metrics->average_uclk_frequency = *data_u16;
> +
> +	GET_METRICS_MEMBER(AverageVclk0Frequency, &data_u16);
> +	gpu_metrics->average_vclk0_frequency = *data_u16;
> +
> +	GET_METRICS_MEMBER(AverageDclk0Frequency, &data_u16);
> +	gpu_metrics->average_dclk0_frequency = *data_u16;
> +
> +	GET_METRICS_MEMBER(AverageVclk1Frequency, &data_u16);
> +	gpu_metrics->average_vclk1_frequency = *data_u16;
> +
> +	GET_METRICS_MEMBER(AverageDclk1Frequency, &data_u16);
> +	gpu_metrics->average_dclk1_frequency = *data_u16;
> +
> +	GET_METRICS_MEMBER(CurrClock, &data_u32);
> +	gpu_metrics->current_gfxclk = data_u32[PPCLK_GFXCLK];
> +	gpu_metrics->current_socclk = data_u32[PPCLK_SOCCLK];
> +	gpu_metrics->current_uclk = data_u32[PPCLK_UCLK];
> +	gpu_metrics->current_vclk0 = data_u32[PPCLK_VCLK_0];
> +	gpu_metrics->current_dclk0 = data_u32[PPCLK_DCLK_0];
> +	gpu_metrics->current_vclk1 = data_u32[PPCLK_VCLK_1];
> +	gpu_metrics->current_dclk1 = data_u32[PPCLK_DCLK_1];
> +
> +	gpu_metrics->throttle_status =
> +			sienna_cichlid_get_throttler_status_locked(smu);
>  	gpu_metrics->indep_throttle_status =
> -			smu_cmn_get_indep_throttler_status(metrics-
> >ThrottlerStatus,
> +			smu_cmn_get_indep_throttler_status(gpu_metrics-
> >throttle_status,
> 
> sienna_cichlid_throttler_map);
> 
> -	gpu_metrics->current_fan_speed = metrics->CurrFanSpeed;
> +	GET_METRICS_MEMBER(CurrFanSpeed, &data_u16);
> +	gpu_metrics->current_fan_speed = *data_u16;
> 
> -	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
> -	if (ret)
> -		return ret;
> +	if (((smu->adev->asic_type == CHIP_SIENNA_CICHLID) && smu-
> >smc_fw_version > 0x003A1E00) ||
> +	      ((smu->adev->asic_type == CHIP_NAVY_FLOUNDER) && smu-
> >smc_fw_version > 0x00410400)) {
> +		GET_METRICS_MEMBER(PcieWidth, &data_u8);
> +		gpu_metrics->pcie_link_width = *data_u8;
> 
> -	if (((adev->asic_type == CHIP_SIENNA_CICHLID) && smu_version >
> 0x003A1E00) ||
> -	      ((adev->asic_type == CHIP_NAVY_FLOUNDER) && smu_version >
> 0x00410400)) {
> -		gpu_metrics->pcie_link_width = metrics->PcieWidth;
> -		gpu_metrics->pcie_link_speed = link_speed[metrics-
> >PcieRate];
> +		GET_METRICS_MEMBER(PcieRate, &data_u8);
> +		gpu_metrics->pcie_link_speed = link_speed[*data_u8];
>  	} else {
>  		gpu_metrics->pcie_link_width =
> 
> 	smu_v11_0_get_current_pcie_link_width(smu);
> @@ -3633,6 +3717,8 @@ static ssize_t
> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
> 
> 	smu_v11_0_get_current_pcie_link_speed(smu);
>  	}
> 
> +	mutex_unlock(&smu->metrics_lock);
> +
>  	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
> 
>  	*table = (void *)gpu_metrics;
> --
> 2.29.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
