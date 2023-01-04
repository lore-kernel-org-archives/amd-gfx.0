Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA04BC3DA7D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 03:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13B0110E42A;
	Wed,  4 Jan 2023 03:15:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCC1F10E42A
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 03:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4fluMEOScDma/ITnTsqE5gCq3d4Wfs9d1EHj8dPFYo/pf5Nu+Zxy33HaI0loJKZdB4/P4oLSSdKkq3brr2ardtYKmlnPxuwJ+IfEx5dMfB0VcARIMNOchx6+uKhxTdBD+QrevqhbmkqfVkBrZn0XQS8gmlbif5FvJqEBbI1afqZIKp2hNVeLlOGuu4Y4V43W0+da5wkq7UYRYS84N5mEbmZDjTUi6bqB4K2e8PgolC+JC7lmMh8xA+BWquf77/rpuSWECgdktdFQxIweP1sGnaxyjrweiPDhPw+ZR7ITIwm/jRDXvbxGuma8FYKX8gRAxRsoOseLKveTaLMPwhqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=my7bmRXHYQkj/Lt0/8VitsxEybyUfa9+tmprGnVvOl0=;
 b=OyiqWv4DOvljkSKDh3O82YgZFmWs5YLYSzla5XvzzDhkKAnQL5ZnIZFqi3AvzEP7zRJxZNihlnmONrCwlPxSgqKfViNb0H3m0ij7DUryLpf6ZqGLjeTEUjAhx1KBTkw7j6/9zblkRuI64jCmicBs/XYxF6k82fytdJiCyhgpIxauLjCUsKj2SI5Z7xqdW/0i+Cx84BWs/9WLFqUrVI/deJTSAXGZElYygMOt/qNFjdZ1nYKwld5wJlDipQESdDy2XyNE6FKZ8r1L6IaCvOH2QhL4UnWAyQKl1++mD4EV7zwHAZWL+1w4+wgazjvJfHaORQRecYzcldGso6H+I+rYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=my7bmRXHYQkj/Lt0/8VitsxEybyUfa9+tmprGnVvOl0=;
 b=J9ID8Gion9ETanjTVT75pT7WkKc1Czt8xvhmEM3FxAdP1CDycHk6B0Wu0BJJNtdzIG5QcR3Gpq7kQv7CkWs/BGIjnic1LLXOPR+vvJlgAck52E5U9NW9u1seyxUt3BnVPffdZbWTtrOlOP8WlgI5mXfdLdUg9Q7z6rQ1xbE8Evo=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 03:15:31 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::642e:a0b1:481:156b]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::642e:a0b1:481:156b%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 03:15:31 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: allow query error counters for specific IP
 block
Thread-Topic: [PATCH] drm/amdgpu: allow query error counters for specific IP
 block
