Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE0BC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Nov 2022 08:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D1A10E26B;
	Mon,  7 Nov 2022 08:52:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBEB810E270
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Nov 2022 08:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KI7kxgoKaT6cpwo7G9qR9Xx+4jtQByP2iaZ2parWPJkI7kWCCrPj8ZD8yOVr81rjPjeoi5BQ/whMJsl5vJN9IZDpi4pLyXesYQ/JMs0aXr7kOPq85t6lV27CLS72ZKDhU3CVFmHAPA/uWQkpBB1b1TWdpceRwPoTISoKyGjGsKbDrvYmAGzMBfJO7HWjcQnRpva417o0fhXXet8OOOkMBhBhzMUimdTOLYt8TDV05/fjwsNRRM/xuzKCLhf4jCKo5YcnyRFSMSwfogdG2EV+rns7BWRAkYv2Rx0T7iE3zjTBDI8mj8LFGGaltlw6//MYrcoynDiZFdwt6grUY2GCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kj01FUGfUmVJCrq/iKl2g1PMED/ctJtHvfEGYHduR+c=;
 b=TPK1688vBISjMAeYp0vJLDylSvdAxFKwrte5Qnw98ktIgTqcUNtTpCx062pM2qDaxxYm4Y4LdFrzUmX2o/bzhfFTWx9oUqKmxXkdV82TeBKchWb4ElQbwX/7YX+Ltd+FM++QoY7p0qOl9Xdt37iq26X5XK4yyl7hl8aoujqFb+0VaMZlYXj42HP1UHZEyCALud5pg573OmcZ2NDV6R2S+rAl0+v6PY5BPt52hYVrrbX28zbcDyQMFQXS3Fjd0ZhgibYNzpT+6zF49i9TCjyewEyuOuOuz/gdUIThU3DL4HvWOXiy/ptgYgSRDBXoOoywx7pXEIRegq5Ft7RZ1zTMYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kj01FUGfUmVJCrq/iKl2g1PMED/ctJtHvfEGYHduR+c=;
 b=PD5JPzkbgT0+DuTdjd6gkGaJbfkPnIELTAMW/9wUW/Lyk1rCq20rCaV+uAHIDpFxEEF8Weucssic6qK/7ooY4g0Ba+7s4ZYnBrp7URTWxKti1PPGqnlr4KMA/frTHxnHRdVxM45vGQfAoke0W0GpQACIjrw914DWnutmDbSm8ts=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Mon, 7 Nov 2022 08:52:25 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a%3]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 08:52:25 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Jain, Harsh" <Harsh.Jain@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: complete gfxoff allow signal during
 suspend without delay
Thread-Topic: [PATCH v3] drm/amdgpu: complete gfxoff allow signal during
 suspend without delay
