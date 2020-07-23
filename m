Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578CCC433F2
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 03:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277AF207E8
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 03:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hjSl2BeN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277AF207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C653C6E2AF;
	Thu, 23 Jul 2020 03:40:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFAE6E2AF
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 03:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhEmjMuHuh/7YXjQg+DCk8M3/VQvOvi88zTt10XEtkYB7R8jf5S9rZyzkjqiLRR0RajG6QkZw7sHa4lK2RrGGDE9ZMdegaKHQq7y1DuVHiJe/95QdC9L2TexlOi7nf0CRhH0mJ+u4BE2sfI1yZGHA8wdCR3yc1m8NLKBVkg9XDiE+/HWIOmslOTuuOc9eqopi8Op7jA8Ev/V8o+kirJkQQ8FC6nD2y5/fGa/MDCXOP9w6GTIG8Tpsfae3pqPGg//a5w3xDxNoJRzTEY9Cb5Oo01XQMha1H/4iRm5V0GTrxeLu6mtr6tRv7pi3mMZr5nWIrTTTdZGIzQC1Iwf5bIl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTudnDLPmsA1wGpVxr5ICY5rTUMKlFoTBf8fhTIErso=;
 b=JR1iDGqtuc3WtkiLy2pzrcW6i/z+viN5XlaeWDHSpfhPavVRlp6NP2KoxmFl9omflzLnG0io4ISxtsjQNMFbXa21mGw3nDybGm9pZiza3mYJRora5fPV4oxK4BidjlAI7ipr7Tc1RISwoLexuPQxokcs9Bz5uELHh9rXG4+c1b5U2O4abi00c0LWT0bEZnQG7KT9+FPVjZmiImxJeqWAlbs3od/AuXWY7GYGVdsByjYKYgIhd+LilqgF4T75IIhlyN96qXw9raYn7SU9/VljV265OTlx5b/EAWndvUYlFDb64uAoDwQRmqIngTJfNaWumZ3JQbMtEGKipVoMNENgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTudnDLPmsA1wGpVxr5ICY5rTUMKlFoTBf8fhTIErso=;
 b=hjSl2BeNFjbmVPXRcCXLba2wTe+Xp1fzn4XRZ8uNvFD4BE5nIj1hxs6Fm54JATu/2wZqZ6TgaJ+PlUQpoOfLFKnrKwRPEKwK29dab6Jy2FWpRPBXDrVrrK51jx32Heui43lUAnD8NS4JoOnXcKQ16CidztjOacEg6NbGMp4QXl4=
Received: from BN6PR12MB1283.namprd12.prod.outlook.com (2603:10b6:404:19::8)
 by BN6PR12MB1220.namprd12.prod.outlook.com (2603:10b6:404:1e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Thu, 23 Jul
 2020 03:40:37 +0000
Received: from BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::48d8:4df2:bfa0:907f]) by BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::48d8:4df2:bfa0:907f%8]) with mapi id 15.20.3216.020; Thu, 23 Jul 2020
 03:40:37 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements,
 John" <John.Clements@amd.com>
