Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BE7C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 14:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7F5010ECF5;
	Mon,  9 May 2022 14:09:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE7B410EC9A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 14:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIIr7cOeuj+5bYv5CfPwtbxBBmsaIdaqWmcAc6aW6sosq90blyxVHustNL3pj4l7aS3hALhBvEi4nGgAtYVFyCUccEFzrEglidPoWtLuFUaeR13WxHbP03gLi3FLkx11GkwB14oWsSaUZ5xII85cqVM2oThR/d23DSovQOj3NUVwMKP2UVwS9L9tvXpq11RC4SgIGI4WH7TadfUJ7n+ehD+lv0HNFVz76KuOm9jBSosQSOYS4JKJ6Kkxv6Z17kpN5It20WOAXKT+cQKhFkawyrxYTH+bj255PA0H37ByamJ9aQjeXBmOyH3wC/wqj3e8Fht90kVA1NFqN6dfrOXJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDTcCT25EA74sbRBNKwvbybU3uE5bwedYxlmm3PRGrQ=;
 b=G7Rgsh6selMMyNhXztAN6xqjWeHInKzaT4hdHKa9SKX1LrJ+aDw0ilC0tazM5sKDxdboDWDbLrlMqIrAFBhOB96JQ2msaNExWY8UiH6/ZU8GPi4aT5G9EoX1RQX94BkB04p5E9U3r12QF3YCp7SUq+t/KUkltpUeflE9xS3QllTGcjcSna+paP6Gd5EJceYyw1oS2ZcZT0LcQaF0N8Yjfx3AKcdZY5Xvy+icHmZ3LfKyLnDhA4bnVBGT2Bg4PZP9E6388bytTHH0XDFrgB1eVfTTagwap4o4aLf4cu7fmNL/4Agc4PXKYGdRDspDESgIYFwHjqPo32uOQCC18hyeEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDTcCT25EA74sbRBNKwvbybU3uE5bwedYxlmm3PRGrQ=;
 b=uBh6lDC633AckzVFPKW508L2dq7XPZx96w4pwNZNlewMwUBOPBfcxjn24zfZz3gZ1FpAd7KJBWEMYl1dJbIzOU1WxJK+d1GCvf5pDCTQoWL54ekJO21ELZfUkz3KFeEsxTkQ125TI3pPg0boQa64cKZ7Py6Qf6QVhSsxIWXG2nk=
