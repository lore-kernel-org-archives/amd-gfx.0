Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3455EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 08:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C0710E173;
	Mon,  9 May 2022 08:42:45 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B6610E173
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 08:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e75u2kf07kGGgC+mzR5lZc1jHb2LsRWFyslWhig8vEzF7fzqf+CyxoyqAjFJTh2m2Cnhos0VParH4JgFJu3r5wqlvkmGdinh6+t+SBZT1TorBAdwjZXycz4/zeJ+Wz2DcfOLsfEMcqECQ3TvdpJKvLbRq7pDtazXu9UVUYbUGUd9Eb7MZxDQrW/1LbLsOrgkaFsZGHfvnASc1VCqFvEHdt1IpGUxh0ltXJ9JUWv/5wX1pA9YrwUa97QjnCDC4Dr/BNYSbj1O0J1zZ5zqhIE7NNNtp+nZFKKicwuafyQfvdiEAg9nxJAknIajUELWIAhOoiHe7QMFCkUETs6yxuRoBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEk5SRmakNRvenpXt58E4KhrTWxeoT1bk3PADe/E1zA=;
 b=IZmlISV4PukOsHpoC9Q09RwWetFzhOic52jsO0RRNGunS2S1uOpkv0h7FiDXVnGbPxoObTqb/URMk0p0lyUuczE7cIXCoraGuv3gELum89qNBoEKCNLn44R9b6mlApzDFwVTZuYblCJ0IInvmikhStZa/aEFRCASywfgc9cZ2I+kAH2rQ7TzbjFn+VAzMyvAkWvodpw6I4UTxvvFn4ROChjiEb463GD2AN2FUutx7FL7/FWml+8BjV4VgvGQyqO+9/wWY3DjLYaqnNOdHawMqjJEr3ZjKl4xoELMwRoH/VFtwGbk+liqxa0ecnYKd2SQrr8nSFUaFz9so3yKp7l4Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEk5SRmakNRvenpXt58E4KhrTWxeoT1bk3PADe/E1zA=;
 b=AwCiWgTCX9fs42n/QK43/5YTxVFpv/8aIwJWRK0O6XZzyDB8SxQxTYRGs4rNFINfZuWTJw06Cf8qWXioh3q4ZwHLZYpUKoYl4Pq/BIloWeamnFSR6WM3YdyPF2Cbpc6AnjF7zgr/4YVZYCsHycJwwWxSFjGmnA2uZc4VVs5Bn78=
