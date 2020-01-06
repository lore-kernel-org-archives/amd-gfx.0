Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BB6C32767
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 06:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 689F221734
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 06:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Us5yDjDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689F221734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC23189D99;
	Mon,  6 Jan 2020 06:34:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98D0F89D99
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 06:34:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9oeiIVEzBosOkP0ROF0VpwME1I6/ydJzmKuZid8O1EpkLqnabD+oBLXZhDmGuv6O67NC1kZ6EKtzilWDGgumaeWurCgcfi6Gb+VauUFmK6grH9y2Lm+sO0Uuz1D9fSbx/wVJ3RXK+GV6tthLrMfG3EB7CyRmhoCyATaN6Qdio4/eGVXxoIsRzi/kSZpgL+au5HViGE7crtL1uk4lgARUk/oKFtePI0FIs+kvwvCqOFUVcn5iAqMhSIpIplvUx3lk2v3nvECMDWh1wnzbYSvHomkxO+IRPtaZBj91kBj2GlbUkJr29oi9mMpNz4FSDiPL1epLDpPyRM07ypPaRYvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SbUtGS5yISvnmRhgFPF6/xiwC4sYIgoUzjVM+PZrJE=;
 b=khaYDey7N6bPlKhG/kXxchNXcaAooAVNqyQrWJpguMyw4k9OXuqOT8KEx+uRyUpQtJeshj+mXNV/PAmZQfhrtrmZNF2FjxFUWFFszndiGdULh4n2zfWZagbC6g752Zop7nF57zv/JKui64/dOHdortiANgO4vg+3oAsfKy/TkqMnPhRf5W12cRtK8BrzGK8CqqDfmQPLk/bNNVAz4jGWhLH03h4+o+v37dbLCYEGP9a/W6vfuxxdL1N8NveEDWcXrGgkJmLXqeb5m7YxGY+TMlCM3aiWQWudYJUV48xVIDREo4a/shu4BdarGfLD5DG463o9EbnjypszlRrlr/BQdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SbUtGS5yISvnmRhgFPF6/xiwC4sYIgoUzjVM+PZrJE=;
 b=Us5yDjDrlHekvVyBYzhqwY0Xs5hjW/ayTUSTQQTHNBVYt5nVSjH7VCNFiFmbDbtuw5h94LPFg5K6LHP/yBM1eddt1exFsNAarFUnRtm4Z1WpnxJz963YEs6HfogKXXOmPrCasyIpd04tM8E2Zi9aNm+lZtXa8rcTP0rm32oC2es=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3151.namprd12.prod.outlook.com (20.178.244.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Mon, 6 Jan 2020 06:34:02 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 06:34:02 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: issue proper hdp flush for table
 transferring
Thread-Topic: [PATCH] drm/amd/powerplay: issue proper hdp flush for table
 transferring
Thread-Index: AQHVwhrYwRHIf9zVBUqs9xEq3r6OY6fdMkcw
Date: Mon, 6 Jan 2020 06:34:01 +0000
Message-ID: <MN2PR12MB3344F5C72C95B6F0BD2BA887E43C0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200103094726.32428-1-evan.quan@amd.com>
In-Reply-To: <20200103094726.32428-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a19b3d80-01db-47ee-b5c1-00000cc2957c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-06T06:33:46Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ccb6fa1a-92d0-4b9b-e846-08d792726b47
x-ms-traffictypediagnostic: MN2PR12MB3151:
x-microsoft-antispam-prvs: <MN2PR12MB3151C1252378E42B9AEB9CEBE43C0@MN2PR12MB3151.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(13464003)(6916009)(33656002)(81166006)(81156014)(8676002)(8936002)(53546011)(71200400001)(66446008)(86362001)(64756008)(7696005)(6506007)(76116006)(66476007)(66556008)(66946007)(478600001)(2906002)(5660300002)(52536014)(19627235002)(55016002)(26005)(186003)(316002)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3151;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6C9FNdfUaUOec6WwzdM58wGBS5EahGAf9B3EAs0CGvDJIcl9UyrDm+Fapw1noCtjFx6gl06T4SO3ZlTX3adaIFID6c88LhnFIEDtklJ9eJDsA2eKiJpTpYCOef3Ir3nJPg50FBLGcZGfFkYbHFLEen5kNNBxslUXHEaR6M6uMZVKieVr15mxPgwrbNuXKNaNWzJYmQes8CnsK1MRjzsyblSwz2/kvPHt02qyCFAQGjKe5G2V547JDmHeXgbEWHOVgDRB4D0SPuNP438gY+t39jiC7kX5aEUSUEGVncUYSDN53WUZgeewkedF1nsr6Ycp6sRWwAXnCp1f/RvgRhywptAMhMQUTozBngIzMpWa4GrKj2s1hrYEvsfYbaM8icn4kkWBLW2U+6yI7B7YiOcqCzgDS7eV06J0zpIU/tYqn+4xWlsuV4UWIAQzeAN8G1G46iFSeXg4DKvQi9zZIHsdeaHVosRJByxstDOzpFM/+5nobQ0AI6f2I3qBMS3JhqVv
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb6fa1a-92d0-4b9b-e846-08d792726b47
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 06:34:01.8187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apNXGMb0Kbi1Yw6aZGjFwFrbOvpXAl+UdfdNmS76XMkU4KZFOThZ8D+5rBIQ+1Um
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3151
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping..

> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Friday, January 3, 2020 5:47 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH] drm/amd/powerplay: issue proper hdp flush for table
> transferring
> 
> Guard the content consistence between the view of GPU and CPU during the
> table transferring.
> 
> Change-Id: Ib3cebb97a1c8fb302eb040483bbaf089ae00c6a9
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c        | 15 ++++++++++-----
>  .../gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c   |  5 ++++-
>  .../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c  |  5 ++++-
>   .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c  |  5 ++++-
>   .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c  | 10 ++++++++--
>  5 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index a56ebcc4e3c7..e1b64134bbd8 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -529,8 +529,14 @@ int smu_update_table(struct smu_context *smu,
> enum smu_table_id table_index, int
> 
>  	table_size = smu_table->tables[table_index].size;
> 
> -	if (drv2smu)
> +	if (drv2smu) {
>  		memcpy(table->cpu_addr, table_data, table_size);
> +		/*
> +		 * Flush hdp cache: to guard the content seen by
> +		 * GPU is consitent with CPU.
> +		 */
> +		amdgpu_asic_flush_hdp(adev, NULL);
> +	}
> 
>  	ret = smu_send_smc_msg_with_param(smu, drv2smu ?
>  					  SMU_MSG_TransferTableDram2Smu :
> @@ -539,11 +545,10 @@ int smu_update_table(struct smu_context *smu,
> enum smu_table_id table_index, int
>  	if (ret)
>  		return ret;
> 
> -	/* flush hdp cache */
> -	adev->nbio.funcs->hdp_flush(adev, NULL);
> -
> -	if (!drv2smu)
> +	if (!drv2smu) {
> +		amdgpu_asic_flush_hdp(adev, NULL);
>  		memcpy(table_data, table->cpu_addr, table_size);
> +	}
> 
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
> b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
> index aa0ee2b46135..2319400a3fcb 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
> @@ -137,7 +137,7 @@ static int smu10_copy_table_from_smc(struct
> pp_hwmgr *hwmgr,
>  			priv->smu_tables.entry[table_id].table_id);
> 
>  	/* flush hdp cache */
> -	adev->nbio.funcs->hdp_flush(adev, NULL);
> +	amdgpu_asic_flush_hdp(adev, NULL);
> 
>  	memcpy(table, (uint8_t *)priv->smu_tables.entry[table_id].table,
>  			priv->smu_tables.entry[table_id].size);
> @@ -150,6 +150,7 @@ static int smu10_copy_table_to_smc(struct pp_hwmgr
> *hwmgr,  {
>  	struct smu10_smumgr *priv =
>  			(struct smu10_smumgr *)(hwmgr->smu_backend);
> +	struct amdgpu_device *adev = hwmgr->adev;
> 
>  	PP_ASSERT_WITH_CODE(table_id < MAX_SMU_TABLE,
>  			"Invalid SMU Table ID!", return -EINVAL;); @@ -161,6
> +162,8 @@ static int smu10_copy_table_to_smc(struct pp_hwmgr *hwmgr,
>  	memcpy(priv->smu_tables.entry[table_id].table, table,
>  			priv->smu_tables.entry[table_id].size);
> 
> +	amdgpu_asic_flush_hdp(adev, NULL);
> +
>  	smu10_send_msg_to_smc_with_parameter(hwmgr,
>  			PPSMC_MSG_SetDriverDramAddrHigh,
>  			upper_32_bits(priv-
> >smu_tables.entry[table_id].mc_addr));
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
> b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
> index 39427ca32a15..715564009089 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
> @@ -58,7 +58,7 @@ static int vega10_copy_table_from_smc(struct pp_hwmgr
> *hwmgr,
>  			priv->smu_tables.entry[table_id].table_id);
> 
>  	/* flush hdp cache */
> -	adev->nbio.funcs->hdp_flush(adev, NULL);
> +	amdgpu_asic_flush_hdp(adev, NULL);
> 
>  	memcpy(table, priv->smu_tables.entry[table_id].table,
>  			priv->smu_tables.entry[table_id].size);
> @@ -70,6 +70,7 @@ static int vega10_copy_table_to_smc(struct pp_hwmgr
> *hwmgr,
>  		uint8_t *table, int16_t table_id)
>  {
>  	struct vega10_smumgr *priv = hwmgr->smu_backend;
> +	struct amdgpu_device *adev = hwmgr->adev;
> 
>  	/* under sriov, vbios or hypervisor driver
>  	 * has already copy table to smc so here only skip it @@ -87,6 +88,8
> @@ static int vega10_copy_table_to_smc(struct pp_hwmgr *hwmgr,
>  	memcpy(priv->smu_tables.entry[table_id].table, table,
>  			priv->smu_tables.entry[table_id].size);
> 
> +	amdgpu_asic_flush_hdp(adev, NULL);
> +
>  	smu9_send_msg_to_smc_with_parameter(hwmgr,
>  			PPSMC_MSG_SetDriverDramAddrHigh,
>  			upper_32_bits(priv-
> >smu_tables.entry[table_id].mc_addr));
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
> b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
> index 90c782c132d2..a3915bfcce81 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
> @@ -66,7 +66,7 @@ static int vega12_copy_table_from_smc(struct pp_hwmgr
> *hwmgr,
>  			return -EINVAL);
> 
>  	/* flush hdp cache */
> -	adev->nbio.funcs->hdp_flush(adev, NULL);
> +	amdgpu_asic_flush_hdp(adev, NULL);
> 
>  	memcpy(table, priv->smu_tables.entry[table_id].table,
>  			priv->smu_tables.entry[table_id].size);
> @@ -84,6 +84,7 @@ static int vega12_copy_table_to_smc(struct pp_hwmgr
> *hwmgr,  {
>  	struct vega12_smumgr *priv =
>  			(struct vega12_smumgr *)(hwmgr->smu_backend);
> +	struct amdgpu_device *adev = hwmgr->adev;
> 
>  	PP_ASSERT_WITH_CODE(table_id < TABLE_COUNT,
>  			"Invalid SMU Table ID!", return -EINVAL); @@ -95,6
> +96,8 @@ static int vega12_copy_table_to_smc(struct pp_hwmgr *hwmgr,
>  	memcpy(priv->smu_tables.entry[table_id].table, table,
>  			priv->smu_tables.entry[table_id].size);
> 
> +	amdgpu_asic_flush_hdp(adev, NULL);
> +
> 
> 	PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(h
> wmgr,
>  			PPSMC_MSG_SetDriverDramAddrHigh,
>  			upper_32_bits(priv-
> >smu_tables.entry[table_id].mc_addr)) == 0, diff --git
> a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> index f604612f411f..0db57fb83d30 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> @@ -189,7 +189,7 @@ static int vega20_copy_table_from_smc(struct
> pp_hwmgr *hwmgr,
>  			return ret);
> 
>  	/* flush hdp cache */
> -	adev->nbio.funcs->hdp_flush(adev, NULL);
> +	amdgpu_asic_flush_hdp(adev, NULL);
> 
>  	memcpy(table, priv->smu_tables.entry[table_id].table,
>  			priv->smu_tables.entry[table_id].size);
> @@ -207,6 +207,7 @@ static int vega20_copy_table_to_smc(struct pp_hwmgr
> *hwmgr,  {
>  	struct vega20_smumgr *priv =
>  			(struct vega20_smumgr *)(hwmgr->smu_backend);
> +	struct amdgpu_device *adev = hwmgr->adev;
>  	int ret = 0;
> 
>  	PP_ASSERT_WITH_CODE(table_id < TABLE_COUNT, @@ -219,6 +220,8
> @@ static int vega20_copy_table_to_smc(struct pp_hwmgr *hwmgr,
>  	memcpy(priv->smu_tables.entry[table_id].table, table,
>  			priv->smu_tables.entry[table_id].size);
> 
> +	amdgpu_asic_flush_hdp(adev, NULL);
> +
>  	PP_ASSERT_WITH_CODE((ret =
> vega20_send_msg_to_smc_with_parameter(hwmgr,
>  			PPSMC_MSG_SetDriverDramAddrHigh,
>  			upper_32_bits(priv-
> >smu_tables.entry[table_id].mc_addr))) == 0, @@ -242,11 +245,14 @@ int
> vega20_set_activity_monitor_coeff(struct pp_hwmgr *hwmgr,  {
>  	struct vega20_smumgr *priv =
>  			(struct vega20_smumgr *)(hwmgr->smu_backend);
> +	struct amdgpu_device *adev = hwmgr->adev;
>  	int ret = 0;
> 
>  	memcpy(priv-
> >smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].table, table,
>  			priv-
> >smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size);
> 
> +	amdgpu_asic_flush_hdp(adev, NULL);
> +
>  	PP_ASSERT_WITH_CODE((ret =
> vega20_send_msg_to_smc_with_parameter(hwmgr,
>  			PPSMC_MSG_SetDriverDramAddrHigh,
>  			upper_32_bits(priv-
> >smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].mc_addr))) == 0, @@ -
> 290,7 +296,7 @@ int vega20_get_activity_monitor_coeff(struct pp_hwmgr
> *hwmgr,
>  			return ret);
> 
>  	/* flush hdp cache */
> -	adev->nbio.funcs->hdp_flush(adev, NULL);
> +	amdgpu_asic_flush_hdp(adev, NULL);
> 
>  	memcpy(table, priv-
> >smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].table,
>  			priv-
> >smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size);
> --
> 2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
