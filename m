Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A640C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 19:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5427601FC
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 19:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5427601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 707676E509;
	Mon, 29 Mar 2021 19:55:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2796E509
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 19:55:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDDlq3mBKbSvIefHMVMYiqJPMcONN5hqN6DgQfq74oXvQLdRBt9h4S2nUNK75jhg6ACzqGqLvYhZxvQGJpSEcolTnDFAo2QfRYkES2auEEHFHapeqFtayMzK836YiZ2pYhyWudflcB2Hx5rH/U3xNIyq5mquyT1kkc/JBJ7O4cNqqNd6PUtZ8jgFOSJ9ClMNIgAJF+lZzEzu2OMdIIgk2wLxT0uGGqbGL+Vg0JIFNbgN0dY5EtHj1Z4oA+kKWEor8mlJDZjRC62aD3o176DDUjrRsCgYQqh2LAydXqmEcckx4gdO1qQZ2oc2UVf77H8/80kzhTea/e2nWhvleSJz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5beiUNWjMRA1uHEiWt0zfSa04JYWdDkfXOehpTfSRo=;
 b=FiTcOLmN5JrK17itLgx68q7aAqEEVxe1qqmv3QAxOoCH5DYaLjDN6B/3ZXBL9E8wzavLZARzuCJLL9iNvWAHZhkqTjDcF+OZBM0/bgQXcXVDqg7/qFHanN/S9leD/HqfBa2xRta/a4mLv7VpylwZfu2MpljZQT475MxGtFID0jBu8Mql95e0aXGPD+zlF3XHX0HHAw3ftLfxV1lRlMBGnlD+altjv0XCUIu9PZ39kuQfteIjPNk7x51DtdaHi+otA424NxcOfPRiDmhjppGG1mTVkPNZw7abgOQpjAnO15gn5Sh0q4DIaP/mk3cIlRMUSxPS4YLOy8Hw0pBP6EFrYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5beiUNWjMRA1uHEiWt0zfSa04JYWdDkfXOehpTfSRo=;
 b=hRrg5Surfr/QLtcgAifXbw4yBGPrWm03tPhj8BZh3DrdnrfU4xydIaDUM6Na5Gl/TPlP9Qg+uwhY1VIGF93wzyHa9ZJouttpqpAiAEkWEdGc2Uw09YRzSJOxbYWcsMPLRx/s7E5y2DrOQHMNvawACd+2tUvYqZ08lXqIaqPzUBM=
Received: from BL0PR12MB4755.namprd12.prod.outlook.com (2603:10b6:208:82::26)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Mon, 29 Mar
 2021 19:55:51 +0000
