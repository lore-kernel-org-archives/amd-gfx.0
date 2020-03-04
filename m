Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561C0C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 15:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 235B5215A4
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 15:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f7iwX9kr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235B5215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA2CB89ACC;
	Wed,  4 Mar 2020 15:46:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F351E89ACC
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 15:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR8Ld2Otms/8x8CDVJYruZiPth6SJ7eaO7eTFfh+mcfhD63q2mkg8XKKvnW396izKukbQuKTmK7FuBluCVD5pdQA2Xik8xYdt5ad4IGW31ljllVD/Qem8JKuEXXmL+VydXRts4W9hKopghE194e7eSpEoEnDZyjpb7zBYCgeHcx8FQj4LSVMzacBAgtBhQii7WWszRA6VklwvDGVNrzxvbQ+O0XK+I3oUFzQvQr0/rGt3YYJHt5fPYXceACdhHpsplKLIHXdFMPvqpacuL3ESr4dpHY3i8DMofCkQ3pvngEmHcEZkpWaRnwhcrv4WbZ87TQ5Zx/Jf6tjceiveXf4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B2EIgHFz8UxyPH+WGHEjpxBDCr9Z0LbAKjqlPtZ+4Q=;
 b=aPLsJjw0zuIsKZR+E4x1p36ztKdJl7nmP+kUKJ3V/taQIP9xDdC8P4Ngfnnl4asRIStiGVJIS1lAvM7mzhkVl4if57kSXkDxIgFZVQTD9ymVg5QKpMgBjlv8+Eu8qmGsfX+KK3XsAq2FoE4bMj1MNs72qUhcDyQfP1gsQcilqmEWTWMDA39vZemVa+ek8mYbu2TaOf/o1P+z0VKXp0WaXOQCEBJ0NZk4WvfbjJ498vG4VD50ErRJJ+aoyO3jt8fyPxvyVbjgqXCiQfW98f1su9rz+4fqgzXQkQquj4PmLqr07JmbGX0bIGs2MnFyKVUCqKhhg17Ld0+hus69RDoSrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B2EIgHFz8UxyPH+WGHEjpxBDCr9Z0LbAKjqlPtZ+4Q=;
 b=f7iwX9krTvqvrdxARoAMyHtfAcVSLxNHk3pz0eHkhLzHXYKT5BbUMN7rzFCPizwIMVl1p0OBMvEGoQ86cSk7oESv6tkixCfwakfvK/i+oAdOvN4ab7S8VaUbXYKGdIw9iYPbd7Y09VM9ltCppWfKM/gYOio9BM/qMpFOQ3gy8TE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2538.namprd12.prod.outlook.com (2603:10b6:907:5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Wed, 4 Mar
 2020 15:46:09 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 15:46:07 +0000
Date: Wed, 4 Mar 2020 10:46:03 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Subject: Re: [PATCH 01/12] drm/amd/display: update soc bb for nv14
Message-ID: <20200304154603.ifglgx3vjbqir7mz@outlook.office365.com>
References: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
 <20200303232718.351364-2-Rodrigo.Siqueira@amd.com>
 <b74dbb45-4373-f7c7-b108-52974e40c113@amd.com>
In-Reply-To: <b74dbb45-4373-f7c7-b108-52974e40c113@amd.com>
X-ClientProxiedBy: YT1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::46)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (165.204.55.250) by
 YT1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Wed, 4 Mar 2020 15:46:06 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a35a310-cb59-4a63-fe99-08d7c053278c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2538:|MW2PR12MB2538:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25389B66E7F8694C3CF3211598E50@MW2PR12MB2538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(199004)(189003)(9686003)(52116002)(1076003)(6666004)(966005)(7696005)(55016002)(956004)(6862004)(5660300002)(44144004)(6506007)(21480400003)(66476007)(66556008)(16526019)(54906003)(316002)(186003)(6636002)(86362001)(4326008)(8676002)(81156014)(53546011)(66946007)(478600001)(26005)(81166006)(8936002)(2906002)(2700100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2538;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXJx2/+n1xakutussDoEJxlQ3/o7zbseEZh3fhbQL/2ydubolypi/xDRcH1fYEEBu3yLfBeA2c21ztBsKjgZeFOs3dYbewFv/nx5FwFs6POx2GMbQoAkWlWJYr6q69VqMmMK2GMs1vWOKm/i9TVaw2ffSJb8Flr/YPXzCInqV78B771ULOETnA6a4fU/zbIcfp2EI5xphZnQOLvcUyWBk3nNF9uMGAOHQBg8XnGkP686hEUpSBJairb+TzACfd3vBBfheTltEw9GarXhgbX3Omh97iTu83i8QpHo+hCFGIww/drB8CgIjhg2/YzriChQY1yM14V1uXkW9YtlR8FZcLHmitfg5bL26JnFVkXsFCmwlx+aVwj33RU6pxTVqn9nWgb2xHZirQpaR+giQfkbrmx2xdz1dGev9UFe+ZSmPocML7Sj2yc4njWDhyL0lLZTFITiLj6gtVLQL6f6rGGUBsDBJXxstsq5nmwH6n8bx5AO5ywu1OaJrsnokaSBjeZN9wi/YHDDPkEGX8pdLOuof+um4yhrCjMup4BJZAt4jowFGR2Y3yphDCsqnJjU1T1e3RLvIuS236+4OLJObnuZGD6LqkCJdgftJG11250Cp/WSwqz5nKxEy37SLLe7SqcyCcraOfKv963QpeKk1s5dwQ==
X-MS-Exchange-AntiSpam-MessageData: NG4yfM3CGlBWWqM0ELlLhvxHP4eXpNilSaROzOTn0iybK7EHmqgVQYXV3zjcfYaiUPqptANBXh+vAFtEM1nmxbLeEbjM5f7LvdxOxDpyvvVNV2Br3AXZ2ZYVyS/I8zX5U14qktbXNVD4592hwQPOuw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a35a310-cb59-4a63-fe99-08d7c053278c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 15:46:07.6723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkTqcw7yPBN6p26YyXiMD61+8uBQQWNSxLYQRFTLBzRwqiry350Uwih/SP5rDeT6EwC4dn+jiCCUqQVglgq42w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2538
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, amd-gfx@lists.freedesktop.org,
 Martin Leung <martin.leung@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: multipart/mixed; boundary="===============1887064610=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1887064610==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jxvjecq2ftzhsaks"
Content-Disposition: inline

--jxvjecq2ftzhsaks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03/04, Kazlauskas, Nicholas wrote:
> On 2020-03-03 6:27 p.m., Rodrigo Siqueira wrote:
> > From: Martin Leung <martin.leung@amd.com>
> >=20
> > [why]
> > nv14 previously inherited soc bb from generic dcn 2, did not match
> > watermark values according to memory team
> >=20
> > [how]
> > add nv14 specific soc bb: copy nv2 generic that it was
> > using from before, but changed num channels to 8
> >=20
> > Signed-off-by: Martin Leung <martin.leung@amd.com>
> > Reviewed-by: Jun Lei <Jun.Lei@amd.com>
> > Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > ---
> >   .../drm/amd/display/dc/dcn20/dcn20_resource.c | 113 +++++++++++++++++-
> >   1 file changed, 112 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > index c629a7b45f56..c8b85f62ae95 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > @@ -337,6 +337,117 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_0_soc =
=3D {
> >   	.use_urgent_burst_bw =3D 0
> >   };
> > +struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv14_soc =3D {
> > +	.clock_limits =3D {
> > +			{
> > +				.state =3D 0,
> > +				.dcfclk_mhz =3D 560.0,
> > +				.fabricclk_mhz =3D 560.0,
> > +				.dispclk_mhz =3D 513.0,
> > +				.dppclk_mhz =3D 513.0,
> > +				.phyclk_mhz =3D 540.0,
> > +				.socclk_mhz =3D 560.0,
> > +				.dscclk_mhz =3D 171.0,
> > +				.dram_speed_mts =3D 8960.0,
> > +			},
> > +			{
> > +				.state =3D 1,
> > +				.dcfclk_mhz =3D 694.0,
> > +				.fabricclk_mhz =3D 694.0,
> > +				.dispclk_mhz =3D 642.0,
> > +				.dppclk_mhz =3D 642.0,
> > +				.phyclk_mhz =3D 600.0,
> > +				.socclk_mhz =3D 694.0,
> > +				.dscclk_mhz =3D 214.0,
> > +				.dram_speed_mts =3D 11104.0,
> > +			},
> > +			{
> > +				.state =3D 2,
> > +				.dcfclk_mhz =3D 875.0,
> > +				.fabricclk_mhz =3D 875.0,
> > +				.dispclk_mhz =3D 734.0,
> > +				.dppclk_mhz =3D 734.0,
> > +				.phyclk_mhz =3D 810.0,
> > +				.socclk_mhz =3D 875.0,
> > +				.dscclk_mhz =3D 245.0,
> > +				.dram_speed_mts =3D 14000.0,
> > +			},
> > +			{
> > +				.state =3D 3,
> > +				.dcfclk_mhz =3D 1000.0,
> > +				.fabricclk_mhz =3D 1000.0,
> > +				.dispclk_mhz =3D 1100.0,
> > +				.dppclk_mhz =3D 1100.0,
> > +				.phyclk_mhz =3D 810.0,
> > +				.socclk_mhz =3D 1000.0,
> > +				.dscclk_mhz =3D 367.0,
> > +				.dram_speed_mts =3D 16000.0,
> > +			},
> > +			{
> > +				.state =3D 4,
> > +				.dcfclk_mhz =3D 1200.0,
> > +				.fabricclk_mhz =3D 1200.0,
> > +				.dispclk_mhz =3D 1284.0,
> > +				.dppclk_mhz =3D 1284.0,
> > +				.phyclk_mhz =3D 810.0,
> > +				.socclk_mhz =3D 1200.0,
> > +				.dscclk_mhz =3D 428.0,
> > +				.dram_speed_mts =3D 16000.0,
> > +			},
> > +			/*Extra state, no dispclk ramping*/
> > +			{
> > +				.state =3D 5,
> > +				.dcfclk_mhz =3D 1200.0,
> > +				.fabricclk_mhz =3D 1200.0,
> > +				.dispclk_mhz =3D 1284.0,
> > +				.dppclk_mhz =3D 1284.0,
> > +				.phyclk_mhz =3D 810.0,
> > +				.socclk_mhz =3D 1200.0,
> > +				.dscclk_mhz =3D 428.0,
> > +				.dram_speed_mts =3D 16000.0,
> > +			},
> > +		},
> > +	.num_states =3D 5,
> > +	.sr_exit_time_us =3D 8.6,
> > +	.sr_enter_plus_exit_time_us =3D 10.9,
> > +	.urgent_latency_us =3D 4.0,
> > +	.urgent_latency_pixel_data_only_us =3D 4.0,
> > +	.urgent_latency_pixel_mixed_with_vm_data_us =3D 4.0,
> > +	.urgent_latency_vm_data_only_us =3D 4.0,
> > +	.urgent_out_of_order_return_per_channel_pixel_only_bytes =3D 4096,
> > +	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes =3D 4096,
> > +	.urgent_out_of_order_return_per_channel_vm_only_bytes =3D 4096,
> > +	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only =3D 40.0,
> > +	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm =3D 40.0,
> > +	.pct_ideal_dram_sdp_bw_after_urgent_vm_only =3D 40.0,
> > +	.max_avg_sdp_bw_use_normal_percent =3D 40.0,
> > +	.max_avg_dram_bw_use_normal_percent =3D 40.0,
> > +	.writeback_latency_us =3D 12.0,
> > +	.ideal_dram_bw_after_urgent_percent =3D 40.0,
> > +	.max_request_size_bytes =3D 256,
> > +	.dram_channel_width_bytes =3D 2,
> > +	.fabric_datapath_to_dcn_data_return_bytes =3D 64,
> > +	.dcn_downspread_percent =3D 0.5,
> > +	.downspread_percent =3D 0.38,
> > +	.dram_page_open_time_ns =3D 50.0,
> > +	.dram_rw_turnaround_time_ns =3D 17.5,
> > +	.dram_return_buffer_per_channel_bytes =3D 8192,
> > +	.round_trip_ping_latency_dcfclk_cycles =3D 131,
> > +	.urgent_out_of_order_return_per_channel_bytes =3D 256,
> > +	.channel_interleave_bytes =3D 256,
> > +	.num_banks =3D 8,
> > +	.num_chans =3D 8,
> > +	.vmm_page_size_bytes =3D 4096,
> > +	.dram_clock_change_latency_us =3D 404.0,
> > +	.dummy_pstate_latency_us =3D 5.0,
> > +	.writeback_dram_clock_change_latency_us =3D 23.0,
> > +	.return_bus_width_bytes =3D 64,
> > +	.dispclk_dppclk_vco_speed_mhz =3D 3850,
> > +	.xfc_bus_transport_time_us =3D 20,
> > +	.xfc_xbuf_latency_tolerance_us =3D 4,
> > +	.use_urgent_burst_bw =3D 0
> > +};
> > +
> >   struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv12_soc =3D { 0 };
> >   #ifndef mmDP0_DP_DPHY_INTERNAL_CTRL
> > @@ -3298,7 +3409,7 @@ static struct _vcs_dpi_soc_bounding_box_st *get_a=
sic_rev_soc_bb(
> >   	uint32_t hw_internal_rev)
> >   {
> >   	if (ASICREV_IS_NAVI12_P(hw_internal_rev))
> > -		return &dcn2_0_nv12_soc;
> > +		return &dcn2_0_nv14_soc;
>=20
> Are you sure this is correct? Shouldn't be checking that the ASICREV is
> Navi14 here, not Navi12?

Nice catch! I correct it to:

+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3408,9 +3408,12 @@ void dcn20_patch_bounding_box(struct dc *dc, struct =
_vcs_dpi_soc_bounding_box_st
 static struct _vcs_dpi_soc_bounding_box_st *get_asic_rev_soc_bb(
        uint32_t hw_internal_rev)
 {
-       if (ASICREV_IS_NAVI12_P(hw_internal_rev))
+       if (ASICREV_IS_NAVI14_M(hw_internal_rev))
                return &dcn2_0_nv14_soc;
=20
+       if (ASICREV_IS_NAVI12_P(hw_internal_rev))
+               return &dcn2_0_nv12_soc;
+
        return &dcn2_0_soc;
 }

Thanks!

> Nicholas Kazlauskas
>=20
> >   	return &dcn2_0_soc;
> >   }
> >=20
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--jxvjecq2ftzhsaks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl5fzTIACgkQWJzP/com
vP/EoQ/9FJjsl10w898oyW6Oll3z/WNYA406t/Q6GcHQ62aQuQDk2rUmAlir/IOd
y77ZqDctQJ6+T+OLM/7/39KE0B6ILbt1j1sJGszlHEFyypby1lSrdlxTYwaAScab
UoPabb3CjLjJNKTh09r4XSiniCobmWllu7vtEapF9Hp2f2TMKAhoFOnNjfUOqtgN
KHkJC1vrbqUEVcdhP4txIAIKT1ZJJtDzLD6Ca+B2fZqrzOj3L+FaR1Yh07g8uHrF
g3MFctsMreGDIIDNX4E4nh1mNzKHpjLTsqGjEf+LDW8/JiGeU0qXAsMNgOY8CIgN
SbYH2/1Rux7q1YM4EnJJS9+AK6AmIgq2TZPcz2DZg/6GSp+C5pgRL5Aqx7j5xXaD
v6VZ1/AiHYFSEbYkXURJoMaK2wNrBhvbT6tj1OUbD2UCHDifQoTP9N7sBiM1Wbr+
qebDUhR1EU6buUQf2F+c1/t1yxSTJb9G8ua8wg7Mq5OKepvcCWg1+GxLWq/DTfrf
IX7fiayrJi0prXdIUk0au5mqZXNfphNmAkXIXGh8O6FRBSM9N6Tsj5XFR7Zj0y6Q
GDbIeXhsjZPxH6vZ1TjJ0jNGhttaxVEl6bJMaOu6tpdYdlIVjQy6ltiQN/8K2s7R
gRT1iWKT8E7c5pmneCPnndR+0bfm1mmlRCQuszUtArIF+QhH6GM=
=Mrk2
-----END PGP SIGNATURE-----

--jxvjecq2ftzhsaks--

--===============1887064610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1887064610==--
