Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79601C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 03:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041F92310D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 03:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041F92310D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6BC6E062;
	Wed, 20 Jan 2021 03:11:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98AED6E062
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 03:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvPk/HvI1RsW5QmYBV0vb0p3e44EjyOGCOov5uRavi4oWKucS8Y5UguKttcNHoawq9RRCPO1SnNcTNnsZWg5O4Jfou0uvRkv4AraeyR+Sg2n5o8GIOleMJXP64KJIYKITkzacLg2IMcCe++pzRVuTsto6arUKm1XufCYNvpE52w/bujaQZAyqZxIVegjabyMUW/A5H78kZci3MQMaw85gXHR5pmoE2i5kWT9/tmvzXqbGStZ1PmM2w2rPi+JE0/Wz0RR4samTFlQFsYeMU4PzXaaOC2F9QxJiPgPUuW7wfHJelE+tQNRq4DzT4XbBq8uixL8gBSldJmYBaZ9/ovpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7cC8sLc6IH+GH4STVXXNVwAnFJ46lP6V7PnfRKMLxc=;
 b=YnIhtwA4S9UahaetiagzpgCLpw1rvmmNfBqzpNS/zn5qL1WE/hb6x6rPIyf9hMB9LpdHpg+/0eZW/Sa7C1BvZBEofejSGsXUwNuBlugWh3z+n4vvVv5BtB9NiLvBbqGiVD4yQZPUfsWkXNtrUsP/aQCran2W47pR7zV2SdCfVBKWRrGmlsjuGb89lF+mtgRc7SHBTbHAQf8j6jv3MxVNZku7AsHKgMhmcFDy1gjtLyPmpcBRtabMHBlodql1rUmwpBWa7/ucNpHxW3Se2j/easlN1MKAK7NEt6QBwNXSBWhz6vhEE/yo2aqttYDQuKQ/5NnWgWBMcPqed+xjDNYmUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7cC8sLc6IH+GH4STVXXNVwAnFJ46lP6V7PnfRKMLxc=;
 b=Aqsy4iNbQzdPzBrK7D+MjcLa/7/MtUie+uZV06hMPI4pkHxy40D56n1lV0siJ2j2SFQEtgRcT3k63FCkKqO/e2EyCjRmSETC60ZLW4pA5vus0z/w7aaxGoN2sqcUO1hDANyXkZOuAPbX4Oul3X3E2ZivM8OTRBXPr5YjXaJxupY=
