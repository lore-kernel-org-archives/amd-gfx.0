Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892B5C4743C
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 02:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4E261003
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 02:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4E261003
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7C1289F97;
	Tue, 22 Jun 2021 02:25:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D550689F97
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 02:25:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwVoy4PowhukWWsTRIzI3DCCQuJan/7B8LCjOv9Z0ElAG7Tv5dn5jCnwBaphyPWteB3fsx+UijRi4onb+atEZDrDfEPCYURyF2HGHXSYtFBwVkluHJypfQ6MC33U2fbA1JfSd4iLuLuXTiIiwZ3f7KKylAHoY9zF7i6K7LQDweKhOEu3bfTAQk16wogq00qogbG0a6n1EGgPfMeiz5yV+tNjKZm2fsNYWRzLJj4TbshZl11Qkykk0tCJzjQsVNy8lVl1cpzFGJeq7q0NLAQujKtiF+HWr/Tx36+zw9w2sEl/GiUM+bYNNGsT1PJaHSzlw+bfHurWG1z/d/m8rRdt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1yHQ+guLIomucpvOCT4eOsiwz1sxDmkMXYnZOp141A=;
 b=ES4IHWumYgilhVa9prkXhxKiRYqmUEhhZJLda8LtEA8UVVL+S10wswpmz1FB3utK2/h2NpanLIAjALbSvy1RZa9zYljzdutHxXQF+6n13caZm2LQmBJTpz+ZrIT2TDkMUnLoGpQrUMAN3WIDhEYWyb25VCpUeBnTMn/RJV0ms9/ox9SelZbtyH1mKaeBUtoqMqi/Uxb56+0TFdCgBtYr7f/eUSrjmsI4lcTgdzJ8Lz3QkqZsnW9YGYXpiOod7oTu6IKBFGxVPdcCoSJNcLkMaBQ4jvHSef7AeMqNlWCVGQ0+GrRY8OjXB6S3rqsh1uo38XuEz3ccrmR1pxemjTS0eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1yHQ+guLIomucpvOCT4eOsiwz1sxDmkMXYnZOp141A=;
 b=bSaHpjuoHWnEcoiJljLVFKPXlwOTE7kXISm3w41JYPJtwj3BO3mQjDd0+T2rfolif1xr2j4yCoaJw1rOuamSfd61Gtd4QVACNWOnZidXCFlNXKJ35/hFKjdy5sfasrSpLHWK6ARz6TqJPjjAhyMBoi5m/vjhTzbcvB25JEadF+s=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16; Tue, 22 Jun 2021 02:25:39 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 02:25:39 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V3 1/7] drm/amdgpu: correct tcp harvest setting
Thread-Topic: [PATCH V3 1/7] drm/amdgpu: correct tcp harvest setting
Thread-Index: AQHXZmsxFWAKnvzZrUWX2vJXFPYJwKseX0oAgADsgxA=
Date: Tue, 22 Jun 2021 02:25:38 +0000
Message-ID: <DM6PR12MB2619DA78289C9BC237FF772AE4099@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210621070040.494336-1-evan.quan@amd.com>
 <c4550aab-23b3-fcf9-5fc1-7c129743adb3@amd.com>