Received: from MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13)
 by CH2PR12MB3878.namprd12.prod.outlook.com (2603:10b6:610:2a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 08:42:41 +0000
Received: from MW4PR12MB5668.namprd12.prod.outlook.com
 ([fe80::4911:d6fa:f15f:a139]) by MW4PR12MB5668.namprd12.prod.outlook.com
 ([fe80::4911:d6fa:f15f:a139%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 08:42:41 +0000
From: "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>
To: "Zhang, Dingchen (David)" <Dingchen.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 14/17] drm/amd/display: add shared helpers to update psr
 config fields to power module
Thread-Topic: [PATCH 14/17] drm/amd/display: add shared helpers to update psr
 config fields to power module
Thread-Index: AQHYYIvLijaU6R4eZUacfbs/RogmZq0WPz4A
Date: Mon, 9 May 2022 08:42:41 +0000
Message-ID: <MW4PR12MB5668EABC524467528F40BD8A96C69@MW4PR12MB5668.namprd12.prod.outlook.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
 <20220505142323.2566949-15-dingchen.zhang@amd.com>
In-Reply-To: <20220505142323.2566949-15-dingchen.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43a4e141-95c8-4646-33a7-08da3197e146
x-ms-traffictypediagnostic: CH2PR12MB3878:EE_
x-microsoft-antispam-prvs: <CH2PR12MB387824EF1FAF86EA248A7C5696C69@CH2PR12MB3878.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JsdH1wJSVZbhdlFBYXSAJ6PosGsaiStcwURIjykXHG+NHpMYOG7CUVw8v+6O/QEJCRNxEhkmKf9rNhA5lat0HFddEb4t6N7X/MpHDmgwsgflmKhPL2YgmxgDa4lshtFYuf/l0YPfRhjSHT4jJtDskOO3nOg8McFygQSKQTxgAQI/Xt1njS1WJ/5fo/0e5h6uecmVVmCvFIFTeBVJzYrh0vqYwOLKNhEyi0BKzmbGVlZPlKYQ3Ak3T/JT2oA+Hpq+qVKNmDwmRiKCQ5Kd/Sp1b4/qYcc4vdH60gGoouYXhCCyfxYVoEX8yHVUDAfhZQqXRSJ6dnsLxRtQ9cCSLG+KUcKuOuoBLkGhY9rRVgKNAyTG7ocHTUdOpWpniAf+SZvTJ8jiGB/rQfuXFRJiEuag1iBdOj+Qn4l8Uj4etThxV5WTV3ssy4VfTv97Gngt4dvIo3O7mHb82JN0sijsLY0B/Z0fhXRdBw1xGAS79sgyvPKYmBGgwU38f0QIuBwcHooKH0W4NCQ1B6Fop43OyRSDQERURpt5BS9bIDri93fm0V3VWQp8DkPsj4RcMU1O0Pfrr2TIJgtLeJkRh2DGVBuO1zjtKw6Lr6JuGOqwl/33M5gCvCThhAvRiHQ5TEiFwOZN6dbkInLzZ7ay9NNUmFW+M9+Ae2jwmLJlpWzekO2DvofHEmC/SFZdMBg8ZFSEK+B7I6TnlxzU12MPXDOHLQy+Uw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5668.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(86362001)(71200400001)(55236004)(8936002)(38070700005)(38100700002)(6506007)(7696005)(83380400001)(9686003)(186003)(122000001)(26005)(55016003)(15650500001)(2906002)(33656002)(5660300002)(52536014)(110136005)(316002)(54906003)(8676002)(4326008)(66556008)(76116006)(64756008)(66446008)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ofkQJNjv6dJb0XihrU2kk4a+C+EoyqXRxAU/Oe/x8y+w+6bcH/gpCasRbZ8w?=
 =?us-ascii?Q?DivaOo3z2YPuf/gbJG9xzpJFzkyrTUOawXdTUJePHINfA+JfuY9ByamvjYLx?=
 =?us-ascii?Q?4iKqQNblhctxUuleyrVuVaev43uo5TnzX2gwnxCWHbm3xeVToXGCjCJbO0IN?=
 =?us-ascii?Q?tK+B+zTCgMSj/WU6H2MI93vJYyfipEcmrlkwHSs7r9r18diSWbfAT/TnGZBn?=
 =?us-ascii?Q?H4CpcL2eoHLW4DwcD8XrUQ+twmGe862t1iICWINt3MWyO3Tbw+Cx6TUzk/Gc?=
 =?us-ascii?Q?REQ9JGaCbDc9ohFfgpxoN4i0VKHtdCSQ/hzW7hiCALIec8iFk2vuxT2Q+x+U?=
 =?us-ascii?Q?0OFvJTUxYEEi0p7MDRLcnY8KvbJgHcqmjG6CsOkLNqt1Csof+AOm28OGQjpX?=
 =?us-ascii?Q?POmP4AHPrfwaVcDAuyemxpYq2YkzrHVN0hQYCGCIw8cV0gzTudlh0Z9zV7Zm?=
 =?us-ascii?Q?JINCWqWM95PvZhj3aM5fSlsQQz52hMIxGcSM22GLjyWwvapmVQvxc1J34heh?=
 =?us-ascii?Q?N2ZuTS6H2whR31/LbtTsuTJS/idRaFun0646/wr5m4tmTy7qQgjuTxspS+Gr?=
 =?us-ascii?Q?I1hZO4U/5wdB1AgGNjEEh868CRDRJJP+MEY89CRlnxOJCx0wg5EGdT2dcNao?=
 =?us-ascii?Q?nXtnYv7b0T5MofIjWltHP8w0qHLYcVbKISIMFKebfmzRQ8G1YzhHYLG7TyAn?=
 =?us-ascii?Q?/Qh6yN7Gz/MNyM/U3VmXEXcmB+N5uCYrsxu/DNSuxDu2ImmLWTuAAbNna2P0?=
 =?us-ascii?Q?5KpvesjC2V5zNIlaN8ktsPFNXTgeaa3lnLJQxuXYY9QPGO9rnd4K3ZKgMvi5?=
 =?us-ascii?Q?AQSIIQ1eDNaj3iZFoAAyafjmTswGmJb1C5o+SuG7VpAECfEKPASF7/73LdWh?=
 =?us-ascii?Q?xHKFWTCCCL7zabF9CC/kIqOcMykqaqRtg1gnkKJt/wlMsYIYeSvvRCuyl1+A?=
 =?us-ascii?Q?kF3OzSYB0l/gAy3rqMVEGpFDpnrCkk0IZrl1VN6ebKMh/eOnwDsHYqwIcOjs?=
 =?us-ascii?Q?6LdsWKvJL1gHCXOfWvtncQec6NkoEAwKNYSsJSNhfldw72YmGzcd0Z4YDZFu?=
 =?us-ascii?Q?IWJswVr4EmqrJ96RyLDL3Ulsv1jqAFl7Q2xS5CsZv1zNIxXBZSsiMKD1M6Z+?=
 =?us-ascii?Q?a91B/Y213tGxNOzwjOIi6/8v2orBzB5THxGLvcCGF+FuDYV9VeKp9pU8Blus?=
 =?us-ascii?Q?f5CIV3poi0IivLvjta8zFS3/dM0LrtuZXqrjxwRmxKgvKbTJlmL/U19E2woF?=
 =?us-ascii?Q?kgFT3nLTf339jlG0hn775a1uLQZoySml4ez/hgxQxWEccjecziz01oslmSwd?=
 =?us-ascii?Q?Ec3WWjYwGIbT/1gyoiUDB23vpJvxR53gcZHXkPhqVrI0NfBSmKKhLZorZEcU?=
 =?us-ascii?Q?BPap0s9t1WTiwvRw7mPnikodoHKyxIeAr+HNPECWFIo5P9XB4liKhFssm1Gl?=
 =?us-ascii?Q?HR6NMgr8bAK6C5Lhe6yb+dSmzHsTdGOOn8I6RlDF6kPUYWdYW1/ze/PSmcI1?=
 =?us-ascii?Q?P0oDXZF+jfOse7TuNpsVErG/xtS//uyQsBL1I0fqjkMFB5k3ClUmMjdD8D/S?=
 =?us-ascii?Q?0NMdS1jtICm7/8QNKs0a7HKcRPlhV/ICAWeyKyCqxhRMuQCutTIsHZduiNu/?=
 =?us-ascii?Q?ipelN/sAGtpJpyQ1trNvPq48AwRG8r94yLsJmXZ/XVYh9tpDvy9HR1SQ9Kra?=
 =?us-ascii?Q?HMs/ozOcvJoiS/zBX7otb7TVZXnByxQR6ENrTbeQtQGvNg/Bsd+X++MhopxF?=
 =?us-ascii?Q?R2L8QZUHrw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5668.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a4e141-95c8-4646-33a7-08da3197e146
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 08:42:41.5487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 39EMzqW0xVabWDEKJuRn95gURpF9rOPNZkhXKLvRVWfiaFtn8ZECdG98wJeTNJXJ4aoh/IHRSRAGfVFhQ2ScFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3878
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha, 
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi


>[why]
>Currently the amdgpu DM psr configuration parameters are hardcoded before =
feeding into the DC helper to setup PSR. We would define a helper >which is=
 to calculate parts of the psr config fields to avoid hard-coding.
>
>[how]
>To make helper shareable, declare and define the helper in the module_help=
er, to set/update below fields:
>- psr remote buffer setup time
>- sdp tx line number deadline
>- line time in us
>- su_y_granularity
>- su_granularity_required
>- psr_frame_capture_indication_req
>- psr_exit_link_training_required
>
>add another helper to check given the stream context, if there is only one=
 stream and the output is eDP panel connected.
>
>Signed-off-by: David Zhang <dingchen.zhang@amd.com>
>---
> .../amd/display/modules/power/power_helpers.c | 73 +++++++++++++++++++  .=
../amd/display/modules/power/power_helpers.h |  6 ++
> 2 files changed, 79 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/d=
rivers/gpu/drm/amd/display/modules/power/power_helpers.c
>index 97928d4c3b9a..1be4fcfa578a 100644
>--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
>+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
>@@ -822,3 +822,76 @@ bool is_psr_su_specific_panel(struct dc_link *link)
>=20
> 	return false;
> }
>+
>+/**
>+ * mod_power_calc_psr_configs() - calculate/update generic psr configurat=
ion fields.
>+ * @psr_config: [output], psr configuration structure to be updated
>+ * @link: [input] dc link pointer
>+ * @stream: [input] dc stream state pointer
>+ *
>+ * calculate and update the psr configuration fields that are not DM=20
>+specific, i.e. such
>+ * fields which are based on DPCD caps or timing information. To setup=20
>+PSR in DMUB FW,
>+ * this helper is assumed to be called before the call of the DC helper d=
c_link_setup_psr().
>+ *
>+ * PSR config fields to be updated within the helper:
>+ * - psr_rfb_setup_time
>+ * - psr_sdp_transmit_line_num_deadline
>+ * - line_time_in_us
>+ * - su_y_granularity
>+ * - su_granularity_required
>+ * - psr_frame_capture_indication_req
>+ * - psr_exit_link_training_required
>+ *
>+ * PSR config fields that are DM specific and NOT updated within the help=
er:
>+ * - allow_smu_optimizations
>+ * - allow_multi_disp_optimizations
>+ */
>+void mod_power_calc_psr_configs(struct psr_config *psr_config,
>+		struct dc_link *link,
>+		const struct dc_stream_state *stream) {
>+	unsigned int num_vblank_lines =3D 0;
>+	unsigned int vblank_time_in_us =3D 0;
>+	unsigned int sdp_tx_deadline_in_us =3D 0;
>+	unsigned int line_time_in_us =3D 0;
>+	struct dpcd_caps *dpcd_caps =3D &link->dpcd_caps;
>+	const int psr_setup_time_step_in_us =3D 55;	/* refer to eDP spec DPCD 0x=
071h */
>+
>+	/* timing parameters */
>+	num_vblank_lines =3D stream->timing.v_total -
>+			 stream->timing.v_addressable -
>+			 stream->timing.v_border_top -
>+			 stream->timing.v_border_bottom;
>+
>+	vblank_time_in_us =3D (stream->timing.h_total * num_vblank_lines * 1000)=
=20
>+/ (stream->timing.pix_clk_100hz / 10);
>+
>+	line_time_in_us =3D ((stream->timing.h_total * 1000) /=20
>+(stream->timing.pix_clk_100hz / 10)) + 1;
>+
>+	/* psr configuration fields */
>+	psr_config->psr_rfb_setup_time =3D
>+		(6 - dpcd_caps->psr_info.psr_dpcd_caps.bits.PSR_SETUP_TIME) *=20

Is this " dpcd_caps->psr_info.psr_dpcd_caps.bits.PSR_SETUP_TIME" always exp=
ected to be less than '6'. What does this 6 indicate here?

>+psr_setup_time_step_in_us;
>+
>+	if (psr_config->psr_rfb_setup_time > vblank_time_in_us) {
>+		link->psr_settings.psr_frame_capture_indication_req =3D true;
>+		link->psr_settings.psr_sdp_transmit_line_num_deadline =3D num_vblank_li=
nes;
>+	} else {
>+		sdp_tx_deadline_in_us =3D vblank_time_in_us -=20
>+psr_config->psr_rfb_setup_time;
>+
>+		/* Set the last possible line SDP may be transmitted without violating =
the RFB setup time */
>+		link->psr_settings.psr_frame_capture_indication_req =3D false;
>+		link->psr_settings.psr_sdp_transmit_line_num_deadline =3D sdp_tx_deadli=
ne_in_us / line_time_in_us;
>+	}
>+
>+	psr_config->psr_sdp_transmit_line_num_deadline =3D link->psr_settings.ps=
r_sdp_transmit_line_num_deadline;
>+	psr_config->line_time_in_us =3D line_time_in_us;
>+	psr_config->su_y_granularity =3D dpcd_caps->psr_info.psr2_su_y_granulari=
ty_cap;
>+	psr_config->su_granularity_required =3D dpcd_caps->psr_info.psr_dpcd_cap=
s.bits.SU_GRANULARITY_REQUIRED;
>+	psr_config->psr_frame_capture_indication_req =3D link->psr_settings.psr_=
frame_capture_indication_req;
>+	psr_config->psr_exit_link_training_required =3D
>+	=09
>+!link->dpcd_caps.psr_info.psr_dpcd_caps.bits.LINK_TRAINING_ON_EXIT_NOT_
>+REQUIRED;
>+}
>+
>+bool mod_power_only_edp(const struct dc_state *context, const struct=20
>+dc_stream_state *stream) {
>+	return context && context->stream_count =3D=3D 1 &&=20
>+dc_is_embedded_signal(stream->signal);
>+}
>diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/d=
rivers/gpu/drm/amd/display/modules/power/power_helpers.h
>index 1a634d8c78c5..316452e9dbc9 100644
>--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
>+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
>@@ -27,6 +27,7 @@
>=20
> #include "dc/inc/hw/dmcu.h"
> #include "dc/inc/hw/abm.h"
>+#include "dc/inc/core_types.h"
>=20
> struct resource_pool;
>=20
>@@ -53,4 +54,9 @@ bool dmub_init_abm_config(struct resource_pool *res_pool=
,
> 		unsigned int inst);
>=20
> bool is_psr_su_specific_panel(struct dc_link *link);
>+void mod_power_calc_psr_configs(struct psr_config *psr_config,
>+		struct dc_link *link,
>+		const struct dc_stream_state *stream); bool mod_power_only_edp(const=20
>+struct dc_state *context,
>+		const struct dc_stream_state *stream);
> #endif /* MODULES_POWER_POWER_HELPERS_H_ */
>--
>2.25.1
>