Received: from CY4PR12MB1159.namprd12.prod.outlook.com (2603:10b6:903:36::17)
 by CY4PR1201MB2549.namprd12.prod.outlook.com (2603:10b6:903:da::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 20 Jan
 2021 03:11:26 +0000
Received: from CY4PR12MB1159.namprd12.prod.outlook.com
 ([fe80::82f:2413:1026:786a]) by CY4PR12MB1159.namprd12.prod.outlook.com
 ([fe80::82f:2413:1026:786a%12]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 03:11:26 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update mmhub mgcg&ls for mmhub_v2_3
Thread-Topic: [PATCH] drm/amdgpu: update mmhub mgcg&ls for mmhub_v2_3
Thread-Index: AQHW7s+oCiM6noChy0m67z5WqyGZuqovxA+AgAAR1mA=
Date: Wed, 20 Jan 2021 03:11:26 +0000
Message-ID: <CY4PR12MB1159CB448D9D51F7D09F15CAF0A20@CY4PR12MB1159.namprd12.prod.outlook.com>
References: <20210120015732.3986339-1-aaron.liu@amd.com>
 <20210120020619.GA610615@hr-amd>
In-Reply-To: <20210120020619.GA610615@hr-amd>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-20T03:11:01Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=86eac40b-d6fb-4465-9344-00005a833d86;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2021-01-20T03:11:01Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e66763b4-fa70-474b-8562-0000b39aaf78
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57c69686-05d4-44cc-7771-08d8bcf1131f
x-ms-traffictypediagnostic: CY4PR1201MB2549:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB2549352835CD63FE2D419E3BF0A29@CY4PR1201MB2549.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: spCBUy15GmZbOWUWT3QKLUS7tMc/4CvRlm6nxe84EJVf+ZWsHikQYoon84ACBO3p9p/xTXXmf+PY52ti6kyz+UA1IEOLQGk9q5vqQjpi2GMrcA5S9PH27hmwKmYlCp5X7CECx9BrodpcotMVoyHmMUBSQfvtZIsaEdJGctYkQd910tGxQCm9xQV7ZYEXg31B2jC5pDT3xRq2+sV9TwlCqhqsHBsg+4wZw8Ro7LQGQiLlMIow1HG9/av8vfifGDrf3/cDu3MsLwgn6da4nhmYx60PMcy2/dQALhTcJ+ARtLmGBVr61vrynZC/ea4QQNJwCLio6/WxwXPKLMqGMymonPBonAaFeq5BHgUGPQKBvt5tjJLQ7Ujm3jKqGLaxiZiln34AHYRXJAGYmRx2m7zARg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1159.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(52536014)(7696005)(5660300002)(316002)(53546011)(8676002)(2906002)(66476007)(6506007)(76116006)(66446008)(64756008)(66556008)(4326008)(26005)(186003)(66946007)(83380400001)(8936002)(478600001)(6636002)(54906003)(55016002)(33656002)(6862004)(9686003)(86362001)(71200400001)(15650500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cI6YLJkPOcN5pYEZ8NzFSjBOmnQqCrZnGZqgdUwQiF5rFQW83NzeI+eaqL8V?=
 =?us-ascii?Q?p2wvFZF2qLHp2X0BW/iJyIyt7ySmgL2c1BSm3xnjpJwUrJPHnTzNN2l2V5iH?=
 =?us-ascii?Q?0FDWvKRSHdHfMYUsmu1mrM+bw5nG+g4IC17dQlpK2AOa3nwjLJZtThT9DtqE?=
 =?us-ascii?Q?stGShMm9OpCN6d5mcb/hCM2QNI12iRWIX+qREnx1NwbbK6+oXv19/JXiPtBU?=
 =?us-ascii?Q?IiJVtTE51w037w/PwranNMTkKMHY38Ax9jUiDPkLp4VWREJt6oPDUMT2269b?=
 =?us-ascii?Q?zAV1oW6zRlrZyqcdFDUAP0aaQY1xiB8vraTvr1sMko5Oe74Ocb6rn42Ymkvv?=
 =?us-ascii?Q?2bWibg9F4r2md8hA+ZW+d1UY1qmLbCr8UDw62WC5QjfDZD6tUGYdFi2XLE9w?=
 =?us-ascii?Q?FV4oxJGzxXQ10Qphe8HS3u4IDewRNDJso7TUd18CrTw+GmtDgmANuYjFE+tm?=
 =?us-ascii?Q?G4lOYLfi9MYNJJuHEfinJ6IX4uOYbptri2/OCQ1gvKqmcGevRPXrMw94G8dp?=
 =?us-ascii?Q?Tti3xF1XuiDDHVsPe0w9i10d2cBz9tcx97So6d/ZIBUYy4OrkjvSFoYRfzS2?=
 =?us-ascii?Q?8G/OqJ5Y5ZKy3EgFvumMMesGc7x6XAVEyocjpGX0EGy2h/rd77QSgi2CvhNN?=
 =?us-ascii?Q?rPQCws5+sBH5xMATfTHF5xSTm1MBN99ugwHYQQOKNF26+pbRH7LXeNVLBCMA?=
 =?us-ascii?Q?/D4Chnc3mB1pjIQPYzN5Yxt+KE0zztR9DEY609SWkyRo4nXB4eU9uUADzXNG?=
 =?us-ascii?Q?yDsSSpt5j237uTJNFZCOXloLbo3iGmqK+c6yhLFz9/H5bEvbwqwDXqcpQMRM?=
 =?us-ascii?Q?KOaO9/mG2guvkL1mcv+dW0oPRf0oMa+0RNUXNghLUu1fs2TP4NilrFyDbUEw?=
 =?us-ascii?Q?jpX6POC5DgFszmvfmmHPCAVNTAYHWCI6R3j6t+AwrFc/MaWhxdfQkZTPZsKw?=
 =?us-ascii?Q?EiXRTUof6vZjPfViZ5r6fIGC3AW1WCzdYmJZ54XSw9A=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1159.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c69686-05d4-44cc-7771-08d8bcf1131f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 03:11:26.5975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HW+DfZhXs2VyQt1T6QcqMTG0sDJZX2djJU8b0JDvnINnYZo+PZxZZTIzH2b7AIcm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2549
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

This patch has been Verfied on Van Gogh.

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Wednesday, January 20, 2021 10:06 AM
> To: Liu, Aaron <Aaron.Liu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: update mmhub mgcg&ls for
> mmhub_v2_3
> 
> On Wed, Jan 20, 2021 at 09:57:32AM +0800, Liu, Aaron wrote:
> > Starting from vangogh, the ATCL2 and DAGB0 registers relative to
> > mgcg/ls has changed.
> >
> > For MGCG:
> > Replace mmMM_ATC_L2_MISC_CG with mmMM_ATC_L2_CGTT_CLK_CTRL.
> >
> > For MGLS:
> > Replace mmMM_ATC_L2_MISC_CG with mmMM_ATC_L2_CGTT_CLK_CTRL.
> > Add DAGB0_(WR/RD)_CGTT_CLK_CTRL registers.
> >
> > Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> 
> Could you double verify it on vangogh as well?
> 
> After that, patch is
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> 
> > ---
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 84
> > ++++++++++++++++++-------
> >  1 file changed, 61 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> > b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> > index 92f02883daa3..8f2edba5bc9e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
> > @@ -492,12 +492,11 @@
> > mmhub_v2_3_update_medium_grain_clock_gating(struct amdgpu_device
> *adev,  {
> >  	uint32_t def, data, def1, data1;
> >
> > -	def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
> > +	def  = data  = RREG32_SOC15(MMHUB, 0,
> mmMM_ATC_L2_CGTT_CLK_CTRL);
> >  	def1 = data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2);
> >
> >  	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG)) {
> > -		data |= MM_ATC_L2_MISC_CG__ENABLE_MASK;
> > -
> > +		data &=
> ~MM_ATC_L2_CGTT_CLK_CTRL__SOFT_OVERRIDE_MASK;
> >  		data1 &=
> ~(DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
> >  		           DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
> >  		           DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
> @@ -506,8
> > +505,7 @@ mmhub_v2_3_update_medium_grain_clock_gating(struct
> amdgpu_device *adev,
> >  		           DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
> >
> >  	} else {
> > -		data &= ~MM_ATC_L2_MISC_CG__ENABLE_MASK;
> > -
> > +		data |=
> MM_ATC_L2_CGTT_CLK_CTRL__SOFT_OVERRIDE_MASK;
> >  		data1 |= (DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
> >  			  DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
> >  			  DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
> @@ -517,7 +515,7 @@
> > mmhub_v2_3_update_medium_grain_clock_gating(struct amdgpu_device
> *adev,
> >  	}
> >
> >  	if (def != data)
> > -		WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG, data);
> > +		WREG32_SOC15(MMHUB, 0,
> mmMM_ATC_L2_CGTT_CLK_CTRL, data);
> >  	if (def1 != data1)
> >  		WREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2,
> data1);  } @@ -526,17
> > +524,44 @@ static void
> > mmhub_v2_3_update_medium_grain_light_sleep(struct amdgpu_device
> *adev,
> >  					   bool enable)
> >  {
> > -	uint32_t def, data;
> > -
> > -	def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
> > -
> > -	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS))
> > -		data |= MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
> > -	else
> > -		data &= ~MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
> > +	uint32_t def, data, def1, data1, def2, data2;
> > +
> > +	def  = data  = RREG32_SOC15(MMHUB, 0,
> mmMM_ATC_L2_CGTT_CLK_CTRL);
> > +	def1 = data1 = RREG32_SOC15(MMHUB, 0,
> mmDAGB0_WR_CGTT_CLK_CTRL);
> > +	def2 = data2 = RREG32_SOC15(MMHUB, 0,
> mmDAGB0_RD_CGTT_CLK_CTRL);
> > +
> > +	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS)) {
> > +		data &=
> ~MM_ATC_L2_CGTT_CLK_CTRL__MGLS_OVERRIDE_MASK;
> > +		data1
> &= !(DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> > +
> 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> > +
> 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> > +
> 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> > +
> 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK);
> > +		data2 &= !(DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_MASK
> |
> > +
> 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> > +
> 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> > +
> 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> > +
> 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK);
> > +	} else {
> > +		data |=
> MM_ATC_L2_CGTT_CLK_CTRL__MGLS_OVERRIDE_MASK;
> > +		data1 |= (DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_MASK
> |
> > +
> 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> > +
> 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> > +
> 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> > +
> 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK);
> > +		data2 |= (DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> > +
> 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> > +
> 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> > +
> 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> > +
> 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK);
> > +	}
> >
> >  	if (def != data)
> > -		WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG, data);
> > +		WREG32_SOC15(MMHUB, 0,
> mmMM_ATC_L2_CGTT_CLK_CTRL, data);
> > +	if (def1 != data1)
> > +		WREG32_SOC15(MMHUB, 0, mmDAGB0_WR_CGTT_CLK_CTRL,
> data1);
> > +	if (def2 != data2)
> > +		WREG32_SOC15(MMHUB, 0, mmDAGB0_RD_CGTT_CLK_CTRL,
> data2);
> >  }
> >
> >  static int mmhub_v2_3_set_clockgating(struct amdgpu_device *adev, @@
> > -555,26 +580,39 @@ static int mmhub_v2_3_set_clockgating(struct
> > amdgpu_device *adev,
> >
> >  static void mmhub_v2_3_get_clockgating(struct amdgpu_device *adev,
> > u32 *flags)  {
> > -	int data, data1;
> > +	int data, data1, data2, data3;
> >
> >  	if (amdgpu_sriov_vf(adev))
> >  		*flags = 0;
> >
> > -	data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
> > -	data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2);
> > +	data = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2);
> > +	data1  = RREG32_SOC15(MMHUB, 0,
> mmMM_ATC_L2_CGTT_CLK_CTRL);
> > +	data2 = RREG32_SOC15(MMHUB, 0, mmDAGB0_WR_CGTT_CLK_CTRL);
> > +	data3 = RREG32_SOC15(MMHUB, 0, mmDAGB0_RD_CGTT_CLK_CTRL);
> >
> >  	/* AMD_CG_SUPPORT_MC_MGCG */
> > -	if ((data & MM_ATC_L2_MISC_CG__ENABLE_MASK) &&
> > -	    !(data1 & (DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
> > +	if (!(data & (DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
> >  		       DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
> >  		       DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
> >  		       DAGB0_CNTL_MISC2__DISABLE_RDRET_CG_MASK |
> >  		       DAGB0_CNTL_MISC2__DISABLE_TLBWR_CG_MASK |
> > -		       DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK)))
> > -		*flags |= AMD_CG_SUPPORT_MC_MGCG;
> > +		       DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK))
> > +		&& !(data1 &
> MM_ATC_L2_CGTT_CLK_CTRL__SOFT_OVERRIDE_MASK)) {
> > +			*flags |= AMD_CG_SUPPORT_MC_MGCG;
> > +	}
> >
> >  	/* AMD_CG_SUPPORT_MC_LS */
> > -	if (data & MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK)
> > +	if (!(data1 & MM_ATC_L2_CGTT_CLK_CTRL__MGLS_OVERRIDE_MASK)
> > +		&& !(data2 &
> (DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> > +
> 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> > +
> 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> > +
> 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> > +
> 	DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK))
> > +		&& !(data3 &
> (DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
> > +
> 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
> > +
> 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
> > +
> 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
> > +
> 	DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK)))
> >  		*flags |= AMD_CG_SUPPORT_MC_LS;
> >  }
> >
> > --
> > 2.25.1
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