In-Reply-To: <c4550aab-23b3-fcf9-5fc1-7c129743adb3@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-22T02:25:35Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=612ff00c-5c76-466a-8160-86cae91c6a10;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 226ab546-42c7-451e-2f93-08d9352506a6
x-ms-traffictypediagnostic: DM6PR12MB4220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4220976034FF6B2963156CC0E4099@DM6PR12MB4220.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DJUx3OdgxyKmHEVzIKy/peC7dgNCyuyjM07x5z2IoXqXLGl3GRT/XLpeWlMZg9uRagsCPBuMdEY32QfpkSlAPJP8Zx2y5Zac4N4onHppsl8UWHty+HYuBeKGrvd++kBsEwpddCg+ewp/nnOjX4vfg8YNAsyLZwNmY+bTV5mHmXStA44D85+Fo1Qh7/rjDSJpaAp56rSOT+Z+lSdf2MU71Mwk696xQgwEQF5y7RBbK0eVGeu9WGDDrZ1HuDXs36LGH9FFFYrvmdk84cLGJPCJkMdQRMMDOlO+I06gjC4xCJoMD2yMFZFUPvut71uPzv6Vy0p0PcGp1dkaS0U/ERT1NScsiy0w72nt/bB0Asc9kUrzzffw+xWkaey6amktLljNMJHgzFWOrRBjGDTmdtYDLwOCqrh4H3wAC6N5FJlX7kR75O2GVionz7WAU3IgbiJBFeyiU1LnS5RgVWo6OJsEBo5kOzvo7BCcV+u33owvIHl4eZeq9TW0wETMSBnhi/sl4eDIlcMkiDUPh2ZCzm0hWZgcJ3ttvN23HLuDrKbumcRFeYsMZ5iiIOVwGPaihuH/tGefgiXwTVeS6u2ZCh/kf6I1JevOLNOs4wq1pRlHTEE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(5660300002)(7696005)(71200400001)(4326008)(316002)(66946007)(9686003)(55016002)(86362001)(66556008)(76116006)(66476007)(64756008)(66446008)(33656002)(478600001)(52536014)(186003)(2906002)(26005)(8936002)(38100700002)(122000001)(8676002)(83380400001)(110136005)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U284dWUwZGNGeTE2VnlTQ0hNa2U2S2hrMFBNNW9hVk9DNFFNcWRVV3BGckNh?=
 =?utf-8?B?S0xLY2kvakdwYzErRjh0MjM1Y2E3bXdsUmFzZVkwcHlub21MME5LRWs2OFBF?=
 =?utf-8?B?L2t0QXk2aHBUTUxRMUtQL3ZsL2xucFhoVUxvbU9ZZU1oZ29KMTJya3JBNHhn?=
 =?utf-8?B?K1BjT3hpdkloRFd0VG5qb21ock9UUVFPb3ZqakZ2S1V6VS9yWi94MU1vRjc2?=
 =?utf-8?B?WUZtVlpqd1VLdjNXZUp4RTUzY1lNWlB4d3dmd1NRZFZrdkFMbXdxSUlKeGNM?=
 =?utf-8?B?T3JSZ2dQSGgzdnM2czJlS1hYYUhFbWFCb1RKSmFQaEZsdjBLZlZ1NEN2VDNK?=
 =?utf-8?B?THk0dGVHNzdKU2NUcHJ0dE9JUkxLME45eW55MVhEcHVlR1FXbGlucHkxc1lC?=
 =?utf-8?B?VnY2MHdLNzJyYS8vMXV0ajVETXhxQnNaRTZseHBjRFNWbEZSSFhjMmxaQzBk?=
 =?utf-8?B?V0R2ZTJhTXMvbE50VzV1TXBpTGM3NFU5SW5QN3R5ZmYwVC9yWUFrdytRbXFG?=
 =?utf-8?B?aThNNVcxT05menUrUXpLd0VQUCs1UXY0VTZxdDZ1ak9FOFgyVWdUVWJ2emJz?=
 =?utf-8?B?WVBHZWdSRHhGWHRqVmtabnM4NEJxaDFEUjR4Wm0yV3pCT0VhSWJFbmNqVU5H?=
 =?utf-8?B?cGpTdXRBL1FTMXNOZUNtcEgzSmxPa3F3bEV4TXQwVGJ6Z3dlNGhHdmMyT3lS?=
 =?utf-8?B?WlRuVmpDUWF3UDVnUG9ScXV0K2JVMGZ0TXcvbExYa0RxeEFuTU1hK1FoR2JK?=
 =?utf-8?B?NFRUVUVGaFd6aEhLTkRWNytrR0tMMndoVno1L1huMHFBeTBPa2c0M0g1WkRG?=
 =?utf-8?B?SEtSenhyVU1TNFdiYTN0R2lnVzZsR2loRng5SnJTWTExUDA5NmtGWGMwVFVC?=
 =?utf-8?B?VDBKSFcxMnVIS3ZtM2ZpR0UxdTIxVTdPVUI2STFuOTdEblJlVUVCampkS0M0?=
 =?utf-8?B?ZVpUdE1PNjY1cGN1azJNb29BSXdZUExXRDF6ckRNWjdaaHlZd0xwWElONG84?=
 =?utf-8?B?WkVGcUZpQzZOeW9peDVHWkUrQllHM2xvVDdlUVBwVDhndWczYVhyV2NMUWxV?=
 =?utf-8?B?VlpFeGtsQ2pROWNadGNja2hwMC9uRjl2TUUrV3JaWlZvZjRDT3h1ZkFiZVVD?=
 =?utf-8?B?U0pGREM5eG9zY2xlZEN6UVoyQkZKQkxyKzlOM2dSWVdJdXpqOXVVRStFQnE4?=
 =?utf-8?B?SmJ4QVpMRmJCVlp0czFLbkMrclZzT2JXdzV5aHhhSVEzM0EvZ2dpVTBBZ0RV?=
 =?utf-8?B?RWFiUUhVV1NrajU1NEtIV3QzS3dwQTBqYUt4ZTdWSWZaaTZVakQ5Nk5Tb1R3?=
 =?utf-8?B?T1A2bTBodUZiWkYzOHNkejFVNzcrSlYvYi9NMmRpQ1hvemJzOFJwZnRnWlZ5?=
 =?utf-8?B?N0o5M0pUSWxueDhmSnMvSkJWSXltMU5mOWRyNlBHY1BkOVdOSnFnam1QQXY1?=
 =?utf-8?B?TWlaQkM0cklMVjJDVlE2c2tFL1NrVysxU21vQkdobjl0SVBDRzhYNUZuRjZq?=
 =?utf-8?B?U1pVUWpnUHZzS3RDaHBMRWlNY0w4MUEvdXEwbVk1dnplVmhVa3JCaklKQWx6?=
 =?utf-8?B?OGRkaWpmcmF4UFgybVNVN3U2WXN3ZTNTWVZGMXNSbnA3bk9wRklJUXNLT1RT?=
 =?utf-8?B?UktkMDI2N09uQmwxQjNZTkFkYVlXTWY1eXJoUlR6TlQyb2RCbzVuQnV2bVMw?=
 =?utf-8?B?L1N0U2tReU5ocENCMkJGQVRKckhrQkExU2VTT2ZvL0p2b0sxRFNlRld0Q01o?=
 =?utf-8?Q?8sA+bobdBBHwRKKYFhhYXNS2BusoiBRNDktF4FB?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226ab546-42c7-451e-2f93-08d9352506a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 02:25:39.0272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HctZbuxgFg2Q8DabRbyTObLUQZZCtWUWzGDJJY46/9Bl+XiXWt2IM5O0Qija89Gj
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