Subject: RE: [PATCH 2/5] drm/amdgpu: validate bad page threshold in ras
Thread-Topic: [PATCH 2/5] drm/amdgpu: validate bad page threshold in ras
Thread-Index: AQHWX9ZBKLoKXU4utEqCnco1Xi462akTOkOAgAFLryA=
Date: Thu, 23 Jul 2020 03:40:36 +0000
Message-ID: <BN6PR12MB12830180010D157F2D2AFB86F1760@BN6PR12MB1283.namprd12.prod.outlook.com>
References: <20200722031415.4792-1-guchun.chen@amd.com>
 <20200722031415.4792-3-guchun.chen@amd.com>
 <CY4PR12MB138209600B8C712A077476449A790@CY4PR12MB1382.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB138209600B8C712A077476449A790@CY4PR12MB1382.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-23T03:39:26Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c960a505-52fd-4917-8110-00007f2d9d95;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-23T03:40:34Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 90f789a8-9dd0-421b-a1b1-0000d4bc81ab
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aa96025d-8b29-4862-3d0f-08d82eba29a4
x-ms-traffictypediagnostic: BN6PR12MB1220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB12203DB8DBFC639C6AC7F4B6F1760@BN6PR12MB1220.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6FTBvkXQt9E00E7Ul2toAopvgl6gPpL9uuJtUuDn8B1Def+zx8VbTFA25aNjzWRjhLEKYjQPUz5BP25KPTs17eVYa8ng/Ma/oalnkH2kOLX2FROos8/ThF/X08IvszSwnUhJ6hsa0kyB2K5mNggKDiuwj82iRUAad7iXJ5jmGjvBQ7DLNUVGxXUX6vBrtIysyAFzfU8fQjXdGBHEmpfp9i5JMbxSzC4NAxbrx8vVyWwRg3wdKtvoRFF5l1rvNV0yIKvhMzpRSguO5DWan3y7/8wslNCM6Lqwthvp3Kk0FUdy8S7xsIew8hkbsiqcVPTyQWhd0k8c59HKSchuAC4C9XglxqmRf8OKNH+gypc6rTeUYNghJYJ7NnVwmVw0wK7H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(26005)(66946007)(66556008)(66476007)(186003)(15650500001)(8676002)(6506007)(86362001)(53546011)(478600001)(76116006)(110136005)(9686003)(316002)(55016002)(6636002)(33656002)(2906002)(7696005)(8936002)(66446008)(64756008)(83380400001)(52536014)(5660300002)(71200400001)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 4modd4i8C57B5/y412mv8gmNvfRLwwu1Xu8+HvG/23IzN04v5ufBwWSZGGuQE1XkBfbJosthFR8Q2qGjIhR3yKt/2JKWvmpDXxDHM9087yuot9yA76X13Pg5vgmdiYT1d1v7ENdwpZtST7OqfCTDnN3mQ3JDDeEkjg8JRuNslS4BX10Z9RG4DhVPAQyqH4n5CRLDxOsEU8f06T+A0WGhYd9SxN1iQCTjV0WE8pkyv9d9GK6niKwzb3h1v1uru8FQr8sBIoQdAUH08m6xgf+4EGIq8lBnmLkGE2bGHMQYdk3zASTfV7a2Ywc6eTdLKIOeZWAHbC4x9Vu07SfZpGRr/H2KfD4DNRpkS1g3QAcynxkPrlp3yDtWmg+SaltE1AxZl9qQgIxypIt6U3Kt7pejRIJ19yXLCMrZjBYyVwkBqvQOwX+s/PUa51dhDqZOBrKm5cMXA4o/xsUGzM6s6gYHUf/AE3GXkcqTVDTah+Q9qoZE/gUwlNIk6MJXgqs4R4Le
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa96025d-8b29-4862-3d0f-08d82eba29a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 03:40:36.8680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EW83xLA9k9I9Xk27Dqrd16RhhfUNMzdpDWZlwbjLBRMvgILfLFzu8+dpZONCGfdNI2Y/3vcXs8Ao50Q4t1mnxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1220
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

[AMD Public Use]

Thanks for review, Stanley.

Re: [Yang, Stanley] : It's better to compare con->bad_page_cnt_threshold with max_length, the value of bad_page_cnt_threshold should not exceed max_length.

Correct, one guard is necessary. It will be patch v2.

Regards,
Guchun

-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com> 
Sent: Wednesday, July 22, 2020 3:52 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH 2/5] drm/amdgpu: validate bad page threshold in ras

[AMD Official Use Only - Internal Distribution Only]

Hi Guchun,

Please see my comment inline.

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Wednesday, July 22, 2020 11:14 AM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; 
> Li, Dennis <Dennis.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; 
> Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
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
[Yang, Stanley] : It's better to compare con->bad_page_cnt_threshold with max_length, the value of bad_page_cnt_threshold should not exceed max_length.

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
> amdgpu_ras_eeprom_test(struct amdgpu_ras_eeprom_control *control) diff 
> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
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
