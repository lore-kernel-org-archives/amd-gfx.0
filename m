Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392BDC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 07:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066EF20729
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 07:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qy7NJFi8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066EF20729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9DD789F5B;
	Wed, 22 Jul 2020 07:51:57 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750040.outbound.protection.outlook.com [40.107.75.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F82989F5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 07:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZgU04mxyj0R52C3HQ9UvLjSOBLHgNmTig22UtPvW9wp515Mw7B4P4H3QNakB/qsjuEZKJBD+42t36N9Ljnx3HidqS7rbP3rvZA5lUBa7mVw9Q1+aROqb65oQAf5WHU6zZWqPQkZyjy9cqAIp2knEWLjGHSXkw7DK85jyGoKfRvgVm/Yjn25Kqfn0fZqRB6EfmPsfWFEdw62HzPqo+LrpMlmvvxsfTNDhzpBFZsbQ2BkLWGGfM8v0liARHY516/3hNK4CDCSceNvVZ6PwCm5l+3Gld83D9ozcmF4o4VtT+v60LTmNkuvQZebis0j4VL1XoQIVm/OOKvYgLu2SwS4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MER7B82Xeqc/SGc+GY/ZxKhH4pCBGWz3Z4csY1TQusY=;
 b=VdxTUDVTMdrNBQpPqhxm/oH7l0zptR+f/NORL6Xy/hYpiCjw6xhoTkWGFPR3Ma5oQbnip3eBOWPIZ9DPeDMU8f0xSWxucFLacq53x+1JMhy5OwXrFo8cQ9Am7ZQfv6MKs+h+5r6MpZeZMQ7Kg+ThsO2lC1wmv5mkqny3bBM226Ej3MZAb8ldJP7qVVRk5aBGVP2za7HLN+jJun/n56x1FrI+YAjv0EvU4tOc6XV6vvUAO/Hi1yft/Q6HYGrlRpc9tMz4Ij7nOcxxO0lsRHLacT8fZC81gT+BNwy9H5GSYXyUk1xbkIJpNCAKsC29mNXRnEnwTFABtwssEjaeEJ407g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MER7B82Xeqc/SGc+GY/ZxKhH4pCBGWz3Z4csY1TQusY=;
 b=Qy7NJFi8kodfAUE5dmrgq/Fz7WQCl69N69MpTJw+fMe21CD23rq7nX9gHi5cOtaNeZSUSW7rOo18BYvyR1/hBDo18FKeJ02Xml722ISxinMvRYnPNjD7yoiLdAu3NvpKStqNo8x3RpLhVJEiJPMobb+p+Jwp6aYyy15oM0ULQ7s=
Received: from CY4PR12MB1382.namprd12.prod.outlook.com (2603:10b6:903:40::18)
 by CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Wed, 22 Jul
 2020 07:51:55 +0000
Received: from CY4PR12MB1382.namprd12.prod.outlook.com
 ([fe80::9be:69c:97ab:d68]) by CY4PR12MB1382.namprd12.prod.outlook.com
 ([fe80::9be:69c:97ab:d68%10]) with mapi id 15.20.3216.020; Wed, 22 Jul 2020
 07:51:55 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements,
 John" <John.Clements@amd.com>
Subject: RE: [PATCH 2/5] drm/amdgpu: validate bad page threshold in ras
Thread-Topic: [PATCH 2/5] drm/amdgpu: validate bad page threshold in ras
Thread-Index: AQHWX9ZCWX1LWEnS9UqpXFt0JMaF9KkTK/JA
Date: Wed, 22 Jul 2020 07:51:55 +0000
Message-ID: <CY4PR12MB138209600B8C712A077476449A790@CY4PR12MB1382.namprd12.prod.outlook.com>
References: <20200722031415.4792-1-guchun.chen@amd.com>
 <20200722031415.4792-3-guchun.chen@amd.com>
In-Reply-To: <20200722031415.4792-3-guchun.chen@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-22T07:47:58Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d235e06d-7873-4982-9e58-0000b08a613d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-22T07:50:39Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e9343ce4-6a5f-481f-a41b-0000db6c60c2
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: [AMD Official Use Only - Internal Distribution Only]
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88f1ce7f-e70f-4246-cfb4-08d82e141ab3
x-ms-traffictypediagnostic: CY4PR12MB1845:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1845131DB220D3FAA5C88A309A790@CY4PR12MB1845.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rt1d3qcl9MkS7Y90IvCmxA7uC7BcKwE2018QK48QB+ipD0t0iuUQmINMTfxh9OYS/PJYiXMY5V56jiGBIlTGHVcarktTfL3epn4IlAVbIEp7go6ZgZz0UEtODeu4i62mJKboyqtjl+GA5poUmsPwL6RwFNuHpHVUd9Jf9J80aLlRqVtrjMd+3xM/CN0MxMcCJ/u4WBPctu3oRQPDoUM7LI5XVq791/1snIcOkU3G+Rorio31G9iuMfZqHT101PoG4I7BMiU3Yi12rZtu/dMEZtXhRUHAgldqjEh+vx2fuAq9M7jNK9+ylwD0wan8o4dfhlzwXodsruhCrhwQk2tyQgE+fE5GkW+D6F4CMvVw/tofMsbNqX2Eq4iZRKzvWUzr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1382.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(316002)(110136005)(53546011)(7696005)(6506007)(6636002)(76116006)(64756008)(66476007)(66446008)(66556008)(66946007)(86362001)(26005)(186003)(15650500001)(52536014)(5660300002)(8676002)(83380400001)(8936002)(478600001)(55016002)(9686003)(2906002)(71200400001)(33656002)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 2au9frUVvibRbFF8t6Yi+c5hhYdgN97iStIRFgxXNt9BE/mIjeLfz5WNQ9tBEg8yuvTKB4dfMX80ih18LHsjtgArV139j3N05il51hQZMzI8QvaTh2m9vGun6udQtHMqisQ9RPoHn1HLz522r38xdkncinT836ja5nTnmpNwFGqvTkQbKM/+pHKTHtTlEDGG8nPIK7s6EynZa1Q9bDjyJjogkuaF5ONm55hPNdub657yJ1mvz44Ov3uE1KqXmz5ktJiSelHx6g57TOk39okNsYHrX6eEpcojn24UyKdi+WbQYdffpw9yH3Oi5U659D18lHiYqKNPUuAMj4PR6V3BlkA2z8a1ouGkLbMLge6pt7dXyCTqucG3qUrjzea4JDa/xi4FY5H8bHvobI/c6O7K4vIlOCyb1UaH3gxCzJpl327gBQSRvV99Nb72ZWAWsWh9UTOYP9gUIO0tEXrKosnz5iRNQCOqySUhUQNTJItlyNadSN3V/AIWDb+iAS81p4V+
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1382.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f1ce7f-e70f-4246-cfb4-08d82e141ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 07:51:55.3711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POkkekqIB6gprnpRYbkdzpIdUNstDwYOP8eYvEoA/7xpjQ0AJII0+mBuOolPJMg02s1/dlqiCsKQL36TMQzTaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1845
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Guchun,

Please see my comment inline.

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Wednesday, July 22, 2020 11:14 AM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;
> Clements, John <John.Clements@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH 2/5] drm/amdgpu: validate bad page threshold in ras
> 
> Bad page threshold value should be valid in the range between
> -1 and max records length of eeprom. It could determine when the GPU
> should be retired.
> 
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 43
> +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  3 ++
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  5 +++
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 +
>  4 files changed, 53 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 6f06e1214622..e3d67d85c55f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -69,6 +69,9 @@ const char *ras_block_string[] = {
>  /* inject address is 52 bits */
>  #define	RAS_UMC_INJECT_ADDR_LIMIT	(0x1ULL << 52)
> 
> +/* typical ECC bad page rate(1 bad page per 100MB VRAM) */
> +#define RAS_BAD_PAGE_RATE		(100 * 1024 * 1024ULL)
> +
>  enum amdgpu_ras_retire_page_reservation {
>  	AMDGPU_RAS_RETIRE_PAGE_RESERVED,
>  	AMDGPU_RAS_RETIRE_PAGE_PENDING,
> @@ -1700,6 +1703,42 @@ static bool amdgpu_ras_check_bad_page(struct
> amdgpu_device *adev,
>  	return ret;
>  }
> 
> +static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
> +					uint32_t max_length)
> +{
> +	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +	int tmp_threshold = amdgpu_bad_page_threshold;
> +	u64 val;
> +
> +	/*
> +	 * Justification of value bad_page_cnt_threshold in ras structure
> +	 *
> +	 * 1. -1 <= amdgpu_bad_page_threshold <= max record length in
> eeprom
> +	 * 2. if amdgpu_bad_page_threshold = -1,
> +	 *    bad_page_cnt_threshold = typical value by formula.
> +	 * 3. if amdgpu_bad_page_threshold = 0,
> +	 *    bad_page_cnt_threshold = 0xFFFFFFFF,
> +	 *    and disable RMA feature accordingly.
> +	 * 4. use the value specified from user when
> (amdgpu_bad_page_threshold
> +	 *    > 0 && < max record length in eeprom).
> +	 */
> +
> +	if (tmp_threshold < -1)
> +		tmp_threshold = -1;
> +	else if (tmp_threshold > max_length)
> +		tmp_threshold = max_length;
> +
> +	if (tmp_threshold == -1) {
> +		val = adev->gmc.mc_vram_size;
> +		do_div(val, RAS_BAD_PAGE_RATE);
> +		con->bad_page_cnt_threshold = lower_32_bits(val);
[Yang, Stanley] : It's better to compare con->bad_page_cnt_threshold with max_length,
the value of bad_page_cnt_threshold should not exceed max_length.

> +	} else if (tmp_threshold == 0) {
> +		con->bad_page_cnt_threshold = 0xFFFFFFFF;
> +	} else {
> +		con->bad_page_cnt_threshold = tmp_threshold;
> +	}
> +}
> +
>  /* called in gpu recovery/init */
>  int amdgpu_ras_reserve_bad_pages(struct amdgpu_device *adev)  { @@ -
> 1777,6 +1816,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device
> *adev)  {
>  	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>  	struct ras_err_handler_data **data;
> +	uint32_t max_eeprom_records_len = 0;
>  	int ret;
> 
>  	if (con)
> @@ -1795,6 +1835,9 @@ int amdgpu_ras_recovery_init(struct
> amdgpu_device *adev)
>  	atomic_set(&con->in_recovery, 0);
>  	con->adev = adev;
> 
> +	max_eeprom_records_len =
> amdgpu_ras_eeprom_get_record_max_length();
> +	amdgpu_ras_validate_threshold(adev, max_eeprom_records_len);
> +
>  	ret = amdgpu_ras_eeprom_init(&con->eeprom_control);
>  	if (ret)
>  		goto free;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index b2667342cf67..4672649a9293 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -336,6 +336,9 @@ struct amdgpu_ras {
>  	struct amdgpu_ras_eeprom_control eeprom_control;
> 
>  	bool error_query_ready;
> +
> +	/* bad page count threshold */
> +	uint32_t bad_page_cnt_threshold;
>  };
> 
>  struct ras_fs_data {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index c0096097bbcf..a2c982b1eac6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -499,6 +499,11 @@ int amdgpu_ras_eeprom_process_recods(struct
> amdgpu_ras_eeprom_control *control,
>  	return ret == num ? 0 : -EIO;
>  }
> 
> +inline uint32_t amdgpu_ras_eeprom_get_record_max_length(void)
> +{
> +	return EEPROM_MAX_RECORD_NUM;
> +}
> +
>  /* Used for testing if bugs encountered */  #if 0  void
> amdgpu_ras_eeprom_test(struct amdgpu_ras_eeprom_control *control)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 7e8647a05df7..b272840cb069 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -85,6 +85,8 @@ int amdgpu_ras_eeprom_process_recods(struct
> amdgpu_ras_eeprom_control *control,
>  					    bool write,
>  					    int num);
> 
> +inline uint32_t amdgpu_ras_eeprom_get_record_max_length(void);
> +
>  void amdgpu_ras_eeprom_test(struct amdgpu_ras_eeprom_control
> *control);
> 
>  #endif // _AMDGPU_RAS_EEPROM_H
> --
> 2.17.1

Regards,
Stanley
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