Thanks Lijo.
However, I'm not quite sure whether " 0xffffffff << (4 * max_wgp_per_sh);" is a valid expression since it kind of triggers some overflow.
Can that work for non-x86 platform or even work reliably for x86 platform?

BR
Evan
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, June 21, 2021 8:08 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH V3 1/7] drm/amdgpu: correct tcp harvest setting
> 
> One minor comment below, apart from that the series looks good.
> 
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> 
> On 6/21/2021 12:30 PM, Evan Quan wrote:
> > Add missing settings for SQC bits. And correct some confusing logics
> > around active wgp bitmap calculation.
> >
> > Change-Id: If4992e175fd61d5609b00328cbe21f487517d039
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> > V1->V2:
> >    - restore correct tcp_harvest setting for NV10 and NV12
> >    - move asic type guard upper layer for better readability
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 103 ++++++++++++++------
> -----
> >   1 file changed, 57 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > index 15ae9e33b925..384b95fbad8b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -5090,47 +5090,50 @@ static void gfx_v10_0_tcp_harvest(struct
> amdgpu_device *adev)
> >   		4 + /* RMI */
> >   		1); /* SQG */
> >
> > -	if (adev->asic_type == CHIP_NAVI10 ||
> > -	    adev->asic_type == CHIP_NAVI14 ||
> > -	    adev->asic_type == CHIP_NAVI12) {
> > -		mutex_lock(&adev->grbm_idx_mutex);
> > -		for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
> > -			for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
> > -				gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff);
> > -				wgp_active_bitmap =
> gfx_v10_0_get_wgp_active_bitmap_per_sh(adev);
> > -				/*
> > -				 * Set corresponding TCP bits for the inactive
> WGPs in
> > -				 * GCRD_SA_TARGETS_DISABLE
> > -				 */
> > -				gcrd_targets_disable_tcp = 0;
> > -				/* Set TCP & SQC bits in
> UTCL1_UTCL0_INVREQ_DISABLE */
> > -				utcl_invreq_disable = 0;
> > -
> > -				for (k = 0; k < max_wgp_per_sh; k++) {
> > -					if (!(wgp_active_bitmap & (1 << k))) {
> > -						gcrd_targets_disable_tcp |=
> 3 << (2 * k);
> > -						utcl_invreq_disable |= (3 <<
> (2 * k)) |
> > -							(3 << (2 *
> (max_wgp_per_sh + k)));
> > -					}
> > +	mutex_lock(&adev->grbm_idx_mutex);
> > +	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
> > +		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
> > +			gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff);
> > +			wgp_active_bitmap =
> gfx_v10_0_get_wgp_active_bitmap_per_sh(adev);
> > +			/*
> > +			 * Set corresponding TCP bits for the inactive WGPs in
> > +			 * GCRD_SA_TARGETS_DISABLE
> > +			 */
> > +			gcrd_targets_disable_tcp = 0;
> > +			/* Set TCP & SQC bits in
> UTCL1_UTCL0_INVREQ_DISABLE */
> > +			utcl_invreq_disable = 0;
> > +
> > +			for (k = 0; k < max_wgp_per_sh; k++) {
> > +				if (!(wgp_active_bitmap & (1 << k))) {
> > +					gcrd_targets_disable_tcp |= 3 << (2 *
> k);
> > +					gcrd_targets_disable_tcp |= 1 << (k +
> (max_wgp_per_sh * 2));
> > +					utcl_invreq_disable |= (3 << (2 * k)) |
> > +						(3 << (2 * (max_wgp_per_sh
> + k)));
> >   				}
> > -
> > -				tmp = RREG32_SOC15(GC, 0,
> mmUTCL1_UTCL0_INVREQ_DISABLE);
> > -				/* only override TCP & SQC bits */
> > -				tmp &= 0xffffffff << (4 * max_wgp_per_sh);
> > -				tmp |= (utcl_invreq_disable &
> utcl_invreq_disable_mask);
> > -				WREG32_SOC15(GC, 0,
> mmUTCL1_UTCL0_INVREQ_DISABLE, tmp);
> > -
> > -				tmp = RREG32_SOC15(GC, 0,
> mmGCRD_SA_TARGETS_DISABLE);
> > -				/* only override TCP bits */
> > -				tmp &= 0xffffffff << (2 * max_wgp_per_sh);
> > -				tmp |= (gcrd_targets_disable_tcp &
> gcrd_targets_disable_mask);
> > -				WREG32_SOC15(GC, 0,
> mmGCRD_SA_TARGETS_DISABLE, tmp);
> >   			}
> > -		}
> >
> > -		gfx_v10_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> > -		mutex_unlock(&adev->grbm_idx_mutex);
> > +			tmp = RREG32_SOC15(GC, 0,
> mmUTCL1_UTCL0_INVREQ_DISABLE);
> > +			/* only override TCP & SQC bits */
> > +			if (adev->asic_type == CHIP_NAVI14)
> > +				tmp &= 0xff000000;
> > +			else
> > +				tmp &=0xfff00000;
> 
> For the disable field mask calculation (which is the value that is applied finally),
> there is no ASIC check. The above code may utilize the same method as in
> the original code without ASIC check.
> 
> tmp &= 0xffffffff << (4 * max_wgp_per_sh);
> 
> Same for below case also - 3*max_wgp_per_sh.
> 
> Thanks,
> Lijo
> 
> > +			tmp |= (utcl_invreq_disable &
> utcl_invreq_disable_mask);
> > +			WREG32_SOC15(GC, 0,
> mmUTCL1_UTCL0_INVREQ_DISABLE, tmp);
> > +
> > +			tmp = RREG32_SOC15(GC, 0,
> mmGCRD_SA_TARGETS_DISABLE);
> > +			/* only override TCP & SQC bits */
> > +			if (adev->asic_type == CHIP_NAVI14)
> > +				tmp &= 0xfffc0000;
> > +			else
> > +				tmp &= 0xffff8000;
> > +			tmp |= (gcrd_targets_disable_tcp &
> gcrd_targets_disable_mask);
> > +			WREG32_SOC15(GC, 0,
> mmGCRD_SA_TARGETS_DISABLE, tmp);
> > +		}
> >   	}
> > +
> > +	gfx_v10_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> > +	mutex_unlock(&adev->grbm_idx_mutex);
> >   }
> >
> >   static void gfx_v10_0_get_tcc_info(struct amdgpu_device *adev) @@
> > -7408,7 +7411,10 @@ static int gfx_v10_0_hw_init(void *handle)
> >   	 * init golden registers and rlc resume may override some registers,
> >   	 * reconfig them here
> >   	 */
> > -	gfx_v10_0_tcp_harvest(adev);
> > +	if (adev->asic_type == CHIP_NAVI10 ||
> > +	    adev->asic_type == CHIP_NAVI14 ||
> > +	    adev->asic_type == CHIP_NAVI12)
> > +		gfx_v10_0_tcp_harvest(adev);
> >
> >   	r = gfx_v10_0_cp_resume(adev);
> >   	if (r)
> > @@ -9328,17 +9334,22 @@ static void
> > gfx_v10_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device
> *
> >
> >   static u32 gfx_v10_0_get_wgp_active_bitmap_per_sh(struct
> amdgpu_device *adev)
> >   {
> > -	u32 data, wgp_bitmask;
> > -	data = RREG32_SOC15(GC, 0, mmCC_GC_SHADER_ARRAY_CONFIG);
> > -	data |= RREG32_SOC15(GC, 0,
> mmGC_USER_SHADER_ARRAY_CONFIG);
> > +	u32 disabled_mask =
> > +		~amdgpu_gfx_create_bitmask(adev-
> >gfx.config.max_cu_per_sh >> 1);
> > +	u32 efuse_setting = 0;
> > +	u32 vbios_setting = 0;
> > +
> > +	efuse_setting = RREG32_SOC15(GC, 0,
> mmCC_GC_SHADER_ARRAY_CONFIG);
> > +	efuse_setting &=
> CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
> > +	efuse_setting >>=
> CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
> >
> > -	data &= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
> > -	data >>=
> CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
> > +	vbios_setting = RREG32_SOC15(GC, 0,
> mmGC_USER_SHADER_ARRAY_CONFIG);
> > +	vbios_setting &=
> GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
> > +	vbios_setting >>=
> GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
> >
> > -	wgp_bitmask =
> > -		amdgpu_gfx_create_bitmask(adev-
> >gfx.config.max_cu_per_sh >> 1);
> > +	disabled_mask |= efuse_setting | vbios_setting;
> >
> > -	return (~data) & wgp_bitmask;
> > +	return (~disabled_mask);
> >   }
> >
> >   static u32 gfx_v10_0_get_cu_active_bitmap_per_sh(struct
> > amdgpu_device *adev)
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
