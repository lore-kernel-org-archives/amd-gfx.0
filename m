Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B69C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 07:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0921C10E4D2;
	Fri, 21 Jan 2022 07:34:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2461610E4D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 07:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHMFUS47Zkq6Q4XWVNDAFSMdc6yzXFyq6nDWSPD0V8bJJUhPredWmGbs4eyJIJNFM0Horj95VEEphpGk14hPFKFDfH99fcAE6/wmYJU0+pAmeH5mA/FAENSxnvIlQmluEMh6ys+I5IIhMxxFgvwHBSjOuff4SaZWZ//SOZgHtAIKdD7LpteYS/UA4iIbKTtKotZC0xyDm+KkdY4CLHAuPiKzeqpK2LrH+lbVj6mql3uZiPIhYK2xysldzcfzs3KaaOW9zyF1R7ZGn0Ql/ImtuTmEcGQPrWnsd+709PsLPlC+kl9YYduKcN9nYbTcUf5ks2lv6HUBHsEOTnU0rmcVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMRLX0sZJI/KC7PRrU5jXKfjmONMYWQ4KlrPtV0q7fo=;
 b=iicJszFDSDfwVkW9sGLLY/Wyu2c90O+7OVGs1s0hxtPRCQB5yexL2B1KXZtmAzPDTdLJn9IhHpl6zZ+9kkO32cCh2TaIdDLR43lJH8BNtORMf8LY+7/aNK501W+eRXBZsbl/yLIzDMwm2WkXld+SmA9V2Bx2rNpPQrzbfZHVWRQrrkPaMJ8iSynjQ+obuS1wmr3VXxwWGr09f5N+AkhCxW+lutLyLwqjvzmEZGOBzplO5BbDsG3bNetLOilF5jurjWZw+vjRwjg+VGGYXd4tSuzJqAPkVpS/z1xft63qexD1XZzbybzbphrYZuvaIkk4hvtVu/rTjk94YO/HBwxhrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMRLX0sZJI/KC7PRrU5jXKfjmONMYWQ4KlrPtV0q7fo=;
 b=0SCCuWh/kv3vnuLfM9DTu6lqU4LGyP5qGhyflomDvxQn9AWtFy/brysixSJHAf6PRL8GyFA3j6ZFpCkLqbs3L2fYFmyx2YduErVOKMyZATQW5j/5EoMZ7GQUSVhLaMpVrNAyJKjs/zPZiu7k5h1Q9WvLKBeXw3OaqwWzbTQYP24=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4562.namprd12.prod.outlook.com (2603:10b6:5:2aa::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Fri, 21 Jan 2022 07:34:46 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 07:34:46 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/pm: use dev_*** to print output in multiple GPUs
Thread-Topic: [PATCH] drm/amd/pm: use dev_*** to print output in multiple GPUs
Thread-Index: AQHYDnE2v8iaRpnxrkWWEhh9kl39TKxs05yAgABB54A=
Date: Fri, 21 Jan 2022 07:34:46 +0000
Message-ID: <DM5PR12MB246963C0644A3BD1758B55AEF15B9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220121024639.810-1-guchun.chen@amd.com>
 <DM6PR12MB2619100E7D280FDA837DE308E45B9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619100E7D280FDA837DE308E45B9@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-21T07:33:41Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2ced341f-1b67-41be-9af5-197824821330;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-21T07:34:44Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 029f525d-ab9c-41a3-afeb-a6cfaf4ac8ba
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51dfe699-0b65-431c-35da-08d9dcb07fda
x-ms-traffictypediagnostic: DM6PR12MB4562:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4562C3CECF413C0C8D0134CFF15B9@DM6PR12MB4562.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Ft0Ugsn5Q89h34U4q8rqY49Nd7jRX0Z8+K0hsW3NhUD/zhZYq1RiwZWzLJsqFgPAyjinAa6yFCWgCp83zgT9/8nnf5dnwXKGfI6Q1LDe/5eHIutzyqnBMObG/Albzp9xG9MNErU/iainC53o+83Ah3mFX8wT/Yqv2rMNKzRGie0eAB+Z4SorRgn4KTFR4Rp2/KMefMP3VLrLrZNSz6nz51kPv0QZhGvpcXc1rVy1Gs3CC9IxvtSYC4qiHkYktbgXka0mf446JkzsCwrYyjMku1Gu6UulxTmjsho19auH8o8+5AMVViaBvcPHBt4yiy7hdvp6ppO5sf2Lf5HTqadhFIkumEZTDFjiN6aAKkHd37mgjhWBW67FRkOerQJNRBppXP+AY3ejY8LEkWV7xZHJ0TaQ1v5vdMbhgS5674txJ1t/4FeBNriF8RPogzyulO0OdR83m3NVPiiQWVtFS2DQ6NpRT1JBHgFZh9qGpEDUguW1Ys2ohOLkw/7u/bRZUUuHubAT7cyLtyFbl2WkbqMTYDqQs+E2ndXkAyK2eHujc0SE5NArKesr2q0y6/+ulPgwM/yof84FrrWVz4GFpogcR0a40yXae2Sx5EpGoak8VL+U8Lxfo5MIrKJemDR5i2pBwJsaz37JnVYLXlCKF9fyP3+wfHf04oZ8ned/dE/GC+YlJ+pUYI7/hvHZ7GXjz9tAUYAD1RgINYyVAk2b4zn9RkwZ0jmDCaKEWxFcBi0Su8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6636002)(38070700005)(52536014)(921005)(83380400001)(122000001)(5660300002)(38100700002)(86362001)(66446008)(64756008)(66556008)(66476007)(508600001)(66946007)(76116006)(8936002)(8676002)(26005)(7696005)(9686003)(53546011)(6506007)(316002)(110136005)(71200400001)(33656002)(2906002)(55016003)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Lp4ZxP21s53x4HMZBIXRdiOd4Qc381Ci4WoBSSmss9uy0iQ2I5csHdI8J+8?=
 =?us-ascii?Q?JFUNg2l9S2R8b5w8Y2jHWqlIkcARjMrXhCYhSoN8IRP3IcJoovYhPt3cY/gO?=
 =?us-ascii?Q?pzMfzfcTWrGAk+wqBxTUdBl9GeaYJuWw7BH50az6lJp4al6IiC/5sYZf3f91?=
 =?us-ascii?Q?l/F0M7nPYZDH7WYgrWqeRJtXto9AjI5jiWDoPbHYTQ31QiRC7hfrnpeHHAPX?=
 =?us-ascii?Q?7Qdwh3JkcPwZ3OMeFKO0GkkC7LQyIuRCSkZ3BmW3MaLVwgs2yT/mEABSarrz?=
 =?us-ascii?Q?25MZu4xsxJ7U93VX4gb3FniQ1+/R0tHtMwLEvN5mdMT2zjFnki9brHqgYwc6?=
 =?us-ascii?Q?jUdFTLUDzox8G7+gDrVbHLs11tzxwpjE4K5JQnMkjjOvqqRjpNqFqAOC7XSZ?=
 =?us-ascii?Q?S7dbpY0B85CJRwDn/Un79gsO8S5prNEBpNBhpqamyz5gFBr/QXkiKNyCifsO?=
 =?us-ascii?Q?K1WeKI7yC5IR4au3/A6kgDEX9STZWpxuH9E+SkYnhUofqBP0t0ONTrY1hqSG?=
 =?us-ascii?Q?j99LOn2L5kEFbZnsaUSoWODoaS4rHbvdhPYzNpBdUQnf8YkmU1WTDYVzCIcl?=
 =?us-ascii?Q?fiobYGiH7qxYCihji3aSbJS9D4nwAfoUUyCCnCw5wa4gL5fXeLP3pI8numxv?=
 =?us-ascii?Q?tIop9JtCaVGhJIYa//iKOpX8CtY5vgVzY73gGkGw9APtHkivfPdzkypR1dT4?=
 =?us-ascii?Q?prz/wO2SdNyvDuTd9Tm6/UtPKwPZRav/hNuL5ETH0x61pnxSjI+PRSL7DZPo?=
 =?us-ascii?Q?NwFN/yWYNtNhvC8o6riFDhcbpn8PRTzQxcZgUNvY1aJCtOzt/LITCvkfJaVG?=
 =?us-ascii?Q?0tH8ZS82lg4gCG3mtSYiMeYqTItAzE4rwEcK5tS4xGs+1+ga1IU4Q0Xpo+vt?=
 =?us-ascii?Q?jMdY1dE0SuVVNU6857QaKm6rkrkPyO5YXEeRtu0v+uWPK6Zbs9qTSTJPwYkS?=
 =?us-ascii?Q?et9/sQ5GaJsH8FYXz7VTZiDpqc+UEu1kpLAUfmQEF2euyfdpT+OrAxdToD1X?=
 =?us-ascii?Q?dqc6VKloaxrF6CKj+1Ll37Kv3LVu0risK/7semw8Ahe8VdYuyr7QWXPhRz3W?=
 =?us-ascii?Q?l2QB53mbcGoI4kMMN6INISqsM+NqGd+25Z6RigtLCJMGFNgtMDXhr5YIGFo3?=
 =?us-ascii?Q?mCr8ies3D/JWFYUzAieZ0wassCfZyng51/ab/CojScCdmjf4bG4HcpmAq5vp?=
 =?us-ascii?Q?VeAztCuyfbzoEpQ5HLKCB2S6fwKwzqAFF4+EtBuNvRfLBqssSNmJA+5+3VIa?=
 =?us-ascii?Q?yjHFvYGxgN3ZHk/Y1kSFlQ8Dmzhq2bjRaWv9uCdPR6BIGjuCdz0PCZrQbOng?=
 =?us-ascii?Q?NL1v2zUf5qTnLFX3+WnkRNplbpFfiLjFt6x81ZYYzpmZ/Hard38TL/lNxmev?=
 =?us-ascii?Q?9wlvj9oEmNxl+bp0kry7X3qq9MgmsWyo5NECoW22CHhEPCt2A9VPQOxEcCxt?=
 =?us-ascii?Q?qTBu35FbPUBbZSoJbx4HyxXzEamgRgHm5ZDlGYChebOaQk8GHq5D5UgeRAOG?=
 =?us-ascii?Q?olv+bGaTM27Ca/bqQXiBEeUZImY2dfpEKw+gSSbePxpvXkKQ6/UWY0bRfUA2?=
 =?us-ascii?Q?rCTHNrVwmZZffmgjUnVyZQzOR5ozWDEeh4W1Z0xMDmMlZNK6ZhJNny+SzYiy?=
 =?us-ascii?Q?CEYDrphzekIGlgLW6DtdTUg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dfe699-0b65-431c-35da-08d9dcb07fda
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 07:34:46.5279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bob3hlZZJsymX3tg1apb7N78rBX63XS0PsGaXj+k0DCxXAFMgyrlRnJrdtjgvuixgJEvHT/Go5kM0dBClAfCyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4562
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Thank you for review, Evan. I will submit the patch with modifying the comm=
it message a bit to align the indentation. Hope it's fine to you.