Thread-Index: AQHZH5A7qEnW/aToC02lqHv/CDvxH66Nlm5A
Date: Wed, 4 Jan 2023 03:15:31 +0000
Message-ID: <DM5PR12MB1770F2ECDA3DB87F5FCEBEDFB0F59@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230103162447.30017-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230103162447.30017-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-04T03:15:21Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9da5cd09-04a5-4776-8d0e-c2e3e244fde0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-04T03:15:28Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 13727340-c113-40fc-b2f3-280d86afde3e
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|SN7PR12MB6932:EE_
x-ms-office365-filtering-correlation-id: ddf27f6a-26b4-4c34-f65d-08daee01f01a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bO47YEz1Lm+zfhAGu0ncpUl1YQEyJq3Qp1SOV14ZPiDlI2RCHAHGTNFt1cdLnnjyWlm+kMVwxWn4nhkzaChShs065GwdbiR/Ft3CxJLMnKu/WFWfkknlvEennOAxjcwVmijRQ1QPGKJ9jVrmMQCtw8suCKpr9P/syZh6OrJbiGSkH/zFavy0rU8FR5q4G/tf7XtnFX72ZH11GQl7j28bbHpnbKObqfGxvz5N43vo59IUe8TnA8gRlRN02fo9/Tp1+nGkwxOmN5ZUFpHSV4J/qQM+3SH3IzisSYsH84wNpzQDN/pULZ1Nv48d+NkPlbJap1FN3oApQcGyDeg6AMjdT5KQJ5ylctOZ1u6Y8JabP891JlAEz/kU5i4Rn391AYRlxnfVFT/eLeyAeQwmT8RlU/XxwM6pA89pBPjNr5xXoBgGbOeqg6DdyDqeolZO3PTuWnnOWcp2bEfQYrTNX/h78Xq9iH5cilWr3aJa5jTy9xqBeIjBnY8I1s7thEB2tFFTHZUX6mwtC5OJ1YluMDTPNgmpRkz/m6cLv2umPMegz5sc/k0ZfRSc7+W2mCL0h/nVaVN7azAKT29fo5Rf5qTTiRyLMXHst+duCn4Ts/q1zYKzrkrAsKQF6Z0q8C83tGMfQ92Uqyc5DQoVDXauC3zPXnzryfEdfmcvksRO1frH2vt5mC9G3CHpEu2oJnNJLL3fPg8zzLv7iiz4lDmWS3AYpg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(38070700005)(122000001)(55016003)(38100700002)(33656002)(86362001)(6636002)(7696005)(6506007)(53546011)(76116006)(66946007)(66476007)(66556008)(478600001)(9686003)(71200400001)(186003)(110136005)(66446008)(64756008)(2906002)(316002)(52536014)(8936002)(8676002)(83380400001)(41300700001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M2NLTp0j7ns2KHko4oZLdQIPGjmT+fhe7golZ4l27zG69Q3Isy//FJXQR/JD?=
 =?us-ascii?Q?J6i0lDuyT7yRc5aZfpsHJR2F1Gvpz7L96HjmuEL2zF6hdYibUiZPESlsFdSw?=
 =?us-ascii?Q?x/p96D7K34L3hqmo8LGKLDrxLMYnHBETOLWWa6di3CawbVr/NXSfWiyCbaCf?=
 =?us-ascii?Q?Xy6DOzkBhgARffTuZ9DE637Ac+BJbXUpwvpLc8X1OpucaLmq2ucRY18dW8j5?=
 =?us-ascii?Q?VJ2g46jWqZkcq/UzYeyti9Qsm0m4FNv5tHsyuodtO/xih+1tpscU4GaY6g67?=
 =?us-ascii?Q?BP53bSwY5k5GkRVgnPDgmOzwOmL5SC78/k6GiElfgT7gEWnrK5NzK1+dxfg0?=
 =?us-ascii?Q?OaBiAZpHspj89ftyh21AGjFUYDNn0XMonR1n4n8nhqmQwoCoCY6iZWEWDhGW?=
 =?us-ascii?Q?S1UEEoyXdivfLJKMSs96VZJUkhNaQxbPb+UUR6lIBW3w0KwW9hVJi+AukccB?=
 =?us-ascii?Q?eROQxgaeJWZaEt7d80y/RLtxcHhAJT1/cyNmLcPZcQkRFiDpwdUJLUM9h0jy?=
 =?us-ascii?Q?/DvseBJVyTqLZZraEDtgVZ1OklIUrtJ3tgAXEF/6Um7iE/U2p3rjEeVNTKiq?=
 =?us-ascii?Q?tacFw1i9W3Bna5AVF9u+WaInf72Zzsks1oOvdxoT9rNvBLtlqasDd0ZMHY/V?=
 =?us-ascii?Q?MCwOn53Km53GTTuLLAWu//gmtImdbK7rf3DWWKx/TZ+EpicpJ//G6NV++OyS?=
 =?us-ascii?Q?CFTGIBOBAJfM4qyO/8kgSR0uIbMyFmazrIS6+BdbYG0RRgKEVswauV4VkxQX?=
 =?us-ascii?Q?fRBuw5kr+Yo3ryQ9SkDzFO/ofc2c3GJxn+uzhZ6iJpRZ/wr02GocmMq9eL1e?=
 =?us-ascii?Q?dELpDcifBqCR1TiXOGvnW6UUKyVcKY2TPe6xvHkedVa2n4BpNzjETTIPmip/?=
 =?us-ascii?Q?q6AncaZ3qigHDz4boJcF1TPuJZqA62EkG68j5kLpBhji+IXYeRKWQEDsj8py?=
 =?us-ascii?Q?CKfsN8JrG5rzwmcDCbT62EkmhuF2JgGJB6eP2OCSKnztOVi/mALxlmenJq0R?=
 =?us-ascii?Q?IQaL+VT2uDe7VRP+vmjy149yjXzskrTIDB4PshQvi23isq+1N9WmVaMJlcxg?=
 =?us-ascii?Q?yi3e9iUaUFnDHNtBwQV8p9hMG+X4m6L2+9KvHSHJ3rRVcxnxZrJlcNypY/Xa?=
 =?us-ascii?Q?o5jYJBoIrXNLpE+WFSRZ4yQzF0COySXJAN1f4hk92gRq6xJwCoNJN4SwuNt7?=
 =?us-ascii?Q?MZlpqL5By/tKEDV+s+1GidlGq30bVO4oErxXWGzpU3SeT1A3krKsxWp7h6Sg?=
 =?us-ascii?Q?VkRDuzxQu33q/s42MBk5ZMkp2s4qcp3B5sdpNIihwv/rmrYC/iCTLtXL9vaw?=
 =?us-ascii?Q?mpxfTsq+OSr5rJwi/OZd+5CftnAnnkUQLWAPjqotD5ibyPDW05kHySldrK0Z?=
 =?us-ascii?Q?QO5ggztHIiPQmT+jGUOXlFA5WSUHGx8aXCSNmerXa1m8oLV/G9Sw5Y4Wc/bi?=
 =?us-ascii?Q?A9WhiAkEnKQedL0GMAv5rVRU3+BKDHoquQOmqHnu6xQowenL+3Ac29Iu69Q7?=
 =?us-ascii?Q?KDfkQHEeFah8yzzhDc3IEfSOgWrgpKalfPaQjelRn1sEbzpOd2icKhInT9Jp?=
 =?us-ascii?Q?v5wljiWThJZc7xGpAFILSIoa3Ri6SouLsvx9WniJdIdSya6ESPyjrofU5A2+?=
 =?us-ascii?Q?eCg2FGPekFSFFYEtgbTJenM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf27f6a-26b4-4c34-f65d-08daee01f01a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 03:15:31.6867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2It928+yrWn1L7BtBePmHVImrVsaBJuAgUuS4eO5Ogot4HO3SJXt34ozT0GmNYqg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932
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

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Wednesday, January 4, 2023 12:25 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: allow query error counters for specific IP b=
lock
>=20
> amdgpu_ras_block_late_init will be invoked in IP specific ras_late_init c=
all as a
> common helper for all the IP blocks.
>=20
> However, when amdgpu_ras_block_late_init call
> amdgpu_ras_query_error_count to query ras error counters,
> amdgpu_ras_query_error_count queries all the IP blocks that support ras q=
uery
> interface.
>=20
> This results to wrong error counters cached in software copies when there=
 are
> ras errors detected at time zero or warm reset procedure. i.e., in
> sdma_ras_late_init phase, it counts on sdma/mmhub errors, while, in
> mmhub_ras_late_init phase, it still counts on sdma/mmhub errors.
>=20
> The change updates amdgpu_ras_query_error_count interface to allow query
> specific ip error counter.
> It introduces a new input parameter: query_info. if query_info is NULL,  =
it means
> query all the IP blocks, otherwise, only query the ip block specified by =
query_info.
>=20
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 89 +++++++++++++++++++------
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 +-
>  2 files changed, 71 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 35b9f2ed2838..7fed63dc09bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1130,11 +1130,54 @@ int amdgpu_ras_error_inject(struct amdgpu_device
> *adev,  }
>=20
>  /**
> - * amdgpu_ras_query_error_count -- Get error counts of all IPs
> + * amdgpu_ras_query_error_count_helper -- Get error counter for
> +specific IP
> + * @adev: pointer to AMD GPU device
> + * @ce_count: pointer to an integer to be set to the count of correctibl=
e errors.
> + * @ue_count: pointer to an integer to be set to the count of uncorrecti=
ble
> errors.
> + * @query_info: pointer to ras_query_if
> + *
> + * Return 0 for query success or do nothing, otherwise return an error
> + * on failures
> + */
> +static int amdgpu_ras_query_error_count_helper(struct amdgpu_device *ade=
v,
> +					       unsigned long *ce_count,
> +					       unsigned long *ue_count,
> +					       struct ras_query_if *query_info) {
> +	int ret;
> +
> +	if (!query_info)
> +		/* do nothing if query_info is not specified */
> +		return 0;
> +
> +	ret =3D amdgpu_ras_query_error_status(adev, query_info);
> +	if (ret)
> +		return ret;
> +
> +	*ce_count +=3D query_info->ce_count;
> +	*ue_count +=3D query_info->ue_count;
> +
> +	/* some hardware/IP supports read to clear
> +	 * no need to explictly reset the err status after the query call */
> +	if (adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 2) &&
> +	    adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 4)) {
> +		if (amdgpu_ras_reset_error_status(adev, query_info-
> >head.block))
> +			dev_warn(adev->dev,
> +				 "Failed to reset error counter and error
> status\n");
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_ras_query_error_count -- Get error counts of all IPs or
> +specific IP
>   * @adev: pointer to AMD GPU device
>   * @ce_count: pointer to an integer to be set to the count of correctibl=
e errors.
>   * @ue_count: pointer to an integer to be set to the count of uncorrecti=
ble
>   * errors.
> + * @query_info: pointer to ras_query_if if the query request is only
> + for
> + * specific ip block; if info is NULL, then the qurey request is for
> + * all the ip blocks that support query ras error counters/status
>   *
>   * If set, @ce_count or @ue_count, count and return the corresponding
>   * error counts in those integer pointers. Return 0 if the device @@ -11=
42,11
> +1185,13 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
>   */
>  int amdgpu_ras_query_error_count(struct amdgpu_device *adev,
>  				 unsigned long *ce_count,
> -				 unsigned long *ue_count)
> +				 unsigned long *ue_count,
> +				 struct ras_query_if *query_info)
>  {
>  	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>  	struct ras_manager *obj;
>  	unsigned long ce, ue;
> +	int ret;
>=20
>  	if (!adev->ras_enabled || !con)
>  		return -EOPNOTSUPP;
> @@ -1158,26 +1203,23 @@ int amdgpu_ras_query_error_count(struct
> amdgpu_device *adev,
>=20
>  	ce =3D 0;
>  	ue =3D 0;
> -	list_for_each_entry(obj, &con->head, node) {
> -		struct ras_query_if info =3D {
> -			.head =3D obj->head,
> -		};
> -		int res;
> -
> -		res =3D amdgpu_ras_query_error_status(adev, &info);
> -		if (res)
> -			return res;
> +	if (!query_info) {
> +		/* query all the ip blocks that support ras query interface */
> +		list_for_each_entry(obj, &con->head, node) {
> +			struct ras_query_if info =3D {
> +				.head =3D obj->head,
> +			};
>=20
> -		if (adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 2)
> &&
> -		    adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 4)) {
> -			if (amdgpu_ras_reset_error_status(adev,
> info.head.block))
> -				dev_warn(adev->dev, "Failed to reset error
> counter and error status");
> +			ret =3D amdgpu_ras_query_error_count_helper(adev, &ce,
> &ue, &info);
>  		}
> -
> -		ce +=3D info.ce_count;
> -		ue +=3D info.ue_count;
> +	} else {
> +		/* query specific ip block */
> +		ret =3D amdgpu_ras_query_error_count_helper(adev, &ce, &ue,
> +query_info);
>  	}
>=20
> +	if (ret)
> +		return ret;
> +
>  	if (ce_count)
>  		*ce_count =3D ce;
>=20
> @@ -2408,7 +2450,7 @@ static void amdgpu_ras_counte_dw(struct
> work_struct *work)
>=20
>  	/* Cache new values.
>  	 */
> -	if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count) =3D=3D 0)
> {
> +	if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count, NULL)
> =3D=3D
> +0) {
>  		atomic_set(&con->ras_ce_count, ce_count);
>  		atomic_set(&con->ras_ue_count, ue_count);
>  	}
> @@ -2589,6 +2631,7 @@ int amdgpu_ras_block_late_init(struct
> amdgpu_device *adev,  {
>  	struct amdgpu_ras_block_object *ras_obj =3D NULL;
>  	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +	struct ras_query_if *query_info;
>  	unsigned long ue_count, ce_count;
>  	int r;
>=20
> @@ -2630,11 +2673,17 @@ int amdgpu_ras_block_late_init(struct
> amdgpu_device *adev,
>=20
>  	/* Those are the cached values at init.
>  	 */
> -	if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count) =3D=3D 0)
> {
> +	query_info =3D kzalloc(sizeof(struct ras_query_if), GFP_KERNEL);
> +	if (!query_info)
> +		return -ENOMEM;
> +	memcpy(&query_info->head, ras_block, sizeof(struct ras_common_if));
> +
> +	if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count,
> +query_info) =3D=3D 0) {
>  		atomic_set(&con->ras_ce_count, ce_count);
>  		atomic_set(&con->ras_ue_count, ue_count);
>  	}
>=20
> +	kfree(query_info);
>  	return 0;
>=20
>  interrupt:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index bf5a95104ec1..f2ad999993f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -540,7 +540,8 @@ void amdgpu_ras_suspend(struct amdgpu_device
> *adev);
>=20
>  int amdgpu_ras_query_error_count(struct amdgpu_device *adev,
>  				 unsigned long *ce_count,
> -				 unsigned long *ue_count);
> +				 unsigned long *ue_count,
> +				 struct ras_query_if *query_info);
>=20
>  /* error handling functions */
>  int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
> --
> 2.17.1