Thread-Index: AQHY8oUOlTSVBBrRw0GJT/oDjxl+sa4zJ1kw
Date: Mon, 7 Nov 2022 08:52:24 +0000
Message-ID: <DM6PR12MB2619886E8C0C4AD4CBC6C69EE43C9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20221107084310.3316535-1-harsh.jain@amd.com>
In-Reply-To: <20221107084310.3316535-1-harsh.jain@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-07T08:52:21Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f25a3dc8-4475-4d88-bd3e-cdaa8c132f2c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DS0PR12MB6558:EE_
x-ms-office365-filtering-correlation-id: d84143d4-e91a-41e3-9013-08dac09d643a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2qkCsOusbMFtImz5u7VdDkgoq18wObifkbu7uvUPrgZ8zhhBZrZU2TZNQQIZbDBFmcIB36O08/53OhEyx+SVbf5xRCLaNb2vB/8kNPT5m3eubUBsvo0BrcqJu236047C/iuQocNRsQM2bAZw7cakOsx9cOgB8xHuHnt+sop4uduqfWPsb1ZDULY2wyS+6B83TnyEKarRbq75vY8qGowuT4Sw59vX4UWg20xKIuYVU2qwGUc0xrwBxWyJdrXBBZaWAU6ik2rn6xxmoQyxg6SGLsMMDHG1ocdaQnm1ceD7h2nUGDjZt6Ji+OKinyWKldNPnhdvsDhBMLIVjCpcj7d5GAllbGPQi1hv1N848YyPEyxXRkEFacPRJ8ALSLjCmjLRtEjTvM+tOSqhUvwC3B0Ol+TjDpriAttd67TpJy5H/IM2fZe/lU/7wsKCQhMbgbAlE3X54rQgQ+Ybgt6PfHxrXlsMXXBYrJPrPVEPFQ1xLc5g5WkhQF1AnvkqG7p024YkKhJizJMyWAddCAUpR9qpnxkN3Vti/2V++WtJZnhhyd1fz1YEkaIvGFkhGCpJWJKc0xYjJjZ0pYxzv9E8HMs2Hd7kk/dVarANpMJy+AWEIu8iSbHHcK6SyHzRzhPdvBSGLrkTcvYTGsZs6LDHHB3lJ39rnw+NasAlHKFtxYIUWt+LeEG3Za6q7HI30gEfqtXglK0hAUE4mEaN3C6ibSEL3BJqN1nArarXmDrqw4KVNM4ubwfzLnUdzaHn27xaxwAw/zcMBycywQAuqw8txeDoOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199015)(2906002)(4326008)(64756008)(66446008)(8676002)(71200400001)(66556008)(33656002)(66946007)(66476007)(76116006)(83380400001)(38070700005)(52536014)(15650500001)(6506007)(5660300002)(8936002)(41300700001)(316002)(6636002)(55016003)(110136005)(478600001)(26005)(53546011)(9686003)(7696005)(186003)(122000001)(38100700002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IBe6MoOIhJF/b64znSm8BtMLzTjYKGskXCcZ8ZnUArTPq50lFh+XUcfuuyMQ?=
 =?us-ascii?Q?opyAIj9PK6QH/9CAEend9Hmr+wdPL9pMNRpP0hDnUfcoGV12XLIdeflQ2kLE?=
 =?us-ascii?Q?8f9xThnM4DheZPXyX4FpulplHNXPMjfyIVhx5HU7gLD1XXRBvd02LBAjQyS5?=
 =?us-ascii?Q?4G8c9I2kx58QJMSX9wMdi2YGUb8SlfHf7tS0r9oaSf4lirxLRE2aVzOdAhW4?=
 =?us-ascii?Q?QHrBwU3y17SDBH2rfc4oFhPUeggeRu01r40ilOYzvJEtOzpTt/bOEEmD/lKk?=
 =?us-ascii?Q?I2p759G7CiGT8LTyID1TCaBpJcQulvTMbLcCQTkOl8ou60QHTZBbb/C89f9P?=
 =?us-ascii?Q?1x00qj5kNJj0Y6ayYwNHXVRoD+YW2CdGTSV3LFjF6fGU1Z78Mhs5SID4pv2U?=
 =?us-ascii?Q?XljcJ50XW1gU9RKgjl43WpUJBQC6Lu9P2n13Thtfn+jotuFdXyaQc5shGn4b?=
 =?us-ascii?Q?5oZvilSN3bkzgn5Laqg5CTbM4S8w01gXGiuGeVgu9aFoLTn4ZH9XGPCQTRjU?=
 =?us-ascii?Q?HsIWKTz4/PTLopBE6M9gYmSKy68zNuLehpSNca378OuLHHbjqJTnBsqDSjSw?=
 =?us-ascii?Q?NAOY0KfOwQ755qmj4pvNkEfTOgHXOAw2b141XaEvY/7L63I/tJYcmkZ+O3td?=
 =?us-ascii?Q?y7UAsmDfcyggA2Ke1lJ1vSYmAvfXnKo40G1l92X31ETs747K2axQ6S5Yx1UI?=
 =?us-ascii?Q?c4ZtM2JNfjdMJjKCQmshi5+D1FOW2vxc2wn35VKZ/EQQCnJX5VTFAW0ND7/A?=
 =?us-ascii?Q?3urDi4pNPiWBIsQWqAWEe/zULWLyIfMy4qxWITeWbIhJLMyyh8GFTqpi+0Fi?=
 =?us-ascii?Q?MJwLKU1eG8Uw7K5yHcLyVarmgvLexT59JRTK6z/qOeBlLWrfVTL73q0bgMZ6?=
 =?us-ascii?Q?qlpW5jG48sHu6nIZefFKxdgQUL0xKEhCcum2ZDN6mkNwSAQQjc5PVUqqSN/R?=
 =?us-ascii?Q?HWEKMcFhhV8g0MGAqUehKUIYaDwNBcUSfYQjKpCdQLtcS/kGeUm16oD5pul2?=
 =?us-ascii?Q?+JxjGUvWXGqZEYRQ5mbvU0WF+fmp6Ud8JMMLMqnMuKJbo3tybvn4QmGClyJD?=
 =?us-ascii?Q?uGUiRBB20WPFOx9iQJo7g0adgM2fM9+4GXU0I25cuL7nwOHQE2EA8ti0GosG?=
 =?us-ascii?Q?hCp3faX7sGM4k9ncAxNuD5eb10lbLuL4Rs9n1ZvfEpizb/hvl4pHGK7guC8R?=
 =?us-ascii?Q?XaZfv4VVe0AQ5hn94DtEgQJ/6yqzoyqKxWJ2m0BT4f95gYzz9aAlpSngoRYF?=
 =?us-ascii?Q?1K3BXQ4zk0+LNvAP9urG8d8mfIgnq9Cjn3MAE2mo3H8/uVjRqtxnpxFUtakg?=
 =?us-ascii?Q?GJA+UMRuRx4X6SgxJKSUOlqiruYfCcYK0nt+ylM4iiigMG1DKwzYeLtuV8du?=
 =?us-ascii?Q?N15wP6unzrEc0VHG55oMYmKEJdMFgx8RpS9wmkAh30Jfty9wYZh2GIkjkDqU?=
 =?us-ascii?Q?cIayk4zciGjhsRbo3Q2nJpzHqJBiq2rmRoeGypK/3SjXT1xZdaT03CPHqghx?=
 =?us-ascii?Q?vCGyuDUMWUoNAum5L3TjfdOqmzw/ctgo2CBP9C4jdz56++BqCYm8RX4q/+BL?=
 =?us-ascii?Q?ttMwe4krnfBbl2JK7kY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84143d4-e91a-41e3-9013-08dac09d643a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 08:52:24.9992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzXKkm1pOFXQT9PihXGuwCP0mgYwcHa4SzE6OEdB7KVrRZy2tBI5ienTHxJo7y5o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Jain, Harsh <Harsh.Jain@amd.com>
> Sent: Monday, November 7, 2022 4:43 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Jain, Harsh <Harsh.Jain@amd.com>
> Subject: [PATCH v3] drm/amdgpu: complete gfxoff allow signal during
> suspend without delay
>=20
> change guarantees that gfxoff is allowed before moving further in
> s2idle sequence to add more reliablity about gfxoff in amdgpu IP's
> suspend flow
>=20
> Signed-off-by: Harsh Jain <harsh.jain@amd.com>
>=20
> ---
>=20
> v2: replaced flush_work with direct call to
> amdgpu_dpm_set_powergating_by_smu
> and edited title
> v3: added braces for readbility
> ---
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 9546adc8a76f..23692e5d4d13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -583,10 +583,14 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device
> *adev, bool enable)
>  		if (adev->gfx.gfx_off_req_count =3D=3D 0 &&
>  		    !adev->gfx.gfx_off_state) {
>  			/* If going to s2idle, no need to wait */
> -			if (adev->in_s0ix)
> -				delay =3D GFX_OFF_NO_DELAY;
> -			schedule_delayed_work(&adev-
> >gfx.gfx_off_delay_work,
> +			if (adev->in_s0ix) {
> +				if
> (!amdgpu_dpm_set_powergating_by_smu(adev,
> +						AMD_IP_BLOCK_TYPE_GFX,
> true))
> +					adev->gfx.gfx_off_state =3D true;
> +			} else {
> +				schedule_delayed_work(&adev-
> >gfx.gfx_off_delay_work,
>  					      delay);
> +			}
>  		}
>  	} else {
>  		if (adev->gfx.gfx_off_req_count =3D=3D 0) {
> --
> 2.25.1