Received: from BL0PR12MB4755.namprd12.prod.outlook.com
 ([fe80::ace7:b127:34db:23a0]) by BL0PR12MB4755.namprd12.prod.outlook.com
 ([fe80::ace7:b127:34db:23a0%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 19:55:50 +0000
From: "Khaire, Rohit" <Rohit.Khaire@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chang, HaiJun" <HaiJun.Chang@amd.com>,
 "Ming, Davis" <Davis.Ming@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add new PF2VF flags for VF register access
 method
Thread-Topic: [PATCH] drm/amdgpu: Add new PF2VF flags for VF register access
 method
Thread-Index: AQHXICU/rLeCW+/DP0OhS7DKSeZPy6qbJwqAgABDLvA=
Date: Mon, 29 Mar 2021 19:55:48 +0000
Message-ID: <BL0PR12MB4755215D5C37B0EB4E12328D877E9@BL0PR12MB4755.namprd12.prod.outlook.com>
References: <20210323204414.11341-1-rohit.khaire@amd.com>
 <b93076c5-13f8-34e8-549b-bef07af17419@amd.com>
In-Reply-To: <b93076c5-13f8-34e8-549b-bef07af17419@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-29T19:55:48Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=61b8dd59-694f-4785-86e8-805560192fb3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: babb924a-c735-420c-0b44-08d8f2eca77c
x-ms-traffictypediagnostic: MN2PR12MB4239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB42390C2DD24E3BD01C87CF91877E9@MN2PR12MB4239.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fdNUhcMJgmYoUZy9nh9W1QkTzmTFflw8EZFfhhejFywV/zmgNKDxobkBvbjG/VjD6mvQBoC5w1ITnd8/avu7C2yRomZ41bxC809/7AW/ZfkxozMFyHlsOKV5IlGF0dLQIJrsXqHliGGFMx4stxw3v+qcUb+9lxbw7o76ItrJpXkNLGPhY4vu5ve/ePcvbTo5MX16docS/lbVwHiT9x6kTb/GrQp+Wq9wXr2qxIN5RSbDH3Hv5/8iBngqiahGv/FokwFKHtotlT7BMQ1TsvI35Hgf9w9rv++h2LSRkQOVRYNF8NOKSG9zOpiEy3nraasGjxMASEd8wg0R1cT1SrQ3Elf06DIslLXvn5vimpfSt0vwF3US6Mtfmd+ywGiKrIc03OxbdY96zProX8fixfwCT0GBkKzIKwsTYfaiTkxQc7lJA516u+UGyRV3jmiVvMbr8D3mCEDWG/xdmPguyZUTUZIQ8b4zCn2HuqkhTWhoeQXi+MDXIiU1V2WhneXFV4DnrBetBGJrCjGXAx9gOeaXWZu2cScfDW3uc2xDTBnKZ/DCQqROnKO3LzAe31/hmT68sDaqgcQQM1jxvz5133em6Y1pT8tN6mK0QL+z0RqZLGddxHf9BTcVdLuRKf9wgL152lqrjLl7fV2xRz9j+mWslZyVW2RZuXXoSjYuBlHzBdc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4755.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(52536014)(54906003)(53546011)(38100700001)(66476007)(6506007)(478600001)(110136005)(76116006)(83380400001)(71200400001)(8936002)(66446008)(26005)(2906002)(186003)(316002)(66946007)(86362001)(4326008)(6636002)(64756008)(8676002)(9686003)(7696005)(33656002)(66556008)(55016002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?akl5ZkVVMVZzV3RJMGlqTEdJNDgzMVVIc3EyWGtVY1JwbHZlVzJPU0d6NnZk?=
 =?utf-8?B?anc3NkNYc0xUaGZDbnJWKzg2UWdhaUtyYXdpRjRPOGJ2bThDWlUwNGY0Qjlk?=
 =?utf-8?B?emd0akJzWmZ6S2FCdVdacU13SUhQNjlaR05ERWkvT1RINVlIeWxhTjVCa01p?=
 =?utf-8?B?QXE2SHpvMXhDd0xSdWJIbjJhakZIdlNqbkdkb3ZTb0JqTHRqSGxxWHJ2RW9t?=
 =?utf-8?B?RkJtQXorb1FxQnU4c3h1T0ZQUXNTdTRYZ3B4czdtQ2kwUTVBZEQrMUYvMUhv?=
 =?utf-8?B?eSt3Ujl5aWhkZnlhMnd5R0NqUkhETFh4Y3QzQ1RMZFMyRmxFaGJBRFAwUEM4?=
 =?utf-8?B?UFZMcGlkSmNLci9oMGdoUElxMWZ6YUowVElCaEhoelNCeEd4cTRKUkZ2QlEx?=
 =?utf-8?B?MUtDTndGNGw3Y1pqR29aYkhjRWx0TG00RUZNUitrZVAxbGhTQ2lEUFBDeFlp?=
 =?utf-8?B?dHZVWUlXUE41bTN3M2huMDNEUnZQVi9jUi9RTC90M3QyN1Y1TEtYemlHMFlQ?=
 =?utf-8?B?RUVtbVgvSHVuVVFpYWE3Mk9DcURKOEpXbDk4T1ppN3FxUjhZNWxFQ1hhTDhE?=
 =?utf-8?B?WmRZTU1vRDFOY080eXhYREpHSk5weGxSZm0zN0VnS1JqWVpHcWh6U2d3c1dO?=
 =?utf-8?B?MzF0TlVyd21PRHhsN04yTFlTNE9VZ2taTkgwMXg2NFpqanJZVjRwcTNDck5H?=
 =?utf-8?B?QnRqMU5wb2NGQy9MTGRTTTNjM29uSG45a2FxR2o1OTBzbWRlVXMvbGk4QzZE?=
 =?utf-8?B?WnprbDdyeVo2VEtsekVScnlTYTdSTVNsVWlza2JKdW5uclJZM1ozQ3pUblhu?=
 =?utf-8?B?OTIzNmdFYjBzN2dzOXFnajY5REtycHFZK2tRWTRPQkdXbUhuc0FwU0plaGdD?=
 =?utf-8?B?M1JwRUNOMGNsOHcrSFVyQnBzVHlvTXQ1YVN2RnROVG51NzI4QS9YQ2kwZ2FV?=
 =?utf-8?B?eVE0UVBycUxGNjNtRmo4dHZWUXhvZ2JrdUpHZitBd0d4ZE50NzlnQkFxbFBK?=
 =?utf-8?B?NG95a2RLR0F1U3VzYzFPYjFZU3RYYm95N3ZjTTJNcXMrSUFzVnVaRFdkS3RB?=
 =?utf-8?B?cUZqNi9hY0hPeEFyN3VqNVFtVmFyTVZaa1J3VkI1NGd5a1J0Q3FjTWtmVHUy?=
 =?utf-8?B?U2JhaFN2ZDQyNTVRb0pCT1lUZnpFKzQ0Sm05RElNdUtHcGdjOVROcU9FREhT?=
 =?utf-8?B?b2crczhzNjFWd0lEYWpreFIvOFRJUm9rK0hSWnlNL1V5V2FKZlJySmpFOXc1?=
 =?utf-8?B?YkNFcXZHR1p6Tml0SWNsclhMWmQ5cmJNZWF1TVo4NXZYa0dJY0wzeDZrUnds?=
 =?utf-8?B?RitpaExaWjl3aFV0THRMYjlObzl1alZrVXkxSlRGQytKK2xuaG90YWZTNmVQ?=
 =?utf-8?B?ZU9ZcTBXQ0hZYlVrSmhyNjNlN0FycXpNSitGSFVscjF2cXlXTm05K2NWWE1v?=
 =?utf-8?B?YlNHa2JRQ1VvVTJib0hNWU4vNk1tcngveGo4amtJMndQc1NBWVpnRnRaYzNE?=
 =?utf-8?B?V29KREZxa1NjK0FiaThBc09NTGFNWEZ6OVVMTjQxck1qdDBhalFUWUJJaDQ3?=
 =?utf-8?B?aTRPelVoaGs5L1c4N0NhQkRYTERVakE2WWo4YmhOTjMzNHdEc2FtcU5vb2xR?=
 =?utf-8?B?cGNrWENGRFprdy8yYlM1bEwrdDJvZ1BnM1RpNDE2R2pWN0NjMS9HYTNwZ0ta?=
 =?utf-8?B?QUlmZ3lwL3oyQnFRdGZIZ2dqQUdJS2lYMGZCbDhFZ3ZXTTRzcHIzcTJzUGJs?=
 =?utf-8?Q?aUtINUZ333ebgb9t89SOhs8XG2GDua50zBd0eOo?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4755.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babb924a-c735-420c-0b44-08d8f2eca77c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 19:55:50.6294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apN0Y846odHBjfpdZ1EZydkab+n7d4KIJ2FwFUYj7Po3OsawpsxwdpSr8ZGvh9e2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Thanks Alex and Luben. 

I've addressed the comments and pushed the changes.

Rohit

-----Original Message-----
From: Tuikov, Luben <Luben.Tuikov@amd.com> 
Sent: March 29, 2021 11:54 AM
To: Khaire, Rohit <Rohit.Khaire@amd.com>; amd-gfx@lists.freedesktop.org; Chang, HaiJun <HaiJun.Chang@amd.com>; Ming, Davis <Davis.Ming@amd.com>; Liu, Monk <Monk.Liu@amd.com>
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add new PF2VF flags for VF register access method

On 2021-03-23 4:44 p.m., Rohit Khaire wrote:
> Add 3 sub flags to notify guest for indirect access of gc, mmhub and ih
> 
> Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    | 11 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 17 +++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 8dd624c20f89..0224f352d060 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -104,6 +104,17 @@ enum AMDGIM_FEATURE_FLAG {
>  	AMDGIM_FEATURE_GIM_MM_BW_MGR = 0x8,
>  	/* PP ONE VF MODE in GIM */
>  	AMDGIM_FEATURE_PP_ONE_VF = (1 << 4),
> +	/* Indirect Reg Access enabled */
> +	AMDGIM_FETURE_INDIRECT_REG_ACCESS = (1 << 5),

Spelling: FETURE --> FEATURE

> +};
> +
> +enum AMDGIM_REG_ACCESS_FLAG {
> +	/* Use PSP to program IH_RB_CNTL */
> +	AMDGIM_FEATURE_IH_REG_PSP_EN = (1 << 0),
> +	/* Use RLC to program MMHUB regs */
> +	AMDGIM_FEATURE_RLC_MMHUB_EN  = (1 << 1),
> +	/* Use RLC to program GC regs */
> +	AMDGIM_FEATURE_RLC_GC_EN     = (1 << 2),
>  };
>  
>  struct amdgim_pf2vf_info_v1 {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 5355827ed0ae..7fed6377d931 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -90,11 +90,22 @@ union amd_sriov_msg_feature_flags {
>  		uint32_t  host_flr_vramlost  : 1;
>  		uint32_t  mm_bw_management   : 1;
>  		uint32_t  pp_one_vf_mode     : 1;
> -		uint32_t  reserved           : 27;
> +		uint32_t  reg_indirect_acc   : 1;
> +		uint32_t  reserved           : 26;
>  	} flags;
>  	uint32_t      all;
>  };
>  
> +union amd_sriov_reg_access_flags {
> +	struct {
> +		uint32_t vf_reg_access_ih    : 1;
> +		uint32_t vf_reg_access_mmhub : 1;
> +		uint32_t vf_reg_access_gc    : 1;
> +		uint32_t reserved            : 29;
> +	} flags;
> +	uint32_t all;
> +};
> +
>  union amd_sriov_msg_os_info {
>  	struct {
>  		uint32_t  windows            : 1;
> @@ -149,8 +160,10 @@ struct amd_sriov_msg_pf2vf_info {
>  	/* identification in ROCm SMI */
>  	uint64_t uuid;
>  	uint32_t fcn_idx;
> +	/* flags to indicate which register access method VF should use */
> +	union amd_sriov_reg_access_flags reg_access_flags;

"to" --> "which" to become

/* flags which indicate the register access method VF should use */

With these fixed, and Alex's comments addressed, this patch is:

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

>  	/* reserved */
> -	uint32_t reserved[256-26];
> +	uint32_t reserved[256-27];
>  };
>  
>  struct amd_sriov_msg_vf2pf_info_header {
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