Received: from BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20)
 by BN6PR12MB1268.namprd12.prod.outlook.com (2603:10b6:404:1a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 14:09:51 +0000
Received: from BN9PR12MB5145.namprd12.prod.outlook.com
 ([fe80::2498:9bac:cf07:b7ec]) by BN9PR12MB5145.namprd12.prod.outlook.com
 ([fe80::2498:9bac:cf07:b7ec%4]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 14:09:51 +0000
From: "Zhang, Dingchen (David)" <Dingchen.Zhang@amd.com>
To: "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 14/17] drm/amd/display: add shared helpers to update psr
 config fields to power module
Thread-Topic: [PATCH 14/17] drm/amd/display: add shared helpers to update psr
 config fields to power module
Thread-Index: AQHYYIvLslGtHXNtC0eBdbTLQxPtKa0WQGWAgABZe4c=
Date: Mon, 9 May 2022 14:09:51 +0000
Message-ID: <BN9PR12MB5145128060B999D3AAD82BC18DC69@BN9PR12MB5145.namprd12.prod.outlook.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
 <20220505142323.2566949-15-dingchen.zhang@amd.com>
 <MW4PR12MB5668EABC524467528F40BD8A96C69@MW4PR12MB5668.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB5668EABC524467528F40BD8A96C69@MW4PR12MB5668.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-09T14:09:49.967Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 247e0a71-9c3b-437f-5d4f-08da31c5959c
x-ms-traffictypediagnostic: BN6PR12MB1268:EE_
x-microsoft-antispam-prvs: <BN6PR12MB12686A2CE2D02B93D84A88EB8DC69@BN6PR12MB1268.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HKv7zdp+3XtDE/2MIoF3N6RY2xi81TzysNJNbet6F70uexsEZLV4rOzHIAxbOTVyn0APKeqL+8oZglYoUspujxSpMRuNnTaWDAflrfS04oQ24x2+5q5PP6hUvCcI56fbtbycOySHai2wu23PKbi+xavFi1RmQD9831f4MhhifyeuDk1cWweXhJ/qefT780EIPGTmFoxDjJv7nnQBP9M8TFgjLCTk9A4bjSQ1kMr4uoSe2cVdjO9h2oj4VI5c5zjELfTJXWNpkhirm1X0CSgW3JG0I6pKsZEqDBFEcuVAm/oRIBx/1ZDf/iJ7q0OEiaT9quk8DnF+wngF83txe0LwWh6Imzro9v9Zb3cB2BAr5KjdS08qpCR0cyEuhztNnW6PncMf8XduS9xUEH1t7Zwdy9T3z0Qa2s5K4SpWLeSLjyqf6rTeCs6QrePhvvXI9s4ZpmlrK02edZVkL7PrFmVbI2DBiMPE2SNXJEQ8KcDAZG2REtUrkpILCM2QH86MqbaNMoI9jCHLMiLIecp3iHnS1FWMm+5Wy96SOIH4BoQmHwvqf50pgoVW90+DHIh6YqcJ4BIT27a9TO88h6bn5x38PoYFRFYwTBSQh1CVHGHX9h2TbjRjlb3dvQUf6ssCKLI7S9uftivf24C2MdEdhf2p3BFkS+b5JYhr/28v00c8kJ0Yvg0fJjcgOqQ1MNF6QCMNwqyVx3HG1pCP7xiQYTWAag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5145.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(91956017)(66446008)(4326008)(66476007)(76116006)(66946007)(66556008)(64756008)(8676002)(33656002)(5660300002)(2906002)(8936002)(52536014)(38070700005)(15650500001)(38100700002)(55016003)(122000001)(26005)(186003)(6506007)(7696005)(53546011)(83380400001)(9686003)(316002)(54906003)(508600001)(71200400001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A55TM8uDXYyEKMvcPDzlAtmhl2J8cbye+mi4apJZ1RSJVsnqq6RPHYMA/i?=
 =?iso-8859-1?Q?XLUeXcjdqbiI4VUkbklDeF/PlxrdO6A8wDTwECKFHLcDdPTEled0AFpnF9?=
 =?iso-8859-1?Q?S50HLybhJwJJJlQbkmu/ub/OQyb+Oc6m+f8Fp8xIsZCwUasLTeDpnhPDAK?=
 =?iso-8859-1?Q?xD3II00d1VcbtHGXChlwC0OI4OrdtY1AjVISYsuT3k+Xk+WpKzO+IK7j9G?=
 =?iso-8859-1?Q?uPdLwRVcm7F4XXWNhUbqm/nzHOh7x8VOvRjDWTWa8oDgjoCdKngv6PK2ur?=
 =?iso-8859-1?Q?pWEGCwSD0MU/arlyQNkL+dPRZKKhYjFROTyTzlF5NtjY+CfWtcRU2edvMr?=
 =?iso-8859-1?Q?KCvBTUBsn1cPor0P93BtdVi3Bh+nn9ACm22ibjJVN2mEkQHi11ASI9q5QQ?=
 =?iso-8859-1?Q?d3zjAzbfG2euVMpmSml3PrMXiBU8wr0Ox+G1QRQciS3UxNeI3XClUWitHH?=
 =?iso-8859-1?Q?vd96t/OQepyRmBsRunYAvQOKywbISEOBpwncdaW5pdyNg2k1gsRRod/3Fh?=
 =?iso-8859-1?Q?HVnYhEtaiGaXPAuFa6fomRHBgcY05K1NAUgZJTmI6DfO7Abkm/y3Ob1MAJ?=
 =?iso-8859-1?Q?ywSiE8P/7X+iHgUP9STNVdDVMBjHWnNkyBoxgHxd0oH4My5wbI5WC6c4r/?=
 =?iso-8859-1?Q?BbqyNKE/ufKmE/mMow6cF1t1OewKkJqoQK0AyhAxYNfhs9ZIqsKXqR/F+m?=
 =?iso-8859-1?Q?s4LxGF+knHfay/XsxNtLf8sCVUVcs7ZoPFIL8Ow44Pt3QE8pqiLsRcsZVx?=
 =?iso-8859-1?Q?VLWXh3mYJsU+1H09S5GmS7ps7qBKv4E3M9nFSS4xi7x1AWg2P4rEiOTNPj?=
 =?iso-8859-1?Q?JzUFJ30uAwn9CyLLVcKICf6kQbF/tuyK0vFK/QO+9PLKCDFVxWGi4lVIFk?=
 =?iso-8859-1?Q?UNBjjR4Eb+nfB8jgr9hbYApiOK4rE7CFxWv6IYObGSTvFzAxQRQ85w+ae3?=
 =?iso-8859-1?Q?ND8gK8IuBMz9988d3/vk3ZWEoy4OZScVrHNa0bgQue0lPkJjyI71BnfbgF?=
 =?iso-8859-1?Q?mtt2iOwtz806Vg3joABhrNO5IEiiKzg2CqMnkrudTtTWlI288Wpv0mVNEG?=
 =?iso-8859-1?Q?hlkCR1kyfFu8Tsk1kbKt+LqS+2iSEt8M81O+Sbb6hiaihBhslPs4st8bXD?=
 =?iso-8859-1?Q?YH32Xs6kWfBWvlyMkbZdoL9wwFVU47gI3p6lDvFASbk+LfwjYBoqrRU9CB?=
 =?iso-8859-1?Q?fSmaTJoC0x4Y9KBetWiw/pWbXEffkaUY/+Lx5ZT9rxgfv1+fO3rk8mmoE6?=
 =?iso-8859-1?Q?LAUgrytpqH4RAPp4HmAqjRSv8WGqt4Wz86NDUnnGU590k4oMS8BWQxDnIx?=
 =?iso-8859-1?Q?dgyTzuKDhpZG2ZPYD5T9PYJpuPtP5ED1mmN5YcvC/6TDh6KEyMLcl29yMb?=
 =?iso-8859-1?Q?CRwTbiiIq4mqpsOycBn/EEMQN1lBomvIFVufsrOEfG2a11e9ghBgwBoiTK?=
 =?iso-8859-1?Q?mK6w5c3Pafk1VJyd48H9oZR59Cg/YixZzuliJKgOmJZLOP9CV764V3517O?=
 =?iso-8859-1?Q?GFvG9fRikfFq4+znfDzm/WerJXNHOH3lKASkYXbTL432H/u5R3l1OuHN6i?=
 =?iso-8859-1?Q?UMAMIT0t/athyF3T4M/y51cWEHUvk4ZIHRinWooCN2VfctWYUXQO01EenH?=
 =?iso-8859-1?Q?bX63+YZ5j30qmxwwu0d0lvFPkxOwsvXx5+7zqKk1m89Io0Rq8dQcx5WTcf?=
 =?iso-8859-1?Q?QmiiS6Df2f4Sh4gc0rXFV+VXrSb47A2KdCFQBMT698YtoiV2QtCGeJSZLA?=
 =?iso-8859-1?Q?nC0oL/5ycjPd5TRFp6IhI7ctzJq4gWSIFO4n35URXW27jK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5145.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247e0a71-9c3b-437f-5d4f-08da31c5959c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 14:09:51.4248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zyopOc8gyNfAIc2AlMzhjkx7NLSs7XYT8htEPgF4XaFKKvpacwSIFwnEtN4OYX+W4iwWXqGiqeNCHWmsObTq9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1268
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

[AMD Official Use Only - General]

Hi Chandan,

Replied in-mail.

Thanks
DZ


From: VURDIGERENATARAJ, CHANDAN <CHANDAN.VURDIGERENATARAJ@amd.com>
Sent: Monday, May 9, 2022 4:42 AM
To: Zhang, Dingchen (David) <Dingchen.Zhang@amd.com>; amd-gfx@lists.freedes=
ktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (=
Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.c=
om>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Zu=
o, Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>;=
 Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.=
com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle=
.Kotarac@amd.com>
Subject: RE: [PATCH 14/17] drm/amd/display: add shared helpers to update ps=
r config fields to power module

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
>
>        return false;
> }
>+
>+/**
>+ * mod_power_calc_psr_configs() - calculate/update generic psr configurat=
ion fields.
>+ * @psr_config: [output], psr configuration structure to be updated
>+ * @link: [input] dc link pointer
>+ * @stream: [input] dc stream state pointer
>+ *
>+ * calculate and update the psr configuration fields that are not DM
>+specific, i.e. such
>+ * fields which are based on DPCD caps or timing information. To setup
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
>+              struct dc_link *link,
>+              const struct dc_stream_state *stream) {
>+      unsigned int num_vblank_lines =3D 0;
>+      unsigned int vblank_time_in_us =3D 0;
>+      unsigned int sdp_tx_deadline_in_us =3D 0;
>+      unsigned int line_time_in_us =3D 0;
>+      struct dpcd_caps *dpcd_caps =3D &link->dpcd_caps;
>+      const int psr_setup_time_step_in_us =3D 55;       /* refer to eDP s=
pec DPCD 0x071h */
>+
>+      /* timing parameters */
>+      num_vblank_lines =3D stream->timing.v_total -
>+                       stream->timing.v_addressable -
>+                       stream->timing.v_border_top -
>+                       stream->timing.v_border_bottom;
>+
>+      vblank_time_in_us =3D (stream->timing.h_total * num_vblank_lines * =
1000)
>+/ (stream->timing.pix_clk_100hz / 10);
>+
>+      line_time_in_us =3D ((stream->timing.h_total * 1000) /
>+(stream->timing.pix_clk_100hz / 10)) + 1;
>+
>+      /* psr configuration fields */
>+      psr_config->psr_rfb_setup_time =3D
>+              (6 - dpcd_caps->psr_info.psr_dpcd_caps.bits.PSR_SETUP_TIME)=
 *

Is this " dpcd_caps->psr_info.psr_dpcd_caps.bits.PSR_SETUP_TIME" always exp=
ected to be less than '6'. What does this 6 indicate here?

***
This is as per the eDP 1.5 spec, DPCD reg at 0x00071h, i.e. the PSR Cap reg=
. (page 377 of 459)
the PSR_SETUP_TIME is represented by 3 bits and interpreted as
- 000b <--> 330 (us)
- 001b <--> 275 (us)
- 010b <--> 220 (us)
- 011b <--> 165 (us)
- 100b <--> 110 (us)
- 101b <--> 055 (us)
- 110b <--> 000 (us)

Since the base 0us interpreted by '6', so the actual psr setup time will be=
 "(6 - psr_setup_time_in_binary) * 55 (us)". That's where the '6' coming fr=
om.
***

>+psr_setup_time_step_in_us;
>+
>+      if (psr_config->psr_rfb_setup_time > vblank_time_in_us) {
>+              link->psr_settings.psr_frame_capture_indication_req =3D tru=
e;
>+              link->psr_settings.psr_sdp_transmit_line_num_deadline =3D n=
um_vblank_lines;
>+      } else {
>+              sdp_tx_deadline_in_us =3D vblank_time_in_us -
>+psr_config->psr_rfb_setup_time;
>+
>+              /* Set the last possible line SDP may be transmitted withou=
t violating the RFB setup time */
>+              link->psr_settings.psr_frame_capture_indication_req =3D fal=
se;
>+              link->psr_settings.psr_sdp_transmit_line_num_deadline =3D s=
dp_tx_deadline_in_us / line_time_in_us;
>+      }
>+
>+      psr_config->psr_sdp_transmit_line_num_deadline =3D link->psr_settin=
gs.psr_sdp_transmit_line_num_deadline;
>+      psr_config->line_time_in_us =3D line_time_in_us;
>+      psr_config->su_y_granularity =3D dpcd_caps->psr_info.psr2_su_y_gran=
ularity_cap;
>+      psr_config->su_granularity_required =3D dpcd_caps->psr_info.psr_dpc=
d_caps.bits.SU_GRANULARITY_REQUIRED;
>+      psr_config->psr_frame_capture_indication_req =3D link->psr_settings=
.psr_frame_capture_indication_req;
>+      psr_config->psr_exit_link_training_required =3D
>+
>+!link->dpcd_caps.psr_info.psr_dpcd_caps.bits.LINK_TRAINING_ON_EXIT_NOT_
>+REQUIRED;
>+}
>+
>+bool mod_power_only_edp(const struct dc_state *context, const struct
>+dc_stream_state *stream) {
>+      return context && context->stream_count =3D=3D 1 &&
>+dc_is_embedded_signal(stream->signal);
>+}
>diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/d=
rivers/gpu/drm/amd/display/modules/power/power_helpers.h
>index 1a634d8c78c5..316452e9dbc9 100644
>--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
>+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
>@@ -27,6 +27,7 @@
>
> #include "dc/inc/hw/dmcu.h"
> #include "dc/inc/hw/abm.h"
>+#include "dc/inc/core_types.h"
>
> struct resource_pool;
>
>@@ -53,4 +54,9 @@ bool dmub_init_abm_config(struct resource_pool *res_pool=
,
>                unsigned int inst);
>
> bool is_psr_su_specific_panel(struct dc_link *link);
>+void mod_power_calc_psr_configs(struct psr_config *psr_config,
>+              struct dc_link *link,
>+              const struct dc_stream_state *stream); bool mod_power_only_=
edp(const
>+struct dc_state *context,
>+              const struct dc_stream_state *stream);
> #endif /* MODULES_POWER_POWER_HELPERS_H_ */
>--
>2.25.1
>
