Return-Path: <SRS0=ZYFY=5S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB2AC43331
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 06:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C43620678
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 06:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DGSKainJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C43620678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1CD46E9CC;
	Thu,  2 Apr 2020 06:09:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770077.outbound.protection.outlook.com [40.107.77.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2BFB6E9CC
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2020 06:09:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tm09dgXoZoAsgR5Aixw4GXO0kqeDOE44bJ7JO7EA/qaIzW8yjF/ioJuFTqr9yx/gvXLnbjN0TexDXj8/qyguHRi0SNrQdRjsHzRfmLvJleESUeaZTqhV738c3A6fpiA6541KcZUPoxEl078yINgygGvkaC62uM8qJkfpzMBAnSBrukCvsiY3MHSpEdTJsUfs4yW44XEFJzERRuQA8rYVGy81FHHf8iYz5nv7PzcvIuE9Bji0+8dnaZroZp50ARaGfBrzKkcKtayxCecCAqKD8VA72q0b7NLJTDw65B4OPcK1isSPGxv57Svb6nLpS+nQY01rsWZpDXWxhinw5KsdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7takl6iOINqGTxVpg10qj+uUFa4ryUl//dQP+YRWqY=;
 b=lHHPCdGHSiyPDRYB32qijnGqBd7BMbgK1pXuNOYdyXq/eYAXlJuD6ALD6SgR3o3c5ccWsps3IlPYvVJppPXhNW2u+v7cz3BamP3pnWNQCU37glQrS17AVmRxx9nQuKAvvnBHlfY2QC93K48rFFOuHhnzrFvAuYTzITVwQpfLvcSDqa9T8iFy+23OtrYpZQU/Ax9YPNUHAiivgZZ41nFHJcpgO1R65Nv4vJi6NIPfGcx7rNvuL9aDCoB2CtIEgEWLLF3NyjIXR0QtmfL85GSKkxXstczQfJPduHB5ebbWfFpysztPOC3RAF+t09J0C+l44Wg/sfjj1eU4GLDmBhGULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7takl6iOINqGTxVpg10qj+uUFa4ryUl//dQP+YRWqY=;
 b=DGSKainJhm5x/u1Ql9MTosS2x7wUB3rdLZoOBQyrd2heoRfzMEbhUT+JOKnsRZoTn8p8NgOD6svjBPtOlU1lC6DHzwECi7lLuA9AztOBaRa9M7myNGAKSN4WXlTzFXkwyGana2vcLkZKiPUjoe+DaEOBJ9PXDKmjfDxz2I/1PkM=
Received: from CY4PR12MB1749.namprd12.prod.outlook.com (2603:10b6:903:11d::16)
 by CY4PR12MB1176.namprd12.prod.outlook.com (2603:10b6:903:38::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Thu, 2 Apr
 2020 06:09:21 +0000
Received: from CY4PR12MB1749.namprd12.prod.outlook.com
 ([fe80::20d0:3ee:a99d:797a]) by CY4PR12MB1749.namprd12.prod.outlook.com
 ([fe80::20d0:3ee:a99d:797a%9]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 06:09:21 +0000
From: "Dai, Yuxian (David)" <Yuxian.Dai@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set the
 MCLK
Thread-Topic: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set
 the MCLK
Thread-Index: AQHWCBp2w4g1boFQ/Uyg+kxwWI3Q2ahlWPiAgAABD0A=
Date: Thu, 2 Apr 2020 06:09:21 +0000
Message-ID: <CY4PR12MB1749607CA0A5BD6384BA48D68DC60@CY4PR12MB1749.namprd12.prod.outlook.com>
References: <20200401114112.8372-1-Yuxian.Dai@amd.com>
 <20200402060436.GA4832@jenkins-Celadon-RN>
In-Reply-To: <20200402060436.GA4832@jenkins-Celadon-RN>
Accept-Language: en-AS, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-02T06:09:17Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bc997509-c506-4099-86a1-000086789709;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-02T06:09:17Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e6fa3512-c354-4777-80b9-0000f0380256
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yuxian.Dai@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44bd7477-fcf2-42c1-1197-08d7d6cc62e7
x-ms-traffictypediagnostic: CY4PR12MB1176:|CY4PR12MB1176:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB117699DEA19E7AA1F4C4FA238DC60@CY4PR12MB1176.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:95;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1749.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(316002)(66446008)(66556008)(64756008)(6862004)(66476007)(66946007)(76116006)(71200400001)(55016002)(6506007)(7696005)(4326008)(8936002)(8676002)(9686003)(81166006)(26005)(81156014)(5660300002)(966005)(186003)(6636002)(478600001)(86362001)(45080400002)(33656002)(52536014)(2906002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jgvY/fQTvg9S/BQN7MW1bub4l9XTus/XV7I+A0G6p5fTFj9y9D0/CPECmFDe/NYhOg7Q0q8jogeH2CBQNlydN22YeDCBtTTEqICuozpUOCTCypIKenC3VMlTRVppXwMA3yxivczgI6niS3V7BkCf7NajZvMGqXC7I4cY2Yuv1PvaiVATgxddPEmQaqVu38OuSQQQCdxN2gTCE3Edx9YRDyEKCPXwOqDaOYB5hgQ/+p8TRX9Sf9Kq0Y9JdtCGc6rkVloo/4o8YBEn43E+MYyPtkKpjin+fivnIELq2S0PcCAEjlLVH9e/5Vxge0Pe4VlLtW14u7Xp7dzClWB32YE84kxHIGz3Ry4tTZSUtQ/PCptV6npmL60g/Zal2emyz9MEn/o9FuyzwWRBqcpW+IU4QyApv8yhHTSnyqSiWTyGms0OnvahnjHnNQlTUy5w3qzL0GbIC6rb3TAt0xD2gy9Gz7ijdIrhJ2CAGrYjj4eWA+s+uhwWhrsM7MUPaDZoIuJT38W3NtZ6LW9+3ZgX++gs/A==
x-ms-exchange-antispam-messagedata: RVcsRIShgT6jll2TmX4CDsClgB83faR1UtaZlGll7T28hpiVItu2phbf7jGMobEH6MtoDzyDF9x7ppA/0ncBXUmKRFt3MQK/yJr82ce+aV4DEStZn/sgVdZCD0VTbG1EGZhCZ5KlPLbqqSAH36fQ2g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bd7477-fcf2-42c1-1197-08d7d6cc62e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 06:09:21.5508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eqbk7MkVv8Ej1eBMXidZCBjYZxFJy6dguqStDrHiCn2jyKf8ez0FsYlyClUf32hjGgzr73YzjBZDWYY+IEz2Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1176
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

On Wed, Apr 01, 2020 at 07:41:12PM +0800, Yuxian Dai wrote:
> 1.Using the FCLK DPM table to set the MCLK for DPM states consist of 
> three entities:
>  FCLK
>  UCLK
>  MEMCLK
> All these three clk change together, MEMCLK from FCLK, so use the fclk 
> frequency.
> 2.we should show the current working clock freqency from clock table 
> metric
> 
> Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Kevin Wang <Kevin1.Wang@amd.com>
> ---

Next time, if you submit the V2 patch, you can generate it as below
command:

git format-patch --subject-prefix="PATCH v2"

And describe the changes from v1 -> v2 in the commit message. This will help everyone to understand your change.
    >  I got it. 
Reviewed-by: Huang Rui <ray.huang@amd.com>

>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 6 ++++++  
> drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c 
> b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index 7bf52ecba01d..c6b39a7026a8 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -239,6 +239,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
>  	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
>  	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
>  	SmuMetrics_t metrics;
> +	bool cur_value_match_level = false;
>  
>  	if (!clk_table || clk_type >= SMU_CLK_COUNT)
>  		return -EINVAL;
> @@ -297,8 +298,13 @@ static int renoir_print_clk_levels(struct smu_context *smu,
>  		GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
>  		size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
>  				cur_value == value ? "*" : "");
> +		if (cur_value == value)
> +			cur_value_match_level = true;
>  	}
>  
> +	if (!cur_value_match_level)
> +		size += sprintf(buf + size, "   %uMhz *\n", cur_value);
> +
>  	return size;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h 
> b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
> index 2a390ddd37dd..89cd6da118a3 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
> @@ -37,7 +37,7 @@ extern void renoir_set_ppt_funcs(struct smu_context *smu);
>  			freq = table->SocClocks[dpm_level].Freq;	\
>  			break;						\
>  		case SMU_MCLK:						\
> -			freq = table->MemClocks[dpm_level].Freq;	\
> +			freq = table->FClocks[dpm_level].Freq;	\
>  			break;						\
>  		case SMU_DCEFCLK:					\
>  			freq = table->DcfClocks[dpm_level].Freq;	\
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cra
> y.huang%40amd.com%7Cfa81baf94d2c409e4f0308d7d6319a8f%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637213381443101089&amp;sdata=LF2pLZj%2Fq0C
> wiMSfvDiofXFKuGVfgje7o4Iti%2FtoNj0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