Regards,
Guchun

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>=20
Sent: Friday, January 21, 2022 11:38 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deuc=
her, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Ko=
enig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Lazar, Lijo <Lijo.Lazar@am=
d.com>
Subject: RE: [PATCH] drm/amd/pm: use dev_*** to print output in multiple GP=
Us

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Friday, January 21, 2022 10:47 AM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander=20
> <Alexander.Deucher@amd.com>; Koenig, Christian=20
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Quan,=20
> Evan <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amd/pm: use dev_*** to print output in multiple=20
> GPUs
>=20
> In multiple GPU configuration, when failed to send a SMU message, it's=20
> hard to figure out which GPU has such problem.
> So it's not comfortable to user.
>=20
> [40190.142181] amdgpu: [powerplay]
>                 last message was failed ret is 65535 [40190.242420]=20
> amdgpu: [powerplay]
>                 failed to send message 201 ret is 65535 [40190.392763]=20
> amdgpu: [powerplay]
>                 last message was failed ret is 65535 [40190.492997]=20
> amdgpu: [powerplay]
>                 failed to send message 200 ret is 65535 [40190.743575]=20
> amdgpu: [powerplay]
>                 last message was failed ret is 65535 [40190.843812]=20
> amdgpu: [powerplay]
>                 failed to send message 282 ret is 65535
>=20
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c   |  4 +++-
>  .../gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c    |  4 ++--
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c | 11
> +++++++----
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c |  2 +-
>  .../gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c   |  4 ++--
>  5 files changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> index 93a1c7248e26..5ca3c422f7d4 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> @@ -208,6 +208,7 @@ static int ci_read_smc_sram_dword(struct pp_hwmgr=20
> *hwmgr, uint32_t smc_addr,
>=20
>  static int ci_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg) =20
> {
> +	struct amdgpu_device *adev =3D hwmgr->adev;
>  	int ret;
>=20
>  	cgs_write_register(hwmgr->device, mmSMC_RESP_0, 0); @@ -218,7 +219,8=20
> @@ static int ci_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
>  	ret =3D PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP);
>=20
>  	if (ret !=3D 1)
> -		pr_info("\n failed to send message %x ret is %d\n",  msg, ret);
> +		dev_info(adev->dev,
> +			"failed to send message %x ret is %d\n", msg,ret);
>=20
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> index 47b34c6ca924..88a5641465dc 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> @@ -87,7 +87,7 @@ static int smu10_send_msg_to_smc(struct pp_hwmgr=20
> *hwmgr, uint16_t msg)
>  	smu10_send_msg_to_smc_without_waiting(hwmgr, msg);
>=20
>  	if (smu10_wait_for_response(hwmgr) =3D=3D 0)
> -		printk("Failed to send Message %x.\n", msg);
> +		dev_err(adev->dev, "Failed to send Message %x.\n", msg);
>=20
>  	return 0;
>  }
> @@ -108,7 +108,7 @@ static int
> smu10_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr,
>=20
>=20
>  	if (smu10_wait_for_response(hwmgr) =3D=3D 0)
> -		printk("Failed to send Message %x.\n", msg);
> +		dev_err(adev->dev, "Failed to send Message %x.\n", msg);
>=20
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> index aae25243eb10..5a010cd38303 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> @@ -165,6 +165,7 @@ bool smu7_is_smc_ram_running(struct pp_hwmgr
> *hwmgr)
>=20
>  int smu7_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)  {
> +	struct amdgpu_device *adev =3D hwmgr->adev;
>  	int ret;
>=20
>  	PHM_WAIT_FIELD_UNEQUAL(hwmgr, SMC_RESP_0, SMC_RESP, 0); @@ -172,9=20
> +173,10 @@ int smu7_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t=20
> msg)
>  	ret =3D PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP);
>=20
>  	if (ret =3D=3D 0xFE)
> -		pr_debug("last message was not supported\n");
> +		dev_dbg(adev->dev, "last message was not supported\n");
>  	else if (ret !=3D 1)
> -		pr_info("\n last message was failed ret is %d\n", ret);
> +		dev_info(adev->dev,
> +			"\nlast message was failed ret is %d\n", ret);
>=20
>  	cgs_write_register(hwmgr->device, mmSMC_RESP_0, 0);
>  	cgs_write_register(hwmgr->device, mmSMC_MESSAGE_0, msg); @@ -184,9=20
> +186,10 @@ int smu7_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t=20
> msg)
>  	ret =3D PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP);
>=20
>  	if (ret =3D=3D 0xFE)
> -		pr_debug("message %x was not supported\n", msg);
> +		dev_dbg(adev->dev, "message %x was not supported\n",
> msg);
>  	else if (ret !=3D 1)
> -		pr_info("\n failed to send message %x ret is %d \n",  msg,
> ret);
> +		dev_dbg(adev->dev,
> +			"failed to send message %x ret is %d \n",  msg, ret);
>=20
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
> index 23e5de3c4ec1..8c9bf4940dc1 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
> @@ -126,7 +126,7 @@ int smu9_send_msg_to_smc(struct pp_hwmgr *hwmgr,=20
> uint16_t msg)
>=20
>  	ret =3D smu9_wait_for_response(hwmgr);
>  	if (ret !=3D 1)
> -		pr_err("Failed to send message: 0x%x, ret value: 0x%x\n",
> msg, ret);
> +		dev_err(adev->dev, "Failed to send message: 0x%x, ret
> value: 0x%x\n", msg, ret);
>=20
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
> index 741fbc87467f..9ad26c285ecd 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
> @@ -115,7 +115,7 @@ static int vega20_send_msg_to_smc(struct pp_hwmgr=20
> *hwmgr, uint16_t msg)
>=20
>  	ret =3D vega20_wait_for_response(hwmgr);
>  	if (ret !=3D PPSMC_Result_OK)
> -		pr_err("Failed to send message 0x%x, response 0x%x\n",
> msg, ret);
> +		dev_err(adev->dev, "Failed to send message 0x%x, response
> 0x%x\n", msg, ret);
>=20
>  	return (ret =3D=3D PPSMC_Result_OK) ? 0 : -EIO;  } @@ -143,7 +143,7 @@=
=20
> static int vega20_send_msg_to_smc_with_parameter(struct pp_hwmgr=20
> *hwmgr,
>=20
>  	ret =3D vega20_wait_for_response(hwmgr);
>  	if (ret !=3D PPSMC_Result_OK)
> -		pr_err("Failed to send message 0x%x, response 0x%x\n",
> msg, ret);
> +		dev_err(adev->dev, "Failed to send message 0x%x, response
> 0x%x\n", msg, ret);
>=20
>  	return (ret =3D=3D PPSMC_Result_OK) ? 0 : -EIO;  }
> --
> 2.17.1
